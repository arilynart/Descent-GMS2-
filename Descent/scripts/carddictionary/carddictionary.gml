// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum Classes
{
	NONE,
	BONDING
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
	ED
}

FindCard = function(class, type, element, rarity, index)
{
	switch (class)
	{
		case Classes.BONDING:
			switch (type)
			{
				case CardTypes.Node:
					switch (element)
					{
						case Elements.D:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.art = spr_ArtBondingNodeDC0;
											card.class = class;
											card.type = type;
											card.element = element;
											card.index = index;
											card.title = "TRUST NODE";
											card.dCost = 1;
											card.vCost = 1;
											card.dSupply = 2;
											card.typeText = "BONDING NODE - DIVINITY"
											card.text = "While a bonded monster is within 3||spr_Square|| , this card becomes a COVENANT NODE. ";
									
											return card;
										break;
										default:
											return 0;
										break;
									}
								break;
								default:
									return 0;
								break;
							}
							
						break;
						case Elements.E:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_NodeBgSE;
											card.art = spr_ArtBondingNodeEC0;
											card.class = class;
											card.type = type;
											card.element = element;
											card.index = index;
											card.title = "FERVOR NODE";
											card.eCost = 1;
											card.vCost = 1;
											card.eSupply = 2;
											card.typeText = "BONDING NODE - ESSENCE"
											card.text = "When you play this card, you can supply ||spr_E|| to a bonded monster within 3||spr_Square|| . ";
									
											return card;
										break;
										default:
											return 0;
										break;
									}
								break;
								default:
									return 0;
								break;
							}
							
						break;
						default:
							return 0;
						break;
					}
				break;
				default:
					return 0;
				break;
			}
		break;
		default:
			return 0;
		break;
			
	}
	return 0;
}

BaseCard = function(type)
{
	var struct = 
	{
		frame : spr_NodeBgWD,
		art : spr_NodeArtDefault,
		class : Classes.NONE,
		type : CardTypes.Node,
		element : Elements.W,
		rarity : CardRarities.Common,
		index : -1,
		title : "",
		typeText : "",
		text : "",
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
			costList = ds_list_create();
		}
	}
	return struct;
}