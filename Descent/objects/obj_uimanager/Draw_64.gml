/// @description Draw UI elements.


//set mouse gui
mouseX = device_mouse_x_to_gui(0);
mouseY = device_mouse_y_to_gui(0);

//draw character selection HUD

//make the circles into diamonds instead.
draw_set_circle_precision(4);

var outlineRadius = 8;

draw_set_color(c_black);
draw_circle(0, quarterY, quarterY, false);
draw_set_color(c_dkgray);

//outline
draw_line_width(0, 0, quarterY, quarterY, outlineRadius);
draw_line_width(0, halfY, quarterY, quarterY, outlineRadius);

//outline notches
draw_set_color(c_gray);
draw_circle(0, 0, outlineRadius, false);
draw_circle(quarterY, quarterY, outlineRadius, false);
draw_circle(0, halfY, outlineRadius, false);

//add diamonds for each ally.


var allySize = array_length(global.Allies);

for (var i = 0; (i < allySize && i < 6) ; i++)
{
	draw_set_color(c_gray);
	var ally = global.Allies[i];
	
	var division = quarterY / 4
	
	var posX = -division;
	var posY = -division;
	
	switch (i)
	{
		case 0:
			posX = division;
			posY = division;
			break;
		case 1:
			posX = division * 2;
			posY = division * 2;
			break;
		case 2:
			posX = division * 3;
			posY = division * 3;
			break;
		case 3:
			posX = division * 3;
			posY = division * 5;
			break;
		case 4:
			posX = division * 2;
			posY = division * 6;
			break;
		case 5:
			posX = division;
			posY = division * 7;
			break;
	}
	
	var buttonStruct =
	{
		left : posX - allyRadius,
		top : posY - allyRadius,
		right : posX + allyRadius,
		bottom : posY + allyRadius
	}
	
	uiCharacterButtons[i] = buttonStruct;
	
	if (mouseX >= uiCharacterButtons[i].left && mouseX <= uiCharacterButtons[i].right
	 && mouseY >= uiCharacterButtons[i].top && mouseY <= uiCharacterButtons[i].bottom)
	{
		draw_set_color(c_white);
	}
	else
	{
		draw_set_color(c_gray);
	}
	
	draw_circle(posX, posY, allyRadius, false);
	draw_sprite_ext(ally.sprite_index, -1, posX, posY, ally.uiScale, ally.uiScale, 
					image_angle, c_white, 1);
	
	if (inventoryDraw == i)
	{
		//draw this character's packs
		var packPosX = 0;
		var packPosY = 0;
		uiPackButtons = array_create(0);
		for (var j = 0; j < array_length(ally.equippedPacks); j++)
		{
			packPosX = quarterX + ((allyRadius + division) * j);
			packPosY = quarterY / 4;
			
			var packButtonStruct =
			{
				left : packPosX - allyRadius,
				top : packPosY - allyRadius,
				right : packPosX + allyRadius,
				bottom : packPosY + allyRadius
			}
				
			array_push(uiPackButtons, packButtonStruct);
				
			if (mouseX >= uiPackButtons[j].left && mouseX <= uiPackButtons[j].right
			 && mouseY >= uiPackButtons[j].top && mouseY <= uiPackButtons[j].bottom)
			{
				draw_set_color(c_white);
			}
			else
			{
				draw_set_color(c_gray);
			}
				
			draw_circle(packPosX, packPosY, allyRadius, false);
			
			var currentPack = ally.equippedPacks[j]
			var packSprite = currentPack.sprite;
			var spriteScale = (allyRadius) / sprite_get_width(packSprite);
			
			draw_sprite_ext(packSprite, 0, packPosX - (allyRadius / 2), packPosY - (allyRadius / 2), 
							spriteScale, spriteScale, image_angle, c_white, 1);
			
			//display pack contents
			if (packDraw == j)
			{
				//var inventoryPad = allyRadius / 8;
				var contentPosY = quarterY / 2;
				draw_set_color(c_gray);
				for (var k = 0; k < currentPack.width; k++)
				{
					for (var l = 0; l < currentPack.height; l++)
					{
						draw_circle((packPosX + (allyRadius)) 
									 + ((division + (allyRadius)) * k), 
									 contentPosY + ((division + (allyRadius)) * l), 
									 allyRadius, false);
					}
				}
			}
		}
		
	}
	

}

//draw Dialogue Box.
var dialogueLength = array_length(dialogueArray);
if (displayDialogue && dialogueLength > 0)
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
	
		//draw line
		var linePad = 8;
		var lineWidth = 1;
		var lineY = topLeftY + textPad + namePad + namePad
		draw_line_width(topLeftX + linePad, lineY, bottomRightX - linePad, lineY, lineWidth);
		
		//draw text
		draw_set_font(fnt_Cambria16);
		draw_text(topLeftX + textPad, 
					topLeftY + textPad + namePad + lineWidth + linePad,
					dialogueArray[dialogueCount]);
	}
	else
	{
		displayDialogue = false;
	}
}