dir = getInfo("image.directory");
name = File.nameWithoutExtension();
run("Split Channels");
 function scalebar(resolution,size) {
 	run("Set Scale...", "distance=1 known="+resolution+" pixel=1 unit=[ um] ");
	run("Scale Bar...", "width="+size+" height=4 font=10 color=White background=None location=[Lower Right] hide overlay");
 	}

lis = getList("image.titles");

LUTs = newArray("Grays","Green","Red","Cyan");

c1_lims = newArray(12000,13000);
c2_lims = newArray(360,2000);
c3_lims = newArray(200,4000);
c4_lims = newArray(180,870);

lims = Array.concat(c1_lims,c2_lims);
lims = Array.concat(lims,c3_lims);
lims = Array.concat(lims,c4_lims);

// Set contrast 
for (i = 0; i < 4; i++) 
{
	ima = lis[i];
	selectImage(ima);
	setMinAndMax(lims[i*2], lims[i*2+1]);
}

// Make merge of channels 2 and 3
run("Merge Channels...", "c1=["+lis[2]+"] c2=["+lis[1]+"] create keep");
this_name= name+"_merge";
scalebar(0.0645,10);
saveAs("png",dir+File.separator+this_name+".png");
close();

for (i = 0; i < 4; i++) 
{
	ima = lis[i];
	selectImage(ima);
	run(LUTs[i]);
	
	setMinAndMax(lims[i*2], lims[i*2+1]);
	this_name= name+"_channel"+i+1;
	saveAs("png",dir+File.separator+this_name+".png");
	close();
}
