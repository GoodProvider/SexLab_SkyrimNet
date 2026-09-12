Scriptname DW_CORE extends Quest

Import Debug
Import Utility
Import JsonUtil
Import PapyrusUtil
Import PO3_SKSEFunctions

DW_SL Property SL Auto
DW_SLA Property SLA Auto
DW_DDi Property DDi Auto
DW_zbf Property zbf Auto

Bool Property Plugin_DD = false Auto
Bool Property Plugin_DoM = false Auto
Bool Property Plugin_ZaZ = false Auto
Bool Property Plugin_SOS = false Auto
Bool Property Plugin_TNG = false Auto
Bool Property Plugin_MinAI = false Auto
Bool Property Plugin_Appr2 = false Auto
Bool Property Plugin_OLactis = false Auto
Bool Property Plugin_OStim = false Auto     ;OStim
Bool Property Plugin_SL = false Auto        ;Sexlab
Bool Property Plugin_SLAR = false Auto      ;Sexlab Aroused

FormList Property DW_NonVirginNPCList Auto
FormList Property DW_VirginsList Auto
FormList Property DW_VirginsClaimed Auto
FormList Property DW_VirginsClaimedTG Auto

GlobalVariable Property DW_ModState00 Auto     ; NPC Breathing effect
GlobalVariable Property DW_ModState01 Auto     ; Arousal Dripping effect
GlobalVariable Property DW_ModState02 Auto     ; Cum effect
GlobalVariable Property DW_ModState03 Auto     ; Squirt effect
GlobalVariable Property DW_ModState04 Auto     ; Gag effect
GlobalVariable Property DW_ModState05 Auto     ; Heavy Visuals effect
GlobalVariable Property DW_ModState06 Auto     ; Heartbeat effect
GlobalVariable Property DW_ModState07 Auto     ; Light Visuals effect
GlobalVariable Property DW_ModState08 Auto     ; Breathing effect
GlobalVariable Property DW_ModState09 Auto     ; Visuals Disable during SL animation
GlobalVariable Property DW_ModState10 Auto     ; Player Sound Disable during SL animation
GlobalVariable Property DW_ModState11 Auto     ; Heartbeat Sound volume max/arousal based
GlobalVariable Property DW_ModState12 Auto     ; Breath Sound volume max/arousal based
GlobalVariable Property DW_ModState13 Auto     ; Virginity loss effect
GlobalVariable Property DW_ModState14 Auto     ; NPC Sound Disable during SL animation
GlobalVariable Property DW_ModState15 Auto     ; Virginity game messages
GlobalVariable Property DW_ModState16 Auto     ; PC Milkleak effect
GlobalVariable Property DW_ModState17 Auto     ; NPC Milkleak effect

GlobalVariable Property DW_Timer Auto
GlobalVariable Property DW_SpellsUpdateTimer Auto
GlobalVariable Property DW_PluginsCheck Auto
GlobalVariable Property DW_bAnimating Auto
GlobalVariable Property DW_effects_heavy Auto
GlobalVariable Property DW_effects_light Auto
GlobalVariable Property DW_DripThreshold Auto
GlobalVariable Property DW_bUseSLGenderForBreath Auto
GlobalVariable Property DW_bUseSLGenderForDripp Auto
GlobalVariable Property DW_bUseSLGenderForSquirt Auto
GlobalVariable Property DW_SquirtChance Auto
GlobalVariable Property DW_bSquirtChanceArousal Auto
GlobalVariable Property DW_bSLStatsIgnore Auto
GlobalVariable Property DW_bPlayerIsVirgin Auto
GlobalVariable Property DW_PlayerVirginityLoss Auto
GlobalVariable Property DW_MaxActiveNPCSounds Auto  ; Maximum number of NPCs that can have active sound effects
GlobalVariable Property DW_ActiveSlotCount Auto  ; Current number of active NPC sound slots
GlobalVariable Property DW_DebugMessages Auto  ; Toggle for verbose debug messages

ImageSpaceModifier Property HighArousalVisual Auto
ImageSpaceModifier Property LowArousalVisual Auto

Sound Property Breathing1 Auto              ;F Low
Sound Property Breathing2 Auto              ;F High
Sound Property Breathing3 Auto              ;M Low
Sound Property Breathing4 Auto              ;M High
Sound Property Heartbeat1 Auto              ;Low
Sound Property Heartbeat2 Auto              ;High

SPELL Property DW_Effects_Spell Auto
SPELL Property DW_Dripping_Spell Auto
SPELL Property DW_DrippingCum_Spell Auto
SPELL Property DW_DrippingBlood_Spell Auto
SPELL Property DW_DrippingSquirt_Spell Auto
SPELL Property DW_DrippingGag_Spell Auto
SPELL Property DW_Breath_Spell Auto
SPELL Property DW_Heart_Spell Auto
SPELL Property DW_Visuals_Spell Auto
SPELL Property DW_Milkleak_Spell Auto

Keyword Property TNG_Gentlewoman Auto
Keyword Property TNG_XL Auto
Keyword Property ActorTypeNPC Auto
Faction Property CurrentFollowerFaction Auto
Faction Property DoMVirginVaginal = None Auto

