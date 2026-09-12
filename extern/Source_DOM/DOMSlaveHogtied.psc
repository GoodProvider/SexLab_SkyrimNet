;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlaveHogtied Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_SlaveTieUp(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto
Actor Property PlayerRef Auto

Function DOM_SlaveTieUp(Actor akTarget)
	DOM01.DOMKeys.DOMTiedUpByIndex(akTarget,3,false,false) ; ZazAPCAO052 ZazAPCAO053
EndFunction
