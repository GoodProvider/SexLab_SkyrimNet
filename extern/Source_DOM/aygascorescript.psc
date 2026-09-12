Scriptname aygasCoreScript extends Quest   Conditional

AYGASInterface Property AYGASInter Auto
Faction Property DOMAliasIndexFaction Auto
Faction Property DOMSlaveManagerFaction Auto

string Function Version()
	return "0.70"
EndFunction

Actor[] deleteSlaves

Event OnInit()
	Init()
EndEvent

Function Init()
	Debug.Notification("AYGAS Core script started")
	GetSoftRequirements()
	EventFunctions.OnInit()
	Scenes.OnInit()
;	Game.GetPlayer().AddSpell(ZoningDetectSpell)
EndFunction

Function CheckVersion()
	if (LastVersion != Version())
		Debug.Notification("Upgrading AYGAS to " + Version())
		if ((LastVersion == "") || (LastVersion < "0.55"))
			EventFunctions.StopEvent()
		endif
		LastVersion = Version()
	endif
EndFunction

Function SellSlave(Actor slave, Actor buyer, int slaveType, float  price, bool soldByPlayer)
	if (StorageUtil.FormListFind(none, "aygasOwners", buyer) < 0)
		StorageUtil.FormListAdd(none, "aygasOwners", buyer)
		StorageUtil.FormListClear(buyer, "aygasSlaves")
	endif

	StorageUtil.FormListAdd(buyer, "aygasSlaves", slave)
	StoreOutfit(slave)

	; Notify selling
	if AYGASInter.DOM != None
		DOM_Actor akActor = AYGASInter.DOM.GetActor(slave)
		if akActor != None
			AYGASInter.DOM.PlayerHasSold(akActor)
		endif
	endif
	; Remove from slave manager
	AYGASInter.RemoveSlaveFromDOM(slave)

	; Remove from HSH
	if (HasHSH)
		HSH.DeregisterSlave(slave)
	endif

	slave.SetFactionRank(SlaveTypeFaction, slaveType)
	if (!slave.IsInFaction(JobExperience))
		slave.SetFactionRank(JobExperience, 0)
	endif

	if (buyer != Game.GetPlayer())
		; Give slave the keys to the owner's house
		int i = buyer.GetNumItems()
		while (i > 0)
			i -= 1
			Form f = buyer.GetNthForm(i)
			if (f.GetType() == 45)		; Give keys to slave
				slave.Additem(f, 1)
			endif
		endwhile

		; Add standard and optional chains
		slave.AddItem(ZazCollar, 1)
		if ((slaveType == 2) || (slaveType == 4) || (slaveType == 7)) 
			if (utility.RandomInt(1, 2) == 1)
				slave.AddItem(ZazYoke, 1)
			else
				slave.AddItem(ZazShackles, 1)
			endif
			slave.AddItem(ZazLegIrons, 1)
		endif
		if ((slaveType == 5) || (slaveType == 8)) 
			slave.AddItem(ZazLegIrons, 1)
		endif

		i = slave.GetNumItems()
		while (i > 0)
			i -= 1
			slave.EquipItem(slave.GetNthForm(i))
			utility.wait(0.1)
		endwhile

		slave.RemoveFromFaction(OwnedByPlayer)

		if ((price > 1) && (soldByPlayer))
			Game.GetPlayer().AddItem(gold, math.floor(price))
			SlaveryGain(1)
			DoProgress(slaveType)
		endif
	else
		slave.SetFactionRank(OwnedByPlayer, 1)
		ObjectReference marker = slave.PlaceAtMe(WorkFunctions.XMarker, 1)		; Player slave: drop a marker for sandboxing
		StorageUtil.SetFormValue(slave, "aygasMarker", marker)
	endif

	if (!slave.IsInFaction(JobExperience))
		slave.SetFactionRank(JobExperience, 0)
	endif

	utility.wait(1)
	StoreOutfit(slave)
	slave.SetDontMove(false)

	StorageUtil.SetIntValue(slave, "OwnerSatisfaction", utility.RandomInt(1,4))	; 1 = crap, 2 = adequate, 3 = good, 4 = outstanding
	StorageUtil.SetIntValue(slave, "Price", price as int)
	StorageUtil.SetFloatValue(slave, "DateOfSale",  Utility.GetCurrentGameTime())	
	StorageUtil.SetFormValue(slave, "Owner", buyer)

	ProcessOwner(buyer, false)
	DebugLog(buyer.GetDisplayname() + " registered as owner, total owners:" + StorageUtil.FormListCount(none, "aygasOwners"))
EndFunction

Function BuySlave(Actor slave, Actor seller, int price)
	if ((seller != Game.GetPlayer()) && (game.GetPlayer().GetItemCount(Gold) < price))
		debug.notification("You do not have enough gold to buy this slave")
		return
	endif

	bool is_success = AYGASInter.AddSlaveToDOM(slave)

	if is_success
		slave.AllowPCDialogue(false)
		ReferenceAlias slot = SlaveSlot(slave)
		if (slot != None)
			(slot as aygasSlaveScript).BeforeSuspend()
			slot.Clear()
		endif

		StorageUtil.FormListRemove(seller, "aygasSlaves", slave)
		StorageUtil.UnsetFormValue(slave, "Owner")

		ObjectReference marker = StorageUtil.GetFormValue(slave, "aygasMarker") as ObjectReference
		if (marker != None)
			marker.Delete()
			StorageUtil.UnsetFormValue(slave, "aygasMarker")
		endif

		ObjectReference f = StorageUtil.GetFormValue(slave, "BoundFurniture") as ObjectReference
		if (f != None) 
			f.Delete()
			StorageUtil.UnsetFormValue(slave, "BoundFurniture")
		endif

		ProcessUnattachedOwner(seller)

		slave.RemoveFromFaction(UnslottedFaction)
		slave.RemoveFromFaction(SlaveTypeFaction)
		slave.RemoveFromFaction(OwnedByPlayer)

		Scenes.ReleaseFromObject(slave)

		if ((seller != Game.GetPlayer()) && (price > 0))
			Game.GetPlayer().RemoveItem(gold, price)
		endif
		slave.SetDontMove(false)
		slave.AllowPCDialogue(true)
		ITF.IgnoreNPC(slave, false)
	else
		debug.notification("Failed to transfer " + slave.GetDisplayName() + " to you")
		DebugLog("Failed to transfer " + slave.GetDisplayName() + " to you")
	endif
EndFunction

