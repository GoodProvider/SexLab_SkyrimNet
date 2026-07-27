Scriptname SkyrimNet_SexLab_Scene_Creator extends SkyrimNet_SexLab_Scene_Interface

Import SkyrimNet_SexLab_Utilities
Import SkyrimNet_SexLab_Scene_Interface

SexLabFramework Property sexlab Auto
Faction OStimActorCountFaction = None 

; ----------------------------------
; Actors and Victims 
; ----------------------------------
int Property num_actors = 0 Auto
Actor[] Property actors Auto

Actor[] Property victims Auto 

; --------------------------------------------
; Buttons 
; --------------------------------------------
int BUTTON_YES = 0
int BUTTON_YES_RANDOM = 1
int BUTTON_NO_SILENT = 2
int BUTTON_NO = 3

; --------------------------------------------
; speaker and target 
; --------------------------------------------
Actor speaker
Actor target

int[] victim_mask
int[] assailant_mask
int[] Property no_orgasm_mask Auto
int[] no_stripping_mask

int no_orgasm_default_current = 0
int no_stripping_default_current = 0
String Property speaking_modifiers_default_current = "_pleasure_" AUTO

String[] Property speaking_modifiers AUTO

String no_orgasm_names = ""
String no_stripping_names = "" 

String method = ""

; --------------------------------------------
; event_hook
; --------------------------------------------
String event_hook = ""

; --------------------------------------------
; Tags 
; --------------------------------------------
int num_tags = 0 
String[] tags = None 

int num_tags_suppress = 0 
String[] tags_suppress = None 

; -------------------------------------
; Actor Locks 
; -------------------------------------
String storage_actor_lock_key = "skyrimnet_sexlab_scene_actor_lock"
int actorLock = 0
float actorLockTimeout = 0.00069444444 ;  1 day / (24 hours  * 60 minutes )  

Function Trace(String func, String msg="", Bool notification=False)
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Scene_Creator", func, "sid:"+sid+" "+msg)
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

Function DbgReturn(String func, String reason="")
    if debug_mode
        if reason != ""
            Trace(func, "--- return "+reason)
        else
            Trace(func, "--- return")
        endif
    endif
EndFunction

Function DbgEnd(String func)
    if debug_mode
        Trace(func, "--- end")
    endif
EndFunction

Function DbgMsg(String func, String msg)
    if debug_mode
        Trace(func, "--- "+msg)
    endif
EndFunction


String Function GetString() 
    String tags_string = JoinStrings(tags,num_tags)
    String tags_suppress_string = JoinStrings(tags_suppress, num_tags_suppress)
    return "intent: "+intent\
          +" actors: ["+actor_names+"]"\
          +" victims: ["+victim_names+"]"\
          +" assailants: ["+assailant_names+"]"\
          +" no_orgasm: ["+no_orgasm_names+"]"\
          +" no_stripping: ["+no_stripping_names+"]"\
          +" tags:"+tags_string\
          +" suppress_tags:"+tags_suppress_string\
          +" style:"+style\
          +" event_hook:"+event_hook\
          +" speaking_modifiers: "+speaking_modifiers
EndFunction 

Function Initialize(int _sid, SkyrimNet_SexLab_Scene_Manager _manager, bool _is_generic = false) 
    debug_mode = False
    parent.Initialize(_sid, _manager, _is_generic) 
    sexlab = manager.sexlab
    EnsureActorsArraysLargeEnough(2) 
    OStimActorCountFaction = manager.OStimActorCountFaction
    if !tags 
        tags = new String[10]
        tags_suppress = new String[10]
    endif 
EndFunction 

; -------------------------------------------------------
; Setup 
; -------------------------------------------------------

Bool Function Setup(String _intent, Actor[] _actors, Actor _speaker, Actor _target, String _method="", String setting_name="")
    DbgEnter("Setup", "intent:"+_intent+" actors:["+JoinActors(_actors)+"] speaker:"+GetDisplayName(_speaker)+" target:"+GetDisplayName(_target)+" method:"+_method+" setting_name:"+setting_name)
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        DbgReturn("Setup", "Setup_CheckLinks failed")
        return False
    endif
    if !_actors
        DbgReturn("Setup", "actors is None")
        return False
    endif

    intent = _intent
    speaker = _speaker
    target = _target

    EnsureActorsArraysLargeEnough(_actors.length) 

    Actor player = Game.GetPlayer() 
    num_actors = 0 
    num_victims = 0 
    has_player = False 
    player_is_victim = False

    no_orgasm_default_current = 0
    no_stripping_default_current = 0
    speaking_modifiers_default_current = speaking_modifiers_default


    int i = 0
    int count = _actors.length
    while i < count 
        Actor akActor = _actors[i]
        if akActor != None 
            actors[num_actors] = akActor
            no_orgasm_mask[num_actors] = no_orgasm_default_current
            no_stripping_mask[num_actors] = no_stripping_default_current

            if player == akActor
                has_player = True 
            endif 
            speaking_modifiers[num_actors] = speaking_modifiers_DEFAULT
            num_actors += 1 
        endif 
        i += 1 
    endwhile 

    if num_actors < 1
        DbgReturn("Setup", "no valid actors")
        return False
    endif

    status = STATUS_ACTIVE 
    num_tags = 0
    num_tags_suppress = 0 
    style = STYLE_NORMALLY

    if (_method == "tentacles" || _method == "tentacle") && setting_name == "" 
        setting_name =  "pleasure_pain"
    endif 
    ; LLM comfort/nonsexual general hard-code nonsexual_male_position_1; Menu already uses this for kissing.
    if _method == "kissing"
        setting_name = "nonsexual_kissing"
    endif 

    LoadSetting("default")
    if setting_name != ""
        LoadSetting(setting_name) 
    endif 

    SetMethod(_method)
    AddTag(_method) 
    SetNames() 
    Trace("Setup", GetString())
    DbgEnd("Setup")
    return True
