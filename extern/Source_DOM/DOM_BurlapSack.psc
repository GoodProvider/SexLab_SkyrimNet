Scriptname DOM_BurlapSack extends ObjectReference  

Armor Property DOMBurlapSack Auto
Actor victim = None
string behaviour = ""
ObjectReference myContainer = None

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	myContainer = akNewContainer
	if akNewContainer == None
		; object was dropped
		return
	endif
	
	; Check to see if new container is an actor
	Actor the_actor = akNewContainer as Actor
	if the_actor != None
		Form item_already_in_slot = the_actor.GetWornForm(DOMBurlapSack.GetSlotMask())
		if item_already_in_slot == None ; Check if such an item is already equipped
			the_actor.EquipItem(DOMBurlapSack, False, True)
		endif
	endif
EndEvent

ObjectReference Function GetContainer()
	return myContainer
EndFunction

Function SetVictim(Actor akRef)
	if akRef != None
		Debug.trace("DOM_BurlapSack: "+getDisplayName()+" set victim="+akRef.GetDisplayName())
	else
		Debug.trace("DOM_BurlapSack: "+getDisplayName()+"set victim=NONE")
	endif
	victim = akRef
EndFunction

Actor Function GetVictim()
	;Debug.trace("DOM_BurlapSack: "+getDisplayName()+"get victim="+victim.GetDisplayName())
	return victim
EndFunction

Function SetBehaviour(string beh)
	;Debug.trace("DOM_BurlapSack: "+getDisplayName()+"set behaviour="+beh)
	behaviour = beh
EndFunction

string Function GetBehaviour()
	;Debug.trace("DOM_BurlapSack: "+getDisplayName()+"get behaviour="+behaviour)
	return behaviour
EndFunction
