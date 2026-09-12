;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 21
Scriptname DOMBodyBagPerk Extends Perk Hidden

;BEGIN FRAGMENT Fragment_18
Function Fragment_18(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMUnBagAndTieUpNPC(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
DOMUnBagNPC(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Keys Property DOMKeys Auto

Function DOMUnBagNPC(ObjectReference akTarget)
	DOM_BurlapSack objSack = akTarget as DOM_BurlapSack
	if objSack == None
		return
	endif
	DOMKeys.DOMDoTakeOutOfBag(Game.GetPlayer(), objSack, false, true)
EndFunction

Function DOMUnBagAndTieUpNPC(ObjectReference akTarget)
	DOM_BurlapSack objSack = akTarget as DOM_BurlapSack
	if objSack == None
		return
	endif
	DOMKeys.DOMDoTakeOutOfBag(Game.GetPlayer(), objSack, true, true)
EndFunction
