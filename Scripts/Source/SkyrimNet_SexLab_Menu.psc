Scriptname SkyrimNet_SexLab_Menu extends Quest  ; Can extend Quest or Form depending on your architecture

SkyrimNet_SexLab_MCM Property mcm Auto
SkyrimNet_SexLab_Main Property main Auto  
SkyrimNet_SexLab_Stages Property stages Auto 
SkyrimNet_SexLab_Scene_Manager Property manager Auto 
SkyrimNet_SexLab_Actions Property actions Auto 

bool debug_mode = false 

Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Menu", func, msg)
    if notification
        Debug.Notification(logged)
    endif 
EndFunction

Function Setup()
    debug_mode = False
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        return
    endif
EndFunction

Bool Function Setup_CheckLinks()
    Bool links_ok = true

    mcm = (self as Quest) as SkyrimNet_SexLab_MCM
    if mcm == None
        links_ok = false
    endif

    main = (self as Quest) as SkyrimNet_SexLab_Main
    if main == None
        links_ok = false
    endif

    stages = (self as Quest) as SkyrimNet_SexLab_Stages
    if stages == None
        links_ok = false
    endif

    manager = (self as Quest) as SkyrimNet_SexLab_Scene_Manager
    if manager == None
        links_ok = false
    endif

    actions = (self as Quest) as SkyrimNet_SexLab_Actions
    if actions == None
        links_ok = false
    endif

    return links_ok
EndFunction

Function ProcessHotkey(int key_code)
    ; Both players need to be in the crosshair to have SkyrimNet load them into the cache
    ; so the parseJsonActor works
    Actor target = Game.GetCurrentCrosshairRef() as Actor 
    Actor player = Game.GetPlayer() 
    
    if target == None && main.sexlab.IsActorActive(player)
        target = player
    endif 
    
    bool target_not_none = target != None
    Trace("ProcessHotkey","target_not_none: "+target_not_none)
    
    if target != None 
        if main.sexlab.IsActorActive(target)
            Trace("ProcessHotkey","target: "+target.getDisplayName()+" in active sex")
            sslThreadController thread = manager.GetThreadbyActor(target)
            if thread != None
                Trace("ProcessHotkey", "thread found "+thread.tid+" for target:"+target.GetDisplayName())
                stages.EditDescriptions(thread)
            else
                Trace("ProcessHotkey","failed to find thread for target:"+target.GetDisplayName())
            endif
        elseif actions.BodyAnimation_IsEligible(target, "", "") && main.sexlab.IsValidActor(target)
            Target_Menu_Selection(target, player)
        endif 
    else 
        MultiTarget_Menu_Selection(player)
    endif 
EndFunction

