Scriptname SkyrimNet_SexLab_Handler_DOM_Interface extends Quest 

Bool Function Setup() 
    return true 
EndFunction 

; Checks if the actor is a dom slave 
Bool Function IsDOMSlave(Actor akActor)
    return false 
EndFunction

; Hands off the slave to SkyrimNet_DOM Target_Menu_Selection
Bool Function Target_Menu_Selection(Actor target, Actor player) 
    return false
EndFunction

String Function HandleOrgasmDenied(Actor akActor) 
    return "" 
EndFunction

Function DOMSlave_Orgasmed(Actor slave, String msg)
EndFunction

Bool Function Orgasm_Desired(Actor akActor)
    return false 
EndFunction

bool Function StartScene_Consensual_Two(String intent, Actor speaker, Actor Superior, Actor target, string style="", string method="", String direction="", String setting_name="")
    return false
EndFunction