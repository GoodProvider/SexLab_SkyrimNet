Scriptname DW_SL extends Quest

DW_CORE CORE  ; Local variable, not a property
DW_SLA Property SLA Auto

Quest ActorsQuest

Event OnInit()
  Quest coreQuest = Quest.GetQuest("DW_Dripping")
  if !coreQuest
    Debug.Trace("DW: [SL] OnInit - Failed to get DW_Dripping quest")
    return
  endif
  CORE = coreQuest as DW_CORE
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif

  ; Pre-initialize commonly used forms
  if CORE.Plugin_Appr2
    ActorsQuest = Game.GetFormFromFile(0x02902C, "Apropos2.esp") as Quest
  endif

  Utility.Wait(1.0)  ; Reduced from 5.0 to 1.0
  
  if !SLA
    Debug.Trace("DW: [SL] OnInit - SLA property not linked")
  endif
endEvent

Function MinAI_RegisterEvent(string eventLine, string eventType)
  int handle = ModEvent.Create("MinAI_RegisterEvent")
  if handle
    ModEvent.PushString(handle, eventLine)
    ModEvent.PushString(handle, eventType)
    ModEvent.Send(handle)
  endif
endFunction

Function MinAI_RequestResponse(string eventLine, string eventType, string targetName)
  int handle = ModEvent.Create("MinAI_RequestResponse")
  if handle
    ModEvent.PushString(handle, eventLine)
    ModEvent.PushString(handle, eventType)
    ModEvent.PushString(handle, targetName)
    ModEvent.Send(handle)
  endif
endFunction

Event OStimManager(string eventName, string _args, float numArg, Form sender)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if !CORE.Plugin_OStim
    return
  endif
  if eventName == "ostim_actor_orgasm"
    Orgasm(sender as Actor, _args)
    return
  endif
  int ostimTid = numArg as int
  if eventName == "ostim_thread_start"
    SendModEvent("DW_AnimationStart")
    Actor akActor = CORE.PlayerRef
    if OActor.IsInOstim(akActor)
      CORE.DW_bAnimating.SetValue(1)
    endif
  elseif eventName == "ostim_thread_scenechanged"

    ; Process virginity checks
    ProcessVirginityChecks(ostimTid)
  elseif eventName == "ostim_thread_end"
    SendModEvent("DW_AnimationEnd")
    if CORE.Plugin_OLactis
      SendModEvent("OLactis.Cleanup")
    endif
    CORE.DW_bAnimating.SetValue(0)
    Actor player = CORE.PlayerRef
  endif
endEvent

Function ProcessVirginityChecks(int ostimTid)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if !CORE.DW_ModState13.GetValue() == 1 || !CORE.Plugin_OStim
    return
  endif
  Actor[] actors = OThread.GetActors(ostimTid)
  string ostimScene = OThread.GetScene(ostimTid)
  if !actors || actors.Length < 2
    return
  endif

  ; Note: In OStim, actors[0] is male, actors[1] is female
  int vaginal = OMetadata.FindActionForTarget(ostimScene, 1, "vaginalsex")
  if CORE.GetGender(actors[0]) == 0 && CORE.GetGender(actors[1]) == 1 && vaginal != -1
    ProcessVirginity(actors[1], actors[0], true)
  endif
endFunction

Function ProcessVirginity(Actor passiveActor, Actor activeActor, bool isOStim)

  ; Early returns for invalid cases
  if !passiveActor || !activeActor
    return
  endif

	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  
  if !CORE.IsAVirgin(passiveActor)
    return
  endif
  
  ; Check vaginal wear state
  if ActorsQuest && DW_Appr2.GetVaginalWearState0to10(passiveActor, ActorsQuest) > 6
    simulateDamagedVagina(passiveActor)
  endif
  
  ; Handle player virginity loss
  if passiveActor == CORE.PlayerRef && CORE.DW_bPlayerIsVirgin.GetValue() == 1
    debug.Notification("$DW_VIRGINITYLOST")
    CORE.DW_bPlayerIsVirgin.SetValue(0)
    CORE.DW_PlayerVirginityLoss.SetValue(CORE.DW_PlayerVirginityLoss.GetValue() + 1)
    CORE.Log("Player lost virginity")

  ; Handle player claiming NPC virginity
  elseif activeActor == CORE.PlayerRef
    debug.Notification("$DW_VIRGINSCLAIMED")
    CORE.DW_VirginsClaimed.AddForm(passiveActor)
    CORE.DW_VirginsClaimedTG.AddForm(passiveActor)
    CORE.Log("Player claimed virginity of " + CORE.GetActorName(passiveActor))
    ProcessVirginityMilestones()
  endif
  
  ; Add to virgins list and apply effects
  CORE.DW_VirginsList.AddForm(passiveActor)
  CORE.DW_DrippingBlood_Spell.cast(passiveActor)
  CORE.Log("Added " + CORE.GetActorName(passiveActor) + " to VirginsList and triggered blood effect")
  
  ; Handle MinAI notifications
  if CORE.Plugin_MinAI
    MinAI_RequestResponse(CORE.GetActorName(passiveActor) + " just lost her virginity to " + CORE.GetActorName(activeActor) + "!", "chatnf_sex", "everyone")
  endif
