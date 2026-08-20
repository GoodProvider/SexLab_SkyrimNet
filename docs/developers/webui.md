# WebUI (SKSE + PrismaUI)

In-game overlay: C++ SKSE plugin, PrismaUI HTML, target/sex menu config.

Quirks: [../../KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md) (PrismaUI view path, action catalog).

## Paths

| Path | Role |
|------|------|
| `SKSE_Source/` | C++ → `SkyrimNet_SexLab.dll` |
| `SKSE/Plugins/SkyrimNet_SexLab.dll` | Built plugin |
| `PrismaUI/views/SkyrimNet_SexLab/index.html` | Overlay HTML under `Data/PrismaUI/views/` |
| `SKSE/Plugins/SkyrimNet_SexLab/webui/` | `actions_index.json`, `TargetMenu/Actor/`, `TargetMenu/Scene/`, `MainPanels/` |
| `optional/handler_udng/` | FOMOD-only UDNG TargetMenu JSON (co-installed with handler ESP) |
| `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` | SkyrimNet plugin settings schema (control store) |
| `Scripts/Source/SkyrimNet_SexLab_WebUI.psc` | Target/Sex/YesNo/SceneCreator/Animation natives + `SceneConnections_Show` |

## Layout

```
| ControlPanel (10% top/left) | Main panel (10% top/bottom/right) |
| TargetMenu (same width)     |                                     |
```

- **ControlPanel** (`#control-panel`): row 1 title `SkyrimNet SexLab`; row 2 `main_panel` pulldown (from `webui/MainPanels/`, with JS builtin fallback); row 3 pause/unpause; row 4 OStimNet-gated **framework** pulldown (`#framework-row`, `sexlab`/`ostim`, no label, hidden unless OStimNet); row 5 **actor focus** pulldown (`#control-actor-pulldown`). Main-panel list includes **None** (clears the right main-panel host). Pulldowns open to the **right** over the main-panel area with an opaque background.
- **Actor focus pulldown:** nearby actors (player pinned first), sorted sexlab → eligible → ineligible, then distance. Labels: name cropped to 10 chars; `(sexlab)` selectable; no suffix = eligible; `(reason)` greyed (`child`/`cmbt`/`ostim`/`dead`/`load`, ≤5 chars). Selection sets `Target_Current` for TargetMenu / Scene Menu / AnimationPanel (`onControlActorChange` → `WebUI_OnControlActorFocus`). Default: crosshair if present, else nearest selectable non-player, else player.
- **Pause toggle:** WebUI opens with `Focus(view, true)` (game paused; button shows **unpause**). Click unpause → `Focus(view, false)` (game runs, UI stays focused/visible; button shows **pause**). Needed so AnimDB/`RegisterForSingleUpdate` and Log tailing can progress while the overlay stays open.
- **TargetMenu:** stacked under ControlPanel in the left column (no actor name header — focus is the ControlPanel pulldown).
- **Main panel host:** one visible panel at a time, selected by the pulldown (builtin Scene Menu / Animation / Log / Settings).
- Sex Menu / YesNo remain overlay panels outside the main_panel pulldown.

### Scene Menu + AnimationPanel connection

