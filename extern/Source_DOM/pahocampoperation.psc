Scriptname PAHOCampOperation extends Quest Conditional

PHHSHInterface Property PHHSHInter Auto

bool miners_onupdate = false
Event OnInit()
	Debug.Trace("PAHOCampOperation OnInit - Next update in 48 hours")
	RegisterForUpdateGametime(48.0) ; 48 hours
EndEvent

Event OnUpdateGametime()
	Debug.Trace("PAHOCampOperation OnUpdateGametime - Next update in 48 hours")
	; Train working
	TrainSlaves()
	if !miners_onupdate
		Debug.Trace("PAHOCampOperation OnUpdateGametime - Starting miners OnUpdate events")
		miners_onupdate = true
	endif
EndEvent

Function TrainSlaves()
	Debug.Trace("PAHOCampOperation TrainSlaves")
	TrainSlotKarthwarsten()
	TrainSlotStonehills()
	TrainSlotDawnstar()
EndFunction

Function TrainSlotKarthwarsten()
	int n = SlotKarthwarsten.length
	int i = 0
	while i < n
		if SlotKarthwarsten[i].GetRef() != None
			DOM_Actor akActor = SlotKarthwarsten[i] as DOM_Actor
			if akActor != None
				if !miners_onupdate
					Debug.Trace("PAHOCampOperation Starting OnUpdate events for "+akActor.GetName())
					akActor.OnUpdate()
					akActor.OnUpdateGameTime()
				endif
				akActor.StartScolding(OverseerKarthwarsten)
				DOM_Mind akMind = akActor.mind
				if akMind != None
					if i == 2
						akMind.TrainHouse(5.0)
					else
						akMind.TrainWork(5.0)
					endif
					akMind.TrainResignation(4.0)
					akMind.TrainFear(3.0)
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function TrainSlotStonehills()
	int n = SlotStonehills.length
	int i = 0
	while i < n
		if SlotStonehills[i].GetRef() != None
			DOM_Actor akActor = SlotStonehills[i] as DOM_Actor
			if akActor != None
				if !miners_onupdate
					Debug.Trace("PAHOCampOperation Starting OnUpdate events for "+akActor.GetName())
					akActor.OnUpdate()
					akActor.OnUpdateGameTime()
				endif
				akActor.StartScolding(OverseerStonehills)
				DOM_Mind akMind = akActor.mind
				if akMind != None
					if i == 2
						akMind.TrainHouse(5.0)
					else
						akMind.TrainWork(5.0)
					endif
					akMind.TrainResignation(4.0)
					akMind.TrainFear(3.0)
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

Function TrainSlotDawnstar()
	int n = SlotDawnstar.length
	int i = 0
	while i < n
		if SlotDawnstar[i].GetRef() != None
			DOM_Actor akActor = SlotDawnstar[i] as DOM_Actor
			if akActor != None
				if !miners_onupdate
					Debug.Trace("PAHOCampOperation Starting OnUpdate events for "+akActor.GetName())
					akActor.OnUpdate()
					akActor.OnUpdateGameTime()
				endif
				akActor.StartScolding(OverseerDawnstar)
				DOM_Mind akMind = akActor.mind
				if akMind != None
					if i == 2
						akMind.TrainHouse(5.0)
					else
						akMind.TrainWork(5.0)
					endif
					akMind.TrainResignation(4.0)
					akMind.TrainFear(3.0)
				endif
			endif
		endif
		i += 1
	endwhile
EndFunction

