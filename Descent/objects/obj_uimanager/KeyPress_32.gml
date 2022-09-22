/// @description reselect


if (global.InCombat)
{
	global.selectedCharacter.currentSquare.Deactivate();
	global.selectedCharacter.currentSquare.ActivateRange(global.selectedCharacter.currentSquare, 6, global.selectedCharacter);
	
}