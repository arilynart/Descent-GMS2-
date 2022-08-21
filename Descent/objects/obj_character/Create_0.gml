/// @description variables.

characterStats = global.BaseCharacter();

moveSpeed = 18;
moveQueue = ds_queue_create();
moving = false;
moveTarget = 0;
maxMove = characterStats.baseMaxMove * 100;

currentSquare = 0;