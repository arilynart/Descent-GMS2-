/// @description check ui clicks


#region solo

if (solo_button != 0 && check_button(solo_button))
{
	
	return;
}

#endregion

#region host

if (host_button != 0 && check_button(host_button))
{
	create_server();
	
	return;
}

#endregion

#region join

if (join_button != 0 && check_button(join_button))
{
	connect_client();
	
	return;
}

#endregion