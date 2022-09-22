/// @description Initialize

map = instance_find(obj_Map, 0);

fnt_Bold = font_add("sitka-small.ttf", 18, true, false, 32, 128);

global.UiManager = self;
global.UiLock = false;
global.SquareLock = false;

#region colors

deckLightColor = #348CEB;

#endregion

//display_reset(8, false);

fullX = display_get_gui_width();
fullY = display_get_gui_height();

halfX = fullX / 2;
halfY = fullY / 2;

quarterX = halfX / 2;
quarterY = halfY / 2;

eighthY = quarterY / 2;

sixteenthY = eighthY / 2;

thirtySecondY = sixteenthY / 2;

thirdX = ceil(fullX / 3);
//thirdY = ceil(fullY / 3);

dialogueCount = 0;
dialogueArray = array_create(0);
displayDialogue = false;
dialogueCharacter = 0;

uiCharacterButtons = array_create(6);

uiPackButtons = 0;
uiItemButtons = 0;
uiMethodButtons = 0;

allyRadius = ceil(quarterY / 6);

mouseX = 0;
mouseY = 0;

inventoryDraw = -1;
packDraw = -1;
itemDraw = -1;

split = 0;
dragSplit = false;
dragX = 0;
splitArea = 0;
splitValue = 0;

confirmSplit = 0;
cancelSplit = 0;

endTurnButton = 0;
igniteButton = 0;
dashButton = 0;
loadButton = 0;
prepLoad = false;
lusiumButtons = array_create(0);
tierToLoadFrom = 1;
confirmLoadButton = 0;
cancelLoadButton = 0;

loadedButtons = array_create(0);
dragCard = -1;
handDraw = true;
handDrawButton = 0;
extraDraw = false;
extraDrawButton = 0;
extraButtons = array_create(0);
handButtons = array_create(0);
lockedHandCards = ds_list_create();

heldRune = -1;
highlightedLusium = ds_list_create();
hoverHighlightedLusium = ds_list_create();
spendLusium = false;
confirmLusiumButton = 0;
cancelLusiumButton = 0;

dragSlot = 0;

spendMana = false;
manaButtons = ds_list_create();
revertManaButtons = ds_list_create();
confirmManaButton = 0;
cancelManaButton = 0;
heldCard = -1;
heldLusium = -1;
requiredV = 0;
addedAmounts = { }
selectSpendPool = { }

function ResetSpendPool(pool)
{
	pool.wPool = 0;
	pool.fPool = 0;
	pool.mPool = 0;
	pool.sPool = 0;
	pool.ePool = 0;
	pool.dPool = 0;
	pool.vPool = 0;
}

ResetSpendPool(selectSpendPool);
ResetSpendPool(addedAmounts);

tempItemPack =
{
	contents : array_create(1)	
}

var emptyStats =
{
	name : ""
}
global.nameless =
{
	characterStats : emptyStats
}

#region Methods

function SetupForManaSpend(cardIndex, card, lusiumIndex)
{
	spendMana = true;
	heldCard = cardIndex;
	heldLusium = lusiumIndex;
	requiredV += card.vCost;
	selectSpendPool.wPool += card.wCost;
	selectSpendPool.fPool += card.fCost;
	selectSpendPool.mPool += card.mCost;
	selectSpendPool.sPool += card.sCost;
	selectSpendPool.ePool += card.eCost;
	selectSpendPool.dPool += card.dCost;
}

function FinishManaSpend()
{
	var lusiumIndex = -1;
	if (heldLusium == 0 || heldLusium == 1 || heldLusium == 2 || heldLusium == 3)
	{
		for (var j = 0; j < ds_list_size(global.selectedCharacter.loadedLusium); j++)
		{
			var item = ds_list_find_value(global.selectedCharacter.loadedLusium, j);
			var item = ds_list_find_value(global.selectedCharacter.loadedLusium, j);
			if (item != 0 && item.type == ItemTypes.Lusium && item.index == heldLusium && item.quantity > 0)
			{
				item.quantity--;
				if (item.quantity <= 0) ds_list_delete(global.selectedCharacter.loadedLusium, j);
				
				lusiumIndex = ds_list_size(global.selectedCharacter.burntLusium);
				var burn = global.BaseEffect();
				burn.Start = method(global, global.BurnLusiumEffect);
				burn.character = global.selectedCharacter;
				burn.lusiumIndex = heldLusium;
		
				AddEffect(burn);
				
				break;
			}
		}
		
		
		if (lusiumIndex == -1) CancelManaSpend();
	}
	else lusiumIndex = ds_list_find_index(global.selectedCharacter.burntLusium, heldLusium);

	PlayHandCard(global.selectedCharacter, selectSpendPool, heldCard, lusiumIndex);
	
	spendMana = false;
	heldCard = -1;
	heldLusium = -1;
	requiredV = 0;
	ResetSpendPool(selectSpendPool);
	ResetSpendPool(addedAmounts);
}

function CancelManaSpend()
{
	spendMana = false;
	heldCard = -1;
	heldLusium = -1;
	requiredV = 0;
	ResetSpendPool(selectSpendPool);
	ResetSpendPool(addedAmounts);
}

#endregion