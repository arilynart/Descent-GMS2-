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

moveTarget = false;

validRange = true;
range = {}
with (range)
{
	right = 0;
	downRight = 0;
	down = 0;
	downLeft = 0;
	left = 0;
	upLeft = 0;
	up = 0;
	upRight = 0;
}
flying = {}
with (flying)
{
	right = 0;
	downRight = 0;
	down = 0;
	downLeft = 0;
	left = 0;
	upLeft = 0;
	up = 0;
	upRight = 0;
}

coordinate = 
{
	x : -1,
	y : -1
}

distance = -1;

closestToTarget = self;

character = 0;

activatedSquares = ds_list_create();

parsedCoordinates = ds_list_create();
parseQueue = ds_queue_create();

activated = false;

interaction = 0;

encounterTrigger = -1;

highlightArray = ds_list_create();
dehighlightArray = ds_list_create();

interactionColor = c_fuchsia;

#region Activation

function Activate(start, maxDistance, activeCharacter) 
{
	show_debug_message("Activating grid from: " + string(start.coordinate) + " with a distance of " + string(maxDistance));
	
	ds_queue_clear(parseQueue);
	ds_list_clear(parsedCoordinates);
	ds_list_clear(activatedSquares);
	
	ds_queue_enqueue(parseQueue, start);
	ds_list_add(parsedCoordinates, start.coordinate);
	start.distance = 0;
	
	while (!ds_queue_empty(parseQueue))
	{
		var currentSquare = ds_queue_dequeue(parseQueue);
		currentSquare.activated = true;
		
		if (currentSquare.moveTarget) currentSquare.image_blend = c_black;
		else if (currentSquare.interaction != 0)
		{
			currentSquare.image_blend = interactionColor;
			currentSquare.image_alpha = 1;
		}
		else if (currentSquare.character != 0)
		{
			currentSquare.image_alpha = 1;
			if (currentSquare.character.characterStats.team == CharacterTeams.Ally)
			{
				currentSquare.image_blend = c_lime;
			}
			else if (currentSquare.character.characterStats.team == CharacterTeams.Enemy)
			{
				currentSquare.image_blend = c_red;
			}
			else if (currentSquare.character.characterStats.team == CharacterTeams.Neutral)
			{
				currentSquare.image_blend = c_blue;
			}
		}
		else
		{
			currentSquare.image_alpha = 0.3;
			currentSquare.image_blend = c_white;
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
				ParseSquare(currentSquare.right, nextDistance, currentSquare, activeCharacter);
			}
			//down
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.down, nextDistance, currentSquare, activeCharacter);
			}
			//left
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.left, nextDistance, currentSquare, activeCharacter);
			}
			//up
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.up, nextDistance, currentSquare, activeCharacter);
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
				ParseSquare(currentSquare.downRight, nextDistance, currentSquare, activeCharacter);
			}
			//downleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.downLeft, nextDistance, currentSquare, activeCharacter);
			}
			//upleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.upLeft, nextDistance, currentSquare, activeCharacter);
			}
			//upright
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.upRight, nextDistance, currentSquare, activeCharacter);
			}
		}
	}
}

function Deactivate()
{
	var size = ds_list_size(activatedSquares);
	
	for (var i = 0; i < size; i++)
	{
		var sq = ds_list_find_value(activatedSquares, i);
		sq.image_alpha = 0;
		sq.image_blend = c_white;
		sq.distance = -1;
		sq.activated = false;
		sq.closestToTarget = 0;
		if (sq.character == map.movingCharacter) map.movingCharacter = 0;
	}
	
	ds_list_clear(activatedSquares);
}

function ParseSquare(square, parseDistance, source, activeCharacter)
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
		else if (square.character.characterStats.team == CharacterTeams.Ally)
		{
			square.image_blend = c_lime;
		}
		else if (square.character.characterStats.team == CharacterTeams.Enemy)
		{
			square.image_blend = c_red;
		}
		else if (square.character.characterStats.team == CharacterTeams.Neutral)
		{
			square.image_blend = c_blue;
		}
		
		if (square.character.characterStats.team == activeCharacter.characterStats.team)
		{
			ds_queue_enqueue(parseQueue, square);
		}
		
		square.distance = parseDistance;
		square.closestToTarget = source;
		ds_list_add(activatedSquares, square);
		ds_list_add(parsedCoordinates, square.coordinate);
	}
}

