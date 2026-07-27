Scriptname SkyrimNet_SexLab_Scene_Manager extends Quest 

Import SkyrimNet_SexLab_Utilities

SkyrimNet_SexLab_Main Property main Auto
SkyrimNet_SexLab_Stages Property stages Auto

SexLabFramework Property sexlab Auto
sslThreadSlots Property threadSlots Auto
sslActorLibrary Property actorLib Auto

Faction Property OStimActorCountFaction = None Auto

; sl_scene_generic is returned when there are no more sl_scenes available
; If a sl_scene is not found, sl_scene_generic is returned
; to make sure a description is always possible
SkyrimNet_SexLab_Scene Property sl_scene_generic = None Auto
SkyrimNet_SexLab_Scene[] Property sl_scenes Auto

; We use Form so we can use CreateFormArray if we need to increase the size 
Form[] thread_scene
SkyrimNet_SexLab_Scene_Creator[] Property creators Auto

; -------------------------------------
Faction Property SkyrimNet_SexLab_Faction_Victim Auto

; Threads filename 
String threads_filename = "Data/SKSE/Plugins/SkyrimNet_SexLab/threads.json"

; -------------------------------------
; Thread Count
; -------------------------------------
int thread_counter = 0 

; -------------------------------------
; Group Info Object 
; -------------------------------------
int Property group_info = 0 Auto

; ---------------------------------------
; Location of the Scenes 
; ---------------------------------------
String SCENES_FOLDER = "Data/SKSE/Plugins/SkyrimNet_SexLab/scenes/"

; ---------------------------------------
; speaker_last is used when save is called 
; ---------------------------------------
Actor speaker_last = None

; --------------------------------------------
; Since returning a None array cause an error
; we set the empty
; --------------------------------------------
sslBaseAnimation[] Property empty = None Auto
sslBaseAnimation[] Property cancel = None Auto

Function Trace(String func, String msg="", Bool notification=False)
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Scene_Manager", func, msg)
    if notification
        Debug.Notification(logged)
    endif 
EndFunction

Function Setup() 
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        return
    endif

    Trace("Setup","")
    ; Auto fills bake into saves. Renaming scenes→sl_scenes / scene_generic→
    ; sl_scene_generic leaves the new names empty on old saves while creators
    ; (unchanged) still work — rebuild every Setup from known FormIDs.
    if !RebuildScenePool()
        Trace("Setup","RebuildScenePool failed, aborting", true)
        return
    endif

    ; Used to check if an actor is controled by OStim
    if Game.GetModByName("Ostim.esp") != 255
        OStimActorCountFaction = Game.GetFormFromFile(0xECA, "Ostim.esp") as Faction
        Trace("Setup","Found Ostim.esp, OStimActorCountFaction set to "+OStimActorCountFaction)
    else 
        OStimActorCountFaction = None 
    endif 

    if !cancel 
        cancel = new sslBaseAnimation[1]
        cancel[0] = None 
    endif 
    if !empty 
        empty = new sslBaseAnimation[2]
        empty[0] = None 
        empty[1] = None 
    endif 
    bool empty_equals_cancel = empty == cancel
    Trace("Initialize", "empty == cancel: "+empty_equals_cancel)

    ; is_generic=true permanently marks the fallback Scene when the pool is exhausted
    sl_scene_generic.Initialize(-1, self, true) 

    int i = sl_scenes.length - 1
    while 0 <= i 
        if sl_scenes[i] == None
            Trace("Setup","sl_scenes["+i+"] is None, aborting", true)
            return
        endif
        sl_scenes[i].Initialize(i, self, false)
        i -= 1 
    endwhile  

    i = creators.length - 1 
    while 0 <= i 
        if creators[i] == None
            Trace("Setup","creators["+i+"] is None, aborting", true)
            return
        endif
        creators[i].Initialize(i, self) 
        i -= 1 
    endwhile 

    if !thread_scene
        Trace("Setup","creating thread_scene map")
        thread_scene = new form[32]
    endif 

    ; Reload the group_tags in case they where changed each time.
    if group_info == 0
        group_info = JValue.readFromFile("Data/SKSE/Plugins/SkyrimNet_Sexlab/group_tags.json")
        JValue.retain(group_info)
    else
        int group_info_new = JValue.readFromFile("Data/SKSE/Plugins/SkyrimNet_Sexlab/group_tags.json")
        JValue.releaseAndRetain(group_info, group_info_new)
        group_info = group_info_new
    endif
    RegisterEventsActions()
    RegisterEventsSexLab()

    ; SexLab always starts with no active threads; clear stale file from prior session
    GetThreadsJson()
