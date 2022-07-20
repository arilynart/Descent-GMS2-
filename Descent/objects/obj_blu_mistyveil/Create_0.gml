/// @description Spawn nodes for editing walls.

map = instance_find(obj_Map, 0);

wallPoints = ds_list_create();

walls = array_create(0);
interactables = ds_list_create();

displaying = true;

mapWidth = 16;
mapHeight = 26

mapName = "Misty Veil"

show_debug_overlay(true);

//all walls.

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

function BasicTest()
{
	show_debug_message("BasicTest Triggered.");
	//var targetSquare = map.squares[firstTestInteractable.x, firstTestInteractable.y];
	var adjacent = global.PlayerAdjacent(other, true);
	show_debug_message("Adjacent? " + string(adjacent));
	if (adjacent == true)
	{
		show_debug_message("You pick up one of your belongings. A package of potions.");
	}
}

#endregion

firstTestInteractable = 
{
	x: 4,
	y: 21,
	i: method(id, BasicTest)
}

ds_list_add(interactables, firstTestInteractable);




#endregion