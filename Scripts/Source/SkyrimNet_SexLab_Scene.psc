Scriptname SkyrimNet_SexLab_Scene extends SkyrimNet_SexLab_Scene_Interface

Import SkyrimNet_SexLab_Utilities
import SkyrimNet_SexLab_Scene_Interface
Import JContainers

SexLabFramework Property sexlab Auto
sslThreadSlots Property threadSlots Auto
sslActorLibrary Property actorLib Auto

Faction Property SkyrimNet_SexLab_Faction_Victim Auto

int num_actors = 0 
; all arrays should be Handled by EnsureArraysLargeEnough
Actor[] actors 
int[] position_objs

String storage_prefix = "skyrimnet_sexlab_scene"
String storage_obj_key = "skyrimnet_sexlab_scene_actor_position_obj"
String storage_total_orgasms_key = "skyrimnet_sexlab_scene_total_orgasms"
int thread_obj = 0 ; Thread_obj will be reused 

; -------------------------------------------
; Intent
; -------------------------------------------
int Property INTENT_STAGE_START = 0 AutoReadOnly
int Property INTENT_STAGE_ONGOING = 1 AutoReadOnly
int Property INTENT_STAGE_END = 2 AutoReadOnly

; -------------------------------------------
; Who send the messages to SkyrimNet 
; -------------------------------------------
Actor sender = None 
Actor receiver = None 

; --------------------------------------------
; Track Scene
; --------------------------------------------
bool Property tracking = False Auto

; --------------------------------------------
; Thread
; --------------------------------------------
sslThreadController thread

; --------------------------------------------
; Set in the generic thread 
; --------------------------------------------
bool is_generic

Function Trace(String func, String msg="", Bool notification=False)
    msg = "[SkyrimNet_SexLab_Scene."+func+"] sid:"+sid+" "+msg
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
    parent.Initialize(_sid,_manager) 
    EnsureActorArraysLargeEnough(2)
    num_actors = 0 

    sexlab = manager.sexlab
    threadSlots = manager.threadSlots
    actorLib = manager.actorLib
    SkyrimNet_SexLab_Faction_Victim = manager.SkyrimNet_SexLab_Faction_Victim
    is_generic = false
    StorageUtil.ClearAllPrefix(storage_prefix)
    CreateThreadJson() 
EndFunction 

; -----------------------------

Function Setup(SkyrimNet_SexLab_Scene_Creator creator=None)
    if thread == None 
        Trace("Setup","thread is none, aborting")
        return 
    endif 

    Actor[] positions = thread.positions
    EnsureActorArraysLargeEnough(positions.length) 

    num_actors = positions.length
    Trace("Setup", "--- a num_actors: "+num_actors+" actors.length: "+actors.length)
    if creator != None 
        has_player = creator.has_player
        intent = creator.intent 
        style = creator.style
        sender = creator.GetSpeaker()
        receiver = creator.GetTarget() 
        int i = 0 
        while i < num_actors 
            if i < creator.num_actors
                SetPosition(i, creator.actors[i], creator.no_orgasm_mask[i], creator.speaking_modifiers[i]) 
            else 
                SetPosition(i, thread.positions[i], 0, "")
            endif 
            i += 1 
        endwhile 
    else 
        intent = INTENT_DEFAULT
        style = STYLE_DEFAULT
        int i = 0 
        has_player = false
        Actor player = Game.GetPlayer()
        while i < num_actors
            SetPosition(i, thread.positions[i], 0, "")
            if thread.positions[i] == player
                has_player = true
            endif
            i += 1 
        endwhile 
        if num_actors == 1 
            sender = actors[0]
            receiver = None 
        else 
            sender = actors[1] 
            receiver = actors[0] 
        endif 
    endif 
    Trace("Setup", "--- b num_actors: "+num_actors)

    if num_actors > 1
        Actor victim = thread.GetVictim() 
        if victim != None && sender == victim 
            sender = receiver 
            receiver = victim
        endif 
    endif 


    Trace("Setup", "--- c num_actors: "+num_actors)
    int i = 0 
    num_victims = 0 
    while i < num_actors
        if thread.IsVictim(actors[i]) 
            num_victims += 1 
            actors[i].AddToFaction(SkyrimNet_SexLab_Faction_Victim)
        else 
            if actors[i].IsInFaction(SkyrimNet_SexLab_Faction_Victim)
                actors[i].RemoveFromFaction(SkyrimNet_SexLab_Faction_Victim)
            endif 
        endif 
        i += 1 
    endwhile 
            
    Trace("Setup", "--- d num_actors: "+num_actors)
    if !is_generic
        status = STATUS_SETUP
    else 
        status = STATUS_ACTIVE 
    endif 
    Trace("Setup", "--- e num_actors: "+num_actors)
    SetNames()
    Trace("Setup", "--- f num_actors: "+num_actors)
    TraceScene() 
