// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function StartTurnEffect(effect)
{
	show_debug_message("StartTurnEffect");
	
	global.TurnCounter++;
	
	global.Player.currentSquare.Select();
	
	
	EndEffect();
}