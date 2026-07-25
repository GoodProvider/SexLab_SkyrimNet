#pragma once

#include "PCH.h"
#include <format>
#include <source_location>
#include <string>
#include <string_view>

/// WebUI logging wrappers that prepend "Namespace::Function" to each message.
/// Call style matches SKSE::log: webui_log::info("msg {}", arg).
/// Struct+CTAD is required so a pack and source_location default can coexist.
namespace webui_log {

    namespace detail {
        /// Trims an MSVC function_name() signature down to Namespace::Function.
        std::string strip_func_name(std::string_view full);
    }

    template<typename... Args>
    struct info {
        /// Logs an info line tagged with the caller's Namespace::Function.
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
        /// Logs a warning tagged with the caller's Namespace::Function.
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
        /// Logs an error tagged with the caller's Namespace::Function.
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
        /// Logs a critical failure tagged with the caller's Namespace::Function.
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
        /// Logs a debug line tagged with the caller's Namespace::Function.
        debug(std::format_string<Args...> fmt, Args&&... args,
              std::source_location loc = std::source_location::current()) {
            SKSE::log::debug("[{}] {}", detail::strip_func_name(loc.function_name()),
                             std::format(fmt, std::forward<Args>(args)...));
        }
    };
    template<typename... Args>
    debug(std::format_string<Args...>, Args&&...) -> debug<Args...>;

}
