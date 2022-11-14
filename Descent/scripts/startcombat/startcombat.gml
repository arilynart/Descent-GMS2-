// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function StartCombat(index)
{
	var map = instance_find(obj_Map, 0);
	var encounter = ds_list_find_value(map.blueprint.encounters, index);
	
	show_debug_message("Starting Combat");
	
	if (encounter.alive)
	{
		encounter.alive = false;
		
		global.cameraTarget.LockCamera(120);
		
		if (!global.InCombat)
		{
			ds_list_clear(global.Combatants);
		}
		
		global.InCombat = true;
		global.TurnCounter = 0;

		var allySize = array_length(global.Allies);
		for (var i = 0; i < allySize; i++)
		{
			var character = global.Allies[i];
			ds_list_add(global.Combatants, character);
		}
	
		for (var i = encounter.startIndex; i <= encounter.endIndex; i++)
		{
			var character = ds_list_find_value(map.spawnedCharacters, i);
			ds_list_add(global.Combatants, character);
		}
		
		randomize();
		
		var combatantSize = ds_list_size(global.Combatants)
		for (var i = 0; i < combatantSize; i++)
		{
			var character = ds_list_find_value(global.Combatants, i);
			show_debug_message("Checking combatant: " + string(character));
			var activation = 0;
			var targetSquare = character.currentSquare;
			
			if (character.characterStats.flying) var type = ParseTypes.Flying;
			else var type = ParseTypes.Standard;
			
			if (!targetSquare.validRange)
			{
				activation = character.currentSquare.Activate(15, character, type);
				for (var j = 0; j < array_length(activation); j++)
				{
					var struct = activation[j];
					
					if (struct != 0 && struct.square.validRange)
					{
						targetSquare = struct.square;
						break;
					}
				}
			}
			else activation = character.currentSquare.Activate(0, character, type);
			
			MoveCharacter(character, targetSquare, activation);
		}

		var startTurnEffect = global.BaseEffect();
		startTurnEffect.Start = method(global, global.StartTurnEffect);
	
		AddEffect(startTurnEffect);
	}
	
	
}


global.TurnCounter = 0;
global.Combatants = ds_list_create();