function ActivateRange(start, maxDistance, activeCharacter) 
{
	show_debug_message("Activating grid from: " + string(start.coordinate) + " with a distance of " + string(maxDistance));
	
	ds_queue_clear(parseQueue);
	ds_list_clear(parsedCoordinates);
	ds_list_clear(activatedSquares);
	
	ds_queue_enqueue(parseQueue, start);
	ds_list_add(parsedCoordinates, start.coordinate);
	start.distance = 0;
	
	while (!ds_queue_empty(parseQueue))
	{
		var currentSquare = ds_queue_dequeue(parseQueue);
		
		if (currentSquare.validRange)
		{
			
			if (currentSquare.moveTarget) currentSquare.image_blend = c_black;
			else if (currentSquare.interaction != 0)
			{
				currentSquare.image_blend = interactionColor;
				currentSquare.image_alpha = 1;
			}
			else if (currentSquare.character != 0)
			{
				currentSquare.image_alpha = 1;
				if (currentSquare.character.characterStats.team == CharacterTeams.Ally)
				{
					currentSquare.image_blend = c_lime;
				}
				else if (currentSquare.character.characterStats.team == CharacterTeams.Enemy)
				{
					currentSquare.image_blend = c_red;
				}
				else if (currentSquare.character.characterStats.team == CharacterTeams.Neutral)
				{
					currentSquare.image_blend = c_blue;
				}
			}
			else
			{
				currentSquare.image_alpha = 0.3;
				currentSquare.image_blend = c_white;
			}
			currentSquare.activated = true;
			
		}
		ds_list_add(activatedSquares, currentSquare);
		var nextDistance = currentSquare.distance + 1;
		
		
		var targetX = -1;
		var targetY = -1;
		
		//straight
		
		
		if (nextDistance <= maxDistance)
		{
			//right
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseRange(currentSquare.range.right, nextDistance, currentSquare, activeCharacter);
			}
			//down
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseRange(currentSquare.range.down, nextDistance, currentSquare, activeCharacter);
			}
			//left
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseRange(currentSquare.range.left, nextDistance, currentSquare, activeCharacter);
			}
			//up
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseRange(currentSquare.range.up, nextDistance, currentSquare, activeCharacter);
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
				ParseRange(currentSquare.range.downRight, nextDistance, currentSquare, activeCharacter);
			}
			//downleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseRange(currentSquare.range.downLeft, nextDistance, currentSquare, activeCharacter);
			}
			//upleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseRange(currentSquare.range.upLeft, nextDistance, currentSquare, activeCharacter);
			}
			//upright
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseRange(currentSquare.range.upRight, nextDistance, currentSquare, activeCharacter);
			}
		}
	}
}

function ParseRange(square, parseDistance, source, activeCharacter)
{
	//show_debug_message("Parsing Square: " + string(square));
	if (square != 0 && ((ds_list_find_index(parsedCoordinates, square.coordinate) < 0 && square.distance < 0) 
	 || parseDistance < square.distance))
	{
		//show_debug_message("Square is valid: " + string(square));
		
		square.distance = parseDistance;
		square.closestToTarget = source;
		ds_queue_enqueue(parseQueue, square);
		ds_list_add(parsedCoordinates, square.coordinate);
	}
}

