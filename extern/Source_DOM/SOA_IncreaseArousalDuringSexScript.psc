Scriptname SOA_IncreaseArousalDuringSexScript extends Quest  

GlobalVariable			Property SOA_IsInSexSceneGlobal		Auto
Spell					Property SOA_FortifyArousalSpell	Auto
actor	ThisActor

Function IncreaseArousalDuringSex(actor CumActor)
	ThisActor = CumActor
	registerForSingleUpdate(20.0 + (20.0 * utility.randomFloat(0.01, 1.0)))
EndFunction

Event OnUpdate()
	if ThisActor == None
		return
	endif
	if SOA_IsInSexSceneGlobal.getValue() == 1.0
		if ThisActor.Is3DLoaded()
			SOA_FortifyArousalSpell.cast(ThisActor, ThisActor)
		endif
		registerForSingleUpdate(20.0 + (20.0 * utility.randomFloat(0.05, 1.0)))
	endIf
EndEvent
