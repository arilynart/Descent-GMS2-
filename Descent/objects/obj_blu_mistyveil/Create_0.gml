/// @description Spawn nodes for editing walls.

map = instance_find(obj_Map, 0);

wallPoints = ds_list_create();

walls = array_create(0);
interactables = ds_list_create();
characters = ds_list_create();

displaying = true;

mapWidth = 16;
mapHeight = 26
mapPad = 1;

mapName = "Misty Veil"

enum Maps
{
	MistyVeil
}

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

#region characters

playerSpawnX = 6;
playerSpawnY = 6;

var forsakenSoul0 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul0.spawnX = 9;
forsakenSoul0.spawnY = 24;

ds_list_add(characters, forsakenSoul0);

#endregion