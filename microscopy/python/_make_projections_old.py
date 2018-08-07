import sys
import re
import os
import numpy as np
import javabridge
import bioformats
from tifffile import imsave


def get_microsc_files(path):
    all_files = os.listdir(path)
    pat = re.compile(".*_w(\d)(\d).*_s(\d*)_t(\d*)\.TIF")

    # The groups are: 0 all, 1 the current wavelength, 2 the total number of wavelength, 3 the stage position, 4 the time
    microsc_files = list()
    microsc_info = list()

    for f in all_files:
        m = pat.match(f)
        if m is not None:
            microsc_files.append(f)
            microsc_info.append([m.group(1), m.group(3), m.group(4)])

    microsc_info = np.array(microsc_info, int)
    return microsc_info,microsc_files

def process(microsc_info,microsc_files,path=".",type_proj="max"):

    # This function is crazy verbose

    javabridge.start_vm(class_path=bioformats.JARS);

    size = np.max(microsc_info, 0)

    for stage in range(1,size[1]+1):
        log1 = np.equal(microsc_info[:, 1], stage)
        for wl in range(1, size[0]+1):
            log2 = np.equal(microsc_info[:, 0], wl)
            out = list()
            for t in range(1, size[2] + 1):

                log3 = np.equal(microsc_info[:, 2], t)
                log = np.logical_and(log1, log2)
                log = np.logical_and(log, log3)
                f = microsc_files[int(np.where(log)[0])]
                reader = bioformats.get_image_reader(1, path=os.path.join(path,f))

                if t == 1:
                    nb_stacks = 1
                    keep = True
                    while keep:
                        try:
                            reader.read(t=nb_stacks, rescale=False)
                            nb_stacks += 1
                        except:
                            keep = False
                    if nb_stacks == 1:
                        break

                stack = list()
                stack.append(reader.read(t=0, rescale=False))

                for z in range(1, nb_stacks):
                    stack.append(reader.read(t=z, rescale=False))

                stack = np.array(stack)
                if type_proj == "max":
                    out.append(np.max(stack, axis=0))
                elif type_proj == "mean":
                    out.append(np.mean(stack, axis=0))
                elif type_proj == "median":
                    out.append(np.median(stack, axis=0))
                elif type_proj == "sum":
                    out.append(np.sum(stack, axis=0) / nb_stacks)

            if nb_stacks > 1:
                out = np.array(out, dtype='uint16')
                imsave(os.path.join(path,"stage_" + str(stage) + "_wave_" + str(wl) +"_"+ type_proj +".tiff"), out)
    javabridge.kill_vm()

def main(args):
    paths = []
    for arg in args:
        if os.path.isdir(arg):
            paths.append(arg)
        else:
            sys.stderr.write("  Error: unexpected argument `%s'\n" % arg)
            sys.exit()

    if not paths:
        sys.stderr.write("  Error: you must specify directories\n")
        sys.exit()

    for p in paths:

        microsc_info, microsc_files = get_microsc_files(p)
        if not len(microsc_info):
            print "Nothing found in " + p
            continue

        dir = os.path.join(p,"projections")
        if not os.path.isdir(dir):
            os.mkdir(dir)
        # Ask for type of projection:
        proj = raw_input("What kind of projection do you want to make? (max,mean,median,sum):\n")
        if proj not in ["max","mean","median","sum"]:
            print proj + " is not a valid projection name"
            exit()
        process(microsc_info, microsc_files,dir,type_proj=proj)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        main(['.'])
    elif sys.argv[1] == 'help':
        print(__doc__)
    else:
        main(sys.argv[1:])