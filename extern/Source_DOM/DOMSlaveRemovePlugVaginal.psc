;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlaveRemovePlugVaginal Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
 DOM_SlavePlug(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
DOM_Core Property DOM01 Auto

Function DOM_SlavePlug(Actor akTarget)
	DOM01.DOMKeys.DOMDoRemovePlug(akTarget,true) ; true = vaginal
EndFunction
