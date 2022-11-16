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

function DealDamage(amount, source)
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
	
	if (characterStats.team != CharacterTeams.Ally)
	{
		var threatIncrease = amount * characterStats.damageThreatModifier;
		var sourceThreat = FindThreat(source);
		
		sourceThreat.threat += threatIncrease;
		
		UpdateThreat();
		
		for (var i = 0; i < ds_list_size(protectCharacters); i++)
		{
			with (ds_list_find_value(protectCharacters, i))
			{
				var threatIncrease = amount * characterStats.protectThreatModifier;
				var sourceThreat = FindThreat(source);
		
				sourceThreat.threat += threatIncrease;
				
				UpdateThreat();
			}
		}
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

OnMoveEnd = 0;

function UpdateThreat()
{
	
	CO_PARAMS.character = id;
	
	return CO_BEGIN
		if (character.threatTarget != 0) highestThreat = character.FindThreat(character.threatTarget);
		else
		{
			highestThreat =
			{
				character : 0,
				threat : 0
			}
		}
		
		i = 0;
		REPEAT ds_list_size(character.threatPotential) THEN
		
			threatStruct = ds_list_find_value(character.threatPotential, i);
		
			show_debug_message(string(character) + " checks threat: " + threatStruct.character.characterStats.name + " with threat value " + string(threatStruct.threat));
		
			IF (threatStruct.threat > 0 && threatStruct.threat == highestThreat.threat) THEN
				foundHighestThreat = 0;
				j1 = 0;
				
				WHILE (foundHighestThreat == 0) THEN
				
					//show_debug_message("Searching grid for highest threat... " + string(highestThreat.character));
				
					var activation = character.currentSquare.Activate(6 + j1, character, ParseTypes.Melee);
				
					//show_debug_message("Finished activation with range " + string(6 + j1) + " and " + string(array_length(activation)) + " squares found.");
					
					for (var k = 0; k < array_length(activation); k++)
					{
						var parse = activation[k];
						
						//show_debug_message("Checking parse at: " + string(k) + " Character: " + string(parse.square.character));
					
						if (parse.square.character != 0 && parse.square.character == highestThreat.character)
						{
							
							foundHighestThreat = parse;
							//show_debug_message("Found the highest threat. " + string(foundHighestThreat));
						}
					}
					
					YIELD 0 THEN
					
					j1++;
					
				END
			
				foundTestThreat = 0;
				j2 = 0;
				breaking = false;
				
				WHILE (foundTestThreat == 0 && !breaking) THEN
					
					show_debug_message("Breaking: " + string(breaking) + " full value: " + string(foundTestThreat == 0 && !breaking));
					if (j2 > j1) 
					{
						breaking = true;
					}
					
				
					if (!breaking)
					{
						var activation = character.currentSquare.Activate(6 + j2, character, ParseTypes.Melee);
				
						for (var k = 0; k < array_length(activation); k++)
						{
							var parse = activation[k];
					
							if (parse != 0 && parse.square.character != 0 && parse.square.character == threatStruct.character)
							{
								foundTestThreat = parse;
							}
						}
					}
				
					YIELD 0 THEN
					
					j2++;
				
				END
				
				if (breaking) show_debug_message("Potential target is out of first test range. Not a higher threat.");
				else if (foundTestThreat.distance < foundHighestThreat.distance) highestThreat = threatStruct;
			ELSE_IF (threatStruct.threat > highestThreat.threat) THEN
				highestThreat = threatStruct;
			END_IF
			
			i++;
		END

		if (highestThreat.threat != 0)
		{
			show_debug_message(string(character) + " has highest threat: " + highestThreat.character.characterStats.name + " with threat value " + string(highestThreat.threat));
			character.threatTarget = highestThreat.character;
		
			show_debug_message("Threat Target Set: " + character.threatTarget.characterStats.name);
		}
	CO_ON_COMPLETE
		global.CombatantsWithThreat++;
	CO_END
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

FindThreat = function(character)
{
	for (var i = 0; i < ds_list_size(threatPotential); i++)
	{
		var threat = ds_list_find_value(threatPotential, i);
		
		if (threat.character == character)
		{
			return threat;
		}
	}
}

#endregion