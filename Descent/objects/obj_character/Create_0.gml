/// @description variables.

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



function EmptyMana()
{
	wPool = 0;
	fPool = 0;
	mPool = 0;
	sPool = 0;
	ePool = 0;
	dPool = 0;
	vPool = 0;
}

EmptyMana();

//lusium
loadedLusium = ds_list_create();
itemsToLoad = array_create(0);

loadedQuantity = function()
{
	var q = 0;
	for (var i = 0; i < array_length(itemsToLoad); i++)
	{
		var item = itemsToLoad[i];
		q += item.quantity;
	}
	return q;
}

function ResetLoaded()
{
	for (var i = 0; i < array_length(itemsToLoad); i++)
	{
		AutoPickup(self, itemsToLoad[i]);
	}
	itemsToLoad = array_create(0);
}

//combat variables
hpGrowthValue = 0.35;
spGrowthValue = 0.65;

maxHp = function()
{
	var calculatedHp = characterStats.vitality + ceil((characterStats.vitality * hpGrowthValue) * characterStats.level);
	return calculatedHp;
}

maxSp = function()
{
	var calculatedSp = characterStats.endurance + ceil((characterStats.endurance * spGrowthValue) * characterStats.level);
	return calculatedSp;
}
maxAp = 2;

currentHp = maxHp();
currentSp = maxSp();
currentAp = maxAp;

//ai variables
aiMind = 0;
aiGoal = -1;
aiThreat = 0;

