# Knowledgebase

## Scene Menu Start Control Panel new → Handoff (2026-08-16)

- Control Panel → Scene Menu → connection **new** seeds a provisional session (`_creator_sid:0`, `_from_target_menu:0`) with **no pooled** `Scene_Creator`. C++ Start then dispatches `WebUI_OnSceneCreatorResult(0, json)` because only `_from_target_menu` selects `WebUI_OnSceneCreatorHandoff`.
- `GetCreatorBySid(0)` misses → used to return with no Trace; SexLab never started. Result now Traces and falls through to Handoff (`CreateCreator` + `FinishStartScene`).
- Do **not** set `_from_target_menu` on Control Panel new — JS disables Load/Save presets when that flag is true. TargetMenu Custom keeps the flag; sid 0 is also a valid YesNo pool slot so C++ cannot infer provisional from sid alone.
- Same provisional seed in `Menu.SyncPanelsForActor` when focus is not SexLab-animating.

## Anidata schema 3.0 (2026-08-12)

- Contract: `docs/developers/anidata-schema.md` (+ accept/emit schemas under `docs/developers/schemas/`).
- Lookup: `<registry>.json` first, then display-name fallback (warn). Pack `_local_` last. No silent same-registrar merge.
- Port: `tools/port_anidata_v3.py --data-root <mods>` renames unambiguous display-name files; unmatched stay on display-name fallback.
- Stage change narration: `transitions["from-to"]` replaces `"Scene changes to "+desc` in `Scene.StageStart` when present.
- Rebuild AnimDB after upgrading so new SQLite columns / JSON packs are ingested.

## Nonsexual gender fallback / keep suppress (2026-08-10)

- **Policy / AnimDB none peel** (query-time; creator chips unchanged): after SexLab `GetAnimationsByTags` misses, (1) gender/position off with full must+suppress → (2) peel must-tags other than first (tail→front, keep `tags[0]`) → (3) peel suppress end→front with `tags[0]` → (4) drop front must-tag keeping full suppress (skip unconstrained 0+0). Never SexLab-random when original tags/suppress were set (`FinishStartScene` aborts).
- **`manager.empty` trap:** Scene Manager allocates `empty` as `sslBaseAnimation[2]` for identity compares. Never treat `anims.length > 0` alone as a hit — use `anims != manager.empty` (and `!= cancel`). Peel used to return after step1 miss because the sentinel looked non-empty.
- F/F + `nonsexual` often yields **0** from SexLab; AnimDB `_creature: exclude` + no gender/position finds F/M nonsexual while holding suppress as long as the peel allows.
- Callers: `SelectAnimations`, `ResolveAnimationsFromTags`, `SelectAnimationsDialog` final start.
- **SceneStart Custom:** fetch `scenes/{setting}.json` `tags_suppress` into `_tags_suppress` (fallback hardcode matches `nonsexual.json`); `filterByOnce='none'` for nonsexual/affection methods, otherwise Scene Creator default `gender`.
- **`SelectAnimationsDialog`:** probe/final miss never clears creator tags/suppress; peel is query-only then return to editor if still empty.

## Scene Menu filter-by downgrade (2026-08-10)

- Filter strictness in `MatchesFilter`: `positions` (per-slot `_pos_genders` + `_pos_race_keys`) ⊂ `gender` (aggregate counts, any arrangement) ⊂ `none` (`_actor_count` + tags + creature). Relaxing along that order can only gain animations.
- Each Scene Menu open arms the chain; `animDbQueryResult` steps one mode looser whenever the anim query returns zero and fallbacks remain. Tags query re-issues with the relaxed filter so available tags match the list.
- **Ordering trap:** in creator mode `scEnrichActorMeta()` resolves genders/race keys **after** the first query, so the opening `gender` pass runs on placeholder `_gender: 0`. Without re-arming on the `'e'` meta result the chain burns down to `none` before real genders exist. Re-arm from `SC.filterStart`, not the default mode, or the cuddle `none` seed flips back to `gender`.
- `animDbQueryResult` drops anim payloads whose `_request_id` != `'a' + SC.animQueryId`; C++ echoes the id verbatim and only `scRefreshAnims` issues `a`-prefixed queries, so a stale empty reply can no longer consume a chain step.
- Chain relaxes the **mode only** — actor count, tag chips, creature require/exclude, and **has description** still apply at `none`, so an empty list remains possible.

## StartScene tags CSV + SceneStartPanel (2026-08-13)

- Papyrus `StartScene_*` take **`tags`** (comma-separated), return **`Bool`**. Empty tags → skip AnimDB, still start. Non-empty → `AnimDb_ResolveTags` (sanitize + largest front-preferring subset, always lowercase); fail → False, no ModEvent.
- `AnimDb_CsvHasTag(csv, tag)` for membership checks (kissing → setting, etc.).
- YAML AI params stay named **`method`** (single value); ActionDispatch maps `method`↔`tags` positionally.
- TargetMenu inactive start rows share **`panel: scene_start`** (cuddle, punish, sex, masturbation, raped by, rapes, threesome). `panelDefaults` seed Subject / Object / `andThird` / intent / direction / method / style / setting. **Start** probes `AnimDb_ResolveTags` — hit → close WebUI + existing `StartScene_One/Two/Three` (JS picks; Object `to victim` → TargetVictim / Nonconsensual_Three); miss → `onNotify`, stay open. **Custom** closes SceneStartPanel, seeds Scene Creator (`SC.filterByOnce = 'none'` only for nonsexual/affection methods, otherwise `gender`) with Scene Setting `tags_suppress` fetched into `_tags_suppress`, then refreshes nearby so Include lists all in-range actors except `child`/`dead`.
- Layout: Subject; `none|and` + optional third actor; direction (giving/getting vs fucking/fucked in filters method); Object relation `with|to victim|none` + Object actor; intent (custom opens IntentPanel); style; Scene Setting. UI intents `show affection` / `comfort` map to Papyrus `showing affection` / `comforting`. Hug-giver @ SexLab pos1 when intent is those labels **or** method is `cuddling|kissing|hug` (`StartScene_Event` + Custom JS). Selectable pool gates: only player → Object disabled; player+one → `and`/third disabled. **Custom** stays enabled whenever Subject is set (missing Object / third / duplicates still open Scene Creator); **Start** keeps the stricter cast gates.
- Third is `participate` only (never a second victim). Solo + assault/punish uses `StartScene_Nonconsensual_One`.