EndFunction 

Bool Function Setup_CheckLinks()
    Bool links_ok = true

    if manager == None
        links_ok = false
    endif

    if sexlab == None
        links_ok = false
    endif

    return links_ok
EndFunction


; --------------------------------------------
; Release 
; --------------------------------------------
Function Release()
    DbgEnter("Release")
    UnlockAllActorLock() 
    num_actors = 0
    num_tags = 0
    num_tags_suppress = 0 
    event_hook = "" 
    speaker = None
    target = None
    method = ""
    no_orgasm_names = ""
    no_stripping_names = ""
    parent.Release() 
    DbgEnd("Release")
EndFunction

; --------------------------------------------
; Start with Thread
; --------------------------------------------
SkyrimNet_SexLab_Scene Function StartScene() 
    DbgEnter("StartScene")
    bool e_c = manager.empty == manager.cancel
    Trace("StartScene", "manager.empty == manager.cancel: "+e_c)    
    SetNames() 

    Trace("StartScene",GetString()) 

    ; Select animations before NewThread so cancel/UI never claims a SexLab Making slot.
    sslBaseAnimation[] animations = SelectAnimations() 
    if animations == manager.cancel
        Trace("StartScene","SelectAnimations returned cancel")
        Release() 
        DbgReturn("StartScene", "None")
        return None
    endif

    DbgMsg("StartScene", "sexlab.NewThread()")
    sslThreadModel model = sexlab.NewThread()
    DbgMsg("StartScene", "sexlab.NewThread() returned model="+model)
    if model == None
        Trace("StartScene","Failed to create model")
        Release()
        DbgReturn("StartScene", "None")
        return None 
    endif

    ; If no animation list is provided (empty), SexLab randomly selects.
    DbgMsg("StartScene", "model.SetAnimations count="+animations.length)
    if animations != manager.empty && animations.length > 0
        model.SetAnimations(animations) 
    endif 

    ; -----------------------------------------
    ; Add Actors and Victims 
    ; -----------------------------------------
    int i = 0 
    bool failed = False 
    while i < num_actors && !failed 
        DbgMsg("StartScene", "model.AddActor "+actors[i].GetDisplayName())
        if model.AddActor(actors[i]) < 0 
            Trace("StartScene","AddActor failed on actor:"+actors[i].GetDisplayName())
            failed = True 
        else 
            if no_orgasm_mask[i] == 1 
                Trace("StartScene","no orgasm for "+actors[i].GetDisplayname())
                DbgMsg("StartScene", "model.DisableOrgasm "+actors[i].GetDisplayname())
                model.DisableOrgasm(actors[i], true) 
            endif 
            if no_stripping_mask[i] == 1 
                Trace("StartScene","no stripping for "+actors[i].GetDisplayname())
                DbgMsg("StartScene", "model.SetNoStripping "+actors[i].GetDisplayname())
                model.SetNoStripping(actors[i])
            endif 
        endif 
        i += 1 
    endwhile 

    i = 0 
    while i < num_victims && !failed
        DbgMsg("StartScene", "model.SetVictim "+victims[i].GetDisplayName())
        model.SetVictim(victims[i])
        i += 1 
    endwhile 

    if failed 
        ; Unlock SexLab Making slot claimed by NewThread (not Creator.Release).
        model.Initialize()
        Release() 
        DbgReturn("StartScene", "None")
        return  None 
    endif 

    ; Realign parallel masks if SexLab reordered positions
    RealignActorMasksFromPositions(model.positions)

    if num_actors == 1
        DbgMsg("StartScene", "sexlab.GetGender "+actors[0].GetDisplayName())
        int gender = sexlab.GetGender(actors[0])
        DbgMsg("StartScene", "sexlab.GetGender returned "+gender)
        bool has_penis = (gender != 1 && gender != 3)
        if has_penis 
            addTag("M")
        else 
            addTag("F")
        endif 
    endif 

    if event_hook != "" 
        DbgMsg("StartScene", "model.SetHook "+event_hook)
        model.SetHook(event_hook)
    endif 

    String tags_string = JoinStrings(tags, num_tags)
    String tags_suppress_string = JoinStrings(tags_suppress, num_tags_suppress)
    Trace("StartScene","intent:"+intent\
        +" actors: ["+actor_names+"]"\
        +" victims: ["+victim_names+"]"\
        +" assailants: ["+assailant_names+"]"\
        +" no_orgasm: ["+no_orgasm_names+"]"\
        +" no_stripping: ["+no_stripping_names+"]"\
        +" tag:"+tags_string\
        +" suppressed:"+tags_suppress_string\
        +" style:"+style\
        +" event_hook:"+event_hook)

    DbgMsg("StartScene", "model.StartThread()")
    sslThreadController thread = model.StartThread() 
    DbgMsg("StartScene", "model.StartThread() returned thread="+thread)
    if thread == None 
        Trace("StartScene","StartThread returned None, releasing sl_scene.sid")
        model.Initialize()
        Release() 
        DbgReturn("StartScene", "None")
        return None 
    endif 

    SkyrimNet_SexLab_Scene sl_scene = manager.CreateSceneByCreator(self, thread) 
    if sl_scene == None
        Trace("StartScene","CreateSceneByCreator returned None, ending orphan thread")
        thread.EndAnimation(true)
        Release()
        DbgReturn("StartScene", "None")
        return None
    endif
    Release() 
    DbgReturn("StartScene", "sl_scene")
    return sl_scene 
