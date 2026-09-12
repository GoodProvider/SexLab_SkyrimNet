Scriptname PAHFellglowSlaveCampQuest extends Quest Conditional

Actor Property actor_jerrek  Auto

ObjectReference Property PAHJerrekInspectSlaveStartLocation  Auto  
ObjectReference Property PAHJerrekSlaveStandForInspectionStartLocation  Auto
ObjectReference Property PAHSlaveNoSaleReturnPoint Auto

Scene Property PAHFSCInspectSlaveScene  Auto
Scene Property PAHFSCTakeRAToCell1Scene Auto

DOM_Core Property DOM01 Auto

Faction Property DOMAnotherSlaveFaction Auto
Faction Property PAHFellglowSlaveFaction Auto
Faction Property PAHFSCCage1Faction Auto

Form Property Gold001 Auto

ReferenceAlias Property Alias_slave_up_for_sale Auto
ReferenceAlias[] Property just_sold_slave_aliases Auto
ReferenceAlias[] Property sold_slave_aliases Auto

ReferenceAlias Property alias_door_guard_1 Auto
ReferenceAlias Property alias_door_guard_2 Auto

ReferenceAlias Property prs_cell_1_slave Auto
ReferenceAlias Property prs_cell_1_slaver Auto

Int Property sell_stage = 0 Auto Conditional Hidden
Int Property can_take_more_slaves = 1 Auto Conditional Hidden

Actor[] Property slavers Auto
ObjectReference Property PlayerRef Auto
ReferenceAlias[] Property scene_aliases Auto
ReferenceAlias[] Property recent_acquisition_aliases Auto

ObjectReference Property CorpseDumpingPoint Auto
ObjectReference Property Cage1DumpPoint Auto

ObjectReference Property map_marker Auto

Function SetSellStage(int _sell_stage)
	sell_stage = _sell_stage

	if sell_stage == 0
		EndGuardSellRoomDoorScene()
	elseif sell_stage == 10
		; Jerrek walking to start position
		actor_jerrek.EvaluatePackage()
	elseif sell_stage == 20
		StartGuardSellRoomDoorScene()
		; Jerrek waiting for player at start position.
	elseif sell_stage == 60
		; Slave being inspected.
		Calculate(Alias_slave_up_for_sale.GetActorRef())
		PAHFSCInspectSlaveScene.Start()
	elseif sell_stage == 70
		;Offer being made
	elseif sell_stage == 80
		;Offer Accepted
		LogTrace("SetSellStage Offer Accepted "+Value)
		Game.GetPlayer().AddItem(Gold001, Value)

		Actor akTarget = Alias_slave_up_for_sale.GetActorRef()
		; Notify selling
		if DOM01 != None
			DOM_Actor akActor = DOM01.GetActor(akTarget)
			if akActor != None
				DOM01.PlayerHasSold(akActor)
			endif
		endif

		DOM01.ReleaseActor(akTarget)

		Alias_slave_up_for_sale.GetActorRef().AddToFaction(DOMAnotherSlaveFaction)
		Alias_slave_up_for_sale.GetActorRef().AddToFaction(PAHFellglowSlaveFaction)

		FillEmptyJustSoldAlias(akTarget)
		Alias_slave_up_for_sale.Clear()
		akTarget.EvaluatePackage()

		StartPrsCell1Scene()

		if can_take_more_slaves
			SetSellStage(100)
		else
			SetSellStage(0)
		endif
	elseif sell_stage == 85
		;Offer Rejected
		Actor akTarget = Alias_slave_up_for_sale.GetActorRef()
		Alias_slave_up_for_sale.Clear()
		akTarget.PathToReference(PAHSlaveNoSaleReturnPoint, 0.5)
		DOM_Actor akActor = DOM01.GetSlave(akTarget)
		if akActor != None
			akActor.SendOrderEquipInventory(true) ;  do anim
			akActor.EnterFollow()
		endif

		SetSellStage(100)
	elseif sell_stage == 100
		;Anymore Slaves?
	endif
EndFunction


