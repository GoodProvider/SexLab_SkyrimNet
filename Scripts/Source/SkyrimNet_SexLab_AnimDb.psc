Scriptname SkyrimNet_SexLab_AnimDb extends Quest

import JContainers

SkyrimNet_SexLab_Main Property main Auto
SexLabFramework Property sexlab Auto

; Native bindings (SKSE)
Function AnimDb_Open() global native
int Function AnimDb_BeginSync(Bool force_rebuild) global native
int Function AnimDb_PushAnimBatch(String json) global native
Bool Function AnimDb_EndSync() global native
String Function AnimDb_QueryTopNAnims(String filter_json, int n) global native
String Function AnimDb_QueryTopNTags(String filter_json, int n) global native
int Function AnimDb_TotalEnabled() global native
int Function AnimDb_TotalCount() global native
String Function AnimDb_GetByRegistry(String registry) global native
String Function AnimDb_GetStageDescription(String registry, int stage) global native
String Function AnimDb_SubstituteActors(String desc, String actors_json) global native
Bool Function AnimDb_SaveAnimLocal(String registry, String json) global native

int BATCH_SIZE = 48
int walk_index = 0
int walk_source = 0 ; 0 human, 1 creature
int walk_total = 0
Bool walk_active = False
Bool walk_force = False
String batch_json = ""

; 0 idle, 1 waiting for SexLab, 2 walking slots
int sync_phase = 0
int walk_slots_human = 0
int walk_slots_creature = 0
int walk_slots_total = 0
float progress_last_time = 0.0

Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_AnimDb", func, msg)
    if notification
        Debug.Notification(msg)
    endif
EndFunction

Function Setup()
    if main == None
        main = (self as Quest) as SkyrimNet_SexLab_Main
    endif
    if sexlab == None && main
        sexlab = main.sexlab
    endif
    AnimDb_Open()
EndFunction

; Kick cooperative sync after SexLab is ready.
Function StartSync(Bool force_rebuild=False)
    if sync_phase != 0
        Trace("StartSync", "already walking, requesting restart force="+force_rebuild)
        walk_force = force_rebuild
        return
    endif
    if sexlab == None
        Trace("StartSync", "sexlab is None", True)
        return
    endif
    walk_force = force_rebuild
    if !sexlab.Enabled
        sync_phase = 1
        walk_active = True
        Trace("StartSync", "SkyrimNet_SexLab is waiting for SexLab", True)
        RegisterForModEvent("SexLabEnabled", "OnSexLabEnabled")
        RegisterForSingleUpdate(1.0)
        return
    endif
    BeginWalk()
EndFunction

Function BeginWalk()
    UnregisterForModEvent("SexLabEnabled")
    walk_slots_human = 0
    walk_slots_creature = 0
    if sexlab.AnimSlots
        walk_slots_human = sexlab.AnimSlots.Slotted
    endif
    sslAnimationSlots creature_slots = sexlab.CreatureSlots as sslAnimationSlots
    if creature_slots
        walk_slots_creature = creature_slots.Slotted
    endif
    walk_slots_total = walk_slots_human + walk_slots_creature
    if !walk_force
        int db_count = AnimDb_TotalCount()
        if db_count == walk_slots_total
            walk_active = False
            sync_phase = 0
            Trace("BeginWalk", "skip reload db_count="+db_count+" registered="+walk_slots_total)
            return
        endif
    endif
    sync_phase = 2
    walk_active = True
    walk_source = 0
    walk_index = 0
    walk_total = 0
    progress_last_time = Utility.GetCurrentRealTime()
    AnimDb_BeginSync(walk_force)
    Trace("BeginWalk", "SkyrimNet_SexLab is loading animations", True)
    RegisterForSingleUpdate(0.05)
EndFunction

Function RebuildDatabase()
    StartSync(True)
EndFunction

Event OnSexLabEnabled()
    if sync_phase == 1
        BeginWalk()
    endif
EndEvent

