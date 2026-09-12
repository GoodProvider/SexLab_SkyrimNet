Scriptname AYGASInterface extends Quest

aygasCoreScript Property AYGAS  Auto
aygasStorageScript Property AYGASStorage  Auto
PAHCore Property PAH = None Auto Hidden
PAHBootstrapScript Property PAHBoot Auto Hidden
DOM_PlayerAlias Property DOMPlayerAlias Auto 
DOM_Core Property DOM = None Auto Hidden
Faction Property PAHDoNotEnslaveFaction = None Auto Hidden
Faction Property StupidVampireThrallFaction Auto
Faction Property DOMActorFaction Auto 
Faction Property DOMActorExcludedFaction Auto 
Faction Property DOMActorInTransfer Auto 
Faction Property DOMHistoryFaction Auto 
Faction Property DOMPlayerSlaveFaction Auto 
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

Event OnInit()
	GetSoftRequirements()
EndEvent

Function Initialize()
	LogInfo("==========================================================================")
	LogInfo("==                         DOM: AYGAS Interface                         ==")
	LogInfo("==========================================================================")

	GetSoftRequirements()
	if DOM != None
		LogInfo("Initialize DOM for AYGAS success!")
		AYGAS.CheckActorAliases()
	else
		LogInfo("WARNING: Could not initialize DOM for AYGAS")
	endif
EndFunction

Function GetSoftRequirements()
	string pah_modname = "paradise_halls.esm"
	string dom_modname = "DiaryOfMine.esm"
	
	if (Game.GetModByName(pah_modname) != 255)
		PAH     = Game.GetFormFromFile(0x0001FAEF, pah_modname) As PAHCore 
		PAHBoot = Game.GetFormFromFile(0x0000CF32, pah_modname) As PAHBootstrapScript 
		PAHDoNotEnslaveFaction = Game.GetFormFromFile(0x0000F606, "paradise_halls.esm") As Faction
	else
		PAH     = None
		PAHBoot = None
		PAHDoNotEnslaveFaction = None
	endif
	if (Game.GetModByName(dom_modname) != 255)
		DOM     = Game.GetFormFromFile(0x00000D61, dom_modname) As DOM_Core 
	else
		DOM     = None
	endif
	if ((StupidVampireThrallFaction == None) && (Game.GetModByname("Dawnguard.esm") != 255))
		StupidVampireThrallFaction = Game.GetFormFromFile(0x000162f7, "Dawnguard.esm") As Faction
	endif
EndFunction

bool Function AddSlaveToDOM(Actor slave)
	ClearNoEnslave(slave)
	if DOM != None
		int rank = -1
		if slave.IsInFaction(DOMHistoryFaction)
			rank = slave.GetFactionRank(DOMHistoryFaction)
		endif
		if PAH == None || (rank >= 0 && rank < 10) ; Move back to DOM
			if rank >= 10
				slave.SetFactionRank(DOMHistoryFaction,rank-(10))
			endif
			DOM.MoveNPCToDOM(slave)
			return true
		elseif rank >= 10
			slave.SetFactionRank(DOMHistoryFaction,rank-(10))
		endif
	endif
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
		return true
	endif
	return false
EndFunction

Function RemoveSlaveFromDOM(Actor slave)
	if slave == None
		return
	endif
	if StupidVampireThrallFaction != None
		slave.RemoveFromFaction(StupidVampireThrallFaction)
	endif
	if DOM != None && slave.IsInFaction(DOMActorFaction)
		int rank = -1
		if slave.IsInFaction(DOMHistoryFaction)
			rank = slave.GetFactionRank(DOMHistoryFaction)
		endif
		if rank >= 10
			slave.SetFactionRank(DOMHistoryFaction,rank-(10))
		endif
		DOM_Actor akActor = DOM.GetActor(slave)
		if akActor != None
			slave.SetFactionRank(DOMActorInTransfer,1) ; transfer to DOM manager
			akActor.SetRestoreOutfitOnRelease(false)
			DOM.ReleaseAlias(akActor)
			SetNoEnslave(slave)
			return
		endif
	endif
	if PAH != None && slave.IsInFaction(PAH.PAHPlayerSlaveFaction)
		ReferenceAlias slaveAlias = PAH.GetSlave(slave)
		if slaveAlias != None
			PAH.RemoveSlave(slaveAlias)	
			SetNoEnslave(slave)
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

