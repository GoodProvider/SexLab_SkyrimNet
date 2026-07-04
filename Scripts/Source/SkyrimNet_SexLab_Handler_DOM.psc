Scriptname SkyrimNet_SexLab_Handler_DOM extends SkyrimNet_SexLab_Handler_DOM_Interface 
SkyrimNet_SexLab_Scene_Manager manager 
SkyrimNet_DOM_Actions actions
import SkyrimNet_SexLab_Utilities

Function Trace(String func, String msg, Bool notification=False)
    msg = "[SkyrimNet_SexLab_Handler_DOM."+func+"] "+msg
    Debug.Trace(msg) 
    if notification
        Debug.Notification(msg)
    endif 
EndFunction

Function Setup()
    manager = Game.GetFormFromFile(0x000800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene_Manager
    if manager == None 
        Trace("Setup","manager is None, aborting")
        return 
    endif 

    actions = Game.GetFormFromFile(0x000800, "SkyrimNet_DOM.esp") as SkyrimNet_DOM_Actions
    if actions == None 
        Trace("Setup","actions is None, aborting")
        return
    endif

    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x000800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main
    if main == None
        Trace("Setup", "main is None, aborting")
        return
    endif
    main.handler_dom = self
    Trace("Setup", "Success")
endFunction

; Checks if the actor is a dom slave 
Bool Function IsDOMSlave(Actor akActor)
    Trace("IsDomSlave","I was called "+akActor.GetDisplayName())
    return SkyrimNet_DOM_API.IsDOMSlave(akActor)
EndFunction

; Hands off the slave to SkyrimNet_DOM Target_Menu_Selection
Bool Function Target_Menu_Selection(Actor target, Actor player)
    return SkyrimNet_DOM_Menu.Target_Menu_Selection(target, player)
EndFunction

String Function HandleOrgasmDenied(Actor akActor)
    DOM_Actor slave = SkyrimNet_DOM_API.GetSlave("SkyrimNet_SexLab_Main", "HandleOrgasmDenied", akActor) as Dom_Actor
    if slave != None 
        if slave.mind.is_aroused_for > 0
            return akActor.GetDisplayName()+"'s body yearns for release, but was denied an orgasm. "
        elseif slave.mind.arousal_factor > 50
            return akActor.GetDisplayName()+" is aroused, but did not orgasm. "
        else 
            return akActor.GetDisplayName()+" did not orgasm. "
        endif 
    endif 
    return ""
EndFunction

Function DOMSlave_Orgasmed(Actor slave, String msg)
    Trace("DOMSlave_Orgasmed","--- "+GetDisplayName(slave)+" "+msg) 
    manager.OrgasmCustom(slave, msg)
EndFunction

Bool Function Orgasm_Desired(Actor akActor)
    DOM_Actor slave = SkyrimNet_DOM_API.GetSlave("SkyrimNet_SexLab_Main", "Orgasm_Combined", akActor) as Dom_Actor
    return slave != None && slave.mind.is_aroused_for > 0
EndFunction

bool Function StartScene_Consensual_Two(String intent, Actor speaker, Actor Superior, Actor target, string style="", string method="", String direction="", String setting_name="")
    Trace("StartScene_Consensual_Two","intent: "+intent+" speaker: "+GetDisplayName(speaker)+" Superior: "+GetDisplayName(Superior)+" target: "+GetDisplayName(target)+" style: "+style+" method: "+method+" direction: "+direction+" setting_name: "+setting_name)
    if SkyrimNet_DOM_API.IsDOMSlave(target)
        actions.StartScene_Consensual_Two(intent, speaker, Superior, target, style, method, direction, setting_name)
        return true 
    else 
        return false
    endif
EndFunction


