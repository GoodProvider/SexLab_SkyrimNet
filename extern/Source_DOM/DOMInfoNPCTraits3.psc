;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMInfoNPCTraits3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMInfoNPCTraits(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


int Property hexaco_trait1 Auto
int Property hexaco_trait2 Auto
DOM_Core Property DOM01 Auto

Function DOMInfoNPCTraits(Actor akTarget)
	DOM01.DOMInfoNPCTraits3(aktarget,hexaco_trait1,hexaco_trait2)
EndFunction
