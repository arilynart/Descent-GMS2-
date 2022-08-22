/// @description Generate the grid


//load blueprint
blueprint = 0;
blueprint = instance_find(obj_blu_MistyVeil, 0);

gridWidth = blueprint.mapWidth;
gridHeight = blueprint.mapHeight;
gridSize = 288;
gridPad = gridSize * blueprint.mapPad;

room_width = (gridWidth * gridSize) + (gridPad * 2);
room_height = (gridHeight * gridSize) + (gridPad * 2);

global.InCombat = false;
global.Combatants = ds_list_create();
global.Turns = ds_list_create();

movingCharacter = 0;

for (var i = 0; i < gridWidth; i++) 
{
	for (var j = 0; j < gridHeight; j++) 
	{
		var newSquare = instance_create_layer(gridPad + i * gridSize + gridSize / 2, 
											  gridPad + j * gridSize + gridSize / 2, 
											  "Squares", obj_Square);
		with(newSquare) 
		{
			coordinate =
			{
				x : i,
				y : j
			}
			image_alpha = 0;
		}
		squares[i,j] = newSquare;
		
		//show_debug_message("Square Created: " + string(squares[i,j].id));
	}
}

//link squares

for (var i = 0; i < gridWidth; i++) 
{
	for (var j = 0; j < gridHeight; j++)
	{
		var sq = squares[i,j];
		
		var targetX = -1;
		var targetY = -1;
		
		//right
		targetX = i + 1;
		targetY = j;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.right = squares[targetX, targetY];
		}
		//downRight
		targetX = i + 1;
		targetY = j + 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.downRight = squares[targetX, targetY];
		}
		//down
		targetX = i;
		targetY = j + 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.down = squares[targetX, targetY];
		}
		//downLeft
		targetX = i - 1;
		targetY = j + 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.downLeft = squares[targetX, targetY];
		}
		//left
		targetX = i - 1;
		targetY = j;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.left = squares[targetX, targetY];
		}
		//upLeft
		targetX = i - 1;
		targetY = j - 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.upLeft = squares[targetX, targetY];
		}
		//up
		targetX = i;
		targetY = j - 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.up = squares[targetX, targetY];
		}
		//upRight
		targetX = i + 1;
		targetY = j - 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.upRight = squares[targetX, targetY];
		}
		
		show_debug_message("Square gateways set: right: " + string(sq.right) 
			+ " downright: " + string(sq.downRight) + " down: " + string(sq.down) 
			+ " downleft: " + string(sq.downLeft) + " left: " + string(sq.left) + " upleft: "
			+ string(sq.upLeft) + " up: " + string(sq.up) + " upright: " + string(sq.upRight));
	}
}

//create points
for (var i = 0; i < gridWidth + 1; i++)
{
	for (var j = 0; j < gridHeight + 1; j++)
	{
		var newPoint = instance_create_layer(gridPad + (i * gridSize), 
											 gridPad + (j * gridSize), "Points", obj_Point);
		with(newPoint)
		{
			//map = self;
			coordinate =
			{
				x : i,
				y : j
			}
		}
		
		ds_list_add(blueprint.wallPoints, newPoint);
	}
}

