#include "ActionDispatch.h"
#include "WebUI_Log.h"
#include "WebUI.h"
#include "Papyrus_WebUI.h"

#include "RE/Skyrim.h"
#include "SKSE/SKSE.h"

#include <cctype>
#include <unordered_map>

// Declared (and defined) in PublicAPI.h — included once from Papyrus_WebUI.cpp.
extern "C" {
    extern uint64_t (*PublicFormIDToUUID)(uint32_t formId);
    extern std::string (*PublicGetActorNameByUUID)(uint64_t uuid);
}

namespace ActionCatalog
{
    namespace
    {
        /// Case-insensitive string equality for YAML / JSON type and name matching.
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

        /// True when a UI/defaults dict entry is a typed Actor object.
        bool IsActorDictEntry(const nlohmann::json& entry)
        {
            if (!entry.is_object())
                return false;
            auto t = entry.value("type", "");
            return EqualsIgnoreCase(t, "Actor");
        }

        /// True when a UI/defaults dict entry is a typed String object.
        bool IsStringDictEntry(const nlohmann::json& entry)
        {
            if (!entry.is_object())
                return false;
            auto t = entry.value("type", "");
            return EqualsIgnoreCase(t, "String") || EqualsIgnoreCase(t, "string");
        }

        /// Shallow-merges src object keys into dest (src wins on conflict).
        void MergeDict(nlohmann::json& dest, const nlohmann::json& src)
        {
            if (!src.is_object())
                return;
            for (auto it = src.begin(); it != src.end(); ++it) {
                dest[it.key()] = it.value();
            }
        }

        /// Root defaults dict: prefer defaultsParameters, fall back to legacy defaults.
        nlohmann::json DefaultsParametersOf(const nlohmann::json& opts)
        {
            if (opts.contains("defaultsParameters") && opts["defaultsParameters"].is_object())
                return opts["defaultsParameters"];
            return opts.value("defaults", nlohmann::json::object());
        }

        /// Recursively finds parameters on an action node matching actionName in options[].
        const nlohmann::json* FindActionParameters(const nlohmann::json& node, const std::string& actionName)
        {
            if (node.is_array()) {
                for (auto& child : node) {
                    if (auto* found = FindActionParameters(child, actionName))
                        return found;
                }
                return nullptr;
            }
            if (!node.is_object())
                return nullptr;

            auto type = node.value("type", "");
            if (EqualsIgnoreCase(type, "action") && node.value("name", "") == actionName) {
                if (node.contains("parameters") && node["parameters"].is_object())
                    return &node["parameters"];
                return nullptr;
            }
            if (node.contains("options"))
                return FindActionParameters(node["options"], actionName);
            return nullptr;
        }

        /// Normalizes a flat UI value or typed {type,default} into a typed dict entry.
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

        /// Reads a String param from a typed entry; style/direction get safe fallbacks if unset.
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

        /// Takes the first pipe-separated token from a YAML description (e.g. style choices).
        std::string FirstPipeValue(const std::string& description)
        {
            auto pos = description.find('|');
            if (pos == std::string::npos)
                return {};
            std::string first = description.substr(0, pos);
            while (!first.empty() && first.front() == ' ')
                first.erase(first.begin());
            while (!first.empty() && first.back() == ' ')
                first.pop_back();
            return first;
        }

        /// Maps Actor source labels to live Actor pointers.
        /// playerActor|player → player; currentActor|target|focus → menu focus.
        RE::Actor* ResolveSource(const std::string& source, RE::Actor* player, RE::Actor* focus)
        {
            if (EqualsIgnoreCase(source, "player") || EqualsIgnoreCase(source, "playerActor"))
                return player;
            if (EqualsIgnoreCase(source, "target") || EqualsIgnoreCase(source, "focus") ||
                EqualsIgnoreCase(source, "currentActor"))
                return focus;
            webui_log::error("ActionDispatch: unknown Actor source '{}'", source);
            return nullptr;
        }

