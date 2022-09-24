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

function DrawCard(x, y, card)
{
	var cardHeight = ceil(global.UiManager.halfY * (7 / 8));
	var cardWidth = ceil((cardHeight / 3) * 2);
	
	var halfX = ceil(x + cardWidth / 2);
	var halfY = ceil(y + cardHeight / 2);

	
	//var quarterY = y + cardHeight / 4;
	
	//var eighthX = ceil(x + cardWidth / 8);
	var eighthY = ceil(y + cardHeight / 8);
	
	var sixteenthX = ceil(x + cardWidth / 16);
	var sixteenthY = ceil(y + cardHeight / 16);
	
	//var thirdX = ceil(x + cardWidth / 3);
	var thirdY = ceil(y + cardHeight / 3);
	
	//var sixthX = ceil(x + cardWidth / 6);
	
	var frameScale = cardHeight / sprite_get_height(card.frame);
	draw_sprite_ext(card.frame, 0, x, y, frameScale, frameScale, 0, c_white, 1);
	
	//art
	var artScale = ((cardWidth / 3) * 2) / sprite_get_width(card.art);
	draw_sprite_ext(card.art, 0, halfX, thirdY, artScale, artScale, 0, c_white, 1);
	
	//rarity
	var raritySprite = spr_Cancel;
	switch (card.rarity)
	{
		case CardRarities.Common:
			raritySprite = spr_common;
		break;
		case CardRarities.Uncommon:
			raritySprite = spr_uncommon;
		break;
		case CardRarities.Rare:
			raritySprite = spr_rare;
		break;
		case CardRarities.Mythic:
			raritySprite = spr_mythic;
		break;
		case CardRarities.Legendary:
			raritySprite = spr_legendary;
		break;
		case CardRarities.Primal:
			raritySprite = spr_primal;
		break;
		
	}
	var rarityScale = (cardWidth / 24) / sprite_get_width(raritySprite);
	draw_sprite_ext(raritySprite, 0, halfX, sixteenthY, rarityScale, rarityScale, 0, c_white, 1);

	//title
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(global.UiManager.fnt_Bold);
	draw_set_color(c_white);
	draw_text_transformed(halfX, eighthY, card.title, card.titleFontScale, card.titleFontScale, 0);
	
	//cost
	if (card.type == CardTypes.Node)
	{
		var costArray = global.SortCostArray(card);
		
		var costWidth = (cardWidth / 16);
		var costLength = array_length(costArray);
		var costX = halfX - ((costLength / 2) * (costWidth)) + (costWidth / 2);
		var costY = eighthY + 18;
		for (var i = 0; i < costLength; i++)
		{
			var cost = costArray[i];
				
			var costScale = costWidth / sprite_get_width(cost);
			costWidth = sprite_get_width(cost) * costScale;
				
			draw_sprite_ext(cost, 0, costX, costY, costScale, costScale, 0, c_white, 1);
				
			costX += costWidth + 1;
		}
	}
	else
	{
		var costX = halfX;
		var costY = eighthY + 18;
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fnt_CardText);
		draw_text(costX, costY, card.costText);
	}
	
	var fontSize = font_get_size(draw_get_font());
	
	//type
	draw_set_halign(fa_left);
	draw_set_font(fnt_CardText);
	draw_text_transformed(sixteenthX, halfY + fontSize, card.typeText, card.typeFontScale, card.typeFontScale, 0);
	
	draw_line(sixteenthX, halfY + 10 + fontSize, x + cardWidth - cardWidth / 16, halfY + 10 + fontSize)
	
	//text
	draw_set_valign(fa_top);
	
	draw_wrapped_text(card.text, cardWidth - (cardWidth / 16) * 3, sixteenthX + (cardWidth / 32), halfY + 15 + fontSize, 6, 1.4);
	
	//supply
	if (card.type == CardTypes.Node)
	{
		var supplyX = sixteenthX;
		var supplyY = y + cardHeight - (cardWidth / 8);
		
		var supplyString = "Supply - ";
		draw_text(supplyX, supplyY, supplyString);
		
		supplyX += string_width(supplyString);
		
		var supplyArray = global.SortSupplyArray(card);
		
		var costWidth = (cardWidth / 16);
		var costLength = array_length(supplyArray);
		for (var i = 0; i < costLength; i++)
		{
			var cost = supplyArray[i];
				
			var costScale = costWidth / sprite_get_width(cost);
			costWidth = sprite_get_width(cost) * costScale;
				
			draw_sprite_ext(cost, 0, supplyX + costWidth / 2, supplyY + costWidth / 2, costScale, costScale, 0, c_white, 1);
			
			supplyX += costWidth + 1;
		}
	}
	
	//index
	var fontSize = font_get_size(draw_get_font());
	draw_text(x + cardWidth - fontSize * 2, y + cardHeight - fontSize * 2, string(card.index))
}

