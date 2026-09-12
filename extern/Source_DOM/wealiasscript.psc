Scriptname WEAliasScript extends ReferenceAlias  
{Should be attached to all aliases in Wilderness Encounter quests.}

bool Property RegisterLoadingAndUnloading = true auto
{Default = TRUE; causes the quest to keep running if loaded, and stop if all similarly flagged aliases unload.}

int Property StopRegisteringUnloadingIfStageHasBeenSet = -1 Auto
{Default = -1 (doesn't matter); don't register unloading if this quest stage}

bool Property PacifyOnLoad = False Auto
{Default = FALSE: Should this alias be made unagressive when he loads?}

bool Property MakeAggressiveAndAttackPlayerIfAttacked = False Auto
{Default = FALSE: Should this alias be made an enemy and set his aggression to very aggressive if he's attacked by the player?}

bool Property MakeAggressiveOnGainLOSToPlayer = false Auto
{Default = FALSE: Should this alias be made an enemy and set his aggression to very aggressive if he sees the player?}

float Property MakeAggressiveOnDistanceToPlayer = 0.0 Auto
{Default = -1, off: Postive value means when the player gets this close the actor should become aggressive. Note: there is a short delay, this is not instantaneous}

bool Property InitiallyDisabled = false Auto
{Default = FALSE: should this alias disable when it loads the first time}
bool disabledOnce

bool Property DisableOnUnload = false Auto
{Default = FALSE: Should this alias disable itself when it unloads}

bool Property KillOnLoad = false Auto
{Default = FALSE: Should this alias kill itself when it loads}

bool Property DisintegrateOnLoad = false Auto
{Default = FALSE: Should this alias kill and disintegrate itself when it loads}

Faction Property PutInThisFactionOnLoad Auto
{Optional: Put alias into this faction on load. Useful for setting up a faction that hates itself if you want to pacify things and yet make them attack each other.}

Activator property DefaultAshPile1 Auto
{The ash pile to use when disintegrating this actor.}

bool attached	;My cell has attached or I moved into an attached cell   (OR - rare/impossible: tried to detach before ever trying to attach)
bool detached	;My cell has detached or I moved into a detached cell   (OR - rare/impossible: tried to detach before ever trying to attach)
; VSmo subhuman
bool bSetAttack	=	false

Event OnUpdate()
	;USKP 2.0.3 - Fuck you Papyrus, let's see how you like this!
	if( GetReference() )
		if MakeAggressiveOnDistanceToPlayer > 0.0

			if GetReference().GetDistance(Game.GetPlayer()) < MakeAggressiveOnDistanceToPlayer && GetActorRef() != None && !GetActorRef().IsDead()
	; 			;debug.trace(self + "OnUpdate() player is within MakeAggressiveOnDistanceToPlayer [ " + MakeAggressiveOnDistanceToPlayer + "], making aggressive to player.")
				(GetOwningQuest() as WEScript).makeAliasAggressiveAndAttackPlayer(self)
			Else

	; 			;debug.trace(self + "OnUpdate() player isn't close enough, so calling RegisterForSingleUpdate(1) to poll again later.")
				RegisterForSingleUpdate(1.0)
			EndIf
		EndIf
	EndIf
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if !bSetAttack && MakeAggressiveAndAttackPlayerIfAttacked && akAggressor == Game.GetPlayer()
;		(GetOwningQuest() as WEScript).makeAliasAggressiveAndAttackPlayer(self)
		GoToState("Attacking")
	EndIf

EndEvent

Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
;	if akViewer == GetActorReference() && akTarget == Game.GetPlayer() as Actor
	if !bSetAttack && akViewer == (GetReference() as actor) && (akTarget as actor) == Game.GetPlayer()
		GoToState("Attacking")
;		(GetOwningQuest() as WEScript).makeAliasAggressiveAndAttackPlayer(self)
	EndIf
EndEvent

Event OnCellAttach()
	TryToAttach()
EndEvent

Event OnAttachedToCell()
	TryToAttach()
EndEvent

Event OnCellDetach()
	TryToDetach()
EndEvent

Event OnDetachedFromCell()
	TryToDetach()
EndEvent


Event OnLoad()
	TryToAttach()

	if InitiallyDisabled && DisabledOnce == False
; 		;debug.trace(self + "OnLoad() calling TryToDisable()")
		DisabledOnce = True
;		TryToDisable()
		if GetReference()
			GetReference().Disable()
		endIf
	EndIf

	if MakeAggressiveOnGainLOSToPlayer
; 		;debug.trace(self + "OnLoad() calling RegisterForSingleLOSGain(GetActorReference(), Game.GetPlayer() as Actor)")
;		RegisterForSingleLOSGain(GetActorReference(), Game.GetPlayer() as Actor)
		RegisterForSingleLOSGain(GetReference() as actor, Game.GetPlayer())
	
	EndIf

	if MakeAggressiveOnDistanceToPlayer > 0
; 		;debug.trace(self + "OnLoad() calling RegisterForSingleUpdate(1)")
		RegisterForSingleUpdate(1.0)
	EndIf
		
	if PacifyOnLoad
		(GetOwningQuest() as WEScript).pacifyAlias(self)
	EndIf

	if PutInThisFactionOnLoad
;		GetActorReference().AddToFaction(PutInThisFactionOnLoad)
		(GetReference() as actor).AddToFaction(PutInThisFactionOnLoad)
	EndIf
	
	if KillOnLoad || DisintegrateOnLoad
;		GetActorReference().kill()
		(GetReference() as actor).kill()
	EndIf
	
; 	;debug.trace(self + "OnLoad()")
	
EndEvent

Event OnDying(Actor akKiller)
	if (DisintegrateOnLoad)
		actor myself = GetReference() as actor
		myself.SetAlpha(0, False)
		myself.SetCriticalStage(myself.CritStage_DisintegrateEnd)
		myself.AttachAshPile(DefaultAshPile1)
		Utility.Wait(1.65)
		myself.SetCriticalStage(myself.CritStage_DisintegrateEnd)
	EndIf
	; VSmO subhuman
	GoToState("Dead")
EndEvent

Event OnUnload()
	TryToDetach()
	
	;USKP 2.0 added sanity check for cleared aliases
    if DisableOnUnload && (GetReference() != None)
;         ;debug.trace(self + "OnUnload() calling Disable()")
        GetReference().Disable()
    EndIf
	
EndEvent

;*** DON'T TRACE IN HERE BEFORE SETTING THE ATTACH/DETACHED VARS - for thread safety
Function TryToAttach()
	bSetAttack = false
	GoToState("")
	if attached || detached    ;If we have already detached or attached before
		;do nothing
		Return
		
	Else ;We haven’t detached or attached before
		Attached  = true
		
		;*** increment and do stuff here
		if RegisterLoadingAndUnloading 
; 			;debug.trace(self + "OnLoad() calling AliasLoadingOrUnloading(IsLoading = True)")
			(GetOwningQuest() as WEScript).AliasLoadingOrUnloading(IsLoading = True)
		EndIf
		
	Endif

	
EndFunction

;*** DON'T TRACE IN HERE BEFORE SETTING THE ATTACH/DETACHED VARS - for thread safety
Function TryToDetach()
	bSetAttack = false
	If detached ; we’ve already detached
		;do nothing
		Return
	Elseif attached ; we haven’t detached AND we have attached – clean up
		Detached = true
		
		;*** decrement and do stuff here
		if RegisterLoadingAndUnloading
;			if StopRegisteringUnloadingIfStageHasBeenSet != -1 && GetOwningQuest().GetStageDone(StopRegisteringUnloadingIfStageHasBeenSet) == True
			if StopRegisteringUnloadingIfStageHasBeenSet != -1 && GetOwningQuest().IsStageDone(StopRegisteringUnloadingIfStageHasBeenSet) == True
; 				debug.trace(self + "WEAliasScript Not unregistering this reference because stage has been set: " + StopRegisteringUnloadingIfStageHasBeenSet)
			Else		
; 				;debug.trace(self + "OnUnload() calling AliasLoadingOrUnloading(IsLoading = False)")
				(GetOwningQuest() as WEScript).AliasLoadingOrUnloading(IsLoading = False)
			EndIf
		EndIf
		
	Else ; we haven’t attached or detached yet, so we didn’t really exist, do nothing and force ignoring everything else
		Detached = true
		Attached = true
		
		;*** tell quest to clean up if everyone else is gone – but do NOT decrement, because we never incremented
		(GetOwningQuest() as WEScript).RegisterForStopQuest()
		
	Endif

EndFunction

; VSmO subhuman
state Dead

	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	endEvent

	Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	endEvent

	event	OnUpdate()
	endEvent
endState

state	Attacking

	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	endEvent

	Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	endEvent

	event	OnBeginState()
		if !bSetAttack && GetActorRef() != None && !GetActorRef().IsDead()
			bSetAttack = true
			(GetOwningQuest() as WEScript).makeAliasAggressiveAndAttackPlayer(self)
		endIf
	endEvent
endState
