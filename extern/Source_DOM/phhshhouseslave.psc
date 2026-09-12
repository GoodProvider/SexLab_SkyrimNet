Scriptname PHHSHHouseSlave extends ReferenceAlias  
Import Utility

int secsPerTick = 1		; Set between 1-3
int behaviorEvalNrTicks = 30	; Nr of ticks between evaluation for behavior, set > 10 

string LastAnim
ObjectReference NextMarker

Event AfterAssign()
	LogTrace("AfterAssign")
	AfterAssignWithType(0)
endevent

Event AfterAssignWithType(int itype)	
	Actor akRef = GetActor()
	LogTrace("AfterAssignWithType type="+itype+" akRef="+akRef)
;	debug.notification("Assigned at level:" + PHSF.PHHSHInter.GetSubmissionTraining(GetActor())
	akRef.RemoveFromFaction(PHSF.WaitingFaction)
	akRef.RemoveFromFaction(PHSF.DoNotWhip)
	akRef.RemoveFromFaction(PHSF.RunningAway)
	akRef.RemoveFromFaction(PHSF.FollowerFaction)		; Being follower causes issues with AFT sometimes
	akRef.RemoveFromFaction(PHSF.HouseFixedOutfit)

	SetInitialBehaviour()
	Name = ""
	IsDressingCounter = 0
	RepositionTicks = 0
	ZbfRefreshTicks = 0
	FurnitureInUse = None
	SexHook = -1
	CheckName()
	
	LastCell = akRef.GetparentCell()
	SlaveTarget.Clear()
	StoreOutfit(true)
	IsDressingCounter = 5		; Disable updates on item add / removal

	; Grab all items from the slave and give them back. This ensures that invisible "outfit" items now shop up in the inventory
	if (PHSF.AlternateInventory)
		ObjectReference c = akRef.PlaceAtme(PHSF.TransferBox)
		c.MoveTo(akRef, 0, 0, -1000, false)
;		c.Disable()
		akRef.RemoveAllItems(c, true, true)	; Move items to box
		akRef.SetOutfit(None, None);		; Clear outfit
		int i = c.GetNumItems()				; Copy items from box, this ensures items are not invisible
		while (i>0)
			i -= 1
			Form f = c.GetNthForm(i)
			int cnt = c.GetItemCount(f)
			akRef.AddItem(f, cnt)
		endwhile
		c.delete()
	endif
	RestoreOutfit()
	IsDressingCounter = 0;
	CheckOutfit()

	Faction DLC1ThrallFaction = Game.GetFormFromFile(0x162F7, "Dawnguard.esm") As Faction
	If DLC1ThrallFaction
		akRef.RemoveFromFaction(DLC1ThrallFaction)
	endif

	BedroomMarker = None
	HouseMarker = None
	CellMarker = None

	if ((!akRef.IsInInterior()) || (akRef.GetParentCell() == Game.GetPlayer().GetParentCell()))		; Always pick markers when adding to a camp to prevent wandering.  Also when in same cell as player
		PickDefaultMarkers()
	endif

	akRef.AllowPCDialogue(true)
	RegisterForSingleUpdate(secsPerTick)
	
	if itype == 0 ||itype < 100 ; try to set from Faction
		itype = akRef.GetFactionRank(PHSF.DOMSlaveManagerFaction)
		if itype < 100
			itype = 100
		endif
	endif
	PHSF.PHHSHInter.Assign(self,itype)
EndEvent

Function PickDefaultMarkers()
	Actor slave = GetActorRef()

	BedroomMarker = Game.FindClosestReferenceOfTypeFromRef(PHSF.BedroomMarkerAct, slave, 5000)
	HouseMarker = Game.FindClosestReferenceOfTypeFromRef(PHSF.HouseMarkerAct, slave, 5000)
	CellMarker = Game.FindClosestReferenceOfTypeFromRef(PHSF.CellMarkerAct, slave, 5000)
EndFunction


Function ClearDefaultMarkers()
	BedroomMarker = None
	HouseMarker = None
	CellMarker = None
EndFunction

Function DoClear()
	DOM_Actor akActor = (self as ReferenceAlias) as DOM_Actor
	LogTrace("DoClear self="+self)
	LogTrace("DoClear before DOM_Actor="+akActor)
	BeforeClear()
	LogTrace("DoClear after DOM_Actor="+akActor)
	;if akActor == None
		LogTrace("DoClear calling DOM_Actor "+akActor)
		akActor.DoClear()
	;else
	;	LogTrace("DoClear no DOM_Actor found "+akActor)
	;	Clear()
	;endif
EndFunction

Event BeforeClear()
	LogTrace("BeforeClear")
;	debug.notification("Deassigned")

	Actor slave = GetActor()
	if (trainer != None)
		PHSF.ReleaseTrainee(trainer, false)
		trainer = None
	endif

	if (slave == None)
		trainee = None
		return
	endif

	UnregisterForUpdate()

	SlaveTarget.Clear()
	StopPosing(slave)

	if (trainee != None)
		PHSF.ReleaseTrainee(slave, false)
		trainee = None
	endif

	if (!DoNotClearFactions)
		slave.RemoveFromFaction(PHSF.AccompanyFaction)
		slave.RemoveFromFaction(PHSF.HouseSlaveFaction)
		slave.RemoveFromFaction(PHSF.HouseCagedFaction)
		slave.RemoveFromFaction(PHSF.HousePoseFaction)
		slave.RemoveFromFaction(PHSF.InSceneFaction)
		slave.RemoveFromFaction(PHSF.OnRackFaction)
		slave.RemoveFromFaction(PHSF.IsTrainerFaction)
		slave.RemoveFromFaction(PHSF.IsTraineeFaction)
		slave.RemoveFromFaction(PHSF.TrainerPunishingFaction)
		slave.RemoveFromFaction(PHSF.RestrainedFaction)
		slave.RemoveFromFaction(PHSF.WallChainFaction)
		slave.RemoveFromFaction(PHSF.PAHHouseReservedFaction )
		slave.RemoveFromFaction(PHSF.DoNotWhip)
		slave.RemoveFromFaction(PHSF.RunningAway)
	endif
	slave.SetDontMove(false)

	FurnitureInUse = None
	ClearDefaultMarkers()

	PoseAnim = ""
	PoseFurnitureMarker = None
	RepositionTicks = 0

	slave.SetHeadTracking(false)
	slave.ClearLookAt()
	PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
EndEvent

Event OnCellAttach()
	GetActorRef().EnableAI()
	IsDressingCounter = 5
	UnregisterForUpdate()
	LastAnim = ""
	Actor slave = GetActor()
	if (slave != None)
		DetachingHavok = true
		CheckName()
		Cell currentCell = slave.GetparentCell()
		if ((currentCell != None) && (!currentCell.IsInterior() ))
			; Check if slave is in their assigned cell
			if (currentCell != LastCell)
				; Check if slave is in a valid cell
				if (PHSF.PortableFunctions.HoldingCellrefForCell(currentCell) == None)
					debug.notification(slave.getDisplayname() + " out of camp, attempting teleport...")
					homeCell = PHSF.PortableFunctions.HoldingCellrefForCell(LastCell) as PHHSHPortableCellScript
					;if ((homeCell != None) && (homeCell.GetRef() != None))
						slave.MoveTo(homeCell.GetRef(), 0, 0, 0, false)
					;else
					;	slave.SetFactionRank(PHSF.AccompanyFaction, 2)		; Force slave to travel to player
					;endif
				else
					;debug.notification(slave.getDisplayname() + " not in assigned cell")
					LastCell = slave.GetParentCell()
				endif
			endif
		endif

		PHSF.DebugLog("Slave " + slave.GetDisplayName() + " attached to cell")

		if (!slave.IsEnabled())
			PHSF.DebugLog("Slave " + slave.GetDisplayName() + "  is disabled?!  Removing from slot...")
			Debug.Notification("Slave " + slave.GetDisplayName() + " is disabled! This can cause problems.  Slave has been removed from the house slot")

			slave.Enable()
			slave.MoveTo(Game.GetPlayer())
			return
		endif

		if (PoseFurnitureMarker != None)
			float zr = slave.GetAngleZ()
			PoseFurnitureMarker.MoveTo(slave, -math.sin(zr)*5, -math.cos(zr)*5, 3, true)
		endif
		


		;PHSF.UpdateGear(slave)
		RestoreOutfit()
		inhibitKneelTicks = 0
		RegisterForSingleUpdate(secsPerTick)
		if ((slave.IsInFaction(PHSF.IsTrainerFaction)) && (trainee != None))
			if ((!slave.IsInFaction(PHSF.AccompanyFaction)) && (!slave.IsInFaction(PHSF.HouseCagedFaction)) && (slave.GetFactionRank(PHSF.TrainerPunishingFaction) != 0))
				PHSF.ClearFromScene(slave, false)
			endif
		endif

		if ((slave.GetFactionRank(PHSF.WallChainFaction) == 9) && (PHSF.DisplayModelFurniture != None))
			PHSF.DMFunctions.DMReleaseActor(slave)
		elseif (FurnitureInUse != None)
			if (slave.GetfactionRank(PHSF.WallChainFaction) == 5)
;				debug.notification("Reactivate furniture")
				slave.RemoveFromFaction(PHSF.WallChainFaction)
				slave.EvaluatePackage()
				slave.SetfactionRank(PHSF.WallChainFaction, 5)
				slave.EvaluatePackage()
			elseif (PHSF.IsZbfDevice(FurnitureInUse))
				utility.wait(2)
;				debug.notification("Reseat furniture")
				SlaveTarget.ForceRefTo(FurnitureInUse)
				RestrainAtMarker("", 5, false)
			endif
		elseif (slave.GetfactionRank(PHSF.WallChainFaction) == 8)
			BindToChains(RestrainedAnim, true)
		elseif (((slave.IsInFaction(PHSF.HousePoseFaction)) || (behaviour == "wait_anim")) && (PoseAnim != ""))
			PHSF.PHHSHInter.SendAnimationEvent(slave, PoseAnim)
		else
			slave.RemoveFromFaction(PHSF.InSceneFaction)
			slave.AllowPCDialogue(true)
		endif

		SexHook = -1
	endif
	DetachingHavok = false
EndEvent

Event OnAttachedToCell()
	OnCellAttach()
EndEvent

Cell Function GetCell()
	Cell c = GetActorRef().GetParentCell()
	if (c != None)
		return c
	else
		return LastCell
	endif
EndFunction

Event OnItemAdded(Form baseItem, int itemCount, ObjectReference objRef, ObjectReference sourceContainer)
	if baseItem == none
		return
	endif
	if baseItem.GetType() == 46
		return
	endif
	if PHSF.DOMZAD.hasKeywordDevice(baseItem)
		return ; do not equip ZAD devices
	endif
	GetActor().EquipItem(baseItem, true, true)
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if (!IsDressingCounter)
		CheckOutfit()
	endif
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if (!IsDressingCounter)
		CheckOutfit()
	endif
EndEvent


Event OnCellDetach()
;	StoreOutfit()

	Actor slave = GetActorRef()
	IsDressingCounter = 5; 			
	CheckName()
	UnregisterForUpdate()
	hasGreeted = false
	hasGreetedGuest = false
	EntertainTicks = 0
	RepositionTicks = 0
	SexHook = -1
	if ((PoseAnim == "") || (PHSF.PHHSHInter.GetPoseTraining(slave) < 50))
		StopPosing(slave)
	endif
	slave.RemoveFromFaction(PHSF.InSceneFaction)
	if ((behaviour=="punishing") || (slave.IsInFaction(PHSF.TaskAssignedFaction) == 1) )
		PHSF.TaskMaster.RemoveFromTask(slave)
		Sandbox()
	elseif (behaviour=="restrained")
		if (slave.IsInFaction(PHSF.IsTraineeFaction))
			SlaveTarget.ForceRefTo(trainer)
			FollowTarget()
		else
			Sandbox()
		endif
	endif

	AdjustRelationshipRank()

	utility.wait(5)
	; Disable AI if cell not loaded
	if ((slave.GetparentCell() == None) || (!slave.GetparentCell().IsAttached()))
		slave.EnableAI(false)
	endif
EndEvent

Event OnDeath(actor akKiller)
	debug.notification("Your slave " + GetRef().GetDisplayName() + " died!")
	DoClear()
EndEvent

int nhit_training = 0
float submission_training  = 0.0
float resignation_training = 0.0
float humiliation_training = 0.0

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
  bool abBashAttack, bool abHitBlocked)
	Actor slave = GetActorRef()
	;debug.notification("Hit:" + slave.GetDisplayName()+" "+nhit_training)
	if (utility.Randomint(1,4) == 1)
		PHSF.FlexiStorage.SlaveExclaim(slave)
	endif
