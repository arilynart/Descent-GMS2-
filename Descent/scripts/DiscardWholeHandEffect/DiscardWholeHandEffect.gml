// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DiscardWholeHandEffect(effect)
{
	while (ds_list_size(effect.character.hand) > 0)
	{
		var card = ds_list_find_value(effect.character.hand, 0);
		
		ds_list_add(effect.character.discard, card);
		ds_list_delete(effect.character.hand, 0);
	}
	
	EndEffect();
}