## Parameters Position formId on Start (2026-08-08)

- Position 0/1 pulldowns write `{ type: "Actor", formId }` into `paramDict` (target/speaker). Custom/scene-seed already used `ResolveActorDictEntry`.
- **Bug:** `ExecuteAction` / `ExecutePapyrusOption` ignored `formId` and always `ResolveSource` (player/focus) — picking Toy had no effect on Start.
- **Fix:** Both paths resolve Actor dict via `ResolveActorDictEntry` first, then fall back to `source`.
- **Also:** `ExecutePapyrusOption` must apply UI params **after** `defaultsParameters` (same as `ExecuteAction`). Defaults-last wiped Cuddle `speaker`/`target` formIds back to `playerActor`/`currentActor`.

## TargetMenu Parameters pulldown clip (2026-08-08)

- `#right-dynamics { overflow-y: auto }` makes `overflow-x: visible` ineffective (CSS forces both axes). Right-opening `.pulldown-menu` children were clipped while Start/Custom (outside the scroller) still worked.
- Fix: `createPulldown` opens menus with `position: fixed` + `getBoundingClientRect` (`positionOpenPulldownMenu`); clear on close. Affects all action→Parameters paths (comfort/affection/punish/sex/masturbation/outfit), not cascade/papyrus option rows.

## Scratch files `z-*.*` (standing rule)

Always **ignore** files matching `z-*.*` (e.g. `z-plan.md`). Local scratch / notes only — not product docs or agent source of truth.

## ControlPanel actor focus + active TargetMenu (2026-08-07)

- ControlPanel bottom `#control-actor-pulldown` owns focus for TargetMenu / Scene Menu / AnimationPanel. `#target-name` and Scene/Animation **scene** pulldowns removed. OStimNet framework pulldown (`#framework-row`) sits on ControlPanel above the actor row.
- Nearby list (C++ `PopulateNearbyActors`): player first; then status `sexlab` → `ok` → ineligible (`child`/`cmbt`/`ostim`/`dead`/`load`); then distance. Labels crop name to 10 + status suffix. Soft Scene Menu pool = `selectable && status==ok`.
- Hotkey **always toggles** overlay visibility: visible → C++ `WebUI_Visibility_Hide` (no Papyrus); hidden → `Open_WebUI_Target` (+ `WebUI_AfterTargetOpen` default pick). Close does not require the same focus actor. MultiTarget retired for this path. Animation main-panel preference persists across hide; restore via `WebUI_MaybeRestoreAnimationPanel` only when focus is SexLab-animating **and** preference true.
- Active panels: `stop` (speaker + silent/stop/explain), `stage` (index/description table), `position` (whole-cast Scene Creator table), `animation` (AnimationPanel name picker in the main host).

## Active TargetMenu `type: papyrus` (2026-08-06, Actor/Scene split 2026-08-16)

- Mid-scene TargetMenu options under `webui/TargetMenu/Scene/options/*.json` use **`type: papyrus`** (no `name`, no YAML / `actions_index`). JS `onAction({action:"papyrus",...})` → C++ `ExecutePapyrusOption` → `SkyrimNet_SexLab_Actions.TM_*`. Actor (not animating) options live in `webui/TargetMenu/Actor/options/`. Catalog pick is ControlPanel focus `SexLabAnimatingFaction` — no per-option faction eligibility on Scene JSON. Actor **`panel: outfit`**: sentence `position_1` / style (`forcefully|normally|gently|silently`) / undresses|dresses / `position_0`; Start → `TM_Outfit`; no Custom; silently skips SkyrimNet narration.
- Storage: Animation JSON durable; AnimDB cache; Scene overlay this-thread only. Save (`TM_SaveAnimationSettings` / AnimationPanel Save) → SQL + JSON (`orgasm_expected`, `speaking_modifiers`, `clothed`). Victim/deny never durable; deny saves as expected=`1`. Full speaking token CSV is persisted (not token `[0]` only).
- Anim switch: `SeedOverlayFromAnimDb` — per-registry `user_anim_defaults` win, else AnimDB, else orgasm→speaking helper (`1`→`_pleasure_`, `0`→`""`).
- Live Scene panels (`panel` on option JSON): `stop` (speaker pulldown + silent/stop/explain), `stage` (`TM_GoToStage` / `TM_SetStageDescription`), `position` (whole-cast table → `TM_ChangeActors` / clothed / O expect vs not / V / speaking chips), `animation` (opens AnimationPanel picker; `TM_SetAnimationIndex`). LLM YAML deferred: `todo/active_action_yaml.md`.

## Debug SKSE DLL + PublicGetPluginConfigValue CTD (2026-08-05, harden 2026-08-16)

