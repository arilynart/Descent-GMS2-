/// @description show status

draw_self();

if (currentArt != -1)
{
	var artWidth = 432;
	var artScale = artWidth / sprite_get_width(currentArt);
	
	var alpha = 0;
	if (alarm_get(0) > 0) alpha = 1;
	else if (alarm_get(1) > 0) alpha = 1 - (alarm_get(1) / artInTime);
	else if (alarm_get(2) > 0) alpha = alarm_get(2) / artMaxTime;
	draw_sprite_ext(currentArt, 0, x, y, artScale, artScale, 0, c_white, alpha);
}