EndFunction 

Function TraceScene() 
    Trace("TraceScene", "--- num_actors: "+num_actors)
    Trace("TraceScene", "--- actors: "+JoinActors(actors,num_actors))
    Trace("TraceScene", "--- victims: "+victim_names)
    Trace("TraceScene", "--- assailants: "+assailant_names)
    Trace("TraceScene", "--- hermaphrodiate: "+hermaphrodiate_names)
    Trace("TraceScene", "--- strapon: "+strapon_names)
    Trace("TraceScene", "--- creature_descriptions: "+creature_descriptions)
EndFunction 

Function Release()
    int i = 0
    while i < num_actors
        if actors[i] != None
            if actors[i].IsInFaction(SkyrimNet_SexLab_Faction_Victim)
                actors[i].RemoveFromFaction(SkyrimNet_SexLab_Faction_Victim)
            endif 
            StorageUtil.UnsetIntValue(actors[i], storage_obj_key)
            StorageUtil.UnsetIntValue(actors[i], storage_total_orgasms_key)
        endif 
        actors[i] = None 
        if position_objs && i < position_objs.length && position_objs[i] > 0
            int speaking_obj = JMap.getObj(position_objs[i], "speaking_modifiers")
            if speaking_obj > 0
                JValue.release(speaking_obj)
            endif 
            JMap.clear(position_objs[i])
        endif 
        i += 1
    endwhile
    num_actors = 0
    sender = None 
    receiver = None 

    if thread != None
        if !is_generic
            manager.UnsetThread_scene(thread.tid)
        endif 
        thread = None 
    else 
        Trace("Release","Thread is None, continuing cleanup") 
    endif 
    if thread_obj > 0
        int actors_map = JMap.getObj(thread_obj, "actors")
        if actors_map > 0
            JMap.clear(actors_map)
        endif 
    endif 
    parent.Release()
EndFunction

Function EnsureActorArraysLargeEnough(int size) 
    if actors && position_objs && size <= actors.length && size <= position_objs.length
        return 
    endif 
    actors = EnsureActorsLargeEnough(actors, size) 
    position_objs = EnsureIntsLargeEnough(position_objs, size, 0 ) 
    int i = 0
    while i < size 
        if position_objs[i] < 1
            position_objs[i] = JMap.object() 
            JValue.retain(position_objs[i])
        endif 
        i += 1 
    endwhile 
EndFunction

; ----------------------------------------
; actor_objs Functions 
; -----------------------------------------

Function SetPosition(int i, Actor akActor, int no_orgasm, String speaking_modifiers) 
    Trace("SetPosition", "--- a i: "+i+" akActor: "+akActor.GetDisplayName()+" no_orgasm: "+no_orgasm+" speaking_modifiers: "+speaking_modifiers)
    EnsureActorArraysLargeEnough(i + 1)
    int obj = position_objs[i]
    JMap.setInt(obj, "no_orgasm", no_orgasm) 
    Trace("SetPosition", "--- b obj: "+obj)

    ; Split up speaking modifiers 
    String[] strings = StringUtil.Split(speaking_modifiers,",")
    int num_strings = strings.length 
    Trace("SetPosition", "--- c num_strings: "+num_strings)
    int speaking_obj = JMap.GetObj(obj, "speaking_modifiers") 
    if speaking_obj < 1 || JArray.count(speaking_obj) != num_strings 
        if speaking_obj > 0 
            JValue.release(speaking_obj) 
        endif 
        speaking_obj = JArray.objectWithSize(num_strings) 
        JValue.retain(speaking_obj)
        JMap.setObj(obj, "speaking_modifiers",speaking_obj) 
    endif 
    Trace("SetPosition", "--- d speaking_obj: "+speaking_obj)
    int j = 0 
    while j < num_strings 
        Jarray.setStr(speaking_obj, j, strings[j]) 
        Trace("SetPosition", "--- e j: "+j+" string: "+strings[j]+" speaking_obj: "+speaking_obj)
        j += 1 
    endwhile 
    SetActor(i, akActor)
    Trace("SetPosition", "name: "+actors[i].GetDisplayName()+" no_orgasm: "+JMap.getInt(obj, "no_orgasm")+" speaking_modifiers: "+JMap.getStr(obj, "speaking_modifiers"))
