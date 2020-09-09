
function addScaleBar(res,scalebar_len,scalebar_text) {
	run("Set Scale...", "distance=1 known=" + res + " pixel=1 unit=[ um] global");	
	extra = "";
	font = 35;
	if (!scalebar_text)
	{
		extra = " hide";
		font= 0;
	}
	
	run("Scale Bar...", "width="+scalebar_len+" height=2 font="+font+" color=White background=None location=[Upper Right] bold overlay" + extra);
}

// In um/pixel
space_res = 0.11;

// In um
scalebar_len = 3;

scalebar_text = false;


run("Duplicate...", "duplicate frames=38-56");
runMacro("/Users/Manu/scripts/microscopy/fiji/make_figures/make_merge.ijm");
runMacro("/Users/Manu/scripts/microscopy/fiji/make_figures/make_vertical_montage.ijm");
addScaleBar(space_res,scalebar_len,scalebar_text);
