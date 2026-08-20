#pragma once

#include <cstdint>
#include <filesystem>
#include <mutex>
#include <optional>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include <nlohmann/json.hpp>

namespace AnimationDB
{
    struct AnimRow
    {
        std::string registry;
        std::string name;
        int enabled = 1;
        int source = 0;
        int position_count = 0;
        int stage_count = 0;
        int males = 0;
        int females = 0;
        int male_creatures = 0;
        int female_creatures = 0;
        int has_creature = 0;
        std::string race_type;
        std::vector<int> pos_genders;
        std::vector<std::string> pos_race_keys;
        std::vector<std::string> tags;
        std::vector<int> pos_no_orgasm;
        std::vector<std::string> pos_speaking_modifiers; // CSV-per-position (stage 1 resolved; Papyrus compat)
        std::vector<int> pos_clothed;                    // 0/1 per position (stage 1 resolved)
        std::unordered_map<int, std::string> stage_descriptions; // resolved (carry-forward)
        std::vector<int> stage_has_description;
        /// Per-stage resolved speaking: stage → vector of CSV strings (one per actor).
        std::unordered_map<int, std::vector<std::string>> stage_speaking;
        /// Per-stage resolved clothed: stage → 0/1 per actor.
        std::unordered_map<int, std::vector<int>> stage_clothed;
        /// Per-stage resolved SNSL tags: stage → tag list.
        std::unordered_map<int, std::vector<std::string>> stage_tags;
        nlohmann::json transitions = nlohmann::json::object();
        std::vector<std::string> file_tags; // SNSL animation-level tags (not SexLab registry tags)
        std::string creator;
        std::int64_t sync_gen = 0;
    };

    struct FilterSpec
    {
        std::optional<int> actor_count;
        std::vector<std::string> must_tags;
        std::vector<std::string> suppress_tags;
        bool require_all = true;
        int creature = 0;
        bool enabled_only = true;
        bool position_match = false;
        std::vector<int> pos_genders;
        std::vector<std::string> pos_race_keys;
        bool has_description = false;
        bool gender_match = false;
        int males = -1;
        int females = -1;
        int male_creatures = -1;
        int female_creatures = -1;
    };

    struct TagCount
    {
        std::string tag;
        int count = 0;
    };

    bool Open();
    void Close();
    bool IsOpen();

    std::int64_t BeginSync(bool force_rebuild);
    bool PushAnim(const nlohmann::json& anim);
    int PushAnimBatch(const nlohmann::json& arr);
    bool EndSync();

    std::vector<AnimRow> QueryTopNAnims(const FilterSpec& spec, int n);
    std::vector<TagCount> QueryTopNTags(const FilterSpec& spec, int n);
    int TotalEnabledCount();
    int TotalCount();

    std::optional<AnimRow> GetByRegistry(const std::string& registry);
    std::string GetStageDescription(const std::string& registry, int stage);
    std::string GetTransition(const std::string& registry, int from_stage, int to_stage);
    std::string SubstituteActors(const std::string& desc, const std::vector<std::string>& actor_names);
    bool SaveAnimLocal(const std::string& registry, const nlohmann::json& payload);

    std::vector<int> InferOrgasmExpected(int position_count, const std::vector<int>& pos_genders,
        const std::unordered_set<std::string>& tags,
        const std::optional<std::vector<int>>& file_override);

    void InferSpeakingModifiers(const std::vector<int>& pos_no_orgasm,
        const std::unordered_set<std::string>& tags,
        std::vector<std::string>& out_csv_per_pos);

    std::string ToLower(std::string s);
    /// Sanitize aliases + lowercase; empty if blank after trim.
    std::string SanitizeTag(std::string tag);
    /// Split CSV, sanitize each, dedupe preserving order.
    std::vector<std::string> ParseSanitizeTagsCsv(const std::string& csv);
    /// Largest front-preferring subset matching ≥1 enabled anim. Empty input → "". actor_count≤0 ignores count.
    std::string ResolveTags(const std::string& tags_csv, int actor_count);
    /// True if needle (sanitized) is an element of tags_csv (sanitized elements).
    bool CsvHasTag(const std::string& tags_csv, const std::string& tag);

    std::filesystem::path PluginDataDir();
}
