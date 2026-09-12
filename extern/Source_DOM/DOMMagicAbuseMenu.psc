Scriptname DOMMagicAbuseMenu extends activemagiceffect  


DOM_Keys Property DOMKeys Auto
Faction Property DOMBeingCaptured Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget != None &&  akTarget.IsInFaction(DOMBeingCaptured)
		return
	endif
	DOMKeys.DOMDoCallMenu(akTarget)
EndEvent