Event OnUpdate()
    if sync_phase == 1
        if sexlab && sexlab.Enabled
            BeginWalk()
        else
            RegisterForSingleUpdate(1.0)
        endif
        return
    endif
    if sync_phase != 2
        return
    endif
    sslAnimationSlots slots = None
    if walk_source == 0
        slots = sexlab.AnimSlots
    else
        slots = sexlab.CreatureSlots as sslAnimationSlots
    endif
    if !slots
        FinishSourceOrDone()
        return
    endif
    int slotted = slots.Slotted
    int batch_count = 0
    String json = "["
    Bool first = True

    while walk_index < slotted && batch_count < BATCH_SIZE
        sslBaseAnimation anim = slots.GetBySlot(walk_index)
        walk_index += 1
        if anim && anim.Registered
            String piece = BuildAnimJson(anim, walk_source)
            if piece != ""
                if !first
                    json += ","
                endif
                json += piece
                first = False
                batch_count += 1
                walk_total += 1
            endif
        endif
    endwhile
    json += "]"

    if batch_count > 0
        AnimDb_PushAnimBatch(json)
    endif

    float now = Utility.GetCurrentRealTime()
    if now - progress_last_time >= 5.0
        progress_last_time = now
        int done = walk_index
        if walk_source == 1
            done += walk_slots_human
        endif
        int pct = 0
        if walk_slots_total > 0
            pct = done * 100 / walk_slots_total
        endif
        if pct > 99
            pct = 99
        endif
        Trace("OnUpdate", "SkyrimNet_SexLab is "+pct+"% finished", True)
    endif

    if walk_index >= slotted
        FinishSourceOrDone()
    else
        RegisterForSingleUpdate(0.01)
    endif
EndEvent

Function FinishSourceOrDone()
    if walk_source == 0
        walk_source = 1
        walk_index = 0
        RegisterForSingleUpdate(0.01)
        return
    endif
    AnimDb_EndSync()
    walk_active = False
    sync_phase = 0
    Trace("FinishSourceOrDone", "total_pushed="+walk_total)
    Trace("FinishSourceOrDone", "SkyrimNet_SexLab is ready", True)
    if walk_force
        ; allow a follow-up force request that arrived mid-walk
        Bool again = walk_force
        walk_force = False
        ; already finished forced sync
    endif
EndFunction

String Function BuildAnimJson(sslBaseAnimation anim, int source)
    if !anim
        return ""
    endif
    String registry = anim.Registry
    if registry == ""
        return ""
    endif
    String name = anim.Name
    int enabled = 0
    if anim.Enabled
        enabled = 1
    endif
    int pos_count = anim.PositionCount
    int stage_count = anim.StageCount
    int[] genders = anim.Genders
    int males = 0
    int females = 0
    int male_creatures = 0
    int female_creatures = 0
    if genders
        if genders.length > 0
            males = genders[0]
        endif
        if genders.length > 1
            females = genders[1]
        endif
        if genders.length > 2
            male_creatures = genders[2]
        endif
        if genders.length > 3
            female_creatures = genders[3]
        endif
    endif
    int has_creature = 0
    if anim.IsCreature
        has_creature = 1
    endif
    String race_type = anim.RaceType
    if !race_type
        race_type = ""
    endif

    String pos_genders = "["
    String pos_race = "["
    int i = 0
    while i < pos_count
        if i > 0
            pos_genders += ","
            pos_race += ","
        endif
        pos_genders += anim.GetGender(i)
        String rk = ""
        String[] rts = anim.GetRaceTypes()
        if rts && i < rts.length && rts[i]
            rk = rts[i]
        endif
        pos_race += "\""+EscapeJson(rk)+"\""
        i += 1
    endwhile
    pos_genders += "]"
    pos_race += "]"

    String[] tags = anim.GetRawTags()
    String tags_json = "["
    i = 0
    int ntags = 0
    if tags
        ntags = tags.length
    endif
    while i < ntags
        if i > 0
            tags_json += ","
        endif
        tags_json += "\""+EscapeJson(tags[i])+"\""
        i += 1
    endwhile
    tags_json += "]"

    return "{\"_registry\":\""+EscapeJson(registry)+"\""\
        +",\"_name\":\""+EscapeJson(name)+"\""\
        +",\"_enabled\":"+enabled\
        +",\"_source\":"+source\
        +",\"_position_count\":"+pos_count\
        +",\"_stage_count\":"+stage_count\
        +",\"_males\":"+males\
        +",\"_females\":"+females\
        +",\"_male_creatures\":"+male_creatures\
        +",\"_female_creatures\":"+female_creatures\
        +",\"_has_creature\":"+has_creature\
        +",\"_race_type\":\""+EscapeJson(race_type)+"\""\
        +",\"_pos_genders\":"+pos_genders\
        +",\"_pos_race_keys\":"+pos_race\
        +",\"_tags\":"+tags_json+"}"
EndFunction

