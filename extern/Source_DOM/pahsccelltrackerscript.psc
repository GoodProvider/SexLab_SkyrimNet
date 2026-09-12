Scriptname pahscCellTrackerScript extends activemagiceffect  

ObjectReference Property invisibleObject auto
 
Event OnEffectStart(Actor akTarget, Actor akCaster)
;	debug.notification("Teleport target: " + akTarget.GetDisplayName() + " caster: " + akCaster.GetDisplayName())
	RSH.RiderFrontRef.ForceRefTo(akCaster)
	if (akCaster.IsOnMount())
		RSH.RemountOnTeleport() ; akCaster)
	else
		utility.wait(3)						; Allow time after teleport
		RSH.Dismount() ; akCaster, false)
	endif
	Utility.Wait(0.1)
	invisibleObject.MoveTo(akCaster)
EndEvent

pahscPackHorseScript Property RSH Auto
