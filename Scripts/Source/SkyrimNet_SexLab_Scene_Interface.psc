Scriptname SkyrimNet_SexLab_Scene_Interface extends Quest

Import SkyrimNet_SexLab_Utilities

SkyrimNet_SexLab_Main Property main Auto
SkyrimNet_SexLab_Stages Property stages Auto
SkyrimNet_SexLab_Scene_Manager Property manager Auto 

; --------------------------------------------
; Scene id == index in sl_scenes
; --------------------------------------------
int Property sid = 0 Auto 

; --------------------------------------------
; Style
; --------------------------------------------
String Property STYLE_FORCEFULLY = "forcefully" AutoREadOnly
String Property STYLE_NORMALLY = "normally" AutoREadOnly
String Property STYLE_GENTLY = "gently" AutoREadOnly
String Property STYLE_DEFAULT = "normally" AutoREadOnly
String Property style Auto

; --------------------------------------------
; Speaking Style
; --------------------------------------------
String Property speaking_modifiers_DEFAULT = "_pleasure_" AUTOReadOnly

; --------------------------------------------
; Number Victims
; --------------------------------------------
int Property num_victims = 0 Auto 

; --------------------------------------------
; Names
; --------------------------------------------
String Property actor_names = "" Auto
String Property actor_names_json = ""Auto

String Property victim_names = ""Auto
String Property victim_names_json = ""Auto

String Property assailant_names = "" Auto

String Property creature_descriptions = "" Auto
String Property hermaphrodiate_names = "" Auto
String Property strapon_names = "" Auto


; --------------------------------------------
; Status 
; STATUS_* must be AutoReadOnly — Auto lets saves corrupt the constants so
; IsActive() (status != STATUS_INACTIVE) stays true forever and the scene pool
; can never be reclaimed.
; --------------------------------------------
String Property STATUS_INACTIVE = "INACTIVE" AutoReadOnly
String Property STATUS_SETUP = "SETUP" AutoReadOnly
String Property STATUS_ACTIVE = "ACTIVE" AutoReadOnly
String Property status = "INACTIVE" Auto

; --------------------------------------------
; Has Player 
; --------------------------------------------
bool property has_player = False Auto
bool property player_is_victim = False Auto

; --------------------------------------------
; intent 
; --------------------------------------------
String Property intent = "sexual_activities" Auto 
String Property INTENT_DEFAULT = "sexual activities" Auto


Function Trace(String func, String msg="", Bool notification=False)
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Scene_Interface", func, "sid:"+sid+" "+msg)
    if notification
        Debug.Notification(logged)
    endif 
EndFunction

String Function GetString() 
    return " actors: ["+actor_names+"]"\
          +" victims: ["+victim_names+"]"\
          +" assailants: ["+assailant_names+"]"\
          +" style:"+style
EndFunction 


; _is_generic is used by Scene (fallback pool flag). Creators ignore it (always false).
Function Initialize(int _sid, SkyrimNet_SexLab_Scene_Manager _manager, bool _is_generic = false) 
    sid = _sid
    manager = _manager 
    main = manager.main
    stages = manager.stages 

    intent = INTENT_DEFAULT
    ; Always reclaim pool slots on manager Setup / load — status is Auto and survives saves.
    status = STATUS_INACTIVE
EndFunction 

; Reset all interface scene state except sid (pool identity).
; Subclasses may preserve additional permanent flags (e.g. Scene.is_generic).
Function Release()
    style = STYLE_NORMALLY
    status = STATUS_INACTIVE
    intent = INTENT_DEFAULT
    has_player = False
    player_is_victim = False
    num_victims = 0
    actor_names = ""
    actor_names_json = ""
    victim_names = ""
    victim_names_json = ""
    assailant_names = ""
    creature_descriptions = ""
    hermaphrodiate_names = ""
    strapon_names = ""
EndFunction

; ------------------------------------------------------
; Set Style 
; ------------------------------------------------------
Function SetStyle(String _style) 
    if _style == "gentle" || _style == "gently"
        style = STYLE_GENTLY   
    elseif _style == "forceful" || _style == "forcefully"
        style = STYLE_FORCEFULLY
    else 
        style = STYLE_NORMALLY
    endif
EndFunction 
String Function GetStyle() 
    return style
EndFunction

bool Function IsActive() 
    return status != STATUS_INACTIVE 
EndFunction

; Selects the style of sex 
; 0 forcefully 
; 1 normally 
; 2 gently 
Function SetStyleDialog()
    Trace("SetStyleDialog","-- start style: "+style)
    String[] buttons = new String[3] 
    if num_victims > 0 
        buttons[0] = "Violent "+intent
        buttons[1] = intent
        buttons[2] = "Gentle "+intent
    else
        buttons[0] = "Forceful "+intent
        buttons[1] = intent
        buttons[2] = "Gentle "+intent
    endif 
    int button = SkyMessage.ShowArray("Change style to:", buttons, getIndex = true) as int 
    if button == 0 
        style = STYLE_FORCEFULLY
    elseif button == 2
        style = STYLE_GENTLY
    else 
        style = STYLE_NORMALLY
    endif 
    Trace("SetStyleDialog","-- end: "+style)
EndFunction