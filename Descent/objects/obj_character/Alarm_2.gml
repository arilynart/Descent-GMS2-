/// @description card finish fade out

if (ds_queue_size(artQueue) > 0)
{
	currentArt = ds_queue_dequeue(artQueue);
	alarm_set(1, artInTime);
}
else currentArt = -1;