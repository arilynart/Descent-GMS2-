/// @description Dehighlight


if (dehighlightArray != 0)
{
	//clear out the array
	
	var highlightSize = ds_list_size(dehighlightArray);
	for (var i = 0; i < highlightSize; i++)
	{
		
		var squareToHighlight = ds_list_find_value(dehighlightArray, i);
		
		if (squareToHighlight.square.activated)
		{
			if (squareToHighlight.square.interaction != 0) squareToHighlight.square.image_blend = interactionColor;
			else if (squareToHighlight.square.character != 0)
			{
				if (squareToHighlight.square.moveTarget) squareToHighlight.square.image_blend = c_black;
				else if (squareToHighlight.square.character.characterStats.team == CharacterTeams.Ally)
				{
					squareToHighlight.square.image_blend = c_lime;
				}
				else if (squareToHighlight.square.character.characterStats.team == CharacterTeams.Enemy)
				{
					squareToHighlight.square.image_blend = c_red;
				}
				else if (squareToHighlight.square.character.characterStats.team == CharacterTeams.Neutral)
				{
					squareToHighlight.square.image_blend = c_blue;
				}
				squareToHighlight.square.image_alpha = 0.6;
			}
			else squareToHighlight.square.image_blend = c_white;
		}
		else
		{
			squareToHighlight.square.image_blend = c_white;
			squareToHighlight.square.image_alpha = 0;
		}

	}
	
	ds_list_clear(dehighlightArray);
}