;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname DOMSlaveUntie Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_SlaveUntie(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto
Actor Property PlayerRef Auto

Function DOM_SlaveUntie(Actor akTarget)
	DOM01.DOMKeys.DOMDoUntie(akTarget)
EndFunction
