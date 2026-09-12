Scriptname PHHSHStorageFunctions extends Quest  conditional

PHHSHInterface Property PHHSHInter Auto
DOM_Sexlab Property DOMSexlab Auto
DOM_ZAD Property DOMZAD Auto
DOM_ZAZ Property DOMZAZ Auto
DOM_Equip Property DOMEquip Auto
DOM_Core Property DOM01 Auto

; DOM Actor factions
Faction Property DOMActorFaction Auto 
Faction Property DOMActorInTransfer Auto 
Faction Property DOMActorExcludedFaction Auto 
Faction Property DOMHistoryFaction Auto 

; Training
Faction Property DOMTrainSubmission Auto
Faction Property DOMTrainResignation Auto
Faction Property DOMTrainCombat Auto

; Skyrim factions
Faction Property pTweakWaitingFaction auto Hidden
Faction Property StupidVampireThrallFaction Auto

Event OnInit()
	GetSoftRequirements()
EndEvent

string Function Version()
	return "2.00"
EndFunction

Function Initialize()
	LogInfo("============================================================================")
	LogInfo("==                           DOM: HSH Interface                           ==")
	LogInfo("============================================================================")

	GetSoftRequirements()
	if DOM01 != None
		LogInfo("Initialize DOM for HSH success!")
		CheckActorAliases()
		FlexiStorage.CheckActorAliases()
	else
		LogInfo("WARNING: Could not initialize DOM for HSH")
	endif
EndFunction

Function GetSoftRequirements()
	If (Game.GetModByName("AmazingFollowerTweaks.esp") != 255)
		pTweakWaitingFaction = Game.GetFormFromFile(0x00032CCB, "AmazingFollowerTweaks.esp") as Faction
	else
		pTweakWaitingFaction = None
	endif

	if (Game.GetModByname("OSA.esm") != 255)
		OSAFaction = Game.GetFormFromFile(0x0000182e, "OSA.esm") As Faction
	else
		OSAFaction = None
	endif

	HasSerialStrip = SS.HasSS()

	if (GreetType < 0)
		if (GreetOwner)
			if (SubmissiveGreet) && (!DisableBDSM)
				GreetType = 2
			else
				GreetType = 1
			endif
		else
			GreetType -= 0
		endif
	endif

	if (Game.GetModByname("FNISSpells.esp") != 255)
		HasFnisSpells = (Game.GetFormFromFile(0x00000d63, "FNISSpells.esp") != None)
	else
		HasFnisSpells = false
	endif

	HasAygas = Aygas.HasAygas()

	if (Game.GetModByname("Heretical Resources.esm") != 255)
		HR_HavocChain = (Game.GetFormFromFile(0x00007Fe3, "Heretical Resources.esm") as Activator)
		HasHereticalResources = (HR_HavocChain != None)
		Game.GetPlayer().AddPerk(ChainTalkPerk)
		if (!Game.GetPlayer().HasSpell(PlaceChain))
			Game.GetPlayer().AddSpell(PlaceChain)
		endif
	else
		Game.GetPlayer().RemovePerk(ChainTalkPerk)
		Game.GetPlayer().RemoveSpell(PlaceChain)
		HasHereticalResources = false
	endif

	if (Game.GetModByname("dcc-dm2.esp") != 255)
		DisplayModelFurniture = (Game.GetFormFromFile(0x000141df, "dcc-dm2.esp") as FormList)
		DisplayModelFaction = (Game.GetFormFromFile(0x00002858, "dse-display-model.esp") as Faction)
	elseif (Game.GetModByname("dse-display-model.esp") != 255)
		if (DisplayModelFurniture == None) 
			DisplayModelFurniture = (Game.GetFormFromFile(0x000cdd01, "PAH_HomeSweetHome.esp") as FormList)
		endif
		if (DisplayModelFurniture != None) 
			DMFunctions.AddDM3Furniture() 
		endif
		DisplayModelFaction = (Game.GetFormFromFile(0x00002858, "dse-display-model.esp") as Faction)
	else
		DisplayModelFurniture = None
		DisplayModelFaction = None
	endif

	HasZazExtension = (Game.GetModByname("ZazExtensionPack.esm") != 255)
	HasZaz622p = (Game.GetFormFromFile(0x00096766, "ZaZAnimationPack.esm") != None)
	HasTaraPack = ((Game.GetModByname("TaraUltimateFurniturePack.esm") != 255) && (Game.GetFormFromFile(0x0002f7e4, "TaraUltimateFurniturePack.esm") != None))
	HasTaraAnims2 = (Game.GetFormFromFile(0x00027aa9, "ZaZAnimationPack.esm") != None)
	HasTaraAnims = ((Game.GetModByname("TaraOffsetBondagePack.esp") != 255) && (Game.GetFormFromFile(0x000012c7, "TaraOffsetBondagePack.esp") != None))
	HasZaz8 = (Game.GetFormFromFile(0x0005e869, "ZaZAnimationPack.esm") != None)
	if (HasZaz8)
		Zaz8Version = 0
		if (Game.GetFormFromFile(0x00085e57, "ZaZAnimationPack.esm") != None)
			Zaz8Version = 1		; Zap 8+
		endif
		if (Game.GetFormFromFile(0x0009be97, "ZaZAnimationPack.esm") != None)
			if (!Game.GetPlayer().HasSpell(PlaceRing2))
				Game.GetPlayer().AddSpell(PlaceRing2)
			endif
			Zaz8Version = 2		; Zap 9
		endif
	else
		Zaz8version = -1
	endif

	ITF.GetSoftRequirements()
	HasTortureFramework = ITF.hasITF
	HasSlaveCart = (Game.GetModByname("PAHSlaveCart.esp") != 255)
	HasMME = MMEFunctions.CheckMME()

	PHHSHInter.GetSoftRequirements()
	HasSlaveTats = (Game.GetModByname("SlaveTats.esp") != 255)

	Serana = Game.GetFormFromFile(0x00002b6c, "Dawnguard.esm") as Form

	LogTrace("--- HSH soft requirements check ends ---") 
EndFunction

Function DebugSlave(Actor slave)
		slave.RemoveFromAllFactions()
		slave.AddToFaction(HouseSlaveFaction)
	String s = "Debugging:" + slave.GetDisplayName() + "," + slave.GetName()
	Faction[] facs = slave.GetFactions(-127, 127)
	int i=0
	while (i<facs.length)
		s += facs[i].GetFormId() + ","
		i+=1
	endwhile
	slave.SetDisplayName("Hello kitty")

	debug.messagebox(s)
EndFunction

Function LockupInHunter(Actor slave)
	ReferenceAlias houseSlot = GetFreeslotHunter()
	ReferenceAlias assistSlot = GetAssistantHunter()
	RegisterSlaveInHouseWithType(slave, houseSlot, 101) ; 101 Hunter
	if (houseSlot != None)
		HunterFunctions.DoorStairs.Lock(false, true)
		HunterFunctions.DoorBasementN.Lock(false, true)
		if (assistSlot != None)
			(houseSlot as PHHSHHouseSlave).Wait()
			(assistSlot as PHHSHGuardFunctions).PrepareToEscort(slave)
		else
			(houseSlot as PHHSHHouseSlave).WaitInCell()
		endif
	endif
EndFunction

Function LockupInTempCamp(Actor akRef)
	LogTrace("PHHSHStorageFunctions LockupInTempCamp akRef="+akRef)
	if SlaveNeedsEscort(akRef)
		if (PortableFunctions.TempCamp as PHHSHPortableCellScript).Guard == None
			debug.notification("Make sure that this slave is guarded or they may escape!")
		endif
	elseif SlaveCanGuard(akRef)
		(PortableFunctions.TempCamp as PHHSHPortableCellScript).SetGuard(akRef)
	endif
	ReferenceAlias houseSlot = GetFreeslotTempCamp()
	LockupSlaveInHouse(akRef, houseSlot, none, 102) ; 102 = Camp
EndFunction

Event OnUpdate()
	NominatedTrainer.Clear()
EndEvent

Function RegisterSlaveInHouse(Actor akRef, ReferenceAlias slot)
	RegisterSlaveInHouseWithType(akRef,slot,0)
EndFunction

Function RegisterSlaveInHouseWithType(Actor akRef, ReferenceAlias slot, int itype) ; itype = 100 House, 101 Hunter, 102 Camp
	LogTrace("PHHSHStorageFunctions RegisterSlaveInHouseWithType type="+itype+" slot="+slot)
	if (slot == None)
		debug.notification("This place cannot accommodate more residents")
		LogTrace("PHHSHStorageFunctions RegisterSlaveInHouseWithType This place cannot accommodate more residents type="+itype)
	else
		slot.ForceRefTo(akRef)
		Faction DLC1ThrallFaction = Game.GetFormFromFile(0x162F7, "Dawnguard.esm") As Faction
		If DLC1ThrallFaction
			akRef.RemoveFromFaction(DLC1ThrallFaction)
		endif

		RemoveSlaveFromDOM(akRef)

		akRef.AddToFaction(HouseSlaveFaction)
;		akRef.AddToFaction(PlayerAllyFaction)		; Leave commented out
		akRef.RemoveFromFaction(NakedFaction)
		akRef.RemoveFromFaction(PlayerFaction)
		If DLC1ThrallFaction
			akRef.RemoveFromFaction(DLC1ThrallFaction)
		endif
		akRef.SetAV("aggression", 0)
;		akRef.SetAV("assistance", 0)		; Leave commented out
		akRef.SetPlayerTeamMate(false, false)
		akRef.StopCombat()
		PHHSHHouseSlave slaveHSH = slot as PHHSHHouseSlave
		LogTrace("AfterAssignWithType "+akRef.GetDisplayName()+" akRef="+akRef)
		slaveHSH.AfterAssignWithType(itype)
		;SlaveRef(akRef).AfterAssign()
		PHHSHInter.SetSexSubFactions(akRef)		; This does a true-up between sex training and the 3 detailed training levels for sex
		akRef.AllowPCDialogue(true)

		; Check if this new slave should be exempt from training (only affects auto pairing by taskmasters)
		Actor tm = Taskmaster.TaskmasterInCell(akRef.GetParentCell())
		if ((tm != None) && (tm.IsInFaction(TrainingExemptFaction)))
			akRef.AddToFaction(TrainingExemptFaction)
		else
			akRef.RemoveFromFaction(TrainingExemptFaction)
		endif
		if (tm != None)
			; Copy taskmaster behaviour flags to slave
			slaveHSH.BeAllowMilking = SlaveRef(tm).TMAllowMilking
			;SlaveRef(akRef).BeAllowMilking = SlaveRef(tm).TMAllowMilking
		endif
		
	endif
