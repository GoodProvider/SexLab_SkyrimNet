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
| `SKSE/Plugins/SkyrimNet_SexLab/webui/TargetMenu/Actor/options/0600_sexlab_bondage.json` | Bondage TargetMenu option (live catalog; `make release` moves it into FOMOD `handler_udng/`) |
| `SKSE/Plugins/SkyrimNet_SexLab/bondage/group-devices.json` | Handler device groups (live; same release split) |
| `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` | SkyrimNet plugin settings schema (control store) |
| `Scripts/Source/SkyrimNet_SexLab_WebUI.psc` | Target/Sex/YesNo/SceneCreator/Animation natives + `SceneConnections_Show` + `SceneInfos_Seed` |

## Layout

```
| ControlPanel (10% top/left) | Main panel (10% top/bottom/right) |
| TargetMenu (same width)     |                                     |
```

- **ControlPanel** (`#control-panel`): row 1 title `SkyrimNet SexLab`; row 2 `main_panel` pulldown (from `webui/MainPanels/`, with JS builtin fallback); row 3 OStimNet-gated **framework** pulldown (`#framework-row`, `sexlab`/`ostim`, no label, hidden unless OStimNet); row 4 **actor focus** pulldown (`#control-actor-pulldown`). Main-panel list includes **None** (clears the right main-panel host). Pulldowns open to the **right** over the main-panel area with an opaque background.
- **Actor focus pulldown:** nearby actors (player pinned first), sorted sexlab → eligible → ineligible, then distance. Labels: name cropped to 10 chars; `(sexlab)` selectable; no suffix = eligible; `(reason)` greyed (`child`/`cmbt`/`ostim`/`dead`/`load`, ≤5 chars). Selection sets `Target_Current` and switches the selected **SceneInfo** to that actor’s thread if any, else the Scene Creator (`new`) SceneInfo. Default: crosshair if present, else nearest selectable non-player, else player.
- **Always paused while open:** `Focus(view, true)` on Show. There is no pause/unpause toggle (it would let SexLab threads drift from SceneInfo drafts). Log tailing is file I/O and still works. AnimDB rebuild that needs `RegisterForSingleUpdate` waits until the overlay closes.
- **TargetMenu:** stacked under ControlPanel in the left column (no actor name header — focus is the ControlPanel pulldown).
- **Main panel host:** one visible panel at a time, selected by the pulldown (builtin Scene Menu / Animation / Log / Settings).
- Sex Menu / YesNo remain overlay panels outside the main_panel pulldown.

### SceneInfo (shared scene draft)

JS `SceneInfo` map: one instance per active SexLab scene (`scene:<sid>`) plus one `'new'` Scene Creator draft. Seeded from Papyrus `BuildAllSceneInfosJson` on overlay Show (`SceneInfos_Seed`). Actor focus selects the thread that contains that actor, or `'new'`. Switching actors does not wipe `'new'`.

Panels copy the selected SceneInfo into a local draft on open. **Start / Done / Update / Stop / silent / explain** write the draft into SceneInfo. **Cancel** (and leaving a panel without confirming) does not. Overlay **Cancel / Escape** hide **without** committing — dirty SceneInfos are dropped. Non-Cancel hide (hotkey, Scene Menu Start, TargetMenu action Start) flushes dirty SceneInfos (`WebUI_OnSceneInfoCommit`) then Unfocus so `StartThread` can run.

### Scene Menu + AnimationPanel connection

- Focus actor owns the selected SceneInfo (or `"new"` creator state). Duplicate scene pulldowns on Scene Menu / AnimationPanel were removed.
- Opening Scene Menu / Animation binds the panel to the selected SceneInfo (`mainPanelDidOpen`). Do not re-fetch Papyrus snapshots on actor change (that wiped drafts).
- **Scene Menu** (`scene_creator_panel`): multi-select anim pool. On `new`: Start (apply + `pendingCreate` + commit-hide) / Cancel (no SceneInfo write). On active scene: Stop (`pendingStop`), A/N column, Update (writes anim pool into SceneInfo; SexLab in-thread cap 128 applied on commit), stage prev/next stay in the draft until Update/Stop.
- **Filter-by downgrade:** each Scene Creator / Scene Menu open arms `gender → none` (`scArmFilterDowngrade`; default `gender`). A query returning zero anims steps to the next looser mode and re-queries, so the pulldown shows the mode actually used. Re-armed once actor meta resolves (genders arrive after the first query). Picking a mode manually pins it for that open (`positions` remains a pulldown option). Callers wanting a different start set `SC.filterByOnce` before `configureSceneCreator` (SceneStartPanel **Custom** uses `none` for nonsexual/affection methods, which leaves no fallbacks; other Custom uses `gender`).
- **AnimationPanel**: in-thread name picker (no 10-cap). Filter input matches substring on name/registry; list scrolls inside `#main-panel-host`. Click a name selects it in the panel draft; **Done** writes `activeRegistry` into SceneInfo. Stage/position/stop editing lives on TargetMenu Scene panels (Done applies to SceneInfo).
- **Animation open preference:** C++ remembers whether Animation was the selected main panel across hide. Hotkey restores Animation only when the focus actor is in SexLab **and** that preference is true.
- **Hotkey toggle:** if the overlay is visible, the menu hotkey hides it immediately (any ControlPanel focus actor) and does **not** dispatch `ProcessHotkey`. Hidden → `Menu.ProcessHotkey` → `Target_Menu_Open` (rebuild if same actor, else full open). Close does not clear `Target_Current`. Show/Focus only after DomReady; missing overlay HTML does not pause the game. Escape uses JS `handleGlobalEscape` when ready; C++ Unfocus/Hide if DomReady never fired.

