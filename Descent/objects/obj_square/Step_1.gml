/// @description Dehighlight


if (dehighlightArray != 0)
{
	
	//clear out the array
	
	var highlightSize = ds_list_size(dehighlightArray);
	for (var i = 0; i < highlightSize; i++)
	{
		
		var squareToHighlight = ds_list_find_value(dehighlightArray, i);

		squareToHighlight.image_blend = c_white;

	}
	
	dehighlightArray = 0;
	highlightArray = 0;
}