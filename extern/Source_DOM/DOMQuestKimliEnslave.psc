;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestKimliEnslave Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_Enslave(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
DOM_SlaveManager Property DOM02 Auto
Faction Property DunPlayerAllyFaction Auto
Faction Property DOMActorExcludedFaction Auto
Faction Property DOMActorExcludedDialogue Auto
Faction Property DOMActionWaiting Auto
Faction Property DOMActionFollowing Auto
Faction Property DOMActionTied Auto
Faction Property DOMBeingCaptured Auto
Faction Property DOMTrainSubmission Auto
ReferenceAlias Property Cross Auto

Function DOM_Enslave(Actor akTarget)
	int istage = GetOwningQuest().GetStage()
	if istage<45
		GetOwningQuest().SetStage(45)
	endif
	if akTarget == None
		return
	endif	
	if akTarget.IsChild()
		DOM_DontEnslave(akTarget)
		return
	endif	
	if akTarget.IsInFaction(DOMBeingCaptured)
		return
	endif	
	akTarget.SetFactionRank(DOMBeingCaptured,2)
	akTarget.RemoveFromFaction(DOMActorExcludedFaction)
	akTarget.RemoveFromFaction(DOMActorExcludedDialogue)
	akTarget.RemoveFromFaction(DOMActionWaiting)
	akTarget.RemoveFromFaction(DOMActionTied)
	akTarget.RemoveFromFaction(DOMActionFollowing)
	int rank = akTarget.GetFactionRank(DOMTrainSubmission)
	if rank < 1
		akTarget.SetFactionRank(DOMTrainSubmission,1)
	endif
	DOM_Actor akActor = None
	if cross != None
		akTarget.SetFactionRank(DOMActionTied,4) ; force initial behaviour to restrained in furniture
		DOM02.SetActiveFurniture(cross.GetRef()) ; set active furniture for initial behaviour
		akActor = DOM02.Capture(akTarget,"DOMZazXcross01_Loop")
	else
		akActor = DOM02.Capture(akTarget,"Anim_BleedOutStart")
	endif
	if akActor == None
		 akTarget.RemoveFromFaction(DOMBeingCaptured)
		 return
	endif
	akActor.mind.TrainRespect(20.0)  ; Respect boost for tied up capture
	DOM02.SetActiveFurniture(None) ; unset active furniture
EndFunction

Function DOM_DontEnslave(Actor akTarget)
	If akTarget.GetRelationshipRank(PlayerRef) < 3
		akTarget.SetRelationshipRank(PlayerRef, 3)
	endif
	akTarget.RemoveFromFaction(DOMActorExcludedDialogue)
	akTarget.RemoveFromFaction(DOMActionWaiting)
	akTarget.RemoveFromFaction(DOMActionTied)
	akTarget.SetFactionRank(DOMActionFollowing,1)
	akTarget.AddToFaction(DunPlayerAllyFaction)
	akTarget.SetPlayerTeammate()
	akTarget.SetRestrained(False)
	akTarget.SetDontMove(False)
	akTarget.SetActorValue("aggression", 1.0)
	akTarget.SetActorValue("confidence", 4.0)
	akTarget.SetActorValue("assistance", 2.0)
	akTarget.SetActorValue("morality",   0.0)
	akTarget.EvaluatePackage()
	if akTarget.GetSitState() == 3
		Cross.GetReference().Activate(akTarget,true)
	endif
	Debug.Trace("QUEST "+akTarget.getDisplayName()+" Waiting= "+akTarget.getFactionRank(DOMActionWaiting)+" Tied= "+akTarget.getFactionRank(DOMActionTied)+" Following= "+akTarget.getFactionRank(DOMActionFollowing))
EndFunction
