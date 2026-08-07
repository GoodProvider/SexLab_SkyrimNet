#include "WebUI.h"
#include "Papyrus_WebUI.h"
#include "WebUI_Log.h"
#include "ActionCatalog.h"
#include "ActionDispatch.h"
#include "Config.h"
#include "RE/Skyrim.h"

#include <Windows.h>
#include <deque>
#include <filesystem>
#include <fstream>
#include <mutex>
#include <sstream>
#include <string>
#include <string_view>
#include <vector>
#include <nlohmann/json.hpp>

static PRISMA_UI_API::IVPrismaUI1* PrismaUI = nullptr;
static PrismaView g_view = 0;
static std::atomic<bool> g_gameReady{false};
static std::atomic<bool> g_domReady{false};
static std::atomic<bool> g_webuiGamePaused{true};
static std::mutex g_invokeMutex;
static std::deque<std::string> g_pendingInvokes;
static std::atomic<uint32_t> g_menuHotkey{0};
static std::mutex g_rebuildTsMutex;
static std::string g_lastRebuildTimestamp;
static std::mutex g_logFileMutex;
static std::uintmax_t g_logFileOffset = 0;

namespace {

class EmptyArgs : public RE::BSScript::IFunctionArguments
{
public:
    bool operator()(RE::BSScrapArray<RE::BSScript::Variable>& a_dst) const override
    {
        a_dst.resize(0);
        return true;
    }
};

std::string ReadPluginVersionFromInfoJson()
{
    try {
        std::ifstream f("Data/SKSE/Plugins/SkyrimNet_SexLab/info.json");
        if (!f)
            return SexLabNet::Config::kPluginVersion;
        auto j = nlohmann::json::parse(f, nullptr, false);
        if (j.is_discarded())
            return SexLabNet::Config::kPluginVersion;
        if (j.contains("version") && j["version"].is_string())
            return j["version"].get<std::string>();
    } catch (...) {
    }
    return SexLabNet::Config::kPluginVersion;
}

std::filesystem::path ResolvePluginLogPath()
{
    if (auto dir = SKSE::log::log_directory())
        return *dir / "SkyrimNet_SexLab.log";
    return {};
}

std::vector<std::string> SplitLogLines(std::string_view text)
{
    std::vector<std::string> lines;
    std::size_t start = 0;
    while (start < text.size()) {
        auto end = text.find('\n', start);
        if (end == std::string_view::npos) {
            lines.emplace_back(text.substr(start));
            break;
        }
        auto line = text.substr(start, end - start);
        if (!line.empty() && line.back() == '\r')
            line.remove_suffix(1);
        lines.emplace_back(line);
        start = end + 1;
    }
    return lines;
}

void PushLogChunk(bool reset, const std::vector<std::string>& lines, const std::string& pathHint)
{
    nlohmann::json j;
    j["reset"] = reset;
    j["lines"] = lines;
    j["path"] = pathHint;
    WebUI_Invoke("appendLogLines(" + j.dump() + ");");
}

/// Caller must hold g_logFileMutex.
void ReadLogTailUnlocked(bool resetFromStart)
{
    if (resetFromStart)
        g_logFileOffset = 0;
    const auto path = ResolvePluginLogPath();
    if (path.empty() || !std::filesystem::exists(path)) {
        PushLogChunk(true, {}, path.empty() ? std::string{} : path.string());
        return;
    }
    std::ifstream f(path, std::ios::binary);
    if (!f) {
        PushLogChunk(true, {}, path.string());
        return;
    }
    f.seekg(0, std::ios::end);
    const auto size = static_cast<std::uintmax_t>(f.tellg());
    constexpr std::uintmax_t kTailBytes = 128 * 1024;
    std::uintmax_t start = 0;
    if (size > kTailBytes)
        start = size - kTailBytes;
    f.seekg(static_cast<std::streamoff>(start));
    std::string buf((std::istreambuf_iterator<char>(f)), std::istreambuf_iterator<char>());
    g_logFileOffset = size;
    auto lines = SplitLogLines(buf);
    if (start > 0 && !lines.empty())
        lines.erase(lines.begin());
    PushLogChunk(true, lines, path.string());
}

void DispatchMenuNoArg(const char* functionName)
{
    SKSE::GetTaskInterface()->AddTask([functionName]() {
        auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
        if (!vm) {
            webui_log::error("DispatchMenuNoArg: no VM");
            return;
        }
        RE::TESQuest* quest = RE::TESForm::LookupByEditorID<RE::TESQuest>("SkyrimNet_SexLab");
        if (!quest)
            quest = RE::TESDataHandler::GetSingleton()->LookupForm<RE::TESQuest>(0x800, "SkyrimNet_SexLab.esp");
        if (!quest) {
            webui_log::error("DispatchMenuNoArg: quest not found");
            return;
        }
        auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
            static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
        RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
        vm->FindBoundObject(handle, "SkyrimNet_SexLab_Menu", scriptObject);
        if (!scriptObject) {
            webui_log::error("DispatchMenuNoArg: Menu script not bound");
            return;
        }
        auto* raw = new EmptyArgs();
        RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
        vm->DispatchMethodCall(scriptObject, RE::BSFixedString(functionName), raw, callback);
        webui_log::info("DispatchMenuNoArg: {}", functionName);
    });
}

void Call_RebuildAnimDb()
{
    SKSE::GetTaskInterface()->AddTask([]() {
        auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
        if (!vm) {
            webui_log::error("Call_RebuildAnimDb: no VM");
            return;
        }
        RE::TESQuest* quest = RE::TESForm::LookupByEditorID<RE::TESQuest>("SkyrimNet_SexLab");
        if (!quest)
            quest = RE::TESDataHandler::GetSingleton()->LookupForm<RE::TESQuest>(0x800, "SkyrimNet_SexLab.esp");
        if (!quest) {
            webui_log::error("Call_RebuildAnimDb: quest not found");
            return;
        }
        auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
            static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
        RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
        vm->FindBoundObject(handle, "SkyrimNet_SexLab_AnimDb", scriptObject);
        if (!scriptObject) {
            webui_log::error("Call_RebuildAnimDb: AnimDb script not bound");
            return;
        }
        auto* raw = new EmptyArgs();
        RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
        vm->DispatchMethodCall(scriptObject, RE::BSFixedString("RebuildDatabase"), raw, callback);
        webui_log::info("Call_RebuildAnimDb: dispatched");
    });
}

void Call_OpenSkyrimNetDashboard()
{
    ActionCatalog::ClearMainPanelSelection();
    WebUI_Invoke("hidePanel('target_menu_panel');");
    WebUI_Invoke("hidePanel('sex_menu_panel');");
    WebUI_Invoke("hidePanel('yesno_panel');");
    PapyrusBindings_WebUI::ClearTargetMenuSession();
    WebUI_Visibility_Hide();
    DispatchMenuNoArg("OpenSkyrimNetDashboard");
}

}  // namespace

