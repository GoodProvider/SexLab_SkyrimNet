Scriptname DW_SLA extends Quest

DW_CORE CORE  ; Local variable, not a property
Faction slaArousal
  
Event OnInit()
  Quest coreQuest = Quest.GetQuest("DW_Dripping")
  if coreQuest
    CORE = coreQuest as DW_CORE
  else
    Debug.Trace("DW: [SLA] OnInit - Failed to get DW_Dripping quest")
  endif
endEvent

int Function GetActorArousal(Actor akActor)
  if !akActor
    return 0
  endif
  if CORE == None
	if Game.GetModByName("DW.esp") != 255
		return 0
	endif
	CORE = Game.GetFormFromFile(0x862, "DW.esp") As DW_CORE
	if CORE == None
		return 0
	endif
  endif
  if !CORE.Plugin_SLAR
	return 0
  endif
  if slaArousal == None
	;Sexlab Aroused or OSL Aroused
	slaArousal = Game.GetFormFromFile(0x3FC36, "SexLabAroused.esm") As Faction
  endif

  int rank = akActor.GetFactionRank(slaArousal)
  if rank > 0
     return rank
  endif
  return 0
EndFunction