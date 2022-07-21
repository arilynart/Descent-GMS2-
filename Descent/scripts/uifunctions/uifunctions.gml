// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function DisplayDialogue(character, dialogue)
{
	show_debug_message("Displaying Dialogue from " + string(character.name) + ". Array: " 
					   + string(dialogue));
	var manager = global.UiManager;

	manager.dialogueCharacter = character;
	manager.dialogueArray = dialogue;
	manager.dialogueCount = -1;
	manager.displayDialogue = true;
}

function AdvanceDialogue()
{
	global.UiManager.dialogueCount += 1;
}