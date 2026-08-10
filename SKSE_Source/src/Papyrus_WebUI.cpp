#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"
#include "WebUI_Log.h"
#include "WebUI.h"
#include "ActionCatalog.h"
#include "AnimationDB.h"
#include "Config.h"
#include <nlohmann/json.hpp>
#include <algorithm>
#include <cmath>
#include <vector>

// Defined in PublicAPI.h (included once from Config.cpp).
extern "C" {
extern uint64_t (*PublicFormIDToUUID)(uint32_t formId);
extern std::string (*PublicGetActorNameByUUID)(uint64_t uuid);
}

namespace PapyrusBindings_WebUI
{
    RE::Actor* Target_Current = nullptr;
    std::int32_t YesNo_Creator_Sid = -1;
    bool EditTagsPlayer = true;
    bool EditTagsNonPlayer = false;
    bool SceneCreatorOpenedForPending = false;
    bool TargetMenuSessionActive = false;
    bool SkipSceneCreatorOnce = false;

    void ClearSceneCreatorPending()
    {
        SceneCreatorOpenedForPending = false;
    }

    void ClearTargetMenuSession()
    {
        TargetMenuSessionActive = false;
        Target_Current = nullptr;
    }

    bool ConsumeSkipSceneCreator(RE::StaticFunctionTag*)
    {
        const bool skip = SkipSceneCreatorOnce;
        SkipSceneCreatorOnce = false;
        return skip;
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
            if (j.contains("_gender_match") && j["_gender_match"].is_boolean())
                spec.gender_match = j["_gender_match"].get<bool>();
            if (j.contains("_males") && j["_males"].is_number_integer())
                spec.males = j["_males"].get<int>();
            if (j.contains("_females") && j["_females"].is_number_integer())
                spec.females = j["_females"].get<int>();
            if (j.contains("_male_creatures") && j["_male_creatures"].is_number_integer())
                spec.male_creatures = j["_male_creatures"].get<int>();
            if (j.contains("_female_creatures") && j["_female_creatures"].is_number_integer())
                spec.female_creatures = j["_female_creatures"].get<int>();
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
        if (!TargetMenuSessionActive)
            WebUI_Invoke("hidePanel('target_menu_panel');");
        ActionCatalog::ClearMainPanelSelection();
        WebUI_Invoke("hidePanel('sex_menu_panel');");
        WebUI_Invoke("hidePanel('yesno_panel');");
        WebUI_Invoke("hidePanel('scene_creator_panel');");
        WebUI_Invoke("hidePanel('animation_menu_panel');");
        WebUI_Invoke("hidePanel('settings_panel');");
        WebUI_Invoke("hidePanel('log_panel');");
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

    void DispatchAnimationMenuExportState(RE::TESForm* thread, RE::TESForm* sl_scene);

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
            // Rebuild catalog so eligibilityRules re-evaluate against live focus state.
            if (!ActionCatalog::IsLoaded())
                ActionCatalog::Load();
            auto catalog = ActionCatalog::BuildUICatalog(hasStrippedItems);
            WebUI_Invoke("configureTargetMenu(" + catalog.dump() + ");");
            WebUI_Visibility_Toggle();
            return;
        }

        Reset_To_Default();
        Target_Current = Target_Input;
        TargetMenuSessionActive = true;

        if (!ActionCatalog::IsLoaded())
            ActionCatalog::Load();

        const auto targetFormId = Target_Current->GetFormID();
        uint64_t uuid = (PublicFormIDToUUID) ? PublicFormIDToUUID(targetFormId) : 0;
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
        WebUI_Invoke("configureControlPanel(" + ActionCatalog::BuildMainPanelsCatalog().dump() + ");");
        const std::string uuidStr =
            uuid ? std::to_string(uuid) : std::to_string(static_cast<unsigned>(targetFormId));
        WebUI_Invoke(std::format("setTargetActor('{}', '{}', {});", uuidStr, EscapeJsString(name),
            static_cast<unsigned>(targetFormId)));

