Scriptname PHHSHTaskmaster extends Quest  Conditional

PHHSHInterface Property PHHSHInter Auto

Function CheckTaskmasters(Actor slave)
	bool hasTM = (TaskmasterInCell(slave.GetParentCell()) != None)
	HouseHasTaskmaster = hasTM
	if (!hasTM)
		AssignTaskmaster(slave)
	endif
EndFunction

Actor Function TaskmasterInCell(Cell c)
	if c == None
		return None
	endif
	phhshPortableCellScript the_cell = PHHSH.PortableFunctions.HoldingCellrefForCell(c) as phhshPortableCellScript
	if the_cell == None
		return None
	endif
	return the_cell.GetTaskMaster()
EndFunction

Function EvaluateTaskmaster(Actor taskmaster)
;	debug.notification("Evaluate")
	PHHSH.DebugLog("Evaluate taskmaster")
	InEval = true
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	int i = 0
	TMAllSlaves = 0
	TMUntrained = 0
	TMTrained = 0
	TMTrainers = 0
	TMTrainingExempt = 0
	TMSexTrained = 0
	TMSlavesAssembled = 0
	TMEntertainers = 0
	TMMales = 0
	TMFemales = 0
	TMMilkMaids = 0
	int sexTrained = 0

	phhshHouseSlave tmScript = PHHSH.SlaveRef(taskmaster)
	if (tmScript != None)
		TMNoTrainCombat = tmScript.TMNoTrainCombat 
		TMNoTrainSex = tmScript.TMNoTrainSex 
		TMNoTrainSubmission = tmScript.TMNoTrainSubmission 
		TMNoTrainRespect = tmScript.TMNoTrainRespect 
		TMNoTrainPose = tmScript.TMNoTrainPose 
		Behavior.AllowMilking = tmScript.TMAllowMilking
		Behavior.ReleaseFromMilkingFurniture = tmScript.TMReleaseFromMilking
	endif

	if (!EventStarted)
		RegisterForUpdateGameTime(3)
		EventStarted = true
	endif

	while (refsInCell[i] != None)
		Actor slave = refsInCell[i].GetActorRef()
		if ((slave != None) && (!slave.IsInFaction(PHHSH.TaskMasterFaction)))
			PHHSH.DebugLog("- Evaluate: " + slave.GetDisplayName())
			bool isSexTrained = isSexTrained(slave)
			if (IsAvailable(slave, false))		
				if (isUntrained(slave))
					TMUntrained += 1
				endif
				if (isTrained(slave))
					TMTrained += 1
				endif
				if (isSexTrained)
					TMSexTrained += 1
				endif
				if (PHHSH.PHHSHInter.DOM.DOMSexlab.GetGender(slave))
					TMFemales += 1
				else
					TMMales += 1
				endif
				int pl = slave.GetFactionRank(PHHSH.PAHPlayFaction)
				if (pl==1)
					TMDoms += 1
				elseif (pl==2)
					TMSubs += 1
				endif
			elseif (IsAvailable(slave, true))	
				TMTrainers += 1
			endif
			int task = slave.GetFactionRank(PHHSH.TaskAssignedFaction)
			if (task == 1)
				TMSlavesAssembled += 1
				if (isSexTrained)
					sexTrained += 1
				endif
			elseif (task == 2)
				TMEntertainers += 1
			endif
			if (slave.IsInFaction(PHHSH.TrainingExemptFaction))
				TMTrainingExempt += 1
			endif
			if (PHHSH.HasMME)
				if (slave.IsInFaction(PHHSH.MMEFunctions.MilkMaidFaction))
					TMMilkMaids += 1
				endif				
			endif

			TMAllSlaves += 1
		endif
		i += 1
	endwhile 

	; If all summoned slaves are also sex trained, enable the sex dialogues
	if ((sexTrained == TMSlavesAssembled) && (TMTypeInLineup != 4) )
		TMTypeInLineup = 3
	endif
	InEval = false

	PHHSH.DebugLog("- u:" + TMUntrained + "  t:" + TMTrained + "  tt:" + TMTrainers + "  s:" + TMSexTrained )
	PHHSH.DebugLog("- m:" + TMMales + "  f:" + TMFemales + "  l:" + TMSlavesAssembled )
EndFunction

Function EndEvaluateTaskmaster()
	int i = 0
	while ((InEval) && (i < 10))
		utility.wait(0.5)	; This will lock up the dialogue as well, like we want
		i += 1
	endwhile
	InEval = false
;		debug.notification("Taskmaster eval incomplete, try without skipping the dialogue")
;	endif
	PHHSH.SetMarkerConditionals(Game.GetPlayer())
EndFunction

Function AssignTaskmaster(Actor slave)
	slave.SetFactionRank(PHHSH.TaskmasterFaction, 1)
	slave.RemoveFromFaction(PHHSH.TrainingExemptFaction)
	slave.RemoveFromFaction(PHHSH.PAHPlayFaction)
	if  (slave.GetLeveledActorBase().GetSex() == 1)
		slave.SetDisplayName("Taskmistress " + slave.GetDisplayname())
	else
		slave.SetDisplayName("Taskmaster " + slave.GetDisplayname())
	endif
	if (slave.IsInFaction(PHHSH.IsDesignatedTrainerFaction))
		slave.SetFactionRank(PHHSH.IsDesignatedTrainerFaction, 1)
	endif

	HouseHasTaskmaster = true
	phhshPortableCellScript the_cell = PHHSH.PortableFunctions.HoldingCellrefForCell(slave.GetParentCell()) as phhshPortableCellScript
	if the_cell == None
		return
	endif
	the_cell.SetTaskMaster(slave)
EndFunction

