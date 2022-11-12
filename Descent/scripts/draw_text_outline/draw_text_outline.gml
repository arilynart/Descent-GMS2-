// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_text_outline(x, y, string, color, size)
{
	var previousColor = draw_get_color();
	
	draw_set_color(color);
	draw_text(x - size, y, string);
	draw_text(x + size, y, string);
	draw_text(x, y - size, string);
	draw_text(x, y + size, string);
	draw_text(x + size, y + size, string);
	draw_text(x - size, y + size, string);
	draw_text(x - size, y - size, string);
	draw_text(x + size, y - size, string);
	
	draw_set_color(previousColor);
}