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

name=getTitle();
run("Z Project...", "projection=[Max Intensity] all");
auto_contrast();
exit();

name=getTitle();
run("Deinterleave","how=2 keep")
fullname1 = name + " #1";
fullname2 = name + " #2";
run("Merge Channels...", "c1=["+fullname1+"] c2=["+fullname2+"] create");
run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
Stack.setChannel(1);
auto_contrast();
Stack.setChannel(2);
auto_contrast();