string npcOverridesFile = "DW/NPCOverrides.json"  ; JSON file for tracking NPC overrides
string actorName = "unknown"
float lastScanTime = 0.0
float[] Property SoundSlotTimers Auto Hidden
Actor[] Property SoundSlotActors Auto Hidden  ; Store which actor owns each slot
Actor Property PlayerRef Auto

Function Startup()
  Debug.Trace("DW: [CORE] Startup called")
  
  ; Initialize sound system at the very beginning
  InitSoundSlotSystem()
  
  ; If already initialized, just log and continue - don't return immediately
  ; This allows the function to run through safely multiple times
  bool alreadyInitialized = (DW_PluginsCheck.GetValue() == 1)
  if alreadyInitialized
    Debug.Trace("DW: [CORE] NOTICE - Redundant Startup called - continuing safely")
  endif
  
  ; Plugin detection - safe to run multiple times
  Plugin_DD = (Game.GetModbyName("Devious Devices - Assets.esm") != 255)
  Plugin_DoM = (Game.GetModbyName("DiaryOfMine.esm") != 255)
  Plugin_ZaZ = (Game.GetModbyName("ZaZAnimationPack.esm") != 255)
  Plugin_SOS = (Game.GetModbyName("Schlongs of Skyrim.esp") != 255)
  Plugin_TNG = (Game.GetModbyName("TheNewGentleman.esp") != 255)
  Plugin_MinAI = (Game.GetModbyName("MinAI.esp") != 255)
  Plugin_Appr2 = (Game.GetModbyName("Apropos2.esp") != 255)
  Plugin_OLactis = (Game.GetModbyName("OninusLactis.esp") != 255)
  Plugin_OStim = (Game.GetModbyName("OStim.esp") != 255)
  Plugin_SL = (Game.GetModbyName("SexLab.esm") != 255)
  Plugin_SLAR = (Game.GetModbyName("SexLabAroused.esm") != 255)
  if Plugin_TNG
    TNG_Gentlewoman = Game.GetFormFromFile(0xFF8, "TheNewGentleman.esp") as Keyword
    TNG_XL = Game.GetFormFromFile(0xFE5, "TheNewGentleman.esp") as Keyword
  endif
  if Plugin_DoM
    DoMVirginVaginal = Game.GetFormFromFile(0x00DB1220, "DiaryOfMine.esm") as Faction
  endif
  DW_PluginsCheck.SetValue(1)
  DW_bAnimating.SetValue(0)
  
  ; Wait for sound system to be fully initialized
  ; This is crucial to prevent loops when processing NPCs
  Utility.Wait(1.0)
  
  ; Always run maintenance functions which are safe to run multiple times

  Maintenance()
  DW_VirginsClaimedTG.Revert()

  ; Remove breath spell from all NPCs
  if DW_Breath_Spell
    if PlayerRef
      ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesWithKeyword(PlayerRef, ActorTypeNPC, 0.0, false)
	  if refs
		int i = 0
		while i < refs.Length
			Actor npc = refs[i] as Actor
			if npc && npc != PlayerRef && npc.HasSpell(DW_Breath_Spell)
			npc.RemoveSpell(DW_Breath_Spell)
			endif
			i += 1
		endwhile
	  endif
    endif
  endif
  
  ; Wait again before processing NPCs
  ; This ensures sound system is fully reset before applying effects
  Utility.Wait(1.0)

  ; Only register events if not already registered
  if !alreadyInitialized
    if Plugin_OStim && SL
      SL.RegisterForModEvent("ostim_thread_start", "OStimManager")
      SL.RegisterForModEvent("ostim_thread_scenechanged", "OStimManager")
      SL.RegisterForModEvent("ostim_thread_speedchanged", "OStimManager")
      SL.RegisterForModEvent("ostim_actor_orgasm", "OStimManager")
      SL.RegisterForModEvent("ostim_thread_end", "OStimManager")
      Debug.Trace("DW: [CORE] OStim events registered")
    endif
    if Plugin_SL && SL
      SL.RegisterForModEvent("OrgasmStart", "OnSexLabOrgasm")
      SL.RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
      SL.RegisterForModEvent("DeviceActorOrgasm", "OnDDOrgasm")
      SL.RegisterForModEvent("AnimationStart", "OnAnimationStart")
      SL.RegisterForModEvent("AnimationEnd", "OnAnimationEnd")
      SL.RegisterForModEvent("StageStart", "OnSexLabStageChange")
      Debug.Trace("DW: [CORE] SexLab events registered")
    endif
    RegisterForModEvent("RestoreVirginity", "RV")
  endif
  RegisterForModEvent("LoadNonVirgins", "OnLoadNonVirgins")
  Log("DW: [CORE] Events registered")
  Utility.Wait(0.2)
  SendModEvent("LoadNonVirgins")
  if SLA
    Debug.Trace("DW: [CORE] Initialization completed successfully")
  else
    Debug.Trace("DW: [CORE] Initialization error - missing SLA reference")
  endif
endFunction

