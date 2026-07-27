Scriptname SkyrimNet_SexLab_Handler_DOM_Interface extends Quest 

Bool Function Setup() 
    return Setup_CheckLinks()
EndFunction 

Bool Function Setup_CheckLinks()
    return true
EndFunction

; Checks if the actor is a dom slave 
Bool Function IsDOMSlave(Actor akActor)
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

int Function GetThreads()
    return 0
EndFunction 

; ------------------------------------------------------------

Function Start_Masturbate(String intent, Actor speaker, Actor superior, String position="")
EndFunction

Function StartScene_Consensual_Two(String intent, Actor speaker, Actor Superior, Actor target, string style="", string method="", String direction="", String setting_name="")
EndFunction

; style omitted (ExecuteQuestFunction max 8 args / DOM_API); SexLab always gets style=""
Function StartScene_Nonconsensual_Two(String intent, Actor speaker, Actor superior, Actor target, Actor victim, string method="", String direction="", String setting_name="")
EndFunction

Function StartScene_Nonconsensual_Two_SpeakerVictim(String intent, Actor speaker, Actor superior, Actor target, string method="", String direction="", String setting_name="")
EndFunction

Function StartScene_Nonconsensual_Two_TargetVictim(String intent, Actor speaker, Actor superior, Actor target, string method="", String direction="", String setting_name="")
EndFunction