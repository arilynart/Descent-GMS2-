// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
RangedAttackSelect = function(character, ability)
{
	character.currentSquare.Deactivate();
	character.currentSquare.ActivateRange(character.currentSquare, ability.range, character);
}

MeleeAttackSelect = function(character, ability)
{
	character.currentSquare.Deactivate();
	character.currentSquare.Activate(character.currentSquare, ability.range, character);
}

BasicAttackExecute = function(square)
{
	if (square.character != 0)
	{
		//show_debug_message("Executing attack.");
		var ability = global.UiManager.heldAbility;
		
		global.selectedCharacter.currentSquare.Deactivate();
		global.SelectSquareExecute = 0;
		
		
		global.UiManager.heldAbility = 0;
		
		global.selectedCharacter.currentAp--;
		
		var damage = ceil(global.selectedCharacter.characterStats.force * ability.forceRatio);
		
		var dealDamage = global.BaseEffect();
		dealDamage.Start = method(global, global.DealDamageEffect);
		dealDamage.character = global.selectedCharacter;
		dealDamage.target = square.character;
		dealDamage.amount = damage;
		
		AddEffect(dealDamage)
	}
}