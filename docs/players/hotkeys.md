# Hotkeys and in-scene controls

Enable the optional hot key in the MCM (**Sex Description Editor** / related bindings).

## Out of animation

- Start a sexual act with crosshair NPC, or between NPCs not under crosshair
- Dress / undress under crosshair (including silently)
- **Punish:** spanking, spanking nude, whip, rape
- **Affection** (SexLab): hug, kiss, cuddle, spoon, headpat
- **Player rapes** / **rapes player**
- OstimNet installed: swap SexLab vs OStim framework
- Domination slave (`SkyrimNet_DOM.esp`): starts route through DOM handler APIs
- **Leash** (`SkyrimNet_Leashed.esp`): opens the SkyrimNet_Leashed PrismaUI leash panel (same as that mod’s panel hotkey). Shown only when Leashed is loaded. Does not require Leashed’s own hotkey to be enabled. On the PrismaUI Target Menu, **leash** closes this overlay first, then opens Leashed.

## In SexLab animation

- Change sex style (Tag Editor dialogs on)
- Add / edit per-stage description
- Set whether a given actor expects an orgasm

Stage JSON format: [../authors/animations.md](../authors/animations.md).

## WebUI menus

In-game PrismaUI target / sex menus (SKSE DLL). Build and paths: [../developers/webui.md](../developers/webui.md). Target Menu **leash** (when `SkyrimNet_Leashed.esp` is loaded) hides this overlay and opens Leashed’s bar.
