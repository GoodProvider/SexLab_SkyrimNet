https://github.com/GoodProvider/SkyrimNet_SexLab/releases/tag/0.33.0

- On SexLab P+, scenes this mod starts no longer hop through every matching animation. A tagged search keeps one animation, and a scene is forced to end after two minutes if enjoyment-wait would loop.
- If a scene has no animation tags, SexLab chooses the animation instead of loading the whole catalog.
- After a scene, afterglow and cum lines come from prompt files (`afterglow.prompt`, `cum.prompt`) instead of hard-coded Papyrus sentences.
    - this allows users to edit them without recompiling. 
- Orgasm narration names who is orgasming and who is not, without treating the “not orgasming” line as an orgasm.
- If SkyrimNet_Leashed is installed, the SkyMessage includes a leash optoin and open SkyrimNet_Leashed's panel 
- Change-outfit and stop action helper prompts moved under `helpers/sexlab/`. Refresh Actions in Game Data Explorer if those descriptions look missing.
