Scriptname aygasEvents extends Quest conditional

AYGASInterface Property AYGASInter Auto

Function OnInit()
	UnregisterForUpdateGameTime()
	OnUpdateGameTime()
EndFunction

Function SceneDelay(int seconds)
	TimerRunning = true
	RegisterForUpdate(seconds)
EndFunction

Event OnUpdate()
	TimerRunning = false
	if (TimerStartBout2)
		FightBout2()
	endif
	TimerStartBout2 = false
EndEvent

Event OnUpdateGametime()
	; Adjust city slavery participation levels
	AdjustCities()
	if ((Utility.RandomInt(1, 8 - Math.Floor(Aygas.SSaleRate / 10)) == 1) && (Aygas.SSaleRate > 0))
		AssignPotentialOwner()
	endif

	RegisterForSingleUpdateGametime(24)		; Have an event once a week

	if ((Utility.RandomInt(1, 6 - Math.Floor(Aygas.SSaleRate / 10)) == 1))
		Aygas.StorageFunctions.MoveExiledRuler()
	endif

	; Todo: add an event on set days
	float today =  Utility.GetCurrentGameTime()
;	if (EventStage == 1)						; Event needs to be set up but hasn't happened for a day.  Do it now
;		Aygas.DebugMessage("1 day passed: set up event now")
;		SetupEvent()
	if (EventStage == -1)					; Event needs to be torn down but hasn't happened for a day.  Do it now
		Aygas.DebugMessage("1 day passed: tear down event now")
		StopEvent()
	elseif (EventStage == 3)
		StartEvent()
	elseif ((LastEventDate + 5 <today) && (EventStage < 4))
		if (EventStage > 0)
			StopEvent()
		else
			PlanEvent()
		endif
	elseif (EventStage == 2)
		if (!EventActorsPicked) 
			PickEventActors()
		endif
;		if (!EventSlavesPicked) 
;			PickEventSlaves(false)
;		endif
	endif
;	debug.notification("Aygas event timer. LastEvent:" + LastEventDate + "   Date:"+today)

EndEvent

; Adjust slavery levels for all cities
Function AdjustCities()
	; reset array so that cities eligible for events can be stored
	EventLocations = new Location[25]
	EventLocationCount = 0 

	DawnstarSlavery = AdjustCitySlavery(DawnstarLocation, DawnstarSlavery )
	MarkarthSlavery = AdjustCitySlavery(MarkarthLocation, MarkarthSlavery )
	RiftenSlavery = AdjustCitySlavery(RiftenLocation, RiftenSlavery )
	FalkreathSlavery = AdjustCitySlavery(FalkreathLocation, FalkreathSlavery )
	RiverwoodSlavery= AdjustCitySlavery(RiverwoodLocation, RiverwoodSlavery)
	SolitudeSlavery = AdjustCitySlavery(SolitudeLocation, SolitudeSlavery )
	RoriksteadSlavery = AdjustCitySlavery(RoriksteadLocation, RoriksteadSlavery )
	MorthalSlavery = AdjustCitySlavery(MorthalLocation, MorthalSlavery )
	IvarsteadSlavery = AdjustCitySlavery(IvarsteadLocation, IvarsteadSlavery )
	HelgenSlavery = AdjustCitySlavery(HelgenLocation, HelgenSlavery )
	WinterholdSlavery = AdjustCitySlavery(WinterholdLocation, WinterholdSlavery )
	WindhelmSlavery = AdjustCitySlavery(WindhelmLocation, WindhelmSlavery )
	WhiterunSlavery = AdjustCitySlavery(WhiterunLocation, WhiterunSlavery)
	BrumaSlavery = AdjustCitySlavery(BrumaLocation, BrumaSlavery)
EndFunction

Function NominateSlaveForEvent(Actor Slave, Actor owner)
	int s = StorageUtil.GetIntValue(slave, "OwnerSatisfaction")	; 1 = crap, 2 = adequate, 3 = good, 4 = outstanding

	if ((SlaveCandidate06 != None) || (slave == None) || ((s >= 2) && (isAuction)) || ((Utility.RandomInt(1, 7 - Math.Floor(Aygas.SSaleRate / 10)) > 2) && (isAuction)) || ((Aygas.SSaleRate == 0) && (isAuction)) )
		return
	endif

	Aygas.DebugMessage("Slave for event: " + slave.GetDisplayName() + ", " + s)

	if (SlaveCandidate01 == None)
		SlaveCandidate01 = slave
		Aygas.DebugLog("Slave " + slave.GetDisplayName() + " to Event Slot 1")
		return
	elseif (SlaveCandidate01 == slave)
		return
	endif
	if (SlaveCandidate02 == None)
		SlaveCandidate02 = slave
		Aygas.DebugLog("Slave " + slave.GetDisplayName() + " to Event Slot 2")
		return
	elseif (SlaveCandidate02 == slave)
		return
	endif
	if (SlaveCandidate03 == None)
		SlaveCandidate03 = slave
		Aygas.DebugLog("Slave " + slave.GetDisplayName() + " to Event Slot 3")
		return
	elseif (SlaveCandidate03 == slave)
		return
	endif
	if (SlaveCandidate04 == None)
		SlaveCandidate04 = slave
		Aygas.DebugLog("Slave " + slave.GetDisplayName() + " to Event Slot 4")
		return
	elseif (SlaveCandidate04 == slave)
		return
	endif
	if (SlaveCandidate05 == None)
		SlaveCandidate05 = slave
		Aygas.DebugLog("Slave " + slave.GetDisplayName() + " to Event Slot 5")
		return
	elseif (SlaveCandidate05 == slave)
		return
	endif
	if (SlaveCandidate06 == None)
		SlaveCandidate06 = slave
		Aygas.DebugLog("Slave " + slave.GetDisplayName() + " to Event Slot 6")
		return
	elseif (SlaveCandidate06 == slave)
		return
	endif
EndFunction

; Plan an event.  Do not run concurrent with OnUpdateGametime!
Function PlanEvent()
	if (EventStage <= 2)
		; No event yet or event not started, pick a random location
		if (EventStage > 0)
			; Remove previous
			StopEvent()
		endif

		if (EventLocationCount == 0)
			Aygas.DebugLog("No eligible towns for event")
			Aygas.DebugMessage("No eligible towns for event")
			PlannedEventDate = 0
			EventLocation = None
			EventLocationAlias.Clear()
		else
			Aygas.DebugMessage("Queue Event!")

			int i = utility.randomint(1, EventLocationCount) - 1
			PlanEventAtLocation(EventLocations[i])
		endif	
	endif
EndFunction

