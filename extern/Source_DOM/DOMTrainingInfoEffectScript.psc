Scriptname DOMTrainingInfoEffectScript extends activemagiceffect 
; This is a modified version of PAH TrainingInfo spell
Import DOM_Util

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.trace("DOMTrainingInfoEffectScript: "+akTarget)
	if akTarget == None
		return
	endif
	;Debug.trace("DOMTrainingInfoEffectScript: "+akTarget.getDisplayName())
	string msg
	
	if DOM01.DOMPAH.isPAH(akTarget)
		;Debug.trace("DOMTrainingInfoEffectScript: "+akTarget.getDisplayName()+" is a PAHSlave")
		msg = DOM01.DOMPAH.TrainingMessage(akTarget)
	else
		DOM_Actor akActor = DOM01.GetActor(akTarget)
		if akActor != None
			;Debug.trace("DOMTrainingInfoEffectScript: "+akActor.getName()+" is a DOM_Actor")
			msg = DOM01.DOMTrainingMessage(akActor)
		else
			;Debug.trace("DOMTrainingInfoEffectScript: "+akTarget.getDisplayName()+" is not registered, using NPC factions")
			msg = DOM01.NPCTrainingMessage(akTarget)
		endif
	endif
	
	if msg == ""
		msg = DOM01.GetSlaveType(akTarget)+" "+akTarget.getDisplayName()+" Untrained"
	endif
	SendMessage(msg)
EndEvent
