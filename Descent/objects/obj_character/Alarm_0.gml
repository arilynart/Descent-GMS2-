/// @description card play animation

if (ds_queue_size(artQueue) > 0)
{
	currentArt = ds_queue_dequeue(artQueue);
	alarm_set(0, artMaxTime);
}
else currentArt = -1;