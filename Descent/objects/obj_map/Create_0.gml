/// @description Generate the grid

gridWidth = 18;
gridHeight = 16;
gridSize = 300;

room_width = gridSize * gridWidth;
room_height = gridSize * gridHeight;

playerSpawnX = 6;
playerSpawnY = 4;

var i = 0;

for (var i = 0; i < gridWidth; i++) 
{
	for (var j = 0; j < gridWidth; j++) 
	{
		var newSquare = instance_create_layer(i * gridSize + gridSize / 2, j * gridSize + gridSize / 2, "Instances", obj_Square);
		
		squares[i,j] = newSquare;
		
		show_debug_message("Square Created: " + string(squares[i,j].id));
	}
}


player = instance_create_layer(playerSpawnX * gridSize, playerSpawnY * gridSize, "Instances", obj_Player);