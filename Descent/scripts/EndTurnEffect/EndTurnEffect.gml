// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EndTurnEffect(effect)
{
	for (var j = 0; j < array_length(global.Allies); j++)
	{
		var char = global.Allies[j];
		char.maxMove = char.characterStats.baseMaxMove;
		char.currentAp = char.maxAp;
		char.currentSquare.Deactivate();
		char.ResetLoaded();

		ds_list_clear(char.lockedHandCards);
	
		if (char.ignited)
		{
			for (var i = 0; i < ds_list_size(char.extra); i++)
			{
				var card = ds_list_find_value(char.extra, i);
		
				if (card != 0 && card.type != CardTypes.Node) card.playedThisTurn = false;
			}
		
			//supply hand, draw new 5
			var discardHandEffect = global.BaseEffect();
			discardHandEffect.Start = method(global, global.SupplyWholeHandEffect);
			discardHandEffect.character = char;
	
			AddEffect(discardHandEffect);
	
			repeat(5)
			{
				var draw = global.BaseEffect();
				draw.Start = method(global, global.DrawCardEffect);
				draw.character = char;
		
				AddEffect(draw);
			}
		
		}
	}
	
	var startTurnEffect = global.BaseEffect();
	startTurnEffect.Start = method(global, global.StartTurnEffect);
	
	AddEffect(startTurnEffect);
	
	EndEffect();
}