Function DeleteSlaves(Actor owner, Actor[] defunctSlaves, int c)
	while (c > 0)
		c -= 1
		StorageUtil.FormListRemove(owner, "aygasSlaves", defunctSlaves[c])
	endwhile
EndFunction

Function SetOwnerLocation(Actor owner)
	if (!StorageUtil.GetStringValue(owner, "Location"))
		if (owner != Game.GetPlayer())
			Location loc = owner.GetEditorLocation()
			if (loc != None)
				string s = loc.GetName()
				if (s != "")
					Location cl = EventFunctions.CityLocation(loc)
					if (cl)
						s += " in " + cl.GetName()
						StorageUtil.SetStringValue(owner, "Location", cl.GetName())
					endif
					DebugLog("Set location for " + owner.GetDisplayname() + ": " + s)
				endif
			endif
		else
			StorageUtil.SetStringValue(owner, "Location", "Player")		; Player has no fixed location			
		endif
	endif
EndFunction

bool Function ProcessUnattachedOwner(Actor owner)
	DebugLog("    process offline:" + owner.GetDisplayName() + " (" + owner.GetFormID() + ")")
	SetOwnerLocation(owner)

	bool inEventLocation = false
	if ((EventFunctions.EventStage >= 1) && (!EventFunctions.EventSlavesPicked))
		string ownerLoc = StorageUtil.GetStringValue(owner, "Location")
		if (ownerLoc == EventFunctions.EventLocationName)
;DebugMessage("Owner " + owner.GetDisplayName() + " in eventlocation " + EventFunctions.EventLocationName)
			inEventLocation = true
		endif
	endif

	int i = StorageUtil.FormListCount(owner, "aygasSlaves")
	int d = 0
	if (i == 0)
		DebugLog(owner.GetDisplayName() + " removed as owner, no slaves owned")
	else
		deleteSlaves = new Actor[50];
		while(i > 0)
			i-=1
			Actor slave = StorageUtil.FormListGet(owner, "aygasSlaves", i) as Actor
			if (slave != none)
				if (inEventLocation)
					EventFunctions.NominateSlaveForEvent(slave, owner)
				endif
				if ((slave.GetType() != 43) && (slave.GetFactionRank(JobOverrideAction) != 4) && (!slave.IsInFaction(IgnoreFaction)))		; Sometimes will have different type, skip processing
					Actor listedOwner = StorageUtil.GetFormValue(slave, "Owner") as Actor
					if (listedOwner == None)
						listedOwner = owner
						StorageUtil.SetFormValue(slave, "Owner", owner)
					endif
					if ((!slave.IsDeleted()) && (!slave.IsDead()) && (owner == listedOwner) )
;						if (SlaveSlot(slave) == None) 
						if (!slave.IsInFaction(SlottedFaction))  ; Added 30-7-18
							if ((slave.GetParentCell() == None) || (!slave.GetParentCell().IsAttached())) 
								slave.RemoveFromFaction(UnslottedFaction)
							else
								slave.SetDontMove(false)
							endif

							if (owner != Game.GetPlayer())  ; Moved outside IF 30-7-18
								slave.MoveTo(owner)
							else
								ProcessUnattachedSlave(slave)
							endif
						endif

						if ((slave.GetParentCell() == None) || (!slave.GetParentCell().IsAttached()))
							ObjectReference f = StorageUtil.GetFormValue(slave, "BoundFurniture") as ObjectReference
							if ((f != None) && (owner != Game.GetPlayer()))
								f.Delete()
								StorageUtil.UnsetFormValue(slave, "BoundFurniture")
							endif
						endif
					else
						DebugLog("Slave "+ slave.GetDisplayName() + " was deleted")
						DebugMessage("Slave "+ slave.GetDisplayName() + " was deleted")
						deleteSlaves[d] = slave
						d+=1
					endif
				endif
			endif
		endwhile
		DeleteSlaves(owner, deleteSlaves, d)
	endif

	if (StorageUtil.FormListCount(owner, "aygasSlaves") >0)
		owner.AddToFaction(OwnerFaction)
		return true
	else
		owner.RemoveFromFaction(OwnerFaction)
		return false
	endif
EndFunction

Function ProcessOwner(Actor owner, bool isZoning)
	DebugLog("    processing:" + owner.GetDisplayName() + " (" + owner.GetFormID() + ")")
	SetOwnerLocation(owner)

	bool inEventLocation = false
	if ((EventFunctions.EventStage >= 1) && (!EventFunctions.EventSlavesPicked))
		string ownerLoc = StorageUtil.GetStringValue(owner, "Location")
		if (ownerLoc == EventFunctions.EventLocationName)
