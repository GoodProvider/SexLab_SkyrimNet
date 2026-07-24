# WebUI (SKSE + PrismaUI)

Guide for the in-game WebUI overlay: C++ SKSE plugin, PrismaUI HTML view, and target/sex menu config.

See also: [KNOWLEDGEBASE.md](../KNOWLEDGEBASE.md) (PrismaUI view path, WebUI target menu catalog), [AGENTS.md](../AGENTS.md) (repo-wide agent rules).

## Key paths

| Path | Role |
|------|------|
| `SKSE_Source/` | C++ / CommonLibSSE-NG → `SkyrimNet_SexLab.dll` |
| `SKSE/Plugins/SkyrimNet_SexLab.dll` | Built plugin (copied by CMake build tasks) |
| `PrismaUI/views/SkyrimNet_SexLab/index.html` | Overlay HTML (loads under `Data/PrismaUI/views/`) |
| `SKSE/Plugins/SkyrimNet_SexLab/webui/` | `target_options.json`, `actions_index.json` |
| `Scripts/Source/SkyrimNet_SexLab_WebUI.psc` | Papyrus stub: `Target_Menu_Open` / `Sex_Menu_Open` (global natives) |
| `SKSE_Source/src/` | Plugin entry (`plugin.cpp`), WebUI, Papyrus bindings, ActionCatalog / ActionDispatch |
| `SKSE_Source/include/` | Public headers (`WebUI.h`, `ActionCatalog.h`, `ActionDispatch.h`) |
| `SKSE_Source/lib/PrismaUI/` | Vendored `PrismaUI_API.h` (do not edit casually) |
| `SKSE_Source/lib/CommonLibSSE-NG/` | Git submodule (CommonLib) |

## SKSE_Source (C++ plugin)

`SKSE_Source/` builds the optional SKSE DLL that drives the PrismaUI WebUI (target / sex menus). Papyrus still owns scene logic; the DLL exposes natives and talks to PrismaUI + SkyrimNet's C++ API.

**Lifecycle**
- On `kDataLoaded`: `InitWebUI()` acquires PrismaUI API, `CreateView("SkyrimNet_SexLab/index.html")`, registers JS listeners (`onCancel`, `onAction`, `onFrameworkChange`).
- On `kPostLoadGame` / `kNewGame`: `WebUI_SetGameReady()` (UI show is blocked until a game is loaded).
- Papyrus → C++: `SkyrimNet_SexLab_WebUI.Target_Menu_Open` / `Sex_Menu_Open` → `WebUI_Invoke` / Show / Focus.
- C++ → JS: `PrismaUI->Invoke` with panel ids `target_menu_panel` / `sex_menu_panel` (HTML adapters map these to `#target-panel` / `#sex-menu-panel`).
- Target catalog: `ActionCatalog` loads `webui/target_options.json` + `webui/actions_index.json`; Start merges parameter dictionary onto YAML `parameterMapping` and dispatches via SkyrimNet.

**Build (required)**: use VS Code/Cursor CMake tasks in `.vscode/tasks.json` with `cwd` = `SKSE_Source` — do not invent one-off MSBuild commands unless asked.

| Task | What it does |
|------|----------------|
| `CMake: Configure (Debug)` | `git submodule update --init --recursive` + `cmake --preset debug` |
| `CMake: Build SKSE (Debug)` | `cmake --build --preset build-debug` and copy DLL → `SKSE/Plugins/SkyrimNet_SexLab.dll` |
| `CMake: Configure (Release)` / `CMake: Build SKSE (Release)` | Same for release presets |
| `Copy DLL to SKSE/Plugins (Debug\|Release)` | Explicit copy if needed |

Requires Visual Studio 2022 generator, `VCPKG_ROOT`, and triplet `x64-windows-static`. CMake also includes `../../SkyrimNet/CppAPI` for SkyrimNet public API headers.

Output DLL must land in `SKSE/Plugins/SkyrimNet_SexLab.dll`; overlay HTML must exist at `PrismaUI/views/SkyrimNet_SexLab/index.html`.

## PrismaUI

[Prisma UI](https://www.nexusmods.com/skyrimspecialedition/mods/148718) is a **hard dependency** for the WebUI overlay (Chromium-based in-game HTML). This mod does not ship PrismaUI.dll — players install it separately.

**View path (critical)**
- `CreateView("SkyrimNet_SexLab/index.html")` resolves under **`Data/PrismaUI/views/`**, **not** `SKSE/Plugins/`.
- Ship / keep: `PrismaUI/views/SkyrimNet_SexLab/index.html`.
- Missing that file → C++ open path still looks fine (hotkey / `Target_Menu_Open`) but **no visible UI**; logs may say the view is invalid.

**API**
- Request `PRISMA_UI_API::IVPrismaUI1` via `RequestPluginAPI` from `PrismaUI.dll` (header: `SKSE_Source/lib/PrismaUI/PrismaUI_API.h`).
- Common ops: `CreateView`, `Invoke`, `RegisterJSListener`, `Show` / `Hide`, `Focus` / `Unfocus`, `IsValid`.

**WebUI data (not HTML)**
- Layout / options: `SKSE/Plugins/SkyrimNet_SexLab/webui/target_options.json`
- Action index (from SkyrimNet action YAMLs): regenerate with `tools/generate_actions_index.py` after editing action `label`s — see `KNOWLEDGEBASE.md` → "WebUI target menu catalog".
