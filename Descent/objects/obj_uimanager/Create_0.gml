/// @description Initialize

fnt_Bold = font_add("sitka-small.ttf", 24, true, false, 32, 128);

global.UiManager = self;
global.UiLock = false;
global.SquareLock = false;

#region colors

deckLightColor = #348CEB;

#endregion

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
thirdY = ceil(fullY / 3);

dialogueCount = 0;
dialogueArray = array_create(0);
displayDialogue = false;
dialogueCharacter = 0;

uiCharacterButtons = array_create(6);

uiPackButtons = 0;
uiItemButtons = 0;
uiMethodButtons = 0;

allyRadius = quarterY / 6

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
resetLoadButton = 0;

dragCard = -1;
handDraw = true;
handDrawButton = 0;
handButtons = array_create(0);
lockedHandCards = ds_list_create();

tempItemPack =
{
	contents : array_create(1)	
}

window_set_fullscreen(true);

var emptyStats =
{
	name : ""
}
global.nameless =
{
	characterStats : emptyStats
}

#region Methods

function TestDialogue()
{
	var testArray = array_create(0);
	
	var line1 = "Hello. This is a test. It looks like the dialogue is working correctly.";
	var line2 = "You've advanced the dialogue. This is my second line.";
	
	array_push(testArray, line1, line2);
	
	DisplayDialogue(global.Player, testArray, true);
}

function DrawPrompt(text)
{
	if (text != "")
	{
		var topY = fullY - quarterY / 2;
		var bottomY = fullY - (quarterY / 4)
		draw_set_color(c_black);
		draw_roundrect(quarterX, topY, fullX - quarterX, bottomY, false);
		
		var yDiff = bottomY - topY;
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_font(fnt_Cambria24);
		draw_text(halfX, topY + yDiff / 8, text);
	}
}

function SupplyFromCard(index, character, element, amount)
{
	ds_list_add(lockedHandCards, index);
	
	var discard = global.BaseEffect();
	discard.Start = method(global, global.DiscardFromHandEffect);
	discard.character = character;
	discard.index = index;
	
	AddEffect(discard);
	
	var supply = global.BaseEffect();
	supply.Start = method(global, global.SupplyManaEffect);
	supply.character = global.selectedCharacter;
	supply.element = element;
	supply.amount = amount;
	
	AddEffect(supply);
	
	
}

//TestDialogue();

#endregion