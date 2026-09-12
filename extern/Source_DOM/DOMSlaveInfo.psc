;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname DOMSlaveInfo Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; begin
DOMSlaveInfoBegin(akspeaker)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; end
DOMSlaveInfoEnd(akspeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto

Function DOMSlaveInfoBegin(Actor akTarget)
    ;Debug.Trace("DOMSlaveInfoBegin");
EndFunction

Function DOMSlaveInfoEnd(Actor akTarget)
    ;Debug.Trace("DOMSlaveInfoEnd");
EndFunction

