#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"
#include "WebUI_Log.h"
#include "WebUI.h"
#include "Papyrus_WebUI.h"
#include "ActionCatalog.h"
#include <nlohmann/json.hpp>

extern "C" {
uint64_t (*PublicFormIDToUUID)(uint32_t formId) = nullptr;
std::string (*PublicGetActorNameByUUID)(uint64_t uuid) = nullptr;
std::string (*PublicGetActorEngagement)(int maxCount, bool excludePlayer, bool playerEventsOnly,
    double shortWindowSeconds, double mediumWindowSeconds) = nullptr;
}

namespace PapyrusBindings_WebUI
{
    RE::Actor* Target_Current = nullptr;

    /// Escapes backslash and single quote so actor names are safe inside JS string literals.
    static std::string EscapeJsString(std::string_view s)
    {
        std::string out;
        out.reserve(s.size() + 8);
        for (char c : s) {
            if (c == '\\' || c == '\'')
                out.push_back('\\');
            out.push_back(c);
        }
        return out;
    }

    /// Opens the target menu for the given actor and focuses the PrismaUI view.
    /// Reloads the action catalog if needed and pushes configure/setTarget/show JS.
    /// Same target again toggles visibility instead of rebuilding.
    void Target_Menu_Open(RE::StaticFunctionTag*, RE::Actor* Target_Input)
    {
        if (!Target_Input) {
            webui_log::warn("Target_Menu_Open called with null Actor.");
            return;
        }

        if (Target_Current == Target_Input) {
            WebUI_Visibility_Toggle();
            return;
        }

        Reset_To_Default();
        Target_Current = Target_Input;

        if (!ActionCatalog::IsLoaded())
            ActionCatalog::Load();

        uint64_t uuid = (PublicFormIDToUUID) ? PublicFormIDToUUID(Target_Current->GetFormID()) : 0;
        std::string skyrimNetName = (uuid && PublicGetActorNameByUUID) ? PublicGetActorNameByUUID(uuid) : "";
        const char* targetName = !skyrimNetName.empty() ? skyrimNetName.c_str() : Target_Current->GetName();
        const char* name = (targetName && targetName[0]) ? targetName : "Unknown";

        webui_log::info("Target_Menu_Open triggered. Target: {}", name);

        auto catalog = ActionCatalog::BuildUICatalog();
        WebUI_Invoke("configureTargetMenu(" + catalog.dump() + ");");
        WebUI_Invoke(std::format("setTargetActor('{}', '{}');", uuid, EscapeJsString(name)));
        WebUI_Invoke("showPanel('target_menu_panel');");
        WebUI_Visibility_Show();
    }

    /// Resets the overlay and shows the sex_menu_panel for an active sex thread.
    /// thread / has_player are accepted for Papyrus signature parity; panel JS owns layout.
    void Sex_Menu_Open(RE::StaticFunctionTag*, RE::TESForm* thread, bool has_player)
    {
        webui_log::info("Sex_Menu_Open triggered. has_player={}", has_player);
        Reset_To_Default();
        WebUI_Invoke("showPanel('sex_menu_panel');");
        WebUI_Visibility_Show();
    }

    /// Formats [script.func] msg, logs it through SKSE, and returns the same string to Papyrus.
    RE::BSFixedString TraceLog(RE::StaticFunctionTag*, RE::BSFixedString script_name,
        RE::BSFixedString func, RE::BSFixedString msg)
    {
        const char* script = script_name.c_str() ? script_name.c_str() : "";
        const char* fn = func.c_str() ? func.c_str() : "";
        const char* body = msg.c_str() ? msg.c_str() : "";
        std::string formatted = std::format("[{}.{}] {}", script, fn, body);
        SKSE::log::info("{}", formatted);
        return RE::BSFixedString(formatted);
    }

    /// Sends setPlayerActor / setNearbyActors JS from SkyrimNet engagement data.
    /// Called from WebUI_Visibility_Show so the target menu has actor pick lists.
    void PopulateNearbyActors()
    {
        auto* player = RE::PlayerCharacter::GetSingleton();
        if (player && PublicFormIDToUUID) {
            uint64_t playerUUID = PublicFormIDToUUID(player->GetFormID());
            std::string playerName = player->GetName();
            if (playerName.empty())
                playerName = "Player";
            WebUI_Invoke(std::format("setPlayerActor('{}', '{}');", playerUUID, EscapeJsString(playerName)));
        }

        if (PublicGetActorEngagement) {
            try {
                std::string raw = PublicGetActorEngagement(20, true, false, 604800.0, 2592000.0);
                auto arr = nlohmann::json::parse(raw);
                nlohmann::json nearby = nlohmann::json::array();
                for (auto& item : arr) {
                    uint32_t formId = item["formId"].get<uint32_t>();
                    std::string actorName = item["name"].get<std::string>();
                    uint64_t actorUUID = PublicFormIDToUUID ? PublicFormIDToUUID(formId) : 0;
                    nearby.push_back({ { "name", actorName }, { "uuid", std::to_string(actorUUID) } });
                }
                WebUI_Invoke("setNearbyActors(" + nearby.dump() + ");");
            } catch (...) {
                webui_log::warn("PopulateNearbyActors: failed to parse actor engagement JSON");
                WebUI_Invoke("setNearbyActors([]);");
            }
        }
    }