- **Symptom:** CTD on load / `kDataLoaded` — Crash Logger `EXCEPTION_ACCESS_VIOLATION` in `SkyrimNet_SexLab.dll` during `std::string` teardown (`std::exchange`).
- **Stack:** `plugin.cpp` → `Config::ApplyFromConfig` → `ApplyMenuHotkey` → `EditStageHotkeyEnabled` → `GetValue` → SkyrimNet `PublicGetPluginConfigValue` (returns `std::string` by value across DLL). Same AV later from `PublicGetActorNameByUUID` in WebUI.
- **Cause:** Debug-built `SkyrimNet_SexLab.dll` (~7.96 MB, `/MTd`) against Release SkyrimNet (`/MD`) — `std::string` layout mismatch. Stack shows `0xCCCCCCCC` fill and path `sexlab.controls.editStageHotkeyEnabled`. AV is on return/destructor; memcpy / `.c_str()` after the call cannot help.
- **Also:** `CMake: Build SKSE (Debug)` copies over `SKSE/Plugins/` (e.g. 2026-08-16 2:39 PM overwrote a 2:17 PM Release). In-game config needs Release.
- **Fix:** `_DEBUG` skips all SkyrimNet exports that return `std::string` (`CrossDllStdStringSafe` in `Config.h`) and uses hardcoded fallbacks. Ship / test config with `CMake: Build SKSE (Release)` (~2.66 MB).
- **Crash logs (this machine):** `C:\Users\bhuff\OneDrive\Documents\my games\Skyrim Special Edition\SKSE\crash-*.log` (OneDrive Documents).

## Plugin config / control store (2026-08-04)

- **Source of truth:** `SKSE/Plugins/SkyrimNet/config/plugins/SkyrimNet_SexLab/manifest.yaml` (`schema.fields`). New settings always go in the manifest; MCM may mirror utilities only.
- **IDs:** C++ `PublicGetPluginConfigValue("SkyrimNet_SexLab", path, def)`; Papyrus `SkyrimNetApi.GetConfig*("Plugin_SkyrimNet_SexLab", path, def)`.
- **Practical split:** C++ owns control-store hotkey (`sexlab.controls.editStageHotkey*` VK→DX via `MapVirtualKeyA`), WebUI Settings panel, and syncing `skyrimnet_sexlab_public_sex_accepted` / `hide_hermaphrodites` / `ostim_player` globals on load. MCM can also enable/remap the same KeyHandler via DX `WebUI_SetHotkey`. Papyrus only `GetConfig*` at Menu / Utilities / Scene / Creator / Manager call sites. No plugin `PatchConfig`.
- **ControlPanel framework toggle** still writes the ostim_player **global** for live eligibility; next load re-syncs from control store.
- **Settings main panel:** `webui/MainPanels/1000_settings.json` → `settings_panel` (rebuild → switches to Log, version from `info.json`, docs URL text, Open SkyrimNet dashboard). MCM shows redirect text + rebuild + last-rebuild timestamp.
- **Log main panel:** `webui/MainPanels/0900_log_panel.json` → `log_panel`. Source: `SKSE::log::log_directory()` + `SkyrimNet_SexLab.log`. JS regex filter; follow-tail until user scrolls away. Settings Rebuild AnimDB switches here so progress lines are visible.
- **No Prisma deep-link** to Plugins → SkyrimNet_SexLab; `TriggerToggleDashboard()` only toggles the SkyrimNet dashboard. **ShellExecute** for GitHub docs is unreliable in-game — show the URL as text instead.

## AnimationDB creature / race-key filter (2026-08-02)

- Scene Creator sets `_creature: require|exclude` from SexLab classification only (`GetGender` 2/3 + `sslCreatureAnimationSlots.GetRaceKey`). Do **not** treat non-creature as “human.”
- **Filter by pulldown** (`gender` / `none` / `positions`, default `gender`): `none` and `gender` apply `_creature` require/exclude without forcing `_position_match`. `gender` sends `_gender_match` + aggregate `_males`/`_females`/`_male_creatures`/`_female_creatures`. `positions` uses `_position_match` + `_pos_genders`; when any creature is present also `_pos_race_keys` (exact lowercase match vs AnimationDB `pos_race_keys`). Dog → only `"Dogs"` (primary GetRaceKey), not `creatures.json` display names.
- Anim list sort: selected/active → has-description → gender-position string (`FFM` from `_pos_genders`, 0/2→M 1/3→F).
- Positions carry `_race_key` from Papyrus `BuildWebUIState` / `GetRaceKeyForActor`. TargetMenu C++ open and nearby-add enrich via `onResolveActorMeta` → `WebUI_OnResolveActorMeta` → `actorAnimMetaResult`.
- WebUI `ParseFilterJson` must accept `_creature`, `_pos_race_keys`, `_gender_match`, `_males`, `_females`, `_male_creatures`, `_female_creatures` (parity with Papyrus AnimationDB parse).

## AnimDB no auto-rebuild on load (2026-08-21)

- Load opens SQLite only (`AnimDb_Open`). Do **not** call `StartSync(False)` from `Main.Setup`.
- After SexLab is enabled, compare `AnimDb_TotalCount` vs human+creature `Slotted`. Match → no prompt. Mismatch → `Trace` + notification `SkyrimNet SexLab # animations doesn't match`, then SkyMessage **above everything** (`ShowArray_NonBlocking`, poll `OnUpdate` — do not latent-block `OnPlayerLoadGame`).
- Empty DB: body `AnimDB is empty`, buttons **Build AnimDB** / **Close**. Non-empty mismatch: `AnimDB has N, SexLab has M`, buttons **Rebuild AnimDB** / **Close**. Close / ESC does nothing. Build/Rebuild → `StartSync(True)` (MCM / Settings still use `RebuildDatabase`).

