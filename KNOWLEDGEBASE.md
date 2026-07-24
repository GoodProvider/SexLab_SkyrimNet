# Knowledgebase

## PrismaUI view path (2026-07-24)

`CreateView("SkyrimNet_SexLab/index.html")` loads from **`Data/PrismaUI/views/`**, not from `SKSE/Plugins/`. This mod ships the overlay at `PrismaUI/views/SkyrimNet_SexLab/index.html` (restored from commit `a8c9440`). Missing that file → valid-looking C++ open path (hotkey / `Target_Menu_Open`) but **no visible UI**. C++ Invokes use panel ids `target_menu_panel` / `sex_menu_panel`; the HTML maps those via `showPanel` / `hidePanel` adapters onto `#target-panel` / `#sex-menu-panel`.

## WebUI target menu catalog (2026-07-24)

Target panel UI is driven by:
- `Data/SKSE/Plugins/SkyrimNet_SexLab/webui/target_options.json` — typed parameter dictionary + category options
- `Data/SKSE/Plugins/SkyrimNet_SexLab/webui/actions_index.json` — generated from SkyrimNet action YAMLs (`tools/generate_actions_index.py`)

Regenerate the index after editing action YAML `label`s. C++ `ActionCatalog` loads both at init / open; Start merges dictionary onto YAML `parameterMapping` and `DispatchMethodCall`s `scriptName`/`executionFunctionName`. Actor slots use dictionary `type: Actor` + `source: player|target` (menu focus). Do not change SkyrimNet mapping types for WebUI — only add `label` fields.

## SexLab position slots and speaker_position (2026-07-23)

In this mod's sex / punish animations, **position_0 is submissive** and **position_1 is dominant**:
- position_0 gives oral to position_1; position_1 receives oral from position_0.
- position_1 fucks into position_0; position_0 is fucked by position_1.
- Punish scene JSON puts `_pain_` (and whipping `_gagged_`) on index 0.

The **Speaker is always the subject** of LLM-facing sentences. `speaker_position` places the Speaker into that slot:
- `StartScene_Nonconsensual_Two_TargetVictim` → speaker at **pos1** (target is victim).
- `StartScene_Nonconsensual_Two_SpeakerVictim` → speaker at **pos0** (speaker is victim).
- Consensual direction tokens (Speaker as subject): `fucking` / `fuck a` / `fucking a` / service `getting` → pos1; `fucked in` / service `giving` → pos0.

## Intent start/finish mirror (2026-07-23)

`GetIntentMessage(START)` → `"A and B start <intent>."`; `GetIntentMessage(END)` → `"A and B finish <intent>."` (same actors + same static intent phrase). Intent is not always sexual — examples: `sexual activities`, `showing physical affection`, `physically comforting each other`, `physically punishing`, `sexual assault`, `cuddling`. YAML `intent` values must be static phrases that fit both templates.

## Orgasm stash / AnimationEnd pipeline (2026-07-23)

1. `OrgasmCombined` / Combined `OrgasmCustom` stash messages and call `thread.UpdateTimer(4.0)` to extend the current stage.
2. Next `StageStart` flushes via `OrgasmMessagesToNarration()` into stage narration (no `OnUpdate` flush).
3. `AnimationEnd`: leftover `OrgasmMessagesToNarration()` → `RegisterEvent` if non-empty → `PurgeDialogue` → `GetIntentMessage(END)` finish mirror (+ SeparateOrgasms afterglow). Do not narrate ongoing activity at end.

## Actor lock key (2026-07-23)

Creator locks with `skyrimnet_sexlab_scene_actor_lock`. Action YAML eligibility and `Main.storage_actor_lock_key` must use the same string (not `skyrimnet_sexlab_actor_lock`).

## Punish-rape setting_name must match scene file (2026-07-22)

`sexlab_punish_rape_target.yaml` / `sexlab_punish_rape_target_by_target.yaml` must use `setting_name: punish_pleasure_pain_rape` (file `scenes/punish_pleasure_pain_rape.json`). A swapped token order (`punish_pain_pleasure_rape`) fails to load the scene. Hotkey Menu.psc uses the correct name. See review-checkpoint `Y-RapeSettingName`.

## SkyrimNet action YAML practice (2026-07-18)

Actions live in `SKSE/Plugins/SkyrimNet/config/actions/`. Executable YAMLs dispatch to `SkyrimNet_SexLab_Actions` via positional `parameterMapping` — order and types must match the Papyrus signature; mapping `name` is LLM-facing only.

- `static` requires `value`; `dynamic` requires `description` (not `value`).
- Prefer Papyrus slot names in mappings (`method`, not `type`; `how` for outfit).
- Action `name` must be unique across all YAMLs.
- Fixed-role nonconsensual two-actor scenes use `StartScene_Nonconsensual_Two_TargetVictim` / `_SpeakerVictim`. Dynamic victim uses `StartScene_Nonconsensual_Two` with an explicit `victim` mapping. Do not pass obsolete `speaking_victim`.
- Eligibility rule groups that exist should set `logicalOperator` and `required: true` (`required: false` is ignored by SkyrimNet).
- Category parents: only `name` / `description` / `customCategory` / `enabled` / eligibility — no `description_` field; keep PARAMS JSON valid.

