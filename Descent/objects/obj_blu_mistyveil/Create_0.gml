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

function PickupDialogue()
{
	var adjacent = global.PlayerAdjacent(other, false);
	show_debug_message("Adjacent? " + string(adjacent));
	if (adjacent != 0)
	{
		var dialogueArray = array_create(0);
		array_push(dialogueArray, "You pick up one of your belongings. A package of potions.");
		DisplayDialogue(global.nameless, dialogueArray, true);
		other.Interaction = 0;
	}
}

#endregion

firstTestInteractable = 
{
	x: 4,
	y: 21,
	i: method(id, PickupDialogue)
}

ds_list_add(interactables, firstTestInteractable);




#endregion