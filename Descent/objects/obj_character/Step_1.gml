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

	
	velocityX = (moveRight * moveSpeed);
	velocityY = (moveDown * moveSpeed);

	if (velocityX != 0 && velocityY != 0)
	{
		velocityX = ceil(velocityX * 0.75);
		velocityY = ceil(velocityY * 0.75);
	}
	
	
	//check each border of the sprite's collision based on the direction we are moving
	var collisionWidthHalf = ceil((bbox_right - bbox_left) / 2);
	var collisionHeightHalf = ceil((bbox_bottom - bbox_top) / 2);
	var collisionCenterX = bbox_left + collisionWidthHalf;
	var collisionCenterY = bbox_top + collisionHeightHalf;
	
	if (velocityX > 0 && !position_meeting(collisionCenterX + velocityX + collisionWidthHalf, collisionCenterY, currentSquare))
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
			if (velocityY > 0 && !position_meeting(collisionCenterX + velocityX + collisionWidthHalf, collisionCenterY + velocityY + collisionHeightHalf, currentSquare))
			{
				if (currentSquare.downRight == 0 || currentSquare.downRight.character != 0)
				{
					//show_debug_message("Down Right Invalid");
					velocityY = 0;
				}
			}
			else if (velocityY < 0 && !position_meeting(collisionCenterX + velocityX + collisionWidthHalf, collisionCenterY + velocityY - collisionHeightHalf, currentSquare))
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
	else if (velocityX < 0 && !position_meeting(collisionCenterX + velocityX - collisionWidthHalf, collisionCenterY, currentSquare))
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
			
			if (velocityY > 0 && !position_meeting(collisionCenterX + velocityX - collisionWidthHalf, collisionCenterY + velocityY + collisionHeightHalf, currentSquare))
			{
				if (currentSquare.downLeft == 0 || currentSquare.downLeft.character != 0)
				{
					//show_debug_message("Down Left Invalid");
					velocityY = 0;
				}
			}
			else if (velocityY < 0 && !position_meeting(collisionCenterX + velocityX - collisionWidthHalf, collisionCenterY + velocityY - collisionHeightHalf, currentSquare))
			{
				if (currentSquare.upLeft == 0 || currentSquare.upLeft.character != 0)
				{
					
					velocityY = 0;
				}
			}
		}
	}
	if (velocityY > 0 && !position_meeting(collisionCenterX, collisionCenterY + velocityY + collisionHeightHalf, currentSquare))
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
	
	if (velocityY < 0 && !position_meeting(collisionCenterX, collisionCenterY + velocityY - collisionHeightHalf, currentSquare))
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
	
	if (!position_meeting(collisionCenterX + velocityX, collisionCenterY, obj_Square))
	{
		velocityX = 0;
	}
	if (!position_meeting(collisionCenterX, collisionCenterY + velocityY, obj_Square))
	{
		velocityY = 0;
	}
	
	
	
	
	show_debug_message("coordinates: (" + string(collisionCenterX) + ", " + string (collisionCenterY) + ") | velocityY: " + string(velocityY));
	
}