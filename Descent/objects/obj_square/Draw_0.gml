/// @description Draw interactables

draw_self();

if (interaction != 0)
{
	var spriteWidth = sprite_get_width(interaction.sprite);
	var spriteHeight = sprite_get_height(interaction.sprite);
	var spriteScale = 96 / spriteWidth;
	
	draw_sprite_ext(interaction.sprite, -1, x - (spriteWidth * spriteScale) / 2, 
					y - (spriteHeight * spriteScale) / 2, spriteScale, spriteScale, 
					image_angle, c_white, 1);
}