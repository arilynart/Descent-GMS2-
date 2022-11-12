// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function RandomizeList(list)
{
	var shuffledList = ds_list_create();
	
	while (ds_list_size(list) > 0)
	{
		var roll = irandom(ds_list_size(list) - 1);
		
		var randomValue = ds_list_find_value(list, roll);
		
		ds_list_add(shuffledList, randomValue);
		ds_list_delete(list, roll);
	}
	
	ds_list_destroy(list);
	return shuffledList;
}