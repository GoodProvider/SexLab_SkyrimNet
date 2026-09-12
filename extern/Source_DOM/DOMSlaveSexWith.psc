;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMSlaveSexWith Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_ActorSexWith(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto

Function DOM_ActorSexWith(Actor akTarget)
	DOM_Actor actor_alias = DOM01.GetActor(akTarget)
	
	if actor_alias != None
		actor_alias.Dialogue_StartSexWith(1) ; type 1 = gentle sex
	endif
EndFunction
