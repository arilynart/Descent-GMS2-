/// @description draw ui over map

if (displaying == true)
{
	var size = array_length(walls);
	draw_set_colour(c_aqua);
	for (var i = 0; i < size; i++)
	{
		var drawWall = walls[i];
		//show_debug_message("Drawing Wall: " + string(drawWall));
		draw_line_width(map.gridPad + drawWall.point1.x * map.gridSize, 
						map.gridPad + drawWall.point1.y * map.gridSize, 
						map.gridPad + drawWall.point2.x * map.gridSize, 
						map.gridPad + drawWall.point2.y * map.gridSize, 
						25);
	}
}

//draw interactables