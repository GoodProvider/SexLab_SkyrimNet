Scriptname DOM_Core extends Quest Conditional
Import Utility
Import DOM_Util
Import DOM_EquipUtil

string DOMVersionStr = "7.12.6"
DOM_PlayerAlias Property DOMPlayerAlias Auto 
DOM_API Property DOMAPI Auto
DOM_PAH Property DOMPAH Auto
DOM_ZAZ Property DOMZaz Auto
DOM_ZAD Property DOMZad Auto
DOM_SEXLAB Property DOMSexlab Auto
DOM_Bathing Property DOMBath Auto
DOM_Equip Property DOMEquip Auto
DOM_Ostim Property DOMOstim Auto
DOM_Animator Property DOM_Anim Auto
DOM_Generator Property DOMGenerator Auto
DOM_SlaverManager Property DOM01 Auto
DOM_SlaveManager Property DOM02 Auto
PHHSHInterface Property DOMHSH Auto Hidden
AYGASInterface Property DOMAYGAS Auto Hidden
int Property nDOMExtraMng = 0 Auto Hidden
DOM_SlaveManager[] __DOMExtraMng
DOM_SlaveManager[] Property DOMExtraMng Hidden
	DOM_SlaveManager[] Function Get()
		if !__DOMExtraMng
			__DOMExtraMng = new DOM_SlaveManager[8] ; Allow for 8 addons
		endif
		return __DOMExtraMng
	EndFunction
EndProperty
GlobalVariable Property DOM_NumberOfExtraMng Auto 

DOM_Diary Property DOM04 Auto
DOM_Keys Property DOMKeys Auto
DOM_MCM Property DOMConfig Auto
PHHSHFlexiStorage Property HSHFlexi Auto Hidden
PHHSHStorageFunctions Property HSHStorage Auto Hidden
PAHOCore Property PAHO Auto Hidden

Actor Property PlayerRef Auto
ReferenceAlias Property fSlave Auto
ReferenceAlias Property fFamily Auto
Message Property DOMFamilyPayMessage Auto 
Message Property DOMFamilyRansomMessage Auto 
MiscObject Property Gold001 Auto

Perk Property DOMEnslavePerk Auto
Perk Property DOMRecruitPerk Auto
Perk Property DOMWakeupPerk Auto
Perk Property DOMBurlapSackPerk Auto

; Furniture and ressources
Keyword Property FurnitureWoodChoppingBlock Auto
Keyword Property CraftingSmithingForge Auto
Keyword Property CraftingSmithingSkyForge Auto
Keyword Property CraftingSmithingArmorTable Auto
Keyword Property CraftingSmithingSharpeningWheel Auto
Keyword Property CraftingCookPot Auto
Keyword Property CraftingTanningRack Auto
Keyword Property CraftingSmelter Auto
Keyword Property CraftingBewitchingBench Auto
Keyword Property WICraftingAlchemy Auto
Keyword Property WICraftingEnchanting Auto

; Skyrim factions
Faction Property DunPlayerAllyFaction Auto
Faction Property MarriageExcludedFaction Auto
Faction Property PlayerFollowerFaction Auto
Faction Property PotentialFollowerFaction Auto
Faction Property CurrentFollowerFaction Auto
Faction Property CurrentHireling Auto
Faction Property MQ201PartyGuestUnhappy Auto
Faction Property DLC1ThrallFaction Auto
Faction Property dunPrisonerFaction Auto
Faction Property BardAudienceExcludedFaction Auto
Faction Property WINeverFillAliasesFaction Auto
Faction Property pTweakWaitingFaction Auto Hidden

Faction Property PlayerFaction Auto
Faction Property WEPlayerEnemy Auto

; External factions
Faction Property AygasSlaveTypeFaction Auto Hidden
Faction Property HshHouseSlaveFaction Auto Hidden
Faction Property HydraSlaveFaction Auto Hidden
Faction Property VanillaBanditsSlaveFaction Auto Hidden
Faction Property VanillaBanditsExSlaveFaction Auto Hidden
Faction Property TravellingWenchesFaction Auto Hidden
Faction Property TravellingWenchesServantFaction Auto Hidden
Faction Property TravellingWenchesPatrolFaction Auto Hidden
Faction Property TravellingWenchesJudgementFaction Auto Hidden
Faction Property TravellingWenchesCollectedFaction Auto Hidden
Faction Property OBISFaction Auto Hidden

Ingredient Property ObisGlowingPearl Auto Hidden

MagicEffect Property DOMHoseAimed Auto
MagicEffect Property DOMHoseProjectile Auto
Spell Property DOMAbductionSpell Auto
Spell Property DOMDiarySpell Auto
Spell Property DOMMenuSpell Auto
Spell Property DOMMenuPower Auto
Spell Property DOMInfoPower Auto
Spell Property DOMInfoSpell Auto
Spell Property DOMLeashSpell Auto
Form  Property DOMLeashPoint Auto

Faction Property DOMNameChangedFaction Auto
Faction Property DOMActorGender Auto
Faction Property DOMActorOwnerGender Auto
Faction Property DOMTrainSex Auto
Faction Property DOMTrainAnal Auto
Faction Property DOMTrainOral Auto
Faction Property DOMTrainVaginal Auto

Faction Property DOMActorAlreadyCleaned Auto
Faction Property DOMActorInTransfer Auto
Faction Property DOMActorHasTatsMarks Auto
Faction Property DOMActorHasTatsBrand Auto
Faction Property DOMRandomSeed Auto  ; to save Random seed of non unique NPC
Faction Property DOMIsLeashed Auto
Faction Property DOMDrunkLevel Auto
Faction Property DOMDruggedLevel Auto
Faction Property DOMIsLoveInterest Auto
Faction Property DOMHasPersonality Auto

; Externals
Cell Property AAADOMTestTony Auto
ObjectReference Property DOMTonyMarker Auto
Spell Property AbPOIFrozenCorpse Auto
Sound Property SlapMoan Auto
Sound Property SlapGagged Auto
Potion Property DOMLovePotion Auto
Potion Property DOMBrokenPotion Auto
Potion Property DOMLustPotion Auto
Potion Property DOMPainPotion Auto
Potion Property Skooma Auto
Potion Property WindhelmDoubleDistilledSkooma Auto
Potion Property FreeformAngasMillKordirsSkooma Auto
Potion Property dunSleepingTreeCampSap Auto
Potion Property TGTQ02BalmoraBlue Auto
Potion Property DLC1RedwaterDenSkooma Auto

Form Property DOMBurlapSack Auto
Form Property XMarkerForm Auto

; Location types
Keyword Property LocTypeJail Auto
Keyword Property LocTypeDungeon Auto
Keyword Property LocTypeMine Auto
Keyword Property LocTypeCave Auto
Keyword Property LocTypeCemetery Auto
Keyword Property LocTypeCity Auto
Keyword Property LocTypeTown Auto
Keyword Property LocTypeDwelling Auto
Keyword Property LocTypeStewardsDwelling Auto
Keyword Property LocTypeInn Auto
Keyword Property LocTypeCastle Auto
Keyword Property LocTypePlayerHouse Auto
Keyword Property LocTypeMilitaryFort Auto
Keyword Property LocTypeMilitaryCamp Auto

; Jail keywords
Keyword Property CWPrisonerMarker1 Auto
Keyword Property CWPrisonerMarker2 Auto
Keyword Property CWPrisonerMarker3 Auto
Keyword Property CWPrisonerMarker4 Auto
Keyword Property IsBeastRace Auto

; Actor type keywords
Keyword Property ActorTypeNPC Auto
Keyword Property ActorTypeCreature Auto
Keyword Property ActorTypeUndead Auto
Keyword Property ActorTypeAnimal Auto
Keyword Property Vampire Auto

; External keywords
KeyWord Property MagicDamageWater Auto Hidden
KeyWord Property MagicWater Auto
Keyword Property BodyBag Auto
Keyword Property DOMLeash Auto

; VoiceTypes
VoiceType Property MaleNord Auto
VoiceType Property FemaleNord Auto

; Idles
Idle Property IdleKneelingEnter Auto
Idle Property pa_HugA Auto
Idle Property IdleOffsetArmsCrossedStart Auto
Idle Property BleedOutStop Auto
Idle Property IdleStop_Loose Auto
Idle Property IdleForceDefaultState Auto
Idle Property staggerStart Auto
Idle Property IdleDrunkStart Auto
Idle Property IdleDrunkStop Auto
Idle Property IdleDialogueDefensiveHandGesture Auto
Idle Property IdleWarmArms Auto
Idle Property IdleCivilWarCheer Auto
Idle Property attackStart Auto
Idle Property ExitBed Auto
Idle Property ExitChairFront Auto
Idle Property IdleNervous Auto
Idle Property IdleCoweringLoose Auto
Idle Property IdleChildCryingStart Auto
Idle Property IdleSilentBow Auto
Idle Property IdleWipeBrow Auto
Idle Property pa_OffsetBoundStandingCut  Auto  
Idle Property offsetBoundStandingPlayerInstant  Auto  
Idle Property offsetBoundStandingStart  Auto  
Idle Property OffsetStop  Auto

; IdleDLC02FallOnKnees
; IdleLaugh
; IdlePrisonerBeat
; IdleSalute
; IdleSnapToAttention
; IdleSurrender
; IdleWarmHands IdleWarmHandsCrouched IdleWarmHandsStanding
; LooseDialogueResponsePositive
; LooseDialogueResponseNegative
; pa_DefeatSleeper

; DOM forms
Weapon Property DOMSlap Auto
Furniture Property DOMFurniStraddle Auto
Furniture Property DOMFurniChair Auto
Formlist Property AlcoholicDrinksExtendedList Auto

; Modesty mod
Keyword Property NoModestyKeyword Auto Hidden

; Toggles 
bool Property hugWhenFreedToggle = true Auto Hidden
bool Property checkInteriorPosesToggle = true Auto Hidden
bool Property doAnimBeforeAndAfterSex = true Auto Hidden
bool Property doAnimPlayerTieup = true Auto Hidden
bool Property renameToggle = true Auto Hidden
bool Property VampireCattleToggle = true Auto Hidden
bool Property wheelsUseVerboseMessage = true Auto Hidden
bool Property dialoguesUseVerboseMessage = false Auto Hidden
bool Property UpdateCombatStrength = true Auto Hidden
bool Property SetEssentialToggle = false Auto Hidden
bool Property RemoveEssentialToggle = false Auto Hidden
bool Property GroupChoiceRandom = true Auto Hidden
bool Property GroupChoicePose = true Auto Hidden
bool Property StartupCheckActor = false Auto Hidden
bool Property StartupSyncTattoos = false Auto Hidden
bool Property CaptureSyncTattoos = true Auto Hidden
bool Property setTransferNodeToggle = true Auto Hidden
bool Property setOBodyPresetToggleF = true Auto Hidden
bool Property setOBodyPresetToggleM = false Auto Hidden
bool Property cryingPunishmentToggle = true Auto Hidden
bool Property cryingPraiseToggle = true Auto Hidden
bool Property RandomFlat = false Auto Hidden
bool Property summonPAHToggle = false Auto Hidden
bool Property summonPosingToggle = false Auto Hidden
bool Property seedUniques = false Auto Hidden
bool Property sendDOMOrders = true Auto Hidden
bool Property sendDOMCaptureEvent = true Auto Hidden
bool Property sendDOMEvents = true Auto Hidden
bool Property sendDOMExternalEventToggle = false Auto Hidden
bool Property sendDOMExternalEventToggleExt = false Auto Hidden
bool Property sendDOMExternalEventToggleExt2 = false Auto Hidden
bool Property sendDOMExternalEventToggleExt3 = false Auto Hidden
bool Property showKinksToggle = false Auto Hidden
bool Property friendsPlayerToggle = true Auto Hidden
bool Property kinksPlayerSubToggle = false Auto Hidden
bool Property kinksPlayerDomToggle = true Auto Hidden
bool Property hasAbductionSpell = true Auto Hidden
bool Property hasDiarySpell = true Auto Hidden
bool Property hasMenuSpell = true Auto Hidden
bool Property hasMenuPower = true Auto Hidden
bool Property hasInfoSpell = true Auto Hidden
bool Property hasInfoPower = true Auto Hidden
bool Property hasAbductionPerk = true Auto Hidden
bool Property hasWakeUpPerk = true Auto Hidden
bool Property hasBurlapSackPerk = true Auto Hidden
bool Property hasRecruitPerk = true Auto Hidden
bool Property hasSlapTool = true Auto Hidden
bool Property debugMode = true Auto Hidden
bool Property verboseMode = true Auto Hidden
bool Property verboseTopics = false Auto Hidden
bool Property verboseAnim = true Auto Hidden
bool Property doPlayerIdle = true Auto Hidden
bool Property dualAnimToggle  = true Auto Hidden
bool Property poseMoveToggle  = false Auto Hidden
bool Property rivalryToggle = true Auto Hidden
bool Property greedToggle = true Auto Hidden
bool Property answerToggle = true Auto Hidden
bool Property topicsToggle = true Auto Hidden
bool Property virginOToggle = true Auto Hidden
bool Property virginAToggle = true Auto Hidden
bool Property virginVToggle = true Auto Hidden
bool Property virginSToggle = true Auto Hidden
bool Property virginGToggle = true Auto Hidden
bool Property staticTraitsMode = false Auto Hidden
bool Property staticTraitsChat = false Auto Hidden
bool Property alarmToggleRunaway = true Auto Hidden
bool Property oppositeSexToggle = true Auto Hidden
bool Property sameSexToggle = false Auto Hidden
bool Property wMessageToggle = true Auto Hidden
bool Property wMessageLevel0 = true Auto Hidden
bool Property wMessageLevel1 = true Auto Hidden
bool Property wMessageLevel2 = true Auto Hidden
bool Property wMessageLevel3 = true Auto Hidden
bool Property wMessageLevel4 = true Auto Hidden
bool Property wMessageLevel5 = true Auto Hidden
bool Property cloneUniqueMode = false Auto Hidden
bool Property cleanFactionUnique = false Auto Hidden
bool Property cleanFactionSpawn = false Auto Hidden
bool Property cleanCrimeFaction = false Auto Hidden
bool Property salutePoseOn = false Auto Hidden
bool Property attentionPoseOn = false Auto Hidden
bool Property kneelPoseOn = false Auto Hidden
bool Property friendToggle = true Auto Hidden
bool Property friendPlayerToggle = true Auto Hidden
bool Property friendDistantToggle = true Auto Hidden
bool Property friendFollowToggle = true Auto Hidden
bool Property familyToggle = true Auto Hidden
bool Property removeGagToggle = false Auto Hidden
bool Property removeCuffsToggle = false Auto Hidden
bool Property removeBlindfoldToggle = false Auto Hidden
bool Property blushFToggle = true Auto Hidden
bool Property tearsFToggle = true Auto Hidden
bool Property masctFToggle = true Auto Hidden
bool Property blushMToggle = true Auto Hidden
bool Property tearsMToggle = true Auto Hidden
bool Property masctMToggle = false Auto Hidden
bool Property resilienceToggle = false Auto Hidden
bool Property loyalToggle = true Auto Hidden
bool Property inloveToggle = true Auto Hidden
bool Property depressedToggle = true Auto Hidden
bool Property insecureToggle = true Auto Hidden
bool Property jealousyToggle = true Auto Hidden
bool Property weaponsFToggle = true Auto Hidden
bool Property weaponsMToggle = true Auto Hidden
bool Property weaponsBToggle = true Auto Hidden
bool Property weaponsOToggle = true Auto Hidden
bool Property cloneSpawnMode = true Auto Hidden
bool Property fHitToggle = true Auto Hidden
bool Property sHitToggle = true Auto Hidden
bool Property escapeToggle = true Auto Hidden
bool Property cleanDeleteToggle = true Auto Hidden
bool Property cleanWeaponsToggle = true Auto Hidden
bool Property cleanArmorsToggle = true Auto Hidden
bool Property cleanAmmoToggle = true Auto Hidden
bool Property cleanBooksToggle = true Auto Hidden
bool Property cleanScrollsToggle = true Auto Hidden
bool Property singleTellToggle = true Auto Hidden
bool Property travelCuffsToggle = true Auto Hidden
bool Property punishPoseToggle = true Auto Hidden
bool Property punishTieToggle = true Auto Hidden
bool Property punishRestrainToggle = true Auto Hidden
bool Property punishMasturbateToggle = true Auto Hidden
bool Property trainSexlabValuesToggle = false Auto Hidden
bool Property readSexlabValuesToggle = false Auto Hidden

; Settings & global values
int Property defaultWaitMode = 3 Auto Hidden
int Property defaultFollowMode = 2 Auto Hidden
int Property delayTopic = 10 Auto Hidden
int Property delayTopicGlobal = 10 Auto Hidden
int Property actorRegenTicks = 1 Auto Hidden
int Property MaxNumberOfFriends = 5 Auto Hidden
float Property chanceRunAwayMultiplier = 1.0 Auto Hidden
float Property actorUpdateTimer = 3.0 Auto Hidden
float Property actorUpdateTimerGlobal = 1.0 Auto Hidden
float Property runAwayValue = 60.0 Auto Hidden
float Property deleteActorThreshold = 10.0 Auto Hidden
float Property dirtRegenAmount = 3.0 Auto Hidden
float Property actorRegenAmount = 5.0 Auto Hidden ; in per mil (default is 0.5% in combat or 0.7%)
float Property arousal_speed_kink  = 1.0 Auto Hidden
float Property orgasm_speed_kink  = 1.0 Auto Hidden
float Property train_speed_kink  = 1.0 Auto Hidden
float Property train_speed_love  = 0.25 Auto Hidden
float Property train_speed_arousal  = 0.50 Auto Hidden
float Property train_speed_orgasm  = 0.25 Auto Hidden
float Property train_speed_npc  = 1.0 Auto Hidden
float Property train_speed_player  = 1.2 Auto Hidden
float Property train_speed_pain = 100.0 Auto Hidden
float Property train_speed_sex  = 100.0 Auto Hidden
float Property train_speed_rape = 100.0 Auto Hidden
float Property train_speed_tell = 100.0 Auto Hidden
float Property train_speed_good = 100.0 Auto Hidden
float Property trait_race_bonus = 1.0 Auto Hidden
float Property trait_gender_bonus = 1.0 Auto Hidden
float Property trait_age_bonus = 1.0 Auto Hidden
float Property trait_job_bonus = 1.0 Auto Hidden
float Property trait_class_bonus = 1.0 Auto Hidden
float Property trait_place_bonus = 1.0 Auto Hidden
Float Property trait_variation = 25.0 Auto Hidden
Float Property anim_speed_sec = 1.0 Auto Hidden
Float Property friend_threshold = 0.60 Auto Hidden
Float Property wealth_modifier = 10.0 Auto Hidden
Float Property pose_threshold = 0.04 Auto Hidden ; in days
Int Property is_dialogue_global_blocked_for = 1 Auto Hidden ; in seconds
Int Property is_weather_dialogue_global_blocked_for = 1 Auto Hidden ; in seconds
bool Property ActionFlag = false Auto Hidden
bool Property ActionGroup = false Auto Hidden
string Property ActionName = "flatter" Auto Hidden
string Property ActionType = "sexy" Auto Hidden
string Property attentionPose = "ZapKneelDisplay" Auto Hidden
string Property salutePose = "IdleHandsBehindBack" Auto Hidden
string Property kneelPose = "ZapLickFeet" Auto Hidden
string Property spellPose1 = "IdleForceDefaultState" Auto Hidden
string Property spellPose2 = "BleedOutStart" Auto Hidden
string Property DefaultPraiseType = "tell" Auto Hidden ; "tell", "pat head", "grope ass", "pat cheek", "hold chin", "kiss", "kiss short", "kiss side"
string Property DefaultPunishmentType = "pain" Auto Hidden ; "pain", "rape", "scold", "public humiliation", "choke", "spank", "slap boobs", "slap face"
string Property DefaultWheelPraiseType = "tell" Auto Hidden ; "tell", "pat head", "grope ass", "pat cheek", "hold chin", "kiss", "kiss short", "kiss side"
string Property DefaultWheelPunishmentType = "scold" Auto Hidden ; "pain", "rape", "scold", "public humiliation", "choke", "spank", "slap boobs", "slap face"

string Property marks_maid_name = "Maid Left cheek" Auto Hidden
string Property marks_maid_file = "DOMMarks\\left_cheek_maid.dds" Auto Hidden
string Property marks_maid_area  = "Face" Auto Hidden
string Property marks_miner_name = "Miner Left cheek" Auto Hidden
string Property marks_miner_file = "DOMMarks\\left_cheek_miner.dds" Auto Hidden
string Property marks_miner_area  = "Face" Auto Hidden
string Property marks_name = "DOM Forehead" Auto Hidden
string Property marks_file = "DOMMarks\\forehead_DOM.dds" Auto Hidden
string Property brand_section = "DoMStatus" Auto Hidden
string Property marks_section = "DOMMarks" Auto Hidden
string Property brand_area  = "Body" Auto Hidden
string Property marks_area  = "Face" Auto Hidden
int    Property brand_color = 0x444544 Auto Hidden
int    Property marks_color = 0x000000 Auto Hidden
int    Property brand_glow  = 0x000000 Auto Hidden
int    Property marks_glow  = 0x000000 Auto Hidden
bool   Property brand_gloss = false Auto Hidden
bool   Property marks_gloss = false Auto Hidden
bool   Property brand_glow_status = true Auto Hidden
bool   Property marks_glow_status = false Auto Hidden

; Widgets (reused from apropos)
Int Property number_of_widgets = 8 Auto Hidden
DOM_MessageWidget[] Property MessageWidgets Auto

; Life style orders
Faction Property DOMIsWalkingOnFour Auto
Faction Property DOMIsRespectful Auto
Faction Property DOMShouldWalkOnFour Auto
Faction Property DOMShouldBeRespectful Auto
Faction Property DOMShouldFightForPlayer Auto
Faction Property DOMShouldBeNaked Auto
Faction Property DOMShouldWearArmor Auto
Faction Property DOMShouldHoldWeapons Auto
Faction Property DOMShouldBeNoOrgasm Auto
Faction Property DOMShouldBeSilent Auto

; DOM Factions
Faction Property DOMActorFaction Auto
Faction Property DOMNotPlayerSlaveFaction Auto
Faction Property DOMNotPlayerSlaverFaction Auto
Faction Property DOMPlayerSlaveFaction Auto
Faction Property DOMPlayerSlaverFaction Auto
Faction Property DOMHistoryFaction Auto
Faction Property DOMActorFamilyHistory Auto
Faction Property DOMActorFamilyReunited Auto
Faction Property DOMSlaveManagerFaction Auto
Faction Property DOMActorIndexFaction Auto
Faction Property DOMAliasIndexFaction Auto
Faction Property DOMSexlabLoadSlave Auto

Faction Property DOMHiddenKink0 Auto
Faction Property DOMHiddenKink1 Auto
Faction Property DOMHiddenKink2 Auto
Faction Property DOMHiddenKink3 Auto
Faction Property DOMHiddenKink4 Auto
Faction Property DOMHiddenKink5 Auto
Faction Property DOMHiddenKink6 Auto
Faction Property DOMHiddenKink7 Auto

Faction Property DOMKnownKink0 Auto
Faction Property DOMKnownKink1 Auto
Faction Property DOMKnownKink2 Auto
Faction Property DOMKnownKink3 Auto
Faction Property DOMKnownKink4 Auto
Faction Property DOMKnownKink5 Auto
Faction Property DOMKnownKink6 Auto
Faction Property DOMKnownKink7 Auto

Faction Property DOMPunishmentReason0 Auto
Faction Property DOMPunishmentReason1 Auto
Faction Property DOMPunishmentReason2 Auto
Faction Property DOMPunishmentReason3 Auto
Faction Property DOMPunishmentReason4 Auto
Faction Property DOMPunishmentReason5 Auto
Faction Property DOMPunishmentReason6 Auto
Faction Property DOMPunishmentReason7 Auto

Faction Property DOMPraiseReason0 Auto
Faction Property DOMPraiseReason1 Auto
Faction Property DOMPraiseReason2 Auto
Faction Property DOMPraiseReason3 Auto
Faction Property DOMPraiseReason4 Auto
Faction Property DOMPraiseReason5 Auto
Faction Property DOMPraiseReason6 Auto
Faction Property DOMPraiseReason7 Auto

Faction Property DOMActorHasHSHCell Auto
Faction Property DOMActorExcludedFaction Auto
Faction Property DOMActorExcludedDialogue Auto
Faction Property DOMActorRivalIsVictim Auto
Faction Property DOMActorFriendIsVictim Auto
Faction Property DOMActorIsVictim Auto
Faction Property DOMBeingCaptured Auto
Faction Property DOMNoCloneFaction Auto
Faction Property DOMNoCleanFaction Auto
Faction Property DOMNoCleanCrimeFaction Auto
Faction Property DOMFollowMode Auto
Faction Property DOMWaitMode Auto
Faction Property DOMTravelMode Auto
Faction Property DOMWorkMode Auto
Faction Property DOMJailMode Auto

Faction Property DOMAnimatingFaction Auto
Faction Property DOMPotentialSlaverFaction Auto
Faction Property DOMPlayerEnemyFaction Auto
Faction Property DOMTobeComfortedFaction Auto
Faction Property DOMDirtiness Auto
Faction Property DOMHasWeapon Auto
Faction Property DOMHasArmor Auto
Faction Property DOMHasBodyArmor Auto
Faction Property DOMHasShield Auto
Faction Property DOMHasJewelry Auto
Faction Property DOMIsNaked Auto
Faction Property DOMPromised Auto
Faction Property DOMToBeSacrificed Auto
Faction Property DOMSlaverHasCamp Auto
Faction Property DOMTraineeCount Auto
Faction Property DOMSlaveHasTrainer Auto
Faction Property DOMSlaverLoadSlave Auto

; Virgin status
Faction Property DOMVirginVaginal Auto
Faction Property DOMVirginAnal Auto
Faction Property DOMVirginOral Auto
Faction Property DOMVirginSame Auto
Faction Property DOMVirginGangbang Auto

; DOM Package Actions
Package Property DOMFollowPlayerAndWait Auto
Package Property DOMFamilyForceGreet Auto
Faction Property DOMActionFighting Auto
Faction Property DOMActionFleeing Auto
Faction Property DOMActionFollowing Auto
Faction Property DOMActionGuard Auto
Faction Property DOMActionKneeling Auto
Faction Property DOMActionMasturbating Auto
Faction Property DOMActionPosing Auto
Faction Property DOMActionPunishing Auto
Faction Property DOMActionTraining Auto
Faction Property DOMActionSweeping Auto
Faction Property DOMActionWorking Auto
Faction Property DOMActionTied Auto
Faction Property DOMActionTravel Auto
Faction Property DOMActionWaiting Auto
Faction Property DOMActionInContainer Auto
Faction Property DOMActionOnDuty Auto
Faction Property DOMActionJailed Auto

; DOM Dialogue factions
Faction Property DOMFailedToFight Auto
Faction Property DOMFailedToPose Auto

; Personality traits
Faction Property DOMTraitHonesty Auto
Faction Property DOMTraitEmotionality Auto
Faction Property DOMTraitExtraversion Auto
Faction Property DOMTraitAgreeableness Auto
Faction Property DOMTraitConscientiousness Auto
Faction Property DOMTraitOpenness Auto

; Personality facets
Faction Property DOMFacetBoldness Auto
Faction Property DOMFacetWilfulness Auto
Faction Property DOMFacetSmartness Auto
Faction Property DOMFacetSensuality Auto
Faction Property DOMFacetToughness Auto
Faction Property DOMFacetSubmissivity Auto

; Personality Modifiers
; Main per training stat - Controls stats evolution
Faction Property DOMModHumility Auto      ; Submission
Faction Property DOMModFearfulness Auto   ; Fear
Faction Property DOMModNaivety Auto       ; Humiliation
Faction Property DOMModForgiveness Auto   ; Anger
Faction Property DOMModPrudent Auto       ; Resignation
Faction Property DOMModDiscipline Auto    ; Respect

; Main per SKILL - Control skill evolution
Faction Property DOMModInsensitivity Auto ; Enforcer 
Faction Property DOMModIntimidate Auto    ; Persuader 
Faction Property DOMModSelfEsteem Auto    ; Depraver
Faction Property DOMModResentment Auto    ; Predator 
Faction Property DOMModController Auto    ; Slaver
Faction Property DOMModPretender Auto     ; Deceiver

; Talents - Control secondary stats evolution
Faction Property DOMModVaginal Auto       ; Honesty
										  ; Emotionality
Faction Property DOMModOral Auto		  ; eXtraversion
Faction Property DOMModAnal Auto		  ; Agreeableness
Faction Property DOMModPerfectionism Auto ; Conscientious (House keeping)
Faction Property DOMModFlexibility Auto	  ; Openness (Pose)
Faction Property DOMModAuthority Auto     ; Openness (Work training)

; Physical - Control physical stat evolution
Faction Property DOMModCombat Auto        ; Combat training

; Secondary - Control traits evolution
Faction Property DOMModCriminality Auto   ; Honesty
Faction Property DOMModSentimentality Auto; Emotionality
Faction Property DOMModDaring Auto        ; Extraversion
Faction Property DOMModImpatience Auto    ; Agreeableness, being angry
Faction Property DOMModDiligent Auto      ; Conscientiousness
Faction Property DOMModManipulation Auto  ; Openness

; Love/Loyal - Control love/loyal stats evolution
Faction Property DOMModModesty Auto       ; Honesty
Faction Property DOMModDependence Auto    ; Emotionality
Faction Property DOMModIngenuity Auto     ; Extraversion
Faction Property DOMModGentleness Auto    ; Agreeableness, being angry
Faction Property DOMModConsideration Auto ; Conscientiousness
Faction Property DOMModCreativity Auto    ; Openness

; Others									
;Faction Property DOMModHope Auto          ; Agreeableness

; Skills
Faction Property DOMSkillEnforcer Auto     ; Submission
Faction Property DOMSkillPersuader Auto    ; Fear
Faction Property DOMSkillDepraver Auto     ; Humiliation
Faction Property DOMSkillPredator Auto     ; Anger
Faction Property DOMSkillSlaver Auto       ; Resignation
Faction Property DOMSkillDeceiver Auto     ; Respect

; Moods
Faction Property DOMMoodJustCaptured Auto
Faction Property DOMMoodNeutral Auto
Faction Property DOMMoodAngry Auto
Faction Property DOMMoodAfraid Auto
Faction Property DOMMoodHappy Auto
Faction Property DOMMoodAshamed Auto
Faction Property DOMMoodSad Auto
Faction Property DOMMoodShock Auto
Faction Property DOMMoodBroken Auto
Faction Property DOMMoodLoyal Auto
Faction Property DOMMoodInlove Auto

; NPC Feelings
Faction Property DOMFeelSubmission Auto
Faction Property DOMFeelFear Auto
Faction Property DOMFeelHumiliation Auto
Faction Property DOMFeelAnger Auto
Faction Property DOMFeelResignation Auto
Faction Property DOMFeelRespect Auto

; Love syndrome
Faction Property DOMLoveDesire Auto
Faction Property DOMLoyalWorship Auto
Faction Property DOMLoveFascination Auto
Faction Property DOMLoyalAbsolution Auto
Faction Property DOMLoyalDevotion Auto
Faction Property DOMLoveAdmiration Auto

; Relationship control factions
Faction Property DOMControlPersonalityDialogue1 Auto
Faction Property DOMControlPersonalityDialogue2 Auto
Faction Property DOMControlPersonalityDialogue3 Auto
Faction Property DOMControlPersonalityDialogue4 Auto
Faction Property DOMControlFeelingsDialogue1 Auto
Faction Property DOMControlFeelingsDialogue2 Auto
Faction Property DOMControlFeelingsDialogue3 Auto
Faction Property DOMControlFeelingsDialogue4 Auto
Faction Property DOMControlModifiersDialogue1 Auto
Faction Property DOMControlModifiersDialogue2 Auto

; Training
Faction Property DOMTrainSubmission Auto
Faction Property DOMTrainFear Auto
Faction Property DOMTrainHumiliation Auto
Faction Property DOMTrainAnger Auto
Faction Property DOMTrainResignation Auto
Faction Property DOMTrainRespect Auto

Faction Property DOMTrainCombat Auto
Faction Property DOMTrainPose Auto
Faction Property DOMTrainHouse Auto
Faction Property DOMTrainWorking Auto
Faction Property DOMTraumaInDays Auto

; Counters
Faction Property DOMNbBrainWashed Auto
Faction Property DOMNbBroken Auto
Faction Property DOMNbComfort Auto
Faction Property DOMNbFlatter Auto
Faction Property DOMNbInsult Auto
Faction Property DOMNbOrgasm Auto
Faction Property DOMNbBondage Auto
Faction Property DOMNbPain Auto
Faction Property DOMNbPraise Auto
Faction Property DOMNbPromise Auto
Faction Property DOMNbRape Auto
Faction Property DOMNbDrug Auto
Faction Property DOMNbSex Auto
Faction Property DOMNbSexWithOthers Auto
Faction Property DOMNbSexForMoney Auto
Faction Property DOMNbKinkTrigger Auto
Faction Property DOMNbShame Auto
Faction Property DOMNbShock Auto
Faction Property DOMNbThreat Auto
Faction Property DOMNbToldoff Auto
Faction Property DOMNbChatFeelings Auto
Faction Property DOMNbChatPersonality Auto
Faction Property DOMNbTrainee Auto
Faction Property DOMNbTrainer Auto
Faction Property DOMNbRecruitedSlavers Auto
Faction Property DOMNbRansomedSlaves Auto
Faction Property DOMNbCapturedSlaves Auto
Faction Property DOMNbBrokenSlaves Auto
Faction Property DOMNbSoldSlaves Auto
Faction Property DOMNbWhoredSlaves Auto
Faction Property DOMNbPlayerFling Auto
Faction Property DOMNbPlayerChat Auto

; Topics & answers

Topic Property DOM02TopicAnswerSwingWeaponRespectful Auto
Topic Property DOM02TopicAnswerIdleRespectful Auto
Topic Property DOM02TopicAnswerHelloRespectful Auto
Topic Property DOM02TopicAnswerGoodbyeRespectful Auto
Topic Property DOM02TopicAnswerCollideRespectful Auto
Topic Property DOM02TopicAnswerYesRespectful Auto
Topic Property DOM02TopicAnswerNoRespectful Auto
Topic Property DOM02TopicAnswerSorryRespectful Auto
Topic Property DOM02TopicAnswerThanksRespectful Auto
Topic Property DOM02TopicAnswerWhatRespectful Auto
Topic Property DOM02TopicAnswerValueRespectful Auto
Topic Property DOM02TopicAnswerStripRespectful Auto
Topic Property DOM02TopicAnswerBadRespectful Auto
Topic Property DOM02TopicAnswerNewPromiseRespectful Auto
Topic Property DOM02TopicAnswerKeptPromiseRespectful Auto
Topic Property DOM02TopicAnswerFailedPromiseRespectful Auto
Topic Property DOM02TopicAnswerSwingWeapon Auto
Topic Property DOM02TopicAnswerIdle Auto
Topic Property DOM02TopicAnswerHello Auto
Topic Property DOM02TopicAnswerGoodbye Auto
Topic Property DOM02TopicAnswerCollide Auto
Topic Property DOM02TopicAnswerYes Auto
Topic Property DOM02TopicAnswerNo Auto
Topic Property DOM02TopicAnswerSorry Auto
Topic Property DOM02TopicAnswerThanks Auto
Topic Property DOM02TopicAnswerWhat Auto
Topic Property DOM02TopicAnswerValue Auto
Topic Property DOM02TopicAnswerStrip Auto
Topic Property DOM02TopicAnswerBad Auto
Topic Property DOM02TopicAnswerNewPromise Auto
Topic Property DOM02TopicAnswerKeptPromise Auto
Topic Property DOM02TopicAnswerFailedPromise Auto
Topic Property DOM02TopicAnswerAttack Auto
Topic Property DOM02TopicAnswerHelp Auto
Topic Property DOM02TopicAnswerOrgasm Auto
Topic Property DOM02TopicAnswerAroused Auto
Topic Property DOM02TopicAnswerTouchBase Auto
Topic Property DOM02TopicAnswerTouchButt Auto
Topic Property DOM02TopicAnswerTouchBreast Auto
Topic Property DOM02TopicAnswerTouchBegin Auto
Topic Property DOM02TopicAnswerTouchNeck Auto

Topic Property DOM02TopicAnswerMoodAngryRespectful Auto
Topic Property DOM02TopicAnswerMoodAfraidRespectful Auto
Topic Property DOM02TopicAnswerMoodTerrorRespectful Auto
Topic Property DOM02TopicAnswerMoodScaredRespectful Auto
Topic Property DOM02TopicAnswerMoodAshamedRespectful Auto
Topic Property DOM02TopicAnswerMoodSadRespectful Auto
Topic Property DOM02TopicAnswerMoodShockedRespectful Auto
Topic Property DOM02TopicAnswerMoodBrokenRespectful Auto
Topic Property DOM02TopicAnswerMoodLoyalRespectful Auto

Topic Property DOM02TopicAnswerMoodAngry Auto
Topic Property DOM02TopicAnswerMoodAfraid Auto
Topic Property DOM02TopicAnswerMoodTerror Auto
Topic Property DOM02TopicAnswerMoodScared Auto
Topic Property DOM02TopicAnswerMoodAshamed Auto
Topic Property DOM02TopicAnswerMoodSad Auto
Topic Property DOM02TopicAnswerMoodShocked Auto
Topic Property DOM02TopicAnswerMoodBroken Auto
Topic Property DOM02TopicAnswerMoodLoyal Auto
Topic Property DOM02TopicAnswerMoodInlove Auto
Topic Property DOM02TopicAnswerMoodDepressed Auto
Topic Property DOM02TopicAnswerMoodJealous Auto
Topic Property DOM02TopicAnswerMoodInsecure Auto

Topic Property DOM02TopicAnswerSubmissionRespectful Auto
Topic Property DOM02TopicAnswerFearRespectful Auto
Topic Property DOM02TopicAnswerHumiliationRespectful Auto
Topic Property DOM02TopicAnswerAngryRespectful Auto
Topic Property DOM02TopicAnswerResignationRespectful Auto
Topic Property DOM02TopicAnswerRespectRespectful Auto

Topic Property DOM02TopicAnswerSubmission Auto
Topic Property DOM02TopicAnswerFear Auto
Topic Property DOM02TopicAnswerHumiliation Auto
Topic Property DOM02TopicAnswerAngry Auto
Topic Property DOM02TopicAnswerResignation Auto
Topic Property DOM02TopicAnswerRespect Auto

Topic Property DOM02TopicAnswerPain1Respectful Auto
Topic Property DOM02TopicAnswerPain2Respectful Auto
Topic Property DOM02TopicAnswerPain3Respectful Auto
Topic Property DOM02TopicAnswerPain4Respectful Auto
Topic Property DOM02TopicAnswerPain5Respectful Auto

Topic Property DOM02TopicAnswerPain1 Auto
Topic Property DOM02TopicAnswerPain2 Auto
Topic Property DOM02TopicAnswerPain3 Auto
Topic Property DOM02TopicAnswerPain4 Auto
Topic Property DOM02TopicAnswerPain5 Auto

Topic Property DOM02TopicAnswerWeather1Respectful Auto
Topic Property DOM02TopicAnswerWeather2Respectful Auto
Topic Property DOM02TopicAnswerWeather3Respectful Auto

Topic Property DOM02TopicAnswerWeather1 Auto
Topic Property DOM02TopicAnswerWeather2 Auto
Topic Property DOM02TopicAnswerWeather3 Auto

Topic Property DOM02TopicAnswerFriend0Respectful Auto
Topic Property DOM02TopicAnswerFriend1Respectful Auto
Topic Property DOM02TopicAnswerFriend2Respectful Auto
Topic Property DOM02TopicAnswerFriend3Respectful Auto
Topic Property DOM02TopicAnswerFriend4Respectful Auto

Topic Property DOM02TopicAnswerFriend0 Auto
Topic Property DOM02TopicAnswerFriend1 Auto
Topic Property DOM02TopicAnswerFriend2 Auto
Topic Property DOM02TopicAnswerFriend3 Auto
Topic Property DOM02TopicAnswerFriend4 Auto

Topic Property DOM02TopicAnswerRival0 Auto
Topic Property DOM02TopicAnswerRival1 Auto
Topic Property DOM02TopicAnswerRival2 Auto
Topic Property DOM02TopicAnswerRival3 Auto
Topic Property DOM02TopicAnswerRival4 Auto

; family associations
associationType Property pCourting    auto
associationType Property pSpouse      auto
associationType Property pParent      auto
associationType Property pGrandParent auto
associationType Property pGreatGrandParent auto
associationType Property pSibling     auto
associationType Property pCousin      auto
associationType Property pUncleAunt   auto
associationType Property pGreatAuntUncle auto
associationType Property pInLawParent auto
associationType Property pInLawBrotherSister auto
associationType Property pInLawAuntUncle auto

; followers
GlobalVariable Property DOM_FollowersMainGenderType Auto 
Int Property femaleFollowCounter = -1 Auto Hidden
Int Property maleFollowCounter = -1 Auto Hidden

Function SetFollowCounters()
	if femaleFollowCounter >= 0
		LogTrace("Number of slaves following the player: "+femaleFollowCounter+" [F] + "+maleFollowCounter+" [M] main gender="+DOM_FollowersMainGenderType.GetValue())
		return
	endif
	femaleFollowCounter = 0
	maleFollowCounter = 0
	int n = DOM02.actorCounter
	int i = 0
	while i < n
		DOM_Actor akActor = DOM02.actorArray[i]
		if akActor != None
			if akActor.behaviour == "follow_player"
				if (akActor.actorSex % 2) == 1
					femaleFollowCounter += 1
				else
					maleFollowCounter += 1
				endif
			endif
		endif
		i += 1
	endwhile
	SetFollowersMainGenderType()
	LogTrace("Number of slaves following the player: "+femaleFollowCounter+" [F] + "+maleFollowCounter+" [M] main gender="+DOM_FollowersMainGenderType.GetValue())
EndFunction

Function SetFollowersMainGenderType()
	if femaleFollowCounter >= maleFollowCounter
		DOM_FollowersMainGenderType.SetValue(1)
	else
		DOM_FollowersMainGenderType.SetValue(0)
	endif
EndFunction

Function AddSlaveFollower(DOM_Actor akActor)
	if akActor == None
		return
	endif
	if (akActor.actorSex % 2) == 1
		femaleFollowCounter += 1
	else
		maleFollowCounter += 1
	endif
	SetFollowersMainGenderType()
EndFunction

Function RemoveSlaveFollower(DOM_Actor akActor)
	if akActor == None
		return
	endif
	if (akActor.actorSex % 2) == 1
		if femaleFollowCounter > 0
			femaleFollowCounter -= 1
		endif
	else
		if maleFollowCounter > 0
			maleFollowCounter -= 1
		endif
	endif
	SetFollowersMainGenderType()
EndFunction

; Player's Skills - Legacy - Do not use these properties - Use the functions below
string Property playerTitle = "" Auto Hidden

Function PlayerHasSold(DOM_Actor akActor)
	DOMPlayerAlias.HasSold(akActor)
EndFunction

Float __skill_enforcer = 0.0 ; Training slaves
Float __skill_persuader = 0.0 ; Scaring slaves
Float __skill_depraver = 0.0 ; Humiliating slaves
Float __skill_predator = 0.0 ; Capturing slaves
Float __skill_slaver = 0.0 ; Managing slaves
Float __skill_deceiver = 0.0 ;  Brain washing slaves

Float Function RetrieveSkillEnforcer()
	return __skill_enforcer
EndFunction
Float Function RetrieveSkillPersuader()
	return __skill_persuader
EndFunction
Float Function RetrieveSkillDepraver()
	return __skill_depraver
EndFunction
Float Function RetrieveSkillPredator()
	return __skill_predator
EndFunction
Float Function RetrieveSkillSlaver()
	return __skill_slaver
EndFunction
Float Function RetrieveSkillDeceiver()
	return __skill_deceiver
EndFunction

Function TrainSkillEnforcer(Actor akAbuser, Float base_amount)
	if akAbuser == PlayerRef || akAbuser == None
		DOMPlayerAlias.TrainSkillEnforcer(base_amount)
		return
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillEnforcer(base_amount)
		return
	endif
	if base_amount < 1.0
		return
	endif
	int rank = akAbuser.GetFactionRank(DOMSkillEnforcer)
	if rank < 100
		if rank < 0
			rank = 0
		else 
			rank = rank + 1
		endif
		akAbuser.SetFactionRank(DOMSkillEnforcer,rank)
	endif
EndFunction
Function TrainSkillPersuader(Actor akAbuser, Float base_amount)
	if akAbuser == PlayerRef || akAbuser == None
		DOMPlayerAlias.TrainSkillPersuader(base_amount)
		return
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillPersuader(base_amount)
		return
	endif
	if base_amount < 1.0
		return
	endif
	int rank = akAbuser.GetFactionRank(DOMSkillPersuader)
	if rank < 100
		if rank < 0
			rank = 0
		else 
			rank = rank + 1
		endif
		akAbuser.SetFactionRank(DOMSkillPersuader,rank)
	endif
EndFunction
Function TrainSkillDepraver(Actor akAbuser, Float base_amount)
	if akAbuser == PlayerRef || akAbuser == None
		DOMPlayerAlias.TrainSkillDepraver(base_amount)
		return
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillDepraver(base_amount)
		return
	endif
	if base_amount < 1.0
		return
	endif
	int rank = akAbuser.GetFactionRank(DOMSkillDepraver)
	if rank < 100
		if rank < 0
			rank = 0
		else 
			rank = rank + 1
		endif
		akAbuser.SetFactionRank(DOMSkillDepraver,rank)
	endif
EndFunction
Function TrainSkillPredator(Actor akAbuser, Float base_amount)
	if akAbuser == PlayerRef || akAbuser == None
		DOMPlayerAlias.TrainSkillPredator(base_amount)
		return
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillPredator(base_amount)
		return
	endif
	if base_amount < 1.0
		return
	endif
	int rank = akAbuser.GetFactionRank(DOMSkillPredator)
	if rank < 100
		if rank < 0
			rank = 0
		else 
			rank = rank + 1
		endif
		akAbuser.SetFactionRank(DOMSkillPredator,rank)
	endif
EndFunction
Function TrainSkillSlaver(Actor akAbuser, Float base_amount)
	if akAbuser == PlayerRef || akAbuser == None
		DOMPlayerAlias.TrainSkillSlaver(base_amount)
		return
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillSlaver(base_amount)
		return
	endif
	if base_amount < 1.0
		return
	endif
	int rank = akAbuser.GetFactionRank(DOMSkillSlaver)
	if rank < 100
		if rank < 0
			rank = 0
		else 
			rank = rank + 1
		endif
		akAbuser.SetFactionRank(DOMSkillSlaver,rank)
	endif
EndFunction
Function TrainSkillDeceiver(Actor akAbuser, Float base_amount)
	if akAbuser == PlayerRef || akAbuser == None
		DOMPlayerAlias.TrainSkillDeceiver(base_amount)
		return
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillDeceiver(base_amount)
		return
	endif
	if base_amount < 1.0
		return
	endif
	int rank = akAbuser.GetFactionRank(DOMSkillDeceiver)
	if rank < 100
		if rank < 0
			rank = 0
		else 
			rank = rank + 1
		endif
		akAbuser.SetFactionRank(DOMSkillDeceiver,rank)
	endif
EndFunction

Float Function GetEnforcerModifier(Actor akAbuser)
	if akAbuser == PlayerRef || akAbuser == None
		return DOMPlayerAlias.GetEnforcerModifier()
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		return akAggressorMind.GetEnforcerModifier()
	endif
	float rank = akAbuser.GetFactionRank(DOMSkillEnforcer) as float
	return 0.5+rank/100.0
EndFunction
Float Function GetPersuaderModifier(Actor akAbuser)
	if akAbuser == PlayerRef || akAbuser == None
		return DOMPlayerAlias.GetPersuaderModifier()
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		return akAggressorMind.GetPersuaderModifier()
	endif
	float rank = akAbuser.GetFactionRank(DOMSkillPersuader) as float
	return 0.5+rank/100.0
EndFunction
Float Function GetDepraverModifier(Actor akAbuser)
	if akAbuser == PlayerRef || akAbuser == None
		return DOMPlayerAlias.GetDepraverModifier()
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		return akAggressorMind.GetDepraverModifier()
	endif
	float rank = akAbuser.GetFactionRank(DOMSkillDepraver) as float
	return 0.5+rank/100.0
EndFunction
Float Function GetPredatorModifier(Actor akAbuser)
	if akAbuser == PlayerRef || akAbuser == None
		return DOMPlayerAlias.GetPredatorModifier()
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		return akAggressorMind.GetPredatorModifier()
	endif
	float rank = akAbuser.GetFactionRank(DOMSkillPredator) as float
	return 0.5+rank/100.0
EndFunction
Float Function GetSlaverModifier(Actor akAbuser)
	if akAbuser == PlayerRef || akAbuser == None
		return DOMPlayerAlias.GetSlaverModifier()
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		return akAggressorMind.GetSlaverModifier()
	endif
	float rank = akAbuser.GetFactionRank(DOMSkillSlaver) as float
	return 0.5+rank/100.0
EndFunction
Float Function GetDeceiverModifier(Actor akAbuser)
	if akAbuser == PlayerRef || akAbuser == None
		return DOMPlayerAlias.GetDeceiverModifier()
	endif
	DOM_Mind akAggressorMind = GetActorMind(akAbuser)
	if akAggressorMind != None
		return akAggressorMind.GetDeceiverModifier()
	endif
	float rank = akAbuser.GetFactionRank(DOMSkillDeceiver) as float
	return 0.5+rank/100.0
EndFunction

float Function GetTrainingSpeed(Actor akAbuser)
	if akAbuser == PlayerRef
		return train_speed_player
	endif
	return train_speed_npc
EndFunction

int Function GetFeeForRecruiting(Actor akTarget)
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if rel >= 4  ; lovers will join for free
		return 0
	endif
	int rank = (akTarget.getFactionRank(DOMPotentialSlaverFaction))
	if rank <= 0
		return (-1)
	endif
	int amount = rank*100
	if rel > 1
		return amount / rel
	elseif rel < 0
		return amount * (-1) * rel
	endif
	return amount
EndFunction

bool Function IsWeaponCaptureAllowed(Actor akTarget)
	if akTarget == None
		return false
	endif
	if akTarget.HasKeyWord(ActorTypeAnimal)
		if !DOMKeys.forbidAnimalCapture ; Capture animals
			return true
		else
			return false
		endif
	endif
	if akTarget.HasKeyWord(ActorTypeCreature)
		if !DOMKeys.forbidCreatureCapture ; Capture creatures
			return true
		else
			return false
		endif
	endif
	if akTarget.HasKeyWord(ActorTypeUndead) && !akTarget.HasKeyWord(ActorTypeNPC)
		if !DOMKeys.forbidUndeadCapture ; Capture undead
			return true
		else
			return false
		endif
	endif

	ActorBase abTarget = akTarget.GetLeveledActorBase()
	if abTarget == None
		return false
	endif
	if !weaponsBToggle || !weaponsOToggle
		Race akRace  = abTarget.GetRace()
		if akRace != None
			if !weaponsBToggle && akRace.hasKeyword(IsBeastRace)
				return false
			endif
			if !weaponsOToggle
				string raceString = akRace.GetName()
				if(stringUtil.find(raceString,"Orc")>=0)
					return false
				endif
			endif
		endif
	endif
	If abTarget.GetSex() == 1
		If !weaponsFToggle
			return false
		endif
	elseIf !weaponsMToggle
		return false
	endif
	return true
EndFunction

; Kinks Settings

bool Property kinksFilterIsSet = false Auto Hidden
bool[] _kinksFilterFemale
bool[] Property kinksFilterFemale
	bool[] Function Get()
		if !_kinksFilterFemale
			_kinksFilterFemale = new bool[128] ; Valid kinks are 1 to 126
		endif
		return _kinksFilterFemale
	EndFunction
EndProperty
bool[] _kinksFilterMale
bool[] Property kinksFilterMale
	bool[] Function Get()
		if !_kinksFilterMale
			_kinksFilterMale = new bool[128] ; Valid kinks are 1 to 126
		endif
		return _kinksFilterMale
	EndFunction
EndProperty

Function SetFilterKink(int kink, int actorSex, bool value)
	if kink < 1 || kink > 126
		return
	endif
	if (actorSex%2) == 0
		_kinksFilterMale[kink] = value
	else
		_kinksFilterFemale[kink] = value
	endif
EndFunction

bool Function FilterKink(int kink, int actorSex, Actor akRef)
	if kink < 1 || kink > 126
		return false
	endif
	if akRef == PlayerRef 
		if kink < 100 && !kinksPlayerSubToggle
			return false
		endif
		if kink >= 100 && !kinksPlayerDomToggle
			return false
		endif
	elseif akRef != None
		if kink == 60 || kink == 64 || kink == 65 ; family kinks
			if akRef.GetLeveledActorBase().IsUnique() ; only for uniques
				if !akRef.HasFamilyRelationship()
					return false ; exclude actors without family relationship
				endif
			endif
		endif
		if kink == 57 ; creature kink
			if akRef.HasKeyword(ActorTypeCreature)
				return false
			endif
		endif
		if kink == 58 ; animal kink
			if akRef.HasKeyword(ActorTypeAnimal)
				return false
			endif
		endif
		if kink == 59 ; undead kink
			if akRef.HasKeyword(ActorTypeUndead) && !akRef.IsGhost()
				return false
			endif
		endif
	endif
	if (actorSex%2) == 0
		if !_kinksFilterMale
			return true
		endif
		return _kinksFilterMale[kink]
	else
		if !_kinksFilterFemale
			return true
		endif
		return _kinksFilterFemale[kink]
	endif
EndFunction

; Start-up
int Function GetVersion()
	return (DOMConfig.DOM_Version.getValue()) as int
EndFunction

string Property RACESEX_MENU = "RaceSex Menu" Auto Hidden
bool Property on_player_loadgame = false Auto Hidden
bool on_player_loadgame_failed = true
bool game_was_initialized = false
bool game_message_was_displayed = false
Event OnInit()
	LogInfo("OnInit() start game_was_initialized="+game_was_initialized+" RaceMenu open="+UI.IsMenuOpen(RACESEX_MENU)+" self="+self)
	if game_was_initialized
		return
	endif
	game_was_initialized = true
	wait(1.0)
	if UI.IsMenuOpen(RACESEX_MENU)
		LogInfo("OnInit() RaceMenu is open - Waiting...")
		while UI.IsMenuOpen(RACESEX_MENU)
			wait(1.0)
		endWhile
		LogInfo("OnInit() RaceMenu has finished - Continuing")
	endif
	LogInfo("OnInit() check game_was_initialized="+game_was_initialized+" on_player_loadgame="+on_player_loadgame+" on_player_loadgame_failed="+on_player_loadgame_failed)
	SetObjectiveDisplayed(0)
	;Wait(1.0)
	if !on_player_loadgame && on_player_loadgame_failed
		on_player_loadgame_failed = false
		LogInfo("OnInit() Calling OnPlayerLoadInit() from Init(): "+on_player_loadgame+" "+on_player_loadgame_failed)
		OnPlayerLoadInit()
	else
		LogInfo("OnInit() No need to call OnPlayerLoadInit()")
	endif
	RegisterForSingleUpdate(1.0)
	LogInfo("OnInit() DOM Initialization successful game_was_initialized="+game_was_initialized)
EndEvent

Function DisplayGameMessage()
	LogInfo("DisplayGameMessage() DOM Initialization successful game_was_initialized="+game_was_initialized+" RaceMenu open="+UI.IsMenuOpen(RACESEX_MENU)+" on_player_loadgame="+on_player_loadgame+" game_message_was_displayed="+game_message_was_displayed)
	if !on_player_loadgame && !game_message_was_displayed
		game_message_was_displayed = true
		if UI.IsMenuOpen(RACESEX_MENU)
			LogInfo("OnInit() RaceMenu is open - Waiting...")
			while UI.IsMenuOpen(RACESEX_MENU)
				wait(1.0)
			endWhile
			LogInfo("OnInit() RaceMenu has finished - Continuing")
		endif
		Debug.MessageBox("DOM Initialization successful. It is recommended you wait for all mods to finish initialization, save your game and reload before starting to play. Have fun in Skyrim and may you not forget the safe word.")
	endif
EndFunction

Event OnGameReload()
	LogInfo("OnGameReload() RaceMenu open="+UI.IsMenuOpen(RACESEX_MENU))
	wait(1.0)
	if UI.IsMenuOpen(RACESEX_MENU)
		LogInfo("OnGameReload() RaceMenu is open - Waiting...")
		while UI.IsMenuOpen(RACESEX_MENU)
			wait(1.0)
		endWhile
		LogInfo("OnGameReload() RaceMenu has finished - Continuing")
	endif
	if !on_player_loadgame && on_player_loadgame_failed
		on_player_loadgame_failed = false
		LogInfo("OnGameReload()Calling OnPlayerLoadInit() from OnGameReload(): "+on_player_loadgame+" "+on_player_loadgame_failed)
		OnPlayerLoadInit()
	else
		LogInfo("OnGameReload() No need to call OnPlayerLoadInit()")
	endif
	DOM04.NotifyLoadGame()
	RegisterForSingleUpdate(1.0)
EndEvent

Event OnPlayerLoadGame()
	on_player_loadgame_failed = false
	LogInfo("OnPlayerLoadGame() RaceMenu open="+UI.IsMenuOpen(RACESEX_MENU))
	if UI.IsMenuOpen(RACESEX_MENU)
		LogInfo("OnPlayerLoadGame() RaceMenu is open - Waiting...")
		while UI.IsMenuOpen(RACESEX_MENU)
			wait(1.0)
		endWhile
		LogInfo("OnPlayerLoadGame() RaceMenu has finished - Continuing")
	endif
	LogInfo("Calling OnPlayerLoadInit() from OnPlayerLoadGame(): "+on_player_loadgame+" "+on_player_loadgame_failed+" on_player_loadgame="+on_player_loadgame)
	OnPlayerLoadInit()
EndEvent

bool on_dom_init = true
Function OnPlayerLoadInit()
	; Run only once after load game
	if on_player_loadgame
		return
	endif
	on_player_loadgame = true
	on_update = true
	on_dom_init = true

	LogTrace("OnPlayerLoadInit RaceMenu open="+UI.IsMenuOpen(RACESEX_MENU))
	if UI.IsMenuOpen(RACESEX_MENU)
		LogInfo("WARNING: RaceMenu is open - Waiting...")
		while UI.IsMenuOpen(RACESEX_MENU)
			wait(1.0)
		endWhile
		LogInfo("WARNING: RaceMenu has finished - Continuing")
	endif

	; Pre-init
	if DOMPlayerAlias == None
		ReferenceAlias player_alias = GetAliasByName("PlayerAlias") as ReferenceAlias
		DOMPlayerAlias = player_alias as DOM_PlayerAlias
		LogInfo("WARNING: DOMPlayerAlias was not set - trying to recover DOMPlayerAlias="+DOMPlayerAlias)
	endif
	DOMPlayerAlias.PreInitializePlayer()
	; Banner
	LogInfo("================================================================================")
	LogInfo("==                                                                            ==")
	LogInfo("==                            Diary of Mine "+DOMVersionStr+"                            ==")
	LogInfo("==                          a PAHE extension by TAK                           ==")
	LogInfo("==                                                                            ==")
	LogInfo("================================================================================")
	LogInfo("Plugin version is: "+DOMConfig.DOM_Version.GetValue())
	if XMarkerForm == None
		LogInfo("WARNING: XMarkerForm was not set - Prepare to fly is this fix doesn't work")
		XMarkerForm = Game.GetFormFromFile(0x0000003B, "Skyrim.esm") As Form
		LogInfo("WARNING: XMarkerForm was reset to "+XMarkerForm)
	endif
	if DOMActionInContainer == None
		LogInfo("WARNING: DOMActionInContainer was not set")
		DOMActionInContainer = Game.GetFormFromFile(0x00103D96, "DiaryOfMine.esm") As Faction
	endif
	If (Game.GetModByName("AmazingFollowerTweaks.esp") != 255)
		pTweakWaitingFaction = Game.GetFormFromFile(0x00032CCB, "AmazingFollowerTweaks.esp") as Faction
	else
		pTweakWaitingFaction = None
	endif
	; Fill string arrays
	SetJSONPunishmentTypes()
	SetJSONPraisingTypes()
	SetJSONPunishmentReasons()
	SetJSONPraisingReasons()
	SetJSONKinkReasons()
	; Generator
	DOMGenerator.Initialize()
	; Ensure PAH has started
	DOMPAH.Initialize()
	DOMPAH.EnsurePAHStarted()
	; API
	if DOMAPI == None
		DOMAPI = Game.GetFormFromFile(0x00000D61, "DiaryOfMine.esm") as DOM_API ; DOM01
	endif
	DOMAPI.Initialize()
	; Equipment
	DOMEquip.Initialize()
	; Zaz
	DOMZaz.Initialize()
	; DD
	DOMZad.Initialize()
	; SexLab
	DOMSexlab.Initialize()
	; Ostim
	if DOMOstim == None
		DOMOstim = Game.GetFormFromFile(0x000ED87C, "DiaryOfMine.esm") as DOM_Ostim ; DOM02
	endif
	DOMOstim.Initialize()
	if DOMOstim.DOM_HasOstim.GetValue() == 0
		DOMSexlab.startSexlabPreferablyPlayer = true
		DOMSexlab.startSexlabPreferablyNPC = true
		DOMSexlab.startSexlabPreferablyDOM = true
	elseif DOMSexlab.DOM_HasSexlab.GetValue() == 0
		DOMSexlab.startSexlabPreferablyPlayer = false
		DOMSexlab.startSexlabPreferablyNPC = false
		DOMSexlab.startSexlabPreferablyDOM = false
	endif
	; Bathing
	DOMBath.Initialize()
	; Animator
	DOM_Anim.Initialize()
	; Banner 2
	LogInfo("================================================================================")
	LogInfo("==                                 DOM: Core                                  ==")
	LogInfo("================================================================================")
	Initialize()
	; Initialize player alias
	LogTrace("Initialize DOMPlayerAlias")
	DOMPlayerAlias.Initialize()
	;LogTrace("DOM04 starting="+DOM04.IsStarting()+" running="+DOM04.IsRunning()+" stage="+DOM04.GetStage())
	LogTrace("Initialize DOMDiary")
	DOM04.Initialize()
	DOM02.Initialize(0) ; default slave manager index is 0
	SetFollowCounters()
	DOM01.Initialize()
	DOMKeys.Initialize()
	If (Game.GetModByName("PAH_AndYouGetASlave.esp") != 255)
		DOMAYGAS = Game.GetFormFromFile(0x0000182B, "PAH_AndYouGetASlave.esp") as AYGASInterface
		DOMAYGAS.Initialize()
	else
		DOMAYGAS = None
	endif
	If (Game.GetModByName("PAH_HomeSweetHome.esp") != 255)
		DOMHSH = Game.GetFormFromFile(0x00008402, "PAH_HomeSweetHome.esp") as PHHSHInterface
		DOMHSH.Initialize()
	else
		DOMHSH = None
	endif
	ReCheck()
	if attentionPose == salutePose
		attentionPose = "ZapKneelDisplay"
		if salutePose == "ZapKneelDisplay"
			salutePose = "IdleHandsBehindBack"
		endif
	endif
	actor_in_dialogue = None
	on_player_loadgame = false
	on_update = false
	on_dom_init = false
	DisplayGameMessage()
	LogTrace("Init done")
EndFunction

bool Function isOnDOMInit()
	return on_dom_init
EndFunction

bool recheck_is_done = false
Function ReCheck()
	if recheck_is_done
		return
	endif
	recheck_is_done = true
	DOM01.ReCheck()
	DOM02.ReCheck()
EndFunction

Function ClearAliases(Actor akRef)
	if fSlave.GetActorRef() == akRef
		fSlave.Clear()
	endif
	NPCClearForceGreet(akRef)
	DOM01.ClearAliases(akRef)
	DOM02.ClearAliases(akRef)
	DOMKeys.ClearAliases(akRef)
EndFunction

Function SendBootstrapEvents()
	string eName = "DOMBootstrap"
	DOM01.RegisterForBootstrap(eName)
	DOM02.RegisterForBootstrap(eName)
	SendModEvent(eName)
EndFunction

bool on_update = false
Event OnUpdate()
	;LogTrace("OnUpdate on_update="+on_update+" blocked="+is_dialogue_global_blocked_for+" weather blocked="+is_weather_dialogue_global_blocked_for)
	if on_update
		return
	endif
	on_update = true
	if is_dialogue_global_blocked_for > 0
		is_dialogue_global_blocked_for -= 1
		if is_dialogue_global_blocked_for > delayTopicGlobal*2
			is_dialogue_global_blocked_for = delayTopicGlobal*2
		endif
	endif
	if is_weather_dialogue_global_blocked_for > 0
		is_weather_dialogue_global_blocked_for -= 1
		if is_weather_dialogue_global_blocked_for > delayTopicGlobal*4
			is_weather_dialogue_global_blocked_for = delayTopicGlobal*4
		endif
	endif
	RegisterForSingleUpdate(actorUpdateTimerGlobal)
	on_update = false
EndEvent

Event OnBootstrap()
	RegisterForSingleUpdate(0.5)
	SetObjectiveDisplayed(0)
	OnPlayerLoadGame()
EndEvent

int Function GetActorType(Actor akRef)
	if akRef.HasKeyword(ActorTypeCreature)
		return 2; Creature
	elseif akRef.HasKeyword(ActorTypeAnimal)
		return 1 ; Animal
	elseif akRef.HasKeyword(ActorTypeNPC)
		return 0 ; NPC
	endif
	return 2; Creature or something else
EndFunction

int Function GetActorRace(Actor akRef) ; 10 = Human, 20 = Elf, 30 = Orc, 40 = Khajiit, 50 = Argonian, 60 = Gods and Demons
	if !akRef.HasKeyword(ActorTypeNPC)
		return 0 ; Not an NPC
	elseif akRef.HasKeyword(ActorTypeCreature)
		actorBase abRef = akRef.GetLeveledActorBase()
		Race ActorRace  = abRef.GetRace()
		string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
		if(stringUtil.find(raceString,"Daedra")>=0)
			return 60
		elseif(stringUtil.find(raceString,"Succubus")>=0)
			return 61
		endif
		return 5; Creature
	elseif akRef.HasKeyword(ActorTypeAnimal)
		return 9 ; Animal
	endif
	actorBase abRef = akRef.GetLeveledActorBase()
	Race ActorRace  = abRef.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	
	if(stringUtil.find(raceString,"Nord")>=0)
		return 11
	elseif(stringUtil.find(raceString,"Redguard")>=0)
		return 15
	elseif(stringUtil.find(raceString,"Imperial")>=0)
		return 16
	elseif(stringUtil.find(raceString,"Breton")>=0)
		return 19
	elseif(stringUtil.find(raceString,"Wood Elf")>=0)
		return 20
	elseif(stringUtil.find(raceString,"Snow Elf")>=0)
		return 21
	elseif(stringUtil.find(raceString,"High Elf")>=0)
		return 26
	elseif(stringUtil.find(raceString,"Dark Elf")>=0)
		return 27
	elseif(stringUtil.find(raceString,"Orc")>=0)
		return 32
	elseif(stringUtil.find(raceString,"Khajiit")>=0)
		return 40
	elseif(stringUtil.find(raceString,"Argonian")>=0)
		return 50
	elseif(stringUtil.find(raceString,"Daedra")>=0)
		return 60
	elseif(stringUtil.find(raceString,"Succubus")>=0)
		return 61
	endif

	return 10; Default human
EndFunction

int Function GetActorGender(Actor akRef, int actorType = 0)
	if akRef.IsInFaction(DOMActorGender)
		;if ((akRef.GetFactionRank(DOMActorGender)) % 2) != (actorSex % 2)
			;LogTrace("GetActorGender DOM gender for "+akRef.GetDisplayName()+" changed from "+ actorSex + " to PAH gender " + akRef.GetFactionRank(DOMActorGender))
			return akRef.GetFactionRank(DOMActorGender)
		;endif
	endif
	int actorSex = DOMSexlab.GetGender(akRef)
	if actorType != 0
		actorSex += 2 ; Creature or animal
	endif
	akRef.SetFactionRank(DOMActorGender,actorSex)
	;LogTrace("GetActorGender DOM gender for "+akRef.GetDisplayName()+" is "+ actorSex + " actorType="+actorType)
	return actorSex
EndFunction

int Function GetActorGenderByString(Actor akRef, string str_gender, int actorType = 0)
	int actorSex
	if str_gender == "male"
		actorSex = 0
	elseif str_gender == "female"
		actorSex = 1
	elseif str_gender == "treat as male"
		actorSex = 4
	elseif str_gender == "treat as female"
		actorSex = 5
	elseif str_gender == "other"
		actorSex = 6 + akRef.GetLeveledActorBase().GetSex()
	else
		actorSex  = akRef.GetLeveledActorBase().GetSex()
	endif
	if actorType != 0 && actorSex < 6
		actorSex += 2 ; Creature = 2, 3, 6, 7
	endif
	LogTrace(" DOM gender for "+akRef.GetDisplayName()+" is "+ actorSex + " actorType="+actorType)
	return actorSex
EndFunction

Function Initialize()
	Logtrace("Initialize start")
	Logtrace(self as string)
	SetStrMessages()
	if DOMNbKinkTrigger == None
		DOMNbKinkTrigger = Game.GetFormFromFile(0x00DB1220, "DiaryOfMine.esm") as Faction
	endif
	if DOMNbSexWithOthers == None
		DOMNbSexWithOthers = Game.GetFormFromFile(0x00DB1221, "DiaryOfMine.esm") as Faction
	endif
	if DOMNbSexForMoney == None
		DOMNbSexForMoney = Game.GetFormFromFile(0x00DB1222, "DiaryOfMine.esm") as Faction
	endif
	if DOMGenerator == None
		DOMGenerator = Game.GetFormFromFile(0x000ED87C, "DiaryOfMine.esm") as DOM_Generator
	endif
	
	;LogTrace("Initialize: Check  DOMShouldWalkOnFour="+DOMShouldWalkOnFour)
	DOMShouldWalkOnFour = Game.GetFormFromFile(0x000EF973, "DiaryOfMine.esm") As Faction
	;LogTrace("Initialize: Assign DOMShouldWalkOnFour="+DOMShouldWalkOnFour)
	;LogTrace("Initialize: Check  DOMIsWalkingOnFour="+DOMIsWalkingOnFour)
	DOMIsWalkingOnFour  = Game.GetFormFromFile(0x000EF972, "DiaryOfMine.esm") As Faction
	;LogTrace("Initialize: Assign DOMIsWalkingOnFour="+DOMIsWalkingOnFour)
	
	; Optionnal properties from add-ons
	If (Game.GetModByName("PAH_AndYouGetASlave.esp") != 255)
		LogTrace("AYGAS Found!")
		AygasSlaveTypeFaction = Game.GetFormFromFile(0x000048E2, "PAH_AndYouGetASlave.esp") as Faction
	else
		AygasSlaveTypeFaction = None
	endif
	If (Game.GetModByName("PAH_HomeSweetHome.esp") != 255)
		LogTrace("HSH Found!")
		HshHouseSlaveFaction = Game.GetFormFromFile(0x008972, "PAH_HomeSweetHome.esp") As Faction
		HSHFlexi = Game.GetFormFromFile(0x00059A2A, "PAH_HomeSweetHome.esp") As PHHSHFlexiStorage
		HSHStorage = Game.GetFormFromFile(0x00008402, "PAH_HomeSweetHome.esp") As PHHSHStorageFunctions
		PAHO = Game.GetFormFromFile(0x00003900, "PAH_HomeSweetHome.esp") As PAHOCore
		if PAHO != None
			if PAHO.PrisonerQst != None
				PAHO.PrisonerQst.RestoreSlavery()
			endif
		endif
	else
		HshHouseSlaveFaction = None
		HSHFlexi = None
		HSHStorage = None
		PAHO = None
	endif
	If (Game.GetModByName("HydraSlaveFaction.esp") != 255)
		LogTrace("HydraSlave Found!")
		HydraSlaveFaction = Game.GetFormFromFile(0x0EBC66, "HydraSlaveFaction.esp") As Faction
	else
		HydraSlaveFaction = None
	endif
	If (Game.GetModByName("SexSlavesForVanillaBandits.esp") != 255)
		VanillaBanditsSlaveFaction = Game.GetFormFromFile(0xD65, "SexSlavesForVanillaBandits.esp") As Faction
		VanillaBanditsExSlaveFaction = Game.GetFormFromFile(0xD6B, "SexSlavesForVanillaBandits.esp") As Faction
	elseIf (Game.GetModByName("HydraSlaveFaction.esp") != 255)
		VanillaBanditsSlaveFaction = Game.GetFormFromFile(0xD65, "MoreBanditCamps - SexSlaves.esp") As Faction
		VanillaBanditsExSlaveFaction = Game.GetFormFromFile(0xD6B, "MoreBanditCamps - SexSlaves.esp") As Faction
	else
		VanillaBanditsSlaveFaction = None
		VanillaBanditsExSlaveFaction = None
	endif
	If (Game.GetModByName("Immersive Wenches.esp") != 255)
		LogTrace("ImmersiveWenches Found!")
		TravellingWenchesFaction = Game.GetFormFromFile(0x00218F2, "Immersive Wenches.esp") As Faction
		TravellingWenchesServantFaction = Game.GetFormFromFile(0x024FCE, "Immersive Wenches.esp") As Faction
		TravellingWenchesPatrolFaction = Game.GetFormFromFile(0x031918, "Immersive Wenches.esp") As Faction
		If (Game.GetModByName("Judgment Wenches.esp") != 255)
			TravellingWenchesJudgementFaction = Game.GetFormFromFile(0x000A12, "Judgment Wenches.esp") As Faction ;"wenchminators" [FACT:10000A12]
			TravellingWenchesCollectedFaction = Game.GetFormFromFile(0x000A05, "Judgment Wenches.esp") As Faction ; "Collected Female" [FACT:10000A05]
		else
			TravellingWenchesJudgementFaction = None
			TravellingWenchesCollectedFaction = None
		endif
	else
		TravellingWenchesFaction = None
		TravellingWenchesServantFaction = None
		TravellingWenchesPatrolFaction = None
	endif
	If (Game.GetModByName("Modesty_Keyword.esp") != 255)
		NoModestyKeyword = (Game.GetFormFromFile(0x00000D99 , "Modesty_Keyword.esp") As keyword)
	else
		NoModestyKeyword = None
	endif
 	If (Game.GetModByName("OBIS SE.esp") != 255)
		OBISFaction = Game.GetFormFromFile(0x000FD4, "OBIS SE.esp") As Faction
		ObisGlowingPearl = Game.GetFormFromFile(0x000FA8, "OBIS SE.esp") As Ingredient
	elseIf (Game.GetModByName("Obis.esp") != 255)
		OBISFaction = Game.GetFormFromFile(0x01AE24, "Obis.esp") As Faction
		ObisGlowingPearl = None
	else
		OBISFaction = None
		ObisGlowingPearl = None		
	endif
	MagicDamageWater = Keyword.GetKeyword("MagicDamageWater")
	if MagicDamageWater != None
		if !DOMHoseAimed.HasKeyword(MagicDamageWater)
			PO3_SKSEFunctions.AddKeywordToForm(DOMHoseAimed,MagicDamageWater)
		endif
		if !DOMHoseProjectile.HasKeyword(MagicDamageWater)
			PO3_SKSEFunctions.AddKeywordToForm(DOMHoseProjectile,MagicDamageWater)
		endif
	endif
	if MagicWater == None
		MagicWater = Keyword.GetKeyword("MagicWater")
	endif
	
	Logtrace("Initialize kinks")
	if !kinksFilterIsSet
		int i = 0
		int n = kinksFilterFemale.length
		while i < n
			_kinksFilterFemale[i] = true
			i += 1
		endwhile
		i = 0
		n = kinksFilterMale.length
		while i < n
			_kinksFilterMale[i] = true
			i += 1
		endwhile
		kinksFilterIsSet = true
	endif
	;wait(1.0)
	InitMessageWidgets(HorizontalAnchor,verticalAnchor)
	UpdateAlcoholList()
	CheckPlayersEquipment()
	RegisterSpells()
	RegisterPerks()
	SlaveTats.compile_cache()
	Logtrace("Initialize factions")
	WriteSaveFactions()
	ReadSaveFactions()
	Logtrace("Initialize events")
	RegisterModEvents()
	Logtrace("Initialize update")
	RegisterForSingleUpdate(1.0)
	Logtrace("Initialize done")
EndFunction

string   g_kink_last_read_key   = ""
string   g_kink_fileName = "Diary Of Mine/KinkReasons.json"
string   g_kink_basePath = "kinksList"
String[] g_kink_keys
String[] g_kink_reasonsF
String[] g_kink_reasonsM
String[] g_kink_last_read_stats
String[] g_kink_last_read_mod   
Float[]  g_kink_last_read_values

Function SetJSONKinkReasons()
	if !JsonUtil.JsonExists(g_kink_fileName)
		LogTrace("SetJSONKinkReasons: ERROR Could not find file "+g_kink_fileName)
		return
	endif
	
	g_kink_last_read_key = ""

	int nkeys = JsonUtil.PathCount(g_kink_fileName, g_kink_basePath) 
	g_kink_keys     =  JsonUtil.PathMembers(g_kink_fileName, g_kink_basePath)
	g_kink_reasonsF =  JsonUtil.PathMembers(g_kink_fileName, g_kink_basePath)
	g_kink_reasonsM =  JsonUtil.PathMembers(g_kink_fileName, g_kink_basePath)
	
	int n = g_kink_keys.length
	LogInfo("SetJSONKinkReasons: Found "+nkeys+" entries in array of size "+n)
	int i = 0
	while i < n
		string the_key   = g_kink_keys[i]
		string the_nameF = GetJSONKinkReasonName(the_key)
		string the_nameM = GetJSONKinkReasonNameForMales(the_key)
		g_kink_reasonsF[i] = the_nameF
		g_kink_reasonsM[i] = the_nameM
		i += 1
	endwhile
	i = 0
	while i < n
		LogTrace("SetJSONKinkReasons: "+i+" Found key="+ g_kink_keys[i]+" reason="+g_kink_reasonsF[i]+"/"+g_kink_reasonsM[i])
		i += 1
	endwhile
EndFunction

Int Function GetJSONNumberOfKinkReasons()
	return g_kink_keys.length
EndFunction

Int Function GetJSONKinkReasonIndexByName(string the_reason)
	if the_reason == ""
		return 0
	endif
	int n = g_kink_keys.length
	int i = 0
	while i < n
		if the_reason == g_kink_reasonsF[i]
			return i
		endif
		i += 1
	endwhile
	i = 0
	while i < n
		if the_reason == g_kink_reasonsM[i]
			return i
		endif
		i += 1
	endwhile
	LogInfo("ERROR: Could not find kink reason index for="+the_reason)
	return 0
EndFunction
String Function GetJSONKinkReasonNameByIndex(int index, int actorSex)
	if index >= 0 && index < g_kink_keys.length
		if (actorSex %2)==1
			return g_kink_reasonsF[index]
		else
			return g_kink_reasonsM[index]
		endif
	endif
	if index < 0 || index >= g_kink_keys.Length
		LogInfo("ERROR: Could not read kink reason with index="+index)
		return GetJSONKinkReasonName("Kink000")
	endif
	if (actorSex %2)==1
		return GetJSONKinkReasonName(g_kink_keys[index])
	endif
	return GetJSONKinkReasonNameForMales(g_kink_keys[index])
EndFunction
String Function GetJSONKinkReasonName(string the_key)
	return JsonUtil.GetPathStringValue(g_kink_fileName, g_kink_basePath + "."+ the_key + ".reason")
EndFunction
String Function GetJSONKinkReasonNameForMales(string the_key)
	string reason_male = JsonUtil.GetPathStringValue(g_kink_fileName, g_kink_basePath + "."+ the_key + ".reason_male")
	if reason_male != ""
		return reason_male
	endif
	return GetJSONKinkReasonName(the_key)
EndFunction

String Function GetJSONKinkArousalModifierByIndex(int index)
	LogTrace("GetJSONKinkArousalModifierByIndex: index="+index+" length="+g_kink_keys.Length)
	if index < 0 || index >= g_kink_keys.Length
		LogInfo("ERROR: Could not read kink modifier with index="+index)
		return GetJSONKinkArousalModifier("Kink000")
	endif
	LogTrace("GetJSONKinkArousalModifierByIndex: index="+index+" key="+g_kink_keys[index])
	string the_mod = GetJSONKinkArousalModifier(g_kink_keys[index])
	LogTrace("GetJSONKinkArousalModifierByIndex: index="+index+" mod="+the_mod)
	return the_mod
EndFunction
String Function GetJSONKinkArousalModifier(string the_key)
	LogTrace("GetJSONKinkArousalModifier: key="+the_key+" last_key="+g_kink_last_read_key)
	if the_key != g_kink_last_read_key
		g_kink_last_read_key    = the_key
		g_kink_last_read_mod    = JsonUtil.PathStringElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".modifier")
		g_kink_last_read_values = JsonUtil.PathFloatElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".values")
		g_kink_last_read_stats  = JsonUtil.PathStringElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".stats")
	endif
	if !g_kink_last_read_mod
		return ""
	endif
	if g_kink_last_read_mod.length < 1
		return ""
	endif
	return g_kink_last_read_mod[0] 
EndFunction

Float[] Function GetJSONKinkTrainingValuesByIndex(int index)
	if index < 0 || index >= g_kink_keys.Length
		LogInfo("ERROR: Could not read kink values with index="+index)
		return GetJSONKinkTrainingValues("Kink000")
	endif
	return GetJSONKinkTrainingValues(g_kink_keys[index])
EndFunction
Float[] Function GetJSONKinkTrainingValues(string the_key)
	if the_key != g_kink_last_read_key
		g_kink_last_read_key    = the_key
		g_kink_last_read_mod    = JsonUtil.PathStringElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".modifier")
		g_kink_last_read_values = JsonUtil.PathFloatElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".values")
		g_kink_last_read_stats  = JsonUtil.PathStringElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".stats")
		if !g_kink_last_read_values
			LogInfo("ERROR: Could not read kink values with key="+the_key)
		endif
	endif
	return g_kink_last_read_values
EndFunction

String[] Function GetJSONKinkTrainingStatsByIndex(int index)
	if index < 0 || index >= g_kink_keys.Length
		LogInfo("ERROR: Could not read kink stats with index="+index)
		return GetJSONKinkTrainingStats("Kink000")
	endif
	return GetJSONKinkTrainingStats(g_kink_keys[index])
EndFunction
String[] Function GetJSONKinkTrainingStats(string the_key, bool do_check=true)
	if the_key != g_kink_last_read_key
		g_kink_last_read_key    = the_key
		g_kink_last_read_mod    = JsonUtil.PathStringElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".modifier")
		g_kink_last_read_values = JsonUtil.PathFloatElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".values")
		g_kink_last_read_stats  = JsonUtil.PathStringElements(g_kink_fileName, g_kink_basePath + "."+ the_key + ".stats")
		if !g_kink_last_read_stats
			LogInfo("ERROR: Could not read kink stats with key="+the_key)
		endif
	endif
	return g_kink_last_read_stats
EndFunction

string   g_praisetype_fileName = "Diary Of Mine/PraisingTypes.json"
string   g_praisetype_fileName2 = "Diary Of Mine/PraisingTypes.json"
string   g_praisetype_basePath = "praiseTypes"
String[] g_praisetype_keys
String[] Property g_praisetype_names Auto Hidden
String[] g_praisetype_desc1
String[] g_praisetype_desc2
String[] g_praisetype_anim1
String[] g_praisetype_anim2

Int Function GetJSONNumberOfPraisingTypes()
	return g_praisetype_keys.length
EndFunction
Function SetJSONPraisingTypes()
	if !JsonUtil.JsonExists(g_praisetype_fileName2)
		LogTrace("SetJSONPraisingTypes: ERROR Could not find file "+g_praisetype_fileName2)
		if !JsonUtil.JsonExists(g_praisetype_fileName)
			LogTrace("SetJSONPraisingTypes: ERROR Could not find file "+g_praisetype_fileName)
			return
		endif
		g_praisetype_fileName2 = g_praisetype_fileName
	endif

	g_praisetype_fileName = g_praisetype_fileName2
	LogTrace("SetJSONPraisingTypes: Reading file "+g_praisetype_fileName)
	
	int nkeys = JsonUtil.PathCount(g_praisetype_fileName, g_praisetype_basePath) 
	g_praisetype_keys  =  JsonUtil.PathMembers(g_praisetype_fileName, g_praisetype_basePath)
	g_praisetype_names =  JsonUtil.PathMembers(g_praisetype_fileName, g_praisetype_basePath)
	g_praisetype_desc1 =  JsonUtil.PathMembers(g_praisetype_fileName, g_praisetype_basePath)
	g_praisetype_desc2 =  JsonUtil.PathMembers(g_praisetype_fileName, g_praisetype_basePath)
	g_praisetype_anim1 =  JsonUtil.PathMembers(g_praisetype_fileName, g_praisetype_basePath)
	g_praisetype_anim2 =  JsonUtil.PathMembers(g_praisetype_fileName, g_praisetype_basePath)
	
	int n = g_praisetype_keys.length
	LogInfo("SetJSONPraisingTypes: Found "+nkeys+" entries in array of size "+n)
	int i = 0
	while i < n
		string the_key   = g_praisetype_keys[i]
		string the_name  = GetJSONPraisingTypeName(the_key)
		string the_desc1 = GetJSONPraisingTypeDescription(the_key)
		string the_desc2 = GetJSONPraisingTypeText(the_key)
		string the_anim1 = GetJSONPraisingTypeAnim(the_key)
		string the_anim2 = GetJSONPraisingTypeAnimBounded(the_key)
		g_praisetype_names[i] = the_name
		g_praisetype_desc1[i] = the_desc1
		g_praisetype_desc2[i] = the_desc2
		g_praisetype_anim1[i] = the_anim1
		g_praisetype_anim2[i] = the_anim2
		i += 1
	endwhile
	i = 0
	while i < n
		LogTrace("SetJSONPraisingTypes: "+i+" Found key="+ g_praisetype_keys[i]+" name="+g_praisetype_names[i]+" anim="+g_praisetype_anim1[i]+"/"+g_praisetype_anim2[i]+" desc="+g_praisetype_desc1[i]+" text="+g_praisetype_desc2[i])
		i += 1
	endwhile
EndFunction

string Function GetJSONPraisingTypeDescriptionByName(string type)
	int index = GetJSONPraisingTypeIndexByName(type)
	return GetJSONPraisingTypeDescriptionByIndex(index)
EndFunction
string Function GetJSONPraisingTypeDescriptionByIndex(int index)
	if index >= 0 && index < g_praisetype_desc1.length
		return g_praisetype_desc1[index]
	endif
	LogInfo("ERROR: Could not read praise type desc with index="+index)
	if g_praisetype_desc1.Length > 0
		return g_praisetype_desc1[0]
	endif
	return ""
EndFunction
String Function GetJSONPraisingTypeDescription(string the_key)
	return JsonUtil.GetPathStringValue(g_praisetype_fileName, g_praisetype_basePath + "."+ the_key + ".desc")
EndFunction
string Function GetJSONPraisingTypeTextByName(string type)
	int index = GetJSONPraisingTypeIndexByName(type)
	return GetJSONPraisingTypeTextByIndex(index)
EndFunction
string Function GetJSONPraisingTypeTextByIndex(int index)
	if index >= 0 && index < g_praisetype_desc2.length
		return g_praisetype_desc2[index]
	endif
	LogInfo("ERROR: Could not read praise type text with index="+index)
	if g_praisetype_desc2.Length > 0
		return g_praisetype_desc2[0]
	endif
	return "tell"
EndFunction
String Function GetJSONPraisingTypeText(string the_key)
	return JsonUtil.GetPathStringValue(g_praisetype_fileName, g_praisetype_basePath + "."+ the_key + ".text")
EndFunction
int Function GetJSONPraisingTypeIndexByName(string the_name)
	int n = g_praisetype_names.length
	if n <= 1
		return 0
	endif
	int i = 0
	while i < n
		if the_name == g_praisetype_names[i]
			return i
		endif
		i += 1
	endwhile
	return 0
EndFunction
String Function GetJSONPraisingTypeNameByIndex(int index)
	if index >= 0 && index < g_praisetype_names.length
		return g_praisetype_names[index]
	endif
	LogInfo("ERROR: Could not read praise type with index="+index)
	if g_praisetype_names.Length > 0
		return g_praisetype_names[0]
	endif
	return "scold"
EndFunction
String Function GetJSONPraisingTypeName(string the_key)
	return JsonUtil.GetPathStringValue(g_praisetype_fileName, g_praisetype_basePath + "."+ the_key + ".name")
EndFunction
String Function GetJSONPraisingTypeAnimByIndex(int index)
	if index >= 0 && index < g_praisetype_anim1.length
		return g_praisetype_anim1[index]
	endif
	LogInfo("ERROR: Could not read praise type anim 1 with index="+index)
	if g_praisetype_anim1.Length > 0
		return g_praisetype_anim1[0]
	endif
	return ""
EndFunction
String Function GetJSONPraisingTypeAnim(string the_key)
	return JsonUtil.GetPathStringValue(g_praisetype_fileName, g_praisetype_basePath + "."+ the_key + ".animation1")
EndFunction
String Function GetJSONPraisingTypeAnimBoundedByIndex(int index)
	if index >= 0 && index < g_praisetype_anim2.length
		return g_praisetype_anim2[index]
	endif
	LogInfo("ERROR: Could not read praise type anim 2 with index="+index)
	if g_praisetype_anim2.Length > 0
		return g_praisetype_anim2[0]
	endif
	return ""
EndFunction
String Function GetJSONPraisingTypeAnimBounded(string the_key)
	return JsonUtil.GetPathStringValue(g_praisetype_fileName, g_praisetype_basePath + "."+ the_key + ".animation2")
EndFunction

string   g_punishtype_fileName = "Diary Of Mine/PunishmentTypes.json"
string   g_punishtype_basePath = "punishmentTypes"
String[] g_punishtype_keys
String[] Property g_punishtype_names Auto Hidden
String[] g_punishtype_desc1
String[] g_punishtype_desc2
String[] g_punishtype_tats1
String[] g_punishtype_tats2
String[] g_punishtype_anim1
String[] g_punishtype_anim2

Int Function GetJSONNumberOfPunishmentTypes()
	return g_punishtype_keys.length
EndFunction

Function SetJSONPunishmentTypes()
	if !JsonUtil.JsonExists(g_punishtype_fileName)
		LogTrace("SetJSONPunishmentTypes: ERROR Could not find file "+g_punishtype_fileName)
		return
	endif

	int nkeys = JsonUtil.PathCount(g_punishtype_fileName, g_punishtype_basePath) 
	g_punishtype_keys  =  JsonUtil.PathMembers(g_punishtype_fileName, g_punishtype_basePath)
	g_punishtype_names =  JsonUtil.PathMembers(g_punishtype_fileName, g_punishtype_basePath)
	g_punishtype_desc1 =  JsonUtil.PathMembers(g_punishtype_fileName, g_punishtype_basePath)
	g_punishtype_desc2 =  JsonUtil.PathMembers(g_punishtype_fileName, g_punishtype_basePath)
	g_punishtype_tats1 =  JsonUtil.PathMembers(g_punishtype_fileName, g_punishtype_basePath)
	g_punishtype_tats2 =  JsonUtil.PathMembers(g_punishtype_fileName, g_punishtype_basePath)
	g_punishtype_anim1 =  JsonUtil.PathMembers(g_punishtype_fileName, g_punishtype_basePath)
	g_punishtype_anim2 =  JsonUtil.PathMembers(g_punishtype_fileName, g_punishtype_basePath)
	
	int n = g_punishtype_keys.length
	LogInfo("SetJSONPunishmentTypes: Found "+nkeys+" entries in array of size "+n)
	int i = 0
	while i < n
		string the_key   = g_punishtype_keys[i]
		string the_name  = GetJSONPunishmentTypeName(the_key)
		string the_desc1 = GetJSONPunishmentTypeDescription(the_key)
		string the_desc2 = GetJSONPunishmentTypeText(the_key)
		string the_tats1 = GetJSONPunishmentTypeTats(the_key)
		string the_tats2 = GetJSONPunishmentTypeTatsBounded(the_key)
		string the_anim1 = GetJSONPunishmentTypeAnim(the_key)
		string the_anim2 = GetJSONPunishmentTypeAnimBounded(the_key)
		g_punishtype_names[i] = the_name
		g_punishtype_desc1[i] = the_desc1
		g_punishtype_desc2[i] = the_desc2
		g_punishtype_tats1[i] = the_tats1
		g_punishtype_tats2[i] = the_tats2
		g_punishtype_anim1[i] = the_anim1
		g_punishtype_anim2[i] = the_anim2
		i += 1
	endwhile
	i = 0
	while i < n
		LogTrace("SetJSONPunishmentTypes: "+i+" Found key="+ g_punishtype_keys[i]+" name="+g_punishtype_names[i]+" tats="+g_punishtype_tats1[i]+"/"+g_punishtype_tats2[i]+" anim="+g_punishtype_anim1[i]+"/"+g_punishtype_anim2[i]+" desc="+g_punishtype_desc1[i]+" text="+g_punishtype_desc2[i])
		i += 1
	endwhile
EndFunction

int Function GetJSONPunishmentTypeIndexByName(string the_name)
	int n = g_punishtype_names.length
	if n <= 1
		return 0
	endif
	int i = 0
	while i < n
		if the_name == g_punishtype_names[i]
			return i
		endif
		i += 1
	endwhile
	return 0
EndFunction
String Function GetJSONPunishmentTypeNameByIndex(int index)
	if index >= 0 && index < g_punishtype_names.length
		return g_punishtype_names[index]
	endif
	LogInfo("ERROR: Could not read punishment type with index="+index)
	if g_punishtype_names.Length > 0
		return g_punishtype_names[0]
	endif
	return "scold"
EndFunction
String Function GetJSONPunishmentTypeName(string the_key)
	return JsonUtil.GetPathStringValue(g_punishtype_fileName, g_punishtype_basePath + "."+ the_key + ".name")
EndFunction
string Function GetJSONPunishmentTypeDescriptionByName(string type)
	int index = GetJSONPunishmentTypeIndexByName(type)
	return GetJSONPunishmentTypeDescriptionByIndex(index)
EndFunction
string Function GetJSONPunishmentTypeDescriptionByIndex(int index)
	if index >= 0 && index < g_punishtype_desc1.length
		return g_punishtype_desc1[index]
	endif
	LogInfo("ERROR: Could not read praise type desc with index="+index)
	if g_punishtype_desc1.Length > 0
		return g_punishtype_desc1[0]
	endif
	return ""
EndFunction
String Function GetJSONPunishmentTypeDescription(string the_key)
	return JsonUtil.GetPathStringValue(g_punishtype_fileName, g_punishtype_basePath + "."+ the_key + ".desc")
EndFunction
string Function GetJSONPunishmentTypeTextByName(string type)
	int index = GetJSONPunishmentTypeIndexByName(type)
	return GetJSONPunishmentTypeTextByIndex(index)
EndFunction
string Function GetJSONPunishmentTypeTextByIndex(int index)
	if index >= 0 && index < g_punishtype_desc2.length
		return g_punishtype_desc2[index]
	endif
	LogInfo("ERROR: Could not read punishment type text with index="+index)
	if g_punishtype_desc2.Length > 0
		return g_punishtype_desc2[0]
	endif
	return ""
EndFunction
String Function GetJSONPunishmentTypeText(string the_key)
	return JsonUtil.GetPathStringValue(g_punishtype_fileName, g_punishtype_basePath + "."+ the_key + ".text")
EndFunction
String Function GetJSONPunishmentTypeTatsByIndex(int index)
	if index >= 0 && index < g_punishtype_tats1.length
		return g_punishtype_tats1[index]
	endif
	LogInfo("ERROR: Could not read punishment type tats 1 with index="+index)
	if g_punishtype_tats1.Length > 0
		return g_punishtype_tats1[0]
	endif
	return ""
EndFunction
String Function GetJSONPunishmentTypeTats(string the_key)
	return JsonUtil.GetPathStringValue(g_punishtype_fileName, g_punishtype_basePath + "."+ the_key + ".tat1")
EndFunction
String Function GetJSONPunishmentTypeTatsBoundedByIndex(int index)
	if index >= 0 && index < g_punishtype_tats2.length
		return g_punishtype_tats2[index]
	endif
	LogInfo("ERROR: Could not read punishment type tats 2 with index="+index)
	if g_punishtype_tats2.Length > 0
		return g_punishtype_tats2[0]
	endif
	return ""
EndFunction
String Function GetJSONPunishmentTypeTatsBounded(string the_key)
	return JsonUtil.GetPathStringValue(g_punishtype_fileName, g_punishtype_basePath + "."+ the_key + ".tat2")
EndFunction

String Function GetJSONPunishmentTypeAnimByIndex(int index)
	if index >= 0 && index < g_punishtype_anim1.length
		return g_punishtype_anim1[index]
	endif
	LogInfo("ERROR: Could not read punishment type anim 1 with index="+index)
	if g_punishtype_anim1.Length > 0
		return g_punishtype_anim1[0]
	endif
	return ""
EndFunction
String Function GetJSONPunishmentTypeAnim(string the_key)
	return JsonUtil.GetPathStringValue(g_punishtype_fileName, g_punishtype_basePath + "."+ the_key + ".animation1")
EndFunction
String Function GetJSONPunishmentTypeAnimBoundedByIndex(int index)
	if index >= 0 && index < g_punishtype_anim2.length
		return g_punishtype_anim2[index]
	endif
	LogInfo("ERROR: Could not read punishment type anim 2 with index="+index)
	if g_punishtype_anim2.Length > 0
		return g_punishtype_anim2[0]
	endif
	return ""
EndFunction
String Function GetJSONPunishmentTypeAnimBounded(string the_key)
	return JsonUtil.GetPathStringValue(g_punishtype_fileName, g_punishtype_basePath + "."+ the_key + ".animation2")
EndFunction

string   g_punish_last_read_key   = ""
string   g_punish_fileName = "Diary Of Mine/PunishmentReasons.json"
string   g_punish_basePath = "punishmentsList"
String[] g_punish_keys
String[] g_punish_reasonsF
String[] g_punish_reasonsM
String[] g_punish_last_read_stats
Float[]  g_punish_last_read_values
String   g_punish_last_read_mod   
String   g_punish_last_read_check

Function SetJSONPunishmentReasons()
	if !JsonUtil.JsonExists(g_punish_fileName)
		LogTrace("SetJSONPunishmentReasons: ERROR Could not find file "+g_punish_fileName)
		return
	endif
	
	g_punish_last_read_key = ""

	int nkeys = JsonUtil.PathCount(g_punish_fileName, g_punish_basePath) 
	g_punish_keys     =  JsonUtil.PathMembers(g_punish_fileName, g_punish_basePath)
	g_punish_reasonsF =  JsonUtil.PathMembers(g_punish_fileName, g_punish_basePath)
	g_punish_reasonsM =  JsonUtil.PathMembers(g_punish_fileName, g_punish_basePath)
	
	int n = g_punish_keys.length
	LogInfo("SetJSONPunishmentReasons: Found "+nkeys+" entries in array of size "+n)
	int i = 0
	while i < n
		string the_key   = g_punish_keys[i]
		string the_nameF = GetJSONPunishmentReasonName(the_key)
		string the_nameM = GetJSONPunishmentReasonNameForMales(the_key)
		g_punish_reasonsF[i] = the_nameF
		g_punish_reasonsM[i] = the_nameM
		i += 1
	endwhile
	i = 0
	while i < n
		LogTrace("SetJSONPunishmentReasons: "+i+" Found key="+ g_punish_keys[i]+" reason="+g_punish_reasonsF[i]+"/"+g_punish_reasonsM[i])
		i += 1
	endwhile
EndFunction

Int Function GetJSONNumberOfPunishmentReasons()
	return g_punish_keys.length
EndFunction

Int Function GetJSONPunishmentReasonIndexByName(string the_reason)
	int n = g_punish_keys.length
	int i = 0
	while i < n
		if the_reason == g_punish_reasonsF[i]
			return i
		endif
		i += 1
	endwhile
	i = 0
	while i < n
		if the_reason == g_punish_reasonsM[i]
			return i
		endif
		i += 1
	endwhile
	LogInfo("ERROR: Could not find punishment reason index for="+the_reason)
	return 0
EndFunction
String Function GetJSONPunishmentReasonNameByIndex(int index, int actorSex)
	if index >= 0 && index < g_punish_keys.length
		if (actorSex %2)==1
			return g_punish_reasonsF[index]
		else
			return g_punish_reasonsM[index]
		endif
	endif
	if index < 0 || index >= g_punish_keys.Length
		LogInfo("ERROR: Could not read punishment reason with index="+index)
		return GetJSONPunishmentReasonName("Punish000")
	endif
	if (actorSex %2)==1
		return GetJSONPunishmentReasonName(g_punish_keys[index])
	endif
	return GetJSONPunishmentReasonNameForMales(g_punish_keys[index])
EndFunction
String Function GetJSONPunishmentReasonName(string the_key)
	return JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".reason")
EndFunction
String Function GetJSONPunishmentReasonNameForMales(string the_key)
	string reason_male = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".reason_male")
	if reason_male != ""
		return reason_male
	endif
	return GetJSONPunishmentReasonName(the_key)
EndFunction

String Function GetJSONPunishmentTrainingCheckByIndex(int index)
	if index < 0 || index >= g_punish_keys.Length
		LogInfo("ERROR: Could not read punishment modifier with index="+index)
		return GetJSONPunishmentTrainingCheck("Punish000")
	endif
	return GetJSONPunishmentTrainingCheck(g_punish_keys[index])
EndFunction
String Function GetJSONPunishmentTrainingCheck(string the_key)
	if the_key != g_praise_last_read_key
		g_punish_last_read_key    = the_key
		g_punish_last_read_check  = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".check")
		g_punish_last_read_mod    = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".modifier")
		g_punish_last_read_values = JsonUtil.PathFloatElements(g_punish_fileName,  g_punish_basePath + "."+ the_key + ".values")
		g_punish_last_read_stats  = JsonUtil.PathStringElements(g_punish_fileName, g_punish_basePath + "."+ the_key + ".stats")
	endif
	return g_punish_last_read_check   
EndFunction

String Function GetJSONPunishmentArousalModifierByIndex(int index)
	LogTrace("GetJSONPunishmentArousalModifierByIndex "+index+" length="+g_punish_keys.Length)
	if index < 0 || index >= g_punish_keys.Length
		LogInfo("ERROR: Could not read punishment modifier with index="+index)
		return GetJSONPunishmentArousalModifier("Punish000")
	endif
	LogTrace("GetJSONPunishmentArousalModifierByIndex "+index+" key="+g_punish_keys[index])
	return GetJSONPunishmentArousalModifier(g_punish_keys[index])
EndFunction
String Function GetJSONPunishmentArousalModifier(string the_key)
	if the_key != g_punish_last_read_key
		g_punish_last_read_key    = the_key
		g_punish_last_read_check  = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".check")
		g_punish_last_read_mod    = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".modifier")
		g_punish_last_read_values = JsonUtil.PathFloatElements(g_punish_fileName, g_punish_basePath + "."+ the_key + ".values")
		g_punish_last_read_stats  = JsonUtil.PathStringElements(g_punish_fileName, g_punish_basePath + "."+ the_key + ".stats")
	endif
	return g_punish_last_read_mod   
EndFunction

Float[] Function GetJSONPunishmentTrainingValuesByIndex(int index)
	if index < 0 || index >= g_punish_keys.Length
		LogInfo("ERROR: Could not read punishment values with index="+index)
		return GetJSONPunishmentTrainingValues("Punish000")
	endif
	return GetJSONPunishmentTrainingValues(g_punish_keys[index])
EndFunction
Float[] Function GetJSONPunishmentTrainingValues(string the_key)
	if the_key != g_punish_last_read_key
		g_punish_last_read_key    = the_key
		g_punish_last_read_check  = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".check")
		g_punish_last_read_mod    = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".modifier")
		g_punish_last_read_values = JsonUtil.PathFloatElements(g_punish_fileName, g_punish_basePath + "."+ the_key + ".values")
		g_punish_last_read_stats  = JsonUtil.PathStringElements(g_punish_fileName, g_punish_basePath + "."+ the_key + ".stats")
		if !g_punish_last_read_values
			LogInfo("ERROR: Could not read punishment values with key="+the_key)
		endif
	endif
	return g_punish_last_read_values
EndFunction

String[] Function GetJSONPunishmentTrainingStatsByIndex(int index)
	if index < 0 || index >= g_punish_keys.Length
		LogInfo("ERROR: Could not read punishment stats with index="+index)
		return GetJSONPunishmentTrainingStats("Punish000")
	endif
	return GetJSONPunishmentTrainingStats(g_punish_keys[index])
EndFunction
String[] Function GetJSONPunishmentTrainingStats(string the_key, bool do_check=true)
	if the_key != g_punish_last_read_key
		g_punish_last_read_key    = the_key
		g_punish_last_read_check  = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".check")
		g_punish_last_read_mod    = JsonUtil.GetPathStringValue(g_punish_fileName, g_punish_basePath + "."+ the_key + ".modifier")
		g_punish_last_read_values = JsonUtil.PathFloatElements(g_punish_fileName, g_punish_basePath + "."+ the_key + ".values")
		g_punish_last_read_stats  = JsonUtil.PathStringElements(g_punish_fileName, g_punish_basePath + "."+ the_key + ".stats")
		if !g_punish_last_read_stats
			LogInfo("ERROR: Could not read punishment stats with key="+the_key)
		endif
	endif
	return g_punish_last_read_stats
EndFunction

string   g_praise_last_read_key   = ""
string   g_praise_fileName = "Diary Of Mine/PraisingReasons.json"
string   g_praise_basePath = "praisesList"
String[] g_praise_keys
String[] g_praise_reasonsF
String[] g_praise_reasonsM
String[] g_praise_last_read_stats
Float[]  g_praise_last_read_values
String   g_praise_last_read_mod   
String   g_praise_last_read_check

Function SetJSONPraisingReasons()
	if !JsonUtil.JsonExists(g_praise_fileName)
		LogTrace("SetJSONPraisingReasons: ERROR Could not find file "+g_praise_fileName)
		return
	endif
	
	g_praise_last_read_key = ""

	int nkeys = JsonUtil.PathCount(g_praise_fileName, g_praise_basePath) 
	g_praise_keys     =  JsonUtil.PathMembers(g_praise_fileName, g_praise_basePath)
	g_praise_reasonsF =  JsonUtil.PathMembers(g_praise_fileName, g_praise_basePath)
	g_praise_reasonsM =  JsonUtil.PathMembers(g_praise_fileName, g_praise_basePath)
	
	int n = g_praise_keys.length
	LogInfo("SetJSONPraisingReasons: Found "+nkeys+" entries in array of size "+n)
	int i = 0
	while i < n
		string the_key   = g_praise_keys[i]
		string the_nameF = GetJSONPraisingReasonName(the_key)
		string the_nameM = GetJSONPraisingReasonNameForMales(the_key)
		g_praise_reasonsF[i] = the_nameF
		g_praise_reasonsM[i] = the_nameM
		i += 1
	endwhile
	i = 0
	while i < n
		LogTrace("SetJSONPraisingReasons: "+i+" Found key="+ g_praise_keys[i]+" reason="+g_praise_reasonsF[i]+"/"+g_praise_reasonsM[i])
		i += 1
	endwhile
EndFunction

Int Function GetJSONNumberOfPraisingReasons()
	return g_praise_keys.length
EndFunction

Int Function GetJSONPraisingReasonIndexByName(string the_reason)
	int n = g_praise_keys.length
	int i = 0
	while i < n
		if the_reason == g_praise_reasonsF[i]
			return i
		endif
		i += 1
	endwhile
	i = 0
	while i < n
		if the_reason == g_praise_reasonsM[i]
			return i
		endif
		i += 1
	endwhile
	LogInfo("ERROR: Could not find praising reason index for="+the_reason)
	return 0
EndFunction
String Function GetJSONPraisingReasonNameByIndex(int index, int actorSex)
	if index >= 0 && index < g_praise_keys.length
		if (actorSex%2)==1
			return g_praise_reasonsF[index]
		else
			return g_praise_reasonsM[index]
		endif
	endif
	if index < 0 || index >= g_praise_keys.Length
		LogInfo("ERROR: Could not read praising reason with index="+index)
		return GetJSONPraisingReasonName("Praise000")
	endif
	if (actorSex%2)==1
		return GetJSONPraisingReasonName(g_praise_keys[index])
	endif
	return GetJSONPraisingReasonNameForMales(g_praise_keys[index])
EndFunction
String Function GetJSONPraisingReasonName(string the_key)
	return JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".reason")
EndFunction
String Function GetJSONPraisingReasonNameForMales(string the_key)
	string reason_male = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".reason_male")
	if reason_male != ""
		return reason_male
	endif
	return GetJSONPraisingReasonName(the_key)
EndFunction

String Function GetJSONPraisingTrainingCheckByIndex(int index)
	if index < 0 || index >= g_praise_keys.Length
		LogInfo("ERROR: Could not read praising modifier with index="+index)
		return GetJSONPraisingTrainingCheck("Praise000")
	endif
	return GetJSONPraisingTrainingCheck(g_praise_keys[index])
EndFunction
String Function GetJSONPraisingTrainingCheck(string the_key)
	if the_key != g_praise_last_read_key
		g_praise_last_read_key    = the_key
		g_praise_last_read_check  = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".check")
		g_praise_last_read_mod    = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".modifier")
		g_praise_last_read_values = JsonUtil.PathFloatElements(g_praise_fileName, g_praise_basePath + "."+ the_key + ".values")
		g_praise_last_read_stats  = JsonUtil.PathStringElements(g_praise_fileName, g_praise_basePath + "."+ the_key + ".stats")
	endif
	return g_praise_last_read_check   
EndFunction

String Function GetJSONPraisingArousalModifierByIndex(int index)
	if index < 0 || index >= g_praise_keys.Length
		LogInfo("ERROR: Could not read praising modifier with index="+index)
		return GetJSONPraisingArousalModifier("Praise000")
	endif
	return GetJSONPraisingArousalModifier(g_praise_keys[index])
EndFunction
String Function GetJSONPraisingArousalModifier(string the_key)
	if the_key != g_praise_last_read_key
		g_praise_last_read_key    = the_key
		g_praise_last_read_check  = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".check")
		g_praise_last_read_mod    = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".modifier")
		g_praise_last_read_values = JsonUtil.PathFloatElements(g_praise_fileName, g_praise_basePath + "."+ the_key + ".values")
		g_praise_last_read_stats  = JsonUtil.PathStringElements(g_praise_fileName, g_praise_basePath + "."+ the_key + ".stats")
	endif
	return g_praise_last_read_mod   
EndFunction

Float[] Function GetJSONPraisingTrainingValuesByIndex(int index)
	if index < 0 || index >= g_praise_keys.Length
		LogInfo("ERROR: Could not read praising values with index="+index)
		return GetJSONPraisingTrainingValues("Praise000")
	endif
	return GetJSONPraisingTrainingValues(g_praise_keys[index])
EndFunction
Float[] Function GetJSONPraisingTrainingValues(string the_key)
	if the_key != g_praise_last_read_key
		g_praise_last_read_key    = the_key
		g_praise_last_read_check  = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".check")
		g_praise_last_read_mod    = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".modifier")
		g_praise_last_read_values = JsonUtil.PathFloatElements(g_praise_fileName, g_praise_basePath + "."+ the_key + ".values")
		g_praise_last_read_stats  = JsonUtil.PathStringElements(g_praise_fileName, g_praise_basePath + "."+ the_key + ".stats")
		if !g_praise_last_read_values
			LogInfo("ERROR: Could not read praising values with key="+the_key)
		endif
	endif
	return g_praise_last_read_values
EndFunction

String[] Function GetJSONPraisingTrainingStatsByIndex(int index)
	if index < 0 || index >= g_praise_keys.Length
		LogInfo("ERROR: Could not read praising stats with index="+index)
		return GetJSONPraisingTrainingStats("Praise000")
	endif
	return GetJSONPraisingTrainingStats(g_praise_keys[index])
EndFunction
String[] Function GetJSONPraisingTrainingStats(string the_key, bool do_check=true)
	if the_key != g_praise_last_read_key
		g_praise_last_read_key    = the_key
		g_praise_last_read_check  = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".check")
		g_praise_last_read_mod    = JsonUtil.GetPathStringValue(g_praise_fileName, g_praise_basePath + "."+ the_key + ".modifier")
		g_praise_last_read_values = JsonUtil.PathFloatElements(g_praise_fileName, g_praise_basePath + "."+ the_key + ".values")
		g_praise_last_read_stats  = JsonUtil.PathStringElements(g_praise_fileName, g_praise_basePath + "."+ the_key + ".stats")
		if !g_praise_last_read_stats
			LogInfo("ERROR: Could not read praising stats with key="+the_key)
		endif
	endif
	return g_praise_last_read_stats
EndFunction

Function RegisterSpells()
	if hasAbductionSpell
		if !PlayerRef.HasSpell(DOMAbductionSpell)
			PlayerRef.AddSpell(DOMAbductionSpell)
		endif
	else
		if PlayerRef.HasSpell(DOMAbductionSpell)
			PlayerRef.RemoveSpell(DOMAbductionSpell)
		endif
	endif
	if hasDiarySpell
		if !PlayerRef.HasSpell(DOMDiarySpell)
			PlayerRef.AddSpell(DOMDiarySpell)
		endif
	else
		if PlayerRef.HasSpell(DOMDiarySpell)
			PlayerRef.RemoveSpell(DOMDiarySpell)
		endif
	endif
	if hasMenuSpell
		if !PlayerRef.HasSpell(DOMMenuSpell)
			PlayerRef.AddSpell(DOMMenuSpell)
		endif
	else
		if PlayerRef.HasSpell(DOMMenuSpell)
			PlayerRef.RemoveSpell(DOMMenuSpell)
		endif
	endif
	if hasMenuPower
		if !PlayerRef.HasSpell(DOMMenuPower)
			PlayerRef.AddSpell(DOMMenuPower)
		endif
	else
		if PlayerRef.HasSpell(DOMMenuPower)
			PlayerRef.RemoveSpell(DOMMenuPower)
		endif
	endif
	if hasInfoSpell
		if !PlayerRef.HasSpell(DOMInfoSpell)
			PlayerRef.AddSpell(DOMInfoSpell)
		endif
	else
		if PlayerRef.HasSpell(DOMInfoSpell)
			PlayerRef.RemoveSpell(DOMInfoSpell)
		endif
	endif
	if hasInfoPower
		if !PlayerRef.HasSpell(DOMInfoPower)
			PlayerRef.AddSpell(DOMInfoPower)
		endif
	else
		if PlayerRef.HasSpell(DOMInfoPower)
			PlayerRef.RemoveSpell(DOMInfoPower)
		endif
	endif
EndFunction

Function RegisterPerks()
	if hasWakeUpPerk
		PlayerRef.AddPerk(DOMWakeupPerk)
	else
		PlayerRef.RemovePerk(DOMWakeupPerk)
	endif
	if hasBurlapSackPerk
		PlayerRef.AddPerk(DOMBurlapSackPerk)
	else
		PlayerRef.RemovePerk(DOMBurlapSackPerk)
	endif
	if hasAbductionPerk
		PlayerRef.AddPerk(DOMEnslavePerk)
	else
		PlayerRef.RemovePerk(DOMEnslavePerk)
	endif
	if hasRecruitPerk
		PlayerRef.AddPerk(DOMRecruitPerk)
	else
		PlayerRef.RemovePerk(DOMRecruitPerk)
	endif
EndFunction

Function UnregisterPerks() ; not used
	PlayerRef.RemovePerk(DOMWakeupPerk)
	PlayerRef.RemovePerk(DOMBurlapSackPerk)
	PlayerRef.RemovePerk(DOMEnslavePerk)
	PlayerRef.RemovePerk(DOMRecruitPerk)
EndFunction

int Function GetSlaveManagerIndex(DOM_SlaveManager mng)
	int n = DOMExtraMng.length
	int idx = 0
	while idx < n
		if DOMExtraMng[idx] == mng
			return idx+1
		endif
	EndWhile
	return -1
EndFunction

int Function AddSlaveManager(DOM_SlaveManager mng)
	int n = DOMExtraMng.length
	if nDOMExtraMng >= n
		return -1 ; failed to add manager
	endif
	HudNotification("New slave manager registered, save and reload to initialize!")
	DOMExtraMng[nDOMExtraMng] = mng
	nDOMExtraMng += 1
	DOM_NumberOfExtraMng.SetValue(nDOMExtraMng)
	return nDOMExtraMng
EndFunction

DOM_Mind Function GetMindFromActor(DOM_Actor akActor)
	if akActor == None
		return None
	endif
	return akActor.mind
EndFunction

DOM_Mind Function GetActorMind(Actor akTarget)
	if akTarget == None
		return None
	endif
	DOM_Actor akActor = GetActor(akTarget)
	if akActor == None
		return None
	endif
	return akActor.mind
EndFunction

DOM_Actor selected_actor = None
Function ClearSelectedActor(DOM_Actor akActor)
	if akActor == selected_actor
		selected_actor = None
	endif
EndFunction

Function CheckDistanceToCell(Actor akRef, int index)
	if akRef == None
		LogTrace("CheckDistanceToCell no actor to check "+akRef)
	endif
	if HSHStorage == None
		LogTrace("CheckDistanceToCell no HSH storage to check "+akRef)
	endif
	PAHOPortable pahop = HSHStorage.PortableFunctions
	if pahop == None
		LogTrace("CheckDistanceToCell no PAHO portable to check "+HSHStorage)
	endif
	PHHSHPortableCellScript cellref = pahop.GetCellRef(index)
	if cellref == None
		LogTrace("CheckDistanceToCell no Cell ref to check "+pahop)
	endif
	ObjectReference cellbutton = cellref.GetReference() as ObjectReference
	if cellbutton == None
		LogTrace("CheckDistanceToCell no Cell button "+cellref)
	endif
	LogTrace("CheckDistanceToCell cellbutton "+cellbutton)
	Cell cell1 = cellbutton.GetParentCell()
	LogTrace("CheckDistanceToCell cell1 "+cell1)
	Cell cell2 = akRef.GetParentCell()
	LogTrace("CheckDistanceToCell cell2 "+cell2)
	if cell1 == cell2
		LogTrace("Same cell!!!")
	endif
EndFunction

DOM_Actor Function GetActor(Actor akRef)
	if akRef == None
		LogTrace("GetActor: Can not get a None actor")
		return None
	endif
	if akRef == PlayerRef
		return None
	endif
	;LogTrace("GetActor "+akRef.GetDisplayName()+" player slave="+akRef.GetFactionRank(DOMPlayerSlaveFaction)+" not player slave="+akRef.GetFactionRank(DOMNotPlayerSlaveFaction))
	;LogTrace("GetActor "+akRef.GetDisplayName()+" actor="+akRef.GetFactionRank(DOMActorFaction)+" mng="+akRef.GetFactionRank(DOMSlaveManagerFaction))
	;LogTrace("GetActor "+akRef.GetDisplayName()+" actor index="+akRef.GetFactionRank(DOMActorIndexFaction)+" alias index="+akRef.GetFactionRank(DOMAliasIndexFaction))

	if !akRef.IsInFaction(DOMActorFaction)
		return None
	endif
	;LogTrace("GetActor() "+akRef.GetDisplayName())
	if akRef == PlayerRef
		return DOMPlayerAlias.actor_alias
	endif
	if selected_actor != None
		if selected_actor.akRef == akRef
			return selected_actor
		endif
	endif
	if akRef.IsInFaction(DOMPlayerSlaveFaction)
		int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
		if rank <= 0 ; Manager 0 is DOM02
			DOM_Actor akActor = DOM02.GetActor(akRef)
			if akActor != None
				selected_actor = akActor
				return akActor
			endif
		elseif rank == 100 ; Managers above 100 are from HSH
			; 100 is House
			if HSHFlexi == None
				LogTrace("GetActor: Can not get HSH actor because flexi storage is not registered "+akRef.GetDisplayName())
				return  None
			endif
			ReferenceAlias slot = HSHFlexi.SlaveRef(akRef) as ReferenceAlias
			return slot as DOM_Actor
		elseif rank == 101 
			; 101 is Hunter, 102 is Camp
			if HSHStorage == None
				LogTrace("GetActor: Can not get HSH actor because storage is not registered "+akRef.GetDisplayName())
				return  None
			endif
			ReferenceAlias slot = HSHStorage.SlaveRef(akRef) as ReferenceAlias
			return slot as DOM_Actor
		elseif rank == 102
			; 101 is Hunter, 102 is Camp
			if HSHStorage == None
				LogTrace("GetActor: Can not get HSH actor because storage is not registered "+akRef.GetDisplayName())
				return  None
			endif
			ReferenceAlias slot = HSHStorage.SlaveRef(akRef) as ReferenceAlias
			return slot as DOM_Actor
		elseif rank <= nDOMExtraMng ; Check if extra managers have been registered
			DOM_SlaveManager mng = DOMExtraMng[rank-(1)]
			DOM_Actor akActor = mng.GetActor(akRef)
			if akActor != None
				selected_actor = akActor
				return akActor
			endif
		endif
	endif
	if akRef.IsInFaction(DOMNotPlayerSlaveFaction)
		int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
		if rank >= 103
			; 103, 104 and 105 are the mine camps
			if PAHO == None
				LogTrace("GetActor: Can not get HSH actor because PAHOCore is not registered "+akRef.GetDisplayName())
				return  None
			endif
			ReferenceAlias slot = PAHO.SlaveRef(akRef) as ReferenceAlias
			return slot as DOM_Actor
		elseif rank >= 50
			; AYGAS Slaves
			LogTrace("GetActor: Can not get AYGAS actor "+akRef.GetDisplayName())
			return  None
		endif
	endif
	if akRef.IsInFaction(DOMPlayerSlaverFaction)
		DOM_Actor akActor = DOM01.GetActor(akRef)
		if akActor != None
			selected_actor = akActor
			return akActor
		endif
	endif
	LogTrace("GetActor: Failed to get actor "+akRef.GetDisplayName())
	return None
EndFunction

DOM_Actor Function GetSlave(Actor akRef)
	if akRef == None
		return None
	endif
	if !akRef.IsInFaction(DOMPlayerSlaveFaction)
		return None
	endif
	if akRef == PlayerRef
		return DOMPlayerAlias.actor_alias
	endif
	if selected_actor != None
		if selected_actor.akRef == akRef
			return selected_actor
		endif
	endif
	int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
	if rank <= 0 ; Manager 0 is DOM02
		DOM_Actor akActor = DOM02.GetActor(akRef)
		if akActor != None
			selected_actor = akActor
			return akActor
		endif
	elseif rank == 100 ; Managers above 100 are from HSH
		; 100 is House
		if HSHFlexi == None
			return  None
		endif
		ReferenceAlias slot = HSHFlexi.SlaveRef(akRef) as ReferenceAlias
		return slot as DOM_Actor
	elseif rank >= 101 && rank <= 102
		; 101 is Hunter, 102 is Camp
		if HSHStorage == None
			return  None
		endif
		ReferenceAlias slot = HSHStorage.SlaveRef(akRef) as ReferenceAlias
		return slot as DOM_Actor
	elseif rank >= 103 && rank <= 105
		; 103, 104 and 105 are the mine camps
		if PAHO == None
			LogTrace("GetSlave: Can not get HSH actor because PAHOCore is not registered "+akRef.GetDisplayName())
			return  None
		endif
		ReferenceAlias slot = PAHO.SlaveRef(akRef) as ReferenceAlias
		return slot as DOM_Actor
	elseif rank >= 50
		; AYGAS Slaves
		LogTrace("GetSlave: Can not get AYGAS actor "+akRef.GetDisplayName())
		return  None
	elseif rank <= nDOMExtraMng ; Check if extra managers have been registered
		DOM_SlaveManager mng = DOMExtraMng[rank-(1)]
		DOM_Actor akActor = mng.GetActor(akRef)
		if akActor != None
			selected_actor = akActor
			return akActor
		endif
	endif
	return None
EndFunction

DOM_Actor Function GetSlaver(Actor akRef)
	if akRef == None
		return None
	endif
	if !akRef.IsInFaction(DOMPlayerSlaverFaction)
		return None
	endif
	if akRef == PlayerRef
		return DOMPlayerAlias.actor_alias
	endif
	if selected_actor != None
		if selected_actor.akRef == akRef
			return selected_actor
		endif
	endif
	DOM_Actor akActor = DOM01.GetActor(akRef)
	if akActor != None
		selected_actor = akActor
		return akActor
	endif
	return None
EndFunction

Function ReleaseAlias(ReferenceAlias akAlias)
	Actor akRef = akAlias.GetActorRef()
	if akRef == None
		LogTrace("ReleaseAlias(): Alias is not set")
		return
	endif
	if akRef.IsInFaction(DOMPlayerSlaveFaction)
		ReleaseSlaveAlias(akAlias)
	elseif akRef.IsInFaction(DOMNotPlayerSlaveFaction)
		ReleaseNotPlayerSlaveAlias(akAlias)
	elseif akRef.IsInFaction(DOMPlayerSlaverFaction)
		ReleaseSlaverAlias(akAlias)
	endif
EndFunction

Function ReleaseSlaveAlias(ReferenceAlias akAlias)
	Actor akRef = akAlias.GetActorRef()
	if akRef == None
		LogTrace("ReleaseSlaveAlias(): Alias is not set")
		return
	endif
	if akRef.IsInFaction(DOMNotPlayerSlaveFaction)
		ReleaseNotPlayerSlaveAlias(akAlias)
		return
	endif
	int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
	if rank <= 0 ; Manager 0 is DOM02
		LogTrace("ReleaseSlaveAlias(): Alias is in DOM02 (slaves) "+akRef.GetDisplayName())
		DOM02.ReleaseAlias(akAlias)
		return
	elseif rank >= 100 ; Managers above 100 are from HSH
		LogTrace("ReleaseSlaveAlias(): Alias is from HSH IGNORE! "+akRef.GetDisplayName())
		return
	elseif rank <= nDOMExtraMng ; Check if extra managers have been registered
		LogTrace("ReleaseSlaveAlias(): Alias is in DOMx"+rank+" (slaves) "+akRef.GetDisplayName())
		DOM_SlaveManager mng = DOMExtraMng[rank-(1)]
		mng.ReleaseAlias(akAlias)
		return
	endif
	LogTrace("ReleaseSlaveAlias(): Alias was not found "+akRef.GetDisplayName())
EndFunction

Function ReleaseNotPlayerSlaveAlias(ReferenceAlias akAlias)
	Actor akRef = akAlias.GetActorRef()
	if akRef == None
		LogTrace("ReleaseNotPlayerSlaveAlias(): Alias is not set")
		return
	endif
	int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
	if rank >= 103 && rank <= 105
		if PAHO != None
			LogTrace("ReleaseNotPlayerSlaveAlias: Release HSH camp miner "+akRef.GetDisplayName())
			PAHO.PAHOCampOps.ReleaseAlias(akAlias)
			return
		endif
	elseif rank >= 50
		; AYGAS Slaves
		LogTrace("ReleaseNotPlayerSlaveAlias: Can not get AYGAS actor "+akRef.GetDisplayName())
		return
	endif
	LogTrace("ReleaseNotPlayerSlaveAlias(): Alias was not found "+akRef.GetDisplayName())
EndFunction

Function ReleaseSlaverAlias(ReferenceAlias akAlias)
	Actor akRef = akAlias.GetActorRef()
	if akRef == None
		LogTrace("ReleaseSlaverAlias(): Alias is not set")
		return
	endif
	LogTrace("ReleaseSlaverAlias(): Alias is in DOM01 (slavers) "+akRef.GetDisplayName())
	DOM01.ReleaseAlias(akAlias)
EndFunction

bool Function ReleaseActor(Actor akRef)
	ReferenceAlias akActor 
	if akRef.IsInFaction(DOMPlayerSlaveFaction)
		return ReleaseSlave(akRef)
	elseif akRef.IsInFaction(DOMNotPlayerSlaveFaction)
		return ReleaseNotPlayerSlave(akRef)
	elseif akRef.IsInFaction(DOMPlayerSlaverFaction)
		return ReleaseSlaver(akRef)
	endif
	LogTrace("ReleaseActor(): Actor was not found "+akRef.GetDisplayName())
	return false
EndFunction

bool Function ReleaseSlave(Actor akRef)
	if !akRef.IsInFaction(DOMPlayerSlaveFaction)
		return false
	endif
	if akRef == PlayerRef
		return false
	endif
	ReferenceAlias akActor 
	int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
	if rank <= 0 ; Manager 0 is DOM02
		akActor = DOM02.GetActorAlias(akRef)
		if akActor != None
			LogTrace("ReleaseSlave(): Actor is in DOM02 (slaves) "+akRef.GetDisplayName())
			DOM02.ReleaseAlias(akActor)
			return true
		endif
	elseif rank >= 100 ; Managers above 100 are from HSH
		LogTrace("ReleaseSlave(): Alias is from HSH IGNORE! "+akRef.GetDisplayName())
		return false
	elseif rank <= nDOMExtraMng ; Check if extra managers have been registered
		DOM_SlaveManager mng = DOMExtraMng[rank-(1)]
		akActor = mng.GetActorAlias(akRef)
		if akActor != None
			LogTrace("ReleaseSlave(): Actor is in DOM0x"+rank+" (slaves) "+akRef.GetDisplayName())
			mng.ReleaseAlias(akActor)
			return true
		endif
	endif
	LogTrace("ReleaseSlave(): Actor was not found "+akRef.GetDisplayName())
	return false
EndFunction

bool Function ReleaseNotPlayerSlave(Actor akRef)
	if !akRef.IsInFaction(DOMNotPlayerSlaveFaction)
		return false
	endif
	if akRef == PlayerRef
		return false
	endif
	ReferenceAlias akActor 
	int rank = akRef.GetFactionRank(DOMSlaveManagerFaction)
	if rank >= 103 && rank <= 105
		if PAHO != None
			PAHO.PAHOCampOps.ReleaseActor(akRef)
			return true
		endif
	elseif rank >= 50
		; AYGAS Slaves
		LogTrace("ReleaseNotPlayerSlave: Can not get AYGAS actor "+akRef.GetDisplayName())
		return  None
	endif
	LogTrace("ReleaseSlave(): Actor was not found "+akRef.GetDisplayName())
	return false
EndFunction

bool Function ReleaseSlaver(Actor akRef)
	if !akRef.IsInFaction(DOMPlayerSlaverFaction)
		return false
	endif
	if akRef == PlayerRef
		return false
	endif
	ReferenceAlias akActor 
	akActor = DOM01.GetActorAlias(akRef)
	if akActor != None
		LogTrace("ReleaseSlaver(): Actor is in DOM01 (slavers) "+akRef.GetDisplayName())
		DOM01.ReleaseAlias(akActor)
		return true
	endif
	LogTrace("ReleaseSlaver(): Actor was not found "+akRef.GetDisplayName())
	return false
EndFunction

Actor actor_in_dialogue = None
Function SlaveFamilyCheck(Actor akTarget)
	;if actor_in_dialogue == None
	;	LogTrace("SlaveFamilyCheck: checking actor family "+akTarget.GetDisplayName())
	;else
	;	LogTrace("SlaveFamilyCheck: checking actor family "+akTarget.GetDisplayName()+" in dialogue with "+actor_in_dialogue.GetDisplayName())
	;endif
	float[] TraitsArray = DOMGenerator.GetNPCTraitsUpdateModifiers(akTarget) ; to fill potential slaver faction
	if akTarget == actor_in_dialogue
		return ; avoid double checking
	endif
	actor_in_dialogue = akTarget
	DOM02.SlaveFamilyCheck(akTarget)
	; Could also loop on extra managers
	int n = nDOMExtraMng
	if n == 0
		return
	endif
	if n > DOMExtraMng.length
		n = DOMExtraMng.length
	endif
	int i = 0
	while i < n 
		DOM_SlaveManager mng = DOMExtraMng[i]
		if mng != None
			mng.SlaveFamilyCheck(akTarget)
		endif
		i += 1
	endwhile
EndFunction

Function SlaveFamilyRansom(Actor akTarget)
	LogTrace("SlaveFamilyRansom: checking actor family "+akTarget.GetDisplayName())
	;if akTarget == actor_in_dialogue
	;	return ; avoid double checking
	;endif
	actor_in_dialogue = akTarget
	DOM02.SlaveFamilyRansom(akTarget)
	; Could also loop on extra managers
	int n = nDOMExtraMng
	if n == 0
		return
	endif
	if n > DOMExtraMng.length
		n = DOMExtraMng.length
	endif
	int i = 0
	while i < n 
		DOM_SlaveManager mng = DOMExtraMng[i]
		if mng != None
			mng.SlaveFamilyRansom(akTarget)
		endif
		i += 1
	endwhile
EndFunction

Function CheckPlayersEquipment()
	if !hasSlapTool
		int n = PlayerRef.GetItemCount(DOMSlap)
		if ( n > 0)
			PlayerRef.RemoveItem(DOMSlap,n,true) ; silent
		endif	
		return
	endif
	;LogTrace("Weapon DOMSlap ="+DOMSlap)
	if (PlayerRef.GetItemCount(DOMSlap) <= 0)
		PlayerRef.AddItem(DOMSlap)
	endif
EndFunction

bool Function IsAllowedToPunish(Actor aggro)
	if aggro.IsInFaction(DOMPlayerSlaverFaction)
		return true
	endif
	if aggro.GetFactionRank(DOMPlayerSlaveFaction) == 2
		return true
	endif
	if sHitToggle 
		if aggro.IsInFaction(DOMPlayerSlaveFaction)
			return true
		elseif DOMPAH.isPAH(aggro)
			return true
		elseif HshHouseSlaveFaction != None && aggro.IsInFaction(HshHouseSlaveFaction)
			return true
		endif
	endif
	if fHitToggle && aggro.IsInFaction(PlayerFollowerFaction)
		return true
	endif
	return false
EndFunction

bool Function IsWithPlayer(Actor akTarget, float distance)
	if akTarget == None
		return false
	endif
	if !akTarget.Is3DLoaded()
		return false
	endif
	if !IsTogetherWithFast(akTarget, PlayerRef, distance) ; 3000.0 = 42.6 meters
		return false
	endif
	return true
EndFunction

bool Function IsObjectWithPlayer(ObjectReference akTarget, float distance)
	if akTarget == None
		return false
	endif
	if !akTarget.Is3DLoaded()
		return false
	endif
	if !IsTogetherWithFast(akTarget, PlayerRef, distance) ; 3000.0 = 42.6 meters
		return false
	endif
	return true
EndFunction

bool Function IsTogetherWith(ObjectReference subject_ref, ObjectReference object_ref, float distance = 10000.0)
	; -=TAK=- Corrected for slaves in AAADOMTestTony
	; Skyrim units 10 000 = 142 m
	if subject_ref.GetParentCell() == AAADOMTestTony
		subject_ref = PlayerRef
	endif
	if object_ref.GetParentCell() == AAADOMTestTony
		object_ref = PlayerRef
	endif

	return IsTogetherWithFast(subject_ref, object_ref, distance)
EndFunction

bool Function isInDungeon(Location loc)
	if loc == None
		return false
	endif
   LogTrace("isInDungeon location="+loc.GetName()+" "+loc)
   if loc.haskeyword(LocTypeDungeon)
		LogTrace("isInDungeon: dungeon")
        return true
	elseif loc.haskeyword(LocTypeJail)
  		LogTrace("isInDungeon: jail")
      return true
	elseif loc.haskeyword(LocTypeMine)
		LogTrace("isInDungeon: mine")
        return true
	elseif loc.haskeyword(LocTypeCemetery)
 		LogTrace("isInDungeon: cemetery")
       return true
	elseif loc.haskeyword(LocTypeCave)
 		LogTrace("isInDungeon: cave")
       return true
    endif    
    return false
EndFunction

bool Function isInCity(Location loc)
	if loc == None
		return false
	endif
    ;LogTrace("isInCity location="+loc.GetName()+" "+loc)
	if loc.haskeyword(LocTypePlayerHouse)
		return false
	endif
    if loc.haskeyword(loctypecity)
		;LogTrace("isInCity: loctypecity")
        return true
	elseif loc.haskeyword(loctypetown)
		;LogTrace("isInCity: loctypetown")
        return true
	elseif loc.haskeyword(LocTypeDwelling)
		;LogTrace("isInCity: LocTypeDwelling")
        return true
	elseif loc.haskeyword(LocTypeStewardsDwelling)
		;LogTrace("isInCity: LocTypeStewardsDwelling")
        return true
	elseif loc.haskeyword(LocTypeInn)
		;LogTrace("isInCity: LocTypeInn")
        return true
	elseif loc.haskeyword(LocTypeCastle)
		;LogTrace("isInCity: LocTypeCastle")
        return true
	elseif loc.haskeyword(LocTypeMilitaryFort)
		;LogTrace("isInCity: LocTypeMilitaryFort")
        return true
	elseif loc.haskeyword(LocTypeMilitaryCamp)    
		;LogTrace("isInCity: LocTypeMilitaryCamp")
        return true
    endif    
    return false
EndFunction

bool Function isAJail(ObjectReference akRef)
	if akRef == None
		return false
	endif
	if akRef.HasKeyWord(CWPrisonerMarker1)
		return true
	endif
	if akRef.HasKeyWord(CWPrisonerMarker2)
		return true
	endif
	if akRef.HasKeyWord(CWPrisonerMarker3)
		return true
	endif
	if akRef.HasKeyWord(CWPrisonerMarker4)
		return true
	endif
	return false
EndFunction

bool Function IsWorkplaceBusy(DOM_Actor akWorker, ObjectReference workplace)
	if workplace == None || akWorker == None
		return false
	endif
	int n = DOM02.actorCounter
	int i = 0
	while i < DOM02.actorCounter
		DOM_Actor akOther = DOM02.actorArray[i]
		if akOther != None && akOther != akWorker
			if akOther.GetWorkingPlace() == workplace
				return true
			endif
		endif
		i += 1
	EndWhile
	return false
EndFunction

bool Function IsANarcotic(Form the_form)
	if the_form == None
		return false
	endif
	if the_form == Skooma
		return true
	endif
	if the_form == WindhelmDoubleDistilledSkooma
		return true
	endif
	if the_form == FreeformAngasMillKordirsSkooma
		return true
	endif
	if the_form == TGTQ02BalmoraBlue
		return true
	endif
	if the_form == DLC1RedwaterDenSkooma
		return true
	endif
	if the_form == dunSleepingTreeCampSap
		return true
	endif
	if stringUtil.find(the_form.GetName(),"Skooma") >=0
		return true
	endif
	return false
EndFunction

Form Function FindAlcoholInInventory(Actor akRef)	
	; Get all items in form list DOM01.AlcoholicDrinksExtendedList
	Int n = akRef.GetNumItems()
	LogTrace("FindAlcoholInInventory: n items="+n+" akRef="+akRef)
	;*ogTrace("has "+n+" items")
	if n == 0
		return None
	endif
	int i = 0
	while i < n
		Form the_form = akRef.GetNthForm(i)
		if IsPotionOrIngredient(the_form)
			float level = GetFormAlcoholLevel(the_form)
			if level > 0.0
				LogTrace("FindAlcoholInInventory: found alcohol beverage: "+the_form.GetName()+" level="+level)
				return the_form
			endif
		endif
		i += 1
	endwhile
	return None
EndFunction

float Function GetFormAlcoholLevel(Form the_form)
	float level = GetAlcoholLevel(the_form)
	if level > 0
		return level
	endif
	if AlcoholicDrinksExtendedList.hasForm(the_form)
		LogInfo("WARNING: Unrecognized alcohol beverage force alcohol level to 1")
		return 1.0
	endif
	return 0.0
EndFunction

Function UpdateAlcoholList()
	Form the_drink
	If Game.GetModByName("HearthFires.esm") != 255 ; Hearthfires beverages
		the_drink = Game.GetFormFromFile(0x03003535, "HearthFires.esm") As Faction ; Argonian Bloodwine 
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
		the_drink = Game.GetFormFromFile(0x03003536, "HearthFires.esm") As Faction ; Surilie Brothers Wine 
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
	endif
	If Game.GetModByName("Dragonborn.esm") != 255 ; Dragonborn beverages
		the_drink = Game.GetFormFromFile(0x0403572F, "Dragonborn.esm") As Faction ; Ashfire Mead 
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
		the_drink = Game.GetFormFromFile(0x040320DF, "Dragonborn.esm") As Faction ; Emberbrand Wine
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
		the_drink = Game.GetFormFromFile(0x040207E5, "Dragonborn.esm") As Faction ; Flin
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
		the_drink = Game.GetFormFromFile(0x040248CE, "Dragonborn.esm") As Faction ; Matze
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
		the_drink = Game.GetFormFromFile(0x040207E6, "Dragonborn.esm") As Faction ; Sujamma
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
		the_drink = Game.GetFormFromFile(0x04024E0B, "Dragonborn.esm") As Faction ; Sadri's Sujamma
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
		the_drink = Game.GetFormFromFile(0x040248CC, "Dragonborn.esm") As Faction ; Shein
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
	endif
	If Game.GetModByName("Immersive Wenches.esp") != 255 ; Immersive Wenches beverages
		the_drink = Game.GetFormFromFile(0x04059647, "Immersive Wenches.esp") As Faction ; Bloodwine 
		if the_drink != None
			AlcoholicDrinksExtendedList.AddForm(the_drink)
		endif
	endif
EndFunction

Function SayTopic(Actor the_actor, Topic topic_to_say, ObjectReference say_to = None)
	;if say_to
	;	the_actor.SetLookAt(say_to)
	;endif
	the_actor.Say(topic_to_say,the_actor,false)
	LogTopic(the_actor,topic_to_say)
EndFunction

bool Function hasWaterKeyword(Form the_form)
	if MagicDamageWater != None 
		if the_form.HasKeyWord(MagicDamageWater)
			return true
		endif
	endif
	return the_form.HasKeyWord(MagicWater)
EndFunction

bool Function isAPlayerSlave(Actor akTarget) ; Is a player's slave
	if akTarget.IsInFaction(DOMPlayerSlaveFaction)
		return true
	endif
	if DOMPAH.isPAH(akTarget)
		return true
	endif
	LogTrace("isAPlayerSlave HSH faction="+HshHouseSlaveFaction)
	If HshHouseSlaveFaction != None
		LogTrace("isAPlayerSlave is in HSH faction="+akTarget.IsInFaction(HshHouseSlaveFaction))
		bool is_slave = akTarget.IsInFaction(HshHouseSlaveFaction)
		if is_slave 
			return true
		endif
	endif
	
	return false
EndFunction

bool Function isAHouseSlave(Actor akTarget) ; Is a player's slave
	LogTrace("isAPlayerSlave HSH faction="+HshHouseSlaveFaction)
	If HshHouseSlaveFaction != None
		LogTrace("isAHouseSlave is in HSH faction="+akTarget.IsInFaction(HshHouseSlaveFaction))
		bool is_slave = akTarget.IsInFaction(HshHouseSlaveFaction)
		if is_slave 
			return true
		endif
	endif
	return false
EndFunction

bool Function isFleeing(Actor akTarget)
	if akTarget == None
		return false
	endif
	if akTarget.IsInFaction(DOMActionFleeing)
		return true
	endif
	if akTarget.IsInFaction(DOMMoodJustCaptured)
		return true
	endif
	return false
EndFunction

bool Function isAnActor(Actor akTarget) ; Is any DOM_Actor
	if akTarget.IsInFaction(DOMActorFaction)
		return true
	endif
	return false
EndFunction

bool Function isAnActorOrASlave(Actor akTarget) ; Is any DOM_Actor
	if akTarget.IsInFaction(DOMActorFaction)
		return true
	endif
	return isASlave(akTarget) 
EndFunction

bool Function isATaskMistress(Actor akTarget)
	if akTarget == None
		return false
	endif
	if HSHStorage == None
		return false
	endif
	if HSHStorage.TaskMasterFaction == None
		return false
	endif
	return akTarget.IsInFaction(HSHStorage.TaskMasterFaction)
EndFunction

bool Function isASlave(Actor akTarget) ; Is any slave
	if akTarget.IsInFaction(DOMPlayerSlaveFaction)
		return true
	endif
	if akTarget.IsInFaction(DOMNotPlayerSlaveFaction)
		return true
	endif
	if DOMPAH.isPAH(akTarget)
		return true
	endif
	If HshHouseSlaveFaction != None
		bool is_slave = akTarget.IsInFaction(HshHouseSlaveFaction)
		if is_slave 
			return true
		endif
	endif
	If AygasSlaveTypeFaction != None
		bool is_slave = akTarget.IsInFaction(AygasSlaveTypeFaction)
		if is_slave 
			return true
		endif
	endif
	
	return false
EndFunction

bool Function isASlaver(Actor akTarget) ; Is any slave
	if akTarget.IsInFaction(DOMNotPlayerSlaverFaction)
		return true
	endif
	if akTarget.IsInFaction(DOMPlayerSlaverFaction)
		return true
	endif
	return false
EndFunction

string Function GetSlaveType(Actor akTarget)
	LogTrace("GetSlaveType akTarget="+akTarget.GetDisplayName()+" mng="+ akTarget.GetFactionRank(DOMSlaveManagerFaction))
	if DOMPAH.isPAH(akTarget)
		return "PAH slave"
	endif
	if akTarget.IsInFaction(DOMActionOnDuty) && akTarget.IsInFaction(DOMActorFaction)
		DOM_Actor akActor = GetActor(akTarget)
		if akActor != None
			return akActor.GetOnDutyTitle()
		endif
	endif
	if akTarget.IsInFaction(DOMPlayerSlaveFaction)
		string title = "Player's "
		int rank = akTarget.GetFactionRank(DOMSlaveManagerFaction)
		if rank == 102
			title += "camp "
		elseif rank == 100
			title += "house "
		endif
		if akTarget.GetFactionRank(DOMPlayerSlaveFaction) == 2
			return title+"trainer"
		else
			return title+"slave"
		endif
	endif
	if akTarget.IsInFaction(DOMNotPlayerSlaveFaction)
		if akTarget.GetFactionRank(DOMNotPlayerSlaveFaction) == 2
			return "Slave trainer"
		else
			return "Slave"
		endif
	endif
	if akTarget.IsInFaction(DOMPlayerSlaverFaction)
		if akTarget.GetLeveledActorBase().GetSex() == 0
			return "Master"
		else
			return "Mistress"
		endif
	endif
	if HshHouseSlaveFaction != None && akTarget.IsInFaction(HshHouseSlaveFaction)
		return "HSH slave"
	elseif AygasSlaveTypeFaction != None && akTarget.IsInFaction(AygasSlaveTypeFaction)
			return  "AYGAS slave"
	elseif DOMZaz.isZazSlave(akTarget)
		return "ZAZ slave"
	endif
	;return "Not a slave"
	if akTarget.IsInFaction(DOMActorInTransfer)
		int rank = akTarget.GetFactionRank(DOMActorInTransfer)
		if rank >= 100
			return "Being transferred to HSH"
		endif
		return "Being transferred to DOM"
	endif
	return "Free person"
EndFunction

Function DOMOpenDiary(Actor akTarget)
	LogTrace("DOMOpenDiary "+akTarget.GetDisplayName())
	DOM_Actor akActor = GetActor(akTarget)
	if akActor == None
		DOMOpenPlayerDiary()
		return
	endif
	DOM_DiaryBook akDiary = DOM04.GetDiary(akActor)
	if akDiary == None
		return
	endif
	akDiary.OpenRead()
EndFunction

Function DOMOpenPlayerDiary()
	LogTrace("DOMOpenPlayerDiary")
	DOM_DiaryBook akDiary = DOM04.DiaryBookPlayer
	if akDiary == None
		return
	endif
	akDiary.OpenRead()
EndFunction

string Function DOMBasicInfo(Actor akTarget)
	string status_msg = GetSlaveType(akTarget)
	string race_msg = GetRaceMessageThirdPerson(akTarget)
	string mood_msg = GetMoodMessage(akTarget)
	string msg = status_msg+" "+akTarget.GetDisplayName()
	if race_msg != ""
		msg += race_msg
		if mood_msg != ""
			msg += " and"+mood_msg
		endif
	elseif mood_msg != ""
		msg += mood_msg
	endif
	return msg
EndFunction

string Function DOMMoodInfo(DOM_Actor akActor)
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return ""
	endif
	Actor akTarget = akActor.akRef
	string msg = DOMBasicInfo(akTarget)+"\n"
	string end_line = "%\n"
	msg += "Runaway "+((akMind.GetChanceRunAway()*100.0) as int)+" / Gang "+((akMind.GetChanceRunAwayGang()*100.0) as int)+" / Yell "+((akMind.ChanceCallForHelp()*100.0) as int)+end_line
	msg += "Angry "+((akMind.GetChanceAngry()*100.0) as int)+" / Defiant "+((akMind.GetChanceDefiant()*100.0) as int)+end_line
	msg += "Afraid "+((akMind.GetChanceAfraid()*100.0) as int)+" / Terrified "+((akMind.GetChanceTerrified()*100.0) as int)+" / Scared "+((akMind.GetChanceScared()*100.0) as int)+end_line
	msg += "Proud "+((akMind.GetChanceProud()*100.0) as int)+" / Ashamed "+((akMind.GetChanceAshamed()*100.0) as int)+end_line
	msg += "Crushed "+((akMind.GetChanceCrushed()*100.0) as int)+" / Sad "+((akMind.GetChanceSad()*100.0) as int)+end_line
	msg += "Shock "+((akMind.GetChanceShock()*100.0) as int)+" / Broken "+((akMind.GetChanceBroken()*100.0) as int)+end_line 
	msg += "In-love "+((akMind.GetChanceInlove()*100.0) as int)+" / Loyal "+((akMind.GetChanceLoyal()*100.0) as int)+end_line
	msg += "Jealous "+((akMind.GetChanceJealous()*100.0)  as int)+" / Depressed "+((akMind.GetChanceDepressed()*100.0) as int)+" / Insecure "+((akMind.GetChanceInsecure()*100.0) as int)+end_line
	msg += "Greed "+((akMind.ChanceAngryForGreed()*100.0) as int)+" / Unfairness "+((akMind.ChanceAngryForUnfairness()*100.0) as int)+" / Injustice "+((akMind.ChanceAngryForInjustice()*100.0) as int)+end_line
	msg += "Happy "+((akMind.GetChanceHappy()*100.0)          as int)+" / Charmed "+((akMind.GetChanceCharmed()*100.0) as int)+end_line
	msg += "Respectful "+((akMind.GetChanceRespectful()*100.0) as int)+" / Fight "+((akMind.GetChanceFightForPlayer()*100.0) as int)+end_line
	return msg
EndFunction

int Function GetMaxRelationShip(Actor akTarget)
	if akTarget.GetActorbase().getSex() == (DOMPlayerAlias.GetPlayerSex() % 2) ; same sex
		if sameSexToggle
			return 4
		endif
	else ; oppositesex
		if oppositeSexToggle
			return 4
		endif
	endif
	return 3
EndFunction

Function SetMinRelationShip(Actor akTarget)
	int relationship_rank = akTarget.GetRelationshipRank(PlayerRef)
	if relationship_rank <= 0
		akTarget.setRelationshipRank(PlayerRef,relationship_rank+1)
	endif
EndFunction

Function IncrementRelationShip(Actor akTarget)
	int relationship_rank = akTarget.GetRelationshipRank(PlayerRef)
	if relationship_rank >= 4
		return
	endif
	if relationship_rank < 3
		akTarget.setRelationshipRank(PlayerRef,relationship_rank+1)
		return
	endif
	; If relation ship rank is 3, check feelings first.
	if akTarget.GetFactionRank(DOMLoveDesire) > 0 || akTarget.GetFactionRank(DOMLoveFascination) > 0 || akTarget.GetFactionRank(DOMLoveAdmiration) > 0
		akTarget.setRelationshipRank(PlayerRef,relationship_rank+1)
		return
	endif
	; If no feelings yet, make a training check
	int stats_level =  akTarget.GetFactionRank(DOMTrainSubmission)+akTarget.GetFactionRank(DOMTrainHumiliation)+akTarget.GetFactionRank(DOMTrainRespect)
	if RandomInt()*300.0 < stats_level
		akTarget.setRelationshipRank(PlayerRef,relationship_rank+1)
		return
	endif
EndFunction

int Function GetPersonalityIndexNPC(Actor akTarget)
	if akTarget == None
		return 0
	endif
	float[] TraitsArray = DOMGenerator.GetNPCTraits(akTarget) ; Just needs the traits, no modifiers
	
	; Strong personality
	float FACET_Smartness = TraitsArray[11]
	float HEXACO_Honesty  = TraitsArray[0]
	if FACET_Smartness > 92.0 && HEXACO_Honesty < 8.0
		return  1 ; Manipulative
	endif
	float FACET_Submissivity  = TraitsArray[9]
	float HEXACO_Emotionality = TraitsArray[1]
	if FACET_Submissivity > 92.0 && HEXACO_Emotionality < 8.0
		return 2 ; Apathetic
	endif
	float FACET_Sensuality    = TraitsArray[8]
	float HEXACO_eXtraversion = TraitsArray[2]
	if FACET_Sensuality > 92.0 && HEXACO_eXtraversion < 8.0
		return 3 ; Languid
	endif
	float FACET_Wilfulness     = TraitsArray[6]
	float HEXACO_Agreeableness = TraitsArray[3]
	if FACET_Wilfulness > 92.0 && HEXACO_Agreeableness < 8.0
		return 4 ; Obstinate
	endif
	float FACET_Toughness          = TraitsArray[7]
	float HEXACO_Conscientiousness = TraitsArray[4]
	if FACET_Toughness > 92.0 && HEXACO_Conscientiousness < 8.0
		return 5 ; Reckless
	endif
	float FACET_Boldness  = TraitsArray[10]
	float HEXACO_Openness = TraitsArray[5]
	if FACET_Boldness > 92.0 && HEXACO_Openness < 8.0
		return 6 ; Brash
	endif
	float Sum_HEXACO = HEXACO_Honesty + HEXACO_Emotionality + HEXACO_eXtraversion + HEXACO_Agreeableness + HEXACO_Conscientiousness + HEXACO_Openness
	float Sum_FACET  = FACET_Wilfulness + FACET_Toughness + FACET_Sensuality + FACET_Submissivity + FACET_Boldness + FACET_Smartness
	if Sum_FACET > 500.0 && Sum_HEXACO < 100.0
		return 7 ; Ruthless
	endif

	if FACET_Smartness < 8.0 && HEXACO_Honesty < 8.0
		return 8 ; Shiftless
	endif
	if FACET_Submissivity < 8.0 && HEXACO_Emotionality < 8.0
		return 9 ; Commanding
	endif
	if FACET_Sensuality < 8.0 && HEXACO_eXtraversion < 8.0
		return 10 ; Austere
	endif
	if FACET_Wilfulness < 8.0 && HEXACO_Agreeableness < 8.0
		return 11 ; Listless
	endif
	if FACET_Toughness < 8.0 && HEXACO_Conscientiousness < 8.0
		return 12 ; Feckless
	endif
	if FACET_Boldness < 8.0 && HEXACO_Openness < 8.0
		return 13 ; Conventional
	endif
	if Sum_FACET < 100.0 && Sum_HEXACO < 100.0
		return 14 ; Stolid
	endif

	if FACET_Smartness < 8.0 && HEXACO_Honesty > 92.0
		return 15 ; Guileless
	endif
	if FACET_Submissivity < 8.0 && HEXACO_Emotionality > 92.0
		return 16 ; Fiery
	endif
	if FACET_Sensuality < 8.0 && HEXACO_eXtraversion > 92.0
		return 17 ; Exuberant
	endif
	if FACET_Wilfulness < 8.0 && HEXACO_Agreeableness > 92.0
		return 18 ; Meek
	endif
	if FACET_Toughness < 8.0 && HEXACO_Conscientiousness > 92.0
		return 19 ; Delicate
	endif
	if FACET_Boldness < 8.0 && HEXACO_Openness > 92.0
		return 20 ; Contemplative
	endif
	if Sum_FACET < 100.0 && Sum_HEXACO > 500.0
		return 21 ; Lambent
	endif

	if FACET_Smartness > 92.0 && HEXACO_Honesty > 92.0
		return 22 ; Wise
	endif
	if FACET_Submissivity > 92.0 && HEXACO_Emotionality > 92.0
		return 23 ; Timid
	endif
	if FACET_Sensuality > 92.0 && HEXACO_eXtraversion > 92.0
		return 24 ; Vivacious
	endif
	if FACET_Wilfulness > 92.0 && HEXACO_Agreeableness > 92.0
		return 25 ; Steadfast
	endif
	if FACET_Toughness > 92.0 && HEXACO_Conscientiousness > 92.0
		return 26 ; Stoic
	endif
	if FACET_Boldness > 92.0 && HEXACO_Openness > 92.0
		return 27 ; Audacious
	endif
	if Sum_FACET > 500.0 && Sum_HEXACO > 500.0
		return 28 ; Magnanimous
	endif

	; Medium personality
	if FACET_Smartness > 84.0 && HEXACO_Honesty < 16.0
		return 1 ; Manipulative
	endif
	if FACET_Submissivity > 84.0 && HEXACO_Emotionality < 16.0
		return 2 ; Apathetic
	endif
	if FACET_Sensuality > 84.0 && HEXACO_eXtraversion < 16.0
		return 3 ; Languid
	endif
	if FACET_Wilfulness > 84.0 && HEXACO_Agreeableness < 16.0
		return 4 ; Obstinate
	endif
	if FACET_Toughness > 84.0 && HEXACO_Conscientiousness < 16.0
		return 5 ; Reckless
	endif
	if FACET_Boldness > 84.0 && HEXACO_Openness < 16.0
		return 6 ; Brash
	endif
	if Sum_FACET > 400.0 && Sum_HEXACO < 200.0
		return 7 ; Ruthless
	endif

	if FACET_Smartness < 16.0 && HEXACO_Honesty < 16.0
		return 8 ; Shiftless
	endif
	if FACET_Submissivity < 16.0 && HEXACO_Emotionality < 16.0
		return 9 ; Commanding
	endif
	if FACET_Sensuality < 16.0 && HEXACO_eXtraversion < 16.0
		return 10 ; Austere
	endif
	if FACET_Wilfulness < 16.0 && HEXACO_Agreeableness < 16.0
		return 11 ; Listless
	endif
	if FACET_Toughness < 16.0 && HEXACO_Conscientiousness < 16.0
		return 12 ; Feckless
	endif
	if FACET_Boldness < 16.0 && HEXACO_Openness < 16.0
		return 13 ; Conventional
	endif
	if Sum_FACET < 200.0 && Sum_HEXACO < 200.0
		return 14 ; Stolid
	endif

	if FACET_Smartness < 16.0 && HEXACO_Honesty > 84.0
		return 15 ; Guileless
	endif
	if FACET_Submissivity < 16.0 && HEXACO_Emotionality > 84.0
		return 16 ; Fiery
	endif
	if FACET_Sensuality < 16.0 && HEXACO_eXtraversion > 84.0
		return 17 ; Exuberant
	endif
	if FACET_Wilfulness < 16.0 && HEXACO_Agreeableness > 84.0
		return 18 ; Meek
	endif
	if FACET_Toughness < 16.0 && HEXACO_Conscientiousness > 84.0
		return 19 ; Delicate
	endif
	if FACET_Boldness < 16.0 && HEXACO_Openness > 84.0
		return 20 ; Contemplative
	endif
	if Sum_FACET < 200.0 && Sum_HEXACO > 400.0
		return 21 ; Lambent
	endif
	
	if FACET_Smartness > 84.0 && HEXACO_Honesty > 84.0
		return 22 ; Wise
	endif
	if FACET_Submissivity > 84.0 && HEXACO_Emotionality > 84.0
		return 23 ; Timid
	endif
	if FACET_Sensuality > 84.0 && HEXACO_eXtraversion > 84.0
		return 24 ; Vivacious
	endif
	if FACET_Wilfulness > 84.0 && HEXACO_Agreeableness > 84.0
		return 25 ; Steadfast
	endif
	if FACET_Toughness > 84.0 && HEXACO_Conscientiousness > 84.0
		return 26 ; Stoic
	endif
	if FACET_Boldness > 84.0 && HEXACO_Openness > 84.0
		return 27 ; Audacious
	endif
	if Sum_FACET > 500.0 && Sum_HEXACO > 500.0
		return 28 ; Magnanimous
	endif
	
	; Faint personality
	if FACET_Smartness > 66.0 && HEXACO_Honesty < 34.0
		return 1 ; Manipulative
	endif
	if FACET_Submissivity > 66.0 && HEXACO_Emotionality < 34.0
		return 2 ; Apathetic
	endif
	if FACET_Sensuality > 66.0 && HEXACO_eXtraversion < 34.0
		return 3 ; Languid 
	endif
	if FACET_Wilfulness > 66.0 && HEXACO_Agreeableness < 34.0
		return 4 ; Obstinate
	endif
	if FACET_Toughness > 66.0 && HEXACO_Conscientiousness < 34.0
		return 5 ; Reckless
	endif
	if FACET_Boldness > 66.0 && HEXACO_Openness < 34.0
		return 6 ; Brash
	endif
	
	if FACET_Smartness < 34.0 && HEXACO_Honesty < 34.0
		return 8 ; Shiftless
	endif
	if FACET_Submissivity < 34.0 && HEXACO_Emotionality < 34.0
		return 9 ; Commanding
	endif
	if FACET_Sensuality < 34.0 && HEXACO_eXtraversion < 34.0
		return 10 ; Austere
	endif
	if FACET_Wilfulness < 34.0 && HEXACO_Agreeableness < 34.0
		return 11 ; Listless
	endif
	if FACET_Toughness < 34.0 && HEXACO_Conscientiousness < 34.0
		return 12 ; Feckless
	endif
	if FACET_Boldness < 34.0 && HEXACO_Openness < 34.0
		return 13 ; Conventional
	endif

	if FACET_Smartness < 34.0 && HEXACO_Honesty > 66.0
		return 15 ; Guileless
	endif
	if FACET_Submissivity < 34.0 && HEXACO_Emotionality > 66.0
		return 16 ; Fiery
	endif
	if FACET_Sensuality < 34.0 && HEXACO_eXtraversion > 66.0
		return 17 ; Exuberant
	endif
	if FACET_Wilfulness < 34.0 && HEXACO_Agreeableness > 66.0
		return 18 ; Meek
	endif
	if FACET_Toughness < 34.0 && HEXACO_Conscientiousness > 66.0
		return 19 ; Delicate
	endif
	if FACET_Boldness < 34.0 && HEXACO_Openness > 66.0
		return 20 ; Contemplative
	endif

	if FACET_Smartness > 66.0 && HEXACO_Honesty > 66.0
		return 22 ; Wise
	endif
	if FACET_Submissivity > 66.0 && HEXACO_Emotionality > 66.0
		return 23 ; Timid
	endif
	if FACET_Sensuality > 66.0 && HEXACO_eXtraversion > 66.0
		return 24 ; Vivacious
	endif
	if FACET_Wilfulness > 66.0 && HEXACO_Agreeableness > 66.0
		return 25 ; Steadfast
	endif
	if FACET_Toughness > 66.0 && HEXACO_Conscientiousness > 66.0
		return 26 ; Stoic
	endif

	return 0 ; plain
EndFunction

Function DOMInfoNPCTraits1(Actor akTarget, int hexaco_trait)
	DOMInfoTraitsMod(akTarget,DOMControlPersonalityDialogue1,hexaco_trait,5.0,2)
	SetMinRelationShip(akTarget)
EndFunction

Function DOMInfoNPCTraits2(Actor akTarget, int hexaco_trait1, int hexaco_trait2)
	DOMInfoTraitsMod(akTarget,DOMControlPersonalityDialogue2,hexaco_trait1,4.0,3)
	int rank = akTarget.GetFactionRank(DOMControlPersonalityDialogue2)
	DOMInfoTraitsMod(akTarget,DOMControlPersonalityDialogue2,hexaco_trait2,4.0,2)
	akTarget.SetFactionRank(DOMControlPersonalityDialogue2,rank)
EndFunction

Function DOMInfoNPCTraits3(Actor akTarget, int hexaco_trait1, int hexaco_trait2)
	int max_relationship = GetMaxRelationShip(akTarget)
	DOMInfoTraitsMod(akTarget,DOMControlPersonalityDialogue3,hexaco_trait1,6.0,max_relationship)
	int rank = akTarget.GetFactionRank(DOMControlPersonalityDialogue3)
	DOMInfoTraitsMod(akTarget,DOMControlPersonalityDialogue3,hexaco_trait2,6.0,3)
	akTarget.SetFactionRank(DOMControlPersonalityDialogue3,rank)
EndFunction

Function DOMInfoNPCTraits4(Actor akTarget, int hexaco_trait1, int hexaco_trait2)
	int max_relationship = GetMaxRelationShip(akTarget)
	DOMInfoTraitsMod(akTarget,DOMControlPersonalityDialogue4,hexaco_trait1,8.0,max_relationship)
	int rank = akTarget.GetFactionRank(DOMControlPersonalityDialogue4)
	DOMInfoTraitsMod(akTarget,DOMControlPersonalityDialogue4,hexaco_trait2,8.0,3)
	akTarget.SetFactionRank(DOMControlPersonalityDialogue4,rank)
EndFunction

Function DOMInfoNPCFeelings1(Actor akTarget, int training_stat)
	DOMInfoTrainingMod(akTarget,DOMControlFeelingsDialogue1,training_stat,8.0,2)
	SetMinRelationShip(akTarget)
EndFunction

Function DOMInfoNPCFeelings2(Actor akTarget, int training_stat)
	DOMInfoTrainingMod(akTarget,DOMControlFeelingsDialogue2,training_stat,10.0,3)
EndFunction

Function DOMInfoNPCFeelings3(Actor akTarget, int training_stat)
	int max_relationship = GetMaxRelationShip(akTarget)
	DOMInfoTrainingMod(akTarget,DOMControlFeelingsDialogue3,training_stat,12.0,max_relationship)
EndFunction

Function DOMInfoNPCFeelings4(Actor akTarget, int training_stat)
	int max_relationship = GetMaxRelationShip(akTarget)
	DOMInfoTrainingMod(akTarget,DOMControlFeelingsDialogue4,training_stat,14.0,max_relationship)
EndFunction

Function DOMInfoNPCMods1(Actor akTarget, int hexaco_trait)
	if hexaco_trait < 0
		hexaco_trait = -(2)
	else
		hexaco_trait += 6
	endif
	int max_relationship = GetMaxRelationShip(akTarget)
	DOMInfoTrainingMod(akTarget,DOMControlModifiersDialogue1,hexaco_trait,10.0,max_relationship)
	int rank = akTarget.GetFactionRank(DOMControlModifiersDialogue1)
	DOMInfoTraitsMod(akTarget,DOMControlModifiersDialogue1,hexaco_trait,6.0,3)
	akTarget.SetFactionRank(DOMControlModifiersDialogue1,rank)
EndFunction

Function DOMInfoNPCMods2(Actor akTarget, int hexaco_trait)
	if hexaco_trait < 0
		hexaco_trait = -(2)
	else
		hexaco_trait += 6
	endif
	int max_relationship = GetMaxRelationShip(akTarget)
	DOMInfoTrainingMod(akTarget,DOMControlModifiersDialogue2,hexaco_trait,12.0,max_relationship)
	int rank = akTarget.GetFactionRank(DOMControlModifiersDialogue2)
	DOMInfoTraitsMod(akTarget,DOMControlModifiersDialogue2,hexaco_trait,8.0,3)
	akTarget.SetFactionRank(DOMControlModifiersDialogue2,rank)
EndFunction

Function DOMInfoTraitsMod(Actor akTarget, Faction contrl_faction, int hexaco_trait, float base_amount, int rel)
	if staticTraitsChat
		DOMInfoTrainingAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
		return
	endif
	if akTarget.isInFaction(DOMActorFaction)
		DOMInfoTraitsAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
	else
		DOMInfoNPCTraitsAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
	endif
EndFunction

Function DOMInfoTrainingMod(Actor akTarget, Faction contrl_faction, int hexaco_trait, float base_amount, int rel)
	if akTarget.isInFaction(DOMActorFaction)
		DOMInfoTrainingAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
	elseif DOMPAH.isPAH(akTarget)
		DOMPAH.InfoTrainingAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
	else
		DOMInfoNPCTrainingAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
	endif
EndFunction

Function DOMInfoNPCTraitsAdjust(Actor akTarget, Faction contrl_faction, int hexaco_trait, float base_amount, int rel)
	;LogTrace("DOMInfoNPCTraitsAdjust: "+akTarget.GetDisplayName()+" trait idx="+hexaco_trait+" amount="+base_amount)
	Faction hexaco_faction
	Faction modify_faction
	if hexaco_trait == -(1)
		hexaco_trait = RandomInt(0,5)
	elseif hexaco_trait < 0
		hexaco_trait = RandomInt(6,11)
	endif
	if hexaco_trait == 0
		hexaco_faction = DOMTraitHonesty
		modify_faction = DOMModHumility
	elseif hexaco_trait == 1
		hexaco_faction = DOMTraitEmotionality
		modify_faction = DOMModFearfulness
	elseif hexaco_trait == 2
		hexaco_faction = DOMTraitExtraversion
		modify_faction = DOMModNaivety
	elseif hexaco_trait == 3
		hexaco_faction = DOMTraitAgreeableness
		modify_faction = DOMModForgiveness
	elseif hexaco_trait == 4
		hexaco_faction = DOMTraitConscientiousness
		modify_faction = DOMModPrudent
	elseif hexaco_trait == 5
		hexaco_faction = DOMTraitOpenness
		modify_faction = DOMModDiscipline
	elseif hexaco_trait == 6
		hexaco_faction = DOMFacetWilfulness
		modify_faction = DOMModCriminality ; easy to go down, hard to go up
	elseif hexaco_trait == 7
		hexaco_faction = DOMFacetToughness
		modify_faction = DOMModSentimentality ; easy to go down, hard to go up
	elseif hexaco_trait == 8
		hexaco_faction = DOMFacetSensuality
		modify_faction = DOMModDaring
	elseif hexaco_trait == 9
		hexaco_faction = DOMFacetSubmissivity
		modify_faction = DOMModImpatience ; easy to go down, hard to go up
	elseif hexaco_trait == 10
		hexaco_faction = DOMFacetBoldness
		modify_faction = DOMModDiligent
	elseif hexaco_trait == 11
		hexaco_faction = DOMFacetSmartness
		modify_faction = DOMModManipulation ; easy to go down, hard to go up
	else
		return
	endif
	if !akTarget.IsInFaction(modify_faction) || !akTarget.IsInFaction(hexaco_faction)
		float[] TraitsArray = DOMGenerator.GetNPCTraitsUpdateModifiers(akTarget)
	endif
	float hexaco_level
	float multiplier
	if akTarget.IsInFaction(hexaco_faction)
		hexaco_level = akTarget.getFactionRank(hexaco_faction) as float
		if hexaco_level < 0.0
			hexaco_level = 0.0
		elseif hexaco_level > 100.0
			hexaco_level = 100.0
		endif
		if hexaco_level >= 50.0
			multiplier = 1.0
		else
			multiplier = -1.0
		endif
	else
		hexaco_level = 50.0
		multiplier   = 1.0
	endif
	int contrl_level
	if contrl_faction != None && akTarget.IsInFaction(contrl_faction)
		contrl_level = akTarget.getFactionRank(contrl_faction)+1
		if contrl_level < 1
			contrl_level = 1
		elseif contrl_level > 125
			contrl_level = 125
		endif
		int relationship_rank = akTarget.GetRelationshipRank(PlayerRef)
		if relationship_rank < rel && relationship_rank < 4
			float x
			if relationship_rank >= 3 ; Emmotionality to become inlove
				x = akTarget.GetFactionRank(DOMTraitEmotionality)+GetModifierFromFaction(akTarget,DOMModSentimentality)/5.0
				int highest_relationship_rank = akTarget.GetHighestRelationshipRank()
				if highest_relationship_rank >= 4
					x *= 0.50 ; already has a lover
				endif
			elseif relationship_rank >= 2 ; Honesty to become close friends
				x = akTarget.GetFactionRank(DOMTraitHonesty)+GetModifierFromFaction(akTarget,DOMModHumility)/5.0
				int highest_relationship_rank = akTarget.GetHighestRelationshipRank()
				if highest_relationship_rank >= 4
					x *= 0.75 ; already has a lover
				elseif highest_relationship_rank >= 3
					x *= 0.85 ; already has close friends but no lover
				endif
			elseif relationship_rank >= 1 ; Agreeableness to become friends
				x = akTarget.GetFactionRank(DOMTraitAgreeableness)+GetModifierFromFaction(akTarget,DOMModForgiveness)/5.0
			elseif relationship_rank >= 0 ; eXtraversion to become acquinted
				x = akTarget.GetFactionRank(DOMTraitExtraversion)+GetModifierFromFaction(akTarget,DOMModDaring)/5.0
			elseif relationship_rank >= -(1) ; openness to get to know
				x = akTarget.GetFactionRank(DOMTraitOpenness)+GetModifierFromFaction(akTarget,DOMModManipulation)/5.0
			else ; Conscientiousness to engage conversation
				x = akTarget.GetFactionRank(DOMTraitConscientiousness)+GetModifierFromFaction(akTarget,DOMModDiligent)/5.0
			endif
			if x > RandomFloat()*1000.0 ; x = 50% + 10% for the average person, so a bit above 1 in 20 chances to increase	
				IncrementRelationShip(akTarget)
			endif
		endif
	else
		contrl_level = 1
	endif
	float amount = base_amount/contrl_level
	float mod = GetModifierFromFaction(akTarget,modify_faction)/100.0
	;LogTrace("DOMInfoNPCTraitsAdjust 1 idx="+hexaco_trait+" mod="+mod+" amount="+amount)
	amount = (multiplier*mod*amount) + 0.5
	if contrl_level < 5
		if amount > 0.0 && amount < 1.0
			amount = 1.0
		elseif amount < 0.0 && amount > -(1.0)
			amount = -1.0
		endif
	endif
	;LogTrace("DOMInfoNPCTraitsAdjust 2 idx="+hexaco_trait+" trait="+hexaco_level+" amount="+amount)
	hexaco_level += amount
	if hexaco_level < 0.0
		hexaco_level = 0.0
	elseif hexaco_level > 100.0
		hexaco_level = 100.0
	endif
	akTarget.setFactionRank(hexaco_faction,(hexaco_level as int))
	if contrl_faction != None && (amount >= 1.0 || amount <= (-1.0))
		int ranknb = akTarget.GetFactionRank(DOMNbChatPersonality)
		if ranknb <= 0
			ranknb = 1
		else
			ranknb += 1
		endif
		akTarget.setFactionRank(DOMNbChatPersonality,ranknb)
		akTarget.setFactionRank(contrl_faction,contrl_level)
		;LogTrace("DOMInfoNPCTraitsAdjust "+akTarget.GetDisplayName()+" idx="+hexaco_trait+" trait="+hexaco_level+" ctrl="+contrl_level+" amount="+amount)
	;else
	;	LogTrace("DOMInfoNPCTraitsAdjust "+akTarget.GetDisplayName()+" idx="+hexaco_trait+" trait="+hexaco_level+" ctrl="+contrl_level+" amount="+amount+" UNCHANGED!")
	endif
EndFunction

Function DOMInfoTraitsAdjust(Actor akTarget, Faction contrl_faction, int hexaco_trait, float base_amount, int rel)
	DOM_Actor akActor = GetActor(akTarget)
	if akActor == None
		DOMInfoNPCTraitsAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		DOMInfoNPCTraitsAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
		return
	endif
	akMind.StartChattingPersonality(PlayerRef,contrl_faction,hexaco_trait,base_amount)
EndFunction

int Function DOMNPCTrainingRandom(Actor akTarget, float amount)
	DOM_Actor akActor = GetActor(akTarget)
	int hexaco_trait
	if akActor != None
		DOM_Mind akMind = akActor.mind
		if akMind != None
			hexaco_trait = akMind.TrainRandom(amount)
			return hexaco_trait
		endif
	endif
	float[] TraitsArray = DOMGenerator.GetNPCTraitsUpdateModifiers(akTarget)
	DOMGenerator.GetTrainingStatsFromFactionsOrRead(akTarget)
	float xh = GetModifierFromFaction(akTarget,DOMModHumility)/100.0
	float xe = GetModifierFromFaction(akTarget,DOMModFearfulness)/100.0
	float xx = GetModifierFromFaction(akTarget,DOMModNaivety)/100.0
	float xa = GetModifierFromFaction(akTarget,DOMModForgiveness)/100.0
	float xc = GetModifierFromFaction(akTarget,DOMModPrudent)/100.0
	float xo = GetModifierFromFaction(akTarget,DOMModDiscipline)/100.0
	float x = RandomFloat()*(xh+xe+xx+xa+xc+xo)
	Faction training_faction
	Faction modifier_faction
	if x < xh
		hexaco_trait     = 0
		training_faction = DOMTrainSubmission
		modifier_faction = DOMModHumility
	elseif x < xh+xe
		hexaco_trait     = 1
		training_faction = DOMTrainFear
		modifier_faction = DOMModFearfulness
	elseif x < xh+xe+xx
		hexaco_trait     = 2
		training_faction = DOMTrainHumiliation
		modifier_faction = DOMModNaivety
	elseif x < xh+xe+xx+xa
		hexaco_trait     = 3
		training_faction = DOMTrainAnger
		modifier_faction = DOMModForgiveness
	elseif x < xh+xe+xx+xa+xc
		hexaco_trait     = 4
		training_faction = DOMTrainResignation
		modifier_faction = DOMModPrudent
	else
		hexaco_trait     = 5
		training_faction = DOMTrainRespect
		modifier_faction = DOMModDiscipline
	endif
	float training_level
	float multiplier
	if akTarget.IsInFaction(training_faction) && hexaco_trait >=0
		training_level = akTarget.getFactionRank(training_faction) as float
		if training_level >= 100.0 && hexaco_trait < 6
			if hexaco_trait == 0
				training_faction = DOMLoveDesire
				modifier_faction = DOMModModesty
			elseif hexaco_trait == 1
				training_faction = DOMLoyalWorship
				modifier_faction = DOMModDependence
			elseif hexaco_trait == 2
				training_faction = DOMLoveFascination
				modifier_faction = DOMModIngenuity
			elseif hexaco_trait == 3
				training_faction = DOMLoyalAbsolution
				modifier_faction = DOMModGentleness
			elseif hexaco_trait == 4
				training_faction = DOMLoyalDevotion
				modifier_faction = DOMModConsideration
			elseif hexaco_trait == 5
				training_faction = DOMLoveAdmiration
				modifier_faction = DOMModCreativity
			endif
			training_level = akTarget.getFactionRank(training_faction) as float
			if training_level >= 100.0
				multiplier = 0.0
			else
				multiplier = 10.0/(training_level*9.0+100.0)*train_speed_love*DOMPlayerAlias.GetDeceiverModifier()
			endif
		elseif training_level <= 0.0
			training_level = 0.0
			multiplier = 1.0
		else
			multiplier = 0.1 + (0.9*(1.0-(training_level/100.0)))
		endif
	else
		training_level = 0.0
		multiplier   = 1.0
	endif
	float mod = GetModifierFromFaction(akTarget,modifier_faction)/100.0
	;LogTrace("DOMInfoNPCTrainingAdjust 1 idx="+hexaco_trait+" mod="+mod+" amount="+amount)
	amount = (multiplier*mod*amount) + 0.5
	if amount < 1.0
		amount = 1.0
	endif
		
	;LogTrace("DOMInfoNPCTrainingAdjust 2 idx="+hexaco_trait+" stat="+training_level+" amount="+amount)
	training_level += amount
	if training_level < 0.0
		training_level = 0.0
	elseif training_level > 100.0
		training_level = 100.0
	endif
	akTarget.setFactionRank(training_faction,(training_level as int))
	return hexaco_trait
EndFunction

Function DOMInfoNPCTrainingAdjust(Actor akTarget, Faction contrl_faction, int hexaco_trait, float base_amount, int rel)
	;LogTrace("DOMInfoNPCTrainingAdjust: "+akTarget.GetDisplayName()+" training idx="+hexaco_trait+" amount="+base_amount)
	Faction training_faction
	Faction modifier_faction
	if hexaco_trait == -(1)
		hexaco_trait = RandomInt(0,5)
	elseif hexaco_trait < 0
		hexaco_trait = RandomInt(6,11)
	endif
	if hexaco_trait == 0
		training_faction = DOMTrainSubmission
		modifier_faction = DOMModHumility
	elseif hexaco_trait == 1
		training_faction = DOMTrainFear
		modifier_faction = DOMModFearfulness
	elseif hexaco_trait == 2
		training_faction = DOMTrainHumiliation
		modifier_faction = DOMModNaivety
	elseif hexaco_trait == 3
		training_faction = DOMTrainAnger
		modifier_faction = DOMModForgiveness
	elseif hexaco_trait == 4
		training_faction = DOMTrainResignation
		modifier_faction = DOMModPrudent
	elseif hexaco_trait == 5
		training_faction = DOMTrainRespect
		modifier_faction = DOMModDiscipline
	elseif hexaco_trait == 6
		training_faction = DOMTrainVaginal
		modifier_faction = DOMModVaginal
	elseif hexaco_trait == 7
		training_faction = DOMTrainAnal
		modifier_faction = DOMModAnal
	elseif hexaco_trait == 8
		training_faction = DOMTrainOral
		modifier_faction = DOMModOral
	elseif hexaco_trait == 9
		training_faction = DOMTrainPose
		modifier_faction = DOMModFlexibility
	elseif hexaco_trait == 10
		training_faction = DOMTrainHouse
		modifier_faction = DOMModPerfectionism
	elseif hexaco_trait == 11
		training_faction = DOMTrainCombat
		modifier_faction = DOMModCombat
	else
		return
	endif
	if !akTarget.IsInFaction(modifier_faction)
		float[] TraitsArray = DOMGenerator.GetNPCTraitsUpdateModifiers(akTarget)
	endif
	if !akTarget.IsInFaction(training_faction)
		DOMGenerator.GetTrainingStatsFromFactionsOrRead(akTarget)
	endif
	float training_level
	float multiplier
	if akTarget.IsInFaction(training_faction) && hexaco_trait >=0
		training_level = akTarget.getFactionRank(training_faction) as float
		if training_level >= 100.0 && hexaco_trait < 6
			if hexaco_trait == 0
				training_faction = DOMLoveDesire
				modifier_faction = DOMModModesty
			elseif hexaco_trait == 1
				training_faction = DOMLoyalWorship
				modifier_faction = DOMModDependence
			elseif hexaco_trait == 2
				training_faction = DOMLoveFascination
				modifier_faction = DOMModIngenuity
			elseif hexaco_trait == 3
				training_faction = DOMLoyalAbsolution
				modifier_faction = DOMModGentleness
			elseif hexaco_trait == 4
				training_faction = DOMLoyalDevotion
				modifier_faction = DOMModConsideration
			elseif hexaco_trait == 5
				training_faction = DOMLoveAdmiration
				modifier_faction = DOMModCreativity
			endif
			training_level = akTarget.getFactionRank(training_faction) as float
			if training_level >= 100.0
				multiplier = 0.0
			else
				multiplier = 10.0/(training_level*9.0+100.0)*train_speed_love*DOMPlayerAlias.GetDeceiverModifier()
			endif
		elseif training_level <= 0.0
			training_level = 0.0
			multiplier = 1.0
		else
			multiplier = 0.1 + (0.9*(1.0-(training_level/100.0)))
		endif
	else
		training_level = 0.0
		multiplier   = 1.0
	endif
	int contrl_level
	if contrl_faction != None && akTarget.IsInFaction(contrl_faction)
		contrl_level = akTarget.getFactionRank(contrl_faction)+1
		if contrl_level < 1
			contrl_level = 1
		elseif contrl_level > 125
			contrl_level = 125
		endif
		int relationship_rank = akTarget.GetRelationshipRank(PlayerRef)
		if relationship_rank < rel && relationship_rank < 4
			float x
			if relationship_rank >= 3 ; Emmotionality to become inlove
				x = akTarget.GetFactionRank(DOMTraitEmotionality)+GetModifierFromFaction(akTarget,DOMModSentimentality)/5.0
				int highest_relationship_rank = akTarget.GetHighestRelationshipRank()
				if highest_relationship_rank >= 4
					x *= 0.50 ; already has a lover
				endif
			elseif relationship_rank >= 2 ; Honesty to become close friends
				x = akTarget.GetFactionRank(DOMTraitHonesty)+GetModifierFromFaction(akTarget,DOMModHumility)/5.0
				int highest_relationship_rank = akTarget.GetHighestRelationshipRank()
				if highest_relationship_rank >= 4
					x *= 0.75 ; already has a lover
				elseif highest_relationship_rank >= 3
					x *= 0.85 ; already has close friends but no lover
				endif
			elseif relationship_rank >= 1 ; Agreeableness to become friends
				x = akTarget.GetFactionRank(DOMTraitAgreeableness)+GetModifierFromFaction(akTarget,DOMModForgiveness)/5.0
			elseif relationship_rank >= 0 ; eXtraversion to become acquinted
				x = akTarget.GetFactionRank(DOMTraitExtraversion)+GetModifierFromFaction(akTarget,DOMModDaring)/5.0
			elseif relationship_rank >= -(1) ; openness to get to know
				x = akTarget.GetFactionRank(DOMTraitOpenness)+GetModifierFromFaction(akTarget,DOMModManipulation)/5.0
			else ; Conscientiousness to engage conversation
				x = akTarget.GetFactionRank(DOMTraitConscientiousness)+GetModifierFromFaction(akTarget,DOMModDiligent)/5.0
			endif
			if x > RandomFloat()*1000.0  ; x = 50% + 10% for the average person, so a bit above 1 in 20 chances to increase
				IncrementRelationShip(akTarget)
			endif
		endif
	else
		contrl_level = 1
	endif
	float amount = base_amount/contrl_level
	float mod = GetModifierFromFaction(akTarget,modifier_faction)/100.0
	;LogTrace("DOMInfoNPCTrainingAdjust 1 idx="+hexaco_trait+" mod="+mod+" amount="+amount)
	amount = (multiplier*mod*amount) + 0.5
	if contrl_level < 5
		if amount < 1.0
			amount = 1.0
		endif
	endif
		
	;LogTrace("DOMInfoNPCTrainingAdjust 2 idx="+hexaco_trait+" stat="+training_level+" amount="+amount)
	training_level += amount
	if training_level < 0.0
		training_level = 0.0
	elseif training_level > 100.0
		training_level = 100.0
	endif
	akTarget.setFactionRank(training_faction,(training_level as int))
	if contrl_faction != None && amount >= 1.0
		int ranknb = akTarget.GetFactionRank(DOMNbChatFeelings)
		if ranknb <= 0
			ranknb = 1
		else
			ranknb += 1
		endif
		akTarget.setFactionRank(DOMNbChatFeelings,ranknb)
		akTarget.setFactionRank(contrl_faction,contrl_level)
		;LogTrace("DOMInfoNPCTrainingAdjust "+akTarget.GetDisplayName()+" idx="+hexaco_trait+" stat="+training_level+" ctrl="+contrl_level+" amount="+amount)
	;else
	;	LogTrace("DOMInfoNPCTrainingAdjust "+akTarget.GetDisplayName()+" idx="+hexaco_trait+" stat="+training_level+" ctrl=UNCHANGED amount="+amount)
	endif
EndFunction

Function DOMInfoTrainingAdjust(Actor akTarget, Faction contrl_faction, int hexaco_trait, float base_amount, int rel)
	DOM_Actor akActor = GetActor(akTarget)
	if akActor == None
		DOMInfoNPCTraitsAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		DOMInfoNPCTraitsAdjust(akTarget,contrl_faction,hexaco_trait,base_amount,rel)
		return
	endif
	akMind.StartChattingFeelings(PlayerRef,contrl_faction,hexaco_trait,base_amount)
EndFunction

Function DOMDialogueFeelings(Actor akTarget)
	;LogTrace("DOMDialogueFeelings: "+wheelsUseVerboseMessage+" "+dialoguesUseVerboseMessage)
	string msg
	if dialoguesUseVerboseMessage
		msg = DOMFeelingsVerboseMessage(akTarget)
	else
		msg = DOMFeelingsMessage(akTarget)
	endif
	SendMessage(msg)
EndFunction

Function NPCDialogueFeelings(Actor akTarget)
	;LogTrace("NPCDialogueFeelings: "+wheelsUseVerboseMessage+" "+dialoguesUseVerboseMessage)
	string msg
	if dialoguesUseVerboseMessage
		msg = NPCFeelingsVerboseMessage(akTarget)
	else
		msg = NPCFeelingsMessage(akTarget)
	endif
	SendMessage(msg)
EndFunction

Function DOMDialogueTraits(Actor akTarget)
	;LogTrace("DOMDialogueTraits: "+wheelsUseVerboseMessage+" "+dialoguesUseVerboseMessage)
	string msg
	if dialoguesUseVerboseMessage
		msg = DOMTraitsVerboseMessage(akTarget)
	else
		msg = DOMTraitsMessage(akTarget)
	endif
	SendMessage(msg)
EndFunction

Function NPCDialogueTraits(Actor akTarget)
	;LogTrace("NPCDialogueTraits: "+wheelsUseVerboseMessage+" "+dialoguesUseVerboseMessage)
	string msg
	if dialoguesUseVerboseMessage
		msg = NPCTraitsVerboseMessage(akTarget)
	else
		msg = NPCTraitsMessage(akTarget)
	endif
	SendMessage(msg)
EndFunction

Function DOMWheelFeelings(Actor akTarget)
	;LogTrace("DOMWheelFeelings: "+wheelsUseVerboseMessage+" "+dialoguesUseVerboseMessage)
	string msg
	if WheelsUseVerboseMessage
		msg = DOMFeelingsVerboseMessage(akTarget)
	else
		msg = DOMFeelingsMessage(akTarget)
	endif
	SendMessage(msg)
EndFunction

Function NPCWheelFeelings(Actor akTarget)
	;LogTrace("NPCWheelFeelings: "+wheelsUseVerboseMessage+" "+dialoguesUseVerboseMessage)
	string msg
	if WheelsUseVerboseMessage
		msg = NPCFeelingsVerboseMessage(akTarget)
	else
		msg = NPCFeelingsMessage(akTarget)
	endif
	SendMessage(msg)
EndFunction

Function DOMWheelTraits(Actor akTarget)
	;LogTrace("DOMWheelTraits: "+wheelsUseVerboseMessage+" "+dialoguesUseVerboseMessage)
	string msg
	if WheelsUseVerboseMessage
		msg = DOMTraitsVerboseMessage(akTarget)
	else
		msg = DOMTraitsMessage(akTarget)
	endif
	SendMessage(msg)
EndFunction

Function NPCWheelTraits(Actor akTarget)
	;LogTrace("NPCWheelTraits: "+wheelsUseVerboseMessage+" "+dialoguesUseVerboseMessage)
	string msg
	if WheelsUseVerboseMessage
		msg = NPCTraitsVerboseMessage(akTarget)
	else
		msg = NPCTraitsMessage(akTarget)
	endif
	SendMessage(msg)
EndFunction

string Function DOMTrainingMessage(DOM_Actor akActor)
	float[] training = new Float[21]
	DOM_Mind akMind = akActor.mind
	training[0] = akMind.submission
	training[1] = akMind.fear_training
	training[2] = akMind.humiliation
	training[3] = akMind.anger_training
	training[4] = akMind.resignation
	training[5] = akMind.respect_training
	training[6] = akMind.pose_training
	training[7] = akMind.sex_training
	training[8] = akMind.combat_training
	training[9] = akMind.house_training
	training[10]= akMind.oral_training
	training[11]= akMind.vaginal_training
	training[12]= akMind.anal_training
	training[13]= akMind.work_training

	training[14]= akMind.skill_enforcer
	training[15]= akMind.skill_persuader
	training[16]= akMind.skill_depraver
	training[17]= akMind.skill_predator
	training[18]= akMind.skill_slaver
	training[19]= akMind.skill_deceiver
	
	training[20]= akMind.timer_for_broken
	
	return GetTrainingMessage(akActor.akRef, training)
EndFunction

string Function NPCTrainingMessage(Actor akTarget)
	if isAnActorOrASlave(akTarget)
		DOM_Actor akActor = GetActor(akTarget)
		if akActor != None
			return DOMTrainingMessage(akActor)
		endif
	endif
	float[] training = new Float[21]
	float[] FeelsArray = DOMGenerator.GetNPCFeelings(akTarget)

	training[0] = FeelsArray[0]
	training[1] = FeelsArray[1]
	training[2] = FeelsArray[2]
	training[3] = FeelsArray[3]
	training[4] = FeelsArray[4]
	training[5] = FeelsArray[5]
	training[6] = akTarget.GetFactionRank(DOMTrainPose)
	training[7] = akTarget.GetFactionRank(DOMTrainSex)
	training[8] = GetFactionRankFloat(akTarget,DOMTrainCombat)
	training[9] = akTarget.GetFactionRank(DOMTrainHouse)
	training[10]= akTarget.GetFactionRank(DOMTrainOral)
	training[11]= akTarget.GetFactionRank(DOMTrainVaginal)
	training[12]= akTarget.GetFactionRank(DOMTrainAnal)
	training[13]= akTarget.GetFactionRank(DOMTrainWorking)

	training[14]= akTarget.GetFactionRank(DOMSkillEnforcer)
	training[15]= akTarget.GetFactionRank(DOMSkillPersuader)
	training[16]= akTarget.GetFactionRank(DOMSkillDepraver)
	training[17]= akTarget.GetFactionRank(DOMSkillPredator)
	training[18]= akTarget.GetFactionRank(DOMSkillSlaver)
	training[19]= akTarget.GetFactionRank(DOMSkillDeceiver)

	training[20]= akTarget.GetFactionRank(DOMTraumaInDays)
	return GetTrainingMessage(akTarget, training)
EndFunction

string Function GetTrainingMessage(Actor akTarget, float[] training)
	string msg = DOMBasicInfo(akTarget)+"\n"
	string msgb = GetBehaviourMessage(akTarget)
	string msgt = GetStatusMessage(akTarget)
	bool isactor = isAnActorOrASlave(akTarget)
	if msgt != ""
		if msgb != ""
			if msg == "" || msg == "\n"
				msg = " is "+msgb+" and "+msgt+"\n"
			else
				msg += " "+msgb+" and "+msgt+"\n"
			endif
		endif
	elseif msgb != ""
		if msg == "" || msg == "\n"
			msg = " is "+msgb+"\n"
		else
			msg += " and "+msgb+"\n"
		endif
	endif
	int x = training[0] as int
	int y = akTarget.GetFactionRank(DOMLoveDesire)
	int z = DOMPAH.GetSubmissionFromFaction(akTarget)
	;LogTrace("x="+x+" y="+y+" z="+z)
	if y > 0
		msg += "Love desire: "+y+"\n"
	elseif z > 0
		msg += "Submission: "+z+"\n"
	elseif !isactor
		msg += "Feeling docile: "+x+"\n"
	endif
	x = training[1] as int
	y = akTarget.GetFactionRank(DOMLoyalWorship)
	z = DOMPAH.GetFearFromFaction(akTarget)
	;LogTrace("x="+x+" y="+y+" z="+z)
	if y > 0
		msg += "Loyal worship: "+y+"\n"
	elseif z > 0
		msg += "Fear training: "+z+"\n"
	elseif !isactor
		msg += "Feeling relaxed: "+x+"\n"
	endif
	x = training[2] as int
	y = akTarget.GetFactionRank(DOMLoveFascination)
	z = DOMPAH.GetHumiliationFromFaction(akTarget)
	if y > 0
		msg += "Love fascination: "+y+"\n"
	elseif z > 0
		msg += "Humiliation: "+z+"\n"
	elseif !isactor
		msg += "Feeling humble: "+x+"\n"
	endif
	x = training[3] as int
	y = akTarget.GetFactionRank(DOMLoyalAbsolution)
	z = DOMPAH.GetAngerFromFaction(akTarget)
	if y > 0
		msg += "Loyal absolution: "+y+"\n"
	elseif z > 0
		msg += "Anger training: "+z+"\n"
	elseif !isactor
		msg += "Feeling lovable: "+x+"\n"
	endif
	x = training[4] as int
	y = akTarget.GetFactionRank(DOMLoyalDevotion)
	z = DOMPAH.GetResignationFromFaction(akTarget)
	if y > 0
		msg += "Loyal devotion: "+y+"\n"
	elseif z > 0
		msg += "Resignation: "+z+"\n"
	elseif !isactor
		msg += "Feeling happy: "+x+"\n"
	endif
	x = training[5] as int
	y = akTarget.GetFactionRank(DOMLoveAdmiration)
	z = DOMPAH.GetRespectFromFaction(akTarget)
	if y > 0
		msg += "Love admiration: "+y+"\n"
	elseif z > 0
		msg += "Respect training: "+z+"\n"
	elseif !isactor
		msg += "Feeling tamed: "+x+"\n"
	endif
	x = training[6] as int
	if x > 0
		msg += "Pose training: "+x+"\n"
	endif
	;x = training[7] as int
	;if x > 0
	;	msg += "Sex training: "+x+"\n"
	;endif
	x = training[10] as int
	if x > 0
		msg += "Oral training: "+x+"\n"
	endif
	x = training[11] as int
	if x > 0
		msg += "Vaginal training: "+x+"\n"
	endif
	x = training[12] as int
	if x > 0
		msg += "Anal training: "+x+"\n"
	endif
	x = training[8] as int
	if x > 0
		msg += "Combat: "+x+"\n"
	endif
	x = training[9] as int
	if x > 0
		msg += "House training: "+x+"\n"
	endif
	x = training[13] as int
	if x > 0
		msg += "Work training: "+x+"\n"
	endif
	x = training[14] as int
	if x > 0
		msg += "Enforcer skill: "+x+"\n"
	endif
	x = training[15] as int
	if x > 0
		msg += "Persuader skill: "+x+"\n"
	endif
	x = training[16] as int
	if x > 0
		msg += "Depraver skill: "+x+"\n"
	endif
	x = training[17] as int
	if x > 0
		msg += "Predator skill: "+x+"\n"
	endif
	x = training[18] as int
	if x > 0
		msg += "Slaver skill: "+x+"\n"
	endif
	x = training[19] as int
	if x > 0
		msg += "Deceiver skill: "+x+"\n"
	endif
	x = training[20] as int
	if x > 0
		msg += "Trauma: "+x+"\n"
	endif

	return msg
EndFunction

string Function GetStatusMessage(Actor akTarget)
	DOM_Actor akActor = GetActor(akTarget)
	if akActor == None
		return "is a free person"
	endif
	if !akActor.mind.is_slave
		return "is a slaver"
	endif
	return akActor.mind.GetTrainingStatusName()
EndFunction

string Function GetBehaviourMessage(Actor akTarget)
	;LogTrace("GetBehaviourMessage() "+akTarget.GetDisplayName()+" DOMActionTied="+akTarget.IsInFaction(DOMActionTied)+" "+DOMActionTied)
	if DOMPAH.isPAH(akTarget)
		return DOMPAH.GetBehaviourMessage(akTarget)
	elseif akTarget.GetFactionRank(DOMActionTied) == 1
		return "is tied"
	elseif akTarget.GetFactionRank(DOMActionTied) == 2
		return "is chained"
	elseif akTarget.GetFactionRank(DOMActionTied) == 4
		return "is restrained in furniture"
	elseif akTarget.IsInFaction(DOMActionTied)
		if akTarget.IsInFaction(DOMActionJailed)
			return "is jailed and restrained"
		else
			return "is restrained"
		endif
	elseif akTarget.GetFactionRank(DOMActionFollowing) == 1
		return "is following you"
	elseif akTarget.GetFactionRank(DOMActionFollowing) == 2
		return "is following a trainer"
	elseif akTarget.GetFactionRank(DOMActionFollowing) == 3
		return "is following someone"
	elseif akTarget.GetFactionRank(DOMActionWaiting) == 2
		return "is busying around"
	elseif akTarget.GetFactionRank(DOMActionWaiting) == 3
		return "is on duty"
	elseif akTarget.IsInFaction(DOMActionWaiting)
		return "is waiting"
	elseif akTarget.GetFactionRank(DOMActionFleeing) == 3
		return "is running away"
	elseif akTarget.IsInFaction(DOMActionFleeing)
		return "is trying to flee"
	elseif akTarget.GetFactionRank(DOMActionPosing) == 2
		return "is sitting in a furniture"
	elseif akTarget.IsInFaction(DOMActionPosing)
		return "is posing"
	elseif akTarget.IsInFaction(DOMActionMasturbating)
		return "is masturbating"
	elseif akTarget.IsInFaction(DOMActionJailed)
		return "is jailed"
	elseif akTarget.GetFactionRank(DOMActionPunishing) == 1
		return "is training slaves"
	elseif akTarget.GetFactionRank(DOMActionPunishing) == 2
		return "is fetching a slave"
	elseif akTarget.GetFactionRank(DOMActionPunishing) == 3
		return "is training a slave"
	elseif akTarget.GetFactionRank(DOMActionTraining) == 1
		return "is training sex slaves"
	elseif akTarget.GetFactionRank(DOMActionTraining) == 2
		return "is fetching a sex slave"
	elseif akTarget.GetFactionRank(DOMActionTraining) == 3
		return "is training a sex slave"
	elseif akTarget.IsInFaction(DOMActionSweeping)
		return "is cleaning"
	elseif akTarget.IsInFaction(DOMActionWorking)
		int rank = akTarget.GetFactionRank(DOMWorkMode)
		if rank == 1
			return "is mining"
		elseif rank == 1
			return "is cutting wood"
		endif
		return "is working"
	elseif akTarget.IsInFaction(DOMActionGuard)
		return "is standing guard"
	elseif akTarget.IsInFaction(DOMActionTravel)
		return "is travelling"
	elseif akTarget.IsInFaction(DOMActionWorking)
		return "is working"
	elseif akTarget.GetFactionRank(DOMActionWaiting) == 4
		return "is doing nothing"
	endif
	return ""
EndFunction

string Function GetRaceMessageFirstPerson(Actor akTarget)
	ActorBase abTarget = akTarget.GetLeveledActorBase()
	if abTarget == None
		return ""
	endif
	Race ActorRace  = abTarget.GetRace()
	if ActorRace == None
		return ""
	endif
	string race_name = ActorRace.GetName()
	if race_name == ""
		return ""
	endif
	string start_char =  StringUtil.GetNthChar(race_name,0)
	string article
	if start_char == "a" || start_char == "e" || start_char == "i" || start_char == "o" || start_char == "u"  
		article = "I am an "
	else
		article = "I am a "
	endif
	return article+race_name
EndFunction

string Function GetRaceMessageThirdPerson(Actor akTarget)
	ActorBase abTarget = akTarget.GetLeveledActorBase()
	if abTarget == None
		return ""
	endif
	Race ActorRace  = abTarget.GetRace()
	if ActorRace == None
		return ""
	endif
	string race_name = ActorRace.GetName()
	if race_name == ""
		return ""
	endif
	string start_char =  StringUtil.GetNthChar(race_name,0)
	string article
	if start_char == "a" || start_char == "e" || start_char == "i" || start_char == "o" || start_char == "u"  
		article = " is an "
	else
		article = " is a "
	endif
	return article+race_name
EndFunction

string Function GetMoodMessage(Actor akTarget)
	if DOMPAH.isPAH(akTarget)
		return DOMPAH.GetMoodMessage(akTarget)
	elseif akTarget.IsInFaction(DOMMoodJustCaptured)
		return " was just captured"
	elseif akTarget.IsInFaction(DOMMoodNeutral)
		return " is ok"
	elseif akTarget.IsInFaction(DOMMoodHappy)
		int rank = akTarget.GetFactionRank(DOMMoodHappy)
		if rank == 1
			return " is fine"
		elseif rank == 2
			return " is happy"
		else
			return " is under your charm"
		endif
	elseif akTarget.IsInFaction(DOMMoodAngry)
		int rank = akTarget.GetFactionRank(DOMMoodAngry)
		if rank == 1
			return " is angry"
		elseif rank == 2
			return " is defiant"
		elseif akTarget.IsInFaction(DOMMoodInlove)
			return " is jealous"
		else
			return " seems angry"
		endif
	elseif akTarget.IsInFaction(DOMMoodAfraid)
		int rank = akTarget.GetFactionRank(DOMMoodAfraid)
		if rank == 1
			return " is afraid"
		elseif rank == 2
			return " is terrified"
		elseif rank == 3
			return " is scared"
		endif
	elseif akTarget.IsInFaction(DOMMoodAshamed)
		int rank = akTarget.GetFactionRank(DOMMoodAshamed)
		if rank == 1
			return " is ashamed"
		elseif rank == 2
			return " is proud"
		elseif akTarget.IsInFaction(DOMMoodInlove)
			return " is insecure"
		else
			return " seems ashamed"
		endif
	elseif akTarget.IsInFaction(DOMMoodSad)
		int rank = akTarget.GetFactionRank(DOMMoodSad)
		if rank == 1
			return " is sad"
		elseif rank == 2
			return " is crushed"
		elseif akTarget.IsInFaction(DOMMoodInlove)
			return " is depressed"
		else
			return " seems sad"
		endif
	elseif akTarget.IsInFaction(DOMMoodShock)
		return " is shocked"
	elseif akTarget.IsInFaction(DOMMoodBroken)
		return " is broken"
	elseif akTarget.IsInFaction(DOMMoodLoyal)
		return " is loyal"
	elseif akTarget.IsInFaction(DOMMoodInlove)
		return " is in love"
	endif
	string the_mood = DOMPAH.GetMoodMessage(akTarget)
	if the_mood != ""
		return the_mood
	endif
	int rank = akTarget.GetRelationshipRank(Game.GetPlayer())
	if rank >= 4
		return " is in love with you"
	elseif rank == 3
		return " really likes you"
	elseif rank == 2
		return " is a good friend"
	elseif rank == 1
		return " is a friend"
	elseif rank == -(1)
		return " is not very friendly"
	elseif rank == -(2)
		return " doesn't like you"
	elseif rank == -(3)
		return " hates you"
	elseif rank <= -(4)
		return " hates your guts"
	endif
	return ""
EndFunction

string Function GetMood(Actor akTarget)
	if akTarget.IsChild()
		int rank = akTarget.getRelationshipRank(PlayerRef)
		if rank >= 4
			return "charmed"
		elseif rank >= 2
			return "happy"
		endif
		return "ok"
	endif
	if akTarget.IsInFaction(DOMMoodBroken)
		return "broken"
	endif
	if akTarget.IsInFaction(DOMMoodHappy)
		int rank = akTarget.GetFactionRank(DOMMoodHappy)
		if rank == 1
			return "fine"
		elseif rank == 2
			return "happy"
		else
			return "charmed"
		endif
	endif
	if akTarget.IsInFaction(DOMMoodSad)
		int rank = akTarget.GetFactionRank(DOMMoodSad)
		if rank == 1
			return "sad"
		else
			return "unhappy"
		endif
	endif
	if akTarget.IsInFaction(DOMMoodShock)
		return "shocked"
	endif
	if akTarget.IsInFaction(DOMMoodJustCaptured)
		return "being abducted"
	endif
	if akTarget.IsInFaction(DOMMoodAshamed)
		int rank = akTarget.GetFactionRank(DOMMoodAshamed)
		if rank == 1
			return "ashamed"
		elseif rank == 2
			return "proud"
		else
			return "insecure"
		endif
	endif
	if akTarget.IsInFaction(DOMMoodAngry)
		int rank = akTarget.GetFactionRank(DOMMoodAngry)
		if rank == 1
			return "angry"
		elseif rank == 2
			return "defiant"
		else
			return "jealous"
		endif
	endif
	if akTarget.IsInFaction(DOMMoodAfraid)
		int rank = akTarget.GetFactionRank(DOMMoodAfraid)
		if rank == 1
			return "afraid"
		elseif rank == 2
			return "terrified"
		else
			return "scared"
		endif
	endif
	if akTarget.IsInFaction(DOMMoodInlove)
		return "in love"
	endif
	if akTarget.IsInFaction(DOMMoodLoyal)
		return "loyal"
	endif
	int rank = akTarget.getRelationshipRank(PlayerRef)
	if rank == 3
		return "loyal"
	elseif rank > 3
		return "in love"
	endif
	string the_mood = DOMPAH.GetMood(akTarget)
	if the_mood != ""
		return the_mood
	endif
	return "ok"
EndFunction


; Feeling messages for slaves
string[] str_feel_message08
string[] str_feel_message16
string[] str_feel_message34
string[] str_feel_message50
string[] str_feel_message66
string[] str_feel_message84
string[] str_feel_message92

; Same for NPCs
string[] str_npcs_message08
string[] str_npcs_message16
string[] str_npcs_message34
string[] str_npcs_message50
string[] str_npcs_message66
string[] str_npcs_message84
string[] str_npcs_message92

; Love messages for slaves
string[] str_love_message08
string[] str_love_message16
string[] str_love_message34
string[] str_love_message50
string[] str_love_message66
string[] str_love_message84
string[] str_love_message92

; Same for NPCs
string[] str_npc2_message08
string[] str_npc2_message16
string[] str_npc2_message34
string[] str_npc2_message50
string[] str_npc2_message66
string[] str_npc2_message84
string[] str_npc2_message92

string[] str_trait_message_low
string[] str_trait_message_lc1
string[] str_trait_message_lc2
string[] str_trait_message_hig
string[] str_trait_message_hc1
string[] str_trait_message_hc2
int[]    str_trait_xcorrel_lc1
int[]    str_trait_xcorrel_lc2
int[]    str_trait_xcorrel_hc1
int[]    str_trait_xcorrel_hc2

string Function GetNPCFeelMessage(int ifeel, int stat)
	string msg
	if(stat<8) 
		return str_npcs_message08[ifeel]
	elseif(stat<16) 
		return str_npcs_message16[ifeel]
	elseif(stat<34) 
		return str_npcs_message34[ifeel]
	elseif(stat>=200) 
		return str_npc2_message92[ifeel]
	elseif(stat>=184) 
		return str_npc2_message84[ifeel]
	elseif(stat>=166) 
		return str_npc2_message66[ifeel]
	elseif(stat>=150) 
		return str_npc2_message50[ifeel]
	elseif(stat>=134) 
		return str_npc2_message34[ifeel]
	elseif(stat>=116) 
		return str_npc2_message16[ifeel]
	elseif(stat>=108) 
		return str_npc2_message08[ifeel]
	elseif(stat>=92) 
		return str_npcs_message92[ifeel]
	elseif(stat>=84) 
		return str_npcs_message84[ifeel]
	elseif(stat>=66) 
		return str_npcs_message66[ifeel]
	endif	
	return str_npcs_message50[ifeel]
EndFunction

string Function GetFeelMessage(int ifeel, int stat, string mstr)
	if(stat<8) 
		return DOM_Util.ReplaceText(str_feel_message08[ifeel],"<MSTR>",mstr)
	elseif(stat<16) 
		return DOM_Util.ReplaceText(str_feel_message16[ifeel],"<MSTR>",mstr)
	elseif(stat<34) 
		return DOM_Util.ReplaceText(str_feel_message34[ifeel],"<MSTR>",mstr)
	elseif(stat>=200) 
		return DOM_Util.ReplaceText(str_love_message92[ifeel],"<MSTR>",mstr)
	elseif(stat>=184) 
		return DOM_Util.ReplaceText(str_love_message84[ifeel],"<MSTR>",mstr)
	elseif(stat>=166) 
		return DOM_Util.ReplaceText(str_love_message66[ifeel],"<MSTR>",mstr)
	elseif(stat>=150) 
		return DOM_Util.ReplaceText(str_love_message50[ifeel],"<MSTR>",mstr)
	elseif(stat>=134) 
		return DOM_Util.ReplaceText(str_love_message34[ifeel],"<MSTR>",mstr)
	elseif(stat>=116) 
		return DOM_Util.ReplaceText(str_love_message16[ifeel],"<MSTR>",mstr)
	elseif(stat>=108) 
		return DOM_Util.ReplaceText(str_love_message08[ifeel],"<MSTR>",mstr)
	elseif(stat>=92) 
		return DOM_Util.ReplaceText(str_feel_message92[ifeel],"<MSTR>",mstr)
	elseif(stat>=84) 
		return DOM_Util.ReplaceText(str_feel_message84[ifeel],"<MSTR>",mstr)
	elseif(stat>=66) 
		return DOM_Util.ReplaceText(str_feel_message66[ifeel],"<MSTR>",mstr)
	endif	
	return DOM_Util.ReplaceText(str_feel_message50[ifeel],"<MSTR>",mstr)
EndFunction

string Function GetTraitMessage(int itrait, float[] traits)
	if itrait == 0 && traits[0] < 34 && traits[1] < 34 && traits[2] < 34 && traits[3] < 34
		; extra low honesty descriptions because of -0 index not existing
		return "a psycho"
	endif
	if itrait == 11 && traits[0] < 34 && traits[11] >= 66
		; extra low honesty descriptions because of -0 index not existing
		return "machiavellian"
	endif
	if traits[itrait] < 34
		int i1 = str_trait_xcorrel_lc1[itrait]
		if i1 >= 0 && traits[i1] >= 66
			return str_trait_message_lc1[itrait]
		elseif i1 < 0 && traits[-(i1)] < 34
			return str_trait_message_lc1[itrait]
		endif
		int i2 = str_trait_xcorrel_lc2[itrait]
		if i2 >= 0 && traits[i2] >= 66
			return str_trait_message_lc2[itrait]
		elseif i2 < 0 && traits[-(i2)] < 34
			return str_trait_message_lc2[itrait]
		endif
		return str_trait_message_low[itrait]
	elseif traits[itrait] >= 66
		int i1 = str_trait_xcorrel_hc1[itrait]
		if i1 >= 0 && traits[i1] >= 66
			return str_trait_message_hc1[itrait]
		elseif i1 < 0 && traits[-(i1)] < 34
			return str_trait_message_hc1[itrait]
		endif
		int i2 = str_trait_xcorrel_hc2[itrait]
		if i2 >= 0 && traits[i2] >= 66
			return str_trait_message_hc2[itrait]
		elseif i2 < 0 && traits[-(i2)] < 34
			return str_trait_message_hc2[itrait]
		endif
		return str_trait_message_hig[itrait]
	endif
	return ""
EndFunction

Function SetStrMessages()
	str_feel_message08 = new string[6]
	str_feel_message16 = new string[6]
	str_feel_message34 = new string[6]
	str_feel_message50 = new string[6]
	str_feel_message66 = new string[6]
	str_feel_message84 = new string[6]
	str_feel_message92 = new string[6]

	str_npcs_message08 = new string[6]
	str_npcs_message16 = new string[6]
	str_npcs_message34 = new string[6]
	str_npcs_message50 = new string[6]
	str_npcs_message66 = new string[6]
	str_npcs_message84 = new string[6]
	str_npcs_message92 = new string[6]

	str_love_message08 = new string[6]
	str_love_message16 = new string[6]
	str_love_message34 = new string[6]
	str_love_message50 = new string[6]
	str_love_message66 = new string[6]
	str_love_message84 = new string[6]
	str_love_message92 = new string[6]

	str_npc2_message08 = new string[6]
	str_npc2_message16 = new string[6]
	str_npc2_message34 = new string[6]
	str_npc2_message50 = new string[6]
	str_npc2_message66 = new string[6]
	str_npc2_message84 = new string[6]
	str_npc2_message92 = new string[6]
	
	; Am I in danger? = Submission = Defiant/Docile = Humility = honesty - wilpower = Is obedient
	str_feel_message08[0] = "<MSTR> better keep distance from me!"
	str_feel_message16[0] = "<MSTR> better not dare to hurt me one more time."
	str_feel_message34[0] = "What does <MSTR> want from me?"
	str_feel_message50[0] = "I will learn, I promised to <MSTR>."
	str_feel_message66[0] = "I hope <MSTR> doesn't hurt me anymore."
	str_feel_message84[0] = "Mercy! I will do whatever <MSTR> wants!"
	str_feel_message92[0] = "I am an obedient slave. I hope <MSTR> will be gentle with me."
	; same for non slave NPC
	str_npcs_message08[0] = "better than ever"
	str_npcs_message16[0] = "good"
	str_npcs_message34[0] = "None of your business"
	str_npcs_message50[0] = "a bit passive"
	str_npcs_message66[0] = "kind of passive"
	str_npcs_message84[0] = "passive"
	str_npcs_message92[0] = "docile"

	; Love desire
	str_love_message08[0] = "I wish <MSTR> spends more time with me."
	str_love_message16[0] = "I hope <MSTR> uses me again."
	str_love_message34[0] = "I get the shivers when <MSTR> gives me orders."
	str_love_message50[0] = "I love it when <MSTR> gives me orders!"
	str_love_message66[0] = "I am here for <MSTR> to use!"
	str_love_message84[0] = "I am <MSTR>'s sex slave!"
	str_love_message92[0] = "I live only to fulfil <MSTR>'s desires!"
	; same for non slave NPC
	str_npc2_message08[0] = "great"
	str_npc2_message16[0] = "really great"
	str_npc2_message34[0] = "awesome"
	str_npc2_message50[0] = "sublime"
	str_npc2_message66[0] = "desirable"
	str_npc2_message84[0] = "sexy"
	str_npc2_message92[0] = "horny"
	
	; What can I do? = Fear training = Nervous/Relaxed = Fearfulness = Emotionality - Toughness = Feels powerless
	str_feel_message08[1] = "I have defeated enemies more impressive than <MSTR>." 
	str_feel_message16[1] = "I am not afraid of <MSTR>."
	str_feel_message34[1] = "What is going to happen to me?"
	str_feel_message50[1] = "I will be good, but <MSTR> has to stop shouting."
	str_feel_message66[1] = "If <MSTR> shows some lenience, I will behave."
	str_feel_message84[1] = "I surrender, this crazyness has to stop."
	str_feel_message92[1] = "I am always listening to <MSTR>."
	; same for non slave NPC
	str_npcs_message92[1] = "anxious"
	str_npcs_message84[1] = "irritated"
	str_npcs_message66[1] = "annoyed"
	str_npcs_message50[1] = "worried"
	str_npcs_message34[1] = "tranquil"
	str_npcs_message16[1] = "calm"
	str_npcs_message08[1] = "relaxed"

	; Loyal worship
	str_love_message08[1] = "I would be foolish to provoke <MSTR>'s wrath." 
	str_love_message16[1] = "<MSTR> is so strong."
	str_love_message34[1] = "Our enemies are no match to <MSTR>."
	str_love_message50[1] = "I believe <MSTR> is indeed the Dragonborn."
	str_love_message66[1] = "<MSTR> is truly unrivalled!"
	str_love_message84[1] = "<MSTR> is certainly one of the divines!"
	str_love_message92[1] = "<MSTR> is the one and only god!"
	; same for non slave NPC
	str_npc2_message92[1] = "fanatical"
	str_npc2_message84[1] = "zealous"
	str_npc2_message66[1] = "in awe"
	str_npc2_message50[1] = "converted"
	str_npc2_message34[1] = "dedicated"
	str_npc2_message16[1] = "admirative"
	str_npc2_message08[1] = "intimidated"
	
	; Noone should know! = Humiliation = Humble/Proud = Lack of Confidence = -eXtraversion + Sensuality = Feels degraded
	str_feel_message08[2] = "I would rather die than let <MSTR> touch me."
	str_feel_message16[2] = "<MSTR> better not dare touching me!"
	str_feel_message34[2] = "<MSTR> should never try to touch me ever again!"
	str_feel_message50[2] = "<MSTR> disgusts me!"
	str_feel_message66[2] = "How did I let this happen?"
	str_feel_message84[2] = "I feel so humiliated."
	str_feel_message92[2] = "I feel so dirty and degraded."
	; same for non slave NPC
	str_npcs_message92[2] = "degraded"
	str_npcs_message84[2] = "humiliated"
	str_npcs_message66[2] = "ashamed"
	str_npcs_message50[2] = "easy"
	str_npcs_message34[2] = "proud"
	str_npcs_message16[2] = "amazing"
	str_npcs_message08[2] = "holier than you"

	; Love fascination
	str_love_message08[2] = "I am learning to be a good pet."
	str_love_message16[2] = "I didn't think I would enjoy this."
	str_love_message34[2] = "I love being objectified."
	str_love_message50[2] = "<MSTR> can dispose of me at will."
	str_love_message66[2] = "I hope I am a good pet for <MSTR>!"
	str_love_message84[2] = "I am <MSTR>'s horny pet!"
	str_love_message92[2] = "I live to be <MSTR>'s thing!"
	; same for non slave NPC
	str_npc2_message08[2] = "aroused"
	str_npc2_message16[2] = "excited"
	str_npc2_message34[2] = "lustful"
	str_npc2_message50[2] = "captivated"
	str_npc2_message66[2] = "hypnotized"
	str_npc2_message84[2] = "enraptured"
	str_npc2_message92[2] = "fascinated"

	; Is it my fault? = Anger training = Hate/love = forgiveness = Agreeableness + Submissivity = Feels guilty
	str_feel_message08[3] = "When I get free <MSTR> will regret this!"
	str_feel_message16[3] = "Who does <MSTR> think they are?"
	str_feel_message34[3] = "<MSTR>'ll pay for what happened to me!"
	str_feel_message50[3] = "Why me? Did I do something wrong?"
	str_feel_message66[3] = "I get it, <MSTR> has the power!"
	str_feel_message84[3] = "I didn't mean to provoke <MSTR>'s anger."
	str_feel_message92[3] = "I feel so sorry for my behaviour, I will try my best for <MSTR>."
	; same for non slave NPC
	str_npcs_message08[3] = "rebellious"
	str_npcs_message16[3] = "defiant"
	str_npcs_message34[3] = "obstinated"
	str_npcs_message50[3] = "good"
	str_npcs_message66[3] = "bitter"
	str_npcs_message84[3] = "suppressed"
	str_npcs_message92[3] = "tamed"

	; Loyal absolution
	str_love_message08[3] = "<MSTR> is not perfect, but I am not perfect either."
	str_love_message16[3] = "I understand it's not all <MSTR>'s fault."
	str_love_message34[3] = "All is forgiven, <MSTR> should be forgiven too."
	str_love_message50[3] = "<MSTR> knows better what's good for me!"
	str_love_message66[3] = "<MSTR> is an example for us all."
	str_love_message84[3] = "I wish I was like <MSTR>, flawless!"
	str_love_message92[3] = "<MSTR> is perfect, and I am trying hard to be too."
	; same for non slave NPC
	str_npc2_message08[3] = "indulgent"
	str_npc2_message16[3] = "understanding"
	str_npc2_message34[3] = "forgiving"
	str_npc2_message50[3] = "dazzled"
	str_npc2_message66[3] = "blinded"
	str_npc2_message84[3] = "transformed"
	str_npc2_message92[3] = "under a spell"

	; Can I escape? = Resignation = Sad/Happy = Prudent = Conscientiousness - Boldness = Feels helpless
	str_feel_message08[4] = "I will escape in no time."
	str_feel_message16[4] = "There must be a way out of here."
	str_feel_message34[4] = "Am I never going to escape this hell?"
	str_feel_message50[4] = "Will someone ever come and rescue me?"
	str_feel_message66[4] = "I guess this is my life now."
	str_feel_message84[4] = "I stopped thinking, I just obey blindly."
	str_feel_message92[4] = "I'll do everything <MSTR> says."
	; same for non slave NPC
	str_npcs_message92[4] = "broken"
	str_npcs_message84[4] = "sad"
	str_npcs_message66[4] = "down"
	str_npcs_message50[4] = "at peace"
	str_npcs_message34[4] = "merry"
	str_npcs_message16[4] = "happy"
	str_npcs_message08[4] = "joyful"

	; Loyal devotion
	str_love_message08[4] = "I am at <MSTR>'s service."
	str_love_message16[4] = "It is my duty to serve <MSTR>."
	str_love_message34[4] = "I am at <MSTR>'s disposal."
	str_love_message50[4] = "It is my pleasure to serve <MSTR>."
	str_love_message66[4] = "I am here at <MSTR>'s orders!"
	str_love_message84[4] = "<MSTR> is magnificent and <MSTR>'s wishes, are my orders!"
	str_love_message92[4] = "I would die for <MSTR>!"
	; same for non slave NPC
	str_npc2_message08[4] = "helpful"
	str_npc2_message16[4] = "committed"
	str_npc2_message34[4] = "reliable"
	str_npc2_message50[4] = "entrusted"
	str_npc2_message66[4] = "trusted"
	str_npc2_message84[4] = "faithful"
	str_npc2_message92[4] = "devoted"

	; Am I worthless?  = Respect training = Victim/Free = Conventionality = -Openness -Smart = Has low self-esteem
	str_feel_message08[5] = "I will make <MSTR> pay for what happened to me!"
	str_feel_message16[5] = "<MSTR> has no right to give me orders!"
	str_feel_message34[5] = "This is a mistake, I have another destiny."
	str_feel_message50[5] = "I feel it's this or the slave market."
	str_feel_message66[5] = "I feel so worthless."
	str_feel_message84[5] = "I hope <MSTR> knows I can be useful."
	str_feel_message92[5] = "I hope <MSTR>, does not get rid of me."
	; same for non slave NPC
	str_npcs_message92[5] = "branded"
	str_npcs_message84[5] = "resigned"
	str_npcs_message66[5] = "meek"
	str_npcs_message50[5] = "ok"
	str_npcs_message34[5] = "satisfied"
	str_npcs_message16[5] = "relieved"
	str_npcs_message08[5] = "free"

	; Love admiration
	str_love_message08[5] = "This humble slave only wish is to serve <MSTR>."
	str_love_message16[5] = "I would be so honoured to be <MSTR>'s sex slave."
	str_love_message34[5] = "I long for the touch of <MSTR>'s hands."
	str_love_message50[5] = "One look from <MSTR> is all I need!"
	str_love_message66[5] = "I literally melt when <MSTR> looks at me."
	str_love_message84[5] = "<MSTR> is the one and only one!"
	str_love_message92[5] = "I shout your name to the sky: <MSTR>!"
	; same for non slave NPC
	str_npc2_message08[5] = "hooked"
	str_npc2_message16[5] = "charmed"
	str_npc2_message34[5] = "bewitched"
	str_npc2_message50[5] = "passionate"
	str_npc2_message66[5] = "infatuated"
	str_npc2_message84[5] = "enamoured"
	str_npc2_message92[5] = "in love"
	
	str_trait_message_low = new string[12]
	str_trait_message_lc1 = new string[12]
	str_trait_message_lc2 = new string[12]
	str_trait_message_hig = new string[12]
	str_trait_message_hc1 = new string[12]
	str_trait_message_hc2 = new string[12]
	str_trait_xcorrel_lc1 = new int[12]
	str_trait_xcorrel_lc2 = new int[12]
	str_trait_xcorrel_hc1 = new int[12]
	str_trait_xcorrel_hc2 = new int[12]

	str_trait_message_low[0] = "against rules"    ; not honest
	str_trait_xcorrel_lc1[0] = -5
	str_trait_message_lc1[0] = "mean"             ; & not open-minded
	str_trait_xcorrel_lc2[0] = 2
	str_trait_message_lc2[0] = "narcissistic"     ; & lively
	;
	str_trait_message_hig[0] = "honest"           ; honest
	str_trait_xcorrel_hc1[0] = -11
	str_trait_message_hc1[0] = "naive"            ; not smart ; was severe = honest & grumpy
	str_trait_xcorrel_hc2[0] = 3
	str_trait_message_hc2[0] = "gentle"           ; & friendly

	str_trait_message_hig[1] = "anxious"          ; not calm
	str_trait_xcorrel_hc1[1] = 3
	str_trait_message_hc1[1] = "sentimental"      ; & friendly
	str_trait_xcorrel_hc2[1] = 2
	str_trait_message_hc2[1] = "a drama queen"    ; & lively
	;
	str_trait_message_low[1] = "calm"             ; calm
	str_trait_xcorrel_lc1[1] = 10
	str_trait_message_lc1[1] = "fearless"         ; & bold
	str_trait_xcorrel_lc2[1] = 4
	str_trait_message_lc2[1] = "careful"          ; & thorough

	str_trait_message_low[2] = "shy"              ; not lively
	str_trait_xcorrel_lc1[2] = 0
	str_trait_message_lc1[2] = "modest"           ; & honest
	str_trait_xcorrel_lc2[2] = 10
	str_trait_message_lc2[2] = "reserved"         ; & bold
	;
	str_trait_message_hig[2] = "outgoing"         ; lively
	str_trait_xcorrel_hc1[2] = 8
	str_trait_message_hc1[2] = "slutty"           ; & sensual
	str_trait_xcorrel_hc2[2] = 6
	str_trait_message_hc2[2] = "a fury"           ; & strong-willed

	str_trait_message_low[3] = "grumpy"           ; not friendly
	str_trait_xcorrel_lc1[3] = 2
	str_trait_message_lc1[3] = "bitchy"           ; & lively
	str_trait_xcorrel_lc2[3] = -5
	str_trait_message_lc2[3] = "arrogant"         ; & conservative
	;
	str_trait_message_hig[3] = "friendly"         ; friendly
	str_trait_xcorrel_hc1[3] = -1
	str_trait_message_hc1[3] = "patient"          ; & calm
	str_trait_xcorrel_hc2[3] = 2
	str_trait_message_hc2[3] = "sociable"         ; & lively

	str_trait_message_low[4] = "lazy"             ; not thorough
	str_trait_xcorrel_lc1[4] = -5
	str_trait_message_lc1[4] = "a leech"          ; & not open-minded
	str_trait_xcorrel_lc2[4] = 6
	str_trait_message_lc2[4] = "efficient"        ; & strong-willed
	;
	str_trait_message_hig[4] = "hard-working"     ; thorough
	str_trait_xcorrel_hc1[4] = 1
	str_trait_message_hc1[4] = "perfectionist"    ; & anxious
	str_trait_xcorrel_hc2[4] = -11
	str_trait_message_hc2[4] = "dull"             ; & stupid

	str_trait_message_low[5] = "conservative"     ; not open-minded
	str_trait_xcorrel_lc1[5] = -8
	str_trait_message_lc1[5] = "conventional"     ; & frigid
	str_trait_xcorrel_lc2[5] = 3
	str_trait_message_lc2[5] = "protective"       ; & friendly
	;
	str_trait_message_hig[5] = "open-minded"      ; open-minded
	str_trait_xcorrel_hc1[5] = -1
	str_trait_message_hc1[5] = "flexible"         ; & calm
	str_trait_xcorrel_hc2[5] = 3
	str_trait_message_hc2[5] = "forgiving"        ; & friendly

	str_trait_message_low[6] = "weak-willed"      ; weak-willed
	str_trait_xcorrel_lc1[6] = -10
	str_trait_message_lc1[6] = "spineless"        ; & not bold
	str_trait_xcorrel_lc2[6] = 10
	str_trait_message_lc2[6] = "a follower"       ; & bold
	;
	str_trait_message_hig[6] = "strong-willed"    ; strong-willed
	str_trait_xcorrel_hc1[6] = 4
	str_trait_message_hc1[6] = "organized"        ; & thorough
	str_trait_xcorrel_hc2[6] = 10
	str_trait_message_hc2[6] = "courageous"       ; & bold

	str_trait_message_low[7]= "delicate"         ; not tough
	str_trait_xcorrel_lc1[7]= 8
	str_trait_message_lc1[7]= "ticklish"         ; & sensual
	str_trait_xcorrel_lc2[7]= 1
	str_trait_message_lc2[7]= "hypersensitive"   ; & anxious
	;
	str_trait_message_hig[7]= "tough"            ; tough
	str_trait_xcorrel_hc1[7]= -8
	str_trait_message_hc1[7]= "a cold person"    ; & frigid
	str_trait_xcorrel_hc2[7]= -2
	str_trait_message_hc2[7]= "reclusive"        ; & shy

	str_trait_message_low[8] = "frigid"           ; not sensual
	str_trait_xcorrel_lc1[8] = 0
	str_trait_message_lc1[8] = "prude"            ; & honest
	str_trait_xcorrel_lc2[8] = -3
	str_trait_message_lc2[8] = "bitter"           ; & grumpy
	;
	str_trait_message_hig[8] = "sensual"          ; sensual
	str_trait_xcorrel_hc1[8] = 5
	str_trait_message_hc1[8] = "a libertine"      ; & open-minded
	str_trait_xcorrel_hc2[8] = -3
	str_trait_message_hc2[8] = "frustrated"       ; & grumpy

	str_trait_message_low[9]= "dominant"         ; not submissive
	str_trait_xcorrel_lc1[9]= 11
	str_trait_message_lc1[9]= "a pervert"        ; & smart
	str_trait_xcorrel_lc2[9]= -5
	str_trait_message_lc2[9]= "a sicko"          ; & not open minded
	;
	str_trait_message_hig[9]= "submissive"       ; submissive
	str_trait_xcorrel_hc1[9]= 2
	str_trait_message_hc1[9]= "demanding"        ; & lively
	str_trait_xcorrel_hc2[9]= 8
	str_trait_message_hc2[9]= "a whore"          ; & sensual

	str_trait_message_low[10] = "needy"            ; not bold
	str_trait_xcorrel_lc1[10] = 2
	str_trait_message_lc1[10] = "an attention whore" ; & lively
	str_trait_xcorrel_lc2[10] = 6
	str_trait_message_lc2[10] = "clingy"           ; & strong-willed
	;
	str_trait_message_hig[10] = "independent"      ; bold
	str_trait_xcorrel_hc1[10] = 2
	str_trait_message_hc1[10] = "spirited"         ; & lively
	str_trait_xcorrel_hc2[10] = 7
	str_trait_message_hc2[10] = "adventurous"      ; & tough

	str_trait_message_low[11] = "stupid"           ; not smart
	str_trait_xcorrel_lc1[11] = 6
	str_trait_message_lc1[11] = "stubborn"         ; & strong-willed
	str_trait_xcorrel_lc2[11] = -5
	str_trait_message_lc2[11] = "a brute"          ; & not open minded
	;
	str_trait_message_hig[11] = "smart"            ; smart
	str_trait_xcorrel_hc1[11] = 0
	str_trait_message_hc1[11] = "serious"          ; & honest
	str_trait_xcorrel_hc2[11] = -5
	str_trait_message_hc2[11] = "sadistic"         ; & not open minded
EndFunction

string Function DOMMoodMessage(Actor akTarget)
	if akTarget.IsChild()
		return NPCMoodMessage(akTarget)
	endif
	DOM_Actor akActor = GetActor(akTarget)
	LogTrace("DOMMoodMessage akTarget="+akTarget.GetDisplayName()+" akActor="+akActor)
	if akActor == None
		return ActorMoodMessage(akTarget)
	endif
	DOM_Mind akMind = akActor.mind
	string mstr
	if akMind != None
		mstr = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.IsRespectfulWritings())
	else
		mstr = DOMPlayerAlias.GetPlayerTitle()
	endif
	string mood = GetMood(akTarget)
	String msg = "I am "+mood
	
	string tstat = akMind.GetTrainingStatusName()
	if tstat != ""
		msg += " and "+tstat+"."
	else
		msg += "."
	endif

	if akTarget.IsInFaction(DOMTobeComfortedFaction)
		msg += " I could use some comforting."
	endif

	if akMind.IsAroused()
		msg += " I am aroused."
	else
		float xa = akMind.arousal_factor ; 0 to 100 up to 200 for spontaneous orgasm
		if xa > 0
			if xa > 90.0
				msg += " I am very horny."
			elseif xa > 80.0
				msg += " I am very excited."
			elseif xa > 50.0
				msg += " I am slightly turned on."
			elseif xa > 30.0
				msg += " I am a bit excited."
			else
				msg += " I am barely aroused."
			endif
		endif
	endif

	float stat
	if mood != "in shock" && mood != "shocked"
		stat = (akMind.ChanceShock()*100.0)
		;LogTrace(akActor.getName()+" chance shock          ="+stat/100.0)
		if(stat<1.0) 
		msg = msg+" I am emotionally stable"
		elseif(stat<5.0) 
			msg = msg+" I am a bit nervous"
		elseif(stat<10.0) 
			msg = msg+" I am nervous"
		else
			msg = msg+" I am hysterical"
		endif
		msg = msg+"." ; ("+stat+")."
	endif
	
	if mood != "broken" && mood != "loyal" && mood != "in love"
		stat = (akMind.ChanceBroken()*100.0)
		;LogTrace(akActor.getName()+" chance broken         ="+stat/100.0)
		if(stat<5.0) 
			msg = msg+" I am resolute"
		elseif(stat<10.0) 
			msg = msg+" I want this to end"
		else
			msg = msg+" I am falling apart"
		endif
		msg = msg+"." ;  ("+stat+")."
	endif
	
	float chance_inlove = akMind.ChanceInlove()*100.0
	float chance_loyal  = akMind.ChanceLoyal()*100.0
	;LogTrace(akActor.getName()+" chance loyal          ="+chance_loyal/100.0)
	if mood != "loyal" && mood != "in love" && chance_loyal > chance_inlove
		stat = chance_loyal
		if(stat<5.0) 
			msg = msg+" "+mstr+" will always be my enemy"
		elseif(stat<10.0) 
			msg = msg+" I am not sure about anything anymore"
		else
			msg = msg+" I am on "+mstr+" side"
		endif
		msg = msg+"." ; ("+stat+")."
	endif
	
	;LogTrace(akActor.getName()+" chance inlove         ="+chance_inlove/100.0)
	if mood != "in love" && mood != "loyal" && chance_inlove > 0.0
		stat = chance_inlove
		if(stat<5.0) 
			msg = msg+" "+mstr+" disgusts me"
		elseif(stat<10.0) 
			msg = msg+" I am confused"
		else
			msg = msg+" I am falling in love"
		endif
		msg = msg+"." ; ("+stat+")."
	endif
	if mood == "loyal" && chance_inlove > 5.0
		stat = chance_inlove
		if(stat<10.0) 
			msg = msg+" I am confused"
		else
			msg = msg+" I am falling in love"
		endif
		msg = msg+"." ; ("+stat+")."
	endif

	if mood == "in love"
		float chance_jealous = akMind.ChanceJealous()*100.0
		if chance_inlove == 0.0
			chance_inlove = 1.0
		endif
		stat = chance_jealous/chance_inlove
		if(stat<0.5) 
			msg = msg+" I trust "+mstr+" above all else"
		elseif(stat<1.0) 
			msg = msg+" "+mstr+" has all my trust"
		elseif(stat<2.0) 
			msg = msg+" I am a bit jealous"
		else
			msg = msg+" I am deeply jealous"
		endif
		msg = msg+"." ; ("+stat+")."
		float chance_depressed = akMind.ChanceDepressed()*100.0
		stat = chance_depressed/chance_inlove
		if(stat<0.5) 
			msg = msg+" "+mstr+" makes me happy"
		elseif(stat<1.0) 
			msg = msg+" I am happy being with "+mstr
		elseif(stat<2.0) 
			msg = msg+" I need more attention"
		else
			msg = msg+" I have no will to live"
		endif
		msg = msg+"." ; ("+stat+")."
	endif
	msg = msg+"\n"

		
	string reason = akMind.promiseOath
	;LogTrace(akActor.getName()+" oath reason           ="+reason)
	if reason != "nothing"
		msg = msg+" "+mstr+" promised me "+reason+" "+GetElapsedTimeString(akMind.promiseTimer)
		if akMind.PromiseWasKept()
			msg += ", and "+mstr+" kept "+DOMPlayerAlias.GetPlayerPossessive()+" promise."
		else
			msg += "."
		endif
	endif
	if akMind.is_slave
		reason = akMind.GetWarnPunishmentReasonString()
		;LogTrace(akActor.getName()+" warn reason           ="+reason)
		if reason != "None" && reason != "no reason"
			msg = msg+" "+mstr+" warned me against "+reason+"."
		endif
		reason = akMind.GetLastPunishmentReasonString()
		;LogTrace(akActor.getName()+" last reason           ="+reason)
		if reason != "no reason"
			msg = msg+" "+mstr+" already punished me for "+reason+"."
		endif
		reason = akMind.GetNextPunishmentReasons()
		;LogTrace(akActor.getName()+" next reason           ="+reason)
		if reason != "no reason"
			msg = msg+" "+mstr+" can punish me for "+reason+"."
		endif
	endif
	reason = akMind.GetNextPraiseReasons()
	;LogTrace(akActor.getName()+" praise reason         ="+reason)
	if reason != "no reason"
		msg = msg+" "+mstr+" can praise me for "+reason+"."
	endif

	int psex = PlayerRef.GetActorBase().GetSex()
	int ssex = akTarget.GetLeveledActorBase().GetSex()
	;LogTrace(akActor.getName()+" virgin same           ="+akMind.virgin_status_same)
	if psex == ssex && sameSexToggle
		if akMind.virgin_status_same == 0
			if ssex == 0
				msg = msg+" I never had gay sex."
			else
				msg = msg+" I never had lesbian sex."
			endif
		endif
		if akMind.virgin_status_same == 2
			if ssex == 0
				msg = msg+" "+mstr+" was my first time with a dude."
			else
				msg = msg+" "+mstr+" was my first time with a girl."
			endif
		endif
	endif

	;LogTrace(akActor.getName()+" virgin vaginal        ="+akMind.virgin_status_vaginal)
	;LogTrace(akActor.getName()+" virgin anal           ="+akMind.virgin_status_anal)
	;LogTrace(akActor.getName()+" virgin oral           ="+akMind.virgin_status_oral)
	;LogTrace(akActor.getName()+" virgin gangbang       ="+akMind.virgin_status_gang)
	if psex != ssex && oppositeSexToggle
		if akMind.virgin_status_vaginal == 0
			if akMind.virgin_status_anal == 0 && akMind.virgin_status_oral == 0		
				msg = msg+" I am a true virgin."
			else
				msg = msg+" I am a virgin."
			endif
		elseif akMind.virgin_status_anal == 0 && akMind.virgin_status_oral == 0
			msg = msg+" I never had oral nor anal sex."
		elseif akMind.virgin_status_anal == 0
			msg = msg+" I never had anal sex."
		elseif akMind.virgin_status_oral == 0
			msg = msg+" I never had oral sex."
		endif

		if akMind.virgin_status_vaginal == 2
			if akMind.virgin_status_anal == 2 && akMind.virgin_status_oral == 2		
				msg = msg+" "+mstr+" took my virginity, all of it."
			elseif akMind.virgin_status_anal == 2
				msg = msg+" "+mstr+" took my virginity, and initiated me to anal sex."
			elseif akMind.virgin_status_oral == 2
				msg = msg+" "+mstr+" took my virginity, and initiated me to oral sex."
			else
				msg = msg+" "+mstr+" took my virginity."
			endif
		elseif akMind.virgin_status_anal == 2 && akMind.virgin_status_oral == 2
				msg = msg+" "+mstr+" initiated me to oral and anal sex."
		elseif akMind.virgin_status_anal == 2
				msg = msg+" "+mstr+" initiated me to anal sex."
		elseif akMind.virgin_status_oral == 2
				msg = msg+" "+mstr+" initiated me to oral sex."
		endif	

		if akMind.virgin_status_vaginal == 3
			if akMind.virgin_status_anal == 3 && akMind.virgin_status_oral == 3		
				msg = msg+" someone took my virginity, all of it."
			elseif akMind.virgin_status_anal == 3
				msg = msg+" someone took my virginity, and initiated me to anal sex."
			elseif akMind.virgin_status_oral == 3
				msg = msg+" someone took my virginity, and initiated me to oral sex."
			else
				msg = msg+" someone took my virginity."
			endif
		elseif akMind.virgin_status_anal == 3 && akMind.virgin_status_oral == 3
				msg = msg+" someone initiated me to oral and anal sex."
		elseif akMind.virgin_status_anal == 3
				msg = msg+" someone initiated me to anal sex."
		elseif akMind.virgin_status_oral == 3
				msg = msg+" someone initiated me to oral sex."
		endif	
		
		if akMind.virgin_status_gang == 2
			if akMind.is_slave
				msg = msg+" "+mstr+" forced me into a gangbang."
			else
				msg = msg+" "+mstr+" allowed me to experience a gangbang."
			endif
		elseif akMind.virgin_status_gang == 3
			if akMind.is_slave
				msg = msg+" someone forced me into a gangbang."
			else
				msg = msg+" I have experienced a gangbang."
			endif
		elseif akMind.virgin_status_gang == 0
			if akMind.virgin_status_vaginal !=0 || akMind.virgin_status_anal !=0 || akMind.virgin_status_oral !=0
				msg = msg+" I've never been in a sex party."
			endif
		endif
	endif

	return msg
EndFunction

string Function NPCMoodMessage(Actor akTarget)
	if isAnActorOrASlave(akTarget)
		return DOMMoodMessage(akTarget)
	endif
	return ActorMoodMessage(akTarget)
EndFunction

string Function ActorMoodMessage(Actor akTarget)
	string mood = GetMood(akTarget)
	string msg 
	if IsAPlayerSlave(akTarget)
		msg = "My name is "+akTarget.GetDisplayName()+" and I am your slave. I am "+mood+"."
	elseif isASlave(akTarget)
		msg = "My name is "+akTarget.GetDisplayName()+" and I am a slave. I am "+mood+"."
	else
		msg = "My name is "+akTarget.GetDisplayName()+" and I am a free person. I am "+mood+"."
	endif
	int level = akTarget.GetLevel()	
	if level > 1
		msg = msg+"\n I am level "+level
	endif
	;LogTrace("ActorMoodMessage msg="+msg)
	return msg
EndFunction

string Function DOMStatsMessage(Actor akTarget)
	if akTarget.IsChild()
		return ActorMoodMessage(akTarget)
	endif
	DOM_Actor akActor = GetActor(akTarget)
	if akActor == None
		return ActorStatsMessage(akTarget)
	endif
	
	DOM_Mind akMind = akActor.mind
	string mstr
	if akActor != None
		mstr = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.IsRespectfulWritings())
	else
		mstr = DOMPlayerAlias.GetPlayerTitle()
	endif
	string mood = GetMood(akTarget)
	String msg = "I am "+mood+"."

	int stat	
	string msg_tmp = ""
	string sh = " I was "
	;LogTrace(akActor.getName()+" number of shock       ="+akMind.number_of_shock)
	if akMind.number_of_shock > 0
		msg_tmp = msg_tmp+DOMTimesMessage(" I was in shock ",akMind.number_of_shock)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of pain        ="+akMind.number_of_pain)
	if akMind.number_of_pain > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("punished ",akMind.number_of_pain)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of toldoff     ="+akMind.number_of_toldoff)
	if akMind.number_of_toldoff > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("scolded ",akMind.number_of_toldoff)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of shame       ="+akMind.number_of_shame)
	if akMind.number_of_shame > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("humiliated ",akMind.number_of_shame)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of insult      ="+akMind.number_of_insult)
	if akMind.number_of_insult > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("insulted ",akMind.number_of_insult)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of flatter     ="+akMind.number_of_flatter)
	if akMind.number_of_flatter > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("flattered ",akMind.number_of_flatter)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of threat      ="+akMind.number_of_threat)
	if akMind.number_of_threat > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("threatened ",akMind.number_of_threat)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of promise     ="+akMind.number_of_promise)
	if akMind.number_of_promise > 1
		msg_tmp = msg_tmp+sh+DOMTimesMessage("given false promises ",(akMind.number_of_promise-(1)))
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	endif
	;LogTrace(akActor.getName()+" number of rape        ="+akMind.number_of_rape)
	if akMind.number_of_rape > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("raped ",akMind.number_of_rape)+"."
		sh = ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	if akMind.number_of_drug > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("drugged ",akMind.number_of_drug)+"."
		sh = ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	
	sh = " I "
	;LogTrace(akActor.getName()+" number of praise      ="+akMind.number_of_praise)
	if akMind.number_of_praise > 0
		msg_tmp = msg_tmp+DOMTimesMessage(" I was praised ",akMind.number_of_praise)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of comfort     ="+akMind.number_of_comfort)
	if akMind.number_of_comfort > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("was comforted ",akMind.number_of_comfort)
		sh = ", "
	endif
	;LogTrace(akActor.getName()+" number of sex         ="+akMind.number_of_sex)
	if akMind.number_of_sex > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("had sex ",akMind.number_of_sex)
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	else
		sh = " "
	endif
	;LogTrace(akActor.getName()+" number of sex for money ="+akMind.number_of_sexformoney)
	if akMind.number_of_sexformoney > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("had sex for money ",akMind.number_of_sexformoney)
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	else
		sh = " "
	endif
	;LogTrace(akActor.getName()+" number of orgasm      ="+akMind.number_of_orgasm)
	if akMind.number_of_orgasm > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("I had an orgasm ",akMind.number_of_orgasm)+"."
		sh = ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	if msg_tmp != ""
		msg = msg+msg_tmp+"\n"
	endif
	
	if !akMind.is_slave
		sh = " I saw you "
		msg_tmp = ""
		;LogTrace(akActor.getName()+" number of captured slaves      ="+akMind.number_of_capturedslaves)
		if akMind.number_of_capturedslaves == 1
			msg_tmp = msg_tmp+sh+"capture one slave."
			sh = ", "
		elseif akMind.number_of_capturedslaves > 0
			msg_tmp = msg_tmp+sh+"capture "+akMind.number_of_capturedslaves+" slaves."
			sh = ", "
		endif
		if akMind.number_of_brokenslaves == 1
			msg_tmp = msg_tmp+sh+" manage to break one slave."
			sh = ", "
		elseif akMind.number_of_brokenslaves > 0
			msg_tmp = msg_tmp+sh+" manage to break "+akMind.number_of_brokenslaves+" slaves."
			sh = ", "
		endif
		if sh  == ", "
			sh = " and "
		endif
		if akMind.number_of_soldslaves == 1
			msg_tmp = msg_tmp+sh+" sell one slave."
		elseif akMind.number_of_soldslaves > 0
			msg_tmp = msg_tmp+sh+" sell "+akMind.number_of_soldslaves+" slaves."
		endif
		if msg_tmp != ""
			msg = msg+msg_tmp+".\n"
		endif
	endif
	
	;LogTrace(akActor.getName()+" number of player chat ="+akMind.number_of_player_chat)
	;LogTrace(akActor.getName()+" number of player fling="+akMind.number_of_player_fling)
	if akMind.number_of_player_fling > 0 && akMind.number_of_player_chat > 0
		msg = msg+DOMTimesMessage(" I saw "+mstr+" flirting with other slaves ",akMind.number_of_player_chat)+DOMTimesMessage(" and being intimate ",akMind.number_of_player_fling)+"."
	elseif akMind.number_of_player_fling > 0
		msg = msg+DOMTimesMessage(" I saw "+mstr+" being intimate with other slaves ",akMind.number_of_player_fling)+"."
	elseif akMind.number_of_player_chat > 0
		msg = msg+DOMTimesMessage(" I saw "+mstr+" flirting with other slaves ",akMind.number_of_player_chat)+"."
	endif

	int nchat1 = akTarget.GetFactionRank(DOMNbChatFeelings)
	int nchat2 = akTarget.GetFactionRank(DOMNbChatPersonality)
	int nchat
	if nchat1 > 0
		nchat = nchat1
		if nchat2 > 0
			nchat += nchat2
		endif
	elseif nchat2 > 0
		nchat = nchat2
	else 
		nchat = 0
	endif
	if nchat > 0
		msg_tmp = msg_tmp+DOMTimesMessage(" "+mstr+" showed interest in me ",nchat)+"."
	else
		msg_tmp = msg_tmp+" "+mstr+" never showed any interest in me as a person."
	endif

	;LogTrace("DOMStatsMessage msg="+msg)
	return msg
EndFunction

string Function ActorStatsMessage(Actor akTarget)	
	string mood = GetMood(akTarget)
	String msg = "I am "+mood+"."

	string msg_tmp = ""
	string sh = " I was "
	if akTarget.GetFactionRank(DOMNbShock) > 0
		msg_tmp = msg_tmp+DOMTimesMessage(" I was in shock ",akTarget.GetFactionRank(DOMNbShock))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbPain) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("punished ",akTarget.GetFactionRank(DOMNbPain))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbBondage) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("put in bondage ",akTarget.GetFactionRank(DOMNbBondage))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbToldoff) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("scolded ",akTarget.GetFactionRank(DOMNbToldoff))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbShame) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("humiliated ",akTarget.GetFactionRank(DOMNbShame))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbInsult) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("insulted ",akTarget.GetFactionRank(DOMNbInsult))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbFlatter) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("flattered ",akTarget.GetFactionRank(DOMNbFlatter))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbThreat) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("threatened ",akTarget.GetFactionRank(DOMNbThreat))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbPromise) > 1
		msg_tmp = msg_tmp+sh+DOMTimesMessage("given false promises ",(akTarget.GetFactionRank(DOMNbPromise)-(1)))
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	endif
	if akTarget.GetFactionRank(DOMNbRape) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("raped ",akTarget.GetFactionRank(DOMNbRape))+"."
		sh == ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	if akTarget.GetFactionRank(DOMNbDrug) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("drugged ",akTarget.GetFactionRank(DOMNbDrug))+"."
		sh == ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	
	sh = " I "
	if akTarget.GetFactionRank(DOMNbPraise) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("was praised ",akTarget.GetFactionRank(DOMNbPraise))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbComfort) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("was comforted ",akTarget.GetFactionRank(DOMNbComfort))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbSex)> 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("had sex ",akTarget.GetFactionRank(DOMNbSex))
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	else
		sh = " "
	endif
	if akTarget.GetFactionRank(DOMNbSexForMoney)> 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("had sex for money ",akTarget.GetFactionRank(DOMNbSexForMoney))
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	else
		sh = " "
	endif
	if akTarget.GetFactionRank(DOMNbOrgasm) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("I had an orgasm ",akTarget.GetFactionRank(DOMNbOrgasm))+"."
		sh = ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	if msg_tmp != ""
		msg = msg+msg_tmp+"\n"
	endif
	
	if akTarget.GetFactionRank(DOMNbPlayerFling) > 0 && akTarget.GetFactionRank(DOMNbPlayerChat) > 0
		msg = msg+DOMTimesMessage(" I saw you flirting with other slaves ",akTarget.GetFactionRank(DOMNbPlayerChat))+DOMTimesMessage(" and being intimate ",akTarget.GetFactionRank(DOMNbPlayerFling))+"."
	elseif akTarget.GetFactionRank(DOMNbPlayerFling) > 0
		msg = msg+DOMTimesMessage(" I saw you being intimate with other slaves ",akTarget.GetFactionRank(DOMNbPlayerFling))+"."
	elseif akTarget.GetFactionRank(DOMNbPlayerChat) > 0
		msg = msg+DOMTimesMessage(" I saw you flirting with other slaves ",akTarget.GetFactionRank(DOMNbPlayerChat))+"."
	endif
	int nchat1 = akTarget.GetFactionRank(DOMNbChatFeelings)
	int nchat2 = akTarget.GetFactionRank(DOMNbChatPersonality)
	int nchat
	if nchat1 > 0
		nchat = nchat1
		if nchat2 > 0
			nchat += nchat2
		endif
	elseif nchat2 > 0
		nchat = nchat2
	else 
		nchat = 0
	endif
	if nchat > 0
		msg_tmp = msg_tmp+DOMTimesMessage(" You showed interest in me ",nchat)+"."
	else
		msg_tmp = msg_tmp+" You never showed any interest in me as a person."
	endif
	msg = msg+"\n"

	;LogTrace("ActorStatsMessage msg="+msg)
	return msg
EndFunction

string Function NPCStatsMessage(Actor akTarget)
	if isAnActorOrASlave(akTarget)
		return DOMStatsMessage(akTarget)
	endif
	string mood = GetMood(akTarget)

	string msg 
	if isASlave(akTarget)
		msg = "My name is "+akTarget.GetDisplayName()+" and I am a slave. I am "+mood+".\n\n"
	else
		msg = "My name is "+akTarget.GetDisplayName()+" and I am a free person. I am "+mood+".\n\n"
	endif

	if akTarget.IsChild()
		return msg
	endif

	string msg_tmp = ""
	string sh = " I was "
	if akTarget.GetFactionRank(DOMNbShock) > 0
		msg_tmp = msg_tmp+DOMTimesMessage(" I was in shock ",akTarget.GetFactionRank(DOMNbShock))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbPain) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("punished ",akTarget.GetFactionRank(DOMNbPain))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbBondage) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("put in bondage ",akTarget.GetFactionRank(DOMNbBondage))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbToldoff) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("scolded ",akTarget.GetFactionRank(DOMNbToldoff))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbShame) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("humiliated ",akTarget.GetFactionRank(DOMNbShame))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbInsult) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("insulted ",akTarget.GetFactionRank(DOMNbInsult))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbFlatter) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("flattered ",akTarget.GetFactionRank(DOMNbFlatter))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbThreat) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("threatened ",akTarget.GetFactionRank(DOMNbThreat))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbPromise) > 1
		msg_tmp = msg_tmp+sh+DOMTimesMessage("given false promises ",(akTarget.GetFactionRank(DOMNbPromise)-(1)))
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	endif
	if akTarget.GetFactionRank(DOMNbRape) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("raped ",akTarget.GetFactionRank(DOMNbRape))+"."
		sh == ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	if akTarget.GetFactionRank(DOMNbDrug) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("drugged ",akTarget.GetFactionRank(DOMNbDrug))+"."
		sh == ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	
	sh = " I "
	if akTarget.GetFactionRank(DOMNbPraise) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("was praised ",akTarget.GetFactionRank(DOMNbPraise))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbComfort) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("was comforted ",akTarget.GetFactionRank(DOMNbComfort))
		sh = ", "
	endif
	if akTarget.GetFactionRank(DOMNbSex)> 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("had sex ",akTarget.GetFactionRank(DOMNbSex))
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	else
		sh = " "
	endif
	if akTarget.GetFactionRank(DOMNbSexForMoney)> 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("had sex for money ",akTarget.GetFactionRank(DOMNbSexForMoney))
		sh = ", "
	endif
	if sh == ", "
		sh = " and "
	else
		sh = " "
	endif
	if akTarget.GetFactionRank(DOMNbOrgasm) > 0
		msg_tmp = msg_tmp+sh+DOMTimesMessage("I had an orgasm ",akTarget.GetFactionRank(DOMNbOrgasm))+"."
		sh = ""
	endif
	if sh == " and "
		msg_tmp = msg_tmp+"."
	endif
	if msg_tmp != ""
		msg = msg+msg_tmp+"\n"
	endif
	
	int nchat1 = akTarget.GetFactionRank(DOMNbChatFeelings)
	int nchat2 = akTarget.GetFactionRank(DOMNbChatPersonality)
	int nchat
	if nchat1 > 0
		nchat = nchat1
		if nchat2 > 0
			nchat += nchat2
		endif
	elseif nchat2 > 0
		nchat = nchat2
	else 
		nchat = 0
	endif
	if nchat > 0
		msg_tmp = msg_tmp+DOMTimesMessage(" You showed interest in me ",nchat)+"."
	else
		msg_tmp = msg_tmp+" You never showed any interest in me as a person."
	endif

	return msg
EndFunction

string Function DOMFeelingsMessage(Actor akTarget)
	Race ActorRace  = akTarget.GetLeveledActorBase().GetRace()
	string raceString = MiscUtil.GetRaceEditorID(ActorRace)
	if StringUtil.Find(raceString, "Child")>=0
		return "I am ok."
	endif

    string msg = "My name is "+akTarget.GetDisplayName()+". "
	if DOMPAH.isPAH(akTarget)
		msg += DOMPAH.GetFeelingsMessage(akTarget)
	elseif akTarget.IsInFaction(DOMPlayerSlaveFaction)
		string mood = GetMood(akTarget)
		msg += "I am a slave, my mood is "+mood+"\n"

		msg = msg+DOMFeelingsHeaderLine2(akTarget,"Submission     = ",DOMTrainSubmission,  "Desire         = ",DOMLoveDesire)
		msg = msg+DOMFeelingsLine2(akTarget,"Fear           = ",DOMTrainFear,   "Worship        = ",DOMLoyalWorship)
		msg = msg+DOMFeelingsLine2(akTarget,"Humiliation    = ",DOMTrainHumiliation, "Fascination    = ",DOMLoveFascination)    
		msg = msg+DOMFeelingsLine2(akTarget,"Anger training = ",DOMTrainAnger,  "Absolution     = ",DOMLoyalAbsolution)          
		msg = msg+DOMFeelingsLine2(akTarget,"Resignation    = ",DOMTrainResignation, "Devotion       = ",DOMLoyalDevotion)
		msg = msg+DOMFeelingsLine2(akTarget,"Respect        = ",DOMTrainRespect,"Admiration     = ",DOMLoveAdmiration)    

		msg = msg+DOMFeelingsLine(akTarget,"Pose training    = ",DOMTrainPose)
		msg = msg+DOMFeelingsLine(akTarget,"Oral training    = ",DOMTrainOral)
		msg = msg+DOMFeelingsLine(akTarget,"Vaginal training = ",DOMTrainVaginal)
		msg = msg+DOMFeelingsLine(akTarget,"Anal training    = ",DOMTrainAnal)

		msg = msg+DOMFeelingsLine(akTarget,"Combat training  = ",DOMTrainCombat)
		msg = msg+DOMFeelingsLine(akTarget,"House keeping    = ",DOMTrainHouse)
		msg = msg+DOMFeelingsLine(akTarget,"Working          = ",DOMTrainWorking)
		msg = msg+DOMFeelingsLine(akTarget,"Trauma           = ",DOMTraumaInDays)
	
		msg = msg+DOMFeelingsLine(akTarget,"Enforcer skill   = ",DOMSkillEnforcer)
		msg = msg+DOMFeelingsLine(akTarget,"Persuader skill  = ",DOMSkillPersuader)
		msg = msg+DOMFeelingsLine(akTarget,"Depraver skill   = ",DOMSkillDepraver)
		msg = msg+DOMFeelingsLine(akTarget,"Predator skill   = ",DOMSkillPredator)
		msg = msg+DOMFeelingsLine(akTarget,"Slaver skill     = ",DOMSkillSlaver)
		msg = msg+DOMFeelingsLine(akTarget,"Deceiver skill   = ",DOMSkillDeceiver)
	elseif akTarget.IsInFaction(DOMPlayerSlaverFaction)
		string mood = GetMood(akTarget)
		msg += "I am a slaver, my mood is "+mood+"\n"
		
		msg = msg+DOMFeelingsHeaderLine(akTarget,"Enforcer skill   = ",DOMSkillEnforcer)
		msg = msg+DOMFeelingsLine(akTarget,"Persuader skill  = ",DOMSkillPersuader)
		msg = msg+DOMFeelingsLine(akTarget,"Depraver skill   = ",DOMSkillDepraver)
		msg = msg+DOMFeelingsLine(akTarget,"Predator skill   = ",DOMSkillPredator)
		msg = msg+DOMFeelingsLine(akTarget,"Slaver skill     = ",DOMSkillSlaver)
		msg = msg+DOMFeelingsLine(akTarget,"Deceiver skill   = ",DOMSkillDeceiver)

		msg = msg+DOMFeelingsLine2(akTarget,"Submission     = ",DOMTrainSubmission,  "Desire         = ",DOMLoveDesire)
		msg = msg+DOMFeelingsLine2(akTarget,"Fear           = ",DOMTrainFear,   "Worship        = ",DOMLoyalWorship)
		msg = msg+DOMFeelingsLine2(akTarget,"Humiliation    = ",DOMTrainHumiliation, "Fascination    = ",DOMLoveFascination)    
		msg = msg+DOMFeelingsLine2(akTarget,"Anger training = ",DOMTrainAnger,  "Absolution     = ",DOMLoyalAbsolution)          
		msg = msg+DOMFeelingsLine2(akTarget,"Resignation    = ",DOMTrainResignation, "Devotion       = ",DOMLoyalDevotion)
		msg = msg+DOMFeelingsLine2(akTarget,"Respect        = ",DOMTrainRespect,"Admiration     = ",DOMLoveAdmiration)    

		msg = msg+DOMFeelingsLine(akTarget,"Pose training    = ",DOMTrainPose)
		msg = msg+DOMFeelingsLine(akTarget,"Oral training    = ",DOMTrainOral)
		msg = msg+DOMFeelingsLine(akTarget,"Vaginal training = ",DOMTrainVaginal)
		msg = msg+DOMFeelingsLine(akTarget,"Anal training    = ",DOMTrainAnal)

		msg = msg+DOMFeelingsLine(akTarget,"Combat training  = ",DOMTrainCombat)
		msg = msg+DOMFeelingsLine(akTarget,"House keeping    = ",DOMTrainHouse)
		msg = msg+DOMFeelingsLine(akTarget,"Working          = ",DOMTrainWorking)
		msg = msg+DOMFeelingsLine(akTarget,"Trauma           = ",DOMTraumaInDays)
	endif
		
	msg = msg+DOMFeelingsLine(akTarget,"Dirtiness        = ",DOMDirtiness)
	DOM_Actor akActor = GetActor(akTarget)
	if akActor != None
		int rank = akActor.mind.GetDrunkLevel()
		if rank > 0
			msg = msg+"Drunk level      = "+rank+"\n" 
		endif
	endif

	return msg
EndFunction

string Function NPCFeelingsMessage(Actor akTarget)
	if isAnActorOrASlave(akTarget)
		return DOMFeelingsMessage(akTarget)
	endif
    string msg
	if akTarget.IsInFaction(DOMTrainSubmission) ; was a slave one day, not sure today
		msg = "My name is "+akTarget.GetDisplayName()+"\n"
	else
		msg = "My name is "+akTarget.GetDisplayName()+" and I am a free person\n"
	endif

	float[] FeelsArray = DOMGenerator.GetNPCFeelings(akTarget);
	if akTarget.IsInFaction(DOMLoveDesire)
		msg = msg+"Desire "+akTarget.GetFactionRank(DOMLoveDesire)+"\n" 
	elseif akTarget.IsInFaction(DOMTrainSubmission)
		msg = msg+"Submission "+akTarget.GetFactionRank(DOMTrainSubmission)+"\n" 
	else
		msg = msg+"Defiant "+(FeelsArray[0] as int)+" Docile\n" 
	endif
	if akTarget.IsInFaction(DOMLoyalWorship)
		msg = msg+"Worship "+akTarget.GetFactionRank(DOMLoyalWorship)+"\n" 
	elseif akTarget.IsInFaction(DOMTrainFear)
		msg = msg+"Fear training "+akTarget.GetFactionRank(DOMTrainFear)+"\n" 
	else
		msg = msg+"Nervous "+(FeelsArray[1] as int)+" Relaxed\n"   
	endif
	if akTarget.IsInFaction(DOMLoveFascination)
		msg = msg+"Fascination "+akTarget.GetFactionRank(DOMLoveFascination)+"\n" 
	elseif akTarget.IsInFaction(DOMTrainHumiliation)
		msg = msg+"Humiliation "+akTarget.GetFactionRank(DOMTrainHumiliation)+"\n" 
	else
		msg = msg+"Proud "+(FeelsArray[2] as int)+" Humble\n"
	endif
	if akTarget.IsInFaction(DOMLoyalAbsolution)
		msg = msg+"Absolution "+akTarget.GetFactionRank(DOMLoyalAbsolution)+"\n" 
	elseif akTarget.IsInFaction(DOMTrainAnger)
		msg = msg+"Anger training "+akTarget.GetFactionRank(DOMTrainAnger)+"\n" 
	else
		msg = msg+"Hater "+(FeelsArray[3] as int)+" Loving\n"           
	endif
	if akTarget.IsInFaction(DOMLoyalDevotion)
		msg = msg+"Devotion "+akTarget.GetFactionRank(DOMLoyalDevotion)+"\n" 
	elseif akTarget.IsInFaction(DOMTrainResignation)
		msg = msg+"Resignation "+akTarget.GetFactionRank(DOMTrainResignation)+"\n" 
	else
		msg = msg+"Sad "+(FeelsArray[4] as int)+" Happy\n"
	endif
	if akTarget.IsInFaction(DOMLoveAdmiration)
		msg = msg+"Admiration "+akTarget.GetFactionRank(DOMLoveAdmiration)+"\n" 
	elseif akTarget.IsInFaction(DOMTrainRespect)
		msg = msg+"Respect training "+akTarget.GetFactionRank(DOMTrainRespect)+"\n" 
	else
		msg = msg+"Rebel "+(FeelsArray[5] as int)+" Tamed\n"  
	endif
	int rank = akTarget.getRelationshipRank(PlayerRef)
	msg = msg+"Relation "+(rank as int)+" with player\n"  
	
	;LogTrace(msg)
	return msg
EndFunction

Function NPCStartFollowMe(Actor akTarget)
	LogTrace("NPCStartFollowMe "+akTarget.GetDisplayName()+" package="+DOMFollowPlayerAndWait)
	if akTarget.IsInFaction(DOMActionWaiting)
		akTarget.RemoveFromFaction(DOMActionWaiting)
	else
		ActorUtil.AddPackageOverride(akTarget, DOMFollowPlayerAndWait, 100, 1)
	endif
	akTarget.SetFactionRank(DOMActionFollowing,1)
	akTarget.EvaluatePackage()
EndFunction

Function NPCStartWaitHere(Actor akTarget)
	LogTrace("NPCStartWaitHere "+akTarget.GetDisplayName())
	if akTarget.IsInFaction(DOMActionFollowing)
		akTarget.RemoveFromFaction(DOMActionFollowing)
	else
		ActorUtil.AddPackageOverride(akTarget, DOMFollowPlayerAndWait, 100, 1)
	endif
	akTarget.SetFactionRank(DOMActionWaiting,1)
	akTarget.EvaluatePackage()
EndFunction

Function NPCStartWaitSandbox(Actor akTarget)
	LogTrace("NPCStartWaitHere "+akTarget.GetDisplayName())
	if akTarget.IsInFaction(DOMActionFollowing)
		akTarget.RemoveFromFaction(DOMActionFollowing)
	else
		ActorUtil.AddPackageOverride(akTarget, DOMFollowPlayerAndWait, 100, 1)
	endif
	akTarget.SetFactionRank(DOMActionWaiting,2)
	akTarget.EvaluatePackage()
EndFunction

Function NPCStopFollowAndWait(Actor akTarget)
	LogTrace("NPCStopFollowAndWait "+akTarget.GetDisplayName())
	akTarget.RemoveFromFaction(DOMActionFollowing)
	akTarget.RemoveFromFaction(DOMActionWaiting)
	ActorUtil.RemovePackageOverride(akTarget, DOMFollowPlayerAndWait)
	akTarget.EvaluatePackage()
EndFunction

Function NPCStartAbduction(Actor akTarget)
	LogTrace("NPCStartAbduction "+akTarget.GetDisplayName())
	NPCStopFollowAndWait(akTarget)
	TrainSkillDeceiver(PlayerRef,1.0)
	DOMKeys.DOMActorAbduction(akTarget)
EndFunction

string Function DOMTraitsMessage(Actor akTarget)
	float[] TraitsArray = DOMGenerator.GetNPCTraits(akTarget) ; Just needs the traits, no modifiers
	string msg = "My name is "+akTarget.GetDisplayName()+" and "+GetRaceMessageFirstPerson(akTarget)+"\n"
	
	msg = msg+GetTraitsMessage(akTarget, TraitsArray)
	if debugMode && akTarget.IsInFaction(DOMActorFaction)
		DOM_Actor akActor = GetActor(akTarget)
		if akActor != None
			DOM_Mind akMind = akActor.mind
			if akMind != None
				akMind.ResetModifiers()
				akMind.PrintPersonality()
			endif
		endif
	endif
	;LogTrace("\n"+msg)
	return msg
EndFunction

string Function NPCTraitsMessage(Actor akTarget)
	if isAnActorOrASlave(akTarget)
		return DOMTraitsMessage(akTarget)
	endif
	float[] TraitsArray = DOMGenerator.GetNPCTraits(akTarget) ; Just needs the traits, no modifiers
	string msg = "My name is "+akTarget.GetDisplayName()+" and "+GetRaceMessageFirstPerson(akTarget)+"\n"

	msg = msg+GetTraitsMessage(akTarget, TraitsArray)
	
	;LogTrace("\n"+msg)
	return msg
EndFunction

string Function GetKinkMessage(DOM_Actor akActor, bool show_hidden)
	string msg = ""
	DOM_Mind akMind = akActor.Mind
	int n = akMind.GetNumberOfHiddenKinks()
	if n <= 0
		return msg
	endif
	string mstr
	if akMind != None
		mstr = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.IsRespectfulWritings())
	else
		mstr = DOMPlayerAlias.GetPlayerTitle()
	endif
	int k = akMind.GetNumberOfKnownKinks()
	int j = n-k
	;Debug.Trace(akActor.GetName()+" total="+n+" known="+k+" n="+j)
	if j > 0 && j <= 2
		msg += " I might have a hidden kink or two."
	elseif j > 2
		msg += " I might have a few hidden kinks."
	endif
	if show_hidden
		if n == 1
			msg += " My hidden kink is "+akMind.GetListOfHiddenKinks()+"."
		elseif n > 1
			msg += " My hidden kinks are "+akMind.GetListOfHiddenKinks()+"."
		endif
	endif
	if k > 0
		if k == 1
			msg += " "+mstr+" knows my kink is "+akMind.GetListOfKnownKinks()+"."
		else
			msg += " "+mstr+" knows my kinks are "+akMind.GetListOfKnownKinks()+"."
		endif
	endif
	float xteased = akMind.GetMaxTeasedLevel()
	if xteased > 5.0
		int idx = akMind.GetMaxTeasedKink()
		if idx > 0 && idx < 127
			if xteased > 50.0
				msg += " "+mstr+" "+DOMPlayerAlias.GetPlayerBeVerb()+" driving me crazy with "+GetJSONKinkReasonNameByIndex(idx,akActor.actorSex)+"."
			elseif xteased > 40.0
				msg += " "+mstr+" "+DOMPlayerAlias.GetPlayerBeVerb()+" exciting me with "+GetJSONKinkReasonNameByIndex(idx,akActor.actorSex)+"."
			elseif xteased > 30.0
				msg += " "+mstr+" "+DOMPlayerAlias.GetPlayerBeVerb()+" turning me on with "+GetJSONKinkReasonNameByIndex(idx,akActor.actorSex)+"."
			elseif xteased > 20.0
				msg += " "+mstr+" "+DOMPlayerAlias.GetPlayerBeVerb()+" triggering me with "+GetJSONKinkReasonNameByIndex(idx,akActor.actorSex)+"."
			else
				msg += " "+mstr+" "+DOMPlayerAlias.GetPlayerBeVerb()+" teasing me with "+GetJSONKinkReasonNameByIndex(idx,akActor.actorSex)+"."
			endif
		endif
	endif
	return msg
EndFunction

string Function DOMFeelingsVerboseMessage(Actor akTarget)
	string mood = GetMood(akTarget)
	String msg = "My name is "+akTarget.GetDisplayName()+". "+"I am "+mood+"."

	Race ActorRace  = akTarget.GetLeveledActorBase().GetRace()
	string raceString = MiscUtil.GetRaceEditorID(ActorRace)
	DOM_Actor akActor = GetActor(akTarget)
	if StringUtil.Find(raceString, "Child")>=0
		if akActor != None
			msg = msg+GetFriendMessage(akActor)+GetOldFriendMessage(akActor)
		endif
		return msg
	endif
	if isASlave(akTarget)
		string mstr
		if IsAPlayerSlave(akTarget)
			if akActor != None
				mstr = DOMPlayerAlias.GetPlayerTitleIfRespectful(akActor.mind.IsRespectfulWritings())
			else
				mstr = DOMPlayerAlias.GetPlayerTitle()
			endif
		else
			Actor akOwner = None
			if akActor != None && akActor.mind
				akOwner = akActor.mind.actor_owner
			endif
			if akOwner != None
				if akOwner.GetLeveledActorBase().GetSex() == 0
					mstr = "My Master"
				else
					mstr = "My Mistress"
				endif
			else
				mstr = "My Owner"
			endif
		endif
		msg = msg+" "+GetFeelMessage(0,akTarget.GetFactionRank(DOMTrainSubmission)  +akTarget.GetFactionRank(DOMLoveDesire),      mstr)
		msg = msg+" "+GetFeelMessage(1,akTarget.GetFactionRank(DOMTrainFear)   +akTarget.GetFactionRank(DOMLoyalWorship),    mstr)
		msg = msg+" "+GetFeelMessage(2,akTarget.GetFactionRank(DOMTrainHumiliation) +akTarget.GetFactionRank(DOMLoveFascination), mstr)
		msg = msg+" "+GetFeelMessage(3,akTarget.GetFactionRank(DOMTrainAnger)  +akTarget.GetFactionRank(DOMLoyalAbsolution), mstr)
		msg = msg+" "+GetFeelMessage(4,akTarget.GetFactionRank(DOMTrainResignation) +akTarget.GetFactionRank(DOMLoyalDevotion),   mstr)
		msg = msg+" "+GetFeelMessage(5,akTarget.GetFactionRank(DOMTrainRespect)+akTarget.GetFactionRank(DOMLoveAdmiration),  mstr)
	
		if !akTarget.IsInFaction(DOMMoodInlove) && !akTarget.IsInFaction(DOMMoodLoyal)
			int rank = akTarget.GetFactionRank(DOMTraumaInDays)
			if rank == 1
				msg = msg+" It feels like have been feeling bad for a whole day."
			elseif rank > 1
				msg = msg+" It feels like have been feeling weird for "+rank+" days."
			endif
		endif
	endif
	
	if akActor != None	
		msg = msg+GetKinkMessage(akActor,showKinksToggle)
		msg = msg+GetRivalMessage(akActor)+GetFriendMessage(akActor)+GetOldFriendMessage(akActor)
		float dirty_level = akActor.dirty_level
		if dirty_level > 0.0
			if dirty_level > 90.0
				msg = msg+" I feel extremely dirty."
			elseif dirty_level > 66.0
				msg = msg+" I feel dirty."
			elseif dirty_level > 34.0
				msg = msg+" I feel a bit dirty."
			endif
		endif
		int drunk_level = akActor.mind.GetDrunkLevel()
		if drunk_level > 0
			if drunk_level == 7
				msg = msg+" I am so drunk, I should be dead."
			elseif drunk_level == 6
				msg = msg+" I am so drunk, I should be in a coma."
			elseif drunk_level == 5
				msg = msg+" I am so drunk, I am about to pass out."
			elseif drunk_level == 4
				msg = msg+" I am so drunk, I am smashed."
			elseif drunk_level == 3
				msg = msg+" I feel drunk..."
			elseif drunk_level == 2
				msg = msg+" I feel a bit tipsy."
			elseif drunk_level == 1
				msg = msg+" I feel sober, almost."
			endif
		endif
	endif
	return msg
EndFunction

string Function NPCFeelingsVerboseMessage(Actor akTarget)
	if isAnActorOrASlave(akTarget)
		return DOMFeelingsVerboseMessage(akTarget)
	endif
    string msg
	if akTarget.IsInFaction(DOMTrainSubmission) ; was a slave one day, not sure today
		msg = "My name is "+akTarget.GetDisplayName()+". "+"I am feeling "
	else
		msg = "My name is "+akTarget.GetDisplayName()+" and "+"I am a free person. I am feeling "
	endif

	float[] FeelsArray = DOMGenerator.GetNPCFeelings(akTarget);
	string pct = ""
	int nb = 0

	int i = 0
	While i < 6
		float stat = FeelsArray[i]
		string feel_msg = GetNPCFeelMessage(i,(FeelsArray[i] as int))
		if feel_msg != ""
			msg = msg+pct+feel_msg
			pct = ", "
			nb += 1
			if(nb==3)
				pct = " but also "
			endif
		endif	
		i += 1
	EndWhile

	; Ending
	if(nb==0)
		msg=msg+" fine."
	else
		msg = msg+"."
	endif
	
	int rank = akTarget.getRelationshipRank(PlayerRef)
	if rank < -(3)
		msg = msg+" Next time we meet, I will kill you."
	elseif rank == -(3)
		msg = msg+" You are despicable."
	elseif rank == -(2)
		msg = msg+" I am not a big fan of you."
	elseif rank == -(1)
		msg = msg+" Why are you always in my way?"
	elseif rank == 0
		msg = msg+" I am not sure I know you."
	elseif rank == 1
		msg = msg+" Here we meet again."
	elseif rank == 2
		msg = msg+" May I call you friend?"
	elseif rank == 3
		msg = msg+" You are a good friend of mine."
	elseif rank > 3
		if akTarget.IsChild()
			msg = msg+" I think I like you."
		else
			msg = msg+" I think I am in love with you."
		endif
	endif

	;LogTrace(msg)
	return msg
EndFunction

string Function DOMTraitsVerboseMessage(Actor akTarget)
	float[] TraitsArray = DOMGenerator.GetNPCTraitsUpdateModifiers(akTarget) ; Also needs modifier values
	string msg = "My name is "+akTarget.GetDisplayName()+" and "+GetRaceMessageFirstPerson(akTarget)+". "+TraitsVerboseMessage(TraitsArray)
	
	msg = msg+TraitsSlaveMessage(akTarget,TraitsArray)
	return msg
EndFunction

string Function NPCTraitsVerboseMessage(Actor akTarget)
	if isAnActorOrASlave(akTarget)
		return DOMTraitsVerboseMessage(akTarget)
	endif
	float[] TraitsArray	= DOMGenerator.GetNPCTraitsUpdateModifiers(akTarget) ; Also needs modifier values
	;LogTrace(akTarget.GetDisplayName()+" traits = "+TraitsArray)
	string msg = "My name is "+akTarget.GetDisplayName()+" and "+GetRaceMessageFirstPerson(akTarget)+". "+TraitsVerboseMessage(TraitsArray)
		
	if ! isASlave(akTarget) ; if not a slave
		; NPC will give very personal information only to their lover
		if akTarget.getRelationshipRank(PlayerRef) > 3
			msg = msg+TraitsSlaveMessage(akTarget,TraitsArray)
		endif
	else ; is a slave
		msg = msg+TraitsSlaveMessage(akTarget,TraitsArray)
	endif
	
	;LogTrace("\n"+msg)
	return msg
EndFunction

string Function TraitsVerboseMessage(float[] TraitsArray)	
    String msg = "I am"
	string pct = " "
	int nb = 0

	int i = 0
	While i < 12
		if  i != 8 && i != 9 ; avoid sensual and submissive
			string tmp_msg = GetTraitMessage(i, TraitsArray)
			;LogTrace("Trait "+i+" "+TraitsArray[i]+" "+tmp_msg)
			if tmp_msg != ""
				msg = msg+pct+tmp_msg
				pct = ", "
				nb += 1
				if nb == 4
					pct = " but also "
				endif
			endif
		endif
		i += 1
	EndWhile

	; Ending
	if(nb==0)
		msg="I am an average person."
	else
		msg = msg+"."
	endif

	return msg
EndFunction

float Function GetModifierValue(int i, Actor akTarget)
	; Main per training stat
	if i==0
		return GetModifierFromFaction(akTarget,DOMModHumility)
	elseif i==1
		return GetModifierFromFaction(akTarget,DOMModFearfulness)
	elseif i==2
		return GetModifierFromFaction(akTarget,DOMModNaivety)
	elseif i==3
		return GetModifierFromFaction(akTarget,DOMModForgiveness)
	elseif i==4
		return GetModifierFromFaction(akTarget,DOMModPrudent)
	elseif i==5
		return GetModifierFromFaction(akTarget,DOMModDiscipline)
	; Main per SKILL
	elseif i==6
		return GetModifierFromFaction(akTarget,DOMModInsensitivity) ; Enforcer 
	elseif i==7
		return GetModifierFromFaction(akTarget,DOMModIntimidate) ; Persuader 
	elseif i==8
		return GetModifierFromFaction(akTarget,DOMModSelfEsteem) ; Depraver 
	elseif i==9
		return GetModifierFromFaction(akTarget,DOMModResentment) ; Predator 
	elseif i==10
		return GetModifierFromFaction(akTarget,DOMModController) ; Slaver 
	elseif i==11
		return GetModifierFromFaction(akTarget,DOMModPretender) ; Deceiver
	; Main per talent
	elseif i==12
		return GetModifierFromFaction(akTarget,DOMModCombat)
	elseif i==13
		return GetModifierFromFaction(akTarget,DOMModVaginal)
	elseif i==14
		return GetModifierFromFaction(akTarget,DOMModOral)
	elseif i==15
		return GetModifierFromFaction(akTarget,DOMModAnal)
	elseif i==16
		return GetModifierFromFaction(akTarget,DOMModPerfectionism) ; Clean house
	elseif i==17
		return GetModifierFromFaction(akTarget,DOMModFlexibility) ; Posing
	; Main per job: hustling, mining, enchantment, alchemy, baking, smithing
	else ; if i==18
		return 0.5 ; Work
	endif
	return GetModifierFromFaction(akTarget,DOMModCriminality) ; Crime
EndFunction

float Function GetExtraModifierValue(int i, DOM_Actor akActor)
	float norm = 100.0
	DOM_Mind akMind = akActor.mind
	if i==0
		return akMind.MOD_Impatience*norm
	elseif i==1
		return akMind.MOD_Modesty*norm
	elseif i==2
		return akMind.MOD_Authority*norm
	elseif i==3
		return akMind.MOD_Resentment*norm
	elseif i==4
		return akMind.MOD_Empathy*norm
	elseif i==5
		return akMind.MOD_Consideration*norm
	elseif i==6
		return akMind.MOD_Sociability*norm
	elseif i==7
		return akMind.MOD_Daring*norm
	elseif i==8
		return akMind.MOD_Impressionable*norm
	elseif i==9
		return akMind.MOD_Sentimentality*norm
	elseif i==10
		return akMind.MOD_Ingenuity*norm
	elseif i==11
		return akMind.MOD_Manipulation*norm
	elseif i==12
		return akMind.MOD_Panic*norm
	elseif i==13
		return akMind.MOD_Rebellion*norm
	elseif i==14
		return akMind.MOD_Gentleness*norm
	elseif i==15
		return akMind.MOD_Orgasm*norm
	elseif i==16
		return akMind.MOD_Sincerity*norm
	elseif i==17
		return akMind.MOD_Anxiety*norm
	elseif i==18
		return akMind.MOD_Organized*norm
	endif
	return akMind.MOD_Laborious*norm
EndFunction

string Function TraitsSlaveMessage(Actor akTarget, float[] TraitsArray)	
	Race ActorRace  = akTarget.GetLeveledActorBase().GetRace()
	string raceString = MiscUtil.GetRaceEditorID(ActorRace)
	if StringUtil.Find(raceString, "Child")>=0 
		return ""
	endif

	string msg = ""
	
	string pct = " I am "
	int nb = 0
	int i = 9
	While i < 12
		if  i != 10
			string tmp_msg = GetTraitMessage(i, TraitsArray)
			if tmp_msg != ""
				msg = msg+pct+tmp_msg
				pct = " and I am "
				nb += 1
			endif
		endif
		i += 1
	EndWhile

	if nb > 0
		msg = msg+"."
	endif
	
	pct = " I am extremely sensitive to "
	nb = 0
	i = 0
	
	While i < 6
		string tmp_name = GetModifierName(i)
		float stat = GetModifierValue(i,akTarget)
		if stat>200
			msg = msg+pct+tmp_name
			pct = ", "
			nb += 1
			if nb == 4
				pct = " but also to "
			endif
		endif
		i += 1
	EndWhile

	DOM_Actor akActor = GetActor(akTarget)
	If akActor != None
		i = 0
		While i < 20
			string tmp_name = GetExtraModifierName(i)
			float stat = GetExtraModifierValue(i,akActor)
			if stat>200
				msg = msg+pct+tmp_name
				pct = ", "
				nb += 1
				if nb == 4
					pct = " but also to "
				endif
			endif
			i += 1
		EndWhile
	endif

	if nb > 0
		msg = msg+"."
	endif

	pct = " I am very sensitive to "
	nb = 0
	i = 0
	While i < 6
		string tmp_name = GetModifierName(i)
		float stat = GetModifierValue(i,akTarget)
		if stat>100 && stat<=200
			msg = msg+pct+tmp_name
			pct = ", "
			nb += 1
			if nb == 4
				pct = " but also to "
			endif
		endif
		i += 1
	EndWhile

	If akActor != None
		i = 0
		While i < 20
			string tmp_name = GetExtraModifierName(i)
			float stat = GetExtraModifierValue(i,akActor)
			if stat>100 && stat<=200
				msg = msg+pct+tmp_name
				pct = ", "
				nb += 1
				if nb == 4
					pct = " but also to "
				endif
			endif
			i += 1
		EndWhile
	endif

	if nb > 0
		msg = msg+"."
	endif
	
	pct = " I am sensitive to "
	nb = 0
	i = 0
	While i < 6
		string tmp_name = GetModifierName(i)
		float stat = GetModifierValue(i,akTarget)
		if stat>=66 && stat<=100
			msg = msg+pct+tmp_name
			pct = ", "
			nb += 1
			if nb == 4
				pct = " but also to "
			endif
		endif
		i += 1
	EndWhile

	If akActor != None
		i = 0
		While i < 20
			string tmp_name = GetExtraModifierName(i)
			float stat = GetExtraModifierValue(i,akActor)
			if stat>=66 && stat<=100
				msg = msg+pct+tmp_name
				pct = ", "
				nb += 1
				if nb == 4
					pct = " but also to "
				endif
			endif
			i += 1
		EndWhile
	endif

	if(nb<=0)
		pct = ""
	else
		pct = ", but"
	endif
	pct = pct+" I am unresponsive to "
	
	i = 0
	While i < 6
		string tmp_name = GetModifierName(i)
		float stat = GetModifierValue(i,akTarget)
		if stat<34 && stat>=16
			msg = msg+pct+tmp_name
			pct = ", "
			nb += 1
		endif
		i += 1
	EndWhile

	If akActor != None
		i = 0
		While i < 20
			string tmp_name = GetExtraModifierName(i)
			float stat = GetExtraModifierValue(i,akActor)
			if stat<34 && stat>=16
				msg = msg+pct+tmp_name
				pct = ", "
				nb += 1
			endif
			i += 1
		EndWhile
	endif


	if nb > 0
		msg = msg+"."
	endif

	pct = " I am resistant to "
	nb = 0
	i = 0
	While i < 6
		string tmp_name = GetModifierName(i)
		float stat = GetModifierValue(i,akTarget)
		if stat<16 && stat>=8
			msg = msg+pct+tmp_name
			pct = ", "
			nb += 1
			if nb == 4
				pct = " but also to "
			endif
		endif
		i += 1
	EndWhile

	If akActor != None
		i = 0
		While i < 20
			string tmp_name = GetExtraModifierName(i)
			float stat = GetExtraModifierValue(i,akActor)
			if stat<16 && stat>=8
				msg = msg+pct+tmp_name
				pct = ", "
				nb += 1
				if nb == 4
					pct = " but also to "
				endif
			endif
			i += 1
		EndWhile
	endif

	if nb > 0
		msg = msg+"."
	endif

	pct = " I am impervious to "
	nb = 0
	i = 0
	While i < 6
		string tmp_name = GetModifierName(i)
		float stat = GetModifierValue(i,akTarget)
		if stat<8
			msg = msg+pct+tmp_name
			pct = ", "
			nb += 1
			if nb == 4
				pct = " but also to "
			endif
		endif
		i += 1
	EndWhile

	If akActor != None
		i = 0
		While i < 20
			string tmp_name = GetExtraModifierName(i)
			float stat = GetExtraModifierValue(i,akActor)
			if stat<8
				msg = msg+pct+tmp_name
				pct = ", "
				nb += 1
				if nb == 4
					pct = " but also to "
				endif
			endif
			i += 1
		EndWhile
	endif
	
	if nb > 0
		msg=msg+"."
	endif
	nb = 0
	pct = ""
	if(msg!="")
		pct = " "
	endif

	stat = GetModifierValue(17,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(17)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I love to pose."
	elseif(stat>100) 
		msg = msg+pct+"I learn fast to pose."
	elseif(stat>=66) 
		msg = msg+pct+"I am not against posing."
	elseif(stat<8) 
		msg = msg+pct+"I hate to pose."
	elseif(stat<16) 
		msg = msg+pct+"I am against posing."
	elseif(stat<34) 
		msg = msg+pct+"I prefer not to pose."
	endif
	float stat = GetModifierValue(12,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(12)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I am learning extremely fast in combat."
	elseif(stat>100) 
		msg = msg+pct+"I am learning very fast in combat."
	elseif(stat>=66) 
		msg = msg+pct+"I am learning fast in combat."
	elseif(stat<8) 
		msg = msg+pct+"I am extremely hesitant in combat."
	elseif(stat<16) 
		msg = msg+pct+"I am hesitant in combat."
	elseif(stat<34) 
		msg = msg+pct+"I am kind of hesitant in combat."
	endif
	stat = GetModifierValue(16,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(16)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I am an excellent housekeeper."
	elseif(stat>100) 
		msg = msg+pct+"I am a good housekeeper."
	elseif(stat>=66) 
		msg = msg+pct+"I could be a housekeeper."
	elseif(stat<8) 
		msg = msg+pct+"I hate cleaning and stuff."
	elseif(stat<16) 
		msg = msg+pct+"I am messy with cleaning."
	elseif(stat<34) 
		msg = msg+pct+"I am always late with cleaning."
	endif
	stat = GetModifierValue(6,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(6)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I am excellent at training."
	elseif(stat>100) 
		msg = msg+pct+"I am very good at training."
	elseif(stat>=66) 
		msg = msg+pct+"I am a good trainer."
	elseif(stat<8) 
		msg = msg+pct+"I am extremely bad at training others."
	elseif(stat<16) 
		msg = msg+pct+"I am bad at training others."
	elseif(stat<34) 
		msg = msg+pct+"I am not good at training others."
	endif
	stat = GetModifierValue(7,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(7)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I am a born leader."
	elseif(stat>100) 
		msg = msg+pct+"I am a very good leader."
	elseif(stat>=66) 
		msg = msg+pct+"I am a good leader."
	elseif(stat<8) 
		msg = msg+pct+"I am a very bad leader."
	elseif(stat<16) 
		msg = msg+pct+"I am not a leader."
	elseif(stat<34) 
		msg = msg+pct+"I am not a very good leader."
	endif
	stat = GetModifierValue(8,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(8)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I am a born depraver."
	elseif(stat>100) 
		msg = msg+pct+"I am very good at revealing others sensuality."
	elseif(stat>=66) 
		msg = msg+pct+"I am a good sex teacher."
	elseif(stat<8) 
		msg = msg+pct+"I am extremely uncomfortable with sex."
	elseif(stat<16) 
		msg = msg+pct+"I am bad at sex."
	elseif(stat<34) 
		msg = msg+pct+"I am not very good with my body."
	endif
	stat = GetModifierValue(9,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(9)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I am a born stalker."
	elseif(stat>100) 
		msg = msg+pct+"I am very good at stalking."
	elseif(stat>=66) 
		msg = msg+pct+"I am good at stalking people."
	elseif(stat<8) 
		msg = msg+pct+"I am extremely uncomfortable looking at someone in the eyes."
	elseif(stat<16) 
		msg = msg+pct+"I wish I could be more confident."
	elseif(stat<34) 
		msg = msg+pct+"I am not very confident."
	endif
	stat = GetModifierValue(10,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(10)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I could be a slave trader."
	elseif(stat>100) 
		msg = msg+pct+"I am very good at managing slaves."
	elseif(stat>=66) 
		msg = msg+pct+"I wish I could invest in the slave trade."
	elseif(stat<8) 
		msg = msg+pct+"I believe all beings should be free."
	elseif(stat<16) 
		msg = msg+pct+"I hope the slave trade will stop."
	elseif(stat<34) 
		msg = msg+pct+"I don't think people should be enslaved."
	endif
	stat = GetModifierValue(11,akTarget)
	;Logtrace("TraitsSlaveMessage: "+GetModifierName(11)+" modifier="+stat)
	if(stat>200) 
		msg = msg+pct+"I have deceived more people than I can count."
	elseif(stat>100) 
		msg = msg+pct+"I am very good at making people love me."
	elseif(stat>=66) 
		msg = msg+pct+"I am good at pleasing people."
	elseif(stat<8) 
		msg = msg+pct+"I never lied once in my life."
	elseif(stat<16) 
		msg = msg+pct+"I can't stand lies."
	elseif(stat<34) 
		msg = msg+pct+"Just don't ask me to lie for you."
	endif

	pct = ""
	if(msg!="")
		pct = " "
	endif
	
	string pct2 = pct+"I am extremely sensitive to "

	stat = GetModifierValue(13,akTarget)
	if(stat>200) 
		msg = msg+pct2+GetModifierName(13)
		pct2 = ", "
		nb = 4
	endif
	stat = GetModifierValue(14,akTarget)
	if(stat>200) 
		msg = msg+pct2+GetModifierName(14)
		pct2 = ", "
		nb = 4
	endif
	stat = GetModifierValue(15,akTarget)
	if(stat>200) 
		msg = msg+pct2+GetModifierName(15)
		pct2 = ", "
		nb = 4
	endif
	if nb == 4
		msg = msg+" sex."
	endif

	pct = ""
	if(msg!="")
		pct = " "
	endif
	
	pct2 = pct+"I am very sensitive to "

	stat = GetModifierValue(13,akTarget)
	if(stat>100 && stat<=200) 
		msg = msg+pct2+GetModifierName(13)
		pct2 = ", "
		nb = 5
	endif
	stat = GetModifierValue(14,akTarget)
	if(stat>100 && stat<=200) 
		msg = msg+pct2+GetModifierName(14)
		pct2 = ", "
		nb = 5
	endif
	stat = GetModifierValue(15,akTarget)
	if(stat>100 && stat<=200) 
		msg = msg+pct2+GetModifierName(15)
		pct2 = ", "
		nb = 5
	endif
	if nb == 5
		msg = msg+" sex."
	endif

	pct = ""
	if(msg!="")
		pct = " "
	endif
	
	pct2 = pct+"I am responsive to "

	stat = GetModifierValue(13,akTarget)
	if(stat>=66 && stat<=100) 
		msg = msg+pct2+GetModifierName(13)
		pct2 = ", "
		nb = 6
	endif
	stat = GetModifierValue(14,akTarget)
	if(stat>=66 && stat<=100) 
		msg = msg+pct2+GetModifierName(14)
		pct2 = ", "
		nb = 6
	endif
	stat = GetModifierValue(15,akTarget)
	if(stat>=66 && stat<=100) 
		msg = msg+pct2+GetModifierName(15)
		pct2 = ", "
		nb = 6
	endif
	if nb == 6
		msg = msg+" sex."
	endif
	
	pct = ""
	if(msg!="")
		pct = " "
	endif
    pct2 = pct+"I am not very sensitive to "

	stat = GetModifierValue(13,akTarget) 
	if(stat<34 && stat>=16) 
		msg = msg+pct2+GetModifierName(13)
		pct2 = ", "
		nb = 7
	endif
	stat = GetModifierValue(14,akTarget)
	if(stat<34 && stat>=16) 
		msg = msg+pct2+GetModifierName(14)
		pct2 = ", "
		nb = 7
	endif
	stat = GetModifierValue(15,akTarget)
	if(stat<34 && stat>=16) 
		msg = msg+pct2+GetModifierName(15)
		pct2 = ", "
		nb = 7
	endif
	if nb == 7
		msg = msg+" sex."
	endif

	pct = ""
	if(msg!="")
		pct = " "
	endif
    pct2 = pct+"I am unresponsive to "

	stat = GetModifierValue(13,akTarget)
	if(stat<16 && stat>=8) 
		msg = msg+pct2+GetModifierName(13)
		pct2 = ", "
		nb = 8
	endif
	stat = GetModifierValue(14,akTarget)
	if(stat<16 && stat>=8) 
		msg = msg+pct2+GetModifierName(14)
		pct2 = ", "
		nb = 8
	endif
	stat = GetModifierValue(15,akTarget)
	if(stat<16 && stat>=8) 
		msg = msg+pct2+GetModifierName(15)
		pct2 = ", "
		nb = 8
	endif
	if nb == 8
		msg = msg+" sex."
	endif
	
	pct = ""
	if(msg!="")
		pct = " "
	endif
    pct2 = pct+"I am oblivious to "

	stat = GetModifierValue(13,akTarget)
	if(stat<8) 
		msg = msg+pct2+GetModifierName(13)
		pct2 = ", "
		nb = 9
	endif
	stat = GetModifierValue(14,akTarget)
	if(stat<8) 
		msg = msg+pct2+GetModifierName(14)
		pct2 = ", "
		nb = 9
	endif
	stat = GetModifierValue(15,akTarget)
	if(stat<8) 
		msg = msg+pct2+GetModifierName(15)
		pct2 = ", "
		nb = 9
	endif
	if nb == 9
		msg = msg+" sex."
	endif

	return msg
EndFunction

Function SendNotificationFriends(string section, string msg, bool start_at_end=false)
	if wMessageLevel0
		if wMessageToggle
			DisplayMessage(section,msg,start_at_end)
		else
			LogTrace("WIDGET="+section+": "+msg)
			HudNotification(msg)
		endif
	else
		LogTrace("TXTMSG0="+msg)
	endif
EndFunction

Function SendNotificationAction(string section, string msg, bool start_at_end=false)
	if wMessageLevel1
		if wMessageToggle
			DisplayMessage(section,msg,start_at_end)
		else
			LogTrace("WIDGET="+section+": "+msg)
			HudNotification(msg)
		endif
	else
		LogTrace("TXTMSG1="+msg)
	endif
EndFunction

Function SendNotificationEmotion(string section, string msg, bool start_at_end=false)
	if wMessageLevel2
		if wMessageToggle
			DisplayMessage(section,msg,start_at_end)
		else
			LogTrace("WIDGET="+section+": "+msg)
			HudNotification(msg)
		endif
	else
		LogTrace("TXTMSG2="+msg)
	endif
EndFunction

Function SendNotificationAbuse(string section, string msg, bool start_at_end=false)
	if wMessageLevel3
		if wMessageToggle
			DisplayMessage(section,msg,start_at_end)
		else
			LogTrace("WIDGET="+section+": "+msg)
			HudNotification(msg)
		endif
	else
		LogTrace("TXTMSG3="+msg)
	endif
EndFunction

Function SendNotificationOrder(string section, string msg, bool start_at_end=false)
	if wMessageLevel4
		if wMessageToggle
			DisplayMessage(section,msg,start_at_end)
		else
			LogTrace("WIDGET="+section+": "+msg)
			HudNotification(msg)
		endif
	else
		LogTrace("TXTMSG4="+msg)
	endif
EndFunction

Function SendNotification(string section, string msg, bool start_at_end=false)
	if wMessageLevel5
		if wMessageToggle
			DisplayMessage(section,msg,start_at_end)
		else
			LogTrace("WIDGET="+section+": "+msg)
			HudNotification(msg)
		endif
	else
		LogTrace("TXTMSG5="+msg)
	endif
EndFunction

Function DisplayMessage(String section, String msg, bool start_at_end=false)
    DOM_MessageWidget widget = FindWidget(section,start_at_end)
	if widget == None
		LogTrace("WIDGET INDEX=None SECTION="+section+": "+msg)
		return
	endif
	;LogTrace("WIDGET INDEX="+widget.WidgetIndex+" SECTION="+section)
	LogTrace("WIDGET INDEX="+widget.WidgetIndex+" SECTION="+section+": "+msg)
	widget.DisplayMessage(msg)
	;UpdateWidgetPosition(widget.WidgetIndex)
EndFunction

int[] Property widgetColor Auto Hidden

bool has_apropos = false
Function InitMessageWidgets(string hAnchor = "", string vAnchor = "")
	If !has_apropos
		if (Game.GetModByName("Apropos2.esp") != 255) || (Game.GetModByName("Apropos.esp") != 255)
			has_apropos = true
			LogTrace("Apropos2 was found. DOM widgets will be displayed on the right")
			if number_of_widgets > 10
				number_of_widgets = 10
				LogTrace("Apropos2 was found. DOM widgets number will be reduced to "+number_of_widgets)
			endif
		endif
	elseif (Game.GetModByName("Apropos2.esp") == 255) && (Game.GetModByName("Apropos.esp") == 255)
		has_apropos = false
	endif
	; Move widgets to the right if Apropos2 is already loaded
	If has_apropos
		horizontalAnchor = "Right"
	elseif hAnchor == "Left" || hAnchor == "Center" || hAnchor == "Right"
		horizontalAnchor = hAnchor
	else
		horizontalAnchor = "Left"
	endif
	if vAnchor == "Top" || vAnchor == "Center" || vAnchor == "Bottom"
		verticalAnchor = vAnchor
	else
		verticalAnchor = "Top"
	endif
    LogTrace("InitMessageWidgets on side = "+horizontalAnchor+"/"+verticalAnchor)

	;if number_of_widgets < 1
	;	number_of_widgets = 1
	;else
	if number_of_widgets > MessageWidgets.length
		if MessageWidgets.length < 20 ; Ugly fix
			MessageWidgets = new DOM_MessageWidget[20]
			MessageWidgets[0] = Game.GetFormFromFile(0x00033230, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[1] = Game.GetFormFromFile(0x001CF282, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[2] = Game.GetFormFromFile(0x001CF283, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[3] = Game.GetFormFromFile(0x001CF284, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[4] = Game.GetFormFromFile(0x001CF285, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[5] = Game.GetFormFromFile(0x001CF286, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[6] = Game.GetFormFromFile(0x001CF287, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[7] = Game.GetFormFromFile(0x001CF288, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[8] = Game.GetFormFromFile(0x001CF289, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[9] = Game.GetFormFromFile(0x001CF28A, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[10] = Game.GetFormFromFile(0x00A9B1B2, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[11] = Game.GetFormFromFile(0x00A9B1B3, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[12] = Game.GetFormFromFile(0x00A9B1B4, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[13] = Game.GetFormFromFile(0x00A9B1B5, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[14] = Game.GetFormFromFile(0x00A9B1B6, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[15] = Game.GetFormFromFile(0x00A9B1B7, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[16] = Game.GetFormFromFile(0x00A9B1B8, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[17] = Game.GetFormFromFile(0x00A9B1B9, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[18] = Game.GetFormFromFile(0x00A9B1BA, "DiaryOfMine.esm") as DOM_MessageWidget
			MessageWidgets[19] = Game.GetFormFromFile(0x00A9B1BB, "DiaryOfMine.esm") as DOM_MessageWidget
		else
			number_of_widgets = MessageWidgets.length
			LogTrace("InitMessageWidgets size was too high. Reset to "+number_of_widgets)
		endif
	endif
	; Correct an old bug
	if MessageWidgets[6] == MessageWidgets[7]
		MessageWidgets[7] = Game.GetFormFromFile(0x001CF288, "DiaryOfMine.esm") as DOM_MessageWidget
	endif
    Int i = 0 
	While i < number_of_widgets
		DOM_MessageWidget widget = MessageWidgets[i]
		widget.IsEnabled = true
		widget.WidgetIndex = i
		widget.UpdateWidgetTextColor(widgetColor[i])
		widget.WidgetWidth = 400
		UpdateWidgetPosition(i)
		LogTrace("InitMessageWidgets enable index="+i+"/"+widget.WidgetIndex+" section="+widget.WidgetSection+" section2="+widget.WidgetSection2+" enabled="+widget.IsEnabled+" widget="+widget)
		i += 1
	EndWhile
	While i < MessageWidgets.Length
		DOM_MessageWidget widget = MessageWidgets[i]
		widget.ClearMessage()
		widget.IsEnabled = false
		widget.WidgetIndex = i
		widget.UpdateWidgetTextColor(widgetColor[i])
		widget.WidgetWidth = 400
		widget.WidgetSection = ""
		widget.WidgetSection2 = ""
		LogTrace("InitMessageWidgets disable index="+i+"/"+widget.WidgetIndex+" section="+widget.WidgetSection+" section2="+" enabled="+widget.IsEnabled+widget.WidgetSection2+" widget="+widget)
		i += 1
	EndWhile
	i = 0 
	While i < MessageWidgets.Length
		MessageWidgets[i].UpdateWidgetTextColor(widgetColor[i])
		MessageWidgets[i].WidgetWidth = 400
		i += 1
	EndWhile
	UpdateAllWidgetPositions()
EndFunction

Int lastwidget = -1
Int lastwidget2 = -1
String Property horizontalAnchor = "Right" Auto Hidden ; "Center" "Left"
String Property verticalAnchor = "Top" Auto Hidden ; "Center" "Bottom"

Function ClearWidgetSections()
	int i = 0
	int n = MessageWidgets.length
	while i < n
		DOM_MessageWidget widget = MessageWidgets[i]
		if widget != None
			LogTrace("Clearing widget "+i+"/"+widget.WidgetIndex+" section1="+widget.WidgetSection+" section2="+widget.WidgetSection2+" enabled="+widget.IsEnabled+" widget="+widget)
			widget.WidgetSection = ""
			widget.WidgetSection2 = ""
		endif
		i += 1
	endwhile
EndFunction

DOM_MessageWidget Function FindWidget(String section, bool start_at_end = false)
	;LogTrace("Looking for message widget: "+section+" number_of_widgets="+number_of_widgets)
	if number_of_widgets <= 0
		return None
	endif
    Int i = 0
	Int iempty = -1
	Int iempty2 = -1
	Int isecond = -1
    While i < number_of_widgets
        DOM_MessageWidget widget = MessageWidgets[i]
		;LogTrace("FindWidget INDEX="+i+"/"+widget.WidgetIndex+" enabled="+widget.IsEnabled+" widget="+MessageWidgets[i])
        If widget.WidgetSection == section
			; If secondary exist, clear it
			if isecond >= 0 && isecond < number_of_widgets
				MessageWidgets[isecond].WidgetSection2 = ""
			endif
			;LogTrace("WIDGET INDEX="+i+"/"+widget.WidgetIndex+" first section found for "+section+" widget="+widget)
			return widget
        endif
        If widget.WidgetSection2 == section
            isecond = i
        endif
		If widget.WidgetSection == ""
			if start_at_end
				iempty = i
			elseif iempty < 0
				iempty = i
			endif
		endif
		If widget.WidgetSection2 == ""
			if start_at_end
				iempty2 = i
			elseif iempty2 < 0
				iempty2 = i
			endif
		endif
        i += 1
    EndWhile
	; Get an empty widget
	if iempty >= 0 && iempty < number_of_widgets
		lastwidget = iempty
		DOM_MessageWidget widget = MessageWidgets[iempty]
		widget.WidgetSection = section
		;LogTrace("WIDGET INDEX="+iempty+"/"+widget.WidgetIndex+" new first section registered for "+section)
		; If secondary exist, clear it
		if isecond >= 0 && isecond < number_of_widgets
			MessageWidgets[isecond].WidgetSection2 = ""
		endif
		return widget
	endif
    ; If no empty widget get secondary
	if isecond >= 0 && isecond < number_of_widgets
		DOM_MessageWidget widget = MessageWidgets[isecond]
		;LogTrace("WIDGET INDEX="+isecond+"/"+widget.WidgetIndex+" secondary section found for "+section)
		return widget
	endif
	; Get an already used widget to share
	if iempty2 >= 0 && iempty2 < number_of_widgets
		lastwidget2 = iempty2
		DOM_MessageWidget widget = MessageWidgets[iempty2]
		widget.WidgetSection2 = section
		;LogTrace("WIDGET INDEX="+iempty2+"/"+widget.WidgetIndex+" new secondary section registered as shared for "+section)
		return widget
	endif
	; Get a reused widget
	;LogTrace("WIDGET INDEX empty="+iempty+"/"+iempty2+" last="+lastwidget+"/"+lastwidget2+" for "+section)
	; On first list
	int new_widget = -1
	bool is_secondary = false
	if lastwidget2 <= 0
		lastwidget += 1
		If lastwidget >= number_of_widgets
			lastwidget = -1
		else
			new_widget = lastwidget
		endif
	endif
	; On second list
	if new_widget < 0
		lastwidget2 += 1
		If lastwidget2 >= number_of_widgets
			lastwidget2 = -1
		else
			new_widget = lastwidget2
			is_secondary = true
		endif
	endif
	if new_widget < 0 || new_widget >= number_of_widgets
		new_widget = 0
	endif
	;LogTrace("WIDGET INDEX new="+new_widget+" last="+lastwidget+"/"+lastwidget2+" for "+section)
	DOM_MessageWidget widget = MessageWidgets[new_widget]
	if is_secondary
		;LogTrace("WIDGET INDEX="+new_widget+"/"+widget.WidgetIndex+" secondary section reused for "+section)
		widget.WidgetSection2 = section
	else
		;LogTrace("WIDGET INDEX="+new_widget+"/"+widget.WidgetIndex+" first section reused for "+section)
		widget.WidgetSection = section
	endif
    return widget
EndFunction

Function UpdateAllWidgetPositions()
	Int[] refPos 
    Int[] offset
    Int calc1
    Int calc2
	Int i = 0

    While i < number_of_widgets
		refPos = GetReferencePos(i)
        offset = GetOffsetPos(i)
    	DOM_MessageWidget widget = MessageWidgets[i]
    	calc1 = refPos[0] + offset[0]
    	calc2 = refPos[1] + offset[1]
    	widget.MoveTo(calc1, calc2)
    	i += 1
    EndWhile
EndFunction

Function UpdateWidgetPosition(Int widgetIndex)
	Int[] refPos = GetReferencePos(widgetIndex)
    Int[] offset = GetOffsetPos(widgetIndex)
    Int calc1 = refPos[0] + offset[0]
	Int calc2 = refPos[1] + offset[1]
    MessageWidgets[widgetIndex].MoveTo(calc1, calc2)
EndFunction

Int[] Function GetReferencePos(Int widgetIndex)
	Int horizontalOffset = 5
	Int verticalOffset   = 134

    Int[] refPos = New Int[2]
    
 	int middleWidget
	if number_of_widgets > 10
		middleWidget = (number_of_widgets+1) / 2
	else
		middleWidget = number_of_widgets + 1
	endif

 	if widgetIndex < middleWidget
		If (horizontalAnchor == "Left")
			refPos[0] = horizontalOffset
		elseIf (horizontalAnchor == "Center")
			refPos[0] = 640 + horizontalOffset
		elseIf (horizontalAnchor == "Right")
			refPos[0] = 1280 + horizontalOffset
		endif
 	else
		If (horizontalAnchor == "Right")
			refPos[0] = horizontalOffset
		elseIf (horizontalAnchor == "Center")
			refPos[0] = 640 + horizontalOffset
		elseIf (horizontalAnchor == "Left")
			refPos[0] = 1280 + horizontalOffset
		endif
	endif
    
    If (verticalAnchor == "Top")
        refPos[1] = verticalOffset
    elseIf (verticalAnchor == "Center")
        refPos[1] = 360 + verticalOffset
    elseIf (verticalAnchor == "Bottom")
        refPos[1] = 720 + verticalOffset
    endif
    
    return refPos
EndFunction

Int[] Function GetOffsetPos(Int widgetIndex)
	int widgetspacing    = 0 
	
    Int[] offsetPos = New Int[2]

    DOM_MessageWidget widget = MessageWidgets[widgetIndex]
	DOM_MessageWidget previousWidget
    Float previousHeights = 0


	int middleWidget
	if number_of_widgets > 10
		middleWidget = (number_of_widgets+1) / 2
	else
		middleWidget = number_of_widgets + 1
	endif

	if widgetIndex < middleWidget
		If horizontalAnchor == "Left"
			offsetPos[0] = 0
		elseIf horizontalAnchor == "Center"
			offsetPos[0] = (-widget.GetDimensions()[0] / 2.0) As Int
		elseIf horizontalAnchor == "Right"
			offsetPos[0] = -widget.GetDimensions()[0] As Int
		endif
		If widgetIndex == 0
			previousWidget = MessageWidgets[0]
		else
			previousWidget = MessageWidgets[widgetIndex - 1]
			Int i = 0
			While i < widgetIndex
				widget = MessageWidgets[i]
				previousHeights += widget.GetDimensions()[1]
				i += 1
			EndWhile
		endif
	else
		If horizontalAnchor == "Right"
			offsetPos[0] = 0
		elseIf horizontalAnchor == "Center"
			offsetPos[0] = (-widget.GetDimensions()[0] / 2.0) As Int
		elseIf horizontalAnchor == "Left"
			offsetPos[0] = -widget.GetDimensions()[0] As Int
		endif
		If widgetIndex <= middleWidget
			previousWidget = MessageWidgets[middleWidget]
		else
			previousWidget = MessageWidgets[widgetIndex - 1]
			Int i = middleWidget
			While i < widgetIndex
				widget = MessageWidgets[i]
				previousHeights += widget.GetDimensions()[1]
				i += 1
			EndWhile
		endif
	endif

   ; Assumes first widget has a unique size, and all others are sized vertically uniformly.
    If verticalAnchor == "Top"
        offsetPos[1] = (previousHeights + (widgetSpacing As Float)) As Int
    elseIf verticalAnchor == "Center"
        offsetPos[1] = (((widgetIndex - 5) As Float) * (previousHeights + (widgetSpacing As Float))) As Int
    elseIf verticalAnchor == "Bottom"
        offsetPos[1] = ((widgetIndex As Float) * -(previousHeights + (widgetSpacing As Float))) As Int
    endif

    return offsetPos
EndFunction

; ##### Relationships

bool Function HasSpouse(Actor akRef)
    if akRef.HasAssociation(pSpouse)
		return true
	endif
	return false
EndFunction

bool Function HasLover(Actor akRef)
    if akRef.HasAssociation(pCourting)
		return true
	endif
	return false
EndFunction

bool Function HasFamily(Actor akRef)
    if akRef.HasFamilyRelationship()
		return true
	endif
	return false
EndFunction

bool Function IsFamily(Actor akRef, Actor akOther)
    if akRef.HasFamilyRelationship(akOther) ; is kinsman/kinswoman
		return true
	endif
	return false
EndFunction

bool Function IsFriend(Actor akRef, Actor akOther)
    if akRef.GetRelationshipRank(akOther) >= 1 ; is friend
		return true
	endif
	return false
EndFunction

bool Function IsLover(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pCourting, akOther)
		if akRef.GetRelationshipRank(akOther) >= 4
			return true ; only if they are both in love!
		endif
	endif
	return false
EndFunction

bool Function IsCourting(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pCourting, akOther)
		if akRef.GetRelationshipRank(akOther) < 4
			if akRef.HasParentRelationship(akOther) ; the parent is the one in love, not the other
				return true ; only one in love!
			endif
		endif
	endif
	return false
EndFunction

bool Function IsCourted(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pCourting, akOther)
		if akRef.GetRelationshipRank(akOther) < 4
			if !akRef.HasParentRelationship(akOther)
				return true ; not in love!
			endif
		endif
	endif
	return false
EndFunction

bool Function IsSpouse(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pSpouse, akOther)
		return true
	endif
	return false
EndFunction

bool Function IsParent(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pParent, akOther)
		if akRef.HasParentRelationship(akOther) ; parent
			return true
		endif
	endif
	return false
EndFunction

bool Function IsChild(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pParent, akOther)
		if !akRef.HasParentRelationship(akOther) ; child
			return true
		endif
	endif
	return false
EndFunction

bool Function IsInLawParent(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pInLawParent, akOther)
		if akRef.HasParentRelationship(akOther) ; parent
			return true
		endif
	endif
	return false
EndFunction

bool Function IsInLawChild(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pInLawParent, akOther)
		if !akRef.HasParentRelationship(akOther) ; child
			return true
		endif
	endif
	return false
EndFunction

bool Function IsSibling(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pSibling, akOther)
		return true
	endif
	return false
EndFunction

bool Function IsInlawSibling(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pInLawBrotherSister, akOther)
		return true
	endif
	return false
EndFunction

bool Function IsCousin(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pCousin, akOther)
		return true
	endif
	return false
EndFunction

bool Function IsGrandParent(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pGrandParent, akOther)
		if akRef.HasParentRelationship(akOther) ; grand parent
			return true
		endif
	endif
	return false
EndFunction

bool Function IsGrandChild(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pGrandParent, akOther)
		if !akRef.HasParentRelationship(akOther) ; grand child
			return true
		endif
	endif
	return false
EndFunction

bool Function IsGreatGrandParent(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pGreatGrandParent, akOther)
		if akRef.HasParentRelationship(akOther) ; grand parent
			return true
		endif
	endif
	return false
EndFunction

bool Function IsGreatGrandChild(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pGreatGrandParent, akOther)
		if !akRef.HasParentRelationship(akOther) ; grand child
			return true
		endif
	endif
	return false
EndFunction

bool Function IsAuntUncle(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pUncleAunt, akOther)
		if akRef.HasParentRelationship(akOther) ; aunt/uncle
			return true
		endif
	endif
	return false
EndFunction

bool Function IsNieceNephew(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pUncleAunt, akOther)
		if !akRef.HasParentRelationship(akOther) ; niece/nephew
			return true
		endif
	endif
	return false
EndFunction

bool Function IsGreatAuntUncle(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pGreatAuntUncle, akOther)
		if akRef.HasParentRelationship(akOther) ; aunt/uncle
			return true
		endif
	endif
	return false
EndFunction

bool Function IsGreatNieceNephew(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pGreatAuntUncle, akOther)
		if !akRef.HasParentRelationship(akOther) ; niece/nephew
			return true
		endif
	endif
	return false
EndFunction

bool Function IsInLawAuntUncle(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pInLawAuntUncle, akOther)
		if akRef.HasParentRelationship(akOther) ; aunt/uncle
			return true
		endif
	endif
	return false
EndFunction

bool Function IsInLawNieceNephew(Actor akRef, Actor akOther)
    if akRef.HasAssociation(pInLawAuntUncle, akOther)
		if !akRef.HasParentRelationship(akOther) ; niece/nephew
			return true
		endif
	endif
	return false
EndFunction

int Function GetFriendshipType(Actor akRef, Actor akOther)
	;LogTrace("Get friendship type :"+akRef+"  "+akOther)
	if IsLover(akRef,akOther)
		return 1
	endif
	if IsCourting(akRef,akOther)
		return 21 ; One sided relationships are > 20
	endif
	if IsCourted(akRef,akOther)
		return 22 ; One sided relationships are > 20
	endif
	if !akRef.HasFamilyRelationship(akOther)
		;LogTrace("Not family :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 0
	elseif IsSpouse(akRef,akOther)
		LogTrace("Spouses :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 2
	elseif IsParent(akRef,akOther)
		LogTrace("Parent :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 3
	elseif IsChild(akRef,akOther)
		LogTrace("Child :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 4
	elseif IsSibling(akRef,akOther)
		LogTrace("Siblings :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 5
	elseif IsGrandParent(akRef,akOther)
		LogTrace("Grand parent :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 6
	elseif IsGrandChild(akRef,akOther)
		LogTrace("Grand child :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 7
	elseif IsCousin(akRef,akOther)
		LogTrace("Cousin :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 8
	elseif IsAuntUncle(akRef,akOther)
		LogTrace("Aunt/Uncle :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 9
	elseif IsNieceNephew(akRef,akOther)
		LogTrace("Niece/Nephew :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 10
	elseif IsGreatGrandParent(akRef,akOther)
		LogTrace("Great grand parent :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 11
	elseif IsGreatGrandChild(akRef,akOther)
		LogTrace("Great grand child :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 12
	elseif IsGreatAuntUncle(akRef,akOther)
		LogTrace("Great Aunt/Uncle :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 13
	elseif IsGreatNieceNephew(akRef,akOther)
		LogTrace("Great Niece/Nephew :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 14
	elseif IsInLawAuntUncle(akRef,akOther)
		LogTrace("In law Aunt/Uncle :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 16
	elseif IsInLawNieceNephew(akRef,akOther)
		LogTrace("In law Niece/Nephew :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 17
	elseif IsInLawParent(akRef,akOther)
		LogTrace("In law parent :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 18
	elseif IsInLawChild(akRef,akOther)
		LogTrace("In law child :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 19
	elseif IsInlawSibling(akRef,akOther)
		LogTrace("In law siblings :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 20
	elseif IsFamily(akRef,akOther)
		LogTrace("Other family :"+akRef.GetDisplayName()+"  "+akOther.GetDisplayName())
		return 15
	endif
	return 0
EndFunction

; ### Friends

int property nbNearbySlaves = 0 Auto Conditional
DOM_Actor[] __nearby_slaves
DOM_Actor[] Property nearby_slaves
	DOM_Actor[] Function Get()
		if !__nearby_slaves
			__nearby_slaves = new DOM_Actor[128]
		endif
		return __nearby_slaves
	EndFunction
EndProperty

int property nbNearbySlavesPwF = 0 Auto Conditional
DOM_Actor[] __nearby_slaves_pwf
DOM_Actor[] Property nearby_slaves_pwf
	DOM_Actor[] Function Get()
		if !__nearby_slaves_pwf
			__nearby_slaves_pwf = new DOM_Actor[128]
		endif
		return __nearby_slaves_pwf
	EndFunction
EndProperty

int property nbNearbyActors = 0 Auto Hidden
Actor[] __nearby_actors
Actor[] Property nearby_actors
	Actor[] Function Get()
		if !__nearby_actors
			__nearby_actors = new Actor[128]
		endif
		return __nearby_actors
	EndFunction
EndProperty

int property nbNearbyFollowers = 0 Auto Hidden
Actor[] __nearby_followers
Actor[] Property nearby_followers
	Actor[] Function Get()
		if !__nearby_followers
			__nearby_followers = new Actor[128]
		endif
		return __nearby_followers
	EndFunction
EndProperty

int property nbAllFollowers = 0 Auto Hidden
Actor[] __all_followers
Actor[] Property all_followers
	Actor[] Function Get()
		if !__all_followers
			__all_followers = new Actor[128]
		endif
		return __all_followers
	EndFunction
EndProperty

Function RemoveFromFollowersList(Actor akSomeone)
	if nbAllFollowers <= 0
		return
	endif
	int i = 0
	while i < nbAllFollowers
		if akSomeone == all_followers[i]
			LogTrace("RemoveFromFollowersList "+akSomeone.GetDisplayName()+" removed from backup followers list")
			all_followers[i] = None
			int j = i
			while j < nbAllFollowers - 1
				all_followers[j] = all_followers[j+1]
				j += 1
			endwhile
			nbAllFollowers -= 1
		endif
		i += 1
	endwhile
EndFunction

Function AddToFollowersList(Actor akSomeone)
	if nbAllFollowers >= all_followers.Length
		return
	endif
	int i = 0
	while i < nbAllFollowers
		if akSomeone == all_followers[i]
			return
		endif
		i += 1
	endwhile
	LogTrace("AddToFollowersList "+akSomeone.GetDisplayName()+" added to backup followers list")
	all_followers[nbAllFollowers] = akSomeone
	nbAllFollowers += 1
EndFunction

int property nbNearbyActorsFamily = 0 Auto Hidden
DOM_Actor[] __nearby_actors_family
DOM_Actor[] Property nearby_actors_family
	DOM_Actor[] Function Get()
		if !__nearby_actors_family
			__nearby_actors_family = new DOM_Actor[128]
		endif
		return __nearby_actors_family
	EndFunction
EndProperty

int property nbNearbyFamily = 0 Auto Hidden
Actor[] __nearby_family
Actor[] Property nearby_family
	Actor[] Function Get()
		if !__nearby_family || __nearby_family.length < 128
			__nearby_family = new Actor[128]
		endif
		return __nearby_family
	EndFunction
EndProperty

bool waiting_for_family = false
Function FillNearbySlavesAndActors()
    ;LogTrace("FillNearbySlavesAndActors waiting_for_family="+waiting_for_family)
	if waiting_for_family
		return
	endif
	waiting_for_family   = true
	nbNearbySlaves       = 0
	nbNearbySlavesPwF    = 0
	nbNearbyFollowers    = 0
	nbNearbyActors       = 0 ; avoid wrong loop
    nbNearbyActorsFamily = 0
	fSlave.Clear()
    Cell the_cell = PlayerRef.GetParentCell()

	int knpc = 43 ; kNPC
    int nnpc = the_cell.GetNumRefs(knpc)
	; Make list of interesting slaves
	int i = nnpc
    ;LogTrace("FillNearbySlavesAndActors slaves with "+nnpc+" NPCs")
    while (i > 0)
        i -= 1
		Actor akSomeone = the_cell.GetNthref(i, knpc) As Actor 
		DOM_Actor akActor = GetSlave(akSomeone)
 		if akActor != None
			LogTrace("FillNearbySlavesAndActors CHECK slave "+akActor.GetName()+" family situation="+akSomeone.GetFactionRank(DOMActorFamilyHistory))
			nearby_slaves[nbNearbySlaves] = akActor
			nbNearbySlaves += 1
			if mightHaveFamilyOrFriend(akSomeone)
				;LogTrace("FillNearbySlavesAndActors FOUND slave with possible family "+akActor.GetName())	
				nearby_slaves_pwf[nbNearbySlavesPwF] = akActor
				nbNearbySlavesPwF += 1
			endif
		endif
    endwhile
 	LogTrace("FillNearbySlavesAndActors number of nearby slaves="+nbNearbySlaves+" potentially with family="+nbNearbySlavesPwF)	
	
	; Make list of interested NPCs
	if nbNearbySlavesPwF > 0
		i = nnpc
		;LogTrace("FillNearbySlavesAndActors family with "+i+" NPCs")
		while (i > 0)
			i -= 1
			Actor akSomeone = the_cell.GetNthref(i, knpc) As Actor 
			if IsToCheckForFamily(akSomeone)
				;LogTrace("FillNearbySlavesAndActors CHECK actor="+akSomeone.GetDisplayName())
				DOM_Actor akActor = ActorHasFamilyNearby(akSomeone)
				if akActor != None
					;LogTrace("FillNearbySlavesAndActors FOUND actor="+akSomeone.GetDisplayName()+" family/friend="+akActor.GetName())
					nearby_actors_family[nbNearbyActorsFamily] = akActor
					nbNearbyActorsFamily += 1
					nearby_actors[nbNearbyActors] = akSomeone
					nbNearbyActors += 1
				endif
			endif
		endwhile
	endif
    waiting_for_family = false

	; Check all followers
	i = nbAllFollowers
    while (i > 0)
        i -= 1
        Actor akSomeone = all_followers[i]
		if !IsFollower(akSomeone)
			RemoveFromFollowersList(akSomeone)
        endif
    endwhile
	
	; Make list of followers
    i = nnpc
    ;LogTrace("FillNearbySlavesAndActors followers with "+i+" NPCs")
    while (i > 0)
        i -= 1
        Actor akSomeone = the_cell.GetNthref(i, knpc) As Actor 
		;LogTrace("FillNearbySlavesAndActors followers CHECK actor["+i+"]="+akSomeone.GetDisplayName()+" id="+akSomeone)
		if IsFollower(akSomeone)
 			;LogTrace("FillNearbySlavesAndActors followers FOUND actor["+i+"]="+akSomeone.GetDisplayName())
			nearby_followers[nbNearbyFollowers] = akSomeone
			nbNearbyFollowers += 1
			AddToFollowersList(akSomeone)
       endif
    endwhile
	LogTrace("FillNearbySlavesAndActors number of nearby actors with family="+nbNearbyActors+"/"+nbNearbyActorsFamily+" number of followers="+nbNearbyFollowers)	
EndFunction

DOM_Actor Function ActorHasFamilyNearby(Actor akSomeone)
	int i = 0
	While i < nbNearbySlavesPwF
		DOM_Actor akActor = nearby_slaves_pwf[i]
		Actor akRef = akActor.akRef
		if isFamilyOrFriend(akSomeone,akRef)
			return akActor
		endif
		i += 1
	endwhile
	return None
EndFunction

Actor Function SlaveHasFamilyNearby(DOM_Actor akActor)
	Actor akRef = akActor.akRef
	int i = 0
	While i < nbNearbyActors
		Actor akSomeone = nearby_actors[i]
		if isFamilyOrFriend(akSomeone,akRef)
			return akSomeone
		endif
		i += 1
	endwhile
	return None
EndFunction

bool Function mightHaveFamilyOrFriend(Actor akTarget)
	 if akTarget == None
		return false
	endif
	if !akTarget.GetLeveledActorBase().IsUnique()
		return false
	endif
	if !akTarget.HasKeyWord(ActorTypeNPC)
		return false
	endif
	if akTarget.GetFactionRank(DOMActorFamilyHistory) > 1 ; Slave situation already settled
		return false
	endif
	return true
EndFunction

bool Function isFamilyOrFriend(Actor akSomeone, Actor akSomeoneelse)
	if akSomeone.getRelationshipRank(akSomeoneelse) >= 3
		return true
	endif
	if akSomeone.HasFamilyRelationship(akSomeoneelse)
		return true
	endif
	return false
EndFunction

bool Function IsToCheckForFamily(Actor akSomeone)
	 if akSomeone == None
		return false
	endif
	;LogTrace("IsToCheckForFamily actor="+akSomeone.GetDisplayName())
	 if akSomeone == PlayerRef
		return false
	endif
	if !akSomeone.GetLeveledActorBase().IsUnique()
		return false
	endif
	if !akSomeone.HasKeyWord(ActorTypeNPC)
		return false
	endif
	if akSomeone.IsChild()
		return false
	endif
	if akSomeone.IsGhost()
		return false
	endif
	if akSomeone.IsDead()
		return false
	endif
	if akSomeone.IsUnconscious()
		return false
	endif
	if akSomeone.GetSleepState() == 3
		return false
	endif
	if akSomeone.IsInFaction(DOMActionTied)
		return false
	endif
	if akSomeone.GetActorValue("Paralysis") != 0.0
		return false
	endif
	if isASlave(akSomeone)
		return false
	endif
	if akSomeone.IsInFaction(DOMActorExcludedFaction)
		return false
	endif
	if akSomeone.IsInFaction(DOMActorFaction) 
		return false
	endif
	if akSomeone.IsInFaction(PlayerFollowerFaction)
		return false
	endif
	return true
EndFunction

bool Function IsFollower(Actor akSomeone)
	 if akSomeone == None
		;LogTrace("IsFollower false actor=None")
		return false
	endif
	 if akSomeone == PlayerRef
		;LogTrace("IsFollower false actor is player")
		return false
	endif
	if akSomeone.IsInFaction(DOMActorFaction)
		;LogTrace("IsFollower false DOM actor="+akSomeone.GetDisplayName())
		return false
	endif
	if akSomeone.IsInFaction(DOMActionFollowing)
		;LogTrace("IsFollower true following actor="+akSomeone.GetDisplayName())
		return true
	endif
	if akSomeone.GetActorValue("WaitingForPlayer") == 1.0
		;LogTrace("IsFollower waiting follower actor="+akSomeone.GetDisplayName())
		return false
	endif
	if pTweakWaitingFaction != None && akSomeone.GetFactionRank(pTweakWaitingFaction) > 0
		;LogTrace("IsFollower waiting follower actor="+akSomeone.GetDisplayName())
		return false
	endif
	if akSomeone.IsInFaction(PlayerFollowerFaction)
		;LogTrace("IsFollower true follower actor="+akSomeone.GetDisplayName())
		return true
	endif
	;LogTrace("IsFollower false actor="+akSomeone.GetDisplayName())
	return false
EndFunction

bool Function IsWaitingForPlayer(Actor akRef)
	if akRef == None
		return false
	endif
	if akRef.GetAV("WaitingForPlayer") == 0
		return false
	endif
	return true
EndFunction

bool checking_for_family = false
Function CheckForFamilyAround()
	if nbNearbySlavesPwF <= 0 || nbNearbyActors <= 0 || nbNearbyActorsFamily != nbNearbyActors || checking_for_family
		return
	endif
	checking_for_family = true
	nbNearbyFamily = 0
	NPCClearForceGreet(None)
    Actor akSomeone
	DOM_Actor akActor
    int i = nbNearbyActors
    
    LogTrace("CheckForFamilyAround found "+nbNearbyActors+"/"+nbNearbyActorsFamily+" NPCs for "+nbNearbySlavesPwF+" slaves")
    while (i > 0)
        i -= 1
        akSomeone = __nearby_actors[i]
		if akSomeone != None
			LogTrace("CheckForFamilyAround CHECK actor="+akSomeone.GetDisplayName())
			akActor = __nearby_actors_family[i]
			if akActor != None
				LogTrace("CheckForFamilyAround FOUND actor="+akSomeone.GetDisplayName()+" family/friend="+akActor.GetName())
				fSlave.ForceRefTo(akActor.akRef)
				nearby_family[nbNearbyFamily] = akSomeone
				nbNearbyFamily = 1
				int k = i
				while (k > 0 && nbNearbyFamily < __nearby_family.length)
					k -= 1
					Actor akSomeoneelse      = __nearby_actors[k]
					DOM_Actor akAnotherActor = __nearby_actors_family[k]
					if akAnotherActor == akActor
						LogTrace("CheckForFamilyAround FOUND other actor="+akSomeoneelse.GetDisplayName()+" family/friend="+akActor.GetName()+" index="+nbNearbyFamily)
						__nearby_family[nbNearbyFamily] = akSomeoneelse
						nbNearbyFamily += 1
					endif
				endwhile
				if nbNearbyFamily <= 1
					NPCStartForceGreet(akSomeone,akActor.akRef)
				else
					int j = RandomInt(0,nbNearbyFamily-(1))
					LogTrace("CheckForFamilyAround picking actor index="+j)
					NPCStartForceGreet(__nearby_family[j],akActor.akRef)
				endif
				checking_for_family = false
				return
			endif
        endif
    endwhile
	fSlave.Clear()
	NPCClearForceGreet(None)
	checking_for_family = false
EndFunction

Function NPCFamilyKeep(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyKeep 1")
	NPCStopForceGreet(akTarget)
	akTarget.SendAssaultAlarm()
	; DOMActorFamilyHistory set to 1 if kept by force, 2 if family accepted the situation, 3 if paid, 4 if family was scared, 5 if freed
	akActor.akRef.SetFactionRank(DOMActorFamilyHistory,1)
	DOM_Mind akMind = akActor.mind
	akMind.should_fight_for_player = false
	if !akMind.IsDevoted()
		akMind.mood = "shock"
	endif
	TrainSkillPredator(PlayerRef,0.5)
	if akTarget.GetRelationshipRank(PlayerRef) >= 0
		akTarget.SetRelationshipRank(PlayerRef,(-1)) 
	endif
	;NPCCheckForceGreet()
EndFunction

Function NPCFamilyAccept(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyAccept 2")
	NPCStopForceGreet(akTarget)
	; DOMActorFamilyHistory set to 1 if kept by force, 2 if family accepted the situation, 3 if paid, 4 if family was scared, 5 if freed
	akActor.akRef.SetFactionRank(DOMActorFamilyHistory,2)
	DOM_Mind akMind = akActor.mind
	if !akMind.IsDevoted()
		akMind.mood = "shock"
	endif
	DOMInfoNPCTrainingAdjust(akTarget, None, 0, 20.0, 4) ; increase submission
	TrainSkillDepraver(PlayerRef,1.0)
	NPCCheckForceGreet()
EndFunction

Function NPCFamilyFear(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyFear 4")
	NPCStopForceGreet(akTarget)
	; DOMActorFamilyHistory set to 1 if kept by force, 2 if family accepted the situation, 3 if paid, 4 if family was scared, 5 if freed
	akActor.akRef.SetFactionRank(DOMActorFamilyHistory,4)
	DOM_Mind akMind = akActor.mind
	if !akMind.IsDevoted()
		akMind.mood = "shock"
	endif
	DOMInfoNPCTrainingAdjust(akTarget, None, 1, 20.0, 0) ; increase fear
	TrainSkillEnforcer(PlayerRef,1.0)
	int rank = akTarget.GetRelationshipRank(PlayerRef)
	if rank > 0 && rank < 4
		akTarget.SetRelationshipRank(PlayerRef,(-1)) 
	endif
	NPCCheckForceGreet()
EndFunction

int pay_amount = 0
Function NPCFamilyRecruitOffer(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyRecruitOffer: checking actor family "+akTarget.GetDisplayName())
	Actor akRef = akActor.akRef
	DOMGenerator.GetNPCTraitsUpdateModifiers(akTarget) ; Needs to update modifiers to get potential slaver status
	int amount = GetFeeForRecruiting(akTarget)*5
	float fvalue = (amount as float)/DOMPlayerAlias.GetSlaverModifier()
	LogTrace("NPCFamilyRecruitOffer: "+akTarget.GetDisplayName()+" and "+akRef.GetDisplayName()+" recruiting fee ="+amount+"/"+DOMPlayerAlias.GetSlaverModifier()+" = "+fvalue)
	float value = 0.0
	int type = GetFriendshipType(akTarget,akRef)
	int rank = akTarget.GetRelationShipRank(akRef)
	if rank >= 4 || type == 3 ; child
		value = (16000.0/DOMPlayerAlias.GetDepraverModifier())
		if type == 0 ; just friends
			value /= 2.0
		elseif type > 10 ; not close family
			value /= 1.5
		elseif type > 5 ; not lover parents or children
			value /= 1.25
		endif
	elseif rank >= 3 || type == 4 ; parents
		value = (8000.0/DOMPlayerAlias.GetDeceiverModifier()) as int
		if type == 0 ; just friends
			value /= 3.0
		elseif type > 10 ; not close family
			value /= 2.0
		elseif type > 5 ; not lover parents or children
			value /= 1.5
		endif
	elseif rank >= 2
		value = (4000.0/DOMPlayerAlias.GetPredatorModifier()) as int
		if type == 0 ; just friends
			value /= 4.0
		elseif type > 10 ; not close family
			value /= 3.0
		elseif type > 5 ; not lover parents or children
			value /= 2.0
		endif
	elseif rank >= 1
		value = (2000.0/DOMPlayerAlias.GetPersuaderModifier()) as int
		if type == 0 ; just friends
			value /= 5.0
		elseif type > 10 ; not close family
			value /= 4.0
		elseif type > 5 ; not lover parents or children
			value /= 3.0
		endif
	else
		value = (1000.0/GetEnforcerModifier(PlayerRef)) as int
		if type == 0 ; just friends
			value /= 5.0
		elseif type > 10 ; not close family
			value /= 4.0
		elseif type > 5 ; not lover parents or children
			value /= 3.0
		endif
	endif
	pay_amount = (value+fvalue) as int
	LogTrace("NPCFamilyRecruitOffer: "+akTarget.GetDisplayName()+" and "+akRef.GetDisplayName()+" type="+type+" rank="+rank)
	LogTrace("NPCFamilyRecruitOffer: "+akTarget.GetDisplayName()+" and "+akRef.GetDisplayName()+" total recruiting fee ="+fvalue+" + "+value+" = "+pay_amount)
	LogTrace("NPCFamilyRecruitOffer: "+akTarget.GetDisplayName()+" could join you for "+pay_amount)
	Debug.MessageBox(akTarget.GetDisplayName()+" will agree for "+pay_amount+" gold to join you as a slaver and help train "+akActor.GetName())
EndFunction

Function NPCFamilyRecruit(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyRecruit: checking actor family "+akTarget.GetDisplayName())
	Actor akRef = akActor.akRef
	LogTrace("NPCFamilyRecruit: "+akTarget+" and "+akRef)
	LogTrace("NPCFamilyRecruit: "+akTarget.GetDisplayName()+" could join you for "+pay_amount)
	LogTrace("NPCFamilyRecruit: "+akTarget.GetDisplayName()+" could join you for "+pay_amount)
	int ibutton = DOMkeys.DOMNPCRecruitMessage.show(pay_amount as float)  
	LogTrace("NPCFamilyRecruit: "+akTarget.GetDisplayName()+" could join you for "+pay_amount+" ibutton="+ibutton)
	if ibutton == 0
		if (PlayerRef.GetGoldAmount() >= pay_amount)
			LogTrace("NPCFamilyRecruit: "+akTarget.GetDisplayName()+" will join you for "+pay_amount+" STOP force greet")
			NPCStopForceGreet(akTarget)
			; DOMActorFamilyHistory set to 1 if kept by force, 2 if family accepted the situation, 3 if paid, 4 if family was scared, 5 if freed, 6 if recruited
			akRef.SetFactionRank(DOMActorFamilyHistory,6)
			PlayerRef.RemoveItem(Gold001, pay_amount)
			HudNotification(akTarget.getDisplayName()+" was recruited for "+pay_amount+" gold")
			DOM_Mind akMind = akActor.mind
			if !akMind.IsDevoted()
				akMind.mood = "shock"
			endif
			if pay_amount > 100
				pay_amount = pay_amount / 10
			elseif pay_amount > 10
				pay_amount = 10
			endif
			akTarget.AddItem(Gold001, pay_amount)
			TrainSkillSlaver(PlayerRef,1.0)
			NPCCheckForceGreet()
			DOM_Actor akSlaver = DOM01.Recruit(akTarget)
			if akSlaver != None
				DOM_Mind akSlaverMind = akSlaver.mind
				if akSlaverMind != None
					akSlaverMind.TrainSkillSlaver(5.0)
					akSlaverMind.TrainSkillDeceiver(5.0)
					akSlaverMind.TrainSkillEnforcer(10.0)
					akSlaverMind.TrainSkillDepraver(10.0)
				else
					TrainSkillSlaver(akTarget,Randomint(3,7))
					TrainSkillDeceiver(akTarget,Randomint(3,7))
					TrainSkillEnforcer(akTarget,Randomint(5,10))
					TrainSkillDepraver(akTarget,Randomint(5,10))
				endif
			else
				TrainSkillSlaver(akTarget,Randomint(3,7))
				TrainSkillDeceiver(akTarget,Randomint(3,7))
				TrainSkillEnforcer(akTarget,Randomint(5,10))
				TrainSkillDepraver(akTarget,Randomint(5,10))
			endif
		else
			HudNotification("You don't have enough gold!")
			NPCFamilyKeep(akTarget,akActor)
		endif
	else
		NPCFamilyKeep(akTarget,akActor)
	endif
EndFunction

Function NPCFamilyOffer(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyOffer: checking actor family "+akTarget.GetDisplayName())
	Actor akRef = akActor.akRef
	LogTrace("NPCFamilyOffer: "+akTarget.GetDisplayName()+" and "+akRef.GetDisplayName())
	LogTrace("NPCFamilyOffer: "+akActor.getName()+" could be sold by "+akTarget.GetDisplayName())
	float fvalue = (DOMGenerator.GetActorFullPrice(akRef) as float)/DOMPlayerAlias.GetPersuaderModifier()
	pay_amount = (fvalue as int)
	Debug.MessageBox(akTarget.GetDisplayName()+" will agree for "+pay_amount+" gold for you to keep "+akActor.GetName())
EndFunction

Function NPCFamilyPay(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyPay: checking actor family "+akTarget.GetDisplayName())
	Actor akRef = akActor.akRef
	LogTrace("NPCFamilyPay: "+akTarget+" and "+akRef)
	LogTrace("NPCFamilyPay: "+akActor.getName()+" could be sold by "+akTarget.GetDisplayName())
	LogTrace("NPCFamilyPay: "+akActor.getName()+" could be sold by "+akTarget.GetDisplayName()+" amount="+pay_amount)
	int ibutton = DOMFamilyPayMessage.show(pay_amount as float)  
	LogTrace("NPCFamilyPay: "+akActor.getName()+" could be sold by "+akTarget.GetDisplayName()+" ibutton="+ibutton)
	if ibutton == 0
		if (PlayerRef.GetGoldAmount() >= pay_amount)
			LogTrace("NPCFamilyPay: "+akActor.getName()+" could be sold by "+akTarget.GetDisplayName()+" STOP force greet")
			NPCStopForceGreet(akTarget)
			; DOMActorFamilyHistory set to 1 if kept by force, 2 if family accepted the situation, 3 if paid, 4 if family was scared, 5 if freed
			akRef.SetFactionRank(DOMActorFamilyHistory,3)
			PlayerRef.RemoveItem(Gold001, pay_amount)
			HudNotification(akActor.getName()+" was bought for "+pay_amount+" gold")
			DOM_Mind akMind = akActor.mind
			if !akMind.IsDevoted()
				akMind.mood = "shock"
			endif
			if pay_amount > 100
				pay_amount = pay_amount / 10
			elseif pay_amount > 10
				pay_amount = 10
			endif
			akTarget.AddItem(Gold001, pay_amount)
			DOMInfoNPCTrainingAdjust(akTarget, None, 2, 20.0, 3) ; increase humiliation
			TrainSkillSlaver(PlayerRef,1.0)
			NPCCheckForceGreet()
		else
			HudNotification("You don't have enough gold!")
			NPCFamilyKeep(akTarget,akActor)
		endif
	else
		NPCFamilyKeep(akTarget,akActor)
	endif
EndFunction

Function NPCFamilyRansomOffer(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyRansomOffer: checking actor family "+akTarget.GetDisplayName())
	Actor akRef = akActor.akRef
	LogTrace("NPCFamilyRansomOffer: "+akTarget.GetDisplayName()+" and "+akRef.GetDisplayName())
	int rank = akRef.GetFactionRank(DOMActorFamilyReunited)
	LogTrace("FamilyRansom: "+akActor.getName()+" could be freed by "+akTarget.GetDisplayName()+" reunited="+rank)
	if rank <= 0
		rank = 1
	else 
		rank += 1
	endif
	float fvalue = (DOMGenerator.GetActorPrice(akRef) as float)/DOMPlayerAlias.GetPersuaderModifier()/(rank as float)
	int max_value = DOMGenerator.GetNPCWealth(akTarget)
	int value = (fvalue as int)
	if value > max_value
		value = max_value
	endif
	Debug.MessageBox(akTarget.GetDisplayName()+" could pay "+value+" gold to free "+akActor.GetName())
EndFunction

Function NPCFamilyRansomPay(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyRansomPay: checking actor family "+akTarget.GetDisplayName())
	Actor akRef = akActor.akRef
	LogTrace("NPCFamilyRansomPay: "+akTarget+" and "+akRef)
	int rank = akRef.GetFactionRank(DOMActorFamilyReunited)
	LogTrace("NPCFamilyRansomPay: "+akActor.getName()+" could be freed by "+akTarget.GetDisplayName()+" reunited="+rank)
	if rank <= 0
		rank = 1
	else 
		rank += 1
	endif
	float fvalue = (DOMGenerator.GetActorPrice(akRef) as float)/DOMPlayerAlias.GetPersuaderModifier()/(rank as float)
	int max_value = DOMGenerator.GetNPCWealth(akTarget)
	int value = (fvalue as int)
	if value > max_value
		value = max_value
	endif
	int ibutton = DOMFamilyRansomMessage.show(value as float)  
	if ibutton == 0
		NPCStopForceGreet(akTarget)
		; DOMActorFamilyHistory set to 1 if kept by force, 2 if family accepted the situation, 3 if paid, 4 if family was scared, 5 if freed
		akRef.SetFactionRank(DOMActorFamilyHistory,5)
		HudNotification(akActor.getName()+" was sold for "+value+" gold")
		PlayerRef.AddItem(Gold001, value)
		DOMInfoNPCTrainingAdjust(akTarget, None, 4, 20.0, 2) ; increase resignation
		DOMPlayerAlias.HasRansomed(akActor)
		akActor.ReleaseOrDelete()
		DOM02.SlaveFamilyAdjustRelationShip(akTarget,akRef,true)
		NPCCheckForceGreet()
	else
		DOM02.SlaveFamilyAdjustRelationShip(akTarget,akRef,false)
		NPCFamilyKeep(akTarget,akActor)
	endif
EndFunction

Function NPCFamilyFree(Actor akTarget, DOM_Actor akActor)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyFree 5")
	NPCStopForceGreet(akTarget)
	; DOMActorFamilyHistory set to 1 if kept by force, 2 if family accepted the situation, 3 if paid, 4 if family was scared, 5 if freed
	akActor.akRef.SetFactionRank(DOMActorFamilyHistory,5)
	DOMInfoNPCTrainingAdjust(akTarget, None, 5, 20.0, 2) ; increase respect
	TrainSkillPersuader(PlayerRef,1.0)
	akActor.ReleaseOrDelete()
	int rank = akTarget.GetRelationshipRank(PlayerRef)
	if rank < 3
		akTarget.SetRelationshipRank(PlayerRef,rank+1) 
	endif
	NPCCheckForceGreet()
EndFunction

Function NPCFamilyForgetIt(Actor akTarget)
	if akTarget == None
		return
	endif
	; This case is for if the slave was already freed
	LogTrace("NPCFamilyForgetIt")
	NPCStopForceGreet(akTarget)
	; DOMActorFamilyHistory set to 1 if kept by force, 2 if family accepted the situation, 3 if paid, 4 if family was scared, 5 if freed
	DOMInfoNPCTrainingAdjust(akTarget, None, 5, 20.0, 2) ; increase respect
	TrainSkillPersuader(PlayerRef,1.0)
	int rank = akTarget.GetRelationshipRank(PlayerRef)
	if rank < 3
		akTarget.SetRelationshipRank(PlayerRef,rank+1) 
	endif
	NPCCheckForceGreet()
EndFunction

Function NPCFamilyAbduct(Actor akTarget, DOM_Actor akActor, bool is_mesmerized)
	if akActor == None
		return
	endif
	if akTarget == None
		return
	endif
	LogTrace("NPCFamilyAbduct")
	NPCStopForceGreet(akTarget)
	TrainSkillDeceiver(PlayerRef,1.0)
	if !is_mesmerized
		DOMInfoNPCTrainingAdjust(akTarget, None, 3, 20.0, 1) ; increase anger
		DOMKeys.DOMActorAbduction(akTarget)
	else
		DOMKeys.DOMActorEnslave(akTarget,attentionPose)
	endif
	; NPCCheckForceGreet() is already called at the end of abduction
EndFunction

Function NPCClearForceGreet(Actor akTarget)
	Actor akRef = fFamily.GetActorRef()
	if akTarget != None && akTarget != akRef
		return ; do not clear, wrong actor
	endif
	if akRef != None
		NPCStopForceGreet(akRef)
	endif
EndFunction

Function NPCStartForceGreet(Actor akTarget, Actor akSlave)
	LogTrace("NPCStartForceGreet "+akTarget.GetDisplayName())
	if akSlave == None || !isASlave(akSlave)
		NPCStopForceGreet(akTarget)
		return
	endif	
	if akSlave.GetFactionRank(DOMActorFamilyHistory) > 1 ; slave status was already settled	
		NPCStopForceGreet(akTarget)
		return
	endif			
	fFamily.ForceRefTo(akTarget)
	Package current_package = akTarget.GetCurrentPackage()
	if current_package == DOMFamilyForceGreet
		return
	endif
	LogTrace("NPCStartForceGreet "+akTarget.GetDisplayName()+" package="+DOMFamilyForceGreet+" current="+current_package+" rank="+akSlave.GetFactionRank(DOMActorFamilyHistory))
	ActorUtil.AddPackageOverride(akTarget, DOMFamilyForceGreet, 127, 1)
	akTarget.EvaluatePackage()
EndFunction

Function NPCStopForceGreet(Actor akTarget)
	if fFamily.GetActorRef() == akTarget
		fFamily.Clear()
	endif
	LogTrace("NPCStopForceGreet "+akTarget.GetDisplayName()+" package="+DOMFamilyForceGreet)
	ActorUtil.RemovePackageOverride(akTarget, DOMFamilyForceGreet)
	akTarget.EvaluatePackage()
EndFunction

Function NPCCheckForceGreet()
	actor_in_dialogue = None
	if !familyToggle
		return
	endif
	; Check for other slaves in dire strait
	LogTrace("NPCCheckForceGreet FillNearbySlavesAndActors")
	FillNearbySlavesAndActors()
	LogTrace("NPCCheckForceGreet CheckForFamilyAround")
	CheckForFamilyAround()
EndFunction

bool on_global_friend_check = false
Function ReCheckFollowFriendships()
	if !friendFollowToggle
		on_global_friend_check = false
		return
	endif
	float current_time               = GetCurrentGameTime()
	float time_since_last_check      = current_time-distant_friend_time
	if time_since_last_check >= 1.0 ; full check will happen soon, skip this one
		return
	endif
	if on_distant_friend_check
		return
	endif
	if on_global_friend_check
		return
	endif
	on_global_friend_check = true
	;LogTrace("ReCheckFollowFriendships toggle="+friendFollowToggle)
	string the_event = "CheckFriendship"
	bool doSendEvent = false
	; slaves
	int i = DOM02.actorCounter-(1)
	LogTrace("ReCheckFollowFriendships toggle="+friendFollowToggle+" nslaves="+(i+1))
	While i >=0 ; New actors first
		DOM_Actor akActor = DOM02.actorArray[i]
		if akActor != None
			; Only actors moving with player should be recheck
			if IsTogetherWithFast(PlayerRef, akActor.akRef, 2000.0) ; 2000 = 28 meters
				if sendDOMEvents
					akActor.RegisterForDOMEvent(None,the_event)
					doSendEvent = true
				else
					akActor.CheckFriendship(i)
				endif
			endif
		endif
		i -= 1
	EndWhile
	; slavers
	i = DOM01.actorCounter-(1)
	;LogTrace("ReCheckFollowFriendships toggle="+friendFollowToggle+" nslavers="+(i+1))
	While i >=0 ; New actors first
		DOM_Actor akActor = DOM01.actorArray[i]
		if akActor != None
			; Only actors moving with player should be recheck
			if IsTogetherWithFast(PlayerRef, akActor.akRef, 2000.0) ; 2000 = 28 meters
				if sendDOMEvents
					akActor.RegisterForDOMEvent(None,the_event)
					doSendEvent = true
				else
					akActor.CheckFriendship(i)
				endif
			endif
		endif
		i -= 1
	EndWhile
	if doSendEvent
		SendDOMEvent(None,the_event)
	endif
	on_global_friend_check = false
EndFunction

bool on_distant_friend_check = false
float distant_friend_time = 0.0
Function ReCheckDistantFriendships()
	if !friendDistantToggle
		on_distant_friend_check = false
		return
	endif
	float current_time               = GetCurrentGameTime()
	float time_since_last_check      = current_time-distant_friend_time
	if time_since_last_check < 1.0 ; one day
		return
	endif
	if on_distant_friend_check
		return
	endif
	on_distant_friend_check = true
	distant_friend_time = GetCurrentGameTime()
	;LogTrace("ReCheckDistantFriendships toggle="+friendFollowToggle)
	string the_event = "CheckFriendship"
	bool doSendEvent = false
	; slaves
	int i = DOM02.actorCounter-(1)
	LogTrace("ReCheckDistantFriendships toggle="+friendFollowToggle+" nslaves="+(i+1))
	While i >=0 ; New actors first
		DOM_Actor akActor = DOM02.actorArray[i]
		if akActor != None
			; Check all actors
			if sendDOMEvents
				akActor.RegisterForDOMEvent(None,the_event)
				doSendEvent = true
			else
				akActor.CheckFriendship(i)
			endif
		endif
		i -= 1
	EndWhile
	; slavers
	i = DOM01.actorCounter-(1)
	;LogTrace("ReCheckDistantFriendships toggle="+friendFollowToggle+" nslavers="+(i+1))
	While i >=0 ; New actors first
		DOM_Actor akActor = DOM01.actorArray[i]
		if akActor != None
			; Check all actors
			if sendDOMEvents
				akActor.RegisterForDOMEvent(None,the_event)
				doSendEvent = true
			else
				akActor.CheckFriendship(i)
			endif
		endif
		i -= 1
	EndWhile
	if doSendEvent
		SendDOMEvent(None,the_event)
	endif
	on_distant_friend_check = false
EndFunction

Function TrainWitnesses(DOM_Actor akActor, int reason, string type, float amount)
	LogTrace("TrainWitnesses: "+akActor.getName()+" number of actors="+DOM02.actorCounter+" reason="+reason+" type="+type+" amount="+amount)
	Actor akRef = akActor.akRef
	string the_event = "TrainWitness"
	bool doSendEvent = false
	int i = 0
	while i < DOM02.actorCounter
		DOM_Actor akOther = DOM02.actorArray[i]
		if akOther != None && akOther != akActor
			if akOther.IsAttentive() || type == "public_humiliation" || type == "to be sacrificed"
				if IsTogetherWithFast(akRef, akOther.akRef, 2000.0) ; 2000 = 30 meters	
					if sendDOMEvents
						akOther.RegisterForDOMEvent(akRef,the_event)
						doSendEvent = true
					else
						akOther.TrainWitness(akActor,amount,reason,type)
					endif
				endif
			endif
		endif
		i += 1
	EndWhile
	if doSendEvent
		SendDOMEvent(akRef,the_event,amount,reason,type)
	endif
EndFunction

; ### Cloning

string Function GetPreviousOccupation(Actor akRef)
	ActorBase abRef = akRef.GetLeveledActorBase()
	if abRef != None
		return abRef.GetName()
	endif
	return akRef.GetDisplayName()
EndFunction

Actor Function CloneOrNot(Actor original, bool force_clone=false)
	;LogTrace("CloneOrNot() Start")
	ActorBase original_base = original.GetLeveledActorBase()
	bool do_clone
	bool is_dead = false
	if force_clone
		do_clone = true
	elseIf original.IsDead() ; force cloning for dead NPCs
		LogTrace("CloneOrNot() Force cloning IsDead="+original.IsDead())
		do_clone = true
		is_dead = true
	elseIf original.IsInFaction(DOMActorAlreadyCleaned) ; Already captured
		;LogTrace("CloneOrNot() No cloning DOMActorAlreadyCleaned")
		do_clone = false
	elseIf DOMPAH.WasAlreadyCleaned(original) ; Already cloned by PAH
		do_clone = false
	elseIf AygasSlaveTypeFaction != None && original.IsInFaction(AygasSlaveTypeFaction)
		;LogTrace("CloneOrNot() No cloning AYGAS")
		do_clone = false
	elseIf HshHouseSlaveFaction != None && original.IsInFaction(HshHouseSlaveFaction)
		;LogTrace("CloneOrNot() No cloning HSH")
		do_clone = false
	elseIf ( original_base == None )
		;LogTrace("CloneOrNot() No cloning No actor base")
		original.setFactionRank(DOMNoCloneFaction,1)
	elseIf original_base.IsUnique() && !cloneUniqueMode 
		;LogTrace("CloneOrNot() No cloning IsUnique")
		original.setFactionRank(DOMNoCloneFaction,1)
	else
		do_clone = true
	endif

	int[] captiveData = DOMPAH.GetActorData(original) ; PAH origin data
	int[] captiveInfo = new Int[5] ; DOM origin data
	captiveInfo[0] = DOMGenerator.GetPlaceOfOriginIndex(original)
	captiveInfo[1] = DOMGenerator.GetJobOfOriginIndex(original)
	captiveInfo[2] = DOMGenerator.GetEmployerOfOriginIndex(original)
	captiveInfo[3] = DOMGenerator.GetTrainerOfOriginIndex(original)
	captiveInfo[4] = DOMGenerator.GetClassOfOriginIndex(original)

	; Spawned actors
	If do_clone || original.IsDead() ; last chance to check for dead actor
		LogTrace("CloneOrNot() Force cloning "+original.GetDisplayName())
		original = CloneAndCopyActor(original)
		if original == None
			return None
		endif
	else
		LogTrace("CloneOrNot() Keep original actor "+original.GetDisplayName())
	endif
	CleanFactions(original)
	if cleanCrimeFaction
		Faction the_faction = original.GetCrimeFaction()
		if the_faction != None
			original.SetCrimeFaction(None)
			RemoveFromFaction(original,the_faction)
		endif
		RemoveFromFaction(original,DOMNoCleanCrimeFaction)
	endif
	LogTrace("CloneOrNot() is_dead="+is_dead+" IsDead="+original.IsDead())
	if is_dead
		LogTrace("CloneOrNot() is_dead="+is_dead+" adding faction and keyword")
		PO3_SKSEFunctions.AddKeywordToForm(original,ActorTypeUndead)
		original.SetFactionRank(DOMGenerator.DraugrAllyFaction,1)
	endif
	DOMGenerator.SetPlaceOfOrigin(original,captiveInfo[0])
	DOMGenerator.SetJobOfOrigin(original,captiveInfo[1])
	DOMGenerator.SetEmployerOfOrigin(original,captiveInfo[2])
	DOMGenerator.SetTrainerOfOrigin(original,captiveInfo[3])
	DOMGenerator.SetClassOfOrigin(original,captiveInfo[4])
	DOMPAH.SetActorData(original, captiveData)
	if RemoveEssentialToggle
		original.GetLeveledActorBase().SetInvulnerable(false)
		original.GetLeveledActorBase().SetEssential(false)
	endif
	if SetEssentialToggle
		original.GetLeveledActorBase().SetEssential(true)
	endif
	;LogTrace("INFO: CloneOrNot "+original.GetDisplayName()+" print all factions")
	;PrintAllFactions(original)
	return original
EndFunction

string Function GetOBodyPreset(Actor act)
	if act.GetLeveledActorBase().GetSex() == 0
		if !setOBodyPresetToggleM
			return "Undefined"
		endif
	else
		if !setOBodyPresetToggleF
			return "Undefined"
		endif
	endif

	if !act.HasKeywordString("ActorTypeNPC")
		return "creature"
	endif
	
	string actorPresetKey1 = "obody_" + act.GetFormID() + "_preset"
	string currentPreset = StorageUtil.GetStringValue(None, actorPresetKey1, missing = "")
	if currentPreset == ""
		string actorPresetKey2 = "obody_" + act.GetActorBase().GetName() + "_preset"
		currentPreset = StorageUtil.GetStringValue(None, actorPresetKey2, missing = "")
		if currentPreset == ""
			LogTrace("GetOBodyPreset could not get preset for actor "+act.GetDisplayName()+"/"+act.GetActorBase().GetName())
			return "Unknown Preset"
		endif
	endif
	LogTrace("GetOBodyPreset for actor "+act.GetDisplayName()+"/"+act.GetActorBase().GetName()+" preset="+currentPreset)
	return currentPreset
EndFunction

Function SetOBodyPreset(Actor act, string preset)
	if act.GetLeveledActorBase().GetSex() == 0
		if !setOBodyPresetToggleM
			LogTrace("SetOBodyPreset SKIPPED for male actor "+act.GetDisplayName()+"/"+act.GetActorBase().GetName()+" preset="+preset)
			return
		endif
	else
		if !setOBodyPresetToggleF
			LogTrace("SetOBodyPreset SKIPPED for female actor "+act.GetDisplayName()+"/"+act.GetActorBase().GetName()+" preset="+preset)
			return
		endif
	endif

	if !act.HasKeyword(ActorTypeNPC)
		LogTrace("SetOBodyPreset SKIPPED not an actor "+act.GetDisplayName()+"/"+act.GetActorBase().GetName()+" preset="+preset)
		return
	endif
	if Game.GetModByName("OBody.esp") == 255
		LogTrace("SetOBodyPreset SKIPPED OBody not found actor "+act.GetDisplayName()+"/"+act.GetActorBase().GetName()+" preset="+preset)
		return
	endif
	OBodyNative.ApplyPresetByName(act,preset)
	LogTrace("SetOBodyPreset for actor "+act.GetDisplayName()+"/"+act.GetActorBase().GetName()+" preset="+preset)
EndFunction

Actor Function CloneAndCopyActor(Actor original)
	;LogTrace("CloneAndCopyActor(): Start "+original.GetDisplayName())

	ActorBase original_base = original.GetLeveledActorBase()
	; Rename cloned actor with PAH generated name
	string name = ""
	if renameToggle && !original_base.IsUnique() && !original.IsInFaction(DOMNameChangedFaction)
		;LogTrace("CloneAndCopyActor rename "+original.GetDisplayName()+"/"+original.GetName()+"/"+original.GetLeveledActorBase().GetName())
		if original.GetDisplayName() == original.GetLeveledActorBase().GetName() ; keep already generated names
			name = NameGenerator(original) ; use PAH name generator
		endif
	endif

	string obody_preset = GetOBodyPreset(original)

	Actor clone = CloneActor(original)
	if clone == None	
		LogTrace("CloneAndCopyActor(): Cloning failed")
		return None
	endif
	if name == ""
		clone.setDisplayName(original.GetDisplayName(),true)
		if original.IsInFaction(DOMNameChangedFaction)
			int rank_namechanged = original.GetFactionRank(DOMNameChangedFaction)
			clone.SetFactionRank(DOMNameChangedFaction,rank_namechanged)
		endif
	else
		LogTrace("CloneAndCopyActor rename to "+name+" from "+original.GetDisplayName())
		clone.setDisplayName(name,true)
		clone.SetFactionRank(DOMNameChangedFaction,3) ; 3=Name was changed by DOM
	endif
	DOMEquip.CheckCloneEquipment(original_base, original, clone)
	Int [] fact_save1 = SaveFactions1(original) ; Save DOM & PAH factions
	Int [] fact_save2 = SaveFactions2(original) ; Save DOM & PAH factions
	cleanActor(clone) ; remove all factions
	RestoreFactions(clone,fact_save1,fact_save2) ; Restore DOM & PAH factions
	CheckGender(clone)
	copySexStats(clone, original)
	copyFactions(clone, original)
	SetOBodyPreset(clone,obody_preset)
	
	; Transfer nodes
	If CheckNiOverride()
		transferNode(original, clone)
	endif  
	prepareClone(original, clone) ; remove spells and tats
	CalmActorFast(clone)
	return clone
EndFunction

string Function NameGenerator(Actor akRef)
	string gender
	if akRef.IsInFaction(DOMActorGender)
		If ((akRef.getFactionRank(DOMActorGender) %2 ) == 0)
			gender = "Male"
		else
			gender = "Female"
		endif
	elseIf akRef.GetLeveledActorBase().GetSex() == 0
		gender = "Male"
	else
		gender = "Female"
	endif
	string sRace = akRef.getRace().getName()
	string fileName = "Data/SKSE/Plugins/StorageUtilData/Diary Of Mine/Names/" + gender + sRace + ".txt"
	int jNames
	int rInt
	string name
	if JsonUtil.JsonExists(fileName)
		jNames = JValue.readFromFile(fileName)
		rInt = Utility.RandomInt(0, JArray.count(jnames) - 1)
		name = JArray.getStr(jnames, rInt)
		If name != ""
			LogTrace("Found name in n="+JArray.count(jnames)+" fileName="+fileName)
			return name
		endif
		LogTrace("No DOM name found n="+JArray.count(jnames)+" fileName="+fileName)
	else
		LogTrace("No DOM name found file doesn't exist fileName="+fileName)
	endif
	LogTrace("No DOM name found for " + gender + " " + sRace+" trying PAH names")

	fileName = "Data/PAHE/" + gender + sRace + ".txt"
	if JsonUtil.JsonExists(fileName)
		jNames = JValue.readFromFile(fileName)
		rInt = Utility.RandomInt(0, JArray.count(jnames) - 1)
		name = JArray.getStr(jnames, rInt)
		If name != ""
			LogTrace("Found name in n="+JArray.count(jnames)+" fileName="+fileName)
			return name
		endif
		LogTrace("No PAH name found n="+JArray.count(jnames)+" fileName="+fileName)
	else
		LogTrace("No PAH name found file doesn't exist fileName="+fileName)
	endif
	LogTrace("No PAH name found for " + gender + " " + sRace+" trying DOM mixed race names")

	fileName = "Data/SKSE/Plugins/StorageUtilData/Diary Of Mine/Names/" + gender + ".txt"
	if JsonUtil.JsonExists(fileName)
		jNames = JValue.readFromFile(fileName)
		rInt = Utility.RandomInt(0, JArray.count(jnames) - 1)
		name = JArray.getStr(jnames, rInt)
		If name != ""
			return name
		endif
	endif
	LogTrace("No DOM mixed race name found for " + gender + " " + sRace+" trying PAH mixed race names")

	fileName = "Data/PAHE/" + gender + ".txt"
	if JsonUtil.JsonExists(fileName)
		jNames = JValue.readFromFile(fileName)
		rInt = Utility.RandomInt(0, JArray.count(jnames) - 1)
		name = JArray.getStr(jnames, rInt)
		If name != ""
			return name
		endif
	endif
	name = akRef.GetDisplayName()
	LogInfo("WARNING! No name found for " + gender + " " + sRace+" "+name)
	return name
EndFunction

Function cleanActor(Actor akRef)
	;LogTrace("cleanActor() "+akRef.GetDisplayName())
	akRef.SetCrimeFaction(None)
	akRef.RemoveFromAllFactions()
	akRef.IgnoreFriendlyHits(true)
	akRef.SetFactionOwner(PlayerFaction)
EndFunction

Actor Function CheckGender(actor slave)
	int actorGender = GetActorGender(slave)
	if (actorGender % 2) == 0 ; Male
		DOMSexlab.TreatAsMale(slave)
	else ; Female
		DOMSexlab.TreatAsFemale(slave)
	endif
EndFunction

ActorBase Function GetValidActorBase(actor akActor)
	ActorBase base = akActor.GetActorBase()
	ActorBase base_leveled = akActor.GetLeveledActorBase()
	if base != base_leveled
		return base_leveled.GetTemplate()
	else
		return base
	endif
EndFunction

bool Function IsSimilarActorBase(ActorBase akActorBase1, ActorBase akActorBase2)
    If (akActorBase1.GetSex() != akActorBase2.GetSex())
        return false
    elseIf (akActorBase1.GetRace() != akActorBase2.GetRace())
        return false
    elseIf (akActorBase1.GetFacePreset(0) != akActorBase2.GetFacePreset(0))
        return false
    elseIf (akActorBase1.GetFacePreset(2) != akActorBase2.GetFacePreset(2))
        return false
    elseIf (akActorBase1.GetFacePreset(3) != akActorBase2.GetFacePreset(3))
        return false
    endif

    return true
EndFunction

Actor Function CloneActor(Actor original)
	;LogTrace("CloneActor(): get clone")
	If original.IsInFaction(DOMActorAlreadyCleaned)
		LogTrace("CloneActor Actor already cleaned by DOM")
		return original
	elseIf DOMPAH.WasAlreadyCleaned(original)
		LogTrace("CloneActor Actor already cleaned by PAH")
		return original
	endif
	; WARNING: Creating an actor in script from a temporary ActorBase will cause a CTD when the temporary ActorBase is garbage collected. 
	; To make a copy of an actor, use GetActorBase() instead. 
	; Here we use this method from good all PAH:
	ActorBase original_base = GetValidActorBase(original)
	Actor clone
	ActorBase clone_base

	int tries = 0
	While tries < 100
		if tries > 0
			LogTrace("CloneActor() try again n="+(tries+1))
		endif
		clone = DOMTonyMarker.PlaceActorAtMe(original_base, 4)
		If IsSimilarActorBase(original_base, clone.GetLeveledActorBase())
			return clone
		endif
		clone.GetLeveledActorBase().SetInvulnerable(false)
		clone.GetLeveledActorBase().SetEssential(false)
		clone.Kill()
		;clone.SetCriticalStage(4) ; use desintegrate end stage instead of Delete() to avoid problems with leveled lists!
		clone.Delete()
		tries += 1
	EndWhile
	LogTrace("CloneActor(): CLONING FAILED!")
	return None
EndFunction

Function prepareClone(Actor original, Actor clone)
	If clone.HasSpell(AbPOIFrozenCorpse)
		clone.RemoveSpell(AbPOIFrozenCorpse)
	endif
	If (Game.GetModByName("SlaveTats.esp") != 255)
		If JContainers.isInstalled() && SlaveTats.Version() != ""
			original.enableAI(false)
			int array = JArray.object()
			JValue.retain(array)
			If !SlaveTats.query_applied_tattoos(original, 0, array)
				int index = JArray.count(array)
				if index > 0
					LogTrace("SlaveTats: Add " + index + " tats")
					while index > 0
						index -= 1
						SlaveTats.add_tattoo(clone, JArray.getObj(array, index), silent = true)
					endWhile
					if CaptureSyncTattoos
						SlaveTats.synchronize_tattoos(clone, true)
					endif
				endif
				JValue.release(array)
			endif
		endif
	endif
EndFunction

Function ReCloneActor(Actor akTarget)
	LogTrace("INFO: ReCloneActor "+akTarget.GetDisplayName()+" no clone="+akTarget.IsInFaction(DOMNoCloneFaction)+" no clean="+akTarget.IsInFaction(DOMNoCleanFaction))
	;PrintAllFactions(akTarget)

	bool is_slave = true
	akTarget.SetDontMove(true)
	ReferenceAlias akAlias = None
	if akTarget.IsInFaction(DOMPlayerSlaveFaction) 
		akAlias = DOM02.GetActorAlias(akTarget)
	endif
	if akAlias == None
		akAlias = DOM01.GetActorAlias(akTarget)
		if akAlias == None
			return
		endif
		is_slave = false
		DOM01.ReleaseAlias(akAlias)
	else
		DOM02.ReleaseAlias(akAlias)
	endif
	Faction crime_faction = akTarget.GetCrimeFaction()
	RemoveFromFaction(akTarget,DOMActorAlreadyCleaned)
	DOMPAH.ResetAlreadyCleaned(akTarget)
	
	LogTrace("INFO: ReCloneActor try to clone "+akTarget)
	Actor clone = CloneAndCopyActor(akTarget)
	If clone == None
		LogInfo("ERROR: ReCloneActor Cloning failed for "+akTarget)
		return
	endif
	if clone != akTarget
		LogTrace("SUCCESS: ReCloneActor Clone will now replace target "+clone)
		clone.setAlpha(0.01)
		clone.MoveTo(akTarget)
		Wait(1.0) ; Wait for 3d loaded
		akTarget.setAlpha(0.01) ; 0 is completely transparent, 1 is completely visible.
		clone.setAlpha(1.0)
		akTarget.MoveTo(DOMTonyMarker) ;  or move the corpse to the dead body cleanup cell
		akTarget.SetDontMove(false)
		akTarget.GetLeveledActorBase().SetInvulnerable(false)
		akTarget.EndDeferredKill()
		akTarget.KillEssential(PlayerRef)
		akTarget.SetCriticalStage(4) ; 
	else
		LogInfo("ERROR: ReCloneActor Clone is identical to target "+akTarget)
	endif
	if !cleanCrimeFaction
		clone.SetCrimeFaction(crime_faction)
		clone.RemoveFromFaction(DOMNoCleanCrimeFaction)
	else
		clone.SetCrimeFaction(None)
		clone.setFactionRank(DOMNoCleanCrimeFaction,1)
	endif

	DOM_Actor akActor
	if is_slave
		akActor = DOM02.AddActor(clone,"",false)
	else
		akActor = DOM01.AddActor(clone,false)
	endif
	;LogTrace("INFO: ReCloneActor "+akTarget.GetDisplayName()+" print all factions")
	;PrintAllFactions(akTarget)
	akActor.EnterFollowPlayer()
	akActor.SendOrderEquipInventory(false) ; no anim
EndFunction

Form[] _saveFactions1

Function ReadSaveFactions()
	String fileName = "Diary Of Mine/SaveFactions.json"
	int n = JsonUtil.FormListCount(fileName,"FactionsToSaveWhenCloning")
	_saveFactions1 =  JsonUtil.FormListToArray(fileName, "FactionsToSaveWhenCloning")
	LogTrace("ReadSaveFactions: number of entries="+n+" array length="+_saveFactions1.length)
	if n != _saveFactions1.length
		LogInfo("WARNING: ReadSaveFactions array length is not equal to number of entries")
		n = _saveFactions1.length
	endif
	int i = 0
	while i < n
		Faction the_faction = _saveFactions1[i] as Faction
		;if the_faction != None
		;	LogTrace("ReadSaveFactions: recovered faction "+i+" "+the_faction.GetName()+" "+the_faction)
		;else
		;	LogInfo("WARNING: ReadSaveFactions failed to recover faction "+i)
		;endif
		i += 1
	endwhile
EndFunction

Function WriteSaveFactions()
	string fileName = "Diary Of Mine/SaveFactions.json"
	if JsonUtil.JsonExists(fileName)
		LogTrace("WriteSaveFactions: Skipping! File already exists: "+fileName)
		return
	endif
	LogTrace("WriteSaveFactions: File not found! Regenerating: "+fileName)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMRandomSeed,false)	; false = don't allow duplicates
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMActorGender,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHasPersonality,false)

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainSubmission,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainFear,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainHumiliation,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainAnger,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainResignation,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainRespect,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainCombat,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainPose,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainSex,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainAnal,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainOral,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainVaginal,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainHouse,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTrainWorking,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTraumaInDays,false)
	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMSkillEnforcer,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMSkillPredator,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMSkillDepraver,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMSkillPersuader,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMSkillSlaver,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMSkillDeceiver,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOM04.DOMPlaceOriginFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOM04.DOMJobOriginFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOM04.DOMEmployerOriginFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOM04.DOMTrainerOriginFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOM04.DOMClassOriginFaction,false)		
		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTraitHonesty,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTraitEmotionality,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTraitExtraversion,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTraitAgreeableness,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTraitConscientiousness,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTraitOpenness,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFacetBoldness,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFacetWilfulness,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFacetSmartness,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFacetSensuality,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFacetToughness,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFacetSubmissivity,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbBrainWashed,false)		; false = don't allow duplicates	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbBroken,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbComfort,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbFlatter,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbInsult,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbOrgasm,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbPain,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbBondage,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbPraise,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbPromise,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbRape,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbDrug,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbSex,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbSexForMoney,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbSexWithOthers,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbKinkTrigger,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbShame,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbShock,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbThreat,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbToldoff,false)	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbChatFeelings,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbChatPersonality,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbTrainee,false)	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbTrainer,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbRecruitedSlavers,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbRansomedSlaves,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbCapturedSlaves,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbSoldSlaves,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbBrokenSlaves,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbPlayerFling,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNbPlayerChat,false)		
		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMVirginVaginal,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMVirginOral,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMVirginAnal,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMVirginSame,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMVirginGangbang,false)		
	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMShouldBeRespectful,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMShouldWalkOnFour,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMShouldFightForPlayer,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMShouldBeNoOrgasm,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMShouldBeSilent,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMShouldBeNaked,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMShouldHoldWeapons,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMShouldWearArmor,false)		
	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNoCloneFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNoCleanFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMNoCleanCrimeFaction,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMEquip.DOMNoOutfitFaction,false)
	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFollowMode,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMWaitMode,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMTravelMode,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMWorkMode,false)
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMJailMode,false)
	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMActorFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPlayerSlaveFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPlayerSlaverFaction,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHistoryFaction,false)	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMActorFamilyHistory,false)	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMActorFamilyReunited,false)	
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMActorInTransfer,false)	

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMLoveDesire,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMLoyalWorship,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMLoveFascination,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMLoyalAbsolution,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMLoyalDevotion,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMLoveAdmiration,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFeelSubmission,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFeelFear,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFeelHumiliation,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFeelAnger,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFeelResignation,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMFeelRespect,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHiddenKink0,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHiddenKink1,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHiddenKink2,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHiddenKink3,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHiddenKink4,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHiddenKink5,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHiddenKink6,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMHiddenKink7,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMKnownKink0,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMKnownKink1,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMKnownKink2,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMKnownKink3,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMKnownKink4,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMKnownKink5,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMKnownKink6,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMKnownKink7,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPunishmentReason0,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPunishmentReason1,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPunishmentReason2,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPunishmentReason3,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPunishmentReason4,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPunishmentReason5,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPunishmentReason6,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPunishmentReason7,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPraiseReason0,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPraiseReason1,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPraiseReason2,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPraiseReason3,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPraiseReason4,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPraiseReason5,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPraiseReason6,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMPraiseReason7,false)		

	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlFeelingsDialogue1,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlFeelingsDialogue2,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlFeelingsDialogue3,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlFeelingsDialogue4,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlPersonalityDialogue1,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlPersonalityDialogue2,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlPersonalityDialogue3,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlPersonalityDialogue4,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlModifiersDialogue1,false)		
	JsonUtil.FormListAdd(fileName,"FactionsToSaveWhenCloning", DOMControlModifiersDialogue2,false)		
	
	DOMPAH.WriteSaveFaction(fileName)
	
	JsonUtil.Save(fileName)
EndFunction

Int [] Function SaveFactions1(Actor original)
	; -=TAK=- save faction ranks
	Int [] fact_save = new Int[128]
	
	int n =  _saveFactions1.length
	if n < 1
		LogInfo("ERROR: SaveFactions factions array is empty")
		return fact_save
	endif
	if n > 128
		n = 128
	endif
	;LogTrace("SaveFactions1: number of entries="+n+" (reading from 0 to 127)")
	int i = 0
	while i < n
		Faction the_faction = _saveFactions1[i] as Faction
		if the_faction == None
			;LogInfo("WARNING: SaveFactions failed to recover faction "+i+" "+the_faction)
			fact_save[i] = -999
		else
			fact_save[i] = GetFactionRankInt(original,the_faction)	
		endif
		i += 1
	endwhile
	return fact_save
EndFunction

Int [] Function SaveFactions2(Actor original)
	; -=TAK=- save faction ranks
	Int [] fact_save = new Int[128]
	
	int n =  _saveFactions1.length - 128
	if n < 1
		;LogInfo("ERROR: SaveFactions factions array is empty")
		return fact_save
	endif
	if n > 128
		n = 128
	endif
	;LogTrace("SaveFactions2: number of entries="+n+" (reading from 128 to 255)")
	int i = 0
	while i < n
		Faction the_faction = _saveFactions1[i+128] as Faction
		if the_faction == None
			;LogInfo("WARNING: SaveFactions failed to recover faction "+i+" "+the_faction)
			fact_save[i] = -999
		else
			fact_save[i] = GetFactionRankInt(original,the_faction)	
		endif
		i += 1
	endwhile
	return fact_save
EndFunction

Function RestoreFactions(Actor original, Int [] fact_save1, Int [] fact_save2)
	; -=TAK=- restore faction ranks
	
	int n =  _saveFactions1.length
	if n < 1
		LogInfo("ERROR: RestoreFactions factions array is empty")
		return
	endif
	if n > 256
		n = 256
	endif
	;LogTrace("RestoreFactions: number of entries="+_saveFactions1.length+" (max is 256)")
	int i = 0
	int nmax = n
	if nmax > 128
		nmax = 128
	endif
	while i < nmax
		Faction the_faction = _saveFactions1[i] as Faction
		if the_faction != None && fact_save1[i] != -999
			SetFactionRankInt(original,the_faction,fact_save1[i])
		;else
		;	LogInfo("WARNING: RestoreFactions failed to recover faction "+i+" "+the_faction)
		endif
		i += 1
	endwhile
	i = 0
	nmax = n - 128
	if nmax > 128
		nmax = 128
	endif
	while i < nmax
		Faction the_faction = _saveFactions1[i+128] as Faction
		if the_faction != None && fact_save2[i] != -999
			SetFactionRankInt(original,the_faction,fact_save2[i])
		;else
		;	LogInfo("WARNING: RestoreFactions failed to recover faction "+(i+128)+" "+the_faction)
		endif
		i += 1
	endwhile
EndFunction

Function RemoveFromEnemyFactions(Actor akRef)
	;LogTrace("RemoveFromEnemyFactions() name="+akRef.GetDisplayName())
	Faction[] lFactions = akRef.GetFactions(-128, 127); The maximum range allowed.
	
	if akRef.IsInFaction(WEPlayerEnemy)
		LogTrace("Removing faction "+i+" "+akRef.GetDisplayName()+" "+akRef.GetFactionRank(WEPlayerEnemy)+" "+WEPlayerEnemy.GetReaction(PlayerFaction)+" "+WEPlayerEnemy.getName()+" "+WEPlayerEnemy)
		akRef.RemoveFromFaction(WEPlayerEnemy)
	endif
	int n = lFactions.length
	int i = 0
	while i < n
		Faction the_faction = lFactions[i]
		if the_faction != None
			int rank = akRef.GetFactionRank(the_faction)
			bool is_enemy = IsEnemyFaction(the_faction)
			if is_enemy
				; 0 = Neutral 1 = Enemy 2 = Ally 3 = Friend
				LogTrace("Removing faction "+i+" "+akRef.GetDisplayName()+" "+rank+" enemy="+is_enemy+" "+the_faction.getName()+" "+the_faction)
				akRef.RemoveFromFaction(the_faction)
			;elseif akRef.GetFactionRank(the_faction) < 0 ; Some PAH factions can be set to -1
			;	LogTrace("Cleaning faction "+i+" "+akRef.GetDisplayName()+" "+rank+" enemy="+is_enemy+" "+the_faction.getName()+" "+the_faction)
			;	akRef.RemoveFromFaction(the_faction)
			;else
			;	LogTrace("Keeping faction  "+i+" "+akRef.GetDisplayName()+" "+rank+" enemy="+is_enemy+" "+the_faction.GetName()+" "+the_faction)			
			endif
		endif
		i += 1
	endWhile
EndFunction

bool Function CheckSameActorBase(Actor akTarget)
	ActorBase abTarget = akTarget.GetLeveledActorBase()
	if abTarget == None
		return false
	endif
	; slaves
	int i = DOM02.actorCounter-(1)
	While i >=0 ; New actors first
		DOM_Actor akActor = DOM02.actorArray[i]
		Actor akOther = akActor.akRef
		if akOther != None && akOther != akTarget
			ActorBase abOther = akOther.GetLeveledActorBase()
			if abOther == abTarget
				return true
			endif
		endif
		i -= 1
	EndWhile
	; slavers
	i = DOM01.actorCounter-(1)
	While i >=0 ; New actors first
		DOM_Actor akActor = DOM01.actorArray[i]
		Actor akOther = akActor.akRef
		if akOther != None && akOther != akTarget
			ActorBase abOther = akOther.GetLeveledActorBase()
			if abOther == abTarget
				return true
			endif
		endif
		i -= 1
	EndWhile
	return false
EndFunction

Function copySexStats(Actor target, Actor source)
	;LogTrace("copySexStats "+target.GetDisplayName())
	DOMSexlab.CopyStat(target, source, "TimeSpent")
	DOMSexlab.CopyStat(target, source, "Sexuality")
	DOMSexlab.CopyStat(target, source, "Foreplay")
	DOMSexlab.CopyStat(target, source, "Males")
	DOMSexlab.CopyStat(target, source, "Females")
	DOMSexlab.CopyStat(target, source, "Creatures")
	DOMSexlab.CopyStat(target, source, "Masturbation")
	DOMSexlab.CopyStat(target, source, "Aggressor")
	DOMSexlab.CopyStat(target, source, "Victim")
	DOMSexlab.CopyStat(target, source, "Pure")
	DOMSexlab.CopyStat(target, source, "Lewd")
	DOMSexlab.CopyStat(target, source, "Vaginal")
	DOMSexlab.CopyStat(target, source, "Anal")
	DOMSexlab.CopyStat(target, source, "Oral")
EndFunction

Function copyFactions(Actor original, Actor clone)
	;LogTrace("copyFactions() START name="+original.GetDisplayName()+" clone="+clone.GetDisplayName())
	Faction[] lFactions = original.GetFactions(-128, 127); The maximum range allowed.
	
	;LogTrace("copyFactions() name="+clone.GetDisplayName()+" factions="+lFactions)
	int n = lFactions.length
	int i = 0
	while i < n
		Faction the_faction = lFactions[i]
		if the_faction != None && !IsEnemyFaction(the_faction)
			int rank = GetFactionRankInt(original,the_faction)
			clone.SetFactionRank(the_faction,rank)
			LogTrace("Copying faction "+i+" "+clone.GetDisplayName()+" rank="+rank+" "+the_faction.getName()+" "+the_faction)
		endif
		i += 1
	endWhile
	Faction crime_faction = original.GetCrimeFaction()
	if crime_faction != None  && !IsEnemyFaction(crime_faction)
		clone.SetCrimeFaction(crime_faction)
		LogTrace("Copying crime faction "+clone.GetDisplayName()+" "+crime_faction.getName()+" "+crime_faction)
	endif
	;LogTrace("copyFactions() DONE name="+clone.GetDisplayName())
EndFunction

bool Function IsEnemyFaction(Faction the_faction)
	if the_faction.GetReaction(PlayerFaction) == 1
		return true
	endif
	if the_faction.GetReaction(DOMGenerator.CrimeFactionWhiterun) == 1
		return true
	endif
	return false
;/	if the_faction == BanditFaction
		return true
	endif
	if the_faction == ForswornFaction	
		return true
	endif
	if the_faction == HagravenFaction	
		return true
	endif
	if the_faction == NecromancerFaction	
		return true
	endif
	if the_faction == WarlockFaction	
		return true
	endif
	if the_faction == VampireFaction	
		return true
	endif
	if the_faction == HydraSlaveFaction	; HydraSlaveFaction faction
		return true
	endif
	if the_faction == VanillaBanditsSlaveFaction	; Bandit SexSlaves faction
		return true
	endif
	if the_faction == TravellingWenchesFaction	; travelling wenches faction
		return true
	endif
	if the_faction == TravellingWenchesServantFaction	; travelling servant faction
		return true
	endif
	if the_faction == TravellingWenchesPatrolFaction	; Wench patrol faction
		return true
	endif
	if the_faction == TravellingWenchesJudgementFaction	; Wench judgement faction
		return true
	endif
	if the_faction == TravellingWenchesCollectedFaction	; Wench judgement collected faction
		return true
	endif
	return false
	/;
EndFunction

Function CleanFactions(Actor akRef)
	LogTrace("CleanFactions start for "+akRef.GetDisplayName())
	;PrintAllFactions(akRef)
	if akRef.IsInFaction(DOMBeingCaptured) ; remove future slaves from bard audience
		akRef.SetFactionRank(BardAudienceExcludedFaction,1)
	endif
	
	If OBISFaction != None && akRef.IsInFaction(OBISFaction)
		RemoveFromFaction(akRef,OBISFaction)
	endif
	If ObisGlowingPearl != None
		akRef.AddItem(ObisGlowingPearl, 1)
	endif

	RemoveFromEnemyFactions(akRef)

	; Remove extras
	RemoveFromFaction(akRef,DOMGenerator.IsGuardFaction)	     ; guards reaction
	RemoveFromFaction(akRef,DOMGenerator.GuardDialogueFaction) ; guards dialogue
	; RemoveFromFaction in DOM_Utils checks for faction != None
	;RemoveFromFaction(akRef,BanditFaction)	
	;RemoveFromFaction(akRef,ForswornFaction)	
	;RemoveFromFaction(akRef,HagravenFaction)	
	;RemoveFromFaction(akRef,NecromancerFaction)	
	;RemoveFromFaction(akRef,WarlockFaction)	
	;RemoveFromFaction(akRef,VampireFaction)	
	RemoveFromFaction(akRef,HydraSlaveFaction)	; HydraSlaveFaction faction
	RemoveFromFaction(akRef,VanillaBanditsSlaveFaction)	; Bandit SexSlaves faction
	;	RemoveFromFaction(kRef,VanillaBanditsExSlaveFaction)	; Bandit Ex SexSlaves faction
	RemoveFromFaction(akRef,TravellingWenchesFaction)	; travelling wenches faction
	RemoveFromFaction(akRef,TravellingWenchesServantFaction)	; travelling servant faction
	RemoveFromFaction(akRef,TravellingWenchesPatrolFaction)	; Wench patrol faction
	RemoveFromFaction(akRef,TravellingWenchesJudgementFaction)	; Wench judgement faction
	RemoveFromFaction(akRef,TravellingWenchesCollectedFaction)	; Wench judgement collected faction
EndFunction

Function SetMoodFaction(Actor akRef, string mood)
	if mood == "just_captured" 
		akRef.SetFactionRank(DOMMoodJustCaptured,1)
	elseif mood == "angry"
		akRef.SetFactionRank(DOMMoodAngry,1)
	elseif mood == "defiant"
		akRef.SetFactionRank(DOMMoodAngry,2)
	elseif mood == "jealous"
		akRef.SetFactionRank(DOMMoodInlove,3)
		akRef.SetFactionRank(DOMMoodAngry,3)
	elseif mood == "afraid"
		akRef.SetFactionRank(DOMMoodAfraid,1)
	elseif mood == "terrified"
		akRef.SetFactionRank(DOMMoodAfraid,2)
	elseif mood == "scared"
		akRef.SetFactionRank(DOMMoodAfraid,3)
	elseif mood == "ashamed"
		akRef.SetFactionRank(DOMMoodAshamed,1)
	elseif mood == "proud"
		akRef.SetFactionRank(DOMMoodAshamed,2)
	elseif mood == "insecure"
		akRef.SetFactionRank(DOMMoodInlove,4)
		akRef.SetFactionRank(DOMMoodAshamed,3)
	elseif mood == "sad"
		akRef.SetFactionRank(DOMMoodSad,1)
	elseif mood == "depressed"
		akRef.SetFactionRank(DOMMoodInlove,2)
		akRef.SetFactionRank(DOMMoodSad,2)
	elseif mood == "shock"
		akRef.SetFactionRank(DOMMoodShock,1)
	elseif mood == "broken"
		akRef.SetFactionRank(DOMMoodBroken,1)
	elseif mood == "loyal"
		akRef.SetFactionRank(DOMMoodLoyal,1)
	elseif mood == "inlove"
		akRef.SetFactionRank(DOMMoodInlove,1)
	elseif mood == "fine"
		akRef.SetFactionRank(DOMMoodHappy,1)
	elseif mood == "happy"
		akRef.SetFactionRank(DOMMoodHappy,2)
	elseif mood == "charmed"
		akRef.SetFactionRank(DOMMoodInlove,0)
		akRef.SetFactionRank(DOMMoodHappy,3)
	else
		akRef.SetFactionRank(DOMMoodNeutral,1)
	endif
EndFunction

Function MoveActorToDOMx(Actor akTarget, int pool_index)
	if pool_index < 0 || pool_index > DOMExtraMng.length
		return
	endif
	if akTarget == None
		return
	endif
	int rank = akTarget.GetFactionRank(DOMSlaveManagerFaction)
	DOM_SlaveManager cur_mng
	if rank <= 0
		cur_mng = DOM02
	elseif rank >= 100 ; Managers above 100 are from HSH
		LogTrace("MoveActorToDOMx(): Alias is from HSH IGNORE! "+akTarget.GetDisplayName())
		return
	else
		rank -= 1
		cur_mng = DOMExtraMng[rank]
	endif
	if cur_mng == None
		return
	endif
	DOM_SlaveManager new_mng
	if pool_index <= 0
		new_mng = DOM02
	else
		pool_index -= 1
		new_mng = DOMExtraMng[pool_index]
	endif
	if new_mng == None
		return
	endif
	cur_mng.ReleaseActor(akTarget)
	new_mng.AddActor(akTarget,"",false) ; add with newActor=false
EndFunction

Function MoveActorToPAH(Actor akActor)
	if akActor == None
		return
	endif
	LogTrace("MoveToPAH "+akActor.GetDisplayName())
	if !DOMPAH.isPAH(akActor)
		DOMPAH.MoveActorToPAH(GetActor(akActor))
	endif
EndFunction

Function MoveActorToDOM(Actor akActor)
	if akActor == None
		return
	endif
	if DOMPAH.isPAH(akActor)
		DOMPAH.MoveActorToDOM(DOMPAH.PAH.GetSlave(akActor))
	else 
		MoveNPCToDOM(akActor)
	endif
EndFunction

DOM_Actor Function MoveNPCToDOM(Actor akActor)
	if akActor == None
		return None
	endif
	
	HudNotification("Transfering "+akActor.GetDisplayName()+" to DOM")
	string behaviour
	if akActor.IsInFaction(DOMActionTied) || DOMPAH.isTied(akActor)
		behaviour = "tied"
	else
		behaviour = "follow_player"
	endif
	bool is_naked = false

	LogTrace("Adding actor to DOM "+akActor.GetDisplayName()+" behaviour="+behaviour+" naked="+is_naked)
		
	DOM_Actor slave = DOM02.AddActor(akActor,"",false)
	if is_naked
		slave.mind.should_be_naked = true
	else
		slave.mind.should_be_naked = false
	endif
	if behaviour == "follow_player"
		slave.EnterFollowPlayer()
	elseif behaviour == "wait_sandbox"
		slave.EnterWaitSandbox()
	elseif behaviour == "wait_at_leash_point"
		slave.WaitAtLeashPoint()
	elseif behaviour == "tied"
		slave.EnterTieUp(None)
	else
		slave.EnterWait()
	endif
	return slave
EndFunction

Function CommandDoCombat(Actor akRef)
	DOM_Actor akActor = GetActor(akRef)
	akActor.mind.should_fight_for_player = true
EndFunction

Function CommandNoLongerDoCombat(Actor akRef)
	DOM_Actor akActor = GetActor(akRef)
	akActor.mind.should_fight_for_player = false
EndFunction

String Function VictimState(Actor Target)
	; return the state the target is currently in as a string.
	If Target.IsDead()
		return "Dead"
	elseif DOMSexlab.IsActorActive(Target)
		return "Sex"
	elseif Target.IsBleedingOut()
		return "Bleedout"
	elseif (Target.GetSleepState() == 3)
		return "Sleeping"
	elseif Target.IsInCombat()
		return "Fighting"		
	endif
	return ""
EndFunction

bool Function isVampire(Actor akTarget)
	if akTarget == None
		return false
	endif
	Actorbase abTarget = akTarget.GetLeveledActorBase()
	if abTarget == None
		return false
	endif
	Race ActorRace  = abTarget.GetRace()
	if ActorRace == None
		return false
	endif
	if ActorRace.HasKeyword(Vampire)
		return true
	endif
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	if stringUtil.find(raceString,"Vampire") >= 0
		return true
	endif
	return false
EndFunction

; RaceMenu version used by transferNode code below
Int Property NIOVERRIDE_VERSION = 6 AutoReadOnly
Int Property NIOVERRIDE_SCRIPT_VERSION = 6 AutoReadOnly

bool Function CheckNiOverride()
	return SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

bool Function transferNode(Actor source, Actor target)
	if !setTransferNodeToggle
		LogTrace("WILL NOT transferNode from "+source.GetDisplayName()+" to "+target.GetDisplayName())
		return false
	endif
	LogTrace("transferNode from "+source.GetDisplayName()+" to "+target.GetDisplayName())

    ;CBBE SECTION WEE WOO WEE WOO THIS IS CBBE ONLY STUFF RIGHT HERE
    ;Instantiate the array
    
    ;list of morphs obtained from RaceMenuMorphsCBBE.psc
    String[] morphs =  new String[128]
    morphs[0] = "Innieoutie"
    morphs[1] = "LabiaNeat_v2"
    morphs[2] = "LabiaTightUp"
    morphs[3] = "Labiapuffyness"
    morphs[4] = "LabiaMorePuffyness_v2"
    morphs[5] = "Labiaprotrude"
    morphs[6] = "Labiaprotrude2"
    morphs[7] = "Labiaprotrudeback"
    morphs[8] = "Labiaspread"
    morphs[9] = "LabiaCrumpled_v2"
    morphs[10] = "LabiaBulgogi_v2"
    morphs[11] = "Vaginasize"
    morphs[12] = "VaginaHole"
    morphs[13] = "Clit"
    morphs[14] = "ClitSwell_v2"
    morphs[15] = "Cutepuffyness"
    morphs[16] = "CBPC"
    morphs[17] = "CrotchGap"
    morphs[18] = "AnalLoose_v2"
    morphs[19] = "AnalPosition_v2"
    morphs[20] = "AnalTexPos_v2"
    morphs[21] = "AnalTexPosRe_v2"
    morphs[22]  = "7B Lower"
    morphs[23]  = "7B Upper"
    morphs[24]  = "VanillaSSEHi"
    morphs[25]  = "VanillaSSELo"
    morphs[26]  = "OldBaseShape"
    morphs[27]  = "Breasts"
    morphs[28]  = "BreastsSmall"
    morphs[29]  = "BreastsSmall2"
    morphs[30]  = "DoubleMelon"
    morphs[31]  = "BreastCleavage"
    morphs[32] = "BreastsTogether"
    morphs[33] = "BreastsConverage_v2"
    morphs[34] = "PushUp"
    morphs[35] = "BreastGravity2"
    morphs[36] = "BreastHeight"
    morphs[37] = "BreastPerkiness"
    morphs[38] = "BreastWidth"
    morphs[39] = "BreastTopSlope"
    morphs[40] = "BreastCenter"
    morphs[41] = "BreastCenterBig"
    morphs[42] = "BreastFlatness"
    morphs[43] = "BreastFlatness2"
    morphs[44] = "BreastsFantasy"
    morphs[45] = "BreastsNewSH"
    morphs[46] = "BreastsNewSHSymmetry"
    morphs[47] = "BreastsGone"
    morphs[48] = "BreastSideShape"
    morphs[49] = "BreastUnderDepth"
    morphs[50] = "BreastsPressed_v2"
    morphs[51] = "NippleSize"
    morphs[52] = "AreolaSize"
    morphs[53] = "AreolaPull_v2"
    morphs[54] = "NippleLength"
    morphs[55] = "NippleSquash1_v2"
    morphs[56] = "NippleSquash2_v2"
    morphs[57] = "NippleManga"
    morphs[58] = "NipplePerkiness"
    morphs[59] = "NipplePerkManga"
    morphs[60] = "NipplePuffy_v2"
    morphs[61] = "NippleShy_v2"
    morphs[62] = "NippleDistance"
    morphs[63] = "NippleTip"
    morphs[64] = "NippleTipManga"
    morphs[65] = "NippleThicc_v2"
    morphs[66] = "NippleTube_v2"
    morphs[67] = "NippleDown"
    morphs[68] = "NippleUp"
    morphs[69] = "NippleDip"
    morphs[70] = "NippleCrease_v2"
    morphs[71] = "NippleCrumpled_v2"
    morphs[72] = "NippleBump_v2"
    morphs[73] = "NipBGone"
    morphs[74] = "NippleInvert_v2"
    morphs[75] = "Clavicle_v2"
    morphs[76] = "BigTorso"
    morphs[77] = "ChestDepth"
    morphs[78] = "ChestWidth"
    morphs[79] = "SternumDepth"
    morphs[80] = "SternumHeight"
    morphs[81] = "RibsProminance"
    morphs[82] = "RibsMore_v2"
    morphs[83] = "NavelEven"
    morphs[84] = "Waist"
    morphs[85] = "WaistHeight"
    morphs[86] = "WideWaistLine"
    morphs[87] = "ChubbyWaist"
    morphs[88] = "Back"
    morphs[89] = "BackArch"
    morphs[90] = "BackValley_v2"
    morphs[91] = "BackWing_v2"
    morphs[92] = "Butt"
    morphs[93] = "BigButt"
    morphs[94] = "ButtSmall"
    morphs[95] = "ChubbyButt"
    morphs[96] = "AppleCheeks"
    morphs[97] = "ButtDimples"
    morphs[98] = "ButtUnderFold"
    morphs[99] = "RoundAss"
    morphs[100] = "ButtSaggy_v2"
    morphs[101] = "ButtPressed_v2"
    morphs[102] = "ButtNarrow_v2"
    morphs[103] = "ButtClassic"
    morphs[104] = "ButtShape2"
    morphs[105] = "ButtCrack"
    morphs[106] = "Groin"
    morphs[107] = "CrotchBack"
    morphs[108] = "7BLeg_v2"
    morphs[109] = "Thighs"
    morphs[110] = "ThighOutsideThicc_v2"
    morphs[111] = "ThighInsideThicc_v2"
    morphs[112] = "ThighFBThicc_v2"
    morphs[113] = "SlimThighs"
    morphs[114] = "LegsThin"
    morphs[115] = "ChubbyLegs"
    morphs[116] = "LegShapeClassic"
    morphs[117] = "LegSpread_v2"
    morphs[118] = "KneeHeight"
    morphs[119] = "KneeShape"
    morphs[120] = "KneeTogether_v2"
    morphs[121] = "CalfSize"
    morphs[122] = "CalfSmooth"
    morphs[123] = "CalfFBThicc_v2"
    morphs[124] = "FeetFeminine"
    morphs[125] = "AnkleSize"
    morphs[126] = "MuscleAbs"
    morphs[127] = "MuscleMoreAbs_v2"
    
    String[] morphs2    = new String[31]
    morphs2[0] = "MuscleArms"
    morphs2[1] = "MuscleMoreArms_v2"
    morphs2[2] = "MuscleButt"
    morphs2[3] = "MuscleLegs"
    morphs2[4] = "MuscleMoreLegs_v2"
    morphs2[5] = "MusclePecs"
    morphs2[6] = "MuscleBack_v2"
    morphs2[7] = "Hips"
    morphs2[8] = "HipBone"
    morphs2[9] = "HipUpperWidth"
    morphs2[10] = "HipCarved"
    morphs2[11] = "HipForward"
    morphs2[12] = "HipNarrow_v2"
    morphs2[13] = "UNPHip_v2"
    morphs2[14] = "Arms"
    morphs2[15] = "ChubbyArms"
    morphs2[16] = "ForearmSize"
    morphs2[17] = "ArmpitShape_v2"
    morphs2[18] = "WristSize"
    morphs2[19] = "ShoulderWidth"
    morphs2[20] = "ShoulderSmooth"
    morphs2[21] = "ShoulderTweak"
    morphs2[22] = "Belly"
    morphs2[23] = "BigBelly"
    morphs2[24] = "BellyFrontUpFat_v2"
    morphs2[25] = "BellyFrontDownFat_v2"
    morphs2[26] = "BellySideUpFat_v2"
    morphs2[27] = "BellySideDownFat_v2"
    morphs2[28] = "BellyUnder_v2"
    morphs2[29] = "TummyTuck"
    morphs2[30] = "PregnancyBelly"
        
    ;sure is a fat array, eh? That's the price of progress. 
        
    nioverride.ClearBodyMorphKeys(target as objectreference, "RSMBodyGen")
        
        
    Int iElement = morphs.length
    
    ;For each element in the morphs array, get the morph magnitude and transformation scale from the source actor, (if it has one), and place it on the target actor.
    while iElement
        
        iElement -= 1
        
        Float mag = nioverride.GetBodyMorph(source as objectreference, morphs[iElement], "RSMBodyGen")
        Float transformag = nioverride.GetNodeTransformScale(source as objectreference, false, true, morphs[iElement], "RSMBodyGen")
        
        nioverride.SetBodyMorph(target as objectreference, morphs[iElement], "RSMBodyGen", mag)
        
        nioverride.AddNodeTransformScale(target as objectreference, false, true, "morphs[iElement]", "RSMBodyGen", transformag)
        nioverride.UpdateNodeTransform(target as objectreference, false, true, morphs[iElement])
    endWhile
    
    Int iElement2 = morphs2.length
    
    ;For each element in the morphs array, get the morph magnitude and transformation scale from the source actor, (if it has one), and place it on the target actor.
    while iElement2
        
        iElement2 -= 1
        
        Float mag = nioverride.GetBodyMorph(source as objectreference, morphs2[iElement2], "RSMBodyGen")
        float transformag = nioverride.GetNodeTransformScale(source as objectreference, false, true, morphs2[iElement2], "RSMBodyGen")
        
        nioverride.SetBodyMorph(target as objectreference, morphs2[iElement2], "RSMBodyGen", mag)
        
        nioverride.AddNodeTransformScale(target as objectreference, false, true, "morphs2[iElement2]", "RSMBodyGen", transformag)
        nioverride.UpdateNodeTransform(target as objectreference, false, true, morphs2[iElement2])
    endWhile
    return true
EndFunction

Function PrintAllFactions(Actor _a)
	Faction[] lFactions = _a.GetFactions(-128, 127); The maximum range allowed.
	int n = lFactions.length
	Logtrace("PrintAllFactions() Print "+n+" factions for "+_a.GetDisplayName())
	Faction cFaction = _a.GetCrimeFaction()
	if cFaction == None
		Logtrace("PrintAllFactions() Crime Faction "+_a.GetDisplayName()+" = None")
	else
		Logtrace("PrintAllFactions() Crime Faction "+_a.GetDisplayName()+" rank="+_a.GetFactionRank(cFaction)+" reaction="+cFaction.GetReaction(PlayerFaction)+" "+cFaction.GetName()+" "+cFaction)
	endif
	int i = 0
	while i < n
		Faction the_faction = lFactions[i]
		if the_faction !=None
			; 0 = Neutral 1 = Enemy 2 = Ally 3 = Friend
			Logtrace("PrintAllFactions() Faction "+i+" "+_a.GetDisplayName()+" rank="+_a.GetFactionRank(the_faction)+" reaction="+the_faction.GetReaction(PlayerFaction)+" "+the_faction.GetName()+" "+the_faction)
		endif
		i += 1
	endWhile
EndFunction

int Function GetWeatherType(Actor akRef)
	if akRef.IsInInterior()
		return -2
	endif
	;		if wClass == 3     ; weather class: snow
	;		elseif wClass == 2 ; weather class: rain
	;		elseif wClass == 1 ; weather class: cloudy
	;		elseif wClass == 0 ; weather class: pleasant
	;		else               ; no current weather
	Weather currentWeather = Weather.GetCurrentWeather()
	if currentWeather != None
		int wClass = currentWeather.GetClassification() 
		return wClass
	endif
	return -1
EndFunction

; ### Join for sex

GlobalVariable Property DOM_SlaverLoadSlave Auto 
GlobalVariable Property DOM_SexlabLoadSlave Auto 
DOM_Actor _actor_to_join = None
DOM_Actor _actor1_to_join_sexlab = None
DOM_Actor _actor2_to_join_sexlab = None
DOM_Actor _actor3_to_join_sexlab = None

Function SetActorToJoin(DOM_Actor Slaver)
	if _actor_to_join != None
		_actor_to_join.ListTraineeNames()
		RemoveFromFaction(_actor_to_join.akRef,DOMSlaverLoadSlave)
	endif
	_actor_to_join = Slaver
	Slaver.akRef.SetFactionRank(DOMSlaverLoadSlave,1)
	DOM_SlaverLoadSlave.SetValue(1)
EndFunction

DOM_Actor Function GetActorToJoin()
	return _actor_to_join
EndFunction

Function ResetActorToJoin(Actor akRef)
	DOM_Actor akActor = GetActor(akRef)
	if akActor == None
		return
	endif
	ResetDOMActorToJoin(akActor)
EndFunction

Function ResetDOMActorToJoin(DOM_Actor akActor)
	if akActor != _actor_to_join
		return
	endif
	if _actor_to_join != None && _actor_to_join.akRef != None
		if !_actor_to_join.akRef.IsDead()
			_actor_to_join.ListTraineeNames()
		endif
		RemoveFromFaction(_actor_to_join.akRef,DOMSlaverLoadSlave)
	endif
	_actor_to_join = None
	if akActor != None && akActor.akRef != None
		RemoveFromFaction(akActor.akRef,DOMSlaverLoadSlave)
	endif
	DOM_SlaverLoadSlave.SetValue(0)
EndFunction

; type 
; 1: gentle sex 2 DOMActors
; 2: rape 2 DOMActors
; 3: 3some 2 DOMActors + player
; 4: 4some 3 DOMActors + player
; 5: 3some 3 DOMActors
; 6: 3some 1 DOMActor + 1 NPC + player  - Not implemented
; 7: 3some 1 DOMActor + 2 NPCs          - Not implemented
; 8: 4some 4 DOMActors                  - Not implemented
; 9: 4some 2 DOMActors + 1 NPC + player - Not implemented
; 24: load 4some
Function SetActor1ToJoinSexlab(DOM_Actor akActor, int type)
	if _actor1_to_join_sexlab != None
		RemoveFromFaction(_actor1_to_join_sexlab.akRef,DOMSexlabLoadSlave)
	endif
	_actor1_to_join_sexlab = akActor
	akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,type)
	DOM_SexlabLoadSlave.SetValue(type) 
EndFunction

Function SetActor2ToJoinSexlab(DOM_Actor akActor, int type)
	if akActor == _actor1_to_join_sexlab
		return
	endif
	if _actor2_to_join_sexlab != None
		RemoveFromFaction(_actor2_to_join_sexlab.akRef,DOMSexlabLoadSlave)
	endif
	_actor2_to_join_sexlab = akActor
	akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,type)
	DOM_SexlabLoadSlave.SetValue(type)
	if _actor1_to_join_sexlab != None ; correct first actor faction rank
		_actor1_to_join_sexlab.akRef.SetFactionRank(DOMSexlabLoadSlave,type)
	endif
EndFunction

Function SetActor3ToJoinSexlab(DOM_Actor akActor, int type)
	if akActor == _actor1_to_join_sexlab
		return
	endif
	if akActor == _actor2_to_join_sexlab
		return
	endif
	if _actor3_to_join_sexlab != None
		RemoveFromFaction(_actor3_to_join_sexlab.akRef,DOMSexlabLoadSlave)
	endif
	_actor3_to_join_sexlab = akActor
	akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,type)
	DOM_SexlabLoadSlave.SetValue(type)
	if _actor1_to_join_sexlab != None ; correct first actor faction rank
		_actor1_to_join_sexlab.akRef.SetFactionRank(DOMSexlabLoadSlave,type)
	endif
	if _actor2_to_join_sexlab != None ; correct second actor faction rank
		_actor2_to_join_sexlab.akRef.SetFactionRank(DOMSexlabLoadSlave,type)
	endif
EndFunction

DOM_Actor Function GetActor1ToJoinSexlab()
	return _actor1_to_join_sexlab
EndFunction

DOM_Actor Function GetActor2ToJoinSexlab()
	return _actor2_to_join_sexlab
EndFunction

DOM_Actor Function GetActor3ToJoinSexlab()
	return _actor3_to_join_sexlab
EndFunction

Function ResetDOMActor1ToJoinSexlab(DOM_Actor akActor)
	if akActor != _actor1_to_join_sexlab
		return
	endif
	if _actor1_to_join_sexlab != None && _actor1_to_join_sexlab.akRef != None
		RemoveFromFaction(_actor1_to_join_sexlab.akRef,DOMSexlabLoadSlave)
	endif
	_actor1_to_join_sexlab = None
	if akActor != None && akActor.akRef != None
		RemoveFromFaction(akActor.akRef,DOMSexlabLoadSlave)
	endif
	DOM_SexlabLoadSlave.SetValue(0)
EndFunction

Function ResetDOMActor2ToJoinSexlab(DOM_Actor akActor)
	if akActor != _actor2_to_join_sexlab
		return
	endif
	if _actor2_to_join_sexlab != None && _actor2_to_join_sexlab.akRef != None
		RemoveFromFaction(_actor2_to_join_sexlab.akRef,DOMSexlabLoadSlave)
	endif
	_actor2_to_join_sexlab = None
	if akActor != None && akActor.akRef != None
		RemoveFromFaction(akActor.akRef,DOMSexlabLoadSlave)
	endif
EndFunction

Function ResetDOMActor3ToJoinSexlab(DOM_Actor akActor)
	if akActor != _actor3_to_join_sexlab
		return
	endif
	if _actor3_to_join_sexlab != None && _actor3_to_join_sexlab.akRef != None
		RemoveFromFaction(_actor3_to_join_sexlab.akRef,DOMSexlabLoadSlave)
	endif
	_actor3_to_join_sexlab = None
	if akActor != None && akActor.akRef != None
		RemoveFromFaction(akActor.akRef,DOMSexlabLoadSlave)
	endif
EndFunction

Function DoActorToJoinSexlab(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor akActor = GetActor1ToJoinSexlab()
	if akActor == None
		return
	endif
	bool aggro
	bool threesome
	int iaccept = DOMGenerator.IsWillingToHaveSexWith(akTarget,akActor)
	if iaccept >= 1
		if akActor.akRef.GetFactionRank(DOMSexlabLoadSlave) == 6 ; 4some no player
			akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,15) ; in scene
			DOM_SexlabLoadSlave.SetValue(15)
			aggro = true
			threesome = true
		elseif akActor.akRef.GetFactionRank(DOMSexlabLoadSlave) == 5 ; threesome no player
			akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,15) ; in scene
			DOM_SexlabLoadSlave.SetValue(15)
			aggro = true
			threesome = true
		elseif akActor.akRef.GetFactionRank(DOMSexlabLoadSlave) == 4 ; foursome
			akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,14) ; in scene
			DOM_SexlabLoadSlave.SetValue(14)
			aggro = true
			threesome = true
		elseif akActor.akRef.GetFactionRank(DOMSexlabLoadSlave) == 3 ; threesome
			akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,13) ; in scene
			DOM_SexlabLoadSlave.SetValue(13)
			aggro = true
			threesome = true
		elseif akActor.akRef.GetFactionRank(DOMSexlabLoadSlave) == 2 ; aggressive
			akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,12) ; in scene
			DOM_SexlabLoadSlave.SetValue(12)
			aggro = true
			threesome = false
		elseif akActor.akRef.GetFactionRank(DOMSexlabLoadSlave) == 1 ; not aggressive
			akActor.akRef.SetFactionRank(DOMSexlabLoadSlave,11) ; in scene
			DOM_SexlabLoadSlave.SetValue(11)
			aggro = false
			threesome = false
		endif
		if threesome
			if iaccept >= 2
				akActor.StartSexWith3ANP(akTarget, "", true)
			else
				akActor.StartSexWith3ANP(akTarget, "", false)
			endif
		elseif iaccept >= 2
			akActor.StartSexWithNPC(akTarget, "", true)
		elseif aggro
			akActor.StartSexWithNPC(akTarget, "Missionary", true)
		else
			akActor.StartSexWithNPC(akTarget, "", false)
		endif
	endif
EndFunction

; ### Victim

; Ensure only one victim is registered at a time
DOM_Actor currentVictim = None
DOM_Actor currentVictimRival = None
DOM_Actor[] currentVictimFriends
Function SetAsVictim(DOM_Actor akActor, int type)
	; type: 1=pain, 2=sexual abuse, 3=verbal abuse, 4=manipulation (being nice)
	bool same_victim = false
	if currentVictim != None
		if currentVictim != akActor
			same_victim = false
		else
			same_victim = true
		endif
	endif
	currentVictim = akActor
	if familyToggle && !checking_for_family && !waiting_for_family
		if fSlave.GetActorRef() == akActor.akRef
			if nbNearbyFamily <= 1
				Actor akFriend = fFamily.GetActorRef()
				if akFriend != None
					NPCStartForceGreet(akFriend,currentVictim.akRef)
				endif
			else
				int j = RandomInt(0,nbNearbyFamily-(1))
				Actor akFriend = nearby_family[j]
				if akFriend != None
					NPCStartForceGreet(akFriend,currentVictim.akRef)
				endif
			endif
		elseif !same_victim && fSlave.GetActorRef() == None
			CheckForFamilyAround() ; Check for family unless is same victim or family check is already busy
		endif
	endif
	LogTrace("SetAsVictim is_player_actor="+akActor.mind.is_player_actor)
	if akActor.mind.is_player_actor
		if !friendPlayerToggle
			return
		endif
	elseif !friendToggle
		return
	endif
	Actor akRef = akActor.akRef
	akRef.SetFactionRank(DOMActorIsVictim,type)
	DOMPlayerAlias.playerCombatTarget.ForceRefTo(akRef)
	int n = akActor.friendArray.length
	if !currentVictimFriends || currentVictimFriends.length < n
		currentVictimFriends = new DOM_Actor[16]
		if n > currentVictimFriends.length
			LogInfo("ERROR expected friend array size of 4 got "+n)
		endif
	endif
	int i = 0
	While i < n
		DOM_Actor afriend = akActor.friendArray[i]
		currentVictimFriends[i] = afriend
		if afriend != None && !afriend.is_trainer
			Actor akOther = afriend.akRef
			if akOther!=None
				; set faction with rank type
				akOther.SetFactionRank(DOMActorFriendIsVictim,type)
			endif
		endif
		i += 1
	EndWhile
	currentVictimRival = akActor.meRival
	if currentVictimRival != None
		currentVictimRival.akRef.SetFactionRank(DOMActorRivalIsVictim,type)
	endif
EndFunction

Function UnsetAsVictim(DOM_Actor akActor)
	if currentVictim == None
		return
	endif
	if akActor != currentVictim
		return
	endif
	Actor akRef = currentVictim.akRef
	RemoveFromFaction(akRef,DOMActorIsVictim)
	DOMPlayerAlias.playerCombatTarget.clear()
	int i = 0
	While i < currentVictimFriends.length
		DOM_Actor afriend = currentVictimFriends[i]
		if afriend != None 
			; unset faction
			Actor akOther = afriend.akRef
			if akOther!=None
				; set faction with rank type
				RemoveFromFaction(akOther,DOMActorFriendIsVictim)
			endif
		endif
		currentVictimFriends[i] = None
		i += 1
	EndWhile
	if currentVictimRival != None
		RemoveFromFaction(currentVictimRival.akRef,DOMActorRivalIsVictim)
	endif
	currentVictimRival = None
	currentVictim = None
EndFunction

DOM_Actor Function AddSlave(Actor akRef)
	return DOM02.AddActor(akRef, "", false) ; assume this is for already enslaved actor
EndFunction

DOM_Actor Function AddSlaver(Actor akRef)
	return DOM01.AddActor(akRef, false) ; assume this is for already processed actor
EndFunction

; Reset pose markers for all actors
Function ResetPoseMarkers()
	LogTrace("ResetPoseMarkers")
	int n = DOM02.actorCounter
	int i = 0
	While (i < n)
		DOM_Actor akActor = DOM02.actorArray[i]
		if akActor != None
			if akActor.PoseMarker != None
				akActor.PoseMarker.Delete()
				akActor.PoseMarker = None
			endif
			akActor.SetMarkerAtPosition()
		endif
		i += 1
	EndWhile
	n = DOM01.actorCounter
	i = 0
	While (i < n)
		DOM_Actor akActor = DOM01.actorArray[i]
		if akActor != None
			if akActor.PoseMarker != None
				akActor.PoseMarker.Delete()
				akActor.PoseMarker = None
			endif
			akActor.SetMarkerAtPosition()
		endif
		i += 1
	EndWhile
EndFunction

; Leash 

bool Property clearing_leash_point = false Auto Hidden

bool Function IsLeashPointInUse(DOMLeashPointScript objScript)
	if clearing_leash_point
		return false
	endif
	if LeashPointInUse(objScript)
		return true
	endif
	if DOMPAH.hasPAH()
		return DOMPAH.IsLeashPointInUse(objScript)
	endif
	return false
EndFunction

bool Function LeashPointInUse(ObjectReference leash_point)
	int n = DOM02.actorCounter
	int i = 0
	While (i < n)
		If DOM02.actorArray[i].leash_point == leash_point
			return true
		endif
		i += 1
	EndWhile
	return false
EndFunction

Function ClearLeashPoint(DOMLeashPointScript leash_point)
	int n = DOM02.actorCounter
	int i = 0
	While (i < n)
		If DOM02.actorArray[i].leash_point == leash_point as ObjectReference
			DOM02.actorArray[i].leash_point = None
		endif
		i += 1
	EndWhile
	if DOMPAH.hasPAH()
		return DOMPAH.ClearLeashPoint(leash_point)
	endif
EndFunction

; Events

Function SetSendExternalEvents(bool status)
	sendDOMExternalEventToggle = status
EndFunction

Function SetSendExternalEventsExt(bool status)
	sendDOMExternalEventToggleExt = status
EndFunction

Function SetSendExternalEventsExt2(bool status)
	sendDOMExternalEventToggleExt2 = status
EndFunction

Function SetSendExternalEventsExt3(bool status)
	sendDOMExternalEventToggleExt3 = status
EndFunction

Function SendDOMExternalEventSSSBS(Form sender, string the_order, string type, string reason, bool flag, string txt)
	if !sendDOMExternalEventToggleExt3
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEventSSSBS Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
		ModEvent.PushString(handle, reason)
		ModEvent.PushBool(handle, flag)
		ModEvent.PushString(handle, txt)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEventSSSBS Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSSBS(Form sender, string the_order, string type, bool flag, string txt)
	if !sendDOMExternalEventToggleExt3
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEventSSBS Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
		ModEvent.PushBool(handle, flag)
		ModEvent.PushString(handle, txt)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEventSSBS Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSFB(Form sender, string the_order, float value, bool flag)
	if !sendDOMExternalEventToggleExt2
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushFloat(handle, value)
		ModEvent.PushBool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSSFB(Form sender, string the_order, string type, float value, bool flag)
	if !sendDOMExternalEventToggleExt2
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
		ModEvent.PushFloat(handle, value)
		ModEvent.PushBool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSSB(Form sender, string the_order, string type, bool flag)
	if !sendDOMExternalEventToggleExt2
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
		ModEvent.PushBool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSSSB(Form sender, string the_order, string type, string reason, bool flag)
	if !sendDOMExternalEventToggleExt2
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
		ModEvent.PushString(handle, reason)
		ModEvent.PushBool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSSS(Form sender, string the_order, string type, string reason)
	if !sendDOMExternalEventToggle
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
		ModEvent.PushString(handle, reason)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSSF(Form sender, string the_order, string type, float value)
	if !sendDOMExternalEventToggleExt
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
		ModEvent.PushFloat(handle, value)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSS(Form sender, string the_order, string type)
	if !sendDOMExternalEventToggle
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSI(Form sender, string the_order, int value)
	if !sendDOMExternalEventToggleExt
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEventSI Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushInt(handle, value)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEventSI Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventSSI(Form sender, string the_order, string type, int value)
	if !sendDOMExternalEventToggleExt
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEventSSI Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, type)
		ModEvent.PushInt(handle, value)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEventSSI Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMExternalEventS(Form sender, string the_order)
	if !sendDOMExternalEventToggle
		return
	endif
	string eventName = "DOMOn"+the_order
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMExternalEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMExternalEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMOrder(Form sender, string the_order, string type="", bool flag=false)
	if !sendDOMOrders
		return
	endif
 	string formid = ""
	if sender != None
		formid = DOM_Util.ConvertIDToHex(sender.GetFormID())
	endif
	string eventName = "DOMOnEvent"+the_order+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMOrder Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, the_order)
		ModEvent.PushString(handle, type)
		ModEvent.Pushbool(handle, flag)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMOrder Registering event FAILED "+eventName)
    endif
EndFunction

Function SendDOMEvent(Form sender, string the_order, float amount=0.0, int reason=0, string type="")
	if !sendDOMEvents
		return
	endif
	string formid = ""
	if sender != None
		formid = DOM_Util.ConvertIDToHex(sender.GetFormID())
	endif
	string eventName = "DOMOnEvent"+the_order+formid
    int handle = ModEvent.Create(eventName)
    if (handle)
		;LogTrace("SendDOMEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, sender)
		ModEvent.PushString(handle, the_order)
		ModEvent.PushFloat(handle, amount)
		ModEvent.PushInt(handle, reason)
		ModEvent.PushString(handle, type)
        ModEvent.Send(handle)
	else
		LogTrace("SendDOMEvent Registering event FAILED "+eventName)
    endif
EndFunction

; Summon Actors

Function SummonSlaves(Actor akTarget, bool only_fighters)
	LogTrace("SummonSlaves only_fighters="+only_fighters+" also_posing="+summonPosingToggle+" also_pah="+summonPAHToggle)
	int n = DOM02.actorCounter
	int i = 0
	while i < n
		DOM_Actor akActor = DOM02.actorArray[i]
		if akActor != None
			if IsToBeSummoned(akActor,only_fighters)
				LogTrace("SummonSlaves summon "+akActor.GetName())
				akActor.akRef.moveTo(akTarget)
			endif
		endif
		i += 1
	endwhile
	if summonPAHToggle
		DOMPAH.SummonSlaves(akTarget,only_fighters)
	endif
EndFunction

Function SummonSlavers(Actor akTarget, bool only_fighters)
	LogTrace("SummonSlavers only_fighters="+only_fighters+" also_posing="+summonPosingToggle+" also_pah="+summonPAHToggle)
	int n = DOM01.actorCounter
	int i = 0
	while i < n
		DOM_Actor akActor = DOM01.actorArray[i]
		if akActor != None
			if IsToBeSummoned(akActor,only_fighters)
				LogTrace("SummonSlavers summon "+akActor.GetName())
				akActor.akRef.moveTo(akTarget)
			endif
		endif
		i += 1
	endwhile
EndFunction

Function SummonRunnerSlaves(Actor akTarget)
	LogTrace("SummonRunnerSlaves also_pah="+summonPAHToggle)
	int n = DOM02.actorCounter
	int i = 0
	while i < n
		DOM_Actor akActor = DOM02.actorArray[i]
		if akActor != None
			if IsARunner(akActor)
				LogTrace("SummonRunnerSlaves summon "+akActor.GetName())
				akActor.akRef.moveTo(akTarget)
			endif
		endif
		i += 1
	endwhile
	if summonPAHToggle
		DOMPAH.SummonRunnerSlaves(akTarget)
	endif
EndFunction

Function SummonFollowerSlaves(Actor akTarget)
	int n = DOM02.actorCounter
	LogTrace("SummonFollowerSlaves n="+n+" also_pah="+summonPAHToggle)
	int i = 0
	while i < n
		DOM_Actor akActor = DOM02.actorArray[i]
		if akActor != None
			if akActor.behaviour == "follow_player"
				LogTrace("SummonFollowerSlaves summon "+akActor.GetName())
				akActor.akRef.moveTo(Game.GetPlayer())
			elseif akActor.behaviour == "follow_trainer"
				DOM_Actor akTrainer = akActor.GetTrainer()
				if akTrainer != None && akTrainer.behaviour == "follow_player"
					LogTrace("SummonFollowerSlaves summon "+akActor.GetName())
					akActor.akRef.moveTo(akTarget)
				endif
			endif
		endif
		i += 1
	endwhile
	if summonPAHToggle
		DOMPAH.SummonFollowerSlaves(akTarget)
	endif
EndFunction

Function SummonFollowerSlavers(Actor akTarget)
	int n = DOM01.actorCounter
	LogTrace("SummonFollowerSlavers n="+n)
	int i = 0
	while i < n
		DOM_Actor akActor = DOM01.actorArray[i]
		if akActor != None
			if akActor.behaviour == "follow_player"
				LogTrace("SummonFollowerSlavers summon "+akActor.GetName())
				akActor.akRef.moveTo(akTarget)
			endif
		endif
		i += 1
	endwhile
EndFunction

Function SummonFollowers(Actor akTarget)
	if nbAllFollowers == 0
		FillNearbySlavesAndActors()
	endif
	int n = nbAllFollowers
	LogTrace("SummonFollowers n="+n)
	int i = 0
	while i < n
		Actor akRef = all_followers[i]
		if akRef != None && !akRef.IsInFaction(DOMActionGuard)
			LogTrace("SummonFollowers summon "+akRef.GetDisplayName())
			akRef.moveTo(akTarget)
		endif
		i += 1
	endwhile
EndFunction

Function SummonAllFollowers(Actor akTarget)
	;LogTrace("SummonAllFollowers waiting_for_family="+waiting_for_family)
	SummonFollowers(akTarget)
	SummonFollowerSlavers(akTarget)
	SummonFollowerSlaves(akTarget)
EndFunction

bool Function IsToBeSummoned(DOM_Actor akActor, bool only_fighters)
	; Ignore tiedup and working slaves
	if akActor.is_restrained || akActor.behaviour_working
		LogTrace("IsToBeSummoned ignore restrained or working "+akActor.GetName())
		return false
	endif
	
	; Only bodyguards
	if only_fighters
		if akActor.mind.should_fight_for_player
			if !summonPosingToggle ; Ignore posing slaves
				if akActor.canIdleSoft
					;LogTrace("IsToBeSummoned select canIdleSoft fighter "+akActor.GetName())
					return true
				endif
			else
				;LogTrace("IsToBeSummoned select non posing fighter "+akActor.GetName())
				return true
			endif
		endif
		LogTrace("IsToBeSummoned ignore non fighter or can not idle "+akActor.GetName())
		return false
	endif
	
	; All slaves
	if !summonPosingToggle ; Ignore posing slaves
		if akActor.canIdleSoft
			;LogTrace("IsToBeSummoned select canIdleSoft "+akActor.GetName())
			return true
		endif
	else
		;LogTrace("IsToBeSummoned select non posing "+akActor.GetName())
		return true
	endif
	if IsARunner(akActor)
		;LogTrace("IsToBeSummoned select freshly captured "+akActor.GetName())
		return true
	endif
	LogTrace("IsToBeSummoned ignore can not idle "+akActor.GetName())
	return false
EndFunction

bool Function IsARunner(DOM_Actor akActor)
	; Ignore tiedup and working slaves
	if akActor.behaviour == "flee_and_cower"
		LogTrace("IsARunner fleeing and cowering: "+akActor.GetName())
		return true
	endif
	if akActor.behaviour == "running_away"
		LogTrace("IsARunner running away: "+akActor.GetName())
		return true
	endif
	if akActor.is_running_away
		LogTrace("IsARunner is running away: "+akActor.GetName())
		return true
	endif
	if akActor.akRef.isInFaction(DOMActionFleeing)
		LogTrace("IsARunner in fleeing faction: "+akActor.GetName())
		return true
	endif
	return false
EndFunction

Function HudNotification(string msg)
	Debug.Notification(msg)
	if verboseMode
		Debug.Trace("DOM_Core: "+msg)
	endif
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Core: "+msg)
EndFunction

Function LogTrace(string msg)
	if verboseMode
		Debug.Trace("DOM_Core: "+msg)
	endif
EndFunction

Function LogAnim(string msg)
	if verboseAnim
		Debug.Trace("DOM_Core:Animation: "+msg)
	endif
EndFunction

Function LogTopic(Actor ActorRef, Topic topic_to_say)
	if verboseTopics
		Debug.Trace("DOM_Core:Topic: "+ActorRef.GetDisplayName()+": says: "+topic_to_say)
	endif
EndFunction

; This is called by DOM_PlayerAlias OnLocationChange
Function DoLocationChange(Location akOldLoc, Location akNewLoc)
  UnsetAsVictim(currentVictim)
  ReCheckFollowFriendships()
  ReCheckDistantFriendships()
  ;LogTrace("DoLocationChange After friendship check")
  NPCCheckForceGreet()
  ;LogTrace("DoLocationChange After family check")
EndFunction

; CBPC Collisions
;/
string[] femaleNodes

		femaleNodes = new string[8]
		femaleNodes[0] = "L Breast01"
		femaleNodes[1] = "L Breast02"
		femaleNodes[2] = "L Breast03"
		femaleNodes[3] = "R Breast01"
		femaleNodes[4] = "R Breast02"
		femaleNodes[5] = "R Breast03"
		femaleNodes[6] = "NPC L Breast"
		femaleNodes[7] = "NPC R Breast"
		

		femaleNodes = new string[12]
		femaleNodes[0] = "L Breast01"
		femaleNodes[1] = "L Breast02"
		femaleNodes[2] = "L Breast03"
		femaleNodes[3] = "R Breast01"
		femaleNodes[4] = "R Breast02"
		femaleNodes[5] = "R Breast03"		
		femaleNodes[6] = "NPC Pelvis [Pelv]"
		femaleNodes[7] = "HDT Belly"
		femaleNodes[8] = "NPC L Butt"
		femaleNodes[9] = "NPC R Butt"
		femaleNodes[10] = "NPC L Breast"
		femaleNodes[11] = "NPC R Breast"
		
		uniNodes = new string[12]
		uniNodes[0] = "CME L Foot [Lft ]"
		uniNodes[1] = "CME R Foot [Rft ]"
		uniNodes[2] = "CME L Calf [LClf]"
		uniNodes[3] = "CME R Calf [RClf]"
		uniNodes[4] = "CME L Knee [LKne]"
		uniNodes[5] = "CME R Knee [RKne]"		
		uniNodes[6] = "CME L Thigh [LThg]"
		uniNodes[7] = "CME R Thigh [RThg]"
		uniNodes[8] = "CME Spine1 [Spn1]"
		uniNodes[9] = "CME Spine2 [Spn2]"
		uniNodes[10] = "CME Neck [Neck]"
		uniNodes[11] = "NPCEyeBone"
		
		socialNodes = new string[8]
		socialNodes[0] = "CME L UpperArm [LUar]"
		socialNodes[1] = "CME R UpperArm [RUar]"
		socialNodes[2] = "CME L Forearm [LLar]"
		socialNodes[3] = "CME R Forearm [RLar]"	
		socialNodes[4] = "CME L Hand [LHnd]"
		socialNodes[5] = "CME R Hand [RHnd]"		
		socialNodes[6] = "CME L Finger21 [LF21]"
		socialNodes[7] = "CME R Finger21 [RF21]"		


/;

;/
Event OnCollisionWithFemale(string eventName, string nodeName, float collisionDuration, Form actorForm)
	Actor a = actorForm as Actor
	if(a == None)
		LogTrace("OnCollisionWithFemale actor=None event="+eventName+" node="+nodeName+" duration="+collisionDuration)
		return
	endif
	LogTrace("OnCollisionWithFemale actor="+a.GetDisplayName()+" event="+eventName+" node="+nodeName+" duration="+collisionDuration)
	
	if femaleNodes.Find(nodeName) >= 0 && actorForm != None
		Actor a = actorForm as Actor
		if(a != None)
			Debug.Notification((a.getactorbase() as form).getname() + " - " + nodeName + " touched")
		endif
	endif
EndEvent

Event OnCollisionWithMale(string eventName, string nodeName, float collisionDuration, Form actorForm)
	Actor a = actorForm as Actor
	if(a == None)
		LogTrace("OnCollisionWithMale actor=None event="+eventName+" node="+nodeName+" duration="+collisionDuration)
		return
	endif
	LogTrace("OnCollisionWithMale actor="+a.GetDisplayName()+" event="+eventName+" node="+nodeName+" duration="+collisionDuration)
EndEvent
/;

Function RegisterForCollisionEvents()
	;LogTrace("Registering for collision events")
	;RegisterForModEvent("CBPCPlayerCollisionWithFemaleEvent", "OnCollisionWithFemale")
	;RegisterForModEvent("CBPCPlayerCollisionWithMaleEvent", "OnCollisionWithMale")
EndFunction

Function UnregisterForCollisionEvents()
	;LogTrace("Unregistering for collision events")
	UnregisterForModEvent("CBPCPlayerCollisionWithFemaleEvent")
	UnregisterForModEvent("CBPCPlayerCollisionWithMaleEvent")
EndFunction

Function RegisterModEvents()
	; Just make sure to not create duplicates
	UnregisterModEvents()

	;RegisterForCollisionEvents()
EndFunction

Function UnregisterModEvents()
	UnregisterForCollisionEvents()
EndFunction