Function Target_Menu_Selection(Actor target, Actor player)
    bool target_is_undressed = false 
    target_is_undressed = main.HasStrippedItems(target)
    String clothing_string = "undress"
    if target_is_undressed 
        clothing_string = "dress"
    endif 
    
    int cancel = 0 
    int sexlab_ostim = -1
    
    if main.ostimnet_found 
        sexlab_ostim = cancel
        cancel += 1
    endif 

    int masturbate = cancel
    int punish = cancel+1
    int affection = cancel+2
    int sex = cancel+3
    int raped_by_player = cancel+4
    int rapes_player = cancel+5
    int clothing = cancel+6
    
    cancel += 7 

    int bondage = -1
    if mcm.udng_found
        bondage = cancel
        cancel += 1 
    endif  
    
    String[] buttons = Utility.CreateStringArray(cancel+1)

    if sexlab_ostim != -1
        buttons[sexlab_ostim] = mcm.sexlab_ostim_options[mcm.sexlab_ostim_player]
    endif 
    buttons[masturbate] = "masturbate"
    buttons[punish] = "punish"
    buttons[affection] = "affection"
    buttons[sex] = "sex"
    buttons[raped_by_player] = "player rapes"
    buttons[rapes_player] = "rapes player"
    buttons[clothing] = clothing_string
    if bondage != -1 
        buttons[bondage] = "bondage"
    endif 
    buttons[cancel] = "cancel"

    String msg = "Should "+target.getDisplayName()+":"
    int button = SkyMessage.ShowArray(msg, buttons, getIndex = true) as int  

    if button >= 0 && button <= cancel
        Trace("Target_Menu_Selection","button:" +buttons[button])
    endif 
    
    if button == masturbate
        if mcm.sexlab_ostim_player == 1 && main.ostimnet_found
            EventSend_OStimNet("SexStart", target, None, "")
        elseif main.handler_dom.IsDOMSlave(target) 
            main.handler_dom.Start_Masturbate("sexual training", target, player)
        else 
            actions.StartScene_Consensual_one("sexual activities", target, "normal", "")
        endif 
    elseif sexlab_ostim != -1 && button == sexlab_ostim 
        String choice = ""
        if mcm.sexlab_ostim_player == 0
            mcm.sexlab_ostim_player = 1
            choice = "Ostim"
        else
            mcm.sexlab_ostim_player = 0
            choice = "SexLab"
        endif 
        Debug.Notification("Switched to "+choice)
    elseif button == punish 
        String[] bs = new String[4] 
        bs[0] = "spanking"
        bs[1] = "spanking nude"
        bs[2] = "whip"
        bs[3] = "rape"
        String method = SkyMessage.ShowArray("How would you like to punish?", bs, getIndex = false) as string  
        if method == ""
            Trace("Target_Menu_Selection","cancelled punish method selection")
            return
        endif
        string setting_name= "punish_spanking"
        String punish_intent = "physically punishing"
        if method == "spanking nude"
            method = "spanking"
            setting_name= "punish_spanking_victim_nude"
        elseif method == "whipping"  || method == "whip"
            method = "whip"
            setting_name= "punish_whipping_oral"
        elseif method == "rape"
            method = ""
            setting_name= "punish_pleasure_pain_rape"
            punish_intent = "sexual assault"
        endif 
        if debug_mode && main.handler_dom.IsDOMSlave(target) 
            main.handler_dom.StartScene_Nonconsensual_Two_SpeakerVictim(punish_intent, target, player, player, method=method, setting_name=setting_name)
        else
            actions.StartScene_Nonconsensual_Two_TargetVictim(punish_intent, player, target, method=method, setting_name=setting_name)
        endif 
    elseif button == affection
        if mcm.sexlab_ostim_player == 0 || !main.ostimnet_found    
            String[] bs = new String[6] 
            bs[0] = "single hug"
            bs[1] = "hugging"
            bs[2] = "cuddle"
            bs[3] = "spooning"
            bs[4] = "kissing"
            bs[5] = "headpat"
            String method = SkyMessage.ShowArray("How would you like to show affection?", bs, getIndex = false) as string  
            if method == ""
                Trace("Target_Menu_Selection","cancelled affection method selection")
                return
            endif
            string setting_name = "nonsexual_male_position_1"
            if method == "kissing" 
                setting_name = "nonsexual_kissing"
            endif 
            actions.StartScene_Consensual_Two("showing physical affection",player, target=target, style="gently", method=method,setting_name=setting_name)
        else
            Debug.Notification("Affection is not available while OStim is the active framework.")
        endif 
    elseif button == sex
        if debug_mode && main.handler_dom.IsDOMSlave(target) 
            main.handler_dom.StartScene_Consensual_Two("sexual activities", target, player, player)
        else
            actions.StartScene_Consensual_Two("sexual activities", player, target)
        endif 
    elseif button == rapes_player
        if debug_mode && main.handler_dom.IsDOMSlave(target) 
            ; slave (speaker) assaults player (target); speaker is not the victim
            main.handler_dom.StartScene_Nonconsensual_Two_TargetVictim("sexual assault", target, player, player)
        else
            actions.StartScene_Nonconsensual_Two_SpeakerVictim("sexual assault", player, target)
        endif 
    elseif button == raped_by_player
        if debug_mode && main.handler_dom.IsDOMSlave(target) 
            main.handler_dom.StartScene_Nonconsensual_Two_SpeakerVictim("sexual assault", target, player, player)
        else
            actions.StartScene_Nonconsensual_Two_TargetVictim("sexual assault",player, target)
        endif 
    elseif button == clothing
        if clothing_string == "undress"
            clothing_string = "take off"
        Else
            clothing_string = "put on"
        endif 

        ;--------------------------------------------------
        ; How would they like it appear? 
        int forcefully = 0
        int normally = 1
        int gently = 2
        int silently = 3
        buttons = new String[4] 
        buttons[forcefully] = "Forcefully by player "
        buttons[normally] = "By player"
        buttons[gently] = "Gently by player"
        buttons[silently] = "( Silently )"

        button = SkyMessage.ShowArray(msg, buttons, getIndex = true) as int 
        if button < 0
            Trace("Target_Menu_Selection","cancelled clothing appearance selection")
            return
        endif
        String narration = "direct"
        String style = "" 
        if button == gently
            style = "gently"
        elseif button == forcefully
            style = "forcefully"
        elseif button == silently
            narration = "none"
        endif 
        
        ;--------------------------------------------------
        ; Now do the action 
        Trace("Target_Menu_Selection","style:"+style+" clothing_string:"+clothing_string)
        actions.Change_Outfit(player, target, style, clothing_string, narration)

    elseif button == bondage 
        EventSend_UDNG("MenuOpen", target)
    endif 
EndFunction

