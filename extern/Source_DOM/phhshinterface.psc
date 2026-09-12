Scriptname PHHSHInterface extends Quest

PHHSHStorageFunctions Property PHSF  Auto

PAHCore Property PAH = None Auto Hidden
PAHBootstrapScript Property PAHBoot Auto Hidden
DOM_Core Property DOM = None Auto Hidden
;bool Property UseDOMTraining = True Auto Hidden
Faction Property PAHDoNotEnslaveFaction = None Auto Hidden
Faction Property DOMActorExcludedFaction Auto 
Faction Property DOMActorFaction Auto 
Faction Property DOMActorInTransfer Auto 
Faction Property DOMActionGuard Auto 
Faction Property DOMHistoryFaction Auto 
Faction Property DOMAnimatingFaction Auto 
Faction Property DOMPlayerSlaveFaction Auto 
Faction Property DOMNotPlayerSlaverFaction Auto 
Faction Property DOMPotentialSlaverFaction Auto 
Faction Property DOMMoodJustCaptured Auto 

; Training
Faction Property DOMTrainSubmission Auto
Faction Property DOMTrainFear Auto
Faction Property DOMTrainHumiliation Auto
Faction Property DOMTrainAnger Auto
Faction Property DOMTrainResignation Auto
Faction Property DOMTrainRespect Auto
Faction Property DOMTrainCombat Auto
Faction Property DOMTrainPose Auto
Faction Property DOMTrainHouse Auto
Faction Property DOMTrainWorking Auto
Faction Property DOMTraumaInDays Auto
Faction Property DOMTrainSex Auto
Faction Property DOMTrainAnal Auto
Faction Property DOMTrainOral Auto
Faction Property DOMTrainVaginal Auto
Faction Property DOMNbSex Auto

Faction Property PlayerFollowerFaction Auto
Faction Property StupidVampireThrallFaction Auto
Faction Property CurrentFollowerFaction Auto
Faction Property WIFollowerCommentFaction Auto
Faction Property PHHSHExcludedFaction Auto
Message Property PAHSlaveInfoMessage Auto Hidden
Faction Property pTweakWaitingFaction Auto Hidden

Event OnInit()
	GetSoftRequirements()
EndEvent

Function Initialize()
	LogInfo("============================================================================")
	LogInfo("==                           DOM: HSH Interface                           ==")
	LogInfo("============================================================================")

	GetSoftRequirements()
	if PAH != None
		LogInfo("Initialize PAH for HSH success!")
	else
		LogInfo("WARNING: Could not initialize PAH for HSH")
	endif
	If (Game.GetModByName("AmazingFollowerTweaks.esp") != 255)
		pTweakWaitingFaction = Game.GetFormFromFile(0x00032CCB, "AmazingFollowerTweaks.esp") as Faction
	else
		pTweakWaitingFaction = None
	endif
EndFunction

Function GetSoftRequirements()
	string pah_modname = "paradise_halls.esm"
	string dom_modname = "DiaryOfMine.esm"
	
	if (Game.GetModByName(pah_modname) != 255)
		PAH     = Game.GetFormFromFile(0x0001FAEF, pah_modname) As PAHCore 
		PAHBoot = Game.GetFormFromFile(0x0000CF32, pah_modname) As PAHBootstrapScript 
		PAHDoNotEnslaveFaction = Game.GetFormFromFile(0x0000F606, "paradise_halls.esm") As Faction
		PAHSlaveInfoMessage = Game.GetFormFromFile(0x0000F606, "paradise_halls.esm") As Message
	else
		PAH     = None
		PAHBoot = None
		PAHDoNotEnslaveFaction = None
		PAHSlaveInfoMessage    = None
	endif
	if (Game.GetModByName(dom_modname) != 255)
		DOM     = Game.GetFormFromFile(0x00000D61, dom_modname) As DOM_Core 
	else
		DOM     = None
	endif
	if ((StupidVampireThrallFaction == None) && (Game.GetModByname("Skyrim.esm") != 255))
		; VampireThrallFaction "Vampire Thrall" [FACT:0002EB13]
		StupidVampireThrallFaction = Game.GetFormFromFile(0x0002EB13, "Skyrim.esm") As Faction
	endif
	if CurrentFollowerFaction == None ; CurrentFollowerFaction [FACT:0005C84E]
		CurrentFollowerFaction = Game.GetFormFromFile(0x0005C84E, "Skyrim.esm") As Faction
	endif
	if WIFollowerCommentFaction == None ; WIFollowerCommentFaction "Put in this faction to get WI follower comments" [FACT:000750B8]
		WIFollowerCommentFaction = Game.GetFormFromFile(0x000750B8, "Skyrim.esm") As Faction
	endif
	if PHHSHExcludedFaction == None ; phhshExcludedFaction "HSH Scene excluded actors" [FACT:080F65DD]
		PHHSHExcludedFaction = Game.GetFormFromFile(0x000F65DD, "PAH_HomeSweetHome.esp") As Faction
	endif