        /// Heuristic: treat a parameterMapping row as an Actor arg for Papyrus dispatch.
        bool MappingLooksLikeActor(const ParamMapping& pm, const nlohmann::json& dict)
        {
            if (EqualsIgnoreCase(pm.type, "speaker") || EqualsIgnoreCase(pm.type, "target"))
                return true;
            if (dict.contains(pm.name) && IsActorDictEntry(dict[pm.name]))
                return true;
            // Common actor arg names when YAML still uses type: dynamic.
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

            /// Packs resolved Actor/String/Bool items into the Papyrus call argument array.
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

        /// Finds the action's quest by plugin+local FormID, full FormID, editor ID, else main quest (0x800).
        RE::TESQuest* FindQuest(
            std::uint32_t questFormId,
            const std::string& editorId,
            const std::string& questPlugin)
        {
            if (!questPlugin.empty() && questFormId != 0) {
                if (auto* q = RE::TESDataHandler::GetSingleton()
                                  ->LookupForm<RE::TESQuest>(questFormId, questPlugin))
                    return q;
                webui_log::warn(
                    "FindQuest: LookupForm({:08X}, {}) failed",
                    questFormId,
                    questPlugin);
            }
            if (questFormId != 0 && questPlugin.empty()) {
                if (auto* q = RE::TESForm::LookupByID<RE::TESQuest>(questFormId))
                    return q;
                webui_log::warn("FindQuest: FormID {:08X} not a quest", questFormId);
            }
            if (!editorId.empty()) {
                if (auto* q = RE::TESForm::LookupByEditorID<RE::TESQuest>(editorId))
                    return q;
            }
            return RE::TESDataHandler::GetSingleton()
                ->LookupForm<RE::TESQuest>(0x800, "SkyrimNet_SexLab.esp");
        }
    }

    /// Dispatches a WebUI-started action to its Papyrus execution function.
    /// Merges YAML statics → defaultsParameters → action-node parameters → UI params, then calls on the main thread.
    /// Returns false if the catalog/action/actors cannot be resolved before dispatch.
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

        // Merge order: YAML statics → defaultsParameters → action-node parameters → UI parameters.
        for (auto& pm : def->parameterMapping) {
            if (EqualsIgnoreCase(pm.type, "static") && pm.hasValue) {
                dict[pm.name] = nlohmann::json{
                    { "type", "String" },
                    { "default", pm.value }
                };
            }
        }

        const auto& opts = TargetOptions();
        MergeDict(dict, DefaultsParametersOf(opts));
        if (opts.contains("options")) {
            if (auto* actionParams = FindActionParameters(opts["options"], actionName))
                MergeDict(dict, *actionParams);
        }

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

        // Actor* must remain valid until the main-thread task runs (same frame).
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
        const std::string questPlugin = def->questPlugin;
        const std::uint32_t questFormId = def->questFormId;

