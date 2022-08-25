// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
StartTurnEffect = function(effect)
{
	//show_debug_message("StartTurnEffect");
	
	var turn = ds_list_find_value(global.Turns, 0);
	
	turn.character.currentSquare.Select();
	
	EndEffect();
}

EndTurnEffect = function(effect)
{
	var turn = ds_list_find_value(global.Turns, 0);
	turn.character.maxMove = turn.character.characterStats.baseMaxMove;
	turn.character.currentSquare.Deactivate();	
	
	ds_list_delete(global.Turns, 0);
	ds_list_add(global.Turns, turn);
	
	var startTurnEffect = global.BaseEffect();
	startTurnEffect.Start = method(global, global.StartTurnEffect);
	
	AddEffect(startTurnEffect);
	
	EndEffect();
}

function AutoEndTurn()
{
	var turnCharacter = ds_list_find_value(global.Turns, 0).character;
	var outOfMovement = (turnCharacter.maxMove < 1);
	
	//if we're out of stuff to do
	if (outOfMovement)
	{
		//end the turn
		var endTurn = global.BaseEffect();
		endTurn.Start = method(global, global.EndTurnEffect);
		
		AddEffect(endTurn);
	}
}