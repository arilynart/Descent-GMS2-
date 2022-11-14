// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DrawEnemyStatCard(x, y, character)
{
	var cardHeight = ceil(global.UiManager.halfY * (7 / 8));
	var cardWidth = ceil((cardHeight / 3) * 2);
	
	var fullX = x + cardWidth;
	
	var halfX = ceil(x + cardWidth / 2);
	var halfY = ceil(y + cardHeight / 2);

	
	//var quarterY = y + cardHeight / 4;
	
	//var eighthX = ceil(x + cardWidth / 8);
	var eighthY = ceil(y + cardHeight / 8);
	
	var sixteenthX = ceil(x + cardWidth / 16);
	//var sixteenthY = ceil(y + cardHeight / 16);

	var thirtySecondY = ceil(y + cardHeight / 32);
	
	//var thirdX = ceil(x + cardWidth / 3);
	var thirdY = ceil(y + cardHeight / 3);
	
	//var sixthX = ceil(x + cardWidth / 6);
	
	var frameScale = cardHeight / sprite_get_height(spr_StatBgF);
	draw_sprite_ext(spr_StatBgF, 0, x, y, frameScale, frameScale, 0, c_black, 1);
	
	//art
	var artScale = ((cardWidth / 3) * 2) / sprite_get_width(character.sprite_index);
	draw_sprite_ext(character.sprite_index, character.image_index, halfX, thirdY, artScale, artScale, 0, c_white, 1);
	
	//name
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(global.UiManager.fnt_Bold);
	draw_set_color(c_white);
	draw_text(halfX, eighthY, character.characterStats.name);
	
	var fontSize = font_get_size(draw_get_font());
	
	//type
	draw_set_halign(fa_left);
	draw_set_font(fnt_CardText);
	draw_text(sixteenthX, halfY + fontSize, character.characterStats.innateType);
	
	draw_line(sixteenthX, halfY + 10 + fontSize, x + cardWidth - cardWidth / 16, halfY + 10 + fontSize);
	
	//text
	draw_set_valign(fa_top);
	draw_set_font(fnt_CardText);
	draw_wrapped_text(character.characterStats.innateDescription, cardWidth - (cardWidth / 16) * 3, sixteenthX + (cardWidth / 32), halfY + 15 + fontSize, 6, 1.4);
	
	//stats
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fnt_CardText);
	
	var spString = "  SP - " + string(character.currentSp) + " / " + string(character.maxSp());
	var hpString = string(character.currentHp) + " / " + string(character.maxHp()) + " - HP  ";
	
	draw_text(x, thirtySecondY, spString);
	
	draw_set_halign(fa_right);
	draw_text(fullX, thirtySecondY, hpString);
	
	//threat
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fnt_CardText);
	
	draw_set_color(c_white);
	var threatString = "  TARGETING: ";
	draw_text_outline(fullX, thirtySecondY, threatString, c_black, 1);
	draw_text(fullX, thirtySecondY, threatString);
	
	var threatSprite = character.threatTarget.sprite_index;
	var threatSpriteWidth = sprite_get_width(threatSprite) * character.characterStats.uiScale;
	var threatSpriteHeight = sprite_get_height(threatSprite) * character.characterStats.uiScale;
	
	draw_sprite_ext(threatSprite, character.threatTarget.image_index,
					fullX + (threatSpriteWidth / 2), thirtySecondY + (threatSpriteHeight),
					character.characterStats.uiScale, character.characterStats.uiScale, 0, c_white, 1);
}