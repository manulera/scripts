""" 
    Run in a directory where there are images acquired from metamorph and a single .nd file,
    it will create the projections of the microscopy images and save them as tif in a folder called
    "projections". Note that sum projection will make you lose information in the intensity, since the
    files are saved with the same bit depth as the source files.
"""
import sys
import re
import os
import numpy as np
from tifffile import imsave,imread


def get_microsc_files(path,nd_name=""):
    all_files = os.listdir(path)
    if nd_name:
        pat = re.compile(nd_name[:-3]+"_w(\d)(\d).*_s(\d*)_t(\d*)\.TIF")
    else:
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

def get_names_from_nd(path):
    all = os.listdir(path)
    all_nd = [i for i in all if i[-3:]==".nd"]

    out = list()
    if len(all_nd)<0:
        print "no nd files found"
        return out
    elif len(all_nd)>1:
        os.error("Several '.nd' files in the directory")

    # Open the file
    with open(os.path.join(path,all_nd[0])) as ins:
        for l in ins:
            ls = l.split(',')
            if len(ls) and '"Stage' in ls[0]:
                out.append(eval(ls[1].strip()))
    return out,all_nd[0]




def process(microsc_info,microsc_files,path=".",type_proj="max",names=[],nd_name=""):

    size = np.max(microsc_info, 0)
    for stage in range(1,size[1]+1):
        log1 = np.equal(microsc_info[:, 1], stage)
        for wl in range(1, size[0]+1):
            print "Doing position", stage,", channel ",wl
            log2 = np.equal(microsc_info[:, 0], wl)
            out = list()
            save_stack=True
            for t in range(1, size[2] + 1):

                log3 = np.equal(microsc_info[:, 2], t)
                log = np.logical_and(log1, log2)
                log = np.logical_and(log, log3)
                # If frame not found, copy the previous one
                if np.sum(log):
                    f = microsc_files[int(np.where(log)[0])]
                else:
                    # A bit sloppy but will work for most cases
                    f = f

                stack = imread(os.path.join(path,f))
                if len(stack.shape)==2:
                    # save_stack=False
                    # break
                    out.append(stack)
                    continue

                if type_proj == "max":
                    out.append(np.max(stack, axis=0))
                elif type_proj == "mean":
                    out.append(np.mean(stack, axis=0))
                elif type_proj == "median":
                    out.append(np.median(stack, axis=0))
                elif type_proj == "sum":
                    out.append(np.sum(stack, axis=0) / stack.shape[0])

            if save_stack:
                if len(names):
                    extra = names[stage-1]
                else:
                    extra = "stage_" + str(stage)
                out = np.array(out, dtype='uint16')
                imsave(os.path.join(path,"projections",nd_name+"_"+extra + "_wave_" + str(wl) +"_"+ type_proj +".tiff"), out)

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

        # Get the names of the positions and the name of the nd file
        names, nd_name = get_names_from_nd(p)

        microsc_info, microsc_files = get_microsc_files(p,nd_name)
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

        process(microsc_info, microsc_files,p,type_proj=proj,names=names,nd_name=nd_name[:-3])

if __name__ == "__main__":
    if len(sys.argv) < 2:
        main(['.'])
    elif sys.argv[1] == 'help':
        print(__doc__)
    else:
        main(sys.argv[1:])