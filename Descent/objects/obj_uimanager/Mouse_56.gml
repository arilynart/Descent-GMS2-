/// @description release drag

dragSplit = false;

if (dragCard >= 0)
{
	var button = handDrawButton;
	var card = ds_list_find_value(global.selectedCharacter.hand, dragCard);
	
	if (mouseX >= button.left && mouseX <= button.right
		&& mouseY >= button.top && mouseY <= button.bottom)
	{
		//supply
		ds_list_add(global.selectedCharacter.lockedHandCards, dragCard);
	
		var discard = global.BaseEffect();
		discard.Start = method(global, global.DiscardFromHandEffect);
		discard.character = global.selectedCharacter;
		discard.index = dragCard;
	
		AddEffect(discard);
		
		if (card.wSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.W, card.wSupply);
		}
		if (card.fSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.F, card.fSupply);
		}
		if (card.mSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.M, card.mSupply);
		}
		if (card.sSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.S, card.sSupply);
		}
		if (card.eSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.E, card.eSupply);
		}
		if (card.dSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.D, card.dSupply);
		}
		if (card.vSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.V, card.vSupply);
		}
		
	}
	else
	{
		var droppedCard = false;
		for (var i = 0; i < array_length(loadedButtons); i++)
		{
			var button = loadedButtons[i];
		
			if (mouseX >= button.left && mouseX <= button.right
			 && mouseY >= button.top && mouseY <= button.bottom)
			{
				//check if we can pay the mana
				if (global.CheckAvailableMana(global.selectedCharacter, card))
				{
					//burn lusium
					for (var j = 0; j < ds_list_size(global.selectedCharacter.loadedLusium); j++)
					{
						var item = ds_list_find_value(global.selectedCharacter.loadedLusium, j);
						if (item != 0 && item.type == ItemTypes.Lusium && item.index == i && item.quantity > 0)
						{
							droppedCard = true;
							//if there's more than one way to spend mana
							if (global.CheckForExtraManaTypes(global.selectedCharacter, card))
							{
								// let the player choose how to spend it
								SetupForManaSpend(dragCard, card, i);
							}
							else
							{
								item.quantity--;
								if (item.quantity <= 0) ds_list_delete(global.selectedCharacter.loadedLusium, j);
								
								var newLusiumIndex = ds_list_size(global.selectedCharacter.burntLusium);
								var burn = global.BaseEffect();
								burn.Start = method(global, global.BurnLusiumEffect);
								burn.character = global.selectedCharacter;
								burn.lusiumIndex = i;
					
								AddEffect(burn);
								var spendPool = global.AutoSpendMana(global.selectedCharacter, card);
								PlayHandCard(global.selectedCharacter, spendPool, dragCard, newLusiumIndex);
							}
							break;
						}
					}
				}
			}
		}
		
		if (!droppedCard)
		{
			for (var i = 0; i < ds_list_size(global.selectedCharacter.burntLusium); i++)
			{
				var lusium = ds_list_find_value(global.selectedCharacter.burntLusium, i)
				var slotSize = ds_list_size(lusium.slotButtons)
				for (var j = 0; j < slotSize; j++)
				{
					var button = ds_list_find_value(lusium.slotButtons, j);
		
					if (mouseX >= button.left && mouseX <= button.right
					 && mouseY >= button.top && mouseY <= button.bottom)
					{
						if (ds_list_size(lusium.heldCards) < slotSize && global.CheckAvailableMana(global.selectedCharacter, card))
						{
							if (global.CheckForExtraManaTypes(global.selectedCharacter, card))
							{
								// let the player choose how to spend it
								SetupForManaSpend(dragCard, card, lusium);
							}
							else
							{
								var spendPool = global.AutoSpendMana(global.selectedCharacter, card);
								PlayHandCard(global.selectedCharacter, spendPool, dragCard, i);
							}
						}
						break;
					}
				}
			}
		}
	}
}
else if (dragSlot != 0)
{
	var button = handDrawButton;
	var dragLusium = ds_list_find_value(global.selectedCharacter.burntLusium, dragSlot.lusiumIndex);
	var card = ds_list_find_value(dragLusium.heldCards, dragSlot.slot);
	
	var slotDetach = true;

	if (mouseX >= button.left && mouseX <= button.right
		&& mouseY >= button.top && mouseY <= button.bottom
		&& card.type == CardTypes.Node)
	{
		//supply
		ds_list_add(global.selectedCharacter.discard, card);
		ds_list_delete(dragLusium.heldCards, dragSlot.slot);
		
		if (card.wSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.W, card.wSupply);
		}
		if (card.fSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.F, card.fSupply);
		}
		if (card.mSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.M, card.mSupply);
		}
		if (card.sSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.S, card.sSupply);
		}
		if (card.eSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.E, card.eSupply);
		}
		if (card.dSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.D, card.dSupply);
		}
		if (card.vSupply > 0)
		{
			SupplyFromCard(global.selectedCharacter, Elements.V, card.vSupply);
		}
		
		slotDetach = false;
	}
	else
	{
		for (var i = 0; i < ds_list_size(global.selectedCharacter.burntLusium); i++)
		{
			var lusium = ds_list_find_value(global.selectedCharacter.burntLusium, i)
			var slotSize = ds_list_size(lusium.slotButtons);
			
			for (var j = 0; j < slotSize; j++)
			{
				var button = ds_list_find_value(lusium.slotButtons, j);
		
				if (mouseX >= button.left && mouseX <= button.right
				 && mouseY >= button.top && mouseY <= button.bottom
				 && card.type != CardTypes.Node && dragSlot.lusiumIndex != i)
				{
					show_debug_message("Dropped non-node on Lusium " + string(i));
					
					//attach rune to lusium
					slotDetach = false;
					
					lusium.capacity++;
					ds_list_add(lusium.heldCards, card);
					
					if (dragLusium.capacity <= 1) ds_list_delete(global.selectedCharacter.burntLusium, dragSlot.lusiumIndex);
					else
					{
						dragLusium.capacity--;
						ds_list_delete(dragLusium.heldCards, dragSlot.slot);
					}
					
					break;
				}
			}
		}
		
		if (slotDetach && card.type != CardTypes.Node  && dragLusium.capacity > 1)
		{
			dragLusium.capacity--;
			ds_list_delete(dragLusium.heldCards, dragSlot.slot)
			
			var newLusium =
			{
				capacity : 1,
				heldCards : ds_list_create(),
				slotButtons : ds_list_create()
			}
			
			ds_list_add(newLusium.heldCards, card);
	
			ds_list_add(global.selectedCharacter.burntLusium, newLusium);
		}
	}
}

dragCard = -1;
dragSlot = 0;