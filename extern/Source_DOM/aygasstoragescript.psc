Scriptname aygasStorageScript extends Quest  

AYGASInterface Property AYGASInter Auto

; Call this Function to place an NPC into the slave storage. Auction slaves are drawn from this pool.
; Make sure the slave is deregistered from PAH/DOM and HSH
; Duplicate non unique NPCs are rejected, the Function returns false and you will be left to deal with the NPC

bool Function StoreSlave(Actor slave)
	if (slave == None)
		return false
	endif

	int formId = slave.GetFormID()

	Aygas.DebugMessage("Attempting to register " + slave.GetDisplayName() + " (" + formId + ") for storage")

	if (!slave.IsInFaction(Aygas.StoredFaction))
		if (StorageUtil.IntListFind(none, "aygasStoredSlaves", formId) < 0)
			slave.SetFactionRank(Aygas.StoredFaction, 1)
			slave.RemoveFromFaction(Aygas.OwnerlessFaction)
			slave.MoveTo(Cellmarker, utility.randomint(-512, 512), utility.randomint(-512, 512), 0)
			slave.EnableAI(false)
			StorageUtil.IntListAdd(none, "aygasStoredSlaves", formId)
;			StorageUtil.FormListAdd(none, "aygasStoredSlaveRefs", slave)
			return true
		else
			Aygas.DebugMessage("Actor already stored")
			return false
		endif
	else
		return true		; This slave got offered for storage twice. Ignore but report success.
	endif	
EndFunction

Function RemoveSlave(Actor slave)
	StorageUtil.IntListRemove(none, "aygasStoredSlaves", slave.GetFormID())
	slave.EnableAI(true)
	slave.RemoveFromFaction(Aygas.StoredFaction)
;	StorageUtil.FormListRemove(none, "aygasStoredSlaveRefs", slave)
EndFunction

Actor Function RandomSlave()
	Actor slave = None
	int actors = Cellmarker.GetParentCell().GetNumRefs(43)
	Aygas.DebugMessage("Slaves in storage: " + actors)
	if (actors > 0)
		slave = Cellmarker.GetParentCell().GetNthRef(Utility.RandomInt(0, actors), 43) as Actor
	else
		Actor a = Game.FindClosestActorFromRef(Cellmarker, 2048)
		if ((a != None) && (a.IsInFaction(Aygas.StoredFaction)))
			slave = a
		endif
	endif

	if (slave == None)
		; No slaves in the pool, spawn a random one
		int rs = Utility.RandomInt(1,4)
		int t = 2 - Aygas.SSlaveSpawnRatio
		
		if (rs <= t)
			slave = CellMarker.PlaceAtme(SlaveFemale) as Actor
			Aygas.DebugMessage("Spawn random female slave")
		else
			slave = CellMarker.PlaceAtme(SlaveMale) as Actor
			Aygas.DebugMessage("Spawn random male slave")
		endif
		slave.RemoveFromFaction(BanditFaction)
		slave.SetAV("aggression", 0)
		slave.StopCombat()

		actor newSlave = AYGASInter.AddSlaveToWorld(slave)
		if (newSlave != None)
			slave = newSlave
			Aygas.DebugMessage("Cloned random NPC: " + slave.GetDisplayname())
		else
			Aygas.DebugMessage("Failed to clone random NPC: " + slave.GetDisplayname())
			return None
		endif

		AYGASInter.SetSubmissionTraining(slave,Utility.RandomInt(40, 80))
		AYGASInter.SetHumiliationTraining(slave,Utility.RandomInt(20, 60))
		AYGASInter.SetResignationTraining(slave,Utility.RandomInt(40, 80))
		AYGASInter.SetSexTraining(slave,Utility.RandomInt(40, 70))

		slave.UnequipAll()
		slave.RemoveAllItems()

;			Aygas.EquipAndStore(slave, Aygas.ZazLegIrons)
;			Aygas.EquipAndStore(slave, Aygas.ZazCollar)
;			Aygas.EquipAndStore(slave, Aygas.StorageFunctions.Rags)
		slave.AddItem(Aygas.ZazLegIrons, 1)
		slave.AddItem(Aygas.ZazCollar, 1)
		slave.AddItem(Aygas.StorageFunctions.Rags, 1)


