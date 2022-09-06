// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
LoadWeaponEffect = function(effect)
{
	for (var i = 0; i < array_length(effect.character.itemsToLoad); i++)
	{
		var fetchItem = effect.character.itemsToLoad[i];
					
		if (fetchItem != 0)
		{
			var loadedItem = 0;
			for (var j = 0; j < ds_list_size(effect.character.loadedLusium); j++)
			{
				var item = ds_list_find_value(effect.character.loadedLusium, j);
				if (item != 0 && item.type == ItemTypes.Lusium && item.index == fetchItem.index)
				{
					item.quantity += fetchItem.quantity;
							
					loadedItem = item;
				}
			}

					
					
			if (loadedItem == 0)
			{
				//new item
				ds_list_add(effect.character.loadedLusium, fetchItem);
			}
		}
	}
	effect.character.itemsToLoad = array_create(0);
	
	EndEffect();
}