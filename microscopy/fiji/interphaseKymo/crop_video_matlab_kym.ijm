function kymo_name(dir)
{
	for (i = 1; i < 100; i++) 
	{
		num = toString(floor(i/10))+toString(i);
		name = "interphase_kymo"+num;
		path = dir+File.separator+name;
		
		if (!File.exists(path))
		{
			return name;
		}
	}
	return false;
}

ima = getTitle();
dir = File.directory()+"interphase_kymos"+File.separator;


if (!File.isDirectory(dir))
{
	File.makeDirectory(dir);
}
name = kymo_name(dir);
dir = dir+File.separator+name+File.separator;

File.makeDirectory(dir);

roiManager("Add");
roiManager("Select", 0);
roiManager("Save", dir+"bounding_box.roi");

file=File.open(dir+File.separator+"settings.txt");
print(file,"0");
File.close(file);

run("Duplicate...", "duplicate");
saveAs("Tiff", dir+File.separator+"movie.tif");
selectWindow(ima);
roiManager("Deselect");
roiManager("Delete");
selectWindow("movie.tif");

run("Z Project...", "projection=[Max Intensity]");
selectWindow("MAX_movie.tif");
saveAs("Tiff", dir+File.separator+"movie_projection.tif");
