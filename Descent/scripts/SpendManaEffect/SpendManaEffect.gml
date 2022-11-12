// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function SpendManaEffect(effect)
{
	effect.character.wPool = clamp(effect.character.wPool - effect.spendPool.wPool, 0, effect.character.wPool);
	effect.character.fPool = clamp(effect.character.fPool - effect.spendPool.fPool, 0, effect.character.fPool);
	effect.character.mPool = clamp(effect.character.mPool - effect.spendPool.mPool, 0, effect.character.mPool);
	effect.character.sPool = clamp(effect.character.sPool - effect.spendPool.sPool, 0, effect.character.sPool);
	effect.character.ePool = clamp(effect.character.ePool - effect.spendPool.ePool, 0, effect.character.ePool);
	effect.character.dPool = clamp(effect.character.dPool - effect.spendPool.dPool, 0, effect.character.dPool);
	effect.character.vPool = clamp(effect.character.vPool - effect.spendPool.vPool, 0, effect.character.vPool);
	
	EndEffect();
}