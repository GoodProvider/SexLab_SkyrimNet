;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname QF_PAHONobleDesires_06028A75 Extends Quest Hidden

;BEGIN ALIAS Property SellSlot
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_SellSlot Auto
;END ALIAS Property

;BEGIN ALIAS Property Pardo
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Pardo Auto
;END ALIAS Property

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
setObjectiveCompleted(30)
setObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(21)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SetObjectiveFailed(21)
SetObjectiveDisplayed(20, false)
SetObjectiveDisplayed(22)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(22, false)
SetObjectiveCompleted(21)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
setObjectiveCompleted(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Event OnUpdate()
	Alias_SellSlot.Clear()
	StartQst.AskWhichSlave = false
EndEvent

Function StoreForAuction()
	Actor slave = Alias_SellSlot.GetActorRef()
	StartQst.PHHSH.LockupInHunter(slave)
	if (StartQst.PHHSH.SlaveRef(slave) != none)
		slave.AddToFaction(ReservedFaction)
		Alias_SellSlot.Clear()

		if (PAHONrOfSlavesDelivered.GetValue() < 3)
			PAHONrOfSlavesDelivered.SetValue(PAHONrOfSlavesDelivered.GetValue() + 1)
			UpdateCurrentInstanceGlobal(PAHONrOfSlavesDelivered)
			if (PAHONrOfSlavesDelivered.GetValue() != 3)
				SetObjectiveDisplayed(10, true, true)
			else
				SetStage(20)
			endif
		endif
	endif
EndFunction

Function ExitAuction()
	HunterOutsideDoor.Lock(false, true)
EndFunction

Function OfferForAuction()
	Alias_SellSlot.Clear()
	Economics.DeclinedIndex = 0
	Economics.AcceptedIndex = 0
	StartQst.AskWhichSlave = true
	RegisterForSingleUpdate(60)
EndFunction

Function EvaluateForAuction(Actor slave)
	if (slave != none)
		StartQst.AskWhichSlave = false
		Economics.AcceptAsSpecial(slave)
	endif
EndFunction

Function Collect()
	Game.GetPlayer().AddItem(Gold, math.floor(HunterFunctions.TotalValue * 0.8))
	Game.GetPlayer().AddItem(HunterUpstairsKey, 1)
	HunterFunctions.TotalValue =0
EndFunction

Key Property HunterBasementKey Auto
Key Property HunterUpstairsKey Auto
Book Property ShoppingList Auto
PAHOCore Property StartQst  Auto  
PHHSHEconomics Property Economics Auto
Faction Property ReservedFaction Auto
GlobalVariable Property PAHONrOfSlavesDelivered  Auto
PHHSHHunterOperation Property HunterFunctions Auto
MiscObject Property Gold Auto
ObjectReference Property HunterOutsideDoor Auto