/// @description Dehighlight


if (dehighlightArray != 0)
{
	
	//clear out the array
	
	var highlightSize = ds_list_size(dehighlightArray);
	for (var i = 0; i < highlightSize; i++)
	{
		
		var squareToHighlight = ds_list_find_value(dehighlightArray, i);
		
		if (squareToHighlight.activated)
		{
			if (squareToHighlight.interaction != 0) squareToHighlight.image_blend = interactionColor;
			else if (squareToHighlight.character != 0)
			{
				if (squareToHighlight.character.characterStats.team == CharacterTeams.Ally)
				{
					squareToHighlight.image_blend = c_lime;
				}
				else if (squareToHighlight.character.characterStats.team == CharacterTeams.Enemy)
				{
					squareToHighlight.image_blend = c_red;
				}
				else if (squareToHighlight.character.characterStats.team == CharacterTeams.Neutral)
				{
					squareToHighlight.image_blend = c_blue;
				}
				squareToHighlight.image_alpha = 1;
			}
			else squareToHighlight.image_blend = c_white;
		}
		else
		{
			squareToHighlight.image_blend = c_white;
			squareToHighlight.image_alpha = 0;
		}

	}
}