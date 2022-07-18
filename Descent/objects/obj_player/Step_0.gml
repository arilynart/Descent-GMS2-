/// @description move if told to.

if (moving)
{
	if (moveTarget == 0 && !ds_queue_empty(moveQueue))
	{
		moveTarget = ds_queue_dequeue(moveQueue);
		move_towards_point(moveTarget.x, moveTarget.y, moveSpeed);
		show_debug_message("No target. Dequeueing next target: " + string(moveTarget));
	}
	else if (moveTarget != 0)
	{
		var distance = point_distance(x, y, moveTarget.x, moveTarget.y);
		if (distance < moveSpeed)
		{
			move_towards_point(moveTarget.x, moveTarget.y, moveSpeed);
			
			show_debug_message("arrived at target. Restting variables.");
			currentSquare.character = 0;
			moveTarget.character = self;
			currentSquare = moveTarget;
			moveTarget = 0;
			
			//x = moveTarget.x;
			//y = moveTarget.y;
		}
		else if (x != moveTarget.x || y != moveTarget.y)
		{
			move_towards_point(moveTarget.x, moveTarget.y, moveSpeed);
			show_debug_message("Not yet arrived at target. Moving.");

		}
		

	}
	else if (ds_queue_empty(moveQueue))
	{
		speed = 0;
		show_debug_message("Queue empty. Ending movement.");
		moving = false;
	}
}