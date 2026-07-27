Scriptname SkyrimNet_SexLab_Stages extends Quest 


SkyrimNet_SexLab_Main Property main Auto
SkyrimNet_SexLab_Scene_Manager Property manager Auto 
sslActorLibrary Property actorLib Auto
import StorageUtil
import SkyrimNet_SexLab_Decorators
import SkyrimNet_SexLab_Utilities

Bool Property hide_help = false Auto

Actor player = None 

String Property animations_folder = "Data/SKSE/Plugins/SkyrimNet_SexLab/animations" AutoReadOnly
String Property local_folder = "Data/SKSE/Plugins/SkyrimNet_SexLab/animations/_local_" AutoReadOnly

String VERSION_1_0 = "1.0"
String VERSION_2_0 = "2.0"

String desc_input = "" 

String Button_Ok = "Ok"
String Button_Cancel = "Cancel"
String Button_Next = "Next"
String Button_Previous = "Previous"
String Button_Accept = "Accept"
String Button_Rewrite = "Rewrite"
String Button_Retry = "Retry"
String Button_Never_Show_Again = "Never Show Again"
String Button_orgasm_expected = "Orgasm Expected"
String Button_Stop_Tracking = "Stop Tracking"
String Button_Start_Tracking = "Start Tracking"
String Button_Go_Back = "Go Back"
String Button_Done = "Done"

SkyrimNet_SexLab_Actions Property actions Auto

String storage_key = "skyrimnet_sexlab_stages_anim_info"

int anim_info_cache = 0

; Devious Devices
bool devices_found = false 
Keyword Property zad_DeviousBelt Auto

; formating 
String newline = "" 

Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Stages", func, msg)
    if notification
        Debug.Notification(logged)
    endif 
EndFunction

Function Setup()
    String temp = "sl" ; attempt to set the capitalization of sl 
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        return
    endif

    newline = StringUtil.AsChar(10)

    ; Devious Devices
    ;if Game.GetModByName("Devious Devices - Assets.esm") != 255
        ;devices_found = true
        ;zad_DeviousBelt = Game.GetFormFromFile(0x00F624, "Devious Devices -Assets.esm") as Keyword
        ;if zad_DeviousBelt == None 
            ;Trace("Setup","Devious Devices found but zad_DeviousBelt is None")
            ;devices_found = false
        ;endif
    ;else 
        ;devices_found = false
    ;endif 
    devices_found = false ; temporarily disable devices integration until I can test and optimize it, since checking for the belt keyword on every stage update is causing some performance issues.

    desc_input = ""
    if player == None 
        player = Game.GetPlayer()
    endif 

    if anim_info_cache <= 0 
        anim_info_cache = JMap.object() 
        JValue.retain(anim_info_cache) 
    else 
        JValue.clear(anim_info_cache) 
    endif 
EndFunction

Bool Function Setup_CheckLinks()
    Bool links_ok = true

    main = (self as Quest) as SkyrimNet_SexLab_Main
    if main == None
        links_ok = false
    endif

    actions = (self as Quest) as SkyrimNet_SexLab_Actions
    if actions == None
        links_ok = false
    endif

    if manager == None
        manager = (self as Quest) as SkyrimNet_SexLab_Scene_Manager
        if manager == None
            links_ok = false
        endif
    endif

    return links_ok
EndFunction

String Function GetStageDescription(sslThreadController thread, int stage_override = -1 )
    if thread == None 
        Trace("GetStageDescription", "thread is None", true)
        return ""
    endif 
    int stage = thread.stage
    if stage_override > 0 
        stage = stage_override 
    endif 
    int anim_info = GetAnim_Info(thread)
    String result = ""
    if anim_info != 0
        bool found = false
        while 0 <= stage && !found
            String stage_id = "stage "+stage
            int desc_info = JMap.getObj(anim_info, stage_id)
            if desc_info != 0 
                Actor[] actors = thread.Positions
                String desc = JMap.getStr(desc_info, "description")
                String version = JMap.getStr(desc_info, "version")
                result = AddActorDescriptionActors(version, actors, desc)
                found = true
            endif 
            stage -= 1
        endwhile 
        JValue.release(anim_info)
    endif 
    return result
EndFunction 

