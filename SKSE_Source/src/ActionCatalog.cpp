#include "ActionCatalog.h"
#include "TargetMenuRegistry.h"
#include "WebUI_Log.h"
#include "Papyrus_WebUI.h"
#include "Config.h"

#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"
#include "WebUI.h"

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
        nlohmann::json g_actorOptions = nlohmann::json::object();
        nlohmann::json g_sceneOptions = nlohmann::json::object();
        nlohmann::json g_mainPanels = nlohmann::json::array();
        std::string g_currentMainPanelKey;
        bool g_animationPanelPreferredOpen = false;
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

        bool IsPluginLoaded(const std::string& pluginName)
        {
            if (pluginName.empty())
                return true;
            auto* dh = RE::TESDataHandler::GetSingleton();
            if (!dh)
                return false;
            return dh->LookupModByName(pluginName) != nullptr;
        }

        std::uint32_t ParseFormId(const nlohmann::json& v)
        {
            if (v.is_number_unsigned() || v.is_number_integer())
                return static_cast<std::uint32_t>(v.get<std::uint64_t>());
            if (v.is_string()) {
                auto s = v.get<std::string>();
                if (s.empty())
                    return 0;
                try {
                    if (s.size() > 2 && s[0] == '0' && (s[1] == 'x' || s[1] == 'X'))
                        return static_cast<std::uint32_t>(std::stoul(s, nullptr, 16));
                    return static_cast<std::uint32_t>(std::stoul(s, nullptr, 0));
                } catch (...) {
                    return 0;
                }
            }
            return 0;
        }

        void ParseParameterMapping(const nlohmann::json& item, ActionDef& def)
        {
            if (!item.contains("parameterMapping") || !item["parameterMapping"].is_array())
                return;
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

        /// If an action option carries plugin dispatch fields, register it into g_byName.
        void TrySynthesizeActionFromOption(const nlohmann::json& node)
        {
            if (!node.is_object())
                return;
            if (!EqualsIgnoreCase(node.value("type", ""), "action"))
                return;

            const std::string name = node.value("name", "");
            const std::string scriptName = node.value("scriptName", "");
            const std::string execFn = node.value("executionFunctionName", "");
            if (name.empty() || scriptName.empty() || execFn.empty())
                return;

            // Prefer explicit plugin key; allow questPlugin alias.
            std::string plugin = node.value("plugin", "");
            if (plugin.empty())
                plugin = node.value("questPlugin", "");
            if (plugin.empty() || !node.contains("questFormId"))
                return;

            if (g_byName.count(name)) {
                webui_log::info("ActionCatalog: option action '{}' already in catalog; keeping index entry", name);
                return;
            }

            ActionDef def;
            def.name = name;
            def.label = node.value("label", name);
            def.questPlugin = plugin;
            def.questFormId = ParseFormId(node["questFormId"]);
            def.scriptName = scriptName;
            def.executionFunctionName = execFn;
            ParseParameterMapping(node, def);

            auto idx = g_actions.size();
            g_byName[def.name] = idx;
            g_actions.push_back(std::move(def));
            webui_log::info(
                "ActionCatalog: synthesized action '{}' from option (plugin={} formId={:08X})",
                name,
                plugin,
                g_actions.back().questFormId);
        }

        void WalkOptionsForSynthesis(const nlohmann::json& node)
        {
            if (node.is_array()) {
                for (auto& child : node)
                    WalkOptionsForSynthesis(child);
                return;
            }
            if (!node.is_object())
                return;
            TrySynthesizeActionFromOption(node);
            if (node.contains("options"))
                WalkOptionsForSynthesis(node["options"]);
        }

        bool PassesRequiresPlugin(const nlohmann::json& node)
        {
            if (!node.is_object())
                return true;
            const std::string req = node.value("requiresPlugin", "");
            if (req.empty())
                return true;
            return IsPluginLoaded(req);
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

        class BoolResultCallback : public RE::BSScript::IStackCallbackFunctor
        {
        public:
            void operator()(RE::BSScript::Variable a_result) override
            {
                if (a_result.IsBool())
                    value = a_result.GetBool();
                done = true;
            }
            void SetObject(const RE::BSTSmartPointer<RE::BSScript::Object>&) override {}

            bool value = false;
            bool done = false;
        };

        bool StorageUtilHasIntValue(RE::TESForm* form, const char* key)
        {
            if (!form || !key || !key[0])
                return false;
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm)
                return false;

            auto cbPtr = RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor>{ new BoolResultCallback() };
            auto* cb = static_cast<BoolResultCallback*>(cbPtr.get());

            RE::BSFixedString keyStr(key);
            auto* args = RE::MakeFunctionArguments(static_cast<RE::TESForm*>(form), std::move(keyStr));
            if (!vm->DispatchStaticCall(
                    RE::BSFixedString("StorageUtil"), RE::BSFixedString("HasIntValue"), args, cbPtr)) {
                return false;
            }
            for (int i = 0; i < 64 && !cb->done; ++i)
                vm->Update(0.0f);
            return cb->done && cb->value;
        }

        RE::TESGlobal* ResolveGlobalByArg(std::string_view name)
        {
            if (name.empty())
                return nullptr;
            if (auto* g = RE::TESForm::LookupByEditorID<RE::TESGlobal>(std::string(name)))
                return g;
            // YAML uses SkyrimNet_SexLab_ostim_player; ESP EditorID is lowercase.
            if (EqualsIgnoreCase(name, "SkyrimNet_SexLab_ostim_player"))
                return RE::TESForm::LookupByEditorID<RE::TESGlobal>("skyrimnet_sexlab_ostim_player");
            return nullptr;
        }

        RE::TESFaction* ResolveFactionByArg(std::string_view name)
        {
            if (name.empty())
                return nullptr;
            if (auto* f = RE::TESForm::LookupByEditorID<RE::TESFaction>(std::string(name)))
                return f;
            auto* dh = RE::TESDataHandler::GetSingleton();
            if (!dh)
                return nullptr;
            if (EqualsIgnoreCase(name, "SexLabAnimatingFaction"))
                return dh->LookupForm<RE::TESFaction>(0xE50F, "SexLab.esm");
            if (EqualsIgnoreCase(name, "OStimActorCountFaction") && dh->LookupModByName("Ostim.esp"))
                return dh->LookupForm<RE::TESFaction>(0xECA, "Ostim.esp");
            return nullptr;
        }

        RE::Actor* FocusActor()
        {
            return PapyrusBindings_WebUI::Target_Current;
        }

        bool ArgIsCurrentActor(const nlohmann::json& arg)
        {
            if (!arg.is_string())
                return false;
            return EqualsIgnoreCase(arg.get<std::string>(), "currentActor");
        }

        /// EligibilityRules eval for actionSwitch + pulldown/action gates.
        bool EvalCondition(const nlohmann::json& cond, bool focusHasStrippedItems)
        {
            if (!cond.is_object())
                return false;
            const std::string decorator = cond.value("decoratorName", "");
            const std::string op = cond.value("comparisonOperator", "==");
            const nlohmann::json& expected =
                cond.contains("expectedValue") ? cond["expectedValue"] : nlohmann::json(0);
            const auto& args =
                cond.contains("arguments") && cond["arguments"].is_array() ? cond["arguments"] : nlohmann::json::array();

            if (EqualsIgnoreCase(decorator, "get_global_value")) {
                if (args.empty() || !args[0].is_string())
                    return false;
                auto* global = ResolveGlobalByArg(args[0].get<std::string>());
                const double actual = global ? static_cast<double>(global->value) : 0.0;
                return CompareValues(actual, op, expected);
            }

            if (EqualsIgnoreCase(decorator, "get_faction_rank")) {
                if (args.size() < 2 || !ArgIsCurrentActor(args[0]) || !args[1].is_string())
                    return false;
                auto* actor = FocusActor();
                auto* faction = ResolveFactionByArg(args[1].get<std::string>());
                double rank = -1.0;
                if (actor && faction) {
                    const bool isPlayer = actor == RE::PlayerCharacter::GetSingleton();
                    rank = static_cast<double>(actor->GetFactionRank(faction, isPlayer));
                }
                return CompareValues(rank, op, expected);
            }

            if (EqualsIgnoreCase(decorator, "is_in_faction")) {
                if (args.size() < 2 || !ArgIsCurrentActor(args[0]) || !args[1].is_string())
                    return false;
                auto* actor = FocusActor();
                auto* faction = ResolveFactionByArg(args[1].get<std::string>());
                const bool inFac = actor && faction && actor->IsInFaction(faction);
                return CompareValues(inFac ? 1.0 : 0.0, op, expected);
            }

            if (EqualsIgnoreCase(decorator, "is_in_combat")) {
                if (args.empty() || !ArgIsCurrentActor(args[0]))
                    return false;
                auto* actor = FocusActor();
                const bool inCombat = actor && actor->IsInCombat();
                return CompareValues(inCombat ? 1.0 : 0.0, op, expected);
            }

            if (EqualsIgnoreCase(decorator, "papyrus_util")) {
                if (args.size() < 3 || !args[0].is_string() || !ArgIsCurrentActor(args[1]) || !args[2].is_string())
                    return false;
                const std::string fn = args[0].get<std::string>();
                const std::string key = args[2].get<std::string>();

                if (EqualsIgnoreCase(fn, "FormListCount")) {
                    if (key != "skyrimnet_sexlab_storage_items")
                        return false;
                    const double count = focusHasStrippedItems ? 1.0 : 0.0;
                    return CompareValues(count, op, expected);
                }

                if (EqualsIgnoreCase(fn, "HasIntValue")) {
                    auto* actor = FocusActor();
                    const bool has = actor && StorageUtilHasIntValue(actor, key.c_str());
                    return CompareValues(has ? 1.0 : 0.0, op, expected);
                }
                return false;
            }

            return false;
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
                if (!PassesRequiresPlugin(child))
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
                if (!PassesRequiresPlugin(opt))
                    continue;
                if (opt.contains("eligibilityRules")) {
                    const auto& rules = opt["eligibilityRules"];
                    if (!EvalEligibilityRules(rules, focusHasStrippedItems)) {
                        webui_log::info(
                            "eligibility omit type={} label={}",
                            opt.value("type", ""),
                            opt.value("label", opt.value("name", "")));
                        continue;
                    }
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

        std::string MainPanelKey(const nlohmann::json& entry)
        {
            if (!entry.is_object())
                return {};
            const std::string type = entry.value("type", "");
            if (EqualsIgnoreCase(type, "builtin"))
                return entry.value("panel", "");
            if (EqualsIgnoreCase(type, "papyrus"))
                return entry.value("id", "");
            return {};
        }

        const nlohmann::json* FindMainPanelByKey(const std::string& key)
        {
            if (key.empty() || !g_mainPanels.is_array())
                return nullptr;
            for (auto& entry : g_mainPanels) {
                if (!entry.is_object())
                    continue;
                if (!PassesRequiresPlugin(entry))
                    continue;
                if (MainPanelKey(entry) == key)
                    return &entry;
            }
            return nullptr;
        }

        class EmptyArgs : public RE::BSScript::IFunctionArguments
        {
        public:
            bool operator()(RE::BSScrapArray<RE::BSScript::Variable>& a_dst) const override
            {
                a_dst.resize(0);
                return true;
            }
        };

        void DispatchPapyrusNoArg(
            const std::string& plugin,
            std::uint32_t localFormId,
            const std::string& scriptName,
            const std::string& functionName)
        {
            if (plugin.empty() || localFormId == 0 || scriptName.empty() || functionName.empty()) {
                webui_log::error("DispatchPapyrusNoArg: incomplete target");
                return;
            }
            SKSE::GetTaskInterface()->AddTask([plugin, localFormId, scriptName, functionName]() {
                auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
                if (!vm) {
                    webui_log::error("DispatchPapyrusNoArg: no VM");
                    return;
                }
                auto* quest = RE::TESDataHandler::GetSingleton()
                                  ->LookupForm<RE::TESQuest>(localFormId, plugin);
                if (!quest) {
                    webui_log::error(
                        "DispatchPapyrusNoArg: quest LookupForm({:08X}, {}) failed",
                        localFormId,
                        plugin);
                    return;
                }
                auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                    static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
                RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
                vm->FindBoundObject(handle, scriptName.c_str(), scriptObject);
                if (!scriptObject) {
                    webui_log::error("DispatchPapyrusNoArg: bound script '{}' not found", scriptName);
                    return;
                }
                auto* raw = new EmptyArgs();
                RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
                vm->DispatchMethodCall(scriptObject, RE::BSFixedString(functionName.c_str()), raw, callback);
                webui_log::info("DispatchPapyrusNoArg: {}::{}", scriptName, functionName);
            });
        }

        void CloseMainPanelEntry(const nlohmann::json& entry)
        {
            const std::string type = entry.value("type", "");
            if (EqualsIgnoreCase(type, "builtin")) {
                const std::string panel = entry.value("panel", "");
                if (!panel.empty())
                    WebUI_Invoke("concealMainPanel('" + panel + "');");
            } else if (EqualsIgnoreCase(type, "papyrus")) {
                std::string plugin = entry.value("plugin", "");
                if (plugin.empty())
                    plugin = entry.value("questPlugin", "");
                const auto formId = entry.contains("questFormId") ? ParseFormId(entry["questFormId"]) : 0;
                const std::string script = entry.value("scriptName", "");
                const std::string fn = entry.value("closeFunction", "");
                if (!fn.empty())
                    DispatchPapyrusNoArg(plugin, formId, script, fn);
            }
        }

        void OpenMainPanelEntry(const nlohmann::json& entry)
        {
            const std::string type = entry.value("type", "");
            if (EqualsIgnoreCase(type, "builtin")) {
                const std::string panel = entry.value("panel", "");
                if (!panel.empty()) {
                    WebUI_Invoke("revealMainPanel('" + panel + "');");
                    if (panel == "settings_panel")
                        SexLabNet::InvokeConfigureSettingsPanel();
                    else if (panel == "log_panel")
                        SexLabNet::InvokeLogPanelOpen();
                }
            } else if (EqualsIgnoreCase(type, "papyrus")) {
                std::string plugin = entry.value("plugin", "");
                if (plugin.empty())
                    plugin = entry.value("questPlugin", "");
                const auto formId = entry.contains("questFormId") ? ParseFormId(entry["questFormId"]) : 0;
                const std::string script = entry.value("scriptName", "");
                const std::string fn = entry.value("openFunction", "");
                if (!fn.empty())
                    DispatchPapyrusNoArg(plugin, formId, script, fn);
            }
        }

        std::vector<std::filesystem::path> SortedJsonFiles(const std::filesystem::path& dir)
        {
            std::vector<std::filesystem::path> files;
            if (!std::filesystem::is_directory(dir))
                return files;
            for (const auto& entry : std::filesystem::directory_iterator(dir)) {
                if (!entry.is_regular_file())
                    continue;
                if (entry.path().extension() != ".json")
                    continue;
                files.push_back(entry.path());
            }
            std::sort(files.begin(), files.end(), [](const auto& a, const auto& b) {
                return a.filename().string() < b.filename().string();
            });
            return files;
        }

        nlohmann::json LoadOptionFiles(const std::filesystem::path& optionsDir)
        {
            nlohmann::json optionsArr = nlohmann::json::array();
            if (!std::filesystem::is_directory(optionsDir)) {
                webui_log::warn("ActionCatalog: missing options directory {}", optionsDir.string());
                return optionsArr;
            }
            for (const auto& path : SortedJsonFiles(optionsDir)) {
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
            return optionsArr;
        }

        nlohmann::json LoadDefaultsParameters(const std::filesystem::path& defaultsPath)
        {
            nlohmann::json defaultsParameters = nlohmann::json::object();
            auto defaultsRaw = ReadFile(defaultsPath);
            if (defaultsRaw.empty())
                return defaultsParameters;
            auto defaultsJson = nlohmann::json::parse(defaultsRaw);
            if (!defaultsJson.is_object()) {
                webui_log::warn("ActionCatalog: {} root must be an object", defaultsPath.string());
                return defaultsParameters;
            }
            if (defaultsJson.contains("defaultsParameters") && defaultsJson["defaultsParameters"].is_object())
                return defaultsJson["defaultsParameters"];
            if (defaultsJson.contains("defaults") && defaultsJson["defaults"].is_object())
                return defaultsJson["defaults"];
            return defaultsParameters;
        }

        bool FocusIsInSexLabScene()
        {
            return PapyrusBindings_WebUI::IsSexLabAnimatingFocus(PapyrusBindings_WebUI::Target_Current);
        }

        const nlohmann::json& ActiveTargetOptions()
        {
            return FocusIsInSexLabScene() ? g_sceneOptions : g_actorOptions;
        }
    }

    /// Public path to the WebUI JSON config directory (actions_index / TargetMenu / MainPanels).
    std::filesystem::path WebUIDir()
    {
        return ResolveWebUIDir();
    }

    /// True after a successful Load() of actions_index.json and TargetMenu.
    bool IsLoaded()
    {
        return g_loaded;
    }

    bool IsStayOpenAction(const std::string& actionName)
    {
        return EqualsIgnoreCase(actionName, "outfit_dress") || EqualsIgnoreCase(actionName, "outfit_undress");
    }

    /// Loads actions_index.json, TargetMenu/Actor, TargetMenu/Scene, and MainPanels into the catalog.
    bool Load()
    {
        g_actions.clear();
        g_byName.clear();
        g_actorOptions = nlohmann::json::object();
        g_sceneOptions = nlohmann::json::object();
        g_mainPanels = nlohmann::json::array();
        g_currentMainPanelKey.clear();
        g_loaded = false;

        const auto dir = ResolveWebUIDir();
        const auto indexPath = dir / "actions_index.json";
        const auto actorDir = dir / "TargetMenu" / "Actor";
        const auto sceneDir = dir / "TargetMenu" / "Scene";
        const auto actorDefaultsPath = actorDir / "defaults.json";
        const auto actorOptionsDir = actorDir / "options";
        const auto sceneOptionsDir = sceneDir / "options";
        const auto mainPanelsDir = dir / "MainPanels";

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
                def.questPlugin = item.value("plugin", "");
                if (def.questPlugin.empty())
                    def.questPlugin = item.value("questPlugin", "");
                if (item.contains("questFormId"))
                    def.questFormId = ParseFormId(item["questFormId"]);
                def.scriptName = item.value("scriptName", "");
                def.executionFunctionName = item.value("executionFunctionName", "");
                def.file = item.value("file", "");
                ParseParameterMapping(item, def);
                if (def.name.empty())
                    continue;
                auto idx = g_actions.size();
                g_byName[def.name] = idx;
                g_actions.push_back(std::move(def));
            }

            auto actorDefaults = LoadDefaultsParameters(actorDefaultsPath);
            if (actorDefaults.empty() && ReadFile(actorDefaultsPath).empty()) {
                webui_log::error("ActionCatalog: missing or empty {}", actorDefaultsPath.string());
                return false;
            }
            if (!std::filesystem::is_directory(actorOptionsDir)) {
                webui_log::error("ActionCatalog: missing options directory {}", actorOptionsDir.string());
                return false;
            }

            auto actorOptionsArr = LoadOptionFiles(actorOptionsDir);
            WalkOptionsForSynthesis(actorOptionsArr);
            g_actorOptions = nlohmann::json::object();
            g_actorOptions["defaultsParameters"] = std::move(actorDefaults);
            g_actorOptions["options"] = std::move(actorOptionsArr);

            auto sceneOptionsArr = LoadOptionFiles(sceneOptionsDir);
            WalkOptionsForSynthesis(sceneOptionsArr);
            g_sceneOptions = nlohmann::json::object();
            g_sceneOptions["defaultsParameters"] = nlohmann::json::object();
            g_sceneOptions["options"] = std::move(sceneOptionsArr);

            for (const auto& path : SortedJsonFiles(mainPanelsDir)) {
                auto raw = ReadFile(path);
                if (raw.empty()) {
                    webui_log::warn("ActionCatalog: skipping empty main_panel {}", path.string());
                    continue;
                }
                auto node = nlohmann::json::parse(raw);
                if (!node.is_object()) {
                    webui_log::warn("ActionCatalog: skipping non-object main_panel {}", path.string());
                    continue;
                }
                g_mainPanels.push_back(std::move(node));
            }
            if (g_mainPanels.empty())
                webui_log::warn("ActionCatalog: no MainPanels loaded from {}", mainPanelsDir.string());

            g_loaded = true;
            webui_log::info(
                "ActionCatalog loaded {} actions, {} actor options, {} scene options, {} main panels",
                g_actions.size(),
                g_actorOptions["options"].size(),
                g_sceneOptions["options"].size(),
                g_mainPanels.size());
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
        return ActiveTargetOptions();
    }

    /// Builds the JSON catalog JS configureTargetMenu expects (defaultsParameters, options, actions).
    /// Loads the catalog first if it is not already loaded. Resolves actionSwitch nodes.
    nlohmann::json BuildUICatalog(bool focusHasStrippedItems)
    {
        if (!g_loaded)
            Load();

        const auto& src = ActiveTargetOptions();
        const bool actorCatalog = !FocusIsInSexLabScene();

        nlohmann::json catalog;
        if (src.contains("defaultsParameters") && src["defaultsParameters"].is_object())
            catalog["defaultsParameters"] = src["defaultsParameters"];
        else
            catalog["defaultsParameters"] = src.value("defaults", nlohmann::json::object());

        catalog["options"] = ResolveOptionsArray(
            src.value("options", nlohmann::json::array()),
            focusHasStrippedItems);

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

        if (actorCatalog) {
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
        }

        catalog["actions"] = actionsObj;
        return catalog;
    }

    nlohmann::json BuildMainPanelsCatalog()
    {
        if (!g_loaded)
            Load();

        nlohmann::json catalog;
        nlohmann::json panels = nlohmann::json::array();
        if (g_mainPanels.is_array()) {
            for (auto& entry : g_mainPanels) {
                if (!entry.is_object())
                    continue;
                if (!PassesRequiresPlugin(entry))
                    continue;
                panels.push_back(entry);
            }
        }
        catalog["panels"] = std::move(panels);
        catalog["selected"] = g_currentMainPanelKey;
        return catalog;
    }

    void ClearMainPanelSelection()
    {
        if (!g_currentMainPanelKey.empty()) {
            if (auto* cur = FindMainPanelByKey(g_currentMainPanelKey))
                CloseMainPanelEntry(*cur);
            g_currentMainPanelKey.clear();
        }
    }

    bool IsAnimationPanelPreferredOpen()
    {
        return g_animationPanelPreferredOpen;
    }

    void SetAnimationPanelPreferredOpen(bool open)
    {
        g_animationPanelPreferredOpen = open;
    }

    void SwitchMainPanel(const std::string& key)
    {
        if (!g_loaded)
            Load();

        if (key.empty()) {
            ClearMainPanelSelection();
            g_animationPanelPreferredOpen = false;
            return;
        }

        if (key == g_currentMainPanelKey) {
            // Already selected: re-show DOM only (no connection reload — avoids loop).
            if (auto* cur = FindMainPanelByKey(key)) {
                if (EqualsIgnoreCase(cur->value("type", ""), "builtin"))
                    OpenMainPanelEntry(*cur);
            }
            return;
        }

        if (!g_currentMainPanelKey.empty()) {
            if (auto* prev = FindMainPanelByKey(g_currentMainPanelKey))
                CloseMainPanelEntry(*prev);
        }

        auto* next = FindMainPanelByKey(key);
        if (!next) {
            webui_log::warn("SwitchMainPanel: unknown key '{}'", key);
            g_currentMainPanelKey.clear();
            return;
        }

        g_currentMainPanelKey = key;
        OpenMainPanelEntry(*next);
        webui_log::info("SwitchMainPanel: selected '{}'", key);

        const std::string panel = next->value("panel", "");
        g_animationPanelPreferredOpen = (panel == "animation_menu_panel");

        // One-shot soft connection load when switching TO Scene Menu / Animation.
        if (panel == "scene_creator_panel" || panel == "animation_menu_panel") {
            WebUI_Invoke("mainPanelDidOpen();");
        }
    }
}
