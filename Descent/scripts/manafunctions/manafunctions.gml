// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

CheckAvailableMana = function(character, card)
{
	//show_debug_message("Checking Available Mana...");
	var manaAvailable = false;
	
	if (card.type == CardTypes.Node)
	{
		var currentW = character.wPool;
		var currentF = character.fPool;
		var currentM = character.mPool;
		var currentS = character.sPool;
		var currentE = character.ePool;
		var currentD = character.dPool;
		var currentV = character.vPool;
	
		var targetW = card.wCost;
		var targetF = card.fCost;
		var targetM = card.mCost;
		var targetS = card.sCost;
		var targetE = card.eCost;
		var targetD = card.dCost;
		var targetV = card.vCost;
		
		if (targetW > 0)
		{
			if (currentW > 0)
			{
				var foundW = clamp(currentW, 0, targetW);
				
				targetW -= foundW;
				currentW -= foundW;
			}
		}
		if (targetF > 0)
		{
			if (currentF > 0)
			{
				var foundF = clamp(currentF, 0, targetF);
				
				targetF -= foundF;
				currentF -= foundF;
			}
		}
		if (targetM > 0)
		{
			if (currentM > 0)
			{
				var foundM = clamp(currentM, 0, targetM);
				
				targetM -= foundM;
				currentM -= foundM;
			}
		}
		if (targetS > 0)
		{
			if (currentS > 0)
			{
				var foundS = clamp(currentS, 0, targetS);
				
				targetS -= foundS;
				currentS -= foundS;
			}
		}
		if (targetE > 0)
		{
			if (currentE > 0)
			{
				var foundE = clamp(currentE, 0, targetE);
				
				targetE -= foundE;
				currentE -= foundE;
			}
		}
		if (targetD > 0)
		{
			if (currentD > 0)
			{
				var foundD = clamp(currentD, 0, targetD);
				
				targetD -= foundD;
				currentD -= foundD;
			}
		}
		if (targetV > 0)
		{
			if (currentV > 0)
			{
				var foundV = clamp(currentV, 0, targetV);
				
				targetV -= foundV;
				currentV -= foundV;
				
			}
			if (targetV > 0 && currentW > 0)
			{
				var foundW = clamp(currentW, 0, targetV);
				
				targetV -= foundW;
				currentW -= foundW;
			}
			if (targetV > 0 && currentF > 0)
			{
				var foundF = clamp(currentF, 0, targetV);
				
				targetV -= foundF;
				currentF -= foundF;
			}
			if (targetV > 0 && currentM > 0)
			{
				var foundM = clamp(currentM, 0, targetV);
				
				targetV -= foundM;
				currentM -= foundM;
			}
			if (targetV > 0 && currentS > 0)
			{
				var foundS = clamp(currentS, 0, targetV);
				
				targetV -= foundS;
				currentS -= foundS;
			}
			if (targetV > 0 && currentE > 0)
			{
				var foundE = clamp(currentE, 0, targetV);
				
				targetV -= foundE;
				currentE -= foundE;
			}
			if (targetV > 0 && currentD > 0)
			{
				var foundD = clamp(currentD, 0, targetV);
				
				targetV -= foundD;
				currentD -= foundD;
			}
		}
		
		if (targetW == 0 && targetF == 0 && targetM == 0 && targetS == 0 && targetE == 0 && targetD == 0 && targetV == 0) manaAvailable = true;
	}
	//show_debug_message("Mana available: " + string(manaAvailable));
	return manaAvailable;
}

