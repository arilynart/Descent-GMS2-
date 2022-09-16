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
artQueue = ds_queue_create();
artOutTime = 30;
artMaxTime = 30;
artInTime = 15;
currentArt = -1;

function AddArtToQueue(card)
{
	ds_queue_enqueue(artQueue, card.art);
	if (alarm_get(1) <= 0 && alarm_get(0) <= 0)
	{
		currentArt = ds_queue_dequeue(artQueue);
		alarm_set(1, artInTime);
	}
}

ignited = false;

nodes = ds_list_create();
extra = ds_list_create();
removed = ds_list_create();
hand = ds_list_create();
discard = ds_list_create();

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
burntLusium = ds_list_create();
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

