/// @description show status

draw_self();

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