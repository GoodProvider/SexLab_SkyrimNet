Scriptname DOMMagicSpellBound extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto
DOM_SlaveManager Property DOM02 Auto
Faction Property DOMBeingCaptured Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == None || akTarget.IsChild()
		return
	endif	
	If !DOM01.IsWeaponCaptureAllowed(akTarget)
		return
	endif
	if akTarget.IsInFaction(DOMBeingCaptured)
		return
	endif	
	akTarget.SetFactionRank(DOMBeingCaptured,2)
	DOM_Actor akActor = DOM02.Capture(akTarget,"BleedOutStart")
	if akActor == None
		 akTarget.RemoveFromFaction(DOMBeingCaptured)
		 return
	endif
	akActor.mind.TrainFear(20.0)  ; Fear boost for magic capture
EndEvent
