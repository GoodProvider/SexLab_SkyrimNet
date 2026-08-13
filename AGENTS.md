# AGENTS.md

Agent guidance for SkyrimNet_SexLab (SkyrimNet ↔ SexLab bridge).

## What this is

Bridge mod between SkyrimNet (LLM) and SexLab Framework.

## Key paths

| Path | Role |
|------|------|
| `Scripts/Source/` | Papyrus source |
| `Scripts/` | Compiled `.pex` |
| `Headers/` | Papyrus headers |
| `skyrimse.ppj` | Pyro project |

Repo root: `c:\Skyrim\dev\mods\SkyrimNet_SexLab`.

### Logs (this machine)

Documents is OneDrive-redirected — not `%USERPROFILE%\Documents\...`.

| Log | Path |
|-----|------|
| Crash Logger | `C:\Users\bhuff\OneDrive\Documents\my games\Skyrim Special Edition\SKSE\crash-*.log` |
| SkyrimNet_SexLab | `C:\Users\bhuff\OneDrive\Documents\my games\Skyrim Special Edition\SKSE\SkyrimNet_SexLab.log` |
| Papyrus | `C:\Users\bhuff\OneDrive\Documents\my games\Skyrim Special Edition\Logs\Script\Papyrus.0.log` |

Relative paths for other machines: [docs/reference/papyrus-rules.md](docs/reference/papyrus-rules.md).

## Documentation map

| Job | Read |
|-----|------|
| Agent router | [llms.txt](llms.txt) |
| Players | [docs/players/overview.md](docs/players/overview.md) |
| Action YAML | [docs/authors/actions.md](docs/authors/actions.md) |
| Prompts | [docs/authors/prompts.md](docs/authors/prompts.md) |
| Animations (authors) | [docs/authors/animations.md](docs/authors/animations.md) |
| Anidata schema 3.0 | [docs/developers/anidata-schema.md](docs/developers/anidata-schema.md) |
| Papyrus / ESP | [docs/developers/papyrus.md](docs/developers/papyrus.md) |
| WebUI / SKSE | [docs/developers/webui.md](docs/developers/webui.md) |
| Release docs | [release-guide.xml](release-guide.xml) + [release-checkpoint.xml](release-checkpoint.xml) |
| Portable doc template (other repos) | [documentation-guide.xml](documentation-guide.xml) |

### Canonical contracts (do not restate elsewhere)

| Topic | File |
|-------|------|
| Papyrus language / naming / traces | [docs/reference/papyrus-rules.md](docs/reference/papyrus-rules.md) |
| Protocol value tokens (`_pain_`, …) | [docs/reference/protocol-tokens.md](docs/reference/protocol-tokens.md) |
| External JSON keys | [docs/reference/json-keys.md](docs/reference/json-keys.md) |
| Orgasm narration gate | [docs/reference/orgasm-narration.md](docs/reference/orgasm-narration.md) |
| Scene JSON keys | [docs/reference/scene-settings.md](docs/reference/scene-settings.md) |
| Animation data (anidata) 3.0 | [docs/developers/anidata-schema.md](docs/developers/anidata-schema.md) |

## Compile

- Papyrus: VS Code/Cursor task **`compile: pyro`** only (unless maintainer asks otherwise).
- SKSE / WebUI: [docs/developers/webui.md](docs/developers/webui.md).

Tools under `tools/`: Pyro, Champollion, XEditLib, Spriggit.

## Commit messages

First ~72 characters summarize the commit. Prefer multi-line body with concrete bullets (paths, keys, YAML names).

## Standing rules

- **Nexus first:** search the mod’s Nexus page before investigating blind.
- **Knowledgebase:** consult [KNOWLEDGEBASE.md](KNOWLEDGEBASE.md) before changes; append new quirks after sessions.
- **INI load order:** Skyrim.ini then SkyrimPrefs.ini (last wins).
- **SE ≠ VR** — never assume parity.

### Top gotchas (see KNOWLEDGEBASE for detail)

RemoveSpell vs DispelSpell; spell effect casting types; fragile VMAD; PlayIdle fails in VR; Wait() under 100ms unreliable; ESL FormID range; loose files override BSA; Condition OR > AND; non-auto properties blank on load; PreWEAPON/PreSHIELD CTD in VR; ONAM for ESM temps; SetVehicle HMD desync; GoToState("") in OnUnload; navmesh CK-only.

## Safety rules

Hooks in `.claude/settings.json` may enforce these.

### Hard blocked

- Deleting game/config install dirs or Bethesda registry keys
- Direct writes to ESP/ESM/ESL/BSA/BA2 (use xelib / Spriggit)

### Requires confirmation

- Edits in game/config directories; `.psc`/`.pex`; Skyrim INIs; SKSE plugin INIs; load-order files; destructive shell on those trees

### General

- Review diffs before applying; user knows modding/INI; propose hook/KB gaps when risk patterns appear
- Audit trail may live under `.claude/backups/`

## Confidence (mandatory before game/script/ESP changes)

1. State confidence 0–100% and assumptions
2. Investigate: KNOWLEDGEBASE, sources, web for SE/VR quirks
3. Target ≥ 90%; if lower, document gaps
4. Never assume SE = VR

| Range | Action |
|-------|--------|
| 95–100% | Proceed with confirmation |
| 80–94% | Proceed with caveats |
| 60–79% | Research more |
| < 60% | Do not proceed |

Checklist: KB → sources → web → rollback → hook-gap check.