Function PlanEventAtLocation(Location eventLoc)
	EventLocation = eventLoc
	EventLocationAlias.ForceLocationTo(EventLocation)
	PlannedEventDate =  Utility.GetCurrentGameTime()
	LastEventDate = PlannedEventDate
	Aygas.DebugLog("Picked " + EventLocation.GetName() + " for event")
	Aygas.DebugMessage("Picked " + EventLocation.GetName() + " for event")
	EventLocationIsBruma = ((BrumaLocation != None) && (EventLocation == BrumaLocation))
	EventActorsPicked = false
	EventSlavesPicked = false

	; Set up markers and spawn coordinator NPC
	ScenePitboss.GetActorRef().Disable()
	SceneAuctionMaster.GetActorRef().Disable()
	UnwantedActor.Clear()
	UnwantedActorMarker.Clear()

	isAuction = false
	if (EventLocation == DawnstarLocation)
		SceneMarker.ForceRefTo(DawnstarMarker)
		EventLocationCode = 1
		isAuction = true
	elseif (EventLocation == MarkarthLocation)
		SceneMarker.ForceRefTo(MarkarthMarker)
		EventLocationCode = 2
		isAuction = true
	elseif (EventLocation == RiftenLocation)
		SceneMarker.ForceRefTo(RiftenMarker)
		EventLocationCode = 3
		isAuction = true
	elseif (EventLocation == SolitudeLocation)
		SceneMarker.ForceRefTo(SolitudeMarker)
		EventLocationCode = 6
		isAuction = true
	elseif (EventLocation == WinterholdLocation)
		SceneMarker.ForceRefTo(WinterholdMarker)
		EventLocationCode = 11
		isAuction = true
	elseif (EventLocation == WindhelmLocation)
		SceneMarker.ForceRefTo(WindhelmMarker)
		EventLocationCode = 12
		isAuction = true
	elseif (EventLocation == WhiterunLocation)
		SceneMarker.ForceRefTo(WhiterunMarker3)
		EventLocationCode = 13
		isAuction = true
	elseif (EventLocation == BrumaLocation)
		BrumaMarker = Game.GetFormFromFile(0x00065053, "BSHeartland.esm") as ObjectReference
		if (BrumaMarker != None)
			SceneMarker.ForceRefTo(BrumaMarker)
			EventLocationCode = 14
			isAuction = true
		else
			SceneMarker.Clear()
		endif
	elseif (EventLocation == FalkreathLocation)
		SceneMarker.ForceRefTo(FalkreathMarker)
		EventLocationCode = 4
	elseif (EventLocation == RiverwoodLocation)
		SceneMarker.ForceRefTo(RiverwoodMarker)
		EventLocationCode = 5
	elseif (EventLocation == RoriksteadLocation)
		SceneMarker.ForceRefTo(RoriksteadMarker)
		EventLocationCode = 7
	elseif (EventLocation == MorthalLocation)
		SceneMarker.ForceRefTo(MorthalMarker)
		EventLocationCode = 8
	elseif (EventLocation == IvarsteadLocation)
		SceneMarker.ForceRefTo(IvarsteadMarker2)
		EventLocationCode = 9
	elseif (EventLocation == HelgenLocation)
		SceneMarker.ForceRefTo(HelgenMarker)
		EventLocationCode = 10
	else
		EventStage = 0
		EventLocationCode = 0
		return
	endif
	EventLocationName = EventLocation.GetName()
	EventStage = 1

	; If player is not in event zone, set it up right away.
;	if (!SceneMarker.GetRef().GetParentCell().IsAttached())		; Disabled: do when player zones into area, needed to handle rotation
;		SetupEvent()
;	endif
EndFunction


Function ForceEvent(Location eventLoc)
	EventStage = 0
	StopEvent()
	Utility.Wait(5)
	PlanEventAtLocation(eventLoc)
EndFunction


Function SetupEvent()
	Aygas.DebugMessage("Event set up")
	NrPlayerSlaves = 0
	EventStage = 2

	SceneMarker.GetRef().Enable()
	if (isAuction)
		SceneAuctionMaster.GetActorRef().Enable()
		SceneAuctionMaster.GetActorRef().MoveTo(Scenemarker.GetRef())
		if (SceneGuard1.GetRef() == None)
			SceneGuard1.ForceRefTo(Guard1)		; Fixes crappy bug where new refaliases in existing quests don't get filled
		endif
		SceneGuard1.GetActorRef().Enable()
		SceneGuard1.GetActorRef().MoveTo(Scenemarker.GetRef())
		if (SceneGuard2.GetRef() == None)
			SceneGuard2.ForceRefTo(Guard2)		; Fixes crappy bug where new refaliases in existing quests don't get filled
		endif
		SceneGuard2.GetActorRef().Enable()
		SceneGuard2.GetActorRef().MoveTo(Scenemarker.GetRef())
	else
		ScenePitboss.GetActorRef().Enable()
		ScenePitboss.GetActorRef().MoveTo(Scenemarker.GetRef())
		SceneGuard1.GetActorRef().Enable()
		SceneGuard1.GetActorRef().MoveTo(Scenemarker.GetRef())
		SceneGuard2.GetActorRef().Enable()
		SceneGuard2.GetActorRef().MoveTo(Scenemarker.GetRef())
	endif

	PropsScript.BuildSet(EventLocationCode)
EndFunction

Function QueueEvent()
	; Reset gametime update to noon
	UnregisterForUpdateGametime()
	EventStage = 3
	float t = Utility.GetCurrentGameTime()
	t -= Math.floor(t)
	t = t * 24

	t = 12 - t
	if (t < 0)
		t += 24
	elseif (t < 1)
		t = 1
	endif
	Aygas.DebugMessage("Event Scheduled, delay: " + t)
	RegisterForUpdateGameTime(t)
	PlayerSlaveInFight = false
	PlayerWinnings = 0
	PlayerBetInRound = 0
	PlayerBetAmount = 0

	DragonsWereOff = RandomDragonsOff.GetValueInt()
	RandomDragonsOff.SetValue(1)

	if (!isAuction)
		int n = SlaveRefs.length
		int i = 0
		while i < n
			if (i%2) == 0
				DressForFight(SlaveRefs[i], true)
			else
				DressForFight(SlaveRefs[i], false)
			endif
			i += 1
		endwhile
	endif
EndFunction

Function StartEvent()
	float t = Utility.GetCurrentGameTime()
	t -= Math.floor(t)
	t = t * 24
	Aygas.DebugMessage("Event Starting: " + t)
	if ((t < 10) || (t > 14))
		; Missed event window or actors never got picked for some reason, cancel
		StopEvent()
		return
	endif

	; Assign additional items
	if (EventLocation == WhiterunLocation)
		Actor ua = WRHeimsk as actor
		if (ua.GetCurrentScene() != None)
			ua.GetCurrentScene().Stop()
		endif
		UnwantedActorMarker.ForceRefTo(WRMoveMarker)
		UnwantedActor.ForceRefTo(ua)
		ua.EvaluatePackage()
	endif 

	if (!EventActorsPicked)
		PickEventActors()		; Force actor selection now if it hasn't happened yet.  This is called when player talks to event handler, so the zone should be loaded and ready for selection.
	endif
	if (!EventSlavesPicked)
		PickEventSlaves(true)		; Force selection of slaves
	endif

