#!/usr/bin/env python

"""
Give the .tif file as argument,
Specify the fiji bin and the fiji script as global variables fiji_bin and fiji_script
In mac it returns an error, but performs the task regardless
"""
import sys, os, subprocess

fiji_bin="/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx"
fiji_script="/Users/Manu/scripts/microscopy/fiji/run_classifier.ijm"


def process(p):

    abs_path= os.path.abspath(p)
    # abs_dir = os.path.dirname(abs_path)
    # extra_dir = os.path.join(abs_dir,'extra')
    #
    # if not os.path.isdir(extra_dir):
    #     os.mkdir(extra_dir)

    subprocess.call([fiji_bin, "--ij2", "--console", "-macro", fiji_script, abs_path])



def main(args):

    for a in args:
        if a[-4:]!=".tif":
            print(a+" is not a .tif file and was ignored")
            continue
        if not os.path.isfile(a):
            sys.stderr(a+ " does not exist")
        print("  --> "+ a)

        process(a)

        # if not os.path.isdir()
        #
        # process(a)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
    else:
        main(sys.argv[1:])
