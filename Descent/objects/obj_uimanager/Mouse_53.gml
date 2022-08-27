/// @description UI events

if (global.SquareLock) return;

if (displayDialogue) AdvanceDialogue();
else
{
	if (igniteButton != 0)
	{
		var button = igniteButton;
		
		if (mouseX >= button.left && mouseX <= button.right
		 && mouseY >= button.top && mouseY <= button.bottom)
		{
			//end turn
			var ignite = global.BaseEffect();
			ignite.Start = method(global, global.IgniteEffect);
			ignite.character = global.selectedCharacter
		
			AddEffect(ignite);
			
			return;
		}
	}
	else if (handDrawButton != 0)
	{
		var button = handDrawButton;
		
		if (mouseX >= button.left && mouseX <= button.right
		 && mouseY >= button.top && mouseY <= button.bottom)
		{
			//end turn
			handDraw = !handDraw;
			
			return;
		}
	}
	
	if (endTurnButton != 0)
	{
		var button = endTurnButton;
		
		if (mouseX >= button.left && mouseX <= button.right
		 && mouseY >= button.top && mouseY <= button.bottom)
		{
			//end turn
			
			prepLoad = false;
			
			var endTurn = global.BaseEffect();
			endTurn.Start = method(global, global.EndTurnEffect);
		
			AddEffect(endTurn);
			
			return;
		}
	}
	
	if (dashButton != 0)
	{
		var button = dashButton;
		
		if (mouseX >= button.left && mouseX <= button.right
		 && mouseY >= button.top && mouseY <= button.bottom)
		{
			//end turn
			var dash = global.BaseEffect();
			dash.Start = method(global, global.DashEffect);
			dash.character = global.selectedCharacter;
			
			dash.character.currentAp--;
		
			AddEffect(dash);
			
			return;
		}
	}
	if (loadButton != 0)
	{
		var button = loadButton;
		
		if (mouseX >= button.left && mouseX <= button.right
		 && mouseY >= button.top && mouseY <= button.bottom)
		{
			//end turn
			prepLoad = !prepLoad;
			
			return;
		}
	}
	
	for (var i = 0; (i < 6 && i < array_length(global.Allies)); i++)
	{
		var button = uiCharacterButtons[i];
	
		//if we're clicking on i's button
		if (mouseX >= button.left && mouseX <= button.right
		 && mouseY >= button.top && mouseY <= button.bottom)
		{
			var character = global.Allies[i]
			
			//enable drawing for character stuff
			if (global.selectedCharacter == character && inventoryDraw == i)
			{
				inventoryDraw = -1;
				packDraw = -1;
				itemDraw = -1;
				split = 0;
			}
			else
			{
				inventoryDraw = i;
				packDraw = -1;
				itemDraw = -1;
				split = 0;
			}
			character.currentSquare.Select();
			return;
		}
	}

	//check if a pack was pressed
	if (inventoryDraw >= 0)
	{
		var character = global.Allies[inventoryDraw];
		
		for (var i = 0; (i < 6 && i < array_length(uiPackButtons)); i++)
		{
			var button = uiPackButtons[i];
	
			//if we're clicking on i's button
			if (mouseX >= button.left && mouseX <= button.right
			 && mouseY >= button.top && mouseY <= button.bottom)
			{
				//enable drawing for pack stuff
				if (packDraw == i)
				{
					packDraw = -1;
					itemDraw = -1;
					split = 0;
				}
				else
				{
					packDraw = i;
					itemDraw = -1;
					split = 0;
					
				}
				return;
			}
		}
		if (packDraw >= 0)
		{
			var pack = character.characterStats.equippedPacks[packDraw];
			for (var i = 0; i < array_length(uiItemButtons); i++)
			{
				var button = uiItemButtons[i];
				
		
				//if we're clicking on i's button
				if (mouseX >= button.left && mouseX <= button.right
				 && mouseY >= button.top && mouseY <= button.bottom)
				{
					if (global.ItemToMove != 0)
					{
						var slot = pack.contents[i];
						
						if (slot != 0 && (slot.type != global.ItemToMove.type 
									  || slot.index != global.ItemToMove.index))
						{
							return;
						}
						
						ItemMovetoSlot(character, packDraw, i);
					}
					else
					{
						if (itemDraw == i) 
						{
							itemDraw = -1;
							split = 0;
						}
						else 
						{
							itemDraw = i;
							split = 0;
						}
					}
					//enable drawing for item stuff
					return;
				}
			}
		
			if (itemDraw >= 0 && pack.contents[itemDraw] != 0)
			{
				if (character.moving) return;
				var item = pack.contents[itemDraw];
				for (var i = 0; (i < array_length(uiMethodButtons) && i < 6); i++)
				{
					var button = uiMethodButtons[i];

					if (mouseX >= button.left && mouseX <= button.right
						&& mouseY >= button.top && mouseY <= button.bottom)
					{
					
					
						ds_list_find_value(global.FindItem(item.type, item.index, item.quantity).methods, i).Execute(character, pack, item);

						split = 0;
						return;
					}
					
				}
			
				if (split != 0)
				{
					if (mouseX >= confirmSplit.left && mouseX <=  confirmSplit.right
						&& mouseY >= confirmSplit.top && mouseY <= confirmSplit.bottom)
					{
						show_debug_message("Confirm Click");
						var splitItem = global.ItemCopy(item);
						splitItem.quantity = splitValue;
						character.characterStats.equippedPacks[packDraw].contents[itemDraw].quantity -= splitValue;
						if (item.quantity <= 0)
						{
							global.ItemDiscard(character, pack, item);
						}
					
						splitItem.pack = -1;
						splitItem.slot = 0;
						tempItemPack.contents[0] = splitItem;
					
						split.Execute(character, tempItemPack, splitItem);
					
						split = 0;
						return;
					}
					else if (mouseX >= cancelSplit.left && mouseX <=  cancelSplit.right
							 && mouseY >= cancelSplit.top && mouseY <= cancelSplit.bottom)
					{
						show_debug_message("Cancel Click");
						split = 0;
						return;
					}
					else if (mouseX >= splitArea.left && mouseX <= splitArea.right
						&& mouseY >= splitArea.top && mouseY <= splitArea.bottom)
					{
						dragSplit = true;
						return;
					}
				}
			
			
			}
			else
			{
				itemDraw = -1;
			}
		}
	}

	var square = instance_position(mouse_x, mouse_y, obj_Square);
	
	if ((global.UiLock && global.SquareLock == false) || (square != noone && square.map.blueprint.displaying) || global.UiManager.displayDialogue) return;
	
	//show_debug_message("Square Clicked: " + string(id) + " Coordinate: " + string(coordinate));

	if (square != noone) square.Select();
}