;DebugMessage("Owner " + owner.GetDisplayName() + " in eventlocation " + EventFunctions.EventLocationName)
			inEventLocation = true
		endif
	endif
	
	string s = owner.GetDisplayName() + ":"

	deleteSlaves = new Actor[50];
	int d = 0

	int i = StorageUtil.FormListCount(owner, "aygasSlaves")
	if (i > 0)
		while(i > 0)
			i-=1
			Actor slave = StorageUtil.FormListGet(owner, "aygasSlaves", i) as Actor
			Actor listedOwner = None
			if (slave != None)
				listedOwner = StorageUtil.GetFormValue(slave, "Owner") as Actor
				if (listedOwner == None)
					listedOwner = owner
					StorageUtil.SetFormValue(slave, "Owner", owner)
				endif
				if (inEventLocation)
					EventFunctions.NominateSlaveForEvent(slave, owner)
				endif
			endif

			if ((slave != none) && (!slave.IsInFaction(IgnoreFaction)))
				if ((!slave.IsDeleted()) && (!slave.IsDead()) && (slave.GetFactionRank(JobOverrideAction) != 4) && (owner == listedOwner) )
					DebugLog("      Slave "+ slave.GetDisplayName() + " (" + slave.GetFormID() + ")" + " processing")
					s += slave.GetDisplayName()

					bool newMarker = false			; Check if player slave has a marker
					ObjectReference marker = StorageUtil.GetFormValue(slave, "aygasMarker") as ObjectReference
					if ((marker == None) && (owner == Game.GetPlayer()))
						marker = slave.PlaceAtMe(WorkFunctions.XMarker, 1)		; Player slave: drop a marker for sandboxing
						StorageUtil.SetFormValue(slave, "aygasMarker", marker)
						newMarker = true
						DebugLog("        Added new marker to player slave")
					endif

					aygasSlaveScript slaveSlot = SlaveSlot(slave) as aygasSlaveScript
					if (slaveSlot == None)
						DebugLog("         Attemt to reserve slot")
						; Attempt to slot slave
						ReferenceAlias slot = GetFreeSlot()
						if ((slot == None) || ((IsInPAHHouse) && (owner != Game.GetPlayer()))  )		; Slaves do not follow into player homes, so do not slot them
							DebugLog("         No slot available or in player home")
	;						if (!slave.IsInFaction(UnslottedFaction))
							if (!IsInPAHHouse)
								slave.SetFactionRank(UnslottedFaction, 1)
								CheckOutfit(slave)
								if (slave.GetFactionRank(JobOverrideAction) != 3)
									slave.SetDontMove(true)
									int pose = utility.RandomInt(1, 3)
									if (pose == 1)
										AYGASInter.SendAnimationEvent(slave, "ZAZAPCAO011")
									elseif (pose == 2)
										AYGASInter.SendAnimationEvent(slave, "ZAZAPCAO002")
									else
										AYGASInter.SendAnimationEvent(slave, "ZazAPPillSolo05")
									endif
								endif
							endif
						else
							DebugLog("         Reserved a slot")
							slave.RemoveFromFaction(UnslottedFaction)
							slot.Clear()
							slot.ForceRefTo(slave)
							OwnerSlot(slave).ForceRefTo(owner)
							AYGASInter.SendAnimationEvent(slave, "IdleForceDefaultState")
							slave.SetDontMove(false)
							(slot as aygasSlaveScript).AfterAssign(owner)
							if ( (owner != Game.GetPlayer()) && (slave.GetDistance(owner) > 2500) ) ; && (slave.GetparentCell() != owner.GetparentCell()) )
								DebugLog("         Moving slave")
								slave.MoveTo(owner)
								utility.wait(1)
							endif
							DebugLog("         Check outfit")
							CheckOutfit(slave)		
	;						debug.notification("Slotted " + slave.GetDisplayName())

							if ((slave.GetFactionRank(JobOverrideAction) == 3) && (slave.GetSitState() != 3))
								; Re-enter furniture
								HandleFurniBoundSlave(slave)
							endif
						endif
					else
						;slave.EnableAI(true)
						if (!SexLab.IsActorActive(slave)) 
							slave.SetDontMove(false)
	;						CheckOutfit(slave)	
						endif

						if (owner != Game.GetPlayer())
							if (IsInPAHHouse)
								if (!slave.GetParentCell().IsAttached())
									DebugLog("         Unslot slave for owners in player home")		; To make sure they dont follow inside
									; In player home, unslot any slaves who are still outside
									slaveSlot.BeforeSuspend()
									slaveSlot.Clear()
									slave.SetDontMove(true)
								endif
							elseif ((isZoning) && (slave.GetDistance(owner) > 2500))
								DebugLog("         Moving slave")
								slave.MoveTo(owner)
							endif
						else
							if (newMarker)
								slaveSlot.MarkerRef.ForceRefTo(marker)
								DebugLog("        New marker set for slotted player slave")
							endif
						endif

						if ((slave.GetFactionRank(JobOverrideAction) == 3) && (slave.GetSitState() != 3))
							; Re-enter furniture
							HandleFurniBoundSlave(slave)
						endif
					endif

					if ((owner == Game.GetPlayer()) && ((slave.GetParentCell() == None) || (!slave.GetParentCell().IsAttached())) )
						ProcessUnattachedSlave(slave)
						slave.MoveTo(marker)
					endif

					DebugLog("      Slave "+ slave.GetDisplayName() + " processing done")
				else
					if (slave != None)
						if (slave.IsDeleted()) || (slave.IsDead() || (owner != listedOwner))
							DebugLog("      Slave "+ slave.GetDisplayName() + " was deleted")
							DebugMessage("Slave "+ slave.GetDisplayName() + " was deleted")
							if (SlaveSlot(slave) != None)
								SlaveSlot(slave).Clear()
							endif
							deleteSlaves[d] = slave
							d+=1
						endif
					endif
				endif
			endif
		endwhile

;		debug.trace(s)
		DeleteSlaves(owner, deleteSlaves, d)
	endif

	if (StorageUtil.FormListCount(owner, "aygasSlaves") >0)
		owner.AddToFaction(OwnerFaction)
	else
		owner.RemoveFromFaction(OwnerFaction)
	endif
EndFunction

Function ProcessDeletedOwner(Actor owner)
	; Owner was deleted, move any attached slaves to the pool
	int i = StorageUtil.FormListCount(owner, "aygasSlaves")
	while(i > 0)
		i -= 1
		Actor slave = StorageUtil.FormListGet(owner, "aygasSlaves", i) as Actor
		if (slave != none)
			if ((!slave.IsDeleted()) && (!slave.IsDead()) )
				if (!StorageFunctions.StoreSlave(slave))
					slave.Disable()
				endif
			else
				slave.Disable()
			endif
		endif
	endwhile	
EndFunction

Function ProcessUnattachedSlave(Actor slave)
	if (slave != None)
		int slaveType = slave.GetFactionRank(SlaveTypeFaction)
		int jobLevel = slave.GetFactionRank(JobExperience)
		float jobInterval = Utility.GetCurrentGameTime() - StorageUtil.GetFloatValue(slave, "DateOfJobCheck")	

		if ((slaveType == 1) || (slaveType == 2) || (slaveType == 13))
			int fac = 1
			if (slaveType == 2)
				fac = 2
			endif
			int amount = Math.Floor(jobLevel * jobInterval  / fac)
			int money = StorageUtil.GetIntValue(slave, "aygasMoney")

			if (money < 1500)
				WorkFunctions.JobPay(slave, amount)
;				debug.notification(slave.GetDisplayName() + " got paid");
			else
				slave.SetFactionRank(SpentPlayerGold, 1)
;				debug.notification(slave.GetDisplayName() + " spending player gold");
			endif
			if ((jobInterval > 0.2) && (Utility.RandomInt(1, 5) == 1))
				DoJobExperience(slave)
			endif
	;		Debugmessage("Paid " + amount + " to " + slave.GetDisplayName())
		endif

		StorageUtil.SetFloatValue(slave, "DateOfJobCheck", Utility.GetCurrentGameTime())	
	endif
EndFunction

