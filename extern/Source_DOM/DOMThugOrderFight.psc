;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMThugOrderFight Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_ThugOrderFight(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_SlaverManager Property DOM01 Auto

Function DOM_ThugOrderFight(Actor akTarget)
	DOM_Actor thug = DOM01.GetActor(akTarget)
	
	if thug != None
		thug.mind.should_fight_for_player = true
	endif
EndFunction
