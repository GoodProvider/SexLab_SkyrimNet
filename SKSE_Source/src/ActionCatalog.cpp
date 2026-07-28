#include "ActionCatalog.h"
#include "WebUI_Log.h"

#include <Windows.h>
#include <filesystem>
#include <fstream>

namespace ActionCatalog
{
    namespace
    {
        std::vector<ActionDef> g_actions;
        std::unordered_map<std::string, std::size_t> g_byName;
        nlohmann::json g_targetOptions = nlohmann::json::object();
        bool g_loaded = false;

        /// Resolves Data/SKSE/Plugins/SkyrimNet_SexLab/webui next to this DLL.
        /// Falls back to cwd/Data/... when the DLL-relative folder is missing.
        std::filesystem::path ResolveWebUIDir()
        {
            HMODULE hm = nullptr;
            if (GetModuleHandleExW(
                    GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                    reinterpret_cast<LPCWSTR>(&ResolveWebUIDir),
                    &hm)) {
                wchar_t buf[MAX_PATH]{};
                if (GetModuleFileNameW(hm, buf, MAX_PATH)) {
                    auto p = std::filesystem::path(buf).parent_path() / "SkyrimNet_SexLab" / "webui";
                    if (std::filesystem::is_directory(p))
                        return p;
                }
            }
            return std::filesystem::current_path() / "Data" / "SKSE" / "Plugins" / "SkyrimNet_SexLab" / "webui";
        }

        /// Reads an entire file as binary into a string; empty on open failure.
        std::string ReadFile(const std::filesystem::path& path)
        {
            std::ifstream in(path, std::ios::binary);
            if (!in)
                return {};
            return std::string(std::istreambuf_iterator<char>(in), std::istreambuf_iterator<char>());
        }
    }

    /// Public path to the WebUI JSON config directory (actions_index / target_options).
    std::filesystem::path WebUIDir()
    {
        return ResolveWebUIDir();
    }

    /// True after a successful Load() of actions_index.json and target_options.json.
    bool IsLoaded()
    {
        return g_loaded;
    }

    /// Loads actions_index.json and target_options.json into the in-memory catalog.
    /// Builds name index used by the target menu and ExecuteAction.
    bool Load()
    {
        g_actions.clear();
        g_byName.clear();
        g_targetOptions = nlohmann::json::object();
        g_loaded = false;

        const auto dir = ResolveWebUIDir();
        const auto indexPath = dir / "actions_index.json";
        const auto optsPath = dir / "target_options.json";

        webui_log::info("ActionCatalog loading from {}", dir.string());

        try {
            auto indexRaw = ReadFile(indexPath);
            if (indexRaw.empty()) {
                webui_log::error("ActionCatalog: missing or empty {}", indexPath.string());
                return false;
            }
            auto index = nlohmann::json::parse(indexRaw);
            if (!index.contains("actions") || !index["actions"].is_array()) {
                webui_log::error("ActionCatalog: actions_index.json missing actions array");
                return false;
            }

            for (auto& item : index["actions"]) {
                ActionDef def;
                def.name = item.value("name", "");
                def.label = item.value("label", def.name);
                def.customCategory = item.value("customCategory", "");
                def.questEditorId = item.value("questEditorId", "");
                def.scriptName = item.value("scriptName", "");
                def.executionFunctionName = item.value("executionFunctionName", "");
                def.file = item.value("file", "");
                if (item.contains("parameterMapping") && item["parameterMapping"].is_array()) {
                    for (auto& m : item["parameterMapping"]) {
                        ParamMapping pm;
                        pm.type = m.value("type", "");
                        pm.name = m.value("name", "");
                        pm.description = m.value("description", "");
                        if (m.contains("value")) {
                            pm.hasValue = true;
                            if (m["value"].is_string())
                                pm.value = m["value"].get<std::string>();
                            else if (m["value"].is_number_integer())
                                pm.value = std::to_string(m["value"].get<int>());
                            else if (m["value"].is_boolean())
                                pm.value = m["value"].get<bool>() ? "true" : "false";
                            else
                                pm.value = m["value"].dump();
                        }
                        def.parameterMapping.push_back(std::move(pm));
                    }
                }
                if (def.name.empty())
                    continue;
                auto idx = g_actions.size();
                g_byName[def.name] = idx;
                g_actions.push_back(std::move(def));
            }

            auto optsRaw = ReadFile(optsPath);
            if (optsRaw.empty()) {
                webui_log::error("ActionCatalog: missing or empty {}", optsPath.string());
                return false;
            }
            g_targetOptions = nlohmann::json::parse(optsRaw);
            g_loaded = true;
            webui_log::info("ActionCatalog loaded {} actions", g_actions.size());
            return true;
        } catch (const std::exception& e) {
            webui_log::error("ActionCatalog::Load failed: {}", e.what());
            return false;
        }
    }

    /// Looks up a loaded ActionDef by SkyrimNet action name; nullptr if missing.
    const ActionDef* FindByName(const std::string& name)
    {
        auto it = g_byName.find(name);
        if (it == g_byName.end())
            return nullptr;
        return &g_actions[it->second];
    }

    /// Raw target_options.json object (defaults + options) used when building UI params.
    const nlohmann::json& TargetOptions()
    {
        return g_targetOptions;
    }

    /// Builds the JSON catalog JS configureTargetMenu expects (defaults, options, actions).
    /// Loads the catalog first if it is not already loaded.
    nlohmann::json BuildUICatalog()
    {
        if (!g_loaded)
            Load();

        nlohmann::json catalog;
        catalog["defaults"] = g_targetOptions.value("defaults", nlohmann::json::object());
        catalog["options"] = g_targetOptions.value("options", nlohmann::json::array());

        nlohmann::json actionsObj = nlohmann::json::object();

        for (auto& def : g_actions) {
            nlohmann::json a;
            a["name"] = def.name;
            a["label"] = def.label.empty() ? def.name : def.label;
            a["customCategory"] = def.customCategory;
            a["executionFunctionName"] = def.executionFunctionName;
            a["questEditorId"] = def.questEditorId;
            a["scriptName"] = def.scriptName;

            nlohmann::json mapping = nlohmann::json::array();
            for (auto& pm : def.parameterMapping) {
                nlohmann::json m;
                m["type"] = pm.type;
                m["name"] = pm.name;
                m["description"] = pm.description;
                if (pm.hasValue)
                    m["value"] = pm.value;
                mapping.push_back(m);
            }
            a["parameterMapping"] = mapping;
            actionsObj[def.name] = a;
        }

        catalog["actions"] = actionsObj;
        return catalog;
    }
}
