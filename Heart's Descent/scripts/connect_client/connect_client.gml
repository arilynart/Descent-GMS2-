// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function connect_client()
{
	with (global.network_manager)
	{
		client_socket = network_create_socket(network_socket_tcp);
		client_server = network_connect(client_socket, targetIp, port);
	
		if (client_server < 0)
		{
			show_error("Connection error. Server could not be found.", false);
		}
		else connected = true;
	}
}