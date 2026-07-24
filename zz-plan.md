if speaker == None 
    if num_actors == 1 
      sender = actors[0]
    else 
      sender = actors[1] 
    endif 
endif 

<goal> fix speaking_modifiers should be ["_pain_","_pleasure_"], and Never contain "" </goal> 
<log>
[07/12/2026 - 09:05:16AM] [SkyrimNet_SexLab_Scene.SetPosition] sid:0 ---- start index:0 akActor:Skadi no_orgasm:1 speaking_modifiers:_pain_,_gagged_
[07/12/2026 - 09:05:17AM] [SkyrimNet_SexLab_Scene.SetPosition] sid:0 end index:0 name: Skadi no_orgasm: 1 speaking_modifiers: ["", ""]
</log> 