EndEvent

Event OnActivate(ObjectReference akActionRef)
	; Actor activates themselves after reaching a bondage marker
	if ((WaitingForArrival==1) && (akActionRef != Game.GetPlayer()))
;		debug.notification("Activated on marker")
		WaitingForArrival = 2
		if ((trainer != None) && (PHSF.SlaveRef(trainer) != None ))
			PHSF.SlaveRef(trainer).TraineeArrived = true
		endif
	elseif ((WaitingForArrival==-1) && (akActionRef != Game.GetPlayer()))
		GetActorRef().SetDontMove(false)
		WaitingForArrival = 1
	elseif (akActionRef == Game.GetPlayer())

	endif
endEvent

Event OnUpdate()
	UnregisterForUpdate()
	Actor slave = GetActorRef()
	if (slave != None)
		if (!slave.GetParentCell().IsAttached())
			return
		endif

		if (trainer != None)
			ReferenceAlias TrainerScript = PHSF.SlaveRef(trainer)
			if ((TrainerScript == None) || (TrainerScript.getRef() == None))
				trainer == None
			endif
		endif

		if (inhibitKneelTicks > 0)
			inhibitKneelTicks -= 1
		endif
		if (isDressingCounter > 0);
			isDressingCounter -= 1
		endif

		if (OffsetRestraintSecs > 0)
			OffsetRestraintSecs -= 1
			if ((OffsetRestraintSecs == 0) && (OffsetRestraint != None))
				slave.UnequipItem(OffsetRestraint, false, true)
				slave.RemoveItem(OffsetRestraint, 1)
				OffsetRestraint = None
				slave.RemoveFromFaction(PHSF.InSceneFaction)
				utility.wait(0.5)
				EquipStored()
			endif
		endif

		if (RepositionTicks > 0)
			RepositionTicks -= 1
			if ((RepositionTicks == 0) && (FurnitureInUse != None))
				GetActorRef().TranslateToRef(FurnitureInUse, 500)
			endif
		endif

;		BehaviorEvalTicks += 1    ; Call in loop from cell
;		if (BehaviorEvalTicks >= behaviorEvalNrTicks)	; Randomize interval to ensure no overlap
;			BehaviorEvalTicks = utility.Randomint(-5, 5)
;			EvaluateBehavior()
;		endif

		CheckName(false)
		BehaviourOnUpdate()
		RegisterForSingleUpdate(secsPerTick)
	else
		PHSF.DebugLog("House slave got update on null reference alias")
	endif
EndEvent



Event OnSit(Objectreference furn)
	Actor slave = GetActorRef()
	FurnitureInUse = furn

	if (WaitingForArrival==1)
		WaitingForArrival = 2
		if ((trainer != None) && (PHSF.SlaveRef(trainer) != None ))
			PHSF.SlaveRef(trainer).TraineeArrived = true
		endif
;		debug.notification("Yoink")
	elseif (slave.IsDoingFavor())
; TODO: Set target to furniture and reactivate when entering cell
		utility.wait(2)
;		debug.notification("Sitting")
;		GoOnRack()
		GetActor().SetDontMove()
		Wait()
		GetActor().SetDontMove()
		slave.SetDoingFavor(false)
	endif

	if (PHSF.IsZbfDevice(furn))
		RepositionTicks = Math.Floor(3 / SecsPerTick) + 1

	endif
EndEvent


event OnSLAnimationEnd(string eventName, string argString, float argNum, form sender)
	if ((eventName == "AnimationEnd_" + SexHook) || (eventName == "AnimationEnd_Slave"))
;		debug.notification("Valid End " + eventName + " on " + GetActorRef().GetDisplayName())
		PunishmentTicks = 0	
		Actor slave = GetActor()
		slave.RemoveFromFaction(PHSF.InSceneFaction)
		UnregisterForModEvent("OnAnimationEnd_" + SexHook)
		UnregisterForModEvent("OnAnimationEnd_Slave")
		SexHook = -1
	endif
endevent

; Adds a restraint to the slave.  If secs > 0, the restraint will be removed automatically after ecs
Function AddOffsetRestraint(Form restraint, int secs)
	Actor slave = GetActorRef()
	slave.AddItem(restraint, 1)
	if (secs > 0)
		OffsetRestraint = restraint
		OffsetRestraintSecs = secs / SecsPerTick
	endif
EndFunction

Function BindToChains(string anim = "", bool isReattach = false)
	Actor AttachedActor = GetActorRef()
	DetachingHavok = true

	if (isReattach)
		PHSF.PHHSHInter.SendAnimationEvent(AttachedActor, "IdleForceDefaultState")
		AttachedActor.PushActorAway(AttachedActor, 0.0)
		AttachedActor.SetAV("Paralysis", 0)
		utility.wait(8)
	endif
;	utility.wait(0.5)

	; Go into ragdoll mode, paralyze to prevent getting up again, and link to the chain
	AttachedActor.PushActorAway(AttachedActor, 0.0)
	AttachedActor.SetAV("Paralysis", 1)

	; Attach all the chains
	if (ChainWristL != None)
		(ChainWristL as HR_HavokChainScript).Useable = false
		(ChainWristL as HR_HavokChainScript).AttachedActor = AttachedActor 
		(ChainWristL as HR_HavokChainScript).AttachActorBone("NPC L Hand [LHnd]")
	endif
	if (ChainWristR != None)
		(ChainWristR as HR_HavokChainScript).Useable = false
		(ChainWristR as HR_HavokChainScript).AttachedActor = AttachedActor 
		(ChainWristR as HR_HavokChainScript).AttachActorBone("NPC R Hand [RHnd]")
	endif
	if (ChainAnkleL != None)
		(ChainAnkleL as HR_HavokChainScript).Useable = false
		(ChainAnkleL as HR_HavokChainScript).AttachedActor = AttachedActor 
		(ChainAnkleL as HR_HavokChainScript).AttachActorBone("NPC L Foot [Lft ]")
	endif
	if (ChainAnkleR != None)
		(ChainAnkleR as HR_HavokChainScript).Useable = false
		(ChainAnkleR as HR_HavokChainScript).AttachedActor = AttachedActor 
		(ChainAnkleR as HR_HavokChainScript).AttachActorBone("NPC R Foot [Rft ]")
	endif
	if (ChainNeck != None)
		(ChainNeck as HR_HavokChainScript).Useable = false
		(ChainNeck as HR_HavokChainScript).AttachedActor = AttachedActor 
		(ChainNeck as HR_HavokChainScript).AttachActorBone("NPC Neck [Neck]")
	endif

	if (anim != "")
		; Get the actor out of Paralysis to assume a normal stance
		utility.wait(0.5)
		AttachedActor.PushActorAway(AttachedActor, 0.0)		; Needed to nudge actor into getting up
		utility.wait(2)	; was 2.0
		AttachedActor.SetAV("Paralysis", 0)
		utility.wait(1)	; was 1.0
		AttachedActor.SetAV("Paralysis", 1)			; Paralyze actor before he got up completely.  This takes effect only after the stand up anim completes

		; Wait for the actor to get up, and set the pose
;		utility.wait(6.0)
		PHSF.PHHSHInter.SendAnimationEvent(AttachedActor, "IdleForceDefaultState")
		if (anim != "IdleForceDefaultState")
			utility.wait(0.5)
			PHSF.PHHSHInter.SendAnimationEvent(AttachedActor, anim)
		endif
	endif
	DetachingHavok = false
EndFunction

Function DetachFromHavokChain(bool retainRefs = false)
	if ((ChainWristL != None) || (ChainWristR != None) || (ChainAnkleL != None) || (ChainAnkleR != None) || (ChainNeck != None))
		DetachingHavok = true
		Actor slave = GetActorRef()

		; Remember some variables in case we have to

;		utility.wait(1)
		slave.PushActorAway(slave, 0.0)
;		utility.wait(5)
		utility.wait(1)

		; Detach chains
		if (ChainWristL != None)
			Game.RemoveHavokConstraints(slave, "NPC L Hand [LHnd]", ChainWristL, (ChainWristL as HR_HavokChainScript).ChainAttachNode)
			(ChainWristL as HR_HavokChainScript).AttachedActor = None
		endif
		if (ChainWristR != None)
			Game.RemoveHavokConstraints(slave, "NPC R Hand [RHnd]", ChainWristR, (ChainWristR as HR_HavokChainScript).ChainAttachNode)
			(ChainWristR as HR_HavokChainScript).AttachedActor = None
		endif
		if (ChainAnkleL != None)
			Game.RemoveHavokConstraints(slave, "NPC L Foot [Lft ]", ChainAnkleL, (ChainAnkleL as HR_HavokChainScript).ChainAttachNode)
			(ChainAnkleL as HR_HavokChainScript).AttachedActor = None
		endif
		if (ChainAnkleR != None)
			Game.RemoveHavokConstraints(slave, "NPC R Foot [Rft ]", ChainAnkleR, (ChainAnkleR as HR_HavokChainScript).ChainAttachNode)
			(ChainAnkleR as HR_HavokChainScript).AttachedActor = None
		endif
		if (ChainNeck != None)
			Game.RemoveHavokConstraints(slave, "NPC Neck [Neck]", ChainNeck, (ChainNeck as HR_HavokChainScript).ChainAttachNode)
			(ChainNeck as HR_HavokChainScript).AttachedActor = None
		endif

		; Wake up slave
		slave.SetAV("Paralysis", 0)
		utility.wait(8)

		; Detach again just in case
		if (ChainWristL != None)
			Game.RemoveHavokConstraints(slave, "NPC L Hand [LHnd]", ChainWristL, (ChainWristL as HR_HavokChainScript).ChainAttachNode)
		endif
		if (ChainWristR != None)
			Game.RemoveHavokConstraints(slave, "NPC R Hand [RHnd]", ChainWristR, (ChainWristR as HR_HavokChainScript).ChainAttachNode)
		endif
		if (ChainAnkleL != None)
			Game.RemoveHavokConstraints(slave, "NPC L Foot [Lft ]", ChainAnkleL, (ChainAnkleL as HR_HavokChainScript).ChainAttachNode)
		endif
		if (ChainAnkleR != None)
			Game.RemoveHavokConstraints(slave, "NPC R Foot [Rft ]", ChainAnkleR, (ChainAnkleR as HR_HavokChainScript).ChainAttachNode)
		endif
		if (ChainNeck != None)
			Game.RemoveHavokConstraints(slave, "NPC Neck [Neck]", ChainNeck, (ChainNeck as HR_HavokChainScript).ChainAttachNode)
		endif

		; Clear vars if needed
		if (!retainRefs)
			RestrainedAnim = ""
			ChainWristL = None
			ChainWristR = None
			ChainAnkleL = None
			ChainAnkleR = None
			ChainNeck = None
		endif

		slave.SetAV("Paralysis", 0)
		DetachingHavok = false
	endif