Function Maintenance()
  if DW_effects_heavy == None
	if Game.GetModByName("DW.esp") != 255
		return
	endif
	DW_effects_heavy = Game.GetFormFromFile(0x8A5, "DW.esp") As GlobalVariable
	if DW_effects_heavy == None
		return
	endif
  endif

  if DW_effects_heavy.GetValue() < 0 || DW_effects_heavy.GetValue() >= 100
    DW_effects_heavy.SetValue(66)
  endif
 
  if DW_effects_light == None
	if Game.GetModByName("DW.esp") != 255
		return
	endif
	DW_effects_light = Game.GetFormFromFile(0x8A6, "DW.esp") As GlobalVariable
	if DW_effects_light == None
		return
	endif
  endif
  
  if DW_effects_light.GetValue() < 0 || DW_effects_light.GetValue() >= 100
    DW_effects_light.SetValue(33)
  endif
  if DW_effects_light.GetValue() >= DW_effects_heavy.GetValue() && DW_effects_heavy.GetValue() >= 1
    DW_effects_light.SetValue(DW_effects_heavy.GetValue() - 1)
  endif

  if DW_MaxActiveNPCSounds == None
	if Game.GetModByName("DW.esp") != 255
		return
	endif
	DW_MaxActiveNPCSounds = Game.GetFormFromFile(0x8BD, "DW.esp") As GlobalVariable
	if DW_MaxActiveNPCSounds == None
		return
	endif
  endif
  if DW_MaxActiveNPCSounds.GetValue() <= 0
    DW_MaxActiveNPCSounds.SetValue(18)
  endif
EndFunction

Function OnAliasReady(DW_DDi akDDi, DW_zbf akZbf)
  
  ; Capture references whether we're initialized or not
  if akDDi
    DDi = akDDi
    Debug.Trace("DW: [CORE] DDi reference obtained")
  else
    Debug.Trace("DW: [CORE] OnAliasReady - DW_DDi quest not found")
  endif
  
  if akZbf
    zbf = akZbf
    Debug.Trace("DW: [CORE] zbf reference obtained")
  else
    Debug.Trace("DW: [CORE] OnAliasReady - DW_zbf quest not found")
  endif
  
  ; It's safe to call Startup multiple times
  if DDi && zbf
    Startup()
  else
    Debug.Trace("DW: [CORE] OnAliasReady - Missing references DDi: " + DDi + ", zbf: " + zbf)
  endif
EndFunction

Function ManageNPCEffects(Actor akActor)
  if !akActor || akActor == PlayerRef
    return
  endif
  
  ; Skip if actor's cell is detaching to prevent removal loops
  if !akActor.GetParentCell() || !akActor.GetParentCell().IsAttached()
    return
  endif

  ; Additional validation before adding effects
  if akActor == PlayerRef || !IsTargetValid(akActor)
    return
  endif
  
  actorName = GetActorName(akActor)
  bool shouldHaveBreath = ShouldHaveBreathEffect(akActor)
  bool suppressDuringAnim = DW_ModState14.GetValue() == 1
  bool isActorAnimating = suppressDuringAnim && IsActorAnimating(akActor)
  bool hasActiveSlot = GetActorSoundSlot(akActor) >= 0
  bool hasBreathSpell = akActor.HasSpell(DW_Breath_Spell)
  
  if shouldHaveBreath && !isActorAnimating
    if !akActor.Is3DLoaded()
      Log("[CORE] ManageNPCEffects - Skipping breath spell for " + actorName + " - Actor unloaded")
    else
      ; Only add the spell if they don't already have it AND don't have a sound slot
      ; This prevents duplicate script instances
      if !hasActiveSlot && IsTargetValid(akActor) && !hasBreathSpell
        Log("[CORE] ManageNPCEffects - Adding breath spell to " + actorName)
        akActor.AddSpell(DW_Breath_Spell, false)
      endif
    endif
  elseif !shouldHaveBreath
    if hasBreathSpell
      Log("[CORE] ManageNPCEffects - Removing breath spell from " + actorName)
      akActor.RemoveSpell(DW_Breath_Spell)
    endif
  endif
EndFunction

bool Function ShouldHaveBreathEffect(Actor akActor)
  ; First check for NPC override
  int overrideState = GetNPCEffectState(akActor, "breath")
  if overrideState != -1  ; If override exists
    return overrideState == 1  ; Return true if enabled (1), false if disabled (0)
  endif
  
  ; Normal behavior if no override exists
  int mode = DW_ModState00.GetValueInt()
  if mode <= 0
    return false
  endif
  
  int sex
  if DW_bUseSLGenderForBreath == None
	DW_bUseSLGenderForBreath = Game.GetFormFromFile(0x8C3, "DW.esp") As GlobalVariable
  endif
  if DW_bUseSLGenderForBreath.GetValue() == 1 && Plugin_SL
    sex = GetGender(akActor)
  else
    sex = akActor.GetActorBase().GetSex()
  endif
  
  ; Return true if mode matches sex or is set to "all"
  return (mode == 1 && sex == 1) || (mode == 2 && sex == 0) || mode == 3
EndFunction

