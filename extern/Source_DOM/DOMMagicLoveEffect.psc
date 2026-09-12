Scriptname DOMMagicLoveEffect extends ActiveMagicEffect  

import Game

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	DOM_Actor slave = DOM01.GetActor(akTarget)
	
	akTarget.StopCombatAlarm()
	if slave != None
		slave.Alter_Mood("inlove")
	else
		if akTarget.IsChild()
			akTarget.setRelationshipRank(Game.getPlayer(), 3)
		else
			akTarget.setRelationshipRank(Game.getPlayer(), 4)
			Debug.Notification(akTarget.getDisplayName()+" looks at you in a different way")
		endif
	endif
EndEvent

