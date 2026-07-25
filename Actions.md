# Actions guide

How to create and edit SkyrimNet LLM actions for SkyrimNet_SexLab.

See also: [README.md](README.md) (end-user features), [Prompts.md](Prompts.md) (prompt contracts), [Code.md](Code.md) (Papyrus developers).

Upstream schema: [WORKFLOW_ACTIONS.md](https://github.com/MinLL/SkyrimNet-GamePlugin/blob/main/docs/modding/WORKFLOW_ACTIONS.md).

## Where files live

| Path | Purpose |
|------|---------|
| `SKSE/Plugins/SkyrimNet/config/actions/` | Action YAML files |
| `SKSE/Plugins/SkyrimNet_SexLab/scenes/` | Scene setting JSON files referenced by `setting_name` |
| `SKSE/Plugins/SkyrimNet/prompts/helpers/` | Optional per-action helper prompts |

Shipped categories (filename prefix / `customCategory`):

- `sexlab_sex1` / `sexlab_sex2` / `sexlab_sex3` — masturbation (1), sex (2), threesome (3)
- `sexlab_nonsexual` / `sexlab_comfort` — affection and nonsexual scenes
- `sexlab_punish` — spanking, whipping, punish-rape
- `sexlab_none` — stop, outfit change, utility

Category parent files end with `_` only (e.g. `sexlab_sex2_.yaml`). They define the category; they do not call Papyrus.

## Category parents vs executable actions

**Category parent** fields only:

- `name`, `description`, `customCategory`, `enabled`
- `eligibilityRules` (optional)

Do **not** put `description_`, `questEditorId`, `scriptName`, or `parameterMapping` on category parents. Keep any PARAMS JSON in `description` valid.

**Executable action** fields:

- `customCategory` — must match a category parent
- `name` — **must be unique** across all action YAMLs
- `description` — LLM-facing text (may include PARAMS hints)
- `questEditorId: SkyrimNet_SexLab`
- `scriptName: SkyrimNet_SexLab_Actions`
- `executionFunctionName` — Papyrus function on that script
- `parameterMapping` — positional args matching the Papyrus signature
- `defaultPriority` (optional)
- `eligibilityRules` (optional)

## parameterMapping rules

Mappings are **positional**: order and types must match the Papyrus function signature in `Scripts/Source/SkyrimNet_SexLab_Actions.psc`. The mapping `name` is LLM-facing only; it does not rename the Papyrus parameter.

| type | Required field | Notes |
|------|----------------|-------|
| `static` | `value` | Fixed string/value passed every call |
| `dynamic` | `description` | LLM fills this; **do not** use `value` |
| `speaker` | (speaker actor) | Triggering entity |

Prefer Papyrus slot names in mappings:

- `method` (not `type`) for how the act is done
- `how` for outfit change
- `victim` when the Papyrus signature takes an explicit victim

### Common entry points

| Function | Use when |
|----------|----------|
| `StartScene_Consensual_One` / `_Two` / `_Three` | Willing participants |
| `StartScene_Nonconsensual_Two` | Victim role chosen by LLM (`victim` mapping) |
| `StartScene_Nonconsensual_Two_TargetVictim` | Target is always the victim |
| `StartScene_Nonconsensual_Two_SpeakerVictim` | Speaker is always the victim |
| `StartScene_Refused_Two` | Refusal / aborted approach |
| `Change_Outfit` | Dress / undress (`stripper`, `stripped`, `how`, `narration`) |

**Never** pass obsolete `speaking_victim` in action YAMLs. Fixed-role assault uses TargetVictim / SpeakerVictim helpers; dynamic victim uses `StartScene_Nonconsensual_Two` with an explicit `victim` mapping.

## setting_name → scene JSON

Optional static mapping:

```yaml
  - type: static
    name: setting_name
    value: punish_spanking
```

Loads `SKSE/Plugins/SkyrimNet_SexLab/scenes/(setting_name).json`.

Built-in scenes include: `default`, `pleasure_pain`, `nonsexual`, `nonsexual_kissing`, `nonsexual_male_position_*`, `punish_spanking`, `punish_spanking_victim_nude`, `punish_whipping_oral`, `punish_pleasure_pain_rape`.

Old names `punishing_*` are gone — use `punish_*`.

### Scene JSON keys

| key | meaning |
|-----|---------|
| `array_defaults` | Default values for per-position arrays (`no_orgasm`, `no_stripping`, `speaking_modifiers`) |
| `no_orgasm` | Per-position: `0` orgasm allowed, `1` denied |
| `no_stripping` | Per-position: `0` undress, `1` keep clothes |
| `speaking_modifiers` | Per-position underscore tokens (see below) |
| `tags` | Animation must include these SexLab tags |
| `tags_suppress` | Animation must not include these tags |
| `method` | Optional human description when tags are insufficient |

Example (`punish_spanking.json`):

```json
{
    "array_defaults":{
        "no_orgasm":1,
        "no_stripping":1
    },
    "speaking_modifiers":["_pain_",""],
    "tags_suppress":"oral,vaginal,anal,masturbation,handjob,boobjob,thighjob,fisting,dildo,fingering,footjob,cuddling,spooning"
}
```

Speaking modifiers must be underscore-wrapped so prompts can match them: `_pain_`, `_pleasure_`, `_gagged_`, `_kissing_`. See [Prompts.md](Prompts.md).

## Eligibility

When you include `eligibilityRules` groups:

- Set `logicalOperator` (`AND` / `OR`)
- Set `required: true` — SkyrimNet ignores `required: false`

Category parents often gate on OStim framework choice, SexLabAnimatingFaction, combat, actor lock, etc. Copy patterns from existing `sexlab_*_.yaml` files.

Actor lock eligibility must use StorageUtil key `skyrimnet_sexlab_scene_actor_lock` (same as `Main.storage_actor_lock_key` / Creator). Do not use the old `skyrimnet_sexlab_actor_lock` string.

## Rape-gated actions

MCM **Add rape actions (must toggle/save/reload)** controls whether rape actions are registered. After changing those YAMLs or the MCM toggle, save, reload, and refresh Actions in Game Data Explorer (see README FAQ).

## After you change actions

1. Ensure `SkyrimNet_SexLab.esp` is last in the load order.
2. Start the game → SkyrimNet webUI → Tools → Game Data Explorer → search `_sexlab` → Quests → View Scripts → **Refresh** → Actions (function count &gt; 0).

## Examples to copy

| File | Pattern |
|------|---------|
| `sexlab_sex2_sex_fucking.yaml` | Consensual two-actor + style/method |
| `sexlab_comfort_cuddle.yaml` | Comfort / nonsexual |
| `sexlab_punish_spanking.yaml` | Fixed TargetVictim (`StartScene_Nonconsensual_Two_TargetVictim`) + `setting_name` |
| `sexlab_punish_spanking_by_target.yaml` | Fixed SpeakerVictim (`StartScene_Nonconsensual_Two_SpeakerVictim`) + same scene |
| `sexlab_punish_rape_target.yaml` | Fixed TargetVictim + `punish_pleasure_pain_rape` |
| `sexlab_none_change_outfit.yaml` | Outfit / silent narration |
| `sexlab_none_stop.yaml` | Stop scene |

## Checklist

- [ ] `name` unique across all action YAMLs
- [ ] `parameterMapping` order matches Papyrus signature
- [ ] `static` uses `value`; `dynamic` uses `description`
- [ ] No `speaking_victim`
- [ ] `setting_name` matches an existing file under `scenes/` (or you added the JSON)
- [ ] Speaking modifiers use `_token_` form
- [ ] Eligibility groups have `logicalOperator` + `required: true`
- [ ] Game Data Explorer Refresh after install
