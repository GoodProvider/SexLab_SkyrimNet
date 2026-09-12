Scriptname DOM_Generator extends Quest
Import Utility
import DOM_Util

DOM_Core Property DOM01 Auto
DOM_Diary Property DOM04 Auto
DOM_PAH Property DOMPAH Auto
DOM_ZAZ Property DOMZaz Auto
DOM_SEXLAB Property DOMSexlab Auto
Faction Property DOMPotentialSlaverFaction Auto
Actor Property PlayerRef Auto

; Origin factions
Faction Property DOMJobOriginFaction Auto
Faction Property DOMEmployerOriginFaction Auto
Faction Property DOMTrainerOriginFaction Auto

; DOM Factions
Faction Property DOMHasPersonality Auto
Faction Property DOMPlayerSlaveFaction Auto
Faction Property DOMPlayerSlaverFaction Auto
Faction Property DOMNotPlayerSlaveFaction Auto
Faction Property DOMNotPlayerSlaverFaction Auto
Faction Property DOMRandomSeed Auto  ; to save Random seed of non unique NPC

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
Faction Property DOMTrainSex Auto
Faction Property DOMTrainAnal Auto
Faction Property DOMTrainOral Auto
Faction Property DOMTrainVaginal Auto

; Skills
Faction Property DOMSkillEnforcer Auto      ; Submission
Faction Property DOMSkillPersuader Auto     ; Fear
Faction Property DOMSkillDepraver Auto      ; Humiliation
Faction Property DOMSkillPredator Auto      ; Anger
Faction Property DOMSkillSlaver Auto        ; Resignation
Faction Property DOMSkillDeceiver Auto      ; Respect

; Love syndrome
Faction Property DOMLoveDesire Auto
Faction Property DOMLoyalWorship Auto
Faction Property DOMLoveFascination Auto
Faction Property DOMLoyalAbsolution Auto
Faction Property DOMLoyalDevotion Auto
Faction Property DOMLoveAdmiration Auto

; Counters
Faction Property DOMNbBrainwashed Auto
Faction Property DOMNbBroken Auto
Faction Property DOMNbComfort Auto
Faction Property DOMNbFlatter Auto
Faction Property DOMNbInsult Auto
Faction Property DOMNbOrgasm Auto
Faction Property DOMNbPain Auto
Faction Property DOMNbBondage Auto
Faction Property DOMNbPraise Auto
Faction Property DOMNbPromise Auto
Faction Property DOMNbRape Auto
Faction Property DOMNbDrug Auto
Faction Property DOMNbSex Auto
Faction Property DOMNbSexForMoney Auto
Faction Property DOMNbSexWithOthers Auto
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

; Virgin status
Faction Property DOMVirginVaginal Auto
Faction Property DOMVirginAnal Auto
Faction Property DOMVirginOral Auto
Faction Property DOMVirginSame Auto
Faction Property DOMVirginGangbang Auto

; Hidden kinks
Faction Property DOMHiddenKink0 Auto
Faction Property DOMHiddenKink1 Auto
Faction Property DOMHiddenKink2 Auto
Faction Property DOMHiddenKink3 Auto
Faction Property DOMHiddenKink4 Auto
Faction Property DOMHiddenKink5 Auto
Faction Property DOMHiddenKink6 Auto
Faction Property DOMHiddenKink7 Auto

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
; Main per training stat
Faction Property DOMModHumility Auto
Faction Property DOMModFearfulness Auto
Faction Property DOMModNaivety Auto
Faction Property DOMModForgiveness Auto
Faction Property DOMModPrudent Auto
Faction Property DOMModDiscipline Auto

; Main per SKILL
Faction Property DOMModInsensitivity Auto ; Enforcer 
Faction Property DOMModIntimidate Auto    ; Persuader 
Faction Property DOMModSelfEsteem Auto    ; Depraver
Faction Property DOMModResentment Auto    ; Predator 
Faction Property DOMModController Auto    ; Slaver
Faction Property DOMModPretender Auto     ; Deceiver

; Main per behaviour
Faction Property DOMModVaginal Auto
Faction Property DOMModAnal Auto
Faction Property DOMModOral Auto
Faction Property DOMModFlexibility Auto   ; Agreeableness, Posing
Faction Property DOMModPerfectionism Auto ; Conscientiousness
Faction Property DOMModAuthority Auto     ; Openness
Faction Property DOMModCombat Auto        ; Special

; Secondary
Faction Property DOMModCriminality Auto   ; Honesty
Faction Property DOMModSentimentality Auto; Emotionality
Faction Property DOMModDaring Auto        ; Extraversion
Faction Property DOMModImpatience Auto    ; Agreeableness, being angry
Faction Property DOMModDiligent Auto      ; Conscientiousness
Faction Property DOMModManipulation Auto  ; Openness

; Love/Loyal
Faction Property DOMModModesty Auto       ; Honesty
Faction Property DOMModDependence Auto    ; Emotionality
Faction Property DOMModIngenuity Auto     ; Extraversion
Faction Property DOMModGentleness Auto    ; Agreeableness, being angry
Faction Property DOMModConsideration Auto ; Conscientiousness
Faction Property DOMModCreativity Auto    ; Openness

; Factions
Faction Property ArenaFaction Auto
Faction Property ForswornFaction Auto
Faction Property BanditFaction Auto
Faction Property BladesFaction Auto 
Faction Property CWImperialFaction Auto
Faction Property CWImperialFactionNPC Auto
Faction Property CWSonsFaction Auto
Faction Property CWSonsFactionNPC Auto
Faction Property DarkBrotherhoodFaction Auto 
Faction Property HagravenFaction Auto
Faction Property IsGuardFaction Auto
Faction Property GuardDialogueFaction Auto
Faction Property NecromancerFaction Auto
Faction Property SilverHandFaction Auto
Faction Property ThalmorFaction Auto
Faction Property ThievesGuildFaction Auto
Faction Property VampireFaction Auto
Faction Property VigilantOfStendarrFaction Auto
Faction Property WarlockFaction Auto	;Warlocks
Faction Property WerewolfFaction Auto
Faction Property CompanionsFaction Auto
Faction Property DraugrAllyFaction Auto
Faction Property CaravanMerchant Auto
Faction Property HunterFaction Auto
Faction Property FavorJobsBeggarsFaction Auto

; Job factions
Faction Property JobApothecaryFaction Auto
Faction Property JobBardFaction Auto
Faction Property JobCourtWizardFaction Auto
Faction Property JobJusticiar Auto
Faction Property JobPriestFaction Auto
Faction Property JobOrcWiseWomanFaction Auto
Faction Property JobStewardFaction Auto
Faction Property JobMerchantFaction Auto
Faction Property JobBlacksmithFaction Auto
Faction Property JobFarmerFaction Auto
Faction Property JobLumberjackFaction Auto
Faction Property JobMinerFaction Auto
Faction Property JobTrainerFaction Auto
Faction Property JobFletcherFaction Auto
Faction Property JobJewelerFaction Auto
Faction Property JobTailorFaction Auto
Faction Property JobJarlFaction Auto
Faction Property JobFenceFaction Auto
Faction Property JobInnkeeperFaction Auto
Faction Property JobInnServer Auto

; Employer factions
Faction Property DawnstarWhiteHallFaction Auto
Faction Property FalkreathJarlsLonghouseFaction Auto
Faction Property MarkarthCastleServantsFaction Auto
Faction Property MarkarthKeepFaction Auto
Faction Property MorthalLonghouseFaction Auto
Faction Property RiftenMistveilKeepFaction Auto
Faction Property SolitudeBluePalaceFaction Auto
Faction Property SolitudeBluePalaceServants Auto
Faction Property WhiterunDragonsReachServants Auto
Faction Property WindhelmPalace Auto
Faction Property WinterholdJarlFaction Auto

; Trainer factions
Faction Property JobTrainerAlchemyFaction Auto ; "Alchemy Trainer"
Faction Property JobTrainerAlterationFaction Auto ; "Alteration Trainer"
Faction Property JobTrainerBlockFaction Auto ; "Block Trainer"
Faction Property JobTrainerConjurationFaction Auto ; "Conjuration Trainer"
Faction Property JobTrainerDestructionFaction Auto ; "Destruction Trainer"
Faction Property JobTrainerEnchantingFaction Auto ; "Enchanting Trainer"
Faction Property JobTrainerHeavyArmorFaction Auto ; "HeavyArmor Trainer"
Faction Property JobTrainerIllusionFaction Auto ; "Illusion Trainer"
Faction Property JobTrainerLightArmorFaction Auto ; "LightArmor Trainer"
Faction Property JobTrainerLockpickingFaction Auto ; "Lockpicking Trainer"
Faction Property JobTrainerMarksmanFaction Auto ; "archery Trainer"
Faction Property JobTrainerOneHandedFaction Auto ; "OneHanded Trainer"
Faction Property JobTrainerPickpocketFaction Auto ; "PickpocketFaction Trainer"
Faction Property JobTrainerRestorationFaction Auto ; "Restoration Trainer"
Faction Property JobTrainerSmithingFaction Auto ; "Smithing Trainer"
Faction Property JobTrainerSneakFaction Auto ; "Sneak Trainer"
Faction Property JobTrainerSpeechcraftFaction Auto ; "Speechcraft Trainer"
Faction Property JobTrainerTwoHandedFaction Auto ; "TwoHanded Trainer"

; Ruler factions
Faction Property GovExiled Auto
Faction Property GovRuling Auto

; Crime factions
Faction Property CrimeFactionCidhnaMine Auto
Faction Property CrimeFactionEastMarch Auto
Faction Property CrimeFactionFalkreath Auto
Faction Property CrimeFactionGreybeard Auto
Faction Property CrimeFactionHaafingar Auto
Faction Property CrimeFactionHjaalmarch Auto
Faction Property CrimeFactionImperial Auto
Faction Property CrimeFactionKhajiitCaravans Auto
Faction Property CrimeFactionOrcs Auto
Faction Property CrimeFactionPale Auto
Faction Property CrimeFactionReach Auto
Faction Property CrimeFactionRift Auto
Faction Property CrimeFactionSons Auto
Faction Property CrimeFactionThievesGuild Auto
Faction Property CrimeFactionWhiterun Auto
Faction Property CrimeFactionWinterhold Auto
Faction Property DLC1VampireCrimeFaction Auto

; Toggle
Message Property DOMPersonalityReadModeMessage Auto
bool Property readJSONTraitsWarning = true Auto Hidden
bool Property writeJSONTransfer = true Auto Hidden
bool Property writeJSONRelease = true Auto Hidden
bool Property readJSONForUniques = true Auto Hidden
bool Property readJSONForSpawned = true Auto Hidden
bool Property readJSONTraitsToggle = true Auto Hidden
bool Property ReadJSONRelationshipToggle = true Auto Hidden
bool Property ReadJSONVirginityToggle = true Auto Hidden
bool Property ReadJSONTrainingToggle = true Auto Hidden
bool Property ReadJSONKinksToggle = true Auto Hidden
bool Property ReadJSONMemoriesToggle = true Auto Hidden
bool Property printActorBonusesToggle = false Auto Hidden

Function Initialize()
	LogInfo("===========================================================================")
	LogInfo("==                            DOM: Generator                             ==")
	LogInfo("===========================================================================")
	if DOMZaz == None
		LogTrace("Recovering DOMZaz")
		DOMZaz = DOM01.DOMZaz
	endif
	ReadTraitBonusFile()
EndFunction

