#include "ActionCatalog.h"
#include "TargetMenuRegistry.h"
#include "WebUI_Log.h"

#include <Windows.h>
#include <algorithm>
#include <cctype>
#include <filesystem>
#include <fstream>
#include <string_view>
#include <vector>

namespace ActionCatalog
{
    namespace
    {
        std::vector<ActionDef> g_actions;
        std::unordered_map<std::string, std::size_t> g_byName;
        nlohmann::json g_targetOptions = nlohmann::json::object();
        bool g_loaded = false;

        bool EqualsIgnoreCase(std::string_view a, std::string_view b)
        {
            if (a.size() != b.size())
                return false;
            for (size_t i = 0; i < a.size(); ++i) {
                if (std::tolower(static_cast<unsigned char>(a[i])) !=
                    std::tolower(static_cast<unsigned char>(b[i])))
                    return false;
            }
            return true;
        }

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

        double AsNumber(const nlohmann::json& v)
        {
            if (v.is_number())
                return v.get<double>();
            if (v.is_boolean())
                return v.get<bool>() ? 1.0 : 0.0;
            if (v.is_string()) {
                try {
                    return std::stod(v.get<std::string>());
                } catch (...) {
                    if (EqualsIgnoreCase(v.get<std::string>(), "true"))
                        return 1.0;
                    if (EqualsIgnoreCase(v.get<std::string>(), "false"))
                        return 0.0;
                }
            }
            return 0.0;
        }

        bool CompareValues(double actual, std::string_view op, const nlohmann::json& expected)
        {
            const double exp = AsNumber(expected);
            if (op == "==")
                return actual == exp;
            if (op == "!=")
                return actual != exp;
            if (op == "<")
                return actual < exp;
            if (op == "<=")
                return actual <= exp;
            if (op == ">")
                return actual > exp;
            if (op == ">=")
                return actual >= exp;
            return false;
        }

        /// Minimal eligibilityRules eval for actionSwitch (FormListCount on strip storage).
        bool EvalCondition(const nlohmann::json& cond, bool focusHasStrippedItems)
        {
            if (!cond.is_object())
                return false;
            const std::string decorator = cond.value("decoratorName", "");
            if (!EqualsIgnoreCase(decorator, "papyrus_util"))
                return false;
            if (!cond.contains("arguments") || !cond["arguments"].is_array() || cond["arguments"].size() < 3)
                return false;

            const auto& args = cond["arguments"];
            const std::string fn = args[0].is_string() ? args[0].get<std::string>() : "";
            const std::string actorTok = args[1].is_string() ? args[1].get<std::string>() : "";
            const std::string key = args[2].is_string() ? args[2].get<std::string>() : "";
            if (!EqualsIgnoreCase(fn, "FormListCount"))
                return false;
            if (!EqualsIgnoreCase(actorTok, "currentActor"))
                return false;
            if (key != "skyrimnet_sexlab_storage_items")
                return false;

            const double count = focusHasStrippedItems ? 1.0 : 0.0;
            const std::string op = cond.value("comparisonOperator", "==");
            return CompareValues(count, op, cond.contains("expectedValue") ? cond["expectedValue"] : nlohmann::json(0));
        }

        bool EvalEligibilityRules(const nlohmann::json& rules, bool focusHasStrippedItems)
        {
            if (!rules.is_array() || rules.empty())
                return true;
            for (auto& group : rules) {
                if (!group.is_object())
                    continue;
                const bool required = group.value("required", true);
                if (!required)
                    continue;
                if (!group.contains("conditions") || !group["conditions"].is_array()) {
                    if (required)
                        return false;
                    continue;
                }
                const std::string logic = group.value("logicalOperator", "AND");
                bool andOk = true;
                bool orOk = false;
                bool any = false;
                for (auto& cond : group["conditions"]) {
                    any = true;
                    const bool ok = EvalCondition(cond, focusHasStrippedItems);
                    andOk = andOk && ok;
                    orOk = orOk || ok;
                }
                if (!any)
                    continue;
                const bool groupOk = EqualsIgnoreCase(logic, "OR") ? orOk : andOk;
                if (!groupOk)
                    return false;
            }
            return true;
        }

