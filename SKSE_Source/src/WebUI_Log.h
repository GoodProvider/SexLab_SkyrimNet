#pragma once

#include "PCH.h"
#include <format>
#include <source_location>
#include <string>
#include <string_view>

// Logging wrappers that auto-prepend "Namespace::Function" to every message.
// Supports the same call style as SKSE::log:
//   webui_log::info("simple message");
//   webui_log::info("Target: {}, Player: {}", targetName, playerName);
//
// Implementation note: the struct+CTAD pattern is required because C++ does not
// allow a variadic template parameter pack and a std::source_location default
// argument on the same plain function.  The struct constructor handles both;
// CTAD deduces Args at the call site, and source_location::current() captures
// the caller's location as the default.
namespace webui_log {

    namespace detail {
        // Trims MSVC's full signature to "Namespace::Function".
        // "void __cdecl Foo::Bar(int)" -> "Foo::Bar"
        std::string strip_func_name(std::string_view full);
    }

    template<typename... Args>
    struct info {
        info(std::format_string<Args...> fmt, Args&&... args,
             std::source_location loc = std::source_location::current()) {
            SKSE::log::info("[{}] {}", detail::strip_func_name(loc.function_name()),
                            std::format(fmt, std::forward<Args>(args)...));
        }
    };
    template<typename... Args>
    info(std::format_string<Args...>, Args&&...) -> info<Args...>;

    template<typename... Args>
    struct warn {
        warn(std::format_string<Args...> fmt, Args&&... args,
             std::source_location loc = std::source_location::current()) {
            SKSE::log::warn("[{}] {}", detail::strip_func_name(loc.function_name()),
                            std::format(fmt, std::forward<Args>(args)...));
        }
    };
    template<typename... Args>
    warn(std::format_string<Args...>, Args&&...) -> warn<Args...>;

    template<typename... Args>
    struct error {
        error(std::format_string<Args...> fmt, Args&&... args,
              std::source_location loc = std::source_location::current()) {
            SKSE::log::error("[{}] {}", detail::strip_func_name(loc.function_name()),
                             std::format(fmt, std::forward<Args>(args)...));
        }
    };
    template<typename... Args>
    error(std::format_string<Args...>, Args&&...) -> error<Args...>;

    template<typename... Args>
    struct critical {
        critical(std::format_string<Args...> fmt, Args&&... args,
                 std::source_location loc = std::source_location::current()) {
            SKSE::log::critical("[{}] {}", detail::strip_func_name(loc.function_name()),
                                std::format(fmt, std::forward<Args>(args)...));
        }
    };
    template<typename... Args>
    critical(std::format_string<Args...>, Args&&...) -> critical<Args...>;

    template<typename... Args>
    struct debug {
        debug(std::format_string<Args...> fmt, Args&&... args,
              std::source_location loc = std::source_location::current()) {
            SKSE::log::debug("[{}] {}", detail::strip_func_name(loc.function_name()),
                             std::format(fmt, std::forward<Args>(args)...));
        }
    };
    template<typename... Args>
    debug(std::format_string<Args...>, Args&&...) -> debug<Args...>;

}
