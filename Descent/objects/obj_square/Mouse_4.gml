/// @description Select Square

if (position_meeting(mouse_x, mouse_y, id))
{
	show_debug_message("Square Clicked: " + string(id) + " Coordinate: " + string(coordinate));
	
	if (character != 0) 
	{
		//selected character. highlight grid for movement.
		if (character.moving == false)
		{
			map.movingCharacter = character;
			Activate(self, 40);
		}
	}
	else if (activated && map.movingCharacter != 0)
	{
		//if a character is already selected and we're waiting to move, move.
		show_debug_message("Moving " + string(map.movingCharacter) + " to " + string(coordinate));
		
		MoveCharacter(map.movingCharacter, self);
		
		map.movingCharacter = 0;
	}
}