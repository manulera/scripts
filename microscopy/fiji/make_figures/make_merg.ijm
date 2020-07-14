// Depending on the number of channels
run("Duplicate...", "duplicate channels=2-3");

name=getTitle();
run("Deinterleave","how=2 keep")
fullname1 = name + " #1";
fullname2 = name + " #2";
run("Merge Channels...", "c1=["+fullname1+"] c2=["+fullname2+"] create");
run("Re-order Hyperstack ...", "channels=[Channels (c)] slices=[Frames (t)] frames=[Slices (z)]");
Stack.setChannel(1);
run("Green");
run("Enhance Contrast", "saturated=0.35");
//auto_contrast();
Stack.setChannel(2);
run("Red");
run("Enhance Contrast", "saturated=0.35");
//auto_contrast();