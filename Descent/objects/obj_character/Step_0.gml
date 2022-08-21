/// @description move if told to.

if (global.InCombat)
{
	if (moving)
	{
		if (moveTarget == 0 && ds_queue_empty(moveQueue) == false)
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
				moveTarget.character = id;
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
}
else if (global.selectedCharacter == id)
{
	var velocityX = (moveRight * moveSpeed);
	var velocityY = (moveDown * moveSpeed);

	if (velocityX != 0 && velocityY != 0)
	{
		velocityX *= 0.75;
		velocityY *= 0.75;
	}
	if (position_meeting(x + velocityX, y, obj_Square) == false)
	{
		velocityX = 0;
	}
	if (position_meeting(x, y + velocityY, obj_Square) == false)
	{
		velocityY = 0;
	}

	
	if (velocityX != 0)
	{
		x += velocityX;
	}

	if (velocityY != 0)
	{
		y += velocityY;
	}
	
	if (position_meeting(x, y, obj_Square))
	{
				
		if (currentSquare != other)
		{
			currentSquare = other;
		}
	}
}