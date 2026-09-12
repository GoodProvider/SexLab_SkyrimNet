ScriptName Apropos2SystemConfig Extends Apropos2SystemLibrary

Import Apropos2Util
Import ApUtil

Message Property CleanSystemFinish Auto
Message Property CleanJContainersFinish Auto
Message Property CheckSKSE Auto
Message Property CheckSkyrim Auto
Message Property CheckJContainers Auto
Message Property CheckSkyUI Auto
Message Property CheckSLA Auto

Spell Property AnalHealthDebuffSpell Auto
Spell Property AnalStaminaDebuffSpell Auto
Spell Property AnalSpeedDebuffSpell Auto
Spell Property OralMagickaDebuffSpell Auto
Spell Property OralSpeechDebuffSpell Auto
Spell Property VaginalHealthDebuffSpell Auto
Spell Property VaginalStaminaDebuffSpell Auto
Spell Property VaginalSpeedDebuffSpell Auto
Spell Property WTStaggerSpell Auto

Bool Property DebugMessagesEnabled  = True Auto Hidden
Bool Property TraceMessagesEnabled = True Auto Hidden
Bool Property LogActorStatsEnabled = True Auto Hidden
Bool Property EnableConsoleOutput = True Auto Hidden 
Bool Property WearAndTearEnabled = True Auto Hidden
Bool Property NPCWearAndTearEnabled = True Auto Hidden
Float Property WTDegradeFactor = 1.2 Auto Hidden
Int Property MaxWearTearAmount = 2000  Auto Hidden
Int Property FrequencyWearTearDegrade = 12 Auto Hidden
Int Property ChanceWTDegrade = 5 Auto Hidden
Int Property SkoomaWTHealAmount = 25 Auto Hidden
Int Property SpiderEggWTHealAmount = 15 Auto Hidden
Int Property ChaurusEggWTHealAmount = 15 Auto Hidden
Bool Property ConsumablesIncreaseArousal = True Auto Hidden
Int Property MinConsumableArousalIncr = 2 Auto Hidden
Int Property MaxConsumableArousalIncr = 15 Auto Hidden
Bool Property WTEffectsEnabled = True Auto Hidden
Bool Property HardcoreWTEffectsEnabled Auto Hidden

Int Property MinArousalAutoMasturbate = 80 Auto Hidden
Bool Property AutoMasturbateEnabled = True Auto Hidden

Int Property MascaraTatsColorTint = 0x000000 Auto Hidden; black
Int Property TatsColorTint = 0x990033 Auto Hidden; 0x990033 is deep red, see:
; https://github.com/schlangster/skyui/blob/master/src/Common/skyui/components/colorswatch/ColorSwatch.as
; if (colorList == null) {
;            colorList = [0x990033, 0xAD0073, 0xA17700, 0x803D0D, 0xBD4F19, 0x007A87, 0x162274, 0x4F2D7F, 0x56364D, 0x618E02, 0x008542, 0x5C4836, 0x999999, 0x000000,
;                         0xCC0033, 0xE86BA5, 0xEAAB00, 0xB88454, 0xE37222, 0x99FFFF, 0x4060AF, 0x8C6CD0, 0x8F6678, 0x9EAB05, 0x19B271, 0xAA9C8F, 0xCCCCCC, 0xFFFFFF];
;        }
;

Bool Property EnableSkinTextures = True Auto Hidden
Bool Property EnableAfterEffects = True Auto Hidden
Bool Property EnableCutScratches = True Auto Hidden
Bool Property EnableDaedricScars = True Auto Hidden
Bool Property EnableTearsAndSobs = True Auto Hidden
Bool Property EnableMascaraSmears = True Auto Hidden

String Property NarrativeMode Auto Hidden
String Property PeriodicPlayerDescriptionsOption = "Timed msg" Auto Hidden

Int Property MinArousalForHugeLoad = 50 Auto Hidden
Int Property MinArousalForLargeLoad = 30 Auto Hidden

Bool Property ShowSexDescriptions = True Auto Hidden
Bool Property ShowVirginityLostMessages = True Auto Hidden
Bool Property ShowWTChangedMessages = True Auto Hidden 
Bool Property ShowAnimationStartMessages = True Auto Hidden
Bool Property ShowAnimationChangeMessages = True Auto Hidden
Bool Property ShowAllStageMessages = True Auto Hidden
Bool Property ShowHugeLargeLoadMessages = True Auto Hidden

; @DEPRECRATED
Bool Property EnableAnimationChange = True Auto Hidden
;
Int Property RapeAnimationSwitchChance = 30 Auto Hidden
Int Property GoBackAggressorFactor = 30 Auto Hidden
Int Property MaxGoBacksPerAnimation = 2 Auto Hidden

