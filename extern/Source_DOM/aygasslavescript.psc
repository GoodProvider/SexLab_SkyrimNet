Scriptname aygasSlaveScript extends ReferenceAlias  

string Property Name Auto

Function AfterAssign(Actor newOwner)
	Owner = newOwner
	Actor akRef = GetActorRef()
	if akRef != None
		Name = akRef.GetDisplayName()
	else
		Name = ""
	endif

	ObjectReference marker = StorageUtil.GetFormValue(akRef, "aygasMarker") as ObjectReference
	if (marker != None)
		MarkerRef.ForceRefTo(marker)
	else
		MarkerRef.Clear()
	endif

	akRef.SetDontMove(false)
	Default()
	UnregisterForUpdate()

	SlaveType = akRef.GetFactionRank(Aygas.SlaveTypeFaction)

	RegisterForSingleUpdate(5)
	PoseSet()
	Aygas.AYGASInter.Assign(self,newOwner)
EndFunction

Event OnLocationChange(Location ol, Location nl)
	Aygas.CheckOutfit(GetActorRef())
EndEvent

Function BeforeSuspend()
	UnregisterForUpdate()
	Actor slave = GetActorRef()
	if (slave == None)
		return
	endif
	MarkerRef.Clear()
	if (slave.GetFactionRank(Aygas.JobOverrideAction) == 2)
		slave.SetfactionRank(Aygas.JobOverrideAction, 0)
	endif
	ObjectReference f = StorageUtil.GetFormValue(slave, "BoundFurniture") as ObjectReference
	if ((f != None) && (owner != Game.GetPlayer()))
		f.Delete()
		StorageUtil.UnsetFormValue(slave, "BoundFurniture")
	endif
	slave.SetDontMove(true)
	Aygas.AYGASInter.Suspend(self,owner)
	owner = None
EndFunction

Event OnDeath(actor akKiller)
	Clear()
EndEvent

Event OnCellAttach()
	Utility.Wait(5)
	OnAttachedToCell()
EndEvent

Event OnCellDetach()
	BeforeSuspend()
EndEvent

Event OnGetup(Objectreference fg)
	Actor slave = GetActorRef()
	Aygas.DebugLog("Gets up: " + slave.GetDisplayName())
	if (slave.GetFactionRank(Aygas.JobOverrideAction) == 2)
		slave.SetfactionRank(Aygas.JobOverrideAction, 0)
		ObjectReference f = StorageUtil.GetFormValue(slave, "BoundFurniture") as ObjectReference
		if (f != None)
			f.Delete()			; Remove temporary furniture
		else
			MarkerRef.Clear()	; Clear reference to permanent furniture
		endif
		StorageUtil.UnsetFormValue(slave, "BoundFurniture")
	endif
EndEvent

Event OnattachedToCell()
	Actor slave= GetActorRef()
	if ((slave != None) && ( !slave.IsDeleted() ))
		slave.SetDontMove(false)
		if (slave.GetFactionRank(Aygas.JobOverrideAction) == 3)
;			slave.SetFactionRank(Aygas.JobOverrideAction, 0)		; Force package reset so actor will sit again
;			slave.EvaluatePackage()
;			utility.wait(5)
;			slave.SetFactionRank(Aygas.JobOverrideAction, 3)
			Aygas.HandleFurniBoundSlave(slave)
		endif
		idlePosing = false
		UnregisterForUpdate()
		Default()
		Aygas.CheckOutfit(GetActorRef())
		RegisterForSingleUpdate(5)
		utility.wait(1)
		PoseSet()
	else
		Clear()
	endif
EndEvent

Event OnUpdate()
	Actor slave = GetActorRef()
	if (slave != None)
		if (slave.IsDead())
			Clear()
			return
		endif

		if (slave.GetParentCell() == None) 
			return
		elseif (!slave.GetParentCell().IsAttached()) 
			return
		endif



		if ((!Aygas.SexLab.IsActorActive(slave)) && (slave.GetFactionRank(Aygas.JobOverrideAction) <= 0) && (!slave.IsInFaction(Aygas.IgnoreFaction)) && (!slave.IsInDialogueWithPlayer() ) && (slave.GetCurrentScene() == None))
			SlaveType = slave.GetFactionRank(Aygas.SlaveTypeFaction)
			BehaviourOnUpdate()
		elseif (slave.GetFactionRank(Aygas.JobOverrideAction) == 3)
			BoundBehaviourOnUpdate()
