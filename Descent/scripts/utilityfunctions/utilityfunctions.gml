// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

PlayerAdjacent = function(square, requirePlayer)
{
	show_debug_message("Checking for adjacent players.");
	var foundPlayer = false;
	for (var i = 0; i < 8; i++)
	{
		var checkSquare = 0;
		switch (i)
		{
			//right
			case 0:
				checkSquare = square.right;
				break;
			//downright
			case 1:
				checkSquare = square.downRight;
				break;
			//down
			case 2:
				checkSquare = square.down;
				break;
			//downleft
			case 3:
				checkSquare = square.downLeft;
				break;
			//left
			case 4:
				checkSquare = square.left;
				break;
			//upleft
			case 5:
				checkSquare = square.upLeft;
				break;
			//up
			case 6:
				checkSquare = square.up;
				break;
			//upright
			case 7:
				checkSquare = square.upRight;
				break;
		}
			
		if (checkSquare.character != 0)
		{
			if (requirePlayer == true)
			{
				if (global.Player == checkSquare.character)
				{
					foundPlayer = true;
				}
				else
				{
					if (checkSquare.character.team == CharacterTeams.Ally)
					{
						show_debug_message(string(checkSquare.character.name) + " doesn't know what to do with that.");
					}
				}
			}
			else 
			{
				//after we add enemies we want to check to maker sure the character is allied.
				if (checkSquare.character.team == CharacterTeams.Ally || global.Player == checkSquare.character) 
				{
					foundPlayer = true;
				}
			}
		}
	}
	show_debug_message("Out of range.");
	return foundPlayer;
}