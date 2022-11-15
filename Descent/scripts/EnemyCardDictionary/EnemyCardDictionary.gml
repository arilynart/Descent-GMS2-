// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum EnemyCardTypes
{
	Basic,
	Trait,
	Astromancy
}

BaseAttackCard = function(monsterIndex, type, rarity, index)
{
	var card =
	{
		title : "EMPTY CARD",
		text : "Empty text.",
		typeText : "EMPTY TYPE - UNSET",
		frame : spr_NodeBgM,
		art : spr_Cancel,
		titleFontScale : 1,
		typeFontScale : 1,
		textFont : fnt_CardText,
		monsterIndex : monsterIndex,
		type : type,
		rarity : rarity,
		index : index,
		actions : array_create(0),
		performedActions : array_create(0),
		reverseActions : array_create(0)
	}
	
	return card;
}



FindEnemyCard = function(monsterIndex, type, rarity, index)
{
	switch(monsterIndex)
	{
		case 0:
			switch (type)
			{
				case EnemyCardTypes.Basic:
					switch (rarity)
					{
						case CardRarities.Common:
							switch (index)
							{
								case 0:
									var card = BaseAttackCard(monsterIndex, type, rarity, index);
									
									card.title = "DRAINING MIST";
									card.typeText = "BASIC ATTACK - SPIRIT";
									card.text = "Advance 6 |spr_Square|  . "
											  + "\n \nMelee - The attacker deals 3 damage to you. If you still have SP after taking damage, discard a card. "
											  + "\n \nIf the attacker was out of range for the previous action, Advance 6 |spr_Square|  . ";
									card.frame = spr_RuneBgS;
									card.art = spr_ArtMonster000BasicC000;
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
	return 0;
}