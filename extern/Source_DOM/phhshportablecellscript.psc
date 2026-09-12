Scriptname PHHSHPortableCellScript extends ReferenceAlias  
Import DOM_Util

int secsPerTick = 5
int ticksPerBehaviourUpdate = 6		; Tick = 5 seconds.
int is_interiorcell = -1 ; Not set, 0 = exterior, 1 = interior

Function PlaceCell(float X, float Y, float Z, float Rot)
	LogTrace("PHHSHPortableCellScript PlaceCell")
	CellWallF = PortableFunctions.PlaceItem(PortableFunctions.CageFront, X, Y, Z, Rot, 128, -128, 0, 180)
	CellDoor = PortableFunctions.PlaceItem(PortableFunctions.CageDoor, X, Y, Z, Rot, 128, -128, 0, 180)
	CellTop = PortableFunctions.PlaceItem(PortableFunctions.CageTop, X, Y, Z, Rot, 0 , 0, 0, 0)
	CellWallL = PortableFunctions.PlaceItem(PortableFunctions.CageSide, X, Y, Z, Rot, 128, 128, 0, 90)
	CellWallO = PortableFunctions.PlaceItem(PortableFunctions.CageSide, X, Y, Z, Rot, -128, 128, 0, 0)
	CellWallR = PortableFunctions.PlaceItem(PortableFunctions.CageSide, X, Y, Z, Rot, -128, -128, 0, 270)
	CellButton = PortableFunctions.PlaceItem(PortableFunctions.CageButton, X, Y, Z, Rot, 80, -145, 0, 0)
	CellLamp = PortableFunctions.PlaceItem(PortableFunctions.CellLamp, X, Y, Z, Rot, 0, 32, 220, 270)
	CellLight = PortableFunctions.PlaceItem(PortableFunctions.CellLight, X, Y, Z, Rot, 0, 32, 180, 270)
	BedRoll = PortableFunctions.PlaceItem(PortableFunctions.BedRoll, X, Y, Z, Rot, -80, 50, 10, 20)

	;LogTrace("PHHSHPortableCellScript PlaceCell CellButton="+CellButton)
	ParentCell = CellButton.GetParentCell()
	;LogTrace("PHHSHPortableCellScript PlaceCell ParentCell="+ParentCell)
	;LogTrace("PHHSHPortableCellScript PlaceCell actorAliases="+actorAliases)
	;MigratedSlaveList = true
	actorCounter = 0
	SetLocation()
	TransferTarget = None

	BedMarker = none
	CellMarker = none
	BedroomMarker = none
	Wallmarker = none

	PortableFunctions.PHHSH.SlaveTatsFunctions.ClearArrayRef(tattooNew)
	PortableFunctions.PHHSH.SlaveTatsFunctions.ClearArrayRef(tattooTrained)

	ObjectReference marker =  PortableFunctions.PlaceItem(PortableFunctions.HouseMarker, X, Y, Z, 0, 0, 0, 0, 0)
	HouseMarkerObj = marker
	PortableFunctions.PlaceItem(PortableFunctions.CellMarker, X, Y, Z, 0, 0, 0, 0, 0)

	FillEmptyMarkers(marker)
	ForceRefTo(CellButton)
	NeedsConfirm = 4
	debug.notification("Please use the cell Functions (click the small box) to confirm placement")
	menuState = 1 ; Place cell
	RegisterForSingleUpdate(secsPerTick)
	PlaceX = X
	PlaceY = Y
	PlaceZ = Z
	PlaceRot = Rot
	Guard = None
	TaskMaster = None
	MarkersHidden = true;
	HidingMarkers = false;
EndFunction

Actor Function GetTaskMaster()
	if TaskMaster != None
		return TaskMaster
	endif
	ObjectReference CellMark = GetRef()
	if CellMark == None
		return None
	endif
	Cell parent_cell = cellMark.GetParentCell()
	if parent_cell == None
		return None
	endif
	PHHSHPortableCellScript other_cell = PortableFunctions.HoldingCellrefForCell(parent_cell) as PHHSHPortableCellScript
	if other_cell == None
		return None
	endif
	return other_cell.TaskMaster
EndFunction

Actor Function GetGuardCellRef()
	if Guard != None
		return Guard
	endif
	ObjectReference CellMark = GetRef()
	if CellMark == None
		return None
	endif
	Cell parent_cell = cellMark.GetParentCell()
	if parent_cell == None
		return None
	endif
	PHHSHPortableCellScript other_cell = PortableFunctions.HoldingCellrefForCell(parent_cell) as PHHSHPortableCellScript
	if other_cell == None
		return None
	endif
	return other_cell.Guard
