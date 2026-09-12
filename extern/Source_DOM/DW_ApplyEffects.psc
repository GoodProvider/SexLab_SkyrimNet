scriptname DW_ApplyEffects extends ActiveMagicEffect

DW_CORE Property CORE Auto

Actor targetRef
ActorBase targetBase
bool isCleaningUp = false ; Prevent recursive cleanup
int dripSex
float lastDripTime = 0.0
float lastGagTime = 0.0
float lastProcessTime = 0.0
string scriptInfo = ""
string targetName = "unknown"

Event OnEffectStart(Actor akTarget, Actor akCaster)
  if IsCleaningUp || !self || !(self as activemagiceffect) || !akTarget
    return
  endif

  targetRef = akTarget
  
  if !targetRef
    CORE.Log("[ApplyEffects] OnEffectStart - Target is None, terminating instance")
    isCleaningUp = true
    return
  endif
  
  int formID = targetRef.GetFormID()
  int timePart = (Utility.GetCurrentRealTime() * 100) as int % 10000
  scriptInfo = "ApplyEffects_" + formID + "_" + timePart  ; Format: "Breath_FormID_Timestamp"
  
  if IsCleaningUp || !self || !(self as activemagiceffect) || !targetRef
    CORE.Log("OnEffectStart - Script or target invalid, cannot retrieve target name, terminating instance", scriptInfo)
    isCleaningUp = true
    targetRef = None
    return
  else
    targetBase = targetRef.GetActorBase()
    if targetBase
      targetName = targetBase.GetName()
      if CORE.DW_bUseSLGenderForDripp.GetValue() == 1
        dripSex = CORE.GetGender(targetRef)
      else
        dripSex = targetBase.GetSex()
      endif
    endif
  endif
  
  float randomDelay = 0.2 + CORE.GetRandomDelay()/2.0
  CORE.Log("OnEffectStart - Created instance for " + targetName + " (delay start for " + randomDelay + " seconds)", scriptInfo)
  Utility.Wait(randomDelay)  ; Stagger start times

  if IsCleaningUp || !self || !(self as activemagiceffect) || !targetRef || !CORE.IsTargetValid(targetRef)
    CORE.Log("OnEffectStart - Script or target invalid before registration for " + targetName, scriptInfo)
    isCleaningUp = true
    targetRef = None
    return
  else
    RegisterForModEvent("DW_ProcessEffectsNow", "OnProcessEffectsNow")
    ProcessEffects(false)
  endif

  ; Schedule next update with minimal initial delay
  float initialDelay = CORE.DW_SpellsUpdateTimer.GetValue()/2.0 + 0.5
  if IsCleaningUp || !self || !(self as activemagiceffect) || !targetRef
    CORE.Log("OnEffectStart - Skipping Update Registration - Script or target invalid: " + targetName, scriptInfo)
    isCleaningUp = true
    targetRef = None
    return
  else
    RegisterForSingleUpdate(initialDelay)
  endif
EndEvent

Event OnUpdate()
  ; Primary check for self validity first
  if !self || !(self as activemagiceffect)
    ; If self is invalid, we cannot proceed or log scriptInfo, just return
    return
  endif
  
  ; Now check cleanup flag and targetRef
  if isCleaningUp || !targetRef
    if targetRef == None
      ; Log if targetRef is None, as this is part of the invalid state we're trying to catch
      CORE.Log("OnUpdate - Early exit due to cleaningUp or targetRef is None for: " + targetName, scriptInfo)
    endif
    return
  endif

  if !CORE.IsTargetValid(targetRef)
    CORE.Log("OnUpdate - Target invalid: " + targetName, scriptInfo)
    isCleaningUp = true
    targetRef = None
    return
  else
    if !isCleaningUp && self && (self as activemagiceffect) && targetRef
      ProcessEffects(true)
    endif
  endif

  ; Schedule next update if still valid
  float nextUpdateTime = CORE.DW_SpellsUpdateTimer.GetValue() + CORE.GetRandomDelay()

  ; One last validity check before registering next update
  if isCleaningUp || !self || !(self as activemagiceffect) || !targetRef
    if targetRef
      CORE.Log("OnUpdate - Cleaning up invalid state for: " + targetName, scriptInfo)
    else
      CORE.Log("OnUpdate - Cleaning up invalid state (no target)", scriptInfo)
    endif
    isCleaningUp = true
    targetRef = None
    return
  else
    RegisterForSingleUpdate(nextUpdateTime)
  endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
  ; Primary check for self validity first
  if !self || !(self as activemagiceffect)
    ; If self is invalid, we cannot proceed or log scriptInfo, just return
    return
  endif
  
  ; Now check cleanup flag
  if isCleaningUp
    CORE.Log("OnEffectFinish - Skipping due to cleaningUp flag for: " + targetName, scriptInfo)
    return
  endif

  if targetRef
    CORE.Log("OnEffectFinish - Script is cleaning up for " + targetName, scriptInfo)
  else
    CORE.Log("OnEffectFinish - Script is cleaning up (target is None) for: " + targetName, scriptInfo)
  endif
  
  isCleaningUp = true
  targetRef = None
EndEvent

