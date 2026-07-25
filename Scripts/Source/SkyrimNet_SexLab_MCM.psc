Scriptname SkyrimNet_SexLab_MCM extends SKI_ConfigBase

SkyrimNet_SexLab_Main Property main Auto  
SkyrimNet_SexLab_Stages Property stages Auto 
SkyrimNet_SexLab_Scene_Manager Property manager Auto 
SkyrimNet_SexLab_Actions Property actions Auto 
SkyrimNet_SexLab_Menu Property menu Auto ; New connection to the Menu script

int rape_toggle
GlobalVariable Property sexlab_public_sex_accepted Auto

; Whether to uses the sexlab or ostimnet options in the menu.
; sexlab = 0
; ostimnet = 1
GlobalVariable Property skyrimnet_sexlab_ostim_player Auto
int Property sexlab_ostim_player
    int Function Get()
        return skyrimnet_sexlab_ostim_player.GetValueInt()
    EndFunction 
    Function Set(int value)
        skyrimnet_sexlab_ostim_player.SetValue(value)
    EndFunction 
EndProperty

; Hides the hermaphrodite from prompt 
; 0 - false
; 1 - true
GlobalVariable Property skyrimnet_sexlab_hide_hermaphrodites Auto

; ------------------------
; Pages 
; ------------------------

String page_options = "options"
String page_actors = "undressed Actors"

bool hot_key_toggle = False 
int sex_edit_key = 43 ; 26

bool clear_JSON = False

; OstimNet Support 
int ostimnet_player_menu = -1
int ostimnet_nonplayer_menu = -1
int ostimnet_affection_menu = -1

String[] Property sexlab_ostim_options Auto 
int Property sexlab_ostim_player_menu Auto  ; menu id 

; UDNG Support 
bool Property udng_found = false Auto
     
; Formating 
string newline = ""

Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_MCM", func, msg)
    if notification
        Debug.Notification(logged)
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

    if Game.GetModByName("SkyrimNetUDNG.esp")  != 255
        udng_found = True
    else 
        udng_found = False 
    endif 

    Trace("Setup", "complete")
EndFunction 

Bool Function Setup_CheckLinks()
    Bool links_ok = true

    if main == None
        main = (self as Quest) as SkyrimNet_SexLab_Main
        if main == None
            links_ok = false
        endif
    endif

    if stages == None
        stages = (self as Quest) as SkyrimNet_SexLab_Stages
        if stages == None
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

;-----------------------------------------------------------------
; Create Pages 
;-----------------------------------------------------------------

Event OnPageReset(string page)
    PageOptions()
EndEvent 

Function PageOptions() 
    SetCursorFillMode(LEFT_TO_RIGHT)
    SetCursorPosition(0)
    AddHeaderOption("Prompt Options")
    SetCursorPosition(2)

    AddToggleOptionST("HideHermaphroditesToggle","Hide hermaphrodite from prompt",skyrimNet_sexlab_hide_hermaphrodites.GetValue() == 1.0)
    AddToggleOptionST("PublicSexAcceptedToggle","Public sex accepted",sexlab_public_sex_accepted.GetValue() == 1.0)
    AddToggleOptionST("VirginBloodEnabled","Enable virgin blood message.",main.virgin_blood_enabled)
    
    SetCursorPosition(6)
    AddHeaderOption("Rape Options")
    SetCursorPosition(8)
    AddToggleOptionST("RapeAllowedToggle","Add rape actions (must toggle/save/reload)",main.rape_allowed)

    SetCursorPosition(10)
    AddHeaderOption("Tag Edit")
    SetCursorPosition(12)
    AddToggleOptionST("SexEditTagsPlayer","Show Dialogs for player actions",main.sex_edit_tags_player)
    AddToggleOptionST("SexEditTagsNonPlayer","Show Dialogs for non-player actions",main.sex_edit_tags_nonplayer)

    AddHeaderOption("Sex Description Editor")
    SetCursorPosition(16)
    AddToggleOptionST("HotKeyToggle","Enable the Start Sex / Edit Stage hot key",hot_key_toggle)
    AddKeyMapOptionST("SexEditKeySet", "Start Sex / Edit Stage Description", sex_edit_key)
    AddToggleOptionST("SexEdithelpToggle","Hide Edit Stage Description Help",stages.hide_help)
    
    SetCursorPosition(18)
    AddHeaderOption("Direction Narration Blocking")
    AddHeaderOption("")
    AddSliderOptionST("NarrationCoolOff", "Narration cooldown", main.direct_narration_cool_off)
    AddSliderOptionST("NarrationMaxDistance", "Narration max distance", main.direct_narration_max_distance)

    if hot_key_toggle 
        RegisterForKey(sex_edit_key)
    endif 

    if main.ostimnet_found 
        int value = sexlab_ostim_player
        String label = sexlab_ostim_options[value]
        Trace("PageOptions"," index: "+value+" label: "+label) 
        AddHeaderOption("OstimNet Integration")
        AddHeaderOption("")
        ostimnet_player_menu = AddMenuOption("sex framework:", label)
    endif 