## Lifecycle

- `kDataLoaded`: PrismaUI API, `CreateView("SkyrimNet_SexLab/index.html")`, JS listeners.
- `kPostLoadGame` / `kNewGame`: `WebUI_SetGameReady()` (enables input; reloads ActionCatalog from `webui/`; `configureControlPanel`).
- DomReady / game-ready: `configureControlPanel(BuildMainPanelsCatalog())`.
- Pulldown → JS `onMainPanelChange` → C++ `SwitchMainPanel` (close previous, open next). On key change to Scene Menu / Animation, C++ invokes `mainPanelDidOpen()` → bind the selected SceneInfo into that panel’s local draft (no Papyrus `WebUI_OnSceneConnectionChange`). Scene Menu **Update** writes into SceneInfo; SexLab anim-list apply happens on overlay commit. Full `SceneCreator_Open` / `Animation_Menu_Show` remain for YesNo / Custom / hotkey.
- Papyrus → C++ open; C++ → JS `showPanel` for `target_menu_panel` / `sex_menu_panel` / `scene_creator_panel` / `animation_menu_panel` (SC/AM auto-select the matching main_panel entry; idempotent if already selected).
- Catalog: `TargetMenu/Actor` or `TargetMenu/Scene` (from ControlPanel SexLabAnimatingFaction) + `actions_index.json` + `MainPanels/`; **Start** merges params and dispatches; **Custom** opens Scene Creator.

### TargetMenu UX

- Root `#target-panel` holds globals + root options + Cancel only (no `#target-name`). Each opened `pulldown` is its own sibling panel (nav stack); Parameters is a separate confirm panel with **Start** / **Custom**. The cascade row sits in the left column under ControlPanel; Scene Creator opens in the right main-panel host.
- Mid-scene **Scene** catalog (focus in SexLabAnimatingFaction): **stop** (speaker pulldown + silent/stop/explain → SceneInfo `pendingStop`), **stage** (index + editable description; **Done** writes SceneInfo), **position** (Scene Creator-style whole-cast table; **Done** writes SceneInfo), **animation** (opens AnimationPanel picker in the main host), **save to json**.
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
| `papyrus` | `label` (no `name`), `plugin`, `questFormId`, `scriptName`, `executionFunctionName`, `parameterMapping`, optional `eligibilityRules`, optional `closeWebUI` / `confirmSave` / `explainPrompt` / `panel`, optional `panelDefaults` | TargetMenu-only Papyrus call via `onAction({action:"papyrus",...})` — no YAML / `actions_index`. Actor **`panel: scene_start`** is the shared sentence UI. Actor **`panel: outfit`**: sentence `position_1` / style (`forcefully|normally|gently|silently`) / undresses|dresses / `position_0`; **Start** only (no Custom); `TM_Outfit`; style `silently` skips SkyrimNet narration. Actor **`panel: bondage`**: speaker / style / `changes devices on` / target; per-group `label: Pulldown`; pulldowns edit JS `ActorBondage.current` only (no live apply); **Cancel** / hide discard the session; **Done** applies `currentJson` (`TM_BondageFinish`) then narrates unless `silently` and `WebUI_CloseOverlay`; no Custom; FOMOD + `requiresPlugin: Devious Devices - Assets.esm`. Scene panels: **`stop`** (speaker pulldown + silent/stop/explain → SceneInfo `pendingStop`), **`stage`** / **`position`** (edit draft; **Done** writes SceneInfo), **`animation`** (opens AnimationPanel; **Done** writes `activeRegistry`). Apply to SexLab on overlay commit. `panelDefaults` seeds SceneStartPanel (Subject, `andThird` none/and, Object `with`/`to victim`/`none`, intent, direction, method, style, setting). Intent **custom** opens IntentPanel (text, Cancel, Ok). Hug/cuddle/kiss giver is SexLab pos1 when intent is `show affection` / `comfort` (or the long Papyrus labels) or method is `cuddling|kissing|hug`. |

