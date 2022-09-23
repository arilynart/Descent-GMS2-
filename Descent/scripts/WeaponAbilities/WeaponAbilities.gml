// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
RangedAttackSelect = function(character, ability)
{
	character.currentSquare.Deactivate();
	character.currentSquare.ActivateRange(character.currentSquare, ability.range, character);
}

RangedAttackExecute = function(square)
{
	if (square.character != 0)
	{
		show_debug_message("Executing attack.");
		
		global.selectedCharacter.currentSquare.Deactivate();
		global.SelectSquareExecute = 0;
		
		global.selectedCharacter.currentAp--;
		
		var weaponData = global.selectedCharacter.characterStats.equippedWeapon;
		var weapon = global.FindItem(weaponData.type, weaponData.index, 0);
		
		var damage = ceil(global.selectedCharacter.characterStats.force * weapon.forceRatio);
		
		var dealDamage = global.BaseEffect();
		dealDamage.Start = method(global, global.DealDamageEffect);
		dealDamage.character = global.selectedCharacter;
		dealDamage.target = square.character;
		dealDamage.amount = damage;
		
		AddEffect(dealDamage)
	}
}