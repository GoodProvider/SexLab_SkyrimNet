#pragma once

#include "ActionCatalog.h"
#include "RE/Skyrim.h"
#include <nlohmann/json.hpp>
#include <string>

namespace ActionCatalog
{
    bool ExecuteAction(
        const std::string& actionName,
        const nlohmann::json& uiParameters,
        RE::Actor* player,
        RE::Actor* focusTarget);
}