//disconnect squares for walls
var wallSize = array_length(blueprint.walls);
for (var i = 0; i < wallSize; i++)
{
	var checkedWall = blueprint.walls[i];
	//find orientation of wall, then disconnect square accordingly. It can only be vertical or horizontal.
	
	var xDiff = abs(checkedWall.point1.x - checkedWall.point2.x);
	
	if (xDiff > 0)
	{
		var bottomSquare = 0;
		//horizontal
		if (checkedWall.point1.x < checkedWall.point2.x)
		{
			//oriented normally
			if (checkedWall.point1.x >= 0 && checkedWall.point1.x < gridWidth 
				&& checkedWall.point1.y >= 0 && checkedWall.point1.y < gridHeight)
			{
				bottomSquare = squares[checkedWall.point1.x, checkedWall.point1.y];
			}
		}
		else
		{
			//flipped
			if (checkedWall.point2.x >= 0 && checkedWall.point2.x < gridWidth 
				&& checkedWall.point2.y >= 0 && checkedWall.point2.y < gridHeight)
			{
				bottomSquare = squares[checkedWall.point2.x, checkedWall.point2.y];
			}
		}
		
			// x | v | x 
			//---1~~~2---
			// v | o | v 
			
		if (bottomSquare != 0)
		{
			if (bottomSquare.up != 0)
			{
				if (bottomSquare.up.down != 0)
				{
					bottomSquare.up.down = 0;
				}
				if (bottomSquare.up.downLeft != 0)
				{
					if (bottomSquare.up.downLeft.upRight != 0)
					{
						bottomSquare.up.downLeft.upRight = 0;
					}
					bottomSquare.up.downLeft = 0;
				}
				if (bottomSquare.up.downRight != 0)
				{
					if (bottomSquare.up.downRight.upLeft != 0)
					{
						bottomSquare.up.downRight.upLeft = 0;

					}
					bottomSquare.up.downRight = 0;
				}
				bottomSquare.up = 0;
			}
			if (bottomSquare.upRight != 0)
			{
				if (bottomSquare.upRight.downLeft != 0)
				{
					bottomSquare.upRight.downLeft = 0;
				}
				bottomSquare.upRight = 0;
			}
			if (bottomSquare.upLeft != 0)
			{
				if (bottomSquare.upLeft.downRight != 0)
				{
					bottomSquare.upLeft.downRight = 0;
				}
				bottomSquare.upLeft = 0;
			}
		
		}
	}
	else
	{
		//vertical
		
		var leftSquare = 0;
		//horizontal
		if (checkedWall.point1.y < checkedWall.point2.y)
		{
			//oriented normally
			if (checkedWall.point1.x - 1 >= 0 && checkedWall.point1.x - 1 < gridWidth 
				&& checkedWall.point1.y >= 0 && checkedWall.point1.y < gridHeight)
			{
				leftSquare = squares[checkedWall.point1.x - 1, checkedWall.point1.y];
			}

		}
		else
		{
			//flipped
			if (checkedWall.point2.x - 1 >= 0 && checkedWall.point2.x - 1 < gridWidth 
				&& checkedWall.point2.y >= 0 && checkedWall.point2.y < gridHeight)
			{
				leftSquare = squares[checkedWall.point2.x - 1, checkedWall.point2.y];
			}
		}
		
			// x | v | x 
			//---1~~~2---	(rotate 90 degrees clockwise)
			// v | o | v 
		if (leftSquare != 0)
		{
			if (leftSquare.right != 0)
			{
				if (leftSquare.right.left != 0)
				{
					leftSquare.right.left = 0;
				}
				if (leftSquare.right.upLeft != 0)
				{
					if (leftSquare.right.upLeft.downRight != 0)
					{
						leftSquare.right.upLeft.downRight = 0;
					}
				
					leftSquare.right.upLeft = 0;
				}
				if (leftSquare.right.downLeft != 0)
				{
					if (leftSquare.right.downLeft.upRight != 0)
					{
						leftSquare.right.downLeft.upRight = 0;
					}
				
					leftSquare.right.downLeft = 0;
				}

				leftSquare.right = 0;
			}
			if (leftSquare.downRight != 0)
			{
				if(leftSquare.downRight.upLeft != 0)
				{
					leftSquare.downRight.upLeft = 0;
				}
				leftSquare.downRight = 0;
			}
			if (leftSquare.upRight != 0)
			{
				if (leftSquare.upRight.downLeft != 0)
				{
					leftSquare.upRight.downLeft = 0;
				}
				leftSquare.upRight = 0;
			}
		}
	}
}

//interactables
var interactableSize = ds_list_size(blueprint.interactables);
for (var i = 0; i < interactableSize; i++)
{
	var interactable = ds_list_find_value(blueprint.interactables, i);
	var targetSquare = squares[interactable.x, interactable.y];
	
	targetSquare.interaction = interactable;
}

#region characters

spawnedCharacters = ds_list_create();

//player
var playerSpawnSquare = squares[blueprint.playerSpawnX, blueprint.playerSpawnY];
player = instance_create_layer(playerSpawnSquare.x, playerSpawnSquare.y, "Characters", obj_Character);
player.currentSquare = playerSpawnSquare;
playerSpawnSquare.character = player;
global.Player = player;
player.characterStats = global.FindCharacter(CharacterClass.Player, 0);
player.sprite_index = player.characterStats.sprite;
global.selectedCharacter = player;

global.Allies = array_create(0);
array_push(global.Allies, player);

cameraTarget = instance_create_layer(player.x, player.y, "AboveCharacters", obj_CameraTarget);

//blueprint characters

var characterSize = ds_list_size(blueprint.characters);
for (var i = 0; i < characterSize; i++)
{
	var cha = ds_list_find_value(blueprint.characters, i);
	var square = squares[cha.spawnX, cha.spawnY];
	var newCharacter = instance_create_layer(square.x, square.y, "Characters", obj_Character);
	square.character = newCharacter;
	newCharacter.currentSquare = square;
	newCharacter.characterStats = cha;
	newCharacter.sprite_index = cha.sprite;
	ds_list_add(spawnedCharacters, newCharacter);
}

#endregion

#region combat encounters

var combatSize = ds_list_size(blueprint.encounters);
for (var i = 0; i < combatSize; i++)
{
	var combat = ds_list_find_value(blueprint.encounters, i);
	
	//set triggers
	var triggerSize = ds_list_size(combat.triggers);
	for (var j = 0; j < triggerSize; j++)
	{
		var trigger = ds_list_find_value(combat.triggers, j);
		
		squares[trigger.x, trigger.y].encounterTrigger = i;
	}
}

#endregion