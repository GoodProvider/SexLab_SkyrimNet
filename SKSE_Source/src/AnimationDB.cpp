#include "AnimationDB.h"
#include "WebUI_Log.h"

#include <Windows.h>
#include <sqlite3.h>

#include <algorithm>
#include <cctype>
#include <fstream>
#include <sstream>

namespace AnimationDB
{
    namespace
    {
        std::recursive_mutex g_mutex;
        sqlite3* g_db = nullptr;
        std::int64_t g_sync_gen = 0;
        bool g_force_rebuild = false;
        std::unordered_map<std::string, AnimRow> g_rows;
        std::unordered_map<std::string, std::unordered_set<std::string>> g_tag_to_regs;

        std::string JsonDump(const nlohmann::json& j)
        {
            return j.dump();
        }

        nlohmann::json VecIntToJson(const std::vector<int>& v)
        {
            return nlohmann::json(v);
        }

        nlohmann::json VecStrToJson(const std::vector<std::string>& v)
        {
            return nlohmann::json(v);
        }

        std::vector<int> JsonToVecInt(const nlohmann::json& j)
        {
            std::vector<int> out;
            if (!j.is_array())
                return out;
            for (const auto& el : j) {
                if (el.is_number_integer())
                    out.push_back(el.get<int>());
                else if (el.is_number())
                    out.push_back(static_cast<int>(el.get<double>()));
            }
            return out;
        }

        std::vector<std::string> JsonToVecStr(const nlohmann::json& j)
        {
            std::vector<std::string> out;
            if (!j.is_array())
                return out;
            for (const auto& el : j) {
                if (el.is_string())
                    out.push_back(ToLower(el.get<std::string>()));
            }
            return out;
        }

        std::string TagsCsv(const std::vector<std::string>& tags)
        {
            std::ostringstream oss;
            for (size_t i = 0; i < tags.size(); ++i) {
                if (i)
                    oss << ',';
                oss << tags[i];
            }
            return oss.str();
        }

        std::vector<std::string> SplitCsv(const std::string& csv)
        {
            std::vector<std::string> out;
            std::string cur;
            auto flush = [&]() {
                // trim
                size_t b = 0;
                while (b < cur.size() && (cur[b] == ' ' || cur[b] == '\t'))
                    ++b;
                size_t e = cur.size();
                while (e > b && (cur[e - 1] == ' ' || cur[e - 1] == '\t'))
                    --e;
                if (e > b)
                    out.push_back(ToLower(cur.substr(b, e - b)));
                cur.clear();
            };
            for (char c : csv) {
                if (c == ',')
                    flush();
                else
                    cur.push_back(c);
            }
            flush();
            return out;
        }

        bool Exec(const char* sql)
        {
            char* err = nullptr;
            if (sqlite3_exec(g_db, sql, nullptr, nullptr, &err) != SQLITE_OK) {
                webui_log::error("AnimationDB SQL: {}", err ? err : "unknown");
                sqlite3_free(err);
                return false;
            }
            return true;
        }

        bool MigrateSchema()
        {
            const char* ddl = R"SQL(
CREATE TABLE IF NOT EXISTS animations (
  registry TEXT PRIMARY KEY,
  name TEXT,
  enabled INTEGER,
  source INTEGER,
  position_count INTEGER,
  stage_count INTEGER,
  males INTEGER,
  females INTEGER,
  male_creatures INTEGER,
  female_creatures INTEGER,
  has_creature INTEGER,
  race_type TEXT,
  pos_genders TEXT,
  pos_race_keys TEXT,
  tags TEXT,
  pos_no_orgasm TEXT,
  pos_speaking_modifiers TEXT,
  stage_descriptions TEXT,
  stage_has_description TEXT,
  sync_gen INTEGER
);
CREATE TABLE IF NOT EXISTS animation_tags (
  registry TEXT,
  tag TEXT,
  PRIMARY KEY (registry, tag)
);
CREATE TABLE IF NOT EXISTS meta (
  key TEXT PRIMARY KEY,
  value TEXT
);
CREATE INDEX IF NOT EXISTS idx_anim_tags_tag ON animation_tags(tag);
)SQL";
            return Exec(ddl);
        }

        void RebuildTagIndexLocked()
        {
            g_tag_to_regs.clear();
            for (const auto& [reg, row] : g_rows) {
                for (const auto& tag : row.tags)
                    g_tag_to_regs[tag].insert(reg);
            }
        }

