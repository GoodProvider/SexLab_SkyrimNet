#include <Windows.h>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/spdlog.h>

#include "PCH.h"
#include "WebUI.h"
#include "Papyrus_WebUI.h"
#include "Papyrus_Utilities.h"
#include "WebUI_Log.h"

using namespace SKSE;

namespace {

/// SKSE entry: init the plugin, register Papyrus natives, and wire messaging.
/// On kDataLoaded creates the PrismaUI WebUI; on load/new game enables input.
/// Returns true so SKSE keeps the DLL loaded.
SKSEPluginLoad(const SKSE::LoadInterface *skse) {
    SKSE::Init(skse);

    SKSE::GetMessagingInterface()->RegisterListener([](SKSE::MessagingInterface::Message *message) {
        if (message->type == SKSE::MessagingInterface::kDataLoaded) {
            RE::ConsoleLog::GetSingleton()->Print("SkyrimNet_SexLab: SKSE listening!");
            InitWebUI();
        } else if (message->type == SKSE::MessagingInterface::kPostLoadGame ||
                   message->type == SKSE::MessagingInterface::kNewGame) {
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
    } else {
        webui_log::info("Failed to get Papyrus interface.");
    }

    return true;
}

}
