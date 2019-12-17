//run("Bio-Formats", "open=/Users/Manu/Documents/data_microscope/spinning3/allsettings25C/EB1-linker-GFP/Ase1D/TP1250_TP4675_12022019/TP1250_cult2/TP1250_8_SR/TP1250_8_SR.nd color_mode=Default display_metadata rois_import=[ROI manager] view=[Metadata only] stack_order=Default");
//saveAs("Text", "/Users/Manu/Desktop/Original Metadata - TP1250_8_SR.csv");


// Verify that it is tif file
if (!endsWith(arg,'.tiff'))
{
	exit("Argument should be a .tiff file");
}

len = lengthOf(arg);
no_termination=substring(arg,0,len-5);
open(arg);
run("Trainable Weka Segmentation");
selectWindow("Trainable Weka Segmentation v3.2.28");
call("trainableSegmentation.Weka_Segmentation.loadClassifier", "/Users/Manu/Desktop/classifier_1.model");
call("trainableSegmentation.Weka_Segmentation.getProbability");
selectWindow("Probability maps");
run("Deinterleave", "how=2");
selectWindow("Probability maps #1");
path_out = no_termination+"_probabilities.tif";
save(path_out);


run("Quit");