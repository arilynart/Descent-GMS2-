//ending the turn

function AiEndTurnGoal(character)
{
	var endTurn = global.BaseEffect();
	endTurn.Start = method(global, global.EndTurnEffect);
		
	AddEffect(endTurn);
}