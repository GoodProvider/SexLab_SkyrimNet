;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMThugOffer Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
DOM_ThugOffer(akSpeaker)
;
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto
Faction Property DOMPotentialSlaverFaction Auto

Function DOM_ThugOffer(Actor akTarget)
	DOM01.DOMGenerator.GetNPCTraitsUpdateModifiers(akTarget) ; Needs to update modifiers to get potential slaver status

	int amount = DOM01.GetFeeForRecruiting(akTarget)
	if amount > 0
		Debug.MessageBox(akTarget.getDisplayName()+" will join you for "+amount+" gold")
	elseif amount == 0
		akTarget.setFactionRank(DOMPotentialSlaverFaction,1)
		Debug.MessageBox(akTarget.getDisplayName()+" will join you for free")
	else
		Debug.MessageBox(akTarget.getDisplayName()+" does not feel like it anymore")
	endif
EndFunction
