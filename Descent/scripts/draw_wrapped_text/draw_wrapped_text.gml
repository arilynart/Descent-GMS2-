// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function draw_wrapped_text(text, maxWidth, topX, topY, descModifier, descRatio)
{
	var wrap = global.TextWrap(text, maxWidth);
	
	var wrapCopy = wrap.text;
	var wrapSplits = array_create(0);
	var splitBy = "|";
			
	while(string_length(wrapCopy) > 0)
	{
		if (string_pos(splitBy, wrapCopy) > 0)
		{
			if (string_pos("\n", wrapCopy) > 0)
			{
				var splitString = string_copy(wrapCopy, 1, string_pos("\n", wrapCopy) - 1);
				array_push(wrapSplits, splitString)
				wrapCopy = string_delete(wrapCopy, 1, string_pos("\n", wrapCopy));
			}
			else
			{
				array_push(wrapSplits, wrapCopy);
				wrapCopy = "";
			}
					
		}
		else
		{
			array_push(wrapSplits, wrapCopy);
			wrapCopy = "";
		}
	}
			
	var imageIndex = 0;
	var currentY = topY;
	for (var section = 0; section < array_length(wrapSplits); section++)
	{
		var firstCopy =  wrapSplits[section];
		var descriptionCopy =  wrapSplits[section];
		var splits = array_create(0);
		var currentX = topX;
		
			
		while(string_length(descriptionCopy) > 0)
		{
			if (string_pos(splitBy, descriptionCopy) > 0)
			{
				var splitString = string_copy(descriptionCopy, 1, string_pos(splitBy, descriptionCopy) - 1);
				array_push(splits, splitString)
				descriptionCopy = string_delete(descriptionCopy, 1, string_pos(splitBy, descriptionCopy));
			}
			else
			{
				array_push(splits, descriptionCopy);
				descriptionCopy = "";
			}
		}
		
		for (var j = 0; j < array_length(splits); j++)
		{
			if (j % 2 == 1)
			{
				//draw image at current spot
				currentX += string_width(splits[j - 1]);
				//currentY += string_height(splits[i - 1]);
			
				var sprite = wrap.sprites[imageIndex];
				var spriteWidth  = sprite_get_width(sprite);
				var imgScale = (font_get_size(draw_get_font()) + descModifier) / spriteWidth;
				
				draw_sprite_ext(sprite, 0, currentX + ceil(descModifier * descRatio), currentY + ceil(descModifier * descRatio), imgScale, imgScale, 0, c_white, 1);
			
				currentX += font_get_size(draw_get_font()) + descModifier;
				imageIndex++;
				
				draw_text(currentX, currentY, splits[j]);
			}
			else
			{
				//draw string
				draw_text(currentX, currentY, splits[j]);
			}
		}
		currentY += string_height(firstCopy);
	}
}

TextWrap = function(inputString, maxWidth)
{
	var sprites = array_create(0);
	
	var checkString = string_copy(inputString, 0, string_length(inputString));
	//show_debug_message("Wrapping String: " + checkString);
	var newString = "";
	var newLine = "";
	for (var i = 0; i < string_length(checkString); checkString = string_delete(checkString, 1, 1))
	{
		var character = string_char_at(checkString, 0);
		
		newLine += character;
		//show_debug_message("Checking character: " + character);
		if (character == " ")
		{
			//check if the next word is too long to fit in width;
			var wordString = string_copy(checkString, 2, string_pos_ext(" ", checkString, 1) - 2);
			//show_debug_message("Checking Line. " + newLine);
			//show_debug_message("Checking Word. " + wordString);
			var tempString = newLine + wordString;
			//show_debug_message("Checking string: " + tempString);
			//show_debug_message("Checking width: " + string(string_width(tempString)) + " to " + string(maxWidth));
			
			if (string_width(tempString) > maxWidth)
			{
				
				newLine += "\n";
				//show_debug_message("String is too long. Wrapping. " + newLine);
				newString += newLine;
				
				newLine = "";
			}
		}
		else if (character == "|")
		{
			//sprite found.
			var spriteString = string_copy(checkString, 2, string_pos_ext("|", checkString, 2) - 2);
			//show_debug_message("Drawing Sprite: " + spriteString);
			array_push(sprites, asset_get_index(spriteString));
			newLine += "|";
			
			//show_debug_message("Deleting: " + string_copy(checkString, 1, string_pos_ext("|", checkString, 2)));
			checkString = string_delete(checkString, 1, string_pos_ext("|", checkString, 2));
		}
		
		if (string_length(checkString) <= 1)
		{
			newString += newLine;
		}
	}
	
	var wrap = { }
	
	wrap.sprites = sprites;
	wrap.text = newString;
	
	return wrap;
}