namespace SexLabNet {

void SetLastRebuildTimestamp(std::string ts)
{
    std::lock_guard lock(g_rebuildTsMutex);
    g_lastRebuildTimestamp = std::move(ts);
}

std::string GetLastRebuildTimestamp()
{
    std::lock_guard lock(g_rebuildTsMutex);
    return g_lastRebuildTimestamp;
}

void InvokeConfigureSettingsPanel()
{
    nlohmann::json j;
    j["version"] = ReadPluginVersionFromInfoJson();
    j["docsUrl"] = Config::kDocsUrl;
    {
        std::lock_guard lock(g_rebuildTsMutex);
        j["lastRebuild"] = g_lastRebuildTimestamp.empty() ? "never" : g_lastRebuildTimestamp;
    }
    WebUI_Invoke("configureSettingsPanel(" + j.dump() + ");");
}

void InvokeLogPanelOpen()
{
    std::lock_guard lock(g_logFileMutex);
    ReadLogTailUnlocked(true);
}

void PushLogPanelPoll()
{
    std::lock_guard lock(g_logFileMutex);
    const auto path = ResolvePluginLogPath();
    if (path.empty() || !std::filesystem::exists(path))
        return;
    std::error_code ec;
    const auto size = std::filesystem::file_size(path, ec);
    if (ec)
        return;
    if (size < g_logFileOffset) {
        ReadLogTailUnlocked(true);
        return;
    }
    if (size == g_logFileOffset)
        return;
    std::ifstream f(path, std::ios::binary);
    if (!f)
        return;
    f.seekg(static_cast<std::streamoff>(g_logFileOffset));
    std::string buf((std::istreambuf_iterator<char>(f)), std::istreambuf_iterator<char>());
    g_logFileOffset = size;
    auto lines = SplitLogLines(buf);
    if (lines.empty())
        return;
    if (!buf.empty() && buf.back() != '\n') {
        const auto& last = lines.back();
        g_logFileOffset -= last.size();
        lines.pop_back();
    }
    if (!lines.empty())
        PushLogChunk(false, lines, path.string());
}

}  // namespace SexLabNet

