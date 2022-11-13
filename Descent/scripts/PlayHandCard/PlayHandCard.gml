// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayHandCard(character, spendPool, handIndex, lusiumIndex)
{
	//var card = ds_list_find_value(character.hand, handIndex);
	
	//play the card on a new piece of lusium, spend mana
	var spendMana = global.BaseEffect();
	spendMana.Start = method(global, global.SpendManaEffect);
	spendMana.character = global.selectedCharacter;
	spendMana.spendPool = spendPool;
						
	AddEffect(spendMana);
						
	var playNode = global.BaseEffect();
	playNode.Start = method(global, global.PlayNodeEffect);
	playNode.character = character;
	playNode.index = handIndex;
	playNode.lusiumIndex = lusiumIndex;
	
	AddEffect(playNode);
}