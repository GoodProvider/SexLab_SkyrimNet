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
| Denied / non-orgasming | **No** — Combined and Separate: `name+" is not orgasming right now. "`; Dom denied / afterglow: “did not orgasm” / “failed to orgasm” |

- Dom: `Handler_DOM.DOMSlave_Orgasmed` → `Scene_Manager.OrgasmCustom` appends `". "+name+" is orgasming."` on purpose — do not strip without updating the prompt.
- Combined / `GetIsOrgasming`: Papyrus emits `name+" is orgasming. "` (and `. again.` / tentacles append). Do not strip that substring without updating the prompt.
- Dom Combined fallback: if orgasm expected and totals > 0 but custom text raced empty, still append `name+" is orgasming. "` (same gate).
- Combined flush (`OrgasmMessagesToNarration`) and `OrgasmIndividual` name every non-orgasming actor with `" is not orgasming right now."` instead of a generic “only listed” sentence. That substring must **not** match the orgasm gate.

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

Combined path also builds clauses in [`Scripts/Source/SkyrimNet_SexLab_Scene.psc`](../../Scripts/Source/SkyrimNet_SexLab_Scene.psc) (`GetIsOrgasming`).