EndFunction

Function LockupSlaveInHouse(Actor akRef, ReferenceAlias slot, ReferenceAlias assistSlot, int itype)
	if (slot == None)
		debug.notification("This house cannot accommodate more residents")
		LogTrace("PHHSHStorageFunctions LockupSlaveInHouse This house cannot accommodate more residents")
	else
		if (akRef.GetItemCount(AuctionSpawnedToken))
			akRef.RemoveItem(AuctionSpawnedToken, 1, true)
		endif
		if (akRef.GetItemCount(AuctionToken))
			akRef.RemoveItem(AuctionToken, 1, true)
		endif
		RegisterSlaveInHouseWithType(akRef, slot, itype)
		if (assistSlot != None)
;			debug.notification("Escort")
			(slot as PHHSHHouseSlave).Wait()
			(assistSlot as PHHSHHouseSlave).PrepareToEscort(akRef)
		else
			(slot as PHHSHHouseSlave).WaitInCell()
		endif
	endif
EndFunction

Function DeregisterFromWhiteRun(Actor akRef)
	LogTrace("DeregisterFromWhiteRun "+akRef)
	if (TransferInProgress)	
		debug.notification("Please wait for the previous slave transfer to complete")
		return
	endif
	TransferInProgress = true

	phhshPortableCellScript hc = DeregisterSlave(akRef)
	DOM_Actor akActor = AddSlaveToDOM(akRef)
	if akActor != None
		LogTrace("DeregisterFromWhiteRun "+akActor.GetName())
		; Store home cell
		akActor.hsh_home_cell = hc
	endif
	
	TransferInProgress = false
	utility.wait(2.0)
	akRef.SetDontmove(false)
	SendAnimationEvent(akRef, "IdleForceDefaultState")
EndFunction

phhshPortableCellScript Function DeregisterSlave(Actor akRef)
	LogTrace("DeregisterSlave "+akRef)
	PHHSHInter.SetSexSubFactions(akRef)		; This does a true-up between sex training and the 3 detailed training levels for sex
	PHHSHHouseSlave slaveScript = SlaveRef(akRef)

	phhshPortableCellScript hc = None
	if (akRef.GetparentCell() != None)
		ReferenceAlias hcell = PortableFunctions.HoldingCellrefForCell(akRef.GetParentCell())
		LogTrace("DeregisterSlave cell="+hcell)
		if ((hcell != None) && (hcell != PortableFunctions.TempCamp))
			hc = (hcell as phhshPortableCellScript)
			hc.RemoveSlave(slaveScript)
			LogTrace("DeregisterSlave remvoe slave from cell="+hc)
		endif
	endif
	if hc == None
		hc = slaveScript.GetHomeCell()
	endif
	
	if (akRef.IsInFaction(IsTrainerFaction))
		SlaveRef(slaveScript.Trainee).WaitInCell()
		RemoveAsTrainee(slaveScript.trainee, false)
	endif
	slaveScript.DoClear()
	akRef.RemoveFromFaction(HouseSlaveFaction)
	akRef.RemoveFromFaction(InSceneFaction)
	akRef.RemoveFromFaction(WallChainFaction)
	akRef.RemoveFromFaction(RestrainedFaction)
	akRef.RemoveFromFaction(OnRackFaction)
	akRef.RemoveFromFaction(PAHHouseReservedFaction )
	akRef.RemoveFromFaction(NakedFaction)
	akRef.RemoveFromFaction(TaskAssignedFaction)
	if (akRef.IsInFaction(IsDesignatedTrainerFaction))
		akRef.SetFactionRank(IsDesignatedTrainerFaction, 1)
	endif
	TaskMaster.DismissTaskmaster(akRef)

	ClearNoEnslave(akRef)
	akRef.SetDontmove(false)
	SendAnimationEvent(akRef, "IdleForceDefaultState")
	
	return hc
EndFunction

Function SexDialogChecks(Actor akRef)
	HasThreesomeSexPartner = (PortableFunctions.GetEligibleSexPartner(akRef) != None)
EndFunction

Function GoToCell(Actor akRef)
	SlaveRef(akRef).WaitInCell()
	TrainPoseBonus(akRef, 1)
EndFunction

Function GoToBedroom(Actor akRef)
	SlaveRef(akRef).WaitInBedroom()
	TrainPoseBonus(akRef, 1)
EndFunction

Function Wait(Actor akRef)
	SlaveRef(akRef).Wait()
	TrainPoseBonus(akRef, 3)
EndFunction

Function EndWaiting(Actor akRef)
	SlaveRef(akRef).Sandbox()
	ClearReservedConditions(akRef)
EndFunction

Function ClearReservedConditions(Actor akRef)
	; Attempt to clear incorrect flags
	if (!akRef.IsInFaction(IsTraineeFaction))
		akRef.RemoveFromFaction(TrainerPunishingFaction)
		akRef.RemoveFromFaction(RestrainedFaction)
		akRef.RemoveFromFaction(WallChainFaction)
		akRef.RemoveFromFaction(WaitingFaction)
		akRef.RemoveFromFaction(PAHHouseReservedFaction )
	endif
EndFunction

Function PoseAnim(Actor akRef, string PoseAnim)
	;LogTrace("HSH: Should pose "+PoseAnim)
	PHHSHHouseSlave slaveRef = SlaveRef(akRef)
	if (slaveRef == None)
		PHHSHInter.PoseAnim(akRef,PoseAnim)
	else
		if (PoseOnFurniture > 0)
			AnimOnFurniture(akRef, PoseAnim, ListTables)
		else
			slaveRef.WaitWithAnim(PoseAnim)
		endif
		PoseOnFurniture = 0
		TrainPoseBonus(akRef, 2)
	endif
EndFunction

Function PoseSeat(Actor akRef, int pose)
	PHHSHHouseSlave slaveRef = SlaveRef(akRef)
	if (pose == 1)
		slaveRef.WaitWithSeat("HSHIdleSeat1")
		if (slaveRef.PoseFurnitureMarker == None)
			slaveRef.PoseFurnitureMarker = akRef.PlaceAtMe(FurniStraddle, 1)
		endif
		SitOnSlave(akRef)
	elseif (pose == 2)
		slaveRef.WaitWithSeat("HSHIdleSeat2")
		if (slaveRef.PoseFurnitureMarker == None)
			slaveRef.PoseFurnitureMarker = akRef.PlaceAtMe(FurniSit, 1)
		endif
		SitOnSlave(akRef)
	endif
	PoseOnFurniture = 0
	TrainPoseBonus(akRef, 2)
EndFunction

Function SitOnSlave(Actor akRef)
	PHHSHHouseSlave slaveRef = SlaveRef(akRef)
	if (slaveRef.PoseFurnitureMarker != None)
		float zr = akRef.GetAngleZ()
		if (slaveRef.PoseFurnitureMarker.GetbaseObject() == FurniStraddle)
			slaveRef.PoseFurnitureMarker.MoveTo(akRef, math.sin(zr)*25, math.cos(zr)*25, 3, true)
		else
			slaveRef.PoseFurnitureMarker.MoveTo(akRef, math.sin(zr)*0, math.cos(zr)*0, 0, true)
			slaveRef.PoseFurnitureMarker.SetAngle(slaveRef.PoseFurnitureMarker.GetAngleX(), slaveRef.PoseFurnitureMarker.GetAngleY(), slaveRef.PoseFurnitureMarker.GetAngleZ() + 90)
		endif
		akRef.SetVehicle(slaveRef.PoseFurnitureMarker)
		slaveRef.PoseFurnitureMarker.Activate(Game.GetPlayer())
	endif
EndFunction

Function AccompanyPlayer(Actor akRef)
	ClearReservedConditions(akRef)
	SlaveTarget(akRef).ForceRefTo(Game.GetPlayer())
	SlaveRef(akRef).AccompanyPlayer()
EndFunction

Function GoToOwnerBed(Actor akRef)
	PHHSHHouseSlave slaveScript = SlaveRef(akRef)
	if (slaveScript.BedroomMarker != None)
		; Find bed near marker
		SlaveTarget(akRef).ForceRefTo(slaveScript.BedroomMarker)
		RestrainAtMarker(akRef, "ZapBedTied", 6)
	else
		RestrainAtMarker(akRef, "ZapBedTied", 4)
	endif
	TrainPoseBonus(akRef, 1)
EndFunction

Function AnimOnFurniture(Actor akRef, string anim, FormList forms)
	PHHSHHouseSlave slaveScript = SlaveRef(akRef)

	ObjectReference furni = Game.FindClosestReferenceOfAnyTypeInListFromRef(forms, akRef, 512)	; Find nearest object from supplied list
	if ((furni == none) || (!furni.IsEnabled()))
		debug.notification("No nearby furniture found")
		; Let slave speak topic for this
	else
		SlaveTarget(akRef).ForceRefTo(furni)
		RestrainAtMarker(akRef, anim, 7)
	endif
EndFunction


Function SetRoomMarker(Actor akRef, int markerType)		; 1=Cell, 2=House, 3=Bed
	Activator acType = None
	String typeName = ""
	if (markerType == 1)
		acType = CellMarkerAct
		typeName = "Cell"
	elseif (markerType == 2)
		acType = HouseMarkerAct
		typeName = "House"
	else
		acType = BedroommarkerAct
		typeName = "Bedroom"
	endif

	; Find nearest marker of type
	ObjectReference marker = Game.FindClosestReferenceOfTypeFromRef(acType, Game.GetPlayer(), 512)
	if (marker != None)
		if (markerType == 1)
			SlaveRef(akRef).CellMarker = marker
		elseif (markerType == 2)
			SlaveRef(akRef).HouseMarker = marker
		else
			SlaveRef(akRef).BedroomMarker = marker
		endif
	else
		debug.notification("No " + typeName + " found nearby")
	endif
EndFunction

Function ClearRoomMarker(Actor akRef, int markerType)		; 1=Cell, 2=House, 3=Bed
	if (markerType == 1)
		SlaveRef(akRef).CellMarker = None
	elseif (markerType == 2)
		SlaveRef(akRef).HouseMarker = None
	else
		SlaveRef(akRef).BedroomMarker = None
	endif
