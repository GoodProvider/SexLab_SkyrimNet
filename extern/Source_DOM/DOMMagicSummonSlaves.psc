Scriptname DOMMagicSummonSlaves extends activemagiceffect  

DOM_Core Property DOM01 Auto
bool Property only_fighters Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akCaster == None
		akCaster = Game.GetPlayer()
	endif
	DOM01.SummonSlaves(akCaster,only_fighters)
EndEvent
