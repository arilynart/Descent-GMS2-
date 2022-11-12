// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BurnLusiumEffect(effect)
{
	var newLusium =
	{
		capacity : effect.lusiumIndex + 1,
		heldCards : ds_list_create(),
		slotButtons : ds_list_create()
	}
	
	ds_list_add(effect.character.burntLusium, newLusium);
	
	EndEffect();
}