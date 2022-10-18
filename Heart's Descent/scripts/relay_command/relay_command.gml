// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function relay_command(buffer)
{
	show_debug_message("Relaying command. " + string(buffer));
	
	for (var i = 1; i < ds_list_size(global.network_manager.player_sockets); i++)
	{
		var _client = ds_list_find_value(global.network_manager.player_sockets, i);
		network_send_packet(_client, buffer, buffer_tell(buffer));
	}
	
}