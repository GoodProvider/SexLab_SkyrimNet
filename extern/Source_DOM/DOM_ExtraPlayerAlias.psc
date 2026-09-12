Scriptname DOM_ExtraPlayerAlias extends ReferenceAlias  

DOM_Extra Property DOM02Extra Auto

Event OnPlayerLoadGame()
	Debug.Trace("DOM_ExtraPlayerAlias: OnPlayerLoadGame "+DOM02Extra)
	DOM02Extra.OnPlayerLoadGame()
EndEvent
