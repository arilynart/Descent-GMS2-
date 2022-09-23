/// @description Destroy DS



//lockedHandCards = ds_list_create();
//highlightedLusium = ds_list_create();
//hoverHighlightedLusium = ds_list_create();
//manaButtons = ds_list_create();
//revertManaButtons = ds_list_create();

ds_list_destroy(lockedHandCards);
ds_list_destroy(highlightedLusium);
ds_list_destroy(hoverHighlightedLusium);
ds_list_destroy(manaButtons);
ds_list_destroy(revertManaButtons);

ds_list_destroy(global.EffectList);
ds_list_destroy(global.Combatants);
ds_list_destroy(global.Turns);

if (surface_exists(global.BarSurface)) surface_free(global.BarSurface);