# SkyrimNet_SexLab Animation Data Schema 3.0

**Schema version:** 3.0  
**Status:** Normative consumer contract for SkyrimNet_SexLab  
**Audience:** Implementers and anyone hand-authoring animation metadata

This document is the normative definition of the SkyrimNet_SexLab animation data format
(anidata). Machine-readable companions live under
[schemas/](schemas/snsl-anidata-3.0-accept.schema.json). Author-facing install and editor
notes: [../authors/animations.md](../authors/animations.md).

## 1. What This Format Is

One JSON file describes one SexLab animation: a per-stage description of the visible pose,
speech constraints, clothing flags, SNSL stage tags, whether each actor is expected to
reach orgasm, and optional descriptions of moving between adjacent stages.

Files are produced by SexLab Description Creator, the in-game editor, or hand-authoring.
**Every key is optional.** Consumers fill gaps from documented defaults rather than rejecting
the file.

## 2. File Location and Lookup

```text
SKSE/Plugins/SkyrimNet_SexLab/animations/<provider>/<registrar>.json
```

The lookup key is `<registrar>`, matched case-insensitively. `<provider>` is grouping only.

| Registration path | Registrar source |
|-------------------|------------------|
| SexLab Animation Loader (SLAL) | `id` in `SLAnims/json/*.json` |
| SexLab framework JSON animations | JSON filename minus `.json` |
| Papyrus-registered animations | string passed to `RegisterAnimation` |

**Consumer lookup order:** prefer `<registrar>.json`; if missing, fall back to
`<display name>.json` and log a warning. Two files that resolve to the same registrar are a
conflict to report, not silently merge. Pack folder `_local_` is loaded last and wins when
both resolve.

Display names are not unique; only the registrar is a safe key. Port display-name packs with
[`tools/port_anidata_v3.py`](../../tools/port_anidata_v3.py).

## 3. Worked Example (Leito DoggyStyle)

Full 3.0 document exercising every key, including per-stage `tags` and speaking overrides.
Shipped as [`SKSE/Plugins/SkyrimNet_SexLab/animations/GoodProvider/LeitoDoggyStyle.json`](../../SKSE/Plugins/SkyrimNet_SexLab/animations/GoodProvider/LeitoDoggyStyle.json)
(provisional registrar `LeitoDoggyStyle` — no unique SLAnims `id` matched the old display name
`Leito DoggyStyle`).

```json
{
  "version": "3.0",
  "creator": "GoodProvider",
  "orgasm_expected": [1, 1],
  "speaking_modifiers": [["_pleasure_"], ["_pleasure_"]],
  "clothed": [0, 0],
  "tags": ["doggy", "vaginal"],
  "stage 1": {
    "description": "{{sl.actors.1}} stands behind {{sl.actors.0}} fingering their pussy getting them ready.",
    "tags": ["fingering", "doggy"],
    "speaking_modifiers": [["_pleasure_"], []]
  },
  "stage 2": {
    "description": "{{sl.actors.1}} fucks {{sl.actors.0}} from behind.",
    "tags": ["doggy", "vaginal"]
  },
  "stage 3": {
    "description": "{{sl.actors.1}} forces {{sl.actors.0}} to their knees and fucks them from behind.",
    "tags": ["doggy", "vaginal", "aggressive"],
    "speaking_modifiers": [["_pleasure_", "_pain_"], ["_pleasure_"]]
  },
  "stage 4": {
    "description": "{{sl.actors.0}} on hands and knees, with ass in the air and head on the ground. {{sl.actors.1}} squats over {{sl.actors.0}} and fucks from behind, while holding {{sl.actors.0}} in place.",
    "tags": ["doggy", "vaginal"],
    "speaking_modifiers": [["_pleasure_", "_gagged_"], ["_pleasure_"]]
  },
  "transitions": {
    "1-2": "{{sl.actors.1}} stops fingering and pushes into {{sl.actors.0}} from behind.",
    "2-1": "{{sl.actors.1}} pulls out and returns to fingering {{sl.actors.0}}.",
    "2-3": "{{sl.actors.1}} forces {{sl.actors.0}} down onto their knees while staying behind them.",
    "3-2": "{{sl.actors.0}} rises from their knees as {{sl.actors.1}} eases the pace from behind.",
    "3-4": "{{sl.actors.0}} drops their head to the ground with hips raised as {{sl.actors.1}} grips them in place.",
    "4-3": "{{sl.actors.0}} lifts their head and torso as {{sl.actors.1}} eases the hold from behind."
  }
}
```

Stage 2 omits speaking/clothed and inherits animation-level values. Stage 1 actor 1 uses `[]`
(speaks normally). When the thread advances stages, a matching `transitions` entry **replaces**
the constructed narration `"Scene changes to " + description`; if absent, that fallback remains.

## 4. Top-Level Keys

| Key | Type | Scope | Default when absent |
|-----|------|-------|---------------------|
| `version` | string | file | treat as 3.0; log a trace-level error |
| `creator` | string | file | unknown; not machine-generated |
| `orgasm_expected` | array of `0`/`1` | per actor | SexLab per-position orgasm data |
| `speaking_modifiers` | array of arrays of tokens | per actor | see §7 |
| `clothed` | array of `0`/`1` | per actor | `0` (unclothed) for every actor |
| `tags` | array of strings | animation / stage | empty; see §8 |
| `stage N` | object or string | per stage | carry forward previous stage |
| `transitions` | object | per stage pair | no transition text |

