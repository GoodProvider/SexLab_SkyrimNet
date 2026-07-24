#include "WebUI.h"
#include "Papyrus_WebUI.h"
#include "WebUI_Log.h"
#include "RE/Skyrim.h"

static PRISMA_UI_API::IVPrismaUI1* PrismaUI = nullptr;
static PrismaView g_view = 0;
static std::atomic<bool> g_gameReady{false};

KeyHandler* KeyHandler::GetSingleton()
{
    static KeyHandler singleton;
    return &singleton;
}

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

void KeyHandler::Register(uint32_t dxScanCode, KeyCallback callback)
{
    std::unique_lock lock(_mutex);
    _callbacks[dxScanCode] = std::move(callback);
}

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

// ── WebUI API ───────────────────────────────────────────────────────────────

void WebUI_SetGameReady()
{
    g_gameReady = true;
    webui_log::info("Game ready — WebUI input enabled.");
}

void WebUI_Visibility_Show()
{
    if (!PrismaUI) return;
    if (!g_gameReady) {
        webui_log::info("WebUI blocked — no game loaded.");
        return;
    }

    PapyrusBindings_WebUI::PopulateNearbyActors();

    PrismaUI->Show(g_view);
    PrismaUI->Focus(g_view, true);
}

void WebUI_Visibility_Hide()
{
    if (!PrismaUI) return;
    PrismaUI->Unfocus(g_view);
    PrismaUI->Hide(g_view);
}

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

void WebUI_Invoke(const std::string& script)
{
    if (PrismaUI)
        PrismaUI->Invoke(g_view, script.c_str());
}
// ── Sex Menu API ────────────────────────────────────────────────────────────

void WebUI_Reset()
{
    WebUI_Invoke("hidePanel('target_menu_panel');");
    WebUI_Invoke("hidePanel('sex_menu_panel');");
    WebUI_Visibility_Hide();
}

void Reset_To_Default()
{
    PapyrusBindings_WebUI::Target_Current = nullptr;
    WebUI_Reset();
}

// ── WebUI API ───────────────────────────────────────────────────────────────

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

        g_view = PrismaUI->CreateView("SkyrimNet_SexLab/index.html", nullptr);
        PrismaUI->Hide(g_view);

        PrismaUI->RegisterJSListener(g_view, "onCancel", [](const char*) {
            WebUI_Visibility_Toggle();
        });

        PrismaUI->RegisterJSListener(g_view, "onAction", [](const char* value) {
            if (!value) return;
            Reset_To_Default();

            std::string_view action(value);
            std::string verb = "";
            if (action == "hug")
                verb = "hugging";
            else if (action == "kiss")
                verb = "kissing";

            webui_log::info("onAction: action={} verb={}", action, verb);
            if (verb != "") {
                auto* player = RE::PlayerCharacter::GetSingleton();
                auto* target = PapyrusBindings_WebUI::Target_Current;
                if (!player || !target) {
                    webui_log::warn("onAction {}: player or target is null", action);
                    return;
                }
                SKSE::GetTaskInterface()->AddTask([player, target, verb]() {
                    auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                    if (!vm) return;
                    // SkyrimNet_SexLab_Actions is a script on the main quest (FormID 0x800),
                    // not a separate quest — look it up by FormID, not EditorID.
                    auto* quest = RE::TESDataHandler::GetSingleton()
                        ->LookupForm<RE::TESQuest>(0x800, "SkyrimNet_SexLab.esp");
                    if (!quest) {
                        webui_log::error("Could not find SkyrimNet_SexLab main quest (0x800)");
                        return;
                    }
                    auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                        static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
                    RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
                    vm->FindBoundObject(handle, "SkyrimNet_SexLab_Actions", scriptObject);
                    if (!scriptObject) {
                        webui_log::error("Could not find bound script for SkyrimNet_SexLab_Actions");
                        return;
                    }
                    auto* args = RE::MakeFunctionArguments(
                        static_cast<RE::Actor*>(player), static_cast<RE::Actor*>(target),
                        RE::BSFixedString("normal"), RE::BSFixedString(verb.c_str()), false);
                    RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
                    vm->DispatchMethodCall(scriptObject, RE::BSFixedString("Affection_Start"), args, callback);
                });
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

        });
        KeyHandler::GetSingleton()->Register(0x2B /* backslash */, []() {
            auto* crosshairData = RE::CrosshairPickData::GetSingleton();
            if (crosshairData) {
                // 1. target is an array, so we access index [0]
                // 2. get() returns a NiPointer, so we use 'auto' instead of 'auto*'
                if (auto ref = crosshairData->target[0].get()) { 
                    auto* targetActor = ref->As<RE::Actor>();
                    if (targetActor) {
                        PapyrusBindings_WebUI::Target_Menu_Open(nullptr, targetActor);
                    }
                }
            }
        });
    });
}