ReferenceAlias Function GetFreeSlotKarthwarsten()
	int n = SlotKarthwarsten.length
	int i = 0
	while i < n
		if SlotKarthwarsten[i].GetRef() == None
			Debug.Trace("GetFreeSlotKarthwarsten "+SlotKarthwarsten[i].GetName())
			return SlotKarthwarsten[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function GetFreeSlotStonehills()
	int n = SlotStonehills.length
	int i = 0
	while i < n
		if SlotStonehills[i].GetRef() == None
			Debug.Trace("GetFreeSlotStonehills "+SlotStonehills[i].GetName())
			return SlotStonehills[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function GetFreeSlotDawnstar()
	int n = SlotDawnstar.length
	int i = 0
	while i < n
		if SlotDawnstar[i].GetRef() == None
			Debug.Trace("GetFreeSlotDawnstar "+SlotDawnstar[i].GetName())
			return SlotDawnstar[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function FreeSlotForLocation()
	Location playerLocation = Game.GetPlayer().GetCurrentLocation()
	if (playerLocation == LocKarthwarsten)
		return GetFreeSlotKarthwarsten()
	endif
	if (playerLocation == LocStonehills)
		return GetFreeSlotStonehills()
	endif
	if (playerLocation == LocDawnstar)
		return GetFreeSlotDawnstar()
	endif
	return None
EndFunction

Actor Function GetActor(ReferenceAlias ref)
	return ref.GetRef() As Actor
EndFunction

Function KillSlot(ReferenceAlias slot)
	if (slot.GetRef() != None)  
		GetActor(slot).DeleteWhenAble() 
		slot.Clear()
	endif
EndFunction

int Function GetLocationIndex(Actor akRef)
	Location theLocation = akRef.GetCurrentLocation()
	if (theLocation == LocKarthwarsten)
		return 103
	elseif (theLocation == LocStonehills)
		return 104
	elseif (theLocation == LocDawnstar)
		return 105
	endif
	return 0
EndFunction

Function AfterAssign(ReferenceAlias ref)
	Actor akRef = ref.GetActorRef()
	if akRef == None
		Debug.Trace("PAHOCampOperation Assign failed to get actor reference")
		return
	endif
	int itype = GetLocationIndex(akRef)
	if itype <= 0
		itype = GetLocationIndex(Game.GetPlayer())
		if itype <= 0
			itype = 103
		endif
	endif

	Debug.Trace("PAHOCampOperation Assign slave to location "+itype+" n="+NumberOfMinersKarthwarsten+"/"+NumberOfMinersStonehills+"/"+NumberOfMinersDawnstar)
	DOM_Actor slaveDOM = ref as DOM_Actor
	if slaveDOM == None
		Debug.Trace("PAHOCampOperation Assign failed to assign DOM actor and mind")
		return
	endif
	akRef.SetFactionRank(PHHSHInter.PHSF.DOMSlaveManagerFaction,itype)
	slaveDOM.SetDisplayName(akRef.GetDisplayName())
	if slaveDOM.DOM01 != PHHSHInter.DOM && PHHSHInter.DOM != None
		Debug.Trace("PAHOCampOperation Assign alias actor DOM pointer was not correctly set!")
		slaveDOM.DOM01 = PHHSHInter.DOM
	endif
	slaveDOM.AfterAssign(true,false,false) ; slave=yes, new=no, player's=no
	DOM_Mind slaveMind = ref as DOM_Mind
	if slaveMind.DOM01 != PHHSHInter.DOM && PHHSHInter.DOM != None
		Debug.Trace("PAHOCampOperation Assign alias mind DOM pointer was not correctly set!")
		slaveMind.DOM01 = PHHSHInter.DOM
	endif
	slaveMind.AfterAssign(true,false,false) ; slave=yes, new=no, player's=no
	if itype == 103
		slaveMind.SetSlaveOwner(OverseerKarthwarsten)
		if ref == SlotKarthwarsten[2]
			slaveDOM.EnterOnDutyClean("will join Karthwarsten's Mine", "Karthwarsten's Cleaner Slave")
			slaveDOM.SetBrandTatsMaid()
			slaveDOM.SetBrandFromStatus()
		else
			slaveDOM.EnterOnDuty("will join Karthwarsten's Mine", "Karthwarsten's Mine Slave")
			slaveDOM.SetBrandTatsMiner()
			slaveDOM.SetBrandFromStatus()
		endif
		NumberOfMinersKarthwarsten += 1
		SetNextIsCleanerKarthwarsten()
	elseif itype == 104
		slaveMind.SetSlaveOwner(OverseerStonehills)
		if ref == SlotStonehills[2]
			slaveDOM.EnterOnDutyClean("will join Stonehills' Mine", "Stonehills' Cleaner Slave")
			slaveDOM.SetBrandTatsMaid()
			slaveDOM.SetBrandFromStatus()
		else
			slaveDOM.EnterOnDuty("will join Stonehills' Mine", "Stonehills' Mine Slave")
			slaveDOM.SetBrandTatsMiner()
			slaveDOM.SetBrandFromStatus()
		endif
		NumberOfMinersStonehills += 1
		SetNextIsCleanerStonehills()
	elseif itype == 105
		slaveMind.SetSlaveOwner(OverseerDawnstar)
		if ref == SlotDawnstar[2]
			slaveDOM.EnterOnDutyClean("will join Dawnstar's Mine", "Dawnstar's Cleaner Slave")
			slaveDOM.SetBrandTatsMaid()
			slaveDOM.SetBrandFromStatus()
		else
			slaveDOM.EnterOnDuty("will join Dawnstar's Mine", "Dawnstar's Mine Slave")
			slaveDOM.SetBrandTatsMiner()
			slaveDOM.SetBrandFromStatus()
		endif
		NumberOfMinersDawnstar += 1
		SetNextIsCleanerDawnstar()
	endif
	slaveDOM.OnUpdate()
	slaveDOM.OnUpdateGameTime()
EndFunction

ReferenceAlias Function GetSlotKarthwarsten(Actor akRef)
	int n = SlotKarthwarsten.length
	int i = 0
	while i < n
		if SlotKarthwarsten[i].GetActorRef() == akRef
			return SlotKarthwarsten[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function GetSlotStonehills(Actor akRef)
	int n = SlotStonehills.length
	int i = 0
	while i < n
		if SlotStonehills[i].GetActorRef() == akRef
			return SlotStonehills[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function GetSlotDawnstar(Actor akRef)
	int n = SlotDawnstar.length
	int i = 0
	while i < n
		if SlotDawnstar[i].GetActorRef() == akRef
			return SlotDawnstar[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function SlaveRef(Actor akRef)
	if akRef == None
		return None
	endif
	int rank = akRef.getFactionRank(PHHSHInter.PHSF.DOMSlaveManagerFaction)
	Debug.Trace("PAHOCampOperation SlaveRef manager="+rank)
	Debug.Trace("PAHOCampOperation SlaveRef AskWhichSlave="+AskWhichSlave+" PAHO.AskWhichSlave="+PAHO.AskWhichSlave)
	Debug.Trace("PAHOCampOperation SlaveRef NumberOfMiners="+NumberOfMinersKarthwarsten+" / "+NumberOfMinersStonehills+" / "+NumberOfMinersDawnstar)
	if rank == 103
		return GetSlotKarthwarsten(akRef)
	endif
	if rank == 104
		return GetSlotStonehills(akRef)
	endif
	if rank == 105
		return GetSlotDawnstar(akRef)
	endif
	return None
EndFunction


int Function NumberOfMinersInLocation()
	Location playerLocation = Game.GetPlayer().GetCurrentLocation()
	if (playerLocation == LocKarthwarsten)
		return NumberOfMinersKarthwarsten
	endif
	if (playerLocation == LocStonehills)
		return NumberOfMinersStonehills
	endif
	if (playerLocation == LocDawnstar)
		return NumberOfMinersDawnstar
	endif
	return 0
EndFunction

Function AskPlayerWhichSlave()
	int n = NumberOfMinersInLocation()
	Debug.Trace("PAHOCampOperation AskPlayerWhichSlave nb miners="+n+" alias="+BuySlot.GetRef())
	if n <= 0
		return
	endif
	AskWhichSlave = true
	RegisterForSingleUpdate(120.0)
EndFunction

Function PointMiner(Actor akTarget)
	Debug.Trace("PAHOCampOperation PointMiner akTarget="+akTarget)
	if akTarget == None
		return
	endif
	BuySlot.ForceRefTo(akTarget)
	debug.notification("You point out " + akTarget.GetDisplayname() + " to the guard")
EndFunction

Event OnUpdate()
	Debug.Trace("PAHOCampOperation OnUpdate alias="+BuySlot.GetActorRef())
	AskWhichSlave = false
	BuySlot.Clear()	
EndEvent

Function BuySlottedSlave()
	Actor akRef = BuySlot.GetActorRef()
	Debug.Trace("PAHOCampOperation BuySlottedSlave alias="+akRef)
	if akRef == None
		return
	endif
	int value = 880
	if PHHSHInter.DOM != None
		value += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainWorking)*4
		value += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainHouse)*2
		value += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainSubmission)
		value += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainRespect)
		value += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainFear)/2
		value += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainResignation)/2
	endif
	Actor PlayerRef = Game.GetPlayer()
	int amount = PlayerRef.GetGoldAmount()
	debug.trace("PAHOCampOperation BuySlottedSlave Player has "+amount+" gold")
	if amount >= value
		debug.notification("You have "+amount+" gold")
		debug.notification("You want to buy bond for " + akRef.GetDisplayname() + " for "+value+" gold")
	else
		debug.notification("You only have "+amount+" gold")
		debug.notification(akRef.GetDisplayname() + "'s release is worth "+value+" gold")
	endif
	int ibutton = PHHSHBuyMessage.show(value as float)  
	if ibutton == 0
		if (PlayerRef.GetGoldAmount() >= value)
			PlayerRef.RemoveItem(Gold, value)
			TransferSlave()
		else
			Debug.Notification("You don't have enough gold!")
			AskWhichSlave = false
			BuySlot.Clear()
		endif
	else
		AskWhichSlave = false
		BuySlot.Clear()
	endif
