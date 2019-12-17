// Close all windows

arg = getArgument();
// Verify that it is an tif file
if (!endsWith(arg,'.tif'))
{
	exit("Argument should be a .tif file");
}
print(arg);
file_path=arg;
//class_path="/Users/Manu/Documents/data_microscope/spinning3/allsettings27C/EnvyAtb2/classifier_EnvyAtb2_LP20.model";
//class_path="/Users/Manu/Documents/data_microscope/spinning3/allsettings27C/pnmt1GFPmal3_mitosis/classifier_mal3_simple.model";
//class_path="/Users/Manu/Documents/data_microscope/spinning3/allsettings27C/cls1_3GFPmch_Atb2/classifier_mchAtb2.model";
class_path="/Users/Manu/Documents/data_microscope/spinning3/allsettings27C/cls1_3GFPmch_Atb2/classifier_cls1_3GFP.model";
// For Ana
 //class_path = "/Users/Manu/Documents/data_microscope/training/mcherryAtb2ME.model";
// class_path = "/Users/Manu/Documents/data_microscope/training/GFPAtb2ME.model";

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
if (File.exists(out_file))
{
	print("Already done: "+file_path);
	run("Quit");
}

// Open the file
open(file_path);

// Run the Weka segmentation using the classifier specified in class_path
run("Trainable Weka Segmentation");
// wait for the plugin to load
wait(3000);

selectWindow("Trainable Weka Segmentation v3.2.28");
call("trainableSegmentation.Weka_Segmentation.loadClassifier", class_path);
call("trainableSegmentation.Weka_Segmentation.getProbability");

// Save the probability map in the same folder as new_name
selectWindow("Probability maps");
run("Duplicate...", "duplicate channels=1");
saveAs("Tiff", out_file);
run("Quit");