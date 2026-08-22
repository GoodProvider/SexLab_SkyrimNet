Scriptname SkyrimNet_SexLab_Handler_UDNG extends Quest

; Optional Devious Devices handler. zadLibs types must stay on this quest (Handler ESP)
; so the main ESP does not fail to bind when DD is absent.
; Per-actor WebUI session: JFormMap of original worn ids for narration. Pulldowns
; edit JS current only; Done applies currentJson then CloseOverlay. Hide/Cancel
; release the session without restoring devices (the actor was never mutated).

zadLibs zlibs = None
int group_devices = 0
int actor_bondage = 0

String group_devices_path = "Data/SKSE/Plugins/SkyrimNet_SexLab/bondage/group-devices.json"

Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Handler_UDNG", func, msg)
    if notification
        Debug.Notification(msg)
    endif
EndFunction

Function Setup()
    ReleaseAll()
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        return
    endif

    String key_ = "SkyrimNet_SexLab_UDNG_MenuOpen"
    UnRegisterForModEvent(key_)
    RegisterForModEvent(key_, "MenuOpen")
    Trace("Setup", "--- DD Assets loaded, registered "+key_)
EndFunction

Bool Function Setup_CheckLinks()
    if Game.GetModByName("Devious Devices - Assets.esm") == 255
        Trace("Setup_CheckLinks", "--- Devious Devices - Assets.esm not loaded")
        return false
    endif

    if zlibs == None
        zlibs = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as zadLibs
    endif
    if zlibs == None
        Trace("Setup_CheckLinks", "--- zadLibs 0xF624 missing from Integration.esm")
        return false
    endif

    if group_devices != 0
        JValue.release(group_devices)
        group_devices = 0
    endif
    group_devices = JValue.readFromFile(group_devices_path)
    if group_devices == 0
        Trace("Setup_CheckLinks", "--- failed to read "+group_devices_path)
        return false
    endif
    JValue.retain(group_devices)
    return true
EndFunction

Bool Function EnsureReady()
    if zlibs == None || group_devices == 0
        return Setup_CheckLinks()
    endif
    return true
EndFunction

Function OpenMenu(Actor target)
    TM_BondageRefresh(target)
EndFunction

Event MenuOpen(Form target_form)
    OpenMenu(target_form as Actor)
EndEvent

String Function DeviceStr(int device, String key1, String key2)
    String v = JMap.getStr(device, key1)
    if v != ""
        return v
    endif
    return JMap.getStr(device, key2)
EndFunction

String Function DeviceIdOf(int device)
    String id = DeviceStr(device, "id", "Id")
    if id != ""
        return id
    endif
    return DeviceStr(device, "name", "Name")
EndFunction

String Function DeviceNameOf(int device)
    String n = DeviceStr(device, "name", "Name")
    if n != ""
        return n
    endif
    return DeviceIdOf(device)
EndFunction

Keyword Function DeviceKeywordOf(int device)
    Keyword kword = JMap.getForm(device, "keyword") as Keyword
    if kword == None
        kword = JMap.getForm(device, "Keyword") as Keyword
    endif
    return kword
EndFunction

Bool Function DeviceIsWorn(Actor target, int device)
    if target == None || zlibs == None || device <= 0
        return false
    endif
    Armor rendered = JMap.getForm(device, "formRendered") as Armor
    Keyword kword = DeviceKeywordOf(device)
    return 1 == zlibs.IsWearingDevice(target, rendered, kword)
EndFunction

int Function WornDeviceInGroup(Actor target, int devices)
    if devices == 0
        return 0
    endif
    int j = JArray.count(devices) - 1
    while j >= 0
        int device = JArray.getObj(devices, j)
        if DeviceIsWorn(target, device)
            return device
        endif
        j -= 1
    endwhile
    return 0
EndFunction

int Function FindDeviceById(int devices, String deviceId)
    if devices == 0 || deviceId == ""
        return 0
    endif
    int n = JArray.count(devices)
    int i = 0
    while i < n
        int device = JArray.getObj(devices, i)
        if DeviceIdOf(device) == deviceId
            return device
        endif
        i += 1
    endwhile
    return 0
EndFunction

Function AddKeys(Actor target, Key z_key, int num)
    if target == None || z_key == None
        return
    endif
    int need = num - target.GetItemCount(z_key)
    if need > 0
        target.AddItem(z_key, need, abSilent=True)
    endif
EndFunction

Function ReleaseAll()
    if actor_bondage != 0
        JValue.release(actor_bondage)
        actor_bondage = 0
    endif
EndFunction

int Function SessionOf(Actor target)
    if target == None || actor_bondage == 0
        return 0
    endif
    return JFormMap.getObj(actor_bondage, target)
EndFunction

