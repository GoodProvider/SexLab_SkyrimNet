Scriptname DOMBookNecromancersOath extends ObjectReference  

DOM_Core Property DOM01 Auto
Actor Property PlayerRef Auto
Message Property DOMTakeOathMessage Auto

Event OnRead()
	int my_answer = DOMTakeOathMessage.Show()
	if my_answer > 0
		Book the_book = (self.GetBaseObject()) as Book
		if the_book != None
			PO3_SKSEFunctions.ClearReadFlag(the_book)
		endif
		return
	endif
	PlayerRef.SetFactionRank(DOM01.NecromancerFaction,1)
	PlayerRef.SetFactionRank(DOM01.DraugrAllyFaction,1)
EndEvent
