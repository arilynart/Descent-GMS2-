// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UpdateAllThreat()
{
	for (var i = 0; i < ds_list_size(global.Combatants); i++)
	{
		var character = ds_list_find_value(global.Combatants, i);
		
		if (character.characterStats.team != CharacterTeams.Ally)
		{
			character.UpdateThreat();
		}
	}
}