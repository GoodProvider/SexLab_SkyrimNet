Scriptname PHHSHFlexiStorage extends Quest  

PHHSHInterface Property PHHSHInter Auto

Function RegisterInCell(Actor akTarget)
	if akTarget == None
		return
	endif
	LogTrace("PHHSHFlexiStorage RegisterInCell "+akTarget.GetDisplayName())
	
	if !RegisterInSpecifiedCell(akTarget, None)
		LogTrace("PHHSHFlexiStorage RegisterInCell ERROR Failed to register "+akTarget.GetDisplayName())
		return
	endif
	
	PHHSHHouseSlave slot = SlaveRef(akTarget)
	if slot == None
		LogTrace("PHHSHFlexiStorage RegisterInCell ERROR Failed to register "+akTarget.GetDisplayName())
		return
	endif
	slot.PickDefaultMarkers()
	if (PHHSH.HasSlaveTats)
		PHHSHPortableCellScript c = PHHSH.PortableFunctions.HoldingCellRefForCell(akTarget.GetparentCell()) as PHHSHPortableCellScript 
		if c != None
			if (PHHSH.SlaveTatsFunctions.CheckArray(c.TattooNew))
				utility.wait(1)
				PHHSH.SlaveTatsFunctions.ApplyTats(akTarget, c.TattooNew)
			endif
		endif
	endif
EndFunction

Function RegisterInHomeCell(Actor akTarget)
	if akTarget == None
		return
	endif
	LogTrace("RegisterInHomeCell RegisterInCell "+akTarget.GetDisplayName())
	DOM_Actor akActor = GetSlaveActor(akTarget)
	if akActor != None
		LogTrace("RegisterInHomeCell RegisterInCell ERROR actor is already in cell "+akActor.GetName())
		return
	endif
	akActor = PHHSHInter.DOM.GetActor(akTarget)
	if akActor == None
		LogTrace("RegisterInHomeCell RegisterInCell ERROR could not find actor "+akTarget.GetDisplayName())
		return
	endif
	PHHSHPortableCellScript portableCell = akActor.hsh_home_cell as PHHSHPortableCellScript
	if portableCell == None
		LogTrace("RegisterInHomeCell RegisterInCell ERROR could not find actor "+akActor.GetName())
		Debug.Notification("Could not find home for "+akActor.GetName())
		akActor.hsh_home_cell = None
		return
	endif
	
	if !RegisterInSpecifiedCell(akTarget, portableCell.ParentCell)
		LogTrace("PHHSHFlexiStorage RegisterInCell ERROR Failed to register "+akTarget.GetDisplayName())
		return
	endif

	PHHSHHouseSlave slot = SlaveRef(akTarget)
	if slot == None
		LogTrace("PHHSHFlexiStorage RegisterInCell ERROR Failed to register "+akTarget.GetDisplayName())
		return
	endif
	slot.PickDefaultMarkers()
	if (PHHSH.HasSlaveTats)
		PHHSHPortableCellScript c = PHHSH.PortableFunctions.HoldingCellRefForCell(akTarget.GetparentCell()) as PHHSHPortableCellScript 
		if c != None
			if (PHHSH.SlaveTatsFunctions.CheckArray(c.TattooNew))
				utility.wait(1)
				PHHSH.SlaveTatsFunctions.ApplyTats(akTarget, c.TattooNew)
			endif
		endif
	endif
	slot.Travel(portableCell.CellButton)
EndFunction

bool Function RegisterInSpecifiedCell(Actor akTarget, Cell c)
	LogTrace("PHHSHFlexiStorage RegisterInSpecifiedCell akTarget="+akTarget+" cell="+c)
	bool newSlot = false
	if (c == None)
		c = akTarget.GetParentCell()
	endif
	bool detachedCell = (akTarget.GetParentCell() == None)


	PHHSHPortableCellScript portableCell = PHHSH.PortableFunctions.HoldingCellRefForCell(c) as PHHSHPortableCellScript 
	if (portableCell == None)
		debug.notification("This location has not been made ready to keep slaves")
		return false
	endif

	if (PHHSH.TransferInProgress)
		debug.notification("Please wait for the previous slave transfer to complete")
		return false
	endif
	LogTrace("PHHSHFlexiStorage RegisterInSpecifiedCell portableCell="+portableCell)
	PHHSH.TransferInProgress = true

	; Check if a slave slot is available
	PHHSHHouseSlave slot = SlaveRef(akTarget)
	LogTrace("PHHSHFlexiStorage RegisterInSpecifiedCell actor is already in slot?="+slot)
	if (slot == None)
		slot = GetFreeSlot()
		newSlot = true
	endif
	LogTrace("PHHSHFlexiStorage RegisterInSpecifiedCell choosen slot="+slot)
	if (slot == None)
		debug.notification("You cannot keep any more slaves")
		PHHSH.TransferInProgress = false
		return false
	endif

	; Remove auction medaillions
	if (akTarget.GetItemCount(PHHSH.AuctionSpawnedToken))
		akTarget.RemoveItem(PHHSH.AuctionSpawnedToken, 1, true)
	endif
	if (akTarget.GetItemCount(PHHSH.AuctionToken))
		akTarget.RemoveItem(PHHSH.AuctionToken, 1, true)
	endif

	; Check if an assistant is available to escort this slave
	int itype 
	if portableCell.IsInDoorCell()
		itype = 100 ; 100 House
	else
		itype = 102 ; 102 Camp
	endif
	if (Game.GetPlayer().GetParentCell() == c) && PHHSH.SlaveNeedsEscort(akTarget)
		PHHSHHouseSlave assistant = GetAssistantInCell(akTarget.GetParentCell()) as PHHSHHouseSlave 
