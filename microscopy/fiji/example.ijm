call("trainableSegmentation.Weka_Segmentation.getProbability");
exit();
dir = getDirectory("Choose a Directory ");
list = getFileList(dir);
for (i=0; i<list.length; i++) {
        if (endsWith(list[i], "/"))
           listFiles(""+dir+list[i]);
        else if (endsWith(list[i],'3_max.tiff'))
        {
        	arg = list[i];
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
        }   
}