Function EnsureSession(Actor target)
    if target == None || group_devices == 0
        return
    endif
    if actor_bondage == 0
        actor_bondage = JFormMap.object()
        JValue.retain(actor_bondage)
    endif
    if JFormMap.hasKey(actor_bondage, target)
        return
    endif
    int session = JMap.object()
    int orig = JArray.object()
    int n = JArray.count(group_devices)
    int i = 0
    while i < n
        int group = JArray.getObj(group_devices, i)
        int devices = JMap.getObj(group, "devices")
        int worn = WornDeviceInGroup(target, devices)
        if worn > 0
            JArray.addStr(orig, DeviceIdOf(worn))
        else
            JArray.addStr(orig, "")
        endif
        i += 1
    endwhile
    JMap.setObj(session, "original", orig)
    JFormMap.setObj(actor_bondage, target, session)
    Trace("EnsureSession", "--- seed "+GetDisplayNameSafe(target))
EndFunction

String Function OriginalIdAt(int session, int index)
    if session == 0
        return ""
    endif
    int orig = JMap.getObj(session, "original")
    if orig == 0 || index < 0 || index >= JArray.count(orig)
        return ""
    endif
    return JArray.getStr(orig, index)
EndFunction

String Function CurrentIdForGroup(int wantedMap, String groupName, String fallback)
    if wantedMap == 0 || groupName == ""
        return fallback
    endif
    if JMap.hasKey(wantedMap, groupName)
        return JMap.getStr(wantedMap, groupName)
    endif
    String[] keys = JMap.allKeysPArray(wantedMap)
    if keys
        int n = keys.Length
        int i = 0
        while i < n
            if keys[i] == groupName
                return JMap.getStr(wantedMap, keys[i])
            endif
            i += 1
        endwhile
    endif
    return fallback
EndFunction

Bool Function UnlockWornInGroup(Actor target, int devices)
    int worn = WornDeviceInGroup(target, devices)
    if worn <= 0
        return true
    endif
    Armor inventory = JMap.getForm(worn, "formInventory") as Armor
    Armor rendered = JMap.getForm(worn, "formRendered") as Armor
    return zlibs.UnLockDevice(target, inventory, rendered, destroyDevice = true)
EndFunction

Bool Function SetGroupToId(Actor target, int devices, String wantedId)
    int worn = WornDeviceInGroup(target, devices)
    String wornId = ""
    if worn > 0
        wornId = DeviceIdOf(worn)
    endif
    if wornId == wantedId
        return true
    endif
    if wantedId == ""
        return UnlockWornInGroup(target, devices)
    endif
    int picked = FindDeviceById(devices, wantedId)
    if picked <= 0
        Trace("SetGroupToId", "--- device not in catalog: "+wantedId)
        return false
    endif
    AddKeys(target, zlibs.chastityKey, 1)
    AddKeys(target, zlibs.restraintsKey, 2)
    AddKeys(target, zlibs.piercingKey, 1)
    Armor inventory = JMap.getForm(picked, "formInventory") as Armor
    Keyword kword = DeviceKeywordOf(picked)
    if worn <= 0
        return zlibs.LockDevice(target, inventory, force = true)
    endif
    return zlibs.SwapDevices(target, inventory, kword, destroyDevice = true)
EndFunction

Function PushBondageState(Actor target)
    if target == None || group_devices == 0
        return
    endif
    int root = JMap.object()
    JMap.setInt(root, "target", target.GetFormID())
    int groups = JArray.object()
    JMap.setObj(root, "groups", groups)
    int n = JArray.count(group_devices)
    int i = 0
    while i < n
        int group = JArray.getObj(group_devices, i)
        int devices = JMap.getObj(group, "devices")
        int worn = WornDeviceInGroup(target, devices)
        int go = JMap.object()
        JMap.setStr(go, "name", JMap.getStr(group, "name"))
        if worn > 0
            JMap.setStr(go, "equippedId", DeviceIdOf(worn))
        else
            JMap.setStr(go, "equippedId", "")
        endif
        int darr = JArray.object()
        JMap.setObj(go, "devices", darr)
        int dn = 0
        if devices != 0
            dn = JArray.count(devices)
        endif
        int j = 0
        while j < dn
            int device = JArray.getObj(devices, j)
            int dobj = JMap.object()
            JMap.setStr(dobj, "id", DeviceIdOf(device))
            JMap.setStr(dobj, "name", DeviceNameOf(device))
            int wearing = 0
            if DeviceIsWorn(target, device)
                wearing = 1
            endif
            JMap.setInt(dobj, "wearing", wearing)
            JArray.addObj(darr, dobj)
            j += 1
        endwhile
        JArray.addObj(groups, go)
        i += 1
    endwhile
    String json = SkyrimNet_SexLab_Utilities.ObjectToLowerCaseKeyJson(root)
    JValue.release(root)
    SkyrimNet_SexLab_WebUI.Bondage_Configure(json)
EndFunction

Function TM_BondageRefresh(Actor target)
    if target == None
        Trace("TM_BondageRefresh", "--- target is None")
        return
    endif
    if !EnsureReady()
        Trace("TM_BondageRefresh", "--- DD not ready")
        return
    endif
    EnsureSession(target)
    PushBondageState(target)