function TestDialogue()
{
	var testArray = array_create(0);
	
	var line1 = "Hello. This is a test. It looks like the dialogue is working correctly.";
	var line2 = "You've advanced the dialogue. This is my second line.";
	
	array_push(testArray, line1, line2);
	
	DisplayDialogue(global.Player, testArray);
}

function DrawPrompt(text)
{
	if (text != "")
	{
		var topY = fullY - quarterY / 2;
		var bottomY = fullY - (quarterY / 4)
		draw_set_color(c_black);
		draw_roundrect(quarterX, topY, fullX - quarterX, bottomY, false);

		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fnt_Cambria24);
		draw_wrapped_text(text, halfX, halfX, topY + (quarterY / 8), 4, 1);
	}
}

function SupplyFromCard(character, element, amount)
{
	
	var supply = global.BaseEffect();
	supply.Start = method(global, global.SupplyManaEffect);
	supply.character = character;
	supply.element = element;
	supply.amount = amount;
	
	AddEffect(supply);
	
	
}

function PlayHandCard(character, spendPool, handIndex, lusiumIndex)
{
	//var card = ds_list_find_value(character.hand, handIndex);
	
	//play the card on a new piece of lusium, spend mana
	var spendMana = global.BaseEffect();
	spendMana.Start = method(global, global.SpendManaEffect);
	spendMana.character = global.selectedCharacter;
	spendMana.spendPool = spendPool;
						
	AddEffect(spendMana);
						
	var playNode = global.BaseEffect();
	playNode.Start = method(global, global.PlayNodeEffect);
	playNode.character = character;
	playNode.index = handIndex;
	playNode.lusiumIndex = lusiumIndex;
	
	AddEffect(playNode);
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
	
	var wrap =
	{
		text : newString,
		sprites : sprites
	}
	
	return wrap;
}

SortCostArray = function(card)
{
	var costArray = array_create(0);
	if (card.wCost > 0)
	{
		repeat(card.wCost)
		{
			array_push(costArray, spr_W);
		}
	}
	if (card.fCost > 0)
	{
		repeat(card.fCost)
		{
			array_push(costArray, spr_F);
		}
	}
	if (card.mCost > 0)
	{
		repeat(card.mCost)
		{
			array_push(costArray, spr_M);
		}
	}
	if (card.sCost > 0)
	{
		repeat(card.sCost)
		{
			array_push(costArray, spr_S);
		}
	}
	if (card.eCost > 0)
	{
		repeat(card.eCost)
		{
			array_push(costArray, spr_E);
		}
	}
	if (card.dCost > 0)
	{
		repeat(card.dCost)
		{
			array_push(costArray, spr_D);
		}
	}
	if (card.vCost > 0)
	{
		repeat(card.vCost)
		{
			array_push(costArray, spr_V);
		}
	}
	
	return costArray;
}

SortSupplyArray = function(card)
{
	var supplyArray = array_create(0);
	if (card.wSupply > 0)
	{
		repeat(card.wSupply)
		{
			array_push(supplyArray, spr_W);
		}
	}
	if (card.fSupply > 0)
	{
		repeat(card.fSupply)
		{
			array_push(supplyArray, spr_F);
		}
	}
	if (card.mSupply > 0)
	{
		repeat(card.mSupply)
		{
			array_push(supplyArray, spr_M);
		}
	}
	if (card.sSupply > 0)
	{
		repeat(card.sSupply)
		{
			array_push(supplyArray, spr_S);
		}
	}
	if (card.eSupply > 0)
	{
		repeat(card.eSupply)
		{
			array_push(supplyArray, spr_E);
		}
	}
	if (card.dSupply > 0)
	{
		repeat(card.dSupply)
		{
			array_push(supplyArray, spr_D);
		}
	}
	if (card.vSupply > 0)
	{
		repeat(card.vSupply)
		{
			array_push(supplyArray, spr_V);
		}
	}
	
	return supplyArray;
}

