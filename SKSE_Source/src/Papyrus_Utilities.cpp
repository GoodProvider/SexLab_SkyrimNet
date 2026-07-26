#include "Papyrus_Utilities.h"
#include "WebUI_Log.h"
#include <algorithm>
#include <cctype>
#include <nlohmann/json.hpp>

namespace PapyrusBindings_Utilities
{
    /// Recursively rebuilds JSON with all object keys converted to lowercase (ASCII).
    /// Case-only key collisions use last-wins. Arrays and scalars are left structurally intact.
    static nlohmann::json LowerCaseKeys(const nlohmann::json& in)
    {
        if (in.is_object()) {
            nlohmann::json out = nlohmann::json::object();
            for (auto it = in.begin(); it != in.end(); ++it) {
                std::string key = it.key();
                std::transform(key.begin(), key.end(), key.begin(),
                    [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
                out[key] = LowerCaseKeys(it.value());
            }
            return out;
        }
        if (in.is_array()) {
            nlohmann::json out = nlohmann::json::array();
            for (const auto& el : in) {
                out.push_back(LowerCaseKeys(el));
            }
            return out;
        }
        return in;
    }

    /// Parses json, lowercases all object keys recursively, returns compact dump.
    /// Invalid or empty input returns "" and logs a warning.
    RE::BSFixedString JsonLowerCaseKeys(RE::StaticFunctionTag*, RE::BSFixedString json)
    {
        const char* raw = json.c_str() ? json.c_str() : "";
        if (!raw[0]) {
            webui_log::warn("JsonLowerCaseKeys: empty input");
            return RE::BSFixedString("");
        }

        try {
            auto parsed = nlohmann::json::parse(raw);
            auto lowered = LowerCaseKeys(parsed);
            return RE::BSFixedString(lowered.dump());
        } catch (const nlohmann::json::exception& e) {
            webui_log::warn("JsonLowerCaseKeys: parse failed: {}", e.what());
            return RE::BSFixedString("");
        } catch (...) {
            webui_log::warn("JsonLowerCaseKeys: unexpected failure");
            return RE::BSFixedString("");
        }
    }

    /// Binds JsonLowerCaseKeys on SkyrimNet_SexLab_Utilities.
    bool Register_Utilities_Functions(RE::BSScript::IVirtualMachine* a_vm)
    {
        if (!a_vm) {
            webui_log::error("Couldn't get Papyrus Virtual Machine.");
            return false;
        }

        constexpr std::string_view scriptName = "SkyrimNet_SexLab_Utilities";

        a_vm->RegisterFunction("JsonLowerCaseKeys", scriptName, JsonLowerCaseKeys);

        webui_log::info("Successfully registered Papyrus functions for {}", scriptName);
        return true;
    }
}