EndFunction

Function SetFollowerWaitingForPlayer(Actor akRef, phhshPortableCellScript the_cell, bool should_wait)
	if akRef == None
		return
	endif
	if DOM == None || akRef.IsInFaction(PlayerFollowerFaction)
		if should_wait
			akRef.SetAV("WaitingForPlayer", 1)
			if pTweakWaitingFaction != None
				akRef.SetFactionRank(pTweakWaitingFaction,1)
			endif
			if DOM != None
				akRef.SetFactionRank(DOMActionGuard,1)
			endif
		else
			akRef.SetAV("WaitingForPlayer", 0)
			if pTweakWaitingFaction != None
				akRef.RemoveFromFaction(pTweakWaitingFaction)
			endif
			if DOM != None
				akRef.RemoveFromFaction(DOMActionGuard)
			endif
		endif
		return
	endif
	DOM_Actor akActor = DOM.GetActor(akRef)
	if akActor == None
		return
	endif
	if should_wait
		if the_cell == None
			akActor.EnterGuard()
			akActor.SetCamp()
			return
		else
			string name = the_cell.GetNameCellRef()
			if the_cell.IsInDoorCell()
				akActor.EnterGuardMsg("will guard "+name+"'s House", name+" Guard")
			else
				akActor.EnterGuardMsg("will guard "+name+"'s Camp", name+" Guard")
			endif
		endif
		UnloadAllTraineesToCell(akActor,the_cell)
		akActor.EnterGuard()
		akActor.LoadAllTrainees(the_cell.GetActorArray())
		akActor.SetCamp()
	else
		akActor.UnloadAllTrainees()
		akActor.EnterFollow()
	endif
EndFunction

Function SetFollowerBackAndForthToCamp(Actor akRef, phhshPortableCellScript the_cell)
	if akRef == None
		return
	endif
	if DOM == None
		return
	endif
	if the_cell == None
		Debug.Notification(akRef.getDisplayName()+" could not find cell")
		return
	endif
	ObjectReference the_button = the_cell.CellButton
	if the_button == None
		Debug.Notification(akRef.getDisplayName()+" could not find cell location")
		return
	endif
	DOM_Actor akActor = DOM.GetActor(akRef)
	if akActor == None
		Debug.Notification(akRef.getDisplayName()+" is not a DOM actor")
		return
	endif
	if akActor.GetTraineeCount() == 0
		Debug.Notification(akActor.getName()+" has no trainee to escort")
		return
	endif
	akActor.SetCampAtRef(the_button)
	akActor.SetTravelMode(4)
	akActor.EnterGotoCamp()
EndFunction

Function UnloadAllTraineesToCell(DOM_Actor akTrainer, phhshPortableCellScript the_cell)
	int i = 0
	While i < akTrainer.GetTraineeCount()
		DOM_Actor aTrainee = akTrainer.traineeArray[i]
		if aTrainee != None
			Actor akTarget = aTrainee.akRef
			if akTarget != None
				LogTrace("Trainee "+akTarget.GetDisplayName()+" will join slaver "+akTrainer.GetName()+" in camp "+the_cell.GetNameCellRef())
				PHSF.LockupInTempCamp(akTarget)
			endif
		endif
		i += 1
	EndWhile
EndFunction

bool Function isASlaver(Actor akRef)
	if akRef == None
		return false
	endif
	if DOM == None
		return false
	endif
	return DOM.isASlaver(akRef)
EndFunction

bool Function isAnActor(Actor akRef)
	if akRef == None
		return false
	endif
	if DOM == None
		return false
	endif
	return DOM.isAnActor(akRef)
EndFunction

DOM_Actor Function GetActor(Actor akRef)
	if akRef == None
		return None
	endif
	if DOM == None
		return None
	endif
	return DOM.GetActor(akRef)
EndFunction

string Function GetPreviousOccupation(Actor akRef)
	if DOM != None
		return DOM.GetPreviousOccupation(akRef)
	endif
	ActorBase abRef = akRef.GetLeveledActorBase()
	if abRef != None
		return abRef.GetName()
	endif
	return akRef.GetDisplayName()
EndFunction

bool Function IsWaitingForPlayer(Actor akRef)
	if akRef == None
		return false
	endif
	if akRef.GetAV("WaitingForPlayer") == 0
		return false
	endif
	return true
EndFunction

bool Function HasSexExtension()
	if DOM != None
		return true
	endif
	if PAH == None
		return false
	endif
	if PAH.PAHTrainVaginal != None
		return true
	endif
	return false
EndFunction

bool Function isVerboseMode()
	if DOM == None
		return false
	endif
	return DOM.verboseMode
EndFunction

