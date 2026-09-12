Scriptname BB_Access_PAHE extends quest

PAHCore Property PAH Auto
PHHSHStorageFunctions Property PHSF Auto
Faction Property PAHPlayerSlaveFaction Auto
Faction Property PAHHasBeenPlayerSlaveFaction Auto

Function SetProperties()
	if (Game.GetModByName("paradise_halls.esm") != 255)
		if PAH == None 	
			PAH = Game.GetFormFromFile(0x01FAEF, "paradise_halls.esm") As PAHCore
			PAHPlayerSlaveFaction = PAH.PAHPlayerSlaveFaction
			PAHHasBeenPlayerSlaveFaction = PAH.PAHHasBeenPlayerSlaveFaction
		endif
	else
		PAH = None
	endif
	If (Game.GetModByName("PAH_HomeSweetHome.esp") != 255)
		PHSF = Game.GetFormFromFile(0x00008402, "PAH_HomeSweetHome.esp") As PHHSHStorageFunctions
	else
		PHSF = None
	endif
EndFunction

Function ReleaseSlave(Actor Hooker)
	SetProperties()
	if PAH != None
		if (Hooker != NONE && Hooker.IsInFaction(PAHPlayerSlaveFaction))
			Debug.Notification("paradise halls Slave detected")
            ReferenceAlias rHooker = PAH.GetSlaveAlias(Hooker)
			PAH.RemoveSlave(rHooker)
			Hooker.EvaluatePackage()
		endif
 	EndIf
EndFunction

Function AddSlave(Actor Hooker)
	SetProperties()
	if PAH != None
		if (Hooker != NONE && Hooker.IsInFaction(PAHHasBeenPlayerSlaveFaction))
			Debug.Notification("paradise halls ex-Slave detected")
			PAH.AddSlave(Hooker)
		endif
 	EndIf
EndFunction

Function HSHTempCampShit(actor aActor)
	SetProperties()
	PHSF.LockupInTempCamp(aActor)
endFunction

