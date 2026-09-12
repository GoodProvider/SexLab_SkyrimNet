;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 29
Scriptname QF_PAHOCatchMoreCriminals_06019FFC Extends Quest Hidden

;BEGIN ALIAS Property Mona
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Mona Auto
;END ALIAS Property

;BEGIN ALIAS Property Slaver1
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Slaver1 Auto
;END ALIAS Property

;BEGIN ALIAS Property GuardStonehills
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardStonehills Auto
;END ALIAS Property

;BEGIN ALIAS Property Slaver2
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Slaver2 Auto
;END ALIAS Property

;BEGIN ALIAS Property Merian
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Merian Auto
;END ALIAS Property

;BEGIN ALIAS Property JarlInform
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_JarlInform Auto
;END ALIAS Property

;BEGIN ALIAS Property StonehillsMarker
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_StonehillsMarker Auto
;END ALIAS Property

;BEGIN ALIAS Property GuardDawnstar
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardDawnstar Auto
;END ALIAS Property

;BEGIN ALIAS Property GuardKarthwarsten
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardKarthwarsten Auto
;END ALIAS Property

;BEGIN ALIAS Property DawnstarDockMarker
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_DawnstarDockMarker Auto
;END ALIAS Property

;BEGIN ALIAS Property TransferSlot
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_TransferSlot Auto
;END ALIAS Property

;BEGIN ALIAS Property Padrin
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Padrin Auto
;END ALIAS Property

;BEGIN ALIAS Property Slaver3
;ALIAS Property TYPE ReferenceAlias
ReferenceAlias Property Alias_Slaver3 Auto
;END ALIAS Property

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveCompleted(65)
SetObjectiveDisplayed(80)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
SetObjectiveCompleted(65)
SetObjectiveDisplayed(90)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
setObjectiveDisplayed(30)
SetObjectiveDisplayed(31)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
;SetObjectiveDisplayed(50)
SetObjectiveDisplayed(51)
SetObjectiveDisplayed(31, false)
SetObjectiveCompleted(40)
qstScript.SpawnSlaverCamp()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SetObjectiveDisplayed(81)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveCompleted(31)
SetObjectiveDisplayed(60)
qstScript.SpawnSlaverCamp()
(Alias_Padrin.GetRef() as Actor).Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveDisplayed(61)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
Actor merian = Alias_Merian.GetRef() as Actor
merian.Enable()
merian.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
SetObjectiveCompleted(65)
SetObjectiveDisplayed(69)
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

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
SetObjectiveCompleted(69)
SetObjectiveDisplayed(70)
(Alias_Padrin.GetRef() as Actor).Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
QstScript.Pardo.AddToFaction(QstScript.PHHSH.PAHHunterVendorFaction)
NextQst.SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SetObjectiveDisplayed(40)
SetObjectiveDisplayed(31, false)
SetObjectiveCompleted(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SetObjectiveDisplayed(65)
Actor mona = Alias_Mona.GetRef() as Actor
mona.SetRestrained(false)
mona.Evaluatepackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property NrOfPrisoners  Auto  

PAHOCatchMoreCriminals Property qstScript  Auto  

Quest Property nextQst  Auto  