Int Property BaseVaginalSemenCapacity = 50 Auto Hidden
Int Property BaseAnalSemenCapacity = 50 Auto Hidden
Int Property BaseOralSemenCapacity = 50 Auto Hidden

Int Property SmallCreatureBaseSemenVolume = 2 Auto Hidden
Int Property HumanoidBaseSemenVolume = 3 Auto  Hidden
Int Property OrcBaseSemenVolume = 4 Auto Hidden
Int Property DremoraBaseSemenVolume = 5 Auto Hidden
Int Property NormalCreatureBaseSemenVolume = 10 Auto Hidden
Int Property LargeCreatureBaseSemenVolume = 25 Auto Hidden
Int Property HugeCreatureBaseSemenVolume = 100 Auto  Hidden


String[] _smallSizedCreatures
String[] _normalSizedCreatures
String[] _largeSizedCreatures
String[] _hugeSizedCreatures
String[] _nonMagicalCreatures
String[] _nonMagicalPredators
String[] _chitinousCreatures
String[] _magicalCreatures
String[] _undeadCreatures
String[] _daedricCreatures
String[] _fabricatedCreatures

Event OnInit()
    Parent.OnInit()
    SetDefaults()

    _smallSizedCreatures = new String[10]
    _smallSizedCreatures[0] = "dog"
    _smallSizedCreatures[1] = "wolf"
    _smallSizedCreatures[2] = "skeever"
    _smallSizedCreatures[3] = "spider"
    _smallSizedCreatures[4] = "riekling"
    _smallSizedCreatures[5] = "ashhopper"
    _smallSizedCreatures[6] = "dwarvenSpider"
    _smallSizedCreatures[7] = "goat"
    _smallSizedCreatures[8] = "rabbit"
    _smallSizedCreatures[9] = "Deathhound"


    _normalSizedCreatures = new String[10]
    _normalSizedCreatures[0] = "draugr"
    _normalSizedCreatures[1] = "falmer"
    _normalSizedCreatures[2] = "ashman"    
    _normalSizedCreatures[3] = "chaurus"    
    _normalSizedCreatures[4] = "dragonPriest"    
    _normalSizedCreatures[5] = "vampireLord"    
    _normalSizedCreatures[6] = "boar"    
    _normalSizedCreatures[7] = "deer"
    _normalSizedCreatures[8] = "dwarvenSphere"
    _normalSizedCreatures[9] = "dwarvenBallista"

    _largeSizedCreatures = new String[13]
    _largeSizedCreatures[0] = "sabreCat"
    _largeSizedCreatures[1] = "bear"
    _largeSizedCreatures[2] = "troll"
    _largeSizedCreatures[3] = "werewolf"
    _largeSizedCreatures[4] = "seeker"
    _largeSizedCreatures[5] = "chaurusReaper"
    _largeSizedCreatures[6] = "horse"
    _largeSizedCreatures[7] = "gargoyle"
    _largeSizedCreatures[8] = "horker"
    _largeSizedCreatures[9] = "chaurusHunter"
    _largeSizedCreatures[10] = "chaurusflyer"
    _largeSizedCreatures[11] = "cat"
    _largeSizedCreatures[12] = "largeSpider"

    _hugeSizedCreatures = new String[7]
    _hugeSizedCreatures[0] = "dragon"
    _hugeSizedCreatures[1] = "giant"
    _hugeSizedCreatures[2] = "lurker"
    _hugeSizedCreatures[3] = "bigSpider"
    _hugeSizedCreatures[4] = "netch"
    _hugeSizedCreatures[5] = "dwarvenCenturion"
    _hugeSizedCreatures[6] = "frostAtronach"

    _nonMagicalCreatures = new String[9]
    _nonMagicalCreatures[0] = "dog"
    _nonMagicalCreatures[1] = "deer"
    _nonMagicalCreatures[2] = "horse"
    _nonMagicalCreatures[3] = "horker"
    _nonMagicalCreatures[4] = "goat"
    _nonMagicalCreatures[5] = "fox"
    _nonMagicalCreatures[6] = "rabbit"
    _nonMagicalCreatures[7] = "skeever"
    _nonMagicalCreatures[8] = "boar"

    _nonMagicalPredators = new String[4]
    _nonMagicalPredators[0] = "wolf"
    _nonMagicalPredators[1] = "sabreCat"
    _nonMagicalPredators[2] = "bear"
    _nonMagicalPredators[3] = "riekling"

    _chitinousCreatures = new String[8]
    _chitinousCreatures[0] = "spider"
    _chitinousCreatures[1] = "bigSpider"
    _chitinousCreatures[2] = "largeSpider"
    _chitinousCreatures[3] = "chaurus"
    _chitinousCreatures[4] = "chaurusReaper"
    _chitinousCreatures[5] = "ashhopper"
    _chitinousCreatures[6] = "chaurusHunter"        
    _chitinousCreatures[7] = "netch"

    _magicalCreatures = new String[8]
    _magicalCreatures[0] = "spriggan"
    _magicalCreatures[1] = "troll"
    _magicalCreatures[2] = "giant"
    _magicalCreatures[3] = "werewolf"
    _magicalCreatures[4] = "dragon"
    _magicalCreatures[5] = "gargoyle"
    _magicalCreatures[6] = "falmer"
    _magicalCreatures[7] = "ashman"

    _undeadCreatures = new String[4]
    _undeadCreatures[0] = "draugr"
    _undeadCreatures[1] = "dragonPriest"
    _undeadCreatures[2] = "vampireLord"
    _undeadCreatures[3] = "Deathhound"

    _daedricCreatures = new String[3]
    _daedricCreatures[0] = "seeker"
    _daedricCreatures[1] = "lurker"
    _daedricCreatures[2] = "frostAtronach"

    _fabricatedCreatures = new String[4]
    _fabricatedCreatures[0] = "dwarvenSpider"
    _fabricatedCreatures[1] = "dwarvenCenturion"
    _fabricatedCreatures[2] = "dwarvenSphere"
    _fabricatedCreatures[3] = "dwarvenBallista"
