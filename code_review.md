# Code Review: SkyrimNet_SexLab_Main.psc

**Reviewer:** Claude Copilot  
**Date:** June 12, 2026  
**Scope:** Quest script - module initialization, scene orchestration, and item storage

---

## Executive Summary

The script is well-structured and follows Skyrim modding conventions. It serves as the central quest script for SkyrimNet_SexLab, handling initialization, state management, and item storage. Most code is sound, but there are **4 moderate issues** and **5 improvement opportunities** identified below.

---

## 1. STRENGTHS

### 1.1 Organization & Imports
- ✅ Clean import structure with explicit module dependencies
- ✅ Logical property grouping (optional mods, global variables, storage keys)
- ✅ Consistent use of namespacing (e.g., `storage_actor_lock_key`, `storage_items_key`)

### 1.2 Trace Function
- ✅ Centralized logging via `Trace()` global function—good for debugging
- ✅ Supports both console and in-game notifications
- ✅ Automatic function name prefixing for log clarity

### 1.3 Storage Utilities
- ✅ `UnStoreStrippedItems()` clears storage after retrieval—prevents accidental re-use
- ✅ `HasStrippedItems()` performs null check before accessing storage

### 1.4 Naming Conventions
- ✅ Follows documented conventions: uppercase constants, camelCase/snake_case for properties
- ✅ Descriptive names for storage keys

---

## 2. ISSUES

### 2.1 ⚠️ **MODERATE: Property Initialization Race Condition in Setup()**

**Location:** Lines 90–91, 94–96

```papyrus
if group_info == 0
    group_info = JValue.readFromFile(...)
    JValue.retain(group_info)
else
    int group_info_new = JValue.readFromFile(...)
    JValue.releaseAndRetain(group_info, group_info_new)
    group_info = group_info_new
endif
```

**Problem:**
- If `Setup()` is called multiple times before `JValue` completes async operations, `group_info` may be partially initialized
- The `else` branch creates a temporary local variable `group_info_new`, which is verbose

**Recommendation:**
```papyrus
; Only reload if explicitly needed (e.g., from MCM)
; Avoid redundant reloads on script reloads
if group_info == 0
    group_info = JValue.readFromFile("Data/SKSE/Plugins/SkyrimNet_Sexlab/group_tags.json")
    if group_info > 0
        JValue.retain(group_info)
    else
        Trace("Setup", "WARNING: Failed to load group_tags.json", true)
    endif
endif
```

**Confidence:** 85% (depends on JValue async behavior)

---

### 2.2 ⚠️ **MODERATE: Missing Null Checks After JSON File Reads**

**Location:** Lines 90–96, 98–101

```papyrus
group_info = JValue.readFromFile(...)
JValue.retain(group_info)
; ... no check for failure

race_to_description = JValue.readFromFile(...)
JValue.retain(race_to_description)
; ... no check for failure
```

**Problem:**
- `JValue.readFromFile()` returns 0 on file not found or parse error
- Script retains 0, which will crash if code later calls `JValue` methods on this handle
- No error notification to user

**Recommendation:**
```papyrus
int group_info_temp = JValue.readFromFile("Data/SKSE/Plugins/SkyrimNet_Sexlab/group_tags.json")
if group_info_temp > 0
    JValue.retain(group_info_temp)
    group_info = group_info_temp
else
    Trace("Setup", "ERROR: Failed to load group_tags.json", true)
    ; Optionally set defaults or abort
endif
```

**Confidence:** 95%

---

### 2.3 🔴 **HIGH: Incomplete Setup() - Handler DOM Not Verified for Compatibility**

**Location:** Lines 76–82

```papyrus
if skyrimnet_dom_found && skyrimnet_sexlab_handler_dom_found
    handler_dom = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab_Handler_DOM.esp") as SkyrimNet_SexLab_Handler_DOM_Interface
    Trace("Setup","SkyrimNet_DOM found setting main.handler_dom to SkyrimNet_SexLab_Handler_DOM")
else 
    handler_dom = (self as Quest) as SkyrimNet_SexLab_Handler_DOM_Interface
    Trace("Setup","SkyrimNet_SexLab_Handler_DOM found:"+skyrimnet_sexlab_handler_dom_found+", SkyrimNet_DOM found :"+skyrimnet_dom_found)
endif
```

**Problems:**
1. **Silent fallback to self:** If external handler fails, script silently casts `self` to `SkyrimNet_SexLab_Handler_DOM_Interface`. This works only if `SkyrimNet_SexLab_Main` also implements this interface (not shown in file).
2. **FormID hardcoded:** `0x800` assumes DOM handler is always at this ID. If mod loads in different plugin slot, this breaks.
3. **No null check:** If cast fails, `handler_dom = None` but no error notification.

