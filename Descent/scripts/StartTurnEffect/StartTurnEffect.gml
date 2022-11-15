// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function StartTurnEffect(effect)
{
	show_debug_message("StartTurnEffect");
	
	global.TurnCounter++;
	
	global.Player.currentSquare.Select();
	
	for (var i = 0; i < ds_list_size(global.Combatants); i++)
	{
		var character = ds_list_find_value(global.Combatants, i);
		
		if (character.characterStats.team == CharacterTeams.Enemy)
		{
			if (character.threatTarget != 0)
			{
				repeat (character.characterStats.attacksPerTurn)
				{
					var draw = global.BaseEffect();
					draw.Start = method(global, global.DrawEnemyCardEffect);
					draw.source = character;
					draw.character = character.threatTarget;
		
					AddEffect(draw);
				}
			}
		}
	}
	
	EndEffect();
}