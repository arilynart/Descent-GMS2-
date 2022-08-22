/// @description move if told to.

if (global.InCombat)
{
	velocityX = 0;
	velocityY = 0;
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
	var otherSquare = instance_position(x, y, obj_Square);
	if (currentSquare != otherSquare)
	{
		currentSquare.character = 0;
		currentSquare = otherSquare;
		otherSquare.character = id;
	}
	
	show_debug_message("Current Square: " + string(currentSquare.coordinate.x) + ", " + string(currentSquare.coordinate.y));
	
	velocityX = (moveRight * moveSpeed);
	velocityY = (moveDown * moveSpeed);

	if (velocityX != 0 && velocityY != 0)
	{
		velocityX = ceil(velocityX * 0.75);
		velocityY = ceil(velocityY * 0.75);
	}
	
	
	//check each border of the sprite's collision based on the direction we are moving
	
	if (velocityX > 0 && !position_meeting(bbox_right + velocityX, y, currentSquare))
	{
		if (currentSquare.right == 0 || currentSquare.right.character != 0)
		{
			//show_debug_message("Right Invalid");
			velocityX = 0;
		
		}
		else
		{
			var bottomRightSquare = instance_position(bbox_right, bbox_bottom, obj_Square);
			var topRightSquare = instance_position(bbox_right, bbox_top, obj_Square);
			if (bottomRightSquare == currentSquare.down)
			{
				if (bottomRightSquare.right == 0 || bottomRightSquare.character != 0) velocityX = 0;
			}
			if (topRightSquare == currentSquare.up)
			{
				if (topRightSquare.right == 0 || topRightSquare.character != 0) velocityX = 0;
			}
			var bottomMeeting = instance_position(bbox_right + velocityX, bbox_bottom + velocityY, obj_Square);
			var topMeeting = instance_position(bbox_right + velocityX, bbox_top + velocityY, obj_Square);
			if (velocityY > 0 && bottomMeeting != currentSquare.right
			 && !position_meeting(bbox_right + velocityX, bbox_bottom + velocityY, currentSquare))
			{
				if (currentSquare.downRight == 0 || currentSquare.downRight.character != 0)
				{
					//show_debug_message("Down Right Invalid");
					velocityY = 0;
				}
			}
			else if (velocityY < 0 && topMeeting != currentSquare.right
				  && !position_meeting(bbox_right + velocityX, bbox_top + velocityY, currentSquare))
			{
				if (currentSquare.upRight == 0 || currentSquare.upRight.character != 0)
				{
					//show_debug_message("Up Right Invalid");
					velocityY = 0;
				}
			}
		}
		//check the two right corners. If the square either of them are touching does not have a right wall, don't allow the movement.
		
	}
	else if (velocityX < 0 && !position_meeting(bbox_left + velocityX, y, currentSquare))
	{
		if (currentSquare.left == 0 || currentSquare.left.character != 0)
		{
			//show_debug_message("Left Invalid");
			velocityX = 0;
		}
		else
		{
			var bottomLeftSquare = instance_position(bbox_left, bbox_bottom, obj_Square);
			var topLeftSquare = instance_position(bbox_left, bbox_top, obj_Square);
			if (bottomLeftSquare == currentSquare.down)
			{
				if (bottomLeftSquare.left == 0 || bottomLeftSquare.character != 0) velocityX = 0;
			}
			if (topLeftSquare == currentSquare.up)
			{
				if (topLeftSquare.left == 0 || topLeftSquare.character != 0) velocityX = 0;
			}
			var bottomMeeting = instance_position(bbox_left + velocityX, bbox_bottom + velocityY, obj_Square);
			var topMeeting = instance_position(bbox_left + velocityX, bbox_top + velocityY, obj_Square);
			if (velocityY > 0 && bottomMeeting != currentSquare.left
			 && !position_meeting(bbox_left + velocityX, bbox_bottom + velocityY, currentSquare))
			{
				if (currentSquare.downLeft == 0 || currentSquare.downLeft.character != 0)
				{
					//show_debug_message("Down Left Invalid");
					velocityY = 0;
				}
			}
			else if (velocityY < 0 && topMeeting != currentSquare.left
				 && !position_meeting(bbox_left + velocityX, bbox_top + velocityY, currentSquare))
			{
				if (currentSquare.upLeft == 0 || currentSquare.upLeft.character != 0)
				{
					
					velocityY = 0;
				}
			}
		}
	}
	if (velocityY > 0 && !position_meeting(x, bbox_bottom + velocityY, currentSquare))
	{
		if (currentSquare.down == 0 || currentSquare.down.character != 0) velocityY = 0;
		else
		{
			var bottomRightSquare = instance_position(bbox_right, bbox_bottom, obj_Square);
			var bottomLeftSquare = instance_position(bbox_left, bbox_bottom, obj_Square);
			if (bottomRightSquare == currentSquare.right)
			{
				if (bottomRightSquare.down == 0 || bottomRightSquare.character != 0) velocityY = 0;
			}
			if (bottomLeftSquare == currentSquare.left)
			{
				if (bottomLeftSquare.down == 0 || bottomLeftSquare.character != 0) velocityY = 0;
			}
		}
	}
	
	if (velocityY < 0 && !position_meeting(x, bbox_top + velocityY, currentSquare))
	{
		if (currentSquare.up == 0 || currentSquare.up.character != 0) velocityY = 0;
		else
		{
			var topRightSquare = instance_position(bbox_right, bbox_top, obj_Square);
			var topLeftSquare = instance_position(bbox_left, bbox_top, obj_Square);
			if (topRightSquare == currentSquare.right)
			{
				if (topRightSquare.up == 0 || topRightSquare.character != 0) velocityY = 0;
			}
			if (topLeftSquare == currentSquare.left)
			{
				if (topLeftSquare.up == 0 || topLeftSquare.character != 0) velocityY = 0;
			}
		}
	}
	
	if (!position_meeting(x + velocityX, y, obj_Square))
	{
		velocityX = 0;
	}
	if (!position_meeting(x, y + velocityY, obj_Square))
	{
		velocityY = 0;
	}
	
	
	
	
	show_debug_message("coordinates: (" + string(x) + ", " + string (y) + ") | velocityY: " + string(velocityY));
	
}