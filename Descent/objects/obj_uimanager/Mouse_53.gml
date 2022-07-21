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
			if (inventoryDraw == i) inventoryDraw = -1;
			else inventoryDraw = i;
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
			//enable drawing for character stuff
			if (packDraw == i) packDraw = -1;
			else packDraw = i;
		}
	}
}