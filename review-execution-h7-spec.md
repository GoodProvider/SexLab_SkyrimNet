# H7 — Narration Utilities Implementation Spec

**Status:** Locked (user Q12A — full checkpoint batches 3–4)  
**File:** `Scripts/Source/SkyrimNet_SexLab_Utilities.psc`  
**Related:** `SkyrimNet_SexLab_Scene.psc` (`StageStart`, `AnimationEnd`)

---

## Current bugs (must fix)

| Line | Issue |
|------|--------|
| 377 | `ContinueActivity` passes `optional` — undefined; should be `optional_is_dropped` |
| 380 | Param named `optional`; body L407 reads `optional_is_dropped` |
| 458–471 | `CheckDuplicate` only blanks duplicates; no cool-off fallback |
| 463 | `StorageUtil.GetStringValue(source, ...)` when `source == None` — use player fallback |

---

## Batch 3 requirements (review-checkpoint.xml)

1. **CheckDuplicate** calls `ContinueActivity` when narration cool-off allows (instead of only returning `""`).
2. Fallback paths use **`optional_is_dropped=True`**.
3. *(Scene)* StageStart unchanged desc → `ContinueActivity(True)` — already in Scene.psc L558; ensure H7b first-start path also uses `True` when desc empty.
4. *(Scene/Dom)* Dom Combined silent unless `orgasm_expected==1` — verify in Scene.psc L684+ after H8; not Utilities.
5. **Player fallback** StorageUtil key when `source == None` in `CheckDuplicate`.

---

## Batch 4 requirements

1. **`allow_continue_fallback=False`** on `DirectNarration_Optional` and `RegisterEvent` when they call `CheckDuplicate` (anti-recursion).
2. **RegisterEvent duplicate:** silent drop only (no re-register same msg).
3. **`NarrationCoolOffAllows(source, target)`** — shared helper extracted from cool-off logic currently at L397–402.
4. *(Scene H7b)* First StageStart: `GetIntentMessage(INTENT_STAGE_START)` + append desc — Scene.psc change, not Utilities.
5. **Both `source` and `target` None:** silent drop; **no** `ContinueActivity` from `CheckDuplicate`.

---

## Suggested function shapes

```papyrus
Bool Function NarrationCoolOffAllows(Actor source, Actor target) global
    ; Extract from DirectNarration_Optional L397–402:
    ; time_delta > cool_off, queue_size == 0, last_audio >= cool_off, distance <= max_distance
EndFunction

String Function CheckDuplicate(String func, Actor source, String msg, \
    Bool allow_continue_fallback=True, Actor target=None) global
    ; If msg == "" return ""
    ; If source == None use Game.GetPlayer() for StorageUtil key (batch 3)
    ; If source == None AND target == None return "" (batch 4)
    ; If duplicate:
    ;   If allow_continue_fallback AND NarrationCoolOffAllows(source, target):
    ;     ContinueActivity(source, target, True)  ; optional_is_dropped=True
    ;     return ""
    ;   Else return ""
    ; Else set StorageUtil and return msg
EndFunction

Function ContinueActivity(Actor source=None, Actor target=None, bool optional_is_dropped=False) global
    ; ... build msg ...
    DirectNarration_Optional("continue activity", msg, source, target, optional_is_dropped)
EndFunction

Function DirectNarration_Optional(String event_type, String msg, Actor source=None, Actor target=None, bool optional_is_dropped=False) global
    msg = CheckDuplicate("DirectNarration_Optional", source, msg, False, target)  ; anti-recursion
    ; ... existing cool-off / DN / RegisterEvent logic using optional_is_dropped ...
EndFunction

Function RegisterEvent(String event_name, String msg, Actor source=None, Actor target=None) global
    if msg == "" return  ; batch 2 silent on blank
    msg = CheckDuplicate("RegisterEvent", source, msg, False, target)
    if msg == "" return  ; duplicate → silent drop (batch 4)
    SkyrimNetApi.RegisterEvent(...)
EndFunction
```

---

## Anti-recursion rule

```
CheckDuplicate (allow_continue=True)
  → ContinueActivity
    → DirectNarration_Optional
      → CheckDuplicate (allow_continue=False)  ← must NOT call ContinueActivity again
```

Without `allow_continue_fallback=False` on inner paths, duplicate detection can loop indefinitely.

---

## `optional_is_dropped` semantics

| Value | Cool-off OK | Cool-off blocked |
|-------|-------------|------------------|
| `False` | DirectNarration | RegisterEvent |
| `True` | DirectNarration | Silent drop (no event) |

Mid-scene stage ticks and duplicate fallbacks should use **`True`** to avoid event spam.

---

## Callers to verify after H7

| Caller | File | Line | Expected |
|--------|------|------|----------|
| `StageStart` unchanged desc | Scene.psc | 558 | `ContinueActivity(sender, receiver, True)` |
| `StageStart` first empty desc | Scene.psc | 544 | Change to `ContinueActivity(..., True)` per H7b |
| `AnimationEnd` optional | Scene.psc | 634 | `DirectNarration_Optional` — uses `allow_continue_fallback=False` internally |
| `Orgasm` optional | Scene.psc | 789 | Same |

---

## Confidence

90% — logic matches locked checkpoint batches; playtest rapid stage changes for spam/loops.
