// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

IgniteEffect = function(effect)
{
	effect.character.ignited = true;
	ds_list_clear(effect.character.nodes);
	
	var nodeLength = array_length(effect.character.characterStats.nodeDeck)
	for (var i = 0; i < nodeLength; i++)
	{
		var node = effect.character.characterStats.nodeDeck[i];
		var loadedNode = global.FindCard(node.class, node.type, node.element, node.rarity, node.index);
		
		if (loadedNode != 0) ds_list_add(effect.character.nodes, loadedNode);
	}
	
	effect.character.nodes = RandomizeList(effect.character.nodes);
	
	repeat(5)
	{
		var draw = global.BaseEffect();
		draw.Start = method(global, global.DrawCardEffect);
		draw.character = effect.character;
		
		AddEffect(draw);
	}
	
	EndEffect();
}

DrawCardEffect = function(effect)
{
	
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

DiscardWholeHandEffect = function(effect)
{
	while (ds_list_size(effect.character.hand) > 0)
	{
		var card = ds_list_find_value(effect.character.hand, 0);
		
		ds_list_add(effect.character.discard, card);
		ds_list_delete(effect.character.hand, 0);
	}
	
	EndEffect();
}

function RandomizeList(list)
{
	var shuffledList = ds_list_create();
	
	while (ds_list_size(list) > 0)
	{
		var roll = irandom(ds_list_size(list) - 1);
		
		var randomValue = ds_list_find_value(list, roll);
		
		ds_list_add(shuffledList, randomValue);
		ds_list_delete(list, roll);
	}
	
	return shuffledList;
}