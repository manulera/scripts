dir = getDirectory("image");
Stack.getPosition(channel, slice, frame);
print(frame);
run("Duplicate...", "duplicate range=1-"+frame);
selectWindow("movie.tif");
close();
selectWindow("movie-1.tif");
saveAs("Tiff", dir+File.separator+"movie.tif");
runMacro("/Users/Manu/scripts/microscopy/fiji/image_treatment_matlab_kym.ijm")
