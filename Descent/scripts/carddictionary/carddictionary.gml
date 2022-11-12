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
	W, F, M, S, E, D, WF, WM, WS, WE, WD,
	FM, FS, FE, FD, MS, ME, MD, SE, SD, ED, V
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
											card.element = element;
											card.index = index;
											card.title = "TRUST NODE";
											card.dCost = 1;
											card.vCost = 1;
											card.dSupply = 2;
											card.typeText = "BONDING NODE - DIVINITY"
											card.text = "While a bonded monster is adjacent to you, this card becomes a COVENANT NODE. ";
									
											return card;
										break;
										case 1:
											var card = global.BaseCard(type);
											card.art = spr_ArtBondingNodeDC001;
											card.class = class;
											card.element = element;
											card.index = index;
											card.title = "ACCORDANCE NODE";
											card.dCost = 2;
											card.vCost = 1;
											card.dSupply = 2;
											card.typeText = "COVENANT NODE - DIVINITY"
											card.text = " ";
									
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
											card.element = element;
											card.index = index;
											card.title = "NURTURING RUNE";
											card.costText = "ESSENCE NODE";
											var cost1 = array_create(0);
											array_push(cost1, "ESSENCE", "NODE");
											array_push(card.costList, cost1);
											card.typeText = "FUNDAMENTAL RUNE - ESSENCE"
											card.text = "Supply the total supply value of all node cards you use to evoke this rune to a bonded monster within 6 |spr_Square| . ";
									
											return card;
										break;
										case 1:
											var card = global.BaseCard(type);
											card.frame = spr_RuneBgE;
											card.art = spr_ArtBondingRuneEC001;
											card.class = class;
											card.element = element;
											card.index = index;
											card.title = "SHIELDING BOND";
											card.permanent = true;
											card.costText = "COVENANT NODE";
											var cost1 = array_create(0);
											array_push(cost1, "COVENANT", "NODE");
											array_push(card.costList, cost1);
											card.typeText = "BONDING RUNE - ESSENCE"
											card.text = "Permanent.\n \nWhen a bonded monster within 6 |spr_Square|  "
													  + "takes damage, you can discard this card to reduce the damage by up to 5.";
									
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
											card.element = element;
											card.index = index;
											card.title = "SYNERGY BOND";
											card.costText = "2 NODES";
											card.permanent = true;
											var cost1 = array_create(0);
											array_push(cost1, "NODE")
											array_push(card.costList, cost1, cost1);
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
				case CardTypes.Manifest:
					switch (element)
					{
						case Elements.ED:
							switch (rarity)
							{
								case CardRarities.Uncommon:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_RuneBgED;
											card.art = spr_ArtBondingManifestEDU000;
											card.class = class;
											card.element = element;
											card.index = index;
											card.rarity = rarity;
											card.title = "EMPOWERING BOND";
											card.costText = "2 BOND RUNES";
											var cost1 = array_create(0);
											array_push(cost1, "BOND", "RUNE");
											array_push(card.costList, cost1, cost1);
											card.typeText = "BONDING MANIFEST - DIVINITY & ESSENCE"
											card.text = "+X for each BOND card you control.\n \nWhen a bonded monster within 6 |spr_Square|  deals damage, "
												+ "you can discard this card to deal 2X damage to that same target. ";
											
											card.titleFontScale = 0.9;
											card.typeFontScale = 0.72;
											
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
		case Classes.CHAPEL:
			switch (type)
			{
				case CardTypes.Node:
					switch (element)
					{
						
						case Elements.F:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_NodeBgF;
											card.art = spr_ArtChapelNodeFC000;
											card.class = class;
											card.element = element;
											card.index = index;
											card.title = "ARCHITECTURE NODE";
											card.fCost = 2;
											card.vCost = 1;
											card.fSupply = 2;
											card.typeText = "CATHEDRAL NODE - FLOW"
									
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
						case Elements.M:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_NodeBgM;
											card.art = spr_ArtChapelNodeMC000;
											card.class = class;
											card.element = element;
											card.index = index;
											card.title = "SCRIPTURE NODE";
											card.mCost = 1;
											card.vCost = 1;
											card.mSupply = 2;
											card.typeText = "CHAPEL NODE - MIST"
											card.text = "While you control a Chapel Module Space, this card becomes a CATHEDRAL NODE. ";
									
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
						
						case Elements.F:
							switch (rarity)
							{
								case CardRarities.Common:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_RuneBgF;
											card.art = spr_ArtChapelRuneFC000;
											card.class = class;
											card.element = element;
											card.index = index;
											card.title = "PILGRIMAGE RUNE";
											card.costText = "FLOW CATHEDRAL NODE";
											var cost1 = array_create(0);
											array_push(cost1, "FLOW", "CATHEDRAL", "NODE");
											array_push(card.costList, cost1);
											card.typeText = "CHAPEL RUNE - FLOW"
											card.text = "Teleport target character within 6 |spr_Square| to any Chapel Module Space you control. ";
									
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
				case CardTypes.Manifest:
					switch (element)
					{
						case Elements.FM:
							switch (rarity)
							{
								case CardRarities.Uncommon:
									switch (index)
									{
										case 0:
											var card = global.BaseCard(type);
											card.frame = spr_RuneBgFM;
											card.art = spr_ArtChapelManifestFMU000;
											card.class = class;
											card.element = element;
											card.index = index;
											card.rarity = rarity;
											card.title = "DOCTRINE OF WINDS";
											card.costText = "2 CATHEDRAL NODES";
											var cost1 = array_create(0);
											array_push(cost1, "CATHEDRAL", "NODE");
											array_push(card.costList, cost1, cost1);
											card.typeText = "CHAPEL MANIFEST - FLOW & MIST"
											card.text = "When this card is played, choose a square within 6 |spr_Square|  . " 
													  + "While this card stays in play, that square is a Chapel Module Space." 
													  + "\n \nUp to once during your turn, discard a card: For each ally that is " 
													  + "inside a Chapel Module Space you control, you have +2 max move this turn and gain +2 move.";
											
											card.titleFontScale = 0.9;
											card.typeFontScale = 0.72;
											card.textFont = fnt_CardTextSmaller;
											
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