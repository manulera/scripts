#!/usr/bin/env python

"""
Give .nd files as arguments, to get the metadata.
Specify the fiji bin and the fiji script as global variables fiji_bin and fiji_script
In mac it returns an error, but performs the task regardless
"""
import sys, os, subprocess

fiji_bin="/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx"
fiji_script="/Users/Manu/scripts/microscopy/fiji/batch_weka.ijm"

def main(args):
    for a in args:
        if a[-5:]!=".tiff":
            print(a+" is not an .tiff file and was ignored")
            continue
        if not os.path.isfile(a):
            sys.stderr(a+ " does not exist")
        print("  --> "+ a)

        try:
            subprocess.call([fiji_bin,"--ij2", "--console", "-macro", fiji_script, os.path.abspath(a)])
        except:
            print(a+" gave an error and was skipped")



if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
    else:
        main(sys.argv[1:])
