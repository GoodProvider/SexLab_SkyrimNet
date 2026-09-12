Scriptname aygasEventDetectorScript extends Quest  

Function ClearSlaveRefs()
	int n = SlaveRefs.length
	int i = 0
	while i < n
		SlaveRefs[i].Clear()
		i += 1
	endwhile
EndFunction

Function ClearSpectatorRefs()
	int n = SpectatorRefs.length
	int i = 0
	while i < n
		SpectatorRefs[i].Clear()
		i += 1
	endwhile
EndFunction

Function Detect()
	ClearSlaveRefs()
	ClearSpectatorRefs()

	Stop()
	Start()
	Utility.Wait(5.0)
EndFunction

ReferenceAlias[] Property SlaveRefs Auto
ReferenceAlias[] Property SpectatorRefs Auto
