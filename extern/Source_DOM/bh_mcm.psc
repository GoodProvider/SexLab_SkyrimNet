Scriptname bh_mcm extends SKI_ConfigBase
Import Utility

BHguestsMoveIn Property BHCore Auto

GlobalVariable Property aa_andragon_guardpos_1 auto
GlobalVariable Property aa_andragon_guardpos_2 auto
GlobalVariable Property aa_andragon_guardpos_3 auto
GlobalVariable Property aa_andragon_guardpos_4 auto

Int enableGuard1_OID 
Int enableGuard2_OID 
Int enableGuard3_OID 
Int enableGuard4_OID 

bool Property enableGuard1 = true Auto Hidden
bool Property enableGuard2 = true Auto Hidden
bool Property enableGuard3 = true Auto Hidden
bool Property enableGuard4 = true Auto Hidden

string[] pageNames

; Initialize
Event OnGameReload()
	parent.OnGameReload()
EndEvent

Event OnConfigOpen()
	pageNames = new String[2]
	pageNames[0] = "Options"
	pageNames[1] = "Default guests"
EndEvent

event OnPageReset(string page)
	if (page == "")
		LoadCustomContent("UB by Andragon.dds", 186, 33)
		return
	else
		UnloadCustomContent()
	endif	
	if PageNames.length == 0
		OnConfigOpen()
		OnPageReset(page)
	endif

	if page == pageNames[0]
		UpdateOptionsPage()
	elseif page == pageNames[1]
		UpdateGuestsPage()
	endif
EndEvent

Function UpdateOptionsPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	AddTextOption("Underground Bathhouse by Andragon", "")
EndFunction

Function UpdateGuestsPage()
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	enableGuard1_OID =  AddToggleOption("Enable entrance guard", enableGuard1)
	enableGuard2_OID =  AddToggleOption("Enable entrance backup guard", enableGuard2)
	enableGuard3_OID =  AddToggleOption("Enable bedroom guard", enableGuard3)
	enableGuard4_OID =  AddToggleOption("Enable patrol guard", enableGuard4)
EndFunction

Function DoGuestsPage(Int option)
	if (option == enableGuard1_OID)
		enableGuard1 = !enableGuard1_OID
		SetToggleOptionValue(enableGuard1_OID, enableGuard1_OID)
		if enableGuard1
			if aa_andragon_guardpos_1.GetValueInt() == 0
				BHCore.BHGuard01default.enable()
			endif
		else
			BHCore.BHGuard01default.disable()
		endif
	elseif (option == enableGuard2_OID)
		enableGuard2 = !enableGuard2_OID
		SetToggleOptionValue(enableGuard2_OID, enableGuard2_OID)
		if enableGuard2
			if aa_andragon_guardpos_2.GetValueInt() == 0
				BHCore.BHGuard02default.enable()
			endif
		else
			BHCore.BHGuard02default.disable()
		endif
	elseif (option == enableGuard3_OID)
		enableGuard3 = !enableGuard3_OID
		SetToggleOptionValue(enableGuard3_OID, enableGuard3_OID)
		if enableGuard3
			if aa_andragon_guardpos_3.GetValueInt() == 0
				BHCore.BHGuard03default.enable()
			endif
		else
			BHCore.BHGuard03default.disable()
		endif
	elseif (option == enableGuard4_OID)
		enableGuard4 = !enableGuard4_OID
		SetToggleOptionValue(enableGuard4_OID, enableGuard4_OID)
		if enableGuard4
			if aa_andragon_guardpos_4.GetValueInt() == 0
				BHCore.BHGuard04default.enable()
			endif
		else
			BHCore.BHGuard04default.disable()
		endif
	endif
EndFunction
