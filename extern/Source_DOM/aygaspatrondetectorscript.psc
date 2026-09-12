Scriptname aygasPatronDetectorScript extends Quest  


Function Detect()
	; Remember patrons already detected (in the previous zone)
	Actor[] PrevMales   = new Actor[16]
	Actor[] PrevFemales = new Actor[16]
	int np = PrevMales.length
	int nr = PatronRefsM.length
	int i = 0
	while i < nr && i < np
		PrevMales[i]   = PatronRefsM[i].GetActorRef()
		PrevFemales[i] = PatronRefsF[i].GetActorRef()
		i += 1
	endwhile

	Utility.Wait(1.0)
	BrothelMarker.MoveTo(Game.GetPlayer())

	; Run detector
	i = 0
	while i < nr
		PatronRefsM[i].Clear()
		PatronRefsF[i].Clear()
		i += 1
	endwhile
	
	int nc = CourtesanRefs.length
	i = 0
	while i < nc
		CourtesanRefs[i].Clear()
		i += 1
	endwhile
	Stop()
	Start()
	Utility.Wait(3.0)

	; Store patrons already detected (in the previous zone)
	int nm = Aygas.Scenes.BrothelPatronCandidatesM.length
	i = 0
	while i < nm && i < np
		if PrevMales[i] != None
			Aygas.Scenes.BrothelPatronCandidatesM[i] = PrevMales[i]
		endif
		if PrevFemales[i] != None
			Aygas.Scenes.BrothelPatronCandidatesF[i] = PrevFemales[i]
		endif
		i += 1
	endwhile

	if !Aygas.IsPlayerHouse() ; not player house 	
		return ; Clearing brothel is handled by Scenes script
	endif
	if CourtesanRefs[0].GetRef() == None ; no courtesan
		return
	endif
	
	int npatrons = 2 ; Work out how many patrons to spawn
	i = 1
	while i < nc
		if CourtesanRefs[i].GetRef() != None
			npatrons += 1
		endif
		i += 1
	endwhile

	patronM = 0		; Counts how many of each patron we assigned
	patronF = 0

	Aygas.DebugMessage("Start brothel with " + npatrons + " patrons")

	; Handle payments to Taskmaster, if any
	utility.wait(3.0)		; Give slotted courtesans time to process payments
	Actor taskmaster = Aygas.HSH.TaskmasterInCell(Game.GetPlayer().GetParentCell())
	if ((taskmaster != None) && (Aygas.HSHHasAygasFunds != None))
		Aygas.DebugMessage("Start brothel collection")
		int amount = 0
		i = 0
		while i < nc
			Actor akCourtesan = CourtesanRefs[i].GetActorRef()
			if akCourtesan != None
				amount += Aygas.WorkFunctions.JobCollectSilently(akCourtesan)
			endif
			i += 1
		endwhile
		if (amount > 0)
			taskmaster.SetFactionRank(Aygas.HSHHasAygasFunds, 1)		; For future, faction rank could indicate for what job this money was collected
			amount += StorageUtil.GetIntValue(taskmaster, "aygasMoney")
			StorageUtil.SetIntValue(taskmaster, "aygasMoney", amount)
		endif
		Aygas.DebugMessage("End brothel collection, got "+ amount)
	endif

	int nb = Aygas.Scenes.BrothelPatrons.length

	Actor candidate = PatronBasedOnSexPreferences(Aygas.Scenes.BrothelPatronCandidatesM[0], Aygas.Scenes.BrothelPatronCandidatesF[0], CourtesanRefs[0].GetActorRef())
	SlotpatronCandidate(candidate, Aygas.Scenes.BrothelPatrons[0])
	i = 1
	while i < nm && i < nb && i < nc
		if CourtesanRefs[i].GetRef() != None
			candidate = PatronBasedOnSexPreferences(Aygas.Scenes.BrothelPatronCandidatesM[i], Aygas.Scenes.BrothelPatronCandidatesF[i], CourtesanRefs[i].GetActorRef())
		else
			candidate = PatronBasedOnSexPreferences(Aygas.Scenes.BrothelPatronCandidatesM[i], Aygas.Scenes.BrothelPatronCandidatesF[i], CourtesanRefs[i-(1)].GetActorRef())
		endif
		SlotpatronCandidate(candidate, Aygas.Scenes.BrothelPatrons[i])
		if npatrons <= i + 1 ; stop loop
			i = nm+nb+nc
		endif
		i += 1
	endwhile
EndFunction

Actor Function PatronBasedOnSexPreferences(Actor maleCandidate, Actor femaleCandidate, Actor courtesan)
	bool isMale
	if (courtesan != None)
		isMale = (Aygas.SexLab.GetGender(courtesan) == 1)
	else
		isMale = (Utility.RandomInt(1, 2) == 1)
	endif

	if ((Aygas.SGaySex == 1) && (Utility.RandomInt(1, 5) == 1))
		isMale = !isMale
	elseif ((Aygas.SGaySex == 2) && (Utility.RandomInt(1, 2) == 1))
		isMale = !isMale
	endif

	if ((isMale) && (maleCandidate != None))
		return maleCandidate
	else
		return femaleCandidate
	endif
EndFunction

Function SlotPatronCandidate(Actor candidate, ReferenceAlias slot)
	if (candidate != None)
		UnslotSlavesForOwner(candidate)	; Ensure the owner doesn't bring their own slaves
		slot.ForceRefTo(candidate)
		candidate.EvaluatePackage()
		candidate.MoveTo(BrothelMarker)
		utility.wait(1)
	else
		slot.Clear()
	endif
EndFunction

Function UnslotSlavesForOwner(Actor owner)
	int i = StorageUtil.FormListCount(owner, "aygasSlaves")
	while(i > 0)
		i-=1
		Actor slave = StorageUtil.FormListGet(owner, "aygasSlaves", i) as Actor
		if (slave != None)
			aygasSlaveScript slaveSlot = aygas.SlaveSlot(slave) as aygasSlaveScript 
			if (slaveSlot != None)
				slaveSlot.BeforeSuspend() 
				slave.SetFactionRank(aygas.UnslottedFaction, 1)	
				slaveSlot.Clear()
			endif
		endif
	endwhile
EndFunction



Function DetectCourtesans()
	int nc = CourtesanRefs.length
	int i = 0
	while i < nc
		CourtesanRefs[i].Clear() 
		i += 1
	endwhile
	Stop()
	Start()
	Utility.Wait(5.0)
EndFunction

Actor Function FindAvailableCourtesan()
	DetectCourtesans()
	Actor[] a = new Actor[16]
	int na = a.length
	int nc = CourtesanRefs.length
	int j = 0
	int i = 0
	while i < nc && i < na
		Actor akCourtesan = CourtesanRefs[i].GetActorRef()
		if (Aygas.JobSlaveAvailable(akCourtesan, false))
			a[j] = akCourtesan
			j += 1
		endif
		i += 1
	endwhile

	if (j == 0)
		Aygas.DebugMessage("No courtesan available ")
		return None
	else
		int s = Utility.RandomInt(1, j) - 1
		Aygas.DebugMessage("Found courtesan " + s + "/" + j + ": " + a[s].GetDisplayName())
		return a[s]
	endif
EndFunction

int Property patronM Auto Hidden		; Counts how many of each patron we assigned
int Property PatronF Auto Hidden

ReferenceAlias[] Property PatronRefsM Auto
ReferenceAlias[] Property PatronRefsF Auto
ReferenceAlias[] Property CourtesanRefs Auto

ObjectReference Property BrothelMarker Auto

AygasCoreScript Property Aygas Auto