Function HandleFurniBoundSlave(Actor slave)
	ObjectReference f = StorageUtil.GetFormValue(slave, "BoundFurniture") as ObjectReference
	if (f != None)
		if (slave.GetSitState() != 3)
			slave.MoveTo(f)
		endif
		if (HasTortureFramework)
			itfCoreScript.GetAPI().UnslotFurniture(f)			; Needed to ensure we can manually start torture sessions on this thing
		endif
		slave.EvaluatePackage()
;	else  ; Probably have to ignore this condition
;		if (slave.GetparentCell().IsAttached())
;			DebugMessage("No stored furniture on " + slave.GetDisplayName())
;			slave.SetFactionRank(JobOverrideAction, 0)
;		endif
	endif
EndFunction

Function CheckOutfit(Actor slave)
	if ((slave.GetparentCell() == none) || (!slave.GetparentCell().IsAttached()))
		DebugLog("            Skip unattached slave")
		return
	endif

	slave.UnequipAll()	

	int i = StorageUtil.FormListCount(slave, "aygasWornItems")

	while (i > 0)
		i -= 1
		Form stuff = StorageUtil.FormListGet(slave, "aygasWornItems", i)
		if (stuff != None)
			slave.EquipItem(stuff, true, true)
		endif
	endwhile
EndFunction

Function StoreOutfit(Actor slave)
	int slotIndex = 0;
;	int slotMask = 0x80300000
	int slotMask = 0

	StorageUtil.FormListClear(slave, "aygasWornItems")

	int slot
	while (slotIndex < 32)
		slot = math.pow(2, slotIndex) as int
		if (!math.LogicalAnd(slot, slotMask))
			Form  item = slave.GetWornForm(slot)
;			if !isToBeStripped(item)
;				item = None
;			endif
			if (item != None)
				StorageUtil.FormListAdd(slave, "aygasWornItems", item)
			endif
		endif
		slotIndex += 1
	endwhile
EndFunction

bool Function isToBeStripped(Form the_form)
	if the_form == None
		return false
	endif
	; Do not strip restrains
	if SexLabUtil.HasKeywordSub(the_form,"NoStrip")
		return false
	elseif SexLabUtil.HasKeywordSub(the_form,"AlwaysStrip")
		return true
	;elseif the_form.HasKeyword(SexLabNoStrip)
	;	return false
	;elseif the_form.HasKeyWordString("SexLabNoStrip")
	;	return false
	elseif the_form.HasKeyWordString("PAHRestraint")
		return false
	elseif the_form.HasKeyWordString("zbfWornWrist")
		return false
	elseif the_form.HasKeyWordString("zbfWornDevice")
		return false
	endif
	return true
EndFunction

Function EquipAndStore(Actor Slave, Form item)
	if ((slave != None) && (item != None))
		slave.EquipItem(item, true, true)
		StorageUtil.FormListAdd(slave, "aygasWornItems", item, false)
	endif
EndFunction

Function CheckActorAliases()
	;LogTrace("CheckActorAliases checking DOM pointers")
	int n = SlaveSlots.length
	int i = 0
	int k = 0
	LogTrace("CheckActorAliases checking DOM pointers array size="+n)
	While i < n
		DOM_Actor akActor = SlaveSlots[i] as DOM_Actor
		if akActor.DOM01 != AYGASInter.DOM
			LogTrace("CheckActorAliases alias "+i+" actor was not correctly set!")
			akActor.DOM01 = AYGASInter.DOM
			k += 1
		endif
		if akActor.PlayerRef != AYGASInter.DOM.PlayerRef
			;LogTrace("CheckActorAliases alias "+i+" actor's player ref was not correctly set!")
			akActor.PlayerRef = AYGASInter.DOM.PlayerRef
			;k += 1
		endif
		ReferenceAlias target = (SlaveSlots[i] as aygasSlaveScript).MarkerRef
		if akActor.target != target
			;LogTrace("CheckActorAliases alias "+i+" actor's target was not correctly set!")
			akActor.target = target
			;k += 1
		endif
		DOM_Mind akMind = SlaveSlots[i] as DOM_Mind
		if akMind.DOM01 != AYGASInter.DOM
			LogTrace("CheckActorAliases alias "+i+" mind was not correctly set!")
			akMind.DOM01 = AYGASInter.DOM
			k += 1
		endif
		if akMind.PlayerRef != AYGASInter.DOM.PlayerRef
			;LogTrace("CheckActorAliases alias "+i+" mind's player ref was not correctly set!")
			akMind.PlayerRef = AYGASInter.DOM.PlayerRef
			;k += 1
		endif
		i += 1
	EndWhile	
	if k == 0
		LogTrace("CheckActorAliases All DOM pointers are OK")
	else
		LogTrace("CheckActorAliases Found "+k+" wrong DOM pointers! Corrected")
	endif
EndFunction

