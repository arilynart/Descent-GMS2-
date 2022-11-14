// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
RangedAttackSelect = function(character, ability)
{
	if (character.storedActivation != 0) character.currentSquare.Deactivate(character.storedActivation);
	character.storedActivation = character.currentSquare.Activate(ability.range, character, ParseTypes.Range);
	character.currentSquare.HighlightActivation(character.storedActivation);
}

MeleeAttackSelect = function(character, ability)
{
	if (character.storedActivation != 0) character.currentSquare.Deactivate(character.storedActivation);
	character.storedActivation = character.currentSquare.Activate(ability.range, character, ParseTypes.Range);
	character.currentSquare.HighlightActivation(character.storedActivation);
}

BasicAttackExecute = function(square)
{
	if (square.character != 0)
	{
		//show_debug_message("Executing attack.");
		var ability = global.UiManager.heldAbility;
		
		if (global.selectedCharacter.storedActivation != 0) global.selectedCharacter.currentSquare.Deactivate(global.selectedCharacter.storedActivation);
		global.SelectSquareExecute = 0;
		
		global.UiManager.heldAbility = 0;
		
		global.selectedCharacter.currentAp--;
		
		var damage = ceil(global.selectedCharacter.characterStats.force * ability.forceRatio);
		
		var dealDamage = global.BaseEffect();
		dealDamage.Start = method(global, global.DealDamageEffect);
		dealDamage.character = global.selectedCharacter;
		dealDamage.target = square.character;
		dealDamage.amount = damage;
		
		AddEffect(dealDamage);
	}
}