Scriptname PHHSHHunterOperation extends Quest Conditional

Event OnInit()
	DoorOutside.Lock(false, true)
EndEvent

Function MarkForAuction(Actor slave, bool doAuction)
	if (doAuction)
		slave.SetFactionRank(ReservedFaction, 0)
	else
		slave.RemoveFromFaction(ReservedFaction)
	endif
	CountAuctionSlaves()
EndFunction

Function Collect()
	Game.GetPlayer().AddItem(AuctionQst.Gold, Math.Floor(TotalValue * 0.8))
	TotalValue = 0
EndFunction

Function StoreForAuction(Actor slave)
	PHSF.LockupInHunter(slave)
	if (PHSF.SlaveRef(slave) != None)
		slave.SetFactionRank(ReservedFaction, 0)
		CountAuctionSlaves()
	endif
EndFunction

Function BuySlaveCart(int price)
	if (PHSF.HasSlaveCart)
		Game.GetPlayer().RemoveItem(AuctionQst.gold, price)
		pahscCoreScript q = Game.GetFormFromFile(0x00000D62, "PAHSlaveCart.esp") As pahscCoreScript
		if (q != None)
			q.SetObjectiveDisplayed(10, true)
			q.SlaveCartBought = true
			SlaveCartBought = true
		endif
	endif
EndFunction


Function OpenDoors(Actor guard)
	bool downstairs =  (Game.GetPlayer().Z < 100)
	ObjectReference[] doors = new ObjectReference[4]
	ObjectReference closestDoor = JailDoorForReference(Game.GetPlayer())
	if ((downstairs) && (closestDoor != None)) 
		; Open cell door immediately
		closestDoor.SetOpen(true)
	endif
	GuardSlot(guard).OpenDoor(DoorOutside)
	DoorStairs.Lock(false, true)
	DoorBasementN.Lock(false, true)	
	DoorOutside.Lock(false, true)
EndFunction

Function ResetGuards()
	Barkeep.SetFactionRank(PHSF.AuctionFaction, 0)
	Barkeep.EvaluatePackage()
	Actor grd1 = guard1.GetActorRef()
	Actor grd2 = guard2.GetActorRef()
	GuardSlot(grd2).Wait()
	GuardSlot(grd1).Wait()
EndFunction

Function PlanAuction()
	AuctionStage = 1
	GameTimeDay = math.floor(Utility.GetCurrentGameTime())
	Guest1.Enable()
	Guest2.Enable()
	Guest3.Enable()
	Guest4.Enable()
	Guest5.Enable()
	BarkeepSlot.ForceRefTo(barkeep)
	RegisterForUpdate(5)
	TotalValue = 0
	PlayerSlaveCount = 0
	AuctionSlaveCount = 0
EndFunction

Function AuctionToStage5()
	Barkeep.SetFactionRank(PHSF.AuctionFaction, 5)
	ReferenceAlias slaveSlot = NextSlot()
	if (slaveSlot == None)
;		Barkeep.Say(TopicAuctionEnd)
		SayTopic(Barkeep, 1)
		utility.wait(15)
		DoorOutside.Lock(false, true)
		if ((!AuctionQst.IsCompleted()) && (AuctionQst.GetStage() == 30))
			AuctionQst.SetStage(40)
		endif
		AuctionStage = 10
		RegisterForSingleUpdateGameTime(0.4)
	else
		if (AuctionSlaveCount > 0)
;			Barkeep.Say(TopicNextLot)
			SayTopic(Barkeep, 7)
		endif
		Actor grd = guard2.GetRef() as Actor
		GuardTarget(grd).ForceRefTo(slaveSlot.GetRef())
		SlaveOnBlock.ForceRefTo(slaveSlot.GetRef())
		AuctionToStage6()
	endif
EndFunction

