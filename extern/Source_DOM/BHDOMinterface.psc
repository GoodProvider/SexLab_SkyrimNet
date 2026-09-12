Scriptname BHDOMinterface extends Quest  

DOM_Core Property DOM01 Auto


Function ActorOnDuty(Actor Guest, string duty_msg, string duty_title)
	if DOM01 == None
		return
	endif
	DOM_Actor akActor = DOM01.GetActor(Guest) 
	if akActor == None
		return
	endif
	akActor.EnterOnDuty(duty_msg,duty_title)
EndFunction

Function ActorOffDuty(Actor Guest)
	if DOM01 == None
		return
	endif
	DOM_Actor akActor = DOM01.GetActor(Guest) 
	if akActor == None
		return
	endif
	akActor.ExitOnDuty()
EndFunction

Function MoveDarkIn(Actor Guest) 
	if !Guest.IsInFaction(DOM01.DOMActorFaction)
		return
	endif
	int actorSex  = Guest.GetLeveledActorBase().GetSex()
	string duty_title
	if (actorSex % 2) == 0
		duty_title = "Dark area Master"
	else
		duty_title = "Dark area Mistress"
	endif
	ActorOnDuty(Guest,"is moving to the dark area",duty_title)	  
EndFunction

Function MoveJailIn(Actor Guest) 
	if !Guest.IsInFaction(DOM01.DOMActorFaction)
		return
	endif
	ActorOnDuty(Guest,"is being sent to jail","Valley prisoner")
EndFunction

Function MoveGuardIn(Actor Guard, int guardpos)
	if !Guard.IsInFaction(DOM01.DOMActorFaction)
		return
	endif
	string msg
	string title
	if guardpos == 1
		msg = "is the new entrance guard"
		title = "Valley entrance guard"
	elseif guardpos == 2
		msg = "is the new entrance guard backup"
		title = "Valley night guard"
	elseif guardpos == 3
		msg = "is the new bedroom guard"
		title = "Valley bedroom guard"
	elseif guardpos == 4
		msg = "is the new patrol guard"
		title = "Valley patrol guard"
	endif
	ActorOnDuty(Guard,msg,title)
EndFunction


Function MoveOccupantIn(Actor Guest, int guestpos)
	if !Guest.IsInFaction(DOM01.DOMActorFaction)
		return
	endif
	string msg
	string title
	if guestpos == 1
		msg = "is a new guest in the Valley"
		if Guest.IsInFaction(DOM01.DOMPlayerSlaveFaction)
			title = "Valley slave"
		else
			title = "Valley resident"
		endif
	elseif guestpos == 2
		msg = "will stay in the Valley"
		if Guest.IsInFaction(DOM01.DOMPlayerSlaveFaction)
			title = "Valley slave"
		else
			title = "Valley resident"
		endif
	elseif guestpos == 3
		msg = "is the new merchant"
		title = "Valley merchant"
	elseif guestpos == 4
		msg = "is the new bard"
		title = "Valley bard"
	elseif guestpos == 5
		int actorSex  = Guest.GetLeveledActorBase().GetSex()
		if (actorSex % 2) == 0
			msg   = "is the new working guy"
			title = "Valley working guy"
		else
			msg   = "is the new working girl"
			title = "Valley working girl"
		endif
	endif
	ActorOnDuty(Guest,msg,title)
EndFunction
