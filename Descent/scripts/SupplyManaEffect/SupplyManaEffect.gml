// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SupplyManaEffect(effect)
{
	switch (effect.element)
	{
		case Elements.W:
			effect.character.wPool += effect.amount;
		break;
		case Elements.F:
			effect.character.fPool += effect.amount;
		break;
		case Elements.M:
			effect.character.mPool += effect.amount;
		break;
		case Elements.S:
			effect.character.sPool += effect.amount;
		break;
		case Elements.E:
			effect.character.ePool += effect.amount;
		break;
		case Elements.D:
			effect.character.dPool += effect.amount;
		break;
		case Elements.V:
			effect.character.vPool += effect.amount;
		break;
	}
	
	EndEffect();
}