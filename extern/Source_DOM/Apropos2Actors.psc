ScriptName Apropos2Actors extends Quest

Import ApUtil
Import Apropos2Util

Apropos2SystemConfig Property Config Auto
Actor Property PlayerRef Auto

Apropos2ActorAlias Property Actor00 Auto
Apropos2ActorAlias Property Actor01 Auto
Apropos2ActorAlias Property Actor02 Auto
Apropos2ActorAlias Property Actor03 Auto
Apropos2ActorAlias Property Actor04 Auto
Apropos2ActorAlias Property Actor05 Auto
Apropos2ActorAlias Property Actor06 Auto
Apropos2ActorAlias Property Actor07 Auto
Apropos2ActorAlias Property Actor08 Auto
Apropos2ActorAlias Property Actor09 Auto
Apropos2ActorAlias Property Actor10 Auto
Apropos2ActorAlias Property Actor11 Auto
Apropos2ActorAlias Property Actor12 Auto
Apropos2ActorAlias Property Actor13 Auto
Apropos2ActorAlias Property Actor14 Auto
Apropos2ActorAlias Property Actor15 Auto
Apropos2ActorAlias Property Actor16 Auto
Apropos2ActorAlias Property Actor17 Auto
Apropos2ActorAlias Property Actor18 Auto
Apropos2ActorAlias Property Actor19 Auto
Apropos2ActorAlias Property Actor20 Auto
Apropos2ActorAlias Property Actor21 Auto
Apropos2ActorAlias Property Actor22 Auto
Apropos2ActorAlias Property Actor23 Auto
Apropos2ActorAlias Property Actor24 Auto
Apropos2ActorAlias Property Actor25 Auto
Apropos2ActorAlias Property Actor26 Auto
Apropos2ActorAlias Property Actor27 Auto
Apropos2ActorAlias Property Actor28 Auto
Apropos2ActorAlias Property Actor29 Auto
Apropos2ActorAlias Property Actor30 Auto
Apropos2ActorAlias Property Actor31 Auto
Apropos2ActorAlias Property Actor32 Auto
Apropos2ActorAlias Property Actor33 Auto
Apropos2ActorAlias Property Actor34 Auto
Apropos2ActorAlias Property Actor35 Auto
Apropos2ActorAlias Property Actor36 Auto
Apropos2ActorAlias Property Actor37 Auto
Apropos2ActorAlias Property Actor38 Auto
Apropos2ActorAlias Property Actor39 Auto
Apropos2ActorAlias Property Actor40 Auto
Apropos2ActorAlias Property Actor41 Auto
Apropos2ActorAlias Property Actor42 Auto
Apropos2ActorAlias Property Actor43 Auto
Apropos2ActorAlias Property Actor44 Auto
Apropos2ActorAlias Property Actor45 Auto
Apropos2ActorAlias Property Actor46 Auto
Apropos2ActorAlias Property Actor47 Auto
Apropos2ActorAlias Property Actor48 Auto
Apropos2ActorAlias Property Actor49 Auto
Apropos2ActorAlias[] Property Actors Auto Hidden

