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
    ; Intentional no-op: DOM handler init is owned by SkyrimNet_SexLab_Main.Setup(),
    ; so this player-alias does not call handler.Setup(). Kept as the alias hook only.
EndEvent

