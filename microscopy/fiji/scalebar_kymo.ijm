name=getTitle();
// copy the movie
run("Duplicate...", "duplicate");
run("Set Scale...", "distance=1 known=0.06 pixel=1 unit=[ um] global");
run("Scale Bar...", "width=3 height=5 font=35 color=White background=None location=[Lower Right]");
//run("AVI... ", "compression=None frame=7 save=/Users/Manu/Dropbox/presentations/LabMeeting07112019/movie_ase1_1.avi");