endFunction

; Process virginity milestones
Function ProcessVirginityMilestones()
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if CORE.DW_ModState15.GetValue() != 1
    return
  endif
  int count = CORE.DW_VirginsClaimedTG.GetSize()
  if count == 1
    debug.Notification("$DW_FIRSTBLOOD")
  elseif count == 5
    debug.Notification("$DW_POWERPLAY")
  elseif count == 10
    debug.Notification("$DW_BRUTALITY")
  elseif count == 15
    debug.Notification("$DW_DOMINATION")
  elseif count == 25
    debug.Notification("$DW_ANNIHILATION")
  endif
endFunction

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if !CORE.Plugin_SL
    return
  endif
  Quest SexLabQuest = Quest.GetQuest("SexLabQuestFramework")
  if SexLabQuest
    SexLabFramework SexLab = SexLabQuest as SexLabFramework
    Actor[] actors = SexLab.HookActors(_args)    
    if actors && actors.Length > 0
      int idx = 0
      while idx < actors.Length
        Orgasm(actors[idx], _args)
        idx += 1
      endwhile
    endif
  endif
endEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int Thread)
  Actor akActor = ActorRef as Actor
  if akActor
    Orgasm(akActor, Thread as String)
  endif
endEvent

Function Orgasm(Actor akActor, String _args)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if !CORE.Plugin_SL && !CORE.Plugin_OStim
    return
  endif

  ; SQUIRT EFFECT - highest priority, process immediately
  int squirtState = CORE.GetNPCEffectState(akActor, "squirt")
  bool processSquirt = false
  
  if squirtState == 1  ; Override enabled
    processSquirt = true
  elseif squirtState == 0  ; Override disabled
    processSquirt = false
  else  ; No override (-1), use global settings
    processSquirt = CORE.DW_ModState03.GetValue() == 1 && \
                   ((CORE.DW_bUseSLGenderForSquirt.GetValue() == 1 && CORE.GetGender(akActor) == 1) || \
                    (akActor.GetActorBase().GetSex() == 1 && CORE.DW_bUseSLGenderForSquirt.GetValue() != 1))
  endif
  
  if processSquirt
    int Chance
    if CORE.DW_bSquirtChanceArousal.GetValue() != 1
      Chance = CORE.DW_SquirtChance.GetValue() as int
    else
      Chance = SLA.GetActorArousal(akActor)
    endif
    if Utility.RandomInt(0, 100) <= Chance

      ; Cast squirt spell immediately without any waits
      CORE.DW_DrippingSquirt_Spell.cast(akActor)
      if CORE.Plugin_MinAI
        MinAI_RegisterEvent(CORE.GetActorName(akActor) + " climaxed so hard she squirted!", "info_sexscene")
      endif
    endif
  endif
  
  ; MILK LEAK EFFECT - process after squirt
  int nippleState = CORE.GetNPCEffectState(akActor, "nipple")
  bool processMilk = false
  
  if nippleState == 1  ; Override enabled
    processMilk = true
  elseif nippleState == 0  ; Override disabled
    processMilk = false
  else  ; No override (-1), use global settings
    processMilk = akActor.GetActorBase().GetSex() == 1 && \
                 ((CORE.DW_ModState16.GetValue() == 1 && akActor == CORE.PlayerRef) || \
                  (CORE.DW_ModState17.GetValue() == 1 && akActor != CORE.PlayerRef))
  endif
  
  if processMilk
    if CORE.Plugin_OLactis
      int duration = 6
      int level = 0
      int orgasms = 1      
      if CORE.Plugin_OStim
        orgasms = OActor.GetTimesClimaxed(akActor)
        duration = (2 * orgasms + 3)
        if orgasms > 5
          level = Utility.RandomInt(0, 2)
        elseif orgasms == 5
          level = 2
        elseif orgasms == 1
          level = 0
        else
          level = Utility.RandomInt(0, 1)
        endif
      endif
      int eventID = ModEvent.Create("OLactis.Lactating")
      if eventID
        ModEvent.PushForm(eventID, akActor as Form)
        ModEvent.PushInt(eventID, duration)
        ModEvent.PushInt(eventID, level)
        ModEvent.Send(eventID)
        CORE.Log("Sent Oninus Lactis lactation event for " + akActor.GetDisplayName(),"SL")
      else
        CORE.Log("Failed to create Oninus Lactis ModEvent.", "SL")
        CORE.DW_Milkleak_Spell.cast(akActor)
      endif
    else
      CORE.DW_Milkleak_Spell.cast(akActor)
    endif
    if CORE.Plugin_MinAI
      MinAI_RegisterEvent("Arousal and stimulation are causing milk to leak from " + CORE.GetActorName(akActor) + "'s nipples", "info_sexscene")
    endif
  endif
  
  ; CUM LEAK EFFECT - process third
  int cumState = CORE.GetNPCEffectState(akActor, "cum")
  if cumState == 1  ; Override enabled
    ProcessCumLeakEffect(akActor, _args)
  elseif cumState == 0  ; Override disabled
    ; Do nothing, effect is disabled
  else  ; No override (-1), use global settings
    if CORE.DW_ModState02.GetValue() == 1
      ProcessCumLeakEffect(akActor, _args)
    endif
  endif