EndFunction 

;-----------------------------------------------------------------
; Prompt Toggles 
;-----------------------------------------------------------------
State PublicSexAcceptedToggle
    Event OnSelectST()
        Bool public_bool = False
        if sexlab_public_sex_accepted.GetValue() == 1.0
            public_bool = False
            sexlab_public_sex_accepted.SetValue(0.0)
        else
            public_bool = True
            sexlab_public_sex_accepted.SetValue(1.0)
        endif 
        SetToggleOptionValueST(public_bool)
        Trace("PublicSexAcceptedToggle","sexlab_public: "+sexlab_public_sex_accepted.GetValue())
    EndEvent
    Event OnHighlightST()
        SetInfoText("Makes public sex a socially accepted intent..")
    EndEvent
EndState

State HideHermaphroditesToggle 
    Event OnSelectST()
        Bool public_bool = False
        if skyrimnet_sexlab_hide_hermaphrodites.GetValue() == 1.0
            public_bool = False
            skyrimnet_sexlab_hide_hermaphrodites.SetValue(0.0)
        else
            public_bool = True
            skyrimnet_sexlab_hide_hermaphrodites.SetValue(1.0)
        endif 
        SetToggleOptionValueST(public_bool)
        bool hide = skyrimnet_sexlab_hide_hermaphrodites.GetValue() == 1.0
        Trace("HideHermaphroditesToggle","hide_hermaphrodites: "+hide)
    EndEvent
    Event OnHighlightST()
        SetInfoText("Hides the hermaphrodite labels the prompt.")
    EndEvent
EndState

;-----------------------------------------------------------------
; Set Toggles 
;-----------------------------------------------------------------
State RapeAllowedToggle
    Event OnSelectST()
        main.rape_allowed = !main.rape_allowed
        SetToggleOptionValueST(main.rape_allowed)
    EndEvent
    Event OnHighlightST()
        SetInfoText("Adds/Removes the NPC rape Actions. Request you save and reload.")
    EndEvent
EndState

State SexEditTagsPlayer
    Event OnSelectST()
        main.sex_edit_tags_player = !main.sex_edit_tags_player
        SetToggleOptionValueST(main.sex_edit_tags_player)
    EndEvent
    Event OnHighlightST()
        SetInfoText("Opens dialogs for events that include the player.")
    EndEvent
EndState

State SexEditTagsNonPlayer
    Event OnSelectST()
        main.sex_edit_tags_nonplayer = !main.sex_edit_tags_nonplayer
        SetToggleOptionValueST(main.sex_edit_tags_nonplayer)
    EndEvent
    Event OnHighlightST()
        SetInfoText("Opens dialogs for events that do not include the player.")
    EndEvent
EndState

State VirginBloodEnabled
    Event OnSelectST()
        main.virgin_blood_enabled = !main.virgin_blood_enabled
        SetToggleOptionValueST(main.virgin_blood_enabled)
    EndEvent
    Event OnHighlightST()
        SetInfoText("Add virgin blood to the first time pussy or anal sex.")
    EndEvent
EndState

; --------------------------------------------
; Hot Keys 
; --------------------------------------------

State HotKeyToggle
    Event OnSelectST()
        hot_key_toggle = !hot_key_toggle
        SetToggleOptionValueST(hot_key_toggle)
        if !hot_key_toggle
            UnregisterForKey(sex_edit_key)
        else
            RegisterForKey(sex_edit_key)
        endif
        ForcePageReset()
    EndEvent
    Event OnHighlightST()
        SetInfoText("Enables the Sex Edit Hotkey."+newline)
    EndEvent
EndState

