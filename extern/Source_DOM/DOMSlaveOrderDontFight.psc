;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlaveOrderDontFight Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_SlaveOrderNoFight(akSPeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


DOM_Core Property DOM01 Auto

Function DOM_SlaveOrderNoFight(Actor akTarget)
	DOM01.CommandNoLongerDoCombat(akTarget)
EndFunction
