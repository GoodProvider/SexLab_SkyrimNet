#include "WebUI.h"
#include "Papyrus_WebUI.h"
#include "WebUI_Log.h"
#include "ActionCatalog.h"
#include "ActionDispatch.h"
#include "RE/Skyrim.h"

#include <deque>
#include <mutex>
#include <string>
#include <nlohmann/json.hpp>

static PRISMA_UI_API::IVPrismaUI1* PrismaUI = nullptr;
static PrismaView g_view = 0;
static std::atomic<bool> g_gameReady{false};
static std::atomic<bool> g_domReady{false};
static std::mutex g_invokeMutex;
static std::deque<std::string> g_pendingInvokes;

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
/// Reloads ActionCatalog so actions_index / target_options pick up file changes.
void WebUI_SetGameReady()
{
    g_gameReady = true;
    if (!ActionCatalog::Load()) {
        webui_log::error("Game ready — ActionCatalog reload failed.");
    } else {
        webui_log::info("Game ready — WebUI input enabled; ActionCatalog reloaded.");
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
}

/// Unfocuses and hides the PrismaUI overlay without clearing Target_Current.
void WebUI_Visibility_Hide()
{
    if (!PrismaUI) return;
    PrismaUI->Unfocus(g_view);
    PrismaUI->Hide(g_view);
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

/// Hides target/sex panels in JS and closes the overlay (menus back to closed).
void WebUI_Reset()
{
    WebUI_Invoke("hidePanel('target_menu_panel');");
    WebUI_Invoke("hidePanel('sex_menu_panel');");
    WebUI_Visibility_Hide();
}

/// Clears the current target actor and resets panels / visibility to a closed UI.
void Reset_To_Default()
{
    PapyrusBindings_WebUI::Target_Current = nullptr;
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
        });

        if (!PrismaUI->IsValid(g_view)) {
            webui_log::critical(
                "CreateView returned invalid view — ensure Data/PrismaUI/views/SkyrimNet_SexLab/index.html exists.");
        }

        PrismaUI->Hide(g_view);

        PrismaUI->RegisterJSListener(g_view, "onCancel", [](const char*) {
            WebUI_Visibility_Hide();
            PapyrusBindings_WebUI::Target_Current = nullptr;
        });

        // JS "start" → hide menus and dispatch ActionCatalog::ExecuteAction.
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
            if (action != "start") {
                webui_log::info("onAction: ignoring action={}", action);
                return;
            }

            const std::string name = payload.value("name", "");
            nlohmann::json params = payload.value("parameters", nlohmann::json::object());

            webui_log::info("onAction start name={}", name);

            WebUI_Invoke("hidePanel('target_menu_panel');");
            WebUI_Invoke("hidePanel('sex_menu_panel');");
            WebUI_Visibility_Hide();

            bool ok = ActionCatalog::ExecuteAction(name, params, player, target);
            PapyrusBindings_WebUI::Target_Current = nullptr;
            if (!ok) {
                webui_log::error("onAction: ExecuteAction failed for {}", name);
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

        KeyHandler::RegisterSink();
        KeyHandler::GetSingleton()->Register(0x01 /* escape */, []() {
            webui_log::info("Escape key pressed.");
            WebUI_Visibility_Hide();
            PapyrusBindings_WebUI::Target_Current = nullptr;
        });
        KeyHandler::GetSingleton()->Register(0x2B /* backslash */, []() {
            if (!g_gameReady) {
                webui_log::info("WebUI hotkey blocked — no game loaded.");
                return;
            }

            RE::Actor* targetActor = nullptr;
            auto* crosshairData = RE::CrosshairPickData::GetSingleton();
            if (crosshairData) {
                if (auto ref = crosshairData->target[0].get()) {
                    targetActor = ref->As<RE::Actor>();
                }
            }

            if (targetActor) {
                PapyrusBindings_WebUI::Target_Menu_Open(nullptr, targetActor);
            } else {
                PapyrusBindings_WebUI::Call_MultiTarget_Menu_Selection();
            }
        });
    });
}
