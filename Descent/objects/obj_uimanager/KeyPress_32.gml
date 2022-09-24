/// @description turn character select


if (global.InCombat)
{
	var character = ds_list_find_value(global.Turns, 0).character;
	character.currentSquare.Deactivate();
	character.currentSquare.Select();
	
}