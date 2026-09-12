Scriptname DOM_SlaveManager extends Quest  
Import Utility
Import DOM_Util

; Main properties
DOM_PlayerAlias Property DOMPlayerAlias Auto 
DOM_Generator Property DOMGenerator Auto
DOM_Core Property DOM01 Auto
DOM_PAH Property DOMPAH Auto
DOM_Diary Property DOM04 Auto
Actor Property PlayerRef Auto
ReferenceAlias Property EssentialRef Auto

; Externals
MiscObject Property Gold001 Auto

; Skyrim factions
Faction Property PlayerFollowerFaction Auto
Faction Property CurrentFollowerFaction Auto
Faction Property DunPlayerAllyFaction Auto
Faction Property BardAudienceExcludedFaction Auto

; DOM factions
Faction Property DOMSlaveManagerFaction Auto
Faction Property DOMActorFaction Auto
Faction Property DOMActorExcludedFaction Auto
Faction Property DOMActorFamilyFaction Auto
Faction Property DOMActorFamilyReunited Auto
Faction Property DOMBeingCaptured Auto
Faction Property DOMActorGender Auto
Faction Property DOMNoCleanCrimeFaction Auto
Faction Property DOMActorIndexFaction Auto
Faction Property DOMAliasIndexFaction Auto

; DOM globals
ReferenceAlias Property slave_tmp Auto
ReferenceAlias Property family_tmp Auto
Message Property DOMFamilyRansomMessage Auto 
int Property DOMSlaveManagerIndex = 0 Auto Hidden

Function Initialize(int mng_idx)
	DOMSlaveManagerIndex = mng_idx
	LogInfo("========================================================================")
	LogInfo("==                       DOM: Slaves manager "+DOMSlaveManagerIndex+"                        ==")
	LogInfo("========================================================================")
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
	if slave_tmp.GetRef() == akRef
		slave_tmp.clear()
	endif
	if family_tmp.GetRef() == akRef
		family_tmp.clear()
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
			;LogTrace("GetActor() found "+i)
			selected_actor = actorArray[i]
			return selected_actor
		endif
		i += 1
	EndWhile
	if akRef == None
		LogInfo("ERROR: GetActor() not found NONE")
	else
		LogInfo("ERROR: GetActor() not found "+akRef.GetDisplayName())
	endif
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
	;LogTrace("GetActorAlias() n alias = "+actorAliases.length+" find "+akRef.getDisplayName())
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
		;LogTrace("GetEmptyAliasIndex(): Alias "+i+" ref="+actorAliases[i].GetRef())
		If actorAliases[i].GetRef() == None
			return i
		endif
		i += 1
	EndWhile
	return i
EndFunction

Function LockActor(Actor akRef)
	akRef.SetFactionRank(DOMBeingCaptured,1)
	akRef.SetAv("aggression", 0)
	akRef.SetAv("confidence", 0)
	akRef.SetAv("assistance", 0)
	akRef.SetAv("morality",   0)
	;EssentialRef.ForceRefTo(akRef)
	;akRef.SetNoBleedoutRecovery(true)
	;CalmActorFast(akRef)	
	;akRef.AllowPCDialogue(false)
	;akRef.ClearLookAt()
	;akRef.AllowBleedoutDialogue(false)
	akRef.AddToFaction(DunPlayerAllyFaction)
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

Function UnlockActor(Actor akRef)
	akRef.RemoveFromFaction(DOMBeingCaptured)
	;EssentialRef.Clear()
	;akRef.SetNoBleedoutRecovery(false)
	;akRef.AllowPCDialogue(false)
	;akRef.ClearLookAt()
	;akRef.AllowBleedoutDialogue(false)
EndFunction

Function AnimActor(Actor akRef, string the_anim)
	LogTrace("Animation: "+akRef.GetDisplayName()+" pose="+the_anim+" anim="+(the_anim != ""))
	if the_anim != ""
		Debug.SendAnimationEvent(akRef,the_anim)
	endif
EndFunction