## AnimationDB + PrismaUI scene panels (2026-08-01)

- **DB file**: `Data/SKSE/Plugins/SkyrimNet_SexLab/animationdb.sql` (SQLite via vcpkg `unofficial-sqlite3`). Registry / tags / race keys stored lowercase for matching; PK = SexLab `registry`. Display `name` (and `animations/(name).json`) keep SexLab casing.
- **Ingest**: Papyrus `SkyrimNet_SexLab_AnimDb` walks `GetBySlot` in batches (not SexLab `GetByTags` — 125-cap lossy). C++ `InferOrgasmExpected` seeds `pos_no_orgasm` / speaking mods; stage descriptions from `animations/**/*.json` (`_local_` last wins). Rebuild is player-opt-in (load prompt / MCM / Settings), not automatic.
- **YesNo / SceneCreator are async**: PrismaUI cannot block like SkyMessage. `SelectAnimations` returns `manager.ui_pending`; C++ JS listeners dispatch `Scene_Manager.WebUI_OnYesNoResult` / `WebUI_OnSceneCreatorResult` → `ContinueAfterYesNo` / `ContinueAfterSceneCreator` → `FinishStartScene`.
- **Yes always opens SceneCreatorMenu**; **Yes (Random)** skips editor; NPC–NPC opens creator when config `sexlab.tagEdit.nonPlayerDialogs` is on. Escape on YesNo = No (Silent).
- **TargetMenu Custom / Start**: root panel only; each pulldown + Parameters are sibling panels in a row **above** Scene Creator. Action click opens Parameters (no immediate start). **Custom** / **Start** close the cascade then fire; Custom opens Scene Creator (`_from_target_menu`, `_creator_sid:0`); Start on SC → `WebUI_OnSceneCreatorHandoff`. **Start** always `ExecuteAction` then **closes WebUI** (clear session + hide; PrismaUI `Focus(..., pauseGame=true)` must not stay focused or SexLab `StartThread` fails). Scene Creator **Start** also closes WebUI even when TargetMenu session is still active (Custom path). For scene-start actions sets `SkipSceneCreatorOnce` → `ConsumeSkipSceneCreator` → `scene_creator_menu_called` so Papyrus skips Scene Creator **and** YesNo (Yes/Random). SceneStartPanel **Start** (`action:"papyrus"` + `closeWebUI` + `StartScene_*`, not `Refused`) sets the same flag; outfit/live papyrus rows do not. Tag Edit MCM no longer intercepts TargetMenu Start.
- **Cuddle tags**: LLM/general method `cuddle` → `cuddling` (`RemapTag` / `Actions` / C++ `RemapMethod`). Dedicated cuddle actions keep UI method `sitting|laying` for narration but `Setup` adds SexLab tag `cuddling` (not sitting/laying — those are position tags and miss Ace cuddle packs).
- **`scene_creator_menu_called`**: once per creator / SexLab thread; `TryOpenSceneCreatorMenu` gates Papyrus first-open; Load/Save refresh still calls `SceneCreator_Open` directly. TargetMenu Custom may re-`configureSceneCreator` while TargetMenu stays open (`TargetMenuSessionActive`; HideAllPanels spares TargetMenu until Cancel). **Do not** keep TargetMenu open across Start — paused overlay blocks SexLab.
- **Scene Creator anim list**: query cap is 125 (SexLab `GetList`). Do **not** embed `JSON.stringify(anim)` in each row `onclick` — with 125 rows that freezes CEF during `configureSceneCreator` and the panel never paints. Keep rows in `SC.lastAnims` and pass an index. Rendered as a 5-column table (genders / modifiers / name / num stages / description); WebUI `AnimRowToJson` includes `_stage_descriptions` so the description column can substitute `{{sl.actors.N}}` from Scene Creator positions.
- **Scene presets**: Load/Save write `scenes/<name>.json` (no OS dialog); preserve `event_hook`. Do not `LoadSetting` on Start after UI edits — that overwrites tags.
- **Victim mask**: After WebUI V toggles, call `RebuildVictimsFromMask` — never `SetNames`/`SetMasks` (those rebuild the mask from `victims[]` and wipe UI).
- **AnimationMenu:** hotkey opens TargetMenu + ControlPanel focus; Animation main panel restores only if preferred-open and focus is SexLab-animating. AnimationPanel is an in-thread **name picker** (filter + scrollable list, no 10-cap); stage/position/stop live on TargetMenu Scene. Escape cancels the overlay (does not save empty AM state).
- **Scene Menu dual-mode (2026-08-02 / 2026-08-07):** UI label Scene Menu; scene focus from ControlPanel actor (no duplicate scene pulldown). Active: A/N + Update (SexLab anim list cap **128** via `sslUtility.PushAnimation`). Tags stay UI filters — pool mutates only on Update.
- **Legacy**: `SkyrimNet_SexLab_Stages` is an empty stub for save compatibility; all callers use AnimDb.

## Caprica rejects formal param name `scriptName` (2026-07-29)

Caprica fails natives that declare a parameter named `scriptName` with `no viable alternative at input 'String'` (even a one-arg stub). Callers are unaffected (positional). Use a different formal name (e.g. `sName`) and document the slot in a comment — see `SkyrimNet_SexLab_API.RegisterTargetMenuOption`.

## TargetMenuRegistry external options (2026-07-29)

`SkyrimNet_SexLab_API.RegisterTargetMenuOption(Form quest, …)` appends runtime actions to the WebUI Target Menu (end of `options` + `actions` in `BuildUICatalog`). Stores the quest **FormID** (not EditorID) — EditorID lookup often fails for optional handler ESPs and `FindQuest` would fall back to the main quest. Cleared on `kPostLoadGame` / `kNewGame`; handlers must re-register in `Setup` with `self as Form`. Click dispatches via `ExecuteAction` with a single `target` Actor arg.

