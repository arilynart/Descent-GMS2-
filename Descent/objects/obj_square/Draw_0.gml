/// @description Draw interactables

draw_self();

if (interaction != 0)
{
	var spriteWidth = sprite_get_width(interaction.sprite);
	var spriteScale = 96 / spriteWidth;
	
	draw_sprite_ext(interaction.sprite, -1, x, y, spriteScale, spriteScale, image_angle, c_white, 1);
}

if (map.blueprint.displaying)
{
	draw_set_color(c_white);
	draw_set_font(fnt_Cambria24);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, y, string(coordinate.x) + ", " + string(coordinate.y));
	
	if (map.blueprint.currentMode == WallModes.Range)
	{
		draw_set_color(c_red);
		var markOffset = 288 / 4;
		var markRadius = 288 / 16;
		if (range.up != 0)
		{
			draw_circle(x, y - markOffset, markRadius, false);
		}
		if (range.right != 0)
		{
			draw_circle(x + markOffset, y, markRadius, false);
		}
		if (range.down != 0)
		{
			draw_circle(x, y + markOffset, markRadius, false);
		}
		if (range.left != 0)
		{
			draw_circle(x - markOffset, y, markRadius, false);
		}
		if (range.upRight != 0)
		{
			draw_circle(x + markOffset, y - markOffset, markRadius, false);
		}
		if (range.downRight != 0)
		{
			draw_circle(x + markOffset, y + markOffset, markRadius, false);
		}
		if (range.downLeft != 0)
		{
			draw_circle(x - markOffset, y + markOffset, markRadius, false);
		}
		if (range.upLeft != 0)
		{
			draw_circle(x - markOffset, y - markOffset, markRadius, false);
		}
	}
	else if (map.blueprint.currentMode == WallModes.Move)
	{
		draw_set_color(c_yellow);
		var markOffset = 288 / 4;
		var markRadius = 288 / 16;
		if (up != 0)
		{
			draw_circle(x, y - markOffset, markRadius, false);
		}
		if (right != 0)
		{
			draw_circle(x + markOffset, y, markRadius, false);
		}
		if (down != 0)
		{
			draw_circle(x, y + markOffset, markRadius, false);
		}
		if (left != 0)
		{
			draw_circle(x - markOffset, y, markRadius, false);
		}
		if (upRight != 0)
		{
			draw_circle(x + markOffset, y - markOffset, markRadius, false);
		}
		if (downRight != 0)
		{
			draw_circle(x + markOffset, y + markOffset, markRadius, false);
		}
		if (downLeft != 0)
		{
			draw_circle(x - markOffset, y + markOffset, markRadius, false);
		}
		if (upLeft != 0)
		{
			draw_circle(x - markOffset, y - markOffset, markRadius, false);
		}
	}
}