EndEvent

Function Setup()
    Debug("Setup")
    parent.Setup()
    SetDefaults()
EndFunction

String Function GetEffectiveNarrativeVoice(Bool hasPlayer)
    If !hasPlayer
        Return "3rd Person"
    Else 
        Return NarrativeMode
    EndIf    
EndFunction

Bool Function PeriodicPCMessagesHotKeyEnabled()
    Return PeriodicPlayerDescriptionsOption == "Use hotkey"
EndFunction

Bool Function PeriodicPCMessagesDisabled()
    Return PeriodicPlayerDescriptionsOption == "Disabled"
EndFunction

Int Property DefaultWidgetFontSize Hidden
    Int Function Get()
        Return Widgets.DefaultFontSize
    EndFunction    
EndProperty

Int Property DefaultWidgetPlayerFontSize Hidden
    Int Function Get()
        Return Widgets.DefaultPlayerFontSize
    EndFunction        
EndProperty

String Property DefaultWidgetHorizontalAnchor Hidden
    String Function Get()
        Return Widgets.DefaultHorizontalAnchor
    EndFunction        
EndProperty

String Property DefaultWidgetVerticalAnchor Hidden
    String Function Get()
        Return Widgets.DefaultVerticalAnchor
    EndFunction        
EndProperty

Int Property DefaultWidgetHorizontalOffset Hidden
    Int Function Get()
        Return Widgets.DefaultHorizontalOffset
    EndFunction        
EndProperty

Int Property DefaultWidgetVerticalOffset Hidden
    Int Function Get()
        Return Widgets.DefaultVerticalOffset
    EndFunction        
EndProperty

Int Property DefaultWidgetSpacing Hidden
    Int Function Get()
        Return Widgets.DefaultWidgetSpacing
    EndFunction        
EndProperty

Float Property DefaultWidgetSecondsToDisplay Hidden
    Float Function Get()
        Return Widgets.DefaultSecondsToDisplay
    EndFunction        
EndProperty

Bool Property WidgetTestMode Hidden
    Bool Function Get()
        Return Widgets.TestMode
    EndFunction
    Function Set(Bool newVal)
        Widgets.TestMode = newVal
    EndFunction   
EndProperty

Int Property WidgetTestKey Hidden
    Int Function Get()
        Return Framework.WidgetTestHotkey
    EndFunction
    Function Set(Int newVal)
        Framework.WidgetTestHotkey = newVal
    EndFunction       
EndProperty    

Int Property WidgetsPlayerFontSize Hidden
    Int Function Get()
        Return Widgets.PlayerFontSize
    EndFunction
    Function Set(Int newVal)
        Widgets.PlayerFontSize = newVal
    EndFunction       
EndProperty

String Property WidgetHorizontalAnchor Hidden
    String Function Get()
        Return Widgets.HorizontalAnchor
    EndFunction
    Function Set(String newVal)
        Widgets.HorizontalAnchor = newVal
    EndFunction
EndProperty

Int Property WidgetHorizontalOffset Hidden
    Int Function Get()
        Return Widgets.HorizontalOffset
    EndFunction
    Function Set(Int newVal)
        Widgets.HorizontalOffset = newVal
    EndFunction    
EndProperty

String Property WidgetVerticalAnchor Hidden
    String Function Get()
        Return Widgets.VerticalAnchor
    EndFunction
    Function Set(String newVal)
        Widgets.VerticalAnchor = newVal
    EndFunction    