**Preferred (2026-08-02, dest 2026-08-16):** optional handlers ship filesystem `webui/TargetMenu/Actor/options/*.json` with `plugin` + `questFormId` + `scriptName` + `executionFunctionName` (+ optional `requiresPlugin`). UDNG bondage uses this via FOMOD; `RegisterTargetMenuOption` is legacy (Actor catalog only).

## ControlPanel / MainPanels (2026-08-02, rename 2026-08-16)

Left column: ControlPanel (`#control-panel`: title + main_panel pulldown + pause/unpause + OStimNet framework pulldown + **actor focus pulldown**) above TargetMenu (10% top/left). Right: one main panel (10% top/bottom/right) from `webui/MainPanels/` (`builtin` or `papyrus`). Pulldown → `onMainPanelChange` → `SwitchMainPanel`. Catalog invoke: `configureControlPanel`. Actor focus → `onControlActorChange` → `ApplyControlActorFocus` / `WebUI_OnControlActorFocus`. `WebUI_Visibility_Show` pushes `setFrameworkToggle`.

- **Pause toggle (2026-08-05):** PrismaUI `Focus(view, true)` pauses the game (default on Show). ControlPanel button toggles pause while the view stays shown. **Quirk:** calling `Focus` again while already focused does **not** change `pauseGame` — must `Unfocus` then `Focus(pauseGame)` to switch. Button label: **unpause** when paused, **pause** when running.

- **ControlPanel missing after Start (2026-08-16):** Scene Creator / papyrus Start hide `#control-panel`. Same-actor `Target_Menu_Open` used to only `configureTargetMenu` + Show, skipping `showPanel`. Overlay came back with TargetMenu/ControlPanel still `display:none`. Fix: `WebUI_Visibility_Show` invokes `showControlPanel()`; same-actor open also `showPanel('target_menu_panel')`.

- **Scene Menu appear/disappear loop (2026-08-03):** Do **not** call `requestSceneConnectionChange` from `revealMainPanel`. Connection reload → `SceneCreator_Open` (`showPanel` → `onMainPanelChange` → `SwitchMainPanel` → reveal) loops. Soft path: `SceneCreator_Configure` / `Animation_Menu_Configure` (no HideAll/showPanel); `WebUI_OnSceneConnectionChange` and `WebUI_OnAnimUpdate` use Configure; `SwitchMainPanel` invokes `mainPanelDidOpen()` once on **key change** only. `showPanel` for SC/AM is idempotent when already selected.

## SKSE native params must use engine types (2026-07-25)

CommonLib `RegisterFunction` derives the Papyrus signature from C++ types (`RE::TESForm*` → `Form`, `RE::Actor*` → `Actor`, etc.) and refuses to bind if the `.pex` differs. Declaring a specific script type on a native (e.g. `sslThreadController`) causes: `Native static function … does not match existing signature … Function will not be bound.`

**Fix**: Use engine types in the Papyrus stub that match C++ — e.g. `Sex_Menu_Open(Form thread, bool has_player)` with `RE::TESForm*`. Callers may still pass `sslThreadController` (it is a Quest/Form).

## ModEvent PushForm actors must be received as Form (2026-07-25)

SexLab/SLSO `SexLabOrgasm` uses `ModEvent.PushForm(eid, ActorRef)`. Handlers that declare the first parameter as `Actor` fail type-check for unique NPCs whose **attached script** is an Actor subclass — e.g. vanilla `WIDeadBodyCleanupScript` on Camilla (`CamillaValeriusREF`). Papyrus reports `received incompatible arguments! Received types (WIDeadBodyCleanupScript,int,int) instead!` and the event never runs (orgasm narration dropped for that NPC).

**Fix**: Receive `Form`, then `akForm as Actor` (same pattern as this mod’s `Action_Stop` / `MenuOpen`). `WIDeadBodyCleanupScript` is often on living uniques — it is cleanup-on-death, not “already dead.”

## PrismaUI view path (2026-07-24)

`CreateView("SkyrimNet_SexLab/index.html")` loads from **`Data/PrismaUI/views/`**, not from `SKSE/Plugins/`. This mod ships the overlay at `PrismaUI/views/SkyrimNet_SexLab/index.html` (restored from commit `a8c9440`). **`make release` copies `PrismaUI/` into FOMOD `core`** so it installs under Data. Missing that file → valid-looking C++ open path (hotkey / `Target_Menu_Open`) but **no visible UI**. Do **not** `Show`/`Focus` until `g_domReady` — `Focus(view, true)` pauses the game; Escape is JS `handleGlobalEscape` which never runs if DomReady never fires (player stuck paused). C++ Escape and a refused open `Unfocus`/`Hide` instead. Papyrus `Open_WebUI_Target` notifies when `Target_Menu_Open` returns false. C++ Invokes use panel ids `target_menu_panel` / `sex_menu_panel`; the HTML maps those via `showPanel` / `hidePanel` adapters onto `#target-panel` / `#sex-menu-panel`.

**Display scale (2026-08-07):** Matches SkyrimNet dashboard scaling system. Design tokens are **px** (`--text-base: 15px`, `--space-*`, `--radius`, `--target-min: 44px`); global scale is `document.body.style.zoom = clamp(ui_scale,0.75–1.5) * resolutionBaseline()` where baseline is `1` at ≤~1080p height else `(innerHeight/1080)*0.85` (up-only; never shrinks from resolution). User `ui_scale` from `GET {__SN_BASE__||http://localhost:8080}/config?api=get&name=Dashboard`. Fit without crop: `#left-column` / target panels use `max-height` + `overflow-y: auto` (same pattern as SkyrimNet’s `.main` scroll). Re-applies on resize and Settings configure.