Endfunction 

bool Function SetActor(int i, Actor akActor)
    if akActor == None 
        Trace("SetActor","actors["+i+"] == None ")
        return False 
    endif  
    actors[i] = akActor
    
    int obj = position_objs[i]
    StorageUtil.SetIntValue(akActor, storage_obj_key, obj) 
    StorageUtil.SetIntValue(akActor, storage_total_orgasms_key, 0)
    JMap.setForm(obj, "actor", actors[i])
    JMap.setStr(obj, "name", actors[i].GetDisplayName())

    int gender = actors[i].GetLeveledActorBase().GetSex() ; actorLib.GetGender(actors[i])
    int gender_sexlab = main.sexlab.GetGender(actors[i]) 
    int has_penis = 0
    if gender != 1 || (gender_sexlab != 1 && gender_sexlab != 3)
        has_penis = 1
    endif
    int has_pussy = 0
    if gender == 1 || gender_sexlab == 1 || gender_sexlab == 3
        has_pussy = 1
    endif
    int hermaphrodiate = 0
    if has_penis == 1 && has_pussy == 1
        hermaphrodiate = 1
    endif
    JMap.setInt(obj, "has_penis", has_penis)
    JMap.setInt(obj, "has_pussy", has_pussy)
    JMap.setInt(obj, "hermaphrodiate", hermaphrodiate)

    JMap.setStr(obj,"notice_level","nothing")
    JMap.setInt(obj,"total_orgasm",0)
    JMap.setInt(obj,"arousal", -1) 
    if thread.IsVictim(akActor) 
        JMap.setInt(obj, "victim", 1) 
        JMap.setInt(obj, "assailant", 0) 
    else 
        JMap.setInt(obj, "victim", 0) 
        JMap.setInt(obj, "assailant", 1) 
    endif 

    sslActorAlias actorAlias = thread.ActorAlias(akActor) 
    ;if Game.GetModByName("Data/SLSO.esp") != 255
        ;enjoyment = actorAlias.Getfull_enjoyment() 
    ;else 
        int enjoyment = actorAlias.GetEnjoyment() 
    ;endif 
    JMap.setInt(obj, "enjoyment", enjoyment)

    return obj
EndFunction

int Function GetObjFromActor(Actor akActor) 
    return StorageUtil.GetIntValue(akActor, storage_obj_key, 0) 
EndFunction 

bool Function UpdateActor(int i , Actor akActor) 
    bool changed = False 
    if actors[i] != akActor 
        SetActor(i, akActor) 
        changed = True 
        int total_orgasms = StorageUtil.GetIntValue(akActor, storage_total_orgasms_key, 0) 
        SetTotalOrgasms(akActor, total_orgasms)
    endif 
    return changed 
EndFunction 

Function AlignActors() 
    int size = thread.positions.length 
    EnsureActorArraysLargeEnough(size) 
    int i = 0 
    bool changed = False 
    while i < size
        if UpdateActor(i, thread.positions[i]) 
            changed = True 
        endif 
        i += 1 
    endwhile 
    while i < num_actors 
        StorageUtil.UnsetIntValue(actors[i], storage_obj_key)
        StorageUtil.UnsetIntValue(actors[i], storage_total_orgasms_key)
        i += 1 
        changed = True 
    endwhile 
    num_actors = size 

    if changed 
        SetNames()
    endif 
    UpdateActorsObj() 
EndFunction 