endFunction

Function ProcessCumLeakEffect(Actor akActor, String _args)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if CORE.Plugin_OStim
    ProcessOStimCumLeak(akActor)
  elseif CORE.Plugin_SL
    ProcessSexLabCumLeak(akActor, _args)
  endif
endFunction

Function ProcessOStimCumLeak(Actor akActor)
  int ostimTid = OActor.GetSceneID(akActor)
  Actor[] actors = OThread.GetActors(ostimTid)
  if !actors || actors.Length < 2
    return
  endif  
  string ostimScene = OThread.GetScene(ostimTid)
  int vaginal = OMetadata.FindActionForTarget(ostimScene, 1, "vaginalsex")
  int anal = OMetadata.FindActionForTarget(ostimScene, 1, "analsex")  
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if CORE.GetGender(actors[0]) == 0 && (vaginal != -1 || anal != -1) && akActor != actors[0]
    if actors[0].GetActorBase().GetSex() != 1 || actors[0].HasKeyword(CORE.TNG_Gentlewoman)
      CORE.DW_DrippingCum_Spell.cast(actors[1])      
      if CORE.Plugin_MinAI
        MinAI_RegisterEvent(CORE.GetActorName(actors[1]) + " is leaking " + CORE.GetActorName(actors[0]) + "'s cum down their thighs", "info_sexscene")
        ProcessTNGBleedingEffect(actors[0], actors[1])
      endif
    endif
  endif
endFunction

Function ProcessSexLabCumLeak(Actor akActor, String _args)
  Quest SexLabQuest = Quest.GetQuest("SexLabQuestFramework")
  if !SexLabQuest
    return
  endif  
  SexLabFramework SexLab = SexLabQuest as SexLabFramework
  Actor[] actors = SexLab.HookActors(_args)  
  if !actors || actors.Length < 2
    return
  endif  
  sslBaseAnimation animation = SexLab.HookAnimation(_args)
  if !(animation.HasTag("Anal") || animation.HasTag("Vaginal")) || akActor == actors[0]
    return
  endif  
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if CORE.GetSOS(actors[1]) == true || actors[1].GetActorBase().GetSex() != 1
    CORE.DW_DrippingCum_Spell.cast(actors[0])    
    if CORE.Plugin_MinAI
      MinAI_RegisterEvent(CORE.GetActorName(actors[0]) + " is leaking " + CORE.GetActorName(actors[1]) + "'s cum down their thighs", "info_sexscene")
      ProcessTNGBleedingEffect(actors[1], actors[0])
    endif
  endif
