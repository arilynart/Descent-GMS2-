/// @description Initialize variables

global.cameraTarget = self;

spd = 60;
defaultSpd = spd;
defaultHSpeed = camera_get_view_speed_x(view_camera[0]);
defaultVSpeed = camera_get_view_speed_y(view_camera[0]);
moveRight = 0;
moveDown = 0;
followingCharacter = 0;

camera = view_camera[0];
camera_set_view_pos(camera, room_width, room_height);

enum ZoomScale 
{
	max72,
	mid144,
	min288
}

zoom = ZoomScale.max72;

defaultResolutionX = 1920;
defaultResolutionY = 1080;

startResolutionX = 0;
startResolutionY = 0;

targetResolutionX = 0;
targetResolutionY = 0;
timer = 0;
maxTime = 300000;

lerpSpeed = 0.08;

function LockCamera(duration)
{
	alarm_set(0, duration);
}