; Check if an actor already has an active breath sound
bool Function HasActiveBreathSound(Actor akActor)
  if !akActor
    return false
  endif
  
  ; First check if they have an active slot
  int slotIndex = GetActorSoundSlot(akActor)
  
  ; If they have a slot, they have an active sound
  ; This is more reliable than checking for the spell since the slot
  ; indicates actual active sound playback
  return slotIndex >= 0
EndFunction

Function InitSoundSlotSystem()
  ; This function completely resets the sound slot system
  Log("DW: [CORE] Initializing sound slot system")
  
  ; Create arrays if needed
  if !SoundSlotTimers || SoundSlotTimers.Length == 0
    SoundSlotTimers = new float[50]
    SoundSlotActors = new Actor[50]
  endif
  
  ; Reset all slots
  int i = 0
  while i < SoundSlotTimers.Length
    SoundSlotTimers[i] = 0.0
    SoundSlotActors[i] = None
    i += 1
  endwhile
  
  ; Reset the global counter
  DW_ActiveSlotCount.SetValue(0)
  
  ; Notify any scripts that might be playing sounds to stop
  ;SendModEvent("DW_StopBreathingSounds")
  
  Log("[CORE] Sound system initialized")
EndFunction

; Returns -1 if no slot available, otherwise returns the slot index
int Function TryAllocateSoundSlot(Actor akActor, int priority = -1)
  if !akActor
    Log("[CORE] TryAllocateSoundSlot - No actor specified, cannot allocate slot")
    return -1
  endif

  if akActor == PlayerRef
    Log("[CORE] TryAllocateSoundSlot - Actor is player, skipping slot allocation")
    return -1
  endif

  ; Make sure actor is in a valid state before proceeding
  if !akActor.Is3DLoaded() || akActor.IsDead() || !akActor.GetParentCell() || !akActor.GetParentCell().IsAttached()
    Log("[CORE] TryAllocateSoundSlot - Actor is in invalid state, cannot allocate slot")
    return -1
  endif

  if akActor
    actorName = GetActorName(akActor)
  endif
  Log("[CORE] Starting Slot allocation for " + actorName + " (Current Count: " + DW_ActiveSlotCount.GetValue() as int + ")")

  ; First check if actor already has a slot
  int existingSlot = GetActorSoundSlot(akActor)
  if existingSlot >= 0
    Log("[CORE] Actor " + actorName + " already has slot " + existingSlot)
    return existingSlot
  endif

  float maxSlots = DW_MaxActiveNPCSounds.GetValue()
  if DW_ActiveSlotCount.GetValue() >= maxSlots
    ; Determine the priority to use
    int myPriority = priority
    if myPriority == -1
      myPriority = GetBreathPriorityForActor(akActor)
    endif
    ; Find the lowest-priority slot
    int lowestPriorityIdx = -1
    int lowestPriority = -1
    int i = 0
    while i < SoundSlotActors.Length
      Actor slotActor = SoundSlotActors[i]
      if slotActor != None
        int slotPriority = GetBreathPriorityForActor(slotActor)
        if slotPriority > lowestPriority
          lowestPriority = slotPriority
          lowestPriorityIdx = i
        endif
      endif
      i += 1
    endwhile
    if myPriority < lowestPriority && lowestPriorityIdx != -1
      ReleaseSlot(lowestPriorityIdx)
      float currentCount = DW_ActiveSlotCount.GetValue()
      DW_ActiveSlotCount.SetValue(currentCount + 1)
      SoundSlotTimers[lowestPriorityIdx] = Utility.GetCurrentRealTime()
      SoundSlotActors[lowestPriorityIdx] = akActor
      Log("[CORE] Stealing slot " + lowestPriorityIdx + " from lower-priority actor for " + actorName + " (priority " + myPriority + ")")
      return lowestPriorityIdx
    else
      Log("[CORE] No slots available for " + actorName + " (priority " + myPriority + ") - all slots are equal or higher priority")
      return -1
    endif
  endif

  int slotIndex = FindFirstFreeSlot()
  if slotIndex >= 0
    ; IMPORTANT: Get the current count AFTER FindFirstFreeSlot has run
    ; This ensures we use the corrected count value
    float currentCount = DW_ActiveSlotCount.GetValue()
    
    ; Increment count BEFORE setting the slot time to prevent race conditions
    DW_ActiveSlotCount.SetValue(currentCount + 1)
    
    ; Only now mark the slot as in use after we've incremented the count
    SoundSlotTimers[slotIndex] = Utility.GetCurrentRealTime()
    
    ; Store actor ownership
    SoundSlotActors[slotIndex] = akActor
    Log("[CORE] Allocating Slot " + slotIndex + " for " + actorName + " (New Count: " + (currentCount + 1) as int + ")")
    return slotIndex
  endif
  Log("[CORE] No slots available")
  return -1
EndFunction

; Helper function to get breath priority for a given actor
int Function GetBreathPriorityForActor(Actor akActor)
  if akActor == None
	return 5
  endif
  if akActor.IsInFaction(CurrentFollowerFaction)
    return 0
  endif
  if PlayerRef == None
	PlayerRef = Game.GetPlayer()
  endif
  float actorDistance = akActor.GetDistance(PlayerRef) 
  if actorDistance < 512.0
      return 1
  elseif actorDistance < 1024.0
      return 2
  elseif actorDistance < 2048.0
      return 3
  elseif actorDistance < 4096.0
      return 4
  endif
  return 5