        bool ostimnet = RE::TESDataHandler::GetSingleton()->LookupModByName("TT_OStimNet.esp") != nullptr;
        // Prefer live control store; fall back to global (TargetMenu live toggle).
        const char* fw = SexLabNet::Config::GetSingleton().FrameworkPlayerIndex() == 1 ? "ostim" : "sexlab";
        if (auto* g = RE::TESForm::LookupByEditorID<RE::TESGlobal>("skyrimnet_sexlab_ostim_player")) {
            if (g->value == 1.0f)
                fw = "ostim";
            else if (g->value == 0.0f)
                fw = "sexlab";
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

    void SceneCreator_Configure(RE::StaticFunctionTag*, RE::BSFixedString state_json)
    {
        const char* raw = state_json.c_str() ? state_json.c_str() : "{}";
        std::string dumped = "{}";
        try {
            dumped = nlohmann::json::parse(raw).dump();
        } catch (const std::exception& e) {
            webui_log::error("SceneCreator_Configure: bad state_json ({}); using {{}}", e.what());
        } catch (...) {
            webui_log::error("SceneCreator_Configure: bad state_json; using {{}}");
        }
        WebUI_Invoke(std::string("configureSceneCreator(") + dumped + ");");
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

    void WebUI_SetLastRebuildTimestamp(RE::StaticFunctionTag*, RE::BSFixedString timestamp)
    {
        const char* ts = timestamp.c_str();
        SexLabNet::SetLastRebuildTimestamp(ts ? ts : "");
        SexLabNet::InvokeConfigureSettingsPanel();
    }

    void Animation_Menu_Open(RE::StaticFunctionTag*, RE::TESForm* thread, RE::TESForm* sl_scene)
    {
        if (!thread || !sl_scene) {
            webui_log::warn("Animation_Menu_Open: null thread or scene");
            return;
        }
        webui_log::info("Animation_Menu_Open");
        ClearTargetMenuSession();
        WebUI_HideAllPanels(nullptr);
        DispatchAnimationMenuExportState(thread, sl_scene);
    }

    void Animation_Menu_Show(RE::StaticFunctionTag*, RE::BSFixedString state_json)
    {
        const char* raw = state_json.c_str() ? state_json.c_str() : "{}";
        std::string dumped = "{}";
        try {
            dumped = nlohmann::json::parse(raw).dump();
        } catch (...) {
            webui_log::warn("Animation_Menu_Show: bad state_json");
        }
        WebUI_Invoke(std::string("configureAnimationMenu(") + dumped + ");");
        WebUI_Invoke("showPanel('animation_menu_panel');");
        WebUI_Visibility_Show();
    }

    void Animation_Menu_Configure(RE::StaticFunctionTag*, RE::BSFixedString state_json)
    {
        const char* raw = state_json.c_str() ? state_json.c_str() : "{}";
        std::string dumped = "{}";
        try {
            dumped = nlohmann::json::parse(raw).dump();
        } catch (...) {
            webui_log::warn("Animation_Menu_Configure: bad state_json");
        }
        WebUI_Invoke(std::string("configureAnimationMenu(") + dumped + ");");
    }

    void SceneConnections_Show(RE::StaticFunctionTag*, RE::BSFixedString state_json)
    {
        const char* raw = state_json.c_str() ? state_json.c_str() : "{}";
        std::string dumped = "{}";
        try {
            dumped = nlohmann::json::parse(raw).dump();
        } catch (...) {
            webui_log::warn("SceneConnections_Show: bad state_json");
        }
        WebUI_Invoke(std::string("configureSceneConnections(") + dumped + ");");
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

    namespace
    {
        constexpr float kDefaultNearbyRadius = 100.f;
        float g_nearbyRadius = kDefaultNearbyRadius;

        constexpr float kAllowedRadii[] = { 100.f, 200.f, 400.f, 800.f, 1600.f };

        RE::TESFaction* ResolveSexLabAnimatingFaction()
        {
            static RE::TESFaction* cached = nullptr;
            static bool resolved = false;
            if (!resolved) {
                resolved = true;
                cached = RE::TESDataHandler::GetSingleton()->LookupForm<RE::TESFaction>(0xE50F, "SexLab.esm");
            }
            return cached;
        }

        RE::TESFaction* ResolveOstimActorCountFaction()
        {
            static RE::TESFaction* cached = nullptr;
            static bool resolved = false;
            if (!resolved) {
                resolved = true;
                auto* dh = RE::TESDataHandler::GetSingleton();
                if (dh && dh->LookupModByName("Ostim.esp"))
                    cached = dh->LookupForm<RE::TESFaction>(0xECA, "Ostim.esp");
            }
            return cached;
        }

        std::string ActorDisplayNameLocal(RE::Actor* actor)
        {
            if (!actor)
                return "Unknown";
            uint64_t uuid = PublicFormIDToUUID ? PublicFormIDToUUID(actor->GetFormID()) : 0;
            if (uuid && PublicGetActorNameByUUID) {
                std::string n = PublicGetActorNameByUUID(uuid);
                if (!n.empty())
                    return n;
            }
            const char* dn = actor->GetDisplayFullName();
            if (dn && dn[0])
                return dn;
            const char* n = actor->GetName();
            return (n && n[0]) ? n : "Unknown";
        }

        struct NearbyClassify {
            std::string status;  // sexlab | ok | reason (<=5)
            bool selectable = false;
            int sortRank = 2;  // 0 sexlab, 1 ok, 2 ineligible
        };

        NearbyClassify ClassifyNearbyActor(RE::Actor* actor)
        {
            NearbyClassify out;
            out.status = "gone";
            out.selectable = false;
            out.sortRank = 2;
            if (!actor || actor->IsDeleted())
                return out;
            if (actor->IsChild()) {
                out.status = "child";
                return out;
            }
            if (actor->IsDead()) {
                out.status = "dead";
                return out;
            }
            if (actor->IsInCombat()) {
                out.status = "cmbt";
                return out;
            }
            if (auto* ostim = ResolveOstimActorCountFaction()) {
                if (actor->IsInFaction(ostim)) {
                    out.status = "ostim";
                    return out;
                }
            }
            if (auto* anim = ResolveSexLabAnimatingFaction()) {
                if (actor->IsInFaction(anim)) {
                    out.status = "sexlab";
                    out.selectable = true;
                    out.sortRank = 0;
                    return out;
                }
            }
            if (!actor->Is3DLoaded()) {
                out.status = "load";
                return out;
            }
            out.status = "ok";
            out.selectable = true;
            out.sortRank = 1;
            return out;
        }

        std::string CropActorLabelName(const std::string& name, std::size_t maxLen = 10)
        {
            if (name.size() <= maxLen)
                return name;
            return name.substr(0, maxLen);
        }

        std::string MakeNearbyLabel(const std::string& name, const NearbyClassify& cls)
        {
            const std::string cropped = CropActorLabelName(name);
            if (cls.status == "ok")
                return cropped;
            std::string reason = cls.status;
            if (reason.size() > 5)
                reason = reason.substr(0, 5);
            return cropped + " (" + reason + ")";
        }

        bool IsSexLabAnimatingActor(RE::Actor* actor)
        {
            if (!actor)
                return false;
            if (auto* anim = ResolveSexLabAnimatingFaction())
                return actor->IsInFaction(anim);
            return false;
        }

        void PushNearbyJsonEntry(nlohmann::json& nearby, RE::Actor* actor, RE::Actor* distAnchor, bool isPlayer)
        {
            if (!actor)
                return;
            const auto formId = actor->GetFormID();
            uint64_t uuid = PublicFormIDToUUID ? PublicFormIDToUUID(formId) : 0;
            const std::string uuidStr =
                uuid ? std::to_string(uuid) : std::to_string(static_cast<unsigned>(formId));

            float dist = 0.f;
            if (distAnchor)
                dist = actor->GetPosition().GetDistance(distAnchor->GetPosition());

            const std::string name = ActorDisplayNameLocal(actor);
            const NearbyClassify cls = ClassifyNearbyActor(actor);

            nearby.push_back({
                { "name", name },
                { "label", MakeNearbyLabel(name, cls) },
                { "uuid", uuidStr },
                { "formId", static_cast<std::uint32_t>(formId) },
                { "dist", dist },
                { "status", cls.status },
                { "selectable", cls.selectable },
                { "sortRank", cls.sortRank },
                { "isPlayer", isPlayer }
            });
        }
    }

    bool SetNearbyRadius(float radius)
    {
        for (float allowed : kAllowedRadii) {
            if (std::fabs(radius - allowed) < 0.5f) {
                g_nearbyRadius = allowed;
                return true;
            }
        }
        return false;
    }

    float GetNearbyRadius()
    {
        return g_nearbyRadius;
    }

    /// Soft session checks for the nearby scan. StorageUtil lock + SexLab IsValidActor applied in Papyrus.
    bool IsAvailableActor(RE::Actor* actor)
    {
        if (!actor || actor->IsDeleted())
            return false;
        if (!actor->Is3DLoaded())
            return false;
        if (actor->IsDead())
            return false;
        if (actor->IsInCombat())
            return false;
        if (auto* anim = ResolveSexLabAnimatingFaction()) {
            if (actor->IsInFaction(anim))
                return false;
        }
        if (auto* ostim = ResolveOstimActorCountFaction()) {
            if (actor->IsInFaction(ostim))
                return false;
        }
        return true;
    }

    void SetNearbyActorsJson(RE::StaticFunctionTag*, RE::BSFixedString json)
    {
        const char* raw = json.c_str() ? json.c_str() : "[]";
        try {
            auto arr = nlohmann::json::parse(raw);
            if (!arr.is_array()) {
                webui_log::warn("SetNearbyActorsJson: not an array — keeping prior nearby list");
                return;
            }
            if (arr.empty()) {
                // Non-destructive: Papyrus tighten found nobody; keep C++ soft sync list.
                webui_log::warn("SetNearbyActorsJson: empty tighten — keeping prior nearby list");
                return;
            }
            auto* player = RE::PlayerCharacter::GetSingleton();
            nlohmann::json nearby = nlohmann::json::array();
            for (auto& item : arr) {
                if (!item.is_object())
                    continue;
                uint32_t formId = 0;
                if (item.contains("formId") && item["formId"].is_number())
                    formId = item["formId"].get<uint32_t>();
                else if (item.contains("_form_id") && item["_form_id"].is_number())
                    formId = item["_form_id"].get<uint32_t>();
                auto* ak = formId ? RE::TESForm::LookupByID<RE::Actor>(formId) : nullptr;
                if (!ak)
                    continue;
                const bool isPlayer = player && ak == player;
                PushNearbyJsonEntry(nearby, ak, player, isPlayer);
            }
            if (nearby.empty()) {
                webui_log::warn("SetNearbyActorsJson: no resolvable actors — keeping prior nearby list");
                return;
            }
            std::sort(nearby.begin(), nearby.end(), [](const nlohmann::json& a, const nlohmann::json& b) {
                const bool ap = a.value("isPlayer", false);
                const bool bp = b.value("isPlayer", false);
                if (ap != bp)
                    return ap && !bp;
                const int ar = a.value("sortRank", 2);
                const int br = b.value("sortRank", 2);
                if (ar != br)
                    return ar < br;
                return a.value("dist", 0.f) < b.value("dist", 0.f);
            });
            webui_log::info("SetNearbyActorsJson: tightened count={}", nearby.size());
            WebUI_Invoke("setNearbyActors(" + nearby.dump() + ");");
        } catch (...) {
            webui_log::warn("SetNearbyActorsJson: bad JSON — keeping prior nearby list");
        }
    }

    void PopulateNearbyActors(float radius)
    {
        if (radius > 0.f && SetNearbyRadius(radius)) {
            // updated
        } else if (radius > 0.f) {
            webui_log::warn("PopulateNearbyActors: invalid radius {}, keeping {}", radius, g_nearbyRadius);
        }

        auto* player = RE::PlayerCharacter::GetSingleton();
        if (player) {
            const auto formId = player->GetFormID();
            uint64_t playerUUID = PublicFormIDToUUID ? PublicFormIDToUUID(formId) : 0;
            const std::string uuidStr =
                playerUUID ? std::to_string(playerUUID) : std::to_string(static_cast<unsigned>(formId));
            std::string playerName = ActorDisplayNameLocal(player);
            WebUI_Invoke(std::format("setPlayerActor('{}', '{}', {});", uuidStr, EscapeJsString(playerName),
                static_cast<unsigned>(formId)));
        }

        if (!player) {
            WebUI_Invoke("setNearbyActors([]);");
            return;
        }

        const float radiusSq = g_nearbyRadius * g_nearbyRadius;
        const auto playerPos = player->GetPosition();
        std::vector<RE::Actor*> scanned;
        scanned.reserve(64);
        int considered = 0;

        auto addUnique = [&](RE::Actor* actor) {
            if (!actor || actor->IsDeleted())
                return;
            const auto id = actor->GetFormID();
            for (auto* existing : scanned) {
                if (existing && existing->GetFormID() == id)
                    return;
            }
            scanned.push_back(actor);
        };

        // Player always listed (status may grey them).
        addUnique(player);

        if (auto* lists = RE::ProcessLists::GetSingleton()) {
            lists->ForEachHighActor([&](RE::Actor* actor) {
                if (!actor || actor == player)
                    return RE::BSContainer::ForEachResult::kContinue;
                if (actor->IsDeleted())
                    return RE::BSContainer::ForEachResult::kContinue;
                ++considered;
                const float distSq = actor->GetPosition().GetSquaredDistance(playerPos);
                if (distSq > radiusSq)
                    return RE::BSContainer::ForEachResult::kContinue;
                addUnique(actor);
                return RE::BSContainer::ForEachResult::kContinue;
            });
        }

        // Keep current focus in the list even outside radius.
        if (Target_Current && Target_Current != player && !Target_Current->IsDeleted())
            addUnique(Target_Current);

        nlohmann::json nearby = nlohmann::json::array();
        for (auto* ak : scanned)
            PushNearbyJsonEntry(nearby, ak, player, ak == player);

        std::sort(nearby.begin(), nearby.end(), [](const nlohmann::json& a, const nlohmann::json& b) {
            const bool ap = a.value("isPlayer", false);
            const bool bp = b.value("isPlayer", false);
            if (ap != bp)
                return ap && !bp;
            const int ar = a.value("sortRank", 2);
            const int br = b.value("sortRank", 2);
            if (ar != br)
                return ar < br;
            return a.value("dist", 0.f) < b.value("dist", 0.f);
        });

        webui_log::info(
            "PopulateNearbyActors: radius={} considered={} listed={}",
            g_nearbyRadius, considered, scanned.size());

        WebUI_Invoke("setNearbyActors(" + nearby.dump() + ");");
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

    void DispatchAnimationMenuExportState(RE::TESForm* thread, RE::TESForm* sl_scene)
    {
        if (!thread || !sl_scene) {
            webui_log::warn("DispatchAnimationMenuExportState: null args");
            return;
        }

        SKSE::GetTaskInterface()->AddTask([thread, sl_scene]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("DispatchAnimationMenuExportState: no VM");
                return;
            }

            RE::TESQuest* quest = FindMainQuest();
            if (!quest) {
                webui_log::error("DispatchAnimationMenuExportState: quest not found");
                return;
            }

            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(sl_scene->GetFormType()), sl_scene);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Scene", scriptObject);
            if (!scriptObject) {
                webui_log::error("DispatchAnimationMenuExportState: Scene script not bound");
                return;
            }

            auto* args = RE::MakeFunctionArguments(static_cast<RE::TESForm*>(thread));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString("WebUI_ExportAnimationMenuState"), args,
                callback);
            webui_log::info("DispatchAnimationMenuExportState: dispatched");
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

    void HandleAnimDbResolveTags(const char* value)
    {
        if (!value)
            return;
        try {
            auto j = nlohmann::json::parse(value);
            const std::string request_id = j.value("_request_id", "");
            const std::string tags = j.value("_tags", "");
            const int actor_count = j.value("_actor_count", 0);
            const std::string resolved = AnimationDB::ResolveTags(tags, actor_count);
            nlohmann::json payload;
            payload["_request_id"] = request_id;
            payload["_resolved"] = resolved;
            payload["_ok"] = !resolved.empty() || tags.empty();
            std::string js = "animDbResolveTagsResult(" + payload.dump() + ");";
            WebUI_Invoke(js);
        } catch (...) {
            webui_log::warn("HandleAnimDbResolveTags: parse failed");
        }
    }

    void HandleNotify(const char* value)
    {
        if (!value)
            return;
        std::string msg;
        try {
            auto j = nlohmann::json::parse(value);
            msg = j.value("msg", "");
        } catch (...) {
            if (value[0] != '\0' && value[0] != '{')
                msg = value;
            else {
                webui_log::warn("HandleNotify: parse failed");
                return;
            }
        }
        if (msg.empty())
            return;

        std::string payload = std::move(msg);
        SKSE::GetTaskInterface()->AddTask([payload]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("HandleNotify: no VM");
                return;
            }
            RE::BSFixedString text(payload.c_str());
            auto* args = RE::MakeFunctionArguments(std::move(text));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            const bool ok = vm->DispatchStaticCall(
                RE::BSFixedString("Debug"),
                RE::BSFixedString("Notification"),
                args,
                callback);
            if (!ok)
                webui_log::warn("HandleNotify: DispatchStaticCall failed");
        });
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

    bool IsAvailableActor_Native(RE::StaticFunctionTag*, RE::Actor* actor)
    {
        return IsAvailableActor(actor);
    }

    bool IsSexLabAnimatingFocus(RE::Actor* actor)
    {
        return IsSexLabAnimatingActor(actor);
    }

    void Call_ControlActorFocus(RE::Actor* target)
    {
        if (!target) {
            webui_log::warn("Call_ControlActorFocus: null target");
            return;
        }
        SKSE::GetTaskInterface()->AddTask([target]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("Call_ControlActorFocus: no VM");
                return;
            }
            RE::TESQuest* quest = FindMainQuest();
            if (!quest) {
                webui_log::error("Call_ControlActorFocus: quest not found");
                return;
            }
            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, "SkyrimNet_SexLab_Menu", scriptObject);
            if (!scriptObject) {
                webui_log::error("Call_ControlActorFocus: Menu script not bound");
                return;
            }
            auto* args = RE::MakeFunctionArguments(static_cast<RE::Actor*>(target));
            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString("WebUI_OnControlActorFocus"), args, callback);
            webui_log::info("Call_ControlActorFocus: dispatched");
        });
    }

    void ApplyControlActorFocus(std::uint32_t formId)
    {
        if (!formId) {
            webui_log::warn("ApplyControlActorFocus: formId 0");
            return;
        }
        auto* actor = RE::TESForm::LookupByID<RE::Actor>(formId);
        if (!actor) {
            webui_log::warn("ApplyControlActorFocus: actor not found {:08X}", formId);
            return;
        }

        Target_Current = actor;
        TargetMenuSessionActive = true;

        const auto targetFormId = actor->GetFormID();
        uint64_t uuid = (PublicFormIDToUUID) ? PublicFormIDToUUID(targetFormId) : 0;
        std::string skyrimNetName = (uuid && PublicGetActorNameByUUID) ? PublicGetActorNameByUUID(uuid) : "";
        const char* targetName = !skyrimNetName.empty() ? skyrimNetName.c_str() : actor->GetName();
        const char* name = (targetName && targetName[0]) ? targetName : "Unknown";
        const std::string uuidStr =
            uuid ? std::to_string(uuid) : std::to_string(static_cast<unsigned>(targetFormId));
        WebUI_Invoke(std::format("setTargetActor('{}', '{}', {});", uuidStr, EscapeJsString(name),
            static_cast<unsigned>(targetFormId)));

        Call_ControlActorFocus(actor);
    }

    void WebUI_AfterTargetOpen(RE::StaticFunctionTag*, RE::Actor* preferred, bool preferExplicit)
    {
        const unsigned fid =
            (preferExplicit && preferred) ? static_cast<unsigned>(preferred->GetFormID()) : 0u;
        WebUI_Invoke(std::format("selectControlActorDefault({});", fid));
    }

    void WebUI_MaybeRestoreAnimationPanel(RE::StaticFunctionTag*)
    {
        if (!Target_Current || !IsSexLabAnimatingActor(Target_Current))
            return;
        if (!ActionCatalog::IsAnimationPanelPreferredOpen())
            return;
        webui_log::info("WebUI_MaybeRestoreAnimationPanel: restoring Animation panel");
        ActionCatalog::SwitchMainPanel("animation_menu_panel");
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
        a_vm->RegisterFunction("SceneCreator_Configure", scriptName, SceneCreator_Configure);
        a_vm->RegisterFunction("Animation_Menu_Open", scriptName, Animation_Menu_Open);
        a_vm->RegisterFunction("Animation_Menu_Show", scriptName, Animation_Menu_Show);
        a_vm->RegisterFunction("Animation_Menu_Configure", scriptName, Animation_Menu_Configure);
        a_vm->RegisterFunction("SceneConnections_Show", scriptName, SceneConnections_Show);
        a_vm->RegisterFunction("WebUI_HideAllPanels", scriptName, WebUI_HideAllPanels);
        a_vm->RegisterFunction("WebUI_SetHotkey", scriptName, WebUI_SetHotkey);
        a_vm->RegisterFunction("WebUI_AfterTargetOpen", scriptName, WebUI_AfterTargetOpen);
        a_vm->RegisterFunction("WebUI_MaybeRestoreAnimationPanel", scriptName, WebUI_MaybeRestoreAnimationPanel);
        a_vm->RegisterFunction("WebUI_SetLastRebuildTimestamp", scriptName, WebUI_SetLastRebuildTimestamp);
        a_vm->RegisterFunction("ActorAnimMeta_Result", scriptName, ActorAnimMeta_Result);
        a_vm->RegisterFunction("ConsumeSkipSceneCreator", scriptName, ConsumeSkipSceneCreator);
        a_vm->RegisterFunction("TraceLog", scriptName, TraceLog);
        a_vm->RegisterFunction("SetNearbyActorsJson", scriptName, SetNearbyActorsJson);
        a_vm->RegisterFunction("IsAvailableActor", scriptName, IsAvailableActor_Native);

        webui_log::info("Successfully registered Papyrus functions for {}", scriptName);
        return true;
    }
}
