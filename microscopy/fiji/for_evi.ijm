// Create a file to store the information

//file = File.open("");

function is_member(arr,name)
{
	for (i=0; i<lengthOf(arr);i++)
	{
		if (arr[i]==name) 
		{
			return true;		
		}
	}
	return false;
}
// Iterate through the rois to find the one that is called either background or main
what = newArray("main","background");
// First verify that there are only two rois and that they are called like that
roi_n = roiManager("count");

if (roi_n!=2)
{
	print("The number of rois is different from two");		
	exit()
}
// Verify that there are one named main and one name background
count = 0;
for (i=0; i<roi_n; i++) 
{
	roiManager("select",i);
	if (is_member(what,Roi.getName))
	{
		count+=1;
	}
}

if (count!=2)
{
	print("The rois are not named 'main' and 'background'");
	exit();
}

measure="background";
for (i=0; i<roi_n; i++) 
{
	roiManager("select",i);
	if (Roi.getName==measure)
	{
		Roi.getCoordinates(x_bg, y_bg);
		
		Stack.setChannel(1);
		bg = getProfile();
		Array.getStatistics(bg, min, max, background_1, stdDev);
		Stack.setChannel(2);
		bg = getProfile();
		Array.getStatistics(bg, min, max, background_2, stdDev);
		Stack.setChannel(3);
		bg = getProfile();
		Array.getStatistics(bg, min, max, background_3, stdDev);
	}
}
measure="main";
for (i=0; i<roi_n; i++) 
{
	roiManager("select",i);
	if (Roi.getName==measure)
	{
		Stack.setChannel(1);
		main_1 = getProfile();
		Stack.setChannel(2);
		main_2 = getProfile(); 
		Stack.setChannel(3);
		main_3 = getProfile();
		run("Plot Profile"); 
  		Plot.getValues(length, y);
	}
}


main1_substracted = Array.copy(main_1);
main2_substracted = Array.copy(main_1);
main3_substracted = Array.copy(main_1);

for (i=0; i<lengthOf(length);i++)
{
	main1_substracted[i] = main_1[i]-background_1;
	main2_substracted[i] = main_2[i]-background_2;
	main3_substracted[i] = main_3[i]-background_3;
}

Table.create("Results");
Table.setColumn("Length (um)",length);
Table.setColumn("Signal1",main1_substracted);
Table.setColumn("Signal2",main2_substracted);
Table.setColumn("Signal3",main3_substracted);
dir = getDirectory("Choose a Directory");
Table.save(dir+"results.csv");
exit();


File.close(file);

// Deselect to save all the rois
roiManager("deselect"); 
roiManager("save",f_name+".zip"); 