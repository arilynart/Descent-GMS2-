/// @description Initialize

nodes = ds_list_create();
extra = ds_list_create();
removed = ds_list_create();
hand = ds_list_create();
discard = ds_list_create();

function EmptyMana()
{
	wPool = 0;
	fPool = 0;
	mPool = 0;
	sPool = 0;
	ePool = 0;
	dPool = 0;
	vPool = 0;
}

EmptyMana();

//lusium
burntLusium = ds_list_create();
loadedLusium = ds_list_create();
itemsToLoad = array_create(0);

loadedQuantity = function()
{
	var q = 0;
	for (var i = 0; i < array_length(itemsToLoad); i++)
	{
		var item = itemsToLoad[i];
		q += item.quantity;
	}
	return q;
}

function ResetLoaded()
{
	for (var i = 0; i < array_length(itemsToLoad); i++)
	{
		AutoPickup(self, itemsToLoad[i]);
	}
	itemsToLoad = array_create(0);
}