EndFunction

Function CheckSexTrained(Actor akRef)
	SexTrained = (PHHSHInter.GetSexTraining(akRef) >= 40)
EndFunction

Function SetFreeSex(Actor akRef, bool doSex)
	if (doSex)
		if (PHHSHInter.GetSexTraining(akRef) < 40)
			SexTrained = false;
		else
			SexTrained = true;
			akRef.AddToFaction(HouseFreeSexFaction)
		endif
	else
		akRef.RemoveFromFaction(HouseFreeSexFaction)
	endif
EndFunction

Function SetFixedOutfit(Actor akRef, bool fixed)
	; Changed to work as a snapshot
;	if (fixed)
		slaveRef(akRef).StoreOutfit()
;		akRef.AddToFaction(HouseFixedOutfit)
;	else
;		akRef.RemoveFromFaction(HouseFixedOutfit)
;	endif
EndFunction

Function NominateForTrainer(Actor trainer)
	PHHSHHouseSlave trainerScript = SlaveRef(trainer)
	if  (trainerScript.IsYoked)
		debug.notification("I can't train other slaves while bound like this!")
		return
	endif
	NominatedTrainer.ForceRefTo(trainer)
	RegisterForSingleUpdate(60)
EndFunction

Function AssignTrainee(Actor trainee)
	PHHSHHouseSlave trainerScript = None
	PHHSHHouseSlave traineeScript = SlaveRef(trainee)

;	if (traineeScript.IsYoked)
;		debug.notification("What am I supposed to do, bound in this thing?")
;		return
;	endif
	
	Actor trainer = NominatedTrainer.GetRef() as Actor
	AssignTrainerToTrainee(trainer, trainee)

	NominatedTrainer.Clear()
	UnregisterForUpdate()
EndFunction
	
Function AssignTrainerToTrainee(Actor trainer, Actor trainee)
	PHHSHHouseSlave trainerScript = None
	if (trainer != None)
		trainerScript = SlaveRef(trainer)
	endif
	PHHSHHouseSlave traineeScript = SlaveRef(trainee)

	if ((trainerScript != None) && (traineeScript != None))
		if ((trainerScript.Trainee != None) && (trainerScript.Trainee != trainee))
			; Reset existing trainee
			RemoveAsTrainee(trainerScript.trainee, false)
		endif
		trainerScript.Trainee = trainee
		traineeScript.Trainer = trainer
		trainee.AddToFaction(IsTraineeFaction)
		trainer.AddToFaction(IsTrainerFaction)
		Weapon trainingWhip = PHHSHInter.GetTrainingWhip()
		trainer.AddItem(trainingWhip)
		trainer.EquipItem(trainingWhip, true)
		trainer.AddItem(cellKey)
		SlaveTarget(trainee).ForceRefTo(trainer)
		traineeScript.AccompanyPlayer()
		trainerScript.RegisterAsTrainer()
		utility.wait(1)
		UpdateGear(trainer)
		trainee.RemoveFromFaction(TrainingExemptFaction)
		trainee.RemoveFromFaction(HouseFreeSexfaction)
		trainer.RemoveFromFaction(HouseFreeSexfaction)
		trainee.RemoveFromFaction(TaskAssignedfaction)
		trainer.RemoveFromFaction(TaskAssignedfaction)
		trainee.RemoveFromFaction(HouseCagedFaction)
		trainer.RemoveFromFaction(HouseCagedFaction)
		trainee.RemoveFromFaction(TrainerPunishingFaction)
		trainer.RemoveFromFaction(TrainerPunishingFaction)
		if (trainee.IsInFaction(IsDesignatedTrainerFaction))
			trainee.SetFactionRank(IsDesignatedTrainerFaction, 1)
		endif

	else
		debug.notification("Failed to assign trainer")
	endif
EndFunction

Function WhipTrainee(Actor trainer, bool whip)
	if (whip)
		trainer.RemoveFromFaction(DoNotWhip)
	else
		trainer.AddToFaction(DoNotWhip)
	endif
EndFunction

Function ReleaseTrainee(Actor trainer, bool returnToCell)
	Actor trainee = SlaveRef(trainer).trainee
	if (trainee != None)
		RemoveAsTrainee(trainee, returnToCell)
	endif
	trainer.RemoveFromFaction(IsTrainerFaction)
	trainer.RemoveFromFaction(TrainerDoneFaction)
	trainer.RemoveFromFaction(TrainerPunishingFaction)
	trainer.RemoveItem(cellKey)
	Weapon trainingWhip = PHHSHInter.GetTrainingWhip()
	trainer.RemoveItem(trainingWhip)
	utility.wait(1)
	UpdateGear(trainer)
EndFunction

Function RemoveAsTrainee(Actor trainee, bool returnToCell)
	PHHSHHouseSlave traineeScript = SlaveRef(trainee)
	if (traineeScript != None) 
		PHHSHHouseSlave trainerScript = SlaveRef(traineeScript.trainer)
		trainee.RemoveFromFaction(IsTraineeFaction)
		trainee.RemoveFromFaction(TrainerPunishingFaction)
		trainee.EvaluatePackage()
		if (traineeScript.trainer != None)
			traineeScript.trainer.RemoveFromFaction(IsTrainerFaction)
			traineeScript.trainer.RemoveFromFaction(TrainerDoneFaction)
			TraineeScript.trainer.RemoveFromFaction(TrainerPunishingFaction)
			TraineeScript.trainer.EvaluatePackage()

			if ((!trainee.IsInFaction(HouseCagedFaction)) && (!returnToCell))
				trainerScript.PrepareToEscort(trainee)
			else
				ClearFromScene(traineeScript.trainer)
				ClearFromScene(trainee)
			endif
			Weapon trainingWhip = PHHSHInter.GetTrainingWhip()
			traineeScript.trainer.UnequipItem(trainingWhip)
			utility.wait(0.2)
			traineeScript.trainer.RemoveItem(trainingWhip, 1)
			utility.wait(0.5)
			UpdateGear(traineeScript.trainer)
			traineeScript.trainer = None
			trainerScript.trainee = None
			trainerScript.UnregisterAsTrainer()
		endif
	endif
EndFunction

Function BringTraineeToCell(Actor trainer)
	PHHSHHouseSlave trainerScript = SlaveRef(trainer)

;	if ((trainerScript.IsBound) || (trainerScript.IsYoked))
;		debug.notification("I'm a bit tied up")
;		return
;	endif

	if ((trainerScript != none) && (!trainerScript.trainee.IsInFaction(HouseCagedFaction)))
		SlaveTarget(trainer).ForceRefTo(Game.GetPlayer())
		trainerScript.AccompanyPlayer()
		trainer.SetFactionRank(TrainerPunishingFaction, 0)
		trainerScript.PrepareToEscort(trainerScript.trainee)
	else
		trainer.SetFactionRank(TrainerPunishingFaction, 0)
	endif
EndFunction

Function FetchTraineeFromCell(Actor trainer)
	PHHSHHouseSlave trainerScript = SlaveRef(trainer)

;	if ((trainerScript.IsBound) || (trainerScript.IsYoked))
;		debug.notification("I can't unlock the cell door like this!")
;		return
;	endif

	if ((trainerScript != none)) ; && ( (trainerScript.trainee.IsInFaction(HouseCagedFaction)) || (trainerScript.trainee.IsInFaction(OnRackFaction))  ))
		trainer.RemoveFromFaction(TrainerPunishingFaction)
		trainerScript.PrepareToFetch(trainerScript.trainee)
	endif
EndFunction

Function CheckTraineeFactionRank(Actor trainer)
	ReferenceAlias akRef = SlaveRef(trainer) as ReferenceAlias
	PHHSHHouseSlave trainerScript = akRef as PHHSHHouseSlave
	DOM_Actor akTrainer = akRef as DOM_Actor
	if ((trainerScript != none) && (trainerScript.trainee != None))
		Actor trainee = trainerScript.trainee
		DOM_Actor akTrainee = DOM01.GetActor(trainee)
		TraineeFactionRank = trainee.GetFactionRank(IsTraineeFaction)
		if akTrainee != None && akTrainer != None
			CanTrainSex = CanTrainSex(akTrainer,akTrainee)
			CanTrainObedience = CanTrainObedience(akTrainer,akTrainee)
			CanTrainRespect = CanTrainRespect(akTrainer,akTrainee)
			CanTrainCombat = CanTrainCombat(akTrainer,akTrainee)
			CanTrainPose = CanTrainPose(akTrainer,akTrainee)
		endif
	endif
EndFunction

bool Function CanTrainSex(DOM_Actor trainer, DOM_Actor trainee)
	if trainer.mind.sex_training >= trainee.mind.sex_training	
		return true
	endif
	return false
EndFunction

bool Function CanTrainObedience(DOM_Actor trainer, DOM_Actor trainee)
	if trainer.mind.submission >= trainee.mind.submission	
		return true
	endif
	return false
EndFunction

bool Function CanTrainRespect(DOM_Actor trainer, DOM_Actor trainee)
	if trainer.mind.respect_training >= trainee.mind.respect_training	
		return true
	endif
	return false
EndFunction

bool Function CanTrainCombat(DOM_Actor trainer, DOM_Actor trainee)
	if trainer.mind.combat_training >= trainee.mind.combat_training	
		return true
	endif
	return false
EndFunction

bool Function CanTrainPose(DOM_Actor trainer, DOM_Actor trainee)
	if trainer.mind.pose_training >= trainee.mind.pose_training	
		return true
	endif
	return false
EndFunction

Function SetTraineeFactionRank(Actor trainer, int rank)
	PHHSHHouseSlave trainerScript = SlaveRef(trainer)
	if ((trainerScript != none) && (trainerScript.trainee != None))
		trainerScript.Trainee.SetFactionRank(IsTraineeFaction, rank)
	endif
EndFunction


Function Punish(Actor trainer, int punishment = -1)
	PHHSHHouseSlave trainerScript = SlaveRef(trainer)
	Actor trainee = trainerScript.trainee
	int trainingType = trainee.GetFactionRank(IsTraineeFaction)

	if ((trainingType == 3) && (punishment < 0) && (DoCombatTraining))	; Combat
		DebugLog("Start sparring between "+ trainer.GetDisplayName() + " and " + trainee.GetDisplayName())
		trainerScript.SparWithTrainee()
		return
	endif

	PunishActor(trainer, trainee, punishment, true)
