import re
import os
import numpy as np

all_files = os.listdir("../meiosistest2")
pat = re.compile(".*_w(\d)(\d).*_s(\d*)_t(\d*)\.TIF")

#The groups are: 0 all, 1 the current wavelength, 2 the total number of wavelength, 3 the stage position, 4 the time
microsc_files = list()
microsc_info = list()

for f in all_files:
    m = pat.match(f)
    if m is not None:
        microsc_files.append(f)
        microsc_info.append([m.group(1),m.group(3),m.group(4)])

microsc_info = np.array(microsc_info,int)
