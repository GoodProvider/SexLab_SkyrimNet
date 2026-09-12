# Animations

Per-stage SexLab animation descriptions for SkyrimNet_SexLab.

Orgasm narration when a stage climaxes: [../reference/orgasm-narration.md](../reference/orgasm-narration.md).

## Paths

| Path | Purpose |
|------|---------|
| `SKSE/Plugins/SkyrimNet_SexLab/animations/_local_/` | Local edits (loaded last, wins) |
| `SKSE/Plugins/SkyrimNet_SexLab/animations/(author)/` | Shared packs |
| `animations/GoodProvider/` | Example pack |

## SexLab P+ playing set

Empty tags: skip `GetAnimationsByTags` so SexLab picks. Tagged matches: `PickOneAnimation` keeps one random anim (P+ `GetPlayingScenes` hops otherwise). `Scene.StageStart` ends the thread after 120s real-time. Papyrus: [../developers/papyrus.md](../developers/papyrus.md).

## In-game editor

MCM **Sex Description Editor** hot key while in a SexLab animation: add/replace stage description, set `orgasm_expected`, change sex style (if Tag Editor dialogs on).

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
    "orgasm_expected": [1, 0]
}
```

Inja `2.0`: actors array; victim usually first; `{{sl.actors.0}}`, `{{sl.actors.1}}`, …

### orgasm_expected

Int array by thread position: `0` no orgasm expected, `1` expects orgasm.

### Sex style (Tag Editor)

Forcefully fucking / having sex / gently making love.

## Sharing

Zip `_local_` or an author folder; install under `animations/(author_name)/`. Keep personal overrides in `_local_`.
