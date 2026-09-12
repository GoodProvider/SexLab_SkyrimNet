Scriptname slaFrameworkScr extends Quest

; vanilla
Actor Property PlayerRef Auto

; sla properties
slaMainScr Property slaMain Auto
slaConfigScr Property slaConfig Auto

FormList Property slaArousedVoiceList Auto
FormList Property slaUnArousedVoiceList Auto

Faction Property slaArousal Auto
Faction Property slaArousalBlocked Auto
Faction Property slaArousalLocked Auto
Faction Property slaExposure Auto
Faction Property slaExhibitionist Auto
Faction Property slaGenderPreference Auto
Faction Property slaTimeRate Auto
Faction Property slaExposureRate Auto



GlobalVariable Property sla_NextMaintenance  Auto  
;GlobalVariable Property GameDaysPassed Auto

Int Property slaArousalCap = 100 AutoReadOnly

; SexLab
SexLabFramework property SexLab auto


Int Function GetVersion()
	Return slaMain.GetVersion()
EndFunction

; 0 - Male
; 1 - Female
; 2 - Both
; 3 - SexLab
Int Function GetGenderPreference(Actor akRef, Bool forConfig = False)
	If (akRef == None)
		return -2
	EndIf
			
	int res = akRef.GetFactionRank(slaGenderPreference)
		
	If (res < 0 || res == 3)
		If (forConfig == True)
			Return 3
		EndIf
	
		;Debug.trace("Using Sexlab for GenderPref")

		int retVal = -1
		
		;;;Credits to Doombell for this piece of code
		int ratio = SexLab.Stats.GetSexuality(akRef)
		if ratio > 65
			retVal =  (-(akRef.GetLeveledActorBase().GetSex() - 1))
		ElseIf ratio < 35
			retVal =  akRef.GetLeveledActorBase().GetSex()
		Else
			retVal =  2
		EndIf
	
		;debug.trace("Returning gender preference " + retVal)
		
		return retVal
		
		;;This code is commented out.  It is the original code.
		;;These three sexlab calls fail unless the user manually sets the Sexlab gender preference
		
		;If (SexLab.Stats.IsStraight(akRef))
		;	If (akRef.GetLeveledActorBase().GetSex() == 0)
		;		Return 1
		;	Else
		;		Return 0
		;	EndIf
		;EndIf
		
		;If (SexLab.Stats.IsBisexual(akRef))
		;	Return 2
		;EndIf		
		
		;If (SexLab.Stats.IsGay(akRef))
		;	Return akRef.GetLeveledActorBase().GetSex()
		;EndIf
	EndIf
	
	Return res
EndFunction


Function SetGenderPreference(Actor akRef, Int gender)
	If (akRef == None)
		return
	EndIf
	
	akRef.SetFactionRank(slaGenderPreference, gender)
EndFunction


bool Function IsActorExhibitionist(Actor akRef)
	If (akRef == None)
		return false
	EndIf
	
	If (akRef.GetFactionRank(slaExhibitionist) >= 0)
		return true
	EndIf
	
	return false
EndFunction


Function SetActorExhibitionist(Actor akRef, bool val = false)
	If (akRef == None)
		return
	EndIf
	
	If (val == true)
		akRef.SetFactionRank(slaExhibitionist, 0)
	Else
		akRef.SetFactionRank(slaExhibitionist, -2)
	EndIf
EndFunction


; returned values range 0.0 - 100.0
Float Function GetActorTimeRate(Actor akRef)
	If (akRef == None)
		return -2.0
	EndIf
	
	; return default value if set not to decay
	If (slaConfig.TimeRateHalfLife <= 0.1)
		Return 10.0
	EndIf
	
	Float res = StorageUtil.GetFloatValue(akRef, "SLAroused.TimeRate", 10.0)
	Float daysSinceLastSex = GetActorDaysSinceLastOrgasm(akRef)
	
	res = res * Math.pow(1.5, - daysSinceLastSex / slaConfig.TimeRateHalfLife)

	akRef.SetFactionRank(slaTimeRate, res as Int)
	Return res
EndFunction