EndFunction

Function PunishActor(Actor dominant, Actor submissive, int punishment, bool isTraining)
	PHHSHHouseSlave domScript = SlaveRef(dominant)
	PHHSHHouseSlave subScript = SlaveRef(submissive)
	
	if (subScript.OffsetRestraint != None)
		return
	endif

	int startIndex = 1
	int endIndex = 27

	if (!SpawnFurniture)
		startIndex = 9
	endif

	int trainingType = submissive.GetFactionRank(IsTraineeFaction)
	if ((trainingType == 2) && (isTraining))	; Sex
		startIndex = 22
	endif

	if ((HasTaraAnims) || (HasTaraAnims2))
		endIndex = 31
	endif

	int punishmentIndex = utility.RandomInt(startIndex,endIndex)

	if ((DOMSexlab.IsValidActor(dominant)) && (DOMSexlab.IsValidActor(submissive)) && (trainingType != 1) && (trainingType != 3)) 
;		punishmentIndex = utility.RandomInt(startIndex, endIndex)
	elseif ((punishmentIndex >= 22) && (punishmentIndex <= 27))
		; Not a valid sex target
		punishmentIndex += 6
	endif

	if (punishment > 0)
		punishmentIndex = punishment
	endif

	DebugLog(dominant.GetDisplayName() + " to punish " + submissive.GetDisplayName()+ " with:" + punishmentIndex)
;	debug.notification(dominant.GetDisplayName() + " to punish " + submissive.GetDisplayName()+ " with:" + punishmentIndex)
;	if (traineeScript.IsYoked)
;		DebugLog("Trainee yoked, cancelling")
;		return
;	endif
;	if ((trainerScript.IsYoked)) ; || (trainerScript.IsBound))
;		DebugLog("Trainer yoked, cancelling")
;		return
;	endif

	if (isTraining)
		TrainPoseBonus(submissive, 2)
	endif

	;traineeScript.StopPosing(trainee)
	;SendAnimationEvent(trainee, "IdleForceDefaultState")

	; Sequence: 1a) Trainee move to position and announce, 1b) trainer move to trainee, 2) Tie up, 3) Punish, 4) End
	int markerIndex = -1
 	string punishAnim = ""
	string poseAnim = ""
	if (punishmentIndex == 1)
		poseAnim = "ZazAPCAO201"
		punishAnim = "whip"
	elseif (punishmentIndex == 2)
		poseAnim = "ZapXCrossPose01b"
		punishAnim = "IdleLockpick"
		markerIndex = 1
	elseif (punishmentIndex == 3)
		if (UseBDSMMarkers)
			poseAnim = "ZazAPCAO017"
		else
			poseAnim = "ZapXCrossPose01b"
		endif
		punishAnim = "whip"
		markerIndex = 1
	elseif (punishmentIndex == 4)
		poseAnim = "ZazAPPillSolo05"
		punishAnim = "ZazAPPillTorCandle1A"
		markerIndex = 1
	elseif (punishmentIndex == 5)
		if (hasTaraPack)
			poseAnim = "taraHogtie02_Enter"
		else
			poseAnim = "ZazAPCAO263"
		endif
		punishAnim = "ZazAPPillTorCandle1A"
	elseif (punishmentIndex == 6)
		poseAnim = "ZazAPCAO013"
		punishAnim = "FNISSPc39"
	elseif (punishmentIndex == 7)
		poseAnim = "ZazAPCAO261"
		punishAnim = "ZazAPPillTorCandle1A"
	elseif (punishmentIndex == 8)
		poseAnim = "ZapXCrossPose02"
		punishAnim = "whip"
		markerIndex = 1
	elseif (punishmentIndex == 9)
		poseAnim = "ZazAPCAO313"
		punishAnim = "IdleLockpick"
	elseif (punishmentIndex == 10)
		if (hasTaraPack)
			poseAnim = "taraGirlStrugglingOnTheGround_Enter"
		else
			poseAnim = "ZapWriPose15"
		endif
		punishAnim = "ZazAPPillTorCandle1A"
	elseif (punishmentIndex == 11)
		if (hasTaraPack)
			poseAnim = "taraHogtie04_Enter"
		else
			poseAnim = "ZapWriPose13"
		endif
		punishAnim = "ZazAPPillTorCandle1A"
	elseif (punishmentIndex == 12)
		poseAnim = "ZazAPCAO306"
		punishAnim = "whip"
	elseif (punishmentIndex == 13)
		poseAnim = "ZazAPCAO304"
		punishAnim = ""
	elseif (punishmentIndex == 14)
		poseAnim = "ZapLickFeet"
		punishAnim = ""
	elseif (punishmentIndex >= 15) && (punishmentIndex < 22)
		ObjectReference furni = FindUnusedZapFurniture(submissive, false)
		if (furni != None)
			bool isActivator = ((DisplayModelFurniture != None) && (DisplayModelFurniture.Find(furni.GetBaseObject()) >= 0))
			ReferenceAlias session = None

			if ((HasTortureFramework) && (!isActivator) && (FrameworkHandlesTorture))
				DebugLog("Torture in furniture:" + furni.GetbaseObject().GetName())
				session = ITF.RequestTortureSession(furni, submissive, dominant, None, None, true)
				if (session)
					subScript.RegisterForITF()
					SlaveTarget(submissive).ForceRefTo(furni)

					RestrainAtMarker(submissive, "", 5)
					utility.wait(1)
					submissive.EvaluatePackage()
					return
				endif
			endif
			if (session == None)
				DebugLog("Punish in furniture:" + furni.GetbaseObject().GetName())
				SlaveTarget(submissive).ForceRefTo(furni)
				poseAnim = ""
				punishAnim = "whip"
				if (isActivator)
					markerIndex = 9
				else
					markerIndex = 5
				endif
			endif
		else
			poseAnim = "ZapXCrossPose02"
			punishAnim = "whip"
			markerIndex = 1
		endif
	elseif ((punishmentIndex >= 22) && (punishmentIndex <= 27))
		DebugLog("Punish with sex")
		poseAnim = ""
		punishAnim = ""
		submissive.AddToFaction(InSceneFaction)
		dominant.AddToFaction(InSceneFaction)

		int sexHook = dominant.GetFormId()
		if (sexHook < 0)
			sexHook = math.abs(sexHook) as int
		endif

		domScript.SexHook = sexHook
		subScript.SexHook = sexHook
		SendAnimationEvent(submissive, "IdleForceDefaultState")

		actor[] sexActors = new actor[2]
    	sexActors[0] = submissive
    	sexActors[1] = dominant

	    sslBaseAnimation[] anims = DOMSexlab.GetAnimationsByTagsBase(2, "Aggressive,Forced", "", false)

   		DOMSexlab.StartSex(sexActors, anims, submissive, false, "" + sexHook)
		domScript.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
		subScript.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
		return
	else
		PortableFunctions.TryApplyTears(submissive)
		SlaveTarget(submissive).ForceRefTo(dominant)
		subScript.FollowTarget()
		RestraintsFunctions.PunishWithRanDOMWornCollar(submissive, 30)
		return;
	endif

	if (punishmentIndex < 22)
		PortableFunctions.TryApplyTears(submissive)
	endif

	Weapon trainingWhip = PHHSHInter.GetTrainingWhip()
	dominant.EquipItem(trainingWhip)
	utility.wait(1)
	UpdateGear(dominant)
	DebugLog("Trainer punish " + punishmentIndex +" at marker:" + markerIndex + "  pose:" + poseAnim + "  punish:" + punishAnim)
;	Debug.Notification("Trainer punish " + punishmentIndex +" at marker:" + markerIndex + "  pose:" + poseAnim + "  punish:" + punishAnim)
	if (markerIndex < 0)
		domScript.PrepareToPunishTrainee(punishAnim, poseAnim)
		subScript.Wait()
		submissive.AddToFaction(InSceneFaction)
	else
		domScript.PrepareToPunishTrainee(punishAnim, "")
		RestrainAtMarker(submissive, poseAnim, markerIndex)
	endif
EndFunction

Function BdsmEval(Actor slave)
	; Called before openimg the BDSM menu.
	; Find nearby chains
	if (HR_HavocChain != None)
		HR_NearbyWallChain = None
		HR_NearbyWallChain = Game.FindClosestReferenceOfTypeFromRef(HR_HavocChain, slave, 300)
		HR_isNearWallChain = ((HR_NearbyWallChain != None) && (HR_NearbyWallChain.Z - slave.Z > -50))
		HR_isNearWallChain2 = false
;		if (HR_isNearWallChain)
;			; Move object out of the way, then recheck to find a second one.
;			float Z = HR_NearbyWallChain.Z
;			HR_NearbyWallChain.Disable()
;			HR_NearbyWallChain.SetPosition(HR_NearbyWallChain.X, HR_NearbyWallChain.Y, Z - 1000)
;			HR_NearbyWallChain2 = Game.FindClosestReferenceOfTypeFromRef(HR_HavocChain, slave, 300)
;			HR_NearbyWallChain.SetPosition(HR_NearbyWallChain.X, HR_NearbyWallChain.Y, Z)
;			HR_NearbyWallChain.Enable()
;			HR_isNearWallChain2 = ((HR_NearbyWallChain2 ) && (HR_NearbyWallChain != HR_NearbyWallChain2) && (HR_NearbyWallChain2.Z - slave.Z > -50))
;			debug.notification("Extra chain:" + (HR_isNearWallChain2))
;		endif
	endif
;	debug.notification("Wall chain:" + HR_isNearWallChain)
EndFunction