/// Returns the process-wide KeyHandler singleton used for WebUI hotkeys.
KeyHandler* KeyHandler::GetSingleton()
{
    static KeyHandler singleton;
    return &singleton;
}

/// Registers this KeyHandler as a BSInputDeviceManager event sink.
/// Required before Escape / backslash (and other) hotkeys can fire.
void KeyHandler::RegisterSink()
{
    auto inputMgr = RE::BSInputDeviceManager::GetSingleton();
    if (inputMgr) {
        inputMgr->AddEventSink(GetSingleton());
        webui_log::info("KeyHandler sink registered.");
    } else {
        webui_log::critical("Failed to get InputDeviceManager.");
    }
}

/// Binds a DX scancode to a callback for WebUI keyboard shortcuts.
/// Replaces any previous callback for the same key.
void KeyHandler::Register(uint32_t dxScanCode, KeyCallback callback)
{
    std::unique_lock lock(_mutex);
    _callbacks[dxScanCode] = std::move(callback);
}

/// Removes any callback bound to dxScanCode.
void KeyHandler::Unregister(uint32_t dxScanCode)
{
    std::unique_lock lock(_mutex);
    _callbacks.erase(dxScanCode);
}

/// Input sink: on keyboard key-down, runs any registered WebUI hotkey callbacks.
/// Callbacks run outside the shared lock so they may mutate handler state safely.
RE::BSEventNotifyControl KeyHandler::ProcessEvent(RE::InputEvent* const* a_eventList,
                                                   [[maybe_unused]] RE::BSTEventSource<RE::InputEvent*>* a_eventSource)
{
    if (!a_eventList)
        return RE::BSEventNotifyControl::kContinue;

    std::vector<KeyCallback> toRun;

    {
        std::shared_lock lock(_mutex);
        for (auto event = *a_eventList; event; event = event->next) {
            if (event->eventType != RE::INPUT_EVENT_TYPE::kButton)
                continue;
            const auto btn = event->AsButtonEvent();
            if (!btn || btn->GetDevice() != RE::INPUT_DEVICE::kKeyboard || !btn->IsDown())
                continue;
            auto it = _callbacks.find(btn->GetIDCode());
            if (it != _callbacks.end())
                toRun.push_back(it->second);
        }
    }

    for (const auto& cb : toRun)
        cb();

    return RE::BSEventNotifyControl::kContinue;
}

/// Marks that a save is loaded so Show / hotkeys are allowed to open the WebUI.
/// Reloads ActionCatalog so actions_index / menu/target / main_panels pick up file changes.
void WebUI_SetGameReady()
{
    g_gameReady = true;
    if (!ActionCatalog::Load()) {
        webui_log::error("Game ready — ActionCatalog reload failed.");
    } else {
        webui_log::info("Game ready — WebUI input enabled; ActionCatalog reloaded.");
        auto panels = ActionCatalog::BuildMainPanelsCatalog();
        WebUI_Invoke("configureControlPanel(" + panels.dump() + ");");
    }
}

