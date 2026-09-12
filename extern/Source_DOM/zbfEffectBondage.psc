Scriptname zbfEffectBondage extends activemagiceffect  

zbfBondageShell Property zbf Auto
GlobalVariable Property zbfSettingDebugMode Auto

zbfSlot slot
Actor TargetRef
String sName

Bool bHasGagSound
Int iEffectRepeatMask
Int iEffectStartEndMask

Float fUpdateFrequency
Float fNextGagSound

Int iId

; @section: zbfEffectBondage
; 
; This is the interface for zbfEffectBondage::
; 
; None of the functions here should be called directly, save for the global Event functions. These
; are used to send events and controll all enchantment controlled actors.
; 
; ZAP uses two systems to control actors. One is an enchantment driven system that is suitable for npcs and
; other, low activity, actors.
; 
; The other system is a slot based system that should be used for actively controlled actors.
; 
; This module does not contain any public functions except:  
; ::SendRescanEvent
; ::SendLogEvent
; 
; The rest of the functions are either unsuitable to call from outside a ZAP context, or are internal to the 
; zbfEffectBondage:: module.
; 

Function RegisterForEvents()
	RegisterForModEvent("ZapRescanActors", "RescanActor")
	RegisterForModEvent("ZapLogActors", "LogActor")
	RegisterForModEvent("ZapSlotActors", "SlottedActor")
	RegisterForModEvent("ZapUnslotActors", "UnslottedActor")
	RegisterForModEvent("ZapSexLabAnimationEnd", "OnSexLabAnimationEnd")
EndFunction

; @section: Events
; 
; Use these event sending functions rather than "manually" sending events. They document parameters and provide a common way to
; send these events around.
;

; Sends a *Rescan* event to all actors.
; 
; This event will trigger a refresh of all running effects on all actors everywhere. If poses are
; set up by console, facial expressions and so on have been tuned, then these may be overwritten by
; the refresh.
; 
; Typically this should not be called by modders often, but rather on user commands from MCM or similar
; functionality.
; 
; If a modders wants to refresh an effect on a specific actor, there's a slot system (zbfSlot:: and zbfBondageShell::SlotActor)
; available to do so.
; 
Function SendRescanEvent() Global
	Int iHandle = ModEvent.Create("ZapRescanActors")
	Bool bSent = ModEvent.Send(iHandle)
	Debug.TraceConditional("zbfEffectBondage: SendRescanEvent failed.", !bSent)
EndFunction

; Sends a *Log* event to all actors.
; 
; This makes all actors in range, that are currently running effects (fewer than one might think),
; send a log event to console log and Skyrim Papyrus log.
; 
Function SendLogEvent() Global
	Int iHandle = ModEvent.Create("ZapLogActors")
	Bool bSent = ModEvent.Send(iHandle)
	Debug.TraceConditional("zbfEffectBondage: SendLogEvent failed.", !bSent)
EndFunction

; Sends a *Slotted* event.
; 
; This is used internally to let actors know that an actor has been slotted. The event itself is only handled
; by any actors actually being slotted. Their enchantment will move to an inactive state and let the slotting system
; take care of running effects.
; 
; This should not be called manually, instead the zbfSlot:: system will handle slotting and unslotting actors.
; 
Function SendSlottedEvent(Actor akActor) Global
	Int iHandle = ModEvent.Create("ZapSlotActors")
	ModEvent.PushForm(iHandle, akActor)
	Bool bSent = ModEvent.Send(iHandle)
	Debug.TraceConditional("zbfEffectBondage: SendSlotEvent failed.", !bSent)
EndFunction

; Sends an *Unslotted* event.
; 
; Reverses the actions of the ::SendSlottedEvent event. After this event has been received, all enchantments should
; work as normal again.
; 
; This should not be called manually, instead the zbfSlot:: system will handle slotting and unslotting actors.
; 
Function SendUnslottedEvent(Actor akActor) Global
	Int iHandle = ModEvent.Create("ZapUnslotActors")
	ModEvent.PushForm(iHandle, akActor)
	Bool bSent = ModEvent.Send(iHandle)
	Debug.TraceConditional("zbfEffectBondage: SendUnslotEvent failed.", !bSent)
EndFunction

; @section: Event handling
; 

