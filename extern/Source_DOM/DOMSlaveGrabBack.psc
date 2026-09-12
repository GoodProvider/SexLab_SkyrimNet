;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlaveGrabBack Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
 DOM_SlaveGrabBack(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto

Function DOM_SlaveGrabBack(Actor akTarget)
	DOM01.DOMKeys.DOMDoGrab(akTarget,"Back")
EndFunction
