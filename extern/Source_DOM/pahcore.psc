Scriptname PAHCore extends Quest Conditional

import Game

PAH_MCM Property Config Auto
SexLabFramework Property SexLab Auto
PAHNpcEval Property NpcEval Auto

ReferenceAlias[] Property slave_aliases Auto
PAHClonifierBaseScript Property clonifier Auto
PAHE_slaveCandidate Property slaveCandidate Auto

PAHPersonalityDefinition[] Property personality_definitions Auto
PAHPersonalityDefinition Property default_male_personality_definition Auto
PAHPersonalityDefinition Property default_female_personality_definition Auto

Weapon Property PAHWhip Auto

Faction Property PAHCleaned Auto
Faction Property PAHECanBeCaptured Auto
Faction Property PAHAASweepingAtTarget Auto

Faction Property PAHPlayerSlaveFaction Auto
Faction Property PAHHasBeenPlayerSlaveFaction Auto
Faction Property PAHSlaveFaction Auto
Faction Property PAHSubmission Auto
Faction Property PAHTrainCombat Auto
Faction Property PAHTrainAnger Auto
Faction Property PAHTrainRespect Auto
Faction Property PAHTrainPose Auto

Faction Property PAHShouldBeRespectful Auto
Faction Property PAHRespectful Auto
Faction Property DunPlayerAllyFaction Auto
Faction Property PAHShouldFightForPlayer Auto

Faction Property PAHTrainAnal Auto
Faction Property PAHTrainSex Auto
Faction Property PAHTrainOral Auto
Faction Property PAHTrainVaginal Auto
Faction Property PAHTrainFear Auto
Faction Property newFear Auto
Faction Property oldFear Auto

Faction Property PAHHumiliation Auto
Faction Property PAHResignation Auto
Faction Property old_Humiliation Auto
Faction Property old_Resignation Auto

Faction Property PAHRegionFaction Auto Hidden
Faction Property PAHJobsFaction Auto Hidden
Faction Property PAHEmployersFaction Auto Hidden

Faction Property SexLabAnimatingFaction Auto ; SexLabAnimatingFaction "SexLab Animating Actors" [FACT:0300E50F]
Faction Property PAH_gender Auto
Faction Property PAH_Player_gender Auto

Faction Property PAHHouseSlave Auto Hidden
Faction Property sexSlaves Auto Hidden
Faction Property sexSlavesReleased Auto Hidden
Faction Property hyd_ahe_regslave Auto Hidden

Faction Property CWSonsFaction Auto	; Stormcloaks 
Faction Property CWImperialFaction Auto	;ImperialSoldiers
Faction Property CWImperialFactionNPC Auto	;ImperialSoldiers
Faction Property CWSonsFactionNPC Auto	; Stormcloaks
Faction Property DA02GuardFaction Auto	; Blue Palace Guard for boethiah's calling [FACT:000B18E2]
Faction Property MQ103ImperialSoldierFaction Auto	;ImperialSoldiers
Faction Property MQ103SonsOfSkyrimSoldierFaction Auto	; Stormcloaks
Faction Property CWDialogueSoldierFaction Auto
Faction Property CWDialogueSoldierWaitingToAttackFaction Auto
Faction Property CWDialogueSoldierWaitingToDefendFaction Auto
Faction Property CWFortFaction Auto
Faction Property GuardDialogueFaction Auto

Faction Property TGNoPickpocketFaction Auto ;Thieves Guild No Pickpocketing Faction
Faction Property GovImperial Auto ;Imperial Government
Faction Property GovRuling Auto ;Ruling Government
Faction Property GovExiled Auto ;Exiled Government

Faction Property RiverwoodSleepingGiantInnFaction Auto ;
Faction Property TownRiverwoodFaction Auto ;
Faction Property DruadachRedoubtFaction Auto ; [FACT:000E3609]
Faction Property TownCidhnaMinePrisonerFaction Auto ; [FACT:000284AE]
Faction Property MQSovngardeCombatDialogueFaction Auto ; 000F0A17
Faction Property MQAncientHeroFaction Auto ; 00044244
Faction Property MQ302CouncilFaction Auto ; 00027EB5
Faction Property BladesFaction Auto 
Faction Property DarkBrotherhoodFaction Auto 
Faction Property ThievesGuildFaction Auto

Faction Property WEPlayerEnemy Auto
Faction Property WIPlayerEnemyFaction Auto
Faction Property WIPlayerEnemySpecialCombatFaction Auto
Faction Property MQ202EnemyofPlayerFaction Auto
Faction Property MQ202ThalmorAgentFaction Auto	;Thalmor
Faction Property DA14CultistFaction Auto	;Sanguine Cultist
Faction Property WIThiefFaction Auto	; Thief 
Faction Property ThalmorFaction Auto	;Thalmor

Faction Property BanditFaction Auto	;Bandits [FACT:0001BCC0]
Faction Property MS07BanditSiblings Auto	;"Broken Oar Bandits" [FACT:00025F95]
Faction Property MS07BanditFaction Auto	; [FACT:00088EE4]
Faction Property WE06BanditFaction Auto	; [FACT:0009CAC0]
Faction Property WE19BanditFaction Auto	; [FACT:0009F811]
Faction Property WE20BanditFaction Auto	; [FACT:0009F817]
Faction Property dunIcerunnerBanditFaction Auto	;"Markarth Wizards' Quarters Guards" [FACT:0008E764]
Faction Property dunValtheimKeepBanditFaction Auto	;[FACT:000AE026]
Faction Property dunRobbersGorgeBanditFaction Auto	;"Robber's Gorge Bandit Faction" [FACT:000B8CAB]
Faction Property SilverHandFaction Auto

Faction Property PAHExArenaFaction Auto
Faction Property PAHExBanditFaction Auto
Faction Property PAHExDarkBrotherhoodFaction Auto
Faction Property PAHExGuardFaction Auto
Faction Property PAHExHunterFaction Auto
Faction Property PAHExImperialFaction Auto
Faction Property PAHExNecromancerFaction Auto
Faction Property PAHExSilverHandFaction Auto
Faction Property PAHExSonsFaction Auto
Faction Property PAHExThalmorFaction Auto
Faction Property PAHExThievesFaction Auto
Faction Property PAHExVampireFaction Auto
Faction Property PAHExVigilantOfStendarrFaction Auto
Faction Property PAHExWarlockFaction Auto
Faction Property PAHExWerewolfFaction Auto
Faction Property PAHExMerchantFaction Auto

Faction Property OBISFaction Auto	;[FACT:08000FD] for se 0101AE24 for LE
Faction Property lalawench_new_travellingwenches Auto Hidden ;"just travelling wenches faction" [FACT:040218F2]
Faction Property lalawench_travelling_servants Auto Hidden ;"travelling servants" [FACT:04024FCE]
Faction Property lalawenchpatrolservantfaction Auto Hidden ;"Wench servant Patrol" [FACT:04031918]
Faction Property WW_wenchminators Auto Hidden ;"wenchminators" [FACT:10000A12]
Faction Property WW_collected Auto Hidden ; "Collected Female" [FACT:10000A05]

Faction Property ForswornFaction Auto	;"Forsworn Faction" [FACT:00043599] 
Faction Property NecromancerFaction Auto	;Necromancers
Faction Property WarlockFaction Auto	;Warlocks
Faction Property dunBlackreachFalmerServantFaction Auto	; Falmer Servant Faction [FACT:000B2D37]
Faction Property dunBluePalaceEnemyFaction Auto	; 

Faction Property VampireFaction Auto
Faction Property WerewolfFaction Auto
Faction Property CreatureFaction Auto	;Creatures
Faction Property DraugrFaction Auto	;Draugr
Faction Property SkeletonFaction Auto	;Skeleton Faction [FACT:0002D1DF] 
Faction Property TrollFaction Auto	;"Troll Faction" [FACT:000435A1]

Faction Property DaedraFaction Auto	
Faction Property DremoraFaction Auto	;Dremora
Faction Property DwarvenAutomatonFaction Auto	;Dwarven
Faction Property SprigganFaction Auto	; SprigganFaction
Faction Property FalmerFaction Auto	; FalmerFaction [FACT:0002997E]
Faction Property DLC2RieklingFaction Auto	; DLC2RieklingFaction [FACT:0301D9C9]

Faction Property DLC2CultistFaction Auto	;  [FACT:04034FBC]
Faction Property DLC1ThrallFaction Auto
Faction Property dunPrisonerFaction Auto
Faction Property WINeverFillAliasesFaction Auto
Faction Property MQ201PartyGuestUnhappy Auto
Faction Property BardAudienceExcludedFaction Auto	;  [FACT:0010FCB4]
Faction Property FavorExcludedFaction Auto	;  [FACT:00094393]
Faction Property WIAdditem03ExclusionFaction Auto	;  [FACT:0010FE03]
Faction Property ArenaFaction Auto
Faction Property VigilantOfStendarrFaction Auto

Faction Property MarriageExcludedFaction Auto	; NPCs the Player cannot marry
Faction Property PlayerFollowerFaction Auto
Faction Property PotentialFollowerFaction Auto
Faction Property currentFollowerFaction Auto
Faction Property currentHireling Auto
Faction Property PlayerFaction Auto

Keyword Property zbfWornDevice Auto	; [KYWD:0700A17C]
Keyword Property PahRestraintMaterialSteel Auto
Keyword Property Pah_Dwarven_Device Auto
Keyword Property defeatActive Auto Hidden
Keyword Property ActorTypeDwarven Auto
Quest Property arousedInstalled Auto Hidden
Quest Property attractionInstalled Auto Hidden

EncounterZone Property PAH0to9Zone Auto
EncounterZone Property PAH10to19Zone Auto
EncounterZone Property PAH20to29Zone Auto
EncounterZone Property PAH30to39Zone Auto
EncounterZone Property PAH40to49Zone Auto
EncounterZone Property PAH50to59Zone Auto
EncounterZone Property PAH60to69Zone Auto
EncounterZone Property PAH70to79Zone Auto
EncounterZone Property PAH80to89Zone Auto
EncounterZone Property PAH90to99Zone Auto
EncounterZone Property PAH100to109Zone Auto
EncounterZone Property PAH110to119Zone Auto
EncounterZone Property PAH120to129Zone Auto
EncounterZone Property PAH130to139Zone Auto
EncounterZone Property PAH140to149Zone Auto
EncounterZone Property PAH150to159Zone Auto
EncounterZone Property PAH160to169Zone Auto
EncounterZone Property PAH170to179Zone Auto
EncounterZone Property PAH180to189Zone Auto
EncounterZone Property PAH190to199Zone Auto
EncounterZone Property PAH200PlusZone Auto

Form Property CuffsRope Auto	;zbfCuffsRope01
Form Property CuffsLeather Auto	;zbfCuffsLeatherBinds
Form Property CuffsIron Auto	;zbfCuffsIronBlack
Form Property CuffsIronBrown Auto	;zbfCuffsIronBrown
Form Property CuffsSimpleBlack Auto	;zbfCuffsSimpleBlack
Form Property CuffsSimpleBrown Auto	;zbfCuffsSimpleBrown
Form Property WristLeather Auto
Armor Property WristIron Auto	;zbfWristIronBlack
Armor Property AnkleLeather Auto	;zbfAnkleLeatherBinds
Armor Property AnkleIron Auto	;zbfAnkleIronBlack
Form Property PHHSHPortablePermaCamp Auto
Armor Property zbfWristSimpleBlack Auto
Armor Property zbfAnkleSimpleBlack Auto
Armor Property zbfWristSimpleBrown Auto
Armor Property zbfAnkleSimpleBrown Auto
Armor Property zbfWristIronBrown Auto
Armor Property zbfAnkleIronBrown Auto
Armor Property zbfWristSteel Auto
Armor Property zbfAnkleSteel Auto
Armor Property PAHEzbfCuffsSteel Auto

Cell Property PAHUtilityCell Auto

;ObjectReference[] Property caravan
ObjectReference Property CaravanAChestREF Auto ; MerchantCaravanAChest
ObjectReference Property CaravanBChestREF Auto ; MerchantCaravanBChest
ObjectReference Property CaravanCChestREF Auto ; MerchantCaravanCChest

ObjectReference Property CloneMarker Auto
Static Property XMarkerHeading Auto

Outfit Property PAHNothingOutfit Auto
Outfit Property PAH_FarmClothesWithCowl_Outfit Auto
Ingredient Property Obis_GlowingPearl Auto
Armor Property ClothesFarmClothes03withExtras Auto
Armor Property PAHEArmorFixerForcedSOS Auto
Armor Property PAHEinvisibleArmor Auto
Armor Property PAHIronSlaveCollarLeashing Auto

ObjectReference _LauraContainer
ObjectReference Property LauraContainer Hidden
	ObjectReference Function Get()
		return _LauraContainer
	EndFunction
EndProperty
ObjectReference _Laura_TESTDevices
ObjectReference Property Laura_TESTDevices Hidden
	ObjectReference Function Get()
		return _Laura_TESTDevices
	EndFunction
EndProperty
Armor _zad_harnessCollar
Armor Property zad_harnessCollar Hidden
	Armor Function Get()
		return _zad_harnessCollar
	EndFunction
EndProperty
Armor _zad_collarPosture
Armor Property zad_collarPosture Hidden
	Armor Function Get()
		return _zad_collarPosture
	EndFunction
EndProperty
Armor _zadx_EboniteHarnessCollar
Armor Property zadx_EboniteHarnessCollar Hidden
	Armor Function Get()
		return _zadx_EboniteHarnessCollar
	EndFunction
EndProperty
Armor _zadx_EboniteBlindfold
Armor Property zadx_EboniteBlindfold Hidden
	Armor Function Get()
		return _zadx_EboniteBlindfold
	EndFunction
EndProperty

Armor _zadx_StraitJacketLatexBlack
Armor Property zadx_StraitJacketLatexBlack Hidden
	Armor Function Get()
		return _zadx_StraitJacketLatexBlack
	EndFunction
EndProperty
Armor _zadx_StraitJacketLatexRed
Armor Property zadx_StraitJacketLatexRed Hidden
	Armor Function Get()
		return _zadx_StraitJacketLatexRed
	EndFunction
EndProperty
Armor _zadx_StraitJacketLatexDressBlack
Armor Property zadx_StraitJacketLatexDressBlack Hidden
	Armor Function Get()
		return _zadx_StraitJacketLatexDressBlack
	EndFunction
EndProperty
Armor _zadx_StraitJacketLatexDressRed
Armor Property zadx_StraitJacketLatexDressRed Hidden
	Armor Function Get()
		return _zadx_StraitJacketLatexDressRed
	EndFunction
EndProperty
Armor _zadx_StraitJacketLatexLegsToplessBlack
Armor Property zadx_StraitJacketLatexLegsToplessBlack Hidden
	Armor Function Get()
		return _zadx_StraitJacketLatexLegsToplessBlack
	EndFunction
EndProperty
Armor _zadx_StraitJacketLatexLegsToplessRed
Armor Property zadx_StraitJacketLatexLegsToplessRed Hidden
	Armor Function Get()
		return _zadx_StraitJacketLatexLegsToplessRed
	EndFunction
EndProperty
Armor _zadx_StraitJacketCatsuitEboniteBlack
Armor Property zadx_StraitJacketCatsuitEboniteBlack Hidden
	Armor Function Get()
		return _zadx_StraitJacketCatsuitEboniteBlack
	EndFunction
EndProperty
Armor _zadx_StraitJacketCatsuitEboniteRed
Armor Property zadx_StraitJacketCatsuitEboniteRed Hidden
	Armor Function Get()
		return _zadx_StraitJacketCatsuitEboniteRed
	EndFunction
