Scriptname DOM_PAH extends Quest  
Import Utility
Import DOM_Util

GlobalVariable Property DOM_HasPAH Auto

; PAH
PAHCore Property PAH Auto Hidden
PAHBootstrapScript Property PAHBoot Auto Hidden
PAHPunishmentRapeScript Property PAHPRS Auto Hidden
Faction Property PAHECanBeCaptured Auto Hidden
Faction Property PAHECanNotBeCaptured Auto Hidden
Faction Property PAHPosing Auto Hidden
Faction Property PAHBECleaning Auto Hidden
Faction Property PAHSubmission Auto Hidden
Quest Property DOMPAHQuest Auto Hidden

; DOM
DOM_PlayerAlias Property DOMPlayerAlias Auto 
DOM_Core Property DOM01 Auto
DOM_SlaveManager Property DOM02 Auto
DOM_Diary Property DOM04 Auto
DOM_Keys Property DOMKeys Auto
Actor Property PlayerRef Auto

; Factions
Faction Property PlayerFollowerFaction Auto
Faction Property DOMActionTied Auto
Faction Property DOMMoodLoyal Auto
Faction Property DOMMoodInlove Auto

; Training
Faction Property DOMTrainSubmission Auto
Faction Property DOMTrainFear Auto
Faction Property DOMTrainHumiliation Auto
Faction Property DOMTrainAnger Auto
Faction Property DOMTrainResignation Auto
Faction Property DOMTrainRespect Auto

Faction Property DOMTrainCombat Auto
Faction Property DOMTrainPose Auto
Faction Property DOMTrainSex Auto
Faction Property DOMTrainAnal Auto
Faction Property DOMTrainOral Auto
Faction Property DOMTrainVaginal Auto

; Main per training stat
Faction Property DOMModHumility Auto      ; Submission
Faction Property DOMModFearfulness Auto   ; Fear
Faction Property DOMModNaivety Auto       ; Humiliation
Faction Property DOMModForgiveness Auto   ; Anger
Faction Property DOMModPrudent Auto       ; Resignation
Faction Property DOMModDiscipline Auto    ; Respect

; Main per behaviour
Faction Property DOMModVaginal Auto       ; Submission
Faction Property DOMModAnal Auto          ; Fear
Faction Property DOMModOral Auto          ; Humiliation
Faction Property DOMModFlexibility Auto   ; Agreeableness, Posing
Faction Property DOMModPerfectionism Auto ; Conscientiousness
Faction Property DOMModCombat Auto        ; Specials

; Skills
Faction Property DOMSkillEnforcer Auto      ; Submission
Faction Property DOMSkillPersuader Auto     ; Fear
Faction Property DOMSkillDepraver Auto      ; Humiliation
Faction Property DOMSkillPredator Auto      ; Anger
Faction Property DOMSkillSlaver Auto        ; Resignation
Faction Property DOMSkillDeceiver Auto      ; Respect

; Love/Loyal
Faction Property DOMModModesty Auto       ; Honesty
Faction Property DOMModDependence Auto    ; Emotionality
Faction Property DOMModIngenuity Auto     ; Extraversion
Faction Property DOMModGentleness Auto    ; Agreeableness, being angry
Faction Property DOMModConsideration Auto ; Conscientiousness
Faction Property DOMModCreativity Auto    ; Openness

; Counters
Faction Property DOMNbChatFeelings Auto

; Love syndrome
Faction Property DOMLoveDesire Auto
Faction Property DOMLoyalWorship Auto
Faction Property DOMLoveFascination Auto
Faction Property DOMLoyalAbsolution Auto
Faction Property DOMLoyalDevotion Auto
Faction Property DOMLoveAdmiration Auto

Faction Property DOMTrainHouse Auto
Faction Property DOMTrainWorking Auto
Faction Property DOMTraumaInDays Auto

; Message boxes
Message Property DOMPAHStatusMessage Auto 
Message Property DOMPAHAbuseMessage Auto 
Message Property DOMPAHOrderMessage Auto 
Message Property DOMPAHPoseMessage Auto
Message Property DOMPAHTrainingMessage Auto 

bool Property standalone_mode = false Auto Hidden

; ------------------- Initialize and Functions with PAH != None check

Function Initialize()
	string pah_modname = "paradise_halls.esm"
	bool had_PAH = false
	if PAH != None
		had_PAH = true
	endif
	if DOMPlayerAlias == None
		ReferenceAlias player_alias = DOM01.GetAliasByName("PlayerAlias") as ReferenceAlias
		DOMPlayerAlias = player_alias as DOM_PlayerAlias
		LogInfo("WARNING: DOMPlayerAlias was not set - trying to recover DOMPlayerAlias="+DOMPlayerAlias)
	endif
	LogInfo("=================================================================================")
	if Game.GetModByName(pah_modname) != 255
		PAH     = Game.GetFormFromFile(0x0001FAEF, pah_modname) As PAHCore 
		if PAH != None
			PAHBoot              = Game.GetFormFromFile(0x0000CF32, pah_modname) As PAHBootstrapScript 
			PAHPRS               = Game.GetFormFromFile(0x000261BB, pah_modname) As PAHPunishmentRapeScript 
			PAHECanBeCaptured    = Game.GetFormFromFile(0x000325C8, pah_modname) As Faction
			PAHECanNotBeCaptured = Game.GetFormFromFile(0x0000F606, pah_modname) As Faction
			PAHPosing            = Game.GetFormFromFile(0x0000F607, pah_modname) As Faction
			PAHBECleaning        = Game.GetFormFromFile(0x0000F0A0, pah_modname) As Faction
			PAHSubmission        = Game.GetFormFromFile(0x000047EB, pah_modname) As Faction
			if Game.GetModByName("DOMPAH.esp") != 255
				DOMPAHQuest          = Game.GetFormFromFile(0x00000808, "DOMPAH.esp") As Quest
			else
				DOMPAHQuest          = None
			endif
			if PAHSubmission == None || PAHSubmission != PAH.PAHSubmission
				LogInfo("WARNING! WRONG INITIALIZATION!")
				LogTrace("submission1="+PAHSubmission)
				LogTrace("submission2="+PAH.PAHSubmission)
			endif
			DOM_HasPAH.SetValue(1.0)
			LogInfo("======             DOM: PAH found! DOM will run in add-on mode             ========")
			;LogInfo("DOM_HasPAH "+DOM_HasPAH+" = "+DOM_HasPAH.GetValue())
			if !had_PAH
				HudNotification("PAH found - DOM runs in addon mode")
			endif
			standalone_mode = false
		endif
	else
		PAH = None
	endif
	if PAH == None
		PAHBoot              = None
		PAHPRS               = None
		PAHECanBeCaptured    = None
		PAHECanNotBeCaptured = None
		PAHPosing            = None
		PAHBECleaning        = None
		PAHSubmission        = None
		DOMPAHQuest          = None
		DOM_HasPAH.SetValue(0.0)
		LogInfo("==            DOM: PAH not found! DOM will run in standalone mode            ==")
		;LogInfo("DOM_HasPAH "+DOM_HasPAH+" = "+DOM_HasPAH.GetValue())
		if !standalone_mode
			HudNotification("PAH not found - DOM runs in standalone mode")
		endif
		standalone_mode = true
	else
		LogInfo("DOMPAH Interface quest="+DOMPAHQuest)
		if DOMPAHQuest != None
			DOMPAHQuest.SetStage(10)
			LogInfo("DOMPAH Interface quest stage="+DOMPAHQuest.GetStage())
		endif
	endif
	LogInfo("=================================================================================")
EndFunction

Function EnsurePAHStarted()
	if PAH == None
		return
	endif
	int n=0
	While (!PAH.IsRunning() || PAH.IsStarting() || (PAH.modStatus != "$PAHE_SettingName_RebootToggle_running"))
		LogTrace("Waiting for PAH to start, status ="+PAH.modStatus)
		Utility.Wait(2.0)
		n+=1
		if n > 100
			LogTrace("Could not wait forever for PAH to start, status="+PAH.modStatus)
			return
		endif
	EndWhile
	LogTrace("PAH is running, status ="+PAH.modStatus)
EndFunction

bool Function hasPAH()
	if PAH == None
		return false
	endif
	return true
EndFunction

bool Function isPAH(Actor akTarget) ; Is a PAH slave
	if PAH == None
		return false
	endif
	if akTarget.IsInFaction(PAH.PAHPlayerSlaveFaction)
		return true
	endif
	return false
EndFunction

bool Function isTied(Actor akTarget)
	if PAHBoot == None
		return false
	endif
	if akTarget.IsInFaction(PAHBoot.PAHBETied)
		return true
	endif
	return false
EndFunction

int Function GetSlaveCount()
	if PAH == None
		return 0
	endif
	return PAH.GetSlaveCount()
EndFunction

int[] Function GetActorData(Actor akTarget)
	if PAH == None
		Int[] results = new Int[4]
		return results
	endif
	return PAH.NpcEval.GetActorData(akTarget) ; PAH origin data
EndFunction

Function SetActorData(Actor akTarget, int[] data)
	if PAH == None
		return
	endif
	PAH.NpcEval.StoreNpcFactionInfo(akTarget, data)
EndFunction

bool Function WasAlreadyCleaned(Actor akTarget)
	if PAH == None
		return false
	endif
	If akTarget.IsInFaction(PAH.PAHCleaned) ; Already captured
		return true
	endif
	return false
EndFunction

Function ResetAlreadyCleaned(Actor akTarget)
	if PAH == None
		return
	endif
	RemoveFromFaction(akTarget,PAH.PAHCleaned)
EndFunction

bool Function wornDwarvenDevice(Actor akTarget)
	if PAH == None
		return false
	endif
	if akTarget.WornHasKeyword(PAH.Pah_Dwarven_Device)
		return true
	endif
	return false
EndFunction

bool Function wornRestraint(Actor akTarget)
	if PAHBoot == None
		return false
	endif
	if akTarget.WornHasKeyword(PAHBoot.PAHRestraint)
		return true
	endif
	return false
EndFunction

bool Function wornLeash(Actor akTarget)
	if PAHBoot == None
		return false
	endif
	if akTarget.WornHasKeyword(PAHBoot.PAHRestraintLeash)
		return true
	endif
	return false
EndFunction

bool Function HasCountAsNaked(Actor akTarget)
	if PAHBoot == None
		return false
	endif
	if akTarget.WornHasKeyword(PAHBoot.PAHCountsAsNaked)
		return true
	endif
	return false
EndFunction

bool Function hasKeywordRestraint(Form the_form)
	if PAHBoot == None
		return false
	endif
	if the_form.HasKeyword(PAHBoot.PAHRestraint) || the_form.HasKeyword(PAHBoot.PAHRestraintLeash)
		return true
	endif
	return false
EndFunction