Function WriteTraitBonusFile(string fileName)
	if JsonUtil.JsonExists(fileName)
		LogTrace("WriteTraitBonusFile: Skipping! File already exists: "+fileName)
		return
	endif
	LogTrace("WriteTraitBonusFile: "+fileName)
	JsonUtil.StringListAdd(fileName,"specialnames", "Animal",false)	; false = don't allow duplicates
	JsonUtil.StringListAdd(fileName,"specialnames", "Child",false)	
	JsonUtil.StringListAdd(fileName,"specialnames", "Creature",false)	
	JsonUtil.StringListAdd(fileName,"specialnames", "Elder",false)	
	JsonUtil.StringListAdd(fileName,"specialnames", "Female",false)	
	JsonUtil.StringListAdd(fileName,"specialnames", "Male",false)	    
	JsonUtil.StringListAdd(fileName,"specialnames", "Undead",false)	
	JsonUtil.StringListAdd(fileName,"specialnames", "YoungAdult",false)	

	JsonUtil.StringListAdd(fileName,"racenames", "Argonian",false) ; false = don't allow duplicates
	JsonUtil.StringListAdd(fileName,"racenames", "Breton",false)
	JsonUtil.StringListAdd(fileName,"racenames", "Dark Elf",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "Daedra",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "High Elf",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "Khajiit",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "Imperial",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "Nord",false)	    
	JsonUtil.StringListAdd(fileName,"racenames", "Orc",false)	    
	JsonUtil.StringListAdd(fileName,"racenames", "Redguard",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "Snow Elf",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "Succubus",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "Vampire",false)	
	JsonUtil.StringListAdd(fileName,"racenames", "Wood Elf",false)	
		
	JsonUtil.StringListAdd(fileName,"traitnames", "Honesty",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Emotionality",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Extraversion",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Agreeableness",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Conscientiousness",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Openness",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Wilfulness",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Toughness",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Sensuality",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Submissivity",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Boldness",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Smartness",false)	
	JsonUtil.StringListAdd(fileName,"traitnames", "Dominance",false) ; Opposite of submissivity	

	JsonUtil.FloatListAdd(fileName,"Animal",  10.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Animal",  10.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Animal",  10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Animal",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Animal",  10.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Animal", -20.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Animal",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Animal",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Animal",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Animal",   0.0,true) ; submissivity for 50% of population
	JsonUtil.FloatListAdd(fileName,"Animal",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Animal", -20.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Animal",   0.0,true) ; dominance for the other 50% of population

	JsonUtil.FloatListAdd(fileName,"Argonian",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Argonian",   0.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Argonian", -20.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Argonian",  10.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Argonian",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Argonian",   0.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Argonian",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Argonian",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Argonian",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Argonian",  10.0,true) ; submissivity for 50% of population
	JsonUtil.FloatListAdd(fileName,"Argonian",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Argonian",  10.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Argonian", -10.0,true) ; dominance for the other 50% of population

	JsonUtil.FloatListAdd(fileName,"Breton",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Breton",  10.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Breton",  10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Breton",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Breton",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Breton", -10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Breton",  10.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Breton", -10.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Breton",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Breton",  10.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Breton",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Breton",  10.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Breton", -10.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Child",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Child",  30.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Child",  20.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Child",  10.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Child",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Child", -10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Child",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Child",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Child",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Child",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Child", -30.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Child",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Child",   0.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Creature", -10.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Creature", -30.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Creature",   0.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Creature", -20.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Creature",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Creature", -25.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Creature",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Creature",  20.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Creature",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Creature",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Creature",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Creature",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Creature",  10.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Daedra", -40.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Daedra", -20.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Daedra",  10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Daedra", -10.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Daedra",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Daedra",   0.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Daedra",  30.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Daedra",  40.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Daedra",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Daedra", -30.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Daedra",  20.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Daedra",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Daedra",  30.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Dark Elf",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Dark Elf", -20.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Dark Elf", -10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Dark Elf",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Dark Elf",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Dark Elf",   0.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Dark Elf",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Dark Elf",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Dark Elf", -20.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Dark Elf", -10.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Dark Elf",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Dark Elf",  10.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Dark Elf",  10.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Elder",  10.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Elder", -10.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Elder",  10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Elder",  10.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Elder",  10.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Elder",  10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Elder",  10.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Elder",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Elder", -30.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Elder",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Elder",  10.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Elder",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Elder",   0.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Female",  10.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Female",  10.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Female",   5.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Female",   5.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Female",   0.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"High Elf",  10.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"High Elf",   0.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"High Elf",   0.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"High Elf", -10.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"High Elf",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"High Elf", -10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"High Elf",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"High Elf",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"High Elf",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"High Elf",   5.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"High Elf",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"High Elf",  20.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"High Elf",  15.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Imperial",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Imperial",  10.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Imperial",   0.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Imperial",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Imperial",  10.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Imperial",  10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Imperial",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Imperial", -10.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Imperial",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Imperial",  10.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Imperial",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Imperial",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Imperial",  10.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Khajiit", -10.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Khajiit",  20.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Khajiit", -10.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Khajiit", -10.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Khajiit",   0.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Male", -10.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Male", -10.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Male",  -5.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Male",  -5.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Male",   0.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Nord",  10.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Nord",   0.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Nord", -10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Nord",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Nord", -10.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Nord", -10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Nord",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Nord",  10.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Nord",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Nord",  15.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Nord",  10.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Nord",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Nord",   5.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Orc",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Orc",   0.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Orc", -10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Orc", -10.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Orc",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Orc",   0.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Orc",  10.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Orc",  20.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Orc",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Orc", -20.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Orc",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Orc",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Orc",  20.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Redguard", -10.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Redguard", -10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Redguard",  10.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Redguard",  10.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Redguard",   0.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Snow Elf",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Snow Elf", -20.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Snow Elf", -10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Snow Elf",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Snow Elf",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Snow Elf", -20.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Snow Elf",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Snow Elf",  10.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Snow Elf",  10.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Snow Elf",  20.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Snow Elf",  10.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Snow Elf",  10.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Snow Elf", -20.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Succubus", -30.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Succubus", -10.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Succubus",  30.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Succubus", -20.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Succubus",  10.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Succubus",  20.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Succubus",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Succubus",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Succubus",  40.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Succubus", -40.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Succubus",   0.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Succubus",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Succubus",  40.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Undead", -20.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Undead", -20.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Undead", -25.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Undead", -20.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Undead",  -5.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Undead", -20.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Undead", -10.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Undead",  10.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Undead",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Undead",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Undead",  10.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Undead", -20.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Undead",   0.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Vampire",  -5.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Vampire", -20.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Vampire", -15.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Vampire", -10.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Vampire",   5.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Vampire", -20.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Vampire",  15.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Vampire",  20.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Vampire",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Vampire",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Vampire",  10.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Vampire",  -5.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Vampire",   0.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"Wood Elf",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Wood Elf",   0.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Wood Elf",  20.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Wood Elf",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Wood Elf",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Wood Elf", -20.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Wood Elf",   0.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Wood Elf", -10.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Wood Elf",  10.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Wood Elf",  20.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Wood Elf", -10.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Wood Elf",  10.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Wood Elf", -20.0,true) ; dominance

	JsonUtil.FloatListAdd(fileName,"YoungAdult", -20.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"YoungAdult",  20.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"YoungAdult",  20.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"YoungAdult", -20.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"YoungAdult", -20.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"YoungAdult",  10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"YoungAdult", -20.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"YoungAdult",   0.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"YoungAdult",  20.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"YoungAdult",   0.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"YoungAdult", -20.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"YoungAdult",   0.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"YoungAdult",   0.0,true) ; dominance-

	JsonUtil.FloatListAdd(fileName,"Player",   0.0,true) ; honesty
	JsonUtil.FloatListAdd(fileName,"Player", -10.0,true) ; emotionality
	JsonUtil.FloatListAdd(fileName,"Player",  10.0,true) ; extraversion
	JsonUtil.FloatListAdd(fileName,"Player",   0.0,true) ; agreeableness
	JsonUtil.FloatListAdd(fileName,"Player",   0.0,true) ; conscientiousness
	JsonUtil.FloatListAdd(fileName,"Player",  10.0,true) ; openness
	JsonUtil.FloatListAdd(fileName,"Player",  10.0,true) ; wilpower
	JsonUtil.FloatListAdd(fileName,"Player",  10.0,true) ; toughness
	JsonUtil.FloatListAdd(fileName,"Player",   0.0,true) ; sensuality
	JsonUtil.FloatListAdd(fileName,"Player", -20.0,true) ; submissivity
	JsonUtil.FloatListAdd(fileName,"Player",  20.0,true) ; boldness
	JsonUtil.FloatListAdd(fileName,"Player",  10.0,true) ; smartness
	JsonUtil.FloatListAdd(fileName,"Player",  20.0,true) ; dominance

	int i = 0
	while i < DOM04.placeOfOriginNames.length
		string placeName = DOM04.placeOfOriginNames[i]
		JsonUtil.StringListAdd(fileName,"placenames", placeName,false)	
		if placeName != ""
			if i > 0 && i < 4 ; quiet places
				JsonUtil.FloatListAdd(fileName,placeName,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,placeName,   5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,placeName,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,placeName,  -5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; dominance
			else ; other places
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,placeName,  -5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,placeName,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,placeName,   5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,placeName,  -5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,placeName,   0.0,true) ; dominance
			endif
		endif
		i += 1
	endwhile

	i = 0
	while i < DOM04.jobOfOriginNames.length
		string jobName = DOM04.jobOfOriginNames[i]
		JsonUtil.StringListAdd(fileName,"jobnames", jobName,false)	
		if jobName != ""
			if i < 4 ; Nobility, just little adjustments for fun
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; dominance
			elseif i == 4 ; Bandit: small bonus to fighting value, malus to refinement 
				JsonUtil.FloatListAdd(fileName,jobName, -15.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName, -15.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName, -15.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,  15.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; dominance
			elseif i == 5 ; Forsworn: small bonus to fighting value, malus to refinement 
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,  15.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName, -15.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName, -15.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; dominance
			elseif i == 8 || i == 9 || i == 39 ; Criminals
				JsonUtil.FloatListAdd(fileName,jobName, -15.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,  20.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,  20.0,true) ; dominance
			elseif i >= 6 && i <= 15 ; Fighters
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; dominance
			elseif  i >= 16 && i <= 25 ; Educated: Wizard, Priest, Bard,  bonus to refinement and intellect, malus to fighting
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,  25.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,  25.0,true) ; dominance
			elseif i >= 26 && i <= 30 ;  Merchant: small bonus to intellect, malus to fighting
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; dominance
			elseif i >= 31 && i <= 32 ; Artisan
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; dominance
			elseif i >= 33 && i <= 36 ; Physical labor farmer, miner ; Physical labor farmer, miner
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; dominance
			elseif i == 37 ; Guard
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,  15.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName, -15.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,  15.0,true) ; dominance
			elseif i == 38 	; Beggar, malus for most traits
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName, -20.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; dominance
			elseif i == 40 || i == 41 ; Works in an inn, small bonus to refinement
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,  15.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName, -10.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,   5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName,  -5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; dominance
			elseif i >= 50 && i < 100 ; Wenches
				JsonUtil.FloatListAdd(fileName,jobName,  20.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,jobName,  20.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,jobName,  20.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,jobName,  10.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,jobName,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,jobName, -20.0,true) ; dominance
			endif
		endif
		i += 1
	endwhile

	i = 0
	while i < DOM04.employerOfOriginNames.length
		string employerName = DOM04.employerOfOriginNames[i]
		JsonUtil.StringListAdd(fileName,"employernames", employerName,false)	
		if employerName != ""
			if i > 0 ; Works at court: bonus points for refinement
				JsonUtil.FloatListAdd(fileName,employerName,  10.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,employerName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,employerName,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,employerName,  -5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,employerName,  10.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,employerName,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,employerName,  -5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,employerName,  -5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,employerName,   5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,employerName,  10.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,employerName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,employerName,   5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,employerName,  10.0,true) ; dominance
			endif
		endif
		i += 1
	endwhile

	i = 0
	while i < DOM04.trainerOfOriginNames.length
		string trainerName = DOM04.trainerOfOriginNames[i]
		JsonUtil.StringListAdd(fileName,"trainernames", trainerName,false)	
		if trainerName != ""
			if i > 0 && i <= 7 ; Magic trainer 
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,trainerName,  -5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,trainerName,  -5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; dominance
			elseif i == 8 ; Speechcraft trainer 
				JsonUtil.FloatListAdd(fileName,trainerName,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; dominance
			elseif i > 8 && i <= 13 ; Fighter trainer 
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,trainerName, -10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,trainerName,  15.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,trainerName,   5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,trainerName, -10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; dominance
			elseif i > 13 && i <= 15 ; Woodsman
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; dominance
			else ; Scout
				JsonUtil.FloatListAdd(fileName,trainerName, -20.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,trainerName,  10.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,trainerName,   0.0,true) ; dominance
			endif
		endif
		i += 1
	endwhile

	i = 0
	while i < DOM04.classOfOriginNames.length
		string className = DOM04.classOfOriginNames[i]
		JsonUtil.StringListAdd(fileName,"classnames", className,false)	
		if className != ""
			if i > 0 && i <= 2 ; Archery class 
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className, -15.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 4 ; Fighter class 
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,  15.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 6 ; Hero class 
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,  15.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 8 ; Mage class 
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,  15.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 10 ; Sorcerer class 
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,  15.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 12 ; Warlock class 
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,  15.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 14 ; Priest class
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,  15.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 16 ; Shaman class
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,  15.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i == 17 ; Bard class
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,  15.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 19 ; Assassin class
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className, -15.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 21 ; Thief class
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; dominance
			elseif i == 22 ; Scout class
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i == 23 ; Ranger class
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 25 ; Blade class
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			elseif i <= 27 ; Soldier class
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; dominance
			else ; Bandit class
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; honesty
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; emotionality
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; extraversion
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; agreeableness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; conscientiousness
				JsonUtil.FloatListAdd(fileName,className,   5.0,true) ; openness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; wilpower
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; toughness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; sensuality
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; submissivity
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; boldness
				JsonUtil.FloatListAdd(fileName,className,  -5.0,true) ; smartness
				JsonUtil.FloatListAdd(fileName,className,   0.0,true) ; dominance
			endif
		endif
		i += 1
	endwhile

	JsonUtil.Save(fileName)
EndFunction

string[] __specialNames
string[] __raceNames
string[] __placeNames
string[] __jobNames
string[] __employerNames
string[] __trainerNames
string[] __classNames
string[] __traitNames
int __raceObject = 0

Function ReadTraitBonusFile()
	string fileName = "Diary Of Mine/PersonalityTraits.json"
	WriteTraitBonusFile(fileName)
	int n = JsonUtil.StringListCount(fileName,"racenames")
	LogTrace("ReadTraitBonusFile n="+__raceNames.length+"/"+n+" set up, file="+fileName)
	__specialNames  =  JsonUtil.StringListToArray(fileName, "specialnames")
	__raceNames     =  JsonUtil.StringListToArray(fileName, "racenames")
	__placeNames    =  JsonUtil.StringListToArray(fileName, "placenames")
	__jobNames      =  JsonUtil.StringListToArray(fileName, "jobnames")
	__employerNames =  JsonUtil.StringListToArray(fileName, "employernames")
	__trainerNames  =  JsonUtil.StringListToArray(fileName, "trainernames")
	__classNames    =  JsonUtil.StringListToArray(fileName, "classnames")
	__traitNames    =  JsonUtil.StringListToArray(fileName, "traitnames")
EndFunction

float[] Function GetTraitBonus(string bonusListName)
	string fileName = "Diary Of Mine/PersonalityTraits.json"
	return  JsonUtil.FloatListToArray(fileName, bonusListName)
EndFunction

float [] Function GetTraitBonusForActor(Actor akTarget)
	printActorBonusesToggle = true
	actorBase abTarget = akTarget.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	;LogTrace("Looking up bonus for "+akTarget.GetDisplayName()+" race = "+raceString)
	float[] BonusTraitsArray = new float[13]
	
	; Gender bonus
	; An examination of gender differences revealed that women scored higher than men on 
	; conscientiousness, emotional instability and agreeableness 
	; Study on student girls: +22H +49E -4X +12A +7C -3O
	; Additionnal HEXACO trait honesty, is negatively linked to the dark triads traits
	; dark triads = narcissism, psycho and machiavelism
	; those traits have much higher occurence in males
 	bool is_female     = (abTarget.GetSex() == 1)
	if is_female
		float[] gender_bonus = GetTraitBonus("Female")
		int i = 0
		while i < BonusTraitsArray.length && i < gender_bonus.length && i < __traitNames.length
			if gender_bonus[i] != 0.0
				BonusTraitsArray[i] = Random3GenderBonus(gender_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" Female "+__traitNames[i]+" "+gender_bonus[i])
				endif
			else
				BonusTraitsArray[i] = 0.0
			endif
			i += 1
		endwhile
	else
		float[] gender_bonus = GetTraitBonus("Male")
		int i = 0
		while i < BonusTraitsArray.length && i < gender_bonus.length && i < __traitNames.length
			if gender_bonus[i] != 0.0
				BonusTraitsArray[i] = Random3GenderBonus(gender_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" Male "+__traitNames[i]+" "+gender_bonus[i])
				endif
			else
				BonusTraitsArray[i] = 0.0
			endif
			i += 1
		endwhile
	endif

	; Type bonus
	if akTarget.HasKeywordString("ActorTypeAnimal")
		float[] type_bonus = GetTraitBonus("Animal")
		int i = 0
		while i < BonusTraitsArray.length && i < type_bonus.length && i < __traitNames.length
			if type_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3RaceBonus(type_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" Animal "+__traitNames[i]+" "+type_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif
	if akTarget.HasKeywordString("ActorTypeCreature")
		float[] type_bonus = GetTraitBonus("Creature")
		int i = 0
		while i < BonusTraitsArray.length && i < type_bonus.length && i < __traitNames.length
			if type_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3RaceBonus(type_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" Creature "+__traitNames[i]+" "+type_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif
	if akTarget.HasKeywordString("ActorTypeUndead")
		float[] type_bonus = GetTraitBonus("Undead")
		int i = 0
		while i < BonusTraitsArray.length && i < type_bonus.length && i < __traitNames.length
			if type_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3RaceBonus(type_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" Undead "+__traitNames[i]+" "+type_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif

	; Player Bonus
	if akTarget == PlayerRef
		float[] player_bonus = GetTraitBonus("Player")
		int i = 0
		while i < BonusTraitsArray.length && i < player_bonus.length && i < __traitNames.length
			if player_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3Bonus(player_bonus[i])
				if printActorBonusesToggle 
					LogTrace("GetTraitBonusForActor "+i+" Player "+__traitNames[i]+" "+player_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif
	
	; Age bonuses
	; Studies showed honesty going up with age after 14 yo
	; Emotionality goes down
	; Extraversion and Agreeableness goes down for middle-age than up for olders
	; Conscientiousness and Openness showed upward age trends	
	if IsElder(raceString)
		float[] age_bonus = GetTraitBonus("Elder")
		int i = 0
		while i < BonusTraitsArray.length && i < age_bonus.length && i < __traitNames.length
			if age_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3AgeBonus(age_bonus[i])
				if printActorBonusesToggle 
					LogTrace("GetTraitBonusForActor "+i+" Elder "+__traitNames[i]+" "+age_bonus[i])
				endif
			endif
			i += 1
		endwhile
	elseif IsYoungAdult(raceString)
		float[] age_bonus = GetTraitBonus("YoungAdult")
		int i = 0
		while i < BonusTraitsArray.length && i < age_bonus.length && i < __traitNames.length
			if age_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3AgeBonus(age_bonus[i])
				if printActorBonusesToggle 
					LogTrace("GetTraitBonusForActor "+i+" YoungAdult "+__traitNames[i]+" "+age_bonus[i])
				endif
			endif
			i += 1
		endwhile
	elseif IsChild(raceString)
		float[] age_bonus = GetTraitBonus("Child")
		int i = 0
		while i < BonusTraitsArray.length && i < age_bonus.length && i < __traitNames.length
			if age_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3AgeBonus(age_bonus[i])
				if printActorBonusesToggle 
					LogTrace("GetTraitBonusForActor "+i+" Child "+__traitNames[i]+" "+age_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif
	
	; Race bonus
	int j = 0
	while j < __raceNames.length
		string raceName = __raceNames[j]
		if(stringUtil.find(raceString,raceName)>=0)
			float[] race_bonus = GetTraitBonus(raceName)
			int i = 0
			while i < BonusTraitsArray.length && i < race_bonus.length && i < __traitNames.length
				if race_bonus[i] != 0.0
					BonusTraitsArray[i] = BonusTraitsArray[i] + Random3RaceBonus(race_bonus[i])
					if printActorBonusesToggle
						LogTrace("GetTraitBonusForActor "+i+" race="+raceName+" "+__traitNames[i]+" "+race_bonus[i])
					endif
				endif
				i += 1
			endwhile
		endif
		j += 1
	endwhile
	
	; Place bonus
	int iplace = GetPlaceOfOriginIndex(akTarget) ; set faction rank if needed
	string placeName = DOM04.GetPlaceOfOriginName(akTarget)
	;LogTrace("GetTraitBonusForActor place="+placeName)
	if placeName != ""
		float[] place_bonus = GetTraitBonus(placeName)
		int i = 0
		while i < BonusTraitsArray.length && i < place_bonus.length && i < __traitNames.length
			if place_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3PlaceBonus(place_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" place="+placeName+" "+__traitNames[i]+" "+place_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif

	; Job bonus
	int ijob = GetJobOfOriginIndex(akTarget) ; set faction rank if needed
	string jobName = DOM04.GetJobOfOriginName(akTarget)
	;LogTrace("GetTraitBonusForActor job="+jobName)
	if jobName != ""
		float[] job_bonus = GetTraitBonus(jobName)
		int i = 0
		while i < BonusTraitsArray.length && i < job_bonus.length && i < __traitNames.length
			if job_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3JobBonus(job_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" job="+jobName+" "+__traitNames[i]+" "+job_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif

	; Employer bonus
	int iemployer = GetEmployerOfOriginIndex(akTarget) ; set faction rank if needed
	string employerName = DOM04.GetEmployerOfOriginName(akTarget)
	;LogTrace("GetTraitBonusForActor employer="+employerName)
	if employerName != ""
		float[] employer_bonus = GetTraitBonus(employerName)
		int i = 0
		while i < BonusTraitsArray.length && i < employer_bonus.length && i < __traitNames.length
			if employer_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3JobBonus(employer_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" employer="+employerName+" "+__traitNames[i]+" "+employer_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif

	; Trainer bonus
	int itrainer = GetTrainerOfOriginIndex(akTarget) ; set faction rank if needed
	string trainerName = DOM04.GetTrainerOfOriginName(akTarget)
	;LogTrace("GetTraitBonusForActor trainer="+trainerName)
	if trainerName != ""
		float[] trainer_bonus = GetTraitBonus(trainerName)
		int i = 0
		while i < BonusTraitsArray.length && i < trainer_bonus.length && i < __traitNames.length
			if trainer_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3ClassBonus(trainer_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" skill="+trainerName+" "+__traitNames[i]+" "+trainer_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif

	; Class bonus
	int iclass = GetClassOfOriginIndex(akTarget) ; set faction rank if needed
	string className = DOM04.GetClassOfOriginName(akTarget)
	;LogTrace("GetTraitBonusForActor class="+className)
	if className != ""
		float[] class_bonus = GetTraitBonus(className)
		int i = 0
		while i < BonusTraitsArray.length && i < class_bonus.length && i < __traitNames.length
			if class_bonus[i] != 0.0
				BonusTraitsArray[i] = BonusTraitsArray[i] + Random3ClassBonus(class_bonus[i])
				if printActorBonusesToggle
					LogTrace("GetTraitBonusForActor "+i+" class="+className+" "+__traitNames[i]+" "+class_bonus[i])
				endif
			endif
			i += 1
		endwhile
	endif

	;PrintTraits("GetTraitBonusForActor "+akTarget.GetDisplaYname()+" Bonus",BonusTraitsArray)
	return BonusTraitsArray
EndFunction

float Function Random3GenderBonus(float x) ; 0 to 2 times x
	float r = (RandomUniform()+RandomUniform()+RandomUniform())/3.0*2.0*x
	return r*DOM01.trait_gender_bonus;
EndFunction

float Function Random3RaceBonus(float x) ; 0 to 2 times x
	float r = (RandomUniform()+RandomUniform()+RandomUniform())/3.0*2.0*x
	return r*DOM01.trait_race_bonus;
EndFunction

float Function Random3AgeBonus(float x) ; 0 to 2 times x
	float r = (RandomUniform()+RandomUniform()+RandomUniform())/3.0*2.0*x
	return r*DOM01.trait_age_bonus;
EndFunction

float Function Random3JobBonus(float x) ; 0 to 2 times x
	float r = (RandomUniform()+RandomUniform()+RandomUniform())/3.0*2.0*x
	return r*DOM01.trait_job_bonus;
EndFunction

float Function Random3ClassBonus(float x) ; 0 to 2 times x
	float r = (RandomUniform()+RandomUniform()+RandomUniform())/3.0*2.0*x
	return r*DOM01.trait_class_bonus;
EndFunction

float Function Random3PlaceBonus(float x) ; 0 to 2 times x
	float r = (RandomUniform()+RandomUniform()+RandomUniform())/3.0*2.0*x
	return r*DOM01.trait_place_bonus;
EndFunction

float Function Random3Bonus(float x) ; 0 to 2 times x
	float r = (RandomUniform()+RandomUniform()+RandomUniform())/3.0*2.0*x
	return r;
EndFunction

; Local seed for Random Functions

int seed = 0

; Random generator using fixed seed

float Function RandomTriangle()
	float r = 50.0*(RandomUniform()+RandomUniform())
	return r;
EndFunction

float Function Random3N() ; -1 to 101
	float r
	if DOM01.RandomFlat
		r = 102.0*(RandomUniform())-(1.0)
	else
		r = 34.0*(RandomUniform()+RandomUniform()+RandomUniform())-(1.0)
	endif
	return r;
EndFunction

float Function Random3P(float x) ; 0 to 2 times x
	float r = (RandomUniform()+RandomUniform()+RandomUniform())/3.0*2.0*x
	return r;
EndFunction

float Function RandomGaussianApprox()
	float r = 25.0*(RandomUniform()+RandomUniform()+RandomUniform()+RandomUniform())
	return r;
EndFunction

float Function RandomFlat()
	float r = RandomUniform()
	return r;
EndFunction

float Function RandomUniform()
  ;seed = (1103515245 * seed + 12345) % 2147483648 ;
  seed = (0x41C64E6D * seed + 12345) % 0x80000000 ;
  float r = math.abs((seed as float)/ 2147483648.0 );
  return r;
EndFunction

; Traits and feelings generation using local seed
Function SetNPCTraitsUpdateModifiers(Actor akTarget, float[] TraitsArray)
	SetNPCTraits(akTarget,TraitsArray)
	UpdateNPCModifiers(akTarget,TraitsArray)
EndFunction

Function SetNPCTraits(Actor akTarget, float[] TraitsArray)
	;LogTrace("SetNPCTraits "+akTarget.GetDisplayName())
	; first check boundaries
	int i = 0
	while i < 12
		if TraitsArray[i] < 0.0
			TraitsArray[i] = 0.0
		elseif TraitsArray[i] > 100.0
			TraitsArray[i] = 100.0
		endif
		i += 1
	endwhile
	
	akTarget.setFactionRank(DOMTraitHonesty,           TraitsArray[0] as int)
	akTarget.setFactionRank(DOMTraitEmotionality,      TraitsArray[1] as int)
	akTarget.setFactionRank(DOMTraitExtraversion,      TraitsArray[2] as int)
	akTarget.setFactionRank(DOMTraitAgreeableness,     TraitsArray[3] as int)
	akTarget.setFactionRank(DOMTraitConscientiousness, TraitsArray[4] as int)
	akTarget.setFactionRank(DOMTraitOpenness,          TraitsArray[5] as int)

	akTarget.setFactionRank(DOMFacetWilfulness,        TraitsArray[6] as int)
	akTarget.setFactionRank(DOMFacetToughness,         TraitsArray[7] as int)
	akTarget.setFactionRank(DOMFacetSensuality,        TraitsArray[8] as int)
	akTarget.setFactionRank(DOMFacetSubmissivity,      TraitsArray[9] as int)
	akTarget.setFactionRank(DOMFacetBoldness,          TraitsArray[10] as int)
	akTarget.setFactionRank(DOMFacetSmartness,         TraitsArray[11] as int)
EndFunction

Function SetNPCFeelings(Actor akTarget, float[] FeelsArray)
	; first check boundaries
	int i = 0
	while i < 6
		if FeelsArray[i] < 0.0
			FeelsArray[i] = 0.0
		elseif FeelsArray[i] > 100.0
			FeelsArray[i] = 100.0
		endif
		i += 1
	endwhile
	
	akTarget.setFactionRank(DOMFeelSubmission,         FeelsArray[0] as int)
	akTarget.setFactionRank(DOMFeelFear,               FeelsArray[1] as int)
	akTarget.setFactionRank(DOMFeelHumiliation,        FeelsArray[2] as int)
	akTarget.setFactionRank(DOMFeelAnger,    		   FeelsArray[3] as int)
	akTarget.setFactionRank(DOMFeelResignation, 	   FeelsArray[4] as int)
	akTarget.setFactionRank(DOMFeelRespect,            FeelsArray[5] as int)
EndFunction

float[] Function GetFactionFeelings(Actor akTarget)
	;LogTrace("GetFactionFeelings: "+akTarget.getDisplayName()+" "+akTarget)
	float[] FeelsArray = new float[6]
	
	FeelsArray[0] = akTarget.GetFactionRank(DOMFeelSubmission)
	FeelsArray[1] = akTarget.GetFactionRank(DOMFeelFear)
	FeelsArray[2] = akTarget.GetFactionRank(DOMFeelHumiliation)
	FeelsArray[3] = akTarget.GetFactionRank(DOMFeelAnger)
	FeelsArray[4] = akTarget.GetFactionRank(DOMFeelResignation)
	FeelsArray[5] = akTarget.GetFactionRank(DOMFeelRespect)
	;;LogTrace("GetFactionFeelings end: "+akTarget.getDisplayName())

	return FeelsArray
EndFunction

Function CheckPotentialSlaverFaction(Actor akTarget, float [] TraitsArray)
	if akTarget.getFactionRank(DOMPotentialSlaverFaction) == 1 && !akTarget.IsInFaction(DOM01.DOMActorFaction)
		return ; already Set
	endif
	; Check for potential Slaver faction
	; As a general rules low honest personalities make the best henchman
	; Personalities siding with bullies:  -honest -open
	;LogTrace("CheckPotentialSlaverFaction: "+akTarget.GetDisplayName()+" honesty="+TraitsArray[0]+" openness="+TraitsArray[5])
	Actor akPlayer = Game.GetPlayer()
	if akTarget.GetRelationshipRank(akPlayer) >= 4
		akTarget.setFactionRank(DOMPotentialSlaverFaction, 1)
	elseif akTarget.IsInFaction(DOMMoodInLove) || akTarget.IsInFaction(DOMMoodLoyal)
		if akTarget.getFactionRank(DOMTrainSubmission) > 70 && akTarget.getFactionRank(DOMTrainRespect) > 70 && akTarget.getFactionRank(DOMTrainResignation) > 70
			akTarget.setFactionRank(DOMPotentialSlaverFaction, 1)
		else
			akTarget.removeFromFaction(DOMPotentialSlaverFaction)
		endif
	elseif (TraitsArray[0] < 34.0 && TraitsArray[5] < 50.0)
		float mod_ins = GetModifierFromFaction(akTarget,DOMModInsensitivity)
		float rank = (150.0-TraitsArray[0]*2.0-TraitsArray[5]+(mod_ins-(100.0)))/2.0 ; max is 275.0
		float MODEnforcer = DOM01.GetEnforcerModifier(PlayerRef)
		if MODEnforcer > 0.1
			rank = rank / MODEnforcer
		else
			rank = rank * 10.0
		endif
		;LogTrace("CheckPotentialSlaverFaction: "+akTarget.GetDisplayName()+" honesty="+TraitsArray[0]+" openness="+TraitsArray[5]+" insensitivity="+mod_ins+" rank="+rank)
		if rank > 127.0
			rank = 127.0
		elseif rank < 1.0
			akTarget.removeFromFaction(DOMPotentialSlaverFaction)
		else
			akTarget.setFactionRank(DOMPotentialSlaverFaction, (rank as int))
		endif
	elseif akTarget.IsInFaction(DOMPotentialSlaverFaction)
		akTarget.removeFromFaction(DOMPotentialSlaverFaction)
	endif
	;LogTrace("Checking Slaver potential for "+akTarget.getDisplayName()+" honest="+TraitsArray[0]+" open="+TraitsArray[5]+" rank="+akTarget.getFactionRank(DOMPotentialSlaverFaction))
EndFunction

Function SetNPCModifiers(Actor akTarget, float[] ModsArray)
	; first check boundaries
	int i = 0
	while i < ModsArray.length
		if ModsArray[i] < 0.0
			ModsArray[i] = 0.0
		elseif ModsArray[i] > 5.0
			ModsArray[i] = 5.0
		endif
		i += 1
	endwhile

	; Main training stat modifier
	SetModifierFromFaction(akTarget,DOMModHumility,      (ModsArray[0]))  ; +Honesty
	SetModifierFromFaction(akTarget,DOMModFearfulness,   (ModsArray[1]))  ; +Emotionality
	SetModifierFromFaction(akTarget,DOMModNaivety,       (ModsArray[2]))  ; -eXtraversion
	SetModifierFromFaction(akTarget,DOMModForgiveness,   (ModsArray[3]))  ; +Agreeableness
	SetModifierFromFaction(akTarget,DOMModPrudent,       (ModsArray[4]))  ; +Conscientiousness
	SetModifierFromFaction(akTarget,DOMModDiscipline,    (ModsArray[5]))  ; -Openness

	; Skill modifier
	SetModifierFromFaction(akTarget,DOMModInsensitivity, (ModsArray[6]))  ; -Honesty
	SetModifierFromFaction(akTarget,DOMModIntimidate,    (ModsArray[7]))  ; +Emotionality/-Honesty
	SetModifierFromFaction(akTarget,DOMModSelfEsteem,    (ModsArray[8]))  ; +eXtraversion
	SetModifierFromFaction(akTarget,DOMModResentment,    (ModsArray[9]))  ; -Agreeableness
	SetModifierFromFaction(akTarget,DOMModController,    (ModsArray[10])) ; +Conscientiousness/-Honesty
	SetModifierFromFaction(akTarget,DOMModPretender,     (ModsArray[11])) ; +Openness/-Honesty

	; Secondary training stat modifier
	SetModifierFromFaction(akTarget,DOMModVaginal,       (ModsArray[12])) ; +Honesty/+Agreeableness
	SetModifierFromFaction(akTarget,DOMModAnal,          (ModsArray[13])) ; +Emotionality/-Openness
	SetModifierFromFaction(akTarget,DOMModOral,          (ModsArray[14])) ; -eXtraversion/+Conscientiousness
	SetModifierFromFaction(akTarget,DOMModFlexibility,   (ModsArray[15])) ; +Agreeableness
	SetModifierFromFaction(akTarget,DOMModPerfectionism, (ModsArray[16])) ; +Conscientiousness/-Honest
	SetModifierFromFaction(akTarget,DOMModAuthority,     (ModsArray[17])) ; +Openness
	
	; Abuse modifier
	SetModifierFromFaction(akTarget,DOMModCriminality,   (ModsArray[18])) ; -Honesty
	SetModifierFromFaction(akTarget,DOMModSentimentality,(ModsArray[19])) ; +Emotionality
	SetModifierFromFaction(akTarget,DOMModDaring,        (ModsArray[20])) ; +eXtraversion
	SetModifierFromFaction(akTarget,DOMModImpatience,    (ModsArray[21])) ; -Agreeableness
	SetModifierFromFaction(akTarget,DOMModDiligent,      (ModsArray[22])) ; +Conscientiousness
	SetModifierFromFaction(akTarget,DOMModManipulation,  (ModsArray[23])) ; +Openness

	; Love stat modifier
	SetModifierFromFaction(akTarget,DOMModModesty,       (ModsArray[24])) ; -Honesty
	SetModifierFromFaction(akTarget,DOMModDependence,    (ModsArray[25])) ; +Emotionality
	SetModifierFromFaction(akTarget,DOMModIngenuity,     (ModsArray[26])) ; +eXtraversion
	SetModifierFromFaction(akTarget,DOMModGentleness,    (ModsArray[27])) ; -Agreeableness
	SetModifierFromFaction(akTarget,DOMModConsideration, (ModsArray[28])) ; +Conscientiousness
	SetModifierFromFaction(akTarget,DOMModCreativity,    (ModsArray[29])) ; +Openness

	SetModifierFromFaction(akTarget,DOMModCombat,        (ModsArray[30])) ; All facets
	
	; Feelings
	float[] FeelsArray = new float[6]  
	FeelsArray[0] = ModsArray[0]*100.0 ; Humility
	FeelsArray[1] = ModsArray[1]*100.0 ; Fearfulness
	FeelsArray[2] = ModsArray[2]*100.0 ; Naivety
	FeelsArray[3] = ModsArray[3]*100.0 ; Forgiveness
	FeelsArray[4] = ModsArray[4]*100.0 ; Prudent
	FeelsArray[5] = ModsArray[5]*100.0 ; Discipline
	SetNPCFeelings(akTarget,FeelsArray)
EndFunction

Function PrintModifiers(Actor akTarget)
	if DOM01.verboseMode == false
		return
	endif
	
	;LogTrace(akTarget.getDisplayName()+" Personality traits")
	;LogTrace(akTarget.getDisplayName()+"   honesty      = "+akTarget.GetFactionRank(DOMTraitHonesty))
	;LogTrace(akTarget.getDisplayName()+"   anxious      = "+akTarget.GetFactionRank(DOMTraitEmotionality))
	;LogTrace(akTarget.getDisplayName()+"   lively       = "+akTarget.GetFactionRank(DOMTraitExtraversion))
	;LogTrace(akTarget.getDisplayName()+"   gentle       = "+akTarget.GetFactionRank(DOMTraitAgreeableness))
	;LogTrace(akTarget.getDisplayName()+"   conscientious= "+akTarget.GetFactionRank(DOMTraitConscientiousness))
	;LogTrace(akTarget.getDisplayName()+"   open minded  = "+akTarget.GetFactionRank(DOMTraitOpenness))
	;LogTrace(akTarget.getDisplayName()+"   bold         = "+akTarget.GetFactionRank(DOMFacetBoldness))
	;LogTrace(akTarget.getDisplayName()+"   wilful       = "+akTarget.GetFactionRank(DOMFacetWilfulness))
	;LogTrace(akTarget.getDisplayName()+"   smart        = "+akTarget.GetFactionRank(DOMFacetSmartness))
	;LogTrace(akTarget.getDisplayName()+"   sensual      = "+akTarget.GetFactionRank(DOMFacetSensuality))
	;LogTrace(akTarget.getDisplayName()+"   tough        = "+akTarget.GetFactionRank(DOMFacetToughness))
	;LogTrace(akTarget.getDisplayName()+"   DOM/sub      = "+akTarget.GetFactionRank(DOMFacetSubmissivity))
	
	;LogTrace(akTarget.getDisplayName()+" Main modifiers")
	;LogTrace(akTarget.getDisplayName()+"   pain         = "+GetModifierFromFaction(akTarget,DOMModHumility))
	;LogTrace(akTarget.getDisplayName()+"   fear         = "+GetModifierFromFaction(akTarget,DOMModFearfulness))
	;LogTrace(akTarget.getDisplayName()+"   shame        = "+GetModifierFromFaction(akTarget,DOMModNaivety))
	;LogTrace(akTarget.getDisplayName()+"   anger        = "+GetModifierFromFaction(akTarget,DOMModForgiveness))
	;LogTrace(akTarget.getDisplayName()+"   sorrow       = "+GetModifierFromFaction(akTarget,DOMModPrudent))
	;LogTrace(akTarget.getDisplayName()+"   discipline   = "+GetModifierFromFaction(akTarget,DOMModDiscipline))

	;LogTrace(akTarget.getDisplayName()+"   criminality  = "+GetModifierFromFaction(akTarget,DOMModCriminality))
	;LogTrace(akTarget.getDisplayName()+"   insensitivity= "+GetModifierFromFaction(akTarget,DOMModInsensitivity))
	;LogTrace(akTarget.getDisplayName()+"   combativity  = "+GetModifierFromFaction(akTarget,DOMModDiligent))
	;LogTrace(akTarget.getDisplayName()+"   self-esteem  = "+GetModifierFromFaction(akTarget,DOMModSelfEsteem))
	;LogTrace(akTarget.getDisplayName()+"   daring       = "+GetModifierFromFaction(akTarget,DOMModDaring))
	;LogTrace(akTarget.getDisplayName()+"   stress       = "+GetModifierFromFaction(akTarget,DOMModImpatience))
	;LogTrace(akTarget.getDisplayName()+"   pose         = "+GetModifierFromFaction(akTarget,DOMModFlexibility))
	;LogTrace(akTarget.getDisplayName()+"   work         = "+GetModifierFromFaction(akTarget,DOMModAuthority))
	;LogTrace(akTarget.getDisplayName()+"   combat       = "+GetModifierFromFaction(akTarget,DOMModCombat))
	;LogTrace(akTarget.getDisplayName()+"   house        = "+GetModifierFromFaction(akTarget,DOMModPerfectionism))
	;LogTrace(akTarget.getDisplayName()+"   trainer      = "+GetModifierFromFaction(akTarget,DOMModTrainer))
	;LogTrace(akTarget.getDisplayName()+"   crime master = "+GetModifierFromFaction(akTarget,DOMModCrimelord))

	;LogTrace(akTarget.getDisplayName()+"   oral         = "+GetModifierFromFaction(akTarget,DOMModOral))
	;LogTrace(akTarget.getDisplayName()+"   vaginal      = "+GetModifierFromFaction(akTarget,DOMModVaginal))
	;LogTrace(akTarget.getDisplayName()+"   anal         = "+GetModifierFromFaction(akTarget,DOMModAnal))
EndFunction

Function SetNPCDefaultStat(Actor akTarget, Faction akFaction)
	if !akTarget.IsInFaction(akFaction)
		akTarget.SetFactionRank(akFaction,0)
	endif
EndFunction

Function SetNPCDefaultTraining(Actor akTarget)
	SetNPCDefaultStat(akTarget,DOMTrainSubmission)
	SetNPCDefaultStat(akTarget,DOMTrainHumiliation)
	SetNPCDefaultStat(akTarget,DOMTrainResignation)
	SetNPCDefaultStat(akTarget,DOMTrainFear)
	SetNPCDefaultStat(akTarget,DOMTrainAnger)
	SetNPCDefaultStat(akTarget,DOMTrainRespect)
	
	SetNPCDefaultStat(akTarget,DOMTrainPose) 
	SetNPCDefaultStat(akTarget,DOMTrainOral)
	SetNPCDefaultStat(akTarget,DOMTrainVaginal)
	SetNPCDefaultStat(akTarget,DOMTrainAnal)
	SetNPCDefaultStat(akTarget,DOMTrainCombat)
	SetNPCDefaultStat(akTarget,DOMTrainHouse)
	SetNPCDefaultStat(akTarget,DOMTrainWorking)
	SetNPCDefaultStat(akTarget,DOMTraumaInDays)
EndFunction

Function PrintTraining(Actor akTarget)
	if DOM01.verboseMode == false
		return
	endif
	
	LogTrace(akTarget.getDisplayName()+" Training stats")
	LogTrace(akTarget.getDisplayName()+"   submission   = "+akTarget.GetFactionRank(DOMTrainSubmission))
	LogTrace(akTarget.getDisplayName()+"   fear         = "+akTarget.GetFactionRank(DOMTrainFear))
	LogTrace(akTarget.getDisplayName()+"   humiliation  = "+akTarget.GetFactionRank(DOMTrainHumiliation))
	LogTrace(akTarget.getDisplayName()+"   anger        = "+akTarget.GetFactionRank(DOMTrainAnger))
	LogTrace(akTarget.getDisplayName()+"   resignation  = "+akTarget.GetFactionRank(DOMTrainResignation))
	LogTrace(akTarget.getDisplayName()+"   respect      = "+akTarget.GetFactionRank(DOMTrainRespect))
	
	LogTrace(akTarget.getDisplayName()+"   combat       = "+GetFactionRankFloat(akTarget,DOMTrainCombat))
	LogTrace(akTarget.getDisplayName()+"   pose         = "+akTarget.GetFactionRank(DOMTrainPose))
	LogTrace(akTarget.getDisplayName()+"   house        = "+akTarget.GetFactionRank(DOMTrainHouse))
	LogTrace(akTarget.getDisplayName()+"   work         = "+akTarget.GetFactionRank(DOMTrainWorking))
	LogTrace(akTarget.getDisplayName()+"   trauma       = "+akTarget.GetFactionRank(DOMTraumaInDays))
	LogTrace(akTarget.getDisplayName()+"   vaginal      = "+akTarget.GetFactionRank(DOMTrainVaginal))
	LogTrace(akTarget.getDisplayName()+"   oral         = "+akTarget.GetFactionRank(DOMTrainOral))
	LogTrace(akTarget.getDisplayName()+"   anal         = "+akTarget.GetFactionRank(DOMTrainAnal))
	LogTrace(akTarget.getDisplayName()+"   sex (total)  = "+akTarget.GetFactionRank(DOMTrainSex))

	LogTrace(akTarget.getDisplayName()+"   enforcer     = "+akTarget.GetFactionRank(DOMSkillEnforcer))
	LogTrace(akTarget.getDisplayName()+"   persuader    = "+akTarget.GetFactionRank(DOMSkillPersuader))
	LogTrace(akTarget.getDisplayName()+"   depraver     = "+akTarget.GetFactionRank(DOMSkillDepraver))
	LogTrace(akTarget.getDisplayName()+"   predator     = "+akTarget.GetFactionRank(DOMSkillPredator))
	LogTrace(akTarget.getDisplayName()+"   slaver       = "+akTarget.GetFactionRank(DOMSkillSlaver))
	LogTrace(akTarget.getDisplayName()+"   deceiver     = "+akTarget.GetFactionRank(DOMSkillDeceiver))
EndFunction

Function UpdateNPCModifiers(Actor akTarget, float[] TraitsArray)
	float[] ModsArray = new float[31]

	ModsArray[0]  = GetDefaultModifierHumility(1.0,TraitsArray)
	ModsArray[1]  = GetDefaultModifierFearfulness(1.0,TraitsArray)
	ModsArray[2]  = GetDefaultModifierNaivety(1.0,TraitsArray)
	ModsArray[3]  = getDefaultModiferForgiveness(1.0,TraitsArray)
	ModsArray[4]  = GetDefaultModifierPrudent(1.0,TraitsArray)
	ModsArray[5]  = GetDefaultModifierDiscipline(1.0,TraitsArray)
	
	ModsArray[6]  = GetDefaultModifierInsensitivity(1.0,TraitsArray)
	ModsArray[7]  = GetDefaultModifierIntimidate(1.0,TraitsArray)
	ModsArray[8]  = GetDefaultModifierSelfEsteem(1.0,TraitsArray)
	ModsArray[9]  = GetDefaultModifierResentment(1.0,TraitsArray)
	ModsArray[10] = GetDefaultModifierController(1.0,TraitsArray)
	ModsArray[11] = GetDefaultModifierPretender(1.0,TraitsArray)

	ModsArray[12]  = GetDefaultModifierVaginal(1.0,TraitsArray)
	ModsArray[13]  = GetDefaultModifierAnal(1.0,TraitsArray)
	ModsArray[14]  = GetDefaultModifierOral(1.0,TraitsArray)
	ModsArray[15] = GetDefaultModifierFlexibility(1.0,TraitsArray)
	ModsArray[16] = GetDefaultModifierPerfectionism(1.0,TraitsArray)
	ModsArray[17] = getDefaultModifierAuthority(1.0,TraitsArray)
	
	ModsArray[18] = getDefaultModifierCriminality(1.0,TraitsArray)
	ModsArray[19] = getDefaultModifierSentimentality(1.0,TraitsArray)
	ModsArray[20] = getDefaultModifierDaring(1.0,TraitsArray)
	ModsArray[21] = getDefaultModifierImpatience(1.0,TraitsArray)
	ModsArray[22] = GetDefaultModifierDiligent(1.0,TraitsArray)
	ModsArray[23] = GetDefaultModifierManipulation(1.0,TraitsArray)

	ModsArray[24] = getDefaultModifierModesty(1.0,TraitsArray)
	ModsArray[25] = getDefaultModifierDependence(1.0,TraitsArray)
	ModsArray[26] = getDefaultModifierIngenuity(1.0,TraitsArray)
	ModsArray[27] = getDefaultModifierGentleness(1.0,TraitsArray)
	ModsArray[28] = GetDefaultModifierConsideration(1.0,TraitsArray)
	ModsArray[29] = GetDefaultModifierCreativity(1.0,TraitsArray)

	ModsArray[30] = getDefaultModifierCombat(1.0,TraitsArray)

	SetNPCModifiers(akTarget, ModsArray)
EndFunction

float[] Function GetNPCTraits(Actor akTarget)
	float[] TraitsArray
	if akTarget == NONE
		return TraitsArray
	endif
	; If traits are saved in factions return ranks
	; else generate traits and save in factions
	if akTarget.isInFaction(DOMHasPersonality)
		int rank = akTarget.GetFactionRank(DOMHasPersonality)
		if rank == 0 ; being generated
			int i = 0
			while i < 10 && rank == 0 ; try to wait up to 10 seconds
				Wait(1.0)
				rank = akTarget.GetFactionRank(DOMHasPersonality)
				i += 1
			endwhile 
			if i >= 10 ; if more than 10 seconds, forget it
				akTarget.setFactionRank(DOMHasPersonality,1)
			endif
		endif
		return GetTraitsFromFactions(akTarget)
	endif
	akTarget.SetFactionRank(DOMHasPersonality,0)
	LogTrace("GetNPCTraits: START "+akTarget.getDisplayName()+" "+akTarget+" HasPersonality="+akTarget.GetFactionRank(DOMHasPersonality))
	bool is_unique = akTarget.GetLeveledActorBase().IsUnique()
	if is_unique && !readJSONForUniques
		TraitsArray = GetPersonalityFromFactionOrGenerated(akTarget)
	elseif !is_unique && !readJSONForSpawned
		TraitsArray = GetPersonalityFromFactionOrGenerated(akTarget)
	else
		TraitsArray = GetPersonalityFromFactionOrReadOrGenerated(akTarget)
		; includes SetNPCTraits
	endif
	;LogTrace("GetNPCTraits: DONE "+akTarget.getDisplayName()+" "+akTarget+" hasDOMHasPersonality="+akTarget.GetFactionRank(DOMHasPersonality))
	return TraitsArray
EndFunction

float[] Function GetNPCTraitsUpdateModifiers(Actor akTarget)
	; If traits are saved in factions return ranks and also get modifier values in factions
	; else generate traits but do not save in factions - this is on purpose
	;LogTrace("GetNPCTraitsUpdateModifiers: "+akTarget.getDisplayName()+" "+akTarget)
	float[] TraitsArray = GetNPCTraits(akTarget)
	UpdateNPCModifiers(akTarget, TraitsArray)
	CheckPotentialSlaverFaction(akTarget, TraitsArray)
	
	return TraitsArray
EndFunction

string Function OpenActorJSON(Actor akRef)
	actorBase abTarget = akRef.GetLeveledActorBase()
	string nameString = akRef.GetDisplayName()
	if nameString == ""
		nameString = abTarget.GetName()
	endif
	int formID = Math.LogicalAnd(abTarget.GetFormID(), 0x00FFFFFF)
	String IDstr = DOM_Util.ConvertIDToHex(formID)
	String fileName = ""
	string playerName = PlayerRef.GetDisplayName()
	if playerName != ""
		fileName = "Diary Of Mine/" + playerName + "/" + IDstr + "_"+ nameString + ".json"
		if JsonUtil.JsonExists(fileName)
			;LogTrace("OpenActorJSON: Found JSON file: "+fileName)
			return fileName
		endif
		fileName = "Diary Of Mine/" + playerName + "/" + IDstr +".json"
		if JsonUtil.JsonExists(fileName)
			;LogTrace("OpenActorJSON: Found JSON file: "+fileName)
			return fileName
		endif
	endif
	fileName = "Diary Of Mine/" + IDstr + "_"+ nameString + ".json"
	if JsonUtil.JsonExists(fileName)
		;LogTrace("OpenActorJSON: Found JSON file: "+fileName)
		return fileName
	endif
	fileName = "Diary Of Mine/" + IDstr +".json"
	if JsonUtil.JsonExists(fileName)
		;LogTrace("OpenActorJSON: Found JSON file: "+fileName)
		return fileName
	endif
	LogTrace("OpenActorJSON: JSON file NOT FOUND: "+fileName)
	return ""
EndFunction


float[] Function GetPersonalityFromFactionOrGenerated(Actor akTarget)
	;LogTrace("GetPersonalityFromFactionOrGenerated "+akTarget.GetDisplayName())
	; Get default traits from factions or generate (in this order) ignore file
	float[] TraitsArray = GetTraitsFromFactionOrGenerated(akTarget)	
	SetNPCTraits(akTarget, TraitsArray)
	akTarget.SetFactionRank(DOMHasPersonality,1)

	; Force factions or generate
	int[] vstatus = GetVirginStatusGenerated(akTarget)	
	SetVirginStatus(akTarget, vstatus)
	
	; Recover PAH training
	DOMPAH.CheckTrainingFactions(akTarget)	
	
	; Recover Kinks
	; GetActorKinks(akTarget) ; nothing to do as already in factions

	return TraitsArray
EndFunction

float[] Function GetPersonalityFromFactionOrReadOrGenerated(Actor akTarget)
	;LogTrace("GetPersonalityFromFactionOrReadOrGenerated "+akTarget.GetDisplayName())
	; Check if file exists
	string fileName = OpenActorJSON(akTarget)
	; Fixed values from JSON files for choosen NPC
	if fileName == "" || !JsonUtil.JsonExists(fileName)
		; file doesn't exist revert to not reading file
		return GetPersonalityFromFactionOrGenerated(akTarget)
	endif
	
	; Get default traits from faction or file or generate (in this order) 
	float[] TraitsArray = GetTraitsFromFactionOrReadOrGenerated(akTarget)	
	SetNPCTraits(akTarget, TraitsArray)
	akTarget.SetFactionRank(DOMHasPersonality,1)

	; Force reading or generate
	int[] vstatus = GetVirginStatusReadOrGenerated(akTarget)	
	SetVirginStatus(akTarget, vstatus)
	
	; Recover Training first from faction then from file
	GetTrainingStatsFromFactionsOrRead(akTarget)
	
	; Recover Kinks
	GetActorKinksRead(akTarget)

	return TraitsArray
EndFunction

float[] Function GetPersonalityGenerated(Actor akTarget)
	LogTrace("GetPersonalityGenerated "+akTarget.GetDisplayName())

	; Get default traits generated (in this order) ignore factions and file
	float[] TraitsArray = GetTraitsGenerated(akTarget)	
	SetNPCTraits(akTarget, TraitsArray)
	akTarget.SetFactionRank(DOMHasPersonality,1)

	; Force reading or generate
	int[] vstatus = GetVirginStatusGenerated(akTarget)	
	SetVirginStatus(akTarget, vstatus)
	
	; Recover PAH training
	DOMPAH.CheckTrainingFactions(akTarget)	
	
	; Recover Kinks
	;GetActorKinks(akTarget)

	return TraitsArray
EndFunction

float[] Function GetPersonalityReadOrGenerated(Actor akTarget)
	LogTrace("GetPersonalityReadOrGenerated "+akTarget.GetDisplayName())
	; Check if file exists
	string fileName = OpenActorJSON(akTarget)
	; Fixed values from JSON files for choosen NPC
	if fileName == "" || !JsonUtil.JsonExists(fileName)
		return GetPersonalityGenerated(akTarget)
	endif

	; Get default traits from file or generate (in this order) ignore factions
	float[] TraitsArray = GetTraitsReadOrGenerated(akTarget)	
	SetNPCTraits(akTarget, TraitsArray)
	akTarget.SetFactionRank(DOMHasPersonality,1)

	; Force reading or generate
	int[] vstatus = GetVirginStatusReadOrGenerated(akTarget)	
	SetVirginStatus(akTarget, vstatus)
	
	; Recover Training
	GetTrainingStatsRead(akTarget)
	
	; Recover Kinks
	GetActorKinksRead(akTarget)

	return TraitsArray
EndFunction

float[] Function GetTraitsReadOrGenerated(Actor akRef) ; Get traits from file or generate
	; Generate traits from seed
	LogTrace("GetTraitsReadOrGenerated: "+akRef.getDisplayName()+" "+akRef)
	float[] TraitsArray
	; Personnality traits ; Message looks for 1 sigma deviation from 50 to define someone as having the trait
	; Flat distribution would be in line with the flat assumption
	; Studies have shown distributions are almost Gaussian
	string fileName
	if readJSONTraitsWarning
		fileName = OpenActorJSON(akRef)
		if fileName != ""
			int iset = DOM01.DOMGenerator.DOMPersonalityReadModeMessage.Show()
			if iset == 0
				readJSONTraitsToggle = true
			elseif iset == 1
				readJSONTraitsToggle = true
				readJSONTraitsWarning = false
			elseif iset == 3
				fileName = ""
				readJSONTraitsToggle = false
			else
				fileName = ""
				readJSONTraitsToggle = false
				readJSONTraitsWarning = false
			endif
		endif
	elseif !readJSONTraitsToggle
		fileName = ""
	else
		fileName = OpenActorJSON(akRef)
	endif
	
	; Fixed values from JSON files for choosen NPC
	If fileName != "" && JsonUtil.JsonExists(fileName)
		string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
		LogTrace("GetTraitsReadOrGenerated: Found json file for NPC "+nameJSON+" "+fileName)
		float xh = JsonUtil.GetFloatValue(fileName, "honesty", 50.0)
		float xe = JsonUtil.GetFloatValue(fileName, "emmotionality", -1.0)
		if xe < 0.0
			xe = JsonUtil.GetFloatValue(fileName, "emotionality", -1.0)
		endif
		if xe < 0.0
			xe = JsonUtil.GetFloatValue(fileName, "calmness", 50.0)
			xe = 100.0-xe
		endif
		float xx = JsonUtil.GetFloatValue(fileName, "extraversion", 50.0)
		float xa = JsonUtil.GetFloatValue(fileName, "agreeableness", 50.0)
		float xc = JsonUtil.GetFloatValue(fileName, "conscientiousness", 50.0)
		float xo = JsonUtil.GetFloatValue(fileName, "openness", 50.0)

		float yh = JsonUtil.GetFloatValue(fileName, "wilpower", 50.0)
		float ye = JsonUtil.GetFloatValue(fileName, "toughness", 50.0)
		float yx = JsonUtil.GetFloatValue(fileName, "sensuality", 50.0)
		float ya = JsonUtil.GetFloatValue(fileName, "submissivity", -1.0)
		if ya < 0.0
			ya = JsonUtil.GetFloatValue(fileName, "submitivity", 50.0)
		endif
		float yc = JsonUtil.GetFloatValue(fileName, "boldness", 50.0)
		float yo = JsonUtil.GetFloatValue(fileName, "smartness", 50.0)

		TraitsArray = new float[12]
		TraitsArray[0]  = xh
		TraitsArray[1]  = xe
		TraitsArray[2]  = xx
		TraitsArray[3]  = xa
		TraitsArray[4]  = xc
		TraitsArray[5]  = xo

		TraitsArray[6]  = yh
		TraitsArray[7]  = ye
		TraitsArray[8]  = yx
		TraitsArray[9]  = ya
		TraitsArray[10] = yc
		TraitsArray[11] = yo
	Else
		;LogTrace("Traits: json file does not exist: "+fileName)
		LogTrace("Traits: Generating traits for "+akRef.GetDisplayName())
		return GetTraitsGenerated(akRef)
	endif
	
    ;PrintTraits(akRef.GetDisplayName()+" Read or Generated",TraitsArray)
	; Check boundaries
	int i = TraitsArray.length
    while i > 0
        i -= 1
        if TraitsArray[i] < 0.0
			TraitsArray[i] = 0.0
		elseif TraitsArray[i] > 100.0
			TraitsArray[i] = 100.0
		endif
    endwhile
    ;PrintTraits(akRef.GetDisplayName()+" GetTraitsReadOrGenerated ",TraitsArray)
	
	return TraitsArray
EndFunction

float[] Function GetTraitsFromFactionOrReadOrGenerated(Actor akRef) ; Get traits from faction or from file or generate
	; Generate traits from seed
	;LogTrace("GetTraitsFromFactionOrReadOrGenerated: "+akRef.getDisplayName()+" "+akRef)
	float[] TraitsArray
	; Personnality traits ; Message looks for 1 sigma deviation from 50 to define someone as having the trait
	; Flat distribution would be in line with the flat assumption
	; Studies have shown distributions are almost Gaussian
	string fileName
	if readJSONTraitsWarning
		fileName = OpenActorJSON(akRef)
		if fileName != ""
			int iset = DOM01.DOMGenerator.DOMPersonalityReadModeMessage.Show()
			if iset == 0
				readJSONTraitsToggle = true
			elseif iset == 1
				readJSONTraitsToggle = true
				readJSONTraitsWarning = false
			elseif iset == 3
				fileName = ""
				readJSONTraitsToggle = false
			else
				fileName = ""
				readJSONTraitsToggle = false
				readJSONTraitsWarning = false
			endif
		endif
	elseif !readJSONTraitsToggle
		fileName = ""
	else
		fileName = OpenActorJSON(akRef)
	endif
	
	; Fixed values from JSON files for choosen NPC
	If fileName != "" && JsonUtil.JsonExists(fileName)
		string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
		LogTrace("GetTraitsFromFactionOrReadOrGenerated: Found json file for NPC "+nameJSON+" "+fileName)
		float xh
		if akRef.IsInFaction(DOMTraitHonesty)
			xh = akRef.GetFactionRank(DOMTraitHonesty)
		else
			xh = JsonUtil.GetFloatValue(fileName, "honesty", 50.0)
		endif
		float xe
		if akRef.IsInFaction(DOMTraitEmotionality)
			xe = akRef.GetFactionRank(DOMTraitEmotionality)
		else
			xe = JsonUtil.GetFloatValue(fileName, "emmotionality", -1.0)
			if xe < 0.0
				xe = JsonUtil.GetFloatValue(fileName, "emotionality", -1.0)
			endif
			if xe < 0.0
				xe = JsonUtil.GetFloatValue(fileName, "calmness", 50.0)
				xe = 100.0-xe
			endif
		endif
		float xx
		if akRef.IsInFaction(DOMTraitExtraversion)
			xx = akRef.GetFactionRank(DOMTraitExtraversion)
		else
			xx = JsonUtil.GetFloatValue(fileName, "extraversion", 50.0)
		endif
		float xa
		if akRef.IsInFaction(DOMTraitAgreeableness)
			xa = akRef.GetFactionRank(DOMTraitAgreeableness)
		else
			xa = JsonUtil.GetFloatValue(fileName, "agreeableness", 50.0)
		endif
		float xc
		if akRef.IsInFaction(DOMTraitConscientiousness)
			xc = akRef.GetFactionRank(DOMTraitConscientiousness)
		else
			xc = JsonUtil.GetFloatValue(fileName, "conscientiousness", 50.0)
		endif
		float xo
		if akRef.IsInFaction(DOMTraitOpenness)
			xo = akRef.GetFactionRank(DOMTraitOpenness)
		else
			xo = JsonUtil.GetFloatValue(fileName, "openness", 50.0)
		endif

		float yh
		if akRef.IsInFaction(DOMFacetWilfulness)
			yh = akRef.GetFactionRank(DOMFacetWilfulness)
		else
			yh = JsonUtil.GetFloatValue(fileName, "wilpower", 50.0)
		endif
		float ye
		if akRef.IsInFaction(DOMFacetToughness)
			ye = akRef.GetFactionRank(DOMFacetToughness)
		else
			ye = JsonUtil.GetFloatValue(fileName, "toughness", 50.0)
		endif
		float yx
		if akRef.IsInFaction(DOMFacetSensuality)
			yx = akRef.GetFactionRank(DOMFacetSensuality)
		else
			yx = JsonUtil.GetFloatValue(fileName, "sensuality", 50.0)
		endif
		float ya
		if akRef.IsInFaction(DOMFacetSubmissivity)
			ya = akRef.GetFactionRank(DOMFacetSubmissivity)
		else
			ya = JsonUtil.GetFloatValue(fileName, "submissivity", -1.0)
			if ya < 0.0
				ya = JsonUtil.GetFloatValue(fileName, "submitivity", 50.0)
			endif
		endif
		float yc
		if akRef.IsInFaction(DOMFacetBoldness)
			yc = akRef.GetFactionRank(DOMFacetBoldness)
		else
			yc = JsonUtil.GetFloatValue(fileName, "boldness", 50.0)
		endif
		float yo
		if akRef.IsInFaction(DOMFacetSmartness)
			yo = akRef.GetFactionRank(DOMFacetSmartness)
		else
			yo = JsonUtil.GetFloatValue(fileName, "smartness", 50.0)
		endif

		TraitsArray = new float[12]
		TraitsArray[0]  = xh
		TraitsArray[1]  = xe
		TraitsArray[2]  = xx
		TraitsArray[3]  = xa
		TraitsArray[4]  = xc
		TraitsArray[5]  = xo

		TraitsArray[6]  = yh
		TraitsArray[7]  = ye
		TraitsArray[8]  = yx
		TraitsArray[9]  = ya
		TraitsArray[10] = yc
		TraitsArray[11] = yo
	Else
		;LogTrace("Traits: json file does not exist: "+fileName)
		LogTrace("Traits: Generating traits for "+akRef.GetDisplayName())
		return GetTraitsFromFactionOrGenerated(akRef)
	endif
	
    ;PrintTraits(akRef.GetDisplayName()+" Read or Generated",TraitsArray)
	; Check boundaries
	int i = TraitsArray.length
    while i > 0
        i -= 1
        if TraitsArray[i] < 0.0
			TraitsArray[i] = 0.0
		elseif TraitsArray[i] > 100.0
			TraitsArray[i] = 100.0
		endif
    endwhile
    ;PrintTraits(akRef.GetDisplayName()+" GetTraitsFromFactionOrReadOrGenerated",TraitsArray)
	
	return TraitsArray
EndFunction

float[] Function GetTraitsFromFactions(Actor akTarget)
	;LogTrace("GetTraitsFromFactions: "+akTarget.getDisplayName()+" "+akTarget)
	float[] TraitsArray = new float[12]
	
	TraitsArray[0] = akTarget.GetFactionRank(DOMTraitHonesty)
	TraitsArray[1] = akTarget.GetFactionRank(DOMTraitEmotionality)
	TraitsArray[2] = akTarget.GetFactionRank(DOMTraitExtraversion)
	TraitsArray[3] = akTarget.GetFactionRank(DOMTraitAgreeableness)
	TraitsArray[4] = akTarget.GetFactionRank(DOMTraitConscientiousness)
	TraitsArray[5] = akTarget.GetFactionRank(DOMTraitOpenness)

	TraitsArray[6] = akTarget.GetFactionRank(DOMFacetWilfulness)
	TraitsArray[7] = akTarget.GetFactionRank(DOMFacetToughness)
	TraitsArray[8] = akTarget.GetFactionRank(DOMFacetSensuality)
	TraitsArray[9] = akTarget.GetFactionRank(DOMFacetSubmissivity)
	TraitsArray[10] = akTarget.GetFactionRank(DOMFacetBoldness)
	TraitsArray[11] = akTarget.GetFactionRank(DOMFacetSmartness)
	
	;;LogTrace("GetTraitsFromFactions end: "+akTarget.getDisplayName())
    ;PrintTraits(akTarget.GetDisplayName()+" GetTraitsFromFactions",TraitsArray)

	return TraitsArray
EndFunction

float[] Function GetTraitsFromFactionOrGenerated(Actor akTarget)
	;LogTrace("GetTraitsFromFactionOrGenerated: "+akTarget.getDisplayName()+" "+akTarget)
	float[] TraitsArray = GetTraitsGenerated(akTarget)
	
	if akTarget.isInFaction(DOMTraitHonesty)
		TraitsArray[0] = akTarget.GetFactionRank(DOMTraitHonesty)
	endif
	if akTarget.isInFaction(DOMTraitEmotionality)
		TraitsArray[1] = akTarget.GetFactionRank(DOMTraitEmotionality)
	endif
	if akTarget.isInFaction(DOMTraitExtraversion)
		TraitsArray[2] = akTarget.GetFactionRank(DOMTraitExtraversion)
	endif
	if akTarget.isInFaction(DOMTraitAgreeableness)
		TraitsArray[3] = akTarget.GetFactionRank(DOMTraitAgreeableness)
	endif
	if akTarget.isInFaction(DOMTraitConscientiousness)
		TraitsArray[4] = akTarget.GetFactionRank(DOMTraitConscientiousness)
	endif
	if akTarget.isInFaction(DOMTraitOpenness)
		TraitsArray[5] = akTarget.GetFactionRank(DOMTraitOpenness)
	endif

	if akTarget.isInFaction(DOMFacetWilfulness)
		TraitsArray[6] = akTarget.GetFactionRank(DOMFacetWilfulness)
	endif
	if akTarget.isInFaction(DOMFacetToughness)
		TraitsArray[7]= akTarget.GetFactionRank(DOMFacetToughness)
	endif
	if akTarget.isInFaction(DOMFacetSensuality)
		TraitsArray[8] = akTarget.GetFactionRank(DOMFacetSensuality)
	endif
	if akTarget.isInFaction(DOMFacetSubmissivity)
		TraitsArray[9]= akTarget.GetFactionRank(DOMFacetSubmissivity)
	endif
	if akTarget.isInFaction(DOMFacetBoldness)
		TraitsArray[10] = akTarget.GetFactionRank(DOMFacetBoldness)
	endif
	if akTarget.isInFaction(DOMFacetSmartness)
		TraitsArray[11] = akTarget.GetFactionRank(DOMFacetSmartness)
	endif

	; Check boundaries
	int i = TraitsArray.length
    while i > 0
        i -= 1
        if TraitsArray[i] < 0.0
			TraitsArray[i] = 0.0
		elseif TraitsArray[i] > 100.0
			TraitsArray[i] = 100.0
		endif
    endwhile
    ;PrintTraits(akTarget.GetDisplayName()+" GetTraitsFromFactionOrGenerated",TraitsArray)

	return TraitsArray
EndFunction

float[] Function GetTraitsGenerated(Actor akTarget)
	float[] TraitsArray = new float[12]
	actorBase abTarget = akTarget.GetLeveledActorBase()
	string nameString = akTarget.GetDisplayName()
	if nameString == ""
		nameString = abTarget.GetName()
	endif
	;LogTrace("GetTraitsGenerated "+nameString+" GetTraitsGenerated()")

	; Base actor values
	;float xh = akTarget.getAV("Health") -(100.0)           ; Level 1 value is 100 for all races
	float xs = akTarget.getAV("Stamina")-(200.0)            ; Level 1 value is 100 for all races
	float xm = akTarget.getAV("Magicka")/10.0-(100.0)       ; Between 0 and 1000 depending on race and level
	float xx = PO3_SKSEFunctions.GetActorSoulSize(akTarget) ; Between 1 and 5 depending on level

	int formID
	if !(abTarget.IsUnique()) || DOM01.seedUniques
		;if !(abTarget.IsUnique())
		;	LogTrace("GetTraitsGenerated "+nameString+" is not unique using Random seed") ; , faction "+DOMRandomSeed)
		;else
		;	LogTrace("GetTraitsGenerated "+nameString+" is unique but using Random seed anyhow") ; , faction "+DOMRandomSeed)
		;endif
		;LogTrace("GetTraitsGenerated "+nameString+" Is in faction? "+akTarget.isInFaction(DOMRandomSeed)+" rank "+akTarget.getFactionRank(DOMRandomSeed))
		if akTarget.isInFaction(DOMRandomSeed)
			seed = akTarget.getFactionRank(DOMRandomSeed)
			;LogTrace("GetTraitsGenerated "+nameString+" Old value restored DOMRandomSeed = "+seed)	
			formID = seed+Math.LogicalAnd(abTarget.GetFormID(), 0x00FFFFFF)
			;LogTrace("GetTraitsGenerated "+nameString+" Old seed value used = "+seed)
		else
			seed  = (((RandomFloat()*256.0) as int) % 256 ) - (128)
			akTarget.setFactionRank(DOMRandomSeed, seed)
			;LogTrace("GetTraitsGenerated "+nameString+" New value stored DOMRandomSeed = "+seed)
			formID = seed+Math.LogicalAnd(abTarget.GetFormID(), 0x00FFFFFF)
			;LogTrace("GetTraitsGenerated "+nameString+" New seed value used = "+seed)
		endif
	else
		;LogTrace(nameString+" is unique, use fixed seed!")
		formID = Math.LogicalAnd(abTarget.GetFormID(), 0x00FFFFFF)
	endif
	;seed = (4527 * (formID+(68))+1013904223) % 2147483648;
	seed =  (0x10A1 * (formID+0x44)+0x3C6EF35F) % 0x80000000; 
	;LogTrace("GetTraitsGenerated "+nameString+" uses ID = "+abTarget+" and seed = "+seed)

	TraitsArray[0]  = Random3N() ; Sly/Honest     Hexaco: Honesty-Humility 
	TraitsArray[1]  = Random3N() ; Calm/Anxious   Hexaco: Emotionality 
	TraitsArray[2]  = Random3N() ; Shy/Lively     Hexaco: eXtraversion 
	TraitsArray[3]  = Random3N() ; Grumpy/Gentle  Hexaco: Agreeableness
	TraitsArray[4]  = Random3N() ; Lazy/Thorough  Hexaco: Conscientiousness 
	TraitsArray[5]  = Random3N() ; Shallow/Open   Hexaco: Openness to Experience

	; Mind & Physical power              ; HEXACO Facets
	TraitsArray[6] = Random3N()+xx*2.0   ; WTSUBM: 1 Wilfulness: Weak/Wilful somehow related to soul size or level
	TraitsArray[7] = Random3N()+xs/20.0  ; WTSUBM: 2 Toughness: Delicate/Tough somehow related to stamina
	TraitsArray[8] = Random3N()          ; WTSUBM: 3 Sensuality: Frigid/Sensual
	TraitsArray[9] = Random3N()          ; WTSUBM: 4 sUbmissivity: sadistic/masochistic = perversion orientation (not a judgement or a graduation of perversion)
	TraitsArray[10]  = Random3N()          ; WTSUBM: 5 Boldness: Needy/Bold  
	TraitsArray[11]  = Random3N()+xm/10.0  ; WTSUBM: 6 sMartness: Stupid/Smart somehow related to magicka

	;PrintTraits("GetTraitsGenerated "+nameString+" Generation",TraitsArray)
	
	bool is_female     = (abTarget.GetSex() == 1)
	float [] BonusTraitsArray = GetTraitBonusForActor(akTarget)
	int i = 0
	while i < BonusTraitsArray.length
		if i == 9 ; submissive/dominant bonuses
			if RandomUniform() > 0.5 ; 50% submissive bonus
				TraitsArray[i] = TraitsArray[i] + BonusTraitsArray[i]
				;LogTrace("GetTraitsGenerated "+__traitNames[i]+"="+TraitsArray[i]+" ("+BonusTraitsArray[i]+")")
			else                     ; 50% dominant bonus
				TraitsArray[i] = TraitsArray[i] - BonusTraitsArray[BonusTraitsArray.length-(1)]
				;LogTrace("GetTraitsGenerated "+__traitNames[i]+"="+TraitsArray[i]+" (-"+BonusTraitsArray[i+1]+")")
			endif
		elseif i < 12
			TraitsArray[i] = TraitsArray[i] + BonusTraitsArray[i]
			;LogTrace("GetTraitsGenerated "+__traitNames[i]+"="+TraitsArray[i]+" ("+BonusTraitsArray[i]+")")
		endif
		i += 1
	endwhile

	;PrintTraits("GetTraitsGenerated "+nameString+" After bonuses",TraitsArray)

	; Morality effect on honesty
	float x = akTarget.GetAV("Morality")
	;LogTrace("Special bonus for "+nameString+" morality = "+x)
	If x < 1
		TraitsArray[0]  = TraitsArray[0] -Random3PlaceBonus(25)  ; Honest
	ElseIf x < 2
		TraitsArray[0]  = TraitsArray[0] -Random3PlaceBonus(10)  ; Honest
	ElseIf x < 3
		TraitsArray[0]  = TraitsArray[0] +Random3PlaceBonus(10)  ; Honest
	Else
		TraitsArray[0]  = TraitsArray[0] +Random3PlaceBonus(25)  ; Honest
	endif
	; Confidence effect on boldness
	x = akTarget.GetAV("Confidence")
	;LogTrace("Special bonus for "+nameString+" confidence = "+x)
	If x < 1
		TraitsArray[10]  = TraitsArray[10] -Random3PlaceBonus(25)  ; Bold
	ElseIf x < 2
		TraitsArray[10]  = TraitsArray[10] -Random3PlaceBonus(10)  ; Bold
	ElseIf x < 3
		TraitsArray[10]  = TraitsArray[10] +Random3PlaceBonus(10)  ; Bold
	Else
		TraitsArray[10]  = TraitsArray[10] +Random3PlaceBonus(25)  ; Bold
	endif
	; Assistance effect on Agreeableness
	x = akTarget.GetAV("Assistance")
	;LogTrace("Special bonus for "+nameString+" assistance = "+x)
	If x < 1
		TraitsArray[3]  = TraitsArray[3] -Random3PlaceBonus(15)  ; Grumpy
	ElseIf x > 1
		TraitsArray[3]  = TraitsArray[3] +Random3PlaceBonus(15)  ; Agreeable
	endif

	; Check boundaries
	i = TraitsArray.length
    while i > 0
        i -= 1
        if TraitsArray[i] < 0.0
			TraitsArray[i] = 0.0
		elseif TraitsArray[i] > 100.0
			TraitsArray[i] = 100.0
		endif
    endwhile

	;LogTrace("Actor "+nameString+" Morality="+akTarget.GetAV("Morality")+" Confidence="+akTarget.GetAV("Confidence")+" Assistance="+akTarget.GetAV("Assistance"))
	;PrintTraits(nameString+" Values",TraitsArray)
    ;PrintTraits(akTarget.GetDisplayName()+" GetTraitsGenerated",TraitsArray)

	return TraitsArray
EndFunction

float[] Function ReadBaseTraits(Actor akRef)
	; Generate traits from seed
	;LogTrace("ReadOrGenerateBaseTraits: "+akRef.getDisplayName()+" "+akRef)
	float[] TraitsArray
	; Personnality traits ; Message looks for 1 sigma deviation from 50 to define someone as having the trait
	; Flat distribution would be in line with the flat assumption
	; Studies have shown distributions are almost Gaussian
	string fileName = OpenActorJSON(akRef)
	If fileName != "" && JsonUtil.JsonExists(fileName)
		string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
		;LogTrace("ReadBaseTraits: Found json file for NPC "+nameJSON+" "+fileName)
		float xh = JsonUtil.GetFloatValue(fileName, "base_honesty", -1.0)
		float xe = JsonUtil.GetFloatValue(fileName, "base_emmotionality", -1.0)
		float xx = JsonUtil.GetFloatValue(fileName, "base_xtraversion", -1.0)
		float xa = JsonUtil.GetFloatValue(fileName, "base_agreeableness", -1.0)
		float xc = JsonUtil.GetFloatValue(fileName, "base_conscientiousness", -1.0)
		float xo = JsonUtil.GetFloatValue(fileName, "base_openness", -1.0)

		float yh = JsonUtil.GetFloatValue(fileName, "base_wilpower", -1.0)
		float ye = JsonUtil.GetFloatValue(fileName, "base_toughness", -1.0)
		float yx = JsonUtil.GetFloatValue(fileName, "base_sensuality", -1.0)
		float ya = JsonUtil.GetFloatValue(fileName, "base_submissivity", -1.0)
		float yc = JsonUtil.GetFloatValue(fileName, "base_boldness", -1.0)
		float yo = JsonUtil.GetFloatValue(fileName, "base_smartness", -1.0)

		TraitsArray = new float[12]
		TraitsArray[0]  = xh
		TraitsArray[1]  = xe
		TraitsArray[2]  = xx
		TraitsArray[3]  = xa
		TraitsArray[4]  = xc
		TraitsArray[5]  = xo

		TraitsArray[6]  = yh
		TraitsArray[7]  = ye
		TraitsArray[8]  = yx
		TraitsArray[9]  = ya
		TraitsArray[10] = yc
		TraitsArray[11] = yo
	Else
		;LogTrace("Traits: json file does not exist: "+fileName)
		;LogTrace("Traits: Setting base traits for "+akRef.GetDisplayName())
		TraitsArray = new float[12]
		TraitsArray[0]  = -1.0
		TraitsArray[1]  = -1.0
		TraitsArray[2]  = -1.0
		TraitsArray[3]  = -1.0
		TraitsArray[4]  = -1.0
		TraitsArray[5]  = -1.0

		TraitsArray[6]  = -1.0
		TraitsArray[7]  = -1.0
		TraitsArray[8]  = -1.0
		TraitsArray[9]  = -1.0
		TraitsArray[10] = -1.0
		TraitsArray[11] = -1.0
	endif
	
    ;PrintTraits(akRef.GetDisplayName()+" Generated",TraitsArray)
	; Check boundaries
	int i = TraitsArray.length
    while i > 0
        i -= 1
        if TraitsArray[i] < 0.0
			TraitsArray[i] = -1.0
		elseif TraitsArray[i] > 100.0
			TraitsArray[i] = 100.0
		endif
    endwhile
    ;PrintTraits(akRef.GetDisplayName()+" Final",TraitsArray)
	
	return TraitsArray
EndFunction

Function SetJSONFloatValueFromFaction(Actor akTarget, string fileName, string keyName, Faction the_faction)
	if akTarget.IsInFaction(the_faction)
		JsonUtil.SetFloatValue(fileName, keyName, akTarget.GetFactionRank(the_faction))
	endif
EndFunction

Function SetJSONIntValueFromFaction(Actor akTarget, string fileName, string keyName, Faction the_faction)
	if akTarget.IsInFaction(the_faction)
		JsonUtil.SetIntValue(fileName, keyName, akTarget.GetFactionRank(the_faction))
	endif
EndFunction

Function WriteActorJSON(Actor akTarget)
	LogTrace("WriteActorJSON "+akTarget.GetDisplayName())
	DOM_Actor akActor = DOM01.GetActor(akTarget)
	if akActor != NONE
		WriteJSON(akActor)
		return
	endif
	if akTarget == None
		LogTrace("WriteActorJSON: Actor is NONE ")
		DOM01.HudNotification("Write JSON failed: invalid actor")
		return
	endif

	string playerName = PlayerRef.GetDisplayName()
	LogTrace("WriteActorJSON: "+akTarget.getDisplayName()+" "+akTarget+" player="+playerName)
	actorBase abTarget = akTarget.GetLeveledActorBase()
	string nameString = akTarget.GetDisplayName()
	if nameString == ""
		nameString = abTarget.GetName()
	endif
	int formID = Math.LogicalAnd(abTarget.GetFormID(), 0x00FFFFFF)
	string IDstr = DOM_Util.ConvertIDToHex(formID)
	string fileName
	if playerName != ""
		fileName = "Diary Of Mine/" + playerName + "/" + IDstr + "_"+ nameString + ".json"
	else
		fileName = "Diary Of Mine/" +  IDstr + "_"+ nameString + ".json"
	endif
	if JsonUtil.JsonExists(fileName)
		LogTrace("WriteActorJSON: json file will be overwritten: "+fileName)
	endif
	LogTrace("Creating json file for DOM Actor "+fileName)
	
	JsonUtil.SetStringValue(fileName,"fullname",          nameString)
	JsonUtil.SetStringValue(fileName,"basename",          abTarget.GetName())
	JsonUtil.SetStringValue(fileName,"id",                "0x"+IDstr)
	
	float[] traits = GetNPCTraits(akTarget)
	JsonUtil.SetFloatValue(fileName, "honesty",           traits[0])
	JsonUtil.SetFloatValue(fileName, "emmotionality",     traits[1])
	JsonUtil.SetFloatValue(fileName, "extraversion",      traits[2])
	JsonUtil.SetFloatValue(fileName, "agreeableness",     traits[3])
	JsonUtil.SetFloatValue(fileName, "conscientiousness", traits[4])
	JsonUtil.SetFloatValue(fileName, "openness",          traits[5])
	JsonUtil.SetFloatValue(fileName, "wilpower",          traits[6])
	JsonUtil.SetFloatValue(fileName, "toughness",         traits[7])
	JsonUtil.SetFloatValue(fileName, "sensuality",        traits[8])
	JsonUtil.SetFloatValue(fileName, "submissivity",      traits[9])
	JsonUtil.SetFloatValue(fileName, "boldness",          traits[10])
	JsonUtil.SetFloatValue(fileName, "smartness",         traits[11])
	
	int[] vstatus = GetVirginStatus(akTarget)
	if vstatus[0] == 4
		JsonUtil.SetIntValue(fileName, "virginvaginal", 0)
	else
		JsonUtil.SetIntValue(fileName, "virginvaginal", 1)
	endif
	if vstatus[1] == 4
		JsonUtil.SetIntValue(fileName, "virginoral", 0)
	else
		JsonUtil.SetIntValue(fileName, "virginoral", 1)
	endif
	if vstatus[2] == 4
		JsonUtil.SetIntValue(fileName, "virginanal", 0)
	else
		JsonUtil.SetIntValue(fileName, "virginanal", 1)
	endif
	if vstatus[3] == 4
		JsonUtil.SetIntValue(fileName, "virginsame", 0)
	else
		JsonUtil.SetIntValue(fileName, "virginsame", 1)
	endif
	if vstatus[4] == 4
		JsonUtil.SetIntValue(fileName, "virgingangbang", 0)
	else
		JsonUtil.SetIntValue(fileName, "virgingangbang", 1)
	endif
	
	; Relationship to player
	JsonUtil.SetIntValue(fileName, "playerrelationship",   akTarget.GetRelationshipRank(PlayerRef))

	; Training stats
	SetJSONFloatValueFromFaction(akTarGet,fileName, "wskillenforcer",    DOMSkillEnforcer)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "wskillpersuader",   DOMSkillPersuader)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "wskilldepraver",    DOMSkillDepraver)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "wskillpredator",    DOMSkillPredator)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "wskillslaver",      DOMSkillSlaver)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "wskilldeceiver",    DOMSkillDeceiver)

	SetJSONFloatValueFromFaction(akTarGet,fileName, "xsubmission",       DOMTrainSubmission)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "xfeartraining",     DOMTrainFear)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "xangertraining",    DOMTrainAnger)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "xrespecttraining",  DOMTrainRespect)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "xhumiliation",      DOMTrainHumiliation)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "xresignation",      DOMTrainResignation)
	
	SetJSONFloatValueFromFaction(akTarGet,fileName, "ylovedesire",       DOMLoveDesire)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "yloyalworship",     DOMLoyalWorship)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "ylovefascination",  DOMLoveFascination)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "yloyalabsolution",  DOMLoyalAbsolution)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "yloveadmiration",   DOMLoveAdmiration)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "yloyaldevotion",    DOMLoyalDevotion)
	
	SetJSONFloatValueFromFaction(akTarGet,fileName, "zPoseTraining",     DOMTrainPose)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "zCombatTraining",   DOMTrainCombat)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "zOralTraining",     DOMTrainOral)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "zVaginalTraining",  DOMTrainVaginal)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "zAnalTraining",     DOMTrainAnal)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "zHouseTraining",    DOMTrainHouse)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "zWorkTraining",     DOMTrainWorking)
	SetJSONFloatValueFromFaction(akTarGet,fileName, "trauma",            DOMTraumaInDays)

	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_pain",    DOMNbPain)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_bondage", DOMNbBondage)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_shame",   DOMNbShame)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_rape",    DOMNbRape)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_drug",    DOMNbDrug)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_sex",     DOMNbSex)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_sexformoney",       DOMNbSexForMoney)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_sexwithothers",     DOMNbSexWithOthers)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_kinktrigger",       DOMNbKinkTrigger)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_orgasm",  DOMNbOrgasm)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_toldoff", DOMNbToldoff)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_praise",  DOMNbPraise)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_comfort", DOMNbComfort)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_insult",  DOMNbInsult)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_flatter", DOMNbFlatter)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_threat",  DOMNbThreat)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_promise", DOMNbPromise)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_chat_feelings", DOMNbChatFeelings)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_chat_personality", DOMNbChatPersonality)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_shock",   DOMNbShock)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_broken",  DOMNbBroken)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_brainwashed",  DOMNbBrainwashed)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_player_fling", DOMNbPlayerFling)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_player_chat",  DOMNbPlayerChat)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_trainee", DOMNbTrainee)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_trainer", DOMNbTrainer)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_whoredslaves", DOMNbWhoredSlaves)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_recruitedslavers", DOMNbRecruitedSlavers)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_ransomedslaves", DOMNbRansomedSlaves)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_capturedslaves", DOMNbCapturedSlaves)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_soldslaves", DOMNbSoldSlaves)
	SetJSONIntValueFromFaction(akTarGet,fileName, "number_of_brokenslaves", DOMNbBrokenSlaves)

	JsonUtil.Save(fileName)
	DOM01.HudNotification("Write JSON success: "+akTarget.GetDisplayName())
