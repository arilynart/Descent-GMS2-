/// @function MoveCharacter(character, target)
/// @param {index} character The character to move.
/// @param {index} target The square to move to.

function MoveCharacter(character, target, activation)
{
	show_debug_message("MoveCharacter");
	var foundCharacter = false;
	var path = ds_list_create();
	
	var parsedStruct = target.CheckSquare(target, activation);
	
	ds_list_add(path, parsedStruct);
	
	if (target == character.currentSquare)
	{
		ds_queue_enqueue(character.moveQueue, parsedStruct);
		
		character.moving = true;
	}
	else if (parsedStruct != 0)
	{
		while (foundCharacter == false)
		{
			if (parsedStruct.closestToTarget != 0)
			{
				var struct = parsedStruct.closestToTarget;
				ds_list_add(path, struct);
				if (struct.square.character == character)
				{
					foundCharacter = true;
					struct.square.character.maxMove -= ds_list_find_value(path, 0).distance;
				}
				else
				{
					parsedStruct = struct;
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
			show_debug_message("No Path Found. Doing Nothing. Line ~48.");
			
			target.moveTarget = false;
			character.moveLock = false;
			
			EndEffect();
		}
		else
		{
			var pathLength = ds_list_size(path);
			show_debug_message("Path Found. Executing path with " + string(pathLength) + " squares.");
			
			//send character along path until the end.
			for (var i = 1; i <= pathLength; i++)
			{
				var index = pathLength - i;
			
				var sq = ds_list_find_value(path, index);
			
				ds_queue_enqueue(character.moveQueue, sq);
			}
		
			if (character == global.selectedCharacter) global.cameraTarget.followingCharacter = character;
			character.moving = true;
		}
	}
	else 
	{
		show_debug_message("No Path Found. Doing Nothing. Line ~75.");
			
		target.moveTarget = false;
		character.moveLock = false;
			
		EndEffect();
	}
	
	ds_list_destroy(path);
}