;	Debug.MessageBox(Aygas.EventDetector.Spectator1Ref.getActorRef().GetDisplayName() + ", " + Aygas.EventDetector.Spectator2Ref.getActorRef().GetDisplayName() + ", " + Aygas.EventDetector.Spectator3Ref.getActorRef().GetDisplayName() + ", " + Aygas.EventDetector.Spectator4Ref.getActorRef().GetDisplayName())

	if ((!EventActorsPicked) || (!EventSlavesPicked))
		StopEvent()
		if (isAuction)
			AuctionSceneCancel.Start()
		else
			FightSceneCancel.Start()
		endif
		return ; No actors found, abort
	endif

	int n = SlaveRefs.length
	int i = 0
	while i < n
		StopScenes(SlaveRefs[i])
		i += 1
	endwhile

	SlaveOnBlockNr = 0
	if (isAuction)
		AuctionScene01.Start()
	else
		i = 0
		while i < n
			if (i%2) == 0
				DressForFight(SlaveRefs[i], true)
			else
				DressForFight(SlaveRefs[i], false)
			endif
			i += 1
		endwhile
		FightScene01.Start()
	endif

	EventStage = 4
	PlayerEarnings = 0
	AllowPlayerAction = false
	RegisterForKey(28)	; Enter
EndFunction

Function StopScenes(ReferenceAlias sr)
	Actor slave = sr.GetActorRef()
	if (slave != None)
		Scene s = slave.GetCurrentScene()
		if (s != None)
			s.Stop()
		endif
		if(Aygas.SexLab.IsActorActive(slave))
			
		endif
	endif
EndFunction

Function ClearSpectatorRefs()
	int n = SpectatorRefs.length
	int i = 0
	while i < n
		SpectatorRefs[i].Clear()
		i += 1
	endwhile
EndFunction

Function StopEvent()
	Aygas.DebugMessage("Event stopping")
	AuctionScene01.Stop()
	AuctionSellScene.Stop()
	AuctionSceneEnd.Stop()
	AuctionSceneCancel.Stop()
	FightScene01.Stop()
	FightBoutScene.Stop()
	FightEndScene2.Stop()
	FightSceneCancel.Stop()

	SetSpectatorLookAt(None)
	ClearSpectatorRefs()
	SlaveCandidate01 = None
	SlaveCandidate02 = None
	SlaveCandidate03 = None
	SlaveCandidate04 = None
	SlaveCandidate05 = None
	SlaveCandidate06 = None
	SlaveOnBlock.Clear()
	Fighter1.Clear()
	Fighter2.Clear()

	int n = SlaveRefs.length
	int i = 0
	while i < n
		SlaveRefRemoveItems(SlaveRefs[i])
		i += 1
	endwhile

	if (PlayerSlaveInFight) ; In second slot
		Actor slave = SlaveRefs[1].GetActorRef()
		SlaveRefs[1].Clear()
		slave.RemoveItem(ArmorLeather, 1)
		slave.RemoveItem(ArmorHatBlue, 1)
		slave.RemoveItem(WeaponMace, 1)
	endif

	ActivateAuctionPackages = false 
	UnwantedActor.Clear()
	UnregisterForAllkeys()

	i = 0
	while i < n
		RedressAfterFight(SlaveRefs[i])
		i += 1
	endwhile
	PlayerSlaveInFight = false

	RandomDragonsOff.SetValue(DragonsWereOff)

	TeardownEvent()
EndFunction

Function SlaveRefRemoveItems(ReferenceAlias r)
	Actor slave = r.GetActorRef()
	if (slave != None)
		slave.RemoveItem(ArmorLeather, 1)
		slave.RemoveItem(ArmorHatRed, 1)
		slave.RemoveItem(ArmorHatBlue, 1)
		slave.RemoveItem(WeaponMace, 1)
	endif
EndFunction

Function SlaveRefStopScene(ReferenceAlias r)
	Actor slave = r.GetActorRef()
	if (slave != None)
		slave.SetFactionRank(Aygas.JobOverrideAction, 0)

		Actor owner = StorageUtil.GetFormValue(slave, "Owner") as Actor
		if (owner != None)
			if (owner != Game.GetPlayer())
				slave.MoveTo(owner)
			else
				slave.SetFactionRank(Aygas.SlaveTypeFaction, 14)
				slave.SetFactionRank(Aygas.OwnedByPlayer, 1)
			endif
		endif
		ReferenceAlias slot = Aygas.SlaveSlot(slave)
		if (slot != None)
			(slot as aygasSlaveScript).BeforeSuspend()
			slot.Clear()
		endif
	
		if (!isAuction)
			RedressAfterFight(r)
		endif

		r.Clear()
		if (owner == None)
			; return unowned slaves to pool
			Aygas.StorageFunctions.StoreSlave(slave)
		endif
	endif
EndFunction

Function SlaveRefStartScene(ReferenceAlias r)
	Actor slave = r.GetActorRef()
	if (slave != None)
		slave.SetFactionRank(Aygas.JobOverrideAction, 4)
		ReferenceAlias slaveRef = Aygas.SlaveSlot(slave)
		if (slaveRef != None)
			(slaveRef as aygasSlaveScript).BeforeSuspend()
			slaveRef.Clear()
		endif
		slave.MoveTo(CageMarker)
		slave.SetDontMove(false)
		slave.EnableAI(true)
		Aygas.CheckOutfit(slave)
	endif
EndFunction

Function TeardownEvent()			; Preferably call when player is not in the event zone
	if (EventLocation != None)
		EventLocation = None
		EventLocationCode = 0
		EventLocationAlias.Clear()
	endif

	if ((EventStage > 0) && (SceneMarker.GetRef().GetParentCell().IsAttached()))
		EventStage = -1		; Player still in zone, delay teardown
		return
	endif
	EventStage = 0
	Aygas.DebugMessage("Event teardown")

	if (SceneMarker.Getref() != None)
		SceneMarker.GetRef().Disable()
		SceneMarker.Clear()
	endif
	if (SceneAuctionMaster.GetRef() != None)
		SceneAuctionMaster.GetRef().Disable()
	endif
	if (ScenePitboss.GetRef() != None)
		ScenePitboss.GetRef().Disable()
	endif
	if (SceneGuard1.GetRef() != None)
		SceneGuard1.GetRef().Disable()
	endif
	if (SceneGuard2.GetRef() != None)
		SceneGuard2.GetRef().Disable()
	endif

	int n = SlaveRefs.length
	int i = 0
	while i < n
		SlaveRefStopScene(SlaveRefs[i])
		i += 1
	endwhile

	PropsScript.TeardownSet()

	EventActorsPicked = false
	EventSlavesPicked = false
	NrPlayerSlaves = 0
EndFunction

Function PickEventActors()
	ActivateAuctionPackages = false
	if  ((!EventActorsPicked) && (SceneMarker.GetRef().GetParentCell().IsAttached()))
		Aygas.EventDetector.Detect()
		int n = Aygas.EventDetector.SpectatorRefs.length
		int m = SpectatorRefs.length
		int i = 0
		while i < n && i < m
			ForceRefOrClear(SpectatorRefs[i], Aygas.EventDetector.SpectatorRefs[i].GetActorRef())
			i += 1
		endwhile

		if (SpectatorRefs[3].GetRef() != None) ; At least 4 spectators
			EventActorsPicked = true
		else
			Aygas.DebugMessage("Not enough spectators found for events")
		endif
		Bidder.Clear()
	else
		Aygas.DebugMessage("Event actor location unattached or already picked")
	endif
EndFunction