EndProperty

Int Property WidgetVerticalOffset Hidden
    Int Function Get()
        Return Widgets.VerticalOffset
    EndFunction
    Function Set(Int newVal)
        Widgets.VerticalOffset = newVal
    EndFunction   
EndProperty

Int Property WidgetFontSize Hidden
    Int Function Get()
        Return Widgets.FontSize
    EndFunction
    Function Set(Int newVal)
        Widgets.FontSize = newVal
    EndFunction       
EndProperty

Int Property WidgetPlayerFontSize Hidden
    Int Function Get()
        Return Widgets.PlayerFontSize
    EndFunction
    Function Set(Int newVal)
        Widgets.PlayerFontSize = newVal
    EndFunction       
EndProperty

Int Property WidgetSpacing Hidden
    Int Function Get()
        Return Widgets.WidgetSpacing
    EndFunction
    Function Set(Int newVal)
        Widgets.WidgetSpacing = newVal
    EndFunction       
EndProperty

Float Property WidgetSecondsToDisplay Hidden
    Float Function Get()
        Return Widgets.SecondsToDisplay
    EndFunction
    Function Set(Float newVal)
        Widgets.SecondsToDisplay = newVal
    EndFunction       
EndProperty

Int Property WidgetWidth Hidden
    Int Function get()
        Return Widgets.WidgetWidth
    EndFunction
    Function set(Int newVal)
        Widgets.WidgetWidth = newVal
    EndFunction
EndProperty

Bool Property Enabled Hidden
    Bool Function get()
        Return Framework.Enabled
    EndFunction
EndProperty

Bool Property DebugMode Hidden
    Bool Function get()
        Return InDebugMode
    EndFunction
    Function set(Bool value)
        InDebugMode = value
        If InDebugMode
            Debug("Apropos Debug/Development Mode Activated")
        Else
            Debug("Apropos Debug/Development Mode Deactivated")
        EndIf
        SendModEventWithBool("Apropos2DebugMode", value)
    EndFunction
EndProperty

Int requiredJCAPIVersion = 3
Int minimumJCfeatureVersion = 0

Bool Function CheckSystemComponent(String component)
    If component == "Skyrim"
        Return (StringUtil.Substring(Debug.GetVersionNumber(), 0, 3) As Float) >= 1.5
        
    ElseIf component == "SKSE"
        Return SKSE.GetScriptVersionRelease() >= 48
        
    ElseIf component == "SkyUI"
        Return Quest.GetQuest("SKI_ConfigManagerInstance") != None
        
    ElseIf component == "JContainers"
        If !JContainers.isInstalled()
            Return False
        EndIf
		if JContainers.APIVersion() > requiredJCAPIVersion
			return True
		endif
        Return JContainers.APIVersion() == requiredJCAPIVersion && JContainers.featureVersion() >= minimumJCfeatureVersion
    ElseIf component == "SexLabAroused"
        Return GetSLA() != none

    ElseIf component == "Slavetats"
        Return Game.GetModByName("Slavetats.esp") != 255

    EndIf
    
    Return False
EndFunction

Bool Function CheckSystem()
    If !CheckSystemComponent("Skyrim")
        CheckSkyrim.Show()
        Return False
        
    ElseIf !CheckSystemComponent("SKSE")
        CheckSKSE.Show(1.73)
        Return False
        
    ElseIf !CheckSystemComponent("SkyUI")
        CheckSkyUI.Show(5.0)
        Return False
        
    ElseIf !CheckSystemComponent("JContainers")
        CheckJContainers.Show(3.2)
        Return False

    ElseIf !CheckSystemComponent("SexLabAroused")
        CheckSLA.Show(2.7)
        Return False

    ; ElseIf slavetats - SlaveTats is optional

    EndIf
    
    Return True
EndFunction

Function Reload()
    ; DebugMode = True
    If DebugMode
        ; Debug.OpenUserLog("Apropos2Debug")
        ; Debug.TraceUser("Apropos2Debug", "Config Reloading...")
        Debug("Config Reloading...")
    EndIf

    LoadLibs(False)
    
EndFunction

Bool Function ShouldPlayStage(Int stage)
    Return ShowAllStageMessages
EndFunction