;		else
;			Debug.Notification(slave.GetDisplayName() + " skip routine")
		endif

		RegisterForSingleUpdate(60)
	else
		Clear()
	endif
EndEvent

event OnSLAnimationEnd(string eventName, string argString, float argNum, form sender)
	;debug.notification("Sex scene ends")
	Default()
endevent

Function PoseSet()
	Actor slave = GetActorRef()
	PoseIdle = None
	PoseAnim = ""
	PoseBound = false

	Idle[] anims
	if (SlaveType == 1)			; Prostitute
		; Random dialog solicit
	elseif (SlaveType == 2)		; prostitute for sale

	elseif (SlaveType == 3)		; shop slave
		if ((slave.isInInterior()) && (utility.randomint(1,5) == 1))
			slave.EquipItem(Aygas.ZazYoke)
			PoseBound = true
		else
			if (utility.randomint(1, 6) == 1)
				slave.Unequipall()
			endif
		endif

	elseif (SlaveType == 4)		; work slave for sale

	elseif (SlaveType == 5)		; generic work slave
		if ((slave.isInInterior()) && (utility.randomint(1,5) == 1))
			slave.EquipItem(Aygas.ZazYoke)
			PoseBound = true
		endif

	elseif (SlaveType == 6)		; Sex Slave
		if (utility.randomint(1, 6) == 1)
			slave.Unequipall()
			; Add random device, set owner to punishing
		endif
	elseif (SlaveType == 7)		; Personal slave for sale

	elseif (SlaveType == 8)		; Personal slave
		if (slave.isInInterior())
			anims = new Idle[1]
			anims[0] = Aygas.IdleDrinkTray
		elseif (utility.randomint(1,3) == 1)
			if (utility.randomint(1, 6) == 1)
				slave.Unequipall()
			endif

			if (utility.randomint(1, 2) == 1)
				slave.EquipItem(Aygas.ZazYoke)
			else
				slave.EquipItem(Aygas.ZazShackles)
			endif

			PoseBound = true
		endif

	elseif (SlaveType == 9)		; Serving slave (Inns)
		anims = new Idle[2]
		anims[0] = Aygas.IdleSoupPot
		anims[1] = Aygas.IdleDrinkTray

	elseif (SlaveType == 10)	; Farm slave
		if (slave.isInInterior())
			anims = new Idle[1]
			anims[0] = Aygas.IdleSoupPot
		endif
	endif

	int nrAnims = anims.Length
	int selAnim = utility.randomint(0, nrAnims * 3)
	if ((nrAnims > 0) && (selAnim < nrAnims))
		PoseIdle = anims[selAnim]
;		Debug.Notification("Play "+ anim + " on " + GetActorRef().GetDisplayName())
	endif
EndFunction

Function PoseCheck()
	Actor slave = getActorRef()
	if ((behaviour == "default") &&  (!Aygas.SexLab.IsActorActive(slave))  )
		if (PoseAnim != "")
			Debug.SendAnimationEvent(slave, PoseAnim)
		elseif (PoseIdle != none)
			slave.PlayIdle(PoseIdle)	
		elseif (!PoseBound)
			; Check if standing still, if so strike a pose
			float X = slave.X
			float Y = slave.Y
			if ((math.abs(X - oldX) < 5) && (math.abs(Y - oldY) < 5) && (slave.GetDistance(owner) < 100))
				stopTicks += 1
;				debug.notification(slave.GetDisplayname() + " stopped")
			else