EndFunction

; Snapshot per-actor masks, then rewrite actors[] and masks to match SexLab positions order.
Function RealignActorMasksFromPositions(Actor[] positions)
    DbgEnter("RealignActorMasksFromPositions", "positions:"+positions.length)
    int old_num = num_actors
    Actor[] old_actors = PapyrusUtil.ActorArray(old_num)
    int[] old_no_orgasm = Utility.CreateIntArray(old_num)
    int[] old_no_stripping = Utility.CreateIntArray(old_num)
    String[] old_speaking = Utility.CreateStringArray(old_num)
    int i = 0
    while i < old_num
        old_actors[i] = actors[i]
        old_no_orgasm[i] = no_orgasm_mask[i]
        old_no_stripping[i] = no_stripping_mask[i]
        old_speaking[i] = speaking_modifiers[i]
        i += 1
    endwhile

    num_actors = positions.length
    EnsureActorsArraysLargeEnough(num_actors)
    i = 0
    while i < num_actors
        actors[i] = positions[i]
        no_orgasm_mask[i] = no_orgasm_default_current
        no_stripping_mask[i] = no_stripping_default_current
        speaking_modifiers[i] = speaking_modifiers_default_current
        int j = 0
        while j < old_num
            if old_actors[j] == actors[i]
                no_orgasm_mask[i] = old_no_orgasm[j]
                no_stripping_mask[i] = old_no_stripping[j]
                speaking_modifiers[i] = old_speaking[j]
                j = old_num
            else
                j += 1
            endif
        endwhile
        i += 1
    endwhile
    SetNames()
    DbgEnd("RealignActorMasksFromPositions")
EndFunction

; --------------------------------------------
; 
; --------------------------------------------

Function EnsureActorsArraysLargeEnough(int size) 
    DbgEnter("EnsureActorsArraysLargeEnough", "size:"+size)
    actors = EnsureActorsLargeEnough(actors, size) 
    victim_mask = EnsureIntsLargeEnough(victim_mask, size) 
    assailant_mask = EnsureIntsLargeEnough(assailant_mask, size) 
    no_orgasm_mask = EnsureIntsLargeEnough(no_orgasm_mask, size, no_orgasm_default_current) 
    no_stripping_mask = EnsureIntsLargeEnough(no_stripping_mask, size, no_stripping_default_current) 
    speaking_modifiers = EnsureStringsLargeEnough(speaking_modifiers, size, speaking_modifiers_default_current) 
    DbgEnd("EnsureActorsArraysLargeEnough")
EndFunction

; ---------------------------------
; Set Up Names 
; ---------------------------------
Function ShiftActorsLeft() 
    DbgEnter("ShiftActorsLeft")
    if num_actors < 2
        DbgReturn("ShiftActorsLeft", "void")
        return 
    endif 
    
    Actor temp = actors[0] 
    int temp_no_orgasm = no_orgasm_mask[0]
    int temp_no_stripping = no_stripping_mask[0]
    String temp_speaking = speaking_modifiers[0]
    int i = 0 
    while i+1 < num_actors
        actors[i] = actors[i+1]
        no_orgasm_mask[i] = no_orgasm_mask[i+1]
        no_stripping_mask[i] = no_stripping_mask[i+1]
        speaking_modifiers[i] = speaking_modifiers[i+1]
        i += 1 
    endwhile 
    actors[i] = temp 
    no_orgasm_mask[i] = temp_no_orgasm
    no_stripping_mask[i] = temp_no_stripping
    speaking_modifiers[i] = temp_speaking
    SetNames() 
    DbgEnd("ShiftActorsLeft")
EndFunction

Function SetMasks()
    DbgEnter("SetMasks")
    int i = 0 
    while i < num_actors 

        ; Victim and Assailant 
        bool found = False 
        int j = 0
        while j < num_victims 
            if actors[i] == victims[j]
                found = true 
            endif 
            j += 1 
        endwhile 
        if found 
            victim_mask[i] = 1 
            assailant_mask[i] = 0 
        else 
            victim_mask[i] = 0 
            assailant_mask[i] = 1
        endif 
        i += 1 
    endwhile 
    DbgEnd("SetMasks")
EndFunction 

Function SetNames() 
    DbgEnter("SetNames")
    SetMasks()
    actor_names = JoinActors(actors, num_actors)
    actor_names_json = JoinActorsToJson(actors, num_actors)

    victim_names = JoinActorsMasked(actors, victim_mask, num_actors)
    assailant_names = JoinActorsMasked(actors, assailant_mask, num_actors)

    no_orgasm_names = JoinActorsMasked(actors, no_orgasm_mask, num_actors)
    no_stripping_names = JoinActorsMasked(actors, no_stripping_mask, num_actors)
;    Trace("SexNames",sid+" actors:"+JoinActors(actors,num_actors)+" num_actors:"+num_actors+\
;        " actor_names:"+actor_names+" actor_names_json:"+actor_names_json+\
;        " hermaphrodiate_names:"+hermaphrodiate_names+" strapon_names:"+strapon_names+\
;        " victim_names:"+victim_names+" victim_names_json:"+victim_names_json+\
;        " assailant_names:"+assailant_names)
    DbgEnd("SetNames")
EndFunction 

; -------------------------------------------------
; Victim and Assailant setters 
; -------------------------------------------------