Function SetNoEnslave(Actor slave)
	if DOM != None
		slave.AddToFaction(DOMActorExcludedFaction)
	endif
	if PAHDoNotEnslaveFaction != None
		slave.AddToFaction(PAHDoNotEnslaveFaction)
	endif
EndFunction

Function ClearNoEnslave(Actor slave)
	if DOM != None
		slave.RemoveFromFaction(DOMActorExcludedFaction)
	endif
	if PAHDoNotEnslaveFaction != None
		slave.RemoveFromFaction(PAHDoNotEnslaveFaction)
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

Function Suspend(aygasSlaveScript akSlave, Actor previousOwner)
	Actor akRef = akSlave.GetActorRef()
	if akRef == None
		LogTrace("Suspend failed to get actor reference")
		return
	endif
	ReferenceAlias slot = akSlave as ReferenceAlias
	DOM_Actor slaveDOM = slot as DOM_Actor
	if slaveDOM == None
		LogTrace("Suspend failed to assign DOM actor and mind")
		return
	endif
	slaveDOM.DoClear()
EndFunction

Function Assign(aygasSlaveScript akSlave, Actor newOwner)
	Actor akRef = akSlave.GetActorRef()
	if akRef == None
		LogTrace("Assign failed to get actor reference")
		return
	endif
	ReferenceAlias slot = akSlave as ReferenceAlias
	DOM_Actor slaveDOM = slot as DOM_Actor
	if slaveDOM == None
		LogTrace("Assign failed to assign DOM actor and mind")
		return
	endif
	akRef.SetFactionRank(DOMActorInTransfer,50)
	akRef.SetFactionRank(Aygas.DOMSlaveManagerFaction,50) ; 50 means AYGAS
	slaveDOM.SetDisplayName(akRef.GetDisplayName())
	if slaveDOM.DOM01 != DOM && DOM != None
		LogTrace("Assign alias actor DOM pointer was not correctly set!")
		slaveDOM.DOM01 = DOM
	endif
	slaveDOM.AfterAssign(true,false,false) ; slave=yes, new=no, player's=no
	DOM_Mind slaveMind = slot as DOM_Mind
	if slaveMind.DOM01 != DOM && DOM != None
		LogTrace("Assign alias mind DOM pointer was not correctly set!")
		slaveMind.DOM01 = DOM
	endif
	slaveMind.AfterAssign(true,false,false) ; slave=yes, new=no, player's=no
	slaveMind.SetSlaveOwner(newOwner)
	if newOwner == None
		slaveDOM.EnterOnDuty("is up for sell", "Slave for sell")
	else
		string ownerName = newOwner.GetDisplayName()
		if ownerName == ""
			slaveDOM.EnterOnDuty("has been enslaved", "Slave with no owner")
		else
			slaveDOM.EnterOnDuty("is now the Property of "+ownerName, ownerName+"'sSlave")
		endif
	endif
	slaveDOM.OnUpdate()
	slaveDOM.OnUpdateGameTime()
EndFunction

bool Function IsAPlayerSlave(Actor slave)
	if slave == None
		return false
	endif
	if DOM != None && slave.IsInFaction(DOMPlayerSlaveFaction)
		return true
	endif
	if PAH != None && slave.IsInFaction(PAH.PAHPlayerSlaveFaction)
		return true
	endif
	return false
EndFunction

bool Function IsSexTrained(Actor client)
	if client == None
		return false
	endif
	if DOM != None && client.IsInFaction(DOMTrainSex)
		return true
	endif
	if PAH != None && client.IsInFaction(PAH.PAHTrainSex)
		return true
	endif
	return false
EndFunction

bool Function hasSubmission(Actor client)
	if client == None
		return false
	endif
	if DOM != None && client.IsInFaction(DOMTrainSubmission)
		return true
	endif
	if PAH != None && client.IsInFaction(PAH.PAHSubmission)
		return true
	endif
	return false
