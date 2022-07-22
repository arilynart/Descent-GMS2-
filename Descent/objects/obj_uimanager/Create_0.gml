/// @description Initialize


global.UiManager = self;
global.UiLock = false;

fullX = display_get_gui_width();
fullY = display_get_gui_height();

halfX = fullX / 2;
halfY = fullY / 2;

quarterX = halfX / 2;
quarterY = halfY / 2;

thirdX = fullX / 3;
thirdY = fullY / 3;

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

tempItem = 0;

window_set_fullscreen(true);

global.nameless =
{
	name : ""
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

//TestDialogue();

#endregion