| `pulldown` | `label`, `options[]`, optional `parameters`, optional `eligibilityRules` | Group; children are `action` and/or nested `pulldown`. Optional `eligibilityRules` evaluated at catalog build against `currentActor`; fail → option omitted |
| `actionSwitch` | `label`, `options[]` of `action` + `eligibilityRules` | C++ picks first eligible child (or disabled fallback label) |

Optional on any option node: `requiresPlugin` (ESP/ESL name) — omitted from the catalog when that mod is not loaded.

**Filesystem dispatch actions** (optional handlers / third parties): an `action` option may carry `plugin`, `questFormId` (local, e.g. `"0x800"`), `scriptName`, `executionFunctionName`, and `parameterMapping`. C++ synthesizes an `ActionDef` so `ExecuteAction` works without an `actions_index` row. Prefer `plugin` + local FormID over EditorID for optional ESPs.

Actor sources: `playerActor` / `currentActor` (aliases `player` / `target` / `focus` still work).

Outfit: Actor catalog `panel: outfit` (undress/dress via FormListCount eligibility) → `TM_Outfit(speaker, target, style)`. Sentence UI; **Start** closes WebUI (no Custom). Style `silently` skips DirectNarration and RegisterEvent. `Outfit_Dress` / `Outfit_Undress` still call `Target_Menu_Refresh` after storage updates (no-ops when menu is closed). LLM YAML `outfit_dress` / `outfit_undress` is unchanged.

Bondage: Actor catalog `SKSE/Plugins/SkyrimNet_SexLab/webui/TargetMenu/Actor/options/0600_sexlab_bondage.json` (`panel: bondage`, `requiresPlugin: Devious Devices - Assets.esm`). Click opens BondagePanel (speaker / style / target), top-aligned with ControlPanel. Each group is `label: Pulldown` (`none` + devices, head-to-foot including Body and Legs). Per-actor **ActorBondage** seeds original+current from worn on first current-actor select; later Refresh must not clobber `current`. Pulldown change writes `current` only (no Papyrus). `bondagePatchPulldowns` seeds from `current`. **Cancel** closes the panel only (Map kept until overlay hide). **Done** → `TM_BondageFinish(speaker, target, style, currentJson)` applies `SetGroupToId` per group, narrates unless `silently`, `ReleaseAll`, `WebUI_CloseOverlay` (`closeWebUI: false` so C++ does not Hide first). Hotkey/Escape hide: `bondageReleaseAll()` + `TM_BondageOnWebUIClosed` ReleaseAll only (no device restore). LLM lock/unlock actions stay in SkyrimNet_UDNG. `zadLibs` is Handler-only so the main ESP loads without DD. Repo/MO2 sees the SKSE tree; `make release` moves this JSON and `bondage/group-devices.json` into FOMOD `handler_udng/` with the handler ESP (see KNOWLEDGEBASE **Optional SKSE files / FOMOD split**).

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

**Reference: bondage / DD** — live files are `webui/TargetMenu/Actor/options/0600_sexlab_bondage.json` (TargetMenu `bondage` → BondagePanel `label: Pulldown` rows → `Handler_UDNG.TM_Bondage*`) and `bondage/group-devices.json` (head-to-foot groups including Body / Legs). Recommended when `Devious Devices - Assets.esm` is active. `make release` moves both into FOMOD `handler_udng/` with the handler ESP (KNOWLEDGEBASE **Optional SKSE files / FOMOD split**). Handler `Setup` registers ModEvents / loads `zadLibs`; it does not call `RegisterTargetMenuOption` and does not depend on `SkyrimNetUDNG.esp`.

`RegisterTargetMenuOption` remains in the API for legacy callers but is not used by the bondage handler.

## Build

CMake tasks in `.vscode/tasks.json` with `cwd` = `SKSE_Source`. Needs VS 2022, `VCPKG_ROOT`, `x64-windows-static`.

| Task | Effect |
|------|--------|
| `CMake: Configure (Debug\|Release)` | submodule init + cmake preset |
| `CMake: Build SKSE (Debug\|Release)` | build + copy DLL → `SKSE/Plugins/` |

## PrismaUI

Hard dependency ([Nexus](https://www.nexusmods.com/skyrimspecialedition/mods/148718)); the PrismaUI **plugin** is not shipped here.

**View path:** `CreateView("SkyrimNet_SexLab/index.html")` resolves under **`Data/PrismaUI/views/`**, not `SKSE/Plugins/`. This mod’s overlay HTML **is** shipped: `make release` copies `PrismaUI/` into FOMOD `core`. Missing file → open path looks fine; do not `Focus` until DomReady or the game pauses with a blank overlay (Escape is JS-only unless C++ Hide runs).

**Display scale:** Overlay matches SkyrimNet’s system — px design tokens (~15px base), `body.style.zoom` × Dashboard `ui_scale` × up-only 1080p baseline, scrollable left-column / panel shells. See [KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md).

After changing action `label`s: regenerate `actions_index.json` with `tools/generate_actions_index.py`.