EndFunction

Function DoFavor()
	FurnitureInUse = None
	Actor slave = GetActorRef()
	slave.RemoveFromFaction(PHSF.AccompanyFaction)
	slave.AddToFaction(PHSF.InSceneFaction)
	StopPosing(slave)
	slave.SetDoingFavor(true)	
EndFunction


Function CheckName(bool doSave = true)
	; Name sometimes gets lost, rendering the slave inpoerative
	Actor slave = GetActorRef()
	if (slave)
		if (slave.GetDisplayName() == "")
			if (Name == "")
				Name = "Nippy"
			endif
			slave.SetDisplayName(Name)
			PHSF.DebugLog("Name restored:" + Name)
		elseif (doSave)
			Name = slave.GetDisplayName()
;			PHSF.DebugLog("Name stored:" + Name)
		endif
	endif
EndFunction

Function CheckOutfit()
	Actor slave = GetActorRef()
	if slave == None
		return
	endif
	if ((IsDressingCounter > 0) || (WornStuff.Length == 0) || (slave.IsInFaction(PHSF.InSceneFaction)) )
		return
	endif

	;debug.notification("Check outfit for:" + slave.GetDisplayName())
	int slotIndex = 0;
;	int slotMask = 0x0000039f
	int slotMask = 0x1f4f139c
	int slot
	bool naked = true
	bool cantMove = false
	bool crawling = false
	isYoked = false

	while (slotIndex < 32)
		slot = math.pow(2, slotIndex) as int
;		if (math.LogicalAnd(slot, slotMask))
			Form  item = slave.GetWornForm(slot)
			if item != None
				naked = false
				if PHSF.IsItemNoMove(item)
					cantMove = true
				endif
				if PHSF.DOMZAD.isYoked(item)
					isYoked = true
				endif
			endif
;		endif
		slotIndex += 1
	endwhile
;	s += " "+ naked

;	if (slave.IsInFaction(PHSF.NakedFaction) != naked)		; Removed, naked / dresset set only by dialogue
;		s += "  changed"
;		if (naked)
;			slave.AddToFaction(PHSF.NakedFaction)
;		else
;			slave.RemoveFromFaction(PHSF.NakedFaction)
;		endif
;	endif

	Form neckItem = slave.GetWornForm(0x8000)
	Form wristItem = slave.GetWornForm(0x20000000)
	Form ddItem = slave.GetWornForm(0x16000)
	Form harnessItem = slave.GetWornForm(0x10008000)
	if ((harnessItem != None) && (math.LogicalAnd(harnessItem.GetFormId(),0xFFFFFF) == 0x4392))
		crawling = true
	endif

	if (ddItem != None)
		if (math.LogicalAnd(ddItem.GetFormId(),0xFFFFFF) == 0x26991)
			neckItem = ddItem
			wristItem = ddItem
		elseif (math.LogicalAnd(ddItem.GetFormId(),0xFFFFFF) == 0xca38)
			neckItem = None
			wristItem = ddItem
		endif
	endif

	if (((neckItem != None) && (neckItem == wristItem)) || (cantMove) || (crawling))
		IsYoked = true
	else
		IsBound = (wristItem != none)
	endif

	neckItem = slave.GetWornForm(0x00000020)
	if (neckItem == PHSF.AuctionSpawnedToken)
		slave.SetFactionRank(PHSF.PAHHouseReservedFaction,1 )
	elseif ((neckItem == PHSF.AuctionToken) && (!slave.IsInFaction(PHSF.PAHHouseReservedFaction ) ))
		slave.AddToFaction(PHSF.PAHHouseReservedFaction )
	elseif ((neckItem != PHSF.AuctionToken) && (slave.IsInFaction(PHSF.PAHHouseReservedFaction)) && \
		((PHSF.QstNobleDesires.IsCompleted()) || ( PHSF.SkipQuests )) )
		slave.RemoveFromFaction(PHSF.PAHHouseReservedFaction )
	endif


;	debug.notification("Yoked:" + IsYoked + "   Bound:" + IsBound)

	PHSF.CanTrain = ((!IsYoked) && (!IsBound))
EndFunction


Function StoreOutfit(bool removeItems = false)
	Actor slave = GetActorRef()

	if WornStuff.Length == 0
		WornStuff = new Form[32]
	endif

	if WornDDStuff.Length == 0 && PHSF.DOMZAD.hasZad
		WornDDStuff = new Form[32]
	endif

	PHSF.DebugLog("Store outfit for:" + slave.GetDisplayName() + "  " + removeItems)
	int slotIndex = 0;
	int slotMask = 0
;	int slotMask = 0x08302000
;	if (slave.IsInFaction(PHSF.NakedFaction))
;		slotMask = 0x8030039f
;	endif

	int slot
	while (slotIndex < 32)
		slot = math.pow(2, slotIndex) as int
		if (!math.LogicalAnd(slot, slotMask))
			Form  item = slave.GetWornForm(slot)
		endif
		slotIndex += 1
	endwhile
;	PHSF.DebugLog(s)

	; Look for DD devices
	if PHSF.DOMZAD.hasZad ; Removed to test if DD devices re-equip correctly.
		WornDDStuff[0] = None
		int i = slave.GetNumItems()
		int ddCount = 0

		while (i > 0)
			i -= 1
			Form item = slave.GetNthForm(i)
			if PHSF.DOMZAD.hasKeywordDevice(item)
				; Check if item is actually worn
				Form renderItem = PHSF.DOMZAD.GetRenderedDevice(item)
				if ((renderItem != None) && (slave.IsEquipped(renderItem)))
					WornDDStuff[ddCount] = item
					ddCount += 1
				endif
			endif
		endwhile
	endif
EndFunction

; Equip the outfit exactly as stored
Function RestoreOutfit()
	EquipOutfit(false)
EndFunction

; Equip stored items in addition to items already worn
Function EquipStored()
	EquipOutfit(true)
EndFunction

Function EquipOutfit(bool nostrip)
	if (WornStuff.Length > 0)
		IsDressingCounter = 5
		Actor slave = GetActorRef()
		PHSF.DebugLog("Recall outfit for:" + slave.GetDisplayName())
		if ((slave == None) || (!slave.IsEnabled()) || (slave.IsDeleted()) )
			PHSF.DebugLog("   Slave in incorrect state, skipping")
			debug.notification("Your slave " + GetActorRef().GetDisplayName() + " died of unnatural causes!")
			DoClear()
			return
		endif

		Form neckChain = Game.GetFormFromFile(0x9be97, "ZazAnimationPack.esm")	; Check if we need to leave this on
		if ((neckChain != None) && (!slave.GetItemCount(neckChain)))
			neckChain = None
		endif

		; First properly unequip DD items

		if (!nostrip)
			slave.UnequipAll()
			utility.wait(0.5)
		endif

		int slotIndex = 0;
		int slotMask = 0x802		; Hair / Longhair: leave wigs on
		int slot = 1

		while (slotIndex < 32)
			Form  item = WornStuff[slotIndex];
				if ((item != none) && (slave.GetItemCount(item) > 0))
					if ((!slave.IsInFaction(PHSF.NakedFaction)) || (!PHSF.isToBeStripped(item)) || (math.LogicalAnd(slot, slotMask)))
						slave.EquipItem(item)
					endif
				endif
			slot *= 2
			slotIndex += 1
		endwhile

		if (neckChain != None)
			slave.EquipItem(neckChain, false)
		endif
		
		PHSF.DebugLog("Recall outfit for:" + slave.GetDisplayName() + " Done")
	endif
EndFunction

Function ReapplyZbfSpell()
	Actor slave = GetActorRef()
	if (PHSF.DOMZaz.ZbfBondageSpell2 == None) || (slave.IsInFaction(PHSF.HousePoseFaction)) || (slave.IsInFaction(PHSF.OnRackFaction)) || (slave.IsInFaction(PHSF.RestrainedFaction)) || (slave.IsInFaction(PHSF.WallChainFaction)) || (slave.GetFactionRank(PHSF.WaitingFaction) > 1)
		return
	endif
	ZbfRefreshTicks -= 1
	if (zbfRefreshTicks <= 0)
		GetActorRef().RemoveSpell(PHSF.DOMZaz.ZbfBondageSpell2)
		GetActorRef().AddSpell(PHSF.DOMZaz.ZbfBondageSpell2)
		ZbfRefreshTicks = 3
	endif
EndFunction


Function RegisterForITF()
	RegisterForModEvent("TortureSession", "OnITFEvent")
EndFunction

Event OnITFEvent(string eventName, string strArg, float numArg, Form sender)
	if ((eventName == "TortureSession") && (strArg == "TortureEnded"))
		PHSF.DebugLog("Session ended: " + FurnitureInUse.GetName())
		Actor slave = GetActorRef()
		UnregisterForModEvent("TortureSession")
		if ((slave.IsInFaction(PHSF.IsTraineeFaction)) && (trainer != None))
			SlaveTarget.ForceRefTo(trainer)
			AccompanyPlayer()

			if (PHSF.SlaveRef(trainer).LastBehaviour == "accompany_player")
				PHSF.SlaveTarget(trainer).ForceRefTo(Game.GetPlayer())
				PHSF.SlaveRef(trainer).AccompanyPlayer()
			else
				PHSF.SlaveRef(trainer).Sandbox()
			endif
		else
			if (LastBehaviour == "accompany_player")
				SlaveTarget.ForceRefTo(Game.GetPlayer())				
				AccompanyPlayer()
			else
				Sandbox()
			endif
		endif
	endif
EndEvent

; ### Behaviour Handling ###
String __behaviour = ""
String Property behaviour
	String Function get()
		return __behaviour
	EndFunction

	Function set(String value)
		__behaviour = value
		EndBehaviour()
		GoToState(__behaviour)
		StartBehaviour()
	EndFunction
EndProperty

Function StartBehaviour()
EndFunction

Function EndBehaviour()
EndFunction

Function BehaviourOnUpdate()
EndFunction



Function SetInitialBehaviour()
	LastBehaviour=""
	NextBehaviour=""
	RestrainedAnim=""
	PunishAnim=""
	WornRestraint=None
	hasGreeted = false
	inhibitKneelTicks = 3
EndFunction

;### Behaviour Definition

Function Sandbox()
	PunishmentTicks = 0
	behaviour = "sandbox"
	FurnitureInUse = None
EndFunction

State sandbox
	Function StartBehaviour()
		Actor slave = GetActor()
		StopPosing(slave)
		slave.SetHeadTracking(false)
		if (HouseMarker != none)
			SlaveTarget.ForceRefTo(HouseMarker)
			slave.SetFactionRank(PHSF.SandboxFaction, 2)
		else
			slave.SetFactionRank(PHSF.SandboxFaction, 1)
		endif
	EndFunction

	Function BehaviourOnUpdate()
		Actor slave = GetActor()
		if (IsYoked)
			Wait()
		endif 
;		debug.notification(slave.GetDisplayName() + " Sandbox tick: " + PunishmentTicks + "  TPF:"+ slave.IsInFaction(PHSF.TrainerPunishingFaction) + "  ITF:" + slave.IsInFaction(PHSF.IsTrainerFaction) + "  Scene:" + slave.IsInFaction(PHSF.InSceneFaction))
		if ((!slave.IsInFaction(PHSF.TrainerPunishingFaction)) && (!slave.IsInFaction(PHSF.InSceneFaction)) && (!PHSF.DisableBdsm) && (!IsInOSAScene(slave)) && (!PHSF.IsInSSScene(slave)))
			ReapplyZbfSpell()
			PunishmentTicks += 1
			if ((slave.IsInFaction(PHSF.IsTrainerFaction)) && (trainee != None) && (!IsInOSAScene(trainee)))