EndFunction 

Bool Function Setup_CheckLinks()
    Bool links_ok = true

    if main == None
        links_ok = false
    endif

    if stages == None
        links_ok = false
    endif

    if SexLab == None
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

; --------------------------------------------------------------------
; Create Creator 
; --------------------------------------------------------------------
SkyrimNet_SexLab_Scene_Creator Function CreateCreator(String intent, Actor[] actors, Actor speaker, Actor target, String method="", String setting_name="")
    Trace("CreateCreator","intent: "+intent+" actors: "+JoinActorsToJson(actors)+" speaker: "+GetDisplayName(speaker)+" target: "+GetDisplayName(target)+" method: "+method+" setting_name: "+setting_name)
    int i = 0
    int num_creators = creators.length 
    while i < num_creators
        if !creators[i].IsActive()
            if creators[i].Setup(intent, actors, speaker, target, method, setting_name)
                return creators[i]
            endif
            Trace("CreateCreator", "Setup failed for creators["+i+"], trying next slot")
        endif 
        i += 1 
    endwhile
    Trace("CreateCreator", "no inactive creator available (or all Setup failed)")
    return None
EndFunction

; --------------------------------------------------------------------
; Get Scene 
; --------------------------------------------------------------------
SkyrimNet_SexLab_Scene Function CreateSceneByCreator(SkyrimNet_SexLab_Scene_Creator creator, sslThreadController thread) 
    if creator == None || thread == None
        Trace("CreateSceneByCreator", "creator or thread is None, aborting")
        return None
    endif
    SkyrimNet_SexLab_Scene sl_scene = GetSceneInactive(thread)
    if sl_scene == None
        Trace("CreateSceneByCreator", "GetSceneInactive returned None, aborting")
        return None
    endif
    if !sl_scene.Setup(creator)
        Trace("CreateSceneByCreator", "Setup failed, releasing scene")
        sl_scene.Release()
        return None
    endif
    return sl_scene 
EndFunction 

SkyrimNet_SexLab_Scene Function CreateSceneWithoutCreator(sslThreadController thread) 
    if thread == None
        Trace("CreateSceneWithoutCreator", "thread is None, aborting")
        return None
    endif
    SkyrimNet_SexLab_Scene_Creator creator = CreateCreator("", thread.Positions, None, None, "", "")
    if creator == None
        Trace("CreateSceneWithoutCreator", "CreateCreator returned None, aborting")
        return None
    endif
    SkyrimNet_SexLab_Scene sl_scene = CreateSceneByCreator(creator, thread)
    ; Setup copied all values out of the creator; free the pool slot so it is not leaked.
    creator.Release()
    return sl_scene
EndFunction 

; --------------------------------------
; These will get a sl_scene if they can find it or return sl_scene_generic 
; create_if_missing=False: read-only lookup (no allocate/Setup/Release) for JSON/decorators
; --------------------------------------
SkyrimNet_SexLab_Scene Function GetSceneByThread(sslThreadController thread, Bool any_state=False, Bool create_if_missing=True)
    if !any_state
        String s = (thread as sslThreadModel).GetState()
        if s != "animating" && s != "prepare"
            return None 
        endif 
    endif 

    int tid = thread.tid
    if tid < thread_scene.length && thread_scene[tid] != None 
        SkyrimNet_SexLab_Scene sl_scene = thread_scene[tid] as SkyrimNet_SexLab_Scene
        ; SETUP and ACTIVE both count as IsActive(); only reclaim on wrong thread or dead scene
        if sl_scene.GetThread() == thread && sl_scene.IsActive()
            return sl_scene
        endif 
        if !create_if_missing
            return None
        endif
        thread_scene[tid] = None
        sl_scene.Release() 
    endif 

    if !create_if_missing
        return None
    endif

    SkyrimNet_SexLab_Scene_Creator creator = CreateCreator("", thread.Positions, None, None, "", "")
    if creator == None
        Trace("GetSceneByThread", "CreateCreator returned None, aborting")
        return None
    endif
    SkyrimNet_SexLab_Scene sl_scene = CreateSceneByCreator(creator, thread)
    ; Setup copied all values out of the creator; free the pool slot so it is not leaked.
    creator.Release()
    if sl_scene == None 
        Trace("GetSceneByThread", "CreateSceneByCreator returned None, aborting")
        return None
    endif
    return sl_scene
EndFunction


