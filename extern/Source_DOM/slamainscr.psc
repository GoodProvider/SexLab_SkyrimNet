Scriptname slaMainScr extends Quest  

; sla
slaInternalScr Property slaUtil Auto
slaConfigScr Property slaConfig Auto
Spell Property slaCloakSpell Auto
Spell Property slaDesireSpell Auto
GlobalVariable Property slaNextTimePlayerNaked Auto
Quest Property slaScanAll Auto
Quest Property slaNakedNPC Auto
Keyword Property ArmorCuirass Auto
Keyword Property ClothingBody Auto
Faction Property slaNaked Auto
GlobalVariable Property sla_NextMaintenance  Auto  
GlobalVariable Property sla_AnimateFemales Auto
GlobalVariable Property sla_AnimateMales Auto
GlobalVariable Property sla_AnimationThreshhold Auto
GlobalVariable Property sla_UseLineOfSight Auto

Formlist Property sla_NakedArmorList Auto



Float Property updateFrequency = 120.00 Auto hidden ;Determines the frequency of scans

Float lastSexFinished = 0.00
bool bWasInitialized = false

; SexLab
SexLabFramework Property SexLab Auto

; vanilla
Actor Property PlayerRef Auto
GlobalVariable Property GameDaysPassed Auto

; callback functions
String slaStageStartStr = "OnStageStart"
String slaAnimationEndStr = "OnAnimationEnd"

; constants
float arousalSearchRadius = 2048.0

; variables
Int modVersion = 0;
Int previousPlayerArousal = 0;
Float lastNotificationTime = 0.0;
Actor crosshairRef = None
Bool wasPlayerRaped = False;
Keyword zadDeviousBelt = None

bool bIsLocked = false
bool bUseLOS = false
int [] lockingInts
bool bNakedOnly = true
bool bDisabled = false

int[] property ActorTypes auto hidden ; [0] = 43/kNPC [1] = 44/kLeveledCharacter [2] = 62/kCharacter


int function IsAnimatingFemales()
	return sla_AnimateFemales.getValue() as Int
endFunction

function SetIsAnimatingFemales(int newValue)
	sla_AnimateFemales.setValue(newValue)
endFunction

int function IsAnimatingMales()
	return sla_AnimateMales.getValue() as Int
endFunction

function SetIsAnimatingMales(int newValue)
	sla_AnimateMales.setValue(newValue)
endFunction

int function getAnimationThreshold()
	return sla_AnimationThreshhold.getValue() as Int
endFunction

function setAnimationThreshold(int newValue)
	sla_AnimationThreshhold.setValue(newValue)
endFunction


int function getUseLOS()
	return sla_UseLineOfSight.getValue() as Int
endFunction

int function getNakedOnly()
	return bNakedOnly as Int
endFunction

function setNakedOnly(int newValue)
	bNakedOnly = newValue as bool
endFunction

int function getDisabled()
	return bDisabled as Int
endFunction

function setDisabled(int newValue)
	bDisabled = newValue as bool
	;debug.trace("Changing disabled to  " + bDisabled)
endFunction

function setUseLOS(int newValue)
	sla_UseLineOfSight.setValue(newValue)
	bUseLOS = newValue as bool
endFunction


function setUpdateFrequency(Float newFreq)
	updateFrequency = newFreq
	debug.trace("Changed update Frequency to " + newFreq + ", was initialized " + bWasInitialized);
	if(bWasInitialized)
		UnregisterForUpdate()
		RegisterForSingleUpdate(updateFrequency)
	endif
endFunction 

Event OnInit()
;	Debug.Notification(Self.GetName() + " has started")
EndEvent

function setCleaningTime()
	float nextTime = GameDaysPassed.GetValue() + 10.0 
	sla_NextMaintenance.SetValue(nextTime)
endFunction


