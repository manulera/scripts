
// The name of the image
window_name = getTitle();
// The directory where the image is
path = File.directory;
dir = path+"events/";
print(dir)
// Make the events folder
if (!File.isDirectory(dir))
{
	File.makeDirectory(dir);
}
// The file where the coordinates are stored (x,y,t)
file = File.open("");
keep_going = true;

while (keep_going)
{	
	// Select a point and print the coords
	coord = Roi.getCoordinates(x,y);
	t = getSliceNumber;
	print(file,""+x[0]+" "+y[0]+" "+t);
	
	// Dialog to decide whether to keep going or not
	Dialog.create("Instructions");
	Dialog.addCheckbox("Keep going?", true);	
	Dialog.show();
	keep_going = Dialog.getCheckbox;
	waitForUser;
}
// Close the file
File.close(file)