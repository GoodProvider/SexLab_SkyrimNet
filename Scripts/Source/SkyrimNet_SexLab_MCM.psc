Scriptname SkyrimNet_SexLab_MCM extends SKI_ConfigBase

SkyrimNet_SexLab_Main Property main Auto
SkyrimNet_SexLab_AnimDb Property animdb Auto
SkyrimNet_SexLab_Scene_Manager Property manager Auto
SkyrimNet_SexLab_Actions Property actions Auto
SkyrimNet_SexLab_Menu Property menu Auto

; Kept for Menu.psc framework labels / global wrapper (C++ syncs control store → global).
GlobalVariable Property skyrimnet_sexlab_ostim_player Auto
int Property sexlab_ostim_player
    int Function Get()
        return skyrimnet_sexlab_ostim_player.GetValueInt()
    EndFunction
    Function Set(int value)
        skyrimnet_sexlab_ostim_player.SetValue(value)
    EndFunction
EndProperty

String page_options = "options"
String[] Property sexlab_ostim_options Auto
bool Property udng_found = false Auto

; DX scancode hotkey (SkyUI KeyMap). Live override via WebUI_SetHotkey.
bool hot_key_toggle = False
int sex_edit_key = 43 ; backslash \

string newline = ""

Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_MCM", func, msg)
    if notification
        Debug.Notification(msg)
    endif
EndFunction

Function Setup()
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        return
    endif

    if !sexlab_ostim_options
       sexlab_ostim_options = new String[2]
       sexlab_ostim_options[0] = "SexLab"
       sexlab_ostim_options[1] = "Ostim"
    endif

    if Game.GetModByName("SkyrimNetUDNG.esp") != 255
        udng_found = True
    else
        udng_found = False
    endif

    ; Apply after C++ ApplyFromConfig. Only push when MCM enable is on so we do not
    ; wipe a hotkey enabled via the SkyrimNet plugin menu.
    if hot_key_toggle
        SkyrimNet_SexLab_WebUI.WebUI_SetHotkey(sex_edit_key, True)
    endif
    Trace("Setup", "complete hotkey enabled="+hot_key_toggle+" dx="+sex_edit_key)
EndFunction

Bool Function Setup_CheckLinks()
    Bool links_ok = true

    if main == None
        main = (self as Quest) as SkyrimNet_SexLab_Main
        if main == None
            links_ok = false
        endif
    endif

    if animdb == None
        animdb = (self as Quest) as SkyrimNet_SexLab_AnimDb
        if animdb == None
            links_ok = false
        endif
    endif

    if manager == None
        manager = (self as Quest) as SkyrimNet_SexLab_Scene_Manager
        if manager == None
            links_ok = false
        endif
    endif

    if actions == None
        actions = (self as Quest) as SkyrimNet_SexLab_Actions
        if actions == None
            links_ok = false
        endif
    endif

    if menu == None
        menu = (self as Quest) as SkyrimNet_SexLab_Menu
        if menu == None
            links_ok = false
        endif
    endif

    return links_ok
EndFunction

Event OnConfigOpen()
    Pages = new String[1]
    pages[0] = page_options
EndEvent

Event OnPageReset(string page)
    PageOptions()
EndEvent

Function PageOptions()
    SetCursorFillMode(TOP_TO_BOTTOM)
    SetCursorPosition(0)

    AddHeaderOption("Settings location")
    AddTextOption("Use SkyrimNet_SexLab WebUI", "Settings panel")
    AddTextOption("  (main panel pulldown → Settings)", "")
    AddTextOption("Or SkyrimNet plugin interface", "SkyrimNet_SexLab")
    AddTextOption("  (SkyrimNet mod menu)", "")

    AddHeaderOption("Start Sex / Edit Stage hotkey")
    AddToggleOptionST("HotKeyToggle", "Enable hotkey", hot_key_toggle)
    AddKeyMapOptionST("SexEditKeySet", "Hotkey", sex_edit_key)

    AddHeaderOption("Animation database")
    String ts = "never"
    if animdb
        ts = animdb.last_rebuild_timestamp
        if ts == ""
            ts = "never"
        endif
    endif
    AddTextOption("Last rebuild", ts)
    AddTextOptionST("RebuildAnimDb", "Rebuild Animation Database", "CLICK")
EndFunction

State HotKeyToggle
    Event OnSelectST()
        hot_key_toggle = !hot_key_toggle
        SetToggleOptionValueST(hot_key_toggle)
        SkyrimNet_SexLab_WebUI.WebUI_SetHotkey(sex_edit_key, hot_key_toggle)
        ForcePageReset()
    EndEvent
    Event OnHighlightST()
        SetInfoText("Enables the PrismaUI Start Sex / Edit Stage hotkey.")
    EndEvent
EndState

State SexEditKeySet
    Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
        Trace("SexEditKeySet", "keyCode: "+keyCode+" conflictControl: "+conflictControl+" conflictName: "+conflictName)
        bool continue = True
        if conflictControl != ""
            String msg
            if conflictName != ""
                msg = "This key is already mapped to:'"+ conflictControl+"'"+ newline\
                    +"(" + conflictName + ")"+newline+newline\
                    +"Are you sure you want to continue?"
            else
                msg = "This key is already mapped to:'" + conflictControl + "'"+newline+"Are you sure you want to continue?"
            endIf
            continue = ShowMessage(msg, true, "$Yes", "$No")
        endif
        if continue
            sex_edit_key = keyCode
            SkyrimNet_SexLab_WebUI.WebUI_SetHotkey(sex_edit_key, hot_key_toggle)
            SetKeymapOptionValueST(sex_edit_key)
        endif
    EndEvent
    Event OnHighlightST()
        SetInfoText( \
            "Crosshair on actor not in sex: start sex."+newline \
          + "Crosshair on actor in sex: stage description editor."+newline \
          + "No crosshair: start sex among nearby eligible actors.")
    EndEvent
EndState

State RebuildAnimDb
    Event OnSelectST()
        SkyrimNet_SexLab_AnimDb adb = (main as Quest) as SkyrimNet_SexLab_AnimDb
        if adb
            adb.RebuildDatabase()
            ShowMessage("Animation database rebuild started in the background.", false)
        else
            ShowMessage("AnimDb script not found on quest.", false)
        endif
        SetTextOptionValueST("STARTED")
        ForcePageReset()
    EndEvent
    Event OnHighlightST()
        SetInfoText("Force a full rebuild of the AnimationDB from SexLab registered animations.")
    EndEvent
EndState
