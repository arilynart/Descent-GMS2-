/// @description destroy all DS

ds_queue_destroy(moveQueue)
ds_queue_destroy(artQueue)

//nodes = ds_list_create();
//extra = ds_list_create();
//removed = ds_list_create();
//hand = ds_list_create();
//discard = ds_list_create();

ds_list_destroy(nodes);
ds_list_destroy(extra);
ds_list_destroy(removed);
ds_list_destroy(hand);
ds_list_destroy(discard);

//burntLusium = ds_list_create();
//loadedLusium = ds_list_create();

for (var i = 0; i < ds_list_size(burntLusium); i++)
{
	var piece = ds_list_find_value(burntLusium, i);
	
	ds_list_destroy(piece.heldCards);
	ds_list_destroy(piece.slotButtons);
}
ds_list_destroy(burntLusium);
ds_list_destroy(loadedLusium);