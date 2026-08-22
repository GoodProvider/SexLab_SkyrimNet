# Changelog

## Unreleased

### AnimDB
- Stop auto-rebuilding AnimDB on load. If counts differ from SexLab after SexLab is ready, notify `SkyrimNet SexLab # animations doesn't match` and show a SkyMessage (empty → Build/Close; mismatch → Rebuild/Close)

### SKSE / WebUI
- Menu hotkey always toggles ControlPanel: hide immediately when the overlay is visible (any focus actor); open TargetMenu only when hidden
- Ship `PrismaUI/views/SkyrimNet_SexLab/index.html` in the FOMOD zip (`make release` copies `PrismaUI/` into `core`)
- Do not Show/Focus the overlay until DomReady; Escape Unfocus/Hide if the view never loaded (missing HTML no longer pauses the game with a blank overlay)

## [0.31.4](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.4) — since [0.31.3](https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.31.3)

### Actions / scenes
- Ship `scenes/no_penis.json` (`tags_suppress`: vaginal, anal) for giving actions that already pass `setting_name: no_penis`

### SKSE / SkyrimNet
- Add plugin manifest `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` with `sexlab.orgasm.delay` (orgasm delay seconds)

### Docs
- Migrate author/developer docs to `docs/` (players, authors, developers, reference); add `llms.txt` agent router; rewrite `release-guide.xml` / `documentation-guide.xml`; shorten `README.md`
- Root `guides/` removed in favor of `docs/`
