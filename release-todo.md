# Release / commit todos (postponed)

Choices deferred from active plans. Clear an item here before the gate it names (commit or release), or move it to a dated “wontfix” note with reason.

Related plan: SceneMenu dual-mode (`scenemenu_dual_mode`).

---

## Before commit (this feature branch)

Naming debt left in place to avoid churn during the dual-mode work. Fix before merging if the public surface should match “Scene Menu”:

- [ ] Rename main-panel id `scene_creator_panel` → `scene_menu_panel` (JSON catalog, JS builtins, C++ `showPanel` / `SwitchMainPanel` keys, docs).
- [ ] Rename DOM id `scene-creator-panel` → `scene-menu-panel` (HTML/CSS/JS).
- [ ] Rename catalog file `000_scene_creator_panel.json` → `000_scene_menu_panel.json` (and any FOMOD / install copies).
- [ ] Rename C++ / native symbols still called `SceneCreator_*` (`SceneCreator_Open`, `OpenSceneCreatorFromTargetMenu`, `onSceneCreatorResult`, etc.) to `SceneMenu_*` where they are the public WebUI bridge.
- [ ] Rename Papyrus helpers still saying SceneCreator in user-facing or WebUI paths (`TryOpenSceneCreatorMenu`, `ContinueAfterSceneCreator`, `WebUI_OnSceneCreator*`) if callers outside this mod depend on names — otherwise document as internal and leave.

Internal Papyrus quest scripts / EditorIDs (`SkyrimNet_SexLab_Scene_Creator_*`) may stay; they are the pre-start pool, not the UI name. Decide explicitly before release (see below).

---

## Before release

### Naming / product

- [ ] Decide whether quest / script `Scene_Creator` stays as the “new” connection backend forever, or gets a soft rename in docs only vs ESP/script rename (ESP rename is high-risk; prefer docs + UI unless a clean break is planned).
- [ ] Player-facing strings: hotkeys, MCM, YesNo copy that still say “Scene Creator”.
- [ ] `docs/players/*` and `docs/developers/webui.md` fully use Scene Menu + connection pulldown language (no leftover “Scene Creator” as the panel name).

### Mid-scene features deferred (sslThreadController)

Not in the dual-mode pass (approach A). Revisit before calling SceneMenu “complete” for active scenes:

- [ ] Offset adjust (`AdjustForward` / `Sideways` / `Upward` / `Schlong`).
- [ ] Scene center move/rotate (`CenterOnObject` / `Coords`, `MoveScene`, `RotateScene`).
- [ ] Reset / realign (`ResetPositions`, `RealignActors`).
- [ ] Stage timers / auto-advance (`SetTimers`, `UpdateTimer`, `AutoAdvance`).
- [ ] Force orgasm / disable-all orgasms beyond per-position O.
- [ ] Lead-in end/disable controls.
- [ ] Bed / furniture flag controls mid-scene.
- [ ] Creator starting-stage picker (if SexLab starting-stage is ever wired).

### UX / architecture

- [ ] Whether AnimationPanel should stay a separate main panel long-term, or fold stage/descriptions into SceneMenu and drop the Animation entry.
- [ ] Tag include/suppress mid-scene: keep as UI browse + Update only, or add auto refilter + `SetAnimations` when tags change on an active connection.
- [ ] AnimationPanel on `new`: playtest single-select AnimDb editor + disabled Prev/Next/Stop; confirm auto-select feels right when list rebuilds.

---

## Tracking

When an item is done, check it off here and note the commit. When deliberately abandoned, strike through and add one-line reason.