Function AddActorsToMap(int map) 
    int i = 0 
    while i < num_actors 
        int obj = position_objs[i]
        String name = JMap.getStr(obj, "name")
        if name != "" 
            JMap.setObj(map, name, obj) 
        endif 
        i += 1 
    endwhile 
EndFunction 

; ------------------------------------
; Get Names 
; ------------------------------------

Function SetNames() 
    actor_names = JoinActors(thread.positions)
    victim_names = GetNames("victim")
    assailant_names = GetNames("assailant")
    hermaphrodiate_names = GetNames("hermaphrodiate") 
    strapon_names = GetNames("strapon")
    creature_descriptions = GetCreatureDescriptions()
EndFunction 

String Function GetNames(String key_) 
    String names = ""
    int matched = 0
    int i = 0 
    while i < num_actors 
        if JMap.getInt(position_objs[i], key_, 0) == 1 
            matched += 1
        endif 
        i += 1 
    endwhile 

    i = 0 
    int seen = 0
    while i < num_actors 
        if JMap.getInt(position_objs[i], key_, 0) == 1 
            if seen > 0 
                if seen + 1 == matched
                    names += " and "
                else 
                    names += ", "
                endif 
            endif 
            names += JMap.getStr(position_objs[i], "name") 
            seen += 1
        endif 
        i += 1 
    endwhile 
    return names 
EndFunction

String Function GetCreatureDescriptions() 
    String desc = "" 
    int i = 0
    while i < num_actors
        Race r = actors[i].GetRace() 
        if sslCreatureAnimationSlots.HasRaceType(r) 
            String name = actors[i].GetDisplayName()
            String race_name = r.GetName() 
            desc += name+" is a "+race_name+". "
            int j = JArray.count(main.race_to_description) - 1 
            while 0 <= j 
                int creature = Jarray.getObj(main.race_to_description, j) 
                Race creature_race = JMap.getForm(creature,"form_") as Race 
                if creature_race == r 
                    desc += JMap.getStr(creature, "description_")
                    j = -1 
                else 
                    j -= 1 
                endif 
            endwhile 
        endif 
        i += 1
    endwhile
    return desc 
EndFunction

; --------------------------------------------
; Get Functions 
; --------------------------------------------

int Function GetTotalOrgasms(Actor akActor)
    return StorageUtil.GetIntValue(akActor, storage_total_orgasms_key, 0) 
EndFunction 

Function SetTotalOrgasms(Actor akActor, int total_orgasms)
    if akActor == None 
        Trace("SetTotalOrgasms","akActor is None")
        return 
    endif 
    StorageUtil.SetIntValue(akActor, storage_total_orgasms_key, total_orgasms) 
    int obj = GetObjFromActor(akActor)
    if obj > 0
        JMap.setInt(obj, "total_orgasm", total_orgasms)
    endif 
EndFunction 

Function SetThread(sslThreadController _thread) 
    thread = _thread
EndFunction 
sslThreadController Function GetThread()
    if thread == None 
        Trace("GetThread","Thread is None | "+GetString())
    endif 
    return thread
EndFunction

Function SetGeneric() 
    is_generic = True 
EndFunction 
bool Function IsGeneric() 
    return is_generic
EndFunction 

; --------------------------------------------
; Get a Status message for the sl_scene (start, are, finished) 
; --------------------------------------------
String Function GetIntentMessage(int intent_stage = -1) 
    String msg = "are "+intent 
    if intent_stage == INTENT_STAGE_START 
        msg = "start "+intent
    elseif intent_stage == INTENT_STAGE_END 
        msg = "finished "+intent
    endif 
    if num_victims > 0
        return assailant_names+" "+msg+" "+victim_names+"."
    endif 
    return actor_names+" "+msg+"."
EndFunction 
    
bool Function GetThreadActive() 
    if thread == None 
        return false 
    endif 
    String s = (thread as sslThreadModel).GetState() 
    if s != "animating" && s != "prepare"
        Trace("GetThreadActive", "thread is not animating or prepare `"+s+"'")
        return false 
    endif 
    return true 
EndFunction

; --------------------------------------------
; Animation Event Handlers 
; --------------------------------------------
Function AnimationStart()
    AlignActors() 
    manager.SaveThreadsJson() 
    String msg = GetIntentMessage(INTENT_STAGE_START)
    RegisterEvent("sexlab update", msg, sender, receiver) 