Function SetDefaults()
    Debug("SetDefaults")
    
    DebugMode = True

    DebugMessagesEnabled = True
    TraceMessagesEnabled = True
    LogActorStatsEnabled = True
    EnableConsoleOutput = True
    WearAndTearEnabled = True
    NPCWearAndTearEnabled = True
    WTDegradeFactor = 1.2
    MaxWearTearAmount = 2000
    FrequencyWearTearDegrade = 12
    ChanceWTDegrade = 5
    ConsumablesIncreaseArousal = True

    WTEffectsEnabled = True
    HardcoreWTEffectsEnabled = False

    MinArousalAutoMasturbate = 80
    AutoMasturbateEnabled = True

    MascaraTatsColorTint = 0x000000
    TatsColorTint = 0x990033

    EnableSkinTextures = True
    EnableAfterEffects = True
    EnableCutScratches = True
    EnableDaedricScars = True
    EnableTearsAndSobs = True
    EnableMascaraSmears = True

    NarrativeMode = "2nd Person"
    PeriodicPlayerDescriptionsOption = "Timed msg"

    ShowSexDescriptions = True
    ShowVirginityLostMessages = True
    ShowWTChangedMessages = True
    ShowAnimationStartMessages = True
    ShowAnimationChangeMessages = True
    ShowAllStageMessages = True
    ShowHugeLargeLoadMessages = True

    WidgetHorizontalAnchor = Widgets.DefaultHorizontalAnchor
    WidgetHorizontalOffset = Widgets.DefaultHorizontalOffset
    WidgetVerticalAnchor   = Widgets.DefaultVerticalAnchor
    WidgetVerticalOffset   = Widgets.DefaultVerticalOffset
    WidgetFontSize         = Widgets.DefaultFontSize
    WidgetPlayerFontSize   = Widgets.DefaultPlayerFontSize
    WidgetSpacing          = Widgets.DefaultWidgetSpacing
    WidgetSecondsToDisplay = Widgets.DefaultSecondsToDisplay

    RapeAnimationSwitchChance = 30
    GoBackAggressorFactor = 30
    MaxGoBacksPerAnimation = 2

    MinArousalForHugeLoad = 50
    MinArousalForLargeLoad = 30

    MinConsumableArousalIncr = 2
    MaxConsumableArousalIncr = 15

    ; set defaults here

    Reload()
EndFunction

Int Function GetCreatureBaseSemenVolume(String creatureType)
    Debug("GetCreatureBaseSemenVolume(" + creatureType + ")")

    If !creatureType
        Return 0
    EndIf

    If _smallSizedCreatures.Find(creatureType) != -1
        Debug("... is small sized creature")
        Return SmallCreatureBaseSemenVolume
    EndIf

    If _normalSizedCreatures.Find(creatureType) != -1
        Debug("... is normal sized creature")
        Return NormalCreatureBaseSemenVolume
    EndIf

    If _largeSizedCreatures.Find(creatureType) != -1
        Debug("... is large creature")
        Return LargeCreatureBaseSemenVolume
    EndIf

    If _hugeSizedCreatures.Find(creatureType) != -1
        Debug("... is huge creature")
        Return HugeCreatureBaseSemenVolume
    EndIf

    Debug("GetCreatureBaseSemenVolume - could not find volume lookup for " + creatureType)
    ; default volume if not matched
    Return 1

EndFunction

String Function GetCreatureBaseSemenVolumeDescription(String creatureType)
    Debug("GetCreatureBaseSemenVolumeDescription(" + creatureType + ")")

    If !creatureType
        Return "normal"
    EndIf

    If _smallSizedCreatures.Find(creatureType) != -1
        Return "beasty"
    EndIf

    If _normalSizedCreatures.Find(creatureType) != -1
        Return "sizable"
    EndIf

    If _largeSizedCreatures.Find(creatureType) != -1
        Return "massive"
    EndIf

    If _hugeSizedCreatures.Find(creatureType) != -1
        Return "huge"
    EndIf

    Debug("GetCreatureBaseSemenVolumeDescription - could not find volume lookup for " + creatureType)
    Return "default"

EndFunction

Int Function GetBaseSemenVolume(String semenSourceRace, Bool isCreature)
    If isCreature
        Return GetCreatureBaseSemenVolume(semenSourceRace)
    ElseIf StringContains(semenSourceRace, "Dremora")
        Return DremoraBaseSemenVolume
    ElseIf IsOrcRace(semenSourceRace)
        Return OrcBaseSemenVolume
    Else 
        Return HumanoidBaseSemenVolume
    EndIf
EndFunction    