ReferenceAlias Function SlaveSlot(Actor slave)
	int n = SlaveSlots.length
	int i = 0
	while i < n
		if SlaveSlots[i].GetActorRef() == slave
			return SlaveSlots[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function OwnerSlot(Actor slave)
	int ns = SlaveSlots.length
	int no = Owners.length
	int i = 0
	while i < ns && i < no
		if SlaveSlots[i].GetActorRef() == slave
			return Owners[i]
		endif
		i += 1
	endwhile
	return None
EndFunction

ReferenceAlias Function GetFreeSlot()
	int n = SlaveSlots.length
	int i = 0
	while i < n
		if SlaveSlots[i].GetActorRef() == None
			return SlaveSlots[i]
		endif
		i += 1
	endwhile

	; Try replacing
	i = 0
	while i < n
		if CheckCanReplaceSlot(SlaveSlots[i])
			(SlaveSlots[i] as aygasSlaveScript).BeforeSuspend()
			return SlaveSlots[i]
		endif
		i += 1
	endwhile

	return None
EndFunction

bool Function CheckCanReplaceSlot(ReferenceAlias slot)
	return ( (((slot as aygasSlaveScript).Owner == Game.GetPlayer()) && ((slot as aygasSlaveScript).GetActorRef().GetParentCell().IsAttached() == false)) \
		|| ((slot as aygasSlaveScript).Owner.GetParentCell().IsAttached() == false) || ((slot as aygasSlaveScript).Owner.GetParentCell() == None))
EndFunction

int Function CheckSlavesNearPlayer()
	if UI.IsMenuOpen("Dialogue Menu")
		return SlavesNearby
	endif
	Cell currentCell = game.GetPlayer().GetParentCell()
	Actor slave = SellQuest.SlaveOnOffer
	GetSoftRequirements()
	SellQuest.Clear()
	SellQuest.Stop()
	utility.wait(0.5)
	SellQuest.Start()
	utility.wait(0.5)
	int n = SellSlots.length
	SlavesNearby = 0
	while n > 0
		n -= 1
		if SellSlots[n].GetRef() != None
			SlavesNearby = n+1
			n = 0
		endif
	endwhile
	DebugMessage("You have " + SlavesNearby + " slaves nearby")
	SellQuest.SlaveOnOffer = slave
	return SlavesNearby
EndFunction

Function ClearSellSlots()
	int n = SellSlots.length
	int i = 0
	while i < n
		SellSlots[i].Clear()
		i += 1
	endwhile
EndFunction

Function ClearSlaveSlots()
	int n = SlaveSlots.length
	int i = 0
	while i < n
		SlaveSlots[i].Clear()
		i += 1
	endwhile
EndFunction

Function EvaluateOwner(Actor owner)
	ClearSellSlots()
	int n = SellSlots.length - (1) ; last slot index
	int i = StorageUtil.FormListCount(owner, "aygasSlaves")
	int sc = 0;

	;debug.notification("Eval " + owner.getDisplayName() + ": count=" + i)
	while i > 0 && SellSlots[n].GetRef() == None
		i -= 1
		Actor slave = StorageUtil.FormListGet(owner, "aygasSlaves", i) as Actor
		if (slave !=  None)
			StoreInSlot(slave)
			sc += 1
		endif
		;debug.notification("- " + slave.GetDisplayName() + " " + StoreInSlot(slave))
	endwhile

	if (!sc)
		StorageUtil.FormListClear(owner, "aygasSlaves")
		owner.RemoveFromFaction(OwnerFaction)
		DebugLog("      Owner "+ owner.GetDisplayName() + " no longer has slaves")
	endif
EndFunction

Function EvaluateSex(Actor slave)
	IsFemale = (SexLab.GetGender(slave) == 1)
EndFunction

Function CheckSlaveForSale(Actor slave)
	if AYGASInter.IsAPlayerSlave(slave)
		StoreInSlot(slave)
		return
	endif

 	if ((HSHHouseSlaveFaction != None) && (slave.IsInFaction(HSHHouseSlaveFaction)))
		if ((slave.IsInFaction(HSHTrainerFaction)) || (slave.IsInFaction(HSHTraineeFaction)))
			return
		endif		
		StoreInSlot(slave)
	endif
EndFunction

Function GetSoftRequirements()
	bool has_HSH = HSH.HasHSH()
	if has_HSH != HasHSH
		HasHSH = has_HSH
		if (HasHSH)
			if (HSHHouseSlaveFaction  == None)
				HSHHouseSlaveFaction = Game.GetFormFromFile(0x00008972, "PAH_HomeSweetHome.esp") As Faction
			endif
			if (HSHTrainerFaction  == None)
				HSHTrainerFaction  = Game.GetFormFromFile(0x000140fb, "PAH_HomeSweetHome.esp") As Faction
			endif
			if (HSHTraineeFaction  == None)
				HSHTraineeFaction  = Game.GetFormFromFile(0x000140ff, "PAH_HomeSweetHome.esp") As Faction
			endif
			HSHHasAygasFunds  = Game.GetFormFromFile(0x000E4EC5, "PAH_HomeSweetHome.esp") As Faction
		else
			HSHHouseSlaveFaction = none
			HSHTrainerFaction = none
			HSHTraineeFaction  = none
			HSHHasAygasFunds  = none
		endif
	endif

	if (Game.GetModByname("BSHeartland.esm") != 255)
		if (CyrInnkeeperFaction == None)
			CyrInnkeeperFaction = Game.GetFormFromFile(0x0005bc06, "BSHeartland.esm") As Faction
		endif
		if (CyrMerchantFaction == None)
			CyrMerchantFaction = Game.GetFormFromFile(0x0005bbde, "BSHeartland.esm") As Faction
		endif
		if (EventFunctions.BrumaLocation == None)
			EventFunctions.BrumaLocation = Game.GetFormFromFile(0x00000f18, "BSHeartland.esm") As Location
		endif
	else
		CyrInnkeeperFaction = None
		CyrMerchantFaction = None
		EventFunctions.BrumaLocation = None
	endif

	HasZaz8 = (Game.GetFormFromFile(0x00085e57, "ZaZAnimationPack.esm") != None)
	ITF.GetSoftRequirements()
	HasTortureFramework = ITF.hasITF
	if (HasTortureFramework)
		ITFIgnoreOwner = (Game.GetFormFromFile(0x0001ef76, "ItortureFramework.esm")) as ActorBase
		HasTortureFramework = (ITFIgnoreOwner != None)
	else
		ITFIgnoreOwner = None
	endif
	
	AYGASInter.GetSoftRequirements()
EndFunction

bool Function StoreInSlot(Actor slave)
	if (slave == None)
		return false
	endif
	int n = SellSlots.length
	int i = 0
	while i < n
		if SellSlots[i].GetRef() == None
			SellSlots[i].ForceRefTo(slave)
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction


Function DebugLog(string txt)
	if (SDebugLog)
		debug.trace("aygas:" + txt)
	endif
EndFunction

Function DebugMessage(string txt)
	if (SDebugMessage)
		debug.notification(txt)
	endif
	if (SDebugLog)
		debug.trace("aygas:" + txt)
	endif
EndFunction

Function EndScene(Actor slave)
	aygasSlaveScript ss = SlaveSlot(slave) as aygasSlaveScript 
	if (ss != None)
		ss.Default()
	endif
	DebugLog(slave.GetDisplayName() + " scene end")
EndFunction

int Property NrSlavesForSale 
	int Function get() 
		return CheckSlavesNearPlayer() 
	EndFunction 
endProperty 

Function SlaveryGain(float gain)
	proLevelSlavery += gain * GainFactor()
	if (proLevelSlavery > 100)
		proLevelSlavery = 100
	endif
	EvaluatePerks()
EndFunction

Function EvaluatePerks()
	; Evaluate progress
	if ((!proTrader) && (proLevelSlavery >= 10.0))
		if (!SCheat)
			debug.notification("You have gained the perk 'Slave trader'!")
		endif
		proTrader = true
	endif
	if ((!proHandler) && (proLevelSlavery >= 20.0) && (proProstitutesSold >= 2))
		if (!SCheat)
			debug.notification("You have gained the perk 'Slave handler'!")
		endif
		proHandler = true
	endif
	if ((!proPatron) && (proLevelSlavery >= 30.0) && (proFightAttended >= 2))
		if (!SCheat)
			debug.notification("You have gained the perk 'Patron'!")
		endif
		proPatron = true
	endif
	if ((!proTrainer) && (proPatron) && (proLevelSlavery >= 40.0) && (proFightWon >= 3))
		if (!SCheat)
			debug.notification("You have gained the perk 'Trainer'!")
		endif
		proTrainer = true
	endif
	if ((!proPimp) && (proLevelSlavery >= 40.0) && (proProstituteTricks >= 15))
		if (!SCheat)
			debug.notification("You have gained the perk 'Pimp'!")
		endif
		proPimp = true
	endif
	if ((!proMadame) && (proPimp) && (proLevelSlavery >= 60.0) && (PlayerWhores() >= 5))
		if (!SCheat)
			if Game.GetPlayer().GetActorBase().GetSex() == 0
				debug.notification("You have gained the perk 'Monsieur'!")
			else
				debug.notification("You have gained the perk 'Madame'!")
			endif
		endif
		proMadame = true
	endif
	if ((!proHelpingHand) && (proSoldWorker) && (proSoldSexSlave) && (proSoldShopAssistant))
		if (!SCheat)
			debug.notification("You have gained the perk 'Helping Hand'!")
		endif
		proHelpingHand = true
	endif
EndFunction

Function DoProgress(int slaveType)
	if ((slaveType == 1) || (slaveType == 2))
		proProstitutesSold += 1
	elseif (slaveType == 6)
		proSoldSexSlave += 1
	elseif (slaveType == 3)
		proSoldShopAssistant += 1
	elseif ((slaveType == 5) || (slaveType == 10))
		proSoldWorker += 1
	endif
	EvaluatePerks()
EndFunction

Function DoJobExperience(Actor slave)
	int lvl = 0
	int job = slave.GetFactionRank(SlaveTypeFaction)
	if (slave.IsInFaction(JobExperience))
		lvl = slave.GetFactionRank(JobExperience)
	endif
	if (lvl < 100)
		lvl += 1
	endif
	slave.SetFactionRank(JobExperience, lvl)
EndFunction

float Function GainFactor()
	if (SDifficulty == 0)
		return 3
	elseif (SDifficulty == 1)
		return 2
	else
		return 1
	endif
EndFunction

Function CheckOwner(Actor slave)
	Actor owner = StorageUtil.GetFormValue(slave, "Owner") as Actor
	if (owner != None)
		Debug.Notification("This slave is owned by " + owner.GetDisplayName())
	else
		if (NominatedOwner != None)
			Debug.Notification("This slave appears to be owned by " + owner.GetDisplayName())
			int price = StorageUtil.GetIntValue(slave, "Price")
			if (price <= 0)
				price = AYGASInter.getBuyerPrice(slave, owner)
			endif
			SellSlave(slave, NominatedOwner, Utility.RandomInt(5, 6), price, false)
			slave.RemoveFromFaction(OwnerlessFaction)
			NominatedOwner = None
		else
			Debug.Notification("You find no owner's mark on this slave")
			slave.SetFactionRank(OwnerlessFaction, 1)
		endif
	endif
EndFunction


Function FollowOwner(Actor slave)
	Actor owner = StorageUtil.GetFormValue(slave, "Owner") as Actor
	if (owner != None)
		slave.MoveTo(owner)
	endif
	slave.SetFactionRank(JobOverrideAction, 1)
	utility.wait(1.0)
	slave.EvaluatePackage()
	utility.wait(1.0)
	slave.SetFactionRank(JobOverrideAction, 0)
	utility.wait(1.0)
	slave.EvaluatePackage()
EndFunction

bool Function JobSlaveAvailable(Actor slave, bool ignoreScenes)
	if slave == None
		;DebugMessage("JobSlaveAvailable: null acotor")
		return false
	endif
	if slave == Scenes.ReservedProstitute.getActorRef()
		;DebugMessage("JobSlaveAvailable: " + slave.GetDisplayName() + " is reserved")
		return false
	endif
	if slave.IsInFaction(IgnoreFaction)
		;DebugMessage("JobSlaveAvailable: " + slave.GetDisplayName() + " in ignore faction")
		return false
	endif
	if slave.IsInDialogueWithPlayer()
		;DebugMessage("JobSlaveAvailable: " + slave.GetDisplayName() + " is in dialogue")
		return false
	endif
	if slave.GetFactionRank(JobOverrideAction) > 0 
		;DebugMessage("JobSlaveAvailable: " + slave.GetDisplayName() + " job override action in effect")
		return false
	endif
	if SexLab.IsActorActive(slave)
		;DebugMessage("JobSlaveAvailable: " + slave.GetDisplayName() + " in SexLab scene")
		return false
	endif
	if !ignoreScenes && slave.GetCurrentScene() != None
		;DebugMessage("JobSlaveAvailable: " + slave.GetDisplayName() + " is in scene")
		return false
	endif
	return  true
EndFunction

bool Function JobClientAvailable(Actor client, Actor slave, Actor owner)
	return  ((client != None) && (client != slave) && (client != owner) && (!client.IsInDialogueWithPlayer() )  && \
					 (client != Game.GetPlayer()) && (!client.IsInFaction(SlaveTypeFaction)) && (!client.IsInFaction(IgnoreFaction)) &&  (!AYGASInter.IsSexTrained(client)) && \
					(!SexLab.IsActorActive(client)) && (!client.HasMagicEffect(TrickCooldown)) && (!Scenes.NPCInScene(client)) && (client.GetCurrentScene() == None) && \
					(!client.HasKeyword(ActorTypeAnimal)) && (!client.HasKeyword(ActorTypeCreature)) && (!client.HasKeyword(ActorTypeUndead)) && \
					(!client.IsChild()) && (!client.IsGuard()) && (!client.IsGhost()) && ((HSHHouseSlavefaction == None) || (!client.IsInFaction(HSHHouseSlaveFaction))) && \ 
					((!Client.IsInFaction(FollowerFaction)) || (!AYGASInter.IsAPlayerSlave(slave))) )
EndFunction

bool Function LocationEligibleForProstitution(Actor slave, bool includeWilderness)
	Cell pc = slave.GetparentCell()
	bool isIndoor = false
	if (pc.IsInterior())
		IsIndoor = true
	endif
	if (slave.GetCurrentLocation() == None)
		return includeWilderness
	endif

	IsEligibleForProstitution = (((EventFunctions.SlaveryLevelAtLocation < 0) && (includeWilderness))|| ((!IsIndoor) && (EventFunctions.SlaveryLevelAtLocation >= 4)) \
				 || (slave.GetCurrentLocation().HasKeyword(Scenes.KeywordInn) ))
	IsEligibleForProstitutionCity = ( ((EventFunctions.SlaveryLevelAtLocation >= 4) && (!IsIndoor)) || (slave.GetCurrentLocation().HasKeyword(Scenes.KeywordInn) ))
	return IsEligibleForProstitution 
EndFunction

; Tries 3 times to find an eligible partner for given prostitute. Partner can be rejected based on type, gender, factions, and if they are busy or not.
Actor Function FindEligibleJohn(Actor prostitute, Actor owner, int range)
	int tries = 5
	while (tries > 0)
		Actor client = Game.FindRandomActorFromRef(prostitute, range)
		if ((JobClientAvailable(client, prostitute, owner)) && (GenderCheck(client, prostitute)))
			return client
		endif
		tries -= 1
	endwhile
EndFunction

bool Function GenderCheck(Actor a1, Actor a2)
	if ((a1 == None) || (a2 == None))
		return true
	elseif ((SexLab.GetGender(a1) != SexLab.GetGender(a2)) || (SGaySex == 2))		; Check up genders if required
		return true
	elseif ((SGaySex == 1) && (Utility.RandomInt(1,4) == 1))
		return true
	else
		return false
	endif
EndFunction

int Function PlayerWhores()
	int whores = 0
	int i = StorageUtil.FormListCount(Game.GetPlayer(), "aygasSlaves")
	while ((i > 0) && (whores < 5))
		i-=1
		Actor slave = StorageUtil.FormListGet(Game.GetPlayer(), "aygasSlaves", i) as Actor
		int slaveType = slave.GetFactionRank(SlaveTypeFaction)
		if ((slavetype == 1) || (slavetype == 2))
			whores += 1
		endif
	endwhile
	return whores
EndFunction

bool Function CheckHSHSlave(Actor slave)
	if (HSHHouseSlaveFaction != None)
		IsHSHSlave = (slave.IsInFaction(HSHHouseSlaveFaction))
	else
		IsHSHSlave = false
	endif
	return IsHSHSlave
EndFunction

bool Function IsPlayerHouse()
	if ((HasHSH) && (Game.GetPlayer().IsInInterior()))
		IsInPAHHouse = HSH.IsPlayerHouse()
	else
		Location l = Game.GetPlayer().GetCurrentLocation()
		if (l != none)
 			IsInPAHHouse = l.HasKeyword(KwdPlayerHome)
		else
			IsInPAHHouse = false
		endif
	endif
	return IsInPAHHouse
EndFunction

Function ProstituteSex(Actor prostitute, Actor john)
	WorkFunctions.TrainSex(prostitute, utility.RandomInt(6, 15))
	if (prostitute.GetFactionRank(JobExperience) > 5)
	   SexLab.QuickStart(prostitute, john, none, none, none, none)
	else
	   actor[] sexActors = new actor[2]
	   sexActors[0] = prostitute
	   sexActors[1] = john
	  sslBaseAnimation[] anims
	  anims = SexLab.GetAnimationsByTag(2, "Aggressive")
	  SexLab.StartSex(sexActors, anims, victim=john, allowBed=true, hook="AygasSlave");

	  AYGASInter.FollowPlayer(prostitute)
	endif
EndFunction

Function Uninstall()
	int o = StorageUtil.FormListCount(none, "aygasOwners")
	DebugLog("aygas: Removing " + o + " owners")
	Debug.Notification("Uninstalling Aygas, be patient")
	while(o > 0)
		o-=1
		Actor owner = StorageUtil.FormListGet(none, "aygasOwners", o) as Actor
		if (owner != none)
			DebugLog("Removing owner " + owner.GetDisplayName())

			int i = StorageUtil.FormListCount(owner, "aygasSlaves")
			while(i > 0)
				i-=1
				Actor slave = StorageUtil.FormListGet(owner, "aygasSlaves", i) as Actor
				if (slave != none)
					DebugLog("Removing slave " + slave.GetDisplayName())
					if ((!slave.IsDeleted()) && (!slave.IsDead()))
						slave.SetDontMove(false)
					endif
					StorageUtil.UnsetIntValue(slave, "OwnerSatisfaction")
					StorageUtil.UnsetIntValue(slave, "Price")
					StorageUtil.UnsetFloatValue(slave, "DateOfSale")
					StorageUtil.FormListClear(slave, "aygasWornItems")
					slave.RemoveFromFaction(SlaveTypeFaction)
					slave.RemoveFromFaction(OwnedByPlayer)
					slave.RemoveFromFaction(HasJobGold)
					slave.RemoveFromFaction(UnslottedFaction)
					slave.RemoveFromFaction(JobOverrideAction)
					slave.RemoveFromFaction(JobExperience)
				endif
			endwhile
		endif
		StorageUtil.FormListClear(owner, "aygasSlaves")
		owner.RemoveFromFaction(OwnerFaction)
	endwhile
	StorageUtil.FormListClear(none, "aygasOwners")
	ClearSlaveSlots()
	Debug.MessageBox("The Aygas mod can now be uninstalled")
EndFunction

aygasSlaveScript Function SlaveRef(Actor akRef)
	int n = SlaveSlots.length
	int i
	if akRef.GetFactionRank(DOMSlaveManagerFaction) == 50; AYGAS
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n
			if SlaveSlots[i].GetActorRef() == akRef
				return SlaveSlots[i] as aygasSlaveScript
			endif
		endif
	endif
	ReferenceAlias slot = None
	i = 0
	while i < n && slot == None
		if SlaveSlots[i].GetActorRef() == akRef
			slot = SlaveSlots[i]
		else
			i += 1
		endif
	endwhile
	if slot != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,50) ; 50 is AYGAS
		return slot as aygasSlaveScript
	endif
	;/
	n = SellSlots.length
	i = 0
	if akRef.GetFactionRank(DOMSlaveManagerFaction) == 51; AYGAS Sell slot
		i = akRef.GetFactionRank(DOMAliasIndexFaction)
		if i >= 0 && i < n
			if SellSlots[i].GetActorRef() == akRef
				return SellSlots[i] as aygasSlaveScript
			endif
		endif
	endif
	slot = None
	i = 0
	while i < n && slot == None
		if SellSlots[i].GetActorRef() == akRef
			slot = SellSlots[i]
		else
			i += 1
		endif
	endwhile
	if slot != None
		akRef.SetFactionRank(DOMAliasIndexFaction,i)
		akRef.SetFactionRank(DOMSlaveManagerFaction,51) ; AYGAS Sell slot
		return slot as aygasSlaveScript
	endif
	/;
	return None
