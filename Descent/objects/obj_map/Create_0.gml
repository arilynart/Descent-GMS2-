/// @description Generate the grid


randomize();

//load textures
var textureArray = texturegroup_get_textures("CardAssets");
for (var i = 0; i < array_length(textureArray); ++i;)
{
    texture_prefetch(textureArray[i]);
}

//load blueprint
blueprint = 0;
blueprint = instance_find(obj_blu_MistyVeil, 0);

gridSize = 288;
gridWidth = (room_width / gridSize) - (blueprint.mapPad * 2);
gridHeight = (room_height / gridSize) - (blueprint.mapPad * 2);

gridPad = gridSize * blueprint.mapPad;


global.InCombat = false;
global.Combatants = ds_list_create();
global.Turns = ds_list_create();
global.BondedMonsters = ds_list_create();

movingCharacter = 0;

aiMindIndices = ds_list_create();
aiMinds = ds_list_create();

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
			sq.range.right = squares[targetX, targetY];
			sq.flying.right = squares[targetX, targetY];
		}
		//downRight
		targetX = i + 1;
		targetY = j + 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.downRight = squares[targetX, targetY];
			sq.range.downRight = squares[targetX, targetY];
			sq.flying.downRight = squares[targetX, targetY];
		}
		//down
		targetX = i;
		targetY = j + 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.down = squares[targetX, targetY];
			sq.range.down = squares[targetX, targetY];
			sq.flying.down = squares[targetX, targetY];
		}
		//downLeft
		targetX = i - 1;
		targetY = j + 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.downLeft = squares[targetX, targetY];
			sq.range.downLeft = squares[targetX, targetY];
			sq.flying.downLeft = squares[targetX, targetY];
		}
		//left
		targetX = i - 1;
		targetY = j;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.left = squares[targetX, targetY];
			sq.range.left = squares[targetX, targetY];
			sq.flying.left = squares[targetX, targetY];
		}
		//upLeft
		targetX = i - 1;
		targetY = j - 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.upLeft = squares[targetX, targetY];
			sq.range.upLeft = squares[targetX, targetY];
			sq.flying.upLeft = squares[targetX, targetY];
		}
		//up
		targetX = i;
		targetY = j - 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.up = squares[targetX, targetY];
			sq.range.up = squares[targetX, targetY];
			sq.flying.up = squares[targetX, targetY];
		}
		//upRight
		targetX = i + 1;
		targetY = j - 1;
		if (targetX >= 0 && targetX < gridWidth && targetY >= 0 && targetY < gridHeight)
		{
			sq.upRight = squares[targetX, targetY];
			sq.range.upRight = squares[targetX, targetY];
			sq.flying.upRight = squares[targetX, targetY];
		}
		
		//show_debug_message("Square gateways set: right: " + string(sq.range.right) 
		//	+ " downright: " + string(sq.range.downRight) + " down: " + string(sq.range.down) 
		//	+ " downleft: " + string(sq.range.downLeft) + " left: " + string(sq.range.left) + " upleft: "
		//	+ string(sq.range.upLeft) + " up: " + string(sq.range.up) + " upright: " + string(sq.range.upRight));
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

