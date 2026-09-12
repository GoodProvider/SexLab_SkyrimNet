scriptname TestGlobalHook extends sslThreadHook

bool function AnimationStarting(sslThreadModel Thread)

	Debug.MessageBox("AnimationStarting - "+Thread)
	Debug.TRACE("AnimationStarting - "+Thread)
	SexLabConfig.Log(Thread+" TEST GLOBAL HOOK - AnimationStarting")
	; Utility.Wait(5.0)

	return true
endFunction

bool function AnimationPrepare(sslThreadController Thread)

	Debug.MessageBox("AnimationPrepare - "+Thread)
	Debug.TRACE("AnimationPrepare - "+Thread)
	SexLabConfig.Log(Thread+" TEST GLOBAL HOOK - AnimationPrepare")
	; Utility.Wait(5.0)

	return true
endFunction