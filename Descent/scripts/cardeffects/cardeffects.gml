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

BurnLusiumEffect = function(effect)
{
	var newLusium =
	{
		capacity : effect.lusiumIndex + 1,
		heldCards : ds_list_create(),
		slotButtons : ds_list_create()
	}
	
	ds_list_add(effect.character.burntLusium, newLusium);
	
	EndEffect();
}

PlayNodeEffect = function(effect)
{
	var card = ds_list_find_value(effect.character.hand, effect.index);
	

	var lusium = ds_list_find_value(effect.character.burntLusium, effect.lusiumIndex);
	ds_list_add(lusium.heldCards, card);
	
	ds_list_delete(effect.character.hand, effect.index);
	
	effect.character.AddArtToQueue(card);
				
	EndEffect();
}

PlayRuneEffect = function(effect)
{
	var card = ds_list_find_value(effect.character.extra, effect.index);
	var lusium = ds_list_find_value(effect.character.burntLusium, effect.lusiumIndex);
	
	//discard all cards attached to lusium
	for (var i = 0; i < ds_list_size(lusium.heldCards); i++)
	{
		var attachedCard = ds_list_find_value(lusium.heldCards, i);
		if (attachedCard != 0)
		{
			if (attachedCard.type == CardTypes.Node) ds_list_add(effect.character.discard, attachedCard);
			else ds_list_add(effect.character.extra, attachedCard);
		}
		
	}
	
	ds_list_clear(lusium.heldCards);
	
	//if card is permanent
	if (card.permanent)
	{
		//lusium capacity becomes 1
		lusium.capacity = 1;
		//play rune on lusium
		ds_list_add(lusium.heldCards, card);
		ds_list_delete(effect.character.extra, effect.index);
	}
	//else
	else
	{
		//destroy lusium
		ds_list_delete(effect.character.burntLusium, effect.lusiumIndex);
		//play rune effect
		
	}
	
	effect.character.AddArtToQueue(card);
	
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

SupplyManaEffect = function(effect)
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

SpendManaEffect = function(effect)
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

SupplyWholeHandEffect = function(effect)
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

DiscardFromHandEffect = function(effect)
{
	var card = ds_list_find_value(effect.character.hand, effect.index);
	ds_list_add(effect.character.discard, card);
	ds_list_delete(effect.character.hand, effect.index);
	
	var lock = ds_list_find_index(global.UiManager.lockedHandCards, effect.index);
	if (lock >= 0)
	{
		ds_list_delete(global.UiManager.lockedHandCards, lock);
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
	
	ds_list_destroy(list);
	return shuffledList;
}