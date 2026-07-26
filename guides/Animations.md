# Animations guide

How to create and share per-stage SexLab animation descriptions for SkyrimNet_SexLab.

See also: [README.md](../README.md) (players / hotkey / MCM), [Actions.md](Actions.md), [Prompts.md](Prompts.md), [Code.md](Code.md), [AGENTS.md](../AGENTS.md).

## Where files live

| Path | Purpose |
|------|---------|
| `SKSE/Plugins/SkyrimNet_SexLab/animations/_local_/` | Your edits (one JSON file per animation); loaded last and wins |
| `SKSE/Plugins/SkyrimNet_SexLab/animations/(author_name)/` | Shared packs; author name is shown when a description is used |
| `animations/GoodProvider/` | Example pack |

Directories are read in order; `_local_` is always last.

## In-game editing

Enable the Sex Description Editor hot key in the MCM. While an actor is in a SexLab animation, the hot key can:

- Add or replace a per-stage description
- Change whether a given actor expects an orgasm
- Change sex style (when Tag Editor dialogs are enabled)

When you add a description:

- If the stage already has one, you can view or replace it
- If not, a text field lets you add one; names are filled in and you can accept or reject
- Empty results usually mean wrong variable names

You can also edit the JSON files with any text editor after creation.

## Fallback behavior

- If no stage description exists, a tag-based description is used
- If the current stage has no description, the last earlier stage that has one is used

## JSON format

**Keys are case-sensitive** (JContainers). Use lowercase `"stage N"` and `"version"` — that is what the in-game editor writes.

```json
{
    "stage 1": {
        "description":"{{sl.actors.1}} fingers {{sl.actors.0}}.",
        "version": "2.0"
    },
    "orgasm_expected":[1,0]
}
```

### Inja format (`version` `2.0`)

- Actors are an array; if there is a victim, it is normally first
- Type actor indices alone if you need to see who is who
- `{{sl.actors.0}}`, `{{sl.actors.1}}`, `{{sl.actors.2}}`, …

## Orgasm Expected

Some animations should not imply every actor orgasms. Stored as an int array matching actor positions in the thread:

- `0` — does not expect an orgasm
- `1` — expects an orgasm

Editable in-game via the hot key while the animation is running, or by hand in the JSON.

## Sex Style

If Tag Editor dialogs are enabled, you can set style for how sex is presented to the LLM:

- Forcefully fucking
- having sex
- gently making love

## Sharing packs

You are strongly encouraged to add and share stage descriptions.

1. Zip your `_local_` folder (or a named author folder)
2. Use an author name (anonymous OK)
3. Send via Discord, or email da.good.provider@gmail.com

Recipients install under `SKSE/Plugins/SkyrimNet_SexLab/animations/(author_name)/`. Keep personal overrides in `_local_` so they win over shared packs.