Function SetHasBeenPlayerSlaveFaction(Actor akTarget,int rank)
	if PAH == None || akTarget == PlayerRef
		return
	endif
	akTarget.SetFactionRank(PAH.PAHHasBeenPlayerSlaveFaction,rank)
EndFunction

Function CleanFactions(Actor akTarget)
	if PAH == None || akTarget == PlayerRef
		return
	endif
	akTarget.RemoveFromFaction(PAH.PAHPlayerSlaveFaction)
	akTarget.RemoveFromFaction(PAH.PAHHasBeenPlayerSlaveFaction)
EndFunction

Function SetTrainingFactionsToPAH(Actor akTarget)
	if PAH == None || akTarget == PlayerRef
		return
	endif
	akTarget.SetFactionRank(PAH.PAHSubmission,akTarget.getFactionRank(DOMTrainSubmission))
	akTarget.SetFactionRank(PAH.PAHTrainFear,akTarget.getFactionRank(DOMTrainFear))
	akTarget.SetFactionRank(PAH.PAHHumiliation,akTarget.getFactionRank(DOMTrainHumiliation))
	akTarget.SetFactionRank(PAH.PAHTrainAnger,akTarget.getFactionRank(DOMTrainAnger))
	akTarget.SetFactionRank(PAH.PAHResignation,akTarget.getFactionRank(DOMTrainResignation))
	akTarget.SetFactionRank(PAH.PAHTrainRespect,akTarget.getFactionRank(DOMTrainRespect))

	akTarget.SetFactionRank(PAH.PAHTrainCombat,akTarget.getFactionRank(DOMTrainCombat))
	akTarget.SetFactionRank(PAH.PAHTrainPose,akTarget.getFactionRank(DOMTrainPose))
	akTarget.SetFactionRank(PAH.PAHTrainSex,akTarget.getFactionRank(DOMTrainSex))
	akTarget.SetFactionRank(PAH.PAHTrainAnal,akTarget.getFactionRank(DOMTrainAnal))
	akTarget.SetFactionRank(PAH.PAHTrainOral,akTarget.getFactionRank(DOMTrainOral))
	akTarget.SetFactionRank(PAH.PAHTrainVaginal,akTarget.getFactionRank(DOMTrainVaginal))
EndFunction

Function SetTrainingFactionsToDOM(Actor akTarget)
	if PAH == None || akTarget == PlayerRef
		return
	endif
	akTarget.SetFactionRank(DOMTrainSubmission,akTarget.getFactionRank(PAH.PAHSubmission))
	akTarget.SetFactionRank(DOMTrainFear,akTarget.getFactionRank(PAH.PAHTrainFear))
	akTarget.SetFactionRank(DOMTrainHumiliation,akTarget.getFactionRank(PAH.PAHHumiliation))
	akTarget.SetFactionRank(DOMTrainAnger,akTarget.getFactionRank(PAH.PAHTrainAnger))
	akTarget.SetFactionRank(DOMTrainResignation,akTarget.getFactionRank(PAH.PAHResignation))
	akTarget.SetFactionRank(DOMTrainRespect,akTarget.getFactionRank(PAH.PAHTrainRespect))

	akTarget.SetFactionRank(DOMTrainCombat,akTarget.getFactionRank(PAH.PAHTrainCombat))
	akTarget.SetFactionRank(DOMTrainPose,akTarget.getFactionRank(PAH.PAHTrainPose))
	akTarget.SetFactionRank(DOMTrainSex,akTarget.getFactionRank(PAH.PAHTrainSex))
	akTarget.SetFactionRank(DOMTrainAnal,akTarget.getFactionRank(PAH.PAHTrainAnal))
	akTarget.SetFactionRank(DOMTrainOral,akTarget.getFactionRank(PAH.PAHTrainOral))
	akTarget.SetFactionRank(DOMTrainVaginal,akTarget.getFactionRank(PAH.PAHTrainVaginal))
EndFunction

Function CheckTrainingFactions(Actor akTarget)
	if PAH == None || akTarget == PlayerRef
		return
	endif
	bool is_pah = isPAH(akTarget)
	if akTarget.IsInFaction(PAH.PAHSubmission)
		int rank1 = akTarget.getFactionRank(PAH.PAHSubmission)
		int rank2 = akTarget.getFactionRank(DOMTrainSubmission)
		if rank1 > rank2	
			akTarget.SetFactionRank(DOMTrainSubmission,rank1)
		endif
		if !is_pah
			akTarget.RemoveFromFaction(PAH.PAHSubmission)
		endif
	endif
	if akTarget.IsInFaction(PAH.PAHTrainFear)
		int rank1 = akTarget.getFactionRank(PAH.PAHTrainFear)
		int rank2 = akTarget.getFactionRank(DOMTrainFear)
		if rank1 > rank2	
			akTarget.SetFactionRank(DOMTrainFear,rank1)
		endif
		if !is_pah
			akTarget.RemoveFromFaction(PAH.PAHTrainFear)
		endif
	endif
	if akTarget.IsInFaction(PAH.PAHHumiliation)
		int rank1 = akTarget.getFactionRank(PAH.PAHHumiliation)
		int rank2 = akTarget.getFactionRank(DOMTrainHumiliation)
		if rank1 > rank2	
			akTarget.SetFactionRank(DOMTrainHumiliation,rank1)
		endif
		if !is_pah
			akTarget.RemoveFromFaction(PAH.PAHHumiliation)
		endif
	endif
	if akTarget.IsInFaction(PAH.PAHTrainAnger)
		int rank1 = akTarget.getFactionRank(PAH.PAHTrainAnger)
		int rank2 = akTarget.getFactionRank(DOMTrainAnger)
		if rank1 > rank2	
			akTarget.SetFactionRank(DOMTrainAnger,rank1)
		endif
		if !is_pah
			akTarget.RemoveFromFaction(PAH.PAHTrainAnger)
		endif
	endif
	if akTarget.IsInFaction(PAH.PAHResignation)
		int rank1 = akTarget.getFactionRank(PAH.PAHResignation)
		int rank2 = akTarget.getFactionRank(DOMTrainResignation)
		if rank1 > rank2	
			akTarget.SetFactionRank(DOMTrainResignation,rank1)
		endif
		if !is_pah
			akTarget.RemoveFromFaction(PAH.PAHResignation)
		endif
	endif
	if akTarget.IsInFaction(PAH.PAHTrainRespect)
		int rank1 = akTarget.getFactionRank(PAH.PAHTrainRespect)
		int rank2 = akTarget.getFactionRank(DOMTrainRespect)
		if rank1 > rank2	
			akTarget.SetFactionRank(DOMTrainRespect,rank1)
		endif
		if !is_pah
			akTarget.RemoveFromFaction(PAH.PAHTrainRespect)
		endif
	endif
EndFunction

bool Function hasSubmissionTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainSubmission)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHSubmission)
EndFunction

bool Function hasFearTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainFear)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHTrainFear)
EndFunction

bool Function hasHumiliationTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainHumiliation)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHHumiliation)
EndFunction

bool Function hasAngerTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainAnger)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHTrainAnger)
EndFunction

bool Function hasResignationTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainResignation)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHResignation)
EndFunction

bool Function hasRespectTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainRespect)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHTrainRespect)
EndFunction

bool Function hasPoseTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainPose)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHTrainPose)
EndFunction

bool Function hasOralTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainOral)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHTrainOral)
EndFunction

bool Function hasVaginalTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainVaginal)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHTrainVaginal)
EndFunction

bool Function hasAnalTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainAnal)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHTrainAnal)
EndFunction

bool Function hasCombatTraining(Actor akRef)
	if akRef.IsInFaction(DOMTrainCombat)
		return true
	endif
	if PAH == None
		return false
	endif
	return akRef.IsInFaction(PAH.PAHTrainCombat)
EndFunction

int Function GetSubmissionFromFaction(Actor akTarget)
	if PAH == None
		return akTarget.getFactionRank(DOMTrainSubmission)
	endif
	;LogTrace(akTarget.GetDisplayname()+" GetSubmissionFromFaction="+GetTrainingFromFaction(akTarget,PAH.PAHSubmission,DOMTrainSubmission))
	return GetTrainingFromFaction(akTarget,PAH.PAHSubmission,DOMTrainSubmission)
EndFunction

int Function GetFearFromFaction(Actor akTarget)
	if PAH == None
		return akTarget.getFactionRank(DOMTrainFear)
	endif
	return GetTrainingFromFaction(akTarget,PAH.PAHTrainFear,DOMTrainFear)
EndFunction

int Function GetHumiliationFromFaction(Actor akTarget)
	if PAH == None
		return akTarget.getFactionRank(DOMTrainHumiliation)
	endif
	return GetTrainingFromFaction(akTarget,PAH.PAHHumiliation,DOMTrainHumiliation)
EndFunction

int Function GetAngerFromFaction(Actor akTarget)
	if PAH == None
		return akTarget.getFactionRank(DOMTrainAnger)
	endif
	return GetTrainingFromFaction(akTarget,PAH.PAHTrainAnger,DOMTrainAnger)
EndFunction

int Function GetResignationFromFaction(Actor akTarget)
	if PAH == None
		return akTarget.getFactionRank(DOMTrainResignation)
	endif
	return GetTrainingFromFaction(akTarget,PAH.PAHResignation,DOMTrainResignation)
EndFunction

int Function GetRespectFromFaction(Actor akTarget)
	if PAH == None
		return akTarget.getFactionRank(DOMTrainRespect)
	endif
	return GetTrainingFromFaction(akTarget,PAH.PAHTrainRespect,DOMTrainRespect)
EndFunction

int Function GetSexFromFaction(Actor akTarget)
	if PAH == None
		return akTarget.getFactionRank(DOMTrainSex)
	endif
	return GetTrainingFromFaction(akTarget,PAH.PAHTrainSex,DOMTrainSex)
EndFunction

int Function GetAnalFromFaction(Actor akTarget)
	int rank
	if PAH == None
		rank = akTarget.getFactionRank(DOMTrainAnal)
	else
		rank = GetTrainingFromFaction(akTarget,PAH.PAHTrainAnal,DOMTrainAnal)
	endif
	if DOM01.readSexlabValuesToggle
		return DOM01.DOMSexlab.GetSexlabValue(akTarget,"Anal",rank)
	endif
	return rank
EndFunction

int Function GetOralFromFaction(Actor akTarget)
	int rank
	if PAH == None
		rank = akTarget.getFactionRank(DOMTrainOral)
	else
		rank = GetTrainingFromFaction(akTarget,PAH.PAHTrainOral,DOMTrainOral)
	endif
	if DOM01.readSexlabValuesToggle
		return DOM01.DOMSexlab.GetSexlabValue(akTarget,"Oral",rank)
	endif
	return rank
EndFunction

