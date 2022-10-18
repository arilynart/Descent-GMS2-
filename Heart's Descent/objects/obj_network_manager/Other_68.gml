/// @description data and connection handling

var _network_type = ds_map_find_value(async_load, "type");

switch (_network_type)
{
	case network_type_data:
		var _buffer = ds_map_find_value(async_load, "buffer");
	
		show_debug_message("Client received buffer. Activating Rpc.");
		
		process_command(_buffer);
		
		if (is_server) relay_command(_buffer);
	break;
	case network_type_connect:
		if (is_server)
		{
			show_debug_message("New client connected. Adding them to player list.");
			var _player_socket = ds_map_find_value(async_load, "socket");
			ds_list_add(player_sockets, _player_socket);
			
			cmd_set_server_client_socket(_player_socket);
			
			cmd_update_player_sockets();
		}
	break;
	case network_type_disconnect:
		var _player_socket = ds_map_find_value(async_load, "socket");
		if (is_server)
		{
			show_debug_message("Client Disconnected. Removing them from player list.");
			
			var _dc_index = ds_list_find_index(player_sockets, _player_socket);
			ds_list_delete(player_sockets, _dc_index);
			
			cmd_update_player_sockets();
		}
	break;
}