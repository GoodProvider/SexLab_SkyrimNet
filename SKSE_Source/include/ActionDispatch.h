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

    /// Scene-start action + MCM Tag Edit gate for TargetMenu → Scene Creator (no ExecuteAction).
    bool ShouldOpenSceneCreatorFromTargetMenu(
        const std::string& actionName,
        const nlohmann::json& uiParameters,
        RE::Actor* player,
        RE::Actor* focusTarget,
        bool editTagsPlayer,
        bool editTagsNonPlayer);

    /// Build Scene Creator JSON from action params and show panel (C++ only; no Papyrus).
    bool OpenSceneCreatorFromTargetMenu(
        const std::string& actionName,
        const nlohmann::json& uiParameters,
        RE::Actor* player,
        RE::Actor* focusTarget);
}
