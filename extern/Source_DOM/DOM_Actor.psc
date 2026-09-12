Scriptname DOM_Actor extends ReferenceAlias 
Import Utility
Import DOM_Util
Import DOM_EquipUtil

;### Constants ###
DOM_Core Property DOM01 Auto

;### Properties ###
Actor Property PlayerRef Auto Hidden
ReferenceAlias Property target Auto Hidden
DOM_Mind Property mind = None Auto Hidden

; ### canXXX Functions to check if actor can idle, move, animate, ...

; bool __canAnimate = true ; false if in Sexlab animation
; canAnimate -> false if is in Sexlab animation
; canAnimate -> false if is in Sexlab animation
; canAnimateLocal -> false if is in DOM animation
; canMove -> false if bound or in animation or passedout/sleeping
; canRunAway -> false if !canMove or caged or leashed or in utility cell or defeated
; canIdle -> false if moving/sitting/fighting/riding or bound or in animation or passedout/sleeping

;bool isInAttachedCell = true

;Event OnAttachedToCell()
;   isInAttachedCell = true
;   LogTrace("Moved to attached cell attach="+isInAttachedCell+" 3dloaded="+akRef.Is3DLoaded())
;EndEvent

;Event OnDetachedFromCell()
;   isInAttachedCell = false
;   LogTrace("Moved to detached cell attach="+isInAttachedCell+" 3dloaded="+akRef.Is3DLoaded())
;EndEvent

;Event OnCellAttach()
;   isInAttachedCell = true
;   LogTrace("Parent cell has attached attach="+isInAttachedCell+" 3dloaded="+akRef.Is3DLoaded())
;EndEvent

;Event OnCellDetach()
;  isInAttachedCell = false
;   LogTrace("Parent cell has detached attach="+isInAttachedCell+" 3dloaded="+akRef.Is3DLoaded())
;EndEvent

Function MoveBone(string node, Float value, bool update = true)
	if !akRef.HasNode(node)
		;LogTrace("Skeleton has no node "+node)
		return
	endif
	string modName = "DiaryOfMine" ; "DiaryOfMine.esm"

	float zpos = NetImmerse.GetNodeLocalPositionZ(akRef,node,false)
	float[] pos = NiOverride.GetNodeTransformPosition(akRef,false,true,node,modName)
	pos[2] = pos[2]+value
	;if value >= 0.0
	;	LogTrace("Moving node "+node+" to "+zpos+" "+pos[2]+" "+value)
	;	XPMSELib.SetNodePosition(akRef, true, node, pos, modName)
	;else
		;LogTrace("Scaling node "+node+" to "+zpos+" "+pos[2]+" "+value)
		XPMSELib.SetNodeScale(akRef, true, node, value, modName)
	;endif
	;NetImmerse.SetNodeLocalPositionZ(akRef,node,zpos+value,false) 
	zpos = NetImmerse.GetNodeLocalPositionZ(akRef,node,false)
	pos = NiOverride.GetNodeTransformPosition(akRef,false,true,node,modName)
	;LogTrace("Moved node "+node+" to "+zpos+" "+pos[2]+" "+value)
	NiOverride.UpdateNodeTransform(akRef, false, true, node)
	
	While Input.IsKeyPressed(DOM01.DOMKeys.moveKey)
		Wait(1.0)
	endwhile
	NiOverride.ClearBodyMorph(akRef, node, modName)
EndFunction

Function AddBodyMorph(String morphName, Float value, bool update = true)
	string modName = "DiaryOfMine" ; "DiaryOfMine.esm"
		
	float val = PapyrusUtil.ClampFloat(value / 2.0, 0.0, 1.0) * 0.5
	;LogTrace("Apply morph "+morphName+" "+value+" -> "+val)
	NiOverride.SetBodyMorph(akRef, "BreastGravity", modName, val)
	NiOverride.SetBodyMorph(akRef, "BreastGravity2", modName, val)
	;NiOverride.SetBodyMorph(akRef, morphName, modName, value) ; "RaceMenuMorphsCBBE.esp"
	If update
		;LogTrace("Updating")
		NiOverride.UpdateModelWeight(akRef)
	endif
	NiOverride.UpdateNodeTransform(akRef, false, true, morphName)
EndFunction

bool __canAnimateLocal = true
bool Property canAnimateLocal Hidden ; false if in local animation
	bool Function get()
		return __canAnimateLocal
	EndFunction
	Function set(bool value) ; to be used by behaviour only
		__canAnimateLocal = value
		DOM01.DOMSexlab.SetForbidden(akRef,!value)
	EndFunction
EndProperty

bool __canIdleSexlab = true
bool Property canIdleSexlab Hidden ; false if engaged in or about to start sexlab animation
	bool Function get()
		if DOM01.DOMSexlab.IsAnimating(akRef)
			if __canIdleSexlab
				return true
			endif
			return false
		endif
		return true
	EndFunction
	Function set(bool value) 
		__canIdleSexlab = value
	EndFunction
EndProperty
bool __canAnimateSexlab = true
bool Property canAnimateSexlab Hidden ; false if engaged in or about to start sexlab animation
	bool Function get()
		if DOM01.DOMSexlab.IsAnimating(akRef)
			return false
		endif
		return __canAnimateSexlab
	EndFunction
	Function set(bool value) 
		__canAnimateSexlab = value
	EndFunction
EndProperty

bool __canAnimate = true
bool Property canAnimate Hidden
	bool Function get()
		if !__canAnimate	
			return false
		endif
		if !akRef.Is3DLoaded()
			;*ogTrace("canAnimate = false not 3dLoaded")
			return false
		endif
		if !canAnimateSexlab
			;*ogTrace("canAnimate = false SL animating")
			return false
		endif
		if akRef.IsOnMount()
			;*ogTrace("canAnimate = false on mount")
			return false
		endif
		return true
	EndFunction
	Function set(bool value) ; To be used by local animations as a fast disable local animation
		__canAnimate = value
	EndFunction
EndProperty

bool __canMove = false ; false if is restrained, or in any animation, true if moving
bool Property canMove Hidden
	bool Function get()
		if !__canMove	
			;*ogTrace("canMove="+__canMove)
			return false
		endif
		if !canAnimateLocal
			;*ogTrace("canMove can not animate local")
			return false
		endif
		if !canAnimateSexlab
			;*ogTrace("canMove can not animate sexlab")
			return false
		endif
		if akRef.IsInFaction(DOM01.DOMAnimatingFaction) ; should be covered by !canAnimateLocal
			;*ogTrace("canMove can not animate in sexlab faction")
			return false
		endif
		if is_restrained
			;*ogTrace("canMove can not animate is restrained")
			return false
		endif
		if (akRef.GetSleepState() != 0) || akRef.IsOnMount()
			;*ogTrace("canMove can not animate is sleeping or in or out of sleep or mounted")
			return false
		endif
		if mind.IsPassedOut()
			;*ogTrace("canMove can not animate is passed out")
			return false
		endif
		return true
	EndFunction
	Function set(bool value) ; to be used by behaviour only
		__canMove = value
		if value
			akRef.SetRestrained(false)
			akRef.SetDontMove(false)
			akRef.SetVehicle(None)
		else
			akRef.SetRestrained()
			akRef.SetDontMove()
		endif
	EndFunction
EndProperty

bool Property canRunAway Hidden
	bool Function get()
		if !canMove	
			return false
		endif
		if akRef.GetParentCell() == DOM01.AAADOMTestTony || the_bag_iam_in != None
			return false
		endif
		if is_leashed
			return false
		endif
		if is_jailed
			return false
		endif
		if has_leash
			return false
		endif
		if DOM01.DOMZaz.HasDefeatActive(akRef)
			return false
		endif
		return true
	EndFunction
EndProperty

bool canFight = false ; ; can fight for player
bool __canIdle = false ; false if is_bounded, moving, or in any animation
bool Property canIdle Hidden
	bool Function get()
		;*ogTrace("canIdle? "+__canIdle)
		if !__canIdle	
			;*ogTrace("canIdle false")
			return false
		endif
		if !canAnimateLocal
			;*ogTrace("canIdle canAnimateLocal false")
			return false
		endif
		if !akRef.Is3DLoaded()
			;*ogTrace("canIdle Is3DLoaded false")
			return false
		endif
		if !canIdleSexlab
			;*ogTrace("canIdle canIdleSexlab false")
			return false
		endif
		if akRef.IsInFaction(DOM01.DOMAnimatingFaction)
			;*ogTrace("canIdle DOMAnimatingFaction false")
			return false
		endif
		if is_moving
			;*ogTrace("canIdle is_moving false")
			return false
		endif
		if mind.is_walking_on_four
			;*ogTrace("canIdle is_walking_on_four false")
			return false
		endif
		if is_bounded ; restrained or wearing arm device or cuffs
			;*ogTrace("canIdle is_bounded false")
			return false
		endif
		if akRef.IsWeaponDrawn()
			;*ogTrace("canIdle weapon drawn false")
			return false
		endif
		if is_in_combat
			;*ogTrace("canIdle is_in_combat false")
			return false
		endif
		if is_sitting
			;*ogTrace("canIdle is_sitting false")
			return false
		endif
		if (akRef.GetSleepState() != 0) || akRef.IsOnMount()
			;*ogTrace("canIdle is_sleeping or on mount false")
			return false
		endif
		if mind.is_walking_on_four
			if !is_behaviour_pose && !is_behaviour_masturbate
				return false
			endif
		endif
		if mind.IsPassedOut()
			;*ogTrace("canIdle is_passed_out false")
			return false
		endif
		;*ogTrace("canIdle true")
		return true
	EndFunction
	Function set(bool value) ; to be used by behaviour only
		;*ogTrace("canIdle.Set() value"+value)
		__canIdle = value
	EndFunction
EndProperty

bool Property canIdleSoft Hidden
	bool Function get()
		if !__canIdle	
			return false
		endif
		if !canAnimateLocal
			return false
		endif
		if !canIdleSexlab
			return false
		endif
		if akRef.IsInFaction(DOM01.DOMAnimatingFaction)
			return false
		endif
		if is_restrained ; restrained but not if only wearing arm device or cuffs
			return false
		endif
		return true
	EndFunction
EndProperty

;bool Property is_weapon_drawn = false Auto Hidden
bool Property is_in_combat    = false Auto Hidden
bool Property is_sitting      = false Auto Hidden
bool __is_moving = false
bool Property is_moving Hidden
	bool Function get()
		if akRef.IsRunning()
			return true
		endif
		if akRef.IsSprinting()
			return true
		endif
		return __is_moving
	EndFunction
	Function set(bool value)
		__is_moving = value
	EndFunction
EndProperty

Float last_pos_x
Float last_pos_y

Function CheckCombatStatus()
	;*ogTrace("CheckCombatStatus is_restrained="+is_restrained)
	if is_restrained ; hands are not available
		return
	endif
	;*ogTrace("CheckCombatStatus should_fight_for_player="+mind.should_fight_for_player)
	if mind.should_fight_for_player
		if akRef.IsSneaking() != PlayerRef.IsSneaking() ; Cancel or start sneaking
			;LogTrace("CheckCombatStatus discrepancy akRef.IsSneaking()="+akRef.IsSneaking()+" player="+PlayerRef.IsSneaking())
			akRef.StartSneaking()
		endif
		;if !akRef.IsWeaponDrawn() && PlayerRef.IsWeaponDrawn()
		;	akRef.DrawWeapon()
		;elseif akRef.IsWeaponDrawn() && !PlayerRef.IsWeaponDrawn()
		;	akRef.SheatheWeapon()
		;endif
		;*ogTrace("CheckCombatStatus akRef.IsSneaking()="+akRef.IsSneaking()+" "+PlayerRef.IsSneaking() )
		return
	endif
EndFunction

bool is_idling = false
Function UpdateIsMovingOnTick()
	Float pos_x = akRef.GetPositionX()
	Float pos_y = akRef.GetPositionY()

	is_moving = (pos_x - 10) > last_pos_x || (pos_x + 10) < last_pos_x || (pos_y - 10) > last_pos_y || (pos_y + 10) < last_pos_y
	;*ogTrace("UpdateIsMovingOnTick is_moving="+is_moving+" is_idling="+is_idling)
	if !is_moving
		if behaviour == "follow_player"
			if PlayerRef.IsRunning() || PlayerRef.IsSprinting()
				CheckCombatStatus()
				is_moving = true
			endif
		elseif actor_trainer != None && behaviour == "follow_trainer"
			if actor_trainer.akRef.IsRunning() || actor_trainer.akRef.IsSprinting()
				if mind.should_fight_for_player
					mind.should_fight_for_player = false
				endif
				CheckCombatStatus()
				is_moving = true
			endif
		endif
	elseif is_idling
		is_idling = false
		LogTrace("UpdateIsMovingOnTick Anim_IdleReset")
		Anim_IdleReset()
	elseif akRef.IsRunning() || akRef.IsSprinting()
		if has_blindfold
			float mod = 15.0
			if __has_cuffs_back || __has_cuffs_boxtied || __has_yoke
				mod = 10.0
			elseif __has_cuffs_front || __has_cuffs_crossed || __has_armbinder
				mod = 12.5
			endif
			if RandomFloat()*mod < mind.MOD_Panic
				TripAndFall(4.0)
			endif
		elseif __has_cuffs_back || __has_cuffs_boxtied || __has_yoke
			if RandomFloat()*25.0 < mind.MOD_Panic
				TripAndFall(2.0)
			endif
		elseif __has_cuffs_front || __has_cuffs_crossed || __has_armbinder
			if RandomFloat()*35.0 < mind.MOD_Panic
				TripAndFall(1.5)
			endif
		endif
	endif
	last_pos_x = pos_x
	last_pos_y = pos_y
EndFunction

Actor Property akRef Auto Hidden
int Property actorSex Auto Hidden
int Property actorType = 0  Auto Hidden ; 0 = NPC, 1 = Animal, 2 = Creature
int Property actorRace = 0  Auto Hidden ; 10 = Human, 20 = Elf, 30 = Orc, 40 = Khajiit, 50 = Argonian
String name = "Unnamed Actor"
String title
string Property actorPossessive = "" Auto Hidden
string Property actorObjective = "" Auto Hidden
string Property actorPronoun = "" Auto Hidden
string Property actorBeVerb = "" Auto Hidden
string Property actorHaveVerb = "" Auto Hidden

; ### Setup and teardown ###

Event OnBootstrap(string eventName = "", string strArg = "", float numArg = 0.0, Form sender = None)
	;LogTrace("OnBootstrap()")
	UnregisterForModEvent("DOMBootstrap")
	ReCheck()
	if GetActorRef() != None
		AfterAssign(mind.is_slave,false,mind.is_player_slave)
	else
		DoClear()
	endif
EndEvent

Event OnLoad()
	if akRef == None
		return
	endif
	if mind == None
		return
	endif
	if is_resetting
		;LogTrace("OnLoad() while resetting - cancel")
		return
	endif
	;LogTrace("OnLoad() behaviour="+behaviour)
	SetProperties(mind.is_slave,mind.is_player_slave)
	;SlaveTats.synchronize_tattoos(akRef)
	; TAK Do we really need to register again?
	;RegisterModEvents()
	;RegisterForSingleUpdate(1.0)
	OnBehaviourLoad()
	RegisterForSingleUpdateGameTime(0.05) ; 1 hour Skyrim = 3 minutes real time and 0.05 = 9 seconds
	;*ogTrace("loaded")
EndEvent

Function ReCheck()
	;LogTrace("ReCheck")
	if akRef == None
		akRef = GetActorRef()
	endif
	if mind.akRef == None
		mind.akRef = akRef
	endif
	if name == ""
		name = akRef.GetDisplayName()
		if name == ""
			name = akRef.GetLeveledActorBase().GetName()
		endif
	endif
	if akRef.GetDisplayName() != name
		LogTrace("ReCheck SetDisplayName name="+name+" akRef="+akRef)
		akRef.SetDisplayName(name,true)
	endif
	actorType = DOM01.GetActorType(akRef)
	actorRace = DOM01.GetActorRace(akRef)
	actorSex  = DOM01.GetActorGender(akRef,actorType)
	ResetDialogue()
	ListTraineeNames() 
	if !hasTears()
		akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
	else
		akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
	endif
	if is_leashed || has_leash
		akRef.AddToFaction(DOM01.DOMIsLeashed)
	else
		akRef.RemoveFromFaction(DOM01.DOMIsLeashed)
	endif
	akRef.AddToFaction(DOM01.DOMActorAlreadyCleaned)
	if __is_naked
		akRef.AddToFaction(DOM01.DOMIsNaked)
	else
		akRef.RemoveFromFaction(DOM01.DOMIsNaked)
	endif
	if __has_blindfold
		akRef.AddToFaction(DOM01.DOMZaz.DOMHasBlindfold)
	else
		akRef.RemoveFromFaction(DOM01.DOMZaz.DOMHasBlindfold)
	endif
		
	akRef.RemoveFromFaction(DOM01.DOMAnimatingFaction)
	DOM01.DOMSexlab.ClearAnimatingFaction(akRef)
	DOM01.DOMSexlab.SetForbidden(akRef,false)
	if behaviour == "on_duty" || behaviour == "on_duty_clean"  || behaviour == "on_duty_restrained" 
		is_on_duty = true
	else
		is_on_duty = false
	endif
	mind.ReCheck()
	RecheckTrainer()
	SetTatsGlowColor()
	;RecheckTrainees()
	;SlaveTats.synchronize_tattoos(akRef) ; done separately
	RegisterModEvents()
EndFunction

Event AfterAssign(bool isSlave, bool newActor, bool playerOwned)
	; Presetup
	akRef = GetActorRef()
	mind  = (self as ReferenceAlias) as DOM_Mind
	SetActorBusy()
	Debug.Trace("DOM_Actor: "+akRef.getDisplayName()+": AfterAssign start isSlave="+isSlave+" newActor="+newActor+" playerOwned="+playerOwned+" tied="+akRef.IsInFaction(DOM01.DOMActionTied))
	; Setup
	ClearValues()
	is_restrained = true
	DOM01.DOMEquip.SetAllowGearFaction(akRef,false,isSlave) ; for now
	if akRef == DOM01.PlayerRef
		__behaviour = "do_nothing"
	elseif isSlave ; assign without running behaviour change code
		if !GetActorRef().IsInFaction(DOM01.DOMActionTied)
			Form cuffs = DOM01.DOMZaz.FindCuffs(akRef)
			if cuffs != None
				LogTrace("AfterAssign found cuffs in inventory="+cuffs.GetName())
				EquipCuffs(cuffs)
				if !IsCuffed()
					has_cuffs_back = true
				endif
			endif
			__behaviour = "flee_and_cower"
		else
			reset_on_behaviour_change = false
			int rank = GetActorRef().GetFactionRank(DOM01.DOMActionTied)
			if rank == 1
				if equipped_cuffs == None
					Form cuffs = DOM01.DOMZaz.FindCuffs(akRef)
					LogTrace("AfterAssign EquipCuffs equipped_cuffs="+equipped_cuffs+" cuffs="+cuffs)
					EquipCuffs(cuffs)
				endif
				__behaviour = "tied"
			elseif rank == 2
				__behaviour = "chained" ; same as tied but no escape possible
			elseif rank == 3
				__behaviour = "restrained"
			else
				nextTiedInFurniture = DOM01.DOM02.GetActiveFurniture()
				currentTiedInFurniture = nextTiedInFurniture
				__behaviour = "restrained_in_furniture"
			endif
		endif
	else 
		__behaviour = "do_nothing"
	endif
	SetProperties(isSlave,playerOwned)
	if newActor ; actor was re-enslaved, clear agreement with family.
		if akRef.IsInFaction(DOM01.DOMActorFamilyHistory)
			if akRef.GetFactionRank(DOM01.DOMActorFamilyHistory) >= 5 ; slave was supposed to be freed
				akRef.RemoveFromFaction(DOM01.DOMActorFamilyHistory)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMActorHasTatsMarks) 
		SetMarksFromStatus()
	endif
	if akRef.IsInFaction(DOM01.DOMActorHasTatsBrand) 
		SetBrandFromStatus()
	endif
	DOM01.DOMPAH.ClearFactions(akRef)
	if akRef.IsInFaction(DOM01.DOMActorInTransfer)
		akRef.RemoveFromFaction(DOM01.DOMActorInTransfer)
	endif
	prehit_health = akRef.GetBaseActorValue("Health") ; mind.GetBaseHealth() ; Maximum health
	;*ogTrace("AfterAssign() properties done behaviour="+behaviour)
	SetCrimeFaction()

	if akRef != DOM01.PlayerRef
		akRef.SetPlayerTeammate(false)
		akRef.StopCombatAlarm()
		ActorUtil.ClearPackageOverride(akRef)
		SetCombatPackageOverride()
	endif

	RegisterModEvents()
	SetActorReady()
	LogTrace("AfterAssign actor ready behaviour="+behaviour+" "+ self + " is " + akRef)
	if akRef != DOM01.PlayerRef
		if DOM01.friendToggle
			string the_event = "CheckFriendshipAfterAssign"
			RegisterForDOMEvent(None,the_event)
			DOM01.SendDOMEvent(None,the_event)
		endif
	elseif DOM01.friendPlayerToggle
		string the_event = "CheckFriendshipAfterAssign"
		RegisterForDOMEvent(None,the_event)
		DOM01.SendDOMEvent(None,the_event)
	endif
	LogTrace("AfterAssign done behaviour="+behaviour+" "+ self + " is " + akRef)
EndEvent

bool __is_initializing = false
bool __is_mind_initializing = false
bool Property is_initializing  Hidden
	bool Function Get()	
		if __is_mind_initializing
			;*ogTrace("__is_initializing="+__is_mind_initializing+" (mind)")
			return true
		endif
		;*ogTrace("__is_initializing="+__is_mind_initializing)
		return __is_initializing
	EndFunction
	Function Set(bool value)	
		__is_initializing = value
	EndFunction
EndProperty

Function SetActorReady()
	is_initializing = false
	;LogTrace("SetActorReady() is_initializing="+is_initializing+" "+__is_mind_initializing)
EndFunction

Function SetActorBusy()
	is_initializing = true
	SetMindBusy()
	;*ogTrace("SetActorBusy() is_initializing="+is_initializing+" "+__is_mind_initializing)
EndFunction

Function SetMindReady()
	__is_mind_initializing = false
	if mind.is_slave
		if DOM01.VampireCattleToggle && DOM01.DLC1ThrallFaction != None && akRef != None
			akRef.AddToFaction(DOM01.DLC1ThrallFaction)
		else
			akRef.RemoveFromFaction(DOM01.DLC1ThrallFaction)
		endif
		DOM01.DOMZaz.AddToZazSlaveFaction(akRef)
		DOM01.DOMZaz.RemoveFromZazSlaverFaction(akRef)
	else
		DOM01.DOMZaz.AddToZazSlaverFaction(akRef)
		DOM01.DOMZaz.RemoveFromZazSlaveFaction(akRef)
	endif
	;LogTrace("SetMindReady() is_initializing="+__is_initializing+" "+__is_mind_initializing)
EndFunction

Function SetMindBusy()
	__is_mind_initializing = true
	;*ogTrace("SetMindBusy() is_initializing="+__is_initializing+" "+__is_mind_initializing)
EndFunction

Function SetCombatPackageOverride()
	akRef.RemoveFromFaction(DOM01.DOMActionFighting)
	akRef.EvaluatePackage()
	if mind.is_slave
		akRef.AddToFaction(DOM01.dunPrisonerFaction)
	endif
	if akRef.IsPlayerTeammate()
		akRef.SetPlayerTeammate(false)
		CalmActorFast(akRef)
	endif
EndFunction

Function UnSetCombatPackageOverride()
	akRef.SetFactionRank(DOM01.DOMActionFighting,1)
	akRef.EvaluatePackage()
	akRef.RemoveFromFaction(DOM01.dunPrisonerFaction)
	if behaviour == "follow_player"
		akRef.SetPlayerTeammate()
	endif
EndFunction

Function SetGender()
	actorType = DOM01.GetActorType(akRef)
	actorRace = DOM01.GetActorRace(akRef)
	actorSex  = DOM01.GetActorGender(akRef,actorType)
	;*ogTrace("SetGender DOM gender actorType="+actorType+" actorSex="+actorSex)

	if actorSex == 0 ; Binary NPC
		DOM01.DOMSexlab.TreatAsMale(akRef)
		actorBeVerb     = "is"
		actorPronoun    = "he"
		actorObjective  = "him"
		actorPossessive = "his"
		actorHaveVerb   = "has"
	elseif actorSex == 1
		DOM01.DOMSexlab.TreatAsFemale(akRef)
		actorBeVerb     = "is"
		actorPronoun    = "she"
		actorObjective  = "her"
		actorPossessive = "her"
		actorHaveVerb   = "has"
	elseif actorSex == 2 ; Creatures
		DOM01.DOMSexlab.TreatAsMale(akRef)
		actorBeVerb     = "is"
		actorPronoun    = "he"
		actorObjective  = "him"
		actorPossessive = "his"
		actorHaveVerb   = "has"
	elseif actorSex == 3
		DOM01.DOMSexlab.TreatAsFemale(akRef)
		actorBeVerb     = "is"
		actorPronoun    = "she"
		actorObjective  = "her"
		actorPossessive = "her"
		actorHaveVerb   = "has"
	elseif actorSex == 4 || actorSex == 6 ; Non binary & other
		DOM01.DOMSexlab.TreatAsMale(akRef)
		actorBeVerb     = "are"
		actorPronoun    = "they"
		actorObjective  = "them"
		actorPossessive = "their"
		actorHaveVerb   = "have"
	else
		DOM01.DOMSexlab.TreatAsFemale(akRef)
		actorBeVerb     = "are"
		actorPronoun    = "they"
		actorObjective  = "them"
		actorPossessive = "their"
		actorHaveVerb   = "have"
	endif
EndFunction

string Function GetGenderbyString()
	if actorSex == 0 || actorSex == 2
		return "male"
	elseif actorSex == 1 || actorSex == 3
		return "female"
	elseif actorSex == 4
		return "treat as male"
	elseif actorSex == 5
		return "treat as female"
	endif
	return "other"
EndFunction

Function SetGenderByString(string str_gender)
	if str_gender == ""
		return
	endif
	actorType = DOM01.GetActorType(akRef)
	actorRace = DOM01.GetActorRace(akRef)
	actorSex  = DOM01.GetActorGenderByString(akRef,str_gender,actorType)
	;*ogTrace("SetGenderByString DOM gender actorType="+actorType+" actorSex="+actorSex)

	akRef.SetFactionRank(DOM01.DOMActorGender,actorSex)
	if actorSex == 0    ; Binary NPC
		DOM01.DOMSexlab.TreatAsMale(akRef)
		actorBeVerb     = "is"
		actorPronoun    = "he"
		actorObjective  = "him"
		actorPossessive = "his"
	elseif actorSex == 1
		DOM01.DOMSexlab.TreatAsFemale(akRef)
		actorBeVerb     = "is"
		actorPronoun    = "she"
		actorObjective  = "her"
		actorPossessive = "her"
	elseif actorSex == 2 ; Creatures
		DOM01.DOMSexlab.TreatAsMale(akRef)
		actorBeVerb     = "is"
		actorPronoun    = "he"
		actorObjective  = "him"
		actorPossessive = "his"
	elseif actorSex == 3
		DOM01.DOMSexlab.TreatAsFemale(akRef)
		actorBeVerb     = "is"
		actorPronoun    = "she"
		actorObjective  = "her"
		actorPossessive = "her"
	elseif actorSex == 4 || actorSex == 6 ; Non binary & other
		DOM01.DOMSexlab.TreatAsMale(akRef)
		actorBeVerb     = "are"
		actorPronoun    = "they"
		actorObjective  = "them"
		actorPossessive = "their"
	else
		DOM01.DOMSexlab.TreatAsFemale(akRef)
		actorBeVerb     = "are"
		actorPronoun    = "they"
		actorObjective  = "them"
		actorPossessive = "their"
	endif
EndFunction

Function SetProperties(bool isSlave, bool playerOwned)
	;*ogTrace("SetProperties() start isSlave="+isSlave+" behaviour="+behaviour)
	;*ogTrace("SetProperties() behaviour="+behaviour)
	;LogInfo("== Actor setup behaviour="+behaviour)
	akRef         = GetActorRef()
	PlayerRef     = Game.GetPlayer()
	mind          = (self as ReferenceAlias) as DOM_Mind
	name          = akRef.GetDisplayName()

	SetGender()
	setTitleByType(isSlave)
	if akRef != DOM01.PlayerRef
		akRef.IgnoreFriendlyHits(true)
		akRef.SetFactionOwner(DOM01.PlayerFaction)
		akRef.SetNotShowOnStealthMeter(true)
		akRef.AddToFaction(DOM01.DunPlayerAllyFaction)
		akRef.RemoveFromFaction(DOM01.MarriageExcludedFaction)
		akRef.RemoveFromFaction(DOM01.PlayerFollowerFaction)
		akRef.RemoveFromFaction(DOM01.CurrentFollowerFaction)
		akRef.RemoveFromFaction(DOM01.currentHireling)
		akRef.RemoveFromFaction(DOM01.PotentialFollowerFaction)
		akRef.RemoveFromFaction(DOM01.MQ201PartyGuestUnhappy)
		akRef.RemoveFromFaction(DOM01.DOMActorExcludedFaction)
		akRef.RemoveFromFaction(DOM01.DOMActorExcludedDialogue)
		DOM01.DOMPAH.CleanFactions(akRef)
		DOM01.DOMZaz.AddToZazGagAllowTalkFaction(akRef)
		akRef.AddToFaction(DOM01.BardAudienceExcludedFaction)
		akRef.AddToFaction(DOM01.WINeverFillAliasesFaction)
		DOM01.DOMPAH.SetCanNotBeCaptured(akRef)
	endif

	akRef.AddToFaction(DOM01.DOMActorFaction)
	if !playerOwned
		if isSlave
			if is_trainer
				akRef.SetFactionRank(DOM01.DOMNotPlayerSlaveFaction,2)
			else
				akRef.SetFactionRank(DOM01.DOMNotPlayerSlaveFaction,1)
			endif
			akRef.RemoveFromFaction(DOM01.DOMPlayerSlaveFaction)
			akRef.RemoveFromFaction(DOM01.DOMPlayerSlaverFaction)
			akRef.RemoveFromFaction(DOM01.DOMNotPlayerSlaverFaction)
			if DOM01.NoModestyKeyword != None
				PO3_SKSEFunctions.AddKeywordToRef(akRef,DOM01.NoModestyKeyword)
			endif
		else
			is_trainer = true
			akRef.AddToFaction(DOM01.DOMPlayerSlaverFaction)
			akRef.RemoveFromFaction(DOM01.DOMPlayerSlaveFaction)
			akRef.RemoveFromFaction(DOM01.DOMPlayerSlaverFaction)
			akRef.RemoveFromFaction(DOM01.DOMNotPlayerSlaveFaction)
			if DOM01.NoModestyKeyword != None
				PO3_SKSEFunctions.RemoveKeywordFromRef(akRef,DOM01.NoModestyKeyword)
			endif
		endif
	elseif isSlave
		if is_trainer
			akRef.SetFactionRank(DOM01.DOMPlayerSlaveFaction,2)
		else
			akRef.SetFactionRank(DOM01.DOMPlayerSlaveFaction,1)
		endif
		akRef.RemoveFromFaction(DOM01.DOMPlayerSlaverFaction)
		akRef.RemoveFromFaction(DOM01.DOMNotPlayerSlaveFaction)
		akRef.RemoveFromFaction(DOM01.DOMNotPlayerSlaverFaction)
		akRef.AddToFaction(DOM01.dunPrisonerFaction)
		if DOM01.NoModestyKeyword != None
			PO3_SKSEFunctions.AddKeywordToRef(akRef,DOM01.NoModestyKeyword)
		endif
	else
		is_trainer = true
		akRef.AddToFaction(DOM01.DOMPlayerSlaverFaction)
		akRef.RemoveFromFaction(DOM01.DOMPlayerSlaveFaction)
		akRef.RemoveFromFaction(DOM01.DOMNotPlayerSlaveFaction)
		akRef.RemoveFromFaction(DOM01.DOMNotPlayerSlaverFaction)
		if DOM01.NoModestyKeyword != None
			PO3_SKSEFunctions.RemoveKeywordFromRef(akRef,DOM01.NoModestyKeyword)
		endif
	endif

	UpdateLocation(akRef.GetCurrentLocation())
	SetDefaultSexlabVoice()
	
	is_inventory_open = false
	wait_for_equipment = false
	is_in_combat = akRef.IsInCombat()
EndFunction

Function ClearValues()
	if akRef != None
		name = akRef.GetDisplayName()
	else
		name = ""
	endif
	;*ogTrace("ClearValues()")
	;isInAttachedCell = true
	is_running_away = false
	canAnimate = true 
	__canAnimateLocal = true 
	__canAnimateSexlab = true 
	__canMove = false
	__canIdle = false
	__canIdleSexlab = true
	canFight = false
	__is_bounded      = false
	__is_restrained   = false
	__has_cuffs         = false ; the not offset ones
	__has_cuffs_front   = false
	__has_cuffs_back    = false
	__has_cuffs_boxtied = false
	__has_cuffs_crossed = false
	__has_yoke          = false
	__has_armbinder     = false
	__has_arms_device   = false
	is_in_combat    = false
	is_sitting      = false
	__is_moving     = false
	is_jailed       = false
	is_idling       = false
	last_pos_x = 0.0
	last_pos_y = 0.0
	on_update = false
	on_update_gametime = false
	lastWeatherType = 0
	wait_for_equipment = false
	is_inventory_open = false
	cuffs_material = 0
	equipped_cuffs = None
	is_exiting_tieup = false
	poseId = -1
	nextPoseId = -1
	prevPoseId = -1
	quietPose        = ""
	strugglePose     = ""
	enterPose        = ""
	exitPose         = ""
	prevQuietPose    = ""
	prevStrugglePose = ""
	prevEnterPose    = ""
	prevExitPose     = ""
	nextQuietPose    = ""
	nextStrugglePose = ""
	nextEnterPose    = ""
	nextExitPose     = ""
	currentTiedInFurniture = None
	nextTiedInFurniture    = None
	was_pose_registered = false
	timer_for_pose = 0.0
	DualAnimationMarker = None
	drunk_active = false
	bleedout_active = false
	alcohol_gift = false
	__has_jewelry = -1.0
	__has_gold = -1
	__hsh_home_cell = None
	myRival = None
	meRival = None
	int n = friendArray.length
	int i = 0
	while i < n
		_friend_array[i] = None
		i+=1
	endwhile
	n = friendXArray.length
	i = 0
	while i < n
		_friend_xarray[i] = 0.0
		i+=1
	endwhile
	n = friendTArray.length
	i = 0
	while i < n
		_friend_tarray[i] = 0
		i+=1
	endwhile
	n = actorFriendArray.length
	i = 0
	while i < n
		_actor_friend_array[i] = None
		i+=1
	endwhile
	n = actorFriendXArray.length
	i = 0
	while i < n
		_actor_friend_xarray[i] = 0.0
		i+=1
	endwhile
	n = actorFriendTArray.length
	i = 0
	while i < n
		_actor_friend_tarray[i] = 0
		i+=1
	endwhile
	marks_name = ""
	marks_file = ""
	marks_area = ""
	actor_trainer = None
	CampMarker = None
	is_trainer = false
	actor_trainee = None 
	actor_trainee2 = None 
	actor_trainee3 = None
	actor_trainee_whipped = None 
	is_following_player = false
	traineeCounter = GetTraineeCount()
	i = 0
	while i < traineeCounter
		_traineeArray[i] = None
		i+=1
	endwhile
	traineeCounter = 0
	is_attentive = false
	is_struggling = false
	PoseMarker = None
	PoseMarkerSave = None
	old_outfit = None
	tears_map0 = 0
	tears_map1 = 0
	tears_map2 = 0
	choke_map0 = 0
	choke_timer = 0
	choke_level = 0
	choke_level_prev = 0
	blush_map0 = 0
	drool_map0 = 0
	wait_activity = 0
	wait_activity_timer = 0
	the_bag_iam_in = None
	is_behaviour_pose = false
	is_behaviour_masturbate = false
	timer_for_punishing = 0
	cycle_for_punishing = 0
	timer_trainee_wait  = 0
	timer_for_work = 0
	is_pickingUpMess = false
	SexlabIsSilent = false
	SexlabUseLipSync = true
	SexlabVoice = None
	has_sex_with_player = false
	has_sex_alone = false
	has_sex_for_money = false
	was_sexlab_ended = false
	was_sexlab_started = false
	was_partner_ended = false
	ClearSexPartners()
	was_inventory_changed = true
	__equip_inventory_busy = false
	__equip_inventory_cancel = false
	correct_behaviour_busy = false
	interact_is_busy = false
	before_clear_is_busy = false
	restore_outfit_on_release = true
	is_resetting = false
	wet_level = 0.0
	dirty_level = 0.0
EndFunction

Function ClearFactions()
	akRef.RemoveFromFaction(DOM01.DOMActorFaction)
	akRef.RemoveFromFaction(DOM01.DOMPlayerSlaveFaction)
	akRef.RemoveFromFaction(DOM01.DOMPlayerSlaverFaction)
	akRef.RemoveFromFaction(DOM01.DOMNotPlayerSlaveFaction)
	akRef.RemoveFromFaction(DOM01.DOMNotPlayerSlaverFaction)
	akRef.RemoveFromFaction(DOM01.DOMSlaveManagerFaction)
	akRef.RemoveFromFaction(DOM01.DOMActorExcludedFaction)
	akRef.RemoveFromFaction(DOM01.DOMActorExcludedDialogue)
	;akRef.RemoveFromFaction(DOM01.DOMActorHasHSHCell)
	;akRef.RemoveFromFaction(DOM01.DOMActorIndexFaction)
	;akRef.RemoveFromFaction(DOM01.DOMAliasIndexFaction)
	akRef.RemoveFromFaction(DOM01.DOMBeingCaptured)
	DOM01.DOMZaz.RemoveFromZazSlaveFaction(akRef)
	DOM01.DOMZaz.RemoveFromZazSlaverFaction(akRef)
	DOM01.DOMZaz.RemoveFromZazGagAllowTalkFaction(akRef)
	DOM01.DOMPAH.ClearCanNotBeCaptured(akRef)
	akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
	akRef.RemoveFromFaction(DOM01.DOMFailedToFight)
	akRef.RemoveFromFaction(DOM01.DOMFailedToPose)
	akRef.RemoveFromFaction(DOM01.DOMActionWaiting)
	akRef.RemoveFromFaction(DOM01.DOMIsNaked)
	akRef.RemoveFromFaction(DOM01.DOMIsLeashed)
	akRef.RemoveFromFaction(DOM01.DOMHasArmor)
	akRef.RemoveFromFaction(DOM01.DOMHasBodyArmor)
	akRef.RemoveFromFaction(DOM01.DOMHasShield)
	akRef.RemoveFromFaction(DOM01.DOMHasWeapon)
	akRef.RemoveFromFaction(DOM01.DOMHasJewelry)
	;akRef.RemoveFromFaction(DOM01.DOMZaz.DOMHasBlindfold)
	;akRef.RemoveFromFaction(DOM01.DOMZaz.DOMHasMouthGag)
	;akRef.RemoveFromFaction(DOM01.DOMZaz.DOMHasPlugAnal)
	;akRef.RemoveFromFaction(DOM01.DOMZaz.DOMHasPlugVaginal)
	
	DOM01.DOMPAH.ClearFactions(akRef)
EndFunction

bool before_clear_is_busy = false
Event BeforeClear()
	LogTrace("BeforeClear "+akRef+" trainer="+actor_trainer)
	if akRef == None
		return
	endif
	before_clear_is_busy = true
	LogTrace("BeforeClear start akRef="+akRef+" IsDead="+akRef.IsDead())
	UnregisterForUpdate()
	UnregisterForUpdateGameTime()
	UnRegisterModEvents()

	if akRef.IsDead()
		if mind.promiseOath == "to be sacrificed"
			DOM01.TrainWitnesses(self, 0, "to be sacrificed", 10.0)
		endif
	endif
	LogTrace("BeforeClear 1 ClearFriends")
	ClearFriends()
	LogTrace("BeforeClear 2 ClearRivals")
	ClearRivals()
	LogTrace("BeforeClear 3 UnloadAllTrainees")
	UnloadAllTrainees()
	LogTrace("BeforeClear 4 SeparateFromTrainer")
	SeparateFromTrainer()

	LogTrace("BeforeClear 5 behaviour")
	if akRef != None && !akRef.IsDead()
		behaviour = "do_nothing"
	else
		reset_on_behaviour_change = false
		behaviour = "dead"
	endif
	Anim_DrunkReset()
	
	LogTrace("BeforeClear 6 target")
	is_leashed = false
	if target != None
		target.Clear()
	endif
	ClearFactions()
	LogTrace("BeforeClear 7 CloseDiary")
	
	DOM01.DOM04.CloseDiary(self)

	;*ogTrace("BeforeClear 8 IsDead="+akRef.IsDead())
	TryRemoveTears(10)
	TryRemoveBlush()
	TryRemoveDrool()
	TryRemoveAllChoke()
	TryRemoveAllSpank()
	TryRemoveAllSlapBoobs()
	TryRemoveAllSlap()
	TryRemoveBrand()
	TryRemoveMarks()
	
	;*ogTrace("BeforeClear 9 IsDead="+akRef.IsDead())
	DOM01.DOMEquip.RestoreOutfit(akRef,actorType,old_outfit,restore_outfit_on_release)
	akRef.RemoveFromFaction(DOM01.BardAudienceExcludedFaction)
	; Clear ref from all aliases
	UnsetAsVictim()
	DOM01.ClearAliases(akRef)
	;*ogTrace("BeforeClear 10 IsDead="+akRef.IsDead())
	if akRef != None && !akRef.IsDead()
		canMove = true
		canIdle = true
	else
		__canMove = false  ; use __canMove, and never set canMove after death as it will revive the actor even if set to false!
		__canIdle = false
	endif
	behaviour_is_busy = false
	LogTrace("BeforeClear end behaviour="+behaviour)
	name = name+" CLEARED"
	mind.SetDisplayName(name)
EndEvent

Function DoClear()
	LogTrace("DoClear start "+akRef)
	mind.BeforeClear()
	BeforeClear()
	mind.akRef = None
	akRef = None
	DOM01.ClearSelectedActor(self)
	Clear()
	LogTrace("DoClear end "+akRef)
EndFunction

Function SetPlayerPotentialFollower()
	; Add to player's ally and potential followers
	akRef.AddToFaction(DOM01.DunPlayerAllyFaction)
	akRef.AddToFaction(DOM01.PotentialFollowerFaction)
	akRef.SetFactionRank(DOM01.CurrentFollowerFaction, -1)
EndFunction

Function ReleaseOrDelete(bool is_freed = true) ; Set free or delete to be called before BeforeClear()
	LogTrace("ReleaseOrDelete")
	ExitCuffed(None)
	behaviour = "do_nothing"
	CalmActorFast(akRef)
	
	; Slave is not freed
	if mind.is_slave && !is_freed
		mind.SetMoodReleased(is_freed) 
		DOM01.ReleaseAlias(self)
		return
	endif
	
	; Slave was freed or slaver
	if mind.IsDevoted()
		mind.SetMoodReleased(is_freed) 
		DOM01.DOM04.NotifyRelease(self)
		SendExternalEventSSB("Released",mind.mood,true)
		SetPlayerPotentialFollower()
		;LogTrace("ReleaseOrDelete HAPPY")
		if DOM01.hugWhenFreedToggle
			Anim_GetPlayerHug()
		endif
	elseif mind.IsBrokenToObey() || mind.IsOkayWithPlayer()
		mind.SetMoodReleased(is_freed) 
		SendExternalEventSSB("Released",mind.mood,true)
		DOM01.DOM04.NotifyRelease(self)
		;LogTrace("ReleaseOrDelete OK="+mind.IsOkayWithPlayer())
		if mind.IsOkayWithPlayer()
			SetPlayerPotentialFollower()
			if DOM01.hugWhenFreedToggle
				Anim_GetPlayerHug()
			endif
		endif
	else
		;LogTrace("ReleaseOrDelete NOT OK")
		mind.SetMoodReleased(is_freed) 
		DOM01.DOM04.NotifyRelease(self)
		SendExternalEventSSB("Released",mind.mood,false)
		ActorBase akBase =  akRef.GetLeveledActorBase() ; akRef.GetBaseObject() as ActorBase ; this last one is supposed to be faster than GetActorBase()
		bool delete_slave
		if akBase.IsUnique()
			delete_slave = false
		elseif akRef.IsInFaction(DOM01.DOMActorInTransfer)
			delete_slave = false
		elseif akRef.GetFactionRank(DOM01.DOMTrainSubmission) < DOM01.deleteActorThreshold
			delete_slave = false
		else
			delete_slave = true
		endif
		if delete_slave
			;LogTrace("Releasing 0 submission slave (preparing to delete) "+akRef.getName())
			akRef.RemoveFromAllFactions()
			akRef.Disable()
			;akRef.DeleteWhenAble()
			akRef.SetCriticalStage(4) ; use desintegrate end stage instead of Delete() to avoid problems with leveled lists!
		endif
	endif	
	DOM01.ReleaseAlias(self)
EndFunction

Function setDisplayName(string newName)
	name = newName
	LogTrace("SetDisplayName name="+newName+" akRef="+akRef)
	if mind != None
		mind.SetDisplayName(name)
	endif
	if akRef != None
		akRef.SetDisplayName(name,true)
		if akRef.GetActorBase().IsUnique()
			akRef.GetBaseObject().SetName(name)
		endif
	endif
EndFunction

String Function getName()
	return name
EndFunction

Function setTitle(string newTitle = "")
	if newTitle != ""
		int l = StringUtil.GetLength(newTitle)
		l -= 1
		if StringUtil.GetNthChar(newTitle,l) == " "
			title = newTitle
		else
			title = newTitle+" "
		endif
		return
	endif
	setTitleByType(mind.is_slave)
EndFunction

Function setTitleByType(bool isSlave)
	if isSlave
		if is_trainer
			if actorSex == 0
				title = "Henchman "
			elseif actorSex == 1
				title = "Henchwench "
			else
				title = "Henchperson "
			endif
		else
			title = ""
		endif
	elseif actorSex == 0 || actorSex == 2
		title = "Master "
	elseif actorSex == 1 || actorSex == 3
		title = "Mistress "
	elseif (actorSex %2) == 0
		title = "Mixter "
	else
		title = "Mixtress "
	endif
EndFunction

String Function getTitle()
	return title
EndFunction

Function SetInitialBehaviour(string last_anim)
	LogTrace("SetInitialBehaviour behaviour="+__behaviour+" anim="+last_anim)
	if last_anim != "" ; akRef.IsInFaction(DOM01.DOMMoodJustCaptured) ; A captured slave
		LogTrace("SetInitialBehaviour defeated just captured and do nothing")
		reset_on_behaviour_change = false
		quietPose = last_anim
		strugglePose = DOM01.DOM_Anim.GetTieupStrugglePose(quietPose)
		__behaviour = "do_nothing"
		behaviour = "flee_and_cower"
	elseif !SetBehaviourByFaction()
		LogTrace("SetInitialBehaviour behaviour="+__behaviour)
		if mind.is_slave
			behaviour = __behaviour
		else
			behaviour = "follow_player"
		endif
	endif
EndFunction

Function InformIsCaptured()
	;LogTrace("InformIsCaptured(): old mood="+mind.mood+" in faction="+akRef.IsInFaction(DOM01.DOMMoodJustCaptured))
	mind.SetObedientTimer(3)
	if behaviour == "flee_and_cower"
		Anim_BleedOutStop()
	endif
	mind.ResetMood()
	LogTrace("InformIsCaptured Anim_IdleReset")
	;Anim_IdleReset()
	; New capture apply player predator bonus
	int history_rank = akRef.GetFactionRank(DOM01.DOMHistoryFaction)
	if history_rank != 1 && history_rank != 3 ; never been player's slave
		mind.ApplyPredatorBonusAtCapture()
	endif
	if history_rank < 0
		akRef.SetFactionRank(DOM01.DOMHistoryFaction,0)
	endif
	DOM01.DOM04.NotifyIsCaptured(self)
	SendExternalEventSSB("Captured",mind.mood,mind.is_player_slave)
	;LogTrace("InformIsCaptured(): new mood="+mind.mood+" in faction="+akRef.IsInFaction(DOM01.DOMMoodJustCaptured))
EndFunction

Function InformIsCapturedAndTieUp()
	InformIsCaptured()
	EnterTieUp(PlayerRef)
	EnterGagged(PlayerRef)
EndFunction

Function InformIsCapturedAndWait()
	InformIsCaptured()
	EnterWait()
EndFunction

Function InformIsCapturedAndFollow()
	InformIsCaptured()
	EnterFollowPlayer()
EndFunction

bool Function SetBehaviourByFaction()
	bool is_in_faction = false
	if akRef.IsInFaction(DOM01.DOMActionFleeing)
		if akRef.GetFactionRank(DOM01.DOMActionFleeing) == 3
			behaviour = "running_away"
			is_in_faction = true
		else
			behaviour = "flee_and_cower"
			is_in_faction = true
		endif
	elseif akRef.IsInFaction(DOM01.DOMActionWaiting)
		if akRef.GetFactionRank(DOM01.DOMActionWaiting) == 1
			behaviour = "wait"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionWaiting) == 2 || akRef.GetFactionRank(DOM01.DOMActionWaiting) == 100
			behaviour = "wait_sandbox"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionWaiting) == 3
			behaviour = "on_duty"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionWaiting) == 4
			if behaviour == "do_nothing"
				is_in_faction = true
			endif
			behaviour = "do_nothing"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionWaiting) == 5
			behaviour = "wait_in_bag"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionWaiting) == 6
			behaviour = "wait_at_leash_point"
			is_in_faction = true
		else ; if akRef.GetFactionRank(DOM01.DOMActionWaiting) == 7
			behaviour = "showering"
			is_in_faction = true
		endif
	elseif akRef.IsInFaction(DOM01.DOMActionFollowing)
		if akRef.GetFactionRank(DOM01.DOMActionFollowing) == 1
			behaviour = "follow_player"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionFollowing) == 2
			behaviour = "follow_trainer"
			is_in_faction = true
		else ; if akRef.GetFactionRank(DOM01.DOMActionFollowing) == 3
			behaviour = "follow_target"
			is_in_faction = true
		endif
	elseif akRef.IsInFaction(DOM01.DOMActionPosing)
		behaviour = "pose"
			is_in_faction = true
	elseif akRef.IsInFaction(DOM01.DOMActionMasturbating)
		behaviour = "masturbate"
			is_in_faction = true
	elseif akRef.IsInFaction(DOM01.DOMActionTied)
		if akRef.GetFactionRank(DOM01.DOMActionTied) == 1
			if equipped_cuffs == None
				Form cuffs = DOM01.DOMZaz.FindCuffs(akRef)
				LogEquip("SetBehaviourByFaction EquipCuffs equipped_cuffs="+equipped_cuffs+" cuffs="+cuffs)
				EquipCuffs(cuffs)
			endif
			behaviour = "tied"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionTied) == 2
			behaviour = "chained" ; same as tied but no escape possible
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionTied) == 3
			behaviour = "restrained"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionTied) == 4
			behaviour = "restrained_in_furniture"
			is_in_faction = true
		else
			behaviour = "on_duty_restrained"
			is_in_faction = true
		endif
	elseif akRef.IsInFaction(DOM01.DOMActionPunishing)
		if akRef.GetFactionRank(DOM01.DOMActionPunishing) == 1
			behaviour = "punishing"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionPunishing) == 2
			behaviour = "fetch_trainee"
			is_in_faction = true
		else ; if akRef.GetFactionRank(DOM01.DOMActionPunishing) == 3
			behaviour = "punish_trainee"
			is_in_faction = true
		endif
	elseif akRef.IsInFaction(DOM01.DOMActionTraining)
		if akRef.GetFactionRank(DOM01.DOMActionTraining) == 1
			behaviour = "sextraining"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionTraining) == 2
			behaviour = "fetch_sextrainee"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionTraining) == 3
			behaviour = "train_trainee"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionTraining) == 11
			behaviour = "orgytraining"
			is_in_faction = true
		elseif akRef.GetFactionRank(DOM01.DOMActionTraining) == 12
			behaviour = "fetch_orgytrainees"
			is_in_faction = true
		else ; if akRef.GetFactionRank(DOM01.DOMActionTraining) == 13
			behaviour = "orgy_trainees"
			is_in_faction = true
		endif
	elseif akRef.IsInFaction(DOM01.DOMActionSweeping)
		behaviour = "clean_house"
			is_in_faction = true
	elseif akRef.IsInFaction(DOM01.DOMActionGuard)
		behaviour = "guard"
			is_in_faction = true
	elseif akRef.IsInFaction(DOM01.DOMActionTravel)
		behaviour = "travel"
			is_in_faction = true
	elseif behaviour != "do_nothing"
		behaviour = "do_nothing"
			is_in_faction = true
	endif
	if is_in_faction
		akRef.EvaluatePackage()
	endif
	LogTrace("SetBehaviourByFaction is_in_faction="+is_in_faction+" behaviour="+behaviour)
	return is_in_faction
EndFunction

; ### Events ###

bool on_update = false
Event OnUpdate()
	;LogTrace("==================== OnUpdate Name="+name+"  Init="+is_initializing+" Cleared="+before_clear_is_busy+" OnUpdate="+on_update+" Busy="+behaviour_is_busy)
	if is_initializing
		LogTrace("==================== OnUpdate INACTIVE Init="+is_initializing)
		RegisterForSingleUpdate(1.0)
		return
	endif
	if before_clear_is_busy || akRef == None
		LogTrace("==================== OnUpdate INACTIVE Init="+is_initializing+" Cleared="+before_clear_is_busy+" OnUpdate="+on_update+" Busy="+behaviour_is_busy+" akRef="+akRef)
		return
	endif
	if on_update
		;*ogTrace("==================== OnUpdate FAILED OnUpdate="+on_update+" busy="+behaviour_is_busy)
		return
	endif
	if behaviour_is_busy
		RegisterForSingleUpdate(1.0)
		return
	endif
	on_update = true
	if is_dialogue_blocked_for > 0
		is_dialogue_blocked_for -= 1
	endif
	if is_weather_dialogue_blocked_for > 0
		is_weather_dialogue_blocked_for -= 1
	endif
	UpdateIsMovingOnTick()
	HandleRegenOnUpdate()
	HandleWeatherOnUpdate()
	HandleSlappedOnUpdate()
	TryRemoveChoke()
	TryRemoveSpank()
	TryRemoveSlapBoobs()
	OnBehaviourUpdate()
	HandleTopicAndIdleOnUpdate()
	on_update = false
	RegisterForSingleUpdate(DOM01.actorUpdateTimer) ; in seconds 3 x 20 time scale = 1 minute RL ; Was 5 in PAH
EndEvent

bool on_update_gametime = false
Event OnUpdateGameTime()
	;LogTrace("******************** OnUpdateGameTime Name="+name+" Cleared="+before_clear_is_busy+" OnUpdateGameTime="+on_update_gametime+" Busy="+behaviour_is_busy)
	if is_initializing
		LogTrace("******************** OnUpdateGameTime INACTIVE Init="+is_initializing)
		RegisterForSingleUpdate(1.0)
		return
	endif
	if before_clear_is_busy || akRef == None
		LogTrace("******************** OnUpdateGameTime INACTIVE Init="+is_initializing+" Cleared="+before_clear_is_busy+" OnUpdateGameTime="+on_update_gametime+" Busy="+behaviour_is_busy+" akRef="+akRef)
		return
	endif
	if on_update_gametime
		;*ogTrace("******************** OnUpdateGameTime FAILED OnUpdateGameTime="+on_update_gametime+" busy="+behaviour_is_busy)
		return
	endif
	if behaviour_is_busy
		;*ogTrace("******************** OnUpdateGameTime FAILED OnUpdateGameTime="+on_update_gametime+" busy="+behaviour_is_busy)
		RegisterForSingleUpdateGameTime(0.05) ; 1.0 = 1 hour Skyrim = 3 minutes real time and 0.05 = 3 minutes Skyrim = 9 seconds RT
		return
	endif
	on_update_gametime = true
	OnBehaviourUpdateGameTime()
	on_update_gametime = false
	HandleDirtOnUpdate()
	float mod = mind.MOD_Modesty
	float x = RandomFloat(0.04, 0.1)+(mind.MOD_Modesty)*0.01 ; mod is 0.0 to 5.0 => 0.04 to 0.15 hour game time = 7 to 27 seconds
	RegisterForSingleUpdateGameTime(x) ; 0.05 to 0.1 = 9 to 18 seconds x 20 = 3 to 6 minutes RL ; Was 10 to 20 Skyrim seconds in PAH
	;*ogTrace("OnUpdateGameTime next update in "+x+" hours game time = "+(x*180.0)+" real seconds modesty="+mind.MOD_Modesty)
EndEvent

bool Function HitIsHostile(Form akSource, Projectile akProjectile)
	if !PlayerRef.IsInCombat()
		return false
	endif
	if akSource == None
		if akProjectile != None
			return true
		endif
		return false
	endif
	if DOM01.DOMZaz.IsWeaponPunishment(akSource)
		return false
	endif

	Weapon akWeapon = akSource as Weapon
	if akWeapon != None
		if 	akWeapon.GetBaseDamage() > 2
			return true
		endif
	endif

	Spell akSpell = akSource as Spell
	if akSpell == None
		return true
	endif
	
	int neffect = akSpell.GetNumEffects()
	int i = 0
	While i < neffect
		MagicEffect meff = akSpell.GetNthEffectMagicEffect(i)
		if meff.IsEffectFlagSet(1) ; Hostile flag = 0x00000001
			return true
		endif
		i += 1
	EndWhile
	
	return false
EndFunction

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	;*ogTrace("OnHit agg="+akAggressor+" src="+akSource+" prj="+akProjectile)
	if is_initializing
		return
	endif
	if mind == None
		return
	endif
	if !mind.is_slave && !mind.whipping_active
		return ; not a slave and no punishment going on
	endif
	Actor akAbuser = akAggressor as Actor
	if akAbuser == None 
		return
	endif

	if akAbuser != PlayerRef
		; if not a DOM_Actor or a follower
		if !akAbuser.IsInFaction(DOM01.DOMActorFaction) && !akAbuser.IsPlayerTeammate()
			return
		endif
	endif

	if akSource != None
		;*ogTrace("akSource.HasKeyword(DOM01.MagicDamageWater)="+akSource.HasKeyword(DOM01.MagicDamageWater))
		if DOM01.hasWaterKeyword(akSource)
			; cleaning
			if !is_showering
				DoShowerHose(akAbuser)
			endif
			return
		endif
	elseif akProjectile != None 
		;*ogTrace("akProjectile.HasKeyword(DOM01.MagicDamageWater)="+akProjectile.HasKeyword(DOM01.MagicDamageWater))
		if DOM01.hasWaterKeyword(akProjectile)
			; cleaning
			if !is_showering
				DoShowerHose(akAbuser)
			endif
			return
		endif
	endif
	
	float health_damage = HandleHealthOnHit(akSource)
	if health_damage <= 0.0
		return
	endif
	OnHitUpdate()
	
	;*ogTrace("OnHit: damage="+health_damage)
	bool isAlarmed = HandleAlarmOnHit()

	if mind.IsDevoted()
		if is_shamed
			mind.IncreaseArousal(0.2,mind.MOD_Discipline)
		endif
	endif
	
	; aggressor is player
	if (akAbuser == PlayerRef)
		if !isAlarmed && !HitIsHostile(akSource,akProjectile)
			SetAsVictim(1)
			; do not register punishment if in combat
			if mind.whipping_by_trainer
				mind.whipping_by_trainer = false
			endif
			HandlePunishmentOnHit(PlayerRef,akSource)
			;*ogTrace("CorrectBehaviour Onhit Player")
			CorrectBehaviour(akAbuser, mind.whipping_reason, true)
		endif
	else ; aggressor is player team mate or DOM_Actor
		if akRef.IsHostileToActor(akAbuser)
			;akRef.StopCombat()
			akRef.StopCombatAlarm()
		endif
		akRef.IgnoreFriendlyHits(true)
		if !isAlarmed && DOM01.IsAllowedToPunish(akAbuser)
			HandlePunishmentOnHit(akAbuser,akSource)
			;*ogTrace("CorrectBehaviour Onhit NPC")
			CorrectBehaviour(akAbuser, mind.whipping_reason, true)
		endif
	endif
	
	CorrectStruggle()
	;*ogTrace("OnHit: done")
EndEvent

Event OnActivate(ObjectReference akActionRef)
	LogTrace("OnActivate akActionRef="+akActionRef)
	;LogTrace("Activated ispressed="+Input.IsKeyPressed(DOM01.DOMKeys.modifierKey))
	if akActionRef == PlayerRef; && !Input.IsKeyPressed(DOM01.DOMKeys.modifierKey)
		HandleDialogueOnActivate()
		;return
 	endif
	; Else grab and move bones
EndEvent

Event OnGrab()
  LogTrace("Why you poking me again?")
endEvent

Event OnDeath(Actor akKiller)
	SendNotification(name+" "+actorBeVerb+" dead")
	;LogTrace("OnDeath()")
	if akRef != None
		reset_on_behaviour_change = false
		DOM01.ReleaseAlias(self)
	endif
EndEvent

Event OnVampirismStateChanged(bool abIsVampire)
	if abIsVampire
		SendNotification(name+" "+actorBeVerb+" now a vampire")
	else
		SendNotification(name+" was cured from vampirism")
	endif
EndEvent

Event OnVampireFeed(Actor akTarget)
	if akTarget == None
		return
	endif
	mind.TrainForVampireFeed(akTarget)
EndEvent

ReferenceAlias __hsh_home_cell
ReferenceAlias Property hsh_home_cell Hidden
	ReferenceAlias Function get()
		LogTrace("hsh_home_cell="+__hsh_home_cell)
		return __hsh_home_cell 
	EndFunction
	Function set(ReferenceAlias value)
		LogTrace("hsh_home_cell="+value)
		__hsh_home_cell = value
		if __hsh_home_cell != None
			SetBoolFaction(akRef, DOM01.DOMActorHasHSHCell, true)
			phhshPortableCellScript the_cell = __hsh_home_cell as phhshPortableCellScript
			if the_cell != None
				string cell_name = the_cell.GetNameCellRef()
				if the_cell.IsInDoorCell()
					SendNotification(name+" home was "+cell_name)
				else
					SendNotification(name+" camp was "+cell_name)
				endif
			endif
		else
			SetBoolFaction(akRef, DOM01.DOMActorHasHSHCell, false)
		endif
	EndFunction
EndProperty

Location Property current_location = None Auto Hidden
Function UpdateLocation(Location akNewLoc)
	if akNewLoc == current_location
		return
	endif
	if akNewLoc == DOM01.DOMPlayerAlias.player_current_location
		if DOM01.DOMPlayerAlias.player_location_type == 1
			;LogTrace("UpdateLocation in dungeon")
			is_in_dungeon = true
			is_in_city = false
		elseif DOM01.DOMPlayerAlias.player_location_type == 2
			;LogTrace("UpdateLocation in city")
			is_in_dungeon = false
			is_in_city = true
		else
			;LogTrace("UpdateLocation in wilderness")
			is_in_dungeon = false
			is_in_city = false
		endif
	elseif actor_trainer != None && actor_trainer.current_location == akNewLoc
		is_in_dungeon = actor_trainer.is_in_dungeon
		is_in_city = actor_trainer.is_in_city
	else
		is_in_dungeon = DOM01.IsInDungeon(akNewLoc)
		is_in_city    = DOM01.IsInCity(akNewLoc)
	endif
	current_location = akNewLoc
EndFunction

Event OnCellLoad()
	;LogTrace("OnCellLoad cellEquipToggle="+DOM01.DOMEquip.cellEquipToggle)
	if DOM01.DOMEquip.cellEquipToggle
		;LogTrace("OnCellLoad check equipment")
		was_inventory_changed = true
		EquipInventoryNowNoApply(false) ; no anim, using mind settings (should wear clothes, ...)
	endif
	;UpdateLocation(akRef.GetCurrentLocation())
	OnBehaviourCellLoad()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	;LogTrace("OnLocationChange locationEquipToggle="+DOM01.DOMEquip.locationEquipToggle)
	if DOM01.DOMEquip.locationEquipToggle
		;LogTrace("OnLocationChange check equipment")
		was_inventory_changed = true
		EquipInventoryNowNoApply(false) ; no anim, using mind settings (should wear clothes, ...)
	endif
	if mind == None
		return
	endif
	UpdateLocation(akNewLoc)
	if is_shamed
		if is_in_city
			mind.IncreaseArousal(20.0,mind.MOD_Naivety)
		elseif is_in_dungeon
			mind.IncreaseArousal(10.0,mind.MOD_Sociability)
		endif
	endif
	OnBehaviourLocationChange(akOldLoc,akNewLoc)
EndEvent

Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
EndEvent

Function RegisterModEvents()
	; Just make sure to not create duplicates
	UnregisterModEvents()
	;*ogTrace("RegisterModEvents")
	RegisterForWhistleEvents()
EndFunction

Function UnregisterModEvents()
	UnRegisterForEquipInventory()
	UnregisterForWhistleEvents()
EndFunction

Function UnRegisterForEquipInventory()
	string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	UnregisterForModEvent("DOM" + formid + "_EquipInventory")
	UnregisterForModEvent("DOM" + formid + "_ApplyEquipmentEffects")
	UnregisterForModEvent("DOM" + formid + "_SexlabEquipInventory")
EndFunction

Function RegisterForWhistleEvents()
	string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	RegisterForModEvent("DOM" + formid + "_Whistle_follow", "DOMWhistle")
	RegisterForModEvent("DOM" + formid + "_Whistle_wait", "DOMWhistle")
EndFunction

Function UnregisterForWhistleEvents()
	string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	UnregisterForModEvent("DOM" + formid + "_Whistle_follow")
	UnregisterForModEvent("DOM" + formid + "_Whistle_wait")
EndFunction

Function RegisterForAnimEvent()
	RegisterForAnimationEvent(akRef, "staggerStop")
	RegisterForAnimationEvent(akRef, "GetUpEnd")
EndFunction

Function UnregisterForAnimEvent()
	UnregisterForAnimationEvent(akRef, "staggerStop")
	UnregisterForAnimationEvent(akRef, "GetUpEnd")
EndFunction

bool Property sendExternalEventToggle = false Auto Hidden
Function SetSendExternalEvents(bool status)
	sendExternalEventToggle = status
EndFunction

bool Property sendExternalEventToggleExt = false Auto Hidden
Function SetSendExternalEventsExt(bool status)
	sendExternalEventToggleExt = status
EndFunction

bool Property sendExternalEventToggleExt2 = false Auto Hidden
Function SetSendExternalEventsExt2(bool status)
	sendExternalEventToggleExt2 = status
EndFunction

bool Property sendExternalEventToggleExt3 = false Auto Hidden
Function SetSendExternalEventsExt3(bool status)
	sendExternalEventToggleExt3 = status
EndFunction

Function SendExternalEventSSSBS(string the_event, string type, string reason, bool flag, string txt)
	DOM01.SendDOMExternalEventSSSBS(akRef,the_event,type,reason,flag,txt)
	if !sendExternalEventToggleExt3 ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSSSBS Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
 		ModEvent.PushString(handle, type)
 		ModEvent.PushString(handle, reason)
		ModEvent.PushBool(handle, flag)
 		ModEvent.PushString(handle, txt)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSSSBS Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSSBS(string the_event, string type, bool flag, string txt)
	DOM01.SendDOMExternalEventSSBS(akRef,the_event,type,flag,txt)
	if !sendExternalEventToggleExt3 ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSSBS Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
 		ModEvent.PushString(handle, type)
 		ModEvent.PushBool(handle, flag)
 		ModEvent.PushString(handle, txt)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSSBS Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSFB(string the_event, float value, bool flag)
	DOM01.SendDOMExternalEventSFB(akRef,the_event,value,flag)
	if !sendExternalEventToggleExt2 ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSFB Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushFloat(handle, value)
 		ModEvent.PushBool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSFB Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSSFB(string the_event, string type, float value, bool flag)
	DOM01.SendDOMExternalEventSSFB(akRef,the_event,type,value,flag)
	if !sendExternalEventToggleExt2 ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSSFB Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushString(handle, type)
		ModEvent.PushFloat(handle, value)
 		ModEvent.PushBool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSSFB Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSSB(string the_event, string type, bool flag)
	DOM01.SendDOMExternalEventSSB(akRef,the_event,type,flag)
	if !sendExternalEventToggleExt2 ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSSB Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushString(handle, type)
 		ModEvent.PushBool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSSB Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSSSB(string the_event, string type, string reason, bool flag)
	DOM01.SendDOMExternalEventSSSB(akRef,the_event,type,reason,flag)
	if !sendExternalEventToggleExt2 ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSSSB Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushString(handle, type)
		ModEvent.PushString(handle, reason)
 		ModEvent.PushBool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSSSB Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSSS(string the_event, string type, string reason)
	DOM01.SendDOMExternalEventSSS(akRef,the_event,type,reason)
	if !sendExternalEventToggle ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSSS Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushString(handle, type)
		ModEvent.PushString(handle, reason)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSSS Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSSF(string the_event, string type, float value)
	DOM01.SendDOMExternalEventSSF(akRef,the_event,type,value)
	if !sendExternalEventToggleExt ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSSF Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushString(handle, type)
		ModEvent.PushFloat(handle, value)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSSF Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSS(string the_event, string type)
	DOM01.SendDOMExternalEventSS(akRef,the_event,type)
	if !sendExternalEventToggle ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSS Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushString(handle, type)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSS Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSI(string the_event, int value)
	DOM01.SendDOMExternalEventSI(akRef,the_event,value)
	if !sendExternalEventToggleExt ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSI Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushInt(handle, value)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSI Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventSSI(string the_event, string type, int value)
	DOM01.SendDOMExternalEventSSI(akRef,the_event,type,value)
	if !sendExternalEventToggleExt ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventSSI Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
		ModEvent.PushString(handle, type)
 		ModEvent.PushInt(handle, value)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventSSI Registering event FAILED "+eventName)
    endif
EndFunction

Function SendExternalEventS(string the_event)
	DOM01.SendDOMExternalEventS(akRef,the_event)
	if !sendExternalEventToggle ; send events for this actor
		return
	endif
	string formid = ""
	if akRef != None
		formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	endif
	string eventName = "DOMOn"+the_event+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;*ogTrace("SendExternalEventS Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akRef)
        ModEvent.Send(handle)
	else
		LogTrace("SendExternalEventS Registering event FAILED "+eventName)
    endif
EndFunction

Function RegisterForOrder(Form sender, string the_event, string type, bool flag=false)
	;*ogTrace("RegisterForOrder event="+the_event)
	if !DOM01.sendDOMOrders
		DoOrder(sender,the_event,type,flag)
		return
	endif
	RegisterForDOMEvent(sender,the_event)
EndFunction

Function RegisterForDOMEvent(Form sender, string the_event)
	string formid = ""
	if sender != None
		formid = DOM_Util.ConvertIDToHex(sender.GetFormID())
	endif
	string eventName = "DOMOnEvent"+the_event+formid
	string callbackName = "OnOrder"+the_event
	UnregisterForModEvent(eventName) 
	;*ogTrace("RegisterForDOMEvent Register event "+eventName+" callback="+callbackName)
	RegisterForModEvent(eventName, callbackName)
EndFunction

Function UnRegisterForDOMEvent(Form sender, string the_event)
	string formid = ""
	if sender != None
		formid = DOM_Util.ConvertIDToHex(sender.GetFormID())
	endif
	string eventName = "DOMOnEvent"+the_event+formid
	UnregisterForModEvent(eventName)
EndFunction

Function SendOrderAnimate(string the_pose, bool the_flag)
	;*ogTrace("SendOrderAnimate pose="+the_pose+" flag="+the_flag)
	string the_order = "Animate"
	RegisterForOrder(None,the_order,the_pose,the_flag)
	DOM01.SendDOMOrder(None,the_order,the_pose,the_flag)
EndFunction

Function SendOrderAnimateStrip()
	;*ogTrace("SendOrderAnimateStrip")
	string the_order = "AnimateStrip"
	RegisterForOrder(None,the_order,"",true)
	DOM01.SendDOMOrder(None,the_order,"",true)
EndFunction

Function SendOrderAnimateUndress(Actor akAbuser)
	;*ogTrace("SendOrderAnimateUndress")
	string the_order = "AnimateUndress"
	RegisterForOrder(akAbuser,the_order,"",true)
	DOM01.SendDOMOrder(akAbuser,the_order,"",true)
EndFunction

Function SendOrderAnimateDressUp()
	;*ogTrace("SendOrderAnimateDressUp")
	string the_order = "AnimateDressUp"
	RegisterForOrder(None,the_order,"",true)
	DOM01.SendDOMOrder(None,the_order,"",true)
EndFunction

Function SendOrderEquipInventoryNoApply(bool do_anim)
	if mind.is_player_actor
		return
	endif
	LogEquip("SendOrderEquipInventoryNoApply do_anim="+do_anim)
	string the_order = "EquipInventoryNoApply"
	RegisterForOrder(None,the_order,"",do_anim)
	DOM01.SendDOMOrder(None,the_order,"",do_anim)
EndFunction

Function SendOrderEquipInventoryQuiet(bool do_anim)
	if mind.is_player_actor
		return
	endif
	LogEquip("SendOrderEquipInventoryQuiet do_anim="+do_anim)
	string the_order = "EquipInventoryQuiet"
	RegisterForOrder(None,the_order,"",do_anim)
	DOM01.SendDOMOrder(None,the_order,"",do_anim)
EndFunction

Function SendOrderEquipInventoryForced(string msg, bool do_anim)
	if mind.is_player_actor
		return
	endif
	LogEquip("SendOrderEquipInventoryForced do_anim="+do_anim+" msg="+msg)
	string the_order = "EquipInventoryForced"
	RegisterForOrder(None,the_order,msg,do_anim)
	DOM01.SendDOMOrder(None,the_order,msg,do_anim)
EndFunction

Function SendOrderEquipInventory(bool do_anim)
	if mind.is_player_actor
		return
	endif
	LogEquip("SendOrderEquipInventory do_anim="+do_anim+" wait="+wait_for_equipment+" open="+is_inventory_open)
	if is_inventory_open || wait_for_equipment
		return
	endif
	string the_order = "EquipInventory"
	RegisterForOrder(None,the_order,"",do_anim)
	DOM01.SendDOMOrder(None,the_order,"",do_anim)
EndFunction

Function SendOrderApplyEquipmentEffects()
	LogEquip("SendOrderApplyEquipmentEffects")
	string the_order = "ApplyEquipmentEffects"
	RegisterForOrder(None,the_order,"",false)
	DOM01.SendDOMOrder(None,the_order,"",false)
EndFunction

Function DoOrder(Form sender, string the_event, string type, bool flag=false)
	if the_event == "Animate"
		OnOrderAnimate(sender,the_event,type,flag)
	elseif the_event == "AnimateStrip"
		OnOrderAnimateStrip(sender,the_event,type,flag)
	elseif the_event == "AnimateUndress"
		OnOrderAnimateUndress(sender,the_event,type,flag)
	elseif the_event == "AnimateDressUp"
		OnOrderAnimateDressUp(sender,the_event,type,flag)
	elseif the_event == "TieUp"
		OnOrderTieUp(sender,the_event,type,flag)
	elseif the_event == "TieUpAndGag"
		OnOrderTieUpAndGag(sender,the_event,type,flag)
	elseif the_event == "TieUpAndBlindfold"
		OnOrderTieUpAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "TieUpGagAndBlindfold"
		OnOrderTieUpGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "Chain"
		OnOrderChain(sender,the_event,type,flag)
	elseif the_event == "ChainAndGag"
		OnOrderChainAndGag(sender,the_event,type,flag)
	elseif the_event == "ChainAndBlindfold"
		OnOrderChainAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "ChainGagAndBlindfold"
		OnOrderChainGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "Cage"
		OnOrderCage(sender,the_event,type,flag)
	elseif the_event == "CageAndGag"
		OnOrderCageAndGag(sender,the_event,type,flag)
	elseif the_event == "CageAndBlindfold"
		OnOrderCageAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "CageGagAndBlindfold"
		OnOrderCageGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "Post"
		OnOrderPost(sender,the_event,type,flag)
	elseif the_event == "PostAndGag"
		OnOrderPostAndGag(sender,the_event,type,flag)
	elseif the_event == "PostAndBlindfold"
		OnOrderPostAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "PostGagAndBlindfold"
		OnOrderPostGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "Cross"
		OnOrderCross(sender,the_event,type,flag)
	elseif the_event == "CrossAndGag"
		OnOrderCrossAndGag(sender,the_event,type,flag)
	elseif the_event == "CrossAndBlindfold"
		OnOrderCrossAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "CrossGagAndBlindfold"
		OnOrderCrossGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "Pillory"
		OnOrderPillory(sender,the_event,type,flag)
	elseif the_event == "PilloryAndGag"
		OnOrderPilloryAndGag(sender,the_event,type,flag)
	elseif the_event == "PilloryAndBlindfold"
		OnOrderPilloryAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "PilloryGagAndBlindfold"
		OnOrderPilloryGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "Wheel"
		OnOrderWheel(sender,the_event,type,flag)
	elseif the_event == "WheelAndGag"
		OnOrderWheelAndGag(sender,the_event,type,flag)
	elseif the_event == "WheelAndBlindfold"
		OnOrderWheelAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "WheelGagAndBlindfold"
		OnOrderWheelGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "AddGag"
		OnOrderAddGag(sender,the_event,type,flag)
	elseif the_event == "AddBlindfold"
		OnOrderAddBlindfold(sender,the_event,type,flag)
	elseif the_event == "AddGagAndBlindfold"
		OnOrderAddGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "RemoveGag"
		OnOrderRemoveGag(sender,the_event,type,flag)
	elseif the_event == "RemoveBlindfold"
		OnOrderRemoveBlindfold(sender,the_event,type,flag)
	elseif the_event == "RemoveGagAndBlindfold"
		OnOrderRemoveGagAndBlindfold(sender,the_event,type,flag)
	elseif the_event == "AddCuffsFront"
		OnOrderAddCuffsFront(sender,the_event,type,flag)
	elseif the_event == "AddCuffsBack"
		OnOrderAddCuffsBack(sender,the_event,type,flag)
	elseif the_event == "AddCuffsCrossed"
		OnOrderAddCuffsCrossed(sender,the_event,type,flag)
	elseif the_event == "AddCuffsBoxTied"
		OnOrderAddCuffsBoxTied(sender,the_event,type,flag)
	elseif the_event == "AddYoke"
		OnOrderAddYoke(sender,the_event,type,flag)
	elseif the_event == "AddArmbinder"
		OnOrderAddArmbinder(sender,the_event,type,flag)
	elseif the_event == "AddCuffs"
		OnOrderAddCuffs(sender,the_event,type,flag)
	elseif the_event == "RemoveCuffs"
		OnOrderRemoveCuffs(sender,the_event,type,flag)
	elseif the_event == "AddPlugVaginal"
		OnOrderAddPlugVaginal(sender,the_event,type,flag)
	elseif the_event == "AddPlugAnal"
		OnOrderAddPlugAnal(sender,the_event,type,flag)
	elseif the_event == "RemovePlug"
		OnOrderRemovePlug(sender,the_event,type,flag)
	elseif the_event == "GatherBag"
		OnOrderGatherBag(sender,the_event,type,flag)
	elseif the_event == "OutBag"
		OnOrderOutBag(sender,the_event,type,flag)
	elseif the_event == "InBag"
		OnOrderInBag(sender,the_event,type,flag)
	elseif the_event == "DrinkThis"
		OnOrderDrinkThis(sender,the_event,type,flag)
	elseif the_event == "Threaten"
		OnOrderThreaten(sender,the_event,type,flag)
	elseif the_event == "Promise"
		OnOrderPromise(sender,the_event,type,flag)
	elseif the_event == "BeNaked"
		OnOrderBeNaked(sender,the_event,type,flag)
	elseif the_event == "DontBeNaked"
		OnOrderDontBeNaked(sender,the_event,type,flag)
	elseif the_event == "NoOrgasm"
		OnOrderNoOrgasm(sender,the_event,type,flag)
	elseif the_event == "FreeOrgasm"
		OnOrderFreeOrgasm(sender,the_event,type,flag)
	elseif the_event == "Strip"
		OnOrderStrip(sender,the_event,type,flag)
	elseif the_event == "StripAll"
		OnOrderStripAll(sender,the_event,type,flag)
	elseif the_event == "StripWeapons"
		OnOrderStripWeapons(sender,the_event,type,flag)
	elseif the_event == "StripArmor"
		OnOrderStripArmor(sender,the_event,type,flag)
	elseif the_event == "EquipInventory"
		OnOrderEquipInventory(sender,the_event,type,flag)
	elseif the_event == "EquipInventoryForced"
		OnOrderEquipInventoryForced(sender,the_event,type,flag)
	elseif the_event == "EquipInventoryNoApply"
		OnOrderEquipInventoryNoApply(sender,the_event,type,flag)
	elseif the_event == "EquipInventoryQuiet"
		OnOrderEquipInventoryQuiet(sender,the_event,type,flag)
	elseif the_event == "ApplyEquipmentEffects"
		OnOrderApplyEquipmentEffects(sender,the_event,type,flag)
	elseif the_event == "UndressBeforeSex"
		OnOrderUndressBeforeSex(sender,the_event,type,flag)
	elseif the_event == "TryWearClothes"
		OnOrderTryWearClothes(sender,the_event,type,flag)
	elseif the_event == "Scold"
		OnOrderScold(sender,the_event,type,flag)
	elseif the_event == "Praise"
		OnOrderPraise(sender,the_event,type,flag)
	elseif the_event == "Insult"
		OnOrderInsult(sender,the_event,type,flag)
	elseif the_event == "Flatter"
		OnOrderFlatter(sender,the_event,type,flag)
	elseif the_event == "Shower"
		OnOrderShower(sender,the_event,type,flag)
	elseif the_event == "Masturbate"
		OnOrderMasturbate(sender,the_event,type,flag)
	elseif the_event == "BeSilent"
		OnOrderBeSilent(sender,the_event,type,flag)
	elseif the_event == "BeRespectful"
		OnOrderBeRespectful(sender,the_event,type,flag)
	elseif the_event == "WalkOnFour"
		OnOrderWalkOnFour(sender,the_event,type,flag)
	elseif the_event == "FightForMe"
		OnOrderFightForMe(sender,the_event,type,flag)
	elseif the_event == "DontFightForMe"
		OnOrderDontFightForMe(sender,the_event,type,flag)
	elseif the_event == "Follow"
		OnOrderFollow(sender,the_event,type,flag)
	elseif the_event == "FollowIfPosing"
		OnOrderFollowIfPosing(sender,the_event,type,flag)
	elseif the_event == "StandStill"
		OnOrderStandStill(sender,the_event,type,flag)
	elseif the_event == "WaitHere"
		OnOrderWaitHere(sender,the_event,type,flag)
	elseif the_event == "Work"
		OnOrderWork(sender,the_event,type,flag)
	elseif the_event == "GoToJail"
		OnOrderGoToJail(sender,the_event,type,flag)
	elseif the_event == "DoDisplay"
		OnOrderDoDisplay(sender,the_event,type,flag)
	elseif the_event == "DoStandUp"
		OnOrderDoStandUp(sender,the_event,type,flag)
	elseif the_event == "DoCalm"
		OnOrderDoCalm(sender,the_event,type,flag)
	elseif the_event == "DoStandUpAndCalm"
		OnOrderDoStandUpAndCalm(sender,the_event,type,flag)
	elseif the_event == "DoDance"
		OnOrderDoDance(sender,the_event,type,flag)
	elseif the_event == "DoMusic"
		OnOrderDoMusic(sender,the_event,type,flag)
	elseif the_event == "DoFlowers"
		OnOrderDoFlowers(sender,the_event,type,flag)
	elseif the_event == "DoDrinks"
		OnOrderDoDrinks(sender,the_event,type,flag)
	elseif the_event == "DoSubmissive"
		OnOrderDoSubmissive(sender,the_event,type,flag)
	elseif the_event == "DoCute"
		OnOrderDoCute(sender,the_event,type,flag)
	elseif the_event == "DoAssPresentation"
		OnOrderDoAssPresentation(sender,the_event,type,flag)
	elseif the_event == "DoBreastsPresentation"
		OnOrderDoBreastsPresentation(sender,the_event,type,flag)
	elseif the_event == "DoChestPresentation"
		OnOrderDoBreastsPresentation(sender,the_event,type,flag)
	elseif the_event == "DoPussyPresentation"
		OnOrderDoPussyPresentation(sender,the_event,type,flag)
	elseif the_event == "DoCrochPresentation"
		OnOrderDoPussyPresentation(sender,the_event,type,flag)
	elseif the_event == "DoChair"
		OnOrderDoChair(sender,the_event,type,flag)
	elseif the_event == "DoLight"
		OnOrderDoLight(sender,the_event,type,flag)
	elseif the_event == "Display"
		OnOrderDisplay(sender,the_event,type,flag)
	elseif the_event == "Kneel"
		OnOrderKneel(sender,the_event,type,flag)
	elseif the_event == "Attention"
		OnOrderAttention(sender,the_event,type,flag)
	elseif the_event == "Salute"
		OnOrderSalute(sender,the_event,type,flag)
	elseif the_event == "LookAtMe"
		OnOrderLookAtMe(sender,the_event,type,flag)
	elseif the_event == "TurnAround"
		OnOrderTurnAround(sender,the_event,type,flag)
	elseif the_event == "ComeHere"
		OnOrderComeHere(sender,the_event,type,flag)
	elseif the_event == "SeparateFromTrainer"
		OnOrderSeparateFromTrainer(sender,the_event,type,flag)
	elseif the_event == "SetTrainer"
		OnOrderSetTrainer(sender,the_event,type,flag)
	elseif the_event == "MarkMe"
		OnOrderMarkMe(sender,the_event,type,flag)
	elseif the_event == "BrandMe"
		OnOrderBrandMe(sender,the_event,type,flag)
	endif
EndFunction

Event OnOrderAnimate(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" flag="+flag)
	if flag ; is_idle
		Anim_IdleByString(type) ; type is the pose to play
	else
		Anim_LocalByString(type)
	endif
	is_group_order = false
EndEvent

Event OnOrderAnimateStrip(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" flag="+flag)
	Anim_Strip(flag)
	is_group_order = false
EndEvent

Event OnOrderAnimateUndress(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" flag="+flag)
	Anim_Undress(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderAnimateDressUp(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" flag="+flag)
	Anim_DressUp(flag)
	is_group_order = false
EndEvent

Event OnOrderTieUp(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	logTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" is_group_order="+is_group_order)
	EnterTieUp(sender as Actor,None,type)
	is_group_order = false
EndEvent

Event OnOrderTieUpAndGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	EnterTieUp(sender as Actor,None,type)
	EnterGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderTieUpAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	EnterTieUp(sender as Actor,None,type)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderTieUpGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	EnterTieUp(sender as Actor,None,type)
	EnterGagged(sender as Actor)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderChain(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetChainPose(self)
	endif
	EnterChained(sender as Actor,None,type,need_cuff=flag)	
	is_group_order = false
EndEvent

Event OnOrderChainAndGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetChainPose(self)
	endif
	EnterChained(sender as Actor,None,type,need_cuff=flag)	
	EnterGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderChainAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetChainPose(self)
	endif
	EnterChained(sender as Actor,None,type,need_cuff=flag)	
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderChainGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetChainPose(self)
	endif
	EnterChained(sender as Actor,None,type,need_cuff=flag)	
	EnterGagged(sender as Actor)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderCage(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetCagePose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)	
	is_group_order = false
EndEvent

Event OnOrderCageAndGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetCagePose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)	
	EnterGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderCageAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetCagePose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)	
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderCageGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetCagePose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)	
	EnterGagged(sender as Actor)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderPost(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetPostPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)	
	is_group_order = false
EndEvent

Event OnOrderPostAndGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetPostPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderPostAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetPostPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderPostGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetPostPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterGagged(sender as Actor)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderCross(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetCrossPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	is_group_order = false
EndEvent

Event OnOrderCrossAndGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetCrossPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderCrossAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetCrossPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderCrossGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetCrossPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterGagged(sender as Actor)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderPillory(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetPilloryPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	is_group_order = false
EndEvent

Event OnOrderPilloryAndGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetPilloryPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderPilloryAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetPilloryPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderPilloryGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetPilloryPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterGagged(sender as Actor)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderWheel(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetWheelPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	is_group_order = false
EndEvent

Event OnOrderWheelAndGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetWheelPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderWheelAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetWheelPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderWheelGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		type = DOM01.DOM_Anim.GetWheelPose(self)
	endif
	EnterRestrained(sender as Actor,None,type,need_cuff=flag)		
	EnterGagged(sender as Actor)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderAddGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	int idx
	if type == "random"
		idx = RandomInt(1,4)
	else
		idx = type as int
	endif
	Form the_gag = DOM01.DOMZaz.GetGag(idx)
	EnterGagged(sender as Actor,the_gag)
	is_group_order = false
EndEvent

Event OnOrderAddBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	int idx
	if type == "random"
		idx = RandomInt(1,6)
	else
		idx = type as int
	endif
	Form the_blindfold = DOM01.DOMZaz.GetBlindfold(idx)
	EnterBlindfolded(sender as Actor,the_blindfold)
	is_group_order = false
EndEvent

Event OnOrderAddGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	EnterGagged(sender as Actor)
	EnterBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderRemoveGag(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	ExitGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderRemoveBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	ExitBlindfolded(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderRemoveGagAndBlindfold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	ExitBlindfolded(sender as Actor)
	ExitGagged(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderAddCuffsFront(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterFollowPlayer()
	EnterCuffed(sender as Actor,1)
	is_group_order = false
EndEvent

Event OnOrderAddCuffsBack(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterFollowPlayer()
	EnterCuffed(sender as Actor,0)
	is_group_order = false
EndEvent

Event OnOrderAddCuffsCrossed(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterFollowPlayer()
	EnterCuffed(sender as Actor,2)
	is_group_order = false
EndEvent

Event OnOrderAddCuffsBoxTied(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterFollowPlayer()
	EnterCuffed(sender as Actor,3)
	is_group_order = false
EndEvent

Event OnOrderAddYoke(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterFollowPlayer()
	EnterCuffed(sender as Actor,4)
	is_group_order = false
EndEvent

Event OnOrderAddArmbinder(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterFollowPlayer()
	EnterCuffed(sender as Actor,5)
	is_group_order = false
EndEvent

Event OnOrderAddCuffs(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterFollowPlayer()
	if mind.anger_training < mind.resignation &&  mind.anger_training < mind.humiliation && mind.anger_training < mind.submission
		EnterCuffed(sender as Actor,2)
	elseif mind.resignation < mind.humiliation && mind.resignation < mind.submission
		EnterCuffed(sender as Actor,1)
	elseif mind.humiliation < mind.submission
		EnterCuffed(sender as Actor,3)
	else
		EnterCuffed(sender as Actor,0)
	endif
	is_group_order = false
EndEvent

Event OnOrderRemoveCuffs(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	ExitCuffed(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderAddPlugAnal(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterPlugged(sender as Actor,false)
	is_group_order = false
EndEvent

Event OnOrderAddPlugVaginal(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	EnterPlugged(sender as Actor,true)
	is_group_order = false
EndEvent

Event OnOrderRemovePlug(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	if has_plug_anal
		ExitPlugged(sender as Actor,false)
	endif
	if has_plug_vaginal
		ExitPlugged(sender as Actor,true)
	endif
	is_group_order = false
EndEvent

Event OnOrderInBag(Form sender, string the_event, string type, bool flag)
	LogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	UnRegisterForDOMEvent(sender,the_event)
	DOM01.DOMKeys.DOMDoPutInBagInPlace(akRef,None)
	is_group_order = false
EndEvent

Event OnOrderOutBag(Form sender, string the_event, string type, bool flag)
	LogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	UnRegisterForDOMEvent(sender,the_event)
	if the_bag_iam_in != None
		DOM01.DOMKeys.DOMDoTakeOutOfBag(sender as Actor, the_bag_iam_in,false,false) ; no tied up, no anim
	endif
	is_group_order = false
EndEvent

Event OnOrderGatherBag(Form sender, string the_event, string type, bool flag)
	LogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	UnRegisterForDOMEvent(sender,the_event)
	if the_bag_iam_in != None
		DOM01.DOMKeys.DOMPickUpBag(sender as Actor, the_bag_iam_in)
	endif
	is_group_order = false
EndEvent

Event OnOrderDrinkThis(Form sender, string the_event, string type, bool flag)
	LogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	UnRegisterForDOMEvent(sender,the_event)
	if type == "alcohol"
		LogTrace("OnOrderDrinkThis alcohol")
		OrderDrinkAlcohol(sender as Actor)
	elseif type == "narcotic"
		LogTrace("OnOrderDrinkThis potion")
		Form the_drug = GetANarcotic(sender as Actor)
		if the_drug != None
			LogTrace("Found "+the_drug.GetName())
			OrderDrinkThis(sender as Actor,the_drug)
		endif
	else
		LogTrace("OnOrderDrinkThis potion")
		OrderDrinkThis(sender as Actor,None)
	endif
	is_group_order = false
EndEvent

Event OnOrderThreaten(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	StartThreatening(sender as Actor,type)
	is_group_order = false
EndEvent

Event OnOrderPromise(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	StartPromising(sender as Actor,type)
	is_group_order = false
EndEvent

Event OnOrderBeNaked(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	SetShouldBeNaked(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDontBeNaked(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	UnsetShouldBeNaked(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderNoOrgasm(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	SetShouldBeNoOrgasm(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderFreeOrgasm(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	UnsetShouldBeNoOrgasm(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderStrip(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	Interact_Strip(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderStripAll(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	Interact_StripAll(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderStripWeapons(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	StripMaybeDropWeapons(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderStripArmor(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	StripMaybeDropArmor(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderUndressBeforeSex(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrderUndressBeforeSex Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	UndressBeforeSex(sender as Actor, flag)
	is_group_order = false
EndEvent

Event OnOrderTryWearClothes(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrderTryWearClothes Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	TryWearClothes(flag)
	is_group_order = false
EndEvent

Event OnOrderEquipInventory(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogEquip("OnOrderEquipInventory Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	EquipInventoryNow(flag) ; true = do anim if dressing up or stripping
	is_group_order = false
EndEvent

Event OnOrderEquipInventoryForced(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogEquip("OnOrderEquipInventoryForced Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	int ireason
	if type == ""
		ireason = 1
	else
		ireason = 2
	endif
	EquipInventoryNowForced(ireason,type,flag) ; true = do anim if dressing up or stripping
	is_group_order = false
EndEvent

Event OnOrderEquipInventoryNoApply(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogEquip("OnOrderEquipInventoryNoApply Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	EquipInventoryNowNoApply(flag) ; true = do anim if dressing up or stripping
	is_group_order = false
EndEvent

Event OnOrderEquipInventoryQuiet(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogEquip("OnOrderEquipInventoryQuiet Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	EquipInventoryNowQuiet(flag) ; true = do anim if dressing up or stripping
	is_group_order = false
EndEvent

Event OnOrderApplyEquipmentEffects(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	LogEquip("OnOrderApplyEquipmentEffects Received order "+the_event+" "+type+" from "+sender+" anim="+flag)
	OnApplyEquipmentEffects()
	is_group_order = false
EndEvent

Event OnOrderScold(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if mind.GetNumberOfNextPunishmentReasons() <= 0
		return
	endif
	StartScolding(sender as Actor,type)
	is_group_order = false
EndEvent

Event OnOrderPraise(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if mind.GetNumberOfNextPraiseReasons() <= 0
		return
	endif
	StartPraising(sender as Actor,type,"tell")
	is_group_order = false
EndEvent

Event OnOrderInsult(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		StartInsulting(sender as Actor)
	else
		StartInsultingWith(sender as Actor,type)
	endif
	is_group_order = false
EndEvent

Event OnOrderFlatter(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if type == ""
		StartFlattering(sender as Actor)
	else
		StartFlatteringWith(sender as Actor,type)
	endif
	is_group_order = false
EndEvent

Event OnOrderShower(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoShower(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderMasturbate(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if is_behaviour_masturbate
		MasturbateHarder(sender as Actor)
		return
	endif
	int x = RandomInt(1,3)
	if x == 1
		EnterMasturbateLaying(sender as Actor)
	elseif x == 2
		EnterMasturbateKneeling(sender as Actor)
	else
		EnterMasturbateStanding(sender as Actor)
	endif
	is_group_order = false
EndEvent

Event OnOrderBeSilent(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if !akRef.IsInFaction(DOM01.DOMShouldBeSilent)
		mind.should_be_silent = true
	endif
	is_group_order = false
EndEvent

Event OnOrderBeRespectful(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if !akRef.IsInFaction(DOM01.DOMShouldBeRespectful)
		SetShouldBeRespectful(sender as Actor)
	endif
	is_group_order = false
EndEvent

Event OnOrderWalkOnFour(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if !akRef.IsInFaction(DOM01.DOMShouldWalkOnFour)
		SetShouldWalkOnFour(sender as Actor)
	endif
	is_group_order = false
EndEvent

Event OnOrderFightForMe(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if !mind.should_fight_for_player
		mind.SetShouldFightForPlayer()
	endif
	is_group_order = false
EndEvent

Event OnOrderDontFightForMe(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if mind.should_fight_for_player
		mind.UnsetShouldFightForPlayer()
	endif
	is_group_order = false
EndEvent

Event OnOrderFollow(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if akRef.IsInFaction(DOM01.DOMActionFollowing)
		return
	endif
	EnterFollowPlayerOrTrainer()
	is_group_order = false
EndEvent

Event OnOrderFollowIfPosing(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	if akRef.IsInFaction(DOM01.DOMActionFollowing)
		return
	endif
	EnterFollowPlayerIfPosing()
	is_group_order = false
EndEvent

Event OnOrderStandStill(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	EnterWait()
	is_group_order = false
EndEvent

Event OnOrderWaitHere(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	EnterWaitSandbox()
	is_group_order = false
EndEvent

Event OnOrderWork(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	int imode = type as int
	if imode == 0
		EnterSweep()
	else
		EnterWork(imode)
	endif
	is_group_order = false
EndEvent

Event OnOrderGoToJail(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	int imode = type as int
	akRef.SetFactionRank(DOM01.DOMJailMode,imode)
	EnterJailByMode()
	is_group_order = false
EndEvent

Event OnOrderDoDisplay(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoDisplay(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoStandUp(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoStandUp()
	is_group_order = false
EndEvent

Event OnOrderDoCalm(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	CalmActorFast(akRef)
	is_group_order = false
EndEvent

Event OnOrderDoStandUpAndCalm(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoStandUpAndCalm()
	is_group_order = false
EndEvent

Event OnOrderDoDance(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoDance(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoMusic(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoMusic(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoFlowers(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoFlowers(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoDrinks(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoDrinks(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoSubmissive(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoSubmissive(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoCute(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoCute(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoAssPresentation(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoAssPresentation(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoBreastsPresentation(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoBreastsPresentation(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoPussyPresentation(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoPussyPresentation(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoChair(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoChair(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDoLight(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoLight(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderDisplay(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	DoDisplay(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderKneel(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	Interact_StartSalute(sender as Actor,DOM01.kneelPose)
	Wait(4.0)
	Interact_EndSalute(DOM01.kneelPose)
	is_group_order = false
EndEvent

Event OnOrderAttention(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	Interact_StartSalute(sender as Actor,DOM01.attentionPose)
	Wait(4.0)
	Interact_EndSalute(DOM01.attentionPose)
	is_group_order = false
EndEvent

Event OnOrderSalute(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	Interact_StartSalute(sender as Actor,DOM01.salutePose)
	Wait(4.0)
	Interact_EndSalute(DOM01.salutePose) 
	is_group_order = false
EndEvent

Event OnOrderBrandMe(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	Interact_Brand(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderMarkMe(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	Interact_Mark(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderLookAtMe(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	Interact_LookAtMe(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderTurnAround(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	Interact_TurnAround(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderComeHere(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received order "+the_event+" "+type+" from "+sender)
	Interact_ComeHere(sender as Actor)
	is_group_order = false
EndEvent

Event OnOrderSeparateFromTrainer(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	SeparateFromTrainer()
	is_group_order = false
EndEvent

Event OnOrderSetTrainer(Form sender, string the_event, string type, bool flag)
	UnRegisterForDOMEvent(sender,the_event)
	;;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	Actor akTarget = sender as Actor
	if akTarget == None
		is_group_order = false
		return
	endif
	DOM_Actor akTrainer = DOM01.GetActor(akTarget)
	if akTrainer == None
		is_group_order = false
		return
	endif
	SetTrainer(akTrainer)
	is_group_order = false
EndEvent

Event OnOrderCheckFriendship(Form sender, string the_event, float amount, int idx, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	if mind.is_slave
		CheckFriendship(DOM01.DOM02.GetActorIndex(akRef)) ; starts at actor index to avoid double check
	else
		CheckFriendship(DOM01.DOM01.GetActorIndex(akRef)) ; starts at actor index to avoid double check
	endif
	is_group_order = false
EndEvent

Event OnOrderCheckFriendshipAfterAssign(Form sender, string the_event, float amount, int idx, string type)
	UnRegisterForDOMEvent(sender,the_event)
	LogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	int i = 0
	int n = 1000
	while is_initializing && i < n
		LogTrace("OnOrderCheckFriendshipAfterAssign actor waiting for initialize to finish... i="+i+"/"+n)
		wait(1.0)
		i += 1
	endwhile
	if akRef == PlayerRef && !DOM01.friendsPlayerToggle
		return
	endif
	CheckOldFriendship()
	CheckFriendship(-1) ; -1 = Check against all actors
	is_group_order = false
EndEvent

Event OnOrderFriendIsDead(Form sender, string the_event, float amount, int reason, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	DOM_Actor akFriend = DOM01.GetActor(sender as Actor)
	FriendIsDead(akFriend)
	is_group_order = false
EndEvent

Event OnOrderFriendIsFreed(Form sender, string the_event, float amount, int reason, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	DOM_Actor akFriend = DOM01.GetActor(sender as Actor)
	FriendIsFreed(akFriend)
	is_group_order = false
EndEvent

Event OnOrderFriendIsMoved(Form sender, string the_event, float amount, int reason, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	DOM_Actor akFriend = DOM01.GetActor(sender as Actor)
	FriendIsMoved(akFriend)
	is_group_order = false
EndEvent

Event OnOrderIncrementFling(Form sender, string the_event, float amount, int reason, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	DOM_Actor akAnotherActor = DOM01.GetActor(sender as Actor)
	IncrementFling(akAnotherActor)
	is_group_order = false
EndEvent

Event OnOrderIncrementChat(Form sender, string the_event, float amount, int reason, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	DOM_Actor akAnotherActor = DOM01.GetActor(sender as Actor)
	IncrementChat(akAnotherActor)
	is_group_order = false
EndEvent

Event OnOrderTrainWitness(Form sender, string the_event, float amount, int reason, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	DOM_Actor akAnotherActor = DOM01.GetActor(sender as Actor)
	TrainWitness(akAnotherActor,amount,reason,type)
	is_group_order = false
EndEvent

Event OnOrderTrainForSlaver(Form sender, string the_event, float amount, int reason, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	DOM_Actor akAnotherActor = DOM01.GetActor(sender as Actor)
	TrainForSlaver(akAnotherActor,amount,reason,type)
	is_group_order = false
EndEvent

Event OnOrderTrainForFriend(Form sender, string the_event, float amount, int reason, string type)
	UnRegisterForDOMEvent(sender,the_event)
	;*ogTrace("OnOrder Received event "+the_event+" "+type+" from "+sender)
	DOM_Actor akAnotherActor = DOM01.GetActor(sender as Actor)
	TrainForFriend(akAnotherActor,amount,reason,type)
	is_group_order = false
EndEvent

Event DOMWhistle(string eventName, string strArg, float numArg, Form sender)
	if IsTogetherWithFast(akRef, PlayerRef, 2000.0) ; Skyrim units 2 000 = 28.4 m
		return
	endif
	if eventName == "DOMWhistle_wait"
		EnterWait()
	else
		EnterFollowPlayer()
	endif
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatStatus)
	if akTarget != akRef || akTarget == None
		return
	endif
	;*ogTrace("OnCombatStateChanged() status="+aeCombatStatus)	
	if aeCombatStatus == 0
		is_in_combat = false
	else
		is_in_combat = true
	endif
	if akRef.IsHostileToActor(PlayerRef)
		return
	endif
	mind.UpdateIsFighting(akTarget, aeCombatStatus)
EndEvent

Event OnSit(ObjectReference akFurniture)
	if is_exiting_tieup
		LogTrace("is exiting tieup but wants to sit in "+akFurniture.GetBaseObject().getName())	
		return
	endif
	;LogTrace("will now be sitting in "+akFurniture.GetBaseObject().getName())	
	is_sitting = true
	nextTiedInFurniture = akFurniture
	if DOM01.DOMZaz.hasKeywordFurniture(akFurniture)
		EnterRestrainedInFurnitureAlreadySitting()
		if akRef.IsDoingFavor()
			akRef.SetDoingFavor(false)
		endif
	elseif akRef.IsDoingFavor()
		EnterPoseInFurnitureAlreadySitting()
		akRef.SetDoingFavor(false)
	endif
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	;LogTrace("is getting up from "+akFurniture.GetBaseObject().getName())	
	is_sitting = false
	;currentTiedInFurniture = None
	nextTiedInFurniture = akFurniture
endEvent

Event OnActorAction(int actionType, Actor akTarget, Form source, int slot)
	; it will always be the player's actor's actions that are being registered, not the current actor
    UnRegisterForActorAction(7)  ; draw 
    UnRegisterForActorAction(10) ; sheath
	;if akTarget != akRef
	;	return
	;endif
    ;if actionType == 7 || actionType == 10 ; draw or sheath
	;	is_weapon_drawn = akRef.IsWeaponDrawn()
	;endif
	;LogTrace("OnActorAction() actionType="+actionType)
EndEvent

Function HandlePunishmentOnHit(Actor akAbuser, Form akSource)
	;*ogTrace("HandlePunishmentOnHit whipping_active="+mind.whipping_active)
	if !mind.whipping_active
		StartWhipping(akAbuser)
	endif
	mind.HandlePunishmentOnHit(akAbuser,akSource)
	ChoosePainTopic(akAbuser)
EndFunction

Float prehit_health = 100.0
Form pain_giver = None 
float Function HandleHealthOnHit(Form akSource)
	;*ogTrace("HandleHealthOnHit "+akSource.GetName())
	float current_health = akRef.GetActorValue("Health") ; Current health
	float current_damage
	if akSource != None
		if akSource != pain_giver
			pain_giver = akSource
			if DOM01.DOMEquip.IsWeaponWhip(akSource) ; Whip
				current_damage = 1.0
				is_whipped = true
				is_slapped = false
				is_caned   = false
				current_health = akRef.GetActorValue("Health") ; get current actor value
			elseif DOM01.DOMEquip.IsWeaponSlap(akSource) ; Slap
				current_damage = 1.0
				is_whipped = false
				is_slapped = true
				is_caned   = false
				current_health = akRef.GetActorValue("Health") ; get current actor value
			elseif DOM01.DOMEquip.IsWeaponCane(akSource) ; Cane
				current_damage = 1.0
				is_whipped = false
				is_slapped = false
				is_caned   = true
				current_health = akRef.GetActorValue("Health") ; get current actor value
			else
				is_whipped = false
				is_slapped = false
				is_caned   = false
				current_damage = prehit_health - current_health
			endif
		elseif is_whipped || is_slapped || is_caned
			current_damage = 1.0
			current_health = akRef.GetActorValue("Health") ; get current actor value
		else
			current_damage = prehit_health - current_health
		endif
	else
		current_damage = prehit_health - current_health
	endif
	prehit_health = current_health
	;*ogTrace("HandleHealthOnHit(): health="+current_health+" damage="+current_damage)
	return current_damage
EndFunction

bool Function HandleAlarmOnHit()
	;*ogTrace("HandleAlarmOnHit() alarmed="+akRef.IsInFaction(DOM01.DOMPlayerEnemyFaction))
	if !akRef.IsInFaction(DOM01.DOMPlayerEnemyFaction)
		return false
	endif

	TurnOffCrimeFaction()
	mind.TrainCombat(2.0)
	if myRival && myRival.akRef.IsHostileToActor(akRef)
		;myRival.akRef.StopCombat()
		myRival.akRef.StopCombatAlarm()
	endif	
	if meRival && meRival != myRival && meRival.akRef.IsHostileToActor(akRef)
		;meRival.akRef.StopCombat()
		meRival.akRef.StopCombatAlarm()
	endif	
	mind.should_fight_for_player = mind.should_fight_for_player
	CalmActorFast(akRef)
	;*ogTrace("CorrectBehaviour HandleAlarmOnHit")
	CorrectBehaviour(GetCurrentTrainer(), 0, true) ; EnterFollowPlayerOrTrainer()
	return true
EndFunction

Function PrepareForSacrifice()
	LogTrace("PrepareForSacrifice start: Max hp="+ mind.GetBaseHealth()+" curr="+ akRef.GetActorValue("health"))
	mind.DamageHealth()
	int rank = akRef.GetFactionRank(DOM01.DOMToBeSacrificed)
	akRef.SetFactionRank(DOM01.DOMToBeSacrificed,2) ; next in line
	if rank < 1 ; training boost
		mind.TrainFear(20.0)
		mind.TrainSubmission(10.0)
		mind.TrainRespect(10.0)
		mind.MakeAngryFor(40.0)
	else
		mind.MakeAngryFor(20.0)
	endif
	LogTrace("PrepareForSacrifice end: Max hp="+ mind.GetBaseHealth()+" curr="+ akRef.GetActorValue("health"))
EndFunction

Function UnprepareForSacrifice()
	;LogTrace("UnrepareForSacrifice start: Max hp="+ mind.GetBaseHealth()+" curr="+ akRef.GetActorValue("health"))
	mind.RestoreHealth()
	akRef.SetFactionRank(DOM01.DOMToBeSacrificed,1) ; to be sacrificed later
	;LogTrace("UnrepareForSacrifice end: Max hp="+ mind.GetBaseHealth()+" curr="+ akRef.GetActorValue("health"))
EndFunction

int ticksSinceRegen = 0
Function HandleRegenOnUpdate()
	if DOM01.actorRegenTicks <= 0 ; no regen
		return
	endif
	ticksSinceRegen += 1
	if ticksSinceRegen < DOM01.actorRegenTicks
		return ; wait for more ticks
	endif
	ticksSinceRegen = 0
	mind.RegenHealth(DOM01.actorRegenAmount)
	prehit_health = akRef.GetActorValue("Health") ; current health
	;*ogTrace("HandleRegenOnUpdate() health="+prehit_health+"/"+mind.GetBaseHealth())
EndFunction

float dirtTimer = 0.0
Function HandleDirtOnUpdate()
	if dirtTimer == 0.0
		dirtTimer = GetCurrentGameTime()
		return
	endif
	float cur_time = GetCurrentGameTime()
	float elapsed_time = cur_time-dirtTimer ; in days
	float amount = elapsed_time * DOM01.dirtRegenAmount ; default is 10 days without showering is fine = 30% dirty
	if poseId == 103 ; if exercising get more dirty
		amount *= 2.0
	endif
	dirty_level += amount
	if akRef.IsSwimming() ; || PO3_SKSEFunctions.IsActorUnderwater(akRef) ; technically wet effect should not be applied when underwater
		wet_level = 1.0
	elseif wet_level > 0.0
		wet_level -= 0.05
		;*ogTrace("New wet level: "+wet_level)
	endif
	dirtTimer = cur_time
EndFunction

int lastWeatherType = 0
Function HandleWeatherOnUpdate()
	if !is_naked ; Only for naked slaves for now
		return
	endif
	if !akRef.Is3DLoaded()
		return
	endif
	int weatherType = GetWeatherType(akRef)
	if lastWeatherType != weatherType
		lastWeatherType = weatherType
		is_weather_dialogue_blocked_for = RandomInt(1,DOM01.delayTopic*2) 
	endif
	;*ogTrace("HandleWeatherOnUpdate: "+name+" weather type = "+weatherType)
	ChooseWeatherTopic(PlayerRef,weatherType)
	mind.TrainForWeather(weatherType)
EndFunction

; ### Location and equipment status ###

bool Property was_inventory_changed = true Auto Hidden
bool __equip_inventory_cancel = false
bool __equip_inventory_busy = false
bool Property equip_inventory_busy Hidden
	bool Function get()
		if !canIdleSexlab
			LogEquip("equip_inventory_busy CAN NOT animate because of Sexlab idles deactivated canIdleSexlab="+canIdleSexlab)
			return true
		endif
		LogEquip("equip_inventory_busy value="+__equip_inventory_busy)
		return __equip_inventory_busy
	EndFunction
	Function set(bool value)
		if __equip_inventory_busy && value && !__equip_inventory_cancel
			; already equipping
			__equip_inventory_cancel = true
		endif
		__equip_inventory_busy = value
		LogEquip("equip_inventory_busy set="+__equip_inventory_busy)
	EndFunction
EndProperty
bool is_inventory_open = false
bool wait_for_equipment = false
int cuffs_material = 0

bool __is_in_dungeon = false
bool Property is_in_dungeon Hidden
	bool Function get()
		return __is_in_dungeon
	EndFunction
	Function set(bool value)
		__is_in_dungeon = value
		; Update dependencies
		mind.RegisterForUpdateChanceAfraid()
		mind.RegisterForUpdateChanceScared()
		mind.RegisterForUpdateChanceTerrified()
		mind.RegisterForUpdateChanceSad()
		mind.RegisterForUpdateChanceCrushed()
	EndFunction
EndProperty

bool __is_in_city = false
bool Property is_in_city Hidden
	bool Function get()
		return __is_in_city
	EndFunction
	Function set(bool value)
		__is_in_city = value
		; Update dependencies
		mind.RegisterForUpdateChanceCrushed()
		mind.RegisterForUpdateChanceProud()
		mind.RegisterForUpdateChanceAshamed()
	EndFunction
EndProperty

bool __is_naked = false
bool Property is_naked Hidden
	bool Function get()
		return __is_naked
	EndFunction
	Function set(bool value)
		__is_naked = value
		SetBoolFaction(akRef, DOM01.DOMIsNaked, __is_naked)
		; Update dependencies
		is_shamed = IsShamed()
	EndFunction
EndProperty

bool __is_shamed = false
bool Property is_shamed Hidden
	bool Function get()
		return __is_shamed
	EndFunction
	Function set(bool value)
		__is_shamed = value
		; Update dependencies
		mind.RegisterForUpdateChanceProud()
		mind.RegisterForUpdateChanceAshamed()
		mind.RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty

bool Property has_shield_in_inventory = false Auto Hidden
bool Property has_body_armor_in_inventory = false Auto Hidden
bool Property has_armor_in_inventory = false Auto Hidden
bool Property has_clothes_in_inventory = false Auto Hidden


bool __has_cuffs_crossed = false
bool Property has_cuffs_crossed Hidden
	bool Function get()
		return __has_cuffs_crossed
	EndFunction
	Function set(bool value)
		if __has_cuffs_crossed == value
			return
		endif
		__has_cuffs_crossed = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasCuffsCrossed, __has_cuffs_crossed)
		if __has_cuffs_crossed
			mind.CheckAndRegisterKink(84,0.5) ; wearing cuffs
		endif
	EndFunction
EndProperty

bool __has_cuffs_front = false
bool Property has_cuffs_front Hidden
	bool Function get()
		return __has_cuffs_front
	EndFunction
	Function set(bool value)
		if __has_cuffs_front == value
			return
		endif
		__has_cuffs_front = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasCuffsFront, __has_cuffs_front)
		if __has_cuffs_front
			mind.CheckAndRegisterKink(84,0.5) ; wearing cuffs
		endif
	EndFunction
EndProperty

bool __has_cuffs_boxtied = false
bool Property has_cuffs_boxtied Hidden
	bool Function get()
		return __has_cuffs_boxtied
	EndFunction
	Function set(bool value)
		if __has_cuffs_boxtied == value
			return
		endif
		__has_cuffs_boxtied = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasCuffsBoxTied, __has_cuffs_boxtied)
		if __has_cuffs_boxtied
			mind.CheckAndRegisterKink(84,0.5) ; wearing cuffs
		endif
	EndFunction
EndProperty

bool __has_cuffs_back = false
bool Property has_cuffs_back Hidden
	bool Function get()
		return __has_cuffs_back
	EndFunction
	Function set(bool value)
		if __has_cuffs_back == value
			return
		endif
		__has_cuffs_back = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasCuffsBack, __has_cuffs_back)
		if __has_cuffs_back
			mind.CheckAndRegisterKink(84,0.5) ; wearing cuffs
		endif
	EndFunction
EndProperty

bool __has_yoke = false
bool Property has_yoke Hidden
	bool Function get()
		return __has_yoke
	EndFunction
	Function set(bool value)
		if __has_yoke == value
			return
		endif
		__has_yoke = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasArmsDeviceYoke, __has_yoke)
		if __has_yoke
			mind.CheckAndRegisterKink(85,0.5) ; wearing a yoke
		endif
	EndFunction
EndProperty

bool __has_armbinder = false
bool Property has_armbinder Hidden
	bool Function get()
		return __has_armbinder
	EndFunction
	Function set(bool value)
		if __has_armbinder == value
			return
		endif
		__has_armbinder = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasArmsDeviceBinder, __has_armbinder)
		if __has_armbinder
			mind.CheckAndRegisterKink(86,0.5) ; wearing an armbinder
		endif
		__has_armbinder = value
	EndFunction
EndProperty

bool __has_mouth_gag = false
bool Property has_mouth_gag Hidden
	bool Function get()
		return __has_mouth_gag
	EndFunction
	Function set(bool value)
		if __has_mouth_gag == value
			return
		endif
		__has_mouth_gag = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasMouthGag, __has_mouth_gag)
	EndFunction
EndProperty

bool __has_arms_device = false
bool Property has_arms_device Hidden
	bool Function get()
		return __has_arms_device
	EndFunction
	Function set(bool value)
		__has_arms_device = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasArmsDevice,__has_arms_device)
	EndFunction
EndProperty

bool __has_dwarven_device = false
bool Property has_dwarven_device Hidden
	bool Function get()
		return __has_dwarven_device
	EndFunction
	Function set(bool value)
		__has_dwarven_device = value
	EndFunction
EndProperty

bool __has_dd_suit = false
bool Property has_dd_suit Hidden
	bool Function get()
		return __has_dd_suit
	EndFunction
	Function set(bool value)
		__has_dd_suit = value
	EndFunction
EndProperty

bool __has_petsuit = false
bool Property has_petsuit Hidden
	bool Function get()
		return __has_petsuit
	EndFunction
	Function set(bool value)
		__has_petsuit = value
	EndFunction
EndProperty

bool __has_straitjacket = false
bool Property has_straitjacket Hidden
	bool Function get()
		return __has_straitjacket
	EndFunction
	Function set(bool value)
		__has_straitjacket = value
	EndFunction
EndProperty

bool __has_cuffs = false
bool Property has_cuffs Hidden
	bool Function get()
		return __has_cuffs
	EndFunction
	Function set(bool value)
		__has_cuffs = value
	EndFunction
EndProperty

bool __has_disablekick = false
bool Property has_disablekick Hidden
	bool Function get()
		return __has_disablekick
	EndFunction
	Function set(bool value)
		__has_disablekick = value
	EndFunction
EndProperty

bool __has_device = false
bool Property has_device Hidden
	bool Function get()
		return __has_device
	EndFunction
	Function set(bool value)
		__has_device = value
	EndFunction
EndProperty

bool __has_collar = false
bool Property has_collar Hidden
	bool Function get()
		return __has_collar
	EndFunction
	Function set(bool value)
		if __has_collar == value
			return
		endif
		LogEquip("has_collar="+__has_collar+" new value="+value)
		__has_collar = value
		mind.RegisterForUpdateChanceRunAway()
		mind.RegisterForUpdateChanceRunAwayGang()
		if __has_collar
			DOM01.DOM04.NotifyEquipCollar(self)
		endif
	EndFunction
EndProperty

bool __has_blindfold = false
bool Property has_blindfold Hidden
	bool Function get()
		return __has_blindfold
	EndFunction
	Function set(bool value)
		if __has_blindfold == value
			return
		endif
		__has_blindfold = value
		LogTrace("Set faction DOMHasBlindfold to "+__has_blindfold)
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasBlindfold, __has_blindfold) ; IsInFaction("DiaryOfMine.esm"|0x00D328F9)
		mind.RegisterForUpdateChanceRunAway()
		mind.RegisterForUpdateChanceRunAwayGang()
	EndFunction
EndProperty

bool __has_leash = false
bool Property has_leash Hidden
	bool Function get()
		return __has_leash
	EndFunction
	Function set(bool value)
		__has_leash = value
		LogEquip("Set has_leash="+__has_leash)
		;if __has_leash && leash_point == None
		;	leash_point = akRef.PlaceAtMe(DOM01.PAHLeashPoint)
		;   leash_point.Enable()
		;endif
	EndFunction
EndProperty

bool __has_plug_anal = false
bool Property has_plug_anal Hidden
	bool Function get()
		return __has_plug_anal
	EndFunction
	Function set(bool value)
		LogEquip("has_plug_anal "+__has_plug_anal+" "+value)
		if __has_plug_anal == value
			return
		endif
		__has_plug_anal = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasPlugAnal, __has_plug_anal)
		LogEquip("has_plug_anal "+__has_plug_anal+" notify")
		if __has_plug_anal
			DOM01.DOM04.NotifyEquipPlugAnal(self)
		endif
	EndFunction
EndProperty

bool __has_plug_vaginal = false
bool Property has_plug_vaginal Hidden
	bool Function get()
		return __has_plug_vaginal
	EndFunction
	Function set(bool value)
		LogEquip("has_plug_vaginal "+__has_plug_vaginal+" "+value)
		if __has_plug_vaginal == value
			return
		endif
		__has_plug_vaginal = value
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasPlugVaginal, __has_plug_vaginal)
		LogEquip("has_plug_vaginal "+__has_plug_vaginal+" notify")
		if __has_plug_vaginal
			DOM01.DOM04.NotifyEquipPlugVaginal(self)
		endif
	EndFunction
EndProperty

bool __has_weapon_in_inventory = false
bool Property has_weapon_in_inventory Hidden
	bool Function get()
		return __has_weapon_in_inventory
	EndFunction
	Function set(bool value)
		if __has_weapon_in_inventory == value
			return
		endif
		__has_weapon_in_inventory = value
		;SetIntFaction(akRef,DOM01.DOMHasInventoryWeapon, __has_weapon_in_inventory as int)
		; Update dependencies
		mind.RegisterForUpdateChanceRunAway()
		mind.RegisterForUpdateChanceRunAwayGang()
		mind.RegisterForUpdateChanceAngry()
		mind.RegisterForUpdateChanceAngryForUnfairness()
		mind.RegisterForUpdateChanceAngryForInjustice()
		mind.RegisterForUpdateChanceDefiant()
		mind.RegisterForUpdateChanceAfraid()
		mind.RegisterForUpdateChanceLoyal()
		mind.RegisterForUpdateChanceHappy()
		mind.RegisterForUpdateChanceCharmed()
	EndFunction
EndProperty
Float __has_weapon = 0.0
Float Property has_weapon Hidden
	Float Function get()
		return __has_weapon
	EndFunction
	Function set(Float value)
		if __has_weapon == value
			return
		endif
		__has_weapon = value
		SetIntFaction(akRef,DOM01.DOMHasWeapon, __has_weapon as int)
		; Update dependencies
		mind.RegisterForUpdateChanceRunAway()
		mind.RegisterForUpdateChanceRunAwayGang()
		mind.RegisterForUpdateChanceAngry()
		mind.RegisterForUpdateChanceAngryForUnfairness()
		mind.RegisterForUpdateChanceAngryForInjustice()
		mind.RegisterForUpdateChanceDefiant()
		mind.RegisterForUpdateChanceAfraid()
		mind.RegisterForUpdateChanceLoyal()
		mind.RegisterForUpdateChanceHappy()
		mind.RegisterForUpdateChanceCharmed()
	EndFunction
EndProperty

Float __dirty_level = 0.0
Float Property dirty_level Hidden
	Float Function get()
		return __dirty_level
	EndFunction
	Function set(Float value)
		if value < 0.0
			value = 0.0
		elseif value > 100.0
			value = 100.0
		endif
		if value == __dirty_level
			return
		endif
		if value > __dirty_level
			if value > 90.0
				if mind.HasNextPraiseReason(30)
					mind.RemoveNextPraiseReason(30) ; "being clean and fresh"
				endif
				mind.SetNextPunishmentReasonOnceMessage(29, getname()+" starts to stink") ; "being dirty"
			elseif value > 50.0
				if mind.HasNextPraiseReason(30)
					mind.RemoveNextPraiseReason(30) ; "being clean and fresh"
				endif
			endif
		endif
		__dirty_level = value
		SetIntFaction(akRef,DOM01.DOMDirtiness, __dirty_level as int)
		; Update dependencies
	EndFunction
EndProperty

Float __wet_level = 0.0
Float Property wet_level Hidden
	Float Function get()
		float value = StorageUtil.GetFloatValue(akRef, "WetFunction_Actor_wetness")
		float wetnessCap = StorageUtil.GetFloatValue(DOM01.DOMBath.WetReduxMCM, "wetnessCap")
		if wetnessCap > 0.0
			;*ogTrace("ResetWetness to "+value+" / "+wetnessCap+" was "+__wet_level)
			value = value/wetnessCap
			__wet_level = value
			;*ogTrace("ResetWetness to "+value+" now "+__wet_level)
		endif
		return __wet_level
	EndFunction
	Function set(Float value)
		if value < 0.0
			value = 0.0
		elseif value > 1.0
			value = 1.0
		endif
		if value == __wet_level
			return
		endif
		DOM01.DOMBath.SetWetness(akRef,value) ; 1.0 is max wetness
		;*ogTrace("SetWetness to "+value)
		__wet_level = value
		;SetIntFaction(akRef,DOM01.DOMWetness, __wet_level*100.0 as int)
		; Update dependencies
	EndFunction
EndProperty

Float __has_body_armor = 0.0
Float Property has_body_armor Hidden
	Float Function get()
		return __has_body_armor
	EndFunction
	Function set(Float value)
		if __has_body_armor == value
			return
		endif
		__has_body_armor = value
		SetIntFaction(akRef,DOM01.DOMHasBodyArmor, __has_body_armor as int)
		; Update dependencies
		mind.RegisterForUpdateChanceRunAway()
		mind.RegisterForUpdateChanceRunAwayGang()
		mind.RegisterForUpdateChanceAfraid()
		mind.RegisterForUpdateChanceSad()
		mind.RegisterForUpdateChanceLoyal()
	EndFunction
EndProperty

Float __has_armor = 0.0
Float Property has_armor Hidden
	Float Function get()
		return __has_armor
	EndFunction
	Function set(Float value)
		if __has_armor == value
			return
		endif
		__has_armor = value
		SetIntFaction(akRef,DOM01.DOMHasArmor, __has_armor as int)
		; Update dependencies
	EndFunction
EndProperty

Float __has_shield = 0.0
Float Property has_shield Hidden
	Float Function get()
		return __has_shield
	EndFunction
	Function set(Float value)
		if __has_shield == value
			return
		endif
		__has_shield = value
		SetIntFaction(akRef,DOM01.DOMHasShield, __has_shield as int)
		; Update dependencies
	EndFunction
EndProperty

bool __has_shame_clothes = false
bool Property has_shame_clothes Hidden
	bool Function get()
		return __has_shame_clothes
	EndFunction
	Function set(bool value)
		__has_shame_clothes = value
		; Update dependencies
		is_shamed = IsShamed()
	EndFunction
EndProperty

bool __has_lingerie = false
bool Property has_lingerie Hidden
	bool Function get()
		return __has_lingerie
	EndFunction
	Function set(bool value)
		__has_lingerie = value
		LogTrace("Changing lingerie status has_lingerie="+__has_lingerie)
		; Update dependencies
		is_shamed = IsShamed()
	EndFunction
EndProperty

bool __has_heels = false
bool Property has_heels Hidden
	bool Function get()
		return __has_heels
	EndFunction
	Function set(bool value)
		__has_heels = value
		LogTrace("Changing heels status has_heels="+__has_heels)
		; Update dependencies
	EndFunction
EndProperty

bool __is_restrained = false
bool Property is_restrained Hidden
	bool Function get()
		return __is_restrained
	EndFunction
	Function set(bool value)
		__is_restrained = value
		; Update dependencies
		mind.RegisterForUpdateChanceAngry()
		mind.RegisterForUpdateChanceJealous()
		mind.RegisterForUpdateChanceSad()
		mind.RegisterForUpdateChanceDepressed()
		mind.RegisterForUpdateChanceHappy()
		SetBoolFaction(akRef,DOM01.DOMZaz.DOMHasRestrains, __is_restrained)
	EndFunction
EndProperty

bool __is_bounded = false
bool Property is_bounded Hidden
	bool Function get()
		;*ogTrace("is_bounded="+__is_bounded+" is_restrained="+__is_restrained+" has_cuffs_back="+__has_cuffs_back+" has_cuffs_boxtied="+__has_cuffs_boxtied+" has_cuffs_front="+__has_cuffs_front+" has_yoke="+__has_yoke+" has_armbinder="+__has_armbinder+" has_arms_device="+__has_arms_device)
		if __is_restrained
			return true
		endif
		if IsCuffed()
			return true
		endif
		if __has_arms_device || __has_cuffs
			return true
		endif
		return __is_bounded
	EndFunction
	Function set(bool value)
		if value == __is_bounded
			return
		endif
		__is_bounded = value
		; Update dependencies
		mind.RegisterForUpdateChanceAngry()
		mind.RegisterForUpdateChanceDefiant()
		mind.RegisterForUpdateChanceJealous()
		mind.RegisterForUpdateChanceSad()
		mind.RegisterForUpdateChanceDepressed()
		mind.RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

bool Property is_jailed = false Auto Hidden

bool __is_leashed = false
bool Property is_leashed Hidden
	bool Function get()
		if __is_leashed
			return true
		endif
		return false
	EndFunction
	Function set(bool value)
		if !__is_leashed && value
			;LogTrace("is_leashed.Set() true")
			__is_leashed = true
			OnLeashed()
			SetBoolFaction(akRef, DOM01.DOMIsLeashed, __is_leashed)
			akRef.AddSpell(DOM01.DOMLeashSpell)
		elseif __is_leashed && !value
			;LogTrace("is_leashed.Set() false")
			__is_leashed = false
			OnUnleashed()
			SetBoolFaction(akRef, DOM01.DOMIsLeashed, __is_leashed)
			akRef.RemoveSpell(DOM01.DOMLeashSpell)
		endif
		; Update dependencies
	EndFunction
EndProperty

Float __has_jewelry = -1.0
Float Property has_jewelry Hidden
	Float Function get()
		return __has_jewelry
	EndFunction
	Function set(Float value)
		__has_jewelry = value/50.0
		; Update dependencies
		SetIntFaction(akRef,DOM01.DOMHasJewelry, __has_jewelry as int)
		mind.RegisterForUpdateChanceInLove()
		mind.RegisterForUpdateChanceHappy()
		mind.RegisterForUpdateChanceCharmed()
	EndFunction
EndProperty

int __has_gold = -1
int Property has_gold Hidden
	int Function get()
		return __has_gold
	EndFunction
	Function set(int value)
		if __has_gold == value
			return
		endif
		__has_gold = value
		; Update dependencies
		mind.RegisterForUpdateChanceInLove()
		mind.RegisterForUpdateChanceHappy()
		mind.RegisterForUpdateChanceCharmed()
	EndFunction
EndProperty

bool Function IsShamed()
	if is_naked
		;*ogTrace("IsShamed naked")
		return true
	endif
	if has_shame_clothes
		;*ogTrace("IsShamed has shame clothes")
		return true
	endif
	if has_lingerie
		;*ogTrace("IsShamed has lingerie")
		return true
	endif
	if is_bounded ; && cuffs_material > 2 ; should be shamed if using some shameful tie pose
		;*ogTrace("IsShamed restrained")
		return true
	endif
	return false
EndFunction

Function SetNakedStatus()
	LogEquip("SetNakedStatus previously is_naked="+is_naked)
	is_naked =  !(DOM01.DOMEquip.HasEquippedClothes(akRef)) ; has_petsuit || has_dd_suit || akRef.WornHasKeyword(DOM01.ArmorCuirass) || akRef.WornHasKeyword(DOM01.DOMEquip.ClothingBody)
	LogEquip("SetNakedStatus now is_naked="+is_naked)
EndFunction

Function SetBondageDeviceStatus()	
	LogEquip("SetBondageDeviceStatus start leash="+has_leash+" device="+has_device+" gag="+has_mouth_gag+" blind="+has_blindfold+" plugv="+has_plug_vaginal+" pluga="+has_plug_anal)
	has_leash  = DOM01.DOMZaz.wornLeash(akRef)
	has_device = DOM01.DOMZaz.wornDevice(akRef) ; Generic device against running away
	LogEquip("SetBondageDeviceStatus0 has_leash="+has_leash+" has_device="+has_device)
	if DOM01.DOMPAH.wornDwarvenDevice(akRef)
		has_dwarven_device = true
	else
		has_dwarven_device = false
	endif
	
	has_dd_suit = DOM01.DOMZad.wornDeviousSuit(akRef)
	has_petsuit = DOM01.DOMZad.wornPetSuit(akRef)
	has_straitjacket = DOM01.DOMZad.wornStraitJacket(akRef)
	has_armbinder = DOM01.DOMZaz.wornArmbinder(akRef)
	has_yoke = DOM01.DOMZaz.wornYoke(akRef)
	has_cuffs = DOM01.DOMZaz.wornCuffs(akRef)
	LogTrace("SetBondageDeviceStatus has_cuffs="+__has_cuffs)
	has_disablekick = DOM01.DOMZad.wornDisableKick(akRef)
		
	if has_dwarven_device || has_disablekick || has_armbinder || has_yoke || has_straitjacket || has_petsuit || has_dd_suit
		has_arms_device = true
		mind.CheckAndRegisterKink(21,2.0) ; "wearing a bondage device"
	else
		has_arms_device = false
	endif

	has_plug_vaginal = DOM01.DOMZaz.wornPlugVaginal(akRef)
	has_plug_anal = DOM01.DOMZaz.wornPlugAnal(akRef)
	
	if has_plug_vaginal
		mind.CheckAndRegisterKink(17,2.0) ; "wearing a vaginal plug"
	endif
	if has_plug_anal
		mind.CheckAndRegisterKink(16,2.0) ; "wearing an anal plug"
	endif

	LogEquip("SetBondageDeviceStatus1 has_collar="+has_collar)
	has_collar = DOM01.DOMZaz.wornCollar(akRef)
	LogEquip("SetBondageDeviceStatus2 has_collar="+has_collar)
	if has_collar
		mind.CheckAndRegisterKink(20,2.0) ; "being collared"
	endif

	has_blindfold = DOM01.DOMZaz.wornBlindfold(akRef)
	if has_blindfold
		mind.CheckAndRegisterKink(19,2.0) ; "being blindfolded"
	endif
	
	has_mouth_gag = DOM01.DOMZaz.wornMouthGag(akRef)
	if has_mouth_gag
		mind.CheckAndRegisterKink(18,2.0) ; "being gagged"
	endif
	
	if Game.GetModByName("Dawnguard.esm") != 255
		if has_mouth_gag
			if akRef.IsInFaction(DOM01.DLC1ThrallFaction) && (akRef.GetVoiceType() == DOM01.MaleNord || akRef.GetVoiceType() == DOM01.FemaleNord)
				akRef.RemoveFromFaction(DOM01.DLC1ThrallFaction)
			endif
		endif
	endif
	LogEquip("SetBondageDeviceStatus end leash="+has_leash+" device="+has_device+" gag="+has_mouth_gag+" blind="+has_blindfold+" plugv="+has_plug_vaginal+" pluga="+has_plug_anal)
EndFunction

Function SetWeaponStatus()
	float x = (HasEquippedWeapon(akRef)) as float
	has_weapon = x
	LogEquip("SetWeaponStatus: "+name+" has_weapon="+has_weapon)	
EndFunction

Function SetArmorStatus()
	float x = HasEquippedBodyArmor(akRef)
	has_body_armor = x
	float y = HasEquippedShield(akRef)
	has_shield = y
	float z = x+HasEquippedHeadArmor(akRef)+HasEquippedHandsArmor(akRef)+HasEquippedFeetArmor(akRef)
	has_armor = z
	LogEquip("SetArmorStatus: "+name+" has_body_armor="+has_body_armor+" has_shield="+has_shield+" has_armor="+has_armor)	
EndFunction

Function SetShameClothesStatus()
	has_shame_clothes = DOM01.DOMEquip.HasShameClothes(akRef)
	LogEquip("SetShameClothesStatus: "+name+" has_shame_clothes="+has_shame_clothes)	
	; Check for lingerie and heels
	if akRef.hasKeyword(DOM01.DOMEquip.ClothingLingerie)
		LogTrace("has lingerie keyword")
		if !has_lingerie
			has_lingerie = true
			mind.CheckAndRegisterKink(81,0.5) ; wearing lingerie
		endif
	else 
		has_lingerie = false
	endif
	if akRef.hasKeyword(DOM01.DOMEquip.ClothingHeels)
		LogTrace("has heels keyword")
		if !has_heels
			has_heels = true
			mind.CheckAndRegisterKink(82,0.5) ; wearing heels
		endif
	else 
		has_heels = false
	endif
EndFunction

Function SetBoundStatus()
	LogTrace("SetBoundStatus start "+name+" wait_for_equipment="+wait_for_equipment)	
	is_bounded = DOM01.DOMZaz.wornRestraints(akRef) ; but might be able to move
	LogTrace("SetBoundStatus is_bounded="+is_bounded)	
	if is_restrained 
		return
	endif
	if !IsCuffed()
		if equipped_cuffs == None
			equipped_cuffs = DOM01.DOMZaz.GetEquippedCuffs(akRef)
		endif
		if equipped_cuffs != None
			SetCuffsStatus()
			LogTrace("SetBoundStatus 1 Anim_IdleReset")
			Anim_IdleReset()
		endif
	elseif equipped_cuffs == None
		equipped_cuffs = DOM01.DOMZaz.GetEquippedCuffs(akRef)
		LogTrace("SetBoundStatus 2 equipped_cuffs="+equipped_cuffs)
		if equipped_cuffs != None
			SetCuffsStatus()
		else
			has_cuffs_back = false
			has_cuffs_boxtied = false
			has_cuffs_crossed = false
			has_cuffs_front = false
			has_yoke        = false
			has_armbinder   = false
		endif
		LogTrace("SetBoundStatus 2 Anim_IdleReset")
		Anim_IdleReset()
	else
		Form current_cuffs = DOM01.DOMZaz.GetEquippedCuffs(akRef)
		if current_cuffs == None
			has_cuffs_back = false
			has_cuffs_boxtied = false
			has_cuffs_crossed = false
			has_cuffs_front = false
			has_yoke        = false
			has_armbinder   = false
			LogTrace("SetBoundStatus 3 Anim_IdleReset")
			Anim_IdleReset()			
		elseif current_cuffs != equipped_cuffs
			equipped_cuffs = current_cuffs
			SetCuffsStatus()
			LogTrace("SetBoundStatus 4 Anim_IdleReset")
			Anim_IdleReset()
		endif
	endif
	LogTrace("SetBoundStatus end "+name+" wait_for_equipment="+wait_for_equipment+" is_bounded="+is_bounded)	
EndFunction

Function SetJewelryStatus()
	float p_has_gold = has_gold
	has_gold = DOM01.DOMEquip.HasGold(akRef)
	float p_has_jewelry = has_jewelry
	has_jewelry = (DOM01.DOMEquip.HasJewelry(akRef)) as float
	LogEquip("SetJewelryStatus: "+name+" has_jewelry before="+p_has_jewelry+" now="+has_jewelry+" init="+is_initializing)	
	float diff
	if p_has_jewelry < 0.0
		diff = 0.0
	else
		diff = p_has_jewelry-has_jewelry
	endif
	if diff > 1.0
		; Slave is not happy has_jewelry was taken
		float amount = diff ; 1 point every 50 gold
		if amount > 50.0
			amount = 50.0
		elseif amount < 1.0 && diff >= 10.0 ; starts to react at 10 gold value for jewelry
			amount = 1.0
		endif
		if !is_initializing && amount >= 1.0
			mind.MakeAngryForTaken(amount)
		endif
	elseif diff < 0.0
		; Slave could be flattered has_jewelry was given
		float amount = (-diff)/2.0 ; 1 point every 100 gold
		if amount > 25.0
			amount = 25.0
		endif
		if !is_initializing && amount >= 1.0 ; starts to react at 100 gold value for jewelry
			mind.MakeFlatteredForGreed(amount)
			if !DOM01.DOMEquip.stripJewelryToggle || !mind.should_be_naked ; only if actually wearing the jewelry
				mind.CheckAndRegisterKink(83,0.25) ; wearing jewelry
			endif
		endif
	endif
	if p_has_gold < 0.0
		diff = 0.0
	else
		diff = p_has_gold-has_gold
	endif
	if diff > 1.0
		; Slave is not happy gold was taken
		float amount = diff/50.0 ; 1 point every 50 gold
		if amount > 50.0
			amount = 50.0
		elseif amount < 1.0 && diff >= 5.0 ; starts to react at 5 gold
			amount = 1.0
		endif
		if !is_initializing && amount >= 1.0
			mind.MakeAngryForTaken(amount)
		endif
	elseif diff < 0.0
		; Slave could be flattered gold was given
		float amount = (-diff)/100.0 ; 1 point every 100 gold
		if amount > 25.0
			amount = 25.0
		endif
		if !is_initializing && amount >= 0.5 ; starts to react at 50 gold
			mind.MakeFlatteredForGreed(amount)
		endif
	endif
EndFunction

Function OpenInventory()
	LogEquip("OpenInventory wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	if equip_inventory_busy
		__equip_inventory_cancel = true
	endif
	is_inventory_open = true
	akRef.OpenInventory(true)
	Wait(0.01) ; Wait for inventory menu to close
	CloseInventory()
EndFunction

Function CloseInventory()
	LogEquip("CloseInventory changed="+was_inventory_changed+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	is_inventory_open = false
	if is_initializing || akRef == None || mind == None ; intiliazing actor
		return
	endif
	TryEquipInventory(false) 
EndFunction

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem == None || mind == None || mind.is_player_actor || akRef == PlayerRef
 		return
	endif
	LogEquip("OnItemAdded item="+akBaseItem.GetName()+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	if is_initializing || before_clear_is_busy || akRef == None ; ignore
		LogEquip("OnItemAdded item="+akBaseItem.GetName()+" BUSY")
		return
	endif
	if alcohol_gift
		LogEquip("OnItemAdded Slave was gifted alcohol "+akBaseItem.getName())
		OrderDrinkForm(PlayerRef,akBaseItem)
		alcohol_gift = false
		return
	endif
	if equip_inventory_busy || wait_for_equipment || is_on_duty ; inventory is being equipped or another mod is in charge
		LogEquip("OnItemAdded item="+akBaseItem.GetName()+" WAITING")
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(akBaseItem) || !isWearable(akBaseItem)
		LogEquip("OnItemAdded item="+akBaseItem.GetName()+" IGNORE")
		return
	endif
	if DOM01.DOMZAD.hasKeywordDevice(akBaseItem)
		return ; do not equip ZAD devices
	endif
	was_inventory_changed = true
	if is_inventory_open && !DOM01.DOMEquip.instantEquipToggle ; player is giving item to actor
		LogEquip("OnItemAdded item="+akBaseItem.GetName()+" INVENTORY OPEN AND NOT EQUIPPING")
		return
	endif
	if !is_inventory_open ; actor picked up an item?
		LogEquip("OnItemAdded item="+akBaseItem.GetName()+" ITEM PICKED UP")
		DOM01.DOMEquip.equipItemWearable(akRef, akBaseItem, (poseID == 99), mind.should_be_naked, mind.should_wear_armor, mind.should_hold_weapons)
		QueueNiNodeUpdate()
		if DOM01.DOMZaz.IsItemRestraint(akBaseItem)
			OnApplyEquipmentEffects()
			LogTrace("OnItemAdded Anim_IdleReset")
			Anim_IdleReset()
		else ; no hurry just send an event
			ApplyEquipmentEffects()
		endif
		return 
	endif
	LogEquip("OnItemAdded item="+akBaseItem.GetName()+" INVENTORY OPEN AND EQUIPPING")
	wait_for_equipment = true
	DOM01.DOMEquip.equipItemWearable(akRef, akBaseItem, (poseID == 99), mind.should_be_naked, mind.should_wear_armor, mind.should_hold_weapons)
	QueueNiNodeUpdate()
	wait_for_equipment = false
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)		
	if akBaseItem == None || mind == None || mind.is_player_actor
 		return
	endif
	LogEquip("OnItemRemoved item="+akBaseItem.GetName()+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	if is_initializing || before_clear_is_busy || akRef == None ; ignore
		LogEquip("OnItemRemoved item="+akBaseItem.GetName()+" BUSY")
		return
	endif
	if equip_inventory_busy || wait_for_equipment || is_on_duty ; inventory is being equipped
		LogEquip("OnItemRemoved item="+akBaseItem.GetName()+" WAITING")
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(akBaseItem) || !isWearable(akBaseItem)
		LogEquip("OnItemRemoved item="+akBaseItem.GetName()+" IGNORE")
		return
	endif
	was_inventory_changed = true
	if is_inventory_open && !DOM01.DOMEquip.instantUnEquipToggle ; player is taking item from actor
		LogEquip("OnItemRemoved item="+akBaseItem.GetName()+" INVENTORY OPEN AND NOT RE-EQUIPPING")
		return
	endif
	if !is_inventory_open ; actor dropped up an item?
		LogEquip("OnItemRemoved item="+akBaseItem.GetName()+" ITEM DROPPED")
		if DOM01.DOMZaz.IsItemRestraint(akBaseItem)
			OnApplyEquipmentEffects()
			LogTrace("OnItemRemoved Anim_IdleReset")
			Anim_IdleReset()
		else ; no hurry just send an event
			ApplyEquipmentEffects()
		endif
		return 
	endif
	LogEquip("OnItemRemoved item="+akBaseItem.GetName()+" INVENTORY OPEN AND RE-EQUIPPING")
	EquipInventoryNow(false) ; no anim, do not send event
	QueueNiNodeUpdate()
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if akBaseObject == None || mind == None || mind.is_player_actor
		return 
	endif
	LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	if is_initializing || before_clear_is_busy || akRef == None ; ignore
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" BUSY")
		return
	endif
	if equip_inventory_busy || wait_for_equipment  || is_inventory_open || is_on_duty ; inventory is being equipped
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" WAITING")
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(akBaseObject) || !isWearable(akBaseObject)
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" IGNORE")
		return
	endif
	if DOM01.DOMEquip.IsItemDevice(akBaseObject) || DOM01.DOMEquip.IsItemSpecial(akBaseObject)
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" DEVICE")
		return
	endif
	if is_working && (DOM01.DOMEquip.IsWeaponMineTool(akBaseObject) || DOM01.DOMEquip.IsCleaningTool(akBaseObject))
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" TOOL")
		return 
	endif
	if is_training && DOM01.DOMZaz.IsWeaponPunishment(akBaseObject)
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" WHIP")
		return 
	endif
	if DOM01.DOMEquip.IsLight(akBaseObject)
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" LIGHT")
		return 
	endif
	; Actor equipped item without being told?
	LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" UNEXPECTED EQUIP")
	if mind.should_be_naked || !(mind.should_wear_armor) || !(mind.should_hold_weapons)
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" CHECK")
		wait_for_equipment = true
		DOM01.DOMEquip.equipItemWearable(akRef, akBaseObject, (poseID == 99), mind.should_be_naked, mind.should_wear_armor, mind.should_hold_weapons)
		QueueNiNodeUpdate()
		wait_for_equipment = false
	endif
EndEvent

Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)
	if akBaseObject == None || mind == None || mind.is_player_actor
		return 
	endif
	LogEquip("OnObjectUnEquipped item="+akBaseObject.GetName()+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	if is_initializing || before_clear_is_busy || akRef == None ; ignore
		LogEquip("OnObjectUnEquipped item="+akBaseObject.GetName()+" BUSY")
		return
	endif
	if equip_inventory_busy || wait_for_equipment  || is_inventory_open || is_on_duty ; inventory is being equipped
		LogEquip("OnObjectUnEquipped item="+akBaseObject.GetName()+" WAITING")
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(akBaseObject) || !isWearable(akBaseObject)
		LogEquip("OnObjectUnEquipped item="+akBaseObject.GetName()+" IGNORE")
		return
	endif
	if DOM01.DOMEquip.IsItemDevice(akBaseObject) || DOM01.DOMEquip.IsItemSpecial(akBaseObject)
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" DEVICE")
		return
	endif
	if is_working && (DOM01.DOMEquip.IsWeaponMineTool(akBaseObject) || DOM01.DOMEquip.IsCleaningTool(akBaseObject))
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" TOOL")
		return 
	endif
	if is_training && DOM01.DOMZaz.IsWeaponPunishment(akBaseObject)
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" WHIP")
		return 
	endif
	if DOM01.DOMEquip.IsLight(akBaseObject)
		LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" TORCH")
		return 
	endif
	; Actor unequipped item without being told?
	LogEquip("OnObjectEquipped item="+akBaseObject.GetName()+" UNEXPECTED UNEQUIP")
EndEvent

Function UnequipAll()
	if akRef == None
		return
	endif
	LogEquip("UnequipAll wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	wait_for_equipment = true
	akRef.UnequipAll()
	wait_for_equipment = false
	was_inventory_changed = true
	ApplyEquipmentEffects()
EndFunction

; equipinventory and check for punishment reasons
Function EquipInventoryNow(bool do_anim=false) ; equip inventory without sending event
	if mind == None
		return
	endif
	if mind.is_player_actor
		return
	endif
	if !was_inventory_changed
		wait_for_equipment = false
		return
	endif
	if !canIdleSexlab
		return
	endif
	float do_msg=0.0
	if do_anim
		do_msg=0.5
		if !is_naked
			LogEquip("EquipInventoryNow Not naked is_naked="+is_naked+" is_running_away="+is_running_away)
			if is_running_away
				if has_body_armor_in_inventory && !(has_body_armor > 1.0)
					SendOrderAnimateDressUp()
				endif
			elseif mind.should_be_naked
				SendOrderAnimateStrip()
			elseif mind.should_wear_armor && has_body_armor_in_inventory && !(has_body_armor > 1.0)
				SendOrderAnimateDressUp()
			endif
		elseif is_running_away ; and is naked
			LogEquip("EquipInventoryNow Running away is_naked="+is_naked+" is_running_away="+is_running_away)
			if has_clothes_in_inventory || has_body_armor_in_inventory
				SendOrderAnimateDressUp()
			endif
		elseif !mind.should_be_naked; and is naked
			LogEquip("EquipInventoryNow Naked is_naked="+is_naked+" has_clothes_in_inventory="+has_clothes_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
			if has_clothes_in_inventory
				SendOrderAnimateDressUp()
			elseif mind.should_wear_armor && has_body_armor_in_inventory
				SendOrderAnimateDressUp()
			endif
		endif
	endif
	
	LogEquip("EquipInventoryNow changed="+was_inventory_changed+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	LogEquip("EquipInventoryNow should wear armor="+mind.should_wear_armor+" should_hold_weapons="+mind.should_hold_weapons+" should_be_naked="+mind.should_be_naked)
	LogEquip("EquipInventoryNow has_clothes_in_inventory="+has_clothes_in_inventory+" has_armor_in_inventory="+has_armor_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
	OnEquipInventory(numArg=do_msg)

	LogEquip("EquipInventoryNow end init="+is_initializing+" anim="+do_anim+" is_naked="+is_naked)
EndFunction

; equipinventory (reason=2 means without checking if should wear clothes) and check for punishment reasons
Function EquipInventoryNowForced(int reason=1, string msg="", bool do_anim=true)
	if mind == None
		return
	endif
	if mind.is_player_actor
		return
	endif
	was_inventory_changed = true
	if !canIdleSexlab
		return
	endif
	if do_anim
		if !is_naked
			if has_body_armor_in_inventory && !(has_body_armor > 1.0)
				SendOrderAnimateDressUp()
			endif
		elseif has_clothes_in_inventory || has_body_armor_in_inventory
			SendOrderAnimateDressUp()
		endif
	endif

	LogEquip("EquipInventoryNowForced changed="+was_inventory_changed+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	LogEquip("EquipInventoryNowForced should wear armor="+mind.should_wear_armor+" should_hold_weapons="+mind.should_hold_weapons+" should_be_naked="+mind.should_be_naked)
	LogEquip("EquipInventoryNowForced has_clothes_in_inventory="+has_clothes_in_inventory+" has_armor_in_inventory="+has_armor_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
	OnEquipInventory(strArg=msg,numArg=(reason as float))
	
	LogEquip("EquipInventoryNowForced anim init="+is_initializing+" should_be_naked="+mind.should_be_naked)
	LogEquip("EquipInventoryNowForced end init="+is_initializing)
EndFunction

; equipinventory without checking for punishment reasons or if running away
Function EquipInventoryNowQuiet(bool do_anim=false) ; this to use for sexlab and before animations
	;LogTrace("EquipInventoryNowQuiet start init="+is_initializing+" anim="+do_anim+" busy="+equip_inventory_busy+" changes="+was_inventory_changed+" wait="+wait_for_equipment+" should be naked="+mind.should_be_naked+" should wear armor="+mind.should_wear_armor+" should hold weapons="+mind.should_hold_weapons+" changes="+was_inventory_changed)
	if mind == None
		return
	endif
	if mind.is_player_actor
		return
	endif
	if !was_inventory_changed
		wait_for_equipment = false
		return
	endif
	if !canIdleSexlab
		return
	endif
	float do_msg=0.0
	if do_anim
		do_msg=0.5
		LogEquip("EquipInventoryNowQuiet anim init="+is_initializing+" should_be_naked="+mind.should_be_naked)
		if !is_naked
			if mind.should_be_naked
				SendOrderAnimateStrip()
			elseif mind.should_wear_armor && has_body_armor_in_inventory && !(has_body_armor > 1.0)
				SendOrderAnimateDressUp()
			endif
		elseif !mind.should_be_naked; and is naked
			if has_clothes_in_inventory
				SendOrderAnimateDressUp()
			elseif mind.should_wear_armor && has_body_armor_in_inventory
				SendOrderAnimateDressUp()
			endif
		endif
	endif

	LogEquip("EquipInventoryNowQuiet changed="+was_inventory_changed+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	LogEquip("EquipInventoryNowQuiet should wear armor="+mind.should_wear_armor+" should_hold_weapons="+mind.should_hold_weapons+" should_be_naked="+mind.should_be_naked)
	LogEquip("EquipInventoryNowQuiet has_clothes_in_inventory="+has_clothes_in_inventory+" has_armor_in_inventory="+has_armor_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
	OnEquipInventoryQuiet(numArg=do_msg)

	LogEquip("EquipInventoryNowQuiet end init="+is_initializing+" anim="+do_anim)
EndFunction

; equipinventory without checking for effects and without checking for punishment reasons or if running away
Function EquipInventoryNowNoApply(bool do_anim=false) ; this to use for sexlab and before animations
	;LogTrace("EquipInventoryNowNoApply start init="+is_initializing+" anim="+do_anim+" busy="+equip_inventory_busy+" changes="+was_inventory_changed+" wait="+wait_for_equipment+" should be naked="+mind.should_be_naked+" should wear armor="+mind.should_wear_armor+" should hold weapons="+mind.should_hold_weapons+" changes="+was_inventory_changed)
	if mind == None
		return
	endif
	if mind.is_player_actor
		return
	endif
	if !was_inventory_changed
		wait_for_equipment = false
		return
	endif
	if !canIdleSexlab
		return
	endif
	float do_msg=0.0
	if do_anim
		do_msg=0.5
		LogEquip("EquipInventoryNowQuiet anim init="+is_initializing+" should_be_naked="+mind.should_be_naked)
		if !is_naked
			if mind.should_be_naked
				SendOrderAnimateStrip()
			elseif mind.should_wear_armor && has_body_armor_in_inventory && !(has_body_armor > 1.0)
				SendOrderAnimateDressUp()
			endif
		elseif !mind.should_be_naked; and is naked
			if has_clothes_in_inventory
				SendOrderAnimateDressUp()
			elseif mind.should_wear_armor && has_body_armor_in_inventory
				SendOrderAnimateDressUp()
			endif
		endif
	endif

	LogEquip("EquipInventoryNowNoApply changed="+was_inventory_changed+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	LogEquip("EquipInventoryNowNoApply should wear armor="+mind.should_wear_armor+" should_hold_weapons="+mind.should_hold_weapons+" should_be_naked="+mind.should_be_naked)
	LogEquip("EquipInventoryNowNoApply has_clothes_in_inventory="+has_clothes_in_inventory+" has_armor_in_inventory="+has_armor_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
	OnEquipInventoryNoApply(numArg=do_msg)

	LogEquip("EquipInventoryNowQuiet end init="+is_initializing+" anim="+do_anim)
EndFunction

; Equip inventory, apply effects and reasons for punishments if needed
Event OnEquipInventory(string eventName = "", string strArg = "", float numArg = 0.0, Form sender = None)
	if !was_inventory_changed
		wait_for_equipment = false
		return
	endif
	if !canIdleSexlab
		return
	endif

	ActorBase abRef = akRef.GetLeveledActorBase()
	Outfit the_outfit = abRef.GetOutfit()
	LogEquip("OnEquipInventory outfit="+the_outfit+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	LogEquip("OnEquipInventory should wear armor="+mind.should_wear_armor+" should_hold_weapons="+mind.should_hold_weapons+" should_be_naked="+mind.should_be_naked)
	LogEquip("OnEquipInventory has_clothes_in_inventory="+has_clothes_in_inventory+" has_armor_in_inventory="+has_armor_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
	equip_inventory_busy = true
	wait_for_equipment = true
	bool was_naked = is_naked
	bool had_armor = (has_armor > 1.0)
	bool hold_weapons = mind.should_hold_weapons && (!is_restrained)
	int type_equip
	if numArg >= 1.0 || is_running_away ; equip without taking account master orders
		type_equip = EquipInventory() ; equip default inventory FORCED!
	else
		type_equip = EquipInventory((poseID == 99),mind.should_be_naked,mind.should_wear_armor,hold_weapons)
	endif
	if (type_equip%2) == 1 ; clothes
		has_clothes_in_inventory = true
	else
		has_clothes_in_inventory = false
	endif
	if ((type_equip/2)%2) == 1 ; armor
		has_armor_in_inventory = true
	else
		has_armor_in_inventory = false
	endif
	if ((type_equip/4)%2) == 1
		has_shield_in_inventory = true
	else
		has_shield_in_inventory = false
	endif
	if ((type_equip/8)%2) == 1
		has_weapon_in_inventory = true
	else
		has_weapon_in_inventory = false
	endif
	; 16 is ammo
	if ((type_equip/32)%2) == 1 ; cuirass
		has_body_armor_in_inventory = true
	else
		has_body_armor_in_inventory = false
	endif
	LogEquip("OnEquipInventory OnApplyEquipmentEffects init="+is_initializing+" busy="+equip_inventory_busy+" changes="+was_inventory_changed+" wait="+wait_for_equipment+" should be naked="+mind.should_be_naked+" should wear armor="+mind.should_wear_armor+" should hold weapons="+mind.should_hold_weapons+" changes="+was_inventory_changed)
	OnApplyEquipmentEffects() ; wait for results
	LogEquip("OnEquipInventory arg="+numArg+" is_naked="+is_naked+" numArg="+numArg+" strArg="+strArg)

	if actorType == 0 ; not animal nor creature
		if numArg > 1 && strArg != "" ; set punishment reason
			LogEquip("OnEquipInventory Check for punishment reasons")
			if mind.should_be_naked
				if !is_naked && was_naked ; took on clothes
					mind.SetNextPunishmentReasonForceMessage((numArg as int),strArg) ; "covering self" by default
				endif
			elseif is_running_away
				if !is_naked && was_naked ; took on clothes
					mind.SetNextPunishmentReasonForceMessage((numArg as int),strArg) ; "covering self" by default
				elseif !had_armor && (has_armor > 1.0) ; took on armor
					mind.SetNextPunishmentReasonForceMessage((numArg as int),strArg) ; "covering self" by default
				endif
			endif
		elseif !is_running_away && numArg > 0.0 && !mind.should_be_naked ; dressing up following master orders
			if was_naked
				if !is_naked
					SendNotificationOrder(name+" hastily puts "+actorPossessive+" clothes back on")
				else
					SendNotificationOrder(name+" could use some clothes")
				endif
			;else
			;	SendNotificationOrder(name+" agrees and "+actorBeVerb+" now allowed to wear clothes")
			endif
		endif
	endif
	wait_for_equipment = false
	equip_inventory_busy = false
	LogEquip("OnEquipInventory end wait="+wait_for_equipment+" init="+is_initializing)
EndEvent

; Equip inventory, apply effects, no check for punishment reasons
Event OnEquipInventoryQuiet(string eventName = "", string strArg = "", float numArg = 0.0, Form sender = None)
	if !was_inventory_changed
		wait_for_equipment = false
		return
	endif
	if !canIdleSexlab
		return
	endif

	ActorBase abRef = akRef.GetLeveledActorBase()
	Outfit the_outfit = abRef.GetOutfit()
	LogEquip("OnEquipInventoryQuiet outfit="+the_outfit+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	LogEquip("OnEquipInventoryQuiet should wear armor="+mind.should_wear_armor+" should_hold_weapons="+mind.should_hold_weapons+" should_be_naked="+mind.should_be_naked)
	LogEquip("OnEquipInventoryQuiet has_clothes_in_inventory="+has_clothes_in_inventory+" has_armor_in_inventory="+has_armor_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
	equip_inventory_busy = true
	wait_for_equipment = true
	bool hold_weapons = mind.should_hold_weapons && (!is_restrained)
	EquipInventory(false,mind.should_be_naked,mind.should_wear_armor,hold_weapons)
	;if !mind.should_be_naked || mind.should_wear_armor || hold_weapons
	LogEquip("OnEquipInventoryQuiet OnApplyEquipmentEffects")
	OnApplyEquipmentEffects() ; getting redressed
	;endif
	wait_for_equipment = false
	equip_inventory_busy = false
	LogEquip("OnEquipInventoryQuiet end wait="+wait_for_equipment+" init="+is_initializing)
EndEvent

; Equip inventory, do not apply effects, no check for punishment reasons
Event OnEquipInventoryNoApply(string eventName = "", string strArg = "", float numArg = 0.0, Form sender = None)
	if !was_inventory_changed
		wait_for_equipment = false
		return
	endif
	if !canIdleSexlab
		return
	endif

	ActorBase abRef = akRef.GetLeveledActorBase()
	Outfit the_outfit = abRef.GetOutfit()
	LogEquip("OnEquipInventoryNoApply outfit="+the_outfit+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	LogEquip("OnEquipInventoryNoApply should wear armor="+mind.should_wear_armor+" should_hold_weapons="+mind.should_hold_weapons+" should_be_naked="+mind.should_be_naked)
	LogEquip("OnEquipInventoryNoApply has_clothes_in_inventory="+has_clothes_in_inventory+" has_armor_in_inventory="+has_armor_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
	equip_inventory_busy = true
	wait_for_equipment = true
	bool hold_weapons = mind.should_hold_weapons && (!is_restrained)
	EquipInventory(false,mind.should_be_naked,mind.should_wear_armor,hold_weapons)
	wait_for_equipment = false
	equip_inventory_busy = false
	LogEquip("OnEquipInventoryNoApply end wait="+wait_for_equipment+" init="+is_initializing)
EndEvent

int Function EquipInventory(bool use_light = false, bool should_be_naked = false, bool should_wear_armor = true, bool should_hold_weapons = true)
	if mind == None
		return 0
	endif
	if mind.is_player_actor
		return 0
	endif
	LogEquip("EquipInventory wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	LogEquip("EquipInventory should wear armor="+mind.should_wear_armor+" should_hold_weapons="+mind.should_hold_weapons+" should_be_naked="+mind.should_be_naked)
	LogEquip("EquipInventory has_clothes_in_inventory="+has_clothes_in_inventory+" has_armor_in_inventory="+has_armor_in_inventory+" has_body_armor_in_inventory="+has_body_armor_in_inventory)
	Form the_form
	int type_equip = 0
	int type
	if __equip_inventory_cancel
		Wait(0.5)
	endif
	__equip_inventory_cancel = false
	Int n = akRef.GetNumItems()
	Int i = n
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			if the_form.GetType() == 53 ; kLeveledItem 
				LogEquip("EquipInventory start "+name+" EquipLeveledItem "+the_form.GetName())
				DOM01.DOMEquip.equipLeveledItem(akRef,the_form)
			else
				LogEquip("EquipInventory start "+name+" EquipItemWearable "+the_form.GetName())
				type = DOM01.DOMEquip.equipItemWearable(akRef,the_form,use_light,should_be_naked,should_wear_armor,should_hold_weapons)
				if (type%2) == 1 &&  (type_equip%2) == 0
					type_equip += 1 ; clothes
				endif
				if ((type/2)%2) == 1 &&  ((type_equip/2)%2) == 0
					type_equip += 2 ; armor except cuirass and shield
				endif
				if ((type/4)%2) == 1 &&  ((type_equip/4)%2) == 0
					type_equip += 4 ; shield
				endif
				if ((type/8)%2) == 1 &&  ((type_equip/8)%2) == 0
					type_equip += 8 ; weapon
				endif
				if ((type/16)%2) == 1 &&  ((type_equip/16)%2) == 0
					type_equip += 16 ; ammo
				endif
				if ((type/32)%2) == 1 &&  ((type_equip/32)%2) == 0
					type_equip += 32 ; cuirass
				endif
				if ((type/64)%2) == 1 &&  ((type_equip/64)%2) == 0
					type_equip += 64 ; jewelry
				endif
			endif
		endif
		if __equip_inventory_cancel
			__equip_inventory_cancel = false
			;LogTrace("EquipInventory cancel "+name+" number of items="+(n-i)+"/"+n+" type_equip="+type_equip)
			return type_equip
		Else
			__equip_inventory_busy = true
		endif
	endwhile

	QueueNiNodeUpdate()
	LogEquip("EquipInventory end "+name+" number of items="+n+" type_equip="+type_equip)
	return type_equip
EndFunction

Function ApplyEquipmentEffects()
	LogEquip("ApplyEquipmentEffects changed="+was_inventory_changed+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	if wait_for_equipment || is_inventory_open
		return
	endif
	if equip_inventory_busy || __equip_inventory_cancel ; inventory is being equipped
		return
	endif
	if !was_inventory_changed
		return
	endif
	if DOM01.DOMEquip.sendDOMEquipEvent
		SendOrderApplyEquipmentEffects()
	else
		OnApplyEquipmentEffects()
	endif
	LogEquip("ApplyEquipmentEffects end")
EndFunction

Event OnApplyEquipmentEffects()
	LogEquip("OnApplyEquipmentEffects changed="+was_inventory_changed+" wait="+wait_for_equipment+" open="+is_inventory_open+" busy="+equip_inventory_busy+" init="+is_initializing+" clear="+before_clear_is_busy)
	if mind == None
		return
	endif
	SetBondageDeviceStatus() ; should be before naked status
	SetNakedStatus()
	SetWeaponStatus()
	SetArmorStatus()
	SetShameClothesStatus()
	SetBoundStatus()
	SetJewelryStatus()
	mind.UpdateRegistered()
	LogEquip("OnApplyEquipmentEffects end wait="+wait_for_equipment+" busy="+equip_inventory_busy+" cancel="+__equip_inventory_cancel)
	was_inventory_changed = false
EndEvent

Function EquipGag(Form the_gag = None)
	LogTrace("EquipGag "+the_gag)
	if the_gag == None
		the_gag = DOM01.DOMZaz.GetGagCloth()
		if the_gag == None
			return
		endif
	endif
	Form current_gag = DOM01.DOMZaz.GetEquippedGag(akRef)
	if current_gag == the_gag
		if akRef.IsEquipped(the_gag)
			if !has_mouth_gag
				has_mouth_gag = true
			endif
			return
		endif
		wait_for_equipment = true
		EquipItemTight(akRef,the_gag)
		wait_for_equipment = false
		if !has_mouth_gag
			has_mouth_gag = true
		endif
		return
	elseif current_gag != None
		UnEquipItemTight(akRef,the_gag)
		akRef.RemoveItem(the_gag)
	endif
	wait_for_equipment = true
	AddItemNoChange(akRef,the_gag)
	EquipItemTight(akRef,the_gag)
	wait_for_equipment = false
	has_mouth_gag = true
EndFunction

Function RemoveGag(bool should_drop=true)
	LogTrace("RemoveGag HasMouthGag="+DOM01.DOMZaz.wornMouthGag(akRef))
	Form the_gag = DOM01.DOMZaz.GetEquippedGag(akRef)
	if the_gag == None
		LogTrace("RemoveGag no gag found")
		has_mouth_gag = false
		return
	endif
	Actor akAbuser = None
	wait_for_equipment = true
	while the_gag != None
		int nitems = akRef.GetItemCount(the_gag)
		LogTrace("RemoveGag "+the_gag.getName()+" n="+nitems)
		if nitems > 0
			if akRef.IsEquipped(the_gag)
				UnEquipItemTight(akRef,the_gag)
			endif
			akRef.RemoveItem(the_gag,nitems,true,akAbuser)
		endif
		the_gag = DOM01.DOMZaz.GetEquippedGag(akRef)
		LogTrace("RemoveGag find other gag "+the_gag)
	endwhile
	wait_for_equipment = false
	LogTrace("RemoveGag MouthGag done")
	has_mouth_gag = false
EndFunction

Function EquipBlindfold(Form the_blindfold)
	if the_blindfold == None
		the_blindfold = DOM01.DOMZaz.GetBlindfold0()
		if the_blindfold == None
			return
		endif
	endif
	wait_for_equipment = true
	AddItemNoChange(akRef,the_blindfold)
	EquipItemTight(akRef,the_blindfold)
	wait_for_equipment = false
	has_blindfold = true
EndFunction

Function RemoveBlindfold(Actor akAbuser, bool should_drop=true)
	LogEquip("RemoveBlindfold HasBlindfold="+has_blindfold+" akRef="+akRef+" akAbuser="+akAbuser)
	if !DOM01.DOMZaz.wornBlindfold(akRef)
		has_blindfold = false
		return
	endif
	
	Form the_blindfold = DOM01.DOMZaz.GetEquippedBlindfold(akRef)
	if the_blindfold != None
		UnEquipItemTight(akRef,the_blindfold)
		if should_drop
			if the_blindfold != DOM01.DOMZaz.GetBlindfold0() && akAbuser == PlayerRef && akAbuser.GetItemCount(the_blindfold) == 0
				akRef.RemoveItem(the_blindfold, akOtherContainer = akAbuser)
			else
				akRef.RemoveItem(the_blindfold)
			endif
		endif
	endif

	has_blindfold = false
EndFunction

Function EquipPlugAnal(Form the_plug = None)
	if the_plug == None
		the_plug       = DOM01.DOMZaz.GetPlugAnal()
		if the_plug == None
			return
		endif
	endif
	LogEquip("EquipPlugAnal plug="+the_plug)
	wait_for_equipment = true
	AddItemNoChange(akRef,the_plug)
	EquipItemTight(akRef,the_plug)
	wait_for_equipment = false
	has_plug_anal = true
EndFunction

Function RemovePlugAnal(Actor akAbuser, bool should_drop=true)
	if !DOM01.DOMZaz.wornPlugAnal(akRef)
		has_plug_anal = false
		return
	endif
	Int iPlugSlotMask = 0x00040000 ; kSlotMask48 ; Unnamed
	
	Form the_plug = akRef.GetWornForm(iPlugSlotMask)
	if the_plug != None
		if DOM01.DOMZaz.IsItemPlugAnal(the_plug)
			UnEquipItemTight(akRef,the_plug)
			if should_drop
				if the_plug != DOM01.DOMZaz.GetPlugAnal() && akAbuser == PlayerRef && akAbuser.GetItemCount(the_plug) == 0
					akRef.RemoveItem(the_plug, akOtherContainer = akAbuser)
				else
					akRef.RemoveItem(the_plug)
				endif
			endif
			has_plug_anal = false
			return
		endif
	endif

	; if not in slot, loop over items and return first item with Zaz keyword
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_plug = akRef.GetNthForm(i)
		if the_plug != None 
			if DOM01.DOMZaz.IsItemPlugAnal(the_plug)
				UnEquipItemTight(akRef,the_plug)
				if should_drop
					if the_plug != DOM01.DOMZaz.GetPlugAnal() && akAbuser == PlayerRef && akAbuser.GetItemCount(the_plug) == 0
						akRef.RemoveItem(the_plug, akOtherContainer = akAbuser)
					else
						akRef.RemoveItem(the_plug)
					endif
				endif
				has_plug_anal = false
			endif
		endif
	endWhile

	has_plug_anal = false
EndFunction

Function EquipPlugVaginal(Form the_plug = None)
	if the_plug == None
		the_plug       = DOM01.DOMZaz.GetPlugVaginal()
		if the_plug == None
			return
		endif
	endif
	wait_for_equipment = true
	AddItemNoChange(akRef,the_plug)
	EquipItemTight(akRef,the_plug)
	wait_for_equipment = false
	has_plug_vaginal = true
EndFunction

Function RemovePlugVaginal(Actor akAbuser, bool should_drop=true)
	if !DOM01.DOMZaz.wornPlugVaginal(akRef)
		has_plug_vaginal = false
		return
	endif
	Int iPlugSlotMask = 0x08000000 ; kSlotMask57 ; Unnamed
	
	Form the_plug = akRef.GetWornForm(iPlugSlotMask)
	if the_plug != None
		if DOM01.DOMZaz.IsItemPlugVaginal(the_plug)
			UnEquipItemTight(akRef,the_plug)
			if should_drop
				if the_plug != DOM01.DOMZaz.GetPlugVaginal() && akAbuser == PlayerRef && akAbuser.GetItemCount(the_plug) == 0
					akRef.RemoveItem(the_plug, akOtherContainer = akAbuser)
				else
					akRef.RemoveItem(the_plug)
				endif
			endif
			has_plug_vaginal = false
			return
		endif
	endif

	; if not in slot, loop over items and return first item with Zaz keyword
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_plug = akRef.GetNthForm(i)
		if the_plug != None 
			if DOM01.DOMZaz.IsItemPlugVaginal(the_plug)
				UnEquipItemTight(akRef,the_plug)
				if should_drop
					if the_plug != DOM01.DOMZaz.GetPlugVaginal() && akAbuser == PlayerRef && akAbuser.GetItemCount(the_plug) == 0
						akRef.RemoveItem(the_plug, akOtherContainer = akAbuser)
					else
						akRef.RemoveItem(the_plug)
					endif
				endif
				has_plug_vaginal = false
			endif
		endif
	endWhile

	has_plug_vaginal = false
EndFunction

Form equipped_cuffs = None
Function EquipCuffs(Form cuffs, Actor akAbuser = None)
	LogTrace("EquipCuffs cuffs="+cuffs)
	if equipped_cuffs == None
		equipped_cuffs = DOM01.DOMZaz.GetEquippedCuffs(akRef)
	endif
	if cuffs == None
		if equipped_cuffs != None
			cuffs = equipped_cuffs
		else
			cuffs = DOM01.DOMZaz.GetCuffsRope()
		endif
		if cuffs == None
			return
		endif
	endif
	LogTrace("EquipCuffs "+cuffs.getName())
	if equipped_cuffs != None && equipped_cuffs != cuffs
		if akRef.IsEquipped(equipped_cuffs)
			UnEquipItemTight(akRef,equipped_cuffs)
		endif
		if equipped_cuffs != DOM01.DOMZaz.GetCuffsRope() && akAbuser == PlayerRef && akAbuser.GetItemCount(equipped_cuffs) == 0
			akRef.RemoveItem(equipped_cuffs, akOtherContainer = akAbuser)
		else
			akRef.RemoveItem(equipped_cuffs)
		endif
	endif
	cuffs_material = DOM01.DOMEquip.GetMaterial(cuffs)
	equipped_cuffs = cuffs
	wait_for_equipment = true
	AddItemNoChange(akRef,cuffs)
	if !akRef.IsEquipped(cuffs)
		LogTrace("EquipCuffs "+cuffs.getName())
		EquipItemTight(akRef,cuffs)
	endif
	wait_for_equipment = false
	LogEquip("EquipCuffs() check inventory")
EndFunction

Function RemoveCuffs(Actor akAbuser=None)
	LogTrace("RemoveCuffs equipped_cuffs "+equipped_cuffs)
	Form cuffs = equipped_cuffs
	equipped_cuffs = None
	cuffs_material = 0
	if cuffs == None
		cuffs = DOM01.DOMZaz.GetEquippedCuffs(akRef)
		LogTrace("RemoveCuffs find other cuffs "+cuffs)
		if cuffs == None
			return
		endif
	endif
	if akAbuser != PlayerRef
		akAbuser = None
	endif
	wait_for_equipment = true
	while cuffs != None
		int nitems = akRef.GetItemCount(cuffs)
		LogTrace("RemoveCuffs "+cuffs.getName()+" n="+nitems)
		if nitems > 0
			if akRef.IsEquipped(cuffs)
				UnEquipItemTight(akRef,cuffs)
			endif
			akRef.RemoveItem(cuffs,nitems,true,akAbuser)
		endif
		cuffs = DOM01.DOMZaz.GetEquippedCuffs(akRef)
		LogTrace("RemoveCuffs find other cuffs "+cuffs)
	endwhile
	wait_for_equipment = false
	SetBoundStatus()
EndFunction

; ### Behaviour setting ###

Function EnterWait()
	if behaviour == "wait"
		SendNotificationAction(name+" "+actorBeVerb+" already standing still")
		return
	endif
	behaviour = "wait"
EndFunction

Function EnterWaitSandbox()
	if behaviour == "wait_sandbox"
		SendNotificationAction(name+" "+actorBeVerb+" already waiting around")
		return
	endif
	behaviour = "wait_sandbox"
EndFunction

Function EnterJailByMode()
	int rank = akRef.GetFactionRank(DOM01.DOMJailMode)
	if rank < 1
		rank = 1
		akRef.SetFactionRank(DOM01.DOMJailMode,rank)
	endif
	if rank == 2
		ExitCuffed(None)
		EnterJailSandbox()
	elseif rank == 3
		ExitCuffed(None)
		EnterJailRestrained(None,None,"","",true)
	elseif rank == 4
		akRef.SetFactionRank(DOM01.DOMJailMode,1)
		EnterJailStand()
		EnterCuffed(None,0)
	elseif rank == 5
		akRef.SetFactionRank(DOM01.DOMJailMode,1)
		EnterJailStand()
		EnterCuffed(None,1)
	elseif rank == 6
		akRef.SetFactionRank(DOM01.DOMJailMode,1)
		EnterJailStand()
		EnterCuffed(None,2)
	elseif rank == 7
		akRef.SetFactionRank(DOM01.DOMJailMode,1)
		EnterJailStand()
		EnterCuffed(None,3)
	elseif rank == 8
		akRef.SetFactionRank(DOM01.DOMJailMode,1)
		EnterJailStand()
		EnterCuffed(None,4)
	elseif rank == 9
		akRef.SetFactionRank(DOM01.DOMJailMode,1)
		EnterJailStand()
		EnterCuffed(None,5)
	else
		ExitCuffed(None)
		EnterJailStand()
	endif
EndFunction

Function EnterJailTravel(int imode)
	if imode <= 3
		akRef.SetFactionRank(DOM01.DOMJailMode,imode)
	else
		akRef.SetFactionRank(DOM01.DOMJailMode,imode-(3))
	endif
	behaviour = "jail_travel"
	if imode == 4
		EnterCuffed(None,0)
	elseif imode == 5
		EnterCuffed(None,1)
	elseif imode == 6
		EnterCuffed(None,2)
	elseif imode == 7
		EnterCuffed(None,3)
	elseif imode == 8
		EnterCuffed(None,4)
	elseif imode == 9
		EnterCuffed(None,5)
	endif
EndFunction

Function EnterJailStand()
	if behaviour == "jail_stand"
		SendNotificationAction(name+" "+actorBeVerb+" already standing in jail")
		return
	endif
	behaviour = "jail_stand"
EndFunction

Function EnterJailSandbox()
	if behaviour == "jail_sandbox"
		SendNotificationAction(name+" "+actorBeVerb+" already waiting in jail")
		return
	endif
	behaviour = "jail_sandbox"
EndFunction

Function EnterGuard()
	if behaviour == "guard"
		SendNotificationAction(name+" "+actorBeVerb+" already guarding")
		return
	endif
	on_duty_string = ""
	behaviour = "guard"
EndFunction

Function EnterDropTraineesAndComeBack()
	Debug.Notification(name+" escorted all slaves to camp and will now come back")
	if DOM01.DOMHSH == None
		SecureTrainees()
		UnloadAllTrainees()
		EnterFollow()
		return
	endif
	ReferenceAlias camp = DOM01.DOMHSH.PHSF.PortableFunctions.HoldingCellrefForCell(akRef.GetParentCell())
	if camp == None
		SecureTrainees()
		UnloadAllTrainees()
		EnterFollow()
		return
	endif
	DOM01.DOMHSH.UnloadAllTraineesToCell(self,camp as phhshPortableCellScript)
	EnterFollow()
EndFunction

Function EnterGuardCamp()
	if DOM01.DOMHSH == None
		EnterGuard()
		return
	endif
	ReferenceAlias camp = DOM01.DOMHSH.PHSF.PortableFunctions.HoldingCellrefForCell(akRef.GetParentCell())
	if camp == None
		EnterGuard()
		return
	endif
	DOM01.DOMHSH.PHSF.PortableFunctions.StandGuard(akRef)
EndFunction

Function EnterGuardMsg(string duty_msg, string duty_title)
	on_duty_string = duty_title
	if behaviour == "guard"
		SendNotificationAction(name+" "+actorBeVerb+" already guarding")
		return
	endif
	behaviour = "guard"
	SendNotificationAction(name+" "+duty_msg)
EndFunction

Function EnterSweep()
	if behaviour == "clean_house"
		;SendNotificationAction(name+" "+actorBeVerb+" already cleaning")
		return
	endif
	behaviour = "clean_house"
	mind.CheckAndRegisterKink(80,2.0) ; "being a maid"
EndFunction

Function EnterWork(int imode)
	;LogTrace("EnterWork mode="+imode)
	if imode <= 0 || imode >= 7
		imode = 1
	endif
	if behaviour == "work" && imode == akRef.GetFactionRank(DOM01.DOMWorkMode)
		;if imode == 1
		;	SendNotificationAction(name+" "+actorBeVerb+" already mining")
		;elseif imode == 1
		;	SendNotificationAction(name+" "+actorBeVerb+" already cutting wood")
		;else
		;	SendNotificationAction(name+" "+actorBeVerb+" already working")
		;endif
		return
	endif
	akRef.SetFactionRank(DOM01.DOMWorkMode,imode)
	behaviour = "work"
	mind.CheckAndRegisterKink(87,2.0) ; "being forced to work"
EndFunction

Function EnterPunishing()
	if behaviour == "punishing"
		SendNotificationAction(name+" "+actorBeVerb+" already punishing slaves")
		return
	endif
	behaviour = "punishing"
EndFunction

Function EnterSexTraining()
	if behaviour == "sextraining"
		SendNotificationAction(name+" "+actorBeVerb+" already training slaves")
		return
	endif
	behaviour = "sextraining"
EndFunction

Function EnterOrgyTraining()
	if behaviour == "orgytraining"
		SendNotificationAction(name+" "+actorBeVerb+" already having an orgy with slaves")
		return
	endif
	behaviour = "orgytraining"
EndFunction

Function SetFollowMode(int imode)
	if imode < 0
		imode = 0
	elseif imode > 3
		imode = 3
	endif
	akRef.SetFactionRank(DOM01.DOMFollowMode,imode)
	if imode == 0
		SendNotificationAction(name+" will follow tightly")
	elseif imode == 1
		SendNotificationAction(name+" will follow closely")
	elseif imode == 2
		SendNotificationAction(name+" will follow from a short distance")
	else
		SendNotificationAction(name+" will follow from afar")
	endif
EndFunction

Function SetWaitMode(int imode)
	if imode < 0
		imode = 0
	elseif imode > 5
		imode = 5
	endif
	akRef.SetFactionRank(DOM01.DOMWaitMode,imode)
	if imode == 0
		SendNotificationAction(name+" will stay around here")
	elseif imode == 1
		SendNotificationAction(name+" will wait around here")
	elseif imode == 2
		SendNotificationAction(name+" will busy around here")
	elseif imode == 3
		SendNotificationAction(name+" will stroll around here")
	elseif imode == 4
		SendNotificationAction(name+" will wander around this place")
	else
		SendNotificationAction(name+" will roam around this place")
	endif
EndFunction

Function SetTravelMode(int imode)
	if imode < 0
		imode = 0
	elseif imode > 4
		imode = 1
	endif
	int n = GetTraineeCount()
	akRef.SetFactionRank(DOM01.DOMTravelMode,imode)
	if imode == 0 || n <= 0
		SendNotificationAction(name+" will travel to camp and then wait there")
	elseif imode == 1
		SendNotificationAction(name+" will travel to camp and then punish slaves")
	elseif imode == 2
		SendNotificationAction(name+"  will travel to camp and then guard slaves")
	elseif imode == 3
		SendNotificationAction(name+"  will travel to camp and then train slaves sexually")
	else ; if imode == 4
		SendNotificationAction(name+"  will escort slaves to camp and then come back")
	endif
EndFunction

Function EnterFollowPlayer()
	if behaviour == "follow_player"
		;SendNotificationAction(name+" "+actorBeVerb+" already following you")
		return
	endif
	if actor_trainer != None && akRef.getFactionRank(DOM01.DOMFollowMode) == 0 ; was following trainer
		SetFollowMode(DOM01.defaultFollowMode)
	endif
	actor_target = None
	behaviour = "follow_player"
EndFunction

Function EnterFollowPlayerIfNearby()
	if !akRef.Is3DLoaded()
		return
	endif
	if !IsTogetherWithFast(akRef, PlayerRef, 40000.0) ; 40000.0 = 568 meters
		return
	endif
	if !canMove
		return
	endif
	if behaviour == "follow_player"
		;SendNotificationAction(name+" "+actorBeVerb+" already following you")
		return
	endif
	EnterFollowPlayer()
EndFunction

Function EnterFollowPlayerIfPosing()
	if !akRef.Is3DLoaded()
		return
	endif
	if !IsTogetherWithFast(akRef, PlayerRef, 40000.0) ; 40000.0 = 568 meters
		return
	endif
	if !canMove
		return
	endif
	if behaviour == "follow_player"
		;SendNotificationAction(name+" "+actorBeVerb+" already following you")
		return
	endif
	if behaviour != "pose" ; || behaviour != "masturbate"
		return
	endif
	if poseId != 10
		return
	endif
	EnterFollowPlayer()
EndFunction

Function ExitTieUpIfTied(Actor akAbuser)
	;*ogTrace("ExitTieUpIfTied 1 is_restrained="+is_restrained)
	if is_restrained || akRef.IsInFaction(DOM01.DOMActionTied)
		ExitTieUp(akAbuser)
	endif
	;*ogTrace("ExitTieUpIfTied 2 is_restrained="+is_restrained)
EndFunction

Function EnterGagged(Actor akAbuser, Form the_gag = None)
	LogTrace("EnterGagged")
	if has_mouth_gag
		if the_gag == None
			return
		endif
		if the_gag == DOM01.DOMZaz.GetEquippedGag(akRef)
			return
		endif
		ExitGagged(None)
	endif
	if the_gag == None
		the_gag = DOM01.DOMZaz.GetGagCloth()
	endif
	EquipGag(the_gag)
	if akAbuser == None
		DOM01.DOM04.NotifyEquipGag(self)
	endif
EndFunction

Function ExitGagged(Actor akAbuser)
	LogTrace("ExitGagged")
	RemoveGag()
EndFunction

Function EnterBlindfolded(Actor akAbuser, Form the_blindfold = None)
	LogTrace("EnterBlindfolded akAbuser="+akAbuser+" the_blindfold="+the_blindfold)
	if has_blindfold
		if the_blindfold == None
			return
		endif
		if the_blindfold == DOM01.DOMZaz.GetEquippedBlindfold(akRef)
			return
		endif
		ExitBlindfolded(None)
	endif
	if the_blindfold == None
		the_blindfold = DOM01.DOMZaz.GetBlindfold0()
	endif
	EquipBlindfold(the_blindfold)
	if akAbuser == None
		DOM01.DOM04.NotifyEquipBlindfold(self)
	endif
EndFunction

Function ExitBlindfolded(Actor akAbuser)
	LogTrace("ExitBlindfolded akAbuser="+akAbuser)
	RemoveBlindfold(akAbuser)
EndFunction

Function EnterCuffed(Actor akAbuser, int itype = 0)
	LogTrace("EnterCuffed START type="+itype+" wait_for_equipment="+wait_for_equipment+" behaviour="+behaviour+" is_restrained="+is_restrained+" is_bounded="+is_bounded)
	if !canMove
		return
	endif
	mind.should_walk_on_four = false ; avoid something too complicated
	;wait_for_equipment = true
	equipped_cuffs = DOM01.DOMZaz.GetEquippedCuffs(akRef)
	if itype == 0
		LogTrace("EnterCuffed type="+itype+" Anim_BoundStartBack")
		Anim_BoundStartBack()
	elseif itype == 1
		LogTrace("EnterCuffed type="+itype+" Anim_BoundStartFront")
		Anim_BoundStartFront()
	elseif itype == 2
		LogTrace("EnterCuffed type="+itype+" Anim_BoundStartCrossed")
		Anim_BoundStartCrossed()
	elseif itype == 3
		LogTrace("EnterCuffed type="+itype+" Anim_BoundStartBoxTied")
		Anim_BoundStartBoxTied()
	elseif itype == 4
		LogTrace("EnterCuffed type="+itype+" Anim_BoundStartYoke")
		Anim_BoundStartYoke()
	elseif itype == 5
		LogTrace("EnterCuffed type="+itype+" Anim_BoundStartArmbinder")
		Anim_BoundStartArmbinder()
	else ; default
		LogTrace("EnterCuffed type="+itype+" Anim_BoundStartBack default type="+itype)
		Anim_BoundStartBack()
	endif
	;if akAbuser == None
	;	DOM01.DOM04.NotifyEquipCuffs(self)
	;endif
	EquipInventoryNow(false)
	LogTrace("EnterCuffed END type="+itype+" wait_for_equipment="+wait_for_equipment+" behaviour="+behaviour+" is_restrained="+is_restrained+" is_bounded="+is_bounded)
	;wait_for_equipment = false
EndFunction

Function ExitCuffed(Actor akAbuser)
	LogAnim("ExitCuffed Anim_BoundStop start")
	Anim_BoundStop()
	LogAnim("ExitCuffed Anim_BoundStop end")
EndFunction

bool Function HasCuffs(int itype)
	LogTrace("HasCuffs type="+itype)
	if itype == 0
		if __has_cuffs_back
			return true
		endif
	elseif itype == 1
		if __has_cuffs_front
			return true
		endif
	elseif itype == 2
		if __has_cuffs_crossed
			return true
		endif
	elseif itype == 3
		if __has_cuffs_boxtied
			return true
		endif
	elseif itype == 4
		if __has_yoke
			return true
		endif
	elseif itype == 5
		if __has_armbinder
			return true
		endif
	elseif __has_cuffs_back
		return true
	endif
	return false
EndFunction

bool Function IsCuffed()
	if __has_cuffs_back
		return true
	endif
	if __has_cuffs_front
		return true
	endif
	if __has_cuffs_crossed
		return true
	endif
	if __has_cuffs_boxtied
		return true
	endif
	if __has_yoke
		return true
	endif
	if __has_armbinder
		return true
	endif
	return false
EndFunction

Function SetCuffsStatus()
	if DOM01.DOMZaz.wornCuffsBack(akRef)
		has_cuffs_back = true
	elseif DOM01.DOMZaz.wornCuffsBoxtied(akRef)
		has_cuffs_boxtied = true
	elseif DOM01.DOMZaz.wornCuffsCrossed(akRef)
		has_cuffs_crossed = true
	elseif DOM01.DOMZaz.wornCuffsFront(akRef)
		has_cuffs_front = true
	elseif DOM01.DOMZaz.wornYoke(akRef)
		has_yoke = true
	elseif DOM01.DOMZaz.wornArmbinder(akRef)
		has_armbinder = true
	endif
EndFunction

Function EnterPlugged(Actor akAbuser, bool is_vaginal=false)
	;LogTrace("EnterPlugged v="+is_vaginal)
	if is_vaginal
		EquipPlugVaginal()
	else
		EquipPlugAnal()
	endif
EndFunction

Function ExitPlugged(Actor akAbuser, bool is_vaginal=false)
	;LogTrace("ExitPlugged v="+is_vaginal)
	if is_vaginal
		RemovePlugVaginal(akAbuser)
	else
		RemovePlugAnal(akAbuser)
	endif
EndFunction

Function EnterRestrainedBehaviour(Actor akAbuser, string the_behaviour, Form cuffs, string the_pose, string the_strugglePose, string the_enterPose, string the_exitPose, bool need_cuff, bool do_anim_abuser)
	LogTrace("EnterRestrainedBehaviour need_cuff="+need_cuff+" is_group_order="+is_group_order)	
	
	;wait_for_equipment = true
	behaviour_is_busy = true
	is_bounded = true
	CalmActorFast(akRef)
	akRef.SetRestrained()
	akRef.SetDontMove()
	bool do_anim_enter
	if behaviour == the_behaviour
		do_anim_enter = false
	else
		do_anim_enter = true
	endif
	if the_pose == "ZazAPCAO310" ; force cuffs for some poses
		if cuffs == None
			cuffs = DOM01.DOMZaz.GetCuffsIron()
		endif
		need_cuff = true
	elseif need_cuff
		if cuffs == None
			cuffs = DOM01.DOMZaz.FindCuffs(akRef)
		;elseif DOM01.DOMZaz.IsItemOffsetOnlyRestraint(cuffs)
		;	cuffs = DOM01.DOMZaz.FindCuffs(akRef)
		endif
		if cuffs == None
			cuffs = DOM01.DOMZaz.GetCuffsRope()
		endif
	endif
	;LogTrace("EnterRestrainedBehaviour() equip cuffs="+cuffs+" equipped="+equipped_cuffs)
	if cuffs != equipped_cuffs && equipped_cuffs != None
		RemoveCuffs(akAbuser)
	endif
	if need_cuff
		LogTrace("EnterRestrainedBehaviour EquipCuffs")
		EquipCuffs(cuffs,akAbuser)
	endif
	;LogTrace("EnterRestrainedBehaviour() cuffs equipped")
	
	;Wait(1.0) ; Wait for cuffs to apply hands in the back

	if !akRef.IsInInterior() && DOM01.checkInteriorPosesToggle
		the_pose = DOM01.DOM_Anim.GetTieupExteriorPose(the_pose)
	endif
	if the_pose == ""
		the_pose         = DOM01.DOM_Anim.GetTieupKneeling(self)
		the_strugglePose = DOM01.DOM_Anim.GetTieupStrugglePose(the_pose)
	elseif the_strugglePose == ""
		the_strugglePose = DOM01.DOM_Anim.GetTieupStrugglePose(the_pose)
	endif
	if the_enterPose == ""
		the_enterPose = DOM01.DOM_Anim.GetTieupEnterPose(the_pose)
	endif
	if the_exitPose == ""
		the_exitPose = DOM01.DOM_Anim.GetTieupExitPose(the_pose)
	endif
	LogTrace("EnterRestrainedBehaviour() set pose do_anim_abuser="+do_anim_abuser+" do_anim_enter="+do_anim_enter)
	SetPoseTied(the_pose, the_strugglePose, the_enterPose, the_exitPose)
	
	if do_anim_enter
		CalmActorFast(akRef)
		if canAnimate && the_enterPose == ""
			SendOrderAnimate(the_enterPose,false) ; no idle
			;Anim_VictimTieUpEnter()
		endif
	endif
	if akAbuser != None
		akRef.SetLookAt(akAbuser)
		if do_anim_abuser && (akAbuser != PlayerRef || DOM01.doAnimPlayerTieup)
			CalmActorFast(akAbuser)
			Anim_AggressorByString(akAbuser,"IdleLockpick")
		endif
	endif
	SetBoundStatus()

	mind.number_of_bondage += 1
	if akAbuser != None
		DOM01.TrainSkillEnforcer(akAbuser,0.5)
	endif

	;LogTrace("EnterRestrainedBehaviour() start behaviour")
	reset_on_behaviour_change = false
	behaviour_is_busy = false
	;wait_for_equipment = false
	behaviour = the_behaviour
	;DOM01.HudNotification("Wait 1")
	;Wait(10.0)
	if do_anim_abuser && (akAbuser != PlayerRef || DOM01.doAnimPlayerTieup)
		;LogTrace("EnterRestrainedBehaviour() Anim_AggressorReset")
		Anim_AggressorReset(akAbuser)
	endif
	EquipInventoryNow(false)
	;DOM01.HudNotification("Wait 2")
	;Wait(10.0)
	;LogTrace("EnterRestrainedBehaviour end")	
EndFunction

Function EnterTieUp(Actor akAbuser, Form cuffs = None, string the_pose = "", string the_strugglePose = "", string the_enterPose = "", string the_exitPose = "")
	LogTrace("EnterTieUp is_group_order="+is_group_order)	
	EnterRestrainedBehaviour(akAbuser, "tied", cuffs, the_pose, the_strugglePose, the_enterPose, the_exitPose, true, !is_group_order) ; use cuffs, do anim abuser if not group
EndFunction

Function EnterChained(Actor akAbuser, Form cuffs, string the_pose, string the_strugglePose="", string the_enterPose = "", string the_exitPose = "", bool need_cuff=false)
	;*ogTrace("EnterChained")	
	EnterRestrainedBehaviour(akAbuser, "chained", cuffs, the_pose, the_strugglePose, the_enterPose, the_exitPose, need_cuff, false) ; no anim
EndFunction

Function EnterRestrained(Actor akAbuser, Form cuffs, string the_pose, string the_strugglePose="", string the_enterPose = "", string the_exitPose = "", bool need_cuff=false)
	;*ogTrace("EnterRestrained pose="+the_pose+" need_cuff="+need_cuff)	
	EnterRestrainedBehaviour(akAbuser, "restrained", cuffs, the_pose, the_strugglePose, the_enterPose, the_exitPose, need_cuff, false) ; no anim	
EndFunction

Function EnterJailRestrained(Actor akAbuser, Form cuffs, string the_pose, string the_strugglePose="", string the_enterPose = "", string the_exitPose = "", bool need_cuff=false)
	;*ogTrace("EnterJailRestrained")	
	EnterRestrainedBehaviour(akAbuser, "jail_restrained", cuffs, the_pose, the_strugglePose, the_enterPose, the_exitPose, need_cuff, false) ; no anim	
EndFunction

bool is_exiting_tieup = false
Function ExitTieUp(Actor akAbuser)
	if !is_restrained
		;*ogTrace("ExitTieUp: not restrained ")	
		return
	endif
	if is_exiting_tieup
		;*ogTrace("ExitTieUp: already exiting ")	
		return
	endif
	is_exiting_tieup = true
	;*ogTrace("ExitTieUp 1")	
	
	behaviour_is_busy = true
	CalmActorFast(akRef)

	if akAbuser != None && behaviour == "tied"
		if akAbuser != PlayerRef || DOM01.doAnimPlayerTieup
			if cuffs_material > 2 ; No cut if iron or steel
				Anim_AggressorByString(akAbuser, "IdleLockpick")
			else
				Anim_AggressorByString(akAbuser, "BoundStandingCutNPC")
			endif
		endif
		if akRef.GetFactionRank(DOM01.DOMActionTied) == 1
			SendOrderAnimate(exitPose,false) ; forced anim, not idle
			;Anim_VictimTieUpExit()
			;Wait(1.0)
		endif
		Anim_AggressorReset(akAbuser)
	endif
	akRef.SetRestrained(false)
	akRef.SetDontMove(false)
	if has_mouth_gag && DOM01.removeGagToggle
		RemoveGag()
	endif
	if has_blindfold && DOM01.removeBlindfoldToggle
		RemoveBlindfold(akAbuser)
	endif
	if DOM01.removeCuffsToggle
		RemoveCuffs(akAbuser)
	endif
	is_exiting_tieup = false
	behaviour_is_busy = false
	if akAbuser == PlayerRef
		behaviour = "follow_player"
	elseif akAbuser != None && akAbuser == actor_trainer.akRef
		behaviour = "follow_trainer"
	else
		behaviour = "wait"
	endif
	;*ogTrace("ExitTieUp 2")	
EndFunction

Function ExitTieUpSoft()
	if !is_restrained
		return
	endif
	if is_exiting_tieup
		return
	endif
	is_exiting_tieup = true
	
	akRef.SetRestrained(false)
	akRef.SetDontMove(false)
	if behaviour != "tied" && behaviour != "chained" && behaviour != "restrained"
		if has_mouth_gag && DOM01.removeGagToggle
			RemoveGag()
		endif
		if has_blindfold && DOM01.removeBlindfoldToggle
			RemoveBlindfold(None)
		endif
		if DOM01.removeCuffsToggle
			RemoveCuffs()
		endif
	endif
	is_exiting_tieup = false
EndFunction

Function SetTiedInFurniture(ObjectReference TheFurniture)
	;*ogTrace("SetTiedInFurniture")
	nextTiedInFurniture = TheFurniture
	currentTiedInFurniture = TheFurniture
	target.ForceRefTo(currentTiedInFurniture)
EndFunction

Function EnterRestrainedInFurnitureAlreadySitting()
	;*ogTrace("EnterRestrainedInFurnitureAlreadySitting current="+nextTiedInFurniture+" next="+nextTiedInFurniture)
	if behaviour != "restrained_in_furniture"
		reset_on_behaviour_change = false
		behaviour = "restrained_in_furniture" ; in sit
	else
		akRef.EvaluatePackage()
	endif
EndFunction

Function EnterPoseInFurnitureAlreadySitting()
	;*ogTrace("EnterPoseInFurnitureAlreadySitting current="+nextTiedInFurniture+" next="+nextTiedInFurniture)
	if behaviour != "pose_in_furniture"
		reset_on_behaviour_change = false
		behaviour = "pose_in_furniture" ; in sit
	else
		akRef.EvaluatePackage()
	endif
EndFunction

Function EnterRestrainedInFurniture(ObjectReference TheFurniture, String ThePose = "", String TheStrugglePose = "")
	if TheFurniture == None
		return
	endif
	SetPoseTied(ThePose, TheStrugglePose)
	nextTiedInFurniture = TheFurniture
	;currentTiedInFurniture = TheFurniture
	;*ogTrace("EnterRestrainedInFurniture activate="+nextTiedInFurniture)
	nextTiedInFurniture.Activate(akRef,true)
	;behaviour = "restrained_in_furniture" ; in sit
EndFunction

Function EnterPoseInFurniture(ObjectReference TheFurniture, String ThePose, String TheStrugglePose = "")
	SetPoseTied(ThePose, TheStrugglePose)
	nextTiedInFurniture = TheFurniture
	;currentTiedInFurniture = TheFurniture
	;*ogTrace("EnterPoseInFurniture activate="+nextTiedInFurniture)
	nextTiedInFurniture.Activate(akRef,true)
	;behaviour = "pose_in_furniture" ; in sit
EndFunction

Function EnterFollow()
	if !mind.is_player_slave && mind.actor_owner != None
		EnterFollowTarget(mind.actor_owner)
		return
	endif
	EnterFollowPlayerOrTrainer()
EndFunction

Function EnterFollowPlayerOrTrainer()
	;*ogTrace("EnterFollowPlayerOrTrainer: actor_trainer="+actor_trainer+" actor_target="+actor_target)
	if actor_target != None
		target.ForceRefTo(actor_target)
		if behaviour == "follow_trainer"
			;SendNotificationAction(name+" "+actorBeVerb+" already following "+actorPossessive+" trainer")
			return
		endif
		behaviour = "follow_target"
		return	
	endif
	if actor_trainer == None
		if behaviour == "follow_player"
			;SendNotificationAction(name+" "+actorBeVerb+" already following you")
			return
		endif
		behaviour = "follow_player"
		return
	endif
	if DOM01.DOMKeys.menuSlavers || actor_trainer.behaviour == "follow_player"
		target.ForceRefTo(actor_trainer.akRef)
		if behaviour == "follow_trainer"
			;SendNotificationAction(name+" "+actorBeVerb+" already following "+actorPossessive+" trainer")
			return
		endif
		behaviour = "follow_trainer"
	endif
EndFunction

Function EnterFollowTrainer()
	if actor_trainer == None
		EnterWait()
		return
	endif
	if behaviour == "follow_trainer"
		;SendNotificationAction(name+" "+actorBeVerb+" already following "+actorPossessive+" trainer")
		return
	endif
	actor_target = None
	behaviour = "follow_trainer"
EndFunction

Function EnterFollowTarget(Actor followTarget)
	if followTarget == None
		EnterWait()
		return
	endif
	actor_target = followTarget
	target.ForceRefTo(followTarget)
	behaviour = "follow_target"
EndFunction

Function ExitFollowTrainer()
	if behaviour == "follow_trainer"
		if DOM01.IsWithPlayer(akRef, 3000.0) ; 3000.0 = 42 meters
			EnterFollowPlayer()
		else
			EnterWait()
		endif
	endif
EndFunction

Function EnterGotoCamp()
	GatherTrainees()
	if DOM01.travelCuffsToggle
		CuffTrainees()
	endif
	if akRef.IsInFaction(DOM01.DOMSlaverHasCamp)
		if CampMarker == None
			SetCamp()
		endif
		target.ForceRefTo(CampMarker)
		behaviour = "travel"
	endif
EndFunction

Function SetLookAtTarget()
	if actor_trainer != None
		akRef.SetLookAt(actor_trainer.akRef)
		return
	endif
	if actor_trainee != None
		akRef.SetLookAt(actor_trainee.akRef)
		return
	elseif actor_trainee_whipped != None
		akRef.SetLookAt(actor_trainee_whipped.akRef)
		return
	endif
	Actor akTarget = target.GetReference() as Actor
	if akTarget != None
		akRef.SetLookAt(akTarget)
		return
	endif
	akRef.ClearLookAt()
EndFunction

; ### Pose handling ###

Int Property poseId = -1 Auto Hidden
int nextPoseId = -1
int prevPoseId = -1
String quietPose        = ""
String strugglePose     = ""
string arousedPose      = ""
String enterPose        = ""
String exitPose         = ""
String prevQuietPose    = ""
String prevStrugglePose = ""
String prevEnterPose    = ""
String prevExitPose     = ""
String nextQuietPose    = ""
String nextStrugglePose = ""
String nextEnterPose    = ""
String nextExitPose     = ""
ObjectReference currentTiedInFurniture = None
ObjectReference nextTiedInFurniture    = None
bool  was_pose_registered = false
float timer_for_pose = 0.0 ; in days

string Function GetPose()
	return quietPose
EndFunction

string Function GetStrugglePose()
	return strugglePose
EndFunction

Function SetQuietPose(string the_pose)
	quietPose = the_pose
EndFunction

Function SetStrugglePose(string the_pose)
	strugglePose = the_pose
EndFunction

Function UnregisterPose()
	timer_for_pose = GetCurrentGameTime()
	was_pose_registered = false
EndFunction

Function StartPose()
	;*ogTrace("StartPose "+nextPoseId+" "+nextquietPose+" "+nextStrugglePose)
	poseId = nextPoseId
	quietPose = nextquietPose
	strugglePose = nextStrugglePose
	enterPose = nextEnterPose
	exitPose = nextExitPose
	UnregisterPose()
EndFunction

Function SetPoseTied(String TheQuietPose, String TheStrugglePose = "", String TheEnterPose = "", String TheExitPose = "")
	nextStrugglePose = TheStrugglePose
	nextQuietPose    = TheQuietPose
	nextEnterPose    = TheEnterPose
	nextExitPose     = TheExitPose
	nextPoseId       = 1
	;*ogTrace("Setting pose tied Id="+nextPoseId+" pose="+nextQuietPose+" struggle="+nextStrugglePose)	
EndFunction

Function SetPose(string the_pose, int rank)
	;/ PoseId
		Poses saved as rank in DOMActionPosing
		<0  = no animation / not used
	    0   = idle reset
		1   = various kneeling tied, animation, forced if == ""
		2   = restrained in furniture, usually animation is handled by furniture
		3   = posing in furniture, usually animation is handled by furniture
		10     = standing/kneeling attentive
		11+    = various activities
		20     = serve drinks
		21     = hold flowers
		30     = sit on me
	    99     = holding a torch
		100    = dance
		101    = play music
		102    = cute pose
		103    = do sport
		104    = cleaning
		105    = no refresh pose
		110    = show breast
		111    = show ass
		112    = show front
		113    = sexy pose
		Masturbate
		1000+  = masturbate standing
		2000+  = masturbate laying
		3000+  = masturbate kneeling
	/;	
	nextStrugglePose = ""
	nextQuietPose    = the_pose
	nextPoseId       = rank
	;*ogTrace("Setting pose Id="+nextPoseId+" pose="+nextQuietPose)	
EndFunction

; ### Idles

Function HandleTopicAndIdleOnUpdate()
	if !akRef.Is3dLoaded()
		return
	endif
	if is_dialogue_blocked_for == 0 && !has_mouth_gag
		if RandomFloat() < 0.25
			ChooseTopic(PlayerRef)
		endif
	endif
	if canIdle && RandomFloat() < 0.05
		mind.ChooseIdle()
	endif
EndFunction

; ### Dual animations ###

ObjectReference Property DualAnimationMarker Auto Hidden

float JSONanim_angle1 = 0.0
float JSONanim_angle2 = 0.0
string JSONanim_idle1 = ""
string JSONanim_idle2 = ""
int JSONanim_nactors = 0
int JSONanim_nscenes = 0
bool JSONanim_is_bounded = false
bool JSONanim_do_actor1 = true
bool JSONanim_do_actor2 = true
bool JSONanim_do_bounded = false
bool JSONanim_do_start = true
String[] JSONanim_idles1
String[] JSONanim_idles2
Float[] JSONanim_angles1
Float[] JSONanim_angles2
Float[] JSONanim_timers
Actor JSONanim_actor2

Function CheckJSONActors()
	; Check if actors can be animated
	if is_restrained
		JSONanim_is_bounded = true
	endif
	if JSONanim_is_bounded && !JSONanim_do_bounded
		LogTrace("CheckJSONActors Actor1 is restrained")
		JSONanim_do_actor1 = false
	elseif DOM01.DOMSexlab.IsAnimating(akRef)
		LogTrace("CheckJSONActors Actor1 is SxL animating")
		JSONanim_do_actor1 = false
	else
		JSONanim_do_actor1 = true
	endif
	if JSONanim_actor2 != None
		if JSONanim_actor2.IsInFaction(DOM01.DOMActionTied)
			LogTrace("CheckJSONActors Actor2 is restrained")
			JSONanim_do_actor2 = false
		elseif DOM01.DOMSexlab.IsAnimating(JSONanim_actor2)
			LogTrace("CheckJSONActors Actor2 is SxL animating")
			JSONanim_do_actor2 = false
		else
			JSONanim_do_actor2 = true
		endif
	else
		JSONanim_do_actor2 = false
	endif
EndFunction

Function StartJSONAnimation(Actor akAnotherActor, string the_key, bool do_bounded=false)
	LogAnim("StartJSONAnimation "+the_key+" with "+akAnotherActor)
	; Set variables
	JSONanim_angle1     = 0.0
	JSONanim_angle2     = 0.0
	JSONanim_idle1      = ""
	JSONanim_idle2      = ""
	JSONanim_actor2     = akAnotherActor
	JSONanim_nscenes    = 0
	JSONanim_is_bounded = false
	JSONanim_do_bounded = do_bounded
	JSONanim_do_start   = true
	; Check if actors are already busy with DOM animations
	if DOM01.DOM_Anim.IsAnimating(akRef)
		LogAnim("StartJSONAnimation Actor1 is alread in DoM animation")
		JSONanim_do_actor1 = false
	else
		JSONanim_do_actor1  = true
	endif
	if JSONanim_actor2 != None
		if DOM01.DOM_Anim.IsAnimating(JSONanim_actor2)
			LogAnim("StartJSONAnimation Actor2 is already in DoM animation")
			JSONanim_do_actor2 = false
		else
			JSONanim_do_actor2  = true
		endif
	else
		LogAnim("StartJSONAnimation Actor2 is not defined")
		JSONanim_do_actor2  = false
	endif
	; If no actors available, abort
	if !JSONanim_do_actor1 && !JSONanim_do_actor2
		JSONanim_nactors = 0
		return
	endif
	JSONanim_nactors    = DOM01.DOM_Anim.GetNumberOfActors(the_key)
	; If no actors or no animations, abort
	if JSONanim_nactors < 1
		LogAnim("StartJSONAnimation animation "+the_key+" is not defined")
		return
	endif
	; Retrieve animations and parameters
	JSONanim_nscenes = 0

	; for actor1
	JSONanim_idles1 = DOM01.DOM_Anim.GetAnimations(the_key,1) ; first actor
	if !JSONanim_idles1
		JSONanim_do_actor1 = false
	elseif JSONanim_idles1.length < 1
		JSONanim_do_actor1 = false
	else
		JSONanim_nscenes = JSONanim_idles1.length
	endif
	JSONanim_angles1 = DOM01.DOM_Anim.GetAngles(the_key,1) ; first actor
	; for actor 2
	JSONanim_idles2 = DOM01.DOM_Anim.GetAnimations(the_key,2) ; second actor
	if !JSONanim_idles2
		JSONanim_do_actor2 = false
	elseif JSONanim_idles2.length < 1
		JSONanim_do_actor2 = false
	elseif JSONanim_idles2.length > JSONanim_nscenes
		JSONanim_nscenes = JSONanim_idles2.length
	endif
	JSONanim_angles2 = DOM01.DOM_Anim.GetAngles(the_key,2) ; second actor
	; for both actors
	JSONanim_timers  = DOM01.DOM_Anim.GetTimers(the_key)

	; Prepare actors
	if JSONanim_do_actor1
		CalmActorFast(akRef)
	endif
	if JSONanim_do_actor2
		CalmActorFast(JSONanim_actor2)
	endif
	; Play animation
	LogAnim("StartJSONAnimation found animation "+the_key+" with "+JSONanim_nscenes+" scenes and "+JSONanim_nactors+" actors")
	PlayJSONAnimation(0) ; play first animation
EndFunction

Function PlayJSONAnimation(int index)
	; Check if any animation should be played
	LogAnim("PlayJSONAnimation idx="+index+" start="+JSONanim_do_start+" actor1="+JSONanim_do_actor1+" actor2="+JSONanim_do_actor2)
	if JSONanim_nactors < 1
		return
	endif
	if JSONanim_nscenes <= index
		return
	endif
	; Check actors current animation status
	CheckJSONActors()
	if !JSONanim_do_actor1 && !JSONanim_do_actor2
		return
	endif
	; Fill in animation parameters
	if JSONanim_do_actor1
		if index < JSONanim_idles1.length
			JSONanim_idle1 = JSONanim_idles1[index]
		endif
	else
		JSONanim_idle1 = ""
	endif
	if JSONanim_angles1 && JSONanim_angles1.length > index
		JSONanim_angle1 = JSONanim_angles1[index]
		DOM01.DOM_Anim.SetAngleActor1(JSONanim_angle1)
	endif
	if JSONanim_do_actor2
		if index < JSONanim_idles2.length
			JSONanim_idle2 = JSONanim_idles2[index]
		endif
	else
		JSONanim_idle2 = ""
	endif
	if JSONanim_angles2 && JSONanim_angles2.length > index
		JSONanim_angle2 = JSONanim_angles2[index]
		DOM01.DOM_Anim.SetAngleActor2(JSONanim_angle2)
	endif
	
	if JSONanim_do_actor1 && JSONanim_do_actor2
		if JSONanim_do_start
			JSONanim_do_start = false
			PlayDualAnimation(JSONanim_actor2,JSONanim_idle1,JSONanim_idle2,JSONanim_angle1,JSONanim_angle2)
		else
			PlayAnotherDualAnim(JSONanim_actor2,JSONanim_idle1,JSONanim_idle2) 
		endif
	elseif JSONanim_do_actor1
		if JSONanim_actor2 != None
			if JSONanim_angle1 == 0.0
				FaceActor(akRef,JSONanim_actor2)
			elseif JSONanim_angle1 == 180.0
				BackActor(akRef,JSONanim_actor2)
			endif
		endif
		Anim_ForcedByString(JSONanim_idle1)
	else ; if JSONanim_do_actor2
		if JSONanim_do_start
			PlayDualAnimationOnlyAbuser(JSONanim_actor2,JSONanim_idle2,JSONanim_angle2)
		else
			PlayAnotherDualAnimOnlyAbuser(JSONanim_actor2,JSONanim_idle2)
		endif
	endif
	if JSONanim_timers && JSONanim_timers.length > index
		Wait(DOM01.anim_speed_sec*JSONanim_timers[index])
	endif		
EndFunction

Function PlayJSONAnimations(int istart, int iend)
	if iend >= JSONanim_nscenes
		iend = JSONanim_nscenes - (1)
	endif
	LogAnim("PlayJSONAnimations istart="+istart+" iend="+iend)
	if istart > iend 
		return
	endif
	int iscene = istart
	while iscene <= iend
		PlayJSONAnimation(iscene)
		iscene += 1
	EndWhile
EndFunction

Function EndJSONAnimation()
	LogAnim("EndJSONAnimation actor1="+JSONanim_do_actor1+" actor2="+JSONanim_do_actor2)
	if JSONanim_do_actor1 && JSONanim_do_actor2
		EndDualAnim(JSONanim_actor2)
	elseif JSONanim_do_actor1
		LogTrace("EndJSONAnimation Anim_IdleReset")
		Anim_IdleReset()
	else ; if JSONanim_do_actor2
		EndDualAnimOnlyAbuser(JSONanim_actor2)
	endif
	JSONanim_angle1 = 0.0
	JSONanim_angle2 = 0.0
	JSONanim_idle1 = ""
	JSONanim_idle2 = ""
	JSONanim_actor2 = None
	JSONanim_nactors = 0
	JSONanim_nscenes = 0
	JSONanim_is_bounded = false
	JSONanim_do_bounded = false
	JSONanim_do_actor1 = true
	JSONanim_do_actor2 = true
	JSONanim_do_start  = true
EndFunction

Function ClearPositionMarker(Actor akAnotherActor)
	RestorePositions(akAnotherActor)
	if DualAnimationMarker != None
		DualAnimationMarker.Delete()
		DualAnimationMarker = None
	endif
EndFunction

Function SetPositionMarker(Actor akAnotherActor, Actor akTarget)
	if DualAnimationMarker != None
		DualAnimationMarker.Delete()
		DualAnimationMarker = None
	endif
	if akAnotherActor == PlayerRef && Game.GetCameraState() == 0
		Game.ForceThirdPerson()
	endif
	DualAnimationMarker = akTarget.PlaceAtMe(DOM01.XMarkerForm)
	DualAnimationMarker.Enable()
	SavePositions(akAnotherActor)
	CheckAnimationmarker(akAnotherActor,akTarget)
EndFunction

Function ResetPositionMarker(Actor akAnotherActor, Actor akTarget)
	if akAnotherActor == PlayerRef && Game.GetCameraState() == 0
		Game.ForceThirdPerson()
	endif
	DualAnimationMarker = akTarget.PlaceAtMe(DOM01.XMarkerForm)
	DualAnimationMarker.Enable()
	SavePositions(akAnotherActor)
	CheckAnimationmarker(akAnotherActor,akTarget)
EndFunction

Function CheckAnimationMarker(Actor akAnotherActor, Actor akTarget)
	if DualAnimationMarker.GetPositionX() != 0.0 || DualAnimationMarker.GetPositionY() != 0.0 || DualAnimationMarker.GetPositionZ() != 0.0
		return
	endif
	Wait(0.1)
	DualAnimationMarker.Delete()
	if akAnotherActor == PlayerRef && Game.GetCameraState() == 0
		Game.ForceThirdPerson()
	endif
	DualAnimationMarker = akTarget.PlaceAtMe(DOM01.XMarkerForm)
	DualAnimationMarker.Enable()
	SavePositions(akAnotherActor)
	if DualAnimationMarker.GetPositionX() != 0.0 || DualAnimationMarker.GetPositionY() != 0.0 || DualAnimationMarker.GetPositionZ() != 0.0
		return
	endif
	Wait(0.1)
	DualAnimationMarker.Delete()
	if akAnotherActor == PlayerRef && Game.GetCameraState() == 0
		Game.ForceThirdPerson()
	endif
	DualAnimationMarker = akTarget.PlaceAtMe(DOM01.XMarkerForm)
	DualAnimationMarker.Enable()
	SavePositions(akAnotherActor)
EndFunction

Function PlayDualAnimationOnlyAbuser(Actor akAnotherActor, string idle2, float angle2=0.0)
	canAnimateLocal = false
	JSONanim_angle1 = 0.0
	JSONanim_angle2 = angle2
	LogAnim("PlayDualAnimationOnlyAbuser ref="+akRef+" actor="+akAnotherActor+" "+idle2+" a2="+angle2)	
	DOM01.DOM_Anim.ClearActor(akAnotherActor)
	SetPositionMarker(akAnotherActor,akRef)	
	DOM01.DOM_Anim.StartDualAnimAlone(DualAnimationMarker,akAnotherActor,angle2)
	DOM01.DOM_Anim.PlayDualAnimAlone(DualAnimationMarker,akAnotherActor,idle2)
EndFunction

Function PlayDualAnimation(Actor akAnotherActor, string idle1, string idle2, float angle1=0.0, float angle2=0.0)
	canAnimateLocal = false
	JSONanim_angle1 = angle1
	JSONanim_angle2 = angle2
	LogAnim("PlayDualAnimation ref="+akRef+" actor="+akAnotherActor+" "+idle1+" "+idle2+" a1="+angle1+" a2="+angle2)	
	if canAnimate
		DOM01.DOM_Anim.ClearActors(akRef,akAnotherActor)
		if DOM01.DOM_Anim.doAnimateAtActorLocation
			SetPositionMarker(akAnotherActor,akRef)
		else
			SetPositionMarker(akAnotherActor,akAnotherActor)
		endif
		DOM01.DOM_Anim.StartDualAnim(DualAnimationMarker,akRef,akAnotherActor,angle1,angle2)
		DOM01.DOM_Anim.PlayDualAnim(DualAnimationMarker,akRef,akAnotherActor,idle1,idle2)
	else
		DOM01.DOM_Anim.ClearActor(akAnotherActor)
		SetPositionMarker(akAnotherActor,akRef)
		DOM01.DOM_Anim.StartDualAnimAlone(DualAnimationMarker,akAnotherActor,angle2)
		DOM01.DOM_Anim.PlayDualAnimAlone(DualAnimationMarker,akAnotherActor,idle2)
	endif
EndFunction

Function PlayAnotherDualAnim(Actor akAnotherActor, string idle1, string idle2)
	LogAnim("PlayAnotherDualAnim "+idle1+" "+idle2)	
	if DualAnimationMarker == None
		if DOM01.DOM_Anim.doAnimateAtActorLocation
			ResetPositionMarker(akAnotherActor,akRef)
		else
			ResetPositionMarker(akAnotherActor,akAnotherActor)
		endif
	endif
	if canAnimate
		DOM01.DOM_Anim.PlayDualAnim(DualAnimationMarker,akRef,akAnotherActor,idle1,idle2)
	else
		DOM01.DOM_Anim.PlayDualAnimAlone(DualAnimationMarker,akAnotherActor,idle2)
	endif
EndFunction

Function PlayAnotherDualAnimOnlyAbuser(Actor akAnotherActor, string idle2)
	LogAnim("PlayAnotherDualAnimOnlyAbuser "+idle2)	
	if DualAnimationMarker == None
		ResetPositionMarker(akAnotherActor,akRef)
	endif
	DOM01.DOM_Anim.PlayDualAnimAlone(DualAnimationMarker,akAnotherActor,idle2)
EndFunction

Function EndDualAnim(Actor akAnotherActor)
	LogAnim("EndDualAnim ref="+akRef+" actor="+akAnotherActor+" a1="+JSONanim_angle1+" a2="+JSONanim_angle2)	
	if canAnimate
		DOM01.DOM_Anim.EndDualAnim(akRef,akAnotherActor)
	else
		DOM01.DOM_Anim.EndDualAnimAlone(akAnotherActor)
	endif
	ClearPositionMarker(akAnotherActor)
	canAnimateLocal = true
	LogTrace("EndDualAnim Anim_IdleReset")
	Anim_IdleReset()
EndFunction

Function EndDualAnimOnlyAbuser(Actor akAnotherActor)
	LogAnim("EndDualAnimOnlyAbuser ref="+akRef+" actor="+akAnotherActor+" a2="+JSONanim_angle2)	
	DOM01.DOM_Anim.EndDualAnimAlone(akAnotherActor)
	ClearPositionMarker(akAnotherActor)
	canAnimateLocal = true
EndFunction

; ### Animations ###

Function Anim_AggressorByString(Actor aggressor, string the_anim)
	LogAnim("Anim_AggressorByString "+the_anim+" animPlayer="+DOM01.doPlayerIdle+" is_group_order="+is_group_order)
	if aggressor == None || is_group_order
		return
	endif
	if aggressor == PlayerRef
		if DOM01.doPlayerIdle
			CalmActorFast(PlayerRef)
			if Game.GetCameraState() == 0
				Game.ForceThirdPerson()
			endif
			Debug.SendAnimationEvent(aggressor, the_anim)
		endif
		return
	endif
	CalmActorFast(aggressor)
	aggressor.setRestrained()
	aggressor.setDontMove()
	aggressor.SetLookAt(akRef)
	akRef.SetLookAt(aggressor)
	Debug.SendAnimationEvent(aggressor, the_anim)
EndFunction

Function Anim_AggressorReset(Actor aggressor)
	LogAnim("Anim_AggressorReset aggressor="+aggressor+" is_group_order="+is_group_order)
	if aggressor == None || is_group_order
		return
	endif
	if aggressor == PlayerRef
		return
	endif
	aggressor.setRestrained(false)
	aggressor.setDontMove(false)
EndFunction

Function Anim_LocalByString(string the_anim)
	LogAnim("Anim_LocalByString anim="+the_anim+" quietPose="+quietPose+" strugglePose="+strugglePose)
	if !canAnimate || the_anim == ""
		return
	endif
	CalmActorFast(akRef)
	Debug.SendAnimationEvent(akRef, the_anim)
EndFunction

Function Anim_ForcedByString(string the_anim)
	LogAnim("Anim_ForcedByString anim="+the_anim)
	if the_anim == ""
		return
	endif
	Debug.SendAnimationEvent(akRef, the_anim)
EndFunction

Function Anim_PoseByString(string the_anim)
	LogAnim("Anim_PoseByString "+the_anim)
	if !canAnimate || !canAnimateLocal || behaviour_is_busy || the_anim == ""
		return
	endif
	CalmActorFast(akRef)
	Debug.SendAnimationEvent(akRef, the_anim)
EndFunction

Function Anim_IdleByString(string the_anim)
	LogAnim("Anim_IdleByString "+the_anim)
	if !canIdle || the_anim == ""
		return
	endif
	Debug.SendAnimationEvent(akRef, the_anim)
EndFunction


Function Anim_Orgasm()
	if !canAnimate || !canAnimateLocal || behaviour_is_busy
		return
	endif
	if is_restrained && behaviour != "tied"
		return
	endif
	
	string the_anim
	if __has_cuffs_crossed || __has_cuffs_front
		the_anim = DOM01.DOM_Anim.GetCuffedArousedPose(self)
	elseif behaviour == "tied" || __has_armbinder || __has_cuffs_back || __has_cuffs_boxtied || __has_cuffs
		the_anim = DOM01.DOM_Anim.GetArmbinderArousedPose(self)
	elseif __has_yoke
		the_anim = DOM01.DOM_Anim.GetYokeArousedPose(self)
	else
		the_anim = DOM01.DOM_Anim.GetArousedPose(self)
	endif
	;*ogTrace("Anim_Orgasm() for "+ mind.GetMoodNameThirdPerson()+name+" pose="+the_anim)
	Debug.SendAnimationEvent(akRef, the_anim)
EndFunction

Function OnSexEnd()
	canAnimateSexlab = true
	canIdleSexlab = true
	ResumeBehaviour()
EndFunction

Function OnSexStartAlone()
	LogTrace("OnSexStartAlone")
	was_sexlab_started = true
	canAnimateSexlab = false
	ClearSexPartners()
	has_sex_with_player = false
	has_sex_alone = true
	mind.sex_is_non_consensual = false
	was_sexlab_ended = false
EndFunction

Function OnSexStart(DOM_Actor akPartner, bool hasPlayer, bool isNotConsensual)
	LogTrace("OnSexStart partner="+akPartner+" hasPlayer="+hasPlayer+" isNotConsensual="+isNotConsensual)
	was_sexlab_started = true
	canAnimateSexlab = false
	ClearSexPartners()
	if akPartner != None
		SetSexPartner(akPartner)
	elseif hasPlayer
		SetActorPartner(PlayerRef)
	endif
	has_sex_with_player = hasPlayer
	has_sex_alone = false
	mind.sex_is_non_consensual = isNotConsensual
	was_sexlab_ended = false
EndFunction

Function OnSexStartNPC(Actor akPartner, bool hasPlayer, bool isNotConsensual)
	LogTrace("OnSexStartNPC partner="+akPartner+" hasPlayer="+hasPlayer+" isNotConsensual="+isNotConsensual)
	was_sexlab_started = true
	canAnimateSexlab = false
	ClearSexPartners()
	SetActorPartner(akPartner)
	has_sex_with_player = hasPlayer
	has_sex_alone = false
	mind.sex_is_non_consensual = isNotConsensual
	was_sexlab_ended = false
EndFunction


Function Anim_OStim(Actor akOther, string tag, bool punishment, string reason_name = "")
	DOM_Actor akOtherActor = DOM01.GetActor(akOther)
	if akOtherActor == None
		Anim_OStimWithNPC(akOther,tag,punishment,reason_name)
	else
		Anim_OStimWithActor(akOtherActor,tag,punishment,reason_name)
	endif
EndFunction

Function Anim_OStimWithActor(DOM_Actor akAnotherActor, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_OStimWithActor actor="+akAnotherActor+" tag="+tag+" psh="+punishment)
	Actor the_actor
	if akAnotherActor == None
		has_sex_with_player = true
		the_actor = PlayerRef
	else
		has_sex_with_player = false
		the_actor = akAnotherActor.akRef
		akAnotherActor.OnSexStart(self,has_sex_with_player,false)
	endif
	OnSexStart(akAnotherActor,has_sex_with_player,punishment)
	Actor[] akActors        = new Actor[2]
	DOM_Actor[] akDOMActors = new DOM_Actor[2]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = the_actor
	akDOMActors[1] = akAnotherActor
	DOM01.DOMOSTIM.StartOStimWithArrays(akActors, akDOMActors, tag, punishment, reason_name)
EndFunction

Function Anim_OStimWithNPC(Actor akOther, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_OStimWithNPC actor="+akOther+" tag="+tag+" psh="+punishment)
	if akOther == None
		akOther = PlayerRef
		has_sex_with_player = true
	elseif akOther == PlayerRef
		has_sex_with_player = true
	else
		has_sex_with_player = false
	endif
	OnSexStartNPC(akOther,has_sex_with_player,punishment)
	Actor[] akActors        = new Actor[2]
	DOM_Actor[] akDOMActors = new DOM_Actor[2]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akOther
	akDOMActors[1] = None
	DOM01.DOMOSTIM.StartOStimWithArrays(akActors, akDOMActors, tag, punishment, reason_name)
EndFunction

Function Anim_Sexlab(Actor akOther, string tag, bool punishment, string reason_name = "")
	DOM_Actor akOtherActor = DOM01.GetActor(akOther)
	if akOtherActor == None
		Anim_SexlabWithNPC(akOther,tag,punishment,reason_name)
	else
		Anim_SexlabWithActor(akOtherActor,tag,punishment,reason_name)
	endif
EndFunction
Function Anim_SexlabWithActor(DOM_Actor akAnotherActor, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWithActor actor="+akAnotherActor+" tag="+tag+" psh="+punishment)
	Actor the_actor
	if akAnotherActor == None
		has_sex_with_player = true
		the_actor = PlayerRef
	else
		has_sex_with_player = false
		the_actor = akAnotherActor.akRef
		akAnotherActor.OnSexStart(self,has_sex_with_player,false)
	endif
	OnSexStart(akAnotherActor,has_sex_with_player,punishment)
	Actor[] akActors        = new Actor[2]
	DOM_Actor[] akDOMActors = new DOM_Actor[2]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = the_actor
	akDOMActors[1] = akAnotherActor
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWithNPC(Actor akOther, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWithNPC actor="+akOther+" tag="+tag+" psh="+punishment)
	if akOther == None
		akOther = PlayerRef
		has_sex_with_player = true
	elseif akOther == PlayerRef
		has_sex_with_player = true
	else
		has_sex_with_player = false
	endif
	OnSexStartNPC(akOther,has_sex_with_player,punishment)
	Actor[] akActors        = new Actor[2]
	DOM_Actor[] akDOMActors = new DOM_Actor[2]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akOther
	akDOMActors[1] = None
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWith3AAP(DOM_Actor akAnotherActor, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWith3AAP actor="+akAnotherActor+" tag="+tag+" psh="+punishment)
	if akAnotherActor == None ; need a partner for threesomes!
		return
	endif
	akAnotherActor.OnSexStart(self,true,false)
	OnSexStart(akAnotherActor,true,punishment)
	Actor[] akActors        = new Actor[3]
	DOM_Actor[] akDOMActors = new DOM_Actor[3]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akAnotherActor.akRef
	akDOMActors[1] = akAnotherActor
	akActors[2]    = PlayerRef
	akDOMActors[2] = None
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWith3ANP(Actor akOther, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWith3ANP actor="+akOther+" tag="+tag+" psh="+punishment)
	if akOther == None
		return
	endif
	OnSexStartNPC(akOther,true,punishment)
	Actor[] akActors        = new Actor[3]
	DOM_Actor[] akDOMActors = new DOM_Actor[3]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akOther
	akDOMActors[1] = None
	akActors[2]    = PlayerRef
	akDOMActors[2] = None
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWith3AAA(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWith3AAA actor1="+akAnotherActor1+" tag="+tag+" psh="+punishment)
	if akAnotherActor1 == None || akAnotherActor2 == None; need two partners for threesomes!
		return
	endif
	akAnotherActor1.OnSexStart(self,false,false)
	akAnotherActor2.OnSexStart(self,false,false)
	OnSexStart(akAnotherActor1,false,punishment)
	SetSexPartner(akAnotherActor2)
	akAnotherActor1.SetSexPartner(akAnotherActor2)
	akAnotherActor2.SetSexPartner(akAnotherActor1)
	Actor[] akActors        = new Actor[3]
	DOM_Actor[] akDOMActors = new DOM_Actor[3]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akAnotherActor1.akRef
	akDOMActors[1] = akAnotherActor1
	akActors[2]    = akAnotherActor2.akRef
	akDOMActors[2] = akAnotherActor2
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWith3AAN(DOM_Actor akAnotherActor, Actor akOther, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWith3AAN actor1="+akAnotherActor+" tag="+tag+" psh="+punishment)
	if akOther == None || akAnotherActor == None; need two partners for threesomes!
		return
	endif
	akAnotherActor.OnSexStart(self,false,false)
	OnSexStart(akAnotherActor,false,punishment)
	SetActorPartner(akOther)
	akAnotherActor.SetActorPartner(akOther)
	Actor[] akActors        = new Actor[3]
	DOM_Actor[] akDOMActors = new DOM_Actor[3]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akAnotherActor.akRef
	akDOMActors[1] = akAnotherActor
	akActors[2]    = akOther
	akDOMActors[2] = None
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWith4AAAP(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWith4AAAP actor="+akAnotherActor1+" tag="+tag+" psh="+punishment)
	if akAnotherActor1 == None || akAnotherActor2 == None ; need two partners for foursomes!
		return
	endif
	akAnotherActor1.OnSexStart(self,true,false)
	akAnotherActor2.OnSexStart(self,true,false)
	OnSexStart(akAnotherActor1,true,punishment)
	SetSexPartner(akAnotherActor2)
	akAnotherActor1.SetSexPartner(akAnotherActor2)
	akAnotherActor2.SetSexPartner(akAnotherActor1)
	Actor[] akActors        = new Actor[4]
	DOM_Actor[] akDOMActors = new DOM_Actor[4]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akAnotherActor1.akRef
	akDOMActors[1] = akAnotherActor1
	akActors[2]    = akAnotherActor2.akRef
	akDOMActors[2] = akAnotherActor2
	akActors[3]    = PlayerRef
	akDOMActors[3] = None
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWith4AANP(DOM_Actor akAnotherActor, Actor akOther, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWith4AANP actor="+akOther+" tag="+tag+" psh="+punishment)
	if akAnotherActor == None || akOther == None
		return
	endif
	akAnotherActor.OnSexStart(self,true,false)
	OnSexStart(akAnotherActor,true,punishment)
	SetActorPartner(akOther)
	akAnotherActor.SetActorPartner(akOther)
	Actor[] akActors        = new Actor[4]
	DOM_Actor[] akDOMActors = new DOM_Actor[4]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akAnotherActor.akRef
	akDOMActors[1] = akAnotherActor
	akActors[2]    = akOther
	akDOMActors[2] = None
	akActors[3]    = PlayerRef
	akDOMActors[3] = None
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWith4AAAA(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, DOM_Actor akAnotherActor3, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWith4AAAA actor1="+akAnotherActor1+" tag="+tag+" psh="+punishment)
	if akAnotherActor1 == None || akAnotherActor2 == None || akAnotherActor3 == None; need three partners for foursomes!
		return
	endif
	akAnotherActor1.OnSexStart(self,false,false)
	akAnotherActor2.OnSexStart(self,false,false)
	akAnotherActor3.OnSexStart(self,false,false)
	OnSexStart(akAnotherActor1,false,punishment)
	SetSexPartner(akAnotherActor2)
	SetSexPartner(akAnotherActor3)
	akAnotherActor1.SetSexPartner(akAnotherActor2)
	akAnotherActor1.SetSexPartner(akAnotherActor3)
	akAnotherActor2.SetSexPartner(akAnotherActor1)
	akAnotherActor2.SetSexPartner(akAnotherActor3)
	akAnotherActor3.SetSexPartner(akAnotherActor1)
	akAnotherActor3.SetSexPartner(akAnotherActor2)
	Actor[] akActors        = new Actor[4]
	DOM_Actor[] akDOMActors = new DOM_Actor[4]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akAnotherActor1.akRef
	akDOMActors[1] = akAnotherActor1
	akActors[2]    = akAnotherActor2.akRef
	akDOMActors[2] = akAnotherActor2
	akActors[3]    = akAnotherActor3.akRef
	akDOMActors[3] = akAnotherActor3
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_SexlabWith4AAAN(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, Actor akOther, string tag, bool punishment, string reason_name = "")
	LogAnim("Anim_SexlabWith4AAAN actor1="+akAnotherActor1+" tag="+tag+" psh="+punishment)
	if akOther == None || akAnotherActor1 == None || akAnotherActor2 == None ; need three partners for foursomes!
		return
	endif
	akAnotherActor1.OnSexStart(self,false,false)
	akAnotherActor2.OnSexStart(self,false,false)
	OnSexStart(akAnotherActor1,false,punishment)
	SetSexPartner(akAnotherActor2)
	akAnotherActor1.SetSexPartner(akAnotherActor2)
	akAnotherActor2.SetSexPartner(akAnotherActor1)
	SetActorPartner(akOther)
	akAnotherActor1.SetActorPartner(akOther)
	akAnotherActor2.SetActorPartner(akOther)
	Actor[] akActors        = new Actor[4]
	DOM_Actor[] akDOMActors = new DOM_Actor[4]
	akActors[0]    = akRef
	akDOMActors[0] = self
	akActors[1]    = akAnotherActor1.akRef
	akDOMActors[1] = akAnotherActor1
	akActors[2]    = akAnotherActor2.akRef
	akDOMActors[2] = akAnotherActor2
	akActors[3]    = akOther
	akDOMActors[3] = None
	DOM01.DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, quietPose, tag, punishment, reason_name)
EndFunction

Function Anim_Sweep()
	if !canIdle
		return
	endif
	Debug.SendAnimationEvent(akRef, DOM01.DOM_Anim.GetBroomPose(self))
EndFunction

Function Anim_OnFour()
	if !canIdle
		return
	endif
	Debug.SendAnimationEvent(akRef, "DOMWalkOnFour")
EndFunction

Function Anim_Stagger()
	LogAnim("Anim_Stagger")
	if !canIdle
		return
	endif
	akRef.PlayIdle(DOM01.staggerStart)
EndFunction

Function Anim_Strip(bool do_bottom)
	LogAnim("Anim_Strip sex="+actorSex)
	if !canMove
		return
	endif
	if is_bounded
		return
	endif
	Debug.SendAnimationEvent(akRef, DOM01.DOM_Anim.GetStripPose(self))
EndFunction

Function Anim_Undress(Actor akAbuser)
	LogAnim("Anim_Undress sex="+actorSex)
	StartJSONAnimation(akAbuser,"DOMUndress")
	PlayJSONAnimations(1,JSONanim_nscenes-(1))
	EndJSONAnimation()
EndFunction

Function Anim_DressUp(bool do_bottom)
	LogAnim("Anim_DressUp sex="+actorSex)
	if !canMove
		return
	endif
	if is_bounded
		return
	endif
	if do_bottom
		LogAnim("Anim_DressUp Bottom")
		Debug.SendAnimationEvent(akRef, DOM01.DOM_Anim.GetDressBottomPose(self)) ; dress bottom
		Wait(2.0*DOM01.anim_speed_sec)
	endif
	LogAnim("Anim_DressUp Top")
	Debug.SendAnimationEvent(akRef, DOM01.DOM_Anim.GetDressTopPose(self)) ; dress top
	;Wait(1.0*DOM01.anim_speed_sec)
EndFunction

bool drunk_active = false
Function Anim_DrunkStart()
	LogAnim("Anim_DrunkStart")
	if !canMove
		return
	endif
	akRef.PlayIdle(DOM01.IdleDrunkStart)
	drunk_active = true
EndFunction

Function Anim_DrunkReset()
	if mind.drunk_level >= 3
		Anim_DrunkStart()
	else
		drunk_active = true ; force reset
		Anim_DrunkStop()
	endif
EndFunction

Function Anim_DrunkStop()
	LogAnim("IdleDrunkStop")
	if !drunk_active
		return
	endif
	if canMove
		CalmActorFast(akRef)
	endif
	akRef.PlayIdle(DOM01.IdleDrunkStop)
	drunk_active = false
EndFunction

; DD Offset animations (* means DOM implemented)
; * 100001 Elbow tie hands in back
; * 100002 Front Cuffs
;   100003 BB Yoke
;   100004 Elbow Armbinder
;   100005 Yoke
;   100006 Armbinder
; * 100007 Cold Elbow tie hands in back
; * 100008 Cold Front Cuffs
;   100009 Cold BB Yoke
;   100010 Cold Elbow Armbinder
;   100011 Cold Yoke
;   100011 Cold Armbinder
;      10x Pony gear (no cuffs)
;      20x Hobbled (no cuffs)
; *    301 Blindfolded
;      302 Ball and chain (no cuffs)
;      303 Horny and restrained hands at belt level
; *    381 Blindfolded Elbow tie hands in back
; *    382 Blindfolded Front Cuffs
;      38x Blindfolded
;      39x Blindfolded
; *    500 Out of stamina with zad Lockable
; *    501 Out of stamina Elbow tie hands in back
; *    502 Out of stamina Front Cuffs
;      50x Out of stamina
;      60x Out of stamina + hobbled

Function Anim_BoundStartArmbinder()
	if __has_cuffs_front
		has_cuffs_front = false
	endif		
	if __has_cuffs_back
		has_cuffs_back = false
	endif
	if __has_cuffs_boxtied
		has_cuffs_boxtied = false
	endif
	if __has_cuffs_crossed
		has_cuffs_crossed = false
	endif
	if __has_yoke
		has_yoke = false
	endif
	Form the_wrist = GetEquippedWrist(akRef)
	if the_wrist != None && the_wrist != equipped_cuffs
		UnEquipItemLoose(akRef,the_wrist)
	endif
	if equipped_cuffs == None
		EquipCuffs(DOM01.DOMZaz.GetArmbinder())
	elseif !(DOM01.DOMZaz.hasKeywordArmbinder(equipped_cuffs))
		EquipCuffs(DOM01.DOMZaz.GetArmbinder())
	endif
	LogAnim("Anim_BoundStartArmbinder has_armbinder="+__has_armbinder+" is_bounded="+is_bounded+" is_restrained="+is_restrained+" cuffs="+equipped_cuffs)
	Debug.SendAnimationEvent(akRef, "offsetBoundStandingStartArmbinder")
	has_armbinder = true
EndFunction

Function Anim_BoundStartYoke() 
	if __has_cuffs_front
		has_cuffs_front = false
	endif		
	if __has_cuffs_back
		has_cuffs_back = false
	endif
	if __has_cuffs_boxtied
		has_cuffs_boxtied = false
	endif
	if __has_cuffs_crossed
		has_cuffs_crossed = false
	endif
	if __has_armbinder
		has_armbinder = false
	endif
	Form the_collar = DOM01.DOMZaz.GetEquippedCollar(akRef)
	if the_collar != None && the_collar != equipped_cuffs
		UnEquipItemTight(akRef,the_collar)
	endif
	the_collar = GetEquippedNecklace(akRef)
	if the_collar != None && the_collar != equipped_cuffs
		UnEquipItemLoose(akRef,the_collar)
	endif
	if equipped_cuffs == None
		EquipCuffs(DOM01.DOMZaz.GetYoke())
	elseif !(DOM01.DOMZaz.hasKeywordYoke(equipped_cuffs))
		EquipCuffs(DOM01.DOMZaz.GetYoke())
	elseif !akRef.IsEquipped(equipped_cuffs)
		EquipItemTight(akRef,equipped_cuffs)
	endif
	LogAnim("Anim_BoundStartYoke has_yoke="+__has_yoke+" is_bounded="+is_bounded+" is_restrained="+is_restrained+" cuffs="+equipped_cuffs)
	Debug.SendAnimationEvent(akRef, "offsetBoundStandingStartYoke")
	has_yoke = true ; IsInFaction("DiaryOfMine.esm"|0x00E58343) DD 100005 Yoke
EndFunction

Function Anim_BoundStartFront() ; Arms cuffed in front loose not crossed
	if __has_cuffs_back
		has_cuffs_back = false
	endif
	if __has_cuffs_boxtied
		has_cuffs_boxtied = false
	endif
	if __has_cuffs_crossed
		has_cuffs_crossed = false
	endif
	if __has_yoke
		has_yoke = false
	endif
	if __has_armbinder
		has_armbinder = false
	endif
	if equipped_cuffs == None
		EquipCuffs(DOM01.DOMZaz.GetWristRope())
	elseif !(DOM01.DOMZaz.hasKeywordWrist(equipped_cuffs))
		EquipCuffs(DOM01.DOMZaz.GetWristRope())
	endif
	LogAnim("Anim_BoundStartFront has_cuffs_front="+__has_cuffs_front+" is_bounded="+is_bounded+" is_restrained="+is_restrained+" cuffs="+equipped_cuffs)
	Debug.SendAnimationEvent(akRef, "offsetBoundStandingStartFront")
	has_cuffs_front = true ; IsInFaction("DiaryOfMine.esm"|0x00E58343) DD 100002 Front Cuffs
EndFunction

Function Anim_BoundStartCrossed() ; Arms cuffed in front tight crossed
	if __has_cuffs_front
		has_cuffs_front = false
	endif		
	if __has_cuffs_back
		has_cuffs_back = false
	endif
	if __has_cuffs_boxtied
		has_cuffs_boxtied = false
	endif
	if __has_yoke
		has_yoke = false
	endif
	if __has_armbinder
		has_armbinder = false
	endif
	if equipped_cuffs == None
		EquipCuffs(DOM01.DOMZaz.GetCuffsPrisoner())
	elseif !(DOM01.DOMZaz.hasKeywordWrist(equipped_cuffs))
		EquipCuffs(DOM01.DOMZaz.GetCuffsPrisoner())
	endif
	LogAnim("Anim_BoundStartCrossed has_cuffs_crossed="+__has_cuffs_crossed+" is_bounded="+is_bounded+" is_restrained="+is_restrained+" cuffs="+equipped_cuffs)
	Debug.SendAnimationEvent(akRef, "offsetBoundStandingStartCrossed")
	has_cuffs_crossed = true ; IsInFaction("DiaryOfMine.esm"|0x00E7BA4A) DAR 400000320
EndFunction

Function Anim_BoundStartBack()
	if __has_cuffs_front
		has_cuffs_front = false
	endif		
	if __has_cuffs_boxtied
		has_cuffs_boxtied = false
	endif
	if __has_cuffs_crossed
		has_cuffs_crossed = false
	endif
	if __has_yoke
		has_yoke = false
	endif
	if __has_armbinder
		has_armbinder = false
	endif
	if equipped_cuffs == None
		EquipCuffs(DOM01.DOMZaz.GetWristRope())
	elseif !(DOM01.DOMZaz.hasKeywordWrist(equipped_cuffs))
		EquipCuffs(DOM01.DOMZaz.GetWristRope())
	endif
	LogAnim("Anim_BoundStartBack has_cuffs_back="+__has_cuffs_back+" is_bounded="+is_bounded+" is_restrained="+is_restrained+" cuffs="+equipped_cuffs)
	Debug.SendAnimationEvent(akRef, "offsetBoundStandingStartBack")
	has_cuffs_back = true ; IsInFaction("DiaryOfMine.esm"|0x00E43F3F) DD 100001 Elbow tie
EndFunction

Function Anim_BoundStartBoxTied()
	if __has_cuffs_front
		has_cuffs_front = false
	endif		
	if __has_cuffs_back
		has_cuffs_back = false
	endif
	if __has_cuffs_crossed
		has_cuffs_crossed = false
	endif
	if __has_yoke
		has_yoke = false
	endif
	if __has_armbinder
		has_armbinder = false
	endif
	if equipped_cuffs == None
		EquipCuffs(DOM01.DOMZaz.GetWristRope())
	elseif !(DOM01.DOMZaz.hasKeywordWrist(equipped_cuffs))
		EquipCuffs(DOM01.DOMZaz.GetWristRope())
	endif
	LogAnim("Anim_BoundStartBoxTied has_cuffs_boxtied="+has_cuffs_boxtied+" is_bounded="+is_bounded+" is_restrained="+is_restrained+" cuffs="+equipped_cuffs)
	Debug.SendAnimationEvent(akRef, "offsetBoundStandingStartBoxtied")
	has_cuffs_boxtied = true ; IsInFaction("DiaryOfMine.esm"|0x00E7BA4B)
EndFunction

Function Anim_BoundStop()
	LogAnim("Anim_BoundStop start IsCuffed()="+IsCuffed()+" has_arms_device="+__has_arms_device)
	if !IsCuffed() && !__has_arms_device
		if equipped_cuffs != None
			LogAnim("Anim_BoundStop RemoveCuffs 1 equipped_cuffs="+equipped_cuffs+" has_arms_device="+__has_arms_device)
			RemoveCuffs()
			LogAnim("Anim_BoundStop RemoveCuffs 2 equipped_cuffs="+equipped_cuffs+" has_arms_device="+__has_arms_device)
		endif
		return
	endif
		
	LogAnim("Anim_BoundStop uncuff behaviour="+behaviour+" has_cuffs_back="+__has_cuffs_back+" has_cuffs_boxtied="+__has_cuffs_boxtied+" has_cuffs_front="+__has_cuffs_front+" has_cuffs_crossed="+__has_cuffs_crossed+" has_yoke="+__has_yoke+" has_armbinder="+__has_armbinder+" cuffs="+equipped_cuffs)
	if canMove
		CalmActorFast(akRef)
	endif
	if __has_cuffs_boxtied
		has_cuffs_boxtied = false
		LogAnim("Anim_BoundStop RemoveCuffs Boxtied")
		RemoveCuffs()
		akRef.PlayIdle(DOM01.OffsetStop)
	endif
	if __has_cuffs_back
		has_cuffs_back = false
		LogAnim("Anim_BoundStop RemoveCuffs Back")
		RemoveCuffs()
		akRef.PlayIdle(DOM01.OffsetStop)
	endif
	if __has_cuffs_crossed
		has_cuffs_crossed = false
		LogAnim("Anim_BoundStop RemoveCuffs Crossed")
		RemoveCuffs()
		akRef.PlayIdle(DOM01.OffsetStop)
	endif		
	if __has_cuffs_front
		has_cuffs_front = false
		LogAnim("Anim_BoundStop RemoveCuffs Front")
		RemoveCuffs()
		akRef.PlayIdle(DOM01.OffsetStop)
	endif	
	if __has_yoke
		has_yoke = false
		LogAnim("Anim_BoundStop RemoveCuffs Yoke")
		RemoveCuffs()
		akRef.PlayIdle(DOM01.OffsetStop)
	endif	
	if __has_armbinder
		has_armbinder = false
		LogAnim("Anim_BoundStop RemoveCuffs Armbinder")
		RemoveCuffs()
		akRef.PlayIdle(DOM01.OffsetStop)
	endif	
	LogAnim("Anim_BoundStop reset"+" behaviour="+behaviour)
	Debug.SendAnimationEvent(akRef,"IdleForceDefaultState")
EndFunction

Function Anim_VictimTieUpExit()
	LogAnim("Anim_VictimTieUpExit pose="+exitPose)
	if !canIdle
		return
	endif
	Debug.SendAnimationEvent(akRef, exitPose)
EndFunction

Function Anim_VictimTieUpEnter()
	LogAnim("Anim_VictimTieUpEnter pose="+enterPose)
	if !canAnimate
		return
	endif
	Debug.SendAnimationEvent(akRef, enterPose)
EndFunction

Function Anim_AggressorTyingUp()
	LogAnim("Anim_AggressorTyingUp")
	if !canIdle
		return
	endif
	Debug.SendAnimationEvent(akRef, DOM01.DOM_Anim.GetTieUpPose(None))
EndFunction

Function Anim_IdleStop()
	LogAnim("Anim_IdleStop")
	if !canAnimate
		return
	endif
	CalmActorFast(akRef)
	akRef.PlayIdle(DOM01.IdleStop_Loose)
EndFunction

Function Anim_IdleReset()
	LogAnim("Anim_IdleReset START wait_for_equipment="+wait_for_equipment+" is_walking_on_four "+mind.is_walking_on_four+" is_restrained="+is_restrained+" is_bounded="+is_bounded+" has_yoke="+__has_yoke+" behaviour="+behaviour+" IsDead="+akRef.IsDead())
	if !canAnimate
		return
	endif
	if wait_for_equipment
		return
	endif
	if is_restrained || is_behaviour_pose || is_behaviour_masturbate
		LogAnim("Anim_IdleReset Anim_Pose")
		CalmActorFast(akRef)
		Anim_Pose()
		return
	endif
	if mind.is_walking_on_four ; && isMovingBehaviour(behaviour)
		LogAnim("Anim_IdleReset Walking on four")
		Debug.SendAnimationEvent(akRef,"IdleForceDefaultState")
		;Debug.SendAnimationEvent(akRef, "DOMWalkOnFour")
		return
	endif
	if __has_yoke
		LogAnim("Anim_IdleReset Anim_BoundStartYoke")
		Anim_BoundStartYoke()
		return
	endif
	if __has_armbinder
		LogAnim("Anim_IdleReset Anim_BoundStartArmbinder")
		Anim_BoundStartArmbinder()
		return
	endif
	if __has_cuffs_boxtied
		LogAnim("Anim_IdleReset Anim_BoundStartBoxTied")
		Anim_BoundStartBoxTied()
		return
	endif
	if __has_cuffs_back
		LogAnim("Anim_IdleReset Anim_BoundStartBack")
		Anim_BoundStartBack()
		return
	endif
	if __has_cuffs_crossed
		LogAnim("Anim_IdleReset Anim_BoundStartCrossed")
		Anim_BoundStartCrossed()
		return
	endif
	if __has_cuffs_front
		LogAnim("Anim_IdleReset Anim_BoundStartFront")
		Anim_BoundStartFront()
		return
	endif
	if is_bounded && isMovingBehaviour(behaviour)
		if __has_arms_device
			LogAnim("Anim_IdleReset Anim_BoundStartArmbinder default")
			Anim_BoundStartArmbinder()
		elseif __has_cuffs
			LogAnim("Anim_IdleReset Anim_BoundStartBack default has_cuffs="+__has_cuffs)
			Anim_BoundStartBack()
		endif
	endif
	if drunk_active
		LogAnim("Anim_IdleReset Anim_DrunkStart drunk_active="+drunk_active)
		Anim_DrunkStart()
		return
	endif
	CalmActorFast(akRef)
	LogAnim("Anim_IdleReset IdleForceDefaultState")
	Debug.SendAnimationEvent(akRef,"IdleForceDefaultState")
	;akRef.PlayIdle(DOM01.IdleForceDefaultState)
EndFunction

bool Function Anim_CoverSelf()
	if !canIdle
		LogAnim("Anim_CoverSelf FAILED")
		return false
	endif
	string the_idle = DOM01.DOM_Anim.GetCoveringPose(self)
	LogAnim("Anim_CoverSelf "+the_idle)
	Debug.SendAnimationEvent(akRef, the_idle)
	is_idling = true
	return true
EndFunction

bool Function Anim_Shamed()
	if !canIdle
		LogAnim("Anim_Shamed FAILED")
		return false
	endif
	string the_idle = DOM01.DOM_Anim.GetShamedPose(self)
	LogAnim("Anim_Shamed "+the_idle)
	Debug.SendAnimationEvent(akRef, the_idle)
	is_idling = true
	return true
EndFunction

bool Function Anim_Shocked()
	if !canIdle
		LogAnim("Anim_Shocked FAILED")
		return false
	endif
	string the_idle = DOM01.DOM_Anim.GetShockedPose(self)
	LogAnim("Anim_Shocked "+the_idle)
	Debug.SendAnimationEvent(akRef, the_idle)
	is_idling = true
	return true
EndFunction

bool Function Anim_WarmArms()
	if !canIdle
		return false
	endif
	LogAnim("Anim_WarmArms")
	akRef.PlayIdle(DOM01.IdleWarmArms)
	is_idling = true
	return true
EndFunction

bool bleedout_active = false
Function Anim_BleedOutStop()
	CalmActorFast(akRef)
	LogAnim("Anim_BleedOutStop")
	akRef.PlayIdle(DOM01.BleedOutStop)
	if actorType != 0 ; creatures and animals
		SpecialReset()
	endif
	bleedout_active = false
EndFunction

Function Anim_BleedOutStart()
	CalmActorFast(akRef)
	if akRef.Is3DLoaded()
		LogAnim("Anim_BleedOutStart")
		Debug.SendAnimationEvent(akRef,"BleedOutStart")
		bleedout_active = true
	endif
EndFunction

Function Anim_Attention()
	LogAnim("Anim_Attention")
	if !canIdle
		return
	endif
	Debug.SendAnimationEvent(akRef, DOM01.attentionPose)
	is_idling = true
EndFunction

Function Anim_Salute()
	LogAnim("Anim_Salute")
	if !canIdle
		return
	endif
	Debug.SendAnimationEvent(akRef, DOM01.salutePose)
	is_idling = true
EndFunction

Function Anim_Kneel()
	LogAnim("Anim_Kneel")
	if !canIdle
		return
	endif
	Debug.SendAnimationEvent(akRef, DOM01.kneelPose)
	is_idling = true
EndFunction

Function Anim_Cower()
	if !canIdle
		return
	endif
	LogAnim("Anim_Cower")
	akRef.PlayIdle(DOM01.IdleCoweringLoose)
	is_idling = true
EndFunction

Function Anim_Cries()
	LogAnim("Anim_Cries TRY")
	TryApplyTears()
	if !canIdle
		return
	endif
	LogAnim("Anim_Cries SUCCESS")
	akRef.PlayIdle(DOM01.IdleChildCryingStart)
	is_idling = true
EndFunction

Function Anim_LookDown()
	if !canIdle
		return
	endif
	LogAnim("Anim_LookDown")
	; akRef.PlayIdle(DOM01.IdleSilentBow) ; kneeling both hands on knees looking down
	Debug.SendAnimationEvent(akRef, DOM01.salutePose)
	is_idling = true
EndFunction

Function Anim_PleaseStop()
	if __has_cuffs_front
		Debug.SendAnimationEvent(akRef, "ZazAPOA009") ; Offset "fiddle play" or hands crossed up in front of chest/face
		return
	endif
	if __has_cuffs_crossed
		Debug.SendAnimationEvent(akRef, "ZazAPOA022") ; Offset hands not crossed up in front of chest/face
		return
	endif
	if __has_cuffs_boxtied
		Debug.SendAnimationEvent(akRef, "ZazAPOA011") ; Hands Behind Back Ankled box tied
		return
	endif
	if __has_cuffs_back || __has_armbinder
		Debug.SendAnimationEvent(akRef, "ZazAPOA002") ; A slight struggle animation
		return
	endif
	if !canIdle
		return
	endif
	LogAnim("Anim_PleaseStop")
	akRef.PlayIdle(DOM01.IdleDialogueDefensiveHandGesture)
	is_idling = true
EndFunction

Function Anim_Nervous()
	LogAnim("Anim_Nervous")
	if !canIdle
		return
	endif
	akRef.PlayIdle(DOM01.IdleNervous)
	is_idling = true
EndFunction

Function Anim_WipeBrow()
	LogAnim("Anim_WipeBrow")
	if !canIdle
		return
	endif
	akRef.PlayIdle(DOM01.IdleWipeBrow)
	is_idling = true
EndFunction

Function Anim_CrossArms()
	LogAnim("Anim_CrossArms")
	if !canIdle
		return
	endif
	akRef.PlayIdle(DOM01.IdleOffsetArmsCrossedStart)
	is_idling = true
EndFunction

Function Anim_AggressiveGesture()
	LogAnim("Anim_AggressiveGesture")
	if !canIdle
		return
	endif
	akRef.PlayIdle(DOM01.IdleCivilWarCheer)
	is_idling = true
EndFunction

Function Anim_Attack()
	LogAnim("Anim_Attack")
	if !canMove
		return
	endif
	;akRef.PlayIdle(DOM01.attackStart)
	Debug.SendAnimationEvent(akRef, "attackStart")
EndFunction

Function Anim_GetPlayerHug()
	LogAnim("Anim_GetPlayerHug")
	DOM01.HudNotification(name+" gives a hug to player")
	Anim_GetHug(PlayerRef)
EndFunction

Function Anim_GetHug(Actor akHugger)
	LogAnim("Anim_GetHug"+" hugger="+akHugger)
	if !canMove
		return
	endif
	CalmActorFast(akRef)
	CalmActorFast(akHugger)
	akRef.playIdleWithTarget(DOM01.pa_HugA,akHugger)
EndFunction

Function Anim_Drink(Actor akAbuser, Form the_drink, bool play_dual, bool play_wine, bool play_spill, bool play_cough)
	LogAnim("Anim_Drink"+" is_group_order="+is_group_order)
	if !canMove
		return
	endif
	canAnimateLocal = false
	if !play_dual || akAbuser == None || is_group_order
		EquipItemLoose(akRef,the_drink)
		if !play_wine
			Debug.SendAnimationEvent(akRef,DOM01.DOM_Anim.GetDrinkMeadPose(self))
		else
			Debug.SendAnimationEvent(akRef,DOM01.DOM_Anim.GetDrinkWinePose(self))
		endif
		if play_cough
			Wait(4.0*DOM01.anim_speed_sec)
			Anim_LocalByString(DOM01.DOM_Anim.GetCoughPose(self))
		endif
		;Wait(4.0*DOM01.anim_speed_sec)
		canAnimateLocal = true
		return
	endif
	
	string the_key
	if !play_wine
		the_key = "DOMDrinkMead"
	else
		the_key = "DOMDrinkWine"
	endif
	StartJSONAnimation(akAbuser,the_key)
	if play_spill	
		PlayJSONAnimation(1)
	else
		PlayJSONAnimations(2,JSONanim_nscenes-(1))
	endif
	EndJSONAnimation()
	if play_cough
		Anim_LocalByString(DOM01.DOM_Anim.GetCoughPose(self))
	endif
	canAnimateLocal = true
EndFunction

; ### Drinking and alcoholism

Function PushMeAway(float amount)
	if !akRef.Is3DLoaded()
		return
	endif
	akRef.PushActorAway(akRef, amount)
EndFunction

Function TripAndFall(float amount)
	if !canMove
		return
	endif
	if akRef.IsRunning() || akRef.IsSprinting()
		SendNotificationEmotion(name+" trips and falls")
		PushMeAway(mind.MOD_Panic*amount)
		mind.SetNextPunishmentReasonSilent(31) ; "being too slow"
	elseif !akRef.IsSwimming() && !akRef.IsFlying() && !akRef.IsOnMount()
		SendNotificationEmotion(name+" "+actorBeVerb+" loosing balance")
		Anim_LocalByString("DOMBaboDefeatKnockOutStart") 
		;Anim_LocalByString("DOMBaboDefeatKnockOutLoop")
		wait(1.0)
		PushMeAway(0.0)
	endif
EndFunction

bool Property alcohol_gift = false Auto Hidden

Function OrderDrink() ; Only player can gift with menu
	alcohol_gift = true
	int pts = akRef.ShowGiftMenu(true, DOM01.AlcoholicDrinksExtendedList, true, false)
	LogTrace("OrderDrink pts="+pts)
	if pts > 0
		Wait(4.0)
	endif
	alcohol_gift = false
EndFunction

Function OrderDrinkAlcohol(Actor akAbuser)
	LogTrace("OrderDrinkAlcohol is_group_order="+is_group_order+" is_restrained="+is_restrained)
	if (is_group_order || akAbuser == None) && is_restrained
		LogTrace("OrderDrinkAlcohol can not drink - restrained")
		return
	endif
	Form the_drink = DOM01.FindAlcoholInInventory(akRef)
	if the_drink == None
		LogTrace("OrderDrinkAlcohol no drink found in actor's inventory")
		the_drink = DOM01.FindAlcoholInInventory(akAbuser)
		if the_drink == None
			LogTrace("OrderDrinkAlcohol no drink found in player's inventory")
			return
		else
			LogTrace("OrderDrinkAlcohol found drink "+the_drink.GetName()+" in player's inventory")
		endif
	else
		LogTrace("OrderDrinkAlcohol found drink "+the_drink.GetName()+" in actor's inventory")
	endif
	OrderDrinkForm(akAbuser,the_drink)
EndFunction

Form Function GetAPotion(Actor akAbuser)
	if akRef.GetItemCount(DOM01.DOMLovePotion) > 0 && mind.is_love_interest
		return DOM01.DOMLovePotion
	endif
	if !mind.IsBrokenToObey() && akRef.GetItemCount(DOM01.DOMBrokenPotion) > 0
		return DOM01.DOMBrokenPotion
	endif
	if akRef.GetItemCount(DOM01.DOMLustPotion) > 0 && mind.is_love_interest
		return DOM01.DOMLustPotion
	endif
	if akRef.GetItemCount(DOM01.DOMPainPotion) > 0
		return DOM01.DOMPainPotion
	endif
	if akRef.GetItemCount(DOM01.DOMLustPotion) > 0
		return DOM01.DOMLustPotion
	endif
	; Search in owner inventory
	if GetObjectFrom(akAbuser,DOM01.DOMLovePotion) && mind.is_love_interest
		return DOM01.DOMLovePotion
	endif
	if !mind.IsBrokenToObey() && GetObjectFrom(akAbuser,DOM01.DOMBrokenPotion)
		return DOM01.DOMBrokenPotion
	endif
	if GetObjectFrom(akAbuser,DOM01.DOMLustPotion) && mind.is_love_interest
		return DOM01.DOMLustPotion
	endif
	if GetObjectFrom(akAbuser,DOM01.DOMPainPotion)
		return DOM01.DOMPainPotion
	endif
	return None
EndFunction

Form Function GetANarcotic(Actor akAbuser)
	if akRef.GetItemCount(DOM01.Skooma) > 0
		return DOM01.Skooma
	endif
	if akRef.GetItemCount(DOM01.WindhelmDoubleDistilledSkooma) > 0
		return DOM01.WindhelmDoubleDistilledSkooma
	endif
	if akRef.GetItemCount(DOM01.FreeformAngasMillKordirsSkooma) > 0
		return DOM01.FreeformAngasMillKordirsSkooma
	endif
	if akRef.GetItemCount(DOM01.TGTQ02BalmoraBlue) > 0
		return DOM01.TGTQ02BalmoraBlue
	endif
	if akRef.GetItemCount(DOM01.DLC1RedwaterDenSkooma) > 0
		return DOM01.DLC1RedwaterDenSkooma
	endif
	if akRef.GetItemCount(DOM01.dunSleepingTreeCampSap) > 0
		return DOM01.dunSleepingTreeCampSap
	endif
	if GetObjectFrom(akAbuser,DOM01.Skooma)
		return DOM01.Skooma
	endif
	if GetObjectFrom(akAbuser,DOM01.WindhelmDoubleDistilledSkooma)
		return DOM01.WindhelmDoubleDistilledSkooma
	endif
	if GetObjectFrom(akAbuser,DOM01.FreeformAngasMillKordirsSkooma)
		return DOM01.FreeformAngasMillKordirsSkooma
	endif
	if GetObjectFrom(akAbuser,DOM01.TGTQ02BalmoraBlue)
		return DOM01.TGTQ02BalmoraBlue
	endif
	if GetObjectFrom(akAbuser,DOM01.DLC1RedwaterDenSkooma)
		return DOM01.DLC1RedwaterDenSkooma
	endif
	if GetObjectFrom(akAbuser,DOM01.dunSleepingTreeCampSap)
		return DOM01.dunSleepingTreeCampSap
	endif
	return None
EndFunction

Function OrderDrinkThis(Actor akAbuser, Form the_drink)
	LogTrace("OrderDrinkThis the_drink="+the_drink+" is_group_order="+is_group_order+" is_restrained="+is_restrained)
	if (is_group_order || akAbuser == None) && is_restrained
		return
	endif
	if the_drink == None
		the_drink = GetAPotion(akAbuser)
		if the_drink == None
			LogTrace("OrderDrinkThis no potion found")
			return
		endif
		LogTrace("OrderDrinkThis found potion="+the_drink)
	endif
	if akRef.GetItemCount(the_drink) <= 0
		if akAbuser.GetItemCount(the_drink) <= 0
			return
		endif
		akAbuser.RemoveItem(the_drink,1,true,akRef)
		if akRef.GetItemCount(the_drink) <= 0
			return
		endif
	endif
	if the_drink == DOM01.DOMLovePotion
		DrinkLovePotion(akAbuser)
	elseif the_drink == DOM01.DOMBrokenPotion
		DrinkMindPotion(akAbuser)
	elseif the_drink == DOM01.DOMLustPotion
		DrinkLustPotion(akAbuser)
	elseif the_drink == DOM01.DOMPainPotion
		DrinkLashPotion(akAbuser)
	elseif DOM01.IsANarcotic(the_drink)
		DrinkNarcoticPotion(akAbuser,the_drink)
	elseif IsPotion(the_drink)
		if GetFromOwnerIfNeededAndEquipObject(akAbuser,the_drink)
			SendNotificationOrder(name+" quaffs a potion of "+the_drink.GetName())
		endif
	elseif the_drink != None
		; It might be alcohol, just try
		OrderDrinkForm(akAbuser,the_drink)
	endif
EndFunction

Function OrderDrinkForm(Actor akAbuser, Form the_drink)
	alcohol_gift = false
	LogTrace("was gifted alcohol "+the_drink.getName())
	float level = DOM01.GetFormAlcoholLevel(the_drink)	
	if level <= 0.0
		SendNotificationAbuse(name+" will drink an alcohol free beverage")
		return
	endif
	float amount = DrinkAlcohol(akAbuser, the_drink,level,true)
	if amount <=0.0
		SendNotificationAbuse(name+" will drink from an empty container")
		return
	endif
	;if !canIdle
	;	behaviour = "wait"
	;endif
	float modifier = GetAlcoholModifier()
	mind.IngestAlcohol(amount*modifier)
EndFunction

Function OrderDrinkFormNoAnim(Form the_drink)
	alcohol_gift = false
	LogTrace("was gifted alcohol "+the_drink.getName())
	float level = DOM01.GetFormAlcoholLevel(the_drink)	
	float amount = DrinkAlcohol(None,the_drink,level,false)
	if amount <=0.0 
		SendNotificationAbuse(name+" will drink from an empty container")
		return
	endif
	if level <= 0.0
		SendNotificationAbuse(name+" will drink an alcohol free beverage")
		return
	endif
	float modifier = GetAlcoholModifier()
	mind.IngestAlcohol(amount*modifier)
EndFunction

float Function GetAlcoholModifier()
	; drunk amount depends on
	; 1) body size
	float weight = akRef.GetActorValue("Mass") ; current mass
	float modifier = (1.0+weight)/2.0
	; 2) past drinking history
	;    not implemented
	; 3) sex
	if ((actorSex%2) == 1)
		modifier = modifier*1.25
	endif
	; 4) amount of food eaten 
	;    not implemented - quickest when alcohol is drunk on an empty stomach and the concentration of alcohol is 20-30%
	; 5) additional drugs taken
	;    not implemented
	; 6) age (younger and older are more sensitive)
	Race akActorRace  = akRef.GetLeveledActorBase().GetRace()
	string raceString = akActorRace.getName()+" "+MiscUtil.GetRaceEditorID(akActorRace)
	if DOM01.DOMGenerator.IsYoungAdult(raceString)
		modifier = modifier*1.5
	elseif DOM01.DOMGenerator.IsElder(raceString)
		modifier = modifier*1.25
	endif
	return modifier
EndFunction

float Function DrinkAlcohol(Actor akAbuser, Form the_drink, float modifier, bool do_anim)
	LogTrace("DrinkAlcohol akAbuser="+akAbuser+" the_drink="+the_drink+" modifier="+modifier+" do_anim="+do_anim)
	; Check alcohol content of drink
	; Form should be alchemy, should have damage stamina regeneration
	; Magnitude of damage stamina regeneration -> alcohol strength 
	float amount = the_drink.GetWeight()
	if amount == 0.0
		amount = 0.5 ; default
	endif
	;*ogTrace("item "+the_drink.getName()+" weight = "+the_drink.GetWeight()+" modifier = "+modifier)

	bool play_wine = modifier >= 2.0
	bool play_dual = !(mind.IsDevoted()) && DOM01.dualAnimToggle && !is_group_order
	if !mind.is_slave
		play_dual = false
	endif
	
	float norm = 100.0
	Race akActorRace  = akRef.GetLeveledActorBase().GetRace()
	string raceString = akActorRace.getName()+" "+MiscUtil.GetRaceEditorID(akActorRace)
	if DOM01.DOMGenerator.IsYoungAdult(raceString)
		norm = 150.0
	endif
	
	if modifier > 2.0 && ((amount > 0.1 && norm > 100.0) || RandomFloat()*norm > mind.FACET_Toughness)
		if amount > 0.1
			amount = 0.1
		endif
		if do_anim
			Anim_Drink(akAbuser,the_drink, play_dual,play_wine, true, true)
		endif
		SendNotificationAbuse(name+" coughs while trying to swallow the "+the_drink.getName()+", spilling most of it.")
	elseif amount > 0.2 && RandomFloat()*norm > mind.FACET_Wilfulness
		amount = 0.2
		if do_anim
			Anim_Drink(akAbuser,the_drink, play_dual, play_wine, true, false)
		endif
		SendNotificationAbuse(name+" barely manages to swallow some of the "+the_drink.getName()+", spilling most of it.")
	elseif amount > 0.5 && (RandomFloat()*norm > mind.FACET_Wilfulness || RandomFloat()*norm > mind.FACET_Toughness)
		amount = 0.5
		if do_anim
			Anim_Drink(akAbuser,the_drink, play_dual, play_wine, true, false)
		endif
		SendNotificationAbuse(name+" struggles to drink the bottle of "+the_drink.getName())
	else
		if do_anim
			Anim_Drink(akAbuser,the_drink, play_dual, play_wine, false, false)
		endif
		SendNotificationAbuse(name+" drinks the full bottle of "+the_drink.getName())
	endif

	DropAndDeleteObject(the_drink)
	if do_anim
		LogTrace("DrinkAlcohol Anim_IdleReset")
		Anim_IdleReset()
	endif
	Wait(1.0)

	; 0.5 = 2 glasses of beer = 0.05% blood alcohol -> hence /10 to have a number in % of alcohol
	return amount*modifier/10.0
EndFunction

Function DropAndDeleteObject(Form the_form)
	wait_for_equipment = true
	int nb = akRef.getItemCount(the_form)
	if nb <=0 
		OwnerDropAndDeleteObject(the_form)
		return
	endif
	if akRef.IsEquipped(the_form)
		if DOM01.DOMEquip.IsItemDevice(the_form) || DOM01.DOMEquip.IsItemSpecial(the_form)
			UnEquipItemTight(akRef,the_form)
		else
			UnEquipItemLoose(akRef,the_form)
		endif
	endif
	akRef.RemoveItem(the_form,1)
	wait_for_equipment = false
EndFunction

Function OwnerDropAndDeleteObject(Form the_form)
	Actor akAbuser = GetCurrentTrainer()
	wait_for_equipment = true
	if akAbuser.IsEquipped(the_form)
		if DOM01.DOMEquip.IsItemDevice(the_form) || DOM01.DOMEquip.IsItemSpecial(the_form)
			UnEquipItemTight(akRef,the_form)
		else
			UnEquipItemLoose(akRef,the_form)
		endif
	endif
	akAbuser.RemoveItem(the_form,1)
	wait_for_equipment = false
EndFunction

; ### Crime faction

Faction Property origCrimeFaction Auto Hidden

Function SetCrimeFaction()
	origCrimeFaction = akRef.GetCrimeFaction()
	if origCrimeFaction == None || origCrimeFaction == DOM01.DOMPlayerEnemyFaction
		origCrimeFaction = DOM01.DOMPlayerEnemyFaction
		akRef.RemoveFromFaction(DOM01.DOMNoCleanCrimeFaction)
	else
		akRef.SetFactionRank(DOM01.DOMNoCleanCrimeFaction,1)
		akRef.RemoveFromFaction(origCrimeFaction)
	endif
	akRef.AddToFaction(DOM01.DunPlayerAllyFaction)
	akRef.SetCrimeFaction(None)
EndFunction

Function CleanCrimeFaction()
	if origCrimeFaction != None && origCrimeFaction != DOM01.DOMPlayerEnemyFaction
		akRef.RemoveFromFaction(origCrimeFaction)
	endif
	origCrimeFaction = DOM01.DOMPlayerEnemyFaction
	akRef.RemoveFromFaction(DOM01.DOMNoCleanCrimeFaction)
	akRef.AddToFaction(DOM01.DunPlayerAllyFaction)
	akRef.SetCrimeFaction(None)
EndFunction

Faction Function GetCrimeFaction()
	;*ogTrace("GetCrimeFaction "+origCrimeFaction)
	if origCrimeFaction == DOM01.DOMPlayerEnemyFaction
		return None
	endif
	return origCrimeFaction
EndFunction

Function TurnOnCrimeFaction()
	if mind.is_player_actor
		return
	endif
	; ensure actor is not going to die after first blow from player or followers
	LogTrace("TurnOnCrimeFaction start health="+akRef.GetActorValue("health"))
	;akRef.ModActorValue("health", 1000.0) ; Set maximum health
	akRef.SetPlayerTeammate(false)
	akRef.IgnoreFriendlyHits(false)
	akRef.RemoveFromFaction(DOM01.DunPlayerAllyFaction)
	akRef.RemoveFromFaction(DOM01.dunPrisonerFaction)
	akRef.SetFactionRank(DOM01.DOMPlayerEnemyFaction,1)
	;akRef.SetCrimeFaction(origCrimeFaction) ; We will try to avoid doing this
	akRef.SetCrimeFaction(None) ; already set to None but other quests might be overwriting it
	LogTrace("TurnOnCrimeFaction end health="+akRef.GetActorValue("health"))
EndFunction

Function TurnOffCrimeFaction()
	if mind.is_player_actor
		return
	endif
	LogTrace("TurnOffCrimeFaction start health="+akRef.GetActorValue("health"))
	akRef.RemoveFromFaction(DOM01.DOMPlayerEnemyFaction)
	;if origCrimeFaction != None && origCrimeFaction != DOM01.DOMPlayerEnemyFaction
	;	akRef.RemoveFromFaction(origCrimeFaction)
	;endif
	akRef.SetCrimeFaction(None) ; already set to None but other quests might be overwriting it
	akRef.StopCombatAlarm()
	akRef.SetPlayerTeammate(mind.should_fight_for_player)
	akRef.IgnoreFriendlyHits(true)
	;akRef.SetFactionOwner(DOM01.PlayerFaction) ; already set
	akRef.SetNotShowOnStealthMeter(true)
	akRef.AddToFaction(DOM01.DunPlayerAllyFaction)
	if mind.is_slave
		akRef.AddToFaction(DOM01.dunPrisonerFaction)
	endif
	;akRef.ModActorValue("health", -1000.0) ; Set maximum health
	LogTrace("TurnOffCrimeFaction end health="+akRef.GetActorValue("health"))
EndFunction

; ### Factions

Function CleanFactions(Actor akRef)
	string beh = behaviour
	string mood = mind.mood
	akRef.SetCrimeFaction(None)
	Int [] fact_save1 = DOM01.SaveFactions1(akRef) ; Save factions
	Int [] fact_save2 = DOM01.SaveFactions2(akRef) ; Save factions
	DOM01.CleanFactions(akRef)
	akRef.RemoveFromAllFactions() 
	DOM01.RestoreFactions(akRef,fact_save1,fact_save2) ; Restore factions
	akRef.removeFromFaction(DOM01.DOMNoCleanFaction)
	akRef.RemoveFromFaction(DOM01.DOMNoCleanCrimeFaction)
	akRef.RemoveFromFaction(DOM01.DOMActorRivalIsVictim)
	akRef.RemoveFromFaction(DOM01.DOMActorFriendIsVictim)
	akRef.RemoveFromFaction(DOM01.DOMActorIsVictim)
	akRef.IgnoreFriendlyHits(true)
	behaviour = beh
	mind.mood = mood
EndFunction

; ### Running away

bool Function TryRunAway()
	if behaviour_is_busy
		return false
	endif
	if is_running_away ; already running
		return false
	endif
	if !canRunAway
		TryCallForHelp(true)
		return false
	endif
	if actor_trainer != None
		if IsTogetherWithFast(actor_trainer.akRef, akRef, 2000.0)
			SendNotification(name+" was caught trying to run away by "+actor_trainer.GetTitle()+actor_trainer.GetName())
			TryCallForHelp(true)		
			DOM_Mind akAggressorMind = DOM01.GetMindFromActor(actor_trainer)
			if akAggressorMind != None
				akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
				akAggressorMind.CheckAndRegisterKink(107,1.0) ; "managing slaves"
			endif
			return false
		endif
	endif
	SendNotification(name+" "+actorBeVerb+" trying to run away")	
	behaviour = "running_away"
	if DOM01.friendToggle
		TryRunAwayFriends()
	endif
	return true
EndFunction

; Same as above but slave is part of a gang running away so no need to call friends again
bool Function TryRunAwayGang()
	if behaviour_is_busy
		return false
	endif
	if is_running_away
		return false
	endif
	if !canRunAway
		ticks_since_last_call_for_help = 0
		TryCallForHelp(true)
		return false
	endif
	if actor_trainer != None
		if IsTogetherWithFast(actor_trainer.akRef, akRef, 2000.0)
			SendNotification(name+" was caught trying to run away by "+actor_trainer.GetTitle()+actor_trainer.GetName())
			ticks_since_last_call_for_help = 0
			TryCallForHelp(true)			
			DOM_Mind akAggressorMind = DOM01.GetMindFromActor(actor_trainer)
			if akAggressorMind != None
				akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
				akAggressorMind.CheckAndRegisterKink(107,1.0) ; "managing slaves"
			endif
			return false
		endif
	endif
	SendNotification(name+" "+actorBeVerb+" running away with "+actorPossessive+" friend")	
	behaviour = "running_away"
	return true
EndFunction

Function TrySendAssaultAlarm()
	if !DOM01.alarmToggleRunaway
		return
	endif
	if origCrimeFaction != None && origCrimeFaction != DOM01.DOMPlayerEnemyFaction
		;LogTrace("TrySendAssaultAlarm SendAssaultAlarm original crime faction="+origCrimeFaction.GetName()+" reaction="+origCrimeFaction.GetReaction(DOM01.PlayerFaction))
		origCrimeFaction.SendAssaultAlarm()
	else
		Faction the_faction = akRef.GetCrimeFaction()
		if the_faction != None
			origCrimeFaction = the_faction
			if origCrimeFaction != DOM01.DOMPlayerEnemyFaction
				;LogTrace("TrySendAssaultAlarm SendAssaultAlarm current crime faction="+the_faction.GetName()+" reaction="+the_faction.GetReaction(DOM01.PlayerFaction))
				the_faction.SendAssaultAlarm()
			endif
		endif
	endif
	;LogTrace("TrySendAssaultAlarm SendAssaultAlarm from actor ref")
	akRef.SendAssaultAlarm()
EndFunction

int ticks_since_last_call_for_help = 0
Function TryCallForHelp(bool do_it_now=false)
	if !mind.is_player_slave
		return
	endif
	if do_it_now
		ticks_since_last_call_for_help = 0
	endif
	ticks_since_last_call_for_help += 1
	if ticks_since_last_call_for_help > 1
		int nticks = (10.0 * mind.MOD_Anxiety) as int
		if ticks_since_last_call_for_help >= nticks
			ticks_since_last_call_for_help = 0 
		endif
		return
	endif
	; Should not call TryRunAway() ; That would be a nested loop, don't call this Function from inside TryCallForHelp()!
	if mind.IsPassedOut()
		return
	endif
	if akRef.IsInDialogueWithPlayer()
		return
	endif
	if !IsTogetherWithFast(akRef, PlayerRef, 72000.0) ; 72000.0 = 100 meters
		return
	endif
	if RandomFloat() > mind.ChanceCallForHelp()
		return ; Do not call for help
	endif
	if behaviour == "wait_in_bag"
		mind.SetNextPunishmentReasonForceMessage(6,"is mumbling a faint call for help") ; "yelling"
		mind.TrainSubmission(2.0)
		mind.TrainResignation(3.0)
		SendExternalEventSS("CallForHelp","inbag")
		return
	endif
	if (has_leash || is_leashed)
		;*ogTrace("TryCallForHelp has_leash="+has_leash+" "+is_leashed)
		if !__has_mouth_gag
			mind.SetNextPunishmentReasonForceMessage(6,"refrains a call for help as "+actorPossessive+" restraints tighten") ; "yelling"
			mind.TrainHumiliation(5.0)
		else
			mind.SetNextPunishmentReasonForceMessage(6,"refrains a faint call for help as "+actorPossessive+" restraints tighten") ; "yelling"
			mind.TrainHumiliation(4.0)
			mind.TrainSubmission(4.0)
		endif
		SendExternalEventSS("CallForHelp","leashed")
		return
	elseif __has_mouth_gag
		if !canMove
			if RandomFloat()*400.0 < mind.FACET_Toughness ; fights back so allies around will notice
				mind.SetNextPunishmentReasonForceMessage(6,"garbles something and tries to get rid of "+actorPossessive+" restrains") ; "yelling"
			endif
			mind.SetNextPunishmentReasonForceMessage(6,"garbles a call for help") ; "yelling"
			mind.TrainSubmission(5.0)
			SendExternalEventSS("CallForHelp","mumbles")
			return ; do not trigger alarm
		elseif RandomFloat()*200.0 < mind.FACET_Toughness ; fights back so allies around will notice
			mind.SetNextPunishmentReasonForceMessage(6,"garbles something and tries to get rid of "+actorPossessive+" gag") ; "yelling"
		else
			mind.SetNextPunishmentReasonForceMessage(6,"is mumbling a call for help") ; "yelling"
			mind.TrainSubmission(5.0)
			SendExternalEventSS("CallForHelp","mumbles")
			return ; do not trigger alarm
		endif
	else
		mind.SetNextPunishmentReasonForceMessage(6,"is yelling for help!") ; "yelling"
		ChooseAnswerHelp()
	endif

	if akRef.IsInFaction(DOM01.DOMPlayerEnemyFaction)
		TrySendAssaultAlarm()
		SendExternalEventSS("CallForHelp","yells")
		return ; already fighting against player
	endif

	; Start call for help
	; Start alarm
	if !akRef.IsInFaction(DOM01.DOMPlayerEnemyFaction)
		TurnOnCrimeFaction()
	endif
	TrySendAssaultAlarm()
	
	Wait(2.0)
	if __has_mouth_gag
		if origCrimeFaction != None
			mind.SetNextPunishmentReasonForceMessage(6,"garbles a call for help to "+origCrimeFaction.getName()) ; "yelling"
		;else
		;	mind.SetNextPunishmentReasonForceMessage(6,"garbles a call for help") ; "yelling"
		endif
		mind.TrainSubmission(5.0)
	else
		if origCrimeFaction != None && origCrimeFaction != DOM01.DOMPlayerEnemyFaction
			mind.SetNextPunishmentReasonForceMessage(6,"calls "+origCrimeFaction.getName()+" for help!")
		else
			mind.SetNextPunishmentReasonForceMessage(6,"calls for help!")
		endif
		ChooseAnswerHelp()
	endif
	
	Wait(2.0)
	if !canMove
		mind.SetNextPunishmentReasonForceMessage(7,"is trying to escape!") ; "struggling"
		mind.TrainResignation(5.0)
		SendExternalEventSS("CallForHelp","yells")
		return ; no attack if can not move
	endif

	; Start attack
	akRef.SetActorValue("aggression", 1.0)
	;akRef.SetActorValue("confidence", 2.0)
	;akRef.SetActorValue("assistance", 2.0)

	SendNotification(name+" charges you trying to earn "+actorPossessive+" freedom!")
	akRef.StartCombat(PlayerRef)
	Wait(2.0)
	if mind.IsAngry() ; Attack!
		akRef.SetLookAt(PlayerRef, true)
		akRef.StartCombat(PlayerRef)
		ChooseAnswerAttack(PlayerRef)
		mind.SetNextPunishmentReasonForceMessage(25,"turns toward you to fight!") ; "running_away"
		SendExternalEventSS("CallForHelp","fights")
	else ; Hesitates...
		akRef.SetActorValue("aggression", 0.0)
		;akRef.SetActorValue("confidence", 1.0)
		;akRef.SetActorValue("assistance", 0.0)
		akRef.StopCombatAlarm()
		akRef.ClearLookAt()
		ChooseAnswerWhat(PlayerRef)
		mind.SetNextPunishmentReasonForceMessage(25,"seems too scared to fight!") ; "running_away"
		SendExternalEventSS("CallForHelp","yells")
	endif
EndFunction

; Loop on friends to make them follow
Function TryRunAwayFriends()
	if !DOM01.friendToggle
		return
	endif
	if is_trainer ; trainers won't runaway with friends
		return
	endif

	int i = 0
	While i < friendArray.length
		DOM_Actor afriend = _friend_array[i]
		if afriend != None && afriend.canRunAway && !afriend.is_running_away
			if IsTogetherWithFast(akRef, afriend.akRef,6000.0) ; 6000 = 85 meters
				;LogTrace("friend "+afriend.getName()+" watches friend running away")
				Float x = friendXArray[i]
				if RandomFloat() < x
					;LogTrace("friend "+afriend.getName()+" considers running away")
					if afriend.mind.MakeRunAwayGang(x)
						;LogTrace("friend "+afriend.getName()+" also tries running away")
						mind.RemoveNextPraiseReason(25) ; "not running away"
					else
						;LogTrace("friend "+afriend.getName()+" does not feel like running away")
						mind.SetNextPraiseReasonSilent(25) ; "not running away"
					endif
				endif
			endif
		endif
	    i += 1
	EndWhile
EndFunction

Function TryEscape()
	if !DOM01.escapeToggle
		return
	endif
	ReleaseOrDelete(false)
EndFunction

; ### Train friends and other actors

Function TrainForSacrifice(DOM_Actor akVictimActor, float amount)		
	if GetMyRival() == akVictimActor 
		;*ogTrace("TrainForSacrifice: "+getName()+" rival witnesses "+akVictimActor.getName()+" sacrifice is_attentive="+IsAttentive())
		ChooseRivalTopic(akVictimActor.akRef)
		mind.TrainAnger(amount)
		mind.TrainRespect(amount)
		return
	endif
	if mind.IsDevoted()
		SendNotificationFriends(name+" seems enthralled  by "+akVictimActor.GetName()+"'s sacrifice")
	else
		mind.IncreaseAnger(amount)
		if mind.MakeAngryForInjustice()
			SendNotificationFriends(name+" "+actorBeVerb+" angered by "+akVictimActor.GetName()+"'s sacrifice")
		else
			mind.TrainResignation(amount)
			if mind.MakeSadForInjustice()
				mind.TrainAnger(amount)
				SendNotificationFriends(name+" "+actorBeVerb+" crushed by "+akVictimActor.GetName()+"'s sacrifice")
			else
				SendNotificationFriends(name+" seems concerned by "+akVictimActor.GetName()+"'s sacrifice")
			endif
		endif
	endif
	;*ogTrace("TrainForSacrifice: "+getName()+" witnesses "+akVictimActor.getName()+" sacrifice is_attentive="+IsAttentive())
	mind.TrainFear(amount)
EndFunction

Function TrainWitness(DOM_Actor akVictimActor, float amount, int reason, string type)		
	if type == "to be sacrificed"
		TrainForSacrifice(akVictimActor, amount)
		return
	endif
	if GetMyRival() == akVictimActor 
		;*ogTrace("TrainWitness: "+getName()+" rival witnesses "+akVictimActor.getName()+" punishment is_attentive="+IsAttentive())
		ChooseRivalTopic(akVictimActor.akRef)
		mind.TrainRespect(amount)
		return
	endif
	;*ogTrace("TrainWitness: "+getName()+" witnesses "+akVictimActor.getName()+" punishment is_attentive="+IsAttentive())
	mind.TrainForReason(amount,reason)
	if RandomFloat() < mind.MOD_Fearfulness
		mind.MakeAfraidFor(amount)
	elseif RandomFloat() < mind.MOD_Prudent
		mind.MakeSadFor(amount)
	elseif RandomFloat() < mind.MOD_Impatience
		mind.MakeAngryFor(amount)
	endif
EndFunction

Function TrainForSlaver(DOM_Actor akVictimActor, float amount, int reason, string type)		
	if type == "captured"
		mind.TrainForCapturedSlave(akVictimActor, amount)
	elseif type == "sold"
		mind.TrainForSoldSlave(akVictimActor, amount)
	elseif type == "ransomed"
		mind.TrainForRansomedSlave(akVictimActor, amount)
	elseif type == "recruited"
		mind.TrainForRecruitedSlaver(akVictimActor, amount)
	elseif type == "whored"
		mind.TrainForWhoredSlave(akVictimActor, amount)
	elseif type == "broken"
		mind.TrainForBrokenSlave(akVictimActor, amount)
	endif
	if type != "recruited" && GetMyRival() == akVictimActor 
		LogTrace("TrainForSlaver: "+getName()+" rival witnesses "+akVictimActor.getName()+" punishment is_attentive="+IsAttentive())
		ChooseRivalTopic(akVictimActor.akRef)
		mind.TrainRespect(amount)
		return
	endif
EndFunction

Function TrainForFriend(DOM_Actor akFriend, float base_amount, int reason, string type)
	if akFriend == None
		return
	endif
	int i =  GetFriendIndex(akFriend) ; akFriend.GetFriendIndex(self)
	if i < 0
		return
	endif
	string rel = GetFriendshipString(akRef,friendTArray[i])
	LogTrace("TrainForFriend "+akFriend.GetName()+" reason="+reason+" type="+type+" rel="+friendTArray[i]+" "+rel)
	float x = friendXArray[i]
	float amount = base_amount*x
	mind.TrainForFriend(amount,reason,type,akFriend.GetName(),rel)
	;*ogTrace("TrainForFriend: "+name+" witnesses "+actorPossessive+" "+rel+" "+akFriend.getName()+" punishment index="+i+" amount="+amount)
EndFunction

bool Function TrainFriends(int reason, string type, float base_amount)
	;;*ogTrace("TrainFriends: "+name+" friends length="+friendArray.length+" reason="+reason+" type="+type+" amount="+base_amount)
	bool bFriends = false
	DOM01.TrainWitnesses(self, reason, type, base_amount)
	if type == "public humiliation"
		base_amount = base_amount*4.0
	endif
	string the_event = "TrainForFriend"
	int i = 0
	While i < friendArray.length
		DOM_Actor afriend = _friend_array[i]
		if afriend != None && actor_trainer != afriend ; trainer won't react to trainee friend being punished
			Actor akOther = afriend.akRef
			bool do_train
			if afriend.mind.IsDevoted()
				if !afriend.mind.is_slave
					do_train = false ; devoted slavers won't react to other actors punishment
				elseif mind.IsDevoted()
					do_train = false ; devoted actors won't react to other devoted actors punishment
				endif
			else
				do_train = true
			endif
			if do_train && IsTogetherWithFast(akRef, akOther, 3000.0) ; 3000 = 42 meters		
				if DOM01.sendDOMEvents
					afriend.RegisterForDOMEvent(akRef,the_event)
				else
					afriend.TrainForFriend(self,base_amount,reason,type)
				endif
				bFriends = true
			endif
		endif
		i += 1
	EndWhile
	DOM01.SendDOMEvent(akRef,the_event,base_amount,reason,type)
	return bFriends
EndFunction

; ### Victim

Function SetAsVictim(int type)
	DOM01.SetAsVictim(self,type)
EndFunction

Function UnsetAsVictim()
	DOM01.UnsetAsVictim(self)
EndFunction

; ### Rivalry between actors

DOM_Actor Property myRival = None Auto Hidden ; love rival of this slave
DOM_Actor Property meRival = None Auto Hidden ; is the rival of this slave

Function SetMyRival(DOM_Actor slave)
	myRival = slave
	if myRival == None
		akRef.RemoveFromFaction(DOM01.DOMActorRivalIsVictim)
	endif
	mind.RegisterForUpdateChanceJealous()
EndFunction

Function SetMeRival(DOM_Actor slave)
	meRival = slave
	mind.RegisterForUpdateChanceJealous()
EndFunction

DOM_Actor Function GetMeRival()
	return meRival
EndFunction

DOM_Actor Function GetMyRival()
	return myRival
EndFunction

Function TryAttackRival()
	if myRival == None
		return
	endif
	if !mind.IsAngry()
		return
	endif
	if !DOM01.rivalryToggle
		return
	endif
	if akRef.IsInDialogueWithPlayer() || myRival.akRef.IsInDialogueWithPlayer()
		return
	endif
	if !has_mouth_gag
		ChooseAnswerAttack(myRival.akRef)
	endif
	if !canMove
		SendNotificationFriends(name+" seems annoyed at "+myRival.getName())
		return
	endif
	if mind.IsFeelingJealous()
		if RandomFloat() > mind.MOD_Gentleness ; This is the opposite of guilt/gentleness
			SendNotificationFriends(name+" turns toward "+myRival.getName()+" to fight")
			akRef.StartCombat(myRival.akRef)
			mind.IncreaseArousal(10.0,mind.MOD_Dependence)
		else
			SendNotificationFriends(name+" turns angrily towards "+myRival.getName())
		endif
	endif
EndFunction						

Function ClearRivals()
	if myRival
		myRival.SetMeRival(None)
		myRival == None
	endif
	if meRival
		meRival.SetMyRival(None)
		meRival == None
	endif
	akRef.RemoveFromFaction(DOM01.DOMActorRivalIsVictim)
EndFunction

; ### Friendship between actors

DOM_Actor[] _friend_array
DOM_Actor[] Property friendArray
	DOM_Actor[] Function Get()
		if !_friend_array
			_friend_array = new DOM_Actor[16] ; extended to 16 to include family members
		elseif _friend_array.length < 16
			DOM_Actor[] tmp_array = new DOM_Actor[16]
			int i = 0
			while i < tmp_array.length && i < _friend_array.length
				tmp_array[i] = _friend_array[i]
				i+=1
			endwhile
			_friend_array = new DOM_Actor[16]
			i = 0
			while i < tmp_array.length
				_friend_array[i] = tmp_array[i]
				i+=1
			endwhile
		endif
		return _friend_array
	EndFunction
EndProperty

Float[] _friend_xarray
Float[] Property friendXArray
	Float[] Function Get()
		if !_friend_xarray
			_friend_xarray = new Float[16] ; extended to 16 to include family members
		elseif _friend_xarray.length < 16
			Float[] tmp_array = new Float[16]
			int i = 0
			while i < tmp_array.length && i < _friend_xarray.length
				tmp_array[i] = _friend_xarray[i]
				i+=1
			endwhile
			_friend_xarray = new Float[16]
			i = 0
			while i < tmp_array.length
				_friend_xarray[i] = tmp_array[i]
				i+=1
			endwhile
		endif
		return _friend_xarray
	EndFunction
EndProperty

Int[] _friend_tarray
Int[] Property friendTArray
	Int[] Function Get()
		if !_friend_tarray
			_friend_tarray = new Int[16] ; extended to 16 to include family members
		elseif _friend_tarray.length < 16
			Int[] tmp_array = new Int[16]
			int i = 0
			while i < tmp_array.length && i < _friend_tarray.length
				tmp_array[i] = _friend_tarray[i]
				i+=1
			endwhile
			_friend_tarray = new Int[16]
			i = 0
			while i < tmp_array.length
				_friend_tarray[i] = tmp_array[i]
				i+=1
			endwhile
		endif
		return _friend_tarray
	EndFunction
EndProperty

Actor[] _actor_friend_array
Actor[] Property actorFriendArray
	Actor[] Function Get()
		if !_actor_friend_array
			_actor_friend_array = new Actor[16] ; extended to 16 to include family members
		elseif _actor_friend_array.length < 16
			Actor[] tmp_array = new Actor[16]
			int i = 0
			while i < tmp_array.length && i < _actor_friend_array.length
				tmp_array[i] = _actor_friend_array[i]
				i+=1
			endwhile
			_actor_friend_array = new Actor[16]
			i = 0
			while i < tmp_array.length
				_actor_friend_array[i] = tmp_array[i]
				i+=1
			endwhile
		endif
		return _actor_friend_array
	EndFunction
EndProperty

Float[] _actor_friend_xarray
Float[] Property actorFriendXArray
	Float[] Function Get()
		if !_actor_friend_xarray
			_actor_friend_xarray = new Float[16] ; extended to 16 to include family members
		elseif _actor_friend_xarray.length < 16
			Float[] tmp_array = new Float[16]
			int i = 0
			while i < tmp_array.length && i < _actor_friend_xarray.length
				tmp_array[i] = _actor_friend_xarray[i]
				i+=1
			endwhile
			_actor_friend_xarray = new Float[16]
			i = 0
			while i < tmp_array.length
				_actor_friend_xarray[i] = tmp_array[i]
				i+=1
			endwhile
		endif
		return _actor_friend_xarray
	EndFunction
EndProperty

Int[] _actor_friend_tarray
Int[] Property actorFriendTArray
	Int[] Function Get()
		if !_actor_friend_tarray
			_actor_friend_tarray = new Int[16] ; extended to 16 to include family members
		elseif _actor_friend_tarray.length < 16
			Int[] tmp_array = new Int[16]
			int i = 0
			while i < tmp_array.length && i < _actor_friend_tarray.length
				tmp_array[i] = _actor_friend_tarray[i]
				i+=1
			endwhile
			_actor_friend_tarray = new Int[16]
			i = 0
			while i < tmp_array.length
				_actor_friend_tarray[i] = tmp_array[i]
				i+=1
			endwhile
		endif
		return _actor_friend_tarray
	EndFunction
EndProperty

int Function GetFriendsNotFamilyCount()
	int n = 0
	int i = 0
	While i < friendArray.length
		DOM_Actor sfriend = _friend_array[i]
		if sfriend != None && friendTArray[i] == 0
			n += 1
		endif
		i += 1
	EndWhile
	return n
EndFunction

int Function GetFriendshipCount()
	int n = 0
	int i = 0
	While i < friendArray.length
		DOM_Actor sfriend = _friend_array[i]
		if sfriend != None
			n += 1
		endif
		i += 1
	EndWhile
	return n
EndFunction

int Function GetTotalFriendshipCount()
	int n = GetFriendshipCount()
	int i = 0
	While i < actorFriendArray.length
		Actor afriend = _actor_friend_array[i]
		if afriend != None
			n += 1
		endif
		i += 1
	EndWhile
	return n
EndFunction

int Function GetFriendSpot(float x, int type)
	; Look for free friend spot
	int i = 0
	if type == 0 ; just friends no family links
		int nfriends = GetFriendsNotFamilyCount()
		if nfriends >= DOM01.MaxNumberOfFriends
			return -1
		endif
	endif
	While i < friendArray.length
		DOM_Actor afriend = _friend_array[i]
		if afriend == None
			return i
		endif
		i += 1
	EndWhile
	; No free spot, compare with previous friends, oldest friends last, skip family members
	i = friendArray.length - (1)
	While i >=0
		DOM_Actor afriend = _friend_array[i]
		int ytype = friendTArray[i]
		if ytype == 0
			float y = friendXArray[i]
			if x > y
				return i
			endif
		endif
		i -= 1
	EndWhile
	if type == 0
		return -1
	endif
	; No free spot, compare with previous friends, oldest friends last, check family members
	i = friendArray.length - (1)
	While i >=0
		DOM_Actor afriend = _friend_array[i]
		float y = friendXArray[i]
		if x > y
			return i
		endif
		i -= 1
	EndWhile
	return -1
EndFunction

Function CheckFriend(DOM_Actor akOther, float x, int type)
	SetFriendshipRank(akOther.akRef)
	int i = GetFriendIndex(akOther)
	if i < 0
		LogInfo("ERROR "+akOther.getName()+" should be friend but is not")
		return
	endif
	friendXArray[i] = x
	friendTArray[i] = type
	LogTrace("Checking friend "+akOther.getName()+" x="+friendXArray[i]+" rel="+friendTArray[i])
EndFunction

bool Function SetFriend(int i, DOM_Actor akOther, float x, int type)
	LogTrace("Setting friend START "+akOther.getName()+" x="+x+" rel="+type)
	if isFriend(akOther)
		CheckFriend(akOther,x,type)
		return false
	endif
	if i < 0 || i >= friendArray.length
		return false
	endif
	SetFriendshipRank(akOther.akRef)
	friendArray[i] = akOther
	friendXArray[i] = x
	friendTArray[i] = type
	if akOther == myRival
		myRival = None ; new friendship clears rivalry
	endif
	if akOther == meRival
		meRival = None ; new friendship clears rivalry
	endif
	LogTrace("Setting friend DONE "+akOther.getName()+" x="+friendXArray[i]+" rel="+friendTArray[i])
	return true
EndFunction

DOM_Actor Function GetFriend(int i)
	return friendArray[i]
EndFunction

int Function GetFriendIndex(DOM_Actor akOther)
	int i = 0
	While i < friendArray.length
		if _friend_array[i] == akOther
			return i
		endif
		i += 1
	EndWhile
	return -1
EndFunction

DOM_Actor Function GetBestFriend()
	DOM_Actor best_friend = None
	float friend_level = 0
	int i = 0
	While i < friendArray.length
		DOM_Actor afriend = _friend_array[i]
		if afriend != None
			int type = friendTArray[i]
			if type == 0 || type == 5 || type == 8 || type > 10 ; ignore parent/child family relationship for BFF
				float level = friendXArray[i]
				if level > friend_level && level >= 0.84
					friend_level = level
					best_friend = afriend
				endif
			endif
		endif
		i += 1
	EndWhile
	return best_friend
EndFunction

int Function GetFriendType(int i)
	return friendTArray[i]
EndFunction

float Function GetFriendStrength(int i)
	return friendXArray[i]
EndFunction

Function RemoveFriend(DOM_Actor akOther)
	int i = 0
	While i < friendArray.length
		DOM_Actor afriend = _friend_array[i]
		if afriend == akOther
			_friend_array[i] = None
			return
		endif
		i += 1
	EndWhile
EndFunction

Function RemoveFriendByIndex(int i)
	if i < 0 || i >= friendArray.length
		return
	endif
	friendArray[i] = None
EndFunction

bool Function IsFriend(DOM_Actor akOther)
	int i = 0
	While i < friendArray.length
		DOM_Actor afriend = _friend_array[i]
		if afriend == akOther
			return true
		endif
		i += 1
	EndWhile
	return false
EndFunction

Function FriendIsDead(DOM_Actor akFriend)
	if akFriend == None
		return
	endif
	bool was_sacrificed
	float amount
	if akFriend.mind.promiseOath == "to be sacrificed"
		;*ogTrace("Friend of "+name+" was sacrificed friend="+akFriend.GetName())
		was_sacrificed = true
		amount = DOM01.train_speed_tell*DOM01.DOMPlayerAlias.GetDeceiverModifier() ; Only player can kill slaves
	else
		;*ogTrace("Friend of "+name+" is dead friend="+akFriend.GetName())
		was_sacrificed = false
		amount = DOM01.train_speed_tell*0.3*DOM01.DOMPlayerAlias.GetSlaverModifier() ; Only player can kill slaves
	endif
	int i = akFriend.GetFriendIndex(self)
	if i < 0
		return
	endif
	string rel = GetFriendshipString(akRef,akFriend.friendTArray[i])
	;*ogTrace(afriend.getName()+"'s friend "+name+" is dead!")
	mind.TrainFear(amount)
	if was_sacrificed
		if mind.IsDevoted()
			SendNotificationFriends(name+" "+actorBeVerb+" honored by "+actorObjective+" "+rel+" "+akFriend.GetName()+"'s sacrifice")
			mind.TrainResignation(10.0) ; boost devotion
			mind.TrainFear(10.0) ; boost worship
		elseif mind.MakeAngryForFriend(60.0)
			SendNotificationFriends(name+" "+actorBeVerb+" angered by "+actorObjective+" "+rel+" "+akFriend.GetName()+"'s sacrifice")
		elseif mind.MakeSadForFriend(60.0)
			SendNotificationFriends(name+" "+actorBeVerb+" crushed by "+actorObjective+" "+rel+" "+akFriend.GetName()+"'s sacrifice")
		endif
	elseif akFriend.mind.whipping_active && mind.MakeAngryForFriend(60.0)
		SendNotificationFriends(name+" "+actorBeVerb+" angered by "+actorObjective+" "+rel+" "+akFriend.GetName()+"'s punishment")
	elseif mind.MakeSadForFriend(30.0)
		SendNotificationFriends(name+" "+actorBeVerb+" crushed by "+actorObjective+" "+rel+" "+akFriend.GetName()+"'s death")
	else
		SendNotificationFriends(name+"'s friend "+akFriend.GetName()+" "+actorBeVerb+" dead!")
	endif
	;*ogTrace("ClearFriends "+i+"-3 IsDead="+akRef.IsDead()+"/"+actorIsDead)
	CreateOldFriendship(akFriend)
	;*ogTrace("ClearFriends "+i+"-4 IsDead="+akRef.IsDead()+"/"+actorIsDead)
	RemoveFriend(akFriend)
	akFriend.RemoveFriend(self)
	;*ogTrace("ClearFriends "+i+"-5 IsDead="+akRef.IsDead()+"/"+actorIsDead)
	akRef.RemoveFromFaction(DOM01.DOMActorFriendIsVictim)
EndFunction

Function FriendIsFreed(DOM_Actor akFriend)
	if akFriend == None
		return
	endif
	int i = akFriend.GetFriendIndex(self)
	if i < 0
		return
	endif
	string rel = GetFriendshipString(akRef,akFriend.friendTArray[i])
	;*ogTrace(afriend.getName()+" is happy to see "+actorObjective+" "+rel+" "+name+" was freed!")
	SendNotificationFriends(name+" "+actorBeVerb+" happy to see "+actorObjective+" "+rel+" "+akFriend.GetName()+" was freed!")
	float amount = DOM01.train_speed_tell*0.3*DOM01.DOMPlayerAlias.GetSlaverModifier() ; Only player can free slaves
	mind.TrainResignation(amount)
	mind.TrainAnger(amount)
	;afriend.mind.TrainRespect(amount)
	;*ogTrace("ClearFriends "+i+"-3 IsDead="+akRef.IsDead()+"/"+actorIsDead)
	CreateOldFriendship(akFriend)
	;*ogTrace("ClearFriends "+i+"-4 IsDead="+akRef.IsDead()+"/"+actorIsDead)
	RemoveFriend(akFriend)
	akFriend.RemoveFriend(self)
	;*ogTrace("ClearFriends "+i+"-5 IsDead="+akRef.IsDead()+"/"+actorIsDead)
	akRef.RemoveFromFaction(DOM01.DOMActorFriendIsVictim)
EndFunction

Function FriendIsMoved(DOM_Actor akFriend)
	if akFriend == None
		LogTrace("ClearFriends WARNING NO FRIEND TO REMOVE akFriend=None")
		return
	endif
	CreateOldFriendship(akFriend)
	;*ogTrace("ClearFriends "+i+"-4 IsDead="+akRef.IsDead()+"/"+actorIsDead)
	RemoveFriend(akFriend)
	akFriend.RemoveFriend(self)
	if akRef == None
		LogTrace("ClearFriends WARNING TOO LATE akRef=None")
		return
	endif
	LogTrace("ClearFriends IsDead="+akRef.IsDead()+" faction="+DOM01.DOMActorFriendIsVictim)
	akRef.RemoveFromFaction(DOM01.DOMActorFriendIsVictim)
EndFunction

Function ClearFriends()
	bool actorIsDead
	if akRef == None
		actorIsDead = true
	else
		actorIsDead = akRef.IsDead()
	endif
	string the_event
	if actorIsDead
		the_event = "FriendIsDead"
	elseif mind.is_freed_slave
		the_event = "FriendIsFreed"
	else
		the_event = "FriendIsMoved"
	endif
	;*ogTrace("ClearFriends IsDead="+akRef.IsDead()+"/"+actorIsDead)
	int i = 0
	While i < friendArray.length
		DOM_Actor afriend = _friend_array[i]
		if afriend != None
			;*ogTrace("ClearFriends "+i+"-1 IsDead="+akRef.IsDead()+"/"+actorIsDead)
			if DOM01.sendDOMEvents
				afriend.RegisterForDOMEvent(akRef,the_event)
			else
				;*ogTrace("ClearFriends "+i+"-2 IsDead="+akRef.IsDead()+"/"+actorIsDead)
				if actorIsDead
					afriend.FriendIsDead(self)
				elseif mind.is_freed_slave
					afriend.FriendIsFreed(self)
				else
					afriend.FriendIsMoved(self)
				endif
			endif
			;*ogTrace("ClearFriends "+i+"-6 IsDead="+akRef.IsDead()+"/"+actorIsDead)
		endif
		i += 1
	EndWhile
	DOM01.SendDOMEvent(akRef,the_event)
	akRef.RemoveFromFaction(DOM01.DOMActorFriendIsVictim)
	akRef.RemoveFromFaction(DOM01.DOMActorIsVictim)
EndFunction

; Friendship: likeable or popular = +40% friends
; Likeable (gives happiness) = +19E +17A +smart +15girls
; Popular (gives high self esteem)= -21H +21X -18A -24O

float Function GetGangCheck(DOM_Actor akOther)
	float x = 0.05
	int n = 0
	int i = 0
	
	While i < friendArray.length
		DOM_Actor afriend1 = _friend_array[i]
		if afriend1 != None && afriend1 != akOther
			int j = 0
			While j < akOther.friendArray.length
				DOM_Actor afriend2 = akOther.friendArray[j]
				if afriend2 != None && afriend2 != self
					n += 1
				endif
				j += 1
			EndWhile
		endif
		i += 1
	EndWhile

	;*ogTrace("Friend gang "+name+" and "+akOther.getname()+" already have "+n+" friends in common")

	if n == 0
		return 0
	endif

	x = x + 0.025 * n

	return x
EndFunction

float Function GetFactionCheck(DOM_Actor akOther)
	;*ogTrace("GetFactionCheck "+akOther)
	Faction crimeFaction1 = GetCrimeFaction()
	;*ogTrace("GetFactionCheck "+name+" crime faction1="+crimeFaction1)
	if crimeFaction1 == None
		return 0.0
	endif
	Faction crimeFaction2 = akOther.GetCrimeFaction()
	;*ogTrace("GetFactionCheck "+akOther.getName()+" crime faction2="+crimeFaction2)
	if crimeFaction1 == crimeFaction2
		return 0.2
	endif
	return 0.0
EndFunction

float Function GetActorTypeCheck(DOM_Actor akOther)
	if actorType == akOther.actorType
		return 1.0 ; no changes
	endif
	if actorType == 1 || akOther.actorType == 1 ; friendship with animals
		return 0.6
	endif
	return 0.3 ; friendship with creatures
EndFunction

float Function GetActorRaceCheck(DOM_Actor akOther)
	if actorRace == akOther.actorRace
		return 1.0 ; no changes
	endif
	if Math.Abs(actorType - akOther.actorRace) <= 5 ; close match
		return 0.9
	endif
	return 0.8 ; 
EndFunction

float Function GetRelationshipCheck(DOM_Actor akOther, int type)
	int rank = akRef.GetRelationshipRank(akOther.akRef)
	LogTrace("GetRelationshipCheck "+akOther.GetName()+" type="+type+" rank="+rank)
	if type==0 ; not family, maybe friends or enemies
		return (rank as float)*0.2
	endif
	if type==1 ; lovers
		return 1.0
	elseif type==2 ; spouses could hate each others
		return (rank as float)*0.25+0.1
	elseif type==3 ; parents are unconditionnal (I am your father, Luke!)
		return 1.0
	elseif type==4 ; child
		return 1.0
	elseif type==5 ; siblings
		return (rank as float)*0.2+0.1
	elseif type==6 ; grand parent
		return 0.5
	elseif type==7 ; grand child
		return 0.5
	endif
	; other family members
	return (rank as float)*0.2+0.05
EndFunction

float Function GetStatusCheck(DOM_Actor akOther)
	;*ogTrace("GetStatusCheck "+akOther+" "+akOther.mind)
	; Actor is slave
	if mind.is_slave 
		if !is_trainer
			if akOther.mind.is_slave
				if !akOther.is_trainer
					return 1.0 ; both slaves
				endif
				return 0.5 ; one slave one trainer
			endif
			return 0.1 ; one slave one free
		endif
		return 0.25 ; one trainer one free
	endif
	; Actor is free
	if akOther.mind.is_slave
		if !akOther.is_trainer
			return 0.1 ; one slave one free
		endif
		return 0.25 ; one trainer one free
	endif
	return 1.0 ; both free
EndFunction

float Function GetFriendship(DOM_Actor akOther, int type)
	;*ogTrace("GetFriendship type="+type+" "+akOther)
	if akOther == None 
		return 0.0
	endif
	if akOther.mind == None
		return 0.0
	endif
	float x = mind.GetPersonalityCheck(akOther.mind)
	;*ogTrace("Friendship-base strength between "+name+" and "+akOther.getName()+" = "+x)
	x += GetGangCheck(akOther)
	;*ogTrace("Friendship-gang strength between "+name+" and "+akOther.getName()+" = "+x)
	float y = GetRelationshipCheck(akOther,type)
	if y <= 0.0 ; Check for no relationships or bad relationships
		if mind.is_slave != akOther.mind.is_slave
			x -= 0.25
		endif
	endif
	x += y
	;*ogTrace("Friendship-type strength between "+name+" and "+akOther.getName()+" = "+x)
	x += GetFactionCheck(akOther)
	;*ogTrace("Friendship-fact strength between "+name+" and "+akOther.getName()+" = "+x)
	x *= GetActorTypeCheck(akOther)
	;*ogTrace("Friendship-actor-type strength between "+name+" and "+akOther.getName()+" = "+x)
	x *= GetActorRaceCheck(akOther)
	;*ogTrace("Friendship-actor-race strength between "+name+" and "+akOther.getName()+" = "+x)
	x *= GetStatusCheck(akOther)
	;*ogTrace("Friendship-stat strength between "+name+" and "+akOther.getName()+" = "+x)
	LogTrace("Friendship with "+akOther.getName()+" type="+type+" strength="+x)
	int n = GetFriendsNotFamilyCount()
	if n > 1 ; harder to get more friends
		x *= 1.0-(n as float)/50.0
	endif
	LogTrace("Friendship with "+akOther.getName()+" corrected for already "+n+" friends, new strength="+x)
	return x
EndFunction

bool Function CorrectFriendship(DOM_Actor akOther)
	LogTrace("CorrectFriendship with "+akOther.getName())
	; add friendship to self or remove from other
	int type = DOM01.GetFriendshipType(akRef,akOther.akRef)
	float x = GetFriendship(akOther,type)
	
	; No match
	if x < DOM01.friend_threshold || RandomFloat() > x
		akOther.RemoveFriend(self)
		return false
	endif
	
	int k = GetFriendSpot(x,type)
	; No room for more friends,
	; and all other friends are a better match than this one
	if k < 0
		akOther.RemoveFriend(self)
		return false
	endif
	
	; Remove previous friends
	DOM_Actor afriend2 = friendArray[k]
	if afriend2 != None
		RemoveFriendByIndex(k)
		afriend2.RemoveFriend(self)
	endif
	
	; Setup new friends
	bool is_success = SetFriend(k, akOther, x, type)
	if !is_success
		akOther.RemoveFriend(self)
		return false
	endif
	if type == 0 ; just friends
		LogTrace("CorrectFriendship friends")
		SendNotificationFriends(name+" is now friend with "+akOther.GetName())
	else
		int type2 = DOM01.GetFriendshipType(akOther.akRef,akRef)
		string rel = GetFriendshipString(akRef,type2)
		LogTrace("CorrectFriendship "+type2+" "+rel)
		SendNotificationFriends(name+" is "+akOther.GetName()+"'s "+rel)
	endif
	DOM01.DOM04.NotifyFriendship(self,akOther,afriend2,None)
	return true	
EndFunction

bool Function CreateFriendship(DOM_Actor akOther)
	; Already friend
	if isFriend(akOther)
		if !akOther.isFriend(self)
			return akOther.CorrectFriendship(self)
		endif
		return false
	elseif akOther.isFriend(self)
		return CorrectFriendship(akOther)
	endif
	int type = DOM01.GetFriendshipType(akRef,akOther.akRef)
	if mind.is_slave != akOther.mind.is_slave
		if type == 0 ; not family - no friendship between slaves and slavers
			return false
		endif
	endif
	float x = GetFriendship(akOther,type)
	
	; Check match if not family
	if type == 0 && (x < DOM01.friend_threshold || RandomFloat() > x)
		return false
	endif
	
	int j = akOther.GetFriendSpot(x,type)
	int k = GetFriendSpot(x,type)
	
	; No room for more friends,
	; and all other friends are a better match than this one
	if j < 0 || k < 0
		return false
	endif
	
	; Remove previous friends
	DOM_Actor afriend1 = akOther.GetFriend(j)
	if afriend1 != None
		akOther.RemoveFriendByIndex(j)
		afriend1.RemoveFriend(akOther)
	endif
	DOM_Actor afriend2 = friendArray[k]
	if afriend2 != None
		RemoveFriendByIndex(k)
		afriend2.RemoveFriend(self)
	endif
	
	; Setup new friends
	int type2 = DOM01.GetFriendshipType(akOther.akRef,akRef)
	bool is_success = akOther.SetFriend(j, self, x, type2)
	if !is_success
		return false
	endif
	is_success = SetFriend(k, akOther, x, type)
	if !is_success
		akOther.RemoveFriend(self)
		return false
	endif
	if type == 0 ; just friends
		SendNotificationFriends(name+" is now friend with "+akOther.GetName())
	else
		string rel = GetFriendshipString(akRef,type2)
		LogTrace("CreateFriendship "+type2+" "+rel)
		SendNotificationFriends(name+" is "+akOther.GetName()+"'s "+rel)
	endif
	DOM01.DOM04.NotifyFriendship(self,akOther,afriend2,afriend1)
	return true
EndFunction

Function CreateOldFriendship(DOM_Actor akOther)
	Actor akOtherRef = akOther.akRef
	; Already friend
	bool actorIsDead
	if akRef == None
		actorIsDead = true
	else
		actorIsDead = akRef.IsDead()
	endif
	if actorIsDead
		if isOldFriend(akOtherRef)
			RemoveOldFriend(akOtherRef)
		endif
		return
	endif
	if isOldFriend(akOtherRef)
		return
	endif

	int type = DOM01.GetFriendshipType(akRef,akOtherRef)
	float x = GetFriendship(akOther,type)
	int k = GetOldFriendSpot(x)
	
	; No room for more friends,
	; and all other friends are a better match than this one
	if k < 0
		return
	endif
	
	; Remove previous friend
	Actor afriend = actorFriendArray[k]
	if afriend != None
		RemoveOldFriendByIndex(k)
	endif
	
	; Setup old friend
	SetOldFriend(k, akOtherRef, x, type)
	if type == 0 ; just friends
		SendNotificationFriends(name+" was separated from "+actorObjective+" friend "+akOtherRef.GetDisplayName())
	else
		string rel = GetFriendshipString(akRef,type)
		SendNotificationFriends(name+" was separated from "+actorObjective+" "+rel+" "+akOtherRef.GetDisplayName())
	endif
EndFunction

int Function GetOldFriendSpot(float x)
	; Look for free friend spot
	int i = 0
	While i < actorFriendArray.length
		Actor afriend = _actor_friend_array[i]
		if afriend == None
			return i
		endif
		i += 1
	EndWhile
	; No free spot, compare with previous friends, oldest friends last
	i = actorFriendArray.length - (1)
	While i >=0
		Actor afriend = _actor_friend_array[i]
		if afriend != None
			if afriend.IsDead()
				return i
			endif
			float y = actorFriendXArray[i]
			if x > y
				return i
			endif
		endif
		i -= 1
	EndWhile
	return -1
EndFunction

Function RemoveOldFriend(Actor akOther)
	int i = 0
	While i < actorFriendArray.length
		Actor afriend = _actor_friend_array[i]
		if afriend == akOther
			_actor_friend_array[i] = None
			return
		endif
		i += 1
	EndWhile
EndFunction

Function RemoveOldFriendByIndex(int i)
	if i < 0 || i >= actorFriendArray.length
		return
	endif
	actorFriendArray[i] = None
EndFunction

Actor Function GetOldFriend(int i)
	return actorFriendArray[i]
EndFunction

Function SetFriendshipRank(Actor akOther)
	if akRef.GetRelationshipRank(akOther) < 1
		akRef.SetRelationshipRank(akOther,1)
	endif
EndFunction

Function SetOldFriend(int i, Actor akOther, float x, int type)
	if isOldFriend(akOther)
		return
	endif
	if i < 0 || i >= actorFriendArray.length
		return
	endif
	SetFriendshipRank(akOther)
	actorFriendArray[i] = akOther
	actorFriendXArray[i] = x
	actorFriendTArray[i] = type
EndFunction

bool Function IsOldFriend(Actor akOther)
	if akOther == None || akOther == akRef
		return false
	endif

	int i = 0
	While i < actorFriendArray.length
		Actor afriend = _actor_friend_array[i]
		if afriend == akOther
			;*ogTrace("Old friendship found "+name+" and "+akOther.getDisplayName())
			return true
		endif
		i += 1
	EndWhile
	return false
EndFunction

Function CheckOldFriendship()
	int i = DOM01.DOM02.actorCounter-(1)
	While i >=0 ; New slaves first
		DOM_Actor akOther = DOM01.DOM02.actorArray[i]
		if akOther != None
			Actor akOtherRef = akOther.akRef
			if akOtherRef != None && isOldFriend(akOtherRef)
				if CreateFriendship(akOther)
					;*ogTrace("Old friendship reconnection between "+name+" and "+akOther.getName())
				endif
				RemoveOldFriend(akOtherRef)
			endif
		endif
		i -= 1
	EndWhile
EndFunction

Function CheckFriendship(int idx)
	LogTrace("CheckFriendship is_initializing="+is_initializing)
	if is_initializing
		return
	endif
	if GetFriendshipCount() == friendArray.length
		;*ogTrace("CheckFriendship Already max friends "+name)
		; Friendships already at maximum, this NPC is not looking for friends
		; but NPC with less than 4 friends can try to get in from their side.
		return
	endif
	
	int i = 0
	int n = DOM01.DOM02.actorCounter
	;if mind.is_slave ; for slaves
		if mind.is_slave && idx >= 0
			i = idx + 1  ; To avoid double checking, start at actor index
		endif
		While i < n 
			DOM_Actor akOther = DOM01.DOM02.actorArray[i]
			if akOther != None && akOther != self
				if (IsTogetherWithFast(akRef, akOther.akRef, 2000.0)) ;  2000 = 28 meters
					LogTrace("Possible friends "+name+" and "+akOther.getName()+" are together")
					if(CreateFriendship(akOther))
						LogTrace("CheckFriendship New friendship is starting between "+name+" and "+akOther.getName())
					endif
				endif
			endif
			i += 1
		EndWhile
	;endif ; end loop on slaves
	i = 0
	n = DOM01.DOM01.actorCounter-(1)
	;if !mind.is_slave ; for slavers
		if !mind.is_slave && idx >= 0
			i = idx + 1 ; To avoid double checking, start at actor index
		endif
		While i < n
			DOM_Actor akOther = DOM01.DOM01.actorArray[i]
			if akOther != None && akOther != self
				if (IsTogetherWithFast(akRef, akOther.akRef, 2000.0)) ;  2000 = 28 meters
					;*ogTrace("CheckFriendship Possible friends "+name+" and "+akOther.getName()+" are together")
					if(CreateFriendship(akOther))
						;*ogTrace("CheckFriendship New friendship is starting between "+name+" and "+akOther.getName())
						;*ogTrace("New friendship is starting between "+name+" and "+akOther.getName())
					endif
				endif
			endif
			i += 1
		EndWhile
	;endif ; end loop on slavers
EndFunction

; ### Trainer and target

Actor actor_target = None
DOM_Actor actor_trainer = None

; Call these Functions from other scripts

Function SeparateFromTrainer()
	LogTrace("SeparateFromTrainer "+actor_trainer)
	if actor_trainer == None
		return
	endif
	actor_trainer.RemoveTrainee(self)
	RemoveTrainer()
EndFunction

Function SetTrainerFromDialogue()
	if actor_trainer != DOM01.GetActorToJoin()	
		SeparateFromTrainer()
	endif
	AddTrainer(DOM01.GetActorToJoin())
	actor_trainer.AddTraineeFromDialogue(self)
EndFunction

Function SetTrainer(DOM_Actor theTrainer)
	;*ogTrace("SetTrainer "+theTrainer.getName())
	if actor_trainer != theTrainer
		SeparateFromTrainer()
		actor_trainer = theTrainer
	endif
	AddTrainer(theTrainer)
	actor_trainer.AddTrainee(self)
EndFunction

DOM_Actor Function GetTrainer()
	return actor_trainer
EndFunction

DOM_Actor Function GetCurrentTrainee()
	return actor_trainee
EndFunction

Actor Function GetActorPartner()
	return actor_sexpartner
EndFunction

Actor Function GetCurrentTrainer()
	if actor_trainer != None
		return actor_trainer.akRef
	endif
	if mind.is_player_slave
		return PlayerRef
	endif
	return mind.actor_owner
EndFunction

Function SetActorPartner(Actor akTarget)
	if akTarget == None
		LogTrace("SetSexPartner partner=None")
	else
		LogTrace("SetSexPartner partner="+akTarget.GetDisplayname())
	endif
	actor_sexpartner = akTarget
EndFunction

; Do not call these Functions externally

Function AddTrainer(DOM_actor theTrainer)
	LogTrace("AddTrainer "+theTrainer.getName())
	actor_trainer = theTrainer
	akRef.setFactionRank(DOM01.DOMSlaveHasTrainer,1)
	akRef.SetLookAt(actor_trainer.akRef)
	target.ForceRefTo(actor_trainer.akRef)
	EnterFollowTrainer()
EndFunction

Function RemoveTrainer()
	if actor_trainer != None
		LogTrace("RemoveTrainer "+actor_trainer.getName()+" IsDead="+actor_trainer.akRef.IsDead()+" trainee IsDead="+akRef.IsDead())
	else
		LogTrace("RemoveTrainer None IsDead="+akRef.IsDead())
	endif
	actor_trainer = None
	akRef.removeFromFaction(DOM01.DOMSlaveHasTrainer)
	if akRef != None && !akRef.IsDead() && !before_clear_is_busy
		SendNotificationAction(name+" "+actorBeVerb+" back at your service")
		akRef.ClearLookAt()
		target.ForceRefTo(GetCurrentTrainer())
		;EnterFollowPlayer()
	else
		if akRef != None
			akRef.ClearLookAt()
		endif
		target.clear()
	endif
EndFunction

Function AddTraineeFromDialogue(DOM_Actor aTrainee)
	if GetTraineeCount() >= traineeArray.length
		DOM01.ResetDOMActorToJoin(self)
		return
	endif
	if isTrainee(aTrainee)
		return
	endif

	if AddTraineeToArray(aTrainee)
		aTrainee.EnterFollowTrainer()
	else
		LogTrace("AddTraineeFromDialogue ERROR: Could not add trainee: "+aTrainee.getName())
	endif

	int n = GetTraineeCount()
	if n >= traineeArray.length
		DOM01.ResetDOMActorToJoin(self)
	endif
	akRef.SetFactionRank(DOM01.DOMTraineeCount,n)
EndFunction

Function AddTrainee(DOM_Actor aTrainee)
	LogTrace("AddTrainee "+aTrainee.getName())
	if GetTraineeCount() >= traineeArray.length
		DOM01.ResetDOMActorToJoin(self)
		return
	endif
	if isTrainee(aTrainee)
		return
	endif

	if AddTraineeToArray(aTrainee)	
		aTrainee.EnterFollowTrainer()
	else
		LogTrace("AddTrainee ERROR: Could not add trainee: "+aTrainee.getName())
	endif

	int n = GetTraineeCount()
	if n >= traineeArray.length
		DOM01.ResetDOMActorToJoin(self)
	endif
	akRef.SetFactionRank(DOM01.DOMTraineeCount,n)
EndFunction

bool Function AddTraineeToArray(DOM_Actor theTrainee)
	if theTrainee == None
		return false
	endif
	if dirty_trainee_array
		int counter = 0
		while dirty_trainee_array	
			if counter >= 128
				Debug.Notification("CANCELED! Wait for previous trainee transfer to finish!")
				return false
			endif
			Wait(1.0)
			counter += 1
			dirty_trainee_array = false
			UpdateTraineeArray()
		endwhile
	endif
	;*ogTrace("AddTraineeToArray "+theTrainee.getName())
	; Look for free trainee spot
	if traineeCounter < 0
		RecheckTrainees()
	endif
	if traineeCounter >= traineeArray.length
		SendNotification("Maximum number of trainees reached for "+name)
		; Failed
		theTrainee.RemoveTrainer()
		return false
	endif
	int idx = GetTraineeIndex(theTrainee)
	if idx < 0
		traineeArray[traineeCounter] = theTrainee
		traineeCounter += 1
		return true
	endif
	LogInfo("WARNING: trainee "+theTrainee.GetName()+" is already registered ")
	return true
EndFunction

int Function GetTraineeIndex(DOM_Actor theTrainee)
	int i = 0
	while i < traineeCounter && i < traineeArray.length
		if traineeArray[i] == theTrainee
			return i
		endif
		i += 1
	endwhile
	return -1
EndFunction

Function RemoveTrainee(DOM_Actor theTrainee)
	LogTrace("RemoveTrainee "+theTrainee)
	if theTrainee == None
		return
	endif
	if dirty_trainee_array
		int counter = 0
		while dirty_trainee_array	
			if counter >= 128
				Debug.Notification("CANCELED! Wait for previous trainee transfer to finish!")
				return
			endif
			Wait(1.0)
			counter += 1
			dirty_trainee_array = false
			UpdateTraineeArray()
		endwhile
	endif
	;*ogTrace("RemoveTrainee "+theTrainee.getName())
	int idx = GetTraineeIndex(theTrainee)
	if idx < 0 || idx > traineeArray.length
		LogTrace("RemoveTrainee WARNING trainee not found "+theTrainee)
		return
	endif
	traineeArray[idx] = None
	traineeCounter -= 1
	if traineeCounter < 0
		traineeCounter = 0
	endif
	UpdateTraineeArray()
EndFunction

bool updating_trainee_array = false
bool dirty_trainee_array = false
Function UpdateTraineeArray()
	LogTrace("UpdateTraineeArray actors busy="+updating_trainee_array)
	if updating_trainee_array
		dirty_trainee_array = true
		return
	endif
	updating_trainee_array = true
	int i = 0
	traineeCounter = 0
	While i < traineeArray.length
		if traineeArray[i] != None
			if i > traineeCounter
				traineeArray[traineeCounter] = traineeArray[i]
				traineeArray[i] = None
				LogTrace("UpdateTraineeArray traineeCounter="+traineeCounter+" "+traineeArray[traineeCounter])
			endif
			traineeCounter += 1
		endif
		i += 1
	EndWhile	
	updating_trainee_array = false
	LogTrace("UpdateTraineeArray done traineeCounter="+traineeCounter)
EndFunction

; ### Trainees

ObjectReference Property CampMarker = None Auto Hidden
string camp_name = ""
DOM_Actor actor_trainee = None ; current trainee
DOM_Actor actor_trainee2 = None ; supplementary trainee 2
DOM_Actor actor_trainee3 = None ; supplementary trainee 3
DOM_Actor actor_trainee_whipped = None ; punished trainee

bool Function TraineeIsBusy(DOM_Actor akTrainee)
	if actor_trainee == akTrainee
		return true
	endif
	if actor_trainee2 == akTrainee
		return true
	endif
	if actor_trainee3 == akTrainee
		return true
	endif
	;if actor_trainee_whipped == akTrainee
	;	return true
	;endif
	return false
EndFunction

Function SetWhippedTrainee(DOM_Actor akTraineeActor)
	actor_trainee_whipped = akTraineeActor
EndFunction

Actor Function GetWhippedTraineeActor()
	if actor_trainee_whipped == None
		return None
	endif
	return actor_trainee_whipped.akRef
EndFunction

int traineeCounter = -1
DOM_Actor[] _traineeArray
DOM_Actor[] Property traineeArray
	DOM_Actor[] Function Get()
		if !_traineeArray || _traineeArray.length < 128
			_traineeArray = new DOM_Actor[128] ; extended to 128 for HSH compatibility
		endif
		return _traineeArray
	EndFunction
EndProperty

int Function GetTraineeCount()
	if traineeCounter >= 0
		return traineeCounter
	endif
	RecheckTrainees()
	return traineeCounter
EndFunction

Function SetTraineesToFight(bool do_fight_for_player)
	int n = GetTraineeCount()
	LogTrace("SetTraineesToFight "+n)
	if n == 0
		return
	endif
	int i = 0
	While i < n
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None
			DOM_Mind akMind = aTrainee.mind
			if akMind != None
				if do_fight_for_player && !akMind.should_fight_for_player
					akMind.SetShouldFightForPlayer()
				elseif !do_fight_for_player && akMind.should_fight_for_player
					akMind.UnsetShouldFightForPlayer()
				endif
			endif
		endif
		i += 1
	EndWhile
EndFunction

Function ListTraineeNames()
	int n = GetTraineeCount()
	LogTrace("ListTraineeNames "+n)
	if n == 0
		if !mind.is_slave
			SendNotification(title+name+" has no Trainees")
		endif
		return
	endif
	string msg = ""
	string tmp_name = "" 
	int i = 0
	While i < n
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None
			if tmp_name
				if msg == ""
					msg = tmp_name
				else
					msg = msg+", "+tmp_name
				endif
			endif
			tmp_name = aTrainee.getName()
			CheckTrainee(aTrainee)
		endif
		i += 1
	EndWhile
	if n == 1
		msg = tmp_name ; msg +" "+tmp_name
	else
		msg = msg +" and "+tmp_name
	endif
	if camp_name != ""
		if (actorSex % 2) == 0
			msg += ". His camp is in "+camp_name
		else
			msg += ". Her camp is in "+camp_name
		endif
	endif
	if mind.is_slave
		if n > 1
			SendNotification(title+name+" trainees are "+msg)
		else
			SendNotification(title+name+" trainee is "+msg)
		endif
	else
		SendNotification(title+name+" merchandise consist of "+msg)
	endif
EndFunction

DOM_Actor Function GetTrainee(int i)
	return traineeArray[i]
EndFunction

Function CheckTrainee(DOM_Actor aTrainee)
	LogTrace("Checking trainee "+aTrainee.GetName())
	if aTrainee.akRef == None
		RemoveTrainee(aTrainee)
		return
	endif
	if aTrainee.GetTrainer() == self
		return
	endif
	aTrainee.AddTrainer(self)
EndFunction

Function RecheckTrainer()
	if actor_trainer == None
		akRef.RemoveFromFaction(DOM01.DOMSlaveHasTrainer)
		return
	endif
	if !akRef.IsInFaction(DOM01.DOMSlaveHasTrainer)
		akRef.setFactionRank(DOM01.DOMSlaveHasTrainer,1)
	endif
	if !actor_trainer.isTrainee(self)
		LogTrace("Recovering trainee for trainer "+actor_trainer.GetName())
		actor_trainer.AddTrainee(self)
	endif
EndFunction

Function RecheckTrainees()
	traineeCounter = 0
	int k = 0
	; Check trainees from slaves list
	int i = 0
	int n = DOM01.DOM02.actorCounter
	While i < n
		DOM_Actor aTrainee =  DOM01.DOM02.GetActorByIndex(i)
		if aTrainee.GetTrainer() == self
			;*ogTrace("found trainee "+aTrainee.GetName())
			if !isTrainee(aTrainee)
				if k < traineeArray.length
					;*ogTrace("resetting trainee "+aTrainee.GetName())
					AddTrainee(aTrainee)
				else
					;*ogTrace("removing trainee "+aTrainee.GetName())
					aTrainee.RemoveTrainer()
				endif
				k = traineeCounter
			endif
		endif
		i += 1
	EndWhile
	; Check trainees from actor list
	i = 0
	n = traineeArray.length
	While i < n
		DOM_Actor aTrainee =  traineeArray[i]
		if aTrainee != None
			;*ogTrace("found trainee "+aTrainee.GetName())
			if aTrainee.GetTrainer() != self
				if k < traineeArray.length
					;*ogTrace("recovering trainee "+aTrainee.GetName())
					aTrainee.AddTrainer(self)
				else
					;*ogTrace("unloading trainee "+aTrainee.GetName())
					RemoveTrainee(aTrainee)
				endif
				k = traineeCounter
			endif
		endif
		i += 1
	EndWhile
	; Check factions
	akRef.SetFactionRank(DOM01.DOMTraineeCount,k)
	if k > 0 && mind.is_slave
		if mind.is_player_slave
			akRef.SetFactionRank(DOM01.DOMPlayerSlaveFaction,2)
		else
			akRef.SetFactionRank(DOM01.DOMNotPlayerSlaveFaction,2)
		endif
	endif
	; Check if actor is trainee but trainer doesn't know about
	if actor_trainer != None
		if !actor_trainer.isTrainee(self)
			;*ogTrace("recovering trainer "+actor_trainer.GetName())
			actor_trainer.AddTrainee(self) ; if failed will also remove trainer
		endif
	endif
EndFunction

bool Function IsTrainee(DOM_Actor theTrainee)
	int i = 0
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee == theTrainee
			return true
		endif
		i += 1
	EndWhile
	return false
EndFunction

Function SetCamp()
	if CampMarker != None
		CampMarker.Delete()
		CampMarker = None
	endif
	CampMarker = akRef.PlaceAtMe(DOM01.XMarkerForm)
	CampMarker.Enable()
	akRef.SetFactionRank(DOM01.DOMSlaverHasCamp,1)
	Location the_loc = akRef.GetCurrentLocation()
	if the_loc
		camp_name = the_loc.GetName()
		if camp_name == ""
			camp_name = "Skyrim"
		endif
	else
		camp_name = "Skyrim"
	endif
	CampMarker.SetDisplayName(camp_name)
	SendNotificationAction(title+name+" sets camp in "+camp_name)
	if behaviour == "travel"
		target.ForceRefTo(CampMarker)
		akRef.EvaluatePackage()
	endif
EndFunction

Function SetCampAtRef(ObjectReference obj)
	if CampMarker != None
		CampMarker.Delete()
		CampMarker = None
	endif
	CampMarker = obj.PlaceAtMe(DOM01.XMarkerForm)
	CampMarker.Enable()
	akRef.SetFactionRank(DOM01.DOMSlaverHasCamp,1)
	Location the_loc = obj.GetCurrentLocation()
	if the_loc
		camp_name = the_loc.GetName()
		if camp_name == ""
			camp_name = "Skyrim"
		endif
	else
		camp_name = "Skyrim"
	endif
	CampMarker.SetDisplayName(camp_name)
	SendNotificationAction(title+name+" sets camp in "+camp_name)
	if behaviour == "travel"
		target.ForceRefTo(CampMarker)
		akRef.EvaluatePackage()
	endif
EndFunction

Function GatherTrainees()
	int i = 0
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None
			aTrainee.SetFollowMode(0)
			aTrainee.EnterFollowTrainer()
			aTrainee.Anim_IdleReset()
			aTrainee.akRef.SetLookAt(akRef)
		endif
		i += 1
	EndWhile
EndFunction

Function CuffTrainees()
	int i = 0
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			if !aTrainee.IsCuffed()
				LogTrace("CuffTrainees Anim_BoundStartBack")
				aTrainee.Anim_BoundStartBack()
			endif
			aTrainee.akRef.SetLookAt(akRef)
		endif
		i += 1
	EndWhile
EndFunction

Function PoseOrRestrainTrainees()
	int i = 0
	bool is_working_ok = false
	bool is_tying = false
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			float sub_level =  aTrainee.mind.resignation
			if sub_level < 50.0*RandomFloat()+50.0
				if !aTrainee.is_restrained && aTrainee.canMove 
					SecureTrainee(aTrainee)
					is_tying = true
				endif
			elseif !aTrainee.is_behaviour_pose ; pose trainee
				PoseTrainee(aTrainee)
				is_working_ok = true
			endif
		endif
		i += 1
	EndWhile

	; Check posing slaves
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			if !aTrainee.is_behaviour_pose && !aTrainee.is_restrained && aTrainee.canMove
				SecureTrainee(aTrainee)
				is_tying = true
			endif
		endif
		i += 1
	EndWhile
	
	if is_working_ok
		mind.CheckAndRegisterKink(106,0.5) ; "objectifying slaves"
	endif

	; Check if slaves were tied-up
	if is_tying
		mind.CheckAndRegisterKink(103,0.5) ; "tying-up slaves" 
	endif
EndFunction

Function PoseTrainees()
	int i = 0
	bool is_working_ok = false
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			if !aTrainee.is_behaviour_pose ; pose trainee
				PoseTrainee(aTrainee)
				is_working_ok = true
			endif
		endif
		i += 1
	EndWhile
	if is_working_ok
		mind.CheckAndRegisterKink(106,0.5) ; "objectifying slaves"
	endif
EndFunction

Function MasturbateOrRestrainTrainees()
	int i = 0
	bool is_working_ok = false
	bool is_tying = false
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			if aTrainee.canMove
				float sub_level = (aTrainee.mind.resignation+aTrainee.mind.submission)/2.0
				float training_level = aTrainee.mind.sex_training
				if sub_level > 50.0*RandomFloat()+50.0 && training_level < 100.0*RandomFloat()
					if aTrainee.behaviour != "masturbate"
						MasturbateTrainee(aTrainee)
						is_working_ok = true
					endif
				else
					SecureTrainee(aTrainee)
					is_tying = true
				endif
			endif
		endif
		i += 1
	EndWhile
	
	; Check masturbating slaves
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			if aTrainee.behaviour != "masturbate" && !aTrainee.is_restrained && aTrainee.canMove
				SecureTrainee(aTrainee)
				is_tying = true
			endif
		endif
		i += 1
	EndWhile

	if is_working_ok
		mind.CheckAndRegisterKink(105,0.5) ; "humiliating slaves"
	endif
	
	; Check if slaves were tied-up
	if is_tying
		mind.CheckAndRegisterKink(103,0.5) ; "tying-up slaves" 
	endif
EndFunction

Function MasturbateTrainees()
	int i = 0
	bool is_working_ok = false
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			if aTrainee.behaviour != "masturbate" && aTrainee.canMove
				float training_level = aTrainee.mind.sex_training
				float x = RandomFloat()
				if training_level > 80.0 && x > 0.6
					aTrainee.EnterMasturbateLaying(akRef)
				elseif training_level > 50.0 && x > 0.4
					aTrainee.EnterMasturbateKneeling(akRef)
				else
					aTrainee.EnterMasturbateStanding(akRef)
				endif
				is_working_ok = true
			endif
		endif
		i += 1
	EndWhile
	if is_working_ok
		mind.CheckAndRegisterKink(105,0.5) ; "humiliating slaves"
	endif
EndFunction

Function DanceTrainees()
	int i = 0
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			DanceTrainee(aTrainee)
		endif
		i += 1
	EndWhile
EndFunction

Function DisplayTrainees()
	int i = 0
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			DisplayTrainee(aTrainee)
		endif
		i += 1
	EndWhile
EndFunction

Function SecureTrainees()
	int i = 0
	bool is_working_ok = false
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			RestrainTrainee(aTrainee)
			is_working_ok = true
		endif
		i += 1
	EndWhile
	if is_working_ok
		mind.CheckAndRegisterKink(103,1.0) ; "tying-up slaves" 
	endif
EndFunction

Function ChainTrainees()
	int i = 0
	bool is_working_ok = false
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			ChainTrainee(aTrainee)
			is_working_ok = true
		endif
		i += 1
	EndWhile
	if is_working_ok
		mind.CheckAndRegisterKink(103,1.0) ; "tying-up slaves" 
	endif
EndFunction

Function RestrainTraineesInFurniture()
	int i = 0
	bool is_working_ok = false
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None && !TraineeIsBusy(aTrainee)
			RestrainTraineeinFurniture(aTrainee)
			is_working_ok = true
		endif
		i += 1
	EndWhile
	if is_working_ok
		mind.CheckAndRegisterKink(103,1.0) ; "tying-up slaves" 
	endif
EndFunction

Function SecureTrainee(DOM_Actor aTrainee)
	if aTrainee.is_restrained
		return
	endif
	if !aTrainee.canMove 
		return
	endif
	float training_level = (aTrainee.mind.resignation+aTrainee.mind.submission+aTrainee.mind.humiliation)/3.0
	float x = RandomFloat()
	if training_level < 50.0 && x > 0.5;
		RestrainTraineeInFurniture(aTrainee)
	elseif training_level < 70.0 && x > 0.5
		ChainTrainee(aTrainee)
	else ; tie up trainee
		RestrainTrainee(aTrainee)
	endif
EndFunction

Function PoseTrainee(DOM_Actor aTrainee)
	aTrainee.ExitTieUpIfTied(akRef)
	if !aTrainee.canMove
		return
	endif
	if !aTrainee.mind.is_love_interest 
		aTrainee.DoExercise(akRef)
	else
		int iRand = RandomInt(1,8)
		if iRand == 1
			aTrainee.DoAssPresentation(akRef)
		elseif iRand == 2
			aTrainee.DoBreastsPresentation(akRef)
		elseif iRand == 3
			aTrainee.DoPussyPresentation(akRef)
		elseif iRand == 4
			aTrainee.DoSubmissive(akRef)
		elseif iRand == 5
			aTrainee.DoCute(akRef)
		elseif iRand == 6
			aTrainee.DoExercise(akRef)
		else
			aTrainee.DoDisplay(akRef)
		endif
	endif
EndFunction

Function RestrainTrainee(DOM_Actor aTrainee)
	; Make sure actors are together
	if !IsTogetherWithFast(akRef, aTrainee.akRef)
		return
	endif

	; Choose pose according to Trainee personality
	string aquietPose    = DOM01.DOM_Anim.GetTieupKneeling(self)
	string aStrugglePose = DOM01.DOM_Anim.GetTieupStrugglePose(aquietPose)

	; Normally we should make sure the Slaver has the right cuffs and remove them from inventory
	; Choose cuffs according to how smart is the Trainee
	Form cuffs = DOM01.DOMZaz.GetSmartCuffs(aTrainee.mind.FACET_Smartness)
	FaceActor(akRef,aTrainee.akRef)
	aTrainee.SetPoseTied(aquietPose, aStrugglePose)
	aTrainee.EnterTieUp(akRef,cuffs)
EndFunction

Function MasturbateTrainee(DOM_Actor aTrainee)
	if aTrainee.is_behaviour_masturbate
		aTrainee.MasturbateHarder(akRef)
		return
	endif
	if !aTrainee.canMove
		return
	endif
	float training_level = aTrainee.mind.sex_training
	float x = RandomFloat()
	if training_level > 80.0 && x > 0.6
		aTrainee.EnterMasturbateLaying(akRef)
	elseif training_level > 50.0 && x > 0.4
		aTrainee.EnterMasturbateKneeling(akRef)
	else
		aTrainee.EnterMasturbateStanding(akRef)
	endif
EndFunction

Function DanceTrainee(DOM_Actor aTrainee)
	SendNotificationAction(title+name+" puts "+aTrainee.getName()+" in submissive pose")
	aTrainee.DoDance(akRef)
EndFunction

Function DisplayTrainee(DOM_Actor aTrainee)
	SendNotificationAction(title+name+" puts "+aTrainee.getName()+" in submissive pose")
	aTrainee.DoSubmissive(akRef)
EndFunction

Function ChainTrainee(DOM_Actor aTrainee)
	string aquietPose = DOM01.DOM_Anim.GetChainPose(aTrainee)

	SendNotificationAction(title+name+" puts "+aTrainee.getName()+" in pose "+aquietPose)
	FaceActor(akRef,aTrainee.akRef)
	aTrainee.EnterChained(akRef, None, aquietPose, aquietPose)
EndFunction

Function RestrainTraineeInFurniture(DOM_Actor aTrainee)
	string aquietPose = DOM01.DOM_Anim.GetFurniturePose(aTrainee)

	SendNotificationAction(title+name+" puts "+aTrainee.getName()+" in pose "+aquietPose)
	FaceActor(akRef,aTrainee.akRef)
	aTrainee.EnterRestrained(akRef,None,aquietPose) ; do not animate trainer
EndFunction

Function LoadTrainee()
	DOM01.SetActorToJoin(self)
EndFunction

Function LoadAllTrainees(ReferenceAlias[] the_trainees)
	string the_order = "SetTrainer"
	int n = the_trainees.length
	int i = 0
	While i < n
		DOM_Actor aTrainee = the_trainees[i] as DOM_Actor
		if aTrainee != None
			if !DOM01.isATaskMistress(aTrainee.akRef)
				if DOM01.sendDOMEvents
					aTrainee.is_group_order = true
					aTrainee.RegisterForOrder(akRef,the_order,"",true)
				else
					aTrainee.SetTrainer(self)
				endif
			endif
		endif
		i += 1
	EndWhile
	DOM01.SendDOMOrder(akRef,the_order,"",true)
EndFunction

Function UnloadAllTrainees()
	string the_order = "SeparateFromTrainer"
	int i = 0
	While i < GetTraineeCount()
		DOM_Actor aTrainee = traineeArray[i]
		if aTrainee != None
			if DOM01.sendDOMEvents
				aTrainee.is_group_order = true
				aTrainee.RegisterForOrder(akRef,the_order,"",true)
			else
				aTrainee.SeparateFromTrainer()
			endif
		endif
		i += 1
	EndWhile
	DOM01.SendDOMOrder(akRef,the_order,"",true)
EndFunction

; Special reset

Function QueueNiNodeUpdate()
	if akRef == None
		return
	endif
	if !akRef.Is3dLoaded()
		return
	endif
	if akRef.IsOnMount()
		return
	endif
	akRef.QueueNiNodeUpdate()
EndFunction

bool is_resetting = false
Function SpecialReset()
	DOM01.CheckDistanceToCell(akRef,0)
	is_resetting = true
	;*ogTrace("SpecialReset() dialogue blocked for actor blocked="+is_dialogue_blocked_for+" global="+DOM01.is_dialogue_global_blocked_for)
	akRef = GetActorRef()
	akRef.Disable()
	akRef.Enable()
	akRef.SetAlpha(1.0)
	correct_behaviour_busy = false
	Recheck()
	if akRef.IsInFaction(DOM01.DOMActionFleeing)
		if !is_running_away && behaviour != "flee_and_cower"
			akRef.RemoveFromFaction(DOM01.DOMActionFleeing)
		endif
	endif
	CalmActorFast(akRef)
	LogTrace("SpecialReset Anim_IdleReset")
	Anim_IdleReset()
	QueueNiNodeUpdate()
	if akRef.GetDisplayName() != name
		LogTrace("SpecialReset SetDisplayName name="+name+" akRef="+akRef)
		akRef.SetDisplayName(name,true)
	endif
	ResetDialogue()
	correct_behaviour_busy = false
	equip_inventory_busy = false
	__equip_inventory_cancel = false
	wait_for_equipment = false
	is_initializing = false
	mind.is_initializing = false
	__is_mind_initializing = false
	canIdleSexlab = true
	canAnimate = true 
	canAnimateLocal = true 
	canAnimateSexlab = true 
	mind.RestoreHealth()
	mind.SetAllowGearFaction()
	was_inventory_changed = true
	LogEquip("SpecialReset: SendOrderEquipInventory")
	SendOrderEquipInventory(false)
	if mind.whipping_active
		EndWhipping(None)
	endif
	if DOM01.DOMZaz.wornMouthGag(akRef)
		has_mouth_gag = true
	else
		has_mouth_gag = false
	endif
	nextEnterPose = enterPose
	nextExitPose = exitPose
	nextPoseId = poseID
	nextQuietPose = quietPose
	nextStrugglePose = strugglePose
	nextTiedInFurniture = currentTiedInFurniture
	GoToState(__behaviour)
	StartBehaviour()
	OnBehaviourUpdate()
	is_resetting = false
EndFunction

Function RestartBehaviour()
	behaviour_is_busy = true
	;*ogTrace("RestartBehaviour() and clear DOMAction and Sexlab factions")
	
	DOM01.DOMSexlab.ClearAnimatingFaction(akRef)
	if mind.should_fight_for_player
		akRef.SetFactionRank(DOM01.DOMActionFighting,1)
	else
		akRef.RemoveFromFaction(DOM01.DOMActionFighting)
	endif	
	akRef.RemoveFromFaction(DOM01.DOMActionFleeing)
	akRef.RemoveFromFaction(DOM01.DOMActionFollowing)
	akRef.RemoveFromFaction(DOM01.DOMActionGuard)
	akRef.RemoveFromFaction(DOM01.DOMActionJailed)
	akRef.RemoveFromFaction(DOM01.DOMActionKneeling)
	akRef.RemoveFromFaction(DOM01.DOMActionMasturbating)
	akRef.RemoveFromFaction(DOM01.DOMActionPosing)
	akRef.RemoveFromFaction(DOM01.DOMActionPunishing)
	akRef.RemoveFromFaction(DOM01.DOMActionSweeping)
	akRef.RemoveFromFaction(DOM01.DOMActionTied)
	akRef.RemoveFromFaction(DOM01.DOMActionTraining)
	akRef.RemoveFromFaction(DOM01.DOMActionTravel)
	akRef.RemoveFromFaction(DOM01.DOMActionWaiting)

	behaviour_is_busy = false
	GoToState(__behaviour)
	StartBehaviour()
EndFunction

Function SpecialResetWithAnim(string the_anim)
	is_resetting = true
	;*ogTrace("SpecialReset() dialogue blocked for actor pose="+the_anim+" blocked="+is_dialogue_blocked_for+" global="+DOM01.is_dialogue_global_blocked_for)
	akRef.SetAlpha(0.0)
	akRef.Disable()
	akRef.Enable()
	CalmActorFast(akRef)
	LogAnim("SpecialResetWithAnim anim="+the_anim)
	if the_anim != ""
		Debug.SendAnimationEvent(akRef, the_anim)
	else
		Debug.SendAnimationEvent(akRef,"IdleForceDefaultState")
	endif
	akRef.SetAlpha(1.0)
	QueueNiNodeUpdate()
	ResetDialogue()
	is_resetting = false
EndFunction

; ##################################################
; ### Dialogues, Answers, Topics and random comments

int is_dialogue_blocked_for = 0
int is_weather_dialogue_blocked_for = 0

Function ResetDialogue()
	is_dialogue_blocked_for = 0
	is_weather_dialogue_blocked_for = 0
	DOM01.is_dialogue_global_blocked_for = 0
	DOM01.is_weather_dialogue_global_blocked_for = 0
	interact_is_busy = false
	akRef.ClearLookAt()
	akRef.AllowPCDialogue(true)
	akRef.AllowBleedoutDialogue(true)
EndFunction

Function HandleDialogueOnActivate()
	LogTrace("HandleDialogueOnActivate() akRef="+akRef)
	if akRef == None
		return
	endif
	akRef.SetAlpha(1.0)
	;QueueNiNodeUpdate()
	;*ogTrace("HandleDialogueOnActivate() is_in_combat="+is_in_combat)
	if akRef.IsInCombat()
		;akRef.StopCombat() ; not needed
		;*ogTrace("HandleDialogueOnActivate() StopCombatAlarm")
		akRef.StopCombatAlarm()
		;*ogTrace("HandleDialogueOnActivate() Activate")
		akRef.Activate(PlayerRef, abDefaultProcessingOnly = true)
	endif	
EndFunction

bool Function CanAnswer()
	;LogTrace("CanAnswer has_mouth_gag="+has_mouth_gag)
	if actorType != 0 ; animal or Creature
		;LogTrace("CanAnswer NO creature")
		return false
	endif
	if !DOM01.answerToggle
		;LogTrace("CanAnswer OFF")
		return false
	endif
	if !akRef.Is3DLoaded()
		;LogTrace("CanAnswer Not 3D loaded")
		return false
	endif
	if has_mouth_gag
		;LogTrace("CanAnswer NO mouth gag")
		return false
	endif
	return !mind.IsPassedOut()
EndFunction

bool Function CanTalk()
	;LogTrace("CanTalk blocked="+is_dialogue_blocked_for+" global blocked="+DOM01.is_dialogue_global_blocked_for)
	if is_dialogue_blocked_for > 0
		;LogTrace("CanTalk NO blocked")
		return false
	endif
	if DOM01.is_dialogue_global_blocked_for > 0
		;LogTrace("CanTalk NO global blocked")
		return false
	endif
	if akRef.IsInDialogueWithPlayer() ; no comments during dialogue
		;LogTrace("CanTalk NO in dialogue with player")
		return false
	endif
	return CanAnswer()
EndFunction

bool Function CanMakeSound()
	if !DOM01.topicsToggle
		return false
	endif
	if !akRef.Is3DLoaded()
		return false
	endif
	if is_dialogue_blocked_for > 0
		return false
	endif
	if DOM01.is_dialogue_global_blocked_for > 0
		return false
	endif
	if mind.IsPassedOutNotDrunk()
		return false
	endif
	if akRef.IsInDialogueWithPlayer() ; enable to avoid shouting during dialogue
		return false
	endif
	return true
EndFunction

Function SayTopic(Topic topic_to_say, ObjectReference say_to = None)
	;LogTrace("SayTopic blocked="+is_dialogue_blocked_for+" global blocked="+DOM01.is_dialogue_global_blocked_for)
	is_dialogue_blocked_for = DOM01.delayTopic ; no more talking for 30 * update delay in seconds
	DOM01.is_dialogue_global_blocked_for = DOM01.delayTopicGlobal ; no other slaves talking for 10 * update delay in seconds
	;if say_to != None
	;	akRef.SetLookAt(say_to)
	;endif
	LogTopic(topic_to_say)
	akRef.Say(topic_to_say,akRef,false)
EndFunction

Function ChooseTopic(Actor akTarget)
	if !CanTalk()
		return
	endif
	if akRef.IsInFaction(DOM01.DOMActorFriendIsVictim)
		ChooseFriendTopic(akTarget)
		return
	endif
	if akRef.IsInFaction(DOM01.DOMActorRivalIsVictim)
		ChooseRivalTopic(akTarget)
		return
	endif
	if mind.whipping_active  && mind.WillTalkUnderPain() ; See pain topics
		ChoosePainTopic(akTarget)
		return
	endif

	float distance = akRef.GetDistance(PlayerRef) ; Skyrim units 10 000 = 142 m
	if distance > 400.0	; Master should be close enough 400=5.7m
		;*ogTrace("say something? Too far")
		return
	endif
	
	if !mind.WillTalkSpontaneously()
		return
	endif
	
	if mind.WillNotTalk()
		return
	endif

	if !mind.WillTalkAboutFeelingsOrEmotions()
		;*ogTrace("say something? Nothing to say about feelings or emotions - try mood")
		;*ogTrace("say something? Nothing to say about feelings or emotions - try mood")
		mind.ChooseTopic()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	;*ogTrace("ChooseTopic: "+name+" call IsNotRespectful")
	bool not_respectful = mind.IsNotRespectful(0.6)
	int isubject = mind.GetMainEmotion()
	;*ogTrace("say: subject "+isubject+" "+submission)
	;*ogTrace("say: subject "+isubject+" "+mind.submission+" respectful="+(!not_respectful))
	if not_respectful
		if isubject == 0
			SayTopic(DOM01.DOM02TopicAnswerSubmission,akTarget)
		elseif isubject == 1
			SayTopic(DOM01.DOM02TopicAnswerFear,akTarget) 
		elseif isubject == 2
			SayTopic(DOM01.DOM02TopicAnswerHumiliation,akTarget) 
		elseif isubject == 3
			SayTopic(DOM01.DOM02TopicAnswerAngry,akTarget) 
		elseif isubject == 4
			SayTopic(DOM01.DOM02TopicAnswerResignation,akTarget) 
		else
			SayTopic(DOM01.DOM02TopicAnswerRespect,akTarget) 
		endif
	else
		if isubject == 0
			SayTopic(DOM01.DOM02TopicAnswerSubmissionRespectful,akTarget)
		elseif isubject == 1
			SayTopic(DOM01.DOM02TopicAnswerFearRespectful,akTarget) 
		elseif isubject == 2
			SayTopic(DOM01.DOM02TopicAnswerHumiliationRespectful,akTarget) 
		elseif isubject == 3
			SayTopic(DOM01.DOM02TopicAnswerAngryRespectful,akTarget) 
		elseif isubject == 4
			SayTopic(DOM01.DOM02TopicAnswerResignationRespectful,akTarget) 
		else
			SayTopic(DOM01.DOM02TopicAnswerRespectRespectful,akTarget) 
		endif
	endif
EndFunction

Function ChooseYellPain()
	if !CanMakeSound() 
		return
	endif
	if RandomFloat() > mind.MOD_Sincerity
		return
	endif
	if RandomFloat()*100.0 < mind.FACET_Toughness
		return
	endif
	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	mind.TrainHumiliation(0.5)
	if has_mouth_gag
		DOM01.SlapGagged.Play(akRef)
		return
	endif
	DOM01.SlapMoan.Play(akRef)
	mind.SetNextPunishmentReasonSilent(6) ; "yelling"
EndFunction

Function ChoosePainTopic(Actor akTarget)
	if !CanTalk() 
		return
	endif
	if RandomFloat() > 0.25
		return
	endif
	float distance = akRef.GetDistance(akTarget) ; Skyrim units 10 000 = 142 m
	if distance > 800.0	; Master should be close enough 800=11.4m
		;*ogTrace("say something for pain? Too far")
		return
	endif

	if !mind.WillTalkUnderPain()
		return
	endif

	if mind.WillNotTalk()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	;*ogTrace("ChoosePainTopic: "+name+" call IsNotRespectful")
	bool not_respectful = mind.IsNotRespectful(0.5)
	int isubject = mind.GetPainTopicSubject()
	;*ogTrace("pain say subject "+isubject)
	if not_respectful
		if isubject == 0
			SayTopic(DOM01.DOM02TopicAnswerPain1,akTarget)
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		elseif isubject == 1
			SayTopic(DOM01.DOM02TopicAnswerPain2,akTarget) 
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		elseif isubject == 2
			SayTopic(DOM01.DOM02TopicAnswerPain3,akTarget) 
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		elseif isubject == 3
			SayTopic(DOM01.DOM02TopicAnswerPain4,akTarget) 
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		else
			SayTopic(DOM01.DOM02TopicAnswerPain5,akTarget) 
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		endif
	else
		if isubject == 0
			SayTopic(DOM01.DOM02TopicAnswerPain1Respectful,akTarget)
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		elseif isubject == 1
			SayTopic(DOM01.DOM02TopicAnswerPain2Respectful,akTarget) 
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		elseif isubject == 2
			SayTopic(DOM01.DOM02TopicAnswerPain3Respectful,akTarget) 
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		elseif isubject == 3
			SayTopic(DOM01.DOM02TopicAnswerPain4Respectful,akTarget) 
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		else
			SayTopic(DOM01.DOM02TopicAnswerPain5Respectful,akTarget) 
			;*ogTrace("pain say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerPain1)
		endif
	endif
EndFunction

Function ChooseFriendTopic(Actor akTarget)
	if !CanTalk()
		return
	endif
	float distance = akRef.GetDistance(akTarget) ; Skyrim units 10 000 = 142 m
	if distance > 800.0	; Master should be close enough 800=11.4m
		;*ogTrace("say something for friend? Too far")
		return
	endif

	if !mind.WillTalkForFriend()
		return
	endif

	if mind.WillNotTalk()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	;*ogTrace("ChooseFriendTopic: "+name+" call IsNotRespectful")
	bool not_respectful = mind.IsNotRespectful(0.6)
	int isubject = mind.GetFriendTopicSubject()
	;*ogTrace("friend say subject "+isubject)
	if not_respectful
		if isubject == 0 ; 0=past 
			SayTopic(DOM01.DOM02TopicAnswerFriend0,akTarget) ; Default
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend0)
		elseif isubject == 1 ; 1=pain
			SayTopic(DOM01.DOM02TopicAnswerFriend1,akTarget) ; Pain
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend1)
		elseif isubject == 2 ; 2=sexual abuse
			SayTopic(DOM01.DOM02TopicAnswerFriend2,akTarget) ; Sexual abuse
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend2)
		elseif isubject == 3 ; 3=verbal abuse
			SayTopic(DOM01.DOM02TopicAnswerFriend3,akTarget) ; Verbal abuse
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend3)
		else ; 4=manipulation
			SayTopic(DOM01.DOM02TopicAnswerFriend4,akTarget) ; Manipulation
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend4)
		endif
	else
		if isubject == 0
			SayTopic(DOM01.DOM02TopicAnswerFriend0Respectful,akTarget)
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend0)
		elseif isubject == 1
			SayTopic(DOM01.DOM02TopicAnswerFriend1Respectful,akTarget) 
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend1)
		elseif isubject == 2
			SayTopic(DOM01.DOM02TopicAnswerFriend2Respectful,akTarget) 
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend2)
		elseif isubject == 3
			SayTopic(DOM01.DOM02TopicAnswerFriend3Respectful,akTarget) 
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend3)
		else
			SayTopic(DOM01.DOM02TopicAnswerFriend4Respectful,akTarget) 
			;*ogTrace("friend say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerFriend4)
		endif
	endif
	; Avoid more than one comment per scene
	akRef.RemoveFromFaction(DOM01.DOMActorFriendIsVictim)
EndFunction

Function ChooseWeatherTopic(Actor akTarget, int weatherType)
	;*ogTrace("ChooseWeatherTopic: "+name+" cantalk="+CanTalk()+" is_weather_dialogue_blocked_for="+is_weather_dialogue_blocked_for+" global blocked="+DOM01.is_weather_dialogue_global_blocked_for)
	if !CanTalk()
		return
	endif
	if is_weather_dialogue_blocked_for > 0 || DOM01.is_weather_dialogue_global_blocked_for > 0
		return
	endif
	;		if wClass == 3     ; weather class: snow
	;		elseif wClass == 2 ; weather class: rain
	;		elseif wClass == 1 ; weather class: cloudy
	;		elseif wClass == 0 ; weather class: pleasant
	;		else               ; no current weather
	if weatherType < 1
		return
	endif

	float distance = akRef.GetDistance(akTarget) ; Skyrim units 10 000 = 142 m
	if distance > 1000.0	; Master should be close enough 1000=15m
		;*ogTrace("ChooseWeatherTopic: "+name+" say something for weather? Too far")
		return
	endif

	if !mind.WillTalkForWeather()
		return
	endif

	if mind.WillNotTalk()
		return
	endif

	;*ogTrace("OnChooseWeatherTopic: "+name+" cantalk="+CanTalk()+" is_weather_dialogue_blocked_for="+is_weather_dialogue_blocked_for+" global blocked="+DOM01.is_weather_dialogue_global_blocked_for)
	;*ogTrace("OnChooseWeatherTopic: "+name+" call IsNotRespectful")
	is_weather_dialogue_blocked_for += DOM01.delayTopic*2 ; * 1.0 seconds (3 minutes) as in RegisterForSingleUpdate(1.0)
	DOM01.is_weather_dialogue_global_blocked_for += DOM01.delayTopicGlobal*2 ; * 1.0 seconds (1 minute) as in RegisterForSingleUpdate(1.0)
	is_dialogue_blocked_for += 1 ; all dialogues blocked for 2 seconds
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.6)
	;*ogTrace("ChooseWeatherTopic: "+name+" weather say subject "+weatherType)
	if not_respectful
		if weatherType == 3
			SayTopic(DOM01.DOM02TopicAnswerWeather3,akTarget)
			;*ogTrace("weather say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerWeather3)
		elseif weatherType == 2
			SayTopic(DOM01.DOM02TopicAnswerWeather2,akTarget) 
			;*ogTrace("weather say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerWeather2)
		elseif weatherType == 1
			SayTopic(DOM01.DOM02TopicAnswerWeather1,akTarget) 
			;*ogTrace("weather say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerWeather1)
		endif
	else
		if weatherType == 3
			SayTopic(DOM01.DOM02TopicAnswerWeather3Respectful,akTarget)
			;*ogTrace("weather say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerWeather3)
		elseif weatherType == 2
			SayTopic(DOM01.DOM02TopicAnswerWeather2Respectful,akTarget) 
			;*ogTrace("weather say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerWeather2)
		elseif weatherType == 1
			SayTopic(DOM01.DOM02TopicAnswerWeather1Respectful,akTarget) 
			;*ogTrace("weather say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerWeather1)
		endif
	endif
EndFunction

Function ChooseRivalTopic(Actor akTarget)
	if !CanTalk()
		return
	endif
	float distance = akRef.GetDistance(akTarget) ; Skyrim units 10 000 = 142 m
	if distance > 800.0	; Master should be close enough 800=11.4m
		;*ogTrace("say something for rival? Too far")
		return
	endif

	if !mind.WillTalkForRival()
		return
	endif

	if mind.WillNotTalk()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	int isubject = mind.GetRivalTopicSubject()
	;*ogTrace("rival say subject "+isubject)
		if isubject == 0
			SayTopic(DOM01.DOM02TopicAnswerRival0,akTarget)
			;*ogTrace("rival say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerRival0)
		elseif isubject == 1
			SayTopic(DOM01.DOM02TopicAnswerRival1,akTarget) 
			;*ogTrace("rival say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerRival1)
		elseif isubject == 2
			SayTopic(DOM01.DOM02TopicAnswerRival2,akTarget) 
			;*ogTrace("rival say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerRival2)
		elseif isubject == 3
			SayTopic(DOM01.DOM02TopicAnswerRival3,akTarget) 
			;*ogTrace("rival say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerRival3)
		else
			SayTopic(DOM01.DOM02TopicAnswerRival4,akTarget) 
			;*ogTrace("rival say subject "+isubject+" topic="+DOM01.DOM02TopicAnswerRival4)
		endif
	; Avoid more than one comment per scene
	akRef.RemoveFromFaction(DOM01.DOMActorRivalIsVictim)
EndFunction

Function ChooseCommentCollide(Actor akTarget)
	if !CanTalk()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.5)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerCollide,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerCollideRespectful,akTarget)
	endif

	if !not_respectful
		return
	endif
	if RandomFloat()*100.0 < mind.respect_training
		return
	endif
	if RandomFloat() < mind.MOD_Discipline
		return
	endif
	Anim_CrossArms()
EndFunction

Function ChooseCommentIdle(Actor akTarget)
	if !CanTalk()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.5)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerIdle,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerIdleRespectful,akTarget)
	endif
EndFunction

Function ChooseCommentSwingWeapon(Actor akTarget)
	if !CanTalk()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.5)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerSwingWeapon,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerSwingWeaponRespectful,akTarget)
	endif
EndFunction

Function ChooseCommentSorry(Actor akTarget)
	;*ogTrace("ChooseCommentSorry() canTalk="+canTalk())
	if !CanTalk()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.6)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerSorry,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerSorryRespectful,akTarget)
	endif
EndFunction

Function ChooseCommentBad(Actor akTarget)
	if !CanTalk()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.3)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerBad,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerBadRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerHello(Actor akTarget)
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.5)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerHello,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerHelloRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerGoodbye(Actor akTarget)
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.5)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerGoodbye,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerGoodbyeRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerNo(Actor akTarget)
	;*ogTrace("ChooseAnswerNo() canTalk="+canTalk())
	Anim_PoseByString("LooseDialogueResponseNegative")
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.5)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerNo,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerNoRespectful,akTarget)
	endif

	if RandomFloat()*100.0 < mind.respect_training
		return
	endif
	if RandomFloat() < mind.MOD_Discipline
		return
	endif
	Anim_CrossArms()
EndFunction

Function ChooseAnswerYes(Actor akTarget)
	;*ogTrace("ChooseAnswerYes() canTalk="+canTalk())
	Anim_PoseByString("LooseDialogueResponsePositive")
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.6)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerYes,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerYesRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerThanks(Actor akTarget)
	;*ogTrace("ChooseAnswerThanks() canTalk="+canTalk())
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.7)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerThanks,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerThanksRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerSorry(Actor akTarget)
	;*ogTrace("ChooseAnswerSorry() canTalk="+canTalk())
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.6)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerSorry,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerSorryRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerWhat(Actor akTarget)
	;*ogTrace("ChooseAnswerWhat() canTalk="+canTalk())
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.4)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerWhat,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerWhatRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerValue(Actor akTarget)
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.5)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerValue,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerValueRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerStrip(Actor akTarget)
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.4)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerStrip,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerStripRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerBad(Actor akTarget)
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	bool not_respectful = mind.IsNotRespectful(0.3)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerBad,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerBadRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerNewPromise(Actor akTarget)
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	SendNotification(title+name+" has been promised "+mind.promiseOath)	
	bool not_respectful = mind.IsNotRespectful(0.6)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerNewPromise,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerNewPromiseRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerKeptPromise(Actor akTarget)
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	if mind.promiseOath == "to be gentle"
		SendNotification(title+name+" "+actorBeVerb+" impressed that you kept your promise to be gentle")	
	else
		SendNotification(title+name+" "+actorBeVerb+" impressed that you kept your promise of "+mind.promiseOath)	
	endif
	bool not_respectful = mind.IsNotRespectful(0.6)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerKeptPromise,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerKeptPromiseRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerFailedPromise(Actor akTarget)
	if !CanAnswer()
		return
	endif

	is_dialogue_blocked_for += 1
	DOM01.is_dialogue_global_blocked_for += 1
	if mind.promiseOath == "to be gentle"
		SendNotification(title+name+" doesn't believe in your promise to be gentle anymore")	
	else
		SendNotification(title+name+" doesn't believe in your promise of "+mind.promiseOath+" anymore")	
	endif
	bool not_respectful = mind.IsNotRespectful(0.4)
	if not_respectful
		SayTopic(DOM01.DOM02TopicAnswerFailedPromise,akTarget)
	else
		SayTopic(DOM01.DOM02TopicAnswerFailedPromiseRespectful,akTarget)
	endif
EndFunction

Function ChooseAnswerHelp(Actor akTarget = None)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerHelp,akTarget)
EndFunction

Function ChooseAnswerAttack(Actor akTarget)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerAttack,akTarget)
EndFunction

Function ChooseAnswerOrgasm(Actor akTarget)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerOrgasm,akTarget)
EndFunction

Function ChooseAnswerAroused(Actor akTarget)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerAroused,akTarget)
EndFunction

Function ChooseAnswerTouchBegin(Actor akTarget)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerTouchBegin,akTarget)
EndFunction

Function ChooseAnswerTouchButt(Actor akTarget)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerTouchButt,akTarget)
EndFunction

Function ChooseAnswerTouchBreast(Actor akTarget)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerTouchBreast,akTarget)
EndFunction

Function ChooseAnswerTouchBase(Actor akTarget)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerTouchBase,akTarget)
EndFunction

Function ChooseAnswerTouchNeck(Actor akTarget)
	if !CanAnswer()
		return
	endif

	SayTopic(DOM01.DOM02TopicAnswerTouchNeck,akTarget)
EndFunction

; ###########################################################
; ### Flatter, insult, threaten and promises by player or NPC

bool Property interact_is_busy = false Auto Hidden

Function StartFlattering(Actor akAbuser)
	if DOM01.singleTellToggle && interact_is_busy
		return
	endif
	interact_is_busy = true
	string type = mind.GetBestFlatter()
	if mind.StartFlatteringWith(akAbuser,type)
		ChooseAnswerThanks(akAbuser)
		if type == "dirty" || type == "sexy"
			mind.CheckAndRegisterKink(8,0.5) ; "being talked dirty"
		endif
	else
		ChooseAnswerBad(akAbuser)
	endif
	interact_is_busy = false
EndFunction

Function StartFlatteringWith(Actor akAbuser, string type)
	if DOM01.singleTellToggle && interact_is_busy
		return
	endif
	interact_is_busy = true
	if mind.StartFlatteringWith(akAbuser,type)
		ChooseAnswerThanks(akAbuser)
		if type == "dirty" || type == "sexy"
			mind.CheckAndRegisterKink(8,0.5) ; "being talked dirty"
		endif
	else
		ChooseAnswerBad(akAbuser)
	endif
	interact_is_busy = false
EndFunction

Function StartInsulting(Actor akAbuser)
	if DOM01.singleTellToggle && interact_is_busy
		return
	endif
	interact_is_busy = true
	string type = mind.GetBestInsult()
	if mind.StartInsultingWith(akAbuser,type)
		ChooseAnswerSorry(akAbuser)
		mind.CheckAndRegisterKink(7,0.5) ; "being insulted"
	else
		ChooseAnswerBad(akAbuser)
	endif
	interact_is_busy = false
EndFunction

Function StartInsultingWith(Actor akAbuser, string type)
	if DOM01.singleTellToggle && interact_is_busy
		return
	endif
	interact_is_busy = true
	if mind.StartInsultingWith(akAbuser,type)
		ChooseAnswerSorry(akAbuser)
		mind.CheckAndRegisterKink(7,0.5) ; "being insulted"
	else
		ChooseAnswerBad(akAbuser)
	endif
	interact_is_busy = false
EndFunction

Function StartComfortingWith(Actor akAbuser, string type)
	if DOM01.singleTellToggle && interact_is_busy
		return
	endif
	interact_is_busy = true
	int result = mind.StartComfortingWith(akAbuser,type)
	if result == 0     ; Not responsive
		ChooseAnswerBad(akAbuser)
	elseif result == 1 ; Feels sorry
		ChooseAnswerSorry(akAbuser)
	elseif result == 2 ; Thankful
		ChooseAnswerThanks(akAbuser)
	else
		ChooseAnswerWhat(akAbuser)
	endif
	interact_is_busy = false
EndFunction

Function StartPromising(Actor akAbuser, string oath)
	if DOM01.singleTellToggle && interact_is_busy
		return
	endif
	if !mind.is_slave
		if oath != "rapture" && oath != "money"
			return
		endif
	endif
	interact_is_busy = true
	if mind.StartPromising(akAbuser,oath)
		ChooseAnswerNewPromise(akAbuser)
	endif
	interact_is_busy = false
EndFunction

Function StartThreatening(Actor akAbuser, string reason)
	if DOM01.singleTellToggle && interact_is_busy
		return
	endif
	interact_is_busy = true
	if mind.StartThreatening(akAbuser,reason)
		ChooseAnswerSorry(akAbuser)
	else
		ChooseAnswerBad(akAbuser)
	endif
	mind.CheckAndRegisterKink(9,1.0) ; "being threatened"
	interact_is_busy = false
EndFunction

; ########################################
; ### Praise, Punishments by player or NPC

Function StartPraising(Actor akAbuser, string reason="", string type="")
	LogTrace("StartPraising: START reason="+reason+" type="+type+" "+DOM01.singleTellToggle+" "+interact_is_busy)
	Interact_Praise(akAbuser,reason,type)
EndFunction

bool Property is_whipped = false Auto Hidden
bool Property is_slapped = false Auto Hidden
bool Property is_caned   = false Auto Hidden
Function StartSlapping()
	;*ogTrace("StartSlapping slapped="+is_slapped)
	if is_slapped ; Only once until punishment is over
		return
	endif
	is_whipped = false
	is_slapped = true
	is_caned   = false
	;*ogTrace("StartSlapping behaviour="+behaviour)
	if RandomFloat() > mind.MOD_Humility
		return
	endif
	
	if is_behaviour_pose
		if RandomFloat()*100.0 < mind.pose_training
			ChooseYellPain()
			return
		endif
		if !mind.HasNextPunishmentReason(15) && mind.WillObeyBecauseWarned(15) > 0 ; "didnt pose"
			ChooseYellPain()
			SendNotificationEmotion(name+" quivers from your slap but remembers your warning")
			return
		endif
		ChooseYellPain()
		if !mind.HasNextPunishmentReason(15) && mind.IsPunishingFor(15) ; "didnt pose"
			Anim_Stagger()
			mind.SetNextPunishmentReasonOnceMessage(15,"couldn't help but moved trying to avoid your slap") ; "didnt pose"
		endif
		return
	endif
	
	if is_behaviour_masturbate
		if RandomFloat()*100.0 < mind.pose_training
			ChooseYellPain()
			return
		endif
		if !mind.HasNextPunishmentReason(19) && mind.WillObeyBecauseWarned(19) > 0 ; "didnt masturbate"
			ChooseYellPain()
			SendNotificationEmotion(name+" quivers from your slap but remembers your warning")
			return
		endif
		ChooseYellPain()
		if !mind.HasNextPunishmentReason(19) && mind.IsPunishingFor(19) ; "didnt masturbate"
			Anim_Stagger()
			mind.SetNextPunishmentReasonOnceMessage(19,"couldn't help but move trying to avoid your slap") ; "didnt masturbate"
		endif
		return
	endif
	
	if RandomFloat()*100.0 > mind.pose_training
		Anim_Stagger()
	endif
	ChooseYellPain()
EndFunction

Function StartScolding(Actor akAbuser, string reason = "")
	if DOM01.singleTellToggle && interact_is_busy
		return
	endif
	;*ogTrace("StartScolding "+reason)
	interact_is_busy = true
	if mind.StartScolding(akAbuser, reason)
		;*ogTrace("StartScolding success "+reason)
		ChooseAnswerSorry(akAbuser)
		mind.CheckAndRegisterKink(4,0.25) ; "being scolded"
	else
		;*ogTrace("StartScolding fail "+reason)
		ChooseAnswerBad(akAbuser)
	endif
	interact_is_busy = false
EndFunction

Function StartPunishingByActor(Actor akAbuser, string reason, string type)
	;*ogTrace("StartPunishingByActor reason="+reason+" type="+type+" whip="+is_whipped+" slap="+is_slapped+" cane="+is_caned)
	if mind.StartPunishing(akAbuser,reason,type)
		if !mind.IsObedient()
			ChooseAnswerWhat(akAbuser)
		endif
	endif
EndFunction

Function StartPunishingWithTag(Actor akAbuser, string reason_name, string type, string tag)
	LogTrace("StartPunishingWithTag type="+type+" reason="+reason_name)
	if type == "rape" ; Only case where tag is used
		Anim_Sexlab(akAbuser, tag, true, reason_name) ; punishment
	else
		Interact_Punish(akAbuser,reason_name,type)
	endif
EndFunction

Function StartPunishing(Actor akAbuser, string reason_name = "", string type = "")
	;*ogTrace("StartPunishing reason="+reason_name+" type="+type)
	Interact_Punish(akAbuser,reason_name,type)
EndFunction

Function EndPunishing(Actor akAbuser, string type)
	;LogTrace("EndPunishing slapped="+is_slapped+" caned="+is_caned)
	mind.EndPunishing(akAbuser,type)
	is_slapped = false
	is_whipped = false
	is_caned   = false
	pain_giver = None
	ChooseTopic(akAbuser)
EndFunction

Function StartWhipping(Actor akAbuser, string reason = "")
	if akAbuser != None
		DOM_Actor akAggressorActor = DOM01.GetActor(akAbuser)
		if akAggressorActor != None
			akAggressorActor.SetWhippedTrainee(self)
		endif
	endif
	StartPunishingByActor(akAbuser,reason,"pain")
EndFunction

Function EndWhipping(Actor akAbuser)
	;LogTrace("EndWhipping EndPunishing slapped="+is_slapped+" caned="+is_caned)
	EndPunishing(akAbuser,"pain")
	if akAbuser != None
		DOM_Actor akAggressorActor = DOM01.GetActor(akAbuser)
		if akAggressorActor != None
			akAggressorActor.SetWhippedTrainee(None)
		endif
	endif
EndFunction

Function StartPunishmentOn(DOM_Actor akVictim, string reason_name, string type, string tag)
	;*ogTrace("StartPunishmentOn reason="+reason_name+" type="+type)
	if akVictim == None
		return
	endif
	if akVictim.akRef == None || akVictim.akRef == akRef
		return
	endif
	if is_bounded
		return
	endif
	if !mind.WillObeydominated(18) ; "didnt obey"
		ChooseAnswerNo(GetCurrentTrainer())
		return
	endif
	akVictim.StartPunishingWithTag(akRef, reason_name, type, tag)
EndFunction

; #####################
; ### Start sex actions

; ---------------------------------
; -------- Start sex from dialogues
; ---------------------------------

Function Dialogue_StartSexWith(int type)
	if !mind.WillObeydominated(21) ; "no_sex"
		ChooseAnswerNo(GetCurrentTrainer())
		return
	endif
	;*ogTrace("Dialogue_StartSexWith type="+type)
	ChooseAnswerYes(GetCurrentTrainer())
	if type < 20
		DOM01.SetActor1ToJoinSexlab(self,type)
	else
		DOM01.SetActor2ToJoinSexlab(self,type)
	endif
EndFunction

Function Dialogue_StartSexJoin()
	DOM_Actor akAnotherActor = DOM01.GetActor1ToJoinSexlab()
	if akAnotherActor == None
		LogTrace("Dialogue_StartSexJoin ERROR UNKNOWN ACTOR TO JOIN")
		return
	endif
	Actor the_actor = akAnotherActor.akRef
	if the_actor == None
		return
	endif
	int rank = the_actor.GetFactionRank(DOM01.DOMSexlabLoadSlave)
	if rank > 10
		rank -= 10
	endif
	if rank == 9 ; 4some with 1 actor 1 NPC and player
		LogTrace("Dialogue_StartSexJoin 4some AANP not implemented") ; Function exists
	elseif rank == 8 ; 4some with 3 actors
		LogTrace("Dialogue_StartSexJoin 4some AAAA with "+akAnotherActor.GetName())
		DOM_Actor akAnotherActor2 = DOM01.GetActor2ToJoinSexlab()
		if akAnotherActor2 == None
			LogTrace("Dialogue_StartSexJoin third actor is None")
		else
			DOM_Actor akAnotherActor3 = DOM01.GetActor3ToJoinSexlab()
			if akAnotherActor3 == None
				LogTrace("Dialogue_StartSexJoin fourth actor is None")
			else
				LogTrace("Dialogue_StartSexJoin 4some AAAA with "+akAnotherActor2.GetName()+" and "+akAnotherActor3.GetName())
				the_actor.SetFactionRank(DOM01.DOMSexlabLoadSlave,16) ; in scene
				akAnotherActor2.akRef.SetFactionRank(DOM01.DOMSexlabLoadSlave,16) ; in scene
				akAnotherActor3.akRef.SetFactionRank(DOM01.DOMSexlabLoadSlave,16) ; in scene
				DOM01.DOM_SexlabLoadSlave.SetValue(16)
				StartSexWith4AAAA(akAnotherActor, akAnotherActor2, akAnotherActor3, "", true); aggressive
			endif
		endif
	elseif rank == 7 ; threesome with 2 NPC
		LogTrace("Dialogue_StartSexJoin threesome ANN not implemented") ; Function exists
	elseif rank == 6 ; threesome with 1 NPC and 1 actor
		LogTrace("Dialogue_StartSexJoin threesome AAN not implemented") ; Function exists
	elseif rank == 5 ; threesome with 2 actors
		LogTrace("Dialogue_StartSexJoin threesome AAA with "+akAnotherActor.GetName())
		DOM_Actor akAnotherActor2 = DOM01.GetActor2ToJoinSexlab()
		if akAnotherActor2 == None
			LogTrace("Dialogue_StartSexJoin third actor is None")
		else
			LogTrace("Dialogue_StartSexJoin threesome AAA with "+akAnotherActor2.GetName())
			the_actor.SetFactionRank(DOM01.DOMSexlabLoadSlave,15) ; in scene
			akAnotherActor2.akRef.SetFactionRank(DOM01.DOMSexlabLoadSlave,15) ; in scene
			DOM01.DOM_SexlabLoadSlave.SetValue(15)
			StartSexWith3AAA(akAnotherActor, akAnotherActor2, "", true); aggressive
		endif
	elseif rank == 4 ; foursome with player and 2 actors
		LogTrace("Dialogue_StartSexJoin foursome AAAP with "+akAnotherActor.GetName())
		DOM_Actor akAnotherActor2 = DOM01.GetActor2ToJoinSexlab()
		if akAnotherActor2 == None
			LogTrace("Dialogue_StartSexJoin fourth actor is None")
		else
			LogTrace("Dialogue_StartSexJoin foursome AAAP with "+akAnotherActor2.GetName())
			the_actor.SetFactionRank(DOM01.DOMSexlabLoadSlave,14) ; in scene
			akAnotherActor2.akRef.SetFactionRank(DOM01.DOMSexlabLoadSlave,14) ; in scene
			DOM01.DOM_SexlabLoadSlave.SetValue(14)
			StartSexWith4AAAP(akAnotherActor, akAnotherActor2, "", true); aggressive
		endif
	elseif rank == 3 ; threesome with player and 1 actor
		LogTrace("Dialogue_StartSexJoin threesome AAP with "+akAnotherActor.GetName())
		the_actor.SetFactionRank(DOM01.DOMSexlabLoadSlave,13) ; in scene
		DOM01.DOM_SexlabLoadSlave.SetValue(13)
		StartSexWith3AAP(akAnotherActor, "", true); aggressive
	elseif rank == 2 ; aggressive
		LogTrace("Dialogue_StartSexJoin aggressive with "+akAnotherActor.GetName())
		the_actor.SetFactionRank(DOM01.DOMSexlabLoadSlave,12) ; in scene
		DOM01.DOM_SexlabLoadSlave.SetValue(12)
		StartPunishing(the_actor, "", "rape")
	elseif rank == 1 ; not aggressive
		LogTrace("Dialogue_StartSexJoin gentle with "+akAnotherActor.GetName())
		the_actor.SetFactionRank(DOM01.DOMSexlabLoadSlave,11) ; in scene
		DOM01.DOM_SexlabLoadSlave.SetValue(11)
		StartSexWithActor(akAnotherActor, "", false) ; not aggressive
	else
		LogTrace("Dialogue_StartSexJoin ERROR UNKNOWN TYPE="+rank+" with "+akAnotherActor.GetName())
	endif
EndFunction

; -------------------------------------------------------------------------
; -------- Start sex with a selected actor (and with or without the player)
; -------------------------------------------------------------------------

Function StartSexOnActor(DOM_Actor akAnotherActor, string type, bool aggro)
	LogTrace("StartSexOnActor")
	if akAnotherActor == None || akAnotherActor.akRef == akRef
		return
	endif
	if is_restrained
		return
	endif
	if !mind.WillObeydominated(21) ; "no_sex"
		ChooseAnswerNo(GetCurrentTrainer())
		return
	endif
	ChooseAnswerYes(GetCurrentTrainer())
	akAnotherActor.StartSexWithActor(self, type, aggro)
EndFunction

Function StartSexOnActor3AAP(DOM_Actor akAnotherActor, string type, bool aggro)
	if akAnotherActor == None || akAnotherActor.akRef == akRef
		return
	endif
	if is_restrained
		return
	endif
	if !mind.WillObeydominated(21) ; "no_sex"
		ChooseAnswerNo(PlayerRef)
		return
	endif
	ChooseAnswerYes(PlayerRef)
	akAnotherActor.StartSexWith3AAP(self, type, aggro) ; player is leading
EndFunction

Function StartSexOnActor4AAAP(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, string type, bool aggro)
	if akAnotherActor1 == None || akAnotherActor1.akRef == akRef
		return
	endif
	if akAnotherActor2 == None || akAnotherActor2.akRef == akRef
		return
	endif
	if is_restrained
		return
	endif
	if !mind.WillObeydominated(21) ; "no_sex"
		ChooseAnswerNo(PlayerRef)
		return
	endif
	ChooseAnswerYes(PlayerRef)
	akAnotherActor1.StartSexWith4AAAP(self, akAnotherActor2, type, aggro) ; player is leading
EndFunction

Function StartSexOnActor3AAA(DOM_Actor akAnotherActor1, DOM_Actor akOther2, string type, bool aggro)
	if akAnotherActor1 == None || akAnotherActor1.akRef == akRef
		return
	endif
	if akOther2 == None || akOther2.akRef == akRef
		return
	endif
	if is_restrained
		return
	endif
	if !mind.WillObeydominated(21) ; "no_sex"
		ChooseAnswerNo(GetCurrentTrainer())
		return
	endif
	ChooseAnswerYes(GetCurrentTrainer())
	akAnotherActor1.StartSexWith3AAA(akOther2, self, type, aggro) ; self is leading
EndFunction

Function StartSexOnActor4AAAA(DOM_Actor akAnotherActor1, DOM_Actor akOther2, DOM_Actor akOther3, string type, bool aggro)
	if akAnotherActor1 == None || akAnotherActor1.akRef == akRef
		return
	endif
	if akOther2 == None || akOther2.akRef == akRef
		return
	endif
	if akOther3 == None || akOther3.akRef == akRef
		return
	endif
	if is_restrained
		return
	endif
	if !mind.WillObeydominated(21) ; "no_sex"
		ChooseAnswerNo(GetCurrentTrainer())
		return
	endif
	ChooseAnswerYes(GetCurrentTrainer())
	akAnotherActor1.StartSexWith4AAAA(akOther2, akOther3, self, type, aggro) ; self is leading
EndFunction

; -------------------------------------------------------------------
; -------- Start sex with this actor (initiated by the player or NPC)
; -------------------------------------------------------------------

Function StartSexWithActor(DOM_Actor akAggressorActor, string type, bool aggro)
	LogTrace("StartSexWithActor akAggressorActor="+akAggressorActor+" type="+type+" aggro="+aggro)
	if akAggressorActor == None
		return
	endif
	Actor akAbuser = akAggressorActor.akRef
	if akAbuser == None
		return
	endif
	if aggro
		ChooseAnswerWhat(akAbuser)
		Anim_SexlabWithActor(akAggressorActor, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDegraded(21) ; "no_sex"
		ChooseAnswerNo(akAbuser)
		return
	endif
	
	ChooseAnswerYes(akAbuser)
	Anim_SexlabWithActor(akAggressorActor, type, false) ; not punishment
EndFunction

Function StartSexWith(Actor akAbuser, string type, bool aggro)
	;*ogTrace("StartSexWith actor="+akOther)
	if aggro
		ChooseAnswerWhat(akAbuser)
		Anim_Sexlab(akAbuser, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(akAbuser)
		return
	endif
	
	ChooseAnswerYes(akAbuser)
	Anim_Sexlab(akAbuser, type, false) ; not punishment
EndFunction

Function StartSexWithOstim(Actor akAbuser, string type, bool aggro)
	;*ogTrace("StartSexWith actor="+akOther)
	if aggro
		ChooseAnswerWhat(akAbuser)
		Anim_OStim(akAbuser, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(akAbuser)
		return
	endif
	
	ChooseAnswerYes(akAbuser)
	Anim_OStim(akAbuser, type, false) ; not punishment
EndFunction

Function StartSexWithNPC(Actor akAbuser, string type, bool aggro)
	;*ogTrace("StartSexWithNPC actor="+akOther)
	if aggro
		ChooseAnswerWhat(akAbuser)
		Anim_SexlabWithNPC(akAbuser, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(akAbuser)
		return
	endif
	
	ChooseAnswerYes(akAbuser)
	Anim_SexlabWithNPC(akAbuser, type, false) ; not punishment
EndFunction

Function StartSexWith3AAP(DOM_Actor akAnotherActor, string type, bool aggro)
	;*ogTrace("StartSexWith3AAP actor="+akAnotherActor)
	if akAnotherActor == None
		return
	endif
	if aggro
		ChooseAnswerWhat(PlayerRef)
		Anim_SexlabWith3AAP(akAnotherActor, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(PlayerRef)
		return
	endif
	
	ChooseAnswerYes(PlayerRef)
	Anim_SexlabWith3AAP(akAnotherActor, type, false) ; not punishment
EndFunction

Function StartSexWith4AAAP(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, string type, bool aggro)
	;*ogTrace("StartSexWith4AAAP actor="+akAnotherActor1+" "+akAnotherActor2)
	if akAnotherActor1 == None || akAnotherActor2 == None
		return
	endif
	if aggro
		ChooseAnswerWhat(PlayerRef)
		Anim_SexlabWith4AAAP(akAnotherActor1, akAnotherActor2, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(PlayerRef)
		return
	endif
	
	ChooseAnswerYes(PlayerRef)
	Anim_SexlabWith4AAAP(akAnotherActor1, akAnotherActor2, type, false) ; not punishment
EndFunction

Function StartSexWith3ANP(Actor akOther, string type, bool aggro)
	;*ogTrace("StartSexWith3ANP actor="+akOther)
	if akOther == None
		return
	endif
	if aggro
		ChooseAnswerWhat(PlayerRef)
		Anim_SexlabWith3ANP(akOther, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(PlayerRef)
		return
	endif
	
	ChooseAnswerYes(PlayerRef)
	Anim_SexlabWith3ANP(akOther, type, false) ; not punishment
EndFunction

Function StartSexWith4AANP(DOM_Actor akAnotherActor, Actor akOther, string type, bool aggro)
	;*ogTrace("StartSexWith4AANP actor="+akOther)
	if akAnotherActor == None || akOther == None
		return
	endif
	if aggro
		ChooseAnswerWhat(PlayerRef)
		Anim_SexlabWith4AANP(akAnotherActor, akOther, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(PlayerRef)
		return
	endif
	
	ChooseAnswerYes(PlayerRef)
	Anim_SexlabWith4AANP(akAnotherActor, akOther, type, false) ; not punishment
EndFunction

Function StartSexWith3AAA(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, string type, bool aggro)
	;*ogTrace("StartSexWith3AAA actor1="+akAnotherActor1+" actor2="+akAnotherActor2)
	if akAnotherActor1 == None || akAnotherActor2 == None
		return
	endif
	if aggro
		ChooseAnswerWhat(akAnotherActor2.akRef)
		Anim_SexlabWith3AAA(akAnotherActor1, akAnotherActor2, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(akAnotherActor2.akRef)
		return
	endif
	
	ChooseAnswerYes(akAnotherActor2.akRef)
	Anim_SexlabWith3AAA(akAnotherActor1, akAnotherActor2, type, false) ; not punishment
EndFunction

Function StartSexWith4AAAA(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, DOM_Actor akAnotherActor3, string type, bool aggro)
	;*ogTrace("StartSexWith4AAAA actor1="+akAnotherActor1+" actor2="+akAnotherActor2)
	if akAnotherActor1 == None || akAnotherActor2 == None || akAnotherActor3 == None
		return
	endif
	if aggro
		ChooseAnswerWhat(akAnotherActor3.akRef)
		Anim_SexlabWith4AAAA(akAnotherActor1, akAnotherActor2, akAnotherActor3, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(akAnotherActor3.akRef)
		return
	endif
	
	ChooseAnswerYes(akAnotherActor3.akRef)
	Anim_SexlabWith4AAAA(akAnotherActor1, akAnotherActor2, akAnotherActor3, type, false) ; not punishment
EndFunction

Function StartSexWith3AAN(DOM_Actor akAnotherActor, Actor akOther, string type, bool aggro)
	;*ogTrace("StartSexWith3AAN target="+akOther+" actor="+akAnotherActor)
	if akAnotherActor == None || akOther == None
		return
	endif
	if aggro
		ChooseAnswerWhat(akOther)
		Anim_SexlabWith3AAN(akAnotherActor, akOther, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(akOther)
		return
	endif
	
	ChooseAnswerYes(akOther)
	Anim_SexlabWith3AAN(akAnotherActor, akOther, type, false) ; not punishment
EndFunction

Function StartSexWith4AAAN(DOM_Actor akAnotherActor1, DOM_Actor akAnotherActor2, Actor akOther, string type, bool aggro)
	;*ogTrace("StartSexWith4AAAN target="+akOther+" actor="+akAnotherActor1+" "+akAnotherActor2)
	if akAnotherActor1 == None || akAnotherActor2 == None || akOther == None
		return
	endif
	if aggro
		ChooseAnswerWhat(akOther)
		Anim_SexlabWith4AAAN(akAnotherActor1, akAnotherActor2, akOther, type, true) ; punishment
		return
	endif
	
	if !mind.WillObeyDisgraced(21) ; "no_sex"
		ChooseAnswerNo(akOther)
		return
	endif
	
	ChooseAnswerYes(akOther)
	Anim_SexlabWith4AAAN(akAnotherActor1, akAnotherActor2, akOther, type, false) ; not punishment
EndFunction

; #####################
; ### Behaviour actions

Function CorrectStruggle()
	;*ogTrace("CorrectStruggle START")
	if is_struggling && is_restrained
		mind.SetNextPunishmentReasonSilent(7) ; "struggling"
		if RandomFloat() < mind.MOD_Discipline*0.5
			mind.TrainForBondage(0.5)
			mind.TrainPose(0.5)
		endif
		is_struggling = false
		Anim_PoseByString(quietPose)
		return
	endif
	;*ogTrace("CorrectStruggle END")
EndFunction

bool correct_behaviour_busy = false
Function CorrectBehaviour(Actor akAbuser, int reason, bool do_follow)
	;*ogTrace("CorrectBehaviour START busy="+correct_behaviour_busy)
	if correct_behaviour_busy
		return
	endif
	correct_behaviour_busy = true
	;*ogTrace("CorrectBehaviour() reason="+reason+" "+DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex)+" follow?="+do_follow+" is_restrained="+is_restrained+" faction="+akRef.IsInFaction(DOM01.DOMActionFleeing)+" rank="+akRef.GetFactionRank(DOM01.DOMActionFleeing))
	if do_follow
		if reason == 25 || is_running_away
			;*ogTrace("CorrectBehaviour() force follow")
			if (behaviour == "wait" || behaviour == "wait_sandbox" || behaviour == "running_away") 
				;*ogTrace("CorrectBehaviour() will follow player or trainer")
				EnterFollowPlayerOrTrainer()
			endif
			ChooseCommentSorry(akAbuser)
			if reason == 25
				correct_behaviour_busy = false
				return
			endif
		endif
	endif
	;*ogTrace("CorrectBehaviour() other reasons")
	if reason <= 0
		correct_behaviour_busy = false
		return
	endif
	
	if reason == 2 ; covering self
		;*ogTrace("CorrectBehaviour() covering self")
		if !equip_inventory_busy && !is_naked && mind.should_be_naked
			if RandomFloat()*50.0 < mind.humiliation
				mind.SetObedientTimer(10)
				was_inventory_changed = true
				LogEquip("CorrectBehaviour: SendOrderEquipInventory")
				SendOrderEquipInventory(true) ; do anim
				ChooseCommentSorry(akAbuser)
				SendNotificationAbuse(getName()+" hastily removes "+actorPossessive+" clothes")
			else ; Add reason again
				ChooseCommentBad(akAbuser)
				if mind.whipping_reason == 2 || mind.current_punishment_reason == 2 ; being punished for this reason so adding will not work
					mind.correct_cover_self = false
				else
					mind.SetNextPunishmentReasonSilent(2) ; "covering self"
				endif
			endif
		endif
	elseif reason == 10 ; "being a bad maid"
		;*ogTrace("CorrectBehaviour() being a bad maid")
		if RandomFloat()*50.0 < mind.submission
			ChooseCommentSorry(akAbuser)
			mind.SetObedientTimer(10)
			if (behaviour == "wait" || behaviour == "wait_sandbox" || behaviour == "running_away") 
				EnterSweep()
			endif
		else ; Add reason again
			ChooseCommentBad(akAbuser)
			mind.SetNextPunishmentReasonSilent(10) ; "being a bad maid"
		endif
	elseif reason == 11 ; being jealous
		;*ogTrace("CorrectBehaviour() being jealous")
		if RandomFloat() < mind.MOD_Authority
			if !mind.IsAngry()
				ChooseCommentSorry(akAbuser)
			elseif mind.RecoverFrom()
				ChooseCommentSorry(akAbuser)
			endif
		endif
	elseif reason == 12 ; being angry
		;*ogTrace("CorrectBehaviour() being angry")
		if RandomFloat() < mind.MOD_Authority
			if !mind.IsAngry()
				ChooseCommentSorry(akAbuser)
			elseif mind.RecoverFrom()
				ChooseCommentSorry(akAbuser)
			endif
		else
			ChooseCommentBad(akAbuser)
		endif
	elseif reason == 14 ; "didnt_fight"
		;*ogTrace("CorrectBehaviour() didnt_fight")
		mind.was_fighting_for_player = true
	elseif reason == 15 ; "didnt pose"
		;*ogTrace("CorrectBehaviour() didnt pose")
		akRef.RemoveFromFaction(DOM01.DOMFailedToPose)
		if (behaviour == "wait" || behaviour == "wait_sandbox" || behaviour == "running_away") 
			if RandomFloat()*50.0 < mind.resignation
				ChooseCommentSorry(akAbuser)
				mind.SetObedientTimer(10)
				ResumePose()
			endif
		endif
	elseif reason == 19 || reason == 20 ; "didnt masturbate" || "refusing to masturbate"
		;*ogTrace("CorrectBehaviour() didnt masturbate")
		if (behaviour == "wait" || behaviour == "wait_sandbox" || behaviour == "running_away") 
			if RandomFloat()*50.0 < mind.submission
				ChooseCommentSorry(akAbuser)
				mind.SetObedientTimer(10)
				ResumeMasturbate()
			endif
		endif
	elseif reason == 22 ; "refusing to strip"
		;*ogTrace("CorrectBehaviour() refusing to strip")
		if RandomFloat()*50.0 < mind.humiliation
			ChooseCommentSorry(akAbuser)
			mind.SetObedientTimer(10)
			if !is_bounded ; !akRef.IsInFaction(DOM01.DOMActionTied)
				Interact_Strip(akAbuser)
			endif
		else ; Add reason again
			ChooseCommentBad(akAbuser)
			mind.SetNextPunishmentReasonSilent(22) ; "refusing to strip"
		endif
	elseif reason == 30 ; "being a bad worker"
		;*ogTrace("CorrectBehaviour() being a bad worker")
		if RandomFloat()*50.0 < mind.resignation
			ChooseCommentSorry(akAbuser)
			mind.SetObedientTimer(10)
			if (behaviour == "wait" || behaviour == "wait_sandbox" || behaviour == "running_away") 
				if !akRef.IsInFaction(DOM01.DOMActionWorking)
					EnterWork(akRef.GetFactionRank(DOM01.DOMWorkMode))
				endif
			endif
		else ; Add reason again
			ChooseCommentBad(akAbuser)
			mind.SetNextPunishmentReasonSilent(30) ; "being a bad worker"
		endif
	elseif reason == 32 ; "not walking on four"
		LogTrace("CorrectBehaviour() not walking on four")
		if RandomFloat()*50.0 < mind.humiliation
			ChooseCommentSorry(akAbuser)
			mind.SetObedientTimer(10)
			if mind.should_walk_on_four
				mind.is_walking_on_four = true
			endif
		else ; Add reason again
			ChooseCommentBad(akAbuser)
			mind.SetNextPunishmentReasonSilent(30) ; "being a bad worker"
		endif
	endif
	if reason == 16 && behaviour == "wait_sandbox" ; "didnt wait"
		;*ogTrace("CorrectBehaviour() didnt wait")
		ChooseCommentSorry(akAbuser)
		mind.SetObedientTimer(10)
		if (behaviour == "wait_sandbox" || behaviour == "running_away") 
			behaviour = "wait"
		endif
	endif
	;*ogTrace("CorrectBehaviour() END")
	correct_behaviour_busy = false
EndFunction

; ####################
; ### Behaviour status

bool Function IsRestrainedCantKneel()
	if behaviour == "tied" ; restrained but just tied up, can kneel
		return false
	elseif __is_restrained ; chained or in furniture
		SendNotificationAbuse(name+" "+actorBeVerb+" being restrained, release "+actorObjective+" first")
		return true
	endif
	return false
EndFunction

bool Function IsTied()
	if behaviour == "tied"
		return true
	endif
	return false
EndFunction

bool Function IsTiedCanKneel()
	if behaviour != "tied"
		return false
	endif
	return DOM01.DOM_Anim.IsTiedUpPoseCanKneel(quietPose)
EndFunction

bool is_attentive = false
bool Function IsAttentive()
	return is_attentive
EndFunction

bool is_struggling = false
bool Function IsStruggling()
	return is_struggling
EndFunction

bool Function IsBreakingWait()
	;if !canMove ; Can not move but might still want to get out
	;	LogTrace("IsBreakingWait() can not move")
	;	return false
	;endif
	bool is_breaking = mind.MakeStopWait()
	if is_breaking
		if actor_trainer != None
			if IsTogetherWithFast(actor_trainer.akRef, akRef, 2000.0)
				SendNotification(name+" was caught wandering around by "+actor_trainer.GetTitle()+actor_trainer.GetName())
				mind.SetNextPunishmentReasonOnceMessage(16,"tried to stop waiting") ; "didnt_wait"
				TryCallForHelp()	
				DOM_Mind akAggressorMind = DOM01.GetMindFromActor(actor_trainer)				
				akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
				akAggressorMind.CheckAndRegisterKink(108,1.0) ; "yelling at slaves"
				return false
			endif
		endif
		;LogTrace("IsBreakingWait() = "+is_breaking)
	endif
	return is_breaking
EndFunction

bool Function IsBreakingWork()
	;if !canMove ; Can not move but might still want to get out
	;	LogTrace("IsBreakingWait() can not move")
	;	return false
	;endif
	bool is_breaking = mind.MakeStopWork()
	if is_breaking
		if actor_trainer != None
			if IsTogetherWithFast(actor_trainer.akRef, akRef, 2000.0)
				SendNotification(name+" was caught taking a break by "+actor_trainer.GetTitle()+actor_trainer.GetName())
				mind.SetNextPunishmentReasonOnceMessage(30,"tried to stop working") ; "being a bad worker"
				TryCallForHelp()			
				DOM_Mind akAggressorMind = DOM01.GetMindFromActor(actor_trainer)				
				akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
				akAggressorMind.CheckAndRegisterKink(108,1.0) ; "yelling at slaves"
				return false
			endif
		endif
		;LogTrace("IsBreakingWork() = "+is_breaking)
	endif
	return is_breaking
EndFunction

bool Function IsBreakingTieup()
	bool is_breaking = mind.MakeBreakTieup()
	if is_breaking
		if actor_trainer != None
			if IsTogetherWithFast(actor_trainer.akRef, akRef, 2000.0)
				SendNotification(name+" was caught struggling by "+actor_trainer.GetTitle()+actor_trainer.GetName())
				mind.SetNextPunishmentReasonOnceMessage(7,"tried to struggle") ; "struggling"
				DOM_Mind akAggressorMind = DOM01.GetMindFromActor(actor_trainer)				
				akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
				akAggressorMind.CheckAndRegisterKink(108,1.0) ; "yelling at slaves"
			endif
		endif
		;LogTrace("IsBreakingTieup() = "+is_breaking)
	endif
	return is_breaking
EndFunction

bool Function IsBreakingPose()
	if !canMove
		;*ogTrace("IsBreakingPose() can not move")
		return false
	endif
	bool is_breaking = mind.MakeStopPose()
	if is_breaking
		;LogTrace("IsBreakingPose() = "+is_breaking)
	endif
	return is_breaking
EndFunction

bool Function IsBreakingMasturbate()
	if !canMove
		;*ogTrace("IsBreakingMasturbate() can not move")
		return false
	endif
	bool is_breaking =  mind.MakeStopMasturbate()
	if is_breaking
		;LogTrace("IsBreakingMasturbate() = "+is_breaking)
	endif
	return is_breaking
EndFunction

bool Function IsBreakingRestraint(Form cuffs)
	if !canAnimate
		;LogTrace("IsBreakingRestraint() can not animate")
		return false
	endif
	if mind.BreakRestraintMoodBase() == 0.0
		;LogTrace("IsBreakingRestraint() not in the mood")
		return false
	endif
	float restraintModifier
	if behaviour != "tied" && is_restrained ; behaviour == "chained" || behaviour == "restrained"  || behaviour == "restrained_in_furniture"
		restraintModifier = 3.0
	elseif cuffs == None
		restraintModifier = 0.1
	else
		restraintModifier = DOM01.DOMEquip.GetMaterialModifier(cuffs)
	endif
	bool is_breaking = mind.MakeBreakRestraint(restraintModifier)
	if is_breaking
		;LogTrace("IsBreakingRestraint() mod = "+restraintModifier+" result = "+is_breaking)
	endif
	return is_breaking
EndFunction

; #################
; ### Special poses

Function DoStandUp()
	int sitState = akRef.GetSitState()
	if sitState>0
		Wait(2.0)
		return
	endif
	int sleepState = akRef.GetSleepState()
	if sleepState>0
		Wait(2.0)
		return
	endif
	if akRef.IsOnMount()
		akRef.Dismount()
		Wait(2.0)
	endif
EndFunction

Function DoStandUpAndCalm()
	;LogTrace("DoStandUpAndCalm")
	DoStandUp()
	CalmActorFast(akRef)
EndFunction

Function DoEntertain(Actor akAbuser, string order)
	if order == "kneel"
		DoSalute(akAbuser,DOM01.kneelPose) 
	elseif order == "attention"
		DoSalute(akAbuser,DOM01.attentionPose)
	elseif order == "salute"
		DoSalute(akAbuser,DOM01.salutePose)
	elseif order == "display"
		DoDisplay(akAbuser)
	elseif order == "shower"
		DoShower(akAbuser)
	elseif order == "ass"
		DoAssPresentation(akAbuser)
	elseif order == "breasts"
		DoBreastsPresentation(akAbuser)
	elseif order == "pussy"
		DoPussyPresentation(akAbuser)
	elseif order == "submissive"
		DoSubmissive(akAbuser)
	elseif order == "cute"
		DoCute(akAbuser)
	elseif order == "dance"
		DoDance(akAbuser)
	elseif order == "music"
		DoMusic(akAbuser)
	elseif order == "drinks"
		DoDrinks(akAbuser)
	elseif order == "flowers"
		DoFlowers(akAbuser)
	elseif order == "light"
		DoLight(akAbuser)
	elseif order == "chair"
		DoChair(akAbuser)
	elseif order == "favor"
		DoFavor(akAbuser)
	elseif order == "cleaning"
		EnterSweep()
	Else
		LogTrace("UNKNOWN Entertain order="+order)
	endif
EndFunction

Function DoSalute(Actor akAbuser, string the_pose)
	int id
	if the_pose == DOM01.kneelPose 
		id = 1
	elseif the_pose == DOM01.attentionPose 
		id = 2
	elseif the_pose == DOM01.salutePose 
		id = 3
	else
		id = 4
	endif
	akRef.SetFactionRank(DOM01.DOMActionKneeling,id)
	Interact_StartSalute(akAbuser,the_pose)
	if DOM01.kneelPoseOn
		akRef.RemoveFromFaction(DOM01.DOMActionKneeling)
		return
	endif
	Wait(10.0*DOM01.anim_speed_sec)
	Interact_EndSalute(the_pose)
	akRef.RemoveFromFaction(DOM01.DOMActionKneeling)
EndFunction

Function DoFavor(Actor akAbuser)
	if is_restrained
		return
	endif

	if !mind.is_slave
		ChooseAnswerYes(akAbuser)		
	elseif !mind.WillObeyAbused(18)
		ChooseAnswerWhat(akAbuser)
	else
		ChooseAnswerYes(akAbuser)
	endif
	
	behaviour = "wait"
	akRef.SetDoingFavor()
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoDance(Actor akAbuser)
	if !mind.WillObeyObjectified(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	string the_dance = DOM01.DOM_Anim.GetDancePose(self)	
	SetPose(the_dance,100)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoMusic(Actor akAbuser)
	if !mind.WillObeyEnslaved(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	string the_play = DOM01.DOM_Anim.GetMusicPose(self)
	SetPose(the_play,101)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoDrinks(Actor akAbuser)
	if !mind.WillObeyEnslaved(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	string the_play = DOM01.DOM_Anim.GetDrinksPose(self)
	
	SetPose(the_play,20)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoExercise(Actor akAbuser)
	if !mind.WillObeyEnslaved(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	string the_play = DOM01.DOM_Anim.GetExercisePose(self)
	
	SetPose(the_play,103)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoDisplay(Actor akAbuser)
	if !mind.WillObeyEnslaved(15)
		ChooseAnswerNo(akAbuser)
		if akAbuser == PlayerRef ; player
			DOM01.DOM04.NotifyEndPricing(self,0,false)
			SendExternalEventSFB("PriceInspection",0.0,false)
		endif
		return
	endif
	ChooseAnswerValue(akAbuser)

	string the_pose = DOM01.DOM_Anim.GetDisplayPose(self)
	SetPose(the_pose,102)
	behaviour = "pose" 	

	mind.StartPricing(akAbuser)
EndFunction

Function DoCute(Actor akAbuser)
	if !mind.WillObeydominated(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	mind.IncreaseArousal(10.0,mind.MOD_Flexibility)
	string the_pose = DOM01.DOM_Anim.GetCutePose(self)
	SetPose(the_pose,102)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

int test_index = 1
Function DoTest(Actor akAbuser)
	string the_pose = DOM_Util.GetTestPose(test_index)
	SendNotificationAbuse(name+" executes pose "+test_index+" "+the_pose)	
	test_index += 1
	if test_index >= 490
		test_index = 1
	endif
	if the_pose == ""
		test_index = 0
	endif
	SetPose(the_pose,105)
	behaviour = "pose" 	
	Anim_PoseByString(the_pose) ; Pose 105 is no refresh so we need to start it here
	Wait(5.0)
	if test_index < 5
		;LogTrace("DoTest pa_DOMOverwhelm player="+akAbuser)
		akRef.playIdleWithTarget(DOM01.DOMKeys.pa_DOMOverwhelm,akAbuser)
	elseif test_index < 10
		;LogTrace("DoTest pa_DOMSleeper player="+akAbuser)
		akRef.playIdleWithTarget(DOM01.DOMKeys.pa_DOMSleeper,akAbuser)
	elseif test_index < 15
		;LogTrace("DoTest pa_DOMNeckBreak player="+akAbuser)
		akRef.playIdleWithTarget(DOM01.DOMKeys.pa_DOMNeckBreak,akAbuser)
	endif
		;akRef.playIdleWithTarget(DOM01.pa_HugA,akAbuser)
EndFunction

Function DoSubmissive(Actor akAbuser)
	if !mind.WillObeydominated(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	mind.IncreaseArousal(20.0,mind.MOD_Flexibility)
	string the_pose = DOM01.DOM_Anim.GetSubmissivePose(self)
	SetPose(the_pose,113)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoAssPresentation(Actor akAbuser)
	if !mind.WillObeydominated(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	mind.IncreaseArousal(20.0,mind.MOD_Flexibility)
	string the_pose = DOM01.DOM_Anim.GetAssPresentationPose(self)
	SetPose(the_pose,111)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoBreastsPresentation(Actor akAbuser)
	if !mind.WillObeydominated(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	mind.IncreaseArousal(20.0,mind.MOD_Flexibility)
	string the_pose = DOM01.DOM_Anim.GetBreastPresentationPose(self)
	SetPose(the_pose,110)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoPussyPresentation(Actor akAbuser)
	if !mind.WillObeydominated(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	mind.IncreaseArousal(20.0,mind.MOD_Flexibility)
	string the_pose = DOM01.DOM_Anim.GetPussyPresentationPose(self)
	SetPose(the_pose,112)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoLight(Actor akAbuser)
	if !mind.WillObeyEnslaved(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	SetPose("",99)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

Function DoFlowers(Actor akAbuser)
	if !mind.WillObeyEnslaved(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	string the_play = DOM01.DOM_Anim.GetFlowersPose(self)
	; "OffsetCarryBasketStart" ; carry the basket
	; "OffsetCarryFlowerBasketPickStart" ; pickup flowers and put in basket
	
	SetPose(the_play,21)
	behaviour = "pose" 	
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

ObjectReference Property PoseMarker Auto Hidden
ObjectReference Property PoseMarkerSave Auto Hidden

Function SitOnSlave(Actor akAbuser)
	if PoseMarker == None
		float zr = akRef.GetAngleZ()
		if quietPose ==  "DOMIdleSeat1"
			PoseMarker = akRef.PlaceAtMe(DOM01.DOMFurniStraddle, 1)
			PoseMarker.MoveTo(akRef, -math.sin(zr)*5.0, -math.cos(zr)*5.0, 3.0, true)
		else
			PoseMarker = akRef.PlaceAtMe(DOM01.DOMFurniChair, 1)
			PoseMarker.MoveTo(akRef, 0.0, 0.0, 0.0, true)
			PoseMarker.SetAngle(PoseMarker.GetAngleX(), PoseMarker.GetAngleY(), PoseMarker.GetAngleZ() + 90.0)
		endif
		PoseMarker.Enable()
		akRef.SetVehicle(PoseMarker)
	endif
	
	;*ogTrace("SitOnSlave(): Trying to sit on slave "+name+" PoseMarker="+PoseMarker)
	PoseMarker.Activate(akAbuser)
	mind.number_of_shame += 1
	mind.TrainHumiliation(5.0)
	mind.CheckAndRegisterKink(66,2.0) ; "being used as a furniture"
EndFunction

Function DoChair(Actor akAbuser)
	if !mind.WillObeyObjectified(15)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)

	string the_pose = DOM01.DOM_Anim.GetChairPose(self)
	SetPose(the_pose,30)
	behaviour = "pose" 	
	
	if PoseMarker != None
		PoseMarker.Delete()
		PoseMarker = None
	endif

	float zr = akRef.GetAngleZ()
	if quietPose ==  "DOMIdleSeat1"
		PoseMarker = akRef.PlaceAtMe(DOM01.DOMFurniStraddle, 1)
		PoseMarker.MoveTo(akRef, -math.sin(zr)*5.0, -math.cos(zr)*5.0, 3.0, true)
	else
		PoseMarker = akRef.PlaceAtMe(DOM01.DOMFurniChair, 1)
		PoseMarker.MoveTo(akRef, 0.0, 0.0, 0.0, true)
		PoseMarker.SetAngle(PoseMarker.GetAngleX(), PoseMarker.GetAngleY(), PoseMarker.GetAngleZ() + 90.0)
	endif
	PoseMarker.Enable()
	akRef.SetVehicle(PoseMarker)
	if akAbuser != None
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
EndFunction

; ##########################
; ### Masturbate and orgasms

Function ChooseOrgasmIdle()
	if poseId < 1000
		; Not a masturbate pose
		return
	endif
			
	strugglePose = ""
	if poseId < 2000
		ChooseOrgasmIdleStanding()
	elseif poseId < 3000
		ChooseOrgasmIdleLaying()
	else
		ChooseOrgasmIdleKneeling()
	endif
EndFunction

Function ChooseOrgasmIdleStanding()
	quietPose = DOM01.DOM_Anim.GetMasturbateStandingPoseClimax(self)
	poseId = 1020

	;*ogTrace("ChooseOrgasmIdle() for "+ mind.GetMoodNameThirdPerson()+name+" id="+poseId+" pose="+quietPose)
	Anim_PoseByString(quietPose) 
EndFunction

Function ChooseOrgasmIdleLaying()
	quietPose = DOM01.DOM_Anim.GetMasturbateLayingPoseClimax(self)
	poseId = 2020
	
	;*ogTrace("ChooseOrgasmIdle() for "+ mind.GetMoodNameThirdPerson()+name+" id="+poseId+" pose="+quietPose)
	Anim_PoseByString(quietPose) 
EndFunction

Function ChooseOrgasmIdleKneeling()
	quietPose = DOM01.DOM_Anim.GetMasturbateKneelingPoseClimax(self)
	poseId = 3020
	
	;*ogTrace("ChooseOrgasmIdle() for "+ mind.GetMoodNameThirdPerson()+name+" id="+poseId+" pose="+quietPose)
	Anim_PoseByString(quietPose) 
EndFunction

Function ChooseMasturbateIdle(float amount)
	if poseId < 1000
		; Not a masturbate pose
		return
	endif
			
	if poseId < 2000
		ChooseMasturbateIdleStanding(amount)
	elseif poseId < 3000
		ChooseMasturbateIdleLaying(amount)
	else
		ChooseMasturbateIdleKneeling(amount)
	endif
EndFunction

int Function GetNextMasturbatePoseId(float amount, int baseid, int nposes)
	int iclimax = nposes - (1)
	if iclimax >= 20
		iclimax = 19
	elseif iclimax < 1
		iclimax = 1
	endif
	if mind.is_enraptured_for > 0 || ((amount>100.0 || baseid>=10) && mind.IsAroused())
		return iclimax
	endif
	if baseid >= iclimax
		return 0
	endif
	float xcur = (amount/200.0)
	float xidx = xcur * (iclimax as float) + 0.5 
	int   icur = xidx as int
	if baseid <= icur
		return icur
	endif
	return 0
EndFunction

Function ChooseMasturbateIdleStanding(float amount)
	strugglePose = ""
	float x = mind.GetHumiliatedEffect()+amount
 	int rootid = 1000
 
	if  mind.is_enraptured_for > 0 && poseId>=rootid+20
		ChooseOrgasmIdleStanding()
		return
	endif
	
	int nposes = DOM01.DOM_Anim.NumberOfMasturbateStandingPoses(self)
	int baseid = GetNextMasturbatePoseId(x,(poseId-rootid),nposes)
	poseId = rootid + baseid
	quietPose = DOM01.DOM_Anim.GetMasturbateStandingPose(self,baseid)
	;LogTrace("ChooseMasturbateIdleStanding: poseId="+poseId+" amount="+x+" baseid="+baseid+" / "+nposes+" pose="+quietPose)
	Anim_PoseByString(quietPose) 
	
	if baseid >= 1
		float strength = (baseid as float) * 100.0 / (nposes as float)
		SexlabPlayMoan(strength as int)
	endif
		
	Anim_PoseByString(quietPose) 
EndFunction

Function ChooseMasturbateIdleLaying(float amount)
	strugglePose = ""
	float x = mind.GetSubmittedEffect()+amount
	int rootid = 2000

	if  mind.is_enraptured_for > 0 && poseId>=rootid+20
		ChooseOrgasmIdleLaying()
		return
	endif

	int nposes = DOM01.DOM_Anim.NumberOfMasturbateLayingPoses(self)
	int baseid = GetNextMasturbatePoseId(x,(poseId-rootid),nposes)
	poseId = rootid + baseid
	quietPose = DOM01.DOM_Anim.GetMasturbateLayingPose(self,baseid)
	;LogTrace("ChooseMasturbateIdleLaying: poseId="+poseId+" amount="+x+" baseid="+baseid+" / "+nposes+" pose="+quietPose)
	Anim_PoseByString(quietPose) 
	
	if baseid >= 1
		float strength = (baseid as float) * 100.0 / (nposes as float)
		SexlabPlayMoan(strength as int)
	endif
		
	Anim_PoseByString(quietPose) 
EndFunction

Function ChooseMasturbateIdleKneeling(float amount)
	strugglePose = ""
	float x = mind.GetSubmittedEffect()+amount
	int rootid = 3000

	if  mind.is_enraptured_for > 0 && poseId>=rootid+20
		ChooseOrgasmIdleLaying()
		return
	endif

	int nposes = DOM01.DOM_Anim.NumberOfMasturbateKneelingPoses(self)
	int baseid = GetNextMasturbatePoseId(x,(poseId-rootid),nposes)
	poseId = rootid + baseid
	quietPose = DOM01.DOM_Anim.GetMasturbateKneelingPose(self,baseid)
	;LogTrace("ChooseMasturbateIdleKneeling: poseId="+poseId+" amount="+x+" baseid="+baseid+" / "+nposes+" pose="+quietPose)
	Anim_PoseByString(quietPose) 
	
	if baseid >= 1
		float strength = (baseid as float) * 100.0 / (nposes as float)
		SexlabPlayMoan(strength as int)
	endif
		
	Anim_PoseByString(quietPose) 
EndFunction

Function MasturbateHarder(Actor akAbuser)
	bool broken = false
	if mind.IsBrokenToObey() || mind.IsDevoted()
		broken = true
	elseif RandomFloat() < mind.MOD_SumAll || RandomFloat() < mind.MOD_Naivety
		if __is_in_city 
			mind.MakeAshamedFor(1.0)
			if RandomFloat() < mind.MOD_Naivety
				SendNotificationOrder(name+" refuses to do that in a public place")	
			else
				broken = true
			endif
		else
			broken = true		
		endif
	endif
	
	if !broken
		ChooseAnswerNo(akAbuser)
		mind.MakeAngryFor(20.0)
		mind.SetNextPunishmentReasonForceMessage(19,"does not want to masturbate for you") ; "didnt masturbate"
		EnterWait()
		return
	endif
	
	if behaviour != "masturbate"
		behaviour = "masturbate"
	endif
	ChooseAnswerYes(akAbuser)
	ChooseMasturbateIdle(50.0)
	float mod = DOM01.GetDepraverModifier(akAbuser)
	mind.CheckAndRegisterKink(71,2.0) ; "being forced to masturbate"

	mind.IncreaseArousal(5.0,mind.MOD_Vaginal)
	mind.TrainVaginal(DOM01.train_speed_sex*0.05*mod)
	mind.MakeAshamedFor(DOM01.train_speed_tell*0.025*mod)
	SendNotificationOrder(name+"'s hand starts moving softly")
	if mind.IsArousedAfterSex(mind.FACET_Sensuality/100.0)
		ChooseAnswerAroused(akAbuser)
		if mind.IsOrgasmingAfterArousal(mind.MOD_Daring*0.25)
			ChooseOrgasmIdle()
			ChooseAnswerOrgasm(akAbuser)
			SendExternalEventSS("Orgasm","masturbate")
			DOM01.DOM04.NotifyOrgasm(self,"masturbate harder",mind.should_be_noorgasm,mind.was_allowed_toorgasm,false)
		endif
	endif
	DOM01.TrainSkillDepraver(akAbuser,0.5)
EndFunction

Function DoMasturbate(Actor akAbuser, string order)
	if order == "stand"
		EnterMasturbateStanding(akAbuser)
	elseif order == "kneel"
		EnterMasturbateKneeling(akAbuser)
	elseif order == "lay"
		EnterMasturbateLaying(akAbuser)
	elseif order == "harder"
		MasturbateHarder(akAbuser)
	else ; "random"
		int x = RandomInt(1,3)
		if x == 1
			EnterMasturbateLaying(akAbuser)
		elseif x == 2
			EnterMasturbateKneeling(akAbuser)
		else
			EnterMasturbateStanding(akAbuser)
		endif
	endif
EndFunction

Function EnterMasturbateKneeling(Actor akAbuser)
	if is_behaviour_masturbate && poseId >= 3000
		MasturbateHarder(akAbuser)
		return
	endif
	StartMasturbate(akAbuser,3000)
	float mod = DOM01.GetDepraverModifier(akAbuser)
	float amount = DOM01.train_speed_sex*0.0125*mod
	mind.TrainOral(amount)
	mind.TrainVaginal(amount)
	mind.CheckAndRegisterKink(71,2.0) ; "being forced to masturbate"
	DOM01.TrainSkillDepraver(akAbuser,0.5)
EndFunction

Function EnterMasturbateLaying(Actor akAbuser)
	if is_behaviour_masturbate && poseId >= 2000 && poseId < 3000
		MasturbateHarder(akAbuser)
		return
	endif
	StartMasturbate(akAbuser,2000)
	float mod = DOM01.GetDepraverModifier(akAbuser)
	float amount = DOM01.train_speed_sex*0.0125*mod
	mind.TrainAnal(amount)
	mind.TrainOral(amount)
	mind.CheckAndRegisterKink(71,2.0) ; "being forced to masturbate"
	DOM01.TrainSkillDepraver(akAbuser,0.5)
EndFunction

Function EnterMasturbateStanding(Actor akAbuser)
	if is_behaviour_masturbate && poseId >= 2000 && poseId < 3000
		MasturbateHarder(akAbuser)
		return
	endif
	StartMasturbate(akAbuser,1000)
	float mod = DOM01.GetDepraverModifier(akAbuser)
	float amount = DOM01.train_speed_sex*0.0125*mod
	mind.TrainAnal(amount)
	mind.TrainVaginal(amount)
	mind.CheckAndRegisterKink(71,2.0) ; "being forced to masturbate"
	DOM01.TrainSkillDepraver(akAbuser,0.5)
EndFunction

; ##############################
; ### Behaviour resume and reset

Function ResumeBehaviour()
	if is_behaviour_pose
		SetPoseStatus()		
	elseif behaviour == "restrained_in_furniture"
		SetFurnitureStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	elseif is_restrained
		SetPoseStatus()		
		CalmActorFast(akRef)
		Anim_Pose()
	elseif is_behaviour_masturbate
		ChooseMasturbateIdle(0)
	endif
EndFunction

Function ResumePose()
	SetPose(prevquietPose,prevPoseId)
	nextStrugglePose = prevStrugglePose
	nextEnterPose = prevEnterPose
	nextExitPose = prevExitPose
	behaviour = "pose" 	
EndFunction

Function ResumeMasturbate()
	if prevPoseId < 1000
		StartMasturbate(GetCurrentTrainer(),1000)
	else
		StartMasturbate(GetCurrentTrainer(),prevPoseId)
	endif
EndFunction

Function StartMasturbate(Actor akAbuser, int pId)
	;if is_restrained
	;	return
	;endif
	if behaviour == "on_duty"
		return
	endif

	nextPoseId = pId
	nextquietPose = ""
	nextStrugglePose = ""
	string cur_beh = behaviour

	if cur_beh != "masturbate"
		SendNotificationAbuse("Forcing "+ mind.GetMoodNameThirdPerson()+name+" to touch "+actorObjective+"self")
	endif

	float x = mind.GetDegradedEffect()
	if !mind.IsObedient()
		if __is_in_city 
			if RandomFloat()*200.0 > x
				mind.MakeAshamedFor(1.0)
				if RandomFloat() < mind.MOD_Naivety
					SendNotificationOrder(name+" refuses to do that in a public place")	
				endif
			endif
		elseif RandomFloat()*100.0 > x
			ChooseAnswerNo(akAbuser)
			mind.SetNextPunishmentReasonForceMessage(20,"refuses to touch "+actorObjective+"self") ; "refusing to masturbate"
			return
		endif
	endif
	ChooseAnswerYes(akAbuser)
	
	behaviour = "masturbate" 	
	float mod = DOM01.GetDepraverModifier(akAbuser)
	mind.TrainVaginal(DOM01.train_speed_sex*0.05*mod)
	mind.MakeAshamedFor(DOM01.train_speed_tell*0.025*mod)
	if akAbuser == PlayerRef
		DOM01.DOMPlayerAlias.HasChatWith(self)
	else
		DOM01.TrainSkillDepraver(akAbuser,0.5)
	endif
EndFunction


; #############################
; ### Interactions consequences

Function IncrementFling(DOM_Actor akOther)
	if isFriend(akOther)	
		if mind.MOD_Dependence >= 1.0
			; Only jealous slaves count about their friends/family
			mind.number_of_player_fling += 1					
		endif
		return
	endif
	
	DOM_Actor rival = GetMyRival()
	if rival == akOther
		akOther.SetMeRival(self)					
	else
		SetMyRival(akOther)
		akOther.SetMeRival(self)
	endif
	TryAttackRival()
	mind.number_of_player_fling += 1
EndFunction

Function IncrementChat(DOM_Actor akOther)
	if !isFriend(akOther)
		mind.number_of_player_chat += 1
		return
	endif
	if mind.MOD_Dependence >= 2.0
		; Only super jealous slaves count about their friends/family
		mind.number_of_player_chat += 1					
	endif
EndFunction

; #######################
; ### Strip and equipment

Outfit old_outfit = None
Function SetOldOutfit(Outfit myoutfit)
	;LogTrace("SetOldOutfit myoutfit="+myoutfit)
	if myoutfit == None
		return
	endif
	if myoutfit == DOM01.DOMEquip.DOMNothingOutfit
		return
	endif
	old_outfit = myoutfit

	bool clear_outfit = DOM01.DOMEquip.OutfitIsToBeCleared(akRef)
	;LogTrace("SetOldOutfit Will clear outfit "+clear_outfit+" old_outfit="+old_outfit)
	if clear_outfit ; check that outfit is indeed cleared
		ActorBase abRef = akRef.GetLeveledActorBase()
		Outfit the_outfit = abRef.GetOutfit()
		if the_outfit != None && the_outfit != DOM01.DOMEquip.DOMNothingOutfit ; if not: clear
			;LogTrace("SetOldOutfit Clearing outfit="+the_outfit)
			akRef.SetOutfit(DOM01.DOMEquip.DOMNothingOutfit)
			akRef.SetFactionRank(DOM01.DOMEquip.DOMNoOutfitFaction,2)
		endif
	endif
EndFunction

bool restore_outfit_on_release = true
Function SetRestoreOutfitOnRelease(bool value)
	restore_outfit_on_release = value
EndFunction

Function CheckAndSetOutfit()
	LogTrace("CheckAndSetOutfit in no outfit faction="+akRef.IsInFaction(DOM01.DOMEquip.DOMNoOutfitFaction))
	if akRef.IsInFaction(DOM01.DOMEquip.DOMNoOutfitFaction)
		return None
	endif
	LogTrace("CheckAndSetOutfit TransferOutfitIfSettings")
	SetOldOutfit(DOM01.DOMEquip.TransferOutfitIfSettings(akRef,false)) ; Only Transfer outfit according to toggles
EndFunction

Function HoldWeapons(Actor akAbuser)
	;*ogTrace("HoldWeapons weapons should="+mind.should_hold_weapons+" has="+has_weapon+" armor should="+mind.should_wear_armor+" has="+has_armor)
	bool had_weapon = (has_weapon > 0.0)
	mind.should_hold_weapons = true
	ChooseAnswerThanks(akAbuser)
	EquipInventoryNow(false) ; no anim
	;LogTrace("HoldWeapons ApplyEquipmentEffects")
	ApplyEquipmentEffects()
	if !had_weapon && (has_weapon > 0.0)
		SendNotificationOrder(name+" hastily equips "+actorPossessive+" weapons")
	elseif has_weapon <= 0.0
		SendNotificationOrder(name+" agrees but doesn't have any suitable weapon")
	else
		SendNotificationOrder(name+" agrees and will now hold weapons")
	endif
EndFunction

Function HoldNoWeapons()
	;*ogTrace("HoldNoWeapons weapons should="+mind.should_hold_weapons+" has="+has_weapon+" armor should="+mind.should_wear_armor+" has="+has_armor)
	mind.should_hold_weapons = false
	LogEquip("HoldNoWeapons: SendOrderEquipInventory")
	SendOrderEquipInventory(false) ; no anim
EndFunction

Function WearArmor(Actor akAbuser)
	;*ogTrace("WearArmor weapons should="+mind.should_hold_weapons+" has="+has_weapon+" armor should="+mind.should_wear_armor+" has="+has_armor)
	bool had_body_armor = (has_body_armor > 1.0)
	bool had_shield = (has_shield > 0.0)
	bool had_armor = (has_armor > 1.0)
	mind.should_wear_armor = true
	ChooseAnswerThanks(akAbuser)
	EquipInventoryNow(true) ; do_anim dress up = true
	;LogTrace("WearArmor ApplyEquipmentEffects")
	ApplyEquipmentEffects()
	if !had_body_armor && (has_body_armor > 1.0)
		SendNotificationOrder(name+" hastily puts on "+actorPossessive+" armor")
	elseif !had_armor && (has_armor > 1.0)
		SendNotificationOrder(name+" hastily puts on some pieces of armor")
	elseif mind.should_be_naked
		if !had_shield && (has_shield > 0.0)
			SendNotificationOrder(name+" fastens "+actorPossessive+" shield")
		else
			SendNotificationOrder(name+" agrees and will now use shields")
		endif
	elseif is_naked
		if (has_shield > 0.0)
			SendNotificationOrder(name+" agrees but only has a shield")
		else
			SendNotificationOrder(name+" agrees but doesn't have any protective armor")
		endif
	else
		SendNotificationOrder(name+" agrees and will now wear armor")
	endif
EndFunction

Function WearNoArmor()
	;*ogTrace("WearNoArmor weapons should="+mind.should_hold_weapons+" has="+has_weapon+" armor should="+mind.should_wear_armor+" has="+has_armor)
	mind.should_wear_armor = false
	SendOrderEquipInventory(!is_naked) ; do_anim dress up = true if not naked
EndFunction

Function HoldWeaponsAndWearArmor(Actor akAbuser)
	;*ogTrace("HoldWeaponsAndWearArmor weapons should="+mind.should_hold_weapons+" has="+has_weapon+" armor should="+mind.should_wear_armor+" has="+has_armor)
	bool had_weapon = (has_weapon > 0.0)
	bool had_body_armor = (has_body_armor > 1.0)
	bool had_armor = (has_armor > 1.0)
	bool had_shield = (has_shield > 0.0)
	mind.should_hold_weapons = true
	mind.should_wear_armor = true
	ChooseAnswerThanks(akAbuser)
	EquipInventoryNow(true) ; do_anim dress up = true
	;LogTrace("HoldWeaponsAndWearArmor ApplyEquipmentEffects")
	ApplyEquipmentEffects()
	if !had_body_armor && (has_body_armor > 1.0)
		SendNotificationOrder(name+" hastily puts on "+actorPossessive+" armor")
	elseif !had_armor && (has_armor > 1.0)
		SendNotificationOrder(name+" hastily puts on some pieces of armor")
	elseif mind.should_be_naked
		if !had_shield && (has_shield > 0.0)
			SendNotificationOrder(name+" fastens "+actorPossessive+" shield")
		else
			SendNotificationOrder(name+" agrees and will now use shields")
		endif
	elseif is_naked
		if (has_shield > 0.0)
			SendNotificationOrder(name+" agrees but only has a shield")
		else
			SendNotificationOrder(name+" agrees but doesn't have any protective armor")
		endif
	else
		SendNotificationOrder(name+" agrees and will now wear armor")
	endif
	if !had_weapon && (has_weapon > 0.0)
		SendNotificationOrder(name+" hastily equips "+actorPossessive+" weapons")
	elseif has_weapon <= 0.0
		SendNotificationOrder(name+" agrees but doesn't have any suitable weapon")
	else
		SendNotificationOrder(name+" agrees and will now hold weapons")
	endif
EndFunction

Function HoldNoWeaponsAndWearNoArmor()
	;*ogTrace("HoldNoWeaponsAndWearNoArmor weapons should="+mind.should_hold_weapons+" has="+has_weapon+" armor should="+mind.should_wear_armor+" has="+has_armor)
	mind.should_hold_weapons = false
	mind.should_wear_armor = false
	SendOrderEquipInventory(!is_naked) ; do_anim dress up = true if not naked
EndFunction

; Strip and choose wether to drop or keep items

Function StripMaybeDrop(Actor akAbuser)
	mind.should_be_naked = true
	if DOM01.DOMEquip.stripAndDropToggle
		StripAndDrop(akAbuser)
		return
	endif
	if DOM01.DOMEquip.stripWeaponsToggle
		mind.should_hold_weapons = false
	endif
	if DOM01.DOMEquip.stripShieldsToggle ; This is maybe too cumbersome as it requires to reset both clothes and armor policies
		mind.should_wear_armor = false
	endif
	StripMore()
EndFunction

Function StripMaybeDropWeapons(Actor akAbuser)
	mind.should_hold_weapons = false
	if DOM01.DOMEquip.stripAndDropToggle
		StripAndDropWeapons(akAbuser)
		return
	endif
	StripMoreWeapons()
EndFunction

Function StripMaybeDropArmor(Actor akAbuser)
	mind.should_wear_armor = false
	if DOM01.DOMEquip.stripAndDropToggle
		StripAndDropArmor(akAbuser)
		return
	endif
	StripMoreArmor()
EndFunction

Function StripMaybeDropWeaponsAndArmor(Actor akAbuser)
	mind.should_hold_weapons = false
	mind.should_wear_armor = false
	if DOM01.DOMEquip.stripAndDropToggle
		StripAndDropWeaponsAndArmor(akAbuser)
		return
	endif
	StripMoreWeaponsAndArmor()
EndFunction

Function StripMaybeDropAll(Actor akAbuser)
	mind.should_be_naked = true
	mind.should_hold_weapons = false
	mind.should_wear_armor = false
	if DOM01.DOMEquip.stripAndDropToggle
		StripAndDropAll(akAbuser)
		return
	endif
	StripMoreAll()
EndFunction

; Strip but keep items

bool Function ForceEquip(Form the_form)
	if !isWearable(the_form)
		return true
	endif
	Armor the_armor = the_form as Armor
	if akRef.IsEquipped(the_armor)
		return true
	endif
	;*ogTrace("ForceEquip no strip "+the_armor.GetName()+" iequip="+akRef.IsEquipped(the_armor))
	int slotmask = Math.LogicalAnd(the_armor.GetSlotMask(), 0x00002FFF)
	Armor item_already_in_slot = akRef.GetWornForm(slotmask) as Armor
	if item_already_in_slot == None
		EquipItemLoose(akRef,the_armor)
		return true
	endif
	if DOM01.DOMEquip.IsItemDevice(item_already_in_slot) || DOM01.DOMEquip.IsItemSpecial(item_already_in_slot)
		return false
	endif
	if DOM01.DOMEquip.IsItemDevice(the_armor) || DOM01.DOMEquip.IsItemSpecial(the_armor)
		EquipItemTight(akRef,the_armor)
	else
		EquipItemLoose(akRef,the_armor)
	endif
	return true
EndFunction

Function StripAndKeepItem(Form the_form)
	if !isWearable(the_form)
		return
	endif
	if !akRef.IsEquipped(the_form)
		if !DOM01.DOMEquip.isToBeStripped(the_form)
			ForceEquip(the_form)
		endif
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(the_form)
		return
	endif
	if DOM01.DOMEquip.IsItemDevice(the_form) || DOM01.DOMEquip.IsItemSpecial(the_form)
		return
	endif
	if !DOM01.DOMEquip.isToBeStripped(the_form)
		return
	endif
	UnEquipItemLoose(akRef,the_form)
EndFunction

Function StripAndKeepItemForced(Form the_form) ; unequip even if not to be stripped
	if !isWearable(the_form)
		return
	endif
	if !akRef.IsEquipped(the_form)
		if DOM01.DOMEquip.IsItemSpecial(the_form) || DOM01.DOMEquip.IsItemDevice(the_form)
			ForceEquip(the_form)
		endif
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(the_form)
		return
	endif
	if DOM01.DOMEquip.IsItemDevice(the_form) || DOM01.DOMEquip.IsItemSpecial(the_form)
		return
	endif
	UnEquipItemLoose(akRef,the_form)
EndFunction

Function StripAndKeepItemAmmo(Ammo the_ammo)
	if !DOM01.DOMEquip.stripWeaponsToggle
		return
	endif
	if !akRef.IsEquipped(the_ammo)
		return
	endif
	;*ogTrace("StripAndKeepItemAmmo "+the_ammo.GetName())
	UnEquipItemLoose(akRef,the_ammo)
EndFunction

Function StripAndKeepItemWeapon(Weapon the_weapon)
	if !DOM01.DOMEquip.stripWeaponsToggle
		return
	endif
	if !akRef.IsEquipped(the_weapon)
		return
	endif
	;*ogTrace("StripAndKeepItemWeapon "+the_weapon.GetName())
	UnEquipItemLoose(akRef,the_weapon)
EndFunction

Function StripAndKeepItemArmor(Armor the_armor)
	if !akRef.IsEquipped(the_armor)
		if !DOM01.DOMEquip.isToBeStripped(the_armor)
			ForceEquip(the_armor)
		endif
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(the_armor)
		return
	endif
	if DOM01.DOMEquip.IsItemDevice(the_armor) || DOM01.DOMEquip.IsItemSpecial(the_armor)
		return
	endif
	if !DOM01.DOMEquip.isToBeStripped(the_armor)
		return
	endif
	UnEquipItemLoose(akRef,the_armor)
EndFunction

Function StripMore()
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			int type = the_form.GetType()
			if type == 26
				StripAndKeepItemArmor(the_form as Armor)
			elseif type == 41
				StripAndKeepItemWeapon(the_form as Weapon)
			elseif type == 42
				StripAndKeepItemAmmo(the_form as Ammo)
			else
				StripAndKeepItem(the_form)
			endif
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;LogTrace("StripMore ApplyEquipmentEffects busy="+equip_inventory_busy+" wait="+wait_for_equipment)
	ApplyEquipmentEffects()
EndFunction

Function StripMoreWeapons()
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			int type = the_form.GetType()
			if type == 41
				StripAndKeepItemWeapon(the_form as Weapon)
			elseif type == 42
				StripAndKeepItemAmmo(the_form as Ammo)
			endif
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;LogTrace("StripMoreWeapons ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

Function StripMoreArmor()
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			int type = the_form.GetType()
			if type == 26
				StripAndKeepItemArmor(the_form as Armor)
			endif
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;LogTrace("StripMoreArmor ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

Function StripMoreWeaponsAndArmor()
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			int type = the_form.GetType()
			if type == 26
				StripAndKeepItemArmor(the_form as Armor)
			elseif type == 41
				StripAndKeepItemWeapon(the_form as Weapon)
			elseif type == 42
				StripAndKeepItemAmmo(the_form as Ammo)
			endif
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;LogTrace("StripMoreWeaponsAndArmor ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

Function StripMoreAll()
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			StripAndKeepItemForced(the_form)
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;LogTrace("StripMoreAll ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

; Strip and drop items

Function DropItem(Actor akAbuser, Form the_form)
	int nb = akRef.getItemCount(the_form)
	if DOM01.DOMEquip.stripDeleteToggle
		akRef.RemoveItem(the_form,nb)
	elseif DOM01.DOMEquip.stripLootToggle
		akRef.RemoveItem(the_form,nb, akOtherContainer = akAbuser)
	else
		akRef.DropObject(the_form,nb)
	endif
EndFunction

Function StripAndDropItem(Actor akAbuser, Form the_form)
	if !isWearable(the_form) && !DOM01.DOMEquip.stripItemsToggle
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(the_form)
		return
	endif
	if DOM01.DOMEquip.IsItemSpecial(the_form)
		ForceEquip(the_form)
		return
	endif
	if DOM01.DOMEquip.IsItemDevice(the_form)
		if ForceEquip(the_form)
			return
		endif
	endif
	if !DOM01.DOMEquip.isToBeStripped(the_form)
		if ForceEquip(the_form)
			return
		endif
	endif
	DropItem(akAbuser, the_form)
EndFunction

Function StripAndDropItemForced(Actor akAbuser, Form the_form)
	if !isWearable(the_form) && !DOM01.DOMEquip.stripItemsToggle
		return
	endif
	if DOM01.DOMEquip.IsItemIgnore(the_form)
		return
	endif
	if DOM01.DOMEquip.IsItemSpecial(the_form)
		ForceEquip(the_form)
		return
	endif
	if DOM01.DOMEquip.IsItemDevice(the_form)
		if ForceEquip(the_form)
			return
		endif
	endif
	DropItem(akAbuser, the_form)
EndFunction

Function StripAndDropItemAmmo(Actor akAbuser, Ammo the_ammo)
	if !DOM01.DOMEquip.stripWeaponsToggle
		return
	endif
	if !akRef.IsEquipped(the_ammo)
		if !DOM01.DOMEquip.stripUnequippedToggle
			return
		endif
	else
		UnEquipItemLoose(akRef,the_ammo)
	endif
	DropItem(akAbuser, the_ammo)
EndFunction

Function StripAndDropItemWeapon(Actor akAbuser, Weapon the_weapon)
	if !DOM01.DOMEquip.stripWeaponsToggle
		return
	endif
	if !akRef.IsEquipped(the_weapon)
		if !DOM01.DOMEquip.stripUnequippedToggle
			return
		endif
	else
		UnEquipItemLoose(akRef,the_weapon)
	endif
	DropItem(akAbuser, the_weapon)
EndFunction

Function StripAndDropItemArmor(Actor akAbuser, Armor the_armor)
	if DOM01.DOMEquip.IsItemIgnore(the_armor)
		return
	endif
	if DOM01.DOMEquip.IsItemSpecial(the_armor)
		ForceEquip(the_armor)
		return
	endif
	if DOM01.DOMEquip.IsItemDevice(the_armor)
		if ForceEquip(the_armor)
			return
		endif
	endif
	if !DOM01.DOMEquip.isToBeStripped(the_armor)
		if ForceEquip(the_armor)
			return
		endif
	endif
	if !akRef.IsEquipped(the_armor)
		if !DOM01.DOMEquip.stripUnequippedToggle
			return
		endif
	elseif DOM01.DOMEquip.IsItemDevice(the_armor) || DOM01.DOMEquip.IsItemSpecial(the_armor)
		UnEquipItemTight(akRef,the_armor)
	else
		UnEquipItemLoose(akRef,the_armor)
	endif
	DropItem(akAbuser, the_armor)
EndFunction

Function StripAndDrop(Actor akAbuser)
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = (akRef.GetNthForm(i)) as Form
		if the_form != None
			int type = the_form.GetType()
			if type == 26
				StripAndDropItemArmor(akAbuser, the_form as Armor)
			elseif type == 41
				StripAndDropItemWeapon(akAbuser, the_form as Weapon)
			elseif type == 42
				StripAndDropItemAmmo(akAbuser, the_form as Ammo)
			else
				StripAndDropItem(akAbuser, the_form)
			endif
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;*ogTrace("StripAndDrop::EquipInventory wait="+wait_for_equipment+" "+name)
	;LogTrace("StripAndDrop ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

Function StripAndDropWeapons(Actor akAbuser)
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	;*ogTrace("StripAndDropWeapons: n="+i+" delete="+DOM01.DOMEquip.stripDeleteToggle+" loot="+DOM01.DOMEquip.stripLootToggle)
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			int type = the_form.GetType()
			if type == 41
				StripAndDropItemWeapon(akAbuser, the_form as Weapon)
			elseif type == 42
				StripAndDropItemAmmo(akAbuser, the_form as Ammo)
			endif
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;*ogTrace("StripAndDropWeapons::ApplyEquipmentEffects wait="+wait_for_equipment+" "+name)
	;LogTrace("StripAndDropWeapons ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

Function StripAndDropArmor(Actor akAbuser)
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			int type = the_form.GetType()
			if type == 26
				StripAndDropItemArmor(akAbuser, the_form as Armor)
			endif
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;*ogTrace("StripAndDropArmor::EquipInventory wait="+wait_for_equipment+" "+name)
	;LogTrace("StripAndDropArmor ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

Function StripAndDropWeaponsAndArmor(Actor akAbuser)
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			int type = the_form.GetType()
			if type == 26
				StripAndDropItemArmor(akAbuser, the_form as Armor)
			elseif type == 41
				StripAndDropItemWeapon(akAbuser, the_form as Weapon)
			elseif type == 42
				StripAndDropItemAmmo(akAbuser, the_form as Ammo)
			endif
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;*ogTrace("StripAndDropWeaponsAndArmor::EquipInventory wait="+wait_for_equipment+" "+name)
	;LogTrace("StripAndDropWeaponsAndArmor ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

Function StripAndDropAll(Actor akAbuser)
	wait_for_equipment = true
	equip_inventory_busy = true
	CheckAndSetOutfit()
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			StripAndDropItemForced(akAbuser, the_form)
		endif
	endwhile
	wait_for_equipment = false
	equip_inventory_busy = false
	;*ogTrace("StripAndDropAll::EquipInventory wait="+wait_for_equipment+" "+name)
	;LogTrace("StripAndDropAll ApplyEquipmentEffects")
	ApplyEquipmentEffects()
EndFunction

; ################
; ### Tats & marks

Function ResetTats()
	ResetTears()
	ResetChoke()
	ResetSlap()
	ResetSpank()
	ResetSlapBoobs()
	ResetBlush()
	ResetBrand()
	ResetMarks()
EndFunction

Int Function RetainedMap() Global
    Int map = JMap.object()
    JValue.retain(map)
    return map
EndFunction

Int Function RetainedMap1Pair(String key1, String value1) Global
    Int map = RetainedMap()
    JMap.setStr(map, key1, value1)
    return map
EndFunction

Int Function RetainedMap2Pair(String key1, String value1, String key2, String value2) Global
    Int map = RetainedMap1Pair(key1, value1)
    JMap.setStr(map, key2, value2)
    return map
EndFunction

Int Function RetainedMap3Pair(String key1, String value1, String key2, String value2, String key3, String value3) Global
    Int map = RetainedMap2Pair(key1, value1, key2, value2)
    JMap.setStr(map, key3, value3)
    return map
EndFunction

Int Function RetainedMap4Pair(String key1, String value1, String key2, String value2, String key3, String value3, String key4, String value4) Global
    Int map = RetainedMap3Pair(key1, value1, key2, value2, key3, value3)
    JMap.setStr(map, key4, value4)
    return map
EndFunction

Int Function AddTattoo(Actor anActor, String tat_name, String texture, String section, String area, Int slot, Int colorTint = -1)
    if colorTint == -1 
        colorTint = 0x990033
    endif
    Int map = RetainedMap4Pair("name", tat_name, "texture", texture, "section", section, "area", area)
    JMap.setInt(map, "color", colorTint)
 
    if Slavetats.add_tattoo(anActor, map, slot)
        LogTrace("AddTattoo: Failed to add tattoo")
    endif
	return map
EndFunction

Int Function AddTattooAlpha(Actor anActor, String tat_name, String texture, String section, String area, Int slot, Int colorTint = -1, Float alpha=0.0)
    if colorTint == -1 
        colorTint = 0x990033
    endif
    Int map = RetainedMap4Pair("name", tat_name, "texture", texture, "section", section, "area", area)
    JMap.setInt(map, "color", colorTint)
    JMap.setFlt(map, "invertedAlpha", 1.0 - alpha)

    if Slavetats.add_tattoo(anActor, map, slot)
        LogTrace("AddTattooAlpha: Failed to add tattoo "+tat_name)
    endif
	return map
EndFunction

Int Function AddTattooGlowGloss(Actor anActor, String tat_name, String texture, String section, String area, Int slot, Int glow, bool gloss, Int colorTint = -1)
    if colorTint == -1 
        colorTint = 0x990033
    endif
    Int map = RetainedMap4Pair("name", tat_name, "texture", texture, "section", section, "area", area)
    JMap.setInt(map, "glow", glow)   ; The glow color to use. Can be overridden via the menu
	if gloss
		JMap.setInt(map, "gloss", 1) ; If > 0, use skin-like gloss. Otherwise, use matte color
	else
		JMap.setInt(map, "gloss", 0)
	endif
	if glow == 0
		JMap.setInt(map, "color", colorTint)
	else
		JMap.setInt(map, "color", glow)
	endif
    if Slavetats.add_tattoo(anActor, map, slot)
        LogTrace("AddTattoo: Failed to add tattoo")
    endif
	return map
EndFunction

Function Interact_Mark(Actor akAbuser)
	TryRemoveMarks()
	SetMarksFromStatus()
	SendNotificationAbuse("Slave "+name+" will be marked "+brand_name)
	if !is_group_order
		Anim_Brand(akAbuser)
	endif
	mind.SetNextPraiseReasonSilent(8) ; "being a nice branded pet"
	mind.CheckAndRegisterKink(61,1.0) ; "being marked"
	if akAbuser == PlayerRef ; player
		DOM01.DOM04.NotifyBrand(self,DOM01.brand_area)
		SendExternalEventSSSB("Branded",brand_name,DOM01.brand_area, mind.IsObedient())
	endif
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillSlaver(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
		akAggressorMind.CheckAndRegisterKink(107,1.0) ; "managing slaves"
	else
		DOM01.TrainSkillSlaver(akAbuser,0.5)
	endif
EndFunction

Function Interact_Unmark()
	TryRemoveMarks()
	SendNotificationAbuse("Slave "+name+" will be unmarked")
	if brand_map0 == 0 && marks_map0 == 0
		mind.RemoveNextPraiseReason(8) ; "being a nice branded pet"
	endif
EndFunction

Function Interact_Brand(Actor akAbuser)
	TryRemoveBrand()
	SetBrandTatsDOM()
	SetBrandFromStatus()
	SendNotificationAbuse("Slave "+name+" will be branded with "+marks_name)
	if !is_group_order
		Anim_Brand(akAbuser)
	endif
	mind.SetNextPraiseReasonSilent(8) ; "being a nice branded pet"
	mind.CheckAndRegisterKink(62,1.0) ; "being branded"
	if akAbuser == PlayerRef ; player
		DOM01.DOM04.NotifyBrand(self,marks_area)
		SendExternalEventSSSB("Branded",marks_name,marks_area, mind.IsObedient())
	endif
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillSlaver(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
		akAggressorMind.CheckAndRegisterKink(107,1.0) ; "managing slaves"
	else
		DOM01.TrainSkillSlaver(akAbuser,0.5)
	endif
EndFunction

Function Interact_unbrand()
	TryRemoveBrand()
	SendNotificationAbuse("Slave "+name+" will be unbranded")
	if brand_map0 == 0 && marks_map0 == 0
		mind.RemoveNextPraiseReason(8) ; "being a nice branded pet"
	endif
EndFunction

Function Anim_Brand(Actor akAbuser)
	if akAbuser == None
		return
	endif
	if is_running_away
		EnterFollowPlayerOrTrainer()
	endif
	if !canAnimate || !canAnimateLocal
		return
	endif 

	canAnimateLocal = false
	canAnimate = false

	mind.UndressBeforeShowering()
	ChooseAnswerStrip(akAbuser)
	
	StartJSONAnimation(akAbuser,"DOMBranding")
	Wait(2.0)
	ChooseAnswerWhat(akAbuser)
	PlayJSONAnimations(1,JSONanim_nscenes-(2))
	Wait(2.0)
	PlayJSONAnimation(JSONanim_nscenes - (1))
	EndJSONAnimation()
	
	canAnimateLocal = true
	canAnimate = true
	mind.RedressAfterShowering()
EndFunction

string brand_name = ""
string brand_file = ""
int brand_map0 = 0
int brand_glow_color = 0

int marks_map0 = 0
int marks_glow_color = 0

Function SetTatsGlowColor()
	LogTrace("SetTatsGlowColor")
	SetTatsFromStatus()
	if marks_map0 != 0
		TryRemoveBrand()
		TryApplyBrand()
	endif
	if brand_map0 != 0
		TryRemoveMarks()
		TryApplyMarks()
	endif
EndFunction

Function SetTatsFromStatus()
	int glow_color = GetMarksGlowColorByIndex(mind.training_status)
	marks_glow_color = glow_color
	brand_glow_color = glow_color
	brand_name = mind.GetTrainingStatusName()
	if brand_name == "freshly captured"
		brand_file = "DoMStatus\\state_fresh_t.dds"
	else
		brand_file = "DoMStatus\\state_"+brand_name+"_t.dds"
	endif
	LogTrace("SetTatsFromStatus brand_file="+brand_file)
EndFunction

Function SetMarksFromStatus()
	SetTatsFromStatus()
	TryApplyMarks()
EndFunction

Function SetBrandFromStatus()
	SetTatsFromStatus()
	TryApplyBrand()
EndFunction

int Function GetMarksGlowColorByIndex(int idx)
	if idx == 0
		return 0xFCDEFD ; "freshly captured" ; training didn't start yet
	endif
	if idx == 1
		return 0x023849 ; "untamed" ; training didn't start yet ; 
	endif
	if idx == 2
		return 0xA000A0 ; "degraded" ; humiliation+submission ; G+B
	endif
	if idx == 3
		return 0x8806CE ; "abused" ; (submission+humiliation)/2.0+anger_training ; G+B+V (0x8806CE)
	endif
	if idx == 4
		return 0x8866CE ; "objectified" ; (humiliation+resignation)/2.0+anger_training ; B+Y+V
	endif
	if idx == 5
		return 0x6688CE ; "tamed" ; (resignation+submission)/2.0+anger_training ; Y+G+V
	endif
	if idx == 6
		return 0x76F51A ; "forced" ; submission+fear_training ; G+O 
	endif
	if idx == 7
		return 0x06CE88 ; "dominated" ; submission+anger_training ; G+V
	endif
	if idx == 8
		return 0xDEB741 ; "subjugated" ; submission+respect_training ; G+R
	endif
	if idx == 9
		return 0xF5761A ; "terrorized" ; resignation+fear_training ; Y+O (0xF5761A)
	endif
	if idx == 10
		return 0xCE8806 ; "enslaved" ; resignation+anger_training ; Y+V
	endif
	if idx == 11
		return 0xB7DE41 ; "subdued" ; resignation+respect_training ; Y+R
	endif
	if idx == 12
		return 0x1A76F5 ; "debased" ; humiliation+fear_training ; B+O
	endif
	if idx == 13
		return 0x0688CE ; "demeaned" ; humiliation+anger_training ; B+V
	endif
	if idx == 14
		return 0xB741DE ; "disgraced" ; humiliation+respect_training ; B+R
	endif
	if idx == 15
		return 0x31FFFF ; "shamed" ; (humiliation+submission)/2.0+MOD_Orgasm*20.0 ; B+G+C (0x00FFFF)
	endif
	if idx == 16
		return 0x07FD66 ; "submitted" ; submission+MOD_Orgasm*20.0 ; G+C
	endif
	if idx == 17
		return 0x0766FD ; "humiliated" ; humiliation+MOD_Orgasm*20.0 ; B+C
	endif
	if idx == 18
		return 0x88FD66 ; "resignated" ; resignation+MOD_Orgasm*20.0 ; Y+C
	endif
	if idx == 19
		return 0x044931 ; "unbroken" ; training didn't start yet
	endif
	if idx == 20
		return 0xCFA087 ; "mesmerized" ; feelings start here
	endif
	if idx == 21
		return 0xDB95AB ; "ravished"
	endif
	if idx == 22
		return 0xDE5D83 ; "bewitched"
	endif
	if idx == 23
		return 0xE68FAC ; "charmed"
	endif
	if idx == 24
		return 0xFF5CCD ; "brainwashed"
	endif
	if idx == 25
		return 0xFF1493 ; "hypnotized"
	endif
	if idx == 26
		return 0xFF007F ; "devoted"
	endif
	if idx == 27
		return 0xFF0000 ; "enraptured" ; = final stage
	endif
	return 0x044931 ; "unbroken" ; == 19
EndFunction

bool Function HasMark()
	if brand_map0 == 0
		return false
	endif
	return true
EndFunction

Function ResetMarks()
	if brand_map0 == 0
		return
	endif
	TryRemoveMarks()
	TryApplyMarks()
EndFunction

Function TryApplyMarks()
 	if actorType != 0
		return ; animal or creature
	endif
	
	Int slot = -1
 	if brand_map0 == 0
		if DOM01.brand_glow_status
			brand_map0 = AddTattooGlowGloss(akRef, brand_name, brand_file, DOM01.brand_section, DOM01.brand_area, slot, brand_glow_color, DOM01.brand_gloss, colorTint = DOM01.brand_color)
		else
			brand_map0 = AddTattooGlowGloss(akRef, brand_name, brand_file, DOM01.brand_section, DOM01.brand_area, slot, DOM01.brand_glow, DOM01.brand_gloss, colorTint = DOM01.brand_color)
		endif
	endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("TryApplyMarks: Failed to synchronize_tattoos - Slave mark")
	endif
	akRef.SetFactionRank(DOM01.DOMActorHasTatsMarks,1)
    ;*ogTrace("TryApplyMarks: Apply Slave mark to " + name+" "+brand_map0+" tat="+marks_name+" file="+marks_file+" sec="+DOM01.marks_section+" area="+marks_area+" color="+DOM01.marks_color)
EndFunction

Function TryRemoveMarks()
    if brand_map0 == 0
		return
	endif
	if Slavetats.remove_tattoos(akRef, brand_map0)
		LogTrace("TryRemoveMarks: Failed to remove tattoo - Slave mark")
    endif
    JValue.release(brand_map0)
    brand_map0 = 0  
	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("TryRemoveMarks Failed to synchronize_tattoos - Remove slave mark")
	endif
	akRef.RemoveFromFaction(DOM01.DOMActorHasTatsMarks)
    ;*ogTrace("TryRemoveMarks Remove slave mark from " + name)
EndFunction

bool Function HasBrand()
	if marks_map0 == 0
		return false
	endif
	return true
EndFunction

Function ResetBrand()
	if marks_map0 == 0
		return
	endif
	TryRemoveBrand()
	TryApplyBrand()
EndFunction

string marks_name = ""
string marks_file = ""
string marks_area = ""

Function SetBrandTatsDOM()
	marks_name = DOM01.marks_name
	marks_file = DOM01.marks_file
	marks_area = DOM01.marks_area
EndFunction

Function SetBrandTatsMaid()
	marks_name = DOM01.marks_maid_name
	marks_file = DOM01.marks_maid_file
	marks_area = DOM01.marks_maid_area
EndFunction

Function SetBrandTatsMiner()
	marks_name = DOM01.marks_miner_name
	marks_file = DOM01.marks_miner_file
	marks_area = DOM01.marks_miner_area
EndFunction

Function TryApplyBrand()
 	if actorType != 0
		return ; animal or creature
	endif
	
	if marks_name == ""
		SetBrandTatsDOM()
	endif
	Int slot = -1
 	if marks_map0 == 0
		if DOM01.marks_glow_status
			marks_map0 = AddTattooGlowGloss(akRef, marks_name, marks_file, DOM01.marks_section, marks_area, slot, marks_glow_color, DOM01.marks_gloss, colorTint = DOM01.marks_color)
		else
			marks_map0 = AddTattooGlowGloss(akRef, marks_name, marks_file, DOM01.marks_section, marks_area, slot, DOM01.marks_glow, DOM01.marks_gloss, colorTint = DOM01.marks_color)
		endif
	endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("TryApplyBrand: Failed to synchronize_tattoos - Slave mark")
	endif
	akRef.SetFactionRank(DOM01.DOMActorHasTatsBrand,1)
   ;*ogTrace("TryApplyBrand: Apply Slave mark to " + name+" "+marks_map0+" tat="+marks_name+" file="+marks_file+" sec="+DOM01.marks_section+" area="+marks_area+" color="+DOM01.marks_color)
EndFunction

Function TryRemoveBrand()
    if marks_map0 == 0
		return
	endif
	if Slavetats.remove_tattoos(akRef, marks_map0)
		LogTrace("TryRemoveBrand: Failed to remove tattoo - Slave mark")
    endif
    JValue.release(marks_map0)
    marks_map0 = 0  
	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("TryRemoveBrand Failed to synchronize_tattoos - Remove slave mark")
	endif
	akRef.RemoveFromFaction(DOM01.DOMActorHasTatsBrand)
    ;*ogTrace("TryRemoveBrand Remove slave mark from " + name)
EndFunction

int tears_map0 = 0
int tears_map1 = 0
int tears_map2 = 0

Function ResetTears()
	int ntears = 0
	if tears_map0 != 0
		ntears += 1
	endif
	if tears_map1 != 0
		ntears += 1
	endif
	if tears_map2 != 0
		ntears += 1
	endif
	if ntears > 0
		TryRemoveTears(ntears)
		TryApplyTears()
		ntears -= 1
		if ntears > 0
			TryApplyTears()
			ntears -= 1
			if ntears > 0
				TryApplyTears()
				ntears -= 1
			endif
		endif
	endif
EndFunction

Function TryApplyTears()
	bool applyTears        = ( DOM01.tearsFToggle && (actorSex%2) == 1) || ( DOM01.tearsMToggle && (actorSex%2) == 0)
	bool applyMascaraTears = ( DOM01.masctFToggle && (actorSex%2) == 1) || ( DOM01.masctMToggle && (actorSex%2) == 0)
    ;*ogTrace("Try apply tears to " + name+" "+applyTears+" "+applyMascaraTears)
	if !applyTears && !applyMascaraTears
		return
	endif
	if actorType != 0
		return ; animal or creature
	endif
	Int slot = -1

 	if tears_map0 == 0 && applyTears
		int x = RandomInt(1,13)
		if x == 1
			tears_map0 = AddTattoo(akRef, "Simple Tears 1", "DOMTears\\simple_tears_1.dds", "DOMTears", "Face", slot) ; 
		elseif x == 2
			tears_map0 = AddTattoo(akRef, "Simple Tears 2", "DOMTears\\simple_tears_2.dds", "DOMTears", "Face", slot) ; 
		elseif x == 3
			tears_map0 = AddTattoo(akRef, "Simple Tears 3", "DOMTears\\simple_tears_3.dds", "DOMTears", "Face", slot) ;
		elseif x == 4
			tears_map0 = AddTattoo(akRef, "Simple Tears 4", "DOMTears\\simple_tears_4.dds", "DOMTears", "Face", slot) ;
		elseif x == 5
			tears_map0 = AddTattoo(akRef, "Simple Tears 5", "DOMTears\\simple_tears_5.dds", "DOMTears", "Face", slot) ;
		elseif x == 6
			tears_map0 = AddTattoo(akRef, "Simple Tears 6", "DOMTears\\simple_tears_6.dds", "DOMTears", "Face", slot) ;
		elseif x == 7
			tears_map0 = AddTattoo(akRef, "Simple Tears 7", "DOMTears\\simple_tears_7.dds", "DOMTears", "Face", slot) ;
		elseif x == 8
			tears_map0 = AddTattoo(akRef, "Simple Tears 8", "DOMTears\\simple_tears_8.dds", "DOMTears", "Face", slot) ;
		elseif x == 9
			tears_map0 = AddTattoo(akRef, "Simple Tears 9", "DOMTears\\simple_tears_9.dds", "DOMTears", "Face", slot) ;
		elseif x == 10
			tears_map0 = AddTattoo(akRef, "Simple Tears 10", "DOMTears\\simple_tears_10.dds", "DOMTears", "Face", slot) ; 
		elseif x == 11
			tears_map0 = AddTattoo(akRef, "Simple Tears 11", "DOMTears\\simple_tears_11.dds", "DOMTears", "Face", slot) ; 
		elseif x == 12
			tears_map0 = AddTattoo(akRef, "Simple Tears 12", "DOMTears\\simple_tears_12.dds", "DOMTears", "Face", slot) ; 
		else
			tears_map0 = AddTattoo(akRef, "Simple Tears 13", "DOMTears\\simple_tears_13.dds", "DOMTears", "Face", slot) ; 
		endif
	elseif tears_map1 == 0 && applyTears
		int x = RandomInt(1,5)
		if x == 1
			tears_map1 = AddTattoo(akRef, "Redeye Tears 1", "DOMTears\\redeye_tears_1.dds", "DOMTears", "Face", slot)
		elseif x == 2
			tears_map1 = AddTattoo(akRef, "Redeye Tears 2", "DOMTears\\redeye_tears_2.dds", "DOMTears", "Face", slot)
		elseif x == 3
			tears_map1 = AddTattoo(akRef, "Redeye Tears 3", "DOMTears\\redeye_tears_3.dds", "DOMTears", "Face", slot)
		elseif x == 4
			tears_map1 = AddTattoo(akRef, "Redeye Tears 4", "DOMTears\\redeye_tears_4.dds", "DOMTears", "Face", slot)
		else
			tears_map1 = AddTattoo(akRef, "Redeye Tears 5", "DOMTears\\redeye_tears_5.dds", "DOMTears", "Face", slot)
		endif
	elseif tears_map2 == 0 && applyMascaraTears
		int x = RandomInt(1,10)
		if x == 1
			tears_map2 = AddTattoo(akRef, "Makeup Tears both", "DOMTears\\makeup_tears_both.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		elseif x == 2
			tears_map2 = AddTattoo(akRef, "Makeup Tears left", "DOMTears\\makeup_tears_left.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		elseif x == 3
			tears_map2 = AddTattoo(akRef, "Makeup Tears right", "DOMTears\\makeup_tears_right.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		elseif x == 4
			tears_map2 = AddTattoo(akRef, "Makeup Tears 2", "DOMTears\\makeup_tears_2.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		elseif x == 5
			tears_map2 = AddTattoo(akRef, "Makeup Tears 3", "DOMTears\\makeup_tears_3.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		elseif x == 6
			tears_map2 = AddTattoo(akRef, "Makeup Tears 4", "DOMTears\\makeup_tears_4.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		elseif x == 7
			tears_map2 = AddTattoo(akRef, "Makeup Tears 5", "DOMTears\\makeup_tears_5.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		elseif x == 8
			tears_map2 = AddTattoo(akRef, "Makeup Tears 6", "DOMTears\\makeup_tears_6.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		elseif x == 9
			tears_map2 = AddTattoo(akRef, "Makeup Tears 7", "DOMTears\\makeup_tears_7.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		else
			tears_map2 = AddTattoo(akRef, "Makeup Tears 8", "DOMTears\\makeup_tears_8.dds", "DOMTears", "Face", slot, 0x000000) ; black mascara tears
		endif
	elseif tears_map2 == 0 && applyTears
		int x = RandomInt(1,13)
		if x == 1
			tears_map2 = AddTattoo(akRef, "Simple Tears 1", "DOMTears\\simple_tears_1.dds", "DOMTears", "Face", slot) ; 
		elseif x == 2
			tears_map2 = AddTattoo(akRef, "Simple Tears 2", "DOMTears\\simple_tears_2.dds", "DOMTears", "Face", slot) ; 
		elseif x == 3
			tears_map2 = AddTattoo(akRef, "Simple Tears 3", "DOMTears\\simple_tears_3.dds", "DOMTears", "Face", slot) ;
		elseif x == 4
			tears_map2 = AddTattoo(akRef, "Simple Tears 4", "DOMTears\\simple_tears_4.dds", "DOMTears", "Face", slot) ;
		elseif x == 5
			tears_map2 = AddTattoo(akRef, "Simple Tears 5", "DOMTears\\simple_tears_5.dds", "DOMTears", "Face", slot) ;
		elseif x == 6
			tears_map2 = AddTattoo(akRef, "Simple Tears 6", "DOMTears\\simple_tears_6.dds", "DOMTears", "Face", slot) ;
		elseif x == 7
			tears_map2 = AddTattoo(akRef, "Simple Tears 7", "DOMTears\\simple_tears_7.dds", "DOMTears", "Face", slot) ;
		elseif x == 8
			tears_map2 = AddTattoo(akRef, "Simple Tears 8", "DOMTears\\simple_tears_8.dds", "DOMTears", "Face", slot) ;
		elseif x == 9
			tears_map2 = AddTattoo(akRef, "Simple Tears 9", "DOMTears\\simple_tears_9.dds", "DOMTears", "Face", slot) ;
		elseif x == 10
			tears_map2 = AddTattoo(akRef, "Simple Tears 10", "DOMTears\\simple_tears_10.dds", "DOMTears", "Face", slot) ; 
		elseif x == 11
			tears_map2 = AddTattoo(akRef, "Simple Tears 11", "DOMTears\\simple_tears_11.dds", "DOMTears", "Face", slot) ; 
		elseif x == 12
			tears_map2 = AddTattoo(akRef, "Simple Tears 12", "DOMTears\\simple_tears_12.dds", "DOMTears", "Face", slot) ; 
		else
			tears_map2 = AddTattoo(akRef, "Simple Tears 13", "DOMTears\\simple_tears_13.dds", "DOMTears", "Face", slot) ; 
		endif
	else
		LogInfo("WARNING: Try apply tears to " + name+" no available map found")
		return
	endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Tears")
	endif
	akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
 
    ;*ogTrace("Apply tears to " + name+" "+tears_map0+" "+tears_map1+" "+tears_map2)
EndFunction

bool Function hasTears()
	if tears_map0 == 0 && tears_map1 == 0 && tears_map2 == 0
		return false
	endif
	return true
EndFunction

Function TryRemoveTears(int max)
	int ntears = max
	bool do_sync = false
	;*ogTrace("Remove tears")
	; Dry bigger tears first
    if tears_map1 != 0 && ntears > 0
		if Slavetats.remove_tattoos(akRef, tears_map1)
			LogTrace("Failed to remove tattoo - Tears1")
        endif
        JValue.release(tears_map1)
        tears_map1 = 0     
		do_sync =true
		ntears -=1
    endif
    if tears_map0 != 0 && ntears > 0
		if Slavetats.remove_tattoos(akRef, tears_map0)
			LogTrace("Failed to remove tattoo - Tears0")
        endif
        JValue.release(tears_map0)
        tears_map0 = 0    
		do_sync =true
		ntears -=1
    endif
	; Remove mascara last
    if tears_map2 != 0 && ntears > 0
		if Slavetats.remove_tattoos(akRef, tears_map2)
			LogTrace("Failed to remove tattoo - Tears2")
        endif
        JValue.release(tears_map2)
        tears_map2 = 0     
		do_sync =true
		ntears -=1
    endif

	if do_sync
		if Slavetats.synchronize_tattoos(akRef, true)
			LogTrace("Failed to synchronize_tattoos - Remove Tears")
			;*ogTrace("Failed to synchronize_tattoos")
		endif
		
		if !hasTears()
			akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
		else
			akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
		endif
	endif
    ;*ogTrace("Remove tears from " + name+" "+tears_map0+" "+tears_map1+" "+tears_map2)
EndFunction

Function TryRemoveMascaraTears()
    if tears_map2 == 0
		return
	endif
	;*ogTrace("Remove mascara tears")
	; Remove mascara only
 	if Slavetats.remove_tattoos(akRef, tears_map2)
		LogTrace("Failed to remove tattoo - Tears2")
    endif
    JValue.release(tears_map2)
    tears_map2 = 0     

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos  - Remove Mascara")
		;*ogTrace("Failed to synchronize_tattoos")
	endif
	
	if !hasTears()
		akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
	else
		akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
	endif
    ;*ogTrace("Remove mascara tears from " + name+" "+tears_map2)
EndFunction

int spank_map0 = 0
int spank_timer = 0
float spank_alpha = 0.0

Function ResetSpank()
	if spank_map0 == 0
		return
	endif
	TryRemoveCurrentSpank()
	TryUpdateSpank()
EndFunction

Function TryApplySpank()
 	if actorType != 0
		return ; animal or creature
	endif
	spank_timer = 64
	TryUpdateSpank()
EndFunction

Function TryUpdateSpank()
	if actorType != 0
		return ; animal or creature
	endif
	
	; Update to spank level
	if spank_timer <= 0
		TryRemoveCurrentSpank()
		return
	elseif spank_map0 != 0 && spank_alpha >= 1.0
		return
	endif
	
	Int slot = -1
 	if spank_map0 == 0
		spank_alpha = 0.25
		spank_map0 = AddTattooAlpha(akRef, "Spank ass", "DOMSlap\\spank_ass_light.dds", "DOMSlap", "Body", slot,alpha=spank_alpha)
	else
		spank_alpha += 0.25
		JMap.setFlt(spank_map0, "invertedAlpha", 1.0 - slapboobs_alpha)
	endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Spank")
	endif
    ;*ogTrace("Apply spank to " + name+" "+spank_map0)
EndFunction

Function TryRemoveSpank()
	if spank_timer == 0 && spank_map0 == 0
		return
	endif
	if spank_timer > 0
		spank_timer -= 1
		return
	endif
	TryUpdateSpank()
EndFunction

Function TryRemoveCurrentSpank()
    if spank_map0 != 0
		if Slavetats.remove_tattoos(akRef, spank_map0)
			LogTrace("Failed to remove tattoo - Spank")
        endif
        JValue.release(spank_map0)
        spank_map0 = 0    
	else
		return
    endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Remove Spank")
		;*ogTrace("Failed to synchronize_tattoos")
	endif
    ;*ogTrace("Remove spank from " + name)
EndFunction

Function TryRemoveAllSpank()
	TryRemoveCurrentSpank()
	spank_timer = 0
    ;*ogTrace("Remove all spank from " + name+" timer="+spank_timer)
EndFunction

int slapboobs_map0 = 0
int slapboobs_timer = 0
float slapboobs_alpha = 0.0

Function ResetSlapBoobs()
	if slapboobs_map0 == 0
		return
	endif
	TryRemoveCurrentSlapBoobs()
	TryUpdateSlapBoobs()
EndFunction

Function TryApplySlapBoobs()
 	if actorType != 0
		return ; animal or creature
	endif
	slapboobs_timer = 64
	TryUpdateSlapBoobs()
EndFunction

Function TryUpdateSlapBoobs()
	if actorType != 0
		return ; animal or creature
	endif
	
	; Update to slap boobs level
	if slapboobs_timer <= 0
		TryRemoveCurrentSlapBoobs()
		return
	elseif slapboobs_map0 != 0 && slapboobs_alpha >= 1.0
		return
	endif
	
	Int slot = -1
 	if slapboobs_map0 == 0
		slapboobs_alpha = 0.25 ; 0 is fully transparent
		slapboobs_map0 = AddTattooAlpha(akRef, "Slap boobs", "DOMSlap\\spank_boobs_light.dds", "DOMSlap", "Body", slot,alpha=slapboobs_alpha)
	else
		slapboobs_alpha += 0.25
		JMap.setFlt(slapboobs_map0, "invertedAlpha", 1.0 - slapboobs_alpha)
	endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("TryUpdateSlapBoobs: Failed to synchronize_tattoos - Slap boobs")
	endif
    ;*ogTrace("TryUpdateSlapBoobs: slap boobs to " + name+" "+slapboobs_map0)
EndFunction

Function TryRemoveSlapBoobs()
	if slapboobs_timer == 0 && slapboobs_map0 == 0
		return
	endif
	if slapboobs_timer > 0
		slapboobs_timer -= 1
		return
	endif
	TryUpdateSlapBoobs()
EndFunction

Function TryRemoveCurrentSlapBoobs()
    if slapboobs_map0 != 0
		if Slavetats.remove_tattoos(akRef, slapboobs_map0)
			LogTrace("TryRemoveCurrentSlapBoobs: Failed to remove tattoo - Slap boobs")
        endif
        JValue.release(slapboobs_map0)
        slapboobs_map0 = 0  
		slapboobs_alpha	= 0.0
	else
		return
    endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("TryRemoveCurrentSlapBoobs: Failed to synchronize_tattoos - Remove Slap boobs")
		;*ogTrace("Failed to synchronize_tattoos")
	endif
    ;*ogTrace("TryRemoveCurrentSlapBoobs: Remove slap boobs from " + name)
EndFunction

Function TryRemoveAllSlapBoobs()
	TryRemoveCurrentSlapBoobs()
	slapboobs_timer = 0
    ;*ogTrace("TryRemoveAllSlapBoobs: Remove all slap boobs from " + name+" timer="+slapboobs_timer)
EndFunction

int slap_map0a = 0
int slap_map0b = 0
int slap_map1 = 0
int slap_timer = 0
int slap_level = 0
int slap_level_prev = 0
int slap_nhits = 0
int slap_type = 0

Function HandleSlappedOnUpdate()
	;*ogTrace("HandleSlappedOnUpdate slapped="+is_slapped)
	if !is_slapped
		if slap_timer > 0
			TryRemoveSlap()
		endif	
		return
	endif
	if !mind.whipping_active
		is_whipped = false
		is_slapped = false
		is_caned   = false
		pain_giver = None
	endif
EndFunction

Function ResetSlap()
	if slap_level == 0
		slap_map0a = 0
		slap_map0b = 0
		slap_map1 = 0
		slap_timer = 0
		return
	endif
	if slap_map0a == 0 && slap_map0b == 0 && slap_map1 == 0 && slap_timer == 0
		slap_level = 0
		return
	endif
	slap_level_prev = 0 ; force update
	TryRemoveCurrentSlap()
	TryUpdateSlap()
EndFunction

Function TryApplySlap()
 	if actorType != 0
		return ; animal or creature
	endif
	slap_nhits += 1
	slap_timer = 64
	slap_level = slap_nhits/24+1
	if slap_level > 5
		slap_level= 5
	endif
	;*ogTrace("TryApplySlap to " + name+" nhits="+slap_nhits+" timer="+slap_timer+" level="+slap_level)
	TryUpdateSlap()
EndFunction

Function TryUpdateSlap()
	if actorType != 0
		return ; animal or creature
	endif
	
	;*ogTrace("TryUpdateSlap for " + name+" nhits="+slap_nhits+" timer="+slap_timer+" level="+slap_level+" prev="+slap_level_prev+" map0a="+slap_map0a+" map0b="+slap_map0b+" map1="+slap_map1)
	; Update to next slap level?
	if slap_timer <= 0
		if slap_level <= 0 ; timer == 0 && level == 0 => do not apply another slap mark
			TryRemoveCurrentSlap()
			slap_type = 0
			return
		endif
	endif
	
	if slap_level == slap_level_prev
		return ; no need to update
	endif
	Int slot = -1
	if slap_type == 0
		slap_type = RandomInt(1,6)
	endif
	if slap_level == 1
		TryRemoveCurrentSlap(true,true,true) ; remove slaps and battered
		if slap_map0a == 0
			;*ogTrace("Try apply slap to " + name+" level="+slap_level+" type="+slap_type)
			if slap_type < 3 ; type 1 and 2
				slap_map0a = AddTattoo(akRef, "Slapped Right 1", "DOMSlap\\Face_Slap_Right1.dds", "DOMSlap", "Face", slot,0)
			else
				slap_map0a = AddTattoo(akRef, "Slapped Left 1", "DOMSlap\\Face_Slap_Left1.dds", "DOMSlap", "Face", slot,0)
			endif
		else
		;	LogTrace("Try apply slap to " + name+" no available map found")
			return
		endif
	elseif slap_level == 2
		TryRemoveCurrentSlap(true,true,true) ; remove slaps and battered
		if slap_map0a == 0
			;*ogTrace("Try apply slap to " + name+" level="+slap_level+" type="+slap_type)
			if slap_type < 3 ; type 1 and 2
				slap_map0a = AddTattoo(akRef, "Slapped Right 2", "DOMSlap\\Face_Slap_Right2.dds", "DOMSlap", "Face", slot,0)
			else
				slap_map0a = AddTattoo(akRef, "Slapped Left 2", "DOMSlap\\Face_Slap_Left2.dds", "DOMSlap", "Face", slot,0)
			endif
		else
		;	LogTrace("Try apply slap to " + name+" no available map found")
			return
		endif
	elseif slap_level == 3
		TryRemoveCurrentSlap(false,true,true) ; remove slap b and battered
		if slap_map0b == 0
			;*ogTrace("Try apply slap to " + name+" level="+slap_level+" type="+slap_type)
			if slap_type < 3 ; type 1 and 2
				slap_map0b = AddTattoo(akRef, "Slapped Left 3", "DOMSlap\\Face_Slap_Left3.dds", "DOMSlap", "Face", slot,0)
			else
				slap_map0b = AddTattoo(akRef, "Slapped Right 3", "DOMSlap\\Face_Slap_Right3.dds", "DOMSlap", "Face", slot,0)
			endif
		else
		;	LogTrace("Try apply slap to " + name+" no available map found")
			return
		endif
	elseif slap_level == 4
		TryRemoveCurrentSlap(true,false,true) ; remove slap a and battered
		if slap_map0a == 0
			;*ogTrace("Try apply slap to " + name+" level="+slap_level+" type="+slap_type)
			if slap_type < 3 ; type 1 and 2
				slap_map0a = AddTattoo(akRef, "Slapped Right 4", "DOMSlap\\Face_Slap_Right4.dds", "DOMSlap", "Face", slot,0)
			else
				slap_map0a = AddTattoo(akRef, "Slapped Left 4", "DOMSlap\\Face_Slap_Left4.dds", "DOMSlap", "Face", slot,0)
			endif
		else
		;	LogTrace("Try apply slap to " + name+" no available map found")
			return
		endif
	else ; if slap_level >= 5
		TryRemoveCurrentSlap(false,false,true) ; remove battered
		if slap_map0a == 0
			;*ogTrace("Try apply slap to " + name+" level="+slap_level+" type="+slap_type)
			if slap_type < 3 ; type 1 and 2
				slap_map0a = AddTattoo(akRef, "Slapped Right 4", "DOMSlap\\Face_Slap_Right4.dds", "DOMSlap", "Face", slot,0)
			else
				slap_map0a = AddTattoo(akRef, "Slapped Left 4", "DOMSlap\\Face_Slap_Left4.dds", "DOMSlap", "Face", slot,0)
			endif
		endif
		if slap_map0b == 0
			;*ogTrace("Try apply slap to " + name+" level="+slap_level+" type="+slap_type)
			if slap_type < 3 ; type 1 and 2
				slap_map0b = AddTattoo(akRef, "Slapped Left 3", "DOMSlap\\Face_Slap_Left3.dds", "DOMSlap", "Face", slot,0)
			else
				slap_map0b = AddTattoo(akRef, "Slapped Right 3", "DOMSlap\\Face_Slap_Right3.dds", "DOMSlap", "Face", slot,0)
			endif
		endif
		if slap_map1 == 0
			;*ogTrace("Try apply slap to " + name+" level="+slap_level+" type="+slap_type)
			slap_map1 = AddTattoo(akRef, "Battered", "DOMSlap\\Face_Battered.dds", "DOMSlap", "Face", slot)
		else
		;	LogTrace("Try apply slap to " + name+" no available map found")
			return
		endif
	endif

	slap_level_prev = slap_level
	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Slap")
	endif
    ;*ogTrace("Apply slap to " + name+" "+slap_map0a+" "+slap_map0b+" "+slap_map1)
EndFunction

Function TryRemoveSlap()
	;*ogTrace("TryRemoveSlap from " + name+" nhits="+slap_nhits+" timer="+slap_timer+" level="+slap_level)
	if slap_nhits == 0 && slap_map0a == 0 && slap_map0b == 0 && slap_map1 == 0
		return
	endif
	if slap_timer > 1
		slap_timer -= 1
		return
	endif
	slap_timer =  0
	if slap_nhits > 96
		slap_nhits = 64
	elseif slap_nhits > 72
		slap_nhits = 48
	elseif slap_nhits > 48
		slap_nhits = 32
	elseif slap_nhits > 24
		slap_nhits = 16
	else
		slap_nhits = 0
		slap_level = 0
		slap_level_prev = 0
		TryUpdateSlap()
		return
	endif
	slap_timer = 64
	slap_level = slap_nhits/24+1
	if slap_level > 5
		slap_level= 5
	endif
	TryUpdateSlap()
EndFunction

Function TryRemoveCurrentSlap(bool rm1a=true, bool rm1b=true, bool rm2=true)
	;*ogTrace("TryRemoveCurrentSlap from " + name+" level="+slap_level+" timer="+slap_timer+" map0a="+slap_map0a+" map0b="+slap_map0b+" map1="+slap_map1+" "+rm1a+" "+rm1b+" "+rm2)
	bool do_update = false
	
    if rm1a && slap_map0a != 0
		;*ogTrace("Try remove slap 0a from " + name+" level="+slap_level+" type="+slap_type)
		if Slavetats.remove_tattoos(akRef, slap_map0a)
			LogTrace("Failed to remove tattoo - Slap")
        endif
        JValue.release(slap_map0a)
        slap_map0a = 0   
		do_update = true		
    endif
   if rm1b && slap_map0b != 0
		;*ogTrace("Try remove slap 0b from " + name+" level="+slap_level+" type="+slap_type)
		if Slavetats.remove_tattoos(akRef, slap_map0b)
			LogTrace("Failed to remove tattoo - Slap")
        endif
        JValue.release(slap_map0b)
        slap_map0b = 0   
		do_update = true		
    endif
    if rm2 && slap_map1 != 0
		;*ogTrace("Try remove slap 1 from " + name+" level="+slap_level+" type="+slap_type)
		if Slavetats.remove_tattoos(akRef, slap_map1)
			LogTrace("Failed to remove tattoo - Slap")
        endif
        JValue.release(slap_map1)
        slap_map1 = 0   
		do_update = true		
    endif

	if !do_update
		return
	endif
	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Remove Slap")
	endif
	;*ogTrace("TryRemoveCurrentSlap removed slap from " + name+" remove level="+slap_level)
EndFunction

Function TryRemoveAllSlap()
	TryRemoveCurrentSlap()
	slap_timer = 0
	slap_level = 0
	slap_type = 0
   ;*ogTrace("Remove all slap from " + name+" timer="+slap_timer)
EndFunction

int choke_map0 = 0
int choke_timer = 0
int choke_level = 0
int choke_level_prev = 0

Function ResetChoke()
	if choke_map0 == 0
		return
	endif
	TryRemoveCurrentChoke()
	TryUpdateChoke()
EndFunction

Function TryApplyChoke()
	if actorType != 0
		return ; animal or creature
	endif
	if choke_level < 0
		choke_level = 0
	endif
	choke_level_prev = choke_level
	choke_level += 1
	if choke_level > 4
		choke_level = 4
		choke_timer += 64
	else
		choke_timer = 64
	endif
	TryUpdateChoke()
EndFunction

Function TryUpdateChoke()
	if actorType != 0
		return ; animal or creature
	endif
 	if choke_level == choke_level_prev && choke_map0 != 0
		; no changes
		return
	endif

	; Update to different choke level
	TryRemoveCurrentChoke()
	if choke_level == 0
		; no more choke mark
		return
	endif
	Int slot = -1
	bool is_female = ((actorSex%2) == 1)

	if choke_level == 1
		if is_female
			choke_map0 = AddTattoo(akRef, "Choke 1F", "DOMChoke\\choke_1F.dds", "DOMChoke", "Face", slot, 0xffffff) 
		else
			choke_map0 = AddTattoo(akRef, "Choke 1M", "DOMChoke\\choke_1M.dds", "DOMChoke", "Face", slot, 0xffffff) 
		endif
	elseif choke_level == 2
		if is_female
			choke_map0 = AddTattoo(akRef, "Choke 2F", "DOMChoke\\choke_2F.dds", "DOMChoke", "Face", slot, 0xffffff) 
		else
			choke_map0 = AddTattoo(akRef, "Choke 2M", "DOMChoke\\choke_2M.dds", "DOMChoke", "Face", slot, 0xffffff) 
		endif
	elseif choke_level == 3
		if is_female
			choke_map0 = AddTattoo(akRef, "Choke 2F", "DOMChoke\\choke_2F.dds", "DOMChoke", "Face", slot, 0xffffff) 
		else
			choke_map0 = AddTattoo(akRef, "Choke 2M", "DOMChoke\\choke_2M.dds", "DOMChoke", "Face", slot, 0xffffff) 
		endif
	else
		if is_female
			choke_map0 = AddTattoo(akRef, "Choke 4F", "DOMChoke\\choke_4F.dds", "DOMChoke", "Face", slot, 0xffffff) 
		else
			choke_map0 = AddTattoo(akRef, "Choke 4M", "DOMChoke\\choke_4M.dds", "DOMChoke", "Face", slot, 0xffffff) 
		endif
	endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Choke")
	endif
    ;*ogTrace("Apply choke to " + name+" level="+choke_level+" timer="+choke_timer+" map="+choke_map0)
EndFunction

Function TryRemoveChoke()
	if choke_timer == 0 && choke_map0 == 0
		return
	endif
	if choke_level <= 0
		choke_level = 0
		return
	endif
	if choke_timer > 0
		choke_timer -= 1
		return
	endif
	choke_level_prev = choke_level
	choke_level -= 1
	if choke_level > 0
		choke_timer = 64
	endif
	TryUpdateChoke()
EndFunction

Function TryRemoveCurrentChoke()
	;*ogTrace("Remove choke")

    if choke_map0 != 0
		if Slavetats.remove_tattoos(akRef, choke_map0)
			LogTrace("Failed to remove tattoo - Choke0")
        endif
        JValue.release(choke_map0)
        choke_map0 = 0    
	else
		return
    endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Remove Choke")
	endif
    ;*ogTrace("Remove choke from " + name)
EndFunction

Function TryRemoveAllChoke()
	TryRemoveCurrentChoke()
	choke_level = 0
    ;*ogTrace("Remove all choke from " + name+" level="+choke_level+" timer="+choke_timer)
EndFunction

int blush_map0 = 0
int drool_map0 = 0

Function ResetBlush()
	if blush_map0 != 0
		TryRemoveBlush()
		TryApplyBlush()
	endif
	if drool_map0 != 0
		TryRemoveDrool()
		TryApplyDrool()
	endif
EndFunction

Function TryApplyBlush()
	if actorType != 0
		return ; animal or creature
	endif
	bool applyBlush        = ( DOM01.blushFToggle && (actorSex%2) == 1) || ( DOM01.blushMToggle && (actorSex%2) == 0)
	if !applyBlush
		return
	endif
    ;*ogTrace("Try apply blush to " + name)
	Int slot = -1
	
	if blush_map0 == 0
		blush_map0 = AddTattoo(akRef, "Blush cheeks 1", "DOMBlush\\blush_cheeks_1.dds", "DOMBlush", "Face", slot, 0xffffff) 
	else
		return
	endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Blush")
	endif
   ;*ogTrace("Apply blush to " + name+" "+blush_map0)
EndFunction

Function TryApplyDrool()
	if actorType != 0
		return ; animal or creature
	endif
    ;*ogTrace("Try apply drool to " + name)
	Int slot = -1
	
	if drool_map0 == 0
		drool_map0 = AddTattoo(akRef, "Mouth mess 3", "DOMDrool\\mouth_mess_3.dds", "DOMDrool", "Face", slot, 0xffffff) 
	else
		return
	endif

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Drool")
	endif
    ;*ogTrace("Apply blush after orgasm to " + name+" "+drool_map0)
EndFunction

Function TryRemoveBlush()
	;*ogTrace("Remove blush")
	if blush_map0 == 0
		return
	endif
	if Slavetats.remove_tattoos(akRef, blush_map0)
		LogTrace("Failed to remove tattoo - Blush0")
    endif
    JValue.release(blush_map0)
    blush_map0 = 0    
	
	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Remove Blush")
		;*ogTrace("Failed to synchronize_tattoos")
	endif
    ;*ogTrace("Remove blush from " + name)
EndFunction

Function TryRemoveDrool()
	;*ogTrace("Remove drool")
	if drool_map0 == 0
		return
	endif
	if Slavetats.remove_tattoos(akRef, drool_map0)
		LogTrace("Failed to remove tattoo - Drool0")
    endif
    JValue.release(drool_map0)
    drool_map0 = 0 

	if Slavetats.synchronize_tattoos(akRef, true)
		LogTrace("Failed to synchronize_tattoos - Remove Drool")
		;*ogTrace("Failed to synchronize_tattoos")
	endif
    ;*ogTrace("Remove drool from " + name)
EndFunction

; ### Interactions

; Save positions of actors before animation
float[] __anim_pos_ref
float[] Property anim_pos_ref
	float[] Function Get()
		if !__anim_pos_ref
			__anim_pos_ref = new float[6]
		endif
		return __anim_pos_ref
	EndFunction
EndProperty

float[] __anim_pos_other
float[] Property anim_pos_other
	float[] Function Get()
		if !__anim_pos_other
			__anim_pos_other = new float[6]
		endif
		return __anim_pos_other
	EndFunction
EndProperty

Function SavePositions(Actor akTarget)
	anim_pos_ref[0] = akRef.GetPositionX()
	anim_pos_ref[1] = akRef.GetPositionY()
	anim_pos_ref[2] = akRef.GetPositionZ()
	anim_pos_ref[3] = akRef.GetAngleX()
	anim_pos_ref[4] = akRef.GetAngleY()
	anim_pos_ref[5] = akRef.GetAngleZ()

	if akTarget != None
		anim_pos_other[0] = akTarget.GetPositionX()
		anim_pos_other[1] = akTarget.GetPositionY()
		anim_pos_other[2] = akTarget.GetPositionZ()
		anim_pos_other[3] = akTarget.GetAngleX()
		anim_pos_other[4] = akTarget.GetAngleY()
		anim_pos_other[5] = akTarget.GetAngleZ()
	else
		anim_pos_other[0] = 0.0
		anim_pos_other[1] = 0.0
		anim_pos_other[2] = 0.0
		anim_pos_other[3] = 0.0
		anim_pos_other[4] = 0.0
		anim_pos_other[5] = 0.0
	endif
EndFunction

Function RestorePositions(Actor akTarget)
	akRef.SetPosition(anim_pos_ref[0], anim_pos_ref[1], anim_pos_ref[2])
	akRef.SetAngle(anim_pos_ref[3], anim_pos_ref[4], anim_pos_ref[5])
	if akTarget != None
		if akTarget != PlayerRef || DOM01.DOM_Anim.doPlayerAnim
			akTarget.SetPosition(anim_pos_other[0], anim_pos_other[1], anim_pos_other[2])
			akTarget.SetAngle(anim_pos_other[3], anim_pos_other[4], anim_pos_other[5])
		endif
	endif
EndFunction

Function Interact_LookAtMe(Actor akAbuser)
	if is_restrained
		FaceActor(akRef,akAbuser)
		return
	endif
	if !mind.WillObeySubdued(18) ; "didnt obey"
		ChooseAnswerNo(akAbuser)
		return
	endif
	akRef.SetLookAt(akAbuser)
	ChooseAnswerYes(akAbuser)
	FaceActor(akRef,akAbuser)
EndFunction

Function Interact_TurnAround(Actor akAbuser)
	if is_restrained
		BackActor(akRef,akAbuser)
		return
	endif
	if !mind.WillObeyTamed(18) ; "didnt obey"
		ChooseAnswerNo(akAbuser)
		return
	endif
	;akRef.SetLookAt(akAbuser)
	akRef.ClearLookAt()
	ChooseAnswerYes(akAbuser)
	BackActor(akRef,akAbuser)
EndFunction

Function Interact_ComeHere(Actor akAbuser)
	if is_restrained
		FrontActor(akRef,akAbuser)
		return
	endif
	if !mind.WillObeySubjugated(18) ; "didnt obey"
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerYes(akAbuser)
	FrontActor(akRef,akAbuser)
EndFunction

Function DoBathMe(Actor akAbuser)
	if akAbuser == None
		return
	endif
	if is_running_away
		EnterFollowPlayerOrTrainer()
	endif
	if is_showering
		return
	endif
	is_showering = true
	if !canAnimate || !canAnimateLocal
		is_showering = false
		return
	endif 
	
	; Check if actor is in the mood
	if !mind.StartBathMe(akAbuser,"bath")
		ChooseAnswerNo(akAbuser)
		is_showering = false
		return
	endif
	canAnimateLocal = false
	string beh = Behaviour
	if beh == "showering"
		beh = "wait"
	endif
	if !is_restrained
		behaviour = "showering"
	else
		canAnimate = false
	endif
	ChooseAnswerStrip(akAbuser)
	MiscObject the_soap = DOM01.DOMBath.TryFindWashProp(akRef)
	if the_soap == None
		the_soap = DOM01.DOMBath.TryFindWashProp(akAbuser)
	endif
	bool has_soap = (the_soap != None)
	wet_level = 1.0
	float mod = mind.MOD_Perfectionism
	float timer = 8.0+mod
	
	StartJSONAnimation(akAbuser,"DOMBathMe")
	Wait(timer)
	DOM01.DOMBath.SetDrip(akAbuser)
	DOM01.DOMBath.SetDrip(akAbuser)
	If has_soap
		DOM01.DOMBath.SetSoapy(akAbuser)
		DOM01.DOMBath.ApplySoapBonus(akAbuser, the_soap)
	endif
	PlayJSONAnimations(1,JSONanim_nscenes-(3))
	DOM01.DOMBath.SetDrip(akAbuser)
	DOM01.DOMBath.SetDrip(akRef)
	DOM01.DOMBath.CleanDirt(akRef,has_soap)
	TryRemoveMascaraTears()
	PlayJSONAnimation(JSONanim_nscenes - (2))
	If has_soap
		DOM01.DOMBath.SetSoapy(akRef)
		DOM01.DOMBath.ApplySoapBonus(akRef, the_soap)
	endif
	dirty_level -= 15.0+mod
	Wait(timer)
	PlayJSONAnimation(JSONanim_nscenes - (1))
	If has_soap
		DOM01.DOMBath.SetUnSoapy(akAbuser)
	endif
	DOM01.DOMBath.SetDrip(akAbuser)
	DOM01.DOMBath.SetDrip(akRef)
	dirty_level -= 25.0+mod
	Wait(timer)
	EndJSONAnimation()
	
	if (Game.GetModByName("_GSPoses.esp") != 255) ; needs GSPose
		Anim_LocalByString("GS319")
		wait(timer)
	endif
	
	if dirty_level <= 50.0
		if mind.HasNextPunishmentReason(29)
			mind.RemoveNextPunishmentReason(29) ; "being dirty"
		endif
		mind.SetNextPraiseReasonSilent(30) ; "being clean and fresh"
	endif
	mind.CheckAndRegisterKink(80,2.0) ; "being a maid"

	If has_soap
		DOM01.DOMBath.SetUnSoapy(akRef)
	endif
	DOM01.DOMBath.SetDrip(akAbuser)
	DOM01.DOMBath.SetDrip(akRef)
	
	Anim_IdleReset()
	canAnimateLocal = true
	canAnimate = true
	mind.RedressAfterShowering()
	is_showering = false
	if behaviour == "showering"
		behaviour = beh
	endif
	wait(timer)
	DOM01.DOMBath.UnSetDrip(akAbuser)
	DOM01.DOMBath.UnSetDrip(akRef)
EndFunction

Function DoShowerHose(Actor akAbuser)
	if is_running_away
		EnterFollowPlayerOrTrainer()
	endif
	if is_showering
		return
	endif
	is_showering = true
	if !canAnimate || !canAnimateLocal
		is_showering = false
		return
	endif 
	; Check if actor is in the mood
	if !mind.StartShowering(akAbuser,"hose")
		ChooseAnswerNo(akAbuser)
		DOM01.DOMBath.SetDrip(akRef)
		if is_naked
			dirty_level -= 40.0
		else
			dirty_level -= 20.0
		endif
		is_showering = false
		wait(timer)
		DOM01.DOMBath.UnSetDrip(akRef)
		return
	endif
	canAnimateLocal = false
	string beh = Behaviour
	if beh == "showering"
		beh = "wait"
	endif
	if !is_restrained
		behaviour = "showering"
	else
		canAnimate = false
	endif
	ChooseAnswerStrip(akAbuser)
	bool has_shower = false
	MiscObject the_soap = DOM01.DOMBath.TryFindWashProp(akRef)
	bool has_soap = (the_soap != None)
	if has_soap
		Anim_LocalByString("DOMBatheF_S1_Soap") ; clean armpits and crotch 
	else
		Anim_LocalByString("DOMBatheF_S1_Rag")
	endif
	if DOM01.DOMBath.ApplyWashPropSpell(akRef,the_soap) ; try to call Bathing in Skyrim
		;*ogTrace("DoShowerHose: successful call to Bathing in Skyrim")
		if has_soap
			dirty_level -= 70.0
		else
			dirty_level -= 50.0
		endif
		if behaviour == "showering"
			behaviour = beh
		endif
		canAnimateLocal = true
		is_showering = false
		if dirty_level <= 50.0
			if mind.HasNextPunishmentReason(29)
				mind.RemoveNextPunishmentReason(29) ; "being dirty"
			endif
			mind.SetNextPraiseReasonSilent(30) ; "being clean and fresh"
		endif
		return 
	endif
	
	wet_level = 1.0
	DOM01.DOMBath.CleanDirt(akRef,has_soap)
	TryRemoveMascaraTears()
	If has_soap
		DOM01.DOMBath.SetSoapy(akRef)
	endif
	float mod = mind.MOD_Perfectionism
	float timer = 8.0+mod
	if (actorSex%2) == 1 ; female
		if has_soap
			Anim_LocalByString("DOMBatheF_S1_Soap") ; clean armpits and crotch 
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 32.0+mod
			wait(timer)
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 31.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheF_S3_Soap") ; clean armpits and ass
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 31.0+mod
			wait(timer)
			if has_shower
				Anim_LocalByString("DOMBatheF_S2_Soap") ; clean hair loose soap shower rince
				DOM01.DOMBath.SetDrip(akRef)
				dirty_level -= 2.0+mod
				wait(timer)
				DOM01.DOMBath.SetDrip(akRef)
				DOM01.DOMBath.SetUnSoapy(akRef)
				dirty_level -= 2.0+mod
				wait(timer)
			endif
			DOM01.DOMBath.ApplySoapBonus(akRef, the_soap)
		else
			Anim_LocalByString("DOMBatheF_S1_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 26.0+mod
			wait(timer)
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheF_S3_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			if has_shower
				Anim_LocalByString("DOMBatheF_S2_Rag")
				DOM01.DOMBath.SetDrip(akRef)
				dirty_level -= 2.0+mod
				wait(timer)
				DOM01.DOMBath.SetDrip(akRef)
				dirty_level -= 2.0+mod
				wait(timer)
			endif
		endif
	else
		if has_soap
			Anim_LocalByString("DOMBatheM_S1_Soap") ; clean arms
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 30.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheM_S2_Soap") ; clean legs
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 30.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheM_S3_Soap") ; clean ass
			DOM01.DOMBath.SetDrip(akRef)
			DOM01.DOMBath.SetUnSoapy(akRef)
			dirty_level -= 30.0+mod
			wait(timer)
			if has_shower
				dirty_level -= 4.0+mod
			endif
			DOM01.DOMBath.ApplySoapBonus(akRef, the_soap)
		else
			Anim_LocalByString("DOMBatheM_S1_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheM_S2_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheM_S3_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			if has_shower
				dirty_level -= 4.0+mod
			endif
		endif
	endif
	
	if (Game.GetModByName("_GSPoses.esp") != 255) ; needs GSPose
		Anim_LocalByString("GS319")
		wait(timer)
	endif
	if dirty_level <= 50.0
		if mind.HasNextPunishmentReason(29)
			mind.RemoveNextPunishmentReason(29) ; "being dirty"
		endif
		mind.SetNextPraiseReasonSilent(30) ; "being clean and fresh"
	endif
	mind.CheckAndRegisterKink(15,2.0) ; "being forced to clean"

	DOM01.DOMBath.SetUnSoapy(akRef)
	DOM01.DOMBath.SetDrip(akRef)
	Anim_IdleReset()
	canAnimateLocal = true
	canAnimate = true
	mind.RedressAfterShowering()
	is_showering = false
	if behaviour == "showering"
		behaviour = beh
	endif
	wait(timer)
	DOM01.DOMBath.UnSetDrip(akRef)
EndFunction

Function DoShower(Actor akAbuser)
	;LogTrace("DoShower1 is_showering="+is_showering+" should_be_naked="+mind.should_be_naked)
	if is_showering
		return
	endif
	if is_restrained ; akRef.IsInFaction(DOM01.DOMActionTied)
		SendNotificationOrder(name+" "+actorBeVerb+" restrained and can't move enough to shower!")
		return
	endif
	if !canAnimate || !canAnimateLocal
		return
	endif 
	bool has_water = false
	bool has_shower = false
	string wash_type
	; Check waterfall and water objects
	if DOM01.DOMBath.isInWaterfall(akRef)
		SendNotificationOrder(name+" will shower under the waterfall")
		has_water = true
		has_shower = true
		wash_type = "waterfall"
	elseif DOM01.DOMBath.isInShower(akRef)
		SendNotificationOrder(name+" will shower under the shower")
		has_water = true
		has_shower = true
		wash_type = "shower"
	elseif DOM01.DOMBath.isInWater(akRef)
		SendNotificationOrder(name+" will clean "+actorObjective+"self in water")
		has_water = true
		wash_type = "bath"
	elseif !PO3_SKSEFunctions.IsActorInWater(akRef)
		;*ogTrace("wet_level = "+wet_level)
		if wet_level > 0.0
			if !canMove
				SendNotificationOrder(name+" can not move to dry "+actorObjective+"self")
				return
			endif
			bool save_idle = canIdle
			canIdle = true
			SendNotificationOrder(name+" will dry "+actorObjective+"self")
			Anim_WipeBrow()
			Wait(2.0)
			Anim_WarmArms()		
			wet_level = 0.0
			Wait(2.0)
			canIdle = save_idle
		else
			SendNotificationOrder(name+" "+actorBeVerb+" as dry as "+actorPronoun+" can be")
		endif
		return
	elseif PO3_SKSEFunctions.IsActorUnderwater(akRef)
		if akRef.IsSwimming()
			SendNotificationOrder(name+" needs to be standing in water to bathe, not swimming!")
			return
		endif
		SendNotificationOrder(name+" will clean "+actorObjective+"self under water")
		has_water = true
		wash_type = "bath"
	else
		SendNotificationOrder(name+" will clean "+actorObjective+"self in the water")
		has_water = true
		wash_type = "bath"
	endif

	; Check if actor is in the mood
	if !mind.StartShowering(akAbuser,wash_type)
		ChooseAnswerNo(akAbuser)
		return
	endif
	;LogTrace("DoShower2 is_showering="+is_showering+" should_be_naked="+mind.should_be_naked)
	canAnimateLocal = false
	string beh = Behaviour
	if beh == "showering"
		beh = "wait"
	endif
	if !is_restrained
		behaviour = "showering"
	endif
	ChooseAnswerStrip(akAbuser)
	MiscObject the_soap = DOM01.DOMBath.TryFindWashProp(akRef)
	bool has_soap = (the_soap != None)
	if has_soap
		Anim_LocalByString("DOMBatheF_S1_Soap") ; clean armpits and crotch 
	else
		Anim_LocalByString("DOMBatheF_S1_Rag")
	endif
	if DOM01.DOMBath.ApplyWashPropSpell(akRef,the_soap) ; try to call Bathing in Skyrim
		;*ogTrace("DoShower: successful call to Bathing in Skyrim")
		if has_soap
			dirty_level -= 100.0
		else
			dirty_level -= 80.0
		endif
		if behaviour == "showering"
			behaviour = beh
		endif
		canAnimateLocal = true
		if dirty_level <= 50.0
			if mind.HasNextPunishmentReason(29)
				mind.RemoveNextPunishmentReason(29) ; "being dirty"
			endif
			mind.SetNextPraiseReasonSilent(30) ; "being clean and fresh"
		endif
		return 
	endif
	
	wet_level = 1.0
	DOM01.DOMBath.CleanDirt(akRef,has_soap)
	TryRemoveMascaraTears()
	If has_soap
		DOM01.DOMBath.SetSoapy(akRef)
	endif
	float mod = mind.MOD_Perfectionism
	float timer = 8.0+mod
	if (actorSex%2) == 1 ; female
		if has_soap
			Anim_LocalByString("DOMBatheF_S1_Soap") ; clean armpits and crotch 
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 32.0+mod
			wait(timer)
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 31.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheF_S3_Soap") ; clean armpits and ass
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 31.0+mod
			wait(timer)
			if has_shower
				Anim_LocalByString("DOMBatheF_S2_Soap") ; clean hair loose soap shower rince
				DOM01.DOMBath.SetDrip(akRef)
				dirty_level -= 2.0+mod
				wait(timer)
				DOM01.DOMBath.SetDrip(akRef)
				DOM01.DOMBath.SetUnSoapy(akRef)
				dirty_level -= 2.0+mod
				wait(timer)
			endif
			DOM01.DOMBath.ApplySoapBonus(akRef, the_soap)
		else
			Anim_LocalByString("DOMBatheF_S1_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 26.0+mod
			wait(timer)
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheF_S3_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			if has_shower
				Anim_LocalByString("DOMBatheF_S2_Rag")
				DOM01.DOMBath.SetDrip(akRef)
				dirty_level -= 2.0+mod
				wait(timer)
				DOM01.DOMBath.SetDrip(akRef)
				dirty_level -= 2.0+mod
				wait(timer)
			endif
		endif
	else
		if has_soap
			Anim_LocalByString("DOMBatheM_S1_Soap") ; clean arms
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 30.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheM_S2_Soap") ; clean legs
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 30.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheM_S3_Soap") ; clean ass
			DOM01.DOMBath.SetDrip(akRef)
			DOM01.DOMBath.SetUnSoapy(akRef)
			dirty_level -= 30.0+mod
			wait(timer)
			if has_shower
				dirty_level -= 4.0+mod
			endif
			DOM01.DOMBath.ApplySoapBonus(akRef, the_soap)
		else
			Anim_LocalByString("DOMBatheM_S1_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheM_S2_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			Anim_LocalByString("DOMBatheM_S3_Rag")
			DOM01.DOMBath.SetDrip(akRef)
			dirty_level -= 25.0+mod
			wait(timer)
			if has_shower
				dirty_level -= 4.0+mod
			endif
		endif
	endif
	
	if (Game.GetModByName("_GSPoses.esp") != 255) ; needs GSPose
		Anim_LocalByString("GS319")
		wait(timer)
	endif
	if dirty_level <= 50.0
		if mind.HasNextPunishmentReason(29)
			mind.RemoveNextPunishmentReason(29) ; "being dirty"
		endif
		mind.SetNextPraiseReasonSilent(30) ; "being clean and fresh"
	endif
	mind.CheckAndRegisterKink(15,2.0) ; "being forced to clean"
	;LogTrace("DoShower3 is_showering="+is_showering+" should_be_naked="+mind.should_be_naked)
	DOM01.DOMBath.SetUnSoapy(akRef)
	DOM01.DOMBath.SetDrip(akRef)
	Anim_IdleReset()
	canAnimateLocal = true
	mind.RedressAfterShowering()
	if behaviour == "showering"
		behaviour = beh
	endif
	wait(timer)
	DOM01.DOMBath.UnSetDrip(akRef)
EndFunction

Function UndressBeforeSex(Actor akAbuser, bool do_aggro)
	canIdleSexlab = true
	LogTrace("UndressBeforeSex canIdleSexlab="+canIdleSexlab)
	mind.UndressBeforeSex(akAbuser,do_aggro)
	canIdleSexlab = false
	LogTrace("UndressBeforeSex canIdleSexlab="+canIdleSexlab)
EndFunction

Function Interact_Undress(Actor akAbuser)
	if is_naked
		SendNotificationOrder(name+" "+actorBeVerb+" already naked")
		return
	endif
	mind.StartUndressingForced(akAbuser) ; forced
	ChooseAnswerStrip(akAbuser)
	;LogTrace("Interact_Undress: start anim doPlayerAnim="+DOM01.DOM_Anim.doPlayerAnim)
	SendOrderAnimateUndress(akAbuser)
 	StripAndDrop(akAbuser)
EndFunction

Function Interact_UndressNoChoice(Actor akAbuser, bool do_anim)
	if is_naked
		return
	endif
	if akAbuser == akRef
		Interact_StripNoChoice(None,do_anim)
		return
	endif
	mind.StartUndressingForced(akAbuser) ; forced
	ChooseAnswerStrip(akAbuser)
	if do_anim
		SendOrderAnimateUndress(akAbuser)
	endif
 	StripMore()
EndFunction

Function Interact_UndressNoAnim(Actor akAbuser)
	if is_naked
		SendNotificationOrder(name+" "+actorBeVerb+" already naked")
		return
	endif
	mind.StartUndressingForced(akAbuser) ; forced
 	StripAndDrop(akAbuser)
EndFunction

Function Interact_UndressAll(Actor akAbuser)
	if is_naked
		SendNotificationOrder(name+" "+actorBeVerb+" already naked")
		return
	endif
	mind.StartUndressingForced(akAbuser) ; forced
	ChooseAnswerStrip(akAbuser)
	SendOrderAnimateUndress(akAbuser)
	StripAndDropAll(akAbuser)
EndFunction

Function Interact_Strip(Actor akAbuser)
	if is_naked
		SendNotificationOrder(name+" "+actorBeVerb+" already naked")
		return
	endif
	if akRef.IsInFaction(DOM01.DOMActionTied)
		SendNotificationOrder(name+" "+actorBeVerb+" restrained and can't move enough to undress!")
		return
	endif
	; Check if actor is in the mood
	if !mind.StartUndressing(akAbuser) ; order (not forced)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerStrip(akAbuser)
	SendOrderAnimateStrip()
 	StripMaybeDrop(akAbuser)
EndFunction

Function Interact_StripNoChoice(Actor akAbuser, bool do_anim)
	if is_naked
		return
	endif
	if  akAbuser != akRef
		ChooseAnswerStrip(akAbuser)
		if do_anim && ! akRef.IsInFaction(DOM01.DOMActionTied)
			SendOrderAnimateStrip()
		endif
	endif
 	StripMore()
EndFunction

Function Interact_StripAll(Actor akAbuser)
	if akRef.IsInFaction(DOM01.DOMActionTied)
		SendNotificationOrder(name+" "+actorBeVerb+" restrained and can't move enough to undress!")
		return
	endif
	; Check if actor is in the mood
	if !mind.StartUndressing(akAbuser) ; order (not forced)
		ChooseAnswerNo(akAbuser)
		return
	endif
	ChooseAnswerStrip(akAbuser)
	SendOrderAnimateStrip()
	StripMaybeDropAll(akAbuser)
EndFunction

Function Interact_Praise(Actor akAbuser, string reason_name, string the_key)
	LogTrace("Interact_Praise key="+the_key+" reason="+reason_name)
	interact_is_busy = true
	if the_key == ""
		the_key = DOM01.DefaultPraiseType
	endif

	bool is_success = mind.StartPraising(akAbuser,reason_name,the_key)

	if the_key == "tell" ; use words for praising
		if is_success
			ChooseAnswerThanks(akAbuser)
			mind.CheckAndRegisterKink(14,0.25) ; "being called a good girl"
		else
			ChooseAnswerBad(akAbuser)
		endif
		interact_is_busy = false
		return
	endif

	int index       = DOM01.GetJSONPraisingTypeIndexByName(the_key)
	bool do_bounded = false
	string anim_key
	if is_bounded
		anim_key = DOM01.GetJSONPraisingTypeAnimBoundedByIndex(index)
		if anim_key == ""
			anim_key = DOM01.GetJSONPraisingTypeAnimByIndex(index)
		else
			do_bounded = true
		endif
	else
		anim_key = DOM01.GetJSONPraisingTypeAnimByIndex(index)
	endif

	StartJSONAnimation(akAbuser,anim_key)
	if is_success
		PlayJSONAnimation(2)
		if the_key == "grope ass"
			ChooseAnswerTouchButt(akAbuser)
			mind.CheckAndRegisterKink(79,0.5) ; "being groped"
		elseif the_key == "hold chin"
			ChooseAnswerTouchBegin(akAbuser)
			mind.CheckAndRegisterKink(76,0.5) ; "being held by the chin"
		elseif the_key == "pat cheek"
			ChooseAnswerTouchBegin(akAbuser)
			mind.CheckAndRegisterKink(77,0.5) ; "being patted on the cheek"
		elseif the_key == "pat head"
			ChooseAnswerTouchBegin(akAbuser)
			mind.CheckAndRegisterKink(78,0.5) ; "being patted on the head"
		elseif stringUtil.find(the_key,"kiss")>=0 ; if the_key == "Love" "Side" "Short" "Long" "Forced" "Dominant"
			ChooseAnswerTouchBegin(akAbuser)
			mind.CheckAndRegisterKink(30,0.5) ; "being kissed"
		else
			ChooseAnswerTouchBegin(akAbuser)
		endif
		PlayJSONAnimations(3,JSONanim_nscenes-(1))
	else
		PlayJSONAnimation(1)
		ChooseAnswerBad(akAbuser)
	endif
	EndJSONAnimation()
	interact_is_busy = false
EndFunction

Function Interact_Punish(Actor akAbuser, string reason_name, string the_key)
	LogTrace("Interact_Punish type="+the_key+" reason="+reason_name)
	if the_key == ""
		the_key = DOM01.DefaultPunishmentType
	endif

	if the_key == "rape" 
		Anim_Sexlab(akAbuser, "", true, reason_name) ; sex punishment with no tag
		return
	elseif the_key == "scold"
		StartScolding(akAbuser,reason_name)
		return
	elseif the_key == "pain"
		StartPunishingByActor(akAbuser,reason_name,the_key)
		return
	endif
	
	interact_is_busy = true

	if reason_name == ""
		reason_name = "being disrespectful"
	endif
	bool do_bounded = false
	int index       = DOM01.GetJSONPunishmentTypeIndexByName(the_key)
	string anim_key
	if is_bounded
		anim_key = DOM01.GetJSONPunishmentTypeAnimBoundedByIndex(index)
		if anim_key == ""
			anim_key = DOM01.GetJSONPunishmentTypeAnimByIndex(index)
		else
			do_bounded = true
		endif
	else
		anim_key = DOM01.GetJSONPunishmentTypeAnimByIndex(index)
	endif
	string tats_key
	if do_bounded
		tats_key = DOM01.GetJSONPunishmentTypeTatsBoundedByIndex(index)
	else
		tats_key = DOM01.GetJSONPunishmentTypeTatsByIndex(index)
	endif
	StartPunishingByActor(akAbuser,reason_name,the_key)
	if mind.IsDevoted()
		ChooseAnswerYes(akAbuser)
	else
		ChooseAnswerWhat(akAbuser)
	endif
	
	LogTrace("Interact_Punish anim="+anim_key+" tats="+tats_key)
	StartJSONAnimation(akAbuser,anim_key, do_bounded)
	if tats_key == "choke"
		LogTrace("Interact_Punish TryApplyChoke")
		TryApplyChoke()
		ChooseAnswerTouchNeck(akAbuser)
	elseif tats_key == "spank"
		LogTrace("Interact_Punish TryApplySpank")
		TryApplySpank()
		ChooseAnswerTouchButt(akAbuser)
	elseif tats_key == "slap face"
		LogTrace("Interact_Punish TryApplySlap")
		TryApplySlap()
		ChooseAnswerTouchBegin(akAbuser)
	elseif tats_key == "slap boobs"
		LogTrace("Interact_Punish TryApplySlapBoobs")
		TryApplySlapBoobs()
		ChooseAnswerTouchBreast(akAbuser)
	else
		ChooseAnswerSorry(akAbuser)
	endif
	PlayJSONAnimation(1)
	EndPunishing(akAbuser,the_key)
	
	if the_key == "public humiliation"
		mind.CheckAndRegisterKink(5,0.5) ; "being publicly humiliated"
		StartThreatening(akAbuser,reason_name)
	endif
	if tats_key == "choke"
		mind.CheckAndRegisterKink(6,0.5) ; "being choked"
		if the_key != "public humiliation"
			StartThreatening(akAbuser,reason_name)
		endif
	elseif tats_key == "spank"
		mind.CheckAndRegisterKink(3,0.5) ; "being spanked"
	elseif tats_key == "slap face"
		mind.CheckAndRegisterKink(38,0.5) ; "being slapped on the face"
	elseif tats_key == "slap boobs"
		mind.CheckAndRegisterKink(39,0.5) ; "being slapped on the tits"
	endif
	PlayJSONAnimations(2,JSONanim_nscenes-(1))

	EndJSONAnimation()
	mind.MakeSadFor(5.0)
	interact_is_busy = false
EndFunction

bool Property is_group_order = false Auto Hidden
Function Interact_StartSalute(Actor akAbuser, string the_pose)
	string salute_type
	if the_pose == DOM01.kneelPose
		if IsRestrainedCantKneel()
			return
		endif
		salute_type = "kneel"
	else
		if is_restrained
			return
		endif
		salute_type = "stand"
	endif
	if !akRef.Is3DLoaded()
		return
	endif
	if !canAnimate
		return
	endif
	
	string kneelPose
	if behaviour == "tied" 
		if isTiedCanKneel()
			kneelPose = DOM01.DOM_Anim.GetTieupSalute(self)
		else 	
			return
		endif
	elseif the_pose == ""
		kneelPose = DOM01.kneelPose
	else
		kneelPose = the_pose
	endif

	if !mind.WillObeySubjugated(13) ; "being disrespectful"
		ChooseAnswerNo(akAbuser)
		if akAbuser == PlayerRef ; player
			DOM01.DOM04.NotifyStartSalute(self,salute_type,is_group_order,false)
			SendExternalEventSSSB("Salute",salute_type,kneelPose,false)
		endif
		return
	endif
	ChooseAnswerYes(akAbuser)
	prevQuietPose = quietPose
	quietPose = kneelPose
	is_attentive = true
	FaceActor(akRef,akAbuser)

	LogAnim("Interact_StartSalute="+kneelPose)	
	if DOM01.kneelPoseOn
		SetPose(kneelPose,10)
		behaviour = "pose" 	
	else
		Anim_LocalByString(kneelPose)
		canAnimateLocal = false
		Wait(4.0*DOM01.anim_speed_sec)
	endif
	float trainer_mod = DOM01.GetPersuaderModifier(akAbuser)
	if salute_type == "kneel"
		mind.CheckAndRegisterKink(12,0.5) ; "being forced to kneel"
		float amount = DOM01.train_speed_tell*0.075*trainer_mod
		mind.TrainRespect(amount)
		mind.TrainHumiliation(amount)
	else
		mind.CheckAndRegisterKink(13,0.5) ; "being forced to salute"
		float amount = DOM01.train_speed_tell*0.075*trainer_mod
		mind.TrainRespect(amount)
		mind.TrainSubmission(amount)
	endif
	if akAbuser == PlayerRef ; player
		DOM01.DOM04.NotifyStartSalute(self,salute_type,is_group_order,true)
		SendExternalEventSSSB("Salute",salute_type,kneelPose,true)
	endif
	DOM01.TrainSkillPersuader(akAbuser,0.5)
EndFunction

Function Interact_EndSalute(string the_pose)
	canAnimateLocal = true
	quietPose = prevQuietPose
	is_attentive = false
	if the_pose == DOM01.kneelPose
		if IsRestrainedCantKneel()
			return
		endif
	elseif is_restrained
		return
	endif
	if !akRef.Is3DLoaded()
		return
	endif
	if !canAnimate
		return
	endif
	if isTiedCanKneel() || is_behaviour_pose || is_behaviour_masturbate
		Anim_LocalByString(quietPose)
		return
	endif
	if !canMove
		return
	endif
	Anim_IdleReset()
EndFunction

Function Interact_Kiss(Actor akAbuser, string the_key)
	if is_restrained
		return
	endif
	
	string beh = behaviour
	float x
	float y
	string anim_key
	if the_key == "Forced"
		x = mind.GetForcedEffect()
		y = 50.0
		anim_key = "DOMKissForced"
	elseif the_key == "Dominant"
		x = mind.GetDominatedEffect()
		y = 100.0
		anim_key = "DOMKissDominant"
	elseif the_key == "Short"
		x = mind.GetDegradedEffect()
		y = 120.0
		anim_key = "DOMKissShort"
	elseif the_key == "Side"
		x = mind.GetSubduedEffect()
		y = 150.0
		anim_key = "DOMKissSide"
	elseif the_key == "Long"
		x = mind.GetObjectifiedEffect()
		y = 200.0
		anim_key = "DOMKissLong"
	elseif the_key == "Love"
		x = mind.GetTamedEffect()
		y = 400.0
		anim_key = "DOMKissLove"
	else 
		x = mind.GetAbusedEffect()
		y = 100.0
		anim_key = "DOMKiss"+the_key
	endif
	LogTrace("Starting Kiss animation "+anim_key)
	StartJSONAnimation(akAbuser,anim_key)
	bool choose_not = !mind.IsObedient() && RandomFloat()*y > x

	if choose_not
		int was_warned = mind.WillObeyBecauseWarned(21) ; no_sex
		if was_warned < 0
			ChooseAnswerNo(akAbuser)
			mind.SetNextPunishmentReasonForceMessage(18,"won't let you touch "+actorObjective) ; "didnt obey"
			PlayJSONAnimation(1)
			EndJSONAnimation()
			behaviour = beh
			if akAbuser == PlayerRef ; player
				DOM01.DOM04.NotifyEndKiss(self,the_key,"",false)
				SendExternalEventSSSB("Kissed",the_key,"",false)
			endif
			return
		elseif was_warned == 0
			ChooseAnswerNo(akAbuser)
			mind.SetNextPunishmentReasonForceMessage(18,"won't let you touch "+actorObjective+" in spite of your warning") ; "didnt obey"
			PlayJSONAnimation(1)
			EndJSONAnimation()
			mind.IncreaseArousal(2.5,mind.MOD_Discipline)
			behaviour = beh
			if akAbuser == PlayerRef ; player
				DOM01.DOM04.NotifyEndKiss(self,the_key,"",false)
				SendExternalEventSSSB("Kissed",the_key,"",false)
			endif
			return
		else
			SendNotificationOrder(name+" remembers your warning and gets in position")	
		endif	
	else	
		if mind.IsScaredToObey()
			SendNotificationOrder(name+" "+actorBeVerb+" too afraid to move away")	
		elseif mind.IsDevoted()
			SendNotificationOrder(name+" gets in position like a good slave")	
		else
			SendNotificationOrder(name+" seems a bit wary of you as you approach")	
		endif
	endif
	ChooseAnswerYes(akAbuser)

	float mod = DOM01.GetDeceiverModifier(akAbuser)
	mind.StartSexualAbuse()
	mind.TrainSubmission(DOM01.train_speed_tell*mod*0.10) ; submission
	
	float bonus = 0.0
	string level_type = ""
	string level_punc = ""
	if RandomFloat() < mind.MOD_Oral ||	RandomFloat()*100.0 < mind.oral_training
		mind.hadOralSex = true
		mind.TrainOral(DOM01.train_speed_tell*mod*0.05)	
		SendNotification(name+" unconsciously parts "+actorPossessive+" lips")
		bonus += 0.025
		mind.IncreaseArousal(2.5,mind.MOD_Oral)
		level_type = "I couldn't help but opened my mouth unwillingly"
		level_punc = ", and "
	endif
	PlayJSONAnimation(2)
	if JSONanim_nscenes > 3 && (RandomFloat()*100.0 < mind.FACET_Sensuality || RandomFloat()*100.0 < mind.submission)
		ChooseAnswerTouchBegin(akAbuser)
		mind.hadOralSex = true
		SendNotification(name+" shivers as you hold "+actorObjective)
		bonus += 0.025
		mind.IncreaseArousal(2.5,mind.MOD_Daring)
		level_type += level_punc+"I started to shiver as soon as "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" hands touched my body"
		level_punc = ". Then"
	endif
	PlayJSONAnimation(3)
	if JSONanim_nscenes > 4 && (RandomFloat() < mind.MOD_Vaginal || RandomFloat()*100.0 < mind.vaginal_training)
		ChooseAnswerTouchBegin(akAbuser)
		mind.hadOralSex = true
		mind.TrainVaginal(DOM01.train_speed_tell*mod*0.05)	
		SendNotification(name+"'s crotch slowly moves closer to yours")
		bonus += 0.025
		mind.IncreaseArousal(5.0,mind.MOD_Vaginal)
		level_type += level_punc+"I felt some warmth coming from inside my crotch"
		level_punc = ", "
	endif
	PlayJSONAnimation(4)
	if mind.HasHiddenKink(30)
		mind.CheckAndRegisterKink(30,2.0) ; "being kissed"
		bonus += 0.25
	endif
	if bonus <= 0.0
	    SendNotification("Kissing an unwilling "+name)
		if the_key == "Forced"
			level_type += level_punc+"It was like kissing a mammoth, I guess."
		elseif the_key == "Dominant"
			level_type += level_punc+"It was like kissing a smelly old troll, I guess."
		elseif the_key == "Short"
			level_type += level_punc+"It was like kissing a mud crab, I guess."
		elseif the_key == "Long"
			level_type += level_punc+"It was like kissing a giant slug, I guess."
		else
			level_type += level_punc+"It was like kissing a dead skeever, I guess."
		endif
	elseif mind.IsArousedAfterSex(mind.FACET_Sensuality/500.0+bonus)
		ChooseAnswerAroused(akAbuser)
		PlayJSONAnimation(5)
		SendNotification(name+" cannot hide "+actorPossessive+" arousal")
		if the_key == "Forced"
			level_type += level_punc+"it was so hot!"
		elseif the_key == "Dominant"
			level_type += level_punc+"it was... A revelation!"
		elseif the_key == "Short"
			level_type += level_punc+"it was nice but a bit too short!"
		elseif the_key == "Long"
			level_type += level_punc+"I am still shivering!"
		else
			level_type += level_punc+"it was not bad at all!"
		endif
	else
	    SendNotification("Kissing "+mind.GetMoodNameThirdPerson()+name+" with a "+the_key+" kiss")
		level_type += level_punc+"it was interesting..."
		PlayJSONAnimation(5)
	endif
	
	PlayJSONAnimations(6,JSONanim_nscenes-(1))
	EndJSONAnimation()
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillDeceiver(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(44) ; "being a devoted slaver"
		akAggressorMind.CheckAndRegisterKink(104,1.0) ; "breaking slaves"
	else
		if akAbuser == PlayerRef
			DOM01.DOM04.NotifyEndKiss(self,the_key,level_type,true)
			SendExternalEventSSSB("Kissed",the_key,level_type,true)
			DOM01.DOMPlayerAlias.HasFlingWith(self)
		endif
		DOM01.TrainSkillDeceiver(akAbuser,0.5)
	endif
	behaviour = beh
EndFunction

Function Interact_Grab(Actor akAbuser, string the_key)
	if is_restrained
		return
	endif
	
	string beh = behaviour
	float x
	float y
	string anim_key
	if the_key == "Front"
		x = mind.GetSubjugatedEffect()
		y = 100.0
		anim_key = "DOMGrabFront"
	elseif the_key == "Back"
		x = mind.GetForcedEffect()
		y = 80.0
		anim_key = "DOMGrabBack"
	elseif the_key == "Floor"
		x = mind.GetDominatedEffect()
		y = 66.0
		anim_key = "DOMGrabFloor"
	else
		x = mind.GetAbusedEffect()
		y = 75.0
		anim_key = "DOMGrab"+the_key
	endif
	LogTrace("Starting Grab animation "+anim_key)
	StartJSONAnimation(akAbuser,anim_key)
	bool choose_not = !mind.IsObedient() && RandomFloat()*y > x

	if choose_not
		int was_warned = mind.WillObeyBecauseWarned(21,0.5) ; no_sex
		if was_warned < 0
			ChooseAnswerNo(akAbuser)
			mind.SetNextPunishmentReasonForceMessage(18,"won't let you touch "+actorObjective) ; "didnt obey"
			PlayJSONAnimation(1)
			EndJSONAnimation()
			behaviour = beh
			if akAbuser == PlayerRef ; player
				DOM01.DOM04.NotifyEndCheck(self,the_key,"",false)
				SendExternalEventSSSB("BodyInspection",the_key,"",false)
			endif
			return
		elseif was_warned == 0
			ChooseAnswerNo(akAbuser)
			mind.SetNextPunishmentReasonForceMessage(18,"won't let you touch "+actorObjective+" in spite of your warning") ; "didnt obey"
			PlayJSONAnimation(1)
			EndJSONAnimation()
			mind.IncreaseArousal(5.0,mind.MOD_Discipline)
			behaviour = beh
			if akAbuser == PlayerRef ; player
				DOM01.DOM04.NotifyEndCheck(self,the_key,"",false)
				SendExternalEventSSSB("BodyInspection",the_key,"",false)
			endif
			return
		else
			if the_key == "Floor"
				SendNotificationOrder(name+" remembers your warning and lays down")	
			else
				SendNotificationOrder(name+" remembers your warning and gets in position")	
			endif
		endif	
	else	
		if mind.IsScaredToObey()
			SendNotificationOrder(name+" "+actorBeVerb+" too afraid to move away")	
		elseif mind.IsDevoted()
			SendNotificationOrder(name+" gets in position like a good slave")	
		else
			SendNotificationOrder(name+" seems a bit wary of you as you approach")	
		endif
	endif
	ChooseAnswerYes(akAbuser)

	float amount = DOM01.train_speed_tell*0.05*DOM01.GetDepraverModifier(akAbuser)
	mind.StartSexualAbuse()
	if the_key == "Front"
		mind.TrainRespect(amount) ; respect
	elseif the_key == "Back"
		mind.TrainFear(amount)    ; fear
	else
		mind.TrainAnger(amount)   ; anger
	endif
	mind.TrainSubmission(amount)  ; submission
	mind.MakeAshamedFor(amount)   ; humiliation
	
	float bonus = 0.0
	string level_type = ""
	string level_punc = ""
	if RandomFloat()*100.0 < mind.FACET_Sensuality	
		ChooseAnswerTouchBegin(akAbuser)
		if the_key == "Back"
			SendNotification(name+" shivers as you tighten your grasp")
		else
			SendNotification(name+" shivers as your hand approaches")
		endif
		bonus += 0.05
		mind.IncreaseArousal(5.0,mind.MOD_Naivety)
		level_type = "I started to shiver as soon as "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" hands touched my body"
		level_punc = ". Then "
	endif
	PlayJSONAnimation(2)
	if JSONanim_nscenes > 3 && (RandomFloat()*100.0 < mind.humiliation)
		ChooseAnswerTouchBreast(akAbuser)
		if the_key == "Front"
			SendNotification(name+"'s nipples perk up")
		else
			SendNotification(name+"'s pointy nipples stiffen")
		endif
		bonus += 0.05
		mind.IncreaseArousal(10.0,mind.MOD_Daring)
		level_type += level_punc+"my nipples started to point towards "+DOM01.DOMPlayerAlias.GetPlayerObjective()
		level_punc = ", and "
	endif
	PlayJSONAnimation(3)
	if JSONanim_nscenes > 4 && (RandomFloat() < mind.MOD_Anal)
		mind.hadAnalSex = true
		mind.TrainAnal(amount)	
		ChooseAnswerTouchButt(akAbuser)
		SendNotification(name+" spontaneously arches "+actorPossessive+" back")
		bonus += 0.05
		mind.IncreaseArousal(5.0,mind.MOD_Anal)
		level_type += level_punc+DOM01.DOMPlayerAlias.GetPlayerPronoun()+" put "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" hands around me, my back arched and I felt my ass stiffening"
		level_punc = ". "
	endif
	PlayJSONAnimation(4)
	if JSONanim_nscenes > 5 && (RandomFloat() < mind.MOD_Oral)
		mind.hadOralSex = true
		mind.TrainOral(amount)	
		if the_key == "Front"
			SendNotification(name+" unconsciously parts "+actorPossessive+" lips")
		elseif the_key == "Back"
			SendNotification(name+" gasps as your hand approaches "+actorPossessive+" thighs")
		else
			SendNotification(name+" unconsciously opens "+actorPossessive+" mouth")
		endif
		bonus += 0.05
		mind.IncreaseArousal(5.0,mind.MOD_Oral)
		level_type += level_punc+"my mouth opened almost unconscientiously"
		level_punc = ". "
	endif	
	PlayJSONAnimation(5)
	if JSONanim_nscenes > 6 && (RandomFloat() < mind.MOD_Vaginal)
		mind.hadVaginalSex = true
		mind.TrainVaginal(amount)	
		ChooseAnswerTouchBase(akAbuser)
		if ((actorSex%2) == 0)
			SendNotification(name+"'s crotch feels stiff and warm")
		else
			SendNotification(name+"'s vagina feels nice and warm")
		endif
		bonus += 0.05
		mind.IncreaseArousal(5.0,mind.MOD_Vaginal)
		level_type += level_punc+"I felt some warmth coming from inside my crotch"
		level_punc = ", "
	endif
	PlayJSONAnimation(6)
	if mind.IsAVirgin()
		SendNotification(name+" certainly feels like a virgin")
		bonus += 0.05
		PlayJSONAnimation(7)
		mind.IncreaseArousal(5.0,mind.MOD_Daring)
		level_type += level_punc+" and the movement of "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" fingers became more and more precise."
		level_type += " It was clear "+DOM01.DOMPlayerAlias.GetPlayerPronoun()+" knew I am a virgin."
		level_punc = ". "
	endif
	if mind.HasHiddenKink(72)
		mind.CheckAndRegisterKink(72,2.0) ; "being handled and checked"
		bonus += 0.25
	endif

	if bonus == 0.0
	    SendNotification("Checking "+ mind.GetMoodNameThirdPerson()+name+"'s intimate parts ")
		if !mind.IsDevoted()
			PlayJSONAnimation(8)
		else
			PlayJSONAnimation(9)
		endif
		if the_key == "Front"
			level_type = "I felt nothing more than a slight breeze of air."
		elseif the_key == "Back"
			level_type = "Nothing, I felt absolutely nothing."
		else
			level_type = "The joke is on "+DOM01.DOMPlayerAlias.GetPlayerObjective()+", I felt almost nothing."
		endif
	elseif mind.IsArousedAfterSex(mind.FACET_Sensuality/100.0+bonus)
		ChooseAnswerAroused(akAbuser)
		SendNotification(name+" cannot hide "+actorPossessive+" arousal")
		if mind.IsOrgasmingAfterArousal((mind.MOD_Daring+bonus)*0.2)
			ChooseAnswerOrgasm(akAbuser)
			SendExternalEventSS("Orgasm","grab")
			DOM01.DOM04.NotifyOrgasm(self,"grab",mind.should_be_noorgasm,mind.was_allowed_toorgasm,true)
			level_type += level_punc+"Then, suddenly, my world exploded and now I just want more of it!"
			PlayJSONAnimation(10)
		else
			level_type += level_punc+"I feel so hot now!"
			PlayJSONAnimation(9)
		endif
	else
		level_type += "."
		PlayJSONAnimation(9)
	endif
	
	PlayJSONAnimations(11,JSONanim_nscenes-(1))
	EndJSONAnimation()
	if akAbuser == PlayerRef ; player
		DOM01.DOM04.NotifyEndCheck(self,the_key,level_type,true)
		SendExternalEventSSSB("BodyInspection",the_key,level_type,false)
		DOM01.DOMPlayerAlias.HasChatWith(self)
	endif
	DOM01.TrainSkillDepraver(akAbuser,0.5)
	behaviour = beh
EndFunction

; ### Alter effects

Function Alter_Mood(string this_mood)
	mind.mood = this_mood
EndFunction

Function Alter_Lust(Actor akAbuser, float amount)
	;*ogTrace("alter lush amount = "+amount)

	ChooseAnswerAroused(akAbuser)
	mind.IncreaseArousalMagic(amount)
	if amount>0
		SendNotificationAbuse(name+"'s cheeks got red for a short while")
		;SendNotificationAbuse("Boosting "+name+"'s lust by "+amount)
	elseif amount<0
		;SendNotificationAbuse("Shrinking "+name+"'s lust by "+amount)
		SendNotificationAbuse(name+" doesn't feel so horny anymore")
	else
		SendNotificationAbuse("Lust spell has no effect on "+name)
	endif
EndFunction

Function Alter_Pain(float amount)
	;LogTrace(getName()+" alter pain amount = "+amount)

	mind.IncreasePainForced(amount)
	if amount>0
		SendNotificationAbuse(getName()+" shivers for a short while")
		;SendNotificationAbuse("Boosting "+getName()+"'s pain by "+amount)
	elseif amount<0
		SendNotificationAbuse(getName()+" doesn't feel so sensitive anymore")
		;SendNotificationAbuse("Shrinking "+getName()+"'s pain by "+amount)
	else
		SendNotificationAbuse("Lash spell has no effect on "+getName())
	endif
EndFunction

Function Alter_Persona(float amount)
	;*ogTrace("alter persona amount = "+amount)

	mind.IncreasePersonaForced(amount)
	if amount>0
		SendNotificationAbuse(name+"'s eyes blink for a short while")
		;SendNotificationAbuse("Boosting "+name+"'s personna ("+amount+")")
	elseif amount<0
		SendNotificationAbuse(name+"'s eyes got dull for a short while")
		;SendNotificationAbuse("Shrinking "+name+"'s personna ("+amount+")")
	else
		SendNotificationAbuse("Persona spell has no effect on "+name+"'s personna")
	endif
EndFunction

Function Alter_Training(float amount)
	;;*ogTrace("subjugate amount = "+amount)

	mind.TrainAll(amount)
	if mind.submission<34.0
		SendNotificationAbuse(name+" looks down for a short while")
	elseif mind.submission<70.0
		SendNotificationAbuse(name+" looks down for a while")
	elseif mind.submission<100.0
		SendNotificationAbuse(name+" looks down in submission")
	else
		SendNotificationAbuse(name+" looks down in total submission")
	endif

	;DOM01.DOMGenerator.Printmind.Training(akRef)
EndFunction

Function Alter_Virginity()
	mind.RecoverVirginity()
	
	SendNotificationAbuse(name+"'s cheeks went red for a short while")
	;SendNotificationAbuse(name+"'s virginity has been restored")
EndFunction

; ### Restore effects

Function Restore_Persona()
	mind.RestorePersonality()
	SendNotificationAbuse(name+"'s eyes blink for a short while")
	;SendNotificationAbuse(name+"'s personality has been restored")
EndFunction

; ### Potions

bool Function GetObjectFrom(Actor akAbuser, Form the_form)
	if akAbuser == None
		return false
	endif
	if akAbuser.getItemCount(the_form) <= 0
		return false
	endif
	akAbuser.RemoveItem(the_form,1, akOtherContainer = akRef)
	int nb = akRef.getItemCount(the_form)
	if nb <= 0
		return false
	endif
	return true
EndFunction

bool Function GetFromOwnerIfNeededAndEquipObject(Actor akAbuser, Form the_form)
	wait_for_equipment = true
	int nb = akRef.getItemCount(the_form)
	if nb <=0 
		 if !GetObjectFrom(akAbuser,the_form)
			wait_for_equipment = false
			return false
		endif
		nb = akRef.getItemCount(the_form)
		if nb <= 0
			wait_for_equipment = false
			return false
		endif
	endif
	
	if akRef.IsEquipped(the_form)
		if DOM01.DOMEquip.IsItemDevice(the_form) || DOM01.DOMEquip.IsItemSpecial(the_form)
			UnEquipItemTight(akRef,the_form)
		else
			UnEquipItemLoose(akRef,the_form)
		endif
	endif
	if DOM01.DOMEquip.IsItemDevice(the_form) || DOM01.DOMEquip.IsItemSpecial(the_form)
		EquipItemLoose(akRef,the_form)
	else
		EquipItemTight(akRef,the_form)
	endif
	wait_for_equipment = false
	return true
EndFunction

Function DrinkLovePotion(Actor akAbuser)
	if !GetFromOwnerIfNeededAndEquipObject(akAbuser,DOM01.DOMLovePotion)
		return
	endif
	bool play_dual = !(mind.IsDevoted()) && DOM01.dualAnimToggle && !is_group_order && akAbuser != None
	if play_dual
		StartJSONAnimation(akAbuser,"DOMDrinkLovePotion")
		if !mind.IsDevoted()
			PlayJSONAnimation(1)
		else
			PlayJSONAnimations(2,JSONanim_nscenes-(1))
		endif
		EndJSONAnimation()
	elseif canMove
		Anim_LocalByString(DOM01.DOM_Anim.GetDrinkLovePotionPose(self))
		Wait(10.0*DOM01.anim_speed_sec)
	endif
	SendNotificationAbuse(name+" falls under your charm")
	if canMove
		if (RandomFloat()*100.0 > mind.FACET_Wilfulness || RandomFloat()*100.0 > mind.FACET_Submissivity)
			Anim_LocalByString(DOM01.DOM_Anim.GetCoughPose(self))
		endif
	endif
EndFunction

Function DrinkLustPotion(Actor akAbuser)
	if !GetFromOwnerIfNeededAndEquipObject(akAbuser,DOM01.DOMLustPotion)
		return
	endif
	bool play_dual = !(mind.IsDevoted()) && DOM01.dualAnimToggle && !is_group_order && akAbuser != None
	if play_dual
		StartJSONAnimation(akAbuser,"DOMDrinkLustPotion")
		if !mind.IsDevoted()
			PlayJSONAnimation(1)
		else
			PlayJSONAnimations(2,JSONanim_nscenes-(1))
		endif
		EndJSONAnimation()
	elseif canMove
		Anim_LocalByString(DOM01.DOM_Anim.GetDrinkLustPotionPose(self))
		Wait(10.0*DOM01.anim_speed_sec)
	endif
	SendNotificationAbuse(name+"'s skin becomes red as blood flow increases in "+actorPossessive+" intimate parts")
	if canMove
		if (RandomFloat()*100.0 > mind.FACET_Wilfulness || RandomFloat()*100.0 > mind.FACET_Sensuality)
			Anim_LocalByString(DOM01.DOM_Anim.GetCoughPose(self))
		endif
	endif
EndFunction

Function DrinkLashPotion(Actor akAbuser)
	if !GetFromOwnerIfNeededAndEquipObject(akAbuser,DOM01.DOMPainPotion)
		return
	endif
	bool play_dual = !(mind.IsDevoted()) && DOM01.dualAnimToggle && !is_group_order && akAbuser != None
	if play_dual
		StartJSONAnimation(akAbuser,"DOMDrinkLashPotion")
		if !mind.IsDevoted()
			PlayJSONAnimation(1)
		else
			PlayJSONAnimations(2,JSONanim_nscenes-(1))
		endif
		EndJSONAnimation()
	elseif canMove
		Anim_LocalByString(DOM01.DOM_Anim.GetDrinkLashPotionPose(self))
		Wait(10.0*DOM01.anim_speed_sec)
	endif
	SendNotificationAbuse(name+"'s face becomes white as fear of pain overflows "+actorPossessive+" brain")
	if canMove
		if (RandomFloat()*100.0 > mind.FACET_Wilfulness || RandomFloat()*100.0 > mind.FACET_Toughness)
			Anim_LocalByString(DOM01.DOM_Anim.GetCoughPose(self))
		endif
	endif
EndFunction

Function DrinkMindPotion(Actor akAbuser)
	if !GetFromOwnerIfNeededAndEquipObject(akAbuser,DOM01.DOMBrokenPotion)
		return
	endif
	bool play_dual = !(mind.IsDevoted()) && DOM01.dualAnimToggle && !is_group_order && akAbuser != None
	if play_dual
		StartJSONAnimation(akAbuser,"DOMDrinkMindPotion")
		if !mind.IsDevoted()
			PlayJSONAnimation(1)
		else
			PlayJSONAnimations(2,JSONanim_nscenes-(1))
		endif
		EndJSONAnimation()
	elseif canMove
		Anim_LocalByString(DOM01.DOM_Anim.GetDrinkMindPotionPose(self))
		Wait(10.0*DOM01.anim_speed_sec)
	endif
	SendNotificationAbuse(name+" "+actorBeVerb+" now under your control")
	if canMove
		if (RandomFloat()*100.0 > mind.FACET_Wilfulness || RandomFloat()*100.0 > mind.FACET_Boldness)
			Anim_LocalByString(DOM01.DOM_Anim.GetCoughPose(self))
		endif
	endif
EndFunction

Function DrinkNarcoticPotion(Actor akAbuser, Form the_drink)
	if !GetFromOwnerIfNeededAndEquipObject(akAbuser,the_drink)
		return
	endif
	bool is_devoted = mind.IsDevoted()
	if actorRace == 40 ; Khajiit
		is_devoted = true ; Khajiits are devoted for Skooma
	endif
	bool play_dual = !(is_devoted) && DOM01.dualAnimToggle && !is_group_order && akAbuser != None
	if play_dual
		StartJSONAnimation(akAbuser,"DOMDrinkNarcotic")
		if !mind.IsDevoted()
			PlayJSONAnimation(1)
		else
			PlayJSONAnimations(2,JSONanim_nscenes-(1))
		endif
		EndJSONAnimation()
	elseif canMove
		Anim_LocalByString(DOM01.DOM_Anim.GetDrinkNarcoticPose(self))
		Wait(10.0*DOM01.anim_speed_sec)
	endif
	if canMove
		if (RandomFloat()*100.0 > mind.FACET_Wilfulness || RandomFloat()*100.0 > mind.FACET_Toughness)
			Anim_LocalByString(DOM01.DOM_Anim.GetCoughPose(self))
		endif
	endif
	if DOM01.IsANarcotic(the_drink)
		mind.IngestNarcotic(the_drink)
	else
		SendNotificationAbuse(name+" strangely doesn't feel anything from ingesting "+the_drink.GetName())
	endif
EndFunction

; ### Leash

ObjectReference __leash_point
ObjectReference	Property leash_point Hidden
	ObjectReference Function get()
		return __leash_point
	EndFunction
	Function set(ObjectReference value)
		;*ogTrace("OnLeashPoint leash_point Set()")
		if value != __leash_point
			DOMLeashPointScript old_leash_point = __leash_point as DOMLeashPointScript
			__leash_point = value
			if old_leash_point != None && !DOM01.LeashPointInUse(old_leash_point)
				old_leash_point.Remove()
			endif
			OnLeashPointChanged()
		endif
	EndFunction
EndProperty

Function OnLeashPointChanged()
	;*ogTrace("OnLeashPointChanged")
	is_leashed = has_leash ; && leash_point != None
EndFunction

Event OnLeashEffect()
	WaitAtLeashPoint()
EndEvent

Event OnLeashed()
	;*ogTrace("OnLeashed")
	WaitAtLeashPoint()
EndEvent

Event OnUnLeashed()
	;*ogTrace("OnUnLeashed")
	if canMove
		EnterFollowPlayer()
	endif
EndEvent

Function WaitAtLeashPoint()
	if canMove
		behaviour = "wait_at_leash_point"
	endif
EndFunction

Event OnEnterBleedout()
	;*ogTrace("Entered bleedout...")
	bleedout_active = true
EndEvent

; ### Life style orders

Function SetShouldBeRespectful(Actor akAbuser)
	float x = mind.respect_training+mind.submission
	bool choose_not = !mind.IsObedient() && RandomFloat()*100.0 > x
	if choose_not
		if mind.WillObeyBecauseWarned(13) > 0 ; "being disrespectful"
			SendNotificationOrder(name+" remembers your warning and agrees")			
		else
			ChooseAnswerNo(akAbuser)
			SendNotificationOrderMaster(name+" doesn't feel like calling you ","")
			mind.SetNextPunishmentReasonSilent(13) ; "being disrespectful"
			Anim_AggressiveGesture()
			return
		endif
	endif
	SendNotificationOrderMaster(name+" will now call you ","")
	ChooseAnswerYes(akAbuser)
	mind.should_be_respectful = true
EndFunction

Function UnsetShouldBeRespectful(Actor akAbuser)
	if mind.IsBrokenToObey() || mind.IsObedient()
		ChooseAnswerThanks(akAbuser)
	else
		ChooseAnswerWhat(akAbuser)
	endif
	SendNotificationOrderMaster(name+" doesn't have to call you ","")
	mind.should_be_respectful = false
EndFunction

Function SetShouldWalkOnFour(Actor akAbuser)
	float x = mind.submission+mind.humiliation
	bool choose_not = !mind.IsObedient() && RandomFloat()*100.0 > x
	if choose_not
		if mind.WillObeyBecauseWarned(32) > 0 ; "not walking on four"
			SendNotificationOrder(name+" remembers your warning and agrees")			
		else
			ChooseAnswerNo(akAbuser)
			SendNotificationOrder(name+" doesn't feel like walking like a dog")
			mind.SetNextPunishmentReasonSilent(32) ; "not walking on four"
			Anim_AggressiveGesture()
			return
		endif
	endif
	SendNotificationOrder(name+" will now walk on four like a good pet")
	ChooseAnswerYes(akAbuser)
	ExitCuffed(akAbuser)
	mind.should_walk_on_four = true
EndFunction

Function UnsetShouldWalkOnFour(Actor akAbuser)
	if mind.IsBrokenToObey() || mind.IsObedient()
		ChooseAnswerThanks(akAbuser)
	else
		ChooseAnswerWhat(akAbuser)
	endif
	SendNotificationOrder(name+" doesn't have to walk like a dog anymore")
	mind.should_walk_on_four = false
EndFunction

Function SetShouldBeNaked(Actor akAbuser)
	bool broken
	if is_running_away
		broken = false
	elseif mind.IsBrokenToObey() || mind.IsObedient()
		broken = true
	elseif RandomFloat() < mind.MOD_Naivety || RandomFloat()*100.0 < mind.humiliation
		broken = true
	else
		broken = false
	endif
	
	bool was_naked = is_naked
	if !broken
		if !was_naked
			mind.SetNextPunishmentReasonForceMessage(2," does not want to go around naked") ; "covering self"
		elseif actorType == 0
			mind.SetNextPunishmentReasonForceMessage(17," "+actorBeVerb+" already naked and doesn't like it") ; "didnt listen"
		else
			mind.SetShouldBeNakedSoft()
			return ; creatures and animals don't care about being naked
		endif
		ChooseAnswerNo(akAbuser)
		mind.MakeAngryFor(10.0)
		mind.should_be_naked = false
		return
	endif
	ChooseAnswerYes(akAbuser)
	if !was_naked
		if akRef.IsInFaction(DOM01.DOMActionTied)
			SendNotificationOrder(name+" "+actorBeVerb+" being ripped-off of "+actorPossessive+" clothes")
		else
			SendNotificationOrder(name+" starts undressing")
		endif
	elseif actorType == 0
		SendNotificationOrder(name+" "+actorBeVerb+" already naked")
	endif
	mind.should_be_naked = true
	SendOrderEquipInventory(true) ; do_anim strip = true
	if !was_naked
		SendNotificationOrder(name+" will go around naked")
	endif
EndFunction

Function UnsetShouldBeNaked(Actor akAbuser)
	bool was_naked = is_naked
	mind.should_be_naked = false
	SendOrderEquipInventory(true) ; do_anim strip = true
	if was_naked && has_clothes_in_inventory
		ChooseAnswerThanks(akAbuser)
	endif
EndFunction

Function SetShouldBeNoOrgasm(Actor akAbuser)
	bool broken
	if is_running_away
		broken = false
	elseif mind.IsBrokenToObey() || mind.IsObedient()
		broken = true
	elseif RandomFloat() < mind.MOD_Naivety || RandomFloat()*100.0 < mind.submission
		broken = true
	else
		broken = false
	endif
	
	if !broken
		mind.SetNextPunishmentReasonForceMessage(17," doesn't care about your orders") ; "didnt listen"
		ChooseAnswerNo(akAbuser)
		mind.MakeAngryFor(10.0)
		mind.should_be_noorgasm = false
		return
	endif
	if mind.should_be_noorgasm
		return
	endif
	ChooseAnswerYes(akAbuser)
	mind.should_be_noorgasm = true
	SendNotificationOrder(name+" is not allowed to orgasm")
EndFunction

Function UnsetShouldBeNoOrgasm(Actor akAbuser)
	if mind.IsBrokenToObey() || mind.IsObedient()
		ChooseAnswerThanks(akAbuser)
	else
		ChooseAnswerWhat(akAbuser)
	endif
	SendNotificationOrder(name+" may now orgasm at will ")
	mind.should_be_noorgasm = false
EndFunction

Function TryEquipInventory(bool do_anim=false)
	;*ogTrace("TryEquipInventory tied="+akRef.IsInFaction(DOM01.DOMActionTied)+" anim="+do_anim+" changes="+was_inventory_changed+" wait="+is_inventory_open)
	if akRef.IsInFaction(DOM01.DOMActionTied)
		;*ogTrace("TryEquipInventory Tied")
		SendOrderEquipInventory(do_anim)
		return
	endif
	if !mind.should_be_naked
		;*ogTrace("TryEquipInventory Should be NOT naked")
		SendOrderEquipInventory(do_anim)
		return
	endif
	if !canMove
		return
	endif
	if is_bounded ; cuffs and the like
		SendOrderEquipInventory(false)
		return
	endif
	int res = mind.TryWearClothes()
	if res < 0
		SendNotificationAbuse(name+" thinks about wearing some clothes but remembers your warning")	
		SendOrderEquipInventory(do_anim)
		return
	elseif res == 0
		;*ogTrace("TryEquipInventory doesn't dare to equip inventory")
		SendOrderEquipInventory(do_anim)
		return
	endif
	;*ogTrace("TryEquipInventory decided to equip inventory")
	SendOrderEquipInventoryForced("feels ashamed and proceeds to put "+actorPossessive+" clothes on",do_anim) ; "covering self"
EndFunction

Function TryWearClothes(bool do_anim=true)
	;*ogTrace("TryWearClothes tied="+akRef.IsInFaction(DOM01.DOMActionTied)+" changes="+was_inventory_changed)
	if akRef.IsInFaction(DOM01.DOMActionTied)
		return
	endif
	;if !is_naked
	;	return
	;endif
	if !mind.should_be_naked
		;*ogTrace("TryWearClothes Should NOT be naked")
		SendOrderEquipInventory(do_anim)
		return
	endif
	if is_bounded ; cuffs and the like
		SendOrderEquipInventory(false)
		return
	endif
	int res = mind.TryWearClothes()
	if res < 0
		SendNotificationAbuse(name+" goes about to wear "+actorObjective+" clothes but remembers your warning")	
		SendOrderEquipInventory(do_anim)
		return
	elseif res == 0
		;*ogTrace("TryWearClothes doesn't dare to wear clothes")
		SendOrderEquipInventory(do_anim)
		return
	endif
	;*ogTrace("TryWearClothes decided to equip clothes")
	SendOrderEquipInventoryForced("feels ashamed and proceeds to put "+actorPossessive+" clothes on",do_anim) ; "covering self")
EndFunction

; ### Behaviour Handling ###

bool __reset_on_behaviour_change = false
bool Property reset_on_behaviour_change Hidden
	bool Function get()
		return __reset_on_behaviour_change
	EndFunction
	Function set(bool value)
		;*ogTrace("reset_on_behaviour_change="+value+" changed from "+__reset_on_behaviour_change)
		__reset_on_behaviour_change = value
	EndFunction
EndProperty
bool behaviour_is_busy = false
String __behaviour = "do_nothing"
String Property prev_behaviour = "nothing" Auto Hidden
String Property behaviour Hidden
	String Function get()
		return __behaviour
	EndFunction
	Function set(String value)
		if behaviour_is_busy
			;LogTrace("Behaviour.set() can not change behaviour is busy")	
			return
		endif
		if mind.is_player_actor 
			LogTrace("Behaviour.set() can not change behaviour for PLAYER")	
			return
		endif
		if mind.IsPassedOut() && !akRef.IsDead()
			LogTrace("can not change behaviour actor is unconscious or sleeping or drunk")	
			return
		endif
		if !canAnimateSexlab
			;LogTrace("Behaviour.set() can not change behaviour is animating with Sexlab")	
			return
		endif
		if behaviour == "on_duty" && value != "do_nothing" && value != "wait_in_bag"
			;*ogTrace("Behaviour.set() can not change behaviour from "+__behaviour+" to "+value)	
			return
		endif
		;LogTrace("Behaviour.set() from "+__behaviour+" to "+value+" canReset="+CanResetBehaviour())	
		if value != __behaviour || CanResetBehaviour()
			behaviour_is_busy = true
			;*ogTrace("Behaviour.set() reset_on_behaviour_change = "+reset_on_behaviour_change)
			prev_behaviour = __behaviour
			__behaviour = value
			EndBehaviour()
			SetPrevPoseState(prev_behaviour,value)
			if reset_on_behaviour_change || behaviour == "follow_player"
				LogTrace("Behaviour.set(): Anim_IdleReset behaviour="+behaviour)
				Anim_IdleReset()
			else
				is_idling = true
			endif
			if __behaviour != "flee_and_cower"
				reset_on_behaviour_change = true
			endif
			akRef.RemoveFromFaction(DOM01.DOMActionFleeing) ; avoid some weird behaviour
			behaviour_is_busy = false
			GoToState(__behaviour)
			StartBehaviour()
			SetCombatStatus()
			;*ogTrace("Behaviour change TryWearClothes changes="+was_inventory_changed)
			akRef.EvaluatePackage()
			TryWearClothes(true)
			;*ogTrace("behaviour EvaluatePackage()")
			DOM01.DOM04.NotifyChangeBehaviour(self)
			if __behaviour != "running_away"
				SendExternalEventSS("BehaviourChange",__behaviour)
			endif
		else
			LogTrace("Behaviour.set() CAN NOT RESET behaviour="+__behaviour)	
		endif
	EndFunction
EndProperty
Function StartBehaviour()
EndFunction
Function EndBehaviour()
EndFunction
bool Function CanResetBehaviour()
	return true
EndFunction
Function OnHitUpdate()
EndFunction
Function OnBehaviourUpdate()
EndFunction
Function OnBehaviourUpdateGameTime()
EndFunction
Function OnBehaviourLoad()
EndFunction
Function OnBehaviourCellLoad()
EndFunction
Function OnBehaviourLocationChange(Location akOldLoc, Location akNewLoc)
EndFunction
string Function GetBehaviourString()
	return ""
EndFunction
float Function GetBehaviourModifier()
	return 1.0
EndFunction

int wait_activity = 0
int wait_activity_timer = 0
Function SetSandboxStatus()
	; 0: do nothing
	; 1: be cute
	; 2: be sexy
	; 3: do sport
	; 10: attentive ; not used
	; 100: in furniture
	wait_activity_timer = 0
	
	if  RandomFloat()*100.0 > mind.submission ; Slave is not submitted
		if  RandomFloat()*100.0 > mind.resignation ; Slave is not resignated
			wait_activity = 0
			return
		endif
		if wait_activity != 4 && mind.IsObedient() && RandomFloat()*200.0 <  mind.HEXACO_Conscientiousness
			wait_activity = 4
			poseId = 104
			quietPose =  DOM01.DOM_Anim.GetCleaningPose(self)
		elseif wait_activity != 3 && mind.IsDevoted() && RandomFloat()*200.0 <  mind.FACET_Toughness
			wait_activity = 3
			poseId = 103
			quietPose = DOM01.DOM_Anim.GetExercisePose(self)
		else
			wait_activity = 0
		endif		
		return
	endif
	
	;if wait_activity != 100 && mind.IsObedient() && RandomFloat()*100.0 <  mind.HEXACO_eXtraversion && RandomFloat()*100.0 <  mind.FACET_Sensuality
	;	currentTiedInFurniture = DOM01.DOM_Anim.GetNearbyZazPose()
	;	if currentTiedInFurniture != None
	;		wait_activity = 100
	;		poseId = 3
	;		return
	;	endif
	;endif
	if wait_activity != 1 && mind.IsObedient() && RandomFloat()*200.0 <  mind.HEXACO_eXtraversion
		wait_activity = 1
		poseId = 102
		quietPose = DOM01.DOM_Anim.GetCutePose(self)
	elseif wait_activity != 2 && mind.IsInLove() && RandomFloat()*200.0 <  mind.FACET_Sensuality
		wait_activity = 2
		poseId = 113
		quietPose = DOM01.DOM_Anim.GetSexyPose(self)
	elseif wait_activity != 3 && mind.IsDevoted() && RandomFloat()*200.0 <  mind.FACET_Toughness
		wait_activity = 3
		poseId = 103
		quietPose = DOM01.DOM_Anim.GetExercisePose(self)
	elseif wait_activity != 4 && mind.IsObedient() && RandomFloat()*200.0 <  mind.HEXACO_Conscientiousness
		wait_activity = 4
		poseId = 104
		quietPose = DOM01.DOM_Anim.GetCleaningPose(self)
	else
		wait_activity = 0
	endif
EndFunction

bool Function isMovingBehaviour(string beh)
	if beh == "follow_player" || beh == "follow_trainer" || beh == "follow_target" || beh == "travel"
		return true
	endif
	if beh == "wait" || beh == "wait_sandbox" || beh == "wait_at_leash_point" || beh == "wait_in_bag"
		return true
	endif
	if beh == "jail_sandbox" || beh == "jail_stand" || beh == "jail_travel"
		return true
	endif
	return false
EndFunction

Function SetPrevPoseState(string prev_behaviour, string next_behaviour)
	;LogTrace("SetPrevPoseState prev_behaviour="+prev_behaviour+" next_behaviour="+next_behaviour)
	if (PoseMarker != None) ; Delete pose marker
		PoseMarker.Delete()
	endif
	PoseMarker = None
	if next_behaviour == "flee_and_cower"
		return
	endif
	if quietPose != ""
		prevPoseId = poseId
		prevQuietPose = quietPose
		prevStrugglePose = strugglePose
		prevEnterPose = enterPose
		prevExitPose = exitPose
		poseId = 0
		quietPose = ""
		strugglePose = ""
	endif
	if prev_behaviour == next_behaviour
		return
	endif
	if next_behaviour == "tied" || next_behaviour == "chained" || next_behaviour == "restrained" || next_behaviour == "restrained_in_furniture" 
		;LogTrace("SetPrevPoseState is_restrained="+is_restrained+" equipped_cuffs="+equipped_cuffs)
		return
	endif
	;LogTrace("SetPrevPoseState prev_behaviour="+prev_behaviour+" equipped_cuffs="+equipped_cuffs)
	if prev_behaviour == "tied" || equipped_cuffs != None ; continue with offset tied
		;LogTrace("SetPrevPoseState IsCuffed="+IsCuffed()+" next_behaviour="+next_behaviour)
		if isMovingBehaviour(next_behaviour)
			;LogTrace("SetPrevPoseState Anim_IdleReset keep cuffs next_behaviour="+next_behaviour)
			Anim_IdleReset()
			return
		endif
		;LogTrace("SetPrevPoseState Anim_BoundStop remove equipped_cuffs="+equipped_cuffs)
		Anim_BoundStop()
		return
	endif
	;LogTrace("SetPrevPoseState IsCuffed="+IsCuffed())
	if !IsCuffed() ; no offset, forget it
		return
	endif
	;LogTrace("SetPrevPoseState next_behaviour="+next_behaviour)
	if isMovingBehaviour(next_behaviour)
		;LogTrace("SetPrevPoseState Anim_IdleReset isMovingBehaviour=true")
		Anim_IdleReset()
		return
	endif
	;LogTrace("SetPrevPoseState Anim_BoundStop")
	Anim_BoundStop()
EndFunction

Function SetPoseStatus()
	;*ogTrace("start SetPoseStatus() behaviour="+behaviour+" poseId="+poseId+" quietPose="+quietPose+" strugglePose="+strugglePose)	
	if poseId < 0 ; no pose
		return
	endif
	if poseId == 99 ; holding a light
		DOM01.DOMEquip.CheckLight(akRef)
		return
	endif
	if poseId == 0
		LogAnim("SetPoseStatus: 0 Anim_IdleReset")
		Anim_IdleReset()
		return
	endif
	; Change pose from time to time
	if poseId >= 100 && RandomFloat() > 0.12
		if poseId == 100 ; dance
			quietPose = DOM01.DOM_Anim.GetDancePose(self)
		elseif poseID == 110
			quietPose = DOM01.DOM_Anim.GetBreastPresentationPose(self)
		elseif poseID == 111
			quietPose = DOM01.DOM_Anim.GetAssPresentationPose(self)
		elseif poseID == 112
			quietPose = DOM01.DOM_Anim.GetPussyPresentationPose(self)
		elseif poseID == 113
			quietPose = DOM01.DOM_Anim.GetSubmissivePose(self)
		endif
	endif
	if poseId == 1
		if quietPose == "" ; find a tied pose
			quietPose    = DOM01.DOM_Anim.GetTieupKneeling(self)
			strugglePose = DOM01.DOM_Anim.GetTieupStrugglePose(quietPose)
		endif
	endif
	if strugglePose == ""
		strugglePose = quietPose
	endif
	Anim_Pose()
EndFunction

Function Anim_Pose()
	if poseId == 105 ; no refresh Pose
		return
	endif
	LogAnim("Anim_Pose: pose="+quietPose+" / "+strugglePose+" struggling="+is_struggling)
	if is_struggling
		Anim_PoseByString(strugglePose)
	else
		Anim_PoseByString(quietPose)
	endif
EndFunction

Function SetCombatStatus()
	if canFight && mind.should_fight_for_player
		; enter combat state
		;*ogTrace("SetCombatStatus: SetPlayerTeammate=true")
		akRef.SetPlayerTeammate(true)
		return
	endif

	; exit combat state
	akRef.SetPlayerTeammate(false)
	;*ogTrace("SetCombatStatus: SetPlayerTeammate=false")
	if is_trainer && is_training
		return
	endif
	;*ogTrace("SetCombatStatus: calm")
	CalmActorFast(akRef) ; includes stopcombatalarm()
EndFunction

Function SetFurnitureStatus()
	;*ogTrace("SetFurnitureStatus behaviour="+behaviour+" "+currentTiedInFurniture+" "+nextTiedInFurniture)
	if currentTiedInFurniture == None
		;*ogTrace("SetFurnitureStatus could not find furniture for sitting in ")		
		if PoseMarker != None
			akRef.MoveTo(PoseMarker)	
		endif
		return
	endif
	int sit_status = akRef.GetSitState()
	if sit_status == 3 ; sitting
		;*ogTrace("SetFurnitureStatus is already sitting in "+currentTiedInFurniture.GetBaseObject().getName())	
		;akRef.MoveTo(currentTiedInFurniture)		
		return
	endif
	if sit_status == 2 || sit_status == 4 ; standing up or sitting down
		;*ogTrace("SetFurnitureStatus is moving in/out sitting in "+currentTiedInFurniture.GetBaseObject().getName()+" status="+sit_status)			
		int n = 0
		Wait(1.0)
		sit_status = akRef.GetSitState()
		while n < 10 ; wait for standing up/sititng down action to finish
			if sit_status == 3 ; sitting
				;*ogTrace("SetFurnitureStatus is now sitting in "+currentTiedInFurniture.GetBaseObject().getName())			
				return
			elseif sit_status == 0 ; not sitting
				;*ogTrace("SetFurnitureStatus is not sitting in "+currentTiedInFurniture.GetBaseObject().getName())			
				n = 10 ; break out of loop
			else
				sit_status = akRef.GetSitState()
				;*ogTrace("SetFurnitureStatus is still moving in/out sitting in "+currentTiedInFurniture.GetBaseObject().getName()+" status="+sit_status)			
				n = n+1
				Wait(0.5)
			endif
		endwhile
		akRef.MoveTo(currentTiedInFurniture)		
	endif
	if sit_status == 0 ; not sitting
		;*ogTrace("SetFurnitureStatus is actually not sitting in "+currentTiedInFurniture.GetBaseObject().getName()+" blocked = "+currentTiedInFurniture.IsActivationBlocked())	
		currentTiedInFurniture.BlockActivation(false)
		akRef.moveTo(currentTiedInFurniture)
		;*ogTrace("SetFurnitureStatus activate="+currentTiedInFurniture)
		bool success_sit = currentTiedInFurniture.Activate(akRef,true)
		;LogTrace("SetFurnitureStatus trying to sit in "+currentTiedInFurniture.GetBaseObject().getName()+" success = "+success_sit)			
	endif
EndFunction

Function UnSetFurnitureStatus()
	;*ogTrace("UnSetFurnitureStatus behaviour="+behaviour+" "+currentTiedInFurniture+" "+nextTiedInFurniture)
	if currentTiedInFurniture == None
		;*ogTrace("UnSetFurnitureStatus could not find furniture")			
		return
	endif
	int sit_status = akRef.GetSitState()
	if sit_status == 0 ; not sitting
		;*ogTrace("UnSetFurnitureStatus not sitting")
		currentTiedInFurniture = None
		return
	endif
	if sit_status == 2 ; sitting down
		;*ogTrace("UnSetFurnitureStatus sitting down")
		int n = 0
		Wait(1.0)
		sit_status = akRef.GetSitState()
		while n < 10 ; wait for standing up/sitting down action to finish
			if sit_status == 0 ; not sitting
				currentTiedInFurniture = None
				return
			elseif sit_status == 3 ; sitting
				n = 10
			else
				n = n+1
				Wait(1.0)
				sit_status = akRef.GetSitState()
			endif
		endwhile
		akRef.moveTo(currentTiedInFurniture)
		;*ogTrace("UnSetFurnitureStatus sitting down activate="+currentTiedInFurniture)
		currentTiedInFurniture.Activate(akRef,true)
		Wait(2.0)
	endif
	if sit_status == 3 ; sitting
		akRef.moveTo(currentTiedInFurniture)
		;*ogTrace("UnSetFurnitureStatus sitting activate="+currentTiedInFurniture)
		currentTiedInFurniture.Activate(akRef,true)
	endif
	currentTiedInFurniture = None
EndFunction

int Function GetBehaviourIndex()
	return 0 ;   "do_nothing" 
EndFunction

; ### Behaviour states: WAITING

; # Forced to stand there and no idling and no moving
Auto state do_nothing
	Function StartBehaviour()
		behaviour_working = false
		canIdle = false
		canMove = true
		canFight = false
		akRef.SetFactionRank(DOM01.DOMActionWaiting,4)
		;*ogTrace("behaviour=do_nothing start"))
	EndFunction

	bool Function CanResetBehaviour()
		return false
	EndFunction

	string Function GetBehaviourTitle()
		return "nothing"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionWaiting)
	EndFunction
EndState

; # Nothing to do anymore
state dead
	Function StartBehaviour()
		behaviour_working = true
		__canIdle = false
		__canMove = false  ; use __canMove, and never set canMove after death as it will revive the actor even if set to false!
		canFight = false
		reset_on_behaviour_change = false
		;*ogTrace("behaviour=dead start")+" IsDead="+akRef.IsDead())
	EndFunction

	int Function GetBehaviourIndex()
		return 1 ; "dead"
	EndFunction

	Function EndBehaviour()
	EndFunction
EndState

; # Forced to wait and leashed
state wait_at_leash_point
	Function StartBehaviour()
		behaviour_working = false
		canIdle = true
		canMove = true
		canFight = true
		if !is_leashed
			is_leashed = true
		endif
		target.ForceRefTo(leash_point)
		akRef.SetFactionRank(DOM01.DOMActionWaiting,6)
		;*ogTrace("behaviour=wait_at_leash_point start"))
	EndFunction

	int Function GetBehaviourIndex()
		return 2 ; "wait_at_leash_point"
	EndFunction

	bool Function CanResetBehaviour()
		return false
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionWaiting)
	EndFunction
EndState

; # Forced to stand in utility cell
DOM_BurlapSack Property the_bag_iam_in = None Auto Hidden
state wait_in_bag
	Function StartBehaviour()
		behaviour_working = false
		canIdle = false
		canMove = false
		canFight = false
		akRef.SetFactionRank(DOM01.DOMActionWaiting,5)
		akRef.SetFactionRank(DOM01.DOMActionInContainer,1) ; 1 is in bag
		mind.number_of_bondage += 1
		mind.IncreaseArousal(5.0, mind.MOD_Sociability)
		;*ogTrace("behaviour=wait_in_bag start"))
		SendExternalEventS("InBag")
	EndFunction

	int Function GetBehaviourIndex()
		return 3 ; "wait_in_bag"
	EndFunction

	bool Function CanResetBehaviour()
		return false
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionWaiting)
		akRef.RemoveFromFaction(DOM01.DOMActionInContainer)
		the_bag_iam_in = None
		SendExternalEventS("OutBag")
	EndFunction
EndState

Function SetMarkerAtPosition()
	if PoseMarker != None ; already set (e.g. human chair)
		return
	endif
	PoseMarker = akRef.PlaceAtMe(DOM01.XMarkerForm, 1)
	PoseMarker.Enable()
	;*ogTrace("SetMarkerAtPosition: x="+PoseMarker.GetPositionX()+" y="+PoseMarker.GetPositionY()+" z="+PoseMarker.GetPositionZ())
	;PoseMarker.MoveTo(akRef, 0.0, 0.0, 0.0, true)
	akRef.SetVehicle(PoseMarker)
EndFunction

Function SetMarkerAtFurniture()
	;LogTrace("SetMarkerAtFurniture furn="+currentTiedInFurniture)
	if PoseMarker != None
		PoseMarker.Delete()
		PoseMarker = None
	endif
	PoseMarker = currentTiedInFurniture.PlaceAtMe(DOM01.XMarkerForm, 1)
	PoseMarker.Enable()
	;PoseMarker.MoveTo(currentTiedInFurniture, 0.0, 0.0, 0.0, true)
	;akRef.SetVehicle(currentTiedInFurniture)
EndFunction

; # Forced to stand there and no moving - taken over by another mod
bool is_on_duty = false

Function EnterOnDuty(string duty_msg, string duty_title)
	;LogTrace("EnterOnDuty "+duty_msg+" "+duty_title)
	on_duty_string = duty_title
	behaviour = "on_duty"
	SendNotificationAction(name+" "+duty_msg)
EndFunction

Function EnterOnDutyClean(string duty_msg, string duty_title)
	;LogTrace("EnterOnDutyClean "+duty_msg+" "+duty_title)
	on_duty_string = duty_title
	behaviour = "on_duty_clean"
	SendNotificationAction(name+" "+duty_msg)
EndFunction

Function EnterOnDutyRestrained(string duty_msg, string duty_title)
	;LogTrace("EnterOnDutyRestrained "+duty_msg+" "+duty_title)
	on_duty_string = duty_title
	behaviour = "on_duty_restrained"
	SendNotificationAction(name+" "+duty_msg)
EndFunction

Function ExitOnDuty()
	;LogTrace("ExitOnDuty")
	behaviour = "do_nothing"
	Wait(2.0)
	EnterFollowPlayer()
EndFunction

string on_duty_string = ""
string Function GetBehaviourTitle()
	return behaviour
EndFunction
string Function GetOnDutyTitle()
	return on_duty_string
EndFunction

state on_duty
	Function StartBehaviour()
		is_on_duty = true
		behaviour_working = true
		canIdle = true
		canMove = true
		canFight = true
		akRef.SetFactionRank(DOM01.DOMActionOnDuty,1)
		SetMarkerAtPosition()
		SendNotificationAction(name+" "+actorBeVerb+" on duty")
		;*ogTrace("behaviour=on_duty start"))
	EndFunction
	
	int Function GetBehaviourIndex()
		return 4 ; "on_duty"
	EndFunction

	string Function GetBehaviourTitle()
		if on_duty_string != ""
			return on_duty_string
		endif
		return behaviour
	EndFunction

	Function EndBehaviour()
		behaviour_working = false
		akRef.RemoveFromFaction(DOM01.DOMActionOnDuty)
		on_duty_string = ""
		is_on_duty = false
	EndFunction
EndState

state on_duty_clean
	Function StartBehaviour()
		is_on_duty = true
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		akRef.SetFactionRank(DOM01.DOMActionOnDuty,2)
		akRef.SetFactionRank(DOM01.DOMActionSweeping,2)	
		if !akRef.IsInFaction(DOM01.DOMWaitMode)
			akRef.SetFactionRank(DOM01.DOMWaitMode,DOM01.defaultWaitMode)
		endif
		is_working = true
		DOM01.DOMEquip.EquipBroom(akRef)
		timer_for_work = 0
		is_pickingUpMess = false
		if is_shamed
			mind.number_of_shame += 1
		endif
		if mind.IsDevoted()
			mind.IncreaseArousal(5.0,mind.MOD_Hope)
		endif
		on_update_gametime = false
		SetMarkerAtPosition()
		SendNotificationAction(title+name+" will tidy up the area")
		;*ogTrace("behaviour=on_duty_clean start"))
		OnBehaviourUpdateGameTime()
	EndFunction
	
	Function OnBehaviourUpdateGameTime()	
		;*ogTrace("behaviour=clean_house canAnimate="+canAnimateSexlabLocal+" "+!akRef.IsInDialogueWithPlayer())	
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if IsBreakingWork()
			;*ogTrace("behaviour=clean_house - starts moving by formula")	
			mind.SetNextPunishmentReasonSilent(10) ; "being a bad maid"
			mind.RemoveNextPraiseReason(10) ; "being a good maid"
			EnterWaitSandbox()
		elseif mind.IsWillingToClean()
			if timer_for_work == 0 || timer_for_work == 9 ; Starts to clean
				;*ogTrace("behaviour=clean_house - starts to clean")	
				if akRef.GetFactionRank(DOM01.DOMActionSweeping) != 1
					akRef.SetFactionRank(DOM01.DOMActionSweeping,1)
					akRef.EvaluatePackage()
					Anim_Sweep()
				endif
				mind.SetNextPraiseReasonSilent(10) ; "being a good maid"
				mind.TrainHouse(1.0)
			elseif timer_for_work == 8 || timer_for_work == 15
				;*ogTrace("behaviour=clean_house - starts to pickup objects")	
				if akRef.GetFactionRank(DOM01.DOMActionSweeping) != 2
					akRef.SetFactionRank(DOM01.DOMActionSweeping,2)
					akRef.EvaluatePackage()
					Anim_IdleReset()
				endif
				CleanTheMess()
			elseif timer_for_work == 16 ; A bit of sandboxing
				;*ogTrace("behaviour=clean_house - starts to sandbox")	
				if akRef.GetFactionRank(DOM01.DOMActionSweeping) != 3
					akRef.SetFactionRank(DOM01.DOMActionSweeping,3)
					akRef.EvaluatePackage()
					Anim_IdleReset()
				endif
			else
				;*ogTrace("behaviour=clean_house busy timer="+timer_for_work)	
			endif
			timer_for_work += 1
			;*ogTrace("behaviour=clean_house 1 timer="+timer_for_work)	
			if timer_for_work > 24
				timer_for_work = 0
			elseif akRef.GetFactionRank(DOM01.DOMActionSweeping) == 1
				Anim_Sweep()
			endif
			;*ogTrace("behaviour=clean_house 2 timer="+timer_for_work)	
		else
			;*ogTrace("behaviour=clean_house - idling")	
			if akRef.GetFactionRank(DOM01.DOMActionSweeping) != 3
				akRef.SetFactionRank(DOM01.DOMActionSweeping,3)
				akRef.EvaluatePackage()
				Anim_IdleReset()				
			endif
		endif
	EndFunction
	
	int Function GetBehaviourIndex()
		return 37 ; "on_duty_clean"
	EndFunction

	string Function GetBehaviourTitle()
		if on_duty_string != ""
			return on_duty_string
		endif
		return behaviour
	EndFunction

	Function EndBehaviour()
		behaviour_working = false
		is_working = false
		akRef.RemoveFromFaction(DOM01.DOMActionOnDuty)
		akRef.RemoveFromFaction(DOM01.DOMActionSweeping)
		DOM01.DOMEquip.UnequipBroom(akRef)
		on_duty_string = ""
		is_on_duty = false
	EndFunction
EndState

state on_duty_restrained
	Function StartBehaviour()
		is_on_duty = true
		canIdle = false
		canMove = false
		canFight = false
		is_restrained = true
		akRef.SetFactionRank(DOM01.DOMActionOnDuty,3)
		akRef.SetFactionRank(DOM01.DOMActionTied,5)
		SetMarkerAtPosition()
		;SendNotificationAction(name+" "+actorBeVerb+" locked in "+on_duty_string)
		;*ogTrace("behaviour=on_duty_restrained start"))
		mind.CheckRestrainedKinks(on_duty_string)
	EndFunction
	
	int Function GetBehaviourIndex()
		return 38 ; "on_duty_restrained"
	EndFunction

	string Function GetBehaviourTitle()
		if on_duty_string != ""
			return "locked in "+on_duty_string
		endif
		return behaviour
	EndFunction

	Function EndBehaviour()
		behaviour_working = false
		is_restrained = false
		is_struggling = false
		akRef.RemoveFromFaction(DOM01.DOMActionOnDuty)
		akRef.RemoveFromFaction(DOM01.DOMActionTied)
		on_duty_string = ""
		is_on_duty = false
	EndFunction
EndState

; # Stand there and sandbox
State wait_sandbox
	Function StartBehaviour()
		behaviour_working = false
		canIdle = true
		canMove = true
		canFight = true
		akRef.SetFactionRank(DOM01.DOMActionWaiting,2)
		if !akRef.IsInFaction(DOM01.DOMWaitMode)
			akRef.SetFactionRank(DOM01.DOMWaitMode,DOM01.defaultWaitMode)
		endif
		SendNotificationAction(name+" will mind "+actorPossessive+" own business")
		SetSandboxStatus()
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		SendNotificationAction(name+" will wait here")
		;*ogTrace("behaviour=wait_sandbox start"))
	EndFunction
	
	Function OnBehaviourUpdateGameTime()
		if !canIdle
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if wait_activity_timer > 40
			SetSandboxStatus()
			if wait_activity <= 0
				akRef.SetFactionRank(DOM01.DOMActionWaiting,2) ; sandbox
				akRef.EvaluatePackage()
			elseif wait_activity >= 100
				akRef.SetFactionRank(DOM01.DOMActionWaiting,100) ; posing in furniture
				akRef.EvaluatePackage()
			else
				akRef.SetFactionRank(DOM01.DOMActionWaiting,1) ; stand still
				akRef.EvaluatePackage()
			endif
		endif
		wait_activity_timer += 1
		if wait_activity >= 100
			SetFurnitureStatus()
		elseif wait_activity > 0
			wait_activity_timer += 1
			Anim_IdleByString(quietPose)
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 5 ; "wait_sandbox"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionWaiting)
		DoStandUp()
	EndFunction
EndState

; # Forced to stand there
state wait
	Function StartBehaviour()
		behaviour_working = false
		canIdle = true
		canMove = true
		canFight = true
		akRef.SetFactionRank(DOM01.DOMActionWaiting,1)
		SendNotificationAction(name+" will stand still")
		;*ogTrace("behaviour=wait start"))
	EndFunction

	Function OnBehaviourUpdate()
		;*ogtrace("OnBehaviourUpdate behaviour=wait")
		if IsBreakingWait()
			mind.SetNextPunishmentReasonForceMessage(16,"chooses to stop waiting") ; "didnt_wait"
			EnterWaitSandbox()
			return
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 6 ; "wait"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionWaiting)
	EndFunction
EndState

; ### Behaviour states: FOLLOWING

bool Function IsFollowingPlayer()
	if is_following_player
		return true
	endif
	if actor_trainer != None && actor_trainer.is_following_player
		return true
	endif
	return false
EndFunction

bool Property is_following_player = false Auto Hidden
state follow_player
	Function StartBehaviour()
		is_following_player = true
		behaviour_working = false
		canIdle = true
		canMove = true
		canFight = true
		target.ForceRefTo(PlayerRef)
		akRef.SetLookAt(PlayerRef)
		akRef.SetFactionRank(DOM01.DOMActionFollowing,1) ; rank 1 is follow player
		if !akRef.IsInFaction(DOM01.DOMFollowMode)
			akRef.SetFactionRank(DOM01.DOMFollowMode,DOM01.defaultFollowMode)
		endif
		SendNotificationAction(name+" "+actorBeVerb+" now following you")
		if mind.is_slave
			DOM01.AddSlaveFollower(self)
		endif
		;*ogTrace("behaviour=follow_player start"))
	EndFunction

	bool Function CanResetBehaviour()
		return false
	EndFunction
	
	string Function GetBehaviourTitle()
		if mind.should_fight_for_player
			return "bodyguard"
		endif
		return "following"
	EndFunction

	;Function OnBehaviourUpdateGameTime()	
	;	LogTrace("FOLLOW_PLAYER target="+target+" ref="+target.GetRef()+" distance="+GetObjectDistance(akRef,target.GetRef())+" mode="+akRef.GetFactionRank(DOM01.DOMFollowMode))
	;	akRef.EvaluatePackage()
	;EndFunction

	int Function GetBehaviourIndex()
		return 7 ; "follow_player"
	EndFunction

	Function EndBehaviour()
		is_following_player = false
		akRef.RemoveFromFaction(DOM01.DOMActionFollowing)
		if mind.is_slave
			DOM01.RemoveSlaveFollower(self)
		endif
	EndFunction	
EndState

state follow_trainer
	Function StartBehaviour()		
		behaviour_working = true
		canIdle = true
		canMove = true
		canFight = false
		if actor_trainer == None
			EnterFollowPlayer()
			return
		endif
		target.ForceRefTo(actor_trainer.akRef) ; actor_trainer should have been checked against None before
		akRef.SetLookAt(actor_trainer.akRef)
		akRef.SetFactionRank(DOM01.DOMActionFollowing,2) ; rank 2 is follow trainer
		if !akRef.IsInFaction(DOM01.DOMFollowMode)
			akRef.SetFactionRank(DOM01.DOMFollowMode,DOM01.defaultFollowMode)
		endif
		SendNotificationAction(name+" now follows trainer "+actor_trainer.getName())
		;*ogTrace("behaviour=follow_trainer start"))
	EndFunction

	Function OnBehaviourUpdateGameTime()	
		;if actor_trainer != None
		;	LogTrace("FOLLOW_TRAINER target="+target+" ref="+target.GetRef()+" trainer="+actor_trainer.GetName()+" distance="+GetObjectDistance(akRef,target.GetRef())+" mode="+akRef.GetFactionRank(DOM01.DOMFollowMode))
		;	akRef.EvaluatePackage()
		;else
		if actor_trainer == None
			LogTrace("FOLLOW_TRAINER target="+target+" ref="+target.GetRef()+" WARNING trainer=None distance="+GetObjectDistance(akRef,target.GetRef())+" mode="+akRef.GetFactionRank(DOM01.DOMFollowMode))
			EnterFollowPlayer()
		endif
	EndFunction
	
	int Function GetBehaviourIndex()
		return 8 ; "follow_trainer"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionFollowing)
	EndFunction
EndState

state follow_target
	Function StartBehaviour()
		behaviour_working = true
		canIdle = true
		canMove = true
		canFight = false
		Actor akTarget = target.GetReference() as Actor
		if akTarget == None
			EnterWait()
			return
		endif		
		akRef.SetLookAt(akTarget)
		akRef.SetFactionRank(DOM01.DOMActionFollowing,3) ; rank 3 is follow target
		if !akRef.IsInFaction(DOM01.DOMFollowMode)
			akRef.SetFactionRank(DOM01.DOMFollowMode,DOM01.defaultFollowMode)
		endif
		SendNotificationAction(name+" "+actorBeVerb+" now following "+akTarget.GetDisplayName())
		;*ogTrace("behaviour=follow_target start"))
	EndFunction

	int Function GetBehaviourIndex()
		return 9 ; "follow_target"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionFollowing)
	EndFunction
EndState

; ### Behaviour states: RUNNING AWAY & FLEEING

state flee_and_cower
	Function StartBehaviour()
		canIdle = false
		canMove = false
		canFight = false
		akRef.ClearLookAt()
		akRef.SetFactionRank(DOM01.DOMActionFleeing,1)
		if quietPose == ""
			quietPose = "Anim_BleedOutStart"
			strugglePose = ""
		endif
		if quietPose != "Anim_BleedOutStart"
			is_restrained = true
		endif
		Anim_LocalByString(quietPose)
		LogTrace("StartBehaviour behaviour=flee_and_cower start quietPose="+quietPose+" is_restrained="+is_restrained)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate behaviour=flee_and_cower quietPose="+quietPose)
		Anim_LocalByString(quietPose)
	EndFunction

	int Function GetBehaviourIndex()
		return 10 ; "flee_and_cower"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionFleeing)
		is_restrained = false
		reset_on_behaviour_change = true
	EndFunction
EndState

bool Property is_running_away = false Auto Hidden
state running_away
	Function StartBehaviour()
		is_running_away = true
		canIdle = false
		canMove = true
		canFight = false
		akRef.ClearLookAt()
		target.ForceRefTo(PlayerRef)
		akRef.SetFactionRank(DOM01.DOMActionFleeing,3)
		mind.SetNextPunishmentReasonForceMessage(25,"is running away!") ; "running_away"
		;TryCallForHelp(true)
		mind.IncreaseArousal(5.0,mind.MOD_Hope)
		SendExternalEventS("Runaway")
		;*ogTrace("behaviour=running_away start"))
	EndFunction

	bool Function CanResetBehaviour()
		return false
	EndFunction
	
	Function OnBehaviourUpdateGameTime()
		if has_leash || is_leashed
			SendNotificationAbuse(name+"'s escape wish vanishes as "+actorPossessive+" restraints tighten")
			EnterFollowPlayerOrTrainer() ; follow trainer or master
		elseif !canRunAway
			TryCallForHelp(true)
		elseif !IsTogetherWithFast(akRef, PlayerRef, 15000.0)
			if actor_trainer == None || !IsTogetherWithFast(actor_trainer.akRef, PlayerRef, 5000.0)
				;*ogTrace("OnBehaviourUpdateGameTime is running away")
				SendOrderEquipInventoryForced("proceeds to put "+actorPossessive+" clothes on",true) ; "covering self"
				TryCallForHelp(true)
				TryEscape()
			endif
		elseif akRef.IsRunning() ; && !akRef.IsInDialogueWithPlayer()
			float mod = 5.0
			if has_blindfold
				mod = 1.0
			endif
			if mind.WasWarned(25)
				mod = mod * 0.5
			endif
			if RandomFloat()*mod < mind.MOD_Fearfulness ; "running_away"
				SendNotificationEmotion(name+" panics and trips while running away")
				mind.MakeMoodAfraid(1.0)
				PushMeAway(mind.MOD_Panic*5.0)
			endif
			TryCallForHelp(true)
		elseif has_blindfold && !has_cuffs_back && !has_cuffs_boxtied && !has_arms_device
			RemoveBlindfold(None,false) ; keep blindfold in inventory
		elseif has_mouth_gag && !has_cuffs_back && !has_cuffs_boxtied && !has_arms_device
			RemoveGag(false) ; keep gag in inventory
		elseif (is_naked && has_clothes_in_inventory) && !is_bounded
			;LogTrace("RUNAWAY EquipInventoryForced is_naked="+is_naked+" !has_armor="+(has_armor <= 1.0)+" !has_weapon="+(has_weapon <= 0.0)+" in inv="+has_clothes_in_inventory+" "+has_armor_in_inventory+" "+has_shield_in_inventory+" "+has_weapon_in_inventory)
			SendOrderEquipInventoryForced("stops running to put "+actorPossessive+" clothes on",true) ; "covering self"
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 11 ; "running_away"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionFleeing)
		is_running_away = false
	EndFunction

	Event OnLeashed()
	EndEvent
EndState

; ### Behaviour states: POSING & RESTRAINED
bool on_hit_update = false
bool Property is_behaviour_pose = false Auto Hidden
state pose
	Function StartBehaviour()
		behaviour_working = false
		canIdle = false
		canMove = true
		canFight = true
		SetLookAtTarget()
		StartPose() ; register next poseId and poses
		SetMarkerAtPosition() ; Can be move while posing?
		akRef.SetFactionRank(DOM01.DOMActionPosing,poseId)
		is_behaviour_pose = true
		if mind.IsDevoted()
			mind.IncreaseArousal(10.0,mind.MOD_Flexibility)
		endif
		if poseId == 99
			DOM01.DOMEquip.EquipLight(akRef)
		endif
		on_update_gametime = false
		Anim_Pose()
		OnBehaviourUpdateGameTime()
		SendNotificationAction(name+" starts posing")
		;*ogTrace("behaviour=pose start"))
		mind.CheckAndRegisterKink(74,0.5) ; "being objectified"
	EndFunction
	
	Function OnHitUpdate()
		;/
		if on_hit_update
			return
		endif
		on_hit_update = true
		wait(2.0)
		QueueNiNodeUpdate()
		on_hit_update = false
		/;
	EndFunction
	
	Function OnBehaviourUpdate()
		;*ogtrace("OnBehaviourUpdate behaviour=pose OnBehaviourUpdate"))
		if !DOM01.poseMoveToggle || PoseMarker == None || akRef.IsInDialogueWithPlayer() || !canAnimateSexlab
			return
		endif
		if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
			SetMarkerAtPosition()
			if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
				PoseMarker = None
				return
			endif
		endif
		akRef.MoveTo(PoseMarker)
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogtrace("OnBehaviourUpdateGameTime behaviour=pose OnBehaviourUpdateGameTime"))
		if !canAnimate
			return
		endif	
		int was_warned = mind.WillObeyBecauseWarned(15)
		if was_warned > 0
			mind.TrainPose(0.5)		
		elseif IsBreakingPose()
			Wait(1.0)
			if was_warned == 0 ; "didnt_pose"
				mind.SetNextPunishmentReasonForceMessage(15,"stops posing despite being warned") ; "didnt_pose"
			else
				mind.SetNextPunishmentReasonForceMessage(15,"chooses to stop posing") ; "didnt_pose"
			endif
			mind.RemoveNextPraiseReason(2) ; "being a good pet"
			akRef.AddToFaction(DOM01.DOMFailedToPose)
			EnterWait()
			return
		elseif RandomFloat() < mind.MOD_Discipline*0.5
			mind.TrainPose(0.5)
		endif
		if !was_pose_registered 
			float elapsed_time = GetCurrentGameTime()-timer_for_pose
			if elapsed_time > DOM01.pose_threshold ; almost 1 hour in days
				was_pose_registered = true
				mind.SetNextPraiseReasonSilent(2) ; "being a good pet"
			endif
		endif
		Actor akTarget = Game.GetCurrentCrosshairRef() As Actor
		if aktarget != akRef	
			Anim_Pose()
		endif
	EndFunction

	string Function GetBehaviourString()
		return "posing "
	EndFunction

	float Function GetBehaviourModifier()
		return 1.2
	EndFunction

	int Function GetBehaviourIndex()
		return 12 ; "pose"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionPosing)
		is_behaviour_pose = false
		if poseId == 99 ; previously holding a torch
			DOM01.DOMEquip.UnequipLight(akRef)
		endif
		poseId = 0
	EndFunction
EndState

bool Property is_behaviour_masturbate = false Auto Hidden
State masturbate
	Function StartBehaviour()
		behaviour_working = false
		canIdle = false
		canMove = true
		canFight = true
		SetLookAtTarget()
		StartPose() ; register next poseId and poses
		SetMarkerAtPosition() ; Can be move while posing?
		if poseId < 1000 ; Make sure we are using a masturbate pose
			poseId = 1000
		endif
		ChooseMasturbateIdle(0) ; update poseId and poses
		akRef.SetFactionRank(DOM01.DOMActionMasturbating,1)
		is_behaviour_masturbate = true
		mind.IncreaseArousal(5.0,mind.MOD_Naivety)
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		SendNotificationAction(name+" starts masturbating")
		;*ogTrace("behaviour=masturbate start"))
	EndFunction
	
	Function OnBehaviourUpdate()
		;*ogtrace("OnBehaviourUpdate behaviour=masturbate OnBehaviourUpdate"))
		if !DOM01.poseMoveToggle || PoseMarker == None || akRef.IsInDialogueWithPlayer() || !canAnimateSexlab
			return
		endif
		if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
			SetMarkerAtPosition()
			if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
				PoseMarker = None
				return
			endif
		endif
		akRef.MoveTo(PoseMarker)
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogtrace("OnBehaviourUpdateGameTime behaviour=masturbate OnBehaviourUpdateGameTime"))
		mind.IncreaseArousal(4.0,mind.MOD_Daring)
		if !canAnimate
			return
		endif	
		int was_warned = mind.WillObeyBecauseWarned(19)
		if was_warned > 0
			SendNotificationEmotion(name+" remembers your warning and goes on with masturbating")
			mind.IncreaseArousal(10.0,mind.MOD_Daring)
		elseif IsBreakingMasturbate()
			if was_warned == 0 ; "didnt_masturbate"
				mind.SetNextPunishmentReasonForceMessage(19,"stops masturbating despite being warned") ; "didnt_masturbate"
			else
				mind.SetNextPunishmentReasonForceMessage(19,"chooses to stop masturbating") ; "didnt_masturbate"
			endif
			
			mind.RemoveNextPraiseReason(2) ; "being a good pet"
			mind.RemoveNextPraiseReason(19) ; "being a good horny pet"
			EnterWait()
			return
		endif
		if !was_pose_registered 
			float elapsed_time = GetCurrentGameTime()-timer_for_pose
			if elapsed_time > DOM01.pose_threshold ; almost 1 hour in days
				was_pose_registered = true
				mind.SetNextPraiseReasonSilent(2) ; "being a good pet"
			endif
		endif
		mind.IsArousedAfterShame(mind.MOD_Daring)
		ChooseMasturbateIdle(0)
	EndFunction

	float Function GetBehaviourModifier()
		return 1.1
	EndFunction

	int Function GetBehaviourIndex()
		return 13 ; "masturbate"
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionMasturbating)
		is_behaviour_masturbate = false
	EndFunction
EndState

state tied
	Function StartBehaviour()
		behaviour_working = false
		canMove = false
		canIdle = false
		canFight = false
		is_restrained = true
		SetLookAtTarget()
		CalmActorFast(akRef)	
		akRef.SetRestrained()
		poseId = 1
		StartPose() ; register next poseId and poses
		SetPoseStatus()
		SetMarkerAtPosition() ; Can be move while tied?
		akRef.SetFactionRank(DOM01.DOMActionTied,1)
		if is_shamed
			mind.number_of_shame += 1
		endif
		mind.IncreaseArousal(15.0,mind.MOD_Sociability)
		RegisterForAnimEvent()
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=tied start"))
		mind.CheckRestrainedKinks(quietPose)
	EndFunction
	
	Function OnHitUpdate()
		;/
		if on_hit_update
			return
		endif
		on_hit_update = true
		wait(2.0)
		QueueNiNodeUpdate()
		on_hit_update = false
		/;
	EndFunction

	Function OnBehaviourUpdate()
		;*ogtrace("OnBehaviourUpdate behaviour=tied OnBehaviourUpdate"))
		if !DOM01.poseMoveToggle || PoseMarker == None || akRef.IsInDialogueWithPlayer() || !canAnimateSexlab
			return
		endif
		if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
			SetMarkerAtPosition()
			if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
				PoseMarker = None
				return
			endif
		endif
		akRef.MoveTo(PoseMarker)
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=tied OnBehaviourUpdateGameTime"))
		if !canAnimate
			return
		endif	
		if equipped_cuffs
			if IsBreakingTieup()
				RegisterForSingleLOSGain(akRef, PlayerRef)
				if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
					mind.TrainForBondage(0.5)
					mind.TrainPose(0.5)
				elseif IsBreakingRestraint(equipped_cuffs)
					;LogTrace("breaking restraints behaviour=tied")	
					mind.SetNextPunishmentReasonForceMessage(24,"managed to break free!") ; "breaking restraints"
					RemoveCuffs()
					EnterWait()
					mind.MakeRunAway()
					return
				else
					mind.SetNextPunishmentReasonSilent(7) ; "struggling"
					timer_for_pose = GetCurrentGameTime()
					is_struggling = true
					Anim_PoseByString(strugglePose)
				endif
			else
				UnregisterForLOS(akRef, PlayerRef)
				if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
					mind.TrainForDiscipline(0.25)
					mind.TrainPose(0.5)
				endif
				is_struggling = false
				Anim_PoseByString(quietPose)
			endif
		else
			Form cuffs = DOM01.DOMZaz.FindCuffs(akRef)
			if cuffs == None
				;LogTrace("is tied but has no cuffs behaviour=tied")	
				if RandomFloat()*100.0 < mind.resignation
					EnterFollowPlayerOrTrainer() ; follow trainer or master
				else
					EnterWait()
				endif
				return
			else
				;LogTrace("is tied but had no cuffs, corrected behaviour=tied")	
				LogTrace("bahaviour=tied EquipCuffs equipped_cuffs="+equipped_cuffs)
				EquipCuffs(cuffs)
			endif
			Anim_PoseByString(quietPose)
		endif
		if !was_pose_registered 
			float elapsed_time = GetCurrentGameTime()-timer_for_pose
			if elapsed_time > DOM01.pose_threshold ; almost 1 hour in days
				was_pose_registered = true
				if mind.is_love_interest
					mind.SetNextPraiseReasonSilent(7) ; "being a good bondage pet"
				else
					mind.SetNextPraiseReasonSilent(1) ; "being a good slave"
				endif
			endif
		endif
	EndFunction
	
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		LogAnim("OnAnimationEvent behaviour=tied")
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndEvent
	
	Function OnBehaviourLoad()
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction
	
	Function OnBehaviourCellLoad()
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction

	Function OnBehaviourLocationChange(Location akOldLoc, Location akNewLoc)
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction
	
	Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
		if RandomFloat()*100.0 < mind.fear_training && RandomFloat() < mind.MOD_Fearfulness
			SendNotificationEmotionMaster("Slave "+name+" shivers as "," is in sight")
			mind.TrainFear(0.5)
			is_struggling = false
			Anim_PoseByString(quietPose)
		endif
	EndEvent

	string Function GetBehaviourString()
		return "tied "
	EndFunction

	float Function GetBehaviourModifier()
		if cuffs_material > 3 ; Steel
			return 1.5
		endif
		if cuffs_material == 3 ; Iron
			return 1.4
		endif
		return 1.3
	EndFunction

	int Function GetBehaviourIndex()
		return 14 ; "tied"
	EndFunction

	Function EndBehaviour()
		ExitTieUpSoft()
		akRef.RemoveFromFaction(DOM01.DOMActionTied)
		is_restrained = false
		is_struggling = false
		UnregisterForAnimEvent()
		UnregisterForLOS(akRef, PlayerRef)
	EndFunction
EndState

state chained
	Function StartBehaviour()
		behaviour_working = false
		canMove = false
		canIdle = false
		canFight = false
		is_restrained = true
		SetLookAtTarget()
		CalmActorFast(akRef)	
		akRef.SetRestrained()
		poseId = 1
		StartPose() ; register next poseId and poses
		SetPoseStatus()
		SetMarkerAtPosition()
		akRef.SetFactionRank(DOM01.DOMActionTied,2)
		if is_shamed
			mind.number_of_shame += 1
		endif
		mind.IncreaseArousal(15.0,mind.MOD_Sociability)
		RegisterForAnimEvent()
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=chained start"))
		mind.CheckRestrainedKinks(quietPose)
	EndFunction

	Function OnBehaviourUpdate()
		if !DOM01.poseMoveToggle || PoseMarker == None || akRef.IsInDialogueWithPlayer() || !canAnimateSexlab
			return
		endif
		if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
			SetMarkerAtPosition()
			if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
				PoseMarker = None
				return
			endif
		endif
		akRef.MoveTo(PoseMarker)
	EndFunction
	
	Function OnBehaviourUpdateGameTime()
		if IsBreakingTieup()
			RegisterForSingleLOSGain(akRef, PlayerRef)
			if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
				mind.TrainForBondage(0.5)
				mind.TrainPose(0.5)
			elseif IsBreakingRestraint(equipped_cuffs)
				;LogTrace("breaking restraints behaviour=tied")	
				mind.SetNextPunishmentReasonForceMessage(24,"managed to break free!") ; "breaking restraints"
				RemoveCuffs()
				EnterWait()
				mind.MakeRunAway()
				return
			else
				mind.SetNextPunishmentReasonSilent(7) ; "struggling"
				timer_for_pose = GetCurrentGameTime()
				is_struggling = true
				;*ogTrace("OnBehaviourUpdate behaviour=chained struggle")
				Anim_PoseByString(strugglePose)
			endif
		else
			UnregisterForLOS(akRef, PlayerRef)
			if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
				mind.TrainForDiscipline(0.25)
				mind.TrainPose(0.5)
			endif
			is_struggling = false
			;*ogTrace("OnBehaviourUpdate behaviour=chained quiet")
			Anim_PoseByString(quietPose)
		endif
		if !was_pose_registered 
			float elapsed_time = GetCurrentGameTime()-timer_for_pose
			if elapsed_time > DOM01.pose_threshold ; almost 1 hour in days
				was_pose_registered = true
				if mind.is_love_interest
					mind.SetNextPraiseReasonSilent(7) ; "being a good bondage pet"
				else
					mind.SetNextPraiseReasonSilent(1) ; "being a good slave"
				endif
			endif
		endif
	EndFunction
	
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		LogAnim("OnAnimationEvent behaviour=chained")
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndEvent
	
	Function OnBehaviourLoad()
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction
	
	Function OnBehaviourCellLoad()
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction

	Function OnBehaviourLocationChange(Location akOldLoc, Location akNewLoc)
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction
	
	Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
		if RandomFloat()*100.0 < mind.fear_training && RandomFloat() < mind.MOD_Fearfulness
			SendNotificationEmotionMaster("Slave "+name+" shivers as "," is in sight")
			mind.TrainFear(0.25)
			mind.TrainForDiscipline(0.25)
			is_struggling = false
			Anim_PoseByString(quietPose)
		endif
	EndEvent

	string Function GetBehaviourString()
		return "chained "
	EndFunction

	float Function GetBehaviourModifier()
		return 1.5
	EndFunction

	int Function GetBehaviourIndex()
		return 15 ; "chained"
	EndFunction

	Function EndBehaviour()
		ExitTieUpSoft()
		akRef.RemoveFromFaction(DOM01.DOMActionTied)
		is_restrained = false
		is_struggling = false
		UnregisterForAnimEvent()
		UnregisterForLOS(akRef, PlayerRef)
	EndFunction
EndState

state restrained
	Function StartBehaviour()
		behaviour_working = false
		canMove = false
		canIdle = false
		canFight = false
		is_restrained = true
		SetLookAtTarget()
		CalmActorFast(akRef)	
		akRef.SetRestrained()
		poseId = 1
		StartPose() ; register next poseId and poses
		SetPoseStatus()
		SetMarkerAtPosition()
		akRef.SetFactionRank(DOM01.DOMActionTied,3)
		if is_shamed
			mind.number_of_shame += 1
		endif
		mind.IncreaseArousal(15.0,mind.MOD_Sociability)
		RegisterForAnimEvent()
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=chained start"))
		mind.CheckRestrainedKinks(quietPose)
	EndFunction
	
	Function OnBehaviourUpdate()
		if !DOM01.poseMoveToggle || PoseMarker == None || akRef.IsInDialogueWithPlayer() || !canAnimateSexlab
			return
		endif
		if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
			SetMarkerAtPosition()
			if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
				PoseMarker = None
				return
			endif
		endif
		akRef.MoveTo(PoseMarker)
	EndFunction

	Function OnBehaviourUpdateGameTime()
		; No escape possible, assume pose has chains included
		if IsBreakingTieup()
			RegisterForSingleLOSGain(akRef, PlayerRef)
			if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
				mind.TrainForBondage(0.5)
				mind.TrainPose(0.5)
			elseif IsBreakingRestraint(equipped_cuffs)
				;LogTrace("breaking restraints behaviour=tied")	
				mind.SetNextPunishmentReasonForceMessage(24,"managed to break free!") ; "breaking restraints"
				RemoveCuffs()
				EnterWait()
				mind.MakeRunAway()
				return
			else
				mind.SetNextPunishmentReasonSilent(7) ; "struggling"
				timer_for_pose = GetCurrentGameTime()
				is_struggling = true
				;*ogTrace("OnBehaviourUpdate behaviour=chained struggle")
				Anim_PoseByString(strugglePose)
			endif
		else
			UnregisterForLOS(akRef, PlayerRef)
			if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
				mind.TrainForDiscipline(0.25)
				mind.TrainPose(0.5)
			endif
			is_struggling = false
			;*ogTrace("OnBehaviourUpdate behaviour=chained quiet")
			Anim_PoseByString(quietPose)
		endif
		if !was_pose_registered 
			float elapsed_time = GetCurrentGameTime()-timer_for_pose
			if elapsed_time > DOM01.pose_threshold ; almost 1 hour in days
				was_pose_registered = true
				if mind.is_love_interest
					mind.SetNextPraiseReasonSilent(7) ; "being a good bondage pet"
				else
					mind.SetNextPraiseReasonSilent(1) ; "being a good slave"
				endif
			endif
		endif
	EndFunction
	
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		LogAnim("OnAnimationEvent behaviour=chained")
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndEvent
	
	Function OnBehaviourLoad()
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction
	
	Function OnBehaviourCellLoad()
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction

	Function OnBehaviourLocationChange(Location akOldLoc, Location akNewLoc)
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction
	
	Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
		if RandomFloat()*100.0 < mind.fear_training && RandomFloat() < mind.MOD_Fearfulness
			SendNotificationEmotionMaster("Slave "+name+" shivers as "," is in sight")
			mind.TrainFear(0.25)
			mind.TrainForDiscipline(0.25)
			is_struggling = false
			Anim_PoseByString(quietPose)
		endif
	EndEvent

	string Function GetBehaviourString()
		return "restrained "
	EndFunction

	float Function GetBehaviourModifier()
		return 1.5
	EndFunction

	int Function GetBehaviourIndex()
		return 16 ; "restrained"
	EndFunction

	Function EndBehaviour()
		ExitTieUpSoft()
		akRef.RemoveFromFaction(DOM01.DOMActionTied)
		is_restrained = false
		is_struggling = false
		UnregisterForAnimEvent()
		UnregisterForLOS(akRef, PlayerRef)
	EndFunction
EndState

state restrained_in_furniture
	Function StartBehaviour()
		behaviour_working = false
		canMove = false
		canIdle = false
		canFight = false
		is_restrained = true
		SetLookAtTarget()
		CalmActorFast(akRef)	
		akRef.SetRestrained()
		;*ogTrace(getName()+" being restrained in "+nextTiedInFurniture+" "+currentTiedInFurniture)
		if nextTiedInFurniture != None
			currentTiedInFurniture = nextTiedInFurniture
		else
			ObjectReference activeFurniture = DOM01.DOM02.GetActiveFurniture() 
			if activeFurniture != None
				currentTiedInFurniture = activeFurniture
			endif
		endif
		string furniture_name
		if currentTiedInFurniture == None
			furniture_name = "furniture"
			SendNotificationAction(getName()+" "+actorBeVerb+" being restrained in furniture")
			SetMarkerAtPosition()
			target.ForceRefTo(PoseMarker)
		else
			furniture_name = currentTiedInFurniture.GetBaseObject().getName()
			SendNotificationAction(getName()+" "+actorBeVerb+" being restrained in "+furniture_name)
			SetMarkerAtFurniture()
			target.ForceRefTo(currentTiedInFurniture)
		endif
		poseId = 2
		StartPose() ; register next poseId and poses
		SetFurnitureStatus()
		;akRef.moveTo(PoseMarker) ; moveTo makes actor get up from furniture!
		;akRef.SetVehicle(PoseMarker)
		akRef.SetFactionRank(DOM01.DOMActionTied,4)
		if is_shamed
			mind.number_of_shame += 1
		endif
		mind.IncreaseArousal(20.0,mind.MOD_Sociability)
		Wait(2.0)
		RegisterForAnimEvent()
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=restrained_in_furniture start"))
		mind.CheckRestrainedKinks(furniture_name)
	EndFunction

	bool Function CanResetBehaviour()
		return false
	EndFunction

	Function OnBehaviourUpdate()
	EndFunction
	
	Function OnBehaviourUpdateGameTime()
		; No escape possible
		if IsBreakingTieup()
			RegisterForSingleLOSGain(akRef, PlayerRef)
			if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
				mind.TrainForBondage(0.5)
				mind.TrainPose(0.5)
			elseif IsBreakingRestraint(currentTiedInFurniture) ; .GetBaseObject()
				;LogTrace("breaking restraints behaviour=restrained")	
				mind.SetNextPunishmentReasonForceMessage(24,"managed to break free!") ; "breaking restraints"
				EnterWait()
				RemoveCuffs()
				mind.MakeRunAway()
			else
				mind.SetNextPunishmentReasonSilent(7) ; "struggling"
				timer_for_pose = GetCurrentGameTime()
				is_struggling = true
			endif
		else
			UnregisterForLOS(akRef, PlayerRef)
			if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
				mind.TrainForDiscipline(0.25)
				mind.TrainPose(0.5)
			endif
			is_struggling = false
		endif
	
		if !was_pose_registered 
			float elapsed_time = GetCurrentGameTime()-timer_for_pose
			if elapsed_time > DOM01.pose_threshold ; almost 1 hour in days
				was_pose_registered = true
				if mind.is_love_interest
					mind.SetNextPraiseReasonSilent(7) ; "being a good bondage pet"
				else
					mind.SetNextPraiseReasonSilent(1) ; "being a good slave"
				endif
			endif
		endif
	EndFunction

	Function OnBehaviourLoad()
		CalmActorFast(akRef)
		SetFurnitureStatus()
	EndFunction
	
	Function OnBehaviourCellLoad()
		CalmActorFast(akRef)
		SetFurnitureStatus()
	EndFunction

	Function OnBehaviourLocationChange(Location akOldLoc, Location akNewLoc)
		CalmActorFast(akRef)
		SetFurnitureStatus()
	EndFunction

	Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
		if RandomFloat()*100.0 < mind.fear_training && RandomFloat() < mind.MOD_Fearfulness
			SendNotificationEmotionMaster("Slave "+getName()+" shivers as "," is in sight")
			mind.TrainFear(0.5)
			is_struggling = false
		endif
	EndEvent

	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		LogAnim("OnAnimationEvent behaviour=restrained_in_furniture")
		CalmActorFast(akRef)
		SetFurnitureStatus()
	EndEvent

	string Function GetBehaviourString()
		return "restrained "
	EndFunction

	float Function GetBehaviourModifier()
		return 2.0
	EndFunction

	int Function GetBehaviourIndex()
		return 17 ; "restrained_in_furniture"
	EndFunction

	Function EndBehaviour()
		ExitTieUpSoft()
		akRef.RemoveFromFaction(DOM01.DOMActionTied)
		is_restrained = false
		is_struggling = false
		UnSetFurnitureStatus()
		UnregisterForAnimEvent()
		UnregisterForLOS(akRef, PlayerRef)
	EndFunction
EndState

state pose_in_furniture
	Function StartBehaviour()
		behaviour_working = false
		canMove = false
		canIdle = false
		canFight = false
		is_restrained = false
		SetLookAtTarget()
		CalmActorFast(akRef)	
		akRef.SetRestrained()
		if nextTiedInFurniture != None
			currentTiedInFurniture = nextTiedInFurniture
		else
			ObjectReference activeFurniture = DOM01.DOM02.GetActiveFurniture() 
			if activeFurniture != None
				currentTiedInFurniture = activeFurniture
			endif
		endif
		if currentTiedInFurniture == None
			SendNotificationAction(getName()+" "+actorBeVerb+" sitting in a furniture")
			SetMarkerAtPosition()
			target.ForceRefTo(PoseMarker)
		else
			SendNotificationAction(getName()+" "+actorBeVerb+" sitting in "+currentTiedInFurniture.GetBaseObject().getName())
			SetMarkerAtFurniture()
			target.ForceRefTo(currentTiedInFurniture)
		endif
		poseId = 3
		StartPose() ; register next poseId and poses
		SetFurnitureStatus()
		;akRef.moveTo(PoseMarker) ; moveTo makes actor get up from furniture!
		;akRef.SetVehicle(PoseMarker)
		akRef.SetFactionRank(DOM01.DOMActionPosing,2) ; 2 is pose in furniture
		mind.IncreaseArousal(20.0,mind.MOD_Sociability)
		RegisterForAnimEvent()
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=restrained_in_furniture start"))
	EndFunction

	Function OnBehaviourUpdate()
	EndFunction

	Function OnBehaviourUpdateGameTime()
		if !canAnimate
			return
		endif	
		int was_warned = mind.WillObeyBecauseWarned(15)
		if was_warned > 0
			mind.TrainPose(0.5)		
		elseif IsBreakingPose()
			Wait(1.0)
			if was_warned == 0 ; "didnt_pose"
				mind.SetNextPunishmentReasonForceMessage(15,"stops posing despite being warned") ; "didnt_pose"
			else
				mind.SetNextPunishmentReasonForceMessage(15,"chooses to stop posing") ; "didnt_pose"
			endif
			mind.RemoveNextPraiseReason(2) ; "being a good pet"
			akRef.AddToFaction(DOM01.DOMFailedToPose)
			EnterWait()
			return
		elseif RandomFloat() < mind.MOD_Discipline*0.5
			mind.TrainPose(0.5)
		endif
		if !was_pose_registered 
			float elapsed_time = GetCurrentGameTime()-timer_for_pose
			if elapsed_time > DOM01.pose_threshold ; almost 1 hour in days
				was_pose_registered = true
				mind.SetNextPraiseReasonSilent(2) ; "being a good pet"
			endif
		endif
		SetFurnitureStatus()
	EndFunction
	
	Function OnBehaviourLoad()
		CalmActorFast(akRef)
		SetFurnitureStatus()
	EndFunction
	
	Function OnBehaviourCellLoad()
		CalmActorFast(akRef)
		SetFurnitureStatus()
	EndFunction

	Function OnBehaviourLocationChange(Location akOldLoc, Location akNewLoc)
		CalmActorFast(akRef)
		SetFurnitureStatus()
	EndFunction

	Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
		if RandomFloat()*100.0 < mind.fear_training && RandomFloat() < mind.MOD_Fearfulness
			SendNotificationEmotionMaster("Slave "+getName()+" shivers as "," is in sight")
			mind.TrainFear(0.5)
			is_struggling = false
		endif
	EndEvent

	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		LogAnim("OnAnimationEvent behaviour=restrained_in_furniture")
		CalmActorFast(akRef)
		SetFurnitureStatus()
	EndEvent

	string Function GetBehaviourString()
		return "posing "
	EndFunction

	float Function GetBehaviourModifier()
		return 1.2
	EndFunction

	int Function GetBehaviourIndex()
		return 18 ; "pose_in_furniture"
	EndFunction

	Function EndBehaviour()
		ExitTieUpSoft()
		akRef.RemoveFromFaction(DOM01.DOMActionPosing)
		is_restrained = false
		is_struggling = false
		UnSetFurnitureStatus()
		UnregisterForAnimEvent()
		UnregisterForLOS(akRef, PlayerRef)
	EndFunction
EndState

; ### Behaviour states: TRAINING

int timer_for_punishing = 0
int cycle_for_punishing = 0
int timer_trainee_wait  = 0
bool __behaviour_working = false
bool Property behaviour_working Hidden
	bool Function get()
		return __behaviour_working
	EndFunction
	Function set(bool value)
		if value != __behaviour_working
			__behaviour_working = value
			if value
				akRef.SetPlayerTeammate(false,false)
				akRef.StopCombatAlarm()
				akRef.ClearLookAt()
				akRef.SetHeadTracking(false)
			else
				akRef.SetHeadTracking(true)
				SetCombatStatus()
			endif
		endif
	EndFunction
EndProperty

bool is_training = false
bool Function IsInTraining()
	if is_training
		return true
	endif
	if actor_trainer == None
		return false
	endif
	if actor_trainer.GetTrainer() != None
		return true ; Avoid trainers loop
	endif
	return actor_trainer.IsInTraining()
EndFunction

state punish_trainee
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = false
		canFight = true
		is_training = true
		if actor_trainee == None
			EnterWait()
			return
		endif
		Actor trRef = actor_trainee.akRef
		akRef.SetFactionRank(DOM01.DOMActionPunishing,3) ; 3 == punishing a slave
		target.ForceRefTo(trRef)
		akRef.SetHeadTracking(false)
		;akRef.SetAlert(true)
		akRef.KeepOffsetFromActor(trRef, 0.0, 70.0, 0.0, afCatchUpRadius = 150.0)
		akRef.SetLookAt(trRef, true)
		trRef.SetLookAt(akRef)
		timer_for_punishing = 0
		cycle_for_punishing = 0
		actor_trainee.StartWhipping(akRef)
		SendNotificationAction(title+name+" will punish "+actor_trainee_whipped.getName())
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=punish_trainee start")+" isPlayerTeammate="+akRef.IsPlayerTeammate())
		mind.CheckAndRegisterKink(101,1.0) ; "punishing slaves"
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime punish_trainee cycle="+cycle_for_punishing+" timer="+timer_for_punishing)
		PunishingUpdateGameTime(0)
	EndFunction
	
	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate punish_trainee cycle="+cycle_for_punishing+" timer="+timer_for_punishing)
		if actor_trainee_whipped == None || actor_trainee_whipped.akRef == None || actor_trainee_whipped.GetTrainer() != self
			actor_trainee = None
			actor_trainee_whipped = None
			EnterPunishTrainees()
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if (cycle_for_punishing % 2) == 0
			Actor trRef = actor_trainee_whipped.akRef
			FaceActor(akRef,trRef)
			;if akRef.Is3DLoaded()
			;	Anim_Attack()
			;endif
			;wait(1.0)
		else 
			actor_trainee_whipped.OnHit(akRef, akRef.GetEquippedWeapon(), None, false, false, false, false)
		endif
		cycle_for_punishing += 1
		timer_for_punishing += 1
		if timer_for_punishing > 20
			if actor_trainee_whipped
				SendNotificationOrder(title+name+" is done punishing "+actor_trainee_whipped.GetName())
			endif
			EnterPunishTrainees()
		endif
		if cycle_for_punishing >= 4
			cycle_for_punishing = 0
		endif
		;*ogTrace("behaviour=punish_trainee update cycle="+cycle_for_punishing+" timer="+timer_for_punishing+" isPlayerTeammate="+akRef.IsPlayerTeammate())
	EndFunction

	int Function GetBehaviourIndex()
		return 19 ; "punish_trainee"
	EndFunction

	Function EndBehaviour()
		is_training = false
		akRef.RemoveFromFaction(DOM01.DOMActionPunishing)
		akRef.EvaluatePackage()
		akRef.SheatheWeapon()
		akRef.SetHeadTracking(true)
		;akRef.SetAlert(false)
		akRef.ClearKeepOffsetFromActor()
		akRef.ClearLookAt()
		if actor_trainee_whipped != None
			SendNotificationAction(title+name+" ends punishment of "+actor_trainee_whipped.getName())
			actor_trainee_whipped.EndWhipping(akRef)
			mind.TrainTrainer()
		endif
		actor_trainee = None
	EndFunction
EndState

state fetch_trainee
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		is_training = true
		if actor_trainee == None
			EnterWait()
			return
		endif
		Actor trRef = actor_trainee.akRef
		SendNotificationAction(title+name+" will fetch "+actor_trainee.getName())
		akRef.SetFactionRank(DOM01.DOMActionPunishing,2) ; 2 == fetching slave
		akRef.SetLookAt(trRef)
		trRef.SetLookAt(akRef)
		target.ForceRefTo(trRef)
		if actor_trainee.canMove && actor_trainee.canIdle
			actor_trainee.EnterWait()
		endif
		timer_trainee_wait = 0
		;*ogTrace("behaviour=fetch_trainee start"))
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime fetch_trainee trainee="+actor_trainee.GetName())
		PunishingUpdateGameTime(0)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate fetch_trainee trainee="+actor_trainee.GetName())
		if actor_trainee == None || actor_trainee.akRef == None || actor_trainee.GetTrainer() != self
			actor_trainee = None
			EnterPunishTrainees()
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		Actor trRef = actor_trainee.akRef
		if (akRef.GetDistance(trRef) < 100.0)
			EnterPunishTrainee(actor_trainee)
			FaceActor(akRef,trRef)
		elseif timer_trainee_wait > 4
			akRef.MoveTo(trRef, 70.0 * Math.Sin(trRef.GetAngleZ()), 70.0 * Math.Cos(trRef.GetAngleZ()), 0, true) ; Teleport to trainer
			FaceActor(akRef,trRef)
		else
			timer_trainee_wait += 1
		endif
		;*ogTrace("behaviour=fetch_trainee update trainee="+actor_trainee.GetName()+" timer="+timer_trainee_wait)
	EndFunction

	int Function GetBehaviourIndex()
		return 20 ; "fetch_trainee"
	EndFunction

	Function EndBehaviour()
		is_training = false
		akRef.RemoveFromFaction(DOM01.DOMActionPunishing)
		akRef.ClearLookAt()
	EndFunction
EndState

state punishing
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		is_training = true
		SendNotificationAction(title+name+" will punish trainees")
		CalmActorFast(akRef)
		DOM01.DOMEquip.EquipWhip(akRef)
		akRef.SetFactionRank(DOM01.DOMActionPunishing,1) ; 1 == waiting for decision
		actor_trainee = None
		;*ogTrace("behaviour=punishing start"))
		cycle_for_punishing = 0
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime punishing cycle="+cycle_for_punishing)
		PunishingUpdateGameTime(0)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate punishing cycle="+cycle_for_punishing)
		if GettraineeCount() < 1
			EnterWait()
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if cycle_for_punishing == 0
			cycle_for_punishing = 1
			if GetTraineeCount() > 1
				if DOM01.punishPoseToggle && DOM01.punishTieToggle
					PoseOrRestrainTrainees()
				elseif DOM01.punishPoseToggle
					PoseTrainees()
				elseif DOM01.punishTieToggle
					SecureTrainees()
				endif
			endif
		else
			; Choose trainee to punish
			DOM_Actor akTraineeActor = GetNextTraineeForPunishment()
			;*ogTrace("behaviour=punishing update trainee="+akTraineeActor)
			EnterFetchTrainee(akTraineeActor)
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 21 ; "punishing"
	EndFunction

	Function EndBehaviour()
		is_training = false
		DOM01.DOMEquip.UnequipWhip(akRef)
		akRef.RemoveFromFaction(DOM01.DOMActionPunishing)
	EndFunction
EndState

float trainerTimer = 0.0
Function PunishingUpdateGameTime(int type) ; 0 is whipping 1 is sexing
	if akRef.Is3DLoaded()
		trainerTimer = 0.0
	endif
	if trainerTimer == 0.0
		trainerTimer = GetCurrentGameTime()
		return
	endif
	float elapsed_time = GetCurrentGameTime()-trainerTimer ; in days
	if elapsed_time >= 1.0
		; 1 day has passed
		;LogTrace("One day has passed without actual training type="+type+" elapsed time="+elapsed_time)
	endif
EndFunction

; ### Behaviour states: SEX TRAINING

state train_trainee
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = false
		is_training = true
		if actor_trainee == None
			EnterWait()
			return
		endif
		Actor trRef = actor_trainee.akRef
		SendNotificationAction(title+name+" will train "+actor_trainee.getName()+" in the sexual arts")
		akRef.SetFactionRank(DOM01.DOMActionTraining,3) ; 3 == sex with slave
		target.ForceRefTo(trRef)
		akRef.SetLookAt(trRef, true)
		trRef.SetLookAt(akRef)
		timer_for_punishing = 0
		cycle_for_punishing = 0
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=train_trainee start"))
		mind.CheckAndRegisterKink(102,1.0) ; "training sex slaves"
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime train_trainee cycle="+cycle_for_punishing+" timer="+timer_for_punishing)
		PunishingUpdateGameTime(1)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate train_trainee cycle="+cycle_for_punishing+" timer="+timer_for_punishing)
		if actor_trainee == None || actor_trainee.akRef == None || actor_trainee.GetTrainer() != self
			actor_trainee = None
			EnterTrainSexTrainees()
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if timer_for_punishing == 0 ; Start scene
			;*ogTrace("behaviour=train_trainee starting Sexlab")
			mind.punishing_trainee_or_trainer = true
			DOM_Mind mind_trainee = actor_trainee.mind
			string tags = ""
			if mind_trainee.oral_training > mind_trainee.anal_training && mind_trainee.vaginal_training > mind_trainee.anal_training
				tags = "Anal"
			elseif mind_trainee.vaginal_training > mind_trainee.oral_training && mind_trainee.anal_training > mind_trainee.oral_training
				tags = "Oral"
			else
				tags = "Vaginal"
			endif
			mind.sex_is_non_consensual = false
			actor_trainee.StartPunishingWithTag(akRef, "", "rape", tags)
			timer_for_punishing = 1
		else
			;*ogTrace("behaviour=train_trainee Sexlab ended but didn't get any notification")
			timer_for_punishing += 1
			if akRef.Is3DLoaded() || timer_for_punishing > 120 ; approximately 120 seconds or 40 minutes Skyrim time
				;*ogTrace("behaviour=train_trainee Sexlab ended but didn't get any notification after "+timer_for_punishing+" seconds is3DLoaded="+akRef.Is3DLoaded())
				if actor_trainee
					SendNotificationAction(title+name+" is done training "+actor_trainee.getName()+" in the sexual arts")
				endif
				EnterTrainSexTrainees()
			endif
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 22 ; "train_trainee"
	EndFunction

	Function EndBehaviour()
		is_training = false
		akRef.RemoveFromFaction(DOM01.DOMActionTraining)
		akRef.ClearLookAt()
		if actor_trainee != None
			SendNotificationAction(title+name+" ends punishment of "+actor_trainee.getName())
			actor_trainee.mind.punishing_trainee_or_trainer = false
			mind.punishing_trainee_or_trainer = false
			mind.TrainSexTrainer()
			actor_trainee = None
		endif
	EndFunction
EndState

state fetch_sextrainee
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		is_training = true
		if actor_trainee == None
			EnterWait()
			return
		endif
		Actor trRef = actor_trainee.akRef
		SendNotificationAction(title+name+" will fetch "+actor_trainee.getName())
		akRef.SetFactionRank(DOM01.DOMActionTraining,2) ; 2 == fetching slave
		akRef.SetLookAt(trRef)
		trRef.SetLookAt(akRef)
		target.ForceRefTo(trRef)
		if actor_trainee.canMove && actor_trainee.canIdle
			actor_trainee.EnterWait()
		endif
		timer_trainee_wait = 0
		;*ogTrace("behaviour=fetch_sextrainee start"))
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime fetch_sextrainee trainee="+actor_trainee.GetName())
		PunishingUpdateGameTime(1)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate fetch_sextrainee trainee="+actor_trainee.GetName())
		if actor_trainee == None || actor_trainee.akRef == None || actor_trainee.GetTrainer() != self
			actor_trainee = None
			EnterTrainSexTrainees()
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		Actor trRef = actor_trainee.akRef
		if !actor_trainee.canAnimateSexlab
			return
		endif
		if trRef.IsInDialogueWithPlayer()
			return
		endif
		if trRef.IsInDialogueWithPlayer()
			return
		endif
		if !actor_trainee.canAnimateLocal
			return
		endif
		if (akRef.GetDistance(trRef) < 100.0)
			EnterTrainSexTrainee(actor_trainee)
			FaceActor(akRef,trRef)
		elseif timer_trainee_wait > 4
			akRef.MoveTo(trRef, 70.0 * Math.Sin(trRef.GetAngleZ()), 70.0 * Math.Cos(trRef.GetAngleZ()), 0, true) ; Teleport trainer
			FaceActor(akRef,trRef)
		else
			timer_trainee_wait += 1
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 23 ; "fetch_sextrainee"
	EndFunction

	Function EndBehaviour()
		is_training = false
		akRef.RemoveFromFaction(DOM01.DOMActionTraining)
		akRef.ClearLookAt()
	EndFunction
EndState

state sextraining
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		is_training = true
		SendNotificationAction(title+name+" will train slaves in the sexual arts")
		CalmActorFast(akRef)
		akRef.SetFactionRank(DOM01.DOMActionTraining,1) ; 1 == waiting for decision
		actor_trainee = None
		;*ogTrace("behaviour=sextraining start"))
		cycle_for_punishing = 0
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime sextraining cycle="+cycle_for_punishing)
		PunishingUpdateGameTime(1)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate sextraining cycle="+cycle_for_punishing)
		if GettraineeCount() < 1
			EnterWait()
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if cycle_for_punishing == 0
			cycle_for_punishing = 1
			if GetTraineeCount() > 1
				if DOM01.punishMasturbateToggle && DOM01.punishRestrainToggle
					MasturbateOrRestrainTrainees()
				elseif DOM01.punishMasturbateToggle
					MasturbateTrainees()
				elseif DOM01.punishRestrainToggle
					SecureTrainees()
				endif
			endif	
		else
			; Choose trainee to punish
			DOM_Actor akTraineeActor = GetNextTraineeForSex()
			EnterFetchSexTrainee(akTraineeActor)
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 24 ; "sextraining"
	EndFunction

	Function EndBehaviour()
		is_training = false
		behaviour_working = false
		akRef.RemoveFromFaction(DOM01.DOMActionTraining)
	EndFunction
EndState

; ### Behaviour states: THREESOME/FOURSOME TRAINING

state orgy_trainees
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = false
		is_training = true
		if actor_trainee == None
			EnterWait()
			return
		endif
		Actor trRef = actor_trainee.akRef
		SendNotificationAction(title+name+" will train "+actor_trainee.getName()+" with sexual orgies")
		akRef.SetFactionRank(DOM01.DOMActionTraining,13) ; 13 == sex with slaves
		target.ForceRefTo(trRef)
		akRef.SetLookAt(trRef, true)
		trRef.SetLookAt(akRef)
		timer_for_punishing = 0
		cycle_for_punishing = 0
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=orgy_trainees start"))
		mind.CheckAndRegisterKink(102,1.0) ; "training sex slaves"
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime orgy_trainees cycle="+cycle_for_punishing+" timer="+timer_for_punishing)
		PunishingUpdateGameTime(1)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate orgy_trainees cycle="+cycle_for_punishing+" timer="+timer_for_punishing)
		if actor_trainee == None || actor_trainee.akRef == None || actor_trainee.GetTrainer() != self
			actor_trainee = None
			EnterTrainOrgyTrainees(actor_trainee,actor_trainee2,actor_trainee3)
			return
		endif
		if actor_trainee2 == None || actor_trainee2.akRef == None || actor_trainee2.GetTrainer() != self
			actor_trainee2 = None
			EnterTrainOrgyTrainees(actor_trainee,actor_trainee2,actor_trainee3)
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if timer_for_punishing == 0 ; Start scene
			;*ogTrace("behaviour=orgy_trainees starting Sexlab")
			mind.punishing_trainee_or_trainer = true
			DOM_Mind mind_trainee = actor_trainee.mind
			string tags = ""
			if mind_trainee.oral_training > mind_trainee.anal_training && mind_trainee.vaginal_training > mind_trainee.anal_training
				tags = "Anal"
			elseif mind_trainee.vaginal_training > mind_trainee.oral_training && mind_trainee.anal_training > mind_trainee.oral_training
				tags = "Oral"
			else
				tags = "Vaginal"
			endif
			mind.sex_is_non_consensual = false
			if actor_trainee3 != None
				if actor_trainee3.akRef == None || actor_trainee3.GetTrainer() != self
					actor_trainee3 = None
				endif
			endif
			if actor_trainee3 == None
				actor_trainee.Anim_SexlabWith3AAA(actor_trainee2, self, tags, true) ; self is leading & punishment
			else
				actor_trainee.Anim_SexlabWith4AAAA(actor_trainee2, actor_trainee3, self, tags, true) ; self is leading & punishment
			endif
			timer_for_punishing = 1
		else
			;*ogTrace("behaviour=train_trainee Sexlab ended but didn't get any notification")
			timer_for_punishing += 1
			if akRef.Is3DLoaded() || timer_for_punishing > 120 ; approximately 120 seconds or 40 minutes Skyrim time
				;*ogTrace("behaviour=orgy_trainees Sexlab ended but didn't get any notification after "+timer_for_punishing+" seconds is3DLoaded="+akRef.Is3DLoaded())
				if actor_trainee
					SendNotificationAction(title+name+" is done training "+actor_trainee.getName()+" with sexual orgies")
				endif
				EnterTrainOrgy()
			endif
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 25 ; "orgy_trainees"
	EndFunction

	Function EndBehaviour()
		is_training = false
		akRef.RemoveFromFaction(DOM01.DOMActionTraining)
		akRef.ClearLookAt()
		if actor_trainee != None
			SendNotificationAction(title+name+" ends punishment of "+actor_trainee.getName())
			actor_trainee.mind.punishing_trainee_or_trainer = false
			mind.punishing_trainee_or_trainer = false
			mind.TrainSexTrainer()
			actor_trainee = None
		endif
		actor_trainee2 = None
		actor_trainee3 = None
	EndFunction
EndState

state fetch_orgytrainees
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		is_training = true
		if actor_trainee == None
			EnterWait()
			return
		endif
		Actor trRef = actor_trainee.akRef
		SendNotificationAction(title+name+" will fetch "+actor_trainee.getName())
		akRef.SetFactionRank(DOM01.DOMActionTraining,12) ; 12 == fetching slaves
		akRef.SetLookAt(trRef)
		trRef.SetLookAt(akRef)
		target.ForceRefTo(trRef)
		if actor_trainee.canMove && actor_trainee.canIdle
			actor_trainee.EnterWait()
		endif
		if actor_trainee2.canMove && actor_trainee2.canIdle
			actor_trainee2.EnterFollowTrainer()
		endif
		if actor_trainee3 != None
			if actor_trainee3.canMove && actor_trainee3.canIdle
				actor_trainee3.EnterFollowTrainer()
			endif
		endif
		timer_trainee_wait = 0
		;*ogTrace("behaviour=fetch_orgytrainees start"))
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime fetch_orgytrainees trainee="+actor_trainee.GetName())
		PunishingUpdateGameTime(1)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate fetch_orgytrainees trainee="+actor_trainee.GetName())
		if actor_trainee == None || actor_trainee.akRef == None || actor_trainee.GetTrainer() != self
			actor_trainee = None
			EnterTrainOrgyTrainees(actor_trainee,actor_trainee2,actor_trainee3)
			return
		endif
		if actor_trainee2 == None || actor_trainee2.akRef == None || actor_trainee2.GetTrainer() != self
			actor_trainee2 = None
			EnterTrainOrgyTrainees(actor_trainee,actor_trainee2,actor_trainee3)
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		Actor trRef = actor_trainee.akRef
		if !actor_trainee.canAnimateSexlab
			return
		endif
		if trRef.IsInDialogueWithPlayer()
			return
		endif
		if !actor_trainee.canAnimateLocal
			return
		endif
		Actor trRef2 = actor_trainee2.akRef
		if !actor_trainee2.canAnimateSexlab
			return
		endif
		if trRef2.IsInDialogueWithPlayer()
			return
		endif
		if !actor_trainee2.canAnimateLocal
			return
		endif
		if actor_trainee3 != None
			if actor_trainee3.akRef == None || actor_trainee3.GetTrainer() != self
				actor_trainee3 = None
			else
				Actor trRef3 = actor_trainee3.akRef
				if !actor_trainee3.canAnimateSexlab
					return
				endif
				if trRef3.IsInDialogueWithPlayer()
					return
				endif
				if !actor_trainee3.canAnimateLocal
					return
				endif
			endif
		endif
		if (akRef.GetDistance(trRef) < 100.0)
			EnterTrainOrgyTrainees(actor_trainee,actor_trainee2,actor_trainee3)
			FaceActor(akRef,trRef)
		elseif timer_trainee_wait > 4
			akRef.MoveTo(trRef, 70.0 * Math.Sin(trRef.GetAngleZ()), 70.0 * Math.Cos(trRef.GetAngleZ()), 0, true) ; Teleport trainer
			FaceActor(akRef,trRef)
		else
			timer_trainee_wait += 1
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 26 ; "fetch_orgytrainees"
	EndFunction

	Function EndBehaviour()
		is_training = false
		akRef.RemoveFromFaction(DOM01.DOMActionTraining)
		akRef.ClearLookAt()
	EndFunction
EndState

state orgytraining
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		is_training = true
		SendNotificationAction(title+name+" will train slaves in orgies")
		CalmActorFast(akRef)
		akRef.SetFactionRank(DOM01.DOMActionTraining,11) ; 11 == waiting for decision
		actor_trainee = None
		actor_trainee2 = None
		actor_trainee3 = None
		;*ogTrace("behaviour=orgytraining start"))
		cycle_for_punishing = 0
	EndFunction

	Function OnBehaviourUpdateGameTime()
		;*ogTrace("OnBehaviourUpdateGameTime orgytraining cycle="+cycle_for_punishing)
		PunishingUpdateGameTime(1)
	EndFunction

	Function OnBehaviourUpdate()
		;*ogTrace("OnBehaviourUpdate orgytraining cycle="+cycle_for_punishing)
		if GettraineeCount() < 2
			if GettraineeCount() > 0
				EnterSexTraining()
			else
				EnterWait()
			endif
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if cycle_for_punishing == 0
			cycle_for_punishing = 1
			if GetTraineeCount() > 1
				if DOM01.punishMasturbateToggle && DOM01.punishRestrainToggle
					MasturbateOrRestrainTrainees()
				elseif DOM01.punishMasturbateToggle
					MasturbateTrainees()
				elseif DOM01.punishRestrainToggle
					SecureTrainees()
				endif
			endif	
		else
			; Choose trainee to punish
			DOM_Actor akTraineeActor1 = GetNextTraineeForSex()
			DOM_Actor akTraineeActor2 = GetSupplementaryTraineeForSex1(akTraineeActor1)
			DOM_Actor akTraineeActor3
			if GetTraineeCount() > 2 && RandomInt(1,5) > 3
				akTraineeActor3 = GetSupplementaryTraineeForSex2(akTraineeActor1,akTraineeActor2)
			else
				akTraineeActor3 = None
			endif 
			EnterFetchOrgyTrainees(akTraineeActor1,akTraineeActor2,akTraineeActor3)
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 27 ; "orgytraining"
	EndFunction

	Function EndBehaviour()
		behaviour_working = false
		is_training = false
		akRef.RemoveFromFaction(DOM01.DOMActionTraining)
	EndFunction
EndState

; ### Behaviour states: WORKING

int timer_for_work = 0
bool is_pickingUpMess = false
bool is_working = false ; is_working with tools

state clean_house
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		akRef.SetFactionRank(DOM01.DOMActionSweeping,2)	
		if !akRef.IsInFaction(DOM01.DOMWaitMode)
			akRef.SetFactionRank(DOM01.DOMWaitMode,DOM01.defaultWaitMode)
		endif
		is_working = true
		DOM01.DOMEquip.EquipBroom(akRef)
		timer_for_work = 0
		is_pickingUpMess = false
		if is_shamed
			mind.number_of_shame += 1
		endif
		if mind.IsDevoted()
			mind.IncreaseArousal(5.0,mind.MOD_Hope)
		endif
		on_update_gametime = false
		SendNotificationAction(title+name+" will tidy up the area")
		;*ogTrace("behaviour=clean_house start"))
		OnBehaviourUpdateGameTime()
	EndFunction
	
	Function OnBehaviourUpdateGameTime()	
		;*ogTrace("behaviour=clean_house canAnimate="+canAnimateSexlabLocal+" "+!akRef.IsInDialogueWithPlayer())	
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if IsBreakingWork()
			;*ogTrace("behaviour=clean_house - starts moving by formula")	
			mind.SetNextPunishmentReasonSilent(10) ; "being a bad maid"
			mind.RemoveNextPraiseReason(10) ; "being a good maid"
			EnterWaitSandbox()
		elseif mind.IsWillingToClean()
			if timer_for_work == 0 || timer_for_work == 9 ; Starts to clean
				;*ogTrace("behaviour=clean_house - starts to clean")	
				if akRef.GetFactionRank(DOM01.DOMActionSweeping) != 1
					akRef.SetFactionRank(DOM01.DOMActionSweeping,1)
					akRef.EvaluatePackage()
					Anim_Sweep()
				endif
				mind.SetNextPraiseReasonSilent(10) ; "being a good maid"
				mind.TrainHouse(1.0)
			elseif timer_for_work == 8 || timer_for_work == 15
				;*ogTrace("behaviour=clean_house - starts to pickup objects")	
				if akRef.GetFactionRank(DOM01.DOMActionSweeping) != 2
					akRef.SetFactionRank(DOM01.DOMActionSweeping,2)
					akRef.EvaluatePackage()
					Anim_IdleReset()
				endif
				CleanTheMess()
			elseif timer_for_work == 16 ; A bit of sandboxing
				;*ogTrace("behaviour=clean_house - starts to sandbox")	
				if akRef.GetFactionRank(DOM01.DOMActionSweeping) != 3
					akRef.SetFactionRank(DOM01.DOMActionSweeping,3)
					akRef.EvaluatePackage()
					Anim_IdleReset()
				endif
			else
				;*ogTrace("behaviour=clean_house busy timer="+timer_for_work)	
			endif
			timer_for_work += 1
			;*ogTrace("behaviour=clean_house 1 timer="+timer_for_work)	
			if timer_for_work > 24
				timer_for_work = 0
			elseif akRef.GetFactionRank(DOM01.DOMActionSweeping) == 1
				Anim_Sweep()
			endif
			;*ogTrace("behaviour=clean_house 2 timer="+timer_for_work)	
		else
			;*ogTrace("behaviour=clean_house - idling")	
			if akRef.GetFactionRank(DOM01.DOMActionSweeping) != 3
				akRef.SetFactionRank(DOM01.DOMActionSweeping,3)
				akRef.EvaluatePackage()
				Anim_IdleReset()				
			endif
		endif
	EndFunction
	
	int Function GetBehaviourIndex()
		return 28 ; "clean_house"
	EndFunction

	Function EndBehaviour()
		behaviour_working = false
		is_working = false
		akRef.RemoveFromFaction(DOM01.DOMActionSweeping)
		DOM01.DOMEquip.UnequipBroom(akRef)
	EndFunction
EndState

state guard
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		akRef.AddToFaction(DOM01.DOMActionGuard)
		SendNotificationAction(title+name+" will guard this area")
		;*ogTrace("behaviour=guard start"))
	EndFunction

	int Function GetBehaviourIndex()
		return 29 ; "guard"
	EndFunction

	string Function GetBehaviourTitle()
		if on_duty_string != ""
			return on_duty_string
		endif
		return behaviour
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionGuard)
		on_duty_string = ""
	EndFunction
EndState

state travel
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = false
		if CampMarker == None
			SetCamp()
		endif
		target.ForceRefTo(CampMarker)
		akRef.AddToFaction(DOM01.DOMActionTravel)
		SendNotificationAction(title+name+" will travel to camp in "+camp_name)
		;*ogTrace("behaviour=travel start"))
		;LogTrace("target="+target.GetRef())
		;LogTrace("camp="+CampMarker)
	EndFunction

	Function OnBehaviourUpdateGameTime()	
		LogTrace("TRAVEL target="+target+" ref="+target.GetRef()+" camp="+CampMarker+" distance="+GetObjectDistance(akRef,target.GetRef()))
		; Check if arrived at destination
		if IsTogetherWithFast(akRef, target.GetRef(), 150.0)
			int n =  GetTraineeCount()
			int rank = akRef.GetFactionRank(DOM01.DOMTravelMode)
			if n <= 0 || rank == 0
				EnterWaitSandbox()
			elseif rank == 1 ; punish slaves
				EnterPunishTrainees()
			elseif rank == 2 ; guard slaves and join HSH camp if nearby
				EnterGuardCamp()
			elseif rank == 3 ; train slaves sexually
				EnterTrainSexTrainees()
			else
				EnterDropTraineesAndComeBack()
			endif
		else
			akRef.EvaluatePackage()
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 30 ; "travel"
	EndFunction

	Function EndBehaviour()
		behaviour_working = false
		akRef.RemoveFromFaction(DOM01.DOMActionTravel)
	EndFunction
EndState

; # Jail
; # Jail stand still
state jail_stand
	Function StartBehaviour()
		behaviour_working = false
		canIdle = true
		canMove = true
		canFight = false
		is_jailed = true
		akRef.SetFactionRank(DOM01.DOMActionJailed,1)
		akRef.SetFactionRank(DOM01.DOMJailMode,1)
		SendNotificationAction(name+" will stand in jail")
		;*ogTrace("behaviour=jail_stand start"))
		mind.CheckAndRegisterKink(75,2.0)
	EndFunction

	Function OnBehaviourUpdate()
		if IsBreakingWait()
			mind.SetNextPunishmentReasonForceMessage(16,"chooses to stop waiting") ; "didnt_wait"
			EnterJailSandbox()
			return
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 31 ; "jail_stand"
	EndFunction

	Function EndBehaviour()
		is_jailed = false
		akRef.RemoveFromFaction(DOM01.DOMActionJailed)
	EndFunction
EndState

State jail_sandbox
	Function StartBehaviour()
		behaviour_working = false
		canIdle = true
		canMove = true
		canFight = false
		is_jailed = true
		akRef.SetFactionRank(DOM01.DOMActionJailed,2)
		akRef.SetFactionRank(DOM01.DOMJailMode,2)
		SetSandboxStatus()
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		SendNotificationAction(name+" will be jailed")
		;*ogTrace("behaviour=jail_sandbox start"))
		mind.CheckAndRegisterKink(75,2.0)
	EndFunction
	
	Function OnBehaviourUpdateGameTime()
		if !canIdle
			return
		endif
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if wait_activity_timer > 40
			SetSandboxStatus()
			if wait_activity <= 0
				akRef.SetFactionRank(DOM01.DOMActionJailed,2) ; sandbox
				akRef.EvaluatePackage()
			elseif wait_activity >= 100
				akRef.SetFactionRank(DOM01.DOMActionJailed,100) ; posing in furniture
				akRef.EvaluatePackage()
			else
				akRef.SetFactionRank(DOM01.DOMActionJailed,1) ; stand still
				akRef.EvaluatePackage()
			endif
		endif
		wait_activity_timer += 1
		if wait_activity >= 100
			SetFurnitureStatus()
		elseif wait_activity > 0
			wait_activity_timer += 1
			Anim_IdleByString(quietPose)
		endif
	EndFunction

	int Function GetBehaviourIndex()
		return 32 ; "jail_sandbox"
	EndFunction

	Function EndBehaviour()
		is_jailed = false
		akRef.RemoveFromFaction(DOM01.DOMActionJailed)
		DoStandUp()
	EndFunction
EndState

state jail_restrained
	Function StartBehaviour()
		behaviour_working = false
		canMove = false
		canIdle = false
		canFight = false
		is_restrained = true
		is_jailed = true
		SetLookAtTarget()
		CalmActorFast(akRef)	
		akRef.SetRestrained()
		poseId = 1
		StartPose() ; register next poseId and poses
		SetPoseStatus()
		SetMarkerAtPosition()
		akRef.SetFactionRank(DOM01.DOMActionJailed,3)
		akRef.SetFactionRank(DOM01.DOMActionTied,3)
		akRef.SetFactionRank(DOM01.DOMJailMode,3)
		if is_shamed
			mind.number_of_shame += 1
		endif
		mind.IncreaseArousal(15.0,mind.MOD_Sociability)
		RegisterForAnimEvent()
		on_update_gametime = false
		OnBehaviourUpdateGameTime()
		;*ogTrace("behaviour=jail_restrained start"))
		mind.CheckRestrainedKinks(quietPose)
		mind.CheckAndRegisterKink(75,2.0)
	EndFunction
	
	Function OnBehaviourUpdate()
		if !DOM01.poseMoveToggle || PoseMarker == None || akRef.IsInDialogueWithPlayer() || !canAnimateSexlab
			return
		endif
		if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
			SetMarkerAtPosition()
			if PoseMarker.GetParentCell() == DOM01.AAADOMTestTony
				PoseMarker = None
				return
			endif
		endif
		akRef.MoveTo(PoseMarker)
	EndFunction

	Function OnBehaviourUpdateGameTime()
		; No escape possible, assume pose has chains included
		if IsBreakingTieup()
			RegisterForSingleLOSGain(akRef, PlayerRef)
			if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
				mind.TrainForBondage(0.5)
				mind.TrainPose(0.5)
			elseif IsBreakingRestraint(equipped_cuffs)
				;LogTrace("breaking restraints behaviour=jail_restrained")	
				mind.SetNextPunishmentReasonForceMessage(24,"managed to break free!") ; "breaking restraints"
				RemoveCuffs()
				EnterJailSandbox()
				return
			else
				mind.SetNextPunishmentReasonSilent(7) ; "struggling"
				timer_for_pose = GetCurrentGameTime()
				is_struggling = true
				;*ogTrace("OnBehaviourUpdate behaviour=chained struggle")
				Anim_PoseByString(strugglePose)
			endif
		else
			UnregisterForLOS(akRef, PlayerRef)
			if mind.WillObeyBecauseWarned(7,0.5) > 0 ; "struggling"
				mind.TrainForDiscipline(0.25)
				mind.TrainPose(0.5)
			endif
			is_struggling = false
			;*ogTrace("OnBehaviourUpdate behaviour=chained quiet")
			Anim_PoseByString(quietPose)
		endif
		if !was_pose_registered 
			float elapsed_time = GetCurrentGameTime()-timer_for_pose
			if elapsed_time > DOM01.pose_threshold ; almost 1 hour in days
				was_pose_registered = true
				if mind.is_love_interest
					mind.SetNextPraiseReasonSilent(7) ; "being a good bondage pet"
				else
					mind.SetNextPraiseReasonSilent(1) ; "being a good slave"
				endif
			endif
		endif
	EndFunction
	
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		LogAnim("OnAnimationEvent behaviour=chained")
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndEvent
	
	Function OnBehaviourLoad()
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction
	
	Function OnBehaviourCellLoad()
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction

	Function OnBehaviourLocationChange(Location akOldLoc, Location akNewLoc)
		SetPoseStatus()
		CalmActorFast(akRef)
		Anim_Pose()
	EndFunction
	
	Event OnGainLOS(Actor akViewer, ObjectReference akTarget)
		if RandomFloat()*100.0 < mind.fear_training && RandomFloat() < mind.MOD_Fearfulness
			SendNotificationEmotionMaster("Slave "+name+" shivers as "," is in sight")
			mind.TrainFear(0.25)
			mind.TrainForDiscipline(0.25)
			is_struggling = false
			Anim_PoseByString(quietPose)
		endif
	EndEvent

	string Function GetBehaviourString()
		return "restrained "
	EndFunction

	float Function GetBehaviourModifier()
		return 1.5
	EndFunction

	int Function GetBehaviourIndex()
		return 33 ; "jail_restrained"
	EndFunction

	Function EndBehaviour()
		is_jailed = false
		akRef.RemoveFromFaction(DOM01.DOMActionJailed)
		ExitTieUpSoft()
		akRef.RemoveFromFaction(DOM01.DOMActionTied)
		is_restrained = false
		is_struggling = false
		UnregisterForAnimEvent()
		UnregisterForLOS(akRef, PlayerRef)
	EndFunction
EndState


state jail_travel
	Function StartBehaviour()
		behaviour_working = false
		canIdle = true
		canMove = true
		canFight = false
		is_jailed = true
		akRef.SetFactionRank(DOM01.DOMActionJailed,0)
		workplace = None
		target.Clear()
		timer_for_work = 0
		on_update_gametime = false
		SendNotificationAction(title+name+" will find a jail around here")
		;*ogTrace("behaviour=jail_travel start"))
		OnBehaviourUpdateGameTime()
	EndFunction
	
	Function OnBehaviourUpdateGameTime()	
		;*ogTrace("behaviour=jail_travel canAnimate="+canAnimateSexlabLocal+" "+!akRef.IsInDialogueWithPlayer())	
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if workplace == None
			workplace = GetNearbyJail(workplace,2000.0)
			if workplace == None
				;*ogTrace("Could not find any suitable jail place mode="+akRef.GetFactionRank(DOM01.DOMJailMode))
				SendNotificationAction(name+" could not find any suitable jail place")
				EnterJailByMode()
				return
			else
				akRef.SetFactionRank(DOM01.DOMActionTravel,1)
				akRef.EvaluatePackage()
				Anim_IdleReset()
				SendNotificationAction(title+name+" will travel to "+workplace.GetDisplayName())
				target.ForceRefTo(workplace)
				akRef.EvaluatePackage()
			endif
			timer_for_work = 0
		endif
		if !IsTogetherWithFast(akRef,workplace, 150.0) ; 2.0 m
			;*ogTrace("behaviour=jail_travel - walking to jail distance="+GetObjectDistance(akRef,workplace))	
			timer_for_work += 1
			if timer_for_work > 24
				akRef.MoveTo(workplace, 64.0, 0.0, 1.0,true) ; match rotation
				;*ogTrace("behaviour=jail_travel - teleport to jail distance="+GetObjectDistance(akRef,workplace))	
				timer_for_work = 0
			endif
		else ; arrived
			EnterJailByMode()
		endif
	EndFunction
	
	int Function GetBehaviourIndex()
		return 34 ; "jail_travel"
	EndFunction

	Function EndBehaviour()
		behaviour_working = false
		akRef.RemoveFromFaction(DOM01.DOMActionJailed)
		akRef.RemoveFromFaction(DOM01.DOMActionTravel)
	EndFunction
EndState

; Showering
bool Property is_showering = false Auto Hidden
state showering
	Function StartBehaviour()
		is_showering = true
		behaviour_working = false
		canIdle = false
		canMove = false
		canFight = false
		akRef.SetFactionRank(DOM01.DOMActionWaiting,7)
		SendNotificationAction(name+" starts cleaning "+actorObjective+"self")
		;*ogTrace("behaviour=showering start"))
	EndFunction

	int Function GetBehaviourIndex()
		return 35 ; "showering"
	EndFunction

	bool Function CanResetBehaviour()
		return false
	EndFunction

	Function EndBehaviour()
		akRef.RemoveFromFaction(DOM01.DOMActionWaiting)
		is_showering = false
	EndFunction
EndState

ObjectReference workplace = None
ObjectReference workplace_furniture = None
MiscObject workplace_ore = None
ObjectReference Function GetWorkingPlace()
	return workplace
EndFunction


bool should_hold_weapons_outside_mining = false

state work
	Function StartBehaviour()
		behaviour_working = true
		canMove = true
		canIdle = true
		canFight = true
		akRef.SetFactionRank(DOM01.DOMActionWorking,1)	
		if !akRef.IsInFaction(DOM01.DOMWorkMode)
			akRef.SetFactionRank(DOM01.DOMWorkMode,1)
		endif
		is_working = true
		should_hold_weapons_outside_mining = mind.should_hold_weapons
		mind.should_hold_weapons = true
		DOM01.DOMEquip.EquipPick(akRef)
		workplace = None
		target.Clear()
		timer_for_work = 0
		on_update_gametime = false
		SendNotificationAction(title+name+" will find work around here")
		;*ogTrace("behaviour=work start"))
		OnBehaviourUpdateGameTime()
	EndFunction
	
	Function OnBehaviourUpdateGameTime()	
		;*ogTrace("behaviour=work canAnimate="+canAnimateSexlabLocal+" "+!akRef.IsInDialogueWithPlayer())	
		if !canAnimateSexlab
			return
		endif
		if akRef.IsInDialogueWithPlayer()
			return
		endif
		if !canAnimateLocal
			return
		endif
		if workplace == None && !workplace_lookup_busy
			;*ogTrace("behaviour=work - get working place timer_for_work="+timer_for_work)	
			workplace = GetNewWorkplace()
			if workplace == None
				;*ogTrace("Could not find any suitable working place mode="+akRef.GetFactionRank(DOM01.DOMWorkMode))
				SendNotificationAction(name+" could not find any suitable working place")
				EnterWaitSandbox()
				return
			else
				target.ForceRefTo(workplace_furniture)
				if akRef.GetFactionRank(DOM01.DOMActionWorking) != 1
					akRef.SetFactionRank(DOM01.DOMActionWorking,1)
					Anim_IdleReset()
					akRef.EvaluatePackage()
				endif
				SendNotificationAction(title+name+" will work at "+workplace.GetDisplayName())
				akRef.EvaluatePackage()
			endif
			timer_for_work = 0
		endif
		if IsBreakingWork()
			;*ogTrace("behaviour=work - chooses to stop working timer_for_work="+timer_for_work)	
			mind.SetNextPunishmentReasonOnceMessage(30,"doesn't want to work") ; "being a bad worker"
			mind.RemoveNextPraiseReason(11) ; "being a good worker"
			EnterWaitSandbox()
		elseif !IsTogetherWithFast(akRef,workplace_furniture, 1000.0) ; 15 m
			;*ogTrace("behaviour=work - walking to workplace distance="+GetObjectDistance(akRef,workplace_furniture)+" timer_for_work="+timer_for_work+" furniture="+workplace_furniture)	
			;timer_for_work += 1
			if akRef.GetFactionRank(DOM01.DOMActionWorking) != 1 ; Travel to workplace
				target.ForceRefTo(workplace_furniture)
				akRef.SetFactionRank(DOM01.DOMActionWorking,1)
				Anim_IdleReset()
				akRef.EvaluatePackage()
			endif
			;if timer_for_work > 24	
			;	akRef.MoveTo(workplace_furniture, 0.0, 0.0, 1.0,true) ; match rotation
			;	;LogTrace("behaviour=work - teleport to workplace distance="+GetObjectDistance(akRef,workplace_furniture))	
			;	timer_for_work = 0
			;endif
			return
		endif
		if mind.IsWillingToWork()
			if timer_for_work == 0  ; Starts to work
				;*ogTrace("behaviour=work - starts to work distance="+GetObjectDistance(akRef,workplace_furniture)+" timer_for_work="+timer_for_work)	
				; Sandboxing to use the workplace
				workplace.Activate(akRef)
				if akRef.GetFactionRank(DOM01.DOMActionWorking) != 2 ; Wait sandbox short distance
					akRef.SetFactionRank(DOM01.DOMActionWorking,2)
					Anim_IdleReset()
					akRef.EvaluatePackage()
				endif
				mind.SetNextPraiseReasonOnceMessage(11,"starts working on "+workplace.GetDisplayName()) ; "being a good worker"
				mind.TrainWork(1.0)
			elseif timer_for_work == 16 ; Get some ore
				; Get some ore
				;*ogTrace("behaviour=work - let's produce some ore timer_for_work="+timer_for_work)	
				if workplace_ore != None
					float work_stat = mind.work_training
					float chance = ((work_stat+100.0)/200.0)
					int max_ore = ((work_stat/10.0) as int) + 2
					;*ogTrace("behaviour=work - chance="+chance+" max_ore="+max_ore)	
					if RandomFloat() < chance
						int current_nb_ore = akRef.GetItemCount(workplace_ore)
						;*ogTrace("behaviour=work - success current nb ore="+current_nb_ore)	
						if current_nb_ore < max_ore
							;*ogTrace("behaviour=work - add ore="+workplace_ore.GetName()+" "+current_nb_ore+"/"+max_ore)	
							akRef.AddItem(workplace_ore, 1)
							SendNotificationAction(name+" produced some "+workplace_ore.GetName())
						endif
					endif
				endif
				if mind.whipping_active
					timer_for_work = 7
				else
					;*ogTrace("behaviour=work - starts to sandbox")	
					if akRef.GetFactionRank(DOM01.DOMActionWorking) != 3 ; Wait sandbox normal distance
						akRef.SetFactionRank(DOM01.DOMActionWorking,3)
						Anim_IdleReset()
						akRef.EvaluatePackage()
					endif
				endif
			;else
				;workplace.Activate(akRef)
				;*ogTrace("behaviour=work busy timer="+timer_for_work)	
			endif
			timer_for_work += 1
			;*ogTrace("behaviour=work timer_for_work="+timer_for_work)	
			if mind.whipping_active && timer_for_work > 16
				;*ogTrace("behaviour=work whipped timer_for_work="+timer_for_work)	
				timer_for_work = 0
			elseif timer_for_work > 24
				;*ogTrace("behaviour=work not whipped timer_for_work="+timer_for_work)	
				timer_for_work = 0
			endif
		else
			mind.SetNextPunishmentReasonOnceMessage(30,"doesn't feel like working") ; "being a bad worker"
			mind.RemoveNextPraiseReason(11) ; "being a good worker"
			;*ogTrace("behaviour=work - idling timer="+timer_for_work)	
			; workplace = None
			if akRef.GetFactionRank(DOM01.DOMActionWorking) != 3 ; Wait sandbox normal distance
				akRef.SetFactionRank(DOM01.DOMActionWorking,3)
				akRef.EvaluatePackage()
				Anim_IdleReset()				
			endif
			;timer_for_work = 0 ; += 1
		endif
	EndFunction
	
	string Function GetBehaviourTitle()
		int rank = akRef.GetFactionRank(DOM01.DOMWorkMode)
		if rank == 1
			return "is mining"
		elseif rank == 2
			return "is cutting wood"
		endif
		return "is working"
	EndFunction

	int Function GetBehaviourIndex()
		return 36 ; "work"
	EndFunction

	Function EndBehaviour()
		behaviour_working = false
		is_working = false
		akRef.RemoveFromFaction(DOM01.DOMActionWorking)
		workplace = None
		workplace_ore = None
		workplace_furniture = None
		mind.should_hold_weapons = should_hold_weapons_outside_mining
		DOM01.DOMEquip.UnequipPick(akRef)
	EndFunction
EndState

; ### Training

bool Property is_trainer = false Auto Hidden
Function PromoteToSlaveMaster()
	if !mind.is_slave
		return
	endif
	is_trainer = true
	int rank
	if mind.is_player_slave 
		rank = akRef.GetFactionRank(DOM01.DOMPlayerSlaveFaction)
	else
		rank = akRef.GetFactionRank(DOM01.DOMNotPlayerSlaveFaction)
	endif
	if rank == 2
		return
	endif
	ChooseAnswerThanks(GetCurrentTrainer())
	SeparateFromTrainer()
	if mind.is_player_slave 
		akRef.SetFactionRank(DOM01.DOMPlayerSlaveFaction,2)
	else
		akRef.SetFactionRank(DOM01.DOMNotPlayerSlaveFaction,2)
	endif
	if title == ""
		setTitleByType(mind.is_slave)
		mind.setTitleByType(mind.is_slave)
	endif
EndFunction

Function DemoteFromSlaveMaster()
	if !mind.is_slave
		return
	endif
	is_trainer = false
	int rank
	if mind.is_player_slave
		rank = akRef.GetFactionRank(DOM01.DOMPlayerSlaveFaction)
	else
		rank = akRef.GetFactionRank(DOM01.DOMNotPlayerSlaveFaction)
	endif
	if rank != 2
		return
	endif
	ChooseAnswerYes(GetCurrentTrainer())
	UnloadAllTrainees()
	EnterFollowPlayer()
	if mind.is_player_slave
		akRef.SetFactionRank(DOM01.DOMPlayerSlaveFaction,1)
	else
		akRef.SetFactionRank(DOM01.DOMNotPlayerSlaveFaction,1)
	endif
	if title == "Henchman" || title == "Henchwench"
		setTitleByType(mind.is_slave)
		mind.setTitleByType(mind.is_slave)
	endif
EndFunction

; PUNISHING

Function EnterPunishTrainees()
	behaviour = "punishing"
EndFunction

Function EnterPunishTrainee(DOM_Actor akTraineeActor)
	if akTraineeActor != None
		actor_trainee = akTraineeActor
		behaviour = "punish_trainee"
	else
		behaviour = "wait"
	endif
EndFunction

Function EnterFetchTrainee(DOM_Actor akTraineeActor)
	if akTraineeActor != None
		actor_trainee = akTraineeActor
		behaviour = "fetch_trainee"
	else
		behaviour = "wait"
	endif
EndFunction

; SEX TRAINING

Function EnterTrainSexTrainees()
	behaviour = "sextraining"
EndFunction

Function EnterTrainSexTrainee(DOM_Actor akTraineeActor)
	if akTraineeActor != None
		actor_trainee = akTraineeActor
		behaviour = "train_trainee"
	else
		behaviour = "wait"
	endif
EndFunction

Function EnterFetchSexTrainee(DOM_Actor akTraineeActor)
	if akTraineeActor != None
		actor_trainee = akTraineeActor
		behaviour = "fetch_sextrainee"
	else
		behaviour = "wait"
	endif
EndFunction

; THREESOME/FOURSOME TRAINING

Function EnterTrainOrgy()
	behaviour = "orgytraining"
EndFunction

Function EnterTrainOrgyTrainees(DOM_Actor akTraineeActor1, DOM_Actor akTraineeActor2, DOM_Actor akTraineeActor3)
	if akTraineeActor1 != None && akTraineeActor2 != None
		actor_trainee = akTraineeActor1
		actor_trainee2 = akTraineeActor2
		actor_trainee3 = akTraineeActor3
		behaviour = "orgy_trainees"
	elseif akTraineeActor1 == None && akTraineeActor2 == None
		behaviour = "wait"
	else
		behaviour = "sextraining"
	endif
EndFunction

Function EnterFetchOrgyTrainees(DOM_Actor akTraineeActor1, DOM_Actor akTraineeActor2, DOM_Actor akTraineeActor3)
	if akTraineeActor1 != None && akTraineeActor2 != None
		actor_trainee = akTraineeActor1
		actor_trainee2 = akTraineeActor2
		actor_trainee3 = akTraineeActor3
		behaviour = "fetch_orgytrainees"
	elseif akTraineeActor1 == None && akTraineeActor2 == None
		behaviour = "wait"
	else
		behaviour = "sextraining"
	endif
EndFunction

; GET TRAINEES

DOM_Actor Function GetNextTraineeForPunishment()
	int i = 0
	; try to find a good reason to punish slave
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && RandomFloat() < 0.5
			if IsTogetherWithFast(akRef, aslave.akRef)
				int reason = aslave.mind.GetNextPunishmentReasonByIndex()
				if reason != "no reason"  && aslave.mind.resignation < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None
			if IsTogetherWithFast(akRef, aslave.akRef)
				int reason = aslave.mind.GetNextPunishmentReasonByIndex()
				if reason != "no reason"  && aslave.mind.total_training < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.total_training<100.0
					int reason = aslave.mind.GetNextPunishmentReasonByIndex()
					if reason != "no reason"  && RandomFloat() < 0.5
						return aslave
					endif
				endif
			endif
		endif
		i += 1
	EndWhile
	; no good reason found, punish anyway
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.resignation < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.total_training < RandomFloat()*99.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.total_training<100.0 && RandomFloat() < 0.5
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	; take the first valid slave
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.total_training<100.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	return None
EndFunction

DOM_Actor Function GetNextTraineeForSex()
	int i = 0
	; try to find a good reason to punish slave
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave.canAnimateSexlab && aslave.canAnimateLocal && RandomFloat() < 0.5
			if IsTogetherWithFast(akRef, aslave.akRef)
				int reason = aslave.mind.GetNextPunishmentReasonByIndex()
				if reason != "no reason"  && aslave.mind.submission < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				int reason = aslave.mind.GetNextPunishmentReasonByIndex()
				if reason != "no reason"  && aslave.mind.sex_training < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0
					int reason = aslave.mind.GetNextPunishmentReasonByIndex()
					if reason != "no reason"  && RandomFloat() < 0.5
						return aslave
					endif
				endif
			endif
		endif
		i += 1
	EndWhile
	; no good reason found, punish anyway
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.submission < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training < RandomFloat()*99.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0 && RandomFloat() < 0.5
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	; take the first valid slave
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	return None
EndFunction

DOM_Actor Function GetSupplementaryTraineeForSex1(DOM_Actor akTrainee)
	int i = 0
	; try to find a good reason to punish slave
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee && aslave.canAnimateSexlab && aslave.canAnimateLocal && RandomFloat() < 0.5
			if IsTogetherWithFast(akRef, aslave.akRef)
				int reason = aslave.mind.GetNextPunishmentReasonByIndex()
				if reason != "no reason"  && aslave.mind.submission < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				int reason = aslave.mind.GetNextPunishmentReasonByIndex()
				if reason != "no reason"  && aslave.mind.sex_training < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0
					int reason = aslave.mind.GetNextPunishmentReasonByIndex()
					if reason != "no reason"  && RandomFloat() < 0.5
						return aslave
					endif
				endif
			endif
		endif
		i += 1
	EndWhile
	; no good reason found, punish anyway
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.submission < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training < RandomFloat()*99.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0 && RandomFloat() < 0.5
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	; take the first valid slave
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	return None
EndFunction

DOM_Actor Function GetSupplementaryTraineeForSex2(DOM_Actor akTrainee1, DOM_Actor akTrainee2)
	int i = 0
	; try to find a good reason to punish slave
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee1 && aslave != akTrainee2 && aslave.canAnimateSexlab && aslave.canAnimateLocal && RandomFloat() < 0.5
			if IsTogetherWithFast(akRef, aslave.akRef)
				int reason = aslave.mind.GetNextPunishmentReasonByIndex()
				if reason != "no reason"  && aslave.mind.submission < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee1 && aslave != akTrainee2 && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				int reason = aslave.mind.GetNextPunishmentReasonByIndex()
				if reason != "no reason"  && aslave.mind.sex_training < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee1 && aslave != akTrainee2 && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0
					int reason = aslave.mind.GetNextPunishmentReasonByIndex()
					if reason != "no reason"  && RandomFloat() < 0.5
						return aslave
					endif
				endif
			endif
		endif
		i += 1
	EndWhile
	; no good reason found, punish anyway
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee1 && aslave != akTrainee2 && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.submission < RandomFloat()*70.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee1 && aslave != akTrainee2 && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training < RandomFloat()*99.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee1 && aslave != akTrainee2 && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0 && RandomFloat() < 0.5
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	; take the first valid slave
	i = 0
	While i < GetTraineeCount()
		DOM_Actor aslave = traineeArray[i]
		if aslave != None && aslave != akTrainee1 && aslave != akTrainee2 && aslave.canAnimateSexlab && aslave.canAnimateLocal
			if IsTogetherWithFast(akRef, aslave.akRef)
				if aslave.mind.sex_training<100.0
					return aslave
				endif
			endif
		endif
		i += 1
	EndWhile
	return None
EndFunction

; ### Work

Function CleanTheMess()
	;LogTrace("CleanTheMess is_pickingUpMess="+is_pickingUpMess)
	if is_pickingUpMess
		return
	endif
	is_pickingUpMess = true
	int iRand = RandomInt(0,20)
	int iType
	
	if iRand == 0 && DOM01.cleanAmmoToggle
		iType = 42 ; kAmmo = 42
	elseif iRand <= 2
		iType = 100 ; kImpactData = 100
	elseif iRand == 3 && DOM01.cleanArmorsToggle
		iType = 26 ; kArmor = 26
	elseif iRand <= 4
		iType = 101 ; kImpactDataSet = 101
	elseif iRand <= 6 && DOM01.cleanBooksToggle
		iType = 27 ; kBook = 27
	elseif iRand <= 9
		iType = 30 ; kIngredient = 30
	elseif iRand == 10
		iType = 45 ; kKey = 45
	elseif iRand == 11 && DOM01.cleanWeaponsToggle
		iType = 41 ; kWeapon = 41
	elseif iRand <= 12
		iType = 36 ; kMovableStatic = 36
	elseif iRand == 13 && DOM01.cleanScrollsToggle
		iType = 23 ; kScrollItem = 23
	elseif iRand <= 15
		iType = 46 ; kPotion = 46
	elseif iRand == 16
		iType = 52 ; kSoulGem = 52
	else
		iType = 32 ; kMisc = 32 ; plate, goblet, jug, flagon, ...
	endif
	
	;LogTrace("timer_for_work="+timer_for_work+" will now clean objects of type "+iType+" Random="+iRand)
	CleanMess(iType)
	is_pickingUpMess = false
EndFunction

Function CleanMess(int iType)
	int iplay = -1
	if current_location == None
		UpdateLocation(akRef.GetCurrentLocation())
	endif
	ObjectReference cont = None
	ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, 1000.0) ; Skyrim units 1000 = 14 m
	int i = refs.length
	if i <= 0 ; try bigger radius
		refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, 2000.0) ; Skyrim units 2000 = 28 m
		i = refs.length
		if i <= 0 ; one last try
			iType = 32 ; plate, goblet, jug, flagon, ...
			refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, 3000.0) ; Skyrim units 1000 = 42 m
			i = refs.length
		endif
	endif
	if i<= 0 ; check there are items to pick up
		return
	endif
	;LogTrace("found form type="+iType+" number of forms="+i)
	While i
		i -= 1
		if behaviour != "clean_house" ; In case behaviour changed in the middle of the task
			return
		endif
		ObjectReference ref = refs[i]
		int motionType = 4
		if ref.Is3DLoaded()
			motionType = PO3_SKSEFunctions.GetMotionType(ref)
		else
			;*ogTrace("NOT 3D LOADED "+ref.GetBaseObject().getName()+" "+ref)		
		endif
		;*ogTrace("clean "+i+" cause="+PO3_SKSEFunctions.GetActorCause(ref)+" form type="+iType+" "+ref.GetBaseObject().getName()+" generated="+PO3_SKSEFunctions.IsGeneratedForm(ref)+" motion="+motionType+" "+ref)
		if PO3_SKSEFunctions.IsGeneratedForm(ref)
			iplay = 1
			;LogTrace("DELETE "+ref.GetBaseObject().getName()+" "+ref)
			if iplay<0 && akRef.Is3DLoaded() && ref.Is3DLoaded()
				akRef.PathToReference(ref,1.0)
			endif
			; put in container if one is available
			if DOM01.cleanDeleteToggle || iType == 100 || iType == 101 ; blood splatter and impact data
				ref.Delete()
			else
				if cont == None
					cont =  GetNearbyContainer()
				endif
				if cont != None
					;LogTrace("MOVE "+ref.GetBaseObject().getName()+" "+ref+" generated to container "+cont.GetBaseObject().getName()+" "+cont)
					if iplay<0 && akRef.Is3DLoaded() && ref.Is3DLoaded()
						akRef.PathToReference(ref,1.0)
					endif
					cont.AddItem(ref)
				else
					; Add item to slave inventory if valuable
					Form the_item = ref.GetBaseObject() 
					if the_item == DOM01.Gold001 && RandomInt()*5.0 < mind.MOD_Greed
						akRef.AddItem(ref)
						;LogTrace("MOVE TO ACTOR INVENTORY "+ref.GetBaseObject().getName()+" gold!")
					elseif DOM01.DOMEquip.processItemJewelry(the_item) && RandomInt()*10.0 < mind.MOD_Greed+mind.MOD_SelfEsteem
						akRef.AddItem(ref)
						SendOrderEquipInventory(true) ; do anim
						;LogTrace("MOVE TO ACTOR INVENTORY "+ref.GetBaseObject().getName()+" jewelry!")
					elseif DOM01.DOMEquip.processItemLingerie(the_item) && RandomInt()*5.0 < mind.MOD_Vaginal
						akRef.AddItem(ref)
						SendOrderEquipInventory(true) ; do anim
						;LogTrace("MOVE TO ACTOR INVENTORY "+ref.GetBaseObject().getName()+" lingerie!")
					elseif the_item.GetGoldValue() > 5.0 * (10.0-mind.MOD_Greed)
						akRef.AddItem(ref)
						;LogTrace("MOVE TO ACTOR INVENTORY "+ref.GetBaseObject().getName()+" valuable!")
					else
						LogTrace("NO CONTAINER "+ref.GetBaseObject().getName()+" generated "+ref)
					endif
				endif
			endif
		elseif motionType < 4 ; is movable
			;*ogTrace("LOCATION current="+current_location+" editor="+ref.GetEditorLocation())		
			if current_location == ref.GetEditorLocation() ; Object is in its editor cell
				iplay = 0
				;LogTrace("PLACE "+ref.GetBaseObject().getName()+" "+ref)
				if iplay<0 && akRef.Is3DLoaded() && ref.Is3DLoaded()
					akRef.PathToReference(ref,1.0)
				endif
				ref.MoveToMyEditorLocation()
			else ; put in container if one is available
				iplay = 2
				if cont == None
					cont =  GetNearbyContainer()
				endif
				if cont != None
					;LogTrace("MOVE "+ref.GetBaseObject().getName()+" "+ref+" to container "+cont.GetBaseObject().getName()+" "+cont)
					if iplay<0 && akRef.Is3DLoaded() && ref.Is3DLoaded()
						akRef.PathToReference(ref,1.0)
					endif
					cont.AddItem(ref)
				else
					; Add item to slave inventory if valuable
					Form the_item = ref.GetBaseObject() 
					if the_item == DOM01.Gold001 && RandomInt()*5.0 < mind.MOD_Greed
						akRef.AddItem(ref)
						;LogTrace("MOVE TO ACTOR INVENTORY "+ref.GetBaseObject().getName()+" gold!")
					elseif DOM01.DOMEquip.processItemJewelry(the_item) && RandomInt()*10.0 < mind.MOD_Greed+mind.MOD_SelfEsteem
						akRef.AddItem(ref)
						SendOrderEquipInventory(true) ; do anim
						;LogTrace("MOVE TO ACTOR INVENTORY "+ref.GetBaseObject().getName()+" jewelry!")
					elseif DOM01.DOMEquip.processItemLingerie(the_item) && RandomInt()*5.0 < mind.MOD_Vaginal
						akRef.AddItem(ref)
						SendOrderEquipInventory(true) ; do anim
						;LogTrace("MOVE TO ACTOR INVENTORY "+ref.GetBaseObject().getName()+" lingerie!")
					elseif the_item.GetGoldValue() > 5.0 * (10.0-mind.MOD_Greed)
						akRef.AddItem(ref)
						;LogTrace("MOVE TO ACTOR INVENTORY "+ref.GetBaseObject().getName()+" valuable!")
					else
						LogTrace("NO CONTAINER "+ref.GetBaseObject().getName()+" generated "+ref)
					endif
				endif
			endif
		else
			LogTrace("NOT MOVABLE "+ref.GetBaseObject().getName()+" "+ref)
		endif
	EndWhile
	if canIdle
		string the_idle
		if iplay == 0
			the_idle = DOM01.DOM_Anim.GetPickupPose(self)
		elseif iplay == 1
			the_idle = DOM01.DOM_Anim.GetCleaningPose(self)
		else
			the_idle = DOM01.DOM_Anim.GetBroomPose(self)
		endif
		Anim_IdleByString(the_idle)
	endif
	mind.CheckAndRegisterKink(80,2.0) ; "being a maid"
EndFunction

bool workplace_lookup_busy = false
ObjectReference Function GetNewWorkplace() 
	;*ogTrace("GetNewWorkplace workplace="+workplace+" busy="+workplace_lookup_busy)
	workplace_lookup_busy = true
	ObjectReference the_workplace
	; Should be a test on DOMWorkMode: 1=mining
	int rank = akRef.GetFactionRank(DOM01.DOMWorkMode)
	if rank <= 1
		the_workplace = GetNearbyMine(workplace,2000.0)
	else
		the_workplace = GetNearbyWoodChoppingBlock(workplace,2000.0)
	endif
	workplace_lookup_busy = false
	return the_workplace
EndFunction

ObjectReference Function GetNearbyWoodChoppingBlock(ObjectReference old_mine, float distance) ; 1000 = 14 m
	;*ogTrace("GetNearbyMine distance="+distance)
	if current_location == None
		UpdateLocation(akRef.GetCurrentLocation())
	endif
	int iType = 40 ; kFurniture  
	ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance) ; Skyrim units 1000 = 14 m
	int i = refs.length
	if i <= 0 ; try bigger radius
		refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance*2.0) ; Skyrim units 2000 = 28 m
		i = refs.length
		if i <= 0 ; one last try
			refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance*4.0) ; Skyrim units 4000 = 56 m
			i = refs.length
		endif
	endif
	if i<= 0 ; nothing found
		;LogTrace("No object found of type="+iType)
		return None
	endif
	;LogTrace("Found object type="+iType+" number of objects="+i)
	ObjectReference the_mine = None
	MiscObject the_ore = None
	ObjectReference the_mine_busy = None
	float the_distance = -1.0
	float the_distance_busy = -1.0
	int the_index = -1
	While i
		i -= 1
		if behaviour != "work" ; In case behaviour changed in the middle of the task
			return None
		endif
		ObjectReference ref = refs[i]
		if ref != None
			;LogTrace("Found object "+i+" "+ref.GetDisplayName()+" = "+ref)
			Form the_form = ref.GetBaseObject()
			;if the_form != None
			;	LogTrace("Found form "+i+" "+the_form.GetName()+" = "+the_form)
			;endif
			ResourceFurnitureScript akMineOre = ref as ResourceFurnitureScript
			if akMineOre != None
				;LogTrace("Found mine "+i+" "+akMineOre.GetDisplayName()+" = "+akMineOre)
				;*ogTrace("Found resource "+i+" "+akMineOre.ResourceCountCurrent)
				;*ogTrace("Found ore "+i+" "+akMineOre.Ore.GetName()+" "+akMineOre.Ore)
				float mine_distance = GetObjectDistance(akRef,ref)
				if ref != old_mine && (the_mine == None || mine_distance < the_distance)
					if !DOM01.IsWorkplaceBusy(self,ref)
						the_mine = ref
						the_distance = mine_distance
						the_index = i
						i = 0
					elseif the_mine_busy == None || mine_distance < the_distance_busy
						the_mine_busy = ref
						the_distance_busy = mine_distance
						the_index = i
					endif
				endif
			endif				
		endif					
	EndWhile
	if the_mine != None
		the_ore = (the_mine as ResourceFurnitureScript).Resource
		;LogTrace("Selected mine "+the_index+" ore="+the_ore.GetName()+" distance="+the_distance)
	elseif old_mine != None
		the_mine = old_mine
		the_ore = (the_mine as ResourceFurnitureScript).Resource
		the_distance = GetObjectDistance(akRef,the_mine)
		;LogTrace("Using old mine "+the_index+" ore="+the_ore.GetName()+" distance="+the_distance)
	elseif the_mine_busy != None
		the_mine = the_mine_busy
		the_ore = (the_mine as ResourceFurnitureScript).Resource
		the_distance = GetObjectDistance(akRef,the_mine)
		;LogTrace("Using busy mine "+the_index+" ore="+the_ore.GetName()+" distance="+the_distance)		
	else
		LogTrace("COULD NOT FIND ANY MINE")
	endif
	if the_mine != None
		workplace_ore = the_ore
		workplace_furniture = the_mine as ResourceFurnitureScript
	else
		workplace_ore = None
		workplace_furniture = None
	endif
	return the_mine
EndFunction

ObjectReference Function GetNearbyMine(ObjectReference old_mine, float distance) ; 1000 = 14 m
	;*ogTrace("GetNearbyMine distance="+distance)
	if current_location == None
		UpdateLocation(akRef.GetCurrentLocation())
	endif
	int iType = 24 ; kActivator 
	ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance) ; Skyrim units 1000 = 14 m
	int i = refs.length
	if i <= 0 ; try bigger radius
		refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance*2.0) ; Skyrim units 2000 = 28 m
		i = refs.length
		if i <= 0 ; one last try
			refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance*4.0) ; Skyrim units 4000 = 56 m
			i = refs.length
		endif
	endif
	if i<= 0 ; nothing found
		;LogTrace("No object found of type="+iType)
		return None
	endif
	;LogTrace("Found object type="+iType+" number of objects="+i)
	ObjectReference the_mine = None
	MiscObject the_ore = None
	ObjectReference the_mine_busy = None
	float the_distance = -1.0
	float the_distance_busy = -1.0
	int the_index = -1
	While i
		i -= 1
		if behaviour != "work" ; In case behaviour changed in the middle of the task
			return None
		endif
		ObjectReference ref = refs[i]
		if ref != None
			;LogTrace("Found object "+i+" "+ref.GetDisplayName()+" = "+ref)
			Form the_form = ref.GetBaseObject()
			;if the_form != None
			;	LogTrace("Found form "+i+" "+the_form.GetName()+" = "+the_form)
			;endif
			MineOreScript akMineOre = ref as MineOreScript
			if akMineOre != None
				;LogTrace("Found mine "+i+" "+akMineOre.GetDisplayName()+" = "+akMineOre)
				;*ogTrace("Found ressource "+i+" "+akMineOre.ResourceCountCurrent)
				;*ogTrace("Found ore "+i+" "+akMineOre.Ore.GetName()+" "+akMineOre.Ore)
				float mine_distance = GetObjectDistance(akRef,ref)
				if ref != old_mine && (the_mine == None || mine_distance < the_distance)
					if !DOM01.IsWorkplaceBusy(self,ref)
						the_mine = ref
						the_distance = mine_distance
						the_index = i
						i = 0
					elseif the_mine_busy == None || mine_distance < the_distance_busy
						the_mine_busy = ref
						the_distance_busy = mine_distance
						the_index = i
					endif
				endif
			endif				
		endif					
	EndWhile
	if the_mine != None
		the_ore = (the_mine as MineOreScript).Ore
		;LogTrace("Selected mine "+the_index+" ore="+the_ore.GetName()+" distance="+the_distance)
	elseif old_mine != None
		the_mine = old_mine
		the_ore = (the_mine as MineOreScript).Ore
		the_distance = GetObjectDistance(akRef,the_mine)
		;LogTrace("Using old mine "+the_index+" ore="+the_ore.GetName()+" distance="+the_distance)
	elseif the_mine_busy != None
		the_mine = the_mine_busy
		the_ore = (the_mine as MineOreScript).Ore
		the_distance = GetObjectDistance(akRef,the_mine)
		;LogTrace("Using busy mine "+the_index+" ore="+the_ore.GetName()+" distance="+the_distance)		
	else
		LogTrace("COULD NOT FIND ANY MINE")
	endif
	if the_mine != None
		workplace_ore = the_ore
		workplace_furniture = (the_mine as MineOreScript).getLinkedRef() as mineOreFurnitureScript
	else
		workplace_ore = None
		workplace_furniture = None
	endif
	return the_mine
EndFunction


ObjectReference Function GetNearbyJail(ObjectReference old_jail, float distance) ; 1000 = 14 m
	;LogTrace("GetNearbyJail distance="+distance)
	if current_location == None
		UpdateLocation(akRef.GetCurrentLocation())
	endif
	int iType = 34 ; Static reference ; 5 = kLocationRef  
	ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance) ; Skyrim units 1000 = 14 m
	int i = refs.length
	if i <= 0 ; try bigger radius
		refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance*2.0) ; Skyrim units 2000 = 28 m
		i = refs.length
		if i <= 0 ; one last try
			iType = 32 ; plate, goblet, jug, flagon, ...
			refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, distance*4.0) ; Skyrim units 4000 = 56 m
			i = refs.length
		endif
	endif
	if i<= 0 ; nothing found
		;LogTrace("No object found of type="+iType)
		return None
	endif
	;LogTrace("Found object type="+iType+" number of objects="+i)
	ObjectReference the_jail = None
	float the_distance = -1.0
	While i
		i -= 1
		if !is_jailed ; In case behaviour changed in the middle of the task
			return None
		endif
		ObjectReference ref = refs[i]
		if ref != None
			;LogTrace("Found object "+i+" "+ref.GetName()+" "+ref.GetDisplayName()+" = "+ref)
			Form the_form = ref.GetBaseObject()
			if the_form != None
				LogTrace("Found form "+i+" "+the_form.GetName()+" = "+the_form)
			endif
			if DOM01.isAJail(ref)
				;LogTrace("Found jail location ref "+i)
				float jail_distance = GetObjectDistance(akRef,ref)
				if ref != old_jail && (the_jail == None || jail_distance < the_distance)
					the_jail = ref
					the_distance = jail_distance
				endif
			endif				
		endif					
	EndWhile
	if the_jail != None
		LogTrace("Selected jail "+i+" "+the_jail.GetName()+" distance="+the_distance)
	elseif old_jail != None
		the_jail = old_jail
		;LogTrace("Using old jail "+i+" "+the_jail.GetName()+" distance="+the_distance)
	else
		LogTrace("COULD NOT FIND ANY JAIL")
	endif
	return the_jail
EndFunction

ObjectReference Function GetNearbyZazPose()
	if DOM01.DOMZaz.zpfFurniture == None
		return None
	endif
	ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesWithKeyword(akRef, DOM01.DOMZaz.zpfFurniture, 2000.0, true) ; Skyrim units 2000 = 28 m
	int n = refs.length
	int i = 0
	While i
		ObjectReference ref = refs[i]
		;LogTrace("clean form type="+ref.GetType()+" "+ref.GetBaseObject().getName()+" IsActivationBlocked="+ref.IsActivationBlocked())
		if ref != None && !ref.IsActivationBlocked()
			return ref
		endif
		if !PO3_SKSEFunctions.IsGeneratedForm(ref)
			;LogTrace("PLACE "+ref.GetBaseObject().getName()+" "+ref)
			return ref
		endif
		i += 1
	EndWhile
	return None
EndFunction

ObjectReference Function GetNearbyContainer()
	int iType = 28 ; kContainer = 28
	ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, 500.0) ; Skyrim units 500 = 7 m
	int i = refs.length
	if i <= 0 
		refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, 1000.0) ; Skyrim units 1000 = 14 m
		i = refs.length
		if i <= 0 
			refs = PO3_SKSEFunctions.FindAllReferencesOfFormType(akRef, iType, 2000.0) ; Skyrim units 2000 = 28 m
			i = refs.length
			if i <= 0 
				return None
			endif
		endif
	endif
	;LogTrace("container form type="+iType+" number of forms="+i)
	While i
		i -= 1
		ObjectReference ref = refs[i]
		;LogTrace("clean form type="+iType+" "+ref.GetBaseObject().getName()+" generated="+PO3_SKSEFunctions.IsGeneratedForm(ref)+" motion="+PO3_SKSEFunctions.GetMotionType(ref))
		if !PO3_SKSEFunctions.IsGeneratedForm(ref)
			;LogTrace("PLACE "+ref.GetBaseObject().getName()+" "+ref)
			return ref
		endif
	EndWhile
	return None
EndFunction

; ### Sexlab animations & voice
bool Property SexlabIsSilent = false Auto Hidden
bool Property SexlabUseLipSync = true Auto Hidden
sslBaseVoice SexlabVoice = None
string Property SexlabAnimOut = "" Auto Hidden
string Property SexlabAnimIn = "" Auto Hidden
int nbSexPartners = 0
DOM_Actor actor_sextrainer = None
DOM_Actor[] __actorPartners
DOM_Actor[] Property actorPartners
	DOM_Actor[] Function Get()
		if !__actorPartners
			__actorPartners = new DOM_Actor[4] ; limited to 4 sex partners, it's one too many
		endif
		return __actorPartners
	EndFunction
EndProperty
Actor actor_sexpartner = None ; current NPC partner
bool was_partner_ended = false
bool property was_sexlab_started = false Auto Hidden
bool Property was_sexlab_ended = false Auto Hidden
bool Property has_sex_with_player = false Auto Hidden
bool Property has_sex_alone = false Auto Hidden
bool Property has_sex_for_money = false Auto Hidden

bool Function IsSceneReallyPenetration()
	if has_sex_alone
		return false
	endif
	if has_sex_with_player
		if (actorSex %2) == (DOM01.DOMPlayerAlias.GetPlayerSex() %2) 
			return false
		endif
		return true
	endif
	if actor_sexpartner != None
		int partnerSex = actor_sexpartner.GetLeveledActorBase().GetSex()
		if (actorSex %2) == (partnerSex %2) 
			return false
		endif
		return true
	endif
	if actor_sextrainer != None
		int partnerSex = actor_sextrainer.actorSex
		if (actorSex %2) == (partnerSex %2) 
			return false
		endif
		return true
	endif
	return false ; Unknowncase
EndFunction

bool Function IsSceneReallyInMouth()
	if has_sex_alone
		return false
	endif
	if has_sex_with_player
		return true
	endif
	if (DOM01.DOMPlayerAlias.GetPlayerSex() %2) == 1
		return true
	endif
	if actor_sexpartner != None
		int partnerSex = actor_sexpartner.GetLeveledActorBase().GetSex()
		if partnerSex == 0
			return true
		endif
		if (actorSex %2) == (partnerSex %2) 
			return false
		endif
		return true
	endif
	if actor_sextrainer != None
		int partnerSex = actor_sextrainer.actorSex
		if partnerSex == 0
			return true
		endif
		if (actorSex %2) == (partnerSex %2) 
			return false
		endif
		return true
	endif
	return false ; Unknowncase
EndFunction

bool Function IsSceneReallySameSex()
	if has_sex_alone
		return false
	endif
	if has_sex_with_player
		if (actorSex %2) == (DOM01.DOMPlayerAlias.GetPlayerSex() %2) 
			return true
		endif
		return false
	endif
	if nbSexPartners == 1
		if actor_sexpartner != None
			int partnerSex = actor_sexpartner.GetLeveledActorBase().GetSex()
			if (actorSex %2) == (partnerSex %2) 
				return true
			endif
			return false
		endif
		if actor_sextrainer != None
			int partnerSex = actor_sextrainer.actorSex
			if (actorSex %2) == (partnerSex %2) 
				return true
			endif
			return false
		endif
	endif
	; threesome
	int partnersSex = 0
	int i = 0
	while i < nbSexPartners
		if actorPartners[i] != None
			if (actorSex %2) != ((actorPartners[i].actorSex) %2) 
				return false
			endif
		endif
		i += 1
	endWhile
	return true
EndFunction

Function ClearSexPartners()
	int n = actorPartners.length
	int idx = 0
	while idx < n
		__actorPartners[idx] = None
		idx+=1
	endwhile
	nbSexPartners = 0
	actor_sexpartner = None
	actor_sextrainer = None
	was_partner_ended = false
EndFunction

DOM_Actor Function GetSexPartner(int idx)
	if idx >= nbSexPartners
		return None
	endif
	return actorPartners[idx]
EndFunction

DOM_Actor Function GetSexTrainer()
	return actor_sextrainer
EndFunction

Actor Function GetCurrentSexTrainer()
	if has_sex_with_player
		return PlayerRef
	endif
	if actor_sextrainer != None
		return actor_sextrainer.akRef
	endif
	if actor_sexpartner != None
		return actor_sexpartner
	endif
	return None
EndFunction

Function AddSexPartner(DOM_Actor akAnotherActor)
	if akAnotherActor == None
		return
	endif
	int n = actorPartners.length
	int idx = 0
	while idx < n
		if __actorPartners[idx] == akAnotherActor
			return ; already added
		endif
		if __actorPartners[idx] == None
			 __actorPartners[idx] = akAnotherActor
			 nbSexPartners += 1
			 return ; got free spot
		endif
		idx+=1
	endwhile
EndFunction

Function SetSexPartner(DOM_Actor akAnotherActor)
	if akAnotherActor == None
		return
	endif
	if nbSexPartners >= actorPartners.length
		LogTrace("SetSexPartner WARNING TOO MANY PARTNERS TO REGISTER partner="+akAnotherActor.GetName()+" nbSexPartners="+nbSexPartners+" max="+actorPartners.length)
		return
	endif
	AddSexPartner(akAnotherActor)
	LogTrace("SetSexPartner partner="+akAnotherActor.GetName()+" nbSexPartners="+nbSexPartners+" max="+actorPartners.length)
	if actor_sexpartner == None
		SetActorPartner(akAnotherActor.akRef)
	endif
	if !has_sex_with_player
		if akAnotherActor == actor_trainer
			actor_sextrainer = actor_trainer
		elseif actor_sextrainer == None && mind.sex_is_non_consensual
			actor_sextrainer = akAnotherActor
		endif
	endif
EndFunction

Function SexlabEndSexPartners()
	was_partner_ended = true
	int idx = 0
	while idx < nbSexPartners
		DOM_Actor the_partner = __actorPartners[idx]
		if the_partner != None
			;LogTrace("SexlabEndSexPartners() partner "+the_partner.GetName()+" was_sexlab_ended="+the_partner.was_sexlab_ended)
			if !the_partner.was_sexlab_ended
				the_partner.SexlabEndScene()
			endif
		endif
		idx += 1
	EndWhile
	ClearSexPartners()
EndFunction

Function SexlabEndScene()
	if was_sexlab_ended
		return
	endif
	LogTrace("SexlabEndScene() was_sexlab_ended="+was_sexlab_ended+" was_partner_ended="+was_partner_ended+" equip_inventory_busy="+equip_inventory_busy)
	was_sexlab_ended = true
	was_sexlab_started = false

	if nbSexPartners > 0 && !was_partner_ended
		SexlabEndSexPartners()
	endif

	if DOM01.GetActor1ToJoinSexlab() != None
		if DOM01.GetActor1ToJoinSexlab().akRef == akRef
			int rank = akRef.GetFactionRank(DOM01.DOMSexlabLoadSlave)
			if rank > 10
				rank -= 10
				akRef.SetFactionRank(DOM01.DOMSexlabLoadSlave,rank) ; not in scene
				DOM01.DOM_SexlabLoadSlave.SetValue(rank)
			endif
		endif
	endif
	akRef.RemoveFromFaction(DOM01.DOMAnimatingFaction)

	if behaviour == "train_trainee"
		;LogTrace("SexlabEndScene() trainer moves to next sex trainee")
		EnterTrainSexTrainees()
	elseif behaviour == "orgy_trainees"
		;LogTrace("SexlabEndScene() trainer moves to next orgy")
		EnterTrainOrgy()
	endif
	
	has_sex_for_money = false
	mind.SetExpressionByMood()
EndFunction

Function SetDefaultSexlabVoice()
	; Pick a voice if needed
	if SexlabVoice != None
		;*ogTrace("Sexlab voice already set to "+SexlabVoice)
		return
	endif
	if SexlabIsSilent
		LogInfo("WARNING: Sexlab voice set to silent")
		return
	endif
	bool IsCreature = (actorSex >= 2)
	SexlabUseLipSync = (DOM01.DOMSexlab.UseLipSync() && !IsCreature)
	SexlabVoice = DOM01.DOMSexlab.GetVoice(akRef,IsCreature)
	;*ogTrace("Sexlab voice set to "+SexlabVoice)
EndFunction

Function SetSexlabVoice(sslBaseVoice voice)
	SexlabVoice = voice
EndFunction

sslBaseVoice Function GetSexlabVoice()
	return SexlabVoice
EndFunction

Function SexlabPlayMoan(int strength = 100, bool isVictim = true)
	if SexlabVoice == None || SexlabIsSilent
		return
	endif
	if !IsTogetherWithFast(akRef, PlayerRef, 1000.0) ; 1000.0 = 14 meters
		return
	endif
	if mind.should_be_silent
		if strength < 80
			strength = strength/10
		else
			mind.SetNextPunishmentReasonSilent(26) ; "moaning"
		endif
	endif
	DOM01.DOMSexlab.PlayMoan(SexlabVoice, akRef, strength, isVictim, SexlabUseLipSync)
EndFunction

Function SexlabPlayOrgasm(bool isVictim = true)
	if !DOM01.DOMSexlab.HasOrgasmEffects()
		return
	endif
	if !IsTogetherWithFast(akRef, PlayerRef, 1000.0) ; 1000.0 = 14 meters
		return
	endif
	; Play SFX/Voice
	if !SexlabIsSilent && SexlabVoice != None
		DOM01.DOMSexlab.PlayVoice(SexlabVoice,akRef,isVictim)
	endif
	DOM01.DOMSexlab.PlayOrgasm(akRef)
EndFunction

; ### Notifications

Function SendNotification(string msg)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg)
	; No notifcation if not in the same cell or not following player
	if !mind.is_player_slave || (!akRef.Is3DLoaded() && !IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotification(name,msg,!mind.is_slave)
EndFunction

Function SendNotificationFriends(string msg)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg)
	; No notifcation if not in the same cell
	if !mind.is_player_slave || (!akRef.Is3DLoaded() && !IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationFriends(name,msg,!mind.is_slave)
EndFunction

Function SendNotificationAction(string msg)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg)
	; No notifcation if not in the same cell
	if !mind.is_player_slave || (!akRef.Is3DLoaded() && !IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationAction(name,msg,!mind.is_slave)
EndFunction

Function SendNotificationEmotion(string msg)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg)
	; No notifcation if not in the same cell
	if !mind.is_player_slave || (!akRef.Is3DLoaded() && !IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationEmotion(name,msg,!mind.is_slave)
EndFunction

Function SendNotificationAbuse(string msg)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg)
	; No notifcation if not in the same cell
	if !mind.is_player_slave || (!akRef.Is3DLoaded() && !IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationAbuse(name,msg,!mind.is_slave)
EndFunction

Function SendNotificationOrder(string msg)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg)
	; No notifcation if not in the same cell
	if !mind.is_player_slave || (!akRef.Is3DLoaded() && !IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationOrder(name,msg,!mind.is_slave)
EndFunction

Function SendNotificationMaster(string msg1, string msg2)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg1+mtr+msg2)
	; No notifcation if not in the same cell
	if !mind.is_player_slave || !IsTogetherWithFast(akRef, PlayerRef, 10000.0)
		LogTrace("Silent notification: "+msg1+mind.actor_owner_title+msg2)
		return
	endif
	String mtr = DOM01.DOMPlayerAlias.GetPlayerTitle()
	DOM01.SendNotification(name,msg1+mtr+msg2,!mind.is_slave)
EndFunction

Function SendNotificationEmotionMaster(string msg1, string msg2)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg1+mtr+msg2)
	; No notifcation if not in the same cell
	if !mind.is_player_slave || !IsTogetherWithFast(akRef, PlayerRef, 10000.0)
		LogTrace("Silent notification: "+msg1+mind.actor_owner_title+msg2)
		return
	endif
	String mtr = DOM01.DOMPlayerAlias.GetPlayerTitle()
	DOM01.SendNotificationEmotion(name,msg1+mtr+msg2,!mind.is_slave)
EndFunction

Function SendNotificationOrderMaster(string msg1, string msg2)
	SendExternalEventSSBS("NotificationSent",mind.training_status_name,mind.is_player_slave,msg1+mtr+msg2)
	; No notifcation if not in the same cell
	if !mind.is_player_slave || !IsTogetherWithFast(akRef, PlayerRef, 10000.0)
		LogTrace("Silent notification: "+msg1+mind.actor_owner_title+msg2)
		return
	endif
	String mtr = DOM01.DOMPlayerAlias.GetPlayerTitle()
	DOM01.SendNotificationOrder(name,msg1+mtr+msg2,!mind.is_slave)
EndFunction

; #### Utilities and debug

Function LogInfo(string msg)
	Debug.Trace("DOM_Actor: "+title+name+": "+msg)
EndFunction

Function LogEquip(string msg)
	if DOM01.DOMEquip.verboseEquip
		Debug.Trace("DOM_Actor:Equipment: "+title+name+": "+msg)
	endif
EndFunction

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_Actor: "+title+name+": "+msg)
	endif
EndFunction

Function LogAnim(string msg)
	if DOM01.verboseAnim
		Debug.Trace("DOM_Actor:Animation: "+title+name+": "+msg+" Idle="+canIdle+" Move="+canMove+" Animate="+canAnimate+" Local="+canAnimateLocal+" Sexlab="+canIdleSexlab)
	endif
EndFunction

Function LogTopic(Topic topic_to_say)
	if DOM01.verboseTopics
		Debug.Trace("DOM_Actor:Topic: "+title+name+": says: "+topic_to_say)
	endif
EndFunction
