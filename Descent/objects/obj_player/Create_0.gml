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

#region Packs

packSlots = ds_list_create();
equippedPacks = array_create(0);

ds_list_add(packSlots, 1, 1, 1, 2);

starterPack1 =
{
	sprite : spr_Pack1,
	tier : 1,
	width : 2,
	height : 2,
	contents : array_create(0)
}

starterPack2 =
{
	sprite : spr_Pack0,
	tier : 2,
	width : 3,
	height : 4,
	contents : array_create(0)
}

array_push(equippedPacks, starterPack1, starterPack2);

#endregion

name = "Sythal";
baseMaxMove = 6;
maxMove = baseMaxMove;