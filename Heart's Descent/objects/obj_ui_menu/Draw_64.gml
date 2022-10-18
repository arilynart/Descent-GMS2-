/// @description draw menu ui

#region frame reset

gui_mouse_x = device_mouse_x_to_gui(0);
gui_mouse_y = device_mouse_y_to_gui(0);

solo_button = 0;
host_button = 0;
join_button = 0;

draw_set_circle_precision(4);

#endregion

if (!global.network_manager.connected)
{
	#region solo button

	var solo_x = quarter_x;
	var solo_y = half_y;

	solo_button = create_button(solo_x - main_button_radius, solo_y - main_button_radius, 
								solo_x + main_button_radius, solo_y + main_button_radius);

	if (check_button(solo_button)) draw_set_color(c_gui_highlight);
	else draw_set_color(c_gui_dark);

	draw_circle(solo_x, solo_y, main_button_radius, false);

	draw_set_font(fnt_menu_bold);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_gui_light);
	draw_text(solo_x, solo_y, "SOLO");

	#endregion

	var multi_x = half_x + quarter_x;

	#region host

	var host_y = half_y - quarter_y;

	host_button = create_button(multi_x - main_button_radius, host_y - main_button_radius, 
								multi_x + main_button_radius, host_y + main_button_radius);

	if (check_button(host_button)) draw_set_color(c_gui_highlight);
	else draw_set_color(c_gui_dark);

	draw_circle(multi_x, host_y, main_button_radius, false);

	draw_set_font(fnt_menu_bold);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_gui_light);
	draw_text(multi_x, host_y, "HOST");

	#endregion

	#region join

	var join_y = half_y + quarter_y;

	join_button = create_button(multi_x - main_button_radius, join_y - main_button_radius, 
								multi_x + main_button_radius, join_y + main_button_radius);

	if (check_button(join_button)) draw_set_color(c_gui_highlight);
	else draw_set_color(c_gui_dark);

	draw_circle(multi_x, join_y, main_button_radius, false);

	draw_set_font(fnt_menu_bold);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_gui_light);
	draw_text(multi_x, join_y, "JOIN");

	#endregion

}
else
{
	var network_status_x = half_x + quarter_x + eighth_x;
	var network_status_y = sixteenth_y;
	
	draw_set_font(fnt_menu_bold);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_gui_highlight);
	draw_text(network_status_x, network_status_y, "Players connected: " + string(ds_list_size(global.network_manager.player_sockets)));
}
