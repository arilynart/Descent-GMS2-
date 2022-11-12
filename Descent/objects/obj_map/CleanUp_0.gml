/// @description Destroy DS & Surfaces


ds_list_destroy(global.EffectList);
ds_list_destroy(global.Combatants);
ds_list_destroy(global.BondedMonsters);

if (surface_exists(global.BarSurface)) surface_free(global.BarSurface);