; val values are 0.0-100.0
; returned values range 0.0 - 100.0
Float Function SetActorTimeRate(Actor akRef, Float val)
	If (akRef == None)
		return -2.0
	EndIf

	If (val < 0.0)
		val = 0.0
	ElseIf (val > 100.0)
		val = 100.0
	EndIf
	
	Return StorageUtil.SetFloatValue(akRef, "SLAroused.TimeRate", val)
EndFunction


; use to change time rate incrementally
Float Function UpdateActorTimeRate(Actor akRef, Float val)
	If (akRef == None)
		return -2.0
	EndIf
	
	val = GetActorTimeRate(akRef) + val
	Return SetActorTimeRate(akRef, val)
EndFunction


Float Function GetActorExposureRate(Actor akRef)
	If (akRef == None)
		return -2.0
	EndIf
	
	float res = StorageUtil.GetFloatValue(akRef, "SLAroused.ExposureRate", -2.0)
	
	; set default value
	If (res < 0.0)
		VoiceType akVoice = akRef.GetLeveledActorBase().GetVoiceType()
	
		If (akVoice != None)
			If (slaArousedVoiceList.Find(akVoice) >= 0)
				res = slaConfig.DefaultExposureRate + 1.0
			ElseIf (slaUnArousedVoiceList.Find(akVoice) >= 0)
				res = slaConfig.DefaultExposureRate - 1.0
			Else
				res = slaConfig.DefaultExposureRate
			EndIf
		Else
			res = slaConfig.DefaultExposureRate
		EndIf
	EndIf
	
	If (res < 0.0)
		res = 0.0
	ElseIf (res > 10.0)
		res = 10.0
	EndIf
	
	Return res
EndFunction


Float Function SetActorExposureRate(Actor akRef, Float val)
	If (akRef == None)
		return -2.0
	EndIf
	
	Int res = (val * 10.0) as Int
	
	If (val < -100.0)
		; Reset values
		val = -2.0
		res = -2
	ElseIf (val < 0.0)
		val = 0.0
		res = 0
	ElseIf (val > 10.0)
		val = 10.0
		res = 100
	EndIf
	
	akRef.SetFactionRank(slaExposureRate, res)
	Return StorageUtil.SetFloatValue(akRef, "SLAroused.ExposureRate", val)
EndFunction


Float Function UpdateActorExposureRate(Actor akRef, Float val)
	If (akRef == None)
		return -2.0
	EndIf
	If (akRef.IsChild())
		return -2.0
	EndIf
	If (akRef.IsDead())
		return -2.0
	EndIf
	
	Float res = GetActorExposureRate(akRef) + val
	Return SetActorExposureRate(akRef, res)
EndFunction


Int Function GetActorExposure(Actor akRef)
	If (akRef == None)
		return -2
	EndIf

	Float res = StorageUtil.GetFloatValue(akRef, "SLAroused.ActorExposure", -2.0)

	; roll initial exposure if needed	
	If (res < -1.0)
		res = Utility.RandomFloat(0.0, 50.0)
		StorageUtil.SetFloatValue(akRef, "SLAroused.ActorExposure", res)
		StorageUtil.SetFloatValue(akRef, "SLAroused.ActorExposureDate", Utility.GetCurrentGameTime())		
	EndIf
	
	If (slaConfig.TimeRateHalfLife > 0.1)
		Float timeSinceUpdate = Utility.GetCurrentGameTime() - StorageUtil.GetFloatValue(akRef, "SLAroused.ActorExposureDate", 0.0)
		res = res * Math.pow(1.5, - timeSinceUpdate / slaConfig.TimeRateHalfLife)
	EndIf
		
	akRef.SetFactionRank(slaExposure, res as Int)
	
	return res as Int
EndFunction


Int Function SetActorExposure(Actor akRef, Int val)
	If (akRef == None)
		return -2
	EndIf
		
	If (val < 0)
		val = 0
	ElseIf (val > 100)
		val = 100
	EndIf

	StorageUtil.SetFloatValue(akRef, "SLAroused.ActorExposure", val as Float)
	StorageUtil.SetFloatValue(akRef, "SLAroused.ActorExposureDate", Utility.GetCurrentGameTime())
	
	; use to update actual arousal
	GetActorArousal(akRef)
	
	return val