EndFunction

Function ReleaseActor(Actor akTarget)
	ReferenceAlias akRef = SlaveRef(akTarget)
	ReleaseAlias(akRef)
EndFunction

Function ReleaseAlias(ReferenceAlias akRef)
	if akRef == None
		return
	endif
	Actor akTarget = akRef.GetActorRef()
	if BuySlot.GetActorRef() == akTarget
		BuySlot.Clear()
	endif
	int idx = GetLocationIndex(akTarget)
	DOM_Actor akActor = akRef as DOM_Actor
	if akActor != None
		akActor.DoClear()
	endif
	akRef.Clear()
	if idx == 103
		NumberOfMinersKarthwarsten -= 1
		SetNextIsCleanerKarthwarsten()
	elseif idx == 104
		NumberOfMinersStonehills -= 1
		SetNextIsCleanerStonehills()
	elseif idx == 105
		NumberOfMinersDawnstar -= 1
		SetNextIsCleanerDawnstar()
	endif
EndFunction

bool Function IsAliasMaid(ReferenceAlias ref)
	if ref == None
		return false
	endif
	if SlotKarthwarsten.length >= 3 && ref == SlotKarthwarsten[2]
		return true
	endif
	if SlotStonehills.length >= 3 && ref == SlotStonehills[2]
		return true
	endif
	if SlotDawnstar.length >= 3 && ref == SlotDawnstar[2]
		return true
	endif
	return false
