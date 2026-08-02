#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"
#include "WebUI_Log.h"
#include "WebUI.h"
#include "PublicAPI.h"
#include "ActionCatalog.h"
#include "AnimationDB.h"
#include <nlohmann/json.hpp>

namespace PapyrusBindings_WebUI
{
    RE::Actor* Target_Current = nullptr;
    std::int32_t YesNo_Creator_Sid = -1;
    bool EditTagsPlayer = true;
    bool EditTagsNonPlayer = false;
    bool SceneCreatorOpenedForPending = false;

    void ClearSceneCreatorPending()
    {
        SceneCreatorOpenedForPending = false;
    }

    static AnimationDB::FilterSpec ParseFilterJson(const char* json)
    {
        AnimationDB::FilterSpec spec;
        if (!json || !json[0])
            return spec;
        try {
            auto j = nlohmann::json::parse(json);
            if (j.contains("_actor_count") && j["_actor_count"].is_number())
                spec.actor_count = j["_actor_count"].get<int>();
            auto read_tags = [&](const char* k, std::vector<std::string>& out) {
                if (j.contains(k) && j[k].is_array()) {
                    for (const auto& el : j[k]) {
                        if (el.is_string())
                            out.push_back(AnimationDB::ToLower(el.get<std::string>()));
                    }
                }
            };
            read_tags("_must_tags", spec.must_tags);
            read_tags("_suppress_tags", spec.suppress_tags);
            if (j.contains("_require_all") && j["_require_all"].is_boolean())
                spec.require_all = j["_require_all"].get<bool>();
            else if (!spec.must_tags.empty())
                spec.require_all = true;
            if (j.contains("_creature") && j["_creature"].is_string()) {
                auto c = AnimationDB::ToLower(j["_creature"].get<std::string>());
                if (c == "require")
                    spec.creature = 1;
                else if (c == "exclude")
                    spec.creature = 2;
            }
            if (j.contains("_enabled_only") && j["_enabled_only"].is_boolean())
                spec.enabled_only = j["_enabled_only"].get<bool>();
            if (j.contains("_position_match") && j["_position_match"].is_boolean())
                spec.position_match = j["_position_match"].get<bool>();
            if (j.contains("_pos_genders") && j["_pos_genders"].is_array()) {
                for (const auto& el : j["_pos_genders"]) {
                    if (el.is_number_integer())
                        spec.pos_genders.push_back(el.get<int>());
                }
            }
            if (j.contains("_pos_race_keys") && j["_pos_race_keys"].is_array()) {
                for (const auto& el : j["_pos_race_keys"]) {
                    if (el.is_string())
                        spec.pos_race_keys.push_back(AnimationDB::ToLower(el.get<std::string>()));
                }
            }
            if (j.contains("_has_description") && j["_has_description"].is_boolean())
                spec.has_description = j["_has_description"].get<bool>();
        } catch (...) {
            webui_log::warn("ParseFilterJson failed");
        }
        return spec;
    }

    static nlohmann::json AnimRowToJson(const AnimationDB::AnimRow& row)
    {
        nlohmann::json j;
        j["_registry"] = row.registry;
        j["_name"] = row.name;
        j["_enabled"] = row.enabled;
        j["_position_count"] = row.position_count;
        j["_stage_count"] = row.stage_count;
        j["_tags"] = row.tags;
        j["_pos_genders"] = row.pos_genders;
        j["_pos_no_orgasm"] = row.pos_no_orgasm;
        j["_pos_speaking_modifiers"] = row.pos_speaking_modifiers;
        j["_stage_has_description"] = row.stage_has_description;
        nlohmann::json sd = nlohmann::json::object();
        for (const auto& [k, v] : row.stage_descriptions)
            sd[std::to_string(k)] = v;
        j["_stage_descriptions"] = sd;
        return j;
    }

    static void InvokeAnimDbQueryResult(const char* request_id, const nlohmann::json& payload)
    {
        nlohmann::json out = payload;
        out["_request_id"] = request_id ? request_id : "";
        WebUI_Invoke("animDbQueryResult(" + out.dump() + ");");
    }

    void WebUI_HideAllPanels(RE::StaticFunctionTag*)
    {
        WebUI_Invoke("hidePanel('target_menu_panel');");
        WebUI_Invoke("hidePanel('sex_menu_panel');");
        WebUI_Invoke("hidePanel('yesno_panel');");
        WebUI_Invoke("hidePanel('scene_creator_panel');");
        WebUI_Invoke("hidePanel('scene_menu_panel');");
    }

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