EndFunction

bool Function IsOutDoorCell()
	if is_interiorcell == 0
		return true
	endif
	ObjectReference cellMark = GetRef()
	if CellMark == None
		return false
	endif
	Cell the_cell = ParentCell
	if the_cell == None
		return false
	endif
	if the_cell.IsInterior()
		is_interiorcell = 1
		return false
	endif
	is_interiorcell = 0
	return true
EndFunction

bool Function IsInDoorCell()
	if is_interiorcell == 1
		return true
	endif
	ObjectReference cellMark = GetRef()
	if CellMark == None
		return false
	endif
	Cell the_cell = ParentCell
	if the_cell == None
		return false
	endif
	if the_cell.IsInterior()
		is_interiorcell = 1
		return true
	endif
	is_interiorcell = 0
	return false
EndFunction

string Function GetNameCellRef()
	ObjectReference CellMark = GetRef()
	if CellMark == None
		return ""
	endif
	Location the_loc = cellMark.GetCurrentLocation()
	string the_name
	if the_loc != None
		the_name = the_loc.GetName()
		if the_name != ""
			return the_name
		endif
	endif
	Cell parent_cell = cellMark.GetParentCell()
	if parent_cell != None
		the_name = parent_cell.GetName()
		if the_name != ""
			return the_name
		endif
	endif
	return "Somewhere"
EndFunction

Function SetLocation()
	if (CellButton != None)
		Location l = CellButton.GetCurrentLocation()
		if (l != None)
			AliasLocation.ForceLocationTo(l)
			return
		endif
	endif

	AliasLocation.Clear()
EndFunction

Function PlaceBox(float X, float Y, float Z, float Rot)
	int response = PortableFunctions.CampSelectionMenu.Show()
	if (response == 0)
		return
	else
		CellWallF = None
		CellDoor = None
		CellTop = None
		if (response == 1) 
			CellWallL = PortableFunctions.PlaceItem(PortableFunctions.CampFire, X, Y, Z, Rot, 150, 0, 0, 0)
			CellWallR = PortableFunctions.PlaceItem(PortableFunctions.BedRoll, X, Y, Z, Rot, 0, 0, 0, 0)
			CellWallO = PortableFunctions.PlaceItem(PortableFunctions.BedRoll, X, Y, Z, Rot, -100, 20, 0, 20)
		else
			CellWallL = None
			CellWallR = None
			CellWallO = None
		endif
		CellButton = PortableFunctions.PlaceItem(PortableFunctions.CageButton, X, Y, Z, Rot, 30, -100, 0, 0)
		ParentCell = CellButton.GetParentCell()
		BedMarker.ForceRefTo(FindBed())
		ObjectReference marker = PortableFunctions.PlaceItem(PortableFunctions.Marker, X, Y, Z, 0, 0, 0, 0, 0)
		CellMarker.ForceRefTo(marker)

		BedroomMarker.Clear()
		Wallmarker.Clear()

		HouseMarkerObj = None
		PortableFunctions.PlaceItem(PortableFunctions.CellMarker, X, Y, Z, 0, 0, 0, 0, 0)

		ForceRefTo(CellButton)
		NeedsConfirm = 4
		debug.notification("Please use the cell Functions (click the small box) to confirm placement")
		menuState = 1 ; Place cell
		OnUpdate()
		RegisterForUpdate(5)
	endif
EndFunction

Function PlaceAtMarker(ObjectReference PosMarker)
	CellWallF = None
	CellDoor = None
	CellTop = None
	CellWallL = None
	CellWallR = None
	CellWallO = None
	CellButton = PosMarker.PlaceAtMe(PortableFunctions.CageButton.GetBaseObject() , 1)
	ParentCell = PosMarker.GetParentCell()
	ObjectReference marker = PosMarker.PlaceAtMe(PortableFunctions.marker.GetbaseObject(), 1)

	marker = PosMarker.PlaceAtMe(PortableFunctions.HouseMarker.GetbaseObject(), 1)
	HouseMarkerObj = marker
	PosMarker.PlaceAtMe(PortableFunctions.CellMarker.GetbaseObject(), 1)

	BedMarker = none
	CellMarker = none
	BedroomMarker = none
	Wallmarker = none

	ForceRefTo(CellButton)
	NeedsConfirm = 0
	MenuState = 0
