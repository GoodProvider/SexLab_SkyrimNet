Scriptname DOM_Extra extends Quest  
Import Utility

DOM_Core Property DOMCore Auto
DOM_SlaveManager Property DOM02Extra Auto
DOM_SEXLAB Property DOMSexlab Auto
Actor Property PlayerRef Auto

Int Property captureKey = 34 Auto Hidden ; G
Int Property modifierKeyDefault = 42 Auto Hidden ; SHIFT
bool Property on_initialize = false Auto Hidden

Event OnInit()
	LogInfo("OnInit")
	Initialize()
EndEvent

Event OnPlayerLoadGame()
	LogInfo("OnPlayerLoadGame")
	Initialize()
EndEvent

Event OnGameReload()
	LogInfo("OnGameReload")
	Initialize()
EndEvent

Function Initialize()
	LogInfo("Initialize on_initialize="+on_initialize+" on_player_loadgame="+DOMCore.on_player_loadgame)
	if on_initialize
		return
	endif
	on_initialize = true
	Utility.Wait(4.0)
	int n = 0
	While (!DOMCore.IsRunning() || DOMCore.IsStarting()) && n < 100
		LogInfo("Initialize DOM is starting="+DOMCore.IsStarting())
		wait(2.0)
		n+=1
		if n > 100
			LogInfo("Could not wait forever for DOM to start, status="+DOMCore.IsRunning())
			return
		endif
	endwhile
	n = 0
	while DOMCore.on_player_loadgame && n < 100
		LogInfo("Initialize on_initialize="+on_initialize)
		wait(2.0)
		n+=1
		if n > 100
			LogInfo("Could not wait forever for DOM to finish initialize, status="+DOMCore.IsRunning())
			return
		endif
	endwhile
	LogInfo("===============================================================================")
	LogInfo("==                         DOM: Extra slave manager                         ===")
	LogInfo("===============================================================================")
	registerKeys()
	if DOM02Extra == None
		LogInfo("ERROR extra slave manager is not set")
		on_initialize = false
		return
	endif
	int idx = DOMCore.GetSlaveManagerIndex(DOM02Extra)
	if idx > 0
		LogInfo("SUCCESS extra slave manager already registered with index="+idx)
		on_initialize = false
		return
	endif
	; Only try to add after checking if already registered
	idx = DOMCore.AddSlaveManager(DOM02Extra)
	if idx <= 0
		LogInfo("ERROR coud not add extra slave manager")
		on_initialize = false
		return
	else
		LogInfo("SUCCESS extra slave manager added with index="+idx)
	endif	
	DOM02Extra.Initialize(idx)
	on_initialize = false
EndFunction

Event OnKeyDown(Int KeyCode)
	If IsInMenuMode()
		return
	endif
	If UI.IsTextInputEnabled() || UI.IsMenuOpen("Crafting Menu")
        return
    endif
	;LogInfo("DOM::OnKeyDown key="+KeyCode)
	if modifierKeyDefault > 0
		if !Input.IsKeyPressed(modifierKeyDefault)
			return
		endif
	endif
	; Make sure player and is not in a Sexlab scene
	If DOMSexlab.IsAnimating(PlayerRef)
		return
	endif
	If captureKey && (KeyCode == captureKey)
		DOMCapture()
	endif
EndEvent

Function registerKeys()
	if captureKey != -1 && captureKey
		RegisterForKey(captureKey)
	endif
EndFunction

Function refreshKeys()
	UnregisterForAllKeys()
	registerKeys()
EndFunction

Function DOMCapture()
	Actor akTarget = (Game.GetCurrentCrosshairRef() As Actor)
	if akTarget == None
		return
	endif
	if DOMSexlab.IsAnimating(akTarget) ; In SL scene
		akTarget.RemoveFromFaction(DOMCore.DOMBeingCaptured)
		return
	endif
	if akTarget.IsInFaction(DOMCore.PlayerFollowerFaction) ; Is a follower
		akTarget.RemoveFromFaction(DOMCore.DOMBeingCaptured)
		return
	endif
	if akTarget.IsInFaction(DOMCore.DOMActorFaction) ; Is already a DOM actor
		akTarget.RemoveFromFaction(DOMCore.DOMBeingCaptured)
		return
	endif
	if akTarget.GetFactionRank(DOMCore.DOMBeingCaptured) == 1 ; already being processed by a slave manager
		return
	endif
	if akTarget.GetFactionRank(DOMCore.DOMBeingCaptured) == 3 ; already being processed
		return
	endif
	akTarget.SetFactionRank(DOMCore.DOMBeingCaptured,3)
	bool isValid = (akTarget.HasKeyWord(DOMCore.ActorTypeNPC) || akTarget.HasKeyWord(DOMCore.ActorTypeCreature)) && !akTarget.IsChild()
	bool isSlave = DOMCore.isASlave(akTarget)
	if !isValid || isSlave || akTarget.IsOnMount()
		akTarget.RemoveFromFaction(DOMCore.DOMBeingCaptured)
		return
	endif

	LogInfo("DOMCapture start Target is "+akTarget)
	HudNotification("Attempting capture of "+akTarget.getDisplayName())
	int sitState = akTarget.GetSitState()
	int sleepState = akTarget.GetSleepState()
	if sleepState>0
		; Wait 2 seconds if laying down or standing up
		if sleepState == 2 ; laying down
			Wait(2.0)
		elseif sleepState == 4 ; standing up
			LogInfo("DOMCapture ExitBed")
			akTarget.PlayIdle(DOMCore.ExitBed)
			Wait(2.0)
		endif
	else
		if sitState>0
			; Wait 2 seconds if sitting down or standing up
			if sitState == 2 ; sitting down
				Wait(2.0)
			elseif sitState == 4 ; standing up
					LogInfo("DOMCapture ExitChairFront")
				akTarget.PlayIdle(DOMCore.ExitChairFront)
				Wait(2.0)
			endif
		endif
	endif
					
	LogInfo("DOMCapture "+akTarget.getDisplayName()+" sleep="+sleepState+" sit="+sitState)
	DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerAttack)
	DOM_Actor akActor = DOM02Extra.Capture(akTarget,"BleedOutStart")
EndFunction

Function HudNotification(string msg)
	Debug.Notification(msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_Extra: "+msg)
	endif
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Extra: "+msg)
EndFunction
