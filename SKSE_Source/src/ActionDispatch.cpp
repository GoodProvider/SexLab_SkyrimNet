#include "ActionDispatch.h"
#include "WebUI_Log.h"

#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"

#include <cctype>

namespace ActionCatalog
{
    namespace
    {
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

        bool IsActorDictEntry(const nlohmann::json& entry)
        {
            if (!entry.is_object())
                return false;
            auto t = entry.value("type", "");
            return EqualsIgnoreCase(t, "Actor");
        }

        bool IsStringDictEntry(const nlohmann::json& entry)
        {
            if (!entry.is_object())
                return false;
            auto t = entry.value("type", "");
            return EqualsIgnoreCase(t, "String") || EqualsIgnoreCase(t, "string");
        }

        void MergeDict(nlohmann::json& dest, const nlohmann::json& src)
        {
            if (!src.is_object())
                return;
            for (auto it = src.begin(); it != src.end(); ++it) {
                dest[it.key()] = it.value();
            }
        }

        // Normalize flat string "foo" or typed {type,default} into typed entry
        nlohmann::json NormalizeParamValue(const nlohmann::json& v)
        {
            if (v.is_object())
                return v;
            if (v.is_string())
                return nlohmann::json{ { "type", "String" }, { "default", v.get<std::string>() } };
            if (v.is_boolean())
                return nlohmann::json{ { "type", "String" }, { "default", v.get<bool>() ? "true" : "false" } };
            if (v.is_number())
                return nlohmann::json{ { "type", "String" }, { "default", std::to_string(v.get<double>()) } };
            return nlohmann::json{ { "type", "String" }, { "default", "" } };
        }

        std::string StringValueOf(const nlohmann::json& entry, const std::string& keyForBackup)
        {
            if (entry.is_object()) {
                if (entry.contains("default") && entry["default"].is_string())
                    return entry["default"].get<std::string>();
                if (entry.contains("value") && entry["value"].is_string())
                    return entry["value"].get<std::string>();
            }
            if (entry.is_string())
                return entry.get<std::string>();

            webui_log::error("ActionDispatch: unset String param '{}'", keyForBackup);
            if (keyForBackup == "style")
                return "normally";
            if (keyForBackup == "direction")
                return "giving";
            return "";
        }

        std::string FirstPipeValue(const std::string& description)
        {
            auto pos = description.find('|');
            if (pos == std::string::npos)
                return {};
            // take substring before first |, trim spaces
            std::string first = description.substr(0, pos);
            while (!first.empty() && first.front() == ' ')
                first.erase(first.begin());
            while (!first.empty() && first.back() == ' ')
                first.pop_back();
            // strip leading prose if description is "forcefully|normally|gently"
            return first;
        }

        RE::Actor* ResolveSource(const std::string& source, RE::Actor* player, RE::Actor* focus)
        {
            if (EqualsIgnoreCase(source, "player"))
                return player;
            if (EqualsIgnoreCase(source, "target") || EqualsIgnoreCase(source, "focus"))
                return focus;
            webui_log::error("ActionDispatch: unknown Actor source '{}'", source);
            return nullptr;
        }

        bool MappingLooksLikeActor(const ParamMapping& pm, const nlohmann::json& dict)
        {
            if (EqualsIgnoreCase(pm.type, "speaker") || EqualsIgnoreCase(pm.type, "target"))
                return true;
            if (dict.contains(pm.name) && IsActorDictEntry(dict[pm.name]))
                return true;
            // common actor arg names when YAML still uses type: dynamic
            static const char* kActorNames[] = {
                "speaker", "target", "victim", "participate", "participate_3",
                "stripper", "stripped", "actor"
            };
            for (auto* n : kActorNames) {
                if (EqualsIgnoreCase(pm.name, n))
                    return true;
            }
            return false;
        }

        class DynamicArgs : public RE::BSScript::IFunctionArguments
        {
        public:
            enum class Kind { Actor, String, Bool };

            struct Item {
                Kind kind = Kind::String;
                RE::Actor* actor = nullptr;
                std::string str;
                bool b = false;
            };

            std::vector<Item> items;

            bool operator()(RE::BSScrapArray<RE::BSScript::Variable>& a_dst) const override
            {
                a_dst.resize(static_cast<RE::BSTArrayBase::size_type>(items.size()));
                for (std::uint32_t i = 0; i < static_cast<std::uint32_t>(items.size()); ++i) {
                    switch (items[i].kind) {
                    case Kind::Actor:
                        a_dst[i].Pack(items[i].actor);
                        break;
                    case Kind::String:
                        a_dst[i].Pack(RE::BSFixedString(items[i].str.c_str()));
                        break;
                    case Kind::Bool:
                        a_dst[i].Pack(items[i].b);
                        break;
                    }
                }
                return true;
            }
        };

        RE::TESQuest* FindQuest(const std::string& editorId)
        {
            if (!editorId.empty()) {
                if (auto* q = RE::TESForm::LookupByEditorID<RE::TESQuest>(editorId))
                    return q;
            }
            // Fallback: this mod's main quest
            return RE::TESDataHandler::GetSingleton()
                ->LookupForm<RE::TESQuest>(0x800, "SkyrimNet_SexLab.esp");
        }
    }