Function SetVictim(Actor victim) 
    DbgEnter("SetVictim", "victim:"+GetDisplayName(victim))
    if !victims 
        victims = PapyrusUtil.ActorArray(10)
    endif 
    num_victims = 0 
    player_is_victim = False
    if victim == None 
        Trace("SetVictim","victim is None")
        DbgReturn("SetVictim", "void")
        return
    endif 

    victims[0] = victim
    num_victims = 1 
    if victim == Game.GetPlayer()
        player_is_victim = True
    endif
    SetNames() 
    DbgEnd("SetVictim")
EndFunction 

Function SetVictims(Actor[] _victims) 
    DbgEnter("SetVictims", "victims:["+JoinActors(_victims)+"]")
    num_victims = 0 
    Actor player = Game.GetPlayer() 
    player_is_victim = False
    int i = 0
    int count = _victims.length
    while i < count 
        if _victims[i] != None 
            if _victims[i] == player
                player_is_victim = True 
            endif 
            num_victims += 1 
        else 
            Trace("SetVictims", "victims["+i+"] is None")
        endif
        i += 1 
    endwhile 

    if num_victims == 0 
        Trace("SetVictims","No valid victims found")
    else 
        victims = EnsureActorsLargeEnough(victims, num_victims) 
        i = 0 
        int j = 0 
        while i < count 
            if _victims[i] != None 
                victims[j] = _victims[i]
                j += 1  
            endif
            i += 1 
        endwhile 
        Trace("SetVictim",JoinActorsToJson(victims))
    endif 
    SetNames() 
    DbgEnd("SetVictims")
EndFunction 

Function SetMethod(String _method) 
    DbgEnter("SetMethod", "method:"+_method)
    method = _method
    if method == "oral" || method == "vaginal" || method == "anal"
        method += " sex"
    elseif method == "whip"
        method =  "whipping"
    endif 
    DbgEnd("SetMethod")
EndFunction

; -------------------------
; Tag Functions 
; -------------------------
String Function RemapTag(String tag)
    if tag == "mouth" || tag == "tongue"
        return "oral"
    elseif tag == "pussy"
        return "vaginal"
    elseif tag == "ass"
        return "anal"
    endif
    return tag
EndFunction

Function RemapAllTags()
    int i = 0
    while i < num_tags
        tags[i] = RemapTag(tags[i])
        i += 1
    endwhile
EndFunction

function SetTag(String tag) 
    DbgEnter("SetTag", "tag:"+tag)
    num_tags = 0
    AddTag(tag)
    DbgEnd("SetTag")
EndFunction 

function SetTagSuppress(String tag) 
    DbgEnter("SetTagSuppress", "tag:"+tag)
    num_tags_suppress = 0 
    AddTagSuppress(tag)
    DbgEnd("SetTagSuppress")
EndFunction 

function AddTag(String tag) 
    DbgEnter("AddTag", "tag:"+tag)
    tag = RemapTag(tag)
    if tag == "" 
        DbgReturn("AddTag", "void")
        return 
    endif 
    int i = 0 
    while i < num_tags 
        if tags[i] == tag 
            DbgReturn("AddTag", "void")
            return 
        endif 
        i += 1 
    endwhile 
    tags = EnsureStringsLargeEnough(tags, num_tags + 1) 
    tags[num_tags] = tag
    num_tags += 1 
    DbgEnd("AddTag")
EndFunction 
function AddTagSuppress(String tag) 
    DbgEnter("AddTagSuppress", "tag:"+tag)
    if tag == "" 
        DbgReturn("AddTagSuppress", "void")
        return 
    endif 
    int i = 0 
    while i < num_tags_suppress
        if tags_suppress[i] == tag 
            DbgReturn("AddTagSuppress", "void")
            return 
        endif 
        i += 1 
    endwhile 
    tags_suppress = EnsureStringsLargeEnough(tags_suppress, num_tags_suppress + 1) 
    tags_suppress[num_tags_suppress] = tag
    num_tags_suppress += 1 
    DbgEnd("AddTagSuppress")
EndFunction 

; --------------------------------------------
; --------------------------------------------
function SetTags(String[] _tags) 
    DbgEnter("SetTags", "tags:["+JoinStrings(_tags)+"]")
    SetTags_Helper(True,_tags) 
    DbgEnd("SetTags")
endfunction

function SetTagsSuppress(String[] _tags_suppress) 
    DbgEnter("SetTagsSuppress", "tags:["+JoinStrings(_tags_suppress)+"]")
    SetTags_Helper(False,_tags_suppress) 
    DbgEnd("SetTagsSuppress")
endfunction

Function SetTags_Helper(bool is_tags, String[] _tags)
    DbgEnter("SetTags_Helper", "is_tags:"+is_tags+" tags:["+JoinStrings(_tags)+"]")
    int number = 0 
    int i = 0
    int _num_tags = _tags.length
    while i < _num_tags 
        if _tags[i] != "" 
            number += 1 
        endif 
        i += 1 
    endwhile 

    String[] ts = tags 
    if !is_tags
        ts = tags_suppress
    endif 
    if number > 0
        ts = EnsureStringsLargeEnough(ts, number) 
        i = 0
        int j = 0 
        int count = _tags.length
        while i < count
            if _tags[i] != "" 
                if is_tags
                    ts[j] = RemapTag(_tags[i])
                else
                    ts[j] = _tags[i]
                endif
                j += 1 
            endif 
            i += 1 
        endwhile 
    endif 

    if is_tags
        num_tags = number
        tags = ts
    else
        num_tags_suppress = number
        tags_suppress = ts
    endif 
    DbgEnd("SetTags_Helper")
EndFunction 

; ------------------------------------------------------
; Set Style 
; ------------------------------------------------------
Function SetStyle(String _style) 
    DbgEnter("SetStyle", "style:"+_style)
    parent.SetStyle(_style)
    DbgEnd("SetStyle")
