# sslThreadController — mid-scene mutability

Agent guide: what can change on a SexLab thread **after** `AnimationStart`.

Source of truth: SexLab Framework AE `sslThreadController.psc` / `sslThreadModel.psc`.

## Lifecycle note

`AnimationStart` fires in **Prepare**. Shortly after: Advancing → **Animating**.

After start the thread is **locked** (`IsLocked` = state ≠ `Unlocked`). Making-only APIs fail.

Most hotkey/scene controls only work in **`Animating`** (empty stubs outside that state). `ChangeActors` works except Ending/Frozen. `SetAnimation` is implemented at script level (not Animating-only).

## Mutability table

| Name | Description | After AnimationStart? |
|------|-------------|------------------------|
| **Actor position slots** (`ChangePositions`) | Swap which actor is in which animation slot | **Yes** (Animating only; not solo/creature) |
| **Offset adjust** (`AdjustForward` / `Sideways` / `Upward` / `Schlong`) | Nudge actor offsets for current stage | **Yes** (Animating) |
| **Scene center** (`CenterOnObject` / `Coords`, `MoveScene`, `RotateScene`) | Move/rotate scene center | **Yes** (Animating; `MoveScene` can rebuild anims) |
| **Reset / realign** (`ResetPositions`, `RealignActors`) | Re-sync actors to poses | **Yes** (Animating) |
| **Current animation** (`ChangeAnimation` / `SetAnimation`) | Switch to another anim already in thread list | **Yes** — index into `Animations` |
| **Animation list** (`SetAnimations`, `SetForcedAnimations`, `AddAnimation`, `Clear*`) | Replace/add anims in the pool | **Yes** to mutate arrays; then `SetAnimation` / `ChangeAnimation` to apply. Forced list overrides primary. `AddAnimation` always adds to **primary** (not forced). |
| **Starting animation** (`SetStartingAnimation`) | First anim before start | **No** — already consumed in Prepare |
| **Add actor** (`AddActor` / `AddActors`) | Add during Making only | **No** — locked stub returns error |
| **Change actors** (`ChangeActors`) | Add/remove/replace cast mid-scene | **Yes** (not Ending/Frozen); re-picks anims if count changes |
| **Victim** (`SetVictim`) | Mark/unmark victim + aggressive flag | **Yes** for flags; pose impact mainly on next `SetAnimation` if `FixVictimPos` / `SortActors` |
| **Stage** (`AdvanceStage`, `GoToStage`) | Jump forward/back in stages | **Yes** (Animating) |
| **Timers** (`SetTimers`, `UpdateTimer`, `AutoAdvance`) | Stage duration / auto-advance | **Yes** |
| **Lead-in** (`DisableLeadIn`, `EndLeadIn`, `SetLeadAnimations`) | Foreplay phase | Partial: can end/disable; starting lead-in after main anim is not intended |
| **Bed / furniture flags** (`DisableBedUse`, `SetBedFlag`) | Allow/forbid bed use | Flags yes; bed already chosen — `MoveScene` can re-evaluate |
| **Orgasms** (`DisableAllOrgasms`, `DisableOrgasm`, `ForceOrgasm`) | Block or force climax | **Yes** |
| **Voice / expression / strapon** | Per-actor presentation | **Yes** (runtime) |
| **Strip / undress / path-to-center** | Prep-time actor setup | Flags can set; strip/path usually already done |
| **Tags** (`AddTag` / `RemoveTag`) | Thread tags | **Yes** (data only; won’t refilter pool by itself) |
| **End scene** (`EndAnimation`) | Stop the thread | **Yes** |

## Direct answers

| Question | Answer |
|----------|--------|
| Change actor position? | **Yes** — swap slots (`ChangePositions`) or adjust offsets / center |
| Change the animation? | **Yes** — to another in the current `Animations` list |
| Add a new animation? | **Yes** — mutate list (`AddAnimation` / `SetForcedAnimations` / `SetAnimations`), then `SetAnimation` or `ChangeAnimation` |
| Change victim? | **Yes** via `SetVictim`; may not instantly re-sort until animation change |
| Add actors? | **Not** with `AddActor`. Use **`ChangeActors(Actor[])`** with the full new cast |

## `Animations` property resolution

1. `CustomAnimations` (forced) if non-empty  
2. else `LeadAnimations` if `LeadIn`  
3. else `PrimaryAnimations`
