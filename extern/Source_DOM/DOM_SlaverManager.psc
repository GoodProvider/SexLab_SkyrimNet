Scriptname DOM_SlaverManager extends Quest  
Import Utility
Import DOM_Util

; Main properties
DOM_PlayerAlias Property DOMPlayerAlias Auto 
DOM_Core Property DOM01 Auto
DOM_Diary Property DOM04 Auto
DOM_PAH Property DOMPAH Auto
Actor Property PlayerRef Auto
ReferenceAlias Property EssentialRef Auto

; Skyrim factions
Faction Property PlayerFollowerFaction Auto
Faction Property CurrentFollowerFaction Auto
Faction Property DunPlayerAllyFaction Auto

; External factions

; DOM factions
Faction Property DOMActorFaction Auto
Faction Property DOMActorExcludedFaction Auto
Faction Property DOMBeingCaptured Auto
Faction Property DOMActorGender Auto
Faction Property DOMNoCleanCrimeFaction Auto
Faction Property DOMActorIndexFaction Auto
Faction Property DOMAliasIndexFaction Auto

Function Initialize()
	LogInfo("=======================================================================")
	LogInfo("==                       DOM: Slavers manager                        ==")
	LogInfo("=======================================================================")
	if DOMPlayerAlias == None
		ReferenceAlias player_alias = DOM01.GetAliasByName("PlayerAlias") as ReferenceAlias
		DOMPlayerAlias = player_alias as DOM_PlayerAlias
		LogInfo("WARNING: DOMPlayerAlias was not set - trying to recover DOMPlayerAlias="+DOMPlayerAlias)
	endif
	CheckActorAliases()
	SetObjectiveDisplayed(0)
	if updating_actor_array
		Wait(10.0)
		updating_actor_array = false
	endif
	UpdateActorArray(true) ; refresh actor array
EndFunction

Function RegisterForBootstrap(string eName)
	int i = 0
	while i < actorCounter
		actorArray[i].RegisterForModEvent(eName, "OnBootstrap")
		actorArray[i].mind.RegisterForModEvent(eName, "OnBootstrap")
		i += 1
	EndWhile
EndFunction

; ##### Actors

ReferenceAlias[] Property targetAliases Auto
ReferenceAlias[] Property actorAliases Auto
DOM_Actor[] Property actorArray Auto Hidden
Int Property actorCounter = 0 Auto Hidden

Int Function GetActorCount()
	return actorCounter
EndFunction

Int Function GetMaxActorCount()
	return actorAliases.length
EndFunction

Function ClearAliases(Actor akRef)
	if EssentialRef.GetRef() == akRef
		EssentialRef.clear()
	endif
EndFunction

DOM_Actor Function GetActorByIndex(int index)
	If index >= 0 && index < actorCounter
		return actorArray[index]
	endif
	return None
EndFunction

DOM_Actor selected_actor = None
DOM_Actor recently_added__actor = None
DOM_Actor Function GetActor(Actor akRef)
	if selected_actor != None && selected_actor.akRef == akRef
		return selected_actor
	endif
	if recently_added__actor != None && recently_added__actor.akRef == akRef
		return recently_added__actor
	endif
	;LogTrace("GetActor() n actors = "+actorCounter+" find "+akRef.getDisplayName())
	; Try to get actor from index faction
	int i = akRef.GetFactionRank(DOMActorIndexFaction)
	if i >= 0 && i < actorCounter
		if actorArray[i].akRef == akRef
			;LogTrace("GetActor() found "+i)
			selected_actor = actorArray[i]
			return selected_actor
		endif
	endif
	; Loop over array
	i = 0
	while i < actorCounter
		if actorArray[i].akRef == akRef
			selected_actor = actorArray[i]
			return selected_actor
		endif
		i += 1
	EndWhile
	return None
EndFunction

int Function GetActorIndex(Actor akRef)
	;LogTrace("GetActorIndex() n actors = "+actorCounter+" find "+akRef.getDisplayName())
	; Try to get actor from index faction
	int i = akRef.GetFactionRank(DOMActorIndexFaction)
	if i >= 0 && i < actorCounter
		if actorArray[i].akRef == akRef
			;LogTrace("GetActorIndex() found "+i)
			return i
		endif
	endif
	; Loop over array
	i = 0
	while i < actorCounter
		if actorArray[i].akRef == akRef
			;LogTrace("GetActorIndex() found "+i)
			return i
		endif
		i += 1
	EndWhile
	return -1
