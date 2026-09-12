Scriptname DOMMagicSummonRunners extends activemagiceffect  


DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akCaster == None
		akCaster = Game.GetPlayer()
	endif
	DOM01.SummonRunnerSlaves(akCaster)
EndEvent