Function Maintenance()
	Debug.Trace(Self + ": starting maintenance... Update frequency " + updateFrequency)
	;Incase we have an update expected, get rid of it
	UnregisterForUpdate()
	gotostate("initializing")
	bWasInitialized = false
	lockingInts = new Int[5]
	int i = 0
	while(i < 5)
		lockingInts[i] = -1
		i = i + 1
	endwhile
	ActorTypes = new Int[3]
	ActorTypes[0] = 43
	ActorTypes[1] = 44
	ActorTypes[2] = 62
	
	bIsLocked = false
	lastSexFinished = 0.00
	bUseLOS = sla_UseLineOfSight.getValue() as bool
	RegisterForSingleUpdate(10)
	Debug.Trace(Self + ": registered for maintenance")
EndFunction

function startCleaning()
	debug.notification("Starting Cleaning in 5 Seconds")
	UnregisterForUpdate()
	gotostate("cleaning")
	RegisterForSingleUpdate(10)
endFunction

state cleaning
Event OnUpdate()
	gotoState("")
	CleanActorStorage()
	RegisterForSingleUpdate(updateFrequency)
endEvent
endState

state initializing
Event OnUpdate()

	
	debug.trace(self + ":Defered maintenance...")
	If (modVersion < 20140121)
		slaConfig.IsUseSOS = False
		slaConfig.slaPuppetActor = PlayerRef
		;slaConfig.TimeRateHalfLife = 2.0
		;slaConfig.SexOveruseEffect = 5
		
		slaUtil = Quest.GetQuest("sla_Internal") As slaInternalScr
		slaConfig.slaUtil = slaUtil
	EndIf
	
	if(slaUtil == none)
		slaUtil = Quest.GetQuest("sla_Internal") As slaInternalScr
	endif
	

	SetVersion(20140124)
	
	slaNextTimePlayerNaked.SetValue(0.0)	
		
	UnregisterForAllModEvents()
	RegisterForModEvent("StageStart", slaStageStartStr)
	RegisterForModEvent("OrgasmEnd", slaAnimationEndStr)
	RegisterForModEvent("slaUpdateExposure", "ModifyExposure")
	
	RegisterForCrosshairRef()
	
	int xflmainId = Game.GetModByName("Devious Devices - Assets.esm")
	if(xflmainId != 255)
			zadDeviousBelt = Game.GetFormFromFile(0x02003330, "Devious Devices - Assets.esm") As Keyword
			Debug.Trace(Self + ": found Devious Devices - Assets.esm")
	else
		zadDeviousBelt = None
	EndIf

	;Debug.Trace(Self + "Slamain stage 3")
	;;We no longer want the player to have this spell
	if(PlayerRef.HasSpell(slaCloakSpell))
		PlayerRef.RemoveSpell(slaCloakSpell)	
	endif
	
	UpdateDesireSpell()

	UnregisterForAllKeys()
	UpdateKeyRegistery()
	
	Debug.Trace(Self + ": finished maintenance")
	;Debug.Notification("SexLab Aroused ready to use at frequency " + updateFrequency)
	gotoState("")
	RegisterForSingleUpdate(updateFrequency) ;Start scanning in two minutes
	bWasInitialized = true
	if(slaConfig.wantsPurging && (GameDaysPassed.getValue() >= sla_NextMaintenance.getValue()))
		startCleaning()
	endif
EndEvent
endState

bool function IsSexLabActive()
	int i = SexLab.Threads.Length
	while i
		i -= 1
		if SexLab.Threads[i].IsLocked
			return true ; // There is a locked/active thread.
		endIf
	endwhile
	return false ; // No threads where locked/active
endfunction

;This is synchronization code.  The scan all function gets called by multiple functions.  These functions synchronize it.
;When a function calls for actors, they pass in a string. 

Actor [] theActors
int _Internal_actorCount