- Focus actor owns the active scene (or `"new"` creator state). Duplicate scene pulldowns on Scene Menu / AnimationPanel were removed.
- Soft reload still uses JS `SCENE_CONNECTION` + Papyrus `WebUI_OnSceneConnectionChange` / `SceneCreator_Configure` / `Animation_Menu_Configure` when the ControlPanel actor changes or a main panel opens (`mainPanelDidOpen`).
- **Scene Menu** (`scene_creator_panel`): multi-select anim pool. On `new`: Start/Cancel. On active scene: Stop, A/N column, Update (SexLab in-thread cap 128), stage prev/next.
- **Filter-by downgrade:** each Scene Creator / Scene Menu open arms `gender → none` (`scArmFilterDowngrade`; default `gender`). A query returning zero anims steps to the next looser mode and re-queries, so the pulldown shows the mode actually used. Re-armed once actor meta resolves (genders arrive after the first query). Picking a mode manually pins it for that open (`positions` remains a pulldown option). Callers wanting a different start set `SC.filterByOnce` before `configureSceneCreator` (SceneStartPanel **Custom** uses `none` for nonsexual/affection methods, which leaves no fallbacks; other Custom uses `gender`).
- **AnimationPanel**: in-thread name picker (no 10-cap). Filter input matches substring on name/registry; list scrolls inside `#main-panel-host`. Click a name → `TM_SetAnimationIndex`. Stage/position/stop editing lives on TargetMenu Scene panels.
- **Animation open preference:** C++ remembers whether Animation was the selected main panel across hide. Hotkey restores Animation only when the focus actor is in SexLab **and** that preference is true.
- **Hotkey toggle:** if the overlay is visible, the menu hotkey hides it immediately (any ControlPanel focus actor) and does **not** dispatch `ProcessHotkey`. Hidden → `Menu.ProcessHotkey` → `Target_Menu_Open` (rebuild if same actor, else full open). Close does not clear `Target_Current`. Escape still goes through `handleGlobalEscape`.

## Lifecycle

- `kDataLoaded`: PrismaUI API, `CreateView("SkyrimNet_SexLab/index.html")`, JS listeners.
- `kPostLoadGame` / `kNewGame`: `WebUI_SetGameReady()` (enables input; reloads ActionCatalog from `webui/`; `configureControlPanel`).
- DomReady / game-ready: `configureControlPanel(BuildMainPanelsCatalog())`.
- Pulldown → JS `onMainPanelChange` → C++ `SwitchMainPanel` (close previous, open next). On key change to Scene Menu / Animation, C++ invokes `mainPanelDidOpen()` → soft connection load (`WebUI_OnSceneConnectionChange` → `SceneCreator_Configure` / `Animation_Menu_Configure`, no HideAll/showPanel). SceneMenu **Update** (`WebUI_OnAnimUpdate`) also refreshes via Configure. Full `SceneCreator_Open` / `Animation_Menu_Show` remain for YesNo / Custom / hotkey.
- Papyrus → C++ open; C++ → JS `showPanel` for `target_menu_panel` / `sex_menu_panel` / `scene_creator_panel` / `animation_menu_panel` (SC/AM auto-select the matching main_panel entry; idempotent if already selected).
- Catalog: `TargetMenu/Actor` or `TargetMenu/Scene` (from ControlPanel SexLabAnimatingFaction) + `actions_index.json` + `MainPanels/`; **Start** merges params and dispatches; **Custom** opens Scene Creator.

### TargetMenu UX

- Root `#target-panel` holds globals + root options + Cancel only (no `#target-name`). Each opened `pulldown` is its own sibling panel (nav stack); Parameters is a separate confirm panel with **Start** / **Custom**. The cascade row sits in the left column under ControlPanel; Scene Creator opens in the right main-panel host.
- Mid-scene **Scene** catalog (focus in SexLabAnimatingFaction): **stop** (speaker pulldown + silent/stop/explain), **stage** (index + editable description), **position** (Scene Creator-style whole-cast table), **animation** (opens AnimationPanel picker in the main host), **save to json**.
- Click an action → select it and open the Parameters panel (does not start).
- **Start** / **Custom** snapshot params, then **close all pulldown + Parameters panels**, then fire `onAction`.
- **Start** → `onAction({action:"start",…})` → `ExecuteAction`, then **closes WebUI** (clear TargetMenu session + hide overlay, same as Cancel) so SexLab `StartThread` runs unpaused. For scene-start actions, C++ sets `SkipSceneCreatorOnce`; Papyrus `Action_Start` consumes it via `ConsumeSkipSceneCreator()` and sets `scene_creator_menu_called` so that scene skips Scene Creator **and** YesNo (treated as Yes/Random). SceneStartPanel **Start** (`action:"papyrus"` + `closeWebUI` + `StartScene_*`) sets the same flag; Custom / live papyrus rows do not. Scene Creator **Start** (including after TargetMenu Custom) also clears the TargetMenu session and hides the overlay; Cancel from Scene Creator still keeps TargetMenu open.
- **Custom** (scene-start actions only) → `onAction({action:"custom",…})` → `OpenSceneCreatorFromTargetMenu` (`_from_target_menu`). TargetMenu root stays open; Custom again reconfigures SC.
- Cancel clears the TargetMenu session. `WebUI_HideAllPanels` spares TargetMenu while that session is active.

