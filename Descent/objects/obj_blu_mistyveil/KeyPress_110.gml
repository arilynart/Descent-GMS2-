/// @description Switch range mode



if (displaying && currentMode == WallModes.Range)
{
	currentRangeMode++;
	if (currentRangeMode > 3) currentRangeMode = RangeWallTypes.FullBlock;
}