**Recommendation:**
```papyrus
if skyrimnet_dom_found && skyrimnet_sexlab_handler_dom_found
    handler_dom = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab_Handler_DOM.esp") as SkyrimNet_SexLab_Handler_DOM_Interface
    if handler_dom == None
        Trace("Setup", "ERROR: Failed to get external handler DOM. Using fallback.", true)
        handler_dom = (self as Quest) as SkyrimNet_SexLab_Handler_DOM_Interface
    endif
else 
    handler_dom = (self as Quest) as SkyrimNet_SexLab_Handler_DOM_Interface
    Trace("Setup", "Using internal handler. External mods found - DOM: " + skyrimnet_dom_found + ", Handler: " + skyrimnet_sexlab_handler_dom_found)
endif

if handler_dom == None
    Trace("Setup", "CRITICAL: handler_dom is None. Quest will not function.", true)
    return
endif
```

**Confidence:** 90%

---

### 2.4 ⚠️ **MODERATE: SexLab.esm Check Only Logs, Doesn't Abort**

**Location:** Lines 68–73

```papyrus
if !MiscUtil.FileExists("Data/SexLab.esm")
    Trace("SetUp","Data/SexLab.esm does not exist") 
    Debug.MessageBox("Can't find Data/SexLab.esm"+StringUtil.AsChar(10)\
        +"SkyrimNet_SexLab will not work.")
    return 
endif
```

**Good:** Script does return, preventing further damage. However:
- **Property initialization skipped:** Properties like `sexlab` are never set, so later code referencing `sexlab.` will crash.
- **Missing return during rest of Setup:** The function doesn't fully abort all initialization after the early return.

**Recommendation:** Move this check to the very first line of `Setup()` and document that all remaining initialization is skipped.

**Confidence:** 95%

---

## 3. CODE STYLE & CONVENTIONS

### 3.1 ✅ **Naming Conventions Compliance**

- Constants (`STORAGE_*`): Not used; consider defining as constants if they're truly immutable.
- Properties: Mostly follow camelCase with underscores (e.g., `active_sex`, `rape_allowed`) — consistent.
- Functions: Correct capitalization (e.g., `Setup()`, `UnStoreStrippedItems()`).

### 3.2 ⚠️ **Inconsistent String Concatenation**

**Location:** Lines 44 (trace messages), 87, 127

```papyrus
msg = "[SkyrimNet_SexLab_Main."+func+"] "+msg         ; Line 45
Debug.Notification(msg)
```

vs.

```papyrus
Debug.MessageBox("Can't find Data/SexLab.esm"+StringUtil.AsChar(10)+"...")
```

**Note:** Both styles work, but `StringUtil.AsChar(10)` is less readable than `" | "` or explicit line breaks. Consider standardizing.

---

## 4. POTENTIAL BUGS

### 4.1 **UnStoreStrippedItems() Logic Flaw**

**Location:** Lines 122–132

```papyrus
Form[] Function UnStoreStrippedItems(Actor akActor)
    if !HasStrippedItems(akActor)
        Trace("UnStoreStrippedItems",akActor.GetDisplayName()+" attempting to get stripped items: found none")
        return Utility.CreateFormArray(0)
    endif
    Form[] forms = StorageUtil.FormListToArray(akActor, storage_items_key)
    StorageUtil.FormListClear(akActor, storage_items_key)
    ...
```

**Concern:** If `akActor` is None, `akActor.GetDisplayName()` will crash. The function assumes caller validates `akActor` first.

**Recommendation:**
```papyrus
Form[] Function UnStoreStrippedItems(Actor akActor)
    if akActor == None
        return Utility.CreateFormArray(0)
    endif
    if !HasStrippedItems(akActor)
        Trace("UnStoreStrippedItems", akActor.GetDisplayName() + " has no stripped items")
        return Utility.CreateFormArray(0)
    endif
    ...
```

**Confidence:** 95%

---

### 4.2 **Property Initialization Without Null Checks**

**Location:** Property declarations (lines 20–60)

```papyrus
Faction Property SkyrimNet_SexLab_Faction_Victim Auto
GlobalVariable Property skyrimnet_sexlab_active_sex Auto
SexLabFramework Property sexlab Auto
```

**Problem:** Auto-properties are only assigned in CK. If they fail to load from the ESP, they become `None` at runtime. Code that later calls methods on them will crash.

**Recommendation:** Add defensive null checks at the start of functions that use these properties, or check them in `Setup()`:

