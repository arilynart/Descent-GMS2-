/// @description reselect


if (global.InCombat)
{
	var character = global.selectedCharacter;
	character.currentSquare.Deactivate();
	character.currentSquare.Select();
	
}