;Call this with an Id that is unique for debugging
int function getAllActors(int lockNum)
	;debug.trace(self+" Getting actors for " + lockNum + " and locked = " + bIsLocked)
	if(bIsLocked)
		;debug.trace("Was locked, returning old count")
		LockScan(lockNum)
		return _Internal_actorCount
	endif
	LockScan(lockNum)
	slaScanAllScript scanner = (slaScanAll as slaScanAllScript)
	_Internal_actorCount = scanner.getArousedActors()
	theActors = scanner.arousedActors
	return _Internal_actorCount
endFunction

;Call this function to get the actors retrieved in the previous scan
;Be sure to call UnlockScan(lockNum) when you are done processing the actors
;Scanall has a 20 slot array of actors, but most will be unfilled
Actor [] function getLoadedActors(int lockNum)
	if(checkForLock(2))
		debug.trace("In the middle of an update")
		return none
	endif
	LockScan(lockNum)
	return theActors
endFunction

;This should not be called directly, it is called automatically by getAllActors()
int function LockScan(int lockNum)
	int i = 0
	while(i < 5)
		if(lockingInts[i] == -1)
			bIsLocked = true
			;debug.trace("Locking for " + lockNum + " at position " + i)
			lockingInts[i] = lockNum
			return i
		endif
		i = i + 1
	endWhile
	return -1
endFunction

;Returns false if there is an error.  This must be called when you are done processing the actors 
;obtained with getAllActors()
bool function UnlockScan(int lockNum)
	int i = 0
	while(i < 5)
		if(lockingInts[i] == lockNum)
			;debug.trace("UnLocking for " + lockNum + " at position " + i)
			lockingInts[i] = -1
			checkForLocks()
			return true
		endif
		i = i + 1
	endWhile
	return false
endFunction

;Checks to see if the function already has a lock and returns true if it does

bool function checkForLock(int lockNum)
	int i = 0
	while(i < 5)
		if(lockingInts[i] == lockNum)
			;debug.trace(self + " " + lockNum + " was Already locked at " + i)
			return true
		endif
		i = i + 1
	endWhile
	;debug.trace(self+" No existing lock for " + locknum)
	return false
endFunction

;Sets the bIsLocked variable false if there are no locking strings in the array
function checkForLocks()
	int i = 0
	while(i < 5)
		if(lockingInts[i] != -1)
			;debug.trace(self+" Not Unlocking scanner, locked by " + lockingInts[i])
			return
		endif
		i = i + 1
	endWhile
	;debug.trace(self+"Unlocking scanner")
	bIsLocked = false
endFunction


