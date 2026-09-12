Scriptname DOMMagicPainEffect extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM_Actor akActor = DOM01.GetActor(akTarget)
	
	if akActor != None
		akActor.Alter_Pain(25.0) ; self.GetMagnitude()
	elseif !akTarget.IsChild()
		DOM01.DOMGenerator.Alter_Pain(akTarget,25.0)
	endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	DOM_Actor akActor = DOM01.GetActor(akTarget)
	
	if akActor != None
		akActor.Alter_Pain(-(25.0))
	elseif !akTarget.IsChild()
		DOM01.DOMGenerator.Alter_Pain(akTarget,-(25.0))
	endif
EndEvent