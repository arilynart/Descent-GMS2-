/// @description Zoom in

if (targetResolutionX == 0 && targetResolutionY == 0)
{
	timer = 0;
	switch(zoom)
	{
		case ZoomScale.max72:
			zoom = ZoomScale.mid144;
			startResolutionX = defaultResolutionX * 4;
			startResolutionY = defaultResolutionY * 4;
			targetResolutionX = defaultResolutionX * 2;
			targetResolutionY = defaultResolutionY * 2;

			break;
		case ZoomScale.mid144:
			zoom = ZoomScale.min288;
			startResolutionX = defaultResolutionX * 2;
			startResolutionY = defaultResolutionY * 2;
			targetResolutionX = defaultResolutionX;
			targetResolutionY = defaultResolutionY;

			break;
		default:
			break;
	}
}