EndProperty
Armor _Pahe_DwarvenPetSuit
Armor Property Pahe_DwarvenPetSuit Hidden
	Armor Function Get()
		return _Pahe_DwarvenPetSuit
	EndFunction
EndProperty
Armor _Pahe_DwarvenSlaveSuit
Armor Property Pahe_DwarvenSlaveSuit Hidden
	Armor Function Get()
		return _Pahe_DwarvenSlaveSuit
	EndFunction
EndProperty

Keyword _dd_Armbinder
Keyword Property DD_Armbinder Hidden
	Keyword Function Get()
		return _dd_Armbinder
	EndFunction
EndProperty
Keyword _dd_Blindfold
Keyword Property DD_Blindfold Hidden
	Keyword Function Get()
		return _dd_Blindfold
	EndFunction
EndProperty
Keyword _dd_BondageMittens
Keyword Property DD_BondageMittens Hidden
	Keyword Function Get()
		return _dd_BondageMittens
	EndFunction
EndProperty
Keyword _dd_collar
Keyword Property DD_Collar Hidden
	Keyword Function Get()
		return _dd_collar
	EndFunction
EndProperty
Keyword _dd_Gag
Keyword Property DD_Gag Hidden
	Keyword Function Get()
		return _dd_Gag
	EndFunction
EndProperty

Keyword _dd_Locks
Keyword Property DD_Locks Hidden
	Keyword Function Get()
		return _dd_Locks
	EndFunction
EndProperty
Keyword _dd_Suit
Keyword Property DD_Suit Hidden
	Keyword Function Get()
		return _dd_Suit
	EndFunction
EndProperty
Keyword _dd_Yoke
Keyword Property DD_Yoke Hidden
	Keyword Function Get()
		return _dd_Yoke
	EndFunction
EndProperty

Keyword _dd_AnkleShackles
Keyword Property DD_AnkleShackles Hidden
	Keyword Function Get()
		return _dd_AnkleShackles
	EndFunction
EndProperty
Keyword _dd_ArmbinderElbow
Keyword Property DD_ArmbinderElbow Hidden
	Keyword Function Get()
		return _dd_ArmbinderElbow
	EndFunction
EndProperty

Keyword _dd_BoundCombatDisableKick
Keyword Property DD_BoundCombatDisableKick Hidden
	Keyword Function Get()
		return _dd_BoundCombatDisableKick
	EndFunction
EndProperty
Keyword _dd_CuffsFront
Keyword Property DD_CuffsFront Hidden
	Keyword Function Get()
		return _dd_CuffsFront
	EndFunction
EndProperty

Keyword _dd_ForcedWalk
Keyword Property DD_ForcedWalk Hidden
	Keyword Function Get()
		return _dd_ForcedWalk
	EndFunction
EndProperty

Keyword _dd_Inventory
Keyword Property DD_Inventory Hidden
	Keyword Function Get()
		return _dd_Inventory
	EndFunction
EndProperty
Keyword _dd_HobbleSkirt
Keyword Property DD_HobbleSkirt Hidden
	Keyword Function Get()
		return _dd_HobbleSkirt
	EndFunction
EndProperty

Keyword _dd_PetSuit
Keyword Property DD_PetSuit Hidden
	Keyword Function Get()
		return _dd_PetSuit
	EndFunction
EndProperty
Keyword _dd_Possessed
Keyword Property DD_Possessed Hidden
	Keyword Function Get()
		return _dd_Possessed
	EndFunction
EndProperty
Keyword _dd_StraitJacket
Keyword Property DD_StraitJacket Hidden
	Keyword Function Get()
		return _dd_StraitJacket
	EndFunction
EndProperty

Keyword _dd_TrainOnSpellCast
Keyword Property DD_TrainOnSpellCast Hidden
	Keyword Function Get()
		return _dd_TrainOnSpellCast
	EndFunction
EndProperty
Keyword _dd_PlugVaginal
Keyword Property DD_PlugVaginal Hidden
	Keyword Function Get()
		return _dd_PlugVaginal
	EndFunction
EndProperty
Keyword _dd_PlugAnal
Keyword Property DD_PlugAnal Hidden
	Keyword Function Get()
		return _dd_PlugAnal
	EndFunction
EndProperty
book _zad_book
book Property zad_book Hidden
	book Function Get()
		return _zad_book
	EndFunction
EndProperty
Key _zad_Key
Key Property zad_Key Hidden
	Key Function Get()
		return _zad_Key
	EndFunction
EndProperty

Keyword _ddx_ChainHarnessBody
Keyword Property DDx_ChainHarnessBody Hidden
	Keyword Function Get()
		return _ddx_ChainHarnessBody
	EndFunction
EndProperty

Keyword _zbf_NoSprint
Keyword Property zbf_NoSprint Hidden
	Keyword Function Get()
		return _zbf_NoSprint
	EndFunction
EndProperty
Keyword _zbf_SlowMove
Keyword Property zbf_SlowMove Hidden
	Keyword Function Get()
		return _zbf_SlowMove
	EndFunction
EndProperty
Keyword _SCB_Crawler
Keyword Property SCB_Crawler Hidden
	Keyword Function Get()
		return _SCB_Crawler
	EndFunction
EndProperty
Keyword _dse_PlugAnal
Keyword Property Dse_PlugAnal Hidden
	Keyword Function Get()
		return _dse_PlugAnal
	EndFunction
EndProperty

Actor Property player Auto
Actor Property PAHBackpackMule Auto
Spell Property AbPOIFrozenCorpse Auto

Spell Property WhistleSpell Auto
Spell Property CaptureSpell Auto	;PAHECaptureSP
Idle Property defeatIdle Auto

Perk[] Property EnslavePerks Auto
Perk Property PAHEnslaveFleeingPerk Auto
Perk Property PAHEnslaveCaptivePerk Auto
Float[] Property EnslavePerksToggle Auto

EffectShader Property CaptureShader Auto	;PAHECaptureMarkFX
string Property pahe_version Auto

;# Conditional properties
int Property slave_count Auto Conditional

bool Property is_full Auto Conditional
bool Property bAlwaysAggressive Auto Conditional
bool Property bAlways_Punish_Aggressive Auto Conditional
bool Property jcInstalled Auto Hidden
bool Property sexlab_gender Auto Hidden

;bool Property IsFemale Auto Conditional
;bool Property IsMale Auto Conditional
;bool Property playerIsFemale Auto Conditional
;bool Property playerIsMale Auto Conditional

; RaceMenu Version data
Int Property NIOVERRIDE_VERSION = 6 AutoReadOnly
Int Property NIOVERRIDE_SCRIPT_VERSION = 6 AutoReadOnly
Int Property RM_CBBE_VERSION = 2 AutoReadOnly

String __modStatus
String Property modStatus
	String function get()
		If __modStatus == "running"
			return "$PAHE_SettingName_RebootToggle_running"
		ElseIf __modStatus == "stopped"
			return "$PAHE_SettingName_RebootToggle_stopped"
		ElseIf __modStatus == "restarting"
			return "$PAHE_SettingName_RebootToggle_restarting"
		Else
			return "Unknown, click to restart mod"
		EndIf
	EndFunction
	Function set(String value)
		If value == "running" || value == "stopped" || value == "restarting"
			__modStatus = value
		EndIf
	EndFunction
EndProperty

bool sexSlavesForBanditsInstalled = false
bool moreBanditsSexslavesInstalled = false

Bool Function CheckNiOverride()
	Return SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

