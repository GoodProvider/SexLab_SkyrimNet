;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestFollowKimli Extends TopicInfo Hidden

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
Faction Property DOMActorExcludedDialogue Auto
Faction Property DOMActionWaiting Auto
Faction Property DOMActionFollowing Auto
Faction Property DOMActionTied Auto
Faction Property DOMFollowMode Auto
Faction Property DunPlayerAllyFaction Auto
Package Property DOMKimliSitCross Auto

Function DOM_DontEnslave(Actor akTarget)
	If akTarget.GetRelationshipRank(PlayerRef) < 3
		akTarget.SetRelationshipRank(PlayerRef, 3)
	endif
	akTarget.SetFactionRank(DOMActorExcludedFaction,1)
	akTarget.RemoveFromFaction(DOMActorExcludedDialogue)
	akTarget.RemoveFromFaction(DOMActionWaiting)
	akTarget.RemoveFromFaction(DOMActionTied)
	akTarget.SetFactionRank(DOMActionFollowing,1)
	int rank = akTarget.GetFactionRank(DOMFollowMode)
	if rank <= 0
		akTarget.SetFactionRank(DOMFollowMode,3)
	elseif rank > 0
		rank -= 1
		akTarget.SetFactionRank(DOMFollowMode,rank)
	endif
	akTarget.AddToFaction(DunPlayerAllyFaction)
	akTarget.SetPlayerTeammate()
	akTarget.SetRestrained(False)
	akTarget.SetDontMove(False)
	akTarget.SetActorValue("aggression", 1.0)
	akTarget.SetActorValue("confidence", 4.0)
	akTarget.SetActorValue("assistance", 2.0)
	akTarget.SetActorValue("morality",   0.0)
	Package current_package = akTarget.GetCurrentPackage()
	if current_package != DOMKimliSitCross
		ActorUtil.AddPackageOverride(akTarget, DOMKimliSitCross, 127, 1)
	endif
	akTarget.EvaluatePackage()
	;Debug.Trace("QUEST "+akTarget.getDisplayName()+" Waiting= "+akTarget.getFactionRank(DOMActionWaiting)+" Tied= "+akTarget.getFactionRank(DOMActionTied)+" Following= "+akTarget.getFactionRank(DOMActionFollowing))
EndFunction