EndFunction

Function ReadActorJSON(Actor akTarget)
	LogTrace("ReadActorJSON "+akTarget.GetDisplayName())
	DOM_Actor akActor = DOM01.GetActor(akTarget)
	if akActor != NONE
		ReadJSON(akActor)
		return
	endif
	if akTarget == None
		LogTrace("ReadActorJSON: Actor is NONE ")
		DOM01.HudNotification("Read JSON failed: invalid actor")
		return
	endif

	; Get default traits from file
	float[] TraitsArray = GetPersonalityReadOrGenerated(akTarget)	

	DOM01.HudNotification("Read JSON success: "+akTarget.GetDisplayName())
EndFunction

Function WriteJSON(DOM_Actor akActor)
	if akActor == None
		LogTrace("WriteJSON: Actor is NONE")
		DOM01.HudNotification("Write DOM JSON failed: invalid actor")
		return
	endif
	Actor akTarget = akActor.akRef
	if akTarget == None
		LogTrace("WriteJSON: Actor Ref is NONE "+akActor.getName())
		DOM01.HudNotification("Write DOM JSON failed: invalid actor")
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		LogTrace("WriteJSON: Actor Mind is NONE "+akActor.getName())
		DOM01.HudNotification("Write DOM JSON failed: invalid actor")
		return
	endif	
	string playerName = PlayerRef.GetDisplayName()
	LogTrace("WriteJSON: "+akTarget.getDisplayName()+" "+akTarget+" player="+playerName)
	actorBase abTarget = akTarget.GetLeveledActorBase()
	string nameString = akTarget.GetDisplayName()
	if nameString == ""
		nameString = abTarget.GetName()
	endif
	int formID = Math.LogicalAnd(abTarget.GetFormID(), 0x00FFFFFF)
	String IDstr = DOM_Util.ConvertIDToHex(formID)
	string fileName
	if playerName != ""
		fileName = "Diary Of Mine/" + playerName + "/" + IDstr + "_"+ nameString + ".json"
	else
		fileName = "Diary Of Mine/" +  IDstr + "_"+ nameString + ".json"
	endif
	if JsonUtil.JsonExists(fileName)
		LogTrace("WriteJSON: json file will be overwritten: "+fileName)
	endif
	LogTrace("Creating json file for DOM Actor "+fileName)
	JsonUtil.SetStringValue(fileName,"fullname",          akActor.GetName())
	JsonUtil.SetStringValue(fileName,"fulltitle",         akActor.GetTitle())
	JsonUtil.SetStringValue(fileName,"fullgender",        akActor.GetGenderByString())
	JsonUtil.SetFloatValue(fileName, "honesty",           akMind.HEXACO_Honesty)
	JsonUtil.SetFloatValue(fileName, "emmotionality",     akMind.HEXACO_Emotionality)
	JsonUtil.SetFloatValue(fileName, "extraversion",      akMind.HEXACO_eXtraversion)
	JsonUtil.SetFloatValue(fileName, "agreeableness",     akMind.HEXACO_Agreeableness)
	JsonUtil.SetFloatValue(fileName, "conscientiousness", akMind.HEXACO_Conscientiousness)
	JsonUtil.SetFloatValue(fileName, "openness",          akMind.HEXACO_Openness)
	JsonUtil.SetFloatValue(fileName, "wilpower",          akMind.FACET_Wilfulness)
	JsonUtil.SetFloatValue(fileName, "toughness",         akMind.FACET_Toughness)
	JsonUtil.SetFloatValue(fileName, "sensuality",        akMind.FACET_Sensuality)
	JsonUtil.SetFloatValue(fileName, "submissivity",      akMind.FACET_Submissivity)
	JsonUtil.SetFloatValue(fileName, "boldness",          akMind.FACET_Boldness)
	JsonUtil.SetFloatValue(fileName, "smartness",         akMind.FACET_Smartness)

	JsonUtil.SetFloatValue(fileName, "base_honesty",           akMind.BASE_Honesty)
	JsonUtil.SetFloatValue(fileName, "base_emmotionality",     akMind.BASE_Emotionality)
	JsonUtil.SetFloatValue(fileName, "base_extraversion",      akMind.BASE_eXtraversion)
	JsonUtil.SetFloatValue(fileName, "base_agreeableness",     akMind.BASE_Agreeableness)
	JsonUtil.SetFloatValue(fileName, "base_conscientiousness", akMind.BASE_Conscientiousness)
	JsonUtil.SetFloatValue(fileName, "base_openness",          akMind.BASE_Openness)
	JsonUtil.SetFloatValue(fileName, "base_wilpower",          akMind.BASE_Wilfulness)
	JsonUtil.SetFloatValue(fileName, "base_toughness",         akMind.BASE_Toughness)
	JsonUtil.SetFloatValue(fileName, "base_sensuality",        akMind.BASE_Sensuality)
	JsonUtil.SetFloatValue(fileName, "base_submissivity",      akMind.BASE_Submissivity)
	JsonUtil.SetFloatValue(fileName, "base_boldness",          akMind.BASE_Boldness)
	JsonUtil.SetFloatValue(fileName, "base_smartness",         akMind.BASE_Smartness)
	
	int i = 0
	int n = akMind.hidden_kinks_slot.length
	while i < n
		int ikink = akMind.hidden_kinks_slot[i]
		if ikink > 0
			string kink_str = "hiddenkink"+i
			;LogTrace("WriteJSON "+akActor.GetName()+" "+kink_str+" ik="+ikink+" kink="+ DOM01.GetJSONKinkReasonNameByIndex(ikink,akActor.actorSex))
			JsonUtil.SetStringValue(fileName, kink_str, DOM01.GetJSONKinkReasonNameByIndex(ikink,akActor.actorSex))
		endif
		i +=1
	endwhile
	i = 0
	n = akMind.known_kinks_slot.length
	while i < n
		int ikink = akMind.known_kinks_slot[i]
		if ikink > 0
			string kink_str = "knownkink"+i
			JsonUtil.SetStringValue(fileName, kink_str, DOM01.GetJSONKinkReasonNameByIndex(ikink,akActor.actorSex))
		endif
		i +=1
	endwhile
	
	if akMind.virgin_status_oral == 4
		JsonUtil.SetIntValue(fileName, "virginoral", 0)
	else
		JsonUtil.SetIntValue(fileName, "virginoral", 1)
	endif
	if akMind.virgin_status_vaginal == 4
		JsonUtil.SetIntValue(fileName, "virginvaginal", 0)
	else
		JsonUtil.SetIntValue(fileName, "virginvaginal", 1)
	endif
	if akMind.virgin_status_anal == 4
		JsonUtil.SetIntValue(fileName, "virginanal", 0)
	else
		JsonUtil.SetIntValue(fileName, "virginanal", 1)
	endif
	if akMind.virgin_status_same == 4
		JsonUtil.SetIntValue(fileName, "virginsame", 0)
	else
		JsonUtil.SetIntValue(fileName, "virginsame", 1)
	endif
	if akMind.virgin_status_gang == 4
		JsonUtil.SetIntValue(fileName, "virgingangbang", 0)
	else
		JsonUtil.SetIntValue(fileName, "virgingangbang", 1)
	endif

	; Relationship to player
	JsonUtil.SetIntValue(fileName, "playerrelationship",   akTarget.GetRelationshipRank(PlayerRef))

	; Training stats & skills
	JsonUtil.SetFloatValue(fileName, "wskillenforcer",    akMind.skill_enforcer)
	JsonUtil.SetFloatValue(fileName, "wskillpredator",    akMind.skill_predator)
	JsonUtil.SetFloatValue(fileName, "wskilldepraver",    akMind.skill_depraver)
	JsonUtil.SetFloatValue(fileName, "wskillpersuader",   akMind.skill_persuader)
	JsonUtil.SetFloatValue(fileName, "wskillslaver",      akMind.skill_slaver)
	JsonUtil.SetFloatValue(fileName, "wskilldeceiver",    akMind.skill_deceiver)

	JsonUtil.SetFloatValue(fileName, "xsubmission",       akMind.submission)
	JsonUtil.SetFloatValue(fileName, "xfeartraining",     akMind.fear_training)
	JsonUtil.SetFloatValue(fileName, "xhumiliation",      akMind.humiliation)
	JsonUtil.SetFloatValue(fileName, "xangertraining",    akMind.anger_training)
	JsonUtil.SetFloatValue(fileName, "xresignation",      akMind.resignation)
	JsonUtil.SetFloatValue(fileName, "xrespecttraining",  akMind.respect_training)
	
	JsonUtil.SetFloatValue(fileName, "ylovedesire",       akMind.love_desire)
	JsonUtil.SetFloatValue(fileName, "yloyalworship",     akMind.loyal_worship)
	JsonUtil.SetFloatValue(fileName, "ylovefascination",  akMind.love_fascination)
	JsonUtil.SetFloatValue(fileName, "yloyalabsolution",  akMind.loyal_absolution)
	JsonUtil.SetFloatValue(fileName, "yloveadmiration",   akMind.love_admiration)
	JsonUtil.SetFloatValue(fileName, "yloyaldevotion",    akMind.loyal_devotion)

	JsonUtil.SetFloatValue(fileName, "zPoseTraining",     akMind.pose_training)
	JsonUtil.SetFloatValue(fileName, "zOralTraining",     akMind.oral_training)
	JsonUtil.SetFloatValue(fileName, "zVaginalTraining",  akMind.vaginal_training)
	JsonUtil.SetFloatValue(fileName, "zAnalTraining",     akMind.anal_training)
	JsonUtil.SetFloatValue(fileName, "zCombatTraining",   akMind.combat_training)
	JsonUtil.SetFloatValue(fileName, "zHouseTraining",    akMind.house_training)
	JsonUtil.SetFloatValue(fileName, "zWorkTraining",     akMind.work_training)
	JsonUtil.SetFloatValue(fileName, "trauma",            akMind.timer_for_broken)
	
	; Counters
	JsonUtil.SetIntValue(fileName, "number_of_pain", akMind.number_of_pain)
	JsonUtil.SetIntValue(fileName, "number_of_bondage", akMind.number_of_bondage)
	JsonUtil.SetIntValue(fileName, "number_of_shame", akMind.number_of_shame)
	JsonUtil.SetIntValue(fileName, "number_of_rape", akMind.number_of_rape)
	JsonUtil.SetIntValue(fileName, "number_of_drug", akMind.number_of_drug)
	JsonUtil.SetIntValue(fileName, "number_of_sex", akMind.number_of_sex)
	JsonUtil.SetIntValue(fileName, "number_of_orgasm", akMind.number_of_orgasm)
	JsonUtil.SetIntValue(fileName, "number_of_toldoff", akMind.number_of_toldoff)
	JsonUtil.SetIntValue(fileName, "number_of_praise", akMind.number_of_praise)
	JsonUtil.SetIntValue(fileName, "number_of_comfort", akMind.number_of_comfort)
	JsonUtil.SetIntValue(fileName, "number_of_insult", akMind.number_of_insult)
	JsonUtil.SetIntValue(fileName, "number_of_flatter", akMind.number_of_flatter)
	JsonUtil.SetIntValue(fileName, "number_of_threat", akMind.number_of_threat)
	JsonUtil.SetIntValue(fileName, "number_of_promise", akMind.number_of_promise)
	JsonUtil.SetIntValue(fileName, "number_of_chat_feelings", akMind.number_of_chat_feelings)
	JsonUtil.SetIntValue(fileName, "number_of_chat_personality", akMind.number_of_chat_personality)
	JsonUtil.SetIntValue(fileName, "number_of_shock", akMind.number_of_shock)
	JsonUtil.SetIntValue(fileName, "number_of_broken", akMind.number_of_broken)
	JsonUtil.SetIntValue(fileName, "number_of_brainwashed", akMind.number_of_brainwashed)
	JsonUtil.SetIntValue(fileName, "number_of_trainee", akMind.number_of_trainee)
	JsonUtil.SetIntValue(fileName, "number_of_trainer", akMind.number_of_trainer)
	JsonUtil.SetIntValue(fileName, "number_of_player_fling", akMind.number_of_player_fling)
	JsonUtil.SetIntValue(fileName, "number_of_player_chat", akMind.number_of_player_chat)
	JsonUtil.SetIntValue(fileName, "number_of_capturedslaves", akMind.number_of_capturedslaves)
	JsonUtil.SetIntValue(fileName, "number_of_brokenslaves", akMind.number_of_brokenslaves)
	JsonUtil.SetIntValue(fileName, "number_of_soldslaves", akMind.number_of_soldslaves)

	JsonUtil.SetStringValue(fileName,"memory_origin_txt", akMind.memory_origin_txt)
	JsonUtil.SetFloatValue(fileName, "memory_capture_time", akMind.memory_capture_time)
	JsonUtil.SetIntValue(fileName, "memory_capture_mood", akMind.memory_capture_mood)
	JsonUtil.SetIntValue(fileName, "memory_capture_ntimes", akMind.memory_capture_ntimes)
	JsonUtil.SetIntValue(fileName, "memory_capture_rtimes", akMind.memory_capture_rtimes)
	JsonUtil.SetIntValue(fileName, "memory_capture_ftimes", akMind.memory_capture_ftimes)
	JsonUtil.SetStringValue(fileName,"memory_capture_location", akMind.memory_capture_location)
	JsonUtil.SetStringValue(fileName,"memory_capture_occupation", akMind.memory_capture_occupation)
	JsonUtil.SetStringValue(fileName,"memory_capture_origin", akMind.memory_capture_origin)
	JsonUtil.SetStringValue(fileName,"memory_capture_type", akMind.memory_capture_type)
	JsonUtil.SetStringValue(fileName,"memory_capture_txt", akMind.memory_capture_txt)

	i = 0
	n = akMind.memory_entries
	while i < n
		JsonUtil.SetFloatValue(fileName, "memory_abuse_time"+i, akMind.memory_abuse_time[i])
		JsonUtil.SetIntValue(fileName, "memory_abuse_category"+i, akMind.memory_abuse_category[i])
		JsonUtil.SetIntValue(fileName, "memory_abuse_mood"+i, akMind.memory_abuse_mood[i])
		JsonUtil.SetIntValue(fileName, "memory_abuse_level"+i, akMind.memory_abuse_level[i])
		JsonUtil.SetIntValue(fileName, "memory_abuse_ntimes"+i, akMind.memory_abuse_ntimes[i])
		JsonUtil.SetIntValue(fileName, "memory_abuse_respectful"+i, akMind.memory_abuse_respectful[i] as Int)
		JsonUtil.SetIntValue(fileName, "memory_abuse_flag"+i, akMind.memory_abuse_flag[i] as Int)
		JsonUtil.SetStringValue(fileName,"memory_abuse_location"+i, akMind.memory_abuse_location[i])
		JsonUtil.SetStringValue(fileName,"memory_abuse_type"+i, akMind.memory_abuse_type[i])
		JsonUtil.SetStringValue(fileName,"memory_abuse_reason"+i, akMind.memory_abuse_reason[i])
		JsonUtil.SetStringValue(fileName,"memory_abuse_txt"+i, akMind.memory_abuse_txt[i])
		i +=1
	endwhile

	JsonUtil.Save(fileName)
	DOM01.HudNotification("Write DOM JSON success: "+akTarget.GetDisplayName())