EndFunction


;New UpdateActorExposure proposed by BeamerMiasma on this topic http://www.loverslab.com/topic/37652-sexlab-aroused-redux/?p=1300702
;The purpose is to remove rounding errors in the conversion from float to int in the old function found below
;This will be slightly faster as well keeping all the code together for easier understanding
;This function is called from multiple locations in slamain and any speed improvements will be useful
;
;In my view, this entire thing should be rewritten to use floats for all functions, but that would break the interface that so many
;are using

Int Function UpdateActorExposure(Actor akRef, Int val, String debugMsg = "")
        If (akRef == None)
                return -2
        EndIf
        If (akRef.IsChild())
                return -2
        EndIf
        If (akRef.IsDead())
                return -2
        EndIf
 
        Float valFix = (val as Float) * GetActorExposureRate(akRef)
        Float res = StorageUtil.GetFloatValue(akRef, "SLAroused.ActorExposure", -2.0)
 
        ; roll initial exposure if needed
        If (res < -1.0)
                res = Utility.RandomFloat(0.0, 50.0) + valFix
        Else
                If (slaConfig.TimeRateHalfLife > 0.1)
                        Float timeSinceUpdate = Utility.GetCurrentGameTime() - StorageUtil.GetFloatValue(akRef, "SLAroused.ActorExposureDate", 0.0)
                        res = res * Math.pow(1.5, - timeSinceUpdate / slaConfig.TimeRateHalfLife) + valFix
                EndIf
        EndIf
 
        If (res < 0.0)
                res = 0.0
        ElseIf (res > 100.0)
                res = 100.0
        EndIf
 
        ; store new exposure value
        akRef.SetFactionRank(slaExposure, res as Int)
        StorageUtil.SetFloatValue(akRef, "SLAroused.ActorExposure", res)
        StorageUtil.SetFloatValue(akRef, "SLAroused.ActorExposureDate", Utility.GetCurrentGameTime())
 
        ; use to update actual arousal
        GetActorArousal(akRef)
 
        ;Debug.Trace("SLA: " + akRef.GetDisplayName() + " got " + (valFix as Int) + " exposure for " + debugMsg)
 
        return res as Int
EndFunction


;;This is the old function.  It is replaced with the one above to remove rounding errors when converting between float and int
;;GetActorExposure is the main culprit
;Int Function UpdateActorExposure(Actor akRef, Int val, String debugMsg = "")
;	If (akRef == None)
;		return -2
;	EndIf
;	
;	If (akRef.IsChild())
;		return -2
;	EndIf
;	
;	Int valFix = ((val as Float) * GetActorExposureRate(akRef)) as Int
;	Int newRank = GetActorExposure(akRef) + valFix
;	
;	Debug.Trace("SLA: " + akRef.GetDisplayName() + " got " + valFix + " exposure for " + debugMsg)
;	
;	return SetActorExposure(akRef, newRank)
;EndFunction


Float Function GetActorDaysSinceLastOrgasm(Actor akRef)
	If (akRef == None)
		return -2.0
	EndIf
	
	Float res = StorageUtil.GetFloatValue(akRef, "SLAroused.LastOrgasmDate", -2.0)
	
	; if orgasm not yet set try SexLab
	If (res < -1.0)
		Return SexLab.Stats.DaysSinceLastSex(akRef)
	EndIf
	
	Return Utility.GetCurrentGameTime() - res
EndFunction


Function UpdateActorOrgasmDate(Actor akRef)
	If (akRef == None)
		return
	EndIf
	
	UpdateActorTimeRate(akRef, slaConfig.SexOveruseEffect as Float)
	StorageUtil.SetFloatValue(akRef, "SLAroused.LastOrgasmDate", Utility.GetCurrentGameTime())
	;Debug.Trace(Self + ": " + akRef.GetDisplayName() + " had orgasm date updated")
EndFunction


bool Function IsActorArousalLocked(Actor akRef)
	If (akRef == None)
		return true
	EndIf

	If (akRef.GetFactionRank(slaArousalLocked) >= 0)
		return true
	EndIf
	
	return false
