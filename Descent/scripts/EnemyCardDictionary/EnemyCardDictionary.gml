// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum EnemyCardTypes
{
	Basic,
	Trait,
	Astromancy
}

FindEnemyCard = function(monsterIndex, type, element, rarity, index)
{
	switch(monsterIndex)
	{
		case EnemyCardTypes.Basic:
		break;
		default:
			return 0;
		break;
	}
	return 0;
}