        SKSE::GetTaskInterface()->AddTask([captured, scriptName, functionName, questEditorId, questPlugin, questFormId, actionName]() {
            auto* vm = RE::BSScript::Internal::VirtualMachine::GetSingleton();
            if (!vm) {
                webui_log::error("ExecuteAction: no VM");
                return;
            }
            auto* quest = FindQuest(questFormId, questEditorId, questPlugin);
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

    namespace
    {
        struct ResolvedSceneParams {
            std::string executionFunctionName;
            std::string intent;
            std::string style = "normally";
            std::string method;
            std::string direction;
            std::string setting_name;
            RE::Actor* speaker = nullptr;
            RE::Actor* target = nullptr;
            RE::Actor* victim = nullptr;
            RE::Actor* participate = nullptr;
            std::vector<RE::Actor*> actorsResolved;
            bool hasPlayer = false;
        };

        bool IsSceneStartExecution(const std::string& fn)
        {
            if (fn.size() < 11)
                return false;
            if (!EqualsIgnoreCase(fn.substr(0, 11), "StartScene_"))
                return false;
            // StartScene_Refused_* is narration-only, not a creator open.
            return fn.find("Refused") == std::string::npos && fn.find("refused") == std::string::npos;
        }

        std::string RemapMethod(std::string method)
        {
            if (EqualsIgnoreCase(method, "pussy"))
                return "vaginal";
            if (EqualsIgnoreCase(method, "mouth"))
                return "oral";
            if (EqualsIgnoreCase(method, "ass"))
                return "anal";
            if (EqualsIgnoreCase(method, "whipping"))
                return "whip";
            if (EqualsIgnoreCase(method, "hugging"))
                return "hug";
            if (EqualsIgnoreCase(method, "cuddle"))
                return "cuddling";
            return method;
        }

        /// SexLab animation tag for a UI/LLM method. Cuddle postures stay in _method for narration.
        std::string SexLabTagFromMethod(const std::string& method)
        {
            if (EqualsIgnoreCase(method, "sitting") || EqualsIgnoreCase(method, "laying") ||
                EqualsIgnoreCase(method, "cuddle"))
                return "cuddling";
            return method;
        }

        int SpeakerPositionFromDirection(const std::string& direction, RE::Actor* speaker, RE::Actor* target,
            RE::Actor* victim)
        {
            if (!target)
                return 0;
            if (victim && speaker && victim == speaker)
                return 0;
            if (victim && target && victim == target)
                return 1;
            if (EqualsIgnoreCase(direction, "fucking") || EqualsIgnoreCase(direction, "fuck a") ||
                EqualsIgnoreCase(direction, "fucking a"))
                return 1;
            if (EqualsIgnoreCase(direction, "fucked in"))
                return 0;
            if (EqualsIgnoreCase(direction, "getting") || EqualsIgnoreCase(direction, "get"))
                return 1;
            if (EqualsIgnoreCase(direction, "giving") || EqualsIgnoreCase(direction, "give"))
                return 0;
            return 0;
        }

        void ApplyVictimFromExecution(ResolvedSceneParams& p)
        {
            const auto& fn = p.executionFunctionName;
            if (fn.find("SpeakerVictim") != std::string::npos ||
                EqualsIgnoreCase(fn, "StartScene_Nonconsensual_One")) {
                p.victim = p.speaker;
            } else if (fn.find("TargetVictim") != std::string::npos) {
                p.victim = p.target;
            } else if (fn.find("Nonconsensual") != std::string::npos && !p.victim) {
                // Nonconsensual_Two with explicit victim already set from mapping.
                if (!p.victim && p.target)
                    p.victim = p.target;
            }
        }

        void BuildActorOrder(ResolvedSceneParams& p)
        {
            p.actorsResolved.clear();
            if (!p.speaker)
                return;
            if (!p.target) {
                p.actorsResolved.push_back(p.speaker);
            } else {
                const int speakerPos = SpeakerPositionFromDirection(p.direction, p.speaker, p.target, p.victim);
                if (speakerPos == 0) {
                    p.actorsResolved.push_back(p.speaker);
                    p.actorsResolved.push_back(p.target);
                } else {
                    p.actorsResolved.push_back(p.target);
                    p.actorsResolved.push_back(p.speaker);
                }
                if (p.participate)
                    p.actorsResolved.push_back(p.participate);
            }
            p.hasPlayer = false;
            auto* player = RE::PlayerCharacter::GetSingleton();
            for (auto* a : p.actorsResolved) {
                if (a && player && a == player) {
                    p.hasPlayer = true;
                    break;
                }
            }
        }

        bool ResolveSceneParams(
            const std::string& actionName,
            const nlohmann::json& uiParameters,
            RE::Actor* player,
            RE::Actor* focusTarget,
            ResolvedSceneParams& out)
        {
            if (!IsLoaded() && !Load())
                return false;
            const ActionDef* def = FindByName(actionName);
            if (!def || def->executionFunctionName.empty())
                return false;
            if (!IsSceneStartExecution(def->executionFunctionName))
                return false;

            out.executionFunctionName = def->executionFunctionName;

            nlohmann::json dict = nlohmann::json::object();
            for (auto& pm : def->parameterMapping) {
                if (EqualsIgnoreCase(pm.type, "static") && pm.hasValue) {
                    dict[pm.name] = nlohmann::json{ { "type", "String" }, { "default", pm.value } };
                }
            }
            const auto& opts = TargetOptions();
            MergeDict(dict, DefaultsParametersOf(opts));
            if (opts.contains("options")) {
                if (auto* actionParams = FindActionParameters(opts["options"], actionName))
                    MergeDict(dict, *actionParams);
            }
            if (uiParameters.is_object()) {
                for (auto it = uiParameters.begin(); it != uiParameters.end(); ++it)
                    dict[it.key()] = NormalizeParamValue(it.value());
            }

            std::unordered_map<std::string, RE::Actor*> actorsByName;
            for (auto& pm : def->parameterMapping) {
                if (pm.name.empty())
                    continue;
                if (MappingLooksLikeActor(pm, dict)) {
                    std::string source = "player";
                    if (EqualsIgnoreCase(pm.type, "target") || EqualsIgnoreCase(pm.name, "target") ||
                        EqualsIgnoreCase(pm.name, "stripped") || EqualsIgnoreCase(pm.name, "victim") ||
                        EqualsIgnoreCase(pm.name, "participate") || EqualsIgnoreCase(pm.name, "participate_3")) {
                        source = "target";
                    }
                    if (dict.contains(pm.name) && IsActorDictEntry(dict[pm.name]))
                        source = dict[pm.name].value("source", source);
                    else if (EqualsIgnoreCase(pm.type, "speaker") || EqualsIgnoreCase(pm.name, "speaker") ||
                             EqualsIgnoreCase(pm.name, "stripper")) {
                        source = "player";
                        if (dict.contains(pm.name) && IsActorDictEntry(dict[pm.name]))
                            source = dict[pm.name].value("source", "player");
                    }
                    // participate often uses nearby / currentActor-like sources from defaults.
                    if (EqualsIgnoreCase(pm.name, "participate") || EqualsIgnoreCase(pm.name, "participate_3")) {
                        if (dict.contains(pm.name) && IsActorDictEntry(dict[pm.name]))
                            source = dict[pm.name].value("source", source);
                    }
                    RE::Actor* actor = ResolveSource(source, player, focusTarget);
                    actorsByName[pm.name] = actor;
                    continue;
                }

                std::string value;
                if (EqualsIgnoreCase(pm.type, "static") && pm.hasValue) {
                    value = pm.value;
                    if (dict.contains(pm.name))
                        value = StringValueOf(dict[pm.name], pm.name);
                } else if (dict.contains(pm.name)) {
                    value = StringValueOf(dict[pm.name], pm.name);
                } else {
                    value = FirstPipeValue(pm.description);
                    if (value.empty()) {
                        if (pm.name == "style")
                            value = "normally";
                        else if (pm.name == "direction")
                            value = "giving";
                    }
                }
                if (EqualsIgnoreCase(pm.name, "intent"))
                    out.intent = value;
                else if (EqualsIgnoreCase(pm.name, "style"))
                    out.style = value.empty() ? "normally" : value;
                else if (EqualsIgnoreCase(pm.name, "method"))
                    out.method = value;
                else if (EqualsIgnoreCase(pm.name, "direction"))
                    out.direction = value;
                else if (EqualsIgnoreCase(pm.name, "setting_name"))
                    out.setting_name = value;
            }

            out.speaker = actorsByName.count("speaker") ? actorsByName["speaker"] : player;
            out.target = actorsByName.count("target") ? actorsByName["target"] : nullptr;
            if (!out.target && actorsByName.count("stripped"))
                out.target = actorsByName["stripped"];
            out.victim = actorsByName.count("victim") ? actorsByName["victim"] : nullptr;
            out.participate = actorsByName.count("participate") ? actorsByName["participate"] : nullptr;
            if (!out.participate && actorsByName.count("participate_3"))
                out.participate = actorsByName["participate_3"];

            ApplyVictimFromExecution(out);
            out.method = RemapMethod(out.method);
            BuildActorOrder(out);
            return out.speaker != nullptr && !out.actorsResolved.empty();
        }

        int ActorGenderSexLab(RE::Actor* actor)
        {
            if (!actor)
                return 0;
            if (auto* base = actor->GetActorBase())
                return static_cast<int>(base->GetSex()); // 0 male, 1 female — SexLab human mapping
            return 0;
        }

        std::string ActorUuidDecimal(RE::Actor* actor)
        {
            if (!actor)
                return "0";
            if (PublicFormIDToUUID) {
                uint64_t uuid = PublicFormIDToUUID(actor->GetFormID());
                if (uuid)
                    return std::to_string(uuid);
            }
            // Fallback so Positions rows stay distinct when SkyrimNet UUID is unavailable.
            return std::to_string(static_cast<unsigned>(actor->GetFormID()));
        }

        std::string ActorDisplayName(RE::Actor* actor)
        {
            if (!actor)
                return "Unknown";
            uint64_t uuid = PublicFormIDToUUID ? PublicFormIDToUUID(actor->GetFormID()) : 0;
            if (uuid && PublicGetActorNameByUUID) {
                std::string n = PublicGetActorNameByUUID(uuid);
                if (!n.empty())
                    return n;
            }
            const char* name = actor->GetName();
            return (name && name[0]) ? name : "Unknown";
        }
    }

    bool ShouldOpenSceneCreatorFromTargetMenu(
        const std::string& actionName,
        const nlohmann::json& uiParameters,
        RE::Actor* player,
        RE::Actor* focusTarget,
        bool editTagsPlayer,
        bool editTagsNonPlayer)
    {
        ResolvedSceneParams params;
        if (!ResolveSceneParams(actionName, uiParameters, player, focusTarget, params))
            return false;
        if (params.hasPlayer)
            return editTagsPlayer;
        return editTagsNonPlayer;
    }

    bool OpenSceneCreatorFromTargetMenu(
        const std::string& actionName,
        const nlohmann::json& uiParameters,
        RE::Actor* player,
        RE::Actor* focusTarget)
    {
        // Allow Custom to reconfigure Scene Creator while TargetMenu stays open.
        // SceneCreatorOpenedForPending still tracks that SC was opened from TargetMenu.

        ResolvedSceneParams params;
        const bool resolved = ResolveSceneParams(actionName, uiParameters, player, focusTarget, params);
        if (!resolved) {
            webui_log::warn(
                "OpenSceneCreatorFromTargetMenu: resolve failed for {} — falling back to focus+player seed",
                actionName);
            params.speaker = player;
            params.target = focusTarget;
            params.victim = nullptr;
            params.participate = nullptr;
            params.intent = actionName;
            params.style = "normally";
            params.method = "";
            if (!params.speaker && !params.target) {
                webui_log::error("OpenSceneCreatorFromTargetMenu: no speaker/target to seed");
                return false;
            }
        }

        // Scene Menu UI seed order (ignore direction): target@0, speaker@1, participate@2+.
        // BuildActorOrder remains for Start / ExecuteAction only.
        RE::Actor* seedTarget = params.target ? params.target : focusTarget;
        RE::Actor* seedSpeaker = params.speaker ? params.speaker : player;
        std::vector<RE::Actor*> seedOrder;
        seedOrder.reserve(3);
        if (seedTarget)
            seedOrder.push_back(seedTarget);
        if (seedSpeaker && seedSpeaker != seedTarget)
            seedOrder.push_back(seedSpeaker);
        if (params.participate && params.participate != seedTarget && params.participate != seedSpeaker)
            seedOrder.push_back(params.participate);
        if (seedOrder.empty() && seedSpeaker)
            seedOrder.push_back(seedSpeaker);

        if (seedOrder.empty()) {
            webui_log::error("OpenSceneCreatorFromTargetMenu: empty position seed");
            return false;
        }

        nlohmann::json state;
        state["_creator_sid"] = 0;
        state["_from_target_menu"] = true;
        state["_intent"] = params.intent;
        state["_style"] = params.style.empty() ? "normally" : params.style;
        state["_method"] = params.method;
        state["_event_hook"] = "";
        state["_num_actors"] = static_cast<int>(seedOrder.size());
        state["_tags"] = SexLabTagFromMethod(params.method);
        state["_tags_suppress"] = "";
        state["_scene_presets"] = nlohmann::json::array({ "default" });
        state["_group_tags"] = nlohmann::json::object();
        state["_group_order"] = nlohmann::json::array();

        nlohmann::json positions = nlohmann::json::array();
        for (auto* a : seedOrder) {
            nlohmann::json po;
            po["_name"] = ActorDisplayName(a);
            po["_uuid"] = ActorUuidDecimal(a);
            po["_form_id"] = a ? static_cast<int>(a->GetFormID()) : 0;
            po["_dressed"] = 0;
            po["_no_orgasm"] = 0;
            po["_victim"] = (params.victim && a == params.victim) ? 1 : 0;
            po["_speaking"] = "_pleasure_";
            po["_gender"] = ActorGenderSexLab(a);
            po["_race_key"] = "";
            positions.push_back(std::move(po));
        }
        state["_positions"] = positions;

        PapyrusBindings_WebUI::SceneCreatorOpenedForPending = true;
        // Keep TargetMenu open so the user can push more presets via Custom.
        WebUI_Invoke("hidePanel('sex_menu_panel');");
        WebUI_Invoke("hidePanel('yesno_panel');");
        WebUI_Invoke("hidePanel('animation_menu_panel');");
        WebUI_Invoke(std::string("configureSceneCreator(") + state.dump() + ");");
        WebUI_Invoke("showPanel('scene_creator_panel');");
        // Show refreshes nearby (sync soft list → unselected Positions rows).
        WebUI_Visibility_Show();

        webui_log::info(
            "OpenSceneCreatorFromTargetMenu: {} seeded count={} target@0={} speaker@1={} method={}",
            actionName,
            seedOrder.size(),
            seedTarget ? ActorDisplayName(seedTarget) : "(none)",
            (seedSpeaker && seedSpeaker != seedTarget) ? ActorDisplayName(seedSpeaker) : "(none)",
            params.method);
        return true;
    }
}
