Scriptname SkyrimNet_SexLab_Handler_DOM_PR extends ReferenceAlias  

SkyrimNet_SexLab_Handler_DOM Property handler Auto  

Function Trace(String func, String msg, Bool notification=False) global
    msg = "[SkyrimNet_SexLab_Handler_DOM_PR."+func+"] "+msg
    Debug.Trace(msg) 
    if notification
        Debug.Notification(msg)
    endif 
EndFunction

Event OnInit() 
    OnPlayerLoadGame() 
EndEvent 

Event OnPlayerLoadGame()
;    handler.Setup()
EndEvent