EndFunction


Function SetActorArousalLocked(Actor akRef, bool val)
	If (akRef == None)
		return
	EndIf
	
	If (val == true)
		akRef.SetFactionRank(slaArousalLocked, 0)
	Else
		akRef.SetFactionRank(slaArousalLocked, -2)
	EndIf
EndFunction


bool Function IsActorArousalBlocked(Actor akRef)
	If (akRef == None)
		return true
	EndIf

	If (akRef.GetFactionRank(slaArousalBlocked) >= 0)
		return true
	EndIf
	
	return false
EndFunction


Function SetActorArousalBlocked(Actor akRef, bool val)
	If (akRef == None)
		return
	EndIf
	
	If (val == true)
		akRef.SetFactionRank(slaArousalBlocked, 0)
	Else
		akRef.SetFactionRank(slaArousalBlocked, -2)
	EndIf
EndFunction


int Function GetActorArousal(Actor akRef)
	If (akRef == None)
		return -2
	EndIf
	
	If (IsActorArousalBlocked(akRef) || akRef.IsChild())
		akRef.SetFactionRank(slaArousal, -2)
		return -2
	EndIf
	
	If (IsActorArousalLocked(akRef))
		return akRef.GetFactionRank(slaArousal)
	EndIf
	
	Int newRank = (GetActorDaysSinceLastOrgasm(akRef) * GetActorTimeRate(akRef)) as Int + GetActorExposure(akRef)
	
	If (newRank < 0)
		newRank = 0
	ElseIf (newRank > slaArousalCap)
		newRank = slaArousalCap
	EndIf
	
	akRef.SetFactionRank(slaArousal, newRank)
	UpdateSOSPosition(akRef, newRank)
	
	If (akRef == PlayerRef)
		slaMain.OnPlayerArousalUpdate(newRank)
	Else		
		If (slaConfig.slaMostArousedActorInLocation != None && slaConfig.slaMostArousedActorInLocation != akRef)
			If (slaConfig.slaMostArousedActorInLocation.GetCurrentLocation() == PlayerRef.GetCurrentLocation())
				If (slaConfig.slaArousalOfMostArousedActorInLoc <= newRank)
					slaConfig.slaMostArousedActorInLocation = akRef
					slaConfig.slaArousalOfMostArousedActorInLoc = newRank
				EndIf
			Else
				slaConfig.slaMostArousedActorInLocation = akRef
				slaConfig.slaArousalOfMostArousedActorInLoc = newRank
			EndIf
		Else
			slaConfig.slaMostArousedActorInLocation = akRef
			slaConfig.slaArousalOfMostArousedActorInLoc = newRank
		EndIf
	EndIf

	return newRank
EndFunction


Actor Function GetMostArousedActorInLocation()
	Return slaConfig.slaMostArousedActorInLocation
EndFunction


Function UpdateSOSPosition(Actor akRef, int akArousal)
	If (akRef == None || !slaConfig.IsUseSOS)
		return
	ElseIf akRef.IsInFaction(SexLab.AnimatingFaction)
		return
	EndIf
	
	int res = (akArousal / 4) - 14;
	HandleErection(akRef,  res)
EndFunction


Function HandleErection(Actor akRef, int position)
	If position < -9
		Debug.sendAnimationEvent(akRef, "SOSFlaccid")
	ElseIf position > 9
		Debug.sendAnimationEvent(akRef, "SOSBend9")
	Else
		Debug.sendAnimationEvent(akRef, "SOSBend" + position)
	EndIf
EndFunction


; ************************
; Depreciated functions
; ************************
Int Function GetActorHoursSinceLastSex(Actor akRef)
	;Debug.Trace(Self + ": function GetActorHoursSinceLastSex is depreciated")
	If (akRef == None)
		return -2
	EndIf
	
	Return SexLab.Stats.HoursSinceLastSex(akRef) as Int
EndFunction


Float Function GetActorDaysSinceLastSex(Actor akRef)
	If (akRef == None)
		return -2.0
	EndIf
	
	Return SexLab.Stats.DaysSinceLastSex(akRef)
EndFunction