    void DispatchSceneExportMenuState(RE::TESForm* thread, RE::TESForm* sl_scene);

    /// Opens the target menu for the given actor and focuses the PrismaUI view.
    /// Same target again toggles visibility instead of rebuilding.
    void Target_Menu_Open(RE::StaticFunctionTag*, RE::Actor* Target_Input, bool hasStrippedItems,
        bool editTagsPlayer, bool editTagsNonPlayer)
    {
        if (!Target_Input) {
            webui_log::warn("Target_Menu_Open called with null Actor.");
            return;
        }

        EditTagsPlayer = editTagsPlayer;
        EditTagsNonPlayer = editTagsNonPlayer;

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
            "Target_Menu_Open triggered. Target: {} hasStrippedItems={} editTagsPlayer={} editTagsNonPlayer={}",
            name,
            hasStrippedItems,
            editTagsPlayer,
            editTagsNonPlayer);

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

    void YesNo_Open(RE::StaticFunctionTag*, RE::BSFixedString question, std::int32_t creator_sid)
    {
        YesNo_Creator_Sid = creator_sid;
        webui_log::info("YesNo_Open creator_sid={}", creator_sid);
        WebUI_HideAllPanels(nullptr);
        nlohmann::json cfg;
        cfg["_question"] = question.c_str() ? question.c_str() : "";
        cfg["_creator_sid"] = creator_sid;
        WebUI_Invoke("configureYesNo(" + cfg.dump() + ");");
        WebUI_Invoke("showPanel('yesno_panel');");
        WebUI_Visibility_Show();
    }

    void SceneCreator_Open(RE::StaticFunctionTag*, RE::BSFixedString state_json)
    {
        webui_log::info("SceneCreator_Open");
        WebUI_HideAllPanels(nullptr);
        const char* raw = state_json.c_str() ? state_json.c_str() : "{}";
        std::string dumped = "{}";
        try {
            auto parsed = nlohmann::json::parse(raw);
            dumped = parsed.dump();
            webui_log::info("SceneCreator_Open state bytes={}", dumped.size());
        } catch (const std::exception& e) {
            webui_log::error("SceneCreator_Open: bad state_json ({}); using {{}}", e.what());
        } catch (...) {
            webui_log::error("SceneCreator_Open: bad state_json; using {{}}");
        }
        SceneCreatorOpenedForPending = true;
        WebUI_Invoke(std::string("configureSceneCreator(") + dumped + ");");
        WebUI_Invoke("showPanel('scene_creator_panel');");
        WebUI_Visibility_Show();
    }

    void ActorAnimMeta_Result(RE::StaticFunctionTag*, RE::BSFixedString json)
    {
        const char* raw = json.c_str() ? json.c_str() : "{}";
        std::string dumped = "{}";
        try {
            dumped = nlohmann::json::parse(raw).dump();
        } catch (...) {
            webui_log::warn("ActorAnimMeta_Result: bad json");
        }
        WebUI_Invoke(std::string("actorAnimMetaResult(") + dumped + ");");
    }

    void WebUI_SetHotkey(RE::StaticFunctionTag*, std::int32_t dxScanCode, bool enabled)
    {
        webui_log::info("WebUI_SetHotkey dx={:#x} enabled={}", static_cast<uint32_t>(dxScanCode), enabled);
        WebUI_SetMenuHotkey(static_cast<uint32_t>(dxScanCode), enabled);
    }

    void Scene_Menu_Open(RE::StaticFunctionTag*, RE::TESForm* thread, RE::TESForm* sl_scene)
    {
        if (!thread || !sl_scene) {
            webui_log::warn("Scene_Menu_Open: null thread or scene");
            return;
        }
        webui_log::info("Scene_Menu_Open");
        Target_Current = nullptr;
        WebUI_HideAllPanels(nullptr);
        DispatchSceneExportMenuState(thread, sl_scene);
    }