DOM_Actor Function Capture(Actor captive, string last_anim)
	;LogTrace(captive.GetDisplayName()+" 1 isunconscious="+captive.IsUnconscious())
	LogTrace("Capture() name="+captive.getDisplayName()+" pose="+last_anim+" isunconscious="+captive.IsUnconscious())
	if captive.GetFactionRank(DOMBeingCaptured) == 1
		return None ; already being captured
	endif
	if captive.IsInFaction(DOMActorExcludedFaction)
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None  ; not elligible
	endif
	if captive.IsInFaction(DOM01.DOMActorInTransfer)
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None  ; not elligible
	endif
	If captive.IsInFaction(PlayerFollowerFaction)
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	If captive.GetFactionRank(CurrentFollowerFaction) >= 0
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if captive.IsInFaction(DOMActorFaction)
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None  ; already a slave or slaver
	endif
	if DOMPAH.isPAH(captive)
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if DOM01.HshHouseSlaveFaction != None && captive.IsInFaction(DOM01.HshHouseSlaveFaction)
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if DOM01.AygasSlaveTypeFaction != None && captive.IsInFaction(DOM01.AygasSlaveTypeFaction)
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	EssentialRef.ForceRefTo(captive)
	LockActor(captive)
	Faction crime_faction = captive.GetCrimeFaction()
	captive.SetCrimeFaction(None)
	MakeActorPlayerFriend(captive)
	if last_anim == "BleedOutStart"
		AnimActor(captive,last_anim)
	endif
	;LogTrace(captive.GetDisplayName()+" 2 isunconscious="+captive.IsUnconscious())
	Actor clone = DOM01.CloneOrNot(captive,false)
	If clone == None
		LogTrace("Capture() Cloning failed for "+captive)
		UnlockActor(captive)
		captive.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	;LogTrace(clone.GetDisplayName()+" 3 isunconscious="+captive.IsUnconscious())
	if clone != captive
		EssentialRef.Clear()
		EssentialRef.ForceRefTo(clone)
		;CalmActorFast(clone)
		clone.setAlpha(0.01)
		clone.MoveTo(captive)
		Wait(1.0) ; Wait for 3d loaded
		AnimActor(clone,last_anim)
		captive.setAlpha(0.01) ; 0 is completely transparent, 1 is completely visible.
		clone.setAlpha(1.0)
		captive.MoveTo(DOM01.DOMTonyMarker) ;  or move the corpse to the dead body cleanup cell
		captive.GetLeveledActorBase().SetInvulnerable(false)
		captive.EndDeferredKill()
		captive.KillEssential(PlayerRef)
		captive.SetCriticalStage(4) ; 
	endif
	if !DOM01.cleanCrimeFaction
		clone.SetCrimeFaction(crime_faction)
		clone.RemoveFromFaction(DOMNoCleanCrimeFaction)
	else
		clone.SetCrimeFaction(None)
		clone.setFactionRank(DOMNoCleanCrimeFaction,1)
	endif
	;DOM01.PrintAllFactions(clone)
	;LogTrace(clone.GetDisplayName()+" 4 isunconscious="+captive.IsUnconscious())
	DOM_Actor akActor = AddActor(clone,last_anim,true)
	;LogTrace(akActor.GetName()+" 5 isunconscious="+akActor.akRef.IsUnconscious())
	EssentialRef.Clear()
	if DOMSlaveManagerIndex <= 0
		DOM04.NotifyCapture(akActor)
		DOM04.NotifyCaptureCircumstances1(akActor,last_anim)
	endif
	DOMPlayerAlias.HasCaptured(akActor)
	LogTrace("Capture() finished name="+clone.getDisplayName()+" pose="+last_anim)
	;LogTrace(akActor.GetName()+" 6 isunconscious="+akActor.akRef.IsUnconscious())
	return akActor
EndFunction

