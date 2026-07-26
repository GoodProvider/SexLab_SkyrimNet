Scriptname SkyrimNet_SexLab_Decorators


import SkyrimNet_SexLab_Main
import SkyrimNet_SexLab_Stages
import SkyrimNet_SexLab_Utilities
import PO3_SKSEFunctions

Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Decorators", func, msg)
    if notification
        Debug.Notification(logged)
    endif 
EndFunction


;----------------------------------------------------------------------------------------------------
; Decorators 
;----------------------------------------------------------------------------------------------------
Function RegisterDecorators() global
    SkyrimNetApi.RegisterDecorator("sexlab_get_threads", "SkyrimNet_SexLab_Decorators", "Get_Threads")
    SkyrimNetApi.RegisterDecorator("sexlab_get_player_los_distance", "SkyrimNet_SexLab_Decorators", "Player_LOS_Distance")
    SkyrimNetApi.RegisterDecorator("sexlab_outfit_options", "SkyrimNet_SexLab_Decorators", "Outfit_Options")
    SkyrimNetApi.RegisterDecorator("sexlab_intent", "SkyrimNet_SexLab_Decorators", "Intent")
    SkyrimNetApi.RegisterDecorator("sexlab_activities", "SkyrimNet_SexLab_Decorators", "Activities")
    ;SkyrimNetApi.RegisterDecorator("sexlab_nudity", "SkyrimNet_SexLab_Decorators", "Is_Nudity")
    ;SkyrimNetApi.RegisterDecorator("sexlab_speaker_info", "SkyrimNet_SexLab_Decorators", "Speaker_Info")
EndFunction

String Function Get_Threads(Actor speaker) global
    SkyrimNet_SexLab_Scene_Manager manager = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene_Manager
    if manager == None 
        Trace("Get_Threads","manger is None, aborting")
        return "{}" 
    endif 
    String json = manager.GetThreadsJson(speaker) 
    Trace("Get_Threads", "json:"+json)
    return json
EndFunction 

String Function Outfit_Options(Actor speaker) global 
    int obj = JMap.object() 
    String options = "undresses"
    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main
    if main == None
        Trace("Outfit_Options", "ERROR: Failed to get SkyrimNet_SexLab_Main form", True)
    else
        ; Check if the actor has undressed items, they could put on 
        if main.HasStrippedItems(speaker) 
            options = "dresses"
        endif 
        Trace("Outfit_Options",speaker.GetDisplayName()+" has options:"+options)
    endif
    JMap.setStr(obj, "options", options) 
    String json = SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(obj) 
    JValue.release(obj) 
    return json 
EndFunction

String Function Intent(Actor speaker) global 
    SkyrimNet_SexLab_Scene_Manager manager = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene_Manager
    if manager == None 
        Trace("Intent","manager is None, aborting")
        return "{}" 
    endif 

    SkyrimNet_SexLab_Scene sl_scene = manager.GetSceneByActor(speaker) 
    if sl_scene != None 
        int obj = JMap.object()
        JMap.setStr(obj, "intent", sl_scene.intent)
        String json = SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(obj)
        JValue.release(obj)
        return json
    endif 
    return "{}"
EndFunction 

String Function Activities(Actor akActor) global
    SkyrimNet_SexLab_Scene_Manager manager = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene_Manager
    int obj = JMap.object()
    String activity = ""
    if manager != None 
        SkyrimNet_SexLab_Scene sl_scene = manager.GetSceneByActor(akActor)
        if sl_scene != None && sl_scene.GetThread() != None
            activity = sl_scene.GetDescription()
        endif 
    endif 
    JMap.setStr(obj, "activity", activity)
    String json = SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(obj)
    JValue.release(obj)
    return json
EndFunction


String Function Player_LOS_Distance(Actor akActor) global 
    Actor player = Game.GetPlayer() 
    float distance = player.GetDistance(akActor) 
    int los 
    if player.hasLOS(akActor) 
        los = 1
    else 
        los = 0
    endif 

  
    int obj = JMap.object() 
    JMap.setFlt(obj,"distance",distance)
    JMap.setInt(obj,"los",los) 
    String json = SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(obj) 
    JValue.release(obj)
    return json 
EndFunction 

String Function Is_Nudity(Actor akActor) global
    ; 32 off top
    ; 52 and 49 off bottom 
    bool topless = false
    bool bottomless = false 
    if akActor != None 
        Form body = akActor.GetEquippedArmorInSlot(32)
        Form pelvis_primary = akActor.GetEquippedArmorInSlot(52)
        Form pelvis_secondary = akActor.GetEquippedArmorInSlot(49)

        if body == None 
            topless = true  
        endif 
        if pelvis_primary == None && pelvis_secondary == None && body == None 
            bottomless = true 
        endif
    endif 
    
    int obj = JMap.object()
    JMap.setInt(obj, "topless", topless as Int)
    JMap.setInt(obj, "bottomless", bottomless as Int)
    String json = SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(obj)
    JValue.release(obj)
    return json
EndFunction