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
	
		/*for (var i = encounter.startIndex; i <= encounter.endIndex; i++)
		{
			var character = ds_list_find_value(map.spawnedCharacters, i);
			ds_list_add(global.Combatants, character);
		}*/
		
		randomize();
		
		var combatantSize = ds_list_size(global.Combatants)
		for (var i = 0; i < combatantSize; i++)
		{
			var character = ds_list_find_value(global.Combatants, i);
			var targetSquare = character.currentSquare;
			if (!targetSquare.validRange)
			{
				if (character.characterStats.flying) character.currentSquare.ActivateFlying(character.currentSquare, 15, character);
				else character.currentSquare.Activate(character.currentSquare, 15, character);
				
				for (var j = 0; j < ds_list_size(character.currentSquare.activatedSquares); j++)
				{
					var square = ds_list_find_value(character.currentSquare.activatedSquares, j);
					
					if (square != 0 && square.validRange)
					{
						targetSquare = square;
						break;
					}
				}
				
				MoveCharacter(character, targetSquare);
				character.currentSquare.Deactivate();
			}
			else MoveCharacter(character, targetSquare);
		}

		var startTurnEffect = global.BaseEffect();
		startTurnEffect.Start = method(global, global.StartTurnEffect);
	
		AddEffect(startTurnEffect);
	}
	
	
}


global.TurnCounter = 0;
global.Combatants = ds_list_create();