EndFunction 
String Function GetStyle() 
    return style
EndFunction

Function SetEventHook(String _event_hook) 
    DbgEnter("SetEventHook", "event_hook:"+_event_hook)
    event_hook = _event_hook 
    DbgEnd("SetEventHook")
EndFunction

; -------------------------------------------------------------------------------
; Get Speaker or Target 
; -------------------------------------------------------------------------------

Actor Function GetSpeaker() 
    DbgEnter("GetSpeaker")
    DbgReturn("GetSpeaker", "speaker")
    return speaker 
EndFunction 

Actor Function GetTarget() 
    DbgEnter("GetTarget")
    DbgReturn("GetTarget", "target")
    return target 
EndFunction

; -------------------------------------------------------------------------------------
; Load Scene Setting from File 
; -------------------------------------------------------------------------------------
Function LoadSetting(String setting_name) 
    if setting_name == "" 
        Trace("LoadSetting", "setting_name is '', aborting")
        return 
    endif 
    String filename = manager.GetSceneSettingFilename(setting_name)
    if !MiscUtil.FileExists(filename) 
        Trace("LoadSetting",filename+" doesn't exist, aborting")
        return 
    endif  

    int setting_id = JValue.readFromFile(filename)
    if setting_id < 0 
        Trace("LoadSetting",filename+" couldn't be parsed, aborting")
        return 
    endif  
    Trace("LoadSetting","loading "+setting_name)

    ; --------------------------------------
    ; Swap the first two positions, most sexlab have female at 0
    ; --------------------------------------
    if JMap.HasKey(setting_id, "male_position") && num_actors > 1
        int position = JMap.getInt(setting_id, "male_position") 
        if position < num_actors 
            int other = 0
            if position == 0 
                other = 1 
            endif 
            DbgMsg("LoadSetting", "sexlab.GetGender position "+actors[position].GetDisplayName())
            int gender = sexlab.GetGender(actors[position])
            bool position_male = gender == 0 || gender == 2 
            DbgMsg("LoadSetting", "sexlab.GetGender other "+actors[other].GetDisplayName())
            gender = sexlab.GetGender(actors[other])
            bool other_male = gender == 0 || gender == 2 
            ; position is not a male
            if !position_male && other_male
                Actor temp = actors[position]
                actors[position] = actors[other] 
                actors[other] = temp
                Trace("LoadSetting"," male_position caused swap: "+JoinActors(actors,num_actors))
            endif 
        endif 
    endif 

    ; --------------------------------------
    ; String Default 
    ; --------------------------------------
    if method == "" && JMap.HasKey(setting_id, "method") 
        method = JMap.getStr(setting_id, "method") 
    endif 

    ; ------------------------------
    ; Array values 
    ; ------------------------------
    int no_stripping_key = 0 
    int no_orgasm_key = 1 
    int speaking_modifiers_key = 2
    String[] keys = new String[3] 
    int num_keys = keys.length 
    keys[no_stripping_key] = "no_stripping"
    keys[no_orgasm_key] = "no_orgasm"
    keys[speaking_modifiers_key] = "speaking_modifiers"

    ; ------------------------------------
    ; Set Actors Arrays with defaults
    ; ------------------------------------
    int i = 0
    if JMap.HasKey(setting_id, "array_defaults") 
        int default_id = JMap.getObj(setting_id, "array_defaults")
        i = 0
        while i < num_keys 
            if JMap.HasKey(default_id, keys[i]) 
                if i == no_stripping_key || i == no_orgasm_key
                    if i == no_stripping_key
                        no_stripping_default_current = JMap.getInt(default_id, keys[i])
                    elseif i == no_orgasm_key 
                        no_orgasm_default_current = JMap.getInt(default_id, keys[i])
                    endif 
                    int j = 0 
                    while j < num_actors 
                        if i == no_stripping_key 
                            no_stripping_mask[j] = no_stripping_default_current
                        else 
                            no_orgasm_mask[j] = no_orgasm_default_current
                        endif 
                        j += 1 
                    endwhile 
                elseif i == speaking_modifiers_key
                    speaking_modifiers_default_current = JMap.getStr(default_id, keys[i], "")
                    int j = 0 
                    while j < num_actors 
                        speaking_modifiers[j] = speaking_modifiers_default_current
                        j += 1 
                    endwhile 
                endif 
            endif 
            i += 1 
        endwhile 
    endif 

    ; ------------------------------------
    ; Set Actors Arrays with specifics
    ; ------------------------------------
    i = 0 
    while i < num_keys 
        if JMap.HasKey(setting_id, keys[i])
            int array_id = JMap.getObj(setting_id, keys[i])
            if i == no_stripping_key || i == no_orgasm_key
                int[] values = JArray.asIntArray(array_id)
                int num_values = values.length
                EnsureActorsArraysLargeEnough(num_values) 

                ; Start with the values included in setting
                int j = 0 
                while j < num_values 
                    if i == no_stripping_key
                        no_stripping_mask[j] = values[j]
                    elseif i == no_orgasm_key
                        no_orgasm_mask[j] = values[j]
                    endif 
                    j += 1 
                endwhile 
            elseif i == speaking_modifiers_key
                string[] strings = JArray.asStringArray(array_id)
                int num_strings = strings.length
                EnsureActorsArraysLargeEnough(num_strings) 

                ; Start with the values included in setting
                int j = 0 
                while j < num_strings 
                    if i == speaking_modifiers_key
                        speaking_modifiers[j] = strings[j]
                    endif 
                    j += 1 
                endwhile 
            endif  
        endif 
        i += 1 
    endwhile 

    int tags_key = 0 
    int tags_suppress_key = 1 
    keys = new String[2] 
    num_keys = keys.length 
    keys[tags_key] = "tags"
    keys[tags_suppress_key] = "tags_suppress"
    i = 0
    while i < num_keys
        if JMap.HasKey(setting_id, keys[i]) 
            String[] strings = StringUtil.Split(JMap.getStr(setting_id, keys[i]), ",")
            if !strings
                strings = Utility.CreateStringArray(0)
            endif 
            int num_strings = strings.length 
            if i == tags_key 
                tags = EnsureStringsLargeEnough(tags, num_strings) 
            elseif i == tags_suppress_key 
                tags_suppress = EnsureStringsLargeEnough(tags_suppress, num_strings) 
            endif 

            int j = 0 
            while j < num_strings 
                if i == tags_key 
                    tags[j] = RemapTag(strings[j])
                elseif i == tags_suppress_key 
                    tags_suppress[j] = strings[j]
                endif 
                j += 1 
            endwhile 
            if i == tags_key 
                num_tags = num_strings
            elseif i == tags_suppress_key 
                num_tags_suppress = num_strings
            endif 
        endif 
        i += 1 
    endwhile 

    JValue.release(setting_id) 

    SetNames() 
    String tags_string = JoinStrings(tags,num_tags)
    String tags_suppress_string = JoinStrings(tags_suppress,num_tags_suppress)
    String no_stripping_json = JoinIntsToJson(no_stripping_mask, num_actors)
    String no_orgasm_json = JoinIntsToJson(no_orgasm_mask, num_actors)
    String speaking_modifiers_json = JoinStringsToJson(speaking_modifiers,num_actors)
    Trace("LoadSetting","defaults: no_strip:"+no_stripping_default_current+" no_orgasm:"+no_orgasm_default_current+" speaking_modifier:"+speaking_modifiers_default_current)
    if setting_name != "default"
        Trace("LoadSetting"," no_stripping:"+no_stripping_json+" no_orgasm:"+no_orgasm_json\
            +" tags:["+tags_string+"] suppress:["+tags_suppress_string+"]"+" speaking_modifiers:["+speaking_modifiers_json+"]")
    endif 
    DbgEnd("LoadSetting")
