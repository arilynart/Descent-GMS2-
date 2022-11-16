// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AdvanceAction(character, source, card, data)
{
	CO_PARAMS.card = card;
	CO_PARAMS.character = character;
	CO_PARAMS.source = source;
	CO_PARAMS.data = data;
	
	return CO_BEGIN
		sourceActivation = source.currentSquare.Activate(data.amount, source, data.movementType);
	
		sourceActivation = 0;
		i = -1;
		
		foundTarget = 0;
		WHILE foundTarget == 0 THEN
			i++;
			
			IF (i > 30) THEN
				var threat = source.FindThreat(character);
				
				threat.threat = 1;
				
				targetThreat = global.CombatantsWithThreat + 1;
				
				source.UpdateThreat();
				
				show_debug_message("Target is more than maximum movement away. Reset target's threat.");
				
				AWAIT (global.CombatantsWithThreat >= targetThreat) THEN
				
				if (source.threatTarget != character)
				{
					var cardSearch = ds_list_find_index(character.threatCards, card)
				
					if (cardSearch >= 0)
					{
						ds_list_add(source.threatTarget.threatCards, card);
						
						ds_list_delete(character.threatCards, cardSearch);
					}
				}
				BREAK;
			END_IF
			
			var type = data.movementType;
			
			if (type == ParseTypes.Standard) type = ParseTypes.Melee;
			 
			sourceActivation = source.currentSquare.Activate(data.amount + i, source, type);
			
			YIELD THEN
			
			var searchForTarget = source.currentSquare.CheckSquare(character.currentSquare, sourceActivation);
			
			if (searchForTarget != 0) foundTarget = searchForTarget;
		
			YIELD THEN
		END

		
		if (foundTarget != 0)
		{
			var targetSquares = 0;6++
			if (data.movementType == ParseTypes.Standard) sourceActivation  = source.currentSquare.Activate(data.amount + i, source, data.movementType);
			
			if (foundTarget.distance <= data.amount + data.targetRange)
			{
				var targetActivation = character.currentSquare.Activate(data.targetRange, source, data.movementType);
				
				targetSquares = array_create(0);
				
				for (var j = 0; j < array_length(targetActivation); j++)
				{
					var parse = targetActivation[j];
					
					var search = source.currentSquare.CheckSquare(parse.square, sourceActivation);
					
					show_debug_message("Target Range Remainder: " + string(data.targetRange % 1 != 0) + " distance check : " + string(parse.distance == data.targetRange - 0.5) + " search check: " + string (search != 0));
					
					if ((parse.distance == data.targetRange 
					 || (data.targetRange % 1 != 0 && parse.distance == data.targetRange - 0.5))
					  && search != 0 && search.distance <= data.amount && search.square.character != 0) 
					{
						array_push(targetSquares, parse);
					}
				}
			}
			else
			{
				var targetActivation = character.currentSquare.Activate(i + 1, character, data.movementType);
				
				var testSquares = array_create(0);
				var minimumDistance = 99;
				
				targetSquares = array_create(0);
				
				for (var j = 0; j < array_length(targetActivation); j++)
				{
					var parse = targetActivation[j];
					
					var search = character.currentSquare.CheckSquare(parse.square, sourceActivation);
					
					if (search != 0 && search.square.character == 0
					 && search.distance <= data.amount && parse.distance <= minimumDistance)
					{
						if (search.distance < minimumDistance) minimumDistance = parse.distance;
						array_push(testSquares, parse);
					}
				}
				
				for (var j = 0; j < array_length(testSquares); j++)
				{
					var parse = testSquares[j];
					
					if (parse.distance == minimumDistance) array_push(targetSquares, parse);
				}
			}
			
			if (targetSquares != 0 && array_length(targetSquares) > 0)
			{
				//if (array_length(targetSquares)  == 1)
				//{
				//	var sq = targetSquares[0];
				//	source.moveLock = true;
		
				//	sq.moveTarget = true;
		
				//	var moveEffect = global.BaseEffect();
				//	moveEffect.character = source;
				//	moveEffect.activation = sourceActivation;
				//	moveEffect.target = sq;
				//	moveEffect.Start = method(global, global.MoveEffect);
		
				//	AddEffect(moveEffect);
				//}
				//else
				//{
					if (global.UiManager.map.movingCharacter != 0)
					{
						global.UiManager.map.movingCharacter.currentSquare.Deactivate(map.movingCharacter.storedActivation);
						global.UiManager.map.movingCharacter = 0;
					}
				
				
					global.selectedSquare = self;
					global.UiManager.map.movingCharacter = source;
				
					source.storedActivation = sourceActivation;
				
					source.currentSquare.HighlightActivation(targetSquares);
					
					source.OnMoveEnd = method(global, CompleteAction);
				//}
			}
		}

	CO_END
}

function AdvanceExecution(character, source, card)
{
	
}

function AdvanceReverse(character, source, card)
{
	
}