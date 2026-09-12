Scriptname DOMMagicStunEffect extends ActiveMagicEffect  

import Game

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Trace("DOMMagicStunEffect target="+akTarget.GetDisplayName()+ "caster="+akCaster)
	if akTarget.IsUnconscious()
		Debug.Trace("Target is already unconscious "+akTarget.GetDisplayName())
		return
	endif
	if akTarget.IsChild()
		return
	endif
	float pangle = akTarget.GetHeadingAngle(akCaster) 
	if pangle < 0.0
		pangle = -pangle
	endif
	;Debug.Trace("DOMMagicStunEffect angle="+pangle)
	if pangle > 110.0 ; out of peripheral vision zone
		Debug.Notification("You manage to stun "+akTarget.GetDisplayName()+" from behind")
		;Debug.Trace("DOMMagicStunEffect set unconscious="+akTarget.GetDisplayName())
		AnimKnockout(akTarget)
		return
	endif
	;Debug.Trace("DOMMagicStunEffect detected="+akCaster.IsDetectedBy(akTarget))
	if akCaster.IsDetectedBy(akTarget)
		;if Game.GetPlayer() == akCaster
			;Debug.Notification("You were detected and failed to surprise "+akTarget.GetDisplayName())
		;endif
		return
	endif
	Debug.Notification("You manage to stun "+akTarget.GetDisplayName()+" by surprise")
	;Debug.Trace("DOMMagicStunEffect STUNNING!")
	AnimKnockout(akTarget)
EndEvent

Function AnimKnockout(Actor akTarget)
	;Debug.Notification("SetUnconscious")
	akTarget.SetUnconscious()
	akTarget.StopCombat()
	akTarget.StopCombatAlarm()
	int sleepState = akTarget.GetSleepState()
	if sleepState == 0
		;Debug.Notification("KnockOutStart")
		Debug.SendAnimationEvent(akTarget,"DOMBaboDefeatKnockOutStart")
		;Debug.SendAnimationEvent(akTarget,"RagdollInstant")
		;Debug.SendAnimationEvent(akTarget,"NPCKnockDown")
		Utility.Wait(4.0)
	endif
	;Debug.Notification("KnockOutLoop")
	Debug.SendAnimationEvent(akTarget,"DOMBaboDefeatKnockOutLoop")
	;Debug.SendAnimationEvent(akTarget,"RagdollInstant")
EndFunction