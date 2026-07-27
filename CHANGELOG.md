# Changelog

## [0.31.2](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.2) — since [0.30.5](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.30.5)

### Actions / scenes
- Split sex actions by actor count: `sexlab_sex1` (masturbation), `sexlab_sex2` (two-actor), `sexlab_sex3` (threesome)
- Speaker-mode split for consensual sex: **fucking** (penis methods) vs **giving** (oral/hand/etc.); giving uses scene `no_penis` (`tags_suppress`: vaginal, anal)
- Outfit actions: LLM `how` is `dresses|undresses`; eligibility uses `OStimActorCountFaction` (not Excitement)
- Removed obsolete `sexlab_none_rape` action
- Actor lock eligibility key standardized to `skyrimnet_sexlab_scene_actor_lock`
- Kissing method auto-loads `nonsexual_kissing` scene setting

### Orgasm / narration
- Centralized orgasm totals + `" is orgasming."` gate via `GetIsOrgasming`
- Dom Combined fallback: if orgasm expected and totals already bumped but custom text raced empty, still append `" is orgasming."`
- Individual orgasm narration notes other actors as not orgasming
- Tentacles flavor only on actors that actually orgasm (no AnimationEnd force-all)

### Scene / Creator reliability
- Select animations **before** `NewThread` so cancel/UI never claims a SexLab Making slot; `model.Initialize()` on post-NewThread abort
- `Scene.Setup` returns Bool; failed setup releases the scene instead of leaving a half-init slot
- `AnimationEnd` no longer creates a scene if one is already gone (avoids duplicate afterglow after stop)
- Stronger duplicate-actor checks in `StartScene`
- Generic threads refuse cleanly when already active; Release always unsets `thread_scene`

### JSON / prompts
- External JSON keys always bare lowercase via `ObjectToLowerCaseKeyJson` / `JsonLowerCaseKeys` (protocol **values** stay `_pain_`, `_pleasure_`, …)
- Activity prompt: removed UUID dumps; `notice_level` only updated on matched speaker
- Outfit helper uses `[style] [how]`

### Logging / SKSE WebUI
- Papyrus traces route through `SkyrimNet_SexLab_WebUI.TraceLog` → `SKSE/SkyrimNet_SexLab.log`
- In-game PrismaUI target / sex menu (SKSE DLL + `docs/developers/webui.md`); custom pulldowns; `actions_index.json` catalog
- Native menu open signatures use `Form` where required for unique NPCs / SKSE

### Editor / DOM
- Stage description / orgasm-expected editors: ESC exits cleanly; parse failure no longer wipes animation JSON
- DOM nonconsensual wrappers drop `style` to stay within ExecuteQuestFunction’s 8-arg limit
- Multi-target menu blank intent defaults to `"sexual activities"`

### Docs
- Author/developer docs under `docs/` (players, authors, developers, reference); `llms.txt` agent router; root `guides/` removed
- `CHANGELOG.md` is the authoritative changelog (`update.md` removed)
