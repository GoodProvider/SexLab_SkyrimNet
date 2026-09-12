ScriptName Apropos2Track extends Quest

Import ApUtil
Import Apropos2Util

Apropos2SystemConfig Property Config Auto
Actor Property PlayerRef Auto
SexLabFramework Property SexLab Auto
slaUtilScr Property SlaUtil Auto

Int Property MALE = 0 AutoReadOnly
Int Property FEMALE = 1 AutoReadOnly

Apropos2TrackActorAlias Property Actor00 Auto
Apropos2TrackActorAlias Property Actor01 Auto
Apropos2TrackActorAlias Property Actor02 Auto
Apropos2TrackActorAlias Property Actor03 Auto
Apropos2TrackActorAlias Property Actor04 Auto
Apropos2TrackActorAlias Property Actor05 Auto
Apropos2TrackActorAlias Property Actor06 Auto
Apropos2TrackActorAlias Property Actor07 Auto
Apropos2TrackActorAlias Property Actor08 Auto
Apropos2TrackActorAlias Property Actor09 Auto
Apropos2TrackActorAlias Property Actor10 Auto
Apropos2TrackActorAlias Property Actor11 Auto
Apropos2TrackActorAlias Property Actor12 Auto
Apropos2TrackActorAlias Property Actor13 Auto
Apropos2TrackActorAlias Property Actor14 Auto
Apropos2TrackActorAlias Property Actor15 Auto
Apropos2TrackActorAlias Property Actor16 Auto
Apropos2TrackActorAlias Property Actor17 Auto
Apropos2TrackActorAlias Property Actor18 Auto
Apropos2TrackActorAlias Property Actor19 Auto
Apropos2TrackActorAlias Property Actor20 Auto
Apropos2TrackActorAlias Property Actor21 Auto
Apropos2TrackActorAlias Property Actor22 Auto
Apropos2TrackActorAlias Property Actor23 Auto
Apropos2TrackActorAlias Property Actor24 Auto
Apropos2TrackActorAlias Property Actor25 Auto
Apropos2TrackActorAlias Property Actor26 Auto
Apropos2TrackActorAlias Property Actor27 Auto
Apropos2TrackActorAlias Property Actor28 Auto
Apropos2TrackActorAlias Property Actor29 Auto
Apropos2TrackActorAlias Property Actor30 Auto
Apropos2TrackActorAlias Property Actor31 Auto
Apropos2TrackActorAlias Property Actor32 Auto
Apropos2TrackActorAlias Property Actor33 Auto
Apropos2TrackActorAlias Property Actor34 Auto
Apropos2TrackActorAlias Property Actor35 Auto
Apropos2TrackActorAlias Property Actor36 Auto
Apropos2TrackActorAlias Property Actor37 Auto
Apropos2TrackActorAlias Property Actor38 Auto
Apropos2TrackActorAlias Property Actor39 Auto
Apropos2TrackActorAlias Property Actor40 Auto
Apropos2TrackActorAlias Property Actor41 Auto
Apropos2TrackActorAlias Property Actor42 Auto
Apropos2TrackActorAlias Property Actor43 Auto
Apropos2TrackActorAlias Property Actor44 Auto
Apropos2TrackActorAlias Property Actor45 Auto
Apropos2TrackActorAlias Property Actor46 Auto
Apropos2TrackActorAlias Property Actor47 Auto
Apropos2TrackActorAlias Property Actor48 Auto
Apropos2TrackActorAlias Property Actor49 Auto
Apropos2TrackActorAlias[] Property Actors Auto Hidden

Function SetUpApropos2Actors()
    Log("SetUpApropos2Actors")
    Actors = New Apropos2TrackActorAlias[20]

    Int i = 0
    While i < Actors.Length
        Actors[i] = GetNthAlias(i) As Apropos2TrackActorAlias
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
        SetUpApropos2Actors()
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
    RegisterForModEvent("HookOrgasmStart", "OrgasmStart")
EndFunction

Bool Function CheckCanRun(String meth)
    ;Debug("CheckCanRun: " + meth)    
    If !Self || !Config
        Error("Critical error - " + meth)
        Return False
    EndIf    

    If !Config.Enabled || GetState() != "Enabled"
        Debug("Config.Enabled=" + Config.Enabled + ", GetState=" + GetState())        
        Return False
    EndIf    
    Return True
EndFunction

Event OrgasmStart(int threadId, bool HasPlayer)
    If !CheckCanRun("OrgasmStart")
        Return
    EndIf

    SslThreadController thread = SexLab.GetController(threadId)
    SslBaseAnimation animation = thread.Animation
    Actor[] actorList = thread.Positions

    Actor primaryActor
    
    If HasPlayer
        primaryActor = PlayerRef
    Else 
    	Int actorPos = thread.GetPosition(actorList[0])
        primaryActor = actorList[0]
    EndIf
    
    Bool isPrimaryFemale = SexLab.GetGender(primaryActor) == FEMALE
    Bool isPrimaryMale = !isPrimaryFemale
    Bool isPrimaryVictim = thread.IsVictim(primaryActor)

    Actor activeActor
    If actorList.Length > 1
        activeActor = actorList[1]
    EndIf
    
    Apropos2TrackActorAlias actor_alias = GetTrackedActorOrStartTracking(primaryActor)
    actor_alias.ProcessOrgasm()

EndEvent

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

Apropos2TrackActorAlias Function GetTrackedActorOrStartTracking(Actor anActor)
    Apropos2TrackActorAlias aproposActor = GetTrackedAlias(anActor)
    If aproposActor
        Return aproposActor
    EndIf
    String actorName = anActor.GetDisplayName()
    If Config.TraceMessagesEnabled
        Debug(actorName + " was not being tracked. Start tracking now...")
    EndIf    
    aproposActor = TrackActor(anActor)
    Return aproposActor
EndFunction

Apropos2TrackActorAlias Function TrackActor(Actor anActor)
    If IsTrackableActor(anActor) && IsNotTracked(anActor)
        Int nextSlot = GetNextAvailableActorSlot()
        If (nextSlot > -1)
            Apropos2TrackActorAlias actorAlias = Actors[nextSlot]
            Debug("Using next slot " + nextSlot)
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
            If Config.TraceMessagesEnabled
                Debug(actorName + " is being tracked")    
            EndIf
            Return False
        EndIf
        i += 1
    EndWhile
    If Config.TraceMessagesEnabled
        Debug(actorName + " is not being tracked")    
    EndIf
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

Apropos2TrackActorAlias Function GetTrackedAlias(Actor anActor)
    String actorName = anActor.GetDisplayName()

    Int i = 0
    While i < Actors.Length
        If Actors[i].GetState() == "Tracking" && Actors[i].GetActor() == anActor
            Debug("Found Apropos2TrackActorAlias the represents " + actorName)
            Return Actors[i]
        EndIf
        i += 1
    EndWhile

    If Config.TraceMessagesEnabled
        Debug("GetTrackedAlias(Actor=" + actorName + ") ==> Not tracked.")
    EndIf
    Return None
EndFunction

Function Log(String msg)
    Config.Log(msg, Source="Apropos2Actors")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, Source="Apropos2Actors")
EndFunction
