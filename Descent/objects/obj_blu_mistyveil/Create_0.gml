/// @description Spawn nodes for editing walls.

map = instance_find(obj_Map, 0);

wallPoints = ds_list_create();

walls = array_create(0);
interactables = ds_list_create();

displaying = true;

mapWidth = 16;
mapHeight = 26
mapPad = 1;

mapName = "Misty Veil"

//load walls.

var fileName = string(mapName) + " SAVE.json"

if (file_exists(fileName))
{
	var buffer = buffer_load(fileName);
	var loadString = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);
	
	var loadedData = json_parse(loadString);
	mapName = loadedData.mapName;
	walls = loadedData.walls;
	mapWidth = loadedData.mapWidth;
	mapHeight = loadedData.mapHeight;
}

#region interactables

#region interaction methods

function PickupDialogue(interaction)
{
	var item = interaction.item;
	var adjacent = global.PlayerAdjacent(other, false);
	show_debug_message("Adjacent? " + string(adjacent));
	var quant = "";
	if (adjacent != 0)
	{
		var dialogueArray = array_create(0);
		if (item.quantity > 1) quant = " x" + string(item.quantity);
		array_push(dialogueArray, "You pick up " + global.FindItem(item.type, item.index, item.quantity).name + quant + ".");
		AutoPickup(adjacent, item);
		DisplayDialogue(global.nameless, dialogueArray, true);
		other.interaction = 0;
	}
	else
	{
		var dialogueArray = array_create(0);
		array_push(dialogueArray, "Out of range.");
		DisplayDialogue(global.nameless, dialogueArray, true);
	}
}

#endregion
var item0 = 
{
	type : ItemTypes.Consumable,
	index : 0,
	quantity : 3,
	maxQuantity : global.FindItem(ItemTypes.Consumable, 0, 1).maxQuantity,
	pack : 0,
	slot : 0
}

firstTestInteractable = 
{
	x: 4,
	y: 21,
	Execute: method(id, PickupDialogue),
	item: item0,
	sprite: global.FindItem(item0.type, item0.index, item0.quantity).sprite
}
secondTestInteractable = 
{
	x: 4,
	y: 22,
	Execute: method(id, PickupDialogue),
	item: item0,
	sprite: global.FindItem(item0.type, item0.index, item0.quantity).sprite
}


ds_list_add(interactables, firstTestInteractable, secondTestInteractable);

#endregion