EndFunction

; Find the first available sound slot and clean up expired slots
int Function FindFirstFreeSlot()
  if !SoundSlotTimers || SoundSlotTimers.Length == 0
    InitSoundSlotSystem()
    return 0
  endif
  
  float currentTime = Utility.GetCurrentRealTime()
  int maxSlots = SoundSlotTimers.Length
  int firstEmptySlot = -1
  int activeCount = 0
  int i = 0
  
  ; First pass: Count active slots and find completely empty slots (zero value)
  while i < maxSlots
    float slotTime = SoundSlotTimers[i]
    
    if slotTime == 0.0
      ; Completely empty slot - record it if we haven't found one yet
      if firstEmptySlot == -1
        firstEmptySlot = i
      endif
    elseif slotTime > 0
      ; Active slot - check if expired
      if (currentTime - slotTime) > 50.0
        ; Slot has expired - mark for cleanup
        SoundSlotTimers[i] = 0.0
        SoundSlotActors[i] = None
        
        ; If we haven't found an empty slot yet, use this one
        if firstEmptySlot == -1
          firstEmptySlot = i
        endif
      else
        ; Active and not expired - count it
        activeCount += 1
      endif
    elseif slotTime < 0
      ; Released slot (negative value = release time)
      if (currentTime + slotTime) < -3.0
        ; Released more than 3 seconds ago - fully available
        SoundSlotTimers[i] = 0.0
        SoundSlotActors[i] = None
        if firstEmptySlot == -1
          firstEmptySlot = i
        endif
      endif
      ; Don't count released slots as active regardless of cooldown
    endif
    
    i += 1
  endwhile
  
  ; If current active count doesn't match what we just counted,
  ; update the global to correct any drift
  if DW_ActiveSlotCount.GetValue() as int != activeCount
    DW_ActiveSlotCount.SetValue(activeCount)
    Log("[CORE] FindFirstFreeSlot - Corrected slot count to " + activeCount)
  endif
  
  ; If we found an empty slot and have room for more sounds
  if firstEmptySlot != -1 && activeCount < DW_MaxActiveNPCSounds.GetValue()
    return firstEmptySlot
  endif
  
  ; The max check is now correct based on the global setting
  Log("[CORE] No slots available (Current count: " + activeCount + ", max: " + DW_MaxActiveNPCSounds.GetValue() as int + ")")
  return -1
EndFunction

Function ReleaseSlot(int slotIndex)
  if slotIndex < 0 || slotIndex >= SoundSlotTimers.Length
    Log("[CORE] ReleaseSlot - Invalid slot index: " + slotIndex)
    return
  endif
  
  ; Get current state and time
  float currentTime = Utility.GetCurrentRealTime()
  float slotTime = SoundSlotTimers[slotIndex]
  Actor slotActor = SoundSlotActors[slotIndex]

  ; If slot is already released (zero or negative), we don't need to do anything
  if slotTime <= 0
    ; Still make sure the actor reference is cleared
    SoundSlotActors[slotIndex] = None
    return
  endif
  
  ; Check if slot has expired naturally (older than 50 seconds)
  if slotTime > 0 && (currentTime - slotTime) > 50.0
    SoundSlotTimers[slotIndex] = 0.0
    SoundSlotActors[slotIndex] = None
    if slotActor
      actorName = GetActorName(slotActor)
    endif
    Log("[CORE] ReleaseSlot - Slot " + slotIndex + " for " + actorName + " has expired naturally")
    
    ; Decrement the counter since we're releasing an active slot
    float currentCount = DW_ActiveSlotCount.GetValue()
    if currentCount > 0
      DW_ActiveSlotCount.SetValue(currentCount - 1)
    else
      DW_ActiveSlotCount.SetValue(0)
    endif
    return
  endif
  
  ; Get actor name for logging before clearing reference
  
  if slotActor
    actorName = GetActorName(slotActor)
  endif
  
  ; Make slot immediately available instead of using negative time cooldown
  SoundSlotTimers[slotIndex] = 0.0
  
  ; CRITICAL: Clear the actor reference immediately
  SoundSlotActors[slotIndex] = None
  
  ; Safely decrement the global count, never below zero
  float currentCount = DW_ActiveSlotCount.GetValue()
  if currentCount > 0
    float newCount = currentCount - 1.0
    DW_ActiveSlotCount.SetValue(newCount)
    Log("[CORE] ReleaseSlot - Released slot " + slotIndex + " for " + actorName + " (New Total: " + newCount as int + ")")
  else 
    ; Shouldn't happen but safer to handle
    Log("[CORE] ReleaseSlot - Warning: Tried to release slot " + slotIndex + " for " + actorName + " but count was already 0")
    DW_ActiveSlotCount.SetValue(0)
  endif
EndFunction

