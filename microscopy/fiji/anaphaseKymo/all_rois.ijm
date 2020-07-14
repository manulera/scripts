dir = getMetadata("original_path")+"kymos_matlab"+File.separator;
file_list = getFileList(dir);
print("---------");
print(getMetadata("original_path"));
print(dir);
for (i = 0; i < file_list.length; i++) {
	this_roi = dir + File.separator + file_list[i] + File.separator + "bounding_box.roi";
	roiManager("Open",this_roi);
}
roiManager("Show All");