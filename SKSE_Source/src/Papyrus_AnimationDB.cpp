#include "Papyrus_AnimationDB.h"
#include "AnimationDB.h"
#include "WebUI_Log.h"

#include <nlohmann/json.hpp>

namespace PapyrusBindings_AnimationDB
{
    namespace
    {
        AnimationDB::FilterSpec ParseFilter(const char* json)
        {
            AnimationDB::FilterSpec spec;
            if (!json || !json[0])
                return spec;
            try {
                auto j = nlohmann::json::parse(json);
                if (j.contains("_actor_count") && j["_actor_count"].is_number())
                    spec.actor_count = j["_actor_count"].get<int>();
                else if (j.contains("actor_count") && j["actor_count"].is_number())
                    spec.actor_count = j["actor_count"].get<int>();

                auto read_tags = [&](const char* k1, const char* k2, std::vector<std::string>& out) {
                    const nlohmann::json* arr = nullptr;
                    if (j.contains(k1) && j[k1].is_array())
                        arr = &j[k1];
                    else if (j.contains(k2) && j[k2].is_array())
                        arr = &j[k2];
                    if (!arr)
                        return;
                    for (const auto& el : *arr) {
                        if (el.is_string())
                            out.push_back(AnimationDB::ToLower(el.get<std::string>()));
                    }
                };
                read_tags("_must_tags", "must_tags", spec.must_tags);
                read_tags("_suppress_tags", "suppress_tags", spec.suppress_tags);

                if (j.contains("_require_all") && j["_require_all"].is_boolean())
                    spec.require_all = j["_require_all"].get<bool>();
                else if (j.contains("require_all") && j["require_all"].is_boolean())
                    spec.require_all = j["require_all"].get<bool>();
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
                else if (j.contains("has_description") && j["has_description"].is_boolean())
                    spec.has_description = j["has_description"].get<bool>();
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
                webui_log::warn("AnimationDB: bad filter JSON");
            }
            return spec;
        }

        nlohmann::json RowToJson(const AnimationDB::AnimRow& row)
        {
            nlohmann::json j;
            j["_registry"] = row.registry;
            j["_name"] = row.name;
            j["_enabled"] = row.enabled;
            j["_source"] = row.source;
            j["_position_count"] = row.position_count;
            j["_stage_count"] = row.stage_count;
            j["_has_creature"] = row.has_creature;
            j["_race_type"] = row.race_type;
            j["_pos_genders"] = row.pos_genders;
            j["_pos_race_keys"] = row.pos_race_keys;
            j["_tags"] = row.tags;
            j["_pos_no_orgasm"] = row.pos_no_orgasm;
            j["_pos_speaking_modifiers"] = row.pos_speaking_modifiers;
            j["_stage_has_description"] = row.stage_has_description;
            nlohmann::json sd = nlohmann::json::object();
            for (const auto& [k, v] : row.stage_descriptions)
                sd[std::to_string(k)] = v;
            j["_stage_descriptions"] = sd;
            return j;
        }
    }

    void AnimDb_Open(RE::StaticFunctionTag*)
    {
        AnimationDB::Open();
    }

    std::int32_t AnimDb_BeginSync(RE::StaticFunctionTag*, bool force_rebuild)
    {
        return static_cast<std::int32_t>(AnimationDB::BeginSync(force_rebuild));
    }

    std::int32_t AnimDb_PushAnimBatch(RE::StaticFunctionTag*, RE::BSFixedString json)
    {
        const char* raw = json.c_str() ? json.c_str() : "";
        try {
            auto j = nlohmann::json::parse(raw);
            return AnimationDB::PushAnimBatch(j);
        } catch (...) {
            webui_log::warn("AnimDb_PushAnimBatch: parse failed");
            return 0;
        }
    }

    bool AnimDb_EndSync(RE::StaticFunctionTag*)
    {
        return AnimationDB::EndSync();
    }

    RE::BSFixedString AnimDb_QueryTopNAnims(RE::StaticFunctionTag*, RE::BSFixedString filter_json,
        std::int32_t n)
    {
        auto spec = ParseFilter(filter_json.c_str());
        auto rows = AnimationDB::QueryTopNAnims(spec, n);
        nlohmann::json arr = nlohmann::json::array();
        for (const auto& row : rows)
            arr.push_back(RowToJson(row));
        return RE::BSFixedString(arr.dump());
    }

    RE::BSFixedString AnimDb_QueryTopNTags(RE::StaticFunctionTag*, RE::BSFixedString filter_json,
        std::int32_t n)
    {
        auto spec = ParseFilter(filter_json.c_str());
        auto tags = AnimationDB::QueryTopNTags(spec, n);
        nlohmann::json arr = nlohmann::json::array();
        for (const auto& t : tags) {
            nlohmann::json o;
            o["_tag"] = t.tag;
            o["_count"] = t.count;
            arr.push_back(o);
        }
        return RE::BSFixedString(arr.dump());
    }