PAHSlave Function AddSlaveToPAH(Actor slave)
	PHSF.ClearNoEnslave(slave)
	if PAH != None
		PAHSlave slaveSlot = PAH.AddSlave(slave)
		if (slaveSlot != None)
			slaveSlot.trainVaginal(1.0)	; Force true-up of sex stats
		endif
		slave.RemoveFromFaction(PAHBoot.PAHBEFleeingAndCowering)		; Just in case these are left on auto-assigned slaves
		slave.RemoveFromFaction(PAHBoot.PAHMoodJustCaptured)
		slave.AddToFaction(PAH.PAHPlayerSlaveFaction)
		slave.AddToFaction(PAH.PAHSlaveFaction)

		if (slave.IsInFaction(PAH.PAHShouldFightForPlayer))
			slave.SetPlayerTeammate()
		endif
		return slaveSlot
	endif
	return None
EndFunction

Function RemoveSlaveFromPAH(Actor slave)
	LogTrace("RemoveSlaveFromPAH slave="+slave)
	if slave == None
		return
	endif
	if PAH != None && slave.IsInFaction(PAH.PAHPlayerSlaveFaction)
		ReferenceAlias slaveAlias = PAH.GetSlave(slave)
		if slaveAlias != None
			PAH.RemoveSlave(slaveAlias)	
			PHSF.SetNoEnslave(slave)
		endif
		if DOM == None && slave.IsInFaction(PAH.PAHSubmission)
			int sub = slave.GetFactionRank(PAH.PAHSubmission)
			if sub > slave.GetFactionRank(PAH.PAHHumiliation)
				slave.SetFactionRank(PAH.PAHHumiliation,sub)
			endif
			if sub > slave.GetFactionRank(PAH.PAHResignation)
				slave.SetFactionRank(PAH.PAHResignation,sub)
			endif
		endif
	endif
	if PAH != None
		slave.RemoveFromFaction(PAH.PAHPlayerSlaveFaction)
		slave.RemoveFromFaction(PAH.PAHSlaveFaction)
	endif
EndFunction

bool Function IsActorActive(Actor akActor)
	if DOM == None
		return false
	endif
	if akActor.isInFaction(DOMAnimatingFaction)
		return true
	endif
	return DOM.DOMSexlab.IsActorActive(akActor)
EndFunction
 
bool Function IsFollowerAvailableForScene(Actor akActor)
	if akActor.GetFactionRank(CurrentFollowerFaction) < 0
		return false
	endif
	if akActor.IsInFaction(PHHSHExcludedFaction)
		return false
	endif
	if !akActor.IsInFaction(WIFollowerCommentFaction)
		return false
	endif
	if akActor.IsChild()
		return false
	endif
	if IsActorActive(akActor)
		return false
	endif
	return true
EndFunction

Function SetNoEnslavePAH(Actor slave)
	if PAHDoNotEnslaveFaction != None
		slave.AddToFaction(PAHDoNotEnslaveFaction)
	endif
EndFunction

Function ClearNoEnslavePAH(Actor slave)
	if PAHDoNotEnslaveFaction != None
		slave.RemoveFromFaction(PAHDoNotEnslaveFaction)
	endif
EndFunction

int Function getActorPrice(Actor akActor)
	if DOM == None
		return 1
	endif
	return DOM.DOMGenerator.getActorPrice(akActor)
EndFunction

float Function getActorTraining(Actor akActor)
	if DOM == None
		return 0.0
	endif
	return GetTrainMod(akActor)
EndFunction

float Function GetTrainMod(Actor slave)
	if slave == None
		return 1.0
	endif
	float fTrainMod = 1.0
	if DOM != None
		fTrainMod *= ((slave.GetFactionRank(DOMTrainSubmission) / 60.0) + 0.34)
		fTrainMod *= ((slave.GetFactionRank(DOMTrainHumiliation) / 60.0) + 0.34)
		fTrainMod *= ((slave.GetFactionRank(DOMTrainResignation) / 60.0) + 0.34)
		fTrainMod *= ((slave.GetFactionRank(DOMTrainRespect) / 60.0) + 0.34)
		fTrainMod += ((slave.GetFactionRank(DOMTrainFear) / 200.0))
		fTrainMod += ((slave.GetFactionRank(DOMTrainAnger) / 200.0))

		fTrainMod += ((slave.GetFactionRank(DOMTrainAnal) / 200.0))
		fTrainMod += ((slave.GetFactionRank(DOMTrainOral) / 200.0))
		fTrainMod += ((slave.GetFactionRank(DOMTrainVaginal) / 200.0))
		fTrainMod += ((slave.GetFactionRank(DOMTrainCombat) / 100.0))
		fTrainMod += ((slave.GetFactionRank(DOMTrainPose) / 150.0))

		fTrainMod += ((slave.GetFactionRank(DOMTrainHouse) / 200.0))
		fTrainMod += ((slave.GetFactionRank(DOMTrainWorking) / 200.0)) 
	elseif PAH != None
		fTrainMod *= ((slave.GetFactionRank(PAH.PAHSubmission) / 60.0) + 0.34)
		fTrainMod *= ((slave.GetFactionRank(PAH.PAHTrainRespect) / 60.0) + 0.34)
		fTrainMod += ((slave.GetFactionRank(PAH.PAHTrainFear) / 200.0))
		fTrainMod += ((slave.GetFactionRank(PAH.PAHTrainAnger) / 200.0))

		fTrainMod += ((slave.GetFactionRank(PAH.PAHTrainAnal) / 200.0))
		fTrainMod += ((slave.GetFactionRank(PAH.PAHTrainOral) / 200.0))
		fTrainMod += ((slave.GetFactionRank(PAH.PAHTrainVaginal) / 200.0))
		fTrainMod += ((slave.GetFactionRank(PAH.PAHTrainCombat) / 100.0))
		fTrainMod += ((slave.GetFactionRank(PAH.PAHTrainPose) / 150.0))
	endif
	return fTrainMod
