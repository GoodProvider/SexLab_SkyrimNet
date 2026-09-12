Scriptname PAHFSCResetTriggerScript extends ObjectReference  

PAHFellglowSlaveCampQuest Property the_quest Auto

Event onTriggerEnter(objectReference akTriggerRef)
	if (akTriggerRef == Game.GetPlayer() as ObjectReference)
		the_quest.OnResetTriggerEnter()
	endif
EndEvent
