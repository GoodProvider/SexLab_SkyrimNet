Scriptname WE01BanditScript extends ReferenceAlias  

ReferenceAlias Property BanditVictim  Auto  
ReferenceAlias Property Boss  Auto  
ReferenceAlias Property Bandit1  Auto  
ReferenceAlias Property Bandit2  Auto  


Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if aeCombatState && GetActorRef() != None && !GetActorRef().IsDead()
		quest myQuest = GetOwningQuest()
		if myQuest 
			(myQuest as WEScript).makeAliasAggressiveAndAttackPlayer(BanditVictim)
			(myQuest as WEScript).makeAliasAggressiveAndAttackPlayer(Boss)
			(myQuest as WEScript).makeAliasAggressiveAndAttackPlayer(Bandit1)
			(myQuest as WEScript).makeAliasAggressiveAndAttackPlayer(Bandit2)
		endIf
;/	if aeCombatState > 0
		(GetOwningQuest() as WEScript).makeAliasAggressiveAndAttackPlayer(BanditVictim)
		(GetOwningQuest() as WEScript).makeAliasAggressiveAndAttackPlayer(Boss)
		(GetOwningQuest() as WEScript).makeAliasAggressiveAndAttackPlayer(Bandit1)
		(GetOwningQuest() as WEScript).makeAliasAggressiveAndAttackPlayer(Bandit2)/;
	endif

EndEvent


