;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname DOMInfoFamilyRecruitOffer Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_ThugOffer(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto
ReferenceAlias Property SlaveWithFamily Auto

Function DOM_ThugOffer(Actor akTarget)
	Actor akSlave
	if SlaveWithFamily != None
		akSlave = SlaveWithFamily.GetActorRef()
	endif
	DOM_Actor akActor = DOM01.GetActor(akSlave)
	DOM01.NPCFamilyRecruitOffer(akTarget,akActor)
EndFunction
