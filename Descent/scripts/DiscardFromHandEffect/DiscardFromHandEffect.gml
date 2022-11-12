// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DiscardFromHandEffect(effect)
{
	var card = ds_list_find_value(effect.character.hand, effect.index);
	ds_list_add(effect.character.discard, card);
	ds_list_delete(effect.character.hand, effect.index);
	
	var lock = ds_list_find_index(effect.character.lockedHandCards, effect.index);
	if (lock >= 0)
	{
		ds_list_delete(effect.character.lockedHandCards, lock);
	}
	
	EndEffect();
}