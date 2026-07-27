Scriptname SkyrimNet_SexLab_Scene extends SkyrimNet_SexLab_Scene_Interface

Import SkyrimNet_SexLab_Utilities
import SkyrimNet_SexLab_Scene_Interface
Import JContainers

SexLabFramework Property sexlab Auto
sslThreadSlots Property threadSlots Auto
sslActorLibrary Property actorLib Auto

Faction Property SkyrimNet_SexLab_Faction_Victim Auto

; all arrays should be Handled by EnsureActorArraysLargeEnough
; Actor list is always thread.positions — do not cache a parallel Actor[].
int[] position_objs
int actors_objs
; JArray of Forms we granted SkyrimNet_SexLab_Faction_Victim. Tracked so an actor
; who leaves the scene mid-run (position swap / reshuffle) still gets the faction
; cleared. thread.positions stays authoritative for the participant list.
int victim_faction_forms
; Stores the Orgasm messages for the next stage Start
; We store the message to give more time for all the OrgasmStart messages
; to be processed.  Specifically DOM's 
String[] orgasm_messages
bool orgasm_messages_set = false

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

float Property orgasm_delay = 5.0 Auto

; -------------------------------------------
; Who send the messages to SkyrimNet 
; -------------------------------------------
Actor sender = None 
Actor receiver = None 

; Initiator is the actor who initiated the scene
Actor initiator = None

; --------------------------------------------
; Track Scene
; --------------------------------------------
bool Property tracking = False Auto

; --------------------------------------------
; Description of the scene
; --------------------------------------------
String description_last = ""

; --------------------------------------------
; Thread
; --------------------------------------------
sslThreadController thread

; --------------------------------------------
; Fallback / generic scene flag
; Permanent once set via Initialize(..., _is_generic=true).
; Never clear on Release — this Scene is the pool fallback when no
; inactive sl_scenes remain, so every active thread can still get a description.
; --------------------------------------------
bool is_generic

Function Trace(String func, String msg="", Bool notification=False)
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Scene", func, "sid:"+sid+" "+msg)
    if notification
        Debug.Notification(logged)
    endif 
EndFunction

bool debug_mode = false
Function DbgEnter(String func, String msg="")
    if debug_mode 
        if msg != ""
            Trace(func, "--- enter "+msg)
        else
            Trace(func, "--- enter")
        endif
    endif
EndFunction

Function DbgReturn(String func, String msg="")
    if debug_mode 
        if msg != ""
            Trace(func, "--- return "+msg)
        else
            Trace(func, "--- return")
        endif
    endif
EndFunction

Function DbgEnd(String func, String msg="")
    if debug_mode 
        if msg != ""
            Trace(func, "--- end "+msg)
        else
            Trace(func, "--- end")
        endif
    endif
EndFunction

Function DbgMsg(String func, String msg="")
    if debug_mode 
        if msg != ""
            Trace(func, "--- "+msg)
        else
            Trace(func, "---")
        endif
    endif
EndFunction


String Function GetString() 
    return " actors: ["+actor_names+"]"\
          +" victims: ["+victim_names+"]"\
          +" assailants: ["+assailant_names+"]"\
          +" style:"+style
EndFunction 

; _is_generic: pass true only for sl_scene_generic from Scene_Manager.
; This flag is permanent for the instance lifetime — do not clear on Release.
Function Initialize(int _sid, SkyrimNet_SexLab_Scene_Manager _manager, bool _is_generic = false) 
    debug_mode = False
    DbgEnter("Initialize", "sid:"+_sid+" is_generic:"+_is_generic)
    parent.Initialize(_sid,_manager, _is_generic) 
    EnsureActorArraysLargeEnough(2)
    sexlab = manager.sexlab
    threadSlots = manager.threadSlots
    actorLib = manager.actorLib
    SkyrimNet_SexLab_Faction_Victim = manager.SkyrimNet_SexLab_Faction_Victim
    is_generic = _is_generic
    ; Drop stale thread from prior save/session — status was reset by parent.Initialize.
    thread = None
    StorageUtil.ClearAllPrefix(storage_prefix)

    if thread_obj < 1
        thread_obj = JMap.object() 
        JValue.retain(thread_obj)
    endif 

    ; Legacy name->position map removed; scrub so retained thread_obj does not emit it
    if JMap.hasKey(thread_obj, "actors")
        JMap.removeKey(thread_obj, "actors")
    endif

    if actors_objs < 1 
        actors_objs = JArray.object()
        JValue.retain(actors_objs)
    endif 
    if !JMap.HasKey(thread_obj, "actors")
        JMap.setObj(thread_obj, "actors", actors_objs)
    endif 
    if victim_faction_forms < 1 
        victim_faction_forms = JArray.object()
        JValue.retain(victim_faction_forms)
    endif 
    DbgEnd("Initialize")
EndFunction 

; -----------------------------

Bool Function Setup(SkyrimNet_SexLab_Scene_Creator creator)
    if creator != None
        DbgEnter("Setup", "creator present")
    else
        DbgEnter("Setup")
    endif
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        DbgReturn("Setup", "False")
        return False
    endif
    if thread == None 
        Trace("Setup","thread is none, aborting")
        DbgReturn("Setup", "False")
        return False
    endif 

    Actor[] positions = thread.positions
    if !positions
        DbgReturn("Setup", "False")
        return False
    endif
    int num_actors = positions.length
    DbgMsg("Setup", "thread.positions count="+num_actors)
    EnsureActorArraysLargeEnough(num_actors) 
    orgasm_messages_set = false

    int i = 0 
    ; Assign interface property (not a local) before SetPosition/SetActor so assailant flags work.
    num_victims = 0 
    if num_actors != JArray.count(actors_objs)
        JValue.release(actors_objs)
        actors_objs = JArray.objectWithSize(num_actors)
        JMap.setObj(thread_obj, "actors", actors_objs)
        JValue.retain(actors_objs)
    endif

    ReconcileVictimFactions()

    if creator != None 
        has_player = creator.has_player
        intent = creator.intent 
        style = creator.style
        ; initiator from Creator.GetSpeaker() (may be None); target only feeds receiver.
        initiator = creator.GetSpeaker()
        sender = initiator
        receiver = creator.GetTarget()
        if sender == None
            if num_actors == 1
                sender = positions[0]
            elseif num_actors >= 2
                sender = positions[1]
            endif
        endif
        if receiver == None && num_actors >= 2
            receiver = positions[0]
        endif
        Trace("Setup", "initiator:"+GetDisplayName(initiator)+" sender:"+GetDisplayName(sender)+" receiver:"+GetDisplayName(receiver))
        i = 0 
        while i < num_actors 
            if i < creator.num_actors
                SetPosition(i, positions[i], creator.no_orgasm_mask[i], creator.speaking_modifiers[i]) 
            else 
                SetPosition(i, positions[i], 0, creator.speaking_modifiers_default_current)
            endif 
            i += 1 
        endwhile 
    else 
        intent = INTENT_DEFAULT
        style = STYLE_DEFAULT
        initiator = None
        sender = None
        receiver = None
        i = 0 
        has_player = false
        Actor player = Game.GetPlayer()
        while i < num_actors
            SetPosition(i, positions[i], 0, speaking_modifiers_DEFAULT)
            if positions[i] == player
                has_player = true
            endif
            i += 1 
        endwhile 
        if num_actors == 1 
            sender = positions[0]
            receiver = None 
        else 
            sender = positions[1] 
            receiver = positions[0] 
        endif 
    endif 
    if num_actors > 1 && num_victims > 0
        DbgMsg("Setup", "thread.GetVictim()")
        Actor victim = thread.GetVictim()
        DbgMsg("Setup", "thread.GetVictim() returned "+victim)
        if victim != None && sender == victim
            sender = receiver
            receiver = victim
        endif
    endif

    if !is_generic
        status = STATUS_SETUP
    else 
        status = STATUS_ACTIVE 
    endif 
    SetNames()
    DbgEnd("Setup")
    return True
