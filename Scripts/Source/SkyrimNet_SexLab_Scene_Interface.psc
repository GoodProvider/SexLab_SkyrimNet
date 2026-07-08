Scriptname SkyrimNet_SexLab_Scene_Interface extends Quest

Import SkyrimNet_SexLab_Utilities

SkyrimNet_SexLab_Main Property main Auto
SkyrimNet_SexLab_Stages Property stages Auto
SkyrimNet_SexLab_Scene_Manager Property manager Auto 

; --------------------------------------------
; Scene id == index in scenes
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
String Property speaking_modifiers_DEFAULT = "pleasure" AUTOReadOnly

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
; Since returning a None array cause an error
; we set the empty
; --------------------------------------------
sslBaseAnimation[] Property empty = None Auto

; --------------------------------------------
; Status 
; --------------------------------------------
String Property STATUS_INACTIVE = "INACTIVE" Auto
String Property STATUS_SETUP = "SETUP" Auto
String Property STATUS_ACTIVE = "ACTIVE" Auto
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
    msg = "[SkyrimNet_SexLab_Scene_Interface."+func+"] sid:"+sid+" "+msg
    Debug.Trace(msg) 
    if notification
        Debug.Notification(msg)
    endif 
EndFunction

String Function GetString() 
    return " actors: ["+actor_names+"]"\
          +" victims: ["+victim_names+"]"\
          +" assailants: ["+assailant_names+"]"\
          +" style:"+style
EndFunction 


Function Initialize(int _sid, SkyrimNet_SexLab_Scene_Manager _manager) 
    sid = _sid
    manager = _manager 
    main = manager.main
    stages = manager.stages 
    if !empty 
        empty = new sslBaseAnimation[1]
        empty[0] = None 
    endif 
    intent = INTENT_DEFAULT
EndFunction 

Function Release()
    style = STYLE_NORMALLY
    status = STATUS_INACTIVE 
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
int Function SetStyleDialog()
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
EndFunction