;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname DOMAbductionPerk Extends Perk Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMCapture(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_SlaveManager Property DOM02 Auto
Faction Property DOMBeingCaptured Auto
bool Property doAnim  Auto

Function DOMCapture(ObjectReference akTarget)
	Actor akActor = akTarget as Actor
	if akActor == None || akActor.IsChild()
		return
	endif
	if akActor.IsInFaction(DOMBeingCaptured)
		return
	endif	
	akActor.SetFactionRank(DOMBeingCaptured,2)
	DOM_Actor dactor = DOM02.Capture(akActor,"BleedOutStart")
	if dactor == None
		 akActor.RemoveFromFaction(DOMBeingCaptured)
		 return
	endif
	dactor.mind.TrainResignation(20.0)  ; Resignation boost for combat capture
EndFunction


