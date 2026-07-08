Scriptname SkyrimNet_SexLab_Scene_Creator extends SkyrimNet_SexLab_Scene_Interface

Import SkyrimNet_SexLab_Utilities
Import SkyrimNet_SexLab_Scene_Interface

SexLabFramework Property sexlab Auto

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
String speaking_modifiers_default_current = ""

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
    msg = "[SkyrimNet_SexLab_Scene_Creator."+func+"] sid:"+sid+" "+msg
    Debug.Trace(msg) 
    if notification
        Debug.Notification(msg)
    endif 
EndFunction

Function DbgEnter(String func)
    Trace(func, "--- enter")
EndFunction

Function DbgReturn(String func, String reason="")
    if reason != ""
        Trace(func, "--- return "+reason)
    else
        Trace(func, "--- return")
    endif
EndFunction

Function DbgEnd(String func)
    Trace(func, "--- end")
EndFunction

Function DbgMsg(String func, String msg)
    Trace(func, "--- "+msg)
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
          +" event_hook:"+event_hook
EndFunction 

Function Initialize(int _sid, SkyrimNet_SexLab_Scene_Manager _manager) 
    DbgEnter("Initialize")
    parent.Initialize(_sid, _manager) 
    sexlab = manager.sexlab
    EnsureActorsArraysLargeEnough(2) 
    if !tags 
        tags = new String[10]
        tags_suppress = new String[10]
    endif 
    DbgEnd("Initialize")
EndFunction 

; -------------------------------------------------------
; Setup 
; -------------------------------------------------------

Function Setup(String _intent, Actor[] _actors, Actor _speaker, Actor _target, String _method="", String setting_name="")
    DbgEnter("Setup")
    Trace("Setup","intent: "+_intent+" actors: ["+JoinActors(_actors)+"] speaker:"+GetDisplayName(_speaker)+" target:"+GetDisplayName(_target)+" method: "+_method)
    intent = _intent
    speaker = _speaker
    target = _target 

    EnsureActorsArraysLargeEnough(_actors.length) 

    Actor player = Game.GetPlayer() 
    num_actors = 0 
    num_victims = 0 
    has_player = False 

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

    status = STATUS_ACTIVE 
    num_tags = 0
    num_tags_suppress = 0 
    style = STYLE_NORMALLY

    if (_method == "tentacles" || _method == "tentacle") && setting_name == "" 
        setting_name =  "pleasure_pain"
    endif 

    LoadSetting("default")
    if setting_name != ""
        LoadSetting(setting_name) 
    endif 

    SetMethod(_method)
    AddTag(_method) 
    SetNames() 
    DbgEnd("Setup")
EndFunction 


; --------------------------------------------
; Release 
; --------------------------------------------
Function Release()
    DbgEnter("Release")
    UnlockAllActorLock() 
    num_tags = 0
    num_tags_suppress = 0 
    event_hook = None 
    parent.Release() 
    DbgEnd("Release")
EndFunction

; --------------------------------------------
; Start with Thread
; --------------------------------------------
SkyrimNet_SexLab_Scene Function StartScene() 
    DbgEnter("StartScene")
    SetNames() 

    Trace("StartScene",GetString()) 

    DbgMsg("StartScene", "sexlab.NewThread()")
    sslThreadModel model = sexlab.NewThread()
    DbgMsg("StartScene", "sexlab.NewThread() returned model="+model)
    if model == None
        Trace("StartScene","Failed to create model")
        Release()
        DbgReturn("StartScene", "None")
        return None 
    endif

    sslBaseAnimation[] animations = SelectAnimations() 
    if animations == empty
        Trace("StartScene","SelectAnimations returned empty")
        Release() 
        DbgReturn("StartScene", "None")
        return None
    endif
    DbgMsg("StartScene", "model.SetAnimations count="+animations.length)
    model.SetAnimations(animations) 

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
        Release() 
        DbgReturn("StartScene", "None")
        return  None 
    endif 

    ; Reset the masks, in case the names moves things around 
    i = 0
    DbgMsg("StartScene", "model.positions.length")
    num_actors = model.positions.length
    while i < num_actors 
        actors[i] = model.positions[i]
        i += 1 
    endwhile 
    SetNames() 

    ; ------------------------------------------
    ; Add Tags
    ; ------------------------------------------

    i = 0
    while i < num_tags
        String tag = tags[i]
        if tag == "mouth" || tag == "tongue"
            tags[i] = "oral"
        elseif tag == "pussy"
            tags[i] = "vaginal"
        elseif tag == "ass"
            tags[i] = "anal"
        endif 
        i += 1 
    endwhile 

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

    Trace("StartScene","--- starting thread")
    DbgMsg("StartScene", "model.StartThread()")
    sslThreadController thread = model.StartThread() 
    DbgMsg("StartScene", "model.StartThread() returned thread="+thread)
    if thread == None 
        Trace("Start","StartThread returned None, releasing sl_scene.sid")
        Release() 
        DbgReturn("StartScene", "None")
        return None 
    endif 

    Trace("StartScene","--- CreateSceneByCreator")
    SkyrimNet_SexLab_Scene sl_scene = manager.CreateSceneByCreator(self, thread) 
    Release() 
    DbgReturn("StartScene", "sl_scene")
    return sl_scene 
