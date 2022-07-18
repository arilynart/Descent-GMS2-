/// @description Select Square

if (position_meeting(mouse_x, mouse_y, id))
{
	show_debug_message("Square Clicked: " + string(id) + " Coordinate: " + string(coordinate));
	
	if (character != 0) 
	{
		//selected character. highlight grid for movement.
		map.movingCharacter = character;
		Activate(self, 60);
	}
	else if (map.movingCharacter != 0)
	{
		//if a character is already selected and we're waiting to move, move.
		show_debug_message("Moving " + string(map.movingCharacter) + " to " + string(coordinate));
	}
}