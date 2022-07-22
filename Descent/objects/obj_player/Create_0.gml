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
	width = 2;
	height = 2;
	contents = array_create(width * height);
}

var starterPack2 = {};
with (starterPack2)
{
	sprite = spr_Pack0;
	tier = 2;
	width = 3;
	height = 4;
	contents = array_create(width * height);
}


var testItem = global.FindItem(ItemTypes.Consumable, 0, 5);
var testItem2 = global.FindItem(ItemTypes.Consumable, 0, 7);

array_push(equippedPacks, starterPack1, starterPack2);

AutoPickup(self, testItem);
AutoPickup(self, testItem2);

#endregion