Function PickEventSlaves(bool force)
	Aygas.DebugMessage("Picking event slaves")
	if  ((!EventSlavesPicked) && (SceneMarker.GetRef().GetParentCell().IsAttached() && ((SlaveCandidate01 != None) || (force)) ))
		SlaveTransferInProgress = true
		if (isAuction)
			Actor randomSlave = Aygas.StorageFunctions.RandomSlave()
			if (randomSlave != None)
				Aygas.StorageFunctions.RemoveSlave(randomSlave)
				ForceRefOrClear(FreeSlaveSlot(), randomSlave)
				Aygas.DebugMessage("Random auction slave:" + randomSlave.GetDisplayName())
				utility.wait(1)
			endif

			ForceRefOrClear(FreeSlaveSlot(), SlaveCandidate01)
			utility.wait(1)

			randomSlave = Aygas.StorageFunctions.RandomSlave()
			if ((randomSlave != None) && (SlaveCandidate01 == None))	; If no slaves from town found, spawn a second slave from storage
				Aygas.StorageFunctions.RemoveSlave(randomSlave)
				ForceRefOrClear(FreeSlaveSlot(), randomSlave)
				Aygas.DebugMessage("Random auction slave:" + randomSlave.GetDisplayName())
				utility.wait(1)
			endif

			if (utility.randomint(1,2) == 1)
				ForceRefOrClear(FreeSlaveSlot(), SlaveCandidate02)
				if (utility.randomint(1,2) == 1)
					ForceRefOrClear(FreeSlaveSlot(), SlaveCandidate03)
					utility.wait(1)
				endif
			endif

			if (SlaveRefs[0].GetRef() != None) 
				EventSlavesPicked = true
				Aygas.DebugMessage("Auction Slaves: " + SlaveRefs[0].GetActorRef().GetDisplayName() + ", " + SlaveRefs[1].GetActorRef().GetDisplayName() + ", " + SlaveRefs[2].GetActorRef().GetDisplayName() + ", " + SlaveRefs[3].GetActorRef().GetDisplayName() )
				SetSlavesEventJob()
			else
				Aygas.DebugMessage("Not enough slaves found for events")
			endif

			SlaveOnBlock.Clear()
		else
			if ((SlaveCandidate01 != None) && ((SlaveCandidate02 != None) || (SlaveRefs[1].GetActorRef() != None)))	; Last condition checks player owned fighter
				ForceRefOrClear(FreeSlaveSlot(), SlaveCandidate01)
				ForceRefOrClear(FreeSlaveSlot(), SlaveCandidate02)
				ForceRefOrClear(FreeSlaveSlot(), SlaveCandidate03)
				ForceRefOrClear(FreeSlaveSlot(), SlaveCandidate04)
				if (SlaveRefs[3].GetActorRef() == None)
					SlaveRefs[2].Clear()
				endif
				EventSlavesPicked = true
				Aygas.DebugMessage("Fight Slaves: " + SlaveRefs[0].GetActorRef().GetDisplayName() + ", " + SlaveRefs[1].GetActorRef().GetDisplayName() + ", " + SlaveRefs[2].GetActorRef().GetDisplayName() + ", " + SlaveRefs[3].GetActorRef().GetDisplayName() )
			else
				Aygas.DebugMessage("Not enough slaves found for events")
			endif
		endif
		SlaveTransferInProgress = false
	endif
EndFunction

Function AuctionSellNextSlave()
	; Select next slave and proceed
	SlaveOnBlockNr += 1
	Actor slave = None

	if ((SlaveOnBlockNr == 1) && (SlaveRefs[0].getRef() != None))
		slave = SlaveRefs[0].GetActorRef()
	elseif ((SlaveOnBlockNr == 2) && (SlaveRefs[1].getRef() != None))
		slave = SlaveRefs[1].GetActorRef()
	elseif ((SlaveOnBlockNr == 3) && (SlaveRefs[2].getRef() != None))
		slave = SlaveRefs[2].GetActorRef()
	elseif ((SlaveOnBlockNr == 4) && (SlaveRefs[3].getRef() != None))
		slave = SlaveRefs[3].GetActorRef()
	endif

	if (slave != None)
		; Determine price
		AuctionTargetPrice = StorageUtil.GetIntValue(slave, "Price")
		if (AuctionTargetPrice <= 0)
			AuctionTargetPrice = AYGASInter.getAuctionPrice(slave)
		endif
		if (slave.GetActorBase().IsUnique())
			AuctionTargetPrice *= 1.5
		endif

		SlaveOnBlock.ForceRefTo(slave)

		if (AuctionTargetPrice < 200)
			AuctionTargetPrice = 200
		elseif (AuctionTargetPrice > 8000)
			AuctionTargetPrice = 8000
		endif

		; Set maximum bids for each buyer
		SpectatorPrice = new float[10]
		LastBidder = None
		PerformedPlayerAction = false
		AllowPlayerAction = false

		AuctionCurrentPrice = AuctionTargetPrice / 2
		Aygas.SellQuest.EvaluateAuctionSlave(slave)		
		int n = SpectatorRefs.length
		int i = 0
		while i < n
			SetSpectatorMaxBid(SpectatorRefs[i], i, AuctionTargetPrice, slave)
			i += 1
		endwhile

		Aygas.DebugLog("Slave " + slave.GetDisplayName() + " on the block, target price " + AuctionTargetPrice + ", type:" + AuctionSlaveType)

		AuctionSalePhase = 1
		AuctionSellScene.Start()
		SetSpectatorLookat(slave)
	else
		; End auction
		AuctionSceneEnd.Start()
	endif
EndFunction

