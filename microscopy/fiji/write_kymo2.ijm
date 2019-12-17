
function kymo_name(dir)
{
	for (i = 1; i < 100; i++) 
	{
		num = toString(floor(i/10))+toString(i);
		name = "kymo"+num;
		path = dir+name+".tif";
		if (!File.exists(path))
		{
			return name;
		}
	}
	return false;
}

ima = getTitle();
dir = File.directory()+"kymos/";
name = kymo_name(dir);

if (!File.isDirectory(dir))
{
	File.makeDirectory(dir);
}

roiManager("Add");
roiManager("Select", 0);
//roiManager("Save", dir+"/"+name+".roi");




run("Crop");
exit();
setBackgroundColor(0, 0, 0);
run("Clear Outside", "stack");
run("Grays");
run("Enhance Contrast", "saturated=0.35");
//saveAs("Tiff", dir+"/"+name+"_mini.tif");

selectWindow(ima);
run("KymographBuilder", "input=[ima]");
run("Duplicate...", "duplicate channels=2");
run("Grays");
run("Enhance Contrast", "saturated=0.35");
//saveAs("Tiff", dir+"/"+name+".tif");

selectWindow(ima);
roiManager("Deselect");
roiManager("Delete");

