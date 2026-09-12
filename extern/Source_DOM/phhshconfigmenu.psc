Scriptname PHHSHConfigmenu extends SKI_ConfigBase  

PHHSHInterface Property PHHSHInter Auto

int oidSubGreet
int oidOwnerGreet
int oidUseMarkers
int oidSpawnFurniture
int oidNoBdsm
int oidBanditSlaves
int oidReloadDeps
int oidDebugReset
int oidDebugLog
int oidAltInv
int oidSkipQuest
int oidRiften
int oidWhiterun
int oidMarkath
int oidSolitude
int oidWindhelm
int oidHunter
int oidSerialStrip
int oidAddressPAH
int oidITFControl
int oidResetLists
int oidArousalThreshold
int oidShowAll
int oidRepairTracker
int oidCustomGreeting
int oidCombatTraining
int oidExitGreeting
int oidSummonTM

int oidModPahe
int oidModPaheS
int oidModDOM
;int oidModDOMt
int oidModPaheD
int oidModSS
int oidModOsa
int oidModFnis
int oidModHR
;int oidModZbfX
int oidModDM
int oidModZE
int oidModZap622
int oidModZap8
int oidModTara
int oidModTaraAnims
int oidModITF
int oidModDD
int oidModAygas
int oidModSlaveCart
int oidModSLAL
int oidModSLALAggressive
int oidModMME
int oidModST

bool showWait = false

int[] cellRefs_OID
int cellRefs_count = 0
ReferenceAlias[] __cellRefs_array
ReferenceAlias[] Property cellRefs_array
	ReferenceAlias[] Function Get()
		if !__cellRefs_array
			__cellRefs_array = new ReferenceAlias[128]
		endif
		return __cellRefs_array
	EndFunction
EndProperty


int Function GetVersion()
    return 10 ;  Belongs to 1.22
EndFunction

Event OnConfigInit()
		Pages = new string[5]
		Pages[0] = "Info / Options"
		Pages[1] = "The Restless Hunter"
		Pages[2] = "House Slaves"
		Pages[3] = "Camp Slaves"
		Pages[4] = "Miners"
EndEvent

event OnVersionUpdate(int a_version)
	if Pages.length == 5
		return
	endif
	Pages = new string[5]
	Pages[0] = "Info / Options"
	Pages[1] = "The Restless Hunter"
	Pages[2] = "House Slaves"
	Pages[3] = "Camp Slaves"
	Pages[4] = "Miners"
EndEvent

string last_page = ""
Event OnPageReset(string page)
	if last_page != page
		showAll = true
		DisplayedCellRef
	endif
	last_page = page
	if (page == "" )
		LoadCustomContent("hsh.dds", 176, 73)	
	elseif (page == Pages[1])
		DoUpdateRestlessHunter()
	elseif (page == Pages[2])
		DoUpdateHouseSlaves()
	elseif (page == Pages[3])
		DoUpdateCamps()
	elseif (page == Pages[4])
		DoUpdateMiners()
	else ; if (page == "Info / Options")
		DoUpdateOptions()
	endif
EndEvent

Function DoUpdateOptions()
		UnloadCustomContent()
		PHSF.GetSoftRequirements()			; Done for upgraded installs
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddHeaderOption("PAH - Home Sweet Home (DOM version)")
		AddTextOption("Version", "<font color='#FFFF00'>" + PHSF.Version() + "</font>")

		SetCursorPosition(6)
		AddHeaderOption("Options")
		string greetValue = "No greeting"
		if (PHSF.CustomGreeting != "")
			greetValue = "Custom"
		elseif (PHSF.GreetType == 1)
			greetValue = "Kneel"
		elseif (PHSF.GreetType == 2)
			greetValue = "Hands behind head"
		elseif (PHSF.GreetType == 3)
			greetValue = "Bow head"
		elseif (PHSF.GreetType == 4)
			greetValue = "Bow, hands on back"
		endif

		oidOwnerGreet = AddMenuOption("Slave greets owner", greetValue)
		oidCustomGreeting = AddInputOption("Custom greeting idle", PHSF.CustomGreeting, 0)
		oidExitGreeting = AddToggleOption("Slaves greet only for a moment", PHSF.ExitGreeting)
		oidNoBdsm = AddToggleOption("Disable BDSM content", PHSF.disableBdsm)
		if (!PHSF.DisableBdsm)
			oidUseMarkers = AddToggleOption("Use designated locations for BDSM equipment", PHSF.UseBdsmMarkers)
		endif
		oidCombatTraining = AddToggleOption("Slaves will spar during combat training", PHSF.DoCombatTraining)
		if (PHSF.SLAL.HasSlal())
			oidArousalThreshold = AddSliderOption("Follower arousal level", PHSF.ArousedFollowerThreshold, "{0}")
		endif

		oidSpawnFurniture = AddToggleOption("Spawn BDSM furniture during training", PHSF.SpawnFurniture)
		if (PHSF.HasSerialStrip)
			oidSerialStrip = AddToggleOption("Animated slave stripping", PHSF.UseSerialStrip)
		endif
		oidBanditSlaves = AddToggleOption("Auction slaves based on bandits", PHSF.UseBanditSlaves)
		oidAddressPAH = AddToggleOption("Give PAH slaves additional dialogue", PHSF.ControlPAHSlaves)
		if (PHSF.HasTortureFramework)
			oidITFControl = AddToggleOption("Torture Framework handles torture", PHSF.FrameworkHandlesTorture)
		endif
		oidSummonTM = AddKeyMapOption("Summon Taskmaster hotkey", PHSF.SummonTaskmasterKey, OPTION_FLAG_WITH_UNMAP)

		AddEmptyOption()
		oidDebugLog = AddToggleOption("Enable debug logging", PHSF.DebugLogging)
		oidSkipQuest = AddToggleOption("Questline is optional", PHSF.SkipQuests)

		AddEmptyOption()
		oidResetLists = AddTextOption("[ Rebuild slave lists ]", None)

		SetCursorPosition(1)
		AddHeaderOption("Detected Mods")
		oidModDOM = AddboolTextOption("DOM (Required)", (PHHSHInter.DOM != None), false)
		;oidModDOMt = AddToggleOption("DOM Extended training", PHHSHInter.UseDOMTraining)
		oidModPahe = AddboolTextOption("PAHE (Optional)", (PHHSHInter.PAH != None), false)
		oidModPaheS = AddboolTextOption("PAHE Extended  (Optional)", (PHHSHInter.HasSexExtension()), false)

		oidModOsa = AddboolTextOption("OSA - 0Sex (optional)", (PHSF.OSAFaction != None), true)
		oidModSS = AddboolTextOption("SerialStrip * (optional)", (PHSF.HasSerialStrip), true)
		oidModFnis = AddboolTextOption("FNIS Spells (optional)", (PHSF.HasFnisSpells), true)
		oidModHR = AddboolTextOption("Heretical Resources (optional)", (PHSF.HasHereticalResources), true)
		oidModDM = AddboolTextOption("I'll Take The Display Model (optional)", (PHSF.DisplayModelFurniture != None), true)
		oidModZE = AddboolTextOption("ZBF Expansion Pack (optional)", PHSF.HasZazExtension, true)
