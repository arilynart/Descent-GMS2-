/// @description Initialize


global.UiManager = self;

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

#region Methods

function DisplayDialogue(character, dialogue)
{
	dialogueCount = 0;
	dialogueCharacter = character;
	dialogueArray = dialogue;
	displayDialogue = true;
}

function AdvanceDialogue()
{
	dialogueCount += 1;
}

function TestDialogue()
{
	var testArray = array_create(0);
	
	var line1 = "Hello. This is a test. It looks like the dialogue is working correctly.";
	var line2 = "You've advanced the dialogue. This is my second line.";
	
	array_push(testArray, line1, line2);
	
	DisplayDialogue(global.Player, testArray);
}

TestDialogue();

#endregion