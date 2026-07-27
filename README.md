# SkyrimNet_SexLab

Adds SkyrimNet (LLM) support to SexLab Framework.

- **Players:** [docs/players/overview.md](docs/players/overview.md) · [hotkeys](docs/players/hotkeys.md) · [requirements](docs/players/requirements.md)
- **Authors:** [actions](docs/authors/actions.md) · [prompts](docs/authors/prompts.md) · [animations](docs/authors/animations.md)
- **Developers:** [papyrus](docs/developers/papyrus.md) · [webui](docs/developers/webui.md)
- **Agents:** [AGENTS.md](AGENTS.md) · [llms.txt](llms.txt) · [release-guide.xml](release-guide.xml) · [documentation-guide.xml](documentation-guide.xml) (portable template for other repos)
- **Changelog:** [CHANGELOG.md](CHANGELOG.md) · [CHANGELOG-user.md](CHANGELOG-user.md)

## Quick start

1. Install requirements ([docs/players/requirements.md](docs/players/requirements.md)).
2. Put `SkyrimNet_SexLab.esp` last; enable narration in SkyrimNet.
3. If Actions fail: Game Data Explorer → `_sexlab` → Refresh (see [FAQ](docs/players/overview.md)).

## Extending

| Task | Doc |
|------|-----|
| New LLM action / scene | [docs/authors/actions.md](docs/authors/actions.md), [docs/reference/scene-settings.md](docs/reference/scene-settings.md) |
| Prompt / speaking tokens | [docs/authors/prompts.md](docs/authors/prompts.md), [docs/reference/protocol-tokens.md](docs/reference/protocol-tokens.md) |
| Stage descriptions | [docs/authors/animations.md](docs/authors/animations.md) |
| Papyrus / SKSE | [docs/developers/papyrus.md](docs/developers/papyrus.md), [docs/developers/webui.md](docs/developers/webui.md) |
