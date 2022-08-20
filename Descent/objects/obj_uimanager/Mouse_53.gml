/// @description UI events

if (global.SquareLock) return;

if (displayDialogue) AdvanceDialogue();
else
{
	for (var i = 0; (i < 6 && i < array_length(global.Allies)); i++)
	{
		var button = uiCharacterButtons[i];
	
		//if we're clicking on i's button
		if (mouseX >= button.left && mouseX <= button.right
		 && mouseY >= button.top && mouseY <= button.bottom)
		{
			//enable drawing for character stuff
			if (inventoryDraw == i)
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
			}
		}
		if (packDraw >= 0)
		{
			var pack = character.equippedPacks[packDraw];
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
					
						//itemDraw = -1;
						split = 0;
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
						character.equippedPacks[packDraw].contents[itemDraw].quantity -= splitValue;
						if (item.quantity <= 0)
						{
							global.ItemDiscard(character, pack, item);
						}
					
						splitItem.pack = -1;
						splitItem.slot = 0;
						tempItemPack.contents[0] = splitItem;
					
						split.Execute(character, tempItemPack, splitItem);
					
						split = 0;
					}
					else if (mouseX >= cancelSplit.left && mouseX <=  cancelSplit.right
							 && mouseY >= cancelSplit.top && mouseY <= cancelSplit.bottom)
					{
						show_debug_message("Cancel Click");
						split = 0;
					}
					else if (mouseX >= splitArea.left && mouseX <= splitArea.right
						&& mouseY >= splitArea.top && mouseY <= splitArea.bottom)
					{
						dragSplit = true;
					}
				}
			
			
			}
			else
			{
				itemDraw = -1;
			
			}
		}
	}
	
}