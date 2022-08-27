/// @description Draw UI elements.

global.UiLock = false;
//set mouse gui
mouseX = device_mouse_x_to_gui(0);
mouseY = device_mouse_y_to_gui(0);

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
		draw_set_valign(fa_top);
		
		//draw name
		draw_set_font(fnt_Cambria24);
		draw_text(topLeftX + namePad, topLeftY + namePad, dialogueCharacter.characterStats.name);
	
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
else
{
		//make the circles into diamonds instead.
	draw_set_circle_precision(4);
	
	//draw card stuff
	if (global.selectedCharacter != 0 && array_length(global.selectedCharacter.characterStats.nodeDeck) > 0)
	{
		var igniteX = fullX - sixteenthY;
		var igniteY = fullY - sixteenthY;
		if (!global.selectedCharacter.ignited && global.selectedCharacter.characterStats.team == CharacterTeams.Ally)
		{
			//end turn button
			handDrawButton = 0;
			igniteButton =
			{
				left : igniteX - sixteenthY,
				top : igniteY - sixteenthY,
				right : igniteX + sixteenthY,
				bottom : igniteY + sixteenthY
			}
				
			if (mouseX >= igniteButton.left && mouseX <= igniteButton.right
				&& mouseY >= igniteButton.top && mouseY <= igniteButton.bottom)
			{
				draw_set_color(c_dkgray);
			}
			else draw_set_color(c_black);
				
			draw_circle(igniteX, igniteY, sixteenthY, false);
				
			draw_set_color(c_white);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(fnt_Cambria24);
			draw_text(igniteX, igniteY, "Ignite");
									
		}
		else
		{
			igniteButton = 0;
			handDrawButton =
			{
				left : igniteX - sixteenthY,
				top : igniteY - sixteenthY,
				right : igniteX + sixteenthY,
				bottom : igniteY + sixteenthY
			}
			var deckCount = ds_list_size(global.selectedCharacter.nodes);
			
			var deckRatio = deckCount / 30;
			
			draw_set_color(c_black);
			draw_circle(igniteX, igniteY, sixteenthY, false);
			if (mouseX >= handDrawButton.left && mouseX <= handDrawButton.right
				&& mouseY >= handDrawButton.top && mouseY <= handDrawButton.bottom)
			{
				draw_set_color(c_ltgray);
			}
			else draw_set_color(deckLightColor);
			draw_circle(igniteX, igniteY, sixteenthY * deckRatio, false);
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(fnt_Bold);
			var deckString = string(deckCount);
			draw_text_outline(igniteX, igniteY, deckString, c_black, 1);
			draw_set_color(c_white);
			draw_text(igniteX, igniteY, deckString);
			
			//cards in hand
			handButtons = array_create(0);
			if (handDraw)
			{
				var handSize = ds_list_size(global.selectedCharacter.hand);
				for (var i = 0; i < handSize; i++)
				{
					var card = ds_list_find_value(global.selectedCharacter.hand, i);
				
					//draw slots
					var handX = fullX - eighthY - eighthY - (i * sixteenthY);
					var handY = fullY - sixteenthY;
					if (i % 2 == 1)
					{
						handY = fullY - eighthY - sixteenthY;
					}
					
					var handButton =
					{
						left : handX - sixteenthY,
						top : handY - sixteenthY,
						right : handX + sixteenthY,
						bottom : handY + sixteenthY
					}
					
					array_push(handButtons, handButton)
				
					if (mouseX >= handButton.left && mouseX <= handButton.right
						&& mouseY >= handButton.top && mouseY <= handButton.bottom)
					{
						DrawCard(fullX - quarterX, eighthY, card);
						draw_set_color(c_dkgray);
					}
					else draw_set_color(c_black);
					draw_circle(handX, handY, sixteenthY, false);
				
					if (global.selectedCharacter.characterStats.team == CharacterTeams.Ally)
					{
						var sprite = card.art;
					}
					else
					{
						var sprite = spr_Cancel;
					}
				
					var spriteScale =  eighthY / sprite_get_width(sprite);
					draw_sprite_ext(sprite, 0, handX, handY, spriteScale, spriteScale, image_angle, c_white, 1);
				}
			}
		}
	}
	else igniteButton = 0;
	//draw character selection HUD
	
	if (global.ItemToMove != 0)
	{
		var quantityInsert = " x " + string(global.ItemToMove.quantity);
		if (global.ItemToMove.quantity <= 1) quantityInsert = "";
		DrawPrompt("Moving " + global.FindItem(global.ItemToMove.type, global.ItemToMove.index, global.ItemToMove.quantity).name + quantityInsert + ".  Right click to cancel.");
	}



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
	
		if (mouseX >= buttonStruct.left && mouseX <= buttonStruct.right
		 && mouseY >= buttonStruct.top && mouseY <= buttonStruct.bottom)
		{
			draw_set_color(c_white);
		}
		else
		{
			draw_set_color(c_gray);
		}
	
		draw_circle(posX, posY, allyRadius, false);
		draw_sprite_ext(ally.sprite_index, ally.image_index, posX, posY, ally.characterStats.uiScale, ally.characterStats.uiScale, 
						image_angle, c_white, 1);
	
		if (inventoryDraw == i)
		{
			//draw this character's packs
			var packPosX = 0;
			var packPosY = 0;
			uiPackButtons = array_create(0);
			for (var j = 0; j < array_length(ally.characterStats.equippedPacks); j++)
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
				
				if (mouseX >= packButtonStruct.left && mouseX <= packButtonStruct.right
				 && mouseY >= packButtonStruct.top && mouseY <= packButtonStruct.bottom)
				{
					draw_set_color(c_white);
				}
				else
				{
					draw_set_color(c_gray);
				}
				
				draw_circle(packPosX, packPosY, allyRadius, false);
			
				var currentPack = ally.characterStats.equippedPacks[j]
				var packSprite = currentPack.sprite;
				var packScale = (allyRadius) / sprite_get_width(packSprite);
			
				draw_sprite_ext(packSprite, 0, packPosX - (allyRadius / 2), 
								packPosY - (allyRadius / 2), packScale, packScale, image_angle, 
								c_white, 1);
			
				//display pack contents
				if (packDraw == j)
				{
					global.UiLock = true;
					var contentPosY = quarterY / 2;
				
					uiItemButtons = array_create(0);
			
					for (var l = 0; l < currentPack.height; l++)
					{
						for (var k = 0; k < currentPack.width; k++)
						{
							var itemPosX = (packPosX + allyRadius) + ((division + allyRadius) * k);
							var itemPosY = contentPosY + (division + allyRadius) * l;
							var contentButton = 
							{
								left : itemPosX - allyRadius,
								top : itemPosY - allyRadius,
								right : itemPosX + allyRadius,
								bottom : itemPosY + allyRadius
							}
						
							array_push(uiItemButtons, contentButton);
						
							if (mouseX >= contentButton.left && mouseX <= contentButton.right
								&& mouseY >= contentButton.top && mouseY <= contentButton.bottom)
							{
								draw_set_color(c_white);
							}
							else
							{
								draw_set_color(c_gray);
							}
						
							draw_circle(itemPosX, itemPosY, 
								allyRadius, false);
							
							var itemIndex = l * currentPack.width + k;
							var item = currentPack.contents[itemIndex];
						
							if (item != 0)
							{
								var fetchedItem = global.FindItem(item.type, item.index, item.quantity);
								var itemSprite = fetchedItem.sprite;
								var itemScale = (allyRadius) / sprite_get_width(itemSprite);
			
								draw_sprite_ext(itemSprite, 0, itemPosX - (allyRadius / 2), 
												itemPosY - (allyRadius / 2), itemScale, itemScale, 
												image_angle, c_white, 1);
									
								if (fetchedItem.maxQuantity > 1)
								{
								
								
									draw_set_halign(fa_right);
									draw_set_valign(fa_top);
									draw_set_font(fnt_Cambria24);
								
									draw_text_outline(contentButton.right, contentButton.top, string(fetchedItem.quantity), c_black, 1);
								
									
									draw_set_color(c_white);
									draw_text(contentButton.right, contentButton.top, string(fetchedItem.quantity));
								}
							
							
								
								if (itemDraw == itemIndex)
								{
								//display info panel
								
									//backgorund
									draw_set_color(c_black);
									var infoPanelX = fullX - quarterY;
									var infoPanelY = fullY - quarterY;
									draw_circle(infoPanelX, infoPanelY, quarterY, false);
								
									draw_set_color(c_dkgray);
									draw_line_width(infoPanelX, infoPanelY - quarterY, infoPanelX 
												  + quarterY, infoPanelY, outlineRadius);
									draw_line_width(infoPanelX, infoPanelY + quarterY, infoPanelX 
												  + quarterY, infoPanelY, outlineRadius);
									draw_line_width(infoPanelX - quarterY, infoPanelY, infoPanelX, 
													infoPanelY - quarterY, outlineRadius);
									draw_line_width(infoPanelX - quarterY, infoPanelY, infoPanelX, 
													infoPanelY + quarterY, outlineRadius);
								
									draw_set_color(c_gray);
									draw_circle(infoPanelX, infoPanelY - quarterY, 
												outlineRadius, false);
									draw_circle(infoPanelX + quarterY, infoPanelY, 
												outlineRadius, false);
									draw_circle(infoPanelX, infoPanelY + quarterY, 
												outlineRadius, false);
									draw_circle(infoPanelX - quarterY, infoPanelY, 
												outlineRadius, false);
								
									//item image, name, and description
									draw_circle(infoPanelX, infoPanelY - (quarterY / 2), 
												allyRadius, false);
									draw_sprite_ext(itemSprite, 0, infoPanelX - (allyRadius / 2), infoPanelY 
													- (quarterY / 2) - (allyRadius / 2), 
													itemScale, itemScale, image_angle, c_white, 1);
												
									draw_set_halign(fa_center);
									draw_set_valign(fa_top);
									draw_set_font(fnt_Cambria24);
									draw_text(infoPanelX, infoPanelY - (quarterY / 4), fetchedItem.name);
									draw_set_font(fnt_Cambria16);
									draw_text(infoPanelX, infoPanelY, fetchedItem.description);
								
									if (fetchedItem.maxQuantity > 1) draw_text(infoPanelX, infoPanelY - (division / 2), 
																		string(fetchedItem.quantity) + " / " 
																		+ string(fetchedItem.maxQuantity));
								
								
								
									//draw all item methods (maximum of 6, 2 base)
									uiMethodButtons = array_create(0);
								
									for (var m = 0; (m < ds_list_size(fetchedItem.methods) && m < 6); m++)
									{
										var drawMethod = ds_list_find_value(fetchedItem.methods, m);
									
										var methodX = 0;
										var methodY = 0;
									
										switch (m)
										{
											case 0:
												methodX = infoPanelX - division * 3;
												methodY = infoPanelY - division;
												break;
											case 1:
												methodX = infoPanelX - division * 2;
												methodY = infoPanelY - division * 2;
												break;
											case 2:
												methodX = infoPanelX - division;
												methodY = infoPanelY - division * 3;
												break;
											case 3:
												methodX = infoPanelX + division;
												methodY = infoPanelY - division * 3;
												break;
											case 4:
												methodX = infoPanelX + division * 2;
												methodY = infoPanelY - division * 2;
												break;
											case 5:
												methodX = infoPanelX + division * 3;
												methodY = infoPanelY - division;
												break;
										}
									
										var methodSprite = drawMethod.sprite;
										var methodScale = (allyRadius) / sprite_get_width(methodSprite);
									
										var methodButton = 
										{
											left : methodX - (allyRadius),
											top : methodY - (allyRadius),
											right : methodX + (allyRadius),
											bottom : methodY + (allyRadius)
										}
									
										array_push(uiMethodButtons, methodButton);
									
										if (mouseX >= methodButton.left && mouseX <= methodButton.right
											&& mouseY >= methodButton.top && mouseY <= methodButton.bottom)
										{
											DrawPrompt(drawMethod.description);
											draw_set_color(c_gray);
										}
										else
										{
											draw_set_color(c_dkgray);
										}
									
									
										draw_circle(methodX, methodY, allyRadius, false);
										draw_sprite_ext(methodSprite, 0, methodX - (allyRadius / 2), 
														methodY - (allyRadius / 2), methodScale, methodScale, 
														image_angle, c_white, 1);
													
										if (split != 0)
										{
											//draw split menu for current item
										
											draw_set_color(c_black);
											draw_roundrect(thirdX, halfY - division, fullX - thirdX, halfY + division, false);
											draw_set_color(c_gray);
											draw_line_width(thirdX + division, halfY, fullX - thirdX - division, 
															halfY, outlineRadius)
	;
										
											if (dragX == 0) dragX = halfX;
										
											draw_roundrect(dragX - division / 4, halfY - division / 2, 
															dragX + division / 4, halfY + division / 2, false);
											splitArea =
											{
												left : thirdX + division,
												top : halfY - division,
												right : fullX - thirdX - division,
												bottom : halfY + division
											}
										
											draw_circle(thirdX, halfY, allyRadius, false);
											draw_circle(fullX - thirdX, halfY, allyRadius, false);
										
											var splitSprite = split.sprite;
											var splitScale = (allyRadius) / sprite_get_width(splitSprite);
										
											draw_sprite_ext(splitSprite, 0, thirdX - (allyRadius / 2), 
															halfY - (allyRadius / 2), splitScale, splitScale, 
															image_angle, c_white, 1);
														
											//confirm & cancel buttons
											var confirmX = halfX - thirdX / 4;
											var confirmY = halfY + division;
										
										
										
											confirmSplit =
											{
												left : confirmX - allyRadius,
												top : confirmY - allyRadius,
												right : confirmX + allyRadius,
												bottom : confirmY + allyRadius,
											}
										
											var confirmSprite = spr_Confirm;
											var confirmScale = (allyRadius) / sprite_get_width(confirmSprite);
										
											if (mouseX >= confirmSplit.left && mouseX <= confirmSplit.right
												&& mouseY >= confirmSplit.top && mouseY <= confirmSplit.bottom)
											{
												draw_set_color(c_white);
											}
											else
											{
												draw_set_color(c_gray);
											}
										
											draw_circle(confirmX, confirmY, allyRadius, false);
										
											draw_sprite_ext(confirmSprite, 0, confirmX - (allyRadius / 2), 
															confirmY - (allyRadius / 2), confirmScale, confirmScale, 
															image_angle, c_black, 1);
										
											var cancelX = halfX + thirdX / 4;
										
											cancelSplit =
											{
												left : cancelX - allyRadius,
												top : confirmY - allyRadius,
												right : cancelX + allyRadius,
												bottom : confirmY + allyRadius,
											}
										
											if (mouseX >= cancelSplit.left && mouseX <= cancelSplit.right
												&& mouseY >= cancelSplit.top && mouseY <= cancelSplit.bottom)
											{
												draw_set_color(c_white);
											}
											else
											{
												draw_set_color(c_gray);
											}
										
											draw_circle(cancelX, confirmY, allyRadius, false);
										
										
										
											var cancelSprite = spr_Cancel;
											var cancelScale = (allyRadius) / sprite_get_width(cancelSprite);
										
											draw_sprite_ext(cancelSprite, 0, cancelX - (allyRadius / 2), 
															confirmY - (allyRadius / 2), cancelScale, cancelScale, 
															image_angle, c_black, 1);
														
											//split amount
														
											var splitMax = thirdX - division * 2;
											var splitRatio = (dragX - (thirdX + division)) / (splitMax)
											splitValue = clamp(ceil(fetchedItem.quantity * splitRatio), 1, fetchedItem.quantity);
										
											draw_set_color(c_black);
											draw_set_font(fnt_Cambria24);
											draw_set_halign(fa_center);
											draw_set_valign(fa_top);
										
											draw_text(fullX - thirdX, halfY - 12, string(splitValue));
										
										
										}
									}
								}
							}

					
						}
					}
				}
			}
		
		}
		
		if (global.InCombat)
		{
			//draw turn order
			
			var turnSize = ds_list_size(global.Turns);
			
			//draw backdrop
			var turnX = fullX - allyRadius;

			draw_set_color(c_black);
			draw_roundrect(turnX, eighthY, fullX, eighthY + (allyRadius * 2 * (turnSize - 1)), false);
			
			for (var i = 0; i < turnSize; i++)
			{
				var turnY = eighthY + (allyRadius * 2 * i);
				
				draw_set_color(c_gray);
				draw_circle(turnX, turnY, allyRadius, false);
				
				var turn = ds_list_find_value(global.Turns, i);
				
				draw_sprite_ext(turn.character.sprite_index, turn.character.image_index, turnX, turnY, 
								turn.character.characterStats.uiScale, turn.character.characterStats.uiScale, 
								image_angle, c_white, 1);
			}
			
			//draw AP
			var apScale = thirtySecondY / sprite_get_width(spr_Ap);
			var apY = halfY + sixteenthY;
			draw_sprite_ext(spr_Ap, 0, thirtySecondY, apY, apScale, apScale, 0, c_white, 1);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(fnt_Cambria24)
			draw_set_color(c_white);
			draw_text(sixteenthY, apY, string(global.selectedCharacter.currentAp));
			
			if (global.selectedCharacter.characterStats.team == CharacterTeams.Ally 
			 && global.selectedCharacter == ds_list_find_value(global.Turns, 0).character 
			 && global.selectedCharacter.currentAp > 0)
			{
				//draw AP spenders
				
				var sprintX = thirtySecondY;
				var sprintY = apY + sixteenthY;
				dashButton =
				{
					left : sprintX - thirtySecondY,
					top : sprintY - thirtySecondY,
					right : sprintX + thirtySecondY,
					bottom : sprintY + thirtySecondY,
				}
				if (mouseX >= dashButton.left && mouseX <= dashButton.right
				 && mouseY >= dashButton.top && mouseY <= dashButton.bottom)
				{
					draw_set_color(c_dkgray);
				}
				else
				{
					draw_set_color(c_black);
				}
				draw_circle(sprintX, sprintY, thirtySecondY, false);
				
				var sprintWidth = sprite_get_width(spr_Sprint);
				var sprintScale = thirtySecondY / sprintWidth;
				draw_sprite_ext(spr_Sprint, 0, sprintX, sprintY, sprintScale, sprintScale, 0, c_white, 1);
			}
			else
			{
				dashButton = 0;
			}
			
			if (ds_list_find_value(global.Turns, 0).character.characterStats.team == CharacterTeams.Ally)
			{
				//end turn button
				endTurnButton =
				{
					left : 0,
					top : fullY - quarterY,
					right : quarterY,
					bottom : fullY
				}
				
				
				var endTurnX = 0;
				var endTurnY = fullY;
				
				if (mouseX >= endTurnButton.left && mouseX <= endTurnButton.right
				 && mouseY >= endTurnButton.top && mouseY <= endTurnButton.bottom)
				{
					draw_set_color(c_dkgray);
				}
				else draw_set_color(c_black);
				
				draw_circle(endTurnX, endTurnY, quarterY, false);
				
				draw_set_color(c_white);
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_set_font(fnt_Cambria24);
				draw_text_transformed(eighthY - font_get_size(draw_get_font()), 
									  fullY - eighthY + font_get_size(draw_get_font()), "End Turn", 
									  1, 1, -45);
									  

			}
			else
			{
				endTurnButton = 0;
			}
			
			
		}
	}
}