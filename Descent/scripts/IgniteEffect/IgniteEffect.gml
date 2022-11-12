// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function IgniteEffect(effect)
{
	show_debug_message("IgniteEffect");
	
	effect.character.ignited = true;
	ds_list_clear(effect.character.nodes);
	
	var nodeLength = array_length(effect.character.characterStats.nodeDeck)
	for (var i = 0; i < nodeLength; i++)
	{
		var node = effect.character.characterStats.nodeDeck[i];
		var loadedNode = global.FindCard(node.class, node.type, node.element, node.rarity, node.index);
		
		if (loadedNode != 0) ds_list_add(effect.character.nodes, loadedNode);
		else show_debug_message("Invalid card info: " + string(node));
	}
	effect.character.nodes = RandomizeList(effect.character.nodes);
	
	var extraLength = array_length(effect.character.characterStats.extraDeck)
	for (var i = 0; i < extraLength; i++)
	{
		var rune = effect.character.characterStats.extraDeck[i];
		var loadedRune = global.FindCard(rune.class, rune.type, rune.element, rune.rarity, rune.index);
		
		if (loadedRune != 0) ds_list_add(effect.character.extra, loadedRune);
		else show_debug_message("Invalid card info: " + string(rune));
	}

	
	repeat(5)
	{
		var draw = global.BaseEffect();
		draw.Start = method(global, global.DrawCardEffect);
		draw.character = effect.character;
		
		AddEffect(draw);
	}
	
	EndEffect();
}