CheckForExtraManaTypes = function(character, card)
{
	var extra = false;
	
	if (card.type == CardTypes.Node)
	{
		var currentW = character.wPool;
		var currentF = character.fPool;
		var currentM = character.mPool;
		var currentS = character.sPool;
		var currentE = character.ePool;
		var currentD = character.dPool;
		var currentV = character.vPool;
	
		var targetW = card.wCost;
		var targetF = card.fCost;
		var targetM = card.mCost;
		var targetS = card.sCost;
		var targetE = card.eCost;
		var targetD = card.dCost;
		var targetV = card.vCost;
		
		if (targetW > 0)
		{
			if (currentW > 0)
			{
				var foundW = clamp(currentW, 0, targetW);
				
				targetW -= foundW;
				currentW -= foundW;
			}
		}
		if (targetF > 0)
		{
			if (currentF > 0)
			{
				var foundF = clamp(currentF, 0, targetF);
				
				targetF -= foundF;
				currentF -= foundF;
			}
		}
		if (targetM > 0)
		{
			if (currentM > 0)
			{
				var foundM = clamp(currentM, 0, targetM);
				
				targetM -= foundM;
				currentM -= foundM;
			}
		}
		if (targetS > 0)
		{
			if (currentS > 0)
			{
				var foundS = clamp(currentS, 0, targetS);
				
				targetS -= foundS;
				currentS -= foundS;
			}
		}
		if (targetE > 0)
		{
			if (currentE > 0)
			{
				var foundE = clamp(currentE, 0, targetE);
				
				targetE -= foundE;
				currentE -= foundE;
			}
		}
		if (targetD > 0)
		{
			if (currentD > 0)
			{
				var foundD = clamp(currentD, 0, targetD);
				
				targetD -= foundD;
				currentD -= foundD;
			}
		}
		if (targetV > 0)
		{
			if (currentV > 0)
			{
				if (targetV <= currentV) extra = false;
				else if (currentW > 0 || currentF > 0 || currentM > 0 || currentS > 0 || currentE > 0 || currentD > 0) extra = true;
			}
			else if (currentW > 0)
			{
				if (currentF > 0 || currentM > 0 || currentS > 0 || currentE > 0 || currentD > 0) extra = true;
			}
			else if (currentF > 0)
			{
				if (currentM > 0 || currentS > 0 || currentE > 0 || currentD > 0) extra = true;
			}
			else if (currentM > 0)
			{
				if (currentS > 0 || currentE > 0 || currentD > 0) extra = true;
			}
			else if (currentS > 0)
			{
				if (currentE > 0 || currentD > 0) extra = true;
			}
			else if (currentE > 0)
			{
				if (currentD > 0) extra = true;
			}
		}
		else extra = false;
	}
	//show_debug_message("Mana available: " + string(manaAvailable));
	return extra;
}

AutoSpendMana = function(character, card)
{
	var spendPool =
	{
		wPool : 0,
		fPool : 0,
		mPool : 0,
		sPool : 0,
		ePool : 0,
		dPool : 0,
		vPool : 0
	}
	if (card.type == CardTypes.Node)
	{
		var currentW = character.wPool;
		var currentF = character.fPool;
		var currentM = character.mPool;
		var currentS = character.sPool;
		var currentE = character.ePool;
		var currentD = character.dPool;
		var currentV = character.vPool;
	
		var targetW = card.wCost;
		var targetF = card.fCost;
		var targetM = card.mCost;
		var targetS = card.sCost;
		var targetE = card.eCost;
		var targetD = card.dCost;
		var targetV = card.vCost;
		
		if (targetW > 0)
		{
			if (currentW > 0)
			{
				var foundW = clamp(currentW, 0, targetW);
				
				targetW -= foundW;
				currentW -= foundW;
				spendPool.wPool += foundW;
			}
		}
		if (targetF > 0)
		{
			if (currentF > 0)
			{
				var foundF = clamp(currentF, 0, targetF);
				
				targetF -= foundF;
				currentF -= foundF;
				spendPool.fPool += foundF;
			}
		}
		if (targetM > 0)
		{
			if (currentM > 0)
			{
				var foundM = clamp(currentM, 0, targetM);
				
				targetM -= foundM;
				currentM -= foundM;
				spendPool.mPool += foundM;
			}
		}
		if (targetS > 0)
		{
			if (currentS > 0)
			{
				var foundS = clamp(currentS, 0, targetS);
				
				targetS -= foundS;
				currentS -= foundS;
				spendPool.sPool += foundS;
			}
		}
		if (targetE > 0)
		{
			if (currentE > 0)
			{
				var foundE = clamp(currentE, 0, targetE);
				
				targetE -= foundE;
				currentE -= foundE;
				spendPool.ePool += foundE;
			}
		}
		if (targetD > 0)
		{
			if (currentD > 0)
			{
				var foundD = clamp(currentD, 0, targetD);
				
				targetD -= foundD;
				currentD -= foundD;
				spendPool.dPool += foundD;
			}
		}
		if (targetV > 0)
		{
			if (currentV > 0)
			{
				var foundV = clamp(currentV, 0, targetV);
				
				targetV -= foundV;
				currentV -= foundV;
				spendPool.vPool += foundV;
				
			}
			if (targetV > 0 && currentW > 0)
			{
				var foundW = clamp(currentW, 0, targetV);
				
				targetV -= foundW;
				currentW -= foundW;
				spendPool.wPool += foundW;
			}
			if (targetV > 0 && currentF > 0)
			{
				var foundF = clamp(currentF, 0, targetV);
				
				targetV -= foundF;
				currentF -= foundF;
				spendPool.fPool += foundF;
			}
			if (targetV > 0 && currentM > 0)
			{
				var foundM = clamp(currentM, 0, targetV);
				
				targetV -= foundM;
				currentM -= foundM;
				spendPool.mPool += foundM;
			}
			if (targetV > 0 && currentS > 0)
			{
				var foundS = clamp(currentS, 0, targetV);
				
				targetV -= foundS;
				currentS -= foundS;
				spendPool.sPool += foundS;
			}
			if (targetV > 0 && currentE > 0)
			{
				var foundE = clamp(currentE, 0, targetV);
				
				targetV -= foundE;
				currentE -= foundE;
				spendPool.ePool += foundE;
			}
			if (targetV > 0 && currentD > 0)
			{
				var foundD = clamp(currentD, 0, targetV);
				
				targetV -= foundD;
				currentD -= foundD;
				spendPool.dPool += foundD;
			}
		}
	}
	
	return spendPool;
}

