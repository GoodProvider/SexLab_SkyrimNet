Scriptname SkyrimNet_SexLab_Handler_DOM extends SkyrimNet_SexLab_Handler_DOM_Interface 
SkyrimNet_SexLab_Scene_Manager manager 

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
;    return SkyrimNet_DOM_API.IsDOMSlave(akActor)
return false 
EndFunction

; Hands off the slave to SkyrimNet_DOM Target_Menu_Selection
Bool Function Target_Menu_Selection(Actor target, Actor player)
;    return SkyrimNet_DOM_Menu.Target_Menu_Selection(target, player)
return false
EndFunction

String Function HandleOrgasmDenied(Actor akActor)
;    DOM_Actor slave = SkyrimNet_DOM_API.GetSlave("SkyrimNet_SexLab_Main", "HandleOrgasmDenied", akActor) as Dom_Actor
;
;    if slave != None 
;        if slave.mind.is_aroused_for > 0
;            return akActor.GetDisplayName()+" was denied an orgasm. "
;        endif 
;    endif 
    return ""
EndFunction

Function DOMSlave_Orgasmed(Actor slave, String msg)
    manager.OrgasmCustom(slave, msg)
EndFunction

Bool Function Orgasm_Desired(Actor akActor)
;    DOM_Actor slave = SkyrimNet_DOM_API.GetSlave("SkyrimNet_SexLab_Main", "Orgasm_Combined", akActor) as Dom_Actor
;    return slave != None && slave.mind.is_aroused_for > 0
return false 
EndFunction