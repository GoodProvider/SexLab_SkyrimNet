#pragma once

#include "PCH.h"

namespace PapyrusBindings_WebUI {
    extern RE::Actor* Target_Current;

    /// Papyrus native: open/toggle the WebUI target menu for an actor.
    /// hasStrippedItems: focus actor has skyrimnet_sexlab_storage_items (for actionSwitch).
    /// editTagsPlayer / editTagsNonPlayer: MCM Tag Edit (cached for TargetMenu → Scene Creator).
    void Target_Menu_Open(RE::StaticFunctionTag*, RE::Actor* Target_Input, bool hasStrippedItems,
        bool editTagsPlayer, bool editTagsNonPlayer);

    /// Re-resolve actionSwitch / refresh catalog while menu stays open.
    void Target_Menu_Refresh(RE::StaticFunctionTag*, bool hasStrippedItems);

    /// MCM Tag Edit flags last passed to Target_Menu_Open.
    extern bool EditTagsPlayer;
    extern bool EditTagsNonPlayer;
    /// C++ TargetMenu opened Scene Creator; cleared on Start handoff / cancel.
    extern bool SceneCreatorOpenedForPending;
    /// TargetMenu is open until Cancel / Reset — HideAllPanels spares it.
    extern bool TargetMenuSessionActive;
    /// One-shot: TargetMenu Start should skip Scene Creator for the next Action_Start creator.
    extern bool SkipSceneCreatorOnce;

    void ClearSceneCreatorPending();
    void ClearTargetMenuSession();
    /// Reads and clears SkipSceneCreatorOnce (Papyrus native).
    bool ConsumeSkipSceneCreator(RE::StaticFunctionTag*);
    void DispatchManagerMethodStrOnly(const char* method, const std::string& b);

    /// Papyrus native: open the in-scene sex menu panel overlay.
    void Sex_Menu_Open(RE::StaticFunctionTag*, RE::TESForm* thread, bool has_player);

    /// Yes/No confirm before scene creator (creator_sid = Scene_Creator.sid).
    void YesNo_Open(RE::StaticFunctionTag*, RE::BSFixedString question, std::int32_t creator_sid);

    /// Scene creator tag/animation editor (JSON state from Scene_Creator.BuildWebUIState).
    void SceneCreator_Open(RE::StaticFunctionTag*, RE::BSFixedString state_json);

    /// Soft configure Scene Menu without HideAllPanels / showPanel (connection refresh).
    void SceneCreator_Configure(RE::StaticFunctionTag*, RE::BSFixedString state_json);

    /// Push SexLab gender + race_key enrich result to Scene Creator JS.
    void ActorAnimMeta_Result(RE::StaticFunctionTag*, RE::BSFixedString json);

    /// Active-animation menu hotkey entry; dispatches Papyrus to build payload then show.
    void Animation_Menu_Open(RE::StaticFunctionTag*, RE::TESForm* thread, RE::TESForm* sl_scene);

    /// Show animation menu panel after Papyrus built state JSON.
    void Animation_Menu_Show(RE::StaticFunctionTag*, RE::BSFixedString state_json);

    /// Soft configure Animation panel without showPanel (connection refresh).
    void Animation_Menu_Configure(RE::StaticFunctionTag*, RE::BSFixedString state_json);

    /// Push scene connection pulldown options to JS.
    void SceneConnections_Show(RE::StaticFunctionTag*, RE::BSFixedString state_json);

    void WebUI_HideAllPanels(RE::StaticFunctionTag*);

    /// MCM: enable/disable C++ menu hotkey and set DX scancode (Escape unchanged).
    void WebUI_SetHotkey(RE::StaticFunctionTag*, std::int32_t dxScanCode, bool enabled);

    /// Papyrus: push last AnimDb rebuild timestamp for Settings panel.
    void WebUI_SetLastRebuildTimestamp(RE::StaticFunctionTag*, RE::BSFixedString timestamp);

    /// Papyrus native: format and write a script log line via SKSE::log.
    RE::BSFixedString TraceLog(RE::StaticFunctionTag*, RE::BSFixedString script_name,
        RE::BSFixedString func, RE::BSFixedString msg);

    /// Registers SkyrimNet_SexLab_WebUI natives on the Papyrus VM.
    bool Register_WebUI_Functions(RE::BSScript::IVirtualMachine* a_vm);

    /// Soft session gate for nearby scan (dead/combat/factions/3D). Papyrus adds StorageUtil + SexLab IsValidActor.
    bool IsAvailableActor(RE::Actor* actor);

    /// True when actor is in SexLab AnimatingFaction.
    bool IsSexLabAnimatingFocus(RE::Actor* actor);

    /// After Target_Menu_Open: pick ControlPanel default and maybe restore Animation panel.
    void WebUI_AfterTargetOpen(RE::StaticFunctionTag*, RE::Actor* preferred, bool preferExplicit);

    /// Restore Animation main panel when preferred-open and focus is in SexLab.
    void WebUI_MaybeRestoreAnimationPanel(RE::StaticFunctionTag*);

    /// JS ControlPanel actor pick → set Target_Current + Papyrus sync.
    void ApplyControlActorFocus(std::uint32_t formId);

    /// Pushes player + nearby actors into JS before showing the overlay.
    /// radius < 0 keeps the last range (default 100).
    void PopulateNearbyActors(float radius = -1.f);

    /// Allowed nearby scan radii (MultiTarget-compatible).
    bool SetNearbyRadius(float radius);
    float GetNearbyRadius();

    /// No crosshair actor: dispatch Papyrus MultiTarget_Menu_Selection picker.
    void Call_MultiTarget_Menu_Selection();

    /// Hotkey path: Papyrus Menu.Open_WebUI_Target(actor) with HasStrippedItems.
    void Call_Open_WebUI_Target(RE::Actor* target);

    /// Hotkey path: Papyrus Menu.ProcessHotkey(keyCode).
    void Call_ProcessHotkey(std::int32_t keyCode);

    extern std::int32_t YesNo_Creator_Sid;

    void DispatchManagerMethodIntInt(const char* method, std::int32_t a, std::int32_t b);
    void DispatchManagerMethodIntStr(const char* method, std::int32_t a, const std::string& b);
    void DispatchAnimationMenuExportState(RE::TESForm* thread, RE::TESForm* sl_scene);
    void HandleAnimDbQuery(const char* value);

    /// JS: onAnimDbResolveTags({_request_id, _tags, _actor_count}) → animDbResolveTagsResult
    void HandleAnimDbResolveTags(const char* value);

    /// JS: onNotify({msg}) → RE::DebugNotification
    void HandleNotify(const char* value);
}
