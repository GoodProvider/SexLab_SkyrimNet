;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestEnd4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMQuestEnd4(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Import Utility

Faction Property DOMActionWaiting Auto
Faction Property DOMActionFollowing Auto
Faction Property DOMActionTied Auto
Faction Property DunPlayerAllyFaction Auto
Faction Property DOMActorExcludedFaction Auto
Faction Property PotentialFollowerFaction Auto
Faction Property CurrentFollowerFaction Auto
ReferenceAlias Property Kimli Auto
ReferenceAlias Property Olava Auto
Actor Property PlayerRef Auto

Function DOMQuestEnd4(Actor akTarget)
	Actor akRef = Kimli.GetActorRef()
	GetOwningQuest().SetStage(50)
	; Olava
	If akTarget.GetRelationshipRank(PlayerRef) < 3
		akTarget.SetRelationshipRank(PlayerRef, 3)
	endif
	; Kimli
	akRef.RemoveFromFaction(DOMActionTied)
	akRef.RemoveFromFaction(DOMActionFollowing)
	akRef.RemoveFromFaction(DOMActionWaiting)
	akTarget.RemoveFromFaction(DOMActorExcludedFaction)
	If akRef.GetRelationshipRank(PlayerRef) < 4
		akRef.SetRelationshipRank(PlayerRef, 4)
	endif
	akRef.SetPlayerTeammate(false)
	akRef.AddToFaction(DunPlayerAllyFaction)
	akRef.AddToFaction(PotentialFollowerFaction)
	if !akRef.IsInFaction(CurrentFollowerFaction) ;CurrentFollowerFaction [FACT:0005C84E]
		akRef.AddToFaction(CurrentFollowerFaction)
	endif
	akRef.SetFactionRank(CurrentFollowerFaction, -1)
	Wait(4.0)
	Debug.trace(akREf.GetDisplayName()+" current package = "+akRef.GetCurrentPackage())
	Wait(4.0)
	Kimli.Clear()
	ActorUtil.ClearPackageOverride(akRef)
	akRef.EvaluatePackage()
      Olava.GetActorRef().RemoveFromFaction(DOMActorExcludedFaction)
EndFunction