EndFunction

Function TM_BondageApply(Actor target, String deviceId)
    Trace("TM_BondageApply", "--- "+GetDisplayNameSafe(target)+" deviceId:"+deviceId)
    if target == None || deviceId == ""
        return
    endif
    if !EnsureReady()
        return
    endif
    EnsureSession(target)

    AddKeys(target, zlibs.chastityKey, 1)
    AddKeys(target, zlibs.restraintsKey, 2)
    AddKeys(target, zlibs.piercingKey, 1)

    int n = JArray.count(group_devices)
    int i = 0
    int picked = 0
    int devices = 0
    while i < n && picked == 0
        int group = JArray.getObj(group_devices, i)
        devices = JMap.getObj(group, "devices")
        picked = FindDeviceById(devices, deviceId)
        i += 1
    endwhile
    if picked <= 0
        Trace("TM_BondageApply", "--- device not in catalog: "+deviceId)
        PushBondageState(target)
        return
    endif

    int wearing = WornDeviceInGroup(target, devices)
    Armor inventory = JMap.getForm(picked, "formInventory") as Armor
    Armor rendered = JMap.getForm(picked, "formRendered") as Armor
    Keyword kword = DeviceKeywordOf(picked)

    Bool success = false
    if wearing > 0 && DeviceIdOf(wearing) == deviceId
        success = zlibs.UnLockDevice(target, inventory, rendered, destroyDevice = true)
        Trace("TM_BondageApply", "--- unlock "+deviceId+" ok="+success)
    elseif wearing <= 0
        success = zlibs.LockDevice(target, inventory, force = true)
        Trace("TM_BondageApply", "--- lock "+deviceId+" ok="+success)
    else
        success = zlibs.SwapDevices(target, inventory, kword, destroyDevice = true)
        Trace("TM_BondageApply", "--- swap to "+deviceId+" ok="+success)
    endif

    PushBondageState(target)
EndFunction

Function TM_BondageOnWebUIClosed()
    Trace("TM_BondageOnWebUIClosed", "--- release session")
    ReleaseAll()
EndFunction

Function TM_BondageFinish(Actor speaker, Actor target, String style, String currentJson)
    Trace("TM_BondageFinish", "--- "+GetDisplayNameSafe(speaker)+" -> "+GetDisplayNameSafe(target)+" style:"+style)
    if target == None || !EnsureReady()
        ReleaseAll()
        SkyrimNet_SexLab_WebUI.WebUI_CloseOverlay()
        return
    endif
    EnsureSession(target)

    int wantedMap = 0
    if currentJson != ""
        wantedMap = JValue.objectFromPrototype(currentJson)
    endif

    String added = ""
    String removed = ""
    int session = SessionOf(target)
    int n = JArray.count(group_devices)
    int i = 0
    while i < n
        int group = JArray.getObj(group_devices, i)
        int devices = JMap.getObj(group, "devices")
        String gname = JMap.getStr(group, "name")
        if gname == ""
            gname = JMap.getStr(group, "Name")
        endif
        String origId = OriginalIdAt(session, i)
        String wantedId = CurrentIdForGroup(wantedMap, gname, origId)
        SetGroupToId(target, devices, wantedId)
        if origId != wantedId
            if wantedId != ""
                int picked = FindDeviceById(devices, wantedId)
                if picked > 0
                    if added != ""
                        added = added + ", "
                    endif
                    added = added + DeviceNameOf(picked)
                endif
            else
                int orig = FindDeviceById(devices, origId)
                if orig > 0
                    if removed != ""
                        removed = removed + ", "
                    endif
                    removed = removed + DeviceNameOf(orig)
                endif
            endif
        endif
        i += 1
    endwhile

    if style != "silently" && style != "silent"
        String style_desc = ""
        if style == "forcefully"
            style_desc = " forcefully "
        elseif style == "gently"
            style_desc = " gently "
        else
            style_desc = " "
        endif

        Actor who = speaker
        if who == None
            who = Game.GetPlayer()
        endif
        String msg = ""
        if removed != ""
            msg = msg + who.GetDisplayName()+style_desc+"unlocked and removed from "+target.GetDisplayName() \
                +" the following: "+removed+". "
        endif
        if added != ""
            msg = msg + who.GetDisplayName()+style_desc+"locked onto "+target.GetDisplayName() \
                +" the following: "+added+". "
        endif
        if msg != ""
            Debug.Notification(msg)
            SkyrimNetApi.DirectNarration(msg, who, target)
        endif
    endif

    ReleaseAll()
    SkyrimNet_SexLab_WebUI.WebUI_CloseOverlay()
EndFunction

String Function GetDisplayNameSafe(Actor a)
    if a == None
        return "None"
    endif
    return a.GetDisplayName()
EndFunction
