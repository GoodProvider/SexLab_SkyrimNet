# Deferred: Active TargetMenu — SkyrimNet action YAML

**Status:** Deferred to its own run.  
**Related plan:** Active TargetMenu scene-centric editors (TargetMenu UI + Papyrus-only this run).

Do **not** implement these while shipping TargetMenu `type: papyrus` controls. TargetMenu uses dedicated Papyrus entry points; YAML here is for **LLM / SkyrimNet actions**.

## Scope (later run)

Create SkyrimNet action YAML under `SKSE/Plugins/SkyrimNet/config/actions/` (+ prompts as needed), regenerate `actions_index.json` via `tools/generate_actions_index.py`, and wire eligibility `SexLabAnimatingFaction > 0` where appropriate.

| Area | Notes |
|------|--------|
| Stop variants | LLM-facing silent / narrated stop if not covered by existing `SEXLAB_STOP` |
| Stage next / prev | Optional LLM stage control |
| Set / switch animation | Optional LLM; TargetMenu click path stays Papyrus |
| Victim apply | Optional LLM |
| Orgasm + force | Optional LLM |
| **Speaker denies Target** | Speaker causes target deny state |
| **Speaker is denied by Target** | Roles flipped |
| Speaking apply | Wording: speaker **decides/sets** modifiers (not “is the modifier”) |
| Clothed | Prefer existing `outfit_dress` / `outfit_undress`; extend eligibility for animating if needed |
| Rotate / full cast order | YAML speaker-only move is insufficient; TargetMenu uses Papyrus |
| ChangeActors | TargetMenu UI this run; optional LLM multi-actor replace deferred |
| Save animation JSON | **Never** — TargetMenu / AnimationPanel only (`type: papyrus` / Save button) |

## Explicitly out of YAML forever (or until product says otherwise)

- TargetMenu **save to json**
- TargetMenu **rotate** full-cast UI Apply
- AnimationPanel **Save** button

## Checklist (when this run starts)

- [ ] Inventory which TargetMenu Papyrus APIs already exist from the UI run
- [ ] Add YAML only where LLM should invoke the same behavior
- [ ] Deny pair + speaking speaker-decides wording
- [ ] Regenerate `actions_index.json`
- [ ] Refresh SkyrimNet Game Data Explorer actions
- [ ] Update [docs/authors/actions.md](../docs/authors/actions.md) if needed
