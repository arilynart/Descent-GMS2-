// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function DisplayDialogue(character, dialogue)
{
	show_debug_message("Displaying Dialogue from " + string(character.characterStats.name) + ". Array: " 
					   + string(dialogue));
	var manager = global.UiManager;
	
	manager.dialogueCharacter = character;
	manager.dialogueArray = dialogue;
	manager.dialogueCount = 0;
	manager.displayDialogue = true;
}

function AdvanceDialogue()
{
	global.UiManager.dialogueCount += 1;
}

////a method to test dialogue system

//function TestDialogue()
//{
//	var testArray = array_create(0);
	
//	var line1 = "Hello. This is a test. It looks like the dialogue is working correctly.";
//	var line2 = "You've advanced the dialogue. This is my second line.";
	
//	array_push(testArray, line1, line2);
	
//	DisplayDialogue(global.Player, testArray);
//}