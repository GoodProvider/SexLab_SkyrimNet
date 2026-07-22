# Prompts guide

How to edit SkyrimNet prompt files shipped with SkyrimNet_SexLab.

See also: [README.md](README.md), [Actions.md](Actions.md) (scene `speaking_modifiers` and action helpers), [Code.md](Code.md).

## Where files live

```
SKSE/Plugins/SkyrimNet/prompts/
  helpers/                          # optional per-action helpers
  submodules/
    character_bio/                  # bio / arousal / appearance
    system_head/                    # system settings snippets
    user_final_instructions/        # activity + narration instructions
```

| File | Role |
|------|------|
| `submodules/character_bio/0005_sexlab_variables.prompt` | Sex-active / arousal variables for character bio |
| `submodules/character_bio/0415_sexlab_appearance.prompt` | Appearance while SexLab-active |
| `submodules/system_head/0020_sexlab_setting.prompt` | System-head SexLab settings |
| `submodules/user_final_instructions/0050_sexlab_activity.prompt` | Active scene description + speaking rules |
| `submodules/user_final_instructions/0550_sexlab_narration.prompt` | Direct-narration / orgasm instructions |
| `helpers/sexlab_*.prompt` | Helpers tied to specific actions (outfit, stop, rape start, orgy, …) |

You are expected to tune these for your world. Keep protocol literals exact (below) or prompts will stop matching game data.

## Why underscores matter

Skyrim pools string identity **case-insensitively**. The first casing that loads wins; later casings collapse into that pool. The game’s casing is unstable across load orders.

Anything matched **outside** Skyrim (Inja `contains`, JSON tooling, case-sensitive prompt compares) must use a stable unique literal:

- **JSON keys** emitted by Papyrus for external consumers: start with `_`  
  Examples: `_threads`, `_actors`, `_speaking_modifiers`, `_victim`, `_notice_level`, `_uuid`, `_description`, `_location`, `_speaker_los`, `_speaker_distance`, `_active`, `_arousal`, …
- **Protocol tokens** in strings: wrap with underscores  
  Examples: `_pain_`, `_pleasure_`, `_gagged_`, `_kissing_`

Plain English words (`pain`, `Actors`) are unsafe as protocol tokens.

## Activity prompt (`0050_sexlab_activity.prompt`)

Typical flow:

1. Load live threads via decorator `sexlab_get_threads(npc.UUID)`, or fall back to `SkyrimNet_SexLab/threads.json` when paused / empty.
2. Read `sexlab._threads` and each thread’s `_actors`.
3. Match the speaking NPC by `_uuid`; use `_speaking_modifiers`, `_victim`, `_notice_level`, creature/strapon flags, etc.
4. Emit scene context and **Speaking Rules** when modifiers are present.

`contains(speaker._speaking_modifiers, "_pain_")` is case-sensitive. Scene JSON and Papyrus must emit the same underscore tokens (see [Actions.md](Actions.md) scene settings).

When adding a new speaking modifier:

1. Emit it from scene settings / code as `_yourtoken_`.
2. Add matching `contains(..., "_yourtoken_")` branches in the activity (and narration) prompts.
3. Document the token in README / Actions.md so authors use it in scene JSON.

## Orgasm narration contract (`0550_sexlab_narration.prompt`)

The prompt gates orgasm instructions with:

```inja
contains(_direct_narration, " is orgasming.")
```

**Contract (must stay exact):**

- Every **orgasming** actor clause in Combined / custom DirectNarration must include the substring `" is orgasming."`
- **Denied** / non-orgasming clauses must **not** include that substring (use “did not orgasm” / denied wording only)
- Dom path: `Handler_DOM.DOMSlave_Orgasmed` → `Scene_Manager.OrgasmCustom` appends `". "+name+" is orgasming."` on purpose — do not strip it without updating this prompt
- Non-Dom Combined uses `name+" is orgasming. "` for the same gate
- Dom Combined fallback may append `name+" is orgasming. "` when orgasm was expected but custom text raced empty

If you change the gate string in the prompt, you must change every Papyrus narration site that appends it.

## Safe edit practices

- Prefer small, targeted edits; keep underscore keys and tokens character-for-character.
- Test with **narration enabled** in SkyrimNet.
- After changing activity / narration prompts, run scenes that hit pleasure, pain, kissing, gagged, orgasm, and denied orgasm.
- Helper prompts under `helpers/` are optional context for specific actions — keep their names aligned with the actions that reference them.
- Do not invent bare JSON keys (`speaking_modifiers`, `Actors`) for the Skyrim→prompt pipeline; use `_speaking_modifiers`-style names.

## Coupling with actions and scenes

| Source | Consumed by |
|--------|-------------|
| Scene `speaking_modifiers` | `0050_sexlab_activity.prompt` |
| Decorator / `threads.json` `_threads` / `_actors` | activity + narration prompts |
| DirectNarration text with `" is orgasming."` | `0550_sexlab_narration.prompt` |
| Action helper prompts | SkyrimNet action workflow |

Changing scene tokens without updating prompts (or the reverse) silently breaks instructions.

## Checklist

- [ ] New / edited keys use leading `_`
- [ ] New speaking tokens are `_wrapped_` and matched with `contains` in prompts
- [ ] Orgasm gate still uses exact `" is orgasming."` (or Papyrus updated in lockstep)
- [ ] Denied orgasm text never includes that substring
- [ ] Narration-enabled in-game smoke test for the paths you changed
