#pragma once

#include "PCH.h"

namespace PapyrusBindings_API
{
    /// Papyrus native: register an external Target Menu action for this game run.
    void RegisterTargetMenuOption(
        RE::StaticFunctionTag*,
        RE::TESForm* quest,
        RE::BSFixedString scriptName,
        RE::BSFixedString executionFunctionName,
        RE::BSFixedString label);

    /// Registers SkyrimNet_SexLab_API natives on the Papyrus VM.
    bool Register_API_Functions(RE::BSScript::IVirtualMachine* a_vm);
}
