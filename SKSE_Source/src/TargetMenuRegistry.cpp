#include "TargetMenuRegistry.h"
#include "WebUI_Log.h"

#include <format>

namespace TargetMenuRegistry
{
    namespace
    {
        std::vector<ExternalOption> g_options;
        std::size_t g_nextId = 0;

        ActionCatalog::ActionDef MakeDef(const ExternalOption& opt)
        {
            ActionCatalog::ActionDef def;
            def.name = opt.actionName;
            def.label = opt.label;
            def.questFormId = opt.questFormId;
            def.scriptName = opt.scriptName;
            def.executionFunctionName = opt.executionFunctionName;
            ActionCatalog::ParamMapping pm;
            pm.type = "target";
            pm.name = "target";
            def.parameterMapping.push_back(std::move(pm));
            return def;
        }
    }

    void Clear()
    {
        g_options.clear();
        g_nextId = 0;
        webui_log::info("TargetMenuRegistry cleared");
    }

    void Register(
        RE::TESForm* quest,
        const std::string& scriptName,
        const std::string& executionFunctionName,
        const std::string& label)
    {
        if (!quest) {
            webui_log::warn("TargetMenuRegistry::Register ignored (null quest)");
            return;
        }
        if (scriptName.empty() || executionFunctionName.empty()) {
            webui_log::warn(
                "TargetMenuRegistry::Register ignored (empty scriptName or executionFunctionName)");
            return;
        }

        const std::uint32_t formId = quest->GetFormID();

        for (auto& existing : g_options) {
            if (existing.questFormId == formId &&
                existing.scriptName == scriptName &&
                existing.executionFunctionName == executionFunctionName) {
                existing.label = label.empty() ? executionFunctionName : label;
                existing.def = MakeDef(existing);
                webui_log::info(
                    "TargetMenuRegistry replaced {}::{} formId={:08X} label='{}'",
                    scriptName, executionFunctionName, formId, existing.label);
                return;
            }
        }

        ExternalOption opt;
        opt.questFormId = formId;
        opt.scriptName = scriptName;
        opt.executionFunctionName = executionFunctionName;
        opt.label = label.empty() ? executionFunctionName : label;
        opt.actionName = std::format("_ext_{}_{}", g_nextId++, opt.label);
        opt.def = MakeDef(opt);
        g_options.push_back(std::move(opt));

        webui_log::info(
            "TargetMenuRegistry registered {}::{} as '{}' formId={:08X} label='{}'",
            scriptName, executionFunctionName, g_options.back().actionName, formId, g_options.back().label);
    }

    const std::vector<ExternalOption>& All()
    {
        return g_options;
    }

    const ExternalOption* FindByName(const std::string& actionName)
    {
        for (auto& opt : g_options) {
            if (opt.actionName == actionName)
                return &opt;
        }
        return nullptr;
    }

    const ActionCatalog::ActionDef* FindActionDef(const std::string& actionName)
    {
        const auto* opt = FindByName(actionName);
        return opt ? &opt->def : nullptr;
    }
}
