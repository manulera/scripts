lis = getList("image.titles");
lis = Array.sort(lis);
images_begining=nImages;
for (i=0;i<images_begining;i++){
	a = lis[i];
	print(a);
	selectImage(a);
	dir = getDirectory("image");
	saveAs("PNG",dir+File.separator+"montage_png.png");
}
