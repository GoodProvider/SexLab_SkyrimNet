Scriptname DW_BreathSpellScr extends activemagiceffect

DW_CORE property CORE Auto

Actor akActor

Int Sound1ID = 0
Int Sound2ID = 0
Sound Sound1
Sound Sound2
float strSound

Event OnEffectStart( Actor akTarget, Actor akCaster )
	If StringUtil.Find(Self As String, "<None>") >= 0
		Debug.Trace("DW_BreathSpellScr OnEffectStart Orphaned ActiveMagicEffect script found self="+self)
		return
	; Code that would throw 'No object bound' error, if script is no longer attached
	EndIf
	if akTarget == None
		Debug.Trace("DW_BreathSpellScr OnEffectStart actor="+akTarget)
		return
	endif
	akActor = akTarget
	RegisterForSingleUpdate(1)
EndEvent

Event OnUpdate()
	If StringUtil.Find(Self As String, "<None>") >= 0
		Debug.Trace("DW_BreathSpellScr OnUpdate Orphaned ActiveMagicEffect script found self="+self)
		return
	; Code that would throw 'No object bound' error, if script is no longer attached
	EndIf
	if akActor == None || self == None
		Debug.Trace("DW_BreathSpellScr OnUpdate akActor="+akActor+" self="+self)
		return
	endif
	;sound Breath high,low,none
	;CORE.sexlab.Log(Sound1ID+" Breath cycle start "+Sound2ID)
	if akActor != None && (CORE.DW_ModState08.GetValue() == 1 && akActor == Game.GetPlayer()) || (CORE.DW_ModState00.GetValue() == 1 && akActor != Game.GetPlayer())
		float rank = CORE.SLA.GetActorArousal(akActor)
		if CORE.DW_ModState12.GetValue() == 0
			strSound = rank/100
		else
			strSound = 1
		endif
		
		if akActor.GetLeveledActorBase().GetSex() == 1		;female
			Sound1 = CORE.Breathing1
			Sound2 = CORE.Breathing2
		elseif akActor.GetLeveledActorBase().GetSex() == 0	;male
			Sound1 = CORE.Breathing3
			Sound2 = CORE.Breathing4
		else												;no beasts
			akActor.RemoveSpell(CORE.DW_Breath_Spell)
			return
		endif

		if  rank >= CORE.DW_effects_heavy.GetValue()		;high arousal
			if Sound1ID != 0
				;CORE.sexlab.Log(Sound1ID+" Breath1 stop")
				Sound.StopInstance(Sound1ID)
				Sound1ID = 0
			endif
			if Sound2ID == 0
				Sound2ID = Sound2.play(akActor)
				;CORE.sexlab.Log(Sound2ID+" Breath2 start")
				Sound.SetInstanceVolume(Sound2ID, strSound)
			else
				;CORE.sexlab.Log(Sound2ID+" Breath2 update")
				Sound.SetInstanceVolume(Sound2ID, strSound)
			endif
      
		elseif rank >= CORE.DW_effects_light.GetValue()		;low arousal
			if Sound2ID != 0
				;CORE.sexlab.Log(Sound2ID+" Breath2 stop")
				Sound.StopInstance(Sound2ID)
				Sound2ID = 0
			endif
			if Sound1ID == 0
				Sound1ID = Sound1.play(akActor)
				;CORE.sexlab.Log(Sound1ID+" Breath1 start")
				Sound.SetInstanceVolume(Sound1ID, strSound)
			else
				;CORE.sexlab.Log(Sound1ID+" Breath1 update")
				Sound.SetInstanceVolume(Sound1ID, strSound)
			endif
		else												;no arousal
			;CORE.sexlab.Log("Arousal too low, Breathing effect stopping " +Sound1ID + " | " + Sound2ID)
			akActor.RemoveSpell(CORE.DW_Breath_Spell)
			return
		endif
		if akActor.HasSpell(CORE.DW_Breath_Spell)
			RegisterForSingleUpdate(CORE.DW_SpellsUpdateTimer.GetValue())
			return
		endif
	endif
	akActor.RemoveSpell(CORE.DW_Breath_Spell)
EndEvent

Event OnPlayerLoadGame()
	;CORE.sexlab.Log("OnPlayerLoadGame(), Breathing effect stopping ")
	akActor.RemoveSpell(CORE.DW_Breath_Spell)
EndEvent

Event OnEffectFinish( Actor akTarget, Actor akCaster )
	if Sound1ID != 0
		Sound.StopInstance(Sound1ID)
		;CORE.sexlab.Log("Breath1 removed")
	endif
	if Sound2ID != 0
		Sound.StopInstance(Sound2ID)
		;CORE.sexlab.Log("Breath2 removed")
	endif
EndEvent