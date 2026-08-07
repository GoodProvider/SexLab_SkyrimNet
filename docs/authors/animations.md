# Animations

Per-stage SexLab animation descriptions for SkyrimNet_SexLab.

Orgasm narration when a stage climaxes: [../reference/orgasm-narration.md](../reference/orgasm-narration.md).

## Paths

| Path | Purpose |
|------|---------|
| `SKSE/Plugins/SkyrimNet_SexLab/animations/_local_/` | Local edits (loaded last, wins) |
| `SKSE/Plugins/SkyrimNet_SexLab/animations/(author)/` | Shared packs |
| `animations/GoodProvider/` | Example pack |

## In-game editor

You are strongly encouraged to add and share stage descriptions. Press the **Sex Description Editor** hot key on an actor in sex:

- If the animation's stage already has a description, you can view or replace it.
- If not, a text field lets you add one; names are filled in and you can accept or reject. Empty results usually mean wrong variable names.
- Set `orgasm_expected` and change sex style (if Tag Editor dialogs are on).

Edit files with any text editor after creation. Type actor indices alone if you need to see who is who.

ESC cancels cleanly. Save aborts if existing JSON fails to parse (avoids wiping with `{}`).

## Fallback

No stage description → tag-based. Current stage empty → last earlier stage with text.

## JSON format

Keys are **case-sensitive** (JContainers). Use lowercase `"stage N"` and `"version"`.

```json
{
    "stage 1": {
        "description": "{{sl.actors.1}} fingers {{sl.actors.0}}.",
        "version": "2.0"
    },
    "orgasm_expected": [1, 0],
    "speaking_modifiers": ["_pleasure_", ""],
    "clothed": [0, 1]
}
```

Inja `2.0`: actors are an array; if there is a victim, it is normally first; `{{sl.actors.0}}`, `{{sl.actors.1}}`, `{{sl.actors.2}}`, …

### orgasm_expected

Int array by thread position: `0` no orgasm expected, `1` expects orgasm.

### speaking_modifiers

Per-position protocol tokens (e.g. `_pleasure_`, `_pain_`). When JSON is missing, defaults from `orgasm_expected`: `1` → `_pleasure_`, `0` → empty.

### clothed

Per-position `0` unclothed / `1` clothed (dressed).

### Sex style (Tag Editor)

Forcefully fucking / having sex / gently making love.

Victim and orgasm **deny** are scene-only and are never stored in animation JSON.

## Sharing

Please send packs by zipping your `_local_` folder with an author name (anonymous OK): Discord, or email da.good.provider@gmail.com.

Install shared packs under `animations/(author_name)/`. Keep personal overrides in `_local_` (loaded last, wins). Examples: `animations/GoodProvider/`.