### `TargetMenu/`

C++ loads **both** trees at `Load()` and `BuildUICatalog` picks one from ControlPanel focus `SexLabAnimatingFaction`:

| Path | Role |
|------|------|
| `TargetMenu/Actor/defaults.json` | `{ "defaultsParameters": { ... } }` (legacy root key `defaults` still accepted) |
| `TargetMenu/Actor/options/*.json` | Start-scene + outfit (not animating) |
| `TargetMenu/Scene/options/*.json` | Live-scene group editors (animating) |

**Order = lexicographic filename** (numeric prefixes). Keys are lowercase. Every option node has `type`:

| type | Fields | Role |
|------|--------|------|
| `parameter` | `name`, `default`, `values` | Global param pulldown |
| `action` | `name`, `label`, optional `parameters`, optional `disabled`, optional dispatch fields | Selects action + Parameters panel; confirm with Start/Custom; `disabled` = greyed non-clickable |
| `papyrus` | `label` (no `name`), `plugin`, `questFormId`, `scriptName`, `executionFunctionName`, `parameterMapping`, optional `eligibilityRules`, optional `closeWebUI` / `confirmSave` / `explainPrompt` / `panel`, optional `panelDefaults` | TargetMenu-only Papyrus call via `onAction({action:"papyrus",...})` — no YAML / `actions_index`. Actor **`panel: scene_start`** is the shared sentence UI. Scene panels: **`stop`** (speaker pulldown + silent/stop/explain), **`stage`** (index jumps; description edits `TM_SetStageDescription`), **`position`** (whole-cast Scene Creator table → `TM_ChangeActors` / clothed / O / V / speaking chips), **`animation`** (opens AnimationPanel in the main host). `panelDefaults` seeds SceneStartPanel (Subject, `andThird` none/and, Object `with`/`to victim`/`none`, intent, direction, method, style, setting). Intent **custom** opens IntentPanel (text, Cancel, Ok). Hug/cuddle/kiss giver is SexLab pos1 when intent is `show affection` / `comfort` (or the long Papyrus labels) or method is `cuddling|kissing|hug`. |

| `pulldown` | `label`, `options[]`, optional `parameters`, optional `eligibilityRules` | Group; children are `action` and/or nested `pulldown`. Optional `eligibilityRules` evaluated at catalog build against `currentActor`; fail → option omitted |
| `actionSwitch` | `label`, `options[]` of `action` + `eligibilityRules` | C++ picks first eligible child (or disabled fallback label) |

Optional on any option node: `requiresPlugin` (ESP/ESL name) — omitted from the catalog when that mod is not loaded.

**Filesystem dispatch actions** (optional handlers / third parties): an `action` option may carry `plugin`, `questFormId` (local, e.g. `"0x800"`), `scriptName`, `executionFunctionName`, and `parameterMapping`. C++ synthesizes an `ActionDef` so `ExecuteAction` works without an `actions_index` row. Prefer `plugin` + local FormID over EditorID for optional ESPs.

Actor sources: `playerActor` / `currentActor` (aliases `player` / `target` / `focus` still work).

Outfit: TargetMenu closes on **Start** (session cleared); `outfit_dress` / `outfit_undress` still call `Target_Menu_Refresh` after storage updates (no-ops when menu is closed). **Custom** keeps TargetMenu open until Cancel.

Menu labels for the target panel come from `TargetMenu/Actor` or `TargetMenu/Scene`. Nested pulldowns open as separate panels in a row (`‹` header pops).