EndFunction

Function WaitHere(Actor slave)
	if slave == None
		return
	endif
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		if slave.IsInFaction(DOMMoodJustCaptured)
			return
		endif
		DOM_Actor akActor = DOM.GetActor(slave)
		if akActor != None
			akActor.EnterWait()
			return
		endif
	endif
	if PAH != None
		if slave.IsInFaction(slave_alias.PAHMoodJustCaptured)
			return
		endif
		PAHSlave slave_alias = PAH.GetSlave(slave)
		if slave_alias != None
			slave_alias.Wait()
		endif
	endif
EndFunction

Function FollowPlayer(Actor slave)
	if slave == None
		return
	endif
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		if slave.IsInFaction(DOMMoodJustCaptured)
			return
		endif
		DOM_Actor akActor = DOM.GetActor(slave)
		if akActor != None
			akActor.EnterFollowpLayer()
			return
		endif
	endif
	if PAH != None
		if slave.IsInFaction(slave_alias.PAHMoodJustCaptured)
			return
		endif
		PAHSlave slave_alias = PAH.GetSlave(slave)
		if slave_alias != None
			slave_alias.FollowPlayer()
		endif
	endif
EndFunction

bool Function FollowTarget(Actor slave, Actor followTarget)
	if slave == None
		return false
	endif
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		DOM_Actor akActor = DOM.GetActor(slave)
		if akActor != None
			akActor.EnterFollowTarget(followTarget)
			return true
		endif
	endif
	if PAH != None
		PAHSlave slaveRef = PAH.GetSlave(slave)
		if (slaveRef != None)
			slaveRef.FollowPlayer()
			utility.wait(1.0)
			slaveRef.actor_alias.Follow(followTarget)
			return true
		endif
	endif
	return false
EndFunction

Function Assign(PHHSHHouseSlave akSlave, int itype)
	Actor akRef = akSlave.GetActorRef()
	if akRef == None
		LogTrace("Assign failed to get actor reference")
		return
	endif
	LogTrace("Assign "+akRef.GetDisplayName()+" type="+itype)
	ReferenceAlias slot = akSlave as ReferenceAlias
	DOM_Actor slaveDOM = slot as DOM_Actor
	if slaveDOM == None
		LogTrace("Assign failed to assign DOM actor and mind")
		return
	endif
	akRef.RemoveFromFaction(DOM.DOMActorHasHSHCell) ; forget about previous cell
	akRef.SetFactionRank(DOMActorInTransfer,itype)
	akRef.SetFactionRank(PHSF.DOMSlaveManagerFaction,itype)
	LogTrace("Assign SetDisplayName "+akRef.GetDisplayName())
	slaveDOM.SetDisplayName(akRef.GetDisplayName())
	if slaveDOM.DOM01 != DOM && DOM != None
		LogTrace("Assign alias actor DOM pointer was not correctly set!")
		slaveDOM.DOM01 = DOM
	endif
	LogTrace("Assign DOM_Actor AfterAssign "+akRef.GetDisplayName())
	slaveDOM.AfterAssign(true,false,true) ; slave=yes, new=no, player's=yes
	DOM_Mind slaveMind = slot as DOM_Mind
	if slaveMind.DOM01 != DOM && DOM != None
		LogTrace("Assign alias mind DOM pointer was not correctly set!")
		slaveMind.DOM01 = DOM
	endif
	LogTrace("Assign DOM_Mind AfterAssign "+akRef.GetDisplayName())
	slaveMind.AfterAssign(true,false,true) ; slave=yes, new=no, player's=yes
	if itype == 101
		slaveDOM.EnterOnDuty("will join The Restless Hunter", "Hunter's Slave")
	elseif itype == 102
		phhshPortableCellScript the_cell = PHSF.PortableFunctions.HoldingCellrefForCell(akRef.GetParentCell()) as phhshPortableCellScript
		if the_cell == None
			slaveDOM.EnterOnDuty("will join Player's Camp", "Camp Slave")
		else
			string name = the_cell.GetNameCellRef()
			slaveDOM.EnterOnDuty("will join "+name+"'s Camp", name+" Slave")
		endif
	elseif itype == 103
		slaveDOM.EnterOnDuty("will join Karthwarsten's Mine", "Karthwarsten's Mine Slave")
	elseif itype == 104
		slaveDOM.EnterOnDuty("will join Stonehills' Mine", "Stonehills' Mine Slave")
	elseif itype == 105
		slaveDOM.EnterOnDuty("will join Dawnstar's Mine", "Dawnstar's Mine Slave")
	else ; itype == 100
		phhshPortableCellScript the_cell = PHSF.PortableFunctions.HoldingCellrefForCell(akRef.GetParentCell()) as phhshPortableCellScript
		if the_cell == None
			slaveDOM.EnterOnDuty("will join Player's Home", "House Slave")
		else
			string name = the_cell.GetNameCellRef()
			slaveDOM.EnterOnDuty("will join "+name+"'s Camp", name+" Slave")
		endif
	endif
	slaveDOM.OnUpdate()
	slaveDOM.OnUpdateGameTime()