;			slave.SetDisplayName("Slave")
		utility.wait(3)		 ; Maybe needed to stabilize things

			; Move to slave pool
			StoreSlave(slave)
;		else
;			slave.Delete()
;			Aygas.DebugMessage("Failed to spawn random slave")
;			slave = None
;		endif
	endif

	if (slave != None)
		; Set the sale price
		Aygas.SellQuest.ConsiderSlave(slave, Game.Getplayer())
;		StorageUtil.SetIntValue(slave, "Price", Aygas.SellQuest.aygasPriceProperty.GetValueInt())
		StorageUtil.SetIntValue(slave, "Price", Aygas.SellQuest.SlavePrice)
		slave.SetFactionRank(Aygas.SlaveTypeFaction, Aygas.SellQuest.BaseType)
	endif

	return slave
EndFunction

Function SpawnSlave()
	Actor slave= RandomSlave()
	Debug.MessageBox("> " + slave.GetDisplayName())
	Game.GetPlayer().PlaceAtMe(slave)
EndFunction

Function MoveExiledRuler()
	; Find an exiled ruler and add them to the slave pool or the Restless Hunter auction stock
	if (!CWQuest.IsCompleted())
		Aygas.DebugMessage("Civil war not completed")
		return
	endif
	int i = Aygas.RulingActors.GetSize()
	Actor slave = None
	while ((i > 0) && (slave == None))
		i -= 1
		Actor a = Aygas.RulingActors.GetAt(i) as Actor
		if ((a != None) && (!a.IsChild()) && (!a.IsDead()) && (a.GetFactionRank(ExiledFaction) >= 0) && (!AYGASInter.hasSubmission(a)))
			slave = a
		endif
	endwhile
	if (slave != None)
		Aygas.DebugMessage("Moving exiled npc: " + slave.GetDisplayname())
		; Enslave with slave manager
		actor newSlave = AYGASInter.AddSlaveToWorld(slave)
		if (newSlave != None)
			slave = newSlave
		else
			Aygas.DebugMessage("Failed to clone exiled npc: " + slave.GetDisplayname())
			return
		endif

		AYGASInter.SetSubmissionTraining(slave,Utility.RandomInt(60, 90))
		AYGASInter.SetHumiliationTraining(slave,Utility.RandomInt(30, 80))
		AYGASInter.SetResignationTraining(slave,Utility.RandomInt(60, 90))
		AYGASInter.SetAngerTraining(slave,Utility.RandomInt(10, 50))
		AYGASInter.SetFearTraining(slave,Utility.RandomInt(10, 50))
		AYGASInter.SetSexTraining(slave,Utility.RandomInt(50, 80))
		AYGASInter.SetCombatTraining(slave,Utility.RandomInt(20, 80))
		AYGASInter.SetPoseTraining(slave,Utility.RandomInt(50, 90))
		AYGASInter.SetRespectTraining(slave,Utility.RandomInt(20, 50))

		bool handled = false
		if ((Utility.RandomInt(1, 2) == 1) && (Aygas.HasHSH))
			; Move to Restless Hunter
			if (Aygas.HSH.MoveSlaveToHunter(slave))
				handled = true
			endif
		endif
		if (!handled)
			; Move to slave pool
			Utility.Wait(60)
			Aygas.StorageFunctions.StoreSlave(slave)
			slave.EquipItem(Aygas.ZazCollar, true, true)
			slave.EquipItem(Aygas.ZazLegIrons, true, true)
			Aygas.DebugMessage("Added to slave pool")
		endif
	endif
EndFunction

aygasCoreScript Property Aygas Auto
Objectreference Property CellMarker Auto
Faction Property ExiledFaction Auto
Faction Property BanditFaction Auto

Quest Property CWQuest Auto
ActorBase Property SlaveMale  Auto
ActorBase Property SlaveFemale  Auto
Armor Property Rags Auto
  