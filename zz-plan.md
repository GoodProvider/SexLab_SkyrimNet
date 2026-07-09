How can I match these two actors up? Can I convert the formid or the UUID into values that match the UUID in inja? 
<scene_returned_json>
    {
      "Actor": "__formData|SkadiFollower.esp|0x83c",
      "arousal": -1,
      "assailant": 1,
      "creature_description": "",
      "Enjoyment": 0,
      "formID": "-33155012",
      "has_penis": 0,
      "has_pussy": 1,
      "is_dom_slave": 0,
      "is_hermaphrodiate": 0,
      "Name": "Skadi",
      "no_orgasm": 0,
      "notice_level": "Nothing",
      "speaking_modifiers": [],
      "total_orgasm": 0,
      "uuid": "16E3AB4F55781B5F",
      "Victim": 0,
      "wearing_strapon": 0
    }
</scene_returned_json>

<inja_decnpc_json>
{
  "UUID": 1649350245772434200,
  "alchemy": 15,
  ...
  "formId": 4261812284,
  ...
  "name": "Skadi",
  ...
}
</inja_decnpc_json>

## Answer: how to match scene actors to inja `npc.UUID`

These are the **same actor**. The values look different because they are encoded differently, not because they identify different entities.

### UUID (correct match key)

| Source | Value | Notes |
|--------|-------|-------|
| Scene `uuid` | `"16E3AB4F55781B5F"` | SkyrimNet entity UUID (hex string) |
| inja `decnpc` `UUID` | `1649350245772434200` | Same UUID as a JSON number |

```
int("16E3AB4F55781B5F", 16) = 1649350245772434271
```

The inja dump shows `1649350245772434200` (ends in `200`, not `271`) because **JSON/JavaScript cannot represent 64-bit integers exactly**. The last digits are rounded off. **Never compare UUIDs as numbers in inja.**

**Do this instead:**

- Papyrus: `SkyrimNetApi.GetEntityUUID(akActor)` → `"16E3AB4F55781B5F"`
- inja: `lower(actor_record.uuid) == lower(npc.UUID)` (string compare, case-insensitive)

Papyrus `GetUUID` in `SkyrimNet_SexLab_Scene.psc` wraps that API.

### formId (same ref, two representations)

| Source | Value | Notes |
|--------|-------|-------|
| Scene `formID` | `"-33155012"` | Signed 32-bit `GetFormID()` as string |
| inja `formId` | `4261812284` | Unsigned 32-bit same bit pattern |

```
-33155012 (signed int32) == 4261812284 (unsigned) == 0xFE06183C
```

These match each other, but **do not match** `npc.UUID` and are awkward to compare across signed/unsigned JSON. Prefer UUID strings for inja matching.

### `__formData|SkadiFollower.esp|0x83c` (base record, not the live ref)

This is the **base NPC record** local ID (`0x83c`) in `SkadiFollower.esp`, from JContainers `JString.encodeFormToString`. It is **not** the runtime actor reference ID and is **not** the SkyrimNet entity UUID. Useful for plugin/editor lookups only.

### Recommended inja pattern

Same as `0550_sexlab_narration.prompt`:

1. Look up by display name: `at(sexlab.Actors, npc.name)`
2. Confirm identity: `lower(actor_record.uuid) == lower(npc.UUID)`
3. Use `npc.UUID` (string) for decorators: `get_faction_rank`, `sexlab_get_threads`, etc.

### What was fixed

- `SetActor` stores uuid via `GetUUID()` → `SkyrimNetApi.GetEntityUUID`
- `formid` stored as int (`JMap.setInt`) so JSON serializes as unsigned `4261812284`, matching `decnpc.formId`
- `0050_sexlab_activity.prompt`: fixed `npd.UUID` typo, replaced broken `for actor in sexlab.actors` loop with name + UUID string match
