	/// @description Spawn nodes for editing walls.

map = instance_find(obj_Map, 0);

wallPoints = ds_list_create();

walls = array_create(0);
rangeWalls = array_create(0);
invalidRange = array_create(0);
interactables = ds_list_create();
characters = ds_list_create();
encounters = ds_list_create();

displaying = false;


mapPad = 1;

mapName = "Misty Veil"

enum RangeWallTypes
{
	FullBlock,
	AllowUpToDown,
	AllowLeftToRight,
	AllowRightToLeft
}

enum WallModes
{
	Move,
	Range
}

currentMode = WallModes.Move;
currentRangeMode = RangeWallTypes.FullBlock;

#region load walls.
var fileName = string(mapName) + " SAVE.json"

if (file_exists(fileName))
{
	var buffer = buffer_load(fileName);
	var loadString = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);
	
	var loadedData = json_parse(loadString);
	mapName = loadedData.mapName;
	walls = loadedData.walls;
	invalidRange = loadedData.invalidRange;
	rangeWalls = loadedData.rangeWalls;
	mapWidth = loadedData.mapWidth;
	mapHeight = loadedData.mapHeight;
}





#endregion

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
	x: 10,
	y: 11,
	Execute: method(id, PickupDialogue),
	item: item0,
	sprite: global.FindItem(item0.type, item0.index, item0.quantity).sprite
}
var secondTestInteractable = 
{
	x: 10,
	y: 12,
	Execute: method(id, PickupDialogue),
	item: item0,
	sprite: global.FindItem(item0.type, item0.index, item0.quantity).sprite
}

var thirdTestInteractable = 
{
	x: 9,
	y: 11,
	Execute: method(id, PickupDialogue),
	item: item1,
	sprite: global.FindItem(item1.type, item1.index, 0).sprite
}
var fourthTestInteractable = 
{
	x: 9,
	y: 12,
	Execute: method(id, PickupDialogue),
	item: item2,
	sprite: global.FindItem(item2.type, item2.index, 0).sprite
}


ds_list_add(interactables, firstTestInteractable, secondTestInteractable, thirdTestInteractable, fourthTestInteractable);

#endregion

#region characters

playerSpawnX = 6;
playerSpawnY = 6;

var forsakenSoul0 = FindCharacter(CharacterClass.Monster, 0);
forsakenSoul0.spawnX = 12;
forsakenSoul0.spawnY = 32;
var forsakenSoul1 = FindCharacter(CharacterClass.Monster, 0);
forsakenSoul1.spawnX = 21;
forsakenSoul1.spawnY = 29;
var forsakenSoul2 = FindCharacter(CharacterClass.Monster, 0);
forsakenSoul2.spawnX = 4;
forsakenSoul2.spawnY = 30;

ds_list_add(characters, forsakenSoul0, forsakenSoul1, forsakenSoul2, /*forsakenSoul3, forsakenSoul4, forsakenSoul5, forsakenSoul6, forsakenSoul7*/);

#endregion

#region combat encounters

var firstEncounterEver =
{
	startIndex : 0,
	endIndex : 2,
	alive : true,
	respawn : true,
	triggers : ds_list_create()
}
var trigger0 =
{
	x : 8,
	y : 25
}
var trigger1 =
{
	x : 9,
	y : 25
}
var trigger2 =
{
	x : 10,
	y : 25
}
var trigger3 =
{
	x : 11,
	y : 25
}
var trigger4 =
{
	x : 12,
	y : 25
}
var trigger5 =
{
	x : 13,
	y : 25
}
var trigger6 =
{
	x : 14,
	y : 25
}
ds_list_add(firstEncounterEver.triggers, trigger0, trigger1, trigger2, trigger3, trigger4, trigger5, trigger6);

ds_list_add(encounters, firstEncounterEver);

#endregion