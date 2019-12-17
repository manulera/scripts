import numpy as np


import sys

from tifffile import imread,imsave


def main(p):
    for f in p:

        if f[-4:]!=".tif":
            print f, "is not a tif image"
            continue

        ima = np.array(imread(f),dtype=int)

        print ima[0, :, :]
        for i in range(ima.shape[0]):

            ima[i,:,:] -= np.mean(ima[i,:,:],dtype=int)
        print ima[0,:,:]
        ima = ima.astype('int16')
        imsave(f[:-4]+"_mean_subs.tif",ima)

if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] == 'help':
        print(__doc__)
    else:
        main(sys.argv[1:])