**Menu hotkey (2026-08-04, toggle 2026-08-16, DomReady guard 2026-08-21):** Control store `sexlab.controls.editStageHotkeyEnabled` + `editStageHotkey` (VK→DX). MCM also has Enable + KeyMap (DX) → `WebUI_SetHotkey`. MCM Setup only re-applies when its toggle is on (does not clear a store-enabled key). Escape stays always registered; if DomReady never fired, Escape is C++ `WebUI_Visibility_Hide` (Unfocus), not queued JS. Hotkey hides immediately when the overlay is visible (any actor); otherwise `Menu.ProcessHotkey` → `Open_WebUI_Target`. Same-actor reopen rebuilds catalog, `showPanel('target_menu_panel')`, and Show (ControlPanel included). Do not dispatch `AfterTargetOpen` on close. Do not Show/Focus until `g_domReady`.

## WebUI target menu catalog (2026-07-28, outfit/actionSwitch 2026-07-31, split layout 2026-07-31)

Target panel UI is driven by:
- `Data/SKSE/Plugins/SkyrimNet_SexLab/webui/TargetMenu/Actor/defaults.json` — `{ "defaultsParameters": { ... } }` (legacy root key `defaults` still accepted).
- `Data/SKSE/Plugins/SkyrimNet_SexLab/webui/TargetMenu/Actor/options/*.json` — start-scene + outfit when focus is **not** in SexLabAnimatingFaction.
- `Data/SKSE/Plugins/SkyrimNet_SexLab/webui/TargetMenu/Scene/options/*.json` — live-scene group editors when focus **is** animating.
- `Data/SKSE/Plugins/SkyrimNet_SexLab/webui/actions_index.json` — generated from SkyrimNet action YAMLs (`tools/generate_actions_index.py`); `{ "actions": [...] }` only (no `by_category`).

**Order = lexicographic filename** (numeric prefixes). All JSON keys lowercase. Pulldowns / switches nest via `options[]`; each `action` needs `name` (SkyrimNet id) + `label` (WebUI display only). Optional `parameters` on `action`/`pulldown` overrides defaults. C++ loads both trees and `BuildUICatalog` picks Actor vs Scene.

**Actor sources** in `defaultsParameters`: prefer `playerActor` (player) and `currentActor` (menu focus). `ActionDispatch::ResolveSource` also accepts legacy `player` / `target` / `focus`.

**`actionSwitch`**: `options[]` of `action` children, each with SkyrimNet-shaped `eligibilityRules`. C++ evaluates in order, takes the **first** true branch, logs the winner. No match → emit disabled/greyed row using switch `label` or first child’s `label`. Menu focus is `currentActor` for `FormListCount` / strip storage.

**Outfit roles**: Papyrus `Outfit_Dress` / `Outfit_Undress(Speaker, Target, style, narration)` — Speaker performs, Target’s outfit changes; StorageUtil key `skyrimnet_sexlab_storage_items` is on **Target**. Narration `silent` → `RegisterEvent`. Style `silently`/`silent` skips both DirectNarration and RegisterEvent. TargetMenu dress/undress is papyrus `panel: outfit` → `TM_Outfit` (not YAML Start); FormListCount eligibility picks the undress vs dress left-row label; execute uses `HasStrippedItems` on selected position_0. Hotkey opens via `Menu.Open_WebUI_Target` (passes `HasStrippedItems`).

Regenerate the index after editing action YAMLs. C++ `ActionCatalog` loads at WebUI init and **reloads on every `kPostLoadGame` / `kNewGame`** (`WebUI_SetGameReady`); Start merges dictionary onto YAML `parameterMapping` and `DispatchMethodCall`s `scriptName`/`executionFunctionName`. Do not change SkyrimNet YAML schema — only action content within existing fields.

Guideline: if a pulldown would have only one child, promote that child to a top-level `action`.

## TargetMenu hierarchical param store (2026-08-02)

Do **not** remember dynamic fields under flat `sns_tm_param:<name>` — shared names (`method`, `direction`) leaked across actions (e.g. comfort `hugging` onto fucking). JS builds a parent-linked tree from the catalog (synthetic root `id=0`; DFS creation ids; `path = parent.path + '.' + label`). Values live at `sns_tm_node:{id}.{path}.{key}` (empty path → `sns_tm_node:0.style`). Global `parameter` options (e.g. `style`) read/write the **root**. Action dynamics initialize fill-if-absent by walking parents for an **allowed** YAML pipe match (style synonyms `gently↔gentle`, `normally↔normal`, `forcefully↔forceful`), else first pipe / full non-pipe description; then store on that action node. `configureTargetMenu` clears legacy `sns_tm_param:*`.

## SexLab position slots and speaker_position (2026-07-23)

In this mod's sex / punish animations, **position_0 is submissive** and **position_1 is dominant**:
- position_0 gives oral to position_1; position_1 receives oral from position_0.
- position_1 fucks into position_0; position_0 is fucked by position_1.
- Punish scene JSON puts `_pain_` (and whipping `_gagged_`) on index 0.