Event OnUpdate()

	if((lastSexFinished > 0) &&  ((Utility.GetCurrentRealTime() - lastSexFinished) < 10))
		debug.trace(self + ":Aroused scan skipped because sexlab is animating within the last 10 seconds.")
		RegisterForSingleUpdate(updateFrequency) ;Another scan in two more minutes
		return
	endif
	if(bDisabled || IsSexLabActive())
		debug.trace(self + ":Aroused scan skipped because sexlab is animating or disabled = " +bDisabled + "." )
		RegisterForSingleUpdate(updateFrequency) ;Another scan in two more minutes
		return
	endif
	

	slaNakedScript nakedScanner = (slaNakedNPC as slaNakedScript)
	int actorCount = 0
	int nakedCount = nakedScanner.getNakedActors()
	
	
	debug.trace("slaScanner start time is ...." + Utility.GetCurrentRealTime())

	if(checkForLock(2))
		debug.trace("Already locked for OnUpdate - This should never happen.  Your machine is too slow")
		return
	endif

	actorCount = getAllActors(2)
	
	;This code attempts to do what the scanning spell does
	bool bPlayerNaked = IsActorNaked(PlayerRef)
	
	if((bNakedOnly == false) || (nakedCount > 0) || bPlayerNaked)
	
		;;Moved actorCount = getAllActors(2) up outside of this if statement so that the else below also has an actorCount
		
		;slaScanAllScript scanner = (slaScanAll as slaScanAllScript)
		
		;int actorCount = scanner.getArousedActors()
		debug.trace("slaScanner After getting actors is ...." + Utility.GetCurrentRealTime() + ", player is naked " +  bPlayerNaked + ", Actor Count " + actorCount)
		
		; edit (BeamerMiasma): Big changes in the loops here. basically I rolled the 3 loops into 1 nested loop:
		;                       actLoop goes through all the actors from the scanner, and finally jumps to the PC
		;                       actNaked then goes through all the actors from the nakedScanner, and finally jumps to the PC (if the PC is naked)
		;                      UpdateNakedArousal is then called with the 2 references (if not pointing to the same actor). I changed that function
		;                       to always update the faction rank, even if there is no LOS, so if UpdateNakedArousal is called you can be 100% sure
		;                       that the faction rank is updated
		;                      Finally, for those cases where UpdateNakedArousal was not called (i.e. for the PC when there are no naked NPCs,
		;                       and for the NPCs when there are no naked NPCs and the PC is not naked either), the faction rank is updated
		actor actLoop
		actor actNaked
		int i = 0
		int j
		bool bFactionNeedsUpdate
		while (i <= actorCount)
				bFactionNeedsUpdate = TRUE
				; actLoop goes through theActors[], and finally to the PC when i==actorCount
				if (i == actorCount)
						actLoop = PlayerRef
				else
						actLoop = theActors[i]
				endif
				j = 0
				;debug.trace("Checking " + actLoop.GetDisplayName())
				; loop through naked actors, and finally PC if PC is naked
				while ((j < nakedCount) || ((j <= nakedCount) && bPlayerNaked))
					if (j == nakedCount)
						actNaked = PlayerRef
					else
						actNaked = nakedScanner.nakedActors[j]
					endif
					if (actLoop != actNaked)
								; UpdateNakedArousal was changed to always update the faction rank, even if no LOS
						UpdateNakedArousal(actLoop, actNaked)
						bFactionNeedsUpdate = FALSE
					endif
					j += 1
				endWhile
				; if faction wasn't updated, do it now
					if (bFactionNeedsUpdate)
						slaUtil.GetActorArousal(actLoop)
					endif
				i += 1
		endWhile
		; end edit (BeamerMiasma)
	else
		int k = actorCount
		while (k)
			k -= 1
			slaUtil.GetActorArousal(theActors[k])
		endwhile
		slaUtil.GetActorArousal(PlayerRef)
	endif
	
	;debug.trace("Unlocking")
	UnlockScan(2)
	debug.trace("slaScanner end time is ...." + Utility.GetCurrentRealTime())
	debug.trace("Next update in " + updateFrequency)
	;debug.notification("Next update in " + updateFrequency)
	RegisterForSingleUpdate(updateFrequency) ;Another scan in two more minutes
	SendModEvent("sla_UpdateComplete",  none, actorCount)
EndEvent

;Called by external programs using a modevent like
;int eid = ModEvent.Create("eventname")
;ModEvent.PushForm(eid, actor)
;ModEvent.PushFloat(eid, 3.5)
;ModEvent.Send(eid)

Event ModifyExposure(Form act, float val)
    Actor akRef = act as Actor
	if(akRef != none)
		slaUtil.UpdateActorExposure(akRef, val as Int, " External Modify Exposure Event")
	endif
EndEvent