EndFunction 

Bool Function Setup_CheckLinks()
    Bool links_ok = true

    if manager == None
        links_ok = false
    endif

    if main == None
        links_ok = false
    endif

    if stages == None
        links_ok = false
    endif

    if sexlab == None
        links_ok = false
    endif

    if threadSlots == None
        links_ok = false
    endif

    if actorLib == None
        links_ok = false
    endif

    return links_ok
EndFunction

; Reconcile SkyrimNet_SexLab_Faction_Victim membership with the current
; thread.positions. Adds the faction to current victims, removes it from current
; non-victims, and clears it from any previously-tracked actor who has left the
; scene. Keeps victim_faction_forms holding exactly the current victims and sets
; the num_victims interface property. Safe to call from Setup and AlignActors.
Function ReconcileVictimFactions()
    DbgEnter("ReconcileVictimFactions")
    if thread == None 
        DbgEnd("ReconcileVictimFactions")
        return 
    endif 
    if victim_faction_forms < 1 
        victim_faction_forms = JArray.object()
        JValue.retain(victim_faction_forms)
    endif 

    Actor[] positions = thread.positions
    int num_actors = positions.length

    ; Drop tracked actors who are no longer a current victim (departed or role changed).
    int t = JArray.count(victim_faction_forms) - 1
    while 0 <= t 
        Actor tracked = JArray.getForm(victim_faction_forms, t) as Actor
        bool still_victim = false 
        if tracked != None 
            int p = 0 
            while p < num_actors && !still_victim 
                if positions[p] == tracked && thread.IsVictim(tracked) 
                    still_victim = true 
                endif 
                p += 1 
            endwhile 
        endif 
        if !still_victim 
            if tracked != None && tracked.IsInFaction(SkyrimNet_SexLab_Faction_Victim) 
                tracked.RemoveFromFaction(SkyrimNet_SexLab_Faction_Victim) 
            endif 
            JArray.eraseIndex(victim_faction_forms, t) 
        endif 
        t -= 1 
    endwhile 

    ; Apply faction to current actors and track new victims.
    num_victims = 0 
    int i = 0 
    while i < num_actors 
        Actor akActor = positions[i] 
        if akActor != None 
            DbgMsg("ReconcileVictimFactions", "thread.IsVictim "+akActor.GetDisplayName())
            if thread.IsVictim(akActor) 
                num_victims += 1 
                akActor.AddToFaction(SkyrimNet_SexLab_Faction_Victim) 
                if JArray.findForm(victim_faction_forms, akActor) < 0 
                    JArray.addForm(victim_faction_forms, akActor) 
                endif 
            else 
                if akActor.IsInFaction(SkyrimNet_SexLab_Faction_Victim) 
                    akActor.RemoveFromFaction(SkyrimNet_SexLab_Faction_Victim) 
                endif 
            endif 
        endif 
        i += 1 
    endwhile 
    DbgEnd("ReconcileVictimFactions")
EndFunction 

; Teardown only — reset/release all state except sid and is_generic.
; AlignActors must not tear down; only Release owns resource cleanup.
Function Release()
    DbgEnter("Release")
    int i = 0
    int num_actors = 0
    if thread != None
        num_actors = thread.positions.length
    endif
    while i < num_actors
        Actor akActor = thread.positions[i]
        if akActor != None
            if akActor.IsInFaction(SkyrimNet_SexLab_Faction_Victim)
                akActor.RemoveFromFaction(SkyrimNet_SexLab_Faction_Victim)
            endif 
            StorageUtil.UnsetIntValue(akActor, storage_obj_key)
            StorageUtil.UnsetIntValue(akActor, storage_total_orgasms_key)
        endif 
        if position_objs && i < position_objs.length && position_objs[i] > 0
            int speaking_obj = JMap.getObj(position_objs[i], "speaking_modifiers")
            if speaking_obj > 0
                JValue.release(speaking_obj)
            endif 
            JMap.clear(position_objs[i])
        endif 
        i += 1
    endwhile
    ; Clear the victim faction from every tracked grant (covers actors who left the
    ; scene and so are no longer in thread.positions), then empty the tracker.
    if victim_faction_forms > 0
        int vf = JArray.count(victim_faction_forms) - 1
        while 0 <= vf
            Actor va = JArray.getForm(victim_faction_forms, vf) as Actor
            if va != None && va.IsInFaction(SkyrimNet_SexLab_Faction_Victim)
                va.RemoveFromFaction(SkyrimNet_SexLab_Faction_Victim)
            endif 
            vf -= 1
        endwhile 
        JArray.clear(victim_faction_forms)
    endif 
    ; Also clear leftover position_objs slots beyond current thread size
    if position_objs
        while i < position_objs.length
            if position_objs[i] > 0
                int speaking_obj = JMap.getObj(position_objs[i], "speaking_modifiers")
                if speaking_obj > 0
                    JValue.release(speaking_obj)
                endif 
                JMap.clear(position_objs[i])
            endif 
            i += 1
        endwhile
    endif
    ; Clear pending orgasm messages so a reused pool scene never inherits stale
    ; entries (OrgasmCombined only writes a slot when orgasm_messages[i] == "").
    if orgasm_messages
        int m = 0
        while m < orgasm_messages.length
            orgasm_messages[m] = ""
            m += 1
        endwhile
    endif
    orgasm_messages_set = false

    sender = None 
    receiver = None 
    initiator = None
    tracking = False

    if thread_obj > 0
        JMap.clear(thread_obj)
        if actors_objs > 0
            JArray.clear(actors_objs)
            JMap.setObj(thread_obj, "actors", actors_objs)
        endif
    endif

    if thread != None
        ; Always clear thread_scene[tid], including generic — otherwise a reused
        ; generic leaves a stale tid→generic map until a later mismatch force-Release.
        manager.UnsetThread_scene(thread.tid)
        thread = None 
    else 
        Trace("Release","Thread is None, continuing cleanup") 
    endif 
    ; parent resets interface fields except sid; is_generic is intentionally preserved
    parent.Release()
    DbgEnd("Release")
