dir = getDirectory("image");
run("Create Mask");
run("Invert");
saveAs("Tiff", dir+File.separator+"cell_mask.tif");
close();