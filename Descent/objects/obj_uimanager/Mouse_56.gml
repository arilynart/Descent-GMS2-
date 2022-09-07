/// @description Insert description here
// You can write your code in this editor

dragSplit = false;

if (dragCard >= 0)
{
	var button = handDrawButton;
		
	if (mouseX >= button.left && mouseX <= button.right
		&& mouseY >= button.top && mouseY <= button.bottom)
	{
		//supply
		var card = ds_list_find_value(global.selectedCharacter.hand, dragCard);
		
		if (card.wSupply > 0)
		{
			SupplyFromCard(dragCard, global.selectedCharacter, Elements.W, card.wSupply);
		}
		if (card.fSupply > 0)
		{
			SupplyFromCard(dragCard, global.selectedCharacter, Elements.F, card.fSupply);
		}
		if (card.mSupply > 0)
		{
			SupplyFromCard(dragCard, global.selectedCharacter, Elements.M, card.mSupply);
		}
		if (card.sSupply > 0)
		{
			SupplyFromCard(dragCard, global.selectedCharacter, Elements.S, card.sSupply);
		}
		if (card.eSupply > 0)
		{
			SupplyFromCard(dragCard, global.selectedCharacter, Elements.E, card.eSupply);
		}
		if (card.dSupply > 0)
		{
			SupplyFromCard(dragCard, global.selectedCharacter, Elements.D, card.dSupply);
		}
		if (card.vSupply > 0)
		{
			SupplyFromCard(dragCard, global.selectedCharacter, Elements.V, card.vSupply);
		}
	}
}

dragCard = -1;