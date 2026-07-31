# Player overview

SkyrimNet_SexLab bridges SkyrimNet (LLM) and SexLab Framework.

Hotkeys: [hotkeys.md](hotkeys.md). Authoring: [../authors/actions.md](../authors/actions.md). Changelog: [../../CHANGELOG.md](../../CHANGELOG.md).

## FAQ

### NPCs avoid casual sex

- Public visibility matters; try whisper mode. SkyrimNet can see/hear through walls.
- Match social-world settings to the tone you want.
- MCM **Public sex accepted** changes prompt treatment of public sex.

### Too much sex

- Tune [arousal prompts](https://github.com/GoodProvider/SkyrimNet_SexLab/blob/main/SKSE/Plugins/SkyrimNet/prompts/submodules/character_bio/0005_sexlab_variables.prompt#L12).
- Check social-world settings.

### Memory errors when actions fire

SkyrimNet is not seeing Actions functions.

1. Put `SkyrimNet_SexLab.esp` last.
2. SkyrimNet webUI → Tools → Game Data Explorer → search `_sexlab` → Quests → View Scripts → **Refresh** → Actions (function count > 0).

### Narration spammy or silent

- MCM **Narration cooldown** — min seconds since last audio before optional Direct Narration.
- MCM **Narration max distance** — player distance for optional narration.

## Shipped LLM actions

| Category | What |
|----------|------|
| sex1 / sex2 / sex3 | Masturbation, two-actor, threesome; forceful/normal/gentle; **fucking** vs **giving** (`no_penis`); rape if MCM **Add rape actions** on |
| nonsexual / comfort | Kiss, hug, cuddle, spoon, headpat; 3-actor nonsexual |
| punish | Spanking, nude spanking, whipping; punish-rape |
| none | Stop; dress/undress actions (silent RegisterEvent OK) |

Scene files via `setting_name`: [../reference/scene-settings.md](../reference/scene-settings.md).

## MCM (summary)

- Prompt: hide hermaphrodites; public sex accepted; virgin blood message
- Rape: add rape actions (toggle / save / reload)
- Tag Edit dialogs; Sex Description Editor hot key
- Direct Narration Blocking: cooldown, max distance
- OstimNet (if present): which framework starts sex for the player

## Requirements

Full list: [requirements.md](requirements.md).
