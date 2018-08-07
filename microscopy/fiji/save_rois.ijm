// The text file to save the information
file = File.open("");
f_name = File.directory+File.nameWithoutExtension;
roi_n = roiManager("count");
for (i=0; i<roi_n; i++) {
roiManager("select",i);
if (Roi.getType=="point")
{
	Roi.getCoordinates(x,y);
	print(file,""+getSliceNumber+" "+x[0]+" "+y[0]);
	}
}

File.close(file);

// Deselect to save all the rois
roiManager("deselect"); 
roiManager("save",f_name+".zip"); 