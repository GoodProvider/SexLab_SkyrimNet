Scriptname aygasWorkScript extends Quest

AYGASInterface Property AYGASInter Auto

Function ProstituteEnable(Actor slave)
	slave.SetFactionRank(aygas.ProstitutionType, 1)
EndFunction

Function ProstituteDisable(Actor slave)
	JobCollect(slave)
	slave.RemoveFromFaction(aygas.ProstitutionType)
EndFunction

Function JobPay(Actor slave, int amount)
	if (amount > 0)
		int money = StorageUtil.GetIntValue(slave, "aygasMoney")
		money += amount
		StorageUtil.SetIntValue(slave, "aygasMoney", money)	
		slave.SetFactionRank(Aygas.HasJobGold, 1)
	endif
EndFunction

Function JobCollect(Actor slave)
	int money = StorageUtil.GetIntValue(slave, "aygasMoney")
	Game.GetPlayer().AddItem(aygas.Gold, money)
	StorageUtil.SetIntValue(slave, "aygasMoney", 0)		
	slave.RemoveFromFaction(Aygas.HasJobGold)
	slave.RemoveFromFaction(Aygas.SpentPlayerGold)
EndFunction

; Remove money from slave and return the amount
int Function JobCollectSilently(Actor slave)
	if (slave!= None)
		int amount = StorageUtil.GetIntValue(slave, "aygasMoney")
		StorageUtil.SetIntValue(slave, "aygasMoney", 0)		
		slave.RemoveFromFaction(Aygas.HasJobGold)
		slave.RemoveFromFaction(Aygas.SpentPlayerGold)
		return amount
	else 
		return 0
	endif
EndFunction


Function SetToWork(Actor slave, int jobtype)
	Aygas.SellSlave(slave, game.GetPlayer(), jobtype, 0, false)
	StorageUtil.SetFloatValue(slave, "DateOfJobCheck",  Utility.GetCurrentGameTime())	
	Aygas.EvaluatePerks()
EndFunction

Function BindSlaveInObject(Actor slave, Furniture furn, int zOffset)
	slave.AllowPCDialogue(false)
	slave.SetDontMove(true)
	Aygas.ITF.IgnoreNPC(slave, true)
	slave.EnableAI(false)
	SetToWork(slave, 2)
	slave.SetFactionRank(Aygas.JobOverrideAction, 1)
	ObjectReference f = Aygas.Scenes.BindInObject(slave, Game.GetPlayer(), furn, false, zOffset)
	slave.EnableAI(true)
	slave.MoveTo(f)
	slave.SetDontMove(false)
	slave.SetFactionRank(Aygas.JobOverrideAction, 3)
	slave.EvaluatePackage()
	slave.AllowPCDialogue(true)
EndFunction

Function FreeSlaveFromObject(Actor slave)
	slave.AllowPCDialogue(false)
	Aygas.BuySlave(slave, Game.GetPlayer(), 0)
	AYGASInter.SendAnimationEvent(slave, "IdleForceDefaultState")
	Utility.Wait(0.5)
	slave.PlayIdle(IdleWarmArms)
	slave.AllowPCDialogue(true)
EndFunction

Function DropMarker(Actor slave)
	; Add a marker to an existing slave.  Re-use existing markers if any
	ObjectReference marker = StorageUtil.GetFormValue(slave, "aygasMarker") as ObjectReference
	if (marker != None)
		marker.MoveTo(slave)		; Move existing marker and exit
	else
		marker = slave.PlaceAtMe(XMarker, 1)		; New marker, store with slave
		StorageUtil.SetFormValue(slave, "aygasMarker", marker)

		aygasSlaveScript slaveRef = aygas.SlaveSlot(slave) as aygasSlaveScript
		if (slaveRef != None)
			; Also handle actions for slave slot
		endif
	endif
EndFunction

Function TrainSex(Actor slave, int amount)
	int inc = math.floor(amount / 3)
	if (inc == 0)
		inc = 1
	endif

	AYGASInter.IncreaseSexTraining(slave,inc)
EndFunction

Function SetFactionRank(Actor a, Faction f, int r)
	if (r > 100)
		r = 100
	elseif (r < 1)
		r = 1
	endif
	a.SetFactionRank(f, r)
EndFunction

int Function ProstituteValue(Actor slave)
	int xp = slave.GetFactionRank(aygas.JobExperience)
	if (xp < 0)
		xp = 0
	endif
	return (6 + xp) * 5
EndFunction

aygasCoreSCript Property Aygas Auto
Actor Property ProstituteWithPlayer Auto Hidden
Static Property XMarker Auto
Idle Property IdleWarmArms Auto