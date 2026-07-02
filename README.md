# SkyrimNet_SexLab

Adds SkyrimNet support to SexLab.

## F.A.Q.
#### My NPCs don't want to have casual sex!
- **People normally don't want to have sex where others can see them**: 
        - Use whipser mode to reduce the number of people watching 
            - SkyrimNet allows people to see/hear through walls/floors
- **Check your social world settings to match the kind of sex you want** 

#### My NPCs keep having too much sex! 
- **Change [arousal prompts](https://github.com/GoodProvider/SkyrimNet_SexLab/blob/main/SKSE/Plugins/SkyrimNet/prompts/submodules/character_bio/0005_sexlab_variables.prompt#L12) to make your actors less horny**
- **Check your social world settings to match the kind of sex you want**
  
#### I am getting Memory errors when actions triggers!
SkyrimNet isn't seeing SkyrimNet_SexLab's Actions' functions.

- Make sure the SkyrimNet_SexLab.esp is the last plugin.
- When the game starts, use your hot key to open SkyrimNet's webUI
    - Select '_tools" on the left column
    - Select 'Game Data Explorer'
    - In the search field type '_sexlab'
    - Select SkyrimNet_SexLab's Quests
    - Select 'View Scripts'
    - Click the 'Refresh' Button
    - Select 'Actions'
        - If it has more then 0 functions you are good to go.


# Actions 
- NPC will be able to start sex
  - ability to set a style of sex: forceful, normal, or gentle 
- NPC will be able to dress and undress
- NPC can start kissing, hugging, and cuddling
- NPC can start punishing with spanking and whipping 

## Action Scene Settings
When a action is called it contains an optional setting_name, this matches to a JSON file SKSE/Plugins/SkyrimNet_SexLab/scenes/(setting_name).json.  This provides the ability to set how SexLab will run the scene. Below is an example, but you can see other example files in [SKSE/Plugins/SkyrimNet_SexLab](SKSE/Plugins/Skyrimnet_SexLab).

```
# Actor.0 is punished by spanking/whipping of Actor.1
# A scene setting where no one will orgasm, 
# no one will strip off their clothing, 
# position 0 speaking is modified by pain, position 1 has no modifiers, 
# and animations with sex tags are suppressed. 
{
    "default":{
        "no_orgasm":1,
        "no_stripping":1,
    },
    "no_stripping":[0],
    "speaking_modifiers":["pain",""],
    "tags_suppress":"oral,vaginal,anal,masturbation,handjob,boobjob,thighjob,fisting,dildo,fingering,footjob,cuddling,spooning"
}
```

| key | value |
| ----| ------| 
| array_defaults            | sets the default value for the arrays | 
| no_orgasm          | 0 is default will orgasm , 1 position will not orgasm | 
| no_stripping       | 0 will undress | 1 will not undress  |
| method             | a string description how something is happen | 
|                    | useful when the tag isn't a good description | 
| speaking_modifiers | pain - the speaker is in intense pain | 
|                    | pleasure - speaker is in intense pleasure  | 
|                    | gagged - speaker is gagged, difficult to speak | 
| tags               | animation must contain these tags | 
| tags_suppressed    | animation must not contain these tags | 

You are encouraged to create and share your own scene settings.  Example actions using scene_settings can be found in [SKSE/Plugins/SkyrimNet/config/actions](SKSE/Plugins/SkyrimNet/config/actions).

### speaking modifiers

Speaking modifiers control the instructions in [0050_sexlab_sexlab_activity.prompt](SKSE/Plugins/SkyrimNet/prompts/submodules/user_final_instructions/0050_sexlab_activity.prompt).  Please experiment and help us find new modifiers to include and improve the prompt. 

# Hot Key
There is an optional hot key, must be enabled in the MCM.  It supports: 
- ability to start a sexual act with an NPC in the crosshairs or between NPCs not in the crosshairs.
- ability to dress/undress the actor under the across hairs.
- If the NPC in the crosshair or player is in a sexlab animation 
  - change the style of sex 
  - add a per-stage description 
  - change if a given actor expects an orgasm 

## Per Stage Description 
When you press the hot key on an actor in sex, one of two thing will happen:
- If the animation's stage already has a description, the description will be presented with the option to replace it. If you choose to edit, it will be the same as the next step
- If the animation's stage does not have a description, a text field will be presented to add it. 
  - After you finish typing, the code will add the actor's names and present the final description to you.  You can accept or reject. If it is empty you most likely used the wrong variable names.

Descriptions you create will be stored in `SkyrimNet_SexLab/animations/\_local\_`with a single file for each animation. Additional stage descriptions will be stored in `animations/(author_name)` as they are shared with me, or people can simple give them to you.  The author's name will be presented when the description is provided, so you know where to edit the files. You can always create new description in \_local\_.

- Once the file exists, you can edit with your favorite text editor if you so choose.
- If no stage descriptions is used, the tag based description will be used. 
- The last stage with a description will be used if none is found.
- descriptions will be used in the order the directories are read, with \_local\_ loaded last.

- We now support inja format for stage descriptions:
  - There will be an array of actors.  If there is a victim, it is normally the first character.
  - If you aren't sure.  Type just the actors needs so you can see which is which.
  - {{sl.actors.0}} is the first actor 
  - {{sl.actors.1}} is the second
  - {{sl.actors.2}} is the third
  - etc 

## Orgasm Expected
Some animation do not provide a justification for all actors to expect an orgasm.
It is stored as an array of integers matching the position of the actors in the thread. 
- 0: the actor does not expect an orgasm
- 1: the actor expects an orgrasm 

## Sex Style 
If you have enabled the Tag Editor, you will be presented with the ability to set the style,
This will change how the sex is presented to the LLM:
- Forcefully fucking
- having sex
- gently making love

## Examples 
Examples can be found in the animations/GoodProvider sub directory.

`SkyrimNet_SexLab\animations\_local_\file.json
~~~json
{
    "stage 1": {
        "description":"{{sl.actors.1}} fingers {{sl.actors.0}}.",
        "version": "2.0"
    },
    "orgasm_expected":[1,0]
}
~~~

## Load Order
Please send me any animations you create by zipping your \_local\_ directory and give me an authors name you would like to use.  I will also accept annoymous submissions.

- Send the zip file to me on discord
- email the zipped file to da.good.provider@gmail.com 

**Requirements**
The following and depedancies:
- [Sexlab Framework](https://www.loverslab.com/files/category/228-sexlab-framework-se/)
- [Papyrus MessageBox](https://www.nexusmods.com/skyrimspecialedition/mods/83578)
- [JContainers](https://www.nexusmods.com/skyrimspecialedition/mods/16495)
- [SkyUI SE](https://www.nexusmods.com/skyrimspecialedition/mods/12604)
  [UIExtensions](https://www.nexusmods.com/skyrimspecialedition/mods/17561)
   - [UIExtensions_UITextEntryMenu_with_VR_support](https://github.com/mrowrpurr/UIExtensions_UITextEntryMenu_with_VR_support) (VR users)
- [Primsa UI](https://www.nexusmods.com/skyrimspecialedition/mods/148718)
    - [Media Keys Fix](https://www.nexusmods.com/skyrimspecialedition/mods/92948)
- [Dragonborn voice over 2](https://www.nexusmods.com/skyrimspecialedition/mods/84329)
- SkyrimNet (Beta7 or later)
   - You must have narration enabled
- SkryimNet_SexLab (this mod)
- **Animation Utilities**
    - [Pandora](https://www.nexusmods.com/skyrimspecialedition/mods/133232)
    - Pandora Output (recommended to store Pandora's output)
    - [XP32 Maximum Skeleton Special Extended (XPMSSE)](https://www.nexusmods.com/skyrimspecialedition/mods/1988)
    - [SL Animation Loader](https://www.loverslab.com/files/file/5328-sexlab-animation-loader-sse/)
    - [Hug kill move fix for USSEP](https://www.nexusmods.com/skyrimspecialedition/mods/139572?tab=description)
- **Animation** 
    - [Ace Animations](https://www.nexusmods.com/skyrimspecialedition/mods/81928) (cuddle/spooning animations)
 
**Optional**
- [SkyrimNet_Arousal](https://github.com/GoodProvider/SkyrimNet_Arousal) adds arousal to prompt / add arousal actions 
- [OSL Aroused](https://www.nexusmods.com/skyrimspecialedition/mods/65454)
   - Will prevent orgasm from increasing satisfaction for tagged actors for a given animations
- [OstimNet](https://github.com/tetherball88/OStimNet)
  - if install, MCM will allow the user to select which framework will be used by the LLM to start sex.  
        

**Other SkyrimNet NSWF**
- [skyrimNet CumSwallowNeeds](mods/SkyrimNet-CumSwallowNeeds.zip) (Author Token) 
   - [CumSwallowNeeds](https://www.loverslab.com/files/file/29763-cumswallowneedsaddon/)

**Recommendations**
- **Utils**
    -  [SKSE](https://skse.silverlock.org/)
    -  [Address Library for SKSE Plugins](https://www.nexusmods.com/skyrimspecialedition/mods/32444)
    -  [Unofficial Skyrim Special Edition Patch - USSEP](https://www.nexusmods.com/skyrimspecialedition/mods/266)
    -  [PapyrusUtil SE](https://www.nexusmods.com/skyrimspecialedition/mods/13048)
    -  [Powerof three Papyrus Extender](https://www.nexusmods.com/skyrimspecialedition/mods/22854)
    -  [Power of three Tweaks](https://www.nexusmods.com/skyrimspecialedition/mods/51073)
    -  [Alternate Start](https://www.nexusmods.com/skyrimspecialedition/mods/272) (nice, but not needed)
       - [Unofficial Skyrim Sepcial Edition Patch](https://www.nexusmods.com/skyrimspecialedition/mods/51073)
    -  [Stay At the System Page NG](https://www.nexusmods.com/skyrimspecialedition/mods/76927)
    -  [Papyrus MessageBox](https://www.nexusmods.com/skyrimspecialedition/mods/83578)
    -   SkyrimNet 
- **nude body (not required)**
    -   [Caliente's Beautiful Bodies Enhancer -CBBE-](https://www.nexusmods.com/skyrimspecialedition/mods/198) or BHUNP
    -   [The New Gentlemen](https://www.loverslab.com/files/file/5355-schlongs-of-skyrim-se/)
        - [The New Gentlewomen](https://www.nexusmods.com/skyrimspecialedition/mods/105649) futanari support
            - https://www.loverslab.com/files/file/11344-sos-addon-futanari-cbbe-sse/
            - TRX Futanari for New Gentlemen (TRX-Corner on [Vermi Discord](https://discord.gg/vermishub))
            - You will need to add using T.N.G's hotkey after exiting racemenu
            - Change the character's gender to male in SexLab only.
- **SexLab**
    -  [Sexlab Framework](https://www.loverslab.com/files/category/228-sexlab-framework-se/)
    -  [SexLab Tools](https://www.loverslab.com/files/file/10660-sexlab-tools-for-se-patched/) (Allows you to change animations with 'h' hotkey)
- **animations** (you might be able to get away with less ... )
    -   [Billyy](https://www.loverslab.com/files/file/3999-billyys-slal-animations-2025-1-1/)
- **Devious Devices** 
    - [SkyrimNet DDUNDNG](https://github.com/naitro2010/SkyrimNet_UDNG/releases/download/alpha2/SkyrimNetDDUDNG.zip)
    - [Devious Devices](https://www.loverslab.com/files/file/5878-devious-devices-se/) (and it's requirements)
    - [Papyrus Tweaks NG](https://www.nexusmods.com/skyrimspecialedition/mods/77779)
    - [Devious Devices NG](https://www.loverslab.com/files/file/29779-devious-devices-ng/)
        - [Blind people DAR](https://www.nexusmods.com/skyrimspecialedition/mods/90947)
        - [Bound hands DAR](https://www.nexusmods.com/skyrimspecialedition/mods/89247) (required for next file) 
        - [Bound hands OAR](https://www.nexusmods.com/skyrimspecialedition/mods/143622?tab=files)

