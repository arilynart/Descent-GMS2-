/// @description Spawn nodes for editing walls.

map = instance_find(obj_Map, 0);

wallPoints = ds_list_create();

walls = array_create(0);

displaying = true;

mapWidth = 16;
mapHeight = 26

mapName = "Misty Veil"

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