;### Events
Event OnPlayerLoadGame()
;	Debug.trace("====================PAHExtension: Startup Process.===================================")
	Debug.trace("=================PAHE8.2.0 mpsd - combat training improvements and released slave friends - test 14: Startup Process.==================================")
	Debug.trace("PAHe" + (pahe_version) + "loaded")
	if !player
		player = Game.GetPlayer()
	EndIf
	Debug.trace("====================PAHExtension: Checking for soft dependencies.====================")
	jcInstalled = JContainers.isInstalled()

	If (Game.GetModByName("paradise_halls_SLExtension.esp") != 255) && (PAHTrainFear != None)
		newFear = Game.GetFormFromFile(0x0001BB4E, "paradise_halls.esm") As Faction
		oldFear = Game.GetFormFromFile(0x0001BB4E, "paradise_halls_SLExtension.esp") As Faction
	endif
	If (Game.GetModByName("DiaryOfMine.esp") != 255)
		old_Humiliation = Game.GetFormFromFile(0x0A410D, "DiaryOfMine.esp") As Faction
		old_Resignation = Game.GetFormFromFile(0x0A410E, "DiaryOfMine.esp") As Faction
		Debug.trace("user has DiaryOfMine addon loaded")
	EndIf
	If (Game.GetModByName("PAH_HomeSweetHome.esp") != 255)
		PAHHouseSlave = Game.GetFormFromFile(0x008972, "PAH_HomeSweetHome.esp") As Faction
		PHHSHPortablePermaCamp = Game.GetFormFromFile(0x03C42A, "PAH_HomeSweetHome.esp") As Form
		Debug.trace("user has PAH_HomeSweetHome addon loaded")
	EndIf
	If (Game.GetModByName("slavers_spellbook.esp") != 255)	;	the slavers spellbook checks are merely informative for cross-mod debugging, no changes are made
		Debug.trace("user has slavers_spellbook.esp addon loaded")
	EndIf
	If (Game.GetModByName("slavers_spellbook_pahe.esp") != 255)
		Debug.trace("user has slavers_spellbook_pahe addon loaded")
	EndIf
	If (Game.GetModByName("slavers_spellbook_slhp.esp") != 255)
		Debug.trace("user has slavers_spellbook_slhp addon loaded")
	EndIf
	If (Game.GetModByName("OBIS SE.esp") != 255)
		OBISFaction = Game.GetFormFromFile(0x000FD4, "OBIS SE.esp") As Faction
		Obis_GlowingPearl = Game.GetFormFromFile(0x000FA8, "OBIS SE.esp") As Ingredient
		Debug.trace("user has OBIS SE loaded")
	ElseIf (Game.GetModByName("Obis.esp") != 255)
		OBISFaction = Game.GetFormFromFile(0x01AE24, "Obis.esp") As Faction
		Debug.trace("user has Obis loaded")
	EndIf
	If (Game.GetModByName("Immersive Wenches.esp") != 255)
		lalawench_new_travellingwenches = Game.GetFormFromFile(0x00218F2, "Immersive Wenches.esp") As Faction
		lalawench_travelling_servants = Game.GetFormFromFile(0x024FCE, "Immersive Wenches.esp") As Faction
		lalawenchpatrolservantfaction = Game.GetFormFromFile(0x031918, "Immersive Wenches.esp") As Faction
		Debug.trace("user has Wenches installed")
		If (Game.GetModByName("Judgment Wenches.esp") != 255)
			WW_wenchminators = Game.GetFormFromFile(0x000A12, "Judgment Wenches.esp") As Faction ;"wenchminators" [FACT:10000A12]
			WW_collected = Game.GetFormFromFile(0x000A05, "Judgment Wenches.esp") As Faction ; "Collected Female" [FACT:10000A05]
			Debug.trace("user has Judgment Wenches installed")
		EndIf
	EndIf
	If (Game.GetModByName("hydra_slavegirls.esp") != 255)
		hyd_ahe_regslave = Game.GetFormFromFile(0x0EBC66, "hydra_slavegirls.esp") As Faction
		Debug.trace("user has hydra_slavegirls.esp loaded")
	EndIf
	If (Game.GetModByName("SexSlavesForVanillaBandits.esp") != 255)
		sexSlavesForBanditsInstalled = true
		sexSlaves = Game.GetFormFromFile(0xD65, "SexSlavesForVanillaBandits.esp") As Faction
		sexSlavesReleased = Game.GetFormFromFile(0xD6B, "SexSlavesForVanillaBandits.esp") As Faction
		Debug.trace("user has SexSlavesForVanillaBandits.esp loaded")
	EndIf
	If !sexSlaves
		If (Game.GetModByName("MoreBanditCamps - SexSlaves.esp") != 255)
			moreBanditsSexslavesInstalled = true
			sexSlaves = (Game.GetFormFromFile(0xD65, "MoreBanditCamps - SexSlaves.esp") As Faction)
			sexSlavesReleased = (Game.GetFormFromFile(0xD6B, "MoreBanditCamps - SexSlaves.esp") As Faction)
			Debug.trace("user has MoreBanditCamps - SexSlaves loaded")
		EndIf
	EndIf
	If (Game.GetModByName("Dawnguard.esm") != 255)
		DLC1ThrallFaction = (Game.GetFormFromFile(0x0162F7, "Dawnguard.esm") As Faction)
		If (DLC1ThrallFaction && (DLC1ThrallFaction != None))
			PAHPlayerSlaveFaction.SetAlly(Game.GetFormFromFile(0x0071D3, "Dawnguard.esm") As Faction); DLC1PlayerVampireLordFaction
			Debug.trace("Dawnguard successfully loaded")
		EndIf
	EndIf
	If (Game.GetModByName("Dragonborn.esm") != 255)
		DLC2RieklingFaction = (Game.GetFormFromFile(0x01D9C9, "Dragonborn.esm") As Faction)
		DLC2CultistFaction = (Game.GetFormFromFile(0x034FBC, "Dragonborn.esm") As Faction)
		Debug.trace("Dragonborn successfully loaded")
	EndIf
	If (Game.GetModByName("Devious Devices - Assets.esm") != 255)
		_dd_PlugVaginal = (Game.GetFormFromFile(0x01DD7C, "Devious Devices - Assets.esm") As Keyword)
		If _dd_PlugVaginal != None
			Debug.trace("DD Vag Plug registered as combat sex training effect")
		EndIf	
		_dd_PlugAnal = (Game.GetFormFromFile(0x01DD7D, "Devious Devices - Assets.esm") As Keyword)
		If _dd_PlugAnal != None
			Debug.trace("DD but Plug registered as combat sex training effect")
		EndIf			
		_dd_Armbinder = (Game.GetFormFromFile(0x00CA3A, "Devious Devices - Assets.esm") As Keyword)
		Debug.trace("Devious Armbinder found")
		_dd_Blindfold = (Game.GetFormFromFile(0x011B1A, "Devious Devices - Assets.esm") As Keyword)
		Debug.trace("Devious Blindfold found")
		_dd_collar = (Game.GetFormFromFile(0x3DF7, "Devious Devices - Assets.esm") As Keyword)
		Debug.trace("Devious collar found")
		_dd_Gag = (Game.GetFormFromFile(0x007EB8, "Devious Devices - Assets.esm") As Keyword)
		Debug.trace("Devious Gag found")
		_dd_Locks = (Game.GetFormFromFile(0x003894, "Devious Devices - Assets.esm") As Keyword)
		Debug.trace("Devious Locks found")
		_dd_Suit = (Game.GetFormFromFile(0x02AFA3, "Devious Devices - Assets.esm") As Keyword)
		_dd_Yoke = (Game.GetFormFromFile(0x02C531, "Devious Devices - Assets.esm") As Keyword)
		Debug.trace("user has Devious Devices - Assets loaded")
	EndIf
	If (Game.GetModByName("Devious Devices - Integration.esm") != 255)
		_dd_AnkleShackles = (Game.GetFormFromFile(0x05F4BB, "Devious Devices - Integration.esm") As Keyword)
		Debug.trace("Devious AnkleShackles found")
		_dd_ArmbinderElbow = (Game.GetFormFromFile(0x062539, "Devious Devices - Integration.esm") As Keyword)
		Debug.trace("Devious ArmbinderElbow found")
		_dd_BondageMittens = (Game.GetFormFromFile(0x05FF81, "Devious Devices - Integration.esm") As Keyword)
		Debug.trace("Devious BondageMittens found")
		_dd_BoundCombatDisableKick = (Game.GetFormFromFile(0x058391, "Devious Devices - Integration.esm") As Keyword)
		Debug.trace("Devious Bound Combat Disable Kick effect registered as combat training effect")
		_dd_CuffsFront = (Game.GetFormFromFile(0x063AD9, "Devious Devices - Integration.esm") As Keyword)
		Debug.trace("Devious CuffsFront found")
		_dd_ForcedWalk = (Game.GetFormFromFile(0x061FD5, "Devious Devices - Integration.esm") As Keyword)
		_dd_HobbleSkirt = (Game.GetFormFromFile(0x05F4BA, "Devious Devices - Integration.esm") As Keyword)
		Debug.trace("Devious HobbleSkirt found")
		_dd_inventory = (Game.GetFormFromFile(0x02B5F0, "Devious Devices - Integration.esm") As Keyword)
		Debug.trace("Devious inventory found registered as special inventory effect")
		_dd_PetSuit = (Game.GetFormFromFile(0x086C1D, "Devious Devices - Integration.esm") As Keyword)
		If _dd_PetSuit != None
			Debug.trace("DD PetSuit registered as combat training effect")
		EndIf			
		_dd_Possessed = (Game.GetFormFromFile(0x01DDCF, "Devious Devices - Integration.esm") As Keyword)
		_dd_StraitJacket = (Game.GetFormFromFile(0x060A46, "Devious Devices - Integration.esm") As Keyword)
		If _dd_StraitJacket != None
			Debug.trace("DD StraitJacket registered as combat training effect")
		EndIf	
		_dd_TrainOnSpellCast = (Game.GetFormFromFile(0x03C3A3, "Devious Devices - Integration.esm") As Keyword)
		Debug.trace("user has Devious Devices - Integration loaded")
		_zad_book = (Game.GetFormFromFile(0x00182D, "Devious Devices - Integration.esm") As book)
		Debug.trace("Devious Devices book found")
		_zad_Key = (Game.GetFormFromFile(0x01775F, "Devious Devices - Integration.esm") As Key)
		Debug.trace("Devious Devices Key found")
		_zad_collarPosture = (Game.GetFormFromFile(0x017759, "Devious Devices - Integration.esm") As Armor)
		Debug.trace("Devious Devices Posture collar found")
		_zad_harnessCollar = (Game.GetFormFromFile(0x031C75, "Devious Devices - Integration.esm") As Armor)
		Debug.trace("Devious Devices harness collar found")
	EndIf
	If (Game.GetModByName("Devious Devices - Expansion.esm") != 255)
		_ddx_ChainHarnessBody = (Game.GetFormFromFile(0x01D0F7, "Devious Devices - Expansion.esm") As Keyword)
		Debug.trace("user has Devious Devices - Expansion loaded")
		_zadx_EboniteHarnessCollar = (Game.GetFormFromFile(0x00D4D3, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Devious Devices Ebonite harness collar found")
		_zadx_EboniteBlindfold = (Game.GetFormFromFile(0x00D4E6, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Devious Ebonite Blindfold found")
		_zadx_StraitJacketLatexBlack = (Game.GetFormFromFile(0x02D9CC, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Black Latex StraitJacket found")
		_zadx_StraitJacketLatexRed = (Game.GetFormFromFile(0x039C6E, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Red Latex StraitJacket found")
		_zadx_StraitJacketLatexDressBlack = (Game.GetFormFromFile(0x03ACA5, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Black Latex StraitJacket Dress found")
		_zadx_StraitJacketLatexDressRed = (Game.GetFormFromFile(0x04E2EA, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Red Latex StraitJacket Dress found")
		_zadx_StraitJacketLatexLegsToplessBlack = (Game.GetFormFromFile(0x039C6A, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Black Latex Topless StraitJacket Legbinder found")
		_zadx_StraitJacketLatexLegsToplessRed = (Game.GetFormFromFile(0x039C6B, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Red Latex Topless StraitJacket Legbinder found")
		_zadx_StraitJacketCatsuitEboniteBlack = (Game.GetFormFromFile(0x00234E, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Black Latex StraitJacket Catsuit found")
		_zadx_StraitJacketCatsuitEboniteRed = (Game.GetFormFromFile(0x002354, "Devious Devices - Expansion.esm") As Armor)
		Debug.trace("Red Latex StraitJacket Catsuit found")
	EndIf
	If (Game.GetModByName("dse-buttplug.esp") != 255)
		_dse_PlugAnal = (Game.GetFormFromFile(0x00082F, "dse-buttplug.esp") As Keyword)
		If _dse_PlugAnal != None
			Debug.trace("dse but Plug registered as combat sex training effect")
		EndIf			
	EndIf
	If (Game.GetModByName("Laura's Bondage Shop.esp") != 255)
		_LauraContainer = (Game.GetFormFromFile(0x004F05, "Laura's Bondage Shop.esp") As ObjectReference)
		If _LauraContainer != None
			Debug.trace("Laura's Bondage Shop found")
		EndIf			
		_Laura_TESTDevices = (Game.GetFormFromFile(0x0999FA, "Laura's Bondage Shop.esp") As ObjectReference)
		If _Laura_TESTDevices != None
			Debug.trace("Laura's Bondage Shop TEST chest found")
		EndIf			
	EndIf
	If (Game.GetModByName("Pahe_Dwarven_Devious_suits.esp") != 255)
		_Pahe_DwarvenPetSuit = (Game.GetFormFromFile(0x000800, "Pahe_Dwarven_Devious_suits.esp") As Armor)
		If _Pahe_DwarvenPetSuit != None
			Debug.trace("Dwarven Devious pet suit found")
		EndIf			
		_Pahe_DwarvenSlaveSuit = (Game.GetFormFromFile(0x000804, "Pahe_Dwarven_Devious_suits.esp") As Armor)
		If _Pahe_DwarvenSlaveSuit != None
			Debug.trace("Dwarven Devious Slave suit found")
		EndIf			
	EndIf
	If (Game.GetModByName("pahe-DeviousDevices-addon-patch.esp") != 255)
		Debug.Notification("Pahe-DeviousDevices-addon-patch.esp obsolete!")
		Debug.trace("user has Pahe-DeviousDevices-addon-patch.esp loaded")
	EndIf
	If (Game.GetModByName("Pahe-DeviousDevices-addon-DDx-patch.esp") != 255)
		Debug.Notification("Pahe-DeviousDevices-addon-DDx-patch.esp obsolete!")
		Debug.trace("user has Pahe-DeviousDevices-addon-DDx-patch.esp loaded")
	EndIf
	If (Game.GetModByName("paradise_halls_SLExtension.esp") == 255)
		Debug.Notification("paradise_halls_SLExtension.esp required!")
		Debug.trace("user has pahcore loaded without Pahe")
		while (Game.GetModByName("paradise_halls_SLExtension.esp") == 255)
			Debug.Notification("paradise_halls_SLExtension.esp required!")
			Debug.Notification(", quit without save!!")
		EndWhile
	EndIf
	If (Game.GetModByName("ZaZAnimationPack.esm") != 255)
		_zbf_NoSprint = (Game.GetFormFromFile(0x008A34, "ZaZAnimationPack.esm") As Keyword)
		Debug.trace("zbf NoSprint effect registered as leash collar effect")
		_zbf_SlowMove = (Game.GetFormFromFile(0x008A37, "ZaZAnimationPack.esm") As Keyword)
		Debug.trace("zbf SlowMove effect registered as leash collar effect")
	EndIf
	If (Game.GetModByName("SkyrimChainBeasts.esm") != 255)
		_SCB_Crawler = (Game.GetFormFromFile(0x004AF8, "SkyrimChainBeasts.esm") As Keyword)
		Debug.trace("Skyrim ChainBeasts Crawler found")
		Debug.trace("user has Skyrim ChainBeasts loaded")
	EndIf
	If (Game.GetModByName("SexLabAroused.esm") != 255)
		arousedInstalled = (Game.GetFormFromFile(0x04290F, "SexLabAroused.esm") as Quest)
		Debug.trace("user has SexLabAroused loaded")
	EndIf
	If (Game.GetModByName("SexLab Attraction.esm") != 255)
		attractionInstalled = (Game.GetFormFromFile(0x12c7, "SexLab Attraction.esm") as Quest)
		Debug.trace("user has SexLab Attraction loaded")
	EndIf
	If (Game.GetModByName("SexLabDefeat.esp") != 255)
		defeatActive = (Game.GetFormFromFile(0x5c666, "SexLabDefeat.esp") as Keyword)
		Debug.trace("user has SexLabDefeat loaded")
	EndIf
	Debug.trace("====================PAHExtension: End of soft dependencies.==========================")
	registerKeys()
	slaveMaintenance()
	makeRestraintsNoStrip()
	addRestraintsMerchants()
;	updateSlaveArray(refresh = true)
	Debug.trace("====================PAHExtension: Startup Process finished.==========================")
	If Config.debugToggle
		Debug.Notification("PAHcore loaded")
	EndIf
	;Debug.Notification("PAHe" + (pahe_version) + "loaded")
EndEvent

Event OnBootstrap()
	RegisterForSingleUpdate(0.5)
	SetObjectiveDisplayed(0)
	OnPlayerLoadGame()
EndEvent

Event OnUpdate()
	FalsifyClearingLeastPointOnTick()
	RegisterForSingleUpdate(0.5)
EndEvent

Function registerKeys()
	If Config.hotkey != -1
		RegisterForKey(Config.hotkey)
	EndIf
	If Config.whistleKey != -1
		RegisterForKey(Config.whistleKey)
	EndIf
	If Config.modifierKey != -1
		RegisterForKey(Config.modifierKey)
	EndIf
EndFunction

Function addRestraintsMerchants()
	If (Laura_TESTDevices != None) && (Pahe_DwarvenPetSuit != None)
		If Laura_TESTDevices.GetItemCount(Pahe_DwarvenPetSuit) < 1
			Laura_TESTDevices.addItem(Pahe_DwarvenPetSuit, 2, true)
		EndIf
		If Laura_TESTDevices.GetItemCount(Pahe_DwarvenSlaveSuit) < 1
			Laura_TESTDevices.addItem(Pahe_DwarvenSlaveSuit, 2, true)
		EndIf
		If LauraContainer.GetItemCount(Pahe_DwarvenPetSuit) < 1
			LauraContainer.addItem(Pahe_DwarvenPetSuit, 2, true)
		EndIf
		If LauraContainer.GetItemCount(Pahe_DwarvenSlaveSuit) < 1
			LauraContainer.addItem(Pahe_DwarvenSlaveSuit, 2, true)
		EndIf
	EndIf
;ObjectReference Property LauraContainer Auto ; Laura's Stock
	If CaravanAChestREF.GetItemCount(PAHEArmorFixerForcedSOS) < 1
		CaravanAChestREF.addItem(PAHEArmorFixerForcedSOS, 2, true)
	EndIf
	If CaravanBChestREF.GetItemCount(PAHEArmorFixerForcedSOS) < 1
		CaravanBChestREF.addItem(PAHEArmorFixerForcedSOS, 2, true)
	EndIf
	If CaravanCChestREF.GetItemCount(PAHEArmorFixerForcedSOS) < 1
		CaravanCChestREF.addItem(PAHEArmorFixerForcedSOS, 2, true)
	EndIf
	If CaravanAChestREF.GetItemCount(PAHEzbfCuffsSteel) < 1
		CaravanAChestREF.addItem(PAHEzbfCuffsSteel, 2, true)
	EndIf
	If CaravanBChestREF.GetItemCount(PAHEzbfCuffsSteel) < 1
		CaravanBChestREF.addItem(PAHEzbfCuffsSteel, 2, true)
	EndIf
	If CaravanCChestREF.GetItemCount(PAHEzbfCuffsSteel) < 1
		CaravanCChestREF.addItem(PAHEzbfCuffsSteel, 2, true)
	EndIf
	If CaravanAChestREF.GetItemCount(CuffsIronBrown) < 1
		CaravanAChestREF.addItem(CuffsIronBrown, 2, true)
	EndIf
	If CaravanBChestREF.GetItemCount(CuffsIronBrown) < 1
		CaravanBChestREF.addItem(CuffsIronBrown, 2, true)
	EndIf
	If CaravanCChestREF.GetItemCount(CuffsIronBrown) < 1
		CaravanCChestREF.addItem(CuffsIronBrown, 2, true)
	EndIf

	If CaravanAChestREF.GetItemCount(PAHIronSlaveCollarLeashing) < 1
		CaravanAChestREF.addItem(PAHIronSlaveCollarLeashing, 2, true)
	EndIf
	If CaravanBChestREF.GetItemCount(PAHIronSlaveCollarLeashing) < 1
		CaravanBChestREF.addItem(PAHIronSlaveCollarLeashing, 2, true)
	EndIf
	If CaravanCChestREF.GetItemCount(PAHIronSlaveCollarLeashing) < 1
		CaravanCChestREF.addItem(PAHIronSlaveCollarLeashing, 2, true)
	EndIf
	If (DD_Collar != None) && (DD_inventory != None)
		If CaravanAChestREF.GetItemCount(zad_Key) < 1
			CaravanAChestREF.addItem(zad_Key, 2, true)
		EndIf
		If CaravanBChestREF.GetItemCount(zad_Key) < 1
			CaravanBChestREF.addItem(zad_Key, 2, true)
		EndIf
		If CaravanCChestREF.GetItemCount(zad_Key) < 1
			CaravanCChestREF.addItem(zad_Key, 2, true)
		EndIf
	EndIf
EndFunction

Function slaveMaintenance()
	int i = 0
	while i < slaveArray.length
		slaveArray[i].registerSexEvent()
		If slaveArray[i].getName() == "" || slaveArray[i].getName() == "slave"
			slaveArray[i].setDisplayName(slaveArray[i].actor_alias.getDisplayName())
		Endif
		i += 1
	EndWhile
EndFunction

Function makeRestraintsNoStrip()
	SexLab.ActorLib.MakeNoStrip(CuffsRope)
	SexLab.ActorLib.MakeNoStrip(CuffsLeather)
	SexLab.ActorLib.MakeNoStrip(CuffsIron)
	SexLab.ActorLib.MakeNoStrip(CuffsIronBrown)
	SexLab.ActorLib.MakeNoStrip(CuffsSimpleBlack)
	SexLab.ActorLib.MakeNoStrip(CuffsSimpleBrown)
	SexLab.ActorLib.MakeNoStrip(WristLeather)
	SexLab.ActorLib.MakeNoStrip(WristIron)
	SexLab.ActorLib.MakeNoStrip(AnkleLeather)
	SexLab.ActorLib.MakeNoStrip(AnkleIron)
EndFunction

Event OnKeyDown(Int KeyCode)
	if !player
		player = Game.GetPlayer()
	EndIf
	If !Utility.IsInMenuMode()
		If Config.whistleKey && ((Config.whistleKey != -1) && (KeyCode == Config.whistleKey))
			WhistleSpell.Cast(player)
			;Actor player_ref = Game.GetPlayer()
			int i = 0
			while (i < slave_aliases.length)
				If (slave_aliases[i].GetActorRef() && (slave_aliases[i].GetActorRef() != None))
					If (slave_aliases[i].GetActorRef().GetParentCell() == (PAHUtilityCell))
						slave_aliases[i].GetActorRef().MoveTo(player)
					EndIf
				Else
					Debug.trace("slave has no valid reference alias in PAHcore")
					Debug.trace("whistleKey in PAHcore WILL IGNORE utility cell move")
					Debug.Notification("whistleKey in PAHcore...")
					Debug.Notification(" WILL IGNORE utility cell move")
				EndIf
				i += 1
			endwhile
		ElseIf Config.whistleKey && (KeyCode == Config.whistleKey)
		ElseIf KeyCode == Config.hotKey
	;		If Input.IsKeyPressed(Config.modifierKey)
				
	;		Else
				getSlaveCandidateByKeypress()
	;		EndIf
		EndIf
	EndIf
EndEvent

Bool Function MarkTarget(Actor Target)
	Actor MarkedOne = (slaveCandidate.GetReference() As Actor)
	If (!MarkedOne || (MarkedOne && (MarkedOne != Target)))
		slaveCandidate.ForceRefTo(Target)
		(slaveCandidate as PAHE_slaveCandidate).Filled()
		CaptureShader.Play(Target, 0.5) ; MarkFXS
		Return True
	Endif
	Return False
EndFunction

Function getSlaveCandidateByKeypress()
	Actor Target = GetCurrentCrosshairRef() as Actor
	If Target
		If !target.IsInFaction(PAHHouseSlave)
			If slaveCandidate && Target == slaveCandidate.getActorRef()
				If target.IsInFaction(PAHPlayerSlaveFaction) && !target.IsBleedingOut()
					Overwhelm()
				ElseIf !Target.Haslos(Player) && !target.IsBleedingOut()
					Overwhelm()
				ElseIf Target.HasKeyword(ActorTypeDwarven)
					Overwhelm()
				Else
;					If ((Game.GetModByName("SexSlavesForVanillaBandits.esp") != 255) || (Game.GetModByName("MoreBanditCamps - SexSlaves.esp") != 255))
					If (sexSlavesForBanditsInstalled || moreBanditsSexslavesInstalled)
						If sexSlaves != None && target.IsInFaction(sexSlaves)
							;#Overwhelm()
							slaveCandidate.ChangeState("Defeated")
						EndIf
					EndIf
				EndIf
			Else
				CaptureSpell.Cast(player, Target)
			EndIf
		EndIf
	Else
		CaptureSpell.Cast(player)
	EndIf
EndFunction

Function Overwhelm()
	Idle overwhelm = (Game.GetFormFromFile(0x37BF8, "paradise_halls_SLExtension.esp") As Idle)
	slaveCandidate.getActorRef().PlayIdleWithTarget(overwhelm, player)
	Utility.Wait(0.3)
	If Player.GetAnimationVariableBool("bIsSynced")
		float i = 5.0
		While (Player.GetAnimationVariableBool("bIsSynced") && (i > 0.0))
			utility.Wait(0.2)
			i -= 0.2
		EndWhile
	EndIf
	slaveCandidate.ChangeState("Defeated")
EndFunction

;### Public
PAHSlave Function AddSlave(Actor slave_actor)
	SetObjectiveDisplayed(0)
	ReferenceAlias slave_alias

	slave_alias = GetSlave(slave_actor)
	If slave_alias != None
		return slave_alias as PAHSlave
	EndIf

	slave_alias = GetEmptyAlias()
	If slave_alias == None
		return None
	EndIf

	String name = slave_actor.getDisplayName()
	slave_alias.ForceRefTo(slave_actor)
	refreshNames()
	(slave_alias as PAHSlave).setDisplayName(name)
	updateSlaveArray(slave_alias as PAHSlave)

	(slave_alias as PAHActorAlias).AfterAssign()
	(slave_alias as PAHSlave).AfterAssign()
	(slave_alias as PAHSlaveMind).AfterAssign()

	UpdateSlaveCount()
	return slave_alias as PAHSlave
EndFunction

PAHSlave Function AddCombatSlave(Actor slave_actor)
	PAHSlave slave = AddSlave(slave_actor)
	if slave == None
		return None
	endif

	slave.TrainCombat(999)
	slave.actor_alias.aggression = 1
	slave.actor_alias.assistance = 2
	slave.actor_alias.confidence = 4
	slave.GetActorRef().RemoveFromFaction(dunPrisonerFaction)
	slave.GetActorRef().AddToFaction(DunPlayerAllyFaction)
	slave.GetActorRef().AddToFaction(PAHShouldFightForPlayer)
	slave.GetActorRef().SetPlayerTeammate()

	return slave
EndFunction

PAHSlave Function AddSlutSlave(Actor slave_actor)
	PAHSlave slave = AddSlave(slave_actor)
	if slave == None
		return None
	endif


	slave.TrainOral(365)
	slave.TrainVaginal(365)
	slave.TrainAnal(365)
	slave.TrainSex(365)
	slave.GetActorRef().setRelationshipRank(Player, 4)

	return slave
EndFunction

PAHSlave Function AddRespectfulSlave(Actor slave_actor)
	PAHSlave slave = AddSlave(slave_actor)
	if slave == None
		return None
	endif

	slave.TrainRespect(200)
	slave.GetActorRef().AddToFaction(PAHShouldBeRespectful)
	slave.GetActorRef().AddToFaction(PAHRespectful)
	slave.GetActorRef().setRelationshipRank(Player, 4)

	return slave
EndFunction

PAHSlave Function AddSubmissiveSlave(Actor slave_actor)
	PAHSlave slave = AddSlave(slave_actor)
	if slave == None
		return None
	endif

	slave.TrainSubmission(200)
	;slave.TrainResignation(200)
	slave.GetActorRef().setRelationshipRank(Player, 4)

	return slave
EndFunction

PAHSlave Function Add_70Sub_Slave(Actor slave_actor)
	PAHSlave slave = AddSlave(slave_actor)
	if slave == None
		return None
	endif

	slave.TrainSubmission(70)
	;slave.TrainResignation(70)
	slave.GetActorRef().setRelationshipRank(Player, 4)

	return slave
EndFunction

Function refreshNames()
	String[] names = _slave_names
	int i = names.length
	While i > 0
		i -= 1
		_slave_array[i].setDisplayName(names[i])
	EndWhile
EndFunction

Function RemoveSlave(ReferenceAlias slave_alias)
	(slave_alias as PAHSlaveMind).BeforeClear()
	(slave_alias as PAHSlave).BeforeClear()
	(slave_alias as PAHActorAlias).BeforeClear()
	slave_alias.clear()

	updateSlaveArray(refresh = true)
	UpdateSlaveCount()
EndFunction

ReferenceAlias Function GetSlaveAlias(Actor slave_actor)
	Int i = 0
	While i < slave_aliases.length
		If slave_aliases[i] && slave_aliases[i].GetActorRef() == slave_actor
			return slave_aliases[i]
		EndIf
		i += 1
	EndWhile

	return None
EndFunction

PAHSlave Function GetSlave(Actor slave_actor)
	return GetSlaveAlias(slave_actor) as PAHSlave
EndFunction

Function PlayerEquipWeapon(Weapon weapon_to_equip)
	If player.GetItemCount(weapon_to_equip) > 0
		player.EquipItem(weapon_to_equip)
		player.DrawWeapon()
	EndIf
EndFunction

Function HandleLocationChange()
	; Actor player_ref = Game.GetPlayer()
	; Worldspace ws_ref = player_ref.GetWorldSpace()

	; int i = 0
	; while (i < slave_aliases.length)
	; 	If (slave_aliases[i] as PAHActorAlias).accompanying_player && !IsTogetherWith(slave_aliases[i].GetActorRef(), Game.GetPlayer())
	; 		slave_aliases[i].GetActorRef().MoveTo(player_ref)
	; 	EndIf
	; 	i += 1
	; endwhile
EndFunction

Function RegisterPersonalityDefinition(PAHPersonalityDefinition personality_definition)
	int i = 0
	While (i < personality_definitions.length)
		If personality_definitions[i] != None
			personality_definitions[i] = personality_definition
			return
		EndIf
		i += 1
	EndWhile
EndFunction

;### Private
ReferenceAlias Function GetEmptyAlias()
	Int i = 0
	While i < slave_aliases.length
		If slave_aliases[i].GetRef() == None
			return slave_aliases[i]
		EndIf
		i += 1
	EndWhile

	return None
EndFunction

Int Function GetSlaveCount()
	int count = 0;
	int i = 0
	While i < slave_aliases.length
		If slave_aliases[i].GetRef() != None
			count += 1
		EndIf
		i += 1
	EndWhile
	return count
EndFunction

Int Function GetMaxSlaveCount()
	return slave_aliases.length
EndFunction

PAHSlave Function GetSlaveByIndex(int index)
	If (index >= 0) && (index < GetSlaveCount())
		return slaveArray[index]
	EndIf
	return None
EndFunction

PAHSlave[] _slave_array
PAHSlave[] Property slaveArray
	PAHSlave[] Function Get()
		If !_slave_array
			updateSlaveArray()
		EndIf
		return _slave_array
	endFunction
EndProperty

String[] _slave_names
String Function getSlaveName(int index)
	return _slave_names[index]
EndFunction

Function setSlaveName(int index)
	PAHSlave slave = _slave_array[index]
	_slave_names[index] = slave.GetActorRef().getDisplayName()
EndFunction

Function updateSlaveArray(PAHSlave newSlave = None, bool refresh = false)
	int slaveCount = GetSlaveCount()
	If slaveCount == 0 && newSlave == None && !_slave_array
		Debug.Trace("PAHCore: WARNING skipping updateSlaveArray slaveCount="+slaveCount+" refresh="+refresh+" newSlave="+newSlave)
		return
	endif
	PAHSlave[] tmp_slaveArray = GetSlaveArrayLength(slaveCount)
	String[] tmp_stringArray = GetStringArrayLength(slaveCount)
; 	String[] tmp_stringArray = utility.CreateStringArray(slaveCount)
	int currentSlaveIndex = 0
	int aliasIndex = 0
	
	If newSlave
		While aliasIndex < _slave_array.length
			tmp_slaveArray[aliasIndex] = _slave_array[aliasIndex]
			tmp_stringArray[aliasIndex] = _slave_array[aliasIndex].getName()
			aliasIndex += 1
		EndWhile
		tmp_slaveArray[aliasIndex] = newSlave
		tmp_stringArray[aliasIndex] = newSlave.getName()
	ElseIf refresh
		While aliasIndex < _slave_array.length
			If _slave_array[aliasIndex].GetActorRef()
				tmp_slaveArray[currentSlaveIndex] = _slave_array[aliasIndex]
				tmp_stringArray[currentSlaveIndex] = _slave_array[aliasIndex].getName()
				currentSlaveIndex += 1
			EndIf
			aliasIndex += 1
		EndWhile
	Else
		While aliasIndex < slave_aliases.length
			PAHSlave slave = slave_aliases[aliasIndex] as PAHSlave
			If slave.GetActorRef() && slave.GetActorRef().GetFormID()
				tmp_slaveArray[currentSlaveIndex] = slave
				tmp_stringArray[currentSlaveIndex] = slave.getName()
				currentSlaveIndex += 1
			EndIf
			aliasIndex += 1
		EndWhile
	EndIf
	
	_slave_array = tmp_slaveArray
	_slave_names = tmp_stringArray
;	EndIf
EndFunction

;PAHSlave[] Function GetAllSlaves()
;	return _slave_array
;EndFunction

Int Function UpdateSlaveCount()
	If !slaveArray
		slave_count = GetSlaveCount()
	Else
		slave_count = slaveArray.length
	EndIf
	is_full = slave_count == slave_aliases.length
	If Config.showSlaveCountToggle
		Debug.Notification("Active Slaves: " + slave_count as String + "/" + slave_aliases.length as String)
	EndIf
	return slave_count as int
EndFunction

; Function _handle_on_player_changed_action()
; 	If (Game.GetPlayer().GetCombatState() > 0) != player_in_combat || Game.GetPlayer().IsSneaking() != player_sneaking || Game.GetPlayer().IsWeaponDrawn() != player_weapon_drawn
; 		player_in_combat = Game.GetPlayer().GetCombatState() > 0
; 		player_sneaking = Game.GetPlayer().IsSneaking()
; 		player_weapon_drawn = Game.GetPlayer().IsWeaponDrawn()

; 		int i = 0
; 		While i < slave_aliases.length
; 			If slave_aliases[i].GetActorRef() != None
; 				slave_aliases[i].OnPlayerChangedAction()
; 			EndIf
; 			i += 1
; 		EndWhile
; 	EndIf
; EndFunction

;### Capture
bool considerFactions = false
bool issexSlaves = false
bool issexSlavesReleased = false;

Function CaptureBase(Actor captive, int type)
;  type = 0 standard capture, 1 : capture with submission>70
;	check for a client identifying mark - keep it for later
;
	string client_marker = StorageUtil.GetStringValue(captive, "pahe_client_identifier", "")
	if client_marker == ""
		Debug.trace("slavers_spellbook: pahcore: no mark found")
	else
		Debug.trace("slavers_spellbook: pahcore: marked with " + client_marker)
	endif

										If Config.debugToggle
											Debug.trace("[PAHCore] Enslavement started")
										EndIf
	Actor cleaned_captive
	If ((Game.GetModByName("PAH_HomeSweetHome.esp") == 255) || !captive.IsInFaction(PAHHouseSlave))

		Debug.SendAnimationEvent(captive, "BleedOutStart")

		int[] captiveData = NpcEval.GetActorData(captive)
										If Config.debugToggle
											Debug.trace("[PAHCore] ActorData stored in eval")
										EndIf

		cleaned_captive = Clone(captive)
			If cleaned_captive != None
				If Config.debugToggle
					Debug.trace("[PAHCore] slave cloned")
				EndIf
				captive.EndDeferredKill()
				captive.KillEssential(player)
				captive.Kill()
			Else
				If Config.debugToggle
					Debug.trace("[PAHCore] Cloning failed")
					If Config.showSlaveCountToggle
						Debug.Notification("[PAHCore] Cloning failed")
					EndIf
				EndIf
			EndIf
		If cleaned_captive != None
			cleaned_captive.AllowPCDialogue(false)
			if type == 1
				Add_70Sub_Slave(cleaned_captive)
			else
				AddSlave(cleaned_captive)
			endIf
			;UpdateSlaveCount()
  
										If Config.debugToggle
											Debug.trace("[PAHCore] Slave list updated")
										EndIf
			cleaned_captive.SetRelationshipRank(player, -2)
			If considerFactions
				If (issexSlaves || issexSlavesReleased)
					randomizeTraining(cleaned_captive)
				EndIf
				resetFactions()
			EndIf

			NpcEval.StoreNpcFactionInfo(cleaned_captive, captiveData)

		
										If Config.debugToggle
											Debug.trace("[PAHCore] eval data stored in slave")
										EndIf

			If captive != cleaned_captive
				cleaned_captive.setAlpha(0.0)
				switchActors(captive, cleaned_captive)
			EndIf

			cleaned_captive.AllowPCDialogue(true)
			cleaned_captive.setAlpha(1)
			cleaned_captive.SetDontMove(False)
;
;			if the slave had an identifying mark from a client mod
;			replicate that mark on the clone
;

			Debug.trace("slavers_spellbook: pahcore: cleaning done")
			if client_marker == ""
				Debug.trace("slavers_spellbook: pahcore: no mark found")
			else
				Debug.trace("slavers_spellbook: pahcore: marked with " + client_marker + " - setting on clone")
				StorageUtil.SetStringValue(cleaned_captive, "pahe_client_identifier", client_marker)
			endif
;
;			inform anyone who may be interested that we made a new slave
;
			debug.trace("PAHCore: sending slavers_spellbook New PAHE_Slave")
			int handle = ModEvent.Create("PAHE_NewSlave")
			if (handle)
				ModEvent.PushForm(handle, self)
				ModEvent.PushForm(handle, cleaned_captive)
				ModEvent.Send(handle)
			endIf



										If Config.debugToggle
											Debug.trace("[PAHCore] Enslavement finished")
										EndIf
		EndIf
	EndIf
EndFunction

Function Capture(Actor captive)
	CaptureBase(captive,0)
EndFunction

Function Capture_70Sub_Slave(Actor captive)
	CaptureBase(captive,1)
EndFunction

Actor Function Clone(Actor original)
	If original.IsInFaction(PAHCleaned)
										If Config.debugToggle
											Debug.trace("[PAHCore] Actor already enslaved")
				Debug.Notification("[PAHCore] Actor already enslaved")
				Debug.Notification("[PAHCore] skipping clone feature")
								EndIf
		return original
	EndIf

	ActorBase original_base = GetValidActorBase(original)
										If Config.debugToggle && original_base != None
											Debug.trace("[PAHCore] Enslavement started")
										EndIf
	Actor clone
	ActorBase clone_base

	If ((Game.GetModByName("SexSlavesForVanillaBandits.esp") != 255) || (Game.GetModByName("MoreBanditCamps - SexSlaves.esp") != 255))
		considerFactions = getFactions(original)
	EndIf

	if !player
		player = Game.GetPlayer()
	EndIf
	EncounterZone level_band_zone = getEncounterZone(original.getLevel())

	int tries = 0
	While tries < 100

		clone = CloneMarker.PlaceActorAtMe(original_base, 4, level_band_zone)
		If actor_base_is_similar(original_base, clone.GetLeveledActorBase())
			
			If original.IsInFaction(PAHPlayerSlaveFaction)
				randomizeTraining(Clone)
			EndIf
			;# Copy gear across and set outfit
			If (original_base.IsUnique() && (!Config.NakedOutfitDisabled || Config.NakedOutfit_Uniques_Only))
				Debug.trace("applying default naked outfit to a unique!")
				clone.SetOutfit(PAHNothingOutfit)
				clone.SetOutfit(PAHNothingOutfit, true)
			ElseIf (!original_base.IsUnique() && !Config.NakedOutfitDisabled && !Config.NakedOutfit_Uniques_Only)
				Debug.trace("applying default naked outfit to random npc")
				clone.SetOutfit(PAHNothingOutfit)
				clone.SetOutfit(PAHNothingOutfit, true)
			ElseIf (!original_base.IsUnique() && Config.NakedOutfit_Uniques_Only)
				Debug.trace("naked outfit set to uniques only, npc is not unique, skipping naked outfit!")			
			ElseIf (Config.NakedOutfitDisabled && !Config.NakedOutfit_Uniques_Only)
				Debug.trace("naked outfit disabled, skipping!")			
			EndIf
			clone.RemoveAllItems()
		
			Int i = original.GetNumItems()
			Form the_form

			While i > 0
				i -= 1
				the_form = original.GetNthForm(i)
				If !(defeatActive && the_form.HasKeyword(Keyword.GetKeyword("DefeatWornDevice")))
					clone.AddItem(the_form, original.GetItemCount(the_form))
					If the_form as Armor != None
						clone.EquipItem(the_form, true)
					EndIf
				EndIf
			EndWhile
			If (Game.GetModByName("OBIS SE.esp") != 255)
				clone.AddItem(Obis_GlowingPearl)
			EndIf
;			clone.SetActorOwner(None)
			copySexStats(clone, original)
			clone = cleanActor(clone)
			If original.IsInFaction(PAHPlayerSlaveFaction)
				clone.setFactionRank(PAHSubmission, original.getFactionRank(PAHSubmission))
				clone.setFactionRank(PAHTrainCombat, original.getFactionRank(PAHTrainCombat))
				clone.setFactionRank(PAHTrainAnger, original.getFactionRank(PAHTrainAnger))
				clone.setFactionRank(PAHTrainRespect, original.getFactionRank(PAHTrainRespect))
				clone.setFactionRank(PAHTrainPose, original.getFactionRank(PAHTrainPose))

				clone.setFactionRank(PAHTrainAnal, original.getFactionRank(PAHTrainAnal))
				clone.setFactionRank(PAHTrainSex, original.getFactionRank(PAHTrainSex))
				clone.setFactionRank(PAHTrainOral, original.getFactionRank(PAHTrainOral))
				clone.setFactionRank(PAHTrainVaginal, original.getFactionRank(PAHTrainVaginal))
				clone.setFactionRank(PAHTrainFear, original.getFactionRank(PAHTrainFear))

				clone.setFactionRank(PAHRegionFaction, original.getFactionRank(PAHRegionFaction))
				clone.setFactionRank(PAHJobsFaction, original.getFactionRank(PAHJobsFaction))
				clone.setFactionRank(PAHEmployersFaction, original.getFactionRank(PAHEmployersFaction))
			EndIf
			;If !original.IsInFaction(PAHMoodJustCaptured)
			;EndIf

			CheckGender(original)
			if (original.getFactionRank(PAH_gender) != original.GetActorBase().GetSex())
				if (original.getFactionRank(PAH_gender) == 0)
					SexLab.TreatAsMale(clone)
					clone.AddToFaction(PAH_gender)
					clone.setFactionRank(PAH_gender, 0)
				ElseIf (original.getFactionRank(PAH_gender) == 1)
					SexLab.TreatAsFemale(clone)
					clone.AddToFaction(PAH_gender)
					clone.setFactionRank(PAH_gender, 1)
				Else
					CheckGender(clone)
				EndIf
			Else
				CheckGender(clone)
			EndIf
			If Config.renameToggle && !original_base.IsUnique()
				string name = NameGenerator(clone)
				if name != ""
					clone.SetDisplayName(name)
				endif
			EndIf
			setSLSkills(original, clone)
			return clone
		Else
			clone.Kill()
			clone.Delete()
		EndIf
		tries += 1
	EndWhile
										If Config.debugToggle && original_base != None
											Debug.trace("[PAHCore] Failed to produce clone")
										EndIf
	return None
EndFunction

Actor Function CloneLeveledActorBase(Actor original)
	return Clone(original)
EndFunction

Actor Function CloneLeveledEncounterZone(Actor original)
	return Clone(original)
EndFunction

string Function NameGenerator(Actor akRef)
	string gender
	If (akRef.getFactionRank(PAH_gender) == 0)
		gender = "Male"
	Else
        	gender = "Female"
	EndIf
	string sRace = akRef.getRace().getName()
        
	If Config.mixed_race_Toggle
		int jNames = JValue.readFromFile("Data/PAHE/" + gender + ".txt")
        	int rInt = Utility.RandomInt(0, JArray.count(jnames) - 1)
		string name = JArray.getStr(jnames, rInt)
		If name == ""
			Debug.trace("[PAHNameGenerator] Line 582 No name found for " + gender + sRace)
		Else    
			return name
		EndIf
    	endif
    
	int jNames = JValue.readFromFile("Data/PAHE/" + gender + sRace + ".txt")
	int rInt = Utility.RandomInt(0, JArray.count(jnames) - 1)
	string name = JArray.getStr(jnames, rInt)
	If name == ""
		Debug.trace("[PAHNameGenerator] Line 582 No name found for " + gender + sRace)
	EndIf
	return name
EndFunction

Actor Function PrecleanActor(actor _a)
	_a.SetCrimeFaction(None)
	_a.RemoveFromFaction(MarriageExcludedFaction)
	_a.RemoveFromFaction(PlayerFollowerFaction)
	_a.RemoveFromFaction(currentFollowerFaction)
	_a.RemoveFromFaction(currentHireling)
	_a.RemoveFromFaction(PotentialFollowerFaction)
	_a.RemoveFromFaction(MQ201PartyGuestUnhappy)

	If (hyd_ahe_regslave != None && _a.IsInFaction(hyd_ahe_regslave))
		_a.RemoveFromFaction(hyd_ahe_regslave)	; hydra_slavegirls faction
	EndIf

	If (lalawench_new_travellingwenches != None && _a.IsInFaction(lalawench_new_travellingwenches))
		_a.RemoveFromFaction(lalawench_new_travellingwenches)	; travelling wenches faction
	EndIf
	If (lalawench_travelling_servants != None && _a.IsInFaction(lalawench_travelling_servants))
		_a.RemoveFromFaction(lalawench_travelling_servants)	; travelling wenches faction
	EndIf
	If (lalawenchpatrolservantfaction != None && _a.IsInFaction(lalawenchpatrolservantfaction))
		_a.RemoveFromFaction(lalawenchpatrolservantfaction)	; Wench servant Patrol faction
	EndIf

	If (Game.GetModByName("Judgment Wenches.esp") != 255)
		If (WW_wenchminators != None && _a.IsInFaction(WW_wenchminators))
			_a.RemoveFromFaction(WW_wenchminators)	 ;"wenchminators" [FACT:10000A12]
		EndIf
		If (WW_collected != None && _a.IsInFaction(WW_collected))
			_a.RemoveFromFaction(WW_collected)	 ; "Collected Female" [FACT:10000A05]
		EndIf
	EndIf

	If (Game.GetModByName("OBIS SE.esp") != 255)
		If (OBISFaction != None && _a.IsInFaction(OBISFaction))
			_a.RemoveFromFaction(OBISFaction)	; OBIS faction
			_a.AddItem((Obis_GlowingPearl), 1)
		EndIf
	ElseIf (Game.GetModByName("Obis.esp") != 255)
		If (OBISFaction != None && _a.IsInFaction(OBISFaction))
			_a.RemoveFromFaction(OBISFaction)	; OBIS faction
		EndIf
	EndIf

	_a.RemoveFromFaction(MQ302CouncilFaction)
	_a.RemoveFromFaction(MQAncientHeroFaction)
	_a.RemoveFromFaction(MQSovngardeCombatDialogueFaction)
	_a.RemoveFromFaction(MQ103ImperialSoldierFaction)
	_a.RemoveFromFaction(MQ103SonsOfSkyrimSoldierFaction)
	_a.RemoveFromFaction(MQ202EnemyofPlayerFaction)
	_a.RemoveFromFaction(MQ202ThalmorAgentFaction)
	_a.RemoveFromFaction(ThalmorFaction)
	_a.RemoveFromFaction(BladesFaction)
	_a.RemoveFromFaction(DarkBrotherhoodFaction)

	_a.RemoveFromFaction(GovImperial)
	_a.RemoveFromFaction(GovRuling)
	_a.RemoveFromFaction(GovExiled)
	_a.RemoveFromFaction(CWImperialFaction)
	_a.RemoveFromFaction(CWImperialFactionNPC)
	_a.RemoveFromFaction(CWSonsFaction)
	_a.RemoveFromFaction(CWSonsFactionNPC)
	_a.RemoveFromFaction(DA02GuardFaction)

	_a.RemoveFromFaction(CWDialogueSoldierFaction)
	_a.RemoveFromFaction(CWDialogueSoldierWaitingToAttackFaction)
	_a.RemoveFromFaction(CWDialogueSoldierWaitingToDefendFaction)
	_a.RemoveFromFaction(CWFortFaction)

	_a.RemoveFromFaction(WEPlayerEnemy)
	_a.RemoveFromFaction(WIPlayerEnemyFaction)
	_a.RemoveFromFaction(WIPlayerEnemySpecialCombatFaction)
	_a.RemoveFromFaction(DA14CultistFaction)
	_a.RemoveFromFaction(WIThiefFaction)
	_a.RemoveFromFaction(TGNoPickpocketFaction)

	_a.RemoveFromFaction(RiverwoodSleepingGiantInnFaction)
	_a.RemoveFromFaction(TownRiverwoodFaction)
	_a.RemoveFromFaction(DruadachRedoubtFaction)
	_a.RemoveFromFaction(TownCidhnaMinePrisonerFaction)
	_a.RemoveFromFaction(FavorExcludedFaction)
	_a.RemoveFromFaction(WIAdditem03ExclusionFaction)

	_a.RemoveFromFaction(BanditFaction)
	_a.RemoveFromFaction(MS07BanditSiblings) ;"Broken Oar Bandits" [FACT:00025F95]
	_a.RemoveFromFaction(MS07BanditFaction) ; [FACT:00088EE4]
	_a.RemoveFromFaction(WE06BanditFaction) ; [FACT:0009CAC0]
	_a.RemoveFromFaction(WE19BanditFaction) ; [FACT:0009F811]
	_a.RemoveFromFaction(WE20BanditFaction) ; [FACT:0009F817]
	_a.RemoveFromFaction(dunIcerunnerBanditFaction) ; "Markarth Wizards' Quarters Guards" [FACT:0008E764]
	_a.RemoveFromFaction(dunValtheimKeepBanditFaction) ; Valtheim Keep Bandits [FACT:000AE026]
	_a.RemoveFromFaction(dunRobbersGorgeBanditFaction) ; "Robber's Gorge Bandit Faction" [FACT:000B8CAB]

	_a.RemoveFromFaction(ForswornFaction) ;  "Forsworn Faction" [FACT:00043599]
	_a.RemoveFromFaction(NecromancerFaction)
	_a.RemoveFromFaction(WarlockFaction)
	_a.RemoveFromFaction(dunBlackreachFalmerServantFaction) ;  Falmer Servant Faction
	_a.RemoveFromFaction(dunBluePalaceEnemyFaction)

	_a.RemoveFromFaction(DaedraFaction)
	_a.RemoveFromFaction(CreatureFaction)
	_a.RemoveFromFaction(SprigganFaction)
	_a.RemoveFromFaction(DraugrFaction)
	_a.RemoveFromFaction(SkeletonFaction)
	_a.RemoveFromFaction(TrollFaction)	;"Troll Faction" [FACT:000435A1]
	_a.RemoveFromFaction(DremoraFaction)
	_a.RemoveFromFaction(DwarvenAutomatonFaction)
	_a.RemoveFromFaction(FalmerFaction)	;Falmer Faction [FACT:0002997E]
	If (DLC2RieklingFaction && (DLC2RieklingFaction != None))
		_a.RemoveFromFaction(DLC2RieklingFaction)
	EndIf
	If (DLC2CultistFaction && (DLC2CultistFaction != None))
		_a.RemoveFromFaction(DLC2CultistFaction)
	EndIf

	_a.IgnoreFriendlyHits(true)

	return _a
EndFunction

Actor Function cleanActor(actor _a)
	assign_ex_factions_and_clean(_a)
	_a.IgnoreFriendlyHits(true)
	_a.SetFactionOwner(PlayerFaction)

	if !player
		player = Game.GetPlayer()
	EndIf

	Faction[] slaveFactions = _a.GetFactions(-127, 127)
	int i=0
	while (i<slaveFactions.length)
		int slave_Towards_PlayerFaction = slaveFactions[i].GetReaction(PlayerFaction)
		if slave_Towards_PlayerFaction == 1
			_a.RemoveFromFaction(slaveFactions[i])
		EndIf
		i+=1
	endwhile
	return _a
EndFunction

Actor Function CheckGender(actor slave)
	if (sexlab_gender && ((SexLab.GetGender(slave) == 0) || (SexLab.GetGender(slave) == 2)))
		;Debug.Notification("slave "+slave.getDisplayName()+" Is Male")
		slave.AddToFaction(PAH_gender)
		slave.setFactionRank(PAH_gender, 0)
	ElseIf (sexlab_gender && ((SexLab.GetGender(slave) == 1) || (SexLab.GetGender(slave) == 3)))
		;Debug.Notification("slave "+slave.getDisplayName()+" Is Female")
		slave.AddToFaction(PAH_gender)
		slave.setFactionRank(PAH_gender, 1)
	Else
		;Debug.Notification("slave failed SexLab gender check")
		;Debug.Notification("using skyrim gender check")
		if (slave.GetActorBase().GetSex() == 0)
			;IsMale = (slave.GetActorBase().GetSex() == 0)
			;IsFemale = false
			;Debug.Notification("slave Is skyrim Male")
			slave.AddToFaction(PAH_gender)
			slave.setFactionRank(PAH_gender, 0)
		Else
			;IsFemale = (slave.GetActorBase().GetSex() == 1)
			;IsMale = false
			;Debug.Notification("slave Is skyrim Female")
			slave.AddToFaction(PAH_gender)
			slave.setFactionRank(PAH_gender, 1)
		EndIf
	EndIf
EndFunction

Actor Function CheckPlayerGender(actor Player)
	if (sexlab_gender && ((SexLab.GetGender(player) == 0) || (SexLab.GetGender(player) == 2)))
		;Debug.Notification("player Is SexLab Male")
		;player.RemoveFromFaction(PAH_gender)
		player.AddToFaction(PAH_Player_gender)
		player.setFactionRank(PAH_Player_gender, 0)
	ElseIf (sexlab_gender && ((SexLab.GetGender(player) == 1) || (SexLab.GetGender(player) == 3)))
		;Debug.Notification("player Is SexLab Female")
		;player.RemoveFromFaction(PAH_gender)
		player.AddToFaction(PAH_Player_gender)
		player.setFactionRank(PAH_Player_gender, 1)
	Else
		;Debug.Notification("player failed SexLab gender check")
		;Debug.Notification("using skyrim gender check")
		if (player.GetActorBase().GetSex() == 0)
			;Debug.Notification("player Is skyrim Male")
			;player.RemoveFromFaction(PAH_gender)
			player.AddToFaction(PAH_Player_gender)
			player.setFactionRank(PAH_Player_gender, 0)
		Else
			;Debug.Notification("player Is skyrim Female")
			;player.RemoveFromFaction(PAH_gender)
			player.AddToFaction(PAH_Player_gender)
			player.setFactionRank(PAH_Player_gender, 1)
		EndIf
	EndIf
EndFunction

;ActorBase Property PahLeveledBase

ActorBase function GetValidActorBase(actor akActor)
	ActorBase base = akActor.GetActorBase()
	ActorBase base_leveled = akActor.GetLeveledActorBase()

;	if base_leveled
	if base != base_leveled
		return base_leveled.GetTemplate()
		;if base != base_leveled
		;	base = PahLeveledBase
		;endIf	
	Else
;		return base.GetTemplate()
		return base
	EndIf
endFunction

Function setSLSkills(Actor source, Actor target)
	SexLab.Stats.SetSkill(target, "TimeSpent", SexLab.Stats.GetSkill(source, "TimeSpent"))
	SexLab.Stats.SetSkill(target, "Sexuality", SexLab.Stats.GetSkill(source, "Sexuality"))
	SexLab.Stats.setSkill(target, "Males" , SexLab.Stats.GetSkill(source, "Males"))
	SexLab.Stats.setSkill(target, "Females", SexLab.Stats.GetSkill(source, "Females"))
	SexLab.Stats.setSkill(target, "Creatures", SexLab.Stats.GetSkill(source, "Creatures"))
	SexLab.Stats.setSkill(target, "Masturbation", SexLab.Stats.GetSkill(source, "Masturbation"))
	SexLab.Stats.setSkill(target, "Aggressor", SexLab.Stats.GetSkill(source, "Aggressor"))
	SexLab.Stats.setSkill(target, "Victim", SexLab.Stats.GetSkill(source, "Victim"))
EndFunction

Function switchActors(Actor original, Actor clone)
	If clone.HasSpell(AbPOIFrozenCorpse)
		clone.RemoveSpell(AbPOIFrozenCorpse)
	EndIf
	If CheckNiOverride()
	;	Pah_bodyNodes.transferNode(original, clone)
	EndIf
	If (Game.GetModByName("SlaveTats.esp") != 255)
		If JContainers.isInstalled() && SlaveTats.Version() != ""
			original.enableAI(false)
			int array = JArray.object()
			JValue.retain(array)
			If !SlaveTats.query_applied_tattoos(original, 0, array)
				int index = JArray.count(array)
				debug.trace("[PAHCore] SlavTats: " + index + " entries")
				if index > 0
					while index > 0
						index -= 1
						SlaveTats.add_tattoo(clone, JArray.getObj(array, index), silent = true)
					endWhile
					SlaveTats.synchronize_tattoos(clone, true)
				EndIf
				JValue.release(array)
			EndIf
		EndIf
	EndIf

	clone.setAlpha(0.0)
	clone.MoveTo(original)
	clone.SetPosition(original.GetPositionX(), original.GetPositionY(), original.GetPositionZ())
	
	If original == slaveCandidate.getActorRef()
		slaveCandidate.clear()
	EndIf
	original.SetDontMove(true)
;	original.Disable()
	original.MoveTo(CloneMarker)
;	original.EnableNoWait()
	original.EndDeferredKill()
	original.KillEssential(player)
	original.Kill()
; 	original.DeleteWhenAble()
;	original.RemoveFromGame()
	Debug.SendAnimationEvent(clone, "BleedOutStart")
EndFunction

Function randomizeTraining(Actor _actor)
;Function randomizeTraining(Actor _actor, bool _isReleased)
	PAHSlave slave = GetSlave(_actor)
;	float relPercent = 1.0;
;	If _isReleased
;		relPercent = (Config.ssbanditsReleasedPercentage / 100.0)
;	EndIf

	If issexSlaves
		slave.TrainAnger(Utility.RandomFloat(0.0, 30.0))
		slave.TrainRespect(Utility.RandomFloat(0.0, 30.0))
		slave.TrainOral(Utility.RandomFloat(5.0, 30.0))
		slave.TrainAnal(Utility.RandomFloat(5.0, 30.0))
		slave.TrainVaginal(Utility.RandomFloat(5.0, 30.0))
		slave.TrainSubmission((slave.combat_training + slave.anger_training + slave.respect_training + slave.sex_training)/6)

;	ElseIf issexSlavesReleased
;		slave.TrainAnger(Utility.RandomFloat(Config.ssbanditsMinAnger, Config.ssbanditsMaxAnger) * relPercent)
;		slave.TrainPose(Utility.RandomFloat(Config.ssbanditsMinPose, Config.ssbanditsMaxPose) * relPercent)
;		slave.TrainRespect(Utility.RandomFloat(Config.ssbanditsMinRespect, Config.ssbanditsMaxRespect) * relPercent)
;		slave.TrainOral(Utility.RandomFloat(Config.ssbanditsMinOral, Config.ssbanditsMaxOral) * relPercent)
;		slave.TrainAnal(Utility.RandomFloat(Config.ssbanditsMinAnal, Config.ssbanditsMaxAnal) * relPercent)
;		slave.TrainVaginal(Utility.RandomFloat(Config.ssbanditsMinVaginal, Config.ssbanditsMaxVaginal) * relPercent)
;		slave.TrainFear(Utility.RandomFloat(Config.ssbanditsMinFear, Config.ssbanditsMaxFear) * relPercent)
;		slave.TrainCombat(Utility.RandomFloat(Config.ssbanditsMinCombat, Config.ssbanditsMaxCombat) * relPercent)
;		float percent = (Config.ssbanditsSubmissionPercentage / 100.0)
;		slave.TrainSubmission((slave.combat_training + slave.pose_training + slave.anger_training + slave.fear_training + slave.respect_training + slave.sex_training) * percent)

	EndIf
EndFunction

bool Function getFactions(Actor _actor)
	If (sexSlavesReleased != None && _actor.IsInFaction(sexSlavesReleased))
		issexSlavesReleased = true
	EndIF
	If (sexSlaves != None && _actor.IsInFaction(sexSlaves) && !_actor.IsInFaction(sexSlavesReleased))
		issexSlaves = true
	EndIf
	return (issexSlaves || issexSlavesReleased)
EndFunction

Function resetFactions()
	considerFactions = false
	issexSlaves = false
	issexSlavesReleased = false
EndFunction

Bool Function actor_base_is_similar(ActorBase actor_base_1, ActorBase actor_base_2)
    If (actor_base_1.GetSex() != actor_base_2.GetSex())
        return false
    ElseIf (actor_base_1.GetRace() != actor_base_2.GetRace())
        return false
    ElseIf (actor_base_1.GetFacePreset(0) != actor_base_2.GetFacePreset(0))
        return false
    ElseIf (actor_base_1.GetFacePreset(2) != actor_base_2.GetFacePreset(2))
        return false
    ElseIf (actor_base_1.GetFacePreset(3) != actor_base_2.GetFacePreset(3))
        return false
    EndIf

    return true
EndFunction

Function assign_ex_factions_and_clean(Actor slave_actor)
	Bool ex_ArenaFaction = false
	Bool ex_BanditFaction = false
	Bool ex_DarkBrotherhoodFaction = false
	Bool ex_GuardDialogueFaction = false
	Bool ex_HunterFaction = false
	Bool ex_CWImperialFaction = false
	Bool ex_NecromancerFaction = false
	Bool ex_SilverHandFaction = false
	Bool ex_CWSonsFaction = false
	Bool ex_ThalmorFaction = false
	Bool ex_ThievesGuildFaction = false
	Bool ex_VampireFaction = false
	Bool ex_VigilantOfStendarrFaction = false
	Bool ex_WarlockFaction = false
	Bool ex_WerewolfFaction = false
	Bool ex_MerchantFaction = false

	if slave_actor.IsInFaction(NpcEval.JobMerchantFaction)
		ex_MerchantFaction = true
	endif
	if slave_actor.IsInFaction(ArenaFaction)
		ex_ArenaFaction = true
	endif
	if slave_actor.IsInFaction(BanditFaction)
		ex_BanditFaction = true
	endif
	if slave_actor.IsInFaction(DarkBrotherhoodFaction)
		ex_DarkBrotherhoodFaction = true
	endif
	if slave_actor.IsInFaction(GuardDialogueFaction)
		ex_GuardDialogueFaction = true
	endif
	if slave_actor.IsInFaction(NpcEval.HunterFaction)
		ex_HunterFaction = true
	endif
	if (slave_actor.IsInFaction(CWImperialFaction) || slave_actor.IsInFaction(CWImperialFactionNPC))
		ex_CWImperialFaction = true
	endif
	if slave_actor.IsInFaction(NecromancerFaction)
		ex_NecromancerFaction = true
	endif
	if slave_actor.IsInFaction(SilverHandFaction)
		ex_SilverHandFaction = true
	endif
	if (slave_actor.IsInFaction(CWSonsFaction) || slave_actor.IsInFaction(CWSonsFactionNPC))
		ex_CWSonsFaction = true
	endif
	if slave_actor.IsInFaction(ThalmorFaction)
		ex_ThalmorFaction = true
	endif
	if slave_actor.IsInFaction(ThievesGuildFaction)
		ex_ThievesGuildFaction = true
	endif
	if slave_actor.IsInFaction(VampireFaction)
		ex_VampireFaction = true
	endif
	if slave_actor.IsInFaction(VigilantOfStendarrFaction)
		ex_VigilantOfStendarrFaction = true
	endif
	if slave_actor.IsInFaction(WarlockFaction)
		ex_WarlockFaction = true
	endif
	if slave_actor.IsInFaction(WerewolfFaction)
		ex_WerewolfFaction = true
	endif

	PrecleanActor(slave_actor)
	slave_actor.RemoveFromAllFactions()

	if ex_MerchantFaction
		slave_actor.AddToFaction(PAHExMerchantFaction)
		slave_actor.AddToFaction(NpcEval.JobMerchantFaction)
	endif
	if ex_ArenaFaction
		slave_actor.AddToFaction(PAHExArenaFaction)
	endif
	if ex_BanditFaction
		slave_actor.AddToFaction(PAHExBanditFaction)
	endif
	if ex_DarkBrotherhoodFaction
		slave_actor.AddToFaction(PAHExDarkBrotherhoodFaction)
	endif
	if ex_GuardDialogueFaction
		slave_actor.AddToFaction(PAHExGuardFaction)
	endif
	if ex_HunterFaction
		slave_actor.AddToFaction(PAHExHunterFaction)
	endif
	if ex_CWImperialFaction
		slave_actor.AddToFaction(PAHExImperialFaction)
	endif
	if ex_NecromancerFaction
		slave_actor.AddToFaction(PAHExNecromancerFaction)
	endif
	if ex_SilverHandFaction
		slave_actor.AddToFaction(PAHExSilverHandFaction)
	endif
	if ex_CWSonsFaction
		slave_actor.AddToFaction(PAHExSonsFaction)
	endif
	if ex_ThalmorFaction
		slave_actor.AddToFaction(PAHExThalmorFaction)
	endif
	if ex_ThievesGuildFaction
		slave_actor.AddToFaction(PAHExThievesFaction)
	endif
	if ex_VampireFaction
		slave_actor.AddToFaction(PAHExVampireFaction)
	endif
	if ex_VigilantOfStendarrFaction
		slave_actor.AddToFaction(PAHExVigilantOfStendarrFaction)
	endif
	if ex_WarlockFaction
		slave_actor.AddToFaction(PAHExWarlockFaction)
	endif
	if ex_WerewolfFaction
		slave_actor.AddToFaction(PAHExWerewolfFaction)
	endif

EndFunction

;### Leashing
Bool __clearing_leash_point = false
Bool Property clearing_leash_point
	Bool Function Get()
		return __clearing_leash_point
	EndFunction
	Function Set(Bool value)
		__clearing_leash_point = value
		clearing_leash_point_timer = 0
	EndFunction
EndProperty

Int clearing_leash_point_timer = 0
Function FalsifyClearingLeastPointOnTick()
	clearing_leash_point_timer += 1
	If clearing_leash_point_timer == 2
		clearing_leash_point = false
	EndIf
EndFunction

Bool Function LeashPointInUse(ObjectReference leash_point)
	int i = 0
	While (i < slave_aliases.length)
		If (slave_aliases[i] as PAHActorAlias).leash_point == leash_point
			return true
		EndIf
		i += 1
	EndWhile
	return false
EndFunction

Function ClearLeashPoint(ObjectReference leash_point)
	int i = 0
	While (i < slave_aliases.length)
		If (slave_aliases[i] as PAHActorAlias).leash_point == leash_point
			(slave_aliases[i] as PAHActorAlias).leash_point = None
		EndIf
		i += 1
	EndWhile
EndFunction

;### Utility
FormList Property wouldFuckList Auto
FormList Property wouldNotFuckList Auto

Bool Function IsTogetherWith(ObjectReference subject_ref, ObjectReference object_ref, int distance = 10000)
	If object_ref.IsInInterior()
		return subject_ref.GetParentCell() == object_ref.GetParentCell()
	Else
		return subject_ref.GetWorldSpace() == object_ref.GetWorldSpace() && subject_ref.GetDistance(object_ref) < distance
	EndIf
EndFunction

Bool Function isCaster(PAHSlave slave_actor)
	Actor base = slave_actor.getActorRef()
	float fighterSkill = getMax(base.GetActorValue("OneHanded"), base.GetActorValue("TwoHanded"))
	float magicSkill = getMax(base.GetActorValue("Conjuration"), base.GetActorValue("Destruction"))

	return magicSkill > fighterSkill
EndFunction

float Function getMax(float value_1, float value_2)
	If value_1 > value_2
		return value_1
	Else
		return value_2
	EndIf
EndFunction

float Function getMin(float value_1, float value_2)
	If value_1 < value_2
		return value_1
	Else
		return value_2
	EndIf
EndFunction

bool Function IsEvenInt(int value)
	float half = value / 2
	half = half - (half as Int)
	return half == 0.0
EndFunction

Bool Function IsFollower(Actor Target)
	Return (Target.isPlayerTeammate() || Target.IsInFaction(currentFollowerFaction) || Target.IsInFaction(currentHireling))
EndFunction

int _slaverRank = 0
int Property slaverRank
	int Function Get()
		return _slaverRank
	EndFunction
EndProperty

int _slaverRankTicks = 0
Function tickSlaverRank()
	_slaverRankTicks += 1
EndFunction

int _slaverSetting = 0
int slaverSettingCount = 4
int Property slaverSetting
	int Function Get()
		return _slaverSetting
	EndFunction
	Function Set(int value)
		If value >= 0
			If value < slaverSettingCount
				_slaverSetting = value
			ElseIf value == slaverSettingCount
				_slaverSetting = 0
			EndIf
		EndIf
	EndFunction
EndProperty

bool Property enableDebug
	bool Function Get()
		return Config.debugToggle
	endFunction
EndProperty

Function copySexStats(Actor target, Actor source)
	SexLab.ActorAdjustBy(target, "Sexuality", (SexLab.GetActorStatInt(source, "Sexuality") - SexLab.GetActorStatInt(target, "Sexuality")))
	SexLab.ActorAdjustBy(target, "Foreplay", (SexLab.GetActorStatInt(source, "Foreplay") - SexLab.GetActorStatInt(source, "Foreplay")))
	SexLab.ActorAdjustBy(target, "Vaginal", (SexLab.GetActorStatInt(source, "Vaginal") - SexLab.GetActorStatInt(source, "Vaginal")))
	target.setFactionRank(PAHTrainVaginal, SexLab.GetActorStatInt(source, "Vaginal"))

	SexLab.ActorAdjustBy(target, "Anal", (SexLab.GetActorStatInt(source, "Anal") - SexLab.GetActorStatInt(target, "Anal")))
	target.setFactionRank(PAHTrainAnal, SexLab.GetActorStatInt(source, "Anal"))
	
	SexLab.ActorAdjustBy(target, "Oral", (SexLab.GetActorStatInt(source, "Oral") - SexLab.GetActorStatInt(target, "Oral")))
	target.setFactionRank(PAHTrainOral, SexLab.GetActorStatInt(source, "Oral"))

	SexLab.ActorAdjustBy(target, "Pure", (SexLab.GetActorStatInt(source, "Pure") - SexLab.GetActorStatInt(target, "Pure")))
	SexLab.ActorAdjustBy(target, "Lewd", (SexLab.GetActorStatInt(source, "Lewd") - SexLab.GetActorStatInt(target, "Lewd")))
EndFunction

EncounterZone Function getEncounterZone(int _level)
	If _level < 10
		return PAH0to9Zone
	ElseIf _level < 20
		return PAH10to19Zone
	ElseIf _level < 30
		return PAH20to29Zone
	ElseIf _level < 40
		return PAH30to39Zone
	ElseIf _level < 50
		return PAH40to49Zone
	ElseIf _level < 60
		return PAH50to59Zone
	ElseIf _level < 70
		return PAH60to69Zone
	ElseIf _level < 80
		return PAH70to79Zone
	ElseIf _level < 90
		return PAH80to89Zone
	Else
		return PAH200PlusZone
	EndIf
EndFunction

int[] Function GetIntArrayLength(Int dl)
	int[] newArray
;	If dl > 64
;		newArray = new int[128]
;	ElseIf dl <= 32
	If dl <= 32
		If dl <= 16
			If dl <= 8
				If dl <= 4
					If dl <= 2
						If dl == 1
							newArray = new int[1]
						ElseIf dl == 2
							newArray = new int[2]
						Else
							newArray = None
						EndIf
					Else
						If dl == 3
							newArray = new int[3]
						Else
							newArray = new int[4]
						EndIf
					EndIf
				Else
					If dl <= 6
						If dl == 5
							newArray = new int[5]
						Else
							newArray = new int[6]
						EndIf
					Else
						If dl == 7
							newArray = new int[7]
						Else
							newArray = new int[8]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 12
					If dl <= 10
						If dl == 9
							newArray = new int[9]
						Else
							newArray = new int[10]
						EndIf
					Else
						If dl == 11
							newArray = new int[11]
						Else
							newArray = new int[12]
						EndIf
					EndIf
				Else
					If dl <= 14
						If dl == 13
							newArray = new int[13]
						Else
							newArray = new int[14]
						EndIf
					Else
						If dl == 15
							newArray = new int[15]
						Else
							newArray = new int[16]
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			If dl <= 24
				If dl <= 20
					If dl <= 18
						If dl == 17
							newArray = new int[17]
						Else
							newArray = new int[18]
						EndIf
					Else
						If dl == 19
							newArray = new int[19]
						Else
							newArray = new int[20]
						EndIf
					EndIf
				Else
					If dl <= 22
						If dl == 21
							newArray = new int[21]
						Else
							newArray = new int[22]
						EndIf
					Else
						If dl == 23
							newArray = new int[23]
						Else
							newArray = new int[24]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 28
					If dl <= 26
						If dl == 25
							newArray = new int[25]
						Else
							newArray = new int[26]
						EndIf
					Else
						If dl == 27
							newArray = new int[27]
						Else
							newArray = new int[28]
						EndIf
					EndIf
				Else
					If dl <= 30
						If dl == 29
							newArray = new int[29]
						Else
							newArray = new int[30]
						EndIf
					Else
						If dl == 31
							newArray = new int[31]
						Else
							newArray = new int[32]
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
;	Else
	ElseIf dl <= 64
		If dl <= 48
			If dl <= 40
				If dl <= 36
					If dl <= 34
						If dl == 33
							newArray = new int[33]
						Else
							newArray = new int[34]
						EndIf
					Else
						If dl == 35
							newArray = new int[35]
						Else
							newArray = new int[36]
						EndIf
					EndIf
				Else
					If dl <= 38
						If dl == 37
							newArray = new int[37]
						Else
							newArray = new int[38]
						EndIf
					Else
						If dl == 39
							newArray = new int[39]
						Else
							newArray = new int[40]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 44
					If dl <= 42
						If dl == 41
							newArray = new int[41]
						Else
							newArray = new int[42]
						EndIf
					Else
						If dl == 43
							newArray = new int[43]
						Else
							newArray = new int[44]
						EndIf
					EndIf
				Else
					If dl <= 46
						If dl == 45
							newArray = new int[45]
						Else
							newArray = new int[46]
						EndIf
					Else
						If dl == 47
							newArray = new int[47]
						Else
							newArray = new int[48]
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			If dl <= 56
				If dl <= 52
					If dl <= 50
						If dl == 49
							newArray = new int[49]
						Else
							newArray = new int[50]
						EndIf
					Else
						If dl == 51
							newArray = new int[51]
						Else
							newArray = new int[52]
						EndIf
					EndIf
				Else
					If dl <= 54
						If dl == 53
							newArray = new int[53]
						Else
							newArray = new int[54]
						EndIf
					Else
						If dl == 55
							newArray = new int[55]
						Else
							newArray = new int[56]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 60
					If dl <= 58
						If dl == 57
							newArray = new int[57]
						Else
							newArray = new int[58]
						EndIf
					Else
						If dl == 59
							newArray = new int[59]
						Else
							newArray = new int[60]
						EndIf
					EndIf
				Else
					If dl <= 62
						If dl == 61
							newArray = new int[61]
						Else
							newArray = new int[62]
						EndIf
					Else
						If dl == 63
							newArray = new int[63]
						Else
							newArray = new int[64]
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Else
		If dl <= 96
			If dl <= 80
				If dl <= 72
					If dl <= 68
						If dl <= 66
							If dl == 65
								newArray = new int[65]
							Else
								newArray = new int[66]
							EndIf
						Else
							If dl == 67
								newArray = new int[67]
							Else
								newArray = new int[68]
							EndIf
						EndIf
					Else
						If dl <= 70
							If dl == 69
								newArray = new int[69]
							Else
								newArray = new int[70]
							EndIf
						Else
							If dl == 71
								newArray = new int[71]
							Else
								newArray = new int[72]
							EndIf
						EndIf
					EndIf
				Else
					If dl <= 76
						If dl <= 74
							If dl == 73
								newArray = new int[73]
							Else
								newArray = new int[74]
							EndIf
						Else
							If dl == 75
								newArray = new int[75]
							Else
								newArray = new int[76]
							EndIf
						EndIf
					Else
						If dl <= 78
							If dl == 77
								newArray = new int[77]
							Else
								newArray = new int[78]
							EndIf
						Else
							If dl == 79
								newArray = new int[79]
							Else
								newArray = new int[80]
							EndIf
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 88
					If dl <= 84
						If dl <= 82
							If dl == 81
								newArray = new int[81]
							Else
								newArray = new int[82]
							EndIf
						Else
							If dl == 83
								newArray = new int[83]
							Else
								newArray = new int[84]
							EndIf
						EndIf
					Else
						If dl <= 86
							If dl == 85
								newArray = new int[85]
							Else
								newArray = new int[86]
							EndIf
						Else
							If dl == 87
								newArray = new int[87]
							Else
								newArray = new int[88]
							EndIf
						EndIf
					EndIf
				Else
					If dl <= 92
						If dl <= 90
							If dl == 89
								newArray = new int[89]
							Else
								newArray = new int[90]
							EndIf
						Else
							If dl == 91
								newArray = new int[91]
							Else
								newArray = new int[92]
							EndIf
						EndIf
					Else
						If dl <= 94
							If dl == 93
								newArray = new int[93]
							Else
								newArray = new int[94]
							EndIf
						Else
							If dl == 95
								newArray = new int[95]
							Else
								newArray = new int[96]
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		ElseIf dl <= 128
			If dl <= 112
				If dl <= 104
					If dl <= 100
						If dl <= 98
							If dl == 97
								newArray = new int[97]
							Else
								newArray = new int[98]
							EndIf
						Else
							If dl == 35
								newArray = new int[99]
							Else
								newArray = new int[100]
							EndIf
						EndIf
					Else
						If dl <= 102
							If dl == 101
								newArray = new int[101]
							Else
								newArray = new int[102]
							EndIf
						Else
							If dl == 103
								newArray = new int[103]
							Else
								newArray = new int[104]
							EndIf
						EndIf
					EndIf
				Else
					If dl <= 108
						If dl <= 106
							If dl == 105
								newArray = new int[105]
							Else
								newArray = new int[106]
							EndIf
						Else
							If dl == 107
								newArray = new int[107]
							Else
								newArray = new int[108]
							EndIf
						EndIf
					Else
						If dl <= 110
							If dl == 109
								newArray = new int[109]
							Else
								newArray = new int[110]
							EndIf
						Else
							If dl == 111
								newArray = new int[111]
							Else
								newArray = new int[112]
							EndIf
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 120
					If dl <= 116
						If dl <= 114
							If dl == 113
								newArray = new int[113]
							Else
								newArray = new int[114]
							EndIf
						Else
							If dl == 115
								newArray = new int[115]
							Else
								newArray = new int[116]
							EndIf
						EndIf
					Else
						If dl <= 118
							If dl == 117
								newArray = new int[117]
							Else
								newArray = new int[118]
							EndIf
						Else
							If dl == 119
								newArray = new int[119]
							Else
								newArray = new int[120]
							EndIf
						EndIf
					EndIf
				Else
					If dl <= 124
						If dl <= 122
							If dl == 121
								newArray = new int[121]
							Else
								newArray = new int[122]
							EndIf
						Else
							If dl == 123
								newArray = new int[123]
							Else
								newArray = new int[124]
							EndIf
						EndIf
					Else
						If dl <= 126
							If dl == 125
								newArray = new int[125]
							Else
								newArray = new int[126]
							EndIf
						Else
							If dl == 127
								newArray = new int[127]
							Else
								newArray = new int[128]
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf

	EndIf
	return newArray
EndFunction

String[] Function GetStringArrayLength(Int dl)
	String[] newArray
;	If dl > 64
;		newArray = new String[128]
;	ElseIf dl <= 32
	If dl <= 32
		If dl <= 16
			If dl <= 8
				If dl <= 4
					If dl <= 2
						If dl == 1
							newArray = new String[1]
						ElseIf dl == 2
							newArray = new String[2]
						Else
							newArray = None
						EndIf
					Else
						If dl == 3
							newArray = new String[3]
						Else
							newArray = new String[4]
						EndIf
					EndIf
				Else
					If dl <= 6
						If dl == 5
							newArray = new String[5]
						Else
							newArray = new String[6]
						EndIf
					Else
						If dl == 7
							newArray = new String[7]
						Else
							newArray = new String[8]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 12
					If dl <= 10
						If dl == 9
							newArray = new String[9]
						Else
							newArray = new String[10]
						EndIf
					Else
						If dl == 11
							newArray = new String[11]
						Else
							newArray = new String[12]
						EndIf
					EndIf
				Else
					If dl <= 14
						If dl == 13
							newArray = new String[13]
						Else
							newArray = new String[14]
						EndIf
					Else
						If dl == 15
							newArray = new String[15]
						Else
							newArray = new String[16]
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			If dl <= 24
				If dl <= 20
					If dl <= 18
						If dl == 17
							newArray = new String[17]
						Else
							newArray = new String[18]
						EndIf
					Else
						If dl == 19
							newArray = new String[19]
						Else
							newArray = new String[20]
						EndIf
					EndIf
				Else
					If dl <= 22
						If dl == 21
							newArray = new String[21]
						Else
							newArray = new String[22]
						EndIf
					Else
						If dl == 23
							newArray = new String[23]
						Else
							newArray = new String[24]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 28
					If dl <= 26
						If dl == 25
							newArray = new String[25]
						Else
							newArray = new String[26]
						EndIf
					Else
						If dl == 27
							newArray = new String[27]
						Else
							newArray = new String[28]
						EndIf
					EndIf
				Else
					If dl <= 30
						If dl == 29
							newArray = new String[29]
						Else
							newArray = new String[30]
						EndIf
					Else
						If dl == 31
							newArray = new String[31]
						Else
							newArray = new String[32]
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
;	Else
	ElseIf dl <= 64
		If dl <= 48
			If dl <= 40
				If dl <= 36
					If dl <= 34
						If dl == 33
							newArray = new String[33]
						Else
							newArray = new String[34]
						EndIf
					Else
						If dl == 35
							newArray = new String[35]
						Else
							newArray = new String[36]
						EndIf
					EndIf
				Else
					If dl <= 38
						If dl == 37
							newArray = new String[37]
						Else
							newArray = new String[38]
						EndIf
					Else
						If dl == 39
							newArray = new String[39]
						Else
							newArray = new String[40]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 44
					If dl <= 42
						If dl == 41
							newArray = new String[41]
						Else
							newArray = new String[42]
						EndIf
					Else
						If dl == 43
							newArray = new String[43]
						Else
							newArray = new String[44]
						EndIf
					EndIf
				Else
					If dl <= 46
						If dl == 45
							newArray = new String[45]
						Else
							newArray = new String[46]
						EndIf
					Else
						If dl == 47
							newArray = new String[47]
						Else
							newArray = new String[48]
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			If dl <= 56
				If dl <= 52
					If dl <= 50
						If dl == 49
							newArray = new String[49]
						Else
							newArray = new String[50]
						EndIf
					Else
						If dl == 51
							newArray = new String[51]
						Else
							newArray = new String[52]
						EndIf
					EndIf
				Else
					If dl <= 54
						If dl == 53
							newArray = new String[53]
						Else
							newArray = new String[54]
						EndIf
					Else
						If dl == 55
							newArray = new String[55]
						Else
							newArray = new String[56]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 60
					If dl <= 58
						If dl == 57
							newArray = new String[57]
						Else
							newArray = new String[58]
						EndIf
					Else
						If dl == 59
							newArray = new String[59]
						Else
							newArray = new String[60]
						EndIf
					EndIf
				Else
					If dl <= 62
						If dl == 61
							newArray = new String[61]
						Else
							newArray = new String[62]
						EndIf
					Else
						If dl == 63
							newArray = new String[63]
						Else
							newArray = new String[64]
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Else
		If dl <= 96
			If dl <= 80
				If dl <= 72
					If dl <= 68
						If dl <= 66
							If dl == 65
								newArray = new String[65]
							Else
								newArray = new String[66]
							EndIf
						Else
							If dl == 67
								newArray = new String[67]
							Else
								newArray = new String[68]
							EndIf
						EndIf
					Else
						If dl <= 70
							If dl == 69
								newArray = new String[69]
							Else
								newArray = new String[70]
							EndIf
						Else
							If dl == 71
								newArray = new String[71]
							Else
								newArray = new String[72]
							EndIf
						EndIf
					EndIf
				Else
					If dl <= 76
						If dl <= 74
							If dl == 73
								newArray = new String[73]
							Else
								newArray = new String[74]
							EndIf
						Else
							If dl == 75
								newArray = new String[75]
							Else
								newArray = new String[76]
							EndIf
						EndIf
					Else
						If dl <= 78
							If dl == 77
								newArray = new String[77]
							Else
								newArray = new String[78]
							EndIf
						Else
							If dl == 79
								newArray = new String[79]
							Else
								newArray = new String[80]
							EndIf
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 88
					If dl <= 84
						If dl <= 82
							If dl == 81
								newArray = new String[81]
							Else
								newArray = new String[82]
							EndIf
						Else
							If dl == 83
								newArray = new String[83]
							Else
								newArray = new String[84]
							EndIf
						EndIf
					Else
						If dl <= 86
							If dl == 85
								newArray = new String[85]
							Else
								newArray = new String[86]
							EndIf
						Else
							If dl == 87
								newArray = new String[87]
							Else
								newArray = new String[88]
							EndIf
						EndIf
					EndIf
				Else
					If dl <= 92
						If dl <= 90
							If dl == 89
								newArray = new String[89]
							Else
								newArray = new String[90]
							EndIf
						Else
							If dl == 91
								newArray = new String[91]
							Else
								newArray = new String[92]
							EndIf
						EndIf
					Else
						If dl <= 94
							If dl == 93
								newArray = new String[93]
							Else
								newArray = new String[94]
							EndIf
						Else
							If dl == 95
								newArray = new String[95]
							Else
								newArray = new String[96]
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		ElseIf dl <= 128
			If dl <= 112
				If dl <= 104
					If dl <= 100
						If dl <= 98
							If dl == 97
								newArray = new String[97]
							Else
								newArray = new String[98]
							EndIf
						Else
							If dl == 35
								newArray = new String[99]
							Else
								newArray = new String[100]
							EndIf
						EndIf
					Else
						If dl <= 102
							If dl == 101
								newArray = new String[101]
							Else
								newArray = new String[102]
							EndIf
						Else
							If dl == 103
								newArray = new String[103]
							Else
								newArray = new String[104]
							EndIf
						EndIf
					EndIf
				Else
					If dl <= 108
						If dl <= 106
							If dl == 105
								newArray = new String[105]
							Else
								newArray = new String[106]
							EndIf
						Else
							If dl == 107
								newArray = new String[107]
							Else
								newArray = new String[108]
							EndIf
						EndIf
					Else
						If dl <= 110
							If dl == 109
								newArray = new String[109]
							Else
								newArray = new String[110]
							EndIf
						Else
							If dl == 111
								newArray = new String[111]
							Else
								newArray = new String[112]
							EndIf
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 120
					If dl <= 116
						If dl <= 114
							If dl == 113
								newArray = new String[113]
							Else
								newArray = new String[114]
							EndIf
						Else
							If dl == 115
								newArray = new String[115]
							Else
								newArray = new String[116]
							EndIf
						EndIf
					Else
						If dl <= 118
							If dl == 117
								newArray = new String[117]
							Else
								newArray = new String[118]
							EndIf
						Else
							If dl == 119
								newArray = new String[119]
							Else
								newArray = new String[120]
							EndIf
						EndIf
					EndIf
				Else
					If dl <= 124
						If dl <= 122
							If dl == 121
								newArray = new String[121]
							Else
								newArray = new String[122]
							EndIf
						Else
							If dl == 123
								newArray = new String[123]
							Else
								newArray = new String[124]
							EndIf
						EndIf
					Else
						If dl <= 126
							If dl == 125
								newArray = new String[125]
							Else
								newArray = new String[126]
							EndIf
						Else
							If dl == 127
								newArray = new String[127]
							Else
								newArray = new String[128]
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf

	EndIf
	return newArray
EndFunction

PAHSlave[] Function GetSlaveArrayLength(Int dl)
	;Debug.Trace("PAHCore: GetSlaveArrayLength dl="+dl)
	PAHSlave[] newArray
	;Debug.Trace("PAHCore: GetSlaveArrayLength newArray="+newArray)
;	If dl > 64
;		newArray = new PAHSlave[128]
;	ElseIf dl <= 32
	If dl <= 32
		If dl <= 16
			If dl <= 8
				If dl <= 4
					If dl <= 2
						If dl == 1
							newArray = new PAHSlave[1]
						ElseIf dl == 2
							newArray = new PAHSlave[2]
						Else
							newArray = None
						EndIf
					Else
						If dl == 3
							newArray = new PAHSlave[3]
						Else
							newArray = new PAHSlave[4]
						EndIf
					EndIf
				Else
					If dl <= 6
						If dl == 5
							newArray = new PAHSlave[5]
						Else
							newArray = new PAHSlave[6]
						EndIf
					Else
						If dl == 7
							newArray = new PAHSlave[7]
						Else
							newArray = new PAHSlave[8]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 12
					If dl <= 10
						If dl == 9
							newArray = new PAHSlave[9]
						Else
							newArray = new PAHSlave[10]
						EndIf
					Else
						If dl == 11
							newArray = new PAHSlave[11]
						Else
							newArray = new PAHSlave[12]
						EndIf
					EndIf
				Else
					If dl <= 14
						If dl == 13
							newArray = new PAHSlave[13]
						Else
							newArray = new PAHSlave[14]
						EndIf
					Else
						If dl == 15
							newArray = new PAHSlave[15]
						Else
							newArray = new PAHSlave[16]
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			If dl <= 24
				If dl <= 20
					If dl <= 18
						If dl == 17
							newArray = new PAHSlave[17]
						Else
							newArray = new PAHSlave[18]
						EndIf
					Else
						If dl == 19
							newArray = new PAHSlave[19]
						Else
							newArray = new PAHSlave[20]
						EndIf
					EndIf
				Else
					If dl <= 22
						If dl == 21
							newArray = new PAHSlave[21]
						Else
							newArray = new PAHSlave[22]
						EndIf
					Else
						If dl == 23
							newArray = new PAHSlave[23]
						Else
							newArray = new PAHSlave[24]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 28
					If dl <= 26
						If dl == 25
							newArray = new PAHSlave[25]
						Else
							newArray = new PAHSlave[26]
						EndIf
					Else
						If dl == 27
							newArray = new PAHSlave[27]
						Else
							newArray = new PAHSlave[28]
						EndIf
					EndIf
				Else
					If dl <= 30
						If dl == 29
							newArray = new PAHSlave[29]
						Else
							newArray = new PAHSlave[30]
						EndIf
					Else
						If dl == 31
							newArray = new PAHSlave[31]
						Else
							newArray = new PAHSlave[32]
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
;	Else
	ElseIf dl <= 64
		If dl <= 48
			If dl <= 40
				If dl <= 36
					If dl <= 34
						If dl == 33
							newArray = new PAHSlave[33]
						Else
							newArray = new PAHSlave[34]
						EndIf
					Else
						If dl == 35
							newArray = new PAHSlave[35]
						Else
							newArray = new PAHSlave[36]
						EndIf
					EndIf
				Else
					If dl <= 38
						If dl == 37
							newArray = new PAHSlave[37]
						Else
							newArray = new PAHSlave[38]
						EndIf
					Else
						If dl == 39
							newArray = new PAHSlave[39]
						Else
							newArray = new PAHSlave[40]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 44
					If dl <= 42
						If dl == 41
							newArray = new PAHSlave[41]
						Else
							newArray = new PAHSlave[42]
						EndIf
					Else
						If dl == 43
							newArray = new PAHSlave[43]
						Else
							newArray = new PAHSlave[44]
						EndIf
					EndIf
				Else
					If dl <= 46
						If dl == 45
							newArray = new PAHSlave[45]
						Else
							newArray = new PAHSlave[46]
						EndIf
					Else
						If dl == 47
							newArray = new PAHSlave[47]
						Else
							newArray = new PAHSlave[48]
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			If dl <= 56
				If dl <= 52
					If dl <= 50
						If dl == 49
							newArray = new PAHSlave[49]
						Else
							newArray = new PAHSlave[50]
						EndIf
					Else
						If dl == 51
							newArray = new PAHSlave[51]
						Else
							newArray = new PAHSlave[52]
						EndIf
					EndIf
				Else
					If dl <= 54
						If dl == 53
							newArray = new PAHSlave[53]
						Else
							newArray = new PAHSlave[54]
						EndIf
					Else
						If dl == 55
							newArray = new PAHSlave[55]
						Else
							newArray = new PAHSlave[56]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 60
					If dl <= 58
						If dl == 57
							newArray = new PAHSlave[57]
						Else
							newArray = new PAHSlave[58]
						EndIf
					Else
						If dl == 59
							newArray = new PAHSlave[59]
						Else
							newArray = new PAHSlave[60]
						EndIf
					EndIf
				Else
					If dl <= 62
						If dl == 61
							newArray = new PAHSlave[61]
						Else
							newArray = new PAHSlave[62]
						EndIf
					Else
						If dl == 63
							newArray = new PAHSlave[63]
						Else
							newArray = new PAHSlave[64]
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	ElseIf dl <= 96
		If dl <= 80
			If dl <= 72
				If dl <= 68
					If dl <= 66
						If dl == 65
							newArray = new PAHSlave[65]
						Else
							newArray = new PAHSlave[66]
						EndIf
					Else
						If dl == 67
							newArray = new PAHSlave[67]
						Else
							newArray = new PAHSlave[68]
						EndIf
					EndIf
				Else
					If dl <= 70
						If dl == 69
							newArray = new PAHSlave[69]
						Else
							newArray = new PAHSlave[70]
						EndIf
					Else
						If dl == 71
							newArray = new PAHSlave[71]
						Else
							newArray = new PAHSlave[72]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 76
					If dl <= 74
						If dl == 73
							newArray = new PAHSlave[73]
						Else
							newArray = new PAHSlave[74]
						EndIf
					Else
						If dl == 75
							newArray = new PAHSlave[75]
						Else
							newArray = new PAHSlave[76]
						EndIf
					EndIf
				Else
					If dl <= 78
						If dl == 77
							newArray = new PAHSlave[77]
						Else
							newArray = new PAHSlave[78]
						EndIf
					Else
						If dl == 79
							newArray = new PAHSlave[79]
						Else
							newArray = new PAHSlave[80]
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			If dl <= 88
				If dl <= 84
					If dl <= 82
						If dl == 81
							newArray = new PAHSlave[81]
						Else
							newArray = new PAHSlave[82]
						EndIf
					Else
						If dl == 83
							newArray = new PAHSlave[83]
						Else
							newArray = new PAHSlave[84]
						EndIf
					EndIf
				Else
					If dl <= 86
						If dl == 85
							newArray = new PAHSlave[85]
						Else
							newArray = new PAHSlave[86]
						EndIf
					Else
						If dl == 87
							newArray = new PAHSlave[87]
						Else
							newArray = new PAHSlave[88]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 92
					If dl <= 90
						If dl == 89
							newArray = new PAHSlave[89]
						Else
							newArray = new PAHSlave[90]
						EndIf
					Else
						If dl == 91
							newArray = new PAHSlave[91]
						Else
							newArray = new PAHSlave[92]
						EndIf
					EndIf
				Else
					If dl <= 94
						If dl == 93
							newArray = new PAHSlave[93]
						Else
							newArray = new PAHSlave[94]
						EndIf
					Else
						If dl == 95
							newArray = new PAHSlave[95]
						Else
							newArray = new PAHSlave[96]
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	ElseIf dl <= 128
		If dl <= 112
			If dl <= 104
				If dl <= 100
					If dl <= 98
						If dl == 97
							newArray = new PAHSlave[97]
						Else
							newArray = new PAHSlave[98]
						EndIf
					Else
						If dl == 99
							newArray = new PAHSlave[99]
						Else
							newArray = new PAHSlave[100]
						EndIf
					EndIf
				Else
					If dl <= 102
						If dl == 101
							newArray = new PAHSlave[101]
						Else
							newArray = new PAHSlave[102]
						EndIf
					Else
						If dl == 103
							newArray = new PAHSlave[103]
						Else
							newArray = new PAHSlave[104]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 108
					If dl <= 106
						If dl == 105
							newArray = new PAHSlave[105]
						Else
							newArray = new PAHSlave[106]
						EndIf
					Else
						If dl == 107
							newArray = new PAHSlave[107]
						Else
							newArray = new PAHSlave[108]
						EndIf
					EndIf
				Else
					If dl <= 110
						If dl == 109
							newArray = new PAHSlave[109]
						Else
							newArray = new PAHSlave[110]
						EndIf
					Else
						If dl == 111
							newArray = new PAHSlave[111]
						Else
							newArray = new PAHSlave[112]
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			If dl <= 120
				If dl <= 116
					If dl <= 114
						If dl == 113
							newArray = new PAHSlave[113]
						Else
							newArray = new PAHSlave[114]
						EndIf
					Else
						If dl == 115
							newArray = new PAHSlave[115]
						Else
							newArray = new PAHSlave[116]
						EndIf
					EndIf
				Else
					If dl <= 118
						If dl == 117
							newArray = new PAHSlave[117]
						Else
							newArray = new PAHSlave[118]
						EndIf
					Else
						If dl == 119
							newArray = new PAHSlave[119]
						Else
							newArray = new PAHSlave[120]
						EndIf
					EndIf
				EndIf
			Else
				If dl <= 124
					If dl <= 122
						If dl == 121
							newArray = new PAHSlave[121]
						Else
							newArray = new PAHSlave[122]
						EndIf
					Else
						If dl == 123
							newArray = new PAHSlave[123]
						Else
							newArray = new PAHSlave[124]
						EndIf
					EndIf
				Else
					If dl <= 126
						If dl == 125
							newArray = new PAHSlave[125]
						Else
							newArray = new PAHSlave[126]
						EndIf
					Else
						If dl == 127
							newArray = new PAHSlave[127]
						Else
							newArray = new PAHSlave[128]
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	Else	
		Debug.trace("PAHe has exceeded array size! error, please report!!")
	EndIf
	return newArray
EndFunction

Function BleedOutStop(ObjectReference slaveRef)
	Actor slave = slaveRef as Actor
	Debug.SendAnimationEvent(slave, "BleedOutStop")
EndFunction