CheckSpendPoolForRequirements = function(card)
{
	var pool = global.UiManager.selectSpendPool;
	
	var manaAvailable = false;
	
	if (card.type == CardTypes.Node)
	{
		var currentW = pool.wPool;
		var currentF = pool.fPool;
		var currentM = pool.mPool;
		var currentS = pool.sPool;
		var currentE = pool.ePool;
		var currentD = pool.dPool;
		var currentV = pool.vPool;
	
		var targetW = card.wCost;
		var targetF = card.fCost;
		var targetM = card.mCost;
		var targetS = card.sCost;
		var targetE = card.eCost;
		var targetD = card.dCost;
		var targetV = card.vCost;
		
		if (targetW > 0)
		{
			if (currentW > 0)
			{
				var foundW = clamp(currentW, 0, targetW);
				
				targetW -= foundW;
				currentW -= foundW;
			}
		}
		if (targetF > 0)
		{
			if (currentF > 0)
			{
				var foundF = clamp(currentF, 0, targetF);
				
				targetF -= foundF;
				currentF -= foundF;
			}
		}
		if (targetM > 0)
		{
			if (currentM > 0)
			{
				var foundM = clamp(currentM, 0, targetM);
				
				targetM -= foundM;
				currentM -= foundM;
			}
		}
		if (targetS > 0)
		{
			if (currentS > 0)
			{
				var foundS = clamp(currentS, 0, targetS);
				
				targetS -= foundS;
				currentS -= foundS;
			}
		}
		if (targetE > 0)
		{
			if (currentE > 0)
			{
				var foundE = clamp(currentE, 0, targetE);
				
				targetE -= foundE;
				currentE -= foundE;
			}
		}
		if (targetD > 0)
		{
			if (currentD > 0)
			{
				var foundD = clamp(currentD, 0, targetD);
				
				targetD -= foundD;
				currentD -= foundD;
			}
		}
		if (targetV > 0)
		{
			if (currentV > 0)
			{
				var foundV = clamp(currentV, 0, targetV);
				
				targetV -= foundV;
				currentV -= foundV;
				
			}
			if (targetV > 0 && currentW > 0)
			{
				var foundW = clamp(currentW, 0, targetV);
				
				targetV -= foundW;
				currentW -= foundW;
			}
			if (targetV > 0 && currentF > 0)
			{
				var foundF = clamp(currentF, 0, targetV);
				
				targetV -= foundF;
				currentF -= foundF;
			}
			if (targetV > 0 && currentM > 0)
			{
				var foundM = clamp(currentM, 0, targetV);
				
				targetV -= foundM;
				currentM -= foundM;
			}
			if (targetV > 0 && currentS > 0)
			{
				var foundS = clamp(currentS, 0, targetV);
				
				targetV -= foundS;
				currentS -= foundS;
			}
			if (targetV > 0 && currentE > 0)
			{
				var foundE = clamp(currentE, 0, targetV);
				
				targetV -= foundE;
				currentE -= foundE;
			}
			if (targetV > 0 && currentD > 0)
			{
				var foundD = clamp(currentD, 0, targetV);
				
				targetV -= foundD;
				currentD -= foundD;
			}
		}
		
		if (targetW == 0 && targetF == 0 && targetM == 0 && targetS == 0 && targetE == 0 && targetD == 0 && targetV == 0) manaAvailable = true;
	}
	//show_debug_message("Mana available: " + string(manaAvailable));
	return manaAvailable;
}

