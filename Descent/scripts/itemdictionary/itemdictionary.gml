// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum ItemTypes
{
	Weapon,
	Armor,
	Pack,
	Consumable,
	Lumium
}

ItemToMove = 0;

FindItem = function(type, index, quantity)
{
	switch(type)
	{
		case ItemTypes.Weapon:
			switch(index)
			{
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
					var maxQuantity = 10;
					quantity = clamp(quantity, 1, maxQuantity);

					var item =
					{
						name : "Medicine",
						description : "A vial of common herbalist medicine for\ntreating wounds.",
						sprite : spr_Potions,
						maxQuantity : maxQuantity,
						quantity : quantity,
						index : index,
						type : type,
						packSlot : 0,
						slot : -1,
						methods : ds_list_create()
					}
					
					var Consume = 
					{
						name : "Drink",
						description : "Applies 5 Regen when consumed.",
						sprite : spr_Consume,
						Execute : method(global, ConsumeMedicine),
						split : false
					}
					ds_list_add(item.methods, Move, Trash, Consume);
					
					return item;
					break;
				default:
					show_error(string(type) + " Item index invalid."  
							 + " | " + string(index), true);
					return undefined;
					break;
			}
			break;
		case ItemTypes.Lumium:
			switch(index)
			{
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

#region Methods

ItemFindOnCharacter = function(character, item)
{
	for (var i = 0; i < array_length(character.equippedPacks); i++)
	{
		var testPack = character.equippedPacks[i];
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
		name : item.name,
		description : item.description,
		sprite : item.sprite,
		maxQuantity : item.maxQuantity,
		quantity : item.quantity,
		index : item.index,
		type : item.type,
		pack : item.pack,
		slot : item.slot,
		methods : item.methods
	}
	
	return newItem;
}

//standard methods. Move and discard.

ItemDiscard = function(character, item)
{
	character.equippedPacks[item.pack].contents[item.slot] = 0;
}

ItemMove = function(character, item)
{
	show_debug_message("Moving item:   Previous ItemToMove: " + string(ItemToMove));
	
	if (ItemToMove != 0)
	{
		ItemMovetoSlot(character, ItemToMove.pack, ItemToMove.slot);
	}
	

	ItemToMove = item;
	ItemDiscard(character, item);
}

function ItemMovetoSlot(character, packIndex, slot)
{
	show_debug_message("Moving item to: " + string(slot));
	var pack = character.equippedPacks[packIndex];
	var quantityToSort = ItemToMove.quantity;
	var sortedQuantity = 0;
	
	while (sortedQuantity < quantityToSort)
	{
		if (pack.contents[slot] != 0)
		{
			//combine with previous item (don't pass in a slot of a different item type)
		
			if (pack.contents[slot].type == ItemToMove.type && pack.contents[slot].index == ItemToMove.index)
			{
				pack.contents[slot].quantity += ItemToMove.quantity;
				if (pack.contents[slot].quantity > pack.contents[slot].maxQuantity)
				{
					var overcap = pack.contents[slot].quantity - pack.contents[slot].maxQuantity;
					pack.contents[slot].quantity = pack.contents[slot].maxQuantity;
					ItemToMove.quantity = overcap;
					if (pack.contents[slot] == ItemToMove.pack.contents[ItemToMove.slot])
					{
						AutoPickup(ItemToMove.character, ItemToMove);
						sortedQuantity = quantityToSort;
					}
					else
					{
						sortedQuantity = quantityToSort - overcap;
						pack = ItemToMove.pack;
						slot = ItemToMove.slot;
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
				AutoPickup(ItemToMove.character, ItemToMove);
			}
		}
		else
		{
			pack.contents[slot] = ItemToMove;
			sortedQuantity = quantityToSort;
		}
	}
	
	ItemToMove = 0;
	
}

//custom methods

ConsumeMedicine = function(character, item)
{
	
	item.quantity--;
	if (item.quantity <= 0) ItemDiscard(character, item);
}

#endregion

#region Structs

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

#endregion