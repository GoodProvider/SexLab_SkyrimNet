Scriptname DOMMagicPersonaWrite extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM01.DOMGenerator.WriteActorJSON(akTarget)
EndEvent
