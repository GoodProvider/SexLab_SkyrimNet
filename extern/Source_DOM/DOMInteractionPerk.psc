;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname DOMInteractionPerk Extends Perk Hidden

;BEGIN FRAGMENT Fragment_13
Function Fragment_13(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMUnTieNPC(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMTieUpNPC(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMWakeUp(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMEnslave(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMBagNPC(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_SlaveManager Property DOM02 Auto
DOM_Keys Property DOMKeys Auto
Idle Property ExitBed Auto
Idle Property ExitChairFront Auto
Package Property DoNothing Auto
Faction Property DOMActionTied Auto

Function DOMWakeUp(ObjectReference akTarget)
	Actor akActor = akTarget as Actor
	if akActor == None
		return
	endif
	Debug.Trace("DOMInteract 1 "+akActor.GetDisplayName()+" unconscious="+akActor.IsUnconscious()+" sleep="+akActor.GetSleepState()+" sit="+akActor.GetSitState())
	if akActor.IsUnconscious()
		akActor.SetUnconscious(false)
		akActor.PushActorAway(akActor, 0.1)
		;Debug.SendAnimationEvent(akTarget,"DOMBaboDefeatKnockOutEnd") ; Gets back up but PushActorAway gives same result
	endif
	akActor.StopCombat()
	akActor.StopCombatAlarm()
	if akActor.GetSleepState() == 3 ; sleeping
		akActor.PlayIdle(ExitBed)
		akActor.PushActorAway(akActor, 0.1)
	elseif akActor.GetSleepState() == 2 ; going to bed
		Utility.Wait(2.0)
		akActor.PlayIdle(ExitBed)
		Utility.Wait(2.0)
	elseif akActor.GetSitState() == 3 ; sitting
		akActor.PlayIdle(ExitChairFront )
		Utility.Wait(2.0)
      elseif akActor.GetSleepState() == 2 ; about to sit
		Utility.Wait(2.0)
		akActor.PlayIdle(ExitChairFront)
		Utility.Wait(2.0)
	endif
	Debug.Trace("DOMInteract 3 "+akActor.GetDisplayName()+" unconscious="+akActor.IsUnconscious()+" sleep="+akActor.GetSleepState()+" sit="+akActor.GetSitState())
EndFunction

Function DOMBagNPC(ObjectReference akTarget)
	Actor akActor = akTarget as Actor
	if akActor == None
		return
	endif
	if akActor.IsChild()
		return
	endif
	DOMKeys.DOMDoPutInBagActor(akActor,Game.GetPlayer(),true)
EndFunction

Function DOMEnslave(ObjectReference akTarget)
	Actor akActor = akTarget as Actor
	if akActor == None
		return
	endif
	if akActor.IsChild()
		return
	endif
	if akActor.IsInFaction(DOMActionTied)
		 DOMKeys.DOMTieupActorAbduction(akActor)
		return
	endif
	DOMKeys.DOMActorAbduction(akActor)
EndFunction

Function DOMUntieNPC(ObjectReference akTarget)
	Actor akActor = akTarget as Actor
	if akActor == None
		return
	endif
	 DOMKeys.DOMUnTieActor(akActor,Game.GetPlayer())
EndFunction

Function DOMTieUpNPC(ObjectReference akTarget)
	Actor akActor = akTarget as Actor
	if akActor == None
		return
	endif
	if akActor.IsChild()
		return
	endif
	 DOMKeys.DOMTieupActor(akActor,Game.GetPlayer())
EndFunction
