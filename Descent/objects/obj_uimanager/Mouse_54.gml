/// @description Insert description here
// You can write your code in this editor

if (global.ItemToMove != 0 && inventoryDraw >= 0)
{
	var character = global.Allies[inventoryDraw];
	ItemMovetoSlot(character, global.ItemToMove.pack, global.ItemToMove.slot);
}
else if (split != 0)
{
	split = 0;
	dragX = 0;
}
else if (itemDraw >= 0)
{
	var character = global.Allies[inventoryDraw];
	if (character.moving) return;
	for (var i = 0; (i < array_length(uiMethodButtons) && i < 6); i++)
	{
		var button = uiMethodButtons[i];

		if (mouseX >= button.left && mouseX <= button.right
			&& mouseY >= button.top && mouseY <= button.bottom)
		{

				var character = global.Allies[inventoryDraw];
				var item = character.equippedPacks[packDraw].contents[itemDraw]
				var tempMethod = ds_list_find_value(global.FindItem(item.type, item.index, item.quantity).methods, i);
			
				if (tempMethod.split)  
				{
					split = tempMethod;
				}
				
		}
	}
}