;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PHHSHAllowActor Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
HSHUnsetActorExcluded(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property PHHSHExcludedFaction Auto

Function HSHUnsetActorExcluded(Actor akTarget)
	akTarget.RemoveFromFaction(PHHSHExcludedFaction)
EndFunction
