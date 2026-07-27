# Scene settings JSON

Files under `SKSE/Plugins/SkyrimNet_SexLab/scenes/(setting_name).json`, loaded when an action passes `setting_name`.

## Keys

| key | meaning |
|-----|---------|
| `array_defaults` | Defaults for per-position arrays (`no_orgasm`, `no_stripping`, `speaking_modifiers`) |
| `no_orgasm` | Per-position: `0` allowed, `1` denied |
| `no_stripping` | Per-position: `0` undress, `1` keep clothes |
| `speaking_modifiers` | Per-position underscore tokens — see [protocol-tokens.md](protocol-tokens.md) |
| `tags` | Animation must include these SexLab tags |
| `tags_suppress` | Animation must not include these tags |
| `method` | Optional description when tags are not enough |

## Built-in scenes

`default`, `pleasure_pain`, `no_penis`, `nonsexual`, `nonsexual_kissing`, `nonsexual_male_position_0`–`2`, `punish_spanking`, `punish_spanking_victim_nude`, `punish_whipping_oral`, `punish_pleasure_pain_rape`.

Use `punish_*` (not obsolete `punishing_*`).

## Examples

**Giving / no penis** — [`scenes/no_penis.json`](../../SKSE/Plugins/SkyrimNet_SexLab/scenes/no_penis.json):

```json
{
    "tags_suppress": "vaginal,anal"
}
```

**Punish / pain** — [`scenes/punish_spanking.json`](../../SKSE/Plugins/SkyrimNet_SexLab/scenes/punish_spanking.json):

```json
{
    "array_defaults": {
        "no_orgasm": 1,
        "no_stripping": 1
    },
    "speaking_modifiers": ["_pain_", ""],
    "tags_suppress": "oral,vaginal,anal,masturbation,handjob,boobjob,thighjob,fisting,dildo,fingering,footjob,cuddling,spooning"
}
```

Wire from actions via static `setting_name` — see [../authors/actions.md](../authors/actions.md).

Synthetic stub (when no short shipped file fits): [../examples/minimal-scene-setting.json](../examples/minimal-scene-setting.json).