; Updates the timestamp for a slot to prevent it from expiring
Function RefreshSlotTimer(int slotIndex)
  if slotIndex < 0 || slotIndex >= SoundSlotTimers.Length
    return
  endif
  
  ; Only refresh if the slot is actually active (positive time)
  if SoundSlotTimers[slotIndex] > 0
    ; Update the timestamp to current time
    SoundSlotTimers[slotIndex] = Utility.GetCurrentRealTime()
  endif
EndFunction

; Check if an actor already has a sound slot allocated
int Function GetActorSoundSlot(Actor akActor)
  if !akActor || !SoundSlotActors
    return -1
  endif
  
  int i = 0
  while i < SoundSlotActors.Length
    ; Check if this slot is assigned to this actor AND is active
    if SoundSlotActors[i] == akActor && SoundSlotTimers[i] > 0
      return i
    endif
    i += 1
  endwhile
  
  return -1
EndFunction

string Function GetActorName(Actor akActor)
  if akActor == PlayerRef
    return akActor.GetActorBase().GetName()
  else
    return akActor.GetDisplayName()
  endif
EndFunction

; Get a random delay between 0-2 seconds in 1/3 second increments
float Function GetRandomDelay()
  ; Returns 0, 0.33, 0.66, 1.0, 1.33, 1.66, 2.0
  return (Utility.RandomInt(0, 6) as float) / 3.0
EndFunction

int Function GetGender(Actor akActor)
  if !akActor
    return -1 ; Invalid actor
  endif
  if Plugin_TNG
    if akActor.GetActorBase().GetSex() == 1 && !akActor.HasKeyword(TNG_Gentlewoman)
      return 1 ; Female
    else
      return 0 ; Male
    endif
  elseif Plugin_SL
    Quest SexLabQuest = Quest.GetQuest("SexLabQuestFramework")
    if SexLabQuest
      SexLabFramework SexLab = SexLabQuest as SexLabFramework
      return SexLab.GetGender(akActor)
    endif
  endif
  return akActor.GetActorBase().GetSex()
endFunction

int Function GetNPCEffectState(Actor akActor, string effectType)
  if !akActor || akActor == PlayerRef || !JsonUtil.IsGood(npcOverridesFile)
    return -1
  endif
  
  string npcName = akActor.GetActorBase().GetName()
  if npcName == ""
    return -1
  endif
  
  int index = JsonUtil.StringListFind(npcOverridesFile, "enabled_npcs", npcName)
  if index == -1
    return -1
  endif
  
  int npcState = JsonUtil.IntListGet(npcOverridesFile, effectType + "_states", index)
  
  ; Add debug logging for drip and breath effects
  if DW_DebugMessages.GetValue() == 1.0
    if effectType == "drip" || effectType == "breath"
      string stateText = "Default"
      if npcState == 1
        stateText = "Enabled"
      elseif npcState == 0
        stateText = "Disabled"
      endif
    endif
  endif
  
  return npcState
EndFunction

int Function GetNPCBreathGender(Actor akActor)
  int effectState = GetNPCEffectState(akActor, "breath")
  if effectState == -1
    return -1
  endif
  
  if effectState == 0  ; Default
    return -1
  elseif effectState == 1  ; Male
    return 0
  elseif effectState == 2  ; Female
    return 1
  else  ; Disable
    return -1
  endif
EndFunction

bool Function GetSOS(Actor akActor)
  if !akActor
    Debug.Trace("DW: [CORE] GetSOS called with None actor")
    return false
  endif
  bool hasSchlong = false
  if Plugin_TNG
    if GetGender(akActor) == 0
      hasSchlong = True
    endif
    return hasSchlong
  endif
  if Plugin_SOS
    Quest sosScriptQuest = Quest.GetQuest("SOS_SetupQuest")
    if sosScriptQuest
      SOS_SetupQuest_Script sosScript = sosScriptQuest as SOS_SetupQuest_Script
      if sosScript
        Faction SOS_SchlongifiedFaction = sosScript.SOS_SchlongifiedFaction
        if SOS_SchlongifiedFaction
          if akActor.IsInFaction(SOS_SchlongifiedFaction)
            Quest addon = sosScript.GetActiveAddon(akActor)
            if addon
              Faction addonFaction = SOS_Data.GetFaction(addon)
              if addonFaction
                ; Check if the addon is in the "NotAPenis" list
                if JsonUtil.StringListFind("/DW/SOS_NotAPenis", "notapenis", addonFaction.getname()) == -1
                  return hasSchlong
                else
                  return akActor.IsInFaction(SOS_SchlongifiedFaction)
                endif
              endif
            endif
            
            ; Default if we can't get addon info but actor is in faction
            return true
          endif
        else
          Debug.Trace("DW: [CORE] GetSOS - SOS_SchlongifiedFaction is None")
        endif
      else
        Debug.Trace("DW: [CORE] GetSOS - Failed to cast SOS_SetupQuest to SOS_SetupQuest_Script")
      endif
    else
      Debug.Trace("DW: [CORE] GetSOS - SOS_SetupQuest not found")
    endif
  endif
  
  ; Default return if no schlong detected through any method
  return hasSchlong
endFunction