Start merge order: YAML statics → `defaultsParameters` → matching action-node `parameters` → UI dictionary (UI wins).

`actions_index.json` is `{ "actions": [...] }` only — no `by_category`.

### `webui/MainPanels/`

One JSON object per file; **order = lexicographic filename**. Optional `requiresPlugin` skips the entry when the mod is missing.

| type | Fields | Role |
|------|--------|------|
| `builtin` | `label`, `panel` | Panel already in PrismaUI (`log_panel`, `settings_panel`, `scene_creator_panel` labeled Scene Menu, `animation_menu_panel`) |
| `papyrus` | `label`, `id`, `plugin`, `questFormId`, `scriptName`, `openFunction`, `closeFunction` | Zero-arg Papyrus open/close on that quest script |

Starters in core: `0900_log_panel.json` (Log), `1000_settings.json` (Settings), `0100_scene_creator_panel.json`, `0200_animation_panel.json`. Foreign main panels are filesystem-only (no register native); DOM wiring is deferred.

**Settings panel:** rebuild AnimationDB (then switches main panel to Log with follow-tail), version from `Data/SKSE/Plugins/SkyrimNet_SexLab/info.json` (fallback `Config::kPluginVersion`), docs URL shown as text (`https://github.com/GoodProvider/SkyrimNet_SexLab` — no `ShellExecute`), **Open SkyrimNet dashboard** hides this WebUI then `SkyrimNetApi.TriggerToggleDashboard()` (navigate Plugins → SkyrimNet_SexLab; no deep-link API). Plugin config schema: `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml`. C++ reads via `PublicGetPluginConfigValue("SkyrimNet_SexLab", …)`; Papyrus via `SkyrimNetApi.GetConfig*("Plugin_SkyrimNet_SexLab", …)`.

**Log panel:** reads `SKSE::log::log_directory()` / `SkyrimNet_SexLab.log` (same sink as `webui_log` / Papyrus `TraceLog`). Regex filter in JS; follow-tail unless the user scrolls away. C++ tails by file offset; JS polls `onLogPoll` while visible.

### Optional integrations (FOMOD / third parties)

Drink your own champagne: official optional packages use the same filesystem JSON contract as third parties. Ship JSON under `Data/SKSE/Plugins/SkyrimNet_SexLab/webui/…` next to the handler ESP. Load order can overwrite files.

**Reference: UDNG** — FOMOD `handler_udng` installs `0600_sexlab_bondage.json` under `webui/TargetMenu/Actor/options/` (TargetMenu `bondage` → `SkyrimNet_SexLab_Handler_UDNG.OpenMenu`) plus the handler ESP. Source tree: `optional/handler_udng/…`. Handler `Setup` still registers ModEvents / links; it no longer calls `RegisterTargetMenuOption`.

`RegisterTargetMenuOption` remains in the API for legacy callers but is not used by UDNG.

## Build

CMake tasks in `.vscode/tasks.json` with `cwd` = `SKSE_Source`. Needs VS 2022, `VCPKG_ROOT`, `x64-windows-static`.

| Task | Effect |
|------|--------|
| `CMake: Configure (Debug\|Release)` | submodule init + cmake preset |
| `CMake: Build SKSE (Debug\|Release)` | build + copy DLL → `SKSE/Plugins/` |

## PrismaUI

Hard dependency ([Nexus](https://www.nexusmods.com/skyrimspecialedition/mods/148718)); not shipped here.

**View path:** `CreateView("SkyrimNet_SexLab/index.html")` resolves under **`Data/PrismaUI/views/`**, not `SKSE/Plugins/`. Missing file → open path looks fine, no visible UI.

**Display scale:** Overlay matches SkyrimNet’s system — px design tokens (~15px base), `body.style.zoom` × Dashboard `ui_scale` × up-only 1080p baseline, scrollable left-column / panel shells. See [KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md).

After changing action `label`s: regenerate `actions_index.json` with `tools/generate_actions_index.py`.
