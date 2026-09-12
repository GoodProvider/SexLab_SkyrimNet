Scriptname phhshSlaverDogTargetScript extends ReferenceAlias  

PHHSHInterface Property PHHSHInter Auto

Event OnActivate(ObjectReference act)
	Actor dog = qst.SlaverDogRef.GetActorRef()
	if (dog.GetFactionRank(qst.SlaverDogFaction) == 3)
		float t = Utility.GetCurrentRealTime()
		if (t - LastHitTime > 10)
			LastHitTime = t
			; Figure out nature of target to determine action

			if PHHSHInter.IsAPlayerSlave(GetActorRef())
				; Slave: Knock down and stop hitting, stop slave from fleeing
				dog.PushActorAway(GetActorRef(), 1)
				PHHSHInter.TellOff(GetActorRef(), "running_away")
				Debug.Notification("Hunter caught runaway slave " + GetActorRef().GetDisplayName())
				dog.SetFactionRank(qst.SlaverDogFaction, 4)
			elseif (!GetActorRef().HasKeyword(CreatureKeyword))
				; NPC: Keep paralyzing
				ParalyzeSpell.Cast( GetActorRef(), GetActorRef())
			else
				; Creature: Attack
				qst.CommandFollow()
				dog.StartCombat(GetActorRef())
			endif
		endif
	endif
EndEvent

phhshSlaverDogScript Property qst Auto
phhshStorageFunctions Property phhsh Auto
Keyword Property CreatureKeyword Auto
Spell Property ParalyzeSpell Auto
float Property LastHitTime Auto Hidden