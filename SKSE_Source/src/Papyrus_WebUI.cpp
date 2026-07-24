#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"
#include "WebUI_Log.h"
#include "WebUI.h"
#include "PublicAPI.h"
#include <nlohmann/json.hpp>

namespace PapyrusBindings_WebUI
{
    RE::Actor* Target_Current = nullptr;

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

        uint64_t uuid = (PublicFormIDToUUID) ? PublicFormIDToUUID(Target_Current->GetFormID()) : 0;
        std::string skyrimNetName = (uuid && PublicGetActorNameByUUID) ? PublicGetActorNameByUUID(uuid) : "";
        const char* targetName = !skyrimNetName.empty() ? skyrimNetName.c_str() : Target_Current->GetName();
        const char* name = (targetName && targetName[0]) ? targetName : "Unknown";

        webui_log::info("Target_Menu_Open triggered. Target: {}", name);

        WebUI_Invoke(std::format("setTargetActor('{}', '{}');", uuid, name));
        WebUI_Invoke("showPanel('target_menu_panel');");
        WebUI_Visibility_Show();
    }

    void Sex_Menu_Open(RE::StaticFunctionTag*, RE::TESForm* thread, bool has_player)
    {
        webui_log::info("Sex_Menu_Open triggered. has_player={}", has_player);
        Reset_To_Default();
        WebUI_Invoke("showPanel('sex_menu_panel');");
        WebUI_Visibility_Show();
    }

    void PopulateNearbyActors()
    {
        // Set player actor
        auto* player = RE::PlayerCharacter::GetSingleton();
        if (player && PublicFormIDToUUID) {
            uint64_t playerUUID     = PublicFormIDToUUID(player->GetFormID());
            std::string playerName  = player->GetName();
            if (playerName.empty()) playerName = "Player";
            WebUI_Invoke(std::format("setPlayerActor('{}', '{}');", playerUUID, playerName));
        }

        // Populate nearby actors from SkyrimNet engagement data
        if (PublicGetActorEngagement) {
            try {
                std::string raw = PublicGetActorEngagement(20, true, false, 604800.0, 2592000.0);
                auto arr = nlohmann::json::parse(raw);
                nlohmann::json nearby = nlohmann::json::array();
                for (auto& item : arr) {
                    uint32_t formId       = item["formId"].get<uint32_t>();
                    std::string actorName = item["name"].get<std::string>();
                    uint64_t actorUUID    = PublicFormIDToUUID ? PublicFormIDToUUID(formId) : 0;
                    nearby.push_back({ {"name", actorName}, {"uuid", std::to_string(actorUUID)} });
                }
                WebUI_Invoke("setNearbyActors(" + nearby.dump() + ");");
            } catch (...) {
                webui_log::warn("PopulateNearbyActors: failed to parse actor engagement JSON");
                WebUI_Invoke("setNearbyActors([]);");
            }
        }
    }

    bool Register_WebUI_Functions(RE::BSScript::IVirtualMachine* a_vm)
    {
        if (!a_vm) {
            webui_log::error("Couldn't get Papyrus Virtual Machine.");
            return false;
        }

        constexpr std::string_view scriptName = "SkyrimNet_SexLab_WebUI";

        a_vm->RegisterFunction("Target_Menu_Open", scriptName, Target_Menu_Open);
        a_vm->RegisterFunction("Sex_Menu_Open", scriptName, Sex_Menu_Open);

        webui_log::info("Successfully registered Papyrus functions for {}", scriptName);
        return true;
    }
}
