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

//card variables
ignited = false;

nodes = ds_list_create();
extras = ds_list_create();
removed = ds_list_create();
hand = ds_list_create();
discard = ds_list_create();
play = ds_list_create();

//ai variables
aiMind = 0;
aiGoal = -1;
aiThreat = 0;