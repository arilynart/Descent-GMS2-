/// @description Highlight



if (position_meeting(mouse_x, mouse_y, id))
{
	//the mouse is on this square
	if (activated && character == 0 && interaction == 0 && global.selectedCharacter.storedActivation != 0)
	{
		ds_list_clear(highlightArray)
		var foundCharacter = -1;
		var check = CheckSquare(id, global.selectedCharacter.storedActivation);
		if (check != 0)
		{
			ds_list_add(highlightArray, check);
			var i = global.selectedCharacter;
			//loop through closest path until selected character is found.
			while (i != foundCharacter)
			{
				var checkSquare = ds_list_find_value(highlightArray, 
													 ds_list_size(highlightArray) - 1).closestToTarget;
				ds_list_add(highlightArray, checkSquare);
				if (checkSquare.square.character != 0)
				{
					foundCharacter = checkSquare.square.character;
				}
			}
	
			//highlight all squares in array
			var highlightSize = ds_list_size(highlightArray);
			for (var i = 0; i < highlightSize; i++)
			{
				var squareToHighlight = ds_list_find_value(highlightArray, i).square;
		
				squareToHighlight.image_blend = c_yellow;
			}
	
			ds_list_copy(dehighlightArray, highlightArray)
		}
	}
}