int Function GetVaginalFromFaction(Actor akTarget)
	int rank
	if PAH == None
		rank = akTarget.getFactionRank(DOMTrainVaginal)
	else
		rank = GetTrainingFromFaction(akTarget,PAH.PAHTrainVaginal,DOMTrainVaginal)
	endif
	;LogTrace("GetVaginalFromFaction rank="+rank+" PAH="+PAH)
	;LogTrace("GetVaginalFromFaction sexlab="+DOM01.DOMSexlab.GetSexlabValue(akTarget,"Vaginal",rank))
	if DOM01.readSexlabValuesToggle
		return DOM01.DOMSexlab.GetSexlabValue(akTarget,"Vaginal",rank)
	endif
	return rank
EndFunction

int Function GetPoseFromFaction(Actor akTarget)
	if PAH == None
		return akTarget.getFactionRank(DOMTrainPose)
	endif
	return GetTrainingFromFaction(akTarget,PAH.PAHTrainPose,DOMTrainPose)
EndFunction

float Function GetCombatFromFaction(Actor akTarget)
	if PAH == None
		return GetFactionRankFloat(akTarget,DOMTrainCombat)
	endif
	return GetTrainingFromFactionFloat(akTarget,PAH.PAHTrainCombat,DOMTrainCombat)
EndFunction

int Function GetTrainingFromFaction(Actor akTarget, Faction PAH_faction, Faction DOM_Faction)
	if !akTarget.IsInFaction(PAH_faction) 
		if !akTarget.IsInFaction(DOM_Faction)
			return 0
		endif
		return akTarget.getFactionRank(DOM_Faction)
	endif
	if !akTarget.IsInFaction(DOM_Faction)
		return akTarget.getFactionRank(PAH_faction)
	endif
	int rank_pah = akTarget.getFactionRank(PAH_faction)
	int rank_DOM = akTarget.getFactionRank(DOM_Faction)
	if !akTarget.IsInFaction(PAH.PAHPlayerSlaveFaction)
		bool is_hsh = false
		bool is_aygas = false
		if DOM01.HshHouseSlaveFaction != None && akTarget.IsInFaction(DOM01.HshHouseSlaveFaction)
			is_hsh = true
		endif
		if DOM01.AygasSlaveTypeFaction != None && akTarget.IsInFaction(DOM01.AygasSlaveTypeFaction)
			is_aygas = true
		endif
		if !is_hsh && !is_aygas ; clean unusued faction
			akTarget.RemoveFromFaction(PAH_faction)
			if rank_DOM > rank_pah
				return rank_DOM
			else
				if rank_DOM < rank_pah
					akTarget.SetFactionRank(DOM_Faction,rank_pah)
				endif
				return rank_pah
			endif
		elseif rank_DOM > rank_pah
			akTarget.SetFactionRank(PAH_faction,rank_DOM)
			return rank_DOM
		else
			if rank_DOM < rank_pah
				akTarget.SetFactionRank(DOM_Faction,rank_pah)
			endif
			return rank_pah
		endif
	endif
	if rank_DOM > rank_pah
		akTarget.SetFactionRank(PAH_Faction,rank_DOM)
		return rank_DOM
	endif
	if rank_DOM < rank_pah
		akTarget.SetFactionRank(DOM_Faction,rank_pah)
	endif
	return rank_pah
EndFunction

string Function GetBehaviourMessage(Actor akTarget)
	if akTarget.GetFactionRank(PAHBoot.PAHBETied) > 1
		return "is restrained"
	elseif akTarget.IsInFaction(PAHBoot.PAHBETied)
		return "is tied"
	elseif akTarget.IsInFaction(PAHBoot.PAHBEFollowing)
		return "is following you"
	elseif akTarget.IsInFaction(PAHPosing)
		return "is posing"
	elseif akTarget.IsInFaction(PAHBoot.PAHBEWaiting) || akTarget.IsInFaction(PAHBoot.PAHBEWaitingAtLeashPoint)
		return "is waiting"
	elseif akTarget.IsInFaction(PAHBECleaning)
		return "is cleaning"
	elseif akTarget.IsInFaction(PAHBoot.PAHBERunningAway) 
		return "is running away"
	elseif akTarget.IsInFaction(PAHBoot.PAHBEFleeingAndCowering) 
		return "is trying to flee"
	elseif akTarget.IsInFaction(PAHBoot.PAHAAStandStill)
		return "is doing nothing"
	elseif akTarget.IsInFaction(PAHBoot.PAHAASandboxAtTarget)
		return "is busying around"
	endif
	return ""
EndFunction

string Function GetFeelingsMessage(Actor akTarget)
	string mood = GetMoodMessage(akTarget)
	string msg = "I am a PAH slave, my mood is "+mood+"\n"

	msg = msg+DOMFeelingsHeaderLine2(akTarget,"Submission     = ",PAH.PAHSubmission,  "Desire         = ",DOMLoveDesire)
	msg = msg+DOMFeelingsLine2(akTarget,"Fear           = ",PAH.PAHTrainFear,   "Worship        = ",DOMLoyalWorship)
	msg = msg+DOMFeelingsLine2(akTarget,"Humiliation    = ",PAH.PAHHumiliation, "Fascination    = ",DOMLoveFascination)    
	msg = msg+DOMFeelingsLine2(akTarget,"Anger training = ",PAH.PAHTrainAnger,  "Absolution     = ",DOMLoyalAbsolution)          
	msg = msg+DOMFeelingsLine2(akTarget,"Resignation    = ",PAH.PAHResignation, "Devotion       = ",DOMLoyalDevotion)
	msg = msg+DOMFeelingsLine2(akTarget,"Respect        = ",PAH.PAHTrainRespect,"Admiration     = ",DOMLoveAdmiration)    

	msg = msg+DOMFeelingsLine(akTarget,"Pose training    = ",PAH.PAHTrainPose)
	msg = msg+DOMFeelingsLine(akTarget,"Oral training    = ",PAH.PAHTrainOral)
	msg = msg+DOMFeelingsLine(akTarget,"Vaginal training = ",PAH.PAHTrainVaginal)
	msg = msg+DOMFeelingsLine(akTarget,"Anal training    = ",PAH.PAHTrainAnal)

	msg = msg+DOMFeelingsLine(akTarget,"Combat training  = ",PAH.PAHTrainCombat)
	msg = msg+DOMFeelingsLine(akTarget,"House keeping    = ",DOMTrainHouse)
	msg = msg+DOMFeelingsLine(akTarget,"Working          = ",DOMTrainWorking)
	msg = msg+DOMFeelingsLine(akTarget,"Trauma           = ",DOMTraumaInDays)
	
	msg = msg+DOMFeelingsLine(akTarget,"Enforcer skill   = ",DOMSkillEnforcer)
	msg = msg+DOMFeelingsLine(akTarget,"Persuader skill  = ",DOMSkillPersuader)
	msg = msg+DOMFeelingsLine(akTarget,"Depraver skill   = ",DOMSkillDepraver)
	msg = msg+DOMFeelingsLine(akTarget,"Predator skill   = ",DOMSkillPredator)
	msg = msg+DOMFeelingsLine(akTarget,"Slaver skill     = ",DOMSkillSlaver)
	msg = msg+DOMFeelingsLine(akTarget,"Deceiver skill   = ",DOMSkillDeceiver)
	
	return msg
EndFunction

float Function GetTrainingFromFactionFloat(Actor akTarget, Faction PAH_faction, Faction DOM_Faction)
	if !akTarget.IsInFaction(PAH_faction)
		return GetFactionRankFloat(akTarget,DOM_Faction)
	endif
	float rank_pah = GetFactionRankFloat(akTarget,PAH_faction)
	float rank_DOM = GetFactionRankFloat(akTarget,DOM_Faction)
	if !akTarget.IsInFaction(PAH.PAHPlayerSlaveFaction)
		bool is_hsh = false
		bool is_aygas = false
		if DOM01.HshHouseSlaveFaction != None && akTarget.IsInFaction(DOM01.HshHouseSlaveFaction)
			is_hsh = true
		endif
		if DOM01.AygasSlaveTypeFaction != None && akTarget.IsInFaction(DOM01.AygasSlaveTypeFaction)
			is_aygas = true
		endif
		if !is_hsh && !is_aygas ; clean unusued faction
			akTarget.RemoveFromFaction(PAH_faction)
			if rank_DOM > rank_pah
				return rank_DOM
			else
				if rank_DOM < rank_pah
					akTarget.SetFactionRank(DOM_Faction,rank_pah as int)
				endif
				return rank_pah
			endif
		elseif rank_DOM > rank_pah
			akTarget.SetFactionRank(PAH_faction,rank_DOM as int)
			return rank_DOM
		else
			if rank_DOM < rank_pah
				akTarget.SetFactionRank(DOM_Faction,rank_pah as int)
			endif
			return rank_pah
		endif
	endif
	if rank_DOM > rank_pah
		akTarget.SetFactionRank(PAH_Faction,rank_DOM as int)
		return rank_DOM
	endif
	if rank_DOM < rank_pah
		akTarget.SetFactionRank(DOM_Faction,rank_pah as int)
	endif
	return rank_pah
EndFunction

Function ClearCanBeCaptured(Actor akTarget)
	if PAHECanBeCaptured == None || akTarget == PlayerRef
		return
	endif
	akTarget.removeFromFaction(PAHECanBeCaptured)
EndFunction

Function ClearCanNotBeCaptured(Actor akTarget)
	if PAHECanNotBeCaptured == None || akTarget == PlayerRef
		return
	endif
	akTarget.removeFromFaction(PAHECanNotBeCaptured)
EndFunction

Function SetCanNotBeCaptured(Actor akTarget)
	if PAHECanNotBeCaptured == None || akTarget == PlayerRef
		return
	endif
	akTarget.AddToFaction(PAHECanNotBeCaptured)
EndFunction

bool Function IsLeashPointInUse(DOMLeashPointScript objScript)
	if PAH.clearing_leash_point
		return false
	endif
	if PAH.LeashPointInUse(objScript)
		return true
	endif
	return false
EndFunction

Function ClearLeashPoint(DOMLeashPointScript objScript)
	PAH.ClearLeashPoint(objScript)
EndFunction

Function SummonSlaves(Actor akTarget, bool only_fighters)
	if PAH == None
		return
	endif
	LogTrace("SummonSlaves only_fighters="+only_fighters+" also_posing="+DOM01.summonPosingToggle+" also_pah="+DOM01.summonPAHToggle)
	int	n = PAH.GetSlaveCount()
	int i = 0
	while i < n
		PAHSlave akSlave = PAH.GetSlaveByIndex(i)
		if akSlave != None
			if IsToBeSummoned(akSlave,only_fighters)
				LogTrace("SummonSlaves summon "+akSlave.GetName())
				akSlave.GetActorRef().moveTo(akTarget)
			endif
		endif
		i += 1
	endwhile
EndFunction

