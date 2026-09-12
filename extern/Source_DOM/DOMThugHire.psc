;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMThugHire Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_ThugHire(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_SlaverManager Property DOM01 Auto
Faction Property DOMPotentialSlaverFaction Auto
Miscobject Property pItemGold auto

Function DOM_ThugHire(Actor akTarget)
	int amount = DOM01.DOM01.GetFeeForRecruiting(akTarget)
	if amount == 0 ; lovers will join for free
		DOM01.Recruit(akTarget)
	elseif amount > 0 ; otherwise prepare to pay
		if (Game.GetPlayer().GetGoldAmount() >= amount)
			Game.GetPlayer().RemoveItem(pItemGold, amount)
			DOM01.Recruit(akTarget)
			if amount > 100
				amount = amount / 10
			elseif amount > 10
				amount = 10
			endif
			akTarget.AddItem(pItemGold, amount)
		else
			Debug.MessageBox("You don't have enough gold to pay "+akTarget.getDisplayName())
		endif
	endif
EndFunction