Function AuctionNextBid()
	Bidder.Clear()
	if (PerformedPlayerAction)
		PerformedPlayerAction = false
		if (AuctionSalePhase <= 2)
			AuctionSalePhase += 1	
		elseif (AuctionSalePhase == 4)
			AuctionSalePhase = 3
		endif
	endif

	if (AuctionSalePhase > 4)
		AllowPlayerAction = false
		AuctionSalePhase = 0
		AYGASInter.SendAnimationEvent(SlaveOnBlock.GetActorRef(), "idleforcedefaultstate")
		; Start next sale
		AuctionSellNextSlave()
	elseif (AuctionSalePhase == 4)
		AuctionSalePhase += 1			; Closing bid was issued, handle sale
		Aygas.DebugMessage("Sold " + SlaveOnBlock.GetActorRef().GetDisplayName() + " to " + LastBidder.GetDisplayname())

		Actor owner = StorageUtil.GetFormValue(SlaveOnBlock.GetActorRef(), "Owner") as Actor
		if (owner != None)
			StorageUtil.FormListRemove(owner, "aygasSlaves", SlaveOnBlock.GetActorRef())
		endif
		SlaveOnBlock.GetActorRef().RemoveFromFaction(Aygas.OwnedByPlayer)

		if (StorageUtil.FormListFind(none, "aygasOwners", LastBidder) < 0)
			StorageUtil.FormListAdd(none, "aygasOwners", LastBidder)
			StorageUtil.FormListClear(LastBidder, "aygasSlaves")
		endif

		StorageUtil.FormListAdd(LastBidder, "aygasSlaves", SlaveOnBlock.GetActorRef())
		Aygas.StoreOutfit(SlaveOnBlock.GetActorRef())

		StorageUtil.SetFormValue(SlaveOnBlock.GetActorRef(), "Owner", LastBidder) as Actor

		StorageUtil.SetIntValue(SlaveOnBlock.GetActorRef(), "OwnerSatisfaction", utility.randomint(1,4))
		StorageUtil.SetIntValue(SlaveOnBlock.GetActorRef(), "Price", AuctionCurrentPrice as int)
		StorageUtil.SetFloatValue(SlaveOnBlock.GetActorRef(), "DateOfSale",  Utility.GetCurrentGameTime())	
		Aygas.ProcessOwner(LastBidder, false)

		if (LastBidder == Game.GetPlayer())
			SlaveOnBlock.GetActorRef().SetFactionRank(Aygas.SlaveTypeFaction, 14)
			SlaveOnBlock.GetActorRef().SetFactionRank(Aygas.OwnedByPlayer, 1)
			Debug.Notification("You have won the auction for this slave!")
			Game.GetPlayer().RemoveItem(Aygas.gold, PlayerLastBid)
		elseif (owner == Game.GetPlayer())
			PlayerEarnings += Math.floor(((AuctionCurrentPrice - 0.001) / 100) +1  )* 85
		endif
	else
		; Figure out next bidder
		Bidders = new Actor[10]
		NrBidders = 0
		int n = SpectatorRefs.length
		int i = 0
		while i < n
			CheckBidderEligible(SpectatorRefs[i], i, AuctionCurrentPrice)
			i += 1
		endwhile

		Aygas.DebugMessage("Bidders: " + NrBidders + " in phase:" + AuctionSalePhase)

		if (NrBidders > 0)
			int j = utility.randomint(0, NrBidders - 1)
			Bidder.ForceRefTo(Bidders[j])

			if (AuctionSalePhase > 1)
				; Increase bid price
				float increase = AuctionTargetPrice / 5
				if (NrBidders == 1)
					increase *= 0.5
				endif
				if (utility.randomint(1,4) == 1)
					increase *= 2
				endif
				if (increase < 100)
					increase = 100
				endif

				AuctionCurrentPrice += increase
				if (AuctionCurrentPrice > 12000)
					AuctionCurrentPrice = 12000
					Bidder.Clear()
				endif
			endif
		endif

		if (Bidder.GetRef() == None)
			AuctionSalePhase = 4			; No further bids
			if (LastBidder != none)
				Bidder.ForceRefTo(LastBidder)
			else
				AuctionSalePhase = 6		; Had no bids at all
				AllowPlayerBidding()
			endif
		else
			if (AuctionSalePhase <= 2)
				AuctionSalePhase += 1			; 1 = opening bid announce, 2 = opening bid response, 3 = subsequent bid, 4 = finish sale, 6 = no sale
				AllowPlayerBidding()
			elseif (AuctionSalePhase == 3)
				AllowPlayerBidding()
			endif
			LastBidder = Bidder.GetActorRef()
		endif

		Aygas.DebugMessage("Bid: " + AuctionCurrentPrice + ", phase:" + AuctionSalePhase + ", bidder:" + Bidder.GetActorRef().GetDisplayName())
	endif
EndFunction

Function SetSpectatorMaxBid(ReferenceAlias ref, int index, float basePrice, Actor slave)
	if ((utility.randomint(1,4) == 1) || (ref.GetActorRef() == None))
		SpectatorPrice[index] = 0
		return
	endif
	if  (Aygas.SexLab.GetGender(slave) != Aygas.SexLab.GetGender(ref.GetActorRef()))
		basePrice *= 1.5
	endif
	if (utility.randomint(1,3) == 3)
		basePrice = 0
	endif
	basePrice = basePrice * utility.randomint(5, 12) / 10
	SpectatorPrice[index] = basePrice
EndFunction

Function CheckBidderEligible(ReferenceAlias ref, int index, float bid)
	Actor owner = StorageUtil.GetFormValue(SlaveOnBlock.GetActorRef(), "Owner") as Actor
	if ((ref.GetActorRef() == None) || (ref.GetActorRef().IsDead()))
		return
	elseif ((bid <= SpectatorPrice[index]) && (ref.GetActorRef() != LastBidder) && (ref.GetRef().GetDistance(SceneAuctionMaster.GetRef()) < 1000  ) && (ref.GetActorRef() != owner))
		Bidders[NrBidders] = ref.GetActorRef()
		NrBidders += 1
	endif
EndFunction

Function AllowPlayerBidding()
	PlayerPrice = Math.floor(((AuctionCurrentPrice - 0.001) / 100) +1  )* 100
	if (AuctionSalePhase == 4)
		PlayerPrice += utility.randomint(3,6) * 100
	elseif ((AuctionSalePhase > 2) && (AuctionSalePhase != 6))
		PlayerPrice += utility.randomint(0,2) * 100
	endif

	Actor owner = StorageUtil.GetFormValue(SlaveOnBlock.GetActorRef(), "Owner") as Actor

	if ((LastBidder != Game.GetPlayer()) && (PlayerPrice<= Game.GetPlayer().GetItemCount(Aygas.gold)) && (Game.GetPlayer() != owner))
		AllowPlayerAction = true
		Debug.Notification("Press Enter to bid " + PlayerPrice+ " for this slave")
	else
		AllowPlayerAction = false
	endif

EndFunction

Event OnKeyDown(int key)
	if (AllowPlayerAction)
		AuctionCurrentPrice = PlayerPrice
		AllowPlayerAction = false
		PerformedPlayerAction = true
		Debug.Notification("You have bid " + PlayerPrice)
		PlayerLastBid = PlayerPrice
		Bidder.ForceRefTo(Game.GetPlayer())
		LastBidder = Game.GetPlayer()
;		BidderWave()		; Disabled, sometimes causes player to be teleported away
		if (AuctionSalePhase == 6)
			AuctionSalePhase = 4
		endif
	endif
EndEvent

Function FightNextBout()
	Aygas.DebugMessage("Round start: " + SlaveOnBlockNr)
	TimerStartBout2 = false
	Fighter1.Clear()
	Fighter2.Clear()
	RedRoundsWon = 0
	RoundsFought = 0
	if (SlaveOnBlockNr == 0)
		SlaveOnBlockNr += 1
		Fighter1.ForceRefTo(SlaveRefs[0].GetActorRef())
		Fighter2.ForceRefTo(SlaveRefs[1].GetActorRef())
		SetSpectatorLookAt(SlaveRefs[1].GetActorRef())
		FightBoutScene.ForceStart()
	elseif ((SlaveOnBlockNr == 1) && (SlaveRefs[2].GetRef() != None) && (SlaveRefs[3].GetRef() != None))
		TimerStartBout2 = true
		RegisterForSingleUpdate(0.1)
	else
		FightEndScene2.ForceStart()
	endif
EndFunction

Function FightBout2()
	FightBoutScene.Stop()
	SlaveOnBlockNr += 1
	Fighter1.Clear()
	Fighter2.Clear()
	Fighter1.ForceRefTo(SlaveRefs[2].GetActorRef())
	Fighter2.ForceRefTo(SlaveRefs[3].GetActorRef())
	SetSpectatorLookAt(SlaveRefs[3].GetActorRef())
	FightBoutScene.ForceStart()
	Aygas.DebugMessage("  Round 2 running:" + FightBoutScene.IsPlaying())
