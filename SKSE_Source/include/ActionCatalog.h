#pragma once

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
        std::string scriptName;
        std::string executionFunctionName;
        std::vector<ParamMapping> parameterMapping;
        std::string file;
    };

    // Load actions_index.json + target_options.json from Data/SKSE/Plugins/SkyrimNet_SexLab/webui/
    bool Load();
    bool IsLoaded();

    const ActionDef* FindByName(const std::string& name);

    // Full catalog for JS configureTargetMenu(...)
    nlohmann::json BuildUICatalog();

    // target_options.json defaults + options
    const nlohmann::json& TargetOptions();

    std::filesystem::path WebUIDir();
}
