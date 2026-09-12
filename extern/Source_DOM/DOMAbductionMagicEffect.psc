Scriptname DOMAbductionMagicEffect extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto
DOM_SlaveManager Property DOM02 Auto
Faction Property DOMBeingCaptured Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Trace("DOMAbductionMagicEffect: OnEffectStart")
	if akTarget == None || akTarget.IsChild()
		;Debug.Trace("DOMAbductionMagicEffect: Wrong target="+akTarget)
		return
	endif	
	if akTarget.IsInFaction(DOMBeingCaptured)
		;Debug.Trace("DOMAbductionMagicEffect: Target already being captured="+akTarget)
		return
	endif	
	akTarget.SetFactionRank(DOMBeingCaptured,2)
	DOM_Actor akActor = DOM02.Capture(akTarget,"BleedOutStart")
	if akActor == None
		 akTarget.RemoveFromFaction(DOMBeingCaptured)
		 return
	endif
    akActor.mind.TrainAnger(20.0)  ; Anger boost for undead capture
EndEvent