Function BdsmWallChain(Actor slave, int type)	;1 = neck, 2 = wrist, 3 = ankle, 4 = L wrist
	if (!HasHereticalResources)
		return
	endif

	ObjectReference chain1 = None
	if (HR_isNearWallChain)
		chain1 = HR_NearbyWallChain
	endif
	ObjectReference chain2 = None
	if (HR_isNearWallChain2)
		chain2 = HR_NearbyWallChain2
	endif
	
	if (chain2 != None)
		if (chain1.Z - chain2.Z < -25 )
			chain2 = HR_NearbyWallChain
			chain1 = HR_NearbyWallChain2
		endif
	endif
	
	SlaveRef(slave).ChainWristL = None
	SlaveRef(slave).ChainWristR = None
	SlaveRef(slave).ChainAnkleL = None
	SlaveRef(slave).ChainAnkleR = None
	SlaveRef(slave).ChainNeck = None

	if (type == 1)
		SlaveRef(slave).ChainNeck = chain1
	elseif (type == 2)
		SlaveRef(slave).ChainWristR = chain1
	elseif (type == 3)
		SlaveRef(slave).ChainAnkleR = chain1
	elseif (type == 4)
		SlaveRef(slave).ChainWristR = chain1
		if (chain2 != None)
			SlaveRef(slave).ChainWristL = chain2
		else
			SlaveRef(slave).ChainWristL = chain1
		endif
	elseif (type == 5)
		SlaveRef(slave).ChainWristR = chain1
		SlaveRef(slave).ChainWristL = chain1
		SlaveRef(slave).ChainAnkleR = chain2
		SlaveRef(slave).ChainAnkleL = chain2
	endif
	SlaveTarget(slave).ForceRefTo(chain1)
EndFunction

Function BdsmWallChainPose(Actor slave, string anim)
	RestrainAtMarker(slave, anim, 8)
EndFunction

bool Function TryUseZapFurniture(Actor slave, bool useNearest = false)
	FormList fl = PortableFunctions.ZazFurnitureList()
	return TryUseFurnitureFromList(slave, useNearest, fl, true)
EndFunction

bool Function TryUseFurnitureFromList(Actor slave, bool useNearest, FormList fl, bool useDM)
	ObjectReference furni = FindUnusedFurnitureFromList(slave, useNearest, fl, useDM)
	
	if (furni != None)
		ReferenceAlias slaveTarget = SlaveTarget(slave)
		bool isActivator = ((DisplayModelFurniture != None) && (DisplayModelFurniture.Find(furni.GetBaseObject()) >= 0))
		if (slaveTarget != None)
			slaveTarget.ForceRefTo(furni)
			if (isActivator)
				RestrainAtMarker(slave, "", 9)
			else
				RestrainAtMarker(slave, "", 5)
			endif
		else
			PHHSHInter.RestrainInFurniture(slave,furni,isActivator)
			utility.wait(10.0)
			if (isActivator)
				furni.activate(slave)
			else
				furni.activate(slave)
			endif			
		endif
		PortableFunctions.TryApplyTears(slave)
		return true
	else
		return false
	endif
EndFunction


ObjectReference Function FindUnusedZapFurniture(Actor slave, bool useNearest)
	FormList fl = PortableFunctions.ZazFurnitureList()
	return FindUnusedFurnitureFromList(slave, useNearest, fl, true)
EndFunction


ObjectReference Function FindUnusedFurnitureFromList(Actor slave, bool useNearest, FormList fl, bool useDm)
	ObjectReference furni = None
	ObjectReference furni2 = None

	if (useNearest)
		furni = Game.FindClosestReferenceOfAnyTypeInList(fl, slave.X, slave.Y, slave.Z, 2048)
		if ( (furni != None) && ((furni.IsFurnitureInUse()) || (!furni.IsEnabled())) )
			furni = None
		endif
		if ((DisplayModelFurniture != None) && (useDM))
			furni2 = Game.FindClosestReferenceOfAnyTypeInList(DisplayModelFurniture, slave.X, slave.Y, slave.Z, 2048)
			if ((furni2 != None) && (furni2.IsEnabled()) && ((furni == None ) || (furni.GetDistance(slave) > furni2.GetDistance(slave)) ))
				furni = furni2
			endif
		endif
	else
		furni = Game.FindRandomReferenceOfAnyTypeInList(fl, slave.X, slave.Y, slave.Z, 2048)
		int i = 10
		while ((furni != None) && ((furni.IsFurnitureInUse()) || (!furni.IsEnabled())) && (i > 0))
			i -= 1
			furni = Game.FindRandomReferenceOfAnyTypeInList(fl, slave.X, slave.Y, slave.Z, 2048)
		endwhile
		if (furni != None) && (furni.IsFurnitureInUse())
			furni = None
		endif

		if (useDM)
			furni2 = Game.FindRandomReferenceOfAnyTypeInList(DisplayModelFurniture, slave.X, slave.Y, slave.Z, 2048)
			i = 10
			while ((furni2 != None) && (!furni2.IsEnabled()) && (i > 0))
				i -= 1
				furni2 = Game.FindRandomReferenceOfAnyTypeInList(DisplayModelFurniture, slave.X, slave.Y, slave.Z, 2048)
			endwhile
			if ((furni2 != None) && (!furni2.IsEnabled()))
				furni2 = None
			endif
		endif

		if (utility.RandomInt(1,2) == 1)
			if (furni == none)
				DebugLog("Selected DM2 furniture")
				furni = furni2
			endif
		else
			if (furni2 != none)
				DebugLog("Selected DM2 furniture")
				furni = furni2
			endif
		endif
	endif

	return furni
EndFunction


Function Undress(Actor slave)
	DoUndress(slave, false)
EndFunction

Function DoUndress(Actor slave, bool noAnimate)
	TrainPoseBonus(slave, 2)
	PHHSHHouseSlave slaveScript = SlaveRef(slave)
	if ((HasSerialStrip) && (UseSerialStrip) && (!noAnimate))
		if (slaveScript)
			slave.AddTofaction(NakedFaction)
		endif
		SendAnimationEvent(slave, "IdleForceDefaultState")
;		RegisterForModEvent("SerialStripStop", "SSStripEnded")
		SS.StartStrip(self, slave, true)
	else
		if (slaveScript)
;			slaveScript.StoreOutfit()
			slave.AddTofaction(NakedFaction)
			slaveScript.RestoreOutfit()
		else
			DoStrip(slave)
			;slave.UnequipAll()
		endif
	endif
EndFunction

Function DoStrip(Actor the_actor)
	Form the_form
	Int i = the_actor.GetNumItems()
	while i > 0
		i -= 1
		the_form = the_actor.GetNthForm(i)
		if the_actor.IsEquipped(the_form)
			if isToBeStripped(the_form)
				the_actor.UnequipItem(the_form)
			endif
		endif
	endwhile
EndFunction

bool Function isToBeStripped(Form the_form)
	if the_form == None
		return false
	endif

	return DOMEquip.IsToBeStripped(the_form)
EndFunction

Function UndressOneItem(Actor slave)
	if ((HasSerialStrip) && (UseSerialStrip))
		SendAnimationEvent(slave, "IdleForceDefaultState")
;		RegisterForModEvent("SerialStripStop", "SSStripEnded")
		SS.StartStrip(self, slave, false)
	endif
EndFunction

Function Dress(Actor slave)
	PHHSHHouseSlave slaveScript = SlaveRef(slave)
	slave.RemoveFromfaction(NakedFaction)
	slaveScript.RestoreOutfit()
	slaveScript.CheckOutfit()
EndFunction

Function AnimWaitPose(Actor slave)
	slave.AddToFaction(InSceneFaction)
	slave.AddToFaction(HousePoseFaction)
EndFunction

Function AnimEndPose(Actor slave)
	slave.RemoveFromFaction(InSceneFaction)
	slave.RemoveFromFaction(HousePoseFaction)
	SendAnimationEvent(slave, "IdleForceDefaultState")
EndFunction

Function Restrain(Actor slave, String pose)
	PHHSHHouseSlave slaveScript = SlaveRef(slave)
	if ((slaveScript != None) && (slaveScript.IsYoked))
		debug.notification("I'm already sufficiently tied up!")
		return
	endif

	if (slaveScript == None)
		PHHSHInter.Restrain(slave,pose)
	else
		RestrainVictimBy(Game.GetPlayer(), slave, pose)
	endif
EndFunction

Function RestrainVictimBy(Actor aggressor, Actor victim, String pose)
	SendAnimationEvent(aggressor, "IdleLockpick")
	SlaveRef(victim).Restrain(pose)
EndFunction

Function RestrainAtMarker(Actor slave, String pose, int marker)
	PHHSHHouseSlave slaveScript = SlaveRef(slave)
	if ((slaveScript.IsYoked) && (marker != 8))
;		debug.notification("Am I not tied up enough as it is?!")
		return
	endif

	if (UseBdsmMarkers)
		SlaveRef(slave).RestrainAtMarker(pose, marker, false)
	else
		SlaveRef(slave).Restrain(pose)
	endif
EndFunction

Function ClearFromScene(Actor slave, bool clearanim = true)
	slave.RemoveFromFaction(AccompanyFaction)
	slave.RemoveFromFaction(HouseCagedFaction)
	slave.RemoveFromFaction(HousePoseFaction)
	slave.RemoveFromFaction(InSceneFaction)
	slave.RemoveFromFaction(TaskAssignedFaction)
	slave.RemoveFromFaction(OnRackFaction)
	if (slave.GetFactionRank(TrainerPunishingFaction) > 0)		; 0 = trainee in cell, keep this condition (not really a scene)
		slave.RemoveFromFaction(TrainerPunishingFaction)
	endif
	slave.RemoveFromFaction(RestrainedFaction)
	slave.RemoveFromFaction(WallChainFaction)
	utility.wait(1)
	if (clearanim)
		SendAnimationEvent(slave, "IdleForceDefaultState")
	endif
	SlaveRef(slave).Sandbox()
;	debug.notification("Cleared "+ slave.GetDisplayname() + " from scene")
EndFunction


Function EndRestrain(Actor slave)
	PHHSHHouseSlave slaveScript = SlaveRef(slave)
	if (slaveScript == None)
		SendAnimationEvent(slave, "IdleForceDefaultState")
		slave.SetDontMove(false)
		slave.RemoveFromFaction(RestrainedFaction)
		slave.RemoveFromFaction(WallChainFaction)
	else
		if (PHHSHInter.GetSubmissionTraining(slave) >= 70)
			slaveScript.Wait()
		else
			slaveScript.WaitInCell()
		endif
	endif
EndFunction

Function DoFavor(Actor slave)
	SlaveRef(slave).DoFavor()
EndFunction

Function OpenInventory(Actor slave)
	slave.OpenInventory(true)
EndFunction

Function TrainPoseBonus(Actor slave, float amount)
	if (!slave.IsInFaction(IsTraineeFaction))
		TrainPose(slave, amount)
	endif
EndFunction

Function TrainPose(Actor slave, float amount)
	DOM_Actor akActor = DOM01.GetActor(slave)
	akActor.mind.TrainPose(amount)
