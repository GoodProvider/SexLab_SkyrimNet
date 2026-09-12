Scriptname slaCloakEffScr extends activemagiceffect  

; sla
slaInternalScr Property slaUtil Auto
slaConfigScr Property slaConfig Auto
Faction Property slaNaked Auto
GlobalVariable Property slaNextTimePlayerNaked Auto

; vanilla
Actor Property PlayerRef Auto
Keyword Property kArmorCuirass Auto
Keyword Property kClothingBody Auto
Keyword Property kActorTypeCreature Auto

; sexlab
SexLabFramework property SexLab auto

;float ftimeStart
;Actor targetActor

Event OnEffectStart(Actor akTarget, Actor akCaster)
;	ftimeStart = Utility.GetCurrentRealTime()
;	targetActor = akTarget
	
	;No longer using this
	return
	
	
	If (slaUtil == None || Utility.IsInMenuMode())
		Return
	EndIf

	Actor lastNakedActor = slaConfig.slaNakedActor
	If (akTarget != None)	
		If (IsActorNaked(PlayerRef))
			UpdateNakedArousal(akTarget, PlayerRef)
		ElseIf (lastNakedActor != None && lastNakedActor != akTarget)
			If (lastNakedActor.GetFactionRank(slaNaked) >= 0)
				UpdateNakedArousal(akTarget, lastNakedActor)
			EndIf
		Else
			; just update actor arousal
			slaUtil.GetActorArousal(akTarget)
		EndIf
		
		If (!akTarget.HasKeyword(kActorTypeCreature))
			If (IsActorNaked(akTarget))
				debug.trace("     " + akTarget.GetDisplayName() + "  is naked")
				UpdateNakedArousal(PlayerRef, akTarget)
			
				If (lastNakedActor == None)
					slaConfig.slaNakedActor = akTarget
				ElseIf (PlayerRef.GetDistance(akTarget) < PlayerRef.GetDistance(lastNakedActor))
					slaConfig.slaNakedActor = akTarget
				EndIf
			else
						debug.trace("     " + akTarget.GetDisplayName() + "  is not naked")
			EndIf
		else
						debug.trace("     " + akTarget.GetDisplayName() + "  has a curras")

		EndIf
	EndIf
EndEvent


;Event OnEffectFinish(Actor akTarget, Actor akCaster)
;	float ftimeEnd = Utility.GetCurrentRealTime()
;	If (targetActor != None)
;		Debug.Trace(Self + ": took " + (ftimeEnd - ftimeStart) + " seconds from start to finish for actor " + targetActor.GetDisplayName())
;	Else
;		Debug.Trace(Self + ": took " + (ftimeEnd - ftimeStart) + " seconds from start to finish")
;	EndIf
;EndEvent


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
	
	If (akRef.HasLOS(akNaked) && slaUtil.GetActorDaysSinceLastOrgasm(akRef) > 0.04)
		Int genderPreference = slaUtil.GetGenderPreference(akRef)
		
		If (genderPreference == akNaked.GetLeveledActorBase().GetSex() || genderPreference == 2)
			slaUtil.UpdateActorExposure(akRef, 2, " seeing naked " + akNaked.GetDisplayName())
		Else
			slaUtil.UpdateActorExposure(akRef, 1, " seeing naked " + akNaked.GetDisplayName())
		EndIf
			
		If (slaUtil.IsActorExhibitionist(akNaked))
			slaUtil.UpdateActorExposure(akNaked, 1, " being exhibitionist to " + akRef.GetDisplayName())
		EndIf
	EndIf
EndFunction


; Note to modders : do not call IsActorNaked() function it is heavy, but check sla_Naked faction rank 
bool Function IsActorNaked(Actor akRef)
	If (akRef == None)
		return false
	EndIf

	; since PC is checked often, reduce number of checks to one in 15.0 seconds
	If (akRef == PlayerRef)
		If (Utility.GetCurrentRealTime() < slaNextTimePlayerNaked.GetValue())
			return (akRef.GetFactionRank(slaNaked) >= 0)
		Else
			slaNextTimePlayerNaked.SetValue(Utility.GetCurrentRealTime() + 15.0)
		EndIf
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
	If (!akRef.WornHasKeyword(kArmorCuirass) && !akRef.WornHasKeyword(kClothingBody))
		return true
	EndIf
	
	Return False
EndFunction


Bool Function IsActorNakedExtended(Actor akRef)
	Form[] itemList = GetEquippedArmors(akRef)
	
	int i = 0
	While i < itemList.length
		If (itemList[i].HasKeyword(kArmorCuirass) || itemList[i].HasKeyword(kClothingBody))
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