Function StripSlave()
	Actor akTarget = Alias_slave_up_for_sale.GetActorRef()
	DOM_Actor akActor = DOM01.GetSlave(akTarget)
	if akActor != None
		akActor.Interact_Strip(Game.GetPlayer())
	endif
EndFunction

Function DressSlave()
	Actor akTarget = Alias_slave_up_for_sale.GetActorRef()
	DOM_Actor akActor = DOM01.GetSlave(akTarget)
	if akActor != None
		akActor.SendOrderEquipInventory(true) ; do anim
	endif
EndFunction

ReferenceAlias Function FillEmptyJustSoldAlias(Actor akTarget)
	ReferenceAlias ref_alias = GetEmptyJustSoldAlias()
	if ref_alias
		ref_alias.ForceRefTo(akTarget)
	endif
	UpdateCanTakeMoreSlaves()
	return ref_alias
EndFunction

ReferenceAlias Function GetEmptyJustSoldAlias()
	int i = 0

	While i < just_sold_slave_aliases.length
		if just_sold_slave_aliases[i].GetRef() == None
			return just_sold_slave_aliases[i]
		endif
		i += 1
	EndWhile

	return None
EndFunction


ReferenceAlias Function FillSoldSlaveAlias(Actor slave)
	ReferenceAlias ref_alias = GetEmptySoldSlaveAlias()
	if ref_alias == None
		ref_alias = sold_slave_aliases[Utility.RandomInt(0, sold_slave_aliases.length - 1)]
		ref_alias.GetActorRef().MoveTo(CorpseDumpingPoint)
		ref_alias.GetActorRef().KillEssential()
		ref_alias.GetActorRef().EndDeferredKill()
	endif
	ref_alias.ForceRefTo(slave)
EndFunction


ReferenceAlias Function GetEmptySoldSlaveAlias()
	int i = 0

	While i < sold_slave_aliases.length
		if sold_slave_aliases[i].GetRef() == None
			return sold_slave_aliases[i]
		endif
		i += 1
	EndWhile

	return None
EndFunction

Function SetSlaveUpForSale(Actor akTarget)
	LogTrace("SetSlaveUpForSale "+akTarget)
	DOM_Actor akActor = DOM01.GetActor(akTarget)
	if akActor != None
		LogTrace("SetSlaveUpForSale DOM actor="+akActor.GetName())
		akActor.EnterWait()
	endif
	LogTrace("SetSlaveUpForSale "+akTarget.GetDisplayName())
	Alias_slave_up_for_sale.ForceRefTo(akTarget)
EndFunction

Function UpdateCanTakeMoreSlaves()
	bool no_room = GetEmptyJustSoldAlias() == None
	if no_room
		can_take_more_slaves = 0
	else
		can_take_more_slaves = 1
	endif
EndFunction

Function OnResetTriggerEnter()
	ReferenceAlias ra_alias
	Actor akTarget
	
	int i = recent_acquisition_aliases.length
	while i > 0
		i -= 1
		ra_alias = recent_acquisition_aliases[i]
		akTarget = ra_alias.GetActorRef()
		if  akTarget != None
			ra_alias.clear()
			FillSoldSlaveAlias(akTarget)
			akTarget.AddToFaction(PAHFSCCage1Faction)
			akTarget.MoveTo(Cage1DumpPoint)
		endif
	endwhile

	UpdateCanTakeMoreSlaves()
	SetSellStage(0)
EndFunction

Function StartPrsCell1Scene()
	if prs_cell_1_slave.GetActorRef() == None
		Actor slaver = alias_door_guard_1.GetActorRef()
		if slaver == None
			slaver = alias_door_guard_2.GetActorRef()
		endif
		if slaver == None
			slaver = GetFreeSlaver()
		endif
		if slaver
			ReferenceAlias ra_alias = GetFilledRecentAqusitionAlias()
			if ra_alias
				prs_cell_1_slave.ForceRefTo(ra_alias.GetActorRef())
				FillSoldSlaveAlias(ra_alias.GetActorRef())
				ra_alias.Clear()
				prs_cell_1_slaver.ForceRefTo(slaver)
				PAHFSCTakeRAToCell1Scene.Start()
				UpdateCanTakeMoreSlaves()
			endif
		endif
	endif