    std::int32_t AnimDb_TotalEnabled(RE::StaticFunctionTag*)
    {
        return AnimationDB::TotalEnabledCount();
    }

    std::int32_t AnimDb_TotalCount(RE::StaticFunctionTag*)
    {
        return AnimationDB::TotalCount();
    }

    RE::BSFixedString AnimDb_GetByRegistry(RE::StaticFunctionTag*, RE::BSFixedString registry)
    {
        auto row = AnimationDB::GetByRegistry(registry.c_str() ? registry.c_str() : "");
        if (!row)
            return RE::BSFixedString("");
        return RE::BSFixedString(RowToJson(*row).dump());
    }

    RE::BSFixedString AnimDb_GetStageDescription(RE::StaticFunctionTag*, RE::BSFixedString registry,
        std::int32_t stage)
    {
        return RE::BSFixedString(
            AnimationDB::GetStageDescription(registry.c_str() ? registry.c_str() : "", stage));
    }

    RE::BSFixedString AnimDb_SubstituteActors(RE::StaticFunctionTag*, RE::BSFixedString desc,
        RE::BSFixedString actors_json)
    {
        std::vector<std::string> names;
        try {
            auto j = nlohmann::json::parse(actors_json.c_str() ? actors_json.c_str() : "[]");
            if (j.is_array()) {
                for (const auto& el : j) {
                    if (el.is_string())
                        names.push_back(el.get<std::string>());
                }
            }
        } catch (...) {
        }
        return RE::BSFixedString(
            AnimationDB::SubstituteActors(desc.c_str() ? desc.c_str() : "", names));
    }

    bool AnimDb_SaveAnimLocal(RE::StaticFunctionTag*, RE::BSFixedString registry, RE::BSFixedString json)
    {
        try {
            auto j = nlohmann::json::parse(json.c_str() ? json.c_str() : "{}");
            return AnimationDB::SaveAnimLocal(registry.c_str() ? registry.c_str() : "", j);
        } catch (...) {
            return false;
        }
    }

    RE::BSFixedString AnimDb_ResolveTags(RE::StaticFunctionTag*, RE::BSFixedString tags_csv,
        std::int32_t actor_count)
    {
        return RE::BSFixedString(
            AnimationDB::ResolveTags(tags_csv.c_str() ? tags_csv.c_str() : "", actor_count));
    }

    bool AnimDb_CsvHasTag(RE::StaticFunctionTag*, RE::BSFixedString tags_csv, RE::BSFixedString tag)
    {
        return AnimationDB::CsvHasTag(
            tags_csv.c_str() ? tags_csv.c_str() : "",
            tag.c_str() ? tag.c_str() : "");
    }

    bool Register_AnimationDB_Functions(RE::BSScript::IVirtualMachine* a_vm)
    {
        if (!a_vm) {
            webui_log::error("Couldn't get Papyrus Virtual Machine.");
            return false;
        }
        constexpr std::string_view scriptName = "SkyrimNet_SexLab_AnimDb";

        a_vm->RegisterFunction("AnimDb_Open", scriptName, AnimDb_Open);
        a_vm->RegisterFunction("AnimDb_BeginSync", scriptName, AnimDb_BeginSync);
        a_vm->RegisterFunction("AnimDb_PushAnimBatch", scriptName, AnimDb_PushAnimBatch);
        a_vm->RegisterFunction("AnimDb_EndSync", scriptName, AnimDb_EndSync);
        a_vm->RegisterFunction("AnimDb_QueryTopNAnims", scriptName, AnimDb_QueryTopNAnims);
        a_vm->RegisterFunction("AnimDb_QueryTopNTags", scriptName, AnimDb_QueryTopNTags);
        a_vm->RegisterFunction("AnimDb_TotalEnabled", scriptName, AnimDb_TotalEnabled);
        a_vm->RegisterFunction("AnimDb_TotalCount", scriptName, AnimDb_TotalCount);
        a_vm->RegisterFunction("AnimDb_GetByRegistry", scriptName, AnimDb_GetByRegistry);
        a_vm->RegisterFunction("AnimDb_GetStageDescription", scriptName, AnimDb_GetStageDescription);
        a_vm->RegisterFunction("AnimDb_SubstituteActors", scriptName, AnimDb_SubstituteActors);
        a_vm->RegisterFunction("AnimDb_SaveAnimLocal", scriptName, AnimDb_SaveAnimLocal);
        a_vm->RegisterFunction("AnimDb_ResolveTags", scriptName, AnimDb_ResolveTags);
        a_vm->RegisterFunction("AnimDb_CsvHasTag", scriptName, AnimDb_CsvHasTag);

        webui_log::info("Successfully registered Papyrus functions for {}", scriptName);
        return true;
    }
}