EndFunction

Function DoSlaveAbuse(Actor slave, bool aggressive = false)
	DoSlaveAbuseDuo(slave, Game.GetPlayer(), aggressive)
	PHHSHInter.SexAbuse(slave)
EndFunction

Function DoSlaveAbuseDuo(Actor slave, Actor john, bool aggressive = false)
	if slave == None
		return
	endif
	if john == None
		return
	endif
	LogTrace("HSH DoSlaveAbuseDuo with slave="+slave.GetDisplayName()+" actor="+john.GetDisplayName()+" aggressive="+aggressive)
	PHHSHHouseSlave slotRef = SlaveRef(slave)

	int sexHook = 0
	if ((SlotRef != None) && (slotRef != None))
		sexHook = john.GetFormId()
		if (sexHook < 0)
			sexHook = math.abs(sexHook) as int
		endif
		SlotRef.SexHook = sexHook
	endif

	if (!aggressive)
		if ((!DOMSexlab.GetGender(slave)) && (DOMSexlab.GetGender(john)))
			; On nonaggressive anims, swap actors if slave is male and partner is female
			sslThreadController i = DOMSexlab.QuickStart(john, slave, "" + sexHook)
		else
			sslThreadController i = DOMSexlab.QuickStart(slave, john, "" + sexHook)
		endif
	else
		actor[] sexActors = new actor[2]
    		sexActors[0] = slave
    		sexActors[1] = john

		sslBaseAnimation[] anims = DOMSexlab.GetAnimationsByTagsBase(2, "Aggressive,Forced", "", false)

   		DOMSexlab.StartSex(sexActors, anims, slave, false, "" + sexHook)
	endif
	if (slotRef != None)
		slave.AddToFaction(InSceneFaction)
		slotRef.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
	endif

	PHHSHInter.FollowPlayer(slave)
	PHHSHInter.IncreaseSexTraining(slave, utility.RandomInt(4,9))
EndFunction

Function DoSlaveAbuseSolo(Actor slave)
	if slave == None
		return
	endif
	LogTrace("HSH DoSlaveAbuseSolo with slave="+slave.GetDisplayName())
	PHHSHHouseSlave slotRef = SlaveRef(slave)

	int sexHook = 0
	if (SlotRef != None)
		sexHook = game.GetPlayer().GetFormId()
		if (sexHook < 0)
			sexHook = math.abs(sexHook) as int
		endif
		SlotRef.SexHook = sexHook
	endif

	sslThreadController i = DOMSexlab.QuickStart(slave, None, "" + sexHook)

	if (SlotRef != None)
		slave.AddToFaction(InSceneFaction)
		slotRef.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
	endif

	PHHSHInter.IncreaseSexTraining(slave, utility.RandomInt(4,9))
EndFunction

Function DoThreesome(Actor slave)
	int sexHook = game.GetPlayer().GetFormId()
	if (sexHook < 0)
		sexHook = math.abs(sexHook) as int
	endif

	; Get all slaves in this cell
	ReferenceAlias[] refsInCell = PortableFunctions.SlaveRefsInCell(slave.GetParentCell())
	int partnerCount = 2
	Actor[] sexActors = new Actor[5]
    	sexActors[0] = slave
    	sexActors[1] = game.GetPlayer()

	; Reserve slave and set end of scene event
	slave.AddToFaction(InSceneFaction)
	PHHSHInter.IncreaseSexTraining(slave, utility.RandomInt(2,4))
	PHHSHHouseSlave slotRef = SlaveRef(slave)
	slotref.SexHook = sexHook
	slotRef.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")

	; Find 3-5 extras to join in
	int maxPartners = utility.RandomInt(3, 5)
	int i = 0
	Actor partner
	while ((refsInCell[i] != None) && (partnerCount < maxPartners))
		partner = refsInCell[i].GetActorRef()
		if ((!partner.IsInFaction(InSceneFaction)) && (!partner.IsInFaction(TaskAssignedFaction)) && (!partner.IsInFaction(TaskmasterFaction)) && (!partner.IsInFaction(WallChainFaction)) && (partner.IsInFaction(HouseFreeSexFaction)) && (partner != slave) && (DOMSexlab.IsValidActor(partner)) )
			; Reserve slave and set end of scene event
			sexActors[partnerCount] = partner
			partner.AddToFaction(InSceneFaction)
			slotRef = SlaveRef(partner)
			slotref.SexHook = sexHook
			slotRef.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
			partnerCount += 1
			PHHSHInter.IncreaseSexTraining(partner, utility.RandomInt(2,4))
		endif
		i+=1
	endwhile

	sslBaseAnimation[] anims
	anims = DOMSexlab.GetAnimationsByTagsBase(partnerCount, "Aggressive,Forced", "", false)

	Actor[] selectedActors		; 13 lines of code because no dynamic arrays, seriously?
	if (partnerCount == 3)
		selectedActors = new Actor[3]
	elseif (partnerCount == 4)
		selectedActors = new Actor[4]
	elseif (partnerCount == 5)
		selectedActors = new Actor[5]
	endif
	i = 0
	while (i < partnerCount)
		selectedActors[i] = sexActors[i]
		i+=1
	endwhile

	DOMSexlab.QuickStartThreesome(SexActors[0], SexActors[1], SexActors[2], SexActors[3], SexActors[4], "" + sexHook)
EndFunction

PHHSHHouseSlave Function SlaveRef(Actor akRef)
	int n = HunterSlot.length
	int i
	if akRef.GetFactionRank(DOMSlaveManagerFaction) == 101 ; Hunter
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n
			if HunterSlot[i].GetActorRef() == akRef
				return HunterSlot[i] as PHHSHHouseSlave
			endif
		endif
	endif
	ReferenceAlias slot = None
	i = 0
	while i < n && slot == None
		if HunterSlot[i].GetActorRef() == akRef
			slot = HunterSlot[i]
		else
			i += 1
		endif
	endwhile
	if slot != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,101) ; 101 is HSH Hunter
		return slot as PHHSHHouseSlave
	endif

	n = TCampSlot.length
	if akRef.GetFactionRank(DOMSlaveManagerFaction) == 102 ; Camp
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n
			if TCampSlot[i].GetActorRef() == akRef
				return TCampSlot[i] as PHHSHHouseSlave
			endif
		endif
	endif
	i = 0
	while i < n && slot == None
		if TCampSlot[i].GetActorRef() == akRef
			slot = TCampSlot[i]
		else
			i += 1
		endif
	endwhile
	if slot != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,102) ; 102 is HSH Camp
		return slot as PHHSHHouseSlave
	endif

	return FlexiStorage.SlaveRef(akRef)
EndFunction

ReferenceAlias Function SlaveTarget(Actor akRef)
	int n = HunterSlot.length
	int i
	if akRef.GetFactionRank(DOMSlaveManagerFaction) == 101 ; Hunter
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n
			if HunterSlot[i].GetActorRef() == akRef
				return HunterTarget[i]
			endif
		endif
	endif
	ReferenceAlias target = None
	i = 0
	while i < n && target == None
		if HunterSlot[i].GetActorRef() == akRef
			target = HunterTarget[i]
		else
			i += 1
		endif
	endwhile
	if target != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,101) ; 101 is HSH Hunter
		return target
	endif
	
	n = TCampSlot.length
	if akRef.GetFactionRank(DOMSlaveManagerFaction) == 102 ; Camp
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n
			if TCampSlot[i].GetActorRef() == akRef
				return TCampTarget[i]
			endif
		endif
	endif
	i = 0
	while i < n && target == None
		if TCampSlot[i].GetActorRef() == akRef
			target = TCampTarget[i]
		else
			i += 1
		endif
	endwhile
	if target != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,102) ; 101 is HSH Camp
		return target
	endif

	return FlexiStorage.SlaveTarget(akRef)
EndFunction

int Function GetNSlotHunter()
	int n = HunterSlot.length
	int i = 0
	while i < n
		if HunterSlot[i].GetActorRef() == None
			return i
		endif
		i += 1
	endwhile
	return n
EndFunction

ReferenceAlias Function GetFreeSlotHunter()
	int n = HunterSlot.length
	int i = 0
	while i < n
		if HunterSlot[i] != None
			if HunterSlot[i].GetActorRef() == None
				return HunterSlot[i] as PHHSHHouseSlave 
			endif
		endif
		i += 1
	endwhile
	return None
EndFunction

int Function GetNTempCamp()
	int n = TCampSlot.length
	int k = 0
	int i = 0
	while i < n
		if TCampSlot[i] != None
			if TCampSlot[i].GetActorRef() != None
				k += 1
			endif
		endif
		i += 1
	endwhile
	return k
EndFunction

ReferenceAlias Function GetFreeSlotTempCamp()
	int n = TCampSlot.length
	int i = 0
	while i < n
		ReferenceAlias the_slot = TCampSlot[i]
		if the_slot != None
			if the_slot.GetActorRef() == None
				LogTrace("GetFreeSlotTempCamp found slot "+i+" = "+the_slot)
				return the_slot as PHHSHHouseSlave 
			endif
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function GetAssistantHunter()
	if (CheckRefGuardIsAvailable(HunterFunctions.Guard1))
		return HunterFunctions.Guard1
	elseif (CheckRefGuardIsAvailable(HunterFunctions.Guard2))
		return HunterFunctions.Guard2
	else
		return None
	endif
EndFunction

; Only disables / moves slaves, must be deregistered from HSH first
Function DeleteSlave(Actor slave)
	if (HasAygas)
		DeregisterSlave(slave)
		if (!Aygas.StoreSlave(slave))
			slave.Disable()
		endif
	else
		slave.Disable()
	endif
EndFunction


bool Function CheckRefSlaveIsAvailable(PHHSHHouseSlave slot)
	Actor slave = slot.getRef() as Actor	
	return ((slave != None) && (!slave.IsInFaction(WallChainFaction)) && (!slave.IsInFaction(HouseCagedFaction)) && (!slave.IsInFaction(InSceneFaction)) && (!slot.IsInOSAScene(slave)) && (!IsInSSScene(slave)) && (slot.SexHook < 0))
EndFunction

bool Function CheckRefGuardIsAvailable(ReferenceAlias slot)
	Actor guard = slot.getRef() as Actor
	if (guard.GetFactionRank(GuardFaction) < 0)
		guard.SetFactionRank(GuardFaction, 0)
	endif
	return ((guard != None) && (guard.GetFactionRank(GuardFaction) == 0))