Function UpdateNakedArousal(Actor akRef, Actor akNaked)

	If (akRef == None || akNaked == None)
		Return
	EndIf
	If (akRef.IsChild() || akNaked.IsChild())
		Return
	EndIf
	If (akRef.IsDead() || akNaked.IsDead())
		Return
	EndIf
	
	
	
	bool hasLos = true
	if(bUseLOS)
		hasLos = akRef.HasLOS(akNaked)
	endif
	;float lastOrgasmtime = slaUtil.GetActorDaysSinceLastOrgasm(akRef)
	
	;debug.trace("Checking actor " + akRef.GetDisplayName() + " for naked "  + akNaked.GetDisplayName() + ", has los = " + hasLos )

	;If (akRef.HasLOS(akNaked) && slaUtil.GetActorDaysSinceLastOrgasm(akRef) > 0.04)
	If (hasLos  )
		Int genderPreference = slaUtil.GetGenderPreference(akRef)
		
		If (genderPreference == akNaked.GetLeveledActorBase().GetSex() || genderPreference == 2)
			slaUtil.UpdateActorExposure(akRef, 4, " seeing naked " + akNaked.GetDisplayName())
		Else
			slaUtil.UpdateActorExposure(akRef, 2, " seeing naked " + akNaked.GetDisplayName())
		EndIf
			
		If (slaUtil.IsActorExhibitionist(akNaked))
			slaUtil.UpdateActorExposure(akNaked, 2, " being exhibitionist to " + akRef.GetDisplayName())
		EndIf
	Else
	        ; edit (BeamerMiasma): update actor sla_Arousal rank when they have no LOS, this way you can depend on the fact that
	        ;                      calling UpdateNakedArousal (with valid arguments) always updates the faction rank
	        ;slaUtil.GetActorArousal(akRef)
	EndIf
EndFunction

; Note to modders : do not call IsActorNaked() function it is heavy, but check sla_Naked faction rank 
bool Function IsActorNaked(Actor akRef)
	If (akRef == None)
		return false
	EndIf

	Bool isNaked = IsActorNakedVanilla(akRef)
	
	If (!isNaked)
		If (slaConfig.IsExtendedNPCNaked || akRef == PlayerRef)
			isNaked = IsActorNakedExtended(akRef)
		EndIf
	EndIf

	If (isNaked)
		akRef.SetFactionRank(slaNaked, 0)
	Else
		akRef.SetFactionRank(slaNaked, -2)
	EndIf
	
	Return isNaked
EndFunction


Bool Function IsActorNakedVanilla(Actor akRef)
	If (!akRef.WornHasKeyword(ArmorCuirass) && !akRef.WornHasKeyword(ClothingBody))
		return true
	EndIf
	
	Return False
EndFunction

Bool Function IsActorNakedExtended(Actor akRef)
	Form[] itemList = GetEquippedArmors(akRef)
	
	int i = 0
	While i < itemList.length
		If (itemList[i].HasKeyword(ArmorCuirass) || itemList[i].HasKeyword(ClothingBody))
			If (StorageUtil.GetIntValue(itemList[i], "SLAroused.IsNakedArmor", 0) == 0)
				return False
			EndIf
		EndIf
		i += 1
	EndWhile

	Return True
EndFunction


Form[] Function GetEquippedArmors(Actor akRef)
	Form[] armorList

	If (akRef == None)
		return armorList
	EndIf
		
	int[] slaSlotMaskValues = slaConfig.slaSlotMaskValues
		
	int index = 0
	While index < slaSlotMaskValues.length
		Form tmpForm = akRef.GetWornForm(slaSlotMaskValues[index])
		
		If (tmpForm != None)
			If (armorList.Find(tmpForm) < 0)
				armorList = sslUtility.PushForm(tmpForm, armorList)
;				Debug.Trace(self +": found " + tmpForm.GetName())
			EndIf
		EndIf
		
		index += 1
	EndWhile
	
	return armorList
EndFunction

function UpdateCloakEffect()
;;Does nothing, called from slaconfigscr so we keep this till after debug
endFunction

Int Function GetVersion()	
	return modVersion
EndFunction

function UpdateKeyRegistery()
	RegisterForKey(slaConfig.NotificationKey)
	Debug.Trace(self + ": Updated notification key to " + slaConfig.NotificationKey)
endFunction


Function SetVersion(Int  newVersion)
	If (modVersion < newVersion)
		modVersion = newVersion
		;Debug.Notification("SexLab Aroused version : " + slaConfig.getVersion())
		Debug.Trace(Self + ": updated to version : " + slaConfig.getVersion())
	ElseIf (modVersion > newVersion)
		Debug.Notification("SexLab Aroused error : downgrading to version " + newVersion + " is not supported")
		Debug.Trace(Self + ": error : downgrading to version " + newVersion + " is not supported")
	EndIf