EndFunction

bool Function IsAPlayerSlave(Actor akActor)
	if akActor == None
		return false
	endif
	if DOM != None && akActor.IsInFaction(DOMPlayerSlaveFaction)
		return true
	endif
	if PAH != None && akActor.IsInFaction(PAH.PAHPlayerSlaveFaction)
		return true
	endif
	return false
EndFunction

bool Function IsAPlayerSlaver(Actor akActor)
	if akActor == None
		return false
	endif
	if DOM != None && akActor.IsInFaction(DOM.DOMPlayerSlaverFaction)
		return true
	endif
	return false
EndFunction

bool Function IsBeingTrained(Actor slave, string trait)
	if slave == None
		return false
	endif
	int phase = slave.GetFactionRank(PHSF.IsTraineeFaction)

	if (phase < 0)
		return false
	endif
	if trait == "Pose"
		return true
	endif
	if phase == 0 && trait != "Combat" 
		return true ; all around
	endif
	if phase == 1 && (trait == "Submission" || trait == "Humiliation" || trait == "Resignation")
		return true ; obedience
	endif
	if phase == 2 && (trait == "Sex" || trait == "Oral" || trait == "Vaginal")
		return true ; sex
	endif
	if phase == 3 && trait == "Combat"
		return true ; combat
	endif
	return false
EndFunction

int Function GetFactionValue(Actor akTarget, Faction akFaction)
	if akTarget.IsInFaction(akFaction)
		return akTarget.GetFactionRank(akFaction)
	endif
	return 0
EndFunction

int Function GetTraining(Actor slave, string trait)
	if slave == None
		return 0
	endif
	if trait == "Submission"
		return GetSubmissionTraining(slave)
	endif
	if trait == "Fear"
		return GetFearTraining(slave)
	endif
	if trait == "Humiliation"
		return GetHumiliationTraining(slave)
	endif
	if trait == "Anger"
		return GetAngerTraining(slave)
	endif
	if trait == "Resignation"
		return GetResignationTraining(slave)
	endif
	if trait == "Respect"
		return GetRespectTraining(slave)
	endif
	if trait == "Sex"
		return GetSexTraining(slave)
	endif
	if trait == "Oral"
		return GetOralTraining(slave)
	endif
	if trait == "Anal"
		return GetAnalTraining(slave)
	endif
	if trait == "Vaginal"
		return GetVaginalTraining(slave)
	endif
	if trait == "Pose"
		return GetPoseTraining(slave)
	endif
	if trait == "Combat"
		return GetCombatTraining(slave)
	endif
	return -(1)
EndFunction

int Function GetSubmissionTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainSubmission)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHSubmission)
	endif
	return 0
EndFunction

int Function GetFearTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainFear)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainFear)
	endif
	return 0
EndFunction

int Function GetHumiliationTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainHumiliation)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHHumiliation)
	endif
	return 0
EndFunction

int Function GetAngerTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainAnger)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainAnger)
	endif
	return 0
EndFunction

int Function GetResignationTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainResignation)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHResignation)
	endif
	return 0
EndFunction

int Function GetRespectTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainRespect)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainRespect)
	endif
	return 0
EndFunction

int Function GetOralTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainOral)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainOral)
	endif
	return 0
EndFunction

int Function GetAnalTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainAnal)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainAnal)
	endif
	return 0
