---
name: release
description: >-
  Align SkyrimNet_SexLab release docs and version metadata for next_version.
  Use when preparing a release, writing CHANGELOG.md or CHANGELOG-user.md,
  bumping Makefile VERSION, updating release-checkpoint.xml, documenting the
  delta since base_tag, or when the user asks to ship, tag-prep, or run a
  release-doc pass. Does not create git tags, GitHub Releases, or run make
  release unless asked.
---

# Release documentation

Shared facts (freshness matrix, version sources, doc inventory, packaging): [release-guide.md](../../../release-guide.md). Session state: [release-checkpoint.xml](../../../release-checkpoint.xml). On conflict, the markdown wins for facts; this file wins for agent procedure. Do not read `release-guide.xml` (removed).

## Cold start

Read, in order:

1. `release-guide.md`
2. `release-checkpoint.xml`
3. `llms.txt`

Then:

1. Take `base_tag` and `next_version` from the checkpoint (fallback: `git describe` / latest version tag).
2. Reconcile with Makefile `VERSION`, `SKSE/Plugins/SkyrimNet_SexLab/info.json`, `FOMOD/info.xml`, and the latest version tag. **If they disagree, stop and ask. Do not invent a version.**
3. Diff `base_tag...HEAD` plus uncommitted files that will ship.
4. For protocol contracts, open the single canonical file under `docs/reference/`. Changelogs get a one-line pointer, never a pasted contract.

Ignore the `llms.txt` denylist unless the maintainer says those paths ship (`SSEEdit Cache/`, `reviews/`, `Source/*.pex`, crash logs, `versions/`, `dist/`, `z-*`, `handler_*` unpack dirs, `SKSE_Source/build/`, vendored CommonLibSSE-NG).

## Hard stops

- Do not create the git tag or GitHub Release.
- Do not run `make release` or pack the `.7z`.
- Do not do feature work, refactors, or review fixes (`review-guide.xml` is a different job).
- Do not invent changelog bullets or README claims.
- Do not commit or push unless the maintainer explicitly asks.
- Do not promise VR-specific behavior unless verified. SE ≠ VR.
- Before any game/script/ESP fix that sneaks into this pass: state confidence ≥ 90% and assumptions.

## Workflow

Copy and track:

```
Release-doc progress:
- [ ] 1. Establish delta
- [ ] 2. Clarify before writing
- [ ] 3. Rewrite CHANGELOG.md
- [ ] 4. Rewrite CHANGELOG-user.md
- [ ] 5. Align docs (freshness matrix)
- [ ] 6. Makefile VERSION if missing
- [ ] 7. Update checkpoint
- [ ] 8. Hand-off
```

### 1. Establish delta

Collect user- and author-visible changes since `base_tag`: scripts, action YAMLs, prompts, scenes, animations, SKSE/WebUI, FOMOD, docs. Skip denylist noise.

Preflight (report only; do not compile or pack): whether `Scripts/*.pex`, SKSE DLL (if WebUI ships), and `Spriggit/` JSON look current.

### 2. Clarify before writing

Stop and ask if any of these are unclear:

- `next_version` / `base_tag` (including Makefile vs `info.json` vs FOMOD vs checkpoint vs tags)
- which working-tree changes ship
- CHANGELOG themes vs docs-only updates
- handler ESP special cases
- deliberate omissions

Do not draft `CHANGELOG*`, `README.md`, or `docs/` until answers avoid invention.

### 3. Rewrite CHANGELOG.md

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

Prefer concrete identifiers (YAML names, `setting_name`, StorageUtil keys, prompt files). Every bullet must be verifiable in git history or the shipping working tree.

### 4. Rewrite CHANGELOG-user.md

First line:

```text
https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/VERSION
```

Then 5–12 plain-English bullets. No claims missing from `CHANGELOG.md`.

### 5. Align docs

Apply the freshness matrix in `release-guide.md` — only touched rows. Prefer pointers over duplication. Keep `README.md` short. Preserve short technical voice under `docs/`.

### 6. Version prep

If `next_version` is missing from Makefile, update Makefile `VERSION` only. `make release` refreshes `info.json` and FOMOD — do not run it unless asked. ESP source of truth is `Spriggit/`, not hand-edited binaries.

### 7. Checkpoint

Update `release-checkpoint.xml`: `updated`, `base_tag`, `next_version`, `version_status`, status notes, `related_artifacts`, `doc_files`.

### 8. Hand-off

Report:

- files touched
- version mismatches left
- preflight notes
- suggested maintainer ship steps: commit → `compile: pyro` if needed → `make release` → git tag → GitHub Release

## Done-when

- Changelogs cover `next_version`
- Freshness-matrix files match the shipping delta
- Checkpoint is current
- Hand-off lists leftover mismatches

Packaging is not part of done.
