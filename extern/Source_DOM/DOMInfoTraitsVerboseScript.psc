;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMInfoTraitsVerboseScript Extends TopicInfo Hidden
Import DOM_Util

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;(pDialogueFollower as DialogueFollowerScript).SetFollower(akspeaker)
DOMInfoTraitsVerboseMessage(akspeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto

Function DOMInfoTraitsVerboseMessage(Actor akTarget)
	DOM01.NPCDialogueTraits(akTarget)
EndFunction
