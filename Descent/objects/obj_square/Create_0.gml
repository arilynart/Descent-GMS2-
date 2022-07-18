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

function Activate(start, maxDistance) 
{
	show_debug_message("Activating grid from: " + string(start.coordinate) + " with a distance of " + string(maxDistance));
	
	var parseQueue = ds_queue_create();
	var parsedCoordinates = ds_list_create();
	var activatedSquares = ds_list_create();
	
	ds_queue_enqueue(parseQueue, start);
	ds_list_add(parsedCoordinates, start.coordinate);
	
	while (!ds_queue_empty(parseQueue))
	{
		var currentSquare = ds_queue_dequeue(parseQueue);
		currentSquare.image_alpha = 1;
		
	}
}