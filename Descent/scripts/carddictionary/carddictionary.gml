// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum Classes
{
	NONE,
	BONDING,
	CHAPEL
}

enum CardTypes
{
	Node,
	Rune,
	Manifest
}

enum CardRarities
{
	Common,
	Uncommon,
	Rare,
	Mythic,
	Legendary,
	Primal
}

enum Elements
{
	W,
	F,
	M,
	S,
	E,
	D,
	WF,
	WM,
	WS,
	WE,
	WD,
	FM,
	FS,
	FE,
	FD,
	MS,
	ME,
	MD,
	SE,
	SD,
	ED,
	V
}


BaseCard = function(type)
{
	var struct = 
	{
		frame : spr_NodeBgWD,
		art : spr_NodeArtDefault,
		class : Classes.NONE,
		type : type,
		element : Elements.W,
		rarity : CardRarities.Common,
		index : -1,
		title : "",
		typeText : "",
		text : "",
		titleFontScale : 1,
		typeFontScale : 1,
		textFont : fnt_CardText
	}
	if (type == CardTypes.Node)
	{
		with (struct)
		{
			wCost = 0;
			fCost = 0;
			mCost = 0;
			sCost = 0;
			eCost = 0;
			dCost = 0;
			vCost = 0;
			wSupply = 0;
			fSupply = 0;
			mSupply = 0;
			sSupply = 0;
			eSupply = 0;
			dSupply = 0;
			vSupply = 0;
		}
		
	}
	else
	{
		with (struct)
		{
			costText = "";
			costList = array_create(0);
			permanent = false;
			playedThisTurn = false;
			
			if (type == CardTypes.Manifest) permanent = true;
		}
	}
	return struct;
}
