/// @description Highlight



if (position_meeting(mouse_x, mouse_y, id))
{
	//the mouse is on this square
	
	//if the previous mouse position is 
	
	if (activated && character == 0 && interaction == 0)
	{
		highlightArray = ds_list_create();
		var foundCharacter = -1;
		ds_list_add(highlightArray, self);
	
		//loop through closest path until selected character is found.
		for (var i = global.selectedCharacter; i != foundCharacter; i = global.selectedCharacter)
		{
			var checkSquare = ds_list_find_value(highlightArray, 
												 ds_list_size(highlightArray) - 1).closestToTarget;
			ds_list_add(highlightArray, checkSquare);
			if (checkSquare.character != 0)
			{
				foundCharacter = checkSquare.character;
			}
		}
	
		//highlight all squares in array
		var highlightSize = ds_list_size(highlightArray);
		for (var i = 0; i < highlightSize; i++)
		{
			var squareToHighlight = ds_list_find_value(highlightArray, i);
		
			squareToHighlight.image_blend = c_aqua;
		}
	
		dehighlightArray = highlightArray;
	}
}