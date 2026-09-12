Scriptname DOMMagicPersonaRestore extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM_Actor slave = DOM01.GetActor(akTarget)
	
	if slave != None
		slave.Restore_Persona()
	elseif !akTarget.IsChild()
		DOM01.DOMGenerator.Restore_Persona(akTarget)
	endif
EndEvent