EndFunction 

; -------------------------------------------------------------------------------------
; Actor LOck
; -------------------------------------------------------------------------------------

bool Function LockAllActorLock() 
    DbgEnter("LockAllActorLock")
    if !actors
        DbgReturn("LockAllActorLock", "False")
        return False
    endif 
    int i = 0 
    while i < num_actors && LockActorLock(actors[i]) 
        i += 1 
    endwhile 

    if i < num_actors 
        UnlockAllActorLock()
        DbgReturn("LockAllActorLock", "False")
        return False 
    endif 
    DbgReturn("LockAllActorLock", "True")
    return True 
EndFunction 

Function UnLockAllActorLock() 
    DbgEnter("UnLockAllActorLock")
    if !actors 
        DbgReturn("UnLockAllActorLock", "void")
        return 
    endif 
    int i = 0
    while i < num_actors
        UnlockActorLock(actors[i]) 
        i += 1 
    endwhile 
    DbgEnd("UnLockAllActorLock")
EndFunction 

Bool Function IsActorLocked(Actor akActor) 
    DbgEnter("IsActorLocked", "akActor:"+GetDisplayName(akActor))
    DbgReturn("IsActorLocked", "StorageUtil.HasIntValue(akActor, storage_actor_lock_key)")
    return StorageUtil.HasIntValue(akActor, storage_actor_lock_key) 
EndFunction 

bool Function LockActorLock(Actor akActor) 
    DbgEnter("LockActorLock", "akActor:"+GetDisplayName(akActor))
    if akActor == None 
        Trace("LockActorLock","akActor is None")
        return false
    endif

    if akActor.IsDead() || akActor.IsInCombat() 
        Trace("LockActorLock", GetDisplayName(akActor)+" is dead or in combat")
        return false 
    endif 

    if StorageUtil.HasIntValue(akActor, "skyrimnet_sexlab_scene_actor_lock")
        Trace("LockActorLock", GetDisplayName(akActor)+" is locked")
        return false 
    endif

    if sexlab.IsActorActive(akActor) 
        Trace("LockActorLock", GetDisplayName(akActor)+" SexLab animation")
        return false 
    endif 

    if OstimActorCountFaction != None && akActor.IsInFaction(OStimActorCountFaction)
        Trace("LockActorLock", GetDisplayName(akActor)+" OStim animation")
        return false 
    endif
    Trace("LockActorLock", GetDisplayName(akActor)+" is eligible for sex")
    if StorageUtil.HasIntValue(akActor, storage_actor_lock_key) 
        Trace("LockActorLock", GetDisplayName(akActor)+" is already locked")
        return false 
    endif 
    StorageUtil.SetIntValue(akActor, storage_actor_lock_key, 1) 
    ; Trace("LockActorLock", GetDisplayName(akActor)+" is locked")
    DbgReturn("LockActorLock", "True")
    return true 
EndFunction 

Function UnlockActorLock(Actor akActor) 
    DbgEnter("UnlockActorLock", "akActor:"+GetDisplayName(akActor))
    StorageUtil.UnsetIntValue(akActor, storage_actor_lock_key) 
    DbgEnd("UnlockActorLock")
EndFunction

;---------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------

