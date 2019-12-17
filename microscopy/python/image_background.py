"""
Substract the background of images
"""

import numpy as np
import argparse

from scipy.stats import norm,gamma
import sys
from joblib import Parallel, delayed
from tifffile import imread

import matplotlib.pyplot as plt





def background_data(data,mask_image,fun):

    data = (data * mask_image).ravel()
    data = data[np.greater(data, 0)]
    # Fit a normal distribution to the data:
    # data = data-min(data)
    # pars = fun.fit(data,0.01,loc=-1.5,scale=10)
    if mode=="gamma":
        pars = fun.fit(data, 3.6, loc=89, scale=18)
    elif mode=="normal":
        pars = fun.fit(data)
    my_fun = fun(*pars)

    return my_fun.mean(),np.mean(data)


def main(p):
    for f in p:


        if f[-4:]!=".tif":
            print f, "is not a tif image"
            continue

        ima = np.array(imread(f))
        print ima.shape
        if mask:
            mask_image = np.logical_not(np.array(imread(mask)))
        else:
            mask_image = 1

        if mode == "normal":
            fun = norm
        elif mode == "gamma":
            fun = gamma
        else:
            sys.stderr("Only accepted modes are 'normal' and 'gamma'")


        backgrounds = Parallel(n_jobs=nb_jobs, verbose=1)(delayed(background_data)(ima[t,:,:],mask_image,fun) for t in range(ima.shape[0]))

        for b in backgrounds:
            print b


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description=__doc__)

    nb_jobs = 20
    mode = "normal"
    mask =False

    parser.add_argument('--nb_jobs', type=int)
    parser.add_argument('--mode', type=str)
    parser.add_argument('--mask', type=str)

    args, unknown = parser.parse_known_args()

    if args.nb_jobs is not None:
        nb_jobs = args.nb_jobs
    if args.mode is not None:
        mode = args.mode
    if args.mask is not None:
        mask = args.mask


    if len(unknown) == 0 or unknown[0] == 'help':
        parser.print_help()
    else:
        main(unknown)
