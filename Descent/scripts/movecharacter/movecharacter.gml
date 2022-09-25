/// @function MoveCharacter(character, target)
/// @param {index} character The character to move.
/// @param {index} target The square to move to.

function MoveCharacter(character, target)
{
	var foundCharacter = false;
	var path = ds_list_create();

	ds_list_add(path, target);
	var parsedSquare = target;
	
	if (target == character.currentSquare)
	{
		ds_queue_enqueue(character.moveQueue, target);
		character.moving = true;
	}
	else
	{
		while (foundCharacter == false)
		{
			if (parsedSquare.closestToTarget != 0)
			{
				var square = parsedSquare.closestToTarget;
				parsedSquare.closestToTarget = 0;
				ds_list_add(path, square);
				if (square.character == character)
				{
					foundCharacter = true;
					square.character.maxMove -= ds_list_find_value(path, 0).distance;
					square.Deactivate();
				}
				else
				{
					parsedSquare = square;
				}
			}
			else
			{
				ds_list_clear(path);
				break;	
			}
		}
	
		if (ds_list_empty(path))
		{
			show_debug_message("No Path Found. Doing Nothing.");
		}
		else
		{
			show_debug_message("Path Found. Executing.");
			var pathLength = ds_list_size(path);
			//send character along path until the end.
			for (var i = 1; i <= pathLength; i++)
			{
				var index = pathLength - i;
			
				var sq = ds_list_find_value(path, index);
			
				ds_queue_enqueue(character.moveQueue, sq);
			}
		
			global.cameraTarget.followingCharacter = character;
			character.moving = true;
		}
	}
	
	ds_list_destroy(path);
}