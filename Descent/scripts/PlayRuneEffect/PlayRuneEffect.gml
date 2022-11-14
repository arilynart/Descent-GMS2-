// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayRuneEffect(effect)
{
	var card = ds_list_find_value(effect.character.extra, effect.index);
	var lusium = ds_list_find_value(effect.character.burntLusium, effect.lusiumIndex);
	
	//discard all cards attached to lusium
	for (var i = 0; i < ds_list_size(lusium.heldCards); i++)
	{
		var attachedCard = ds_list_find_value(lusium.heldCards, i);
		if (attachedCard != 0)
		{
			if (attachedCard.type == CardTypes.Node) ds_list_add(effect.character.discard, attachedCard);
			else ds_list_add(effect.character.extra, attachedCard);
		}
		
	}
	
	ds_list_clear(lusium.heldCards);
	
	//if card is permanent
	if (card.permanent)
	{
		//lusium capacity becomes 1
		lusium.capacity = 1;
		//play rune on lusium
		ds_list_add(lusium.heldCards, card);
		ds_list_delete(effect.character.extra, effect.index);
	}
	//else
	else
	{
		//destroy lusium
		ds_list_delete(effect.character.burntLusium, effect.lusiumIndex);
		//play rune effect
		
	}
	
	effect.character.AddArtToQueue(card);
	
	//threat
	
	for (var i = 0; i < ds_list_size(global.Combatants); i++)
	{
		with (ds_list_find_value(global.Combatants, i))
		{
			if (characterStats.team == CharacterTeams.Enemy)
			{
				var threatValue = characterStats.spellThreatValue;
			
				var sourceThreat = FindThreat(effect.character);
				
				sourceThreat.threat += threatValue;
				
				UpdateThreat();
			}
			
		}
	}
	
	EndEffect();
}