Upstream schema: [WORKFLOW_ACTIONS.md](https://github.com/MinLL/SkyrimNet-GamePlugin/blob/main/docs/modding/WORKFLOW_ACTIONS.md).

## StageStart scene-change must not wipe orgasm narration (2026-07-17)

**Symptom**: `OrgasmCombined` stashes `"bob is orgasming. "` and sets `orgasm_messages_set`, but final DirectNarration is only `"Scene changes to …"` + cum — no `" is orgasming."`, so `0550_sexlab_narration.prompt` never gates.

**Cause**: In `Scene.StageStart`, after building `narration` from `orgasm_messages`, `desc != description_last` did `narration = "Scene changes to "+desc`, which replaced the orgasm/denied block. `orgasm_happened` stayed true (cum still appended); only the orgasm text was lost.

**Fix**: When the stage description changes, lead with `"Scene changes to "+desc` and **append** any existing orgasm narration instead of assigning over it. Non-orgasm ChangePosition path (empty narration) is unchanged.

## EnsureActorArraysLargeEnough must check both arrays (2026-07-16)

**Symptom**: `OrgasmCombined` — `Cannot access an element of a None array` on `orgasm_messages[i]`.

**Cause**: `EnsureActorArraysLargeEnough` early-returned when only `position_objs` was large enough. After save/load (or when `orgasm_messages` was added later), `position_objs` can be restored while `orgasm_messages` stays None.

**Fix**: Early-return only when **both** `position_objs` and `orgasm_messages` exist and meet `size`. `OrgasmCombined` also calls `EnsureActorArraysLargeEnough(num_actors)` before indexing (same pattern as `OrgasmCustom`).

## Papyrus string literals do not treat `\n` as newline (2026-07-15)

`"\n"` / `"\r\n"` in Papyrus source are backslash + letter(s), not control characters. Use `StringUtil.AsChar(10)` (LF) and `StringUtil.AsChar(13)` (CR). This project already does that in `Stages.psc` / `MCM.psc` via a `newline` field.

## SexLab orgasm narration trigger (2026-07-14)

**Prompt**: `SKSE/Plugins/SkyrimNet/prompts/submodules/user_final_instructions/0550_sexlab_narration.prompt` uses `contains(_direct_narration, " is orgasming.")`.

**Contract**:
- Orgasming actors’ clauses in Combined/custom narration must include `" is orgasming."`.
- Non-orgasming / denied clauses must not (e.g. `HandleOrgasmDenied`, “did not orgasm”, SeparateOrgasms “failed to orgasm”).
- Dom custom path: `Handler_DOM.DOMSlave_Orgasmed` → `Scene_Manager.OrgasmCustom` appends `". "+name+" is orgasming."` before Scene stashes/sends. Required for the prompt gate.
- Dom Combined fallback: when `_dom_slave`, `orgasm_expected==1`, totals > 0, and custom message empty, Scene still appends `name+" is orgasming. "` so the prompt gate fires if Dom feed raced past Combined.
- Dom feed: sibling `SkyrimNet_DOM_Events.OnOrgasm` must call `DOMSlave_Orgasmed` (do not early-return). Dom `SexLab_AnimationStart` may `DisableOrgasm` on Dom actors so SexLab hooks alone will not narrate them.

**SeparateOrgasms**: Manager skips Dom on `SexLabOrgasm`; `Scene.OrgasmCustom` must use `config.SeparateOrgasms` and call `OrgasmHelper` immediately when Separate is on; otherwise stash into `customer_orgasm_messages` for `HookOrgasmStart` Combined.

## Scene pool / GetSceneInactive None (2026-07-12)

**Symptom**: `Cannot call SetThread() on a None object` in `GetSceneInactive` after `Failed to find inactive sl_scene using generic`, even with **no active SexLab animations** (pool should be free).

**Causes**:
1. Property rename `scenes`/`scene_generic` → `sl_scenes`/`sl_scene_generic`: Auto property fills are **baked into saves**. Old saves keep empty new-name properties; `creators` (unchanged name) still works. Runtime pool looks empty → fallback to None generic → crash.
2. `sl_scene_generic` Auto property unresolved → fallback `SetThread` crashed (no None guard).
3. `STATUS_*` were `Auto` (not `AutoReadOnly`). Saves can corrupt constants so `IsActive()` stays true forever.
4. `Initialize` did not reset `status` / clear stale `thread`.

**Fixes**: `RebuildScenePool()` via `GetFormFromFile` every Setup; None-guard + generic recovery; `STATUS_*` → `AutoReadOnly`; reset `status`/`thread` on Initialize; reclaim by `GetThreadActive()` (not status alone).
