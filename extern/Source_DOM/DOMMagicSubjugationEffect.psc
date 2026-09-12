Scriptname DOMMagicSubjugationEffect extends ActiveMagicEffect  

import Game

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM_Actor akActor = DOM01.GetActor(akTarget)
	
	akTarget.StopCombatAlarm()
	if akActor != None
		akActor.Alter_Training(100.0)
		;Debug.Trace("DOMMagicSubjugationEffect::OnEffectStart mag="+GetMagnitude())
	elseif !akTarget.IsChild()
		DOM01.DOMGenerator.Alter_Training(akTarget,100.0)
	endif
EndEvent

;Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Trace("DOMMagicSubjugationEffect::OnEffectFinish mag="+GetMagnitude())
;EndEvent