;				debug.notification(slave.GetDisplayName() + " Sandbox tick: " + PunishmentTicks + "  Sit:"+ slave.GetSitState() + "  Trainee:" + trainee.IsInFaction(PHSF.HouseCagedFaction))
				if ((PunishmentTicks * SecsPerTick > 30) && (slave.GetSitState() == 0) && (!trainee.IsInFaction(PHSF.HouseCagedFaction)))
					PunishmentTicks = 0
					PHSF.Punish(slave)
				endif
			elseif ((slave.GetFactionRank(PHSF.PAHPlayFaction) == 1) && (!slave.IsInFaction(PHSF.IsTrainerFaction)) && (!slave.IsInFaction(PHSF.IsTraineeFaction)) && (!slave.IsInFaction(PHSF.TrainerDoneFaction)) && (PunishmentTicks * SecsPerTick > 30 + utility.Randomint(1, 15)))
				PunishmentTicks = 0
				ReferenceAlias[] refsInCell = PHSF.PortableFunctions.SlaveRefsInCell(slave.GetParentCell())
				ReferenceAlias[] filterRefs = PHSF.Taskmaster.FilterArrayForType(refsInCell, 11)
				int c = 0
				while (filterRefs[c] != None)
					c += 1
				endwhile
				if (c > 0)
					int i = utility.Randomint(0, c - 1)
					Actor victim = filterRefs[i].GetActorRef()

					if (victim != None)
						trainee = victim		; For the nonce, set trainer and trainee
						if ((!victim.IsInFaction(PHSF.TrainerPunishingFaction)) && (!victim.IsInFaction(PHSF.InSceneFaction)) && (!IsInOSAScene(victim)) && (!PHSF.IsInSSScene(victim)))
							PHSF.SlaveRef(victim).trainer = slave
							PHSF.DebugLog("Playing:" + slave.GetDisplayName() + " with:" + victim.GetDisplayName())
;							debug.notification("Playing:" + slave.GetDisplayName() + " with:" + victim.GetDisplayName())
							PHSF.PunishActor(slave, victim, -1, false)
						else
;							debug.notification("Playing:" + slave.GetDisplayName() + " with: (BUSY)" + victim.GetDisplayName())
						endif
					else
;						debug.notification(slave.GetDisplayName() + " Found no one to play with out of candidates:" + c)
					endif
				endif
			endif
		endif

		CheckForGreeting(GetActor(), false)
		CheckForSexPartners(slave)
	EndFunction

	Function EndBehaviour()
	EndFunction
EndState

Function Wait()
	if ((trainer != None) && (PHSF.SlaveRef(trainer) != None ))
		PHSF.SlaveRef(trainer).TraineeArrived = true
	endif
	StopPosing(GetActor())
	LastBehaviour = behaviour
	NextBehaviour = "wait"
	behaviour = "wait"
EndFunction

State wait
	Function StartBehaviour()
		GetActor().SetFactionRank(PHSF.WaitingFaction, 1)	; Normal wait
		GetActor().EvaluatePackage()
	EndFunction

	Function BehaviourOnUpdate()
		ReapplyZbfSpell()
		CheckForGreeting(GetActor(), false)
		CheckForSexPartners(GetActor())
	EndFunction

	Function EndBehaviour()
		GetActor().SetDontMove(false)
		GetActor().RemoveFromFaction(PHSF.WaitingFaction)
		FurnitureInUse = None
	EndFunction
EndState

Function WaitWithAnim(string anim)
	GetActor().SetFactionRank(PHSF.WaitingFaction, 2)		; wait with anim
	PHSF.PHHSHInter.SendAnimationEvent(GetActor(), "IdleForceDefaultState")
	utility.wait(1)
	PoseAnim = anim
	NextBehaviour = "wait_anim"
	behaviour = "wait_anim"
	PHSF.PHHSHInter.SendAnimationEvent(GetActor(), anim)
EndFunction

Function WaitWithSeat(string anim)
	GetActor().SetFactionRank(PHSF.WaitingFaction, 3)		; wait with seat
	PHSF.PHHSHInter.SendAnimationEvent(GetActor(), "IdleForceDefaultState")
	utility.wait(1)
	PoseAnim = anim
	NextBehaviour = "wait_anim"
	behaviour = "wait_anim"
	PHSF.PHHSHInter.SendAnimationEvent(GetActor(), anim)
EndFunction

State wait_anim
	Function StartBehaviour()
		GetActor().EvaluatePackage()
		GetActor().SetDontMove(true)
	EndFunction

	Function BehaviourOnUpdate()

	EndFunction

	Function EndBehaviour()
		if (NextBehaviour != "wait_anim")
			PoseAnim = ""
		endif
		if (PoseFurnitureMarker != None)
			PoseFurnitureMarker.Delete()
			PoseFurnituremarker = None
		endif

		GetActor().SetDontMove(false)
		GetActor().SetVehicle(GetActor())
		GetActor().RemoveFromFaction(PHSF.WaitingFaction)
	EndFunction
EndState

Function WaitInCell()
	NextMarker = Cellmarker
	GetActorRef().SetFactionRank(PHSF.HouseCagedFaction, 1)		; Package finds Random cell marker
	NextBehaviour = "wait_in_cell"
	behaviour = "wait_in_cell"
	FurnitureInUse = None
EndFunction

Function WaitInBedroom()
	NextMarker = BedroomMarker
	GetActorRef().SetFactionRank(PHSF.HouseCagedFaction, 3)		; Pcackage finds Random bedroom marker
	NextBehaviour = "wait_in_cell"
	behaviour = "wait_in_cell"
	FurnitureInUse = None
EndFunction

State wait_in_cell
	Function StartBehaviour()
		Actor slave = GetActor()
		StopPosing(slave)
		if (NextMarker != none)
			SlaveTarget.ForceRefTo(NextMarker)
			slave.SetFactionRank(PHSF.HouseCagedFaction, 2)	; Go to follow target
;		else
;			Sandbox()
		endif
		slave.EvaluatePackage()
		if (slave.IsInFaction(PHSF.IsTraineeFaction))
			PHSF.SlaveRef(trainer).PauseTraining()
		endif
	EndFunction

	Function BehaviourOnUpdate()
		CheckForGreeting(GetActor(), false)
		CheckForSexPartners(GetActor())
		ReapplyZbfSpell()
	EndFunction

	Function EndBehaviour()
		GetActor().RemoveFromFaction(PHSF.HouseCagedFaction)
		if (GetActor().IsInFaction(PHSF.IsTraineeFaction))
			PHSF.SlaveRef(trainer).ResumeTraining()
		endif
	EndFunction
EndState

Function FollowTarget()
	NextBehaviour = "follow_target"
	behaviour = "follow_target"
	FurnitureInUse = None
EndFunction

State follow_target
	Function StartBehaviour()
		PlayerNearTicks = 0
		LastPlayerDistance = 0
		StopPosing(GetActor())
		GetActor().AddToFaction(PHSF.InSceneFaction)
		GetActor().SetFactionRank(PHSF.AccompanyFaction, 1)
		GetActor().EvaluatePackage()
	EndFunction

	Function BehaviourOnUpdate()
		CheckForIdleBehaviour(GetActor())
		CheckForSexPartners(GetActor())
		ReapplyZbfSpell()
	EndFunction

	Function EndBehaviour()
		GetActor().RemoveFromFaction(PHSF.AccompanyFaction)
	EndFunction
EndState

Function Travel(ObjectReference target_cell)
	lastBehaviour = behaviour
	lastTarget = SlaveTarget.GetActorRef()
	SlaveTarget.ForceRefTo(target_cell)
	LogTrace("Travel to "+target_cell)
	utility.wait(1.0)
	NextBehaviour = "travel"
	behaviour = "travel"
	FurnitureInUse = None
EndFunction

State travel
	Function StartBehaviour()
		PlayerNearTicks = 0
		LastPlayerDistance = 0
		StopPosing(GetActor())
		GetActor().AddToFaction(PHSF.TravelingFaction)
		GetActor().EvaluatePackage()
	EndFunction

	Function BehaviourOnUpdate()
		LogTrace("TRAVEL target="+SlaveTarget+" ref="+SlaveTarget.GetRef()+" distance="+DOM_Util.GetObjectDistance(GetActor(),SlaveTarget.GetRef()))
		; Check if arrived at destination
		if DOM_Util.IsTogetherWithFast(GetActor(), SlaveTarget.GetRef(), 150.0)
			Sandbox()
		else
			GetActor().EvaluatePackage()
		endif
	EndFunction

	Function EndBehaviour()
		GetActor().RemoveFromFaction(PHSF.TravelingFaction)
	EndFunction
EndState

Function AccompanyPlayer()
	NextBehaviour = "accompany_player"
	behaviour = "accompany_player"
	FurnitureInUse = None
EndFunction

State accompany_player
	Function StartBehaviour()
		GetActor().RemoveFromFaction(PHSF.InSceneFaction)
		PlayerNearTicks = 0
		LastPlayerDistance = 0
		StopPosing(GetActor())
		GetActor().SetFactionRank(PHSF.AccompanyFaction, 1)
		GetActor().EvaluatePackage()
	EndFunction

	Function BehaviourOnUpdate()
		CheckForIdleBehaviour(GetActor())
		CheckForSexPartners(GetActor())
		ReapplyZbfSpell()
	EndFunction

	Function EndBehaviour()
		GetActor().RemoveFromFaction(PHSF.AccompanyFaction)
	EndFunction
EndState

Function PrepareToEscort(Actor escort)
	lastBehaviour = behaviour
	lastTarget = SlaveTarget.GetActorRef()
	SlaveTarget.ForceRefTo(escort)
	utility.wait(0.5)		
	escort.AddToFaction(PHSF.InSceneFaction)
	behaviour = "prepare_to_escort"
	FurnitureInUse = None
EndFunction

State prepare_to_escort
	Function StartBehaviour()
		Actor slave = GetActor()
		StopPosing(slave)
		slave.SetFactionRank(PHSF.AccompanyFaction, 1)
		slave.AddToFaction(PHSF.InSceneFaction)
		slave.EvaluatePackage()
		slave.SetDontMove(false)
		StopTicks = 0
;		debug.notification(slave.GetDisplayName() + " will accompany" + SlaveTarget.GetActorRef().GetDisplayName()  )
	EndFunction

	Function BehaviourOnUpdate()
		Actor slave = GetActor()
		if ((slave.GetDistance(SlaveTarget.GetRef()) < 100) || (StopTicks * secsPerTick > 30  ))
;			debug.notification("Nearby")
			EscortTargetToCell()
		elseif (slave.GetParentCell() != SlaveTarget.GetRef().GetParentCell())
			SandBox()
			PHSF.DebugLog("Revert to sandbox from escorting: " + slave.GetDisplayName())
		else
			StopTicks += 1
		endif
	EndFunction

	Function EndBehaviour()
		GetActor().RemoveFromFaction(PHSF.AccompanyFaction)
	EndFunction
EndState


Function EscortTargetToCell()
	Actor escort = SlaveTarget.GetActorRef()
	PHSF.SlaveTarget(escort).ForceRefTo(GetActor())
	(PHSF.SlaveRef(escort) as PHHSHHouseSlave).AccompanyPlayer()
	FurnitureInUse = None
	utility.wait(1)
	behaviour = "escort_to_cell"
EndFunction

State escort_to_cell
	Function StartBehaviour()
		Actor slave = GetActor()
		StopPosing(slave)
		slave.SetFactionRank(PHSF.HouseCagedFaction, 1)
		slave.EvaluatePackage()
		slave.SetDontMove(false)
		StopTicks = 0
	EndFunction

	Function BehaviourOnUpdate()
		Actor slave = GetActor()
		if ((math.abs(lastX - slave.X) < 10) && (math.abs(lastY - slave.Y) < 10))
			StopTicks += 1
			if (StopTicks * secsPerTick > 20)
