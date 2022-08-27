// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum CharacterClass
{
	Player,
	Bondable,
	Monster,
	Friendly,
	Hostile
}

FindCharacter = function(class, index)
{
	switch (class)
	{
		case CharacterClass.Player:
			var character = global.BaseCharacter();
			character.name = "Sythal";
			character.team = CharacterTeams.Ally;
			character.class = class;
			character.sprite = spr_Player;
			character.tempo = 3;
			array_push(character.packSlots, 1, 1, 1, 2);

			var starterPack1 = {};
			with (starterPack1)
			{
				sprite = spr_Pack1;
				tier = 1;
				width = 1;
				height = 2;
				contents = array_create(width * height);
			}

			var starterPack2 = {};
			with (starterPack2)
			{
				sprite = spr_Pack0;
				tier = 2;
				width = 2;
				height = 3;
				contents = array_create(width * height);
			}

			array_push(character.equippedPacks, starterPack1, starterPack2);
			
			var startingNode0 =
			{
				class : Classes.BONDING,
				type : CardTypes.Node,
				element : Elements.D,
				rarity : CardRarities.Common,
				index : 0
			}
			var startingNode1 =
			{
				class : Classes.BONDING,
				type : CardTypes.Node,
				element : Elements.E,
				rarity : CardRarities.Common,
				index : 0
			}
			
			array_push(character.unlockedCards, startingNode0, startingNode1);
			
			repeat(15) array_push(character.nodeDeck, startingNode0, startingNode1);
			
			return character;
			break;
		case CharacterClass.Monster:
			switch (index)
			{
				case 0:
					var character = global.BaseCharacter();
					character.name = "Forsaken Soul";
					character.aiMindIndex = 0;
					character.team = CharacterTeams.Enemy;
					character.class = class;
					character.sprite = spr_ForsakenBanshee;
					character.tempo = 2;
					array_push(character.packSlots, 1);

					var starterPack1 = {};
					with (starterPack1)
					{
						sprite = spr_Pack1;
						tier = 1;
						width = 1;
						height = 2;
						contents = array_create(width * height);
					}

					array_push(character.equippedPacks, starterPack1);
					return character;
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

BaseCharacter = function()
{
	var struct = 
	{
		spawnX : 0,
		spawnY : 0,
		name : "",
		aiMindIndex : -1,
		team : CharacterTeams.Neutral,
		class : CharacterClass.Monster,
		sprite : spr_Cancel,
		uiScale : 0.25,
		packSlots : array_create(0),
		equippedPacks : array_create(0),
		baseMaxMove : 6,
		tempo : 0,
		unlockedCards : array_create(0),
		nodeDeck : array_create(0),
		extraDeck : array_create(0)
	}
	return struct;
}

enum CharacterTeams
{
	Ally,
	Neutral,
	Enemy
}