String Function AddActorDescriptionActors(String version, Actor[] actors, String desc)
    Trace("AddActorDescriptionActors","version"+version+" actors:"+JoinActors(actors)+" desc:"+desc) 
    if desc == ""
        Trace("AddActorDescriptionActors","Description is empty")
        return ""
    endif 
    if (actors.Length == 0 || actors[0] == None || actors[0].GetDisplayName() == "")  
        Trace("AddActorDescriptionActors","Actors are none or have not name")
        return ""
    endif 

    String result = "" 
    if version == VERSION_1_0
        if actors.length == 1 
            result = actors[0].GetDisplayName()+" "+desc+"."
            String last_char = StringUtil.GetNthChar(desc,StringUtil.GetLength(desc) - 1)
            if !StringUtil.IsPunctuation(last_char)
                result += "."
            endif
        else
            result = actors[1].GetDisplayName()+" "+desc+" "+actors[0].GetDisplayName()+"."
        endif 
    else
        if version != VERSION_2_0
            Trace("AddActorDescriptionActors","Unknown version "+version)
        endif 
        int size = actors.length
        int actors_arr = JArray.object()
        int i = 0 
        while i < size 
            JArray.addStr(actors_arr, actors[i].GetDisplayName())
            i += 1 
        endwhile 
        int obj = JMap.object()
        JMap.setObj(obj, "actors", actors_arr)
        String json = ObjectToLowerCaseKeyJson(obj)
        JValue.release(obj)
        result = SkyrimNetApi.ParseString(desc, "sl", json)
        Trace("AddActorDescriptionActors","json: "+json+" desc: "+desc+" result: "+result)
    endif 
    return result
EndFunction 
; ------------------------------------
; Edit Description Function 
; Returns True if there was a thread to edit
; ------------------------------------

Function EditDescriptions(sslThreadController thread)
    Trace("EditDecriptions","-- a")
    if thread == None 
        Trace("EditDescriptions","thread is None")
        return
    endif 
    Trace("EditDecriptions","-- b")
    SkyrimNet_SexLab_Scene sl_scene = manager.GetSceneByThread(thread)
    if sl_scene == None 
        Trace("EditDescriptions","sl_scene is None")
        return 
    endif 
    Trace("EditDecriptions","-- c")

    Actor[] actors = thread.Positions

    sslBaseAnimation anim = thread.animation
    String fname = GetFilename(thread)
    Trace("EditDescriptions","fname: "+fname)

    Trace("EditDecriptions","-- d")
    String[] buttons = new String[8]
    int desc_prev = 0 
    int desc_edit = 1 
    int desc_next = 2 
    int stop = 3
    int orgasm_edit = 4 
    int tracking = 5 
    int style_edit = 6
    int done = 7
    buttons[desc_prev] = "Previous"
    buttons[desc_edit] = "Desc. Edit"
    buttons[desc_next] = "Next"
    buttons[stop] = "Stop"
    buttons[orgasm_edit] = "Orgasm Expected"
    buttons[tracking] = "Start Tracking" 
    buttons[style_edit] = "Style"
    buttons[done] = "Done"

    int button = desc_prev

    Trace("EditDecriptions","-- e")
    while button != done 
        String source = "" 
        String desc = "" 
        int desc_stage = thread.stage 
        int anim_info = GetAnim_Info(thread, true)
        while 0 <= desc_stage && desc == "" 
            String stage_id = "stage "+desc_stage
            int desc_info = JMap.getObj(anim_info, stage_id)
            if desc_info == 0
                desc_stage -= 1 
            else 
                String desc_inja = JMap.getStr(desc_info, "description")
                source = JMap.getStr(desc_info, "source")
                String version = JMap.getStr(desc_info, "version")
                desc = AddActorDescriptionActors(version, actors, desc_inja)
            endif 
        endwhile 
        if anim_info != 0
            JValue.release(anim_info)
        endif 

    Trace("EditDecriptions","-- g")
        if sl_scene.tracking
            buttons[tracking] = Button_Stop_Tracking
        else
            buttons[tracking] = Button_Start_Tracking
        endif 

        String msg = "name:"+thread.animation.name+newline\
               +"tags:"+SkyrimNet_SexLab_Scene.GetTagsString(thread.animation)+newline
        if desc == "" 
            if !hide_help
                msg += "You may enter a description for stage "+thread.stage+"."+newline
                msg += "ex: " + BuildExample(actors)
            else 
                msg += "Stage "+thread.stage+": (no description)"+newline
            endif 
        else 
            if desc_stage != thread.stage
                buttons[desc_edit] = "add for stage "+thread.stage
                source = "from "+desc_stage+" stage"
            endif 
            String source_stage = source +" "+thread.stage+"/"+thread.animation.StageCount() 
            msg += "["+source_stage+"] "+desc
        endif 
        msg += newline+"style:"+sl_scene.GetStyle() 
        int[] orgasm_mask = GetOrgasmExpected(thread)
        if orgasm_mask.length == actors.length 
            int i = orgasm_mask.length - 1
            while 0 <= i 
                if orgasm_mask[i] == 1
                    orgasm_mask[i] = 0
                else
                    orgasm_mask[i] = 1
                endif 
                i -= 1
            endwhile
            String names = JoinActorsMasked(actors, orgasm_mask)
            if names != "" 
                msg += ""+newline+"Orgasm not expected for: "+names
            endif 
        endif 
        button = SkyMessage.ShowArray(msg, buttons, getIndex = true) as int  

        if button < 0 || button > done
            Trace("EditDecriptions","-- h cancel/ESC button:"+button)
            return
        endif
    Trace("EditDecriptions","-- h button: "+ buttons[button] )
        if button == desc_prev
            if thread.stage > 1 
                thread.GoToStage(thread.stage - 1)
            endif 
        elseif button == desc_next 
            if thread.stage + 1 <= thread.animation.StageCount()
                thread.GoToStage(thread.stage + 1)
            endif 
        elseif button == desc_edit  
            EditorDescription(main, sl_scene)
        elseif button == orgasm_edit 
            SetOrgasmExpected(thread)
        elseif button == tracking 
            sl_scene.tracking = !sl_scene.tracking
        elseif button == style_edit 
            ; Live Scene only: one DN per style change. Scene_Creator / SetStyleDialog stay silent.
            sl_scene.SetStyleDialog() 
        elseif button == stop 
            String style = SkyrimNet_SexLab_Scene_Manager.GetStyleDialog("How will you stop it?")
            actions.SceneStop_Target(player, actors[0], style)
            return
        endif 
    endwhile 

    Trace("EditDecriptions","-- k")

