//// Script assets have changed for v2.3.0 see
//// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//function OldActivate(start, maxDistance, activeCharacter)
//{
//	show_debug_message("Activating grid from: " + string(start.coordinate) + " with a distance of " + string(maxDistance));
	
//	ds_queue_clear(parseQueue);
//	ds_list_clear(parsedCoordinates);
//	ds_list_clear(activatedSquares);
	
//	ds_queue_enqueue(parseQueue, start);
//	ds_list_add(parsedCoordinates, start.coordinate);
//	start.distance = 0;
	
//	while (!ds_queue_empty(parseQueue))
//	{
//		var currentSquare = ds_queue_dequeue(parseQueue);
//		currentSquare.activated = true;
		
		
		
//		ds_list_add(activatedSquares, currentSquare);
		
//		var targetX = -1;
//		var targetY = -1;
		
//		//straight
//		var nextDistance = currentSquare.distance + 1;
		
//		if (nextDistance <= maxDistance)
//		{
//			//right
//			targetX = currentSquare.coordinate.x + 1;
//			targetY = currentSquare.coordinate.y;
//			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
//			{
//				ParseSquare(currentSquare.right, nextDistance, currentSquare, activeCharacter);
//			}
//			//down
//			targetX = currentSquare.coordinate.x;
//			targetY = currentSquare.coordinate.y + 1;
//			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
//			{
//				ParseSquare(currentSquare.down, nextDistance, currentSquare, activeCharacter);
//			}
//			//left
//			targetX = currentSquare.coordinate.x - 1;
//			targetY = currentSquare.coordinate.y;
//			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
//			{
//				ParseSquare(currentSquare.left, nextDistance, currentSquare, activeCharacter);
//			}
//			//up
//			targetX = currentSquare.coordinate.x;
//			targetY = currentSquare.coordinate.y - 1;
//			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
//			{
//				ParseSquare(currentSquare.up, nextDistance, currentSquare, activeCharacter);
//			}
//		}
		
//		nextDistance = currentSquare.distance + 1.5;
//		if (nextDistance <= maxDistance)
//		{
//			//downright
//			targetX = currentSquare.coordinate.x + 1;
//			targetY = currentSquare.coordinate.y + 1;
//			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
//			{
//				ParseSquare(currentSquare.downRight, nextDistance, currentSquare, activeCharacter);
//			}
//			//downleft
//			targetX = currentSquare.coordinate.x - 1;
//			targetY = currentSquare.coordinate.y + 1;
//			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
//			{
//				ParseSquare(currentSquare.downLeft, nextDistance, currentSquare, activeCharacter);
//			}
//			//upleft
//			targetX = currentSquare.coordinate.x - 1;
//			targetY = currentSquare.coordinate.y - 1;
//			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
//			{
//				ParseSquare(currentSquare.upLeft, nextDistance, currentSquare, activeCharacter);
//			}
//			//upright
//			targetX = currentSquare.coordinate.x + 1;
//			targetY = currentSquare.coordinate.y - 1;
//			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
//			{
//				ParseSquare(currentSquare.upRight, nextDistance, currentSquare, activeCharacter);
//			}
//		}
//	}
//}

//function OldParseSquare(square, parseDistance, source, activeCharacter)
//{
//	//show_debug_message("Parsing Square: " + string(square));
//	if (square != 0 && square.character == 0
//	 && ((ds_list_find_index(parsedCoordinates, square.coordinate) < 0 && square.distance < 0) 
//	 || parseDistance < square.distance))
//	{
//		//show_debug_message("Square is valid: " + string(square));
		
//		square.distance = parseDistance;
//		square.closestToTarget = source;
//		ds_queue_enqueue(parseQueue, square);
//		ds_list_add(parsedCoordinates, square.coordinate);
//	}
//	else if (square != 0 && square.character != 0
//		  && ((ds_list_find_index(parsedCoordinates, square.coordinate) < 0 && square.distance < 0) 
//		  || parseDistance < square.distance))
//	{
//		//show_debug_message("Square is invalid.");
		
//		square.image_alpha = 1;
//		square.activated = true;
		
//		if (square.interaction != 0)
//		{
//			square.image_blend = interactionColor;
//		}
//		else if (square.character.characterStats.team == CharacterTeams.Ally)
//		{
//			square.image_blend = c_lime;
//		}
//		else if (square.character.characterStats.team == CharacterTeams.Enemy)
//		{
//			square.image_blend = c_red;
//		}
//		else if (square.character.characterStats.team == CharacterTeams.Neutral)
//		{
//			square.image_blend = c_blue;
//		}
		
//		if (square.character.characterStats.team == activeCharacter.characterStats.team)
//		{
//			ds_queue_enqueue(parseQueue, square);
//		}
		
//		square.distance = parseDistance;
//		square.closestToTarget = source;
//		ds_list_add(activatedSquares, square);
//		ds_list_add(parsedCoordinates, square.coordinate);
//	}
//}