Function AuctionToStage6()
	Actor grd = guard2.GetRef() as Actor
	Actor slave = GuardTarget(grd).GetRef() as Actor
	PHHSHHouseSlave slaveSlot = PHSF.SlaveRef(slave)
	slaveSlot.Wait()
	slaveSlot.StopPosing(slave)
	slave.AddToFaction(PHSF.InSceneFaction)
	LockCellDoors(false)
	grd.SetFactionRank(PHSF.GuardFaction, 6)
	grd.EvaluatePackage()

	Slavevalue = PHSF.Economics.SpecialValue(slave)
	praise = PHSF.Economics.AuctionEval(slave) 
	CurrentValue = SlaveValue / 2
	PHSF.SlaveTarget(slave).ForcerefTo(PilloryX)

	AuctionSlaveCount += 1

	utility.wait(3)
	slaveSlot.GoOnRack()
	Ticks = 0
	AuctionStage = 6
EndFunction

Function AuctionToStage7()
	Actor slave = SlaveOnBlock.GetRef() as Actor
	LockCellDoors(true)
	AuctionStage = 7
	SayTopic(Barkeep, 10)
	PlayerBid = 0
	if (slave.GetFactionRank(ReservedFaction) == 1)
		debug.notification("Press Enter to bid for this slave");
		RegisterForKey(28)
	else
		UnregisterForKey(28)
	endif
EndFunction

Function ExitAuction()
	AuctionStage = 0
	UnregisterForKey(28)

	while (NextSlot() != None)
		Actor slave = NextSlot().GetActorRef()
		int value = PHSF.Economics.SpecialValue(slave)
		TotalValue += value
		slave.RemoveFromFaction(ReservedFaction)
		PHSF.SlaveRef(slave).Clear()
		PHSF.DeleteSlave(slave)
;		slave.Disable()
	endwhile

	if ((!AuctionQst.IsCompleted()) && (AuctionQst.GetStage() == 30))
		AuctionQst.SetStage(40)
	endif
EndFunction

Event OnKeyDown(int keyCode)
	if (Game.GetPlayer().GetItemCount(AuctionQst.Gold) >= CurrentValue)
		Debug.Notification("You have bid for this slave")
		PlayerBid = CurrentValue
	else
		Debug.Notification("You lack the gold to bid that high")
	endif
EndEvent

Event OnUpdate()
;	debug.notification("Auction stage: " + AuctionStage)

	Actor grd1 = Guard1.GetRef() as Actor
	Actor grd2 = Guard2.GetRef() as Actor
	grd1.EvaluatePackage()
	grd2.EvaluatePackage()
;	Actor s = SlaveOnBlock.GetActorRef()
;	if (s != none)
;		s.EvaluatePackage()
;	endif

;(AuctionQst.GetStage() == 35) &&
	if ( (AuctionStage > 0) && (Game.GetPlayer().GetCurrentLocation() != RestlessHunterLocation))
		; End the auction
		ExitAuction()
		return
	endif

	if (AuctionStage == 0)
		ResetGuards()
		DoorOutside.Lock(false, true)
		AuctionMarker.Disable()
		Guest1.Disable()
		Guest2.Disable()
		Guest3.Disable()
		Guest4.Disable()
		Guest5.Disable()
		SlaveOnBlock.ForceRefTo(None)
		UnregisterForUpdate()

	elseif (AuctionStage == 1)
		float t = utility.GetCurrentGameTime()
		if (GameTimeDay != math.floor(t))
			;debug.notification("Day passed")
			if (t - math.floor(t) > 0.33)
				debug.notification("You missed the slave auction")				
				AuctionStage = 2
				RegisterForSingleUpdateGameTime(4)
			elseif (Game.GetPlayer().GetCurrentLocation() != RestlessHunterLocation)
				debug.notification("You slept through the slave auction")
				DoorOutside.Lock(true, true)
				DoorStairs.Lock(false, true)
				DoorBasementN.Lock(false, true)	
				AuctionStage = 2
				AuctionMarker.Enable()
				RegisterForSingleUpdateGameTime(2)
			else
				if ((!AuctionQst.IsCompleted()) && (AuctionQst.GetStage() == 21))
					AuctionQst.SetStage(30)
				endif
				AuctionStage = 3
				AuctionMarker.Enable()
				DoorOutside.Lock(true, true)
