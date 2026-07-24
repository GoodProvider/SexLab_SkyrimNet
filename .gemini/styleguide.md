# Repository Instructions

Inherit and follow all development guidelines, codebase constraints, and rules defined in the `CLAUDE.md` file located at the root of this repository. 

Treat the rules inside `CLAUDE.md` with high priority.

# Papyrus Coding Style Guide: SkyrimNet_SexLab

## 🛠 Script Architecture
*   **Initialization**: Always use `OnInit()` and `OnPlayerLoadGame()` in `ReferenceAlias` scripts to bridge persistence to the main `Quest` handlers[cite: 7, 10].
*   **Dependency Checks**: Verify external mod presence (e.g., `ostimnet_found`) before calling native functions from those frameworks to prevent VM freezing[cite: 8].
*   **Interface Usage**: Do not modify `Handler_DOM_Interface.txt` directly; implement logic in concrete handlers like `Handler_DOM.txt`[cite: 4, 5].

## 💾 Data Management (JContainers & StorageUtil)
*   **Memory Hygiene**: Any `JMap` or `JArray` created via `JValue.release` must be released at the end of the scope to prevent save-game bloat[cite: 2].
*   **JSON Handling**: Avoid manual string concatenation for JSON payloads (`"{" + ...`). Use `JValue.stringify()` or `JMap` object keys[cite: 3].
*   **State Persistence**: Use `StorageUtil` specifically for actor-bound equipment caching and temporary state flags[cite: 8, 9].

## ⚠️ Error Prevention & Anti-Patterns
*   **Type Safety**: Never pass a String literal into a parameter slot expecting an `Actor` form[cite: 1].
*   **Syntax Audits**: Watch for "keyword doubling" (e.g., `Function Function`) which causes immediate compiler crashes[cite: 1].
*   **Form Lookups**: Wrap all `Game.GetFormFromFile` calls in `if (targetForm)` checks to avoid calling methods on `None`[cite: 8].
*   **MCM Logic**: Ensure float comparisons include a decimal (e.g., `== 0.0`) to match MCM parameter types correctly[cite: 9].

## 📝 Naming Conventions
*   **Event Keys**: Use the prefix `SkyrimNet_SexLab_` for all `ModEvent` registrations (e.g., `SkyrimNet_SexLab_Action_Start`)[cite: 1, 6].
*   **Boolean Flags**: Prefix with `is` or `has` (e.g., `isSubmissive`, `hasLOS`)[cite: 3, 4].
*   **Member Variables**: Use lowercase for local script variables and underscore-delimited names for global properties[cite: 8, 9].