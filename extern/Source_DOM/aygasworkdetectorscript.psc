Scriptname aygasWorkDetectorScript extends Quest  

Function ClearProstituteRefs()
	int n = ProstituteRefs.length
	int i = 0
	while i < n
		ProstituteRefs[i].Clear()
		i += 1
	endwhile
EndFunction

Function SetProstituteActors()
	int n = ProstituteRefs.length
	int m = Prostitutes.length
	int i = 0
	while i < n && i < m
		Prostitutes[i] = ProstituteRefs[i].GetActorRef()
		i += 1
	endwhile
EndFunction

int Function CountProstitutes()
	int n = Prostitutes.length
	while n > 0
		n -= 1
		if Prostitutes[n] != None
			return n + 1
		endif
	endwhile
	return 0
EndFunction

Function Detect()
	ClearProstituteRefs()
	PotentialOwnerRef.Clear()
	
	Stop()
	Start()
	Utility.Wait(5.0)

	SetProstituteActors()
	PotentialOwner = PotentialOwnerRef.GetActorRef()

	Aygas.ProstitutesNearby = CountProstitutes()
	
	Aygas.DebugMessage("AYGAS Prostitutes nearby:" + Aygas.Prostitutesnearby)
EndFunction

Actor Function RandomProstitute()
	int n = CountProstitutes()
	if n < 2
		return Prostitutes[0]
	endif
	int i = Utility.RandomInt(1, n) - (1)
	return Prostitutes[i]
EndFunction

ReferenceAlias[] Property ProstituteRefs Auto
ReferenceAlias Property PotentialOwnerRef Auto
Actor[] __Prostitutes
Actor[] Property Prostitutes
	Actor[] Function Get()
		if !__Prostitutes
			__Prostitutes = new Actor[3]
		endif
		return __Prostitutes
	EndFunction
EndProperty
Actor Property PotentialOwner Auto Hidden

aygasCoreScript Property Aygas Auto