EndFunction

Function StageStart() 
    AlignActors() 
    manager.SaveThreadsJson() 
    if SexLab == None 
        Trace("StageStart","sexlab is None | actors:"+JoinActors(actors,num_actors))
        return 
    endif
    if thread == None 
        Trace("StageStart","thread is None | actors:"+JoinActors(actors,num_actors))
        return 
    endif

    ; Send a DN if its a start and includes a player
    ; if not player send DN if allowed by cool off 
    String desc = stages.GetStageDescription(thread)
    if status != STATUS_ACTIVE
        status = STATUS_ACTIVE

        ; -----------------------------------
        ; Registers who started the activites 
        ; -----------------------------------
        if num_actors > 1 
            desc = sender.GetDisplayName()+" initiates, "+ GetIntentMessage(INTENT_STAGE_START)+desc
        endif 

        if desc == "" 
            ContinueActivity(sender, receiver)
        else 
            DirectNarration(desc, sender, receiver) 
        endif 
    elseif thread.stage != thread.animation.StageCount()
        bool use_continue = True 
        if desc != "" && thread.stage > 1
            String desc_last = stages.GetStageDescription(thread, thread.stage - 1)
            if desc != desc_last
                desc = actors[0].GetDisplayName()+"'s sl_scene changes to "+desc
                use_continue = False 
            endif 
        endif 
        if use_continue 
            ContinueActivity(sender, receiver, True)
        else
            DirectNarration_optional("ChangePosition", desc, sender, receiver) 
        endif 
    endif 

    ; If this thread is being tracked print the thread's status 
    if tracking
        bool[] desc_orgasm = stages.GetHasDescriptionOrgasmExpected(thread)
        String msg = "" 
        if desc_orgasm[0]
            msg = "has description"
        endif
        if desc_orgasm[1]
            if msg != ""
                msg += " and "
            endif 
            msg += "orgasm expected"        
        endif
        Debug.Notification("stage "+thread.stage+" of "+ thread.animation.StageCount()+" "+msg)
    endif  
EndFunction

Function AnimationEnd(Actor speaker=None, String style="silently") 
    AlignActors() 
    manager.SaveThreadsJson()

    String msg = GetIntentMessage(INTENT_STAGE_END)
    if SexLab == None || thread == None 
        Trace("AnimationEnd","SexLab or thread is None for sl_scene with actors "+actor_names)
        RegisterEvent("sexlab update", msg, sender, receiver) 
        Release()
        return 
    endif 
    Trace("AnimationEnd","thread id:"+thread.tid+" status:"+thread.GetState())
    ; Handle Separate Orgasms
    sslSystemConfig config = (SexLab as Quest) as sslSystemConfig

    String narration = ""
    if style != "silently" && speaker != None
        narration = speaker.GetDisplayName()+" "+style+" stops, "+GetIntentMessage(INTENT_STAGE_ONGOING)+". "
    endif
    bool has_tentacles = False 

    if  thread.Animation.HasTag("tentacles")
        has_tentacles = True 
        narration = "The tentacles orgasm flooding cum both inside and outside. "
    endif

    bool orgasm_denied = false
    if config.SeparateOrgasms
        String after = "" 
        int[] orgasm_expected = stages.GetOrgasmExpected(thread)
        int j = num_actors - 1 
        while 0 <= j 
            String name = JMap.getStr(position_objs[j], "name") 
            int total_orgasms = JMap.getInt(position_objs[j], "total_orgasm")
            if total_orgasms < 1 
                if orgasm_expected.length > j && orgasm_expected[j] == 1
                    after += name+" failed to orgasm. "
                    orgasm_denied = true
                endif
            elseif total_orgasms < 2
                after += name+"'s body glows in post orgasm. "
            else 
                after += name+"'s body is recovering from "+total_orgasms+" orgasms. "
            endif 
            j -= 1 
        endwhile ;
        narration += after
    endif 

    narration += msg
    if speaker != None || has_tentacles
        DirectNarration(narration, sender, receiver)
    elseif orgasm_denied
        DirectNarration_Optional(intent+" ends", narration, sender, receiver)
    else
        RegisterEvent(intent+" ends", narration, sender, receiver)
    endif 

    if ThreadSlots == None
        Trace("AnimationEnd","ThreadSlots is None", true)
        Release()
        return
    endif
    sslThreadController[] threads = ThreadSlots.Threads

    int i = threads.length - 1 
    bool found = false
    while 0 <= i && !found
        String s = (threads[i] as sslThreadModel).GetState()
        if s == "animating" || s == "prepare"
            found = true
        endif 
        i -= 1
    endwhile
    if found
        main.active_sex = true
    else 
        main.active_sex = false
    endif

    style = STYLE_NORMALLY
    Release() 
