 Scriptname DOM_ExtraMCM extends SKI_ConfigBase
Import Utility
Import DOM_Util

DOM_Core Property DOMCore Auto
DOM_Extra Property DOMExtra Auto
DOM_SlaveManager Property DOM02Extra Auto
Actor Property PlayerRef Auto

; Toggles and text
Int actorTitle_OID
Int actorName_OID
Int actorWrite_OID
Int actorRead_OID
Int actorPrevious_OID
Int actorGender_OID
Int actionName_OID
Int actionType_OID
Int actorPose_OID
Int actorStrugglePose_OID
Int actorSummon_OID
Int actorResetDiary_OID
Int actorRelease_OID
Int actorFixme_OID
Int actorFixTats_OID
Int actorSummonBag_OID

; Hot keys
Int HKCapture_OID
Int HKModifierDefault_OID

Actor Property player Auto
string[] pageNames

; Initialize
Event OnGameReload()
	parent.OnGameReload()
	DOMExtra.OnGameReload()
EndEvent

Event OnConfigOpen()
	int slaveCount = DOM02Extra.actorCounter
	if slaveCount > 86
		pageNames = new String[2]
	elseif slaveCount > 43
		pageNames = new String[3]
	else
		pageNames = new String[4]
	endif
	pageNames[0] = "Hotkeys"
	pageNames[1] = "Slaves 1-43"
	if slaveCount > 43
		pageNames[2] = "Slaves 44-86"
	endif
	if slaveCount > 86
		pageNames[3] = "Slaves 87-128"
	endif
	Pages = pageNames
EndEvent

event OnPageReset(string page)
	if (page == "")
		LoadCustomContent("DiaryOfMine.dds", 186, 33)
		return
	else
		UnloadCustomContent()
	endif	
	if PageNames.length == 0
		OnConfigOpen()
		OnPageReset(page)
	endif

	if page == pageNames[0]
		UpdateHotkeysPage()
	elseif page == pageNames[1]
		UpdateSlaveRosterPage1()
	elseif PageNames.length > 2 && page == pageNames[2]
		UpdateSlaveRosterPage2()
	elseif PageNames.length > 3 && page == pageNames[3]
		UpdateSlaveRosterPage3()
	endif
EndEvent

Function UpdateHotkeysPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("Modifier key")
	HKModifierDefault_OID = AddKeyMapOption("Modifier key",   DOMExtra.modifierKeyDefault) 

	AddHeaderOption("Hotkeys")
	HKCapture_OID    = AddKeyMapOption("Capture key", DOMExtra.captureKey)
EndFunction


Event OnOptionKeyMapChange(Int Option, Int keyCode, String conflictControl, String conflictName)
	bool Continue = True
	If (keyCode == 1)
		keyCode = 0
		conflictControl = ""
	endif
	If keyCode == 0
		keyCode = -1
		conflictControl = ""
	endif
	If (conflictControl != "")
		String msg
		If conflictName != ""
			msg = "$This key is already mapped to:\n'{" + conflictControl + "}'\n({" + conflictName + "})\n\nAre you sure you want to continue?"
		Else
			msg = "$This key is already mapped to:\n'{" + conflictControl + "}'\n\nAre you sure you want to continue?"
		endif
		Continue = ShowMessage(msg, True, "$Yes", "$No")
	endif		
	If !Continue
		return
	endif
	if Option == HKCapture_OID
		DOMExtra.captureKey = keyCode
	elseif Option == HKModifierDefault_OID
		DOMExtra.modifierKeyDefault = keyCode
	endif
	SetKeymapOptionValue(Option, keyCode)
	DOMExtra.refreshKeys()
EndEvent