    /// Main-thread Papyrus call into SkyrimNet_SexLab_Menu.MultiTarget_Menu_Selection.
    /// Used when the WebUI hotkey has no crosshair actor to open against.
    void Call_MultiTarget_Menu_Selection()
    {
        auto* player = RE::PlayerCharacter::GetSingleton();
        if (!player) {
            webui_log::warn("Call_MultiTarget_Menu_Selection: no player");
            return;
        }

        webui_log::info("Call_MultiTarget_Menu_Selection: dispatching Papyrus MultiTarget_Menu_Selection");

        SKSE::GetTaskInterface()->AddTask([player]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("Call_MultiTarget_Menu_Selection: no VM");
                return;
            }

            RE::TESQuest* quest = RE::TESForm::LookupByEditorID<RE::TESQuest>("SkyrimNet_SexLab");
            if (!quest) {
                quest = RE::TESDataHandler::GetSingleton()
                    ->LookupForm<RE::TESQuest>(0x800, "SkyrimNet_SexLab.esp");
            }
            if (!quest) {
                webui_log::error("Call_MultiTarget_Menu_Selection: quest SkyrimNet_SexLab not found");
                return;
            }

            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Menu", scriptObject);
            if (!scriptObject) {
                webui_log::error("Call_MultiTarget_Menu_Selection: bound script SkyrimNet_SexLab_Menu not found");
                return;
            }

            auto* args = RE::MakeFunctionArguments(static_cast<RE::Actor*>(player));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString("MultiTarget_Menu_Selection"), args, callback);
            webui_log::info("Call_MultiTarget_Menu_Selection: dispatched");
        });
    }

    /// Looks up the bound SkyrimNet_SexLab_Menu script on the main quest.
    static RE::BSTSmartPointer<RE::BSScript::Object> FindMenuScript(RE::BSScript::Internal::VirtualMachine* vm)
    {
        RE::TESQuest* quest = RE::TESForm::LookupByEditorID<RE::TESQuest>("SkyrimNet_SexLab");
        if (!quest) {
            quest = RE::TESDataHandler::GetSingleton()
                ->LookupForm<RE::TESQuest>(0x800, "SkyrimNet_SexLab.esp");
        }
        if (!quest) {
            webui_log::error("FindMenuScript: quest SkyrimNet_SexLab not found");
            return {};
        }

        auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
            static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
        RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
        vm->FindBoundObject(handle, "SkyrimNet_SexLab_Menu", scriptObject);
        if (!scriptObject) {
            webui_log::error("FindMenuScript: bound script SkyrimNet_SexLab_Menu not found");
            return {};
        }
        return scriptObject;
    }

    /// Main-thread Papyrus call into SkyrimNet_SexLab_Menu.EventSend_LeashedOpen.
    /// Overlay is already hidden by C++ handoff; Papyrus Hide is a no-op if already hidden.
    void Call_EventSend_LeashedOpen()
    {
        webui_log::info("Call_EventSend_LeashedOpen: dispatching Papyrus EventSend_LeashedOpen");

        SKSE::GetTaskInterface()->AddTask([]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("Call_EventSend_LeashedOpen: no VM");
                return;
            }

            auto scriptObject = FindMenuScript(vm);
            if (!scriptObject) {
                return;
            }

            auto* args = RE::MakeFunctionArguments();
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString("EventSend_LeashedOpen"), args, callback);
            webui_log::info("Call_EventSend_LeashedOpen: dispatched");
        });
    }

    /// Papyrus native: hide panels and overlay, clear Target_Current.
    void Hide(RE::StaticFunctionTag*)
    {
        Reset_To_Default();
    }

    /// Binds Target_Menu_Open, Sex_Menu_Open, TraceLog, and Hide on SkyrimNet_SexLab_WebUI.
    bool Register_WebUI_Functions(RE::BSScript::IVirtualMachine* a_vm)
    {
        if (!a_vm) {
            webui_log::error("Couldn't get Papyrus Virtual Machine.");
            return false;
        }

        constexpr std::string_view scriptName = "SkyrimNet_SexLab_WebUI";

        a_vm->RegisterFunction("Target_Menu_Open", scriptName, Target_Menu_Open);
        a_vm->RegisterFunction("Sex_Menu_Open", scriptName, Sex_Menu_Open);
        a_vm->RegisterFunction("TraceLog", scriptName, TraceLog);
        a_vm->RegisterFunction("Hide", scriptName, Hide);

        webui_log::info("Successfully registered Papyrus functions for {}", scriptName);
        return true;
    }
}