function ActivateFlying(start, maxDistance, activeCharacter) 
{
	show_debug_message("Activating flying from: " + string(start.coordinate) + " with a distance of " + string(maxDistance));
	
	ds_queue_clear(parseQueue);
	ds_list_clear(parsedCoordinates);
	ds_list_clear(activatedSquares);
	
	ds_queue_enqueue(parseQueue, start);
	ds_list_add(parsedCoordinates, start.coordinate);
	start.distance = 0;
	
	while (!ds_queue_empty(parseQueue))
	{
		var currentSquare = ds_queue_dequeue(parseQueue);
		
		if (currentSquare.validRange)
		{
			if (currentSquare.moveTarget) currentSquare.image_blend = c_black;
			else if (currentSquare.interaction != 0)
			{
				currentSquare.image_blend = interactionColor;
				currentSquare.image_alpha = 1;
			}
			else if (currentSquare.character != 0)
			{
				currentSquare.image_alpha = 1;
				if (currentSquare.character.characterStats.team == CharacterTeams.Ally)
				{
					currentSquare.image_blend = c_lime;
				}
				else if (currentSquare.character.characterStats.team == CharacterTeams.Enemy)
				{
					currentSquare.image_blend = c_red;
				}
				else if (currentSquare.character.characterStats.team == CharacterTeams.Neutral)
				{
					currentSquare.image_blend = c_blue;
				}
			}
			else
			{
				currentSquare.image_alpha = 0.3;
				currentSquare.image_blend = c_white;
			}
			currentSquare.activated = true;
			
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
				ParseSquare(currentSquare.flying.right, nextDistance, currentSquare, activeCharacter);
			}
			//down
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.flying.down, nextDistance, currentSquare, activeCharacter);
			}
			//left
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.flying.left, nextDistance, currentSquare, activeCharacter);
			}
			//up
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.flying.up, nextDistance, currentSquare, activeCharacter);
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
				ParseSquare(currentSquare.flying.downRight, nextDistance, currentSquare, activeCharacter);
			}
			//downleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.flying.downLeft, nextDistance, currentSquare, activeCharacter);
			}
			//upleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.flying.upLeft, nextDistance, currentSquare, activeCharacter);
			}
			//upright
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(currentSquare.flying.upRight, nextDistance, currentSquare, activeCharacter);
			}
		}
	}
}

#endregion

function Select()
{
	show_debug_message("Select Square: " + string(coordinate.x) + ", " + string(coordinate.y));
	if (global.SelectSquareExecute != 0)
	{
		show_debug_message("Selected square has an execute method.");
		if (activated)
		{
			if (interaction == 0)
			{
				show_debug_message("Square is activated and there is no interaction on square. Executing...");
				global.SelectSquareExecute(self);
			}
		}
		else
		{
			show_debug_message("Square is not activated. Deactivating and resetting.");
			global.selectedCharacter.currentSquare.Deactivate();
			global.SelectSquareExecute = 0;
			global.UiManager.heldAbility = 0;
		}
		return;
	}

	if (character != 0) 
	{
		show_debug_message("Selected square has a character.");
		if (global.selectedCharacter != 0) global.selectedCharacter.currentSquare.Deactivate();
		
		global.cameraTarget.followingCharacter = character;
		global.selectedCharacter = character;
		//selected character. highlight grid for movement.
		if (activated == false && character.moving == false
		 && global.InCombat && character.maxMove > 0
		 && character.characterStats.team == CharacterTeams.Ally
		 && character.moveLock == false)
		{
			show_debug_message("Character can move. Highlighting move options.");
			if (map.movingCharacter != 0)
			{
				map.movingCharacter.currentSquare.Deactivate();
				map.movingCharacter = 0;
			}
			
			global.selectedSquare = self;
			map.movingCharacter = character;
			if (character.characterStats.flying) ActivateFlying(self, character.maxMove, character);
			else Activate(self, character.maxMove, character);
		}
	}
	else if (activated && interaction != 0)
	{
		interaction.Execute(self, interaction);
	}
	else if (activated && map.movingCharacter != 0 && character == 0 && interaction == 0 && !moveTarget)
	{
		//if a character is already selected and we're waiting to move, move.
		show_debug_message("Moving " + string(map.movingCharacter) + " to " + string(coordinate));
		map.movingCharacter.moveLock = true;
		
		moveTarget = true;
		
		var moveEffect = global.BaseEffect();
		moveEffect.character = map.movingCharacter;
		moveEffect.target = self;
		moveEffect.Start = method(global, global.MoveEffect);
		
		AddEffect(moveEffect);
		
		map.movingCharacter = 0;
	}
}