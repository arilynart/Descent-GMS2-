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
}