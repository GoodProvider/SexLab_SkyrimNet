Scriptname	_JSW_SUB_ActorUpdates	extends	Quest

_JSW_BB_Storage		Property	Storage				Auto		;	Storage data helper

;AssociationType		Property	assocSpouse			Auto		;	added for findsexpartner check
;AssociationType		Property	assocCourting		Auto		;	added for findsexpartner check
AssociationType[]	Property	assocTypes			Auto		; 0 - placeholder/none, 1 - spouse, 2 - courting

; 2.26
Alias				Property	GV_Alias			Auto		; 

_JSW_SUB_GVAlias	GVAliasSC

int	lastRelationshipChecked

function AUUnregister()
	UnRegisterForAllModEvents()
endFunction

bool function RunAtGoFunction()
{called by ScriptStarter onplayerloadgame}
	RegisterForModEvent("FMPatchIncActorUpdate", "IncrementalStatusUpdate")
	if (GVAliasSC == none) || !GVAliasSC.ImHere()
		GVAliasSC = (GV_Alias as referenceAlias) as _JSW_SUB_GVAlias
	endIf
	return true
endFunction

event IncrementalStatusUpdate(int howMany = 8)
{update "x" actors and fathers each time player changes location}
	UnregisterForModEvent("FMPatchIncActorUpdate")
	int	startIndex	=	Storage.FMValues[15]
	int	arrayLength	=	Math.LogicalAND(Storage.TrackedFathers.Length, 0xFFF)
	if (startIndex < 0) || (arrayLength && (startIndex >= arrayLength))
		startIndex = 0
	endIf
	; 2.54 check for zero-length array
	if arrayLength
		GoToState("Males")
		CheckDeadActors(startIndex, howMany)
		UpdateRelationships(howMany)
	endIf

	startIndex	=	Storage.FMValues[14]
	arrayLength	=	Math.LogicalAND(Storage.TrackedActors.Length, 0xFFF)
	if (startIndex < 0) || (arrayLength && (startIndex >= arrayLength))
		startIndex = 0
	endIf
	; 2.54 check for zero-length arrays
	if arrayLength
		GoToState("")
		CheckDeadActors(startIndex, howMany)
		UpdateRelationships(howMany)
	endIf

	RegisterForModEvent("FMPatchIncActorUpdate", "IncrementalStatusUpdate")
endEvent

