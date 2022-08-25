// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AiUpdateGoal(character)
{
	var aiMind = character.aiMind;
	if (aiMind.PriorityGoal != 0)
	{
		//execute the priority
	}
	else
	{
		//no priority, the character can do what suits it best.
		
		//find the best goal depending on the situation and what is available
		
		//if we are about to die, try to heal or bolster defenses.
		
			//if we can heal
				//heal self
			//else, if we are not ai0 and a nearby ally is capable of healing before a dangerous enemy can act
			
				//run towards the ally
				
				//if we can bolster defenses
					//bolster self defenses
			
			//else, if we can bolster defenses
				//bolster self defenses
			
			//else
				//this is our last stand. go full offense
			
		//else if we have any methods of movement
		if (global.AiCanMove(character))
		{
			//move towards nearest enemy
			character.aiGoal = method(global, AiMoveToEnemyGoal);
		}
		else
		{
			//can't find anything else to do. end turn.
			character.aiGoal = method(global, AiEndTurnGoal);
		}
			
	}
	
	//goal has been updated. execute goal protocol
	character.aiGoal(character);
}

//all types of actions that an Ai could desire
enum AiGoals
{
	HealSelf,
	HealAny,
	DefenseIncrease,
	DamageEnemy,
	DamageMultiple,
	MoveSelf,
	MoveEnemy,
	MoveAlly,
	MoveAny
}