SkyrimNet_SexLab_Scene Function GetSceneByThreadId(int tid, bool any_state=False, Bool create_if_missing=True)
    if sexlab == None 
        Trace("GetSceneBythreadId","Sexlab is None, aborting")
        return None
    endif 
    sslThreadController thread = SexLab.GetController(tid)
    if thread == None 
        Trace("GetSceneBythreadId", "thread is None, aborting")
        return None 
    endif 
    return GetSceneByThread(thread, any_state, create_if_missing) 
EndFunction 

; ----------------------------------------
; Rebuild pool/creator refs from plugin FormIDs. Required after property renames
; (scenes→sl_scenes, scene_generic→sl_scene_generic): Auto fills bake into saves,
; so old saves keep empty new-name properties while creators still work.
bool Function RebuildScenePool()
    String plugin = "SkyrimNet_SexLab.esp"
    ; Scene_00..09 local IDs (matches ESP / Spriggit fill order)
    int[] scene_ids = new int[10]
    scene_ids[0] = 0x80C
    scene_ids[1] = 0x802
    scene_ids[2] = 0x809
    scene_ids[3] = 0x80A
    scene_ids[4] = 0x80B
    scene_ids[5] = 0x80D
    scene_ids[6] = 0x80E
    scene_ids[7] = 0x80F
    scene_ids[8] = 0x810
    scene_ids[9] = 0x811

    Trace("RebuildScenePool", "rebuilding sl_scenes from GetFormFromFile")
    sl_scenes = new SkyrimNet_SexLab_Scene[10]
    int i = 0
    while i < 10
        sl_scenes[i] = Game.GetFormFromFile(scene_ids[i], plugin) as SkyrimNet_SexLab_Scene
        if sl_scenes[i] == None
            Trace("RebuildScenePool", "scene FormID "+scene_ids[i]+" is None", true)
            return false
        endif
        i += 1
    endwhile

    Trace("RebuildScenePool", "rebuilding sl_scene_generic from GetFormFromFile")
    sl_scene_generic = Game.GetFormFromFile(0x812, plugin) as SkyrimNet_SexLab_Scene
    if sl_scene_generic == None
        Trace("RebuildScenePool", "sl_scene_generic FormID 0x812 is None", true)
        return false
    endif

    bool need_creators = !creators || creators.length != 10
    if !need_creators
        i = 0
        while i < 10 && !need_creators
            if creators[i] == None
                need_creators = true
            endif
            i += 1
        endwhile
    endif
    if need_creators
        Trace("RebuildScenePool", "rebuilding creators from GetFormFromFile")
        creators = new SkyrimNet_SexLab_Scene_Creator[10]
        i = 0
        while i < 10
            creators[i] = Game.GetFormFromFile(0x813 + i, plugin) as SkyrimNet_SexLab_Scene_Creator
            if creators[i] == None
                Trace("RebuildScenePool", "creator FormID "+(0x813 + i)+" is None", true)
                return false
            endif
            i += 1
        endwhile
    endif
    return true
EndFunction

