/// @description Begin Wall Selection


if (global.UiManager.displayDialogue) return;

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
	
	//make sure only one of the points is different.
	var xDiff = abs(global.wallBuildPoint1.x - global.wallBuildPoint2.x);
	var yDiff = abs(global.wallBuildPoint1.y - global.wallBuildPoint2.y);
	
	if (xDiff > 0 && yDiff > 0)
	{
		show_debug_message("Wall not in line. Cancelled action.");
	}
	else if ((xDiff == 0 && yDiff > 0) || (xDiff > 0 && yDiff == 0))
	{
		for (var step = 0; step < xDiff; step++)
		{
			var x1 = -1;
			var x2 = -1;
			if (global.wallBuildPoint1.x < global.wallBuildPoint2.x)
			{
				x1 = global.wallBuildPoint1.x + step;
				x2 = global.wallBuildPoint1.x + step + 1;
			}
			else
			{
				x1 = global.wallBuildPoint1.x - step;
				x2 = global.wallBuildPoint1.x - step - 1;
			}
			
			var newWall = 
			{
				point1 :
				{
					x : x1,
					y : global.wallBuildPoint1.y
				},
				point2 :
				{
					x : x2,
					y : global.wallBuildPoint2.y
				}
			}
	
			var inverseWall = 
			{
				point1 :
				{
					x : x2,
					y : global.wallBuildPoint2.y
				},
				point2 :
				{
					x : x1,
					y : global.wallBuildPoint1.y
				}
			}
	
			var wallExists = false;
			var index = -1;
			var size = array_length(map.blueprint.walls);
	
			for (var i = 0; i < size; i++)
			{
				var checkedWall = map.blueprint.walls[i];
				if ((checkedWall.point1.x == newWall.point1.x && checkedWall.point1.y == newWall.point1.y
					&& checkedWall.point2.x == newWall.point2.x && checkedWall.point2.y == newWall.point2.y)
					|| (checkedWall.point1.x == inverseWall.point1.x && checkedWall.point1.y == inverseWall.point1.y
					&& checkedWall.point2.x == inverseWall.point2.x && checkedWall.point2.y == inverseWall.point2.y))
				{
					wallExists = true;
					index = i;
				}
			}
	
			if (wallExists == true && index >= 0)
			{
				show_debug_message("Wall already exists. Removing.");
				array_delete(map.blueprint.walls, index, 1);
			}
			else
			{
				array_push(map.blueprint.walls, newWall);
			}
		}
		for (var step = 0; step < yDiff; step++)
		{
			var y1 = -1;
			var y2 = -1;
			if (global.wallBuildPoint1.y < global.wallBuildPoint2.y)
			{
				y1 = global.wallBuildPoint1.y + step;
				y2 = global.wallBuildPoint1.y + step + 1;
			}
			else
			{
				y1 = global.wallBuildPoint1.y - step;
				y2 = global.wallBuildPoint1.y - step - 1;
			}
			
			newWall = 
			{
				point1 :
				{
					x : global.wallBuildPoint1.x,
					y : y1
				},
				point2 :
				{
					x : global.wallBuildPoint2.x,
					y : y2
				}
			}
	
			inverseWall = 
			{
				point1 :
				{
					x : global.wallBuildPoint2.x,
					y : y2
				},
				point2 :
				{
					x : global.wallBuildPoint1.x,
					y : y1
				}
			}
	
			var wallExists = false;
			var index = -1;
			var size = array_length(map.blueprint.walls);
	
			for (var i = 0; i < size; i++)
			{
				var checkedWall = map.blueprint.walls[i];
				if ((checkedWall.point1.x == newWall.point1.x && checkedWall.point1.y == newWall.point1.y
					&& checkedWall.point2.x == newWall.point2.x && checkedWall.point2.y == newWall.point2.y)
					|| (checkedWall.point1.x == inverseWall.point1.x && checkedWall.point1.y == inverseWall.point1.y
					&& checkedWall.point2.x == inverseWall.point2.x && checkedWall.point2.y == inverseWall.point2.y))
				{
					wallExists = true;
					index = i;
				}
			}
	
			if (wallExists == true && index >= 0)
			{
				show_debug_message("Wall already exists. Removing.");
				array_delete(map.blueprint.walls, index, 1);
			}
			else
			{
				array_push(map.blueprint.walls, newWall);
			}
		}
		
	}
	else
	{
		show_debug_message("Wall is a single point. Cancelled action.");
	}

	global.wallBuildPoint1.object.image_blend = c_white;
	global.wallBuildPoint2.object.image_blend = c_white;
	global.wallBuildPoint1 = 0;
	global.wallBuildPoint2 = 0;
}