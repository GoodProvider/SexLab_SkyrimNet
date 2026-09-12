;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestEnd3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMQuestEnd3(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

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

Function DOMQuestEnd3(Actor akTarget)
	; Olava
	If akTarget.GetRelationshipRank(PlayerRef) < 2
		akTarget.SetRelationshipRank(PlayerRef, 2)
	endif
	; Kimli
	Actor akRef = Kimli.GetActorRef()
	akRef.RemoveFromFaction(DOMActionTied)
	akRef.RemoveFromFaction(DOMActionFollowing)	
	akRef.RemoveFromFaction(DOMActionWaiting)
	akTarget.RemoveFromFaction(DOMActorExcludedFaction)
	If akRef.GetRelationshipRank(PlayerRef) < 3
		akRef.SetRelationshipRank(PlayerRef, 3)
	endif
	akRef.SetPlayerTeammate(false)
	akRef.AddToFaction(DunPlayerAllyFaction)
	akRef.AddToFaction(PotentialFollowerFaction)
	akRef.SetFactionRank(CurrentFollowerFaction, -1)
	GetOwningQuest().SetStage(50)
	Kimli.Clear()
	ActorUtil.ClearPackageOverride(akRef)
	akRef.EvaluatePackage()
	Olava.GetActorRef().RemoveFromFaction(DOMActorExcludedFaction)
EndFunction

