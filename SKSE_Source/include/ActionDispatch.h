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

    /// TargetMenu type "papyrus": dispatch by plugin/questFormId/script/exec/mapping (no action name / YAML).
    bool ExecutePapyrusOption(
        const nlohmann::json& optionPayload,
        RE::Actor* player,
        RE::Actor* focusTarget);

    /// True when action resolves as a scene-start (used to gate Custom / SkipSceneCreatorOnce).
    /// editTags* args still apply when callers want MCM gating; TargetMenu Start passes true/true.
    bool ShouldOpenSceneCreatorFromTargetMenu(
        const std::string& actionName,
        const nlohmann::json& uiParameters,
        RE::Actor* player,
        RE::Actor* focusTarget,
        bool editTagsPlayer,
        bool editTagsNonPlayer);

    /// Build Scene Creator JSON from action params and show panel (C++ only; no Papyrus).
    /// Keeps TargetMenu open; Custom may call again to reconfigure.
    bool OpenSceneCreatorFromTargetMenu(
        const std::string& actionName,
        const nlohmann::json& uiParameters,
        RE::Actor* player,
        RE::Actor* focusTarget);
}
