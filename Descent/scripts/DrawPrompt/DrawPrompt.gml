// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function DrawPrompt(text)
{
	if (text != "")
	{
		var topY = fullY - quarterY / 2;
		var bottomY = fullY - (quarterY / 4)
		draw_set_color(c_black);
		draw_roundrect(quarterX, topY, fullX - quarterX, bottomY, false);

		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fnt_Cambria24);
		draw_wrapped_text(text, halfX, halfX, topY + (quarterY / 8), 4, 1);
	}
}