bool Function IsTargetValid(Actor akTarget)
  if !akTarget
    Log("[CORE] IsTargetValid - Target is None")
    return false
  endif
  
  if akTarget
    actorName = GetActorName(akTarget)
  endif

  if !akTarget.Is3DLoaded()
    Log("[CORE] IsTargetValid - Target 3D not loaded: " + actorName)
    return false
  endif
  
  if akTarget.IsDead()
    Log("[CORE] IsTargetValid - Target is dead: " + actorName)
    return false
  endif

  return true
EndFunction

bool Function IsActorAnimating(Actor akActor)
  bool isSexLab = false
  bool isOStim = false

  ; SexLab check
  if Plugin_SL
    Quest SexLabQuest = Quest.GetQuest("SexLabQuestFramework")
    if SexLabQuest
      SexLabFramework SexLab = SexLabQuest as SexLabFramework
      if SexLab && SexLab.IsActorActive(akActor)
        isSexLab = true
      endif
    endif
  endif

  ; OStim check
  ; OStim's IsInOStim is a global native function, so we call it directly
  if Plugin_OStim
    if OActor.IsInOStim(akActor)
      isOStim = true
    endif
  endif
  return isSexLab || isOStim
endFunction

bool Function IsAVirgin(Actor akTarget)
  if !akTarget
    return true
  endif

  if Plugin_DoM && DoMVirginVaginal
    if akTarget.GetFactionRank(DoMVirginVaginal) > 1
      return false
    endif
  endif

  ; Get ActorBase for checking against the non-virgin list
  ActorBase akBase = akTarget.GetActorBase()
  
  ; Check against NonVirginNPCList and return early if the NPC should not be a virgin
  if akBase && DW_NonVirginNPCList.HasForm(akBase)
    Log("Skipping virginity check for " + GetActorName(akTarget) + " - found in NonVirginNPCList")
    return false
  endif
  
  ; Check if actor is already in virgins list (has already lost virginity)
  if DW_VirginsList.Find(akTarget) != -1
    Log("Skipping virginity check for " + GetActorName(akTarget) + " - already in VirginsList")
    return false
  endif

  ; SexLab-specific checks for non-player NPCs
  ; Note: SexLab tracks sexual experience, so we check if they've had sex before
  if Plugin_SL && akTarget != PlayerRef
    Quest SexLabQuest = Quest.GetQuest("SexLabQuestFramework")
    if SexLabQuest
      SexLabFramework SexLab = SexLabQuest as SexLabFramework
      if SexLab && SexLab.HadSex(akTarget) && (SexLab.GetSkillLevel(akTarget, "Vaginal") > 0)
        return false
      endif
    endif
  endif
  return true
EndFunction

Function ScanForBreathers()
  if !PlayerRef || !ActorTypeNPC
    Log("ScanForBreathers - PlayerRef or ActorTypeNPC is None, skipping scan", "CORE")
    return
  endif

  ; Track timing to help diagnose performance issues
  float startTime = Utility.GetCurrentRealTime()
  
  ; Try the find function directly with debugging
  ObjectReference[] refs = PO3_SKSEFunctions.FindAllReferencesWithKeyword(PlayerRef, ActorTypeNPC, 2048.0, false)
  
  ; Record how long the call took
  float endTime = Utility.GetCurrentRealTime()
  
  ; Debug info about the results
  if refs
    Log("ScanForBreathers - Found " + refs.Length + " references with keyword in " + (endTime - startTime) + " seconds", "CORE")
  else 
    Log("ScanForBreathers - FindAllReferencesWithKeyword returned None in " + (endTime - startTime) + " seconds", "CORE")
  endif
  
  if !refs
    Log("ScanForBreathers - No references found, possible error", "CORE")
    return
  endif
  
  int i = 0
  int totalShouldHave = 0
  int totalAddSpells = 0
  while i < refs.Length
    Actor npc = refs[i] as Actor
    if npc && npc != PlayerRef
      if IsTargetValid(npc)
        bool shouldHaveBreath = ShouldHaveBreathEffect(npc)
        if shouldHaveBreath
          totalShouldHave += 1
          bool hasSpell = npc.HasSpell(DW_Breath_Spell)
          if !hasSpell
            npc.AddSpell(DW_Breath_Spell, false)
            totalAddSpells += 1
          endif
        endif
      endif
    endif
    i += 1
  endwhile
  Log("[CORE] ScanForBreathers - Found " + refs.Length + " NPCs, " + totalShouldHave + " breath enabled (" + DW_MaxActiveNPCSounds.GetValue() as int + " sound slot limit) - " + totalAddSpells + " breath spells added")
EndFunction

Function RemoveNPCEffects(Actor akActor)
  if !akActor
    return
  endif

  if akActor.HasSpell(DW_Breath_Spell)
    akActor.RemoveSpell(DW_Breath_Spell)
  endif
  if akActor.HasSpell(DW_Dripping_Spell)
    akActor.RemoveSpell(DW_Dripping_Spell)
  endif
  if akActor.HasSpell(DW_DrippingGag_Spell)
    akActor.RemoveSpell(DW_DrippingGag_Spell)
  endif
EndFunction

