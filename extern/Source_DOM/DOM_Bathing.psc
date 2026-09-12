Scriptname DOM_Bathing extends Quest  
Import DOM_Util

DOM_Core Property DOMCore Auto
DOM_SEXLAB Property DOMSexlab Auto
DOM_Animator Property DOM_Anim Auto

Actor Property PlayerRef Auto

MiscObject Property soap01 Auto
FormList Property DOMWaterList Auto
FormList Property DOMWaterfallList Auto

bool Property useBiS = false Auto Hidden
bool has_BiS = false
bool has_DaB = false

; Bathing in Skyrim 
FormList Property WashPropList Auto Hidden
FormList Property BatheAttemptSpellList Auto Hidden
FormList Property SoapBonusSpellList Auto Hidden
GlobalVariable Property GetSoapyStyleFollowers Auto Hidden
Spell Property DefaultBatheAttemptSpell Auto Hidden
Spell Property SoapyAppearanceSpell Auto Hidden
Spell Property SoapyAppearanceAnimatedSpell Auto Hidden

; Keep it clean
FormList Property SBBATHSoapItemList Auto Hidden
FormList Property SBSoapSpellFLST Auto Hidden
Keyword Property LocTypeShowerInInns Auto Hidden
GlobalVariable Property SBBATHAnimatedSoapShader Auto Hidden
Spell Property SBBathSoapAnimationSpell Auto Hidden
Spell Property SBBathSoapNoAnimationSpell Auto Hidden

; Dirt and Blood
MiscObject Property Dirty_Soap Auto Hidden
Spell Property Dirty_SoapEffectSpell Auto Hidden
Spell Property Dirty_Spell_Clean Auto Hidden
Spell Property Dirty_Spell_Dirt1 Auto Hidden
Spell Property Dirty_Spell_Dirt2 Auto Hidden
Spell Property Dirty_Spell_Dirt3 Auto Hidden
Spell Property Dirty_Spell_Dirt4 Auto Hidden
Spell Property Dirty_Spell_Blood1 Auto Hidden
Spell Property Dirty_Spell_Blood2 Auto Hidden
Spell Property Dirty_Spell_Blood3 Auto Hidden
Spell Property Dirty_Spell_Blood4 Auto Hidden
Spell Property Dirty_NPCEffect_Blood1 Auto Hidden
Spell Property Dirty_NPCEffect_Blood2 Auto Hidden
Spell Property Dirty_NPCEffect_Blood3 Auto Hidden
Spell Property Dirty_NPCEffect_Blood4 Auto Hidden
Spell Property Dirty_NPCEffect_Blood5 Auto Hidden
Spell Property Dirty_CleaningEffect Auto Hidden
Spell Property Dirty_CleaningEffectNPC Auto Hidden

; Wet Function redux
Spell Property WetReduxSpell Auto Hidden
Form Property WetReduxMCM Auto Hidden

; Wet and Cold
Spell Property WetNPCDripSpell Auto Hidden