Function SummonRunnerSlaves(Actor akTarget)
	if PAH == None
		return
	endif
	LogTrace("SummonRunnerSlaves also_pah="+DOM01.summonPAHToggle)
	int	n = PAH.GetSlaveCount()
	int i = 0
	while i < n
		PAHSlave akSlave = PAH.GetSlaveByIndex(i)
		if akSlave != None
			if akSlave.behaviour == "running_away" || akSlave.behaviour == "flee_and_cower"
				LogTrace("SummonRunnerSlaves summon "+akSlave.GetName())
				akSlave.GetActorRef().moveTo(akTarget)
			endif
		endif
		i += 1
	endwhile
EndFunction

Function SummonFollowerSlaves(Actor akTarget)
	if PAH == None
		return
	endif
	LogTrace("SummonFollowerSlaves")
	int	n = PAH.GetSlaveCount()
	int i = 0
	while i < n
		PAHSlave akSlave = PAH.GetSlaveByIndex(i)
		if akSlave != None
			if akSlave.behaviour == "follow_player"
				LogTrace("SummonFollowerSlaves summon "+akSlave.GetName())
				akSlave.GetActorRef().moveTo(akTarget)
			endif
		endif
		i += 1
	endwhile
EndFunction

bool Function IsToBeSummoned(PAHSlave akSlave, bool only_fighters)
	; Ignore tiedup and working slaves
	Actor akRef = akSlave.GetActorRef()
	if akRef.IsInFaction(PAHBoot.PAHBETied)
		LogTrace("IsToBeSummoned ignore restrained or doing nothing "+akSlave.GetName())
		return false
	endif
	
	; Only bodyguards
	if only_fighters
		if akSlave.should_be_respectful
			if !DOM01.summonPosingToggle ; Ignore posing slaves
				if !akRef.IsInFaction(PAHPosing)
					LogTrace("IsToBeSummoned select canIdleSoft fighter "+akSlave.GetName())
					return true
				endif
			else
				LogTrace("IsToBeSummoned select non posing fighter "+akSlave.GetName())
				return true
			endif
		endif
		LogTrace("IsToBeSummoned ignore non fighter or can not idle "+akSlave.GetName())
		return false
	endif
	
	; All slaves
	if !DOM01.summonPosingToggle ; Ignore posing slaves
		if !akRef.IsInFaction(PAHPosing)
			LogTrace("IsToBeSummoned select canIdleSoft "+akSlave.GetName())
			return true
		endif
	else
		LogTrace("IsToBeSummoned select non posing "+akSlave.GetName())
		return true
	endif
	LogTrace("IsToBeSummoned ignore can not idle "+akSlave.GetName())
	return false
EndFunction

string Function GetMoodMessage(Actor akTarget)
	if PAHBoot == None
		return ""
	endif
	if akTarget.IsInFaction(PAHBoot.PAHMoodJustCaptured)
		return " was just captured"
	elseif akTarget.IsInFaction(PAHBoot.PAHMoodNeutral)
		return " is ok"
	elseif akTarget.IsInFaction(PAHBoot.PAHMoodAngry)
		return " is angry"
	elseif akTarget.IsInFaction(PAHBoot.PAHMoodAfraid)
		return " is afraid"
	endif
	return ""
EndFunction

string Function GetMood(Actor akTarget)
	if PAHBoot == None
		return ""
	endif
	if akTarget.IsInFaction(PAHBoot.PAHMoodJustCaptured)
		return "being captured"
	elseif akTarget.IsInFaction(PAHBoot.PAHMoodAngry)
		return "angry"
	elseif akTarget.IsInFaction(PAHBoot.PAHMoodAfraid)
		return "afraid"
	elseif akTarget.IsInFaction(PAHBoot.PAHMoodNeutral)
		return " neutral"
	endif
	return ""
EndFunction

Function WriteSaveFaction(string fileName)
	if PAH == None
		return
	endif
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHRegionFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHJobsFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHEmployersFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.NpcEval.PAHTrainersFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHHasBeenPlayerSlaveFaction,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHSubmission,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainFear,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHHumiliation,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainAnger,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHResignation,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainRespect,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainCombat,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainPose,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainSex,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainAnal,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainOral,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", PAH.PAHTrainVaginal,false)		
EndFunction

Function WriteConfig(string fileName)
	if PAH == None
		return
	endif
	JsonUtil.SetFloatValue(fileName, "PostDelay",         PAH.Config.postRapeDelay)
	;JsonUtil.SetIntValue(fileName,   "markkey",           PAH.Config.hotkey)
	JsonUtil.SetIntValue(fileName,   "renametoggle",      PAH.Config.renameToggle as Int)
	JsonUtil.SetIntValue(fileName,   "allwaysaggressive", PAH.bAlwaysAggressive as Int)
	JsonUtil.SetIntValue(fileName,   "leashtoggle",       PAH.Config.leashToggle as Int)
	JsonUtil.SetIntValue(fileName,   "outfittoggle",      PAH.Config.NakedOutfitDisabled as Int)
EndFunction

Function ReadConfig(string fileName)
	if PAH == None
		return
	endif
	PAH.Config.postRapeDelay       = JsonUtil.GetFloatValue(fileName, "PostDelay", 15.0)	
	;PAH.Config.hotkey              = JsonUtil.GetIntValue(fileName, "markkey", -1)
	PAH.Config.renameToggle        = JsonUtil.GetIntValue(fileName, "renametoggle", 1)
	PAH.bAlwaysAggressive          = JsonUtil.GetIntValue(fileName, "allwaysaggressive", 0)
	PAH.Config.leashToggle         = JsonUtil.GetIntValue(fileName, "leashtoggle", 1)
	PAH.Config.NakedOutfitDisabled = JsonUtil.GetIntValue(fileName, "outfittoggle", 0)
EndFunction

Function TransferPAHEtoDOM()
	if PAH == None
		return
	endif
	int nDOM = DOM02.GetActorCount()
	int nmax = DOM02.GetMaxActorCount()
	int n = PAH.GetSlaveCount()
	LogTrace("TransferPAHEtoDOM() found "+n+" PAH actors will join "+nDOM+"/"+nmax+" DOM actors")
	int i = 1
	while i < n && nDOM+i < nmax
		PAHSlave sl_alias = PAH.GetSlaveByIndex(0)
		if sl_alias != None
			HudNotification("TransferPAHEtoDOM() found actor index="+i+" name="+sl_alias.getName())
			MoveActorToDOM(sl_alias)
		endif
		i += 1
	endwhile
	
	HudNotification("Done transferring "+(n-(1))+" actors to DOM")
	HudNotification("First PAH slave kept to avoid buggy array")
EndFunction

Function TransferDOMtoPAHE()
	if PAH == None
		return
	endif
	int npah = PAH.GetSlaveCount()
	int nmax = PAH.GetMaxSlaveCount()
	int n = DOM02.GetActorCount()
	LogTrace("TransferDOMtoPAHE() found "+n+" DOM actors will join "+npah+"/"+nmax+" PAH actors")
	int i = 0
	while i < n && npah+i < nmax
		DOM_Actor sl_alias = DOM02.GetActorByIndex(0)
		if sl_alias != None
			LogTrace("TransferDOMtoPAHE() found actor index="+i+" name="+sl_alias.getName())
			MoveActorToPAH(sl_alias)
		endif
		i += 1
	endwhile
	
	HudNotification("Done transferring "+n+" actors to PAH")
EndFunction

; ------------------- Actor managment - Functions without PAH != None check

PAHActorAlias Function GetSlaveAlias(Actor akTarget)
	if PAH == None
		return None
	endif
	return PAH.GetSlaveAlias(akTarget) as PAHActorAlias
EndFunction

Function ReleaseSlave(Actor akTarget)
	PAHSlave sl_alias = PAH.GetSlave(akTarget)
	if sl_alias != None
		LogTrace(sl_alias.getName()+": Releasing PAH slave")
		sl_alias.ReleaseSlave()
	endif	
EndFunction

Function ClearFactions(Actor akTarget)
	if PAH == None
		return
	endif
	
	akTarget.RemoveFromFaction(PAH.PAHPlayerSlaveFaction)
	
	if PAHPosing != None
		akTarget.RemoveFromFaction(PAHPosing)
	endif
	
	if PAHBECleaning != None
		akTarget.RemoveFromFaction(PAHBECleaning)
	endif

	if PAHECanBeCaptured != None
		akTarget.RemoveFromFaction(PAHECanBeCaptured)
	endif

	if PAHECanNotBeCaptured != None
		akTarget.RemoveFromFaction(PAHECanNotBeCaptured)
	endif
	
	if PAHBoot == None
		return
	endif

	akTarget.RemoveFromFaction(PAHBoot.PAHBETied)
	akTarget.RemoveFromFaction(PAHBoot.PAHBECalm)
	akTarget.RemoveFromFaction(PAHBoot.PAHBEFollowing)
	akTarget.RemoveFromFaction(PAHBoot.PAHBEWaiting)
	akTarget.RemoveFromFaction(PAHBoot.PAHBEFleeingAndCowering)
	akTarget.RemoveFromFaction(PAHBoot.PAHBERunningAway)
	akTarget.RemoveFromFaction(PAHBoot.PAHBEWaitingAtLeashPoint)
	akTarget.RemoveFromFaction(PAHBoot.PAHAAStandStill)
	akTarget.RemoveFromFaction(PAHBoot.PAHAASandboxAtTarget)
EndFunction

Function ClearTrainingFactions(Actor akTarget)
	if PAH == None
		return
	endif
	
	akTarget.RemoveFromFaction(PAH.PAHSubmission)
	akTarget.RemoveFromFaction(PAH.PAHTrainFear)
	akTarget.RemoveFromFaction(PAH.PAHHumiliation)
	akTarget.RemoveFromFaction(PAH.PAHTrainAnger)
	akTarget.RemoveFromFaction(PAH.PAHResignation)
	akTarget.RemoveFromFaction(PAH.PAHTrainRespect)
	akTarget.RemoveFromFaction(PAH.PAHTrainCombat)
	akTarget.RemoveFromFaction(PAH.PAHTrainPose)
	akTarget.RemoveFromFaction(PAH.PAHTrainSex)
	akTarget.RemoveFromFaction(PAH.PAHTrainAnal)
	akTarget.RemoveFromFaction(PAH.PAHTrainOral)
	akTarget.RemoveFromFaction(PAH.PAHTrainVaginal)
	
	if PAHBoot == None
		return
	endif

	akTarget.RemoveFromFaction(PAHBoot.PAHMoodNeutral)
	akTarget.RemoveFromFaction(PAHBoot.PAHMoodAfraid)
	akTarget.RemoveFromFaction(PAHBoot.PAHMoodAngry)
	akTarget.RemoveFromFaction(PAHBoot.PAHMoodJustCaptured)
	akTarget.RemoveFromFaction(PAHBoot.PAHRespectful)