CheckForViableLusium = function(character, card)
{
	
	var foundLusium = array_create(0);
	
	if ((card.type == CardTypes.Rune || card.type == CardTypes.Manifest) && !card.playedThisTurn)
	{
		//search through all lusium
		for (var i = 0; i < ds_list_size(character.burntLusium); i++)
		{
			var lusium = ds_list_find_value(character.burntLusium, i);
			if (lusium != 0 && lusium.capacity >= ds_list_size(card.costList))
			{
				var parsedCosts = array_create(0);
				//make sure the lusium fulfills all costs
				for (var j = 0; j < ds_list_size(card.costList); j++)
				{
					var cost = ds_list_find_value(card.costList, j);
					
					var validCards = ds_list_create();
					//search through all cards on lusium piece
					for (var k = 0; k < ds_list_size(lusium.heldCards); k++)
					{
						var checkCard = ds_list_find_value(lusium.heldCards, k);

						if (checkCard != 0)
						{
							var cardViable = true;
							//check through all cards on that piece of lusium for the current cost.
							for (var l = 0; l < ds_list_size(cost); l++)
							{
								var costString = ds_list_find_value(cost, l);
							
								//show_debug_message("Checking word: " + costString + " to type: " + checkCard.typeText);
							
								var checkPos = string_pos(costString, checkCard.typeText);
							
								//show_debug_message("Check result is: " + string(checkPos));
								//if any of the cost words cannot be found, the card is not viable
								if (checkPos <= 0)
								{
									//show_debug_message("Checking word: " + costString + " to title: " + checkCard.title);
									checkPos = string_pos(costString, checkCard.title);
									//show_debug_message("Check result is: " + string(checkPos));
									if (checkPos <= 0)
									{
										cardViable = false;
										break;
									}
								
								}
							}
							//if the current card is viable
							if (cardViable)
							{
								ds_list_add(validCards, checkCard);
							}
						}
						

					}
					
					array_push(parsedCosts, validCards);
				}
				
				var singularCards = ds_list_create();
				var validLusium = true;
				//search through our parsed costs
				for (var j = 0; j < array_length(parsedCosts); j++)
				{
					//if we only have 1 viable card
					var cardList = parsedCosts[j];
					if (ds_list_size(cardList) == 1)
					{
						var single = ds_list_find_value(cardList, 0);
						//if singularCards already has this card
						if (ds_list_find_index(singularCards, single) >= 0)
						{
							//cost is invalid. Need a different piece of lusium.
							validLusium = false;
							break;
						}
						//else, add the card to singularCards
						else ds_list_add(singularCards, single)
					}
					else if (ds_list_size(cardList) == 0) validLusium = false;
				}
				
				if (validLusium)
				{
					//show_debug_message("Valid Lusium Found: " + string(i));
					array_push(foundLusium, i);
				}
			}

		}
		
	}
	
	return foundLusium;
}