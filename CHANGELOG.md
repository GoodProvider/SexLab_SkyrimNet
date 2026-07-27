# Changelog

## [0.31.3](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.3) — since [0.30.5](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.30.5)

### Actions / scenes
- Split sex actions by actor count: `sexlab_sex1` (masturbation), `sexlab_sex2` (two-actor), `sexlab_sex3` (threesome)
- Speaker-mode split for consensual sex: **fucking** (penis methods) vs **giving** (oral/hand/etc.); giving uses scene `no_penis` (`tags_suppress`: vaginal, anal)
- Outfit actions: LLM `how` is `dresses|undresses`; eligibility uses `OStimActorCountFaction` (not Excitement)
- Removed obsolete `sexlab_none_rape` action
- Actor lock eligibility key standardized to `skyrimnet_sexlab_scene_actor_lock`
- Kissing method auto-loads `nonsexual_kissing` scene setting
- Punish scenes renamed `punishing_*` → `punish_*`; added `punish_pleasure_pain_rape` and `*_by_target` punish variants

### Orgasm / narration
- Centralized orgasm totals + `" is orgasming."` gate via `GetIsOrgasming` — contract: [docs/reference/orgasm-narration.md](docs/reference/orgasm-narration.md)
- Combined fallback: if orgasm expected and totals already bumped but custom text raced empty, still append `" is orgasming."`
- Individual orgasm narration notes other actors as not orgasming
- Tentacles flavor only on actors that actually orgasm (no AnimationEnd force-all)
- `0550_sexlab_narration.prompt`: UUID-matched speaker, arousal bands, `_pain_` / `_pleasure_` tokens, orgasm gate on direct narration

### Scene / Creator reliability
- Select animations **before** `NewThread` so cancel/UI never claims a SexLab Making slot; `model.Initialize()` on post-NewThread abort
- `Scene.Setup` returns Bool; failed setup releases the scene instead of leaving a half-init slot
- `AnimationEnd` no longer creates a scene if one is already gone (avoids duplicate afterglow after stop)
- Stronger duplicate-actor checks in `StartScene`
- Generic threads refuse cleanly when already active; Release always unsets `thread_scene`

### JSON / prompts
- External JSON keys always bare lowercase via `ObjectToLowerCaseKeyJson` / `JsonLowerCaseKeys` (protocol **values** stay `_pain_`, `_pleasure_`, …) — [docs/reference/json-keys.md](docs/reference/json-keys.md)
- Activity prompt: removed UUID dumps; speaker match by actor UUID
- Outfit helper uses `[style] [how]`; removed obsolete `0520_sexlab_dressing_instructions.prompt`

### Logging / SKSE WebUI
- Papyrus traces route through `SkyrimNet_SexLab_WebUI.TraceLog` → `SKSE/SkyrimNet_SexLab.log`
- In-game PrismaUI target / sex menu (SKSE DLL + [docs/developers/webui.md](docs/developers/webui.md)); custom pulldowns; `actions_index.json` catalog
- Native menu open signatures use `Form` where required for unique NPCs / SKSE
- SkyrimNet plugin manifest: `sexlab.orgasm.delay` (orgasm delay seconds)

### Editor
- Stage description / orgasm-expected editors: ESC exits cleanly; parse failure no longer wipes animation JSON
- Multi-target menu blank intent defaults to `"sexual activities"`

### Docs
- Author/developer docs under `docs/` (players, authors, developers, reference); `llms.txt` agent router; root `guides/` removed
- `CHANGELOG.md` is the authoritative changelog (`update.md` removed)
