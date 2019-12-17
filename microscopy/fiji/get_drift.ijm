
arg = getArgument();
// Verify that it is an tif file
if (!endsWith(arg,'.tif'))
{
	exit("Argument should be a .tif file");
}
print(arg);
file_path=arg;
// Set the name of the new file and get the output path
name=File.getName(file_path);
out_path=File.getParent(file_path);

len = lengthOf(name);
pos_name=substring(name,0,len-15);
outfile = out_path+File.separator+pos_name+".txt";
print(outfile);


open(file_path);
// Re-order the hyperstack
run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
// Calculate the drift and save the image
run("Correct 3D drift", "channel=1 only=0 lowest=1 highest=1 only_0 please="+outfile);
run("Quit");