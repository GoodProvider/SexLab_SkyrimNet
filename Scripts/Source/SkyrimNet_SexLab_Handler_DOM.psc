Scriptname SkyrimNet_SexLab_Handler_DOM extends SkyrimNet_SexLab_Handler_DOM_Interface 

SkyrimNet_SexLab_Scene_Manager manager 

import SkyrimNet_SexLab_Utilities



Function Trace(String func, String msg, Bool notification=False)

    msg = "[SkyrimNet_SexLab_Handler_DOM."+func+"] "+msg

    Debug.Trace(msg) 

    if notification

        Debug.Notification(msg)

    endif 

EndFunction



bool Function Setup()

    manager = Game.GetFormFromFile(0x000800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene_Manager

    if manager == None 

        Trace("Setup","manager is None, aborting")

        return  False

    endif 



    ; Light Dom presence check (call sites use SkyrimNet_DOM_API, not a local Actions property)

    if Game.GetModByName("SkyrimNet_DOM.esp") == 255

        Trace("Setup","SkyrimNet_DOM.esp not loaded, aborting")

        return False

    endif



    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x000800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main

    if main == None

        Trace("Setup", "main is None, aborting")

        return False

    endif

    main.handler_dom = self

    Trace("Setup", "Success")

    return True 

endFunction



; Checks if the actor is a dom slave 

Bool Function IsDOMSlave(Actor akActor)

    if akActor == None

        return false

    endif

    return SkyrimNet_DOM_API.IsDOMSlave(akActor)

EndFunction



String Function HandleOrgasmDenied(Actor akActor)

    DOM_Actor slave = SkyrimNet_DOM_API.GetSlave("SkyrimNet_SexLab_Handler_DOM", "HandleOrgasmDenied", akActor) as Dom_Actor

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

    if slave == None || manager == None

        Trace("DOMSlave_Orgasmed","slave or manager is None, aborting")

        return

    endif

    Trace("DOMSlave_Orgasmed","--- "+GetDisplayName(slave)+" "+msg) 

    manager.OrgasmCustom(slave, msg)

EndFunction



Bool Function Orgasm_Desired(Actor akActor)

    DOM_Actor slave = SkyrimNet_DOM_API.GetSlave("SkyrimNet_SexLab_Main", "Orgasm_Combined", akActor) as Dom_Actor

    return slave != None && slave.mind.is_aroused_for > 0

EndFunction



; ------------------------------------------------------------

Function Start_Masturbate(String intent, Actor speaker, Actor superior, String style="", String position="")

    SkyrimNet_DOM_API.Start_Masturbate(intent, speaker, superior, style, position)

EndFunction



Function StartScene_Consensual_Two(String intent, Actor speaker, Actor superior, Actor target, string style="", string method="", String direction="", String setting_name="")

    SkyrimNet_DOM_API.StartScene_Consensual_Two(intent, speaker, superior, target, style, method, direction, setting_name)

EndFunction



Function StartScene_Nonconsensual_Two(String intent, Actor speaker, Actor superior, Actor target=None, string style="", string method="", String direction="", bool speaker_victim=false, String setting_name="")

    SkyrimNet_DOM_API.StartScene_Nonconsensual_Two(intent, speaker, superior, target, style, method, direction, speaker_victim, setting_name)

EndFunction


