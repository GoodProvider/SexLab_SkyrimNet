Scriptname phhshAuctionScript extends Quest  

PHHSHInterface Property PHHSHInter Auto

int freeSlots
int spawnSlots

Event OnInit()
	HSH.DebugLog("Auction script started")
	RegisterForUpdateGameTime(24)
EndEvent

Event OnUpdateGameTime()
	; Check if any slaves should be spawned for auction
	HSH.DebugLog("Auction script spawn timer")
	if ((HSH.SkipQuests) || (EndQuest.IsCompleted()))
		if ((SpawnPoint.GetParentCell() == None) || (!SpawnPoint.GetParentCell().IsAttached()))
			SpawnAuctionSlaves()
		else
			HSH.DebugLog("Auction spawn cancelled, cell active")
		endif
	endif
EndEvent

Function FixSpawnTimer()
	UnregisterForUpdateGameTime()
	RegisterForUpdateGameTime(12)
EndFunction

Function SpawnAuctionSlaves()
;	UnregisterForUpdateGameTime()
;	RegisterForSingleUpdateGameTime(12)
	freeSlots = 0
	spawnSlots = 0
	
	HSH.DebugLog("Auction spawn check")
	;debug.notification("Hunter slave spawn")
	int n = HSH.HunterSlot.length
	int i = 0
	while i < n
		CheckHunterSlot(HSH.HunterSlot[i])
		i += 1
	endwhile
	
	if (spawnSlots >= 3)
		; Delete a Random slave
		ReferenceAlias deleteSlot = None
		i = Utility.RandomInt(0, n-(1))
		int wrapped = 0

		while ((deleteSlot == None) && (wrapped < 2))
			deleteSlot = GetAuctionSlot(i)
			i += 1
			if (i >= 14)
				i = 0
				wrapped += 1
			endif
		endwhile

		if (deleteSlot != None)
			HSH.DebugLog("Delete auction slave to make room")
			Actor del = deleteSlot.GetActorRef()
			if (HSH.HasAygas) && (del.GetActorBase().IsUnique() )
				; Dump unique slaves into Aygas slave pool
				HSH.Aygas.StoreSlave(del)
			else
				deleteSlot.GetActorRef().Delete()
			endif
			deleteSlot.Clear()
			spawnSlots -= 1
		else
				HSH.DebugLog("3 slots, None found to delete")
		endif
	endif

	if ((freeSlots > 0) && (spawnSlots < 3))
		; Spawn a new slave
		ReferenceAlias houseSlot = HSH.GetFreeslotHunter()
		if (houseSlot != None)
			; Spawn slave and register in Restless Hunter	
			Actor slave	
			if (!HSH.UsebanditSlaves)		
				slave = SpawnPoint.PlaceAtme(SlaveList2) as Actor
			else
				slave = SpawnPoint.PlaceAtme(SlaveListAlt) as Actor
				slave.RemoveFromFaction(BanditFaction)
				slave.SetAV("aggression", 0)
				slave.StopCombat()

				ObjectReference c = slave.PlaceAtme(HSH.TransferBox)
				c.MoveTo(slave, 0, 0, -1000, false)
				slave.RemoveAllItems(c, true, true)	; Move items to box
				slave.SetOutfit(None, None);		; Clear outfit
				c.delete()
				slave.EquipItem(HSH.Collar, true, true)
				slave.EquipItem(HSH.LegChains, true, true)
				slave.EquipItem(HSH.AuctionSpawnedToken, true, true)
				slave.EquipItem(SlaveOutfit, true, true)
				slave.SetDisplayName("Slave")
			endif

			HSH.DebugLog("New slave " + slave.GetDisplayName())
			HSH.RegisterSlaveInHouseWithType(slave, houseSlot, 101) ; 101 Hunter
			; Reserved for auction, and not player owned
			slave.SetFactionRank(HSH.PAHHouseReservedFaction , 1)

			(houseSlot as PHHSHHouseSlave).IsDressingCounter = 5; 		
			; Equip all inventory items
			utility.wait(1)
			i = slave.GetNumItems()
			while (i > 0)
				i -= 1
				slave.EquipItem(slave.GetNthForm(i))
				utility.wait(0.1)
			endwhile
			(houseSlot as PHHSHHouseSlave).StoreOutfit()

			; Assign Random training stats
			PHHSHInter.SetSubmissionTraining(slave, Utility.RandomInt(60, 90))
			PHHSHInter.SetCombatTraining(slave, Utility.RandomInt(20, 80))
			PHHSHInter.SetPoseTraining(slave, Utility.RandomInt(20, 80))
			PHHSHInter.SetRespectTraining(slave, Utility.RandomInt(20, 80))
			PHHSHInter.SetSexTraining(slave, Utility.RandomInt(20, 80))
			PHHSHInter.SetResignationTraining(slave, Utility.RandomInt(60, 90))
			PHHSHInter.SetHumiliationTraining(slave, Utility.RandomInt(30, 90))
			PHHSHInter.SetFearTraining(slave, Utility.RandomInt(30, 90))
			PHHSHInter.SetAngerTraining(slave, Utility.RandomInt(30, 90))

			utility.wait(1)
			(houseSlot as PHHSHHouseSlave).WaitInCell()
			slave.SetFactionRank(HSH.HouseCagedFaction , 1)
			;DOM_Actor akActor = houseSlot as DOM_Actor
			;akActor.OnUpdate()v ; Already handled by PHHSHHouseSlave
			;akActor.OnUpdateGameTime()
		else
			HSH.DebugLog("No free slot for new auction slave")
		endif
	endif
EndFunction

Function CheckHunterSlot(ReferenceAlias Slot)
	Actor slave = Slot.GetActorRef()
	if (slave == None)
		freeSlots += 1	
	elseif (slave.GetItemCount(HSH.AuctionSpawnedToken) > 0)
		spawnSlots += 1
	endif
EndFunction

ReferenceAlias Function GetAuctionSlot(int i)
	; Note: index = 0 - 13
	ReferenceAlias ref = HSH.HunterSlot[i]

	if ((ref != None) && (ref.GetActorRef() != None) && (ref.GetActorRef().GetItemCount(HSH.AuctionSpawnedToken) > 0) && \
		((HSH.HasAygas ) || (!ref.GetActorRef().GetActorBase().IsUnique()))	  )
		return ref
	else
		return None
	endif
EndFunction


phhshStorageFunctions Property HSH Auto
LeveledActor Property SlaveList2  Auto  
LeveledActor Property SlaveListAlt  Auto  
ObjectReference Property SpawnPoint Auto
Quest Property EndQuest Auto
Faction Property BanditFaction Auto
LeveledItem Property SlaveOutfit Auto