DOM_Actor Function AddActor(Actor akRef, string last_anim, bool newActor)
	;LogTrace("AddActor() start name="+akRef.getDisplayName()+" agg="+akRef.getAv("aggression"))
	if akRef.IsChild()
		return None
	endif
	If akRef.IsInFaction(PlayerFollowerFaction)
		LogTrace(akRef.getDisplayName()+" you should not enslave a follower")
		return None
	endif
	If akRef.GetFactionRank(CurrentFollowerFaction) >= 0
		LogTrace(akRef.getDisplayName()+" you should not enslave a follower")
		return None
	endif
	; Looking if actor is already in our list
	ReferenceAlias actor_alias = GetActorAlias(akRef)
	If actor_alias != None
		LogTrace(akRef.getDisplayName()+" is already a player slave")
		return None
	endif
	
	int ind = GetEmptyAliasIndex()
	if ind >= actorAliases.length
		LogTrace("You have reached your maximum number of Slaves")
		return None
	endif	
	actor_alias = actorAliases[ind]

	; Check if actor is a PAH slave
	if DOMPAH.isPAH(akRef)
		DOMPAH.ReleaseSlave(akRef)
		LogTrace(akRef.getDisplayName()+": Promote PAH slave to DOM")
	endif

	; Check if actor is a DOM slaver
	DOM_Actor ac_alias = DOM01.GetSlaver(akRef)
	if ac_alias != None
		LogTrace(ac_alias.getName()+": Demote slaver to slave")
		DOM01.ReleaseSlaverAlias(ac_alias)
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
	
	actor_alias.ForceRefTo(akRef)
	DOM_Actor akActor  = actor_alias as DOM_Actor
	akActor.target     = targetAliases[ind]
	akActor.SetDisplayName(akRef.GetDisplayName())
	akActor.AfterAssign(true,newActor,true) ; slave=yes, new=newActor, player's=yes
	DOM_Mind akMind = actor_alias as DOM_Mind
	akMind.SetDisplayName(akRef.GetDisplayName())
	akMind.AfterAssign(true,newActor,true) ; slave=yes, new=newActor, player's=yes
	akActor.SetInitialBehaviour(last_anim)
	recently_added__actor = akActor
	UpdateActorArray(false)
	akActor.OnUpdate()
	akActor.OnUpdateGameTime()
	;LogTrace("AddActor() end name="+akRef.getDisplayName()+" agg="+akRef.getAv("aggression"))
	akActor.ResetDialogue()
	akActor.akRef.SetFactionRank(DOMSlaveManagerFaction,DOMSlaveManagerIndex) ; This is the slave manager index, main is 0. Any extra manager should get that index upon registering with DOMCore
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
	LogTrace("Removing alias: "+akActor.GetName())
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
			LogTrace("CheckActorAliases alias "+i+" actor's DOM ref was not correctly set!")
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
			LogTrace("CheckActorAliases alias "+i+" mind's DOM ref was not correctly set!")
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
		actorArray = new DOM_Actor[128]
	endif
	LogTrace("UpdateActorArray slaves refresh loop: size="+actorAliases.length)
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
					akActor.target     = targetAliases[i]
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
							LogTrace("UpdateActorArray Checking actor index "+actorCounter+" name = "+akActor.getname())
							akActor.ReCheck()
						else
							akActor.RegisterModEvents() ; This is the minimum
						endif
						if DOM01.StartupSyncTattoos && akRef.Is3DLoaded()
							;LogTrace("UpdateActorArray Sync tattoos actor index "+actorCounter+" name = "+akActor.getname())
							SlaveTats.synchronize_tattoos(akRef)
						endif
						if DOMSlaveManagerIndex <= 0
							DOM04.CheckDiaryByIndex(i,akActor)
						endif
					endif
					;akRef.EvaluatePackage()
					LogTrace("UpdateActorArray Recovered actor index "+actorCounter+" name = "+akActor.getname())
					actorCounter += 1
					if actorCounter > actorAliases.length
						LogTrace("UpdateActorArray ERROR found more than "+actorAliases.length+" actors!")
					endif
				endif
			endif
		endif
		i += 1
	EndWhile	
	if DOMSlaveManagerIndex <= 0
		HudNotification("Diary Of Mine - Active Writers: " + actorCounter as String + "/" + actorAliases.length as String)
	else
		HudNotification("Diary Of Mine Pool "+DOMSlaveManagerIndex+" - Active Writers: " + actorCounter as String + "/" + actorAliases.length as String)
	endif
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

; ### Active furnitures at capture
ObjectReference currentActiveFurniture = None

Function SetActiveFurniture(ObjectReference obj)
	if obj != None
		LogTrace("SetActiveFurniture "+obj.getName())
	else
		LogTrace("SetActiveFurniture None")
	endif
	currentActiveFurniture = obj
EndFunction

ObjectReference Function GetActiveFurniture()
	if currentActiveFurniture != None
		LogTrace("GetActiveFurniture "+currentActiveFurniture.getName())
	else
		LogTrace("GetActiveFurniture None")
	endif
	return currentActiveFurniture
EndFunction

; ### Family and Ransoming

Function SlaveFamilyCheck(Actor akTarget)
	;LogTrace("SlaveFamilyCheck: checking actor family "+akTarget.getDisplayName())
	int i = 0
	while i < actorCounter
		DOM_Actor slave = actorArray[i]
		if slave != None
			Actor akRef = slave.GetActorRef()
			if IsTogetherWithFast(akRef, PlayerRef, 2000.0) ; 2000 = 30 meters
				int rank = akTarget.GetRelationshipRank(akRef)
				if akTarget.HasFamilyRelationship(akRef) || rank >= 3
					int type = DOM01.GetFriendshipType(akTarget,akRef)
					LogTrace("SlaveFamilyCheck: "+slave.getName()+" is "+akTarget.getDisplayName()+"'s "+GetFriendshipString(akRef, type))
					slave_tmp.Clear()
					slave_tmp.ForceRefTo(akRef)
					family_tmp.Clear()
					family_tmp.ForceRefTo(akTarget)
					akTarget.SetFactionRank(DOMActorFamilyFaction,type)
					return
				endif
			endif
		endif
		i += 1
	EndWhile
	;LogTrace("SlaveFamilyCheck: done "+akTarget.getDisplayName())
