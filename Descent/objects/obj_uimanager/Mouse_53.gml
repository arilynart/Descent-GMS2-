/// @description UI events


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
		for (var i = 0; i < array_length(uiItemButtons); i++)
		{
			var button = uiItemButtons[i];
		
			//if we're clicking on i's button
			if (mouseX >= button.left && mouseX <= button.right
			 && mouseY >= button.top && mouseY <= button.bottom)
			{
				//enable drawing for item stuff
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
		}
		if (itemDraw >= 0)
		{
			for (var i = 0; (i < array_length(uiMethodButtons) && i < 6); i++)
			{
				var button = uiMethodButtons[i];

				if (mouseX >= button.left && mouseX <= button.right
					&& mouseY >= button.top && mouseY <= button.bottom)
				{
					var character = global.Allies[inventoryDraw];
					var item = character.equippedPacks[packDraw].contents[itemDraw]
					ds_list_find_value(item.methods, i).Execute(character, item);
					
					itemDraw = -1;
					split = 0;
				}
			}
			if (splitArea != 0 && mouseX >= splitArea.left && mouseX <= splitArea.right
				&& mouseY >= splitArea.top && mouseY <= splitArea.bottom)
			{
				dragSplit = true;
			}
		}
	}
}