    void Scene_Menu_Show(RE::StaticFunctionTag*, RE::BSFixedString state_json)
    {
        const char* raw = state_json.c_str() ? state_json.c_str() : "{}";
        WebUI_Invoke(std::string("configureSceneMenu(") + raw + ");");
        WebUI_Invoke("showPanel('scene_menu_panel');");
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
            std::string playerName;
            if (playerUUID && PublicGetActorNameByUUID) {
                playerName = PublicGetActorNameByUUID(playerUUID);
            }
            if (playerName.empty()) {
                const char* dn = player->GetDisplayFullName();
                if (dn && dn[0])
                    playerName = dn;
            }
            if (playerName.empty()) {
                const char* n = player->GetName();
                playerName = (n && n[0]) ? n : "Player";
            }
            WebUI_Invoke(std::format("setPlayerActor('{}', '{}', {});", playerUUID, EscapeJsString(playerName),
                static_cast<unsigned>(player->GetFormID())));
        }

        if (PublicGetActorEngagement) {
            try {
                std::string raw = PublicGetActorEngagement(20, true, false, 604800.0, 2592000.0);
                auto arr = nlohmann::json::parse(raw);
                nlohmann::json nearby = nlohmann::json::array();
                for (auto& item : arr) {
                    uint32_t formId = item["formId"].get<uint32_t>();
                    std::string actorName;
                    uint64_t actorUUID = PublicFormIDToUUID ? PublicFormIDToUUID(formId) : 0;
                    if (actorUUID && PublicGetActorNameByUUID) {
                        actorName = PublicGetActorNameByUUID(actorUUID);
                    }
                    if (actorName.empty() && item.contains("name") && item["name"].is_string()) {
                        actorName = item["name"].get<std::string>();
                    }
                    if (actorName.empty()) {
                        auto* ak = RE::TESForm::LookupByID<RE::Actor>(formId);
                        if (ak) {
                            const char* dn = ak->GetDisplayFullName();
                            if (dn && dn[0])
                                actorName = dn;
                            else {
                                const char* n = ak->GetName();
                                if (n && n[0])
                                    actorName = n;
                            }
                        }
                    }
                    if (actorName.empty())
                        actorName = "Unknown";
                    nearby.push_back({
                        { "name", actorName },
                        { "uuid", std::to_string(actorUUID) },
                        { "formId", static_cast<int>(formId) }
                    });
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

    void DispatchSceneExportMenuState(RE::TESForm* thread, RE::TESForm* sl_scene)
    {
        if (!thread || !sl_scene) {
            webui_log::warn("DispatchSceneExportMenuState: null args");
            return;
        }

        SKSE::GetTaskInterface()->AddTask([thread, sl_scene]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("DispatchSceneExportMenuState: no VM");
                return;
            }

            RE::TESQuest* quest = FindMainQuest();
            if (!quest) {
                webui_log::error("DispatchSceneExportMenuState: quest not found");
                return;
            }

            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(sl_scene->GetFormType()), sl_scene);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Scene", scriptObject);
            if (!scriptObject) {
                webui_log::error("DispatchSceneExportMenuState: Scene script not bound");
                return;
            }

            auto* args = RE::MakeFunctionArguments(static_cast<RE::TESForm*>(thread));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString("WebUI_ExportMenuState"), args,
                callback);
            webui_log::info("DispatchSceneExportMenuState: dispatched");
        });
    }

    static void DispatchManagerMethod(const char* method, std::int32_t a, std::int32_t b)
    {
        SKSE::GetTaskInterface()->AddTask([method, a, b]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("DispatchManagerMethod: no VM");
                return;
            }

            RE::TESQuest* quest = FindMainQuest();
            if (!quest) {
                webui_log::error("DispatchManagerMethod: quest not found");
                return;
            }

            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Scene_Manager", scriptObject);
            if (!scriptObject) {
                webui_log::error("DispatchManagerMethod: Manager script not bound");
                return;
            }

            int arg_a = static_cast<int>(a);
            int arg_b = static_cast<int>(b);
            auto* args = RE::MakeFunctionArguments(std::move(arg_a), std::move(arg_b));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString(method), args, callback);
        });
    }

    static void DispatchManagerMethodStr(const char* method, std::int32_t a, const std::string& b)
    {
        SKSE::GetTaskInterface()->AddTask([method, a, b]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("DispatchManagerMethod: no VM");
                return;
            }

            RE::TESQuest* quest = FindMainQuest();
            if (!quest) {
                webui_log::error("DispatchManagerMethod: quest not found");
                return;
            }

            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Scene_Manager", scriptObject);
            if (!scriptObject) {
                webui_log::error("DispatchManagerMethod: Manager script not bound");
                return;
            }

            int arg_a = static_cast<int>(a);
            RE::BSFixedString arg_b(b);
            auto* args = RE::MakeFunctionArguments(std::move(arg_a), std::move(arg_b));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString(method), args, callback);
        });
    }
    void DispatchManagerMethodIntInt(const char* method, std::int32_t a, std::int32_t b)
    {
        DispatchManagerMethod(method, a, b);
    }

    void DispatchManagerMethodIntStr(const char* method, std::int32_t a, const std::string& b)
    {
        DispatchManagerMethodStr(method, a, b);
    }

    void DispatchManagerMethodStrOnly(const char* method, const std::string& b)
    {
        std::string methodName = method ? method : "";
        std::string payload = b;
        SKSE::GetTaskInterface()->AddTask([methodName, payload]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("DispatchManagerMethodStrOnly: no VM");
                return;
            }
            RE::TESQuest* quest = FindMainQuest();
            if (!quest) {
                webui_log::error("DispatchManagerMethodStrOnly: quest not found");
                return;
            }
            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Scene_Manager", scriptObject);
            if (!scriptObject) {
                webui_log::error("DispatchManagerMethodStrOnly: Manager script not bound");
                return;
            }
            auto* args = RE::MakeFunctionArguments(RE::BSFixedString(payload.c_str()));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString(methodName.c_str()), args, callback);
            webui_log::info("DispatchManagerMethodStrOnly: {}", methodName);
        });
    }

    void HandleAnimDbQuery(const char* value)
    {
        if (!value)
            return;
        try {
            auto j = nlohmann::json::parse(value);
            const std::string request_id = j.value("_request_id", "");
            const std::string query_type = j.value("_type", "tags");
            const std::string filter_raw = j.contains("_filter") ? j["_filter"].dump() : "{}";
            const int n = j.value("_n", 20);
            auto spec = ParseFilterJson(filter_raw.c_str());

            if (query_type == "anims") {
                nlohmann::json rows = nlohmann::json::array();
                for (const auto& row : AnimationDB::QueryTopNAnims(spec, n))
                    rows.push_back(AnimRowToJson(row));
                nlohmann::json payload;
                payload["_anims"] = rows;
                payload["_total_enabled"] = AnimationDB::TotalEnabledCount();
                InvokeAnimDbQueryResult(request_id.c_str(), payload);
            } else {
                nlohmann::json tags = nlohmann::json::array();
                for (const auto& tc : AnimationDB::QueryTopNTags(spec, n)) {
                    tags.push_back({ { "_tag", tc.tag }, { "_count", tc.count } });
                }
                nlohmann::json payload;
                payload["_tags"] = tags;
                payload["_total_enabled"] = AnimationDB::TotalEnabledCount();
                InvokeAnimDbQueryResult(request_id.c_str(), payload);
            }
        } catch (...) {
            webui_log::warn("HandleAnimDbQuery: parse failed");
        }
    }

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

    void Call_ProcessHotkey(std::int32_t keyCode)
    {
        SKSE::GetTaskInterface()->AddTask([keyCode]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("Call_ProcessHotkey: no VM");
                return;
            }

            RE::TESQuest* quest = FindMainQuest();
            if (!quest) {
                webui_log::error("Call_ProcessHotkey: quest not found");
                return;
            }

            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Menu", scriptObject);
            if (!scriptObject) {
                webui_log::error("Call_ProcessHotkey: Menu script not bound");
                return;
            }

            int arg = static_cast<int>(keyCode);
            auto* args = RE::MakeFunctionArguments(std::move(arg));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString("ProcessHotkey"), args, callback);
            webui_log::info("Call_ProcessHotkey: dispatched key={}", keyCode);
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
        a_vm->RegisterFunction("YesNo_Open", scriptName, YesNo_Open);
        a_vm->RegisterFunction("SceneCreator_Open", scriptName, SceneCreator_Open);
        a_vm->RegisterFunction("Scene_Menu_Open", scriptName, Scene_Menu_Open);
        a_vm->RegisterFunction("Scene_Menu_Show", scriptName, Scene_Menu_Show);
        a_vm->RegisterFunction("WebUI_HideAllPanels", scriptName, WebUI_HideAllPanels);
        a_vm->RegisterFunction("WebUI_SetHotkey", scriptName, WebUI_SetHotkey);
        a_vm->RegisterFunction("ActorAnimMeta_Result", scriptName, ActorAnimMeta_Result);
        a_vm->RegisterFunction("TraceLog", scriptName, TraceLog);

        webui_log::info("Successfully registered Papyrus functions for {}", scriptName);
        return true;
    }
}
