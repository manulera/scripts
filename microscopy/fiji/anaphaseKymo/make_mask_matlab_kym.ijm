dir = getDirectory("image");
run("Create Mask");
run("Invert");

saveAs("Tiff", dir+File.separator+"mask.tif");
close();
runMacro("/Users/Manu/scripts/microscopy/fiji/image_treatment_matlab_kym.ijm");
