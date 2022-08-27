/// @description Initialize variables. Definition for square activation.
map = instance_find(obj_Map, 0);

global.grid = true;

right = 0;
downRight = 0;
down = 0;
downLeft = 0;
left = 0;
upLeft = 0;
up = 0;
upRight = 0;

coordinate = 
{
	x : -1,
	y : -1
}

distance = -1;

closestToTarget = self;

character = 0;

activatedSquares = ds_list_create();

parsedCoordinates = ds_list_create
parseQueue = ds_queue_create();

activated = false;

interaction = 0;

encounterTrigger = -1;

highlightArray = 0;
dehighlightArray = 0;

interactionColor = c_fuchsia;

#region Activation

function Activate(start, maxDistance) 
{
	show_debug_message("Activating grid from: " + string(start.coordinate) + " with a distance of " + string(maxDistance));
	
	parseQueue = ds_queue_create();
	parsedCoordinates = ds_list_create();
	activatedSquares = ds_list_create();
	
	ds_queue_enqueue(parseQueue, start);
	ds_list_add(parsedCoordinates, start.coordinate);
	start.distance = 0;
	
	while (!ds_queue_empty(parseQueue))
	{
		var currentSquare = ds_queue_dequeue(parseQueue);
		currentSquare.image_alpha = 0.3;
		currentSquare.activated = true;
		
		if (currentSquare.interaction != 0)
		{
			currentSquare.image_blend = interactionColor;
			currentSquare.image_alpha = 1;
		}
		
		ds_list_add(activatedSquares, currentSquare);
		
		var targetX = -1;
		var targetY = -1;
		
		//straight
		var nextDistance = currentSquare.distance + 1;
		
		if (nextDistance <= maxDistance)
		{
			//right
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.right, nextDistance, currentSquare);
			}
			//down
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.down, nextDistance, currentSquare);
			}
			//left
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.left, nextDistance, currentSquare);
			}
			//up
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.up, nextDistance, currentSquare);
			}
		}
		
		nextDistance = currentSquare.distance + 1.5;
		if (nextDistance <= maxDistance)
		{
			//downright
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.downRight, nextDistance, currentSquare);
			}
			//downleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.downLeft, nextDistance, currentSquare);
			}
			//upleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.upLeft, nextDistance, currentSquare);
			}
			//upright
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.upRight, nextDistance, currentSquare);
			}
		}
	}
}

function Deactivate()
{
	var size = ds_list_size(activatedSquares);
	
	for (i = 0; i < size; i++)
	{
		var sq = ds_list_find_value(activatedSquares, i);
		sq.image_alpha = 0;
		sq.image_blend = c_white;
		sq.distance = -1;
		sq.activated = false;
		sq.closestToTarget = 0;
		if (sq.character == map.movingCharacter) map.movingCharacter = 0;
	}
}

function ParseSquare(square, parseDistance, source)
{
	//show_debug_message("Parsing Square: " + string(square));
	if (square != 0 && square.character == 0
	 && ((ds_list_find_index(parsedCoordinates, square.coordinate) < 0 && square.distance < 0) 
	 || parseDistance < square.distance))
	{
		//show_debug_message("Square is valid: " + string(square));
		
		square.distance = parseDistance;
		square.closestToTarget = source;
		ds_queue_enqueue(parseQueue, square);
		ds_list_add(parsedCoordinates, square.coordinate);
	}
	else if (square != 0 && square.character != 0
		  && ((ds_list_find_index(parsedCoordinates, square.coordinate) < 0 && square.distance < 0) 
		  || parseDistance < square.distance))
	{
		//show_debug_message("Square is invalid.");
		
		square.image_alpha = 1;
		square.activated = true;
		
		if (square.interaction != 0)
		{
			square.image_blend = interactionColor;
			
		}
		else
		{
			square.image_blend = c_lime;
		}
		
		square.distance = parseDistance;
		square.closestToTarget = source;
		ds_list_add(activatedSquares, square);
		ds_list_add(parsedCoordinates, square.coordinate);
	}
}
#endregion

function Select()
{
	show_debug_message("Select Square: " + string(coordinate.x) + ", " + string(coordinate.y));
	if (activated && global.SelectSquareExecute != 0)
	{
		if (interaction == 0)
		{
			global.SelectSquareExecute(self);
		}
		return;
	}

	if (character != 0) 
	{
		if (global.selectedCharacter != 0) global.selectedCharacter.currentSquare.Deactivate();
		
		global.cameraTarget.followingCharacter = character;
		global.selectedCharacter = character;
		//selected character. highlight grid for movement.
		if (activated == false && character.moving == false && character.aiMind == 0
		 && global.InCombat && character == ds_list_find_value(global.Turns, 0).character)
		{
			if (map.movingCharacter != 0)
			{
				map.movingCharacter.currentSquare.Deactivate();
				map.movingCharacter = 0;
			}
			
			global.selectedSquare = self;
			map.movingCharacter = character;
			Activate(self, character.maxMove);
		}
	}
	else if (activated && interaction != 0)
	{
		interaction.Execute(interaction);
	}
	else if (activated && map.movingCharacter != 0 && character == 0 && interaction == 0)
	{
		//if a character is already selected and we're waiting to move, move.
		show_debug_message("Moving " + string(map.movingCharacter) + " to " + string(coordinate));
		
		var moveEffect = global.BaseEffect();
		moveEffect.character = map.movingCharacter;
		moveEffect.target = self;
		moveEffect.Start = method(global, global.MoveEffect);
		
		AddEffect(moveEffect);
		
		map.movingCharacter = 0;
		
		AutoEndTurn();
	}
}