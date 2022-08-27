/// @description Draw interactables

draw_self();

if (interaction != 0)
{
	var spriteWidth = sprite_get_width(interaction.sprite);
	var spriteScale = 96 / spriteWidth;
	
	draw_sprite_ext(interaction.sprite, -1, x, y, spriteScale, spriteScale, image_angle, c_white, 1);
}