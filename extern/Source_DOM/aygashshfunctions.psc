Scriptname aygasHSHFunctions extends Quest  

bool Function HasHSH()
	bool hsh = (Game.GetModByname("PAH_HomeSweetHome.esp") != 255)
	if ((hsh) && (HSHFunctionsQuest == None))
		HSHFunctionsQuest = Game.GetFormFromFile(0x00008402, "PAH_HomeSweetHome.esp") As Quest 
	endif

	return hsh
	;return false		; Used in stub
EndFunction

Function DeregisterSlave(Actor slave)
	if ((HSHFunctionsQuest != None) && (slave.IsInFaction(Aygas.HSHHouseSlaveFaction)))
		(HSHFunctionsQuest as phhshStorageFunctions).DeregisterSlave(slave)
	endif
EndFunction

bool Function MoveSlaveToHunter(Actor slave)
	bool handled = false
	ReferenceAlias houseSlot = (HSHFunctionsQuest as phhshStorageFunctions).GetFreeslotHunter()
	if (houseSlot != None)
		slave.MoveTo((HSHFunctionsQuest as phhshStorageFunctions).HunterFunctions.Guard1AuctionMarker)
		slave.UnequipAll()
		slave.RemoveAllItems()
		Utility.Wait(1)
		slave.EquipItem((HSHFunctionsQuest as phhshStorageFunctions).AuctionSpawnedToken, true, true)
		slave.EquipItem(Aygas.ZazCollar, true, true)
		slave.EquipItem(Aygas.ZazLegIrons, true, true)
		Utility.Wait(1)
		(HSHFunctionsQuest as phhshStorageFunctions).RegisterSlaveInHouseWithType(slave, houseSlot, 101) ; 101 Hunter
		slave.SetFactionRank((HSHFunctionsQuest as phhshStorageFunctions).PAHHouseReservedFaction , 1)
		(houseSlot as PHHSHHouseSlave).StoreOutfit()
		Utility.Wait(1)
		slave.MoveTo((HSHFunctionsQuest as phhshStorageFunctions).HunterFunctions.Guard1AuctionMarker)
		(houseSlot as PHHSHHouseSlave).WaitInCell()
		DOM_Actor akActor = houseSlot as DOM_Actor
		; akActor.OnUpdate() ; already handled by aygasSlaveScript
		akActor.OnUpdateGameTime()
		handled = true
		Aygas.DebugMessage("Added to Hunter, reserved:" + slave.getFactionRank((HSHFunctionsQuest as phhshStorageFunctions).HunterFunctions.ReservedFaction))
	endif
	return handled
EndFunction

bool Function IsPlayerHouse()
	phhshStorageFunctions hshStorage = HSHFunctionsQuest as phhshStorageFunctions
	if hshStorage == None
		;Debug.Trace("aygasHSHFunctions hshStorage="+hshStorage)
		return false
	endif
	if Aygas == None
		Debug.Trace("aygasHSHFunctions Aygas="+Aygas)
		return false
	endif
	Cell current_cell = Game.GetPlayer().GetParentCell()
	bool is_permacell = false
	if current_cell == None
		;Debug.Trace("aygasHSHFunctions current_cell="+current_cell)
	else
		is_permacell = hshStorage.IsInPermaCell(current_cell)
		;Debug.Trace("aygasHSHFunctions is_permacell="+is_permacell)
	endif
	if is_permacell
		return true
	endif
	if Aygas.KwdPlayerHome == None
		Debug.Trace("aygasHSHFunctions KwdPlayerHome="+Aygas.KwdPlayerHome)
		return false
	endif
	Location current_loc = Game.GetPlayer().GetCurrentLocation()
	if current_loc == None
		;Debug.Trace("aygasHSHFunctions current_loc="+current_loc)
		return false
	endif
	bool has_keyword = current_loc.HasKeyword(Aygas.KwdPlayerHome)
	;Debug.Trace("aygasHSHFunctions has_keyword="+has_keyword)
	return has_keyword
EndFunction

Actor Function TaskmasterInCell(Cell c)
	return (HSHFunctionsQuest as phhshStorageFunctions).Taskmaster.TaskmasterInCell(c)
	return None
EndFunction

ObjectReference Function FindUnusedZAPFurniture(Actor slave, bool tryNearest, int tries)
	ObjectReference furni = None
	FormList fl = (HSHFunctionsQuest as phhshStorageFunctions).PortableFunctions.ZazFurnitureList()
	int i = tries

	while ((i > 0) && (furni == None))
		if ((tryNearest) && (i==tries))
			furni = Game.FindClosestReferenceOfAnyTypeInList(fl, slave.X, slave.Y, slave.Z, 4096)
		else
			furni = Game.FindRandomReferenceOfAnyTypeInList(fl, slave.X, slave.Y, slave.Z, 4096)
		endif
		if ( (furni != None) && ((furni.IsFurnitureInUse()) || (!furni.IsEnabled())) )
			furni = None
		endif
		i-= 1
	endwhile

	return furni
EndFunction

aygasCoreScript Property Aygas Auto
Quest Property HSHFunctionsQuest Auto Hidden