EndFunction 

; --------------------------------------------
; Orgasm Handlers
; --------------------------------------------
Function OrgasmCombined()
    AlignActors() 
    int[] orgasm_expected = stages.GetOrgasmExpected(thread)
    bool someone_ejaculated = False 
    String narration = "" 
    Trace("Orgasm_Combined","ThreadID:"+thread.tid+" has_player:"+has_player+" orgasm_expected:"+orgasm_expected)
    int i = 0
    bool no_orgasm_everyone = true
    while i < num_actors
        int obj = position_objs[i] 
        String name = JMap.getStr(obj, "name")
        int no_orgasm = JMap.getInt(obj, "no_orgasm")
        if no_orgasm == 0 
            int has_penis = JMap.getInt(obj, "has_penis")
            int total_orgasms = GetTotalOrgasms(actors[i]) 
            int is_dom_slave = JMap.getInt(obj,"is_dom_slave")
            if is_dom_slave == 1 
                if orgasm_expected[i] == 1
                    if total_orgasms > 0
                        if has_penis
                            someone_ejaculated = True 
                        endif 
                    else 
                        narration += main.handler_dom.HandleOrgasmDenied(actors[i])
                    endif 
                endif 
                Trace("Orgasm_Combined",i+" "+name+" | someone_ejaculated: "+someone_ejaculated+" | DOMSlave:true | narration: "+narration)
            else
                if orgasm_expected[i] == 1
                    narration += name+" is orgasming. "
                    if has_penis
                        someone_ejaculated = True
                    endif
                endif 
            endif 
            no_orgasm_everyone = false
            Trace("Orgasm_Combined","--- i:"+i+" "+name+" | someone_ejaculated: "+someone_ejaculated+" | narration: "+narration)
        else 
            narration += name+" did not orgasm. "
        endif 
        i += 1
    endwhile

    ; Generate cum message 
    i = 0
    while i < num_actors 
        if someone_ejaculated
            narration += AddCum(i, actors[i], actors[i].GetDisplayName())
        endif 
        Trace("Orgasm_Combined","--- "+i+" "+thread.positions[i].GetDisplayName()+"| adding cum | narration: "+narration)
        i += 1 
    endwhile 

    if !no_orgasm_everyone
        if has_player
            DirectNarration(narration, sender, receiver, purge_dialogue=True)
        else 
            DirectNarration_optional("orgasm", narration, sender, receiver)
        endif 
    endif 
EndFunction

; Used for SLSO.esp orgasm handling
Event OrgasmIndividual(Actor akActor, int full_enjoyment, int num_orgasms)
    if akActor == None 
        Trace("OrgasmIndividual","akActor is None") 
        return 
    endif 

    String name = GetDisplayName(akActor) 
    int obj = GetObjFromActor(akActor) 
    if obj > 0 
        if JMap.getInt(obj, "no_orgasm") == 1 
            Trace("OrgasmIndividual",name+" shouldn't orgasm")
            return 
        endif 
        JMap.SetInt(obj, "enjoyment", full_enjoyment) 

        SetTotalOrgasms(akActor, num_orgasms)
    endif 

    String msg = ""
    if num_orgasms == 1
        msg += akActor.GetDisplayName()+" orgasmed."
    else
        msg += akActor.GetDisplayName()+" orgasmed again."
    endif 

    OrgasmHelper(akActor, msg)
EndEvent

Function OrgasmCustom(Actor akActor, String msg)
    SetTotalOrgasms(akActor, GetTotalOrgasms(akActor) + 1) 
    OrgasmHelper(akActor, msg)
EndFunction

