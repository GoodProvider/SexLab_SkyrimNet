;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMThugSlaveOffer Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_ThugSlaveOffer(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property DOMPotentialSlaverFaction Auto

Function DOM_ThugSlaveOffer(Actor akTarget)
	if akTarget.getFactionRank(DOMPotentialSlaverFaction) < 0
		akTarget.setFactionRank(DOMPotentialSlaverFaction,1)
	endif
	;Debug.MessageBox(akTarget.getDisplayName()+" will join you in exchange of freedom")
EndFunction
