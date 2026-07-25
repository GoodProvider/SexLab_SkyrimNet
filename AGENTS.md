# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Skyrim mode that acts as a bridge between SkyrimNet and SexLab Framework.

## Key Paths

- **Repository root**: `c:\Skyrim\dev\mods\SkyrimNet_SexLab`
- **Project Scripts (source)**: `Scripts/Source`
- **Compiled Scripts output**: `Scripts` (project `Output`)
- **Papyrus Headers**: `Headers`

These are the authoritative locations used by the Papyrus project file `skyrimse.ppj` for imports and compilation.

## WebUI / SKSE / PrismaUI

See **[Guides/WebUI.md](Guides/WebUI.md)** for SKSE_Source, PrismaUI view paths, CMake build tasks, and WebUI config (`target_options.json` / `actions_index.json`).

# Papyrus rules 
- Papyrus is case insensitive, so these are only for human reviewers
- Papyrus does not allow an array variable (String[] a for example) to be compared to None `if a == None`, it must always be checked directly `if a`
```Papayrus
String[] a = None 
; This will check that a is not None and not empty.
if a 
; This will cause run time errors
if a == None
- Papyrus is case insensitive (aA == Aa == aa == AA) 
```
  
   - correct `String[] a = None; If a 

## String case and external consumers
- Skyrim is case-insensitive for string identity. It uses the **first casing** of a given string that appears in the load order; later sources that differ only by case reuse that pooled form.
- The game's **internal casing is unstable** across installs/load orders — do not rely on Title Case vs lowercase surviving unchanged.
- When a string must be matched **outside** Skyrim (prompts, Inja `contains`, JSON tooling, SKSE plugins that do case-sensitive compares), wrap the token in underscores to guarantee uniqueness and a stable literal, e.g. `_pleasure_`, `_pain_`, `_gagged_`, `_kissing_`.
- Plain English words without wrapping are unsafe as protocol tokens for external matching.

## SexLab orgasm narration (`" is orgasming."`)
- `0550_sexlab_narration.prompt` gates orgasm instructions with `contains(_direct_narration, " is orgasming.")` on the **whole** direct narration string.
- In multi-actor Combined/custom narration: every **orgasming** actor clause **must** include the exact substring `" is orgasming."`; **non-orgasming / denied** actor clauses **must not** include it (use denied / “did not orgasm” wording only).
- `Scene_Manager.OrgasmCustom` appends `". "+name+" is orgasming."` on purpose so Dom/`DOMSlave_Orgasmed` messages trigger that prompt. Do not strip or rephrase that append without updating the prompt.
- Non-Dom Combined uses `name+" is orgasming. "` for the same contract.
- Dom Combined fallback: if `orgasm_expected` and totals > 0 but `customer_orgasm_messages[i]` is empty, still append `name+" is orgasming. "` (custom never arrived / race). Denied path must not use that substring.

## JSON keys for Skyrim-generated, externally processed JSON
- Keys in JSON that Skyrim emits and that is consumed outside the game (decorators, threads.json, prompts) **must start with an underscore**, e.g. `_speaking_modifiers`, `_actors`, `_uuid`.
- Leading `_` keeps keys unique under Skyrim's case-insensitive string pool and stable for case-sensitive external consumers.
- Do not invent new bare keys (`speaking_modifiers`, `Actors`) for that pipeline; prefer `_speaking_modifiers`-style names.

## naming convention  
- Constant variable are all upper case: THIS_IS_A_CONSTANT
- properties and variables:
   -  start with a lower case letter: thisIsAVairable,  thisIs_Variable
   - use mix of snake_case and camelCase
- Functions and Events start with an Upper case letter. ThisIsAFunction, ThisIs_Function
   - Match case to the close EndFunction, EndEvent 

## Installed Modding Tools
Always include commented lines when calculating line number.

## 

## Debug Traces Log files 
Debug Trace message should always start with "---"  `Trace("FunctionName", "--- this is a debug message")`
- **SkyrimNet_SexLab**: C:\Users\bhuff\OneDrive\Documents\my games\Skyrim Special Edition\SKSE\SkyrimNet_SexLab.log
   - This is the primary location to look, it contains the log message produced by SkyrimNet_SexLab TraceLog 
- **Papyrus**: C:\Users\bhuff\OneDrive\Documents\my games\Skyrim Special Edition\Logs\Script\Papyrus.0.log
   - This is where to look for None errors.  The matter will look like \_SexLab.*line \, to find the call to SkyrimNet_SexLab code, but you will need 2 to3 the lines above and below for context. 
- **SkyrimNet**: C:\Users\bhuff\OneDrive\Documents\my games\Skyrim Special Edition\SKSE\SkyrimNet.log
   - This can be checked if all else fails and you want to see SkyrimNets view. 
   - This is a last resort, it is very large/verbose expensive to read , alway ask before checking.

**Papyrus compile (required)**: use the VS Code/Cursor task **`compile: pyro`** (`.vscode/tasks.json`). It runs Pyro against `skyrimse.ppj` with the project game path. Do not invent alternate Caprica/`papyrus.exe` one-off compile commands for this repo unless the user asks.

**SKSE / WebUI compile**: see **[Guides/WebUI.md](Guides/WebUI.md)**.

All under `tools/`:

| Tool | Purpose | Usage |
|------|---------|-------|
| **Pyro** | Compile Papyrus `.psc` → `.pex` via project file | Task **`compile: pyro`** (`skyrimse.ppj`) |
| **Champollion** | Decompile Papyrus `.pex` → `.psc` | `tools/Champollion/Champollion.exe input.pex` |
| **XEditLib.dll** | Programmatic ESP/ESM reading via FFI | Load with koffi in Node.js (see below) |
| **Spriggit** | ESP ↔ YAML/JSON conversion (.NET) | `dotnet tool run spriggit serialize ...` / local `serialize.bat` / `deserialize.bat` |

> **Note**: Install tools you need into a `tools/` folder in your game directory. See the [xeditlib](https://github.com/WingedGuardian/xeditlib) repo for XEditLib setup.

## INI Config Hierarchy

Settings load in this order (later overrides earlier):
1. `Skyrim.ini` -- base settings
3. `SkyrimPrefs.ini` -- user preferences (loaded last)

## Nexus Mod Research (Standing Rule)

**Always search a mod's Nexus mod page before investigating it.** Check the description, tutorials/articles, comments, and bug reports before going in blind. This saves enormous time -- most issues have been seen and documented by other users.

## Knowledgebase

`KNOWLEDGEBASE.md` (project root) is the master reference for all discovered quirks, gotchas, and cross-version differences. **Always consult it before making changes** to avoid repeating past mistakes.

**Standing instruction**: After every debugging session, mod investigation, or web research, extract any new facts (engine quirks, VR vs SSE differences, API gotchas, tool limitations) and add them to KNOWLEDGEBASE.md. We learn from everything we come into contact with.

## Top Gotchas (Always In Context)

These are the most dangerous/common pitfalls. Consult `KNOWLEDGEBASE.md` for full details.

1. **RemoveSpell doesn't fire OnEffectFinish** -- use `DispelSpell` when cleanup logic exists
2. **All effects on a spell must have the same casting type** -- mismatches cause silent failure
3. **VMAD editing is fragile** -- use `GetFormFromFile()` to minimize properties; xEdit can't add scripts to VMAD
4. **PlayIdle fails in VR** -- VRIK overrides skeleton IK; bypass with timed Papyrus scripts
5. **Wait() unreliable under 100ms** -- merge sub-100ms gaps; use `RegisterForSingleUpdate` when possible
6. **SSE != VR** for: camera, skeleton, collision, UI, input, SKSE addresses, physics (60Hz->90Hz)
7. **ESL FormIDs must be in xx000800-xx000FFF** -- exceeding = crash or data corruption
8. **Loose files always override BSAs** -- check for loose file conflicts before assuming BSA content wins
9. **Condition OR has precedence over AND** -- `A AND B OR C` != what you'd expect
10. **Non-auto properties don't restore from master on save/load** -- they stay blank
11. **PreWEAPON/PreSHIELD skeleton nodes cause CTD in VR** -- must be removed
12. **ONAM required for ESM temp record overrides** -- missing ONAM = game silently ignores overrides
13. **SetVehicle causes HMD desync in VR** -- avoid entirely
14. **GoToState("") in OnUnload -> Self=None crash** -- move to OnLoad instead
15. **Navmesh creation is CK-only** -- xEdit can only delete, never recreate

## Safety Rules

Hooks in `.claude/settings.json` enforce these automatically:

### Hard blocked (cannot proceed)
- Deleting the game installation directory or config directory
- Deleting Bethesda registry keys
- Directly writing to ESP/ESM/ESL/BSA/BA2 files (use xelib or modding tools)

### Requires user confirmation
y **Any edit to ANY file** in the game directory or config directory (catch-all)
- Papyrus scripts (`.psc`, `.pex`)
- Skyrim INI files (Skyrim.ini, SkyrimVR.ini, SkyrimPrefs.ini)
- SKSE plugin configs (`Data/SKSE/Plugins/*.ini`)
- Load order files (loadorder.txt, plugins.txt)
- Any `rm`, `mv`, `cp`, redirect, or `sed -i` touching game/config directories
- Any bash command referencing plugin/archive files

### General rules
- **Always review changes before applying** -- this is a delicate install
- Never modify ESP/ESM files directly -- use xelib programmatically or Spriggit
- User is knowledgeable about Skyrim modding and INI settings

### Safety improvement loop
After every session, near-miss, or unexpected outcome, evaluate whether a new hook, expanded protection, or knowledgebase entry could have prevented or caught the issue. Propose new hooks when a pattern of risk emerges -- not reactively after damage, but proactively when you notice a gap. Document proposed hooks in the "Hook Candidates" section of `KNOWLEDGEBASE.md` even if not immediately implemented.

### Audit trail
- Every file edit is auto-backed up to `.claude/backups/` with timestamp
- An audit log at `.claude/backups/AUDIT_LOG.txt` records every file touched, when, and by which tool

## Confidence Levels (Mandatory)

**Before proposing ANY change** to game files, configs, scripts, or ESP records, you MUST:

1. **State a confidence level** (0-100%) for each proposed change
2. **List assumptions** that the confidence level depends on
3. **Investigate before acting**: Check the knowledgebase, read relevant source files, and web-search for Skyrim/VR-specific quirks before committing to an approach. Skyrim has many built-in bugs and version-specific differences -- things frequently do NOT work as expected.
4. **Target >= 90% confidence** before touching anything. If below 90%, document what's uncertain and what additional research would raise it.
5. **Never assume Skyrim SE behavior = Skyrim VR behavior.** Always verify VR-specific differences.

### Confidence scale
| Range | Meaning | Action |
|-------|---------|--------|
| 95-100% | Verified via testing, docs, or authoritative source | Proceed with user confirmation |
| 80-94% | Strong evidence but not fully verified | Proceed with caveats noted |
| 60-79% | Reasonable assumption, some unknowns | Research more before proceeding |
| < 60% | Speculative | Do NOT proceed -- investigate first |

### Investigation checklist (before any change)
- [ ] Consulted `KNOWLEDGEBASE.md` for known quirks
- [ ] Read the actual source files involved
- [ ] Web-searched for known issues with this approach
- [ ] Considered rollback path if the change breaks something
- [ ] Evaluated whether this task reveals a gap in current hook coverage