EndFunction

int Function CountSlaves()
	return actorCounter
EndFunction

Function AddSlave(ReferenceAlias slaveAlias)
	if slaveAlias == None
		return
	endif
	if dirty_actor_array
		int counter = 0
		while dirty_actor_array	
			if counter >= 128
				Debug.Notification("CANCELED! Wait for previous slave transfer to finish!")
				return
			endif
			Utility.Wait(1.0)
			counter += 1
			dirty_actor_array = false
			UpdateActorArray()
		endwhile
	endif
	LogTrace("PHHSHPortableCellScript AddSlave slaveAlias="+slaveAlias)
	if actorCounter < 0
		actorCounter = 0
	endif
	if actorCounter >= actorAliases.length
		Debug.notification("HSH Cell is full!")
		LogTrace("PHHSHPortableCellScript AddSlave error cell is full actorCounter="+actorCounter)
		return
	endif
	int idx = GetSlaveIndex(slaveAlias)
	if idx < 0
		actorAliases[actorCounter] = slaveAlias
		actorCounter += 1
		if Guard != None
			DOM_Actor akTrainer = PortableFunctions.PHHSHInter.GetActor(Guard)
			if akTrainer != None
				DOM_Actor akActor = slaveAlias as DOM_Actor
				if akActor != None && !PortableFunctions.PHHSHInter.DOM.isATaskMistress(akActor.akRef)
					akActor.SetTrainer(akTrainer)
				endif
			endif
		endif
	else
		LogTrace("WARNING: Alias is already registered in cell alias="+slaveAlias)
	endif
EndFunction

int Function GetSlaveIndex(ReferenceAlias slaveAlias)
	int i = 0
	while i < actorCounter && i < actorAliases.length
		if actorAliases[i] == slaveAlias
			return i
		endif
		i += 1
	endwhile
	return -1
EndFunction

Function RemoveSlave(ReferenceAlias slaveAlias)
	if slaveAlias == None
		return
	endif
	if dirty_actor_array
		int counter = 0
		while dirty_actor_array	
			if counter >= 128
				Debug.Notification("CANCELED! Wait for previous slave transfer to finish!")
				return
			endif
			Utility.Wait(1.0)
			counter += 1
			dirty_actor_array = false
			UpdateActorArray()
		endwhile
	endif
	LogTrace("PHHSHPortableCellScript RemoveSlave slaveAlias="+slaveAlias)
	int idx = GetSlaveIndex(slaveAlias)
	if idx < 0 || idx > actorAliases.length
		LogTrace("PHHSHPortableCellScript RemoveSlave WARNING alias not found in cell slaveAlias="+slaveAlias)
		return
	endif
	actorAliases[idx] = None
	actorCounter -= 1
	if actorCounter < 0
		actorCounter = 0
	endif
	UpdateActorArray()
EndFunction

bool updating_actor_array = false
bool dirty_actor_array = false
Function UpdateActorArray()
	LogTrace("PHHSHPortableCellScript UpdateActorArray actors busy="+updating_actor_array)
	if updating_actor_array
		dirty_actor_array = true
		return
	endif
	updating_actor_array = true
	int i = 0
	actorCounter = 0
	While i < actorAliases.length
		if actorAliases[i] != None
			if i > actorCounter
				actorAliases[actorCounter] = actorAliases[i]
				actorAliases[i] = None
				LogTrace("PHHSHPortableCellScript UpdateActorArray actorCounter="+actorCounter+" "+actorAliases[actorCounter])
			endif
			actorCounter += 1
		endif
		i += 1
	EndWhile	
	updating_actor_array = false
	LogTrace("PHHSHPortableCellScript UpdateActorArray done actorCounter="+actorCounter)
EndFunction

ReferenceAlias[] Function GetActorArray()
	if dirty_actor_array
		int counter = 0
		while dirty_actor_array	
			if counter >= 128
				Debug.Notification("WARNING! Slave array might not be up to date")
				return actorAliases
			endif
			LogTrace("PHHSHPortableCellScript GetActorArray array is dirty, updating...")
			Utility.Wait(1.0)
			counter += 1
			dirty_actor_array = false
			UpdateActorArray()
		endwhile
	endif
	return actorAliases
EndFunction

