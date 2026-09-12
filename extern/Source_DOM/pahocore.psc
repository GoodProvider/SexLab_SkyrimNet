Scriptname PAHOCore extends Quest  Conditional

PHHSHInterface Property PHHSHInter Auto

Function SetConversationJark(Actor akSpeaker, int ns)
	Jarl.ForceRefTo(akSpeaker)
	NextStage = ns
EndFunction

Function AskPlayerWhichSlave()
	Debug.Trace("PAHOCore AskPlayerWhichSlave alias="+SellSlot.GetActorRef())
	AskWhichSlave = true
	RegisterForSingleUpdate(120.0)
EndFunction

Event OnUpdate()
	Debug.Trace("PAHOCore OnUpdate alias="+SellSlot.GetActorRef())
	AskWhichSlave = false
	SellSlot.Clear()	
EndEvent

Function SellSlottedMiner(int amount)
	Debug.Trace("PAHOCore SellSlottedMiner alias="+SellSlot.GetActorRef()+" AskWhichSlave="+AskWhichSlave)
	Actor akRef = SellSlot.GetActorRef()
	if akRef == None
		return
	endif
	if PHHSHInter.DOM != None
		amount += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainWorking)*2
		amount += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainHouse)
		amount += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainSubmission)/5
		amount += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainRespect)/5
		amount += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainFear)/10
		amount += akRef.GetFactionRank(PHHSHInter.DOM.DOMTrainResignation)/10
	endif
	Debug.Trace("PAHOCore SellSlottedMiner "+akRef.GetDisplayName()+" for "+amount+" gold")
	Game.GetPlayer().AddItem(Gold, amount)
	TransferSlave()
EndFunction

Function SellSlottedSlave()
	Debug.Trace("PAHOCore SellSlottedSlave alias="+SellSlot.GetActorRef())
	TransferSlave()
EndFunction

Function TransferSlave()
	Actor slave = SellSlot.GetActorRef()
	AskWhichSlave = false
	SellSlot.Clear()
	if slave == None
		Debug.Trace("PAHOCore TransferSlave ERROR empty alias="+SellSlot)
		return
	endif
	Debug.Trace("PAHOCore TransferSlave alias="+slave.getDisplayName())
	ReferenceAlias ref = PAHOCampOps.FreeSlotForLocation()
	; Notify selling
	if PHHSH.DOM01 != None
		DOM_Actor akActor = PHHSH.DOM01.GetActor(slave)
		if akActor != None
			PHHSH.DOM01.PlayerHasSold(akActor)
		endif
	endif
	PHHSH.RemoveSlaveFromDOM(slave)
	Outfit my_outfit = slave.GetLeveledActorBase().GetOutfit()
	slave.UnequipAll()
	if PAHOCampOps.IsAliasMaid(ref)
		slave.SetOutfit(MaidOutfit)
	else
		slave.SetOutfit(MinerOutfit)
	endif
	slave.StopCombatAlarm()
	slave.StopCombat()
	slave.SetActorValue("aggression", 0.0)
	if (ref == none)
		return
	endif
	ref.ForceRefTo(slave)
	PAHOCampOps.AfterAssign(ref)
	DOM_Actor akActor = ref as DOM_Actor
	if my_outfit != None
		akActor.SetOldOutfit(my_outfit)
	endif
	;akActor.OnUpdate() ; Already handled by PHHSHHouseSlave
	;akActor.OnUpdateGameTime()
EndFunction

Function UpdateMap()
	Debug.Notification("Map updated")
	Debug.Trace("PAHOCore UpdateMap - Map updated")
	SetObjectiveCompleted(GetStage()+20)
	SetStage(60)
EndFunction

ReferenceAlias Function SlaveRef(Actor akRef)
	return PAHOCampOps.SlaveRef(akRef)
EndFunction

FavorJarlsMakeFriendsScript Property ThaneCheck Auto

ReferenceAlias Property Jarl Auto
ReferenceAlias Property SellSlot Auto
int Property NextStage Auto Conditional
Armor Property ItemCollar Auto
Weapon Property ItemWhip Auto
MiscObject Property Gold Auto
bool Property AskWhichSlave = false Auto Conditional
PAHOCampOperation Property PAHOCampOps Auto
PHHSHStorageFunctions Property PHHSH Auto
Outfit Property MinerOutfit Auto
Outfit Property MaidOutfit Auto
PAHOCatchMoreCriminals Property PrisonerQst Auto
Quest Property AltStartQuest Auto