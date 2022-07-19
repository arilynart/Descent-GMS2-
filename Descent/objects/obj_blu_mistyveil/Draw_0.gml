/// @description override

if (displaying == true)
{
	var size = array_length(walls);
	draw_set_colour(c_aqua);
	for (var i = 0; i < size; i++)
	{
		var drawWall = walls[i];
		//show_debug_message("Drawing Wall: " + string(drawWall));
		draw_line_width(drawWall.point1.x * map.gridSize, drawWall.point1.y * map.gridSize, 
			drawWall.point2.x * map.gridSize, drawWall.point2.y * map.gridSize, 25);
	}
}