EndFunction

Function EnsureActorArraysLargeEnough(int size) 
    DbgEnter("EnsureActorArraysLargeEnough", "size:"+size)
    ; Both arrays must be present and large enough. position_objs alone is not
    ; enough: save/load (or older code) can restore position_objs while
    ; orgasm_messages stays None — early-return then leaves Combined crashing.
    if position_objs && orgasm_messages && size <= position_objs.length && size <= orgasm_messages.length
        DbgReturn("EnsureActorArraysLargeEnough", "void")
        return 
    endif 
    position_objs = EnsureIntsLargeEnough(position_objs, size, 0 ) 
    orgasm_messages = EnsureStringsLargeEnough(orgasm_messages, size, "")
    int i = 0
    while i < size 
        if position_objs[i] < 1
            position_objs[i] = JMap.object() 
            JValue.retain(position_objs[i])
        endif 
        i += 1 
    endwhile 
    DbgEnd("EnsureActorArraysLargeEnough")
EndFunction

; ----------------------------------------
; actor_objs Functions 
;
; -----------------------------------------

Function SetPosition(int index, Actor akActor, int no_orgasm, String speaking_modifiers) 
    DbgEnter("SetPosition", "start index:"+index+" akActor:"+GetDisplayName(akActor)+" no_orgasm:"+no_orgasm+" speaking_modifiers:"+speaking_modifiers)
    EnsureActorArraysLargeEnough(index + 1)

    int obj = position_objs[index]
    JMap.setInt(obj, "no_orgasm", no_orgasm) 

    ; Split up speaking modifiers 
    String[] strings = StringUtil.Split(speaking_modifiers,",")
    int count = strings.length 
    int num_strings = 0 
    int i = 0 
    while i < count
        if strings[i] != ""
            num_strings += 1
        endif
        i += 1
    endwhile

    int speaking_obj = JMap.getObj(obj, "speaking_modifiers") 
    if speaking_obj < 1 || JArray.count(speaking_obj) != num_strings 
        if speaking_obj > 0 
            JValue.release(speaking_obj) 
        endif 
        speaking_obj = JArray.objectWithSize(num_strings) 
        JValue.retain(speaking_obj)
        JMap.setObj(obj, "speaking_modifiers",speaking_obj) 
    endif 
    i = 0 
    int w = 0 
    while i < count 
        if strings[i] != ""
            JArray.setStr(speaking_obj, w, strings[i]) 
            w += 1 
        endif
        i += 1 
    endwhile
    SetActor(index, akActor)
    Trace("SetPosition", "end index:"+index+" name: "+akActor.GetDisplayName()+" no_orgasm: "+JMap.getInt(obj, "no_orgasm")+" speaking_modifiers: "+JoinJArrayStrToJson(speaking_obj))
Endfunction 

bool Function SetActor(int i, Actor akActor)
    DbgEnter("SetActor", "i:"+i+" "+GetDisplayName(akActor))
    if i < 0
        DbgReturn("SetActor", "False")
        return False
    endif
    if akActor == None 
        DbgReturn("SetActor", "False")
        return False 
    endif
    int obj = position_objs[i]
    JArray.setObj(actors_objs, i, obj)

    StorageUtil.SetIntValue(akActor, storage_obj_key, obj) 
    StorageUtil.SetIntValue(akActor, storage_total_orgasms_key, 0)
    JMap.setStr(obj, "uuid", GetUUID(akActor))
    JMap.setStr(obj, "formid", akActor.GetFormID())
    JMap.setStr(obj, "name", akActor.GetDisplayName())

    int gender = akActor.GetLeveledActorBase().GetSex() ; actorLib.GetGender(akActor)
    DbgMsg("SetActor", "sexlab.GetGender "+akActor.GetDisplayName())
    int gender_sexlab = main.sexlab.GetGender(akActor) 
    DbgMsg("SetActor", "sexlab.GetGender returned "+gender_sexlab)
    int has_penis = 0
    if gender != 1 || (gender_sexlab != 1 && gender_sexlab != 3)
        has_penis = 1
    endif
    int has_pussy = 0
    if gender == 1 || gender_sexlab == 1 || gender_sexlab == 3
        has_pussy = 1
    endif

    int is_hermaphrodiate = 0
    if actorLib.GetTrans(akActor) == 0 
        is_hermaphrodiate = 1
    endif 


    JMap.setInt(obj, "has_penis", has_penis)
    JMap.setInt(obj, "has_pussy", has_pussy)
    JMap.setInt(obj, "is_hermaphrodiate", is_hermaphrodiate)
    JMap.setStr(obj, "creature_description", GetCreatureDescriptions(akActor))

    JMap.setStr(obj,"notice_level","nothing")
    if status == STATUS_ACTIVE
        JMap.setStr(obj,"notice_level","active")
    endif
    JMap.setInt(obj,"total_orgasm",0)
    JMap.setInt(obj,"arousal", -1) 
    DbgMsg("SetActor", "thread.IsVictim "+akActor.GetDisplayName())
    if thread.IsVictim(akActor) 
        JMap.setInt(obj, "victim", 1) 
        JMap.setInt(obj, "assailant", 0) 
    elseif num_victims > 0 
        JMap.setInt(obj, "victim", 0) 
        JMap.setInt(obj, "assailant", 1) 
    else 
        JMap.setInt(obj, "victim", 0) 
        JMap.setInt(obj, "assailant", 0) 
    endif 

    DbgMsg("SetActor", "thread.ActorAlias "+akActor.GetDisplayName())
    int enjoyment = 0
    if status == STATUS_ACTIVE
        sslActorAlias actorAlias = thread.ActorAlias(akActor) 
        ;if Game.GetModByName("SLSO.esp") != 255
            ;enjoyment = actorAlias.Getfull_enjoyment() 
        ;else 
        ;    int enjoyment = actorAlias.GetEnjoyment() 
        ;endif 

        if actorAlias != None
            enjoyment = actorAlias.GetEnjoyment() 
        endif 
    endif 
    JMap.setInt(obj, "enjoyment", enjoyment)

    if main.handler_dom.IsDOMSlave(akActor)
        JMap.setInt(obj, "dom_slave", 1)
    else
        JMap.setInt(obj, "dom_slave", 0)
    endif


    DbgReturn("SetActor", "True")
    return True