; Allows the user to choose to accept the sex act chosen by the LLM.
; Return values match BUTTON_* constants:
; 0 BUTTON_YES — Yes (may open tag editor)
; 1 BUTTON_YES_RANDOM — Yes without tag editor
; 2 BUTTON_NO_SILENT — refuse, do not tell the LLM
; 3 BUTTON_NO — refuse and narrate rejection to the LLM
int function YesNoDialog()
    
    DbgEnter("YesNoDialog")
    Actor player = Game.GetPlayer() 
    String player_name = player.GetDisplayName()

    String[] buttons = new String[4]
    buttons[BUTTON_YES] = "Yes"
    buttons[BUTTON_YES_RANDOM] = "Yes (Random)"
    buttons[BUTTON_NO_SILENT] = "No (Silent)"
    buttons[BUTTON_NO] = "No"

    String question = ""
    String rejection = ""

    String intent_method = intent 
    if method != "" 
        intent_method += " by "+method 
    endif 

    Trace("YesNoDialog","intent:"+intent+" num_victims:"+num_victims)
    if num_victims == 0
        int[] player_mask = Utility.CreateIntArray(num_actors, 1)
        int i = 0
        while i < num_actors
            if actors[i] == player
                player_mask[i] = 0
            endif 
            i += 1
        endwhile
        String names = JoinActorsMasked(actors, player_mask, num_actors)
        question = "Would you like to start "+intent_method+" with "+names+"?"
        rejection = player_name+" refuses to start "+intent_method+" with "+names+"."
    else
        if player_is_victim
            question = "Will you allow "+assailant_names+" to start "+intent_method+" with you?"
            rejection = player_name+" prevents "+assailant_names+" from starting "+intent_method+" with them."
        else 
            question = "Would you like to start "+intent_method+" "+victim_names+"?"
            rejection = player_name+" refuses to start "+intent_method+" "+victim_names+"."
        endif 
    endif 
    
    DbgMsg("YesNoDialog", "SkyMessage.ShowArray question="+question)
    int button = SkyMessage.ShowArray(question, buttons, getIndex = true) as int  
    DbgMsg("YesNoDialog", "SkyMessage.ShowArray returned button="+button)
    if button == BUTTON_NO || button == BUTTON_NO_SILENT
        if button == BUTTON_NO 
            DirectNarration(rejection, player, actors[0])
        endif 
    endif 
    DbgReturn("YesNoDialog", "button")
    return button
EndFunction

; ------------------------------------------------------------------------
; Animations 
; ------------------------------------------------------------------------

sslBaseAnimation[] Function SelectAnimations()
    DbgEnter("SelectAnimations")
    RemapAllTags()
    if num_victims > 0
        Trace("SelectAnimations"," assailants:"+assailant_names+" victims:"+victim_names)
    else 
        Trace("SelectAnimations"," actors:"+actor_names)
    endif 
    sslBaseAnimation[] animations = manager.empty
    int button = BUTTON_YES
    if has_player
        button = YesNoDialog()
        if button == BUTTON_NO || button == BUTTON_NO_SILENT
            DbgReturn("SelectAnimations", "cancel")
            return manager.cancel 
        endif 
    endif  

    if button != BUTTON_YES_RANDOM
        if (main.sex_edit_tags_player && has_player) || (main.sex_edit_tags_nonplayer && !has_player)
            animations = SelectAnimationsDialog()
            if animations == manager.cancel
                DbgReturn("SelectAnimations", "cancel")
                return manager.cancel
            endif
        endif 
    endif

    ; YES without tag editor, YES_RANDOM, or dialog returned empty:
    ; look up by tags when we do not already have a non-empty list from the dialog.
    if animations == manager.empty || !animations || animations.length == 0
        String tags_string = JoinStrings(tags, num_tags)
        String tags_suppress_string = JoinStrings(tags_suppress, num_tags_suppress)
        bool require = false 
        if num_tags > 0 || num_tags_suppress > 0
            require = true 
        endif 
        DbgMsg("SelectAnimations", "sexlab.GetAnimationsByTags actors="+num_actors+" tags="+tags_string+" suppress="+tags_suppress_string+" require="+require)
        animations = sexLab.GetAnimationsByTags(num_actors, tags_string, tags_suppress_string, require)
        DbgMsg("SelectAnimations", "sexlab.GetAnimationsByTags returned count="+animations.length)
    endif

    ; empty = no forced list; StartScene skips SetAnimations and SexLab randomly selects.
    if animations == manager.empty || !animations || animations.length == 0
        DbgReturn("SelectAnimations", "manager.empty")
        return manager.empty
    endif
    DbgReturn("SelectAnimations", "animations")
    return animations  
EndFunction 


