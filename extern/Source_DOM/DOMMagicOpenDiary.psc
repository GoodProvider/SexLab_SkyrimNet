Scriptname DOMMagicOpenDiary extends activemagiceffect  

DOM_Core Property DOM01 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("DOMMagicOpenDiary OnEffectStart target="+akTarget+" caster="+akCaster)
	if akTarget == None || akCaster == None
		DOM01. DOMOpenPlayerDiary()
		return
	endif
	DOM01.DOMOpenDiary(akTarget)
EndEvent