Bool Function ExportSettings()
    Int exportMapId = RetainedMap()
    
    JMap.setInt(exportMapId, "DebugMessagesEnabled", DebugMessagesEnabled As Int)
    JMap.setInt(exportMapId, "TraceMessagesEnabled", TraceMessagesEnabled As Int)
    JMap.setInt(exportMapId, "LogActorStatsEnabled", LogActorStatsEnabled As Int)
    JMap.setInt(exportMapId, "EnableConsoleOutput", EnableConsoleOutput As Int)
    JMap.setInt(exportMapId, "WearAndTearEnabled", WearAndTearEnabled As Int)
    JMap.setInt(exportMapId, "NPCWearAndTearEnabled", NPCWearAndTearEnabled As Int)
    JMap.setFlt(exportMapId, "WTDegradeFactor", WTDegradeFactor)
    JMap.setInt(exportMapId, "MaxWearTearAmount", MaxWearTearAmount)
    JMap.setInt(exportMapId, "FrequencyWearTearDegrade", FrequencyWearTearDegrade)
    JMap.setInt(exportMapId, "WTEffectsEnabled", WtEffectsEnabled As Int)
    JMap.setInt(exportMapId, "HardcoreWTEffectsEnabled", HardcoreWTEffectsEnabled As Int)

    JMap.setInt(exportMapId, "ChanceWTDegrade", ChanceWTDegrade)
    JMap.setInt(exportMapId, "ConsumablesIncreaseArousal", ConsumablesIncreaseArousal As Int)

    JMap.setInt(exportMapId, "MinArousalAutoMasturbate", MinArousalAutoMasturbate)
    JMap.setInt(exportMapId, "AutoMasturbateEnabled", AutoMasturbateEnabled As Int)

    JMap.setInt(exportMapId, "MascaraTatsColorTint", MascaraTatsColorTint)
    JMap.setInt(exportMapId, "TatsColorTint", TatsColorTint)

    JMap.setInt(exportMapId, "EnableSkinTextures", EnableSkinTextures As Int)
    JMap.setInt(exportMapId, "EnableAfterEffects", EnableAfterEffects As Int)
    JMap.setInt(exportMapId, "EnableCutScratches", EnableCutScratches As Int)
    JMap.setInt(exportMapId, "EnableDaedricScars", EnableDaedricScars As Int)
    JMap.setInt(exportMapId, "EnableTearsAndSobs", EnableTearsAndSobs As Int)
    JMap.setInt(exportMapId, "EnableMascaraSmears", EnableMascaraSmears As Int)

    JMap.setStr(exportMapId, "NarrativeMode", NarrativeMode)
    JMap.setStr(exportMapId, "PeriodicPlayerDescriptionsOption", PeriodicPlayerDescriptionsOption)

    JMap.setInt(exportMapId, "ShowSexDescriptions", ShowSexDescriptions As Int)
    JMap.setInt(exportMapId, "ShowVirginityLostMessages", ShowVirginityLostMessages As Int)
    JMap.setInt(exportMapId, "ShowWTChangedMessages", ShowWTChangedMessages As Int)

    JMap.setInt(exportMapId, "ShowAnimationStartMessages", ShowAnimationStartMessages As Int)
    JMap.setInt(exportMapId, "ShowAnimationChangeMessages", ShowAnimationChangeMessages As Int)
    JMap.setInt(exportMapId, "ShowAllStageMessages", ShowAllStageMessages As Int)
    JMap.setInt(exportMapId, "ShowHugeLargeLoadMessages", ShowHugeLargeLoadMessages As Int)    

    JMap.setStr(exportMapId, "WidgetHorizontalAnchor", WidgetHorizontalAnchor)
    JMap.setInt(exportMapId, "WidgetHorizontalOffset", WidgetHorizontalOffset)
    JMap.setStr(exportMapId, "WidgetVerticalAnchor", WidgetVerticalAnchor)
    JMap.setInt(exportMapId, "WidgetVerticalOffset", WidgetVerticalOffset)
    JMap.setInt(exportMapId, "WidgetFontSize", WidgetFontSize)
    JMap.setInt(exportMapId, "WidgetPlayerFontSize", WidgetPlayerFontSize)
    JMap.setInt(exportMapId, "WidgetSpacing", WidgetSpacing)
    JMap.setFlt(exportMapId, "WidgetSecondsToDisplay", WidgetSecondsToDisplay)

    JMap.setInt(exportMapId, "RapeAnimationSwitchChance", RapeAnimationSwitchChance)
    JMap.setInt(exportMapId, "MaxGoBacksPerAnimation", MaxGoBacksPerAnimation)
    JMap.setInt(exportMapId, "GoBackAggressorFactor", GoBackAggressorFactor)

    JMap.setInt(exportMapId, "MinArousalForHugeLoad", MinArousalForHugeLoad)
    JMap.setInt(exportMapId, "MinArousalForLargeLoad", MinArousalForLargeLoad)

    JMap.setInt(exportMapId, "BaseVaginalSemenCapacity", BaseVaginalSemenCapacity)
    JMap.setInt(exportMapId, "BaseAnalSemenCapacity", BaseAnalSemenCapacity)
    JMap.setInt(exportMapId, "BaseOralSemenCapacity", BaseOralSemenCapacity)
    JMap.setInt(exportMapId, "SmallCreatureBaseSemenVolume", SmallCreatureBaseSemenVolume)
    JMap.setInt(exportMapId, "HumanoidBaseSemenVolume", HumanoidBaseSemenVolume)
    JMap.setInt(exportMapId, "OrcBaseSemenVolume", OrcBaseSemenVolume)
    JMap.setInt(exportMapId, "DremoraBaseSemenVolume", DremoraBaseSemenVolume)
    JMap.setInt(exportMapId, "NormalCreatureBaseSemenVolume", NormalCreatureBaseSemenVolume)
    JMap.setInt(exportMapId, "LargeCreatureBaseSemenVolume", LargeCreatureBaseSemenVolume)
    JMap.setInt(exportMapId, "HugeCreatureBaseSemenVolume", HugeCreatureBaseSemenVolume)

    JMap.setInt(exportMapId, "MinConsumableArousalIncr", MinConsumableArousalIncr)
    JMap.setInt(exportMapId, "MaxConsumableArousalIncr", MaxConsumableArousalIncr)
    
    String path = GenerateSettingsExportPath()
    JValue.writeToFile(exportMapId, path)
    JValue.release(exportMapId)
    Return True