EndFunction

Function LogTrace(string msg)
	if AYGASInter.isVerboseMode()
		Debug.Trace("AYGASCoreScript: "+msg)
	endif
EndFunction

MiscObject Property Gold Auto

Spell Property FindSlaveAbility Auto
MagicEffect Property TrickCooldown Auto
Spell Property TrickCooldownSpell Auto

Armor Property ZazCollar Auto
Armor Property ZazLegIrons Auto
Armor Property ZazYoke Auto
Armor Property ZazShackles Auto

aygasITFFunctions Property ITF Auto
ActorBase Property ITFIgnoreOwner Auto Hidden

aygasHSHFunctions Property HSH Auto
Faction Property HSHHouseSlaveFaction Auto Hidden
Faction Property HSHTrainerFaction Auto Hidden
Faction Property HSHTraineeFaction Auto Hidden
Faction Property HSHHasAygasFunds Auto Hidden

Faction Property MerchantFaction Auto
Faction Property CaravanFaction Auto
Faction Property InnKeeperFaction Auto
Faction Property MinerFaction Auto
Faction Property FarmerFaction Auto
Faction Property LumberjackFaction Auto

Faction Property SlaveTypeFaction Auto
Faction Property UnslottedFaction Auto
Faction Property SlottedFaction Auto
Faction Property OwnerFaction Auto
Faction Property JobExperience Auto
Faction Property JobOverrideAction Auto			; 1=Following player, 2=Bound in furniture (short), 3=perma bound
Faction Property StoredFaction Auto
Faction Property ProstitutionType Auto
Faction Property HasJobGold Auto
Faction Property SpentPlayerGold Auto
Faction Property OwnedByPlayer Auto
Faction Property OwnerlessFaction Auto
Faction Property IgnoreFaction Auto