Unrecognized lowercase top-level keys: preserve and ignore.

Actor-indexed arrays use SexLab position order (same as `{{sl.actors.N}}`). Length mismatch vs
actor count: log and fall back to defaults for missing entries; do not reject the file.
`orgasm_expected` length mismatch: ignore the whole array.

### `version` / `creator`

Generated files use `"version": "3.0"`. Absent `version` is still readable (trace log).
Per-stage `version` from 2.0 files is ignored. `creator` is provenance only (e.g.
`"GoodProvider"`); value casing is preserved.

Do **not** copy SexLab package identity (provider, display name, actor count, stage count,
SexLab registry tags) into this file for identity purposes. SNSL `tags` below are a separate
per-stage overlay for speaking defaults and prompt context; they do not replace SexLab
`AnimRow.tags` used for AnimDB query/filter.

## 5. Optionality and Resolution

Resolve in order, stop at first hit:

1. value on the requested stage;
2. resolved value of the nearest preceding stage;
3. animation-level value at the top of the file;
4. built-in default from §4.

Animation-level values seed the chain like stage 0.

### Empty is not absent

- `speaking_modifiers`: actor empty list `[]` means “speaks normally”; do not carry-forward or
  default over it.
- `tags`: empty list `[]` means “no SNSL stage tags”; treat as a real value.
- `description`: empty string **is** absent; fall back to nearest earlier non-empty description.

## 6. Stage Objects

Keys: `stage N` (one-based, no leading zeros). On read, accept `stage 1`, `Stage 1`, `stage1`;
emit canonical `stage N`.

```json
"stage 2": {
  "description": "...",
  "speaking_modifiers": [["_pleasure_"], ["_pleasure_"]],
  "clothed": [0, 0],
  "tags": ["vaginal"]
}
```

Bare string stage value ≡ object with only `description`. Descriptions use
`{{sl.actors.N}}` and must not assert clothing (use `clothed`).

## 7. `speaking_modifiers`

Per-actor arrays of tokens; animation and/or stage level; resolve per §5.

| Token | Effect |
|-------|--------|
| `_pleasure_` | pleasure vocalizations; cap ~8 words |
| `_pain_` | pain vocalizations; cap ~8 words |
| `_gagged_` | mouth blocked; 1–3 vocalizations |
| `_kissing_` | mouth occupied; ≤5 words |

Authority for effect:
`SKSE/Plugins/SkyrimNet/prompts/submodules/user_final_instructions/0050_sexlab_activity.prompt`.
`_gagged_` wins over pleasure/pain vocalization rules. `_kissing_` is only reached when neither
`_pleasure_` nor `_pain_` is present — do not emit `["_pleasure_", "_kissing_"]`.

**Defaults** when nothing resolves:

1. tag-derived rules (resolved SNSL stage `tags` preferred over SexLab tags), including gentle
   activity → empty list;
2. empty list when that actor’s `orgasm_expected` is `0`;
3. `["_pleasure_"]` as last resort.

Legacy accept: per-actor comma-separated string instead of a token array.

## 8. `tags`

Optional array of lowercase SexLab-style strings (`oral`, `vaginal`, `cuddling`, …) at
animation and/or stage level. Resolve per §5. Used for speaking defaults and active-stage
prompt context. Empty `[]` is a real value.

These do **not** replace SexLab registry tags on the AnimDB row used for query/filter.

## 9. `clothed`

Per-actor `0` unclothed / `1` clothed; animation and/or stage; resolve per §5. Absent for all
stages ⇒ every actor unclothed. Authoritative over any clothing impression in descriptions.

## 10. `orgasm_expected`

Per-actor `0`/`1` once per animation (no per-stage form). Absent ⇒ derive from SexLab. Present
with wrong length ⇒ ignore entire array.

## 11. `transitions`

Object keyed `"<from>-<to>"` (adjacent stages only; both directions independent). Values are
actor-template strings. Optional; omit for single-stage anims.

**Consumer:** on stage change in `SkyrimNet_SexLab_Scene.StageStart`, if a transition for
`prev→cur` exists after actor substitution, use it as the change narration instead of
`"Scene changes to " + description`. If missing, keep that constructed fallback. Orgasm append
and DirectNarration / RegisterEvent paths are unchanged.

## 12. Actor Substitution

Only `{{sl.actors.N}}` (no spaces inside braces). Literal replace with display names. Never
hard-code actor names.

## 13. Key Casing

**Keys are lowercase. Values are not.** Consumers match keys case-insensitively. Two keys that
differ only in case in one object are a fatal conflict.

## 14. Machine-Readable Schemas

| Document | Use |
|----------|-----|
| [snsl-anidata-3.0-accept.schema.json](schemas/snsl-anidata-3.0-accept.schema.json) | input (hand-authored, 2.0, partial) |
| [snsl-anidata-3.0-emit.schema.json](schemas/snsl-anidata-3.0-emit.schema.json) | complete generated output |

Actor-count and consecutive-stage checks belong to the application.

## 15. Differences From 2.0

2.0 was mostly `stage N` + `description` (+ unused per-stage `version`) and optional
`orgasm_expected`. A 2.0 file is a valid 3.0 file (defaults fill the rest).

Consumer work: registrar lookup, file `speaking_modifiers` / `clothed` / `tags` / `transitions`,
resolution chain, `creator` / missing-`version` tracing. Port tool:
[`tools/port_anidata_v3.py`](../../tools/port_anidata_v3.py).
