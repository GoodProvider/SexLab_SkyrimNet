Scriptname DOMMagicPose extends ActiveMagicEffect  

DOM_Core Property DOM01 Auto
Int Property PoseId Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == None
		return
	endif
	if PoseID == 1
		Debug.Trace("DOMMagicPose:Animation: OnEffectStart() "+DOM01.spellPose1)
		Debug.SendAnimationEvent(akTarget, DOM01.spellPose1)
	else
		Debug.Trace("DOMMagicPose:Animation: OnEffectStart() "+DOM01.spellPose2)
		Debug.SendAnimationEvent(akTarget, DOM01.spellPose2)
	endif	
EndEvent