Faction Property CyrInnkeeperFaction Auto Hidden
Faction Property CyrMerchantFaction Auto Hidden
Faction Property FollowerFaction Auto

SexLabFramework Property SexLab Auto

aygasSellScript Property SellQuest Auto
aygasScenesScript Property Scenes Auto

ReferenceAlias[] Property SellSlots Auto
ReferenceAlias[] Property SlaveSlots Auto
ReferenceAlias[] Property Owners Auto
ReferenceAlias Property SelectedSlot Auto
ReferenceAlias Property PlayerRef Auto

Idle Property IdleDrinkTray Auto
Idle Property IdleSoupPot Auto

Idle Property IdlePose1 Auto
Idle Property IdlePose2 Auto
Idle Property IdlePose3 Auto
Idle Property IdlePose4 Auto
Idle Property IdlePose5 Auto
Idle Property IdlePose6 Auto

FormList Property Beds Auto

bool Property HasHSH Auto

aygasEvents Property EventFunctions Auto
aygasStorageScript Property StorageFunctions Auto
aygasWorkScript Property WorkFunctions Auto
aygasWorkDetectorScript Property WorkDetector Auto
aygasPatronDetectorScript Property PatronDetector Auto
aygasEventDetectorScript Property EventDetector Auto
FormList Property RulingActors Auto
Keyword Property KwdPlayerHome Auto

