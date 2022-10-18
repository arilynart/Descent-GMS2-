// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function target_command(buffer, socket)
{
	network_send_packet(socket, buffer, buffer_tell(buffer));
}