/// Shows and focuses the PrismaUI overlay after refreshing nearby actors for the menu.
/// No-ops if PrismaUI is missing, no game is loaded, or the view path is invalid.
void WebUI_Visibility_Show()
{
    if (!PrismaUI) return;
    if (!g_gameReady) {
        webui_log::info("WebUI blocked — no game loaded.");
        return;
    }
    if (!PrismaUI->IsValid(g_view)) {
        webui_log::critical("WebUI_Visibility_Show: view invalid (missing PrismaUI/views/SkyrimNet_SexLab/index.html?).");
        return;
    }

    PapyrusBindings_WebUI::PopulateNearbyActors();

    webui_log::info("WebUI Show + Focus.");
    PrismaUI->Show(g_view);
    PrismaUI->Focus(g_view, true);
    g_webuiGamePaused = true;
    WebUI_Invoke("setControlPaused(true);");
}

/// Unfocuses and hides the PrismaUI overlay without clearing Target_Current.
void WebUI_Visibility_Hide()
{
    if (!PrismaUI) return;
    PrismaUI->Unfocus(g_view);
    PrismaUI->Hide(g_view);
    g_webuiGamePaused = true;
}

/// Shows the overlay if hidden, otherwise hides it.
void WebUI_Visibility_Toggle()
{
    webui_log::info("WebUI visibility toggled.");
    if (!PrismaUI) return;

    if (PrismaUI->IsHidden(g_view)) {
        WebUI_Visibility_Show();
    } else {
        WebUI_Visibility_Hide();
    }
}

/// Runs a JS snippet on the WebUI view, or queues it until DomReady.
/// Early invokes before the HTML loads are flushed by FlushPendingInvokes.
void WebUI_Invoke(const std::string& script)
{
    if (!PrismaUI) return;

    // Queue until DomReady — CreateView callbacks may not have run yet.
    if (!g_domReady.load()) {
        std::scoped_lock lock(g_invokeMutex);
        g_pendingInvokes.push_back(script);
        return;
    }

    PrismaUI->Invoke(g_view, script.c_str());
}

/// Drains the DomReady queue and Invokes each pending script on the live view.
static void FlushPendingInvokes()
{
    std::deque<std::string> pending;
    {
        std::scoped_lock lock(g_invokeMutex);
        pending.swap(g_pendingInvokes);
    }
    if (!PrismaUI) return;
    for (const auto& script : pending) {
        PrismaUI->Invoke(g_view, script.c_str());
    }
    if (!pending.empty()) {
        webui_log::info("Flushed {} queued WebUI Invoke(s) after DomReady.", pending.size());
    }
}

/// Hides all menu panels in JS and closes the overlay.
void WebUI_Reset()
{
    ActionCatalog::ClearMainPanelSelection();
    WebUI_Invoke("hidePanel('control_panel');");
    WebUI_Invoke("hidePanel('target_menu_panel');");
    WebUI_Invoke("hidePanel('sex_menu_panel');");
    WebUI_Invoke("hidePanel('yesno_panel');");
    WebUI_Invoke("hidePanel('scene_creator_panel');");
    WebUI_Invoke("hidePanel('animation_menu_panel');");
    WebUI_Visibility_Hide();
}

/// Clears the current target actor and resets panels / visibility to a closed UI.
void Reset_To_Default()
{
    PapyrusBindings_WebUI::ClearTargetMenuSession();
    WebUI_Reset();
}

