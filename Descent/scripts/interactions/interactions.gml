// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function PickupDialogue(square, interaction)
{
	var item = interaction.item;
	var adjacent = global.PlayerAdjacent(square, false);
	show_debug_message("Adjacent? " + string(adjacent));
	var quant = "";
	if (adjacent != 0)
	{
		var dialogueArray = array_create(0);
		if (item.quantity > 1) quant = " x" + string(item.quantity);
		array_push(dialogueArray, "You pick up " + global.FindItem(item.type, item.index, item.quantity).name + quant + ".");
		AutoPickup(adjacent, item);
		DisplayDialogue(global.nameless, dialogueArray);
		square.interaction = 0;
	}
	else
	{
		var dialogueArray = array_create(0);
		array_push(dialogueArray, "Out of range.");
		DisplayDialogue(global.nameless, dialogueArray);
	}
}