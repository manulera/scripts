
function kymo_name(dir)
{
	for (i = 1; i < 100; i++) 
	{
		num = toString(floor(i/10))+toString(i);
		name = "kymo"+num;
		path = dir+name+".tif";
		if (!File.exists(path))
		{
			return name;
		}
	}
	return false;
}

function getTag(tag) {
      info = getImageInfo();
      index1 = indexOf(info, tag);
      if (index1==-1) return "";
      index1 = indexOf(info, ":", index1);
      if (index1==-1) return "";
      index2 = indexOf(info, "\n", index1);
      value = substring(info, index1+1, index2);
      return value;
}


ima = getTitle();
dir = File.directory()+"kymos/";
name = kymo_name(dir);

meta = getTag("Frame interval");
print(meta);