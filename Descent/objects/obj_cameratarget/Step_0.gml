/// @description actual movement
camera = view_camera[0];

cameraX = camera_get_view_x(camera) + (camera_get_view_width(camera) / 2);
cameraY = camera_get_view_y(camera) + (camera_get_view_height(camera) / 2);

if (x != cameraX)
{
	x = cameraX;
}

if (y != cameraY)
{
	y = cameraY;
}

velocityX = (moveRight * spd);
velocityY = (moveDown * spd);

if (velocityX != 0 && velocityY != 0)
{
	velocityX *= 0.75;
	velocityY *= 0.75;
}

if (velocityX != 0)
{
	x += velocityX;
}

if (velocityY != 0)
{
	y += velocityY;
}