EndFunction

; --------------------------------------------
; 
; --------------------------------------------

Function EnsureActorsArraysLargeEnough(int size) 
    DbgEnter("EnsureActorsArraysLargeEnough")
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
    
    String before = actor_names 
    Actor temp = actors[0] 
    int i = 0 
    while i+1 < num_actors
        actors[i] = actors[i+1]
        i += 1 
    endwhile 
    actors[i] = temp 
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
    DbgEnter("SetVictim")
    if !victims 
        victims = PapyrusUtil.ActorArray(10)
    endif 
    num_victims = 0 
    if victim == None 
        Trace("SetVictim","victim is None")
        DbgReturn("SetVictim", "void")
        return
    endif 

    victims[0] = victim
    num_victims = 1 
    Trace("SetVictim",GetDisplayName(victim))
    SetNames() 
    DbgEnd("SetVictim")
EndFunction 

Function SetVictims(Actor[] _victims) 
    DbgEnter("SetVictims")
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
        Trace("SexVictims","No valid victims found")
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
    DbgEnter("SetMethod")
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
function SetTag(String tag) 
    DbgEnter("SetTag")
    num_tags = 0
    AddTag(tag)
    DbgEnd("SetTag")
EndFunction 

function SetTagSuppress(String tag) 
    DbgEnter("SetTagSuppress")
    num_tags_suppress = 0 
    AddTagSuppress(tag)
    DbgEnd("SetTagSuppress")
EndFunction 

function AddTag(String tag) 
    DbgEnter("AddTag")
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
    DbgEnter("AddTagSuppress")
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
    DbgEnter("SetTags")
    SetTags_Helper(True,_tags) 
    DbgEnd("SetTags")
endfunction

function SetTagsSuppress(String[] _tags_suppress) 
    DbgEnter("SetTagsSuppress")
    SetTags_Helper(False,_tags_suppress) 
    DbgEnd("SetTagsSuppress")
endfunction

Function SetTags_Helper(bool is_tags, String[] _tags)
    DbgEnter("SetTags_Helper")
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
                ts[j] = _tags[i]
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
    DbgEnter("SetStyle")
    parent.SetStyle(_style)
    DbgEnd("SetStyle")
EndFunction 
String Function GetStyle() 
    return style
EndFunction