;				Barkeep.Say(TopicAuctionStart)
				SayTopic(grd1, 2)
				Barkeep.SetFactionRank(PHSF.AuctionFaction, 3)
				Barkeep.EvaluatePackage()
				GuardSlot(grd1).WaitAtMarker(Guard1AuctionMarker)
				RegisterForSingleUpdateGameTime(0.5)
			endif
		endif

	elseif (AuctionStage == 6)
		Actor slave = SlaveOnBlock.GetRef() as Actor
		if (slave.GetSitState() >= 3)
			AuctionToStage7()
		elseif (slave.GetDistance(PilloryX) < 50)
			Ticks += 1
			if (Ticks > 2)
				AuctionToStage7()
			endif
		elseif ((math.abs(slave.X - oldX) < 50) && (math.abs(slave.Y - oldY) < 50))
			Ticks += 1
;			debug.notification("stopped")
			if (ticks > 4)
				slave.MoveTo(PilloryX)
				AuctionToStage7()
			elseif (ticks > 2)
;				debug.notification("teleport")
				slave.MoveTo(grd2)
				slave.SetDontMove(false)
				slave.RemoveFromFaction(PHSF.HousePoseFaction)
				Debug.SendAnimationEvent(slave, "IdleForceDefaultState")
			endif
		endif
		oldX = slave.X
		oldY = slave.Y
	elseif (AuctionStage == 7)
;		Barkeep.Say(TopicOpenBid)
	else
;		AuctionStage = 0

	endif
EndEvent

Event OnUpdateGameTime()
	if (AuctionStage == 2)
		AuctionStage = 0
		if ((!AuctionQst.IsCompleted()) && (AuctionQst.GetStage() == 21))
			AuctionQst.SetStage(22)
		endif
	elseif (AuctionStage == 3)
		AuctionStage = 4
;		(Guard1.GetRef() as Actor).Say(TopicAuctionStartSit)
		SayTopic((Guard1.GetRef() as Actor), 3)
		BarkeepSlot.ForceRefTo(barkeep)
		Barkeep.SetFactionRank(PHSF.AuctionFaction, 4)
	elseif (AuctionStage == 10)
		AuctionStage = 11
		ResetGuards()
		RegisterForSingleUpdateGameTime(2)
	elseif (AuctionStage == 11)
		AuctionStage = 0
	endif
EndEvent

Function SlaveAnnounced()
;	Barkeep.Say(TopicOpenBid)
	SayTopic(Barkeep, 8)
EndFunction

Function NextBid()
	utility.wait(5)
	int i = (SlaveValue) / (2*Utility.RandomInt(3,7))

	if ((currentValue < 1000) && (i < 100))
		i = 100
	elseif ((currentValue < 3500) && (i < 200))
		i = 200
	elseif (i < 500 )
		i = 500
	endif

;	debug.notification("Current:"+ CurrentValue + "   Inc:" + i + "  Actual:" + SlaveValue)
	CurrentValue += i;

	if (CurrentValue >= SlaveValue)
		if (PlayerBid >= CurrentValue - i)		; Player had the last high bid, end the auction at that price
			CurrentValue -= i
		endif
;		Barkeep.Say(TopicEndBid)
		SayTopic(Barkeep, 5)
	else
;		Barkeep.Say(TopicNextBid)	
		SayTopic(Barkeep, 6)
	endif
EndFunction

Function EndBid(int finalPrice)
	UnregisterForKey(28)
	bool playerSlave = false
	Actor slave = SlaveOnBlock.GetActorRef()
	if (slave.getFactionRank(ReservedFaction) != 1)
		TotalValue += finalPrice
		PlayerSlaveCount += 1