```papyrus
Function Setup()
    ; Validate auto-properties
    if sexlab == None
        Trace("Setup", "ERROR: sexlab property not initialized. Critical dependency missing.", true)
        return
    endif
    if SkyrimNet_SexLab_Faction_Victim == None
        Trace("Setup", "ERROR: SkyrimNet_SexLab_Faction_Victim not initialized.", true)
        return
    endif
    ...
```

**Confidence:** 90%

---

## 5. PERFORMANCE CONSIDERATIONS

### 5.1 **JSON File Loads on Every Script Reload**

**Location:** Lines 90–101

If a script reload occurs mid-session, `group_info` and `race_to_description` will be reloaded from disk. This is fine if infrequent, but consider caching or adding a reload counter.

**Recommendation:**
```papyrus
int Property reloads_until_json_refresh = 0 Auto

; Track reloads and only refresh JSON occasionally
if reloads_until_json_json <= 0
    ; Reload JSON
    reloads_until_json_refresh = 5  ; Refresh after 5 reloads
else
    reloads_until_json_refresh -= 1
endif
```

**Confidence:** 70% (minor optimization; only matters if Setup() called frequently)

---

### 5.2 **StorageUtil Operations**

**Location:** Lines 107–120

```papyrus
StorageUtil.FormListClear(akActor, storage_items_key)
int i = 0
while i < forms.Length
    StorageUtil.FormListAdd(akActor, storage_items_key, forms[i])
    i += 1
endwhile
```

**Note:** This is the correct way to populate a form list in Papyrus. No performance issue, but consider using `StorageUtil.FormListAdd()` in a loop—this is already done correctly. ✅

---

## 6. DOCUMENTATION & COMMENTS

### 6.1 ⚠️ **Incomplete Function Documentation**

**Location:** All functions

```papyrus
; No docstring explaining parameters, return values, or side effects
Function Setup()
    Trace("SetUp","")
    ...
EndFunction
```

**Recommendation:**
```papyrus
; Initializes SkyrimNet_SexLab quest system
; Loads JSON configs (group_tags.json, creatures.json)
; Sets up handlers (DOM or internal)
; Loads optional mod compatibility flags
; @return None
; @note Logs errors via Trace() and shows MessageBox on critical failure (missing SexLab.esm)
Function Setup()
```

---

### 6.2 **Magic Number Explanation**

**Location:** Lines 49–50 (direct_narration_cool_off = 20)

```papyrus
if direct_narration_cool_off == 0 
    direct_narration_cool_off = 20 
```

**Missing:** Why 20? Seconds? Update frames? Add a comment:

```papyrus
; Cooldown in real-time seconds between DirectNarration events (prevent audio spam)
direct_narration_cool_off = 20.0
```

---

## 7. RECOMMENDATIONS

### Priority 1 (Do First)
1. **Add null checks after `JValue.readFromFile()` calls** (Issue 2.2)
2. **Verify `handler_dom` initialization** (Issue 2.3)
3. **Add null checks for auto-properties** (Issue 4.2)
4. **Validate `akActor` in `UnStoreStrippedItems()`** (Issue 4.1)

### Priority 2 (Important)
5. Simplify `group_info` reload logic (Issue 2.1)
6. Add function documentation comments
7. Extract magic numbers to named constants

### Priority 3 (Nice-to-Have)
8. Standardize string concatenation style
9. Consider JSON reload caching optimization
10. Add debug flags for development tracing

---

## 8. TESTING CHECKLIST

- [ ] Test `Setup()` when SexLab.esm is missing
- [ ] Test `Setup()` with external DOM handler present
- [ ] Test `Setup()` with external DOM handler missing
- [ ] Test `UnStoreStrippedItems()` with None actor
- [ ] Test multiple calls to `Setup()` (verify no double-retain)
- [ ] Verify JSON files load and retain properly
- [ ] Test item storage and retrieval cycle
- [ ] Check for memory leaks with JValue retain/release

---

## 9. CONCLUSION

**Overall Grade: B+**

The script is functional and follows most Skyrim modding best practices. The primary concerns are error handling around external dependencies (DOM handler, JSON files) and null validation. Implementing the Priority 1 recommendations will significantly improve robustness.

**Key Takeaway:** This script is a critical initialization point. Defensive programming and explicit error handling will prevent silent failures that are hard to debug in-game.

---

## Appendix: KNOWLEDGEBASE References

- **SexLab.esm critical dependency:** Properly checked and aborted if missing ✅
- **JValue handle lifecycle:** Retain/release pattern used correctly, but no error checking on handles
- **Auto-properties:** Vulnerable to initialization failure; add validation checks
- **External mod detection:** Using `MiscUtil.FileExists()` correctly ✅