Function SetEventHook(String _event_hook) 
    DbgEnter("SetEventHook")
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
    DbgEnter("LoadSetting")
    if setting_name == "" 
        Trace("LoadSetting", "setting_name is '', aborting")
        DbgReturn("LoadSetting", "void")
        return 
    endif 
    String filename = manager.GetSceneSettingFilename(setting_name)
    if !MiscUtil.FileExists(filename) 
        Trace("LoadSetting",filename+" doesn't exit, aborting")
        DbgReturn("LoadSetting", "void")
        return 
    endif  

    int setting_id = JValue.readFromFile(filename)
    if setting_id < 0 
        Trace("LoadSetting",filename+" couldn't be parsed, aborting")
        DbgReturn("LoadSetting", "void")
        return 
    endif  
    Trace("LoadSetting","loading "+setting_name)

    ; --------------------------------------
    ; Swap the first two positions, most sexlab have female at 0
    ; --------------------------------------
    if JMap.HasKey(setting_id, "male_position") && num_actors > 1
        int position = JMap.GetInt(setting_id, "male_position") 
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
        method = JMap.GetStr(setting_id, "method") 
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
    if JMap.HasKey(setting_id, "array_defaults") 
        int default_id = JMap.GetObj(setting_id, "array_defaults")
        int i = 0
        while i < num_keys 
            if JMap.HasKey(default_id, keys[i]) 
                if i == no_stripping_key || i == no_orgasm_key
                    if i == no_stripping_key
                        no_stripping_default_current = JMap.GetInt(default_id, keys[i])
                    elseif i == no_orgasm_key 
                        no_orgasm_default_current = JMap.GetInt(default_id, keys[i])
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
                    speaking_modifiers_default_current = JMap.GetStr(default_id, keys[i], "")
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
    int i = 0 
    while i < num_keys 
        if JMap.HasKey(setting_id, keys[i])
            int array_id = JMap.GetObj(setting_id, keys[i])
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
            String[] strings = StringUtil.Split(JMap.GetStr(setting_id, keys[i]), ",")
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
                    tags[j] = strings[j]
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
    Trace("LoadSetting","defauls: no_strip:"+no_stripping_default_current+" no_orgasm:"+no_orgasm_default_current+" speaking_modifier:"+speaking_modifiers_default_current)
    if setting_name != "default"
        Trace("LoadSetting"," no_stripping:"+no_stripping_json+" no_orgasm:"+no_orgasm_json\
            +" tags:["+tags_string+"] suppress:["+tags_suppress_string+"]"+" speaking_modifiers:["+speaking_modifiers+"]")
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
    DbgEnter("IsActorLocked")
    DbgReturn("IsActorLocked", "StorageUtil.HasIntValue(akActor, storage_actor_lock_key)")
    return StorageUtil.HasIntValue(akActor, storage_actor_lock_key) 
EndFunction 

bool Function LockActorLock(Actor akActor) 
    DbgEnter("LockActorLock")
    if StorageUtil.HasIntValue(akActor, storage_actor_lock_key) 
        DbgReturn("LockActorLock", "False")
        return False 
    endif 
    Trace("LockActorLock",akActor.GetDisplayName())
    StorageUtil.SetIntValue(akActor, storage_actor_lock_key, 1) 
    DbgReturn("LockActorLock", "True")
    return True 
EndFunction 

Function UnlockActorLock(Actor akActor) 
    DbgEnter("UnlockActorLock")
    StorageUtil.UnsetIntValue(akActor, storage_actor_lock_key) 
    Trace("UnlockActorLock",akActor.GetDisplayName())
    DbgEnd("UnlockActorLock")
EndFunction

;---------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------------------------

; Allows the user to choose to accept the sex act chosen by the LLM 
; The value will between 
; 1 Yes with the editor 
; 2 Yes, but no tag editor 
; 3 No (silent), refused, but don't tell the LLM 
; 4 NO, tell the LLM 
int function YesNoDialog()
    
    DbgEnter("YesNoDialog")
    Actor player = Game.GetPlayer() 
    String player_name = player.GetDisplayName()

    int yes = 0 
    int no_silent = 1
    int no = 2 

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
            question = "Will you allow, "+assailant_names+" to start "+intent_method+" you?"
            rejection = player_name+" prevents, "+assailant_names+" from to start "+intent_method+" them?"
        else 
            question = "Would you like to start "+intent_method+" "+victim_names+"?"
            rejection = player_name+" refuses to start "+intent_method+" "+victim_names+"."
        endif 
    endif 
    
    DbgMsg("YesNoDialog", "SkyMessage.ShowArray question="+question)
    int button = SkyMessage.ShowArray(question, buttons, getIndex = true) as int  
    DbgMsg("YesNoDialog", "SkyMessage.ShowArray returned button="+button)
    Trace("YesNoDialog","--- question: "+question+" buttons: "+JoinStrings(buttons, buttons.length)+" button: "+button)
    if button == BUTTON_NO || button == BUTTON_NO_SILENT
        if button == BUTTON_NO 
            DirectNarration(rejection, player, actors[0])
        endif 
    endif 
    Trace("YesNoDialog","--- returning button: "+button)
    DbgReturn("YesNoDialog", "button")
    return button
