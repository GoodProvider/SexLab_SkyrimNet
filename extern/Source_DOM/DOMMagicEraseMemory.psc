Scriptname DOMMagicEraseMemory extends ActiveMagicEffect  


import Game

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM_Actor slave = DOM01.GetActor(akTarget)
	
	akTarget.StopCombatAlarm()
	if slave != None
		slave.mind.EraseMemory() ; self.GetMagnitude()
	elseif !akTarget.IsChild()
		DOM01.DOMGenerator.EraseMemoryActor(akTarget)
	endif
EndEvent