EndFunction

String Function GetUUID(Actor akActor)
    DbgEnter("GetUUID", "akActor:"+GetDisplayName(akActor))
    if akActor == None
        DbgReturn("GetUUID", "")
        return ""
    endif
    String uuid = UuidToDecimalString(SkyrimNetApi.GetEntityUUID(akActor))
    DbgReturn("GetUUID", uuid)
    return uuid
EndFunction

int Function GetObjFromActor(Actor akActor) 
    DbgEnter("GetObjFromActor", "akActor:"+GetDisplayName(akActor))
    DbgReturn("GetObjFromActor", "StorageUtil.GetIntValue(akActor, storage_obj_key, 0)")
    return StorageUtil.GetIntValue(akActor, storage_obj_key, 0) 
EndFunction 

bool Function UpdateActor(int i , Actor akActor) 
    DbgEnter("UpdateActor", "i:"+i+" akActor:"+GetDisplayName(akActor))
    bool changed = False 
    int obj = position_objs[i]
    ; Slot changed if this actor is not bound to this position's metadata obj
    if GetObjFromActor(akActor) != position_objs[i] 
        SetActor(i, akActor) 
        changed = True 
        int total_orgasms = StorageUtil.GetIntValue(akActor, storage_total_orgasms_key, 0) 
        SetTotalOrgasms(akActor, total_orgasms)
        obj = position_objs[i]
    elseif status == STATUS_ACTIVE && obj > 0
        JMap.setStr(obj, "notice_level", "active")
    endif
    int wearing_strapon = 0
    if thread.IsUsingStrapon(akActor)
        wearing_strapon = 1
    endif 
    if obj > 0
        JMap.setInt(obj, "wearing_strapon", wearing_strapon)
    endif

    DbgReturn("UpdateActor", "changed")
    return changed 
EndFunction 

Function AlignActors() 
    DbgEnter("AlignActors")
    DbgMsg("AlignActors", "thread.positions.length")
    int size = thread.positions.length 
    EnsureActorArraysLargeEnough(size) 
    int i = 0 
    bool changed = False 
    if size != JArray.count(actors_objs)
        JValue.release(actors_objs)
        actors_objs = JArray.objectWithSize(size)
        JMap.setObj(thread_obj, "actors", actors_objs)
        JValue.retain(actors_objs)
        changed = True
    endif
    while i < size
        if UpdateActor(i, thread.positions[i]) 
            changed = True 
        endif 
        i += 1 
    endwhile 
    ; Relink every slot: UpdateActor only writes actors_objs when an actor's binding
    ; changes, so after a resize (recreated array) unchanged slots would stay null.
    i = 0 
    while i < size 
        JArray.setObj(actors_objs, i, position_objs[i]) 
        i += 1 
    endwhile 
    ; Do not tear down leftover slots here — only Release owns teardown.

    ; Positions may have changed; reconcile victim faction so departed actors are cleared.
    ReconcileVictimFactions()

    if changed 
        SetNames()
    endif 
    DbgEnd("AlignActors")
EndFunction 

; ------------------------------------
; Get Names 
; ------------------------------------

Function SetNames() 
    DbgEnter("SetNames")
    DbgMsg("SetNames", "thread.positions")
    actor_names = JoinActors(thread.positions)
    victim_names = GetNames("victim")
    assailant_names = GetNames("assailant")
    hermaphrodiate_names = GetNames("is_hermaphrodiate") 
    strapon_names = GetNames("wearing_strapon")
    DbgEnd("SetNames")
EndFunction 

String Function GetNames(String key_) 
    DbgEnter("GetNames", "key_:"+key_)
    String names = ""
    int matched = 0
    int i = 0 
    int num_actors = thread.positions.length
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
    DbgReturn("GetNames", "names")
    return names 
EndFunction

String Function GetCreatureDescriptions(Actor akActor) 
    DbgEnter("GetCreatureDescriptions", "akActor:"+GetDisplayName(akActor))
    String desc = "" 
    Race r = akActor.GetRace() 
    if sslCreatureAnimationSlots.HasRaceType(r) 
        String name = akActor.GetDisplayName()
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
    DbgReturn("GetCreatureDescriptions", "desc:"+desc)
    return desc 
EndFunction

; --------------------------------------------
; Get Functions 
; --------------------------------------------

int Function GetTotalOrgasms(Actor akActor)
    DbgEnter("GetTotalOrgasms", "akActor:"+GetDisplayName(akActor))
    DbgReturn("GetTotalOrgasms", "StorageUtil.GetIntValue(akActor, storage_total_orgasms_key, 0)")
    return StorageUtil.GetIntValue(akActor, storage_total_orgasms_key, 0) 
EndFunction 

Function SetTotalOrgasms(Actor akActor, int total_orgasms)
    DbgEnter("SetTotalOrgasms", "akActor:"+GetDisplayName(akActor)+" total_orgasms:"+total_orgasms)
    if akActor == None 
        Trace("SetTotalOrgasms","akActor is None")
        DbgReturn("SetTotalOrgasms", "void")
        return 
    endif 
    StorageUtil.SetIntValue(akActor, storage_total_orgasms_key, total_orgasms) 
    int obj = GetObjFromActor(akActor)
    if obj > 0
        JMap.setInt(obj, "total_orgasm", total_orgasms)
    endif 
    DbgEnd("SetTotalOrgasms")
EndFunction 

; Builds the prompt-gate clause and updates the actor's orgasm total.
; total_orgasms < 0: +1 from current. total_orgasms >= 0: set absolute (SLSO).
; Tentacles tag: append flavor on the orgasming actor only (do not force-orgasm all positions).
String Function GetIsOrgasming(Actor akActor, int total_orgasms = -1)
    DbgEnter("GetIsOrgasming", "akActor:"+GetDisplayName(akActor)+" total_orgasms:"+total_orgasms)
    if akActor == None
        Trace("GetIsOrgasming", "Is None")
        return ""
    endif
    if total_orgasms < 0
        SetTotalOrgasms(akActor, GetTotalOrgasms(akActor) + 1)
    else
        SetTotalOrgasms(akActor, total_orgasms)
    endif
    int recorded = GetTotalOrgasms(akActor)
    DbgMsg("GetIsOrgasming", GetDisplayName(akActor)+" total_orgasms:"+recorded) ; debug-total_orgasms
    String name = akActor.GetDisplayName()
    String msg = name+" is orgasming. "
    if recorded > 1
        msg = name+" is orgasming. again. "
    endif
    if thread != None && thread.Animation != None && thread.Animation.HasTag("tentacles")
        msg += "The tentacles is orgasming and flooding cum both inside and outside. "
    endif
    DbgReturn("GetIsOrgasming", msg)
    return msg