Function OrgasmHelper(Actor akActor, String msg)
    Trace("OrgasmHelper","akActor:"+akActor.GetDisplayName()+" msg:"+msg)
    AlignActors()
    Actor cum_catcher = None
    String cum_catcher_name = "(None)"

    int gender = sexlab.GetGender(akActor) 
    bool has_penis = gender == 0 || gender == 2
    if has_penis 
        ; Generate the orgasm message
        int i = 0
        while i < num_actors
            if thread.positions[i] != akActor && cum_catcher == None
                cum_catcher = thread.positions[i]
                cum_catcher_name = cum_catcher.GetDisplayName()
                msg += AddCum(i, cum_catcher, cum_catcher_name)
            endif 
            i += 1 
        endwhile 
    endif 

    Trace("OrgasmHelper"," has_penis:"+has_penis+" cum_catcher:"+cum_catcher_name+" msg:"+msg)
    if has_player 
        DirectNarration(msg, akActor, cum_catcher, purge_dialogue=true)
    else 
        DirectNarration_Optional("orgasm", msg, akActor, cum_catcher) 
    endif 
EndFunction

;----------------------------------------------------
; Add Cum
;----------------------------------------------------
String Function AddCum(int position, Actor akActor, String name)
    ; Add cum overlay 
    sslBaseAnimation anim = thread.Animation
    int CumId = anim.GetCumId(position, thread.stage)

    ; -1 - no gender 
    ;  0 - Male (also the default values if the actor is not existing)
    ;  1 - Female
    int gender = akActor.GetLeveledActorBase().GetSex()
    ; 0 - male
    ; 1 - female 
    ; 2 - male creature 
    ; 3 - female creature 
    int gender_sexlab = sexlab.GetGender(akActor)
    bool has_pussy = gender == 1 || gender_sexlab == 1 || gender_sexlab == 3
    String genital = "" 
    if has_pussy
        genital = "pussy"
    else 
        genital = "penis"
    endif 

    String places = "" 
    if cumId > 0
        if cumId == sslObjectFactory.vaginal()
            places = genital
        elseif cumId == sslObjectFactory.oral()
            places = "mouth"
        elseif cumId == sslObjectFactory.anal()
            places = "ass"
        elseif cumId == sslObjectFactory.VaginalOral()
            if has_pussy
                places = genital+" and mouth"
            else
                places = "mouth"
            endif 
        elseif cumId == sslObjectFactory.VaginalAnal()
            if has_pussy
                places = genital+" and ass"
            else
                places = "mouth"
            endif 
        elseif cumId == sslObjectFactory.OralAnal()
            places = "mouth and ass"
        elseif cumId == sslObjectFactory.VaginalOralAnal()
            if has_pussy
                places = "mouth and ass"
            else
                places = genital+", mouth, and ass"
            endif 
        endif
    endif 

    if places != ""
        return name+"'s "+places+" is dripping with warm sticky cum. "
    endif 
    return "" 
EndFunction  

; --------------------------------------------
; --------------------------------------------
String Function GetDescription()
    if thread == None 
        return ""
    endif 
    int intent_stage = INTENT_STAGE_ONGOING
    if status != STATUS_ACTIVE
        intent_stage = INTENT_STAGE_START
    endif 
    return GetIntentMessage(intent_stage)+" "+stages.GetStageDescription(thread)
EndFunction

Function CreateThreadJson() 
    if !thread_obj
        thread_obj = JMap.object() 
        JValue.retain(thread_obj)

        int actors_obj = JMap.object() 
        JValue.retain(actors_obj)
        JMap.setObj(thread_obj, "actors", actors_obj) 
    endif 
EndFunction

String Function GetJson(Actor speaker) 
    int obj = GetObj(speaker) 
    String json = JValue.toJsonString(obj) 
    return json 
EndFunction 