EndFunction

Function SetNextIsCleanerKarthwarsten()
	if SlotKarthwarsten.length < 3
		NextIsCleanerKarthwarsten = false
		return
	endif
	if SlotKarthwarsten[2].GetActorRef() != None
		NextIsCleanerKarthwarsten = false
		return
	endif
	if SlotKarthwarsten[1].GetActorRef() == None
		NextIsCleanerKarthwarsten = false
		return
	endif
	if SlotKarthwarsten[0].GetActorRef() == None
		NextIsCleanerKarthwarsten = false
		return
	endif
	NextIsCleanerKarthwarsten = true
EndFunction

Function SetNextIsCleanerStonehills()
	if SlotStonehills.length < 3
		NextIsCleanerStonehills = false
		return
	endif
	if SlotStonehills[2].GetActorRef() != None
		NextIsCleanerStonehills = false
		return
	endif
	if SlotStonehills[1].GetActorRef() == None
		NextIsCleanerStonehills = false
		return
	endif
	if SlotStonehills[0].GetActorRef() == None
		NextIsCleanerStonehills = false
		return
	endif
	NextIsCleanerStonehills = true
EndFunction

Function SetNextIsCleanerDawnstar()
	if SlotDawnstar.length < 3
		NextIsCleanerDawnstar = false
		return
	endif
	if SlotDawnstar[2].GetActorRef() != None
		NextIsCleanerDawnstar = false
		return
	endif
	if SlotDawnstar[1].GetActorRef() == None
		NextIsCleanerDawnstar = false
		return
	endif
	if SlotDawnstar[0].GetActorRef() == None
		NextIsCleanerDawnstar = false
		return
	endif
	NextIsCleanerDawnstar = true