;				debug.notification("Stopped")
				utility.wait(1)
				Actor escort = SlaveTarget.GetActorRef()
				escort.RemoveFromFaction(PHSF.InSceneFaction)
				(PHSF.SlaveRef(escort) as PHHSHHouseSlave).WaitInCell()
				SlaveTarget.ForceRefTo(Game.GetPlayer())
				AccompanyPlayer()
			endif
		else
			StopTicks = 0
		endif
		lastX = slave.X
		lastY = slave.Y
	EndFunction

	Function EndBehaviour()
		GetActor().RemoveFromFaction(PHSF.HouseCagedFaction)
		GetActor().RemoveFromFaction(PHSF.InSceneFaction)
	EndFunction
EndState


Function PrepareToFetch(Actor escort)
	Actor slave = GetActor()
	lastBehaviour = behaviour
	lastTarget = SlaveTarget.GetActorRef()
	SlaveTarget.Clear()
	SlaveTarget.ForceRefTo(escort)
	escort.AddToFaction(PHSF.InSceneFaction)
	FurnitureInUse = None
	utility.wait(1)		
	behaviour = "prepare_to_fetch"
;	debug.notification("Fetch target: " + SlaveTarget.GetActorRef().GetDisplayName())
EndFunction


State prepare_to_fetch
	Function StartBehaviour()
		Actor slave = GetActor()
		StopPosing(slave)
		slave.SetFactionRank(PHSF.AccompanyFaction, 1)
		slave.AddToFaction(PHSF.InSceneFaction)
		slave.EvaluatePackage()
		StopTicks = 0
;		debug.notification("start target: " + SlaveTarget.GetActorRef().GetDisplayName())
	EndFunction

	Function BehaviourOnUpdate()
;		debug.notification("follow target: " + SlaveTarget.GetActorRef().GetDisplayName())
		Actor slave = GetActor()
		if ((slave.GetDistance(SlaveTarget.GetRef()) < 100) || (StopTicks * secsPerTick > 30) )
			Wait()
			utility.wait(1)
			EscortTargetToPlayer()
		else
			StopTicks += 1
		endif
	EndFunction

	Function EndBehaviour()
		GetActor().RemoveFromFaction(PHSF.AccompanyFaction)
	EndFunction
EndState


Function EscortTargetToPlayer()
	Actor slave = GetActor()
	Actor escort = SlaveTarget.GetActorRef()

	escort.RemoveFromFaction(PHSF.InSceneFaction)
	slave.RemoveFromFaction(PHSF.InSceneFaction)

	SlaveTarget.ForceRefTo(Game.GetPlayer())
	PHSF.SlaveTarget(escort).ForceRefTo(slave)
	utility.wait(0.5)		
	PHSF.SlaveRef(escort).AccompanyPlayer()
	AccompanyPlayer()
EndFunction


Function GoOnRack()
	behaviour = "on_rack"
	StopPosing(GetActor())
;	GetActor().SetDontMove()
	GetActor().AddToFaction(PHSF.OnRackFaction)
	utility.wait(0.5)
	GetActor().EvaluatePackage()
EndFunction

State on_rack
	Function StartBehaviour()

	EndFunction

	Function BehaviourOnUpdate()

	EndFunction

	Function EndBehaviour()
		GetActor().SetDontMove(false)
		GetActor().RemoveFromFaction(PHSF.OnRackFaction)
		if (NextBehaviour != "follow_target")
			GetActor().RemoveFromFaction(PHSF.InSceneFaction)
		endif
	EndFunction
EndState

Function Restrain(String animName)
	RestrainedAnim = animName
	StopTicks = 0
	GetActor().RemoveFromFaction(PHSF.WallChainFaction)
	GetActor().SetDontMove()
	if (!IsYoked) 
		PHSF.PHHSHInter.SendAnimationEvent(GetActor(), RestrainedAnim)
	endif
	LastBehaviour = behaviour
	NextBehaviour = "restrained"
	behaviour = "restrained"
;	RestrainedAnim = animName
	WaitingForArrival = 0;
EndFunction

; Markers:
; 1 Wall marker
; 2 Cell Marker
; 3 Bedroom marker
; 4 Bed
; 5 Sittable Furniture (slave target)
; 6 Bed in designated bedroom
; 7 Non sittable furniture
; 8 Havok chains / ropes
; 9 Activator (slave target)
; 10 Move to target and return
; 11 Target

Function RestrainAtMarker(String animName, int marker, bool waitForActivate=false)
	if ((marker == 5) || (marker == 7))		; Furniture
		FurnitureInUse = SlaveTarget.GetRef()
	else
		FurnitureInUse = None
	endif

	if ((marker == 2) && (CellMarker != None))
		SlaveTarget.ForceRefTo(Cellmarker)
		marker = 11
	elseif ((marker == 3) && (BedroomMarker != None))
		SlaveTarget.ForceRefTo(Bedroommarker)
		marker = 11
	endif

	RestrainedAnim = animName
	CheckRestraintNeeded(animName)
	StopTicks = 0
	if (waitForActivate)
		WaitingForArrival = -1
	else
		WaitingForArrival = 1
	endif
	if (!IsYoked) 
		PHSF.PHHSHInter.SendAnimationEvent(GetActor(), "IdleForceDefaultState")
	endif
	LastBehaviour = behaviour
	NextBehaviour = "restrained"
	behaviour = "restrained"
;	RestrainedAnim = animName
	GetActor().SetDontMove(waitForActivate)
	GetActor().AddToFaction(PHSF.WallChainFaction)
	GetActor().SetfactionRank(PHSF.WallChainFaction, marker)
	GetActor().EvaluatePackage()
EndFunction

Function CheckRestraintNeeded(String animName)
	if ((IsYoked) || (IsBound))
		return
	endif

	IsDressingCounter = 1
	Wornrestraint = None
	if ((animName== "ZapWriPose12") || (animName== "ZapWriPose13") || (animName== "ZapWriPose14") || (animName== "ZapWriPose15"))
		WornRestraint = PHSF.WristRopes3
	elseif (animName== "ZapWriPose07")		
		WornRestraint = PHSF.WristChains2
	endif
	if (WornRestraint != None)
		Actor slave = GetActor()
		utility.wait(0.2)
;		slave.AddItem(WornRestraint, 1)
		utility.wait(0.2)
		slave.EquipItem(WornRestraint, true, true)		
	endif
	IsDressingCounter = 0
EndFunction

State restrained
	Function StartBehaviour()
;		debug.notification("StartBehaviour: restrained:" + restrainedAnim)
		Actor slave = GetActor()
		slave.AddToFaction(PHSF.RestrainedFaction)
		slave.AddToFaction(PHSF.InSceneFaction)
		slave.EvaluatePackage()
		slave.SetDontMove(WaitingForArrival==0)
		CheckRestraintNeeded(RestrainedAnim )
	EndFunction

	Function BehaviourOnUpdate()
		Actor slave = GetActor()
;		debug.notification("Update waiting:" + WaitingForArrival + "  FR:" + slave.GetFactionRank(PHSF.WallChainFaction))
	
		if (WaitingForArrival==1)
			if (slave.GetFactionRank(PHSF.WallChainFaction) < 7)
				StopTicks += 1
			else
				; For furniture, check if slave is actually stopped
				if (math.abs(lastX - slave.X) + math.abs(lastY - slave.Y) < 10)
					StopTicks += 1
				endif
				lastX = slave.X
				lastY = slave.Y
				
				if ((StopTicks * SecsPerTick > 4) && (math.abs(SlaveTarget.GetRef().X - slave.X) + math.abs(SlaveTarget.GetRef().Y - slave.Y) < 100))
					if (slave.GetFactionRank(PHSF.WallChainFaction) == 7)
						slave.MoveTo(SlaveTarget.GetRef(), 0, 0, SlaveTarget.GetRef().GetHeight(), false)
					endif
					WaitingForArrival = 2
				endif
			endif
		endif

		if ((WaitingForArrival==2) || ((StopTicks * SecsPerTick > 60)  && (WaitingForArrival==1))  )
			if (slave.GetFactionRank(PHSF.WallChainFaction) == 7)
				slave.SetDontMove()
			elseif (slave.GetFactionRank(PHSF.WallChainFaction) == 8)
;				slave.MoveTo(SlaveTarget.GetRef(), 0, 0, slave.Z - SlaveTarget.GetRef().Z, false)
			elseif (((slave.GetFactionRank(PHSF.WallChainFaction) == 5) || (slave.GetFactionRank(PHSF.WallChainFaction) == 9) || (slave.GetFactionRank(PHSF.WallChainFaction) == 10) || (slave.GetFactionRank(PHSF.WallChainFaction) == 11)) && (WaitingForArrival==1))
				slave.MoveTo(SlaveTarget.GetRef(), 0, 0,0, false)
			endif
;			debug.notification("Done waiting")
			utility.wait(3)
			if (slave.GetFactionRank(PHSF.WallChainFaction) < 4)
;				debug.notification("anim")
				slave.SetDontMove()
				if (!IsYoked)
					PHSF.PHHSHInter.SendAnimationEvent(slave, RestrainedAnim)
				endif
				utility.wait(1)
			elseif (slave.GetFactionRank(PHSF.WallChainFaction) == 8)
				BindToChains(restrainedAnim)				
			elseif (slave.GetFactionRank(PHSF.WallChainFaction) == 10)
				SlaveTarget.ForceRefTo(lastTarget)
				AccompanyPlayer()
			elseif (slave.GetFactionRank(PHSF.WallChainFaction) == 5)
				if (slave.GetSitState() != 3)		; Should be sitting at this point, furniture unreachable or occupied
; debug.notification(slave.GetDisplayName() + " failed to sit")
					Sandbox()
				endif
			elseif (slave.GetFactionRank(PHSF.WallChainFaction) != 9)
;				debug.notification("anim delay")
				if (!IsYoked)
					PHSF.PHHSHInter.SendAnimationEvent(slave, RestrainedAnim)
				endif
				utility.wait(1)
				slave.SetDontMove()
			endif
			LastAnim = RestrainedAnim
			WaitingForArrival=3
		elseif ((WaitingForArrival==0) || (WaitingForArrival==3))
			stopTicks += 1
			if (stopticks * SecsPerTick > 4)
				string anim
				if (!utility.RandomInt(0,1))
					anim = PHSF.StruggleAnimation(RestrainedAnim)
				else
					anim = RestrainedAnim
				endif
				if ((anim != LastAnim) &&  (!IsYoked) && (!DetachingHavok))
					PHSF.PHHSHInter.SendAnimationEvent(slave, anim)
					LastAnim = anim
				endif
				stopTicks = 0
			endif
		endif
	EndFunction

	Function EndBehaviour()
;		debug.notification("EndBehaviour")
		LastAnim = ""

		Actor slave = GetActor()
;		slave.SetDontMove(false)
		if ((NextBehaviour != "restrained") && (slave.GetFactionRank(PHSF.WallChainFaction) != 7) && (slave.GetFactionRank(PHSF.WallChainFaction) != 10))
			bool bleedout = true
			if (slave.GetFactionRank(PHSF.WallChainFaction) == 8)
				DetachFromHavokChain()
				bleedout = false
			elseif ((slave.GetFactionRank(PHSF.WallChainFaction) == 9) && (PHSF.DisplayModelFurniture != None))
				PHSF.DMFunctions.DMReleaseActor(slave)
			endif
			RestrainedAnim = ""
			if ((!IsYoked) && (bleedout))
				PHSF.PHHSHInter.SendAnimationEvent(slave, "BleedoutStart")
			endif
			slave.SetDontMove(false)
			if (bleedout)
				PHSF.PortableFunctions.TryApplyTears(slave)
				utility.wait(5)
			endif
