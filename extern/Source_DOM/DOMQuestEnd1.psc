;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestEnd1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMQuestEnd1(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property DOMActionWaiting Auto
Faction Property DOMActionFollowing Auto
Faction Property DOMActionTied Auto
ReferenceAlias Property Kimli Auto
Actor Property PlayerRef Auto

Function DOMQuestEnd1(Actor akTarget)
	Actor akRef = Kimli.GetActorRef()
	If akTarget.GetRelationshipRank(PlayerRef) < 3
		akTarget.SetRelationshipRank(PlayerRef, 3)
	endif
	GetOwningQuest().SetStage(49)
	akRef.EvaluatePackage()
EndFunction

