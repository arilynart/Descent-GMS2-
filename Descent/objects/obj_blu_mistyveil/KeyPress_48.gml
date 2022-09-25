/// @description Save map


//make save array

var saveStruct =
{
	mapName: self.mapName,
	walls : self.walls,
	invalidRange : self.invalidRange,
	rangeWalls : self.rangeWalls,
	flyingWalls : self.flyingWalls,
	mapWidth : self.mapWidth,
	mapHeight : self.mapHeight
}

//turn into json and save via buffer
var saveString = json_stringify(saveStruct);
var buffer = buffer_create(string_byte_length(saveString) + 1, buffer_fixed, 1);
buffer_write(buffer, buffer_string, saveString);
buffer_save(buffer, string(mapName) + " SAVE.json");
buffer_delete(buffer);

show_debug_message("Map saved: " + string(mapName) + " SAVE.json || " + string(saveString));