Event OnProcessEffectsNow(string eventName, string strArg, float numArg, Form sender)
  ; Critical: First check for cleanup state or missing references
  if isCleaningUp || !self || !(self as activemagiceffect)
    return
  endif
  
  ; Check for valid target
  if !targetRef
    CORE.Log("OnProcessEffectsNow - No valid target", scriptInfo)
    isCleaningUp = true
    return
  endif

  ; Verify target is still valid
  if !CORE.IsTargetValid(targetRef)
    CORE.Log("OnProcessEffectsNow - Target invalid: " + targetName, scriptInfo)
    isCleaningUp = true
    targetRef = None
    return
  endif
  
  ; Process the effects
  CORE.Log("OnProcessEffectsNow - Processing effects for " + targetName, scriptInfo)
  ProcessEffects(false)
EndEvent

Function ProcessEffects(bool checkTimers = true)
  ; Skip processing if we're already cleaning up
  if IsCleaningUp || !self || !(self as activemagiceffect) || !targetRef
    return
  endif

  ; Check if target is valid before processing
  if !CORE.IsTargetValid(targetRef)
    CORE.Log("ProcessEffects - Invalid target: " + targetName, scriptInfo)
    return
  endif

  ; Get current time for timer checks
  float currentTime = Utility.GetCurrentRealTime()
  
  ; Revalidate before processing dripping effects
  if IsCleaningUp || !self || !(self as activemagiceffect) || !targetRef || !CORE.IsTargetValid(targetRef)
    CORE.Log("ProcessEffects - Skipping dripping effects - Invalid state for: " + targetName, scriptInfo)
    return
  endif
  
  ; Process dripping effects
  if !isCleaningUp && targetRef && CORE.SLA && CORE.SL
    float arousal = CORE.SLA.GetActorArousal(targetRef)
	if CORE.DW_DripThreshold == None
		CORE.DW_DripThreshold = Game.GetFormFromFile(0x8AD, "DW.esp") As GlobalVariable
	endif
    float arousalThreshold = CORE.DW_DripThreshold.GetValue()
    if !checkTimers || (currentTime - lastDripTime) > 45.0
      ; Check for NPC-specific override first
      int dripState = CORE.GetNPCEffectState(targetRef, "drip")
      if targetRef && dripState == 1  ; Override enabled
        if !IsCleaningUp && targetRef && arousal >= arousalThreshold && !targetRef.HasSpell(CORE.DW_Dripping_Spell)
          CORE.Log("ProcessEffects - Applying drip effect for " + targetName + " (override enabled and arousal threshold met)", scriptInfo)
          CORE.DW_Dripping_Spell.cast(targetRef)
          lastDripTime = currentTime
        endif
      elseif targetRef && dripState == 0  ; Override disabled
        if targetRef.HasSpell(CORE.DW_Dripping_Spell)
          CORE.Log("ProcessEffects - Removing drip effect for " + targetName + " (override disabled)", scriptInfo)
          targetRef.RemoveSpell(CORE.DW_Dripping_Spell)
        endif
      else  ; No override, use global settings
        if targetRef && CORE.DW_ModState01.GetValue() == 1
          if dripSex == 1
            if !IsCleaningUp && self && (self as activemagiceffect) && CORE.IsTargetValid(targetRef) && arousal >= arousalThreshold && !targetRef.HasSpell(CORE.DW_Dripping_Spell)
              CORE.Log("ProcessEffects - Applying drip effect for " + targetName + " (global settings)", scriptInfo)
              CORE.DW_Dripping_Spell.cast(targetRef)
              lastDripTime = currentTime
            endif
          endif
        endif
      endif
    endif
  endif
  
  ; Revalidate before processing gag effects
  if IsCleaningUp || !self || !(self as activemagiceffect) || !targetRef || !CORE.IsTargetValid(targetRef)
    CORE.Log("ProcessEffects - Skipping gag effects - Invalid state for: " + targetName, scriptInfo)
    return
  endif
  
  ; Process gag effects
  if !IsCleaningUp && targetRef && CORE.DW_DrippingGag_Spell && CORE.DDi && CORE.zbf
    if !checkTimers || (currentTime - lastGagTime) > 8.0
      ; Check for NPC-specific override first
      int gagState = CORE.GetNPCEffectState(targetRef, "gag")
      if targetRef && gagState == 1  ; Override enabled
        if CORE.DDi.IsWearingDDGag(targetRef) || CORE.zbf.IsWearingZaZGag(targetRef)
          CORE.Log("ProcessEffects - Applying gag effect for " + targetName + " (override enabled)", scriptInfo)  
          if !IsCleaningUp && targetRef
            CORE.DW_DrippingGag_Spell.cast(targetRef)
            lastGagTime = currentTime
          endif
        endif
      elseif gagState == 0  ; Override disabled
        ; Do nothing, effect is disabled
      else  ; No override, use global settings
        if targetRef && CORE.DW_ModState04.GetValue() == 1
          if CORE.DDi.IsWearingDDGag(targetRef) || CORE.zbf.IsWearingZaZGag(targetRef)
            CORE.Log("ProcessEffects - Applying gag effect for " + targetName + " (global settings)", scriptInfo)
            if !IsCleaningUp && targetRef
              CORE.DW_DrippingGag_Spell.cast(targetRef)
              lastGagTime = currentTime
            endif
          endif
        endif
      endif
    endif
  endif

  ; Let CORE handle breath effects - with double validation
  if IsCleaningUp || !self || !(self as activemagiceffect) || !targetRef || !CORE.IsTargetValid(targetRef)
    CORE.Log("ProcessEffects - Skipping ManageNPCEffects - Invalid state for: " + targetName, scriptInfo)
    return
  else
    CORE.ManageNPCEffects(targetRef)
  endif
EndFunction