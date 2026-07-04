Scriptname SkyrimNet_SexLab_Utilities

Function Trace(String func, String msg, Bool notification=False) global

    ;msg = GetTimeStamp()+" [SkyrimNet_SexLab_Utilities."+func+"] "+msg
    msg = "[SkyrimNet_SexLab_Utilities."+func+"] "+msg
    Debug.Trace(msg)
    if notification
        Debug.Notification(msg)
    endif 
EndFunction

String Function GetDisplayName(Actor akActor) global
    if akActor == None 
        return "none"
    endif 
    return akActor.GetDisplayName()
EndFunction 

; ------------------------------------------------------------
; Timestamps
; ------------------------------------------------------------
String Function GetTimestamp() global
    int ts = Utility.GetCurrentRealTime() as int

    int s    = ts % 60
    int m    = (ts / 60) % 60
    int h    = (ts / 3600) % 24
    int days = ts / 86400

    ; Walk years from epoch (1970-01-01)
    int year = 1970
    bool yearDone = false
    while !yearDone
        int diy = 365
        if (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0))
            diy = 366
        endif
        if days >= diy
            days -= diy
            year += 1
        else
            yearDone = true
        endif
    endwhile

    ; Walk months
    int month = 1
    bool monDone = false
    while !monDone
        int dim = 31
        if month == 4 || month == 6 || month == 9 || month == 11
            dim = 30
        elseif month == 2
            if (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0))
                dim = 29
            else
                dim = 28
            endif
        endif
        if days >= dim
            days -= dim
            month += 1
        else
            monDone = true
        endif
    endwhile
    int day = days + 1

    ; Zero-pad each component
    String yy = year as String
    String mo = month as String
    if month < 10
        mo = "0" + mo
    endif
    String dd = day as String
    if day < 10
        dd = "0" + dd
    endif
    String hh = h as String
    if h < 10
        hh = "0" + hh
    endif
    String mn = m as String
    if m < 10
        mn = "0" + mn
    endif
    String ss = s as String
    if s < 10
        ss = "0" + ss
    endif

    return yy + ":" + mo + ":" + dd + " " + hh + ":" + mn + ":" + ss
EndFunction

; ------------------------------------------------------------
; Combines Actors or Strings into natural language list 
; will make a natural sentence with comma and 'and' 
; mask is an int[] array 0 - false and 1 - true
; ------------------------------------------------------------
String Function JoinActors(Actor[] actors, int num_actors=-1) global 
    if !actors 
        return "none"
    endif 
    if num_actors < 0 
        num_actors = actors.length
    endif 
    int i = 0
    string joined = "" 
    while i < num_actors 
        String name = "none"
        if actors[i] != None 
            name = actors[i].GetDisplayName() 
        endif 

        if joined != "" 
            if num_actors > 2
                joined += ", "
            endif
            if i == num_actors - 1 
                joined += " and "
            endif
        endif
        joined += name
        i += 1  
    endwhile 
    return joined
EndFunction 

String Function JoinActorsMasked(Actor[] actors, int[] mask, int num_actors = -1) global 
    if !actors 
        return "none"
    endif 
    if num_actors < 0 
        num_actors = actors.length
    endif 
    int i = 0
    string joined = "" 
    while i < num_actors 
        if mask[i] == 1 
            String name = "none"
            if actors[i] != None 
                name = actors[i].GetDisplayName() 
            endif 

            if joined != "" 
                if num_actors > 2
                    joined += ", "
                endif
                if i == num_actors - 1 
                    joined += " and "
                endif
            endif
            joined += name
        endif 
        i += 1  
    endwhile 
    return joined
EndFunction 


String Function JoinNouns(String[] strings, int num_nouns = -1, bool add_is_are=false) global 
    if !strings 
        return "none"
    endif 
    int[] mask = Utility.CreateIntArray(strings.length, 1)

    int total = strings.length 
    int i = 0
    if num_nouns < 0 
        num_nouns = strings.length 
    endif 
    string joined = "" 
    while i < num_nouns 
        if joined != "" 
            if total > 2
                joined += ", "
            endif
            if i == num_nouns - 1 
                joined += " and "
            endif
        endif
        joined += strings[i]
        i += 1  
    endwhile 
    return JoinIsAre(joined, total, add_is_are) 