Function EventSend_OstimNet(String type, Actor speaker, Actor target, String tag)
    int handle = ModEvent.Create("SkyrimNet_SexLab_OStimNet_"+type)
    ModEvent.PushForm(handle, speaker)
    ModEvent.PushForm(handle, target)
    ModEvent.PushString(handle, tag)
    ModEvent.Send(handle)
EndFunction

Function EventSend_UDNG(String type, Actor target)
    int handle = ModEvent.Create("SkyrimNet_SexLab_UDNG_"+type)
    ModEvent.PushForm(handle, target)
    ModEvent.Send(handle)
EndFunction

Function MultiTarget_Menu_Selection(Actor player)
    String msg = "No target in crosshair, looking for nearby sexable actors"
    Debug.Notification(msg)
    Trace("MultiTarget_Menu_Selection",msg)
    
    int[] ranges = new int[5]
    ranges[0] = 100 
    ranges[1] = 200 
    ranges[2] = 400
    ranges[3] = 800
    ranges[4] = 1600

    uilistMenu listMenu = uiextensions.GetMenu("UIlistMenu") AS uilistMenu
    int i = 0
    while i < ranges.length
        listMenu.AddEntryItem(ranges[i]+" units")
        i += 1
    endwhile
    listMenu.AddEntryItem("<cancel>")
    listMenu.OpenMenu()
    int index = listMenu.GetResultInt() 
    
    if index < 0 || index > ranges.length - 1
        Trace("MultiTarget_Menu_Selection","cancelled range selection")
        return
    endif

    ; -----------------------------------------
    Trace("MultiTarget_Menu_Selection","selected index:"+index+" range:"+ranges[index])
    int scan_range = ranges[index]

    int range = 0 
    int scaler = 0
    Actor[] actors_all = new Actor[1]
    
    while actors_all.length < 2 && scaler <= 5
        range = scan_range + 100*scaler
        actors_all = MiscUtil.ScanCellActors(player, range)
        Trace("MultiTarget_Menu_Selection","scaler:"+scaler+" scan range:"+range+" found:"+actors_all.length)
        scaler += 1 
    endwhile 
   
    Trace("MultiTarget_Menu_Selection"," scan range:"+range+" found:"+actors_all.length)

    if actors_all.length < 2
        actors_all = MiscUtil.ScanCellActors(player, 2000)
        if actors_all.length == 0
            Trace("MultiTarget_Menu_Selection","No eligible actors found in the area.")
            return
        endif 
    endif 

    bool[] valid = PapyrusUtil.BoolArray(actors_all.length)
    int num_actors = 0 
    i = actors_all.length - 1

    while 0 <= i 
        if actions.BodyAnimation_IsEligible(actors_all[i], "", "") && main.sexlab.IsValidActor(actors_all[i])
            valid[i] = True
            num_actors += 1
        else 
            valid[i] = False
        endif 
        Trace("MultiTarget_Menu_Selection","i:"+i+" "+actors_all[i].GetDisplayName()+" valid:"+valid[i])
        i -= 1
    endwhile 

    if num_actors < 2
        Trace("MultiTarget_Menu_Selection","Not enough eligible actors found in the area.")
        return
    endif
    Trace("MultiTarget_Menu_Selection","Found "+num_actors+" valid actors.")

    Actor[] actors = PapyrusUtil.ActorArray(num_actors)
    String[] names = Utility.CreateStringArray(num_actors)
    int[] indexes = Utility.CreateIntArray(num_actors)
    
    i = actors_all.length - 1
    int j = 0 
    while 0 <= i
        if valid[i]
            actors[j] = actors_all[i]
            names[j] = actors[j].GetDisplayName()
            j += 1
        endif 
        i -= 1
    endwhile 

    int[] selected = new int[5]

    String cancel = "<cancel>"
    String intent = "sexual activities"
    String setting_name = ""

    int next = 0 
    bool building_list = true 
    index = 1
    listMenu = uiextensions.GetMenu("UIlistMenu") AS uilistMenu
    
    ; I couldn't compare directly to the strings button in some case
    ; so fell back on next and index :(
    bool finished = false
    while finished == false
        listMenu.ResetMenu()

        i = 0 
        String start = "start | "
        if next > 0
            while i < next 
                if i > 0 
                    start += "+"
                endif 
                start += names[selected[i]]
                i += 1
            endwhile 
        else 
            start = "select actors to: "
        endif 
        
        listMenu.AddEntryItem(start)
        listMenu.AddEntryItem("intent: '"+intent+"'>")
        listMenu.AddEntryItem("setting: '"+setting_name+"'>")

        i = 0
        while 0 <= i && i < num_actors
            bool found = false 
            j = 0 
            while j < next && !found 
                if selected[j] == i
                    found = True
                else 
                    j += 1
                endif 
            endwhile
            
            String front = "  "
            if found
                front = "- "
                indexes[i] = j
            elseif next < selected.length
                front = "+ "
                indexes[i] = -1
            endif
            listMenu.AddEntryItem(front+names[i])
            i += 1
        endwhile 

        listMenu.AddEntryItem(cancel)
        listMenu.OpenMenu()
        index = listMenu.GetResultInt()
        
        if index <= 0 
            if 0 < next 
                finished = True 
            endif 
        elseif index == 1 
            String[] buttons = new String[4] 
            buttons[0] = "showing physical affection"
            buttons[1] = "sexual activities"
            buttons[2] = "sexual assault"
            buttons[3] = "custom"

            String msg_intent = "What is the intent?"
            intent = SkyMessage.ShowArray(msg_intent, buttons, getIndex = false) as String
            
            if intent == "custom"
                UIExtensions.OpenMenu("UITextEntryMenu")
                intent = UIExtensions.GetMenuResultString("UITextEntryMenu")
                Trace("MultiTarget_Menu_Selection","custom intent: " + intent)
                if intent == ""
                    intent = "sexual activities"
                endif
            elseif intent == ""
                intent = "sexual activities"
            else 
                setting_name = ""
            endif 
        elseif index == 2
            String[] setting_names = manager.GetSceneSettings() 
            listMenu = uiextensions.GetMenu("UIlistMenu") AS uilistMenu
            listMenu.ResetMenu() 
            int idx = 0 
            while idx < setting_names.length 
                listMenu.AddEntryItem(setting_names[idx]) 
                idx += 1 
            endwhile 
            listMenu.OpenMenu()
            idx = listMenu.GetResultInt()
            if 0 <= idx && idx < setting_names.length 
                setting_name = setting_names[idx]
            else 
                setting_name = "" 
            endif 

        elseif index < num_actors + 3
            index -= 3
            ; Remove only a currently-selected actor; add only when there is free
            ; capacity. When the list is full (next == selected.length) the render loop
            ; stops refreshing indexes[] for unselected rows, leaving a stale -1; without
            ; this guard clicking such a row fell into the remove branch with j = -1 and
            ; wrote selected[-1] / wrongly decremented next.
            if indexes[index] != -1
                j = indexes[index]
                while j < next - 1 
                    selected[j] = selected[j+1]
                    j += 1
                endwhile
                next -= 1
            elseif next < selected.length
                selected[next] = index
                next += 1
            endif
            if next > 0
                Trace("MultiTarget_Menu_Selection","after next:"+next+" selected[index]:"+selected[next - 1])
            endif 
        else 
            return 
        endif 
    endwhile

    Actor[] actors_selected = PapyrusUtil.ActorArray(next)
    i = 0 
    while i < next 
        actors_selected[i] = actors[selected[i]]
        i += 1 
    endwhile 
    Trace("MultiTarget_Menu_Selection","intent:"+intent+" next:"+next+" actors_selected:"+SkyrimNet_SexLab_Utilities.JoinActors(actors_selected))

    if intent == ""
        intent = "sexual activities"
    endif

    Actor speaker = actors_selected[0]
    Actor target = None 
    if next > 1 
        target = actors_selected[1]
    endif 

    String method = ""
    if intent == "comfort"
        setting_name = "nonsexual_male_position_1"
        method = "spooning"
    elseif intent == "showing physical affection" || intent == "showing affection"
        method = "spooning"
        setting_name = "nonsexual_male_position_1"
    endif 

    if intent == "sexual assault"
        SkyrimNet_SexLab_Scene_Creator creator = manager.CreateCreator(intent, actors_selected, speaker, target, setting_name="")
        if creator == None 
            Trace("MultiTarget_Menu_Selection", "CreateCreator returned None, aborting")
            return 
        endif 
        if creator.LockAllActorLock()
            creator.SetVictim(actors_selected[0])
            Creator.StartScene() 
        else 
            creator.Release()
        endif 
    else 
        SkyrimNet_SexLab_Scene_Creator creator = manager.CreateCreator(intent, actors_selected, speaker, target, method=method, setting_name=setting_name)
        if creator == None 
            Trace("MultiTarget_Menu_Selection", "CreateCreator returned None, aborting")
            return 
        endif 
        if creator.LockAllActorLock()
            Creator.StartScene() 
        else 
            creator.Release()
        endif 
    endif 
EndFunction

String Function SexRapeSelection(String current)
    uilistMenu listMenu = uiextensions.GetMenu("UIlistMenu") AS uilistMenu
    listMenu.ResetMenu()
    listMenu.AddEntryItem("sex")
    listMenu.AddEntryItem("rape")
    listMenu.OpenMenu()
    int index = listMenu.GetResultInt() 
    if index == 0
        return "sex>"
    elseif index == 1
        return "rape>"
    endif
    return current
EndFunction