EndFunction 

; ------------------------------------
; Editor Functions 
; ------------------------------------
string Function GetPlayerInput() global
    Trace("GetPlayerInput","GetPlayerInput called")
    ; Don't do this if we're in VR
    if SkyrimNetApi.IsRunningVR()
        Trace("SkyrimNetInternal","GetPlayerInput: Skipping input in VR")
        Debug.Notification("Text input is disabled in VR")
        return ""
    endif

    ; ---------------------------------------------

    UIExtensions.OpenMenu("UITextEntryMenu")
    string messageText = UIExtensions.GetMenuResultString("UITextEntryMenu")
    Trace("GetPlayerInput","GetPlayerInput returned: " + messageText)
    return messageText
EndFunction

Function EditorDescription(SkyrimNet_SexLab_Main main, SkyrimNet_SexLab_Scene sl_scene) 
    sslThreadController thread = sl_scene.GetThread()
    
    int thread_id = thread.tid
    Actor[] actors = thread.Positions
    String stage_id = "stage "+thread.stage
  ;  uiextensions.InitMenu("UITextEntryMenu")
    ;uiextensions.OpenMenu("UITextEntryMenu")
    ;    desc_input = UIExtensions.GetMenuResultString("UITextEntryMenu")
    desc_input = GetPlayerInput()
    String version = VERSION_2_0
    if desc_input != ""
        String desc = AddActorDescriptionActors(version, actors, desc_input)
        if desc != ""
            int accept = 0
            int rewrite = 1 
            int cancel = 2
            String[] buttons = new String[3]
            buttons[accept] = "Accept"
            buttons[rewrite] = "Rewrite" 
            buttons[cancel] = "Cancel"
            String full = thread.animation.name+newline \
                +"tags:"+SkyrimNet_SexLab_Scene.GetTagsString(thread.animation)+newline+newline \
                + thread.stage+"/"+thread.animation.StageCount() + \
                   " On {the floor/a bed}, "+desc 

            int button = SkyMessage.ShowArray(full, buttons, getIndex = true) as int  

            if button == accept 
                sl_scene.tracking = true
                UpdateAnimInfo(thread, "stage", version, new int[1] )
            elseif button == rewrite
                EditorDescription(main, sl_scene)
            endif 
        else
            String msg = "Your description wasn't parsed correctly."+newline
            int i = 0 
            int count = actors.length
            while i < count
                msg += "{{sl.actors."+i+"}}: "+actors[i].GetDisplayName()+newline
                i += 1
            endwhile 
            msg += BuildExample(actors)

            int retry = 0 
            int cancel = 1
            String[] buttons = new String[2]    
            buttons[retry] = "Retry"
            buttons[cancel] = "Cancel"

            int button = SkyMessage.ShowArray(msg, buttons, getIndex = true) as int  

            if button == retry
                EditorDescription(main, sl_scene)
            endif 
        endif 
    endif 
    desc_input = ""
