// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Summon(square)
{
	if (square.interaction == 0 && square.character == 0)
	{
		global.selectedCharacter.currentSquare.Deactivate(global.selectedCharacter.storedActivation);
		global.SelectSquareExecute = 0;
		
		var summonStats = ds_list_find_value(global.BondedMonsters, global.UiManager.selectedSummon);
		ds_list_delete(global.BondedMonsters, global.UiManager.selectedSummon);
		var character = global.UiManager.summonCharacter;
		
		global.UiManager.selectedSummon = -1;
		
		character.ResetStats(summonStats);
		
		character.x = square.x;
		character.y = square.y;
		character.currentSquare = square;
		square.character = character;
		
		array_push(global.Allies, character);
		
		global.UiManager.summonCharacter = instance_create_layer(-10000, -10000, "Characters", obj_Character, { characterStats : FindCharacter(CharacterClass.Bondable, 0) });
	}
}