EndFunction

Function TransferSlave()
	Debug.Trace("PAHOCampOperation TransferSlave alias="+BuySlot.GetRef())
	AskWhichSlave = false
	Actor akTarget = BuySlot.GetActorRef()
	BuySlot.Clear()
	if akTarget == None
		return
	endif
	Debug.Trace("PAHOCampOperation TransferSlave actor="+akTarget.GetDisplayName())
	ReferenceAlias akRef = SlaveRef(akTarget)
	ReleaseAlias(akRef)
	PHHSHInter.PHSF.AddSlaveToDOM(akTarget)
EndFunction

string Function GetMineName(ReferenceAlias ref)
	if ref == GuardKarthwarsten
		return "Karthwarsten"
	endif
	if ref == GuardStonehills
		return "Stonehills"
	endif
	if ref == GuardDawnstar
		return "Dawnstar"
	endif
	return "Nowhere"
EndFunction

int Function GetMineCounter(ReferenceAlias ref)
	if ref == GuardKarthwarsten
		return NumberOfMinersKarthwarsten
	endif
	if ref == GuardStonehills
		return NumberOfMinersStonehills
	endif
	if ref == GuardDawnstar
		return NumberOfMinersDawnstar
	endif
	return 0
EndFunction

PAHOCOre Property PAHO Auto
MiscObject Property Gold Auto
Message Property PHHSHBuyMessage Auto
ReferenceAlias Property BuySlot Auto
bool Property AskWhichSlave = false Auto Conditional

Int property NumberOfMinersKarthwarsten = 0 Auto  Conditional
Int property NumberOfMinersStonehills  = 0 Auto  Conditional
Int property NumberOfMinersDawnstar = 0 Auto  Conditional

Bool property NextIsCleanerKarthwarsten = false Auto  Conditional
Bool property NextIsCleanerStonehills = false Auto  Conditional
Bool property NextIsCleanerDawnstar = false Auto  Conditional

Actor Property OverseerKarthwarsten Auto
Actor Property OverseerStonehills Auto
Actor Property OverseerDawnstar Auto

ReferenceAlias[] Property SlotKarthwarsten Auto
ReferenceAlias[] Property SlotStonehills Auto
ReferenceAlias[] Property SlotDawnstar Auto

ReferenceAlias Property GuardKarthwarsten Auto
ReferenceAlias Property GuardStonehills Auto
ReferenceAlias Property GuardDawnstar Auto

Location Property LocKarthwarsten  Auto  
Location Property LocStonehills  Auto  
Location Property LocDawnstar  Auto  

