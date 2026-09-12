;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMNPCInBag Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMBagNPC(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


DOM_Keys Property DOMKeys Auto

Function DOMBagNPC(Actor akTarget)
	if akTarget == None
		return
	endif
	if akTarget.IsChild()
		return
	endif
	DOMKeys.DOMDoPutInBagActor(akTarget,Game.GetPlayer(),true)
EndFunction
