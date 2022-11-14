/// @description Initialize variables. Definition for square activation.
map = instance_find(obj_Map, 0);

enum ParseTypes
{
	Standard,
	Melee,
	Range,
	Flying
}

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

character = 0;

activated = false;

interaction = 0;

encounterTrigger = -1;

highlightArray = ds_list_create();
dehighlightArray = ds_list_create();

interactionColor = c_fuchsia;

#region Activation

Activate = function(maxDistance, activeCharacter, parseType)
{
	//initialize
	var array = array_create(0);
	
	var parseQueue = ds_queue_create();
	var parsedCoordinates = ds_list_create();
	
	var parsedStart = BaseParse(id, 0, 0);
	
	ds_queue_enqueue(parseQueue, parsedStart);
	
	//loop
	while (!ds_queue_empty(parseQueue))
	{
		var struct = ds_queue_dequeue(parseQueue);
		
		switch (parseType)
		{
			case ParseTypes.Standard:
				var adjacentCheck = struct.square;
			break;
			case ParseTypes.Melee:
				var adjacentCheck = struct.square;
			break;
			case ParseTypes.Range:
				var adjacentCheck = struct.square.range;
			break;
			case ParseTypes.Flying:
				var adjacentCheck = struct.square.flying;
			break;
		}
		
		array_push(array, struct);
		
		var targetX = -1;
		var targetY = -1;
		
		var nextDistance = struct.distance + 1;
		
		if (nextDistance <= maxDistance)
		{
			//right
			targetX = struct.coordinate.x + 1;
			targetY = struct.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(adjacentCheck.right, nextDistance, struct, activeCharacter, parseQueue, parsedCoordinates, parseType);
			}
			//down
			targetX = struct.coordinate.x;
			targetY = struct.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(adjacentCheck.down, nextDistance, struct, activeCharacter, parseQueue, parsedCoordinates, parseType);
			}
			//left
			targetX = struct.coordinate.x - 1;
			targetY = struct.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(adjacentCheck.left, nextDistance, struct, activeCharacter, parseQueue, parsedCoordinates, parseType);
			}
			//up
			targetX = struct.coordinate.x;
			targetY = struct.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
			{
				ParseSquare(adjacentCheck.up, nextDistance, struct, activeCharacter, parseQueue, parsedCoordinates, parseType);
			}
			
			nextDistance = struct.distance + 1.5;
			if (nextDistance <= maxDistance)
			{
				//downright
				targetX = struct.coordinate.x + 1;
				targetY = struct.coordinate.y + 1;
				if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
				{
					ParseSquare(adjacentCheck.downRight, nextDistance, struct, activeCharacter, parseQueue, parsedCoordinates, parseType);
				}
				//downleft
				targetX = struct.coordinate.x - 1;
				targetY = struct.coordinate.y + 1;
				if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
				{
					ParseSquare(adjacentCheck.downLeft, nextDistance, struct, activeCharacter, parseQueue, parsedCoordinates, parseType);
				}
				//upleft
				targetX = struct.coordinate.x - 1;
				targetY = struct.coordinate.y - 1;
				if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
				{
					ParseSquare(adjacentCheck.upLeft, nextDistance, struct, activeCharacter, parseQueue, parsedCoordinates, parseType);
				}
				//upright
				targetX = struct.coordinate.x + 1;
				targetY = struct.coordinate.y - 1;
				if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridHeight)
				{
					ParseSquare(adjacentCheck.upRight, nextDistance, struct, activeCharacter, parseQueue, parsedCoordinates, parseType);
				}
			}
		}
	}
	
	//cleanup
	
	ds_queue_destroy(parseQueue);
	ds_list_destroy(parsedCoordinates);
	
	//return
	
	return array;
}

BaseParse = function(square, parseDistance, source)
{
	var parseStruct =
	{
		coordinate : square.coordinate,
		square : square,
		distance : parseDistance,
		closestToTarget : source
	}
	return parseStruct;
}

function ParseSquare(square, parseDistance, source, activeCharacter, parseQueue, parsedCoordinates, parseType)
{
	var parseCheck = CheckParseDistance(parsedCoordinates, square, parseDistance);
	if (square != 0
	&& (!AlreadyParsed(parsedCoordinates, square) || parseCheck))
	{
		if (parseType != ParseTypes.Standard || square.character == 0 || square.character.characterStats.team == activeCharacter.characterStats.team)
		{
			var parseStruct = BaseParse(square, parseDistance, source);
		
			ds_queue_enqueue(parseQueue, parseStruct);
			if (parseCheck) DeleteExistingParse(parsedCoordinates, square);
			ds_list_add(parsedCoordinates, parseStruct);
		}
	}
}