EndFunction

int Function GetVaginalTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainVaginal)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainVaginal)
	endif
	return 0
EndFunction

int Function GetCombatTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainCombat)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainCombat)
	endif
	return 0
EndFunction

int Function GetPoseTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainPose)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainPose)
	endif
	return 0
EndFunction

Function SetSubmissionTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainSubmission, value)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHSubmission, value)
	endif
EndFunction

Function SetFearTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainFear, value)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHTrainFear, value)
	endif
EndFunction

Function SetHumiliationTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainHumiliation, value)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHHumiliation, value)
	endif
EndFunction

Function SetAngerTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainAnger, value)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHTrainAnger, value)
	endif
EndFunction

Function SetResignationTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainResignation, value)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHResignation, value)
	endif
EndFunction

Function SetRespectTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainRespect, value)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHTrainRespect, value)
	endif
EndFunction

Function SetPoseTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainPose, value)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHTrainPose, value)
	endif
EndFunction

Function SetCombatTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainCombat, value)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHTrainCombat, value)
	endif
EndFunction

int Function GetSubmissionLevel(Actor slave)
	if slave == None
		return 0
	endif
	if DOM != None
		int sub = GetFactionValue(slave,DOMTrainSubmission)
		if sub == 0 && PAH != None && slave.IsInFaction(PAH.PAHSubmission)
			sub = slave.GetFactionRank(PAH.PAHSubmission)
		endif
		int hum = GetFactionValue(slave,DOMTrainHumiliation)
		int reg = GetFactionValue(slave,DOMTrainResignation)
		int tot = (sub+hum+reg)/3
		if tot > 0
			return tot
		endif
	endif
	if PAH != None
		return GetFactionValue(slave,PAH.PAHSubmission)
	endif
	return 0
EndFunction

int Function GetRespectLevel(Actor slave)
	if slave == None
		return 0
	endif
	if DOM != None
		int res = GetFactionValue(slave,DOMTrainRespect)
		if res == 0 && PAH != None && slave.IsInFaction(PAH.PAHTrainRespect)
			res = slave.GetFactionRank(PAH.PAHTrainRespect)
		endif
		int fea = GetFactionValue(slave,DOMTrainFear)
		int ang = GetFactionValue(slave,DOMTrainAnger)
		int tot = (res+fea+ang)/3
		if tot > 0
			return tot
		endif
	endif
	if PAH != None
		return GetFactionValue(slave,PAH.PAHTrainRespect)
	endif
	return 0
EndFunction

Function TrainSex(Actor slave, int value)
	DOM_Actor akActor = DOM.GetActor(slave)
	if akActor != None
		akActor.mind.TrainVaginal(value as float)
		akActor.mind.TrainAnal(value as float)
		akActor.mind.TrainOral(value as float)
		return
	endif
	int rank = GetSexTraining(slave)
	if rank >= 100
		return
	endif
	int f = rank + utility.Randomint(1, value)
	if (f > 100)
		f = 100
	endif
	SetSexTraining(slave,f)
EndFunction

int Function GetSexTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainSex)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHTrainSex)
	endif
	return 0
EndFunction

Function SetSexTraining(Actor slave, int value)
	if DOM != None
		slave.SetFactionRank(DOMTrainSex, value)
		SetSexSubFactions(slave)
	endif
	if PAH != None && PAH.PAHTrainSex != None
		slave.SetFactionRank(PAH.PAHTrainSex, value)
		SetSexSubFactions(slave)
	endif
EndFunction

