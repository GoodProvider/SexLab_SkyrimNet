#include "WebUI_Log.h"

namespace webui_log::detail {

    std::string strip_func_name(std::string_view full) {
        // Drop parameter list: everything from '(' onward
        auto paren = full.find('(');
        if (paren != std::string_view::npos)
            full = full.substr(0, paren);

        // Strip anonymous-namespace tokens BEFORE the space-trim because
        // MSVC writes "`anonymous namespace'::" which contains a space that
        // would confuse rfind below, leaving "namespace'::Function".
        std::string result(full);
        for (std::string_view anon : {"`anonymous namespace'::", "{anonymous}::"}) {
            std::string::size_type pos;
            while ((pos = result.find(anon)) != std::string::npos)
                result.erase(pos, anon.size());
        }

        // Drop return type + calling convention: everything up to the last space
        auto space = result.rfind(' ');
        if (space != std::string::npos)
            result = result.substr(space + 1);

        return result;
    }

}