function DeleteExistingParse(parsedCoordinates, square)
{
	for (var i = 0; i < ds_list_size(parsedCoordinates); i++)
	{
		var checkParse = ds_list_find_value(parsedCoordinates, i);
		
		if (checkParse.square == square)
		{
			ds_list_delete(parsedCoordinates, i);
		}
	}
}

AlreadyParsed = function(parsedCoordinates, square)
{
	for (var i = 0; i < ds_list_size(parsedCoordinates); i++)
	{
		var checkParse = ds_list_find_value(parsedCoordinates, i);
		
		if (checkParse.square == square)
		{
			return true;
		}
	}
	return false;
}

CheckParseDistance = function(parsedCoordinates, square, parseDistance)
{
	for (var i = 0; i < ds_list_size(parsedCoordinates); i++)
	{
		var checkParse = ds_list_find_value(parsedCoordinates, i);
		
		if (checkParse.square == square && checkParse.distance > parseDistance)
		{
			return true;
		}
	}
	return false;
}

function HighlightActivation(array)
{
	for (var i = 0; i < array_length(array); i++)
	{
		var currentSquare = array[i].square;
		
		if (currentSquare.validRange)
		{
			currentSquare.activated = true;
			if (currentSquare.moveTarget) currentSquare.image_blend = c_black;
			else if (currentSquare.interaction != 0)
			{
				currentSquare.image_blend = interactionColor;
				currentSquare.image_alpha = 0.6;
			}
			else if (currentSquare.character != 0)
			{
				currentSquare.image_alpha = 0.6;
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
		}
	}
}

function Deactivate(array)
{
	var size = array_length(array);
	
	for (var i = 0; i < size; i++)
	{
		var struct = array[i];
		var sq = struct.square;
		sq.image_alpha = 0;
		sq.image_blend = c_white;
		sq.activated = false;
		if (sq.character == map.movingCharacter) map.movingCharacter = 0;
	}
}

CheckSquare = function(square, array)
{
	//show_debug_message("Checking square against array with " + string(array_length(array)) + " squares.");
	for (var i = 0; i < array_length(array); i++)
	{
		var currentSquare = array[i].square;
		
		if (square == currentSquare) return array[i];
	}
	return 0;
}

CheckValidSelection = function(square, array)
{
	if (square != 0 && array != 0)
	{
		for (var i = 0; i < array_length(array); i++)
		{
			var struct = array[i];
			if (struct != 0 && struct.square == square)
			{
				return true;
			}
		}
	}
	return false;
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
			if (global.selectedCharacter.storedActivation != 0) global.selectedCharacter.currentSquare.Deactivate(global.selectedCharacter.storedActivation);
			global.SelectSquareExecute = 0;
			global.UiManager.heldAbility = 0;
		}
		return;
	}

	if (character != 0) 
	{
		show_debug_message("Selected square has a character.");
		if (global.selectedCharacter != 0 && global.selectedCharacter.storedActivation != 0) global.selectedCharacter.currentSquare.Deactivate(global.selectedCharacter.storedActivation);
		
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
				map.movingCharacter.currentSquare.Deactivate(map.movingCharacter.storedActivation);
				map.movingCharacter = 0;
			}
			
			global.selectedSquare = self;
			map.movingCharacter = character;
			
			if (character.characterStats.flying) var type = ParseTypes.Flying;
			else var type = ParseTypes.Standard;
			
			character.storedActivation = Activate(character.maxMove, character, type);
			show_debug_message(string(character) + " stored " + string(array_length(character.storedActivation)) + " squares in activation.");
			HighlightActivation(character.storedActivation);
		}
	}
	else if (activated && interaction != 0)
	{
		interaction.Execute(self, interaction);
	}
	else if (map.movingCharacter != 0  && CheckValidSelection(id, map.movingCharacter.storedActivation) 
	      && character == 0 && interaction == 0 && !moveTarget && validRange)
	{
		//if a character is already selected and we're waiting to move, move.
		show_debug_message("Moving " + string(map.movingCharacter) + " to " + string(coordinate));
		map.movingCharacter.moveLock = true;
		
		moveTarget = true;
		
		var activationArray = array_create(0);
		var length = array_length(map.movingCharacter.storedActivation);
		array_copy(activationArray, 0, map.movingCharacter.storedActivation, 0, length);
		
		var moveEffect = global.BaseEffect();
		moveEffect.character = map.movingCharacter;
		moveEffect.activation = activationArray;
		moveEffect.target = id;
		moveEffect.Start = method(global, global.MoveEffect);
		
		AddEffect(moveEffect);
		
		Deactivate(map.movingCharacter.storedActivation);
		map.movingCharacter.storedActivation = 0
		map.movingCharacter = 0;
	}
}

