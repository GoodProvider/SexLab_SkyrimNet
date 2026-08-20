# Hotkeys and in-scene controls

Enable the Start Sex / Edit Stage hotkey in either:

1. **SkyUI MCM** → Enable hotkey + KeyMap (DirectInput scancode), or
2. **SkyrimNet mod menu** → SkyrimNet_SexLab → Sex Description Editor hotkey fields (VK)

Both drive the same C++ `KeyHandler` via `WebUI_SetHotkey` / control-store apply. There is no separate Papyrus key sink.

## Out of animation

- Same hotkey **toggles** ControlPanel + TargetMenu (open if hidden, close if visible — any focus actor). Open uses ControlPanel actor focus (crosshair preferred; else nearby list — MultiTarget picker retired)
- Dress / undress under crosshair (including silently)
- **Punish:** spanking, spanking nude, whip, rape
- **Affection** (SexLab): hug, kiss, cuddle, spoon, headpat
- **Player rapes** / **rapes player**
- OstimNet installed: swap SexLab vs OStim framework
- Domination slave (`SkyrimNet_DOM.esp`): starts route through DOM handler APIs

## In SexLab animation

- Same hotkey toggles ControlPanel + TargetMenu; Animation main panel restores on open only if it was left open
- Mid-scene TargetMenu: stop / stage / position / animation / save to json
- Change sex style (when Tag Editor dialogs are on)
- Add / edit a per-stage description
- Change whether a given actor expects an orgasm

Stage JSON format: [../authors/animations.md](../authors/animations.md).

## WebUI menus

In-game PrismaUI target / sex / YesNo / Scene Creator menus (SKSE DLL). Build and paths: [../developers/webui.md](../developers/webui.md).
