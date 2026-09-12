;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlaveSex4Gang Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_SlaveSexJoin(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto

Function DOM_SlaveSexJoin(Actor akTarget)
	DOM_Actor actor_alias = DOM01.GetActor(akTarget)
	
	if actor_alias != None
		actor_alias.Dialogue_StartSexWith(4) ; type 4 = foursome
	endif
EndFunction
