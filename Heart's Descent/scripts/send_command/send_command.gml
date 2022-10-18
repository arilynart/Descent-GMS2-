// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_command(buffer)
{
	show_debug_message("Sending command through.");
	network_send_packet(global.network_manager.client_socket, buffer, buffer_tell(buffer));
}