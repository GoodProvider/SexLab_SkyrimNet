#pragma once

#include <functional>
#include <map>
#include <vector>
#include <shared_mutex>

#include "PrismaUI_API.h"


using KeyCallback = std::function<void()>;

class KeyHandler : public RE::BSTEventSink<RE::InputEvent*>
{
public:
    static KeyHandler* GetSingleton();
    static void RegisterSink();
    void Register(uint32_t dxScanCode, KeyCallback callback);

private:
    KeyHandler() = default;
    ~KeyHandler() override = default;
    KeyHandler(const KeyHandler&) = delete;
    KeyHandler(KeyHandler&&) = delete;
    KeyHandler& operator=(const KeyHandler&) = delete;
    KeyHandler& operator=(KeyHandler&&) = delete;

    RE::BSEventNotifyControl ProcessEvent(RE::InputEvent* const* a_eventList,
                                          RE::BSTEventSource<RE::InputEvent*>* a_eventSource) override;

    std::map<uint32_t, KeyCallback> _callbacks;
    std::shared_mutex _mutex;
};

void InitWebUI();
void WebUI_SetGameReady();
void WebUI_Visibility_Show();
void WebUI_Visibility_Hide();
void WebUI_Visibility_Toggle();
void WebUI_Invoke(const std::string& script);
void WebUI_Reset();
void Reset_To_Default();
