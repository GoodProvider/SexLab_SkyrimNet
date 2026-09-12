;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlaveInFurniture1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_SlaveRestrainInFurniture(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto
Actor Property PlayerRef Auto

Function DOM_SlaveRestrainInFurniture(Actor akTarget)
	DOM01.DOMKeys.DOMCrossByIndex(akTarget,0,false,false) ; ZazAPCAO025"
EndFunction
