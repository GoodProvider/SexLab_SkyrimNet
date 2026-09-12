;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestReleaseKimli Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_DontEnslave(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
Faction Property DOMActorExcludedFaction Auto
Faction Property DOMActionWaiting Auto
Faction Property DOMActionFollowing Auto
Faction Property DOMFollowMode Auto
Faction Property DOMActorExcludedDialogue Auto
Faction Property DOMActionTied Auto
Faction Property DunPlayerAllyFaction Auto
ReferenceAlias Property Cross Auto
Package Property DOMKimliSitCross Auto

Function DOM_DontEnslave(Actor akTarget)
	Debug.Trace("DOMQuestReleaseKimli DOM_DontEnslave")
	If akTarget.GetRelationshipRank(PlayerRef) < 1
		akTarget.SetRelationshipRank(PlayerRef, 1)
	endif
	akTarget.RemoveFromFaction(DOMActorExcludedFaction)
	akTarget.RemoveFromFaction(DOMActorExcludedDialogue)
	akTarget.RemoveFromFaction(DOMActionWaiting)
	akTarget.RemoveFromFaction(DOMActionTied)
	akTarget.SetFactionRank(DOMActionFollowing,1)
	akTarget.SetFactionRank(DOMFollowMode,1)
	akTarget.AddToFaction(DunPlayerAllyFaction)
	akTarget.SetPlayerTeammate()
	akTarget.SetRestrained(False)
	akTarget.SetDontMove(False)
	akTarget.SetActorValue("aggression", 1.0)
	akTarget.SetActorValue("confidence", 4.0)
	akTarget.SetActorValue("assistance", 2.0)
	akTarget.SetActorValue("morality",   0.0)
	GetOwningQuest().SetStage(45)
	Package current_package = akTarget.GetCurrentPackage()
	if current_package != DOMKimliSitCross
		ActorUtil.AddPackageOverride(akTarget, DOMKimliSitCross, 127, 1)
		current_package = akTarget.GetCurrentPackage()
	endif
	akTarget.EvaluatePackage()
	if akTarget.GetSitState() == 3
		Cross.GetReference().Activate(akTarget,true)
	endif
	Utility.Wait(2.0)
	akTarget.EvaluatePackage()
	Debug.Trace("QUEST "+akTarget.getDisplayName()+" Waiting= "+akTarget.getFactionRank(DOMActionWaiting)+" Tied= "+akTarget.getFactionRank(DOMActionTied)+" Following= "+akTarget.getFactionRank(DOMActionFollowing)+" Following= "+akTarget.getFactionRank(DOMFollowMode)+" pkg="+current_package)
EndFunction