;			PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
		endif
		if (!IsYoked)
			PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
		endif
		utility.wait(0.5)
		slave.SetDontMove(false)
		slave.RemoveFromFaction(PHSF.RestrainedFaction)
		slave.RemoveFromFaction(PHSF.InSceneFaction)
		slave.RemoveFromFaction(PHSF.WallChainFaction)
		slave.RemoveFromFaction(PHSF.HousePoseFaction)
		slave.EvaluatePackage()
		if (WornRestraint != None)
			slave.UnequipItem(WornRestraint)
			utility.wait(0.2)
			slave.RemoveItem(WornRestraint, 1)
			utility.wait(0.5)
			EquipStored()
		endif
		utility.wait(3)
	EndFunction
EndState

Function SparWithTrainee()
	behaviour = "sparring"
	FurnitureInUse = None
EndFunction

State sparring
	Function StartBehaviour()
		PunishmentTicks = 0
		Actor slave = GetActor()
;		slave.AddToFaction(PHSF.InSceneFaction)
;		trainee.AddToFaction(PHSF.InSceneFaction)
		slave.AddItem(PHSF.SparWeapon, 1)			; Need to add a weapon (not sure how to use fists)
		trainee.AddItem(PHSF.SparWeapon, 1)
		utility.wait(3)
		RestoreOutfit()						; Needed after messing with inventory
		PHSF.SlaveRef(trainee).RestoreOutfit()
		SlaveTarget.ForceRefTo(trainee)
		PHSF.SlaveTarget(trainee).ForceRefTo(slave)
		slave.SetFactionRank(PHSF.TrainerPunishingFaction, 4)	; 4 = spar
		trainee.SetFactionRank(PHSF.TrainerPunishingFaction, 4)	
		utility.wait(0.5)
		slave.EvaluatePackage()	
		trainee.EvaluatePackage()	
	EndFunction

	Function BehaviourOnUpdate()
		PunishmentTicks += 1
		if (PunishmentTicks * SecsPerTick > 30)
			Sandbox()
		endif
	EndFunction

	Function EndBehaviour()
		Actor slave = GetActor()
;		slave.RemoveFromFaction(PHSF.InSceneFaction)
;		trainee.RemoveFromFaction(PHSF.InSceneFaction)
		slave.RemoveFromFaction(PHSF.TrainerPunishingFaction)
		trainee.RemoveFromFaction(PHSF.TrainerPunishingFaction)
		PHSF.SlaveTarget(trainee).ForceRefTo(slave)
		PHSF.SlaveRef(trainee).AccompanyPlayer()
		utility.wait(0.5)
		slave.EvaluatePackage()
		trainee.EvaluatePackage()	
		slave.StopCombat()
		trainee.StopCombat()
		slave.RemoveItem(PHSF.SparWeapon, 1)
		trainee.RemoveItem(PHSF.SparWeapon, 1)
		utility.wait(3)
		RestoreOutfit()
		PHSF.SlaveRef(trainee).RestoreOutfit()
	EndFunction
EndState

Function PrepareToPunishTrainee(String pAnim, String rAnim)
	PunishAnim = pAnim
	RestrainedAnim = rAnim
	TraineeArrived = false
	behaviour = "punishing"
	FurnitureInUse = None
EndFunction

State punishing
	Function StartBehaviour()
		Actor slave = GetActor()
		StopPosing(slave)
		slave.ClearLookAt()
		slave.SetHeadTracking(false)
		slave.AddToFaction(PHSF.InSceneFaction)
		SlaveTarget.ForceRefTo(trainee)
		slave.SetFactionRank(PHSF.TrainerPunishingFaction, 1)	
		stopTicks = 0
		utility.wait(0.5)		
		slave.EvaluatePackage()
	EndFunction

	Function BehaviourOnUpdate()
		Actor slave = GetActor()
		if (slave.GetFactionRank(PHSF.TrainerPunishingFaction) == 1)
			if ((TraineeArrived) && (slave.GetDistance(trainee) <= 120))
				slave.SetLookAt(trainee, true)
				utility.wait(1)
;				debug.notification("Restrain anim:" + RestrainedAnim)
				if ((!IsBound) && (!IsYoked))
					PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleLockpick")
				endif
				if (RestrainedAnim != "")
					PHSF.SlaveRef(trainee).Restrain(RestrainedAnim)
				endif
				utility.wait(3)
				if ((PunishAnim != "whip") || (slave.IsInFaction(PHSF.DoNotWhip) ))
					slave.SetFactionRank(PHSF.TrainerPunishingFaction, 2)
				else
					slave.SetFactionRank(PHSF.TrainerPunishingFaction, 3)
					utility.wait(2)
				endif
				utility.wait(1)
				slave.EvaluatePackage()
				LastAnim = ""
				StopTicks = 2
				PunishmentTicks = 0
			else
				; Handle timeout issues: trainer cannot reach trainee / trainee cannot find or activate marker
				StopTicks += 1
				if (StopTicks * SecsPerTick > 60)
					slave.MoveTo(trainee, 5, 5, 0, false)		; Teleport trainer
					TraineeArrived = true
				endif
			endif
		elseif (slave.GetFactionRank(PHSF.TrainerPunishingFaction) == 2)
			if (StopTicks * SecsPerTick < 5)
				StopTicks += 1
			else
				if ((PunishAnim != "") && (!IsYoked))
					PHSF.PHHSHInter.SendAnimationEvent(slave, PunishAnim)
				endif
			endif
		endif

		if (slave.GetFactionRank(PHSF.TrainerPunishingFaction) >= 2)
			PunishmentTicks += 1
			if (PunishmentTicks * SecsPerTick > 30)
				Sandbox()
				slave.EvaluatePackage()
			endif
		endif
	EndFunction

	Function EndBehaviour()
		Actor slave = GetActor()
		slave.ClearLookAt()
		slave.SetHeadTracking(true)
		slave.SetDontMove(false)
		slave.SheatheWeapon()
		PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
		utility.wait(1)
		slave.RemoveFromFaction(PHSF.TrainerPunishingFaction)
		slave.RemoveFromFaction(PHSF.HousePoseFaction)
		slave.RemoveFromFaction(PHSF.InSceneFaction)
		PHSF.SlaveTarget(trainee).ForceRefTo(slave)

		PHSF.SlaveRef(trainee).AccompanyPlayer()
		utility.wait(0.5)
		slave.EvaluatePackage()		
		if (slave.GetFactionRank(PHSF.PAHPlayFaction) == 1)
			utility.wait(1)
			;PHSF.SlaveRef(trainee).behaviour = PHSF.SlaveRef(trainee).LastBehaviour
			PHSF.SlaveRef(trainee).Sandbox()
		endif
	EndFunction
EndState

Function RegisterAsTrainer()
	LastTrainingTime = Utility.GetCurrentGameTime()
	Debug.Trace("HomeSweetHome: "+GetActorRef().GetDisplayName()+" register as trainer time = "+LastTrainingTime)
	RegisterForUpdateGametime(6)
EndFunction

Function UnregisterAsTrainer()
	UnregisterForUpdateGametime()
	trainee = None
	trainee_actor = None
EndFunction

Function PauseTraining()
	OnUpdateGameTime()
	;LastTrainingTime = Utility.GetCurrentGameTime()
EndFunction

Function ResumeTraining()
	LastTrainingTime = Utility.GetCurrentGameTime()
	OnUpdateGameTime()
EndFunction

Event OnUpdateGameTime()
	if trainee == None ; not a trainer
		UnregisterForUpdateGametime()
		return
	endif
	Actor slave = GetActorRef()
	if slave.IsInFaction(PHSF.TrainerDoneFaction) ; training done
		UnregisterForUpdateGametime()
		return
	endif
	DOM_Actor akActor = (self as ReferenceAlias) as DOM_Actor
	if akActor == None ; actor was released
		UnregisterForUpdateGametime()
		return
	endif
	
	;Debug.Trace("HomeSweetHome: OnUpdateGameTime")
;	if ((PHSF.OSAEffect != None) && (slave.HasMagicEffect(PHSF.OSAEffect)))
;		debug.notification(slave.GetDisplayName() + " In OSA scene")
;	endif

	float days = Utility.GetCurrentGameTime() - LastTrainingTime
	if (days < 1)
		return
	endif
	int trainType = trainee.GetFactionRank(PHSF.IsTraineeFaction)

	if (!trainee.IsInFaction(PHSF.HouseCagedFaction))
		; Check if a taskmaster is present and determing training bonus
		actor tm = PHSF.Taskmaster.TaskmasterInCell(slave.GetParentCell())
;		if tm == None && days < 2 
;			; Update only every two days if no taskmaster/mistress
;			return
;		endif
		int train_next = 0
		bool[] ignoreStat = new bool[5]
		ignoreStat[0] = false ; submission
		ignoreStat[1] = false ; respect
		ignoreStat[2] = false ; pose
		ignoreStat[3] = false ; sex
		ignoreStat[4] = false ; combat

		; Check if a taskmaster is present and determing training bonus
		DOM_Actor tmActor
		if tm
			ReferenceAlias tm_ref = PHSF.SlaveRef(tm) as ReferenceAlias
			phhshHouseSlave tms = tm_ref as phhshHouseSlave
			tmActor = tm_ref as DOM_Actor
			if tmActor == None
				tmActor = PHSF.PHHSHInter.DOM.GetActor(tm)
			endif
			ignoreStat[0] = tms.TMNoTrainSubmission
			ignoreStat[1] = tms.TMNoTrainRespect
			ignoreStat[2] = tms.TMNoTrainPose
			ignoreStat[3] = tms.TMNoTrainSex
			ignoreStat[4] = tms.TMNoTrainCombat
		endif

		train_next = TrainActor(days,trainType,tmActor,ignoreStat)
		
		if train_next > 4
			debug.notification(slave.getDisplayName()+" has completed training of "+trainee.GetDisplayName()) 
			if (!slave.IsInFaction(PHSF.IsDesignatedTrainerFaction))
				slave.SetFactionRank(PHSF.IsDesignatedTrainerFaction, 1)	; Trainer can now be made a designated trainer.
			endif
			if (tm == None)
				SlaveTarget.ForceRefTo(Game.GetPlayer())
				slave.AddTofaction(PHSF.TrainerDoneFaction)
				PHSF.SlaveTarget(trainee).ForceRefTo(trainer)
				PHSF.SlaveRef(trainee).AccompanyPlayer()
			else
				actor exTrainee = trainee		; This variable is cleared upon release
				slave.AddTofaction(PHSF.TrainerDoneFaction)
				utility.wait(utility.Randomint(1, 10))	; Reduce chances of 2 trainers calling this at same time
				PHSF.Taskmaster.ReassignTrainers(tm, true)
				utility.wait(3)
				PHSF.ClearFromScene(exTrainee)		; In case a punishment scene is started just after clearing the training state
				PHSF.ClearFromScene(slave)
			endif
		else
			trainee.SetFactionRank(PHSF.IsTraineeFaction, train_next)
		endif
	elseif (slave.GetFactionRank(PHSF.TrainerPunishingFaction) != 0)	; Fix trainee stuck in cell when trainer wasn't told to put her there
		PHSF.SlaveTarget(trainee).ForceRefTo(trainer)
		PHSF.SlaveRef(trainee).AccompanyPlayer()
	endif
	LastTrainingTime = Utility.GetCurrentGameTime()
EndEvent

