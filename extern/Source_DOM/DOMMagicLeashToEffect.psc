Scriptname DOMMagicLeashToEffect extends activemagiceffect  
; This is a modified version of PAH leash to effect

DOM_Core Property DOM01 Auto
PAHActorAlias slave_actor_alias
DOM_Actor DOM_actor_alias
Actor slave_actor_ref
Form Property DOMLeashPoint Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		return
	endif
	ObjectReference leash_point = None

	if DOM01.DOMPAH.isPAH(akTarget)
		slave_actor_alias = DOM01.DOMPAH.GetSlaveAlias(akTarget)
		if slave_actor_alias != None
			slave_actor_ref = slave_actor_alias.GetActorRef()
			leash_point = slave_actor_alias.leash_point
			DOM_actor_alias = None
		endif
	endif
	
	if leash_point == None
		slave_actor_alias = None
		DOM_actor_alias = DOM01.GetActor(akTarget)
		if DOM_actor_alias != None
			slave_actor_ref = DOM_actor_alias.akRef
			leash_point = DOM_actor_alias.leash_point
		else
			slave_actor_ref = None
  			return
		endif
	endif

	DOM01.clearing_leash_point = true
	RegisterForSingleUpdate(0.2)
EndEvent

Event OnUpdate()
	if DOM01.clearing_leash_point
		ClearCurrentLeashPoint()
	else
		SetNewLeashPoint()
	endif
EndEvent

Function ClearCurrentLeashPoint()
	ObjectReference leash_point = None
	if DOM_actor_alias != None
		leash_point = DOM_actor_alias.leash_point
     else
		leash_point = slave_actor_alias.leash_point
	endif

	DOMLeashPointScript current_leash_point = leash_point as DOMLeashPointScript
	if current_leash_point != None
		current_leash_point.ClearAndRemove()
	endif
	if DOM_actor_alias != None
		DOM_actor_alias.leash_point = None
     else
		slave_actor_alias.leash_point = None
	endif
EndFunction

Function SetNewLeashPoint()	
	ObjectReference leash_point = Game.FindClosestReferenceOfTypeFromRef(DOMLeashPoint as Form,  slave_actor_ref, 300.0)
	if DOM_actor_alias != None
		DOM_actor_alias.leash_point =  leash_point 
     else
		slave_actor_alias.leash_point =  leash_point 
	endif
EndFunction
