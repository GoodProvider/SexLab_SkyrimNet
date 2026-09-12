# Code Review: SkyrimNet_SexLab_Decorators.psc

## Summary
Papyrus decorator registration and utility script for SkyrimNet_SexLab. Generally well-structured, but contains logic inconsistencies, incomplete error handling, and dead code.

---

## Issues Ranked by Importance

### 1. HIGH: Misleading Trace Message (Line 65)
**File:** SkyrimNet_SexLab_Decorators.psc  
**Line:** 65  
**Problem:**  
```papyrus
Trace("Outfit_Options",speaker.GetDisplayName()+" has stripped items")
```
The trace message unconditionally states "has stripped items" regardless of whether the condition actually evaluated to true or false. This is misleading for debugging.

**Fix:**  
```papyrus
String result = "undresses"
if main.HasStrippedItems(speaker)
    result = "dresses"
    Trace("Outfit_Options", speaker.GetDisplayName() + " has stripped items, setting to dress mode")
else
    Trace("Outfit_Options", speaker.GetDisplayName() + " has no stripped items, setting to undress mode")
endif
return "{" + '"' + "option" + '"' + ":" + '"' + result + '"' + "}"
```

---

### 2. HIGH: Confusing Variable Initialization (Lines 61-64)
**File:** SkyrimNet_SexLab_Decorators.psc  
**Lines:** 61-64  
**Problem:**  
```papyrus
String options = "undresses"
if main.HasStrippedItems(speaker)
    options = "dresses"
endif
```
The initial value is counterintuitive. If stripped items exist, we "dress" (correct), but the initial "undresses" suggests the opposite logic. This is confusing for maintainers.

**Fix:**  
Reverse the initial condition or add a clarifying comment:
```papyrus
; Default: actor has no stripped items, so offer to undress
String options = "undresses"
; If stripped items exist, offer to dress instead
if main.HasStrippedItems(speaker)
    options = "dresses"
endif
```

---

### 3. HIGH: Missing Null Check on GetFormFromFile (Line 60)
**File:** SkyrimNet_SexLab_Decorators.psc  
**Line:** 60  
**Problem:**  
```papyrus
String Function Outfit_Options(Actor speaker) global 
    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main
    String options = "undresses"
    if main.HasStrippedItems(speaker)  ; <-- CRASH if main is None
```
If `GetFormFromFile()` returns None or casting fails, calling `main.HasStrippedItems()` will crash the script. No defensive check exists.

**Fix:**  
```papyrus
String Function Outfit_Options(Actor speaker) global 
    SkyrimNet_SexLab_Main main = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Main
    if main == None
        Trace("Outfit_Options", "ERROR: Failed to get SkyrimNet_SexLab_Main form", True)
        return "{" + '"' + "option" + '"' + ":" + '"' + "undresses" + '"' + "}"
    endif
    
    String options = "undresses"
    if main.HasStrippedItems(speaker)
        options = "dresses"
    endif
    Trace("Outfit_Options", speaker.GetDisplayName() + " clothing state: " + options)
    return "{" + '"' + "option" + '"' + ":" + '"' + options + '"' + "}"
EndFunction
```

---

### 4. MEDIUM: Dead Code (Lines 76-97)
**File:** SkyrimNet_SexLab_Decorators.psc  
**Lines:** 76-97  
**Problem:**  
Large commented-out `Speaker_Info()` function with 22 lines of dead code. This should either be:
- Removed entirely
- Restored with documentation
- Explained in a KnowledgeBase entry

**Fix:**  
Delete lines 76-97, or if it's experimental, move to a separate `experimental.psc` or document in KNOWLEDGEBASE.md why it's commented.

---

### 5. MEDIUM: Incomplete Error Handling (Lines 127-131)
**File:** SkyrimNet_SexLab_Decorators.psc  
**Lines:** 127-131  
**Problem:**  
```papyrus
String Function SexLab_Get_Threads(Actor speaker) global
    SkyrimNet_SexLab_Scene_Manager manager = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene_Manager
    if manager == None 
        return '{"threads":[]}'  ; Silently returns empty, no log
    endif 
```
While there's a None check, failure is silent. Callers won't know if they got a real empty array or a failed lookup. This can hide bugs.

