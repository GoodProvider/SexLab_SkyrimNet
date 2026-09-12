;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlavePunish6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMPunish1(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto

Function DOMPunish1(Actor akTarget)
	DOM_Actor sl_alias = DOM01.GetActor(akTarget)
	if sl_alias != None
		sl_alias.StartPunishing(Game.getPlayer(),"yelling")
	endif
EndFunction
