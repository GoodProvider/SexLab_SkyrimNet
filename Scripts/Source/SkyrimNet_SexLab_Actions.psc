Scriptname SkyrimNet_SexLab_Actions extends Quest

SkyrimNet_SexLab_Main Property main Auto 
SkyrimNet_SexLab_Scene_Manager Property manager Auto 
SexLabFramework Property sexlab Auto 

import SkyrimNet_SexLab_Utilities

Idle Property pa_HugA Auto  ; IDLE:000F4699

Faction OStimActorCountFaction = None 

Function Trace(String func, String msg, Bool notification=False) global
    msg = "[SkyrimNet_SexLab_Actions."+func+"] "+msg
    Debug.Trace(msg) 
    if notification
        Debug.Notification(msg)
    endif 
EndFunction

; -------------------------------------------------
; Setup
; -------------------------------------------------
Function Setup()
    if Game.GetModByName("Ostim.esp") != 255
        OStimActorCountFaction = Game.GetFormFromFile(0xECA, "Ostim.esp") as Faction
        Trace("Setup","Found Ostim.esp, OStimActorCountFaction set to "+OStimActorCountFaction)
    else 
        OStimActorCountFaction = None 
    endif 
EndFunction 

;-------------------------------------------
; One
;-------------------------------------------

Function StartScene_Consensual_One(String intent, Actor speaker, string style="", String method="", String setting_name="")
    Trace("StartScene_Consensual_One",intent+" "+speaker.GetDisplayName()+" style: "+style+" method: "+method)
    StartScene_Event(intent, speaker, style=style, method=method, setting_name=setting_name) 
EndFunction

Function StartScene_Nonconsensual_One(String intent, Actor speaker, string style="", String method="", String setting_name="")
    Trace("StartScene_Nonconsensual_One",intent+" "+speaker.GetDisplayName()+" style: "+style+" method: "+method)
    StartScene_Event(intent, speaker, victim=speaker, style=style, method=method, setting_name=setting_name) 
EndFunction

;-------------------------------------------
; Two
;-------------------------------------------

Function StartScene_Consensual_Two(String intent, Actor speaker, Actor target, string style="", string method="", String direction="", String setting_name="")
    Trace("StartScene_Consensual_Two","intent:"+intent+" speaker:"+speaker.GetDisplayName()+" + "+target.GetDisplayName()+" style: "+style+" direction: "+direction+" intent: "+intent+" method:"+method+" setting_name:"+setting_name)

    ; Hug idle is bi-directional, so is ignored 
    if method == "hug" || method == "single hug"
        target.playIdleWithTarget(pa_HugA, speaker) 
        Actor sender = speaker 
        Actor receiver = target 
        if direction == "get" || direction == "getting"
            sender = target 
            receiver = speaker 
        endif 
        String msg = sender.GetDisplayName()+" hugs "+receiver.GetDisplayName()+"."
        DirectNarration(msg, speaker, target)
        return
    endif 
    StartScene_Event(intent, speaker, target, None, style, method, direction, setting_name=setting_name) 
EndFunction

Function StartScene_Nonconsensual_Two(String intent, Actor speaker, Actor target=None, string style="", string method="", String direction="", bool speaker_victim=false, String setting_name="")
    Trace("StartScene_Nonconsensual_Two",GetDisplayName(speaker)+" "+GetDisplayName(target)+" style: "+style+" method:"+method+" direction: "+direction+" speaker_victim:"+speaker_victim+" setting_name:"+setting_name)
    Actor victim = target
    if speaker_victim 
        victim = speaker
    endif 
    StartScene_Event(intent, speaker, target, victim, style, method, direction, setting_name=setting_name) 
EndFunction

Function StartScene_Nonconsensual_Two_Victim(String intent, Actor speaker, Actor target=None, string style="", string method="", String direction="", Actor victim, String setting_name="")
    Trace("StartScene_Nonconsensual_Two",GetDisplayName(speaker)+" "+GetDisplayName(target)+" style: "+style+" method:"+method+" direction: "+direction+" speaker_victim:"+GetDisplayName(victim)+" setting_name:"+setting_name)
    StartScene_Event(intent, speaker, target, victim, style, method, direction, setting_name=setting_name) 
EndFunction

Function StartScene_Punish_Two(String intent, Actor speaker, Actor target=None, string style="", string method="", String direction="", String setting_name="")
    Trace("StartScene_Punish_Two",GetDisplayName(speaker)+" "+GetDisplayName(target)+" style: "+style+" method:"+method+" direction: "+direction+" setting_name:"+setting_name)
    Actor victim = target
    StartScene_Event(intent, speaker, target, victim, style, method, direction, setting_name=setting_name) 