EndFunction

Bool Function ImportSettings()
    String path = GenerateSettingsExportPath()

    If !JContainers.fileExistsAtPath(path)
        Debug.MessageBox("Exported settings do not exist at: " + path)
        Return False
    EndIf

    Int importMapId = JValue.readFromFile(path)
    If importMapId ==0 
        Debug.MessageBox("Could not read exported settings at: " + path)
        Return False
    EndIf

    JValue.retain(importMapId)
    
    DebugMessagesEnabled = JMap.getInt(importMapId, "DebugMessagesEnabled") As Bool
    TraceMessagesEnabled = JMap.getInt(importMapId, "TraceMessagesEnabled") As Bool
    LogActorStatsEnabled = JMap.getInt(importMapId, "LogActorStatsEnabled") As Bool
    EnableConsoleOutput = JMap.getInt(importMapId, "EnableConsoleOutput") As Bool
    WearAndTearEnabled = JMap.getInt(importMapId, "WearAndTearEnabled") As Bool
    NPCWearAndTearEnabled = JMap.getInt(importMapId, "NPCWearAndTearEnabled") As Bool
    WtDegradeFactor = JMap.getFlt(importMapId, "WTDegradeFactor")
    MaxWearTearAmount = JMap.getInt(importMapId, "MaxWearTearAmount")
    FrequencyWearTearDegrade = JMap.getInt(importMapId, "FrequencyWearTearDegrade")
    WTEffectsEnabled = JMap.getInt(importMapId, "WTEffectsEnabled") As Bool
    HardcoreWTEffectsEnabled = JMap.getInt(importMapId, "HardcoreWTEffectsEnabled") As Bool

    MinArousalAutoMasturbate = JMap.getInt(importMapId, "MinArousalAutoMasturbate")
    AutoMasturbateEnabled = JMap.getInt(importMapId, "AutoMasturbateEnabled") As Bool

    MascaraTatsColorTint = JMap.getInt(importMapId, "MascaraTatsColorTint")
    TatsColorTint = JMap.getInt(importMapId, "TatsColorTint")

    ChanceWTDegrade = JMap.getInt(importMapId, "ChanceWTDegrade")
    ConsumablesIncreaseArousal = JMap.getInt(importMapId, "ConsumablesIncreaseArousal") As Bool

    EnableSkinTextures = JMap.getInt(importMapId, "EnableSkinTextures") As Bool
    EnableAfterEffects = JMap.getInt(importMapId, "EnableAfterEffects") As Bool
    EnableCutScratches = JMap.getInt(importMapId, "EnableCutScratches") As Bool
    EnableDaedricScars = JMap.getInt(importMapId, "EnableDaedricScars") As Bool
    EnableTearsAndSobs = JMap.getInt(importMapId, "EnableTearsAndSobs") As Bool
    EnableMascaraSmears = JMap.getInt(importMapId, "EnableMascaraSmears") As Bool
    
    NarrativeMode = JMap.getStr(importMapId, "NarrativeMode")
    PeriodicPlayerDescriptionsOption = JMap.getStr(importMapId, "PeriodicPlayerDescriptionsOption")

    ShowSexDescriptions = JMap.getInt(importMapId, "ShowSexDescriptions") As Bool
    ShowVirginityLostMessages = JMap.getInt(importMapId, "ShowVirginityLostMessages") As Bool
    ShowWTChangedMessages = JMap.getInt(importMapId, "ShowWTChangedMessages") As Bool

    ShowAnimationStartMessages = JMap.getInt(importMapId, "ShowAnimationStartMessages") As Bool
    ShowAnimationChangeMessages = JMap.getInt(importMapId, "ShowAnimationChangeMessages") As Bool
    ShowAllStageMessages = JMap.getInt(importMapId, "ShowAllStageMessages") As Bool
    ShowHugeLargeLoadMessages = JMap.getInt(importMapId, "ShowHugeLargeLoadMessages") As Int  

    WidgetHorizontalAnchor  = JMap.getStr(importMapId, "WidgetHorizontalAnchor")
    WidgetHorizontalOffset = JMap.getInt(importMapId, "WidgetHorizontalOffset")
    WidgetVerticalAnchor = JMap.getStr(importMapId, "WidgetVerticalAnchor")
    WidgetVerticalOffset = JMap.getInt(importMapId, "WidgetVerticalOffset")
    WidgetFontSize = JMap.getInt(importMapId, "WidgetFontSize")
    WidgetPlayerFontSize = JMap.getInt(importMapId, "WidgetPlayerFontSize")
    WidgetSpacing = JMap.getInt(importMapId, "WidgetSpacing")
    WidgetSecondsToDisplay = JMap.getFlt(importMapId, "WidgetSecondsToDisplay")

    RapeAnimationSwitchChance = JMap.getInt(importMapId,"RapeAnimationSwitchChance")
    MaxGoBacksPerAnimation = JMap.getInt(importMapId, "MaxGoBacksPerAnimation")
    GoBackAggressorFactor = JMap.getInt(importMapId, "GoBackAggressorFactor")

    MinArousalForHugeLoad = JMap.getInt(importMapId, "MinArousalForHugeLoad")
    MinArousalForLargeLoad = JMap.getInt(importMapId, "MinArousalForLargeLoad")

    BaseVaginalSemenCapacity = JMap.getInt(importMapId, "BaseVaginalSemenCapacity")
    BaseAnalSemenCapacity = JMap.getInt(importMapId, "BaseAnalSemenCapacity")
    BaseOralSemenCapacity = JMap.getInt(importMapId, "BaseOralSemenCapacity")
    SmallCreatureBaseSemenVolume = JMap.getInt(importMapId, "SmallCreatureBaseSemenVolume")
    HumanoidBaseSemenVolume = JMap.getInt(importMapId, "HumanoidBaseSemenVolume")
    OrcBaseSemenVolume = JMap.getInt(importMapId, "OrcBaseSemenVolume")
    DremoraBaseSemenVolume = JMap.getInt(importMapId, "DremoraBaseSemenVolume")
    NormalCreatureBaseSemenVolume = JMap.getInt(importMapId, "NormalCreatureBaseSemenVolume")
    LargeCreatureBaseSemenVolume = JMap.getInt(importMapId, "LargeCreatureBaseSemenVolume")
    HugeCreatureBaseSemenVolume = JMap.getInt(importMapId, "HugeCreatureBaseSemenVolume")

    MinConsumableArousalIncr = JMap.getInt(importMapId, "MinConsumableArousalIncr")
    MaxConsumableArousalIncr = JMap.getInt(importMapId, "MaxConsumableArousalIncr")

    JValue.release(importMapId)

    Return True