;		debug.notification("Registering for test slot: " + akTarget.GetDisplayName() + "  Escort:" + assistant.getActorRef().GetDisplayName() )
		PHHSH.LockupSlaveInHouse(akTarget, slot, assistant, itype)
	else
		LogTrace("PHHSHFlexiStorage RegisterInSpecifiedCell register slave "+akTarget.GetDisplayName())
;		debug.notification("Registering for test slot: " + akTarget.GetDisplayName())
		PHHSH.RegisterSlaveInHouseWithType(akTarget, slot, itype)
		slot.Sandbox()
	endif

	; Recount is never forced.
	LogTrace("PHHSHFlexiStorage RegisterInSpecifiedCell add slave "+akTarget.GetDisplayName())
	portableCell.AddSlave(slot)

	;DOM_Actor akActor = (slot as ReferenceAlias) as DOM_Actor
	;akActor.OnUpdate() ; Already handled by PHHSHHouseSlave
	;akActor.OnUpdateGameTime()

	PHHSH.TransferInProgress = false
	utility.wait(3.0)

	if (portableCell.CellType == 2)
		portableCell.CheckIfGuarded()
	endif
	
	return true
EndFunction

Function SlaveExclaim(Actor akRef)
	PHHSH.ScenesSLA.Exclaim(akRef)
EndFunction

ReferenceAlias Function GetSlaveAlias(Actor akRef)
	if akRef == None
		return None
	endif
	int n = slotAliases.length
	int i = 0
	while i < n
		if slotAliases[i].GetActorRef() == akRef
			return slotAliases[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

Function CheckCellAliases(PHHSHPortableCellScript the_cell)
	if the_cell == None
		return
	endif
	LogTrace("PHHSHFlexiStorage CheckCellAliases checking cell "+the_cell.GetNameCellRef())
	int n = slotAliases.length
	int i = 0
	Cell parent_cell = the_cell.ParentCell
	if parent_cell == None
		return
	endif
	while i < n
		ReferenceAlias the_ref = slotAliases[i]
		if the_ref != None && the_ref.GetRef() != None
			Cell ref_cell = the_ref.GetRef().GetParentCell()
			if ref_cell == parent_cell
				if the_cell.GetSlaveIndex(the_ref) < 0
					LogTrace("PHHSHFlexiStorage CheckCellAliases found UNREGISTERED alias="+the_ref)
					the_cell.AddSlave(the_ref)
				else
					LogTrace("PHHSHFlexiStorage CheckCellAliases found registered alias="+the_ref)
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

PHHSHHouseSlave Function SlaveRef(Actor akRef)
	int n = slotAliases.length
	int i
	int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
	if rank == 100 || rank == 102 ; HSH Houses or Camps
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n
			if slotAliases[i].GetActorRef() == akRef
				return slotAliases[i] as PHHSHHouseSlave
			endif
		endif
	endif
	ReferenceAlias slot = GetSlaveAlias(akRef)
	if slot != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,100) ; 100 is HSH Houses
	endif
	return slot as PHHSHHouseSlave
EndFunction

DOM_Actor Function GetSlaveActor(Actor akRef)
	int n = slotAliases.length
	int i
	int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
	if rank == 100 || rank == 102 ; HSH Houses or Camps
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n
			if slotAliases[i].GetActorRef() == akRef
				return slotAliases[i] as DOM_Actor
			endif
		endif
	endif
	ReferenceAlias slot = GetSlaveAlias(akRef)
	if slot != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,100) ; 100 is HSH Houses
	endif
	return slot as DOM_Actor
EndFunction

