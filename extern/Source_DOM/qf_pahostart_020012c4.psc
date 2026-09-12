;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname QF_PAHOStart_020012C4 Extends Quest Hidden

;BEGIN ALIAS Property GuardDawnstar
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardDawnstar Auto
;END ALIAS Property

;BEGIN ALIAS Property LeigelfDawnstar
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_LeigelfDawnstar Auto
;END ALIAS Property

;BEGIN ALIAS Property Jarl
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS Property

;BEGIN ALIAS Property GuardKarthwasten
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardKarthwasten Auto
;END ALIAS Property

;BEGIN ALIAS Property SellSlot
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_SellSlot Auto
;END ALIAS Property

;BEGIN ALIAS Property GuardMorthal
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardMorthal Auto
;END ALIAS Property

;BEGIN ALIAS Property AinethachKarthwasten
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_AinethachKarthwasten Auto
;END ALIAS Property

;BEGIN ALIAS Property Player
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS Property

;BEGIN ALIAS Property GhorzaMarkath
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_GhorzaMarkath Auto
;END ALIAS Property

;BEGIN ALIAS Property PacturStonehills
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_PacturStonehills Auto
;END ALIAS Property

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
setObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveCompleted(50)
SetObjectiveDisplayed(61)
Alias_GuardKarthwasten.GetRef().Enable(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SetObjectiveCompleted(20)
actor Ghorza = Alias_GhorzaMarkath.GetActorRef()
if ((Ghorza != None) && (!Ghorza.IsDead()))
   SetObjectiveDisplayed(40)
else
   SetStage(31)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
if PAHOCamps == None
	PAHOCamps = Game.GetFormFromFile(0x00019FFF, "PAH_HomeSweetHome.esp") as PAHOCampOperation
endif
if Alias_GuardDawnStar.GetRef() == None
	Alias_GuardDawnStar.ForceRefTo(PAHOCamps.OverseerDawnstar)
endif
Alias_GuardDawnStar.GetRef().Enable(true)
if Alias_GuardMorthal.GetRef() == None
	Alias_GuardMorthal.ForceRefTo(PAHOCamps.OverseerStonehills)
endif
Alias_GuardMorthal.GetRef().Enable(true)
if Alias_GuardKarthwasten.GetRef() == None
	Alias_GuardKarthwasten.ForceRefTo(PAHOCamps.OverseerKarthwarsten)
endif
Alias_GuardKarthwasten.GetRef().Enable(true)
NextQuest.SetStage(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveCompleted(50)
SetObjectiveDisplayed(62)
Alias_GuardDawnStar.GetRef().Enable(true)
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

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(10)
actor Ghorza = Alias_GhorzaMarkath.GetActorRef()
if ((Ghorza != None) && (!Ghorza.IsDead()))
   SetObjectiveDisplayed(40)
else
   SetStage(30)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveCompleted(50)
SetObjectiveDisplayed(60)
Alias_GuardMorthal.GetRef().Enable(true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
setObjectiveCompleted(30)
actor Ghorza = Alias_GhorzaMarkath.GetActorRef()
if ((Ghorza != None) && (!Ghorza.IsDead()))
   SetObjectiveDisplayed(40)
else
   SetStage(32)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PAHOCampOperation Property PAHOCamps Auto
Quest Property NextQuest  Auto  
