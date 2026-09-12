Scriptname _WetColdBreathAction extends activemagiceffect  

;====================================================================================

VisualEffect Breath

_WetQuestScript Property _WetQuest Auto

Bool Property RegularBreaths Auto

Float Frequency
Float BreathFreq

Actor targ

;====================================================================================

Function Breathe(Float TempFrequency, VisualEffect TempBreath)
	Frequency = TempFrequency
	Breath = TempBreath
	If targ == _WetQuest.PlayerRef
		GoToState("RegularPlayer")
	Else
		GoToState("RegularNPC")
	EndIf
EndFunction

;====================================================================================
 
Event OnEffectStart(Actor akTarget, Actor akCaster)
	If StringUtil.Find(Self As String, "<None>") >= 0
		Debug.Trace("_WetColdBreathAction OnEffectStart Orphaned ActiveMagicEffect script found self="+self)
		return
	; Code that would throw 'No object bound' error, if script is no longer attached
	EndIf
	if akTarget == None || self == None
		Debug.Trace("_WetColdBreathAction Skipping OnEffectStart, actor is not ready="+akTarget)
		return
	endif
	targ = akTarget
	Race tRace = targ.GetRace()
	If RegularBreaths
		If tRace == _WetQuest.ArgonianRace
			Breathe(2.4, _WetQuest._WetBreathArgVE)
		ElseIf tRace == _WetQuest.KhajiitRace
			Breathe(2.4, _WetQuest._WetBreathKhajVE)
		ElseIf tRace == _WetQuest.WerewolfBeastRace || (_WetQuest.DBWerebear && tRace == _WetQuest.DBWerebear)
			Breathe(1.9, _WetQuest._WetBreathWerewolfVE)
		Else
			Breathe(2.4, _WetQuest._WetBreathVE)
		EndIf
	Else
		If tRace == _WetQuest.ArgonianRace
			If _WetQuest.InVanillaColdTimed
				Breath = _WetQuest._WetBreathFastArgVE
			Else
				Breath = _WetQuest._WetBreathFrigidArgVE
			EndIf
		ElseIf tRace == _WetQuest.KhajiitRace
			If _WetQuest.InVanillaColdTimed
				Breath = _WetQuest._WetBreathFastKhajVE
			Else
				Breath = _WetQuest._WetBreathFrigidKhajVE
			EndIf
		Else
			If _WetQuest.InVanillaColdTimed
				Breath = _WetQuest._WetBreathFastVE
			Else
				Breath = _WetQuest._WetBreathFrigidVE
			EndIf
		EndIf
		RegisterForAnimationEvent(targ, "MotionDrivenDialogueNextClip")
		RegisterForAnimationEvent(targ, "BeginCastLeft")
		RegisterForAnimationEvent(targ, "BeginCastRight")
		RegisterForAnimationEvent(targ, "weaponSwing")
		RegisterForAnimationEvent(targ, "arrowRelease")
		RegisterForAnimationEvent(targ, "SoundPlay.WPNSwingUnarmed")
		If targ == _WetQuest.PlayerRef
			targ.AddToFaction(_WetQuest._WetBreathPlayerFaction)
			GoToState("ActionPlayer")
		Else
			targ.AddToFaction(_WetQuest._WetBreathFaction)
			GoToState("ActionNPC")
		EndIf
	EndIf
EndEvent

;====================================================================================

