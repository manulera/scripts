pathfile=File.openDialog("Choose the file to Open:");
filestring=File.openAsString(pathfile);
rows=split(filestring, "\n");
rows=Array.slice(rows,5,rows.length);
x=newArray(rows.length);
y=newArray(rows.length);

for(i=0; i<rows.length; i++){
	columns=split(rows[i],"\t");
	x[i]=parseInt(columns[0]);
	y[i]=parseInt(columns[1]);
}

width = getWidth();
height = getHeight();

Array.getStatistics(x, min_x, max_x,_, _);
Array.getStatistics(y, min_y, max_y,_, _);

print(min_x);
print(min_y);
run("Duplicate...", "duplicate");

// Addition to the canvas
add_x = width+max_x-min_x;
add_y = height+max_y-min_y;

// We want the image to be at the bottom-right corner when the drift is equal to the minimal of x
// and y

run("Canvas Size...", "width="+add_x+" height="+add_y+" position=Bottom-Right");


Stack.getDimensions(_, _, channels, slices, frames);

// Iterate through time
for(f=1; f<=frames; f++)
{
	Stack.setFrame(f);	
	// Iterate through slices
	for(s=1; s<=slices; s++)
	{
		Stack.setSlice(s);		
		//Iterate through channels
		for(c=1; c<=channels; c++)
		{
			Stack.setChannel(c);
			// Substract the 1, because the arrays are zero-based indexed
			move_x = x[f-1]-max_x;
			move_y = y[f-1]-max_y;
			run("Translate...", "x="+move_x+" y="+move_y+" interpolation=None slice");
		}
	}
}

