/// @description actual movement

camera_set_view_pos(camera, x - (camera_get_view_width(camera) / 2), y - (camera_get_view_height(camera) / 2));

var cameraX = camera_get_view_x(camera) + (camera_get_view_width(camera) / 2);
var cameraY = camera_get_view_y(camera) + (camera_get_view_height(camera) / 2);

/*if (hLock == true || vLock == true)
{
	if (hLock == true)
	{
		x = room_width / 2;
	}
	if (vLock == true)
	{
		y = room_height / 2;
	}
}
else 
{*/
	if (followingCharacter != 0)
	{
		x = followingCharacter.x;
		y = followingCharacter.y;
	}
	else
	{
		if (x != cameraX)
		{
			x = cameraX;
		}

		if (y != cameraY)
		{
			y = cameraY;
		}
	}
//}

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