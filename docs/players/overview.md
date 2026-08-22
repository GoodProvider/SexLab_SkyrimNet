# Player overview

SkyrimNet_SexLab bridges SkyrimNet (LLM) and SexLab Framework.

Hotkeys: [hotkeys.md](hotkeys.md). Authoring: [../authors/actions.md](../authors/actions.md). Changelog: [../../CHANGELOG.md](../../CHANGELOG.md).

## FAQ

### NPCs avoid casual sex

- People normally don't want to have sex where others can see them.
  - Use whisper mode to reduce the number of people watching.
  - SkyrimNet allows people to see/hear through walls/floors.
- Match social-world settings to the tone you want.
- **Public sex accepted** (SkyrimNet plugin menu → SkyrimNet_SexLab) changes prompt treatment of public sex.

### Too much sex

- Tune [arousal prompts](https://github.com/GoodProvider/SkyrimNet_SexLab/blob/main/SKSE/Plugins/SkyrimNet/prompts/submodules/character_bio/0005_sexlab_variables.prompt#L12).
- Check social-world settings.

### Memory errors when actions fire

SkyrimNet is not seeing Actions functions.

1. Put `SkyrimNet_SexLab.esp` last.
2. SkyrimNet webUI → Tools → Game Data Explorer → search `_sexlab` → Quests → View Scripts → **Refresh** → Actions (function count > 0).

### Narration spammy or silent

- **Narration cooldown** — min seconds since last audio before optional Direct Narration (SkyrimNet_SexLab plugin settings).
- **Narration max distance** — player distance for optional narration (same settings UI).

## Shipped LLM actions

| Category | What |
|----------|------|
| sex1 / sex2 / sex3 | Masturbation, two-actor, threesome; forceful/normal/gentle; **fucking** vs **giving** (`no_penis`); rape if **Add rape actions** is on |
| nonsexual / comfort | Kiss, hug, cuddle, spoon, headpat; 3-actor nonsexual |
| punish | Spanking, nude spanking, whipping; punish-rape |
| none | Stop; dress/undress actions (silent RegisterEvent OK) |

Scene files via `setting_name`: [../reference/scene-settings.md](../reference/scene-settings.md).

## Settings

Plugin options live in:

1. **SkyrimNet mod menu** → **SkyrimNet_SexLab** plugin (manifest / control store), or
2. In-game WebUI **Settings** main panel (main panel pulldown → Settings) for rebuild / version / docs

AnimDB does not rebuild on load. If it is empty or its animation count does not match SexLab, a notification and a dialog appear (Build/Rebuild or Close). SkyUI MCM keeps rebuild + last-rebuild timestamp, Start Sex / Edit Stage hotkey enable/remap, and points players at those UIs. New settings are always added to the manifest first.

| Category | Options |
|----------|---------|
| **Prompt Options** | Hide hermaphrodite from prompt; Public sex accepted |
| **Rape Options** | Add rape actions (toggle, save, reload; Game Data Explorer Refresh if needed) |
| **Tag Edit** | Show dialogs for player actions; Show dialogs for non-player actions |
| **Sex Description Editor** | Enable Start Sex / Edit Stage hotkey; hotkey binding; Hide Edit Stage Description Help |
| **Direct Narration Blocking** | Narration cooldown (seconds); Narration max distance (meters) |
| **Framework** | Player sex framework — SexLab or Ostim (when OStimNet is installed) |
| **Orgasm** | Orgasm delay (seconds) |

## Requirements

Full list: [requirements.md](requirements.md).
