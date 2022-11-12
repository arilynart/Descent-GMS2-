// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.EffectList = ds_list_create();

BaseEffect = function()
{
	var struct =
	{
		character : 0,
		target : 0,
		Start : method(global, EmptyStartEffect),
		End : method(global, EmptyEndEffect)
	}
	return struct;
}

function PlayEffect()
{
	if (ds_list_size(global.EffectList) > 0)
	{
		var firstEffect = ds_list_find_value(global.EffectList, 0);
		firstEffect.Start(firstEffect);
	}
}

function AddEffect(effect)
{
	ds_list_add(global.EffectList, effect);
	if (ds_list_size(global.EffectList) == 1)
	{
		PlayEffect();
	}
}

function EndEffect()
{
	var firstEffect = ds_list_find_value(global.EffectList, 0);
	firstEffect.End(firstEffect);

	ds_list_delete(global.EffectList, 0);
	PlayEffect();

}

function EmptyStartEffect(effect)
{
	
}

function EmptyEndEffect(effect)
{
	
}