EndFunction

int Function GetAliasIndex(Actor akRef)
	; Try to get actor from index faction
	int n = actorAliases.length
	int i = akRef.GetFactionRank(DOMAliasIndexFaction)
	if i >= 0 && i < n
		if actorAliases[i].GetActorRef() == akRef
			return i
		endif
	endif
	; Loop over array
	i = 0
	While i < n
		If actorAliases[i].GetActorRef() == akRef
			return i
		endif
		i += 1
	EndWhile
	return -1
EndFunction

ReferenceAlias Function GetActorAlias(Actor akRef)
	; Try to get actor from index faction
	int n = actorAliases.length
	int i = akRef.GetFactionRank(DOMAliasIndexFaction)
	if i >= 0 && i < n
		if actorAliases[i].GetActorRef() == akRef
			return actorAliases[i]
		endif
	endif
	; Loop over array
	i = 0
	While i < actorAliases.length
		If actorAliases[i].GetActorRef() == akRef
			return actorAliases[i]
		endif
		i += 1
	EndWhile
	return None
EndFunction

ReferenceAlias Function GetActorAliasForced(Actor akRef)
	if akRef == None
		LogInfo("ERROR: GetActorAliasForced() not found NONE")
	endif
	;LogTrace("GetActorAlias() : n slavers = "+actorAliases.length+" find "+akRef.getDisplayName())																					   
	ReferenceAlias sl_alias = GetActorAlias(akRef)
	if sl_alias != None
		return sl_alias
	endif
	LogInfo("ERROR: GetActorAliasForced() not found at first try "+akRef.GetDisplayName())
	int itry = 1
	while itry < 20
		LogInfo("ERROR: GetActorAliasForced() wait and one more try "+akRef.GetDisplayName())
		Wait(1.0)
		itry += 1
		sl_alias = GetActorAlias(akRef)
		if sl_alias != None
			return sl_alias
		endif
		LogInfo("ERROR: GetActorAliasForced() not found at try "+itry+" "+akRef.GetDisplayName())
	endwhile
	LogInfo("ERROR: GetActorAliasForced() not found after "+itry+" attempts exiting "+akRef.GetDisplayName())	
	return None
EndFunction

int Function GetEmptyAliasIndex()
	Int i = 0
	While i < actorAliases.length
		LogTrace("GetEmptyAliasIndex(): Alias "+i+" ref="+actorAliases[i].GetRef())
		If actorAliases[i].GetRef() == None
			return i
		endif
		i += 1
	EndWhile
	return i
EndFunction

Function MakeActorPlayerFriend(Actor akRef)
	if akRef.GetRelationshipRank(PlayerRef) < 0
		akRef.SetRelationshipRank(PlayerRef, 0)
	endif
	akRef.IgnoreFriendlyHits(true)
	akRef.AddToFaction(DOMActorFaction)
	akRef.AddToFaction(DunPlayerAllyFaction)
	;akRef.AllowPCDialogue(true)
	;akRef.AllowBleedoutDialogue(true)
	DOMPAH.SetCanNotBeCaptured(akRef)
EndFunction

