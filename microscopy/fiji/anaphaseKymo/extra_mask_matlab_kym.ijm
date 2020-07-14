dir = getDirectory("image");
run("Create Mask");
run("Invert");

saveAs("Tiff", dir+File.separator+"extra_mask.tif");
close();
