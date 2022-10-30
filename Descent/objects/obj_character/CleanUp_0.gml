/// @description destroy all DS

ds_queue_destroy(moveQueue)
ds_queue_destroy(artQueue)

ds_list_destroy(nodes);
ds_list_destroy(extra);
ds_list_destroy(removed);
ds_list_destroy(hand);
ds_list_destroy(discard);

ds_list_destroy(threatCards);

for (var i = 0; i < ds_list_size(burntLusium); i++)
{
	var piece = ds_list_find_value(burntLusium, i);
	
	ds_list_destroy(piece.heldCards);
	ds_list_destroy(piece.slotButtons);
}
ds_list_destroy(burntLusium);
ds_list_destroy(loadedLusium);