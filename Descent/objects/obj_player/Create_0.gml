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

moveSpeed = 12;

moveQueue = ds_queue_create();

moving = false;

moveTarget = 0;

currentSquare = 0;

name = "Sythal";