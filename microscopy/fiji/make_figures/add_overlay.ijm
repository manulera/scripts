//// Variables to set --------------------------------

frame_increment = 3;


Stack.getDimensions(x_size, y_size, channels, slices, frames);

run("Make Montage...", "columns="+frames/frame_increment+" rows=1 scale=1 increment="+frame_increment);

run("Restore Selection");

for(f=1; f<=frames/frame_increment; f++)
{
	getSelectionBounds(x, y, w, h);
    run("Add Selection...");
    setSelectionLocation(x+x_size, y);	
}