// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SupplyWholeHandEffect(effect)
{
	while (ds_list_size(effect.character.hand) > 0)
	{
		var card = ds_list_find_value(effect.character.hand, 0);
		
		effect.character.wPool += card.wSupply;
		effect.character.fPool += card.fSupply;
		effect.character.mPool += card.mSupply;
		effect.character.sPool += card.sSupply;
		effect.character.ePool += card.eSupply;
		effect.character.dPool += card.dSupply;
		effect.character.vPool += card.vSupply;
		
		ds_list_add(effect.character.discard, card);
		ds_list_delete(effect.character.hand, 0);
	}
	
	EndEffect();
}