EndFunction

Function SetSlavesEventJob()
	int n = SlaveRefs.length
	int i = 0
	while i < n
		SlaveRefStartScene(SlaveRefs[i])
		i += 1
	endwhile
EndFunction

Function RoundWinner(bool redWins)	; Red = fighter1 / fighter3
	Actor winner
	RedWonThisRound = redWins
	if (redWins)
		RedRoundsWon += 1
		winner = Fighter1.GetActorRef()
	else
		winner = Fighter2.GetActorRef()
	endif
	RoundsFought += 1
	Utility.Wait(4)
	Fighter1.GetActorRef().ResetHealthAndLimbs()
	Fighter2.GetActorRef().ResetHealthAndLimbs()
	Aygas.DebugMessage("Round: " + winner.GetDisplayName() + " " + redWins)
EndFunction

Function BoutWinner(bool redWins)
	If ((PlayerSlaveInFight) && (SlaveOnBlockNr == 1) && (!redWins))
		Aygas.DebugMessage("Player slave wins")
		PlayerWinnings += 200
		Aygas.proFightWon += 1
		Aygas.EvaluatePerks()
	endif
	if (redWins)
		AYGASInter.SendAnimationEvent(Fighter1.GetActorRef(), "IdleSalute")
	else
		AYGASInter.SendAnimationEvent(Fighter2.GetActorRef(), "IdleSalute")
	endif

	if ((PlayerBetInRound == SlaveOnBlockNr) && (PlayerBetOnRed == redWins))
		PlayerWinnings += PlayerBetAmount * 2
	endif
EndFunction

Function ForceRefOrClear(ReferenceAlias ref, ObjectReference val)
	if (ref != None)
		if (val != None)
			ref.ForceRefTo(val)
		else
;			ref.Clear()		; Should not be needed
		endif
	endif
EndFunction

Function EventPlayerZoning()					; Handle event related actions when player zones
	if (SceneMarker.GetRef() != none)
		if (SceneMarker.GetRef().GetParentCell().IsAttached() )
			Utility.Wait(2)
			if (EventStage == 1)						; Event needs to be set up but hasn't happened for a day.  Do it now
				Aygas.DebugMessage("Set up event now")
				SetupEvent()
			endif
		endif
		if (EventStage == 2)
			if (!EventActorsPicked) 
				PickEventActors()
			endif	
			if (!EventSlavesPicked) 
				PickEventSlaves(false)
			endif
		endif
	endif
EndFunction

; Check the city's acceptance of slavery in relation to the nr of slaves there
; Note that the level may be adjusted by other Functions as well
int Function AdjustCitySlavery(location city, int currentLevel )
	if (city == none)
		return 0
	endif

	; Get slave count in city
	int count = 0;
	int i = StorageUtil.FormListCount(none, "aygasOwners")
	while(i > 0)
		i-=1
		Actor owner = StorageUtil.FormListGet(none, "aygasOwners", i) as Actor
		string s = StorageUtil.GetStringValue(owner, "Location")
		if ((s != "") && (s == city.GetName()))
			count += StorageUtil.FormListCount(owner, "aygasSlaves")
		endif
	endwhile

	float townSizeFactor = 1
	if ((city == DawnStarLocation) || (city == FalkreathLocation) || (city == MorthalLocation) || (city == WinterholdLocation))
		townSizeFactor = 1.5
	elseif ((city == RiverwoodLocation) || (city == RoriksteadLocation) || (city == IvarsteadLocation) || (city == HelgenLocation))
		townSizeFactor = 2
	endif

	; Adjust level
	int suggestedLevel = math.floor(count * townSizeFactor / DifficultyFactor())	
	if (currentLevel < suggestedLevel)
		; Adjust upward
		if (suggestedLevel > 4)
			suggestedLevel = 4					; Higher levels can only be reached with slave events like auctions or fights
		endif
		currentLevel = suggestedLevel
	elseif (currentLevel > suggestedLevel)
		; Adjust downward
		if (currentLevel < 4)						; Level 4 or5 is not adjusted downward
			currentLevel = suggestedLevel
		endif
	endif

;	debug.notification("Slaves in " + city.Getname() + ": " + count + ", Level is now " + currentLevel)
	if ((currentLevel >= 3) || (Aygas.SCheatCities))
		EventLocations[EventLocationCount] = city
		EventLocationCount += 1
	endif
	return currentLevel
EndFunction

Function AssignPotentialOwner()
	if ((Aygas.NominatedOwner != None) && (!Aygas.NominatedOwner.IsDisabled()) && (!Aygas.Nominatedowner.IsDead()))
		Aygas.DebugMessage("Find slave for " + Aygas.NominatedOwner.GetDisplayName())
		Actor slave = Aygas.StorageFunctions.RandomSlave()
		if (slave != None)
			Aygas.DebugMessage("Found slave " + slave.GetDisplayName())
			Aygas.StorageFunctions.RemoveSlave(slave)
			int price = StorageUtil.GetIntValue(slave, "Price")
			if (price <= 0)
				AuctionTargetPrice = AYGASInter.getBuyerPrice(slave, Aygas.NominatedOwner)
			endif
			Aygas.SellSlave(slave, Aygas.NominatedOwner, Utility.RandomInt(5, 6), price, false)

			Aygas.NominatedOwner = None
			Aygas.WorkDetector.PotentialOwner = None
		endif
	endif
EndFunction

Function AuctionPlayerSlave(Actor slave)
	; Transfer to Aygas
	SlaveTransferInProgress = true
	Aygas.SellQuest.ConsiderSlave(slave, SceneAuctionmaster.GetActorRef())
	int baseType = Aygas.SellQuest.BaseType
	int price = AYGASInter.getSellerPrice(slave, SceneAuctionmaster.GetActorRef())
	Aygas.SellSlave(slave, Game.GetPlayer(), baseType, 0, true)
	StorageUtil.SetIntValue(slave, "Price", price as int)

	; Transfer to auction slot
	NrPlayerSlaves += 1
	ReferenceAlias ref = FreeSlaveSlot()
	if (ref != None)
		ref.ForceRefTo(slave)
	elseif (!SlaveRefs[1].GetActorRef().IsInFaction(Aygas.OwnedByPlayer))	; Skip slave 1, this contains the slave from the pool that we do not want to overwrite
		SlaveRefs[1].ForceRefTo(slave)
	elseif (!SlaveRefs[2].GetActorRef().IsInFaction(Aygas.OwnedByPlayer))
		SlaveRefs[2].ForceRefTo(slave)
	elseif (!SlaveRefs[3].GetActorRef().IsInFaction(Aygas.OwnedByPlayer))
		SlaveRefs[3].ForceRefTo(slave)
	endif

	slave.SetFactionRank(Aygas.JobOverrideAction, 4)
	slave.EvaluatePackage()
	SlaveTransferInProgress = false
EndFunction

