// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

SortCostArray = function(card)
{
	var costArray = array_create(0);
	if (card.wCost > 0)
	{
		repeat(card.wCost)
		{
			array_push(costArray, spr_W);
		}
	}
	if (card.fCost > 0)
	{
		repeat(card.fCost)
		{
			array_push(costArray, spr_F);
		}
	}
	if (card.mCost > 0)
	{
		repeat(card.mCost)
		{
			array_push(costArray, spr_M);
		}
	}
	if (card.sCost > 0)
	{
		repeat(card.sCost)
		{
			array_push(costArray, spr_S);
		}
	}
	if (card.eCost > 0)
	{
		repeat(card.eCost)
		{
			array_push(costArray, spr_E);
		}
	}
	if (card.dCost > 0)
	{
		repeat(card.dCost)
		{
			array_push(costArray, spr_D);
		}
	}
	if (card.vCost > 0)
	{
		repeat(card.vCost)
		{
			array_push(costArray, spr_V);
		}
	}
	
	return costArray;
}

SortSupplyArray = function(card)
{
	var supplyArray = array_create(0);
	if (card.wSupply > 0)
	{
		repeat(card.wSupply)
		{
			array_push(supplyArray, spr_W);
		}
	}
	if (card.fSupply > 0)
	{
		repeat(card.fSupply)
		{
			array_push(supplyArray, spr_F);
		}
	}
	if (card.mSupply > 0)
	{
		repeat(card.mSupply)
		{
			array_push(supplyArray, spr_M);
		}
	}
	if (card.sSupply > 0)
	{
		repeat(card.sSupply)
		{
			array_push(supplyArray, spr_S);
		}
	}
	if (card.eSupply > 0)
	{
		repeat(card.eSupply)
		{
			array_push(supplyArray, spr_E);
		}
	}
	if (card.dSupply > 0)
	{
		repeat(card.dSupply)
		{
			array_push(supplyArray, spr_D);
		}
	}
	if (card.vSupply > 0)
	{
		repeat(card.vSupply)
		{
			array_push(supplyArray, spr_V);
		}
	}
	
	return supplyArray;
}

SortPools = function(character)
{
	var array = array_create(0);
	
	if (character.wPool > 0)
	{
		var struct =
		{
			element : Elements.W,
			sprite : spr_W,
			amount : character.wPool - global.UiManager.selectSpendPool.wPool
		}
		array_push(array, struct);
	}
	if (character.fPool > 0)
	{
		var struct =
		{
			element : Elements.F,
			sprite : spr_F,
			amount : character.fPool - global.UiManager.selectSpendPool.fPool
		}
		array_push(array, struct);
	}
	if (character.mPool > 0)
	{
		var struct =
		{
			element : Elements.M,
			sprite : spr_M,
			amount : character.mPool - global.UiManager.selectSpendPool.mPool
		}
		array_push(array, struct);
	}
	if (character.sPool > 0)
	{
		var struct =
		{
			element : Elements.S,
			sprite : spr_S,
			amount : character.sPool - global.UiManager.selectSpendPool.sPool
		}
		array_push(array, struct);
	}
	if (character.ePool > 0)
	{
		var struct =
		{
			element : Elements.E,
			sprite : spr_E,
			amount : character.ePool - global.UiManager.selectSpendPool.ePool
		}
		array_push(array, struct);
	}
	if (character.dPool > 0)
	{
		var struct =
		{
			element : Elements.D,
			sprite : spr_D,
			amount : character.dPool - global.UiManager.selectSpendPool.dPool
		}
		array_push(array, struct);
	}
	if (character.vPool > 0)
	{
		var struct =
		{
			element : Elements.V,
			sprite : spr_V,
			amount : character.vPool
		}
		array_push(array, struct);
	}
	
	return array;
}

SortSpendPools = function()
{
	var array = array_create(0);
	
	if (global.UiManager.selectSpendPool.wPool > 0)
	{
		var struct =
		{
			element : Elements.W,
			sprite : spr_W,
			amount : global.UiManager.selectSpendPool.wPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.fPool > 0)
	{
		var struct =
		{
			element : Elements.F,
			sprite : spr_F,
			amount : global.UiManager.selectSpendPool.fPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.mPool > 0)
	{
		var struct =
		{
			element : Elements.M,
			sprite : spr_M,
			amount : global.UiManager.selectSpendPool.mPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.sPool > 0)
	{
		var struct =
		{
			element : Elements.S,
			sprite : spr_S,
			amount : global.UiManager.selectSpendPool.sPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.ePool > 0)
	{
		var struct =
		{
			element : Elements.E,
			sprite : spr_E,
			amount : global.UiManager.selectSpendPool.ePool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.dPool > 0)
	{
		var struct =
		{
			element : Elements.D,
			sprite : spr_D,
			amount : global.UiManager.selectSpendPool.dPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.vPool > 0)
	{
		var struct =
		{
			element : Elements.V,
			sprite : spr_V,
			amount : global.UiManager.selectSpendPool.vPool
		}
		array_push(array, struct);
	}
	
	return array;
}