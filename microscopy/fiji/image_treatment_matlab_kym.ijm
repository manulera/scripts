dir = getDirectory("image");
movie = getTitle();
do_treatment=true;

//dotIndex = indexOf(movie, "."); 
//movie_name = substring(movie, 0, dotIndex-1); 
movie_name = "movie";

open(dir+File.separator+"mask.tif");
mask = getTitle();
run("Invert");
run("Create Selection");
close();
selectWindow(movie);
run("Restore Selection");
if (do_treatment)
{
	run("Bleach Correction", "correction=[Exponential Fit]");
}

run("Select None");
saveAs("Tiff", dir+File.separator+movie_name+"_bleach_corrected.tif");

bleach_corrected = getTitle();


run("Duplicate...", "duplicate");
run("Gaussian Blur...", "sigma=2 stack");
saveAs("Tiff", dir+File.separator+movie_name+"_bleach_corrected_gauss2.tif");
close();

selectWindow(bleach_corrected);
run("Gaussian Blur...", "sigma=1 stack");
saveAs("Tiff", dir+File.separator+movie_name+"_bleach_corrected_gauss1.tif");

if (do_treatment)
{
	close();
	close();
}
close("Log");