EndFunction

; ------------------------------------------------------------------------
; Animations 
; ------------------------------------------------------------------------

sslBaseAnimation[] Function SelectAnimations()
    DbgEnter("SelectAnimations")
    if num_victims > 0
        Trace("SelectAnimations"," assailants:"+assailant_names+" victims:"+victim_names)
    else 
        Trace("SelectAnimations"," actors:"+actor_names)
    endif 
    sslBaseAnimation[] animations = empty
    int button = BUTTON_YES
    if has_player
        button = YesNoDialog()
        Trace("SelectAnimations","--- button: "+button)
        if button == BUTTON_NO || button == BUTTON_NO_SILENT
            DbgReturn("SelectAnimations", "empty")
            return empty 
        endif 
    endif  

    Trace("SelectAnimations","--- a button: "+button)
    if button != BUTTON_YES_RANDOM
        if (main.sex_edit_tags_player && has_player) || (main.sex_edit_tags_nonplayer && !has_player)
            animations = SelectAnimationsDialog()
        else 
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
    else
        Trace("SelectAnimations","--- b button: "+button)
        String tags_string = JoinStrings(tags, num_tags)
        Trace("SelectAnimations","--- c tags_string: "+tags_string)
        String tags_suppress_string = JoinStrings(tags_suppress, num_tags_suppress)
        Trace("SelectAnimations","--- d tags_suppress_string: "+tags_suppress_string)
        bool require = false 
        if num_tags > 0 || num_tags_suppress > 0
            require = true 
        endif 
        Trace("SelectAnimations","--- e sexlab: "+sexlab)
        DbgMsg("SelectAnimations", "sexlab.GetAnimationsByTags actors="+num_actors+" tags="+tags_string+" suppress="+tags_suppress_string+" require="+require)
        animations =  sexLab.GetAnimationsByTags(num_actors, tags_string, tags_suppress_string, require)
        DbgMsg("SelectAnimations", "sexlab.GetAnimationsByTags returned count="+animations.length)
        Trace("SelectAnimations","--- e animations: "+animations.length)
    endif 
    Trace("SelectAnimations","--- f animations: "+animations.length)
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
        return empty 
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
        DbgReturn("SelectAnimationsDialog", "empty")
        return empty
    endif 
    Trace("SelectAnimationDialog e")

    int groups = JMap.getObj(group_tags,"groups",0)
    if groups == 0
        groups = JMap.allKeys(group_tags)
        JValue.retain(groups)
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
                JValue.release(groups)
                DbgReturn("SelectAnimationsDialog", "empty")
                return empty
            elseif button == "<remove"
                num_tags -= 1
            elseif button != "-continue-" && button != actor_names && button != tags_label
                if button != "" 
                    AddTag(button)
                endif 
            endif 
        endwhile 

        DbgMsg("SelectAnimationsDialog", "sexlab.GetAnimationsByTags final tags="+tags_string)
        sslBaseAnimation[] anims =  SexLab.GetAnimationsByTags(num_actors, tags_string, tags_suppress_string, true)
        DbgMsg("SelectAnimationsDialog", "sexlab.GetAnimationsByTags final returned count="+anims.length)
        if anims.length > 0
            JValue.release(groups)
            DbgReturn("SelectAnimationsDialog", "anims")
            return anims 
        else
            Trace("SelectAnimationsDialog","No animations found for: "+tags_string, True )
            if num_tags > 0
               num_tags -= 1 
            endif 
        endif 
    endwhile 
    JValue.release(groups)
    DbgReturn("SelectAnimationsDialog", "empty")
    return empty
EndFunction

Function AddGroupTags(uilistMenu listMenu, int group_tags, String group) global
    int tags_obj = JMap.getObj(group_tags, group, 0)
    SkyrimNet_SexLab_Scene_Creator creator = Game.GetFormFromFile(0x8000,"SkyrimNet_SexLab_Scene_Creator.psc") AS SkyrimNet_SexLab_Scene_Creator
    creator.DbgEnter("AddGroupTags")
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
    creator.DbgEnd("AddGroupTags")
EndFunction

String Function GroupDialog(int group_tags, String group)
    DbgEnter("GroupDialog")
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