;		oidModZap622 = AddboolTextOption("ZAP v6.22+ (optional)", PHSF.HasZaz622p, true)
		if (PHSF.Zaz8Version <= 0)
			oidModZap8 = AddboolTextOption("ZAP v8.0 (optional)", PHSF.HasZaz8, true)
		elseif (PHSF.Zaz8Version == 1)
			oidModZap8 = AddboolTextOption("ZAP v8.0+ (optional)", PHSF.HasZaz8, true)
		elseif (PHSF.Zaz8Version == 2)
			oidModZap8 = AddboolTextOption("ZAP v9.0 (optional)", PHSF.HasZaz8, true)
		endif
		if (!PHSF.HasZaz8)
			oidModTara = AddboolTextOption("Tara Furniture Pack (optional)", PHSF.HasTaraPack, true)
			if (!PHSF.HasTaraAnims2) 
				oidModTaraAnims = AddboolTextOption("Tara Animation Pack (optional)", PHSF.HasTaraAnims, true)
			else
				oidModTaraAnims = AddboolTextOption("Tara Animation Pack, ZAP integrated (optional)", PHSF.HasTaraAnims2, true)
			endif
		endif
		oidModITF = AddboolTextOption("Torture Framework * (optional)", PHSF.HasTortureFramework, true)
		oidModDD = AddboolTextOption("Devious Devices * (optional)", (PHSF.DOMZAD.zad_Lockable != None), true)
		oidModAygas = AddboolTextOption("And You Get a Slave! * (optional)", (PHSF.HasAygas), true)
		oidModSlaveCart = AddboolTextOption("PAH Slave Cart * (optional)", (PHSF.HasSlaveCart), true)
		oidModSLAL = AddboolTextOption("SexLab Aroused * (optional)", (PHSF.SLAL.HasSLAL()), true)
		oidModSLALAggressive = AddToggleOption("Followers are aggressive",PHSF.FollowersAggro)
		oidModMME = AddboolTextOption("Milk Mod Economy (optional)", (PHSF.HasMME), true)
		oidModST = AddboolTextOption("SlaveTats (optional)", (PHSF.HasSlaveTats), true)

		AddEmptyOption()
		AddTextOption("*) If you install one of these mods later, re-run the", "")
		AddTextOption("     installer for this mod and select the appropriate", "")
		AddTextOption("     patches", "")

		oidReloadDeps = AddTextOption("[ Reset dependencies ]", None)
		oidRepairTracker = AddTextOption("[ Reset Slave Camp Tracker ]", None)

		; oidDebugReset = AddTextOption("[ Restore Slave Camps & Houses ]", None)
EndFunction

PAHOPortable Property PortableFunctions Auto

int slaveList  = 0
int selected_info = -1

Function DoUpdateCamps()
	UnloadCustomContent()
	;*ebug.trace("DoUpdateCamps ShowAll="+ShowAll+" DisplayedCellRef="+DisplayedCellRef)

	if PHSF == None
		return
	endif
	if PortableFunctions == None
		return
	endif
	SetCursorFillMode(TOP_TO_BOTTOM)
	if slave_OID.length != 43
		slave_OID = new Int[43]
		slave_ref = new DOM_Actor[43]
	endif

	SetCursorPosition(0) ; Start with left column

	UpdateCellList(PHSF.PortableFunctions.CellRefs,"camp",false)

	slaveList  = 0
	selected_info = -1
	if ShowAll || DisplayedCellRef == PortableFunctions.TempCamp
		string tcs = PortableFunctions.GetNameTempCamp()
		Actor grd = PortableFunctions.GetGuardTempCamp()
		if tcs != ""
			UpdateSlaveList(PHSF.TCampSlot,tcs+" encampment",grd,PHSF.GetNTempCamp(),true,true)
		endif
	endif

	int j = 0
	int m = PHSF.PortableFunctions.CellRefs.length
	while j < m
		PHHSHPortableCellScript CellRef = PortableFunctions.CellRefs[j] as PHHSHPortableCellScript
		if CellRef != None  && (ShowAll || DisplayedCellRef == CellRef)
			bool is_outdoor = cellRef.IsOutDoorCell()
			if is_outdoor
				Cell parentCell = cellRef.ParentCell
				cellRef.SetLocation()
				string tcs = cellRef.GetNameCellRef()
				Actor grd = cellRef.GetGuardCellRef()
				UpdateSlaveList(PortableFunctions.SlaveRefsInCell(parentCell),tcs+" camp",grd,PortableFunctions.CountSlaveRefsInCell(parentCell),true,false)
			endif
		endif
		j += 1
	endwhile
	if j == 0
		AddHeaderOption("Permanent camps - None")
	endif

	;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info >= 0 && selected_info < slave_ref.length
		displayedActor = slave_ref[selected_info]
		UpdateActorInfoPage()
	endif
EndFunction

