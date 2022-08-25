/// @description Select Square


if ((global.UiLock && global.SquareLock == false) || map.blueprint.displaying || global.UiManager.displayDialogue) return;

show_debug_message("Square Clicked: " + string(id) + " Coordinate: " + string(coordinate));

Select();