DOM_Actor Function Recruit(Actor recruit)
	LogTrace(recruit.GetDisplayName()+" 1 isunconscious="+recruit.IsUnconscious())
	LogTrace("Recruit() name="+recruit.getDisplayName())
	if recruit.GetFactionRank(DOMBeingCaptured) == 1
		return None ; already being captured
	endif
	if recruit.IsInFaction(DOMActorExcludedFaction)
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None  ; not elligible
	endif
	if recruit.IsInFaction(DOM01.DOMActorInTransfer)
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None  ; not elligible
	endif
	If recruit.IsInFaction(PlayerFollowerFaction)
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	If recruit.GetFactionRank(CurrentFollowerFaction) >= 0
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if recruit.IsInFaction(DOMActorFaction)
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None  ; already a slave or slaver
	endif
	if DOMPAH.isPAH(recruit)
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if DOM01.HshHouseSlaveFaction != None && recruit.IsInFaction(DOM01.HshHouseSlaveFaction)
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if DOM01.AygasSlaveTypeFaction != None && recruit.IsInFaction(DOM01.AygasSlaveTypeFaction)
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif

	MakeActorPlayerFriend(recruit)
	LogTrace(recruit.GetDisplayName()+" 2 isunconscious="+recruit.IsUnconscious())
	Actor clone = DOM01.CloneOrNot(recruit)
	If clone == None
		LogTrace("Recruit() Cloning failed for "+recruit)
		recruit.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	LogTrace(clone.GetDisplayName()+" 3 isunconscious="+recruit.IsUnconscious())
	if clone != recruit
		;CalmActorFast(clone)
		clone.setAlpha(0.01)
		clone.MoveTo(recruit)
		Wait(1.0) ; Wait for 3d loaded
		recruit.setAlpha(0.01) ; 0 is completely transparent, 1 is completely visible.
		clone.setAlpha(1.0)
		recruit.MoveTo(DOM01.DOMTonyMarker) ;  or move the corpse to the dead body cleanup cell
		recruit.GetLeveledActorBase().SetInvulnerable(false)
		recruit.EndDeferredKill()
		recruit.KillEssential(PlayerRef)
		recruit.SetCriticalStage(4) ; 
	endif
	clone.setFactionRank(DOMNoCleanCrimeFaction,1)
	;DOM01.PrintAllFactions(clone)
	LogTrace(clone.GetDisplayName()+" 4 isunconscious="+recruit.IsUnconscious())
	DOM_Actor akActor = AddActor(clone,true)
	LogTrace(akActor.GetName()+" 5 isunconscious="+akActor.akRef.IsUnconscious())
	DOM01.TrainSkillSlaver(PlayerRef,0.5)
	DOMPlayerAlias.HasRecruited(akActor)
	LogTrace("Recruit() finished name="+clone.getDisplayName())
	LogTrace(akActor.GetName()+" 6 isunconscious="+akActor.akRef.IsUnconscious())
	return akActor
EndFunction

DOM_Actor Function AddActor(Actor akRef, bool newActor)
	if akRef.IsChild()
		return None
	endif
	If akRef.IsInFaction(PlayerFollowerFaction) || akRef.GetFactionRank(CurrentFollowerFaction) >= 0
		HudNotification("You can not recruit a follower")
		LogTrace(akRef.getDisplayName()+" you can not recruit a follower")
		return None
	endif
	; Looking if actor is already in our list
	ReferenceAlias actor_alias = GetActorAlias(akRef)
	If actor_alias != None
		LogTrace(akRef.getDisplayName()+" is already at your service")
		return None
	endif
	
	int ind = GetEmptyAliasIndex()
	if ind >= actorAliases.length
		LogTrace("You have reached your maximum number of Slavers")
		return None
	endif	
	actor_alias = actorAliases[ind]
	
	; Check if actor is a PAH slave
	if DOMPAH.isPAH(akRef)
		DOMPAH.ReleaseSlave(akRef)
		LogTrace(akRef.getDisplayName()+": Promote slave to slaver")
	endif
	
	; Check if actor is a DOM slave
	DOM_Actor ac_alias = DOM01.GetSlave(akRef)
	if ac_alias != None
		LogTrace(ac_alias.getName()+": Promote slave to slaver")
		ac_alias.ReleaseOrDelete()
	endif	

	; Block dialogue until ready
	akRef.AllowPCDialogue(false)
	akRef.ClearLookAt()
	akRef.AllowBleedoutDialogue(false)

	; Remove from being captured factions
	DOMPAH.ClearCanBeCaptured(akRef)
	akRef.SetFactionRank(DOMActorFaction,1)
	akRef.removeFromFaction(DOMBeingCaptured)

	; Check gender
	if !akRef.IsInFaction(DOMActorGender)
		DOM01.CheckGender(akRef)
	endif

	; Update relationship
	;akRef.SetPlayerTeammate()

	actor_alias.ForceRefTo(akRef)
	DOM_Actor akActor  = actor_alias as DOM_Actor
	akActor.target     = targetAliases[ind]
	akActor.SetDisplayName(akRef.GetDisplayName())
	akActor.AfterAssign(false,newActor,true) ; slave=yes, new=newActor, player's=yes
	DOM_Mind akMind = actor_alias as DOM_Mind
	akMind.SetDisplayName(akRef.GetDisplayName())
	akMind.AfterAssign(false,newActor,true) ; slave=yes, new=newActor, player's=yes
	akActor.SetInitialBehaviour("")
	recently_added__actor = akActor
	UpdateActorArray(false)
	akActor.OnUpdate()
	akActor.OnUpdateGameTime()
	LogTrace("AddActor() name="+akRef.getDisplayName()+" allow dialogue"+" agg="+akRef.getAv("aggression"))
	akActor.ResetDialogue()
	return akActor
