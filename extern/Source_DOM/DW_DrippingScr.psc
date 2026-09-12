Scriptname DW_DrippingScr extends ReferenceAlias

DW_CORE Property CORE Auto
DW_DDi Property DDi Auto
DW_zbf Property zbf Auto

Actor Property PlayerRef Auto

float lastLocationChangeTime = 0.0
float lastScanTime = 0.0
string scriptInfo = ""

Event OnInit()
  if !CORE
    Debug.Trace("DW: [DrippingScr] OnInit - CORE not found")
    return
  endif
  
  Debug.Trace("DW: Installing Dripping When Aroused NG")
  Debug.Notification("Installing Dripping When Aroused NG")
  CORE.OnAliasReady(DDi, zbf)
  RegisterForSingleUpdate(0.2)
endEvent

Event OnPlayerLoadGame()
  scriptInfo = "DrippingScr"
  if CORE && PlayerRef
    CORE.Startup()
    ; Remove all effect spells from player for a clean start
    PlayerRef.RemoveSpell(CORE.DW_Breath_Spell)
    PlayerRef.RemoveSpell(CORE.DW_Heart_Spell)
    PlayerRef.RemoveSpell(CORE.DW_Visuals_Spell)
    Utility.Wait(1.0)
    lastScanTime = Utility.GetCurrentRealTime()
    lastLocationChangeTime = Utility.GetCurrentRealTime()
    SendModEvent("DW_ProcessEffectsNow")
    RegisterForSingleUpdate(0.2)
    CORE.Log("OnPlayerLoadGame - Complete", scriptInfo)
  endif
endEvent

Event OnUpdate()
  if !CORE || !CORE.SLA
    Debug.Trace("DW: [DrippingScr] OnUpdate - CORE not found")
    RegisterForSingleUpdate(1.0)  ; Try again in a second if refs not ready
    return
  endif

  if !PlayerRef
    CORE.Log("OnUpdate - Player not found", scriptInfo)
    return
  endif
  
  if CORE.DW_Effects_Spell == None
		CORE.DW_Effects_Spell = Game.GetFormFromFile(0x860, "DW.esp") As Spell
  endif
  ; Add effects spell if not already present
  if !PlayerRef.HasSpell(CORE.DW_Effects_Spell)
    CORE.Log("OnUpdate - Initializing Player effects spell", scriptInfo)
    PlayerRef.AddSpell(CORE.DW_Effects_Spell, false)
  endif
  
  ; Explicitly manage breath spell based on toggle
  if CORE.DW_Breath_Spell == None
		CORE.DW_Breath_Spell = Game.GetFormFromFile(0x88E, "DW.esp") As Spell
  endif
  if CORE.DW_ModState08.GetValue() == 1
    if !PlayerRef.HasSpell(CORE.DW_Breath_Spell)
      CORE.Log("OnUpdate - Initializing Player breathing effects", scriptInfo)
      PlayerRef.AddSpell(CORE.DW_Breath_Spell, false)
      RegisterForSingleUpdate(0.2) ; Schedule a quick follow-up to ensure effect is reapplied promptly
      return
    endif
  else
    if PlayerRef.HasSpell(CORE.DW_Breath_Spell)
      CORE.Log("OnUpdate - Removing Player breathing effects (toggle off)", scriptInfo)
      PlayerRef.RemoveSpell(CORE.DW_Breath_Spell)
      RegisterForSingleUpdate(0.2) ; Schedule a quick follow-up to ensure removal is processed
      return
    endif
  endif
  
  if CORE.DW_Heart_Spell == None
		CORE.DW_Heart_Spell = Game.GetFormFromFile(0x88D, "DW.esp") As Spell
  endif
 if CORE.DW_ModState06.GetValue() == 1 && !PlayerRef.HasSpell(CORE.DW_Heart_Spell)
    CORE.Log("OnUpdate - Initializing Player heartbeat effects", scriptInfo)
    PlayerRef.AddSpell(CORE.DW_Heart_Spell, false)
  endif
  
  if CORE.DW_Visuals_Spell == None
		CORE.DW_Visuals_Spell = Game.GetFormFromFile(0x88F, "DW.esp") As Spell
  endif
  ; Visuals spell logic: only do work if at least one visuals toggle is enabled
  if CORE.DW_ModState05.GetValue() == 1 || CORE.DW_ModState07.GetValue() == 1
    float rank = CORE.SLA.GetActorArousal(PlayerRef)
    bool animating = CORE.DW_ModState09.GetValue() == 1 && CORE.DW_bAnimating.GetValue() == 1
    if (CORE.DW_ModState05.GetValue() == 1 && rank >= CORE.DW_effects_heavy.GetValue()) || (CORE.DW_ModState07.GetValue() == 1 && rank >= CORE.DW_effects_light.GetValue())
      if !PlayerRef.HasSpell(CORE.DW_Visuals_Spell) && !animating
        CORE.Log("OnUpdate - Initializing Player visual effects", scriptInfo)
        PlayerRef.AddSpell(CORE.DW_Visuals_Spell, false)
      endif
    else
      if PlayerRef.HasSpell(CORE.DW_Visuals_Spell)
        CORE.Log("OnUpdate - Removing Player visual effects (toggles off or arousal too low)", scriptInfo)
        PlayerRef.RemoveSpell(CORE.DW_Visuals_Spell)
      endif
    endif
  else
    if PlayerRef.HasSpell(CORE.DW_Visuals_Spell)
      CORE.Log("OnUpdate - Removing Player visual effects (both toggles off)", scriptInfo)
      PlayerRef.RemoveSpell(CORE.DW_Visuals_Spell)
    endif
  endif

  float now = Utility.GetCurrentRealTime()
  if now - lastScanTime > 20.0 && now - lastLocationChangeTime > 20.0
    CORE.ScanForBreathers()
    lastScanTime = now
  endif

  ; Schedule next update using MCM timer setting
  float updateInterval = CORE.DW_Timer.GetValue()
  if updateInterval < 10.0
    updateInterval = 10.0  ; Minimum 10 seconds between updates
  endif
  RegisterForSingleUpdate(updateInterval)
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
  Actor akActor = GetActorRef()
  if !akActor || !CORE
    return
  endif
  bool hasDDi = (DDi != None)
  bool hasZBF = (zbf != None)
  if !hasDDi && !hasZBF
    CORE.Log("OnObjectUnequipped - No gag detection interfaces available", scriptInfo)
    return
  endif
  bool isWearingGag = false
  if hasDDi && DDi.IsWearingDDGag(akActor)
    isWearingGag = true
  endif
  if !isWearingGag && hasZBF && zbf.IsWearingZaZGag(akActor)
    isWearingGag = true
  endif
  if !isWearingGag && akActor.HasSpell(CORE.DW_DrippingGag_Spell)
    akActor.RemoveSpell(CORE.DW_DrippingGag_Spell)
  endif
endEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  string oldLocName = "Unknown"
  string newLocName = "Unknown"
  if akOldLoc
    oldLocName = akOldLoc.GetName()
  endif
  if akNewLoc
    newLocName = akNewLoc.GetName()
  endif
  CORE.Log("Location change detected - From: " + oldLocName + ", To: " + newLocName, scriptInfo)
  lastLocationChangeTime = Utility.GetCurrentRealTime()
EndEvent