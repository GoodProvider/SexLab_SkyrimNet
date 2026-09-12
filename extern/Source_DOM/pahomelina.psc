Scriptname PAHOMelina extends ReferenceAlias  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
;	debug.trace("Location changed:" + akNewLoc.GetName())
;	debug.notification("Location changed:" + akNewLoc.GetName())
	QF_PAHOKidnapping_060228C3 qst = GetOwningQuest() as QF_PAHOKidnapping_060228C3
	if ((qst.GetStage() >= 80) && (qst.GetStage() < 90))
		if ((akNewLoc == BluePalace) && (akOldLoc != BluePalace) )
			qst.SetObjectiveFailed(80)
			utility.wait(2)
			qst.Reset()
			qst.SetStage(71)
			qst.SetObjectiveDisplayed(70, false)
			GetActorRef().EvaluatePackage()
;			debug.trace("Failed")
;			debug.notification("Failed")
		elseif (akNewLoc == WinkingSkeever)
;			debug.trace("Arrived")
;			debug.notification("Arrived")
			RegisterForSingleUpdate(60)		; Prevent quest from failing instantly if player waits in the palace for Melina to leave
		endif
	elseif ((qst.GetStage() >= 100) && (qst.GetStage() <= 102))
		SubdueStage = 2
		utility.wait(3)
		GetActorRef().UnequipItem(qst.Rope)
		utility.wait(0.2)
		GetActorRef().EquipItem(qst.Rope, true, true)
	endif
EndEvent

Function CheckStatus()
	Actor akRef = GetActorRef()
	if SubdueType != 1
		if akRef.HasMagicEffect(Para1) || akRef.HasMagicEffect(Para2) || akRef.HasMagicEffect(Para3)
			SubdueType = 2 ; paralyzed
		elseif akRef.IsUnconscious()
			SubdueType = 4 ; unconscious
		elseif akRef.GetSleepState() == 3
			SubdueType = 3 ; sleeping
		endif
	endif
		
	UnregisterForUpdateGameTime()
	SubdueStage = 0
	RegisterForSingleUpdateGameTime(0.5)
EndFunction

Function AdministerPoison()
	UnregisterForUpdateGameTime()
	SubdueType = 1 ; poison
	SubdueStage = 0
	RegisterForSingleUpdateGameTime(0.5)
EndFunction

Event OnUpdateGameTime()
	if SubdueType == 0
		return
	endif
	if SubdueType != 1 ; only for poison
		return
	endif
	if SubdueStage == 0
		if SubdueType == 1
			SubdueStage = 2
			debug.notification("Melina seems to be recovering from the potion's effect")
		endif
		RegisterForSingleUpdateGameTime(0.5)
	elseif SubdueStage == 1
		debug.notification("Melina calls for help!")
		GetOwningQuest().SetStage(101)
		GetActorRef().SendAssaultAlarm()
		CrimeFaction.ModCrimeGold(100, true)
	else
		if SubdueType == 1
			debug.notification("Melina has recovered from the effects of the poison")
		endif
		SubdueType = 0
		GetOwningQuest().SetStage(101)
	endif
EndEvent

Event OnUpdate()
;	debug.trace("returning")
;	debug.notification("returning")
	Quest qst = GetOwningQuest()
	GetOwningQuest().SetStage(81)		; Walk home
	GetActorRef().EvaluatePackage()
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
;	debug.notification("Combat state")
	Quest qst = GetOwningQuest()
	if ((qst.GetStage() >= 80) && (qst.GetStage() < 90))	
		qst.SetStage(85)
	endif
EndEvent

Event OnLoad()
;	debug.Notification("Attached")
	QF_PAHOKidnapping_060228C3 qst = GetOwningQuest() as QF_PAHOKidnapping_060228C3
	if (qst.GetStage() >= 100)
		utility.wait(3)
		GetActorRef().UnequipItem(qst.Rope)
		utility.wait(0.2)
		GetActorRef().EquipItem(qst.Rope, true, true)
	endif
EndEvent

Location Property BluePalace Auto
Location Property WinkingSkeever Auto
bool inhibit = false

MagicEffect Property Para1 Auto
MagicEffect Property Para2 Auto
MagicEffect Property Para3 Auto
int Property SubdueType Auto Hidden
int Property SubdueStage Auto Hidden
Faction Property CrimeFaction Auto
Faction Property Submission Auto

