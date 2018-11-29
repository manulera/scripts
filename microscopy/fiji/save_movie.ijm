name=getTitle();
// copy the movie
run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
run("Duplicate...", "duplicate");
run("Time Stamper", "starting=0 interval=60 x=2 y=15 font=18 '00 decimal=0 anti-aliased or=sec");
run("Set Scale...", "distance=1 known=0.16 pixel=1 unit=[ um] global");
run("Scale Bar...", "width=3 height=4 font=10 color=White background=None location=[Lower Right] bold label");
run("AVI... ", "compression=None frame=7 save=/Users/Manu/Documents/Presentations/Lab_meeting_11.2018/slow_movie.avi");