        /// Resolves one actionSwitch node to a single action (or disabled placeholder).
        nlohmann::json ResolveActionSwitch(const nlohmann::json& node, bool focusHasStrippedItems)
        {
            nlohmann::json children = nlohmann::json::array();
            if (node.contains("options") && node["options"].is_array())
                children = node["options"];

            for (auto& child : children) {
                if (!child.is_object())
                    continue;
                if (!EqualsIgnoreCase(child.value("type", ""), "action"))
                    continue;
                const auto& rules = child.contains("eligibilityRules") ? child["eligibilityRules"] : nlohmann::json::array();
                if (!EvalEligibilityRules(rules, focusHasStrippedItems))
                    continue;

                nlohmann::json out = nlohmann::json::object();
                out["type"] = "action";
                out["name"] = child.value("name", "");
                out["label"] = child.value("label", out["name"]);
                if (child.contains("parameters"))
                    out["parameters"] = child["parameters"];
                webui_log::info(
                    "actionSwitch chose name={} label={}",
                    out.value("name", ""),
                    out.value("label", ""));
                return out;
            }

            std::string fallbackLabel = node.value("label", "");
            std::string fallbackName;
            if (!children.empty() && children[0].is_object()) {
                if (fallbackLabel.empty())
                    fallbackLabel = children[0].value("label", children[0].value("name", "unavailable"));
                fallbackName = children[0].value("name", "");
            }
            if (fallbackLabel.empty())
                fallbackLabel = "unavailable";

            nlohmann::json out = nlohmann::json::object();
            out["type"] = "action";
            out["name"] = fallbackName;
            out["label"] = fallbackLabel;
            out["disabled"] = true;
            webui_log::info("actionSwitch no match; disabled label={}", fallbackLabel);
            return out;
        }

        nlohmann::json ResolveOptionsArray(const nlohmann::json& options, bool focusHasStrippedItems)
        {
            nlohmann::json out = nlohmann::json::array();
            if (!options.is_array())
                return out;
            for (auto& opt : options) {
                if (!opt.is_object()) {
                    out.push_back(opt);
                    continue;
                }
                if (EqualsIgnoreCase(opt.value("type", ""), "actionSwitch")) {
                    out.push_back(ResolveActionSwitch(opt, focusHasStrippedItems));
                    continue;
                }
                if (EqualsIgnoreCase(opt.value("type", ""), "pulldown") && opt.contains("options")) {
                    nlohmann::json copy = opt;
                    copy["options"] = ResolveOptionsArray(opt["options"], focusHasStrippedItems);
                    out.push_back(std::move(copy));
                    continue;
                }
                out.push_back(opt);
            }
            return out;
        }
    }

    /// Public path to the WebUI JSON config directory (actions_index / menu/target).
    std::filesystem::path WebUIDir()
    {
        return ResolveWebUIDir();
    }

    /// True after a successful Load() of actions_index.json and menu/target.
    bool IsLoaded()
    {
        return g_loaded;
    }

    bool IsStayOpenAction(const std::string& actionName)
    {
        return EqualsIgnoreCase(actionName, "outfit_dress") || EqualsIgnoreCase(actionName, "outfit_undress");
    }

