# SkyrimNet_SexLab — Review Summary: Deferred Backlog

Deferred / not-yet-scheduled items carried in [review-checkpoint.xml](review-checkpoint.xml) and [review-execution-plan.xml](review-execution-plan.xml). None are known regressions; they are documented here as **where / problem / fix** so any can be scheduled without re-discovery.

Line numbers include commented lines. Confidence notes flag items whose detail should be re-confirmed against source before implementing.

---

## M7 — `GetAnim_Info` JContainers allocation not released

- **Where:** [Scripts/Source/SkyrimNet_SexLab_Stages.psc](Scripts/Source/SkyrimNet_SexLab_Stages.psc) — `GetAnim_Info` (`int anim_info = JMap.object()` line 598; per-file `int info = JValue.readFromFile(fn)` line 619; `return anim_info` line 644). Callers that never release the returned object: `GetStageDescription` (line 101), `GetOrgasmExpected` (line 400), `GetHasDescriptionOrgasmExpected` (line 558), `SetOrgasmExpected` (line 491), `EditDescriptions` (line 214).
- **Problem:** `GetAnim_Info` builds a fresh JMap every call and reads one JValue per animation folder, none of which are `JValue.release`d. JContainers auto-GCs unreferenced objects, so this is churn rather than a hard leak, but every stage tick allocates and abandons several objects.
- **Fix:** `JValue.release(info)` after copying its contents inside the folder loop, and `JValue.release(anim_info)` in each caller once its values are read (or wrap `anim_info` with `JValue.retain` + explicit release). Simplest: have callers release the returned object after use.

## M8 — `orgasm_expected` resolution vs. per-stage description walk

- **Where:** [Scripts/Source/SkyrimNet_SexLab_Stages.psc](Scripts/Source/SkyrimNet_SexLab_Stages.psc) — `GetOrgasmExpected` reads the top-level `orgasm_expected` key (lines 405-407); `GetStageDescription` walks stages downward to find a description (lines 103-113). Consumed in [Scripts/Source/SkyrimNet_SexLab_Scene.psc](Scripts/Source/SkyrimNet_SexLab_Scene.psc) `StageStart` (line 822) and `AnimationEnd` (line 944).
- **Problem:** `orgasm_expected` is resolved once per animation (a single animation-wide array), while stage descriptions fall back stage-by-stage. For multi-stage animations the orgasm expectation used at a given stage can disagree with the description actually shown for that stage.
- **Fix:** Resolve `orgasm_expected` with the same per-stage downward fallback used for descriptions, or explicitly document/enforce that `orgasm_expected` is animation-wide and independent of stage. *(Confidence moderate — confirm intended per-stage vs per-animation semantics with author before changing.)*

## M9-M16 — Bundled polish items

### hide_help has no effect
- **Where:** [Scripts/Source/SkyrimNet_SexLab_Stages.psc](Scripts/Source/SkyrimNet_SexLab_Stages.psc) `EditDescriptions` help block (lines 237-239); property `hide_help` (line 11); toggled by [Scripts/Source/SkyrimNet_SexLab_MCM.psc](Scripts/Source/SkyrimNet_SexLab_MCM.psc) `SexEditHelpToggle` (lines 281-290).
- **Problem:** The "You may enter a description…" help text is shown whenever `desc == ""`, regardless of `stages.hide_help`. The MCM toggle is wired but never consulted, so "Hide Edit Stage Description Help" does nothing.
- **Fix:** Gate the help lines with `if !hide_help` (still show a minimal prompt when help is hidden).

### OStim affection path missing
- **Where:** [Scripts/Source/SkyrimNet_SexLab_Menu.psc](Scripts/Source/SkyrimNet_SexLab_Menu.psc) affection branch OStim else (lines 171-173).
- **Problem:** When OStim is the active framework, the affection button only shows `Debug.Notification("Affection is not available while OStim is the active framework.")` — the action is inert.
- **Fix:** Implement an OStim affection path (e.g. route to the OStim event send like `masturbate`/`sex` do), or intentionally document affection as SexLab-only.

### Victim faction not cleared for dropped actors
- **Where:** [Scripts/Source/SkyrimNet_SexLab_Scene.psc](Scripts/Source/SkyrimNet_SexLab_Scene.psc) `Setup` adds victims to `SkyrimNet_SexLab_Faction_Victim` (line 197); `Release` removes it only for current `thread.positions` (lines 313-314); `AlignActors` (line 564) rebinds positions but does not clean actors no longer present.
- **Problem:** If an actor leaves a scene mid-run (position swap / thread reshuffle), that actor can retain `SkyrimNet_SexLab_Faction_Victim` because only `Release` clears the current positions, not actors that dropped out.
- **Fix:** Track previously-faction'd actors and remove the faction from any actor no longer in `thread.positions` during `AlignActors`, or clear the faction on the departed actor when detected.