; Events reacting to mod events.
; 
; Each implementation is overriden in the respective state.
; 
Event LogActor()
	If zbfUtil.IsValidActor(TargetRef)
		;MiscUtil.PrintConsole("Unslotted: " + sName)
		String output = "Scanning\nActor(" + TargetRef + "): " + sName + " (unslotted)"
		output += "\nState: " + GetState() 
		output += "\nDisabled: " + TargetRef.IsDisabled()
		output += "\nParent cell: " + TargetRef.GetParentCell()
		Log(output)
		MiscUtil.PrintConsole(output)
	EndIf
EndEvent

Event RescanActor()
	bNeedsRescan = True
EndEvent

Event SlottedActor(Form akForm)
	If akForm == TargetRef
		slot = zbf.FindSlot(TargetRef)
		;Debug.Trace("zbfEffectBondage ===> " + sName + " <==== SLOTTED")
	EndIf
EndEvent

Event UnslottedActor(Form akForm)
	If akForm == TargetRef
		Log("Actor was unslotted. Restoring full functionality.")
		slot = None
		;Debug.Trace("zbfEffectBondage ===> " + sName + " <==== UNSLOTTED")
	EndIf
EndEvent

Event OnSexLabAnimationEnd(Form controller, String tags, Form a1, Form a2, Form a3, Form a4)
	If a1 == TargetRef || a2 == TargetRef || a3 == TargetRef || a4 == TargetRef
		ApplyEffects(TargetRef, iEffectStartEndMask)
	EndIf
EndEvent

Event OnCellAttach()
	bNeedsRescan = True
EndEvent

Event OnCellDetach()
EndEvent

Function ApplyEffects(Actor akTarget, Int iMask)
	If zbfUtil.IsValidActor(akTarget)
		Int finalMask = iMask
		If slot != None
			; Log("Slot mask " + slot.GetEffectSlotControlMask())
			finalMask = zbfUtil.RemoveFlag(finalMask, slot.GetEffectSlotControlMask())
		EndIf

		; Log("ApplyEffects with final mask " + finalMask)
		zbf.ApplyModifiersMask(akTarget, finalMask)

		If bHasGagSound && (Utility.GetCurrentRealTime() >= fNextGagSound)
			zbf.PlayGagSound(akTarget)
			fNextGagSound = zbf.NextGagSound()
		EndIf
	EndIf
EndFunction

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If StringUtil.Find(Self As String, "<None>") >= 0
		Debug.Trace("zbfEffectBondage OnEffectStart Orphaned ActiveMagicEffect script found self="+self)
		return
	; Code that would throw 'No object bound' error, if script is no longer attached
	EndIf
	if akTarget == None || self == None
		Debug.Trace("zbfEffectBondage Skipping OnEffectStart, actor is not ready="+akTarget+" self="+self)
		return
	endif
	; iId detects race conditions. It's set to zero by default, so a negative value marks the place of interrupt.
	;Debug.Trace("zbfEffectBondage OnEffectStart self="+self)
	TargetRef = akTarget
	iId = -1

	bEnableLogging = (zbfSettingDebugMode.GetValueInt() > 0)
	iId = -2
	sName = zbfUtil.GetActorName(akTarget)
	iId = -3
	iId = Utility.RandomInt(1000, 9999)
	RegisterForEvents()
	fUpdateFrequency = zbf.GetUpdateIntervalForActor(TargetRef)

	slot = zbf.FindSlot(akTarget)
	;Debug.Trace("zbfEffectBondage Slot found as " + slot)
	GoToState("Default")
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	GoToState("Finished")
	Log("Effect terminating on " + sName)
EndEvent

Auto State Idle
	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		; Bare bones finish here to make sure that effects do nothing if they haven't started yet
	EndEvent
EndState

State Detached
	Event OnBeginState()
		Log("Detached " + sName)
	EndEvent

	Event OnCellAttach()
		Log("OnCellAttach " + sName)
		GoToState("Default")
	EndEvent
EndState

Event OnUpdate()
	If StringUtil.Find(Self As String, "<None>") >= 0
		Debug.Trace("zbfEffectBondage OnUpdate Orphaned ActiveMagicEffect script found self="+self)
		TargetRef = None
		return
		; Code that would throw 'No object bound' error, if script is no longer attached
	EndIf
	if TargetRef == None || self == None
		Debug.Trace("zbfEffectBondage OnUpdate, actor is not ready="+TargetRef+" self="+self)
		return
	endif
	;Debug.Trace("zbfEffectBondage OnUpdate, actor is not ready="+TargetRef+" self="+self)