EndFunction

Function SetThread(sslThreadController _thread) 
    if _thread != None
        DbgEnter("SetThread", "tid:"+_thread.tid)
    else
        DbgEnter("SetThread")
    endif
    thread = _thread
    DbgEnd("SetThread")
EndFunction 
sslThreadController Function GetThread()
    DbgEnter("GetThread")
    if thread == None 
        Trace("GetThread","Thread is None | "+GetString())
    endif 
    DbgReturn("GetThread", "thread")
    return thread
EndFunction

; Prefer Initialize(..., _is_generic=true). This only sets true; never clear is_generic.
Function SetGeneric() 
    is_generic = True 
EndFunction 
bool Function IsGeneric() 
    DbgReturn("IsGeneric", "is_generic")
    return is_generic
EndFunction 

; --------------------------------------------
; Get a Status message for the sl_scene (start, are, finish) 
; --------------------------------------------
String Function GetIntentMessage(int intent_stage = -1) 
    DbgEnter("GetIntentMessage", "intent_stage:"+intent_stage)
    String msg = "are "+intent 
    if intent_stage == INTENT_STAGE_START 
        msg = "start "+intent
    elseif intent_stage == INTENT_STAGE_END 
        msg = "finish "+intent
    endif 
    if num_victims > 0
        DbgReturn("GetIntentMessage", "with victims")
        return assailant_names+" "+msg+" "+victim_names+"."
    endif 
    DbgReturn("GetIntentMessage", "actors only")
    return actor_names+" "+msg+"."
EndFunction 
    
bool Function GetThreadActive() 
    DbgEnter("GetThreadActive")
    if thread == None 
        DbgReturn("GetThreadActive", "false")
        return false 
    endif 
    DbgMsg("GetThreadActive", "thread.GetState()")
    String s = (thread as sslThreadModel).GetState() 
    DbgMsg("GetThreadActive", "thread.GetState() returned "+s)
    if s != "animating" && s != "prepare"
        Trace("GetThreadActive", "thread is not animating or prepare `"+s+"'")
        DbgReturn("GetThreadActive", "false")
        return false 
    endif 
    ; Ghost / stuck slot: state still animating but no actors left
    if !thread.Positions || thread.Positions.length == 0
        Trace("GetThreadActive", "thread has no positions")
        DbgReturn("GetThreadActive", "false")
        return false
    endif
    DbgReturn("GetThreadActive", "true")
    return true 
EndFunction

; --------------------------------------------
; Animation Event Handlers 
; --------------------------------------------
Function AnimationStart()
    description_last = ""
    ; Re-entrant mid-scene AnimationStart must not force STATUS_SETUP (would re-run
    ; first-start/initiator path) or clear orgasm_messages_set while leaving non-empty
    ; slots (flush skips; Combined will not refill). Only reset orgasm stash on first start.
    if status != STATUS_ACTIVE
        status = STATUS_SETUP
        if orgasm_messages
            int m = 0
            while m < orgasm_messages.length
                orgasm_messages[m] = ""
                m += 1
            endwhile
        endif
        orgasm_messages_set = false
    endif
    DbgEnter("AnimationStart")
    AlignActors() 
    manager.SaveThreadsJson() 
    String msg = GetIntentMessage(INTENT_STAGE_START) + GetDescription()
    RegisterEvent("sexlab update", msg, sender, receiver) 
    DbgEnd("AnimationStart", "msg:"+msg+" sender:"+GetDisplayName(sender)+" receiver:"+GetDisplayName(receiver))
EndFunction

Function StageStart() 
    DbgEnter("StageStart")
    AlignActors() 
    manager.SaveThreadsJson() 
    if SexLab == None 
        Trace("StageStart","sexlab is None | actors:"+actor_names)
        DbgReturn("StageStart", "void")
        return 
    endif
    if thread == None 
        Trace("StageStart","thread is None | actors:"+actor_names)
        DbgReturn("StageStart", "void")
        return 
    endif

    String orgasm_narration = OrgasmMessagesToNarration()
    String desc = GetDescription()

    ; Send a DN if its a start and includes a player
    ; if not player send DN if allowed by cool off 
    ; GetDescription: stage JSON, else tag fallback (raw GetStageDescription alone leaves initiates: empty)
    if status != STATUS_ACTIVE
        status = STATUS_ACTIVE
        String narration = desc + orgasm_narration
        if initiator != None
            narration = initiator.GetDisplayName()+" initiates: "+desc
            narration += orgasm_narration
        endif
        if orgasm_narration != ""
            RegisterEvent("sexlab update", orgasm_narration, sender, receiver)
        else 
            if has_player
                DirectNarration(narration, sender, receiver) 
            else
                DirectNarration_Optional("start", narration, sender, receiver) 
            endif
        endif 
    ; Late Dom custom msgs may arrive after Combined; flush any leftovers before send/Release
    else
        String narration = ""
        bool change_scene = false
        if desc != "" && description_last != ""
            if desc != description_last
                ; Scene-change is prefixed; orgasm block is appended from orgasm_narration below.
                narration = "Scene changes to "+desc
                change_scene = true
            else 
                desc = ""
            endif 
        endif 
        if orgasm_narration != ""
            if change_scene 
                RegisterEvent("change", narration, sender, receiver)
            endif 
        else 
            if !change_scene
                ContinueActivity(sender, receiver, True)
            else
                DirectNarration_optional("ChangePosition", narration, sender, receiver) 
            endif 
        endif 
    endif 

    if orgasm_narration != ""
        thread.UpdateTimer(orgasm_delay)
        if has_player
            DirectNarration(orgasm_narration, sender, receiver, purge_dialogue=True)
        else
            DirectNarration_optional("orgasm", orgasm_narration, sender, receiver)
        endif 
    endif 
    ; Only advance description_last when desc is a real new description; unchanged
    ; path sets desc="" and must not wipe the prior value (would skip later Scene changes to).
    if desc != ""
        description_last = desc
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
    DbgEnd("StageStart")
EndFunction

