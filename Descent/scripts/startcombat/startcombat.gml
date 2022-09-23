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
			ds_list_clear(global.Turns);
		}
		
		global.InCombat = true;

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
			MoveCharacter(character, character.currentSquare);
			
			//roll initiative
			var baseInitiative = character.characterStats.tempo * 10;
			var roll = irandom(15);
			var initiativeRoll = baseInitiative + roll;
			
			var existingTurnSize = ds_list_size(global.Turns);
			var validInitiative = false;
			
			while (!validInitiative)
			{
				
				validInitiative = true;
				
				for (var j = 0; j < existingTurnSize; j++)
				{
					var turn = ds_list_find_value(global.Turns, j);
					if (turn.initiative == initiativeRoll)
					{
						validInitiative = false;
						
						var newRoll = irandom(9);
						initiativeRoll = baseInitiative + newRoll;
					}
				}
			}
			
			var newTurn = 
			{
				character : character,
				initiative : initiativeRoll
			}
			
			ds_list_add(global.Turns, newTurn);
			
			show_debug_message(character.characterStats.name + " rolls initiative. Result is " + string(initiativeRoll));
		}
		
		//sort turns descending
		var sortedList = ds_list_create();
		var turnSize = ds_list_size(global.Turns);
		for (var i = 0; i < turnSize; i++)
		{
			//go through sorted list until the one we're adding has higher iniative than the next one or we reach the end of the list.
			var turnToSort = ds_list_find_value(global.Turns, i);
			var foundSlot = -1;
			var sortedSize = ds_list_size(sortedList);
			if (sortedSize == 0)
			{
				ds_list_add(sortedList, turnToSort);
			}
			else
			{
				for (var j = 0; j < sortedSize; j++)
				{
					var checkedTurn = ds_list_find_value(sortedList, j);
					if (checkedTurn.initiative < turnToSort.initiative)
					{
						foundSlot = j;
					}
				}
			
				if (foundSlot < 0) ds_list_add(sortedList, turnToSort);
				else ds_list_insert(sortedList, foundSlot, turnToSort);
			}
		}
		ds_list_destroy(global.Turns);
		global.Turns = sortedList;
	
		var startTurnEffect = global.BaseEffect();
		startTurnEffect.Start = method(global, global.StartTurnEffect);
		startTurnEffect.character = ds_list_find_value(global.Turns, 0).character;
	
		AddEffect(startTurnEffect);
	}
	
	
}

global.Combatants = ds_list_create();
global.Turns = ds_list_create();