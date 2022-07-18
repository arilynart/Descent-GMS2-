/// @description Begin Wall Selection

image_blend = c_blue;

if (global.wallBuildPoint1 == 0)
{
	global.wallBuildPoint1 =
	{
		object : id,
		x : coordinate.x,
		y : coordinate.y
	}
}
else if (global.wallBuildPoint2 == 0)
{
	global.wallBuildPoint2 =
	{
		object : id,
		x : coordinate.x,
		y : coordinate.y
	}
	
	AddWall(map.blueprint.walls, global.wallBuildPoint1.x, global.wallBuildPoint1.y, 
	global.wallBuildPoint2.x, global.wallBuildPoint2.y);
	global.wallBuildPoint1.object.image_blend = c_white;
	global.wallBuildPoint2.object.image_blend = c_white;
	global.wallBuildPoint1 = 0;
	global.wallBuildPoint2 = 0;
}