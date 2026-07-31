#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"
#include "WebUI_Log.h"
#include "WebUI.h"
#include "PublicAPI.h"
#include "ActionCatalog.h"
#include <nlohmann/json.hpp>

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

    static RE::TESQuest* FindMainQuest()
    {
        RE::TESQuest* quest = RE::TESForm::LookupByEditorID<RE::TESQuest>("SkyrimNet_SexLab");
        if (!quest) {
            quest = RE::TESDataHandler::GetSingleton()
                ->LookupForm<RE::TESQuest>(0x800, "SkyrimNet_SexLab.esp");
        }
        return quest;
    }

    /// Opens the target menu for the given actor and focuses the PrismaUI view.
    /// Same target again toggles visibility instead of rebuilding.
    void Target_Menu_Open(RE::StaticFunctionTag*, RE::Actor* Target_Input, bool hasStrippedItems)
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

        webui_log::info(
            "Target_Menu_Open triggered. Target: {} hasStrippedItems={}",
            name,
            hasStrippedItems);

        auto catalog = ActionCatalog::BuildUICatalog(hasStrippedItems);
        WebUI_Invoke("configureTargetMenu(" + catalog.dump() + ");");
        WebUI_Invoke(std::format("setTargetActor('{}', '{}');", uuid, EscapeJsString(name)));

        bool ostimnet = RE::TESDataHandler::GetSingleton()->LookupModByName("TT_OStimNet.esp") != nullptr;
        const char* fw = "sexlab";
        if (auto* g = RE::TESForm::LookupByEditorID<RE::TESGlobal>("skyrimnet_sexlab_ostim_player")) {
            if (g->value == 1.0f)
                fw = "ostim";
        }
        WebUI_Invoke(std::format("setFrameworkToggle({}, '{}');", ostimnet ? "true" : "false", fw));

        WebUI_Invoke("showPanel('target_menu_panel');");
        WebUI_Visibility_Show();
    }

    /// Re-resolve actionSwitch while the target menu stays open on Target_Current.
    void Target_Menu_Refresh(RE::StaticFunctionTag*, bool hasStrippedItems)
    {
        if (!Target_Current) {
            // LLM / non-WebUI Outfit_* calls refresh harmlessly when menu is closed.
            return;
        }
        if (!ActionCatalog::IsLoaded())
            ActionCatalog::Load();

        webui_log::info("Target_Menu_Refresh hasStrippedItems={}", hasStrippedItems);
        auto catalog = ActionCatalog::BuildUICatalog(hasStrippedItems);
        WebUI_Invoke("configureTargetMenu(" + catalog.dump() + ");");
    }

    /// Resets the overlay and shows the sex_menu_panel for an active sex thread.
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

            RE::TESQuest* quest = FindMainQuest();
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

    /// Hotkey: Menu.Open_WebUI_Target so Papyrus can pass HasStrippedItems.
    void Call_Open_WebUI_Target(RE::Actor* target)
    {
        if (!target) {
            webui_log::warn("Call_Open_WebUI_Target: null target");
            return;
        }

        SKSE::GetTaskInterface()->AddTask([target]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("Call_Open_WebUI_Target: no VM");
                return;
            }

            RE::TESQuest* quest = FindMainQuest();
            if (!quest) {
                webui_log::error("Call_Open_WebUI_Target: quest not found");
                return;
            }

            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Menu", scriptObject);
            if (!scriptObject) {
                webui_log::error("Call_Open_WebUI_Target: Menu script not bound");
                return;
            }

            auto* args = RE::MakeFunctionArguments(static_cast<RE::Actor*>(target));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString("Open_WebUI_Target"), args, callback);
            webui_log::info("Call_Open_WebUI_Target: dispatched");
        });
    }

    bool Register_WebUI_Functions(RE::BSScript::IVirtualMachine* a_vm)
    {
        if (!a_vm) {
            webui_log::error("Couldn't get Papyrus Virtual Machine.");
            return false;
        }

        constexpr std::string_view scriptName = "SkyrimNet_SexLab_WebUI";

        a_vm->RegisterFunction("Target_Menu_Open", scriptName, Target_Menu_Open);
        a_vm->RegisterFunction("Target_Menu_Refresh", scriptName, Target_Menu_Refresh);
        a_vm->RegisterFunction("Sex_Menu_Open", scriptName, Sex_Menu_Open);
        a_vm->RegisterFunction("TraceLog", scriptName, TraceLog);

        webui_log::info("Successfully registered Papyrus functions for {}", scriptName);
        return true;
    }
}
