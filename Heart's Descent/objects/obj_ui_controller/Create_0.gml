/// @description initialize

global.ui_controller = id;

fnt_menu_bold = font_add("sitka-small.ttf", 18, true, false, 32, 128);

full_x = display_get_gui_width();
full_y = display_get_gui_height();

half_x = full_x / 2;
half_y = full_y / 2;

quarter_x = half_x / 2;
quarter_y = half_y / 2;

eighth_x = quarter_x / 2;
eighth_y = quarter_y / 2;

//sixteenth_x = eighth_x / 2;
sixteenth_y = eighth_y / 2;

//thirtysecond_y = sixteenth_y / 2;

//third_x = ceil(full_x / 3);
//third_y = ceil(full_y / 3);

main_button_radius = eighth_y;

#region colors

c_gui_dark = $322224;
c_gui_light = $7CCCBB;
c_gui_highlight = $452F7F;

#endregion