EndFunction


Function UpdateDesireSpell()
	If (slaConfig.IsDesireSpell)
		PlayerRef.RemoveSpell(slaDesireSpell)
		PlayerRef.AddSpell(slaDesireSpell, false)
		Debug.Trace(self + ": Enabled Desire spell")
	Else
		PlayerRef.RemoveSpell(slaDesireSpell)
		Debug.Trace(self + ": Disabled Desire spell")
	EndIf
EndFunction



Event OnKeyDown( int keyCode )	
	If (!Utility.IsInMenuMode() && slaConfig.NotificationKey == keyCode)
		Debug.Notification(PlayerRef.GetDisplayName() + " arousal level " + slaUtil.GetActorArousal(PlayerRef))
		
		If (crosshairRef != None)
			Debug.Notification(crosshairRef.GetDisplayName() + " arousal level " + slaUtil.GetActorArousal(crosshairRef))
			slaConfig.slaPuppetActor = crosshairRef
		Else
			slaConfig.slaPuppetActor = PlayerRef
		EndIf
	EndIf
EndEvent


Event OnKeyUp(Int KeyCode, Float HoldTime)
	If (!Utility.IsInMenuMode() && slaConfig.NotificationKey == keyCode)
		If (HoldTime > 2.0)
			StartPCMasturbation()
		EndIf
	EndIf
EndEvent


Function StartPCMasturbation()
	sslBaseAnimation[] animations
	Actor[] sexActors = new Actor[1]
	sexActors[0] = PlayerRef
			
	If (PlayerRef.GetLeveledActorBase().GetSex() == 0)
		animations = SexLab.GetAnimationsByTag(1, "Masturbation", "M")
	Else
		animations = SexLab.GetAnimationsByTag(1, "Masturbation", "F")
	EndIf
			
	int id = SexLab.StartSex(sexActors, animations)
	If id < 0
		Debug.Notification("SexLab animation failed to start [" + id + "]")
		Debug.Trace(self + ": SexLab animation failed to start [" + id + "]")
	EndIf
EndFunction


Event OnCrosshairRefChange(ObjectReference ref)
	crosshairRef = none
	if ref != none
;		if ref.GetVoiceType() != none  ;is this an actor?
			crosshairRef = ref as Actor
;		endIf
	endIf
EndEvent




