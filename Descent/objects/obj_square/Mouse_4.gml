/// @description Select Square


if ((global.UiLock && global.SquareLock == false) || map.blueprint.displaying || global.UiManager.displayDialogue) return;

show_debug_message("Square Clicked: " + string(id) + " Coordinate: " + string(coordinate));

if (activated && global.SelectSquareExecute != 0)
{
	if (interaction == 0)
	{
		global.SelectSquareExecute(self);
	}
	return;
}

if (character != 0) 
{

	//selected character. highlight grid for movement.
	if (activated == false && character.moving == false)
	{
		global.selectedCharacter = character;
		global.selectedSquare = self;
		map.movingCharacter = character;
		Activate(self, character.maxMove);
	}
}
else if (activated && interaction != 0)
{
	interaction.Execute(interaction);
}
else if (activated && map.movingCharacter != 0)
{
	//if a character is already selected and we're waiting to move, move.
	show_debug_message("Moving " + string(map.movingCharacter) + " to " + string(coordinate));
		
	MoveCharacter(map.movingCharacter, self);
		
	map.movingCharacter = 0;
}