EndFunction

; Call after changing equiped items
Function UpdateGear(Actor slave)
	phhshhouseslave slaveRef = SlaveRef(slave)
	if (slaveRef != none)
		slaveRef.EquipStored()
	endif
EndFunction

Function ActorMatchDirection(Actor slave)
	Objectreference marker = Game.FindClosestReferenceOfAnyTypeInListFromRef(ChainIdleMarkers ,slave,25)
	if (marker != none)
		debug.notification("Marker found")
	else
		debug.notification("No marker")
	endif
EndFunction 

String Function StruggleAnimation(String animName)
	if (animName == "ZapWriPose07")
		return "ZapWriStruggle07"
	elseif (animName == "ZapWriPose12")
		return "ZapWriStruggle12"
	elseif (animName == "ZapWriPose13")
		return "ZapWriStruggle13"
	elseif (animName == "ZapWriPose14")
		return "ZapWriStruggle14"
	elseif (animName == "ZapWriPose15")
		return "ZapWriStruggle15"
	elseif (animName == "ZapXCrossPose01")
		return "ZapXCrossStruggle01"
	elseif (animName == "ZapXCrossPose01b")
		return "ZapXCrossStruggle01"
	else
		return animName
	endif
EndFunction

Function DebugResetQuest()
EndFunction


Function DebugLog(String s)
	if (DebugLogging)
		LogTrace("HSH: " + s)
	endif
EndFunction

Event SSStripEnded(string eventName, string strArg, float numArg, Form sender)
;	Debug.MessageBox("Strip ended: " + sender)
EndEvent

Function SetMarkerConditionals(Actor slave)
	PHHSHHouseSlave slaveScript = SlaveRef(slave)
	if (slaveScript != None)
		DesignatedBedroom = (slaveScript.BedroomMarker != None)
		DesignatedHouse = (slaveScript.HouseMarker != None)
		DesignatedCell = (slaveScript.CellMarker != None)
	endif
	NearBedroomMarker = (Game.FindClosestReferenceOfTypeFromRef(BedroomMarkerAct, Game.GetPlayer(), 512) != None)
	NearHouseMarker = (Game.FindClosestReferenceOfTypeFromRef(HouseMarkerAct, Game.GetPlayer(), 512) != None)
	NearCellMarker = (Game.FindClosestReferenceOfTypeFromRef(CellMarkerAct, Game.GetPlayer(), 512) != None)
EndFunction

Function SetPlay(Actor slave, int role)	; 0=nothing, 1=dom, 2=sub
	if (role == 0)
		slave.RemoveFromFaction(PAHPlayFaction)
		Weapon trainingWhip = PHHSHInter.GetTrainingWhip()
		slave.RemoveItem(TrainingWhip, 1)
	elseif (role == 1)
		slave.SetFactionRank(PAHPlayFaction, 1)
		if (slave.GetFactionRank(TaskAssignedFaction) != 1)
			slaveRef(slave).Sandbox()
		endif
	elseif (role == 2)
		slave.SetFactionRank(PAHPlayFaction, 2)
	endif

	if ((role > 0) && (slave.GetFactionRank(TaskAssignedFaction) > 1))
		slave.RemoveFromFaction(TaskAssignedFaction)
	endif
EndFunction

string Function GreetAnim()
	LogTrace("GreetAnim")
	if (CustomGreeting != "")
		return CustomGreeting
	elseif (GreetType == 1)
		return "ZapWriPose07"
	elseif (GreetType == 2)
		return "ZapKneelDisplay"
	elseif (GreetType == 3)
		return "IdleGrave_01"
	else
		return "IdleGrave_02"
	endif
EndFunction

bool Function IsInPermaCell(Cell c)
	if (c != None)
		ReferenceAlias r = PortableFunctions.HoldingCellRefForCell(c)
		return ((r != none) && (r != PortableFunctions.TempCamp))
	else
		return false
	endif
EndFunction

Function SummonTaskmaster()
	Actor tm = Taskmaster.TaskmasterInCell(Game.GetPlayer().GetParentCell())
	if (tm != None)
		phhshHouseSlave tmScript = SlaveRef(tm)
		if (tmScript != None)
			if (tm.GetDistance(Game.GetPlayer()) < 150)
				; Dismiss
				debug.notification("Dismissing " + tm.GetDisplayName())
				tmScript.Sandbox()
			else
				; Summon
				AccompanyPlayer(tm)
				debug.notification("Summoning " + tm.GetDisplayName())
			endif
		endif
	endif
EndFunction

Function CopyTats(Actor slave)
	SlaveTatsFunctions.GetAppliedTats(slave)
	Debug.Notification("Copied tattoos")
EndFunction

Function SetNewTat()
	phhshPortableCellScript c = PortableFunctions.HoldingCellrefForCell(Game.GetPlayer().GetParentCell()) as phhshPortableCellScript
	if (c != None)
		c.TattooNew = SlaveTatsFunctions.CopyTatsToRef(c.TattooNew)
	endif
EndFunction

Function SetTrainTat()
	phhshPortableCellScript c = PortableFunctions.HoldingCellrefForCell(Game.GetPlayer().GetParentCell()) as phhshPortableCellScript
	if (c != None)
		c.TattooTrained = SlaveTatsFunctions.CopyTatsToRef(c.TattooTrained)
	endif
EndFunction


Function ClearNewTat()
	phhshPortableCellScript c = PortableFunctions.HoldingCellrefForCell(Game.GetPlayer().GetParentCell()) as phhshPortableCellScript
	if (c != None)
		SlaveTatsFunctions.ClearArrayRef(c.TattooNew)
	endif
EndFunction

Function ClearTrainTat()
	phhshPortableCellScript c = PortableFunctions.HoldingCellrefForCell(Game.GetPlayer().GetParentCell()) as phhshPortableCellScript
	if (c != None)
		SlaveTatsFunctions.ClearArrayRef(c.TattooTrained)
	endif
EndFunction

bool Function IsMilkDevice(ObjectReference furni)
	return DOMZaz.IsMilkingDevice(furni)
EndFunction

bool Function IsZbfDevice(ObjectReference furni)
	return DOMZaz.IsFurnitureDevice(furni)
EndFunction

bool Function IsItemNoMove(Form item)
	return DOMZaz.hasKeywordNoMove(item)
EndFunction

bool Function IsBusy(Actor slave)
	if PHHSHInter.IsActorActive(slave)
		return true
	endif
	return ( (slave.IsInFaction(HousePoseFaction )) || (slave.IsInFaction(WallChainFaction )) || (slave.IsInFaction(InSceneFaction)) || (IsInSSScene(slave)) || ((DisplayModelFaction != None) && (slave.IsInFaction(DisplayModelFaction) )) )
EndFunction

bool Function IsInSSScene(Actor a)
	return (ActorUtil.CountPackageOverride(a) > 0)
EndFunction

Function CheckActorAliases()
	;LogTrace("CheckActorAliases checking DOM pointers for Hunter's slots")
	int n = HunterSlot.length
	int i = 0
	int k = 0
	LogTrace("CheckActorAliases checking DOM pointers array size="+n)
	While i < n
		DOM_Actor akActor = HunterSlot[i] as DOM_Actor
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
		if akActor.target != HunterTarget[i]
			;LogTrace("CheckActorAliases alias "+i+" actor's target was not correctly set!")
			akActor.target = HunterTarget[i]
			;k += 1
		endif
		DOM_Mind akMind = HunterSlot[i] as DOM_Mind
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
		PHHSHHouseSlave akSlave = HunterSlot[i] as PHHSHHouseSlave
		if akSlave.SlaveTarget != HunterTarget[i]
			;LogTrace("CheckActorAliases alias "+i+" target was not correctly set!")
			akSlave.SlaveTarget = HunterTarget[i]
			;k += 1
		endif
		akSlave.GetHomeCell()
		i += 1
	EndWhile	
	if k == 0
		LogTrace("CheckActorAliases All DOM pointers are OK for Hunter's slots")
	else
		LogTrace("CheckActorAliases Found "+k+" wrong DOM pointers! Corrected")
	endif
	
	;LogTrace("CheckActorAliases checking DOM pointers for Camp's slots")
	n = TCampSlot.length
	i = 0
	k = 0
	LogTrace("CheckActorAliases checking DOM pointers array size="+n)
	While i < n
		DOM_Actor akActor = TCampSlot[i] as DOM_Actor
		if akActor.DOM01 != DOM01
			LogTrace("CheckActorAliases alias "+i+" actor was not correctly set!")
			akActor.DOM01 = DOM01
			k += 1
		endif
		DOM_Mind akMind = TCampSlot[i] as DOM_Mind
		if akMind.DOM01 != DOM01
			LogTrace("CheckActorAliases alias "+i+" mind was not correctly set!")
			akMind.DOM01 = DOM01
			k += 1
		endif
		PHHSHHouseSlave akSlave = TCampSlot[i] as PHHSHHouseSlave
		if akSlave.SlaveTarget != TCampTarget[i]
			LogTrace("CheckActorAliases alias "+i+" target was not correctly set!")
			akSlave.SlaveTarget = TCampTarget[i]
			k += 1
		endif
		i += 1
	EndWhile	
	if k == 0
		LogTrace("CheckActorAliases All DOM pointers are OK for Camp's slots")
	else
		LogTrace("CheckActorAliases Found "+k+" wrong DOM pointers! Please Correct")
	endif
EndFunction

DOM_Actor Function AddSlaveToDOM(Actor slave)
	ClearNoEnslave(slave)
	int rank = -1
	if slave.IsInFaction(DOMHistoryFaction)
		rank = slave.GetFactionRank(DOMHistoryFaction)
	endif
	if PHHSHInter.PAH == None || (rank >= 0 && rank < 10) ; Move back to DOM
		if rank >= 10
			slave.SetFactionRank(DOMHistoryFaction,rank-(10))
		endif
		return DOM01.MoveNPCToDOM(slave)
	elseif rank >= 10
		slave.SetFactionRank(DOMHistoryFaction,rank-(10))
	endif
	PHHSHInter.AddSlaveToPAH(slave)
	return None
EndFunction