Event OnActivate(ObjectReference ref)
	if (menuState == 1)
		CellType = PortableFunctions.PlacingCellType
		NeedsConfirm = 0	
		MenuState = 0	
		debug.notification("Placement confirmed")
		Game.GetPlayer().AddSpell(PortableFunctions.AddFurnitureSpell)
		Game.GetPlayer().AddSpell(PortableFunctions.RemoveFurnitureSpell)

		HasUpgrade = false
		if (CellType == 1)
;			Game.GetPlayer().RemoveItem(PortableFunctions.CellToken, 1)
			int icount =Game.GetPlayer().GetItemCount(PortableFunctions.CellToken)		; Ensures a stack of tokens remains usable
			Game.GetPlayer().RemoveItem(PortableFunctions.CellToken,icount,true)
   			if icount > 1
        			icount = icount - 1
   				Game.GetPlayer().AddItem(PortableFunctions.CellToken,icount,true)
    			endif		
		elseif (CellType == 2)
;			debug.notification("The cell will be ready in a week")
;			Game.GetPlayer().RemoveItem(PortableFunctions.PermaCampToken, 1)
			int icount =Game.GetPlayer().GetItemCount(PortableFunctions.PermaCampToken)		; Ensures a stack of tokens remains usable
			Game.GetPlayer().RemoveItem(PortableFunctions.PermaCampToken,icount,true)
   			if icount > 1
        			icount = icount - 1
   				Game.GetPlayer().AddItem(PortableFunctions.PermaCampToken,icount,true)
    			endif		

;			RegisterForUpdateGameTime(1)
;			RemoveProps()
		elseif (CellType == 3)
;			Game.GetPlayer().RemoveItem(PortableFunctions.CampToken, 1)
		endif
		if (GetOwningQuest().GetStage() != 10)
			GetOwningQuest().SetStage(10)
		endif
		HideMarkersInCell(true)
	else
		if (CellType <= 2)
			Cellmenu()
		else
			CellCampMenu()
		endif		
	endif
EndEvent

Event OnUpdateGameTime()
	UnregisterForUpdateGameTime()
	PlaceCell(PlaceX, PlaceY, PlaceZ, PlaceRot)
EndEvent

Function CellMenu()
	PortableFunctions.OfferUpgrade = false
	PortableFunctions.OfferCellRemove = (CellDoor != None)
	int response = PortableFunctions.HouseMenu.Show()
	if (response == 1)
		RemoveCell()
	elseif (response == 2)
		PortableFunctions.CellMarkersHidden = MarkersHidden
		PortableFunctions.CellMarkersBusy = HidingMarkers
		MarkerMenu()
	elseif (response == 3)
		RoundUpSlaves()
	elseif (response == 4)
		response = PortableFunctions.ConfirmCageMenu.Show()
		if (response == 1)		
			CellWallF.Delete()
			CellDoor.Delete()
			CellTop.Delete()
			CellWallL.Delete()
			CellWallO.Delete()
			CellWallR.Delete()
			if (CellLamp != None)
				CellLamp.Delete()
				CellLight.Delete()
			endif
			if (BedRoll != None)
				BedRoll.Delete()
			endif

			CellWallF = None
			CellDoor = None
			CellTop = None
			CellWallL = None
			CellWallO = None
			CellWallR = None
			CellLamp = None
			CellLight = None
			BedRoll = None
		endif

	elseif (response == 5)
		HasUpgrade = true
		Game.GetPlayer().RemoveItem(PortableFunctions.UpgradeToken, 1)
		Debug.notification("House cell upgraded to 6 occupants")
	else
		MenuState = 0	
	endif
EndFunction

Function CellCampMenu()
	int response = PortableFunctions.TempCampMenu.Show()
	if (response == 1)
		RemoveCell()
	elseif (response == 2)
		RoundUpSlaves()
	else
		MenuState = 0	
	endif
EndFunction

Function SetTaskMaster(Actor tm)
	if TaskMaster != None
		SetAliasTitle(Taskmaster,"")
	endif
	TaskMaster = tm
	if TaskMaster == None
		return
	endif
	if TaskMaster.GetLeveledActorBase().GetSex() == 1
		SetAliasTitle(TaskMaster,"Taskmistress")
	else
		SetAliasTitle(TaskMaster,"Taskmaster")
	endif
EndFunction

Function SetAliasTitle(Actor akTarget, string the_title)
	DOM_Actor akActor = GetActorAlias(akTarget) as DOM_Actor
	if akActor == None
		return
	endif
	akActor.SetTitle(the_title)
EndFunction