int Function GetSexLevel(Actor slave)
	if slave == None
		return 0
	endif
	if DOM != None
		int sex  = GetFactionValue(slave,DOMTrainSex)
		int sexA = GetFactionValue(slave,DOMTrainAnal)
		int sexO = GetFactionValue(slave,DOMTrainOral)
		int sexV = GetFactionValue(slave,DOMTrainVaginal)
		LogTrace("Current DOM sex stat for " + slave.GetDisplayName() + "  S:" + sex + "  A:" + sexA + "  O:" + sexO + "  V:" + sexV)
		float sexC = (sexA + sexO + sexV) / 3.0
		if (math.floor(sexC) > sex)
			; Sex value out of date: update it
			LogTrace("Update main DOM sex stat for " + slave.GetDisplayName() + " to " + math.floor(sexC) + " from " + sex)
			sex = math.floor(sexC)
			slave.SetFactionRank(DOMTrainSex, sex)
		elseif (math.floor(sexC) < sex)
			; Separate sex stats out of date: update them
			LogTrace("Update separate DOM sex stats for " + slave.GetDisplayName() + " to " + sex)
			SetSexSubFactions(slave)
		else
			LogTrace("DOM Sex stats for " + slave.GetDisplayName() + " up to date: " + sex)
		endif
		if sex > 0
			return sex
		endif
	endif
	if PAH != None
		int sex  = GetFactionValue(slave,PAH.PAHTrainSex)
		int sexA = GetFactionValue(slave,PAH.PAHTrainAnal)
		int sexO = GetFactionValue(slave,PAH.PAHTrainOral)
		int sexV = GetFactionValue(slave,PAH.PAHTrainVaginal)
		LogTrace("Current PAH sex stat for " + slave.GetDisplayName() + "  S:" + sex + "  A:" + sexA + "  O:" + sexO + "  V:" + sexV)
		float sexC = (sexA + sexO + sexV) / 3.0
		if (math.floor(sexC) > sex)
			; Sex value out of date: update it
			LogTrace("Update main PAH sex stat for " + slave.GetDisplayName() + " to " + math.floor(sexC) + " from " + sex)
			sex = math.floor(sexC)
			slave.SetFactionRank(PAH.PAHTrainSex, sex)
		elseif (math.floor(sexC) < sex)
			; Separate sex stats out of date: update them
			LogTrace("Update separate PAH sex stats for " + slave.GetDisplayName() + " to " + sex)
			SetSexSubFactions(slave)
		else
			LogTrace("PAH Sex stats for " + slave.GetDisplayName() + " up to date: " + sex)
		endif
		return sex
	endif
	return 0
EndFunction

Function IncreaseSexTraining(Actor slave, int amount)
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		DOM_Actor akActor = DOM.GetActor(slave)
		if akActor != None
			DOM_Mind akMind = akActor.mind
			akMind.TrainOral(amount)
			akMind.TrainVaginal(amount)
			akMind.TrainAnal(amount)
			return
		endif
	endif
	if PAH != None && slave.IsInFaction(PAH.PAHPlayerSlaveFaction)
		PAHSlave slaveSlot = PAH.GetSlave(slave)
		if (slaveSlot != None)
			slaveSlot.TrainOral(amount)
			slaveSlot.TrainVaginal(amount)
			slaveSlot.TrainAnal(amount)
			return
		endif
	endif
	int sex = GetSexTraining(slave)
	sex += amount
	if (sex > 100)
		sex = 100
	endif
	SetSexTraining(slave,sex)
EndFunction

Function SetSexSubFactions(Actor slave)
	int sex  = 0
	int sexA = 0
	int sexO = 0
	int sexV = 0
	if DOM != None
		sex  = GetFactionValue(slave,DOMTrainSex)
		sexA = GetFactionValue(slave,DOMTrainAnal)
		sexO = GetFactionValue(slave,DOMTrainOral)
		sexV = GetFactionValue(slave,DOMTrainVaginal)
	endif
	if PAH != None && sex == 0
		sex  = GetFactionValue(slave,PAH.PAHTrainSex)
		sexA = GetFactionValue(slave,PAH.PAHTrainAnal)
		sexO = GetFactionValue(slave,PAH.PAHTrainOral)
		sexV = GetFactionValue(slave,PAH.PAHTrainVaginal)
	endif
	int sexC = math.floor((sexA + sexO + sexV) / 3.0)
	int delta = sex - sexC
	if delta > 0
		sexA += delta
		sexO += delta
		if (sexA > 100)
			sexO += sexA - 100
			sexA = 100
		endif
		if (sexO > 100)
			sexO = 100
		endif
		sexV += 3 * (sex - math.floor((sexA + sexO + sexV) / 3.0))
		if (sexV > 100)
			sexV = 100
		endif
		LogTrace("Updating stats for " + slave.GetDisplayName() + ", delta: " + delta + " from S:" + sex + " to A:" + sexA + "  O:" + sexO + "  V:" + sexV)

		if DOM != None
			slave.SetFactionRank(DOMTrainAnal, sexA)
			slave.SetFactionRank(DOMTrainOral, sexO)
			slave.SetFactionRank(DOMTrainAnal, sexV)
		endif
		if PAH != None
			slave.SetFactionRank(PAH.PAHTrainAnal, sexA)
			slave.SetFactionRank(PAH.PAHTrainOral, sexO)
			slave.SetFactionRank(PAH.PAHTrainAnal, sexV)
		endif
	elseif delta < 0
		sex = sexC
	endif
	if DOM != None
		slave.SetFactionRank(DOMTrainSex, sex)
	endif
	if PAH != None
		slave.SetFactionRank(PAH.PAHTrainSex, sex)
	endif
EndFunction

bool Function PAHSlaveNeedsEscort(Actor slave)
	if slave == None
		return false
	endif
	if PAH != None
		if slave.GetFactionRank(PAH.PAHResignation) < 70 &&  slave.GetFactionRank(PAH.PAHSubmission) < 70
			return true
		endif
	endif
	return false
EndFunction

