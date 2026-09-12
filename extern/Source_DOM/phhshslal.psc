Scriptname phhshSLAL extends Quest  

bool Property phhshUseSLAL = true Auto Hidden
; SLAL Functions

bool Function HasSlal()
	If Game.GetModByName("SexLabAroused.esm") != 255 ; 
		return true
	endif
	return false
EndFunction

Function UnlockScan(int myLockNum)
	slaMainScr pslaMainScr = Game.GetFormFromFile(0x00042d62, "SexLabAroused.esm") as slaMainScr 
	if (pslaMainScr != None)
		pslaMainScr.UnlockScan(myLockNum) 
	endif
EndFunction

bool Function GetActors(int myLockNum, float  c)
	if !phhshUseSLAL
		actorsNumber = 0
		return true
	endif
	if !HasSlal()
		actorsNumber = 0
		return true
	endif
	slaMainScr pslaMainScr = Game.GetFormFromFile(0x00042d62, "SexLabAroused.esm") as slaMainScr 
	if (pslaMainScr != None)
		Actor[] myActors = pslaMainScr.getLoadedActors(myLockNum)

		;if (!actorList )
		;	actorList = new Actor[20]
		;endif

		int i = 0;     ;Copy the actors to a private array  
		int n = actorList.length
		while i < c && i < n
			actorList [i] = myActors[i]
            i+= 1
		endwhile
		actorsNumber = i
		return true 
	else
		Debug.Notification("HSH: SL Aroused main quest not found!")
		return false
	endif
EndFunction

int Function GetActorArousal(actor a)
	if !phhshUseSLAL
		return 0
	endif
	if !HasSlal()
		return 0
	endif
	slaFrameworkScr pslaMainScr = Game.GetFormFromFile(0x0004290f, "SexLabAroused.esm") as slaFrameworkScr 
	if (pslaMainScr != None)
		return pslaMainScr.GetActorArousal(a)
	else
		return 0
	endif
EndFunction

;slaMainScr Property pslaMainScr Auto
int Property actorsNumber = 0 Auto Hidden
Actor[] _actorList
Actor[] Property actorList
	Actor[] Function Get()
		if !_actorList
			_actorList = new Actor[20] ; 
			actorsNumber = 0
		endif
		return _actorList
	EndFunction
EndProperty