/// One-shot WebUI bootstrap: PrismaUI API, action catalog, view, JS listeners, hotkeys.
/// View path must exist under Data/PrismaUI/views/SkyrimNet_SexLab/index.html.
/// Escape hides UI; backslash opens target menu (crosshair) or multi-target picker.
void InitWebUI()
{
    static std::once_flag s_initFlag;
    std::call_once(s_initFlag, []() {

        PrismaUI = static_cast<PRISMA_UI_API::IVPrismaUI1*>(
            PRISMA_UI_API::RequestPluginAPI(PRISMA_UI_API::InterfaceVersion::V1));

        if (!PrismaUI) {
            webui_log::critical("Failed to acquire PrismaUI API.");
            return;
        }
        webui_log::info("PrismaUI API acquired successfully.");

        ActionCatalog::Load();

        g_domReady = false;
        // Resolves under Data/PrismaUI/views/, not SKSE/Plugins/.
        g_view = PrismaUI->CreateView("SkyrimNet_SexLab/index.html", [](PrismaView view) {
            g_view = view;
            g_domReady = true;
            webui_log::info("WebUI DomReady.");
            FlushPendingInvokes();
            if (ActionCatalog::IsLoaded()) {
                auto panels = ActionCatalog::BuildMainPanelsCatalog();
                WebUI_Invoke("configureControlPanel(" + panels.dump() + ");");
            }
        });

        if (!PrismaUI->IsValid(g_view)) {
            webui_log::critical(
                "CreateView returned invalid view — ensure Data/PrismaUI/views/SkyrimNet_SexLab/index.html exists.");
        }

        PrismaUI->Hide(g_view);

        PrismaUI->RegisterJSListener(g_view, "onCancel", [](const char*) {
            WebUI_Invoke("hidePanel('target_menu_panel');");
            PapyrusBindings_WebUI::ClearTargetMenuSession();
            // Keep other panels if any; hide overlay when nothing else needs focus.
            WebUI_Visibility_Hide();
        });

        PrismaUI->RegisterJSListener(g_view, "onYesNoResult", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const int button = j.value("button", 2);
                const int creator_sid = j.value("creator_sid", PapyrusBindings_WebUI::YesNo_Creator_Sid);
                webui_log::info("onYesNoResult button={} creator_sid={}", button, creator_sid);
                WebUI_Invoke("hidePanel('yesno_panel');");
                // Yes (0) opens SceneCreator next — keep overlay focused. Random/No hide unless TargetMenu stays.
                if (button != 0 && !PapyrusBindings_WebUI::TargetMenuSessionActive)
                    WebUI_Visibility_Hide();
                PapyrusBindings_WebUI::DispatchManagerMethodIntInt("WebUI_OnYesNoResult", creator_sid, button);
            } catch (...) {
                webui_log::warn("onYesNoResult: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onSceneCreatorResult", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const std::string action = j.value("_action", "cancel");
                const int creator_sid = j.value("_creator_sid", -1);
                // creator_sid 0 is a valid pool slot — only _from_target_menu marks the C++ provisional path.
                const bool fromTargetMenu = j.value("_from_target_menu", false);
                webui_log::info("onSceneCreatorResult action={} creator_sid={} fromTargetMenu={}", action,
                    creator_sid, fromTargetMenu);
                WebUI_Invoke("hidePanel('scene_creator_panel');");
                PapyrusBindings_WebUI::ClearSceneCreatorPending();
                if (!PapyrusBindings_WebUI::TargetMenuSessionActive)
                    WebUI_Visibility_Hide();
                if (action == "start" && fromTargetMenu) {
                    j["_from_target_menu"] = true;
                    PapyrusBindings_WebUI::DispatchManagerMethodStrOnly("WebUI_OnSceneCreatorHandoff", j.dump());
                } else if (action == "start") {
                    PapyrusBindings_WebUI::DispatchManagerMethodIntStr("WebUI_OnSceneCreatorResult", creator_sid,
                        j.dump());
                } else if (fromTargetMenu) {
                    webui_log::info("onSceneCreatorResult: target-menu cancel");
                } else {
                    PapyrusBindings_WebUI::DispatchManagerMethodIntStr("WebUI_OnSceneCreatorResult", creator_sid,
                        "{\"_action\":\"cancel\"}");
                }
            } catch (...) {
                webui_log::warn("onSceneCreatorResult: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onSceneCreatorLoad", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const int creator_sid = j.value("_creator_sid", -1);
                const std::string name = j.value("_scene_preset", "");
                webui_log::info("onSceneCreatorLoad creator_sid={} preset={}", creator_sid, name);
                PapyrusBindings_WebUI::DispatchManagerMethodIntStr("WebUI_OnSceneCreatorLoad", creator_sid, name);
            } catch (...) {
                webui_log::warn("onSceneCreatorLoad: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onSceneCreatorSave", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const int creator_sid = j.value("_creator_sid", -1);
                webui_log::info("onSceneCreatorSave creator_sid={}", creator_sid);
                PapyrusBindings_WebUI::DispatchManagerMethodIntStr("WebUI_OnSceneCreatorSave", creator_sid, j.dump());
            } catch (...) {
                webui_log::warn("onSceneCreatorSave: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onAnimationMenuClose", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const int scene_sid = j.value("_scene_sid", -1);
                webui_log::info("onAnimationMenuClose scene_sid={}", scene_sid);
                WebUI_Invoke("hidePanel('animation_menu_panel');");
                WebUI_Visibility_Hide();
                PapyrusBindings_WebUI::DispatchManagerMethodIntStr("WebUI_OnAnimationMenuClose", scene_sid, j.dump());
            } catch (...) {
                webui_log::warn("onAnimationMenuClose: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onAnimationMenuLiveUpdate", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const int scene_sid = j.value("_scene_sid", -1);
                PapyrusBindings_WebUI::DispatchManagerMethodIntStr("WebUI_OnAnimationMenuLiveUpdate", scene_sid, j.dump());
            } catch (...) {
                webui_log::warn("onAnimationMenuLiveUpdate: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onAnimationMenuPrevNext", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const int scene_sid = j.value("_scene_sid", -1);
                const int direction = j.value("_direction", 0);
                webui_log::info("onAnimationMenuPrevNext scene_sid={} direction={}", scene_sid, direction);
                PapyrusBindings_WebUI::DispatchManagerMethodIntInt("WebUI_OnAnimationMenuPrevNext", scene_sid,
                    direction);
            } catch (...) {
                webui_log::warn("onAnimationMenuPrevNext: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onAnimationMenuStop", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const int scene_sid = j.value("_scene_sid", -1);
                webui_log::info("onAnimationMenuStop scene_sid={}", scene_sid);
                WebUI_Invoke("hidePanel('animation_menu_panel');");
                WebUI_Visibility_Hide();
                PapyrusBindings_WebUI::DispatchManagerMethodIntInt("WebUI_OnAnimationMenuStop", scene_sid, 0);
            } catch (...) {
                webui_log::warn("onAnimationMenuStop: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onSceneConnectionChange", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                webui_log::info("onSceneConnectionChange {}", j.dump());
                PapyrusBindings_WebUI::DispatchManagerMethodStrOnly("WebUI_OnSceneConnectionChange", j.dump());
            } catch (...) {
                webui_log::warn("onSceneConnectionChange: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onSceneConnectionsRefresh", [](const char* value) {
            PapyrusBindings_WebUI::DispatchManagerMethodStrOnly("WebUI_OnSceneConnectionsRefresh",
                value ? value : "{}");
        });

        PrismaUI->RegisterJSListener(g_view, "onSceneAnimUpdate", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const int scene_sid = j.value("_scene_sid", -1);
                webui_log::info("onSceneAnimUpdate scene_sid={}", scene_sid);
                PapyrusBindings_WebUI::DispatchManagerMethodIntStr("WebUI_OnSceneAnimUpdate", scene_sid, j.dump());
            } catch (...) {
                webui_log::warn("onSceneAnimUpdate: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onAnimRegistrySave", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                webui_log::info("onAnimRegistrySave registry={}", j.value("_registry", ""));
                PapyrusBindings_WebUI::DispatchManagerMethodStrOnly("WebUI_OnAnimRegistrySave", j.dump());
            } catch (...) {
                webui_log::warn("onAnimRegistrySave: bad JSON");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onAnimDbQuery", [](const char* value) {
            PapyrusBindings_WebUI::HandleAnimDbQuery(value);
        });

        PrismaUI->RegisterJSListener(g_view, "onNearbyRangeChange", [](const char* value) {
            if (!value)
                return;
            float range = 100.f;
            try {
                auto j = nlohmann::json::parse(value);
                if (j.is_object() && j.contains("_range") && j["_range"].is_number())
                    range = j["_range"].get<float>();
                else if (j.is_number())
                    range = j.get<float>();
            } catch (...) {
                try {
                    range = std::stof(value);
                } catch (...) {
                    webui_log::warn("onNearbyRangeChange: bad payload {}", value);
                    return;
                }
            }
            if (!PapyrusBindings_WebUI::SetNearbyRadius(range)) {
                webui_log::warn("onNearbyRangeChange: invalid range {}", range);
                return;
            }
            webui_log::info("onNearbyRangeChange range={}", PapyrusBindings_WebUI::GetNearbyRadius());
            PapyrusBindings_WebUI::PopulateNearbyActors(PapyrusBindings_WebUI::GetNearbyRadius());
        });

        PrismaUI->RegisterJSListener(g_view, "onResolveActorMeta", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                PapyrusBindings_WebUI::DispatchManagerMethodStrOnly("WebUI_OnResolveActorMeta", j.dump());
            } catch (...) {
                webui_log::warn("onResolveActorMeta: bad JSON");
            }
        });

        // JS "start" → Scene Creator (Tag Edit) or ActionCatalog::ExecuteAction.
        PrismaUI->RegisterJSListener(g_view, "onAction", [](const char* value) {
            if (!value) return;

            auto* target = PapyrusBindings_WebUI::Target_Current;
            auto* player = RE::PlayerCharacter::GetSingleton();
            std::string payloadStr(value);

            nlohmann::json payload;
            try {
                payload = nlohmann::json::parse(payloadStr);
            } catch (...) {
                webui_log::warn("onAction: non-JSON payload ignored: {}", payloadStr);
                return;
            }

            const std::string action = payload.value("action", "");
            const std::string name = payload.value("name", "");
            nlohmann::json params = payload.value("parameters", nlohmann::json::object());

            if (action == "custom") {
                webui_log::info("onAction custom name={}", name);
                if (!ActionCatalog::OpenSceneCreatorFromTargetMenu(name, params, player, target)) {
                    webui_log::error("onAction: OpenSceneCreatorFromTargetMenu failed for {}", name);
                }
                return;
            }

            if (action == "papyrus") {
                webui_log::info("onAction papyrus label={}", payload.value("label", ""));
                nlohmann::json opt = payload;
                if (!opt.contains("parameters"))
                    opt["parameters"] = params;
                bool ok = ActionCatalog::ExecutePapyrusOption(opt, player, target);
                if (!ok)
                    webui_log::error("onAction: ExecutePapyrusOption failed");
                // Stay open for live panels unless payload requests close.
                if (payload.value("closeWebUI", false)) {
                    WebUI_Invoke("hidePanel('target_menu_panel');");
                    PapyrusBindings_WebUI::ClearTargetMenuSession();
                    WebUI_Visibility_Hide();
                }
                return;
            }

            if (action != "start") {
                webui_log::info("onAction: ignoring action={}", action);
                return;
            }

            webui_log::info("onAction start name={}", name);

            // TargetMenu Start always ExecuteAction; skip Scene Creator only for scene-start actions.
            if (ActionCatalog::ShouldOpenSceneCreatorFromTargetMenu(
                    name, params, player, target, true, true)) {
                PapyrusBindings_WebUI::SkipSceneCreatorOnce = true;
            }

            // Queue Papyrus first, then close overlay so StartThread runs unpaused
            // (PrismaUI Focus uses pauseGame=true). Custom keeps TargetMenu open.
            bool ok = ActionCatalog::ExecuteAction(name, params, player, target);
            if (!ok) {
                webui_log::error("onAction: ExecuteAction failed for {}", name);
                PapyrusBindings_WebUI::SkipSceneCreatorOnce = false;
            }
            WebUI_Invoke("hidePanel('target_menu_panel');");
            PapyrusBindings_WebUI::ClearTargetMenuSession();
            WebUI_Visibility_Hide();
        });

        PrismaUI->RegisterJSListener(g_view, "onMainPanelChange", [](const char* value) {
            if (!value)
                return;
            try {
                auto j = nlohmann::json::parse(value);
                const std::string key = j.value("key", "");
                webui_log::info("onMainPanelChange key={}", key);
                ActionCatalog::SwitchMainPanel(key);
            } catch (...) {
                // Plain string key
                webui_log::info("onMainPanelChange key={}", value);
                ActionCatalog::SwitchMainPanel(value);
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onFrameworkChange", [](const char* value) {
            if (!value) return;
            auto* global = RE::TESForm::LookupByEditorID<RE::TESGlobal>("skyrimnet_sexlab_ostim_player");
            if (!global) {
                webui_log::error("Could not find global skyrimnet_sexlab_ostim_player");
                return;
            }
            if (std::string_view(value) == "ostim") {
                global->value = 1.0f;
                webui_log::info("Framework set to OStim");
            } else {
                global->value = 0.0f;
                webui_log::info("Framework set to SexLab");
            }
        });

        PrismaUI->RegisterJSListener(g_view, "onControlPauseToggle", [](const char*) {
            if (!PrismaUI || !PrismaUI->IsValid(g_view))
                return;
            // Focus() while already focused does not re-apply pauseGame — Unfocus first.
            const bool nextPaused = !g_webuiGamePaused.load();
            PrismaUI->Unfocus(g_view);
            PrismaUI->Focus(g_view, nextPaused);
            g_webuiGamePaused = nextPaused;
            webui_log::info("onControlPauseToggle: {} (Unfocus+Focus pauseGame={})",
                nextPaused ? "paused" : "unpaused", nextPaused);
            WebUI_Invoke(nextPaused ? "setControlPaused(true);" : "setControlPaused(false);");
        });

        PrismaUI->RegisterJSListener(g_view, "onSettingsRebuild", [](const char*) {
            webui_log::info("onSettingsRebuild");
            Call_RebuildAnimDb();
            ActionCatalog::SwitchMainPanel("log_panel");
        });

        PrismaUI->RegisterJSListener(g_view, "onSettingsOpenSkyrimNet", [](const char*) {
            webui_log::info("onSettingsOpenSkyrimNet");
            Call_OpenSkyrimNetDashboard();
        });

        PrismaUI->RegisterJSListener(g_view, "onSettingsRefresh", [](const char*) {
            SexLabNet::InvokeConfigureSettingsPanel();
        });

        PrismaUI->RegisterJSListener(g_view, "onLogPanelOpen", [](const char*) {
            SexLabNet::InvokeLogPanelOpen();
        });

        PrismaUI->RegisterJSListener(g_view, "onLogPoll", [](const char*) {
            SexLabNet::PushLogPanelPoll();
        });

        KeyHandler::RegisterSink();
        KeyHandler::GetSingleton()->Register(0x01 /* escape */, []() {
            webui_log::info("Escape key pressed.");
            WebUI_Invoke("handleGlobalEscape();");
        });
        // Menu hotkey is control-store-driven via Config::ApplyMenuHotkey.
    });
}

/// MCM enable/remap: bind dxScanCode to Menu.ProcessHotkey, or clear when disabled.
void WebUI_SetMenuHotkey(uint32_t dxScanCode, bool enabled)
{
    const uint32_t prev = g_menuHotkey.exchange(0);
    if (prev != 0 && prev != 0x01)
        KeyHandler::GetSingleton()->Unregister(prev);

    if (!enabled || dxScanCode == 0 || dxScanCode == 0x01) {
        webui_log::info("WebUI menu hotkey disabled (prev={:#x}).", prev);
        return;
    }

    g_menuHotkey = dxScanCode;
    KeyHandler::GetSingleton()->Register(dxScanCode, [dxScanCode]() {
        if (!g_gameReady) {
            webui_log::info("WebUI hotkey blocked — no game loaded.");
            return;
        }
        PapyrusBindings_WebUI::Call_ProcessHotkey(static_cast<std::int32_t>(dxScanCode));
    });
    webui_log::info("WebUI menu hotkey registered dx={:#x}.", dxScanCode);
}
