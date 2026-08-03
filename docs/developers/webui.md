# WebUI (SKSE + PrismaUI)

In-game overlay: C++ SKSE plugin, PrismaUI HTML, target/sex menu config.

Quirks: [../../KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md) (PrismaUI view path, action catalog).

## Paths

| Path | Role |
|------|------|
| `SKSE_Source/` | C++ → `SkyrimNet_SexLab.dll` |
| `SKSE/Plugins/SkyrimNet_SexLab.dll` | Built plugin |
| `PrismaUI/views/SkyrimNet_SexLab/index.html` | Overlay HTML under `Data/PrismaUI/views/` |
| `SKSE/Plugins/SkyrimNet_SexLab/webui/` | `actions_index.json`, `menu/target/`, `main_panels/` |
| `optional/handler_udng/` | FOMOD-only UDNG TargetMenu JSON (co-installed with handler ESP) |
| `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` | SkyrimNet plugin schema (e.g. `sexlab.orgasm.delay`) |
| `Scripts/Source/SkyrimNet_SexLab_WebUI.psc` | Target/Sex/YesNo/SceneCreator/Animation natives + `SceneConnections_Show` |

## Layout

```
| MainMenu (10% top/left) | Main panel (10% top/bottom/right) |
| TargetMenu (same width) |                                     |
```

- **MainMenu:** row 1 title `SkyrimNet SexLab`; row 2 `main_panel` pulldown (from `webui/main_panels/`, with JS builtin fallback). Pulldown list includes **None** (clears the right main-panel host). The open menu drops to the **right** over the main-panel area with an opaque background.
- **TargetMenu:** stacked under MainMenu in the left column. OStimNet framework toggle shows sexlab/ostim only (no “framework” label).
- **Main panel host:** one visible panel at a time, selected by the pulldown (builtin **Scene Menu** / Animation).
- Sex Menu / YesNo remain overlay panels outside the main_panel pulldown.

### Scene Menu + AnimationPanel connection

- Both panels share a top **scene** pulldown: `new` (Scene Creator pool) plus each active scene labeled with `GetIntentMessage` (status message).
- JS `onSceneConnectionChange` → Papyrus `WebUI_OnSceneConnectionChange`; list via `SceneConnections_Show` / `WebUI_OnSceneConnectionsRefresh`.
- **Scene Menu** (`scene_creator_panel`): multi-select anim pool. On `new`: Start/Cancel. On active scene: Stop, A/N column, Update (SexLab in-thread cap 128), stage prev/next.
- **AnimationPanel**: single-select focus registry; positions are anim-slot / AnimDb (not actors). Prev/Next/Stop enabled only on an active scene connection. Done saves AnimDb (`onAnimRegistrySave` when not live).

## Lifecycle

- `kDataLoaded`: PrismaUI API, `CreateView("SkyrimNet_SexLab/index.html")`, JS listeners.
- `kPostLoadGame` / `kNewGame`: `WebUI_SetGameReady()` (enables input; reloads ActionCatalog from `webui/`; `configureMainMenu`).
- DomReady / game-ready: `configureMainMenu(BuildMainPanelsCatalog())`.
- Pulldown → JS `onMainPanelChange` → C++ `SwitchMainPanel` (close previous, open next). On key change to Scene Menu / Animation, C++ invokes `mainPanelDidOpen()` → soft connection load (`WebUI_OnSceneConnectionChange` → `SceneCreator_Configure` / `Animation_Menu_Configure`, no HideAll/showPanel). Full `SceneCreator_Open` / `Animation_Menu_Show` remain for YesNo / Custom / hotkey.
- Papyrus → C++ open; C++ → JS `showPanel` for `target_menu_panel` / `sex_menu_panel` / `scene_creator_panel` / `animation_menu_panel` (SC/AM auto-select the matching main_panel entry; idempotent if already selected).
- Catalog: `menu/target/` + `actions_index.json` + `main_panels/`; **Start** merges params and dispatches; **Custom** opens Scene Creator.

### TargetMenu UX

