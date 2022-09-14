/// @description show status

draw_self();

if (currentArt >= 0)
{
	var artWidth = 432;
	var artScale = artWidth / sprite_get_width(currentArt);
	draw_sprite_ext(currentArt, 0, x, y, artScale, artScale, 0, c_white, alarm_get(0) / artMaxTime);
}

var startX = x - 144;
var lineLength = 288;

if (currentHp < maxHp())
{
	var hpY = y + 144 - 20;
	draw_set_color(c_black);
	draw_line_width(startX, hpY, startX + lineLength, hpY, 20);
	draw_set_color(c_red);
	draw_line_width(startX, hpY, startX + ceil(lineLength * (currentHp / maxHp())), hpY, 20);
}

if (currentSp < maxSp())
{
	
	var spY = y + 144 - 20 - 36;
	draw_set_color(c_black);
	draw_line_width(startX, spY, startX + lineLength, spY, 20);
	draw_set_color(c_aqua);
	draw_line_width(startX, spY, startX + ceil(lineLength * (currentSp / maxSp())), spY, 20);
}