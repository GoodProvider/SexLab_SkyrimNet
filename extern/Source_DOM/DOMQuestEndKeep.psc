;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestEndKeep Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
 DOMQuestKeepSlave(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Kimli Auto
Actor Property PlayerRef Auto

Function DOMQuestKeepSlave(Actor akTarget) 
	; Olava
	If akTarget.GetRelationshipRank(PlayerRef) < 3
		akTarget.SetRelationshipRank(PlayerRef, 3)
	endif
	GetOwningQuest().SetStage(50)
	Kimli.Clear()
EndFunction
