function generate_name(dir)
{
	for (i = 1; i < 100; i++) 
	{
		num = toString(floor(i/10))+toString(i);
		name = "bundle_"+num;
		path = dir+File.separator+name;
		
		if (!File.exists(path))
		{
			return name;
		}
	}
	return false;
}

dir = getDirectory("image");
name = generate_name(dir);
dir = dir+File.separator+name+File.separator;

File.makeDirectory(dir);
if (!File.isDirectory(dir))
{
	File.makeDirectory(dir);
}

run("Create Mask");
run("Invert");

saveAs("Tiff", dir+File.separator+"bundle_mask.tif");