bool Function SetDOMActors()
	bool is_success = true
	if self_actor == None
		self_actor = (self as ReferenceAlias) as DOM_Actor
		if self_actor == None
			self_actor  = PHSF.PHHSHInter.DOM.GetActor(GetActorRef())
		endif
		if self_actor == None
			LogTrace("TrainActor ERROR could nto get DOM actor for self")
			is_success = false
		endif
	endif
	if trainee != None
		if trainee_actor == None
			trainee_actor = PHSF.PHHSHInter.DOM.GetActor(trainee)
			if trainee_actor == None
				LogTrace("TrainActor ERROR could not get DOM actor for trainee")
				is_success = false
			endif
		endif
	endif
	if trainer != None
		if trainer_actor == None
			trainer_actor = PHSF.PHHSHInter.DOM.GetActor(trainer)
			if trainer_actor == None
				LogTrace("TrainActor ERROR could not get DOM actor for trainer")
				is_success = false
			endif
		endif
	endif
	return is_success
EndFunction

int Function TrainActor(float days,int trainType, DOM_Actor taskmaster, bool[] ignoreStat)
	if !SetDOMActors()
		return 5 ; training is done
	endif
	float amount = 10.0
	bool[] skipStat = new bool[5]
	skipStat[0] = false ; submission
	skipStat[1] = false ; respect
	skipStat[2] = false ; pose
	skipStat[3] = false ; sex
	skipStat[4] = false ; combat
	if (trainType == 0) ; All but combat
		skipStat[4] = true ; combat
		;amount = 40.0
	elseif (trainType == 1) ; Pain
		skipStat[1] = true ; respect
		skipStat[2] = true ; pose
		skipStat[3] = true ; sex
		skipStat[4] = true ; combat
	elseif (trainType == 2) ; Sex
		skipStat[0] = true ; submission
		skipStat[1] = true ; respect
		skipStat[2] = true ; pose
		skipStat[4] = true ; combat
	elseif (trainType == 3) ; Combat
		skipStat[0] = true ; submission
		skipStat[1] = true ; respect
		skipStat[2] = true ; pose
		skipStat[3] = true ; sex
	elseif (trainType == 4) ; Pose
		skipStat[0] = true ; submission
		skipStat[1] = true ; respect
		skipStat[3] = true ; sex
		skipStat[4] = true ; combat
	endif ; trainType == 5 ; Everything

	float tm_bonus 
	if (taskmaster != None) 
		DOM_Mind akTmMind = taskmaster.mind
		float tm_skill = akTmMind.GetDeceiverModifier()
		float tm_extra = ((akTmMind.submission - 80.0) / 40.0) 
		if (akTmMind.respect_training > 50.0)
			tm_extra += ((akTmMind.respect_training - 50.0) / 100.0)
		endif
		tm_bonus = 1.0 + tm_skill + tm_extra/4.0
	else
		tm_bonus = 1.0
	endif

	float trainer_bonus
	float  subt
	float  humt
	float  regt
	float  feat
	float  angt
	float  rest
	float  post
	float  orat
	float  vagt
	float  anat
	float  comt

	if self_actor != None
		DOM_Mind akTrMind = self_actor.mind
		if trainType == 2 ; sex
			trainer_bonus = akTrMind.GetDepraverModifier()
		elseif trainType == 4 ; pose
			trainer_bonus = akTrMind.GetPersuaderModifier()
		else ; pain
			trainer_bonus = akTrMind.GetEnforcerModifier()
		endif
		subt = akTrMind.submission
		humt = akTrMind.humiliation
		regt = akTrMind.resignation
		feat = akTrMind.fear_training
		angt = akTrMind.anger_training
		rest = akTrMind.respect_training
		post = akTrMind.pose_training
		orat = akTrMind.oral_training
		vagt = akTrMind.vaginal_training
		anat = akTrMind.anal_training
		comt = akTrMind.combat_training
	else
		trainer_bonus = 0.5
		subt = 100.0
		humt = 100.0
		regt = 100.0
		feat = 100.0
		angt = 100.0
		rest = 100.0
		post = 100.0
		orat = 100.0
		vagt = 100.0
		anat = 100.0
		comt = 100.0
	endif
	float bonus = days * tm_bonus * trainer_bonus * 0.5 * PHSF.PHHSHInter.DOM.train_speed_npc

	; Current training stats for trainee
	DOM_Mind akSlMind = trainee_actor.mind
	float  sub  = akSlMind.submission
	float  hum  = akSlMind.humiliation
	float  reg  = akSlMind.resignation
	float  fea  = akSlMind.fear_training
	float  ang  = akSlMind.anger_training
	float  res  = akSlMind.respect_training
	float  pos  = akSlMind.pose_training
	float  ora  = akSlMind.oral_training
	float  vag  = akSlMind.vaginal_training
	float  ana  = akSlMind.anal_training
	float  com  = akSlMind.combat_training
	
	LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" before "+sub+" "+hum+" "+reg+" "+fea+" "+ang+" "+res+" | "+pos+" | "+ora+" "+vag+" "+ana+" | "+com)
	if self_actor
		LogTrace("TrainActor: trainer "+self_actor.GetName()+" bonus="+trainer_bonus+" "+subt+" "+humt+" "+regt+" "+feat+" "+angt+" "+rest+" | "+post+" | "+orat+" "+vagt+" "+anat+" | "+comt)
	else
		LogTrace("TrainActor: trainer NONE bonus="+trainer_bonus+" "+subt+" "+humt+" "+regt+" "+feat+" "+angt+" "+rest+" | "+post+" | "+orat+" "+vagt+" "+anat+" | "+comt)
	endif
	if taskmaster
		LogTrace("TrainActor: taskmaster/mistress "+taskmaster.GetName()+" bonus="+tm_bonus)
	else
		LogTrace("TrainActor: taskmaster/mistress NONE bonus="+tm_bonus)
	endif

	if trainType == 0 || trainType == 5 ; all but combat or everything
		akSlMind.number_of_pain += 1
		akSlMind.number_of_rape += 1
	elseif trainType == 1 ; pain
		akSlMind.number_of_pain += 1
	elseif trainType == 2
		akSlMind.number_of_rape += 1
	endif

	if !ignoreStat[0] && !skipStat[0] ; submission/humiliation/resignation
		if (sub < subt)
			akSlMind.TrainSubmission((amount+RandomFloat(0, amount))* bonus)
		endif
		if (hum < humt)
			akSlMind.TrainHumiliation((amount+RandomFloat(0, amount))* bonus)
		endif
		if (reg < regt)
			akSlMind.TrainResignation((amount+RandomFloat(0, amount))* bonus)
		endif
	endif
	if !ignoreStat[1] && !skipStat[1] ; fear/anger/respect
		if (fea < feat)
			akSlMind.TrainFear((amount+RandomFloat(0, amount))* bonus)
		endif
		if (ang < angt)
			akSlMind.TrainAnger((amount+RandomFloat(0, amount))* bonus)
		endif
		if (res < rest)
			akSlMind.TrainRespect((amount+RandomFloat(0, amount))* bonus)
		endif
	endif
	if !ignoreStat[2] && !skipStat[2] ; pose
		if (pos < post)
			akSlMind.TrainPose((amount+RandomFloat(0, amount))* bonus)
		endif
	endif
	if !ignoreStat[3] && !skipStat[3] ; sex
		if (ora < orat)
			akSlMind.TrainOral((amount+RandomFloat(0, amount))* bonus)
		endif
		if (vag < vagt)
			akSlMind.TrainVaginal((amount+RandomFloat(0, amount))* bonus)
		endif
		if (ana < anat)
			akSlMind.TrainAnal((amount+RandomFloat(0, amount))* bonus)
		endif
	endif
	if !ignoreStat[4] && !skipStat[4] ; combat
		if (com < comt)
			akSlMind.TrainCombat((amount+RandomFloat(0, amount))* bonus)
		endif
	endif
	
	; Update to values after training
	sub  = akSlMind.submission
	hum  = akSlMind.humiliation
	reg  = akSlMind.resignation
	fea  = akSlMind.fear_training
	ang  = akSlMind.anger_training
	res  = akSlMind.respect_training
	pos  = akSlMind.pose_training
	ora  = akSlMind.oral_training
	vag  = akSlMind.vaginal_training
	ana  = akSlMind.anal_training
	com  = akSlMind.combat_training

	LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" amount="+amount+" bonus="+bonus)
	LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" after "+sub+" "+hum+" "+reg+" "+fea+" "+ang+" "+res+" | "+pos+" | "+ora+" "+vag+" "+ana+" | "+com)

	; what to train next?
	int train_next

	; Check for training end
	bool doneSub = (((sub >= subt) && (hum >= humt) && (res >= rest)) || (ignoreStat[0])) 
	bool doneRes = (((res >= rest) && (fea >= feat) && (ang >= angt)) || (ignoreStat[1])) 
	bool doneSex = (((ora >= orat) && (vag >= vagt) && (ana >= anat)) || (ignoreStat[3])) 
	bool doneCom = ((com >= comt) || (ignoreStat[4])) 
	bool donePos = ((pos >= post) || (ignoreStat[2])) 

	if doneSub && doneRes && doneSex && donePos && doneCom
		LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" training done")
		if trainType == 0 || trainType == 5
			self_actor.mind.TrainAllTrainer()
		elseif trainType == 2 
			self_actor.mind.TrainSexTrainer()
		else
			self_actor.mind.TrainTrainer()
		endif
		if taskmaster != None
			taskmaster.mind.TrainHouseMistress()
		endif
		train_next = 5
	elseif (((trainType == 0) && (doneSub) && (doneRes)) || ((trainType == 1) && (doneSub)) || ((trainType == 2) && (doneSex)) || ((trainType == 3) && (doneCom)) || ((trainType == 4) && (donePos)) )
		if (sub < subt || hum < humt || reg < regt) && !doneSub
			LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" move to training 1 - submission")
			train_next = 1
		elseif (res < rest || fea < feat || ang < angt) && !doneRes
			LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" move to training 0 - all but combat")
			train_next = 0
		elseif (ora < orat || vag < vagt || ana < anat) && !doneSex
			LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" move to training 2 - sex")
			train_next = 2
		elseif com < comt && !doneCom
			LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" move to training 3 - combat")
			train_next = 3
		elseif pos < post && !donePos
			LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" move to training 4 - pose")
			train_next = 4
		else
			LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" move to training 5 - done ")
			train_next = 5
		endif
	else
		LogTrace("TrainActor: trainee "+trainee_actor.GetName()+" continue with training "+trainType)
		train_next = trainType
	endif
			
	trainee.SetFactionRank(PHSF.IsTraineeFaction, train_next)
	return train_next
EndFunction

Actor Function GetActor() 
	return GetRef() as Actor
EndFunction

Function CheckForSexPartners(Actor slave)
	FreeSexTicks += 1
	if (FreeSexTicks * SecsPerTick <150 + utility.Randomint(0, 30) )
		return
	endif
	FreeSexTicks = 0

	if (SexHook > 0)
		return
	endif

	if ((PHSF.IsBusy(slave)) || ( !PHSF.DOMSexlab.IsValidActor(slave)) || (slave.IsInFaction(PHSF.AccompanyFaction )) || (!slave.IsInFaction(PHSF.HouseFreeSexFaction)) || (slave.IsInFaction(PHSF.IsTrainerFaction)) || (slave.IsInFaction(PHSF.IsTraineeFaction))  )
		return
	endif

	PHSF.PortableFunctions.FindFreeSexPartner(slave)
EndFunction

; Get the leader (target actor) for a slave's current activity.  Never returns None
Actor Function GetLeader(int currentTask)
	Actor leader = None
	if (trainer == None)
		if ((currentTask >= 1) && (SlaveTarget != None) && (SlaveTarget.GetActorRef() != None))
			leader = SlaveTarget.GetActorRef()
		else
			leader = Game.GetPlayer()
		endif
	else
		leader = trainer
	endif
	return leader
EndFunction

