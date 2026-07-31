#pragma once

#include "PCH.h"

namespace PapyrusBindings_WebUI {
    extern RE::Actor* Target_Current;

    /// Papyrus native: open/toggle the WebUI target menu for an actor.
    /// hasStrippedItems: focus actor has skyrimnet_sexlab_storage_items (for actionSwitch).
    void Target_Menu_Open(RE::StaticFunctionTag*, RE::Actor* Target_Input, bool hasStrippedItems);

    /// Re-resolve actionSwitch / refresh catalog while menu stays open.
    void Target_Menu_Refresh(RE::StaticFunctionTag*, bool hasStrippedItems);

    /// Papyrus native: open the in-scene sex menu panel overlay.
    void Sex_Menu_Open(RE::StaticFunctionTag*, RE::TESForm* thread, bool has_player);

    /// Papyrus native: format and write a script log line via SKSE::log.
    RE::BSFixedString TraceLog(RE::StaticFunctionTag*, RE::BSFixedString script_name,
        RE::BSFixedString func, RE::BSFixedString msg);

    /// Registers SkyrimNet_SexLab_WebUI natives on the Papyrus VM.
    bool Register_WebUI_Functions(RE::BSScript::IVirtualMachine* a_vm);

    /// Pushes player + nearby actors into JS before showing the overlay.
    void PopulateNearbyActors();

    /// No crosshair actor: dispatch Papyrus MultiTarget_Menu_Selection picker.
    void Call_MultiTarget_Menu_Selection();

    /// Hotkey path: Papyrus Menu.Open_WebUI_Target(actor) with HasStrippedItems.
    void Call_Open_WebUI_Target(RE::Actor* target);
}
