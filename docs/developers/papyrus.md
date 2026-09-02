# Papyrus / code

Developer guide: paths, compile, architecture, review, ESP.

Contracts: [../reference/papyrus-rules.md](../reference/papyrus-rules.md), [../reference/json-keys.md](../reference/json-keys.md), [../reference/orgasm-narration.md](../reference/orgasm-narration.md). WebUI: [webui.md](webui.md). Quirks: [../../KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md).

## Paths

| Path | Role |
|------|------|
| `Scripts/Source/` | Papyrus source |
| `Scripts/` | Compiled `.pex` |
| `Headers/` | Import headers |
| `skyrimse.ppj` | Pyro project |
| `Spriggit/` | ESP ↔ JSON |
| `SKSE/Plugins/SkyrimNet/config/actions/` | Action YAML |
| `SKSE/Plugins/SkyrimNet/prompts/` | Prompts |
| `SKSE/Plugins/SkyrimNet_SexLab/` | Scenes, animations, threads |
| `SKSE_Source/` | C++ WebUI plugin |

## Compile

VS Code / Cursor task **`compile: pyro`** (`.vscode/tasks.json`). Do not invent Caprica / `papyrus.exe` one-offs unless asked.

SKSE: [webui.md](webui.md).

## Architecture

```
Actions / Menu / DOM
        │
        ▼
Scene_Creator (pooled) ──StartScene──► Scene_Manager.CreateSceneByCreator
        │                                      │
        └── Release() after Setup ◄── Scene.Setup(creator)
                                               │
                                    SexLab events → Scene
                                               │
                         Decorators / threads.json → prompts
```

- Creator: `CreateCreator()` → ACTIVE; always `Release()` after cancel or after Setup copies state.
- `SelectAnimations()` before `sexlab.NewThread()`; abort → `model.Initialize()` then `Release()`.
- `Scene.Setup` returns `Bool`; failure → Release, no half-init slot.
- `Scene.initiator` is the speaker by default. If `num_victims > 0`, `PickNonVictimInitiator()` keeps initiator only when they are not a victim; otherwise first non-victim from positions 1…n then 0 (or None). First-stage `"X initiates: …"` only; do not recompute on AlignActors / live SetVictim.
- External / DOM threads: `EnsureSceneForThread` from `AnimationStart` / `StageStart`. `GetSceneInactive` calls `SetThread` before `thread_scene[tid]`. `GetSceneByThread` treats that slot as authoritative during Setup (status still INACTIVE); Release only on tid mismatch.
- Actor lock: `skyrimnet_sexlab_scene_actor_lock`.
- Trace → `WebUI.TraceLog` → `SKSE\SkyrimNet_SexLab.log` (prefix `"---"`).
- DOM optional: `handler_dom`; Dom orgasm → `OrgasmCustom` + `" is orgasming."`. Nonconsensual wrappers omit `style` (8-arg limit).
- Quirks (initiator vs victim, DOM bind race): [KNOWLEDGEBASE.md](../../KNOWLEDGEBASE.md).

## Review

| File | Role |
|------|------|
| `review-guide.xml` | Persona / rules |
| `review-checkpoint.xml` | Locked decisions, backlog |
| `review-execution-plan.xml` | Current fix pass |
| `reviews/*.review.md` | Per-pass notes |

Resume: guide + checkpoint → plan High→Medium→Low (1-based lines, include comments) → apply → `compile: pyro` → write review → update checkpoint.

## ESP / Spriggit

Do not hand-edit `.esp`. `Spriggit/` is source of truth for the main plugin.

| Command | Direction |
|---------|-----------|
| `make update` / `serialize.bat` | `.esp` → `Spriggit/` |
| `make esp` | `Spriggit/` → `.esp` |
| `make release` | version + esp + pack `.7z` |

Handler ESPs are not Spriggit-backed yet.

## Content authors

Actions / prompts / animations → [../authors/](../authors/). Keep protocol strings in sync with [../reference/](../reference/).