;		Barkeep.Say(TopicBuyer)
		SayTopic(Barkeep, 4)
	else
		if (PlayerBid >= CurrentValue)
;			Barkeep.Say(TopicPlayerWins)
			SayTopic(Barkeep, 9)
;			debug.Notification("Won bid at " + finalPrice)
			playerSlave = true
		else
			SayTopic(Barkeep, 4)
;			Barkeep.Say(TopicBuyer)
		endif
	endif
	Actor grd1 = guard1.GetActorRef()
	Actor grd2 = guard2.GetActorRef()

	PHHSHHouseSlave slaveSlot = PHSF.SlaveRef(slave)
	slave.RemoveFromFaction(ReservedFaction)
;	slaveSlot.Wait()
	if (playerSlave)
		SlaveSlot.Wait()
		GuardSlot(grd1).PrepareToEscort(slave)
		slave.UnequipItem(PHSF.AuctionSpawnedToken )
		Utility.Wait(0.2)
		slave.RemoveItem(PHSF.AuctionSpawnedToken )
		Game.GetPlayer().RemoveItem(AuctionQst.Gold, finalPrice)
	else
		PHSF.SlaveTarget(slave).ForceRefTo(grd1)		
		GuardSlot(grd1).EscortToDoor(DoorOutside, slave)
;	utility.wait(2)
		slaveSlot.FollowTarget()
	endif

	GuardTarget(grd2).Clear()
	GuardSlot(grd2).WaitAtMarker(Guard1AuctionMarker)

	utility.wait(8)
	SlaveOnBlock.Clear()
	AuctionToStage5()
EndFunction


ReferenceAlias Function GuardTarget(Actor guard)
	if (guard == Guard1.GetRef())
		return GuardTarget1
	elseif (guard == Guard2.GetRef())
		return GuardTarget2
	else
		return None
	endif
EndFunction

PHHSHGuardFunctions Function GuardSlot(Actor guard)
	if (guard == Guard1.GetRef())
		return Guard1 as PHHSHGuardFunctions 
	elseif (guard == Guard2.GetRef())
		return Guard2 as PHHSHGuardFunctions 
	else
		return None
	endif
EndFunction

ObjectReference Function JailDoorForReference(ObjectReference ref)
	if (ref.Z > 100)
		return None
	endif

	if ((ref.X <-320) || (ref.X > 640) || (ref.y < -560) || (ref.y > 60) || ((ref.y> -370) && (ref.y < -140)  ))
		return None
	endif

	if (Ref.X < -130)
		if (ref.Y< -300)
			return DoorCell7
		else
			return DoorCell8
		endif
	elseif (ref.X < 130)
		if (ref.Y< -300)
			return DoorCell3
		else
			return DoorCell6
		endif
	elseif (ref.X < 385)
		if (ref.Y< -300)
			return DoorCell2
		else
			return DoorCell5
		endif
	else
		if (ref.Y< -300)
			return DoorCell1
		else
			return DoorCell4
		endif
	endif
EndFunction

Function LockCellDoors(bool lock)
	DoorCell1.Lock(lock, true)
	DoorCell2.Lock(lock, true)
	DoorCell3.Lock(lock, true)
	DoorCell4.Lock(lock, true)
	DoorCell5.Lock(lock, true)
	DoorCell6.Lock(lock, true)
	DoorCell7.Lock(lock, true)
	DoorCell8.Lock(lock, true)
EndFunction

