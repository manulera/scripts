//run("Bio-Formats", "open=/Users/Manu/Documents/data_microscope/spinning3/allsettings25C/EB1-linker-GFP/Ase1D/TP1250_TP4675_12022019/TP1250_cult2/TP1250_8_SR/TP1250_8_SR.nd color_mode=Default display_metadata rois_import=[ROI manager] view=[Metadata only] stack_order=Default");
//saveAs("Text", "/Users/Manu/Desktop/Original Metadata - TP1250_8_SR.csv");

arg = getArgument();
// Verify that it is an nd file
if (!endsWith(arg,'.nd'))
{
	exit("Argument should be an .nd file");
}

len = lengthOf(arg);
no_termination=substring(arg,0,len-3);
run("Bio-Formats", "open=[arg] color_mode=Default display_metadata rois_import=[ROI manager] view=[Metadata only] stack_order=Default");
path_out = no_termination+"_metadata.csv";
saveAs("Text", path_out);
run("Quit");