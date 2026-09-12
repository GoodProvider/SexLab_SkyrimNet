;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname DOMRecruitThugPerk Extends Perk Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMRecruit(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_SlaverManager Property DOM01 Auto
DOM_Core Property DOMCore Auto
Faction Property DOMPotentialSlaverFaction Auto

Function DOMRecruit(ObjectReference akTarget)
	Actor akActor = akTarget as Actor
	DOMCore.DOMGenerator.GetNPCTraitsUpdateModifiers(akActor) ; Needs to update modifiers to get potential slaver status
	int rank = akActor.getFactionRank(DOMPotentialSlaverFaction)
	if rank > 0
		Debug.Notification(akActor.GetDisplayName()+" will gladly join you as a slaver.")
		DOM01.Recruit(akActor)
	else
		Debug.Notification(akActor.GetDisplayName()+" would rather die than join you.")
	endif
EndFunction


