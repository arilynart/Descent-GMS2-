// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

PlayerAdjacent = function(square, requirePlayer)
{
	show_debug_message("Checking for adjacent players.");
	var foundPlayer = 0;
	for (var i = 0; i < 8; i++)
	{
		var checkSquare = 0;
		switch (i)
		{
			//right
			case 0:
				checkSquare = square.right;
				break;
			//downright
			case 1:
				checkSquare = square.downRight;
				break;
			//down
			case 2:
				checkSquare = square.down;
				break;
			//downleft
			case 3:
				checkSquare = square.downLeft;
				break;
			//left
			case 4:
				checkSquare = square.left;
				break;
			//upleft
			case 5:
				checkSquare = square.upLeft;
				break;
			//up
			case 6:
				checkSquare = square.up;
				break;
			//upright
			case 7:
				checkSquare = square.upRight;
				break;
		}
			
		if (checkSquare != 0 && checkSquare.character != 0)
		{
			checkSquare.Deactivate();
			if (requirePlayer == true)
			{
				if (global.Player == checkSquare.character)
				{
					foundPlayer = checkSquare.character;
				}
				else
				{
					if (checkSquare.character.characterStats.team == CharacterTeams.Ally)
					{
						show_debug_message(string(checkSquare.character.characterStats.name) + " doesn't know what to do with that.");
					}
				}
			}
			else 
			{
				//after we add enemies we want to check to maker sure the character is allied.
				if (checkSquare.character.characterStats.team == CharacterTeams.Ally || global.Player == checkSquare.character) 
				{
					foundPlayer = checkSquare.character;
				}
			}
		}
	}
	show_debug_message("Out of range.");
	return foundPlayer;
}

//call this whenever packs are changed.
function PackCheck(character)
{
	//penalize movement for overpacking.
	
	//check to make sure each pack doesn't overcap, prioritizing largest.
	
}

//quick-add item to the inventory
function AutoPickup(character, item)
{
	show_debug_message(character.characterStats.name + " is picking up item: " + string(item));
	
	var quantityToSort = item.quantity;
	var sortedQuantity = 0;
	
	var addItem = global.ItemCopy(item);
	
	if (addItem.maxQuantity > 1)
	{
		for (var h = 0; sortedQuantity < quantityToSort; h++)
		{
			var selectedPack = -1
			var emptyIndex = -1;
			for (var i = 0; i < array_length(character.characterStats.equippedPacks); i++)
			{
				var pack = character.characterStats.equippedPacks[i];
				var tempIndex = -1;
				for (var j = 0; j < pack.width * pack.height; j++)
				{
					var tempItem = pack.contents[j]
					if (tempItem != 0 && tempItem.type == addItem.type && tempItem.index == addItem.index 
						&& tempItem.quantity < tempItem.maxQuantity)
					{
						selectedPack = pack;
						emptyIndex = j;
					}
				}
			}
			if (selectedPack != -1)
			{
				var itemToCombineTo = selectedPack.contents[emptyIndex];
			
				itemToCombineTo.quantity += quantityToSort - sortedQuantity;
			
				if (itemToCombineTo.quantity > itemToCombineTo.maxQuantity)
				{
					sortedQuantity = quantityToSort - (itemToCombineTo.quantity - itemToCombineTo.maxQuantity);
					itemToCombineTo.quantity = itemToCombineTo.maxQuantity;
					item.quantity -= sortedQuantity;
				}
				else
				{
					sortedQuantity = quantityToSort;
				}
			}
			else
			{
				//nothing found. break loop.
				show_debug_message("No packs found. Breaking loop.");
				break;
			}
		
		
		}
	}
	
	
	if (sortedQuantity < quantityToSort)
	{
		show_debug_message("Searching for empty slot.");
	
		//no previous items to merge with. add remaining to empty slot.
		var lowestValue = 99;
		selectedPack = -1;
		emptyIndex = -1;
		var packIndex = -1
		for (var i = 0; i < array_length(character.characterStats.equippedPacks); i++)
		{
			var pack = character.characterStats.equippedPacks[i];
			
			var tempIndex = -1;
			for (var j = 0; j < pack.width * pack.height; j++)
			{
				var tempItem = pack.contents[j]
				if (tempItem == 0)
				{
					tempIndex = j; 
					j = 99;
				}
			}
		
			if (tempIndex >= 0 && pack.tier < lowestValue)
			{
				emptyIndex = tempIndex;
				lowestValue = pack.tier;
				packIndex = i;
				selectedPack = pack;
				i = 99;
			}
		}
		if (selectedPack != -1)
		{
			addItem.pack = packIndex;
			addItem.slot = emptyIndex;
			selectedPack.contents[emptyIndex] = addItem;
		}
		else
		{
			show_debug_message("No room for item. Drop something first.");
		}
	}
}

function Summon(square)
{
	if (square.interaction == 0 && square.character == 0)
	{
		global.selectedCharacter.currentSquare.Deactivate();
		global.SelectSquareExecute = 0;
		
		global.selectedCharacter.currentAp--;
		
		var summonStats = ds_list_find_value(global.BondedMonsters, global.UiManager.selectedSummon);
		var character = global.UiManager.summonCharacter;
		
		character.ResetStats(summonStats);
		
		character.x = square.x;
		character.y = square.y;
		character.currentSquare = square;
		square.character = character;
		
		array_push(global.Allies, character);
		
		global.UiManager.summonCharacter = instance_create_layer(-10000, -10000, "Characters", obj_Character, { characterStats : FindCharacter(CharacterClass.Bondable, 0) });
		
		if (global.InCombat)
		{
			ds_list_add(global.Combatants, character);
			
			var baseInitiative = character.characterStats.tempo * 10;
			var roll = irandom(15);
			var initiativeRoll = baseInitiative + roll;
			
			var existingTurnSize = ds_list_size(global.Turns);
			var validInitiative = false;
			
			while (!validInitiative)
			{
				
				validInitiative = true;
				
				for (var j = 0; j < existingTurnSize; j++)
				{
					var turn = ds_list_find_value(global.Turns, j);
					if (turn.initiative == initiativeRoll)
					{
						validInitiative = false;
						
						var newRoll = irandom(9);
						initiativeRoll = baseInitiative + newRoll;
					}
				}
			}
			
			var newTurn = 
			{
				character : character,
				initiative : initiativeRoll
			}
			
			var foundTurn = false;
			var turnSize = ds_list_size(global.Turns);
			for (var i = 0; i < turnSize; i++)
			{
				//go through sorted list until the one we're adding has higher iniative than the next one or we reach the end of the list.
				var checkedTurn = ds_list_find_value(global.Turns, i);
				
				if (i > 0 && checkedTurn.initiative < newTurn.initiative)
				{
					ds_list_insert(global.Turns, i, newTurn);
					foundTurn = true;
					break;
				}
			}
			
			if (!foundTurn)
			{
				ds_list_add(global.Turns, newTurn);
			}
		}
	}
}