var wallSize = array_length(blueprint.rangeWalls);
for (var i = 0; i < wallSize; i++)
{
	var checkedWall = blueprint.rangeWalls[i];
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
		switch (checkedWall.type)
		{
			case RangeWallTypes.AllowUpToDown:
				if (bottomSquare != 0)
				{
					if (bottomSquare.range.up != 0)
					{
						if (bottomSquare.range.up.range.downLeft != 0)
						{
							if (bottomSquare.range.up.range.downLeft.range.upRight != 0)
							{
								bottomSquare.range.up.range.downLeft.range.upRight = 0;
							}
						}
						if (bottomSquare.range.up.range.downRight != 0)
						{
							if (bottomSquare.range.up.range.downRight.range.upLeft != 0)
							{
								bottomSquare.range.up.range.downRight.range.upLeft = 0;

							}
						}
						bottomSquare.range.up = 0;
					}
					if (bottomSquare.range.upRight != 0)
					{
						bottomSquare.range.upRight = 0;
					}
					if (bottomSquare.range.upLeft != 0)
					{
						bottomSquare.range.upLeft = 0;
					}
		
				}
			break;
			default:
				//show_debug_message("Default: block all connections : " + string(bottomSquare));
				if (bottomSquare != 0)
				{
					if (bottomSquare.range.up != 0)
					{
						if (bottomSquare.range.up.range.down != 0)
						{
							bottomSquare.range.up.range.down = 0;
						}
						if (bottomSquare.range.up.range.downLeft != 0)
						{
							if (bottomSquare.range.up.range.downLeft.range.upRight != 0)
							{
								bottomSquare.range.up.range.downLeft.range.upRight = 0;
							}
							bottomSquare.range.up.range.downLeft = 0;
						}
						if (bottomSquare.range.up.range.downRight != 0)
						{
							if (bottomSquare.range.up.range.downRight.range.upLeft != 0)
							{
								bottomSquare.range.up.range.downRight.range.upLeft = 0;

							}
							bottomSquare.range.up.range.downRight = 0;
						}
						bottomSquare.range.up = 0;
					}
					if (bottomSquare.range.upRight != 0)
					{
						if (bottomSquare.range.upRight.range.downLeft != 0)
						{
							bottomSquare.range.upRight.range.downLeft = 0;
						}
						bottomSquare.range.upRight = 0;
					}
					if (bottomSquare.range.upLeft != 0)
					{
						if (bottomSquare.range.upLeft.range.downRight != 0)
						{
							bottomSquare.range.upLeft.range.downRight = 0;
						}
						bottomSquare.range.upLeft = 0;
					}
		
				}
			break;
			
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
			
		switch (checkedWall.type)
		{
			case RangeWallTypes.AllowLeftToRight:
				if (leftSquare != 0)
				{
					if (leftSquare.range.right != 0)
					{
						if (leftSquare.range.right.range.left != 0)
						{
							leftSquare.range.right.range.left = 0;
						}
						if (leftSquare.range.right.range.upLeft != 0)
						{
				
							leftSquare.range.right.range.upLeft = 0;
						}
						if (leftSquare.range.right.range.downLeft != 0)
						{
				
							leftSquare.range.right.range.downLeft = 0;
						}
					}
					if (leftSquare.range.downRight != 0)
					{
						if(leftSquare.range.downRight.range.upLeft != 0)
						{
							leftSquare.range.downRight.range.upLeft = 0;
						}
					}
					if (leftSquare.range.upRight != 0)
					{
						if (leftSquare.range.upRight.range.downLeft != 0)
						{
							leftSquare.range.upRight.range.downLeft = 0;
						}
					}
				}
			break;
			case RangeWallTypes.AllowRightToLeft:
				if (leftSquare != 0)
				{
					if (leftSquare.range.right != 0)
					{
						if (leftSquare.range.right.range.upLeft != 0)
						{
							if (leftSquare.range.right.range.upLeft.range.downRight != 0)
							{
								leftSquare.range.right.range.upLeft.range.downRight = 0;
							}
						}
						if (leftSquare.range.right.range.downLeft != 0)
						{
							if (leftSquare.range.right.range.downLeft.range.upRight != 0)
							{
								leftSquare.range.right.range.downLeft.range.upRight = 0;
							}
			
						}

						leftSquare.range.right = 0;
					}
					if (leftSquare.range.downRight != 0)
					{
						leftSquare.range.downRight = 0;
					}
					if (leftSquare.range.upRight != 0)
					{
						leftSquare.range.upRight = 0;
					}
				}
			break;
			default:
				//show_debug_message("Default: block all connections : " + string(leftSquare));
				if (leftSquare != 0)
				{
					if (leftSquare.range.right != 0)
					{
						if (leftSquare.range.right.range.left != 0)
						{
							leftSquare.range.right.range.left = 0;
						}
						if (leftSquare.range.right.range.upLeft != 0)
						{
							if (leftSquare.range.right.range.upLeft.range.downRight != 0)
							{
								leftSquare.range.right.range.upLeft.range.downRight = 0;
							}
				
							leftSquare.range.right.range.upLeft = 0;
						}
						if (leftSquare.range.right.range.downLeft != 0)
						{
							if (leftSquare.range.right.range.downLeft.range.upRight != 0)
							{
								leftSquare.range.right.range.downLeft.range.upRight = 0;
							}
				
							leftSquare.range.right.range.downLeft = 0;
						}

						leftSquare.range.right = 0;
					}
					if (leftSquare.range.downRight != 0)
					{
						if(leftSquare.range.downRight.range.upLeft != 0)
						{
							leftSquare.range.downRight.range.upLeft = 0;
						}
						leftSquare.range.downRight = 0;
					}
					if (leftSquare.range.upRight != 0)
					{
						if (leftSquare.range.upRight.range.downLeft != 0)
						{
							leftSquare.range.upRight.range.downLeft = 0;
						}
						leftSquare.range.upRight = 0;
					}
				}
			break;
		}
		
	}
}

for (var i = 0; i < array_length(blueprint.invalidRange); i++)
{
	var range = blueprint.invalidRange[i];
	var square = squares[range.x, range.y];
	square.validRange = false;
	show_debug_message("Square invalidated at: " + string(range.x) + ", " + string(range.y) + " | Result is: " + string(square.validRange));
}

