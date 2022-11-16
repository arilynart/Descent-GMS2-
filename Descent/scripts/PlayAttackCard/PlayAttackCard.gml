// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.ActionComplete = false;

function PlayAttackCard(character, index)
{
	CO_PARAMS.character = character;
	CO_PARAMS.index = index;
	
	return CO_BEGIN
	
		card = ds_list_find_value(character.threatCards, index);
	
		attacker = card.owner;
	
		if (global.selectedCharacter.storedActivation != 0) global.selectedCharacter.currentSquare.Deactivate(global.selectedCharacter.storedActivation);
	
		previousCharacter = global.selectedCharacter;
		
		attacker.currentSquare.Select();
	
		global.ControlEnemyLock = true;
		
		i = 0;
		REPEAT array_length(card.actions) THEN
			
			var action = card.actions[i];
			
			action.Select(character, attacker, card, action.data);
			
			AWAIT (global.ActionComplete) THEN
			
			global.ActionComplete = false;
			
			i++;
		END

		global.ControlEnemyLock = false;
		
		previousCharacter.currentSquare.Select();
		
	CO_END;
}

function CompleteAction()
{
	show_debug_message("Action Complete.");
	global.ActionComplete = true;
}