Function SetUpAproposActors()
    Log("SetUpAproposActors")
    Actors = New Apropos2ActorAlias[20]
    ; Actors[0] = Actor00
    ; Actors[1] = Actor01
    ; Actors[2] = Actor02
    ; Actors[3] = Actor03
    ; Actors[4] = Actor04
    ; Actors[5] = Actor05
    ; Actors[6] = Actor06
    ; Actors[7] = Actor07
    ; Actors[8] = Actor08
    ; Actors[9] = Actor09
    ; Actors[10] = Actor10
    ; Actors[11] = Actor11
    ; Actors[12] = Actor12
    ; Actors[13] = Actor13
    ; Actors[14] = Actor14
    ; Actors[15] = Actor15
    ; Actors[16] = Actor16
    ; Actors[17] = Actor17
    ; Actors[18] = Actor18
    ; Actors[19] = Actor19
    ; Actors[20] = Actor20
    ; Actors[21] = Actor21
    ; Actors[22] = Actor22
    ; Actors[23] = Actor23
    ; Actors[24] = Actor24
    ; Actors[25] = Actor25
    ; Actors[26] = Actor26
    ; Actors[27] = Actor27
    ; Actors[28] = Actor28
    ; Actors[29] = Actor29
    ; Actors[30] = Actor30
    ; Actors[31] = Actor31
    ; Actors[32] = Actor32
    ; Actors[33] = Actor33
    ; Actors[34] = Actor34
    ; Actors[35] = Actor35
    ; Actors[36] = Actor36
    ; Actors[37] = Actor37
    ; Actors[38] = Actor38
    ; Actors[39] = Actor39
    ; Actors[40] = Actor40
    ; Actors[41] = Actor41
    ; Actors[42] = Actor42
    ; Actors[43] = Actor43
    ; Actors[44] = Actor44
    ; Actors[45] = Actor45
    ; Actors[46] = Actor46
    ; Actors[47] = Actor47
    ; Actors[48] = Actor48
    ; Actors[49] = Actor49

    Int i = 0
    While i < Actors.Length
        Actors[i] = GetNthAlias(i) As Apropos2ActorAlias
        Actors[i].Setup()
        i += 1
    EndWhile
EndFunction

Event OnInit()
    Debug("OnInit")
    GameLoaded()
EndEvent

Function Setup()
    Debug("Setup")
    GameLoaded()
EndFunction

Function GameLoaded()
    Debug("GameLoaded")

    UnregisterForEvents()

    If !Config.CheckSystemComponent("JContainers")
        Return
    EndIf

    If !Actors
        SetUpAproposActors()
    EndIf
    RegisterForEvents()
    Debug("GameLoaded - Ready")
EndFunction

Function UnregisterForEvents()
    Debug("UnregisterForEvents")
    UnregisterForAllModEvents()
EndFunction

Function RegisterForEvents()
    Debug("RegisterForEvents")
    RegisterForModEvent("APRWT_UpdateEffectsAndTats", "UpdateEffectsAndTats")
    RegisterForModEvent("APRWT_ApplyWearAndTear", "ApplyWearAndTear")
    RegisterForModEvent("APRWT_OverrideWearAndTear", "OverrideWearAndTear")
EndFunction

Event Apropos2DatabaseRefreshed()
EndEvent

; actorClass ==> Human, Dremora, Wolf, Draugr
Function ProcessOrgasm(SslThreadController thread, Actor primaryActor, Actor activeActor, Bool hasVictimOrAggressive, String actorClass, String[] bodyPartsAffected)
    Trace("ProcessOrgasm: " + primaryActor.GetDisplayName() +","+ activeActor.GetDisplayName() +","+ StringIfElse(hasVictimOrAggressive, "hasVictimOrAggressive") +","+ actorClass +","+ StringArrayToString(bodyPartsAffected))
    Apropos2ActorAlias aproposActor = GetTrackedActorOrStartTracking(primaryActor)
    If aproposActor && activeActor
        aproposActor.ProcessOrgasm(thread, activeActor, hasVictimOrAggressive, actorClass, bodyPartsAffected)
    EndIf       
EndFunction

Function ProcessStageStart(Actor primaryActor, Actor[] all_actors)
    Apropos2ActorAlias aproposActor = GetTrackedActorOrStartTracking(primaryActor)
    If aproposActor
        aproposActor.ProcessStageStart(all_actors)
    EndIf        
EndFunction

Function ClearTrackedNPCActors()
    Int i = 0
    While i < Actors.Length
        Apropos2ActorAlias anAlias = Actors[i]
        If anAlias != "ReadyForTracking" && anAlias.GetActor() != PlayerRef
            Actors[i].GoToState("ClearTracking")
        EndIf
        i += 1
    EndWhile
    SetUpAproposActors()
    Log("All named NPC trackings removed")
EndFunction

Function DoUpdateEffectsAndTats(Actor anActor, Bool increasingAbuse)
    Debug("DoUpdateEffectsAndTats")

    If !ShouldApplyWearAndTear(anActor)
        Return
    EndIf   

    Apropos2ActorAlias aproposActor = GetTrackedActorOrStartTracking(anActor)
    If aproposActor
        aproposActor.LogAllWearAndTear()
        aproposActor.UpdateWearTearEffects()
        aproposActor.UpdateAbuseTextures(increasingAbuse=increasingAbuse)
    EndIf    
