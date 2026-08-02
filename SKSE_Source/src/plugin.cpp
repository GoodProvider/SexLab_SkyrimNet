#include <Windows.h>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/spdlog.h>

#include "PCH.h"
#include "WebUI.h"
#include "Papyrus_WebUI.h"
#include "Papyrus_Utilities.h"
#include "Papyrus_API.h"
#include "Papyrus_AnimationDB.h"
#include "AnimationDB.h"
#include "TargetMenuRegistry.h"
#include "WebUI_Log.h"

using namespace SKSE;

namespace {

SKSEPluginLoad(const SKSE::LoadInterface *skse) {
    SKSE::Init(skse);

    SKSE::GetMessagingInterface()->RegisterListener([](SKSE::MessagingInterface::Message *message) {
        if (message->type == SKSE::MessagingInterface::kDataLoaded) {
            RE::ConsoleLog::GetSingleton()->Print("SkyrimNet_SexLab: SKSE listening!");
            AnimationDB::Open();
            InitWebUI();
        } else if (message->type == SKSE::MessagingInterface::kPostLoadGame ||
                   message->type == SKSE::MessagingInterface::kNewGame) {
            TargetMenuRegistry::Clear();
            WebUI_SetGameReady();
        }
    });

    webui_log::info("SkyrimNet_SexLab: Trying to load WebUI plugin...");
    if (auto papyrus = SKSE::GetPapyrusInterface()) {
        if (!papyrus->Register(PapyrusBindings_WebUI::Register_WebUI_Functions)) {
            webui_log::error("Failed to register WebUI Papyrus functions");
        } else {
            webui_log::info("WebUI Papyrus functions registered");
        }
        if (!papyrus->Register(PapyrusBindings_Utilities::Register_Utilities_Functions)) {
            webui_log::error("Failed to register Utilities Papyrus functions");
        } else {
            webui_log::info("Utilities Papyrus functions registered");
        }
        if (!papyrus->Register(PapyrusBindings_API::Register_API_Functions)) {
            webui_log::error("Failed to register API Papyrus functions");
        } else {
            webui_log::info("API Papyrus functions registered");
        }
        if (!papyrus->Register(PapyrusBindings_AnimationDB::Register_AnimationDB_Functions)) {
            webui_log::error("Failed to register AnimationDB Papyrus functions");
        } else {
            webui_log::info("AnimationDB Papyrus functions registered");
        }
    } else {
        webui_log::info("Failed to get Papyrus interface.");
    }

    return true;
}

}
