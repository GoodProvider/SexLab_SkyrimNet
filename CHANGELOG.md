# Changelog

## [0.31.5](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.5) — since [0.31.4](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.4)

### Papyrus / scenes
- `PickNonVictimInitiator()` in `Scene.Setup`: if `num_victims > 0`, initiator is never a victim (keep current if non-victim; else positions 1…n then 0). First-stage `"X initiates: …"` only
- `GetSceneInactive`: `SetThread` before publishing `thread_scene[tid]`
- `GetSceneByThread`: `thread_scene[tid]` is authoritative during Setup (no `IsActive()` requirement); rebind when `GetThread()` is None or tid matches; Release only on tid mismatch
- `EnsureSceneForThread` from `AnimationStart` / `StageStart` (DOM / external SexLab threads)
- `thread == None` guards in `AnimationStart`, `GetDescription`, `GetThreadObj`

### Prompts
- `0050_sexlab_activity.prompt` (v0.31.5+): `_pain_` / `_pleasure_` vocalizations are “one to two” (dropped every-N-words); distracted cap 9 words (was 8); narration-enabled cap 20 words (was 12) and “Narration should move the action forward”; dropped consecutive-vocalization ban

### SKSE / WebUI
- `Papyrus_WebUI.cpp`: SkyrimNet PublicAPI via `extern` function pointers instead of `#include "PublicAPI.h"`; DLL rebuilt

## [0.31.4](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.4) — since [0.31.3](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.3)

### Actions / scenes
- Ship `scenes/no_penis.json` (`tags_suppress`: vaginal, anal) for giving actions that already pass `setting_name: no_penis`

### SKSE / SkyrimNet
- Add plugin manifest `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` with `sexlab.orgasm.delay` (orgasm delay seconds)

### Docs
- Migrate author/developer docs to `docs/` (players, authors, developers, reference); add `llms.txt` agent router; rewrite `release-guide.xml` / `documentation-guide.xml`; shorten `README.md`
- Root `guides/` removed in favor of `docs/`