EndFunction

Event UpdateEffectsAndTats(Form frm, bool increasingAbuse)
    Actor anActor = frm As Actor
    If !anActor
        Return
    EndIf
    DoUpdateEffectsAndTats(anActor, increasingAbuse)
EndEvent

Bool Function ShouldApplyWearAndTear(Actor anActor)
    If !Config.WearAndTearEnabled
        Return False
    EndIf

    If !Config.NPCWearAndTearEnabled && anActor != PlayerRef
        Return False
    EndIf   

    Return True
EndFunction

Event OverrideWearAndTear(Form frm, String area, Int new_value, Bool updateAbuse, Bool updateCreatureAbuse, Bool updateDaedricAbuse)
    Debug("OverrideWearAndTear")
    Actor anActor = frm As Actor
    If !anActor
        Return
    EndIf

    If !ShouldApplyWearAndTear(anActor)
        Return
    EndIf

    String actorName = anActor.GetDisplayName()
    If Config.TraceMessagesEnabled
        Log("AproposWearAndTear.OverrideWearAndTear(" + actorName + "," + new_value + ")")
    EndIf

    Apropos2ActorAlias aproposActor = GetTrackedActorOrStartTracking(anActor)

    If aproposActor
        If area == "Vaginal"
            aproposActor.OverrideVaginalWearTearState(new_value, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)
        ElseIf area == "Anal"
            aproposActor.OverrideAnalWearTearState(new_value, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)
        Else
            aproposActor.OverrideOralWearTearState(new_value, updateAbuse=updateAbuse, updateCreatureAbuse=updateCreatureAbuse, updateDaedricAbuse=updateDaedricAbuse)
        EndIf
    EndIf
EndEvent

Function DoApplyWearAndTear(Actor anActor, String area, string damageClass, Bool isRapeOrAggressive, Bool isCreature)
;Function DoApplyWearAndTear(Actor anActor, String area, string damageClass, Bool isRapeOrAggressive, Bool isCreature)
    Debug("DoApplyWearAndTear")

    If !ShouldApplyWearAndTear(anActor)
        Return
    EndIf   

    String actorName = anActor.GetDisplayName()
    If Config.TraceMessagesEnabled
        Debug("DoApplyWearAndTear(" + actorName + "," + damageClass + "," + isRapeOrAggressive + ")")
    EndIf

    Bool isDaedricCreatureOrDremora = IsDremoraOrDaedricCreature(damageClass)

    Apropos2ActorAlias aproposActor = GetTrackedActorOrStartTracking(anActor)
    If aproposActor
        Int amount = GetWearTearDamage(damageClass, isRapeOrAggressive)
        If area == "Vaginal"
            aproposActor.IncreaseVaginalWearAndTear(amount)
            aproposActor.IncreaseVaginalAbuseWearAndTear(amount, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)     
        ElseIf area == "Anal"
            aproposActor.IncreaseAnalWearAndTear(amount)
            aproposActor.IncreaseAnalAbuseWearAndTear(amount, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)  
        Else
            aproposActor.IncreaseOralWearAndTear(amount)
            aproposActor.IncreaseOralAbuseWearAndTear(amount, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)         
        EndIf
    EndIf    
EndFunction

