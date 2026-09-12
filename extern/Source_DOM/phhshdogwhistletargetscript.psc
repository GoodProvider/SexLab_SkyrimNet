Scriptname phhshDogWhistleTargetScript extends ObjectReference  

Event OnLoad()
	Actor akTarget = Game.GetCurrentCrosshairRef() As Actor
	if akTarget == None
		akTarget = Game.FindClosestActorFromRef(self, 100)
	endif
	qst.DogWhistle(akTarget)
	Disable()
	DeleteWhenAble()
EndEVent

phhshSlaverDogScript Property qst Auto