; ----------------------------------------
; This function returns the list of animations matching the requested animations
; If no animations were selected, it will return an array with a single None value `[None]`
; 
;   anims = SelectAnimationsDialog(sexlab. positions, tag) 
;   if anims == empty
;        thread.SetAnimations(anims)
;   endif 
; ----------------------------------------
sslBaseAnimation[] Function SelectAnimationsDialog() 
    DbgEnter("SelectAnimationsDialog")
    if num_victims > 0
        Trace("SelectAnimationsDialog"," assailants:"+assailant_names+" victims:"+victim_names)
    else 
        Trace("SelectAnimationsDialog"," actors:"+actor_names)
    endif 

    if (has_player && !main.sex_edit_tags_player) || (!has_player && !main.sex_edit_tags_nonplayer)
        Trace("SelectAnimationsDialog", "Returning empty | sex_edit_tags_player:"+main.sex_edit_tags_player+" sex_edit_tags_nonplayer:"+main.sex_edit_tags_nonplayer)
        DbgReturn("SelectAnimationsDialog", "empty")
        return manager.empty 
    endif 

    String tags_string = JoinStrings(tags, num_tags)
    String tags_suppress_string = JoinStrings(tags_suppress, num_tags_suppress)
    if num_tags > 0 || num_tags_suppress > 0
        DbgMsg("SelectAnimationsDialog", "sexlab.GetAnimationsByTags probe tags="+tags_string)
        sslBaseAnimation[] anims =  SexLab.GetAnimationsByTags(num_actors, tags_string, tags_suppress_string, true)
        DbgMsg("SelectAnimationsDialog", "sexlab.GetAnimationsByTags probe returned count="+anims.length)
        if anims.length == 0
            Trace("SelectAnimationsDialog", "No animations found, dropping initial tag: ["+tags_string+"] tags_suppress:["+tags_suppress_string+"]")
            num_tags = 0 
            num_tags_suppress = 0
            tags_string = "" 
            tags_suppress_string = "" 
        endif 
    endif 

    ; the order of the groups 
    int group_tags = JMap.getObj(manager.group_info,"group_tags",0)
    if group_tags == 0 
        Trace("SelectAnimationsDialog", "group_tags not found in group_tags.json")
        DbgReturn("SelectAnimationsDialog", "manager.empty")
        return manager.empty
    endif 
    Trace("SelectAnimationDialog e")

    int groups = JMap.getObj(group_tags,"groups",0)
    bool groups_owned = false
    if groups == 0
        groups = JMap.allKeys(group_tags)
        JValue.retain(groups)
        groups_owned = true
    endif 

    int group_count = JArray.count(groups)
    uilistMenu listMenu = uiextensions.GetMenu("UIlistMenu") AS uilistMenu

    while True
        String order_str ="change order>"
        bool finished = false
        Trace("SelectAnimationsDialog","num_tags:"+num_tags)
        while !finished
            String start_label = "<start "+intent+">"
            Trace("SelectAnimationsDialog"," start_label:"+start_label)
            String style_button = "change style: "+style+">"
            listMenu.ResetMenu()

            listMenu.AddEntryItem(actor_names)
            if num_actors > 1 
                listMenu.AddEntryItem(order_str)
            endif 
            listMenu.AddEntryItem(style_button)

            ; build the current tags
            tags_string = JoinStrings(tags,num_tags)
            String tags_label = "tags:"+tags_string
            listMenu.AddEntryItem(tags_label)

            tags_suppress_string = JoinStrings(tags_suppress,num_tags_suppress)
            String tags_suppress_label = "suppress:"+tags_suppress_string
            listMenu.AddEntryItem(tags_suppress_label)

            listMenu.AddEntryItem(start_label)

            ; there is at least one tag that can be removed 
            if 0 < num_tags 
                listMenu.AddEntryItem("<remove")
            endif 

            ; Add groups
            int i =  0
            while i < group_count
                String group = JArray.getStr(groups,i)
                listMenu.AddEntryItem(group)
                i += 1
            endwhile

            ; just give up
            listMenu.AddEntryItem("<cancel>")

            listMenu.OpenMenu()
            String button =  listMenu.GetResultString()
            if JMap.hasKey(group_tags, button)
                button = GroupDialog(group_tags, button)
            endif 

            if button == start_label 
                finished = true
            elseif button == style_button
                SetStyleDialog()
                style_button = style+">"
            elseif button == order_str 
                ShiftActorsLeft() 
            elseif button == "<cancel>"
                if groups_owned
                    JValue.release(groups)
                endif
                DbgReturn("SelectAnimationsDialog", "cancel")
                return manager.cancel
            elseif button == "<remove"
                num_tags -= 1
            elseif button != "-continue-" && button != actor_names && button != tags_label && button != tags_suppress_label
                if button != "" 
                    AddTag(button)
                endif 
            endif 
        endwhile 

        DbgMsg("SelectAnimationsDialog", "sexlab.GetAnimationsByTags final tags="+tags_string)
        sslBaseAnimation[] anims =  SexLab.GetAnimationsByTags(num_actors, tags_string, tags_suppress_string, true)
        DbgMsg("SelectAnimationsDialog", "sexlab.GetAnimationsByTags final returned count="+anims.length)
        if anims.length > 0
            if groups_owned
                JValue.release(groups)
            endif
            DbgReturn("SelectAnimationsDialog", "anims")
            return anims 
        else
            Trace("SelectAnimationsDialog","No animations found for: "+tags_string, True )
            if num_tags > 0
               num_tags -= 1 
            endif 
        endif 
    endwhile 
    if groups_owned
        JValue.release(groups)
    endif
    DbgReturn("SelectAnimationsDialog", "manager.empty")
    return manager.empty
EndFunction

Function AddGroupTags(uilistMenu listMenu, int group_tags, String group)
    DbgEnter("AddGroupTags", "group:"+group)
    int tags_obj = JMap.getObj(group_tags, group, 0)
    if tags_obj != 0 
        int i = 0
        int count = JArray.count(tags_obj)
        while i < count
            String tag = JArray.getStr(tags_obj, i, "")
            if tag != ""
                listMenu.AddEntryItem(tag)
            endif
            i += 1
        endwhile 
    endif 
    DbgEnd("AddGroupTags")
EndFunction

String Function GroupDialog(int group_tags, String group)
    DbgEnter("GroupDialog", "group:"+group)
    uilistMenu listMenu = uiextensions.GetMenu("UIlistMenu") AS uilistMenu
    listMenu.ResetMenu()
    listMenu.AddEntryItem("<back")
    AddGroupTags(listMenu, group_tags, group) 
    listMenu.OpenMenu()
    String button =  listMenu.GetResultString()
    if button == "<back"
        button = "-continue-"
    endif 
    Trace("GroupDialog","button:"+button)
    DbgReturn("GroupDialog", "button")
    return button
EndFunction 