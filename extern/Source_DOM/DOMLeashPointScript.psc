Scriptname DOMLeashPointScript extends ObjectReference  

DOM_Core Property DOM01 Auto

Event OnLoad()
	RegisterForSingleUpdate(0.5)
EndEvent

Event OnUpdate()
	if DOM01.IsLeashPointInUse(self)
		return
	endif
	Remove() ; remove if not in use
EndEvent

Function ClearAndRemove()
	DOM01.ClearLeashPoint(self)
	Remove()
EndFunction

Function Remove()
	Disable()
	Utility.Wait(4.0)
	Delete()
EndFunction