    bool ExecuteAction(
        const std::string& actionName,
        const nlohmann::json& uiParameters,
        RE::Actor* player,
        RE::Actor* focusTarget)
    {
        if (!IsLoaded() && !Load()) {
            webui_log::error("ExecuteAction: catalog not loaded");
            return false;
        }

        const ActionDef* def = FindByName(actionName);
        if (!def || def->executionFunctionName.empty()) {
            webui_log::error("ExecuteAction: unknown or non-executable action '{}'", actionName);
            return false;
        }

        nlohmann::json dict = nlohmann::json::object();

        // 1) YAML statics as String defaults
        for (auto& pm : def->parameterMapping) {
            if (EqualsIgnoreCase(pm.type, "static") && pm.hasValue) {
                dict[pm.name] = nlohmann::json{
                    { "type", "String" },
                    { "default", pm.value }
                };
            }
        }

        // 2) target_options defaults
        MergeDict(dict, TargetOptions().value("defaults", nlohmann::json::object()));

        // 3+4) UI / option parameters (already merged on JS side into payload.parameters)
        if (uiParameters.is_object()) {
            for (auto it = uiParameters.begin(); it != uiParameters.end(); ++it) {
                dict[it.key()] = NormalizeParamValue(it.value());
            }
        }

        auto args = std::make_shared<DynamicArgs>();

        for (auto& pm : def->parameterMapping) {
            if (pm.name.empty())
                continue;

            if (MappingLooksLikeActor(pm, dict)) {
                std::string source = "player";
                if (EqualsIgnoreCase(pm.type, "target") || EqualsIgnoreCase(pm.name, "target") ||
                    EqualsIgnoreCase(pm.name, "stripped") || EqualsIgnoreCase(pm.name, "victim")) {
                    source = "target";
                }
                if (dict.contains(pm.name) && IsActorDictEntry(dict[pm.name])) {
                    source = dict[pm.name].value("source", source);
                } else if (EqualsIgnoreCase(pm.type, "speaker") || EqualsIgnoreCase(pm.name, "speaker") ||
                           EqualsIgnoreCase(pm.name, "stripper")) {
                    source = "player";
                    if (dict.contains(pm.name) && IsActorDictEntry(dict[pm.name]))
                        source = dict[pm.name].value("source", "player");
                }

                RE::Actor* actor = ResolveSource(source, player, focusTarget);
                if (!actor) {
                    webui_log::error(
                        "ExecuteAction: missing Actor for '{}' (action {}, source {})",
                        pm.name, actionName, source);
                    return false;
                }
                DynamicArgs::Item item;
                item.kind = DynamicArgs::Kind::Actor;
                item.actor = actor;
                args->items.push_back(item);
                continue;
            }

            // String / scalar
            std::string value;
            if (EqualsIgnoreCase(pm.type, "static") && pm.hasValue) {
                value = pm.value;
                if (dict.contains(pm.name))
                    value = StringValueOf(dict[pm.name], pm.name);
            } else if (dict.contains(pm.name)) {
                value = StringValueOf(dict[pm.name], pm.name);
            } else {
                webui_log::error("ExecuteAction: unset dynamic '{}' on action {}", pm.name, actionName);
                value = FirstPipeValue(pm.description);
                if (value.empty()) {
                    if (pm.name == "style")
                        value = "normally";
                    else if (pm.name == "direction")
                        value = "giving";
                }
            }

            DynamicArgs::Item item;
            item.kind = DynamicArgs::Kind::String;
            item.str = value;
            args->items.push_back(item);
        }

        // Capture resolved args for the task (Actor* valid until task runs on main thread same frame)
        struct CapturedArg {
            bool isActor = false;
            RE::Actor* actor = nullptr;
            std::string str;
        };
        std::vector<CapturedArg> captured;
        captured.reserve(args->items.size());
        for (auto& it : args->items) {
            CapturedArg c;
            if (it.kind == DynamicArgs::Kind::Actor) {
                c.isActor = true;
                c.actor = it.actor;
            } else {
                c.str = it.str;
            }
            captured.push_back(std::move(c));
        }

        const std::string scriptName = def->scriptName.empty() ? "SkyrimNet_SexLab_Actions" : def->scriptName;
        const std::string functionName = def->executionFunctionName;
        const std::string questEditorId = def->questEditorId;

        SKSE::GetTaskInterface()->AddTask([captured, scriptName, functionName, questEditorId, actionName]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("ExecuteAction: no VM");
                return;
            }
            auto* quest = FindQuest(questEditorId);
            if (!quest) {
                webui_log::error("ExecuteAction: quest not found for {}", actionName);
                return;
            }
            auto handle = vm->GetObjectHandlePolicy()->GetHandleForObject(
                static_cast<RE::VMTypeID>(quest->GetFormType()), quest);
            RE::BSTSmartPointer<RE::BSScript::Object> scriptObject;
            vm->FindBoundObject(handle, scriptName.c_str(), scriptObject);
            if (!scriptObject) {
                webui_log::error("ExecuteAction: bound script '{}' not found", scriptName);
                return;
            }

            auto* raw = new DynamicArgs();
            for (auto& c : captured) {
                DynamicArgs::Item item;
                if (c.isActor) {
                    item.kind = DynamicArgs::Kind::Actor;
                    item.actor = c.actor;
                } else {
                    item.kind = DynamicArgs::Kind::String;
                    item.str = c.str;
                }
                raw->items.push_back(std::move(item));
            }

            RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
            vm->DispatchMethodCall(scriptObject, RE::BSFixedString(functionName.c_str()), raw, callback);
            webui_log::info("ExecuteAction: dispatched {}::{} ({} args) for {}",
                scriptName, functionName, raw->items.size(), actionName);
        });

        return true;
    }
}
