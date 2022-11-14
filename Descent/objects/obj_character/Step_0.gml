/// @description move if told to.

depth = -y;

if (global.InCombat)
{
	velocityX = 0;
	velocityY = 0;
	if (moving)
	{
		if (moveTarget == 0 && ds_queue_empty(moveQueue) == false)
		{
			moveTarget = ds_queue_dequeue(moveQueue).square;
			if (ds_queue_empty(moveQueue))
			{
				currentSquare.character = 0;
				currentSquare = moveTarget;
				currentSquare.moveTarget = false;
				moveTarget.character = id;
				UpdateAllThreat();
			}
			move_towards_point(moveTarget.x, moveTarget.y, moveSpeed);
			//show_debug_message("No target. Dequeueing next target: " + string(moveTarget));
		}
		else if (moveTarget != 0)
		{
			var distance = point_distance(x, y, moveTarget.x, moveTarget.y);
			if (distance < moveSpeed)
			{
				move_towards_point(moveTarget.x, moveTarget.y, moveSpeed);
			
				//show_debug_message("arrived at target. Restting variables.");
				moveTarget = 0;
			}
			else if (x != moveTarget.x || y != moveTarget.y)
			{
				move_towards_point(moveTarget.x, moveTarget.y, moveSpeed);
				//show_debug_message("Not yet arrived at target. Moving.");

			}
		

		}
		else if (ds_queue_empty(moveQueue))
		{
			speed = 0;
			//show_debug_message("Queue empty. Ending movement.");
			moving = false;
			moveLock = false;
			
			if (ds_list_size(global.EffectList) > 0)
			{
				EndEffect();
			}
			
			if (ds_list_empty(global.EffectList)
			 && maxMove > 0 && global.selectedCharacter == id)
			{
				currentSquare.Select();
			}
		}
	}
}
else if (global.selectedCharacter == id && !global.SquareLock)
{
	var otherSquare = instance_position(x, y, obj_Square);
	if (storedActivation != 0) currentSquare.Deactivate(storedActivation);
	storedActivation = array_create(0);
	
	if (currentSquare != otherSquare)
	{
		currentSquare.character = 0;
		currentSquare = otherSquare;
		otherSquare.character = id;
		
	}
	
	
	//check for nearby interactables
	if (otherSquare.interaction != 0)
	{
		otherSquare.image_alpha = 1;
		otherSquare.activated = true;
		otherSquare.image_blend = otherSquare.interactionColor;
		
		array_push(storedActivation, otherSquare.BaseParse(otherSquare, 0, otherSquare));
	}
	//downright
	if (otherSquare.downRight != 0 && otherSquare.downRight.interaction != 0)
	{
		otherSquare.downRight.image_alpha = 1;
		otherSquare.downRight.activated = true;
		otherSquare.downRight.image_blend = otherSquare.downRight.interactionColor;
		
		array_push(storedActivation, otherSquare.BaseParse(otherSquare.downRight, 0, otherSquare.downRight));
	}
	//down
	if (otherSquare.down != 0 && otherSquare.down.interaction != 0)
	{
		otherSquare.down.image_alpha = 1;
		otherSquare.down.activated = true;
		otherSquare.down.image_blend = otherSquare.down.interactionColor;
		
		array_push(storedActivation, otherSquare.BaseParse(otherSquare.down, 0, otherSquare.down));
	}
	//downleft
	if (otherSquare.downLeft != 0 && otherSquare.downLeft.interaction != 0)
	{
		otherSquare.downLeft.image_alpha = 1;
		otherSquare.downLeft.activated = true;
		otherSquare.downLeft.image_blend = otherSquare.downLeft.interactionColor;
		
		array_push(storedActivation, BaseParse(otherSquare.downLeft, 0, otherSquare.downLeft));
	}
	//left
	if (otherSquare.left != 0 && otherSquare.left.interaction != 0)
	{
		otherSquare.left.image_alpha = 1;
		otherSquare.left.activated = true;
		otherSquare.left.image_blend = otherSquare.left.interactionColor;
		
		array_push(storedActivation, otherSquare.BaseParse(otherSquare.left, 0, otherSquare.left));
	}
	//upleft
	if (otherSquare.upLeft != 0 && otherSquare.upLeft.interaction != 0)
	{
		otherSquare.upLeft.image_alpha = 1;
		otherSquare.upLeft.activated = true;
		otherSquare.upLeft.image_blend = otherSquare.upLeft.interactionColor;
		
		array_push(storedActivation, otherSquare.BaseParse(otherSquare.upLeft, 0, otherSquare.upLeft));
	}
	//up
	if (otherSquare.up != 0 && otherSquare.up.interaction != 0)
	{
		otherSquare.up.image_alpha = 1;
		otherSquare.up.activated = true;
		otherSquare.up.image_blend = otherSquare.up.interactionColor;
		
		array_push(storedActivation, otherSquare.BaseParse(otherSquare.up, 0, otherSquare.up));
	}
	//upright
	if (otherSquare.upRight != 0 && otherSquare.upRight.interaction != 0)
	{
		otherSquare.upRight.image_alpha = 1;
		otherSquare.upRight.activated = true;
		otherSquare.upRight.image_blend = otherSquare.upRight.interactionColor;
		
		array_push(storedActivation, otherSquare.BaseParse(otherSquare.upRight, 0, otherSquare.upRight));
	}
	//right
	if (otherSquare.right != 0 && otherSquare.right.interaction != 0)
	{
		otherSquare.right.image_alpha = 1;
		otherSquare.right.activated = true;
		otherSquare.right.image_blend = otherSquare.right.interactionColor;
		
		array_push(storedActivation, otherSquare.BaseParse(otherSquare.right, 0, otherSquare.right));
	}
	
	//show_debug_message("Current Square: " + string(currentSquare.coordinate.x) + ", " + string(currentSquare.coordinate.y));
	
	if (currentSquare.encounterTrigger >= 0)
	{
		//start the encounter
		if (ds_list_find_value(currentSquare.map.blueprint.encounters, currentSquare.encounterTrigger).alive)
			StartCombat(currentSquare.encounterTrigger);
	}
	
	if !window_has_focus()
    {
		moveRight = 0;
		moveDown = 0;
    }
	
	velocityX = (moveRight * moveSpeed);
	velocityY = (moveDown * moveSpeed);
	

	
	
	if (velocityX != 0 && velocityY != 0)
	{
		velocityX = ceil(velocityX * 0.75);
		velocityY = ceil(velocityY * 0.75);
	}
	
	
	//check each border of the sprite's collision based on the direction we are moving
	
	if (characterStats.flying)
	{
		if (velocityX > 0 && !position_meeting(bbox_right + velocityX, y, currentSquare))
		{
			if (currentSquare.flying.right == 0 || currentSquare.flying.right.character != 0)
			{
				//show_debug_message("Right Invalid");
				velocityX = 0;
		
			}
			else
			{
				var bottomRightSquare = instance_position(bbox_right, bbox_bottom, obj_Square);
				var topRightSquare = instance_position(bbox_right, bbox_top, obj_Square);
				if (bottomRightSquare == currentSquare.flying.down)
				{
					if (bottomRightSquare.flying.right == 0 || bottomRightSquare.flying.right.character != 0) velocityX = 0;
				}
				if (topRightSquare == currentSquare.flying.up)
				{
					if (topRightSquare.flying.right == 0 || topRightSquare.flying.right.character != 0) velocityX = 0;
				}
				var bottomMeeting = instance_position(bbox_right + velocityX, bbox_bottom + velocityY, obj_Square);
				var topMeeting = instance_position(bbox_right + velocityX, bbox_top + velocityY, obj_Square);
				if (velocityY > 0 && bottomMeeting != currentSquare.flying.right
				 && !position_meeting(bbox_right + velocityX, bbox_bottom + velocityY, currentSquare))
				{
					if (currentSquare.flying.downRight == 0 || currentSquare.flying.downRight.character != 0)
					{
						//show_debug_message("Down Right Invalid");
						velocityY = 0;
					}
				}
				else if (velocityY < 0 && topMeeting != currentSquare.flying.right
					  && !position_meeting(bbox_right + velocityX, bbox_top + velocityY, currentSquare))
				{
					if (currentSquare.flying.upRight == 0 || currentSquare.flying.upRight.character != 0)
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
			if (currentSquare.flying.left == 0 || currentSquare.flying.left.character != 0)
			{
				//show_debug_message("Left Invalid");
				velocityX = 0;
			}
			else
			{
				var bottomLeftSquare = instance_position(bbox_left, bbox_bottom, obj_Square);
				var topLeftSquare = instance_position(bbox_left, bbox_top, obj_Square);
				if (bottomLeftSquare == currentSquare.flying.down)
				{
					if (bottomLeftSquare.flying.left == 0 || bottomLeftSquare.flying.left.character != 0) velocityX = 0;
				}
				if (topLeftSquare == currentSquare.flying.up)
				{
					if (topLeftSquare.flying.left == 0 || topLeftSquare.flying.left.character != 0) velocityX = 0;
				}
				var bottomMeeting = instance_position(bbox_left + velocityX, bbox_bottom + velocityY, obj_Square);
				var topMeeting = instance_position(bbox_left + velocityX, bbox_top + velocityY, obj_Square);
				if (velocityY > 0 && bottomMeeting != currentSquare.flying.left
				 && !position_meeting(bbox_left + velocityX, bbox_bottom + velocityY, currentSquare))
				{
					if (currentSquare.flying.downLeft == 0 || currentSquare.flying.downLeft.character != 0)
					{
						//show_debug_message("Down Left Invalid");
						velocityY = 0;
					}
				}
				else if (velocityY < 0 && topMeeting != currentSquare.flying.left
					 && !position_meeting(bbox_left + velocityX, bbox_top + velocityY, currentSquare))
				{
					if (currentSquare.flying.upLeft == 0 || currentSquare.flying.upLeft.character != 0)
					{
					
						velocityY = 0;
					}
				}
			}
		}
		if (velocityY > 0 && !position_meeting(x, bbox_bottom + velocityY, currentSquare))
		{
			if (currentSquare.flying.down == 0 || currentSquare.flying.down.character != 0) velocityY = 0;
			else
			{
				var bottomRightSquare = instance_position(bbox_right, bbox_bottom, obj_Square);
				var bottomLeftSquare = instance_position(bbox_left, bbox_bottom, obj_Square);
				if (bottomRightSquare == currentSquare.flying.right)
				{
					if (bottomRightSquare.flying.down == 0 || bottomRightSquare.flying.down.character != 0) velocityY = 0;
				}
				if (bottomLeftSquare == currentSquare.flying.left)
				{
					if (bottomLeftSquare.flying.down == 0 || bottomLeftSquare.flying.down.character != 0) velocityY = 0;
				}
			}
		}
	
		if (velocityY < 0 && !position_meeting(x, bbox_top + velocityY, currentSquare))
		{
			if (currentSquare.flying.up == 0 || currentSquare.flying.up.character != 0) velocityY = 0;
			else
			{
				var topRightSquare = instance_position(bbox_right, bbox_top, obj_Square);
				var topLeftSquare = instance_position(bbox_left, bbox_top, obj_Square);
				if (topRightSquare == currentSquare.flying.right)
				{
					if (topRightSquare.flying.up == 0 || topRightSquare.flying.up.character != 0) velocityY = 0;
				}
				if (topLeftSquare == currentSquare.flying.left)
				{
					if (topLeftSquare.flying.up == 0 || topLeftSquare.flying.up.character != 0) velocityY = 0;
				}
			}
		}
	}
	else
	{
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
					if (bottomRightSquare.right == 0 || bottomRightSquare.right.character != 0) velocityX = 0;
				}
				if (topRightSquare == currentSquare.up)
				{
					if (topRightSquare.right == 0 || topRightSquare.right.character != 0) velocityX = 0;
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
					if (bottomLeftSquare.left == 0 || bottomLeftSquare.left.character != 0) velocityX = 0;
				}
				if (topLeftSquare == currentSquare.up)
				{
					if (topLeftSquare.left == 0 || topLeftSquare.left.character != 0) velocityX = 0;
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
					if (bottomRightSquare.down == 0 || bottomRightSquare.down.character != 0) velocityY = 0;
				}
				if (bottomLeftSquare == currentSquare.left)
				{
					if (bottomLeftSquare.down == 0 || bottomLeftSquare.down.character != 0) velocityY = 0;
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
					if (topRightSquare.up == 0 || topRightSquare.up.character != 0) velocityY = 0;
				}
				if (topLeftSquare == currentSquare.left)
				{
					if (topLeftSquare.up == 0 || topLeftSquare.up.character != 0) velocityY = 0;
				}
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
	
	//show_debug_message("coordinates: (" + string(x) + ", " + string (y) + ") | velocityY: " + string(velocityY));

	if (velocityX != 0)
	{
		x += velocityX;
	}

	if (velocityY != 0)
	{
		y += velocityY;
	}
}