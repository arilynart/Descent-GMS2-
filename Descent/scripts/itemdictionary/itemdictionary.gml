// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum ItemTypes
{
	Weapon,
	Armor,
	Pack,
	Consumable,
	Lusium
}

ItemToMove = 0;

FindItem = function(type, index, quantity)
{
	switch(type)
	{
		case ItemTypes.Weapon:
			switch(index)
			{
				case 0:
					var maxQuantity = 3;
					quantity = clamp(quantity, 1, maxQuantity);
					var item = global.BaseWeapon();
					item.name = "Lapis Rod";
					item.description = "A simple, traditional rod made of lapis stone from Protector's" 
									 + " Pass. The material's conducivity to mana makes even this basic " 
								 	 + "medium lethally potent.";
					item.sprite = spr_Weapon000;
					item.maxQuantity = maxQuantity;
					item.quantity = quantity;
					item.index = index;
					item.type = type;
					item.pack = 0;
					item.slot = -1;
					item.methods = array_create(0);
					item.lusiumPerAp = 2;
					item.maximumLusium = 9;
					item.forceRatio = 0.8;
					
					var weaponAbility0 =
					{
						sprite : spr_Weapon000a0,
						range : 6,
						Execute : method(global, global.RangedAttackExecute)
					}
					
					array_push(item.methods, Trash, Move, EquipWeapon);
					array_push(item.abilities, weaponAbility0);
					
					return item;
				break;
				default:
					show_error(string(type) + " Item index invalid."  
							 + " | " + string(index), true);
					return undefined;
				break;
			}
		break;
		case ItemTypes.Armor:
			switch(index)
			{
				default:
					show_error(string(type) + " Item index invalid."  
							 + " | " + string(index), true);
					return undefined;
				break;
			}
		break;
		case ItemTypes.Pack:
			switch(index)
			{
				default:
					show_error(string(type) + " Item index invalid."  
							 + " | " + string(index), true);
					return undefined;
				break;
			}
		break;
		case ItemTypes.Consumable:
			switch(index)
			{
				case 0:
					//medicine.
					var maxQuantity = 3;
					quantity = clamp(quantity, 1, maxQuantity);

					var item = global.BaseItem();
					item.name = "Medicine";
					item.description = "A vial of common herbalist medicine for\ntreating wounds.";
					item.sprite = spr_Potions;
					item.maxQuantity = maxQuantity;
					item.quantity = quantity;
					item.index = index;
					item.type = type;
					item.pack = 0;
					item.slot = -1;
					item.methods = array_create(0);
					
					var Consume = 
					{
						name : "Drink",
						description : "Applies 5 Regen when consumed.",
						sprite : spr_Consume,
						Execute : method(global, ConsumeMedicine),
						split : false
					}
					array_push(item.methods, Trash, Move, Consume);
					
					return item;
				break;
				default:
					show_error(string(type) + " Item index invalid."  
							 + " | " + string(index), true);
					return undefined;
				break;
			}
		break;
		case ItemTypes.Lusium:
			switch(index)
			{
				case 0:
					var maxQuantity = 30;
					quantity = clamp(quantity, 1, maxQuantity);

					var item = global.BaseItem();
					item.name = "Lusium I";
					item.description = "The most basic form of Lusium. Can only handle 1 node at a time. Cheap and easy to get, but the worst effectiveness for astromancy. ";
					item.sprite = spr_Lusium0;
					item.maxQuantity = maxQuantity;
					item.quantity = quantity;
					item.index = index;
					item.type = type;
					item.pack = 0;
					item.slot = -1;
					item.methods = array_create(0);
					
					array_push(item.methods, Trash, Move);
					
					return item;
				break;
				case 1:
					var maxQuantity = 30;
					quantity = clamp(quantity, 1, maxQuantity);

					var item = global.BaseItem();
					item.name = "Lusium II";
					item.description = "This lusium has been slightly refined. Can only handle 2 nodes at a time, but still decent effectiveness for astromancy. ";
					item.sprite = spr_Lusium1;
					item.maxQuantity = maxQuantity;
					item.quantity = quantity;
					item.index = index;
					item.type = type;
					item.pack = 0;
					item.slot = -1;
					item.methods = array_create(0);
					
					array_push(item.methods, Trash, Move);
					
					return item;
				break;
				case 2:
					var maxQuantity = 30;
					quantity = clamp(quantity, 1, maxQuantity);

					var item = global.BaseItem();
					item.name = "Lusium III";
					item.description = "This lusium has had most impurities removed by an artisan. Can handle up to 3 nodes at a time. ";
					item.sprite = spr_Lusium2;
					item.maxQuantity = maxQuantity;
					item.quantity = quantity;
					item.index = index;
					item.type = type;
					item.pack = 0;
					item.slot = -1;
					item.methods = array_create(0);
					
					array_push(item.methods, Trash, Move);
					
					return item;
				break;
				case 3:
					var maxQuantity = 30;
					quantity = clamp(quantity, 1, maxQuantity);

					var item = global.BaseItem();
					item.name = "Lusium IV";
					item.description = "This lusium has been perfectly refined by a master artisan. Although not necessary in most situations, this powerful metal can hold up to 4 nodes at a time. ";
					item.sprite = spr_Lusium3;
					item.maxQuantity = maxQuantity;
					item.quantity = quantity;
					item.index = index;
					item.type = type;
					item.pack = 0;
					item.slot = -1;
					item.methods = array_create(0);
					
					array_push(item.methods, Trash, Move);
					
					return item;
				break;
				default:
					show_error(string(type) + " Item index invalid."  
							 + " | " + string(index), true);
					return undefined;
				break;
			}
		break;
		default:
			show_error("Invalid item type.", true);
			return undefined;
		break;
		
	}
}

