#pragma once

#include "ActionCatalog.h"

#include "RE/Skyrim.h"

#include <cstdint>
#include <string>
#include <vector>

namespace TargetMenuRegistry
{
    struct ExternalOption {
        std::uint32_t questFormId = 0;
        std::string scriptName;
        std::string executionFunctionName;
        std::string label;
        std::string actionName;
        /// Ready-to-dispatch ActionDef (name = actionName, target param mapping).
        ActionCatalog::ActionDef def;
    };

    /// Drops all registered options (call on PostLoadGame / NewGame).
    void Clear();

    /// Appends an option, or replaces an existing entry with the same
    /// questFormId + scriptName + executionFunctionName.
    void Register(
        RE::TESForm* quest,
        const std::string& scriptName,
        const std::string& executionFunctionName,
        const std::string& label);

    const std::vector<ExternalOption>& All();

    /// Looks up a registered option by synthetic actionName; nullptr if missing.
    const ExternalOption* FindByName(const std::string& actionName);

    /// ActionDef for a registered option, or nullptr.
    const ActionCatalog::ActionDef* FindActionDef(const std::string& actionName);
}
