Scriptname _WetFootWet extends activemagiceffect  

ImpactDataSet FootImpact

_WetQuestScript Property _WetQuest Auto

Actor targ
Perk Property MuffledMovement Auto

;====================================================================================
 
Event OnEffectStart(Actor akTarget, Actor akCaster)
	If StringUtil.Find(Self As String, "<None>") >= 0
		Debug.Trace("_WetFootWet OnEffectStart Orphaned ActiveMagicEffect script found self="+self)
		return
	; Code that would throw 'No object bound' error, if script is no longer attached
	EndIf
	if akTarget == None
		Debug.Trace("_WetFootWet Skipping OnEffectStart, actor is not ready="+akTarget)
		return
	endif
	targ = akTarget
	MuffledMovement = Game.GetFormFromFile(0x00058213, "Skyrim.esm") as Perk
	If targ;.hasPerk(MuffledMovement)
		targ = None
	ElseIf targ != None
		FootImpact = _WetQuest._WetFootWetSoundIPDS
		RegisterForAnimationEvent(targ, "FootLeft")
		RegisterForAnimationEvent(targ, "FootRight")
		If targ == _WetQuest.PlayerRef
			RegisterForAnimationEvent(targ, "JumpUp")
			RegisterForAnimationEvent(targ, "JumpDown")
			GoToState("Alive")
		Else
			GoToState("AliveNPC")
		EndIf
	EndIf
EndEvent

;====================================================================================

State Alive

	Event OnAnimationEvent(ObjectReference aktarg, String EventName)
		If targ != None
			If EventName == "FootLeft"
				targ.PlayImpactEffect(FootImpact, "NPC L Calf [LClf]")
			ElseIf EventName == "FootRight"
				targ.PlayImpactEffect(FootImpact, "NPC R Calf [RClf]")
			Else
				targ.PlayImpactEffect(FootImpact, "NPC L Calf [LClf]")
				targ.PlayImpactEffect(FootImpact, "NPC R Calf [RClf]")
			EndIf
		EndIf
	EndEvent

	Event OnDying(Actor akKiller)
		GoToState("Dead")
	EndEvent

EndState

;====================================================================================

State AliveNPC

	Event OnAnimationEvent(ObjectReference aktarg, String EventName)
		If targ != None
			If EventName == "FootLeft"
				targ.PlayImpactEffect(FootImpact, "NPC L Calf [LClf]")
			Else
				targ.PlayImpactEffect(FootImpact, "NPC R Calf [RClf]")
			EndIf
		EndIf
	EndEvent

	Event OnDying(Actor akKiller)
		GoToState("Dead")
	EndEvent

EndState

State Dead
EndState