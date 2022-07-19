/// @description Initialize variables

global.cameraTarget = self;

spd = 60;
defaultSpd = spd;
defaultHSpeed = camera_get_view_speed_x(view_camera[0]);
defaultVSpeed = camera_get_view_speed_y(view_camera[0]);
moveRight = 0;
moveDown = 0;
followingCharacter = 0;
hLock = false;
vLock = false;