// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DrawEnemyCardEffect(effect)
{
	show_debug_message("DrawCardEffect");
	
	if (ds_list_size(effect.source.enemyDeck) <= 0 && ds_list_size(effect.source.discard > 0))
	{
		//reshuffle, remove top 2
		effect.source.enemyDeck = RandomizeList(effect.source.discard);
		
		effect.source.discard = ds_list_create();
	}
	
	if (ds_list_size(effect.source.enemyDeck) > 0)
	{
		var topCard = ds_list_find_value(effect.source.enemyDeck, 0);
	
		//draw topCard
		ds_list_add(effect.character.threatCards, topCard);
		ds_list_delete(effect.source.enemyDeck, 0);
	}
	
	EndEffect();
}