EndFunction

;-------------------------------------------
; Threesome
;-------------------------------------------

Function StartScene_Consensual_Three(String intent, Actor speaker, Actor target, string style, string direction, string method, String setting_name="", Actor participate)
    Trace("StartScene_Consensual_Three","intent:"+GetDisplayName(speaker)+" + "+GetDisplayName(target)+" style: "+style+" direction: "+direction+" method: "+method+" participate:"+participate.GetDisplayName()+" setting_name:"+setting_name+" participate:"+GetDisplayName(participate))
    StartScene_Event(intent, speaker, target, None, style, method, direction, setting_name=setting_name, participate_3=participate)
EndFunction


Function StartScene_Nonconsensual_Three(String intent, Actor speaker, Actor target, string style, string method, string direction, bool speaker_victim, String setting_name="", Actor participate)
    Trace("StartScene_Nonconsensual_Three","intent:"+GetDisplayName(speaker)+" + "+GetDisplayName(target)+" style: "+style+" direction: "+direction+" method: "+method+" speaker_victim:"+speaker_victim+" setting_name:"+setting_name+" participate:"+GetDisplayName(participate))
    Actor victim = target
    if speaker_victim 
        victim = speaker
    endif 
    StartScene_Event(intent, speaker, target, victim, style, method, direction, setting_name=setting_name, participate_3=participate) 
EndFunction

;-------------------------------------------
; Scene Stop 
;-------------------------------------------

Function SceneStop(Actor speaker, String style)
    Trace("SceneStop",GetDisplayName(speaker)+" style: "+style)
    SceneStop_Event(speaker, speaker, style) 
EndFunction

Function SceneStop_Target(Actor speaker, Actor target, String style)
    Trace("SceneStop",GetDisplayName(speaker)+" + "+GetDisplayName(target)+" style: "+style)
    SceneStop_Event(speaker, target, style) 
EndFunction

;------------------------------------------------------------------------------
; Refused
;------------------------------------------------------------------------------

Function StartScene_Refused_Two(String intent, Actor speaker, Actor target, string style="", string method="", string direction="")
    String speaker_name = GetDisplayName(speaker)
    String target_name = GetDisplayName(target)
    Trace("StartScene_Refused_Two","intent: "+intent+" "+speaker_name+" + "+target_name+" style: "+style+" direction: "+direction+" method: "+method)
    if style == "normal" || style == "normally"
        style = "" 
    endif 
    String msg = target_name+" "+style+" refused to allow "+intent+" by "
    if direction == "" || direction == "getting" 
        msg += direction+" "+method+" from "+speaker.GetDisplayName() 
    else 
        msg += direction+" "+method+" to "+speaker.GetDisplayName() 
    endif 
    DirectNarration(msg, target, speaker) 
EndFunction

;------------------------------------------------------------------------------
; Events 
;------------------------------------------------------------------------------

Function SceneStop_Event(Actor speaker, Actor target, String style) 
    int handle = ModEvent.Create("SkyrimNet_SexLab_Action_Stop")
    ModEvent.PushForm(handle, speaker)
    ModEvent.PushForm(handle, target)
    ModEvent.PushString(handle, style)
    ModEvent.Send(handle)
EndFunction 

;--------------------------------------
; Two actors 
;--------------------------------------
Function StartScene_Event(String intent, Actor speaker, Actor target=None, Actor victim=None,\
     string style="", string method="", String direction="", String event_hook="", String setting_name="",\
     Actor participate_3=None)

    if target == None && participate_3 != None 
        target = participate_3 
        participate_3 = None 
    endif 

    String speaker_name = GetDisplayName(speaker)
    String target_name = GetDisplayName(target) 
    String victim_name = GetDisplayName(victim) 
    String participate_3_name = GetDisplayName(participate_3) 
    
    if method == "pussy"
        method = "vaginal"
    elseif method == "mouth"
        method = "oral"
    elseif method == "ass" 
        method = "anal"
    endif 

    if method == "whipping"
        method = "whip"
    endif 

    if method == "hugging"
        method = "hug"
    endif 

    int speaker_position = 0 
    if target != None 
        if method == "oral" || method == "vaginal" || method == "anal"
            if direction == "fuck a"
                speaker_position = 1 
            endif 
        elseif method == "kissing" || method == "spanking" || method == "whip"
            if direction == "giving" || direction == "give" 
                speaker_position = 1 
            endif 
        elseif direction == "get" || direction == "getting"
            speaker_position = 1 
        endif 
    endif 

    String event_name = "SkyrimNet_SexLab_Action_Start"
    Trace("StartScene_Event","event_name:"+event_name+" intent:"+intent+" speaker:"+speaker_name+" target:"+target_name+" victim:"+victim_name\
        +" style:"+style+" speaker_position:"+speaker_position+" method:"+method+" event_hook:"+event_hook+" setting_name:"+setting_name\
        +" participate_3_name:"+participate_3_name)

    int handle = ModEvent.Create(event_name)
    ModEvent.PushString(handle, intent)
    ModEvent.PushForm(handle, speaker)
    ModEvent.PushForm(handle, target)
    ModEvent.PushForm(handle, victim)
    ModEvent.PushString(handle, style)
    ModEvent.PushString(handle, method)
    ModEvent.PushInt(handle, speaker_position)
    ModEvent.PushString(handle, event_hook)
    ModEvent.PushString(handle, setting_name)
    ModEvent.PushForm(handle, participate_3)
    ModEvent.Send(handle)
