name=getTitle();
run("Deinterleave","how=2 keep")
fullname1 = name + " #1";
fullname2 = name + " #2";
run("Merge Channels...", "c1=["+fullname2+"] c2=["+fullname1+"] create");