Function LoadNonVirginNPCListFromJSON()
  ; Ensure the FormList is properly initialized before using it
  if !DW_NonVirginNPCList
    Debug.Trace("DW: [ERROR] NonVirginNPCList FormList is None")
    Log("Failed to load NonVirginNPCList from JSON - FormList property not set")
    return
  endif
  
  ; Clear the FormList first
  DW_NonVirginNPCList.Revert()
  
  ; Double-check that the list is actually empty
  while DW_NonVirginNPCList.GetSize() > 0
    DW_NonVirginNPCList.RemoveAddedForm(DW_NonVirginNPCList.GetAt(0))
  endwhile
  
  string jsonPath = "DW/NonVirginNPCList"
  Log("Loading NonVirginNPCList from JSON (" + jsonPath + ")", "CORE")
  
  ; Force close and reopen the JSON file to prevent caching issues
  JsonUtil.Unload(jsonPath)
  Utility.Wait(0.1)  ; Add a small delay
  
  ; Check if the file exists and reload it
  if !JsonUtil.JsonExists(jsonPath)
    Debug.Trace("DW: [ERROR] JSON file does not exist: " + jsonPath)
    return
  endif
  
  ; Force reload the file from disk
  if !JsonUtil.Load(jsonPath)
    Debug.Trace("DW: [ERROR] Failed to load JSON file: " + jsonPath)
    return
  endif
  
  if !JsonUtil.IsGood(jsonPath)
    Debug.Trace("DW: [ERROR] JSON file is invalid: " + jsonPath)
    return
  endif
  
  ; Get the count of entries
  int count = JsonUtil.PathCount(jsonPath, ".not_a_virgin")
  Log("Found " + count + " entries in NonVirginNPCList JSON", "CORE")
  
  if count > 0
    int i = 0
    int formsAdded = 0
    int batchSize = 12
    int batchCount = 0
    while i < count
      int batchStart = i
      int batchEnd = i + batchSize
      if batchEnd > count
        batchEnd = count
      endif
      while i < batchEnd
        int formID_int = JsonUtil.GetPathIntValue(jsonPath, ".not_a_virgin[" + i + "].actorFormID", 0)
        string modName = JsonUtil.GetPathStringValue(jsonPath, ".not_a_virgin[" + i + "].modName", "<none>")
        string npcName = JsonUtil.GetPathStringValue(jsonPath, ".not_a_virgin[" + i + "].actorName", "<none>")

        if formID_int != 0 && modName != "" && modName != "<none>"
          if Game.GetModByName(modName) != 255
            Form formRef = Game.GetFormFromFile(formID_int, modName)
            if formRef
              ActorBase npcBase = formRef as ActorBase
              if npcBase
                DW_NonVirginNPCList.AddForm(npcBase)
                formsAdded += 1
                Log("NonVirginNPCList loaded " + npcBase.GetName() + " from JSON index " + i + " (" + formID_int + " in " + modName + ")", "CORE")
              else
                Debug.Trace("DW: [DEBUG] Form is not an ActorBase: " + formRef)
              endif
            else
              Debug.Trace("DW: [DEBUG] Failed to get form from file: " + formID_int + " in " + modName)
            endif
          else
            Debug.Trace("DW: [DEBUG] Skipping NPC at index " + i + " because mod is not loaded: " + modName)
          endif
        else
          Debug.Trace("DW: [DEBUG] Invalid formID or modName at index " + i)
        endif
        i += 1
      endwhile
      batchCount += 1
      Log("Batch " + batchCount + ": Processed " + (i as string) + "/" + (count as string) + " NPCs", "CORE")
      Utility.Wait(0.2)
    endwhile
    Log("Successfully loaded " + formsAdded + " NPCs from NonVirginNPCList JSON (" + (count-formsAdded) + " failed to load)", "CORE")
  else
    Debug.Trace("DW: [WARNING] JSON file has 0 entries in not_a_virgin list: " + jsonPath)
    Log("Found 0 entries in NonVirginNPCList")
  endif
EndFunction

Event RV(Form apForm)
  Actor akActor = apForm as Actor
  if akActor != None 
    if DW_VirginsList.HasForm(akActor)
      DW_VirginsList.RemoveAddedForm(akActor)
      Log(akActor.GetActorBase().GetName() + " virginity restored")
    endif
    if akActor == PlayerRef
      DW_bPlayerIsVirgin.SetValue(1)
      Log("PC virginity restored")
    endif
  endif
EndEvent

Function Log(string msg, string scriptInfo = "")
  if DW_DebugMessages == None
	if Game.GetModByName("DW.esp") != 255
		return
	endif
	DW_DebugMessages = Game.GetFormFromFile(0x8BE, "DW.esp") As GlobalVariable
	if DW_DebugMessages == None
		return
	endif
  endif
  if DW_DebugMessages.GetValue() == 1
    if scriptInfo != ""
      Debug.Trace("DW: [" + scriptInfo + "] " + msg)
    else
      Debug.Trace("DW: " + msg)
    endif
  endif
EndFunction

Event OnLoadNonVirgins(string eventName, string strArg, float numArg, Form sender)
  LoadNonVirginNPCListFromJSON()
EndEvent