### DOM player-alias Setup commented out
- **Where:** [Scripts/Source/SkyrimNet_SexLab_Handler_DOM_PR.psc](Scripts/Source/SkyrimNet_SexLab_Handler_DOM_PR.psc) `OnPlayerLoadGame` (line 18, `;    handler.Setup()`).
- **Problem:** The DOM player-alias never calls `handler.Setup()`. Harmless today because `Main.Setup()` owns DOM handler wiring, but the alias is dead as a setup path.
- **Fix:** Either delete the alias script/hook or restore `handler.Setup()` if the alias is meant to own DOM init. Keep only one owner (currently `Main.Setup`).

### Mislabeled Trace tags
- **Where (examples):** [Scripts/Source/SkyrimNet_SexLab_Scene_Manager.psc](Scripts/Source/SkyrimNet_SexLab_Scene_Manager.psc) `CreateSceneWithoutCreator` uses `Trace("CreateSceneByThread", …)` (line 168); `GetSceneByThread` logs `"CreateSceneWithoutCreator returned None"` (line 217); `OrgasmIndividual` event uses `Trace("OrgasmCombined", …)` (line 745). [Scripts/Source/SkyrimNet_SexLab_Scene_Creator.psc](Scripts/Source/SkyrimNet_SexLab_Scene_Creator.psc) `StartScene` uses `Trace("Start", …)` (line 327); `SetVictims` uses `Trace("SexVictims", …)` (line 525).
- **Problem:** Trace function-name labels/messages don't match their enclosing function, making log filtering by function misleading.
- **Fix:** Correct each label to its actual function name (cosmetic; log-only).

### Orgasm editor polish
- **Where:** [Scripts/Source/SkyrimNet_SexLab_Stages.psc](Scripts/Source/SkyrimNet_SexLab_Stages.psc) `SetOrgasmExpected` (lines 482-551).
- **Problem:** Placeholder backlog item for UX/robustness polish of the per-actor orgasm-expected editor (navigation, persistence feedback). No functional defect currently identified.
- **Fix:** Revisit editor flow when scheduling; define concrete acceptance criteria first. *(Low priority / scope TBD.)*

## S10b — Convert always-on Trace scaffolding to `debug_mode`-gated `DbgMsg`

- **Where:** [Scripts/Source/SkyrimNet_SexLab_Scene.psc](Scripts/Source/SkyrimNet_SexLab_Scene.psc) — numerous unconditional `Trace("…","--- …")` calls (e.g. `Setup` lines 174, 206, 225, 228, 270-298; `StageStart`; `AnimationEnd`; `OrgasmCombined`).
- **Problem:** Debug scaffolding logs on every scene tick even when not debugging, adding log volume and minor overhead. `DbgMsg`/`DbgEnter`/`DbgReturn` (gated by `debug_mode`, lines 75-114) already exist for this purpose.
- **Fix:** Replace the always-on `--- ` scaffolding `Trace(...)` calls with the `debug_mode`-gated `DbgMsg(...)` helpers; keep genuine warning/error traces unconditional.

## S11 — `GetLocation` furniture branch returns raw tags without article/preposition

- **Where:** [Scripts/Source/SkyrimNet_SexLab_Scene.psc](Scripts/Source/SkyrimNet_SexLab_Scene.psc) `GetLocation` (furniture list lines 1314-1348; return `loc+" "` line 1367).
- **Problem:** The bed branch returns natural phrasing ("a single bed "), but the furniture branch assigns the raw tag (e.g. `"Table"`, `"WoodenPony"`) with no article/preposition, so the location reads as a bare noun in narration.
- **Fix:** Map each furniture tag to a natural phrase with preposition (e.g. `"on a table"`, `"on a wooden pony"`), matching the "in a cage"/"through a gloryhole" style already used in the `!found` fallback (lines 1350-1364).

---

## Explicitly NOT bugs (do not re-report)
- `H9` — Manager `OrgasmIndividual` Dom early-return: external SkyrimNet_DOM calls `DOMSlave_Orgasmed`.
- `Handler_DOM_PR` overlaps the "DOM player-alias Setup commented out" note above (same line 18); harmless because `Main.Setup` owns DOM wiring.
- `WebUI.psc` — intentional future SKSE library anchor.
- `GetFormFromFile` property wiring — intentional in global functions.
- `PagedActors`, `z-*`, `SkyrimNet_Sexlab_Creatures.psc` — out of scope per [review-guide.xml](review-guide.xml).