EndFunction

Function ReadJSON(DOM_Actor akActor)
	if akActor == None
		DOM01.HudNotification("Read DOM JSON failed: invalid actor")
		return
	endif
	Actor akTarget = akActor.akRef
	if akTarget == None
		DOM01.HudNotification("Read DOM JSON failed: invalid actor")
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		DOM01.HudNotification("Read DOM JSON failed: invalid actor")
		return
	endif	
	akMind.RestorePersonality()
	GetTrainingStatsForcedRead(akActor)
	akMind.RestoreVirginity()
	akMind.RestoreHiddenKinks()
	SetMemories(akMind)
	DOM01.HudNotification("Read DOM JSON success: "+akTarget.GetDisplayName())
EndFunction

Function SetMemories(DOM_Mind akMind)
	if !ReadJSONMemoriesToggle
		return
	endif
	if akMind == NONE
		return
	endif
	Actor akRef = akMind.akRef
	bool is_unique = akRef.GetLeveledActorBase().IsUnique()
	if is_unique && !readJSONForUniques
		return
	elseif is_unique && !readJSONForSpawned
		return
	endif

	;LogTrace("SetMemories "+akMind.GetName())
	string fileName = OpenActorJSON(akRef)
	If fileName == "" || !JsonUtil.JsonExists(fileName)
		;LogTrace("SetMemories: json file does not exist: "+fileName)
		return
	endif
	LogTrace("SetMemories: Found json file for NPC "+akRef.GetDisplayName()+": "+fileName)
	
	float time = JsonUtil.GetFloatValue(fileName, "memory_capture_time", 0.0)
	int mood
	if time != 0.0
		akMind.memory_capture_time = time
		akMind.memory_capture_mood = JsonUtil.GetIntValue(fileName, "memory_capture_mood", 0)
		akMind.memory_capture_ntimes = JsonUtil.GetIntValue(fileName, "memory_capture_ntimes", 1)
		akMind.memory_capture_rtimes = JsonUtil.GetIntValue(fileName, "memory_capture_rtimes", 0)
		akMind.memory_capture_ftimes = JsonUtil.GetIntValue(fileName, "memory_capture_ftimes", 0)
		akMind.memory_capture_location = JsonUtil.GetStringValue(fileName,"memory_capture_location", "")
		akMind.memory_capture_occupation =  JsonUtil.GetStringValue(fileName,"memory_capture_occupation", "")
		akMind.memory_capture_origin = JsonUtil.GetStringValue(fileName,"memory_capture_origin", "")
		akMind.memory_capture_type = JsonUtil.GetStringValue(fileName,"memory_capture_type", "")
		akMind.memory_capture_txt = JsonUtil.GetStringValue(fileName,"memory_capture_txt","")
		akMind.memory_origin_txt = JsonUtil.GetStringValue(fileName,"memory_origin_txt","")
	endif

	int kmax = akMind.memory_abuse_time.length
	int i = 0
	int ktot = 0
	while i < kmax
		time   = JsonUtil.GetFloatValue(fileName, "memory_abuse_time"+i,0.0)
		if time != 0.0
			akMind.memory_abuse_time[ktot] = time
			akMind.memory_abuse_category[ktot] = JsonUtil.GetIntValue(fileName, "memory_abuse_category"+i, 1)
			akMind.memory_abuse_mood[ktot] = JsonUtil.GetIntValue(fileName, "memory_abuse_mood"+i, 0)
			akMind.memory_abuse_level[ktot] = JsonUtil.GetIntValue(fileName, "memory_abuse_level"+i, 0)
			akMind.memory_abuse_ntimes[ktot] = JsonUtil.GetIntValue(fileName, "memory_abuse_ntimes"+i, 1)
			int respectful = JsonUtil.GetIntValue(fileName, "memory_abuse_respectful"+i, 0)
			if respectful > 0
				akMind.memory_abuse_respectful[ktot] = true
			else
				akMind.memory_abuse_respectful[ktot] = false
			endif
			int flag = JsonUtil.GetIntValue(fileName, "memory_abuse_flag"+i, 0)
			if flag > 0
				akMind.memory_abuse_flag[ktot] = true
			else
				akMind.memory_abuse_flag[ktot] = false
			endif
			akMind.memory_abuse_type[ktot] = JsonUtil.GetStringValue(fileName,"memory_abuse_type"+i, "")
			akMind.memory_abuse_reason[ktot] = JsonUtil.GetStringValue(fileName,"memory_abuse_reason"+i, "")
			akMind.memory_abuse_txt[ktot] = JsonUtil.GetStringValue(fileName,"memory_abuse_txt"+i, "")
			ktot += 1
		endif
		i += 1
	endwhile
	if ktot > 0
		akMind.memory_entries = ktot
	endif
EndFunction

Function PrintTraits(string title, Float[] TraitsArray)
	int i = 0
	int n = TraitsArray.length
	if n > __traitNames.length
		n = __traitNames.length
	endif
    while i < n
  		LogTrace(title+" "+__traitNames[i]+"="+TraitsArray[i])
		i += 1
   endwhile
EndFunction

Function GetActorKinksRead(Actor akTarget)
	if !ReadJSONKinksToggle
		return
	endif
	int kmax = 8
	ActorBase abTarget = akTarget.GetLeveledActorBase()
	int actorSex = abTarget.GetSex()
	int k = GetHiddenKinksNumber(akTarget,actorSex,kmax)
	int i = 0
	while i < k
		int ikink = GetHiddenKink(akTarget,actorSex,i)
		if ikink > 0
			if i == 0
				akTarget.SetFactionRank(DOMHiddenKink0,ikink)
			elseif i == 1
				akTarget.SetFactionRank(DOMHiddenKink1,ikink)
			elseif i == 2
				akTarget.SetFactionRank(DOMHiddenKink2,ikink)
			elseif i == 3
				akTarget.SetFactionRank(DOMHiddenKink3,ikink)
			elseif i == 4
				akTarget.SetFactionRank(DOMHiddenKink4,ikink)
			elseif i == 5
				akTarget.SetFactionRank(DOMHiddenKink5,ikink)
			elseif i == 6
				akTarget.SetFactionRank(DOMHiddenKink6,ikink)
			elseif i == 7
				akTarget.SetFactionRank(DOMHiddenKink7,ikink)
			endif
		endif
		i += 1
	endwhile
EndFunction

float Function GetSubmissionTraining(string fileName, Actor akRef)
	if DOMPAH.hasSubmissionTraining(akRef)
		float rank1 = DOMPAH.GetSubmissionFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "xsubmission", rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "xsubmission", 0.0)
EndFunction

float Function GetFearTraining(string fileName, Actor akRef)
	;LogTrace("GetFearTraining "+fileName+" "+akRef.GetDisplayName())
	if DOMPAH.hasFearTraining(akRef)
		float rank1 = DOMPAH.GetFearFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "xfeartraining", rank1)
		;LogTrace("GetFearTraining "+akRef.GetDisplayName()+" "+rank1+"/"+rank2)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	;LogTrace("GetFearTraining "+akRef.GetDisplayName()+" "+JsonUtil.GetFloatValue(fileName, "xfeartraining", 0.0))
	return JsonUtil.GetFloatValue(fileName, "xfeartraining", 0.0)
EndFunction

float Function GetHumiliationTraining(string fileName, Actor akRef)
	if DOMPAH.hasHumiliationTraining(akRef)
		float rank1 = DOMPAH.GetHumiliationFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "xhumiliation", rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "xhumiliation", 0.0)
EndFunction

float Function GetAngerTraining(string fileName, Actor akRef)
	if DOMPAH.hasAngerTraining(akRef)
		float rank1 = DOMPAH.GetAngerFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "xangertraining", rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "xangertraining", 0.0)
EndFunction

float Function GetResignationTraining(string fileName, Actor akRef)
	if DOMPAH.hasResignationTraining(akRef)
		float rank1 = DOMPAH.GetResignationFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "xresignation", rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "xresignation", 0.0)
EndFunction

float Function GetRespectTraining(string fileName, Actor akRef)
	if DOMPAH.hasRespectTraining(akRef)
		float rank1 = DOMPAH.GetRespectFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "xrespecttraining", rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "xrespecttraining", 0.0)
EndFunction

float Function GetPoseTraining(string fileName, Actor akRef)
	if DOMPAH.hasRespectTraining(akRef)
		float rank1 = DOMPAH.GetPoseFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "zPoseTraining", rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "zPoseTraining", 0.0)
EndFunction

float Function GetOralTraining(string fileName, Actor akRef)
	;LogTrace("GetOralTraining "+akRef.GetDisplayName()+" fileName="+fileName)
	if DOMPAH.hasOralTraining(akRef)
		float rank1 = DOMPAH.GetOralFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "zOralTraining", rank1)
		if rank2 > rank1
			;LogTrace("GetOralTraining "+akRef.GetDisplayName()+" fileName="+fileName+" file>rank oral="+rank2)
			return rank2
		endif
		;LogTrace("GetOralTraining "+akRef.GetDisplayName()+" fileName="+fileName+" rank>file oral="+rank1)
		return rank1
	endif
	float x = JsonUtil.GetFloatValue(fileName, "zOralTraining", 0.0)
	;LogTrace("GetOralTraining "+akRef.GetDisplayName()+" fileName="+fileName+" file oral="+x)
	return x
EndFunction

float Function GetVaginalTraining(string fileName, Actor akRef)
	LogTrace("GetVaginalTraining "+DOMPAH.hasVaginalTraining(akRef))
	if DOMPAH.hasVaginalTraining(akRef)
		float rank1 = DOMPAH.GetVaginalFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "zVaginalTraining", rank1)
		LogTrace("GetVaginalTraining rank1="+rank1+" rank2="+rank2)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "zVaginalTraining", 0.0)
EndFunction

float Function GetAnalTraining(string fileName, Actor akRef)
	if DOMPAH.hasAnalTraining(akRef)
		float rank1 = DOMPAH.GetAnalFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "zAnalTraining", rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "zAnalTraining", 0.0)
EndFunction

float Function GetCombatTraining(string fileName, Actor akRef)
	if DOMPAH.hasCombatTraining(akRef)
		float rank1 = DOMPAH.GetCombatFromFaction(akRef)
		float rank2 = JsonUtil.GetFloatValue(fileName, "zCombatTraining", rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetFloatValue(fileName, "zCombatTraining", 0.0)
EndFunction

float Function GetTrainingFloat(string fileName, Actor akRef, string keyName, Faction the_faction)
	;LogTrace("GetTrainingFloat "+fileName+" "+akRef.GetDisplaYName()+" "+keyName+" "+the_faction.GetName())
	if the_faction != None && akRef.IsInFaction(the_faction)
		float rank1 = akRef.GetFactionRank(the_faction)
		float rank2 = JsonUtil.GetFloatValue(fileName, keyName, rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	;LogTrace("GetTrainingFloat "+fileName+" "+akRef.GetDisplaYName()+" "+keyName+" ="+JsonUtil.GetFloatValue(fileName, keyName, 0.0))
	return JsonUtil.GetFloatValue(fileName, keyName, 0.0)
EndFunction

int Function GetTrainingInt(string fileName, Actor akRef, string keyName, Faction the_faction)
	if the_faction != None && akRef.IsInFaction(the_faction)
		int rank1 = akRef.GetFactionRank(the_faction)
		int rank2 = JsonUtil.GetIntValue(fileName, keyName, rank1)
		if rank2 > rank1
			return rank2
		endif
		return rank1
	endif
	return JsonUtil.GetIntValue(fileName, keyName, 0)
EndFunction

Function GetTrainingStatsRead(Actor akTarget)	
	if !ReadJSONTrainingToggle && !ReadJSONRelationshipToggle
		return
	endif
	bool is_unique = akTarget.GetLeveledActorBase().IsUnique()
	if is_unique && !readJSONForUniques
		return
	elseif is_unique && !readJSONForSpawned
		return
	endif
	; Fixed values from JSON files for choosen NPC
	string fileName = OpenActorJSON(akTarget)
	If fileName == "" || !JsonUtil.JsonExists(fileName)
		;LogTrace("GetTrainingStatsRead: json file does not exist: "+fileName)
		return
	endif
	
	string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akTarget.GetDisplayName())
	LogTrace("GetTrainingStatsRead: Found json file for NPC "+nameJSON+" "+fileName)
		
	; Relationship to Player
	if ReadJSONRelationshipToggle
		akTarget.SetRelationShipRank(PlayerRef,JsonUtil.GetIntValue(fileName, "playerrelationship", akTarget.GetRelationshipRank(PlayerRef)))
	endif
	
	if !ReadJSONTrainingToggle
		return
	endif

	; Training stats
	GetFactionFromJSONFloatValue(filename, akTarget, "wskillenforcer", DOMSkillEnforcer)
	GetFactionFromJSONFloatValue(filename, akTarget, "wskillpersuader",DOMSkillPersuader)
	GetFactionFromJSONFloatValue(filename, akTarget, "wskilldepraver", DOMSkillDepraver)
	GetFactionFromJSONFloatValue(filename, akTarget, "wskillpredator", DOMSkillPredator)
	GetFactionFromJSONFloatValue(filename, akTarget, "wskillslaver",   DOMSkillSlaver)
	GetFactionFromJSONFloatValue(filename, akTarget, "wskilldeceiver", DOMSkillDeceiver)

	GetFactionFromJSONFloatValue(filename, akTarget, "xsubmission", DOMTrainSubmission)
	GetFactionFromJSONFloatValue(filename, akTarget, "xfeartraining", DOMTrainFear)
	GetFactionFromJSONFloatValue(filename, akTarget, "xhumiliation", DOMTrainHumiliation)
	GetFactionFromJSONFloatValue(filename, akTarget, "xangertraining", DOMTrainAnger)
	GetFactionFromJSONFloatValue(filename, akTarget, "xresignation", DOMTrainResignation)
	GetFactionFromJSONFloatValue(filename, akTarget, "xrespecttraining", DOMTrainRespect)

	GetFactionFromJSONFloatValue(filename, akTarget, "ylovedesire", DOMLoveDesire)
	GetFactionFromJSONFloatValue(filename, akTarget, "yloyalworship", DOMLoyalWorship)
	GetFactionFromJSONFloatValue(filename, akTarget, "ylovefascination", DOMLoveFascination)
	GetFactionFromJSONFloatValue(filename, akTarget, "yloyalabsolution", DOMLoyalAbsolution)
	GetFactionFromJSONFloatValue(filename, akTarget, "yloveadmiration", DOMLoveAdmiration)
	GetFactionFromJSONFloatValue(filename, akTarget, "yloyaldevotion", DOMLoyalDevotion)
	
	GetFactionFromJSONFloatValue(filename, akTarget, "zPoseTraining", DOMTrainPose)
	GetFactionFromJSONFloatValue(filename, akTarget, "zOralTraining", DOMTrainOral)
	GetFactionFromJSONFloatValue(filename, akTarget, "zVaginalTraining", DOMTrainVaginal)
	GetFactionFromJSONFloatValue(filename, akTarget, "zAnalTraining", DOMTrainAnal)
	GetFactionFromJSONFloatValue(filename, akTarget, "zCombatTraining", DOMTrainCombat)
	GetFactionFromJSONFloatValue(filename, akTarget, "zHouseTraining", DOMTrainHouse)
	GetFactionFromJSONFloatValue(filename, akTarget, "zWorkTraining", DOMTrainWorking)
	GetFactionFromJSONFloatValue(filename, akTarget, "trauma",        DOMTraumaInDays)

	; Counters
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_pain", DOMNbPain)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_bondage", DOMNbBondage)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_shame", DOMNbShame)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_rape", DOMNbRape)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_drug", DOMNbDrug)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_sex", DOMNbSex)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_sexformoney",   DOMNbSexForMoney)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_sexwithothers", DOMNbSexWithOthers)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_kinktrigger",   DOMNbKinkTrigger)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_orgasm", DOMNborgasm)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_toldoff", DOMNbToldoff)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_praise", DOMNbpraise)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_comfort", DOMNbcomfort)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_insult", DOMNbinsult)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_flatter", DOMNbflatter)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_threat", DOMNbThreat)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_promise", DOMNbpromise)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_chat_feelings", DOMNbChatFeelings)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_chat_personality", DOMNbChatPersonality)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_shock", DOMNbShock)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_broken", DOMNbBroken)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_brainwashed", DOMNbBrainwashed)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_trainee", DOMNbTrainee)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_trainer", DOMNbTrainer)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_whoredslaves", DOMNbWhoredSlaves)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_recruitedslavers", DOMNbRecruitedSlavers)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_ransomedslaves", DOMNbRansomedSlaves)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_capturedslaves", DOMNbCapturedSlaves)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_brokenslaves", DOMNbBrokenSlaves)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_soldslaves", DOMNbSoldSlaves)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_player_fling", DOMNbPlayerFling)
	GetFactionFromJSONIntValue(filename, akTarget, "number_of_player_chat", DOMNbPlayerChat)
		
	int number_of_sex  = aktarget.GetFactionRank(DOMNbSex)
	int number_of_rape = aktarget.GetFactionRank(DOMNbRape)
	if number_of_sex < number_of_rape 
		aktarget.SetFactionRank(DOMNbSex,number_of_rape)
	endif