The **Speaker is always the subject** of LLM-facing sentences. `speaker_position` places the Speaker into that slot:
- `StartScene_Nonconsensual_Two_TargetVictim` → speaker at **pos1** (target is victim).
- `StartScene_Nonconsensual_Two_SpeakerVictim` → speaker at **pos0** (speaker is victim).
- Consensual direction tokens (Speaker as subject): `fucking` / `fuck a` / `fucking a` / service `getting` → pos1; `fucked in` / service `giving` → pos0.
- **Cuddling intents** (`cuddling` / `showing affection` / `comforting`): opposite of oral — `giving` → pos1 (hug giver / male slot); `getting` → pos0.

## Intent start/finish mirror (2026-07-23)

`GetIntentMessage(START)` → `"A and B start <intent>."`; `GetIntentMessage(END)` → `"A and B finish <intent>."` (same actors + same static intent phrase). Intent is not always sexual — examples: `sexual activities`, `showing physical affection`, `physically comforting each other`, `physically punishing`, `sexual assault`, `cuddling`. YAML `intent` values must be static phrases that fit both templates.

## Orgasm totals via GetIsOrgasming (2026-07-24)

`Scene.GetIsOrgasming(Actor, total_orgasms=-1)` is the single place that both bumps per-actor totals (`StorageUtil` + `total_orgasm`) and returns the `" is orgasming."` prompt-gate clause. Call sites: `OrgasmCombined` (stash), `OrgasmIndividual` (SLSO absolute `num_orgasms`), `OrgasmCustom` (always increment; append only if substring missing). When `thread.Animation` has tag `tentacles`, `GetIsOrgasming` appends tentacles flavor on that orgasming actor only — do **not** force-orgasm all positions from `AnimationEnd`. `OrgasmMessagesToNarration` must not increment again on flush. "again" uses the post-update `GetTotalOrgasms` count (not the pre-increment `-1` local).

## Scene pool generic fallback (2026-07-26)

`GetSceneInactive` may bind `sl_scene_generic` only when `!GetThreadActive()`. Concurrent 11th+ scenes refuse allocate (`None`) rather than overwrite a live generic — avoids CK pool expansion. `Scene.Release` always `UnsetThread_scene(tid)` including generic.

## Creator.Setup returns Bool (2026-07-26)

`Scene_Creator.Setup` returns `False` on link/empty-actor failure (no `STATUS_ACTIVE`). `CreateCreator` returns `None` when Setup fails or pool exhausted; all callers must gate on `None` (Action_Start, Menu multitarget, CreateSceneWithoutCreator, GetSceneByThread).


## Pyro / UIExtensions import (2026-07-24)

`skyrimse.ppj` imports `@ModsFolder\UIExtensions\scripts\Source`. If that folder is empty, Caprica fails with `unable to locate script UIExtensions`. Restore real UIExtensions sources there (stubs only for compile smoke tests).

## Orgasm stash / AnimationEnd pipeline (2026-07-23)

1. `OrgasmCombined` / Combined `OrgasmCustom` stash messages and call `thread.UpdateTimer(4.0)` to extend the current stage.
2. Next `StageStart` flushes via `OrgasmMessagesToNarration()` into stage narration (no `OnUpdate` flush).
3. `AnimationEnd`: leftover `OrgasmMessagesToNarration()` → `RegisterEvent` if non-empty → `PurgeDialogue` → `GetIntentMessage(END)` finish mirror (+ SeparateOrgasms afterglow). Do not narrate ongoing activity at end.

## Actor lock key (2026-07-23)

Creator locks with `skyrimnet_sexlab_scene_actor_lock`. Action YAML eligibility and `Main.storage_actor_lock_key` must use the same string (not `skyrimnet_sexlab_actor_lock`).

## Punish-rape setting_name must match scene file (2026-07-22)

`sexlab_punish_rape_target.yaml` / `sexlab_punish_rape_target_by_target.yaml` must use `setting_name: punish_pleasure_pain_rape` (file `scenes/punish_pleasure_pain_rape.json`). A swapped token order (`punish_pain_pleasure_rape`) fails to load the scene. Hotkey Menu.psc uses the correct name. See review-checkpoint `Y-RapeSettingName`.

## SkyrimNet action YAML practice (2026-07-18)

Full authoring guide: [docs/authors/actions.md](docs/authors/actions.md).

Actions live in `SKSE/Plugins/SkyrimNet/config/actions/`. Executable YAMLs dispatch to `SkyrimNet_SexLab_Actions` via positional `parameterMapping` — order and types must match the Papyrus signature; mapping `name` is LLM-facing only.

- **Hard limit: max 8 `parameterMapping` entries** per action YAML (SkyrimNet). Threesome actions already use all 8; do not add a 9th — fold into an existing dynamic, use `setting_name`, or a fixed-role Papyrus wrapper.
- `static` requires `value`; `dynamic` requires `description` (not `value`).
- Prefer Papyrus slot names in mappings (`method`, not `type`; `how` for outfit).
- Action `name` must be unique across all YAMLs.
- Fixed-role nonconsensual two-actor scenes use `StartScene_Nonconsensual_Two_TargetVictim` / `_SpeakerVictim`. Dynamic victim uses `StartScene_Nonconsensual_Two` with an explicit `victim` mapping. Do not pass obsolete `speaking_victim`.
- Eligibility rule groups that exist should set `logicalOperator` and `required: true` (`required: false` is ignored by SkyrimNet).
- Category parents: only `name` / `description` / `customCategory` / `enabled` / eligibility — no `description_` field; keep PARAMS JSON valid.

