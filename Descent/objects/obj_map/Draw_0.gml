/// @description Draw floating shit

if (!surface_exists(global.BarSurface))
{
	global.BarSurface = surface_create(room_width, room_height);
}
if (surface_exists(global.BarSurface))
{
	with (obj_Character)
	{
		if (currentArt != -1)
		{
			var artWidth = 432;
			var artScale = artWidth / sprite_get_width(currentArt);
	
			var alpha = 0;
			if (alarm_get(0) > 0) alpha = 1;
			else if (alarm_get(1) > 0) alpha = 1 - (alarm_get(1) / artInTime);
			else if (alarm_get(2) > 0) alpha = alarm_get(2) / artMaxTime;
			
			draw_set_alpha(alpha - 0.5);
			draw_set_color(#080008);
			draw_rectangle(0, 0, room_width, room_height, false);	
			draw_set_alpha(1);
			draw_sprite_ext(currentArt, 0, x, y, artScale, artScale, 0, c_white, alpha);
		}
	
		if (currentHp < maxHp() || currentSp < maxSp())
		{
			var lineLength = 268;
			var startX = x - lineLength / 2;
			
			surface_set_target(global.BarSurface);
	
			var spY = y + 144 - 20 - 36;
			draw_set_color(c_black);
			draw_line_width(startX, spY, startX + lineLength, spY, 20);
			draw_set_color(c_aqua);
			draw_line_width(startX, spY, startX + ceil(lineLength * (currentSp / maxSp())), spY, 20);
	
			var hpY = y + 144 - 20;
			draw_set_color(c_black);
			draw_line_width(startX, hpY, startX + lineLength, hpY, 20);
			draw_set_color(c_red);
			draw_line_width(startX, hpY, startX + ceil(lineLength * (currentHp / maxHp())), hpY, 20);
	
			surface_reset_target();
		}
	}
}