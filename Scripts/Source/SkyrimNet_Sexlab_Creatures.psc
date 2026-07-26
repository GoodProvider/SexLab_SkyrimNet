scriptname SkyrimNet_SexLab_Creatures 

; This is a helper function used to find all the race form ids and store them into a JSON file 



Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Creatures", func, msg)
    if notification
        Debug.Notification(logged)
    endif 
EndFunction


Function Store_Races() global
    Trace("Store_Races", "Storing Races' formids.", true )

    String creaturesum_esp = "CreatureSummoner.esp"
    Int actorBaseType = 43

    Form[] forms = PO3_SKSEFunctions.GetAllFormsInMod(asModName = creaturesum_esp, aiFormtype = actorBaseType)
    if forms == None 
        Trace("Store_Races", "forms is None, aborting") 
        return 
    endif 
    int i = forms.length - 1 
    int races = JMap.object()
    while 0 <= i
        ActorBase base = forms[i] as ActorBase
        Race r = base.GetRace() 
        String race_name = r.GetName() 
        Trace("StoreRaces",race_name)
        if !JMap.hasKey(races, race_name)
            int info = JMap.object() 
            JMap.setStr(info, "name", race_name) 
            JMap.setForm(info, "form", r)
            JMap.setObj(races,race_name,info)  ; adding the race to the higher level to be saved with it later
        endif 
        i -= 1 
    endwhile
    String filename = "Data/SKSE/Plugins/SkyrimNet_SexLab/name_race.json"
    Trace("SkyrimNet_SexLab_Creatures","forms count: "+JMap.count(races)+" writing "+filename)
    MiscUtil.WriteToFile(filename, SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(races), append=False)
    JValue.release(races) 
EndFunction