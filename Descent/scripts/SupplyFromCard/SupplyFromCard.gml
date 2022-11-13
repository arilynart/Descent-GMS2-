// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function SupplyFromCard(character, element, amount)
{
	
	var supply = global.BaseEffect();
	supply.Start = method(global, global.SupplyManaEffect);
	supply.character = character;
	supply.element = element;
	supply.amount = amount;
	
	AddEffect(supply);
	
}