var wallSize = array_length(blueprint.flyingWalls);
for (var i = 0; i < wallSize; i++)
{
	var checkedWall = blueprint.flyingWalls[i];
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
			if (bottomSquare.flying.up != 0)
			{
				if (bottomSquare.flying.up.flying.down != 0)
				{
					bottomSquare.flying.up.flying.down = 0;
				}
				if (bottomSquare.flying.up.flying.downLeft != 0)
				{
					if (bottomSquare.flying.up.flying.downLeft.flying.upRight != 0)
					{
						bottomSquare.flying.up.flying.downLeft.flying.upRight = 0;
					}
					bottomSquare.flying.up.flying.downLeft = 0;
				}
				if (bottomSquare.flying.up.flying.downRight != 0)
				{
					if (bottomSquare.flying.up.flying.downRight.flying.upLeft != 0)
					{
						bottomSquare.flying.up.flying.downRight.flying.upLeft = 0;

					}
					bottomSquare.flying.up.flying.downRight = 0;
				}
				bottomSquare.flying.up = 0;
			}
			if (bottomSquare.flying.upRight != 0)
			{
				if (bottomSquare.flying.upRight.flying.downLeft != 0)
				{
					bottomSquare.flying.upRight.flying.downLeft = 0;
				}
				bottomSquare.flying.upRight = 0;
			}
			if (bottomSquare.flying.upLeft != 0)
			{
				if (bottomSquare.flying.upLeft.flying.downRight != 0)
				{
					bottomSquare.flying.upLeft.flying.downRight = 0;
				}
				bottomSquare.flying.upLeft = 0;
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
			if (leftSquare.flying.right != 0)
			{
				if (leftSquare.flying.right.flying.left != 0)
				{
					leftSquare.flying.right.flying.left = 0;
				}
				if (leftSquare.flying.right.flying.upLeft != 0)
				{
					if (leftSquare.flying.right.flying.upLeft.flying.downRight != 0)
					{
						leftSquare.flying.right.flying.upLeft.flying.downRight = 0;
					}
				
					leftSquare.flying.right.flying.upLeft = 0;
				}
				if (leftSquare.flying.right.flying.downLeft != 0)
				{
					if (leftSquare.flying.right.flying.downLeft.flying.upRight != 0)
					{
						leftSquare.flying.right.flying.downLeft.flying.upRight = 0;
					}
				
					leftSquare.flying.right.flying.downLeft = 0;
				}

				leftSquare.flying.right = 0;
			}
			if (leftSquare.flying.downRight != 0)
			{
				if(leftSquare.flying.downRight.flying.upLeft != 0)
				{
					leftSquare.flying.downRight.flying.upLeft = 0;
				}
				leftSquare.flying.downRight = 0;
			}
			if (leftSquare.flying.upRight != 0)
			{
				if (leftSquare.flying.upRight.flying.downLeft != 0)
				{
					leftSquare.flying.upRight.flying.downLeft = 0;
				}
				leftSquare.flying.upRight = 0;
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
player = instance_create_layer(playerSpawnSquare.x, playerSpawnSquare.y, "Characters", obj_Character, 
{
	characterStats : FindCharacter(CharacterClass.Player, 0)
});
player.currentSquare = playerSpawnSquare;
playerSpawnSquare.character = player;
global.Player = player;
player.sprite_index = player.characterStats.sprite;
global.selectedCharacter = player;

var ahlya = FindCharacter(CharacterClass.Bondable, 0);
var test = FindCharacter(CharacterClass.Monster, 0);


global.Allies = array_create(0);


ds_list_add(global.BondedMonsters, ahlya);
array_push(global.Allies, player);

cameraTarget = instance_create_layer(player.x, player.y, "AboveCharacters", obj_CameraTarget);

//blueprint characters

var characterSize = ds_list_size(blueprint.characters);
for (var i = 0; i < characterSize; i++)
{
	var cha = ds_list_find_value(blueprint.characters, i);
	var square = squares[cha.spawnX, cha.spawnY];
	var newCharacter = instance_create_layer(square.x, square.y, "Characters", obj_Character, 
	{
		characterStats : cha
	});
	square.character = newCharacter;
	newCharacter.currentSquare = square;
	newCharacter.sprite_index = cha.sprite;
	
	ds_list_add(spawnedCharacters, newCharacter);
	
	//ai
	
	if (cha.aiMindIndex >= 0)
	{
		var existingAiIndex = ds_list_find_index(aiMindIndices, cha.aiMindIndex);
		var targetMind = 0;
		//if our ai index already exists
		if (existingAiIndex >= 0)
		{
			targetMind = ds_list_find_value(aiMinds, existingAiIndex);
		}
		else
		{
			//new Ai mind
			targetMind = instance_create_layer(0, 0, "Instances", obj_AiMind);
			targetMind.index = cha.aiMindIndex;
			ds_list_add(aiMindIndices, cha.aiMindIndex);
			ds_list_add(aiMinds, targetMind);
		}
		
		//give that Ai control over this character
		ds_list_add(targetMind.characters, newCharacter);
		newCharacter.aiMind = targetMind;
	}
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