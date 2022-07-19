/// @description Generate the grid


//load blueprint
blueprint = instance_create_layer(0, 0, "Instances", obj_blu_MistyVeil);

gridWidth = blueprint.mapWidth;
gridHeight = blueprint.mapHeight;
gridSize = 300;

room_width = gridWidth * gridSize;
room_height = gridHeight * gridSize;

playerSpawnX = 6;
playerSpawnY = 6;

movingCharacter = 0;

for (var i = 0; i < gridWidth; i++) 
{
	for (var j = 0; j < gridHeight; j++) 
	{
		var newSquare = instance_create_layer(i * gridSize + gridSize / 2, j * gridSize + gridSize / 2, "Squares", obj_Square);
		with(newSquare) 
		{
			coordinate.x = i;
			coordinate.y = j;
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
		var newPoint = instance_create_layer(i * gridSize, j * gridSize, "Points", obj_Point);
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

//create other necessary objects

player = instance_create_layer(squares[playerSpawnX, playerSpawnY].x, squares[playerSpawnX, playerSpawnY].y, "Characters", obj_Player);
squares[playerSpawnX, playerSpawnY].character = player;
cameraTarget = instance_create_layer(player.x, player.y, "AboveCharacters", obj_CameraTarget);

var camWidth = camera_get_view_width(view_camera[0])
if (room_width < camWidth)
{
	cameraTarget.hLock = true;
}
var camHeight = camera_get_view_height(view_camera[0])
if (room_height < camHeight)
{
	cameraTarget.vLock = true;
}

camera_set_view_target(view_camera[0], cameraTarget);



show_debug_message("Camera Target Initialized. Set to: " + string(camera_get_view_target(view_camera[0])));