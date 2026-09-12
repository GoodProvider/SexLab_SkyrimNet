# SkyrimNet_SexLab — Fix Pass Checklist

**Date:** 2026-07-08  
**Plan:** [review-execution-plan.xml](review-execution-plan.xml)  
**H7 spec:** [review-execution-h7-spec.md](review-execution-h7-spec.md)

Apply in order. Check off after each step compiles (Papyrus steps).

---

## Step 1 — Scene Creator (H1, M6)

**File:** `Scripts/Source/SkyrimNet_SexLab_Scene_Creator.psc`

- [ ] L286–288: `CreateSceneByCreator` **before** `Release()`
- [ ] L524–526: `SetStyle` → `parent.SetStyle(_style)`

---

## Step 2 — Scene Manager (H2, H3, M1–M3, NEW-1, NEW-2)

**File:** `Scripts/Source/SkyrimNet_SexLab_Scene_Manager.psc`

- [ ] L348–350: Cache thread before `AnimationEnd`; `StopThread(cachedThread)`
- [ ] L398–413: Creator null-check; `Release()` on lock fail
- [ ] L285–288: `UnRegisterForModEvent` before Action Start/Stop register
- [ ] L173–175: Set `thread_scene[tid]` for generic fallback
- [ ] L611–612: Release only root `obj` in `GetThreadsJson`
- [ ] L315–350: Always `AnimationEnd`+`Release`; consent dialog only if `has_player`
- [ ] L293–307: Validate `target` after Actor cast

---

## Step 3 — Main (H4)

**File:** `Scripts/Source/SkyrimNet_SexLab_Main.psc`

- [ ] L92–95: SexLab gate `== 255` to abort (not `!= 255`)

---

## Step 4 — Stages (H5)

**File:** `Scripts/Source/SkyrimNet_SexLab_Stages.psc`

- [ ] L148: `JArray.setStr(actors_obj, ...)`
- [ ] L152: `JMap.setObj(obj, "actors", actors_obj)`

---

## Step 5 — Menu + Actions (H6, H10, M4)

**Files:** `SkyrimNet_SexLab_Menu.psc`, `SkyrimNet_SexLab_Actions.psc`

- [ ] Menu L207: Remove `+"es"` on outfit string
- [ ] Actions L242: Branch on `how == "dress"`
- [ ] Menu L163–166: DOM `IsDOMSlave` + `Target_Menu_Selection`; remove dead gate
- [ ] Menu L463–469: Creator null + `LockAllActorLock` pattern

---

## Step 6 — Utilities (H7)

**File:** `Scripts/Source/SkyrimNet_SexLab_Utilities.psc`

See [review-execution-h7-spec.md](review-execution-h7-spec.md).

- [ ] `NarrationCoolOffAllows(source, target)` helper
- [ ] `optional_is_dropped` param fix L377/L380/L407
- [ ] `CheckDuplicate` + `allow_continue_fallback`
- [ ] Anti-recursion on DN_Optional / RegisterEvent paths
- [ ] Player StorageUtil fallback when `source == None`

---

## Step 7 — Scene (H7b, H8, P1/P6/P11 Papyrus)

**File:** `Scripts/Source/SkyrimNet_SexLab_Scene.psc`

- [ ] L532–544: First `StageStart` always prepends intent; empty desc → `ContinueActivity(..., True)`
- [ ] L269–319: Set `is_dom_slave` in `SetActor`
- [ ] `GetObj`: export `names`, `victims` (string arrays), `location`
- [ ] `SetActor`/`UpdateActor`: `notice_level` = `"active"` when in active scene

---

## Step 8 — Decorators (M5, P2)

**File:** `Scripts/Source/SkyrimNet_SexLab_Decorators.psc`

- [ ] L61–64: `Intent` manager None-guard
- [ ] Register `sexlab_activities` → `Activities(Actor)` returns `{"activity": ...}`

---

## Step 9 — Action YAMLs (Y1–Y3)

- [ ] `sexlab_nonsexual_general_three.yaml` L30–32: `description:` for participate
- [ ] `sexlab_nonsexual_general_three.yaml` L1: `customCategory: sexlab_nonsexual`
- [ ] `sexlab_sex_sex_fucking_three.yaml` L30–32: `description:` for participate

---

## Step 10 — Prompts (P2–P8, P3, P4, P7)

- [ ] `helpers/sexlab/none_stop.prompt` L1: `sexlab_activities(npc.UUID)`
- [ ] `0050_sexlab_activity.prompt` L28–62: Fix `can_see_desc` / `can_hear_desc` typos
- [ ] `0550_sexlab_narration.prompt` L15–24: Set `notice_level` active (mirror 0050)
- [ ] `0020_sexlab_setting.prompt` L1: `sexlab_public_sex_accepted`
- [ ] `0005_sexlab_variables.prompt` L42: `skyrimnet_sexlab_active_sex`
- [ ] `helpers/sexlab/none_change_outfit.prompt`: Use `sexlab_outfit_options`

---

## Step 11 — Compile

```text
tools/Caprica/Caprica.exe --game skyrim --import Headers --import Scripts/Source ...
```

Or project `skyrimse.ppj` / russo-2025 papyrus-compiler per AGENTS.md.

---

## Step 12 — Closeout

- [ ] Write `reviews/2026-07-08-01.review.md`
- [ ] Update `review-checkpoint.xml` → `fix_pass` status `applied`

---

## Smoke tests (in-game)

1. Mod loads with SexLab present (Main.Setup does not abort).
2. LLM start scene with `style: forcefully` — narration reflects style.
3. Stop scene — SexLab thread actually ends.
4. Menu dress — actor redresses (not strip-only).
5. Three-actor nonsexual YAML — third participant binds.
6. Bio prompt during sex — `actor_having_sex` true for participants.