EndFunction

String Function BuildExample(Actor[] actors) 
    String example = "{{sl.actors.1}} is having sex with {{sl.actors.0}}."
    if actors.length == 1
        example = "{{sl.actors.0}} is masturbating."
    elseif actors.length > 3
        example = "{{sl.actors.2}}, {{sl.actors.1}}, and {{sl.actors.0}} are having an orgy."
    endif 
    String desc = AddActorDescriptionActors(VERSION_2_0, actors, example)
    return "'"+example+"'"+newline+ "'"+desc+"'"
EndFunction



; ------------------------------------
; Orgasm Expected Functions
; ------------------------------------
int[] Function GetOrgasmExpected(sslThreadController thread) 
    Trace("GetOrgasmExpected","thread: "+thread.tid+" "+thread.animation.name)
    String fname = GetFilename(thread)
    Actor[] actors = thread.Positions
    int anim_info = GetAnim_Info(thread)
    if anim_info == 0
        return Utility.CreateIntArray(actors.length, 0)
    endif 
    int id = 0 
    if JMap.hasKey(anim_info, "orgasm_expected")
        id = JMap.getObj(anim_info, "orgasm_expected")
    endif 

    int count = 0 
    if id != 0 
        count = Jarray.count(id)
    endif 
    if count == actors.length
        int[] orgasm_expected = JArray.asIntArray(id)
        Trace("GetOrgasmExpected","values found in file orgasm_expected: "+orgasm_expected)
        JValue.release(anim_info)
        return orgasm_expected
    endif 

    if actors.length > 2
        Trace("GetOrgasmExpected","more than 2 actors, all orgasm expected")
        JValue.release(anim_info)
        return Utility.CreateIntArray(actors.length, 1)
    endif

    int[] orgasm_expected = Utility.CreateIntArray(actors.length, 1)
    sslBaseAnimation Animation = thread.animation
    Trace("GetOrgasmExpected","tags:"+animation.GetRawTags())

    int i = actors.length - 1
    while 0 <= i 
        ; -1 - no gender 
        ;  0 - Male (also the default values if the actor is not existing)
        ;  1 - Female
        int gender = actors[i].GetLeveledActorBase().GetSex() ; actorLib.GetGender(actors[i])
        int gender_sexlab = main.sexlab.GetGender(actors[i]) 
        bool has_penis = gender != 1 || (gender_sexlab != 1 && gender_sexlab != 3)
        bool has_pussy = gender == 1 || gender_sexlab == 1 || gender_sexlab == 3


        String reason = ""
        if devices_found && actors[i].WornHasKeyword(zad_DeviousBelt)
            orgasm_expected[i] = 0
            reason = "has DD belt"
        elseif Animation.HasTag("Estrus")
            orgasm_expected[i] = 1
            reason = "animation has tag estrus"
        elseif Animation.HasTag("69") || Animation.HasTag("Masturbation")
            orgasm_expected[i] = 1
            reason = "animation has tag 69 or masturbation"
        else
            if i == 0 
                if has_pussy && (Animation.HasTag("Vaginal") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Lesbian") || Animation.HasTag("Fingering") || Animation.HasTag("Dildo"))
                    orgasm_expected[i] = 1 
                    reason = "position 0 with pussy and tag: vaginal, cunnilingus, lesbian, fingering, or dildo"
                elseif Animation.hasTag("Anal") || Animation.HasTag("Fisting")
                    orgasm_expected[i] = 1 
                    reason = "position 0 with tags: anal or fisting)"
                else
                    orgasm_expected[i] = 0
                    reason = "position 0 with out: pussy+tag(vaginal, cunnilingus, lesbian, fingering, dildo) or (anal, fisting)"
                endif 
            else 
                if has_penis && (Animation.HasTag("Vaginal") || Animation.HasTag("Boobjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Handjob") || Animation.HasTag("Footjob") || Animation.HasTag("Oral") || Animation.HasTag("Anal"))
                    orgasm_expected[i] = 1
                    reason = "position 1+ with penis and tags: vaginal, boobjob, blowjob, handjob, footjob, oral, or anal"

                else
                    orgasm_expected[i] = 0
                    reason = "position 1+ without penis+tag(vaginal, boobjob, blowjob, handjob, footjob, oral, anal)"
                endif 
            endif 
        endIf

        String name = actors[i].GetDisplayName()
        bool expected = orgasm_expected[i] == 1 
        ; Trace("GetOrgasmExpected","    "+i+" "+name+" pussy:"+has_pussy+" penis:"+has_penis+" orgasm_expected:"+expected+" reasoning:"+reason)
        i -= 1
    endwhile
    Trace("GetOrgasmExpected","    orgasm_expected: "+orgasm_expected)
    JValue.release(anim_info)
    return orgasm_expected
EndFunction

Function SetOrgasmExpected(sslThreadController thread)
    SkyrimNet_SexLab_Scene sl_scene = manager.GetSceneByThread(thread)
    if sl_scene == None 
        Trace("SetOrgasmExpected","sl_scene is None")
        return 
    endif 

    Actor[] actors = thread.Positions
    int num_actors = actors.length
    int anim_info = GetAnim_Info(thread)
    int orgasm_expected_id = JMap.getObj(anim_info, "orgasm_expected")
    int count = Jarray.count(orgasm_expected_id)

    int[] orgasm_expected = Utility.CreateIntArray(num_actors, 0)
    int i = num_actors - 1
    while 0 <= i 
        if i < count
            orgasm_expected[i] = JArray.getInt(orgasm_expected_id, i)
        else
            orgasm_expected[i] = 0
        endif 
        i -= 1
    endwhile
    if anim_info != 0
        JValue.release(anim_info)
    endif 

    String[] buttons = Utility.CreateStringArray(num_actors + 2)
    int go_back = 0
    int done = num_actors + 1

    buttons[go_back] = Button_Go_Back
    buttons[done] = Button_Done
    int button = 1
    bool changed  = false
    while button != go_back && button != done 
        i = 0 
        String msg = "Change if an actor orgasm expected."+newline
        while i < actors.length
            String name = actors[i].GetDisplayName()
            if orgasm_expected[i] == 1
                msg += ""+newline+name+"'s expects an orgasm."
                buttons[i+1] = "Change "+ name+" to not expect orgasm."
            else
                msg += ""+newline+name+"'s doesn't expects an orgasm."
                buttons[i+1] = "Change "+ name+" to expect orgasm."
            endif 
            i += 1
        endwhile

        button = SkyMessage.ShowArray(msg, buttons, getIndex = true) as int
        if button < 0
            ; ESC/cancel: exit without save unless already toggled.
            if changed
                UpdateAnimInfo(thread, "orgasm_expected", VERSION_2_0, orgasm_expected)
            endif
            return
        elseif go_back < button && button < done
            changed = true
            i = button - 1
            if orgasm_expected[i] == 1
                orgasm_expected[i] = 0
            else
                orgasm_expected[i] = 1    
            endif
        endif
    endwhile

    if changed 
        UpdateAnimInfo(thread, "orgasm_expected", VERSION_2_0, orgasm_expected)
    endif 

    if button == done
        return
    elseif button == go_back
        EditorDescription(main, sl_scene) 
        return 
    endif 
EndFunction

; ------------------------------------
; Helper functions
; ------------------------------------

bool[] Function GetHasDescriptionOrgasmExpected(sslThreadController thread)
    int anim_info = GetAnim_Info(thread)
    bool[] desc_orgasmExpected = Utility.CreateBoolArray(2, false)
    if anim_info == 0 
        return desc_orgasmExpected
    endif 
    String stage_id = "stage "+thread.stage
    desc_orgasmExpected[0] = JMap.hasKey(anim_info, stage_id)
    int orgasm_expected = JMap.getObj(anim_info, "orgasm_expected")
    if orgasm_expected != 0
        desc_orgasmExpected[1] = true
    endif 
    JValue.release(anim_info)
    return desc_orgasmExpected
EndFunction

int Function GetAnim_Info(sslThreadController thread, Bool force_load=False)

    ; Load the local version if it exists and we aren't forcing a reload 
    sslBaseAnimation anim = thread.animation
    ;if False 
        ;Bool anim_info_cached = JMap.HasKey(anim_info_cache, anim.name)
        ;if !force_load && anim_info_cached
            ;int anim_info = JMap.getObj(anim_info_cache, anim.name) 
            ;if anim_info != 0 
                ;String name = JMap.getStr(anim_info, "name")
                ;JValue.writeToFile(anim_info, animations_folder+"/anim_info_loaded.json")
                ;return anim_info
            ;endif 
        ;endif 
            ;
        ;; This will hold a map between the Stage and the descriptions 
        ;if anim_info_cached
            ;int anim_info = JMap.getObj(anim_info_cache, anim.name) 
            ;if anim_info != 0 
                ;JValue.release(anim_info)
            ;endif 
            ;JMap.removeKey(anim_info_cache, anim.name)
        ;endif 
    ;endif 

    ; This will hold a map between the Stage and the descriptions 
    int anim_info = JMap.object() 
    JMap.setStr(anim_info, "name", anim.name)

    String[] folders = MiscUtil.FoldersInfolder(animations_folder)

    String fname = GetFilename(thread)
    ; Make sure the local folder is processed last
    int i = folders.length - 1
    while 0 <= i && folders[i] != "_local_"
        i -= 1
    endwhile 
    if 0 < i 
        folders[i] = folders[0]
        folders[0] = "_local_"
    endif

    i = folders.Length - 1
    while 0 <= i
        String fn = animations_folder+"/"+folders[i]+"/"+fname
        if MiscUtil.FileExists(fn)
            Trace("GetAnim_Info","loading: "+fn)
            int info = JValue.readFromFile(fn)
            if info != 0
                String[] keys = JMap.allKeysPArray(info)
                int k = keys.length - 1
                while 0 <= k
                    if keys[k] == "orgasm_expected"
                        int orgasm_expected = JMap.getObj(info, "orgasm_expected")
                        JMap.setObj(anim_info, "orgasm_expected", orgasm_expected)
                    else
                        int desc_info = JMap.getObj(info, keys[k])
                        JMap.setStr(desc_info, "source", folders[i])
                        String stage_id = keys[k]
                        String desc = JMap.getStr(desc_info, "description")
                        JMap.setObj(anim_info, stage_id, desc_info)
                    endif 
                    k -= 1
                endwhile 
                ; setObj retained children into anim_info; release the file root.
                JValue.release(info)
            else 
                Trace("GetAnim_Info", "Parse error for '"+fn+"'", true)
            endif 
        endif
        i -= 1
    endwhile 
    ; setAnimCache(thread, anim_info) 
    MiscUtil.WriteToFile(animations_folder+"/anim_info.json", ObjectToLowerCaseKeyJson(anim_info), append=False)
    ; Retain the returned object so it is not auto-GC'd while a caller reads it;
    ; every caller must JValue.release(anim_info) once done (rebuilt fresh each call).
    JValue.retain(anim_info)
    return anim_info
EndFunction 

Function UpdateAnimInfo(sslThreadController thread, String field, String version, int[] orgasm_expected)
    String fname = GetFilename(thread)
    String path = local_folder+"/"+fname
    int anim_info = 0
    if MiscUtil.FileExists(path)
        anim_info = JValue.readFromFile(path)
        if anim_info == 0
            Trace("UpdateAnimInfo", "Parse error for '"+path+"', aborting save to avoid wiping file")
            return
        endif
    else 
        anim_info = JMap.object()
    endif 
    if field == "stage"
        String stage_id = "stage "+thread.stage
        int stage_info = JMap.object() 
        JMap.setStr(stage_info,"version",version)
        JMap.setStr(stage_info,"description",desc_input)
        JMap.setObj(anim_info, stage_id, stage_info)
    else 
        int orgasm_expected_id = JArray.objectWithSize(orgasm_expected.length)
        int i = orgasm_expected.length - 1
        while 0 <= i 
            JArray.setInt(orgasm_expected_id, i, orgasm_expected[i])
            i -= 1
        endwhile
        JMap.setObj(anim_info, "orgasm_expected", orgasm_expected_id)
    endif 

    Trace("UpdateAnimInfo", "saving "+fname, true)
    String json = ObjectToLowerCaseKeyJson(anim_info)
    MiscUtil.WriteToFile(path, json, append=False)
    MiscUtil.WriteToFile(animations_folder+"/animation_stage_description_last.json", json, append=False)
    JValue.Release(anim_info)
    manager.SaveThreadsJson()
EndFunction 

Function SetAnimCache(sslThreadController thread, int anim_info)
    JMap.setObj(anim_info_cache, thread.animation.name, anim_info) 
    JValue.retain(anim_info)
EndFunction 

String Function GetFilename(sslThreadController thread) global
    sslBaseAnimation anim = thread.animation
    return anim.name+".json"
EndFunction 