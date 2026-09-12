;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PF_PAHFSCJerrekToInspectLoc2_0300682B Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
;akActor.SetLookAt((GetOwningQuest() as QF_PAHFellglowSlaveCampQuest_030057E9).Alias_slave_up_for_sale.GetActorRef())
akActor.SetLookAt((GetOwningQuest() as PAHFellglowSlaveCampQuest).Alias_slave_up_for_sale.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