EndFunction 

String Function JoinNounsMasked(String[] strings, int[] mask, int num_strings = -1, bool add_is_are = false) global 
    if !strings 
        return "none"
    endif 
    int total = 0
    int i = 0
    int count = strings.length
    while i < count 
        if mask[i] == 1
            total += 1 
        endif 
        i += 1
    endwhile 

    i = 0
    int j = 0
    string joined = "" 
    while i < count
        if mask[i] == 1
            if j > 0
                if total > 2
                    joined += ", "
                    if j == total - 1 
                        joined += "and "
                    endif
                else
                    joined += " and "
                endif
            endif
            joined += strings[i]
            j += 1  
        endif 
        i += 1 
    endwhile 
    joined = JoinIsAre(joined, total, add_is_are) 
    return joined
EndFunction

String Function JoinIsAre(String joined, int total, bool add_is_are) global
    if add_is_are && total > 0 
        if total == 1 
            joined += " is "
        else 
            joined += " are "
        endif 
    endif 
    return joined 
EndFunction 

String Function JoinStringsToJson(String[] strings, int num_strings=-1) global 
    if !strings 
        return "none"
    endif 
    if num_strings == -1 
        num_strings = strings.length 
    endif 
    String json = "" 
    int i = 0
    while i < num_strings 
        if json != "" 
            json += ", "
        endif 
        json += '"'+strings[i]+'"'
        i += 1
    endwhile
    json = "["+json+"]"
    return json
EndFunction 

String Function JoinStringsToJsonMasked(String[] strings, int[] mask=None, int num_strings=-1) global 
    if !strings 
        return "none"
    endif 
    if num_strings == -1 
        num_strings = strings.length 
    endif 
    String json = "" 
    int i = 0
    while i < num_strings 
        if mask == None || mask[i] == 1
            if json != "" 
                json += ", "
            endif 
            json += '"'+strings[i]+'"'
        endif 
        i += 1
    endwhile
    json = "["+json+"]"
    return json
EndFunction 

String Function JoinActorsToJson(Actor[] actors, int num_actors=-1) global
    if !actors 
        return "none"
    endif 
    if num_actors == -1 
        num_actors = actors.length 
    endif 
    String json = ""
    int i = 0
    while i < num_actors 
        if json != ""
            json += ", "
        endif 
        String name = "none" 
        if actors[i] != None 
            name = actors[i].GetDisplayName()
        endif
        json += '"'+name+'"'
        i += 1
    endwhile 
    return "["+json+"]"
EndFunction 

String Function JoinActorsToJsonMasked(Actor[] actors, int[] mask, int num_actors=-1) global
    if !actors 
        return "none"
    endif 
    if num_actors == -1 
        num_actors = actors.length 
    endif 
    String json = ""
    int i = 0
    while i < num_actors 
        if mask[i] == 1 
            if json != ""
                json += ","
            endif 

            String name = "none" 
            if actors[i] != None 
                name = actors[i].GetDisplayName()
            endif
            json += '"'+name+'"'
        endif 
        i += 1
    endwhile 
    return "["+json+"]"
EndFunction 

String Function JoinStrings(String[] strings, int num_strings=-1) global
    if !strings 
        return "none"
    endif 
    int i = 0 
    if num_strings < 0
        num_strings = strings.length 
    endif 
    string joined = ""
    while i < num_strings 
        if joined != ""
            joined += "," 
        endif 
        joined += strings[i]
        i += 1 
    endwhile 
    return joined 
EndFunction 

String Function JoinIntsToJson(int[] ints, int num_ints=-1) global 
    if !ints 
        return "none"
    endif 
    if num_ints == -1 
        num_ints = ints.length 
    endif 
    String json = "" 
    int i = 0
    while i < num_ints 
        if json != "" 
            json += ", "
        endif 
        json += ints[i]
        i += 1
    endwhile
    json = "["+json+"]"
    return json
EndFunction 

; ------------------------------------------------------------
; Narration Wrappers 
; ------------------------------------------------------------