State RegularPlayer

	Event OnBeginState()
		BreathFreq = Frequency
		OnUpdate()
	EndEvent

	Event OnUpdate()
		If StringUtil.Find(Self As String, "<None>") >= 0
			Debug.Trace("_WetColdBreathAction OnUpdate Orphaned ActiveMagicEffect script found self="+self)
			return
		; Code that would throw 'No object bound' error, if script is no longer attached
		EndIf
		if targ == None || self == None
			Debug.Trace("_WetColdBreathAction Skipping OnUpdate, actor is not ready="+targ)
			return
		endif
		if !targ.Is3DLoaded()
			RegisterForSingleUpdate(BreathFreq)
			return
		endif
		Breath.Play(targ, 1.2)
		Breath.Play(targ, 1.2)
		RegisterForSingleUpdate(BreathFreq)
	EndEvent

	Event OnRaceSwitchComplete()
		Race tRace = targ.GetRace()
		If tRace == _WetQuest.ArgonianRace
			Breathe(2.4, _WetQuest._WetBreathArgVE)
		ElseIf tRace == _WetQuest.KhajiitRace
			Breathe(2.4, _WetQuest._WetBreathKhajVE)
		ElseIf tRace == _WetQuest.WerewolfBeastRace || (_WetQuest.DBWerebear && tRace == _WetQuest.DBWerebear)
			Breathe(1.9, _WetQuest._WetBreathWerewolfVE)
		Else
			Breathe(2.4, _WetQuest._WetBreathVE)
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

EndState

State RegularNPC

	Event OnBeginState()
		BreathFreq = Frequency
		OnUpdate()
	EndEvent

	Event OnUpdate()
		If StringUtil.Find(Self As String, "<None>") >= 0
			Debug.Trace("_WetColdBreathAction OnUpdate Orphaned ActiveMagicEffect script found self="+self)
			return
		; Code that would throw 'No object bound' error, if script is no longer attached
		EndIf
		if targ == None || self == None
			Debug.Trace("_WetColdBreathAction Skipping OnUpdate, actor is not ready="+targ)
			return
		endif
		if !targ.Is3DLoaded()
			RegisterForSingleUpdate(BreathFreq)
			return
		endif
		Breath.Play(targ, 1.2)
		Breath.Play(targ, 1.2)
		RegisterForSingleUpdate(BreathFreq)
	EndEvent

	Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
		If aeCombatState == 1
			BreathFreq = Frequency / 1.5
		Else
			BreathFreq = Frequency
		EndIf
	EndEvent

	Event OnRaceSwitchComplete()
		If targ
			Race tRace = targ.GetRace()
			If tRace == _WetQuest.ArgonianRace
				Breathe(2.4, _WetQuest._WetBreathArgVE)
			ElseIf tRace == _WetQuest.KhajiitRace
				Breathe(2.4, _WetQuest._WetBreathKhajVE)
			ElseIf tRace == _WetQuest.WerewolfBeastRace || (_WetQuest.DBWerebear && tRace == _WetQuest.DBWerebear)
				Breathe(1.9, _WetQuest._WetBreathWerewolfVE)
			Else
				Breathe(2.4, _WetQuest._WetBreathVE)
			EndIf
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

	Event OnDying(Actor akKiller)
		OnEffectFinish(targ, targ)
	EndEvent

EndState

;====================================================================================

State ActionPlayer

	Event OnAnimationEvent(ObjectReference aktarg, string EventName)
		If targ
			Breath.Play(targ, 1.2)
			Breath.Play(targ, 1.2)
		EndIf
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		If targ
			targ.RemoveFromFaction(_WetQuest._WetBreathFaction)
			targ.RemoveFromFaction(_WetQuest._WetBreathPlayerFaction)
		EndIf
		GoToState("Dead")
	EndEvent

EndState

State ActionNPC

	Event OnAnimationEvent(ObjectReference aktarg, string EventName)
		If targ
			Breath.Play(targ, 1.2)
			Breath.Play(targ, 1.2)
		EndIf
	EndEvent

	Event OnCellDetach()
		OnEffectFinish(targ, targ)
	EndEvent

	Event OnUnload()
		OnEffectFinish(targ, targ)
	EndEvent

	Event OnDetachedFromCell()
		OnEffectFinish(targ, targ)
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		If targ
			targ.RemoveFromFaction(_WetQuest._WetBreathFaction)
			targ.RemoveFromFaction(_WetQuest._WetBreathPlayerFaction)
		EndIf
		GoToState("Dead")
	EndEvent

	Event OnDying(Actor akKiller)
		If targ
			targ.RemoveFromFaction(_WetQuest._WetBreathFaction)
		EndIf
		GoToState("Dead")
	EndEvent

EndState

State Dead
EndState