// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DiscardAttackEffect(effect)
{
	var card = ds_list_find_value(effect.character.threatCards, effect.index);
	
	ds_list_add(card.owner.discard, card);
	ds_list_delete(effect.character.threatCards, effect.index);
	
	EndEffect();
}