EndEvent

Bool bNeedsRescan = True
State Default
	Event OnBeginState()
		Log("OnBeginState: Default")
		bNeedsRescan = True
		If StringUtil.Find(Self As String, "<None>") >= 0
			Debug.Trace("zbfEffectBondage OnBeginState DefaultState Orphaned ActiveMagicEffect script found self="+self)
			TargetRef = None
			return
			; Code that would throw 'No object bound' error, if script is no longer attached
		EndIf
		if TargetRef == None || self == None
			Debug.Trace("zbfEffectBondage OnBeginState DefaultState actor is not ready="+TargetRef+" self="+self)
			return
		endif
		;Debug.Trace("zbfEffectBondage OnBeginState DefaultState target="+TargetRef+" self="+self)
		RegisterForSingleUpdate(0.1)
	EndEvent

	Event OnUpdate()
		If StringUtil.Find(Self As String, "<None>") >= 0
			Debug.Trace("zbfEffectBondage OnUpdate DefaultState Orphaned ActiveMagicEffect script found self="+self)
			TargetRef = None
			return
			; Code that would throw 'No object bound' error, if script is no longer attached
		EndIf
		if TargetRef == None || self == None
			Debug.Trace("zbfEffectBondage OnUpdate DefaultState actor is not ready="+TargetRef+" self="+self)
			return
		endif
		;Debug.Trace("zbfEffectBondage OnUpdate 1 DefaultState target="+TargetRef+" self="+self)

		Int iMaskToUse = iEffectRepeatMask
		If bNeedsRescan
			bNeedsRescan = False

			; Update frequency
			fUpdateFrequency = zbf.GetUpdateIntervalForActor(TargetRef)
			fNextGagSound = Utility.GetCurrentRealTime()

			; Get effect mask
			iEffectStartEndMask = zbf.WornEffectMask(TargetRef)
			iEffectRepeatMask = iEffectStartEndMask
			If !zbfUtil.HasFlag(iEffectRepeatMask, zbf.iEffectRepeat)
				iEffectRepeatMask = zbfUtil.RemoveFlag(iEffectRepeatMask, zbf.iEffectArms)
			EndIf
			bHasGagSound = zbf.WornHasGagSound(TargetRef)
			Log("Flags: " + iEffectStartEndMask + " and repeating: " + iEffectRepeatMask)

			iMaskToUse = iEffectStartEndMask
		EndIf

		ApplyEffects(TargetRef, iMaskToUse)
		If StringUtil.Find(Self As String, "<None>") >= 0
			Debug.Trace("zbfEffectBondage OnUpdate DefaultState Orphaned ActiveMagicEffect script found self="+self)
			TargetRef = None
			return
			; Code that would throw 'No object bound' error, if script is no longer attached
		EndIf
		if TargetRef == None || self == None
			Debug.Trace("zbfEffectBondage OnUpdate DefaultState actor is not ready="+TargetRef+" self="+self)
			return
		endif
		;Debug.Trace("zbfEffectBondage OnUpdate 2 DefaultState target="+TargetRef+" self="+self)
		RegisterForSingleUpdate(fUpdateFrequency)
	EndEvent

	Event RescanActor()
		If zbfUtil.IsValidActor(TargetRef)
			bNeedsRescan = True
		EndIf
	EndEvent

	Event OnCellDetach()
		GoToState("Detached")
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Finished")
		Log("Effect terminating on " + sName)
	EndEvent
EndState

State Finished
	Event OnBeginState()
		Log("Finished " + sName)
		ApplyEffects(TargetRef, iEffectStartEndMask)
	EndEvent

	Event OnEffectStart(Actor akTarget, Actor akCaster)
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
	EndEvent
EndState


; Private or debugging functions
; 

Bool bEnableLogging = True
String sLogPrefix
Function Log(String asMessage, Bool abCondition = True)
	If abCondition && bEnableLogging
		Debug.Trace("zbfEffectBondage(" + sName + ", " + iId + ", " + GetState() + "): " + asMessage)
	EndIf
EndFunction
