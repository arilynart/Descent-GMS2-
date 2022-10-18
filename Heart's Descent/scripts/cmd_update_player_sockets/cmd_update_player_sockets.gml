// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cmd_update_player_sockets()
{
	var _nm = global.network_manager;
	if (_nm.is_server)
	{
		if (ds_list_size(_nm.player_sockets) > _nm.max_player_count)
		{
			for (var i = _nm.max_player_count; i < ds_list_size(_nm.player_sockets); i++)
			{
				var _socket = ds_list_find_value(_nm.player_sockets, i);
				cmd_disconnect_client(_socket);
			}
		}
		
		var _buffer = buffer_create(_nm.max_buffer_size, buffer_grow, 1);
		buffer_seek(_buffer, buffer_seek_start, 0);
		
		buffer_write(_buffer, buffer_u16, buffer_ids.update_player_sockets);
		
		for (var i = 0; i < ds_list_size(_nm.player_sockets); i++)
		{
			buffer_write(_buffer, buffer_u16, ds_list_find_value(_nm.player_sockets, i));
		}
		
		send_command(_buffer);
		
		buffer_delete(_buffer);
	}
}