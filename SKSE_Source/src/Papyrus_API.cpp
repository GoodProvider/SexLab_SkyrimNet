#include "Papyrus_API.h"
#include "TargetMenuRegistry.h"
#include "WebUI_Log.h"

namespace PapyrusBindings_API
{
    void RegisterTargetMenuOption(
        RE::StaticFunctionTag*,
        RE::BSFixedString questEditorId,
        RE::BSFixedString scriptName,
        RE::BSFixedString executionFunctionName,
        RE::BSFixedString label)
    {
        TargetMenuRegistry::Register(
            questEditorId.c_str() ? questEditorId.c_str() : "",
            scriptName.c_str() ? scriptName.c_str() : "",
            executionFunctionName.c_str() ? executionFunctionName.c_str() : "",
            label.c_str() ? label.c_str() : "");
    }

    bool Register_API_Functions(RE::BSScript::IVirtualMachine* a_vm)
    {
        if (!a_vm) {
            webui_log::error("Couldn't get Papyrus Virtual Machine.");
            return false;
        }

        constexpr std::string_view scriptName = "SkyrimNet_SexLab_API";

        a_vm->RegisterFunction("RegisterTargetMenuOption", scriptName, RegisterTargetMenuOption);

        webui_log::info("Successfully registered Papyrus functions for {}", scriptName);
        return true;
    }
}
