// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayNodeEffect(effect)
{
	var card = ds_list_find_value(effect.character.hand, effect.index);
	

	var lusium = ds_list_find_value(effect.character.burntLusium, effect.lusiumIndex);
	ds_list_add(lusium.heldCards, card);
	
	ds_list_delete(effect.character.hand, effect.index);
	
	effect.character.AddArtToQueue(card);
				
	EndEffect();
}