endFunction

Function ProcessTNGBleedingEffect(Actor giver, Actor receiver)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if !CORE.Plugin_TNG
    return
  endif
  
  ; Check if giver has an XL size
  int TNG_Size = TNG_PapyrusUtil.GetActorSize(giver)
  bool isXLSize = giver.HasKeyword(CORE.TNG_XL) || TNG_Size == 4
  
  if !isXLSize
    return
  endif
  
  ; Check for NPC-specific override
  int bloodState = CORE.GetNPCEffectState(receiver, "blood")
  
  ; Apply bleeding effects based on override state
  if bloodState == 0
    return  ; Override disabled - do nothing
  elseif bloodState == 1 || (bloodState == -1 && CORE.DW_ModState13.GetValue() == 1)

    ; Apply blood effects
    CORE.DW_DrippingBlood_Spell.cast(receiver)
    
    ; Check for vaginal damage
    if ActorsQuest && DW_Appr2.GetVaginalWearState0to10(receiver, ActorsQuest) > 6
      simulateDamagedVagina(receiver)
    endif
    
    ; Register MinAI event if available
    if CORE.Plugin_MinAI
      MinAI_RegisterEvent(CORE.GetActorName(receiver) + " is bleeding from being ripped open by " + CORE.GetActorName(giver) + "'s enormous cock", "info_sexscene")
    endif
  endif
endFunction

Function simulateDamagedVagina(Actor akActor)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
	if akActor != None 
		if CORE.DW_VirginsList.HasForm(akActor)
			CORE.DW_VirginsList.RemoveAddedForm(akActor)
			debug.Trace(akActor.GetActorBase().GetName() +" vagina damaged")
		endif
		if akActor == CORE.PlayerRef
			debug.Trace("PC vagina damaged")
		endif
	endif
endFunction

Event OnSexLabStageChange(String _eventName, String _args, Float _argc, Form _sender)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
    if CORE.Plugin_SL
        Quest SexLabQuest = Quest.GetQuest("SexLabQuestFramework")
        if (SexLabQuest)
            SexLabFramework SexLab = SexLabQuest as SexLabFramework
            Actor[] actors = SexLab.HookActors(_args)
            sslBaseAnimation animation = SexLab.HookAnimation(_args)
            
            if CORE.DW_ModState13.GetValue() == 1 && animation.HasTag("Vaginal") && actors.Length > 1

                ; Note: In SexLab, actors[0] is female, actors[1] is male
                If ((CORE.GetSOS(actors[1]) == true || SexLab.Config.UseStrapons == true) || actors[1].GetActorBase().GetSex() != 1) && actors[0].GetActorBase().GetSex() == 1
                    ProcessVirginity(actors[0], actors[1], false)
                endif
            endif
        endif
    endif
endEvent

Event OnAnimationStart(string eventName, string strArg, float numArg, Form sender)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if CORE.Plugin_SL
    SendModEvent("DW_AnimationStart")
    Quest SexLabQuest = Quest.GetQuest("SexLabQuestFramework")
    if (SexLabQuest)
      SexLabFramework SexLab = SexLabQuest as SexLabFramework
      sslThreadController thread = SexLab.GetController(strArg as int)
      if thread.HasPlayer == true
        Actor akActor = CORE.PlayerRef
        CORE.DW_bAnimating.SetValue(1)
      endif
    endif
  endif
endEvent

Event OnAnimationEnd(string eventName, string strArg, float numArg, Form sender)
	  if CORE == None
		if Game.GetModByName("DW.esp") != 255
			return
		endif
		CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
		if CORE == None
			return
		endif
	  endif
  if CORE.Plugin_SL
    SendModEvent("DW_AnimationEnd")
    Quest SexLabQuest = Quest.GetQuest("SexLabQuestFramework")
    if (SexLabQuest)
      SexLabFramework SexLab = SexLabQuest as SexLabFramework      
      sslThreadController thread = SexLab.GetController(strArg as int)
      if thread.HasPlayer == true
        CORE.DW_bAnimating.SetValue(0)
      endif
    endif

;    if CORE.Plugin_OLactis
;      Int eventID = ModEvent.Create("OLactis.Cleanup")
;      ModEvent.Send(eventID)
;    endif
  endif
endEvent