#!/usr/bin/env python

"""
Give .nd files as arguments, to get the metadata.
Specify the fiji bin and the fiji script as global variables fiji_bin and fiji_script
In mac it returns an error, but performs the task regardless
"""
import sys, os, subprocess

fiji_bin="/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx"
fiji_script="/Users/Manu/scripts/microscopy/fiji/metadata_csv.ijm"

def main(args):
    for a in args:
        if a[-3:]!=".nd":
            print(a+" is not an .nd file and was ignored")
            continue
        if not os.path.isfile(a):
            sys.stderr(a+ " does not exist")
        print("  --> "+ a)
        if not os.path.isfile(a[:-3]+"_metadata.csv"):
            try:
                subprocess.call([fiji_bin,"--ij2", "--console", "-macro", fiji_script, a])
            except:
                print(a+" gave an error and was skipped")
        else:
            print("metadata.csv found, and file skipped")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
    else:
        main(sys.argv[1:])
