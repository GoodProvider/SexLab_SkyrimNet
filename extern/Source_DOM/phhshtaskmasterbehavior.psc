Scriptname PHHSHTaskmasterBehavior extends Quest Conditional

; Taskmaster / slave behavior scripts

Function BehaviorAllowMilking(Actor taskmaster, bool allow)
	phhshHouseSlave tmScript = PHHSH.SlaveRef(taskmaster)
	AllowMilking = allow
	if (tmScript != None)
		tmScript.TMAllowMilking = allow
	endif

	; Set Property on slaves as well
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	int i=0
	while (refsInCell[i] != None) 
		(refsInCell[i] as phhshHouseSlave).BeAllowMilking = allow
		i += 1
	endwhile
EndFunction

Function BehaviorAllowMilkingFurniture(Actor taskmaster, bool allow)
	AllowMilkingFurniture = allow
	; Set Property on slaves as well
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	int i=0
	while (refsInCell[i] != None) 
		(refsInCell[i] as phhshHouseSlave).BeAllowMilkingFurniture = allow
		i += 1
	endwhile
EndFunction

Function BehaviorReleaseFromMilkingFurniture(Actor taskmaster, bool allow)
	phhshHouseSlave tmScript = PHHSH.SlaveRef(taskmaster)
	ReleaseFromMilkingFurniture = allow
	if (tmScript != None)
		tmScript.TMReleaseFromMilking = allow
	endif

	; Set Property on slaves as well
	ReferenceAlias[] refsInCell = PHHSH.PortableFunctions.SlaveRefsInCell(taskmaster.GetParentCell())
	int i=0
	while (refsInCell[i] != None) 
		(refsInCell[i] as phhshHouseSlave).BeReleaseFromMilkFurniture = allow
		i += 1
	endwhile
EndFunction

Function SetMilkingAllowed(Actor slave, bool allow)
	PHHSH.SlaveRef(slave).BeAllowMilking = allow
EndFunction

Function SetMilkingFurnitureAllowed(Actor slave, bool allow)
	PHHSH.SlaveRef(slave).BeAllowMilkingFurniture = allow
EndFunction

Function SetReleaseFromMilkingFurnitureAllowed(Actor slave, bool allow)
	PHHSH.SlaveRef(slave).BeReleaseFromMilkFurniture = allow
EndFunction

Function RequestRelease(Actor slave)
;	debug.notification(slave.GetDisplayName() + " requests release from device")
	actor tm = PHHSH.Taskmaster.TaskmasterInCell(slave.GetParentCell())
	if (tm != None)
		if ((!PHHSH.IsBusy(tm)) && (slave.GetCurrentScene() == None))
			PHHSH.ScenesSLA.StartTMReleaseScene(tm, slave)
		endif
	endif
EndFunction

Function EvalBehaviorFlags(Actor slave)
	IsMilkMaid = PHHSH.MMEFunctions.IsMilkMaid(slave)
	phhshHouseSlave slaveRef = PHHSH.SlaveRef(slave)
	AllowMilking = slaveRef.BeAllowMilking
	AllowMilkingFurniture = slaveRef.BeAllowMilkingFurniture
	ReleaseFromMilkingFurniture = slaveRef.BeReleaseFromMilkFurniture
EndFunction

