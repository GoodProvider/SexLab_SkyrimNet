Scriptname SkyrimNet_SexLab_Handler_UDNG extends Quest


SkyrimNet_UDNG_Groups Property udng_groups = None Auto

Function Trace(String func, String msg, Bool notification=False) global
    msg = "[SkyrimNet_SexLab_Handler_UDNG."+func+"] "+msg
    Debug.Trace(msg) 
    if notification
        Debug.Notification(msg)
    endif
EndFunction

Function Setup()
    String file = "SkyrimNetUDNG.esp"
    String key = "SkyrimNet_SexLab_UDNG_MenuOpen"
    UnRegisterForModEvent(key)
    if udng_groups != None 
        RegisterForModEvent(key, "MenuOpen")
        Trace("Setup",file+" found registering for "+key) 
    else 
        Trace("Setup",file+" not found")
    endif 
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