ReferenceAlias Function NextSlot()
	int n = PHSF.HunterSlot.length
	int i = 0
	while i < n
		Actor akRef = PHSF.HunterSlot[i].GetActorRef()
		if akRef != None && akRef.IsInFaction(ReservedFaction)
			return PHSF.HunterSlot[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

Function CountAuctionSlaves()
	AuctionSlaveCount = 0
	int n = PHSF.HunterSlot.length
	int i = 0
	while i < n
		AuctionSlaveCount += SlotIsForAuction(PHSF.HunterSlot[i])
		i += 1
	endwhile
EndFunction

int Function SlotIsForAuction(referenceAlias slot)
	if ((slot.GetRef() != None)&& (slot.GetActorRef().IsInFaction(ReservedFaction)) )
		return 1
	else
		return 0
	endif
EndFunction

Function SayTopic(Actor a, int topicnr)
	int i = 0
	while ((Speaker.GetRef() != None) && (i<30))
		utility.wait(1)
		i += 1
	endwhile

	TopicIndex = topicnr
	Speaker.ForceRefTo(a)
	a.EvaluatePackage()
	utility.wait(1)
	Speaker.Clear()
EndFunction

ReferenceAlias Property Guard1 Auto
ReferenceAlias Property Guard2 Auto
ReferenceAlias Property GuardTarget1 Auto
ReferenceAlias Property GuardTarget2 Auto
ReferenceAlias Property BarkeepSlot Auto
ReferenceAlias Property SlaveOnBlock Auto
ReferenceAlias Property Speaker Auto

PHHSHStorageFunctions Property PHSF Auto
QF_PAHONobleDesires_06028A75 Property AuctionQst Auto

ObjectReference Property DoorCell1 Auto
ObjectReference Property DoorCell2 Auto
ObjectReference Property DoorCell3 Auto
ObjectReference Property DoorCell4 Auto
ObjectReference Property DoorCell5 Auto
ObjectReference Property DoorCell6 Auto
ObjectReference Property DoorCell7 Auto
ObjectReference Property DoorCell8 Auto
ObjectReference Property DoorOutside Auto
ObjectReference Property DoorStairs Auto
ObjectReference Property DoorBasementN Auto

ObjectReference Property Guard1AuctionMarker Auto
Faction Property ReservedFaction Auto

int Property AuctionStage = 0 Auto Conditional
int Property GameTimeDay Auto
int Property Ticks Auto
int Property AuctionSlaveCount = 0 Auto Conditional

Actor Property Barkeep Auto

Location Property RestlessHunterLocation Auto

Topic Property TopicAuctionStart Auto
Topic Property TopicAuctionStartSit Auto
Topic Property TopicOpenBid Auto
Topic Property TopicNextBid Auto
Topic Property TopicEndBid Auto
Topic Property TopicBuyer Auto
Topic Property TopicPlayerWins Auto
Topic Property TopicNextLot Auto
Topic Property TopicAuctionEnd Auto

ObjectReference Property AuctionMarker Auto
Actor Property Guest1 Auto
Actor Property Guest2 Auto
Actor Property Guest3 Auto
Actor Property Guest4 Auto
Actor Property Guest5 Auto

ObjectReference Property PilloryX Auto

Topic Property praise Auto 

int Property SlaveValue Auto  Conditional
int Property PlayerBid Auto  Conditional
int Property CurrentValue Auto  Conditional
int Property TotalValue Auto Conditional
int Property PlayerSlaveCount Auto Conditional

Key Property BasementKey Auto
Key Property UpstairsKey Auto

Package Property PackageSay Auto

float Property oldX auto
float Property oldY auto

bool Property SlaveCartBought Auto Conditional
int Property TopicIndex Auto Conditional
int Property PraiseIndex Auto Conditional

; Auction stages
; 0 - Nothing
; 1 - Auction planned, spawn and assemble attendees
; 2 - Auction failed, no player present.  Remove attendees
; 3 - Auction starts, spawn remaining attendees, move to basement, bartender lock door
; 4 - Auction master and guards to position
; 5 - Guard fetch slave
; 6 - Guard position slave
; 7 - Bidding process
; 8 - Guard escort slave to door, teleport to outside shack
; 9 - Despawn slave, determine next lot and go to stage 4
; 10 - Bartender unlocks door, attendees leave
; 11 - despawn attendees
; despawn sold slaves and attendees upon load / unload cycle of cell
; Attendee types: present in bar, visiting, visiting and buying (will loiter outside after auction)
