
lis = getList("image.titles");
images_begining=nImages;
dir = File.directory();
for (i=0;i<images_begining;i+=1)
{	
	selectImage(lis[i]);
	
	// Re-order the hyperstack
	run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
	
	// Get the nd file name
	filename=getInfo("window.title");
	pos_name=substring(filename,0,lengthOf(filename)-15);
	outfile = dir+File.separator+".."+File.separator+"drifts"+File.separator+pos_name+".txt";
	// Calculate the drift and save the image
	run("Correct 3D drift", "channel=1 only=0 lowest=1 highest=1 only_0 please="+outfile);
}	