Function ContinueActivity(Actor source=None, Actor target=None, bool optional=False) global 
    String msg = ""
    If source != None 
        if target != None 
            msg = "continue activity that includes "+source.GetDisplayName()+" and "+target.GetDisplayName()
        else
            msg = "continue activity that includes "+source.GetDisplayName()
        endif 
    else 
            msg = "continue activity"
    endif
    DirectNarration_Optional("continue activity", msg, source, target, optional)
EndFunction 

Function DirectNarration_Optional(String event_type, String msg, Actor source=None, Actor target=None, bool optional=False) global
    ;Trace("DirectNarration_OPtional","event_type: "+event_type+" source: "+GetDisplayName(source)+" target: "+GetDisplayName(target)+" optional: "+optional+" msg: "+msg)
;    msg = CheckDuplicate("DirectNarration_Optional", source, msg)

    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main

    float unit_meter = 0.01465
    float distance = (unit_meter*main.direct_narration_max_distance) + 1 
    if source != None 
        Actor player = Game.GetPlayer()
        if player == source 
            distance = 0 
        else
            distance = unit_meter*player.GetDistance(source) 
        endif 
    endif 

    String type = "" 
    int queue_size = SkyrimNetAPI.GetSpeechQueueSize()
    int last_audio = SkyrimNetAPI.GetTimeSinceLastAudioEnded()/1000 ; in seconds
    float time_current = Utility.GetCurrentRealTime() 
    float time_delta = time_current - main.direct_narration_last_time 
    if time_delta > main.direct_narration_cool_off && queue_size == 0 && (last_audio >= main.direct_narration_cool_off && distance <= main.direct_narration_max_distance)
        SkyrimNetApi.DirectNarration(msg, source, target)
        main.direct_narration_last_time = time_current
        ;SkyrimNetApi.RegisterEvent(event_type, msg, source, target)
        type = "direct"
    else 
        if !optional && msg != ""
            SkyrimNetApi.RegisterEvent(event_type, msg, source, target)
            type = "event"
        else 
            type = "skipped"
        endif 
    endif 

    if source != None 
        msg += " source:"+source.GetDisplayName()
    endif 
    if target != None 
        msg += " target:"+target.GetDisplayName()
    endif
    Trace("DirectNarration_Optional","type:"+type+" narration_delta:"+time_delta+" queue_size:"+queue_size+" last_audio_secs:"+last_audio+">?"+main.direct_narration_cool_off+" distance:"+distance+"<?"+main.direct_narration_max_distance+" msg:"+msg)
EndFunction

Function DirectNarration(String msg, Actor source=None, Actor target=None) global
    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main
    ; msg = CheckDuplicate("DirectNarration", source, msg)

    SkyrimNetApi.DirectNarration(msg, source, target)
    main.direct_narration_last_time = Utility.GetCurrentRealTime() 
    ;SkyrimNetApi.RegisterEvent("sexlab_event", msg, source, target)
    if source != None 
        msg += " source:"+source.GetDisplayName()
    endif 
    if target != None 
        msg += " target:"+target.GetDisplayName()
    endif
    Trace("DirectNarration", msg)
EndFunction


Function RegisterEvent(String event_name, String msg, Actor source=None, Actor target=None) global
    if msg != "" 
        msg = CheckDuplicate("RegisterEvent", source, msg)

        SkyrimNetApi.RegisterEvent(event_name, msg, source, target)

        ; Sets up the log message
        if source != None 
            msg += " source:"+source.GetDisplayName()
        endif 
        if target != None 
            msg += " target:"+target.GetDisplayName()
        endif
        Trace("RegisterEvent", "event_name:"+event_name+" msg:"+msg)
    endif 
EndFunction

String Function CheckDuplicate(String func, Actor source, String msg) global
    if msg == ""
        return msg
    endif 
    String storage_key = "sexlab_narration_last_msg"
    String old = StorageUtil.GetStringValue(source, storage_key, "")
    Bool old_equals_new = old == msg
    if old == msg
        Trace(func+".CheckDuplicate", "changing duplicate `"+msg+"' to ''")
        return "" 
    else 
        StorageUtil.SetStringValue(source, storage_key, msg)
        return msg
    endif