Function Initialize()
	LogInfo("=============================================================================")
	LogInfo("==                         DOM: Bathing interface                          ==")
	LogInfo("=============================================================================")

	If (Game.GetModByName("Bathing in Skyrim.esp") != 255) ; BiS renewed
		LogTrace("BathingInSkyrim renewed Found!")
		WashPropList = (Game.GetFormFromFile(0xFE000DAE, "Bathing in Skyrim.esp") As FormList)
		BatheAttemptSpellList = None ; (Game.GetFormFromFile(0x000269C1, "Bathing in Skyrim.esp") As FormList)
		SoapBonusSpellList = (Game.GetFormFromFile(0x0000008E, "Bathing in Skyrim.esp") As FormList)
		GetSoapyStyleFollowers = (Game.GetFormFromFile(0x00000018, "Bathing in Skyrim.esp") As GlobalVariable)
		DefaultBatheAttemptSpell = None ; (Game.GetFormFromFile(0x00027F54, "Bathing in Skyrim.esp") As Spell)
		SoapyAppearanceSpell = (Game.GetFormFromFile(0x00000039, "Bathing in Skyrim.esp") As Spell)
		SoapyAppearanceAnimatedSpell = (Game.GetFormFromFile(0x0000003B, "Bathing in Skyrim.esp") As Spell)
		has_BiS = true
	elseIf (Game.GetModByName("Bathing in Skyrim - Main.esp") != 255) ; BiS origin
		LogTrace("BathingInSkyrim legacy Found!")
		WashPropList = (Game.GetFormFromFile(0x00000DAE, "Bathing in Skyrim - Main.esp") As FormList)
		BatheAttemptSpellList = (Game.GetFormFromFile(0x000269C1, "Bathing in Skyrim - Main.esp") As FormList)
		SoapBonusSpellList = (Game.GetFormFromFile(0x000053CE, "Bathing in Skyrim - Main.esp") As FormList)
		GetSoapyStyleFollowers = (Game.GetFormFromFile(0x0001E84C, "Bathing in Skyrim - Main.esp") As GlobalVariable)
		DefaultBatheAttemptSpell = (Game.GetFormFromFile(0x00027F54, "Bathing in Skyrim - Main.esp") As Spell)
		SoapyAppearanceSpell = (Game.GetFormFromFile(0x00019CBA, "Bathing in Skyrim - Main.esp") As Spell)
		SoapyAppearanceAnimatedSpell = (Game.GetFormFromFile(0x00022391, "Bathing in Skyrim - Main.esp") As Spell)
		has_BiS = true
	else
		WashPropList = None
		BatheAttemptSpellList = None
		SoapBonusSpellList = None
		GetSoapyStyleFollowers = None
		DefaultBatheAttemptSpell = None
		SoapyAppearanceSpell = None
		SoapyAppearanceAnimatedSpell = None
		has_BiS = false
	endif
	If (Game.GetModByName("Keep It Clean.esp") != 255)
		LogTrace("KeepItClean Found!")
		SBBATHSoapItemList = (Game.GetFormFromFile(0x001DF00F, "Keep It Clean.esp") As FormList)
		LocTypeShowerInInns = (Game.GetFormFromFile(0x0011C0A2, "Keep It Clean.esp") As Keyword)
		SBBATHAnimatedSoapShader = (Game.GetFormFromFile(0x001A7503, "Keep It Clean.esp") As GlobalVariable)
		SBBathSoapNoAnimationSpell = (Game.GetFormFromFile(0x001A7501, "Keep It Clean.esp") As Spell)		
		SBBathSoapAnimationSpell = (Game.GetFormFromFile(0x001606EF, "Keep It Clean.esp") As Spell)
		If (Game.GetModByName("DOMKeepItClean.esp") != 255)
			SBSoapSpellFLST = (Game.GetFormFromFile(0x00000800, "DOMKeepItClean.esp") As FormList)
		endif
	else
		SBBATHSoapItemList = None
		LocTypeShowerInInns = None
		SBBATHAnimatedSoapShader = None
		SBBathSoapNoAnimationSpell = None
		SBBathSoapAnimationSpell = None
		SBSoapSpellFLST = None
	endif
	If (Game.GetModByName("Dirt and Blood - Dynamic Visuals.esp") != 255)
		LogTrace("DirtAndBlood Found!")
		Dirty_Soap = (Game.GetFormFromFile(0x0000082E, "Dirt and Blood - Dynamic Visuals.esp") As MiscObject)
		Dirty_SoapEffectSpell = (Game.GetFormFromFile(0x00000800, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Clean     = (Game.GetFormFromFile(0x00000813, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Dirt1     = (Game.GetFormFromFile(0x0000080D, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Dirt2     = (Game.GetFormFromFile(0x0000080E, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Dirt3     = (Game.GetFormFromFile(0x0000080F, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Dirt4     = (Game.GetFormFromFile(0x0000083B, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Blood1    = (Game.GetFormFromFile(0x00000810, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Blood2    = (Game.GetFormFromFile(0x00000811, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Blood3    = (Game.GetFormFromFile(0x00000812, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Blood4    = (Game.GetFormFromFile(0x0000083A, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_Spell_Blood4    = (Game.GetFormFromFile(0x0000083A, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_NPCEffect_Blood1  = (Game.GetFormFromFile(0x00000840, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_NPCEffect_Blood2  = (Game.GetFormFromFile(0x0000083F, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_NPCEffect_Blood3  = (Game.GetFormFromFile(0x0000081D, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_NPCEffect_Blood4  = (Game.GetFormFromFile(0x0000081E, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_NPCEffect_Blood5  = (Game.GetFormFromFile(0x0000081F, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		Dirty_CleaningEffectNPC = (Game.GetFormFromFile(0x0000085F, "Dirt and Blood - Dynamic Visuals.esp") As Spell)
		has_DaB = true
	else
		Dirty_Soap = None
		Dirty_SoapEffectSpell = None
		Dirty_Spell_Clean = None
		Dirty_Spell_Dirt1 = None
		Dirty_Spell_Dirt2 = None
		Dirty_Spell_Dirt3 = None
		Dirty_Spell_Dirt4 = None
		Dirty_Spell_Blood1 = None
		Dirty_Spell_Blood2 = None
		Dirty_Spell_Blood3 = None
		Dirty_Spell_Blood4 = None
		Dirty_NPCEffect_Blood1 = None
		Dirty_NPCEffect_Blood2 = None
		Dirty_NPCEffect_Blood3 = None
		Dirty_NPCEffect_Blood4 = None
		Dirty_NPCEffect_Blood5 = None
		Dirty_CleaningEffect = None
		Dirty_CleaningEffectNPC = None
		has_DaB = false
	endif
	If (Game.GetModByName("WetFunction.esp") != 255)
		LogTrace("WetFunction Found!")
		WetReduxSpell = (Game.GetFormFromFile(0x0000182C, "WetFunction.esp") As Spell)
		WetReduxMCM = (Game.GetFormFromFile(0x00000800, "WetFunction.esp") As Form)
	else
		WetReduxSpell = None
		WetReduxMCM = None
	endif
	If (Game.GetModByName("WetandCold.esp") != 255) && (Game.GetModByName("DOMWetandCold.esp") != 255)
		LogTrace("WetAndCold Found!")
		WetNPCDripSpell = (Game.GetFormFromFile(0x00000800, "DOMWetandCold.esp") As Spell)
	else
		WetNPCDripSpell = None
	endif
EndFunction


; Bathing interface

Function CleanDirt(Actor akTarget, bool UsedSoap)
	akTarget.ClearExtraArrows()
	;SPE_ObjectRef.RemoveDecals(DirtyActor, true)
	DOMSexlab.ClearCum(akTarget)
	if has_DaB ; dirt and blood
		bool isPlayer = (akTarget == PlayerRef)
		if isPlayer
			akTarget.RemoveSpell(Dirty_SoapEffectSpell)
			akTarget.RemoveSpell(Dirty_Spell_Dirt1)
			akTarget.RemoveSpell(Dirty_Spell_Dirt2)
			akTarget.RemoveSpell(Dirty_Spell_Dirt3)
			akTarget.RemoveSpell(Dirty_Spell_Dirt4)
			akTarget.RemoveSpell(Dirty_Spell_Blood1)
			akTarget.RemoveSpell(Dirty_Spell_Blood2)
			akTarget.RemoveSpell(Dirty_Spell_Blood3)
			akTarget.RemoveSpell(Dirty_Spell_Blood4)
			akTarget.RemoveSpell(Dirty_CleaningEffect)
			akTarget.AddSpell(Dirty_Spell_Clean)
		else
			akTarget.RemoveSpell(Dirty_SoapEffectSpell)
			akTarget.RemoveSpell(Dirty_NPCEffect_Blood1)
			akTarget.RemoveSpell(Dirty_NPCEffect_Blood2)
			akTarget.RemoveSpell(Dirty_NPCEffect_Blood3)
			akTarget.RemoveSpell(Dirty_NPCEffect_Blood4)
			akTarget.RemoveSpell(Dirty_NPCEffect_Blood5)
			akTarget.RemoveSpell(Dirty_CleaningEffectNPC)	
		endIf
	endif 
	If !has_BiS ; BiS renewed or origin
		return
	endif
	;mzinInterfaceFadeTats.FadeTats(Init.FadeTats_API, DirtyActor, UsedSoap, Menu.FadeTatsFadeTime, Menu.FadeTatsSoapMult, Init.IsFadeTattoosInstalled)
	int BiS_CleanActorDirtEvent = ModEvent.Create("BiS_CleanActorDirt")
    If (BiS_CleanActorDirtEvent)
		ModEvent.PushForm(BiS_CleanActorDirtEvent, akTarget)
		ModEvent.PushFloat(BiS_CleanActorDirtEvent, 10.0)
		ModEvent.PushFloat(BiS_CleanActorDirtEvent, 0.25)
		ModEvent.PushBool(BiS_CleanActorDirtEvent, UsedSoap)
        ModEvent.Send(BiS_CleanActorDirtEvent)
    EndIf
EndFunction

MiscObject Function TryFindWashProp(Actor akTarget)
	Int WashPropIndex
	MiscObject WashProp
	if WashPropList != None ; Bathing in Skyrim is installed
		WashPropIndex = WashPropList.GetSize()
		While WashPropIndex > 0
			WashPropIndex -= 1
			WashProp = WashPropList.GetAt(WashPropIndex) As MiscObject
			If WashProp!= None && akTarget.GetItemCount(WashProp) > 0
				return WashProp
			endif		
		EndWhile
	endif
	if SBBATHSoapItemList != None ; Keep it clean is installed
		WashPropIndex = SBBATHSoapItemList.GetSize()
		While WashPropIndex > 0
			WashPropIndex -= 1
			WashProp = SBBATHSoapItemList.GetAt(WashPropIndex) As MiscObject
			If WashProp!= None && akTarget.GetItemCount(WashProp) > 0
				return WashProp
			endif		
		EndWhile
	endif	
	if Dirty_Soap != None && akTarget.GetItemCount(Dirty_Soap) > 0
		return Dirty_Soap
	endif	
	if akTarget.GetItemCount(soap01) > 0
		return soap01
	endif	
	return None
EndFunction

bool Function ApplyWashPropSpell(Actor akTarget, MiscObject Soap)
	Spell BatheAttemptSpell = None
	; Try Bathing in Skyrim
	if BatheAttemptSpellList != None && useBiS
		LogTrace("ApplyWashPropSpell: Bathing in Skyrim is installed and used for animations")
		int idx = BiS_GetWashPropIndex(Soap)
		if idx >= 0
			BatheAttemptSpell = BatheAttemptSpellList.GetAt(idx) As Spell
		endif
		if BatheAttemptSpell == None
			BatheAttemptSpell = DefaultBatheAttemptSpell
		endif
		LogTrace("ApplyWashPropSpell: calling Bathing in Skyrim spell="+BatheAttemptSpell)
		akTarget.AddSpell(BatheAttemptSpell)
		Utility.Wait(1.0)
		akTarget.RemoveSpell(BatheAttemptSpell)
		return true
	endif
	return false
EndFunction

Function ApplySoapBonus(Actor akTarget, MiscObject Soap)
	if Soap == None
		return
	endif
	; Bathing in Skyrim
	if SoapBonusSpellList != None
		int idx = BiS_GetWashPropIndex(Soap)
		if idx >= 0
			Spell SoapBonusSpell = SoapBonusSpellList.GetAt(idx) As Spell
			akTarget.AddSpell(SoapBonusSpell, false)
			return
		endif
	endif
	; Keep it Clean
	if SoapBonusSpellList != None
		int idx = KiC_GetWashPropIndex(Soap)
		if idx >= 0
			Spell SoapBonusSpell = SBSoapSpellFLST.GetAt(idx) As Spell
			akTarget.AddSpell(SoapBonusSpell, false)
			return
		endif
	endif
EndFunction

Function SetSoapy(Actor akTarget)
	If GetSoapyStyleFollowers != None ; Bathing in Skyrim is installed 
		LogTrace("SetSoapy: using effect from Bathing in Skyrim")
		If GetSoapyStyleFollowers.GetValue() == 1
			akTarget.AddSpell(SoapyAppearanceSpell, false)
		elseIf GetSoapyStyleFollowers.GetValue() == 2
			akTarget.AddSpell(SoapyAppearanceAnimatedSpell, false)
		endif
		return
	endif
	if SBBATHAnimatedSoapShader != None ; Keep it Clean is installed 
		LogTrace("SetSoapy: using effect from Keep it Clean")
		if (SBBATHAnimatedSoapShader.GetValue() as Int) == 1
			akTarget.AddSpell(SBBathSoapAnimationSpell, false)
		else
			akTarget.AddSpell(SBBathSoapNoAnimationSpell, false)
		endif
		return
	endif
	if Dirty_SoapEffectSpell != None
		LogTrace("SetSoapy: using effect from Dirt and Blood")
		akTarget.AddSpell(Dirty_SoapEffectSpell, false)
		return
	endif
EndFunction

Function SetUnsoapy(Actor akTarget)
	If GetSoapyStyleFollowers != None ; Bathing in Skyrim is installed 
		If akTarget.HasSpell(SoapyAppearanceSpell)
			akTarget.RemoveSpell(SoapyAppearanceSpell)
		elseIf akTarget.HasSpell(SoapyAppearanceAnimatedSpell)
			akTarget.RemoveSpell(SoapyAppearanceAnimatedSpell)
		endif
	endif
	if SBBATHAnimatedSoapShader != None ; Keep it Clean is installed 
		If akTarget.HasSpell(SBBathSoapAnimationSpell)
			akTarget.RemoveSpell(SBBathSoapAnimationSpell)
		elseIf akTarget.HasSpell(SBBathSoapNoAnimationSpell)
			akTarget.RemoveSpell(SBBathSoapNoAnimationSpell)
		endif
	endif
	if Dirty_SoapEffectSpell != None ; Dirt and Blood is installed
		If akTarget.HasSpell(Dirty_SoapEffectSpell)
			akTarget.RemoveSpell(Dirty_SoapEffectSpell)
		endif
	endif
EndFunction

; Bathing in Skyrim functions

int Function BiS_GetWashPropIndex(MiscObject Soap)
	if Soap == None
		return -1 ; no soap
	endif
	; Bathing in Skyrim
	; 0 dragon's tongue
	; 1 dwemer
	; 2 blue foral
	; 3 lavender
	; 4 purple floral
	; 5 superior floral
	; 6 red floral
	; 7 plain soap
	; 8 wash rag
	; 9 spriggan
	if Soap == soap01 || Soap == Dirty_Soap
		return 7 ; plain soap index
	endif
	int WashPropIndex
	if WashPropList != None ; Bathing in Skyrim is installed
		WashPropIndex = WashPropList.GetSize()
		while WashPropIndex
			WashPropIndex -= 1		
			if WashPropList.GetAt(WashPropIndex) As MiscObject == Soap
				return WashPropIndex
			endif		
		endwhile
	endif
	
	return -1 ; no soap found
EndFunction

; Keep it clean soap

int Function KiC_GetWashPropIndex(MiscObject Soap)
	if Soap == None
		return -1 ; no soap
	endif
	; Keep it clean
	; 0 plain soap
	; 1 red mountain
	; 2 purple mountain
	; 3 blue mountain
	; 4 superior mountain
	; 5 lavender
	; 6 dragon's tongue
	if Soap == soap01 || Soap == Dirty_Soap
		return 0 ; plain soap index
	endif
	int WashPropIndex
	if SBBATHSoapItemList != None ; Keep it Clean is installed
		WashPropIndex = SBBATHSoapItemList.GetSize()
		while WashPropIndex
			WashPropIndex -= 1		
			if SBBATHSoapItemList.GetAt(WashPropIndex) As MiscObject == Soap
				return WashPropIndex
			endif		
		endwhile
	endif
	
	return -1 ; plain soap
EndFunction

; Wet Function redux interface

Function SetWetness(Actor akTarget, float value)
	if WetReduxSpell == None
		LogTrace("SetWetness: Wet Function redux is not installed")
		return
	endif
	float wetnessCap = StorageUtil.GetFloatValue(WetReduxMCM, "wetnessCap")
	value = value*wetnessCap
	StorageUtil.SetFloatValue(akTarget, "WetFunction_Actor_wetness", value) ; default max wetness is 10.0 for Wet Function redux
	StorageUtil.SetFloatValue(akTarget, "WetFunction_Actor_wetnessRate", 0.0) ; to be set for the spell to start
	float amount = StorageUtil.GetFloatValue(akTarget, "WetFunction_Actor_wetness")
	;LogTrace("SetWetness: Applying wet effect to actor "+akTarget.GetDisplayName()+" amount="+amount+" cap="+wetnessCap+" spell="+WetReduxSpell)
	if value > 0.0
		if !akTarget.HasSpell(WetReduxSpell)
			akTarget.AddSpell(WetReduxSpell)
		endif
	elseif akTarget.HasSpell(WetReduxSpell)
		akTarget.RemoveSpell(WetReduxSpell)
	endif
	;Wait(1.0)
	;amount = StorageUtil.GetFloatValue(akTarget, "WetFunction_Actor_wetness")
	;LogTrace("SetWetness: Applying wet effect to actor "+akTarget.GetDisplayName()+" amount="+amount+" hasSpell="+akTarget.HasSpell(WetReduxSpell))	
EndFunction

; Wet and Cold interface

Function SetDrip(Actor akTarget)
	if WetNPCDripSpell == None
		LogTrace("SetDrip: Wet and Cold or DOM W&C interface is not installed ")
		return
	endif
	if akTarget.HasSpell(WetNPCDripSpell)
		return
	endif
	;LogTrace("SetDrip: Applying drip effect to actor "+akTarget.GetDisplayName()+" spell="+WetNPCDripSpell)
	akTarget.AddSpell(WetNPCDripSpell)
EndFunction

Function UnsetDrip(Actor akTarget)
	if WetNPCDripSpell == None
		LogTrace("UnsetDrip: Wet and Cold or DOM W&C interface is not installed ")
		return
	endif
	if !akTarget.HasSpell(WetNPCDripSpell)
		return
	endif
	;LogTrace("UnsetDrip: Removing drip effect from actor "+akTarget.GetDisplayName()+" spell="+WetNPCDripSpell)
	akTarget.RemoveSpell(WetNPCDripSpell)
EndFunction

; Water places


bool Function isInWaterfall(Actor akTarget)
	Form the_waterfall = Game.FindClosestReferenceOfAnyTypeInListFromRef(DOMWaterfallList,akTarget,500.0) ; 150 = 2m
	if the_waterfall == None
		LogTrace("isInWaterfall: false")
		return false
	endif
	LogTrace("isInWaterfall: true "+the_waterfall.GetName())
    return true
EndFunction

bool Function isInShower(Actor akTarget)
	Location loc = akTarget.GetCurrentLocation()
	if loc == None
		return false
	endif
	if LocTypeShowerInInns != None && loc.haskeyword(LocTypeShowerInInns)
		return true
	endif
    return false
EndFunction

bool Function isInWater(Actor akTarget)
	Form the_water = Game.FindClosestReferenceOfAnyTypeInListFromRef(DOMWaterList,akTarget,150.0) ; 150 = 2m
	if the_water == None
		LogTrace("isInWater: false")
		return false
	endif
 	LogTrace("isInWater: true "+the_water.GetName())
   return true
EndFunction

;  NPC Shower

Function DoNPCShower(Actor akTarget)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	bool has_water = false
	bool has_shower = false
	string wash_type
	string actorObjective = "her"
	int actorSex = akTarget.GetLeveledActorBase().GetSex()
	if actorSex == 0
		actorObjective = "him"
	endif
	; Check waterfall and water objects
	if isInWaterfall(akTarget)
		HudNotification(name+" will shower under the waterfall")
		has_water = true
		has_shower = true
		wash_type = "waterfall"
	elseif isInShower(akTarget)
		HudNotification(name+" will shower under the shower")
		has_water = true
		has_shower = true
		wash_type = "shower"
	elseif isInWater(akTarget)
		HudNotification(name+" will clean "+actorObjective+"self in water")
		has_water = true
		wash_type = "bath"
	elseif PO3_SKSEFunctions.IsActorUnderwater(akTarget)
		if akTarget.IsSwimming()
			HudNotification(name+" needs to be standing in water to bathe, not swimming!")
			return
		endif
		HudNotification(name+" will clean "+actorObjective+"self under water")
		has_water = true
		wash_type = "bath"
	elseif PO3_SKSEFunctions.IsActorInWater(akTarget)
		HudNotification(name+" will clean "+actorObjective+"self in the water")
		has_water = true
		wash_type = "bath"
	else
		HudNotification("There is no water here for "+name+" to clean "+actorObjective+"self")
		return
	endif

	DOMCore.DOMKeys.DOMDoNPCUnDress(akTarget)
	MiscObject the_soap = TryFindWashProp(akTarget)
	bool has_soap = (the_soap != None)
	CalmActorFast(akTarget)
	if has_soap
		Debug.SendAnimationEvent(akTarget,"DOMBatheF_S1_Soap") ; clean armpits and crotch 
	else
		Debug.SendAnimationEvent(akTarget,"DOMBatheF_S1_Rag")
	endif
	if ApplyWashPropSpell(akTarget,the_soap) ; try to call Bathing in Skyrim
		return 
	endif
	
	; Do cleaning
	CleanDirt(akTarget,has_soap)
	If has_soap
		SetSoapy(akTarget)
	endif
	float mod = GetModifierFromFaction(akTarget,DOMCore.DOMModPerfectionism)/100.0
	float timer = 2.0+mod
	if (actorSex%2) == 1 ; female
		if has_soap
			Debug.SendAnimationEvent(akTarget,"DOMBatheF_S1_Soap") ; clean armpits and crotch 
			SetDrip(akTarget)
			Utility.Wait(timer)
			SetDrip(akTarget)
			Utility.Wait(timer)
			Debug.SendAnimationEvent(akTarget,"DOMBatheF_S3_Soap") ; clean armpits and ass
			SetDrip(akTarget)
			Utility.Wait(timer)
			if has_shower
				Debug.SendAnimationEvent(akTarget,"DOMBatheF_S2_Soap") ; clean hair loose soap shower rince
				SetDrip(akTarget)
				Utility.Wait(timer)
				SetDrip(akTarget)
				SetUnSoapy(akTarget)
				Utility.Wait(timer)
			endif
			ApplySoapBonus(akTarget, the_soap)
		else
			Debug.SendAnimationEvent(akTarget,"DOMBatheF_S1_Rag")
			SetDrip(akTarget)
			Utility.Wait(timer)
			SetDrip(akTarget)
			Utility.Wait(timer)
			Debug.SendAnimationEvent(akTarget,"DOMBatheF_S3_Rag")
			SetDrip(akTarget)
			Utility.Wait(timer)
			if has_shower
				Debug.SendAnimationEvent(akTarget,"DOMBatheF_S2_Rag")
				SetDrip(akTarget)
				Utility.Wait(timer)
				SetDrip(akTarget)
				Utility.Wait(timer)
			endif
		endif
	else
		if has_soap
			Debug.SendAnimationEvent(akTarget,"DOMBatheM_S1_Soap") ; clean arms
			SetDrip(akTarget)
			Utility.Wait(timer)
			Debug.SendAnimationEvent(akTarget,"DOMBatheM_S2_Soap") ; clean legs
			SetDrip(akTarget)
			Utility.Wait(timer)
			Debug.SendAnimationEvent(akTarget,"DOMBatheM_S3_Soap") ; clean ass
			SetDrip(akTarget)
			SetUnSoapy(akTarget)
			Utility.Wait(timer)
			ApplySoapBonus(akTarget, the_soap)
		else
			Debug.SendAnimationEvent(akTarget,"DOMBatheM_S1_Rag")
			SetDrip(akTarget)
			Utility.Wait(timer)
			Debug.SendAnimationEvent(akTarget,"DOMBatheM_S2_Rag")
			SetDrip(akTarget)
			Utility.Wait(timer)
			Debug.SendAnimationEvent(akTarget,"DOMBatheM_S3_Rag")
			SetDrip(akTarget)
			Utility.Wait(timer)
		endif
	endif

	SetUnSoapy(akTarget)
	SetDrip(akTarget)
	Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
	DOMCore.DOMKeys.DOMDoNPCDressUp(akTarget)
	Utility.Wait(timer)
	UnSetDrip(akTarget)
EndFunction


; Save positions of actors before animation
float[] __anim_pos_ref
float[] Property anim_pos_ref
	float[] Function Get()
		if !__anim_pos_ref
			__anim_pos_ref = new float[6]
		endif
		return __anim_pos_ref
	EndFunction
EndProperty

float[] __anim_pos_other
float[] Property anim_pos_other
	float[] Function Get()
		if !__anim_pos_other
			__anim_pos_other = new float[6]
		endif
		return __anim_pos_other
	EndFunction
EndProperty

Function SavePositions(Actor akRef, Actor akTarget)
	anim_pos_ref[0] = akRef.GetPositionX()
	anim_pos_ref[1] = akRef.GetPositionY()
	anim_pos_ref[2] = akRef.GetPositionZ()
	anim_pos_ref[3] = akRef.GetAngleX()
	anim_pos_ref[4] = akRef.GetAngleY()
	anim_pos_ref[5] = akRef.GetAngleZ()

	if akTarget != None
		anim_pos_other[0] = akTarget.GetPositionX()
		anim_pos_other[1] = akTarget.GetPositionY()
		anim_pos_other[2] = akTarget.GetPositionZ()
		anim_pos_other[3] = akTarget.GetAngleX()
		anim_pos_other[4] = akTarget.GetAngleY()
		anim_pos_other[5] = akTarget.GetAngleZ()
	else
		anim_pos_other[0] = 0.0
		anim_pos_other[1] = 0.0
		anim_pos_other[2] = 0.0
		anim_pos_other[3] = 0.0
		anim_pos_other[4] = 0.0
		anim_pos_other[5] = 0.0
	endif
EndFunction

Function RestorePositions(Actor akRef, Actor akTarget)
	akRef.SetPosition(anim_pos_ref[0], anim_pos_ref[1], anim_pos_ref[2])
	akRef.SetAngle(anim_pos_ref[3], anim_pos_ref[4], anim_pos_ref[5])
	if akTarget != None
		if akTarget != PlayerRef || DOM_Anim.doPlayerAnim
			akTarget.SetPosition(anim_pos_other[0], anim_pos_other[1], anim_pos_other[2])
			akTarget.SetAngle(anim_pos_other[3], anim_pos_other[4], anim_pos_other[5])
		endif
	endif
EndFunction

Function DoNPCBathMe(Actor akTarget)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	string wash_type
	string actorObjective = "her"
	int actorSex = akTarget.GetLeveledActorBase().GetSex()
	if actorSex == 0
		actorObjective = "him"
	endif

	Actor akAnotherActor = PlayerRef
	DOMCore.DOMKeys.DOMDoNPCUnDress(akTarget)
	MiscObject the_soap = TryFindWashProp(akTarget)
	if the_soap == None
		the_soap = TryFindWashProp(akAnotherActor)
	endif
	bool has_soap = (the_soap != None)
	CalmActorFast(akTarget)
	if has_soap
		Debug.SendAnimationEvent(akTarget,"DOMBatheF_S1_Soap") ; clean armpits and crotch 
	else
		Debug.SendAnimationEvent(akTarget,"DOMBatheF_S1_Rag")
	endif
	if ApplyWashPropSpell(akTarget,the_soap) ; try to call Bathing in Skyrim
		return 
	endif
	
	; Do cleaning
	CleanDirt(akTarget,has_soap)
	If has_soap
		SetSoapy(akTarget)
	endif
	float mod = GetModifierFromFaction(akTarget,DOMCore.DOMModPerfectionism)/100.0
	float timer = 2.0+mod
	
	ObjectReference DualAnimationMarker = akAnotherActor.PlaceAtMe(DOMCore.XMarkerForm)
	if akAnotherActor == PlayerRef && Game.GetCameraState() == 0
		Game.ForceThirdPerson()
	endif
	DOM_Anim.ClearActors(akTarget,akAnotherActor)
	DualAnimationMarker.Enable()
	SavePositions(akTarget,akAnotherActor)
	DOM_Anim.StartDualAnim(DualAnimationMarker,akTarget,akAnotherActor,0.0,0.0)
	DOM_Anim.PlayDualAnim(DualAnimationMarker,akTarget,akAnotherActor,"DOMwash_Anubsadult_bath_A2_S1","DOMwash_Anubsadult_bath_A1_S1")
	SetDrip(akAnotherActor)
	Utility.wait(timer)
	DOM_Anim.PlayDualAnim(DualAnimationMarker,akTarget,akAnotherActor,"DOMwash_Anubsadult_bath_A2_S1","DOMwash_Anubsadult_bath_A1_S1")
	SetDrip(akAnotherActor)
	If has_soap
		SetSoapy(akAnotherActor)
		ApplySoapBonus(akAnotherActor, the_soap)
	endif
	Utility.wait(timer)
	DOM_Anim.PlayDualAnim(DualAnimationMarker,akTarget,akAnotherActor,"DOMwash_Anubsadult_bath_A2_S1","DOMwash_Anubsadult_bath_A1_S1")
	SetDrip(akAnotherActor)
	SetDrip(akTarget)
	CleanDirt(akTarget,has_soap)
	If has_soap
		SetSoapy(akTarget)
		ApplySoapBonus(akTarget, the_soap)
	endif
	Utility.wait(timer)
	If has_soap
		SetUnSoapy(akAnotherActor)
	endif
	SetDrip(akAnotherActor)
	SetDrip(akTarget)
	DOM_Anim.PlayDualAnim(DualAnimationMarker,akTarget,akAnotherActor,"DOMwash_Anubsadult_bath_A2_S1","DOMwash_Anubsadult_bath_A1_S1")
	Utility.wait(timer)
	DOM_Anim.EndDualAnim(akTarget,akAnotherActor)
	
	if (Game.GetModByName("_GSPoses.esp") != 255) ; needs GSPose
		Debug.SendAnimationEvent(akTarget,"GS319")
		Utility.wait(timer)
	endif

	If has_soap
		SetUnSoapy(akTarget)
	endif
	SetDrip(akAnotherActor)
	SetDrip(akTarget)
	
	SetUnSoapy(akAnotherActor)
	SetUnSoapy(akTarget)
	SetDrip(akTarget)
	Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
	DOMCore.DOMKeys.DOMDoNPCDressUp(akTarget)
	Utility.Wait(timer)
	UnSetDrip(akAnotherActor)
	UnSetDrip(akTarget)
	
	RestorePositions(akTarget,akAnotherActor)
	if DualAnimationMarker != NONE
		DualAnimationMarker.Delete()
		DualAnimationMarker = NONE
	endif
EndFunction

; Utilities

Function HudNotification(string msg)
	Debug.Notification(msg)
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Bathing: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_Bathing: "+msg)
	endif
EndFunction
