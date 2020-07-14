//// Variables to set --------------------------------

// In seconds
time_res = 60;

// In um/pixel
space_res = 0.11;

// In um
scalebar_len = 5;

scalebar_text = false;

// Format of the time
time_format = "00:00:00";
time_format = "00:00";

//// --------------------------------

name=getTitle();

function addScaleBar(res,scalebar_len,scalebar_text) {
	run("Set Scale...", "distance=1 known=" + res + " pixel=1 unit=[ um] global");	
	extra = "";
	font = 35;
	if (!scalebar_text)
	{
		extra = " hide";
		font= 0;
	}
	
	run("Scale Bar...", "width="+scalebar_len+" height=5 font="+font+" color=White background=None location=[Lower Right] bold overlay" + extra);
}

function addTimer(interval,format){
	run("Label...", "format="+format+" starting=0 interval="+interval+" x=0 y=0 font=35 text=[] use");	
}


// copy the movie
run("Duplicate...", "duplicate");

//addTimer(time_res,time_format);
addScaleBar(space_res,scalebar_len,scalebar_text);

//run("AVI... ", "compression=None frame=7 save=/Users/Manu/Dropbox/presentations/LabMeeting07112019/movie_ase1_1.avi");