Function FightPlayerSlave(Actor slave)
	if (slave != None)
		SlaveRefStopScene(SlaveRefs[1])
		ForceRefOrClear(SlaveRefs[1], slave)
		DressForFight(SlaveRefs[1], false)
		PlayerSlaveInFight = true
		Game.GetPlayer().RemoveItem(Aygas.Gold, 100)
		Aygas.SlaveryGain(1)
		Aygas.ProFightAttended += 1
		Aygas.EvaluatePerks()
	endif
EndFunction

Function DressForFight(ReferenceAlias r, bool isRed)
	Actor a = r.getActorRef()
	if (a != None)
		a.UnequipAll()
		a.EquipItem(ArmorLeather, true, true)
		if (isRed)
			a.EquipItem(ArmorHatRed, true, true)
		else
			a.EquipItem(ArmorHatBlue, true, true)
		endif
	endif
EndFunction

Function RedressAfterFight(ReferenceAlias r)
	Actor a = r.getActorRef()
	if (a != None)
		Aygas.CheckOutfit(a)
	endif
EndFunction

Function SetSpectatorLookAt(Actor target)
	if (target != None)
		Aygas.DebugMessage("Actors look at:" + target.GetDisplayName())
	endif
	int n = SpectatorRefs.length
	int i = 0
	while i < n
		SetRefLookat(SpectatorRefs[i], target)
		i += 1
	endwhile
EndFunction

Function SetRefLookat(ReferenceAlias ref, Objectreference target)
	Actor subject = ref.GetActorRef()
	if subject == None
		return
	endif
	if subject.IsDead()
		return
	endif
	if target == None
		subject.ClearLookAt()
		return
	endif
	subject.SetLookAt(target, false)
	if SceneAuctionMaster == None
		return
	endif
	float zOffset = subject.GetHeadingAngle(SceneAuctionMaster.GetActorRef())
	;subject.SetAngle(subject.GetAngleX(), subject.GetAngleY(), subject.GetAngleZ() + zOffset)
	subject.TranslateTo(subject.X, subject.Y, subject.Z, subject.GetAngleX(), subject.GetAngleY(), subject.GetAngleZ() + zOffset, 0, 300)
EndFunction