Function DismissTaskmaster(Actor slave)
	if (slave.IsInFaction(PHHSH.TaskmasterFaction))
		slave.RemoveFromFaction(PHHSH.TaskmasterFaction)
		string n = slave.GetDisplayname()
		if (stringutil.find(n, "Taskmaster", 0) == 0)
			slave.SetDisplayName(stringutil.substring(n, 11, stringutil.getlength(n) - 11))
		endif
		if (stringutil.find(n, "Taskmistress", 0) == 0)
			slave.SetDisplayName(stringutil.substring(n, 13, stringutil.getlength(n) - 13))
		endif
		EventStarted = false		; Force re-registration of scheduled events
		PHHSH.PortableFunctions.SetTransferTarget(slave.GetParentCell(), None)
		HouseHasTaskmaster = false
		phhshPortableCellScript the_cell = PHHSH.PortableFunctions.HoldingCellrefForCell(slave.GetParentCell()) as phhshPortableCellScript
		if the_cell == None
			return
		endif
		the_cell.SetTaskMaster(None)
	endif
EndFunction

Function DesignateTrainer(Actor trainer, bool designate)
	if (designate)
		trainer.SetFactionRank(PHHSH.IsDesignatedTrainerFaction, 2)
	else
		trainer.SetFactionRank(PHHSH.IsDesignatedTrainerFaction, 1)
	endif
EndFunction


Function SetTrainerManagement(Actor slave, bool doManage)
	if (domanage)
		slave.SetFactionRank(PHHSH.TaskmasterFaction, 2)
	else
		slave.SetFactionRank(PHHSH.TaskmasterFaction, 1)
	endif
EndFunction

Function FetchOneSlave(Actor taskmaster, int type, bool sendToBed = false)   	; 1=untrained, 2=trained, 4=trainer, 3=lover
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	ReferenceAlias[] filterRefs = FilterArrayForType(refsInCell, type)
	int i = 0
	string s = "Match:\n"
	while (filterRefs[i] != None)
		s += filterRefs[i].GetActorRef().GetDisplayName() + "\n"
		i += 1
	endwhile
	s += i
;	debug.messagebox(s)

	ReferenceAlias selected = RandomRefFromArray(filterRefs)
	if (selected != None)
;		debug.notification("Selected: " + selected.GetActorRef().GetDisplayName())
		PHHSHHouseSlave tms = PHHSH.SlaveRef(taskmaster)
		if (!sendTobed)
			tms.PrepareToFetch(selected.GetActorRef())
;			selected.GetActorRef().SetFactionRank(PHHSH.TaskAssignedFaction, 1)		; 1=In Lineup
		else
			tms.LastTarget = Game.GetPlayer()
			PHHSH.SlaveTarget(taskmaster).ForceRefTo(selected.GetActorRef())
			tms.RestrainAtMarker("", 10)		
			(selected as PHHSHHouseSlave ).RestrainAtMarker("ZapWriPose07", 3, true)					
		endif
	endif
EndFunction

Function SummonSlaves(Actor taskmaster, int type)   	; 1=trained, 2=untrained, 4=trainer, 3=lover, 5=everyone, 6=entertainers, 7=females, 8=males, 9=exempt from training, 10=doms, 11=subs, 12=milkmaids, 13=to be milked, 14=5 Random slaves
	TMTypeInLineup = type
	LineupWaiting = false
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	ReferenceAlias[] filterRefs = FilterArrayForType(refsInCell, type)
	int i = 0
	if (filterRefs[i] != None)
		PHHSHHouseSlave tms = PHHSH.SlaveRef(taskmaster)
		tms.PrepareToFetch(filterRefs[0].GetActorRef())

		while (filterRefs[i] != None)
			Actor slave = filterRefs[i].GetActorRef()
			if (filterRefs[i + 1] != None)
				Actor slaveN = filterRefs[i+1].GetActorRef()
				PHHSH.SlaveTarget(slaveN).ForceRefTo(slave)
				(filterRefs[i +1] as PHHSHHouseSlave).AccompanyPlayer()
;debug.notification(slaveN.GetDisplayName() + " follows " + slave.GetDisplayName())
			endif
			slave.SetFactionRank(PHHSH.TaskAssignedFaction, 1)		; 1=In Lineup
			if (slave.IsInFaction(PHHSH.IsTrainerFaction))
				EnsureTrainerBringsTrainee(slave)
			endif
			i += 1
		endwhile
	endif
EndFunction

Function CommandAllSlaves(Actor taskmaster, int command)		; 1=To cell, 2=Sandbox, 3=stop task
	PHHSHHouseSlave tms = PHHSH.SlaveRef(taskmaster)
	tms.Sandbox()
	utility.wait(5)
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	int i = 0;
	while (refsInCell[i] != None)
		Actor slave = refsInCell[i].GetActorRef()
		if ((slave != taskmaster) && (!slave.IsInFaction(PHHSH.IsTraineeFaction)) )
			if (command == 1)
				(refsInCell[i] as PHHSHHouseSlave).WaitInCell()
			elseif (command == 2)
				(refsInCell[i] as PHHSHHouseSlave).Sandbox()
			elseif (command == 3)
				DismissFromTask(slave)
			endif
			RemoveFromTask(slave, true)
		endif
		i += 1
	endwhile
	utility.wait(2)
	returnTaskmasterToPlayer(taskmaster)
EndFunction

Function CommandTrainers(Actor taskmaster, int command)		; 1=stop training	2=train
	PHHSHHouseSlave tms = PHHSH.SlaveRef(taskmaster)
	tms.Sandbox()
	utility.wait(5)
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	ReferenceAlias[] filterRefs = FilterArrayForType(refsInCell, 4)

	int i = 0;
	while (filterRefs [i] != None)
		Actor slave = filterRefs [i].GetActorRef()
		if (command == 1)