Function SetGuard(Actor grd)
	if Guard != None || grd == None
		return
	endif
	Guard = grd
	debug.notification(grd.GetDisplayName() + " is guarding this camp")
	PortableFunctions.PHHSHInter.SetFollowerWaitingForPlayer(Guard,self,true)
EndFunction

Function CheckGuard()
	if Guard == None
		;LogTrace("PHHSHPortableCellScript CheckGuard no guard "+Guard)
		return
	endif
	if Guard.GetParentCell() == ParentCell
		;LogTrace("PHHSHPortableCellScript CheckGuard guard in cell "+Guard)
		return
	endif
	if IsTogetherWithFast(CellButton, Guard, 5000.0) ; 5000 = 70 meters
		;LogTrace("PHHSHPortableCellScript CheckGuard guard is wandering around "+Guard)
		return
	endif
	if Guard.IsInFaction(PortableFunctions.PHHSH.PlayerFollowerFaction)
		LogTrace("PHHSHPortableCellScript CheckGuard follower left camp "+Guard)
		TryReplaceGuard()
		return
	endif
	if PortableFunctions.PHHSHInter.isASlaver(Guard)
		LogTrace("PHHSHPortableCellScript CheckGuard slaver left camp "+Guard)
		TryReplaceGuard()
		return
	endif
	ReferenceAlias slot = PortableFunctions.PHHSH.SlaveRef(Guard)
	if slot == None
		LogTrace("PHHSHPortableCellScript CheckGuard slave left camp "+Guard)
		TryReplaceGuard()
		return
	endif
	LogTrace("PHHSHPortableCellScript CheckGuard slave wandered away from camp "+Guard)
	Guard.moveto(CellButton,0.0,0.0,25.0)
EndFunction

Function CheckIfGuarded()
	if (Guard == None)
		LogTrace("PHHSHPortableCellScript CheckIfGuarded "+Guard)
		TryReplaceGuard()
	endif
EndFunction

Function TryReplaceGuard()
	LogTrace("PHHSHPortableCellScript TryReplaceGuard guard="+Guard)
	string s = ""
	Actor lastGuard = Guard
	if (Guard != none)
		s = Guard.GetDisplayName() + " is no longer guarding your camp.  "	
	endif
	Guard=PortableFunctions.FindNewGuard(CellButton)
	if (Guard != none)
		s += Guard.GetDisplayName() + " is now on guard duty"
	elseif (lastGuard != None)
		s += "The camp is now unguarded!"
	endif
	if s != ""
		debug.notification(s)
		LogTrace("PHHSHPortableCellScript TryReplaceGuard "+s)
	endif
	LogTrace("PHHSHPortableCellScript TryReplaceGuard ERROR!")
EndFunction

Function MarkerMenu()
	int response
	if (HouseMarkerObj != None)
		response = PortableFunctions.MarkerHouseMenu.Show()
	else
		response = PortableFunctions.MarkerMenu.Show()
	endif
	if (response == 0)
		CellMenu()
	elseif (response == 5)
		HideMarkersInCell(false)
	elseif (response == 6)
		HideMarkersInCell(true)
	elseif (response == 8)
		RemoveChains()
	elseif ((response >= 1) && (response < 5))
		menuState = response + 1
		RegisterForKey(1)
		RegisterForKey(28)
		OnUpdate()
		RegisterForUpdate(5.0)
	endif
EndFunction

ReferenceAlias Function GetActorAlias(Actor akTarget)
	if akTarget == None
		return None
	endif
	int i = 0
	while i < actorCounter
		ReferenceAlias sl_alias = actorAliases[i]
		if sl_alias != None && sl_alias.GetActorRef() == akTarget
			return sl_alias
		endif
		i += 1
	endwhile
	return None
EndFunction
 
Function RoundUpSlaves()
	LogTrace("RoundUpSlaves")
	int i = 0
	while i < actorCounter
		ReferenceAlias sl_alias = actorAliases[i]
		if sl_alias != None
			Actor akRef = sl_alias.GetActorRef()
			if akRef != None
				LogTrace("RoundUpSlaves: found slave "+akRef.GetDisplaYName())
				akRef.MoveTo(GetRef(), 25, 25, 0, false)
			endif
		endif
		i += 1
	endwhile
EndFunction

Event OnAttachedToCell()
	OnCellAttach()
EndEvent

Event OnCellAttach()
;	debug.notification("Cell attach")
	UnregisterForUpdate()
	utility.wait(1)
	RegisterForSingleUpdate(secsPerTick)
