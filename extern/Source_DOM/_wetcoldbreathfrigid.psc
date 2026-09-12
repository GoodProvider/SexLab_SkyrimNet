Scriptname _WetColdBreathFrigid extends activemagiceffect  

;====================================================================================

VisualEffect Property Breath Auto

_WetQuestScript Property _WetQuest Auto

Float Property Interval = 1.2 Auto

Actor targ

;====================================================================================
 
Event OnEffectStart(Actor akTarget, Actor akCaster)
	targ = akTarget
	If targ == _WetQuest.PlayerRef
		GoToState("Alive")
	Else
		GoToState("AliveNPC")
	EndIf
EndEvent

;====================================================================================

State Alive

	Event OnBeginState()
		OnUpdate()
	EndEvent

	Event OnUpdate()
		If StringUtil.Find(Self As String, "<None>") >= 0
			Debug.Trace("_WetColdBreathFrigid OnUpdate Orphaned ActiveMagicEffect script found self="+self)
			return
		; Code that would throw 'No object bound' error, if script is no longer attached
		EndIf
		if targ == None || self == None
			Debug.Trace("_WetColdBreathFrigid Skipping OnUpdate, actor is not ready="+targ)
			return
		endif
		if !targ.Is3DLoaded()
			RegisterForSingleUpdate(Interval)
			return
		endif
		Breath.Play(targ, 1.2)
		RegisterForSingleUpdate(Interval)
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

EndState

State AliveNPC

	Event OnBeginState()
		OnUpdate()
	EndEvent

	Event OnUpdate()
		If StringUtil.Find(Self As String, "<None>") >= 0
			Debug.Trace("_WetColdBreathFrigid OnUpdate Orphaned ActiveMagicEffect script found self="+self)
			return
		; Code that would throw 'No object bound' error, if script is no longer attached
		EndIf
		if targ == None || self == None
			Debug.Trace("_WetColdBreathFrigid Skipping OnUpdate, actor is not ready="+targ)
			return
		endif
		if !targ.Is3DLoaded()
			RegisterForSingleUpdate(Interval)
			return
		endif
		Breath.Play(targ, 1.2)
		RegisterForSingleUpdate(Interval)
	EndEvent

	Event OnEffectFinish(Actor akTarget, Actor akCaster)
		GoToState("Dead")
	EndEvent

	Event OnDying(Actor akKiller)
		OnEffectFinish(targ, targ)
	EndEvent

EndState

State Dead
EndState