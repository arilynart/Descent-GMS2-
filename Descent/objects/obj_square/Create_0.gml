/// @description Initialize variables. Definition for square activation.
map = instance_find(obj_Map, 0);

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

function Activate(start, maxDistance) 
{
	show_debug_message("Activating grid from: " + string(start.coordinate) + " with a distance of " + string(maxDistance));
	
	parseQueue = ds_queue_create();
	parsedCoordinates = ds_list_create();
	
	ds_queue_enqueue(parseQueue, start);
	ds_list_add(parsedCoordinates, start.coordinate);
	start.distance = 0;
	
	while (!ds_queue_empty(parseQueue))
	{
		var currentSquare = ds_queue_dequeue(parseQueue);
		currentSquare.image_alpha = 1;
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
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridWidth)
			{
				ParseSquare(currentSquare.right, nextDistance);
			}
			//down
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridWidth)
			{
				ParseSquare(currentSquare.down, nextDistance);
			}
			//left
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridWidth)
			{
				ParseSquare(currentSquare.left, nextDistance);
			}
			//up
			targetX = currentSquare.coordinate.x;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridWidth)
			{
				ParseSquare(currentSquare.up, nextDistance);
			}
		}
		
		nextDistance = currentSquare.distance + 1.5;
		if (nextDistance <= maxDistance)
		{
			//downright
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridWidth)
			{
				ParseSquare(currentSquare.downRight, nextDistance);
			}
			//downleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y + 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridWidth)
			{
				ParseSquare(currentSquare.downLeft, nextDistance);
			}
			//upleft
			targetX = currentSquare.coordinate.x - 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridWidth)
			{
				ParseSquare(currentSquare.upLeft, nextDistance);
			}
			//upright
			targetX = currentSquare.coordinate.x + 1;
			targetY = currentSquare.coordinate.y - 1;
			if (targetX >= 0 && targetX < map.gridWidth && targetY >= 0 && targetY < map.gridWidth)
			{
				ParseSquare(currentSquare.upRight, nextDistance);
			}
		}
	}
}

function ParseSquare(square, parseDistance)
{
	//show_debug_message("Parsing Square: " + string(square));
	if (square != 0 && ((ds_list_find_index(parsedCoordinates, square.coordinate) < 0 && square.distance < 0) || parseDistance < square.distance))
	{
		//show_debug_message("Square is valid: " + string(square));
		square.distance = parseDistance;
		ds_queue_enqueue(parseQueue, square);
		ds_list_add(parsedCoordinates, square.coordinate);
	}
	else
	{
		show_debug_message("Square is invalid: " + string(square));
	}
}