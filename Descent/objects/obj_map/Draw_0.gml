/// @description Draw HP Bars


with (obj_Character)
{
	if (currentHp < maxHp() || currentSp < maxSp())
	{
		if (!surface_exists(global.BarSurface))
		{
			global.BarSurface = surface_create(room_width, room_height);
		}
		
		if (surface_exists(global.BarSurface))
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