int Function GetObj(Actor speaker)
    AlignActors()

    Float distance = 0.0
    bool los = True 
    if speaker != None 
        los = False 
    endif 

    int i = 0
    bool actor_changed = False 
    while i < num_actors 
        if speaker != None && thread.positions[i] == speaker 
            los = True 
        endif 
        if UpdateActor(i, thread.positions[i]) 
            actor_changed = True 
        endif 
        i += 1 
    endwhile 
    if actor_changed
        SetNames() 
    endif 

    if !los
        distance = speaker.GetDistance(thread.positions[0])
        los = speaker.HasLOS(thread.positions[0]) 
    endif 

    JMap.setInt(thread_obj, "active", GetThreadActive() as int ) 
    JMap.setStr(thread_obj, "status",status) 
    JMap.setStr(thread_obj, "description", GetDescription())
    JMap.setStr(thread_obj, "style", style)
    JMap.setFlt(thread_obj, "speaker_distance", distance)
    JMap.setInt(thread_obj, "speaker_los", los as int)
    return thread_obj
EndFunction

int Function GetVictimsNamesJsonObj()
    int victimNamesMap = JMap.object()
    int i = 0
    while i < num_actors
        if thread.IsVictim(actors[i])
            JMap.setStr(victimNamesMap, actors[i].GetDisplayName(), actors[i].GetDisplayName())
        endif
        i += 1
    endwhile

    return victimNamesMap
EndFunction

int Function UpdateActorsObj()
    int actors_map = JMap.getObj(thread_obj, "actors")
    int i = 0
    JMap.clear(actors_map) 
    while i < num_actors
        int obj = position_objs[i]
        String name = JMap.getStr(obj,"name")
        JMap.setObj(actors_map,name,obj)
        i += 1 
    endwhile
    return actors_map
EndFunction

String Function GetLocation()

    int bed = thread.BedTypeId

    String loc = "the floor"
    if  bed == 1
        loc = "a bedroll "
    elseif bed == 2
        loc = "a single bed "
    elseif bed == 3
        loc = "a double bed "
    endif 

    String[] on_furniture = new String[21]
    on_furniture[0] = "Table"
    on_furniture[1] = "LowTable"
    on_furniture[2] = "JavTable"
    on_furniture[3] = "Pole"
    on_furniture[4] = "wall"
    on_furniture[5] = "horse"
    on_furniture[6] = "Pillory"
    on_furniture[7] = "PilloryLow"
    on_furniture[8] = "Cage"
    on_furniture[9] = "Haybale"
    on_furniture[10] = "Xcross"
    on_furniture[11] = "WoodenPony"
    on_furniture[12] = "EnchantingWB"
    on_furniture[13] = "AlchemyWB"
    on_furniture[14] = "FuckMachine"
    on_furniture[15] = "chair"
    on_furniture[16] = "wheel"
    on_furniture[17] = "DwemerChair"
    on_furniture[18] = "NecroChair"
    on_furniture[19] = "Throne"
    on_furniture[20] = "Stockade"
    ; Add more if needed

    sslBaseAnimation anim = thread.Animation
    int i = 0
    bool found = false
    while i < on_furniture.Length && !found
        if anim.HasTag(on_furniture[i])
            loc = on_furniture[i]
            found = true
        endif
        i += 1
    endwhile

    if loc == "" 
        if anim.HasTag("Cage")
            loc = " in a cage"
        elseif anim.HasTag("Gallows")
            loc = " in a gallows"
        elseif anim.HasTag("coffin")
            loc = " in a coffin"
        elseif anim.HasTag("floating")
            loc = " floating in air"
        elseif anim.HasTag("tentacles")
            loc = " with tentacles"
        elseif anim.HasTag("gloryhole") || anim.HasTag("gloryholem")
            loc = " through a gloryhole"
        endif
    endif 

    return loc+" "
EndFunction 


bool Function SexLab_Thread_LOS(Actor akActor)
    if thread == None 
        return True 
    endif 
    int i = 0
    while i < num_actors 
        if akActor == thread.positions[i] || akActor.HasLOS(thread.positions[i])
            return true
        endif 
        i += 1
    endwhile 
    return false
endFunction 

String Function GetTagsString(sslBaseAnimation anim) global
    String[] _tags = anim.GetRawTags()
    int num_tags = _tags.length 
    int obj = JArray.objectWithSize(num_tags) 
    int i = 0 
    while i < num_tags
        JArray.setStr(obj, i, _tags[i])
        i += 1
    endwhile
    String json = JValue.toJsonString(obj)
    JValue.release(obj) 
    return json
EndFunction 