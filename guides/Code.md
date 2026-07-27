# Code guide

Developer guide for working on SkyrimNet_SexLab (Papyrus, ESP, review workflow).

See also: [README.md](../README.md) (players), [Actions.md](Actions.md) (YAML authors), [Prompts.md](Prompts.md) (prompt authors), [KNOWLEDGEBASE.md](../KNOWLEDGEBASE.md) (quirks and past fixes), [AGENTS.md](../AGENTS.md) (repo-wide agent rules).

## Key paths

| Path | Role |
|------|------|
| `Scripts/Source/` | Papyrus source (authoritative) |
| `Scripts/` | Compiled `.pex` output |
| `Headers/` | Papyrus import headers |
| `skyrimse.ppj` | Pyro project file |
| `Spriggit/` | ESP ↔ JSON serialization |
| `SKSE/Plugins/SkyrimNet/config/actions/` | Action YAMLs |
| `SKSE/Plugins/SkyrimNet/prompts/` | Prompt files |
| `SKSE/Plugins/SkyrimNet_SexLab/` | Scenes, animations, group tags, threads output |
| `SKSE_Source/` | C++ PrismaUI WebUI plugin → `SkyrimNet_SexLab.dll` (see [WebUI.md](WebUI.md)) |

Repository root: `c:\Skyrim\dev\mods\SkyrimNet_SexLab`.

## Compile

Use the VS Code / Cursor task **`compile: pyro`** (`.vscode/tasks.json`). It runs Pyro against `skyrimse.ppj` with the project game path.

Do **not** invent one-off Caprica / `papyrus.exe` compile commands unless the maintainer asks.

## Naming and Papyrus rules

- **Constants:** `THIS_IS_A_CONSTANT`
- **Properties / variables:** start lowercase; mix of snake_case and camelCase (`thisIs_Variable`)
- **Functions / Events:** start Upper case; match `EndFunction` / `EndEvent` casing
- **Arrays vs None:** never `if a == None` for arrays; use `if a` (checks non-None and non-empty)
- **Debug traces:** start with `"---"` — e.g. `Trace("FunctionName", "--- this is a debug message")`
- Papyrus log: `Documents\my games\Skyrim Special Edition\Logs\Script\Papyrus.0.log`

JSON **keys** for external consumers: bare lowercase via `ObjectToLowerCaseKeyJson`. Protocol **value** tokens (speaking modifiers): underscore-wrapped (`_pain_`). See [Prompts.md](Prompts.md).

## Architecture (high level)

```
Actions / Menu / DOM
        │
        ▼
Scene_Creator (pooled) ──StartScene──► Scene_Manager.CreateSceneByCreator
        │                                      │
        │                                      ▼
        └── Release() after Setup ◄── Scene.Setup(creator) copies state out
                                               │
                                               ▼
                                    SexLab thread events → Scene handlers
                                               │
                                               ▼
                         Decorators / GetObj / threads.json → SkyrimNet prompts
```

- **Creator pool:** `CreateCreator()` marks a slot ACTIVE; returns `None` when exhausted. Every caller **must** `Release()` after cancel or after `Scene.Setup` copied values out.
- **Manager:** hooks SexLab thread events; routes to Scene; orgasm / stage / narration paths live here and on Scene.
- **Menu:** hotkey UI lives in `SkyrimNet_SexLab_Menu.psc` (split out of MCM).
- **Init:** Main, Actions, Menu, Manager, Creator, and DOM handlers call `Setup_CheckLinks()` before continuing setup.
- **Actor lock:** StorageUtil key `skyrimnet_sexlab_scene_actor_lock` (`Main.storage_actor_lock_key`); YAML eligibility must match.
- **Decorators** (`SkyrimNet_SexLab_Decorators.psc`): expose scene state as bare-lowercase JSON keys for prompts (via `ObjectToLowerCaseKeyJson`).
- **Logging:** Papyrus `Trace` → `SkyrimNet_SexLab_WebUI.TraceLog` → `Documents\...\SKSE\SkyrimNet_SexLab.log` (prefix messages with `"---"`).
- **Creator start order:** `SelectAnimations()` before `sexlab.NewThread()`; on post-`NewThread` abort call `model.Initialize()` then `Release()`.
- **Scene.Setup** returns `Bool`; `CreateSceneByCreator` Releases and returns `None` on failure.
- **Optional DOM:** `main.handler_dom` is either the Interface stub (no-op / passthrough) or real `SkyrimNet_SexLab_Handler_DOM` when `SkyrimNet_DOM.esp` is loaded. Dom orgasm uses `DOMSlave_Orgasmed` → `OrgasmCustom` (appends `" is orgasming."`). DOM nonconsensual wrappers omit `style` (8-arg ExecuteQuestFunction limit).
- **Optional UDNG:** bondage-related hotkey / handler when present.
- **WebUI / SKSE:** see [WebUI.md](WebUI.md).

Locked decisions and “do not re-report” facts live in `review-checkpoint.xml`.

## Review artifacts

| File | Purpose |
|------|---------|
| `review-guide.xml` | Review persona / output rules |
| `review-checkpoint.xml` | Durable architecture, constraints, backlog, pass history |
| `review-execution-plan.xml` | Current fix-pass findings (problem / fix / file / line) |
| `reviews/*.review.md` | Per-pass changelog |
| `KNOWLEDGEBASE.md` | Cross-cutting quirks (action YAML practice, orgasm contract, …) |

**Resume a review:** read `review-guide.xml` + `review-checkpoint.xml` → regenerate execution plan High→Medium→Low with 1-based line numbers (include comments) → apply → `compile: pyro` → write `reviews/YYYY-MM-DD-NN.review.md` → update checkpoint `<pass>` / `<updated>` / `<current_status>`.

Respect `<constraints>` and `<locked_decisions>`; do not re-report items listed there.

## ESP / Spriggit

Do not hand-edit `.esp` binaries. Use Spriggit serialize / deserialize (or project bat files) and keep `Spriggit/` in sync with intentional ESP changes.

## Safety and confidence

This install is delicate. Before changing game files, scripts, or ESP records:

1. State confidence (target ≥ 90%) and assumptions
2. Check `KNOWLEDGEBASE.md` and relevant sources
3. Prefer rollback-friendly edits
4. Do not assume SE behavior equals VR

Hooks / backups under `.claude/` may apply when using Claude Code tooling; still review diffs before applying.

## Content authors vs code

- YAML actions / scenes → [Actions.md](Actions.md)
- Prompt files → [Prompts.md](Prompts.md)
- Animation stage JSON (`"stage N"`, `orgasm_expected`) → [Animations.md](Animations.md)

Keep code changes that emit prompt protocol strings (`" is orgasming."`, speaking_modifiers values like `_pleasure_`, …) in sync with [Prompts.md](Prompts.md).
