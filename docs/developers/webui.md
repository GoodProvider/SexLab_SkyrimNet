# WebUI (SKSE + PrismaUI)

In-game overlay: C++ SKSE plugin, PrismaUI HTML, target/sex menu config.

Quirks: [../../KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md) (PrismaUI view path, action catalog).

## Paths

| Path | Role |
|------|------|
| `SKSE_Source/` | C++ → `SkyrimNet_SexLab.dll` |
| `SKSE/Plugins/SkyrimNet_SexLab.dll` | Built plugin |
| `PrismaUI/views/SkyrimNet_SexLab/index.html` | Overlay HTML under `Data/PrismaUI/views/` |
| `SKSE/Plugins/SkyrimNet_SexLab/webui/` | `actions_index.json`, `menu/target/` (defaults + options) |
| `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` | SkyrimNet plugin schema (e.g. `sexlab.orgasm.delay`) |
| `Scripts/Source/SkyrimNet_SexLab_WebUI.psc` | `Target_Menu_Open(target, hasStrippedItems, editTagsPlayer, editTagsNonPlayer)` / `Target_Menu_Refresh` / `Sex_Menu_Open` natives |

## Lifecycle

- `kDataLoaded`: PrismaUI API, `CreateView("SkyrimNet_SexLab/index.html")`, JS listeners.
- `kPostLoadGame` / `kNewGame`: `WebUI_SetGameReady()` (enables input; reloads ActionCatalog from `webui/`).
- Papyrus → C++ open; C++ → JS panels `target_menu_panel` / `sex_menu_panel`.
- Catalog: `menu/target/` (typed recursive menu tree with `defaultsParameters`) + `actions_index.json`; **Start** merges params onto YAML and dispatches via SkyrimNet; **Custom** opens Scene Creator with action-derived state.

### TargetMenu UX

- Root `#target-panel` holds globals + root options + Cancel only. Each opened `pulldown` is its own sibling panel (nav stack); Parameters is a separate confirm panel with **Start** / **Custom**. The cascade row sits **above** Scene Creator.
- Click an action → select it and open the Parameters panel (does not start).
- **Start** / **Custom** snapshot params, then **close all pulldown + Parameters panels** (root TargetMenu stays), then fire `onAction`.
- **Start** → `onAction({action:"start",…})` → `ExecuteAction`. For scene-start actions, C++ sets `SkipSceneCreatorOnce`; Papyrus `Action_Start` consumes it via `ConsumeSkipSceneCreator()` and sets `scene_creator_menu_called` so YesNo / Tag Edit will not open Scene Creator for that scene.
- **Custom** (scene-start actions only) → `onAction({action:"custom",…})` → `OpenSceneCreatorFromTargetMenu` (`_from_target_menu`). TargetMenu root stays open above Scene Creator; Custom again reconfigures SC.
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
| `action` | `name`, `label`, optional `parameters`, optional `disabled` | Selects action + Parameters panel; confirm with Start/Custom; `disabled` = greyed non-clickable |
| `pulldown` | `label`, `options[]`, optional `parameters` | Group; children are `action` and/or nested `pulldown` |
| `actionSwitch` | `label`, `options[]` of `action` + `eligibilityRules` | C++ picks first eligible child (or disabled fallback label) |

Actor sources: `playerActor` / `currentActor` (aliases `player` / `target` / `focus` still work).

Outfit stay-open: TargetMenu stays open for all Start/Custom (until Cancel). `outfit_dress` / `outfit_undress` still call `Target_Menu_Refresh` after StorageUtil updates.

Menu labels for the target panel come from `menu/target/`. Nested pulldowns open as separate panels in a row (`‹` header pops).

Start merge order: YAML statics → `defaultsParameters` → matching action-node `parameters` → UI dictionary (UI wins).

`actions_index.json` is `{ "actions": [...] }` only — no `by_category`.

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
