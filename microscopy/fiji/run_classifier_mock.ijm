// Close all windows

arg = getArgument();
// Verify that it is an tif file
if (!endsWith(arg,'.tif'))
{
	exit("Argument should be a .tif file");
}
print(arg);
file_path=arg;
class_path="/Users/Manu/Documents/data_microscope/spinning3/allsettings27C/EnvyAtb2/classifier_EnvyAtb2_LP20.model";

// Set the name of the new file and get the output path
name=File.getName(file_path);
out_path=File.getParent(file_path);
if (out_path==0)
{
	out_path=".";
	}
print(out_path);
len = lengthOf(name);
no_termination=substring(name,0,len-4);
new_name=no_termination+"_extra.tif";
out_file=out_path+"/"+new_name;
print(out_file);

// Open the file
open(file_path);

saveAs("Tiff", out_file);
run("Quit");