EndFunction

Function SlaveFamilyRansom(Actor akTarget)
	LogTrace("SlaveFamilyRansom: checking actor family "+akTarget.getDisplayName())
	Actor akRef = slave_tmp.GetActorRef()
	DOM_Actor slave = GetActor(akRef)
	if slave != None
		int rank = akRef.GetFactionRank(DOMActorFamilyReunited)
		LogTrace("SlaveFamilyRansom: "+slave.getName()+" could be freed by "+akTarget.getDisplayName()+" reunited="+rank)
		if rank <= 0
			rank = 1
		else 
			rank += 1
		endif
		float fvalue = (DOMGenerator.GetActorPrice(akRef) as float)*DOMPlayerAlias.GetPersuaderModifier()/(rank as float)
		int max_value = DOMGenerator.GetNPCWealth(akTarget)
		int value = (fvalue as int)
		if value > max_value
			value = max_value
		endif
		int ibutton = DOMFamilyRansomMessage.show(value as float)  
		if ibutton == 0
			DOM04.NotifyReleaseRansom(slave)
			DOMPlayerAlias.HasRansomed(slave)
			slave.ReleaseOrDelete()
			PlayerRef.addItem(Gold001, value)
			SlaveFamilyAdjustRelationShip(akTarget,akRef,true)
			; Should probably make both actors walk to each other and hug
			;akTarget.playIdleWithTarget(pa_idle,akRef) ;
		else
			SlaveFamilyAdjustRelationShip(akTarget,akRef,false)
		endif
	endif
	;LogTrace("SlaveFamilyRansom: done "+akTarget.getDisplayName())
EndFunction

Function SlaveFamilyAdjustRelationShip(Actor akTarget, Actor akSlave, bool is_a_deal)
	if !is_a_deal
		int rank = akTarget.getRelationshipRank(PlayerRef)
		if rank < 4 ; loving actors will think it's ok
			if rank >= 0
				rank = -1
			elseif rank > - 4
				rank -= 1
			endif
			akTarget.setRelationshipRank(PlayerRef, rank)
		endif
		return
	endif

	int rank = akSlave.GetFactionRank(DOMActorFamilyReunited)
	if rank <= 0
		rank = 1
	else 
		rank += 1
	endif
	akSlave.SetFactionRank(DOMActorFamilyReunited,rank)
	akTarget.RemoveFromFaction(DOMActorFamilyFaction)
	if rank > 1 ; player tried to sell slave twice or more, getting angry
		rank = akTarget.getRelationshipRank(PlayerRef)
		if rank < 4
			if rank >= 0
				rank = -1
			elseif rank > - 4
				rank -= 1
			endif
			akTarget.setRelationshipRank(PlayerRef, rank)
		endif
		rank = akSlave.getRelationshipRank(PlayerRef)
		if rank < 4
			if rank >= 0
				rank = -1
			elseif rank > - 4
				rank -= 1
			endif
			akSlave.setRelationshipRank(PlayerRef, rank)
		endif
		return
	endif
	; first time everybody is happy
	int family_rank = akTarget.getRelationshipRank(akSlave)
	if family_rank > 0
		rank = akTarget.getRelationshipRank(PlayerRef)
		if rank < 3
			rank += family_rank
			if rank > 3
				rank = 3
			endif
			akTarget.setRelationshipRank(PlayerRef,rank)
		endif
		rank = akSlave.getRelationshipRank(PlayerRef)
		if rank < 3
			rank += family_rank
			if rank > 3
				rank = 3
			endif
			akSlave.setRelationshipRank(PlayerRef,rank)
		endif
	endif
EndFunction

; ##### Utilities

Function CheckSlaveNames()
	int i = 0
	while i < actorCounter
		DOM_Actor slave = actorArray[i]
		if slave != None
			Actor akRef = slave.GetActorRef()
			if akRef != None
				string display_name = akRef.GetDisplayName()
				if display_name != ""
					LogTrace("CheckSlaveNames "+i+" OK "+slave.GetName()+" display="+display_name)
				else
					LogTrace("CheckSlaveNames "+i+" FAIL "+slave.GetName()+" display="+display_name)
					slave.ReCheck()
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_SlaveManager: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_SlaveManager: "+msg)
	endif
EndFunction

Function HudNotification(string msg)
	if DOM01.debugMode
		Debug.Notification(msg)
	endif
EndFunction
