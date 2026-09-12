;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestStart Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
DOMQuestOLava1(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
ReferenceAlias Property Agnis Auto

Function DOMQuestOLava1(Actor akTarget)
	GetOwningQuest().SetStage(10)
	If akTarget.GetRelationshipRank(PlayerRef) < 1
		akTarget.SetRelationshipRank(PlayerRef, 1)
	endif
	Actor akRef = Agnis.GetActorRef()
	if akRef != None && akRef.IsDead()
		GetOwningQuest().SetStage(20)
	elseif akRef == None
		GetOwningQuest().SetStage(20)
	endif
EndFunction