EndFunction

Function MoveActorToDOM(PAHSlave akSlave)
	if PAHBoot == None
		return
	endif
	if akSlave == None
		return
	endif
	Actor akActor = akSlave.GetActorRef()
	if akActor == None
		return
	endif
	
	HudNotification("Transfering "+akSlave.GetName()+" to DOM")
	string behaviour = akSlave.behaviour
	if akActor.IsInFaction(PAHBoot.PAHBETied)
		behaviour = "tied"
	endif
	bool is_naked = akSlave.actor_alias.naked

	ReferenceAlias slaveAlias = akSlave as ReferenceAlias
	if (slaveAlias != None)
		LogTrace("Removing actor from PAH "+akActor.getDisplayName())
		PAH.RemoveSlave(slaveAlias)
	endif
	LogTrace("Adding actor to DOM "+akActor.getDisplayName()+" behaviour="+behaviour+" naked="+is_naked)
	
	akActor.RemoveFromFaction(PAHECanBeCaptured)
	
	SetTrainingFactionsToDOM(akActor)
	DOM_Actor slave = DOM02.AddActor(akActor,"",false)
	if is_naked
		slave.mind.should_be_naked = true
	else
		slave.mind.should_be_naked = false
	endif
	if behaviour == "follow_player"
		slave.EnterFollowPlayer()
	elseif behaviour == "wait_sandbox"
		slave.EnterWaitSandbox()
	elseif behaviour == "wait_at_leash_point"
		slave.WaitAtLeashPoint()
	elseif behaviour == "tied" || behaviour == "restrained_in_furniture"
		slave.EnterTieUp(None)
	elseif behaviour == "cleanHouse"
		slave.EnterSweep()
	else
		slave.EnterWait()
	endif
EndFunction

Function MoveActorToPAH(DOM_Actor akSlave)
	if akSlave == None
		return
	endif
	LogTrace("MoveToPAH Slave "+akSlave.GetName()+" PAH="+PAH)
	if PAH == None
		return
	endif
	Actor akActor = akSlave.akRef
	if akActor == None
		return
	endif
	HudNotification("Transfering "+akActor.GetDisplayName()+" to PAH")
	LogTrace("Removing actor from DOM "+akActor.getDisplayName())
	string behaviour = akSlave.behaviour
	string mood = akSlave.mind.mood
	if akActor.IsInFaction(DOMActionTied)
		behaviour = "tied"
	endif
	if akSlave.mind.submission < 10.0
		akSlave.mind.submission = 10.0
	endif
	bool is_naked = akSlave.mind.should_be_naked
	DOM04.NotifyReleasetoPAH(akSlave)
	akSlave.SetRestoreOutfitOnRelease(false)
	DOM01.ReleaseActor(akActor)
	LogTrace("Adding actor to PAH "+akActor.getDisplayName()+" behaviour="+behaviour+" naked="+is_naked)
	SetMoodFaction(akActor,mood)
	SetTrainingFactionsToPAH(akActor)
	PAHSlave slave = PAH.AddSlave(akActor)
	Actor akRef = slave.GetActorRef()
	slave.should_fight_for_player = false
	if is_naked
		slave.actor_alias.Strip()
	else
		slave.EquipInventory()
	endif
	if behaviour == "follow_player"
		slave.FollowPlayer()
	elseif behaviour == "wait_sandbox"
		slave.WaitSandbox()
	elseif behaviour == "wait_at_leash_point"
		slave.WaitAtLeashPoint()
	elseif behaviour == "tied"
		slave.TieUp(DOM01.DOMZaz.GetCuffsRope(), Aggressor = None, DoAnimation = false, Enter = true)
	else
		slave.Wait()
	endif
EndFunction

Function SetMoodFaction(Actor akTarget, string mood)
	if PAHBoot == None || akTarget == PlayerRef
		return
	endif
	if mood == "just_captured" 
		akTarget.SetFactionRank(PAHBoot.PAHMoodJustCaptured,1)
	elseif mood == "angry" || mood == "defiant" || mood == "jealous"
		akTarget.SetFactionRank(PAHBoot.PAHMoodAngry,1)
	elseif mood == "afraid" || mood == "terrified" || mood == "scared" || mood == "broken" || mood == "inshock"
		akTarget.SetFactionRank(PAHBoot.PAHMoodAfraid,1)
	else
		akTarget.SetFactionRank(PAHBoot.PAHMoodNeutral,1)
	endif
	if mood == "loyal"
		akTarget.setRelationshipRank(PlayerRef,3)
	elseif mood == "inlove" || mood == "depressed" || mood == "insecure" || mood == "jealous"
		akTarget.setRelationshipRank(PlayerRef,4)
	endif
EndFunction

; ------------------- Info messages - Functions without PAH != None check

string Function TrainingMessage(Actor akTarget)
	PAHSlave akActor = PAH.GetSlave(akTarget)
	if akActor == None
		return ""
	endif
	float[] training = new Float[21]
	training[0] = akActor.submission
	training[1] = akActor.fear_training
	training[2] = akActor.humiliation
	training[3] = akActor.anger_training
	training[4] = akActor.resignation
	training[5] = akActor.respect_training
	
	training[6] = akActor.pose_training
	training[7] = akActor.sex_training
	training[8] = akActor.combat_training
	training[9] = akTarget.GetFactionRank(DOMTrainHouse)
	training[10]= akActor.oral_training
	training[11]= akActor.vaginal_training
	training[12]= akActor.anal_training
	training[13] = akTarget.GetFactionRank(DOMTrainWorking)

	training[14]= akTarget.GetFactionRank(DOMSkillEnforcer)
	training[15]= akTarget.GetFactionRank(DOMSkillPredator)
	training[16]= akTarget.GetFactionRank(DOMSkillDepraver)
	training[17]= akTarget.GetFactionRank(DOMSkillPersuader)
	training[18]= akTarget.GetFactionRank(DOMSkillSlaver)
	training[19]= akTarget.GetFactionRank(DOMSkillDeceiver)
	
	training[20]= akTarget.GetFactionRank(DOMTraumaInDays)

	return DOM01.GetTrainingMessage(akTarget, training)
EndFunction

string Function MoodInfo(Actor akTarget)
	PAHSlave akActor = PAH.GetSlave(akTarget)
	if akActor == None
		return ""
	endif
	PAHSlaveMind akMind = akActor.mind
	if akMind == None
		return ""
	endif
	string msg = akTarget.getDisplayName()+DOM01.GetMoodMessage(akTarget)+"\n"
	string end_line = "%\n"
	msg += "Runaway "+((ChanceRunaway(akMind)*100.0) as int)+end_line ; anger training
	msg += "Angry "+((akMind.ChanceAngry()*100.0) as int)+" / Recover "+ChanceRecoverAngry(akMind)+end_line ; anger training
	msg += "Afraid "+((akMind.ChanceAfraid()*100.0) as int)+" / Recover "+ChanceRecoverAfraid(akMind)+end_line ; fear_training
	msg += "Respectful "+((akMind.ChanceRespectful()*100.0) as int)+end_line ; respect_training
	msg += "Fight "+((akMind.ChanceFightForPlayer()*100.0) as int)+end_line ; combat_training
	return msg
EndFunction

; ------------------- PAH Mind - Functions without PAH != None check

Float Function ChanceRecoverAngry(PAHSlaveMind akMind)
	return (1.0 - (akMind.anger_rating / 200.0))
EndFunction

Float Function ChanceRecoverAfraid(PAHSlaveMind akMind)
	Float chance = (akMind.fear_rating + 10.0) / 100.0
	chance = chance * akMind.RecentlyPunishedChanceMultiplier(inverted = true)
	return chance
EndFunction

Float Function ChanceRunaway(PAHSlaveMind akMind)
	Float base_chance_run_away = 0.5
	Float chance = base_chance_run_away * 0.5
	chance = (chance * akMind.SubmissionChanceMultiplier(0, PAH.Config.runAwayValue, inverted = true))
	chance = (chance * akMind.RecentlyPunishedChanceMultiplier(inverted = true))
	return chance
EndFunction

Function InfoTrainingAdjust(Actor aktarget, Faction contrl_faction, int hexaco_trait, float base_amount, int rel)
	if akTarget == PlayerRef
		return
	endif
	PAHSlave sl_alias = PAH.GetSlave(akTarget)
	if sl_alias == None
		DOM01.DOMInfoNPCTrainingAdjust(aktarget,contrl_faction,hexaco_trait,base_amount,rel)
		return
	endif
	int contrl_level
	if akTarget.IsInFaction(contrl_faction)
		contrl_level = akTarget.getFactionRank(contrl_faction)+1
		if contrl_level < 1
			contrl_level = 1
		elseif contrl_level > 125
			contrl_level = 125
		endif
	else
		contrl_level = 1
	endif
	float amount = base_amount/contrl_level
	if contrl_level < 5
		if amount < 1.0
			amount = 1.0
		endif
	endif
	LogTrace("PAHInfoTrainingAdjust 1 idx="+hexaco_trait+" amount="+amount)
	float training_level_before
	float training_level_after
	if hexaco_trait == -(1)
		hexaco_trait = RandomInt(0,5)
	elseif hexaco_trait < 0
		hexaco_trait = RandomInt(6,11)
	endif
	if hexaco_trait == 0
		training_level_before = sl_alias.submission
		TrainSubmission(sl_alias,amount)
		training_level_after = sl_alias.submission
	elseif hexaco_trait == 1
		training_level_before = sl_alias.fear_training
		TrainFear(sl_alias,amount)
		training_level_after = sl_alias.fear_training
	elseif hexaco_trait == 2
		training_level_before = sl_alias.humiliation
		TrainHumiliation(sl_alias,amount)
		training_level_after = sl_alias.humiliation
	elseif hexaco_trait == 3
		training_level_before = sl_alias.anger_training
		TrainAnger(sl_alias,amount)
		training_level_after = sl_alias.anger_training
	elseif hexaco_trait == 4
		training_level_before = sl_alias.resignation
		TrainResignation(sl_alias,amount)
		training_level_after = sl_alias.resignation
	elseif hexaco_trait == 5
		training_level_before = sl_alias.respect_training
		TrainRespect(sl_alias,amount)
		training_level_after = sl_alias.respect_training
	elseif hexaco_trait == 0
		training_level_before = sl_alias.vaginal_training
		TrainVaginal(sl_alias,amount)
		training_level_after = sl_alias.vaginal_training
	elseif hexaco_trait == 1
		training_level_before = sl_alias.anal_training
		TrainAnal(sl_alias,amount)
		training_level_after = sl_alias.anal_training
	elseif hexaco_trait == 2
		training_level_before = sl_alias.oral_training
		TrainOral(sl_alias,amount)
		training_level_after = sl_alias.oral_training
	elseif hexaco_trait == 3
		training_level_before = sl_alias.pose_training
		TrainPose(sl_alias,amount)
		training_level_after = sl_alias.pose_training
	elseif hexaco_trait == 4
		training_level_before = sl_alias.GetActorRef().GetFactionRank(DOMTrainHouse)
		TrainHouse(sl_alias,amount)
		training_level_after = sl_alias.GetActorRef().GetFactionRank(DOMTrainHouse)
	elseif hexaco_trait == 5
		training_level_before = sl_alias.combat_training
		TrainCombat(sl_alias,amount)
		training_level_after = sl_alias.combat_training
	else
		return
	endif
	int ranknb = akTarget.GetFactionRank(DOMNbChatFeelings)
	if ranknb <= 0
		ranknb = 1
	else
		ranknb += 1
	endif
	akTarget.setFactionRank(DOMNbChatFeelings,ranknb)
	LogTrace("PAHInfoTrainingAdjust 2 idx="+hexaco_trait+" stat="+training_level_before+" amount="+amount)
	akTarget.setFactionRank(contrl_faction,contrl_level)
	LogTrace("PAHInfoTrainingAdjust 3 idx="+hexaco_trait+" stat="+training_level_after+" ctrl="+contrl_level)
