/// @description Draw UI elements.
//depth = 110000;

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
			
				draw_sprite_ext(packSprite, 0, packPosX, 
								packPosY, packScale, packScale, image_angle, 
								c_white, 1);
			
				//display pack contents
				if (packDraw == j)
				{
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
			
								draw_sprite_ext(itemSprite, 0, itemPosX, 
												itemPosY, itemScale, itemScale, 
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
									draw_sprite_ext(itemSprite, 0, infoPanelX, infoPanelY 
													- (quarterY / 2), 
													itemScale, itemScale, image_angle, c_white, 1);
												
									draw_set_halign(fa_center);
									draw_set_valign(fa_top);
									draw_set_font(fnt_Cambria24);
									draw_text(infoPanelX, infoPanelY - (quarterY / 4), fetchedItem.name);
									draw_set_font(fnt_Cambria16);
									var wrappedDesc = global.TextWrap(fetchedItem.description, ceil((halfY / 3) * 1.9));
									draw_text(infoPanelX, infoPanelY, wrappedDesc.text);
								
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
			var turnY = sixteenthY;

			draw_set_color(c_black);
			draw_rectangle(halfX, -1, halfX + (allyRadius * 2 * (turnSize - 1)), turnY, false);
			
			for (var i = 0; i < turnSize; i++)
			{
				var turnX = halfX + (allyRadius * 2 * i);
				
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
				
				if (global.selectedCharacter.characterStats.equippedWeapon != 0)
				{
					var loadX = sixteenthY + thirtySecondY;
					var loadY = apY + sixteenthY;
					loadButton =
					{
						left : loadX - thirtySecondY,
						top : loadY - thirtySecondY,
						right : loadX + thirtySecondY,
						bottom : loadY + thirtySecondY,
					}

					if (mouseX >= loadButton.left && mouseX <= loadButton.right
					 && mouseY >= loadButton.top && mouseY <= loadButton.bottom)
					{
						var sprite = spr_Reload;
						draw_set_color(c_dkgray);
					}
					else
					{
						var sprite = global.FindItem(global.selectedCharacter.characterStats.equippedWeapon.type, global.selectedCharacter.characterStats.equippedWeapon.index, 1).sprite;
						draw_set_color(c_black);
					}
					draw_circle(loadX, loadY, thirtySecondY, false);
					
					var loadWidth = sprite_get_width(sprite);
					var loadScale = thirtySecondY / loadWidth;
					draw_sprite_ext(sprite, 0, loadX, loadY, loadScale, loadScale, 0, c_white, 1);
					lusiumButtons = array_create(0);
					cancelLoadButton = 0;
					confirmLoadButton = 0;
					if (prepLoad)
					{
						draw_set_color(c_black);
						draw_circle(halfX, halfY, quarterY, false)
						
						draw_set_halign(fa_center);
						draw_set_valign(fa_middle);
						draw_set_font(fnt_Cambria16)
						draw_set_color(c_white);
						draw_text(halfX, halfY - eighthY, "Choose up to " + string(global.FindItem(global.selectedCharacter.characterStats.equippedWeapon.type, global.selectedCharacter.characterStats.equippedWeapon.index, 1).lusiumPerAp) + " to load.");
						
						for (var i = 0; i < 4; i++)
						{
							var item = global.FindItem(ItemTypes.Lusium, i, 0);
							var foundQuantity = 0;
							var	lusiumX = halfX - eighthY - sixteenthY + (i * eighthY);
							var lusiumY = halfY + allyRadius;
														
							var newButton =
							{
								left : lusiumX - allyRadius,
								top : lusiumY - allyRadius,
								right : lusiumX + allyRadius,
								bottom : lusiumY + allyRadius,
							}
							array_push(lusiumButtons, newButton);
							if (mouseX >= newButton.left && mouseX <= newButton.right
							 && mouseY >= newButton.top && mouseY <= newButton.bottom
							 && global.selectedCharacter.loadedQuantity() < global.FindItem(ItemTypes.Weapon, global.selectedCharacter.characterStats.equippedWeapon.index, 0).lusiumPerAp)
							{
								draw_set_color(c_ltgray);
							}
							else
							{
								draw_set_color(c_gray);
							}
							draw_circle(lusiumX, lusiumY, allyRadius, false);
							var lusiumScale = allyRadius / sprite_get_width(item.sprite);
							draw_sprite_ext(item.sprite, 0, lusiumX, lusiumY, lusiumScale, lusiumScale, 0, c_white, 1);
							for (var j = 0; j < array_length(global.selectedCharacter.characterStats.equippedPacks); j++)
							{
								var pack = global.selectedCharacter.characterStats.equippedPacks[j];
								if (pack != 0 && pack.tier <= tierToLoadFrom)
								{
									for (var k = 0; k < array_length(pack.contents); k++)
									{
										var checkItem = pack.contents[k];
										if (checkItem != 0 && checkItem.type == ItemTypes.Lusium && checkItem.index == i)
										{
											foundQuantity += checkItem.quantity;
										}
									}
								}
							}

							
							draw_text_outline(lusiumX + (allyRadius / 2), lusiumY - (allyRadius / 2), string(foundQuantity), c_black, 1);
							draw_set_color(c_white);
							draw_text(lusiumX + (allyRadius / 2), lusiumY - (allyRadius / 2), string(foundQuantity));
						}
						for (var i = 0; i < 4; i++)
						{
							var item = global.FindItem(ItemTypes.Lusium, i, 0);
							var foundQuantity = 0;
							var	lusiumX = halfX - eighthY - sixteenthY + (i * eighthY);
							var lusiumY = halfY - allyRadius;
							
							var lusiumScale = allyRadius / sprite_get_width(item.sprite);
							
							for (var k = 0; k < array_length(global.selectedCharacter.itemsToLoad); k++)
							{
								var checkItem = global.selectedCharacter.itemsToLoad[k];
								if (checkItem != 0 && checkItem.type == ItemTypes.Lusium && checkItem.index == i)
								{
									draw_set_color(c_gray);							
									draw_circle(lusiumX, lusiumY, allyRadius, false);
									draw_sprite_ext(item.sprite, 0, lusiumX, lusiumY, lusiumScale, lusiumScale, 0, c_white, 1);
									draw_text_outline(lusiumX + (allyRadius / 2), lusiumY - (allyRadius / 2), string(checkItem.quantity), c_black, 1);
									draw_set_color(c_white);
									draw_text(lusiumX + (allyRadius / 2), lusiumY - (allyRadius / 2), string(checkItem.quantity));
								}
							}
						}
						
						//confirm
						var confirmX = halfX;
						var confirmY = halfY + eighthY;
						
						confirmLoadButton = 
						{
							left : confirmX - allyRadius,
							top : confirmY - allyRadius,
							right : confirmX + allyRadius,
							bottom : confirmY + allyRadius,
						}
						
						if (mouseX >= confirmLoadButton.left && mouseX <= confirmLoadButton.right
						 && mouseY >= confirmLoadButton.top && mouseY <= confirmLoadButton.bottom
						 && global.selectedCharacter.loadedQuantity() > 0)
						{
							draw_set_color(c_lime);
						}
						else draw_set_color(c_green);
						draw_circle(confirmX, confirmY, allyRadius, false);
						
						var confirmScale = allyRadius / sprite_get_width(spr_Confirm);
						draw_sprite_ext(spr_Confirm, 0, confirmX - (allyRadius / 2), confirmY - (allyRadius / 2), confirmScale, confirmScale, 0, c_black, 1);
						
						//cancel
						var cancelX = halfX;
						var cancelY = confirmY + allyRadius * 2;
						
						cancelLoadButton = 
						{
							left : cancelX - allyRadius,
							top : cancelY - allyRadius,
							right : cancelX + allyRadius,
							bottom : cancelY + allyRadius,
						}
						
						if (mouseX >= cancelLoadButton.left && mouseX <= cancelLoadButton.right
						 && mouseY >= cancelLoadButton.top && mouseY <= cancelLoadButton.bottom
						 && global.selectedCharacter.loadedQuantity() > 0)
						{
							draw_set_color(c_red);
						}
						else draw_set_color(c_maroon);
						draw_circle(cancelX, cancelY, allyRadius, false);
						
						var cancelScale = allyRadius / sprite_get_width(spr_Cancel);
						draw_sprite_ext(spr_Cancel, 0, cancelX - (allyRadius / 2), cancelY - (allyRadius / 2), cancelScale, cancelScale, 0, c_black, 1);
					}
				}
			}
			else
			{
				dashButton = 0;
				loadButton = 0;
				
				prepLoad = false;
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
			
			//draw card stuff
			if (global.selectedCharacter != 0 && array_length(global.selectedCharacter.characterStats.nodeDeck) > 0)
			{
				loadedButtons = array_create(0);
				for (var i = 0; i < 4; i++)
				{
					var loadedX = fullX - allyRadius
					var loadedY = halfY - (allyRadius * 3) + (i * (allyRadius * 2));
					
					var newButton =
					{
						left : loadedX - allyRadius,
						top : loadedY - allyRadius,
						right : loadedX + allyRadius,
						bottom : loadedY + allyRadius
					}
					
					if (dragCard >= 0 
					 && mouseX > newButton.left && mouseX < newButton.right
					 && mouseY > newButton.top && mouseY < newButton.bottom)
					{
						 draw_set_color(c_ltgray)
					}
					else draw_set_color(c_gray);
					
					array_push(loadedButtons, newButton);
					
					draw_circle(loadedX, loadedY, allyRadius, false);
					
					var q = 0;
					for (var j = 0; j < ds_list_size(global.selectedCharacter.loadedLusium); j++)
					{
						var item = ds_list_find_value(global.selectedCharacter.loadedLusium, j);
						if (item != 0 && item.index == i && item.type == ItemTypes.Lusium)
						{
							q += item.quantity;
						}
					}
					
					if (q > 0)
					{
						var alpha = 1;
						var color = c_white;
					}
					else
					{
						var alpha = 0.5;
						var color = c_gray;
					}
					
					var sprite = global.FindItem(ItemTypes.Lusium, i, 0).sprite;
					var spriteScale = allyRadius / sprite_get_width(sprite);
					
					draw_sprite_ext(sprite, 0, loadedX, loadedY, spriteScale, spriteScale, 0, color, alpha);
					
					var loadedQX = loadedX + (allyRadius / 2);
					var loadedQY = loadedY - (allyRadius / 2);
					
					draw_set_halign(fa_center);
					draw_set_valign(fa_middle);
					draw_text_outline(loadedQX, loadedQY, string(q), c_black, 1);
					draw_set_color(c_white);
					draw_text(loadedQX, loadedQY, string(q));
				}
				
				//pools
				var sortedPools = global.SortPools(global.selectedCharacter);
				var poolLength = array_length(sortedPools);
				ds_list_clear(manaButtons);
				ds_list_clear(revertManaButtons);
				confirmManaButton = 0;
				cancelManaButton = 0;
				if (poolLength > 0)
				{
					for (var i = 0; i < poolLength; i++)
					{
						var poolX = fullX - allyRadius * 3;
						var poolY = halfY + ((allyRadius * 2) * i);
						var pool = sortedPools[i];
						
						if (spendMana)
						{
							var promptString = "Pay";
							var card = ds_list_find_value(global.selectedCharacter.hand, heldCard);
							
							repeat(card.vCost)
							{
								promptString += "|spr_V|";
							}
							
							DrawPrompt(promptString);
							
							var button =
							{
								left : poolX - allyRadius,
								top : poolY - allyRadius,
								right : poolX + allyRadius,
								bottom : poolY + allyRadius,
								element : pool.element
							}
							ds_list_add(manaButtons, button);
							if (mouseX >= button.left && mouseX <= button.right
							 && mouseY >= button.top && mouseY <= button.bottom)
							{
								draw_set_color(c_dkgray);
								draw_circle(poolX, poolY, allyRadius, false);
							}
						}
						
						var poolScale = allyRadius / sprite_get_width(pool.sprite);
						draw_sprite_ext(pool.sprite, 0, poolX, poolY, poolScale, poolScale, 0, c_white, 1);
						draw_set_halign(fa_middle);
						draw_set_valign(fa_center);
						var poolString = string(pool.amount);
						draw_text_outline(poolX, poolY, poolString, c_black, 1);
						draw_set_color(c_white);
						draw_text(poolX, poolY, poolString);
						
					}
				}
				if (spendMana)
				{
					//spendPools
					var sortedPools = global.SortSpendPools();
					var poolLength = array_length(sortedPools);
					if (poolLength > 0)
					{
						for (var i = 0; i < poolLength; i++)
						{
							var poolX = fullX - allyRadius * 5;
							var poolY = halfY + ((allyRadius * 2) * i);
							var pool = sortedPools[i];
							
							var button =
							{
								left : poolX - allyRadius,
								top : poolY - allyRadius,
								right : poolX + allyRadius,
								bottom : poolY + allyRadius,
								element : pool.element
							}
							ds_list_add(revertManaButtons, button)
							if (mouseX >= button.left && mouseX <= button.right
								&& mouseY >= button.top && mouseY <= button.bottom)
							{
								draw_set_color(c_dkgray);
								draw_circle(poolX, poolY, allyRadius, false);
							}
							
							var poolScale = allyRadius / sprite_get_width(pool.sprite);
							draw_sprite_ext(pool.sprite, 0, poolX, poolY, poolScale, poolScale, 0, c_white, 1);
							draw_set_halign(fa_middle);
							draw_set_valign(fa_center);
							var poolString = string(pool.amount);
							draw_text_outline(poolX, poolY, poolString, c_black, 1);
							draw_set_color(c_white);
							draw_text(poolX, poolY, poolString);
						
						}
					}
					
					var confirmPoolX = fullX - allyRadius * 7;
					var confirmPoolY = halfY;
					if (global.CheckSpendPoolForRequirements(ds_list_find_value(global.selectedCharacter.hand, heldCard)))
					{
						confirmManaButton =
						{
							left : confirmPoolX - allyRadius,
							top : confirmPoolY - allyRadius,
							right : confirmPoolX + allyRadius,
							bottom : confirmPoolY + allyRadius
						}
						
						if (mouseX >= confirmManaButton.left && mouseX <= confirmManaButton.right
						 && mouseY >= confirmManaButton.top && mouseY <= confirmManaButton.bottom)
						{
							draw_set_color(c_ltgray);
						}
						else draw_set_color(c_lime);
					}
					else draw_set_color(c_green);
					draw_circle(confirmPoolX, confirmPoolY, allyRadius, false)
					var confirmPoolScale = allyRadius / sprite_get_width(spr_Confirm);
					draw_sprite_ext(spr_Confirm, 0, confirmPoolX - (allyRadius / 2), confirmPoolY - (allyRadius / 2), confirmPoolScale, confirmPoolScale, 0, c_black, 1);
					
					var cancelPoolX = fullX - allyRadius * 7;
					var cancelPoolY = halfY + allyRadius * 2;
					cancelManaButton =
					{
						left : cancelPoolX - allyRadius,
						top : cancelPoolY - allyRadius,
						right : cancelPoolX + allyRadius,
						bottom : cancelPoolY + allyRadius
					}
						
					if (mouseX >= cancelManaButton.left && mouseX <= cancelManaButton.right
						&& mouseY >= cancelManaButton.top && mouseY <= cancelManaButton.bottom)
					{
						draw_set_color(c_ltgray);
					}
					else draw_set_color(c_red);
					draw_circle(cancelPoolX, cancelPoolY, allyRadius, false);
					var cancelPoolScale = allyRadius / sprite_get_width(spr_Cancel);
					draw_sprite_ext(spr_Cancel, 0, cancelPoolX - (allyRadius / 2), cancelPoolY - (allyRadius / 2), cancelPoolScale, cancelPoolScale, 0, c_black, 1);
					
				}

				var igniteX = fullX - sixteenthY;
				var igniteY = fullY - sixteenthY;
				igniteButton = 0;
				handDrawButton = 0;
				extraDrawButton = 0;
				if (!global.selectedCharacter.ignited && global.selectedCharacter.characterStats.team == CharacterTeams.Ally)
				{
					//end turn button
					
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
						draw_set_color(c_gray);
					}
					else if (dragCard < 0) draw_set_color(deckLightColor);
					else
					{
						deckRatio = 7 / 8;
						draw_set_color(c_purple);
					}
					draw_circle(igniteX, igniteY, ceil(sixteenthY * deckRatio), false);
			
					draw_set_halign(fa_center);
					draw_set_valign(fa_middle);
					draw_set_font(fnt_Bold);
					if (dragCard < 0) var deckString = string(deckCount);
					else var deckString = "Supply";
					draw_text_outline(igniteX, igniteY, deckString, c_black, 1);
					draw_set_color(c_white);
					draw_text(igniteX, igniteY, deckString);

					//cards in hand
					handButtons = array_create(0);
					if (handDraw)
					{
						var burntSize = ds_list_size(global.selectedCharacter.burntLusium);
						var burntY = fullY - (allyRadius * 2) - eighthY - sixteenthY;
						var burntX = fullX - quarterY;
						for (var i = 0; i < burntSize; i++)
						{
							var lusium = ds_list_find_value(global.selectedCharacter.burntLusium, i);
							
							if (i > 0) burntX -= eighthY;
							
							
							for (var j = 0; j < lusium.capacity; j++)
							{
								burntX -= (allyRadius * 2 * j);
								
								var newButton =
								{
									left : burntX - allyRadius,
									top : burntY - allyRadius,
									right : burntX + allyRadius,
									bottom : burntY + allyRadius
								}
					
								ds_list_add(lusium.slotButtons, newButton);
								draw_set_color(c_black);
								draw_circle(burntX, burntY, allyRadius, false);
								if (mouseX >= newButton.left && mouseX <= newButton.right
								 && mouseY >= newButton.top && mouseY <= newButton.bottom)
								{
									
									draw_set_color(c_gray);
								}
								else draw_set_color(c_dkgray);
								draw_line_width(burntX, burntY - allyRadius, burntX + allyRadius, burntY, outlineRadius);
								draw_line_width(burntX, burntY + allyRadius, burntX + allyRadius, burntY, outlineRadius);
								draw_line_width(burntX, burntY - allyRadius, burntX - allyRadius, burntY, outlineRadius);
								draw_line_width(burntX, burntY + allyRadius, burntX - allyRadius, burntY, outlineRadius);
								draw_circle(burntX, burntY - allyRadius, outlineRadius, false);
								draw_circle(burntX, burntY + allyRadius, outlineRadius, false);
								draw_circle(burntX - allyRadius, burntY, outlineRadius, false);
								draw_circle(burntX + allyRadius, burntY, outlineRadius, false);
								
								if (j < ds_list_size(lusium.heldCards))
								{
									var card = ds_list_find_value(lusium.heldCards, j);
									var spriteScale =  eighthY / sprite_get_width(card.art);
									draw_sprite_ext(card.art, 0, burntX, burntY, spriteScale, spriteScale, 0, c_white, 1);
									if (mouseX >= newButton.left && mouseX <= newButton.right
									 && mouseY >= newButton.top && mouseY <= newButton.bottom)
									{
										DrawCard(fullX - quarterX, eighthY, card);
									}
								}
							}
						}
						
						var handSize = ds_list_size(global.selectedCharacter.hand);
						for (var i = 0; i < handSize; i++)
						{
							var card = ds_list_find_value(global.selectedCharacter.hand, i);
							var handX = fullX - quarterY - (i * allyRadius);
							var handY = fullY - sixteenthY;
							if (i % 2 == 1)
							{
								handY = fullY - (allyRadius * 2) - sixteenthY;
							}
							//draw slots
							if (dragCard != i)
							{
								var artX = handX;
								var artY = handY;
								
								var handButton =
								{
									left : handX - allyRadius,
									top : handY - allyRadius,
									right : handX + allyRadius,
									bottom : handY + allyRadius
								}
					
								array_push(handButtons, handButton)
				
								if (mouseX >= handButton.left && mouseX <= handButton.right
								 && mouseY >= handButton.top && mouseY <= handButton.bottom)
								{
									DrawCard(fullX - quarterX, eighthY, card);
									draw_set_color(c_dkgray);
								}
								else draw_set_color(c_black);
							}
							else
							{
								var artX = mouseX;
								var artY = mouseY;
								DrawCard(fullX - quarterX, eighthY, card);
								draw_set_color(c_black);
							}
							
							draw_circle(handX, handY, allyRadius, false);
							
							if (global.CheckAvailableMana(global.selectedCharacter, card)) draw_set_color(deckLightColor);	
							else draw_set_color(c_dkgray);
							
							draw_line_width(handX, handY - allyRadius, handX + allyRadius, handY, outlineRadius);
							draw_line_width(handX, handY + allyRadius, handX + allyRadius, handY, outlineRadius);
							draw_line_width(handX, handY - allyRadius, handX - allyRadius, handY, outlineRadius);
							draw_line_width(handX, handY + allyRadius, handX - allyRadius, handY, outlineRadius);
							draw_circle(handX, handY - allyRadius, outlineRadius, false);
							draw_circle(handX, handY + allyRadius, outlineRadius, false);
							draw_circle(handX - allyRadius, handY, outlineRadius, false);
							draw_circle(handX + allyRadius, handY, outlineRadius, false);
				
							if (global.selectedCharacter.characterStats.team == CharacterTeams.Ally)
							{
								var sprite = card.art;
							}
							else
							{
								var sprite = spr_Cancel;
							}
				
							var spriteScale =  eighthY / sprite_get_width(sprite);
							draw_sprite_ext(sprite, 0, artX, artY, spriteScale, spriteScale, 0, c_white, 1);
						}
						
					}
					
					//extra deck
					if (global.selectedCharacter.characterStats.team == CharacterTeams.Ally 
					 && ds_list_size(global.selectedCharacter.extra) > 0)
					{
						var extraX = igniteX - sixteenthY;
						var extraY = igniteY - eighthY;
						extraDrawButton =
						{
							left : extraX - sixteenthY,
							top : extraY - sixteenthY,
							right : extraX + sixteenthY,
							bottom : extraY + sixteenthY
						}
						draw_set_color(c_black);
						draw_circle(extraX, extraY, sixteenthY, false);
					
						if (mouseX >= extraDrawButton.left && mouseX <= extraDrawButton.right
							&& mouseY >= extraDrawButton.top && mouseY <= extraDrawButton.bottom)
						{
							draw_set_color(c_gray);
						}
						else draw_set_color(deckLightColor);
						draw_circle(extraX, extraY, ceil(sixteenthY * (7 / 8)), false);
					
						var extraScale = sixteenthY / sprite_get_width(spr_Extra);
						draw_sprite_ext(spr_Extra, 0, extraX, extraY, extraScale, extraScale, 0, c_black, 1);
					
						if (extraDraw)
						{
							var extraCount = ds_list_size(global.selectedCharacter.extra);
							var extraDrawX = halfX;
							var extraDrawY = halfY;
						
							for (var i = 0; i < extraCount; i++)
							{
								var card = ds_list_find_value(global.selectedCharacter.extra, i);
								var handX = ceil(extraDrawX - ((extraCount / 2)* eighthY) + (eighthY * i));
								var handY = extraDrawY
								//draw slots
								var artX = handX;
								var artY = handY;
								
								var handButton =
								{
									left : handX - allyRadius,
									top : handY - allyRadius,
									right : handX + allyRadius,
									bottom : handY + allyRadius
								}
					
								//array_push(handButtons, handButton)
								var usable = false;
								
								if (global.CheckForViableLusium(global.selectedCharacter, card)) usable = true;
								draw_set_color(c_black);
								if (mouseX >= handButton.left && mouseX <= handButton.right
								 && mouseY >= handButton.top && mouseY <= handButton.bottom)
								{
									DrawCard(fullX - quarterX, eighthY, card);
									if (usable) draw_set_color(c_dkgray);
									else draw_set_color(c_black);
								}
								
								
								draw_circle(handX, handY, allyRadius, false);
								
								if (usable) var alpha = 1;
								else var alpha = 0.5;
				
								var spriteScale =  eighthY / sprite_get_width(card.art);
								draw_sprite_ext(card.art, 0, artX, artY, spriteScale, spriteScale, 0, c_white, alpha);
							}
						}
					}
					
				}
			}
			else igniteButton = 0;
		}
	}
}