Scriptname SkyrimNet_SexLab_Handler_DOM extends SkyrimNet_SexLab_Handler_DOM_Interface 

SkyrimNet_SexLab_Scene_Manager manager 

import SkyrimNet_SexLab_Utilities

String storage_actor_orgasm_total_key = "skyrimnet_sexlab_domactor_orgasm_total"
String storage_actor_orgasm_message_key = "skyrimnet_sexlab_domactor_orgasm_message"



int actors_obj = 0


Function Trace(String func, String msg, Bool notification=False)
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Handler_DOM", func, msg)
    if notification
        Debug.Notification(logged)
    endif 
EndFunction



bool Function Setup()
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        return False
    endif

    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x000800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main
    main.handler_dom = self

    Trace("Setup", "Success")

    if actors_obj == 0 
        actors_obj = JArray.object()
        Jvalue.retain(actors_obj)
    endif

    return True 
endFunction

Bool Function Setup_CheckLinks()
    Bool links_ok = true

    manager = Game.GetFormFromFile(0x000800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene_Manager
    if manager == None 
        links_ok = false
    endif 

    ; Light Dom presence check (call sites use SkyrimNet_DOM_API, not a local Actions property)
    if Game.GetModByName("SkyrimNet_DOM.esp") == 255
        links_ok = false
    endif

    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x000800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main
    if main == None
        links_ok = false
    endif

    return links_ok
EndFunction



; Checks if the actor is a dom slave 

Bool Function IsDOMSlave(Actor akActor)

    if akActor == None

        return false

    endif

    return SkyrimNet_DOM_API.IsDOMSlave(akActor)

EndFunction



String Function HandleOrgasmDenied(Actor akActor)

    DOM_Actor slave = SkyrimNet_DOM_API.GetSlave("SkyrimNet_SexLab_Handler_DOM", "HandleOrgasmDenied", akActor) as Dom_Actor

    if slave != None && slave.mind != None 


        if slave.mind.arousal_factor > 120
            return akActor.GetDisplayName()+"'s body and mind scream for release, but was denied an orgasm. "
        elseif slave.mind.arousal_factor > 99
            return akActor.GetDisplayName()+"'s body hungers release, but was denied an orgasm. "
        elseif slave.mind.arousal_factor > 80
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
    if slave == None 
        Trace("DOMSlave_Orgasmed","slave is None, aborting")
    elseif manager == None 
        Trace("DOMSlave_Orgasmed","manager is None, aborting")
    elseif !manager.sexlab.IsActorActive(slave) 
        int total = StorageUtil.GetIntValue(slave, storage_actor_orgasm_total_key, 0)
        msg += " "+GetDisplayName(slave)+" is orgasming. "
        if total == 0 
            StorageUtil.SetIntValue(slave, storage_actor_orgasm_total_key, 1)
            StorageUtil.SetStringValue(slave, storage_actor_orgasm_message_key, msg)
            JArray.addForm(actors_obj, slave)
        else
            total += 1
            StorageUtil.SetIntValue(slave, storage_actor_orgasm_total_key, total)
        endif
        RegisterForSingleUpdate(1.0)
    else 
        manager.OrgasmCustom(slave, msg)
    endif
EndFunction

Event OnUpdate() 
    Form[] objs = JArray.asFormArray(actors_obj)
    int i = 0 
    int count = objs.Length
    String narration = ""
    Actor sender = None 
    Actor receiver = None 
    while i < count
        Actor slave = objs[i] as Actor
        if sender == None 
            sender = slave
        elseif receiver == None 
            receiver = slave
        endif
        int total = StorageUtil.GetIntValue(slave, storage_actor_orgasm_total_key, 0)
        String msg = StorageUtil.GetStringValue(slave, storage_actor_orgasm_message_key, "")
        if total > 0 
            if total > 1 
                msg += total+" times, over and over again." 
            endif 
            StorageUtil.UnsetIntValue(slave, storage_actor_orgasm_total_key)
            StorageUtil.UnsetStringValue(slave, storage_actor_orgasm_message_key)
        endif
        narration += msg+". "
        i += 1 
    endwhile 
    JArray.clear(actors_obj)
    if narration != "" 
        DirectNarration(narration, sender, receiver, purge_dialogue=true)
    endif
EndEvent


Bool Function Orgasm_Desired(Actor akActor)

    DOM_Actor slave = SkyrimNet_DOM_API.GetSlave("SkyrimNet_SexLab_Handler_DOM", "Orgasm_Desired", akActor) as Dom_Actor

    return slave != None && slave.mind != None && slave.mind.is_aroused_for > 0

EndFunction


int Function GetThreads()
    return SkyrimNet_DOM_API.GetThreads()
EndFunction



; ------------------------------------------------------------

Function Start_Masturbate(String intent, Actor speaker, Actor superior, String position="")
    SkyrimNet_DOM_API.Start_Masturbate(intent, speaker, superior, position)
EndFunction



Function StartScene_Consensual_Two(String intent, Actor speaker, Actor superior, Actor target, string style="", string method="", String direction="", String setting_name="")
    SkyrimNet_DOM_API.StartScene_Consensual_Two(intent, speaker, superior, target, style, method, direction, setting_name)
EndFunction



; style omitted (ExecuteQuestFunction max 8 args / DOM_API); SexLab always gets style=""
Function StartScene_Nonconsensual_Two(String intent, Actor speaker, Actor superior, Actor target, Actor victim, string method="", String direction="", String setting_name="")
    SkyrimNet_DOM_API.StartScene_Nonconsensual_Two(intent, speaker, superior, target, victim, method=method, direction=direction, setting_name=setting_name)
EndFunction

Function StartScene_Nonconsensual_Two_SpeakerVictim(String intent, Actor speaker, Actor superior, Actor target, string method="", String direction="", String setting_name="")
    SkyrimNet_DOM_API.StartScene_Nonconsensual_Two_SpeakerVictim(intent, speaker, superior, target, method=method, direction=direction, setting_name=setting_name)
EndFunction

Function StartScene_Nonconsensual_Two_TargetVictim(String intent, Actor speaker, Actor superior, Actor target, string method="", String direction="", String setting_name="")
    SkyrimNet_DOM_API.StartScene_Nonconsensual_Two_TargetVictim(intent, speaker, superior, target, method=method, direction=direction, setting_name=setting_name)
EndFunction