;				debug.notification(slave.GetDisplayname() + " moved")
				stopTicks = 0
				idlePosing = false
				Debug.SendAnimationEvent(slave, "IdleForceDefaultState")
			endif
			if ( ((stopTicks > 0) && (!idlePosing)) || (stopTicks > 3) )
				int pose = utility.randomint(0, 7)
				idlePosing = true
				if (pose == 0)
					slave.PlayIdle(Aygas.IdlePose1)
				elseif (pose == 1)
					slave.PlayIdle(Aygas.IdlePose2)
				elseif (pose == 2)
					slave.PlayIdle(Aygas.IdlePose3)
				elseif (pose == 3)
					slave.PlayIdle(Aygas.IdlePose4)
				elseif (pose == 4)
					slave.PlayIdle(Aygas.IdlePose5)
				elseif (pose == 5)
					slave.PlayIdle(Aygas.IdlePose6)
				else
					idlePosing = false
					Debug.SendAnimationEvent(slave, "IdleForceDefaultState")
				endif
			endif
			oldX = X
			oldY = Y
		endif
	endif
EndFunction

Function BoundBehaviourOnUpdate()
	if (Utility.RandomInt(1, 3) == 1)	
		Actor slave = GetActorRef()
		ObjectReference f = StorageUtil.GetFormValue(slave, "BoundFurniture") as ObjectReference

		if ((Aygas.HasTortureFramework) && (f != None))
			Aygas.ITF.BindInFurniture(f, slave, None)
		else
			; Todo: insert scene for non ITF action.
		endif
	endif
EndFunction

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
EndFunction

Function Default()
;	debug.notification("Behaviour set to default: " + GetActorRef().GetDisplayName())
	behaviour = "default"
EndFunction

State default
	Function StartBehaviour()

	EndFunction

	Function BehaviourOnUpdate()
;		debug.notification("Default update " + GetActorRef().GetDisplayName())
		Actor slave = GetActorRef()

		if (owner.GetSleepState() == 3)
			Sleep()

		elseif ((SlaveType  == 1) || (SlaveType  == 13))
			if ((Utility.RandomInt(1, 2) == 1) && (!Aygas.EventFunctions.ActivateAuctionPackages))
				Actor client = Aygas.FindEligibleJohn(slave, owner, 1500)

				; Is client eligible and not busy?
				if ((client != None) && (Aygas.JobSlaveAvailable(slave, false)))
					Aygas.DebugMessage("Evaluate trick for " + slave.GetDisplayName() + " with:" + client.GetDisplayName())
					if (Aygas.Scenes.InnTrickProstitute.GetRef() != None)
						Aygas.DebugLog("Trick Scene is occupied")
					else
						Aygas.Scenes.InnTrickProstitute.ForceRefTo(slave)
						Aygas.Scenes.InnTrickCustomer.ForceRefTo(client)	
						ObjectReference bed = Game.FindRandomReferenceOfAnyTypeInListFromRef(Aygas.Beds, slave, 2048)
						if (Aygas.Scenes.UseBed(bed))
							Aygas.DebugLog("Found bed")
							Aygas.Scenes.InnTrickTargetBed.ForceRefTo(bed)	
						else
							Aygas.Scenes.InnTrickTargetBed.Clear()
						endif
						Aygas.DebugLog("Scene start")
						; Scene()
						Aygas.DoJobExperience(slave)

						if (owner == Game.GetPlayer())
							Aygas.WorkFunctions.JobPay(slave, Aygas.WorkFunctions.ProstituteValue(slave))
						endif

						RegisterForModEvent("AnimationEnd_AygasSlave", "OnSLAnimationEnd")
						Aygas.Scenes.InnTrickScene.Start()

						if (SlaveType != 13)
							Aygas.Scenes.ApplyClientCooldown(client)
						endif
					endif
				endif
			endif

		elseif ((owner != Game.GetPlayer()) && (!Aygas.EventFunctions.ActivateAuctionPackages))
			int satisfaction = StorageUtil.GetIntValue(slave, "OwnerSatisfaction")	; 1 = crap, 2 = adequate, 3 = good, 4 = outstanding

			int act = Utility.RandomInt(1,8)
			if (act <= 2)
				; Punish unruly slaves
				if (satisfaction == 1)
					Aygas.DebugLog(Owner.GetDisplayName() + " to punish " + slave.getDisplayName())
					if ((Aygas.Scenes.PunishSlave.GetRef() == None) && (!Aygas.Scenes.NPCInScene(owner)))
