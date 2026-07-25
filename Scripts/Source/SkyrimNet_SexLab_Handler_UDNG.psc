Scriptname SkyrimNet_SexLab_Handler_UDNG extends Quest


SkyrimNet_UDNG_Groups Property udng_groups = None Auto

Function Trace(String func, String msg, Bool notification=False) global
    String logged = SkyrimNet_SexLab_WebUI.TraceLog("SkyrimNet_SexLab_Handler_UDNG", func, msg)
    if notification
        Debug.Notification(logged)
    endif
EndFunction

Function Setup()
    Bool links_ok = Setup_CheckLinks()
    if !links_ok
        return
    endif

    String file = "SkyrimNetUDNG.esp"
    String key_ = "SkyrimNet_SexLab_UDNG_MenuOpen"
    UnRegisterForModEvent(key_)
    if udng_groups != None 
        RegisterForModEvent(key_, "MenuOpen")
        Trace("Setup",file+" found registering for "+key_) 
    else 
        Trace("Setup",file+" not found")
    endif 
EndFunction

Bool Function Setup_CheckLinks()
    ; udng_groups is optional; missing integration is a no-op, not a hard failure.
    return true
EndFunction

Event MenuOpen(Form target_form)
    Actor target = target_form as Actor 
    if target != None 
        if udng_groups != None
            Trace("UpdateDevices","Updating devices for target: "+target.GetDisplayName())
            udng_groups.UpdateDevices(target) 
        else
            Trace("UpdateDevices","Update failed, target: "+target.GetDisplayName())
        endif
    else 
        Trace("UpdateDevices","target_form is None")
    endif 
EndEvent