bool Property IsEligibleForProstitution Auto Conditional Hidden
bool Property IsEligibleForProstitutionCity Auto Conditional Hidden
int Property ProstitutesNearby Auto Conditional Hidden
int Property SlavesNearby Auto Conditional Hidden
bool Property IsInPAHHouse Auto Conditional Hidden
bool Property IsHSHSlave Auto Conditional Hidden
bool Property IsFemale Auto Conditional Hidden

bool Property IsInBruma Auto Conditional Hidden
bool Property HasZaz8 Auto Conditional			; Tara's combined ZAP + furni pack
bool Property HasTortureFramework Auto

Keyword Property ActorTypeAnimal Auto
Keyword Property ActorTypeCreature Auto
Keyword Property ActorTypeUndead Auto

;Keyword Property kwdZbfRestrained Auto
;Keyword Property kwdDDRestrained Auto

Furniture Property FurnPillory Auto
Furniture Property FurnTree2 Auto
Furniture Property FurnStake Auto
Furniture Property FurnPole Auto
Furniture Property FurnPoleCross Auto
Furniture Property FurnPole2 Auto


Actor Property NominatedOwner Auto Hidden
float Property ZoneTime Auto Hidden
string Property LastVersion Auto Hidden

; Settings
bool Property SDebugMessage Auto
bool Property SDebugLog Auto
bool Property SBuyBack Auto conditional
bool Property SDoEvents Auto conditional
int Property SDifficulty Auto
int Property SGaySex Auto Conditional
int Property SSlaveSpawnRatio Auto		; 0 = balanced, 1 = most males, 2 = all males, -1 = most females, -2 = all females
int Property SSaleRate Auto			; Rate at which NPCs sell their slaves.  0 = never
bool Property SAutoCollectUpkeep Auto Hidden
int Property SWeeklyUpkeep Auto
bool Property SUseWorldFurniture Auto
bool Property SSpawnFurniture Auto
bool Property SCheat Auto conditional Hidden
bool Property SCheatCities Auto Hidden

; Achievements
bool Property proTrader Auto conditional Hidden
bool Property proHandler Auto conditional Hidden
bool Property proPimp Auto conditional Hidden
bool Property proPatron Auto conditional Hidden
bool Property proTrainer Auto conditional Hidden
bool Property proHelpingHand Auto conditional Hidden
bool Property proMadame Auto  conditional Hidden
bool Property proTaskmaster Auto conditional Hidden

; Progress trackers
float Property proLevelSlavery Auto conditional Hidden
int Property proProstitutesSold Auto Hidden
int Property proProstituteTricks Auto Hidden
int Property proSoldShopAssistant Auto Hidden
int Property proSoldWorker Auto Hidden
int Property proSoldSexSlave Auto Hidden
int Property proFightAttended Auto Hidden
int Property proFightWon Auto Hidden

