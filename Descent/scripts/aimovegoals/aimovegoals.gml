// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AiMoveToEnemyGoal(character)
{
	show_debug_message("AiMoveToEnemyGoal");
	var MoveExecution = 0;
	var moveDistance = 0;
	//if we have move left
	if (character.maxMove >= 1)
	{
		moveDistance = character.maxMove;
		MoveExecution = method(global, AiNormalMove);
	}
	
	
	//else, if we have any other tools to move there
		//use the best tool for the job
		
	//activate move.
	
	if (moveDistance > 0)
	{
		var foundSquare = 0;
		var foundCharacter = 0;
		var h = 0;
		var activatedBreak = false;
		while (foundCharacter == 0)
		{
			show_debug_message("Searching for new character at distance of " + string(moveDistance + h));
			
			character.currentSquare.Deactivate();
			
			character.currentSquare.Activate(character.currentSquare, moveDistance + h);
			
			var activatedSize = ds_list_size(character.currentSquare.activatedSquares);
			for (var i = 0; i < activatedSize; i++)
			{
				var checkSquare = ds_list_find_value(character.currentSquare.activatedSquares, i);
			
				show_debug_message("Checking Square at: " + string(checkSquare.coordinate.x) + ", " + string(checkSquare.coordinate.y));
			
				if (checkSquare.character != 0 && checkSquare.character.aiMind != character.aiMind)
				{
					if (foundCharacter == 0 || foundCharacter.aiThreat < checkSquare.character.aiThreat)
					{
						if (foundSquare == 0 || (foundSquare != 0 && checkSquare.distance < foundSquare.distance) || foundCharacter.aiThreat < checkSquare.character.aiThreat)
						{
							//find the closest square within the move distance
							foundCharacter = checkSquare.character;
							foundSquare = checkSquare;
							
							//find closest to target location within max distance
							
							var foundDistance = foundSquare.distance;
							while (foundDistance > moveDistance || foundSquare.character != 0 || foundSquare.interaction != 0)
							{
								if (foundSquare == character.currentSquare)
								{
									activatedBreak = true;
									break;
								}
								else
								{
									foundSquare = foundSquare.closestToTarget;
									foundDistance = foundSquare.distance;
								}
							}

						}
					}
				}
				if (activatedBreak) break;
			}
			
			h++;
			if (h > moveDistance * 4) activatedBreak = true;
			if (activatedBreak) break;
		}
		
		//move
		if (activatedBreak)
		{
			character.maxMove = 0;
			AiUpdateGoal(character);
		}
		else if (foundSquare != 0)
		{
			show_debug_message("Target square found at " + string(foundSquare.coordinate.x) + ", " + string(foundSquare.coordinate.y));

			MoveExecution(character, foundSquare);
		}
	}
	else
	{
		AiUpdateGoal(character);
	}
}

AiCanMove = function(character)
{
	var movementRemaining = (character.maxMove >= 1);
	
	return (movementRemaining);
}

function AiNormalMove(character, target)
{
	var moveEffect = global.BaseEffect();
	moveEffect.character = character;
	moveEffect.target = target;
	moveEffect.Start = method(global, global.MoveEffect);
		
	AddEffect(moveEffect);
}