EndFunction

String Function JsonBool(bool value) global
    if value 
        return ":true"
    endif 
    return ":false"
EndFunction

; --------------------------------------
; Ensure Functions 
; --------------------------------------
int[] Function EnsureIntsLargeEnough(int[] ints, int total, int default=0) global 
    if !ints 
        return Utility.CreateIntArray(total, default) 
    endif 
    if total <= ints.length
        return ints 
    endif 

    int[] _ints = Utility.CreateIntArray(total + 10,default) 
    int i = 0 
    int count = ints.length 
    while i < count 
        _ints[i] = ints[i]
        i += 1 
    endwhile 

    return _ints 
EndFunction 

String[] Function EnsureStringsLargeEnough(String[] strings, int num_strings, String default="") global 
    if !strings 
        return Utility.CreateStringArray(num_strings,default) 
    endif 
    if num_strings <= strings.length
        return strings 
    endif 

    String[] _strings = Utility.CreateStringArray(num_strings + 10,default) 
    int i = 0 
    int count = strings.length 
    while i < count 
        _strings[i] = strings[i]
        i += 1 
    endwhile 

    return _strings 
EndFunction 

Actor[] Function EnsureActorsLargeEnough(Actor[] actors_current, int total) global 
    if !actors_current
        return PapyrusUtil.ActorArray(total) 
    endif 
    if total <= actors_current.length
        return actors_current 
    endif 

    Actor[] _actors = PapyrusUtil.ActorArray(total + 10) 
    int i = 0 
    int count = actors_current.length 
    while i < count 
        _actors[i] = actors_current[i]
        i += 1 
    endwhile 

    return _actors 
EndFunction 

String Function ReplaceWord(String asSource, String asToFind, String asReplacement) global
    ; Early out if either string is empty to avoid errors
    If asSource == "" || asToFind == ""
        Return asSource
    EndIf

    int iTargetLen = StringUtil.GetLength(asToFind)
    int iPos = StringUtil.Find(asSource, asToFind)
    
    ; Loop to handle the global flag (/g) for multiple occurrences
    While iPos >= 0
        bool bIsWordMatch = false
        int iSourceLen = StringUtil.GetLength(asSource)
        
        ; 1. Exact Match (Whole string is just the target)
        If iSourceLen == iTargetLen
            bIsWordMatch = true
            
        ; 2. Front (Index = 0, equivalent to /^target /)
        ElseIf iPos == 0
            ; Check if the character AFTER the word is a space
            If StringUtil.Substring(asSource, iTargetLen, 1) == " "
                bIsWordMatch = true
            EndIf
            
        ; 3. End (Index = Length - TargetLength, equivalent to / target$/)
        ElseIf iPos == (iSourceLen - iTargetLen)
            ; Check if the character BEFORE the word is a space
            If StringUtil.Substring(asSource, iPos - 1, 1) == " "
                bIsWordMatch = true
            EndIf
            
        ; 4. Middle (Anything else, requires spaces on both sides)
        Else
            ; Check if surrounded by spaces (like / target /)
            If StringUtil.Substring(asSource, iPos - 1, 1) == " " && StringUtil.Substring(asSource, iPos + iTargetLen, 1) == " "
                bIsWordMatch = true
            EndIf
        EndIf
        
        ; Execute Replacement if boundaries matched
        If bIsWordMatch
            String sBefore = ""
            If iPos > 0
                sBefore = StringUtil.Substring(asSource, 0, iPos)
            EndIf
            
            String sAfter = ""
            If (iPos + iTargetLen) < iSourceLen
                sAfter = StringUtil.Substring(asSource, iPos + iTargetLen, 0)
            EndIf
            
            asSource = sBefore + asReplacement + sAfter
            
            ; Advance past the newly inserted word to prevent infinite loops
            iPos = StringUtil.Find(asSource, asToFind, iPos + StringUtil.GetLength(asReplacement))
        Else
            ; Not a standalone word; advance past the current match to keep looking
            iPos = StringUtil.Find(asSource, asToFind, iPos + 1)
        EndIf
    EndWhile
    
    Return asSource
EndFunction
