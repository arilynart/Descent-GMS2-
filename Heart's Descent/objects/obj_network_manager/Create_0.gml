/// @description initialize



global.network_manager = id;

port = 7777;

max_buffer_size = 256;
max_player_count = 2;
player_sockets = ds_list_create();

ready_clients = 0;

targetIp = "127.0.0.1";

function reset_network_data()
{
	
	connected = false;
	client_socket = -1;
	is_server = false;
	server = -1;
	client_server = -1;
	ds_list_clear(player_sockets);
	
	server_client_socket = -1;
	
}

reset_network_data()