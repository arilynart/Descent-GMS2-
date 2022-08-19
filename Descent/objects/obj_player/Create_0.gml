/// @description variables.

enum CharacterTeams
{
	Player,
	Ally,
	NPC,
	Enemy
}

team = CharacterTeams.Player;

global.Player = self;

global.Allies = array_create(0);

array_push(global.Allies, self);

moveSpeed = 18;
moveQueue = ds_queue_create();
moving = false;
moveTarget = 0;

currentSquare = 0;

uiScale = 0.25;

name = "Sythal";
baseMaxMove = 6;
maxMove = baseMaxMove;

#region Packs

packSlots = ds_list_create();
equippedPacks = array_create(0);

ds_list_add(packSlots, 1, 1, 1, 2);

var starterPack1 = {};
with (starterPack1)
{
	sprite = spr_Pack1;
	tier = 1;
	width = 1;
	height = 2;
	contents = array_create(width * height);
}

var starterPack2 = {};
with (starterPack2)
{
	sprite = spr_Pack0;
	tier = 2;
	width = 2;
	height = 3;
	contents = array_create(width * height);
}

var testItem = 
{
	type : ItemTypes.Consumable,
	index : 0,
	quantity : 1,
	maxQuantity : global.FindItem(ItemTypes.Consumable, 0, 1).maxQuantity,
	pack : 0,
	slot : 0
}
var testItem2 = 
{
	type : ItemTypes.Consumable,
	index : 0,
	quantity : 3,
	maxQuantity : global.FindItem(ItemTypes.Consumable, 0, 1).maxQuantity,
	pack : 0,
	slot : 0
}

array_push(equippedPacks, starterPack1, starterPack2);

AutoPickup(self, testItem);
AutoPickup(self, testItem2);
AutoPickup(self, testItem2);

#endregion

