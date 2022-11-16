// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function FinishAction(character, source, card)
{
	
	
	var discard = global.BaseEffect();
	discard.Start = method(global, global.DiscardAttackEffect);
	discard.character = character;
	discard.index = index;
	
	AddEffect(discard);
}