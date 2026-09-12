# Release guide

Align docs and version metadata with what will ship as `next_version`. Packaging, git tags, and GitHub Releases are a separate maintainer step.

Agents: use the project `release` skill (`.cursor/skills/release/SKILL.md`). Session state: [release-checkpoint.xml](release-checkpoint.xml). Protocol contracts: [docs/reference/](docs/reference/) — do not restate them here.

## Who does what

| Actor | Owns | Does not do unless asked |
|-------|------|--------------------------|
| Agent | Changelogs, freshness-matrix docs, Makefile `VERSION` if missing, checkpoint | `compile: pyro`, `make release`, git tag, GitHub Release, feature work |
| Maintainer | Compile, package, tag, publish | Inventing changelog bullets the tree does not support |

**Agent done-when:** `CHANGELOG.md` and `CHANGELOG-user.md` cover `next_version`; freshness-matrix files match the delta; checkpoint is current; hand-off lists leftover version mismatches. Packaging is not part of done.

## Version sources

One release version. If these disagree, stop and ask — do not invent.

| Source | Field | Role |
|--------|-------|------|
| [Makefile](Makefile) | `VERSION` | Authoritative for `make release` package name |
| [SKSE/Plugins/SkyrimNet_SexLab/info.json](SKSE/Plugins/SkyrimNet_SexLab/info.json) | `version` | Written by `python_scripts/info.py` during `make release` |
| [FOMOD/info.xml](FOMOD/info.xml) | `Version` | From `FOMOD_source` via `fomod-update-name-version.py` |
| [FOMOD/ModuleConfig.xml](FOMOD/ModuleConfig.xml) | same | Same during `make release` |
| git tag matching `VERSION` | — | Created only when the maintainer ships |

Also reconcile checkpoint `base_tag` / `next_version` and the latest version tag.

Releases URL: `https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/{VERSION}`

## Freshness matrix

Update only the rows the delta touches. Contracts stay single-sourced under `docs/reference/`.

| When the delta includes | Update |
|-------------------------|--------|
| Action YAML or scene JSON | `docs/authors/actions.md`; `docs/reference/scene-settings.md`; `CHANGELOG.md`; `CHANGELOG-user.md` if player-visible; `README.md` index only if a new top-level feature category appears; `docs/examples/` stub only if no short in-tree file exists |
| Prompts, speaking modifiers, or orgasm DirectNarration text | exactly one of `docs/reference/protocol-tokens.md`, `orgasm-narration.md`, or `json-keys.md`; `docs/authors/prompts.md`; changelogs |
| Papyrus scene / manager / creator behavior | `docs/developers/papyrus.md`; changelogs; `docs/reference/*` only if a protocol contract changed |
| WebUI / SKSE / PrismaUI | `docs/developers/webui.md`; `docs/players/hotkeys.md` if user-visible; changelogs |
| Animation stage JSON or editor UX | `docs/authors/animations.md`; `docs/players/hotkeys.md` if needed; changelogs |
| Install / MCM / FAQ | `docs/players/overview.md` and/or `requirements.md`; keep `README.md` short |
| Doc layout or agent map | `llms.txt`; `AGENTS.md` pointers; `release-checkpoint.xml` `doc_files` |

## Doc inventory

| Role | Path |
|------|------|
| End-user front door | `README.md` |
| Agent router | `llms.txt` |
| Agent policy | `AGENTS.md` |
| Changelog (technical) | `CHANGELOG.md` |
| Changelog (player) | `CHANGELOG-user.md` |
| Players | `docs/players/overview.md`, `hotkeys.md`, `requirements.md` |
| Authors | `docs/authors/actions.md`, `prompts.md`, `animations.md` |
| Developers | `docs/developers/papyrus.md`, `webui.md` |
| Contracts | `docs/reference/papyrus-rules.md`, `protocol-tokens.md`, `json-keys.md`, `orgasm-narration.md`, `scene-settings.md` |
| Examples | `docs/examples/` |
| This guide | `release-guide.md` |
| Agent skill | `.cursor/skills/release/SKILL.md` |
| Session state | `release-checkpoint.xml` |

## Changelog rules

Ground truth is the git delta since `base_tag` plus working-tree files that will ship. No invented features. Every bullet must be verifiable. Changelogs get a one-line pointer to `docs/reference/…`, never a pasted protocol.

### `CHANGELOG.md`

Title:

```markdown
## [VERSION](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/VERSION) — since [BASE](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/BASE)
```

Use only these H3 themes, and only when the group has content:

- Actions / scenes
- Orgasm / narration
- Papyrus
- SKSE / WebUI
- Animations
- Install / MCM
- Docs

Prefer concrete identifiers (YAML names, `setting_name`, StorageUtil keys, prompt files).

### `CHANGELOG-user.md`

First line = GitHub releases URL for `next_version`. Then 5–12 plain-English bullets. No claims missing from `CHANGELOG.md`.

### Writing bar

- Short technical bullets; one H1 per markdown file; sequential H2/H3; pure Markdown (no HTML).
- Examples: minimal snippet + link to the full in-tree file; if none is short enough, add a stub under `docs/examples/`.
- Version-pin behavior that is release-specific (applies to vX.Y+).
- Do not promise VR-specific behavior unless verified; SE ≠ VR.
- Ask before drafting when version, ship set, handler ESP special cases, or omissions are unclear.

## Noise (do not changelog)

Ignore the [llms.txt](llms.txt) denylist unless the maintainer says those paths ship: `SSEEdit Cache/`, `reviews/`, `Source/*.pex`, crash logs, `versions/`, `dist/`, `z-*`, `handler_*` unpack dirs, `SKSE_Source/build/`, vendored CommonLibSSE-NG.

## Packaging (maintainer)

Prereqs: `Scripts/*.pex` current (`compile: pyro`); SKSE DLL if WebUI ships; `Spriggit/` JSON is ESP source of truth (not hand-edited binaries); animations merged if required.

`make release` writes `info.json` and FOMOD from `VERSION`/`NAME`, deserializes `SkyrimNet_SexLab.esp` from `Spriggit/`, stages core + handlers, packs `versions/SkyrimNet_SexLab ${VERSION}.7z`.

Ship order: commit → `compile: pyro` if needed → `make release` → git tag → GitHub Release.