EndFunction

Function TrainSubmission(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float submission = sl_alias.submission
	if submission < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(submission/100.0)))
		submission += (multiplier*GetModifierFromFaction(akTarget,DOMModHumility)/100.0*base_amount)
		sl_alias.submission = submission
	else
		float love_desire = akTarget.GetFactionRank(DOMLoveDesire) as float
		Float multiplier = 10.0/(love_desire*9.0+100.0)
		float mod = (multiplier*GetModifierFromFaction(akTarget,DOMModModesty)/100.0*base_amount)*DOM01.train_speed_love*DOMPlayerAlias.GetDeceiverModifier()
		if mod < 1.0
			love_desire += 1.0
		else
			love_desire += mod
		endif
		akTarget.SetFactionRank(DOMLoveFascination,love_desire as int)
	endif
EndFunction

Function TrainFear(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float fear_training = sl_alias.fear_training
	if fear_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(fear_training/100.0)))
		fear_training += (multiplier*GetModifierFromFaction(akTarget,DOMModFearfulness)/100.0*base_amount)
		sl_alias.fear_training = fear_training
	else
		float loyal_worship = akTarget.GetFactionRank(DOMLoyalWorship) as float
		Float multiplier = 10.0/(loyal_worship*9.0+100.0)
		float mod = (multiplier*GetModifierFromFaction(akTarget,DOMModDependence)/100.0*base_amount)*DOM01.train_speed_love*DOMPlayerAlias.GetDeceiverModifier()
		if mod < 1.0
			loyal_worship += 1.0
		else
			loyal_worship += mod
		endif
		akTarget.SetFactionRank(DOMLoveFascination,loyal_worship as int)
	endif
EndFunction

Function TrainHumiliation(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float humiliation = sl_alias.humiliation
	if humiliation < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(humiliation/100.0)))
		humiliation += (multiplier*GetModifierFromFaction(akTarget,DOMModNaivety)/100.0*base_amount)
		sl_alias.humiliation = humiliation
	else
		float love_fascination = akTarget.GetFactionRank(DOMLoveFascination) as float
		Float multiplier = 10.0/(love_fascination*9.0+100.0)
		float mod = (multiplier*GetModifierFromFaction(akTarget,DOMModIngenuity)/100.0*base_amount)*DOM01.train_speed_love*DOMPlayerAlias.GetDeceiverModifier()
		if mod < 1.0
			love_fascination += 1.0
		else
			love_fascination += mod
		endif
		akTarget.SetFactionRank(DOMLoveFascination,love_fascination as int)
	endif
EndFunction

Function TrainAnger(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float anger_training = sl_alias.anger_training
	if anger_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(anger_training/100.0)))
		anger_training += (multiplier*GetModifierFromFaction(akTarget,DOMModForgiveness)/100.0*base_amount)
		sl_alias.anger_training = anger_training
	else
		float loyal_absolution = akTarget.GetFactionRank(DOMLoyalAbsolution) as float
		Float multiplier = 10.0/(loyal_absolution*9.0+100.0)
		float mod = (multiplier*GetModifierFromFaction(akTarget,DOMModGentleness)/100.0*base_amount)*DOM01.train_speed_love*DOMPlayerAlias.GetDeceiverModifier()
		if mod < 1.0
			loyal_absolution += 1.0
		else
			loyal_absolution += mod
		endif
		akTarget.SetFactionRank(DOMLoveFascination,loyal_absolution as int)
	endif
EndFunction

Function TrainResignation(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float resignation = sl_alias.resignation
	if resignation < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(resignation/100.0)))
		resignation += (multiplier*GetModifierFromFaction(akTarget,DOMModPrudent)/100.0*base_amount)
		sl_alias.resignation = resignation
	else
		float loyal_devotion = akTarget.GetFactionRank(DOMLoyalDevotion) as float
		Float multiplier = 10.0/(loyal_devotion*9.0+100.0)
		float mod = (multiplier*GetModifierFromFaction(akTarget,DOMModConsideration)/100.0*base_amount)*DOM01.train_speed_love*DOMPlayerAlias.GetDeceiverModifier()
		if mod < 1.0
			loyal_devotion += 1.0
		else
			loyal_devotion += mod
		endif
		akTarget.SetFactionRank(DOMLoveFascination,loyal_devotion as int)
	endif
EndFunction

Function TrainRespect(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float respect_training = sl_alias.respect_training
	if respect_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(respect_training/100.0)))
		respect_training += (multiplier*GetModifierFromFaction(akTarget,DOMModDiscipline)/100.0*base_amount)
		sl_alias.respect_training = respect_training
	else
		float love_admiration = akTarget.GetFactionRank(DOMLoveAdmiration) as float
		Float multiplier = 10.0/(love_admiration*9.0+100.0)
		float mod = (multiplier*GetModifierFromFaction(akTarget,DOMModCreativity)/100.0*base_amount)*DOM01.train_speed_love*DOMPlayerAlias.GetDeceiverModifier()
		if mod < 1.0
			love_admiration += 1.0
		else
			love_admiration += mod
		endif
		akTarget.SetFactionRank(DOMLoveFascination,love_admiration as int)
	endif
EndFunction

Function TrainVaginal(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float vaginal_training = sl_alias.vaginal_training
	if vaginal_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(vaginal_training/100.0)))
		vaginal_training += (multiplier*GetModifierFromFaction(akTarget,DOMModVaginal)/100.0*base_amount)
		sl_alias.vaginal_training = vaginal_training
	endif
EndFunction

Function TrainAnal(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float anal_training = sl_alias.anal_training
	if anal_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(anal_training/100.0)))
		anal_training += (multiplier*GetModifierFromFaction(akTarget,DOMModAnal)/100.0*base_amount)
		sl_alias.anal_training = anal_training
	endif
EndFunction

Function TrainOral(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float oral_training = sl_alias.oral_training
	if oral_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(oral_training/100.0)))
		oral_training += (multiplier*GetModifierFromFaction(akTarget,DOMModOral)/100.0*base_amount)
		sl_alias.oral_training = oral_training
	endif
EndFunction

Function TrainPose(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float pose_training = sl_alias.pose_training
	if pose_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(pose_training/100.0)))
		pose_training += (multiplier*GetModifierFromFaction(akTarget,DOMModFlexibility)/100.0*base_amount)
		sl_alias.pose_training = pose_training
	endif
EndFunction

Function TrainHouse(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	int house_training
	if akTarget.IsInFaction(DOMTrainHouse)
		house_training = akTarget.GetFactionRank(DOMTrainHouse)
	else 
		house_training = 0
	endif
	if house_training < 100
		Float multiplier = 0.1 + (0.9*(1.0-((house_training as float)/100.0)))
		Float amount = (multiplier*GetModifierFromFaction(akTarget,DOMModPerfectionism)/100.0*base_amount)+0.5
		if amount < 1.0
			amount = 1.0
		endif
		house_training += (amount as int)
		akTarget.SetFactionRank(DOMTrainHouse, house_training)
	endif
EndFunction

Function TrainCombat(PAHSlave sl_alias, float base_amount)
	Actor akTarget = sl_alias.GetActorRef()
	float combat_training = sl_alias.combat_training
	if combat_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(combat_training/100.0)))
		combat_training += (multiplier*GetModifierFromFaction(akTarget,DOMModCombat)/100.0*base_amount)
		sl_alias.combat_training = combat_training
	endif
EndFunction

; ------------------- PAH Keys and wheel menu - Functions without PAH != None check

