/// @description ???





//activatedSquares = ds_list_create();

//parsedCoordinates = ds_list_create();
//parseQueue = ds_queue_create();


//highlightArray = ds_list_create();
//dehighlightArray = ds_list_create();

ds_list_destroy(activatedSquares);
ds_list_destroy(parsedCoordinates);
ds_queue_destroy(parseQueue);
ds_list_destroy(highlightArray);
ds_list_destroy(dehighlightArray);