Function RemoveSlaveFromDOM(Actor slave)
	LogTrace("RemoveSlaveFromDOM slave="+slave)
	if slave == None
		return
	endif
	if StupidVampireThrallFaction != None
		slave.RemoveFromFaction(StupidVampireThrallFaction)
	endif
	if slave.IsInFaction(DOMActorFaction)
		int rank = -1
		if slave.IsInFaction(DOMHistoryFaction)
			rank = slave.GetFactionRank(DOMHistoryFaction)
		endif
		if rank >= 10
			slave.SetFactionRank(DOMHistoryFaction,rank-(10))
		endif
		DOM_Actor akActor = DOM01.GetActor(slave)
		if akActor != None
			slave.SetFactionRank(DOMActorInTransfer,1) ; transfer to DOM manager
			akActor.SetRestoreOutfitOnRelease(false)
			DOM01.ReleaseAlias(akActor)
			SetNoEnslave(slave)
			return
		endif
	endif
	PHHSHInter.RemoveSlaveFromPAH(slave)
EndFunction

Function SetNoEnslave(Actor slave)
	slave.AddToFaction(DOMActorExcludedFaction)
	PHHSHInter.SetNoEnslavePAH(slave)
EndFunction

Function ClearNoEnslave(Actor slave)
	slave.RemoveFromFaction(DOMActorExcludedFaction)
	PHHSHInter.ClearNoEnslavePAH(slave)
EndFunction

bool Function SlaveCanGuard(Actor slave)
	if slave == None
		return false
	endif
	if slave.GetFactionRank(DOMTrainCombat) >= 50
		if slave.GetFactionRank(DOMTrainSubmission) >= 70
			return true
		endif
		if slave.GetFactionRank(DOMTrainResignation) >= 70
			return true
		endif
	endif
	return PHHSHInter.PAHSlaveCanGuard(slave)
EndFunction

bool Function SlaveNeedsEscort(Actor slave)
	if slave == None
		return false
	endif
	if slave.GetFactionRank(DOMTrainResignation) < 70 &&  slave.GetFactionRank(DOMTrainSubmission) < 70
		return true
	endif
	return PHHSHInter.PAHSlaveNeedsEscort(slave)
EndFunction

Function SendAnimationEvent(Actor akTarget, string animation)
	if DOM01.verboseAnim
		Debug.Trace("PHHSHStorageFunctions:Animation: "+animation+" for "+akTarget)
	endif
	debug.sendanimationevent(akTarget, animation)
EndFunction

Function LogInfo(string msg)
	Debug.Trace("PHHSHStorageFunctions: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("PHHSHStorageFunctions: "+msg)
	endif
EndFunction

PHHSHHunterOperation Property HunterFunctions Auto

Actor Property PlayerRef Auto
ReferenceAlias Property PlayerAlias Auto

ReferenceAlias[] Property HunterSlot Auto
ReferenceAlias[] Property HunterTarget Auto
ReferenceAlias[] Property TCampSlot Auto
ReferenceAlias[] Property TCampTarget Auto

ReferenceAlias Property NominatedTrainer Auto

Faction Property TravelingFaction Auto
Faction Property WaitingFaction Auto
Faction Property AccompanyFaction Auto
Faction Property HouseSlaveFaction Auto
Faction Property HouseFixedOutfit Auto
Faction Property HouseCagedFaction Auto
Faction Property HousePoseFaction Auto
Faction Property HouseFreeSexFaction Auto
Faction Property NakedFaction Auto
Faction Property InSceneFaction Auto
Faction Property IsTrainerFaction Auto
Faction Property IsTraineeFaction Auto
Faction Property IsDesignatedTrainerFaction Auto		; 1 = eligible(has trained 1 slave), 2 = active
Faction Property TrainingExemptFaction Auto
Faction Property OnRackFaction Auto
Faction Property TrainerDoneFaction Auto
Faction Property TrainerPunishingFaction Auto
Faction Property RestrainedFaction Auto
Faction Property WallChainFaction Auto
Faction Property SandboxFaction Auto
Faction Property GuardFaction Auto
Faction Property AuctionFaction Auto
Faction Property PAHHouseReservedFaction Auto
Faction Property DoNotWhip Auto
Faction Property RunningAway Auto
Faction Property FollowerFaction Auto
Faction Property PAHHunterVendorFaction Auto
Faction Property PlayerFaction  Auto  
Faction Property PlayerAllyFaction  Auto  
Faction Property PlayerFollowerFaction  Auto  
Faction Property TaskmasterFaction Auto
Faction Property TaskAssignedFaction Auto
Faction Property HouseCarlFaction Auto
Faction Property PAHPlayFaction Auto	; 1=dom, 2=sub
Faction Property PAHHasAygasGold Auto
Faction Property DisplayModelFaction Auto Hidden

int Property GreetType=-1 Auto Hidden		; -1 not set, 0 kneel, 1 submissive, 2 bow
bool Property FollowersAggro=true Auto Hidden
bool Property SubmissiveGreet=true Auto Hidden
bool Property UseBdsmMarkers=true Auto conditional Hidden
bool Property DisableBdsm=false Auto conditional Hidden
bool Property AlternateInventory=false Auto Hidden
bool Property DebugLogging=false Auto Conditional Hidden
bool Property SkipQuests=false Auto Conditional Hidden
bool Property SpawnFurniture=true Auto Hidden
bool Property GreetOwner=true Auto Conditional Hidden
bool Property UseSerialStrip=true Auto Conditional Hidden
bool Property UseBanditSlaves=false Auto Hidden
bool Property ControlPAHSlaves=true Auto Conditional Hidden
bool Property FrameworkHandlesTorture=true Auto Conditional Hidden
int Property ArousedFollowerThreshold=70 Auto Hidden
String Property CustomGreeting Auto Hidden
int Property SummonTaskmasterKey=-1 Auto Hidden
bool Property ExitGreeting Auto Hidden
bool Property DoCombatTraining=true Auto Hidden
bool Property NonLinearTraining=true Auto Hidden

int Property TraineeFactionRank Auto Conditional Hidden
bool Property CanTrainSex Auto Conditional Hidden
bool Property CanTrainObedience Auto Conditional Hidden
bool Property CanTrainCombat Auto Conditional Hidden
bool Property CanTrainRespect Auto Conditional Hidden
bool Property CanTrainPose Auto Conditional Hidden

bool Property CanTrain Auto Conditional Hidden
bool Property SexTrained Auto Conditional Hidden

FormList Property ChainIdlemarkers Auto

Armor Property dummyArmor  Auto 
Armor Property WristRopes3  Auto 
Armor Property WristChains2  Auto 
Armor Property Collar Auto 
Armor Property Yoke Auto 
Armor Property LegChains  Auto 
Armor Property AuctionToken Auto
Armor Property AuctionSpawnedToken Auto

Key Property CellKey Auto
QF_PAHOKidnapping_060228C3 Property DebugQuest Auto
PHHSHEconomics Property Economics Auto
PAHOPortable Property PortableFunctions Auto
PHHSHHavokHandling Property HavokFunctions Auto
PHHSHNearbyActorScript Property ActorDetector Auto
phhshOffsetRestraints Property RestraintsFunctions Auto
phhshAygas Property Aygas Auto
phhshITF Property ITF Auto
phhshSS Property SS Auto
phhshSLAL Property SLAL Auto
phhshSceneSLA Property ScenesSLA Auto
phhshDisplayModel Property DMFunctions Auto
phhshMME Property MMEFunctions Auto
phhshSlaveTats Property SlaveTatsFunctions Auto

Container Property TransferBox Auto

Quest Property QstNobleDesires Auto
PHHSHFlexiStorage Property FlexiStorage Auto
phhshTaskmaster Property Taskmaster Auto

Faction Property OSAFaction Auto Hidden
bool Property HasHereticalResources = false Auto Conditional Hidden
bool Property HasSerialStrip = false Auto Hidden
bool Property HasFnisSpells = false Auto Conditional Hidden
bool Property HasZazExtension = false Auto Conditional Hidden
bool Property HasZaz622p = false Auto Conditional Hidden
bool Property HasTaraPack = false Auto Conditional Hidden
bool Property HasTaraAnims = false Auto Conditional Hidden
bool Property HasTaraAnims2 = false Auto Conditional Hidden		; For the ZAZ intergrated version
bool Property HasTortureFramework = false Auto Hidden
bool Property HasZaz8 = false Auto Conditional Hidden		; Tara's combined ZAP + furni pack
int Property Zaz8Version = -1 Auto Conditional Hidden
bool Property HasAygas = false Auto Hidden
bool Property HasSlaveCart = false Auto Conditional Hidden
bool Property HasMME = false Auto Conditional Hidden
bool Property HasSlaveTats = false Auto Conditional Hidden

Activator Property BedroomMarkerAct Auto
Activator Property HouseMarkerAct Auto
Activator Property CellMarkerAct Auto

Activator Property HR_HavocChain Auto Hidden
bool Property HR_isNearWallChain Auto Conditional Hidden
bool Property HR_isNearWallChain2 Auto Conditional Hidden
ObjectReference Property HR_NearbyWallChain Auto Hidden
ObjectReference Property HR_NearbyWallChain2 Auto Hidden

FormList Property DisplayModelFurniture Auto Hidden		; Used in this mod

bool Property DesignatedBedroom Auto Conditional Hidden
bool Property DesignatedHouse Auto Conditional Hidden
bool Property DesignatedCell Auto Conditional Hidden

bool Property NearBedroomMarker Auto Conditional Hidden
bool Property NearHouseMarker Auto Conditional Hidden
bool Property NearCellMarker Auto Conditional Hidden

bool Property HasCopiedTattoos Auto Conditional Hidden
bool Property HouseHasNewTattoos Auto Conditional Hidden
bool Property HouseHasTrainedTattoos Auto Conditional Hidden

bool Property TransferInProgress Auto Conditional

FormList Property ListTables Auto
int Property PoseOnFurniture Auto Conditional Hidden

bool Property HasThreesomeSexPartner Auto Conditional Hidden
Perk Property ChainTalkPerk Auto
Spell Property PlaceChain Auto
Spell Property PlaceRing2 Auto
MiscObject Property Gold Auto

Weapon Property SparWeapon Auto

Furniture Property FurniStraddle Auto
Furniture Property FurniSit Auto

Form Property Serana Auto Hidden
Faction Property DOMAliasIndexFaction Auto
Faction Property DOMSlaveManagerFaction Auto