EndFunction

Function ReleaseActor(Actor akRef)
	if selected_actor != None && selected_actor.akRef == akRef
		selected_actor = None
	endif
	if recently_added__actor != None && recently_added__actor.akRef == akRef
		recently_added__actor = None
	endif
	ReferenceAlias actor_alias = GetActorAlias(akRef)
	if actor_alias != None
		ReleaseAlias(actor_alias)
	endif
EndFunction

Function ReleaseAlias(ReferenceAlias actor_alias)
	DOM_Actor akActor = (actor_alias as DOM_Actor)
	if actor_alias.GetActorRef() == None
		LogTrace("Removing alias: already removed "+akActor.GetName())
		return
	endif
	LogTrace("Removing Slaver: "+akActor.GetName())
	if DOM01.GetActorToJoin() == akActor
		DOM01.ResetDOMActorToJoin(akActor)
	endif
	if DOM01.GetActor1ToJoinSexlab() == akActor
		DOM01.ResetDOMActor1ToJoinSexlab(akActor)
	endif
	if DOM01.GetActor2ToJoinSexlab() == akActor
		DOM01.ResetDOMActor2ToJoinSexlab(akActor)
	endif
	if DOM01.GetActor3ToJoinSexlab() == akActor
		DOM01.ResetDOMActor3ToJoinSexlab(akActor)
	endif
	if selected_actor == akActor
		selected_actor = None
	endif
	if recently_added__actor == akActor
		recently_added__actor = None
	endif
	DOM01.DOM_SlaverLoadSlave.SetValue(0)
	akActor.DoClear()
	;akActor.akRef = None ; Keep to allow reaction to death
	UpdateActorArray(false)
EndFunction

Function CheckActorAliases()
	;LogTrace("CheckActorAliases checking DOM pointers")
	int n = actorAliases.length
	int i = 0
	int k = 0
	LogTrace("CheckActorAliases checking DOM pointers array size="+n)
	While i < n
		DOM_Actor akActor = actorAliases[i] as DOM_Actor
		if akActor.DOM01 != DOM01
			LogTrace("CheckActorAliases alias "+i+" actor was not correctly set!")
			akActor.DOM01 = DOM01
			k += 1
		endif
		if akActor.PlayerRef != PlayerRef
			;LogTrace("CheckActorAliases alias "+i+" actor's player ref was not correctly set!")
			akActor.PlayerRef = PlayerRef
			;k += 1
		endif
		if akActor.target != targetAliases[i]
			;LogTrace("CheckActorAliases alias "+i+" actor's target was not correctly set!")
			akActor.target = targetAliases[i]
			;k += 1
		endif
		DOM_Mind akMind = actorAliases[i] as DOM_Mind
		if akMind.DOM01 != DOM01
			LogTrace("CheckActorAliases alias "+i+" mind was not correctly set!")
			akMind.DOM01 = DOM01
			k += 1
		endif
		if akMind.PlayerRef != PlayerRef
			;LogTrace("CheckActorAliases alias "+i+" mind's player ref was not correctly set!")
			akMind.PlayerRef = PlayerRef
			;k += 1
		endif
		i += 1
	EndWhile	
	if k == 0
		LogTrace("CheckActorAliases All DOM pointers are OK")
	else
		LogTrace("CheckActorAliases Found "+k+" wrong DOM pointers! Corrected")
	endif
