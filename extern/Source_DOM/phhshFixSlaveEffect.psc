Scriptname phhshFixSlaveEffect extends activemagiceffect  

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	debug.notification("Fixing slave " + akTarget.GetDisplayName())	
	phhshHouseSlave slot = (PHHSH as phhshStorageFunctions).SlaveRef(akTarget)
	if (slot != None)
		slot.AfterAssignWithType(0) ; 0 means get from faction
	else
		debug.notification("Not a HSH slave")
	endif
EndEvent

Quest Property PHHSH Auto 