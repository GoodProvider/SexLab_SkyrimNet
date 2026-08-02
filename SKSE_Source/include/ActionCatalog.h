#pragma once

#include <cstdint>
#include <filesystem>
#include <nlohmann/json.hpp>
#include <string>
#include <unordered_map>
#include <vector>

namespace ActionCatalog
{
    struct ParamMapping {
        std::string type;         // static | speaker | dynamic | ...
        std::string name;
        std::string value;        // for static
        std::string description;
        bool hasValue = false;
    };

    struct ActionDef {
        std::string name;
        std::string label;
        std::string customCategory;
        std::string questEditorId;
        /// Session FormID for runtime-registered options (0 = use questEditorId).
        std::uint32_t questFormId = 0;
        std::string scriptName;
        std::string executionFunctionName;
        std::vector<ParamMapping> parameterMapping;
        std::string file;
    };

    // Load actions_index.json + menu/target/ from Data/SKSE/Plugins/SkyrimNet_SexLab/webui/
    bool Load();
    bool IsLoaded();

    const ActionDef* FindByName(const std::string& name);

    /// True for outfit_dress / outfit_undress (menu stays open after start).
    bool IsStayOpenAction(const std::string& actionName);

    // Full catalog for JS configureTargetMenu(...).
    // focusHasStrippedItems: StorageUtil strip-store on focus (currentActor) for actionSwitch.
    nlohmann::json BuildUICatalog(bool focusHasStrippedItems = false);

    // Assembled menu/target defaultsParameters + options
    const nlohmann::json& TargetOptions();

    std::filesystem::path WebUIDir();
}