BaseItem = function()
{
	var item =
	{
		name : "",
		description : "",
		sprite : spr_Potions,
		maxQuantity : 1,
		quantity : 1,
		index : 0,
		type : ItemTypes.Consumable,
		pack : 0,
		slot : -1,
		methods : array_create(0)
	}
	return item;
}

BaseWeapon = function()
{
	var item = global.BaseItem();
	item.lusiumPerAp = 2;
	item.maximumLusium = 9;
	item.forceRatio = 0.5;
	item.abilities = array_create(0);
					
	array_push(item.methods, global.Trash, global.Move, global.EquipWeapon);
					
	return item;
}

#region Methods

ItemFindOnCharacter = function(character, item)
{
	for (var i = 0; i < array_length(character.characterStats.equippedPacks); i++)
	{
		var testPack = character.characterStats.equippedPacks[i];
		for (var j = 0; j < array_length(testPack.contents); j++)
		{
			var testItem = testPack.contents[j];
			if (item == testItem)
			{
				var fetchedItem =
				{
					character : character,
					pack : testPack,
					index: j,
					item : testItem
				}
				return fetchedItem;
			}
		}
	}
	return 0;
}

ItemCopy = function(item)
{
	var newItem = 
	{
		maxQuantity : item.maxQuantity,
		quantity : item.quantity,
		index : item.index,
		type : item.type,
		pack : item.pack,
		slot : item.slot,
	}
	
	return newItem;
}

//standard methods. Move and discard.

ItemDiscard = function(character, pack, item)
{
	if (item.pack >= 0) pack = character.characterStats.equippedPacks[item.pack];
	else pack = global.UiManager.tempItemPack;
	pack.contents[item.slot] = 0;
}

ItemMove = function(character, pack, item)
{
	show_debug_message("Moving item:   Previous global.ItemToMove: " + string(global.ItemToMove));
	
	if (global.ItemToMove != 0)
	{
		
		ItemMovetoSlot(character, global.ItemToMove.pack, global.ItemToMove.slot);
	}

	global.ItemToMove = item;
	ItemDiscard(character, pack, item);
}

