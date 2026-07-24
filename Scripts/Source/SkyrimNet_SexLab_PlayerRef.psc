Scriptname SkyrimNet_SexLab_PlayerRef extends ReferenceAlias  


SkyrimNet_SexLab_Main Property main Auto  

Function Trace(String func, String msg, Bool notification=False) global
    msg = "[SkyrimNet_SexLab_PlayerRef."+func+"] "+msg
    Debug.Trace(msg) 
    if notification
        Debug.Notification(msg)
    endif 
EndFunction

Event OnInit() 
    OnPlayerLoadGame() ; ensure setup runs on initial load as well as subsequent loads, in case player starts a new game without reloading a save. Also ensures setup runs before any other scripts that rely on it, since this is an alias of the player and will initialize before any quests or other objects.
EndEvent 

Event OnPlayerLoadGame()
    ;if main == None 
        ;main = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main
    ;endif 
    main.Setup()
EndEvent

