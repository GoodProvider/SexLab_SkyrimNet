;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname DOMThugOrderFollow Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_ThugFollow(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_SlaverManager Property DOM01 Auto

Function DOM_ThugFollow(Actor akTarget)
	DOM_Actor thug = DOM01.GetActor(akTarget)
	
	if thug != None
		thug.EnterFollowPlayer()
	endif
EndFunction
