// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cmd_disconnect_client(socket)
{
	var _nm = global.network_manager;
	if (_nm.is_server)
	{
		var _buffer = buffer_create(_nm.max_buffer_size, buffer_grow, 1);
		buffer_seek(_buffer, buffer_seek_start, 0);
	
		buffer_write(_buffer, buffer_u16, buffer_ids.disconnect_client);
		
		target_command(_buffer, socket);
		
		buffer_delete(_buffer);
	}

}