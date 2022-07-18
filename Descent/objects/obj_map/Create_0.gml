/// @description Generate the grid

gridWidth = 18;
gridHeight = 16;
gridSize = 300;

room_width = gridSize * gridWidth;
room_height = gridSize * gridHeight;

playerSpawnX = 6;
playerSpawnY = 4;

for (var i = 0; i < gridWidth; i++) 
{
	for (var j = 0; j < gridWidth; j++) 
	{
		var newSquare = instance_create_layer(i * gridSize + gridSize / 2, j * gridSize + gridSize / 2, "Instances", obj_Square);
		with(newSquare) 
		{
			newSquare.coordX = i;
			newSquare.coordY = j;
		}
		squares[i,j] = newSquare;
		
		//show_debug_message("Square Created: " + string(squares[i,j].id));
	}
}

//link squares

for (var i = 0; i < gridWidth; i++) 
{
	for (var j = 0; j < gridWidth; j++)
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
	}
}

player = instance_create_layer(playerSpawnX * gridSize, playerSpawnY * gridSize, "Instances", obj_Player);