        void LoadAllRowsLocked()
        {
            g_rows.clear();
            sqlite3_stmt* stmt = nullptr;
            const char* sql =
                "SELECT registry,name,enabled,source,position_count,stage_count,males,females,"
                "male_creatures,female_creatures,has_creature,race_type,pos_genders,pos_race_keys,"
                "tags,pos_no_orgasm,pos_speaking_modifiers,stage_descriptions,stage_has_description,sync_gen "
                "FROM animations";
            if (sqlite3_prepare_v2(g_db, sql, -1, &stmt, nullptr) != SQLITE_OK)
                return;
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                AnimRow row;
                auto col = [&](int i) -> std::string {
                    const unsigned char* t = sqlite3_column_text(stmt, i);
                    return t ? reinterpret_cast<const char*>(t) : "";
                };
                row.registry = col(0);
                row.name = col(1);
                row.enabled = sqlite3_column_int(stmt, 2);
                row.source = sqlite3_column_int(stmt, 3);
                row.position_count = sqlite3_column_int(stmt, 4);
                row.stage_count = sqlite3_column_int(stmt, 5);
                row.males = sqlite3_column_int(stmt, 6);
                row.females = sqlite3_column_int(stmt, 7);
                row.male_creatures = sqlite3_column_int(stmt, 8);
                row.female_creatures = sqlite3_column_int(stmt, 9);
                row.has_creature = sqlite3_column_int(stmt, 10);
                row.race_type = col(11);
                try {
                    row.pos_genders = JsonToVecInt(nlohmann::json::parse(col(12).empty() ? "[]" : col(12)));
                    row.pos_race_keys = JsonToVecStr(nlohmann::json::parse(col(13).empty() ? "[]" : col(13)));
                } catch (...) {
                }
                row.tags = SplitCsv(col(14));
                try {
                    row.pos_no_orgasm = JsonToVecInt(nlohmann::json::parse(col(15).empty() ? "[]" : col(15)));
                    row.pos_speaking_modifiers = JsonToVecStr(nlohmann::json::parse(col(16).empty() ? "[]" : col(16)));
                    auto sd = nlohmann::json::parse(col(17).empty() ? "{}" : col(17));
                    if (sd.is_object()) {
                        for (auto it = sd.begin(); it != sd.end(); ++it) {
                            if (it.value().is_string()) {
                                try {
                                    row.stage_descriptions[std::stoi(it.key())] = it.value().get<std::string>();
                                } catch (...) {
                                }
                            }
                        }
                    }
                    row.stage_has_description =
                        JsonToVecInt(nlohmann::json::parse(col(18).empty() ? "[]" : col(18)));
                } catch (...) {
                }
                row.sync_gen = sqlite3_column_int64(stmt, 19);
                g_rows[row.registry] = std::move(row);
            }
            sqlite3_finalize(stmt);
            RebuildTagIndexLocked();
        }

        void UpsertRowLocked(const AnimRow& row)
        {
            sqlite3_stmt* stmt = nullptr;
            const char* sql =
                "INSERT INTO animations(registry,name,enabled,source,position_count,stage_count,males,females,"
                "male_creatures,female_creatures,has_creature,race_type,pos_genders,pos_race_keys,tags,"
                "pos_no_orgasm,pos_speaking_modifiers,stage_descriptions,stage_has_description,sync_gen) "
                "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) "
                "ON CONFLICT(registry) DO UPDATE SET "
                "name=excluded.name,enabled=excluded.enabled,source=excluded.source,"
                "position_count=excluded.position_count,stage_count=excluded.stage_count,"
                "males=excluded.males,females=excluded.females,male_creatures=excluded.male_creatures,"
                "female_creatures=excluded.female_creatures,has_creature=excluded.has_creature,"
                "race_type=excluded.race_type,pos_genders=excluded.pos_genders,"
                "pos_race_keys=excluded.pos_race_keys,tags=excluded.tags,"
                "pos_no_orgasm=excluded.pos_no_orgasm,pos_speaking_modifiers=excluded.pos_speaking_modifiers,"
                "stage_descriptions=excluded.stage_descriptions,"
                "stage_has_description=excluded.stage_has_description,sync_gen=excluded.sync_gen";
            if (sqlite3_prepare_v2(g_db, sql, -1, &stmt, nullptr) != SQLITE_OK)
                return;

            nlohmann::json stage_desc = nlohmann::json::object();
            for (const auto& [k, v] : row.stage_descriptions)
                stage_desc[std::to_string(k)] = v;

            int i = 1;
            auto bind_text = [&](const std::string& s) {
                sqlite3_bind_text(stmt, i++, s.c_str(), -1, SQLITE_TRANSIENT);
            };
            bind_text(row.registry);
            bind_text(row.name);
            sqlite3_bind_int(stmt, i++, row.enabled);
            sqlite3_bind_int(stmt, i++, row.source);
            sqlite3_bind_int(stmt, i++, row.position_count);
            sqlite3_bind_int(stmt, i++, row.stage_count);
            sqlite3_bind_int(stmt, i++, row.males);
            sqlite3_bind_int(stmt, i++, row.females);
            sqlite3_bind_int(stmt, i++, row.male_creatures);
            sqlite3_bind_int(stmt, i++, row.female_creatures);
            sqlite3_bind_int(stmt, i++, row.has_creature);
            bind_text(row.race_type);
            bind_text(JsonDump(VecIntToJson(row.pos_genders)));
            bind_text(JsonDump(VecStrToJson(row.pos_race_keys)));
            bind_text(TagsCsv(row.tags));
            bind_text(JsonDump(VecIntToJson(row.pos_no_orgasm)));
            bind_text(JsonDump(VecStrToJson(row.pos_speaking_modifiers)));
            bind_text(JsonDump(stage_desc));
            bind_text(JsonDump(VecIntToJson(row.stage_has_description)));
            sqlite3_bind_int64(stmt, i++, row.sync_gen);
            sqlite3_step(stmt);
            sqlite3_finalize(stmt);

            sqlite3_exec(g_db, ("DELETE FROM animation_tags WHERE registry='" + row.registry + "'").c_str(),
                nullptr, nullptr, nullptr);
            for (const auto& tag : row.tags) {
                sqlite3_stmt* tstmt = nullptr;
                if (sqlite3_prepare_v2(g_db, "INSERT OR IGNORE INTO animation_tags(registry,tag) VALUES(?,?)",
                        -1, &tstmt, nullptr) == SQLITE_OK) {
                    sqlite3_bind_text(tstmt, 1, row.registry.c_str(), -1, SQLITE_TRANSIENT);
                    sqlite3_bind_text(tstmt, 2, tag.c_str(), -1, SQLITE_TRANSIENT);
                    sqlite3_step(tstmt);
                    sqlite3_finalize(tstmt);
                }
            }
            g_rows[row.registry] = row;
        }

        void LoadAnimJsonForName(const std::string& display_name, AnimRow& row,
            std::optional<std::vector<int>>& orgasm_override)
        {
            auto root = PluginDataDir() / "animations";
            if (!std::filesystem::is_directory(root))
                return;

            std::vector<std::filesystem::path> packs;
            std::filesystem::path local_pack;
            for (const auto& ent : std::filesystem::directory_iterator(root)) {
                if (!ent.is_directory())
                    continue;
                auto name = ent.path().filename().string();
                if (name == "_local_")
                    local_pack = ent.path();
                else
                    packs.push_back(ent.path());
            }
            if (!local_pack.empty())
                packs.push_back(local_pack); // last wins

            const std::string fname = display_name + ".json";
            nlohmann::json merged = nlohmann::json::object();
            for (const auto& pack : packs) {
                auto path = pack / fname;
                if (!std::filesystem::exists(path))
                    continue;
                try {
                    std::ifstream in(path);
                    nlohmann::json info = nlohmann::json::parse(in);
                    if (!info.is_object())
                        continue;
                    for (auto it = info.begin(); it != info.end(); ++it)
                        merged[it.key()] = it.value();
                } catch (...) {
                }
            }

            row.stage_descriptions.clear();
            for (auto it = merged.begin(); it != merged.end(); ++it) {
                std::string key = it.key();
                std::string key_l = ToLower(key);
                if (key_l == "orgasm_expected") {
                    if (it.value().is_array()) {
                        std::vector<int> ov;
                        for (const auto& el : it.value()) {
                            if (el.is_number_integer())
                                ov.push_back(el.get<int>());
                            else if (el.is_number())
                                ov.push_back(static_cast<int>(el.get<double>()));
                        }
                        if (static_cast<int>(ov.size()) == row.position_count)
                            orgasm_override = ov;
                    }
                    continue;
                }
                // "stage 1" / "Stage 1"
                if (key_l.rfind("stage", 0) == 0) {
                    int stage = 0;
                    try {
                        auto sp = key.find_first_of("0123456789");
                        if (sp != std::string::npos)
                            stage = std::stoi(key.substr(sp));
                    } catch (...) {
                        continue;
                    }
                    if (stage < 1)
                        continue;
                    std::string desc;
                    if (it.value().is_object() && it.value().contains("description") &&
                        it.value()["description"].is_string())
                        desc = it.value()["description"].get<std::string>();
                    else if (it.value().is_string())
                        desc = it.value().get<std::string>();
                    row.stage_descriptions[stage] = desc;
                }
            }
            row.stage_has_description.assign(std::max(0, row.stage_count), 0);
            for (int s = 1; s <= row.stage_count; ++s) {
                auto it = row.stage_descriptions.find(s);
                if (it != row.stage_descriptions.end() && !it->second.empty())
                    row.stage_has_description[s - 1] = 1;
            }
        }

        bool HasTag(const std::unordered_set<std::string>& tags, const char* t)
        {
            return tags.contains(t);
        }

        bool MatchesFilter(const AnimRow& row, const FilterSpec& spec)
        {
            if (spec.enabled_only && !row.enabled)
                return false;
            if (spec.actor_count && row.position_count != *spec.actor_count)
                return false;
            if (spec.creature == 1 && !row.has_creature)
                return false;
            if (spec.creature == 2 && row.has_creature)
                return false;

            std::unordered_set<std::string> tagset(row.tags.begin(), row.tags.end());
            for (const auto& s : spec.suppress_tags) {
                if (tagset.contains(ToLower(s)))
                    return false;
            }
            if (!spec.must_tags.empty()) {
                if (spec.require_all) {
                    for (const auto& m : spec.must_tags) {
                        if (!tagset.contains(ToLower(m)))
                            return false;
                    }
                } else {
                    bool any = false;
                    for (const auto& m : spec.must_tags) {
                        if (tagset.contains(ToLower(m))) {
                            any = true;
                            break;
                        }
                    }
                    if (!any)
                        return false;
                }
            }

            if (spec.position_match) {
                if (static_cast<int>(spec.pos_genders.size()) != row.position_count)
                    return false;
                for (int i = 0; i < row.position_count; ++i) {
                    if (i >= static_cast<int>(row.pos_genders.size()) ||
                        row.pos_genders[i] != spec.pos_genders[i])
                        return false;
                    if (i < static_cast<int>(spec.pos_race_keys.size()) &&
                        !spec.pos_race_keys[i].empty()) {
                        std::string want = ToLower(spec.pos_race_keys[i]);
                        std::string have =
                            i < static_cast<int>(row.pos_race_keys.size()) ? row.pos_race_keys[i] : "";
                        if (have != want)
                            return false;
                    }
                }
            }

            if (spec.gender_match) {
                if (spec.males >= 0 && row.males != spec.males)
                    return false;
                if (spec.females >= 0 && row.females != spec.females)
                    return false;
                if (spec.male_creatures >= 0 && row.male_creatures != spec.male_creatures)
                    return false;
                if (spec.female_creatures >= 0 && row.female_creatures != spec.female_creatures)
                    return false;
            }

            if (spec.has_description) {
                bool any = false;
                for (int v : row.stage_has_description) {
                    if (v != 0) {
                        any = true;
                        break;
                    }
                }
                if (!any) {
                    for (const auto& [_, desc] : row.stage_descriptions) {
                        if (!desc.empty()) {
                            any = true;
                            break;
                        }
                    }
                }
                if (!any)
                    return false;
            }
            return true;
        }

        nlohmann::json GetJsonField(const nlohmann::json& j, const char* key)
        {
            if (j.contains(key))
                return j[key];
            std::string alt = key;
            if (!alt.empty() && alt[0] == '_') {
                // also try without underscore
            }
            return nlohmann::json();
        }
    }

    std::string ToLower(std::string s)
    {
        std::transform(s.begin(), s.end(), s.begin(),
            [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
        return s;
    }

    std::string SanitizeTag(std::string tag)
    {
        tag = ToLower(std::move(tag));
        // trim
        size_t b = 0;
        while (b < tag.size() && (tag[b] == ' ' || tag[b] == '\t'))
            ++b;
        size_t e = tag.size();
        while (e > b && (tag[e - 1] == ' ' || tag[e - 1] == '\t'))
            --e;
        if (e <= b)
            return {};
        tag = tag.substr(b, e - b);
        if (tag == "pussy")
            return "vaginal";
        if (tag == "mouth" || tag == "tongue")
            return "oral";
        if (tag == "ass")
            return "anal";
        if (tag == "whipping")
            return "whip";
        if (tag == "hugging")
            return "hug";
        if (tag == "cuddle")
            return "cuddling";
        if (tag == "single hug")
            return "hug";
        return tag;
    }

    std::vector<std::string> ParseSanitizeTagsCsv(const std::string& csv)
    {
        std::vector<std::string> out;
        std::unordered_set<std::string> seen;
        for (const auto& raw : SplitCsv(csv)) {
            std::string t = SanitizeTag(raw);
            if (t.empty() || seen.contains(t))
                continue;
            seen.insert(t);
            out.push_back(std::move(t));
        }
        return out;
    }

    namespace
    {
        bool AnyAnimHasAllTagsLocked(const std::vector<std::string>& must, int actor_count)
        {
            FilterSpec spec;
            spec.must_tags = must;
            spec.require_all = true;
            spec.enabled_only = true;
            if (actor_count > 0)
                spec.actor_count = actor_count;
            for (const auto& [_, row] : g_rows) {
                if (MatchesFilter(row, spec))
                    return true;
            }
            return false;
        }
    }

    std::string ResolveTags(const std::string& tags_csv, int actor_count)
    {
        auto tags = ParseSanitizeTagsCsv(tags_csv);
        if (tags.empty())
            return {};

        std::lock_guard lock(g_mutex);
        const int n = static_cast<int>(tags.size());
        // Largest subset first; within size, lex combinations prefer earlier indices.
        for (int k = n; k >= 1; --k) {
            std::vector<int> idx(static_cast<size_t>(k));
            for (int i = 0; i < k; ++i)
                idx[static_cast<size_t>(i)] = i;
            while (true) {
                std::vector<std::string> subset;
                subset.reserve(static_cast<size_t>(k));
                for (int i : idx)
                    subset.push_back(tags[static_cast<size_t>(i)]);
                if (AnyAnimHasAllTagsLocked(subset, actor_count))
                    return TagsCsv(subset);

                // next combination in lex order
                int t = k - 1;
                while (t >= 0 && idx[static_cast<size_t>(t)] == n - k + t)
                    --t;
                if (t < 0)
                    break;
                ++idx[static_cast<size_t>(t)];
                for (int j = t + 1; j < k; ++j)
                    idx[static_cast<size_t>(j)] = idx[static_cast<size_t>(j - 1)] + 1;
            }
        }
        return {};
    }

    bool CsvHasTag(const std::string& tags_csv, const std::string& tag)
    {
        const std::string needle = SanitizeTag(tag);
        if (needle.empty())
            return false;
        for (const auto& t : ParseSanitizeTagsCsv(tags_csv)) {
            if (t == needle)
                return true;
        }
        return false;
    }

    std::filesystem::path PluginDataDir()
    {
        HMODULE hm = nullptr;
        if (GetModuleHandleExW(
                GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                reinterpret_cast<LPCWSTR>(&PluginDataDir), &hm)) {
            wchar_t buf[MAX_PATH]{};
            if (GetModuleFileNameW(hm, buf, MAX_PATH)) {
                auto p = std::filesystem::path(buf).parent_path() / "SkyrimNet_SexLab";
                if (std::filesystem::is_directory(p) || true)
                    return p;
            }
        }
        return std::filesystem::current_path() / "Data" / "SKSE" / "Plugins" / "SkyrimNet_SexLab";
    }

    std::vector<int> InferOrgasmExpected(int position_count, const std::vector<int>& pos_genders,
        const std::unordered_set<std::string>& tags,
        const std::optional<std::vector<int>>& file_override)
    {
        if (file_override && static_cast<int>(file_override->size()) == position_count)
            return *file_override;

        std::vector<int> out(std::max(0, position_count), 1);
        if (position_count > 2)
            return out;

        for (int i = 0; i < position_count; ++i) {
            int gender = i < static_cast<int>(pos_genders.size()) ? pos_genders[i] : 0;
            bool has_pussy = gender == 1 || gender == 3;
            bool has_penis = gender == 0 || gender == 2;

            if (HasTag(tags, "estrus")) {
                out[i] = 1;
            } else if (HasTag(tags, "69") || HasTag(tags, "masturbation")) {
                out[i] = 1;
            } else if (i == 0) {
                if (has_pussy && (HasTag(tags, "vaginal") || HasTag(tags, "cunnilingus") ||
                                     HasTag(tags, "lesbian") || HasTag(tags, "fingering") ||
                                     HasTag(tags, "dildo")))
                    out[i] = 1;
                else if (HasTag(tags, "anal") || HasTag(tags, "fisting"))
                    out[i] = 1;
                else
                    out[i] = 0;
            } else {
                if (has_penis && (HasTag(tags, "vaginal") || HasTag(tags, "boobjob") ||
                                     HasTag(tags, "blowjob") || HasTag(tags, "handjob") ||
                                     HasTag(tags, "footjob") || HasTag(tags, "oral") || HasTag(tags, "anal")))
                    out[i] = 1;
                else
                    out[i] = 0;
            }
        }
        return out;
    }

    void InferSpeakingModifiers(const std::vector<int>& pos_no_orgasm,
        const std::unordered_set<std::string>& tags, std::vector<std::string>& out_csv_per_pos)
    {
        // orgasm_expected 1 (pos_no_orgasm 0) → _pleasure_; not expected → empty.
        // Pain tags may append _pain_ for position 0 when expected.
        out_csv_per_pos.assign(pos_no_orgasm.size(), "");
        for (size_t i = 0; i < pos_no_orgasm.size(); ++i) {
            const bool orgasm_expected = pos_no_orgasm[i] == 0;
            std::vector<std::string> mods;
            if (orgasm_expected)
                mods.push_back("_pleasure_");
            if (orgasm_expected && i == 0 && (HasTag(tags, "spanking") || HasTag(tags, "whipping")))
                mods.push_back("_pain_");
            std::ostringstream oss;
            for (size_t m = 0; m < mods.size(); ++m) {
                if (m)
                    oss << ',';
                oss << mods[m];
            }
            out_csv_per_pos[i] = oss.str();
        }
    }

    bool Open()
    {
        std::lock_guard lock(g_mutex);
        if (g_db)
            return true;
        auto path = PluginDataDir() / "animationdb.sql";
        std::error_code ec;
        std::filesystem::create_directories(path.parent_path(), ec);
        if (sqlite3_open(path.string().c_str(), &g_db) != SQLITE_OK) {
            webui_log::error("AnimationDB: failed to open {}", path.string());
            g_db = nullptr;
            return false;
        }
        if (!MigrateSchema()) {
            sqlite3_close(g_db);
            g_db = nullptr;
            return false;
        }
        LoadAllRowsLocked();
        webui_log::info("AnimationDB: opened {} ({} rows)", path.string(), g_rows.size());
        return true;
    }

    void Close()
    {
        std::lock_guard lock(g_mutex);
        if (g_db) {
            sqlite3_close(g_db);
            g_db = nullptr;
        }
        g_rows.clear();
        g_tag_to_regs.clear();
    }

    bool IsOpen()
    {
        std::lock_guard lock(g_mutex);
        return g_db != nullptr;
    }

    std::int64_t BeginSync(bool force_rebuild)
    {
        std::lock_guard lock(g_mutex);
        if (!g_db && !Open())
            return 0;
        g_force_rebuild = force_rebuild;
        g_sync_gen += 1;
        if (g_force_rebuild) {
            Exec("DELETE FROM animations");
            Exec("DELETE FROM animation_tags");
            g_rows.clear();
            g_tag_to_regs.clear();
        }
        webui_log::info("AnimationDB: BeginSync gen={} force={}", g_sync_gen, force_rebuild);
        return g_sync_gen;
    }

    bool PushAnim(const nlohmann::json& anim)
    {
        std::lock_guard lock(g_mutex);
        if (!g_db)
            return false;

        auto get_str = [&](const char* k) -> std::string {
            if (anim.contains(k) && anim[k].is_string())
                return ToLower(anim[k].get<std::string>());
            return {};
        };
        auto get_int = [&](const char* k, int def = 0) {
            if (!anim.contains(k))
                return def;
            if (anim[k].is_number_integer())
                return anim[k].get<int>();
            if (anim[k].is_number())
                return static_cast<int>(anim[k].get<double>());
            if (anim[k].is_boolean())
                return anim[k].get<bool>() ? 1 : 0;
            return def;
        };

        AnimRow row;
        row.registry = get_str("_registry");
        if (row.registry.empty())
            row.registry = get_str("registry");
        if (row.registry.empty())
            return false;
        // Human-facing name keeps SexLab casing (UI + animations/(name).json)
        if (anim.contains("_name") && anim["_name"].is_string())
            row.name = anim["_name"].get<std::string>();
        else if (anim.contains("name") && anim["name"].is_string())
            row.name = anim["name"].get<std::string>();

        row.enabled = get_int("_enabled", get_int("enabled", 1));
        row.source = get_int("_source", get_int("source", 0));
        row.position_count = get_int("_position_count", get_int("position_count", 0));
        row.stage_count = get_int("_stage_count", get_int("stage_count", 0));
        row.males = get_int("_males", get_int("males", 0));
        row.females = get_int("_females", get_int("females", 0));
        row.male_creatures = get_int("_male_creatures", get_int("male_creatures", 0));
        row.female_creatures = get_int("_female_creatures", get_int("female_creatures", 0));
        row.has_creature = get_int("_has_creature", get_int("has_creature", 0));
        row.race_type = get_str("_race_type");
        if (row.race_type.empty())
            row.race_type = get_str("race_type");

        if (anim.contains("_pos_genders"))
            row.pos_genders = JsonToVecInt(anim["_pos_genders"]);
        else if (anim.contains("pos_genders"))
            row.pos_genders = JsonToVecInt(anim["pos_genders"]);

        if (anim.contains("_pos_race_keys"))
            row.pos_race_keys = JsonToVecStr(anim["_pos_race_keys"]);
        else if (anim.contains("pos_race_keys"))
            row.pos_race_keys = JsonToVecStr(anim["pos_race_keys"]);

        if (anim.contains("_tags") && anim["_tags"].is_array())
            row.tags = JsonToVecStr(anim["_tags"]);
        else if (anim.contains("tags") && anim["tags"].is_array())
            row.tags = JsonToVecStr(anim["tags"]);
        else if (anim.contains("_tags") && anim["_tags"].is_string())
            row.tags = SplitCsv(anim["_tags"].get<std::string>());

        // skip if unchanged and not force
        if (!g_force_rebuild) {
            auto it = g_rows.find(row.registry);
            if (it != g_rows.end()) {
                // still touch sync_gen
                bool same = it->second.name == row.name && it->second.tags == row.tags &&
                            it->second.pos_genders == row.pos_genders &&
                            it->second.position_count == row.position_count &&
                            it->second.enabled == row.enabled;
                if (same) {
                    it->second.sync_gen = g_sync_gen;
                    UpsertRowLocked(it->second);
                    return true;
                }
            }
        }

        std::unordered_set<std::string> tagset(row.tags.begin(), row.tags.end());
        std::optional<std::vector<int>> orgasm_file;
        LoadAnimJsonForName(row.name, row, orgasm_file);

        auto orgasm = InferOrgasmExpected(row.position_count, row.pos_genders, tagset, orgasm_file);
        row.pos_no_orgasm.resize(orgasm.size());
        for (size_t i = 0; i < orgasm.size(); ++i)
            row.pos_no_orgasm[i] = 1 - orgasm[i];
        InferSpeakingModifiers(row.pos_no_orgasm, tagset, row.pos_speaking_modifiers);
        row.sync_gen = g_sync_gen;
        UpsertRowLocked(row);
        return true;
    }

    int PushAnimBatch(const nlohmann::json& arr)
    {
        if (!arr.is_array())
            return 0;
        int n = 0;
        for (const auto& el : arr) {
            if (el.is_object() && PushAnim(el))
                ++n;
        }
        return n;
    }

    bool EndSync()
    {
        std::lock_guard lock(g_mutex);
        if (!g_db)
            return false;
        sqlite3_stmt* stmt = nullptr;
        if (sqlite3_prepare_v2(g_db, "DELETE FROM animations WHERE sync_gen != ?", -1, &stmt, nullptr) ==
            SQLITE_OK) {
            sqlite3_bind_int64(stmt, 1, g_sync_gen);
            sqlite3_step(stmt);
            sqlite3_finalize(stmt);
        }
        Exec("DELETE FROM animation_tags WHERE registry NOT IN (SELECT registry FROM animations)");
        LoadAllRowsLocked();
        webui_log::info("AnimationDB: EndSync gen={} rows={}", g_sync_gen, g_rows.size());
        return true;
    }

    std::vector<AnimRow> QueryTopNAnims(const FilterSpec& spec, int n)
    {
        std::lock_guard lock(g_mutex);
        std::vector<AnimRow> out;
        for (const auto& [reg, row] : g_rows) {
            if (MatchesFilter(row, spec))
                out.push_back(row);
        }
        std::sort(out.begin(), out.end(),
            [](const AnimRow& a, const AnimRow& b) { return a.registry < b.registry; });
        if (n > 0 && static_cast<int>(out.size()) > n)
            out.resize(static_cast<size_t>(n));
        return out;
    }

    std::vector<TagCount> QueryTopNTags(const FilterSpec& spec, int n)
    {
        auto anims = QueryTopNAnims(spec, 0);
        std::unordered_map<std::string, int> counts;
        for (const auto& row : anims) {
            for (const auto& tag : row.tags)
                counts[tag] += 1;
        }
        std::vector<TagCount> out;
        out.reserve(counts.size());
        for (const auto& [tag, c] : counts)
            out.push_back({tag, c});
        std::sort(out.begin(), out.end(), [](const TagCount& a, const TagCount& b) {
            if (a.count != b.count)
                return a.count > b.count;
            return a.tag < b.tag;
        });
        if (n > 0 && static_cast<int>(out.size()) > n)
            out.resize(static_cast<size_t>(n));
        return out;
    }

    int TotalEnabledCount()
    {
        std::lock_guard lock(g_mutex);
        int n = 0;
        for (const auto& [_, row] : g_rows) {
            if (row.enabled)
                ++n;
        }
        return n;
    }

    int TotalCount()
    {
        std::lock_guard lock(g_mutex);
        return static_cast<int>(g_rows.size());
    }

    std::optional<AnimRow> GetByRegistry(const std::string& registry)
    {
        std::lock_guard lock(g_mutex);
        auto it = g_rows.find(ToLower(registry));
        if (it == g_rows.end())
            return std::nullopt;
        return it->second;
    }

    std::string GetStageDescription(const std::string& registry, int stage)
    {
        auto row = GetByRegistry(registry);
        if (!row)
            return {};
        auto it = row->stage_descriptions.find(stage);
        if (it == row->stage_descriptions.end())
            return {};
        return it->second;
    }

    std::string SubstituteActors(const std::string& desc, const std::vector<std::string>& actor_names)
    {
        std::string out = desc;
        for (size_t i = 0; i < actor_names.size(); ++i) {
            std::string token = "{{sl.actors." + std::to_string(i) + "}}";
            size_t pos = 0;
            while ((pos = out.find(token, pos)) != std::string::npos) {
                out.replace(pos, token.size(), actor_names[i]);
                pos += actor_names[i].size();
            }
        }
        return out;
    }

    bool SaveAnimLocal(const std::string& registry, const nlohmann::json& payload)
    {
        std::lock_guard lock(g_mutex);
        if (!g_db)
            return false;
        auto it = g_rows.find(ToLower(registry));
        if (it == g_rows.end())
            return false;

        AnimRow& row = it->second;
        auto local_dir = PluginDataDir() / "animations" / "_local_";
        std::error_code ec;
        std::filesystem::create_directories(local_dir, ec);

        // Prefer original-case name for file: payload _name, else stored row.name
        std::string fname = row.name + ".json";
        if (payload.contains("_name") && payload["_name"].is_string())
            fname = payload["_name"].get<std::string>() + ".json";
        else if (payload.contains("name") && payload["name"].is_string())
            fname = payload["name"].get<std::string>() + ".json";

        nlohmann::json file = nlohmann::json::object();
        auto path = local_dir / fname;
        if (std::filesystem::exists(path)) {
            try {
                std::ifstream in(path);
                file = nlohmann::json::parse(in);
                if (!file.is_object())
                    file = nlohmann::json::object();
            } catch (...) {
                file = nlohmann::json::object();
            }
        }

        if (payload.contains("stage_descriptions") && payload["stage_descriptions"].is_object()) {
            for (auto it2 = payload["stage_descriptions"].begin(); it2 != payload["stage_descriptions"].end();
                 ++it2) {
                int stage = 0;
                try {
                    stage = std::stoi(it2.key());
                } catch (...) {
                    continue;
                }
                std::string desc = it2.value().is_string() ? it2.value().get<std::string>() : "";
                nlohmann::json stage_obj = nlohmann::json::object();
                stage_obj["version"] = "2.0";
                stage_obj["description"] = desc;
                file["stage " + std::to_string(stage)] = stage_obj;
                row.stage_descriptions[stage] = desc;
            }
        }
        if (payload.contains("orgasm_expected") && payload["orgasm_expected"].is_array()) {
            file["orgasm_expected"] = payload["orgasm_expected"];
            auto ov = JsonToVecInt(payload["orgasm_expected"]);
            if (static_cast<int>(ov.size()) == row.position_count) {
                row.pos_no_orgasm.resize(ov.size());
                for (size_t i = 0; i < ov.size(); ++i)
                    row.pos_no_orgasm[i] = 1 - ov[i];
            }
        }
        if (payload.contains("pos_no_orgasm") && payload["pos_no_orgasm"].is_array()) {
            row.pos_no_orgasm = JsonToVecInt(payload["pos_no_orgasm"]);
            nlohmann::json ov = nlohmann::json::array();
            for (int v : row.pos_no_orgasm)
                ov.push_back(1 - v);
            file["orgasm_expected"] = ov;
        }
        if (payload.contains("speaking_modifiers") && payload["speaking_modifiers"].is_array()) {
            file["speaking_modifiers"] = payload["speaking_modifiers"];
            row.pos_speaking_modifiers = JsonToVecStr(payload["speaking_modifiers"]);
        }
        if (payload.contains("clothed") && payload["clothed"].is_array()) {
            file["clothed"] = payload["clothed"];
            // clothed 1 = dressed / no_stripping; mirror into row if we track dressed separately later
        }

        row.stage_has_description.assign(std::max(0, row.stage_count), 0);
        for (int s = 1; s <= row.stage_count; ++s) {
            auto sit = row.stage_descriptions.find(s);
            if (sit != row.stage_descriptions.end() && !sit->second.empty())
                row.stage_has_description[s - 1] = 1;
        }

        try {
            std::ofstream out(path);
            out << file.dump(2);
        } catch (...) {
            return false;
        }
        UpsertRowLocked(row);
        RebuildTagIndexLocked();
        return true;
    }
}