bool Function PAHSlaveCanGuard(Actor slave)
	if slave == None
		return false
	endif
	if PAH != None
		if slave.GetFactionRank(PAH.PAHTrainCombat) >= 50
			if slave.GetFactionRank(PAH.PAHResignation) >= 70
				return true
			endif
			if slave.GetFactionRank(PAH.PAHResignation) >= 70
				return true
			endif
		endif
	endif
	return false
EndFunction

Function PoseAnim(Actor slave, string poseanim)
	if slave == None
		return
	endif
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		DOM_Actor akActor = DOM.GetActor(slave)	
		if akActor != None
			akActor.EnterChained(Game.GetPlayer(), None, PoseAnim)
			SendAnimationEvent(slave, poseanim)
			return
		endif
	endif
	if PAH != None && slave.IsInFaction(PAH.PAHPlayerSlaveFaction)
		PAHSlave slaveAlias = PAH.GetSlave(slave)
		if (slaveAlias != None)
			slaveAlias.should_pose = true  ; Needed to punish slave if not posing
			slaveAlias.setPose(1)          ; TAK Needed to start pose behaviour
			;slaveAlias.Wait()             ; TAK instead of wait behaviour
			SendAnimationEvent(slave, poseanim)
			return
		endif
	endif
	SendAnimationEvent(slave, poseanim)
EndFunction

Function Restrain(Actor slave, string pose)
	if slave == None
		return
	endif
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		DOM_Actor akActor = DOM.GetActor(slave)	
		if akActor != None
			akActor.EnterTieUp(Game.GetPlayer(), DOM.DOMZaz.zbfCuffsIronBlack, pose, pose)
			return
		endif
	endif
	if PAH != None && slave.IsInFaction(PAH.PAHPlayerSlaveFaction)
		PAHSlave slaveRef = PAH.GetSlave(slave)
		if (slaveRef != None)
			slaveRef.ChangeTiePose(pose, pose)
			slaveRef.TieUp(PAH.CuffsIron, Aggressor = Game.GetPlayer(), DoAnimation = true)
			return
		endif
	endif
	SendAnimationEvent(slave, pose)
EndFunction

Function RestrainInFurniture(Actor slave, ObjectReference furni, bool isActivator)
	if slave == None
		return
	endif
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		DOM_Actor akActor = DOM.GetActor(slave)
		if akActor != None
			akActor.EnterRestrainedInFurniture(furni, "", "")
			return
		endif
	endif
	if PAH != None && slave.IsInFaction(PAH.PAHPlayerSlaveFaction)
		PAHSlave slaveAlias = PAH.GetSlave(slave)
		if slaveAlias != None
			slaveAlias.FollowPlayer()
			utility.wait(1.0)
			slaveAlias.actor_alias.Follow(furni)
			slaveAlias.RestrainedInFurniture()
			return
		endif
	endif
	; Could be sent to Zaz for other actors
EndFunction

Function SexAbuse(Actor slave)
	if slave == None
		return
	endif
	if DOM != None
		int nsex = slave.GetFactionRank(DOMNbSex)
		if nsex < 127
			slave.SetFactionRank(DOMNbSex, nsex+1)
		endif
	endif
EndFunction

Function TellOff(Actor slave, string reason)
	if slave == None
		return
	endif
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		DOM_Actor akActor = DOM.GetActor(slave)
		if akActor != None
			akActor.StartScolding(Game.GetPlayer(),reason)
			return
		endif
	endif
	if PAH != None && slave.IsInFaction(PAH.PAHPlayerSlaveFaction)
		PAHSlave slaveAlias = PAH.GetSlave(slave)
		if slaveAlias != None
			slaveAlias.TellOff(reason)
		endif
	endif
EndFunction

Weapon Function GetTrainingWhip()
	if DOM != None
		return DOM.DOMEquip.DOMWhip
	endif
	if PAH != None
		return PAH.PAHWhip
	endif
	return None
EndFunction

Function SlaveInfoEffect(Actor akTarget, Actor akCaster)
	if DOM != None
		string msg = DOM.NPCStatsMessage(akTarget)
		Debug.MessageBox(msg)
	elseif PAH != None && PAHSlaveInfoMessage != None
		PAHSlave slave = PAH.GetSlave(akTarget)
		PAHSlaveInfoMessage.Show(\
			slave.submission, \
			slave.combat_training, \
			slave.anger_training, \
			slave.respect_training, \
			slave.pose_training, \
			slave.sex_training, \
			slave.fear_training \
		)
	endif
EndFunction

Function SendAnimationEvent(Actor akTarget, string animation)
	debug.sendanimationevent(akTarget, animation)
EndFunction

Function LogInfo(string msg)
	Debug.Trace("HSHInterface: "+msg)
EndFunction

Function LogTrace(String s)
	if isVerboseMode()
		Debug.Trace("HSHInterface: " + s)
	endif
EndFunction
