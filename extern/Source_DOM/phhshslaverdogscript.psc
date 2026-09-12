Scriptname phhshSlaverDogScript extends Quest  

Function BuyDog (int amount)
	Game.GetPlayer().RemoveItem(gold, amount, false)
	SlaverDogRef.GetActorRef().SetFactionRank(SlaverDogFaction, 1)
	SlaverDogRef.GetActorRef().AllowPCDialogue(true)
	Game.GetPlayer().AddSpell(WhistleSpell)
EndFunction

Function CommandStay()
	SlaverDogRef.GetActorRef().SetFactionRank(SlaverDogFaction, 1)
EndFunction

Function CommandFollow()
	SlaverDogRef.GetActorRef().SetFactionRank(SlaverDogFaction, 2)
EndFunction

Function CommandChase()
	SlaverDogRef.GetActorRef().SetFactionRank(SlaverDogFaction, 3)
EndFunction

Function DogWhistle(Actor target)
	; Count nr of times whistle is blown in succession
	float t = Utility.GetCurrentRealTime()
	if (t - WhistleTime >= 1)
		WhistleCount = 1
		SlaverDogTargetRef.Clear()
	else
		WhistleCount += 1
	endif
	WhistleTime = t
	UnregisterForUpdate()
	RegisterForSingleUpdate(2)

	if (target != None)
		SlaverDogTargetRef.ForceRefTo(target)
	endif
EndFunction

Event OnUpdate()
	if (WhistleCount == 1)
		debug.notification("Hunter is following")
		CommandFollow()
	elseif (WhistleCount == 2)
		if (SlaverDogTargetRef.GetActorRef() != None)
			debug.notification("Hunter is chasing " + SlaverDogTargetRef.GetActorRef().GetDisplayName())
			CommandChase()
		else
			debug.notification("Point at someone when whistling to give chase")
		endif
	elseif (WhistleCount == 3)	
		debug.notification("Hunter is staying put")
		CommandStay()
	endif
EndEvent

ReferenceAlias Property SlaverDogRef Auto
ReferenceAlias Property SlaverDogTargetRef Auto
Faction Property SlaverDogFaction Auto
MiscObject Property Gold Auto
Spell Property WhistleSpell Auto

int Property WhistleCount Auto Hidden
float Property WhistleTime Auto Hidden