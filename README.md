# SkyrimNet_SexLab

Adds SkyrimNet support to SexLab.

See also: [CHANGELOG.md](CHANGELOG.md), [Actions.md](Actions.md), [Prompts.md](Prompts.md), [Code.md](Code.md).

## F.A.Q.

#### My NPCs don't want to have casual sex!
- **People normally don't want to have sex where others can see them**:
  - Use whisper mode to reduce the number of people watching
  - SkyrimNet allows people to see/hear through walls/floors
- **Check your social world settings to match the kind of sex you want**
- MCM **Public sex accepted** changes how public sex is treated in prompts

#### My NPCs keep having too much sex!
- **Change [arousal prompts](https://github.com/GoodProvider/SkyrimNet_SexLab/blob/main/SKSE/Plugins/SkyrimNet/prompts/submodules/character_bio/0005_sexlab_variables.prompt#L12) to make your actors less horny**
- **Check your social world settings to match the kind of sex you want**

#### I am getting Memory errors when actions triggers!
SkyrimNet isn't seeing SkyrimNet_SexLab's Actions' functions.

- Make sure the SkyrimNet_SexLab.esp is the last plugin.
- When the game starts, use your hot key to open SkyrimNet's webUI
  - Select "tools" on the left column
  - Select 'Game Data Explorer'
  - In the search field type `_sexlab`
  - Select SkyrimNet_SexLab's Quests
  - Select 'View Scripts'
  - Click the 'Refresh' Button
  - Select 'Actions'
    - If it has more than 0 functions you are good to go.

#### Narration feels spammy or silent
- MCM **Narration cooldown** — minimum seconds since last audio before optional Direct Narration
- MCM **Narration max distance** — how far the player can be for optional narration

---

# Actions

NPC / LLM actions (see [Actions.md](Actions.md) to add your own):

- **sex** — start sex (forceful / normal / gentle), masturbation, 2- and 3-actor scenes; rape actions when MCM **Add rape actions** is on (toggle, save, reload)
- **nonsexual / comfort** — kissing, hugging, cuddling, spooning, headpat-style affection; 3-actor nonsexual
- **punish** — spanking, nude spanking, whipping; punish-rape (nonconsensual APIs with an explicit victim)
- **none** — stop the scene; dress / undress (including silent narration)

## Action Scene Settings

When an action is called it may include `setting_name`, which loads `SKSE/Plugins/SkyrimNet_SexLab/scenes/(setting_name).json`. That controls orgasm, stripping, speaking modifiers, and animation tags.

Built-in scenes include: `default`, `pleasure_pain`, `nonsexual`, `nonsexual_kissing`, `nonsexual_male_position_0`–`2`, `punish_spanking`, `punish_spanking_victim_nude`, `punish_whipping_oral`, `punish_pleasure_pain_rape`.

Example (punish-style scene — no orgasm, no strip, pain on position 0, suppress sex tags):

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

| key | value |
| ----| ------|
| array_defaults | sets the default value for the arrays |
| no_orgasm | 0 = may orgasm, 1 = will not orgasm |
| no_stripping | 0 = undress, 1 = keep clothes |
| method | string description when tags are not enough |
| speaking_modifiers | `_pain_` — intense pain; `_pleasure_` — intense pleasure; `_gagged_` — gagged; `_kissing_` — mouth busy kissing |
| tags | animation must contain these tags |
| tags_suppress | animation must not contain these tags |

You are encouraged to create and share your own scene settings. Example actions: [SKSE/Plugins/SkyrimNet/config/actions](SKSE/Plugins/SkyrimNet/config/actions). Full authoring rules: [Actions.md](Actions.md).

### Speaking modifiers

Speaking modifiers drive instructions in [0050_sexlab_activity.prompt](SKSE/Plugins/SkyrimNet/prompts/submodules/user_final_instructions/0050_sexlab_activity.prompt). Tokens must be underscore-wrapped (`_pleasure_`, `_pain_`, `_gagged_`, `_kissing_`) so they stay unique under Skyrim's case-insensitive string pool and match case-sensitive prompts. See [Prompts.md](Prompts.md).

---

# Hot Key

Optional hot key (enable in the MCM). Supports:

- Start a sexual act with the NPC in the crosshairs, or between NPCs not in the crosshairs
- Dress / undress the actor under the crosshairs (including **silently**)
- **Punish** submenu: spanking, spanking nude, whip, rape
- **Affection** submenu (SexLab framework): hug, kiss, cuddle, spoon, headpat
- **Player rapes** / **rapes player**
- If OstimNet is installed: swap SexLab vs OStim framework from the menu
- If the NPC is a Domination slave (`SkyrimNet_DOM.esp`): starts route through DOM handler APIs
- While in a SexLab animation:
  - change sex style
  - add / edit a per-stage description
  - change whether a given actor expects an orgasm

## MCM options

- **Prompt Options:** Hide hermaphrodites from prompt; Public sex accepted; Enable virgin blood message
- **Rape Options:** Add rape actions (must toggle / save / reload)
- **Tag Edit:** Show dialogs for player actions / non-player actions
- **Sex Description Editor:** Enable hot key; key binding; Hide Edit Stage Description Help
- **Direct Narration Blocking:** Narration cooldown; Narration max distance
- **OstimNet Integration** (when present): which framework starts sex for the player

## Per Stage Description

You are strongly encouraged to add and share stage descriptions. When you press the hot key on an actor in sex:

- If the animation's stage already has a description, you can view or replace it
- If not, a text field lets you add one; names are filled in and you can accept or reject. Empty results usually mean wrong variable names

Descriptions are stored under `SKSE/Plugins/SkyrimNet_SexLab/animations/_local_/` (one file per animation). Shared packs live in `animations/(author_name)/`. Author name is shown when a description is used. `_local_` is loaded last and wins.

- Edit files with any text editor after creation
- If no stage description exists, tag-based description is used
- The last stage with a description is used if the current stage has none
- Directories are read in order; `_local_` last

**Keys are case-sensitive** (JContainers). Use lowercase `"stage N"` and `"version"` — that is what the in-game editor writes. Prefer:

```json
{
    "stage 1": {
        "description":"{{sl.actors.1}} fingers {{sl.actors.0}}.",
        "version": "2.0"
    },
    "orgasm_expected":[1,0]
}
```

Inja format (`version` `2.0`):

- Actors are an array; if there is a victim, it is normally first
- Type actor indices alone if you need to see who is who
- `{{sl.actors.0}}`, `{{sl.actors.1}}`, `{{sl.actors.2}}`, …

Examples: `animations/GoodProvider/`.

Please send packs by zipping your `_local_` folder with an author name (anonymous OK): Discord, or email da.good.provider@gmail.com.

## Orgasm Expected

Some animations should not imply every actor orgasms. Stored as an int array matching actor positions in the thread:

- `0` — does not expect an orgasm
- `1` — expects an orgasm

## Sex Style

If Tag Editor dialogs are enabled, you can set style for how sex is presented to the LLM:

- Forcefully fucking
- having sex
- gently making love

---

# Extending / contributing

| Guide | Summary |
|-------|---------|
| **[Actions.md](Actions.md)** | Create or edit LLM actions under `SKSE/Plugins/SkyrimNet/config/actions/`. Wire `setting_name` to scene JSONs, eligibility rules, and consensual / nonconsensual Papyrus entry points. |
| **[Prompts.md](Prompts.md)** | Edit SexLab prompt submodules. Bare lowercase JSON keys, `_wrapped_` speaking-modifier value tokens, and the `" is orgasming."` narration contract. |
| **[Code.md](Code.md)** | Develop Papyrus / SKSE: paths, `compile: pyro`, architecture (Creator → Scene → Manager), review-checkpoint workflow. |

---

**Requirements**

The following and dependencies:

- [SexLab Framework](https://www.loverslab.com/files/category/228-sexlab-framework-se/)
- [Papyrus MessageBox](https://www.nexusmods.com/skyrimspecialedition/mods/83578)
- [JContainers v4.2.13.1+](https://www.nexusmods.com/skyrimspecialedition/mods/16495)
- [SkyUI SE](https://www.nexusmods.com/skyrimspecialedition/mods/12604)
- [UIExtensions](https://www.nexusmods.com/skyrimspecialedition/mods/17561)
  - [UIExtensions_UITextEntryMenu_with_VR_support](https://github.com/mrowrpurr/UIExtensions_UITextEntryMenu_with_VR_support) (VR users)
- [Prisma UI](https://www.nexusmods.com/skyrimspecialedition/mods/148718)
  - [Media Keys Fix](https://www.nexusmods.com/skyrimspecialedition/mods/92948)
- [Dragonborn voice over 2](https://www.nexusmods.com/skyrimspecialedition/mods/84329)
- SkyrimNet (Beta7 or later)
  - You must have narration enabled
- SkyrimNet_SexLab (this mod)
- **Animation Utilities**
  - [Pandora](https://www.nexusmods.com/skyrimspecialedition/mods/133232)
  - Pandora Output (recommended to store Pandora's output)
  - [XP32 Maximum Skeleton Special Extended (XPMSSE)](https://www.nexusmods.com/skyrimspecialedition/mods/1988)
  - [SL Animation Loader](https://www.loverslab.com/files/file/5328-sexlab-animation-loader-sse/)
  - [Hug kill move fix for USSEP](https://www.nexusmods.com/skyrimspecialedition/mods/139572?tab=description)
- **Animation**
  - [Ace Animations](https://www.nexusmods.com/skyrimspecialedition/mods/81928) (cuddle/spooning animations)

**Optional**

- [SkyrimNet_DOM](https://github.com/GoodProvider) — requires `SkyrimNet_DOM.esp`; Domination slave orgasm / denied narration and DOM-routed hotkey starts
- [SkyrimNet_Arousal](https://github.com/GoodProvider/SkyrimNet_Arousal) — arousal in prompts / arousal actions
- [OSL Aroused](https://www.nexusmods.com/skyrimspecialedition/mods/65454)
  - Can prevent orgasm from increasing satisfaction for tagged actors for a given animation
- [OstimNet](https://github.com/tetherball88/OStimNet)
  - If installed, MCM selects which framework the LLM uses to start sex

**Other SkyrimNet NSFW**

- [skyrimNet CumSwallowNeeds](mods/SkyrimNet-CumSwallowNeeds.zip) (Author Token)
  - [CumSwallowNeeds](https://www.loverslab.com/files/file/29763-cumswallowneedsaddon/)

**Recommendations**

- **Utils**
  - [SKSE](https://skse.silverlock.org/)
  - [Address Library for SKSE Plugins](https://www.nexusmods.com/skyrimspecialedition/mods/32444)
  - [Unofficial Skyrim Special Edition Patch - USSEP](https://www.nexusmods.com/skyrimspecialedition/mods/266)
  - [PapyrusUtil SE](https://www.nexusmods.com/skyrimspecialedition/mods/13048)
  - [Powerof three Papyrus Extender](https://www.nexusmods.com/skyrimspecialedition/mods/22854)
  - [Power of three Tweaks](https://www.nexusmods.com/skyrimspecialedition/mods/51073)
  - [Alternate Start](https://www.nexusmods.com/skyrimspecialedition/mods/272) (nice, but not needed)
  - [Stay At the System Page NG](https://www.nexusmods.com/skyrimspecialedition/mods/76927)
  - Papyrus MessageBox
  - SkyrimNet
- **nude body (not required)**
  - [Caliente's Beautiful Bodies Enhancer -CBBE-](https://www.nexusmods.com/skyrimspecialedition/mods/198) or BHUNP
  - [The New Gentlemen](https://www.loverslab.com/files/file/5355-schlongs-of-skyrim-se/)
    - [The New Gentlewomen](https://www.nexusmods.com/skyrimspecialedition/mods/105649) futanari support
      - https://www.loverslab.com/files/file/11344-sos-addon-futanari-cbbe-sse/
      - TRX Futanari for New Gentlemen (TRX-Corner on [Vermi Discord](https://discord.gg/vermishub))
      - Add via T.N.G's hotkey after exiting racemenu
      - Change the character's gender to male in SexLab only
- **SexLab**
  - [SexLab Framework](https://www.loverslab.com/files/category/228-sexlab-framework-se/)
  - [SexLab Tools](https://www.loverslab.com/files/file/10660-sexlab-tools-for-se-patched/) (change animations with 'h' hotkey)
- **animations** (you might get away with less …)
  - [Billyy](https://www.loverslab.com/files/file/3999-billyys-slal-animations-2025-1-1/)
- **Devious Devices**
  - [SkyrimNet DDUNDNG](https://github.com/naitro2010/SkyrimNet_UDNG/releases/download/alpha2/SkyrimNetDDUDNG.zip)
  - [Devious Devices](https://www.loverslab.com/files/file/5878-devious-devices-se/) (and its requirements)
  - [Papyrus Tweaks NG](https://www.nexusmods.com/skyrimspecialedition/mods/77779)
  - [Devious Devices NG](https://www.loverslab.com/files/file/29779-devious-devices-ng/)
    - [Blind people DAR](https://www.nexusmods.com/skyrimspecialedition/mods/90947)
    - [Bound hands DAR](https://www.nexusmods.com/skyrimspecialedition/mods/89247) (required for next file)
    - [Bound hands OAR](https://www.nexusmods.com/skyrimspecialedition/mods/143622?tab=files)