string sort_criteria = ""
Int[] slave_OID
Int currentActor_OID = -1
Function UpdateSlaveRosterPage1()
	SetCursorFillMode(TOP_TO_BOTTOM)
	int slaveCount = DOM02Extra.actorCounter
	if slave_OID.length != 43
		slave_OID = new Int[43]
	endif
	int slaveList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("First 43 slaves")
	else
		AddHeaderOption("First 43 slaves in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i < slaveCount) && (i < 43) && (slaveList < slave_OID.length)
		DOM_Actor sl_alias = DOM02Extra.GetActorByIndex(i)
		slave_OID[i] = AddTextOption(i+1 + ": " + sl_alias.GetName(), sl_alias.GetTitle())
		if currentActor_OID == slave_OID[i]
			selected_info = i
		endif
		;LogTrace("UpdateSlaveRosterPage: OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
		slaveList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateActorInfoPage(selected_info,true)
	endif
EndFunction

Function UpdateSlaveRosterPage2()
	SetCursorFillMode(TOP_TO_BOTTOM)
	int slaveCount = DOM02Extra.actorCounter
	if slave_OID.length != 43
		slave_OID = new Int[43]
	endif
	int slaveList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("Slaves 44 to 86")
	else
		AddHeaderOption("Slaves 44 to 86 in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i+43 < slaveCount) && (i < 43) && (slaveList < slave_OID.length)
		DOM_Actor sl_alias = DOM02Extra.GetActorByIndex(i+43)
		slave_OID[i] = AddTextOption(i+1 + ": " + sl_alias.GetName(), sl_alias.GetTitle())
		if currentActor_OID == slave_OID[i]
			selected_info = i+43
		endif
		;LogTrace("UpdateSlaveRosterPage: OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
		slaveList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateActorInfoPage(selected_info,true)
	endif
EndFunction

Function UpdateSlaveRosterPage3()
	SetCursorFillMode(TOP_TO_BOTTOM)
	int slaveCount = DOM02Extra.actorCounter
	if slave_OID.length != 43
		slave_OID = new Int[43]
	endif
	int slaveList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("Slaves 87 to 128")
	else
		AddHeaderOption("Slaves 87 to 128 in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i+86 < slaveCount) && (i < 43) && (slaveList < slave_OID.length)
		DOM_Actor sl_alias = DOM02Extra.GetActorByIndex(i+86)
		slave_OID[i] = AddTextOption(i+1 + ": " + sl_alias.GetName(), sl_alias.GetTitle())
		if currentActor_OID == slave_OID[i]
			selected_info = i+86
		endif
		;LogTrace("UpdateSlaveRosterPage: OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
		slaveList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateActorInfoPage(selected_info,true)
	endif
EndFunction

Function UpdateActorInfoPage(int idx, bool is_slave)
	displayedActor = DOM02Extra.GetActorByIndex(idx)
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
	actorPrevious_OID = AddInputOption("Before: ",displayedActor.GetPreviousOccupation())
	string str_gender = "other"
	if displayedActor.actorSex == 0 || displayedActor.actorSex == 2
		str_gender = "male"
	elseif displayedActor.actorSex == 1 || displayedActor.actorSex == 3
		str_gender = "female"
	elseif displayedActor.actorSex == 4
		str_gender = "treat as male"
	elseif displayedActor.actorSex == 5
		str_gender = "treat as female"
	endif
	actorGender_OID = AddInputOption("$Gender: ", str_gender)
	if is_slave
		string status = akMind.GetTrainingStatusName()+" slave"
		AddTextOption("$Status: ", status, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Status: ", "free person", OPTION_FLAG_DISABLED)
	endif
	AddTextOption("$Mood: ", akMind.mood, OPTION_FLAG_DISABLED)
	AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle(), OPTION_FLAG_DISABLED)

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
	actorSummon_OID = AddTextOption("$Summon to player", "$Click")
	if displayedActor.the_bag_iam_in != None
		actorSummonBag_OID = AddTextOption("$Summon burlap sack", "$Click")
	endif
	actorResetDiary_OID = AddTextOption("Reset diary text", "$Click")
	actorFixTats_OID = AddTextOption("$Fix SlaveTats", "$Click")
	;if displayedActor.akRef.Is3DLoaded()
		actorFixme_OID = AddTextOption("$Fix unresponsive or invisible actor", "$Click")
	;endif
	actorRelease_OID = AddTextOption("$Release actor from DOM", "$Click")

	AddTextOption("$Location: ", GetLocationString(akRef), OPTION_FLAG_DISABLED)
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
	AddTextOption("Persuader skill: ", akMind.skill_persuader, OPTION_FLAG_DISABLED)
	AddTextOption("Depraver skill: ", akMind.skill_depraver, OPTION_FLAG_DISABLED)
	AddTextOption("Predator skill: ", akMind.skill_predator, OPTION_FLAG_DISABLED)
	AddTextOption("Slaver skill: ", akMind.skill_slaver, OPTION_FLAG_DISABLED)
	AddTextOption("Deceiver skill: ", akMind.skill_deceiver, OPTION_FLAG_DISABLED)
	AddTextOption("Dirtiness: ", displayedActor.dirty_level, OPTION_FLAG_DISABLED)
	AddTextOption("Drunk level: ", akMind.GetDrunkLevel(), OPTION_FLAG_DISABLED)
	actorWrite_OID = AddTextOption("Write JSON file", "$Click")
	actorRead_OID = AddTextOption("Read JSON file", "$Click")
EndFunction

DOM_Actor displayedActor = None
Function DoActorRosterPage(Int option)
	;LogTrace("DoActorRosterPage: option="+option)
	If displayedActor != None
		If (option == actorSummon_OID)
			if displayedActor != None && displayedActor.akRef != None
				displayedActor.akRef.moveTo(PlayerRef)
			endif
			ForcePageReset()
			return
		ElseIf (option == actorSummonBag_OID)
			if displayedActor != None && displayedActor.the_bag_iam_in != None
				displayedActor.the_bag_iam_in.moveTo(PlayerRef,afZOffset = 10.0)
			endif
			ForcePageReset()
			return
		ElseIf (option == actorResetDiary_OID)
			if displayedActor != None && displayedActor.akRef != None
				displayedActor.mind.ResetTextMemories()
			endif
			ForcePageReset()
			return
		ElseIf (option == actorRelease_OID)
			if displayedActor != None && displayedActor.akRef != None
				DOMCore.ReleaseActor(displayedActor.akRef)
			endif
			ForcePageReset()
			return
		ElseIf (option == actorFixTats_OID)
			if displayedActor != None && displayedActor.akRef != None ; && displayedActor.akRef.Is3DLoaded()
				displayedActor.ResetTats()
				SlaveTats.synchronize_tattoos(displayedActor.akRef)
			endif
			ForcePageReset()
			return
		ElseIf (option == actorFixme_OID)
			if displayedActor != None && displayedActor.akRef != None ; && displayedActor.akRef.Is3DLoaded()
				displayedActor.SpecialReset()
			endif
			ForcePageReset()
			return
		ElseIf (option == actorRead_OID)
			If displayedActor == None
				return
			endif
			SetTextOptionValue(actorRead_OID, "Importing values ", false)
			If ShowMessage("Import personality values from JSON file?")
				DOMCore.DOMGenerator.ReadJSON(displayedActor)
				;SetTextOptionValue(actorRead_OID, "$Done! ", false)
			Else
				;SetTextOptionValue(actorRead_OID, "", false)
			endif
			ForcePageReset()
			return
		ElseIf (option == actorWrite_OID)
			If displayedActor == None
				LogTrace("WRITE JSON ERROR: No selected actor")
				return
			endif
			LogTrace("WRITE JSON selected actor="+displayedActor.getName())
			SetTextOptionValue(actorWrite_OID, "Exporting values ", false)
			If ShowMessage("Export personality values to JSON file?")
				DOMCore.DOMGenerator.WriteJSON(displayedActor)
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

float Function getAnglePlayer(Actor akRef)
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
	elseIf angle <= 67.5
		return "to your northeast."
	elseIf angle <= 112.5
		return "to your east."
	elseIf angle <= 157.5
		return "to your southeast"
	elseIf angle <= 202.5
		return "to your south."
	elseIf angle <= 247.5
		return "to your southwest."
	elseIf angle <= 292.5
		return "to your west."
	elseIf angle <= 337.5
		return "to your northwest."
	elseIf angle <= 360.0
		return "to your north."
	endif
	return "in an unknown direction."
EndFunction

string Function GetDistanceString(Actor akRef)
	string units = " metres"
	float distance = akRef.GetDistance(PlayerRef) * 0.01428 ; 1000.0 units = 14.28 meters
	if distance > 1000.0
		distance = distance / 1000.0
		units = " kilometres"
	endif
	return (distance as int) + units
EndFunction

string Function GetLocationString(Actor akRef)
	string locStr
	Cell parent_cell = akRef.GetParentCell()
	If parent_cell != None
		locStr = parent_cell.GetName()
	else
		Location current_loc = akRef.GetCurrentLocation()
		if current_loc != None
			locStr = current_loc.GetName()
		endif		
	endif
	If locStr != ""
		return locStr
	endif
	
	string dirStr = GetDirectionString(akRef)
	string farStr = GetDistanceString(akRef)
	return farStr+" "+dirStr
EndFunction

Function ResetAllMemories()
	int n = DOM02Extra.actorCounter
	int idx = 0
	while idx < n
		DOM_Actor akActor = DOM02Extra.GetActorByIndex(idx)
		if akActor != None
			akActor.mind.ResetAllMemories()
		endif
		idx += 1
	endWhile
EndFunction


Function ResetAllDiaries()
	int n = DOM02Extra.actorCounter
	int idx = 0
	while idx < n
		DOM_Actor akActor = DOM02Extra.GetActorByIndex(idx)
		if akActor != None
			akActor.mind.ResetTextMemories()
		endif
		idx += 1
	endWhile
EndFunction

Function LogTrace(string msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_MCM: "+msg)
	endif
EndFunction

