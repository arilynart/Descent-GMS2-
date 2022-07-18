/// @description display/hide points


var size = ds_list_size(wallPoints);

if (displaying)
{
	displaying = false;
	for (var i = 0; i < size; i++)
	{
		ds_list_find_value(wallPoints, i).visible = false;
	}
}
else
{
	displaying = true;
	for (var i = 0; i < size; i++)
	{
		ds_list_find_value(wallPoints, i).visible = true;
	}
	
}
