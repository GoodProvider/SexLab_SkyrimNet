Scriptname DOMMagicShockEffect extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM_Actor slave = DOM01.GetActor(akTarget)
	
	if slave != None
		slave.Alter_Mood("shock")
	else
		Debug.Notification("Mind shock spell has no effect on "+akTarget.getDisplayName())
	endif
EndEvent
