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
	turn.character.currentAp = turn.character.maxAp;
	turn.character.currentSquare.Deactivate();
	turn.character.ResetLoaded();

	ds_list_clear(global.UiManager.lockedHandCards);
	
	if (turn.character.ignited)
	{
		for (var i = 0; i < ds_list_size(turn.character.extra); i++)
		{
			var card = ds_list_find_value(turn.character.extra, i);
		
			if (card != 0 && card.type != CardTypes.Node) card.playedThisTurn = false;
		}
		
		//supply hand, draw new 5
		var discardHandEffect = global.BaseEffect();
		discardHandEffect.Start = method(global, global.SupplyWholeHandEffect);
		discardHandEffect.character = turn.character;
	
		AddEffect(discardHandEffect);
	
		repeat(5)
		{
			var draw = global.BaseEffect();
			draw.Start = method(global, global.DrawCardEffect);
			draw.character = turn.character;
		
			AddEffect(draw);
		}
		
	}
	
	var sort = false;
	if (turn.character == global.EndCharacter) sort = true;
	
	ds_list_delete(global.Turns, 0);
	ds_list_add(global.Turns, turn);
	
	if (sort) SortInitiative();

	var startTurnEffect = global.BaseEffect();
	startTurnEffect.Start = method(global, global.StartTurnEffect);
	startTurnEffect.character = ds_list_find_value(global.Turns, 0).character;
	
	AddEffect(startTurnEffect);
	
	EndEffect();
}

function AutoEndTurn()
{
	var turnCharacter = ds_list_find_value(global.Turns, 0).character;
	var outOfMovement = (turnCharacter.maxMove < 1);
	var outOfAp = (turnCharacter.currentAp < 1);
	var outOfCards = (turnCharacter.ignited && ds_list_size(turnCharacter.hand) == 0);
	
	//if we're out of stuff to do
	if (outOfMovement && outOfAp && outOfCards)  
	{
		//end the turn
		var endTurn = global.BaseEffect();
		endTurn.Start = method(global, global.EndTurnEffect);
		
		AddEffect(endTurn);
	}
}