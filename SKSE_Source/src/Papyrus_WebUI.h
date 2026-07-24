#pragma once

#include "PCH.h"

namespace PapyrusBindings_WebUI {
    extern RE::Actor* Target_Current;
    void Target_Menu_Open(RE::StaticFunctionTag*, RE::Actor* Target_Input);
    void Sex_Menu_Open(RE::StaticFunctionTag*, RE::TESForm* thread, bool has_player);
    bool Register_WebUI_Functions(RE::BSScript::IVirtualMachine* a_vm);
    void PopulateNearbyActors();  // called from WebUI_Visibility_Show
}