Function AnimationEnd(Actor speaker=None, String style="silently") 
    DbgEnter("AnimationEnd", "speaker:"+GetDisplayName(speaker)+" style:"+style)
    AlignActors() 
    manager.SaveThreadsJson()

    if SexLab != None && thread != None 
        Trace("AnimationEnd","thread id:"+thread.tid+" status:"+thread.GetState())
        DbgMsg("AnimationEnd", "thread.GetState()="+thread.GetState())
        DbgMsg("AnimationEnd", "SexLab as sslSystemConfig")
        sslSystemConfig config = (SexLab as Quest) as sslSystemConfig

        ; Leftover Combined orgasm stash → event before purge (not ongoing-activity DN).
        ; Tentacles flavor is appended inside GetIsOrgasming when the animation is tagged.
        String orgasm_narration = OrgasmMessagesToNarration()
        if orgasm_narration != ""
            RegisterEvent("orgasm", orgasm_narration, sender, receiver)
        endif

        ; Post-activity afterglow (SeparateOrgasms); not ongoing sexual activity
        String afterglow = ""
        if config.SeparateOrgasms
            int[] orgasm_expected = stages.GetOrgasmExpected(thread)
            int j = thread.positions.length - 1 
            while 0 <= j 
                String name = JMap.getStr(position_objs[j], "name") 
                int total_orgasms = JMap.getInt(position_objs[j], "total_orgasm")
                if total_orgasms < 1 
                    if orgasm_expected.length > j && orgasm_expected[j] == 1
                        afterglow += name+" failed to orgasm. "
                    endif
                elseif total_orgasms < 2
                    afterglow += name+"'s body glows in post orgasm. "
                else 
                    afterglow += name+"'s body is recovering from "+total_orgasms+" orgasms. "
                endif 
                j -= 1 
            endwhile
        endif 

        ; Mirror AnimationStart: "A and B finish <intent>."
        String end_message = GetIntentMessage(INTENT_STAGE_END)
        if afterglow != ""
            end_message += " "+afterglow
        endif
        int d = 0
        while d < thread.positions.length
            String dbg_name = JMap.getStr(position_objs[d], "name")
            int dbg_total = JMap.getInt(position_objs[d], "total_orgasm")
            DbgMsg("AnimationEnd", dbg_name+" total_orgasms:"+dbg_total) ; debug-total_orgasms
            d += 1
        endwhile
        DbgMsg("AnimationEnd", "end_message:"+end_message) ; debug-total_orgasms
        if has_player
            DirectNarration(end_message, sender, receiver, purge_dialogue=True)
        else
            DirectNarration_optional("end", end_message, sender, receiver)
        endif 
    endif 

    Release() 
    DbgEnd("AnimationEnd")
EndFunction 

; --------------------------------------------
; Orgasm Handlers
; --------------------------------------------

; --------------------------------------------
; Captures the orgasm message sent just before the last stage 
; We have a race condition where other HookOrgasmStart listeners 
; may send their messages before we get ours.
; We will there for store all the orgasm messages 
; and send them at the start of the next stage. 
; --------------------------------------------
Function OrgasmCombined()
    DbgEnter("OrgasmCombined")
    AlignActors() 
    int[] orgasm_expected = stages.GetOrgasmExpected(thread)
    int i = 0
    int num_actors = thread.positions.length
    EnsureActorArraysLargeEnough(num_actors)
    while i < num_actors
        int obj = position_objs[i] 
        bool no_orgasm = JMap.getInt(obj, "no_orgasm") == 1
        bool is_dom_slave = JMap.getInt(obj,"dom_slave") == 1

        if orgasm_expected[i] == 1 && !no_orgasm && !is_dom_slave && orgasm_messages[i] == ""
            orgasm_messages_set = true
            orgasm_messages[i] = GetIsOrgasming(thread.positions[i])
        endif 
        i += 1
    endwhile
    if orgasm_messages_set && thread != None
        thread.UpdateTimer(4.0)
    endif

    DbgEnd("OrgasmCombined")
EndFunction

; Used for SLSO.esp orgasm handling (invoked from Manager as a Function call)
Function OrgasmIndividual(Actor akActor, int full_enjoyment, int num_orgasms)
    DbgEnter("OrgasmIndividual", "akActor:"+GetDisplayName(akActor)+" full_enjoyment:"+full_enjoyment+" num_orgasms:"+num_orgasms)
    if akActor == None 
        Trace("OrgasmIndividual","akActor is None") 
        DbgReturn("OrgasmIndividual", "void")
        return 
    endif 

    String name = GetDisplayName(akActor) 
    int obj = GetObjFromActor(akActor) 
    if obj > 0 
        if JMap.getInt(obj, "no_orgasm") == 1 
            Trace("OrgasmIndividual",name+" shouldn't orgasm")
            DbgReturn("OrgasmIndividual", "void")
            return 
        endif 
        JMap.setInt(obj, "enjoyment", full_enjoyment) 
    endif 

    ; Prompt gate + total via GetIsOrgasming (SLSO absolute count).
    String msg = GetIsOrgasming(akActor, num_orgasms)

    int num_actors = thread.positions.length
    int i = 0
    while i < num_actors
        if thread.positions[i] != akActor
            msg += " "+thread.positions[i].GetDisplayName()+" is not orgasming."
        endif 
        i += 1 
    endwhile 
    OrgasmHelper(akActor, msg)
    DbgEnd("OrgasmIndividual")
EndFunction

Function OrgasmCustom(Actor akActor, String msg)
    DbgEnter("OrgasmCustom", "akActor:"+GetDisplayName(akActor)+" msg:"+msg)
    sslSystemConfig config = (SexLab as Quest) as sslSystemConfig

    if StringUtil.Find(msg, " is orgasming.") < 0 
        msg += GetIsOrgasming(akActor)
    else
        ; Manager/DOM already appended the substring; still count this orgasm.
        GetIsOrgasming(akActor)
    endif

    if config.SeparateOrgasms
        OrgasmHelper(akActor, msg)
    else 
        EnsureActorArraysLargeEnough(thread.positions.length)
        int i = 0 
        while i < thread.positions.length && thread.positions[i] != akActor
            i += 1
        endwhile
        if i < thread.positions.length
            orgasm_messages_set = true
            orgasm_messages[i] = msg
            if thread != None
                thread.UpdateTimer(4.0)
            endif
        endif
    endif
    DbgEnd("OrgasmCustom")
EndFunction

Function OrgasmHelper(Actor akActor, String msg)
    DbgEnter("OrgasmHelper", "akActor:"+GetDisplayName(akActor)+" msg:"+msg)
    AlignActors()
    Actor cum_catcher = None
    String cum_catcher_name = "(None)"

    int gender = sexlab.GetGender(akActor) 
    DbgMsg("OrgasmHelper", "sexlab.GetGender returned "+gender)
    bool has_penis = gender == 0 || gender == 2
    if has_penis 
        ; Generate the orgasm message
        int i = 0
        int num_actors = thread.positions.length
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
    DbgEnd("OrgasmHelper")
EndFunction

