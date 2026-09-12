;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMInfoSlaveTraits1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMInfoSlaveTraits(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

int Property hexaco_trait Auto
DOM_Core Property DOM01 Auto

Function DOMInfoSlaveTraits(Actor akTarget)
	DOM01.DOMInfoNPCTraits1(aktarget,hexaco_trait)
EndFunction
