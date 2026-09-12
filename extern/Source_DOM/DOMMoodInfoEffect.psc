Scriptname DOMMoodInfoEffect extends activemagiceffect  
Import DOM_Util

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.trace("DOMMoodInfoEffectScript: "+akTarget)
	if akTarget == None
		return
	endif
	string msg = ""

	if DOM01.DOMPAH.isPAH(akTarget)
		;Debug.trace("DOMMoodInfoEffectScript: "+akTarget.getDisplayName()+" is a PAHSlave")
		msg = DOM01.DOMPAH.MoodInfo(akTarget)
	endif
    if msg == ""
		DOM_Actor akActor = DOM01.GetActor(akTarget)
		if akActor != None
			;Debug.trace("DOMMoodInfoEffectScript: "+akActor.getName()+" is a DOM_Actor")
			msg = DOM01.DOMMoodInfo(akActor)
		else
			;Debug.trace("DOMMoodInfoEffectScript: "+akTarget.getDisplayName()+" is another NPC")
			msg = DOM01.NPCMoodMessage(akTarget)
		endif
	endif
	if msg != ""
		SendMessage(msg)
	endif
EndEvent

