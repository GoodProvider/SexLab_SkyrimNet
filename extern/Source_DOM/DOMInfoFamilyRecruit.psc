;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMInfoFamilyRecruit Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_ThugHire(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto
ReferenceAlias Property SlaveWithFamily Auto

Function DOM_ThugHire(Actor akTarget)
	Actor akSlave
	if SlaveWithFamily != None
		akSlave = SlaveWithFamily.GetActorRef()
	endif
	DOM_Actor akActor = DOM01.GetActor(akSlave)
	DOM01.NPCFamilyRecruit(akTarget,akActor)
EndFunction