EndFunction

; Get JSON value
; Set faction rank to value
Function GetFactionFromJSONFloatValue(string filename, Actor akTarget, string the_key, Faction the_faction)
	int value = (JsonUtil.GetFloatValue(fileName, the_key, 0.0)) as int
	if value > 0
		akTarget.SetFactionRank(the_faction, value)
	else
		akTarget.RemoveFromFaction(the_faction)
	endif
EndFunction

; Get value from faction or JSON whichever is highest
; Set faction rank, if rank is 0 or lower remove from faction
Function GetFactionOrJSONFloatValue(string filename, Actor akTarget, string the_key, Faction the_faction)
	float value = GetTrainingFloat(fileName,akTarget,the_key,the_faction)
	SetFactionRank(akTarget, the_faction, value as int)
EndFunction

Function GetFactionFromJSONIntValue(string filename, Actor akTarget, string the_key, Faction the_faction)
	int value = JsonUtil.GetIntValue(fileName, the_key, 0)
	if value > 0
		akTarget.SetFactionRank(the_faction, value)
	else
		akTarget.RemoveFromFaction(the_faction)
	endif
EndFunction

Function GetFactionOrJSONIntValue(string filename, Actor akTarget, string the_key, Faction the_faction)
	int value = GetTrainingInt(fileName,akTarget,the_key,the_faction)
	SetFactionRank(akTarget, the_faction, value)
EndFunction

Function GetTrainingStatsFromFactionsOrRead(Actor akTarget)
	; Fixed values from JSON files for choosen NPC
	if !ReadJSONTrainingToggle && !ReadJSONRelationshipToggle
		;LogTrace("GetTrainingStatsFromFactionsOrRead: json file reading turned off for training stats and player's relationship")
		return
	endif
	string fileName = OpenActorJSON(akTarget)
	If fileName == "" || !JsonUtil.JsonExists(fileName)
		;LogTrace("GetTrainingStatsFromFactionsOrRead: json file does not exist: "+fileName)
		return
	endif
	
	string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akTarget.GetDisplayName())
	;LogTrace("GetTrainingStatsFromFactionsOrRead: Found json file for NPC "+nameJSON+" "+fileName)

	; Recover PAH factions
	DOMPAH.CheckTrainingFactions(akTarget)	

	; Relationship to Player
	if ReadJSONRelationshipToggle
		int rank1 = akTarget.GetRelationshipRank(PlayerRef)
		int rank2 = JsonUtil.GetIntValue(fileName, "playerrelationship", rank1)
		;LogTrace("GetTrainingStatsFromFactionsOrRead PlayerRelationship="+rank1+"/"+rank2)
		if rank2 > rank1
			akTarget.SetRelationShipRank(PlayerRef,rank2)
		endif
	endif
	if !ReadJSONTrainingToggle
		;LogTrace("GetTrainingStatsFromFactionsOrRead: json file reading turned off for training stats")
		return
	endif

	; Training stats
	SetFactionRank(akTarget,DOMTrainSubmission,GetSubmissionTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTrainFear,GetFearTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTrainHumiliation,GetHumiliationTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTrainAnger,GetAngerTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTrainResignation,GetResignationTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTrainRespect, GetRespectTraining(fileName,akTarget) as int)
	
	GetFactionOrJSONFloatValue(fileName,akTarget,"ylovedesire",DOMLoveDesire)
	GetFactionOrJSONFloatValue(fileName,akTarget,"yloyalworship",DOMLoyalWorship)
	GetFactionOrJSONFloatValue(fileName,akTarget,"ylovefascination",DOMLoveFascination)
	GetFactionOrJSONFloatValue(fileName,akTarget,"yloyalabsolution",DOMLoyalAbsolution)
	GetFactionOrJSONFloatValue(fileName,akTarget,"yloveadmiration",DOMLoveAdmiration)
	GetFactionOrJSONFloatValue(fileName,akTarget,"yloyaldevotion",DOMLoyalDevotion)

	SetFactionRank(akTarget,DOMTrainpose, GetPoseTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTrainoral, GetOralTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTrainvaginal, GetVaginalTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTrainanal, GetAnalTraining(fileName,akTarget) as int)
	SetFactionRank(akTarget,DOMTraincombat, GetCombatTraining(fileName,akTarget) as int)
	GetFactionOrJSONFloatValue(fileName,akTarget,"zHouseTraining",DOMTrainHouse)
	GetFactionOrJSONFloatValue(fileName,akTarget,"zWorkTraining", DOMTrainWorking)
	GetFactionOrJSONFloatValue(fileName,akTarget,"trauma", DOMTraumaInDays)
		
	GetFactionOrJSONFloatValue(fileName,akTarget,"wskillenforcer",   DOMSkillEnforcer)
	GetFactionOrJSONFloatValue(fileName,akTarget,"wskillpredator",    DOMSkillPredator)
	GetFactionOrJSONFloatValue(fileName,akTarget,"wskilldepraver",    DOMSkillDepraver)
	GetFactionOrJSONFloatValue(fileName,akTarget,"wskillpersuader",   DOMSkillPersuader)
	GetFactionOrJSONFloatValue(fileName,akTarget,"wskillslaver",     DOMSkillSlaver)
	GetFactionOrJSONFloatValue(fileName,akTarget,"wskilldeceiver",    DOMSkillDeceiver)
	
	; Counters
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_pain", DOMNbPain)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_bondage", DOMNbBondage)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_shame", DOMNbShame)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_rape", DOMNbRape)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_drug", DOMNbDrug)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_sex", DOMNbSex)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_sexformoney",   DOMNbSexForMoney)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_sexwithothers", DOMNbSexWithOthers)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_kinktrigger",   DOMNbKinkTrigger)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_orgasm", DOMNborgasm)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_toldoff", DOMNbToldoff)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_praise", DOMNbpraise)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_comfort", DOMNbcomfort)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_insult", DOMNbinsult)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_flatter", DOMNbflatter)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_threat", DOMNbThreat)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_promise", DOMNbpromise)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_chat_feelings", DOMNbChatFeelings)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_chat_personality", DOMNbChatPersonality)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_shock", DOMNbShock)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_broken", DOMNbBroken)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_brainwashed", DOMNbBrainwashed)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_trainee", DOMNbTrainee)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_trainer", DOMNbTrainer)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_whoredslaves", DOMNbWhoredSlaves)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_recruitedslavers", DOMNbRecruitedSlavers)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_ransomedslaves", DOMNbRansomedSlaves)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_capturedslaves", DOMNbCapturedSlaves)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_soldslaves", DOMNbSoldSlaves)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_brokenslaves", DOMNbBrokenSlaves)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_player_fling", DOMNbPlayerFling)
	GetFactionOrJSONIntValue(fileName,akTarget, "number_of_player_chat", DOMNbPlayerChat)
		
	int number_of_sex  = aktarget.GetFactionRank(DOMNbSex)
	int number_of_rape = aktarget.GetFactionRank(DOMNbRape)
	if number_of_sex < number_of_rape 
		aktarget.SetFactionRank(DOMNbSex,number_of_rape)
	endif
EndFunction

Function GetTrainingStatsForcedRead(DOM_Actor akActor)
	if !ReadJSONTrainingToggle && !ReadJSONRelationshipToggle
		return
	endif
	Actor akRef = akActor.akRef

	DOM_Mind akMind = akActor.mind
	; Fixed values from JSON files for choosen NPC
	string fileName = OpenActorJSON(akRef)
	If fileName == "" || !JsonUtil.JsonExists(fileName)
		;LogTrace("GetTrainingStatsForcedRead: json file does not exist: "+fileName)
		return
	endif
	
	string nameJSON   = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
	string titleJSON  = JsonUtil.GetStringValue(fileName, "fulltitle", "")
	string genderJSON = JsonUtil.GetStringValue(fileName, "fullgender", "")
	LogTrace("GetTrainingStatsForcedRead: Found json file for NPC "+titleJSON+" "+nameJSON+" "+fileName)
		
	; Relationship to Player
	if ReadJSONRelationshipToggle
		akRef.SetRelationShipRank(PlayerRef,JsonUtil.GetIntValue(fileName, "playerrelationship", akRef.GetRelationshipRank(PlayerRef)))
	endif
	if !ReadJSONTrainingToggle
		return
	endif
	
	akActor.SetDisplayName(nameJSON)
	akMind.SetDisplayName(nameJSON)
	akActor.SetTitle(titleJSON)
	akMind.SetTitle(titleJSON)
	akActor.SetGenderByString(genderJSON)
	akMind.SetGenderByString(genderJSON)

	; Training stats
	akMind.submission       = GetSubmissionTraining(fileName,akRef)
	akMind.fear_training    = GetFearTraining(fileName,akRef)
	akMind.humiliation      = GetHumiliationTraining(fileName,akRef)
	akMind.anger_training   = GetAngerTraining(fileName,akRef)
	akMind.resignation      = GetResignationTraining(fileName,akRef)
	akMind.respect_training = GetRespectTraining(fileName,akRef)
	
	akMind.love_desire      = GetTrainingFloat(fileName,akRef,"ylovedesire",DOMLoveDesire)
	akMind.loyal_worship    = GetTrainingFloat(fileName,akRef,"yloyalworship",DOMLoyalWorship)
	akMind.love_fascination = GetTrainingFloat(fileName,akRef,"ylovefascination",DOMLoveFascination)
	akMind.loyal_absolution = GetTrainingFloat(fileName,akRef,"yloyalabsolution",DOMLoyalAbsolution)
	akMind.love_admiration  = GetTrainingFloat(fileName,akRef,"yloveadmiration",DOMLoveAdmiration)
	akMind.loyal_devotion   = GetTrainingFloat(fileName,akRef,"yloyaldevotion",DOMLoyalDevotion)

	akMind.pose_training    = GetPoseTraining(fileName,akRef)
	akMind.oral_training    = GetOralTraining(fileName,akRef)
	akMind.vaginal_training = GetVaginalTraining(fileName,akRef)
	akMind.anal_training    = GetAnalTraining(fileName,akRef)
	akMind.combat_training  = GetCombatTraining(fileName,akRef)
	akMind.house_training   = GetTrainingFloat(fileName,akRef,"zHouseTraining",DOMTrainHouse)
	akMind.work_training    = GetTrainingFloat(fileName,akRef,"zWorkTraining", DOMTrainWorking)
	akMind.timer_for_broken = GetTrainingFloat(fileName,akRef,"trauma", DOMTraumaInDays)
		
	akMind.skill_enforcer   = GetTrainingFloat(fileName,akRef,"wskillenforcer",   DOMSkillEnforcer)
	akMind.skill_predator   = GetTrainingFloat(fileName,akRef,"wskillpredator",    DOMSkillPredator)
	akMind.skill_depraver   = GetTrainingFloat(fileName,akRef,"wskilldepraver",    DOMSkillDepraver)
	akMind.skill_persuader  = GetTrainingFloat(fileName,akRef,"wskillpersuader",   DOMSkillPersuader)
	akMind.skill_slaver     = GetTrainingFloat(fileName,akRef,"wskillslaver",     DOMSkillSlaver)
	akMind.skill_deceiver   = GetTrainingFloat(fileName,akRef,"wskilldeceiver",    DOMSkillDeceiver)
	
	; Counters
	akMind.number_of_pain   = GetTrainingInt(fileName,akRef, "number_of_pain", DOMNbPain)
	akMind.number_of_bondage= GetTrainingInt(fileName,akRef, "number_of_bondage", DOMNbBondage)
	akMind.number_of_shame  = GetTrainingInt(fileName,akRef, "number_of_shame", DOMNbShame)
	akMind.number_of_rape   = GetTrainingInt(fileName,akRef, "number_of_rape", DOMNbRape)
	akMind.number_of_rape   = GetTrainingInt(fileName,akRef, "number_of_drug", DOMNbDrug)
	akMind.number_of_sex    = GetTrainingInt(fileName,akRef, "number_of_sex", DOMNbSex)
	akMind.number_of_sexformoney      = GetTrainingInt(fileName,akRef, "number_of_sexformoney",   DOMNbSexForMoney)
	akMind.number_of_sexwithothers    = GetTrainingInt(fileName,akRef, "number_of_sexwithothers", DOMNbSexWithOthers)
	akMind.number_of_kinktrigger      = GetTrainingInt(fileName,akRef, "number_of_kinktrigger",   DOMNbKinkTrigger)
	akMind.number_of_orgasm = GetTrainingInt(fileName,akRef, "number_of_orgasm", DOMNborgasm)
	akMind.number_of_toldoff= GetTrainingInt(fileName,akRef, "number_of_toldoff", DOMNbToldoff)
	akMind.number_of_praise = GetTrainingInt(fileName,akRef, "number_of_praise", DOMNbpraise)
	akMind.number_of_comfort= GetTrainingInt(fileName,akRef, "number_of_comfort", DOMNbcomfort)
	akMind.number_of_insult = GetTrainingInt(fileName,akRef, "number_of_insult", DOMNbinsult)
	akMind.number_of_flatter= GetTrainingInt(fileName,akRef, "number_of_flatter", DOMNbflatter)
	akMind.number_of_threat = GetTrainingInt(fileName,akRef, "number_of_threat", DOMNbThreat)
	akMind.number_of_promise= GetTrainingInt(fileName,akRef, "number_of_promise", DOMNbpromise)
	akMind.number_of_chat_feelings= GetTrainingInt(fileName,akRef, "number_of_chat_feelings", DOMNbChatFeelings)
	akMind.number_of_chat_personality= GetTrainingInt(fileName,akRef, "number_of_chat_personality", DOMNbChatPersonality)
	akMind.number_of_shock  = GetTrainingInt(fileName,akRef, "number_of_shock", DOMNbShock)
	akMind.number_of_broken = GetTrainingInt(fileName,akRef, "number_of_broken", DOMNbBroken)
	akMind.number_of_brainwashed = GetTrainingInt(fileName,akRef, "number_of_brainwashed", DOMNbBrainwashed)
	akMind.number_of_trainee= GetTrainingInt(fileName,akRef, "number_of_trainee", DOMNbTrainee)
	akMind.number_of_trainer= GetTrainingInt(fileName,akRef, "number_of_trainer", DOMNbTrainer)
	akMind.number_of_whoredslaves= GetTrainingInt(fileName,akRef, "number_of_whoredslaves", DOMNbWhoredSlaves)
	akMind.number_of_recruitedslavers= GetTrainingInt(fileName,akRef, "number_of_recruitedslavers", DOMNbRecruitedSlavers)
	akMind.number_of_ransomedslaves= GetTrainingInt(fileName,akRef, "number_of_ransomedslaves", DOMNbRansomedSlaves)
	akMind.number_of_capturedslaves= GetTrainingInt(fileName,akRef, "number_of_capturedslaves", DOMNbCapturedSlaves)
	akMind.number_of_soldslaves= GetTrainingInt(fileName,akRef, "number_of_soldslaves", DOMNbSoldSlaves)
	akMind.number_of_brokenslaves= GetTrainingInt(fileName,akRef, "number_of_brokenslaves", DOMNbBrokenSlaves)
	akMind.number_of_player_fling= GetTrainingInt(fileName,akRef, "number_of_player_fling", DOMNbPlayerFling)
	akMind.number_of_player_chat = GetTrainingInt(fileName,akRef, "number_of_player_chat", DOMNbPlayerChat)
		
	if akMind.number_of_sex < akMind.number_of_rape 
		akMind.number_of_sex = akMind.number_of_rape
	endif
	
	; Clean PAH factions to avoid weird update
	DOMPAH.ClearTrainingFactions(akRef)
EndFunction

Function GetTrainingStatsFromFactions(DOM_Mind akMind)
	Actor akRef = akMind.akRef
		
	; Training stats
	akMind.submission       = DOMPAH.GetSubmissionFromFaction(akRef)
	akMind.fear_training    = DOMPAH.GetFearFromFaction(akRef)
	akMind.humiliation      = DOMPAH.GetHumiliationFromFaction(akRef)
	akMind.anger_training   = DOMPAH.GetAngerFromFaction(akRef)
	akMind.resignation      = DOMPAH.GetResignationFromFaction(akRef)
	akMind.respect_training = DOMPAH.GetRespectFromFaction(akRef)
	
	akMind.love_desire      = GetFactionRankFloat(akRef,DOMLoveDesire)
	akMind.loyal_worship    = GetFactionRankFloat(akRef,DOMLoyalWorship)
	akMind.love_fascination = GetFactionRankFloat(akRef,DOMLoveFascination)
	akMind.loyal_absolution = GetFactionRankFloat(akRef,DOMLoyalAbsolution)
	akMind.love_admiration  = GetFactionRankFloat(akRef,DOMLoveAdmiration)
	akMind.loyal_devotion   = GetFactionRankFloat(akRef,DOMLoyalDevotion)

	akMind.pose_training    = DOMPAH.GetPoseFromFaction(akRef)
	akMind.oral_training    = DOMPAH.GetOralFromFaction(akRef)
	akMind.vaginal_training = DOMPAH.GetVaginalFromFaction(akRef)
	akMind.anal_training    = DOMPAH.GetAnalFromFaction(akRef)
	akMind.combat_training  = DOMPAH.GetCombatFromFaction(akRef)
	akMind.house_training   = GetFactionRankFloat(akRef,DOMTrainHouse)
	akMind.work_training    = GetFactionRankFloat(akRef, DOMTrainWorking)
	akMind.timer_for_broken = GetFactionRankFloat(akRef, DOMTraumaInDays)
	;LogTrace("GetTrainingStatsFromFactions "+akActor.GetName()+" oral="+akMind.oral_training)
		
	akMind.skill_enforcer   = GetFactionRankFloat(akRef,   DOMSkillEnforcer)
	akMind.skill_predator   = GetFactionRankFloat(akRef,    DOMSkillPredator)
	akMind.skill_depraver   = GetFactionRankFloat(akRef,    DOMSkillDepraver)
	akMind.skill_persuader  = GetFactionRankFloat(akRef,   DOMSkillPersuader)
	akMind.skill_slaver     = GetFactionRankFloat(akRef,     DOMSkillSlaver)
	akMind.skill_deceiver   = GetFactionRankFloat(akRef,    DOMSkillDeceiver)
	
	; Counters
	akMind.number_of_pain   = GetFactionRankInt(akRef, DOMNbPain)
	akMind.number_of_bondage= GetFactionRankInt(akRef, DOMNbBondage)
	akMind.number_of_shame  = GetFactionRankInt(akRef, DOMNbShame)
	akMind.number_of_rape   = GetFactionRankInt(akRef, DOMNbRape)
	akMind.number_of_drug   = GetFactionRankInt(akRef, DOMNbDrug)
	akMind.number_of_sex    = GetFactionRankInt(akRef, DOMNbSex)
	akMind.number_of_sexformoney      = GetFactionRankInt(akRef, DOMNbSexForMoney)
	akMind.number_of_sexwithothers    = GetFactionRankInt(akRef, DOMNbSexWithOthers)
	akMind.number_of_kinktrigger      = GetFactionRankInt(akRef, DOMNbKinkTrigger)
	akMind.number_of_orgasm = GetFactionRankInt(akRef, DOMNborgasm)
	akMind.number_of_toldoff= GetFactionRankInt(akRef, DOMNbToldoff)
	akMind.number_of_praise = GetFactionRankInt(akRef, DOMNbpraise)
	akMind.number_of_comfort= GetFactionRankInt(akRef, DOMNbcomfort)
	akMind.number_of_insult = GetFactionRankInt(akRef, DOMNbinsult)
	akMind.number_of_flatter= GetFactionRankInt(akRef, DOMNbflatter)
	akMind.number_of_threat = GetFactionRankInt(akRef, DOMNbThreat)
	akMind.number_of_promise= GetFactionRankInt(akRef, DOMNbpromise)
	akMind.number_of_chat_feelings= GetFactionRankInt(akRef, DOMNbChatFeelings)
	akMind.number_of_chat_personality= GetFactionRankInt(akRef, DOMNbChatPersonality)
	akMind.number_of_shock  = GetFactionRankInt(akRef, DOMNbShock)
	akMind.number_of_broken = GetFactionRankInt(akRef, DOMNbBroken)
	akMind.number_of_brainwashed = GetFactionRankInt(akRef, DOMNbBrainwashed)
	akMind.number_of_trainee= GetFactionRankInt(akRef, DOMNbTrainee)
	akMind.number_of_trainer= GetFactionRankInt(akRef, DOMNbTrainer)
	akMind.number_of_whoredslaves= GetFactionRankInt(akRef, DOMNbWhoredSlaves)
	akMind.number_of_ransomedslaves= GetFactionRankInt(akRef, DOMNbRansomedSlaves)
	akMind.number_of_capturedslaves= GetFactionRankInt(akRef, DOMNbCapturedSlaves)
	akMind.number_of_soldslaves= GetFactionRankInt(akRef, DOMNbSoldSlaves)
	akMind.number_of_brokenslaves= GetFactionRankInt(akRef, DOMNbBrokenSlaves)
	akMind.number_of_player_fling= GetFactionRankInt(akRef, DOMNbPlayerFling)
	akMind.number_of_player_chat = GetFactionRankInt(akRef, DOMNbPlayerChat)
		
	if akMind.number_of_sex < akMind.number_of_rape 
		akMind.number_of_sex = akMind.number_of_rape
	endif
EndFunction

int Function GetHiddenKinksNumber(Actor akRef, int actorSex, int kmax)
	if !ReadJSONKinksToggle
		return 0
	endif
	bool is_unique = akRef.GetLeveledActorBase().IsUnique()
	if is_unique && !readJSONForUniques
		return 0
	elseif !is_unique && !readJSONForSpawned
		return 0
	endif

	int idx = 0
	int nkinks = 0
	; Fixed values from JSON files for choosen NPC
	string fileName = OpenActorJSON(akRef)
	If fileName != "" && JsonUtil.JsonExists(fileName)
		string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
		while idx < kmax
			string kink_str = "hiddenkink"+idx
			string kink_name = ""
			int kink = JsonUtil.GetIntValue(fileName, kink_str, -1)
			if kink > 0
				kink_name = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			else
				kink_name = JsonUtil.GetStringValue(fileName, kink_str, "")
				kink = DOM01.GetJSONKinkReasonIndexByName(kink_name)
			endif
			if kink > 0 ; || kink_name != ""
				nkinks = idx+1
				;LogTrace("GetHiddenKinksNumber check: "+nameJSON+" Found "+kink_str+" idx="+kink+" "+kink_name)
			endif
			idx += 1
		endwhile
		;LogTrace("GetHiddenKinksNumber check: "+nameJSON+" Found json file with "+nkinks+"/"+kmax+" kinks for NPC "+nameJSON+" "+fileName)
	;Else
	;	LogTrace("GetHiddenKinksNumber check: json file does not exist: "+fileName)
	endif
	return nkinks
EndFunction

int Function GetKnownKinksNumber(Actor akRef, int actorSex, int kmax)
	if !ReadJSONKinksToggle
		return 0
	endif
	bool is_unique = akRef.GetLeveledActorBase().IsUnique()
	if is_unique && !readJSONForUniques
		return 0
	elseif !is_unique && !readJSONForSpawned
		return 0
	endif

	int idx = 0
	int nkinks = 0
	; Fixed values from JSON files for choosen NPC
	string fileName = OpenActorJSON(akRef)
	If fileName != "" && JsonUtil.JsonExists(fileName)
		string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
		while idx < kmax
			string kink_str = "knownkink"+idx
			string kink_name = ""
			int kink = JsonUtil.GetIntValue(fileName, kink_str, -1)
			if kink > 0
				kink_name = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			else
				kink_name = JsonUtil.GetStringValue(fileName, kink_str, "")
				kink = DOM01.GetJSONKinkReasonIndexByName(kink_name)
			endif
			if kink > 0 ; || kink_name != ""
				nkinks = idx+1
				;LogTrace("GetKnownKinksNumber check: "+nameJSON+" Found "+kink_str+" idx="+kink+" "+kink_name)
			endif
			idx += 1
		endwhile
		;LogTrace("GetKnownKinksNumber check: "+nameJSON+" Found json file with "+nkinks+"/"+kmax+" kinks for NPC "+nameJSON+" "+fileName)
	;Else
	;	LogTrace("GetKnownKinksNumber check: json file does not exist: "+fileName)
	endif
	return nkinks
EndFunction

int Function GetHiddenKink(Actor akRef, int actorSex, int idx)
	if !ReadJSONKinksToggle
		return 0
	endif
	if idx < 0
		return 0
	endif
	
	; See kink numbers and names in DOM_Util
	string kink_str = "hiddenkink"+idx
	int kink = 0
	int kink_check
	string kink_name

	; Fixed values from JSON files for choosen NPC
	string fileName = OpenActorJSON(akRef)
	If fileName != "" && JsonUtil.JsonExists(fileName)
		string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
		;LogTrace("GetHiddenKink: Found json file for NPC "+nameJSON+" "+fileName)
		kink = JsonUtil.GetIntValue(fileName, kink_str, -1)
		if kink > 0
			kink_name = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			kink_check = DOM01.GetJSONKinkReasonIndexByName(kink_name)
			if kink_check != kink
				kink = 0
			endif
		endif
		if kink <= 0
			kink_name = JsonUtil.GetStringValue(fileName, kink_str, "no kink")
			kink = DOM01.GetJSONKinkReasonIndexByName(kink_name)
		endif
		if kink > 0 && kink < 127
			LogTrace("GetHiddenKink Found json file for NPC "+nameJSON+" "+kink_str+" idx="+kink+" name="+kink_name)
			return kink
		endif
	;else
	;	LogTrace("GetHiddenKink: json file does not exist: "+fileName)
	endif
	return 0
EndFunction

int Function GetKnownKink(Actor akRef, int actorSex, int idx)
	if !ReadJSONKinksToggle
		return 0
	endif
	if idx < 0 ; || idx >= 6
		return 0
	endif
	
	; See kink numbers and names in DOM_Util
	string kink_str = "knownkink"+idx
	int kink = 0
	int kink_check
	string kink_name

	; Fixed values from JSON files for choosen NPC
	string fileName = OpenActorJSON(akRef)
	If fileName != "" && JsonUtil.JsonExists(fileName)
		string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
		;LogTrace("GetHiddenKink: Found json file for NPC "+nameJSON+" "+fileName)
		kink = JsonUtil.GetIntValue(fileName, kink_str, -1)
		if kink > 0
			kink_name = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			kink_check = DOM01.GetJSONKinkReasonIndexByName(kink_name)
			if kink_check != kink
				kink = 0
			endif
		endif
		if kink <= 0
			kink_name = JsonUtil.GetStringValue(fileName, kink_str, "no kink")
			kink = DOM01.GetJSONKinkReasonIndexByName(kink_name)
		endif
		if kink > 0 && kink < 127
			LogTrace("GetKnownKink Found json file for NPC "+nameJSON+" "+kink_str+" idx="+kink+" name="+kink_name)
			return kink
		endif
	;else
	;	LogTrace("GetKnownKink: json file does not exist: "+fileName)
	endif
	return 0
EndFunction

bool Function IsYoungAdult(string racestring)
	if StringUtil.Find(raceString, "Teen")>=0 || StringUtil.Find(raceString, "Teeen")>=0 || StringUtil.Find(raceString, "YoungAdult")>=0
		return true
	endif
	return false
EndFunction

bool Function IsChild(string racestring)
	if StringUtil.Find(raceString, "Child")>=0
		LogInfo("WARNING! IsChild actor is a child")
		return true
	endif
	if StringUtil.Find(raceString, "Kid")>=0
		LogInfo("WARNING! IsChild actor is a kid")
		return true
	endif
	return false
EndFunction

bool Function IsElder(string racestring)
	if StringUtil.Find(raceString, "Old")>=0 || StringUtil.Find(raceString, "Elder")>=0
		return true
	endif
	return false
EndFunction

; DOM_Mind virgin status 
; 0 = Virgin
; 1 = Soon not a virgin anymore
; 2 = Player took virginity
; 3 = Someone else took virginity
; 4 = Not a virgin since a long time ago
; JSON file virgin status
; 1 = Virgin
; 0 = Not a virgin since a long time ago

int[] Function GetVirginStatusReadOrGenerated(Actor akRef)
	; 0  = a virgin
	; 1  = lost virginity during current sexlab event
	; 2  = not a virgin anymore by player
	; 3  = not a virgin anymore by trainer
	; 4  = not a virgin historically
	int[] vstatus = new int[5]
	
	; Fixed values from JSON files for choosen NPC
	string fileName
	if !ReadJSONVirginityToggle
		fileName = ""
	else
		fileName = OpenActorJSON(akRef)
	endif
	If fileName != "" && JsonUtil.JsonExists(fileName)
		string nameJSON = JsonUtil.GetStringValue(fileName, "fullname", akRef.GetDisplayName())
		
		int v = JsonUtil.GetIntValue(fileName, "virginvaginal", -1)
		LogTrace("Virgin vaginal: Found for NPC "+nameJSON+" v="+v)
		if v == 1
			vstatus[0] = 0 ; 0=is a virgin
		elseif v == 0
			vstatus[0] = 4 ; 4=historically not a virgin
		else
			vstatus[0] = GetVaginalVirginDefaultStatus(akRef)
		endif
		v = JsonUtil.GetIntValue(fileName, "virginoral", -1)
		LogTrace("Virgin oral: Found for NPC "+nameJSON+" v="+v)
		if v == 1
			vstatus[1] = 0 ; 0=is a virgin
		elseif v == 0
			vstatus[1] = 4 ; 4=historically not a virgin
		else
			vstatus[1] = GetOralVirginDefaultStatus(akRef)
		endif
		v = JsonUtil.GetIntValue(fileName, "virginanal", -1)
		LogTrace("Virgin anal: Found for NPC "+nameJSON+" v="+v)
		if v == 1
			vstatus[2] = 0 ; 0=is a virgin
		elseif v == 0
			vstatus[2] = 4 ; 4=historically not a virgin
		else
			vstatus[2] = GetAnalVirginDefaultStatus(akRef)
		endif
		v = JsonUtil.GetIntValue(fileName, "virginsame", -1)
		LogTrace("Virgin same: Found for NPC "+nameJSON+" v="+v)
		if v == 1
			vstatus[3] = 0 ; 0=is a virgin
		elseif v == 0
			vstatus[3] = 4 ; 4=historically not a virgin
		else
			vstatus[3] = GetSameVirginDefaultStatus(akRef)
		endif
		v = JsonUtil.GetIntValue(fileName, "virgingangbang", -1)
		LogTrace("Virgin gangbang: Found for NPC "+nameJSON+" v="+v)
		if v == 1
			vstatus[4] = 0 ; 0=is a virgin
		elseif v == 0
			vstatus[4] = 4 ; 4=historically not a virgin
		else
			vstatus[4] = GetGangVirginDefaultStatus(akRef)
		endif
	else
		;LogTrace("Virgin status: json file does not exist: "+akRef.GetDisplayName()+" fileName="+fileName)
		vstatus[0] = GetVaginalVirginDefaultStatus(akRef)
		vstatus[1] = GetOralVirginDefaultStatus(akRef)
		vstatus[2] = GetAnalVirginDefaultStatus(akRef)
		vstatus[3] = GetSameVirginDefaultStatus(akRef)
		vstatus[4] = GetGangVirginDefaultStatus(akRef)
	endif
	return vstatus
EndFunction

int[] Function GetVirginStatusGenerated(Actor akRef)
	; 0  = a virgin
	; 1  = lost virginity during current sexlab event
	; 2  = not a virgin anymore by player
	; 3  = not a virgin anymore by trainer or NPC
	; 4  = not a virgin historically
	int[] vstatus = new int[5]
	vstatus[0] = GetVaginalVirginDefaultStatus(akRef)
	vstatus[1] = GetOralVirginDefaultStatus(akRef)
	vstatus[2] = GetAnalVirginDefaultStatus(akRef)
	vstatus[3] = GetSameVirginDefaultStatus(akRef)
	vstatus[4] = GetGangVirginDefaultStatus(akRef)

	;LogTrace("Virgin status: force generated: "+akRef.GetDisplayName())
	return vstatus
EndFunction

