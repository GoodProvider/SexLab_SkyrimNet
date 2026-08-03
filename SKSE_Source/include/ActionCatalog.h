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
        /// ESP/ESL name for LookupForm(localId, plugin); empty → use questFormId as full ID or editorId.
        std::string questPlugin;
        /// Local FormID when questPlugin set; else full FormID for runtime registry (0 = editorId / default).
        std::uint32_t questFormId = 0;
        std::string scriptName;
        std::string executionFunctionName;
        std::vector<ParamMapping> parameterMapping;
        std::string file;
    };

    // Load actions_index.json + menu/target/ + main_panels/ from Data/SKSE/Plugins/SkyrimNet_SexLab/webui/
    bool Load();
    bool IsLoaded();

    const ActionDef* FindByName(const std::string& name);

    /// True for outfit_dress / outfit_undress (menu stays open after start).
    bool IsStayOpenAction(const std::string& actionName);

    // Full catalog for JS configureTargetMenu(...).
    // focusHasStrippedItems: StorageUtil strip-store on focus (currentActor) for actionSwitch.
    nlohmann::json BuildUICatalog(bool focusHasStrippedItems = false);

    /// Catalog for JS configureMainMenu(...): { "panels": [ ... ] } with requiresPlugin filtered.
    nlohmann::json BuildMainPanelsCatalog();

    /// Apply main-panel selection from JS (id or panel key). Closes previous, opens next.
    void SwitchMainPanel(const std::string& key);

    /// Clear current main-panel selection (papyrus close / hide builtins) without selecting another.
    void ClearMainPanelSelection();

    // Assembled menu/target defaultsParameters + options
    const nlohmann::json& TargetOptions();

    std::filesystem::path WebUIDir();
}