EndEvent

Event OnUpdate()
;	debug.notification("Cell update")
	if dirty_actor_array
		dirty_actor_array = false
		UpdateActorArray()
	endif
	if (menuState == 1) ; Place cell
		NeedsConfirm -= 1
		if (NeedsConfirm > 0)
			debug.notification("Please use the cell Functions (click the small box) to confirm placement")
		else
			debug.notification("Placement cancelled")
			UnregisterForUpdate()
			RemoveCell(true)
		endif
	elseif (menuState == 2) ; Place cell
		debug.notification("Place Cell Marker: [Enter] to place, [Esc] to end")	
	elseif (menuState == 3) ; Place cell
		debug.notification("Place Bedroom Marker: [Enter] to place, [Esc] to end")	
	elseif (menuState == 4) ; Place cell
		debug.notification("Place Wall Marker: [Enter] to place, [Esc] to end")	
	elseif (menuState == 5) ; && (HouseMarker != None)) ; Place cell
		debug.notification("Place House Marker: [Enter] to place, [Esc] to end")	
	elseif (CellType != 1)
		;LogTrace("PHHSHPortableCellScript OnUpdate CheckGuard Guard="+Guard)
		CheckGuard()
		if (!Guard)
			float distance = GetRef().GetDistance(Game.GetPlayer())
			if (distance > 4000.0)
				CheckEscape()
			else
;				debug.notification("Guarded by player")
			endif
		else
;			debug.notification("Guarded by " + Guard.GetDisplayName())
		endif
	endif
	if (ParentCell.IsAttached())
		BehaviourUpdateTicks += 1
		if (BehaviourUpdateTicks >= ticksPerBehaviourUpdate)
			PortableFunctions.PHHSH.DebugLog("Cell behaviour update")
			BehaviourUpdateTicks = 0
			int i = 0
			while (actorAliases[i] != None)
				PortableFunctions.PHHSH.Taskmaster.Behavior.EvaluateBehavior(actorAliases[i] as phhshHouseSlave)
				i+=1
			endwhile
			PortableFunctions.PHHSH.DebugLog("Cell behaviour update ends: " + i)
		endif
		RegisterForSingleUpdate(secsPerTick)
	endif
EndEvent

Function CheckEscape()
	if actorCounter <= 0
		return
	endif
	if (utility.Randomint(1, 20) == 1)
		int i = 0
		string name = GetNameCellRef()
		while i < actorCounter && i < actorAliases.length
			referencealias slot = actorAliases[i]
			if ((slot != none) && (slot.GetActorRef() != none))
				Actor slave = slot.GetActorRef()
				if PortableFunctions.PHHSH.SlaveNeedsEscort(slave)
					DOM_Actor akActor = slot as DOM_Actor
					bool do_escape = true
					if akActor != None
						if !akActor.is_running_away
							do_escape = false
						elseif akActor.TryRunAway()
							debug.notification(slave.GetDisplayName() + " is trying to escape from "+name+"!")
						endif
					endif
					if do_escape
						debug.notification(slave.GetDisplayName() + " has managed to escape from "+name+"!")
						PortableFunctions.PHHSH.DeregisterSlave(slave)
						slave.EvaluatePackage()
						int rank = slave.GetRelationshipRank(Game.GetPlayer())
						if rank > -4
							slave.SetRelationshipRank(Game.GetPlayer(), rank-(1))
						endif
					endif
				endif
			endif
		endwhile
	endif
EndFunction

Function RemoveCell(bool silent= false)
	bool isOccupied = PortableFunctions.IsOccupied(CellButton)

	if ((isOccupied) && (!silent))
		if (CellType == 3)
			debug.notification("Please remove all slaves from this camp first")
			return
