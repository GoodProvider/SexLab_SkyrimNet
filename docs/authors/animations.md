# Animations

Per-stage SexLab animation descriptions for SkyrimNet_SexLab.

**Format contract (schema 3.0):** [../developers/anidata-schema.md](../developers/anidata-schema.md).  
Orgasm narration when a stage climaxes: [../reference/orgasm-narration.md](../reference/orgasm-narration.md).

## Paths

| Path | Purpose |
|------|---------|
| `SKSE/Plugins/SkyrimNet_SexLab/animations/_local_/` | Local edits (loaded last, wins) |
| `SKSE/Plugins/SkyrimNet_SexLab/animations/(author)/` | Shared packs |
| `animations/GoodProvider/` | Example pack |

Files are keyed by SexLab **registrar** (`<registrar>.json`). Display-name filenames still load
with a warning; port packs with `tools/port_anidata_v3.py`.

## In-game editor

Press the **Sex Description Editor** hot key on an actor in sex:

- View or replace an existing stage description, or add one (actor placeholders filled in).
- Set `orgasm_expected` and sex style when Tag Editor dialogs are on.

ESC cancels. Save aborts if existing JSON fails to parse.

## Fallback

No stage description → tag-based. Current stage empty → last earlier stage with text.  
Stage change with a `transitions` entry → that text; otherwise `"Scene changes to " + description`.

## Sharing

Zip your `_local_` folder with an author name (anonymous OK): Discord, or email
da.good.provider@gmail.com. Install under `animations/(author_name)/`. Keep personal overrides
in `_local_`.