int Function GetVaginalVirginDefaultStatus(Actor akRef)
	if akRef.IsInFaction(DOMVirginVaginal)
		return akRef.GetFactionRank(DOMVirginVaginal)
	endif
	
	if !DOM01.virginVToggle
		return 4
	endif
	
	bool HasSpouse = DOM01.HasSpouse(akRef)
	bool HasLover = DOM01.HasLover(akRef)

	if HasSpouse || HasLover
		return 4		
	elseif akRef.GetFactionRank(DOMTrainVaginal) >= 1
		return 3		
	endif

	float chance = 0.6 ; Chance to not be a virgin
	; Races, some should not be in here anyhow
	actorBase abTarget = akRef.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	if IsElder(raceString)
		chance += 0.3
	elseif IsYoungAdult(raceString) || IsChild(raceString)
		return 0
	endif

	; get previous employers and jobs
	int jobs = akRef.getFactionRank(DOMJobOriginFaction)  
	int emps = akRef.getFactionRank(DOMEmployerOriginFaction) 

	if(jobs<0 && emps<0) ; Probably a unique NPC we need to evaluate
		jobs = GetJobOfOriginIndex(akRef)
		emps = GetEmployerOfOriginIndex(akRef)
	endif

	; This reflects only Skyrim jobs and employers not real life nor anyother part of Cyrodil
	if emps > 0 ; Works at court
		chance += 0.1
	endif
	if jobs < 4 ; Nobility
		chance += 0.2
	elseif jobs == 4 ; Bandit
		chance += 0.3
	elseif jobs == 9 ; Thief
		chance += 0.2
	elseif jobs == 25 ; Bards
		chance += 0.3
	elseif jobs == 40 || jobs == 41 ; Works at an inn
		chance += 0.3
	endif
	
	if RandomUniform() < chance
		return 4
	endif
	return 0
EndFunction

int Function GetAnalVirginDefaultStatus(Actor akRef)
	if akRef.IsInFaction(DOMVirginAnal)
		return akRef.GetFactionRank(DOMVirginAnal)
	endif

	if !DOM01.virginAToggle
		return 4
	endif

	float chance = 0.2 ; Chance to not be a virgin
	; Races, some should not be in here anyhow
	actorBase abTarget = akRef.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	if IsElder(raceString)
		chance += 0.3
	elseif IsYoungAdult(raceString) || IsChild(raceString)
		return 0
	endif

	if DOM01.HasSpouse(akRef)
		chance += 0.2
	elseif DOM01.HasLover(akRef)
		chance += 0.1
	endif

	; get previous employers and jobs
	int jobs = akRef.getFactionRank(DOMJobOriginFaction)  
	int emps = akRef.getFactionRank(DOMEmployerOriginFaction) 

	if(jobs<0 && emps<0) ; Probably a unique NPC we need to evaluate
		jobs = GetJobOfOriginIndex(akRef)
		emps = GetEmployerOfOriginIndex(akRef)
	endif

	; This reflects only Skyrim jobs and employers not real life nor anyother part of Cyrodil
	if emps > 0 ; Works at court
		chance += 0.2
	endif
	if jobs < 4 ; Nobility
		chance += 0.2
	elseif jobs == 4 ; Bandit
		chance += 0.2
	elseif jobs == 9 ; Thief
		chance += 0.2
	elseif jobs == 25 ; Bards
		chance += 0.3
	elseif jobs == 30 || jobs == 31 ; Merchant
		chance += 0.1
	elseif jobs == 40 || jobs == 41 ; Works at an inn
		chance += 0.3
	endif
	
	if RandomUniform() < chance
		return 4
	endif
	return 0
EndFunction

int Function GetOralVirginDefaultStatus(Actor akRef)
	if akRef.IsInFaction(DOMVirginOral)
		return akRef.GetFactionRank(DOMVirginOral)
	endif

	if !DOM01.virginOToggle
		return 4
	endif

	float chance = 0.4 ; Chance to not be a virgin
	; Races, some should not be in here anyhow
	actorBase abTarget = akRef.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	if IsElder(raceString)
		chance += 0.3
	elseif IsYoungAdult(raceString) || IsChild(raceString)
		return 0
	endif

	; get previous employers and jobs
	int jobs = akRef.getFactionRank(DOMJobOriginFaction)  
	int emps = akRef.getFactionRank(DOMEmployerOriginFaction) 

	if(jobs<0 && emps<0) ; Probably a unique NPC we need to evaluate
		jobs = GetJobOfOriginIndex(akRef)
		emps = GetEmployerOfOriginIndex(akRef)
	endif

	; This reflects only Skyrim jobs and employers not real life nor anyother part of Cyrodil
	if emps > 0 ; Works at court
		chance += 0.3
	endif
	if jobs < 4 ; Nobility
		chance += 0.2
	elseif jobs == 4 ; Bandit
		chance += 0.1
	elseif jobs == 9 ; Thief
		chance += 0.1
	elseif jobs == 25 ; Bards
		chance += 0.3
	elseif jobs == 30 || jobs == 31 ; Merchant
		chance += 0.1
	elseif jobs == 40 || jobs == 41 ; Works at an inn
		chance += 0.3
	endif
	
	if RandomUniform() < chance
		return 4
	endif
	return 0
EndFunction

int Function GetSameVirginDefaultStatus(Actor akRef)
	if akRef.IsInFaction(DOMVirginSame)
		return akRef.GetFactionRank(DOMVirginSame)
	endif

	if !DOM01.virginSToggle
		return 4
	endif

	;return 0
	float chance = 0.05 ; Chance to not be a virgin
	; Races, some should not be in here anyhow
	actorBase abTarget = akRef.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	if IsYoungAdult(raceString) || IsChild(raceString)
		return 0
	endif

	; get previous employers and jobs
	int jobs = akRef.getFactionRank(DOMJobOriginFaction)  
	int emps = akRef.getFactionRank(DOMEmployerOriginFaction) 

	if(jobs<0 && emps<0) ; Probably a unique NPC we need to evaluate
		jobs = GetJobOfOriginIndex(akRef)
		emps = GetEmployerOfOriginIndex(akRef)
	endif

	; This reflects only Skyrim jobs and employers not real life nor anyother part of Cyrodil
	if emps > 0 ; Works at court
		chance += 0.02
	endif
	if jobs < 4 ; Nobility
		chance += 0.02
	elseif jobs == 4 ; Bandit
		chance += 0.01
	elseif jobs >= 6 && jobs <= 15 ; Trained fighter: Legion, Stormcloaks, Blades, Companions, Vigilant, Guards, thieves, DB
		chance += 0.01
	elseif jobs == 25 ; Bards
		chance += 0.01
	elseif jobs == 40 || jobs == 41 ; Works at an inn
		chance += 0.02
	endif

	if RandomUniform() < chance
		return 4
	endif
	return 0
EndFunction

int Function GetGangVirginDefaultStatus(Actor akRef)
	if akRef.IsInFaction(DOMVirginGangbang)
		return akRef.GetFactionRank(DOMVirginGangbang)
	endif

	if !DOM01.virginGToggle
		return 4
	endif

	float chance = 0.05 ; Chance to not be a virgin
	; Races, some should not be in here anyhow
	actorBase abTarget = akRef.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	if IsElder(raceString)
		chance += 0.3
	elseif IsYoungAdult(raceString) || IsChild(raceString)
		return 0
	endif

	; get previous employers and jobs
	int jobs = akRef.getFactionRank(DOMJobOriginFaction)  
	int emps = akRef.getFactionRank(DOMEmployerOriginFaction) 

	if(jobs<0 && emps<0) ; Probably a unique NPC we need to evaluate
		jobs = GetJobOfOriginIndex(akRef)
		emps = GetEmployerOfOriginIndex(akRef)
	endif

	; This reflects only Skyrim jobs and employers not real life nor anyother part of Cyrodil
	if emps > 0 ; Works at court
		chance += 0.02
	endif
	if jobs < 4 ; Nobility
		chance += 0.02
	elseif jobs == 4 ; Bandit
		chance += 0.01
	elseif jobs >= 6 && jobs <= 15 ; Trained fighter: Legion, Stormcloaks, Blades, Companions, Vigilant, Guards
		chance += 0.01
	elseif jobs == 25 ; Bards
		chance += 0.01
	elseif jobs == 40 || jobs == 41 ; Works at an inn
		chance += 0.02
	endif
		
	if RandomUniform() < chance
		return 4
	endif
	return 0
EndFunction

float Function GetFlatModifier(int index, float[] TraitsArray)
	float mod
	if index == 0
		mod = GetDefaultModifierHumility(100.0, TraitsArray)
	elseif index == 1
		mod = GetDefaultModifierFearfulness(100.0, TraitsArray)
	elseif index == 2
		mod = GetDefaultModifierNaivety(100.0, TraitsArray)
	elseif index == 3
		mod = getDefaultModiferForgiveness(100.0, TraitsArray)
	elseif index == 4
		mod = GetDefaultModifierPrudent(100.0, TraitsArray)
	else
		mod = GetDefaultModifierDiscipline(100.0, TraitsArray)
	endif
	
	; Correct extra high values from modifier
	if mod > 200.0
		mod = 100.0
	elseif mod > 100.0
		mod = 90.0
	elseif mod > 70.0
		mod = 80.0
	endif
	
	if mod < 0.0
		mod = 0.0
	elseif mod > 100.0
		mod = 100.0
	endif

	return mod
EndFunction

int[] Function GetVirginStatus(Actor akRef)
	int[] vstatus
	bool is_unique = akRef.GetLeveledActorBase().IsUnique()
	if is_unique && !readJSONForUniques
		vstatus = GetVirginStatusGenerated(akRef)
	elseif !is_unique && !readJSONForSpawned
		vstatus = GetVirginStatusGenerated(akRef)
	elseif !ReadJSONVirginityToggle
		vstatus = GetVirginStatusGenerated(akRef)
	else
		vstatus = GetVirginStatusReadOrGenerated(akRef)
	endif

	if akRef.IsInFaction(DOMVirginVaginal)
		vstatus[0] = akRef.GetFactionRank(DOMVirginVaginal)
	endif
	if akRef.IsInFaction(DOMVirginOral)
		vstatus[1] = akRef.GetFactionRank(DOMVirginOral)
	endif
	if akRef.IsInFaction(DOMVirginAnal)
		vstatus[2] = akRef.GetFactionRank(DOMVirginAnal)
	endif
	if akRef.IsInFaction(DOMVirginSame)
		vstatus[3] = akRef.GetFactionRank(DOMVirginSame)
	endif
	if akRef.IsInFaction(DOMVirginGangbang)
		vstatus[4] = akRef.GetFactionRank(DOMVirginGangbang)
	endif
	return vstatus
EndFunction

Function SetVirginStatus(Actor akRef, int[] vstatus)
	akRef.SetFactionRank(DOMVirginVaginal, vstatus[0])
	akRef.SetFactionRank(DOMVirginOral, vstatus[1])
	akRef.SetFactionRank(DOMVirginAnal, vstatus[2])
	akRef.SetFactionRank(DOMVirginSame, vstatus[3])
	akRef.SetFactionRank(DOMVirginGangbang, vstatus[4])
EndFunction

float[] Function GetNPCFeelings(Actor akTarget)
	; If feelings are saved in factions return ranks
	; else generate feelings and save in factions
	;LogTrace("GetDefaultNPCFeelings: "+akTarget.getDisplayName()+" "+akTarget)
	
	if akTarget.isInFaction(DOMFeelSubmission)
		return GetFactionFeelings(akTarget)
	endif

	float[] FeelsArray = GetDefaultNPCFeelings(akTarget)
	SetNPCFeelings(akTarget, FeelsArray)	
	return FeelsArray
EndFunction

float[] Function GetDefaultNPCFeelings(Actor akTarget)
	actorBase abTarget = akTarget.GetLeveledActorBase()
	string nameString = akTarget.GetName()
	if nameString == ""
		nameString = abTarget.GetName()
	endif
	; unless actor is or was a slave
	float[] FeelsArray = new float[6]                                                           
	float[] TraitsArray = GetNPCTraits(akTarget) ; No need for modifiers a they will be computed individually
	
	; Get feelings from faction ranks for slaves or once a slave
	;;LogTrace(nameString+" faction rank "+akTarget.GetFactionRank(DOMTrainSubmission))
	FeelsArray[0] = GetFlatModifier(0,TraitsArray)
	FeelsArray[1] = GetFlatModifier(1,TraitsArray)
	FeelsArray[2] = GetFlatModifier(2,TraitsArray)
	FeelsArray[3] = GetFlatModifier(3,TraitsArray)
	FeelsArray[4] = GetFlatModifier(4,TraitsArray)
	FeelsArray[5] = GetFlatModifier(5,TraitsArray)

	return FeelsArray
EndFunction

; HONESTY
float Function GetDefaultModifierHumility(float w, Float [] traits)
	; emotion = Pain, traits = -tough -wil +honest
	float mod = traits[0]*3.0+(100.0-traits[6])*2.0+(100.0-traits[7])
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierModesty(float w, Float [] traits) 
	; emotion = +honesty +sensual -anxious
	float mod = traits[0]*3.0+traits[8]*2.0+(100.0-traits[1])
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierInsensitivity(float w, Float [] traits)
    ; -submi -honest +live
	float mod = (100.0-traits[9])*2.0+(100.0-traits[0])*3.0+traits[2]
	return NormModifier(mod)*w
EndFunction

Float Function getDefaultModifierCriminality(float w, Float [] traits)
	; -honest -open +smart
	float mod = (100.0-traits[0])*3.0+(100.0-traits[5])+traits[11]*2.0
	return NormModifier(mod)*w
EndFunction

float Function GetDefaultModifierVaginal(float w, Float [] traits)
	; emotion = sex, traits = +honest +subm +sensual +wil
	float mod = traits[0]*2.0+traits[9]*2.0+traits[8]+traits[6]
	return NormModifier(mod)*w	
EndFunction

; EMOTIONALITY
float Function GetDefaultModifierFearfulness(float w, Float [] traits)
	; emotion = Fear traits = +anxious +lively -tough
	float mod = traits[1]*3.0+(100.0-traits[7])*2.0+traits[2]
	return NormModifier(mod)*w
EndFunction

Float Function getDefaultModifierSentimentality(float w, Float [] traits)
	; +smart +anxious +sens
	float mod = traits[1]*3.0+traits[8]*2.0+traits[11]
	return NormModifier(mod)*w
EndFunction

float Function getDefaultModifierDependence(float w, Float [] traits) 
	; emotion = +anxious -bold +kind
	float mod = traits[1]*3.0+(100.0-traits[10])*2.0+traits[3]
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierIntimidate(float w, Float [] traits) ; 
	; emotion = +anxious +tough -honest
	float mod = traits[1]*2.0+traits[7]*2.0+(100.0-traits[0])*2.0
	return NormModifier(mod)*w	
EndFunction

; EXTRAVERSION
float Function getDefaultModifierSelfEsteem(float w, Float [] traits) ; 
	; emotion = SelfEsteem, traits = +tough -honest +live
	float mod = traits[7]*2.0+(100.0-traits[0])+traits[2]*3.0
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierNaivety(float w, Float [] traits) 
	; emotion = Shame, traits = -lively -open-minded +sensual
	float mod = (100.0-traits[2])*3.0+traits[8]*2.0+(100.0-traits[5])
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierDaring(float w, Float [] traits) ; Used by train sex
	; emotion = Pleasure, traits = +tough +bold +live
	float mod = traits[7]+traits[10]*2.0+traits[2]*3.0
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierIngenuity(float w, Float [] traits) 
	; emotion = -live -smart +emo
	float mod = (100.0-traits[2])*3.0+(100.0-traits[11])*2.0+traits[1]
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierOral(float w, Float [] traits)
	; emotion = sex, traits = -lively +(submi and sensual)/2 +cons
	float mod = (100.0-traits[2])*2.0+traits[4]*2.0+traits[9]+traits[8]
	return NormModifier(mod)*w	
EndFunction

; AGREEABLENESS
float Function getDefaultModifierGentleness(float w, Float [] traits) 
	; emotion = +honesty +kind -wil
	float mod = traits[3]*3.0+(100.0-traits[6])*2.0+traits[0]
	return NormModifier(mod)*w	
EndFunction

Float Function getDefaultModifierImpatience(float w, Float [] traits)
	; emotion = Stress, traits = -tough -kind +lively
	float mod = (100.0-traits[3])*3.0+(100.0-traits[7])*2.0+traits[2]
	return NormModifier(mod)*w
EndFunction

;float Function getDefaultModifierHope(float w, Float [] traits) 
;	; emotion = +wil +sensual +kind
;	float mod = traits[6]+traits[8]*2.0+traits[3]*3.0
;	return NormModifier(mod)*w	
;EndFunction

float Function getDefaultModiferForgiveness(float w, Float [] traits)
	; emotion = Stress, traits = +anxious +kind +submi
	float mod = traits[3]*3.0+traits[9]*2.0+traits[1]
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierResentment(float w, Float [] traits) ; 
	; emotion =  +smart -kind +consciensous 
	float mod = traits[11]*2.0+(100.0-traits[3])*3.0+traits[4]
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierAnal(float w, Float [] traits)
	; emotion = sex, traits = +submi +wil -open +kind
	float mod = traits[9]+traits[6]+(100.0-traits[5])*2.0+traits[3]*2.0
	return NormModifier(mod)*w	
EndFunction

;CONSCIENTIOUSNESS
float Function GetDefaultModifierDiligent(float w, Float [] traits) 
	; emotion = Combat, traits = +cons +tough -subm
	float mod = traits[4]*3.0+traits[7]*2.0+(100.0-traits[9])
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierConsideration(float w, Float [] traits) 
	; emotion = +anxious +sensual +cons
	float mod = traits[4]*3.0+traits[8]*2.0+traits[1]
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierPerfectionism(float w, Float [] traits)
	; emotion = Taking care of house, traits = +subm +cons +lively
	float mod = traits[4]*3.0+traits[9]*2.0+traits[2]
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierPrudent(float w, Float [] traits) 
	; emotion = Sorrow, traits = +cons -bold +kind 
	float mod = traits[4]*3.0+(100.0-traits[10])*2.0+traits[3]
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierController(float w, Float [] traits) ; 
	; emotion = +cons -honesty -submi
	float mod = traits[4]*2.0+(100.0-traits[9])*2.0+(100.0-traits[0])*2.0
	return NormModifier(mod)*w	
EndFunction

; OPEN-MINDED
float Function getDefaultModifierAuthority(float w, Float [] traits)
	; emotion = subject to order, traits = -open -wil +cons
	float mod = (100.0-traits[6])*2.0+(100.0-traits[5])*3.0+traits[4]
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierFlexibility(float w, Float [] traits)
	; emotion = Posing or in bondage, traits = +kind +sens +open
	float mod = traits[8]*2.0+traits[5]*3.0+traits[3]
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierManipulation(float w, Float [] traits) 
	; emotion = -open +sub +emo
	float mod = (100.0-traits[5])*3.0+traits[9]*2.0+traits[1]
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierCreativity(float w, Float [] traits) 
	; emotion = subject to order, traits = +open +bold +sens
	float mod = traits[5]*3.0+traits[10]*2.0+traits[8]
	return NormModifier(mod)*w	
EndFunction

float Function GetDefaultModifierDiscipline(float w, Float [] traits)
	; emotion = Shame, traits = -open-minded +lively -smart
	float mod = (100.0-traits[5])*3.0+(100.0-traits[11])*2.0+traits[2]
	return NormModifier(mod)*w	
EndFunction

float Function getDefaultModifierPretender(float w, Float [] traits) ; 
	; emotion =  +open-minded -honest +smart
	float mod = traits[5]*2.0+traits[11]*2.0+(100.0-traits[0])*2.0
	return NormModifier(mod)*w	
EndFunction

; PHYSICAL
float Function GetDefaultModifierCombat(float w, Float [] traits) 
	; emotion = Combat, traits = bold wil smart
	float mod = traits[10]*2.0+traits[6]*2.0+traits[11]*2.0
	return NormModifier(mod)*w	
EndFunction

float Function DTrainer(Actor akTarget)
	int rank = akTarget.GetFactionRank(DOMSkillEnforcer)
	if rank <= 0
		return 0.5
	endif
	return 0.5+(rank as float)/100.0
EndFunction

Float Function DMaster(Actor akTarget)
	int rank = akTarget.GetFactionRank(DOMSkillDeceiver)
	if rank <= 0
		return 0.5
	endif
	return 0.5+(rank as float)/100.0
EndFunction

