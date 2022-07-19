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

closestToTarget = 0;

character = 0;

activatedSquares = ds_list_create();

parsedCoordinates = ds_list_create
parseQueue = ds_queue_create();

activated = false;

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
		currentSquare.image_alpha = 1;
		currentSquare.activated = true;
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
		sq.distance = -1;
		sq.activated = false;
		sq.closestToTarget = 0;
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
	else
	{
		show_debug_message("Square is invalid: " + string(square.coordinate));
	}
}