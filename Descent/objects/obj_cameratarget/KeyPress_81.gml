/// @description Zoom Out

if (targetResolutionX == 0 && targetResolutionY == 0)
{
	timer = 0;
	switch(zoom)
	{
		case ZoomScale.mid144:
			zoom = ZoomScale.max72;
			startResolutionX = defaultResolutionX * 2;
			startResolutionY = defaultResolutionY * 2;
			targetResolutionX = defaultResolutionX * 4;
			targetResolutionY = defaultResolutionY * 4;
			
			break;
		case ZoomScale.min288:
			zoom = ZoomScale.mid144;
			startResolutionX = defaultResolutionX;
			startResolutionY = defaultResolutionY;
			targetResolutionX = defaultResolutionX * 2;
			targetResolutionY = defaultResolutionY * 2;
			
			break;
		default:
			break;
	}
}