Upstream schema: [WORKFLOW_ACTIONS.md](https://github.com/MinLL/SkyrimNet-GamePlugin/blob/main/docs/modding/WORKFLOW_ACTIONS.md).

## StageStart scene-change must not wipe orgasm narration (2026-07-17)

**Symptom**: `OrgasmCombined` stashes `"bob is orgasming. "` and sets `orgasm_messages_set`, but final DirectNarration is only `"Scene changes to …"` + cum — no `" is orgasming."`, so `0550_sexlab_narration.prompt` never gates.

**Cause**: In `Scene.StageStart`, after building `narration` from `orgasm_messages`, `desc != description_last` did `narration = "Scene changes to "+desc`, which replaced the orgasm/denied block. `orgasm_happened` stayed true (cum still appended); only the orgasm text was lost.

**Fix**: When the stage description changes, lead with `"Scene changes to "+desc` and **append** any existing orgasm narration instead of assigning over it. Non-orgasm ChangePosition path (empty narration) is unchanged.

## EnsureActorArraysLargeEnough must check both arrays (2026-07-16)

**Symptom**: `OrgasmCombined` — `Cannot access an element of a None array` on `orgasm_messages[i]`.

**Cause**: `EnsureActorArraysLargeEnough` early-returned when only `position_objs` was large enough. After save/load (or when `orgasm_messages` was added later), `position_objs` can be restored while `orgasm_messages` stays None.

**Fix**: Early-return only when **both** `position_objs` and `orgasm_messages` exist and meet `size`. `OrgasmCombined` also calls `EnsureActorArraysLargeEnough(num_actors)` before indexing (same pattern as `OrgasmCustom`).

## Papyrus string literals do not treat `\n` as newline (2026-07-15)

`"\n"` / `"\r\n"` in Papyrus source are backslash + letter(s), not control characters. Use `StringUtil.AsChar(10)` (LF) and `StringUtil.AsChar(13)` (CR). This project already does that in `Stages.psc` / `MCM.psc` via a `newline` field.

## SexLab orgasm narration trigger (2026-07-14)

**Prompt**: `SKSE/Plugins/SkyrimNet/prompts/submodules/user_final_instructions/0550_sexlab_narration.prompt` uses `contains(_direct_narration, " is orgasming.")`.

**Contract**:
- Orgasming actors’ clauses in Combined/custom narration must include `" is orgasming."`.
- Non-orgasming / denied clauses must not (e.g. `HandleOrgasmDenied`, “did not orgasm”, SeparateOrgasms “failed to orgasm”).
- Dom custom path: `Handler_DOM.DOMSlave_Orgasmed` → `Scene_Manager.OrgasmCustom` appends `". "+name+" is orgasming."` before Scene stashes/sends. Required for the prompt gate.
- Dom Combined fallback: when `_dom_slave`, `orgasm_expected==1`, totals > 0, and custom message empty, Scene still appends `name+" is orgasming. "` so the prompt gate fires if Dom feed raced past Combined.
- Dom feed: sibling `SkyrimNet_DOM_Events.OnNotificationSent` (Ext3 on) routes description containing `"orgasm"` to `DOMSlave_Orgasmed`. Prefer notifications over `DOMOnOrgasm` (faster; leave Orgasm unregistered). Dom `SexLab_AnimationStart` may `DisableOrgasm` on Dom actors so SexLab hooks alone will not narrate them. If Ext3 is off: Dom melt HUD can fire while DN denies the slave or narrates other actors only — see SkyrimNet_DOM KNOWLEDGEBASE “Dom melt without DirectNarration”.

**SeparateOrgasms**: Manager skips Dom on `SexLabOrgasm`; `Scene.OrgasmCustom` must use `config.SeparateOrgasms` and call `OrgasmHelper` immediately when Separate is on; otherwise stash into `customer_orgasm_messages` for `HookOrgasmStart` Combined.

## Scene pool / GetSceneInactive None (2026-07-12)

**Symptom**: `Cannot call SetThread() on a None object` in `GetSceneInactive` after `Failed to find inactive sl_scene using generic`, even with **no active SexLab animations** (pool should be free).

**Causes**:
1. Property rename `scenes`/`scene_generic` → `sl_scenes`/`sl_scene_generic`: Auto property fills are **baked into saves**. Old saves keep empty new-name properties; `creators` (unchanged name) still works. Runtime pool looks empty → fallback to None generic → crash.
2. `sl_scene_generic` Auto property unresolved → fallback `SetThread` crashed (no None guard).
3. `STATUS_*` were `Auto` (not `AutoReadOnly`). Saves can corrupt constants so `IsActive()` stays true forever.
4. `Initialize` did not reset `status` / clear stale `thread`.

**Fixes**: `RebuildScenePool()` via `GetFormFromFile` every Setup; None-guard + generic recovery; `STATUS_*` → `AutoReadOnly`; reset `status`/`thread` on Initialize; reclaim by `GetThreadActive()` (not status alone).

## DOM / external thread scene bind race (2026-07-27)

**Symptom**: Native DOM SexLab threads log `[SkyrimNet_SexLab_Stages.GetStageDescription] thread is None` shortly after `SetPosition` during scene auto-create. SkyrimNet prompts may lack activity/description for that thread.

**Cause**: `GetSceneInactive` published `thread_scene[tid]` before `SetThread(thread)`. A reentrant `GetSceneByThread` (from `SaveThreadsJson` / decorators during first-frame Setup) saw `GetThread() == None`, failed reference equality, and `Release()`'d the scene mid-Setup. `SetPosition` could still finish; later `GetDescription` ran with `thread == None`.

**Fixes**: `SetThread` before `thread_scene[tid]` in `GetSceneInactive`; `GetSceneByThread` treats `thread_scene[tid]` as authoritative (rebind by `tid`, never Release solely for transient `GetThread() == None`); `EnsureSceneForThread` on `HookAnimationStart` / `HookStageStart`; thread guards in `Scene.AnimationStart` / `GetDescription` / `GetThreadObj`.