EndFunction


Function StartGuardSellRoomDoorScene()
	alias_door_guard_1.ForceRefTo(GetFreeSlaver())
	alias_door_guard_2.ForceRefTo(GetFreeSlaver())
EndFunction

Function EndGuardSellRoomDoorScene()
	alias_door_guard_1.Clear()
	alias_door_guard_2.Clear()
EndFunction


Actor Function GetFreeSlaver()
	Actor slaver
	slaver = slavers[Utility.RandomInt(0, slavers.length)]
	if IsFree(slaver)
		return slaver
	endif
	slaver = slavers[Utility.RandomInt(0, slavers.length)]
	if IsFree(slaver)
		return slaver
	endif
	slaver = slavers[Utility.RandomInt(0, slavers.length)]
	if IsFree(slaver)
		return slaver
	endif
	
	int i = slavers.length
	while i > 0
		i -= 1
		if IsFree(slavers[i])
			return slavers[i]
		endif
	endwhile

	return none
EndFunction

Bool Function IsFree(Actor slaver)
	int i = scene_aliases.length
	while i > 0
		i -= 1
		if scene_aliases[i].GetActorRef() == slaver
			return false
		endif
	endwhile
	return true
EndFunction


ReferenceAlias Function GetFilledRecentAqusitionAlias()
	int i = recent_acquisition_aliases.length
	while i > 0
		i -= 1
		if recent_acquisition_aliases[i].GetActorRef() != None
			return recent_acquisition_aliases[i]
		endif
	endwhile
	return None
EndFunction

Function ShowMapMarker()
	map_marker.AddToMap(false)
EndFunction

Actor property slave Auto Hidden
Int Property Value Auto Conditional Hidden
Int Property HealthRating Auto Conditional Hidden
Int Property PhysiqueRating Auto Conditional Hidden
Int Property IntellectRating Auto Conditional Hidden

Function Calculate(Actor akTarget)
	if akTarget == None
		Value = 1
		HealthRating = 1
		PhysiqueRating = 1
		IntellectRating = 1
		return
	endif
	slave = akTarget
	Value = ((DOM01.DOMGenerator.GetActorPrice(akTarget)) / 2.0 * DOM01.MOD_Slaver) as int
	LogTrace("Calculate "+akTarget.GetDisplayName()+" value="+Value)
	
	int base_health = Math.Ceiling(slave.GetBaseAv("health"))
	if base_health <= 100
		HealthRating = 1
	elseif base_health <= 200
		HealthRating = 2
	elseif base_health <= 300
		HealthRating = 3
	elseif base_health <= 400
		HealthRating = 4
	else
		HealthRating = 5
	endif

	int base_stamina = Math.Ceiling(slave.GetBaseAv("stamina"))
	if base_stamina <= 100
		PhysiqueRating = 1
	elseif base_stamina <= 200
		PhysiqueRating = 2
	elseif base_stamina <= 300
		PhysiqueRating = 3
	elseif base_stamina <= 400
		PhysiqueRating = 4
	else
		PhysiqueRating = 5
	endif
	
	int base_magicka = Math.Ceiling(slave.GetBaseAv("magicka"))
	if base_magicka <= 100
		IntellectRating = 1
	elseif base_magicka <= 200
		IntellectRating = 2
	elseif base_magicka <= 300
		IntellectRating = 3
	elseif base_magicka <= 400
		IntellectRating = 4
	else
		IntellectRating = 5
	endif
	
	if Value == 0
		Value = 10
	endif
EndFunction

Function ShowValue(Int offset = 0)
	if Value == 0
		Calculate(Alias_slave_up_for_sale.GetActorRef())
	endif
	LogTrace("ShowValue "+Value+" + "+offset)
	Value = Value + offset
	if slave != None
		Debug.MessageBox("Offer: " + (Value) as String+" for "+slave.GetDisplayName())
	else
		Debug.MessageBox("Offer: " + (Value) as String)
	endif
EndFunction

Function LogTrace(String s)
	;if isVerboseMode()
		Debug.Trace("PAHFellglowSlaveCamp: " + s)
	;endif
EndFunction