String Function EscapeJson(String s) global
    if !s
        return ""
    endif
    ; Minimal JSON string escape without StringUtil.Replace dependency.
    String out = ""
    int i = 0
    int n = StringUtil.GetLength(s)
    while i < n
        String ch = StringUtil.GetNthChar(s, i)
        if ch == "\\"
            out += "\\\\"
        elseif ch == "\""
            out += "\\\""
        else
            out += ch
        endif
        i += 1
    endwhile
    return out
EndFunction

; ---- Query wrappers used by Scene / UI ----

String Function QueryTopNAnims(String filter_json, int n)
    return AnimDb_QueryTopNAnims(filter_json, n)
EndFunction

String Function QueryTopNTags(String filter_json, int n)
    return AnimDb_QueryTopNTags(filter_json, n)
EndFunction

int Function TotalEnabled()
    return AnimDb_TotalEnabled()
EndFunction

String Function GetByRegistry(String registry)
    return AnimDb_GetByRegistry(registry)
EndFunction

String Function GetStageDescription(String registry, int stage)
    return AnimDb_GetStageDescription(registry, stage)
EndFunction

String Function SubstituteActors(String desc, String actors_json)
    return AnimDb_SubstituteActors(desc, actors_json)
EndFunction

Bool Function SaveAnimLocal(String registry, String json)
    return AnimDb_SaveAnimLocal(registry, json)
EndFunction

; ---- Replacements for former Stages APIs ----

Bool Property hide_help = false Auto

String Function GetThreadStageDescription(sslThreadController thread, int stage_override = -1)
    if !thread || !thread.animation
        return ""
    endif
    int stage = stage_override
    if stage < 1
        stage = thread.stage
    endif
    String reg = thread.animation.Registry
    String desc = AnimDb_GetStageDescription(reg, stage)
    if desc == "" && stage > 1
        ; fall back to earlier stages like old editor
        int s = stage - 1
        while s >= 1 && desc == ""
            desc = AnimDb_GetStageDescription(reg, s)
            s -= 1
        endwhile
    endif
    if desc == ""
        return ""
    endif
    Actor[] actors = thread.Positions
    String actors_json = "["
    int i = 0
    while actors && i < actors.length
        if i > 0
            actors_json += ","
        endif
        actors_json += "\""+EscapeJson(actors[i].GetDisplayName())+"\""
        i += 1
    endwhile
    actors_json += "]"
    return AnimDb_SubstituteActors(desc, actors_json)
EndFunction

int[] Function GetOrgasmExpected(sslThreadController thread)
    Actor[] actors = thread.Positions
    int n = 0
    if actors
        n = actors.length
    endif
    int[] out = Utility.CreateIntArray(n, 1)
    if !thread || !thread.animation || n < 1
        return out
    endif
    String row = AnimDb_GetByRegistry(thread.animation.Registry)
    if row == ""
        return out
    endif
    int obj = JValue.objectFromPrototype(row)
    if obj == 0
        return out
    endif
    int no_arr = JMap.getObj(obj, "_pos_no_orgasm")
    if no_arr == 0
        JValue.release(obj)
        return out
    endif
    int count = JArray.count(no_arr)
    int i = 0
    while i < n
        int no_org = 0
        if i < count
            no_org = JArray.getInt(no_arr, i)
        endif
        out[i] = 1 - no_org
        i += 1
    endwhile
    JValue.release(obj)
    return out
EndFunction

bool[] Function GetHasDescriptionOrgasmExpected(sslThreadController thread)
    Actor[] actors = thread.Positions
    int n = 0
    if actors
        n = actors.length
    endif
    bool[] out = Utility.CreateBoolArray(n, false)
    if !thread || !thread.animation
        return out
    endif
    String row = AnimDb_GetByRegistry(thread.animation.Registry)
    if row == ""
        return out
    endif
    int obj = JValue.objectFromPrototype(row)
    if obj == 0
        return out
    endif
    int has_arr = JMap.getObj(obj, "_stage_has_description")
    int stage = thread.stage
    bool has_desc = false
    if has_arr != 0 && stage >= 1 && stage <= JArray.count(has_arr)
        has_desc = JArray.getInt(has_arr, stage - 1) == 1
    endif
    int[] orgasm = GetOrgasmExpected(thread)
    int i = 0
    while i < n
        out[i] = has_desc && orgasm[i] == 1
        i += 1
    endwhile
    JValue.release(obj)
    return out
EndFunction
