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
					
					var item =
					{
						name : "Medicine",
						sprite : spr_Potions,
						maxQuantity : 10,
						quantity : quantity,
						index : index,
						type : type,
						methods : ds_list_create()
					}
					
					var Consume = 
					{
						name : "Drink",
						description : "Heals the drinker for 25 HP.",
						Execute : method(global, ConsumeMedicine)
					}
					ds_list_add(item.methods, Consume);
					
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

// Always pass the character who uses the item. 

//standard methods. Move and discard.

ConsumeMedicine = function(character)
{
	var dialogue = array_create(1);
	dialogue[0] = character.name + " drinks a vial of medicine.";
	DisplayDialogue(character, dialogue, true);
}

#endregion