;		else
;			debug.notification("Please remove all slaves from this home first")
		endif
	endif

	int response = 1
	if (!silent)
		if (isOccupied)
			response = PortableFunctions.ConfirmFilledCellMenu.Show()
		else
			response = PortableFunctions.ConfirmCellMenu.Show()
		endif
	endif
	if (response == 1)
		UnregisterForUpdate()
		MenuState = 0;

		RemoveProps()
		DeleteMarkersInCell()

		if Guard != None
			LogTrace("PHHSHPortableCellScript RemoveCell WaitingForPlayer "+Guard)
			PortableFunctions.PHHSHInter.SetFollowerWaitingForPlayer(Guard,self,false)
		endif		

		if (isOccupied)
			debug.notification("Moving slaves to PAHE, be patient")
			ReferenceAlias[] slaves = new ReferenceAlias[101]
			int i
			while (actorAliases[i] != None)
				slaves[i] = actorAliases[i]
				i += 1
			endwhile
			int count = i
			i = 0
			while (slaves[i] != None)
				PortableFunctions.PHHSH.DebugLog("Moving slave to DOM:" + slaves[i].GetActorRef().GetDisplayName())
				PortableFunctions.PHHSH.DeregisterFromWhiteRun(slaves[i].GetActorRef())
				i+= 1
				debug.notification("...process slave " + i + "/" + count)
			endwhile
			debug.notification("Done moving slaves")
		endif

		Guard = None
		TaskMaster = None
		is_interiorcell = -1
		AliasLocation.Clear()
		Clear()
	endif
EndFunction

Function RemoveProps()
	CellWallF.Delete()
	CellDoor.Delete()
	CellTop.Delete()
	CellWallL.Delete()
	CellWallO.Delete()
	CellWallR.Delete()
	CellButton.Delete()
	if ((CellMarker != None) && (CellMarker.GetRef() != None))
		CellMarker.GetRef().Delete()
		Cellmarker.Clear()
	endif
	if ((WallMarker != None) && (WallMarker.GetRef() != None))
		WallMarker.GetRef().Delete()
		WallMarker.Clear()
	endif
	if ((BedroomMarker != None) && (BedroomMarker.GetRef() != None))
		BedroomMarker.GetRef().Delete()
		Bedroommarker.Clear()
	endif
	if (HouseMarker != None)
		If (Housemarker.GetRef() != None)
			HouseMarker.GetRef().Delete()
		endif
		HouseMarker.Clear()
	endif
	if (CellLamp != None)
		CellLamp.Delete()
		CellLight.Delete()
	endif

	if (BedRoll != None)
		BedRoll.Delete()
	endif

	if (BedMarker != None)
		BedMarker.Clear()
	endif

	CellWallF = None
	CellDoor = None
	CellTop = None
	CellWallL = None
	CellWallO = None
	CellWallR = None
	CellLamp = None
	CellLight = None
	BedRoll = None
EndFunction

Objectreference Function FindBed()
	if PortableFunctions.PHHSH.DOMSexlab.Beds == None
		return None
	endif
	ObjectReference b =  Game.FindClosestReferenceOfAnyTypeInListFromRef(PortableFunctions.PHHSH.DOMSexlab.Beds, CellButton, 1024)
	return b
EndFunction

Function ExitPlacement()
	menuState = 0
	UnregisterForKey(28)
	UnregisterForKey(1)
	HideMarkersInCell(true)
EndFunction

