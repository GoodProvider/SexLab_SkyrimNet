# WebUI (SKSE + PrismaUI)

In-game overlay: C++ SKSE plugin, PrismaUI HTML, target/sex menu config.

Quirks: [../../KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md) (PrismaUI view path, action catalog).

## Paths

| Path | Role |
|------|------|
| `SKSE_Source/` | C++ → `SkyrimNet_SexLab.dll` |
| `SKSE/Plugins/SkyrimNet_SexLab.dll` | Built plugin |
| `PrismaUI/views/SkyrimNet_SexLab/index.html` | Overlay HTML under `Data/PrismaUI/views/` |
| `SKSE/Plugins/SkyrimNet_SexLab/webui/` | `target_options.json`, `actions_index.json` |
| `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` | SkyrimNet plugin schema (e.g. `sexlab.orgasm.delay`) |
| `Scripts/Source/SkyrimNet_SexLab_WebUI.psc` | `Target_Menu_Open` / `Sex_Menu_Open` natives |

## Lifecycle

- `kDataLoaded`: PrismaUI API, `CreateView("SkyrimNet_SexLab/index.html")`, JS listeners.
- `kPostLoadGame` / `kNewGame`: `WebUI_SetGameReady()` (enables input; reloads ActionCatalog from `webui/`).
- Papyrus → C++ open; C++ → JS panels `target_menu_panel` / `sex_menu_panel`.
- Catalog: `target_options.json` (typed recursive menu tree) + `actions_index.json`; Start merges params onto YAML and dispatches via SkyrimNet.

### `target_options.json`

Root: `defaults` + `options[]`. Every option node has `type`:

| type | Fields | Role |
|------|--------|------|
| `parameter` | `name`, `default`, `values` | Global param pulldown |
| `action` | `name`, `label` | Starts SkyrimNet action `name`; UI text = `label` |
| `pulldown` | `label`, `options[]` | Group; children are `action` and/or nested `pulldown` |

Menu labels live only in `target_options.json` (not YAML / index). Prefer promoting a single-child pulldown to a top-level `action`. Nested pulldowns use a middle-column nav stack (`‹` header pops).

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