;			PHHSH.BringTraineeToCell(slave)
;			(filterRefs [i] as PHHSHHouseSlave).Trainee.SetFactionRank(PHHSH.HouseCagedFaction, 1)
			PHHSH.SlaveRef((filterRefs [i] as PHHSHHouseSlave).Trainee).WaitInCell()
			slave.SetFactionRank(PHHSH.TrainerPunishingFaction, 0)
		elseif (command == 2)
;			(filterRefs [i] as PHHSHHouseSlave).Trainee.RemoveFromFaction(PHHSH.HouseCagedFaction)
			PHHSH.SlaveTarget((filterRefs [i] as PHHSHHouseSlave).Trainee).ForceRefTo(slave)
			PHHSH.SlaveRef((filterRefs [i] as PHHSHHouseSlave).Trainee).AccompanyPlayer()
			slave.RemoveFromFaction(PHHSH.TrainerPunishingFaction)
			(filterRefs [i] as PHHSHHouseSlave).Sandbox()
		endif
		i += 1
	endwhile
	utility.wait(2)
	returnTaskmasterToPlayer(taskmaster)
EndFunction

; 1=To cell, 2=Sandbox; 3=Bedroom, 4=travel, 5=pose, 6=entertain, 7=wait, 8=mark bedroom, 9=mark house, 10=mark cell, 11=strip, 12=dress, 13=follow, 14=exempt from training, 15=include in training
; 16=Stop play, 17=Random play, 18=Allow Milk, 19=Deny milk, 20=Allow milk machines, 21=Deny milking machines 22=allow release from machine, 23=deny release
Function CommandSummonedSlaves(Actor taskmaster, int command)			
	bool voicedCommand = ((command >=7) && (command <= 23))
	PHHSHHouseSlave tms = PHHSH.SlaveRef(taskmaster)

	if (command == 4)
		if (MsgTransport.Show() == 0)
			return
		endif
	endif

	if (!voicedCommand )
		tms.Sandbox()
	endif

	ReferenceAlias[] newRefs = new ReferenceAlias[101]
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	int i = 0;
	while (refsInCell[i] != None)
		newRefs[i] = refsInCell[i]
		i += 1
	endwhile

	if (command == 7)
		utility.wait(2)
		LineupWaiting = true
	elseif (command == 13)
		LineupWaiting = false
	elseif (voicedCommand )
;		utility.wait(1)
	else
		utility.wait(5)
	endif

	PHHSH.DebugLog("Command " + command + " to slaves in lineup")
	i = 0
	Actor followTarget = Game.GetPlayer()
	while (newRefs[i] != None)
		Actor slave = newRefs[i].GetActorRef()
		PHHSH.DebugLog("- Process " + slave.GetDisplayName())
		if ((slave != taskmaster) && (slave.GetFactionRank(PHHSH.TaskAssignedFaction) == 1) )
			if (command == 1)
				(newRefs[i] as PHHSHHouseSlave).WaitInCell()
			elseif (command == 2)
				(newRefs[i] as PHHSHHouseSlave).Sandbox()
			elseif (command == 5)
				slave.SetFactionRank(PHHSH.TaskAssignedFaction, 3)
				(newRefs[i] as PHHSHHouseSlave).Sandbox()
			elseif (command == 6)
				CommandToEntertain(slave)
			elseif (command == 7)
;				(newRefs[i] as PHHSHHouseSlave).Wait()
				PHHSH.PoseAnim(slave, PHHSH.GreetAnim())
			elseif (command == 8)
				PHHSH.SetRoomMarker(slave, 3)
			elseif (command == 9)
				PHHSH.SetRoomMarker(slave, 2)
			elseif (command == 10)
				PHHSH.SetRoomMarker(slave, 1)
			elseif (command == 11)
				PHHSH.DoUndress(slave, true)		; Inhibit animation on undress, since SerialStrip is not multithreaded
			elseif (command == 12)
				PHHSH.Dress(slave)
			elseif (command == 13)
				(newRefs[i] as PHHSHHouseSlave).AccompanyPlayer()
			elseif (command == 14)
				slave.AddToFaction(PHHSH.TrainingExemptFaction)
				if (slave.IsInFaction(PHHSH.IsTrainerFaction))
					PHHSH.ReleaseTrainee(slave, true)
				elseif (slave.IsInFaction(PHHSH.IsTraineeFaction))
					if ((newRefs[i] as PHHSHHouseSlave).trainer != None)
						PHHSH.ReleaseTrainee((newRefs[i] as PHHSHHouseSlave).trainer, true)
					endif
				endif
			elseif (command == 15)
				slave.RemoveFromFaction(PHHSH.TrainingExemptFaction)
			elseif (command == 16)
				phhsh.SetPlay(slave, 0)
			elseif (command == 17)
				phhsh.SetPlay(slave, utility.Randomint(1, 2))
			elseif (command == 3)
				(newRefs[i] as PHHSHHouseSlave ).RestrainAtMarker("ZapWriPose07", 3)		
			elseif (command == 18)
				(newRefs[i] as PHHSHHouseSlave ).BeAllowMilking = true		
			elseif (command == 19)
				(newRefs[i] as PHHSHHouseSlave ).BeAllowMilking = false		
			elseif (command == 20)
				(newRefs[i] as PHHSHHouseSlave ).BeAllowMilkingFurniture = true		
			elseif (command == 21)
				(newRefs[i] as PHHSHHouseSlave ).BeAllowMilkingFurniture = false		
			elseif (command == 22)
				(newRefs[i] as PHHSHHouseSlave ).BeReleaseFromMilkFurniture = true		
			elseif (command == 23)
				(newRefs[i] as PHHSHHouseSlave ).BeReleaseFromMilkFurniture = false		
			elseif (command == 4)
				bool xfer = false
				PHHSH.DebugLog("  Deregister")
				PHHSH.DeRegisterFromWhiteRun(slave)
				xfer = PHHSHInter.FollowTarget(slave,followTarget)
				if (xfer)
					followTarget = slave				
					PHHSH.DebugLog("  Transfer complete")
					Form item
					if ((!PHHSH.hasTaraAnims) && (!PHHSH.hasTaraAnims2))
						item= PHHSH.yoke
					else
						item= PHHSH.RestraintsFunctions.RanDOMWornCollar()
						if (item==  None)
							item= PHHSH.yoke
						endif
					endif
					slave.EquipItem(item, true)
				else
					PHHSH.DebugLog("  Could not transfer " + 	slave.GetDisplayName())
				endif
			endif
			if (!voicedCommand )
				RemoveFromLineup(slave)
			endif
		endif
		i += 1
	endwhile
	PHHSH.DebugLog("Done processing lineup command")
	utility.wait(2)
	returnTaskmasterToPlayer(taskmaster)
	if (command == 4)
		PHHSH.ScenesSLA.SayTM(taskmaster, 1)
	endif
