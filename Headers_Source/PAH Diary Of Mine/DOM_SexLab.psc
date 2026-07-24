Scriptname DOM_Sexlab extends Quest  

Function StartSex(Actor[] sexActors, sslBaseAnimation[] anims, Actor victim=None, bool allowBed=false, string hook="")
EndFunction

Function StartSexlabWithAnims(Actor[] akActors, DOM_Actor[] akDOMActors, string tied_pose, string tags, bool is_punishment, string reason_name, sslBaseAnimation[] anims, ObjectReference CenterOn = None, bool AllowBed = true, string Hook = "")
EndFunction

; Animating Functions 
Function ClearAnimatingFaction(Actor akRef)
EndFunction

Function SetAnimatingFaction(Actor akRef)
EndFunction