**Fix:**  
```papyrus
String Function SexLab_Get_Threads(Actor speaker) global
    SkyrimNet_SexLab_Scene_Manager manager = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab.esp") as SkyrimNet_SexLab_Scene_Manager
    if manager == None 
        Trace("SexLab_Get_Threads", "ERROR: Failed to get SkyrimNet_SexLab_Scene_Manager", True)
        return '{"threads":[]}'
    endif 
    return manager.GetThreadsJson(speaker) 
EndFunction
```

---

### 6. MEDIUM: Redundant Parameter Specification (Line 31)
**File:** SkyrimNet_SexLab_Decorators.psc  
**Line:** 31  
**Problem:**  
```papyrus
"-h", "${workspaceFolder}/Headers", "-h", "${workspaceFolder}/Headers",
```
This is a build task config line, but within the Papyrus script itself, line 31 in `RegisterDecorators()` references a decorator that's commented out:
```papyrus
;SkyrimNetApi.RegisterDecorator("sexlab_nudity", "SkyrimNet_SexLab_Decorators", "Is_Nudity")
```
If `Is_Nudity()` function is implemented (line 107) but the decorator isn't registered, it's dead code.

**Fix:**  
Either:
1. Uncomment line 30 if the decorator should be active
2. Delete the `Is_Nudity()` function (lines 107-124) if it's not needed
3. Document why it's disabled in KNOWLEDGEBASE.md

---

### 7. LOW: Inconsistent Comment Documentation
**File:** SkyrimNet_SexLab_Decorators.psc  
**Lines:** 52-59  
**Problem:**  
Only the `Outfit_Options()` function has a large commented-out documentation block (28 lines of body slot notes). Other functions lack equivalent documentation about what they do, their parameters, and return values.

**Fix:**  
Add standardized docstring comments:
```papyrus
; Returns distance and line-of-sight status of an actor relative to the player
; @param akActor The actor to check
; @return JSON: {"distance": float, "los": bool}
String Function Player_LOS_Distance(Actor akActor) global
```

---

### 8. LOW: Commented-Out Decorator Registrations (Lines 29-30)
**File:** SkyrimNet_SexLab_Decorators.psc  
**Lines:** 29-30  
**Problem:**  
```papyrus
;SkyrimNetApi.RegisterDecorator("sexlab_nudity", "SkyrimNet_SexLab_Decorators", "Is_Nudity")
;SkyrimNetApi.RegisterDecorator("sexlab_speaker_info", "SkyrimNet_SexLab_Decorators", "Speaker_Info")
```
Why are these disabled? No explanation. If they're broken, the implementation functions should be removed too.

**Fix:**  
Add inline comments:
```papyrus
; SexLab_Nudity decorator disabled: pending API review with SkyrimNet team
;SkyrimNetApi.RegisterDecorator("sexlab_nudity", "SkyrimNet_SexLab_Decorators", "Is_Nudity")
```

---

## Summary of Fixes by Priority

| Severity | Issue | Line(s) | Action |
|----------|-------|---------|--------|
| HIGH | Null safety on GetFormFromFile | 60 | Add defensive None check |
| HIGH | Misleading trace message | 65 | Separate and clarify trace output |
| HIGH | Confusing logic initialization | 61-64 | Add clarifying comments or restructure |
| MEDIUM | Incomplete error handling | 127-131 | Add trace on manager failure |
| MEDIUM | Dead code (Speaker_Info) | 76-97 | Remove or document |
| MEDIUM | Disabled decorator mismatch | 29-30, 107-124 | Align implementations with registrations |
| LOW | Missing docstrings | Multiple | Add function documentation |
| LOW | Unexplained disabled decorators | 29-30 | Add inline explanatory comments |

---

## Confidence Level: **92%**

**Assumptions:**
- Papyrus best practices follow C#-like null safety requirements
- KNOWLEDGEBASE.md has established error handling patterns
- Decorators must be registered to be callable
- `HasStrippedItems()` and `GetThreadsJson()` are reliable external APIs

**Notes:**
- The JSON string concatenation (e.g., `"{"+'"'+"option"+'"'+"..."`) is valid but hard to read; consider extracting to a helper function in future refactoring
- The large body slot documentation (lines 28-50) is useful but could be moved to KNOWLEDGEBASE.md to reduce script clutter