ReferenceAlias Function GetSlaveTarget(Actor akRef)
	if akRef == None
		return None
	endif
	int n = slotAliases.length
	int m = targetAliases.length
	int i = 0
	while i < n && i < m
		if slotAliases[i].GetActorRef() == akRef
			return targetAliases[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function SlaveTarget(Actor akRef)
	int n = slotAliases.length
	int m = targetAliases.length
	int i
	if akRef.GetFactionRank(DOMSlaveManagerFaction) == 100 ; House
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n && i < m
			if slotAliases[i].GetActorRef() == akRef
				return targetAliases[i]
			endif
		endif
	endif
	ReferenceAlias target = GetSlaveTarget(akRef)
	if target != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,100) ; 100 is HSH Houses
	endif
	return target
EndFunction

ReferenceAlias Function GetAssistantInCell(Cell c)
	int n = slotAliases.length
	int i = 0
	while i < n
		if (CheckRefSlaveIsAvailable(slotAliases[i], c))
			return slotAliases[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

PHHSHHouseSlave Function GetFreeSlot()
	int n = slotAliases.length
	LogTrace("PHHSHFlexiStorage GetFreeSlot n="+n)
	int i = 0
	while i < n
		LogTrace("PHHSHFlexiStorage slotAliases i="+i+" alias="+slotAliases[i])
		if slotAliases[i] != None
			LogTrace("PHHSHFlexiStorage slotAliases i="+i+" actor="+slotAliases[i].GetActorRef())
			if slotAliases[i].GetActorRef() == None
				return slotAliases[i] as PHHSHHouseSlave 
			endif
		endif
		i += 1
	endwhile
	return None
EndFunction

bool Function CheckRefSlaveIsAvailable(ReferenceAlias slot, Cell c)
	Actor slave = slot.getActorRef()
	return ((slave != None) && (PHHSHInter.GetSubmissionTraining(slave) >= 70) && (!slave.IsInFaction(PHHSH.IsTraineeFaction)) && (!slave.IsInFaction(PHHSH.TaskAssignedFaction)) && (!slave.IsInFaction(PHHSH.IsTrainerFaction)) && (PHHSH.CheckRefSlaveIsAvailable(slot as PHHSHHouseSlave)) && (slave.GetParentCell() == c) )
EndFunction

Function CheckActorAliases()
	;LogTrace("CheckActorAliases checking DOM pointers")
	int n = slotAliases.length
	int i = 0
	int k = 0
	LogTrace("CheckActorAliases checking DOM pointers array size="+n)
	While i < n
		DOM_Actor akActor = slotAliases[i] as DOM_Actor
		if akActor.DOM01 != PHHSHInter.DOM
			LogTrace("CheckActorAliases alias "+i+" actor was not correctly set!")
			akActor.DOM01 = PHHSHInter.DOM
			k += 1
		endif
		if akActor.PlayerRef != PHHSHInter.DOM.PlayerRef
			;LogTrace("CheckActorAliases alias "+i+" actor's player ref was not correctly set!")
			akActor.PlayerRef = PHHSHInter.DOM.PlayerRef
			;k += 1
		endif
		if akActor.target != targetAliases[i]
			;LogTrace("CheckActorAliases alias "+i+" actor's target was not correctly set!")
			akActor.target = targetAliases[i]
			;k += 1
		endif
		DOM_Mind akMind = slotAliases[i] as DOM_Mind
		if akMind.DOM01 != PHHSHInter.DOM
			LogTrace("CheckActorAliases alias "+i+" mind was not correctly set!")
			akMind.DOM01 = PHHSHInter.DOM
			k += 1
		endif
		if akMind.PlayerRef != PHHSHInter.DOM.PlayerRef
			;LogTrace("CheckActorAliases alias "+i+" mind's player ref was not correctly set!")
			akMind.PlayerRef = PHHSHInter.DOM.PlayerRef
			;k += 1
		endif
		PHHSHHouseSlave akSlave = slotAliases[i] as PHHSHHouseSlave
		if akSlave.SlaveTarget != targetAliases[i]
			;LogTrace("CheckActorAliases alias "+i+" target was not correctly set!")
			akSlave.SlaveTarget = targetAliases[i]
			;k += 1
		endif
		i += 1
	EndWhile	
	if k == 0
		LogTrace("CheckActorAliases All DOM pointers are OK")
	else
		LogTrace("CheckActorAliases Found "+k+" wrong DOM pointers! Corrected")
	endif
EndFunction

Function LogTrace(string msg)
	if PHHSHInter.isVerboseMode()
		Debug.Trace("PHHSHFlexiStorage: "+msg)
	endif
EndFunction

PHHSHStorageFunctions Property PHHSH Auto

ReferenceAlias[] Property targetAliases Auto
ReferenceAlias[] Property slotAliases Auto

Topic Property ExclaimTopic Auto
Faction Property DOMAliasIndexFaction Auto
Faction Property DOMSlaveManagerFaction Auto
