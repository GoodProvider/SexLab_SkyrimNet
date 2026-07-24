# Changelog

https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.0

requires: 
    - https://github.com/ryobg/JContainers/releases/tag/v4.2.13.1 (newer then nexus) 

### Players

- Hotkey: punish rape, affection methods (including headpat), silent dress/undress; Domination slaves route through DOM when `SkyrimNet_DOM.esp` is present
- MCM: Hide Edit Stage Description Help; narration cooldown and max distance documented in README
- Optional SkyrimNet_DOM for slave orgasm / denied narration and DOM-routed scene starts
- Requires JContainers ≥ 4.2.13.1; Hug kill move fix for USSEP recommended
- Animation pack updates under `animations/GoodProvider/` (facesit, missionary, and related)

### Authors (actions / scenes / prompts)

- Speaking modifiers are underscore-wrapped (`_pain_`, `_pleasure_`, `_gagged_`, `_kissing_`) so prompts match case-sensitively
- Punish scene settings renamed: `punishing_*` → `punish_*`
- Added `punish_pleasure_pain_rape` scene and punish-rape actions; `setting_name` must be `punish_pleasure_pain_rape`
- Punish spanking / nude spanking / whipping: fixed-role YAMLs (`*_Target` / `*_by_target`) using `StartScene_Nonconsensual_Two_TargetVictim` or `_SpeakerVictim`
- Actor lock StorageUtil key is `skyrimnet_sexlab_scene_actor_lock` (action eligibility must use the same string)
- Removed `0520_sexlab_dressing_instructions.prompt`; `0005_sexlab_variables` detects sex-active via SexLab/OStim factions; activity and narration prompts refreshed for underscore JSON and the `" is orgasming."` contract
- New docs: [Actions.md](Actions.md), [Prompts.md](Prompts.md), [Code.md](Code.md); [README.md](README.md) is the full end-user guide

### Technical

- Hotkey menu logic split into `SkyrimNet_SexLab_Menu.psc` (MCM thinner)
- `Setup_CheckLinks` on Main, Actions, Menu, Manager, Creator, and DOM handlers
- UUID matching and richer actor JSON (`_uuid`, OStim faction awareness) for prompts / threads
- DOM orgasm / denied narration pipeline improvements
