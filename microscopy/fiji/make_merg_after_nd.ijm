run("Z Project...", "projection=[Max Intensity] all");
Stack.setChannel(1);
run("Enhance Contrast", "saturated=0.35");
Stack.setChannel(2);
run("Enhance Contrast", "saturated=0.35");

name=getTitle();
run("Deinterleave","how=2 keep")
fullname1 = name + " #1";
fullname2 = name + " #2";
run("Merge Channels...", "c1=["+fullname1+"] c2=["+fullname2+"] create");

exit()