State SexEditKeySet
    Event OnKeyMapChangeST(int keyCode, string conflictControl, string conflictName)
        Trace("SexEditKeySet","keyCode: "+keyCode+" conflictControl: "+conflictControl+" conflictName: "+conflictName)
        bool continue = True
        if conflictControl != "" 
            String msg = None 
            if (conflictName != "")
                msg = "This key is already mapped to:'"+ conflictControl+"'"+ newline\
                    +"(" + conflictName + ")"+newline+newline\
                    +"Are you sure you want to continue?"
            else
                msg = "This key is already mapped to:'" + conflictControl + "'"+newline+"Are you sure you want to continue?"
            endIf

            continue = ShowMessage(msg, true, "$Yes", "$No")
        endif 
        if continue 
            UnregisterForKey(sex_edit_key)
            sex_edit_key = keyCode
            RegisterForKey(sex_edit_key)
            SetKeymapOptionValueST(sex_edit_key)
        endif 
    EndEvent
 
    Event OnHighlightST()
        SetInfoText( \
            "For an actor in the crosshair and not in a sex animation, it will allow you to start a sex animation."+newline \
          + "For an actor in the crosshair and in a sex animation, it will open a stage description editor for that animation."+newline \
          + "Without any actor in the crosshair, it will allow you to start sex between a near by set of eligible actors.")
    EndEvent
EndState

State SexEditHelpToggle
    Event OnSelectST()
        stages.hide_help = !stages.hide_help
        SetToggleOptionValueST(stages.hide_help)
        ForcePageReset()
    EndEvent
    Event OnHighlightST()
        SetInfoText("Hides the help dialogue that appears if no stage description is found."+newline)
    EndEvent
EndState

;-----------------------------------------------------------------
; Direct Narration 
;-----------------------------------------------------------------

State NarrationCoolOff
    Event OnSliderOpenST()
        SetSliderDialogStartValue(main.direct_narration_cool_off)
        SetSliderDialogDefaultValue(50)
        SetSliderDialogRange(1, 120)
        SetSliderDialogInterval(1)
    EndEvent
    Event OnSliderAcceptST(float value) 
        main.direct_narration_cool_off = value 
        SetSliderDialogStartValue(main.direct_narration_cool_off)
        ForcePageReset()
    EndEvent
    Event OnHighlightST()
        SetInfoText("Minimum number of seconds since last audio ended before next optional Direct Narration."+newline)
    EndEvent
EndState

State NarrationMaxDistance
    Event OnSliderOpenST()
        SetSliderDialogStartValue(main.direct_narration_max_distance)
        SetSliderDialogDefaultValue(main.direct_narration_max_distance_default)
        SetSliderDialogRange(5, 100)
        SetSliderDialogInterval(1)
    EndEvent
    Event OnSliderAcceptST(float value) 
        main.direct_narration_max_distance = value 
        SetSliderDialogStartValue(main.direct_narration_max_distance)
        ForcePageReset()
    EndEvent
    Event OnHighlightST()
        SetInfoText("Maximum distance in meters that could generate a new direct narration."+newline)
    EndEvent
EndState

;-----------------------------------------------------------------
; OstimNet Integration
;-----------------------------------------------------------------
Event OnOptionMenuOpen(int menu_id)
    Trace("OnOptionMenuOpen","menu_id: "+menu_id+" options: "+sexlab_ostim_options)
    if menu_id == ostimnet_player_menu
        SetMenuDialogOptions(sexlab_ostim_options)
        SetMenuDialogStartIndex(sexlab_ostim_player)
    endif
    SetMenuDialogDefaultIndex(0)
endEvent

event OnOptionMenuAccept(int menu_id, int index)
    if menu_id == ostimnet_player_menu
        sexlab_ostim_player = index 
        String label = sexlab_ostim_options[index]
        Trace("OnOptionMenuAccept"," menu_id: "+menu_id+" sexlab_ostim_player: "+index+" label: "+label)
        SetMenuOptionValue(menu_id, label)
    endif 
endEvent

; --------------------------------------------
; Handles OnKeyDown 
; --------------------------------------------

Event OnKeyDown(int key_code)
    Trace("OnKeyDown", "key_code: "+key_code)
    if UI.IsTextInputEnabled()
        return 
    endif 
    if sex_edit_key == key_code
        if !menu
            Trace("OnKeyDown", "menu is None; hotkey ignored", true)
            return
        endif
        menu.ProcessHotkey(key_code)
    endif 
EndEvent