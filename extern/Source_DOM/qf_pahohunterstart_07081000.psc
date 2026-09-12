;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF_PAHOHunterStart_07081000 Extends Quest Hidden

;BEGIN ALIAS PROPERTY GuardSanurarauch
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardSanurarauch Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Pardo
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pardo Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BuySlot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BuySlot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardStonehills
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardStonehills Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardQuickSilverMine
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardQuickSilverMine Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SellSlot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SellSlot Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveCompleted(30)
NextQuest.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(20)
SetObjectiveCompleted(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
setObjectiveDisplayed(30)
SetObjectiveCompleted(20)
Alias_SellSlot.Clear()
Alias_GuardQuickSilverMine.GetRef().Enable(true)
Alias_GuardStoneHills.GetRef().Enable(true)
Alias_GuardSanurarauch.GetRef().Enable(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PHHSHInterface Property PHHSHInter Auto

Function AskPlayerWhichSlave()
	PAHO.AskWhichSlave = true
	RegisterForSingleUpdate(120)
EndFunction

Event OnUpdate()
	PAHO.AskWhichSlave = false
	Alias_SellSlot.Clear()	
EndEvent


Function SellSlottedMiner(int amount)
	Debug.Trace("PAHOHunterStart SellSlottedMiner alias="+Alias_SellSlot.GetRef())
	Actor akRef = Alias_SellSlot.GetActorRef()
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
	Debug.Trace("PAHOHunterStart SellSlottedMiner "+akRef.GetDisplayName()+" for "+amount+" gold")
	Game.GetPlayer().AddItem(Gold, amount)
	TransferSlave()
EndFunction

Function SellSlottedSlave()
	TransferSlave()
EndFunction

Function TransferSlave()
	Debug.Trace("PAHOHunterStart TransferSlave alias="+Alias_SellSlot.GetRef())
	Actor slave = Alias_SellSlot.GetRef() as Actor
	PAHO.AskWhichSlave = false
	Alias_SellSlot.Clear()
	if slave == None
		Debug.Trace("PAHOHunterStart TransferSlave ERROR empty alias="+Alias_SellSlot)
		return
	endif
	Debug.Trace("PAHOHunterStart TransferSlave FreeSlotForLocation")
	ReferenceAlias ref = PAHOCampOps.FreeSlotForLocation()
	; Notify selling
	if PHSF.DOM01 != None
		DOM_Actor akActor = PHSF.DOM01.GetActor(slave)
		if akActor != None
			PHSF.DOM01.PlayerHasSold(akActor)
		endif
	endif
	PHSF.RemoveSlaveFromDOM(slave)
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
	if (ref != none)
		ref.ForceRefTo(slave)
	endif
	PAHOCampOps.AfterAssign(ref)
	DOM_Actor akActor = ref as DOM_Actor
	if my_outfit != None
		akActor.SetOldOutfit(my_outfit)
	endif
	;akActor.OnUpdate() ; Already handled by PHHSHHouseSlave
	;akActor.OnUpdateGameTime()
EndFunction

PAHOCampOperation Property PAHOCampOps Auto
PAHOCOre Property PAHO Auto
PHHSHStorageFunctions Property PHSF Auto
Outfit Property MinerOutfit Auto
Outfit Property MaidOutfit Auto
MiscObject Property Gold Auto
Quest Property NextQuest Auto