Function DoUpdateRestlessHunter()
	UnloadCustomContent()
	;*ebug.trace("DoUpdateRestlessHunter ShowAll="+ShowAll+" DisplayedCellRef="+DisplayedCellRef)

	if PHSF == None
		return
	endif
	SetCursorFillMode(TOP_TO_BOTTOM)
	if slave_OID.length != 43
		slave_OID = new Int[43]
		slave_ref = new DOM_Actor[43]
	endif

	SetCursorPosition(0) ; Start with left column
	
	int n = PHSF.GetNSlotHunter()
	if n < 1
		AddHeaderOption("The Restless Hunter: empty")
	elseif n <= 1
		AddHeaderOption("The Restless Hunter: 1 slave")
	else
		AddHeaderOption("The Restless Hunter: "+n+" slaves")
	endif
	oidHunter = AddTextOption("[Click to reset slaves]", None);
	int i = 0
	int slaveCount = PHSF.HunterSlot.length
	slaveList  = 0
	selected_info = -1
	while (i < slaveCount) && (slaveList < 43) && (slaveList < slave_OID.length)
		ReferenceAlias ref = PHSF.HunterSlot[i]
		if ref.GetRef() != None
			DOM_Actor sl_alias = ref as DOM_Actor
			if sl_alias != None
				slave_ref[slaveList] = sl_alias
				slave_OID[slaveList] = AddTextOption((slaveList+1) + ": " + sl_alias.GetName(), sl_alias.GetTitle())
				if currentActor_OID == slave_OID[slaveList]
					selected_info = slaveList
				endif
				slaveList += 1
				;*ebug.trace("PHHSHConfigmenu DoUpdateRestlessHunter Actor["+i+"]="+sl_alias.getName()+" OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
			endif
		endif
		i += 1
	endWhile

	;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info >= 0 && selected_info < slave_ref.length
		displayedActor = slave_ref[selected_info]
		UpdateActorInfoPage()
	endif
EndFunction

Function DoUpdateHouseSlaves()
	UnloadCustomContent()
	;*ebug.trace("DoUpdateHouseSlaves ShowAll="+ShowAll+" DisplayedCellRef="+DisplayedCellRef)

	if PHSF == None
		return
	endif
	SetCursorFillMode(TOP_TO_BOTTOM)
	if slave_OID.length != 43
		slave_OID = new Int[43]
		slave_ref = new DOM_Actor[43]
	endif

	SetCursorPosition(0) ; Start with left column

	;*ebug.trace("DoUpdateHouseSlaves CellRefs="+PHSF.PortableFunctions.CellRefs)
	UpdateCellList(PHSF.PortableFunctions.CellRefs,"house",true)

	int i = 0
	slaveList  = 0
	selected_info = -1
	int n = 0
	int j = 0
	int m = PHSF.PortableFunctions.CellRefs.length
	while j < m
		PHHSHPortableCellScript CellRef = PortableFunctions.CellRefs[j] as PHHSHPortableCellScript
		if CellRef != None  && (ShowAll || DisplayedCellRef == CellRef)
			bool is_indoor = cellRef.IsInDoorCell()
			if is_indoor
				Cell parentCell = cellRef.ParentCell
				cellRef.SetLocation()
				string tcs = cellRef.GetNameCellRef()
				Actor grd = cellRef.GetGuardCellRef()
				UpdateSlaveList(PortableFunctions.SlaveRefsInCell(parentCell),tcs+" camp",grd,PortableFunctions.CountSlaveRefsInCell(parentCell),true,false)
			endif
		endif
		j += 1
	endwhile
	if j == 0
		AddHeaderOption("Permanent camps - None")
	endif

	;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info >= 0 && selected_info < slave_ref.length
		displayedActor = slave_ref[selected_info]
		UpdateActorInfoPage()
	endif
EndFunction

string Function GetLocationName(Actor akRef)
	if akRef == None
		return "the wilderness"
	endif
	Location the_loc = akRef.GetCurrentLocation()
	if the_loc == None
		Cell parentCell = akRef.GetParentCell()
		if parentCell != None
			string the_place = parentCell.GetName()
			if the_place != ""
				return the_place
			endif
		endif
		return "the wilderness"
	endif
	string the_name = the_loc.GetName()
	if the_name == ""
		Cell parentCell = akRef.GetParentCell()
		if parentCell != None
			string the_place = parentCell.GetName()
			if the_place != ""
				return the_place
			endif
		endif
		return "the wilderness"
	endif
	return the_name
EndFunction


float Function getAnglePlayer(Actor akRef)
	Actor PlayerRef = Game.GetPlayer()
	float angle = PlayerRef.GetAngleZ() + PlayerRef.GetHeadingAngle(akRef)
	if angle < 0.0
		while angle < 0.0
			angle = 360.0 - angle
		endWhile
		return angle
	endif
	while angle > 360.0
		angle = angle - 360.0
	endWhile
	return angle
EndFunction

string Function GetDirectionString(Actor akRef)
	float angle = getAnglePlayer(akRef)
	
	if angle <= 22.5
		return "to your north."
	elseif angle <= 67.5
		return "to your northeast."
	elseif angle <= 112.5
		return "to your east."
	elseif angle <= 157.5
		return "to your southeast"
	elseif angle <= 202.5
		return "to your south."
	elseif angle <= 247.5
		return "to your southwest."
	elseif angle <= 292.5
		return "to your west."
	elseif angle <= 337.5
		return "to your northwest."
	elseif angle <= 360.0
		return "to your north."
	endif
	return "in an unknown direction."
EndFunction

string Function GetDistanceString(Actor akRef)
	Actor PlayerRef = Game.GetPlayer()
	string units = " metres"
	float distance = akRef.GetDistance(PlayerRef) * 0.01428 ; 1000.0 units = 14.28 meters
	if distance > 1000.0
		distance = distance / 1000.0
		units = " kilometres"
	endif
	return (distance as int) + units
EndFunction

string Function GetPositionString(Actor akRef)
	string dirStr = GetDirectionString(akRef)
	string farStr = GetDistanceString(akRef)
	return farStr+" "+dirStr
EndFunction

Int actorTitle_OID
Int actorName_OID
Int actorWrite_OID
Int actorRead_OID
Int actorPrevious_OID
Int actorGender_OID
Int actionFlag_OID
Int actionName_OID
Int actionType_OID
Int actorPose_OID
Int actorStrugglePose_OID
Int actorEssential_OID
Int actorSummon_OID
Int actorResetDiary_OID
Int actorRelease_OID
Int actorFixme_OID
Int actorFixTats_OID
Int actorSummonBag_OID

DOM_Actor displayedActor = None

Function UpdateSlaveList(ReferenceAlias[] slaveRefs, string title, Actor grd, int n, bool show_guard, bool full_check)
	;*ebug.trace("UpdateSlaveList for "+title+" : "+n+" slaves")
	AddHeaderOption(title+" : "+n+" slaves")
	if show_guard
		if grd != None
			if PHHSHInter.isASlaver(grd)
				DOM_Actor sl_alias = PHHSHInter.GetActor(grd)
				if sl_alias != None
					slave_ref[slaveList] = sl_alias
					slave_OID[slaveList] = AddTextOption((slaveList+1) + ": Guarded by ", sl_alias.GetName())
					if currentActor_OID == slave_OID[slaveList]
						selected_info = slaveList
					endif
					slaveList += 1
				else
					AddTextOption("Guarded by ",grd.GetDisplayName(), OPTION_FLAG_DISABLED)
				endif
			else
				AddTextOption("Guarded by ",grd.GetDisplayName(), OPTION_FLAG_DISABLED)
			endif
		else
			AddTextOption("Unguarded!","", OPTION_FLAG_DISABLED)
		endif
	endif
	int slaveCount
	if full_check
		slaveCount = slaveRefs.length
	else
		slaveCount = n
	endif
	;*ebug.trace("UpdateSlaveList for "+title+" slaveCount="+slaveCount)
	int i = 0
	while (i < slaveCount) && (slaveList < 43) && (slaveList < slave_OID.length)
		ReferenceAlias ref = slaveRefs[i]
		;*ebug.trace("UpdateSlaveList "+title+" "+i+" ref="+ref)
		if ref != None && ref.GetRef() != None
			DOM_Actor sl_alias = ref as DOM_Actor
			if sl_alias != None
				slave_ref[slaveList] = sl_alias
				slave_OID[slaveList] = AddTextOption((slaveList+1) + ": " + sl_alias.GetName(), sl_alias.GetTitle())
				if currentActor_OID == slave_OID[slaveList]
					selected_info = slaveList
				endif
				slaveList += 1
				;*ebug.trace("PHHSHConfigmenu UpdateSlaveList "+title+" Actor["+i+"]="+sl_alias.getName()+" OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
			endif
		endif
		i += 1
	endWhile
EndFunction

string Function GetCampName(ReferenceAlias the_cell)
	if the_cell == None ||  the_cell.GetRef() == None
		return "Nowhere"
	endif
	if the_cell == PortableFunctions.TempCamp
		return PortableFunctions.GetNameTempCamp()+" encampment"
	endif
	PHHSHPortableCellScript cell_script = the_cell as PHHSHPortableCellScript
	if cell_script == None
		return "Nowhere"
	endif
	return cell_script.GetNameCellRef()
EndFunction

int Function GetCampCounter(ReferenceAlias the_cell)
	if the_cell == None ||  the_cell.GetRef() == None
		return 0
	endif
	if the_cell == PortableFunctions.TempCamp
		return PHSF.GetNTempCamp()
	endif
	PHHSHPortableCellScript cell_script = the_cell as PHHSHPortableCellScript
	if cell_script == None
		return 0
	endif
	return cell_script.actorCounter
EndFunction

Function UpdateCellList(ReferenceAlias[] the_list, string title, bool is_interior)
	cellRefs_count = 0
	if cellRefs_OID.length != 43
		cellRefs_OID = new Int[43]
	endif

	; Fill the cell refs list
	int n
	int i = 0
	int j = 0
	if !the_list
		n = 0
	else
		n = the_list.length
	endif
	;*ebug.trace("UpdateCellList n="+n)
	if !is_interior
		if PortableFunctions.TempCamp != None && PortableFunctions.TempCamp.GetRef() != None
			cellRefs_array[0] = PortableFunctions.TempCamp
			j += 1
		endif
	endif
	while i < n && j < cellRefs_array.length
		PHHSHPortableCellScript the_cell = the_list[i] as PHHSHPortableCellScript
		if the_cell != None
			if is_interior
				if the_cell.IsInDoorCell()
					cellRefs_array[j] = the_list[i]
					j += 1
				endif
			else
				if the_cell.IsOutDoorCell()
					cellRefs_array[j] = the_list[i]
					j += 1
				endif
			endif
		endif
		i += 1
	endWhile
	cellRefs_count = j
	if cellRefs_count > cellRefs_OID.length
		cellRefs_count = cellRefs_OID.length
	endif

	AddHeaderOption("Active "+title+"s : "+cellRefs_count)
	;*ebug.trace("UpdateCellList cellRefs_count="+cellRefs_count)
	if cellRefs_count <= 0
		oidShowAll = AddTextOption("No "+title+" to show", None, OPTION_FLAG_DISABLED)
		return
	endif
	if cellRefs_count == 1
		ReferenceAlias the_cell = cellRefs_array[0]
		int nb = GetCampCounter(the_cell)
		string name = GetCampName(the_cell)
		;*ebug.trace("UpdateCellList "+name+" cell="+the_cell.GetRef())
		oidShowAll = AddTextOption(name,nb, OPTION_FLAG_DISABLED)
		return
	endif
	if !showAll
		oidShowAll = AddTextOption("Show All", None)
	endif
	j = 0
	while j < cellRefs_count && j < cellRefs_array.length
		if cellRefs_array[j] != None
			;*ebug.trace("UpdateCellList "+j+" alias="+the_cell)
			ReferenceAlias the_cell = cellRefs_array[j]
			int nb = GetCampCounter(the_cell)
			string name = GetCampName(the_cell)
			if the_cell == DisplayedCellRef
				cellRefs_OID[j] = AddTextOption(name,nb, OPTION_FLAG_DISABLED)
			else
				cellRefs_OID[j] = AddTextOption(name,nb)
			endif
			;*ebug.trace("UpdateCellList "+j+" "+name+" ref="+the_cell.GetRef())
		endif
		j += 1
	endwhile
EndFunction

Function UpdateMineList()
	;*ebug.trace("UpdateMineList")
	cellRefs_count = 0
	string title = "mine"
	if cellRefs_OID.length != 43
		cellRefs_OID = new Int[43]
	endif

	; Fill the cell refs list
	int n = cellRefs_array.length
	if n > 1
		cellRefs_array[0] = PAHOCamps.GuardKarthwarsten
		cellRefs_count +=1
	endif
	if n > 2
		cellRefs_array[1] = PAHOCamps.GuardStonehills
		cellRefs_count +=1
	endif
	if n > 3
		cellRefs_array[2] = PAHOCamps.GuardDawnstar
		cellRefs_count +=1
	endif

	;*ebug.trace("UpdateMineList cellRefs_count="+cellRefs_count)
	AddHeaderOption("Active "+title+"s : "+cellRefs_count)
	if cellRefs_count <= 0
		oidShowAll = AddTextOption("No "+title+" to show", None, OPTION_FLAG_DISABLED)
		return
	endif
	if cellRefs_count == 1
		ReferenceAlias the_cell = cellRefs_array[0]
		if the_cell != None
			int nb = PAHOCamps.GetMineCounter(the_cell)
			string name = PAHOCamps.GetMineName(the_cell)
			;*ebug.trace("UpdateMineList "+name+" mine="+the_cell.GetRef())
			oidShowAll = AddTextOption(name,nb, OPTION_FLAG_DISABLED)
		endif
		return
	endif
	if !showAll
		oidShowAll = AddTextOption("Show All", None)
	endif
	int j = 0
	while j < cellRefs_count && j < cellRefs_array.length
		ReferenceAlias the_cell = cellRefs_array[j]
		if the_cell != None
			int nb = PAHOCamps.GetMineCounter(the_cell)
			string name = PAHOCamps.GetMineName(the_cell)
			;*ebug.trace("UpdateMineList  "+j+" "+name+" alias="+the_cell)
			;*ebug.trace("UpdateMineList  "+j+" "+name+" ref="+the_cell.GetRef())
			if the_cell == DisplayedCellRef
				cellRefs_OID[j] = AddTextOption(name,nb, OPTION_FLAG_DISABLED)
			else
				cellRefs_OID[j] = AddTextOption(name,nb)
			endif
		endif
		j += 1
	endwhile
EndFunction

Function UpdateActorInfoPage()
	if displayedActor == None
		return
	endif
	DOM_Mind akMind = displayedActor.mind
	Actor akRef = displayedActor.akRef
	
	actorName_OID = AddInputOption("$Name: ",displayedActor.GetName())
	if displayedActor.getTitle() == ""
		actorTitle_OID = AddInputOption("$Title: ","$<Press to set>")
	else
		actorTitle_OID = AddInputOption("$Title: ",displayedActor.GetTitle())
	endif
	if akRef.GetLeveledActorBase().IsUnique()
		String before_name = PHHSHInter.GetPreviousOccupation(akRef)
		if before_name != displayedActor.GetName()
			actorPrevious_OID = AddTextOption("Before: ",before_name+" [Unique]", OPTION_FLAG_DISABLED)
		else
			actorPrevious_OID = AddTextOption("Before: ","[Unique]", OPTION_FLAG_DISABLED)
		endif
	else
		actorPrevious_OID = AddTextOption("Before: ",PHHSHInter.GetPreviousOccupation(akRef), OPTION_FLAG_DISABLED)
	endif
	string str_gender = displayedActor.GetGenderbyString()
	actorGender_OID = AddInputOption("$Gender: ", str_gender)
	if akMind.is_slave
		string status = akMind.GetTrainingStatusName()
		if status != "enslaved"
			status += " slave"
		endif
		AddTextOption("$Status: ", status, OPTION_FLAG_DISABLED)
	elseif PHHSHInter.IsAPlayerSlaver(akRef)
		AddTextOption("$Status: ", "slaver", OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Status: ", "free person", OPTION_FLAG_DISABLED)
	endif
	AddTextOption("$Mood: ", akMind.mood, OPTION_FLAG_DISABLED)
	AddTextOption("$Location: ", GetLocationName(akRef), OPTION_FLAG_DISABLED)
	if akRef.GetParentCell() ==  Game.GetPlayer().GetParentCell() 
		AddTextOption("Position: ", GetPositionString(akRef), OPTION_FLAG_DISABLED)
	endif
	
	if displayedActor.behaviour == "follow_player" && PHHSHInter.DOM != None
		int rank = akRef.GetFactionRank(PHHSHInter.DOM.DOMFollowMode)
		if rank == 0
			AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle()+" tight", OPTION_FLAG_DISABLED)
		elseif rank == 1
			AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle()+" close", OPTION_FLAG_DISABLED)
		elseif rank == 3
			AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle()+" far", OPTION_FLAG_DISABLED)
		else
			AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle()+" short", OPTION_FLAG_DISABLED)
		endif
	else
		AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle(), OPTION_FLAG_DISABLED)
	endif
	ObjectReference target = displayedActor.target.GetRef()
	if target != None
		string target_name = target.GetDisplayName()
		if target_name == ""
			target_name = target.GetName()
		endif
		if target_name == ""
			target_name = "No Name"
		endif
		AddTextOption("Target: ", target_name, OPTION_FLAG_DISABLED)
	endif

	string the_pose =  displayedActor.GetPose()
	if the_pose != ""
		actorPose_OID = AddInputOption("$Pose: ", the_pose)
		string the_struggle_pose =  displayedActor.GetStrugglePose()
		if the_struggle_pose != ""
			actorStrugglePose_OID = AddInputOption("$Struggle pose: ", the_struggle_pose)
		else
			actorStrugglePose_OID = -1
		endif
	else
		actorPose_OID = -1
	endif
	if akRef.IsEssential()
		actorEssential_OID = AddTextOption("Remove essential flag", "$Click")
	else
		actorEssential_OID = AddTextOption("Set essential flag", "$Click")
	endif
	actorSummon_OID = AddTextOption("$Summon to player", "$Click")
	if displayedActor.the_bag_iam_in != None
		actorSummonBag_OID = AddTextOption("$Summon burlap sack", "$Click")
	endif
	actorResetDiary_OID = AddTextOption("Reset diary text", "$Click")
	actorFixTats_OID = AddTextOption("$Fix SlaveTats", "$Click")
	;if displayedActor.akRef.Is3DLoaded()
		actorFixme_OID = AddTextOption("$Fix unresponsive or invisible actor", "$Click")
	;endif
	actorRelease_OID = AddTextOption("Release actor", "$Click")

	if akMind.submission <= 100.0
		AddTextOption("$Submission: ", akMind.submission, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love desire: ", akMind.love_desire, OPTION_FLAG_DISABLED)
	endif
	if akMind.fear_training <= 100.0
		AddTextOption("$Fear training: ", akMind.fear_training, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal worship: ", akMind.loyal_worship, OPTION_FLAG_DISABLED)
	endif
	if akMind.humiliation <= 100.0
		AddTextOption("$Humiliation: ", akMind.humiliation, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love fascination: ", akMind.love_fascination, OPTION_FLAG_DISABLED)
	endif
	if akMind.anger_training <= 100.0
		AddTextOption("$Anger training: ", akMind.anger_training, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal absolution: ", akMind.loyal_absolution, OPTION_FLAG_DISABLED)
	endif
	if akMind.resignation <= 100.0
		AddTextOption("$Resignation: ", akMind.resignation, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal devotion: ", akMind.loyal_devotion, OPTION_FLAG_DISABLED)
	endif
	if akMind.respect_training <= 100.0
		AddTextOption("$Respect training: ", akMind.respect_training, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love admiration: ", akMind.love_admiration, OPTION_FLAG_DISABLED)
	endif
	AddTextOption("$Sex training: ", akMind.sex_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Vaginal training: ", akMind.vaginal_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Oral training: ", akMind.oral_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Anal training: ", akMind.anal_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Combat training: ", akMind.combat_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Pose training: ", akMind.pose_training, OPTION_FLAG_DISABLED)
	if ((displayedActor.actorSex)%2) == 0
		AddTextOption("$Servant training: ", akMind.house_training, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Maid training: ", akMind.house_training, OPTION_FLAG_DISABLED)
	endif
	AddTextOption("Work training: ", akMind.work_training, OPTION_FLAG_DISABLED)
	AddTextOption("Enforcer skill: ", akMind.skill_enforcer, OPTION_FLAG_DISABLED)
	AddTextOption("Predator skill: ", akMind.skill_predator, OPTION_FLAG_DISABLED)
	AddTextOption("Depraver skill: ", akMind.skill_depraver, OPTION_FLAG_DISABLED)
	AddTextOption("Persuader skill: ", akMind.skill_persuader, OPTION_FLAG_DISABLED)
	AddTextOption("Slaver skill: ", akMind.skill_slaver, OPTION_FLAG_DISABLED)
	AddTextOption("Deceiver skill: ", akMind.skill_deceiver, OPTION_FLAG_DISABLED)
	AddTextOption("Dirtiness: ", displayedActor.dirty_level, OPTION_FLAG_DISABLED)
	AddTextOption("Drunk level: ", akMind.GetDrunkLevel(), OPTION_FLAG_DISABLED)
	AddTextOption("Blood alcohol: ", akMind.GetBloodAlcohol(), OPTION_FLAG_DISABLED)
	actorWrite_OID = AddTextOption("Write JSON file", "$Click")
	actorRead_OID = AddTextOption("Read JSON file", "$Click")
EndFunction

PAHOCampOperation Property PAHOCamps Auto
Int[] slave_OID
DOM_Actor[] slave_ref
Int currentActor_OID = -1

Function DoUpdateMiners()
	UnloadCustomContent()
	;*ebug.trace("DoUpdateMiners ShowAll="+ShowAll+" DisplayedCellRef="+DisplayedCellRef)
	if PAHOCamps == None
		return
	endif
	SetCursorFillMode(TOP_TO_BOTTOM)
	if slave_OID.length != 43
		slave_OID = new Int[43]
		slave_ref = new DOM_Actor[43]
	endif

	SetCursorPosition(0) ; Start with left column

	UpdateMineList()
	
	slaveList  = 0
	selected_info = -1
	if ShowAll || DisplayedCellRef == PAHOCamps.GuardKarthwarsten
		UpdateSlaveList(PAHOCamps.SlotKarthwarsten,"Karthwarsten's mine",None,PAHOCamps.NumberOfMinersKarthwarsten,false,true)
	endif
	if ShowAll || DisplayedCellRef == PAHOCamps.GuardStonehills
		UpdateSlaveList(PAHOCamps.SlotStonehills,"Stonehills's mine",None,PAHOCamps.NumberOfMinersStonehills,false,true)
	endif
	if ShowAll || DisplayedCellRef == PAHOCamps.GuardDawnstar
		UpdateSlaveList(PAHOCamps.SlotDawnstar,"Dawnstar's mine",None,PAHOCamps.NumberOfMinersDawnstar,false,true)
	endif

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info >= 0 && selected_info < slave_ref.length
		displayedActor = slave_ref[selected_info]
		UpdateActorInfoPage()
	endif
EndFunction

int Function AddboolTextOption(string text, bool value, bool optional)
	string s = "<font color='#00FF00'>OK</font>"
	if (!value)
		if (optional)
			s = "---"
		else
			s = "<font color='#FF0000'>Missing</font>"
		endif
	endif
	return AddTextOption(text, s)
EndFunction

Event OnOptionMenuOpen(int option)
	if (option == oidOwnerGreet )
   		string[] greetOpt = new string[5]
    		greetOpt [0] = "No greeting"
   		greetOpt [1] = "Kneel"
   		greetOpt [2] = "Hands behind head"
   		greetOpt [3] = "Bow head"
   		greetOpt [4] = "Bow, hands on back"
		SetMenuDialogOptions(greetOpt)
		SetMenuDialogDefaultIndex(2)
		if (PHSF.GreetType >= 0)
			SetMenuDialogStartIndex(PHSF.GreetType)
		endif
	endif
EndEvent

Event OnOptionMenuAccept(int option, int index)
	if (option == oidOwnerGreet )
		if (index >= 0)
			PHSF.GreetType = index
			PHSF.CustomGreeting = ""
			ForcePageReset()
		endif
	endif
EndEvent

Event OnOptionInputOpen(int a_option)
	if (a_option == oidCustomGreeting)
		SetInputDialogStartText(PHSF.CustomGreeting)
	elseif (a_option == actorName_OID && actorName_OID != -1)
		If displayedActor == None
			return
		endif
		SetInputDialogStartText(displayedActor.GetName())
		return
	elseif (a_option == actorGender_OID && actorGender_OID != -1)
		If displayedActor == None
			return
		endif
		string str_gender = displayedActor.GetGenderbyString()
		SetInputDialogStartText(str_gender)
		return
	elseif (a_option == actorTitle_OID && actorTitle_OID != -1)
		If displayedActor == None
			return
		endif
		SetInputDialogStartText(displayedActor.GetTitle())
		return
	elseif (a_option == actorPose_OID && actorPose_OID != -1)
		If displayedActor == None
			return
		endif
		SetInputDialogStartText(displayedActor.GetPose())
		return
	elseif (a_option == actorStrugglePose_OID && actorStrugglePose_OID != -1)
		If displayedActor == None
			return
		endif
		SetInputDialogStartText(displayedActor.GetStrugglePose())
		return
	endif
EndEvent

Event OnOptionInputAccept(int a_option, string a_input)
	if (a_option == oidCustomGreeting)
		PHSF.CustomGreeting = a_input
		ForcePageReset()
	elseif (a_option == actorName_OID && actorName_OID != -1)
		If displayedActor == None
			return
		endif
		If a_input != ""
			displayedActor.SetDisplayName(a_input)
			displayedActor.mind.SetDisplayName(a_input)
		endif
		SetInputOptionValue(a_option, displayedActor.getName())
		ForcePageReset()
		return
	elseif (a_option == actorGender_OID && actorGender_OID != -1)
		If displayedActor == None
			return
		endif
		If a_input != ""
			displayedActor.SetGenderByString(a_input)
			displayedActor.mind.SetGenderByString(a_input)
		endif
		string str_gender = displayedActor.GetGenderbyString()
		SetInputOptionValue(a_option, str_gender)
		return
	elseif (a_option == actorTitle_OID && actorTitle_OID != -1)
		If displayedActor == None
			return
		endif
		displayedActor.SetTitle(a_input)
		displayedActor.mind.SetTitle(a_input)
		SetInputOptionValue(a_option, displayedActor.GetTitle())
		SetTextOptionValue(currentActor_OID, displayedActor.GetTitle())
		return
	elseif (a_option == actorPose_OID && actorPose_OID != -1)
		If displayedActor == None
			return
		endif
		displayedActor.SetQuietPose(a_input)
		SetInputOptionValue(a_option, displayedActor.GetPose())
		return
	elseif (a_option == actorStrugglePose_OID && actorStrugglePose_OID != -1)
		If displayedActor == None
			return
		endif
		displayedActor.SetStrugglePose(a_input)
		SetInputOptionValue(a_option, displayedActor.GetStrugglePose())
		return
	endif
EndEvent

Event OnOptionSelect(int option)
	if (CurrentPage == Pages[0])
		DoOptionsPage(option)
		return
	elseif (CurrentPage == Pages[1])
		DoHunterSlaves(option)
		DoListSlaves(option)
	elseif (CurrentPage == Pages[2])
		DoHouseSlaves(option)
		DoListCells(option)
		DoListSlaves(option)
	elseif (CurrentPage == Pages[3])
		DoCampSlaves(option)
		DoListCells(option)
		DoListSlaves(option)
	elseif (CurrentPage == Pages[4])
		DoMineSlaves(option)
		DoListCells(option)
		DoListSlaves(option)
		return
	endif
EndEvent

Function DoListCells(int option)
	if option == oidShowAll
		DisplayedCellRef = None
		ShowAll = true
		ForcePageReset()
		return
	endif
	int i = cellRefs_count
	while (i > 0)
		i -= 1
		if (option == cellRefs_OID[i])
			DisplayedCellRef = cellRefs_array[i]
			ShowAll = false
			ForcePageReset()
			return
		endif
	endwhile
EndFunction

Function DoListSlaves(int option)
	If displayedActor != None
		If (option == actorEssential_OID)
			if displayedActor != None && displayedActor.akRef != None
				Actor akRef = displayedActor.akRef
				if akRef.IsEssential()
					akRef.GetLeveledActorBase().SetInvulnerable(false)
					akRef.GetLeveledActorBase().SetEssential(false)
				else
					akRef.GetLeveledActorBase().SetEssential(true)
				endif					
			endif
			ForcePageReset()
			return
		elseif (option == actorSummon_OID)
			if displayedActor != None && displayedActor.akRef != None
				displayedActor.akRef.moveTo(Game.GetPlayer())
			endif
			ForcePageReset()
			return
		elseif (option == actorSummonBag_OID)
			if displayedActor != None && displayedActor.the_bag_iam_in != None
				displayedActor.the_bag_iam_in.moveTo(Game.GetPlayer(),afZOffset = 10.0)
			endif
			ForcePageReset()
			return
		elseif (option == actorResetDiary_OID)
			if displayedActor != None && displayedActor.akRef != None
				displayedActor.mind.MergeMemories()
				displayedActor.mind.ResetTextMemories()
			endif
			ForcePageReset()
			return
		elseif (option == actorRelease_OID)
			if displayedActor != None && displayedActor.akRef != None
				PAHOCamps.ReleaseAlias(displayedActor)
			endif
			ForcePageReset()
			return
		elseif (option == actorFixTats_OID)
			if displayedActor != None && displayedActor.akRef != None ; && displayedActor.akRef.Is3DLoaded()
				displayedActor.ResetTats()
				SlaveTats.synchronize_tattoos(displayedActor.akRef)
			endif
			ForcePageReset()
			return
		elseif (option == actorFixme_OID)
			if displayedActor != None && displayedActor.akRef != None ; && displayedActor.akRef.Is3DLoaded()
				displayedActor.SpecialReset()
				displayedActor.RestartBehaviour()
			endif
			ForcePageReset()
			return
		elseif (option == actorRead_OID)
			If displayedActor == None
				return
			endif
			SetTextOptionValue(actorRead_OID, "Importing values ", false)
			If ShowMessage("Import personality values from JSON file?")
				if PHHSHInter.DOM != None
					PHHSHInter.DOM.DOMGenerator.ReadJSON(displayedActor)
				endif
				;SetTextOptionValue(actorRead_OID, "$Done! ", false)
			Else
				;SetTextOptionValue(actorRead_OID, "", false)
			endif
			ForcePageReset()
			return
		elseif (option == actorWrite_OID)
			If displayedActor == None
				Debug.Trace("PHHSHConfigmenu WRITE JSON ERROR: No selected actor")
				return
			endif
			Debug.Trace("PHHSHConfigmenu WRITE JSON selected actor="+displayedActor.getName())
			SetTextOptionValue(actorWrite_OID, "Exporting values ", false)
			If ShowMessage("Export personality values to JSON file?")
				if PHHSHInter.DOM != None
					PHHSHInter.DOM.DOMGenerator.WriteJSON(displayedActor)
				endif
				;SetTextOptionValue(actorWrite_OID, "$Done! ", false)
			Else
				;SetTextOptionValue(actorWrite_OID, "", false)
			endif
			ForcePageReset()
			return
		endif
	endif

	currentActor_OID = option
	ForcePageReset()
EndFunction

Function DoHunterSlaves(int option)
EndFunction

Function DoCampSlaves(int option)
EndFunction

Function DoHouseSlaves(int option)
EndFunction

Function DoMineSlaves(int option)
EndFunction

Function DoOptionsPage(int option)
		if (option == oidSubGreet)
			PHSF.SubmissiveGreet = !PHSF.SubmissiveGreet
			SetToggleOptionValue(oidSubGreet, PHSF.SubmissiveGreet)
		elseif (option == oidUseMarkers)
			PHSF.UseBdsmMarkers = !PHSF.UseBdsmMarkers
			SetToggleOptionValue(oidUseMarkers, PHSF.UseBdsmMarkers)
		elseif (option == oidSpawnFurniture)
			PHSF.SpawnFurniture= !PHSF.SpawnFurniture
			SetToggleOptionValue(oidSpawnFurniture, PHSF.SpawnFurniture)
		elseif (option == oidModSLALAggressive)
			PHSF.FollowersAggro= !PHSF.FollowersAggro
			SetToggleOptionValue(oidModSLALAggressive, PHSF.FollowersAggro)
		elseif (option == oidNoBdsm)
			PHSF.DisableBdsm = !PHSF.DisableBdsm
			ForcePageReset()
		elseif (option == oidCombatTraining)
			PHSF.DoCombatTraining = !PHSF.DoCombatTraining
			ForcePageReset()
		elseif (option == oidOwnerGreet)
			PHSF.GreetOwner = !PHSF.GreetOwner
			ForcePageReset()
		elseif (option == oidExitGreeting)
			PHSF.ExitGreeting = !PHSF.ExitGreeting
			ForcePageReset()
		elseif (option == oidAltInv)
			PHSF.AlternateInventory = !PHSF.AlternateInventory
			SetToggleOptionValue(oidAltInv, PHSF.AlternateInventory)
		elseif (option == oidBanditSlaves)
			PHSF.UseBanditSlaves = !PHSF.UseBanditSlaves
			SetToggleOptionValue(oidBanditSlaves, PHSF.UseBanditSlaves)
		elseif (option == oidAddressPAH)
			PHSF.ControlPAHSlaves = !PHSF.ControlPAHSlaves;
			SetToggleOptionValue(oidAddressPAH, PHSF.ControlPAHSlaves)
		elseif (option == oidITFControl)
			PHSF.FrameworkHandlesTorture= !PHSF.FrameworkHandlesTorture;
			SetToggleOptionValue(oidITFControl, PHSF.FrameworkHandlesTorture)
		elseif (option == oidSkipQuest)
			if (!PHSF.SkipQuests)
				PHSF.SkipQuests = true
			else
				if (Game.GetPlayer().GetItemCount(PHSF.HunterFunctions.UpstairsKey) == 0)
					PHSF.SkipQuests = false
				endif
			endif
			SetToggleOptionValue(oidSkipQuest, PHSF.SkipQuests)
		elseif (option == oidDebugLog)
			PHSF.DebugLogging= !PHSF.DebugLogging
			SetToggleOptionValue(oidDebugLog, PHSF.DebugLogging)
		;elseif (option == oidModDOMt)
		;	PHHSHInter.UseDOMTraining = !PHHSHInter.UseDOMTraining
		;	SetToggleOptionValue(oidModDOMt, PHHSHInter.UseDOMTraining)
		elseif (option == oidRepairTracker)
			PHSF.PortableFunctions.SetObjectiveDisplayed(10, false)
			PHSF.PortableFunctions.SetObjectiveDisplayed(10, true)
		elseif (option == oidHunter)
			debug.messagebox("Resetting Hunter slaves")
			int n = PHSF.HunterSlot.length
			int i = 0
			while i < n
				Actor akRef = PHSF.HunterSlot[i].GetActorRef()
				if akRef != None
					int j
					if i < HunterCellMarker.length
						j = i
					else
						j = 0
					endif
					ResetSlot(PHSF.HunterSlot[i], HunterCellMarker[j])
				endif
				i += 1
			endwhile
		elseif (option == oidSerialStrip)
			PHSF.UseSerialStrip = !PHSF.UseSerialStrip 
			SetToggleOptionValue(oidSerialStrip, PHSF.UseSerialStrip )
		elseif (option == oidReloadDeps)
	;		Debug.MessageBox("Adding new furniture from ZAP 8, this may take a minute.  The menu will be unresponsive, please wait until completion is announced.  Click OK to start the process")
			PHSF.GetSoftRequirements()
	;		Debug.MessageBox("Done adding new forms from ZAP 8")
			Debug.MessageBox("Dependencies have been reset")
		elseif (option == oidResetLists)
			PortableFunctions.RestoreCells()
			Debug.MessageBox("Exit menu for recovering to finish")
			return
		endif
EndFunction

Event OnOptionSliderOpen(int option)
	if (option == oidArousalThreshold)
		SetSliderDialogStartValue(PHSF.ArousedFollowerThreshold)
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(30.0, 100.0)
		SetSliderDialogInterval(5.0)
	endif
EndEvent

Event OnOptionSliderAccept(int option, float value)
	if (option == oidArousalThreshold)
		PHSF.ArousedFollowerThreshold = Math.Floor(value)
		SetSliderOptionValue(oidArousalThreshold, PHSF.ArousedFollowerThreshold, "{0}")
	endif
EndEvent

Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	if (option == oidSummonTM)
		if (keyCode == 1)  ; Escape = clear
			keyCode = -1
		endif

		if (keyCode > 1) && (conflictcontrol != "")
			debug.messagebox("This key is already assigned to " + conflictControl + " - " + conflictName)
		else
			PHSF.SummonTaskmasterKey = keyCode
			SetKeyMapOptionValue(oidSummonTM, keyCode, false)
			(PHSF.PlayerAlias as phhshPlayerScript).ResetHotkeys()
		endif
	endif
EndEvent

Event OnOptionHighlight(int option)
	if (option == oidSubGreet)
		SetInfotext("If selected, house slaves will use a submissive presenting pose to greet you, instead of simply kneeling")
	elseif (option == oidOwnerGreet)
		SetInfotext("Select how slaves will greet their owner (that's you!)")
	elseif (option == oidExitGreeting)
		SetInfotext("If enabled, slaves will greet you for a moment, then go about their business again")
	elseif (option == oidUseMarkers)
		SetInfoText("Spawn BDSM furniture only in designated locations.  If turned off, furniture can be spawned anywhere")
	elseif (option == oidNoBdsm)
		SetInfoText("Disables the BDSM-themed content, such as punishment during training, and the bondage dialogues")
	elseif (option == oidAltInv)
		SetInfoText("If enabled, outfits worn by slaves (and invisible in their inventory) will be converted to inventory items, so they can be undressed manually")
	elseif (option == oidSkipQuest)
		SetInfoText("If enabled, you can buy house upgrades and have slave auctions at the Restless Hunter without completing the questline")
	elseif (option == oidDebugLog)
		SetInfoText("Write debug messages to the Skyrim log.  Enable this option if you experience problems and require support")
	elseif (option == oidBanditSlaves)
		SetInfoText("If enabled, slaves made available at auction will look like bandits instead of using the preset appearances.  Recommended if you have the Prettier Bandit mod, this option will make the slaves Prettier as well")
	elseif (option == oidSpawnFurniture)
		SetInfoText("Spawn torture devices when training a slave.  Disable this feature to only use existing devices (if any)")
	elseif (option == oidSerialStrip)
		SetInfoText("Uses animations when ordering a slave to strip (uses SerialStrip)")
	elseif(option == oidModPahe)
		SetInfoText("If highlighted, PAH is installed")
	elseif(option == oidModDOM)
		SetInfoText("If highlighted, DOM is installed")
	elseif(option == oidModPaheS)
		SetInfoText("If highlighted, your version of PAHE tracks sex stats separately")
	;elseif(option == oidModDOMt)
	;	SetInfoText("If highlighted, your HSH uses DOM training")
	elseif(option == oidModPaheD)
		SetInfoText("If highlighted, your version of PAHE stores details on slaves' origins")
	elseif(option == oidModSS)
		SetInfoText("Allows you to strip a slave one garment at a time, animated")
	elseif(option == oidModOsa)
		SetInfoText("Home Sweet Home will not interfere with OSA scenes")
	elseif(option == oidModFnis)
		SetInfoText("Required to make slaves dance or pose")
	elseif(option == oidModHR)
		SetInfoText("Adds some interesting restraint options like Havok wall chains")
	elseif(option == oidModDM)
		SetInfoText("Slaves will be restrained in Display Model furniture")
	elseif(option == oidModZE)
		SetInfoText("Adds extra bondage furniture and effects")
	elseif(option == oidModZap622)
		SetInfoText("Adds extra bondage furniture")
	elseif(option == oidModZap8)
		SetInfoText("This is the 8.0 and up version of ZAP with Tara's furniture and anims integrated.  Adds furniture and animations to HSH")
	elseif(option == oidModTara)
		SetInfoText("Adds bondage furniture and animations")
	elseif(option == oidModITF)
		SetInfoText("Adds animated torture in devices")
	elseif(option == oidModTaraAnims)
		SetInfoText("Adds more bondage options for trainers, punishment and transportation")
	elseif(option == oidModSLAL)
		SetInfoText("Followers will make use of HSH or PAHE slaves when aroused")
	elseif(option == oidModSLALAggressive)
		SetInfoText("Followers will be aggressive with slaves")
	elseif(option == oidAddressPAH)
		SetInfoText("Slaves out of houses (PAH slaves) will have some of the dialogue that your house slaves have")
	elseif(option == oidModDD)
		SetInfoText("Extra wearable bondage devices")
	elseif(option == oidModSlaveCart)
		SetInfoText("Slave Cart mod adds a cart to move your slaves around in")
	elseif(option == oidModAygas)
		SetInfoText("Slaves sold at auction at the Restless Hunter may turn up at auctions in town or with new owners around Skyrim")
	elseif(option == oidITFControl)
		SetInfoText("Let ITF control torture sessions in appropriate furniture")
	elseif(option == oidReloadDeps)
		SetInfoText("Reacquire dependencies and reload torture furniture lists")
	elseif (option == oidResetLists)
		SetInfoText("Clear and rebuild lists of slaves in houses.  Use if the list is corrupted.  Can be safely used at ayu time")
	elseif (option == oidArousalThreshold)
		SetInfoText("If a follower becomes more aroused than then limit set here, they will avail themselves of nearby slaves to satisfy their urges (set to 100 to disable)")
	elseif (option == oidRepairTracker)
		SetInfoText("Click this if the slave camp tracker disappears from your quest list or the map")
	elseif (option == oidModMME)
		SetInfoText("Milk Mod Economy lets you milk your slaves")
	elseif (option == oidModST)
		SetInfoText("SlaveTats mod allows taskmasters to tattoo slaves for you")
	elseif (option == oidCustomGreeting)
		SetInfoText("Set a custom greeting idle (click to set).  Any value that works with sae from console will work here")
	elseif (option == oidSummonTM)
		SetInfoText("Set a hotkey to summon or dismiss your taskmasters")
	elseif (option == oidCombatTraining)
		SetInfoText("When enabled, slaves will spar with each other when training combat.  In some cases this may cause aggro issues with bystanders.")
	endif
EndEvent

Function ResetSlot(ReferenceAlias Slot, ObjectReference Marker)
	Actor slave = Slot.GetActorRef()
	if (slave != None)
		slave.Enable()
		slave.Moveto(marker, 50, utility.Randomint(-50, 50), 0, false)
	endif
EndFunction

ObjectReference Property RiftenCellMarker Auto
ObjectReference Property MarkathCellMarker Auto
ObjectReference Property SolitudeCellMarker Auto
ObjectReference Property WhiterunCellMarker Auto
ObjectReference Property WindhelmCellMarker Auto

ObjectReference[] Property HunterCellMarker Auto

PHHSHStorageFunctions Property PHSF Auto
PHHSHMigrate Property MigrateFunctions Auto

bool Property ShowAll Auto Hidden
ReferenceAlias Property DisplayedCellRef Auto Hidden
