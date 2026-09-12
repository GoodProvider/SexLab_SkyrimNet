;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMInfoNPCFeelings3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMInfoNPCFeelings(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


int Property training_stat Auto
DOM_Core Property DOM01 Auto

Function DOMInfoNPCFeelings(Actor akTarget)
	DOM01.DOMInfoNPCFeelings3(aktarget,training_stat)
EndFunction

