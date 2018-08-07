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

images_begining=nImages
for (i=0;i<images_begining;i++){
	selectImage(i+1);
	if (Stack.isHyperstack)
	{
		// Apply z projection
		run("Z Project...","start=1 stop=7 projection=[Max Intensity] all");
		// Apply autocontrast to the projection in both channels
		Stack.setChannel(1);
		auto_contrast();
		Stack.setChannel(2);
		auto_contrast();
		wait(1000);
	}
}

// Now show the max projections up so you dont have to select them:
//for (i=images_begining;i<nImages;i++){
//	selectImage(i+1);
//}
// 