EndFunction

Function Test(Actor slave)
	debug.notification("Test")
EndFunction

Function CommandToEntertain(Actor slave)
	slave.SetFactionRank(PHHSH.TaskAssignedFaction, 2)
	PHHSHHouseSlave slaveRef = PHHSH.SlaveRef(slave)
	slaveRef.Sandbox()
EndFunction

bool Function IsAvailable(Actor slave, bool includeTrainers, int excludeTask = 1)
;	if ((!slave.IsInFaction(PHHSH.InSceneFaction)) && (!slave.IsInFaction(PHHSH.TaskAssignedFaction)) && (!slave.IsInFaction(PHHSH.TaskmasterFaction)) && (!slave.IsInFaction(PHHSH.WallChainFaction)) && (!slave.IsInFaction(PHHSH.IsTraineeFaction))  )
	if ( (slave.GetFactionRank(PHHSH.TaskAssignedFaction) != excludeTask) && (!slave.IsInFaction(PHHSH.TaskmasterFaction)) && (!slave.IsInFaction(PHHSH.IsTraineeFaction))  )
		return ((includeTrainers) || (!slave.IsInFaction(PHHSH.IsTrainerFaction)) )
	else
		return false
	endif		
EndFunction


Function EnsureTrainerBringsTrainee(actor trainer)
	PHHSHHouseSlave trainerRef = PHHSH.SlaveRef(trainer)
	if (trainerRef != None)
		Actor trainee = trainerRef.trainee
		if (trainee != None)
			PHHSHHouseSlave traineeRef = PHHSH.SlaveRef(trainee)
			if ((!trainee.IsInFaction(PHHSH.AccompanyFaction)) || (PHHSH.SlaveTarget(trainee).GetRef() != trainer))
				PHHSH.SlaveTarget(trainee).ForceRefTo(trainer)
				traineeRef.AccompanyPlayer()
			endif
		endif
	endif
EndFunction

Function HandleEntertainment(PHHSHHouseSlave slaveRef )
	Actor slave = slaveRef.GetActorRef()
	if ((slave != None) && (!slave.IsInFaction(PHHSH.IsTrainerFaction)) && (!slave.IsInFaction(PHHSH.IsTraineeFaction)))
;		Debug.notification(slave.GetDisplayName() +  " entertaining")
		if (slave.IsInFaction(PHHSH.AccompanyFaction))
			; Slave is already following someone
			ReferenceAlias targetRef = PHHSH.SlaveTarget(slave)
			if ((targetRef != None) && (targetRef.GetActorRef() != None)  && (!targetRef.GetActorRef().IsInFaction(PHHSH.HouseSlaveFaction)) && ( (targetRef.GetActorRef().IsInFaction(PHHSH.FollowerFaction)) ||  (targetRef.GetActorRef().IsInFaction(PHHSH.HouseCarlFaction)) ) )
				; Slave is assigned to valid follower
				int act = utility.Randomint(1, 10)
;				debug.notification(act)
				if (act == 1)
					PHHSH.ScenesSLA.SaySlave(slave, 2)
				elseif (act == 2)
					PHHSH.ScenesSLA.SaySlave(slave, 3)
					Actor[] sexActors = new actor[2]
					if ((!PHHSH.PHHSHInter.DOM.DOMSexlab.GetGender(slave)) && (PHHSH.PHHSHInter.DOM.DOMSexlab.GetGender(targetRef.GetActorRef())))
						; Swap roles if guest is female and slave is male
    						sexActors[0] = targetRef.GetActorRef()
    						sexActors[1] = slave
					else
    						sexActors[1] = targetRef.GetActorRef()
    						sexActors[0] = slave
					endif
					int sexHook = slave.GetFormId()
					if (sexHook < 0)
						sexHook = math.abs(sexHook) as int
					endif
					slaveRef.SexHook = sexHook
					slave.AddToFaction(PHHSH.InSceneFaction)
					slave.SetDontMove(false)
					;Debug.Trace("PHHSHTaskMaster send anim=IdleForceDefaultState")
					Debug.SendAnimationEvent(slave, "IdleForceDefaultState")
				    	sslBaseAnimation[] anims
 			   		anims = PHHSH.PHHSHInter.DOM.DOMSexlab.GetAnimationsByTagsBase(2, "")

   					PHHSH.DOMSexlab.StartSex(sexActors, anims, victim=None, allowBed=true, hook="" + sexHook)
					slaveRef.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
				endif
			else
				; Slave is following someone else, ignore
			endif
		else
			; Slave is not following, find a partner
			Actor guest = PHHSH.ActorDetector.RandomFollower()
			if (guest != None)
