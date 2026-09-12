Scriptname BB_Access_DOM extends quest

DOM_Core Property DOM01 Auto
Faction Property DOMPlayerSlaveFaction Auto
Faction Property DOMPlayerSlaverFaction Auto
Faction Property BB_WasDOMSlaveFaction Auto
Faction Property BB_WasDOMSlaverFaction Auto

Function SetProperties()
	if (Game.GetModByName("DiaryOfMine.esm") != 255)
		if DOM01 == None
			DOM01 = Game.GetFormFromFile(0x000D61, "DiaryOfMine.esm") As DOM_Core
			DOMPlayerSlaveFaction = DOM01.DOMPlayerSlaveFaction
			DOMPlayerSlaverFaction = DOM01.DOMPlayerSlaverFaction
			BB_WasDOMSlaveFaction = Game.GetFormFromFile(0x000BBC, "TDF Enhanced Prostitution.esp") As Faction
			BB_WasDOMSlaverFaction = Game.GetFormFromFile(0x000BBD, "TDF Enhanced Prostitution.esp") As Faction
		endif
	else
		DOM01 = None
	endif
EndFunction

Function ReleaseSlave(Actor Hooker)
	SetProperties()
	if DOM01 != None
		if (Hooker != NONE && Hooker.IsInFaction(DOMPlayerSlaveFaction))
			Debug.Notification("Diary Of Mine Slave detected. Releasing Slave from DoM...")
			Hooker.AddToFaction(BB_WasDOMSlaveFaction)
			DOM01.ReleaseSlave(Hooker)
			Hooker.EvaluatePackage()
		elseif (Hooker != NONE && Hooker.IsInFaction(DOMPlayerSlaverFaction))
			Debug.Notification("Diary Of Mine Slaver detected. Releasing Slave from DoM...")
			Hooker.AddToFaction(BB_WasDOMSlaverFaction)
			DOM01.ReleaseSlaver(Hooker)
			Hooker.EvaluatePackage()
		endif
 	EndIf
EndFunction

Function AddSlave(Actor Hooker)
	SetProperties()
	if DOM01 != None
		if (Hooker != NONE && Hooker.IsInFaction(BB_WasDOMSlaveFaction))
			Debug.Notification("Diary of Mine ex-Slave detected. Adding back into DoM...")
			Hooker.RemoveFromFaction(BB_WasDOMSlaveFaction)
			DOM01.AddSlave(Hooker)
		elseif (Hooker != NONE && Hooker.IsInFaction(BB_WasDOMSlaverFaction))
			Debug.Notification("Diary of Mine ex-Slaver detected. Adding back into DoM...")
			Hooker.RemoveFromFaction(BB_WasDOMSlaverFaction)
			DOM01.AddSlaver(Hooker)
		endif
 	EndIf
EndFunction

Function DOM_LoadSlave(Actor akTarget)
	SetProperties()
	if DOM01 != None
		DOM_Actor slave = DOM01.GetActor(akTarget)	
		if slave != None
			slave.SetTrainerFromDialogue()
		endif
	endif
EndFunction


