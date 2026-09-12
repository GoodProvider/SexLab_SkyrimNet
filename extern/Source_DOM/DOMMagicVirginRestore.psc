Scriptname DOMMagicVirginRestore extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM_Actor slave = DOM01.GetActor(akTarget)
	
	if slave != None
		slave.Alter_Virginity()
	elseif !akTarget.IsChild()
		DOM01.DOMGenerator.Alter_Virginity(akTarget)
	endif
EndEvent
