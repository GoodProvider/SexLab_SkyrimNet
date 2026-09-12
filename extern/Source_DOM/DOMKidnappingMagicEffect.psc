Scriptname DOMKidnappingMagicEffect extends ActiveMagicEffect  

DOM_Keys Property DOMKeys Auto
Faction Property DOMBeingCaptured Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == None || akTarget.IsChild()
		return
	endif	
	if akTarget.IsInFaction(DOMBeingCaptured)
		return
	endif	
	DOMKeys.DOMActorAbduction(akTarget)
EndEvent

