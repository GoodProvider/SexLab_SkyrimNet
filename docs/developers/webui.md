# WebUI (SKSE + PrismaUI)

In-game overlay: C++ SKSE plugin, PrismaUI HTML, target/sex menu config.

Quirks: [../../KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md) (PrismaUI view path, action catalog).

## Paths

| Path | Role |
|------|------|
| `SKSE_Source/` | C++ → `SkyrimNet_SexLab.dll` |
| `SKSE/Plugins/SkyrimNet_SexLab.dll` | Built plugin |
| `PrismaUI/views/SkyrimNet_SexLab/index.html` | Overlay HTML under `Data/PrismaUI/views/` |
| `SKSE/Plugins/SkyrimNet_SexLab/webui/` | `target_options.json`, `actions_index.json`, `TargetMenu/Actor/options/` |
| `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` | SkyrimNet plugin schema (e.g. `sexlab.orgasm.delay`) |
| `Scripts/Source/SkyrimNet_SexLab_WebUI.psc` | `Target_Menu_Open` / `Sex_Menu_Open` / `Hide` natives |

## Lifecycle

- `kDataLoaded`: PrismaUI API, `CreateView("SkyrimNet_SexLab/index.html")`, JS listeners.
- `kPostLoadGame` / `kNewGame`: `WebUI_SetGameReady()`.
- Papyrus → C++ open; C++ → JS panels `target_menu_panel` / `sex_menu_panel`.
- Catalog: `target_options.json` + `actions_index.json` (ActionCatalog does not load `webui/TargetMenu/` or `MainPanels/`). Start merges params onto YAML and dispatches via SkyrimNet.
- Options with `requiresPlugin` are omitted from the catalog when that ESP is not loaded.
- `type: handoff` (e.g. `leash` → `SkyrimNet_Leashed.esp`): click hides this overlay (`Hide` / `Reset_To_Default`) and `DispatchMethodCall` `EventSend_LeashedOpen` (`SkyrimNet_Leashed_OpenPanel`).

## Build

CMake tasks in `.vscode/tasks.json` with `cwd` = `SKSE_Source`. Needs VS 2022, `VCPKG_ROOT`, `x64-windows-static`.

Papyrus C++ bindings declare SkyrimNet PublicAPI symbols as `extern` function pointers (`PublicFormIDToUUID`, …). Do not `#include "PublicAPI.h"` from this plugin.

| Task | Effect |
|------|--------|
| `CMake: Configure (Debug\|Release)` | submodule init + cmake preset |
| `CMake: Build SKSE (Debug\|Release)` | build + copy DLL → `SKSE/Plugins/` |

## PrismaUI

Hard dependency ([Nexus](https://www.nexusmods.com/skyrimspecialedition/mods/148718)); not shipped here.

**View path:** `CreateView("SkyrimNet_SexLab/index.html")` resolves under **`Data/PrismaUI/views/`**, not `SKSE/Plugins/`. Missing file → open path looks fine, no visible UI.

After changing action `label`s: regenerate `actions_index.json` with `tools/generate_actions_index.py`.