Event OnKeyDown(int keyCode)
	if (keyCode == 28)
		ObjectReference marker
		if (menuState == 2)
			marker = PortableFunctions.PlaceItem(PortableFunctions.CellMarker, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
			FillEmptyMarkers(marker)
			debug.notification("Cell marker placed")
		elseif (menuState == 3)
			marker = PortableFunctions.PlaceItem(PortableFunctions.BedroomMarker, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
			FillEmptyMarkers(marker)
			debug.notification("Bedroom marker placed")
		elseif (menuState == 4)
			marker = PortableFunctions.PlaceItem(PortableFunctions.WallMarker, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
			FillEmptyMarkers(marker)
			debug.notification("Wall marker placed")
		elseif (menuState == 5)
			marker = PortableFunctions.PlaceItem(PortableFunctions.HouseMarker, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
			FillEmptyMarkers(marker)
			debug.notification("House marker placed")
		endif
	elseif (keyCode == 1)
		ExitPlacement()
	endif
EndEvent

Function HideMarkersInCell(bool hide = true)
	if (HidingMarkers)
;		debug.notification("Hide Markers in progress, please wait...")
		return
	endif
	HidingMarkers = true
	Cell kCell = CellButton.GetParentCell()
	MarkersHidden = hide
	Form fWall =  PortableFunctions.WallMarker.GetBaseObject()

	Int iIndex = kCell.GetNumRefs(fWall.GetType())
;	debug.notification("Markers hide: " + hide + "  Count:" + iIndex + " In:" + kCell.GetName())
	float scale = 1.0
	if (MarkersHidden)
		scale = 0.0
	endif
	
	ObjectReference obj
	while (iIndex)
		iIndex -= 1
		obj = kCell.GetNthRef(iIndex, fWall.GetType())
		if (obj.HasKeyword(PortableFunctions.CellMarkerKeyword))
			obj.SetScale(scale)
			utility.wait(0.1)
			obj.disable()
			utility.wait(0.1)
			obj.Enable()
;			debug.notification("x " + obj.GetName())
		else
;			debug.notification("- " + obj.GetName())
		endif
	endwhile
;	debug.notification("Markers hide done: " + MarkersHidden)
	HidingMarkers = false
EndFunction

Function DeleteMarkersInCell()
	Cell kCell = CellButton.GetParentCell()
	Form fWall =  PortableFunctions.WallMarker.GetBaseObject()

	Int iIndex = kCell.GetNumRefs(fWall.GetType())
	ObjectReference obj
	while (iIndex)
		iIndex -= 1
		obj = kCell.GetNthRef(iIndex, fWall.GetType())
		if (obj.HasKeyword(PortableFunctions.CellMarkerKeyword))
			obj.Delete()
		endif
	endwhile
EndFunction

Function RemoveChains()
	int response = PortableFunctions.ConfirmRemoveChainMenu.Show()
		if (response == 1)
		ObjectReference c = Game.FindClosestReferenceOfTypeFromRef(PortableFunctions.PHHSH.HR_HavocChain, Game.GetPlayer(), 10000) 
		int i = 0
		while ((c != None) && (i < 1000))
			c.MoveTo(c, 0, 0, -12000)		; Move chains down in case they cannot be deleted
			c.Delete()
			c = None
			c = Game.FindClosestReferenceOfTypeFromRef(PortableFunctions.PHHSH.HR_HavocChain, Game.GetPlayer(), 10000) 
			i += 1
		endWhile
		if (c == None)
			debug.notification("Done removing chains")
		else
			debug.notification("Not all chains could be removed, please try again")
		endif
	endif
EndFunction

Function FillEmptyMarkers(ObjectReference marker)
;	if (HouseMarker.GetRef() == None)
;		ObjectReference hm = marker.PlaceAtMe(PortableFunctions.Housemarker.GetBaseObject(), 1)
;		HouseMarker.ForceRefTo(hm)
;	endif
EndFunction


Function LogTrace(string msg)
	Debug.Trace("PHHSHPortableCellScript: "+msg)
EndFunction

PAHOPortable Property PortableFunctions Auto
ObjectReference Property CellButton Auto
ObjectReference Property CellDoor Auto
ObjectReference Property CellTop Auto
ObjectReference Property CellWallL Auto
ObjectReference Property CellWallR Auto
ObjectReference Property CellWallO Auto
ObjectReference Property CellWallF Auto
ObjectReference Property CellLamp Auto
ObjectReference Property CellLight Auto
ObjectReference Property Bedroll Auto

ReferenceAlias Property CellMarker Auto
ReferenceAlias Property BedroomMarker Auto
ReferenceAlias Property WallMarker Auto
ReferenceAlias Property BedMarker Auto
ReferenceAlias Property HouseMarker Auto
phhshPortableCellScript Property TransferTarget Auto		; Replace by Cell parameter?
Cell Property TransferTargetCell Auto

LocationAlias  Property AliasLocation Auto

ObjectReference Property HouseMarkerObj Auto

ObjectReference Property DefaultCellMarker Auto
ObjectReference Property DefaultHouseMarker Auto
ObjectReference Property DefaultBedroomMarker Auto

int Property tattooNew Auto					; Tattoo for new slaves.  This is a JContainers identifyer, with an array of tats
int Property tattooTrained Auto					; Tattoo for trained slaves.

int Property NeedsConfirm Auto
Cell Property ParentCell Auto
int Property menuState Auto
bool Property HasUpgrade Auto
int Property CellType Auto

float Property placeX Auto
float Property placeY Auto
float Property placeZ Auto
float Property placeRot Auto

Actor Property Guard Auto
Actor Property TaskMaster Auto
bool Property MarkersHidden = false Auto
bool Property HidingMarkers = false Auto

Int Property actorCounter = 0 Auto Hidden
ReferenceAlias[] __actorAliases
ReferenceAlias[] Property actorAliases Hidden
	ReferenceAlias[] Function Get()
		if !__actorAliases
			__actorAliases = new ReferenceAlias[128]
		endif
		return __actorAliases
	EndFunction
EndProperty

bool Property MigratedSlaveList Auto Hidden
int Property BehaviourUpdateTicks Auto Hidden