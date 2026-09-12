Scriptname aygasITFFunctions extends Quest  

bool Property hasITF = false Auto Hidden

Function GetSoftRequirements()
	hasITF = ((Game.GetModByname("ItortureFramework.esm") != 255) && (Game.GetFormFromFile(0x00003519, "ItortureFramework.esm") != None))
EndFunction


Function BindInFurniture(ObjectReference f, Actor slave, Actor owner)
	if !hasITF
		return
	endif
	itfCoreScript.GetAPI().UnslotFurniture(f)		; Need to remove furniture from script to pass pre-check (may not be necessary for call with owner)
	Aygas.DebugMessage("Bound slave scene:" + slave.GetDisplayName())
	if (itfCoreScript.GetAPI().CheckFurnitureIsEligible(f))
		Aygas.DebugMessage("Start ITF scene")
		itfCoreScript.GetAPI().RequestTortureSession(f, slave, owner)
	endif
EndFunction

Function IgnoreNPC(Actor victim, bool ignore)
	if !hasITF
		return
	endif
	Faction f = Game.GetFormFromFile(0x0001ef75, "ItortureFramework.esm") As Faction
	if ((f != None) && (victim != None))
		if (ignore)
			victim.SetFactionRank(f, 1)
		else
			victim.RemoveFromFaction(f)
		endif
	endif
EndFunction

aygasCoreScript Property Aygas Auto