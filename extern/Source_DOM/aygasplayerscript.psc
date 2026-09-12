Scriptname aygasPlayerScript extends ReferenceAlias  

;Event OnCellAttach(	)
;	Debug.Notification("Player cell attached")
;EndEvent

Event OnPlayerLoadGame()
	Debug.Trace("AYGAS started, version " + Aygas.Version())
	Aygas.ZoneTime = Utility.GetCurrentRealTime()
	Aygas.GetSoftRequirements()
	Aygas.CheckSlavesNearPlayer()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	UnregisterForUpdate()		; Was inside iswaiting if
	Aygas.ZoneTime = Utility.GetCurrentRealTime()
	Aygas.CheckVersion()

	Aygas.IsPlayerHouse()		; On zoning, check if in player home
	Aygas.Scenes.ClearScenes()
	Aygas.EventFunctions.EventPlayerZoning()

	Game.GetPlayer().RemoveFromFaction(Aygas.JobOverrideAction)

	if (akNewLoc != None)
		Aygas.EventFunctions.EvaluateSlaveryLevel(akNewloc)
		Aygas.LocationEligibleForProstitution(Game.GetPlayer(), true)

		if ((Aygas.EventFunctions.EventStage >= 4) && (!Aygas.EventFunctions.SceneMarker.GetRef().GetParentCell().IsAttached()) )
			; Zoned out of event location, cancel event
			Aygas.EventFunctions.StopEvent()
		elseif ((Aygas.EventFunctions.EventStage == -1) && (!Aygas.EventFunctions.SceneMarker.GetRef().GetParentCell().IsAttached()) )
			; Zoned out of event location, tear down event
			Aygas.EventFunctions.StopEvent()		
		elseif ((Aygas.EventFunctions.EventStage == 1) && (!Aygas.EventFunctions.SceneMarker.GetRef().GetParentCell().IsAttached()) )
			; Event needs to be set up and player is elsewhere, do it now.
			Aygas.EventFunctions.SetupEvent()
		elseif ((Aygas.EventFunctions.EventStage == 2) && (akNewLoc == Aygas.EventFunctions.EventLocation  ))
			Aygas.EventFunctions.PropsScript.MoveSet(Aygas.EventFunctions.EventLocationCode)
		endif
	endif

	if (!isWaiting)
;		isWaiting = true
		Utility.Wait(1)	; was 5
		ProcessOwners(true)		
		isWaiting = false
		FindPotentialNewOwner()

		RegisterForUpdate(60)
	else
		RegisterForUpdate(10)		
	endif
EndEvent

Event OnUpdate()
	ProcessOwners(false)
	Aygas.CheckSlavesNearPlayer()
	isWaiting = false
EndEvent

Function ProcessOwners(bool isZoning)
	; Check slave owners in zone
	; Slot slaves
	Actor[] deleteOwners = new Actor[100];
	int d = 0
	int i = StorageUtil.FormListCount(none, "aygasOwners")
	Aygas.DebugLog("Tracking " + i + " owners")

	while(i > 0)
		; Process attached owners first
		i-=1
		Actor a = StorageUtil.FormListGet(none, "aygasOwners", i) as Actor
		if ((a != none) && (!a.IsDeleted()) && (!a.IsDead()) )
			if ((a.GetParentCell() != None ) && (a.GetParentCell().IsAttached()))
				Aygas.DebugLog("Tracking " + a.GetDisplayName() + "  " + a.GetParentCell())
				Aygas.ProcessOwner(a, isZoning)
			endif
		endif
	endwhile

	i = StorageUtil.FormListCount(none, "aygasOwners")
	Aygas.DebugLog("Tracking " + i + " owners")
	while(i > 0)
		; Process unattached owners
		i-=1
		Actor a = StorageUtil.FormListGet(none, "aygasOwners", i) as Actor
		if ((a != none) && (!a.IsDeleted()) && (!a.IsDead()) )
			if ((a.GetParentCell() == None ) || (!a.GetParentCell().IsAttached()))
				Aygas.DebugLog("Tracking " + a.GetDisplayName() + "  " + a.GetParentCell())
				if (!Aygas.ProcessUnattachedOwner(a))
					deleteOwners[d] = a
					d += 1
				endif
			endif
		elseif (a != none)
			deleteOwners[d] = a
			d += 1
		endif
	endwhile

	while (d > 0)
		d -= 1
		Aygas.ProcessDeletedOwner(deleteOwners[d])
		StorageUtil.FormListRemove(none, "aygasOwners", deleteOwners[d]) 
	endwhile

	Aygas.WorkDetector.Detect()
	Actor p = Aygas.WorkDetector.RandomProstitute()
	if (p != none)
		Aygas.Scenes.ProTrickProstituteCandidate.ForceRefTo(p)
	else
		Aygas.Scenes.ProTrickProstituteCandidate.Clear()
	endif

	Aygas.DebugLog("aygas: done tracking owners")
EndFunction

Function FindPotentialNewOwner()
	if (Aygas.EventFunctions.SlaveryLevelAtLocation >= 2)
		Aygas.Debugmessage("Check for new owner")		
		Actor powner = Aygas.WorkDetector.PotentialOwner
		if (powner != None)
			if ((Aygas.HSHHouseSlaveFaction == None) || (!powner.IsInFaction(Aygas.HSHHouseSlaveFaction)))
				Aygas.DebugMessage("Found new owner: " + powner.GetDisplayname())
				Aygas.NominatedOwner = powner
			endif
		endif
	endif
EndFunction

aygasCoreScript Property Aygas Auto
bool Property isWaiting=false Auto

Keyword Property KwdPlayerHome Auto