Float Function DSubmission(Float submission, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(submission/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModHumility) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DFear(Float fear_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(fear_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModFearfulness) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DHumiliation(Float humiliation, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(humiliation/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModNaivety) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DAnger(Float anger_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(anger_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModForgiveness) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DResignation(Float resignation, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(resignation/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModPrudent) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DRespect(Float respect_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(respect_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModDiscipline) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DOralSex(Float sex_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(sex_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModOral) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DVaginalSex(Float sex_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(sex_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModVaginal) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DAnalSex(Float sex_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(sex_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModAnal) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DCombat(Float combat_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(combat_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModCombat) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DPose(Float pose_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(pose_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModFlexibility) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

Float Function DHouse(Float house_training, Float base_amount, Actor akTarget)
	Float multiplier = 0.1 + (0.9*(1-(house_training/100)))
	Float modifier = GetModifierFromFaction(akTarget,DOMModPerfectionism) * base_amount / 100.0
	Float x = multiplier*modifier
	if x < 1.0
		return 1.0
	endif
	return x
EndFunction

; Interface to Sexlab, AYGAS, HSH

int Function IsWillingToHaveSexWith(Actor akTarget, DOM_Actor akActor)
	if aktarget == None
		Debug.Notification("ERROR: Could not find NPC to join Sexlab scene")
		return 0
	endif
	; Slave and submission checks
	;LogTrace("IsWillingToHaveSexWith "+akTarget.GetDisplayName()+" in PAH faction="+aktarget.IsInFaction(PAHPlayerSlaveFaction)+" "+PAHPlayerSlaveFaction)
	if DOMPAH.isPAH(akTarget)
		if aktarget.GetFactionRank(DOMTrainSubmission) > 70
			Debug.Notification(akTarget.GetDisplayName()+" obeys like a good slave")
			return 2
		else
			Debug.Notification(akTarget.GetDisplayName()+" doesn't really have a choice")
			return 1
		endif
	endif
	LogTrace("IsWillingToHaveSexWith "+akTarget.GetDisplayName()+" in DOM faction="+aktarget.IsInFaction(DOMPlayerSlaveFaction)+" "+DOMPlayerSlaveFaction)
	if aktarget.IsInFaction(DOMPlayerSlaveFaction)
		if aktarget.GetFactionRank(DOMTrainSubmission) > 70
			Debug.Notification(akTarget.GetDisplayName()+" obeys like a good slave")
			return 2
		else
			Debug.Notification(akTarget.GetDisplayName()+" doesn't really have a choice")
			return 1
		endif
	endif
	LogTrace("IsWillingToHaveSexWith "+akTarget.GetDisplayName()+" love desire="+aktarget.IsInFaction(DOMLoveDesire)+" "+DOMLoveDesire)
	if aktarget.IsInFaction(DOMLoveDesire)
		if aktarget.GetFactionRank(DOMLoveDesire) > 0
			Debug.Notification(akTarget.GetDisplayName()+" obeys submissively")
			return 2
		endif
	endif
	LogTrace("IsWillingToHaveSexWith "+akTarget.GetDisplayName()+" submission="+aktarget.IsInFaction(DOMTrainSubmission)+" "+DOMTrainSubmission)
	if aktarget.IsInFaction(DOMTrainSubmission)
		if aktarget.GetFactionRank(DOMTrainSubmission) > 70
			Debug.Notification(akTarget.GetDisplayName()+" obeys like a good slave")
			return 1
		endif
	endif
	LogTrace("IsWillingToHaveSexWith "+akTarget.GetDisplayName()+" in DOM potential faction="+aktarget.IsInFaction(DOMPotentialSlaverFaction)+" "+DOMPotentialSlaverFaction)
	if aktarget.IsInFaction(DOMPotentialSlaverFaction)
		if akTarget.GetLeveledActorBase().GetSex() == 0
			Debug.Notification(akTarget.GetDisplayName()+" accepts with a malicious grin on his face")
		else
			Debug.Notification(akTarget.GetDisplayName()+" accepts with a malicious grin on her face")
		endif
		return 2
	endif
	LogTrace("IsWillingToHaveSexWith "+akTarget.GetDisplayName()+" in DOM slaver faction="+aktarget.IsInFaction(DOMPlayerSlaverFaction)+" "+DOMPlayerSlaverFaction)
	if aktarget.IsInFaction(DOMPlayerSlaverFaction)
		if akTarget.GetLeveledActorBase().GetSex() == 0
			Debug.Notification(akTarget.GetDisplayName()+" accepts with an evil grin on his face")
		else
			Debug.Notification(akTarget.GetDisplayName()+" accepts with an evil grin on her face")
		endif
		return 2
	endif
	; Relationship checks
	float[] TraitsArray = GetNPCTraits(akTarget)
	if TraitsArray[0] >  RandomFloat()*10.0 ; Honest
		if TraitsArray[5] < RandomFloat()*1000.0 ; Close minded
			if DOM01.IsSpouse(akTarget,akActor.akRef)
				if akTarget.GetLeveledActorBase().GetSex() == 0
					Debug.Notification(akTarget.GetDisplayName()+" wants you to free his spouse first")
				else
					Debug.Notification(akTarget.GetDisplayName()+" wants you to free her spouse first")
				endif
				return 0			
			elseif akTarget.HasFamilyRelationship(akActor.akRef)
				if akTarget.GetLeveledActorBase().GetSex() == 0
					Debug.Notification(akTarget.GetDisplayName()+" will not do it with his "+GetFriendshipString(akActor.akRef,DOM01.GetFriendshipType(akTarget,akActor.akRef)))
				else
					Debug.Notification(akTarget.GetDisplayName()+" will not do it with her "+GetFriendshipString(akActor.akRef,DOM01.GetFriendshipType(akTarget,akActor.akRef)))
				endif
				return 0
			endif
		endif
	endif
	if TraitsArray[0] <  RandomFloat()*10.0 ; Dishonest
		if TraitsArray[5] > RandomFloat()*100.0 ; Open minded
			if DOM01.IsSpouse(akTarget,akActor.akRef)
				if akTarget.GetLeveledActorBase().GetSex() == 0
					Debug.Notification(akTarget.GetDisplayName()+" will gladly do it with his spouse")
				else
					Debug.Notification(akTarget.GetDisplayName()+" will gladly do it with her spouse")
				endif
				return 0			
			elseif akTarget.HasFamilyRelationship(akActor.akRef)
				Debug.Notification(akTarget.GetDisplayName()+" seems very excited to do it with a family member")
				return 0
			endif
		endif
	endif
	if DOM01.IsCourting(akTarget,akActor.akRef)
		if RandomFloat()*100.0 > TraitsArray[9] ; Dominant
			if akTarget.GetLeveledActorBase().GetSex() == 0
				Debug.Notification(akTarget.GetDisplayName()+" appears excited to rape his love interest")
			else
				Debug.Notification(akTarget.GetDisplayName()+" appears excited to rape her love interest")
			endif
			return 2
		endif
		if RandomFloat()*100.0 > TraitsArray[8] ; ; Sensual
			if akTarget.GetLeveledActorBase().GetSex() == 0
				Debug.Notification(akTarget.GetDisplayName()+" is excited to have sex with his love interest")
			else
				Debug.Notification(akTarget.GetDisplayName()+" is excited to have sex with her love interest")
			endif
			return 1
		endif
	endif
	if !DOM01.IsSpouse(akTarget,akActor.akRef)
		if akTarget.HasFamilyRelationship(akActor.akRef)
			Debug.Notification(akTarget.GetDisplayName()+" seems hesitant to do it with a family member")
			return 0
		endif
	else
		if RandomFloat()*50.0 < TraitsArray[0] ; Honesty
			if RandomFloat()*50.0 < TraitsArray[6] ; Wilful
				if akTarget.GetLeveledActorBase().GetSex() == 0
					Debug.Notification(akTarget.GetDisplayName()+" won't do it with his spouse in public")
				else
					Debug.Notification(akTarget.GetDisplayName()+" won't do it with her spouse in public")
				endif
				return 0
			endif
		endif
		if RandomFloat()*100.0 > TraitsArray[9] ; Dominant
			if akTarget.GetLeveledActorBase().GetSex() == 0
				Debug.Notification(akTarget.GetDisplayName()+" appears excited to rape his spouse in public")
			else
				Debug.Notification(akTarget.GetDisplayName()+" appears excited to rape her spouse in public")
			endif
			return 2
		endif
		if RandomFloat()*100.0 > TraitsArray[8] ; ; Sensual
			if akTarget.GetLeveledActorBase().GetSex() == 0
				Debug.Notification(akTarget.GetDisplayName()+" is excited to have sex with his spouse in public")
			else
				Debug.Notification(akTarget.GetDisplayName()+" is excited to have sex with her spouse in public")
			endif
			return 1
		endif
		if akTarget.GetLeveledActorBase().GetSex() == 0
			Debug.Notification(akTarget.GetDisplayName()+" reluctantly accepts to have sex with his spouse in public")
		else
			Debug.Notification(akTarget.GetDisplayName()+" reluctantly accepts to have sex with her spouse in public")
		endif
		return 1
	endif
	if akTarget.HasFamilyRelationship(akActor.akRef) 
		if akTarget.GetRelationshipRank(akActor.akRef) > 3
			if RandomFloat()*66.0 < TraitsArray[0] ; Honesty
				if RandomFloat()*66.0 < TraitsArray[6] ; Wilful
					if akTarget.GetLeveledActorBase().GetSex() == 0
						Debug.Notification(akTarget.GetDisplayName()+" won't do it with the love of his life in public")
					else
						Debug.Notification(akTarget.GetDisplayName()+" won't do it with the love of her life in public")
					endif
					return 0
				endif
			endif
			if RandomFloat()*100.0 > TraitsArray[9] ; Dominant
				if akTarget.GetLeveledActorBase().GetSex() == 0
					Debug.Notification(akTarget.GetDisplayName()+" appears excited to rape the love of his life in public")
				else
					Debug.Notification(akTarget.GetDisplayName()+" appears excited to rape the love of her life in public")
				endif
				return 2
			endif
			if RandomFloat()*100.0 > TraitsArray[8] ; ; Sensual
				if akTarget.GetLeveledActorBase().GetSex() == 0
					Debug.Notification(akTarget.GetDisplayName()+" is excited to have sex with the love of his life in public")
				else
					Debug.Notification(akTarget.GetDisplayName()+" is excited to have sex with the love of her life in public")
				endif
				return 1
			endif
			if akTarget.GetLeveledActorBase().GetSex() == 0
				Debug.Notification(akTarget.GetDisplayName()+" reluctantly accepts to have sex with the love of his life in public")
			else
				Debug.Notification(akTarget.GetDisplayName()+" reluctantly accepts to have sex with the love of her life in public")
			endif
			return 1
		elseif akTarget.GetRelationshipRank(akActor.akRef) > 1
			if RandomFloat()*200.0 < TraitsArray[0] ; Honesty
				if RandomFloat()*200.0 < TraitsArray[6] ; Wilful
					if akTarget.GetLeveledActorBase().GetSex() == 0
						Debug.Notification(akTarget.GetDisplayName()+" won't do it with his friend in public")
					else
						Debug.Notification(akTarget.GetDisplayName()+" won't do it with her friend in public")
					endif
					return 0
				endif
			endif
			if RandomFloat()*100.0 > TraitsArray[9] ; Dominant
				if akTarget.GetLeveledActorBase().GetSex() == 0
					Debug.Notification(akTarget.GetDisplayName()+" appears excited to rape his friend in public")
				else
					Debug.Notification(akTarget.GetDisplayName()+" appears excited to rape her friend in public")
				endif
				return 2
			endif
			if RandomFloat()*100.0 > TraitsArray[8] ; ; Sensual
				if akTarget.GetLeveledActorBase().GetSex() == 0
					Debug.Notification(akTarget.GetDisplayName()+" is excited to have sex with his friend in public")
				else
					Debug.Notification(akTarget.GetDisplayName()+" is excited to have sex with her friend in public")
				endif
				return 1
			endif
			if akTarget.GetLeveledActorBase().GetSex() == 0
				Debug.Notification(akTarget.GetDisplayName()+" reluctantly accepts to have sex with his friend in public")
			else
				Debug.Notification(akTarget.GetDisplayName()+" reluctantly accepts to have sex with her friend in public")
			endif
			return 1
		endif
	endif
	; Personality checks
	if RandomFloat()*100.0 < TraitsArray[0] ; Honesty
		if RandomFloat()*100.0 < TraitsArray[6] ; Wilful
			Debug.Notification(akTarget.GetDisplayName()+" is really too honest for that kind of stuff")
			return 0
		endif
		if RandomFloat()*100.0 < TraitsArray[5] ; Open-minded
			if RandomFloat()*100.0 > TraitsArray[9] ; Dominant
				Debug.Notification(akTarget.GetDisplayName()+" will make an exception this time")
				return 2
			endif
			if RandomFloat()*100.0 < TraitsArray[8] ; Sensual
				Debug.Notification(akTarget.GetDisplayName()+" is too excited to refuse")
				return 1
			endif
		endif
		Debug.Notification(akTarget.GetDisplayName()+" is too honest for that kind of stuff")
		return 0
	endif
	if RandomFloat()*100.0 < TraitsArray[5] ; Open-minded
		if RandomFloat()*100.0 > TraitsArray[9] ; Dominant
			if akTarget.GetLeveledActorBase().GetSex() == 0
				Debug.Notification(akTarget.GetDisplayName()+" accepts with a pervert grin on his face")
			else
				Debug.Notification(akTarget.GetDisplayName()+" accepts with a pervert grin on her face")
			endif
			return 2
		endif
		if RandomFloat()*100.0 < TraitsArray[8] ; Sensual
			Debug.Notification(akTarget.GetDisplayName()+" accepts without hesitation")
			return 1
		endif
		if RandomFloat()*100.0 < TraitsArray[6] ; Wilful
			int rank = akTarget.getRelationshipRank(PlayerRef)
			if rank < 2
				Debug.Notification(akTarget.GetDisplayName()+" is clearly tempted but prefers to abstain")
				return 0
			elseif rank < 3
				Debug.Notification(akTarget.GetDisplayName()+" hesitates but finally accepts")
				return 1
			else
				Debug.Notification(akTarget.GetDisplayName()+" accepts because it's you")
				return 2
			endif
		endif
		Debug.Notification(akTarget.GetDisplayName()+" is easily convinced")
		return 1
	endif	
	if RandomFloat()*100.0 > TraitsArray[9] ; Dominant
		if RandomFloat()*100.0 < TraitsArray[2] ; eXtraversion
			Debug.Notification(akTarget.GetDisplayName()+" seems a bit too happy about it")
			return 2
		endif
		Debug.Notification(akTarget.GetDisplayName()+" seems a bit wary but accepts")
		return 1
	endif
	if RandomFloat()*100.0 < TraitsArray[8] ; Sensuality
		if RandomFloat()*100.0 < TraitsArray[6] ; Wilful
			int rank = akTarget.getRelationshipRank(PlayerRef)
			if rank < 3
				Debug.Notification(akTarget.GetDisplayName()+" has better things to do")
				return 0
			else
				Debug.Notification(akTarget.GetDisplayName()+" would do anything for you")
				return 2
			endif
		endif
		Debug.Notification(akTarget.GetDisplayName()+" could not refuse such an offer")
		return 1
	endif
	Debug.Notification(akTarget.GetDisplayName()+" doesn't feel like it")
	return 0
EndFunction

; Get actor price with current training (buyer value)
int Function getActorPrice(Actor akActor)
	float base_health  = akActor.GetBaseAv("health")/100.0    ; Level 1 value is 100 for all races
	float base_stamina = akActor.GetBaseAv("stamina")/100.0   ; Level 1 value is 100 for all races
	float base_magicka = akActor.GetBaseAv("magicka")/100.0   ; Between 0 and 1000 depending on race and level
	Actorbase abTarget = akActor.GetLeveledActorBase()
	bool is_female     = (abTarget.GetSex() == 1)
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	float RaceSexMultiplier    = 1.0
	;LogTrace("getActorPrice:  "+akActor.getDisplayName()+" female="+is_female+" race="+raceString)

	; Race bonuses
	if ActorRace.HasKeyword(DOM01.Vampire) || (stringUtil.find(raceString,"Vampire")>=0)
		RaceSexMultiplier = 0.3 ; No one wants that sick stuff
	elseif(stringUtil.find(raceString,"Elder")>=0)
		if ((akActor.GetBaseAv("magicka") > akActor.GetBaseAv("health")) ||  (akActor.GetBaseAv("magicka") > akActor.GetBaseAv("stamina"))   )
			RaceSexMultiplier = 1.8	; wizard
		else
			RaceSexMultiplier = 0.5 ; just a standard old actor
		endif
	elseif(stringUtil.find(raceString,"Argonian")>=0)
		RaceSexMultiplier = 0.6
	elseif(stringUtil.find(raceString,"Breton")>=0)
		if is_female
			RaceSexMultiplier = 1.2
		else
			RaceSexMultiplier = 0.8
		endif
	elseif(stringUtil.find(raceString,"Dark Elf")>=0)
		if is_female
			RaceSexMultiplier = 1.1
		else
			RaceSexMultiplier = 0.9
		endif
	elseif(stringUtil.find(raceString,"High Elf")>=0)
		if is_female
			RaceSexMultiplier = 1.4
		else
			RaceSexMultiplier = 0.6
		endif
	elseif(stringUtil.find(raceString,"Imperial")>=0)
		RaceSexMultiplier = 1.15
	elseif(stringUtil.find(raceString,"Khajiit")>=0)
		RaceSexMultiplier = 0.8
	elseif(stringUtil.find(raceString,"Nord")>=0)
		if is_female
			RaceSexMultiplier = 1.4
		else
			RaceSexMultiplier = 1.1
		endif
	elseif(stringUtil.find(raceString,"Orc")>=0)
		RaceSexMultiplier = 1.2
	elseif(stringUtil.find(raceString,"Redguard")>=0)
		if is_female
			RaceSexMultiplier = 1.5
		else
			RaceSexMultiplier = 1
		endif
	elseif(stringUtil.find(raceString,"Wood Elf")>=0)
		if is_female
			RaceSexMultiplier = 1.3
		else
			RaceSexMultiplier = 1.2
		endif
	endif
	;LogTrace("getActorPrice:  "+akActor.getDisplayName()+" RaceSexMultiplier="+RaceSexMultiplier)
	
	Float fTrainMod = 1.0
	fTrainMod *= ((akActor.GetFactionRank(DOMTrainSubmission) / 60.0) + 0.34)
	fTrainMod *= ((akActor.GetFactionRank(DOMTrainResignation) / 60.0) + 0.34)
	fTrainMod *= ((akActor.GetFactionRank(DOMTrainHumiliation) / 60.0) + 0.34)
	fTrainMod *= ((akActor.GetFactionRank(DOMTrainRespect) / 60.0) + 0.34)
	fTrainMod += (akActor.GetFactionRank(DOMTrainAnal) / 200.0)
	fTrainMod += (akActor.GetFactionRank(DOMTrainOral) / 200.0)
	fTrainMod += (akActor.GetFactionRank(DOMTrainVaginal) / 200.0)
	fTrainMod += (GetFactionRankFloat(akActor,DOMTrainCombat) / 100.0)
	fTrainMod += (akActor.GetFactionRank(DOMTrainPose) / 150.0)
	fTrainMod += (akActor.GetFactionRank(DOMTrainHouse) / 200.0)
	fTrainMod += (akActor.GetFactionRank(DOMTrainAnger) / 200.0)
	fTrainMod += (akActor.GetFactionRank(DOMTrainFear) / 200.0)
	fTrainMod += (akActor.GetFactionRank(DOMTrainWorking) / 200.0)
	fTrainMod += 1.0

	;LogTrace("getActorPrice:  "+akActor.getDisplayName()+" Training="+fTrainMod)
	
	Float fWeightMod = (abTarget.GetWeight() / 50.0) + 0.5
	float base_value = (base_health + base_stamina + base_magicka)*100.0

	;LogTrace("getActorPrice:  "+akActor.getDisplayName()+" Weight="+fWeightMod)
	;LogTrace("getActorPrice:  "+akActor.getDisplayName()+" Combat="+base_value)
	
	float mood_modifier = 0.25
	if akActor.IsInFaction(DOMMoodBroken)
		mood_modifier = 0.5
	elseif akActor.IsInFaction(DOMMoodLoyal)
		mood_modifier = 0.75
	elseif akActor.IsInFaction(DOMMoodInlove)
		mood_modifier = 1.0
	endif

	base_value = base_value * RaceSexMultiplier * fTrainMod * fWeightMod
	int value = (mood_modifier * base_value) as int

	LogTrace("getActorPrice:  "+akActor.getDisplayName()+" final value="+value+" base="+base_value+" mood modifier="+mood_modifier)
	if value < 10
		value = 10
	endif
	return value
EndFunction

; Get actor price assuming max training (ransom value)
int Function getActorFullPrice(Actor akActor)
	float base_health  = akActor.GetBaseAv("health")/100.0    ; Level 1 value is 100 for all races
	float base_stamina = akActor.GetBaseAv("stamina")/100.0   ; Level 1 value is 100 for all races
	float base_magicka = akActor.GetBaseAv("magicka")/100.0   ; Between 0 and 1000 depending on race and level
	Actorbase abTarget = akActor.GetLeveledActorBase()
	bool is_female     = (abTarget.GetSex() == 1)
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	float RaceSexMultiplier    = 1.0
	;LogTrace("getActorFullPrice:  "+akActor.getDisplayName()+" female="+is_female+" race="+raceString)

	; Race bonuses
	if ActorRace.HasKeyword(DOM01.Vampire) || (stringUtil.find(raceString,"Vampire")>=0)
		RaceSexMultiplier = 0.3 ; No one wants that sick stuff
	elseif(stringUtil.find(raceString,"Elder")>=0)
		if ((akActor.GetBaseAv("magicka") > akActor.GetBaseAv("health")) ||  (akActor.GetBaseAv("magicka") > akActor.GetBaseAv("stamina"))   )
			RaceSexMultiplier = 1.8	; wizard
		else
			RaceSexMultiplier = 0.5 ; just a standard old actor
		endif
	elseif(stringUtil.find(raceString,"Argonian")>=0)
		RaceSexMultiplier = 0.6
	elseif(stringUtil.find(raceString,"Breton")>=0)
		if is_female
			RaceSexMultiplier = 1.2
		else
			RaceSexMultiplier = 0.8
		endif
	elseif(stringUtil.find(raceString,"Dark Elf")>=0)
		if is_female
			RaceSexMultiplier = 1.1
		else
			RaceSexMultiplier = 0.9
		endif
	elseif(stringUtil.find(raceString,"High Elf")>=0)
		if is_female
			RaceSexMultiplier = 1.4
		else
			RaceSexMultiplier = 0.6
		endif
	elseif(stringUtil.find(raceString,"Imperial")>=0)
		RaceSexMultiplier = 1.15
	elseif(stringUtil.find(raceString,"Khajiit")>=0)
		RaceSexMultiplier = 0.8
	elseif(stringUtil.find(raceString,"Nord")>=0)
		if is_female
			RaceSexMultiplier = 1.4
		else
			RaceSexMultiplier = 1.1
		endif
	elseif(stringUtil.find(raceString,"Orc")>=0)
		RaceSexMultiplier = 1.2
	elseif(stringUtil.find(raceString,"Redguard")>=0)
		if is_female
			RaceSexMultiplier = 1.5
		else
			RaceSexMultiplier = 1
		endif
	elseif(stringUtil.find(raceString,"Wood Elf")>=0)
		if is_female
			RaceSexMultiplier = 1.3
		else
			RaceSexMultiplier = 1.2
		endif
	endif
	;LogTrace("getActorFullPrice:  "+akActor.getDisplayName()+" RaceSexMultiplier="+RaceSexMultiplier)
	
	Float fTrainMod = 22.0
	;LogTrace("getActorFullPrice:  "+akActor.getDisplayName()+" Training="+fTrainMod)
	
	Float fWeightMod = (abTarget.GetWeight() / 50.0) + 0.5
	float base_value = (base_health + base_stamina + base_magicka)*100.0

	;LogTrace("getActorFullPrice:  "+akActor.getDisplayName()+" Weight="+fWeightMod)
	;LogTrace("getActorFullPrice:  "+akActor.getDisplayName()+" Combat="+base_value)
	
	base_value = base_value * RaceSexMultiplier * fTrainMod * fWeightMod
	int value = (base_value) as int

	LogTrace("getActorFullPrice:  "+akActor.getDisplayName()+" final value="+value+" base="+base_value)
	if value < 1000
		value = 1000
	endif
	return value
EndFunction

Function TrainMasters(Actor trainer, Actor taskmaster)
	; Change personality traits for masters
	if trainer != None
		float trm = trainer.GetFactionRank(DOMSkillEnforcer)
		Float multiplier
		if trm < 100.0
			multiplier = 0.1 + (0.9*(1.0-(trm/100.0)))
			trm += (multiplier*GetModifierFromFaction(trainer,DOMModInsensitivity)/100.0)
			trainer.SetFactionRank(DOMSkillEnforcer,trm as int)
		endif
		Int ntr = trainer.GetFactionRank(DOMNbTrainee)
		if ntr < 127
			ntr += 1
			trainer.SetFactionRank(DOMNbTrainee, ntr)
		endif

		if !DOM01.staticTraitsMode
			float t04 = trainer.GetFactionRank(DOMTraitConscientiousness)
			float t07 = trainer.GetFactionRank(DOMFacetWilfulness)
			float xt  = (100.0-t07)*t04/300.0
			if xt < 1.0
				xt = 1.0
			endif

			; -submi -honest +bold -open 
			xt *= 5.0/(ntr+5.0) ; less efficient after a few trainees
			float t00 = trainer.GetFactionRank(DOMTraitHonesty)	
			float t02 = trainer.GetFactionRank(DOMTraitExtraversion)
			float t06 = trainer.GetFactionRank(DOMFacetBoldness)
			float t10 = trainer.GetFactionRank(DOMFacetSensuality)
			float t11 = trainer.GetFactionRank(DOMFacetSubmissivity)
			trainer.SetFactionRank(DOMTraitHonesty,      (t00-RandomFloat(0, xt)) as int)
			trainer.SetFactionRank(DOMTraitExtraversion, (t02+RandomFloat(0, xt)) as int)
			trainer.SetFactionRank(DOMFacetBoldness,     (t06+RandomFloat(0, xt)/2.0) as int)
			trainer.SetFactionRank(DOMFacetSensuality,   (t10+RandomFloat(0, xt)/2.0) as int)
			trainer.SetFactionRank(DOMFacetSubmissivity, (t11-RandomFloat(0, xt)) as int)
			float[] TraitsArray	= GetNPCTraitsUpdateModifiers(trainer) ; Update traits and modifiers
		endif
	endif
	if taskmaster != None
		float trm = trainer.GetFactionRank(DOMSkillDeceiver)
		Float multiplier
		if trm < 100.0
			multiplier = 0.1 + (0.9*(1.0-(trm/100.0)))
			trm += (multiplier*GetModifierFromFaction(trainer,DOMModCriminality)/100.0)
			trainer.SetFactionRank(DOMSkillDeceiver,trm as int)
		endif
		Int ntr = taskmaster.GetFactionRank(DOMNbTrainer)
		if ntr < 127
			ntr += 1
			taskmaster.SetFactionRank(DOMNbTrainer, ntr)
		endif

		if !DOM01.staticTraitsMode
			float t04 = taskmaster.GetFactionRank(DOMTraitConscientiousness)
			float t07 = taskmaster.GetFactionRank(DOMFacetWilfulness)
			float xt  = (100.0-t07)*t04/600.0
			if xt < 1.0
				xt = 1.0
			endif

			; -honest -open +smart -kind
			xt *= 5.0/(ntr+5.0) ; less efficient after a few trainer successes
			float t00 = taskmaster.GetFactionRank(DOMTraitHonesty)
			float t02 = taskmaster.GetFactionRank(DOMTraitExtraversion)
			float t05 = taskmaster.GetFactionRank(DOMTraitOpenness)
			float t08 = taskmaster.GetFactionRank(DOMFacetSmartness)
			float t09 = taskmaster.GetFactionRank(DOMFacetToughness)
			
			taskmaster.SetFactionRank(DOMTraitHonesty,      (t00-RandomFloat(0, xt)) as int)
			taskmaster.SetFactionRank(DOMTraitExtraversion, (t02+RandomFloat(0, xt)/2.0) as int)
			taskmaster.SetFactionRank(DOMTraitOpenness,     (t05-RandomFloat(0, xt)/2.0) as int)
			taskmaster.SetFactionRank(DOMFacetSmartness,    (t08+RandomFloat(0, xt)) as int)
			taskmaster.SetFactionRank(DOMFacetToughness,    (t09+RandomFloat(0, xt)) as int)
			float[] TraitsArray	= GetNPCTraitsUpdateModifiers(taskmaster) ; Update traits and modifiers
		endif
	endif
EndFunction

int Function TrainActorNPC(float days, int trainType, Actor trainee, Actor trainer, Actor taskmaster, bool [] ignoreStat)	
	if trainee == None
		return 5 ; training done
	endif
	float amount = 10.0
	bool[] skipStat = new bool[5]
	skipStat[0] = false ; submission
	skipStat[1] = false ; respect
	skipStat[2] = false ; pose
	skipStat[3] = false ; sex
	skipStat[4] = false ; combat
	if (trainType == 0) ; All but combat
		skipStat[4] = true ; combat
		;amount = 40.0
	elseif (trainType == 1) ; Pain
		skipStat[1] = true ; respect
		skipStat[2] = true ; pose
		skipStat[3] = true ; sex
		skipStat[4] = true ; combat
	elseif (trainType == 2) ; Sex
		skipStat[0] = true ; submission
		skipStat[1] = true ; respect
		skipStat[2] = true ; pose
		skipStat[4] = true ; combat
	elseif (trainType == 3) ; Combat
		skipStat[0] = true ; submission
		skipStat[1] = true ; respect
		skipStat[2] = true ; pose
		skipStat[3] = true ; sex
	elseif (trainType == 4) ; Pose
		skipStat[0] = true ; submission
		skipStat[1] = true ; respect
		skipStat[3] = true ; sex
		skipStat[4] = true ; combat
	endif ; trainType == 5 ; Everything

	float tm_bonus
	if (taskmaster != None) 
		float tm_skill = DOM01.GetDeceiverModifier(taskmaster)
		float tm_extra = ((taskmaster.GetFactionRank(DOMTrainSubmission) - 80.0) / 40.0) 
		if (taskmaster.GetFactionRank(DOMTrainRespect) > 50)
			tm_extra += ((taskmaster.GetFactionRank(DOMTrainRespect) - 50.0) / 100.0)
		endif
		tm_bonus = 1.0 + tm_skill + tm_extra/4.0
	else
		tm_bonus = 1.0
	endif

	float trainer_bonus
	float  subt
	float  humt
	float  regt
	float  feat
	float  angt
	float  rest
	float  post
	float  orat
	float  vagt
	float  anat
	float  comt

	if trainer != None
		if trainType == 2 ; sex
			trainer_bonus = DOM01.GetDepraverModifier(trainer)
		elseif trainType == 4 ; pose
			trainer_bonus = DOM01.GetPersuaderModifier(trainer)
		else
			trainer_bonus = DOM01.GetEnforcerModifier(trainer)
		endif
		subt = trainer.GetFactionRank(DOMTrainSubmission) as float
		humt = trainer.GetFactionRank(DOMTrainHumiliation) as float
		regt = trainer.GetFactionRank(DOMTrainResignation) as float	
		feat = trainer.GetFactionRank(DOMTrainFear) as float
		angt = trainer.GetFactionRank(DOMTrainAnger) as float
		rest = trainer.GetFactionRank(DOMTrainRespect) as float
		post = trainer.GetFactionRank(DOMTrainPose) as float
		orat = trainer.GetFactionRank(DOMTrainOral) as float
		vagt = trainer.GetFactionRank(DOMTrainVaginal) as float
		anat = trainer.GetFactionRank(DOMTrainAnal) as float
		comt = GetFactionRankFloat(trainer,DOMTrainCombat) as float
	else
		trainer_bonus = 0.5
		subt = 100.0
		humt = 100.0
		regt = 100.0
		feat = 100.0
		angt = 100.0
		rest = 100.0
		post = 100.0
		orat = 100.0
		vagt = 100.0
		anat = 100.0
		comt = 100.0
	endif
	float bonus = days * tm_bonus * trainer_bonus * 0.5 * DOM01.train_speed_npc

	; Current training stats for trainee
	float  sub  = trainee.GetFactionRank(DOMTrainSubmission) as float
	float  hum  = trainee.GetFactionRank(DOMTrainHumiliation) as float
	float  reg  = trainee.GetFactionRank(DOMTrainResignation) as float
	float  fea  = trainee.GetFactionRank(DOMTrainFear) as float
	float  ang  = trainee.GetFactionRank(DOMTrainAnger) as float
	float  res  = trainee.GetFactionRank(DOMTrainRespect) as float
	float  pos  = trainee.GetFactionRank(DOMTrainPose) as float
	float  ora  = trainee.GetFactionRank(DOMTrainOral) as float
	float  vag  = trainee.GetFactionRank(DOMTrainVaginal) as float
	float  ana  = trainee.GetFactionRank(DOMTrainAnal) as float
	float  com  = GetFactionRankFloat(trainee,DOMTrainCombat) as float
	
	LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" before "+sub+" "+hum+" "+reg+" "+fea+" "+ang+" "+res+" | "+pos+" | "+ora+" "+vag+" "+ana+" | "+com)
	if trainer
		LogTrace("TrainActorNPC: trainer "+trainer.GetDisplayName()+" bonus="+trainer_bonus+" "+subt+" "+humt+" "+regt+" "+feat+" "+angt+" "+rest+" | "+post+" | "+orat+" "+vagt+" "+anat+" | "+comt)
	else
		LogTrace("TrainActorNPC: trainer NONE bonus="+trainer_bonus+" "+subt+" "+humt+" "+regt+" "+feat+" "+angt+" "+rest+" | "+post+" | "+orat+" "+vagt+" "+anat+" | "+comt)
	endif
	if taskmaster
		LogTrace("TrainActorNPC: taskmaster/mistress "+taskmaster.GetDisplayName()+" bonus="+tm_bonus)
	else
		LogTrace("TrainActorNPC: taskmaster/mistress NONE bonus="+tm_bonus)
	endif

	int rank
	if trainType == 0 || trainType == 5 ; all but combat or everything
		rank = trainee.GetFactionRank(DOMNbPain)
		if rank <= 0
			trainee.SetFactionRank(DOMNbPain,1)
		elseif rank < 127
			trainee.SetFactionRank(DOMNbPain,rank+1)
		endif
		rank = trainee.GetFactionRank(DOMNbRape)
		if rank <= 0
			trainee.SetFactionRank(DOMNbRape,1)
		elseif rank < 127
			trainee.SetFactionRank(DOMNbRape,rank+1)
		endif
	elseif trainType == 1 ; pain
		rank = trainee.GetFactionRank(DOMNbPain)
		if rank <= 0
			trainee.SetFactionRank(DOMNbPain,1)
		elseif rank < 127
			trainee.SetFactionRank(DOMNbPain,rank+1)
		endif
	elseif trainType == 2
		rank = trainee.GetFactionRank(DOMNbRape)
		if rank <= 0
			trainee.SetFactionRank(DOMNbRape,1)
		elseif rank < 127
			trainee.SetFactionRank(DOMNbRape,rank+1)
		endif
	endif

	if !ignoreStat[0] && !skipStat[0] ; submission/humiliation/resignation
		if (sub < subt)
			float  subd = DSubmission(sub, (amount+RandomFloat(0, amount))* bonus, trainee)
			sub += subd
			if (sub > subt)
				sub = subt
			endif
 			trainee.SetFactionRank(DOMTrainSubmission, sub as int)
		endif
		if (hum < humt)
			float  humd = DHumiliation(hum, (amount+RandomFloat(0, amount))* bonus, trainee)
			hum += humd
			if (hum > humt)
				hum = humt
			endif
 			trainee.SetFactionRank(DOMTrainHumiliation, hum as int)
		endif
		if (reg < regt)
			float  regd = DResignation(reg, (amount+RandomFloat(0, amount)) * bonus, trainee)
			reg += regd
			if (reg > regt)
				reg = regt
			endif
 			trainee.SetFactionRank(DOMTrainResignation, reg as int)
		endif
	endif
	if !ignoreStat[1] && !skipStat[1] ; fear/anger/respect
		if (fea < feat)
			float  fead = DFear(fea, (amount+RandomFloat(0, amount)) * bonus, trainee)
			fea += fead
			if (fea > feat)
				fea = feat
			endif
 			trainee.SetFactionRank(DOMTrainFear, fea as int)
		endif
		if (ang < angt)
			float  angd = DAnger(ang, (amount+RandomFloat(0, amount)) * bonus, trainee)
			ang += angd
			if (ang > angt)
				ang = angt
			endif
 			trainee.SetFactionRank(DOMTrainAnger, ang as int)
		endif
		if (res < rest)
			float  resd = DRespect(res, (amount+RandomFloat(0, amount)) * bonus, trainee)
			res += resd
			if (res > rest)
				res = rest
			endif
 			trainee.SetFactionRank(DOMTrainRespect, res as int)
		endif
	endif
	if !ignoreStat[2] && !skipStat[2] ; pose
		if (pos < post)
			float  posd = DPose(pos, (amount+RandomFloat(0, amount)) * bonus, trainee)
			pos += posd
			if (pos > post)
				pos = post
			endif
 			trainee.SetFactionRank(DOMTrainPose, pos as int)
		endif
	endif
	if !ignoreStat[3] && !skipStat[3] ; sex
		if (ora < orat)
			float  orad = DOralSex(ora, (amount+RandomFloat(0, amount)) * bonus, trainee)
			ora += orad
			if (ora > orat)
				ora = orat
			endif
 			trainee.SetFactionRank(DOMTrainOral, ora as int)
		endif
		if (vag < vagt)
			float  vagd = DVaginalSex(vag, (amount+RandomFloat(0, amount)) * bonus, trainee)
			vag += vagd
			if (vag > vagt)
				vag = vagt
			endif
 			trainee.SetFactionRank(DOMTrainVaginal, vag as int)
		endif
		if (ana < anat)
			float  anad = DAnalSex(ana, (amount+RandomFloat(0, amount)) * bonus, trainee)
			ana += anad
			if (ana > anat)
				ana = anat
			endif
 			trainee.SetFactionRank(DOMTrainAnal, ana as int)
		endif
		float sex = (ana+ora+vag)/3.0
		trainee.SetFactionRank(DOMTrainSex, sex as int)
	endif
	if !ignoreStat[4] && !skipStat[4] ; combat
		if (com < comt)
			float  comd = DCombat(com, (amount+RandomFloat(0, amount)) * bonus, trainee)
			com += comd
			if (com > comt)
				com = comt
			endif
			if com < 0
				com = 0
			elseif com > 127
				com = 127
			endif
 			trainee.SetFactionRank(DOMTrainCombat, com as int)
		endif
	endif

	; Update to values after training
	sub  = trainee.GetFactionRank(DOMTrainSubmission) as float
	hum  = trainee.GetFactionRank(DOMTrainHumiliation) as float
	reg  = trainee.GetFactionRank(DOMTrainResignation) as float
	fea  = trainee.GetFactionRank(DOMTrainFear) as float
	ang  = trainee.GetFactionRank(DOMTrainAnger) as float
	res  = trainee.GetFactionRank(DOMTrainRespect) as float
	pos  = trainee.GetFactionRank(DOMTrainPose) as float
	ora  = trainee.GetFactionRank(DOMTrainOral) as float
	vag  = trainee.GetFactionRank(DOMTrainVaginal) as float
	ana  = trainee.GetFactionRank(DOMTrainAnal) as float
	com  = GetFactionRankFloat(trainee,DOMTrainCombat) as float

	LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" amount="+amount+" bonus="+bonus)
	LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" after "+sub+" "+hum+" "+reg+" "+fea+" "+ang+" "+res+" | "+pos+" | "+ora+" "+vag+" "+ana+" | "+com)

	; what to train next?
	int train_next
	
	; Check for training end
	bool doneSub = (((sub >= subt) && (hum >= humt) && (res >= rest)) || (ignoreStat[0])) 
	bool doneRes = (((res >= rest) && (fea >= feat) && (ang >= angt)) || (ignoreStat[1])) 
	bool doneSex = (((ora >= orat) && (vag >= vagt) && (ana >= anat)) || (ignoreStat[3])) 
	bool doneCom = ((com >= comt) || (ignoreStat[4])) 
	bool donePos = ((pos >= post) || (ignoreStat[2])) 

	if (doneSub && doneRes && doneSex && donePos && doneCom)
		LogTrace("HomeSweetHome: trainee "+trainee.GetDisplayName()+" training done")
		TrainMasters(trainer,taskmaster)
		train_next = 5
	elseif (((trainType == 0) && (doneSub) && (doneRes)) || ((trainType == 1) && (doneSub)) || ((trainType == 2) && (doneSex)) || ((trainType == 3) && (doneCom)) || ((trainType == 4) && (donePos)) )
		if (sub < subt || hum < humt || reg < regt) && !doneSub
			LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" move to training 1 - sub")
			train_next = 1
		elseif (res < rest || fea < feat || ang < angt) && !doneRes
			LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" move to training 0 - res")
			train_next = 0
		elseif (ora < orat || vag < vagt || ana < anat) && !doneSex
			LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" move to training 2 - sex")
			train_next = 2
		elseif com < comt && !doneCom
			LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" move to training 3 - com")
			train_next = 3
		elseif pos < post && !donePos
			LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" move to training 4 - pos")
			train_next = 4
		else
			LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" move to training 5 - done ")
			train_next = 5
		endif
	else
		LogTrace("TrainActorNPC: trainee "+trainee.GetDisplayName()+" continue with training "+trainType)
		train_next = trainType
	endif
	return train_next
EndFunction

int Function TrainActorSubmissionOnHit(Actor akActor, float training)		
	int sub = akActor.GetFactionRank(DOMTrainSubmission)
	if sub >= 100
		return sub
	endif
	training += DSubmission(sub, 10, akActor)
	if training < 1
		training = 1.0
	endif
	int npain = akActor.GetFactionRank(DOMNbPain)
	if npain < 127
		akActor.SetFactionRank(DOMNbPain, npain+1)
	endif
	int dsub = training as int
	sub += dsub
	akActor.SetFactionRank(DOMTrainSubmission, sub)
	return sub
EndFunction

int Function TrainActorResignationOnHit(Actor akActor, float training)		
	int reg = akActor.GetFactionRank(DOMTrainResignation)
	if reg >= 100
		return reg
	endif
	training += DResignation(reg, 10, akActor)
	if training < 1
		training = 1.0
	endif
	int dreg = training as int
	reg += dreg
	akActor.SetFactionRank(DOMTrainResignation, reg)
	return reg
EndFunction

int Function TrainActorHumiliationOnHit(Actor akActor, float training)	
	int hum = akActor.GetFactionRank(DOMTrainHumiliation)
	if hum >= 100
		return hum
	endif
	training += DHumiliation(hum, 10, akActor)
	if training < 1
		training = 1.0
	endif
	int dhum = training as int
	hum += dhum
	akActor.SetFactionRank(DOMTrainHumiliation, hum)
	return hum
EndFunction

Function Alter_Persona(Actor akTarget, float amount)
	float[] TraitsArray = GetNPCTraits(akTarget)	
	
	traitsArray[0] = traitsArray[0] +amount*DOM_Util.RandG1() ; Sly/Honest  Hexaco: Honesty-Humility  
	traitsArray[1] = traitsArray[1] +amount*DOM_Util.RandG1() ; Anxious/Calm   Hexaco: Emotionality 
	traitsArray[2] = traitsArray[2] +amount*DOM_Util.RandG1() ; Shy/Lively     Hexaco: eXtraversion 
	traitsArray[3] = traitsArray[3] +amount*DOM_Util.RandG1() ; Grumpy/Gentle  Hexaco: Agreeableness
	traitsArray[4] = traitsArray[4] +amount*DOM_Util.RandG1() ; Lazy/Thorough  Hexaco: Conscientiousness 
	traitsArray[5] = traitsArray[5] +amount*DOM_Util.RandG1() ; Shallow/Open   Hexaco: Openness to Experience
	; Mind power
	TraitsArray[10] = TraitsArray[10] +amount*DOM_Util.RandG1() ; Needy, clingy/Bold,  independant, social sensitivity
	TraitsArray[6] = TraitsArray[6] +amount*DOM_Util.RandG1() ; Weak minded/Wilful, sensitivity to mind attacks
	TraitsArray[11] = TraitsArray[11] +amount*DOM_Util.RandG1() ; Stupid/Smart   strength of the mind
	; Physical power
	TraitsArray[8] = TraitsArray[8] +amount*DOM_Util.RandG1() ; Frigid/Sensual, sexual sensitivity
	TraitsArray[7]= TraitsArray[7]+amount*DOM_Util.RandG1() ; Delicate/Tough, physical sensitivity
	TraitsArray[9]= TraitsArray[9]+amount*DOM_Util.RandG1() ; DOM/Sub, perversion direction

	Debug.Notification(akTarget.getDisplayName()+"'s eyes blink for a short while")
	if amount>0
		SetNPCTraitsUpdateModifiers(akTarget, TraitsArray)
		Debug.Notification("Boosting "+akTarget.getDisplayName()+"'s personna by "+amount)
	elseif amount<0
		SetNPCTraitsUpdateModifiers(akTarget, TraitsArray)
		Debug.Notification("Shrinking "+akTarget.getDisplayName()+"'s personna by "+amount)
	else
		Debug.Notification("Alter persona spell has no effect on "+akTarget.getDisplayName())
	endif
EndFunction

Function Alter_Lust(Actor akTarget, float amount)
	float[] TraitsArray = GetNPCTraits(akTarget)	

	traitsArray[0] = traitsArray[0] +amount*DOM_Util.RandG1()   ; Sly/Honest  Hexaco: Honesty-Humility  
	traitsArray[2] = traitsArray[2] -amount*DOM_Util.RandG1()*2 ; Shy/Lively     Hexaco: eXtraversion 
	traitsArray[3] = traitsArray[3] +amount*DOM_Util.RandG1()*2 ; Grumpy/Gentle  Hexaco: Agreeableness
	traitsArray[5] = traitsArray[5] -amount*DOM_Util.RandG1()*3 ; Shallow/Open   Hexaco: Openness to Experience
	; Physical power
	TraitsArray[8] = TraitsArray[8] +amount*DOM_Util.RandG1()*3 ; Frigid/Sensual, sexual sensitivity
	TraitsArray[7]= TraitsArray[7]-amount*DOM_Util.RandG1()   ; Delicate/Tough, physical sensitivity
	TraitsArray[9]= TraitsArray[9]+amount*DOM_Util.RandG1()*3 ; DOM/Sub, perversion direction

	DOM01.DOMKeys.IncreaseArousal(akTarget,None,amount,DOMModDaring)
	
	Debug.Notification(akTarget.getDisplayName()+"'s cheeks got red for a short while")
	if amount>0
		SetNPCTraitsUpdateModifiers(akTarget, TraitsArray)
		Debug.Notification("Boosting "+akTarget.getDisplayName()+"'s lust by "+amount)
	elseif amount<0
		SetNPCTraitsUpdateModifiers(akTarget, TraitsArray)
		Debug.Notification("Shrinking "+akTarget.getDisplayName()+"'s lust by "+amount)
	else
		Debug.Notification("Lust spell has no effect on "+akTarget.getDisplayName())
	endif
EndFunction

Function Alter_Pain(Actor akTarget, float amount)
	float[] TraitsArray = GetNPCTraits(akTarget)	

	traitsArray[0] = traitsArray[0] +amount*DOM_Util.RandG1()   ; Sly/Honest  Hexaco: Honesty-Humility  
	traitsArray[1] = traitsArray[1] +amount*DOM_Util.RandG1()*2 ; Calm/Anxious   Hexaco: Emotionality 
	; Mind power
	TraitsArray[10] = TraitsArray[10] -amount*DOM_Util.RandG1()   ; Needy, clingy/Bold,  independant, social sensitivity
	TraitsArray[6] = TraitsArray[6] -amount*DOM_Util.RandG1()*3 ; Weak minded/Wilful, sensitivity to mind attacks
	; Physical power
	TraitsArray[8] = TraitsArray[8] +amount*DOM_Util.RandG1()*2 ; Frigid/Sensual, sexual sensitivity
	TraitsArray[7]= TraitsArray[7]-amount*DOM_Util.RandG1()*3 ; Delicate/Tough, physical sensitivity
	TraitsArray[9]= TraitsArray[9]+amount*DOM_Util.RandG1()*2 ; DOM/Sub, perversion direction

	Debug.Notification(akTarget.getDisplayName()+" shivers for a short while")
	if amount>0
		SetNPCTraitsUpdateModifiers(akTarget, TraitsArray)
		Debug.Notification("Boosting "+akTarget.getDisplayName()+"'s pain by "+amount)
	elseif amount<0
		SetNPCTraitsUpdateModifiers(akTarget, TraitsArray)
		Debug.Notification("Shrinking "+akTarget.getDisplayName()+"'s pain by "+amount)
	else
		Debug.Notification("Lash spell has no effect on "+akTarget.getDisplayName())
	endif
EndFunction

Function Alter_Virginity(Actor akRef)
	; Virgin status
	DOMSexlab.ClearStats(akRef)
	int virgin_status_vaginal = 0
	int virgin_status_anal    = 0
	int virgin_status_oral    = 0
	int virgin_status_same    = 0 
	int virgin_status_gang    = 0
	akRef.SetFactionRank(DOMVirginVaginal, virgin_status_vaginal)
	akRef.SetFactionRank(DOMVirginAnal, virgin_status_anal)
	akRef.SetFactionRank(DOMVirginOral, virgin_status_oral)
	akRef.SetFactionRank(DOMVirginSame, virgin_status_same)
	akRef.SetFactionRank(DOMVirginGangbang, virgin_status_gang)

	int vaginal_training = akRef.GetFactionRank(DOMTrainVaginal)
	int anal_training    = akRef.GetFactionRank(DOMTrainAnal)
	int oral_training    = akRef.GetFactionRank(DOMTrainOral)
	int sex_training     = akRef.GetFactionRank(DOMTrainSex)

	if vaginal_training < 0 || virgin_status_vaginal == 0
		vaginal_training = 0
	endif
	if anal_training < 0 || virgin_status_anal == 0
		anal_training = 0
	endif
	if oral_training < 0 || virgin_status_oral == 0
		oral_training = 0
	endif
	sex_training     = (((vaginal_training + anal_training + oral_training) as float)/3.0+0.5) as int ; recompute total training
	if sex_training > 127
		sex_training = 127
	endif

	akRef.SetFactionRank(DOMTrainVaginal, vaginal_training)
	akRef.SetFactionRank(DOMTrainAnal, anal_training)
	akRef.SetFactionRank(DOMTrainOral, oral_training)
	akRef.SetFactionRank(DOMTrainSex, sex_training)


	if virgin_status_vaginal == 0 && virgin_status_anal == 0 && virgin_status_oral == 0 && virgin_status_same == 0
		; never had sex
		akRef.SetFactionRank(DOMNbSex,0)
		akRef.SetFactionRank(DOMNbSexForMoney,0)
		akRef.SetFactionRank(DOMNbSexWithOthers,0)
		akRef.SetFactionRank(DOMNbRape,0)
		akRef.SetFactionRank(DOMNbOrgasm,0)
		akRef.SetFactionRank(DOMVirginGangbang,0)
	elseif vaginal_training == 0.0 && anal_training == 0.0 && oral_training == 0.0
		; was never trained
		akRef.SetFactionRank(DOMNbSex,0)
		akRef.SetFactionRank(DOMNbSexForMoney,0)
		akRef.SetFactionRank(DOMNbSexWithOthers,0)
		akRef.SetFactionRank(DOMNbRape,0)
		akRef.SetFactionRank(DOMNbOrgasm,0)
	endif
	
	Debug.Notification(akRef.getDisplayName()+"'s cheeks went red for a short while")
	;Debug.Notification(akRef.getDisplayName()+"'s virginity has been restored")
EndFunction

Function Restore_Persona(Actor akTarget)
	; -=TAK=- generate personality traits and feelings
	; Personnality traits as described by the HEXACO model
	float[] TraitsArray = GetTraitsReadOrGenerated(akTarget)	
	SetNPCTraitsUpdateModifiers(akTarget, TraitsArray)
	Debug.Notification(akTarget.getDisplayName()+"'s eyes blink for a short while")
	;Debug.Notification(akTarget.getDisplayName()+"'s personality has been restored")
EndFunction

Function EraseMemoryActor(Actor akTarget)
	akTarget.RemoveFromFaction(DOMTrainFear)
	akTarget.RemoveFromFaction(DOMTrainRespect)
	akTarget.RemoveFromFaction(DOMTrainAnger)
	akTarget.RemoveFromFaction(DOMTrainSubmission)
	akTarget.RemoveFromFaction(DOMTrainHumiliation)
	akTarget.RemoveFromFaction(DOMTrainResignation)

	akTarget.RemoveFromFaction(DOMTrainPose)
	akTarget.RemoveFromFaction(DOMTrainCombat)
	akTarget.RemoveFromFaction(DOMTrainHouse)
	akTarget.RemoveFromFaction(DOMTrainWorking)
	akTarget.RemoveFromFaction(DOMTraumaInDays)

	akTarget.RemoveFromFaction(DOMNbPraise)
	akTarget.RemoveFromFaction(DOMNbPain)
	akTarget.RemoveFromFaction(DOMNbBondage)
	akTarget.RemoveFromFaction(DOMNbToldoff)
	akTarget.RemoveFromFaction(DOMNbShame)
	akTarget.RemoveFromFaction(DOMNbComfort)
	akTarget.RemoveFromFaction(DOMNbFlatter)
	akTarget.RemoveFromFaction(DOMNbInsult)
	akTarget.RemoveFromFaction(DOMNbPromise)
	akTarget.RemoveFromFaction(DOMNbThreat)
	akTarget.RemoveFromFaction(DOMNbKinkTrigger)
	akTarget.RemoveFromFaction(DOMNbShock)
	akTarget.RemoveFromFaction(DOMNbBroken)	
	akTarget.RemoveFromFaction(DOMNbBrainwashed)	
	akTarget.RemoveFromFaction(DOMNbChatFeelings)
	akTarget.RemoveFromFaction(DOMNbChatPersonality)
	
	akTarget.RemoveFromFaction(DOMNbTrainee)
	akTarget.RemoveFromFaction(DOMNbTrainer)
	akTarget.RemoveFromFaction(DOMNbWhoredSlaves)
	akTarget.RemoveFromFaction(DOMNbRecruitedSlavers)
	akTarget.RemoveFromFaction(DOMNbRansomedSlaves)
	akTarget.RemoveFromFaction(DOMNbCapturedSlaves)
	akTarget.RemoveFromFaction(DOMNbSoldSlaves)
	akTarget.RemoveFromFaction(DOMNbBrokenSlaves)
	akTarget.RemoveFromFaction(DOMNbPlayerFling)
	akTarget.RemoveFromFaction(DOMNbPlayerChat)
EndFunction

Function Alter_Training(Actor akTarget, float amount)
	float[] TraitsArray = GetNPCTraits(akTarget)	

	;LogTrace(akTarget.getDisplayName()+" looks down in submission amount(original)="+amount)
	; wilpower modifier
	amount = amount*(1.3-TraitsArray[6]/100.0)
	;LogTrace(akTarget.getDisplayName()+" looks down in submission amount(wilpower)="+amount)
	; smartness modifier
	amount = amount*(1.5-TraitsArray[11]/100.0)
	;LogTrace(akTarget.getDisplayName()+" looks down in submission amount(smart)="+amount)
	SetNPCDefaultTraining(akTarget)
	PrintTraining(akTarget)
	bool [] ignoreStat = new bool[5]
	ignoreStat[0] = false
	ignoreStat[1] = false
	ignoreStat[2] = false
	ignoreStat[3] = false
	ignoreStat[4] = false
	TrainActorNPC(amount/10.0, 5, akTarget, None, None, ignoreStat)

	IncrementFactionRank(akTarget,DOMNbShock)
	IncrementFactionRank(akTarget,DOMNbPraise)
	IncrementFactionRank(akTarget,DOMNbPain)
	IncrementFactionRank(akTarget,DOMNbToldoff)
	
	PrintTraining(akTarget)

	float mag = 0.0
	if akTarget.IsInFaction(DOMTrainSubmission)
		mag += akTarget.GetFactionRank(DOMTrainSubmission)
	endif
	if mag<34.0
		Debug.Notification(akTarget.getDisplayName()+" looks down for a short while")
	elseif mag<70.0
		Debug.Notification(akTarget.getDisplayName()+" looks down for a while")
	elseif mag<100.0
		Debug.Notification(akTarget.getDisplayName()+" looks down in submission")
	else
		Debug.Notification(akTarget.getDisplayName()+" looks down in total submission")
	endif
EndFunction

Function IncrementFactionRank(Actor akTarget, Faction akFaction)
	if akTarget.IsInFaction(akFaction)
		int rank = akTarget.getFactionRank(akFaction)+1
		akTarget.setFactionRank(akFaction, rank)
	else
		akTarget.setFactionRank(akFaction, 1)
	endif
EndFunction

int Function GetNPCWealth(Actor akRef)
	; get previous employers and jobs
	int jobs = akRef.getFactionRank(DOMJobOriginFaction)  
	int emps = akRef.getFactionRank(DOMEmployerOriginFaction) 
	int skil = akRef.getFactionRank(DOMTrainerOriginFaction) 

	if(jobs<0 && emps<0) ; Probably a unique NPC we need to evaluate
		jobs = GetJobOfOriginIndex(akRef)
		emps = GetEmployerOfOriginIndex(akRef)
		skil = GetTrainerOfOriginIndex(akRef)
	endif
	;LogTrace(akRef.GetDisplayName()+" jobs="+jobs+" employers="+emps)

	; Estimate wealth per NPC
	float multiplier
	; Modifier
	; Super rich *100000
	; Nobility NPC *10000
	; Rich *1000
	; Middle class *100
	; Poor *10
	; Beggar *1

	; This reflects only Skyrim jobs and employers not real life nor anyother part of Cyrodil
	if jobs == 1 ; Jarl
		multiplier = 10000.0
	elseif jobs == 2 ; Nobility
		multiplier = 2000.0
	elseif jobs == 3 ; Exiled Nobility
		multiplier = 1000.0
	elseif jobs == 4 ; Bandit
		multiplier = 45.0
	elseif jobs == 5 ; Forsworn
		multiplier = 30.0
	elseif jobs == 8 ; DB
		multiplier = 400.0
	elseif jobs == 9 ; Thief
		multiplier = 125.0
	elseif jobs >= 6 && jobs <= 15 ; Trained fighter: Legion, Stormcloaks, Blades, Companions, Vigilant, Guards
		multiplier = 150.0
	elseif jobs >= 16 && jobs <= 24 ; Educated: Wizard, Priest, ...
		multiplier = 300.0
	elseif jobs == 25 ; Bards
		multiplier = 220.0
	elseif jobs >= 26 && jobs <= 29 ; Merchant
		multiplier = 500.0
	elseif jobs >= 30 && jobs <= 32 ; Artisans ; factor of 2 between master and apprentice in the middle-ages
		multiplier = 100.0
	elseif jobs >= 33 && jobs <= 36 ; Physical labor farmer, miner
		multiplier = 10.0
	elseif jobs == 37 	; Guard
		multiplier = 40.0
	elseif jobs == 38 	; Beggar
		multiplier = 1.0
	elseif jobs == 39 	; Fence
		multiplier = 200.0
	elseif jobs == 40 || jobs == 41 ; Works at an inn
		multiplier = 140.0
	elseif jobs == 50 ; Travelling Wench
		multiplier = 270.0
	elseif jobs == 51 ; Travelling servant
		multiplier = 30.0
	elseif jobs == 52 ; Travelling bodyguard
		multiplier = 180.0
	elseif jobs >= 100 && jobs <= 105 ; Slaves
		multiplier = 0.0
	elseif jobs == 106 ; Slavers
		multiplier = 800.0
	else
		multiplier = 20.0
	endif
	if emps > 0 ; Works at court
		multiplier = 50.0
	endif

	int wealth_amount = ((multiplier*DOM01.wealth_modifier) as int)
	int gold_amount = DOM01.DOMEquip.HasGold(akRef)
	LogTrace(akRef.GetDisplayName()+" wealth to spend="+multiplier+" * "+DOM01.wealth_modifier+" ="+wealth_amount+" gold in inventory="+gold_amount)
	return wealth_amount + gold_amount
EndFunction

; Utils

Function SetPlaceOfOrigin(Actor akRef, int idx)
	;LogTrace("SetPlaceOfOrigin region="+idx)
	if idx < 0
		return
	endif
	akRef.setFactionRank(DOM04.DOMPlaceOriginFaction, idx)
EndFunction

Function SetJobOfOrigin(Actor akRef, int idx)
	;LogTrace("SetJobOfOrigin job="+idx)
	if idx < 0
		return
	endif
	akRef.setFactionRank(DOM04.DOMJobOriginFaction, idx)
EndFunction

Function SetEmployerOfOrigin(Actor akRef, int idx)
	;LogTrace("SetEmployerOfOrigin employer="+idx)
	if idx <  0
		return
	endif
	akRef.setFactionRank(DOM04.DOMEmployerOriginFaction, idx)
EndFunction

Function SetTrainerOfOrigin(Actor akRef, int idx)
	;LogTrace("SetTrainerOfOrigin trainer="+idx)
	if idx < 0
		return
	endif
	akRef.setFactionRank(DOM04.DOMTrainerOriginFaction, idx)
EndFunction

Function SetClassOfOrigin(Actor akRef, int idx)
	;LogTrace("SetClassOfOrigin trainer="+idx)
	if idx < 0
		return
	endif
	akRef.setFactionRank(DOM04.DOMClassOriginFaction, idx)
EndFunction

int Function GetJobOfOriginIndex(Actor akRef)
	int rank = akRef.getFactionRank(DOM04.DOMJobOriginFaction)
	;LogTrace("GetJobOfOriginIndex start rank="+rank)
	if rank >= 0
		;LogTrace("GetJobOfOriginIndex already set rank="+rank)
		return rank ; Already Set by DOM
	endif
	; Not set
	; Faction members
	if akRef.IsInFaction(JobJarlFaction)
		rank = 1 ; Jarl
	elseif akRef.IsInFaction(GovRuling)
		rank = 2 ; Nobility
	elseif akRef.IsInFaction(GovExiled)
		rank = 3 ; Exiled nobility
	elseif akRef.IsInFaction(BanditFaction)
		rank = 4 ; Bandit
	elseif akRef.IsInFaction(ForswornFaction)
		rank = 5 ; Forsworn
	elseif akRef.isInFaction(CWImperialFaction) || akRef.isInFaction(CWImperialFactionNPC)
		rank = 6 ; "a member of the imperial legion"
	elseif akRef.isInFaction(CWSonsFaction) || akRef.isInFaction(CWSonsFactionNPC) || akRef.isInFaction(CrimeFactionSons)
		rank = 7 ; "a member of the stormcloaks"
	elseif akRef.isInFaction(DarkBrotherhoodFaction)
		rank = 8 ; "a member of the dark brotherhood"
	elseif akRef.isInFaction(ThievesGuildFaction) || akRef.isInFaction(CrimeFactionThievesGuild)
		rank = 9 ; "a member of the thieves guild"
	elseif akRef.isInFaction(CompanionsFaction)
		rank = 10 ; "a member of the companions"
	elseif akRef.isInFaction(WerewolfFaction)
		rank = 11 ; "a wild werewolf"
	elseif akRef.isInFaction(SilverHandFaction)
		rank = 12 ; "a member of the silver hand"
	elseif akRef.isInFaction(BladesFaction)
		rank = 13 ; "a member of the blades"
	elseif akRef.isInFaction(VigilantOfStendarrFaction)
		rank = 14 ; "a vigilant of Stendarr"
	elseif akRef.isInFaction(ArenaFaction)
		rank = 15 ; "a member of the Arena"
	elseif akRef.isInFaction(ThalmorFaction)
		rank = 16 ; "a thalmor"
	elseif akRef.isInFaction(NecromancerFaction)
		rank = 17 ; "a necromancer"
	elseif akRef.isInFaction(WarlockFaction)
		rank = 18 ; "a warlock "
	elseif akRef.isInFaction(VampireFaction) || akRef.isInFaction(DLC1VampireCrimeFaction)
		rank = 19 ; "a vampire"
	; Jobs
	elseif akRef.IsInFaction(JobCourtWizardFaction)
		rank = 20 ; Wizard		
	elseif akRef.IsInFaction(JobJusticiar)
		rank = 21 ; Justiciar		
	elseif akRef.IsInFaction(JobPriestFaction)
		rank = 22 ; Priest		
	elseif akRef.IsInFaction(JobOrcWiseWomanFaction)
		rank = 23 ; Wise woman		
	elseif akRef.IsInFaction(JobStewardFaction)
		rank = 24 ; Steward		
	elseif akRef.IsInFaction(JobBardFaction)
		rank = 25 ; Bard		
	elseif akRef.IsInFaction(JobJewelerFaction)
		rank = 26 ; Jeweler	
	elseif akRef.IsInFaction(JobApothecaryFaction)
		rank = 27 ; Apothecary		
	elseif akRef.IsInFaction(JobTailorFaction)
		rank = 28 ; Tailor		
	elseif akRef.IsInFaction(JobMerchantFaction)
		rank = 29 ; Merchant		
	elseif akRef.IsInFaction(CaravanMerchant)
		rank = 30 ; Caravan merchant		
	elseif akRef.IsInFaction(JobFletcherFaction)
		rank = 31 ; Fletcher
	elseif akRef.IsInFaction(JobBlacksmithFaction)
		rank = 32 ; Blacksmith
	elseif akRef.IsInFaction(JobFarmerFaction)
		rank = 33 ; Farmer
	elseif akRef.IsInFaction(HunterFaction)
		rank = 34 ; Hunter
	elseif akRef.IsInFaction(JobLumberjackFaction)
		rank = 35 ; Lumberjack
	elseif akRef.IsInFaction(JobMinerFaction)
		rank = 36 ; Miner
	elseif akRef.isInFaction(GuardDialogueFaction)
		rank = 37 ; "a guard"
	elseif akRef.IsInFaction(FavorJobsBeggarsFaction)
		rank = 38 ; "a beggar"
	elseif akRef.IsInFaction(JobFenceFaction)
		rank = 39 ; "a fence"
	elseif akRef.IsInFaction(JobInnkeeperFaction)
		rank = 40 ; "an inn keeper"
	elseif akRef.IsInFaction(JobInnServer)
		rank = 41 ; "an inn servant"
	; Creatures
	elseif akRef.isInFaction(HagravenFaction)
		rank = 49 ; Hagraven
	; Wenches
	elseif DOM01.TravellingWenchesFaction != None && akRef.isInFaction(DOM01.TravellingWenchesFaction)
		rank = 50 ; "a travelling wench"
	elseif DOM01.TravellingWenchesJudgementFaction != None && akRef.isInFaction(DOM01.TravellingWenchesJudgementFaction)
		rank = 50 ; "a travelling wench"
	elseif DOM01.TravellingWenchesCollectedFaction != None && akRef.isInFaction(DOM01.TravellingWenchesCollectedFaction)
		rank = 50 ; "a travelling wench"
	elseif DOM01.TravellingWenchesServantFaction != None && akRef.isInFaction(DOM01.TravellingWenchesServantFaction)
		rank = 51 ; "a travelling servant"
	elseif DOM01.TravellingWenchesPatrolFaction != None && akRef.isInFaction(DOM01.TravellingWenchesPatrolFaction)
		rank = 52 ; "a travelling bodyguard"
	; Slaves and slavers
	elseif DOM01.DLC1ThrallFaction != None && akRef.isInFaction(DOM01.DLC1ThrallFaction)
		rank = 100 ; "merely a piece of meat used by vampires"
	elseif DOM01.AygasSlaveTypeFaction != None && akRef.isInFaction(DOM01.AygasSlaveTypeFaction)
		rank = 101 ; "sold as a slave"
	elseif DOM01.HydraSlaveFaction != None && akRef.isInFaction(DOM01.HydraSlaveFaction)
		rank = 102 ; "a slave of Hydra"
	elseif DOM01.VanillaBanditsSlaveFaction != None && akRef.isInFaction(DOM01.VanillaBanditsSlaveFaction)
		rank = 103 ; "a bandit's slave"
	elseif DOM01.VanillaBanditsExSlaveFaction != None && akRef.isInFaction(DOM01.VanillaBanditsExSlaveFaction)
		rank = 104 ; "a fugitive bandit's slave"
	elseif DOMZaz.isZazSlave(akRef) || akRef.IsInFaction(DOMNotPlayerSlaveFaction)
		rank = 105 ; "a slave"
	elseif DOMZaz.isZazSlaver(akRef) || akRef.IsInFaction(DOMNotPlayerSlaverFaction)
		rank = 106 ; "a slaver"
	endif

	;LogTrace("GetJobOfOriginIndex setting rank="+rank)
	if rank < 0
		rank = 0
	endif
	SetJobOfOrigin(akRef,rank)
	;LogTrace("GetJobOfOriginIndex end rank="+rank)
	return rank
EndFunction

int Function GetEmployerOfOriginIndex(Actor akRef)
	int rank = akRef.getFactionRank(DOM04.DOMEmployerOriginFaction)
	if rank >= 0 
		return rank ; Already Set by DOM
	endif
	; Not set 
	if akRef.IsInFaction(DawnstarWhiteHallFaction)
		rank = 1 ; Dawnstar
	elseif akRef.IsInFaction(FalkreathJarlsLonghouseFaction)
		rank = 2 ; Falkreath
	elseif akRef.IsInFaction(MarkarthCastleServantsFaction) || akRef.IsInFaction(MarkarthKeepFaction)
		rank = 3 ; Markarth
	elseif akRef.IsInFaction(MorthalLonghouseFaction)
		rank = 4 ; Morthal
	elseif akRef.IsInFaction(RiftenMistveilKeepFaction)
		rank = 5 ; Riften
	elseif akRef.IsInFaction(SolitudeBluePalaceFaction) || akRef.IsInFaction(SolitudeBluePalaceServants)
		rank = 6 ; Solitude
	elseif akRef.IsInFaction(WhiterunDragonsReachServants)
		rank = 7 ; Whiterun
	elseif akRef.IsInFaction(WindhelmPalace)
		rank = 8 ; Windhelm
	elseif akRef.IsInFaction(WinterholdJarlFaction)
		rank = 9 ; Winterhold
	endif

	if rank < 0
		rank = 0
	endif
	SetEmployerOfOrigin(akRef,rank)
	return rank
EndFunction

int Function GetTrainerOfOriginIndex(Actor akRef)
	int rank = akRef.getFactionRank(DOM04.DOMTrainerOriginFaction)
	if rank >= 0
		return rank ; Already Set by DOM
	endif
	; Not set
	if akRef.IsInFaction(JobTrainerAlterationFaction)
		rank = 1 ; "Alteration Trainer" 
	elseif akRef.IsInFaction(JobTrainerConjurationFaction)
		rank = 2 ; "Conjuration Trainer" 
	elseif akRef.IsInFaction(JobTrainerDestructionFaction)
		rank = 3 ; "Destruction Trainer" 
	elseif akRef.IsInFaction(JobTrainerIllusionFaction)
		rank = 4 ; "Illusion Trainer" 
	elseif akRef.IsInFaction(JobTrainerRestorationFaction)
		rank = 5 ; "Restoration Trainer" 
	elseif akRef.IsInFaction(JobTrainerEnchantingFaction)
		rank = 6 ; "Enchanting Trainer" 
	elseif akRef.IsInFaction(JobTrainerAlchemyFaction)
		rank = 7 ; "Alchemy Trainer" 
	elseif akRef.IsInFaction(JobTrainerSpeechcraftFaction)
		rank = 8 ; "Speechcraft Trainer" 
	elseif akRef.IsInFaction(JobTrainerSmithingFaction)
		rank = 9 ; "Smithing Trainer" 
	elseif akRef.IsInFaction(JobTrainerOneHandedFaction)
		rank = 10 ; "One-Handed Trainer" 
	elseif akRef.IsInFaction(JobTrainerTwoHandedFaction)
		rank = 11 ; "Two-handed Trainer" 
	elseif akRef.IsInFaction(JobTrainerBlockFaction)
		rank = 12 ; "Block Trainer" 
	elseif akRef.IsInFaction(JobTrainerHeavyArmorFaction)
		rank = 13 ; "HeavyArmor Trainer" 
	elseif akRef.IsInFaction(JobTrainerLightArmorFaction)
		rank = 14 ; "Light Armor Trainer" 
	elseif akRef.IsInFaction(JobTrainerMarksmanFaction)
		rank = 15 ; "Marksman Trainer" 
	elseif akRef.IsInFaction(JobTrainerSneakFaction)
		rank = 16 ; "Sneak Trainer" 
	elseif akRef.IsInFaction(JobTrainerLockpickingFaction)
		rank = 17 ; "Lockpicking Trainer" 
	elseif akRef.IsInFaction(JobTrainerPickpocketFaction)
		rank = 18 ; "Pickpocket Trainer" 
	endif

	if rank < 0
		rank = 0
	endif
	SetTrainerOfOrigin(akRef,rank)
	return rank
EndFunction

int Function GetClassOfOriginIndex(Actor akRef)
	int rank = akRef.getFactionRank(DOM04.DOMEmployerOriginFaction)
	if rank >= 0 
		return rank ; Already Set by DOM
	endif
	; Not set 
	actorBase abTarget = akRef.GetLeveledActorBase()
	Class ActorClass  = abTarget.GetClass()
	string classString = ActorClass.GetName() ; +" "+MiscUtil.GetClassEditorID(ActorClass)

	if stringUtil.find(classString,"Archer")>=0
		rank = 1
	elseif stringUtil.find(classString,"Missile")>=0
		rank = 2
	elseif(stringUtil.find(classString,"Warrior")>=0) 
		rank = 3
	elseif stringUtil.find(classString,"Melee")>=0
		rank = 4
	elseif(stringUtil.find(classString,"Barbarian")>=0)
		rank = 5
	elseif (stringUtil.find(classString,"Hero")>=0)
		rank = 6
	elseif(stringUtil.find(classString,"Wizard")>=0)
		rank = 7
	elseif (stringUtil.find(classString,"Sorcerer")>=0)
		rank = 10
	elseif(stringUtil.find(classString,"Warlock")>=0) 
		rank = 11
	elseif stringUtil.find(classString,"Witchblade")>=0
		rank = 12
	elseif(stringUtil.find(classString,"Priest")>=0)
		rank = 13
	elseif (stringUtil.find(classString,"Monk")>=0)
		rank = 14
	elseif(stringUtil.find(classString,"Shaman")>=0)
		rank = 15
	elseif (stringUtil.find(classString,"Mystic")>=0)
		rank = 16
	elseif(stringUtil.find(classString,"Bard")>=0)
		rank = 17
	elseif(stringUtil.find(classString,"Assassin")>=0)
		rank = 18
	elseif (stringUtil.find(classString,"Nightblade")>=0)
		rank = 19
	elseif(stringUtil.find(classString,"Rogue")>=0)
		rank = 20
	elseif (stringUtil.find(classString,"Thief")>=0)
		rank = 21
	elseif(stringUtil.find(classString,"Scout")>=0)
		rank = 22
	elseif(stringUtil.find(classString,"Ranger")>=0)
		rank = 23
	elseif(stringUtil.find(classString,"Blade")>=0)
		rank = 24
	elseif(stringUtil.find(classString,"Vigilant")>=0)
		rank = 25
	elseif(stringUtil.find(classString,"Guard")>=0) 
		rank = 26
	elseif stringUtil.find(classString,"Soldier")>=0
		rank = 27
	elseif(stringUtil.find(classString,"MageConjurer")>=0)
		rank = 9
	elseif(stringUtil.find(classString,"MageDestruction")>=0)
		rank = 7
	elseif(stringUtil.find(classString,"Flame")>=0)
		rank = 35
	elseif(stringUtil.find(classString,"Frost")>=0)
		rank = 36
	elseif(stringUtil.find(classString,"Storm")>=0)
		rank = 37
	elseif(stringUtil.find(classString,"Atronach")>=0)
		rank = 29
	elseif(stringUtil.find(classString,"MageElemental")>=0)
		rank = 29
	elseif(stringUtil.find(classString,"MageNecro")>=0)
		rank = 30
	elseif(stringUtil.find(classString,"Nightingale")>=0)
		rank = 31
	elseif(stringUtil.find(classString,"Spellsword")>=0)
		rank = 32
	elseif(stringUtil.find(classString,"Predator")>=0)
		rank = 33
	elseif(stringUtil.find(classString,"Animal")>=0)
		rank = 34
	elseif(stringUtil.find(classString,"Conjurer")>=0) 
		rank = 9
	elseif (stringUtil.find(classString,"Mage")>=0)
		rank = 8
	elseif(stringUtil.find(classString,"Bandit")>=0)
		rank = 28
	endif

	if rank < 0
		rank = 0
	endif
	SetClassOfOrigin(akRef,rank)
	return rank
EndFunction

int Function GetPlaceOfOriginIndex(Actor akRef)
	int rank = akRef.getFactionRank(DOM04.DOMPlaceOriginFaction)
	if rank >= 0
		return rank ; Already Set by DOM
	endif
	; Not set
	if akRef.isInFaction(CrimeFactionEastMarch)
		rank = 1 ; "the East March"
	elseif akRef.isInFaction(CrimeFactionFalkreath)
		rank = 2 ; "Falkreath"
	elseif akRef.isInFaction(CrimeFactionHaafingar)
		rank = 3 ; "Haafingar"
	elseif akRef.isInFaction(CrimeFactionHjaalmarch)
		rank = 4 ; "Hjaalmarch"
	elseif akRef.isInFaction(CrimeFactionPale)
		rank = 5 ; "the Pale"
	elseif akRef.isInFaction(CrimeFactionReach)
		rank = 6 ; "the Reach"
	elseif akRef.isInFaction(CrimeFactionRift)
		rank = 7 ; "the Rift"
	elseif akRef.isInFaction(CrimeFactionWhiterun)
		rank = 8 ; "Whiterun"
	elseif akRef.isInFaction(CrimeFactionWinterhold)
		rank = 9 ; "Winterhold"
	elseif akRef.isInFaction(CrimeFactionOrcs)
		rank = 10 ; "the Orc Strongholds"
	elseif akRef.isInFaction(CrimeFactionCidhnaMine)
		rank = 11 ; "Cidhna Mine"
	elseif akRef.isInFaction(CrimeFactionGreybeard)
		rank = 12 ; "the Throat of the World"
	elseif akRef.isInFaction(CrimeFactionImperial)
		rank = 13 ; "Cyrodiil"
	elseif akRef.isInFaction(CrimeFactionKhajiitCaravans)
		rank = 14 ; "the Khajiit Caravans"
	endif
	; 0 = Skyrim
	if rank < 0
		rank = 0
	else
		SetPlaceOfOrigin(akRef,rank)
	endif
	return rank
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Generator: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_Generator: "+msg)
	endif
EndFunction