bool Function CheckFixSlaveBusy(Actor slave)
	if ((slave.IsInFaction(PHSF.InSceneFaction)) || (SexHook >= 0) || ((PHSF.DOMZAZ.ZbfCrawlingEffect != None) && (slave.HasMagicEffect(PHSF.DOMZAZ.ZbfCrawlingEffect)))  )
		if (slave.IsInFaction(PHSF.HousePoseFaction))
			slave.RemoveFromFaction(PHSF.HousePoseFaction)
			PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
		endif
		return true	; Exit pose if in scene, and stop further processing
	endif
	return false
EndFunction

bool Function CheckFixInScene(Actor slave, Actor master)
	if ((IsInOSAScene(master)) || (IsInOSAScene(slave)) || (PHSF.PHHSHInter.IsActorActive(slave)) || (PHSF.IsInSSScene(slave)))
		slave.SetDontMove(false)
		return true
	endif
	return false
EndFunction

; Idle behaviour check for slave following a target
Function CheckForIdleBehaviour(Actor slave)
	LogTrace("CheckForIdleBehaviour")
	if (CheckFixSlaveBusy(slave))
		return
	endif

	int task = slave.GetFactionRank(PHSF.TaskAssignedFaction)

	Actor leader = GetLeader(task)

	if (CheckFixInScene(slave, leader))
		return
	endif

	if ((task == 2)	&& (!slave.IsInFaction(PHSF.IsTrainerFaction)))	; Entertain, check for nearby followers
		EntertainTicks += 1
		if (EntertainTicks * secsPerTick > 10)
			EntertainTicks = 0
			PHSF.Taskmaster.HandleEntertainment(self)
		endif
	endif

	float distance = slave.GetDistance(leader)
	float  movement = math.abs(lastX - slave.X) + math.abs(lastY - slave.Y)
	lastX = slave.X
	lastY = slave.Y

	if ((task == 2) && (!HasGreetedGuest) && (distance < 150))
		PHSF.ScenesSLA.SaySlave(slave, 1)
		HasGreetedGuest = true
	endif

	if ((leader.GetSitState() == 3) && (task != 1))		; Leader sitting and slave not in lineup
;		debug.notification("dance")
		slave.AddToFaction(PHSF.HousePoseFaction)
		if ((!IsBound) && (!IsYoked))
			PHSF.PHHSHInter.SendAnimationEvent(slave, "FNISSPc20")
		endif
	elseif ((math.abs(distance - LastPlayerDistance) < 25) && (distance < 150) && (movement < 5))
		PlayerNearTicks += 1
		if ((PlayerNearTicks * secsPerTick >=  3) && (!slave.IsInfaction(PHSF.HousePoseFaction)) && (slave.GetCurrentScene() == None))
			if (task == 1)
				if (GreetAngle < -360)
					GreetAngle = slave.GetAngleZ() + 90
				endif
				slave.TranslateTo(slave.X, slave.Y, slave.Z, slave.GetAngleX(), slave.GetAngleY(), greetAngle, 0, 300)
				utility.wait(0.5)
			else
				slave.SetLookAt(leader, true)
				slave.SetHeadTracking(true)
			endif

			slave.AddToFaction(PHSF.HousePoseFaction)
			GetActor().EvaluatePackage()

			if ((!IsBound) && (!IsYoked) && (PHSF.GreetType > 0) && (PHSF.GreetOwner))		; Add GreetOwner check
				if ((slave.GetSitState() != 0) && (PHSF.GreetType >= 3))
					PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
				endif

				PHSF.PHHSHInter.SendAnimationEvent(slave, PHSF.GreetAnim())
				isGreeting = true
			endif
			utility.wait(1)
			slave.SetDontMove()
			slave.ClearLookAt()
		endif
	else
		if ((!IsBound) && (!IsYoked) && (PlayerNearTicks))
			PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
		endif
		PlayerNearTicks = 0
		StopPosing(slave)
	endif
	LastPlayerDistance = distance
EndFunction

; Idle behaviour check for slave sandboxing or waiting
Function CheckForGreeting(Actor slave, bool once)
	LogTrace("CheckForGreeting")
	if (CheckFixSlaveBusy(slave))
		return
	endif

	if ((slave.IsInFaction(PHSF.InSceneFaction)) || (slave.GetCurrentScene() != None) || (slave.GetSleepState()==3) )
		if (slave.IsInFaction(PHSF.HousePoseFaction))
			slave.RemoveFromFaction(PHSF.HousePoseFaction)
			PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
		endif
		return
	endif

	int task = slave.GetFactionRank(PHSF.TaskAssignedFaction)

	Actor master = GetLeader(task)

	if (CheckFixInScene(slave, master))
		return
	endif

	if (task == 3)		; Pose faction: use nearby furniture
		if (utility.Randomint(1, 30) == 1)
			if (utility.Randomint(1, 2) == 1)
				if (PHSF.TryUseZapFurniture(slave, false))
					slave.RemoveFromFaction(PHSF.TaskAssignedFaction)
				endif
			else
				PHSF.PoseOnFurniture = utility.Randomint(0,1)
				if (utility.Randomint(1,2) == 1)
					PHSF.PoseAnim(slave, "FNISSPc24")
				else
					PHSF.PoseAnim(slave, "FNISSPc22")
				endif
				slave.RemoveFromFaction(PHSF.TaskAssignedFaction)
			endif
		endif
	elseif (task == 2)		; Entertain, check for nearby followers
		if (utility.Randomint(1, 10) == 1)
			PHSF.Taskmaster.HandleEntertainment(self)
		endif
	endif

	float distance = slave.GetDistance(master)
	if (distance < 150)	; Add GreetOwner check
		if ((!slave.IsInfaction(PHSF.HousePoseFaction)) && (!once || !hasGreeted  ) && (inhibitKneelTicks <= 0) && (!slave.IsInfaction(PHSF.IsTrainerFaction)) && (slave.GetCurrentScene() == None))
;			debug.notification("Kneel")
			slave.SetLookAt(Game.GetPlayer(), true)
			slave.SetHeadTracking(true)

			slave.AddToFaction(PHSF.HousePoseFaction)
			GetActor().EvaluatePackage()

			if ((!IsBound) && (!IsYoked) && (PHSF.GreetType > 0))
				utility.wait(1)
				if ((slave.GetSitState() != 0) && (PHSF.GreetType >= 3))
					PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
				endif
				PHSF.PHHSHInter.SendAnimationEvent(slave, PHSF.GreetAnim())
				isGreeting = true
			endif
			utility.wait(2)
			slave.SetDontMove()
			slave.ClearLookAt()
			hasGreeted = true
			KneelingTicks += 1
		elseif ((slave.IsInfaction(PHSF.HousePoseFaction)) && (PHSF.ExitGreeting))
			KneelingTicks += 1
			if ((KneelingTicks > math.floor(10.0 / secsPerTick)) && (slave.IsInFaction(PHSF.SandboxFaction) ))
				StopPosing(slave)
			endif
		endif
	else
		StopPosing(slave)
	endif
EndFunction

Function AdjustRelationshipRank()
	Actor slave = GetActorRef()
	int respect = PHSF.PHHSHInter.GetRespectTraining(slave)
	int rr = math.floor(((respect as float) / 100.0) * 8) - 4
	slave.SetRelationshipRank(Game.GetPlayer(), rr)
EndFunction

Function StopPosing(Actor slave)
	if (slave.IsInfaction(PHSF.HousePoseFaction))
;		Debug.Notification("Stop Posing")
		utility.wait(0.5)

		if ((IsBound) || (IsYoked))
			if (!isGreeting)
				PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
				EquipOutfit(true)
			endif
		else
			PHSF.PHHSHInter.SendAnimationEvent(slave, "IdleForceDefaultState")
		endif
		slave.RemoveFromFaction(PHSF.HousePoseFaction)
		slave.SetHeadTracking(false)
		slave.ClearLookAt()
		inhibitKneelTicks = math.floor(10.0 / secsPerTick)
		KneelingTicks = 0
		utility.wait(0.5)
	endif
	slave.SetDontMove(false)
	isGreeting = false
	GreetAngle = -999
EndFunction

PHHSHPortableCellScript Function GetHomeCell()
	LogTrace("GetHomeCell "+homeCell)
	if homeCell != None
		return homeCell
	endif
	Actor akRef = GetActorRef()
	if akRef == None
		return None
	endif
	homeCell = PHSF.PortableFunctions.HoldingCellrefForCell(akRef.GetParentCell()) as phhshPortableCellScript
	LogTrace("GetHomeCell New home cell found "+homeCell)
	return homeCell
EndFunction

bool Function IsInOSAScene(Actor a)
	return ((PHSF.OSAFaction != None) && (a.IsInFaction(PHSF.OSAFaction)) )
EndFunction

Function LogTrace(string msg)
	if PHSF.PHHSHInter.isVerboseMode()
		Debug.Trace("PHHSHHouseSlave: "+Name+": "+msg)
	endif
EndFunction


PHHSHStorageFunctions Property PHSF Auto	; Must be set in slot!
ReferenceAlias Property SlaveTarget Auto	; Must be set in slot or at init
PHHSHPortableCellScript Property homeCell Auto Hidden

bool Property HasGreeted Auto
bool Property HasGreetedGuest Auto
bool Property IsGreeting Auto
int Property InhibitKneelTicks Auto
int Property KneelingTicks Auto
int Property PlayerNearTicks Auto
int Property StopTicks Auto
int Property WaitingForArrival Auto			; 0=do not wait, 1=waiting, 2=arrived, 3=handled
int Property PunishmentTicks Auto
int Property FreeSexTicks Auto
int Property EntertainTicks Auto
int Property ZbfRefreshTicks Auto
float Property LastPlayerDistance Auto
int Property RepositionTicks Auto		; 0 = no action, >0 = nr of ticks to count down
; int Property BehaviorEvalTicks Auto

Form Property ClothesTorso Auto
Form Property ClothesHat Auto
Form Property ClothesHands Auto
Form Property ClothesBoots Auto

String Property LastBehaviour Auto
String Property NextBehaviour Auto
String Property RestrainedAnim Auto
String Property PunishAnim Auto

Armor Property WornRestraint Auto

Actor Property lastTarget Auto
Actor Property Trainee Auto
Actor Property Trainer Auto

DOM_Actor Property self_actor Auto
DOM_Actor Property trainee_actor Auto
DOM_Actor Property trainer_actor Auto

float Property lastX Auto
float Property lastY Auto
bool Property TraineeArrived Auto
float Property LastTrainingTime Auto

string Property Name Auto
Form[] Property WornStuff Auto
Form[] Property WornDDStuff Auto
int  Property IsDressingCounter Auto
bool Property IsBound Auto
bool Property IsYoked Auto
int Property SexHook Auto

bool Property DoNotClearFactions = false Auto
Cell Property LastCell Auto

ObjectReference Property FurnitureInUse Auto

ObjectReference Property BedroomMarker Auto
ObjectReference Property HouseMarker Auto
ObjectReference Property CellMarker Auto

String Property PoseAnim Auto
ObjectReference Property PoseFurnitureMarker Auto

ObjectReference Property ChainWristL Auto
ObjectReference Property ChainWristR Auto
ObjectReference Property ChainAnkleL Auto
ObjectReference Property ChainAnkleR Auto
ObjectReference Property ChainNeck Auto
bool Property DetachingHavok Auto

Form Property OffsetRestraint Auto
int Property OffsetRestraintSecs Auto

float Property GreetAngle Auto

; Taskmaster properties
bool Property TMNoTrainCombat Auto 
bool Property TMNoTrainSex Auto 
bool Property TMNoTrainSubmission Auto 
bool Property TMNoTrainRespect Auto 
bool Property TMNoTrainPose Auto 
bool Property TMAllowMilking Auto
bool Property TMReleaseFromMilking Auto

; Behaviour properties
bool Property BeAllowMilking = true Auto
bool Property BeAllowMilkingFurniture = true Auto
bool Property BeReleaseFromMilkFurniture = true Auto