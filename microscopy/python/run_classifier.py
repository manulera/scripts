#!/usr/bin/env python

"""
Give the classifier as first argument, then list of .tifs
Specify the fiji bin and the fiji script as global variables fiji_bin and fiji_script
In mac it returns an error, but performs the task regardless
"""
import sys, os, subprocess

fiji_bin="/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx"
fiji_script="/Users/Manu/scripts/microscopy/fiji/run_classifier.ijm"


def process(p,classifier):

    abs_path= os.path.abspath(p)
    # abs_dir = os.path.dirname(abs_path)
    # extra_dir = os.path.join(abs_dir,'extra')
    #
    # if not os.path.isdir(extra_dir):
    #     os.mkdir(extra_dir)

    subprocess.call([fiji_bin, "--ij2", "--console", "-macro", fiji_script, classifier+","+abs_path])



def main(args):

    classifier = args[0]

    classifier_extension = os.path.splitext(classifier)[1]

    if classifier_extension!=".model":
        sys.stderr("The 1st argument is not a classifier")

    for a in args[1:]:
        if a[-4:]!=".tif":
            print(a+" is not a .tif file and was ignored")
            continue
        if not os.path.isfile(a):
            sys.stderr(a+ " does not exist")
        print("  --> "+ a)

        process(a,os.path.abspath(classifier))

        # if not os.path.isdir()
        #
        # process(a)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
    else:
        main(sys.argv[1:])
