/// @description variables.

moveSpeed = 18;
moveQueue = ds_queue_create();
moving = false;
moveLock = false;
moveTarget = 0;
maxMove = characterStats.baseMaxMove;

global.BarSurface = 0;

currentSquare = 0;

moveRight = 0;
moveDown = 0;

velocityX = 0;
velocityY = 0;

storedActivation = 0;

function ResetStats(stats)
{
	characterStats = stats;
	sprite_index = characterStats.sprite;
	maxMove = characterStats.baseMaxMove;
	currentHp = maxHp();
	currentSp = maxSp();
	currentAp = maxAp;
}

#region art queue

//card variables
artQueue = ds_queue_create();
artOutTime = 30;
artMaxTime = 30;
artInTime = 15;
currentArt = -1;

function AddArtToQueue(card)
{
	ds_queue_enqueue(artQueue, card.art);
	if (alarm_get(1) <= 0 && alarm_get(0) <= 0&& alarm_get(2) <= 0)
	{
		currentArt = ds_queue_dequeue(artQueue);
		alarm_set(1, artInTime);
	}
}

ignited = false;

#endregion

#region combat variables
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

function DealDamage(amount)
{
	var damage = amount;
	if (currentSp > 0)
	{
		damage -= currentSp;
		currentSp = clamp(currentSp - amount, 0, maxSp);
	}
	if (damage > 0)
	{
		currentHp = clamp(currentHp - damage, 0, maxHp);
		
		//if (currentHp <= 0) instance_destroy(id);
	}
}

#endregion

#region player cards

threatCards = ds_list_create();

nodes = ds_list_create();
extra = ds_list_create();
removed = ds_list_create();
hand = ds_list_create();
discard = ds_list_create();

lockedHandCards = ds_list_create();

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

#endregion

#region lusium
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

#endregion

#region enemy variables

enemyDeck = ds_list_create();
threatTarget = 0;
threatPotential = ds_list_create();
protectCharacters = ds_list_create();

function UpdateThreat()
{
	var highestThreat =
	{
		character : 0,
		threat : 0
	}
	for (var i = 0; i < ds_list_size(threatPotential); i++)
	{
		var threatStruct = ds_list_find_value(threatPotential, i);
		
		show_debug_message(string(id) + " checks threat: " + threatStruct.character.characterStats.name + " with threat value " + string(threatStruct.threat));
		
		if (threatTarget == 0 && threatStruct.threat > 0 && threatStruct.threat == highestThreat.threat)
		{
			var foundHighestThreat = 0;
			var j1 = 0;
			while (foundHighestThreat == 0)
			{
				var activation = currentSquare.Activate(6 + j1, id, ParseTypes.Range);
				
				for (var k = 0; k < array_length(activation); k++)
				{
					var parse = activation[k];
					
					if (parse != 0 && parse.square.character != 0 && parse.square.character == highestThreat.character)
					{
						foundHighestThreat = parse;
					}
				}
				
				j1++;
			}
			
			var foundTestThreat = 0;
			var j2 = 0;
			while (foundTestThreat == 0)
			{
				if (j2 > j1)
				{
					break;
				}
				
				var activation = currentSquare.Activate(6 + j2, id, ParseTypes.Range);
				
				for (var k = 0; k < array_length(activation); k++)
				{
					var parse = activation[k];
					
					if (parse != 0 && parse.square.character != 0 && parse.square.character == threatStruct.character)
					{
						foundTestThreat = parse;
					}
				}
				
				j2++;
			}
			
			if (j2 > j1) show_debug_message("Potential target is out of first test range. Not a higher threat.");
			else if (foundTestThreat.distance < foundHighestThreat.distance) highestThreat = threatStruct;
		}
		else if (threatStruct.threat > highestThreat.threat)
		{
			highestThreat = threatStruct;
		}
	}

	if (highestThreat.threat != 0)
	{
		show_debug_message(string(id) + " has highest threat: " + highestThreat.character.characterStats.name + " with threat value " + string(highestThreat.threat));
		threatTarget = highestThreat.character;
		
		show_debug_message("Threat Target Set: " + threatTarget.characterStats.name);
	}
}

function AddPotentialThreat(character)
{
	var startThreat = 0;
	
	if (character.characterStats.team != characterStats.team) startThreat = 1;
	
	var struct =
	{
		character : character,
		threat : startThreat
	}
	
	ds_list_add(threatPotential, struct);
}

#endregion