SortPools = function(character)
{
	var array = array_create(0);
	
	if (character.wPool > 0)
	{
		var struct =
		{
			element : Elements.W,
			sprite : spr_W,
			amount : character.wPool - global.UiManager.selectSpendPool.wPool
		}
		array_push(array, struct);
	}
	if (character.fPool > 0)
	{
		var struct =
		{
			element : Elements.F,
			sprite : spr_F,
			amount : character.fPool - global.UiManager.selectSpendPool.fPool
		}
		array_push(array, struct);
	}
	if (character.mPool > 0)
	{
		var struct =
		{
			element : Elements.M,
			sprite : spr_M,
			amount : character.mPool - global.UiManager.selectSpendPool.mPool
		}
		array_push(array, struct);
	}
	if (character.sPool > 0)
	{
		var struct =
		{
			element : Elements.S,
			sprite : spr_S,
			amount : character.sPool - global.UiManager.selectSpendPool.sPool
		}
		array_push(array, struct);
	}
	if (character.ePool > 0)
	{
		var struct =
		{
			element : Elements.E,
			sprite : spr_E,
			amount : character.ePool - global.UiManager.selectSpendPool.ePool
		}
		array_push(array, struct);
	}
	if (character.dPool > 0)
	{
		var struct =
		{
			element : Elements.D,
			sprite : spr_D,
			amount : character.dPool - global.UiManager.selectSpendPool.dPool
		}
		array_push(array, struct);
	}
	if (character.vPool > 0)
	{
		var struct =
		{
			element : Elements.V,
			sprite : spr_V,
			amount : character.vPool
		}
		array_push(array, struct);
	}
	
	return array;
}