- Root `#target-panel` holds globals + root options + Cancel only. Each opened `pulldown` is its own sibling panel (nav stack); Parameters is a separate confirm panel with **Start** / **Custom**. The cascade row sits in the left column under MainMenu; Scene Creator opens in the right main-panel host.
- Click an action → select it and open the Parameters panel (does not start).
- **Start** / **Custom** snapshot params, then **close all pulldown + Parameters panels** (root TargetMenu stays), then fire `onAction`.
- **Start** → `onAction({action:"start",…})` → `ExecuteAction`. For scene-start actions, C++ sets `SkipSceneCreatorOnce`; Papyrus `Action_Start` consumes it via `ConsumeSkipSceneCreator()` and sets `scene_creator_menu_called` so YesNo / Tag Edit will not open Scene Creator for that scene.
- **Custom** (scene-start actions only) → `onAction({action:"custom",…})` → `OpenSceneCreatorFromTargetMenu` (`_from_target_menu`). TargetMenu root stays open; Custom again reconfigures SC.
- Cancel clears the TargetMenu session. `WebUI_HideAllPanels` spares TargetMenu while that session is active.

### `menu/target/`

Layout under `webui/menu/target/`:

| Path | Role |
|------|------|
| `defaults.json` | `{ "defaultsParameters": { ... } }` (legacy root key `defaults` still accepted) |
| `options/*.json` | One top-level option object per file; **order = lexicographic filename** (use numeric prefixes, e.g. `0000_…`, `0100_…`) |

C++ assembles these into the same in-memory shape JS expects: `defaultsParameters` + `options[]`. Keys are lowercase. Every option node has `type`:

| type | Fields | Role |
|------|--------|------|
| `parameter` | `name`, `default`, `values` | Global param pulldown |
| `action` | `name`, `label`, optional `parameters`, optional `disabled`, optional dispatch fields | Selects action + Parameters panel; confirm with Start/Custom; `disabled` = greyed non-clickable |
| `pulldown` | `label`, `options[]`, optional `parameters` | Group; children are `action` and/or nested `pulldown` |
| `actionSwitch` | `label`, `options[]` of `action` + `eligibilityRules` | C++ picks first eligible child (or disabled fallback label) |

Optional on any option node: `requiresPlugin` (ESP/ESL name) — omitted from the catalog when that mod is not loaded.

**Filesystem dispatch actions** (optional handlers / third parties): an `action` option may carry `plugin`, `questFormId` (local, e.g. `"0x800"`), `scriptName`, `executionFunctionName`, and `parameterMapping`. C++ synthesizes an `ActionDef` so `ExecuteAction` works without an `actions_index` row. Prefer `plugin` + local FormID over EditorID for optional ESPs.

Actor sources: `playerActor` / `currentActor` (aliases `player` / `target` / `focus` still work).

Outfit stay-open: TargetMenu stays open for all Start/Custom (until Cancel). `outfit_dress` / `outfit_undress` still call `Target_Menu_Refresh` after StorageUtil updates.

Menu labels for the target panel come from `menu/target/`. Nested pulldowns open as separate panels in a row (`‹` header pops).

Start merge order: YAML statics → `defaultsParameters` → matching action-node `parameters` → UI dictionary (UI wins).

`actions_index.json` is `{ "actions": [...] }` only — no `by_category`.

### `webui/main_panels/`

One JSON object per file; **order = lexicographic filename**. Optional `requiresPlugin` skips the entry when the mod is missing.

| type | Fields | Role |
|------|--------|------|
| `builtin` | `label`, `panel` | Panel already in PrismaUI (`scene_creator_panel` labeled Scene Menu, `animation_menu_panel`) |
| `papyrus` | `label`, `id`, `plugin`, `questFormId`, `scriptName`, `openFunction`, `closeFunction` | Zero-arg Papyrus open/close on that quest script |

Starters in core: `000_scene_creator_panel.json`, `010_animation_panel.json`. Foreign main panels are filesystem-only (no register native); DOM wiring is deferred.

### Optional integrations (FOMOD / third parties)

Drink your own champagne: official optional packages use the same filesystem JSON contract as third parties. Ship JSON under `Data/SKSE/Plugins/SkyrimNet_SexLab/webui/…` next to the handler ESP. Load order can overwrite files.

**Reference: UDNG** — FOMOD `handler_udng` installs `0600_sexlab_bondage.json` (TargetMenu `bondage` → `SkyrimNet_SexLab_Handler_UDNG.OpenMenu`) plus the handler ESP. Source tree: `optional/handler_udng/…`. Handler `Setup` still registers ModEvents / links; it no longer calls `RegisterTargetMenuOption`.

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

After changing action `label`s: regenerate `actions_index.json` with `tools/generate_actions_index.py`.
