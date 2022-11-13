// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

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
	
	var elementY = spriteY + doubleRadius * 2;
	for (var i = 0; i < array_length(elementSprites); i++)
	{
		var elementX = spriteX - (floor(array_length(elementSprites) / 2) * (allyRadius / 2)) + (i * allyRadius);
		
		
		var elementScale = allyRadius / sprite_get_width(elementSprites[i]);
		draw_sprite_ext(elementSprites[i], 0, elementX, elementY, elementScale, elementScale, 0, c_white, 1);
	}
		
	draw_set_font(fnt_Cambria16);
	var linePad = 20;
	draw_text(spriteX, elementY + allyRadius, "Lvl " + string(characterStats.level));
	
	var leftStatsX = ceil(halfX + sixteenthX * 1.5);
	var rightStatsX = ceil(halfX + eighthX + sixteenthX / 2);
	
	
	var enduranceY = elementY + allyRadius;
	var vitalityY = enduranceY + linePad;
	var forceY = vitalityY + linePad;
	var tempoY = forceY + linePad;
	var generationY = forceY + linePad * 5;
	var generationX = leftStatsX + allyRadius
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
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
	
	for (var i = 0; i < array_length(characterStats.generation); i++)
	{
		var itemData = characterStats.generation[i];
		var fetchedItem = global.FindItem(itemData.type, itemData.index, itemData.quantity);
		
		draw_set_color(c_gray);
		draw_circle(generationX, generationY, allyRadius, false);
		var spriteScale = allyRadius / sprite_get_width(fetchedItem.sprite);
		draw_sprite_ext(fetchedItem.sprite, 0, generationX, generationY, spriteScale, spriteScale, 0, c_white, 1);
		
		if (fetchedItem.maxQuantity > 1)
		{
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(fnt_Cambria16)
			draw_text_outline(generationX + allyRadius / 2, generationY - allyRadius / 2, string(itemData.quantity), c_black, 1);
			
			draw_set_color(c_white);
			draw_text(generationX + allyRadius / 2, generationY - allyRadius / 2, string(itemData.quantity));
		}
		generationX += allyRadius * 2.5;
	}
	
}