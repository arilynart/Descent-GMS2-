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
	ED,
	V
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
						
						case Elements.E:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_NodeBgSE;
											card.art = spr_ArtBondingNodeEC000;
											card.class = class;
											card.type = type;
											card.element = element;
											card.index = index;
											card.title = "FERVOR NODE";
											card.eCost = 1;
											card.vCost = 1;
											card.eSupply = 2;
											card.typeText = "BONDING NODE - ESSENCE"
											card.text = "When you play this card, you can supply |spr_E|  to a bonded monster within 3 |spr_Square| . ";
									
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
						case Elements.D:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.art = spr_ArtBondingNodeDC000;
											card.class = class;
											card.type = type;
											card.element = element;
											card.index = index;
											card.title = "TRUST NODE";
											card.dCost = 1;
											card.vCost = 1;
											card.dSupply = 2;
											card.typeText = "BONDING NODE - DIVINITY"
											card.text = "While a bonded monster is within 3 |spr_Square| , this card becomes a COVENANT NODE. ";
									
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
				case CardTypes.Rune:
				switch (element)
					{
						
						case Elements.E:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_RuneBgE;
											card.art = spr_ArtBondingRuneEC000;
											card.class = class;
											card.type = type;
											card.element = element;
											card.index = index;
											card.title = "NURTURING RUNE";
											card.costText = "ESSENCE BONDING NODE";
											var cost1 = ds_list_create();
											ds_list_add(cost1, "ESSENCE", "BONDING", "NODE");
											ds_list_add(card.costList, cost1);
											card.typeText = "BONDING RUNE - ESSENCE"
											card.text = "Supply the total supply value of all node cards you use to evoke this rune to a bonded monster within 6 |spr_Square| . ";
									
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
						case Elements.D:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_RuneBgD;
											card.art = spr_ArtBondingRuneDC000;
											card.class = class;
											card.type = type;
											card.element = element;
											card.index = index;
											card.title = "SYNERGY BOND";
											card.costText = "2 BONDING NODES";
											card.permanent = true;
											var cost1 = ds_list_create();
											ds_list_add(cost1, "BONDING", "NODE")
											ds_list_add(card.costList, cost1, cost1);
											card.typeText = "BONDING RUNE - DIVINITY"
											card.text = "Permanent.\n \nWhen a bonded monster within " 
													  + "6 |spr_Square|  deals damage, you can discard this "
													  + "card to allow that monster to make another attack " 
													  + "this turn without spending |spr_Ap| . ";
									
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
			permanent = false;
		}
	}
	return struct;
}