EndFunction

Function ExportStorage()
    JDB.writeToFile(ModSpecificUserDirectory() + "JDB.json")
EndFunction

Function Log(String msg, String Source="Apropos2SystemConfig", String display="trace, console")
    Apropos2Util.ULog(msg, Source, LogActorStatsEnabled, EnableConsoleOutput, display)
EndFunction

Function Debug(String msg, String Source="Apropos2SystemConfig")
    Apropos2Util.UDebug(msg, Source, LogActorStatsEnabled, EnableConsoleOutput)
EndFunction

; Function LogAnimationStage(String eventName, sslThreadController thread, String source="Apropos2SystemConfig")
;     Apropos2Util.ULogAnimationStage(eventName, thread, source, LogActorStatsEnabled, EnableConsoleOutput)
; EndFunction

Function LogEventInfo(String eventName, sslThreadController thread, String source="Apropos2SystemConfig")
    Apropos2Util.ULogEventInfo(eventName, thread, source, LogActorStatsEnabled, EnableConsoleOutput)
EndFunction

Function LogActor(Actor anActor, String msg, String source="Apropos2SystemConfig") 
    Apropos2Util.ULogActor(anActor, msg, source, LogActorStatsEnabled, EnableConsoleOutput)
EndFunction

Function DebugActor(Actor anActor, String msg, String source="Apropos2SystemConfig") 
    Apropos2Util.UDebugActor(anActor, msg, source, LogActorStatsEnabled, EnableConsoleOutput)
EndFunction

Function Verbose(String msg, String Source="Apropos2SystemConfig")
    Apropos2Util.UVerbose(msg, source, LogActorStatsEnabled, EnableConsoleOutput)
EndFunction