;				debug.notification("Attempt to assign to " + guest.GetDisplayName())
				; Check if no other slaves are assigned to this guest
				bool unassigned = true

				ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(slave.GetParentCell())
				ReferenceAlias[] filterRefs = FilterArrayForType(refsInCell, 6)
				int i = 0;
				while ((filterRefs [i] != None) && (unassigned))
					Actor entSlave = filterRefs [i].GetActorRef()
					Actor entSlaveTarget = PHHSH.SlaveTarget(entSlave).GetActorRef()
					if (entSlaveTarget == guest)
						unassigned = false
					endif
					i += 1
				endwhile

				if (unassigned)
;					debug.notification("Entertaining " + guest.GetDisplayName())
					slaveRef.HasGreetedGuest = false
					PHHSH.Slavetarget(slave).ForceRefTo(guest)
					slaveRef.AccompanyPlayer()
				endif
			endif
		endif
	endif
EndFunction

; Calling this with isTaskmaster = false will assume the specified actor is a designated trainer instead of a taskmaster
Function ReassignTrainers(Actor taskmaster, bool isTaskmaster)
	if (ReassigningTrainers)
		return			; Only execute in 1 thread
	else
		ReassigningTrainers = true
	endif

	PHHSH.DebugLog("Reassign trainers by taskmaster " + taskmaster.GetDisplayName())
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	phhshPortableCellScript currentCell = PHHSH.PortableFunctions.HoldingCellrefForCell(taskmaster.GetParentCell()) as phhshPortableCellScript
;	phhshPortableCellScript targetCell = currentCell.TransferTarget as phhshPortableCellScript
	Cell targetCell = currentCell.TransferTargetCell

	phhshHouseSlave tmScript = None		; Used to retrieve the training settings for this house
	if (isTaskmaster)
		tmScript = PHHSH.SlaveRef(taskmaster)
	else
		actor realTM = TaskmasterInCell(taskmaster.GetParentCell())
		if (realTM != None)
			tmScript = PHHSH.SlaveRef(realTM)
		endif
	endif

	if (tmScript != None)
		PHHSH.DebugLog("  Has Taskmaster info")
	endif

	int nrSlavesToTransfer = 0
	Actor[] SlavesToTransfer = new Actor[101]

	; Release trainers when they are done
	int i = 0
	while (refsInCell[i] != None)
		Actor slave = refsInCell[i].GetActorRef()
		if ((slave != None) && (slave.IsInFaction(PHHSH.TrainerDoneFaction)) )
			phhshHouseSlave trainer = PHHSH.SlaveRef(slave)
			if (trainer.Trainee.GetFactionRank(PHHSH.IsDesignatedTrainerFaction) != 2)
				slavesToTransfer[nrSlavesToTransfer] = trainer.Trainee
				nrSlavesToTransfer += 1
			endif
			PHHSH.ReleaseTrainee(slave, false)
			trainer.Sandbox()
			PHHSH.DebugLog(slave.GetDisplayName() + " released trainee")
		endif
		i += 1
	endwhile

	; Loop over all potential trainers and see if there is someone for them to train	
	TMReassignedTrainers = 0
	i = 0
	while (refsInCell[i] != None)
		Actor slave = refsInCell[i].GetActorRef()
		if ((slave != None) && (!slave.IsInFaction(PHHSH.IsTrainerFaction)) && \
				((!slave.IsInFaction(PHHSH.TrainerDoneFaction)) || (targetCell == None)) && \	
				((taskmaster.GetFactionRank(PHHSH.TaskmasterFaction) == 2) || (slave.GetFactionRank(PHHSH.IsDesignatedTrainerFaction) == 2)) \
				)  ; Either tasmkmaster is managing training or prospective trainer is designated.


;PHHSH.DebugLog("T: " + slave.GetDisplayName())
			int j = 0
			while (refsInCell[j] != None)
				Actor trainee = refsInCell[j].GetActorRef()
;PHHSH.DebugLog("   S: " + trainee.GetDisplayName())
				if ((trainee != None) && (CanTrain(slave, trainee, tmScript )) )
					PHHSH.DebugLog("Assigning " + slave.GetDisplayName() + " to train " + trainee.GetDisplayName())
					PHHSH.AssignTrainerToTrainee(slave, trainee)
					PHHSH.SlaveRef(slave).Sandbox()
					TMReassignedTrainers = 1
				endif
				j += 1
			endwhile
		endif
		i += 1
	endwhile

	while (isTaskmaster) && (nrSlavesToTransfer > 0)
		nrSlavesToTransfer -= 1
		Actor slave = SlavesToTransfer[nrSlavesToTransfer]
		; Check here if slave did not get reassigned to / as a new trainer
		if ((slave != None) && (!slave.IsInFaction(PHHSH.IsTraineeFaction)) && (!slave.IsInFaction(PHHSH.IsTrainerFaction)) )
			; Also apply tattoo if specced
			if (PHHSH.HasSlaveTats) 
				if (PHHSH.SlaveTatsFunctions.CheckArray(currentCell.TattooTrained))
					PHHSH.SlaveTatsFunctions.ApplyTats(slave, currentCell.TattooTrained)
				endif
			endif

			;Transfer
			if (targetCell != None)
				ReferenceAlias targetCellRef = PHHSH.PortableFunctions.HoldingCellrefForCell(targetCell)
				if ((targetCellRef != None) && (targetCellRef.GetRef() != None))
					currentCell.RemoveSlave(PHHSH.SlaveRef(slave))
					PHHSH.SlaveRef(slave).Wait()
					utility.wait(0.2)
					slave.MoveTo(targetCellRef.GetRef())
					PHHSH.SlaveRef(slave).Wait()
					PHHSH.SlaveRef(slave).ClearDefaultMarkers()
					utility.wait(0.2)
					if !PHHSH.FlexiStorage.RegisterInSpecifiedCell(slave, targetCell)
						debug.notification("Transfer of trained slave " +  slave.GetDisplayName() + " to " + targetCell.GetName() + " failed")
						return
					endif
					PHHSH.SlaveRef(slave).WaitInCell()
					PHHSH.DebugLog("Transfer trained slave " + slave.GetDisplayName() + " to " + targetCellRef.GetRef().GetCurrentLocation().GetName())
					debug.notification("Trained slave " + slave.GetDisplayName() + " transferred to " + targetCellRef.GetRef().GetCurrentLocation().GetName())
				else
					debug.notification("Transfer of trained slave " +  slave.GetDisplayName() + " to " + targetCell.GetName() + " failed, no cell installed there")
					return
				endif
			endif			
		endif
	endwhile

	ReassigningTrainers = false
