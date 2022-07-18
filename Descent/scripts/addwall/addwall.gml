/// @function AddWall(list, x1, y1, x2, y2)
/// @param {index} list The list to add the wall to.
/// @param {real} x1 The X coordinate of first wall point
/// @param {real} y1 The Y coordinate of first wall point
/// @param {real} x2 The X coordinate of second wall point
/// @param {real} y2 The Y coordinate of second wall point

function AddWall(list, x1, y1, x2, y2)
{
	newWall = 
	{
		point1 :
		{
			x : x1,
			y : y1
		},
		point2 :
		{
			x: x2,
			y : y2
		}
	}
	
	show_debug_message("New Wall Created: " + string(newWall));
	ds_list_add(list, newWall);
}