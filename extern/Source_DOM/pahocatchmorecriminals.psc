Scriptname PAHOCatchMoreCriminals extends Quest  

PHHSHInterface Property PHHSHInter Auto

Event OnInit()
	RegisterForUpdate(1)
EndEvent

Event OnUpdate()
;	debug.notification("tick")
	Actor slaver_chief = Slaver3.GetActorRef()
	if slaver_chief == none
		return
	endif
	if ((GetStage()==40) || (GetStage()==50))
		if !(slaver_chief.IsDead())
			return
		endif
		;LogTrace("Slaver chief is dead "+slaver_chief.GetDisplayName())
		Actor henchman = Slaver1.GetActorRef()
		henchman.SetActorValue("aggression", 0.0)
		henchman.RemoveFromFaction(PHHSHInter.DOMNotPlayerSlaverFaction)
		henchman.SetFactionRank(PHHSHInter.DOMPotentialSlaverFaction,1)
		henchman.StopCombatAlarm()
		;LogTrace("Slaver henchman "+henchman.GetDisplayName()+" rank="+henchman.GetFactionRank(PHHSHInter.DOMNotPlayerSlaverFaction))
		Actor henchwoman = Slaver2.GetActorRef()
		henchwoman.SetActorValue("aggression", 0.0)
		henchwoman.RemoveFromFaction(PHHSHInter.DOMNotPlayerSlaverFaction)
		henchwoman.SetFactionRank(PHHSHInter.DOMPotentialSlaverFaction,1)
		henchwoman.StopCombatAlarm()
		;LogTrace("Slaver henchwoman "+henchwoman.GetDisplayName()+" rank="+henchwoman.GetFactionRank(PHHSHInter.DOMNotPlayerSlaverFaction))
		if (GetStage() == 40)
			SetObjectiveCompleted(51)
		else
			SetObjectiveCompleted(60)
		endif
		if (Game.GetPlayer().GetItemCount(SlaversNote) == 0)
			SetStage(55)
		else
			SetStage(60)
		endif
		UnregisterForUpdate()
	endif
EndEvent

Function DeliverPrisoner()
	if (NrOfPrisoners.GetValue() < 3)
		NrOfPrisoners.SetValue(NrOfPrisoners.GetValue() + 1)
		UpdateCurrentInstanceGlobal(NrOfPrisoners)
		if (NrOfPrisoners.GetValue() != 3)
			SetObjectiveDisplayed(10, true, true)
		else
			SetStage(10)
		endif
	endif
EndFunction

Function GiveKey()
	Game.GetPlayer().AddItem(SlaverKey, 1)
EndFunction

Function EnslaveMona()
	Actor mona = MonaRef.GetRef() as Actor
	mona.SetRestrained(false)
	MonaRef.Clear()
	PHHSH.DeregisterFromWhiteRun(mona)
EndFunction

Function FreeMona()
	Actor mona = MonaRef.GetRef() as Actor
	if PHHSHInter.DOM != None
		mona.RemoveFromFaction(PHHSHInter.DOM.DOMZaz.DOMHasCuffsBack)
	endif
	mona.SetRestrained(false)
	mona.RemoveItem(ItemCollar)
	mona.RemoveItem(ItemAnkle)
	mona.RemoveItem(ItemWrist)
	MonaRef.Clear()
	Debug.SendAnimationEvent(mona,"IdleForceDefaultState")
	if mona.GetRelationshipRank(Game.GetPlayer()) < 3
		mona.SetRelationshipRank(Game.GetPlayer(),3)
	endif
EndFunction

Function CaptureMona()
	Actor mona = MonaRef.GetActorRef()
	mona.SetRestrained(false)
	MonaRef.Clear()
	PHHSHInter.DOM.DOMkeys.DOMActorCaptureFront(mona,"You swiftly grab Mona's neck")
EndFunction

bool Function CheckSlottedPrisoner()
	LogTrace("PAHOCatchMoreCriminals CheckSlottedPrisoner FreeSlotForLocation")
	ReferenceAlias ref = PAHO.PAHOCampOps.FreeSlotForLocation()
	if (ref != none)
		return true
	else
		PAHO.AskWhichSlave = false
		PAHO.SellSlot.Clear()	
		return false
	endif
EndFunction

Function TransferSlottedPrisoner(int baseAmount = 400)
	LogTrace("PAHOCatchMoreCriminals TransferSlottedPrisoner")
	ReferenceAlias ref = PAHO.SellSlot
	if ref == none
		LogTrace("PAHOCatchMoreCriminals TransferSlottedPrisoner sell slot is NONE")
		return
	endif
	Actor akRef = ref.GetActorRef()
	if akRef == None
		LogTrace("PAHOCatchMoreCriminals TransferSlottedPrisoner No actor in slot")
		return
	endif
	if PHHSHInter.DOM != None
		baseAmount += akRef.GetFactionRank(PHHSHInter.DOMTrainWorking)*2
		baseAmount += akRef.GetFactionRank(PHHSHInter.DOMTrainHouse)
	endif
	int margin = (baseAmount / 6)
	Game.GetPlayer().AddItem(PAHO.Gold, utility.Randomint(baseAmount - margin,baseAmount + margin))
	LogTrace("PAHOCatchMoreCriminals TransferSlottedPrisoner actor="+akRef.GetDisplayName())
	PAHO.TransferSlave()
	DeliverPrisoner()
