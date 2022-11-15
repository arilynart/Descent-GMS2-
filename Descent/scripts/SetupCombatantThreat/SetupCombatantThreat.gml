// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetupCombatantThreat()
{
	global.CombatantsWithThreat = 0;
	
	var targetCombatants = 0;
	
	for (var i = 0; i < ds_list_size(global.Combatants); i++)
	{
		var character = ds_list_find_value(global.Combatants, i);
		if (character.characterStats.team == CharacterTeams.Enemy)
		{
			targetCombatants++;
		}
	}
	
	//CO_SCOPE = global;
	CO_PARAMS.targetCombatants = targetCombatants;
	
	return CO_BEGIN
	
	for (var i = 0; i < ds_list_size(global.Combatants); i++)
	{
		var character = ds_list_find_value(global.Combatants, i);
		
		if (character.characterStats.team != CharacterTeams.Ally)
		{
			ds_list_clear(character.threatPotential);
		
			for (var j = 0; j < ds_list_size(global.Combatants); j++)
			{
				if (j != i)
				{
					var otherCharacter = ds_list_find_value(global.Combatants, j);
		
					character.AddPotentialThreat(otherCharacter);
				}
			}
			
			character.UpdateThreat();
		}
		
			
	}
	
	AWAIT (global.CombatantsWithThreat >= targetCombatants) THEN
	
	show_debug_message("Combatants with threat: " + string(global.CombatantsWithThreat));

	global.CombatantsWithThreat = 0;
	
	var startTurnEffect = global.BaseEffect();
	startTurnEffect.Start = method(global, global.StartTurnEffect);
	
	AddEffect(startTurnEffect);
	
	CO_END
}

global.CombatantsWithThreat = 0;