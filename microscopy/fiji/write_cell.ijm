
function cell_name(dir)
{
	for (i = 1; i < 100; i++) 
	{
		num = toString(floor(i/10))+toString(i);
		name = "cell"+num;
		path = dir+name+".tif";
		if (!File.exists(path))
		{
			return name;
		}
	}
	return false;
}

ima = getTitle();
dir = File.directory()+"weka/";
name = cell_name(dir);

if (!File.isDirectory(dir))
{
	File.makeDirectory(dir);
}

roiManager("Add");
roiManager("Select", 0);
roiManager("Save", dir+"/"+name+".roi");

run("Duplicate...", "duplicate");

saveAs("Tiff", dir+"/"+name+".tif");
roiManager("Deselect");
roiManager("Delete");