; Resolve sl_scene_generic from the property, or FormID 0x812 if still missing.
bool Function ResolveSceneGeneric()
    if sl_scene_generic != None
        return true
    endif
    sl_scene_generic = Game.GetFormFromFile(0x812, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene
    if sl_scene_generic == None
        Trace("ResolveSceneGeneric", "GetFormFromFile(0x812) returned None")
        return false
    endif
    Trace("ResolveSceneGeneric", "recovered sl_scene_generic via GetFormFromFile")
    return true
EndFunction

; Claim an inactive pool scene, reclaiming orphans (IsActive but no live thread).
; Falls back to sl_scene_generic; returns None only if generic cannot be resolved.
SkyrimNet_SexLab_Scene Function GetSceneInactive(sslThreadController thread) 
    if thread == None
        Trace("GetSceneInactive", "thread is None, aborting")
        return None
    endif
    ; Old saves may still have empty sl_scenes if Setup has not rebuilt yet this session.
    if !sl_scenes || sl_scenes.length == 0
        Trace("GetSceneInactive", "sl_scenes empty — RebuildScenePool")
        if !RebuildScenePool()
            Trace("GetSceneInactive", "RebuildScenePool failed", true)
            return None
        endif
        int j = 0
        while j < sl_scenes.length
            sl_scenes[j].Initialize(j, self, false)
            j += 1
        endwhile
        if sl_scene_generic != None
            sl_scene_generic.Initialize(-1, self, true)
        endif
    endif
    int i = 0 
    int num_scenes = sl_scenes.length 
    while i < num_scenes
        SkyrimNet_SexLab_Scene candidate = sl_scenes[i]
        if candidate != None
            ; Busy only if a live SexLab thread is attached — status alone is not enough
            ; when saves leave all slots ACTIVE with no animations running.
            if candidate.GetThreadActive()
                i += 1
            else
                if candidate.IsActive()
                    Trace("GetSceneInactive", "reclaiming orphan sl_scenes["+i+"] sid:"+candidate.sid)
                    candidate.Release()
                endif
                EnsureThreadSceneLargeEnough(thread.tid) 
                thread_scene[thread.tid] = candidate
                candidate.SetThread(thread)
                return candidate
            endif
        else
            i += 1 
        endif
    endwhile
    Trace("GetSceneInactive","Failed to find inactive sl_scene using generic")
    if !ResolveSceneGeneric()
        Trace("GetSceneInactive", "sl_scene_generic is None, aborting")
        return None
    endif
    ; Single shared fallback: do not rebind while it already serves a live thread (no CK pool expand).
    if sl_scene_generic.GetThreadActive()
        Trace("GetSceneInactive", "sl_scene_generic already active for another thread, refusing allocate")
        return None
    endif
    EnsureThreadSceneLargeEnough(thread.tid)
    thread_scene[thread.tid] = sl_scene_generic
    sl_scene_generic.SetThread(thread) 
    return sl_scene_generic
EndFunction 

SkyrimNet_SexLab_Scene Function GetSceneByActor(Actor akActor) 
    if akActor == None 
        Trace("GetSceneByActor","akActor is None, aborting")
        return None 
    endif 
    sslThreadController thread = GetThreadByActor(akActor) 
    if thread == None
        return None 
    endif 
    return GetSceneByThread(thread)
EndFunction

sslThreadController Function GetThreadByActor(Actor akActor) 
    Trace("GetThread","actor:"+akActor.GetDisplayName())
    sslThreadController[] threads = ThreadSlots.Threads
    if threads.length == -1 
        return None 
    endif 

    int i = threads.length - 1
    while 0 <= i
        String status = (threads[i] as sslThreadModel).GetState()
        if status == "animating" || status == "prepare"
            Actor[] actors = threads[i].Positions
            int j = actors.length - 1
            while 0 <= j 
                if actors[j] == akActor
                    return threads[i]
                endif 
                j -= 1
            endwhile 
        endif 
        i -= 1
    endwhile
    return None 
EndFunction 

;----------------------------------------------------------------------------------------------------
; Thread_Scene Functions 
;----------------------------------------------------------------------------------------------------
Function UnsetThread_Scene(int tid)
    if 0 <= tid && tid < thread_scene.length
        thread_scene[tid] = None 
    endif 
EndFunction

Function EnsureThreadSceneLargeEnough(int tid)
    if tid >= thread_scene.length
        Trace("EnsureThreadSceneLargeEnough","tid:"+tid+" thread_scene.length:"+thread_scene.length)
        int new_size = tid + 10
        Form[] resized = Utility.CreateFormArray(new_size)
        int i = 0
        int num_threads = thread_scene.length
        while i < num_threads 
            resized[i] = thread_scene[i]
            i += 1
        endwhile
        thread_scene = resized
    endif
EndFunction

;----------------------------------------------------------------------------------------------------
; Get SceneSettings
;----------------------------------------------------------------------------------------------------
String Function GetSceneSettingFilename(String setting_name)
    return SCENES_FOLDER+"/"+setting_name+".json"
EndFunction
String[] function GetSceneSettings()
    ; 1. Read all filenames from the directory that end in .json
    String[] files = MiscUtil.FilesInfolder(SCENES_FOLDER)

    
    ; Safety check: Handle empty directory or invalid paths smoothly
    if !files || files.Length == 0
        return Utility.CreateStringArray(0)
    endif
    
    ; 2. Initialize your setting_names array dynamically matching the file count
    ; (Vanilla Papyrus requires compile-time constants for array sizes, SKSE bypasses this)
    String[] setting_names = Utility.CreateStringArray(files.Length)
    
    ; 3. Loop through files, strip the extension, and populate setting_names
    int i = 0
    while i < files.Length
        String currentFile = files[i]
        
        ; Find the starting character index of the ".json" extension
        int extIndex = StringUtil.Find(currentFile, ".json")
        
        if extIndex != -1
            ; Extract everything from the start (index 0) up to the dot
            setting_names[i] = StringUtil.Substring(currentFile, 0, extIndex)
        else
            ; Fallback case if a filename slips through without an extension
            setting_names[i] = currentFile
        endif
        
        i += 1
    endwhile
    
    ; 4. Return the clean array of setting names
    return setting_names
endFunction
   
;----------------------------------------------------------------------------------------------------
; Action Events
;----------------------------------------------------------------------------------------------------
Function RegisterEventsActions() 
    Trace("RegisterEventsActions","")
    UnRegisterForModEvent("SkyrimNet_SexLab_Action_Stop")
    UnRegisterForModEvent("SkyrimNet_SexLab_Action_Start")
    RegisterForModEvent("SkyrimNet_SexLab_Action_Stop", "Action_Stop")
    RegisterForModEvent("SkyrimNet_SexLab_Action_Start", "Action_Start")
EndFunction 

Event Action_Stop(Form f_speaker,Form f_target, String style)
    Actor speaker = f_speaker as Actor 
    Actor target = f_target as Actor 
    if speaker == None 
        Trace("Action_Stop", "f_speaker is none, aborting")
        return 
    endif 
    if f_target == None 
        Trace("Action_Stop", "f_target is none, aborting")
        return 
    endif 
    if target == None 
        Trace("Action_Stop", "target is none, aborting")
        return 
    endif 

    Trace("Action_Stop", "speaker: "+speaker.GetDisplayName()+" target: "+target.GetDisplayName()+" style: "+style)
    SkyrimNet_SexLab_Scene sl_scene = GetSceneByActor(target)
    if sl_scene == None 
        Trace("Action_Stop", "No sl_scene found for target: "+target.GetDisplayName())
        return 
    endif 
    if main == None 
        Trace("Action_Stop", "main is None")
        return  
    endif 

    Actor Player = Game.GetPlayer() 
    if sl_scene.has_player
        if speaker != player && main.sex_edit_tags_player
            int yes = 0
            int no = 1
            int no_forcefully = 2
            int no_gently = 3
            int no_silently = 4
            String[] buttons = new String[5]
            buttons[yes] = "Yes"
            buttons[no] = "No"
            buttons[no_forcefully] = "No (forcefully)"
            buttons[no_gently] = "No (gently)"
            buttons[no_silently] = "No (silently)"
            String intent
            String question = speaker.GetDisplayName()+" is trying to stop "+sl_scene.GetIntentMessage(sl_scene.INTENT_STAGE_ONGOING)+", will you allow it?"
            int button = SkyMessage.showArray(question, buttons, getIndex = True) as int 
            if button != yes
                if button == no_silently
                    return 
                endif 
                String player_style = "" 
                if button == no_forcefully
                    player_style = "forcefully"
                elseif button == no_gently
                    player_style = "gently"
                endif 
                String msg = player.GetDisplayName()+" "+player_style+" refuses "+speaker.GetDisplayName()+"'s attempt to "+style+" stop "\
                    +sl_scene.GetIntentMessage(sl_scene.INTENT_STAGE_ONGOING)+"."
                DirectNarration(msg, speaker)
                return
            endif 
        endif 
    endif 

    sslThreadController cachedThread = sl_scene.GetThread()
    sl_scene.AnimationEnd(speaker,style)
    threadSlots.StopThread(cachedThread)
EndEvent 

Event Action_Start(String intent, Form f_speaker, Form f_target, Form f_victim, \
    string style, string method, int speaker_position,\ 
    String event_hook, String setting_name,\ 
    Form f_participate_3)
    Trace("Action_Start","intent:"+intent)
    Actor speaker = f_speaker as Actor 
    Actor target = f_target as Actor 
    Actor victim = f_victim as Actor 
    Actor participate_3 = f_participate_3 as Actor 

    Trace("Action_Start","intent:"+intent\
        +" speaker:"+GetDisplayName(speaker)+" target:"+GetDisplayName(target)+" victim:"+GetDisplayName(Victim)\
        +" style:"+style+" method:"+method+" speaker_position:"+speaker_position+" event_hook:"+event_hook+" setting_name:"+setting_name\
        +" participate_3:"+GetDisplayName(participate_3))

    if speaker == None 
        Trace("StartScene_Event", "speaker is None")
        return 
    endif 

    ; ----------------------------
    ; Build the actors array
    ; ----------------------------
    int num_actors = 1 
    if target != None 
        num_actors += 1 
        if participate_3 != None 
            num_actors += 1 
        endif 
    endif 
    Actor[] actors = PapyrusUtil.ActorArray(num_actors)
    if target == None 
        actors[0] = speaker
    else
        if speaker_position == 0 
            actors[0] = speaker 
            actors[1] = target 
        else 
            actors[1] = speaker 
            actors[0] = target 
        endif 
        if participate_3 != None 
            actors[2] = participate_3
        endif 
    endif 

    SkyrimNet_SexLab_Scene_Creator creator = CreateCreator(intent, actors, speaker, target, method, setting_name)
    if creator == None 
        Trace("Action_Start", "CreateCreator returned None, aborting")
        return 
    endif 
    if creator.LockAllActorLock()
        ; Can't be set by setting
        if victim != None 
            creator.SetVictim(victim)
        endif 
        if style != ""
            creator.SetStyle(style) 
        endif 
        ; Can overwrite the setting values 
        if event_hook != "" 
            creator.SetEventHook(event_hook) 
        endif 

        Creator.StartScene() 
    else 
        creator.Release()
    endif 
EndEvent 


;----------------------------------------------------------------------------------------------------
; SexLab Events
;----------------------------------------------------------------------------------------------------
Function RegisterEventsSexlab() 
    Trace("RegisterSexlabEvents","")
    ; SexLabFramework sexlab = Game.GetForm

    UnRegisterForModEvent("HookAnimationStart")
    RegisterForModEvent("HookAnimationStart", "AnimationStart")
    UnRegisterForModEvent("HookStageStart")
    RegisterForModEvent("HookStageStart", "StageStart")
    ;UnRegisterForModEvent("HookStageEnd")
    ;RegisterForModEvent("HookStageEnd", "SexLab_StageEnd")
    UnRegisterForModEvent("HookAnimationEnd")
    RegisterForModEvent("HookAnimationEnd", "AnimationEnd")

    UnRegisterForModEvent("HookOrgasmStart")
    UnRegisterForModEvent("SexLabOrgasm")
    RegisterForModEvent("SexLabOrgasm", "OrgasmIndividual")
    UnRegisterForModEvent("HookOrgasmStart")
    RegisterForModEvent("HookOrgasmStart", "OrgasmCombined")
EndFunction 

; ----------------------------------------------------------
Event AnimationStart(int ThreadID, bool HasPlayer)
    SkyrimNet_SexLab_Scene sl_scene = GetSceneByThreadId(ThreadID)
    if sl_scene == None 
        Trace("AnimationStart","Scene is None for ThreadID "+ThreadID)
        return
    endif
    sl_scene.AnimationStart() 
EndEvent 


; ----------------------------------------------------------
Event StageStart(int ThreadID, bool HasPlayer)
    SkyrimNet_SexLab_Scene sl_scene = GetSceneByThreadId(ThreadID)
    if sl_scene == None 
        Trace("StageStart","Scene is None for ThreadID "+ThreadID)
        return
    endif
    sl_scene.StageStart() 
EndEvent


; ----------------------------------------------------------
event AnimationEnd(int ThreadID, bool HasPlayer)
    ; create_if_missing=False: Action_Stop may already have AnimationEnd+Release; do not allocate a new scene.
    SkyrimNet_SexLab_Scene sl_scene = GetSceneByThreadId(ThreadID, any_state=True, create_if_missing=False)
    if sl_scene == None 
        Trace("AnimationEnd","Scene is None for ThreadID "+ThreadID)
    else 
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
        sl_scene.AnimationEnd() 
    endif
EndEvent 

; Function AllowedDeniedOnlyIncrease(Actor[] actors, sslThreadController thread, String status)
    ; if !Game.GetModByName("SexLabAroused.esm")  != 255
        ; return
    ; endif
    ; Store orgasm denied actor's arousal level before sex, It is not allowed to lower 
    ;q = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as Quest
    ;SkyrimNet_SexLab_main main = q as SkyrimNet_SexLab_Main
    ;SkyrimNet_SexLab_Stages stages_lib = q as SkyrimNet_SexLab_Stages

    ; int[] orgasm_denied = new int [1] ; stages.GetOrgasmDenied(thread)
    ; int satisifcation_idx = slaInternalModules.RegisterStaticEffect("Orgasm")
; 
    ; int i = orgasm_denied.length - 1
    ; while 0 <= i    
        ; float sat_value = slaInternalModules.GetStaticEffectValue(actors[i], satisifcation_idx)
        ; if orgasm_denied[i] == 1
            ; if status == "start"
                ; StorageUtil.SetFloatValue(actors[i], storage_arousal_key, sat_value)
            ; else
                ; float stored_value = StorageUtil.GetFloatValue(actors[i], storage_arousal_key)
                ; if stored_value < sat_value
                    ; StorageUtil.SetFloatValue(actors[i], storage_arousal_key, sat_value)
                ; elseif stored_value > sat_value
                    ; slaInternalModules.SetStaticArousalValue(actors[i], satisifcation_idx, stored_value)
                    ; Trace("AllowedDeniedOnlyIncrease",actors[i].GetDisplayName()+" orgasm denied, so erasing orgasm satisifaction "+sat_value+" -> "+stored_value)
                ; endif 
            ; endif 
        ; endif 
        ; sat_value = slaInternalModules.GetStaticEffectValue(actors[i], satisifcation_idx)
        ; i -= 1
    ; endwhile
; EndFunction

; ----------------------------------------------------------------------------------------------------
; Orgasm Event Functions 
; This function is not called when flag SLSO, as it has its own orgasm handling
; ----------------------------------------------------------------------------------------------------
Event OrgasmCombined(int ThreadID, bool HasPlayer)
    ; Ignore if separate orgasms is on, as it has its own handling
    sslSystemConfig config = (SexLab as Quest) as sslSystemConfig
    if config.SeparateOrgasms 
        return 
    endif 
    SkyrimNet_SexLab_Scene sl_scene = GetSceneByThreadId(ThreadID)
    if sl_scene == None 
        Trace("OrgasmCombined","Scene is None for ThreadID "+ThreadID)
        return
    endif
    sl_scene.OrgasmCombined() 
EndEvent 

; Used for SLSO.esp orgasm handling
; SexLab PushForm sends attached-script type (e.g. WIDeadBodyCleanupScript); receive Form then cast.
Event OrgasmIndividual(Form akForm, int full_enjoyment, int num_orgasms)
    Actor akActor = akForm as Actor
    if !akActor
        return
    endif

    sslSystemConfig config = (SexLab as Quest) as sslSystemConfig
    if !config.SeparateOrgasms 
        return 
    endif 

    ; DOM handles it's own orgasms
    if main.handler_dom.IsDOMSlave(akActor)
        return
    endif 

    SkyrimNet_SexLab_Scene sl_scene = GetSceneByActor(akActor)
    if sl_scene == None
        Trace("OrgasmIndividual","Scene is none for actor: "+akActor.GetDisplayName())
        return
    endif
    sl_scene.OrgasmIndividual(akActor, full_enjoyment, num_orgasms) 
EndEvent

int Function GettotalOrgasms(Actor akActor)
    SkyrimNet_SexLab_Scene sl_scene = GetSceneByActor(akActor)
    if sl_scene == None 
        return 0 
    endif 
    return sl_scene.GettotalOrgasms(akActor)
EndFunction

Function OrgasmCustom(Actor akActor, String msg) 
    SkyrimNet_SexLab_Scene sl_scene = GetSceneByActor(akActor)
    if sl_scene == None 
        return 
    endif 
    sl_scene.OrgasmCustom(akActor, msg + ". "+GetDisplayName(akActor)+" is orgasming.")
EndFunction



; ------------------------------------------------------
; JSON 
; ------------------------------------------------------
Function SaveThreadsJson()
    GetThreadsJson()
EndFunction

String Function GetThreadsJson(Actor speaker = None)
    if speaker == None 
        if speaker_last != None 
            speaker = speaker_last
        else 
            speaker = Game.GetPlayer()
        endif 
    else 
        speaker_last = speaker
    endif 

    if main == None
        Trace("GetthreadsJson","main is None")
        return "{}"
    endif

    sslThreadController[] threads = ThreadSlots.Threads

    int obj = JMap.object() 
    JMap.setStr(obj, "counter", thread_counter)
    thread_counter += 1 

    int threads_array = JArray.object() 
    int i = 0
    while i < threads.length
        ; Read-only: do not allocate/Setup scenes while dumping JSON
        SkyrimNet_SexLab_Scene sl_scene = GetSceneByThread(threads[i], False, False)
        if sl_scene != None 
            if sl_scene.GetThreadActive() 
                JArray.addObj(threads_array, sl_scene.GetThreadObj(speaker))
            endif 
        endif 
        i += 1
    endwhile

    int threads_dom = main.handler_dom.GetThreads()
    if threads_dom
        i = JArray.count(threads_dom) - 1
        while i >= 0
            int thread = JArray.getObj(threads_dom, i)
            String description = JMap.getStr(thread, "description")
            if description != ""
                ; Enrich actors for prompts without SetActor StorageUtil / orgasm side effects
                int actor_objs = JMap.getObj(thread, "actors")
                int j = JArray.count(actor_objs) - 1
                Actor akActor = None
                bool speaker_in_thread = false
                while j >= 0
                    int actor_obj = JArray.getObj(actor_objs, j)
                    Actor a = JMap.getForm(actor_obj, "form") as Actor
                    if a != None
                        akActor = a
                        if speaker != None && a == speaker
                            speaker_in_thread = true
                        endif
                        EnrichActorObjForJson(actor_obj, a)
                    endif
                    j -= 1
                endwhile

                float distance = 0.0
                bool los = false
                if speaker != None
                    if speaker_in_thread
                        distance = 1.0
                        los = true
                    elseif akActor != None
                        distance = 0.0142875 * speaker.GetDistance(akActor)
                        los = speaker.HasLOS(akActor)
                    endif
                endif

                AddStrIfNotDefined(thread, "location", "floor")
                AddStrIfNotDefined(thread, "style", "normal")
                JMap.setFlt(thread, "speaker_distance", distance)
                JMap.setInt(thread, "speaker_los", los as int)
                JArray.addObj(threads_array, thread)
            endif
            i -= 1
        endwhile
    endif

    JMap.setObj(obj, "threads", threads_array) 

    String json = SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(obj) 
    
    JValue.release(obj) 
    JValue.release(threads_dom)
    Miscutil.WriteToFile(threads_filename, json, append=False)
    return json
EndFunction 

; Prompt-safe actor fields for DOM threads. No StorageUtil / SexLab thread mutation.
Function EnrichActorObjForJson(int actor_obj, Actor akActor)
    if actor_obj == 0 || akActor == None
        return
    endif
    JMap.setStr(actor_obj, "uuid", UuidToDecimalString(SkyrimNetApi.GetEntityUUID(akActor)))
    JMap.setStr(actor_obj, "formid", akActor.GetFormID())
    AddStrIfNotDefined(actor_obj, "name", akActor.GetDisplayName())
    if !JMap.hasKey(actor_obj, "victim")
        JMap.setInt(actor_obj, "victim", 0)
    endif
    if !JMap.hasKey(actor_obj, "arousal")
        JMap.setInt(actor_obj, "arousal", -1)
    endif
    if !JMap.hasKey(actor_obj, "notice_level")
        JMap.setStr(actor_obj, "notice_level", "nothing")
    endif
    if !JMap.hasKey(actor_obj, "creature_description")
        JMap.setStr(actor_obj, "creature_description", "")
    endif
    if !JMap.hasKey(actor_obj, "is_hermaphrodiate")
        JMap.setInt(actor_obj, "is_hermaphrodiate", 0)
    endif
    if !JMap.hasKey(actor_obj, "wearing_strapon")
        JMap.setInt(actor_obj, "wearing_strapon", 0)
    endif
    if !JMap.hasKey(actor_obj, "speaking_modifiers")
        JMap.setObj(actor_obj, "speaking_modifiers", JArray.object())
    endif
    if main != None && main.handler_dom.IsDOMSlave(akActor)
        JMap.setInt(actor_obj, "dom_slave", 1)
    else
        JMap.setInt(actor_obj, "dom_slave", 0)
    endif
EndFunction

Function AddStrIfNotDefined(int obj, String key_, String value)
    if JMap.hasKey(obj, key_)
        return
    endif
    JMap.setStr(obj, key_, value)
EndFunction

String Function GetStyleDialog(String msg) global
    String[] buttons = new String[4]
    buttons[0] = "forcefully"
    buttons[1] = "normally"
    buttons[2] = "gently"
    buttons[3] = "silently"
    return SkyMessage.ShowArray(msg, buttons, getIndex=False) as String
EndFunction

; ----------------------------------------------------------------------------------------------------
; Check if actor is busy
; ----------------------------------------------------------------------------------------------------

bool Function IsBusy(Actor akActor) 
    if akActor == None 
        Trace("IsActorBusy","akActor is None")
        return false
    endif

    if akActor.IsDead() || akActor.IsInCombat() 
        return true 
    endif 

    if sexlab.IsActorActive(akActor) 
        return true 
    endif 

    if OstimActorCountFaction != None && akActor.IsInFaction(OStimActorCountFaction)
        return true 
    endif

    return false
EndFunction