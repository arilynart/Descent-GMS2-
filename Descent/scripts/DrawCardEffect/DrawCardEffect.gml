// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DrawCardEffect(effect)
{
	show_debug_message("DrawCardEffect");
	
	if (ds_list_size(effect.character.nodes) <= 0 && ds_list_size(effect.character.discard > 0))
	{
		//reshuffle, remove top 2
		effect.character.nodes = RandomizeList(effect.character.discard);
		
		repeat(2)
		{
			var topCard = ds_list_find_value(effect.character.nodes, 0);
			ds_list_add(effect.character.removed, topCard);
			ds_list_delete(effect.character.nodes, 0);
		}
	}
	
	if (ds_list_size(effect.character.nodes) > 0)
	{
		var topCard = ds_list_find_value(effect.character.nodes, 0);
	
		//draw topCard
		ds_list_add(effect.character.hand, topCard);
		ds_list_delete(effect.character.nodes, 0);
	}
	
	EndEffect();
}