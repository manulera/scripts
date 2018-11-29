

function auto_contrast() { 
        /* 
         * rewriting "Auto contrast adjustment" button of "Brightness/Contrast" 
         * Damien Guimond 
         * 20120516 
         * Acknowledgements: Kota Miura 
         */ 
        
	 AUTO_THRESHOLD = 5000;	 
	 getRawStatistics(pixcount); 
	 limit = pixcount/10;
	 threshold = pixcount/AUTO_THRESHOLD; 
	 nBins = 256; 
	 getHistogram(values, histA, nBins); 
	 i = -1; 
	 found = false; 
	 do { 
	         counts = histA[++i]; 
	         if (counts > limit) counts = 0; 
	         found = counts > threshold; 
	 } while ((!found) && (i < histA.length-1)) 
	 hmin = values[i]; 
	
	 i = histA.length; 
	 do { 
	         counts = histA[--i]; 
	         if (counts > limit) counts = 0; 
	         found = counts > threshold; 
	 } while ((!found) && (i > 0)) 
	 hmax = values[i]; 
	
	 setMinAndMax(hmin, hmax); 
	 //print(hmin, hmax); 
	 //run("Apply LUT"); 
}

nb_chans = 2
lis = getList("image.titles");
lis = Array.sort(lis);
images_begining=nImages;
for (i=0;i<images_begining;i+=nb_chans){
	a = lis[i];
	selectImage(a);
	b = lis[i+1];
	selectImage(b);
	if (nb_chans==3)
	{
		c = lis[i+2];
		selectImage(c);
		run("Concatenate...", "title="+a+" open image1="+a+" image2="+b+" image3="+c);
	}
	else
	{
		run("Concatenate...", "title="+a+" open image1="+a+" image2="+b );
	}
	run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
	run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");
	Stack.setDisplayMode("grayscale");
}


//Apply autocontrast
images_begining=nImages;
for (i=0; i<nImages;i++)
{
	selectImage(i+1);
	Stack.setChannel(1);
	auto_contrast();
	Stack.setChannel(2);
	auto_contrast();
	if (nb_chans==3)
	{
		Stack.setChannel(3);
		auto_contrast();
	}
}


// Now show the max projections up so you dont have to select them:
//for (i=images_begining;i<nImages;i++){
//	selectImage(i+1);
//}
// 

