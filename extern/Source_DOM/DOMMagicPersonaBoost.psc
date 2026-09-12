Scriptname DOMMagicPersonaBoost extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM_Actor slave = DOM01.GetActor(akTarget)
	
	if slave != None
		slave.Alter_Persona(25.0) ; self.GetMagnitude()
	elseif !akTarget.IsChild()
		DOM01.DOMGenerator.Alter_Persona(akTarget,25.0)
	endif
EndEvent