EndFunction

bool updating_actor_array = false
Function UpdateActorArray(bool do_check)
	LogTrace("UpdateActorArray refreshing actors busy="+updating_actor_array)
	if updating_actor_array
		return
	endif
	updating_actor_array = true
	int i = 0
	actorCounter = 0
	if actorArray.length != actorAliases.length
		LogTrace("UpdateActorArray new array allocated, previous size = "+actorArray.length)
		actorArray = new DOM_Actor[32]
	endif
	LogTrace("UpdateActorArray slavers refresh loop: size="+actorAliases.length)
	While i < actorAliases.length
		Actor ActorRef = actorAliases[i].GetActorRef()
		If ActorRef != None
			DOM_Actor akActor = actorAliases[i] as DOM_Actor
			if akActor == None
				LogInfo("ERROR: UpdateActorArray Failed to recover actor index "+i+" name = "+ActorRef.getDisplayName())
				actorAliases[i].Clear()
			else
				Actor akRef = akActor.GetActorRef()
				if akRef == None
					LogInfo("WARNING: UpdateActorArray Failed to recover actor reference "+actorCounter+" name = "+ActorRef.getDisplayName())
					actorAliases[i].ForceRefTo(ActorRef)
					akActor = actorAliases[i] as DOM_Actor
					akRef = akActor.GetActorRef()
				elseif akRef != ActorRef
					LogInfo("WARNING: UpdateActorArray Failed to validate actor reference "+actorCounter+" name = "+akRef.getDisplayName())
					actorAliases[i].ForceRefTo(akRef)
					akActor = actorAliases[i] as DOM_Actor
					akRef = akActor.GetActorRef()
				endif
				if akRef == None || akActor == None
					LogInfo("ERROR: UpdateActorArray Failed to recover actor index "+i+" name = "+ActorRef.getDisplayName())
					actorAliases[i].Clear()
				else
					;LogTrace("UpdateActorArray Recovering actor index "+actorCounter+" name = "+akActor.getname())
					actorArray[actorCounter] = akActor
					akActor.target = targetAliases[i]
					akRef.SetFactionRank(DOMActorIndexFaction,actorCounter)
					akRef.SetFactionRank(DOMAliasIndexFaction,i)
					if akActor.akRef != ActorRef
						LogInfo("WARNING: UpdateActorArray dom actor ref was wrongly set: "+akActor.akRef+" instead of "+ActorRef)
						akActor.akRef = ActorRef
					endif
					if akActor.mind.akRef != ActorRef
						LogInfo("WARNING: UpdateActorArray dom mind ref was wrongly set: "+akActor.mind.akRef+" instead of "+ActorRef)
						akActor.mind.akRef = ActorRef
					endif
					if do_check
						if DOM01.StartupCheckActor
							akActor.Recheck()
						else
							akActor.RegisterModEvents() ; This is the minimum
						endif
						if DOM01.StartupSyncTattoos && akRef.Is3DLoaded()
							SlaveTats.synchronize_tattoos(akRef)
						endif
						DOM04.CheckDiaryXByIndex(i,akActor)
					endif
					;akRef.EvaluatePackage()
					Logtrace("Recovered actor index "+actorCounter+" name = "+akActor.getname())
					actorCounter += 1
					if actorCounter > actorAliases.length
						LogInfo("ERROR found more than "+actorAliases.length+" actors!")
					endif
				endif
			endif
		endif
		i += 1
	EndWhile	
	HudNotification("Diary Of Mine - Active Readers: " + actorCounter as String + "/" + actorAliases.length as String)
	updating_actor_array = false
EndFunction

Function ReCheck()
	int i = 0
	while i < actorCounter
		DOM_Actor akActor = actorArray[i]
		if akActor != None
			akActor.ReCheck()
		endif
		i += 1
	endwhile
EndFunction

; ##### Utilities

Function LogInfo(string msg)
	Debug.Trace("DOM_SlaverManager: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_SlaverManager: "+msg)
	endif
EndFunction

Function HudNotification(string msg)
	if DOM01.debugMode
		Debug.Notification(msg)
	endif
EndFunction