function CheckDeadActors(int startIndex, int howMany)
{checks if they're alive, or not}
	form		where		=	none
	actor		thisActor	=	none
	form		parentLoc	=	none
	int			anInt
	location	oldWhere	=	none
	int			theCount
	while (theCount < howMany)
		thisActor = Storage.TrackedActors[startIndex] as actor
		if !thisActor || ((Storage.ActorBlackList.Find(thisActor as form) != -1) || !(thisActor as objectReference).GetDisplayName() || thisActor.IsDead())
			Storage.TrackedActorRemove(startIndex, false)
		else
			where = thisActor.GetCurrentLocation() as form
			if where
				oldWhere = Storage.ActorLocation[startIndex] as location
				if oldWhere && ((oldWhere as form) != where) && ((GVAliasSC.HabitationLocs.Find(where) == -1) || (GVAliasSC.ChildLocs.Find(where) == -1))
					GVAliasSC.UpdateLocationMap(oldWhere, where as location)
					oldwhere = none
				endIf
				if (GVAliasSC.HabitationLocs.Find(where) != -1)
					parentLoc = where
				else
					anInt = GVAliasSC.ChildLocs.Find(where)
					if anInt != -1
						parentLoc = GVAliasSC.HabitationLocs[anInt]
					endIf
				endIf
			endIf
			Storage.ActorLocation[startIndex] = where
			Storage.ActorLocParent[startIndex] = parentLoc
			where = none
			parentLoc = none
			thisActor = none
		endIf
		startIndex += 1
		if startIndex >= Storage.TrackedActors.Length
			startIndex = 0	; 2.61
;			startIndex -= Storage.TrackedActors.Length
		endIf
		theCount += 1
	endWhile
	Storage.FMValues[14] = (startIndex - 1)
endFunction

function UpdateRelationships(int howMany)
	{updates relationship records for the selected set of actors}
	actor	thisActor	=	none
	actor	thatActor	=	none
	int		hasLover	=	0
	int		thatIndex	=	0
	int		theCount	=	0
	int		updates	
	while (theCount < (Storage.TrackedActors.Length + 1)) && (updates < howMany)
		thisActor = Storage.TrackedActors[lastRelationshipChecked] as actor
		if thisActor && (Storage.FemHasLoveInterest[lastRelationshipChecked] == none)
			if (Storage.FemAttached[lastRelationshipChecked] == -1)
				if Storage.ATFlags[lastRelationshipChecked] == -1
					hasLover = 0
				elseIf thisActor.HasAssociation(assocTypes[1])
					hasLover = 1
				elseIf thisActor.HasAssociation(assocTypes[2])
					hasLover = 2
				else
					hasLover = 0
				endIf
				Storage.FemAttached[lastRelationshipChecked] = hasLover
			else
				hasLover = Storage.FemAttached[lastRelationshipChecked]
			endIf
;			debug.trace("FM+: " + thisActor.GetDisplayName() + " has AT: " + hasLover)
			if (hasLover == 0)
				Storage.FemHasLoveInterest[lastRelationshipChecked] = none
				Storage.Fidelity[lastRelationshipChecked] = 0
			else
				updates += 1
				thatActor = Storage.FemHasLoveInterest[lastRelationshipChecked] as actor
				if thatActor && !thisActor.HasAssociation(assocTypes[hasLover], thatActor)
					thatActor = none
				endIf
				if !thatActor
;					debug.trace("FM+: trying to find SO for: " + thisActor.GetDisplayName())
					thatIndex = Storage.TrackedFathers.Length
					while thatIndex > 0
						thatIndex -= 1
						thatActor = Storage.TrackedFathers[thatIndex] as actor
						if thatActor && (Storage.MaleAttached[thatIndex] == hasLover)
							if thisActor.HasAssociation(assocTypes[hasLover], thatActor)
								UpdateAssociation(thisActor, thatActor, hasLover, lastRelationshipChecked, thatIndex)
								thatIndex = 0
							endIf
							thatActor = none
						endIf
					endWhile
				endIf
			endIf
		endIf
		lastRelationshipChecked += 1
		if lastRelationshipChecked >= Storage.TrackedActors.Length
			lastRelationshipChecked = 0	; 2.61
;			startIndex -= Storage.TrackedActors.Length
		endIf
		theCount += 1
	endWhile
;	Storage.FMValues[14] = (startIndex - 1)
endFunction

function	UpdateAssociation(actor thisActor, actor thatActor, int hasLover, int startIndex, int thatIndex)
{hasLover == 0 for none, hasLover == 1 for spouses, == 2 for courting}
	Storage.FemHasLoveInterest[startIndex] = thatActor as form
;	Storage.MaleAttached[thatIndex] = hasLover
;	Storage.MaleHasLoveInterest[thatIndex] = thisActor as form
	int modifier = thisActor.GetRelationshipRank(thatActor)
	if (modifier > 0)
		Storage.Fidelity[startIndex] = (modifier as float * 2.5) as int
	else
		Storage.Fidelity[startIndex] = (modifier * 10)
	endIf
	string theString = " spouse of "
	if hasLover == 2
		theString = " GF of "
	endIf
	debug.trace("FM+ info: " + thisActor.GetDisplayName() + theString + thatActor.GetDisplayName())
endFunction

state Males
	function CheckDeadActors(int startIndex, int howMany)
	{checks if they're alive, or not}
		form		where		=	none
		actor		thisActor	=	none
		form		parentLoc	=	none
		int			anInt
		location	oldWhere	=	none
		int 		theCount
		while (theCount < howMany)
			thisActor = Storage.TrackedFathers[startIndex] as actor
			if !thisActor || ((Storage.ActorBlackList.Find(thisActor as form) != -1) || !(thisActor as objectReference).GetDisplayName() || thisActor.IsDead())
				Storage.TrackedFatherRemove(startIndex, false)
			else
				where = thisActor.GetCurrentLocation() as form
				if where
					oldWhere = Storage.FatherLocation[startIndex] as location
					if oldWhere && ((oldWhere as form) != where) && ((GVAliasSC.HabitationLocs.Find(where) == -1) || (GVAliasSC.ChildLocs.Find(where) == -1))
						GVAliasSC.UpdateLocationMap(oldWhere, where as location)
						oldwhere = none
					endIf
					if (GVAliasSC.HabitationLocs.Find(where) != -1)
						parentLoc = where
					else
						anInt = GVAliasSC.ChildLocs.Find(where)
						if anInt != -1
							parentLoc = GVAliasSC.HabitationLocs[anInt]
						endIf
					endIf
				endIf
				Storage.FatherLocation[startIndex] = where
				Storage.FatherLocParent[startIndex] = parentLoc
				where = none
				parentLoc = none
				thisActor = none
			endIf
			startIndex += 1
			if startIndex >= Storage.TrackedFathers.Length
				startIndex = 0	; 2.61
;				startIndex -= Storage.TrackedFathers.Length
			endIf
			theCount += 1
		endWhile
		; 2.61
		Storage.FMValues[15] = (startIndex - 1)
	endFunction

	function UpdateRelationships(int howMany)
	{updates relationship records for the selected set of actors}
		int 	hasLover
		int		theCount = 0
		int		index		=	Storage.MaleAttached.Find(-1)
		actor	thisActor
		while (index != -1) && (theCount < howMany) && (index < Storage.ATFlagsMale.length)
			thisActor = Storage.TrackedFathers[index] as actor
			if thisActor
				hasLover = 0
				if Storage.ATFlagsMale[index] == -1
;					hasLover = 0
				elseIf thisActor.HasAssociation(assocTypes[1])
					hasLover = 1
				elseIf thisActor.HasAssociation(assocTypes[2])
					hasLover = 2
;				else
;					hasLover = 0
				endIf
;				debug.trace("FM+: updated relationship info for " + thisActor.GetDisplayName() + " " + hasLover + " " + (thisActor as form))
				Storage.MaleAttached[index] = hasLover
;			else
;				hasLover = Storage.MaleAttached[index]
			endIf
;/			if thisActor && (Storage.ATFlagsMale[index] != -1)
				if thisActor.HasAssociation(assocTypes[1])
					hasLover = 1
				elseIf thisActor.HasAssociation(assocTypes[2])
					hasLover = 2
				endIf
			endIf/;
;			Storage.MaleAttached[index] = hasLover
			index = Storage.MaleAttached.RFind(-1)
			theCount += 1
		endWhile
	endFunction

;/	function UpdateRelationships(int startIndex, int howMany)
	{updates relationship records for the selected set of actors}
		actor thisActor = none
		actor thatActor = none
		int hasLover = 0
		int thatIndex = 0
		int		theCount
		while (theCount < howMany)
			thisActor = Storage.TrackedFathers[startIndex] as actor
			if thisActor && (Storage.MaleHasLoveInterest[startIndex] == none)
				if (Storage.MaleAttached[startIndex] == -1)
					if Storage.ATFlagsMale[startIndex] == -1
						hasLover = 0
					elseIf thisActor.HasAssociation(assocTypes[1])
						hasLover = 1
					elseIf thisActor.HasAssociation(assocTypes[2])
						hasLover = 2
					else
						hasLover = 0
					endIf
					Storage.MaleAttached[startIndex] = hasLover
				else
					hasLover = Storage.MaleAttached[startIndex]
				endIf
;				debug.trace("FM+: " + thisActor.GetDisplayName() + " has AT: " + hasLover)
				if (hasLover == 0)
					Storage.MaleHasLoveInterest[startIndex] = none
				else
					thatActor = Storage.MaleHasLoveInterest[startIndex] as actor
					if thatActor && !thisActor.HasAssociation(assocTypes[hasLover], thatActor)
						thatActor = none
					endIf
					if !thatActor
						thatIndex = Storage.TrackedActors.Length
						while thatIndex > 0
							thatIndex -= 1
							thatActor = Storage.TrackedActors[thatIndex] as actor
							if thatActor && (Storage.FemAttached[thatIndex] == hasLover)
								if thisActor.HasAssociation(assocTypes[hasLover], thatActor)
									UpdateAssociation(thisActor, thatActor, hasLover, startIndex, thatIndex)
									thatIndex = 0
								endIf
								thatActor = none
							endIf
						endWhile
					endIf
				endIf
			endIf
			startIndex += 1
			if startIndex >= Storage.TrackedFathers.Length
				startIndex -= Storage.TrackedFathers.Length
			endIf
			theCount += 1
		endWhile
		Storage.FMValues[15] = (startIndex - 1)
	endFunction

	function	UpdateAssociation(actor thisActor, actor thatActor, int hasLover, int startIndex, int thatIndex)
	{hasLover == 0 for none, == 1 for spouses, == 2 for courting}
		Storage.MaleHasLoveInterest[startIndex] = thatActor as form
		Storage.FemAttached[thatIndex] = hasLover
		Storage.FemHasLoveInterest[thatIndex] = thisActor as form
		int modifier = thisActor.GetRelationshipRank(thatActor)
		if (modifier > 0)
			Storage.Fidelity[thatIndex] = (modifier as float * 2.5) as int
		else
			Storage.Fidelity[thatIndex] = (modifier * 10)
		endIf
		string theString = " spouse of "
		if hasLover == 2
			theString = " BF of "
		endIf
		debug.trace("FM+ info: " + thisActor.GetDisplayName() + theString + thatActor.GetDisplayName())
	endFunction/;
endState
