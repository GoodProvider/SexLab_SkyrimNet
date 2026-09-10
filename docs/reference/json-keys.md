# External JSON keys

Canonical rules for JSON that Skyrim emits and external consumers read (decorators, `threads.json`, prompts).

## Rule

Use **bare lowercase** keys only:

- `speaking_modifiers`, `actors`, `uuid`, `victim`, `notice_level`, `threads`, …

Do **not** invent Title Case or leading-`_` keys (`Actors`, `_actors`) for this pipeline.

Always serialize via `ObjectToLowerCaseKeyJson` / `JsonLowerCaseKeys` so export casing is stable under Skyrim’s string pool.

Protocol **values** (speaking modifiers) are separate — still `_pain_`, etc. See [protocol-tokens.md](protocol-tokens.md).

## Implementation

[`Scripts/Source/SkyrimNet_SexLab_Utilities.psc`](../../Scripts/Source/SkyrimNet_SexLab_Utilities.psc) (excerpt):

```papyrus
; Serialize JValue -> JSON string with all object keys lowercased. Empty/invalid -> "{}".
; Only project call site for JValue.toJsonString.
String Function ObjectToLowerCaseKeyJson(int obj) global
    String json = JValue.toJsonString(obj)
    json = JsonLowerCaseKeys(json)
    if !json
        return "{}"
    endif
    return json
EndFunction
```

Call sites include scene/thread export in `SkyrimNet_SexLab_Scene.psc` / `SkyrimNet_SexLab_Scene_Manager.psc`, stages export in `SkyrimNet_SexLab_Stages.psc`, and `RenderSlPrompt` in `SkyrimNet_SexLab_Utilities.psc`.