EndFunction

int Function GetFactionValue(Actor akTarget, Faction akFaction)
	if akTarget.IsInFaction(akFaction)
		return akTarget.GetFactionRank(akFaction)
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

int Function GetSubmissionTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainSubmission)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHSubmission)
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

int Function GetResignationTraining(Actor slave)
	if DOM != None
		return slave.GetFactionRank(DOMTrainResignation)
	endif
	if PAH != None
		return slave.GetFactionRank(PAH.PAHResignation)
	endif
	return 0
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

Actor Function AddSlaveToWorld(Actor slave)
	if DOM != None
		Actor newSlave = DOM.CloneOrNot(slave,true) ; force cloning
		return newSlave
	endif
	if PAH == None
		return None
	endif
	Actor newSlave = None
	int[] captiveData = PAH.NpcEval.GetActorData(slave)
	newSlave = PAH.Clone(slave)
	If newSlave != slave
		If (newSlave != None)
			slave.EndDeferredKill()
			slave.KillEssential()
			slave.Kill()
		Else  ; if (PAH.Config.LeveledActorBaseToggle)
			newSlave = PAH.CloneLeveledActorBase(slave)
			ActorBase slave_base = PAH.GetValidActorBase(slave)
			If (!slave_base.IsUnique())
				newSlave = PAH.CloneLeveledEncounterZone(slave)
			endif
		endif
	endif
	
	If (newSlave != None)
		newSlave.AllowPCDialogue(false)
		PAH.CleanActor(newSlave)
		newSlave.SetRelationshipRank(Game.GetPlayer(), 0)
		PAH.NpcEval.StoreNpcFactionInfo(newSlave, captiveData)

		If (slave != newSlave)
			newSlave.setAlpha(0.0)
			PAH.switchActors(slave, newSlave)
		endif

		newSlave.RemoveFromFaction(AYGASStorage.BanditFaction)
		newSlave.SetAV("aggression", 0)
		newSlave.StopCombat()
		newSlave.AllowPCDialogue(true)
		newSlave.setAlpha(1)
		newSlave.SetDontMove(False)
	endif
	return newSlave
EndFunction

int Function getSlavePrice(Actor slave)
	int price = Aygas.SellQuest.SlavePrice
	if price > 0
		return price
	endif
	if slave == None
		return 0
	endif
	if DOM == None
		return 0
	endif
	return (DOM.DOMGenerator.getActorPrice(slave)/2.0*DOMPlayerAlias.GetDeceiverModifier()) as int
EndFunction

float Function GetNPCWealth(Actor buyer)
	if buyer == None
		return -1
	endif
	if DOM == None
		return -1
	endif
	return DOM.DOMGenerator.GetNPCWealth(buyer)
EndFunction

int Function getSellerPrice(Actor slave, Actor owner)
	if slave == None
		return 0
	endif
	if DOM == None
		return Aygas.SellQuest.SlavePrice
	endif
	return ((DOM.DOMGenerator.getActorPrice(slave)+200.0)/DOMPlayerAlias.GetPersuaderModifier()) as int		
EndFunction

int Function getBuyerPrice(Actor slave, Actor buyer)
	if slave == None
		return 0
	endif
	if DOM != None
		return DOM.DOMGenerator.getActorPrice(slave)
	endif
	return Utility.RandomInt(1500, 3500)
EndFunction

int Function getAuctionPrice(Actor slave)
	if slave == None
		return 0
	endif
	if DOM != None
		return DOM.DOMGenerator.getActorPrice(slave)/2
	endif
	return Utility.RandomInt(700, 2500)
EndFunction

Function SendAnimationEvent(Actor akTarget, string animation)
	debug.sendanimationevent(akTarget, animation)
EndFunction

bool Function isVerboseMode()
	if DOM == None
		return false
	endif
	return DOM.verboseMode
EndFunction

Function LogInfo(string msg)
	Debug.Trace("AYGASInterface: "+msg)
EndFunction

Function LogTrace(String s)
	if isVerboseMode()
		Debug.Trace("AYGASInterface: " + s)
	endif
EndFunction