EndFunction

bool Function CanTrain(Actor trainer, Actor trainee, phhshHouseSlave taskmasterScript)
	bool NoTrainCombat = false 
	bool NoTrainSex = false 
	bool NoTrainSubmission = false 
	bool NoTrainRespect = false 
	bool NoTrainPose = false 

	if (taskmasterScript != None)
		NoTrainCombat = taskmasterScript.TMNoTrainCombat 
		NoTrainSex = taskmasterScript.TMNoTrainSex 
		NoTrainSubmission = taskmasterScript.TMNoTrainSubmission 
		NoTrainRespect = taskmasterScript.TMNoTrainRespect 
		NoTrainPose = taskmasterScript.TMNoTrainPose 
	endif

	PHHSH.DebugLog("   >>> Check " + trainee.GetDisplayName() + " trained by " + trainer.GetDisplayName())
	PHHSH.DebugLog("       Combat/Sex/Sub/Res/Pose:" + NoTrainCombat + ", " + NoTrainSex + ", " + NoTrainSubmission + ", " + NoTrainRespect + ", " + NoTrainPose)

	if ((trainer.IsInFaction(PHHSH.IsTrainerFaction)) || (trainer.IsInFaction(PHHSH.IsTraineeFaction)) || (trainee.IsInFaction(PHHSH.IsTrainerFaction)) || (trainee.IsInFaction(PHHSH.IsTraineeFaction)) || (trainer.IsInFaction(PHHSH.TaskmasterFaction)) || (trainee.IsInFaction(PHHSH.TaskmasterFaction)) )
		return false		; Invalidate if either candidate is already involved in training or is the taskmaster
	endif
	
	if ((trainer.IsInFaction(PHHSH.TrainingExemptFaction)) || (trainee.IsInFaction(PHHSH.TrainingExemptFaction)))
		return false		; No training if either slave is exempted from training
	endif

	if (trainer.IsInFaction(PHHSH.HouseCagedFaction))
		return false		; No training if trainer is confined to a cell
	endif

	if (trainee.GetFactionRank(PHHSH.IsDesignatedTrainerFaction) == 2)	; Cannot train designated trainers
		return false
	endif

	int tsub = PHHSHInter.GetSubmissionTraining(trainer)
	if tsub < 70
		return false
	else
		if !NoTrainSubmission
			if tsub > PHHSHInter.GetSubmissionTraining(trainee)
				return true
			endif
			int treg = PHHSHInter.GetResignationTraining(trainer)
			if treg > PHHSHInter.GetResignationTraining(trainee)
				return true
			endif
			int thum = PHHSHInter.GethumiliationTraining(trainer)
			if thum > PHHSHInter.GetHumiliationTraining(trainee)
				return true
			endif
		endif
		if !NoTrainSex
			int tsex = PHHSHInter.GetSexTraining(trainer)
			if tsex > PHHSHInter.GetSexTraining(trainee) + 1
				return true
			endif
		endif
		if !NoTrainPose
			int tpos = PHHSHInter.GetPoseTraining(trainer)
			if tpos > PHHSHInter.GetPoseTraining(trainee)
				return true
			endif
		endif
		if !NoTrainRespect
			int tres = PHHSHInter.GetRespectTraining(trainer)
			if tres > PHHSHInter.GetRespectTraining(trainee)
				return true
			endif
			int tfea = PHHSHInter.GetFearTraining(trainer)
			if tfea > PHHSHInter.GetFearTraining(trainee)
				return true
			endif
			int tang = PHHSHInter.GetAngerTraining(trainer)
			if tang > PHHSHInter.GetAngerTraining(trainee)
				return true
			endif
		endif
		if !NoTrainCombat
			int tcom = PHHSHInter.GetCombatTraining(trainer)
			if tcom > PHHSHInter.GetCombatTraining(trainee)
				return true
			endif
		endif
		return false
	endif
EndFunction

Event OnUpdateGameTime()
;	Debug.Notification("Training check")
	int i = 0
	int n = PHHSH.PortableFunctions.CellRefs.length
	while i < n
		ProcessTrainerRoster(PHHSH.PortableFunctions.CellRefs[i])
		i += 1
	endwhile
;	Debug.Notification("Training check done")
EndEvent

Function ProcessTrainerRoster(ReferenceAlias cellRef)
	if ((cellRef.GetRef() != None) && ((cellRef as PHHSHPortableCellScript).ParentCell != None))
		ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell((cellRef as PHHSHPortableCellScript).ParentCell)
		int i = 0
		Actor taskmaster = None
		Actor designatedTrainer = None
		while ((refsInCell[i] != None) && (taskmaster == None))
			if (refsInCell[i].GetActorRef().GetFactionRank(PHHSH.TaskmasterFaction) == 2)
				taskmaster = refsInCell[i].GetActorRef()
