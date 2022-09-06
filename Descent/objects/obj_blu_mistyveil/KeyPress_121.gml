/// @description display/hide points


var size = ds_list_size(wallPoints);

if (displaying)
{
	displaying = false;
	global.grid = true;
	show_debug_overlay(false);
	for (var i = 0; i < size; i++)
	{
		ds_list_find_value(wallPoints, i).visible = false;
	}
}
else
{
	displaying = true;
	global.grid = false;
	show_debug_overlay(true);
	for (var i = 0; i < size; i++)
	{
		ds_list_find_value(wallPoints, i).visible = true;
	}
}