;						Aygas.DebugMessage("Punish!")
						Aygas.Scenes.PunishSlave.ForceRefTo(slave)
						Aygas.Scenes.PunishMaster.ForceRefTo(owner)
						Aygas.Scenes.PunishScene.Start()
						; Scene()
					endif
				elseif (satisfaction == 2)
					Aygas.DebugLog(Owner.GetDisplayName() + " whips " + slave.getDisplayName())
					if ((Aygas.Scenes.WhipSlave.GetRef() == None) && (!Aygas.Scenes.NPCInScene(owner)))
;						Aygas.DebugMessage("Whip!")
						Aygas.Scenes.WhipSlave.ForceRefTo(slave)
						Aygas.Scenes.WhipMaster.ForceRefTo(owner)
						Aygas.Scenes.ShortWhipScene.Start()
						; Scene()
					endif
				endif
			elseif ((!slave.GetParentCell().IsInterior()) && (satisfaction <= 2) && (act == 8))
				if (Utility.GetCurrentRealTime() - Aygas.ZoneTime < 20)		; Don't start punishment right after zoning
					return
				endif

				Furniture f = None

				; Attempt to locate free range furniture for this session, if enabled
				if ((Aygas.HasHSH) && (Aygas.SUseWorldFurniture))
					ObjectReference furniRef
					furniRef = Aygas.HSH.FindUnusedZAPFurniture(slave, true, 3)
					if (furniRef != None)
						Aygas.DebugMessage("Punish " + slave.GetDisplayname() + " in furniture " + furniRef.GetName())
						Aygas.Scenes.BindInObjectRef(slave, owner, furniRef, true)
						MarkerRef.ForceRefTo(furniRef)
						slave.SetFactionRank(Aygas.JobOverrideAction, 2)
						slave.EvaluatePackage()
						return
					elseif (!Aygas.SSpawnFurniture)
						return		; Exit if we're not supposed to spawn furniture
					endif
				endif

				if (Aygas.EventFunctions.CityLocation(slave.GetCurrentLocation()) != None)
					; Punish in stocks
					Aygas.DebugLog("Punish " + slave.GetDisplayname() + " in furniture")
					f = Aygas.FurnPillory 
				else
					; Punish in tree
					Aygas.DebugLog("Punish " + slave.GetDisplayname() + " in tree")
					f = Aygas.FurnTree2 
				endif

 				ObjectReference fr = Aygas.Scenes.BindInObject(slave, owner, f, true, 0)
				slave.MoveTo(fr)
				MarkerRef.ForceRefTo(fr)
				slave.SetFactionRank(Aygas.JobOverrideAction, 2)
				slave.EvaluatePackage()
			else
				PoseCheck()
			endif
		endif
	EndFunction

	Function EndBehaviour()
	EndFunction
EndState

Function Sleep()
	behaviour = "sleep"
EndFunction

State sleep
	Function StartBehaviour()
		Debug.SendAnimationEvent(GetActorRef(), "IdleLayDownEnter")
		GetActorRef().SetDontMove(true)
	EndFunction

	Function BehaviourOnUpdate()
;		debug.notification("Sleep update")
		if (owner.GetSleepState() != 3)
			Default()
		endif
	EndFunction

	Function EndBehaviour()
		GetActorRef().SetDontMove(false)
		Debug.SendAnimationEvent(GetActorRef(), "IdleForceDefaultState")
	EndFunction
EndState

Function Scene()
	behaviour = "scene"
EndFunction

State scene
	Function StartBehaviour()
	EndFunction

	Function BehaviourOnUpdate()
;		debug.notification("Scene update " + GetActorRef().GetDisplayname())
;		if (Aygas.Scenes.InnTrickProstitute.GetActorRef() != GetActorRef())
;			Aygas.DebugMessage("Scene ends")
;			Default()
;		endif
	EndFunction

	Function EndBehaviour()
	EndFunction
EndState

Function LogTrace(string msg)
	if Aygas.AYGASInter.isVerboseMode()
		Debug.Trace("AYGASSlave: "+Name+": "+msg)
	endif
EndFunction

Actor Property Owner Auto
aygasCoreScript Property Aygas Auto
int Property SlaveType Auto
string Property PoseAnim Auto
Idle Property PoseIdle Auto
float Property oldX Auto
float Property oldY Auto
int Property stopTicks Auto
bool Property idlePosing Auto
bool Property PoseBound Auto
ReferenceAlias Property MarkerRef Auto