;				debug.notification("Got trainer manager:" + taskmaster.GetDisplayName())
			endif
			if (refsInCell[i].GetActorRef().GetFactionRank(PHHSH.IsDesignatedTrainerFaction) == 2)
				designatedTrainer = refsInCell[i].GetActorRef()
;				debug.notification("Got designated trainer:" + designatedTrainer.GetDisplayName())
			endif
			i += 1
		endwhile

		if (taskmaster != None)
			ReassignTrainers(taskmaster, true)
		elseif (designatedTrainer != None)
			ReassignTrainers(designatedTrainer, false)
		endif
	endif
EndFunction

ReferenceAlias[] Function FilterArrayForType(ReferenceAlias[] refs, int filter)	
	; 1=untrained, 2=trained, 4=trainer, 3=lover, 5=everyone, 6=entertainer, 7=females, 
	; 8=males, 9=training exempt, 10=play dom, 11=play sub, 12=milkmaids, 13=to be milked, 14=5 Random slaves
	ReferenceAlias[] newRefs = new ReferenceAlias[101]
	int i = 0
	int numRefs = 0

	while (refs[i] != None) && ((filter != 14) || (numrefs < 5))
		Actor slave = refs[i].GetActorRef()
		if ((filter == 5) && (!slave.IsInFaction(PHHSH.IsTraineeFaction)) && (!slave.IsInFaction(PHHSH.TaskMasterFaction)))
			newRefs[numRefs] = refs[i]
			numRefs += 1
		elseif (filter == 14)
			if (IsAvailable(slave, false))					
				newRefs[numRefs] = refs[i]
				numRefs += 1
			endif
		else
			if (IsAvailable(slave, false))		
				if ((filter == 1) && (isUntrained(slave)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 2) && (isTrained(slave)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 3) && (isSexTrained(slave)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 6) && (isEntertainer(slave)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 7) && (PHHSH.DOMSexlab.GetGender(slave)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 8) && (!PHHSH.DOMSexlab.GetGender(slave)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 9) && (slave.IsInFaction(PHHSH.TrainingExemptFaction)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 10) && (slave.GetFactionRank(PHHSH.PAHPlayFaction) == 1) &&  (!slave.IsInFaction(PHHSH.IsTraineeFaction)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 11) && (slave.GetFactionRank(PHHSH.PAHPlayFaction) == 2) &&  (!slave.IsInFaction(PHHSH.IsTraineeFaction)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 12) && (slave.IsInFaction(PHHSH.MMEFunctions.MilkMaidFaction)))
					newRefs[numRefs] = refs[i]
					numRefs += 1
				elseif ((filter == 13) && (slave.IsInFaction(PHHSH.MMEFunctions.MilkMaidFaction)))
					if ((!PHHSH.MMEFunctions.IsBeingMilked(slave)) && (PHHSH.MMEFunctions.ReadyForMilking(slave)))
						newRefs[numRefs] = refs[i]
						numRefs += 1
					endif
				endif
			elseif (IsAvailable(slave, true))	
				if (filter == 4)
					newRefs[numRefs] = refs[i]
					numRefs += 1
				endif
			endif
		endif
		i += 1
	endwhile
	return newRefs
EndFunction

ReferenceAlias Function RandomRefFromArray(ReferenceAlias[] refs)
	int i = 0
	while (refs[i] != None)
		i += 1
	endwhile
	if (i > 0)
		return refs[utility.Randomint(0, i - 1)]
	else
		return None
	endif
EndFunction

Function returnTaskmasterToPlayer(actor taskmaster)
	PHHSHHouseSlave tms = PHHSH.SlaveRef(taskmaster)
	PHHSH.SlaveTarget(taskmaster).ForceRefTo(Game.GetPlayer())
	tms.AccompanyPlayer()
EndFunction

bool Function IsUntrained(Actor slave)
	return (PHHSHInter.GetSubmissionTraining(slave) < 70)
EndFunction

bool Function IsTrained(Actor slave)
	return (PHHSHInter.GetSubmissionTraining(slave) >= 70)
EndFunction

bool Function IsEntertainer(Actor slave)
	return (slave.GetFactionRank(PHHSH.TaskAssignedFaction) == 2)
EndFunction


; Task 1=Lineup, 2=Entertain, 3=Pose
Function RemoveFromTask(Actor slave, bool anyTask = false)
	int task = slave.GetFactionRank(PHHSH.TaskAssignedFaction)
	if (task == 1)
		RemoveFromLineup(slave)
	elseif (anyTask)
		slave.RemoveFromFaction(PHHSH.TaskAssignedFaction)
	endif
EndFunction

Function RemoveFromLineup(Actor slave)
	int task = slave.GetFactionRank(PHHSH.TaskAssignedFaction)
	if (task == 1) 
		Actor following = None
		Actor follower = None

		ReferenceAlias slaveTarget = PHHSH.SlaveTarget(slave)
		if (slaveTarget != None)
			following = slaveTarget.GetActorRef()
		endif
		
		; Remove this slave from the linked list
		ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(slave.GetParentCell())
		int i = 0;
		while (refsInCell[i] != None)
			Actor a = refsInCell[i].GetActorRef()
			if (a.GetFactionRank(PHHSH.TaskAssignedFaction) == 1)
				ReferenceAlias aTarget = PHHSH.SlaveTarget(a)
				if ((aTarget != None) && (aTarget.GetActorRef() == slave))
					follower = a
				endif
			endif
			i += 1
		endwhile

		if ((follower != None) && (following != None))
			PHHSH.SlaveTarget(follower).ForceRefTo(following)
		endif

		slave.RemoveFromFaction(PHHSH.TaskAssignedFaction)
	endif
