// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function check_button(button)
{
	var _mouse_x = global.ui_controller.gui_mouse_x;
	var _mouse_y = global.ui_controller.gui_mouse_y;
	
	if (_mouse_x > button.left  && _mouse_x < button.right
	 && _mouse_y > button.top && _mouse_y < button.bottom)
	{
		return true;
	}
	else return false;
}