Int Function ShowOrderMenu(Actor akTarget)		
	if !DOMKeys.wheelIsDefaultMenu
		return DOMPAHOrderMessage.Show()
	endif
	PAHSlave sl_alias = None
	if akTarget != None
		sl_alias = PAH.GetSlave(akTarget)
	endif
	if DOMKeys.debugKeyMode
		HudNotification("Order menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Inventory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Inventory ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	if sl_alias != None && sl_alias.behaviour != "follow_player"
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Follow me ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Follow me ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Following ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = " ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = false)
	endif
	
	if sl_alias != None && sl_alias.behaviour != "wait"
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Stand still ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Stand still ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Standing ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
	endif
	
	if sl_alias != None && sl_alias.behaviour != "wait_sandbox"
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Wait here ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Wait here ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Waiting ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	endif
		
	;LogTrace(akTarget.GetDisplayName()+" PAHBoot.PAHBETied="+akTarget.IsInFaction(PAHBoot.PAHBETied)+" "+PAHBoot.PAHBETied)
	if akTarget.IsInFaction(PAHBoot.PAHBETied)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Untie ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Untie ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Put in bag ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Put in bag ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	endif

	if !akTarget.IsInFaction(PAHBoot.PAHBETied)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Tie up ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Tie up ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Tied ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Tied ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Pose ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Pose ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Order to ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Order to ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowAbuseMenu(Actor akTarget)
	if !DOMKeys.wheelIsDefaultMenu
		return DOMPAHAbuseMessage.Show()
	endif
	PAHSlave sl_alias = None
	if akTarget != None
		sl_alias = PAH.GetSlave(akTarget)
	endif
	if DOMKeys.debugKeyMode
		HudNotification("Abuse menu for "+akTarget.getDisplayName())
	endif
			
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	string reason = sl_alias.GetReasonForPunishment()
	if reason == ""
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "No reason ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Scold ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "No reason ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Punish ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = false)
	else
		if sl_alias.punishment_active
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Being punished ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Punish ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Punish ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
		endif
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Scold ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Scold ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	endif

	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)
	
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowStatusMenu(Actor akTarget)
	if !DOMKeys.wheelIsDefaultMenu
		return DOMPAHStatusMessage.Show()
	endif
	string txt_respectful = "Be respectful "
	string txt_fight_for_me = "Fight for me "
	string txt_be_a_maid = "Be my maid "
	PAHSlave sl_alias = None
	if akTarget != None
		sl_alias = PAH.GetSlave(akTarget)
		if sl_alias != None
			if sl_alias.should_be_respectful
				txt_respectful = "No need to be respectful "
			endif
			if sl_alias.should_fight_for_player
				txt_fight_for_me = "Don't fight "
			endif
		endif
		if akTarget.GetLeveledActorBase().GetSex() == 0
			txt_be_a_maid = "Be my servant "
		endif
	endif
	if DOMKeys.debugKeyMode
		HudNotification("Status menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Personality ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Feelings ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Mood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = txt_respectful)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = txt_fight_for_me)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Personality ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Feelings ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Mood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = txt_respectful)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = txt_fight_for_me)
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)
	
	if sl_alias != None && sl_alias.behaviour != "cleanHouse"
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = txt_be_a_maid)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = txt_be_a_maid)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Serving ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
	endif


	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowTrainingMenu(Actor akTarget)
	if !DOMKeys.wheelIsDefaultMenu
		return DOMPAHTrainingMessage.Show()
	endif
	if DOMKeys.debugKeyMode
		HudNotification("Abuse menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	if akTarget.IsInFaction(PAHBoot.PAHNaked)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Naked ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Naked ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Strip ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Strip ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	endif
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Rape ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Sex ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Equip inventory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Rape ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Sex ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Equip inventory ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowPoseMenu()
	if !DOMKeys.wheelIsDefaultMenu
		return DOMPAHPoseMessage.Show()
	endif
	if DOMKeys.debugKeyMode
		HudNotification("Pose menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Stand ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Dance ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Grace ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Show-off ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Wild ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Get down ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Relax ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Statue ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Stand ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Dance ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Grace ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Show-off ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Wild ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Get down ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Relax ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Statue ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DoRapeMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	int imenu = DOMKeys.ShowDOMSexMenu(akTarget,true)
	if imenu == 0
		PAHPRS.fuck(akTarget, Game.getPlayer(), "Vaginal", true, "", true)
	elseif imenu == 1
		PAHPRS.fuck(akTarget, Game.getPlayer(), "Oral", true, "", true)
	elseif imenu == 2
		PAHPRS.fuck(akTarget, Game.getPlayer(), "Anal", true, "", true)
	endif
EndFunction

Function DoSexMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	int imenu = DOMKeys.ShowDOMSexMenu(akTarget,false)
	if imenu == 0
		PAHPRS.fuck(akTarget, Game.getPlayer(), "Vaginal", false, "", false)
	elseif imenu == 1
		PAHPRS.fuck(akTarget, Game.getPlayer(), "Oral", false, "", false)
	elseif imenu == 2
		PAHPRS.fuck(akTarget, Game.getPlayer(), "Anal", false, "", false)
	endif
EndFunction

Function DoEquipInventory(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if DOMKeys.debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to clean the mess")
		endif
		if sl_alias != None
			sl_alias.EquipInventory()
		endif
	endif
EndFunction

Function DoStrip(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if DOMKeys.debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to clean the mess")
		endif
		if sl_alias != None
			sl_alias.Strip()
		endif
	endif
EndFunction

Function DoBeRespectful(Actor akTarget)
	if akTarget == None
		return
	endif
	PAHSlave sl_alias = PAH.GetSlave(akTarget)
	if sl_alias == None
		return
	endif
	if !sl_alias.should_be_respectful
		sl_alias.should_be_respectful = true
		sl_alias.respectful = true
		if DOMKeys.debugKeyMode
			HudNotification("Be respectful "+sl_alias.getName())
		endif
	else
		sl_alias.should_be_respectful = false
		sl_alias.respectful = false
		if DOMKeys.debugKeyMode
			HudNotification("Don't be respectful "+sl_alias.getName())
		endif
	endif
EndFunction

Function DoCleanTheMess(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if DOMKeys.debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to clean the mess")
		endif
		if sl_alias != None
			if akTarget.IsInFaction(PAHBoot.PAHBETied)
				sl_alias.TieUp(None, Aggressor = Game.GetPlayer(), DoAnimation = true, Enter = false)	
			endif
			sl_alias.cleanHouse()
		endif
	endif
EndFunction

Function DoFightForMe(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if sl_alias != None
			if !sl_alias.should_fight_for_player
				sl_alias.should_fight_for_player = true
				sl_alias.fights_for_player = true
				If (sl_alias.behaviour == "follow_player")
					akTarget.SetPlayerTeammate()
				endif
				if DOMKeys.debugKeyMode
					HudNotification("Order "+sl_alias.getName()+" to fight for player")
				endif
			else
				sl_alias.should_fight_for_player = false
				sl_alias.fights_for_player = false
				if (akTarget.IsPlayerTeammate())
					akTarget.SetPlayerTeammate(false)
				endif
				if DOMKeys.debugKeyMode
					HudNotification("Order "+sl_alias.getName()+" to not fight for player")
				endif
			endif
		endif
	endif
EndFunction

Function DoPunish(Actor akTarget)
	if akTarget != None
		if isPAH(aktarget)
			if DOMKeys.debugKeyMode
				HudNotification("Start punishment for "+akTarget.getDisplayName())
			endif
			PAHSlave sl_alias = PAH.GetSlave(akTarget)
			if sl_alias != None
				string reason = sl_alias.GetReasonForPunishment()
				if reason != ""
					HudNotification("Punishing "+sl_alias.GetName()+" for "+reason)
					sl_alias.StartPunishment("pain") ; PAH punishment Function
				endif
			endif
		endif
	endif
EndFunction

Function DoScold(Actor akTarget)
	if akTarget != None
		if isPAH(aktarget)
			if DOMKeys.debugKeyMode
				HudNotification("Start tell-off for "+akTarget.getDisplayName())
			endif
			PAHSlave sl_alias = PAH.GetSlave(akTarget)
			if sl_alias != None
				string reason = sl_alias.GetReasonForPunishment()
				if reason != ""
					HudNotification("Scolding "+sl_alias.GetName()+" for "+reason)
					sl_alias.TellOff(reason)
				endif
			endif
		endif
	endif
EndFunction

Function DoOpenInventory(Actor akTarget)
	if akTarget != None
		if isPAH(aktarget)
			if DOMKeys.debugKeyMode
				HudNotification("Open inventory for "+akTarget.getDisplayName())
			endif
			PAHSlave sl_alias = PAH.GetSlave(akTarget)
			if sl_alias == None
				aktarget.OpenInventory(true)
			else
				sl_alias.OpenInventory()
			endif
		elseif akTarget.IsInFaction(PlayerFollowerFaction); || akTarget.IsInFaction(DOM01.PotentialFollowerFaction)
			akTarget.OpenInventory(true)
		elseif akTarget.GetRelationshipRank(PlayerRef) >= 4
			akTarget.OpenInventory(true)
		elseif akTarget.IsUnconscious()
			akTarget.OpenInventory(true)
		elseif DOM01.isAPlayerSlave(akTarget)
			akTarget.OpenInventory(true)
		endif
	endif
EndFunction

Function DoFollowMe(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if DOMKeys.debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to follow")
		endif
		if sl_alias != None
			if akTarget.IsInFaction(PAHBoot.PAHBETied)
				sl_alias.TieUp(None, Aggressor = Game.GetPlayer(), DoAnimation = true, Enter = false)	
			endif
			Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
			sl_alias.FollowPlayer()
		endif
	endif
EndFunction

Function DoStandStill(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if DOMKeys.debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to stand still")
		endif
		if sl_alias != None
			if akTarget.IsInFaction(PAHBoot.PAHBETied)
				sl_alias.TieUp(None, Aggressor = Game.GetPlayer(), DoAnimation = true, Enter = false)	
			endif
			Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
			sl_alias.Wait()
		endif
	endif
EndFunction

Function DoWaitHere(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if DOMKeys.debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to wait here")
		endif
		if sl_alias != None
			if akTarget.IsInFaction(PAHBoot.PAHBETied)
				sl_alias.TieUp(None, Aggressor = Game.GetPlayer(), DoAnimation = true, Enter = false)	
			endif
			Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
			sl_alias.WaitSandbox()
		endif
	endif
EndFunction

Function DoUntie(Actor akTarget)
	if akTarget == None
		return
	endif
	PAHSlave sl_alias = PAH.GetSlave(akTarget)
	if DOMKeys.debugKeyMode
		HudNotification("Order "+akTarget.GetDisplayName()+" to wait here")
	endif
	if sl_alias != None && akTarget.IsInFaction(PAHBoot.PAHBETied)
		sl_alias.TieUp(None, Aggressor = Game.GetPlayer(), DoAnimation = true, Enter = false)
		Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
	endif
EndFunction

Function DoTieUp(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if DOMKeys.debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to wait here")
		endif
		if sl_alias != None && !akTarget.IsInFaction(PAHBoot.PAHBETied)
			Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
			sl_alias.TieUp(DOM01.DOMZaz.GetCuffsRope(), Aggressor = Game.GetPlayer(), DoAnimation = true, Enter = true)
		endif
	endif
EndFunction

Function DoFavor(Actor akTarget)
	if akTarget != None
		PAHSlave sl_alias = PAH.GetSlave(akTarget)
		if DOMKeys.debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to wait here")
		endif
		if sl_alias != None && !akTarget.IsInFaction(PAHBoot.PAHBETied)
			sl_alias.Wait()
			Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
			akTarget.SetDoingFavor()
		endif
	endif
EndFunction

Function DoOrderMenu(Actor akTarget)
	int imenu = ShowOrderMenu(akTarget)
	if imenu == 0
		DoOpenInventory(akTarget)
	elseif imenu == 1
		DoFollowMe(akTarget)
	elseif imenu == 2
		DoStandStill(akTarget) ; not sandbox
	elseif imenu == 3
		DoWaitHere(akTarget) ; sandbox
	elseif imenu == 4
		if akTarget.IsInFaction(PAHBoot.PAHBETied)
			DoUntie(akTarget)
		else
			DOMKeys.DOMDoPutInBag(akTarget)
		endif
	elseif imenu == 5
		DoTieUp(akTarget)
	elseif imenu == 6
		DoPoseMenu(akTarget)
	elseif imenu == 7
		DoFavor(akTarget)
	endif
EndFunction

Function DoStatusMenu(Actor akTarget)
	int imenu = ShowStatusMenu(akTarget)
	; Info menu
	if imenu == 0
		DOM01.DOMWheelTraits(akTarget)
	elseif imenu == 1
		DOM01.DOMWheelFeelings(akTarget)
	elseif imenu == 2
		DOMKeys.DOMDOMood(akTarget)
	elseif imenu == 3
		DOMKeys.DOMDoStatus(akTarget)
	elseif imenu == 4
		DoBeRespectful(akTarget)
	elseif imenu == 5
		DoFightForMe(akTarget)
	elseif imenu == 6
		DoCleanTheMess(akTarget)
	endif
EndFunction

Function DoTrainingMenu(Actor akTarget)
	int imenu = ShowTrainingMenu(akTarget)
	if imenu == 0
		DoStrip(akTarget)
	elseif imenu == 1
		DoRapeMenu(akTarget)
	elseif imenu == 2
		DoSexMenu(akTarget)
	elseif imenu == 5 || imenu == 3
		DoEquipInventory(akTarget)
	endif
EndFunction

Function DoAbuseMenu(Actor akTarget)
	int imenu = ShowAbuseMenu(akTarget)
	; Punish & praise menu
	if imenu == 0
		DoPunish(akTarget)
	elseif imenu == 1
		DoScold(akTarget)
	endif
EndFunction

Function DoPoseMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	PAHSlave sl_alias = PAH.GetSlave(akTarget)
	if sl_alias == None
		return
	endif
	int imenu = ShowPoseMenu()
	string poseanim = ""
	if imenu == 0
		poseanim = DOM01.DOM_Anim.GetTieupKneelingNPC(akTarget)
	elseif imenu == 1
		poseanim = "FNISSPc20" ; dance for me
	elseif imenu == 2
		poseanim = "FNISSPc24" ; dance with grace
	elseif imenu == 3
		poseanim = "FNISSPc22" ; dance show off your body
	elseif imenu == 4
		poseanim = "FNISSPc17" ; wild dance
	elseif imenu == 5
		poseanim = "FNISSPc6" ; get down
	elseif imenu == 6
		poseanim = "FNISSPc29" ; relax
	elseif imenu == 7
		poseanim = "FNISSPc30" ; statue  ; "FNISSPc31" ; swan pose ; "FNISSPo8" flowers
	endif
	if poseanim != ""
		if akTarget.IsInFaction(PAHBoot.PAHBETied)
			sl_alias.TieUp(None, Aggressor = Game.GetPlayer(), DoAnimation = true, Enter = false)	
		endif
		sl_alias.should_pose = true  ; Needed to punish slave if not posing
		sl_alias.setPose(1)          ; Needed to start pose behaviour
		Debug.SendAnimationEvent(akTarget, poseanim) ; start pose
	endif
EndFunction

Function DoPutInBagActor(DOM_BurlapSack objSack, Actor akTarget)
	PAHSlave sl_alias = PAH.GetSlave(akTarget)
	if sl_alias.behaviour == "restrained_in_furniture"
		objSack.SetBehaviour("tied")
	else
		objSack.SetBehaviour(sl_alias.behaviour)
	endif
	akTarget.SetFactionRank(DOM01.DOMActionInContainer,1)
	sl_alias.behaviour = "do_nothing"
EndFunction

Function DoTakeOutOfBag(DOM_BurlapSack objSack, Actor akTarget, bool do_tieup)
	PAHSlave sl_alias = PAH.GetSlave(akTarget)
	akTarget.RemoveFromFaction(DOM01.DOMActionInContainer)
	if sl_alias == None
		if do_tieup
			DOMKeys.DOMTieupActor(akTarget,None) 
		else
			DOMKeys.DOMUntieActor(akTarget,None)
		endif
		return
	endif
	if do_tieup
		sl_alias.TieUp(DOM01.DOMZaz.GetCuffsRope(), Aggressor = None, DoAnimation = false, Enter = true)
		return
	endif
	string beh = objSack.GetBehaviour()
	if beh == "tied"
		sl_alias.TieUp(DOM01.DOMZaz.GetCuffsRope(), Aggressor = None, DoAnimation = false, Enter = true)
	elseif beh == ""
		sl_alias.Wait()
	else
		sl_alias.behaviour = beh
	endif
EndFunction

Function SetBehaviour(Actor akTarget, string beh)
	PAHSlave sl_alias = PAH.GetSlave(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.behaviour = beh
EndFunction

Function AllStandstill()
	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to stand still to one PAH slave")
		else
			HudNotification("Order to stand still to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None && !akTarget.IsInFaction(PAHBoot.PAHBERunningAway) && !akTarget.IsInFaction(PAHBoot.PAHBEFleeingAndCowering)
				if DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					if akTarget.IsInFaction(PAHBoot.PAHBETied)
						sl_alias.TieUp(None, Aggressor = None, DoAnimation = false, Enter = false)	
					endif
					Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
					sl_alias.Wait()
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllWaitHere()
	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to wait here to one PAH slave")
		else
			HudNotification("Order to wait here to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None && !akTarget.IsInFaction(PAHBoot.PAHBERunningAway) && !akTarget.IsInFaction(PAHBoot.PAHBEFleeingAndCowering)
				if DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					if akTarget.IsInFaction(PAHBoot.PAHBETied)
						sl_alias.TieUp(None, Aggressor = None, DoAnimation = false, Enter = false)	
					endif
					Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
					sl_alias.WaitSandbox()
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllFollow()
	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to follow to one PAH slave")
		else
			HudNotification("Order to follow to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None && !akTarget.IsInFaction(PAHBoot.PAHBERunningAway) && !akTarget.IsInFaction(PAHBoot.PAHBEFleeingAndCowering)
				if DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					if akTarget.IsInFaction(PAHBoot.PAHBETied)
						sl_alias.TieUp(None, Aggressor = None, DoAnimation = false, Enter = false)	
					endif
					Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
					sl_alias.FollowPlayer()
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllFollowIfPosing()
	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to follow if posing to one PAH slave")
		else
			HudNotification("Order to follow if posing to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None && !akTarget.IsInFaction(PAHBoot.PAHBERunningAway) && !akTarget.IsInFaction(PAHBoot.PAHBEFleeingAndCowering)
				if sl_alias.behaviour == "pose" && DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					if akTarget.IsInFaction(PAHBoot.PAHBETied)
						sl_alias.TieUp(None, Aggressor = None, DoAnimation = false, Enter = false)	
					endif
					Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState") ; end pose
					sl_alias.FollowPlayer()
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllBeRespectful()
	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to be respectful to one PAH slave")
		else
			HudNotification("Order to be respectful to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None
				if !sl_alias.should_be_respectful && DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					sl_alias.should_be_respectful = true
					sl_alias.respectful = true
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllFightForMe()
	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to fight to one PAH slave")
		else
			HudNotification("Order to fight to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None
				if !sl_alias.should_fight_for_player && DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					sl_alias.should_fight_for_player = true
					sl_alias.fights_for_player = true
					If (sl_alias.behaviour == "follow_player")
						akTarget.SetPlayerTeammate()
					endif
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllDontFightForMe()
	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to not fight to one PAH slave")
		else
			HudNotification("Order to not fight to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None
				if sl_alias.should_fight_for_player && DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					sl_alias.should_fight_for_player = false
					sl_alias.fights_for_player = false
					if (akTarget.IsPlayerTeammate())
						akTarget.SetPlayerTeammate(false)
					endif
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllPose(int imenu)
	string poseanim = ""
	if imenu == 0
		poseanim = "FNISSPc6" ; get down  (was chair) 
	elseif imenu == 1
		poseanim = "FNISSPc30" ; statue  (was light)
	elseif imenu == 2
		poseanim = "FNISSPo8" ; flowers (was flowers)
	elseif imenu == 3
		poseanim = "FNISSPc29" ; relax (was drinks) 
	elseif imenu == 4
		poseanim = "FNISSPc22" ; dance show off your body (was cute)
	elseif imenu == 5
		poseanim = "FNISSPc24" ; dance with grace (was dance)
	elseif imenu == 6
		poseanim = "FNISSPc20" ; dance for me (was music)
	elseif imenu == 7
		poseanim = DOM01.DOM_Anim.GetTieupKneelingNPC(None) ; Stand here (was cute)
	endif
	if poseanim == ""
		return
	endif

	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to pose to one PAH slave")
		else
			HudNotification("Order to pose to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None && !akTarget.IsInFaction(PAHBoot.PAHBERunningAway) && !akTarget.IsInFaction(PAHBoot.PAHBEFleeingAndCowering)
				if DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					if akTarget.IsInFaction(PAHBoot.PAHBETied)
						sl_alias.TieUp(None, Aggressor = None, DoAnimation = false, Enter = false)	
					endif
					sl_alias.should_pose = true  ; Needed to punish slave if not posing
					sl_alias.setPose(1)          ; Needed to start pose behaviour
					Debug.SendAnimationEvent(akTarget, poseanim) ; start pose
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllKneel()
	string poseanim

	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to kneel to one PAH slave")
		else
			HudNotification("Order to kneel to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None && !akTarget.IsInFaction(PAHBoot.PAHBERunningAway) && !akTarget.IsInFaction(PAHBoot.PAHBEFleeingAndCowering) && sl_alias.behaviour != "restrained_in_furniture"
				if DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					if akTarget.IsInFaction(PAHBoot.PAHBETied)
						poseanim = DOM01.DOM_Anim.GetTieupSaluteNPC(akTarget)
					else
						poseanim = DOM01.kneelPose
					endif
					sl_alias.should_pose = true  ; Needed to punish slave if not posing
					sl_alias.setPose(1)          ; Needed to start pose behaviour
					Debug.SendAnimationEvent(akTarget, poseanim) ; start pose
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function AllAttention()
	string poseanim = DOM01.attentionPose

	int n = PAH.GetSlaveCount()
	if DOMKeys.debugKeyMode
		if n==1
			HudNotification("Order to stand on attention to one PAH slave")
		else
			HudNotification("Order to stand on attention to "+n+" PAH slaves")
		endif
	endif
	int i = 0
	while i < n
		PAHSlave sl_alias = PAH.slaveArray[i]
		if sl_alias != None
			Actor akTarget = sl_alias.GetActorRef()
			if akTarget != None && !akTarget.IsInFaction(PAHBoot.PAHBERunningAway) && !akTarget.IsInFaction(PAHBoot.PAHBEFleeingAndCowering) && !akTarget.IsInFaction(PAHBoot.PAHBETied)
				if DOM01.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
					sl_alias.should_pose = true  ; Needed to punish slave if not posing
					sl_alias.setPose(1)          ; Needed to start pose behaviour
					Debug.SendAnimationEvent(akTarget, poseanim) ; start pose
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

bool Function IsWeaponPunishment(Form akSource)
	if PAHBoot == None
		return false
	endif
	if akSource.HasKeyword(PAHBoot.PAHPainGiver)
		;LogTrace("IsWeaponPunishment PAHPainGiver "+akSource.GetName()) 
		return true
	endif
	return false
EndFunction

; Utils

Function HudNotification(string msg)
	Debug.Notification(msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_PAH: "+msg)
	endif
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_PAH: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_PAH: "+msg)
	endif
EndFunction
