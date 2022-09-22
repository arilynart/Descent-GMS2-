/// @description toggle square


if (displaying && currentMode == WallModes.Range)
{
	var square = instance_position(mouse_x, mouse_y, obj_Square);
	if (square != noone)
	{
		var struct =
		{
			x : square.coordinate.x,
			y : square.coordinate.y
		}
	
		for (var i = 0; i < array_length(invalidRange); i++)
		{
			var coord = invalidRange[i];
			if (struct.x == coord.x && struct.y == coord.y)
			{
				array_delete(invalidRange, i, 1);
				return;
			}
		}
	
		array_push(invalidRange, struct);
	}
}