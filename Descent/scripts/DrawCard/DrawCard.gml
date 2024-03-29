// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
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
	draw_set_valign(fa_middle);
	draw_set_font(fnt_CardText);
	draw_text_transformed(sixteenthX, halfY + fontSize, card.typeText, card.typeFontScale, card.typeFontScale, 0);
	
	draw_line(sixteenthX, halfY + 10 + fontSize, x + cardWidth - cardWidth / 16, halfY + 10 + fontSize)
	
	//text
	draw_set_valign(fa_top);
	draw_set_font(card.textFont);
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