SortSpendPools = function()
{
	var array = array_create(0);
	
	if (global.UiManager.selectSpendPool.wPool > 0)
	{
		var struct =
		{
			element : Elements.W,
			sprite : spr_W,
			amount : global.UiManager.selectSpendPool.wPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.fPool > 0)
	{
		var struct =
		{
			element : Elements.F,
			sprite : spr_F,
			amount : global.UiManager.selectSpendPool.fPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.mPool > 0)
	{
		var struct =
		{
			element : Elements.M,
			sprite : spr_M,
			amount : global.UiManager.selectSpendPool.mPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.sPool > 0)
	{
		var struct =
		{
			element : Elements.S,
			sprite : spr_S,
			amount : global.UiManager.selectSpendPool.sPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.ePool > 0)
	{
		var struct =
		{
			element : Elements.E,
			sprite : spr_E,
			amount : global.UiManager.selectSpendPool.ePool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.dPool > 0)
	{
		var struct =
		{
			element : Elements.D,
			sprite : spr_D,
			amount : global.UiManager.selectSpendPool.dPool
		}
		array_push(array, struct);
	}
	if (global.UiManager.selectSpendPool.vPool > 0)
	{
		var struct =
		{
			element : Elements.V,
			sprite : spr_V,
			amount : global.UiManager.selectSpendPool.vPool
		}
		array_push(array, struct);
	}
	
	return array;
}

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

function DrawSummon(character, characterStats)
{
	var doubleRadius = allyRadius * 2;
	
	draw_set_color(c_gray);
	
	var spriteX = halfX + quarterX;
	var spriteY = quarterY;
	draw_circle(spriteX, spriteY, doubleRadius, false);
	
	var spriteScale = doubleRadius * 2 / sprite_get_width(character.sprite_index);
	draw_sprite_ext(character.sprite_index, character.image_index, spriteX, spriteY, spriteScale, spriteScale, 0, c_white, 1);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_Cambria24);
	draw_set_color(c_gray);
	
	draw_text(spriteX, spriteY + doubleRadius * 1.5, characterStats.name);
	
	var elementSprites = array_create(0);
	switch (characterStats.element)
	{
		case Elements.W:
			array_push(elementSprites, spr_W);
		break;
		case Elements.F:
			array_push(elementSprites, spr_F);
		break;
		case Elements.M:
			array_push(elementSprites, spr_M);
		break;
		case Elements.S:
			array_push(elementSprites, spr_S);
		break;
		case Elements.E:
			array_push(elementSprites, spr_E);
		break;
		case Elements.D:
			array_push(elementSprites, spr_D);
		break;
		case Elements.WF:
			array_push(elementSprites, spr_W);
			array_push(elementSprites, spr_F);
		break;
		case Elements.WM:
			array_push(elementSprites, spr_W);
			array_push(elementSprites, spr_M);
		break;
		case Elements.WS:
			array_push(elementSprites, spr_W);
			array_push(elementSprites, spr_S);
		break;
		case Elements.WE:
			array_push(elementSprites, spr_W);
			array_push(elementSprites, spr_E);
		break;
		case Elements.WD:
			array_push(elementSprites, spr_W);
			array_push(elementSprites, spr_D);
		break;
		case Elements.FM:
			array_push(elementSprites, spr_F);
			array_push(elementSprites, spr_M);
		break;
		case Elements.FS:
			array_push(elementSprites, spr_F);
			array_push(elementSprites, spr_S);
		break;
		case Elements.FE:
			array_push(elementSprites, spr_F);
			array_push(elementSprites, spr_E);
		break;
		case Elements.FD:
			array_push(elementSprites, spr_F);
			array_push(elementSprites, spr_D);
		break;
		case Elements.MS:
			array_push(elementSprites, spr_M);
			array_push(elementSprites, spr_S);
		break;
		case Elements.ME:
			array_push(elementSprites, spr_M);
			array_push(elementSprites, spr_E);
		break;
		case Elements.MD:
			array_push(elementSprites, spr_M);
			array_push(elementSprites, spr_D);
		break;
		case Elements.SE:
			array_push(elementSprites, spr_S);
			array_push(elementSprites, spr_E);
		break;
		case Elements.SD:
			array_push(elementSprites, spr_S);
			array_push(elementSprites, spr_D);
		break;
		case Elements.ED:
			array_push(elementSprites, spr_E);
			array_push(elementSprites, spr_D);
		break;
	}
	
	for (var i = 0; i < array_length(elementSprites); i++)
	{
		var elementX = spriteX - (floor(array_length(elementSprites) / 2) * (allyRadius / 2)) + (i * allyRadius);
		var elementY = spriteY + doubleRadius * 2;
		
		var elementScale = allyRadius / sprite_get_width(elementSprites[i]);
		draw_sprite_ext(elementSprites[i], 0, elementX, elementY, elementScale, elementScale, 0, c_white, 1);
	}
	
	
	var leftStatsX = ceil(halfX + sixteenthX * 1.5);
	var rightStatsX = ceil(halfX + eighthX + sixteenthX);
	var linePad = 20;
	
	var enduranceY = elementY;
	var vitalityY = enduranceY + linePad;
	var forceY = vitalityY + linePad;
	var tempoY = forceY + linePad;
	var generationY = forceY + linePad * 5;
	var generationX = leftStatsX + allyRadius
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_Cambria16);
	draw_set_color(c_gray);
	
	draw_text(leftStatsX, enduranceY, "Endurance:  ");
	draw_text(rightStatsX, enduranceY, "SP:  ");
	draw_text(leftStatsX, vitalityY, "Vitality:  ");
	draw_text(rightStatsX, vitalityY, "HP:  ");
	draw_text(leftStatsX, forceY, "Force:  ");
	draw_text(leftStatsX, tempoY, "Tempo:  ");
	draw_text(leftStatsX, generationY, "Generation:  ");
	
	draw_set_halign(fa_left);
	draw_text(leftStatsX, enduranceY, string(characterStats.endurance));
	draw_text(rightStatsX, enduranceY, string(character.maxSp()));
	draw_text(leftStatsX, vitalityY, string(characterStats.vitality));
	draw_text(rightStatsX, vitalityY, string(character.maxHp()));
	draw_text(leftStatsX, forceY, string(characterStats.force));
	draw_text(leftStatsX, tempoY, string(characterStats.tempo));
	
	draw_circle(generationX, generationY, allyRadius, false);
}