#include "WebUI_Log.h"

namespace webui_log::detail {

    /// Trims MSVC's full signature to "Namespace::Function" for log prefixes.
    /// Strips params, anon-namespace tokens (before space trim), then return/cc.
    std::string strip_func_name(std::string_view full) {
        // Drop parameter list: everything from '(' onward.
        auto paren = full.find('(');
        if (paren != std::string_view::npos)
            full = full.substr(0, paren);

        // Anon tokens contain spaces; strip before rfind(' ') or names break.
        std::string result(full);
        for (std::string_view anon : {"`anonymous namespace'::", "{anonymous}::"}) {
            std::string::size_type pos;
            while ((pos = result.find(anon)) != std::string::npos)
                result.erase(pos, anon.size());
        }

        // Drop return type + calling convention: everything up to the last space.
        auto space = result.rfind(' ');
        if (space != std::string::npos)
            result = result.substr(space + 1);

        return result;
    }

}
