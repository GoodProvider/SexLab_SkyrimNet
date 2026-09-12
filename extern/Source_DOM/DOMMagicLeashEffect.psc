Scriptname DOMMagicLeashEffect extends activemagiceffect  
; This is a modified version of PAH Leash Effect

Float Property update_timer = 0.5 Auto Hidden
Float Property refire_timer = 3.0 Auto Hidden
Float Property launch_z_lift = 0.0 Auto Hidden
Float Property launch_force = 300.0 Auto Hidden
Float Property leash_distance = 300.0 Auto Hidden

DOM_Core Property DOM01 Auto
;Sound Property leash_link_sound Auto

PAHActorAlias slave_actor_alias
DOM_Actor DOM_actor_alias
Actor slave_actor_ref

Static Property XMarkerHeading Auto
Explosion Property LeashFieldExplosion Auto
Spell Property LeashStaggerSpell Auto
Spell Property LeashSoundSpell Auto

ObjectReference explosion_ref
ObjectReference explosion_marker
ObjectReference link_cast_source

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		return
	endif
	ObjectReference leash_point = None

	if DOM01.DOMPAH.isPAH(aktarget)
		slave_actor_alias = DOM01.DOMPAH.GetSlaveAlias(akTarget)
		if slave_actor_alias != None
			DOM_actor_alias = None
			slave_actor_ref = slave_actor_alias.GetActorRef()
			leash_point = slave_actor_alias.leash_point
		endif
	endif

	if leash_point == None
	      slave_actor_alias = None
		DOM_actor_alias = DOM01.GetActor(akTarget)
		if DOM_actor_alias != None
			slave_actor_ref = DOM_actor_alias.akRef
			leash_point = DOM_actor_alias.leash_point
		  else
			slave_actor_ref =None
			return
		endif
      endif

	PlayLinkFX(false,leash_point)
	RegisterForSingleUpdate(update_timer)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnRegisterForUpdate()
	if explosion_ref != None
		explosion_ref.Delete()
	endif
	if explosion_marker != None
		explosion_marker.Delete()
	endif
	if link_cast_source != None
		link_cast_source.Delete()
	endif
EndEvent

Event OnUpdate()
	ObjectReference leash_point = None
	if DOM_actor_alias != None
		 leash_point = DOM_actor_alias.leash_point
  	elseif slave_actor_alias != None
		 leash_point = slave_actor_alias.leash_point
    endif
    if leash_point == None
		return
    endif
		
	if slave_actor_ref.GetDistance(leash_point) > leash_distance
		HandleSlaveOutOfRange(leash_point)
	else
		if Utility.RandomFloat() < 0.4
			; PlayLinkFX(false,leash_point)
		endif
		RegisterForSingleUpdate(update_timer)
	endif
EndEvent

Function HandleSlaveOutOfRange(ObjectReference leash_point)
	PlayLinkFX(false,leash_point)
	PlayLeashFieldFX(leash_point)

	float zOffset = slave_actor_ref.GetHeadingAngle(leash_point)
	if !(zOffset < 90 && zOffset > -90)
		RepelByStagger()
	else
		RepelByLaunch(leash_point)
	endif
	if DOM_actor_alias != None
		DOM_actor_alias.OnLeashEffect()
      else
		slave_actor_alias.OnLeashEffect()
 	endif
	RegisterForSingleUpdate(refire_timer)
EndFunction

Function PlayLeashFieldFX(ObjectReference leash_point)
	if explosion_ref != None
		explosion_ref.Disable()
		explosion_ref.Delete()
	endif

	if explosion_marker == None
		explosion_marker = slave_actor_ref.PlaceAtMe(XMarkerHeading)
	endif

	explosion_marker.MoveTo(slave_actor_ref)
	float zOffset = explosion_marker.GetHeadingAngle(leash_point)
	explosion_marker.SetAngle(0, 0, explosion_marker.GetAngleZ() + zOffset)
	explosion_ref = explosion_marker.PlaceAtMe(LeashFieldExplosion)
EndFunction

Function RepelByStagger()
	LeashStaggerSpell.Cast(slave_actor_ref)
EndFunction

Function RepelByLaunch(ObjectReference leash_point)
	Float delta_x = slave_actor_ref.GetPositionX() - leash_point.GetPositionX()
	Float delta_y = slave_actor_ref.GetPositionY() - leash_point.GetPositionY()

	;# Normalise to max delta of 1
	Float divider
	Float pos_delta_x = delta_x
	Float pos_delta_y = delta_y
	if pos_delta_x < 0
		pos_delta_x = 0 - pos_delta_x
	endif
	if pos_delta_y < 0
		pos_delta_y = 0 - pos_delta_y
	endif
	if pos_delta_x > pos_delta_y
		divider = pos_delta_x
	else
		divider = pos_delta_y
	endif
	delta_x = delta_x/divider
	delta_y = delta_y/divider

	delta_x = 0 - delta_x
	delta_y = 0 - delta_y

	slave_actor_ref.PushActorAway(slave_actor_ref, 0)
	Utility.Wait(0.05)
	slave_actor_ref.ApplyHavokImpulse(delta_x, delta_y, launch_z_lift, launch_force)
EndFunction

Function PlayLinkFX(bool with_pull_fx, ObjectReference leash_point)
	; if link_cast_source != None
	; 	link_cast_source.Delete()
	; endif
	; link_cast_source = slave_actor_ref.PlaceAtMe(XMarkerHeading)
	; link_cast_source.SetPosition(link_cast_source.GetPositionX(), link_cast_source.GetPositionY(), link_cast_source.GetPositionZ() + 110)

	LeashSoundSpell.Cast(leash_point, slave_actor_ref)
EndFunction
