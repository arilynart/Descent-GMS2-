/// @description Load map

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