EndFunction

Function SpawnSlaverCamp()
	CampMarker.Enable()
	Actor mona = MonaRef.GetRef() as Actor
	Mona.Enable()
	mona.SetRestrained(true)
	mona.EquipItem(ItemCollar, true, true)
	mona.EquipItem(ItemAnkle, true, true)
	mona.EquipItem(ItemWrist, true, true)
EndFunction

Function RemoveSlaverCamp()
	LogTrace("PAHOCatchMoreCriminals RemoveSlaverCamp SKIPPED")
	return
	;/
	String s = "Removing slaver camp near Dawnstar.  "
	CampMarker.Disable()
	Actor merian = MerianRef.GetActorRef()
	Actor mona = MonaRef.GetActorRef()
	if ((merian != none) && (!PHHSHInter.IsAPlayerSlave(merian)) && (!merian.IsInFaction(PAHO.PHHSH.HouseSlaveFaction)))
		merian.Disable()
		s += "Merian removed.   "
	endif
	if ((mona != none) && (!PHHSHInter.IsAPlayerSlave(mona)) && (!mona.IsInFaction(PAHO.PHHSH.HouseSlaveFaction)))
		mona.Disable()
		s += "Mona removed.   "
	endif
	PAHO.PHHSH.DebugLog(s)
	/;
EndFunction

bool is_slavery_restored = false
Function RestoreSlavery()
	if is_slavery_restored
		return
	endif
	if !IsRunning()
		LogTrace("RestoreSlavery Quest is not running")
		return
	endif
	LogTrace("RestoreSlavery Restoring HSH mine camps")
	LogTrace("RestoreSlavery MerianRef="+MerianRef+" "+MerianRef.GetRef()+" "+MerianRef.GetActorRef())
	LogTrace("RestoreSlavery MonaRef="+MonaRef+" "+MonaRef.GetRef()+" "+MonaRef.GetActorRef())
	is_slavery_restored = true
	if (MerianRef.GetRef() as Actor).IsDisabled() && !(MerianRef.GetRef() as Actor).IsDead()
		(MerianRef.GetRef() as Actor).Enable()
	endif
	if (MonaRef.GetRef() as Actor).IsDisabled() && !(MonaRef.GetRef() as Actor).IsDead()
		(MonaRef.GetRef() as Actor).Enable()
	endif
	if (PadrinRef.GetRef() as Actor).IsDisabled() && !(PadrinRef.GetRef() as Actor).IsDead()
		(PadrinRef.GetRef() as Actor).Enable()
	endif
	if (Guard1Ref.GetRef() as Actor).IsDisabled() && !(Guard1Ref.GetRef() as Actor).IsDead()
		(Guard1Ref.GetRef() as Actor).Enable()
	endif
	if (Guard2Ref.GetRef() as Actor).IsDisabled() && !(Guard2Ref.GetRef() as Actor).IsDead()
		(Guard2Ref.GetRef() as Actor).Enable()
	endif
	if (Guard3Ref.GetRef() as Actor).IsDisabled() && !(Guard3Ref.GetRef() as Actor).IsDead()
		(Guard3Ref.GetRef() as Actor).Enable()
	endif	
EndFunction

Function EndSlavery()
	is_slavery_restored = false
	;CampMarker.Disable()
	;(MerianRef.GetRef() as Actor).Disable()
	;(MonaRef.GetRef() as Actor).Disable()
	;(PadrinRef.GetRef() as Actor).Disable()
	;(Guard1Ref.GetRef() as Actor).Disable()
	;(Guard2Ref.GetRef() as Actor).Disable()
	;(Guard3Ref.GetRef() as Actor).Disable()
	
EndFunction

Function LogTrace(string msg)
	if PHHSHInter.isVerboseMode()
		Debug.Trace("PAHOCatchMoreCriminals: "+msg)
	endif
EndFunction

GlobalVariable Property NrOfPrisoners  Auto
PAHOCore Property PAHO Auto   
Topic Property TopicCampFull Auto
Faction Property AttackPlayerFaction Auto
ReferenceAlias Property JarlInform Auto
ObjectReference Property SlaversManifestBook Auto
ReferenceAlias Property MonaRef Auto
ReferenceAlias Property MerianRef Auto
ReferenceAlias Property PadrinRef Auto
ObjectReference Property CampMarker Auto
ReferenceAlias Property Slaver1 Auto
ReferenceAlias Property Slaver2 Auto
ReferenceAlias Property Slaver3 Auto
Book Property SlaversNote Auto
Armor Property ItemCollar Auto
Armor Property ItemAnkle Auto
Armor Property ItemWrist Auto
PHHSHStorageFunctions Property PHHSH Auto
Key Property SlaverKey Auto
ReferenceAlias Property Guard1Ref Auto
ReferenceAlias Property Guard2Ref Auto
ReferenceAlias Property Guard3Ref Auto
Actor Property Pardo Auto

MiscObject Property Gold  Auto  