Event OnStageStart(string eventName, string argString, float argNum, form sender)
	Actor[] actorList = SexLab.HookActors(argString)
	
	If (actorList.length < 1)
		return
	EndIf
	
	sslThreadController thisThread = SexLab.HookController(argString)
	
	If (thisThread.animation.HasTag("Foreplay"))
		int i = 0
		While i < actorList.length
			slaUtil.UpdateActorExposure(actorList[i], 1, "foreplay")
			i += 1
		EndWhile
	EndIf
	
	;;This if actorList.Find code by BeamerMiasma replaces the single ArouseNPCsWithinRadius(actorList[0]
	If (actorList.Find(PlayerRef) >= 0)
		ArouseNPCsWithinRadius(PlayerRef, arousalSearchRadius)
	Else
		ArouseNPCsWithinRadius(actorList[0], arousalSearchRadius)
	EndIf
	
EndEvent


Event OnAnimationEnd(string eventName, string argString, float argNum, form sender)
	Actor[] actorList = SexLab.HookActors(argString)

	lastSexFinished = Utility.GetCurrentRealTime()
	
	If (actorList.length < 1)
		return
	EndIf

	sslThreadController thisThread = SexLab.HookController(argString)
	Actor victim = SexLab.HookVictim(argString)
	sslBaseAnimation animation = SexLab.HookAnimation(argString)
	
	Bool canHaveOrgasm = False
	If (animation.HasTag("Anal") || animation.HasTag("Vaginal") || animation.HasTag("Masturbation") || animation.HasTag("Fisting"))
		canHaveOrgasm = True
	EndIf
	
	If (victim != None)
		If (victim == PlayerRef)
			wasPlayerRaped = True
		EndIf
		slaUtil.UpdateActorExposure(victim, -10, "being rape victim")
	EndIf
	
	Int exposureValue = ((thisThread.TotalTime / GetAnimationDuration(thisThread)) * -20.0) as Int
	int i = 0	
	While i < actorList.length
		If (actorList[i].GetLeveledActorBase().GetSex() == 0 || actorList[i].GetLeveledActorBase().GetSex() == -1)
			slaUtil.UpdateActorOrgasmDate(actorList[i])
			slaUtil.UpdateActorExposure(actorList[i], exposureValue, "having orgasm")
		ElseIf (actorList[i].GetLeveledActorBase().GetSex() == 1)
			Bool actorHasDeviousBelt = False
			If (zadDeviousBelt != None)
				actorHasDeviousBelt = actorList[i].WornHasKeyword(zadDeviousBelt)
			EndIf
			
			If (canHaveOrgasm && !actorHasDeviousBelt)
				slaUtil.UpdateActorOrgasmDate(actorList[i])
				slaUtil.UpdateActorExposure(actorList[i], exposureValue, "having orgasm")
			Else
				; Debug.Trace(Self + ": " + actorList[i].GetDisplayName() + " can not have orgasm")
			EndIf
		EndIf
		
		i += 1
	EndWhile
EndEvent


Function ArouseNPCsWithinRadius(Actor akCenter, float radius)
	If (akCenter == None)
		return
	EndIf

	if(checkForLock(3))
		debug.trace("Already locked for ArouseNPCsWithinRadius")
		return
	endif
	
	int actorCount = getAllActors(3)
	
	bool havePlayer = false
	int i = 0
	While (i < actorCount)
		Actor akTmp = theActors[i]
		if(akTmp == playerRef)
			havePlayer = true
		endif
		If (akTmp != None)
			;debug.trace("Checking WatchingSex " + akTmp.GetDisplayName())
			If (akCenter.GetDistance(akTmp) < radius && !akTmp.IsInFaction(SexLab.AnimatingFaction))
				if (akTmp.HasLOS(akCenter))
					slaUtil.UpdateActorExposure(akTmp, 1, " watching sex of " + akCenter.GetDisplayName())
				EndIf
			EndIf
		EndIf
		i += 1
	EndWhile
	
	;if(!havePlayer)
		;debug.trace("Checking playerRef")
	;	If (playerRef.HasLOS(akCenter))
	;		slaUtil.UpdateActorExposure(playerRef, 1, " watching sex of " + akCenter.GetDisplayName())
	;	EndIf
	;endif
	UnlockScan(3)
EndFunction


Float Function GetAnimationDuration(sslThreadController bThread)
	If (bThread == None)
		return -1.0
	EndIf
	
	Float[] timeList =  bThread.Timers
	
	Float res = 0.0
	Float stageTimer = 0.0
	int i = 0
	int stageCount = bThread.animation.StageCount()
	
	While (i < timeList.length && i < stageCount)
	
		if i == stageCount - 1
			stageTimer = timeList[4]
		elseif i < 3
			stageTimer = timeList[i]
		else
			stageTimer = timeList[3]
		endIf
		
		res = res + stageTimer
		i += 1
	EndWhile
	
	return res
EndFunction


Function OnPlayerArousalUpdate(Int arousal)	
	If (arousal <= 20 && (previousPlayerArousal > 20 || lastNotificationTime + 0.5 <= GameDaysPassed.GetValue()))
		If (wasPlayerRaped == True)
			Debug.Notification("$SLA_NotificationArousal20Rape")
			wasPlayerRaped = False
		Else
			Debug.Notification("$SLA_NotificationArousal20")
		EndIf
		lastNotificationTime = GameDaysPassed.GetValue()
	ElseIf (arousal >= 90 && (previousPlayerArousal < 90 || lastNotificationTime + 0.2 <= GameDaysPassed.GetValue()))
		Debug.Notification("$SLA_NotificationArousal90")
		lastNotificationTime = GameDaysPassed.GetValue()
	ElseIf (arousal >= 70 && (previousPlayerArousal < 70 || lastNotificationTime + 0.3 <= GameDaysPassed.GetValue()))
		Debug.Notification("$SLA_NotificationArousal70")
		lastNotificationTime = GameDaysPassed.GetValue()
	ElseIf (arousal >= 50 && (previousPlayerArousal < 50 || lastNotificationTime + 0.4 <= GameDaysPassed.GetValue()))
		Debug.Notification("$SLA_NotificationArousal50")
		lastNotificationTime = GameDaysPassed.GetValue()
	EndIf

	previousPlayerArousal = arousal
EndFunction

function CleanActorStorage()

	debug.notification("Please wait, SLA Redux Actor Storage Cleaning")
	
	setCleaningTime()
	
	int i = StorageUtil.debug_GetFloatObjectCount()
	;debug.trace("Cleaning started at " + Utility.GetCurrentRealTime() + ", with " + i + " items to check")
	
	int removedCount = 0;
	
	while i
		i -= 1
		Form ObjKey = StorageUtil.debug_GetFloatObject(i)
		int n = StorageUtil.debug_GetFloatKeysCount(ObjKey)
		while n
			n -= 1
			string ValueName = StorageUtil.debug_GetFloatKey(ObjKey, n)
			;debug.trace("Checking Key " + ValueName)
			if (ValueName == "SLAroused.ActorExposure")
				bool IsActor = IsActor(ObjKey)
				if( !IsActor || (IsActor && !IsImportant(ObjKey as Actor)))
					;if(IsActor)
					;	debug.trace("Would delete " + (ObjKey as Actor).GetDisplayName())
					;else
					;	debug.trace("Would delete nonactor " + i)
					;endif
					removedCount += 1
					ClearFromActorStorage(ObjKey)

					; // Exit the string keys loop since aroused keys have already been found
					n = 0
;				else
;					if(IsActor)
;						debug.trace("Not deleting " + (ObjKey as Actor).GetDisplayName())
;					else
;						debug.trace("Not deleting nonactor " + i)
;					endif
				endif
			endIf
		endwhile
	endWhile
	debug.trace("Removed " + removedCount + " unused settings.  Finished at " + Utility.GetCurrentRealTime());
	debug.notification("Actor Storage Cleaning Complete")
endFunction

bool function IsActor(Form FormRef)
	return FormRef && ActorTypes.Find(FormRef.GetType()) != -1
endFunction

bool function IsImportant(Actor ActorRef)
	if !ActorRef || ActorRef.IsDead() || ActorRef.IsDeleted() || ActorRef.IsChild()
		return false
	elseIf ActorRef == PlayerRef
		return true
	endIf
	ActorBase BaseRef = ActorRef.GetLeveledActorBase()
	return BaseRef.IsUnique() || BaseRef.IsEssential() || BaseRef.IsInvulnerable() || BaseRef.IsProtected() || ActorRef.IsGuard() || ActorRef.IsPlayerTeammate()
endFunction

function ClearFromActorStorage(Form FormRef)
	;
	;StorageUtil.FormListRemove(none, "SLAroused.TimeRate", none, true)
	
	StorageUtil.UnsetFloatValue(FormRef, "SLAroused.TimeRate")
	StorageUtil.UnsetFloatValue(FormRef, "SLAroused.ExposureRate")
	StorageUtil.UnsetFloatValue(FormRef, "SLAroused.ActorExposure")
	StorageUtil.UnsetFloatValue(FormRef, "SLAroused.ActorExposureDate")
	StorageUtil.UnsetFloatValue(FormRef, "SLAroused.LastOrgasmDate")
endFunction