ReferenceAlias Function FreeSlaveSlot()
	int n = SlaveRefs.length
	int i = 0
	while i < n
		if SlaveRefs[i].GetRef() == None
			return SlaveRefs[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function SlaveSlot(Actor slave)
	int n = SlaveRefs.length
	int i = 0
	while i < n
		if SlaveRefs[i].GetActorRef() == slave
			return SlaveRefs[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

; returns parent city of specified location, or none if not in a city
Location Function CityLocation(Location loc)
	if (loc == None)
		return None
	elseif ((DawnstarLocation.IsChild(loc)) || (loc == DawnstarLocation))
		return DawnstarLocation
	elseif ((MarkarthLocation.IsChild(loc)) || (loc == MarkarthLocation))
		return MarkarthLocation 
	elseif ((RiftenLocation.IsChild(loc)) || (loc == RiftenLocation))
		return RiftenLocation 
	elseif ((FalkreathLocation.IsChild(loc)) || (loc == FalkreathLocation))
		return FalkreathLocation 
	elseif ((RiverwoodLocation.IsChild(loc)) || (loc == RiverwoodLocation))
		return RiverwoodLocation 
	elseif ((SolitudeLocation.IsChild(loc)) || (loc == SolitudeLocation))
		return SolitudeLocation 
	elseif ((RoriksteadLocation.IsChild(loc)) || (loc == RoriksteadLocation))
		return RoriksteadLocation 
	elseif ((MorthalLocation.IsChild(loc)) || (loc == MorthalLocation))
		return MorthalLocation 
	elseif ((IvarsteadLocation.IsChild(loc)) || (loc == IvarsteadLocation))
		return IvarsteadLocation 
	elseif ((HelgenLocation.IsChild(loc)) || (loc == HelgenLocation))
		return HelgenLocation 
	elseif ((WinterholdLocation.IsChild(loc)) || (loc == WinterholdLocation))
		return WinterholdLocation 
	elseif ((WindhelmLocation.IsChild(loc)) || (loc == WindhelmLocation))
		return WindhelmLocation 
	elseif ((WhiterunLocation.IsChild(loc)) || (loc == WhiterunLocation))
		return WhiterunLocation 
	elseif ((BrumaLocation != None) && ((BrumaLocation.IsChild(loc)) || (loc == BrumaLocation)))
		return BrumaLocation 
	else
		return None
	endif
EndFunction

; Slavery level in specified location.  returns -1 if not a city
int Function EvaluateSlaveryLevel(Location l)
	Location city = CityLocation(l)
	Aygas.IsInBruma = false
	if (city == None)
		SlaveryLevelAtLocation = -1
	elseif (Aygas.SCheatCities)
		SlaveryLevelAtLocation = 5
	elseif (city == DawnstarLocation)
		SlaveryLevelAtLocation = DawnstarSlavery
	elseif (city == MarkarthLocation)
		SlaveryLevelAtLocation = MarkarthSlavery
	elseif (city == RiftenLocation)
		SlaveryLevelAtLocation = RiftenSlavery
	elseif (city == FalkreathLocation)
		SlaveryLevelAtLocation = FalkreathSlavery
	elseif (city == RiverwoodLocation)
		SlaveryLevelAtLocation = RiverwoodSlavery
	elseif (city == SolitudeLocation )
		SlaveryLevelAtLocation = SolitudeSlavery
	elseif (city == RoriksteadLocation)
		SlaveryLevelAtLocation = RoriksteadSlavery
	elseif (city == MorthalLocation)
		SlaveryLevelAtLocation = MorthalSlavery
	elseif (city == IvarsteadLocation )
		SlaveryLevelAtLocation = IvarsteadSlavery
	elseif (city == HelgenLocation)
		SlaveryLevelAtLocation = HelgenSlavery
	elseif (city == WinterholdLocation)
		SlaveryLevelAtLocation = WinterholdSlavery
	elseif (city == WindhelmLocation)
		SlaveryLevelAtLocation = WindhelmSlavery
	elseif (city == WhiterunLocation)
		SlaveryLevelAtLocation = WhiterunSlavery
	elseif (city == BrumaLocation )
		SlaveryLevelAtLocation = BrumaSlavery
		Aygas.IsInBruma = true
	else
		SlaveryLevelAtLocation = -1
	endif
	return SlaveryLevelAtLocation
;	debug.notification(city.GetName() + " : " + SlaveryLevelAtLocation)
EndFunction

float Function DifficultyFactor()
	if (Aygas.SDifficulty == 0)
		return 1.5
	elseif (Aygas.SDifficulty == 1)
		return 2.3
	else
		return 3.3
	endif
EndFunction

Function BidderWave()
	string anim
	int i = utility.randomint(0,2)
	if (i == 0)
		anim = "idlecomethisway"
	elseif (i == 1)
		anim = "idlepointfar_02"
	else
		anim = "idlewave"
	endif
	if (Bidder.GetRef() != None)
		AYGASInter.SendAnimationEvent(Bidder.getActorRef(), anim)
	endif
EndFunction

aygasCoreScript Property AYGAS Auto
aygasPropsScript Property PropsScript Auto

Location Property DawnstarLocation auto
Location Property MarkarthLocation auto
Location Property RiftenLocation auto
Location Property FalkreathLocation auto
Location Property RiverwoodLocation auto
Location Property SolitudeLocation auto
Location Property RoriksteadLocation auto
Location Property MorthalLocation auto
Location Property IvarsteadLocation auto
Location Property HelgenLocation auto
Location Property WinterholdLocation auto
Location Property WindhelmLocation auto
Location Property WhiterunLocation auto
Location Property BrumaLocation auto Conditional Hidden

int Property DawnstarSlavery auto conditional Hidden	; Indicates the level of slavery in each town
int Property MarkarthSlavery auto conditional Hidden		; 0 = None, 1 = Underground, 2 = Some slavery, 3 = Open slavery, 4 = Accepted, 5 = Participating
int Property RiftenSlavery auto conditional Hidden
int Property FalkreathSlavery auto conditional Hidden
int Property RiverwoodSlavery auto conditional Hidden
int Property SolitudeSlavery auto conditional Hidden
int Property RoriksteadSlavery auto conditional Hidden
int Property MorthalSlavery auto conditional Hidden
int Property IvarsteadSlavery auto conditional Hidden
int Property HelgenSlavery auto conditional Hidden
int Property WinterholdSlavery auto conditional Hidden
int Property WindhelmSlavery auto conditional Hidden
int Property WhiterunSlavery auto conditional Hidden
int Property BrumaSlavery auto conditional Hidden

Location[] Property EventLocations auto Hidden
int Property EventLocationCount auto Hidden
int Property SlaveryLevelAtLocation auto conditional Hidden
float Property LastEventDate Auto Hidden
float Property PlannedEventDate Auto Hidden
Location Property EventLocation Auto conditional Hidden
LocationAlias Property EventLocationAlias Auto
string Property EventLocationName Auto Hidden
bool Property EventLocationIsBruma Auto conditional Hidden	; For dialogue
int Property EventLocationCode Auto Conditional Hidden		; Follows location variable list above, starting at 1 = Dawnstar

bool Property ActivateAuctionPackages Auto Conditional Hidden
int Property AuctionSalePhase Auto Conditional Hidden
float Property AuctionTargetPrice Auto Conditional Hidden
float Property AuctionCurrentPrice Auto Conditional Hidden
bool Property AuctionSlaveFemale Auto conditional Hidden
int Property AuctionSlaveType Auto Conditional Hidden
bool Property AuctionSlaveObedient Auto Conditional Hidden
float[] Property SpectatorPrice Auto Hidden
actor[] Property Bidders Auto Hidden
int Property NrBidders Auto Hidden
actor Property LastBidder Auto Hidden
bool Property AllowPlayerAction Auto Conditional Hidden
bool Property PerformedPlayerAction Auto Conditional Hidden
int Property PlayerPrice Auto Hidden
int Property PlayerLastBid Auto Hidden
int Property NrPlayerSlaves Auto Conditional Hidden
int Property SlaveOnBlockNr Auto Conditional Hidden
int Property PlayerEarnings Auto Conditional Hidden
bool Property SlaveTransferInProgress Auto Conditional Hidden
bool Property PlayerSlaveInFight Auto Conditional Hidden
int Property PlayerBetInRound Auto Conditional Hidden
bool Property PlayerBetOnRed Auto Hidden
int Property PlayerBetAmount Auto Hidden

int Property RedRoundsWon Auto Conditional Hidden		; Red = fighter1 / fighter3, blue = fighter2 / fighter4
bool Property RedWonThisRound Auto Conditional Hidden
bool Property WinnerIsFemale Auto Conditional Hidden
int Property RoundsFought Auto Conditional Hidden
int Property PlayerWinnings Auto Conditional Hidden

ReferenceAlias Property SceneMarker Auto
ReferenceAlias Property SceneAuctionMaster Auto
ReferenceAlias Property ScenePitboss Auto
ReferenceAlias Property SceneGuard1 Auto
ReferenceAlias Property SceneGuard2 Auto
ReferenceAlias Property UnwantedActor Auto
ReferenceAlias Property UnwantedActorMarker Auto

ReferenceAlias[] Property SpectatorRefs Auto
ReferenceAlias[] Property SlaveRefs Auto
ReferenceAlias[] Property OwnerRefs Auto

ReferenceAlias Property SlaveOnBlock Auto
ReferenceAlias Property Bidder Auto

ReferenceAlias Property Fighter1 Auto
ReferenceAlias Property Fighter2 Auto

Actor Property SlaveCandidate01 Auto Hidden
Actor Property SlaveCandidate02 Auto Hidden
Actor Property SlaveCandidate03 Auto Hidden
Actor Property SlaveCandidate04 Auto Hidden
Actor Property SlaveCandidate05 Auto Hidden
Actor Property SlaveCandidate06 Auto Hidden

int Property EventStage Auto Conditional Hidden		; -1 marked for deactivation, 1 = Location picked, 2 = location set up, 3 = Queued for start, 4 = Starting
bool Property isAuction Auto Conditional Hidden
bool Property EventActorsPicked Auto Hidden		; true if actors for event have been selected.  Happens in stage 2 or 3 when player visits the location
bool Property EventSlavesPicked Auto Hidden

ObjectReference Property FightMarker Auto
ObjectReference Property CageMarker Auto
ObjectReference Property Cage Auto
ObjectReference Property CageZap8 Auto
ObjectReference Property SlaveStock2 Auto
ObjectReference Property SlaveStock3 Auto
ObjectReference Property Brazier1 Auto
ObjectReference Property Brazier2 Auto
ReferenceAlias Property CageMarkerRef Auto
ReferenceAlias Property StockMarkerRef Auto
ReferenceAlias Property FightMarkerRef Auto

ObjectReference Property DawnstarMarker auto
ObjectReference Property MarkarthMarker auto
ObjectReference Property RiftenMarker auto
ObjectReference Property SolitudeMarker auto
ObjectReference Property WinterholdMarker auto
ObjectReference Property WindhelmMarker auto
ObjectReference Property WhiterunMarker3 auto
ObjectReference Property BrumaMarker auto Hidden

ObjectReference Property FalkreathMarker auto
ObjectReference Property RiverwoodMarker auto
ObjectReference Property RoriksteadMarker auto
ObjectReference Property MorthalMarker auto
ObjectReference Property IvarsteadMarker2 auto
ObjectReference Property HelgenMarker auto

Scene Property AuctionScene01 Auto
Scene Property AuctionSellScene Auto
Scene Property AuctionSceneEnd Auto
Scene Property AuctionSceneCancel Auto

Scene Property FightScene01 Auto
Scene Property FightSceneCancel Auto
Scene Property FightBoutScene Auto
Scene Property FightEndScene2 Auto

ObjectReference Property WRHeimsk Auto
Objectreference Property WRMovemarker Auto

bool Property TimerRunning Auto Conditional Hidden
bool Property TimerStartBout2 Auto Hidden
Actor Property Guard1 Auto
Actor Property Guard2 Auto

Armor Property ArmorLeather Auto
Armor Property ArmorHatRed Auto
Armor Property ArmorHatBlue Auto
Weapon Property WeaponMace Auto

GlobalVariable Property RandomDragonsOff Auto
int Property DragonsWereOff Auto Hidden