String Function OrgasmMessagesToNarration()
    String narration = ""
    bool orgasm_happened = false
    bool ejaculation_happened = false
    int num_actors = thread.positions.length
    if orgasm_messages_set
        orgasm_messages_set = false
        int k = 0
        int[] orgasm_expected = stages.GetOrgasmExpected(thread)
        int num_orgasmers = 0 
        while k < num_actors && k < orgasm_messages.length
            int obj = JArray.getObj(actors_objs, k)
            String name = JMap.getStr(obj, "name")
            if orgasm_messages[k] != ""
                num_orgasmers += 1
                orgasm_happened = true
                ; Totals already bumped when GetIsOrgasming built the stashed clause.
                if JMap.getInt(obj, "has_penis") == 1 
                    ejaculation_happened = true
                endif 
                narration += orgasm_messages[k]
                orgasm_messages[k] = ""
            elseif orgasm_expected.length > k && orgasm_expected[k] == 1 && JMap.getInt(obj, "dom_slave") == 1
                ; Dom Combined fallback: custom raced past stash but totals already bumped.
                if GetTotalOrgasms(thread.positions[k]) > 0 || JMap.getInt(obj, "total_orgasm") > 0
                    num_orgasmers += 1
                    orgasm_happened = true
                    if JMap.getInt(obj, "has_penis") == 1
                        ejaculation_happened = true
                    endif
                    narration += name+" is orgasming. "
                else
                    narration += main.handler_dom.HandleOrgasmDenied(thread.positions[k])
                endif
            endif 
            k += 1
        endwhile
        if num_orgasmers > 0 && num_orgasmers < num_actors
            narration += "Only listed actors started orgasming right now. "
        endif
    endif 

    if ejaculation_happened
        int i = 0
        while i < num_actors 
            String cum_msg = AddCum(i, thread.positions[i], thread.positions[i].GetDisplayName())
            if cum_msg != ""
                if narration != "" && StringUtil.GetNthChar(narration, StringUtil.GetLength(narration) - 1) != " "
                    narration += " "
                endif
                narration += cum_msg
            endif
            i += 1 
        endwhile 
    endif 

    if orgasm_happened
        return narration
    else 
        return ""
    endif
EndFunction

;----------------------------------------------------
; Add Cum
;----------------------------------------------------
String Function AddCum(int position, Actor akActor, String name)
    ; Add cum overlay 
    DbgEnter("AddCum", "position:"+position+" akActor:"+GetDisplayName(akActor)+" name:"+name)
    DbgMsg("AddCum", "thread.Animation")
    sslBaseAnimation anim = thread.Animation
    DbgMsg("AddCum", "anim.GetCumId position="+position+" stage="+thread.stage)
    int CumId = anim.GetCumId(position, thread.stage)

    ; -1 - no gender 
    ;  0 - Male (also the default values if the actor is not existing)
    ;  1 - Female
    int gender = akActor.GetLeveledActorBase().GetSex()
    ; 0 - male
    ; 1 - female 
    ; 2 - male creature 
    ; 3 - female creature 
    DbgMsg("AddCum", "sexlab.GetGender "+akActor.GetDisplayName())
    int gender_sexlab = sexlab.GetGender(akActor)
    DbgMsg("AddCum", "sexlab.GetGender returned "+gender_sexlab)
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
                places = "ass"
            endif 
        elseif cumId == sslObjectFactory.OralAnal()
            places = "mouth and ass"
        elseif cumId == sslObjectFactory.VaginalOralAnal()
            if has_pussy
                places = genital+", mouth, and ass"
            else
                places = "mouth and ass"
            endif 
        endif
    endif 

    if places != ""
        DbgReturn("AddCum", "cum message")
        return name+"'s "+places+" is dripping with warm sticky cum. "
    endif 
    DbgReturn("AddCum", "empty")
    return "" 
EndFunction  

; --------------------------------------------
; --------------------------------------------
String Function GetDescription()
    DbgEnter("GetDescription")
    String desc = stages.GetStageDescription(thread)
    if desc == "" 
        desc = GetDescriptionFromTags()
    endif 
    return desc 
EndFunction 

String Function GetThreadJson(Actor speaker) 
    DbgEnter("GetThreadJson", "speaker:"+GetDisplayName(speaker))
    GetThreadObj(speaker) 
    String json = SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(thread_obj) 
    DbgReturn("GetThreadJson", "json")
    return json 
EndFunction 

int Function GetThreadObj(Actor speaker)
    DbgEnter("GetThreadObj", "speaker:"+GetDisplayName(speaker))
    alignactors()

    float distance = 0.0
    bool los = true 
    String speaker_name = ""
    if speaker == None
        ; No viewing speaker: treat as present/close so prompts do not gate on LOS.
        distance = 1.0
        los = true
        speaker_name = "none"
    else
        los = false 
    endif 

    int i = 0
    int num_actors = thread.positions.length
    bool actor_changed = false 
    while i < num_actors 
        if speaker != None && thread.positions[i] == speaker 
            los = true 
        endif 
        if updateactor(i, thread.positions[i]) 
            actor_changed = true 
        endif 
        i += 1 
    endwhile 
    if actor_changed
        setnames() 
    endif 

    if speaker != None
        speaker_name = speaker.GetDisplayName()
        if !los
            distance = 0.0142875*speaker.getdistance(thread.positions[0])
            los = speaker.haslos(thread.positions[0]) 
        endif 
    endif 


    jmap.setint(thread_obj, "active", getthreadactive() as int ) 
    jmap.SetStr(thread_obj, "status",status) 
    jmap.SetStr(thread_obj, "description", getdescription())
    jmap.SetStr(thread_obj, "style", style)
    jmap.setStr(thread_obj, "speaker_name", speaker_name)
    jmap.SetFlt(thread_obj, "speaker_distance", distance)
    jmap.setint(thread_obj, "speaker_los", los as int)

    int names_arr = jarray.object()
    int victims_arr = jarray.object()
    i = 0
    while i < num_actors
        Actor akActor = thread.positions[i]
        jarray.addstr(names_arr, akActor.getdisplayname())
        dbgmsg("GetThreadObj", "thread.isvictim "+akActor.getdisplayname())
        if thread.isvictim(akActor)
            jarray.addstr(victims_arr, akActor.getdisplayname())
        endif
        i += 1
    endwhile
    jmap.setobj(thread_obj, "names", names_arr)
    jmap.setobj(thread_obj, "victims", victims_arr)
    jmap.SetStr(thread_obj, "location", getlocation())

    dbgreturn("getThreadobj", "thread_obj")
    return thread_obj
EndFunction

