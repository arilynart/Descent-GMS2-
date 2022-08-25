/// @description variables.

characterStats = global.BaseCharacter();

moveSpeed = 18;
moveQueue = ds_queue_create();
moving = false;
moveTarget = 0;
maxMove = characterStats.baseMaxMove;

currentSquare = 0;

moveRight = 0;
moveDown = 0;

velocityX = 0;
velocityY = 0;

aiMind = 0;
aiGoal = -1;
aiThreat = 0;