EndFunction 


;--------------------------------------
; Functions 
;--------------------------------------



; -------------------------------------------------
; Dress and Undress
; Narration: direct, silent, none (notification or event)
; -------------------------------------------------
Function Change_Outfit(Actor stripper, Actor stripped, String style, String how, String narration)
    Trace("Change_Outfit",stripper.GetDisplayName()+" stripper "+stripped.GetDisplayName()+" style:"+style+" how: "+how+" narration:"+narration)

    if how == "take off" 
        how = "undress"
    elseif how == "put on"
        how = "dress"
    endif 

    bool success = False
    if how == "dress"
        Form[] forms = main.UnStoreStrippedItems(Stripped)
        if forms.length > 0
            sexlab.UnStripActor(Stripped, forms, false)
            success = True
        else
            Trace("Change_Outfit",Stripped.GetDisplayName()+" has no stripped items")
        endif
    else
        ;/* StripActor
        * * Strips an actor using SexLab's strip setting as chosen by the user from the SexLab MCM
        * * 
        * * @param: Actor ActorRef - The actor whose equipment shall be unequipped.
        * * @param: Actor VictimRef [OPTIONAL] - If ActorRef matches VictimRef victim strip setting are used. If VictimRef is set but doesn't match, aggressor setting are used.
        * * @param: bool DoAnimate [OPTIONAL true by default] - Whether or not to play the actor stripping animations during the strip
        * * @param: bool LeadIn [OPTIONAL false by default] - If TRUE and VictimRef == none, Foreplay strip setting will be used.
        * * @return: Form[] - An array of all equipment stripped from ActorRef
        */;
        Actor victim = None 
        Bool do_animate = True
        if stripper != stripped
            victim = stripped 
            do_animate = False
        endif 
        Form[] forms = sexlab.StripActor(stripped, victim, do_animate, false) 
        main.StoreStrippedItems(stripped, forms)
        success = True 
    endif

    if success
        Actor listener = Stripped 
        if listener == Stripper 
            listener = None 
        endif 

        String msg = stripper.GetDisplayName()+" "+style+" "+how+"es "+stripped.GetDisplayName()+"."
        if narration == "direct"
            DirectNarration(msg, stripper, listener) 
        elseif narration == "silent"
            RegisterEvent(how,msg, stripper, listener) 
        endif 
    endif 
EndFunction

; -------------------------------------------------
; IsEligible
; -------------------------------------------------

bool Function BodyAnimation_IsEligible(Actor akActor, string contextJson, string paramsJson)
    if akActor == None 
        Trace("BodyAnimation_IsEligible","akActor is None")
        return false
    endif

    String name = akActor.GetDisplayName()
    if akActor.IsDead() || akActor.IsInCombat() 
        Trace("BodyAnimation_IsEligible", akActor.GetDisplayName()+" is dead or in combat")
        return false 
    endif 

    if StorageUtil.HasIntValue(akActor, "skyrimnet_sexlab_scene_actor_lock")
        Trace("BodyAnimation_IsEligible", akActor.GetDisplayName()+" is locked")
        return false 
    endif

    if main.sexLab.IsActorActive(akActor) 
        Trace("BodyAnimation_IsEligible", akActor.GetDisplayName()+" SexLab animation")
        return false 
    endif 

    if OstimActorCountFaction != None && akActor.IsInFaction(OStimActorCountFaction)
        Trace("BodyAnimation_IsEligible", akActor.GetDisplayName()+" OStim animation")
        return false 
    endif
    Trace("BodyAnimation_Tag", name+" is eligible for sex")
    return True
EndFunction
