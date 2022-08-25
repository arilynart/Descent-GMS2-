/// @description actual movement

if (global.UiManager.displayDialogue) LockCamera(1);

var cameraX = camera_get_view_x(camera) + (camera_get_view_width(camera) / 2);
var cameraY = camera_get_view_y(camera) + (camera_get_view_height(camera) / 2);

//show_debug_message("Camera Lock: " + string(alarm_get(0)));

if (global.InCombat && alarm_get(0) <= 0)
{
	var velocityX = (moveRight * spd);
	var velocityY = (moveDown * spd);



	if (velocityX != 0 && velocityY != 0)
	{
		velocityX *= 0.75;
		velocityY *= 0.75;
	}

	if (velocityX != 0)
	{
		x += velocityX;
		followingCharacter = 0;
	}

	if (velocityY != 0)
	{
		y += velocityY;
		followingCharacter = 0;
	}
}
else 
{
	followingCharacter = global.selectedCharacter;
}

if (followingCharacter != 0)
{
	x = followingCharacter.x;
	y = followingCharacter.y;
}



//zoomstuff
if (targetResolutionX > 0)
{
	if (timer <= maxTime)
	{
		//start movement.
		timer += delta_time;
		if (timer > maxTime)
		{
			timer = maxTime;
		}
		
		if (targetResolutionX != camera_get_view_width(camera) 
			|| targetResolutionY != camera_get_view_height(camera))
		{
			var progress = timer / maxTime;
			camera_set_view_size(camera, lerp(startResolutionX, targetResolutionX, progress), 
										lerp(startResolutionY, targetResolutionY, progress));
		}
		else
		{
			startResolutionX = 0;
			startResolutionY = 0;
			targetResolutionX = 0;
			targetResolutionY = 0;
			show_debug_message("Target resolution reached. Resetting resolution.");
		}
	}
}

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

if (cameraX != x || cameraY != y)
{
	var tempX = lerp(cameraX, x, lerpSpeed);
	var tempY = lerp(cameraY, y, lerpSpeed);
	camera_set_view_pos(camera, tempX - (camera_get_view_width(camera) / 2), tempY - (camera_get_view_height(camera) / 2));
}