function ItemMovetoSlot(character, packIndex, slot)
{
	show_debug_message("Moving item to: " + string(slot));
	
	var quantityToSort = global.ItemToMove.quantity;
	var sortedQuantity = 0;
	var pack = 0;
	if (packIndex >= 0) pack = character.characterStats.equippedPacks[packIndex];
	else
	{
		AutoPickup(character, global.ItemToMove);
		sortedQuantity = quantityToSort;
	}
	while (sortedQuantity < quantityToSort)
	{
		
		if (pack.contents[slot] != 0)
		{
			//combine with previous item (don't pass in a slot of a different item type)
		
			if (pack.contents[slot].type == global.ItemToMove.type && pack.contents[slot].index == global.ItemToMove.index)
			{
				pack.contents[slot].quantity += global.ItemToMove.quantity;
				if (pack.contents[slot].quantity > pack.contents[slot].maxQuantity)
				{
					var overcap = pack.contents[slot].quantity - pack.contents[slot].maxQuantity;
					pack.contents[slot].quantity = pack.contents[slot].maxQuantity;
					global.ItemToMove.quantity = overcap;
					var nativePack = 0;
					if (global.ItemToMove.pack >= 0) nativePack = character.characterStats.equippedPacks[global.ItemToMove.pack];
					else nativePack = global.UiManager.tempItemPack;
					
					if (pack.contents[slot] == nativePack.contents[global.ItemToMove.slot])
					{
						show_debug_message("Cannot add item to the starting slot. Running AutoPickup instead.");
						AutoPickup(character, global.ItemToMove);
						sortedQuantity = quantityToSort;
					}
					else
					{
						if (global.ItemToMove.pack >= 0)
						{
							show_debug_message("Overcapped quantity. Resetting to original slot.");
							sortedQuantity = quantityToSort - overcap;
							packIndex = global.ItemToMove.pack;
							pack = character.characterStats.equippedPacks[global.ItemToMove.pack];
							slot = global.ItemToMove.slot;
						}
						else
						{
							show_debug_message("Overcapped quantity. Since object was split, running auto pickup.");
							sortedQuantity = quantityToSort;
							AutoPickup(character, global.ItemToMove);
						}
					}
				}
				else
				{
					sortedQuantity = quantityToSort;
				}
			}
			else
			{
				show_debug_message("Cannot add item to slot. Running AutoPickup instead.");
				sortedQuantity = quantityToSort;
				AutoPickup(character, global.ItemToMove);
			}
		}
		else
		{
			global.ItemToMove.pack = packIndex;
			global.ItemToMove.slot = slot;
			pack.contents[slot] = global.ItemToMove;
			
			sortedQuantity = quantityToSort;
		}
	}
	
	global.ItemToMove = 0;
	
}

global.SelectSquareExecute = 0;
global.ItemToPlace = 0;
ItemPlace = function(character, pack, item)
{
	//select grid square for placing
	if (global.ItemToPlace != 0)
	{
		
		ItemMovetoSlot(character, global.ItemToPlace.pack, global.ItemToPlace.slot);
	}

	global.ItemToPlace = item;
	SelectSquareToPlace(character);
	ItemDiscard(character, pack, item);
}

function SelectSquareToPlace(character)
{
	global.SquareLock = true;
	
	var map = instance_find(obj_Map, 0);
	if (map.movingCharacter != 0)
	{
		map.movingCharacter.currentSquare.Deactivate();
		map.movingCharacter = 0;
	}
	
	character.currentSquare.Activate(character.currentSquare, 1.5);
	global.SelectSquareExecute = method(global, global.FinishPlaceItem);
	global.selectedSquare = character.currentSquare;
}

FinishPlaceItem = function(square)
{
	show_debug_message("FinishPlaceItem");
	if (square.character != 0)
	{
		AutoPickup(square.character, global.ItemToPlace);
		
	}
	else
	{
		interactable = 
		{
			x: square.coordinate.x,
			y: square.coordinate.y,
			Execute: method(global, PickupDialogue),
			item: global.ItemToPlace,
			sprite: global.FindItem(global.ItemToPlace.type, global.ItemToPlace.index, global.ItemToPlace.quantity).sprite
		}
		square.interaction = interactable;
	}
	global.ItemToPlace = 0;
	global.SelectSquareExecute = 0;
	global.SquareLock = false;
	global.selectedSquare.Deactivate();
	
	var ui = instance_find(obj_UiManager, 0);
	ui.packDraw = -1;
	ui.itemDraw = -1;
}

//custom methods

ConsumeMedicine = function(character, pack, item)
{
	
	item.quantity--;
	if (item.quantity <= 0) ItemDiscard(character, pack, item);
}

#endregion

#region Structs

EquipWeapon =
{
	name : "Equip",
	description : "Equip the weapon.",
	sprite : spr_Discard,
	Execute : method(global, ItemDiscard),
	split : false
}

Trash = 
{
	name : "Trash",
	description : "Destroy the item.",
	sprite : spr_Discard,
	Execute : method(global, ItemDiscard),
	split : true
}

Move = 
{
	name : "Move",
	description : "Move the item.",
	sprite : spr_Move,
	Execute : method(global, ItemMove),
	split : true
}

Place =
{
	name : "Place",
	description : "Place the item on the grid, allowing other characters to pick it up.",
	sprite : spr_Place,
	Execute : method(global, ItemPlace),
	split : true
}

#endregion