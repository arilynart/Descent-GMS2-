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

FindItemOnCharacter = function(character, item)
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

//standard methods. Move and discard.

ItemDiscard = function(character, item)
{
	var fetchItem = FindItemOnCharacter(character, item);
	
	if (fetchItem != 0)
	{
		//delete item
		fetchItem.item.quantity--;
		if (fetchItem.item.quantity <= 0) fetchItem.pack.contents[fetchItem.index] = 0;
	}
}

ItemMove = function(character, item)
{
	var fetchItem = FindItemOnCharacter(character, item);
	
	if (fetchItem != 0)
	{
		//delete item
		ItemToMove = item;
	}
}

//custom methods

ConsumeMedicine = function(character, item)
{
	var dialogue = array_create(1);
	dialogue[0] = character.name + " drinks a vial of medicine.";
	DisplayDialogue(global.nameless, dialogue, false);
	
	ItemDiscard(character, item);
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