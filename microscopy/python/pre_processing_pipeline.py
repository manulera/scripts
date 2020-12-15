#!/usr/bin/env python

"""
Give the .nd file as argument. It will:

- make the max projection calling max_projections.py
- Call the run_classifier script.
- Call the get_drift script.
- Delete the projections.


Specify the fiji bin and the fiji script as global variables fiji_bin and fiji_script
In mac it returns an error, but performs the task regardless
"""

import sys, os, subprocess
from make_projections import main as make_projections
from run_classifier import main as run_classifier
from get_drift import main as get_drift
from pre_processing_settings import *

def classify_files(classifier,extension,projections_dir):

    classifier_arguments = [classifier]

    for file in os.listdir(projections_dir):
        # Ana: You specify here the channel used for segmentation (spindle)
        if file.endswith(extension):
            classifier_arguments.append(os.path.join(projections_dir, file))

    run_classifier(classifier_arguments)





def process(arg):

    path = os.path.dirname(os.path.realpath(arg))

    if os.path.isdir(os.path.join(path,"extra")):
        print "  Skipped, because it already has an extra directory"
        return

    make_projections([path],'max')

    projections_dir = os.path.join(path,'projections')



    classify_files(classifier_1,extension_classifier1,projections_dir)
    if classify_second:
        classify_files(classifier_2, extension_classifier2, projections_dir)


    # Get the drift

    files_4drift = list()

    for file in os.listdir(projections_dir):
        # Ana: You specify here the channel used for drift
        if file.endswith(extension_drift):
            files_4drift.append(os.path.join(projections_dir, file))

    get_drift(files_4drift)


    # Re-sort the files

    extra_dir = os.path.join(path,"extra")
    drift_dir = os.path.join(path,"drifts")

    if not os.path.isdir(extra_dir):
        os.mkdir(extra_dir)
    if not os.path.isdir(drift_dir):
        os.mkdir(drift_dir)

    for file in os.listdir(projections_dir):
        if file.endswith("extra.tif"):
            file1 = os.path.join(projections_dir, file)
            file2 = os.path.join(extra_dir, file)
            os.rename(file1,file2)

    for file in os.listdir(projections_dir):
        if file.endswith(".txt"):
            file1 = os.path.join(projections_dir, file)
            file2 = os.path.join(drift_dir, file)
            os.rename(file1,file2)


    return

def main(args):

    for a in args:
        if a[-3:]!=".nd":
            print(a+" is not a .nd file and was ignored")
            continue
        if not os.path.isfile(a):
            sys.stderr(a+ " does not exist")
        print("Processing  --> "+ a)
        process(a)








if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
    else:
        main(sys.argv[1:])
