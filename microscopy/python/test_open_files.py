import javabridge
import bioformats
import numpy as np
from find_paths import microsc_info,microsc_files
from tifffile import imsave
javabridge.start_vm(class_path=bioformats.JARS)

# reader = bioformats.get_image_reader(1,path="../meiosistest3/meiosistest3_w33-spinning1 mcherry_s21_t120.TIF")

size = np.max(microsc_info,0)

wl = 1
stage = 1

log2 = np.equal(microsc_info[:, 1], stage)

type_proj = "sum"

for wl in range(1,4):
    log1 = np.equal(microsc_info[:, 0], wl)
    out=list()
    for t in range(1,size[2]+1):

        log3 = np.equal(microsc_info[:, 2], t)
        log = np.logical_and(log1,log2)
        log = np.logical_and(log, log3)
        f = microsc_files[int(np.where(log)[0])]
        reader = bioformats.get_image_reader(1, path="../meiosistest3/" + f)

        if t == 1:
            nb_stacks = 1
            keep = True
            while keep:
                try:
                    reader.read(t=nb_stacks, rescale=False)
                    nb_stacks+=1
                except:
                    keep = False
            if nb_stacks ==1:
                break


        stack = list()
        stack.append(reader.read(t=0, rescale=False))

        for z in range(1,nb_stacks):
            stack.append(reader.read(t=z, rescale=False))

        stack = np.array(stack)
        if type_proj=="max":
            out.append(np.max(stack,axis=0))
        elif type_proj=="mean":
            out.append(np.mean(stack, axis=0))
        elif type_proj=="median":
            out.append(np.median(stack, axis=0))
        elif type_proj=="sum":
            out.append(np.sum(stack, axis=0)/nb_stacks)
        
    if nb_stacks>1:
        out = np.array(out,dtype='uint16')
        imsave("test_"+ str(wl)+".tiff",out)
        exit()




# while t<120:
#
#     b=a.read(t=t,rescale=False)
#     plt.hist(b.flat)
#     plt.show()
#     t+=1
javabridge.kill_vm()