EndFunction

Function DismissFromTask(Actor slave)
	PHHSHHouseSlave ref = PHHSH.SlaveRef(slave)
	RemoveFromTask(slave, true)
	ref.WaitInCell()
EndFunction

bool Function IsSexTrained(Actor slave)
	if PHHSHInter.GetSubmissionTraining(slave) < 70
		return false
	endif
	if PHHSHInter.GetSexTraining(slave) < 40
		return false
	endif
	return true
EndFunction

; Calculate new skill level for trainee, taking into account: duration of training (in days), trainer and taskmaster bonuses, training settings
int Function TrainSkill(int trainType, int traineeSkill, int trainerSkill, float days, float factor, Actor trainer, Actor taskmaster)
	float bonus = 1.0
	; TODO: Revise this code to take taskmaster and trainer stats into account
	if (taskmaster != None) 
		DOM_Actor akTM = PHHSHInter.DOM.GetActor(taskmaster) 
		if akTM != None
			if akTM.mind.submission > 80.0
				bonus += (akTM.mind.submission - 80.0) / 40.0
			endif
			if akTM.mind.respect_training > 50.0
				bonus += (akTM.mind.respect_training - 50.0) / 100.0
			endif
		endif
	endif

	float speedCurve = 1.0
	if (PHHSH.NonLinearTraining)
		; Adjust based on skill difference
		speedCurve = (trainerSkill - Traineeskill) / 30		; 100:3.3   80:2.6   60:2  40:1.3  20:0.66  10:0.33
		if (speedCurve > 2.5)
			speedCurve = 2.5
		elseif (speedCurve < 0.2)
			speedCurve = 0.2
		endif
	endif

	bonus = bonus * speedCurve * factor

	int delta = math.floor( (5 + utility.RandomInt(-3, 4)) * days * bonus)
	if (delta < 1)
		delta = 1
	endif

	int newSkill = traineeSkill + delta
	if (newSkill > trainerSkill)
		newSkill = trainerSkill
	endif

	PHHSH.DebugLog(">> Trainer:" + trainer.GetDisplayName() + "  skills:" + trainerSkill + ", " + traineeSkill + "  bonus:" + bonus + "  speedcurve:" + speedcurve + "  delta:" + delta)

	return newSkill
EndFunction

Function HouseholdInfo(Actor taskmaster, bool lineuponly)
	string m
	if (!lineuponly)
 		m = "Slaves managed by " + taskmaster.GetDisplayName() + "\n\n"
	else
		m = "Slaves in lineup\n\n"
	endif

	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	int i = 0
	while (refsInCell[i] != None)
		Actor slave = refsInCell[i].GetActorRef()
		if ((slave) && ( ((!lineuponly) || (slave.GetFactionRank(PHHSH.TaskAssignedFaction)==1) )  ))
			m += slave.GetDisplayname()
			if (slave.IsInFaction(PHHSH.TaskmasterFaction))
				m += "*"
			endif
			if (slave.IsInFaction(PHHSH.IsTrainerFaction))
				m += " (trains " + (refsInCell[i] as PHHSHHouseSlave).trainee.GetDisplayName() + ")"
			endif
			if (slave.IsInFaction(PHHSH.IsTraineeFaction))
				m += " (in training)"
			endif
			int sub = PHHSHInter.GetSubmissionLevel(slave)
			int res = PHHSHInter.GetRespectLevel(slave)
			int sex = PHHSHInter.GetSexLevel(slave)
			int com = PHHSHInter.GetCombatTraining(slave)
			int pos = PHHSHInter.GetPoseTraining(slave)
			m += " s:"+sub+" r:"+res+" s:"+sex+" p:"+pos+" c:"+com
			m += "\n"
		endif
		i += 1
	endwhile
	debug.messagebox(m)
EndFunction

Function CollectAygasGold(Actor tm)
	int amount = PHHSH.Aygas.CollectAygasGold(tm)
	Game.GetPlayer().AddItem(PHHSH.Gold, amount)
	tm.RemoveFromFaction(PHHSH.PAHHasAygasGold)
EndFunction


bool Property HouseHasTaskmaster Auto Conditional
PHHSHStorageFunctions Property PHHSH Auto
phhshTaskmasterBehavior Property Behavior Auto

Topic Property TopicSlavesReady Auto
Topic Property TopicWelcome Auto
Topic Property TopicService Auto
Topic Property TopicSex Auto
Message Property MsgTransport Auto

int Property TMAllSlaves Auto Conditional
int Property TMUntrained Auto Conditional
int Property TMTrained Auto Conditional
int Property TMTrainingExempt Auto Conditional
int Property TMTrainers Auto Conditional
int Property TMSexTrained Auto Conditional
int Property TMSlavesAssembled Auto Conditional
int Property TMTypeInLineup Auto Conditional
int Property TMEntertainers Auto Conditional
int Property TMReassignedTrainers Auto Conditional
int Property TMMales Auto Conditional
int Property TMFemales Auto Conditional
int Property TMDoms Auto Conditional
int Property TMSubs Auto Conditional
int Property TMMilkMaids Auto Conditional

bool Property TMNoTrainCombat Auto Conditional
bool Property TMNoTrainSex Auto Conditional
bool Property TMNoTrainSubmission Auto Conditional
bool Property TMNoTrainRespect Auto Conditional
bool Property TMNoTrainPose Auto Conditional

bool Property InEval Auto
bool Property LineupWaiting Auto Conditional

bool Property EventStarted Auto 
bool Property ReassigningTrainers Auto 