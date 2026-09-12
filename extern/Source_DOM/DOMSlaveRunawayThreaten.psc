;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlaveRunawayThreaten Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMThreat1(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto

Function DOMThreat1(Actor akTarget)
	DOM_Actor sl_alias = DOM01.GetActor(akTarget)
	if sl_alias != None
		sl_alias.Interact_Punish(Game.GetPlayer(),"running away","public humiliation") ; includes threaten
	endif
EndFunction