int Function GetVictimsNamesJsonObj()
    DbgEnter("GetVictimsNamesJsonObj")
    int victimNamesMap = JMap.object()
    int i = 0
    int num_actors = thread.positions.length
    while i < num_actors
        Actor akActor = thread.positions[i]
        if thread.IsVictim(akActor)
            JMap.setStr(victimNamesMap, akActor.GetDisplayName(), akActor.GetDisplayName())
        endif
        i += 1
    endwhile

    DbgReturn("GetVictimsNamesJsonObj", "victimNamesMap")
    return victimNamesMap
EndFunction

String Function GetLocation()

    DbgEnter("GetLocation")
    DbgMsg("GetLocation", "thread.BedTypeId")
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

    ; Natural phrasing (with preposition/article) parallel to on_furniture, so the
    ; location reads as e.g. "on a table" instead of the bare tag "Table".
    String[] on_furniture_phrase = new String[21]
    on_furniture_phrase[0] = "on a table"
    on_furniture_phrase[1] = "on a low table"
    on_furniture_phrase[2] = "on a table"
    on_furniture_phrase[3] = "on a pole"
    on_furniture_phrase[4] = "against a wall"
    on_furniture_phrase[5] = "on a horse"
    on_furniture_phrase[6] = "in a pillory"
    on_furniture_phrase[7] = "in a pillory"
    on_furniture_phrase[8] = "in a cage"
    on_furniture_phrase[9] = "on a haybale"
    on_furniture_phrase[10] = "on an X-cross"
    on_furniture_phrase[11] = "on a wooden pony"
    on_furniture_phrase[12] = "at an enchanting table"
    on_furniture_phrase[13] = "at an alchemy table"
    on_furniture_phrase[14] = "on a fuck machine"
    on_furniture_phrase[15] = "on a chair"
    on_furniture_phrase[16] = "on a wheel"
    on_furniture_phrase[17] = "on a Dwemer chair"
    on_furniture_phrase[18] = "on a necromancer chair"
    on_furniture_phrase[19] = "on a throne"
    on_furniture_phrase[20] = "in a stockade"

    DbgMsg("GetLocation", "thread.Animation")
    sslBaseAnimation anim = thread.Animation
    int i = 0
    bool found = false
    while i < on_furniture.Length && !found
        if anim.HasTag(on_furniture[i])
            loc = on_furniture_phrase[i]
            found = true
        endif
        i += 1
    endwhile

    if !found 
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

    DbgReturn("GetLocation", "loc")
    return loc+" "
EndFunction 


bool Function SexLab_Thread_LOS(Actor akActor)
    DbgEnter("SexLab_Thread_LOS", "akActor:"+GetDisplayName(akActor))
    if thread == None 
        DbgReturn("SexLab_Thread_LOS", "True")
        return True 
    endif 
    int i = 0
    int num_actors = thread.positions.length
    while i < num_actors 
        if akActor == thread.positions[i] || akActor.HasLOS(thread.positions[i])
            DbgReturn("SexLab_Thread_LOS", "true")
            return true
        endif 
        i += 1
    endwhile 
    DbgReturn("SexLab_Thread_LOS", "false")
    return false
endFunction 

String Function GetTagsString(sslBaseAnimation anim) global
    String[] _tags = anim.GetRawTags()
    int num_tags = _tags.length 
    int i = 0 
    String tags_string = ""
    while i < num_tags
        tags_string += _tags[i]
        if i < num_tags - 1
            tags_string += ", "
        endif 
        i += 1
    endwhile 
    return tags_string
EndFunction 


String Function GetDescriptionFromTags()
    ; Get the thread that triggered this event via the thread id
    sslBaseAnimation anim = thread.Animation
    ; Get our list of actors that were in this animation thread.
    Actor[] positions = thread.positions
    int num_actors = positions.length
    String sub_name = ""
    String dom_name = ""
    if num_actors > 0 && positions[0] != None
        sub_name = positions[0].GetDisplayName()
    endif
    if num_actors > 1 && positions[1] != None
        dom_name = positions[1].GetDisplayName()
    endif

    String buffer

    If anim.HasTag("aggressive") && dom_name != ""
        buffer = dom_name + " is sexually assaulting " + sub_name + ". "
    Else
        buffer = ""
    EndIf
    buffer += sub_name + " is"

    If anim.HasTag("rough")
        buffer += " roughly"
    ElseIf anim.HasTag("loving")
        buffer += " lovingly"
    EndIf

    If anim.HasTag("cowgirl")
        buffer += ", cowgirl position,"
    ElseIf anim.HasTag("missionary")
        buffer += ", missionary position,"
    ElseIf anim.HasTag("kneeling")
        buffer += ", kneeling position,"
    ElseIf anim.HasTag("standing")
        buffer += ", standing position,"
    EndIf

    If anim.HasTag("anal")
        buffer += " having anal sex with"
    ElseIf anim.HasTag("assjob")
        buffer += " having an assjob by"
    ElseIf anim.HasTag("boobjob")
        buffer += " giving a boobjob to"
    ElseIf anim.HasTag("thighjob")
        buffer += " giving a thighjob to"
    ElseIf anim.HasTag("vaginal")
        buffer += " having vaginal sex with"
    ElseIf anim.HasTag("fisting")
        buffer += " having her pussy fisted by"
    ElseIf anim.HasTag("oral") || anim.HasTag("blowjob") || anim.HasTag("cunnilingus")
        buffer += " giving a blowjob to"
    ElseIf anim.HasTag("spanking")
        buffer += " being spanked by"
    ElseIf anim.HasTag("masturbation")
        buffer += " masturbating furiously"
    ElseIf anim.HasTag("fingering")
        buffer += " being fingered by"
    ElseIf anim.HasTag("footjob")
        buffer += " giving a footjob to"
    ElseIf anim.HasTag("handjob")
        buffer += " giving a handjob to"
    ElseIf anim.HasTag("kissing")
        buffer += " kissing with"
    ElseIf anim.HasTag("headpat")
        buffer += " having head patted by"
    ElseIf anim.HasTag("hugging")
        buffer += " hugging"
    Else
        buffer += " having sex with"
        Trace("GetDescriptionFromTags", "no matching animation tag")
    EndIf

    If num_actors > 1 && dom_name != ""
        buffer += " " + dom_name
    EndIf
    buffer += ".\n\n"
    return buffer
endFunction

Function SetStyleDialog()
    DbgEnter("SetStyleDialog")
    String style_old = style
    parent.SetStyleDialog()

    if style_old != style
        String name = GetDisplayName(sender)
        if has_player
            name = GetDisplayName(game.GetPlayer())
        endif 
        DirectNarration(name+" changes from '"+style_old+"' to '"+style+"'", sender, receiver)
    endif 
    DbgReturn("SetStyleDialog")
endFunction