Function EvaluateBehavior(phhshHouseSlave slaveRef)
	; Infrequent /  expensive checks on conditions to trigger certain behavioral actions.  Called by the cell marker
	Actor slave = slaveRef.GetActorRef()
	if slave == None
		return
	endif
	if (!slave.GetParentCell().IsAttached())
		return
	endif
	
	PHHSH.DebugLog("Evaluate Behaviour: " + slave.GetDisplayName())

	; MME Checks
	if (PHHSH.MMEFunctions.IsBeingMilked(slave))
		; Being milked, check if ready and allowed to stop
		if (slave.GetSitState() == 3)			; Assume sitting means being in a milk machine
			if (PHHSH.MMEFunctions.MilkLevel(slave) < 2.0)
				PHHSH.DebugLog(slave.GetDisplayName() + " in machine")
				if (slaveRef.BeReleaseFromMilkFurniture)
					RequestRelease(slave)
				else
					if (utility.Randomint(1, 3) == 1)
						PHHSH.ScenesSLA.Say(slave, 3)
					endif
				endif
			endif
		endif
	elseif (PHHSH.MMEFunctions.ReadyForMilking(slave))
		PHHSH.DebugLog("C " + slave.GetDisplayName() + ": " + PHHSH.MMEFunctions.MilkPercentage(slave) + ", " +  PHHSH.IsBusy(slave))
		; Ready for milking, check level
		if ((PHHSH.MMEFunctions.MilkPercentage(slave) > 95) && (!PHHSH.IsBusy(slave)) )
			bool didMilk = false
			if ((PHHSH.MMEFunctions.IsWearingMilkEquipment(slave)) && (slaveRef.BeAllowMilking) && (!slave.IsInFaction(PHHSH.AccompanyFaction )) && (!slaveRef.IsBound) && (!slaveRef.IsYoked))
				; Has milking cuirass, self milk if not busy and allowed
				PHHSH.DebugLog(slave.GetDisplayName() + " self milk")
				PHHSH.MMEFunctions.SelfMilk(slave)
				didMilk = true
			elseif ((slaveRef.BeAllowMilking) && (!slaveRef.IsYoked) && (!slave.IsInFaction(PHHSH.AccompanyFaction )) && (slaveRef.BeAllowMilkingFurniture))
				; Find and enter machine if not busy and allowed
				didMilk = PHHSH.TryUseFurnitureFromList(slave, false, PHHSH.DOMZAZ.GetMilkFurniture(), false)
				PHHSH.DebugLog(slave.GetDisplayName() + " equipment milk:" + didMilk)
			elseif (slaveRef.BeAllowMilking) 
				if ((slave.IsInFaction(PHHSH.AccompanyFaction )) && (slaveRef.slaveTarget.GetActorRef() != None) && (Game.GetPlayer() != slaveRef.slaveTarget.GetActorRef()))
					; let companion milk
					PHHSH.DebugLog(slave.GetDisplayName() + " milked by companion" + slaveRef.slaveTarget.GetActorRef().GetDisplayName())
					PHHSH.MMEFunctions.InitMilking(slave, slaveRef.slaveTarget.GetActorRef())
					didMilk = true
				else
					; Find and enter fellow slave if not busy and allowed
					Actor partner = PHHSH.PortableFunctions.GetEligibleSexPartner(slave)
					PHHSH.DebugLog(slave.GetDisplayName() + " milked by " + partner.GetDisplayName())
					if (partner != None)
						PHHSH.MMEFunctions.InitMilking(slave, partner)
						didMilk = true
					endif
				endif
			endif
			if (!didMilk)
				PHHSH.DebugLog(slave.GetDisplayName() + " asks to be milked")
				; Ask to be milked
				if (utility.Randomint(1, 3) == 1)
					Actor currentmaster = slaveRef.slaveTarget.GetActorRef()
					if (currentmaster == None)
						currentmaster = Game.GetPlayer()
					endif
					if (PHHSH.DOMSexlab.GetGender(currentmaster))
						PHHSH.ScenesSLA.Say(slave, 1)
					else
						PHHSH.ScenesSLA.Say(slave, 2)
					endif
				endif
				PHHSH.DOMSexlab.PickVoice(slave, Utility.RandomInt (30, 100), false)
			endif
		endif
	endif
EndFunction


bool Property IsMilkMaid Auto Conditional Hidden
bool Property AllowMilking Auto Conditional Hidden			; Allow or deny milking
bool Property AllowMilkingFurniture Auto Conditional Hidden		; Allow or deny milking furniture
bool Property ReleaseFromMilkingFurniture Auto Conditional Hidden	; release from milking furniture

phhshStorageFunctions Property PHHSH Auto
