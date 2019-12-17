lis = getList("image.titles");
lis = Array.sort(lis);
images_begining=nImages;
for (i=0;i<images_begining;i+=1){
	a = lis[i];
	selectImage(a);
	run("Z Project...", "projection=[Max Intensity] all");
	run("Enhance Contrast", "saturated=0.35");
}