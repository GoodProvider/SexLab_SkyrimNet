Scriptname phhshSS extends Quest  

bool Function HasSS()
	bool ok = false
	if (Game.GetModByname("SerialStrip.esp") != 255)
		ok = (Game.GetFormFromFile(0x00000d62, "SerialStrip.esp") != None)
	endif
	return ok
EndFunction

Function StartStrip(Quest caller, Actor slave, bool stripAll)
;	(Game.GetFormFromFile(0x00000d62, "SerialStrip.esp") as SerialStripFunctions).SendSerialStripStartEvent(caller, slave, stripAll)	
EndFunction