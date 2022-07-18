/// @description Select Square

if (position_meeting(mouse_x, mouse_y, id))
{
	show_debug_message("Square Clicked: " + string(id) + " Coordinate: " + string(coordinate));
	
	if (character != 0) Activate(self, 6);
}