; Function DoApplyWearAndTear_OLD(Actor anActor, String area, string damageClass, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
; ;Function DoApplyWearAndTear(Actor anActor, String area, string damageClass, Bool isRapeOrAggressive, Bool isCreature)
;     Debug("ApplyWearAndTear")

;     If !ShouldApplyWearAndTear(anActor)
;         Return
;     EndIf   

;     String actorName = anActor.GetDisplayName()
;     If Config.TraceMessagesEnabled
;         Debug("ApplyWearAndTear(" + actorName + "," + damageClass + "," + isRapeOrAggressive + ")")
;     EndIf

;     ;Bool isDaedricCreatureOrDremora = damageClass == "Dremora"

;     Apropos2ActorAlias aproposActor = GetTrackedActorOrStartTracking(anActor)
;     If aproposActor
;         Int amount = GetWearTearDamage(damageClass, isRapeOrAggressive)
;         If area == "Vaginal"
;             aproposActor.IncreaseVaginalWearAndTear(amount)
;             aproposActor.IncreaseVaginalAbuseWearAndTear(amount, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)     
;         ElseIf area == "Anal"
;             aproposActor.IncreaseAnalWearAndTear(amount)
;             aproposActor.IncreaseAnalAbuseWearAndTear(amount, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)  
;         Else
;             aproposActor.IncreaseOralWearAndTear(amount)
;             aproposActor.IncreaseOralAbuseWearAndTear(amount, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)         
;         EndIf
;     EndIf    
; EndFunction

Event ApplyWearAndTear(Form frm, String area, string damageClass, Bool isRapeOrAggressive, Bool isCreature)
    Actor anActor = frm As Actor
    If !anActor
        Return
    EndIf

    DoApplyWearAndTear(anActor, area, damageClass, isRapeOrAggressive, isCreature)
EndEvent

; Event ApplyWearAndTear_OLD(Form frm, String area, string damageClass, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
;     Actor anActor = frm As Actor
;     If !anActor
;         Return
;     EndIf

;     DoApplyWearAndTear_OLD(anActor, area, damageClass, isRapeOrAggressive, isDaedricCreatureOrDremora, isCreature)
; EndEvent

Int Function GetWearTearDamage(String damageClass, Bool isRapeOrAggressive)
    If Config.TraceMessagesEnabled
        Debug("GetWearTearDamage(damageClass="+damageClass+",isRapeOrAggressive="+isRapeOrAggressive+")")
    EndIf

    Float amt = JDB.solveFlt(QueryKey("wearteardamage", damageClass), -1.0)
    If amt == -1.0
        Debug("WARNING GetWearTearDamage() - " + damageClass + " unrecognized. Using a value of 10.0 for damage")
        amt = 10.0
    EndIf

    If isRapeOrAggressive
        Float factor = JDB.solveFlt(QueryKey("wearteardamage", "AggressiveOrRape"), 1.0)
        Return (amt * factor) As Int
    EndIf
    Return amt As Int
EndFunction

Apropos2ActorAlias Function GetTrackedActorOrStartTracking(Actor anActor)
    Apropos2ActorAlias aproposActor = GetAproposActor(anActor)
    If aproposActor
        Return aproposActor
    EndIf
    String actorName = anActor.GetDisplayName()
    Trace(actorName + " was not being tracked. Start tracking now...")   
    aproposActor = TrackActor(anActor)
    Return aproposActor
EndFunction

Apropos2ActorAlias Function GetAproposActor(Actor anActor)
    String actorName = anActor.GetDisplayName()

    Int i = 0
    While i < Actors.Length
        If Actors[i].GetState() == "Tracking" && Actors[i].GetActor() == anActor
            Trace("Found Apropos2ActorAlias the represents " + actorName)
            Return Actors[i]
        EndIf
        i += 1
    EndWhile

    Trace("GetAproposActor(Actor=" + actorName + ") ==> Not tracked.")
    Return None
EndFunction

PAHCore Property PAH Auto Hidden
Faction Property DOMHistoryFaction Auto Hidden

Bool Function IsTrackableActor(Actor anActor) 
    if anActor == PlayerRef
		return True
	endif
	if anActor.GetActorBase().IsUnique()
		return True
	EndIf
	if anActor.IsPlayerTeammate()
		return True
	EndIf
	if DOMHistoryFaction == none && (Game.GetModByName("DiaryOfMine.esm") != 255)
		DOMHistoryFaction = Game.GetFormFromFile(0x0073413C, "DiaryOfMine.esm") As Faction
	endif
	if DOMHistoryFaction != None && anActor.IsInFaction(DOMHistoryFaction)
		return True
	endif
	if PAH == None && (Game.GetModByName("paradise_halls.esm") != 255)
		PAH = Game.GetFormFromFile(0x0001FAEF, "paradise_halls.esm") As PAHCore 
	endif
	if PAH != None && anActor.IsInFaction(PAH.PAHPlayerSlaveFaction)
		return True
	endif
	return false
EndFunction

Apropos2ActorAlias Function TrackActor(Actor anActor)
	If !IsTrackableActor(anActor)
		return None
	endif
    If IsNotTracked(anActor)
        Int nextSlot = GetNextAvailableActorSlot()
        If (nextSlot > -1)
            Apropos2ActorAlias actorAlias = Actors[nextSlot]
            Trace("Using next slot " + nextSlot + " actorAlias is alive: " + actorAlias.TestIsAlive())
            actorAlias.Track(anActor, nextSlot)
            Return actorAlias
        EndIf
    EndIf
    Return None
EndFunction

Bool Function IsNotTracked(Actor actorToTest)
    String actorName = actorToTest.GetDisplayName()
    Int i = 0
    While i < Actors.Length
        If Actors[i].GetState() != "ReadyForTracking" && Actors[i].GetActor() == actorToTest
            Trace(actorName + " is being tracked")
            Return False
        EndIf
        i += 1
    EndWhile
    Trace(actorName + " is not being tracked")
    Return True
EndFunction

Int Function GetNextAvailableActorSlot()
    Int i = 0
    While i < Actors.Length
        If Actors[i].GetState() == "ReadyForTracking"
            Return i
        EndIf
        i += 1
    EndWhile
    Return -1
EndFunction

String Function GetWearTearVaginal(Actor anActor)
    Apropos2ActorAlias aproposActor = GetAproposActor(anActor)
    If aproposActor
        Return aproposActor.VaginalWearTear
    EndIf
    Return ""
EndFunction

String Function GetWearTearAnal(Actor anActor)
    Apropos2ActorAlias aproposActor = GetAproposActor(anActor)
    If aproposActor
        Return aproposActor.AnalWearTear
    EndIf
    Return ""
EndFunction

String Function GetWearTearOral(Actor anActor)
    Apropos2ActorAlias aproposActor = GetAproposActor(anActor)
    If aproposActor
        Return aproposActor.OralWearTear
    EndIf
    Return ""
EndFunction

String[] Function GetTrackedActorList()
    Int size
    Bool isDouble = Config.EnableSkinTextures
    If isDouble
        size = 100
    Else
        size = 50
    EndIf

    String[] list = SslUtility.StringArray(size)
    Int i = 0
    Int j 
    While i < Actors.Length
        Apropos2ActorAlias a = Actors[i]
        If Config.DebugMessagesEnabled
            Actor trackedActor = a.GetActor()
            ; If trackedActor
            ;     Log("i: " + i + " state: " + a.GetState() + " actor : " + a.GetActor().GetActorBase().GetName())
            ; Else
            ;     Log("i: " + i + " state: " + a.GetState() + " actor : none")
            ; EndIf
        EndIf
        If isDouble
            j = i * 2
        Else
            j = i
        EndIf        
        If a.GetState() == "Tracking" && a.GetActor() != PlayerRef
           list[j] = a.GetActor().GetActorBase().GetName() + " Vaginal:" + a.VaginalWearTearState + " Anal:" + a.AnalWearTearState + " Oral:" + a.OralWearTearState
            If isDouble
                list[j+1] = "... abuse:" + a.AverageAbuseState + " creature: " + a.AverageCreatureAbuseState + " daedric : " + a.AverageDaedricAbuseState
            EndIf
        Else
            list[j] = ""
            If isDouble
                list[j+1] = ""
            EndIf
        EndIf
        i += 1

    EndWhile
    Return list
EndFunction

Event Stop()
    UnregisterForAllModEvents()
    Parent.Stop()
EndEvent

Function Log(String msg)
    Config.Log(msg, Source="Apropos2Actors")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, Source="Apropos2Actors")
EndFunction

Function Trace(String msg)
    If !Config.TraceMessagesEnabled
        Return
    EndIf
    Config.Debug(msg, Source="Apropos2Actors")
EndFunction
