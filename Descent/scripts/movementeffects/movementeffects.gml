// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


DashEffect = function(effect)
{
	//effect.character.currentSquare.Deactivate();
	effect.character.maxMove += effect.character.characterStats.baseMaxMove;
	if (global.selectedCharacter == effect.character) effect.character.currentSquare.Select();
	
	EndEffect();
}