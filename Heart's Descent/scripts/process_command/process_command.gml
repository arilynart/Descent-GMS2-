// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function process_command(buffer)
{
	var _buffer_id = buffer_read(buffer, buffer_u16);
	show_debug_message("Buffer ID: " + string(_buffer_id));
	switch (_buffer_id)
	{
		#region buffer_ids.disconnect_client
		
		case buffer_ids.set_server_client_socket:
		
		
		
		var _socket = buffer_read(buffer, buffer_u16);
		global.network_manager.server_client_socket = _socket;
		
		break;
		
		#endregion
		
		#region buffer_ids.disconnect_client
		
		case buffer_ids.disconnect_client:

		show_debug_message("Too many players.");
		network_destroy(global.network_manager.client_socket);
		global.network_manager.reset_network_data();
		
		break;
		
		#endregion
		
		#region buffer_ids.update_player_sockets
		
		case buffer_ids.update_player_sockets:
		
		ds_list_clear(global.network_manager.player_sockets);
		while (buffer_tell(buffer) < buffer_get_size(buffer) - 1)
		{
			ds_list_add(global.network_manager.player_sockets, buffer_read(buffer, buffer_u16));
		}
			
		break;
		
		#endregion
	}
}

enum buffer_ids
{
	set_server_client_socket,
	disconnect_client,
	update_player_sockets
}