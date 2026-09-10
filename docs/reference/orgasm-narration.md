# Orgasm narration contract

Canonical gate used by `0550_sexlab_narration.prompt`.

## Gate

```inja
contains(_direct_narration, " is orgasming.")
```

The substring `" is orgasming."` must stay exact on the whole direct-narration string.

## Rules

| Clause type | Must include `" is orgasming."`? |
|-------------|----------------------------------|
| Orgasming actor | **Yes** |
| Denied / non-orgasming | **No** (use denied / “did not orgasm” wording only) |

- Dom: `Handler_DOM.DOMSlave_Orgasmed` → `Scene_Manager.OrgasmCustom` appends `". "+name+" is orgasming."` on purpose — do not strip without updating the prompt.
- Combined / `GetIsOrgasming`: `helpers/sexlab/orgasming.prompt` (`RenderOrgasmingClause`) must emit `" is orgasming."`. Papyrus falls back to `name+" is orgasming. "` if the substring is missing.
- Dom Combined fallback: if orgasm expected and totals > 0 but custom text raced empty, still append via `RenderOrgasmingClause` (same gate).
- `OrgasmIndividual` may append `" is not orgasming."` (`helpers/sexlab/not_orgasming.prompt`) for other actors — that must **not** match the orgasm gate.

If you change the gate in the prompt, update every Papyrus narration site that appends it.

## Example (Papyrus)

[`Scripts/Source/SkyrimNet_SexLab_Scene_Manager.psc`](../../Scripts/Source/SkyrimNet_SexLab_Scene_Manager.psc) — `OrgasmCustom`:

```papyrus
Function OrgasmCustom(Actor akActor, String msg)
    SkyrimNet_SexLab_Scene sl_scene = GetSceneByActor(akActor)
    if sl_scene == None
        return
    endif
    sl_scene.OrgasmCustom(akActor, msg + ". "+GetDisplayName(akActor)+" is orgasming.")
EndFunction
```

Combined path also builds clauses in [`Scripts/Source/SkyrimNet_SexLab_Scene.psc`](../../Scripts/Source/SkyrimNet_SexLab_Scene.psc) (`RenderOrgasmingClause` / `helpers/sexlab/orgasming.prompt`).