    /// Loads actions_index.json and menu/target (defaults.json + options/*.json) into the catalog.
    /// Builds name index used by the target menu and ExecuteAction.
    bool Load()
    {
        g_actions.clear();
        g_byName.clear();
        g_targetOptions = nlohmann::json::object();
        g_loaded = false;

        const auto dir = ResolveWebUIDir();
        const auto indexPath = dir / "actions_index.json";
        const auto menuDir = dir / "menu" / "target";
        const auto defaultsPath = menuDir / "defaults.json";
        const auto optionsDir = menuDir / "options";

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

            auto defaultsRaw = ReadFile(defaultsPath);
            if (defaultsRaw.empty()) {
                webui_log::error("ActionCatalog: missing or empty {}", defaultsPath.string());
                return false;
            }
            auto defaultsJson = nlohmann::json::parse(defaultsRaw);
            if (!defaultsJson.is_object()) {
                webui_log::error("ActionCatalog: {} root must be an object", defaultsPath.string());
                return false;
            }

            nlohmann::json defaultsParameters = nlohmann::json::object();
            if (defaultsJson.contains("defaultsParameters") && defaultsJson["defaultsParameters"].is_object())
                defaultsParameters = defaultsJson["defaultsParameters"];
            else if (defaultsJson.contains("defaults") && defaultsJson["defaults"].is_object())
                defaultsParameters = defaultsJson["defaults"];

            if (!std::filesystem::is_directory(optionsDir)) {
                webui_log::error("ActionCatalog: missing options directory {}", optionsDir.string());
                return false;
            }

            std::vector<std::filesystem::path> optionFiles;
            for (const auto& entry : std::filesystem::directory_iterator(optionsDir)) {
                if (!entry.is_regular_file())
                    continue;
                if (entry.path().extension() != ".json")
                    continue;
                optionFiles.push_back(entry.path());
            }
            std::sort(optionFiles.begin(), optionFiles.end(), [](const auto& a, const auto& b) {
                return a.filename().string() < b.filename().string();
            });

            nlohmann::json optionsArr = nlohmann::json::array();
            for (const auto& path : optionFiles) {
                auto raw = ReadFile(path);
                if (raw.empty()) {
                    webui_log::warn("ActionCatalog: skipping empty option file {}", path.string());
                    continue;
                }
                auto node = nlohmann::json::parse(raw);
                if (!node.is_object()) {
                    webui_log::warn("ActionCatalog: skipping non-object option file {}", path.string());
                    continue;
                }
                optionsArr.push_back(std::move(node));
            }
            if (optionsArr.empty())
                webui_log::warn("ActionCatalog: no option files loaded from {}", optionsDir.string());

            g_targetOptions = nlohmann::json::object();
            g_targetOptions["defaultsParameters"] = std::move(defaultsParameters);
            g_targetOptions["options"] = std::move(optionsArr);
            g_loaded = true;
            webui_log::info(
                "ActionCatalog loaded {} actions, {} target options",
                g_actions.size(),
                g_targetOptions["options"].size());
            return true;
        } catch (const std::exception& e) {
            webui_log::error("ActionCatalog::Load failed: {}", e.what());
            return false;
        }
    }

    /// Looks up a loaded ActionDef by SkyrimNet action name; nullptr if missing.
    /// Also resolves runtime-registered TargetMenuRegistry options.
    const ActionDef* FindByName(const std::string& name)
    {
        auto it = g_byName.find(name);
        if (it != g_byName.end())
            return &g_actions[it->second];
        return TargetMenuRegistry::FindActionDef(name);
    }

    /// Assembled target menu object (defaultsParameters + options) used when building UI params.
    const nlohmann::json& TargetOptions()
    {
        return g_targetOptions;
    }

    /// Builds the JSON catalog JS configureTargetMenu expects (defaultsParameters, options, actions).
    /// Loads the catalog first if it is not already loaded. Resolves actionSwitch nodes.
    nlohmann::json BuildUICatalog(bool focusHasStrippedItems)
    {
        if (!g_loaded)
            Load();

        nlohmann::json catalog;
        if (g_targetOptions.contains("defaultsParameters") && g_targetOptions["defaultsParameters"].is_object())
            catalog["defaultsParameters"] = g_targetOptions["defaultsParameters"];
        else
            catalog["defaultsParameters"] = g_targetOptions.value("defaults", nlohmann::json::object());

        catalog["options"] = ResolveOptionsArray(g_targetOptions.value("options", nlohmann::json::array()), focusHasStrippedItems);

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

        for (auto& ext : TargetMenuRegistry::All()) {
            nlohmann::json opt = nlohmann::json::object();
            opt["type"] = "action";
            opt["name"] = ext.actionName;
            opt["label"] = ext.label;
            catalog["options"].push_back(opt);

            nlohmann::json a = nlohmann::json::object();
            a["name"] = ext.actionName;
            a["label"] = ext.label;
            a["customCategory"] = "";
            a["executionFunctionName"] = ext.executionFunctionName;
            a["questEditorId"] = "";
            a["scriptName"] = ext.scriptName;
            nlohmann::json mapping = nlohmann::json::array();
            nlohmann::json m = nlohmann::json::object();
            m["type"] = "target";
            m["name"] = "target";
            m["description"] = "";
            mapping.push_back(m);
            a["parameterMapping"] = mapping;
            actionsObj[ext.actionName] = a;
        }

        catalog["actions"] = actionsObj;
        return catalog;
    }
}
