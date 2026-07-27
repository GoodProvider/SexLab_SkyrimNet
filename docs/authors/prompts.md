# Prompts

Edit SkyrimNet prompt files shipped with this mod.

Contracts: [../reference/json-keys.md](../reference/json-keys.md), [../reference/protocol-tokens.md](../reference/protocol-tokens.md), [../reference/orgasm-narration.md](../reference/orgasm-narration.md).

## Paths

```
SKSE/Plugins/SkyrimNet/prompts/
  helpers/
  submodules/
    character_bio/
    system_head/
    user_final_instructions/
```

| File | Role |
|------|------|
| `character_bio/0005_sexlab_variables.prompt` | Arousal / sex-active bio |
| `character_bio/0415_sexlab_appearance.prompt` | Appearance while SexLab-active |
| `system_head/0020_sexlab_setting.prompt` | System-head settings |
| `user_final_instructions/0050_sexlab_activity.prompt` | Scene + speaking rules |
| `user_final_instructions/0550_sexlab_narration.prompt` | Direct narration / orgasm gate |
| `helpers/sexlab_*.prompt` | Per-action helpers |

Outfit guidance: `helpers/sexlab_none_change_outfit.prompt` (`[style] [how]`). No `0520_sexlab_dressing_instructions.prompt`.

## Keys vs values

| Kind | Form |
|------|------|
| JSON keys (Skyrim → prompts) | bare lowercase |
| Protocol values | `_wrapped_` |

Keep literals character-for-character or matching breaks.

## Activity flow (`0050`)

1. `sexlab_get_threads(npc.UUID)` or `threads.json` fallback.
2. Match speaker by `uuid`; read `speaking_modifiers`, `victim`, etc.
3. Emit context + Speaking Rules when modifiers present.

`contains(speaker.speaking_modifiers, "_pain_")` is case-sensitive.

## Orgasm gate (`0550`)

See [../reference/orgasm-narration.md](../reference/orgasm-narration.md). Gate:

```inja
contains(_direct_narration, " is orgasming.")
```

## Coupling

| Source | Consumer |
|--------|----------|
| Scene `speaking_modifiers` | `0050_sexlab_activity.prompt` |
| `threads` / `actors` JSON | activity + narration |
| DirectNarration + `" is orgasming."` | `0550_sexlab_narration.prompt` |

## Checklist

- [ ] Keys bare lowercase; values `_wrapped_` where protocol
- [ ] Orgasm gate still `" is orgasming."` (or Papyrus updated with it)
- [ ] Denied orgasm text never includes that substring
- [ ] Narration-enabled smoke test for changed paths
