/// @description draw ui over map

if (displaying == true)
{
	switch (currentMode)
	{
		case WallModes.Move:
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
		break;
		case WallModes.Range:
			var size = array_length(rangeWalls);
			
			for (var i = 0; i < size; i++)
			{
				var drawWall = rangeWalls[i];
				//show_debug_message("Drawing Wall: " + string(drawWall));
				switch (drawWall.type)
				{
					case RangeWallTypes.FullBlock:
						draw_set_colour(c_aqua);
					break;
					case RangeWallTypes.AllowUpToDown:
						draw_set_colour(c_yellow);
					break;
					case RangeWallTypes.AllowLeftToRight:
						draw_set_colour(c_fuchsia);
					break;
					case RangeWallTypes.AllowRightToLeft:
						draw_set_colour(c_lime);
					break;
				}
				
				draw_line_width(map.gridPad + drawWall.point1.x * map.gridSize, 
								map.gridPad + drawWall.point1.y * map.gridSize, 
								map.gridPad + drawWall.point2.x * map.gridSize, 
								map.gridPad + drawWall.point2.y * map.gridSize, 
								25);
			}
			
			var offsetX = sprite_get_width(spr_Cancel) / 2;
			var offsetY = sprite_get_height(spr_Cancel) / 2;
			for (var i = 0; i < array_length(invalidRange); i++)
			{
				var coord = invalidRange[i];
				var square = map.squares[coord.x, coord.y];
				
				
				draw_sprite_ext(spr_Cancel, 0, square.x - offsetX, square.y - offsetY, 1, 1, 0, c_red, 1);
			}
		break;
	}

}

//draw interactables