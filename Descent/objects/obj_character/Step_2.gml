/// @description move


if (velocityX != 0)
{

	x += velocityX;
}

if (velocityY != 0)
{

	y += velocityY;
}

var otherSquare = instance_position(x, y, obj_Square);
if (currentSquare != otherSquare)
{
	currentSquare.character = 0;
	currentSquare = otherSquare;
	otherSquare.character = id;
}
	
show_debug_message("Current Square: " + string(currentSquare.coordinate.x) + ", " + string(currentSquare.coordinate.y));
