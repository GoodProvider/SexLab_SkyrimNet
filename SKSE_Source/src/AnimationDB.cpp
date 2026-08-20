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

        bool TableHasColumn(const char* table, const char* column)
        {
            sqlite3_stmt* stmt = nullptr;
            std::string sql = std::string("PRAGMA table_info(") + table + ")";
            if (sqlite3_prepare_v2(g_db, sql.c_str(), -1, &stmt, nullptr) != SQLITE_OK)
                return false;
            bool found = false;
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                const unsigned char* name = sqlite3_column_text(stmt, 1);
                if (name && _stricmp(reinterpret_cast<const char*>(name), column) == 0) {
                    found = true;
                    break;
                }
            }
            sqlite3_finalize(stmt);
            return found;
        }

        bool EnsureColumn(const char* table, const char* column, const char* type_sql)
        {
            if (TableHasColumn(table, column))
                return true;
            std::string sql = std::string("ALTER TABLE ") + table + " ADD COLUMN " + column + " " + type_sql;
            webui_log::info("AnimationDB: adding column {}.{}", table, column);
            return Exec(sql.c_str());
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
  sync_gen INTEGER,
  pos_clothed TEXT,
  stage_speaking TEXT,
  stage_clothed TEXT,
  stage_tags TEXT,
  transitions TEXT,
  file_tags TEXT,
  creator TEXT
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
            if (!Exec(ddl))
                return false;
            // Older DBs created before 3.0 columns — add if missing.
            if (!EnsureColumn("animations", "pos_clothed", "TEXT"))
                return false;
            if (!EnsureColumn("animations", "stage_speaking", "TEXT"))
                return false;
            if (!EnsureColumn("animations", "stage_clothed", "TEXT"))
                return false;
            if (!EnsureColumn("animations", "stage_tags", "TEXT"))
                return false;
            if (!EnsureColumn("animations", "transitions", "TEXT"))
                return false;
            if (!EnsureColumn("animations", "file_tags", "TEXT"))
                return false;
            if (!EnsureColumn("animations", "creator", "TEXT"))
                return false;
            return true;
        }

        std::string JoinCsv(const std::vector<std::string>& parts)
        {
            std::ostringstream oss;
            for (size_t i = 0; i < parts.size(); ++i) {
                if (i)
                    oss << ',';
                oss << parts[i];
            }
            return oss.str();
        }

        /// Parse speaking_modifiers: nested token arrays OR legacy flat CSV/string per actor.
        /// Returns nullopt if value is not a usable array.
        std::optional<std::vector<std::string>> ParseSpeakingModifiersValue(const nlohmann::json& v)
        {
            if (!v.is_array())
                return std::nullopt;
            std::vector<std::string> out;
            out.reserve(v.size());
            for (const auto& el : v) {
                if (el.is_array()) {
                    std::vector<std::string> tokens;
                    for (const auto& t : el) {
                        if (t.is_string()) {
                            auto s = t.get<std::string>();
                            if (!s.empty())
                                tokens.push_back(s);
                        }
                    }
                    out.push_back(JoinCsv(tokens));
                } else if (el.is_string()) {
                    // Legacy flat CSV or single token string — keep as CSV (trim empties via SplitCsv join)
                    out.push_back(JoinCsv(SplitCsv(el.get<std::string>())));
                } else if (el.is_null()) {
                    out.push_back("");
                } else {
                    out.push_back("");
                }
            }
            return out;
        }

        nlohmann::json SpeakingCsvToNestedJson(const std::vector<std::string>& csv_per_pos)
        {
            nlohmann::json arr = nlohmann::json::array();
            for (const auto& csv : csv_per_pos) {
                nlohmann::json tokens = nlohmann::json::array();
                for (const auto& t : SplitCsv(csv))
                    tokens.push_back(t);
                arr.push_back(tokens);
            }
            return arr;
        }

        /// Lowercase object keys; false on case-only key conflict.
        bool LowerKeyObject(const nlohmann::json& in, nlohmann::json& out, const std::string& ctx)
        {
            out = nlohmann::json::object();
            if (!in.is_object())
                return false;
            for (auto it = in.begin(); it != in.end(); ++it) {
                std::string lk = ToLower(it.key());
                if (out.contains(lk)) {
                    webui_log::error("AnimationDB: fatal case-conflicting keys in {} (key '{}')", ctx,
                        it.key());
                    return false;
                }
                out[lk] = it.value();
            }
            return true;
        }

        bool ParseStageKey(const std::string& key_l, int& stage_out)
        {
            // Accept "stage 1", "stage1", "stage 01" after lowercasing.
            if (key_l.rfind("stage", 0) != 0)
                return false;
            size_t i = 5;
            while (i < key_l.size() && (key_l[i] == ' ' || key_l[i] == '_' || key_l[i] == '\t'))
                ++i;
            if (i >= key_l.size() || !std::isdigit(static_cast<unsigned char>(key_l[i])))
                return false;
            try {
                stage_out = std::stoi(key_l.substr(i));
            } catch (...) {
                return false;
            }
            return stage_out >= 1;
        }

        nlohmann::json StageSpeakingToJson(const std::unordered_map<int, std::vector<std::string>>& m)
        {
            nlohmann::json o = nlohmann::json::object();
            for (const auto& [k, v] : m)
                o[std::to_string(k)] = v;
            return o;
        }

        nlohmann::json StageClothedToJson(const std::unordered_map<int, std::vector<int>>& m)
        {
            nlohmann::json o = nlohmann::json::object();
            for (const auto& [k, v] : m)
                o[std::to_string(k)] = v;
            return o;
        }

        nlohmann::json StageTagsToJson(const std::unordered_map<int, std::vector<std::string>>& m)
        {
            nlohmann::json o = nlohmann::json::object();
            for (const auto& [k, v] : m)
                o[std::to_string(k)] = v;
            return o;
        }

        void JsonToStageSpeaking(const nlohmann::json& j,
            std::unordered_map<int, std::vector<std::string>>& out)
        {
            out.clear();
            if (!j.is_object())
                return;
            for (auto it = j.begin(); it != j.end(); ++it) {
                try {
                    int stage = std::stoi(it.key());
                    if (it.value().is_array())
                        out[stage] = JsonToVecStr(it.value());
                } catch (...) {
                }
            }
        }

        void JsonToStageClothed(const nlohmann::json& j, std::unordered_map<int, std::vector<int>>& out)
        {
            out.clear();
            if (!j.is_object())
                return;
            for (auto it = j.begin(); it != j.end(); ++it) {
                try {
                    int stage = std::stoi(it.key());
                    if (it.value().is_array())
                        out[stage] = JsonToVecInt(it.value());
                } catch (...) {
                }
            }
        }

        void JsonToStageTags(const nlohmann::json& j, std::unordered_map<int, std::vector<std::string>>& out)
        {
            out.clear();
            if (!j.is_object())
                return;
            for (auto it = j.begin(); it != j.end(); ++it) {
                try {
                    int stage = std::stoi(it.key());
                    if (it.value().is_array())
                        out[stage] = JsonToVecStr(it.value());
                } catch (...) {
                }
            }
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
                "tags,pos_no_orgasm,pos_speaking_modifiers,stage_descriptions,stage_has_description,sync_gen,"
                "pos_clothed,stage_speaking,stage_clothed,stage_tags,transitions,file_tags,creator "
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
                try {
                    row.pos_clothed = JsonToVecInt(nlohmann::json::parse(col(20).empty() ? "[]" : col(20)));
                    JsonToStageSpeaking(nlohmann::json::parse(col(21).empty() ? "{}" : col(21)), row.stage_speaking);
                    JsonToStageClothed(nlohmann::json::parse(col(22).empty() ? "{}" : col(22)), row.stage_clothed);
                    JsonToStageTags(nlohmann::json::parse(col(23).empty() ? "{}" : col(23)), row.stage_tags);
                    auto tr = nlohmann::json::parse(col(24).empty() ? "{}" : col(24));
                    row.transitions = tr.is_object() ? tr : nlohmann::json::object();
                    row.file_tags = JsonToVecStr(nlohmann::json::parse(col(25).empty() ? "[]" : col(25)));
                } catch (...) {
                }
                row.creator = col(26);
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
                "pos_no_orgasm,pos_speaking_modifiers,stage_descriptions,stage_has_description,sync_gen,"
                "pos_clothed,stage_speaking,stage_clothed,stage_tags,transitions,file_tags,creator) "
                "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) "
                "ON CONFLICT(registry) DO UPDATE SET "
                "name=excluded.name,enabled=excluded.enabled,source=excluded.source,"
                "position_count=excluded.position_count,stage_count=excluded.stage_count,"
                "males=excluded.males,females=excluded.females,male_creatures=excluded.male_creatures,"
                "female_creatures=excluded.female_creatures,has_creature=excluded.has_creature,"
                "race_type=excluded.race_type,pos_genders=excluded.pos_genders,"
                "pos_race_keys=excluded.pos_race_keys,tags=excluded.tags,"
                "pos_no_orgasm=excluded.pos_no_orgasm,pos_speaking_modifiers=excluded.pos_speaking_modifiers,"
                "stage_descriptions=excluded.stage_descriptions,"
                "stage_has_description=excluded.stage_has_description,sync_gen=excluded.sync_gen,"
                "pos_clothed=excluded.pos_clothed,stage_speaking=excluded.stage_speaking,"
                "stage_clothed=excluded.stage_clothed,stage_tags=excluded.stage_tags,"
                "transitions=excluded.transitions,file_tags=excluded.file_tags,creator=excluded.creator";
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
            bind_text(JsonDump(VecIntToJson(row.pos_clothed)));
            bind_text(JsonDump(StageSpeakingToJson(row.stage_speaking)));
            bind_text(JsonDump(StageClothedToJson(row.stage_clothed)));
            bind_text(JsonDump(StageTagsToJson(row.stage_tags)));
            bind_text(JsonDump(row.transitions.is_object() ? row.transitions : nlohmann::json::object()));
            bind_text(JsonDump(VecStrToJson(row.file_tags)));
            bind_text(row.creator);
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

        /// Collect pack dirs: non-_local_ first, _local_ last (wins on conflict).
        std::vector<std::filesystem::path> AnimPackDirs(const std::filesystem::path& root)
        {
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
                packs.push_back(local_pack);
            return packs;
        }

        /// Find single winning path for fname across packs. Conflict → warn, last wins.
        std::optional<std::filesystem::path> ResolveAnimFilePath(
            const std::vector<std::filesystem::path>& packs, const std::string& fname,
            const std::string& registry)
        {
            std::vector<std::filesystem::path> hits;
            for (const auto& pack : packs) {
                auto path = pack / fname;
                if (std::filesystem::exists(path))
                    hits.push_back(path);
            }
            if (hits.empty())
                return std::nullopt;
            if (hits.size() > 1) {
                webui_log::warn(
                    "AnimationDB: anidata conflict for registry '{}' file '{}' ({} packs); using {}",
                    registry, fname, hits.size(), hits.back().string());
            }
            return hits.back();
        }

        void ApplyAnimJsonToRow(const nlohmann::json& raw, AnimRow& row,
            std::optional<std::vector<int>>& orgasm_override, std::vector<char>* speaking_from_file_out)
        {
            nlohmann::json info;
            if (!LowerKeyObject(raw, info, row.registry.empty() ? row.name : row.registry))
                return;

            if (!info.contains("version")) {
                webui_log::error("AnimationDB: anidata missing version for '{}' (treating as 3.0)",
                    row.registry.empty() ? row.name : row.registry);
            }

            if (info.contains("creator") && info["creator"].is_string())
                row.creator = info["creator"].get<std::string>();

            // Animation-level optional fields (present vs absent).
            std::optional<std::vector<std::string>> anim_speaking;
            std::optional<std::vector<int>> anim_clothed;
            std::optional<std::vector<std::string>> anim_tags;
            bool anim_speaking_present = false;
            bool anim_clothed_present = false;
            bool anim_tags_present = false;

            if (info.contains("orgasm_expected") && info["orgasm_expected"].is_array()) {
                auto ov = JsonToVecInt(info["orgasm_expected"]);
                if (static_cast<int>(ov.size()) == row.position_count)
                    orgasm_override = ov;
                else if (!ov.empty())
                    webui_log::warn(
                        "AnimationDB: orgasm_expected length {} != position_count {} for '{}'; ignoring",
                        ov.size(), row.position_count, row.registry);
            }

            if (info.contains("speaking_modifiers")) {
                anim_speaking = ParseSpeakingModifiersValue(info["speaking_modifiers"]);
                anim_speaking_present = anim_speaking.has_value();
                if (!anim_speaking_present)
                    webui_log::warn("AnimationDB: bad speaking_modifiers for '{}'", row.registry);
            }
            if (info.contains("clothed") && info["clothed"].is_array()) {
                anim_clothed = JsonToVecInt(info["clothed"]);
                anim_clothed_present = true;
            }
            if (info.contains("tags") && info["tags"].is_array()) {
                anim_tags = JsonToVecStr(info["tags"]);
                anim_tags_present = true;
                row.file_tags = *anim_tags;
            } else {
                row.file_tags.clear();
            }

            if (info.contains("transitions") && info["transitions"].is_object()) {
                nlohmann::json tr_out = nlohmann::json::object();
                for (auto it = info["transitions"].begin(); it != info["transitions"].end(); ++it) {
                    if (it.value().is_string())
                        tr_out[ToLower(it.key())] = it.value().get<std::string>();
                }
                row.transitions = std::move(tr_out);
            } else {
                row.transitions = nlohmann::json::object();
            }

            struct StageRaw {
                bool has_desc = false;
                std::string desc;
                bool has_speaking = false;
                std::vector<std::string> speaking;
                bool has_clothed = false;
                std::vector<int> clothed;
                bool has_tags = false;
                std::vector<std::string> tags;
            };
            std::unordered_map<int, StageRaw> stages;

            for (auto it = info.begin(); it != info.end(); ++it) {
                int stage = 0;
                if (!ParseStageKey(it.key(), stage))
                    continue;
                StageRaw raw_s;
                if (it.value().is_string()) {
                    raw_s.has_desc = true;
                    raw_s.desc = it.value().get<std::string>();
                } else if (it.value().is_object()) {
                    nlohmann::json st;
                    if (!LowerKeyObject(it.value(), st, row.registry + " stage " + std::to_string(stage)))
                        continue;
                    // Ignore per-stage version.
                    if (st.contains("description") && st["description"].is_string()) {
                        raw_s.has_desc = true;
                        raw_s.desc = st["description"].get<std::string>();
                    }
                    if (st.contains("speaking_modifiers")) {
                        auto sp = ParseSpeakingModifiersValue(st["speaking_modifiers"]);
                        if (sp) {
                            raw_s.has_speaking = true;
                            raw_s.speaking = *sp;
                        }
                    }
                    if (st.contains("clothed") && st["clothed"].is_array()) {
                        raw_s.has_clothed = true;
                        raw_s.clothed = JsonToVecInt(st["clothed"]);
                    }
                    if (st.contains("tags") && st["tags"].is_array()) {
                        raw_s.has_tags = true;
                        raw_s.tags = JsonToVecStr(st["tags"]);
                    }
                }
                stages[stage] = std::move(raw_s);
            }

            row.stage_descriptions.clear();
            row.stage_speaking.clear();
            row.stage_clothed.clear();
            row.stage_tags.clear();

            // Resolved carry state (animation-level seeds like stage 0).
            std::string last_desc;
            bool have_speaking = anim_speaking_present;
            std::vector<std::string> cur_speaking = anim_speaking_present ? *anim_speaking : std::vector<std::string>{};
            bool have_clothed = anim_clothed_present;
            std::vector<int> cur_clothed = anim_clothed_present ? *anim_clothed : std::vector<int>{};
            bool have_tags = anim_tags_present;
            std::vector<std::string> cur_tags = anim_tags_present ? *anim_tags : std::vector<std::string>{};

            const int npos = std::max(0, row.position_count);
            const int nstages = std::max(0, row.stage_count);

            for (int s = 1; s <= nstages; ++s) {
                auto sit = stages.find(s);
                if (sit != stages.end()) {
                    const StageRaw& r = sit->second;
                    // description: empty string = absent
                    if (r.has_desc && !r.desc.empty())
                        last_desc = r.desc;
                    if (r.has_speaking) {
                        have_speaking = true;
                        cur_speaking = r.speaking;
                    }
                    if (r.has_clothed) {
                        have_clothed = true;
                        cur_clothed = r.clothed;
                    }
                    if (r.has_tags) {
                        have_tags = true;
                        cur_tags = r.tags;
                    }
                }
                if (!last_desc.empty())
                    row.stage_descriptions[s] = last_desc;
                if (have_speaking)
                    row.stage_speaking[s] = cur_speaking;
                if (have_clothed)
                    row.stage_clothed[s] = cur_clothed;
                if (have_tags)
                    row.stage_tags[s] = cur_tags;
            }

            row.stage_has_description.assign(nstages, 0);
            for (int s = 1; s <= nstages; ++s) {
                auto it = row.stage_descriptions.find(s);
                if (it != row.stage_descriptions.end() && !it->second.empty())
                    row.stage_has_description[s - 1] = 1;
            }

            // pos_clothed: resolved stage 1 / anim / default 0
            row.pos_clothed.assign(npos, 0);
            if (have_clothed || (nstages >= 1 && row.stage_clothed.contains(1))) {
                const auto& src = (nstages >= 1 && row.stage_clothed.contains(1))
                                      ? row.stage_clothed[1]
                                      : cur_clothed;
                for (int i = 0; i < npos; ++i) {
                    if (i < static_cast<int>(src.size()))
                        row.pos_clothed[i] = src[static_cast<size_t>(i)] ? 1 : 0;
                    else
                        webui_log::warn(
                            "AnimationDB: clothed missing actor {} for '{}'; defaulting 0", i, row.registry);
                }
            }

            // Speaking CSV for Papyrus = resolved stage 1 / anim-level. Mark which actors
            // the file supplied (including empty ""). PushAnim fills the rest after orgasm.
            row.pos_speaking_modifiers.assign(npos, "");
            if (speaking_from_file_out)
                speaking_from_file_out->assign(static_cast<size_t>(npos), 0);

            bool speaking_resolved = have_speaking || (nstages >= 1 && row.stage_speaking.contains(1));
            std::vector<std::string> speak_src;
            if (nstages >= 1 && row.stage_speaking.contains(1))
                speak_src = row.stage_speaking[1];
            else if (have_speaking)
                speak_src = cur_speaking;

            if (speaking_resolved) {
                for (int i = 0; i < npos; ++i) {
                    if (i < static_cast<int>(speak_src.size())) {
                        row.pos_speaking_modifiers[static_cast<size_t>(i)] = speak_src[static_cast<size_t>(i)];
                        if (speaking_from_file_out)
                            (*speaking_from_file_out)[static_cast<size_t>(i)] = 1;
                    } else {
                        webui_log::warn(
                            "AnimationDB: speaking_modifiers missing actor {} for '{}'; will default", i,
                            row.registry);
                    }
                }
            }
        }

        void LoadAnimJson(const std::string& registry, const std::string& display_name, AnimRow& row,
            std::optional<std::vector<int>>& orgasm_override, std::vector<char>* speaking_from_file_out)
        {
            auto root = PluginDataDir() / "animations";
            if (!std::filesystem::is_directory(root))
                return;

            auto packs = AnimPackDirs(root);
            // Prefer <registry>.json; else fall back to <display name>.json with warning.
            std::optional<std::filesystem::path> path;
            std::string used_fname;
            if (!registry.empty()) {
                used_fname = registry + ".json";
                path = ResolveAnimFilePath(packs, used_fname, registry);
            }
            if (!path && !display_name.empty()) {
                used_fname = display_name + ".json";
                path = ResolveAnimFilePath(packs, used_fname, registry);
                if (path) {
                    webui_log::warn(
                        "AnimationDB: using display-name anidata '{}' for registry '{}' (prefer registrar filename)",
                        used_fname, registry);
                }
            }
            if (!path)
                return;

            try {
                std::ifstream in(*path);
                nlohmann::json info = nlohmann::json::parse(in);
                if (!info.is_object())
                    return;
                ApplyAnimJsonToRow(info, row, orgasm_override, speaking_from_file_out);
            } catch (const std::exception& e) {
                webui_log::warn("AnimationDB: failed to parse {}: {}", path->string(), e.what());
            } catch (...) {
                webui_log::warn("AnimationDB: failed to parse {}", path->string());
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
        // Tag-derived: gentle / nonsexual activity → empty list for all actors.
        if (HasTag(tags, "cuddling") || HasTag(tags, "kissing") || HasTag(tags, "hug") ||
            HasTag(tags, "holding") || HasTag(tags, "lovingkiss")) {
            out_csv_per_pos.assign(pos_no_orgasm.size(), "");
            return;
        }
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
        std::vector<char> speaking_from_file;
        LoadAnimJson(row.registry, row.name, row, orgasm_file, &speaking_from_file);

        auto orgasm = InferOrgasmExpected(row.position_count, row.pos_genders, tagset, orgasm_file);
        row.pos_no_orgasm.resize(orgasm.size());
        for (size_t i = 0; i < orgasm.size(); ++i)
            row.pos_no_orgasm[i] = 1 - orgasm[i];

        // Prefer resolved SNSL stage-1 tags (including empty []) over SexLab tags.
        std::unordered_set<std::string> tags_for_infer;
        if (row.stage_tags.contains(1)) {
            const auto& t = row.stage_tags[1];
            tags_for_infer.insert(t.begin(), t.end());
        } else {
            tags_for_infer = tagset;
        }

        std::vector<std::string> inferred;
        InferSpeakingModifiers(row.pos_no_orgasm, tags_for_infer, inferred);
        if (row.pos_speaking_modifiers.size() < orgasm.size())
            row.pos_speaking_modifiers.resize(orgasm.size());
        if (speaking_from_file.size() < orgasm.size())
            speaking_from_file.resize(orgasm.size(), 0);
        for (size_t i = 0; i < orgasm.size(); ++i) {
            if (!speaking_from_file[i] && i < inferred.size())
                row.pos_speaking_modifiers[i] = inferred[i];
        }
        if (row.stage_count >= 1)
            row.stage_speaking[1] = row.pos_speaking_modifiers;

        if (row.pos_clothed.size() < orgasm.size())
            row.pos_clothed.resize(orgasm.size(), 0);

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

    std::string GetTransition(const std::string& registry, int from_stage, int to_stage)
    {
        auto row = GetByRegistry(registry);
        if (!row || !row->transitions.is_object())
            return {};
        const std::string key = std::to_string(from_stage) + "-" + std::to_string(to_stage);
        auto it = row->transitions.find(key);
        if (it == row->transitions.end() || !it->is_string())
            return {};
        return it->get<std::string>();
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
        const std::string reg_key = ToLower(registry);
        auto it = g_rows.find(reg_key);
        if (it == g_rows.end())
            return false;

        AnimRow& row = it->second;
        auto local_dir = PluginDataDir() / "animations" / "_local_";
        std::error_code ec;
        std::filesystem::create_directories(local_dir, ec);

        // Schema 3.0: write by registrar name, not display name.
        const std::string fname = row.registry + ".json";
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

        nlohmann::json payload_l;
        if (!LowerKeyObject(payload, payload_l, "SaveAnimLocal:" + row.registry))
            payload_l = payload; // fall through with original keys if conflict

        file["version"] = "3.0";
        if (payload_l.contains("creator") && payload_l["creator"].is_string()) {
            file["creator"] = payload_l["creator"];
            row.creator = payload_l["creator"].get<std::string>();
        }

        auto apply_stage_desc = [&](int stage, const std::string& desc) {
            if (stage < 1)
                return;
            nlohmann::json stage_obj = nlohmann::json::object();
            if (file.contains("stage " + std::to_string(stage)) &&
                file["stage " + std::to_string(stage)].is_object()) {
                stage_obj = file["stage " + std::to_string(stage)];
                // Drop legacy per-stage version.
                nlohmann::json cleaned = nlohmann::json::object();
                for (auto sit = stage_obj.begin(); sit != stage_obj.end(); ++sit) {
                    if (ToLower(sit.key()) == "version")
                        continue;
                    cleaned[sit.key()] = sit.value();
                }
                stage_obj = std::move(cleaned);
            }
            stage_obj["description"] = desc;
            file["stage " + std::to_string(stage)] = stage_obj;
            row.stage_descriptions[stage] = desc;
        };

        if (payload_l.contains("stage_descriptions") && payload_l["stage_descriptions"].is_object()) {
            for (auto it2 = payload_l["stage_descriptions"].begin();
                 it2 != payload_l["stage_descriptions"].end(); ++it2) {
                int stage = 0;
                try {
                    stage = std::stoi(it2.key());
                } catch (...) {
                    continue;
                }
                std::string desc = it2.value().is_string() ? it2.value().get<std::string>() : "";
                apply_stage_desc(stage, desc);
            }
        }

        // Also accept canonical "stage N" keys on the payload.
        for (auto it2 = payload_l.begin(); it2 != payload_l.end(); ++it2) {
            int stage = 0;
            if (!ParseStageKey(it2.key(), stage))
                continue;
            std::string desc;
            if (it2.value().is_string()) {
                desc = it2.value().get<std::string>();
            } else if (it2.value().is_object()) {
                nlohmann::json st;
                if (LowerKeyObject(it2.value(), st, row.registry + " save stage")) {
                    if (st.contains("description") && st["description"].is_string())
                        desc = st["description"].get<std::string>();
                    // Merge other stage fields (speaking/clothed/tags) without version.
                    nlohmann::json stage_obj = nlohmann::json::object();
                    if (file.contains("stage " + std::to_string(stage)) &&
                        file["stage " + std::to_string(stage)].is_object())
                        stage_obj = file["stage " + std::to_string(stage)];
                    if (!desc.empty() || (st.contains("description")))
                        stage_obj["description"] = desc;
                    if (st.contains("speaking_modifiers"))
                        stage_obj["speaking_modifiers"] =
                            SpeakingCsvToNestedJson(
                                ParseSpeakingModifiersValue(st["speaking_modifiers"])
                                    .value_or(std::vector<std::string>{}));
                    if (st.contains("clothed"))
                        stage_obj["clothed"] = st["clothed"];
                    if (st.contains("tags"))
                        stage_obj["tags"] = st["tags"];
                    stage_obj.erase("version");
                    file["stage " + std::to_string(stage)] = stage_obj;
                    if (!desc.empty() || st.contains("description"))
                        row.stage_descriptions[stage] = desc;
                    continue;
                }
            }
            apply_stage_desc(stage, desc);
        }

        if (payload_l.contains("orgasm_expected") && payload_l["orgasm_expected"].is_array()) {
            file["orgasm_expected"] = payload_l["orgasm_expected"];
            auto ov = JsonToVecInt(payload_l["orgasm_expected"]);
            if (static_cast<int>(ov.size()) == row.position_count) {
                row.pos_no_orgasm.resize(ov.size());
                for (size_t i = 0; i < ov.size(); ++i)
                    row.pos_no_orgasm[i] = 1 - ov[i];
            }
        }
        if (payload_l.contains("pos_no_orgasm") && payload_l["pos_no_orgasm"].is_array()) {
            row.pos_no_orgasm = JsonToVecInt(payload_l["pos_no_orgasm"]);
            nlohmann::json ov = nlohmann::json::array();
            for (int v : row.pos_no_orgasm)
                ov.push_back(1 - v);
            file["orgasm_expected"] = ov;
        }

        if (payload_l.contains("speaking_modifiers") && payload_l["speaking_modifiers"].is_array()) {
            auto parsed = ParseSpeakingModifiersValue(payload_l["speaking_modifiers"]);
            if (parsed) {
                file["speaking_modifiers"] = SpeakingCsvToNestedJson(*parsed);
                row.pos_speaking_modifiers = *parsed;
                if (row.stage_count >= 1)
                    row.stage_speaking[1] = *parsed;
            }
        }
        if (payload_l.contains("clothed") && payload_l["clothed"].is_array()) {
            file["clothed"] = payload_l["clothed"];
            row.pos_clothed = JsonToVecInt(payload_l["clothed"]);
            for (int& v : row.pos_clothed)
                v = v ? 1 : 0;
            if (row.stage_count >= 1)
                row.stage_clothed[1] = row.pos_clothed;
        }
        if (payload_l.contains("tags") && payload_l["tags"].is_array()) {
            file["tags"] = payload_l["tags"];
            row.file_tags = JsonToVecStr(payload_l["tags"]);
            if (row.stage_count >= 1)
                row.stage_tags[1] = row.file_tags;
        }
        if (payload_l.contains("transitions") && payload_l["transitions"].is_object()) {
            nlohmann::json tr = nlohmann::json::object();
            for (auto tit = payload_l["transitions"].begin(); tit != payload_l["transitions"].end(); ++tit) {
                if (tit.value().is_string())
                    tr[ToLower(tit.key())] = tit.value().get<std::string>();
            }
            file["transitions"] = tr;
            row.transitions = tr;
        }

        row.stage_has_description.assign(std::max(0, row.stage_count), 0);
        for (int s = 1; s <= row.stage_count; ++s) {
            auto sit = row.stage_descriptions.find(s);
            if (sit != row.stage_descriptions.end() && !sit->second.empty())
                row.stage_has_description[s - 1] = 1;
        }

        // Rebuild stage keys canonically without per-stage version.
        {
            nlohmann::json stages_out = nlohmann::json::object();
            std::vector<std::string> drop_keys;
            for (auto fit = file.begin(); fit != file.end(); ++fit) {
                int stage = 0;
                if (!ParseStageKey(ToLower(fit.key()), stage))
                    continue;
                drop_keys.push_back(fit.key());
                if (!fit.value().is_object()) {
                    if (fit.value().is_string()) {
                        nlohmann::json o = nlohmann::json::object();
                        o["description"] = fit.value().get<std::string>();
                        stages_out["stage " + std::to_string(stage)] = o;
                    }
                    continue;
                }
                nlohmann::json cleaned = nlohmann::json::object();
                for (auto sit = fit.value().begin(); sit != fit.value().end(); ++sit) {
                    if (ToLower(sit.key()) == "version")
                        continue;
                    cleaned[ToLower(sit.key()) == "description"       ? "description"
                            : ToLower(sit.key()) == "speaking_modifiers" ? "speaking_modifiers"
                            : ToLower(sit.key()) == "clothed"           ? "clothed"
                            : ToLower(sit.key()) == "tags"              ? "tags"
                                                                         : sit.key()] = sit.value();
                }
                stages_out["stage " + std::to_string(stage)] = cleaned;
            }
            for (const auto& k : drop_keys)
                file.erase(k);
            for (auto sit = stages_out.begin(); sit != stages_out.end(); ++sit)
                file[sit.key()] = sit.value();
        }

        try {
            std::ofstream out(path);
            out << file.dump(2);
        } catch (...) {
            return false;
        }
        UpsertRowLocked(row);
        RebuildTagIndexLocked();
        webui_log::info("AnimationDB: SaveAnimLocal wrote {}", path.string());
        return true;
    }
}
