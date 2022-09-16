	/// @description Spawn nodes for editing walls.

map = instance_find(obj_Map, 0);

wallPoints = ds_list_create();

walls = array_create(0);
interactables = ds_list_create();
characters = ds_list_create();
encounters = ds_list_create();

displaying = false;


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

var item0 = 
{
	type : ItemTypes.Consumable,
	index : 0,
	quantity : 3,
	maxQuantity : global.FindItem(ItemTypes.Consumable, 0, 1).maxQuantity,
	pack : 0,
	slot : 0
}
var item1 = 
{
	type : ItemTypes.Lusium,
	index : 0,
	quantity : 25,
	maxQuantity : global.FindItem(ItemTypes.Lusium, 0, 1).maxQuantity,
	pack : 0,
	slot : 0
}
var item2 = 
{
	type : ItemTypes.Lusium,
	index : 1,
	quantity : 25,
	maxQuantity : global.FindItem(ItemTypes.Lusium, 0, 1).maxQuantity,
	pack : 0,
	slot : 0
}

var firstTestInteractable = 
{
	x: 4,
	y: 21,
	Execute: method(id, PickupDialogue),
	item: item0,
	sprite: global.FindItem(item0.type, item0.index, item0.quantity).sprite
}
var secondTestInteractable = 
{
	x: 4,
	y: 22,
	Execute: method(id, PickupDialogue),
	item: item0,
	sprite: global.FindItem(item0.type, item0.index, item0.quantity).sprite
}

var thirdTestInteractable = 
{
	x: 3,
	y: 21,
	Execute: method(id, PickupDialogue),
	item: item1,
	sprite: global.FindItem(item1.type, item1.index, 0).sprite
}
var fourthTestInteractable = 
{
	x: 3,
	y: 22,
	Execute: method(id, PickupDialogue),
	item: item2,
	sprite: global.FindItem(item2.type, item2.index, 0).sprite
}


ds_list_add(interactables, firstTestInteractable, secondTestInteractable, thirdTestInteractable, fourthTestInteractable);

#endregion

#region characters

playerSpawnX = 6;
playerSpawnY = 6;

var forsakenSoul0 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul0.spawnX = 9;
forsakenSoul0.spawnY = 24;
var forsakenSoul1 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul1.spawnX = 11;
forsakenSoul1.spawnY = 25;
var forsakenSoul2 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul2.spawnX = 8;
forsakenSoul2.spawnY = 24;
var forsakenSoul3 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul3.spawnX = 8;
forsakenSoul3.spawnY = 25;
var forsakenSoul4 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul4.spawnX = 14;
forsakenSoul4.spawnY = 25;
var forsakenSoul5 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul5.spawnX = 14;
forsakenSoul5.spawnY = 24;
var forsakenSoul6 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul6.spawnX = 14;
forsakenSoul6.spawnY = 22;
var forsakenSoul7 = global.FindCharacter(CharacterClass.Monster, 0);
forsakenSoul7.spawnX = 14;
forsakenSoul7.spawnY = 21;

ds_list_add(characters, forsakenSoul0, forsakenSoul1, /*forsakenSoul2, forsakenSoul3, forsakenSoul4, forsakenSoul5, forsakenSoul6, forsakenSoul7*/);

#endregion

#region combat encounters

var firstEncounterEver =
{
	startIndex : 0,
	endIndex : 1,
	alive : true,
	respawn : true,
	triggers : ds_list_create()
}
hallwayTrigger =
{
	x : 12,
	y : 23
}
ds_list_add(firstEncounterEver.triggers, hallwayTrigger);

ds_list_add(encounters, firstEncounterEver);

#endregion