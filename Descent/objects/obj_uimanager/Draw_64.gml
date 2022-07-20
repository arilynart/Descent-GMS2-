/// @description Draw UI elements.


//draw Dialogue Box.
var dialogueLength = array_length(dialogueArray)
if (displayDialogue == true && dialogueLength > 0)
{
	if (dialogueCount < dialogueLength)
	{
	//draw box, fill with text.
	draw_set_color(c_black);
	var topLeftX = thirdX;
	var topLeftY = fullY - (quarterY / 2);
	var bottomRightX = thirdX * 2;
	var bottomRightY = fullY - 5;
		
	//draw
	draw_roundrect(topLeftX, topLeftY, bottomRightX, bottomRightY, false);

	//set parameters for drawing text.
	var namePad = 4;
	var textPad = 28;
	draw_set_color(c_white);
	
	draw_set_halign(fa_left);
		
	//draw name
	draw_set_font(fnt_Cambria24);
	draw_text(topLeftX + namePad, topLeftY + namePad, dialogueCharacter.name);
		
	//draw text
	draw_set_font(fnt_Cambria16);
	draw_text(topLeftX + textPad + namePad, topLeftY + textPad + namePad, dialogueArray[dialogueCount]);
	}
	else
	{
		displayDialogue = false;
	}

}