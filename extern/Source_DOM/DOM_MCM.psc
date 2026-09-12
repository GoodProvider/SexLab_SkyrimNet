 Scriptname DOM_MCM extends SKI_ConfigBase
Import Utility
Import DOM_Util

DOM_PlayerAlias Property DOMPlayerAlias Auto 
DOM_Core Property DOMCore Auto
DOM_Animator Property DOM_Anim Auto
DOM_Bathing Property DOMBath Auto
DOM_Equip Property DOMEquip Auto
DOM_Keys Property DOMKeys Auto
DOM_SlaverManager Property DOM01 Auto
DOM_SlaveManager Property DOM02 Auto
DOM_Diary Property DOM04 Auto
DOM_PAH Property DOMPAH Auto
DOM_ZAZ Property DOMZAZ Auto
DOM_SEXLAB Property DOMSexlab Auto
DOM_Generator Property DOMGenerator Auto

Actor Property PlayerRef Auto

GlobalVariable Property DOM_TrainingThresholdLow Auto 
GlobalVariable Property DOM_TrainingThresholdMedium Auto 
GlobalVariable Property DOM_TrainingThresholdHigh Auto 
GlobalVariable Property DOM_TrainingThresholdMax Auto 
GlobalVariable Property DOM_SubmissionMinValue Auto 
GlobalVariable Property DOM_DeactivateDialogueFollow Auto 
GlobalVariable Property DOM_DeactivateDialogueForNPC Auto 
GlobalVariable Property DOM_DeactivateDialogueForDOM Auto 
GlobalVariable Property DOM_HealthPercentage Auto 
GlobalVariable Property DOM_HealthMinValue Auto 
GlobalVariable Property DOM_NumberOfExtraMng Auto 
GlobalVariable Property DOM_OppositeSexTopics auto 
GlobalVariable Property DOM_SameSexTopics auto 
GlobalVariable Property DOM_ActivateCombatAbduction auto 
GlobalVariable Property DOM_ActivateCombatRecruit auto 
GlobalVariable Property DOM_RelationShipClosenessValue auto 
GlobalVariable Property DOM_RelationShipIntimacyValue auto 
GlobalVariable Property DOM_Version auto 

bool activateDialogueFollow = true
bool activateDialogueForNPC = true
bool activateDialogueForDOM = true
bool activateCombatAbduction = true
bool activateCombatRecruit = true

Int GroupChoiceRandom_OID
Int GroupChoicePose_OID
Int StartupCheckActor_OID
Int StartupSyncTattoos_OID
Int CaptureSyncTattoos_OID
Int UpdateCombatStrength_OID
Int setOBodyPresetToggleF_OID
Int setOBodyPresetToggleM_OID
Int setTransferNodeToggle_OID
Int cryingPunishmentToggle_OID 
Int cryingPraiseToggle_OID 
Int travelCuffsToggle_OID 
Int punishPoseToggle_OID 
Int punishTieToggle_OID
Int punishMasturbateToggle_OID
Int punishRestrainToggle_OID
Int attentionPose_OID
Int salutePose_OID
Int kneelPose_OID
Int salutePoseOn_OID
Int attentionPoseOn_OID
Int kneelPoseOn_OID
Int poseMoveToggle_OID
Int checkInteriorPosesToggle_OID
Int spellPose1_OID
Int spellPose2_OID
Int ExportSettings_OID
Int ImportSettings_OID
Int playerSkillsMessageToggle_OID
Int kinksPlayerSubToggle_OID
Int kinksPlayerDomToggle_OID
Int friendsPlayerToggle_OID
Int activateDialogueFollow_OID
Int activateDialogueForNPC_OID
Int activateDialogueForDOM_OID
Int playerDiaryToggle_OID
Int playerJournalToggle_OID
Int playerLedgerToggle_OID
Int slaveDiaryToggle_OID
Int slaverDiaryToggle_OID
Int resetAllDiary_OID
Int resetAllmemories_OID
Int equipSlaver_OID
Int clearWidgets_OID
Int transferDOMtoPAHE_OID
Int transferPAHEtoDOM_OID
Int registerSexLab_OID
Int wMessageToggle_OID
Int wMessageLevel0_OID
Int wMessageLevel1_OID
Int wMessageLevel2_OID
Int wMessageLevel3_OID
Int wMessageLevel4_OID
Int wMessageLevel5_OID
Int[] widgetColor_OID
Int marks_color_OID
Int marks_glow_OID
Int marks_glow_status_OID
Int marks_gloss_OID
Int brand_color_OID
Int brand_glow_OID
Int brand_glow_status_OID
Int brand_gloss_OID
Int blushFToggle_OID
Int tearsFToggle_OID
Int masctFToggle_OID
Int blushMToggle_OID
Int tearsMToggle_OID
Int masctMToggle_OID
Int resilienceToggle_OID
Int loyalToggle_OID
Int inloveToggle_OID
Int depressedToggle_OID
Int insecureToggle_OID
Int jealousyToggle_OID
Int greedToggle_OID
Int friendToggle_OID
Int friendPlayerToggle_OID
Int friendFollowToggle_OID
Int friendDistantToggle_OID
Int hugWhenFreedToggle_OID
Int familyToggle_OID
Int answerToggle_OID
Int topicsToggle_OID
Int itemEquipToggle_OID
Int instantEquipToggle_OID
Int instantUnEquipToggle_OID
Int cellEquipToggle_OID
Int locationEquipToggle_OID
Int shameArea52_OID
Int maskPubicArea_OID
Int maskFillHerUp_OID
Int useStripKeywords_OID
Int resetStripKeywords_OID
Int neverStripFX_OID
Int stripAndDropToggle_OID
Int stripDeleteToggle_OID
Int stripLootToggle_OID
Int stripItemsToggle_OID
Int stripUnequippedToggle_OID
Int stripWeaponsToggle_OID
Int stripShieldsToggle_OID
Int stripHeelsToggle_OID
Int stripUnderwearToggle_OID
Int stripJewelryToggle_OID
Int removeBlindfoldToggle_OID
Int removeGagToggle_OID
Int removeCuffsToggle_OID
Int undressBeforeSex_OID
Int redressAfterSex_OID
Int doAnimBeforeAndAfterSex_OID
Int doAnimPlayerTieup_OID
Int doRipOffBeforeSex_OID
Int addAbductionSpell_OID
Int addDiarySpell_OID
Int addMenuSpell_OID
Int addMenuPower_OID
Int addInfoSpell_OID
Int addInfoPower_OID
Int addWakeUpPerk_OID
Int addBurlapSackPerk_OID
Int addAbductionPerk_OID
Int addRecruitPerk_OID
Int activateCombatAbduction_OID
Int activateCombatRecruit_OID
Int addSlapTool_OID
Int seedUniques_OID
Int RandomFlat_OID
Int RemoveEssentialToggle_OID
Int SetEssentialToggle_OID
Int phhshUseSLAL_OID
Int debugMode_OID
Int debugInit_OID
Int debugKeyMode_OID
Int writeJSONRelease_OID
Int writeJSONTransfer_OID
Int trainSexlabValuesToggle_OID
Int readSexlabValuesToggle_OID
Int VampireCattleToggle_OID
Int sendDOMOrders_OID
Int sendDOMEquipEvent_OID
Int sendDOMCaptureEvent_OID
Int sendDOMEvents_OID
Int forbidAnimalCapture_OID
Int forbidCreatureCapture_OID
Int forbidUndeadCapture_OID
Int showKinksToggle_OID
Int ReadJSONTraitsToggle_OID
Int ReadJSONTraitsWarning_OID
Int ReadJSONRelationshipToggle_OID
Int ReadJSONVirginityToggle_OID
Int ReadJSONTrainingToggle_OID
Int ReadJSONKinksToggle_OID
Int ReadJSONMemoriesToggle_OID
Int readJSONForUniques_OID
Int readJSONForSpawned_OID
Int useBiS_OID
Int singleTellToggle_OID
Int removeSlavesSpells_OID
Int removeSlaversSpells_OID
Int summonPAHToggle_OID
Int summonPosingToggle_OID
Int printActorBonusesToggle_OID
Int verboseMode_OID
Int verboseTopics_OID
Int wheelsUseVerboseMessage_OID
Int dialoguesUseVerboseMessage_OID
Int verboseAnim_OID
Int verboseEquip_OID
Int rescaleAnimToggle_OID
Int doAnimateAtActorLocation_OID
Int alwaysRandomizeAnimations_OID
Int doPlayerAnim_OID
Int doPlayerIdle_OID
Int doFreeCamera_OID
Int doRemoveHeels_OID
Int startSexlabPreferablyPlayer_OID
Int startSexlabPreferablyNPC_OID
Int startSexlabPreferablyDOM_OID
Int separateOrgasmToggle_OID
Int alwaysAggressiveToggle_OID
Int alwaysGentleToggle_OID
Int useAggressiveTag_OID
Int dualAnimToggle_OID
Int requireSLTags_OID					 
Int requireSLTags4_OID					 
Int requireSLTags3_OID					 
Int staticTraitsMode_OID
Int staticTraitsChat_OID
Int renameToggle_OID
Int cloneUniqueMode_OID
Int cloneSpawnMode_OID
Int cleanCrimeFaction_OID
Int cleanFactionUnique_OID
Int cleanFactionSpawn_OID
Int cleanUniqueOutfit_OID
Int cleanSpawnOutfit_OID
Int cleanSlaverOutfit_OID
Int restoreOutfitUnique_OID
Int restoreOutfitSpawn_OID
Int restoreOutfitAlways_OID
Int tieupWhenUnBagToggle_OID
Int alarmToggleAbduction2_OID
Int alarmToggleAbduction_OID
Int alarmToggleWitness3_OID
Int alarmToggleWitness2_OID
Int alarmToggleWitness_OID
Int alarmToggleRunaway_OID
Int escapeToggle_OID
Int fHitToggle_OID
Int sHitToggle_OID
Int rivalryToggle_OID
Int weaponsOToggle_OID
Int weaponsBToggle_OID
Int weaponsFToggle_OID
Int weaponsMToggle_OID
Int virginOToggle_OID
Int virginAToggle_OID
Int virginVToggle_OID
Int virginSToggle_OID
Int virginGToggle_OID
Int oppositeSexToggle_OID
Int sameSexToggle_OID
Int allowSlavesGear_OID
Int allowSlaversGear_OID
Int HKModifier_OID
Int HKModifierDefault_OID
Int HKFixme_OID
Int HKTest_OID
Int HKMenu0_OID
Int HKMenu1_OID
Int HKMenu2_OID
Int HKMenu3_OID
Int HKMenu4_OID
Int HKMenu5_OID
Int HKMenu6_OID
Int HKMenu7_OID
Int HKMenu8_OID
Int HKMenu9_OID
Int HKMenu10_OID
Int HKMenuPAH_OID
Int HKMenuSlavers_OID					 
Int HKMenuExtraSlaves_OID					 
Int HKAbduction_OID
Int HKAction_OID
Int HKDiary_OID
Int HKBagIn_OID
Int HKBagOut_OID
Int HKTraits_OID
Int HKFeels_OID
Int HKStatus_OID
Int HKMood_OID
Int HKMove_OID
Int HKInventory_OID
Int HKPraise_OID
Int HKScold_OID
Int HKPunish_OID
Int HKChoke_OID
Int HKKneel_OID
Int HKAttention_OID
Int HKFavor_OID
Int HKRipOff_OID
Int HKStrip_OID
Int HKCome_OID
Int HKTraitsDigits_OID
Int HKFeelsDigits_OID
Int HKFollow_OID
Int HKFollowAll_OID
Int wheelIsDefaultMenu_OID
Int wheelIsDefaultCall_OID
Int wheelUsesDefaultPunishmentType_OID
Int wheelUsesDefaultPraiseType_OID
Int cleanDeleteToggle_OID
Int cleanAmmoToggle_OID
Int cleanWeaponsToggle_OID
Int cleanArmorsToggle_OID
Int cleanBooksToggle_OID
Int cleanScrollsToggle_OID
Int playerTitle_OID
Int playerGender_OID
Int actorTitle_OID
Int actorName_OID
Int actorWrite_OID
Int actorRead_OID
Int actorRemoveSpells_OID
Int actorRemoveBaseSpells_OID
Int actorPrevious_OID
Int actorRace_OID
Int actorGender_OID
Int actionGroup_OID
Int actionFlag_OID
Int actionName_OID
Int actionType_OID
Int actorPose_OID
Int actorStrugglePose_OID
Int actorFightForPlayer_OID
Int actorHoldWeapons_OID
Int actorWearArmor_OID
Int actorBeNaked_OID
Int actorBeRespectful_OID
Int actorBeSilent_OID
Int actorNoOrgasm_OID
Int actorWalkOnFour_OID
Int actorEssential_OID
Int actorThrall_OID
Int actorSummon_OID
Int actorResetDiary_OID
Int actorRelease_OID
Int actorFixme_OID
Int actorFixTats_OID
Int actorSummonBag_OID

string[] pageNames

State PUN_closeness_value
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_RelationShipClosenessValue.GetValue())
		SetSliderDialogDefaultValue(3.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_RelationShipClosenessValue.SetValue(value)
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOM_RelationShipClosenessValue.SetValue(3.0)
		SetSliderOptionValueST(3.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Minimum relationship value ("+((DOM_RelationShipClosenessValue.GetValue()) as int)+") above which closeness actions are allowed")
	EndEvent
EndState

State PUN_intimacy_value
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_RelationShipIntimacyValue.GetValue())
		SetSliderDialogDefaultValue(4.0)
		SetSliderDialogRange(0.0, 5.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_RelationShipIntimacyValue.SetValue(value)
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOM_RelationShipIntimacyValue.SetValue(4.0)
		SetSliderOptionValueST(4.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Minimum relationship value ("+((DOM_RelationShipIntimacyValue.GetValue()) as int)+") above which intimacy actions are allowed")
	EndEvent
EndState

State PUN_health_percentage
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_HealthPercentage.GetValue()*100.0)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_HealthPercentage.SetValue(value/100.0)
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOM_HealthPercentage.SetValue(0.3)
		SetSliderOptionValueST(30.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Health percentage value ("+((DOM_HealthPercentage.GetValue()*100.0) as int)+"%) below which capture is allowed")
	EndEvent
EndState

State PUN_health_value
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_HealthMinValue.GetValue())
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(5.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_HealthMinValue.SetValue(value)
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOM_HealthMinValue.SetValue(10.0)
		SetSliderOptionValueST(10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Health absolute value ("+((DOM_HealthMinValue.GetValue()) as int)+") below which capture is allowed")
	EndEvent
EndState

State PUN_submission_value
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_SubmissionMinValue.GetValue())
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_SubmissionMinValue.SetValue(value)
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOM_SubmissionMinValue.SetValue(70.0)
		SetSliderOptionValueST(70.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Minimun submission value ("+((DOM_SubmissionMinValue.GetValue()) as int)+") to have nice sex with actor")
	EndEvent
EndState

State PUN_training_threshold_low
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_TrainingThresholdLow.GetValue())
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_TrainingThresholdLow.SetValue(value)
		SetSliderOptionValueST(value)
		if DOM_TrainingThresholdMedium.GetValue() < value 
			DOM_TrainingThresholdMedium.SetValue(value)
		endif
		if DOM_TrainingThresholdHigh.GetValue() < value 
			DOM_TrainingThresholdHigh.SetValue(value)
		endif
		if DOM_TrainingThresholdMax.GetValue() < value 
			DOM_TrainingThresholdMax.SetValue(value)
		endif
	EndEvent
	Event OnDefaultST()
		DOM_TrainingThresholdLow.SetValue(30.0)
		SetSliderOptionValueST(30.0)
		if DOM_TrainingThresholdMedium.GetValue() < 30.0 
			DOM_TrainingThresholdMedium.SetValue(30.0)
		endif
		if DOM_TrainingThresholdHigh.GetValue() < 30.0 
			DOM_TrainingThresholdHigh.SetValue(30.0)
		endif
		if DOM_TrainingThresholdMax.GetValue() < 30.0 
			DOM_TrainingThresholdMax.SetValue(30.0)
		endif
	EndEvent
	Event OnHighlightST()
		SetInfoText("Minimun training stat value ("+((DOM_TrainingThresholdLow.GetValue()) as int)+") for low level abuse")
	EndEvent
EndState

State PUN_training_threshold_medium
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_TrainingThresholdMedium.GetValue())
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_TrainingThresholdMedium.SetValue(value)
		SetSliderOptionValueST(value)
		if DOM_TrainingThresholdLow.GetValue() > value 
			DOM_TrainingThresholdLow.SetValue(value)
		endif
		if DOM_TrainingThresholdHigh.GetValue() < value 
			DOM_TrainingThresholdHigh.SetValue(value)
		endif
		if DOM_TrainingThresholdMax.GetValue() < value 
			DOM_TrainingThresholdMax.SetValue(value)
		endif
	EndEvent
	Event OnDefaultST()
		DOM_TrainingThresholdMedium.SetValue(50.0)
		SetSliderOptionValueST(50.0)
		if DOM_TrainingThresholdLow.GetValue() > 50.0 
			DOM_TrainingThresholdLow.SetValue(50.0)
		endif
		if DOM_TrainingThresholdHigh.GetValue() < 50.0 
			DOM_TrainingThresholdHigh.SetValue(50.0)
		endif
		if DOM_TrainingThresholdMax.GetValue() < 50.0 
			DOM_TrainingThresholdMax.SetValue(50.0)
		endif
	EndEvent
	Event OnHighlightST()
		SetInfoText("Minimun training stat value ("+((DOM_TrainingThresholdMedium.GetValue()) as int)+") for medium level abuse")
	EndEvent
EndState

State PUN_training_threshold_high
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_TrainingThresholdHigh.GetValue())
		SetSliderDialogDefaultValue(70.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_TrainingThresholdHigh.SetValue(value)
		SetSliderOptionValueST(value)
		if DOM_TrainingThresholdLow.GetValue() > value 
			DOM_TrainingThresholdLow.SetValue(value)
		endif
		if DOM_TrainingThresholdMedium.GetValue() > value 
			DOM_TrainingThresholdMedium.SetValue(value)
		endif
		if DOM_TrainingThresholdMax.GetValue() < value 
			DOM_TrainingThresholdMax.SetValue(value)
		endif
	EndEvent
	Event OnDefaultST()
		DOM_TrainingThresholdHigh.SetValue(70.0)
		SetSliderOptionValueST(70.0)
		if DOM_TrainingThresholdLow.GetValue() > 70.0 
			DOM_TrainingThresholdLow.SetValue(70.0)
		endif
		if DOM_TrainingThresholdMedium.GetValue() > 70.0 
			DOM_TrainingThresholdMedium.SetValue(70.0)
		endif
		if DOM_TrainingThresholdMax.GetValue() < 70.0 
			DOM_TrainingThresholdMax.SetValue(70.0)
		endif
	EndEvent
	Event OnHighlightST()
		SetInfoText("Minimun training stat value ("+((DOM_TrainingThresholdHigh.GetValue()) as int)+") for high level abuse")
	EndEvent
EndState

State PUN_training_threshold_max
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM_TrainingThresholdMax.GetValue())
		SetSliderDialogDefaultValue(90.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM_TrainingThresholdMax.SetValue(value)
		SetSliderOptionValueST(value)
		if DOM_TrainingThresholdLow.GetValue() > value 
			DOM_TrainingThresholdLow.SetValue(value)
		endif
		if DOM_TrainingThresholdMedium.GetValue() > value 
			DOM_TrainingThresholdMedium.SetValue(value)
		endif
		if DOM_TrainingThresholdHigh.GetValue() > value 
			DOM_TrainingThresholdHigh.SetValue(value)
		endif
	EndEvent
	Event OnDefaultST()
		DOM_TrainingThresholdMax.SetValue(90.0)
		SetSliderOptionValueST(90.0)
		if DOM_TrainingThresholdLow.GetValue() > 90.0 
			DOM_TrainingThresholdLow.SetValue(90.0)
		endif
		if DOM_TrainingThresholdMedium.GetValue() > 90.0 
			DOM_TrainingThresholdMedium.SetValue(90.0)
		endif
		if DOM_TrainingThresholdHigh.GetValue() > 90.0 
			DOM_TrainingThresholdHigh.SetValue(90.0)
		endif
	EndEvent
	Event OnHighlightST()
		SetInfoText("Minimun training stat value ("+((DOM_TrainingThresholdMax.GetValue()) as int)+") for max level abuse")
	EndEvent
EndState

State PUN_postrape_delay
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMSexlab.postRapeDelay)
		SetSliderDialogDefaultValue(15.0)
		SetSliderDialogRange(0.0, 30.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMSexlab.postRapeDelay = value
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMSexlab.postRapeDelay = 15.0
		SetSliderOptionValueST(15.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Post rape delay "+((DOMSexlab.postRapeDelay) as int)+" in seconds")
	EndEvent
EndState

State PUN_delete_percentage
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.deleteActorThreshold)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.deleteActorThreshold = value
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.deleteActorThreshold = 10.0
		SetSliderOptionValueST(10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Delete released actor if submission is lower than "+((DOMCore.deleteActorThreshold) as int))
	EndEvent
EndState

State PUN_wealth_modifier
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.wealth_modifier)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.wealth_modifier = value
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.wealth_modifier = 10.0
		SetSliderOptionValueST(DOMCore.wealth_modifier)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$NPC wealth modifier when buying slaves from player")
	EndEvent
EndState

State PUN_chanceRunAwayMultiplier
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.chanceRunAwayMultiplier*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.chanceRunAwayMultiplier = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.chanceRunAwayMultiplier = 1.0
		SetSliderOptionValueST(DOMCore.chanceRunAwayMultiplier*100.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Runaway chance multiplier in percent. The lower the less chance to runaway.")
	EndEvent
EndState

State PUN_update_timer
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.actorUpdateTimer*1000.0)
		SetSliderDialogDefaultValue(3000.0)
		SetSliderDialogRange(100.0, 10000.0)
		SetSliderDialogInterval(100.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.actorUpdateTimer = value/1000.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.actorUpdateTimer = 3.0
		SetSliderOptionValueST(DOMCore.actorUpdateTimer*1000.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Tick length in ms between status update for DOM actors")
	EndEvent
EndState

State PUN_update_timer_global
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.actorUpdateTimerGlobal*1000.0)
		SetSliderDialogDefaultValue(1000.0)
		SetSliderDialogRange(100.0, 10000.0)
		SetSliderDialogInterval(100.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.actorUpdateTimerGlobal = value/1000.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.actorUpdateTimerGlobal = 1.0
		SetSliderOptionValueST(DOMCore.actorUpdateTimerGlobal*1000.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Tick length in ms between global update for DOM core")
	EndEvent
EndState

State PUN_delay_topic
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.delayTopic)
		SetSliderDialogDefaultValue(30)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.delayTopic = value as int
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.delayTopic = 10
		SetSliderOptionValueST(DOMCore.delayTopic)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Timeout in ticks between allowed comments for 1 actor")
	EndEvent
EndState

State PUN_delay_topic_global
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.delayTopicGlobal)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.delayTopicGlobal = value as int
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.delayTopic = 3
		SetSliderOptionValueST(DOMCore.delayTopicGlobal)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Timeout in seconds between allowed comments for all actors")
	EndEvent
EndState

State PUN_number_of_widgets
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.number_of_widgets)
		SetSliderDialogDefaultValue(8.0)
		SetSliderDialogRange(0.0, 20.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.number_of_widgets = value as int
		SetSliderOptionValueST(value)
		DOMCore.InitMessageWidgets(DOMCore.HorizontalAnchor,DOMCore.verticalAnchor)
	EndEvent
	Event OnDefaultST()
		DOMCore.number_of_widgets = 8
		SetSliderOptionValueST(DOMCore.number_of_widgets)
		DOMCore.InitMessageWidgets(DOMCore.HorizontalAnchor,DOMCore.verticalAnchor)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Maximum number of slave message widgets")
	EndEvent
EndState

State PUN_trait_race_bonus
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.trait_race_bonus*10.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.trait_race_bonus = value/10.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.trait_race_bonus = 1.0
		SetSliderOptionValueST(DOMCore.trait_race_bonus*10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Race and type bonus to personality trait modifier")
	EndEvent
EndState

State PUN_trait_class_bonus
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.trait_class_bonus*10.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.trait_class_bonus = value/10.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.trait_class_bonus = 1.0
		SetSliderOptionValueST(DOMCore.trait_class_bonus*10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Class and trainer skill bonus to personality trait modifier")
	EndEvent
EndState

State PUN_trait_job_bonus
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.trait_job_bonus*10.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.trait_job_bonus = value/10.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.trait_job_bonus = 1.0
		SetSliderOptionValueST(DOMCore.trait_job_bonus*10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Job and emploter bonus to personality trait modifier")
	EndEvent
EndState

State PUN_trait_gender_bonus
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.trait_gender_bonus*10.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.trait_gender_bonus = value/10.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.trait_gender_bonus = 1.0
		SetSliderOptionValueST(DOMCore.trait_gender_bonus*10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Gender bonus to personality trait modifier")
	EndEvent
EndState

State PUN_trait_age_bonus
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.trait_age_bonus*10.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.trait_age_bonus = value/10.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.trait_age_bonus = 1.0
		SetSliderOptionValueST(DOMCore.trait_age_bonus*10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Age bonus to personality trait modifier")
	EndEvent
EndState

State PUN_trait_place_bonus
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.trait_place_bonus*10.0)
		SetSliderDialogDefaultValue(10.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.trait_place_bonus = value/10.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.trait_place_bonus = 1.0
		SetSliderOptionValueST(DOMCore.trait_place_bonus*10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Location bonus to personality trait modifier")
	EndEvent
EndState

State PUN_trait_variation
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.trait_variation)
		SetSliderDialogDefaultValue(25.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.trait_variation = value
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.trait_variation = 25.0
		SetSliderOptionValueST(DOMCore.trait_variation)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Maximum personality trait variation from special events")
	EndEvent
EndState

State PUN_runaway_value
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.runAwayValue)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.runAwayValue = value
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.runAwayValue = 60.0
		SetSliderOptionValueST(DOMCore.runAwayValue)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Maximum personality trait variation from special events")
	EndEvent
EndState

State PUN_maxNumberOfParagraph
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOM04.maxNumberOfParagraph)
		SetSliderDialogDefaultValue(128.0)
		SetSliderDialogRange(1.0, 128.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOM04.maxNumberOfParagraph = value as int
		if DOM04.maxNumberOfParagraph > DOM04.DiaryParagraph.length
			DOM04.maxNumberOfParagraph = DOM04.DiaryParagraph.length
		endif
		if DOM04.maxNumberOfParagraph < 1
			DOM04.maxNumberOfParagraph = 1
		endif
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOM04.maxNumberOfParagraph = 128
		if DOM04.maxNumberOfParagraph > DOM04.DiaryParagraph.length
			DOM04.maxNumberOfParagraph = DOM04.DiaryParagraph.length
		endif
		if DOM04.maxNumberOfParagraph < 1
			DOM04.maxNumberOfParagraph = 1
		endif
		SetSliderOptionValueST(DOM04.maxNumberOfParagraph)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Maximum number of paragraph in slave and slaver's diary")
	EndEvent
EndState

State PUN_friend_threshold
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.friend_threshold*100.0)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.friend_threshold = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.friend_threshold = 0.6
		SetSliderOptionValueST(60.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Friendship threshold above which friends are created in %")
	EndEvent
EndState

State PUN_pose_threshold
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.pose_threshold*1440.0)
		SetSliderDialogDefaultValue(60.0)
		SetSliderDialogRange(0.0, 2000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.pose_threshold = value/1440.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.pose_threshold = 1.0/24.0
		SetSliderOptionValueST(60.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Pose threshold in game minutes after which praising is possible")
	EndEvent
EndState

State PUN_anim_speed_sec
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.anim_speed_sec*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.anim_speed_sec = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.anim_speed_sec = 1.0
		SetSliderOptionValueST(100.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Dual animation length")
	EndEvent
EndState

State PUN_orgasm_modifier
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_orgasm*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_orgasm = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_orgasm = 0.25
		SetSliderOptionValueST(25.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Orgasm chance modifier")
	EndEvent
EndState

State PUN_arousal_modifier
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_arousal*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_arousal = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_arousal = 0.5
		SetSliderOptionValueST(50.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Arousal chance modifier")
	EndEvent
EndState

State PUN_love_modifier
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_love*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_love = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_love = 0.25
		SetSliderOptionValueST(25.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Love/loyal training modifier")
	EndEvent
EndState

State PUN_kinktraining_modifier
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_kink*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_kink = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_kink = 1.0
		SetSliderOptionValueST(100.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Kink training modifier")
	EndEvent
EndState

State PUN_kinkarousal_modifier
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.arousal_speed_kink*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.arousal_speed_kink = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.arousal_speed_kink = 1.0
		SetSliderOptionValueST(100.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Kink arousal modifier")
	EndEvent
EndState

State PUN_kinkorgasm_modifier
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.orgasm_speed_kink*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 200.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.orgasm_speed_kink = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.orgasm_speed_kink = 1.0
		SetSliderOptionValueST(100.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Kink orgasm modifier")
	EndEvent
EndState

State PUN_MaxNumberOfFriends
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.MaxNumberOfFriends)
		SetSliderDialogDefaultValue(5.0)
		SetSliderDialogRange(0.0, 16.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.MaxNumberOfFriends = value as int
		SetSliderOptionValueST(DOMCore.MaxNumberOfFriends)
	EndEvent
	Event OnDefaultST()
		DOMCore.MaxNumberOfFriends = 5
		SetSliderOptionValueST(DOMCore.MaxNumberOfFriends)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Maximum number of friends not counting family members")
	EndEvent
EndState

State PUN_regen_ticks
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.actorRegenTicks)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.actorRegenTicks = value as int
		SetSliderOptionValueST(DOMCore.actorRegenTicks)
	EndEvent
	Event OnDefaultST()
		DOMCore.actorRegenTicks = 1
		SetSliderOptionValueST(DOMCore.actorRegenTicks)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Number of ticks before regen (O is never)")
	EndEvent
EndState

State PUN_regen_amount
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.actorRegenAmount)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(1.0, 100.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.actorRegenAmount = value
		SetSliderOptionValueST(DOMCore.actorRegenAmount)
	EndEvent
	Event OnDefaultST()
		DOMCore.actorRegenAmount = 5.0
		SetSliderOptionValueST(DOMCore.actorRegenAmount)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Number of health points to regen per second in per mil")
	EndEvent
EndState

State PUN_dirty_amount
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.dirtRegenAmount*10.0)
		SetSliderDialogDefaultValue(30.0)
		SetSliderDialogRange(0.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.dirtRegenAmount = value/10.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.dirtRegenAmount = 3.0
		SetSliderOptionValueST(DOMCore.dirtRegenAmount*10.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Amount of dirtiness gained in 10 days")
	EndEvent
EndState

State PUN_skills_difficulty
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMPlayerAlias.skills_difficulty*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMPlayerAlias.skills_difficulty = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMPlayerAlias.skills_difficulty = 1.0
		SetSliderOptionValueST(DOMPlayerAlias.skills_difficulty*100.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("Training speed for player skills")
	EndEvent
EndState

State PUN_train_speed_npc
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_npc*100.0)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_npc = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_npc = 1.0
		SetSliderOptionValueST(100.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Training speed when using NPC trainer")
	EndEvent
EndState

State PUN_train_speed_player
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_player*100.0)
		SetSliderDialogDefaultValue(120.0)
		SetSliderDialogRange(1.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_player = value/100.0
		SetSliderOptionValueST(value)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_player = 1.0
		SetSliderOptionValueST(120.0)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Training speed when using Player as trainer")
	EndEvent
EndState

State PUN_train_speed_pain
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_pain)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_pain = value
		SetSliderOptionValueST(DOMCore.train_speed_pain)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_pain = 100.0
		SetSliderOptionValueST(DOMCore.train_speed_pain)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Training speed for pain punishments")
	EndEvent
EndState

State PUN_train_speed_sex
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_sex)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_sex = value
		SetSliderOptionValueST(DOMCore.train_speed_sex)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_sex = 100.0
		SetSliderOptionValueST(DOMCore.train_speed_sex)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Training speed for sex")
	EndEvent
EndState

State PUN_train_speed_rape
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_rape)
		SetSliderDialogDefaultValue(100.0)
		SetSliderDialogRange(1.0, 1000.0)
		SetSliderDialogInterval(1.0)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_rape = value
		SetSliderOptionValueST(DOMCore.train_speed_rape)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_rape = 100.0
		SetSliderOptionValueST(DOMCore.train_speed_rape)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Training speed for rape")
	EndEvent
EndState

State PUN_train_speed_tell
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_tell)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(1, 1000)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_tell = value
		SetSliderOptionValueST(DOMCore.train_speed_tell)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_tell = 100
		SetSliderOptionValueST(DOMCore.train_speed_tell)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Training speed for scolding slaves")
	EndEvent
EndState

State PUN_train_speed_good
	Event OnSliderOpenST()
		SetSliderDialogStartValue(DOMCore.train_speed_good)
		SetSliderDialogDefaultValue(100)
		SetSliderDialogRange(1, 1000)
		SetSliderDialogInterval(1)
	EndEvent
	Event OnSliderAcceptST(float value)
		DOMCore.train_speed_good = value
		SetSliderOptionValueST(DOMCore.train_speed_good)
	EndEvent
	Event OnDefaultST()
		DOMCore.train_speed_good = 100
		SetSliderOptionValueST(DOMCore.train_speed_good)
	EndEvent
	Event OnHighlightST()
		SetInfoText("$Training speed for praising slaves")
	EndEvent
EndState

state DefaultPraiseType
    event OnMenuOpenST()
		int idx = DOMCore.GetJSONPraisingTypeIndexByName(DOMCore.DefaultPraiseType)
		DOMCore.DefaultPraiseType = DOMCore.g_praisetype_names[idx]
        SetMenuDialogStartIndex(idx)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(DOMCore.g_praisetype_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
            SetMenuOptionValueST(DOMCore.g_praisetype_names[index])
			DOMCore.DefaultPraiseType = DOMCore.g_praisetype_names[index]
			LogTrace("DefaultPraiseType = "+DOMCore.DefaultPraiseType)
         endif
    endevent
endstate

state DefaultPunishmentType
    event OnMenuOpenST()
		int idx = DOMCore.GetJSONPunishmentTypeIndexByName(DOMCore.DefaultPunishmentType)
		DOMCore.DefaultPunishmentType = DOMCore.g_punishtype_names[idx]
        SetMenuDialogStartIndex(idx)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(DOMCore.g_punishtype_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
            SetMenuOptionValueST(DOMCore.g_punishtype_names[index])
			DOMCore.DefaultPunishmentType = DOMCore.g_punishtype_names[index]
			LogTrace("DefaultPunishmentType = "+DOMCore.DefaultPunishmentType)
        endif
    endevent
endstate

state DefaultWheelPraiseType
    event OnMenuOpenST()
		int idx = DOMCore.GetJSONPraisingTypeIndexByName(DOMCore.DefaultWheelPraiseType)
		DOMCore.DefaultWheelPraiseType = DOMCore.g_praisetype_names[idx]
        SetMenuDialogStartIndex(idx)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(DOMCore.g_praisetype_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
            SetMenuOptionValueST(DOMCore.g_praisetype_names[index])
			DOMCore.DefaultWheelPraiseType = DOMCore.g_praisetype_names[index]
			LogTrace("DefaultWheelPraiseType = "+DOMCore.DefaultWheelPraiseType)
         endif
    endevent
endstate

state DefaultWheelPunishmentType
    event OnMenuOpenST()
		int idx = DOMCore.GetJSONPunishmentTypeIndexByName(DOMCore.DefaultWheelPunishmentType)
		DOMCore.DefaultWheelPunishmentType = DOMCore.g_punishtype_names[idx]
        SetMenuDialogStartIndex(idx)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(DOMCore.g_punishtype_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
            SetMenuOptionValueST(DOMCore.g_punishtype_names[index])
			DOMCore.DefaultWheelPunishmentType = DOMCore.g_punishtype_names[index]
			LogTrace("DefaultWheelPunishmentType = "+DOMCore.DefaultWheelPunishmentType)
        endif
    endevent
endstate

string[] default_follow_mode_names
state DefaultFollowMode
    event OnMenuOpenST()
        SetMenuDialogStartIndex(DOMCore.DefaultFollowMode)
        SetMenuDialogDefaultIndex(2)
        SetMenuDialogOptions(default_follow_mode_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
            SetMenuOptionValueST(default_follow_mode_names[index])
			DOMCore.DefaultFollowMode = index
        endif
    endevent
endstate

string[] default_wait_mode_names
state DefaultWaitMode
    event OnMenuOpenST()
        SetMenuDialogStartIndex(DOMCore.DefaultWaitMode)
        SetMenuDialogDefaultIndex(2)
        SetMenuDialogOptions(default_wait_mode_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
            SetMenuOptionValueST(default_wait_mode_names[index])
			DOMCore.DefaultWaitMode = index
        endif
    endevent
endstate

string[] horizontal_anchor_names
state HorizontalAnchor
    event OnMenuOpenST()
		int idx = 0
		if DOMCore.HorizontalAnchor == "Center"
			idx = 1
		elseif DOMCore.HorizontalAnchor == "Right"
			idx = 2
		endif
        SetMenuDialogStartIndex(idx)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(horizontal_anchor_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
            SetMenuOptionValueST(horizontal_anchor_names[index])
			DOMCore.HorizontalAnchor = horizontal_anchor_names[index]
			DOMCore.InitMessageWidgets(DOMCore.HorizontalAnchor,DOMCore.verticalAnchor)
        endif
    endevent
endstate

string[] vertical_anchor_names
state VerticalAnchor
    event OnMenuOpenST()
 		int idx = 0
		if DOMCore.VerticalAnchor == "Center"
			idx = 1
		elseif DOMCore.VerticalAnchor == "Bottom"
			idx = 2
		endif
       SetMenuDialogStartIndex(idx)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(vertical_anchor_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
            SetMenuOptionValueST(vertical_anchor_names[index])
			DOMCore.VerticalAnchor = vertical_anchor_names[index]
			DOMCore.InitMessageWidgets(DOMCore.HorizontalAnchor,DOMCore.verticalAnchor)
        endif
    endevent
endstate

; Tattoos and slave marks

int tattoos = 0
Function SetupTattooSections()
	int cache = SlaveTats.acquire_cache()
    int DOMain = JMap.getObj(cache, "default")
	string area = tattoos_area_current
	if area == ""
		area = DOMCore.marks_area
	endif
    tattoos = JValue.releaseAndRetain(tattoos, JValue.deepCopy(JMap.getObj(DOMain, area)))
    JMap.setObj(tattoos, "[No Tattoo]", JValue.objectFromPrototype("[{\"name\":\"[No Tattoo]\", \"section\":\"[No Tattoo]\", \"area\":\"" + area + "\"}]"))
    tattoos_section_names = JMap.allKeysPArray(tattoos)
EndFunction

Function SetupTattooNames()
	int applied = JValue.addToPool(JArray.object(), "SlaveTats-_setup_tattoos")
	string section = tattoos_section_current
	if section == ""
		section = DOMCore.marks_section
	endif
    int tats = JMap.getObj(tattoos, section)

    if tats == 0
        JValue.cleanPool("SlaveTats-_setup_tattoos")
        return
    endif

    int buffer1 = JValue.addToPool(JArray.object(), "SlaveTats-_setup_tattoos")
    int buffer2 = JValue.addToPool(JArray.object(), "SlaveTats-_setup_tattoos")

    int i = 0
    int num_tats = JArray.count(tats)
    while i < num_tats
        int entry = JArray.getObj(tats, i)
        if (SlaveTats.find_excluding_tattoo(applied, entry) < 0) && (SlaveTats.find_required_tattoo(applied, entry) >= 0)
            JMap.removeKey(entry, "slot") ; The menu does not respect tattoo pre-specified slots. That's for mods.
            JArray.addStr(buffer1, JMap.getStr(entry, "name"))
            JArray.addStr(buffer2, JMap.getStr(entry, "texture"))
            i += 1
        else
            JArray.eraseIndex(tats, i)
        endif
    endwhile

    tattoos_item_names = JArray.asStringArray(buffer1)
    tattoos_file_names = JArray.asStringArray(buffer2)

    JValue.cleanPool("SlaveTats-_setup_tattoos")
EndFunction

string tattoos_area_current
string[] tattoos_area_names
state TattoosArea
    event OnMenuOpenST()
		if tattoos_area_current == ""
			 tattoos_area_current = DOMCore.marks_area
		endif
		int idx = 0
		if tattoos_area_current == "Face"
			idx = 1
		elseif tattoos_area_current == "Hands"
			idx = 2
		elseif tattoos_area_current == "Feet"
			idx = 3
		endif
        SetMenuDialogStartIndex(idx)
        SetMenuDialogDefaultIndex(idx)
        SetMenuDialogOptions(tattoos_area_names)
    endevent

    event OnMenuAcceptST(int index)
        if index >= 0
			tattoos_area_current = tattoos_area_names[index]
            SetMenuOptionValueST(tattoos_area_names[index])
			SetupTattooSections()
			SetupTattooNames()
		endif
    endevent
endstate

string tattoos_section_current
string[] tattoos_section_names
state TattoosSection
    event OnMenuOpenST()
		if tattoos_section_current == ""
			tattoos_section_current = DOMCore.marks_section
		endif
		int section_idx = tattoos_section_names.Find(tattoos_section_current)
        SetMenuDialogStartIndex(section_idx)
        SetMenuDialogDefaultIndex(section_idx)
        SetMenuDialogOptions(tattoos_section_names)
    endevent

    event OnMenuAcceptST(int index)
        SetMenuOptionValueST(tattoos_section_names[index])
		tattoos_section_current = tattoos_section_names[index]
		SetupTattooNames()
    endevent
endstate

string[] tattoos_item_names
string[] tattoos_file_names
state TattoosName
    event OnMenuOpenST()
        SetMenuDialogStartIndex(tattoos_item_names.Find(DOMCore.marks_name))
        SetMenuDialogDefaultIndex(tattoos_item_names.Find("DOM Forehead"))
        SetMenuDialogOptions(tattoos_item_names)
    endevent

    event OnMenuAcceptST(int index)
		if tattoos_area_current == ""
			tattoos_area_current = DOMCore.marks_area
		endif
		if tattoos_section_current == ""
			tattoos_section_current = DOMCore.marks_section
		endif
        SetMenuOptionValueST(tattoos_item_names[index])
		if DOMCore.marks_name != tattoos_item_names[index]
			DOMCore.marks_area    = tattoos_area_current
			DOMCore.marks_section = tattoos_section_current
			DOMCore.marks_name    = tattoos_item_names[index]
			DOMCore.marks_file    = tattoos_file_names[index]
			LogTrace("Selecting tattoo: "+DOMCore.marks_name+" file: "+DOMCore.marks_file)
		endif
    endevent
endstate

; Initialize
Event OnGameReload()
	LogInfo("OnGameReload RaceMenu open="+UI.IsMenuOpen(DOMCore.RACESEX_MENU))
	wait(1.0)
	if UI.IsMenuOpen(DOMCore.RACESEX_MENU)
		LogInfo("OnGameReload RaceMenu is open - Waiting...")
		while UI.IsMenuOpen(DOMCore.RACESEX_MENU)
			wait(1.0)
		endWhile
		LogInfo("OnGameReload RaceMenu has finished - Continuing")
	endif
	parent.OnGameReload()
	DOMCore.OnGameReload()
EndEvent

string Function GetVersionString()
	int v = DOM_Version.GetValue() as int
	string vstr = v
	LogTrace("GetVersionString() from save "+v)
	return vstr
EndFunction

Event OnConfigOpen()
	LogInfo("OnConfigOpen")
	if DOMPlayerAlias == None
		ReferenceAlias player_alias = DOMCore.GetAliasByName("PlayerAlias") as ReferenceAlias
		DOMPlayerAlias = player_alias as DOM_PlayerAlias
		LogInfo("WARNING: DOMPlayerAlias was not set - trying to recover DOMPlayerAlias="+DOMPlayerAlias)
	endif

	int idx = DOMCore.GetJSONPraisingTypeIndexByName(DOMCore.DefaultPraiseType)
	DOMCore.DefaultPraiseType = DOMCore.g_praisetype_names[idx]
	idx = DOMCore.GetJSONPunishmentTypeIndexByName(DOMCore.DefaultPunishmentType)
	DOMCore.DefaultPunishmentType = DOMCore.g_punishtype_names[idx]

	if default_follow_mode_names.length != 4
		default_follow_mode_names = new string[4]
		default_follow_mode_names[0] = "tight"
		default_follow_mode_names[1] = "close"
		default_follow_mode_names[2] = "near"
		default_follow_mode_names[3] = "long"
	endif
	if default_wait_mode_names.length != 6
		default_wait_mode_names = new string[6]
		default_wait_mode_names[0] = "tight"
		default_wait_mode_names[1] = "close"
		default_wait_mode_names[2] = "near"
		default_wait_mode_names[3] = "long"
		default_wait_mode_names[4] = "far"
		default_wait_mode_names[5] = "very far"
	endif
	if horizontal_anchor_names.length != 3
		horizontal_anchor_names = new string[3]
		horizontal_anchor_names[0] = "Left"
		horizontal_anchor_names[1] = "Center"
		horizontal_anchor_names[2] = "Right"
	endif
	if vertical_anchor_names.length != 3
		vertical_anchor_names = new string[3]
		vertical_anchor_names[0] = "Top"
		vertical_anchor_names[1] = "Center"
		vertical_anchor_names[2] = "Bottom"
	endif
	if tattoos_area_names.length != 4
		tattoos_area_names = new string[4]
		tattoos_area_names[0] = "Body"
		tattoos_area_names[1] = "Face"
		tattoos_area_names[2] = "Hands"
		tattoos_area_names[3] = "Feet"
	endif
	SetupTattooSections()
	SetupTattooNames()

	int slaveCount = DOM02.actorCounter
	int slaverCount = DOM01.actorCounter
	nPages = 16
	if slaveCount > 0
		nPages += 1
	endif
	if slaveCount > 43
		nPages += 1
	endif
	if slaveCount > 81
		nPages += 1
	endif
	if slaverCount > 0
		nPages += 1
	endif
	if DOMCore.nbNearbyFollowers > 0
		nPages += 1
	endif
	if DOMCore.nbNearbyFamily > 0
		nPages += 1
	endif
	
	if nPages <= 16
		pageNames = new String[16]
	elseif nPages == 17
		pageNames = new String[17]
	elseif nPages == 18
		pageNames = new String[18]
	elseif nPages == 19
		pageNames = new String[19]
	elseif nPages == 20
		pageNames = new String[20]
	elseif nPages == 21
		pageNames = new String[21]
	else
		pageNames = new String[22]
	endif
	pageNames[0] = "DOM v"+GetVersionString()
	pageNames[1] = "Capture"
	pageNames[2] = "Player"
	pageNames[3] = "Punishment & Abuse"
	pageNames[4] = "Equipment & Clothes"
	pageNames[5] = "Personality"
	pageNames[6] = "NPCs"
	pageNames[7] = "$Wheel menu"
	pageNames[8] = "$Hotkeys"
	pageNames[9] = "$Animations"
	pageNames[10] = "$Sex & Gender"
	pageNames[11] = "Kinks for females"
	pageNames[12] = "Kinks for males"
	pageNames[13] = "$Notifications"
	pageNames[14] = "$Debug"
	pageNames[15] = "Player's stats"
	
	int iPage = 16
	if slaveCount > 0
		pageNames[iPage] = "Slaves 1-43"
		iPage += 1
	endif
	if slaveCount > 43
		pageNames[iPage] = "Slaves 44-86"
		iPage += 1
	endif
	if slaveCount > 81
		pageNames[iPage] = "Slaves 87-128"
		iPage += 1
	endif
	if slaverCount > 0
		pageNames[iPage] = "$Slaver roster"
		iPage += 1
	endif
	if DOMCore.nbNearbyFollowers > 0
		pageNames[iPage] = "Followers"
		iPage += 1
	endif
	if DOMCore.nbNearbyFamily > 0
		pageNames[iPage] = "Family"
		iPage += 1
	endif
	Pages = pageNames
EndEvent

int nPages = 0
event OnPageReset(string page)
	;LogTrace("OnPageReset page="+page)
	if (page == "")
		LoadCustomContent("DiaryOfMine.dds", 186, 33)
		return
	else
		UnloadCustomContent()
	endif	
	int slaveCount = DOM02.actorCounter
	int slaverCount = DOM01.actorCounter
	nPages = 16
	if slaveCount > 0
		nPages += 1
	endif
	if slaveCount > 43
		nPages += 1
	endif
	if slaveCount > 81
		nPages += 1
	endif
	if slaverCount > 0
		nPages += 1
	endif
	if DOMCore.nbNearbyFollowers > 0
		nPages += 1
	endif
	if DOMCore.nbNearbyFamily > 0
		nPages += 1
	endif
	if PageNames.length == 0 || PageNames.length < nPages
		OnConfigOpen()
		OnPageReset(page)
		return
	endif

	if page == pageNames[0]
		UpdateOptionsPage()
		return
	elseif page == pageNames[1]
		UpdateCapturePage()
		return
	elseif page == pageNames[2]
		UpdatePlayerPage()
		return
	elseif page == pageNames[3]
		UpdateAbusePage()
		return
	elseif page == pageNames[4]
		UpdateEquipmentPage()
		return
	elseif page == pageNames[5]
		UpdatePersonalityPage()
		return
	elseif page == pageNames[6]
		UpdateNPCsPage()
		return
	elseif page == pageNames[7]
		UpdateWheelmenuPage()
		return
	elseif page == pageNames[8]
		UpdateHotkeysPage()
		return
	elseif page == pageNames[9]
		UpdateIdlesPage()
		return
	elseif page == pageNames[10]
		UpdateGenderPage()
		return
	elseif page == pageNames[11]
		UpdateKinksFemalePage()
		return
	elseif page == pageNames[12]
		UpdateKinksMalePage()
		return
	elseif page == pageNames[13]
		UpdateNotificationsPage()
		return
	elseif page == pageNames[14]
		UpdateDebugPage()
		return
	elseif page == pageNames[15]
		UpdatePlayerRosterPage()
		return
	endif
	int iPage = 16
	if slaveCount > 0
		if page == pageNames[iPage]
			UpdateSlaveRosterPage1()
			return
		endif
		iPage += 1
	endif
	if slaveCount > 43
		if page == pageNames[iPage]
			UpdateSlaveRosterPage2()
			return
		endif
		iPage += 1
	endif
	if slaveCount > 81
		if page == pageNames[iPage]
			UpdateSlaveRosterPage3()
			return
		endif
		iPage += 1
	endif
	if slaverCount > 0
		if page == pageNames[iPage]
			UpdateSlaverRosterPage()
			return
		endif
		iPage += 1
	endif
	if DOMCore.nbNearbyFollowers > 0
		if page == pageNames[iPage]
			UpdateFollowerRosterPage()
			return
		endif
		iPage += 1
	endif
	if DOMCore.nbNearbyFamily > 0
		if page == pageNames[iPage]
			UpdateFamilyRosterPage()
			return
		endif
		iPage += 1
	endif
EndEvent

Event OnOptionSelect(Int option)
	;LogTrace("OnOptionSelect page="+CurrentPage)
	If CurrentPage == pageNames[0]
		DoOptionsPage(option)
	elseif CurrentPage == pageNames[1]
		DoCapturePage(option)
	elseif CurrentPage == pageNames[2]
		DoPlayerPage(option)
	elseif CurrentPage == pageNames[3]
		DoAbusePage(option)
	elseif CurrentPage == pageNames[4]
		DoEquipmentPage(option)
	elseif CurrentPage == pageNames[5]
		DoPersonalityPage(option)
	elseif CurrentPage == pageNames[6]
		DoNPCsPage(option)
	elseif CurrentPage == pageNames[7]
		DoWheelPage(option)
	elseif CurrentPage == pageNames[8]
		DoHotkeysPage(option)
	elseif CurrentPage == pageNames[9]
		DoIdlesPage(option)
	elseif CurrentPage == pageNames[10]
		DoGenderPage(option)
	elseif CurrentPage == pageNames[11]
		DoKinksFemalePage(option)
	elseif CurrentPage == pageNames[12]
		DoKinksMalePage(option)
	elseif CurrentPage == pageNames[13]
		DoNotificationsPage(option)
	elseif CurrentPage == pageNames[14]
		DoDebugPage(option)
	else
		DoActorRosterPage(option)
	endif
EndEvent

string sort_criteria = ""
Int[] slave_OID
Int currentActor_OID = -1
Function UpdateSlaveRosterPage1()
	;LogTrace("UpdateSlaveRosterPage1")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int slaveCount = DOM02.actorCounter
	if slave_OID.length != 43
		slave_OID = new Int[43]
	endif
	int slaveList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("First 43 slaves")
	else
		AddHeaderOption("First 43 slaves in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i < slaveCount) && (i < 43) && (slaveList < slave_OID.length)
		DOM_Actor sl_alias = DOM02.GetActorByIndex(i)
		slave_OID[i] = AddTextOption(i+1 + ": " + sl_alias.GetName(), sl_alias.GetTitle())
		if currentActor_OID == slave_OID[i]
			selected_info = i
		endif
		;LogTrace("UpdateSlaveRosterPage: OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
		slaveList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateActorInfoPage(selected_info,true,false) ; slave not player
	endif
EndFunction

Function UpdateSlaveRosterPage2()
	;LogTrace("UpdateSlaveRosterPage2")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int slaveCount = DOM02.actorCounter
	if slave_OID.length != 43
		slave_OID = new Int[43]
	endif
	int slaveList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("Slaves 44 to 86")
	else
		AddHeaderOption("Slaves 44 to 86 in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i+43 < slaveCount) && (i < 43) && (slaveList < slave_OID.length)
		DOM_Actor sl_alias = DOM02.GetActorByIndex(i+43)
		slave_OID[i] = AddTextOption(i+1 + ": " + sl_alias.GetName(), sl_alias.GetTitle())
		if currentActor_OID == slave_OID[i]
			selected_info = i+43
		endif
		;LogTrace("UpdateSlaveRosterPage: OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
		slaveList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateActorInfoPage(selected_info,true,false) ; slave, not player
	endif
EndFunction

Function UpdateSlaveRosterPage3()
	;LogTrace("UpdateSlaveRosterPage3")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int slaveCount = DOM02.actorCounter
	if slave_OID.length != 43
		slave_OID = new Int[43]
	endif
	int slaveList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("Slaves 87 to 128")
	else
		AddHeaderOption("Slaves 87 to 128 in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i+86 < slaveCount) && (i < 43) && (slaveList < slave_OID.length)
		DOM_Actor sl_alias = DOM02.GetActorByIndex(i+86)
		slave_OID[i] = AddTextOption(i+1 + ": " + sl_alias.GetName(), sl_alias.GetTitle())
		if currentActor_OID == slave_OID[i]
			selected_info = i+86
		endif
		;LogTrace("UpdateSlaveRosterPage: OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
		slaveList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateActorInfoPage(selected_info,true,false) ; slave, not player
	endif
EndFunction

Int[] slaver_OID
Function UpdateSlaverRosterPage()
	;LogTrace("UpdateSlaverRosterPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int slaverCount = DOM01.actorCounter
	if slaver_OID.length < 32
		slaver_OID = new Int[32]
	endif
	int slaverList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("$All slavers")
	else
		AddHeaderOption("$All slaves in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i < slaverCount) && (slaverList < slaver_OID.length)
		DOM_Actor sl_alias = DOM01.GetActorByIndex(i)
		slaver_OID[i] = AddTextOption(i+1 + ": " + sl_alias.GetName(), sl_alias.GetTitle())
		if currentActor_OID == slaver_OID[i]
			selected_info = i
		endif
		slaverList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateActorInfoPage(selected_info,false,false) ; slaver, not player
	endif
EndFunction

Function UpdatePlayerRosterPage()
	;LogTrace("UpdateSlaverRosterPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int slaverCount = 1
	if slaver_OID.length < 32
		slaver_OID = new Int[32]
	endif
	int slaverList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	AddHeaderOption("Player")

	if DOMPlayerAlias == None
		ReferenceAlias player_alias = GetAliasByName("PlayerAlias") as ReferenceAlias
		DOMPlayerAlias = player_alias as DOM_PlayerAlias
		LogTrace("UpdatePlayerRosterPage WARNING: DOMPlayerAlias was not set - trying to recover DOMPlayerAlias="+DOMPlayerAlias)
	endif

	int i = 0
	int selected_info = -1
	while (i < slaverCount) && (slaverList < slaver_OID.length)
		DOM_Actor sl_alias = DOMPlayerAlias.actor_alias
		if sl_alias == None
			LogTrace("UpdateSlaverRosterPage player actor not found!")
			DOMPlayerAlias.ResetInitializePlayer()
			DOMPlayerAlias.InitializePlayer()
			sl_alias = DOMPlayerAlias.actor_alias
		endif
		if sl_alias != None
			slaver_OID[i] = AddTextOption(i+1 + ": " + sl_alias.GetName(), sl_alias.GetTitle())
			if currentActor_OID == slaver_OID[i]
				selected_info = i
			endif
		endif
		slaverList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateActorInfoPage(selected_info,false,true) ; slaver, player
	endif
EndFunction

Function UpdateFollowerRosterPage()
	;LogTrace("UpdateFollowerRosterPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int actorCount = DOMCore.nbNearbyFollowers
	if slave_OID.length != 43
		slave_OID = new Int[43]
	endif
	int actorList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("First 43 followers")
	else
		AddHeaderOption("First 43 followers in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i < actorCount) && (i < 43) && (actorList < slave_OID.length)
		Actor akRef = DOMCore.nearby_followers[i]
		if akRef != None
			slave_OID[i] = AddTextOption(i+1 + ": " + akRef.GetDisplayName(), "")
			if currentActor_OID == slave_OID[i]
				selected_info = i
			endif
		endif
		;LogTrace("UpdateFollowerRosterPage: OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
		actorList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateNPCInfoPage(selected_info,true)
	endif
EndFunction

Function UpdateFamilyRosterPage()
	;LogTrace("UpdateFamilyRosterPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int actorCount = DOMCore.nbNearbyFamily
	if slave_OID.length != 43
		slave_OID = new Int[43]
	endif
	int actorList = 0

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	if sort_criteria == ""
		AddHeaderOption("First 43 family members")
	else
		AddHeaderOption("First 43 family members in {"+sort_criteria+"}")
	endif

	int i = 0
	int selected_info = -1
	while (i < actorCount) && (i < 43) && (actorList < slave_OID.length)
		Actor akRef = DOMCore.nearby_family[i]
		if akRef != None
			slave_OID[i] = AddTextOption(i+1 + ": " + akRef.GetDisplayName(), "")
			if currentActor_OID == slave_OID[i]
				selected_info = i
			endif
		endif
		;LogTrace("UpdateFamilyRosterPage: OID="+slave_OID[i]+" current="+currentActor_OID+" selected="+selected_info)
		actorList += 1
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	if selected_info != -1
		UpdateNPCInfoPage(selected_info,true)
	endif
EndFunction

Function UpdateActorInfoPage(int idx, bool is_slave, bool is_player)
	if is_player
		displayedActor = DOMPlayerAlias.actor_alias
		if displayedActor == None
			LogTrace("UpdateActorInfoPage player actor not found!")
			DOMPlayerAlias.ResetInitializePlayer()
			DOMPlayerAlias.InitializePlayer()
			displayedActor = DOMPlayerAlias.actor_alias
		endif
	elseif is_slave
		displayedActor = DOM02.GetActorByIndex(idx)
	else
		displayedActor = DOM01.GetActorByIndex(idx)
	endif
	if displayedActor == None
		return
	endif
	displayedNPC = None
	DOM_Mind akMind = displayedActor.mind
	Actor akRef = displayedActor.akRef
	
	actorName_OID = AddInputOption("$Name: ",displayedActor.GetName())
	if displayedActor.getTitle() == ""
		actorTitle_OID = AddInputOption("$Title: ","$<Press to set>")
	else
		actorTitle_OID = AddInputOption("$Title: ",displayedActor.GetTitle())
	endif
	if akRef.GetLeveledActorBase().IsUnique()
		String before_name = DOMCore.GetPreviousOccupation(akRef)
		if before_name != displayedActor.GetName()
			actorPrevious_OID = AddTextOption("Before: ",before_name+" [Unique]", OPTION_FLAG_DISABLED)
		else
			actorPrevious_OID = AddTextOption("Before: ","[Unique]", OPTION_FLAG_DISABLED)
		endif
	else
		actorPrevious_OID = AddTextOption("Before: ",DOMCore.GetPreviousOccupation(akRef), OPTION_FLAG_DISABLED)
	endif
	string str_gender = displayedActor.GetGenderbyString()
	actorGender_OID = AddInputOption("$Gender: ", str_gender)
	string race_name = akRef.GetLeveledActorBase().GetRace().GetName()
	actorRace_OID = AddTextOption("Race: ",race_name, OPTION_FLAG_DISABLED)
	if is_slave
		string status = akMind.GetTrainingStatusName()
		if status != "enslaved"
			status += " slave"
		endif
		AddTextOption("$Status: ", status, OPTION_FLAG_DISABLED)
	elseif akRef.IsInFaction(DOMCore.DOMPlayerSlaverFaction)
		AddTextOption("$Status: ", "slaver", OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Status: ", "free person", OPTION_FLAG_DISABLED)
	endif
	AddTextOption("$Mood: ", akMind.mood, OPTION_FLAG_DISABLED)
	AddTextOption("$Location: ", GetLocationName(akRef), OPTION_FLAG_DISABLED)
	if akRef.GetParentCell() ==  PlayerRef.GetParentCell() 
		AddTextOption("Position: ", GetPositionString(akRef), OPTION_FLAG_DISABLED)
	endif
	
	if displayedActor.behaviour == "follow_player"
		int rank = akRef.GetFactionRank(DOMCore.DOMFollowMode)
		if rank == 0
			AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle()+" tight", OPTION_FLAG_DISABLED)
		elseif rank == 1
			AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle()+" close", OPTION_FLAG_DISABLED)
		elseif rank == 3
			AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle()+" far", OPTION_FLAG_DISABLED)
		else
			AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle()+" short", OPTION_FLAG_DISABLED)
		endif
	else
		AddTextOption("$Occupation: ", displayedActor.GetBehaviourTitle(), OPTION_FLAG_DISABLED)
	endif
	ObjectReference target = displayedActor.target.GetRef()
	if target != None
		string target_name = target.GetDisplayName()
		if target_name == ""
			target_name = target.GetName()
		endif
		if target_name == ""
			target_name = "No Name"
		endif
		AddTextOption("Target: ", target_name, OPTION_FLAG_DISABLED)
	endif

	string the_pose =  displayedActor.GetPose()
	if the_pose != ""
		actorPose_OID = AddInputOption("$Pose: ", the_pose)
		string the_struggle_pose =  displayedActor.GetStrugglePose()
		if the_struggle_pose != ""
			actorStrugglePose_OID = AddInputOption("$Struggle pose: ", the_struggle_pose)
		else
			actorStrugglePose_OID = -1
		endif
	else
		actorPose_OID = -1
	endif

	actorFightForPlayer_OID = AddToggleOption("Fight for me",   akRef.IsInFaction(DOMCore.DOMShouldFightForPlayer))
	actorHoldWeapons_OID    = AddToggleOption("Hold weapons",   akRef.IsInFaction(DOMCore.DOMShouldHoldWeapons))
	actorWearArmor_OID      = AddToggleOption("Wear armor",     akRef.IsInFaction(DOMCore.DOMShouldWearArmor))
	actorBeNaked_OID        = AddToggleOption("Be naked",       akRef.IsInFaction(DOMCore.DOMShouldBeNaked))
	actorBeRespectful_OID   = AddToggleOption("Be respectful",  akRef.IsInFaction(DOMCore.DOMShouldBeRespectful))
	actorBeSilent_OID       = AddToggleOption("Be silent",      akRef.IsInFaction(DOMCore.DOMShouldBeSilent))
	actorNoOrgasm_OID       = AddToggleOption("No orgasm",      akRef.IsInFaction(DOMCore.DOMShouldBeNoOrgasm))
	actorWalkOnFour_OID     = AddToggleOption("Walk on 4",      akRef.IsInFaction(DOMCore.DOMShouldWalkOnFour))

	if !is_player
		if akRef.IsEssential()
			actorEssential_OID = AddTextOption("Remove essential flag", "$Click")
		else
			actorEssential_OID = AddTextOption("Set essential flag", "$Click")
		endif
		if akRef.IsInfaction(DOMCore.DLC1ThrallFaction)
			actorThrall_OID = AddTextOption("Remove thrall faction", "$Click")
		else
			actorThrall_OID = AddTextOption("Set thrall faction", "$Click")
		endif
		if displayedActor.the_bag_iam_in != None
			actorSummonBag_OID = AddTextOption("$Summon burlap sack", "$Click")
		else
			actorSummon_OID = AddTextOption("$Summon to player", "$Click")
		endif
		actorRelease_OID = AddTextOption("Release actor from DOM", "$Click")
	endif
	actorResetDiary_OID = AddTextOption("Reset diary text", "$Click")
	actorFixTats_OID = AddTextOption("$Fix SlaveTats", "$Click")
	actorFixme_OID = AddTextOption("$Fix unresponsive or invisible actor", "$Click")
	
	if akMind.love_desire <= 0.0
		AddTextOption("$Submission: ", akMind.submission, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love desire: ", akMind.love_desire, OPTION_FLAG_DISABLED)
	endif
	if akMind.loyal_worship <= 0.0
		AddTextOption("$Fear training: ", akMind.fear_training, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal worship: ", akMind.loyal_worship, OPTION_FLAG_DISABLED)
	endif
	if akMind.love_fascination <= 0.0
		AddTextOption("$Humiliation: ", akMind.humiliation, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love fascination: ", akMind.love_fascination, OPTION_FLAG_DISABLED)
	endif
	if akMind.loyal_absolution <= 0.0
		AddTextOption("$Anger training: ", akMind.anger_training, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal absolution: ", akMind.loyal_absolution, OPTION_FLAG_DISABLED)
	endif
	if akMind.loyal_devotion <= 0.0
		AddTextOption("$Resignation: ", akMind.resignation, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal devotion: ", akMind.loyal_devotion, OPTION_FLAG_DISABLED)
	endif
	if akMind.love_admiration <= 0.0
		AddTextOption("$Respect training: ", akMind.respect_training, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love admiration: ", akMind.love_admiration, OPTION_FLAG_DISABLED)
	endif
	AddTextOption("$Sex training: ", akMind.sex_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Vaginal training: ", akMind.vaginal_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Oral training: ", akMind.oral_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Anal training: ", akMind.anal_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Combat training: ", akMind.combat_training, OPTION_FLAG_DISABLED)
	AddTextOption("$Pose training: ", akMind.pose_training, OPTION_FLAG_DISABLED)
	if ((displayedActor.actorSex)%2) == 0
		AddTextOption("$Servant training: ", akMind.house_training, OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Maid training: ", akMind.house_training, OPTION_FLAG_DISABLED)
	endif
	AddTextOption("Work training: ", akMind.work_training, OPTION_FLAG_DISABLED)
	AddTextOption("Enforcer skill: ", akMind.skill_enforcer, OPTION_FLAG_DISABLED)
	AddTextOption("Predator skill: ", akMind.skill_predator, OPTION_FLAG_DISABLED)
	AddTextOption("Depraver skill: ", akMind.skill_depraver, OPTION_FLAG_DISABLED)
	AddTextOption("Persuader skill: ", akMind.skill_persuader, OPTION_FLAG_DISABLED)
	AddTextOption("Slaver skill: ", akMind.skill_slaver, OPTION_FLAG_DISABLED)
	AddTextOption("Deceiver skill: ", akMind.skill_deceiver, OPTION_FLAG_DISABLED)
	AddTextOption("Dirtiness: ", displayedActor.dirty_level, OPTION_FLAG_DISABLED)
	AddTextOption("Drunk level: ", akMind.GetDrunkLevel(), OPTION_FLAG_DISABLED)
	AddTextOption("Blood alcohol: ", akMind.GetBloodAlcohol(), OPTION_FLAG_DISABLED)
	
	;actorRemoveSpells_OID = AddTextOption("Remove actor learnt spells", "$Click")
	;actorRemoveBaseSpells_OID = AddTextOption("Remove actor base spells", "$Click")
	actorWrite_OID = AddTextOption("Write JSON file", "$Click")
	actorRead_OID = AddTextOption("Read JSON file", "$Click")
EndFunction

Function UpdateNPCInfoPage(int idx, bool is_follower)
	if is_follower
		displayedNPC = DOMCore.nearby_followers[idx]
	else
		displayedNPC = DOMCore.nearby_family[idx]
	endif
	if displayedNPC == None
		return
	endif
	displayedActor = None
	Actor akRef = displayedNPC
	
	actorName_OID = AddInputOption("$Name: ",akRef.GetDisplayName())
	if akRef.GetLeveledActorBase().IsUnique()
		String before_name = DOMCore.GetPreviousOccupation(akRef)
		if before_name != akRef.GetDisplayName()
			actorPrevious_OID = AddTextOption("Before: ",before_name+" [Unique]", OPTION_FLAG_DISABLED)
		else
			actorPrevious_OID = AddTextOption("Before: ","[Unique]", OPTION_FLAG_DISABLED)
		endif
	else
		actorPrevious_OID = AddTextOption("Before: ",DOMCore.GetPreviousOccupation(akRef), OPTION_FLAG_DISABLED)
	endif
	string str_gender = "other"
	int actorSex = akRef.GetLeveledActorBase().GetSex()
	if actorSex == 0
		str_gender = "male"
	elseif actorSex == 1
		str_gender = "female"
	endif
	actorGender_OID = AddTextOption("$Gender: ", str_gender, OPTION_FLAG_DISABLED)
	string race_name = akRef.GetLeveledActorBase().GetRace().GetName()
	actorRace_OID = AddTextOption("Race: ",race_name, OPTION_FLAG_DISABLED)
	if akRef.IsInFaction(DOMCore.DOMPlayerSlaveFaction)
		AddTextOption("$Status: ", "player's slave", OPTION_FLAG_DISABLED)
	elseif akRef.IsInFaction(DOMCore.DOMNotPlayerSlaveFaction)
		AddTextOption("$Status: ", "slave", OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Status: ", "free person", OPTION_FLAG_DISABLED)
	endif
	AddTextOption("$Mood: ", DOMCore.GetMoodMessage(akRef), OPTION_FLAG_DISABLED)
	AddTextOption("$Location: ", GetLocationName(akRef), OPTION_FLAG_DISABLED)
	if akRef.GetParentCell() ==  PlayerRef.GetParentCell() 
		AddTextOption("Position: ", GetPositionString(akRef), OPTION_FLAG_DISABLED)
	endif

	if akRef.GetCurrentPackage() == DOMCore.DOMFamilyForceGreet
		AddTextOption("$Occupation: ", "Force greet", OPTION_FLAG_DISABLED)
	elseif DOMCore.IsFollower(akRef)
		AddTextOption("$Occupation: ", "Following", OPTION_FLAG_DISABLED)
	elseif DOMCore.IsWaitingForPlayer(akRef)
		AddTextOption("$Occupation: ", "Waiting", OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Occupation: ", "Unknown", OPTION_FLAG_DISABLED)
	endif
	
	actorFightForPlayer_OID = AddToggleOption("Fight for me",   akRef.IsInFaction(DOMCore.DOMShouldFightForPlayer))
	actorHoldWeapons_OID    = AddToggleOption("Hold weapons",   akRef.IsInFaction(DOMCore.DOMShouldHoldWeapons))
	actorWearArmor_OID     = AddToggleOption("Wear armor",     akRef.IsInFaction(DOMCore.DOMShouldWearArmor))
	actorBeNaked_OID        = AddToggleOption("Be naked",       akRef.IsInFaction(DOMCore.DOMShouldBeNaked))
	actorBeRespectful_OID   = AddToggleOption("Be respectful",  akRef.IsInFaction(DOMCore.DOMShouldBeRespectful))
	actorBeSilent_OID       = AddToggleOption("Be silent",      akRef.IsInFaction(DOMCore.DOMShouldBeSilent))
	actorNoOrgasm_OID       = AddToggleOption("No orgasm",      akRef.IsInFaction(DOMCore.DOMShouldBeNoOrgasm))
	actorWalkOnFour_OID     = AddToggleOption("Walk on 4",      akRef.IsInFaction(DOMCore.DOMShouldWalkOnFour))

	if akRef.IsEssential()
		actorEssential_OID = AddTextOption("Remove essential flag", "$Click")
	else
		actorEssential_OID = AddTextOption("Set essential flag", "$Click")
	endif
	if akRef.IsInfaction(DOMCore.DLC1ThrallFaction)
		actorThrall_OID = AddTextOption("Remove thrall faction", "$Click")
	else
		actorThrall_OID = AddTextOption("Set thrall faction", "$Click")
	endif
	if akRef.IsInFaction(DOMCore.DOMActionInContainer)
		actorSummonBag_OID = AddTextOption("In burlap sack", "No summon", OPTION_FLAG_DISABLED)
	else
		actorSummon_OID = AddTextOption("$Summon to player", "$Click")
	endif
	actorFixTats_OID = AddTextOption("$Fix SlaveTats", "$Click")
	actorFixme_OID = AddTextOption("$Fix unresponsive or invisible actor", "$Click")

	if akRef.GetFactionRank(DOMCore.DOMLoveDesire) <= 0
		AddTextOption("$Submission: ", akRef.GetFactionRank(DOMCore.DOMTrainSubmission), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love desire: ", akRef.GetFactionRank(DOMCore.DOMLoveDesire), OPTION_FLAG_DISABLED)
	endif
	if akRef.GetFactionRank(DOMCore.DOMLoyalWorship) <= 0
		AddTextOption("$Fear training: ", akRef.GetFactionRank(DOMCore.DOMTrainFear), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal worship: ", akRef.GetFactionRank(DOMCore.DOMLoyalWorship), OPTION_FLAG_DISABLED)
	endif
	if akRef.GetFactionRank(DOMCore.DOMLoveFascination) <= 0
		AddTextOption("$Humiliation: ", akRef.GetFactionRank(DOMCore.DOMTrainHumiliation), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love fascination: ", akRef.GetFactionRank(DOMCore.DOMLoveFascination), OPTION_FLAG_DISABLED)
	endif
	if akRef.GetFactionRank(DOMCore.DOMLoyalAbsolution) <= 0
		AddTextOption("$Anger training: ", akRef.GetFactionRank(DOMCore.DOMTrainAnger), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal absolution: ", akRef.GetFactionRank(DOMCore.DOMLoyalAbsolution), OPTION_FLAG_DISABLED)
	endif
	if akRef.GetFactionRank(DOMCore.DOMLoyalDevotion) <= 0
		AddTextOption("$Resignation: ", akRef.GetFactionRank(DOMCore.DOMTrainResignation), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Loyal devotion: ", akRef.GetFactionRank(DOMCore.DOMLoyalDevotion), OPTION_FLAG_DISABLED)
	endif
	if akRef.GetFactionRank(DOMCore.DOMLoveAdmiration) <= 0
		AddTextOption("$Respect training: ", akRef.GetFactionRank(DOMCore.DOMTrainRespect), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Love admiration: ", akRef.GetFactionRank(DOMCore.DOMLoveAdmiration), OPTION_FLAG_DISABLED)
	endif
	AddTextOption("$Sex training: ", akRef.GetFactionRank(DOMCore.DOMTrainSex), OPTION_FLAG_DISABLED)
	AddTextOption("$Vaginal training: ", akRef.GetFactionRank(DOMCore.DOMTrainVaginal), OPTION_FLAG_DISABLED)
	AddTextOption("$Oral training: ", akRef.GetFactionRank(DOMCore.DOMTrainOral), OPTION_FLAG_DISABLED)
	AddTextOption("$Anal training: ", akRef.GetFactionRank(DOMCore.DOMTrainAnal), OPTION_FLAG_DISABLED)
	AddTextOption("$Combat training: ", akRef.GetFactionRank(DOMCore.DOMTrainCombat), OPTION_FLAG_DISABLED)
	AddTextOption("$Pose training: ", akRef.GetFactionRank(DOMCore.DOMTrainPose), OPTION_FLAG_DISABLED)
	if ((actorSex)%2) == 0
		AddTextOption("$Servant training: ", akRef.GetFactionRank(DOMCore.DOMTrainHouse), OPTION_FLAG_DISABLED)
	else
		AddTextOption("$Maid training: ", akRef.GetFactionRank(DOMCore.DOMTrainHouse), OPTION_FLAG_DISABLED)
	endif
	AddTextOption("Work training: ", akRef.GetFactionRank(DOMCore.DOMTrainWorking), OPTION_FLAG_DISABLED)
	AddTextOption("Enforcer skill: ", akRef.GetFactionRank(DOMCore.DOMSkillEnforcer), OPTION_FLAG_DISABLED)
	AddTextOption("Predator skill: ", akRef.GetFactionRank(DOMCore.DOMSkillPredator), OPTION_FLAG_DISABLED)
	AddTextOption("Depraver skill: ", akRef.GetFactionRank(DOMCore.DOMSkillDepraver), OPTION_FLAG_DISABLED)
	AddTextOption("Persuader skill: ", akRef.GetFactionRank(DOMCore.DOMSkillPersuader), OPTION_FLAG_DISABLED)
	AddTextOption("Slaver skill: ", akRef.GetFactionRank(DOMCore.DOMSkillSlaver), OPTION_FLAG_DISABLED)
	AddTextOption("Deceiver skill: ", akRef.GetFactionRank(DOMCore.DOMSkillDeceiver), OPTION_FLAG_DISABLED)
	AddTextOption("Dirtiness: ", akRef.GetFactionRank(DOMCore.DOMDirtiness), OPTION_FLAG_DISABLED)
	AddTextOption("Drunk level: ", akRef.GetFactionRank(DOMCore.DOMDrunkLevel), OPTION_FLAG_DISABLED)

	;actorRemoveSpells_OID = AddTextOption("Remove actor learnt spells", "$Click")
	;actorRemoveBaseSpells_OID = AddTextOption("Remove actor base spells", "$Click")
	actorWrite_OID = AddTextOption("Write JSON file", "$Click")
	actorRead_OID = AddTextOption("Read JSON file", "$Click")
EndFunction

float Function getAnglePlayer(Actor akRef)
	float angle = PlayerRef.GetAngleZ() + PlayerRef.GetHeadingAngle(akRef)
	if angle < 0.0
		while angle < 0.0
			angle = 360.0 - angle
		endWhile
		return angle
	endif
	while angle > 360.0
		angle = angle - 360.0
	endWhile
	return angle
EndFunction

string Function GetDirectionString(Actor akRef)
	float angle = getAnglePlayer(akRef)
	
	if angle <= 22.5
		return "to your north."
	elseif angle <= 67.5
		return "to your northeast."
	elseif angle <= 112.5
		return "to your east."
	elseif angle <= 157.5
		return "to your southeast"
	elseif angle <= 202.5
		return "to your south."
	elseif angle <= 247.5
		return "to your southwest."
	elseif angle <= 292.5
		return "to your west."
	elseif angle <= 337.5
		return "to your northwest."
	elseif angle <= 360.0
		return "to your north."
	endif
	return "in an unknown direction."
EndFunction

string Function GetDistanceString(Actor akRef)
	string units = " metres"
	float distance = akRef.GetDistance(PlayerRef) * 0.01428 ; 1000.0 units = 14.28 meters
	if distance > 1000.0
		distance = distance / 1000.0
		units = " kilometres"
	endif
	return (distance as int) + units
EndFunction

string Function GetPositionString(Actor akRef)
	string dirStr = GetDirectionString(akRef)
	string farStr = GetDistanceString(akRef)
	return farStr+" "+dirStr
EndFunction

Function UpdateGenderPage()
	;LogTrace("UpdateGenderPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	;AddHeaderOption("$Gender Choices")
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	
	AddHeaderOption("Random topics")
	oppositeSexToggle_OID = AddToggleOption("$Opposite sex topics",  DOMCore.oppositeSexToggle)
	sameSexToggle_OID = AddToggleOption("$Same sex topics",  DOMCore.sameSexToggle)

	AddHeaderOption("Tears and blush")

	blushFToggle_OID = AddToggleOption("Blush for females",  DOMCore.blushFToggle)
	tearsFToggle_OID = AddToggleOption("$Tears for females",  DOMCore.tearsFToggle)
	masctFToggle_OID = AddToggleOption("$Smudged mascara for females",  DOMCore.masctFToggle)
	blushMToggle_OID = AddToggleOption("Blush for males",  DOMCore.blushMToggle)
	tearsMToggle_OID = AddToggleOption("$Tears for males",  DOMCore.tearsMToggle)
	masctMToggle_OID = AddToggleOption("$Smudged mascara for males",  DOMCore.masctMToggle)
	cryingPunishmentToggle_OID = AddToggleOption("Punish for crying",  DOMCore.cryingPunishmentToggle)
	cryingPraiseToggle_OID     = AddToggleOption("Praise for crying",  DOMCore.cryingPraiseToggle)

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("$Virginity")
	virginOToggle_OID = AddToggleOption("$Allow oral virginity",  DOMCore.virginOToggle)
	virginAToggle_OID = AddToggleOption("$Allow anal virginity",  DOMCore.virginAToggle)
	virginVToggle_OID = AddToggleOption("$Allow vaginal virginity",  DOMCore.virginVToggle)
	virginSToggle_OID = AddToggleOption("$Allow same sex virginity",  DOMCore.virginSToggle)
	virginGToggle_OID = AddToggleOption("Allow sex party virginity",  DOMCore.virginGToggle)

	AddHeaderOption("$Sexlab settings")
	startSexlabPreferablyPlayer_OID = AddToggleOption("Use Sexlab before OStim for Player",  DOMSexlab.startSexlabPreferablyPlayer)
	startSexlabPreferablyNPC_OID = AddToggleOption("Use Sexlab before OStim for NPCs",  DOMSexlab.startSexlabPreferablyNPC)
	startSexlabPreferablyDOM_OID = AddToggleOption("Use Sexlab before OStim for DOM",  DOMSexlab.startSexlabPreferablyDOM)
	separateOrgasmToggle_OID = AddToggleOption("$Use separate orgasm",  DOMSexlab.separateOrgasmToggle)
	alwaysAggressiveToggle_OID = AddToggleOption("$Always aggressive sex",  DOMSexlab.alwaysAggressiveToggle)
	alwaysGentleToggle_OID = AddToggleOption("$Non aggressive punishment sex",  DOMSexlab.alwaysGentleToggle)
	useAggressiveTag_OID = AddToggleOption("Use aggressive tag for punishment sex",  DOMSexlab.useAggressiveTag)
EndFunction

Int[] kinksFemale_OID
Function UpdateKinksFemalePage()
	;LogTrace("UpdateKinksFemalePage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int kinksCountHalf = 63
	if kinksFemale_OID.length < 127
		kinksFemale_OID = new Int[127]
	endif

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	int i = 0
	while i < kinksCountHalf
		int idx = i + 1
		string kinks_txt = DOMCore.GetJSONKinkReasonNameByIndex(idx,1) ; use actorSex == 1 for females
		if kinks_txt != "unknown kink"
			kinksFemale_OID[i] = AddToggleOption(kinks_txt,  DOMCore.kinksFilterFemale[idx])
		endif
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	kinksCountHalf = kinksCountHalf * 2
	while i < kinksCountHalf
		int idx = i + 1
		string kinks_txt = DOMCore.GetJSONKinkReasonNameByIndex(idx,1) ; use actorSex == 1 for females
		if kinks_txt != "unknown kink"
			kinksFemale_OID[i] = AddToggleOption(kinks_txt,  DOMCore.kinksFilterFemale[idx])
		endif
		i += 1
	endWhile
EndFunction

Int[] kinksMale_OID
Function UpdateKinksMalePage()
	;LogTrace("UpdateKinksMalePage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	int kinksCountHalf = 63
	if kinksMale_OID.length < 127
		kinksMale_OID = new Int[127]
	endif

    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	int i = 0
	while i < kinksCountHalf
		int idx = i + 1
		string kinks_txt = DOMCore.GetJSONKinkReasonNameByIndex(idx,0) ; use actorSex == 0 for males
		if kinks_txt != "unknown kink"
			kinksMale_OID[i] = AddToggleOption(kinks_txt,  DOMCore.kinksFilterMale[idx])
		endif
		i += 1
	endWhile

    ;===============================================================================
	SetCursorPosition(1) ; Continue with right column
	kinksCountHalf = kinksCountHalf * 2
	while i < kinksCountHalf
		int idx = i + 1
		string kinks_txt = DOMCore.GetJSONKinkReasonNameByIndex(idx,0) ; use actorSex == 0 for males
		if kinks_txt != "unknown kink"
			kinksMale_OID[i] = AddToggleOption(kinks_txt,  DOMCore.kinksFilterMale[idx])
		endif
		i += 1
	endWhile
EndFunction

phhshStorageFunctions HSHQuest = None

Function UpdateCapturePage()
	;LogTrace("UpdateCapturePage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	;AddHeaderOption("Toggles")
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	
	AddHeaderOption("Combat")
	AddSliderOptionST("PUN_health_percentage", "Health percentage", DOM_HealthPercentage.GetValue()*100.0)
	AddSliderOptionST("PUN_health_value", "Health value", DOM_HealthMinValue.GetValue())

	AddHeaderOption("$Abduction weapons")
	weaponsFToggle_OID = AddToggleOption("$Weapons capture females",  DOMCore.weaponsFToggle)
	weaponsMToggle_OID = AddToggleOption("$Weapons capture males",  DOMCore.weaponsMToggle)
	weaponsOToggle_OID = AddToggleOption("Weapons capture orcs",  DOMCore.weaponsOToggle)
	weaponsBToggle_OID = AddToggleOption("Weapons capture beasts",  DOMCore.weaponsBToggle)

	AddHeaderOption("Special actors")
	forbidAnimalCapture_OID = AddToggleOption("Capture animals",  !DOMKeys.forbidAnimalCapture)
	forbidCreatureCapture_OID = AddToggleOption("Capture creatures",  !DOMKeys.forbidCreatureCapture)
	forbidUndeadCapture_OID = AddToggleOption("Capture undead",  !DOMKeys.forbidUndeadCapture)

	AddHeaderOption("Body morphs")
	setTransferNodeToggle_OID = AddToggleOption("Transfer body morphs to clone",  DOMCore.setTransferNodeToggle)
	setOBodyPresetToggleF_OID = AddToggleOption("Transfer OBody preset to female clone",  DOMCore.setOBodyPresetToggleF)
	setOBodyPresetToggleM_OID = AddToggleOption("Transfer OBody preset to male clone",  DOMCore.setOBodyPresetToggleM)

	AddHeaderOption("Outfit on actor capture")

	cleanUniqueOutfit_OID = AddToggleOption("$Clear unique NPC outfit",  DOMEquip.cleanUniqueOutfit)
	cleanSpawnOutfit_OID = AddToggleOption("$Clear spawned NPC outfit",  DOMEquip.cleanSpawnOutfit)
	cleanSlaverOutfit_OID = AddToggleOption("$Clear slaver NPC outfit",  DOMEquip.cleanSlaverOutfit)

	AddHeaderOption("Outfit on actor release")
	restoreOutfitUnique_OID = AddToggleOption("$Restore unique NPC outfit",  DOMEquip.restoreOutfitUnique)
	restoreOutfitSpawn_OID = AddToggleOption("$Restore spawned NPC outfit",  DOMEquip.restoreOutfitSpawn)
	restoreOutfitAlways_OID = AddToggleOption("Always restore outfit",  DOMEquip.restoreOutfitAlways)

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("Animation")
	sendDOMCaptureEvent_OID = AddToggleOption("Use events for capture animations",  DOMCore.sendDOMCaptureEvent)

	AddHeaderOption("$Cloning")
	renameToggle_OID = AddToggleOption("Rename cloned NPC",  DOMCore.renameToggle)
	cloneUniqueMode_OID = AddToggleOption("$Clone unique NPC",  DOMCore.cloneUniqueMode)
	cloneSpawnMode_OID = AddToggleOption("$Clone spawned NPC",  DOMCore.cloneSpawnMode)

	AddHeaderOption("Cleaning")
	cleanCrimeFaction_OID = AddToggleOption("$Clean crime faction at capture",  DOMCore.cleanCrimeFaction)
	cleanFactionUnique_OID = AddToggleOption("$Clean all unique NPC factions",  DOMCore.cleanFactionUnique)
	cleanFactionSpawn_OID = AddToggleOption("$Clean all spawned NPC factions",  DOMCore.cleanFactionSpawn)
		
	AddHeaderOption("Default values and flags")
	writeJSONRelease_OID = AddToggleOption("Write JSON at release",  DOMGenerator.writeJSONRelease)
	writeJSONTransfer_OID = AddToggleOption("Write JSON during transfer",  DOMGenerator.writeJSONTransfer)
	trainSexlabValuesToggle_OID = AddToggleOption("Train sex stats with SL values",  DOMCore.trainSexlabValuesToggle)
	readSexlabValuesToggle_OID = AddToggleOption("Set sex stats to SL values",  DOMCore.readSexlabValuesToggle)
	VampireCattleToggle_OID = AddToggleOption("Set vampire cattle status",  DOMCore.VampireCattleToggle)
	RemoveEssentialToggle_OID = AddToggleOption("Remove essential flag",  DOMCore.RemoveEssentialToggle)
	SetEssentialToggle_OID = AddToggleOption("Set essential flag",  DOMCore.SetEssentialToggle)
	AddMenuOptionST("DefaultFollowMode", "follow distance", default_follow_mode_names[DOMCore.DefaultFollowMode])
	AddMenuOptionST("DefaultWaitMode", "wait distance", default_wait_mode_names[DOMCore.DefaultWaitMode])

EndFunction

Function UpdateWheelmenuPage()
	;LogTrace("UpdateWheelmenuPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("$Wheel menu key or right column key+modifier")
	HKMenu1_OID      = AddKeyMapOption("$Order wheel", DOMKeys.menu1Key)
	HKMenu2_OID      = AddKeyMapOption("$Abuse wheel", DOMKeys.menu2Key)
	HKMenu7_OID      = AddKeyMapOption("$Trainer management", DOMKeys.menu7Key)
	HKMenu5_OID      = AddKeyMapOption("$Group order wheel", DOMKeys.menu5Key)
	HKMenu9_OID      = AddKeyMapOption("$Group abuse wheel", DOMKeys.menu9Key)
	HKDiary_OID      = AddKeyMapOption("Open diary", DOMKeys.diaryKey)

	AddHeaderOption("Left Modifier key")
	HKModifierDefault_OID = AddKeyMapOption("$Default modifier key",   DOMKeys.modifierKeyDefault) 

	AddHeaderOption("Top menu key")
	HKMenu0_OID      = AddKeyMapOption("Top menu wheel", DOMKeys.menu0Key)

	AddHeaderOption("Default actions")
	wheelIsDefaultMenu_OID = AddToggleOption("Use wheel menu", DOMKeys.wheelIsDefaultMenu)
	wheelIsDefaultCall_OID = AddToggleOption("Use wheel top menu", DOMKeys.wheelIsDefaultCall)
	wheelUsesDefaultPunishmentType_OID = AddToggleOption("No wheel choice for punishment type", DOMKeys.wheelUsesDefaultPunishmentType)
	wheelUsesDefaultPraiseType_OID = AddToggleOption("No wheel choice for praise type", DOMKeys.wheelUsesDefaultPraiseType)
	AddMenuOptionST("DefaultWheelPraiseType", "praise", DOMCore.DefaultWheelPraiseType)
	AddMenuOptionST("DefaultWheelPunishmentType", "punish", DOMCore.DefaultWheelPunishmentType)

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("$Wheel menu key or left column key+modifier")
	HKMenu3_OID      = AddKeyMapOption("$Info wheel", DOMKeys.menu3Key)
	HKMenu4_OID      = AddKeyMapOption("$Training wheel", DOMKeys.menu4Key)
	HKMenu8_OID      = AddKeyMapOption("$Trainer abuse", DOMKeys.menu8Key)
	HKMenu6_OID      = AddKeyMapOption("Group info wheel", DOMKeys.menu6Key)
	HKMenu10_OID     = AddKeyMapOption("Group training wheel", DOMKeys.menu10Key)
	HKAction_OID     = AddKeyMapOption("Action key", DOMKeys.actionKey)

	AddHeaderOption("Right Modifier key")
	HKModifier_OID = AddKeyMapOption("$Modifier key",   DOMKeys.modifierKey) 

	AddHeaderOption("Action key parameters")
	actionName_OID = AddInputOption("Action name", DOMCore.ActionName)
	actionType_OID = AddInputOption("Action type", DOMCore.ActionType)
	actionFlag_OID = AddToggleOption("Action flag", DOMCore.ActionFlag)
	actionGroup_OID = AddToggleOption("Action to group", DOMCore.ActionGroup)

	AddHeaderOption("$Other actors")
	HKMenuPAH_OID    = AddToggleOption("$Include PAH actors", DOMKeys.menuPAH)
	HKMenuExtraSlaves_OID= AddToggleOption("Include extra slaves", DOMKeys.menuExtraSlaves)
	HKMenuSlavers_OID= AddToggleOption("$Include slavers", DOMKeys.menuSlavers)
EndFunction

Function UpdateHotkeysPage()
	;LogTrace("UpdateHotkeysPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("$Hotkeys or left column key+modifier")
	HKAbduction_OID    = AddKeyMapOption("$Abduction key", DOMKeys.abductionKey)
	HKCome_OID      = AddKeyMapOption("$Allow slave to orgasm",  DOMKeys.comeKey) 
	HKBagIn_OID     = AddKeyMapOption("$Put in bag", DOMKeys.bagInKey)
	HKRipOff_OID    = AddKeyMapOption("$Rip-off clothes from slave",  DOMKeys.ripoffKey) 
	HKKneel_OID     = AddKeyMapOption("$All slaves kneel",  DOMKeys.kneelKey) 
	HKPunish_OID    = AddKeyMapOption("$Set example",  DOMKeys.punishKey) 
	HKPraise_OID    = AddKeyMapOption("$Slave praise key", DOMKeys.praiseKey) 
	HKTraits_OID    = AddKeyMapOption("$NPC traits key",   DOMKeys.traitsKey) 
	HKFeels_OID     = AddKeyMapOption("$NPC feelings key", DOMKeys.feelsKey) 
	HKMood_OID      = AddKeyMapOption("$Slave mood information", DOMKeys.moodKey) 
	HKFollow_OID    = AddKeyMapOption("$Order all bowing/attentive slaves to follow", DOMKeys.followKey) 
	HKFixme_OID     = AddKeyMapOption("Reset actor", DOMKeys.fixmeKey)
	;HKMove_OID      = AddKeyMapOption("Move bones", DOMKeys.moveKey) 

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("$Wheel menu key or right column key+modifier")
	HKFavor_OID     = AddKeyMapOption("$Do favor",     DOMKeys.favorKey) 
	HKInventory_OID = AddKeyMapOption("$Open slave inventory", DOMKeys.inventoryKey) 
	HKBagOut_OID    = AddKeyMapOption("$Take out of bag", DOMKeys.bagOutKey)	
	HKStrip_OID     = AddKeyMapOption("$Order slave to strip",  DOMKeys.stripKey) 
	HKAttention_OID = AddKeyMapOption("$All slaves attention",  DOMKeys.attentionKey) 
	HKChoke_OID     = AddKeyMapOption("$Choke disrespectful",  DOMKeys.chokeKey) 
	HKScold_OID     = AddKeyMapOption("$Slave scold key",  DOMKeys.scoldKey) 
	HKTraitsDigits_OID = AddKeyMapOption("$NPC numerical traits",   DOMKeys.traitsDigitsKey) 
	HKFeelsDigits_OID  = AddKeyMapOption("$NPC numerical feelings", DOMKeys.feelsDigitsKey) 
	HKStatus_OID       = AddKeyMapOption("$Slave status key", DOMKeys.statusKey) 
	HKFollowAll_OID    = AddKeyMapOption("$Order all movable slaves to follow", DOMKeys.followAllKey) 
	HKTest_OID         = AddKeyMapOption("$Pose test key [DEBUG]", DOMKeys.testPoseKey)
EndFunction

Function UpdateOptionsPage()
	;LogTrace("UpdateOptionsPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("Let's have a serious chat")
	if DOM_DeactivateDialogueForDOM.GetValue() == 0
		activateDialogueForDOM = true
	else
		activateDialogueForDOM = false
	endif
	activateDialogueForDOM_OID = AddToggleOption("Dialogue for DOM actors",  activateDialogueForDOM)
	if DOM_DeactivateDialogueForNPC.GetValue() == 0
		activateDialogueForNPC = true
	else
		activateDialogueForNPC = false
	endif
	activateDialogueForNPC_OID = AddToggleOption("Dialogue for NPC",  activateDialogueForNPC)
	if DOM_DeactivateDialogueFollow.GetValue() == 0
		activateDialogueFollow = true
	else
		activateDialogueFollow = false
	endif
	activateDialogueFollow_OID = AddToggleOption("Follow dialogue for NPC",  activateDialogueFollow)

	AddHeaderOption("$Import/Export Settings")
	ExportSettings_OID = AddTextOption("$Export Settings", "")
	ImportSettings_OID = AddTextOption("$Import Settings", "")
	
	AddHeaderOption("Delete spawned actors")
	AddSliderOptionST("PUN_delete_percentage", "Delete actor stat threshold", DOMCore.deleteActorThreshold)

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("Health regen")
	AddSliderOptionST("PUN_regen_ticks", "Ticks before regen", DOMCore.actorRegenTicks)
	AddSliderOptionST("PUN_regen_amount", "Health points to regen", DOMCore.actorRegenAmount)

	AddHeaderOption("Diaries")
	slaveDiaryToggle_OID = AddToggleOption("Update slave diary",  DOM04.slaveDiaryToggle)
	slaverDiaryToggle_OID = AddToggleOption("Update slaver diary",  DOM04.slaverDiaryToggle)
	AddSliderOptionST("PUN_maxNumberOfParagraph", "Maximum number of paragraphs", DOM04.maxNumberOfParagraph)
	resetAllDiary_OID = AddTextOption("Reset all diaries", "")
	resetAllmemories_OID = AddTextOption("Reset all memories", "")

	AddHeaderOption("Wet and Cold gear")
	allowSlavesGear_OID = AddToggleOption("Allow gear for slaves",  DOMEquip.allowSlavesGearToggle)
	allowSlaversGear_OID = AddToggleOption("Allow gear for slavers",  DOMEquip.allowSlaversGearToggle)
EndFunction

Function UpdatePlayerPage()
	;LogTrace("UpdatePlayerPage")
	if DOM_ActivateCombatRecruit.GetValue() == 0
		activateCombatRecruit = false
	else
		activateCombatRecruit = true
	endif
	if DOM_ActivateCombatAbduction.GetValue() == 0
		activateCombatAbduction = false
	else
		activateCombatAbduction = true
	endif

	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("Settings")

	AddSliderOptionST("PUN_skills_difficulty", "Skills progress", DOMPlayerAlias.skills_difficulty*100.0)
	playerSkillsMessageToggle_OID = AddToggleOption("Show skill milestone messages",  DOMPlayerAlias.playerSkillsMessageToggle)
	kinksPlayerSubToggle_OID = AddToggleOption("Player has submissive kinks",  DOMCore.kinksPlayerSubToggle)
	kinksPlayerDomToggle_OID = AddToggleOption("Player has dominant kinks",    DOMCore.kinksPlayerDomToggle)
	friendsPlayerToggle_OID = AddToggleOption("Player has friends",  DOMCore.friendsPlayerToggle)
	playerJournalToggle_OID = AddToggleOption("Get player's journal",  DOMPlayerAlias.playerJournalToggle)
	playerLedgerToggle_OID = AddToggleOption("Get player's ledger",  DOMPlayerAlias.playerLedgerToggle)
	playerDiaryToggle_OID = AddToggleOption("Update player ledger",  DOM04.playerDiaryToggle)

	AddHeaderOption("Tools")
	addSlapTool_OID  = AddToggleOption("Slap tool",    DOMCore.hasSlapTool)
	equipSlaver_OID = AddTextOption("$Get slaver's equipment", "")	

	AddHeaderOption("Perks")
	addAbductionPerk_OID  = AddToggleOption("$Abduction perk",    DOMCore.hasAbductionPerk)
	activateCombatAbduction_OID  = AddToggleOption("Combat abduction",    activateCombatAbduction)
	addRecruitPerk_OID  = AddToggleOption("Recruit perk",    DOMCore.hasRecruitPerk)
	activateCombatRecruit_OID    = AddToggleOption("Combat recruit",    activateCombatRecruit)
	addWakeUpPerk_OID  = AddToggleOption("Wakeup, tieup and bag perk",    DOMCore.hasWakeUpPerk)
	addBurlapSackPerk_OID  = AddToggleOption("Burlap sack perk",    DOMCore.hasBurlapSackPerk)

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("Spells and Powers")
	addAbductionSpell_OID  = AddToggleOption("Abduction spell",    DOMCore.hasAbductionSpell)
	addDiarySpell_OID  = AddToggleOption("Open diary spell",    		   DOMCore.hasDiarySpell)
	addMenuSpell_OID  = AddToggleOption("Abuse menu spell",    DOMCore.hasMenuSpell)
	addMenuPower_OID  = AddToggleOption("Abuse menu power",    DOMCore.hasMenuPower)
	addInfoSpell_OID  = AddToggleOption("Training info spell",    DOMCore.hasInfoSpell)
	addInfoPower_OID  = AddToggleOption("Training info power",    DOMCore.hasInfoPower)
	summonPAHToggle_OID  = AddToggleOption("Summon PAH slaves",    DOMCore.summonPAHToggle)
	summonPosingToggle_OID  = AddToggleOption("Summon posing slaves",    DOMCore.summonPosingToggle)

	AddHeaderOption("Animations")
	alwaysRandomizeAnimations_OID = AddToggleOption("Use random idle animations",  DOM_Anim.alwaysRandomizeAnimations)
	doAnimPlayerTieup_OID = AddToggleOption("Animate player when tying up", DOMCore.doAnimPlayerTieup)
	doPlayerIdle_OID = AddToggleOption("Idle player",  DOMCore.doPlayerIdle)
	doPlayerAnim_OID = AddToggleOption("$Animate player",  DOM_Anim.doPlayerAnim)
	doAnimateAtActorLocation_OID = AddToggleOption("Animate at actor location",  DOM_Anim.doAnimateAtActorLocation)
	doFreeCamera_OID = AddToggleOption("$Use free camera",  DOM_Anim.doFreeCamera)

EndFunction

Function UpdateDebugPage()
	;LogTrace("UpdateDebugPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	;AddHeaderOption("Toggles")
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	
	AddHeaderOption("$Development")
	debugInit_OID = AddTextOption("$Initialize", "")
	StartupCheckActor_OID  = AddToggleOption("Check actors at startup",  DOMCore.StartupCheckActor)
	debugMode_OID = AddToggleOption("$Debug mode",  DOMCore.debugMode)
	debugKeyMode_OID = AddToggleOption("$Debug key pressed",  DOMKeys.debugKeyMode)
	printActorBonusesToggle_OID = AddToggleOption("Verbose trait bonuses",  DOMGenerator.printActorBonusesToggle)
	verboseMode_OID = AddToggleOption("$Verbose logfile",  DOMCore.verboseMode)
	showKinksToggle_OID = AddToggleOption("Show hidden kinks",  DOMCore.showKinksToggle)
	;removeSlavesSpells_OID = AddTextOption("Remove known spells from all slaves", "$Click")
	;removeSlaversSpells_OID = AddTextOption("Remove known spells from all slavers", "$Click")
	
	AddHeaderOption("Dialogues & random topics")	
	verboseTopics_OID = AddToggleOption("$Log dialogues",  DOMCore.verboseTopics)
	answerToggle_OID = AddToggleOption("Slave answers",  DOMCore.answerToggle)
	topicsToggle_OID = AddToggleOption("Slave topics",  DOMCore.topicsToggle)
	singleTellToggle_OID = AddToggleOption("One telling at a time", DOMCore.singleTellToggle)
	AddSliderOptionST("PUN_update_timer", "Actor update tick length", DOMCore.actorUpdateTimer)
	AddSliderOptionST("PUN_delay_topic", "Per slave comment timeout", DOMCore.delayTopic)
	AddSliderOptionST("PUN_update_timer_global", "Global update tick length", DOMCore.actorUpdateTimerGlobal)
	AddSliderOptionST("PUN_delay_topic_global", "Global comment timeout", DOMCore.delayTopicGlobal)

	SetCursorPosition(1) ; Continue with right column

	if DOMPAH.hasPAH()
		AddHeaderOption("$Transfer slaves")
		int nDOM = DOM02.actorCounter
		transferDOMtoPAHE_OID = AddTextOption("Send {"+nDOM+"} slaves to PAHE", "")
		int npahe = DOMPAH.GetSlaveCount()
		transferPAHEtoDOM_OID = AddTextOption("Send {"+npahe+"} slaves to DOM", "")
	endif

	AddHeaderOption("Tattoos")
	CaptureSyncTattoos_OID = AddToggleOption("Sync tattoos at capture",  DOMCore.CaptureSyncTattoos)
	StartupSyncTattoos_OID = AddToggleOption("Sync tattoos at startup",  DOMCore.StartupSyncTattoos)
	AddMenuOptionST("TattoosArea", "Marks area", DOMCore.marks_area)
	AddMenuOptionST("TattoosSection", "Marks section", DOMCore.marks_section)
	AddMenuOptionST("TattoosName", "Marks name", DOMCore.marks_name)
	marks_color_OID = AddColorOption("Marks color", DOMCore.marks_color)
	marks_glow_OID = AddColorOption("Marks glow color", DOMCore.marks_glow)
	marks_glow_status_OID = AddToggleOption("Marks glow color is status", DOMCore.marks_glow_status)
	marks_gloss_OID = AddToggleOption("Marks gloss",  DOMCore.marks_gloss)
	brand_color_OID = AddColorOption("Brand color", DOMCore.brand_color)
	brand_glow_OID = AddColorOption("Brand glow color", DOMCore.brand_glow)
	brand_glow_status_OID = AddToggleOption("Brand glow color is status", DOMCore.brand_glow_status)
	brand_gloss_OID = AddToggleOption("Brand gloss",  DOMCore.brand_gloss)
	
	AddHeaderOption("Personality message box")	
	dialoguesUseVerboseMessage_OID = AddToggleOption("Personality dialogue message as text",  DOMCore.dialoguesUseVerboseMessage)
	wheelsUseVerboseMessage_OID = AddToggleOption("Personality wheel message as text",  DOMCore.wheelsUseVerboseMessage)
EndFunction

Function UpdatePersonalityPage()
	;LogTrace("UpdatePersonalityPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("Personality traits")
	RandomFlat_OID = AddToggleOption("Flat distribution for traits",  DOMCore.RandomFlat)
	AddSliderOptionST("PUN_trait_race_bonus", "Race personality modifier", DOMCore.trait_race_bonus*10.0)
	AddSliderOptionST("PUN_trait_class_bonus", "Class personality modifier", DOMCore.trait_class_bonus*10.0)
	AddSliderOptionST("PUN_trait_job_bonus", "Job personality modifier", DOMCore.trait_job_bonus*10.0)
	AddSliderOptionST("PUN_trait_gender_bonus", "Gender personality modifier", DOMCore.trait_gender_bonus*10.0)
	AddSliderOptionST("PUN_trait_age_bonus", "Age personality modifier", DOMCore.trait_age_bonus*10.0)
	AddSliderOptionST("PUN_trait_place_bonus", "Location personality modifier", DOMCore.trait_place_bonus*10.0)
	staticTraitsMode_OID = AddToggleOption("$Forbids traits from evolving",  DOMCore.staticTraitsMode)
	staticTraitsChat_OID = AddToggleOption("Chat always increase training",  DOMCore.staticTraitsChat)
	AddSliderOptionST("PUN_trait_variation", "$Maximum trait variation", DOMCore.trait_variation)

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("Running away")
	escapeToggle_OID = AddToggleOption("Slaves can escape", DOMCore.escapeToggle)
	AddSliderOptionST("PUN_runaway_value", "Runaway resignation threshold", DOMCore.runAwayValue)
	AddSliderOptionST("PUN_chanceRunAwayMultiplier", "Runaway chance", DOMCore.chanceRunAwayMultiplier)
	AddHeaderOption("$Extensions")
	resilienceToggle_OID = AddToggleOption("Resilience",  DOMCore.resilienceToggle)
	loyalToggle_OID = AddToggleOption("Loyal",  DOMCore.loyalToggle)
	inloveToggle_OID = AddToggleOption("In love",  DOMCore.inloveToggle)
	depressedToggle_OID = AddToggleOption("$Depression",  DOMCore.depressedToggle)
	insecureToggle_OID = AddToggleOption("Insecure",  DOMCore.insecureToggle)
	jealousyToggle_OID = AddToggleOption("$Jealousy",  DOMCore.jealousyToggle)
	greedToggle_OID = AddToggleOption("Slaves react to jewelry and gold gifts", DOMCore.greedToggle)
	friendToggle_OID = AddToggleOption("$Friendship",  DOMCore.friendToggle)
	friendPlayerToggle_OID = AddToggleOption("Friendship with player",  DOMCore.friendPlayerToggle)
	AddSliderOptionST("PUN_MaxNumberOfFriends", "Number of friends", DOMCore.MaxNumberOfFriends)
	friendFollowToggle_OID = AddToggleOption("Friends in player's cell",  DOMCore.friendFollowToggle)
	friendDistantToggle_OID = AddToggleOption("Friends in all cells",  DOMCore.friendDistantToggle)
	AddSliderOptionST("PUN_friend_threshold", "$Friendship threshold", DOMCore.friend_threshold*100.0)
	rivalryToggle_OID = AddToggleOption("$Rival slaves can attack each other", DOMCore.rivalryToggle)
EndFunction

Function UpdateAbusePage()
	;LogTrace("UpdateAbusePage")
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("Behaviour")	
	sendDOMOrders_OID = AddToggleOption("Use events for group orders",  DOMCore.sendDOMOrders)
	sendDOMEvents_OID = AddToggleOption("Use events for loops on slaves",  DOMCore.sendDOMEvents)
	removeCuffsToggle_OID = AddToggleOption("Remove cuffs with untie", DOMCore.removeCuffsToggle)
	removeGagToggle_OID = AddToggleOption("$Remove gag with untie", DOMCore.removeGagToggle)
	removeBlindfoldToggle_OID = AddToggleOption("$Remove blindfold with untie", DOMCore.removeBlindfoldToggle)
	UpdateCombatStrength_OID = AddToggleOption("Update combat skills",  DOMCore.UpdateCombatStrength)

	AddHeaderOption("Training speed and mofifiers")
	AddSliderOptionST("PUN_train_speed_pain", "$Punishment multiplier", DOMCore.train_speed_pain)
	AddSliderOptionST("PUN_train_speed_sex",  "$Sex multiplier", DOMCore.train_speed_sex)
	AddSliderOptionST("PUN_train_speed_rape", "$Rape multiplier", DOMCore.train_speed_rape)
	AddSliderOptionST("PUN_train_speed_tell", "$Told-off multiplier", DOMCore.train_speed_tell)
	AddSliderOptionST("PUN_train_speed_good", "$Praise multiplier", DOMCore.train_speed_good)
	AddSliderOptionST("PUN_train_speed_npc",  "Training speed for NPCs", DOMCore.train_speed_npc*100.0)
	AddSliderOptionST("PUN_train_speed_player",  "Training speed for Player", DOMCore.train_speed_player*100.0)
	AddSliderOptionST("PUN_love_modifier",     "Love/loyal feeling modifier", DOMCore.train_speed_love*100.0)
	AddSliderOptionST("PUN_arousal_modifier", "Arousal chance modifier", DOMCore.train_speed_arousal*100.0)
	AddSliderOptionST("PUN_orgasm_modifier",  "Orgasm chance modifier", DOMCore.train_speed_orgasm*100.0)
	AddSliderOptionST("PUN_kinktraining_modifier", "Kink training modifier", DOMCore.train_speed_kink*100.0)
	AddSliderOptionST("PUN_kinkarousal_modifier", "Kink arousal modifier", DOMCore.arousal_speed_kink*100.0)
	AddSliderOptionST("PUN_kinkorgasm_modifier", "Kink orgasm chance modifier", DOMCore.orgasm_speed_kink*100.0)

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("Default abuses")
	AddMenuOptionST("DefaultPraiseType", "praise", DOMCore.DefaultPraiseType)
	AddMenuOptionST("DefaultPunishmentType", "punish", DOMCore.DefaultPunishmentType)

	AddHeaderOption("Punishment on hit")
	fHitToggle_OID = AddToggleOption("$Follower's attacks punish slaves", DOMCore.fHitToggle)
	sHitToggle_OID = AddToggleOption("$Slave's attacks punish slaves", DOMCore.sHitToggle)

	AddHeaderOption("Sex")	
	AddSliderOptionST("PUN_submission_value", "Min sub for nice sex", DOM_SubmissionMinValue.GetValue())
	undressBeforeSex_OID = AddToggleOption("Undress before sex", DOMSexlab.undressBeforeSex)
	redressAfterSex_OID = AddToggleOption("Redress after sex", DOMSexlab.redressAfterSex)
	doAnimBeforeAndAfterSex_OID = AddToggleOption("Anim strip before and after sex", DOMCore.doAnimBeforeAndAfterSex)
	doRipOffBeforeSex_OID = AddToggleOption("Dual anim rip-off before rape", DOMSexlab.doRipOffBeforeSex)
	
	AddHeaderOption("Bathing")	
	AddSliderOptionST("PUN_dirty_amount", "Dirtiness for 10 days", DOMCore.dirtRegenAmount*10.0)
	useBiS_OID = AddToggleOption("Use Bathing in Skyrim",  DOMBath.useBiS)

	AddHeaderOption("$House cleaning")
	cleanDeleteToggle_OID  = AddToggleOption("$Generated items are deleted during cleaning",    DOMCore.cleanDeleteToggle)
	cleanWeaponsToggle_OID = AddToggleOption("$Pickup weapons when cleaning",  DOMCore.cleanWeaponsToggle)
	cleanArmorsToggle_OID  = AddToggleOption("$Pickup armors when cleaning",   DOMCore.cleanArmorsToggle)
	cleanAmmoToggle_OID    = AddToggleOption("$Pickup ammo when cleaning",     DOMCore.cleanAmmoToggle)
	cleanBooksToggle_OID   = AddToggleOption("$Pickup books when cleaning",     DOMCore.cleanBooksToggle)
	cleanScrollsToggle_OID = AddToggleOption("$Pickup scrolls when cleaning",  DOMCore.cleanScrollsToggle)
EndFunction

Function UpdateEquipmentPage()
	;LogTrace("UpdateEquipmentPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column
	AddHeaderOption("$Stripping")
	useStripKeywords_OID = AddToggleOption("Use DOM fast strip keywords", DOMEquip.useStripKeywords)
	resetStripKeywords_OID = AddToggleOption("Reset DOM fast strip keywords", DOMEquip.resetStripKeywords)
	stripAndDropToggle_OID = AddToggleOption("$Strip always drop items", DOMEquip.stripAndDropToggle)
	stripDeleteToggle_OID = AddToggleOption("$Delete items", DOMEquip.stripDeleteToggle)
	stripLootToggle_OID = AddToggleOption("$Add items to player inventory", DOMEquip.stripLootToggle)
	stripItemsToggle_OID = AddToggleOption("Strip all items", DOMEquip.stripItemsToggle)
	stripUnequippedToggle_OID = AddToggleOption("$Include unequipped items", DOMEquip.stripUnequippedToggle)
	stripWeaponsToggle_OID = AddToggleOption("$Strip weapons", DOMEquip.stripWeaponsToggle)
	stripShieldsToggle_OID = AddToggleOption("Strip shields", DOMEquip.stripShieldsToggle)
	stripHeelsToggle_OID = AddToggleOption("$Include heels", DOMEquip.stripHeelsToggle)
	stripUnderwearToggle_OID = AddToggleOption("$Include underwear", DOMEquip.stripUnderwearToggle)
	stripJewelryToggle_OID = AddToggleOption("$Include jewelry", DOMEquip.stripJewelryToggle)

	SetCursorPosition(1) ; Continue with right column
	AddHeaderOption("Special slots")	
	neverStripFX_OID = AddToggleOption("Never strip FX/hair/body/genitals", DOMEquip.neverStripFX)
	shameArea52_OID = AddToggleOption("Make area 52 shameful", DOMEquip.shameArea52)
	maskPubicArea_OID = AddToggleOption("Do not strip area 52", DOMEquip.maskPubicArea)
	maskFillHerUp_OID = AddToggleOption("Do not strip area 48 and 53-55", DOMEquip.maskFillHerUp)

	AddHeaderOption("Inventory")	
	verboseEquip_OID = AddToggleOption("Log equipment ",  DOMEquip.verboseEquip)
	sendDOMEquipEvent_OID = AddToggleOption("Use events for equip inventory",  DOMEquip.sendDOMEquipEvent)
	itemEquipToggle_OID = AddToggleOption("On item equipped equip",  DOMEquip.itemEquipToggle)
	instantEquipToggle_OID = AddToggleOption("Instant equip items",  DOMEquip.instantEquipToggle)
	instantUnEquipToggle_OID = AddToggleOption("Instant re-equip items",  DOMEquip.instantUnEquipToggle)
	cellEquipToggle_OID = AddToggleOption("Cell load equip",  DOMEquip.cellEquipToggle)
	locationEquipToggle_OID = AddToggleOption("Location change equip",  DOMEquip.locationEquipToggle)
EndFunction

Function UpdateNPCsPage()
	;LogTrace("UpdateNPCsPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("NPC dialogues")
	AddSliderOptionST("PUN_closeness_value", "Closeness value", DOM_RelationShipClosenessValue.GetValue())
	AddSliderOptionST("PUN_intimacy_value", "Intimacy value", DOM_RelationShipIntimacyValue.GetValue())
	AddSliderOptionST("PUN_training_threshold_low", "Low stat threshold for abuse", DOM_TrainingThresholdLow.GetValue())
	AddSliderOptionST("PUN_training_threshold_medium", "Medium stat threshold for abuse", DOM_TrainingThresholdMedium.GetValue())
	AddSliderOptionST("PUN_training_threshold_high", "High stat threshold for abuse", DOM_TrainingThresholdHigh.GetValue())
	AddSliderOptionST("PUN_training_threshold_max", "Max stat threshold for abuse", DOM_TrainingThresholdMax.GetValue())

	AddHeaderOption("NPC reactions")
	tieupWhenUnBagToggle_OID = AddToggleOption("Tieup when out of bag", DOMKeys.tieupWhenUnBagToggle)
	alarmToggleAbduction_OID = AddToggleOption("$Alarm on abduction", DOMKeys.alarmToggleAbduction)
	alarmToggleAbduction2_OID = AddToggleOption("Alarm on out of bag", DOMKeys.alarmToggleAbduction2)
	alarmToggleWitness_OID = AddToggleOption("Witness alarm at start", DOMKeys.alarmToggleWitness)
	alarmToggleWitness2_OID = AddToggleOption("Witness alarm at end", DOMKeys.alarmToggleWitness2)
	alarmToggleWitness3_OID = AddToggleOption("Witness alarm when bagging", DOMKeys.alarmToggleWitness3)
	alarmToggleRunaway_OID = AddToggleOption("$Alarm for runaway slaves", DOMCore.alarmToggleRunaway)
	familyToggle_OID = AddToggleOption("Family reacts to slaves",  DOMCore.familyToggle)
	hugWhenFreedToggle_OID = AddToggleOption("Freed slaves give hug",  DOMCore.hugWhenFreedToggle)

	SetCursorPosition(1) ; Continue with right column
	
	AddHeaderOption("Personality generation")
	seedUniques_OID  = AddToggleOption("Seed unique actors",    DOMCore.seedUniques)

	AddHeaderOption("JSON personality file")
	readJSONForUniques_OID = AddToggleOption("Read JSON for uniques",  DOMGenerator.readJSONForUniques)
	readJSONForSpawned_OID = AddToggleOption("Read JSON for spawned",  DOMGenerator.readJSONForSpawned)
	ReadJSONTraitsWarning_OID = AddToggleOption("Read personality warning",  DOMGenerator.ReadJSONTraitsWarning)
	ReadJSONTraitsToggle_OID = AddToggleOption("Read personality traits",  DOMGenerator.ReadJSONTraitsToggle)
	ReadJSONRelationshipToggle_OID = AddToggleOption("Read relationship to player",  DOMGenerator.ReadJSONRelationshipToggle)
	ReadJSONVirginityToggle_OID = AddToggleOption("Read virginity status",  DOMGenerator.ReadJSONVirginityToggle)
	ReadJSONTrainingToggle_OID = AddToggleOption("Read training stats",  DOMGenerator.ReadJSONTrainingToggle)
	ReadJSONKinksToggle_OID = AddToggleOption("Read hidden kinks",  DOMGenerator.ReadJSONKinksToggle)
	ReadJSONMemoriesToggle_OID = AddToggleOption("Read diary memories",  DOMGenerator.ReadJSONMemoriesToggle)
	
	AddHeaderOption("Buyers and clients")
	AddSliderOptionST("PUN_wealth_modifier", "$NPC wealth multiplier", DOMCore.wealth_modifier)
	If (Game.GetModByName("PAH_HomeSweetHome.esp") != 255)
		HSHQuest = Game.GetFormFromFile(0x00008402, "PAH_HomeSweetHome.esp") As phhshStorageFunctions 
		if HSHQuest != None
			if HSHQuest.SLAL != None
				phhshUseSLAL_OID = AddToggleOption("HSH uses SL aroused",    HSHQuest.SLAL.phhshUseSLAL)
			endif
		endif
	endif
EndFunction

Function UpdateNotificationsPage()
	;LogTrace("UpdateNotificationsPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("Widgets")
	AddSliderOptionST("PUN_number_of_widgets", "$Maximum number of widgets", DOMCore.number_of_widgets)
	wMessageToggle_OID = AddToggleOption("$Messages in widgets",  DOMCore.wMessageToggle)
	AddMenuOptionST("HorizontalAnchor", "Horizontal", DOMCore.HorizontalAnchor)
	AddMenuOptionST("VerticalAnchor", "Vertical", DOMCore.VerticalAnchor)
	clearWidgets_OID = AddTextOption("Clear widgets", "")	

	AddHeaderOption("$Notifications")
	wMessageLevel0_OID = AddToggleOption("$Show friend messages",  DOMCore.wMessageLevel0)
	wMessageLevel1_OID = AddToggleOption("$Show mood messages",  DOMCore.wMessageLevel1)
	wMessageLevel2_OID = AddToggleOption("$Show emotions messages",  DOMCore.wMessageLevel2)
	wMessageLevel3_OID = AddToggleOption("$Show secondary abuse messages",  DOMCore.wMessageLevel3)
	wMessageLevel4_OID = AddToggleOption("$Show response messages",  DOMCore.wMessageLevel4)
	wMessageLevel5_OID = AddToggleOption("$Show important abuse messages",  DOMCore.wMessageLevel5)

	SetCursorPosition(1) ; Continue with right column
		
	AddHeaderOption("Widget colors")
	widgetColor_OID = new Int[20]
	int i = 0
	int n = widgetColor_OID.length
	while i < n && i < DOMCore.widgetColor.length
		widgetColor_OID[i] = AddColorOption("Widget "+i, DOMCore.widgetColor[i])
		i += 1
	endWhile
EndFunction

Function UpdateIdlesPage()
	;LogTrace("UpdateIdlesPage")
	SetCursorFillMode(TOP_TO_BOTTOM)
	;AddHeaderOption("Toggles")
    ;===============================================================================
	SetCursorPosition(0) ; Start with left column

	AddHeaderOption("$Idles")
	attentionPoseOn_OID = AddToggleOption("$Attention idle starts pose",  DOMCore.attentionPoseOn)
	attentionPose_OID = AddInputOption("$Attention idle", DOMCore.attentionPose)
	salutePoseOn_OID = AddToggleOption("Salute idle starts pose",  DOMCore.salutePoseOn)
	salutePose_OID = AddInputOption("Salute idle", DOMCore.salutePose)
	kneelPoseOn_OID = AddToggleOption("$Bow idle starts pose",  DOMCore.kneelPoseOn)
	kneelPose_OID = AddInputOption("$Bow idle", DOMCore.kneelPose)
	AddSliderOptionST("PUN_postrape_delay", "Trauma delay", DOMSexlab.postRapeDelay)

	AddHeaderOption("$Pose settings")	
	GroupChoiceRandom_OID = AddToggleOption("Group order Random pose",  DOMCore.GroupChoiceRandom)
	GroupChoicePose_OID = AddToggleOption("Group order wheel pose",  DOMCore.GroupChoicePose)
	poseMoveToggle_OID = AddToggleOption("Reset actor position when posing or tied", DOMCore.poseMoveToggle)
	checkInteriorPosesToggle_OID = AddToggleOption("Check tied poses can be used outdoor", DOMCore.checkInteriorPosesToggle)
	AddSliderOptionST("PUN_pose_threshold", "$Pose praise in minutes", DOMCore.pose_threshold*1440.0)

	AddHeaderOption("$Posing spells")
	spellPose1_OID = AddInputOption("$Pose for spell 1", DOMCore.spellPose1)
	spellPose2_OID = AddInputOption("$Pose for spell 2", DOMCore.spellPose2)

	SetCursorPosition(1) ; Continue with right column

	AddHeaderOption("Trainees")
	travelCuffsToggle_OID = AddToggleOption("Travelling slaves are cuffed", DOMCore.travelCuffsToggle)
	punishPoseToggle_OID = AddToggleOption("Punished slaves should pose", DOMCore.punishPoseToggle)
	punishTieToggle_OID = AddToggleOption("Punished slaves should be tied-up", DOMCore.punishTieToggle)
	punishMasturbateToggle_OID = AddToggleOption("Sex trainees should masturbate", DOMCore.punishMasturbateToggle)
	punishRestrainToggle_OID = AddToggleOption("Sex trainees should be restrained", DOMCore.punishRestrainToggle)

	AddHeaderOption("$Animations")	
	verboseAnim_OID = AddToggleOption("$Log animations ",  DOMCore.verboseAnim)
	requireSLTags_OID = AddToggleOption("Require all Sexlab tags",  DOMSexlab.requireSLTags)
	requireSLTags3_OID = AddToggleOption("Require all tags for 3somes",  DOMSexlab.requireSLTags3)
	requireSLTags4_OID = AddToggleOption("Require all tags for 4somes",  DOMSexlab.requireSLTags4)
	doRemoveHeels_OID = AddToggleOption("Remove heels",  DOM_Anim.doRemoveHeels)
	rescaleAnimToggle_OID = AddToggleOption("$Rescale actors",  DOM_Anim.doRescale)
	dualAnimToggle_OID = AddToggleOption("$Turn on all dual animations",  DOMCore.dualAnimToggle)
	AddSliderOptionST("PUN_anim_speed_sec", "$Dual animation length", DOMCore.anim_speed_sec*100.0)

	
	;registerSexLab_OID	= AddTextOption("$Register Sexlab animations", "")
EndFunction

Event OnOptionHighLight(Int option)
	If (option == ExportSettings_OID)
		SetInfoText("$Export settings to file /SKSE/Plugins/StorageUtilData/Diary Of Mine/"+PlayerRef.getDisplayName()+"/Settings.json")
	elseif (option == seedUniques_OID)
		SetInfoText("Add a seed to unique NPCs to allow for different personalities")
	elseif (option == phhshUseSLAL_OID)
		SetInfoText("Turn off Sexlab Aroused in AYGAS and HSH")
	elseif (option == ImportSettings_OID)
		SetInfoText("$Import settings from file /SKSE/Plugins/StorageUtilData/Diary Of Mine/"+PlayerRef.getDisplayName()+"/Settings.json")
	elseif (option == debugInit_OID)
		SetInfoText("$Reinitialize DOM")
	elseif (option == resetAllDiary_OID)
		SetInfoText("Reset all diaries text")
	elseif (option == resetAllmemories_OID)
		SetInfoText("Reset all memories from all diaries ")
	elseif (option == equipSlaver_OID)
		SetInfoText("$Equip character with a whip and slaver's weapons")
	elseif (option == clearWidgets_OID)
		SetInfoText("Will clear which actors are associated with which widget")
	elseif (option == registerSexLab_OID)
		SetInfoText("$Register Zaz and SLAL animations to SexLab")
	elseif (option == resilienceToggle_OID)
		SetInfoText("Turn on or off slave hability to recover and lower training stats")
	elseif (option ==loyalToggle_OID)
		SetInfoText("$Turn on or off loyal mood")
	elseif (option ==inloveToggle_OID)
		SetInfoText("$Turn on or off in-love mood and all love moods below")
	elseif (option == depressedToggle_OID)
		SetInfoText("$Turn on or off depressed mood")
	elseif (option == insecureToggle_OID)
		SetInfoText("Turn on or off insecure mood")
	elseif (option == jealousyToggle_OID)
		SetInfoText("$Turn on or off jealous mood")
	elseif (option == greedToggle_OID)
		SetInfoText("Turn on or off greed emotion")
	elseif (option == friendToggle_OID)
		SetInfoText("Actors have friends and they react to different events")
	elseif (option == friendPlayerToggle_OID)
		SetInfoText("Actors can befriend the player")
	elseif (option == friendFollowToggle_OID)
		SetInfoText("Actors following player are check for friends at location change")
	elseif (option == friendDistantToggle_OID)
		SetInfoText("Actors in all cells are check for friends every day")
	elseif (option == hugWhenFreedToggle_OID)
		SetInfoText("Slave will hug player when freed if mood is high enough")
	elseif (option == familyToggle_OID)
		SetInfoText("Slave's family will approach player")
	elseif (option == answerToggle_OID)
		SetInfoText("Slaves answer orders")
	elseif (option == marks_glow_status_OID)
		SetInfoText("Branding mark glow color is set according to slave status")
	elseif (option == marks_gloss_OID)
		SetInfoText("Branding mark has skin-like gloss")
	elseif (option == brand_glow_status_OID)
		SetInfoText("Status tattoo glow color is set according to slave status")
	elseif (option == brand_gloss_OID)
		SetInfoText("Status tattoo has skin-like gloss")
	elseif (option == topicsToggle_OID)
		SetInfoText("$Slaves express their feelings in Random topics")
	elseif (option == itemEquipToggle_OID)
		SetInfoText("Equipment is re-checked when Skyrim sends an equip event")
	elseif (option == instantEquipToggle_OID)
		SetInfoText("Item is re-checked  when transfered to the inventory window")
	elseif (option == instantUnEquipToggle_OID)
		SetInfoText("Equipment is re-checked  when an item is taken from the inventory window")
	elseif (option == cellEquipToggle_OID)
		SetInfoText("Equipment is re-checked  when cell loads")
	elseif (option == locationEquipToggle_OID)
		SetInfoText("Equipment is re-checked  when location changes")
	elseif (option == useStripKeywords_OID)
		SetInfoText("Add special keywords to items to be stripped or not (SE only)")
	elseif (option == shameArea52_OID)
		SetInfoText("Armors with area 52 parts are always considered shameful")
	elseif (option == maskPubicArea_OID)
		SetInfoText("Do not strip items in pubic slot. Use for SOS and Pube replacement mods")
	elseif (option == maskFillHerUp_OID)
		SetInfoText("Do not strip items from slots 48 and 53 to 55. Needed for Fill her Up mod")
	elseif (option == resetStripKeywords_OID)
		SetInfoText("Reset special keywords from now on - Do not leave it on for too long (SE only)")
	elseif (option == stripAndDropToggle_OID)
		SetInfoText("$DOM_stripAndDropToggle_Info")
	elseif (option == neverStripFX_OID)
		SetInfoText("If on FX/hair/body/genitals are never stripped even if part of armour or clothing")
	elseif (option == stripDeleteToggle_OID)
		SetInfoText("$All equipped clothes and weapons will be deleted")
	elseif (option == stripLootToggle_OID)
		SetInfoText("$All equipped clothes and weapons will be looted by player")
	elseif (option == stripItemsToggle_OID)
		SetInfoText("All type of items be looted by player or removed")
	elseif (option == stripUnequippedToggle_OID)
		SetInfoText("$Unequipped clothes and weapons will be included")
	elseif (option == stripWeaponsToggle_OID)
		SetInfoText("$Will also take weapons when stripping")
	elseif (option == stripShieldsToggle_OID)
		SetInfoText("$Strip shields and removing weapons also removes shields")
	elseif (option == stripHeelsToggle_OID)
		SetInfoText("$Heels (heels keywords or in object name) will be included")
	elseif (option == stripUnderwearToggle_OID)
		SetInfoText("$Underwear (underwear keywords or in object name) will be included")
	elseif (option == stripJewelryToggle_OID)
		SetInfoText("$Jewelry (jewelry keywords) will be included")
	elseif (option == undressBeforeSex_OID)
		SetInfoText("Slaves and slavers will undress before sex")
	elseif (option == redressAfterSex_OID)
		SetInfoText("Slaves and slavers will dress after sex")
	elseif (option == doAnimBeforeAndAfterSex_OID)
		SetInfoText("Undressing and redressing animations are played before and after sex")
	elseif (option == doRipOffBeforeSex_OID)
		SetInfoText("If sex is aggressive rip-off dual animation will be played")
	elseif (option == removeCuffsToggle_OID)
		SetInfoText("Untie slave also removes cuffs")
	elseif (option == removeBlindfoldToggle_OID)
		SetInfoText("Untie slave also removes blindfold")
	elseif (option == removeGagToggle_OID)
		SetInfoText("$Untie slave also removes gag")
	elseif (option == wMessageToggle_OID)
		SetInfoText("$Use Apropos style widgets for notifications")
	elseif (option == wMessageLevel0_OID)
		SetInfoText("Messages related to friends and rivals will appear in widgets or hud")
	elseif (option == wMessageLevel1_OID)
		SetInfoText("$Mood and behaviour changes will appear in widgets or hud")
	elseif (option == wMessageLevel2_OID)
		SetInfoText("$Emotions & warnings will appear in widgets or hud")
	elseif (option == wMessageLevel3_OID)
		SetInfoText("$Secondary abuse and drink messages will appear in widgets or hud")
	elseif (option == wMessageLevel4_OID)
		SetInfoText("$Responses to orders will appear in widgets or hud")
	elseif (option == wMessageLevel5_OID)
		SetInfoText("$Abuse and error messages will appear in widgets or hud")
	elseif (option == doAnimPlayerTieup_OID)
		SetInfoText("If uncheck the player will not be animated when tying-up slaves")
	elseif (option == activateCombatAbduction_OID)
		SetInfoText("Abduction perk is active on low health actors")
	elseif (option == activateCombatRecruit_OID)
		SetInfoText("Recruit perk is active on low health actors")
	elseif (option == summonPAHToggle_OID)
		SetInfoText("Summon slaves spells also apply to PAH slaves")
	elseif (option == summonPosingToggle_OID)
		SetInfoText("Summon slaves spells also apply to posing & masturbating slaves")
	elseif (option == singleTellToggle_OID)
		SetInfoText("Only one of scold/praise/insult/flatter/threat/promise/comfort per slave at a time")
	elseif (option == useBiS_OID)
		SetInfoText("Use bathing in Skyrim animations if installed")
	elseif (option == blushFToggle_OID)
		SetInfoText("Allow blush for aroused females")
	elseif (option == tearsFToggle_OID)
		SetInfoText("$Allow tears for females in sad or shocked mood")
	elseif (option == masctFToggle_OID)
		SetInfoText("$Allow mascara black tears for females in sad or shocked mood")
	elseif (option == blushMToggle_OID)
		SetInfoText("Allow blush for aroused males")
	elseif (option == tearsMToggle_OID)
		SetInfoText("$Allow tears for males in sad or shocked mood")
	elseif (option == masctMToggle_OID)
		SetInfoText("$Allow mascara black tears for males in sad or shocked mood")
	elseif (option == cryingPunishmentToggle_OID)
		SetInfoText("Slaves may be punished for crying")
	elseif (option == cryingPraiseToggle_OID)
		SetInfoText("Slaves may be praised for crying")
	elseif (option == HKFixme_OID)
		SetInfoText("$This a trick for restoring invisible NPCs")
	elseif (option == HKTest_OID)
		SetInfoText("$Key used to test a serie of poses")
	elseif (option == HKAbduction_OID)
		SetInfoText("$Quick capture NPC under crosshair")
	elseif (option == actionName_OID)
		SetInfoText("Praise, scold, insult, flatter, ..")
	elseif (option == actionType_OID)
		SetInfoText("Reason (crying, being angry, ...) or type (sexy, romance, ...)")
	elseif (option == actionType_OID)
		SetInfoText("Usually wether or not to wear additional cuffs when restrained")
	elseif (option == HKBagIn_OID)
		SetInfoText("$Press tghis key to put a slave in a bag")
	elseif (option == HkBagOut_OID)
		SetInfoText("$Press this key to take a slave out of bag")
	elseif (option == oppositeSexToggle_OID)
		SetInfoText("$Allow slaves to comment about sex with opposite gender player")
	elseif (option == sameSexToggle_OID)
		SetInfoText("$Allow slaves to comment about sex with same gender player")
	elseif (option == setTransferNodeToggle_OID)
		SetInfoText("Transfer RaceMenu morphs from original actor to clone")
	elseif (option == setOBodyPresetToggleF_OID)
		SetInfoText("Apply OBody settings from original female actor to clone")
	elseif (option == setOBodyPresetToggleM_OID)
		SetInfoText("Apply OBody settings from original male actor to clone")
	elseif (option == doPlayerIdle_OID)
		SetInfoText("Idle player when tying up slaves and such")
	elseif (option == alwaysRandomizeAnimations_OID)
		SetInfoText("If false will choose idles according to personality for DOM actors")
	elseif (option == doAnimateAtActorLocation_OID)
		SetInfoText("If false will animate at player's location")
	elseif (option == doPlayerAnim_OID)
		SetInfoText("$Allow single animations on player")
	elseif (option == doFreeCamera_OID)
		SetInfoText("Use free camera mode during dual animations")
	elseif (option == doRemoveHeels_OID)
		SetInfoText("Remove heels effect during dual animations")
	elseif (option == dualAnimToggle_OID)
		SetInfoText("$Always use dual animations")
	elseif (option == requireSLTags_OID)
		SetInfoText("Require all Sexlab tags to be met when selecting animations")
	elseif (option == requireSLTags4_OID)
		SetInfoText("Require all Sexlab tags to be met when selecting animations")
	elseif (option == requireSLTags3_OID)
		SetInfoText("Require all Sexlab tags to be met when selecting animations")
	elseif (option == startSexlabPreferablyPlayer_OID)
		if DOMSexlab.DOM_HasSexlab.GetValue() == 1
			SetInfoText("Will use Sexlab rather than OStim for player sex scenes")
		else
			SetInfoText("Sexlab is not installed!")
		endif
	elseif (option == startSexlabPreferablyNPC_OID)
		if DOMSexlab.DOM_HasSexlab.GetValue() == 1
			SetInfoText("Will use Sexlab rather than OStim for NPCs sex scenes without the player")
		else
			SetInfoText("Sexlab is not installed!")
		endif
	elseif (option == startSexlabPreferablyDOM_OID)
		if DOMSexlab.DOM_HasSexlab.GetValue() == 1
			SetInfoText("Will use Sexlab rather than OStim for sex scenes with only DOM actors")
		else
			SetInfoText("Sexlab is not installed!")
		endif
	elseif (option == separateOrgasmToggle_OID)
		if Game.GetModByName("SLSO.esp") != 255
			SetInfoText("$Use SLSO events to trigger slaves orgasm instead of DOM personality system")
		else
			SetInfoText("$SLSO is not installed!")
		endif
	elseif (option == alwaysAggressiveToggle_OID)
		SetInfoText("$Always select aggressive animations for non punishment sex")
	elseif (option == alwaysGentleToggle_OID)
		SetInfoText("$Always select non aggressive animations for punishment sex")
	elseif (option == useAggressiveTag_OID)
		SetInfoText("Require aggressive tag for punishment sex animations")
	elseif (option == attentionPoseOn_OID)
		SetInfoText("$Slaves keep attention pose instead of resuming activity")
	elseif (option == salutePoseOn_OID)
		SetInfoText("Slaves keep salute pose instead of resuming activity")
	elseif (option == attentionPose_OID)
		SetInfoText("$Enter animation string to be used as attention pose")
	elseif (option == salutePose_OID)
		SetInfoText("Enter animation string to be used as salute pose")
	elseif (option == kneelPoseOn_OID)
		SetInfoText("$Slaves keep attention pose instead of resuming activity")
	elseif (option == kneelPose_OID)
		SetInfoText("$Enter animation string to be used as bow to mistress/master pose")
	elseif (option == checkInteriorPosesToggle_OID)
		SetInfoText("If set hanging from roof poses will not be used outdoor")
	elseif (option == poseMoveToggle_OID)
		SetInfoText("Reset actor position every tick for posing or tied actors")
	elseif (option == spellPose1_OID)
		SetInfoText("$Send animation to NPC (debug spell)")
	elseif (option == spellPose2_OID)
		SetInfoText("$Send another animation to NPC (debug spell)")
	elseif (option == HKMenu0_OID)
		SetInfoText("All menus access in one wheel or message box")
	elseif (option == HKMenu1_OID)
		SetInfoText("$Inventory, follow, wait, fight, pose, maid, order")
	elseif (option == HKMenu2_OID)
		SetInfoText("$Punish, threaten, choke, example, praise, promise, flatter, comfort")
	elseif (option == HKMenu3_OID)
		SetInfoText("$Personality, stats, respect, silence, tie, bag")
	elseif (option == HKMenu4_OID)
		SetInfoText("$Clothes, rape, sex, orgasm, display, kiss, inspect, masturbate")
	elseif (option == HKMenu5_OID)
		SetInfoText("$Group respect, follow, wait, fight, pose, kneel, attention")
	elseif (option == HKMenu6_OID)
		SetInfoText("$Group clothes, display, masturbate, silence, threaten, promise, tie, bag")
	elseif (option == HKMenu7_OID)
		SetInfoText("$Slave management menu for trainers")
	elseif (option == HKMenu8_OID)
		SetInfoText("$Slave training menu for trainers")
	elseif (option == HKMenu9_OID)
		SetInfoText("Group status menu")
	elseif (option == HKMenu10_OID)
		SetInfoText("Group training menu")
	elseif (option == HKAction_OID)
		SetInfoText("Key to press for customized action")
	elseif (option == HKDiary_OID)
		SetInfoText("Key to press to open actor's diary")
	elseif (option == HKModifierDefault_OID)
		SetInfoText("If set this modifier has to be pressed to enable left column hotkeys")
	elseif (option == HKModifier_OID)
		SetInfoText("Modifier key to press for right column hotkey")
	elseif (option == HKMenuPAH_OID)
		SetInfoText("$PAH slaves answer to group wheel if available")
	elseif (option == HKMenuExtraSlaves_OID)
		SetInfoText("Also include slaves from extra managers (Addon's slaves)")
	elseif (option == HKMenuSlavers_OID)
		SetInfoText("$Also include slavers to group wheel orders if available")
	elseif (option == HKTraits_OID)
		SetInfoText("$Display message box with target NPC traits")
	elseif (option == HKTraitsDigits_OID)
		SetInfoText("$Displays NPC traits in numerical format")
	elseif (option == HKFeels_OID)
		SetInfoText("$Display message box with target NPC feelings")
	elseif (option == HKFeelsDigits_OID)
		SetInfoText("$Displays NPC feelings in numerical format")
	elseif (option == HKMood_OID)
		SetInfoText("$Information on the slave current mood and progress")
	elseif (option == HKMove_OID)
		SetInfoText("Press and hold key to explore slave's body")
	elseif (option == HKInventory_OID)
		SetInfoText("$Opens PAHE and HSH slaves inventory")
	elseif (option == HKStatus_OID)
		SetInfoText("$Display message box with slave status")
	elseif (option ==  HKFollow_OID)
		SetInfoText("$Order all nearby slaves bowing or in attention pose to follow player")
	elseif (option ==  HKFollowAll_OID)
		SetInfoText("$Order all nearby slaves not tied or in furniture to follow player")
	elseif (option ==  HKPraise_OID)
		SetInfoText("$Praise target for being a good slave")
	elseif (option == HKScold_OID)
		SetInfoText("$Tell off slave for bad behaviour")
	elseif (option ==  HKPunish_OID)
		SetInfoText("$Punish slave publicly, setting an example for others")
	elseif (option ==  HKChoke_OID)
		SetInfoText("$Punish unrespectful slave with choke")
	elseif (option ==  HKFavor_OID)
		SetInfoText("$Tell slave to use object or furniture")
	elseif (option ==  HKKneel_OID)
		SetInfoText("$Force all slaves to kneel in front of player")
	elseif (option ==  HKAttention_OID)
		SetInfoText("$Force all slaves to use attention pose in front of player")
	elseif (option ==  HKRipOff_OID)
		SetInfoText("$Rip-off clothes and weapons from slave and delete or steal them")
	elseif (option ==  HKStrip_OID)
		SetInfoText("$Order slave to remove clothes and unequip weapons")
	elseif (option ==  HKCome_OID)
		SetInfoText("$Allow slave under crosshair to orgasm")
	elseif (option == wheelIsDefaultCall_OID)
		SetInfoText("Top menu will use wheels instead of dialogue boxes")
	elseif (option == wheelIsDefaultMenu_OID)
		SetInfoText("Menu will use wheels instead of dialogue boxes")
	elseif (option == wheelUsesDefaultPunishmentType_OID)
		SetInfoText("Default punishment type will be used instead of wheel choice")
	elseif (option == wheelUsesDefaultPraiseType_OID)
		SetInfoText("Default praise type will be used instead of wheel choice")
	elseif (option ==  renameToggle_OID)
		SetInfoText("Use race inspired Random names for cloned NPCs")
	elseif (option ==  cloneUniqueMode_OID)
		SetInfoText("$Clone unique NPCs when enslaving and kill original")
	elseif (option == cloneSpawnMode_OID)
		SetInfoText("$Clone spawned NPCs when enslaving and kill original")
	elseif (option == cleanCrimeFaction_OID)
		SetInfoText("$Always clean crime faction regardless of other options")
	elseif (option == cleanFactionUnique_OID)
		SetInfoText("$Clean factions for unique NPCs")
	elseif (option == cleanFactionSpawn_OID)
		SetInfoText("$Clean factions for spawned NPCs")
	elseif (option == cleanUniqueOutfit_OID)
		SetInfoText("$Use naked outfit for unique NPCs")
	elseif (option == cleanSpawnOutfit_OID)
		SetInfoText("$Use naked outfit for spawned NPCs")
	elseif (option == cleanSlaverOutfit_OID)
		SetInfoText("$Use naked outfit for slavers. Unique/spawned flags above apply")
	elseif (option == restoreOutfitUnique_OID)
		SetInfoText("$Restore default outfit for unique NPCs on release")
	elseif (option == restoreOutfitSpawn_OID)
		SetInfoText("$Restore default outfit for spawned NPCs on release")
	elseif (option == restoreOutfitAlways_OID)
		SetInfoText("Restore outfit when moving slaves to PAH/HSH/AYGAS (above rules apply)")
	elseif (option == playerGender_OID)
		SetInfoText("Valid entries are: male, female, other, treat as male, treat as female")
	elseif (option == actorGender_OID)
		SetInfoText("Valid entries are: male, female, other, treat as male, treat as female")
	endif
EndEvent

Event OnOptionKeyMapChange(Int Option, Int keyCode, String conflictControl, String conflictName)
	bool Continue = True
	If (keyCode == 1)
		keyCode = 0
		conflictControl = ""
	endif
	If keyCode == 0
		keyCode = -1
		conflictControl = ""
	endif
	If (conflictControl != "")
		String msg
		If conflictName != ""
			msg = "$This key is already mapped to:\n'{" + conflictControl + "}'\n({" + conflictName + "})\n\nAre you sure you want to continue?"
		Else
			msg = "$This key is already mapped to:\n'{" + conflictControl + "}'\n\nAre you sure you want to continue?"
		endif
		Continue = ShowMessage(msg, True, "$Yes", "$No")
	endif		
	If !Continue
		return
	endif
	if Option == HKModifier_OID
		DOMKeys.modifierKey = keyCode
	elseif Option == HKModifierDefault_OID
		DOMKeys.modifierKeyDefault = keyCode
	elseif Option == HKMenu0_OID
		DOMKeys.menu0Key = keyCode
	elseif Option == HKMenu1_OID
		DOMKeys.menu1Key = keyCode
	elseif Option == HKMenu2_OID
		DOMKeys.menu2Key = keyCode
	elseif Option == HKMenu3_OID
		DOMKeys.menu3Key = keyCode
	elseif Option == HKMenu4_OID
		DOMKeys.menu4Key = keyCode
	elseif Option == HKMenu5_OID
		DOMKeys.menu5Key = keyCode
	elseif Option == HKMenu6_OID
		DOMKeys.menu6Key = keyCode
	elseif Option == HKMenu7_OID
		DOMKeys.menu7Key = keyCode
	elseif Option == HKMenu8_OID
		DOMKeys.menu8Key = keyCode
	elseif Option == HKMenu9_OID
		DOMKeys.menu9Key = keyCode
	elseif Option == HKMenu10_OID
		DOMKeys.menu10Key = keyCode
	elseif Option == HKAction_OID
		DOMKeys.ActionKey = keyCode
	elseif Option == HKDiary_OID
		DOMKeys.DiaryKey = keyCode
	elseif Option == HKTraits_OID
		DOMKeys.traitsKey = keyCode
	elseif Option == HKTraitsDigits_OID
		DOMKeys.traitsDigitsKey = keyCode
	elseif Option == HKFeels_OID
		DOMKeys.feelsKey = keyCode
	elseif Option == HKFeelsDigits_OID
		DOMKeys.feelsDigitsKey= keyCode
	elseif Option == HKStatus_OID
		DOMKeys.statusKey = keyCode
	elseif Option == HKMood_OID
		DOMKeys.moodKey = keyCode
	;elseif Option == HKMove_OID
	;	DOMKeys.moveKey = keyCode
	elseif Option == HKFollow_OID
		DOMKeys.followKey = keyCode
	elseif Option == HKFollowAll_OID
		DOMKeys.followAllKey = keyCode
	elseif Option == HKInventory_OID
		DOMKeys.inventoryKey = keyCode
	elseif Option == HKPraise_OID
		DOMKeys.praiseKey = keyCode
	elseif Option == HKScold_OID
		DOMKeys.scoldKey = keyCode
	elseif Option == HKPunish_OID
		DOMKeys.punishKey = keyCode
	elseif Option == HKChoke_OID
		DOMKeys.chokeKey = keyCode
	elseif Option == HKFavor_OID
		DOMKeys.favorKey = keyCode
	elseif Option == HKKneel_OID
		DOMKeys.kneelKey = keyCode
	elseif Option == HKAttention_OID
		DOMKeys.attentionKey = keyCode
	elseif Option == HKRipOff_OID
		DOMKeys.ripoffKey = keyCode
	elseif Option == HKStrip_OID
		DOMKeys.stripKey = keyCode
	elseif Option == HKCome_OID
		DOMKeys.comeKey = keyCode
	elseif Option == HKAbduction_OID
		DOMKeys.abductionKey = keyCode
	elseif Option == HKFixme_OID
		DOMKeys.fixmeKey = keyCode
	elseif Option == HKTest_OID
		DOMKeys.testPoseKey = keyCode
	elseif Option == HKBagIn_OID
		DOMKeys.bagInKey = keyCode
	elseif Option == HKBagOut_OID
		DOMKeys.bagOutKey = keyCode
	endif
	SetKeymapOptionValue(Option, keyCode)
	DOMKeys.refreshKeys()
EndEvent

Function CloseMessage()
	ShowMessage("$Close all menus to continue...", false)
	wait(0.1)
EndFunction

DOM_Actor displayedActor = None
Actor displayedNPC = None
Function DoActorRosterPage(Int option)
	Actor akRef = displayedNPC
	DOM_Mind akMind = None
	if displayedActor != None && displayedActor.akRef != None
		 akRef  = displayedActor.akRef
		 akMind = displayedActor.mind
	endif
	LogTrace("DoActorRosterPage: option="+option+" akRef="+akRef)
	LogTrace("DoActorRosterPage: displayedNPC="+displayedNPC+" displayedActor="+displayedActor)
	if akRef != None
	If (option == actorEssential_OID)
		if akRef.IsEssential()
			akRef.GetLeveledActorBase().SetInvulnerable(false)
			akRef.GetLeveledActorBase().SetEssential(false)
		else
			akRef.GetLeveledActorBase().SetEssential(true)
		endif					
	elseIf (option == actorFightForPlayer_OID)
		bool is_should = akRef.IsInFaction(DOMCore.DOMShouldFightForPlayer)
		if akMind != None
			akMind.should_fight_for_player = !is_should
		else
			SetBoolFaction(akRef, DOMCore.DOMShouldFightForPlayer, !is_should)
		endif
	elseIf (option == actorHoldWeapons_OID)
		bool is_should = akRef.IsInFaction(DOMCore.DOMShouldHoldWeapons)
		if akMind != None
			akMind.should_hold_weapons = !is_should
		else
			SetBoolFaction(akRef, DOMCore.DOMShouldHoldWeapons, !is_should)
		endif
	elseIf (option == actorWearArmor_OID)
		bool is_should = akRef.IsInFaction(DOMCore.DOMShouldWearArmor)
		if akMind != None
			akMind.should_wear_armor = !is_should
		else
			SetBoolFaction(akRef, DOMCore.DOMShouldWearArmor, !is_should)
		endif
	elseIf (option == actorBeNaked_OID)
		bool is_should = akRef.IsInFaction(DOMCore.DOMShouldBeNaked)
		if akMind != None
			akMind.should_be_naked = !is_should
		else
			SetBoolFaction(akRef, DOMCore.DOMShouldBeNaked, !is_should)
		endif
	elseIf (option == actorBeRespectful_OID)
		bool is_should = akRef.IsInFaction(DOMCore.DOMShouldBeRespectful)
		if akMind != None
			akMind.should_be_respectful = !is_should
		else
			SetBoolFaction(akRef, DOMCore.DOMShouldBeRespectful, !is_should)
		endif
	elseIf (option == actorBeSilent_OID)
		bool is_should = akRef.IsInFaction(DOMCore.DOMShouldBeSilent)
		if akMind != None
			akMind.should_be_silent = !is_should
		else
			SetBoolFaction(akRef, DOMCore.DOMShouldBeSilent, !is_should)
		endif
	elseIf (option == actorNoOrgasm_OID)
		bool is_should = akRef.IsInFaction(DOMCore.DOMShouldBeNoOrgasm)
		if akMind != None
			akMind.should_be_noorgasm = !is_should
		else
			SetBoolFaction(akRef, DOMCore.DOMShouldBeNoOrgasm, !is_should)
		endif
	elseIf (option == actorWalkOnFour_OID)
		bool is_should = akRef.IsInFaction(DOMCore.DOMShouldWalkOnFour)
		if akMind != None
			akMind.should_walk_on_four = !is_should
		else
			SetBoolFaction(akRef, DOMCore.DOMShouldWalkOnFour, !is_should)
		endif
	elseIf (option == actorThrall_OID)
		if !akRef.IsInFaction(DOMCore.DLC1ThrallFaction)
			akRef.SetFactionRank(DOMCore.DLC1ThrallFaction,1)
		elseif akRef.IsInFaction(DOMCore.DLC1ThrallFaction)
			akRef.RemoveFromFaction(DOMCore.DLC1ThrallFaction)
		endif
		; unless not
		if displayedActor && displayedActor.has_mouth_gag
			if akRef.IsInFaction(DOMCore.DLC1ThrallFaction) && (akRef.GetVoiceType() == DOMCore.MaleNord || akRef.GetVoiceType() == DOMCore.FemaleNord)
				akRef.RemoveFromFaction(DOMCore.DLC1ThrallFaction)
			endif
		endif
	elseif (option == actorSummon_OID)
		akRef.moveTo(PlayerRef)
	elseif (option == actorSummonBag_OID)
		if displayedActor != None && displayedActor.the_bag_iam_in != None
			displayedActor.the_bag_iam_in.moveTo(PlayerRef,afZOffset = 10.0)
		endif
	elseif (option == actorResetDiary_OID)
		if displayedActor != None
			displayedActor.mind.MergeMemories()
			displayedActor.mind.ResetTextMemories()
		endif
	elseif (option == actorRelease_OID)
		if displayedActor != None
			DOMCore.ReleaseActor(displayedActor.akRef)
		endif
	elseif (option == actorFixTats_OID)
		if displayedActor != None
			displayedActor.ResetTats()
			SlaveTats.synchronize_tattoos(displayedActor.akRef)
		else
			SlaveTats.synchronize_tattoos(akRef)
		endif
	elseif (option == actorFixme_OID)
		if displayedActor != None
			displayedActor.SpecialReset()
			displayedActor.RestartBehaviour()
		else
			DOMKeys.SpecialReset(akRef)
		endif
	elseif (option == actorRemoveSpells_OID)
		SetTextOptionValue(actorRemoveSpells_OID, "Removing spells ", false)
		if ShowMessage("Remove all learnt spells from actor?")
			int n = DOMKeys.DOMDoClearActorSpells(akRef)
			if n >= 0
				Debug.MessageBox("Removed "+n+" spells from actor "+akref.GetDisplayName())
			endif
		endif
	elseif (option == actorRemoveBaseSpells_OID)
		SetTextOptionValue(actorRemoveSpells_OID, "Removing spells ", false)
		if ShowMessage("Remove all base spells from actor?")
			int n = DOMKeys.DOMDoClearActorBaseSpells(akRef)
			if n >= 0
				Debug.MessageBox("Removed "+n+" base spells from actor "+akref.GetDisplayName())
			endif
		endif
	elseif (option == actorRead_OID)
		SetTextOptionValue(actorRead_OID, "Importing values ", false)
		If ShowMessage("Import personality values from JSON file?")
			If displayedActor != None
				DOMGenerator.ReadJSON(displayedActor)
			Else
				DOMGenerator.ReadActorJSON(akRef)
			endif
		endif
	elseif (option == actorWrite_OID)
		SetTextOptionValue(actorWrite_OID, "Exporting values ", false)
		If ShowMessage("Export personality values to JSON file?")
			If displayedActor != None
				DOMGenerator.WriteJSON(displayedActor)
			Else
				DOMGenerator.WriteActorJSON(akRef)
			endif
		endif
	else
		currentActor_OID = option
	endif
	else
		currentActor_OID = option
	endif

	ForcePageReset()
EndFunction

Function DoGenderPage(Int option)
	LogTrace("DoGenderPage")
	If (option == oppositeSexToggle_OID)
		DOMCore.oppositeSexToggle = !DOMCore.oppositeSexToggle
		if DOMCore.oppositeSexToggle
			DOM_OppositeSexTopics.SetValue(1)
		else
			DOM_OppositeSexTopics.SetValue(0)
		endif
		SetToggleOptionValue(oppositeSexToggle_OID, DOMCore.oppositeSexToggle)
	elseif (option == sameSexToggle_OID)
		DOMCore.sameSexToggle = !DOMCore.sameSexToggle
		if DOMCore.sameSexToggle
			DOM_sameSexTopics.SetValue(1)
		else
			DOM_sameSexTopics.SetValue(0)
		endif
		SetToggleOptionValue(sameSexToggle_OID, DOMCore.sameSexToggle)
	elseif (option == blushFToggle_OID)
		DOMCore.blushFToggle = !DOMCore.blushFToggle
		SetToggleOptionValue(blushFToggle_OID, DOMCore.blushFToggle)
	elseif (option == tearsFToggle_OID)
		DOMCore.tearsFToggle = !DOMCore.tearsFToggle
		SetToggleOptionValue(tearsFToggle_OID, DOMCore.tearsFToggle)
	elseif (option == masctFToggle_OID)
		DOMCore.masctFToggle = !DOMCore.masctFToggle
		SetToggleOptionValue(masctFToggle_OID, DOMCore.masctFToggle)
	elseif (option == blushMToggle_OID)
		DOMCore.blushMToggle = !DOMCore.blushMToggle
		SetToggleOptionValue(blushMToggle_OID, DOMCore.blushMToggle)
	elseif (option == tearsMToggle_OID)
		DOMCore.tearsMToggle = !DOMCore.tearsMToggle
		SetToggleOptionValue(tearsMToggle_OID, DOMCore.tearsMToggle)
	elseif (option == masctMToggle_OID)
		DOMCore.masctMToggle = !DOMCore.masctMToggle
		SetToggleOptionValue(masctMToggle_OID, DOMCore.masctMToggle)
	elseif (option == cryingPunishmentToggle_OID)
		DOMCore.cryingPunishmentToggle = !DOMCore.cryingPunishmentToggle
		SetToggleOptionValue(cryingPunishmentToggle_OID, DOMCore.cryingPunishmentToggle)
	elseif (option == cryingPraiseToggle_OID)
		DOMCore.cryingPraiseToggle = !DOMCore.cryingPraiseToggle
		SetToggleOptionValue(cryingPraiseToggle_OID, DOMCore.cryingPraiseToggle)
	elseif (option == virginOToggle_OID)
		DOMCore.virginOToggle = !DOMCore.virginOToggle
		SetToggleOptionValue(virginOToggle_OID, DOMCore.virginOToggle)
	elseif (option == virginAToggle_OID)
		DOMCore.virginAToggle = !DOMCore.virginAToggle
		SetToggleOptionValue(virginAToggle_OID, DOMCore.virginAToggle)
	elseif (option == virginVToggle_OID)
		DOMCore.virginVToggle = !DOMCore.virginVToggle
		SetToggleOptionValue(virginVToggle_OID, DOMCore.virginVToggle)
	elseif (option == virginSToggle_OID)
		DOMCore.virginSToggle = !DOMCore.virginSToggle
		SetToggleOptionValue(virginSToggle_OID, DOMCore.virginSToggle)
	elseif (option == virginGToggle_OID)
		DOMCore.virginGToggle = !DOMCore.virginGToggle
		SetToggleOptionValue(virginGToggle_OID, DOMCore.virginGToggle)
	elseif (option == startSexlabPreferablyPlayer_OID)
		if DOMCore.DOMOstim.DOM_HasOstim.GetValue() == 0
			DOMSexlab.startSexlabPreferablyPlayer = true
		elseif DOMSexlab.DOM_HasSexlab.GetValue() == 0
			DOMSexlab.startSexlabPreferablyPlayer = false
		else
			DOMSexlab.startSexlabPreferablyPlayer = !DOMSexlab.startSexlabPreferablyPlayer
			SetToggleOptionValue(startSexlabPreferablyPlayer_OID, DOMSexlab.startSexlabPreferablyPlayer)
		endif
	elseif (option == startSexlabPreferablyNPC_OID)
		if DOMCore.DOMOstim.DOM_HasOstim.GetValue() == 0
			DOMSexlab.startSexlabPreferablyNPC = true
		elseif DOMSexlab.DOM_HasSexlab.GetValue() == 0
			DOMSexlab.startSexlabPreferablyNPC = false
		else
			DOMSexlab.startSexlabPreferablyNPC = !DOMSexlab.startSexlabPreferablyNPC
			SetToggleOptionValue(startSexlabPreferablyNPC_OID, DOMSexlab.startSexlabPreferablyNPC)
		endif
	elseif (option == startSexlabPreferablyDOM_OID)
		if DOMCore.DOMOstim.DOM_HasOstim.GetValue() == 0
			DOMSexlab.startSexlabPreferablyDOM = true
		elseif DOMSexlab.DOM_HasSexlab.GetValue() == 0
			DOMSexlab.startSexlabPreferablyDOM = false
		else
			DOMSexlab.startSexlabPreferablyDOM = !DOMSexlab.startSexlabPreferablyDOM
			SetToggleOptionValue(startSexlabPreferablyDOM_OID, DOMSexlab.startSexlabPreferablyDOM)
		endif
	elseif (option == separateOrgasmToggle_OID)
		if Game.GetModByName("SLSO.esp") != 255
			DOMSexlab.separateOrgasmToggle = !DOMSexlab.separateOrgasmToggle
			SetToggleOptionValue(separateOrgasmToggle_OID, DOMSexlab.separateOrgasmToggle)
		else
			DOMSexlab.separateOrgasmToggle = false
			SetToggleOptionValue(separateOrgasmToggle_OID, DOMSexlab.separateOrgasmToggle)
		endif
	elseif (option == alwaysAggressiveToggle_OID)
		DOMSexlab.alwaysAggressiveToggle = !DOMSexlab.alwaysAggressiveToggle
		SetToggleOptionValue(alwaysAggressiveToggle_OID, DOMSexlab.alwaysAggressiveToggle)
	elseif (option == alwaysGentleToggle_OID)
		DOMSexlab.alwaysGentleToggle = !DOMSexlab.alwaysGentleToggle
		SetToggleOptionValue(alwaysGentleToggle_OID, DOMSexlab.alwaysGentleToggle)
	elseif (option == useAggressiveTag_OID)
		DOMSexlab.useAggressiveTag = !DOMSexlab.useAggressiveTag
		SetToggleOptionValue(useAggressiveTag_OID, DOMSexlab.useAggressiveTag)
	endif
EndFunction

Function DoKinksFemalePage(Int option)
	LogTrace("DoKinksFemalePage")
	int i = 0
	int n = 126
	while i < n
		if option == kinksFemale_OID[i]
			int idx = i + 1
			DOMCore.SetFilterKink(idx,1,!DOMCore.kinksFilterFemale[idx])
			SetToggleOptionValue(option, DOMCore.kinksFilterFemale[idx])
		endif
		i += 1
	endwhile
EndFunction

Function DoKinksMalePage(Int option)
	LogTrace("DoKinksMalePage")
	int i = 0
	int n = 126
	while i < n
		if option == kinksMale_OID[i]
			int idx = i + 1
			DOMCore.SetFilterKink(idx,0,!DOMCore.kinksFilterMale[idx])
			SetToggleOptionValue(option, DOMCore.kinksFilterMale[idx])
		endif
		i += 1
	endwhile
EndFunction

event OnOptionInputOpen(int a_option)
	LogTrace("OnOptionInputOpen")
	if (a_option == playerGender_OID && playerGender_OID != -1)
		string str_gender = displayedActor.GetGenderbyString()
		SetInputDialogStartText(str_gender)
		return
	elseif (a_option == playerTitle_OID && playerTitle_OID != -1)
		SetInputDialogStartText(DOMPlayerAlias.GetPlayerTitle())
		return
	elseif (a_option == actorName_OID && actorName_OID != -1)
		If displayedActor == None
			return
		endif
		SetInputDialogStartText(displayedActor.GetName())
		return
	elseif (a_option == actorGender_OID && actorGender_OID != -1)
		If displayedActor == None
			return
		endif
		string str_gender = displayedActor.GetGenderbyString()
		SetInputDialogStartText(str_gender)
		return
	elseif (a_option == actorTitle_OID && actorTitle_OID != -1)
		If displayedActor == None
			return
		endif
		SetInputDialogStartText(displayedActor.GetTitle())
		return
	elseif (a_option == actorPose_OID && actorPose_OID != -1)
		If displayedActor == None
			return
		endif
		SetInputDialogStartText(displayedActor.GetPose())
		return
	elseif (a_option == actorStrugglePose_OID && actorStrugglePose_OID != -1)
		If displayedActor == None
			return
		endif
		SetInputDialogStartText(displayedActor.GetStrugglePose())
		return
	elseif (a_option == attentionPose_OID && attentionPose_OID != -1)
		SetInputDialogStartText(DOMCore.attentionPose)
		return
	elseif (a_option == salutePose_OID && salutePose_OID != -1)
		SetInputDialogStartText(DOMCore.salutePose)
		return
	elseif (a_option == kneelPose_OID && kneelPose_OID != -1)
		SetInputDialogStartText(DOMCore.kneelPose)
		return
	elseif (a_option == actionName_OID && actionName_OID != -1)
		SetInputDialogStartText(DOMCore.actionName)
		return
	elseif (a_option == actionType_OID && actionType_OID != -1)
		SetInputDialogStartText(DOMCore.actionType)
		return
	elseif (a_option == spellPose1_OID && spellPose1_OID != -1)
		SetInputDialogStartText(DOMCore.spellPose1)
		return
	elseif (a_option == spellPose2_OID && spellPose2_OID != -1)
		SetInputDialogStartText(DOMCore.spellPose2)
		return
	endif
endEvent

event OnOptionInputAccept(int a_option, string a_input)
	if (a_option == playerGender_OID && playerGender_OID != -1)
		If a_input != ""
			DOMPlayerAlias.SetPlayerGenderByString(a_input)
		endif
		string str_gender = displayedActor.GetGenderbyString()
		SetInputOptionValue(a_option, str_gender)
		return
	elseif (a_option == playerTitle_OID && playerTitle_OID != -1)
		DOMPlayerAlias.SetPlayerTitleByString(a_input)
		SetInputOptionValue(a_option, DOMPlayerAlias.GetPlayerTitle())
		return
	elseif (a_option == actorName_OID && actorName_OID != -1)
		If displayedActor == None
			return
		endif
		If a_input != ""
			displayedActor.SetDisplayName(a_input)
			displayedActor.mind.SetDisplayName(a_input)
		endif
		SetInputOptionValue(a_option, displayedActor.getName())
		ForcePageReset()
		return
	elseif (a_option == actorGender_OID && actorGender_OID != -1)
		If displayedActor == None
			return
		endif
		displayedActor.SetGenderByString(a_input)
		displayedActor.mind.SetGenderByString(a_input)
		string str_gender = displayedActor.GetGenderbyString()
		SetInputOptionValue(a_option, str_gender)
		return
	elseif (a_option == actorTitle_OID && actorTitle_OID != -1)
		If displayedActor == None
			return
		endif
		displayedActor.SetTitle(a_input)
		displayedActor.mind.SetTitle(a_input)
		SetInputOptionValue(a_option, displayedActor.GetTitle())
		SetTextOptionValue(currentActor_OID, displayedActor.GetTitle())
		return
	elseif (a_option == actorPose_OID && actorPose_OID != -1)
		If displayedActor == None
			return
		endif
		displayedActor.SetQuietPose(a_input)
		SetInputOptionValue(a_option, displayedActor.GetPose())
		return
	elseif (a_option == actorStrugglePose_OID && actorStrugglePose_OID != -1)
		If displayedActor == None
			return
		endif
		displayedActor.SetStrugglePose(a_input)
		SetInputOptionValue(a_option, displayedActor.GetStrugglePose())
		return
	elseif (a_option == attentionPose_OID && attentionPose_OID != -1)
		DOMCore.attentionPose = a_input
		SetInputOptionValue(a_option, DOMCore.attentionPose)
		return
	elseif (a_option == salutePose_OID && salutePose_OID != -1)
		DOMCore.salutePose = a_input
		SetInputOptionValue(a_option, DOMCore.salutePose)
		return
	elseif (a_option == kneelPose_OID && kneelPose_OID != -1)
		DOMCore.kneelPose = a_input
		SetInputOptionValue(a_option, DOMCore.kneelPose)
		return
	elseif (a_option == actionName_OID && actionName_OID != -1)
		DOMCore.actionName = a_input
		SetInputOptionValue(a_option, DOMCore.actionName)
		return
	elseif (a_option == actionType_OID && actionType_OID != -1)
		DOMCore.actionType = a_input
		SetInputOptionValue(a_option, DOMCore.actionType)
		return
	elseif (a_option == spellPose1_OID && spellPose1_OID != -1)
		DOMCore.spellPose1 = a_input
		SetInputOptionValue(a_option, DOMCore.spellPose1)
		return
	elseif (a_option == spellPose2_OID && spellPose2_OID != -1)
		DOMCore.spellPose2 = a_input
		SetInputOptionValue(a_option, DOMCore.spellPose2)
		return
	endif
endEvent

Function DoCapturePage(Int option)
	;LogTrace("DoCapturePage")
	If (option == sendDOMCaptureEvent_OID)
		DOMCore.sendDOMCaptureEvent = !DOMCore.sendDOMCaptureEvent
		SetToggleOptionValue(sendDOMCaptureEvent_OID, DOMCore.sendDOMCaptureEvent)
	elseif (option == weaponsOToggle_OID)
		DOMCore.weaponsOToggle = !DOMCore.weaponsOToggle
		SetToggleOptionValue(weaponsOToggle_OID, DOMCore.weaponsOToggle)
	elseif (option == weaponsBToggle_OID)
		DOMCore.weaponsBToggle = !DOMCore.weaponsBToggle
		SetToggleOptionValue(weaponsBToggle_OID, DOMCore.weaponsBToggle)
	elseif (option == weaponsFToggle_OID)
		DOMCore.weaponsFToggle = !DOMCore.weaponsFToggle
		SetToggleOptionValue(weaponsFToggle_OID, DOMCore.weaponsFToggle)
	elseif (option == weaponsMToggle_OID)
		DOMCore.weaponsMToggle = !DOMCore.weaponsMToggle
		SetToggleOptionValue(weaponsMToggle_OID, DOMCore.weaponsMToggle)
	elseif (option == forbidAnimalCapture_OID)
		DOMkeys.forbidAnimalCapture = !DOMkeys.forbidAnimalCapture
		SetToggleOptionValue(forbidAnimalCapture_OID, DOMkeys.forbidAnimalCapture)
	elseif (option == forbidCreatureCapture_OID)
		DOMkeys.forbidCreatureCapture = !DOMkeys.forbidCreatureCapture
		SetToggleOptionValue(forbidCreatureCapture_OID, DOMkeys.forbidCreatureCapture)
	elseif (option == forbidUndeadCapture_OID)
		DOMkeys.forbidUndeadCapture = !DOMkeys.forbidUndeadCapture
		SetToggleOptionValue(forbidUndeadCapture_OID, DOMkeys.forbidUndeadCapture)
	elseif (option == setTransferNodeToggle_OID)
		DOMCore.setTransferNodeToggle = !DOMCore.setTransferNodeToggle
		SetToggleOptionValue(setTransferNodeToggle_OID, DOMCore.setTransferNodeToggle)
	elseif (option == setOBodyPresetToggleF_OID)
		DOMCore.setOBodyPresetToggleF = !DOMCore.setOBodyPresetToggleF
		SetToggleOptionValue(setOBodyPresetToggleF_OID, DOMCore.setOBodyPresetToggleF)
	elseif (option == setOBodyPresetToggleM_OID)
		DOMCore.setOBodyPresetToggleM = !DOMCore.setOBodyPresetToggleM
		SetToggleOptionValue(setOBodyPresetToggleM_OID, DOMCore.setOBodyPresetToggleM)
	elseif (option == cleanUniqueOutfit_OID)
		DOMEquip.cleanUniqueOutfit = !DOMEquip.cleanUniqueOutfit
		SetToggleOptionValue(cleanUniqueOutfit_OID, DOMEquip.cleanUniqueOutfit)
	elseif (option == cleanSpawnOutfit_OID)
		DOMEquip.cleanSpawnOutfit = !DOMEquip.cleanSpawnOutfit
		SetToggleOptionValue(cleanSpawnOutfit_OID, DOMEquip.cleanSpawnOutfit)
	elseif (option == cleanSlaverOutfit_OID)
		DOMEquip.cleanSlaverOutfit = !DOMEquip.cleanSlaverOutfit
		SetToggleOptionValue(cleanSlaverOutfit_OID, DOMEquip.cleanSlaverOutfit)
	elseif (option == restoreOutfitUnique_OID)
		DOMEquip.restoreOutfitUnique = !DOMEquip.restoreOutfitUnique
		SetToggleOptionValue(restoreOutfitUnique_OID, DOMEquip.restoreOutfitUnique)
	elseif (option == restoreOutfitSpawn_OID)
		DOMEquip.restoreOutfitSpawn = !DOMEquip.restoreOutfitSpawn
		SetToggleOptionValue(restoreOutfitSpawn_OID, DOMEquip.restoreOutfitSpawn)
	elseif (option == restoreOutfitAlways_OID)
		DOMEquip.restoreOutfitAlways = !DOMEquip.restoreOutfitAlways
		SetToggleOptionValue(restoreOutfitAlways_OID, DOMEquip.restoreOutfitAlways)
	elseif (option == renameToggle_OID)
		DOMCore.renameToggle = !DOMCore.renameToggle
		SetToggleOptionValue(renameToggle_OID, DOMCore.renameToggle)
	elseif (option == cloneUniqueMode_OID)
		DOMCore.cloneUniqueMode = !DOMCore.cloneUniqueMode
		SetToggleOptionValue(cloneUniqueMode_OID, DOMCore.cloneUniqueMode)
	elseif (option == cloneSpawnMode_OID)
		DOMCore.cloneSpawnMode = true; !DOMCore.cloneSpawnMode
		SetToggleOptionValue(cloneSpawnMode_OID, DOMCore.cloneSpawnMode)
	elseif (option == cleanFactionUnique_OID)
		DOMCore.cleanFactionUnique = !DOMCore.cleanFactionUnique
		SetToggleOptionValue(cleanFactionUnique_OID, DOMCore.cleanFactionUnique)
	elseif (option == cleanFactionSpawn_OID)
		DOMCore.cleanFactionSpawn = !DOMCore.cleanFactionSpawn
		SetToggleOptionValue(cleanFactionSpawn_OID, DOMCore.cleanFactionSpawn)
	elseif (option == writeJSONTransfer_OID)
		DOMGenerator.writeJSONTransfer = !DOMGenerator.writeJSONTransfer
		SetToggleOptionValue(writeJSONTransfer_OID, DOMGenerator.writeJSONTransfer)
	elseif (option == writeJSONRelease_OID)
		DOMGenerator.writeJSONRelease = !DOMGenerator.writeJSONRelease
		SetToggleOptionValue(writeJSONRelease_OID, DOMGenerator.writeJSONRelease)
	elseif (option == trainSexlabValuesToggle_OID)
		DOMCore.trainSexlabValuesToggle = !DOMCore.trainSexlabValuesToggle
		SetToggleOptionValue(trainSexlabValuesToggle_OID, DOMCore.trainSexlabValuesToggle)
	elseif (option == readSexlabValuesToggle_OID)
		DOMCore.readSexlabValuesToggle = !DOMCore.readSexlabValuesToggle
		SetToggleOptionValue(readSexlabValuesToggle_OID, DOMCore.readSexlabValuesToggle)
	elseif (option == VampireCattleToggle_OID)
		DOMCore.VampireCattleToggle = !DOMCore.VampireCattleToggle
		SetToggleOptionValue(VampireCattleToggle_OID, DOMCore.VampireCattleToggle)
	elseif (option == RemoveEssentialToggle_OID)
		DOMCore.RemoveEssentialToggle = !DOMCore.RemoveEssentialToggle
		SetToggleOptionValue(RemoveEssentialToggle_OID, DOMCore.RemoveEssentialToggle)
	elseif (option == SetEssentialToggle_OID)
		DOMCore.SetEssentialToggle = !DOMCore.SetEssentialToggle
		SetToggleOptionValue(SetEssentialToggle_OID, DOMCore.SetEssentialToggle)
	elseif (option == cleanCrimeFaction_OID)
		DOMCore.cleanCrimeFaction = !DOMCore.cleanCrimeFaction
		SetToggleOptionValue(cleanCrimeFaction_OID, DOMCore.cleanCrimeFaction)
	endif
EndFunction

Function DoHotkeysPage(Int option)
	LogTrace("DoHotkeysPage")
EndFunction

Function DoWheelPage(Int option)
	LogTrace("DoWheelPage")
	If (option == wheelIsDefaultMenu_OID)
		DOMKeys.wheelIsDefaultMenu = !DOMKeys.wheelIsDefaultMenu
		SetToggleOptionValue(wheelIsDefaultMenu_OID, DOMKeys.wheelIsDefaultMenu)
	elseif (option == wheelIsDefaultCall_OID)
		DOMKeys.wheelIsDefaultCall = !DOMKeys.wheelIsDefaultCall
		SetToggleOptionValue(wheelIsDefaultCall_OID, DOMKeys.wheelIsDefaultCall)
	elseif (option == wheelUsesDefaultPunishmentType_OID)
		DOMKeys.wheelUsesDefaultPunishmentType = !DOMKeys.wheelUsesDefaultPunishmentType
		SetToggleOptionValue(wheelUsesDefaultPunishmentType_OID, DOMKeys.wheelUsesDefaultPunishmentType)
	elseif (option == wheelUsesDefaultPraiseType_OID)
		DOMKeys.wheelUsesDefaultPraiseType = !DOMKeys.wheelUsesDefaultPraiseType
		SetToggleOptionValue(wheelUsesDefaultPraiseType_OID, DOMKeys.wheelUsesDefaultPraiseType)
	elseif (option == HKMenuPAH_OID)
		DOMKeys.menuPAH = !DOMKeys.menuPAH
		SetToggleOptionValue(HKMenuPAH_OID, DOMKeys.menuPAH)
	elseif (option == HKMenuExtraSlaves_OID)
		DOMKeys.menuExtraSlaves = !DOMKeys.menuExtraSlaves
		SetToggleOptionValue(HKMenuExtraSlaves_OID, DOMKeys.menuExtraSlaves)
	elseif (option == HKMenuSlavers_OID)
		DOMKeys.menuSlavers = !DOMKeys.menuSlavers
		SetToggleOptionValue(HKMenuSlavers_OID, DOMKeys.menuSlavers)
	elseif (option == actionGroup_OID)
		DOMCore.actionGroup = !DOMCore.actionGroup
		SetToggleOptionValue(actionGroup_OID, DOMCore.actionGroup)
	elseif (option == actionFlag_OID)
		DOMCore.actionFlag = !DOMCore.actionFlag
		SetToggleOptionValue(actionFlag_OID, DOMCore.actionFlag)
	endif
EndFunction

Function DoOptionsPage(Int option)
	LogTrace("DoOptionsPage")
	If (option == ExportSettings_OID)
		SetTextOptionValue(ExportSettings_OID, "$Exporting Settings ", false)
		If ShowMessage("$Overwrite settings file with your current settings?")
			SaveSettings()
			SetTextOptionValue(ExportSettings_OID, "$Done! ", false)
		Else
			SetTextOptionValue(ExportSettings_OID, "", false)
		endif
	elseif (option == resetAllDiary_OID)
		SetTextOptionValue(resetAllDiary_OID, "Reset diaries", false)
		If ShowMessage("Reset all slaves' diaries text")
			SetTextOptionValue(resetAllDiary_OID, "$Close MCM", false)
			CloseMessage()
			ResetAllDiaries()
		Else
			SetTextOptionValue(resetAllDiary_OID, "", false)
		endif
	elseif (option == resetAllmemories_OID)
		SetTextOptionValue(resetAllmemories_OID, "Reset memories", false)
		If ShowMessage("Reset all slaves' memories")
			SetTextOptionValue(resetAllmemories_OID, "$Close MCM", false)
			CloseMessage()
			ResetAllMemories()
		Else
			SetTextOptionValue(resetAllmemories_OID, "", false)
		endif
	elseif (option == ImportSettings_OID)
		SetTextOptionValue(ImportSettings_OID, "$Importing Settings ", false)
		If ShowMessage("$Overwrite your current settings with the settings saved to file?")
			LoadSettings()
			SetTextOptionValue(ImportSettings_OID, "$Done! ", false)
		Else
			SetTextOptionValue(ImportSettings_OID, "", false)
		endif
	elseif (option == slaveDiaryToggle_OID)
		DOM04.slaveDiaryToggle = !DOM04.slaveDiaryToggle
		SetToggleOptionValue(slaveDiaryToggle_OID, DOM04.slaveDiaryToggle)
	elseif (option == slaverDiaryToggle_OID)
		DOM04.slaverDiaryToggle = !DOM04.slaverDiaryToggle
		SetToggleOptionValue(slaverDiaryToggle_OID, DOM04.slaverDiaryToggle)
	elseif (option == activateDialogueFollow_OID)
		activateDialogueFollow = !activateDialogueFollow
		if activateDialogueFollow
			DOM_DeactivateDialogueFollow.SetValue(0)
		else
			DOM_DeactivateDialogueFollow.SetValue(1)
		endif
		SetToggleOptionValue(activateDialogueFollow_OID, activateDialogueFollow)
	elseif (option == activateDialogueForNPC_OID)
		activateDialogueForNPC = !activateDialogueForNPC
		if activateDialogueForNPC
			DOM_DeactivateDialogueForNPC.SetValue(0)
		else
			DOM_DeactivateDialogueForNPC.SetValue(1)
		endif
		SetToggleOptionValue(activateDialogueForNPC_OID, activateDialogueForNPC)
	elseif (option == activateDialogueForDOM_OID)
		activateDialogueForDOM = !activateDialogueForDOM
		if activateDialogueForDOM
			DOM_DeactivateDialogueForDOM.SetValue(0)
		else
			DOM_DeactivateDialogueForDOM.SetValue(1)
		endif
		SetToggleOptionValue(activateDialogueForDOM_OID, activateDialogueForDOM)
	elseif (option == allowSlavesGear_OID)
		DOMEquip.allowSlavesGearToggle = !DOMEquip.allowSlavesGearToggle
		SetToggleOptionValue(allowSlavesGear_OID, DOMEquip.allowSlavesGearToggle)
	elseif (option == allowSlaversGear_OID)
		DOMEquip.allowSlaversGearToggle = !DOMEquip.allowSlaversGearToggle
		SetToggleOptionValue(allowSlaversGear_OID, DOMEquip.allowSlaversGearToggle)
	endif
EndFunction

Function DoDebugPage(Int option)
	LogTrace("DoDebugPage")
	If (option == debugInit_OID)
		SetTextOptionValue(debugInit_OID, "$Close MCM", false)
		If ShowMessage("Initialize DOM Core")
			SetTextOptionValue(debugInit_OID, "$Close MCM", false)
			CloseMessage()
			DOMCore.OnPlayerLoadInit()
		Else
			SetTextOptionValue(debugInit_OID, "", false)
		endif
	elseif (option == StartupCheckActor_OID)
		DOMCore.StartupCheckActor = !DOMCore.StartupCheckActor
		SetToggleOptionValue(StartupCheckActor_OID, DOMCore.StartupCheckActor)
	elseif (option == debugMode_OID)
		DOMCore.debugMode = !DOMCore.debugMode
		SetToggleOptionValue(debugMode_OID, DOMCore.debugMode)
	elseif (option == debugKeyMode_OID)
		DOMKeys.debugKeyMode = !DOMKeys.debugKeyMode
		SetToggleOptionValue(debugKeyMode_OID, DOMKeys.debugKeyMode)
	elseif (option == printActorBonusesToggle_OID)
		DOMGenerator.printActorBonusesToggle = !DOMGenerator.printActorBonusesToggle
		SetToggleOptionValue(printActorBonusesToggle_OID, DOMGenerator.printActorBonusesToggle)
	elseif (option == verboseMode_OID)
		DOMCore.verboseMode = !DOMCore.verboseMode
		SetToggleOptionValue(verboseMode_OID, DOMCore.verboseMode)
	elseif (option == showKinksToggle_OID)
		DOMCore.showKinksToggle = !DOMCore.showKinksToggle
		SetToggleOptionValue(showKinksToggle_OID, DOMCore.showKinksToggle)
	elseif (option == removeSlavesSpells_OID)
		SetTextOptionValue(removeSlavesSpells_OID, "Removing spells ", false)
		if ShowMessage("Remove known spells from all slaves?")
			int n = DOM02.actorCounter
			int mt = 0
			int mb = 0
			int idx = 0
			while idx < n
				DOM_Actor akActor = DOM02.GetActorByIndex(idx)
				if akActor != None
					int kt = DOMKeys.DOMDoClearActorSpells(akActor.akRef)
					mt += kt
					int kb = DOMKeys.DOMDoClearActorSpells(akActor.akRef)
					mb += kb
				endif
				idx += 1
			endWhile
			if n >= 0
				Debug.MessageBox("Removed "+mt+" known and "+mb+" base spells from "+n+" slave actors")
			endif
		endif
	elseif (option == removeSlaversSpells_OID)
		SetTextOptionValue(removeSlaversSpells_OID, "Removing spells ", false)
		if ShowMessage("Remove known spells from all slavers?")
			int n = DOM01.actorCounter
			int mt = 0
			int mb = 0
			int idx = 0
			while idx < n
				DOM_Actor akActor = DOM01.GetActorByIndex(idx)
				if akActor != None
					int kt = DOMKeys.DOMDoClearActorSpells(akActor.akRef)
					mt += kt
					int kb = DOMKeys.DOMDoClearActorSpells(akActor.akRef)
					mb += kb
				endif
				idx += 1
			endWhile
			if n >= 0
				Debug.MessageBox("Removed "+mt+" known and "+mb+" base spells from "+n+" slaver actors")
			endif
		endif
	elseif (option == CaptureSyncTattoos_OID)
		DOMCore.CaptureSyncTattoos = !DOMCore.CaptureSyncTattoos
		SetToggleOptionValue(CaptureSyncTattoos_OID, DOMCore.CaptureSyncTattoos)
	elseif (option == StartupSyncTattoos_OID)
		DOMCore.StartupSyncTattoos = !DOMCore.StartupSyncTattoos
		SetToggleOptionValue(StartupSyncTattoos_OID, DOMCore.StartupSyncTattoos)
	elseif (option == verboseTopics_OID)
		DOMCore.verboseTopics = !DOMCore.verboseTopics
		SetToggleOptionValue(verboseTopics_OID, DOMCore.verboseTopics)
	elseif (option == wheelsUseVerboseMessage_OID)
		DOMCore.wheelsUseVerboseMessage = !DOMCore.wheelsUseVerboseMessage
		SetToggleOptionValue(wheelsUseVerboseMessage_OID, DOMCore.wheelsUseVerboseMessage)
	elseif (option == dialoguesUseVerboseMessage_OID)
		DOMCore.dialoguesUseVerboseMessage = !DOMCore.dialoguesUseVerboseMessage
		SetToggleOptionValue(dialoguesUseVerboseMessage_OID, DOMCore.dialoguesUseVerboseMessage)
	elseif (option == answerToggle_OID)
		DOMCore.answerToggle = !DOMCore.answerToggle
		SetToggleOptionValue(answerToggle_OID, DOMCore.answerToggle)
	elseif (option == marks_glow_status_OID)
		DOMCore.marks_glow_status = !DOMCore.marks_glow_status
		SetToggleOptionValue(marks_glow_status_OID, DOMCore.marks_glow_status)
	elseif (option == marks_gloss_OID)
		DOMCore.marks_gloss = !DOMCore.marks_gloss
		SetToggleOptionValue(marks_gloss_OID, DOMCore.marks_gloss)
	elseif (option == brand_glow_status_OID)
		DOMCore.brand_glow_status = !DOMCore.brand_glow_status
		SetToggleOptionValue(brand_glow_status_OID, DOMCore.brand_glow_status)
	elseif (option == brand_gloss_OID)
		DOMCore.brand_gloss = !DOMCore.brand_gloss
		SetToggleOptionValue(brand_gloss_OID, DOMCore.brand_gloss)
	elseif (option == topicsToggle_OID)
		DOMCore.topicsToggle = !DOMCore.topicsToggle
		SetToggleOptionValue(topicsToggle_OID, DOMCore.topicsToggle)
	elseif (option == singleTellToggle_OID)
		DOMCore.singleTellToggle = !DOMCore.singleTellToggle
		SetToggleOptionValue(singleTellToggle_OID, DOMCore.singleTellToggle)
	elseif (option == transferDOMtoPAHE_OID)
		SetTextOptionValue(transferDOMtoPAHE_OID, "$to PAHE... ", false)
		If ShowMessage("$Are you sure you want to transfer all DOM slaves to PAHE?")
			SetTextOptionValue(transferDOMtoPAHE_OID, "$Close MCM", false)
			CloseMessage()
			DOMPAH.TransferDOMtoPAHE()
		Else
			SetTextOptionValue(transferDOMtoPAHE_OID, "", false)
		endif
	elseif (option == transferPAHEtoDOM_OID)
		SetTextOptionValue(transferPAHEtoDOM_OID, "$to DOM... ", false)
		If ShowMessage("$Are you sure you want to transfer all PAHE slaves to DOM?")
			SetTextOptionValue(transferPAHEtoDOM_OID, "$Close MCM", false)
			CloseMessage()
			DOMPAH.TransferPAHEtoDOM()
		Else
			SetTextOptionValue(transferPAHEtoDOM_OID, "", false)
		endif
	;elseif (option == registerSexLab_OID)
	;	SetTextOptionValue(registerSexLab_OID, "$Register animations ", false)
	;	If ShowMessage("$Register Zaz and SLAL animations to SexLab")
	;		SetOptionFlags(registerSexLab_OID, a_flags = OPTION_FLAG_DISABLED, a_noUpdate = False)
	;		SetTextOptionValue(registerSexLab_OID, "$Close MCM", false)
	;		CloseMessage()
	;		RegisterAnimations()
	;	Else
	;		SetTextOptionValue(registerSexLab_OID, "", false)
	;	endif
	endif
EndFunction

Function DoPersonalityPage(Int option)
	LogTrace("DoPersonalityPage")
	If (option == RandomFlat_OID)
		DOMCore.RandomFlat = !DOMCore.RandomFlat
		SetToggleOptionValue(RandomFlat_OID, DOMCore.RandomFlat)
	elseif (option == staticTraitsMode_OID)
		DOMCore.staticTraitsMode = !DOMCore.staticTraitsMode
		SetToggleOptionValue(staticTraitsMode_OID, DOMCore.staticTraitsMode)
	elseif (option == staticTraitsChat_OID)
		DOMCore.staticTraitsChat = !DOMCore.staticTraitsChat
		SetToggleOptionValue(staticTraitsChat_OID, DOMCore.staticTraitsChat)
	elseif (option == escapeToggle_OID)
		DOMCore.escapeToggle = !DOMCore.escapeToggle
		SetToggleOptionValue(escapeToggle_OID, DOMCore.escapeToggle)
	elseif (option == resilienceToggle_OID)
		DOMCore.resilienceToggle = !DOMCore.resilienceToggle
		SetToggleOptionValue(resilienceToggle_OID, DOMCore.resilienceToggle)
	elseif (option == loyalToggle_OID)
		DOMCore.loyalToggle = !DOMCore.loyalToggle
		SetToggleOptionValue(loyalToggle_OID, DOMCore.loyalToggle)
	elseif (option == inloveToggle_OID)
		DOMCore.inloveToggle = !DOMCore.inloveToggle
		SetToggleOptionValue(inloveToggle_OID, DOMCore.inloveToggle)
	elseif (option == depressedToggle_OID)
		DOMCore.depressedToggle = !DOMCore.depressedToggle
		SetToggleOptionValue(depressedToggle_OID, DOMCore.depressedToggle)
	elseif (option == insecureToggle_OID)
		DOMCore.insecureToggle = !DOMCore.insecureToggle
		SetToggleOptionValue(insecureToggle_OID, DOMCore.insecureToggle)
	elseif (option == jealousyToggle_OID)
		DOMCore.jealousyToggle = !DOMCore.jealousyToggle
		SetToggleOptionValue(jealousyToggle_OID, DOMCore.jealousyToggle)
	elseif (option == greedToggle_OID)
		DOMCore.greedToggle = !DOMCore.greedToggle
		SetToggleOptionValue(greedToggle_OID, DOMCore.greedToggle)
	elseif (option == friendToggle_OID)
		DOMCore.friendToggle = !DOMCore.friendToggle
		SetToggleOptionValue(friendToggle_OID, DOMCore.friendToggle)
	elseif (option == friendPlayerToggle_OID)
		DOMCore.friendPlayerToggle = !DOMCore.friendPlayerToggle
		SetToggleOptionValue(friendPlayerToggle_OID, DOMCore.friendPlayerToggle)
	elseif (option == friendFollowToggle_OID)
		DOMCore.friendFollowToggle = !DOMCore.friendFollowToggle
		SetToggleOptionValue(friendFollowToggle_OID, DOMCore.friendFollowToggle)
	elseif (option == friendDistantToggle_OID)
		DOMCore.friendDistantToggle = !DOMCore.friendDistantToggle
		SetToggleOptionValue(friendDistantToggle_OID, DOMCore.friendDistantToggle)
	elseif (option == rivalryToggle_OID)
		DOMCore.rivalryToggle = !DOMCore.rivalryToggle
		SetToggleOptionValue(rivalryToggle_OID, DOMCore.rivalryToggle)		
	endif
EndFunction

Function DoAbusePage(Int option)
	LogTrace("DoAbusePage")
	If (option == removeCuffsToggle_OID)
		DOMCore.removeCuffsToggle = !DOMCore.removeCuffsToggle
		SetToggleOptionValue(removeCuffsToggle_OID, DOMCore.removeCuffsToggle)
	elseif (option == removeBlindfoldToggle_OID)
		DOMCore.removeBlindfoldToggle = !DOMCore.removeBlindfoldToggle
		SetToggleOptionValue(removeBlindfoldToggle_OID, DOMCore.removeBlindfoldToggle)
	elseif (option == removeGagToggle_OID)
		DOMCore.removeGagToggle = !DOMCore.removeGagToggle
		SetToggleOptionValue(removeGagToggle_OID, DOMCore.removeGagToggle)
	elseif (option == undressBeforeSex_OID)
		DOMSexlab.undressBeforeSex = !DOMSexlab.undressBeforeSex
		SetToggleOptionValue(undressBeforeSex_OID, DOMSexlab.undressBeforeSex)
	elseif (option == redressAfterSex_OID)
		DOMSexlab.redressAfterSex = !DOMSexlab.redressAfterSex
		SetToggleOptionValue(redressAfterSex_OID, DOMSexlab.redressAfterSex)
	elseif (option == doRipOffBeforeSex_OID)
		DOMSexlab.doRipOffBeforeSex = !DOMSexlab.doRipOffBeforeSex
		SetToggleOptionValue(doRipOffBeforeSex_OID, DOMSexlab.doRipOffBeforeSex)
	elseif (option == doAnimBeforeAndAfterSex_OID)
		DOMCore.doAnimBeforeAndAfterSex = !DOMCore.doAnimBeforeAndAfterSex
		SetToggleOptionValue(doAnimBeforeAndAfterSex_OID, DOMCore.doAnimBeforeAndAfterSex)
	elseif (option == sendDOMOrders_OID)
		DOMCore.sendDOMOrders = !DOMCore.sendDOMOrders
		SetToggleOptionValue(sendDOMOrders_OID, DOMCore.sendDOMOrders)
	elseif (option == sendDOMEvents_OID)
		DOMCore.sendDOMEvents = !DOMCore.sendDOMEvents
		SetToggleOptionValue(sendDOMEvents_OID, DOMCore.sendDOMEvents)
	elseif (option == UpdateCombatStrength_OID)
		DOMCore.UpdateCombatStrength = !DOMCore.UpdateCombatStrength
		SetToggleOptionValue(UpdateCombatStrength_OID, DOMCore.UpdateCombatStrength)
	elseif (option == useBiS_OID)
		DOMBath.useBiS = !DOMBath.useBiS
		SetToggleOptionValue(useBiS_OID, DOMBath.useBiS)
	elseif (option == cleanDeleteToggle_OID)
		DOMCore.cleanDeleteToggle = !DOMCore.cleanDeleteToggle
		SetToggleOptionValue(cleanDeleteToggle_OID, DOMCore.cleanDeleteToggle)
	elseif (option == cleanWeaponsToggle_OID)
		DOMCore.cleanWeaponsToggle = !DOMCore.cleanWeaponsToggle
		SetToggleOptionValue(cleanWeaponsToggle_OID, DOMCore.cleanWeaponsToggle)
	elseif (option == cleanArmorsToggle_OID)
		DOMCore.cleanArmorsToggle = !DOMCore.cleanArmorsToggle
		SetToggleOptionValue(cleanArmorsToggle_OID, DOMCore.cleanArmorsToggle)
	elseif (option == cleanAmmoToggle_OID)
		DOMCore.cleanAmmoToggle = !DOMCore.cleanAmmoToggle
		SetToggleOptionValue(cleanAmmoToggle_OID, DOMCore.cleanAmmoToggle)
	elseif (option == cleanBooksToggle_OID)
		DOMCore.cleanBooksToggle = !DOMCore.cleanBooksToggle
		SetToggleOptionValue(cleanBooksToggle_OID, DOMCore.cleanBooksToggle)
	elseif (option == cleanScrollsToggle_OID)
		DOMCore.cleanScrollsToggle = !DOMCore.cleanScrollsToggle
		SetToggleOptionValue(cleanScrollsToggle_OID, DOMCore.cleanScrollsToggle)
	elseif (option == fHitToggle_OID)
		DOMCore.fHitToggle = !DOMCore.fHitToggle
		SetToggleOptionValue(fHitToggle_OID, DOMCore.fHitToggle)
	elseif (option == sHitToggle_OID)
		DOMCore.sHitToggle = !DOMCore.sHitToggle
		SetToggleOptionValue(sHitToggle_OID, DOMCore.sHitToggle)
	endif
EndFunction

Function DoEquipmentPage(Int option)
	LogTrace("DoEquipmentPage")
	If (option == useStripKeywords_OID)
		DOMEquip.useStripKeywords = !DOMEquip.useStripKeywords
		SetToggleOptionValue(useStripKeywords_OID, DOMEquip.useStripKeywords)
	elseif (option == resetStripKeywords_OID)
		DOMEquip.resetStripKeywords = !DOMEquip.resetStripKeywords
		SetToggleOptionValue(resetStripKeywords_OID, DOMEquip.resetStripKeywords)
	elseif (option == stripAndDropToggle_OID)
		DOMEquip.stripAndDropToggle = !DOMEquip.stripAndDropToggle
		SetToggleOptionValue(stripAndDropToggle_OID, DOMEquip.stripAndDropToggle)
	elseif (option == stripDeleteToggle_OID)
		DOMEquip.stripDeleteToggle = !DOMEquip.stripDeleteToggle
		SetToggleOptionValue(stripDeleteToggle_OID, DOMEquip.stripDeleteToggle)
	elseif (option == stripLootToggle_OID)
		DOMEquip.stripLootToggle = !DOMEquip.stripLootToggle
		SetToggleOptionValue(stripLootToggle_OID, DOMEquip.stripLootToggle)
	elseif (option == stripItemsToggle_OID)
		DOMEquip.stripItemsToggle = !DOMEquip.stripItemsToggle
		SetToggleOptionValue(stripItemsToggle_OID, DOMEquip.stripItemsToggle)
	elseif (option == stripUnequippedToggle_OID)
		DOMEquip.stripUnequippedToggle = !DOMEquip.stripUnequippedToggle
		SetToggleOptionValue(stripUnequippedToggle_OID, DOMEquip.stripUnequippedToggle)
	elseif (option == neverStripFX_OID)
		DOMEquip.neverStripFX = !DOMEquip.neverStripFX
		SetToggleOptionValue(neverStripFX_OID, DOMEquip.neverStripFX)
	elseif (option == shameArea52_OID)
		DOMEquip.shameArea52 = !DOMEquip.shameArea52
		SetToggleOptionValue(shameArea52_OID, DOMEquip.shameArea52)
	elseif (option == maskPubicArea_OID)
		DOMEquip.maskPubicArea = !DOMEquip.maskPubicArea
		SetToggleOptionValue(maskPubicArea_OID, DOMEquip.maskPubicArea)
	elseif (option == maskFillHerUp_OID)
		DOMEquip.maskFillHerUp = !DOMEquip.maskFillHerUp
		SetToggleOptionValue(maskFillHerUp_OID, DOMEquip.maskFillHerUp)
	elseif (option == stripWeaponsToggle_OID)
		DOMEquip.stripWeaponsToggle = !DOMEquip.stripWeaponsToggle
		SetToggleOptionValue(stripWeaponsToggle_OID, DOMEquip.stripWeaponsToggle)
	elseif (option == stripShieldsToggle_OID)
		DOMEquip.stripShieldsToggle = !DOMEquip.stripShieldsToggle
		SetToggleOptionValue(stripShieldsToggle_OID, DOMEquip.stripShieldsToggle)
	elseif (option == stripHeelsToggle_OID)
		DOMEquip.stripHeelsToggle = !DOMEquip.stripHeelsToggle
		SetToggleOptionValue(stripHeelsToggle_OID, DOMEquip.stripHeelsToggle)
	elseif (option == stripUnderwearToggle_OID)
		DOMEquip.stripUnderwearToggle = !DOMEquip.stripUnderwearToggle
		SetToggleOptionValue(stripUnderwearToggle_OID, DOMEquip.stripUnderwearToggle)
	elseif (option == stripJewelryToggle_OID)
		DOMEquip.stripJewelryToggle = !DOMEquip.stripJewelryToggle
		SetToggleOptionValue(stripJewelryToggle_OID, DOMEquip.stripJewelryToggle)
	elseif (option == verboseEquip_OID)
		DOMEquip.verboseEquip = !DOMEquip.verboseEquip
		SetToggleOptionValue(verboseEquip_OID, DOMEquip.verboseEquip)
	elseif (option == sendDOMEquipEvent_OID)
		DOMEquip.sendDOMEquipEvent = !DOMEquip.sendDOMEquipEvent
		SetToggleOptionValue(sendDOMEquipEvent_OID, DOMEquip.sendDOMEquipEvent)
	elseif (option == itemEquipToggle_OID)
		DOMEquip.itemEquipToggle = !DOMEquip.itemEquipToggle
		SetToggleOptionValue(itemEquipToggle_OID, DOMEquip.itemEquipToggle)
	elseif (option == instantEquipToggle_OID)
		DOMEquip.instantEquipToggle = !DOMEquip.instantEquipToggle
		SetToggleOptionValue(instantEquipToggle_OID, DOMEquip.instantEquipToggle)
	elseif (option == instantUnEquipToggle_OID)
		DOMEquip.instantUnEquipToggle = !DOMEquip.instantUnEquipToggle
		SetToggleOptionValue(instantUnEquipToggle_OID, DOMEquip.instantUnEquipToggle)
	elseif (option == cellEquipToggle_OID)
		DOMEquip.cellEquipToggle = !DOMEquip.cellEquipToggle
		SetToggleOptionValue(cellEquipToggle_OID, DOMEquip.cellEquipToggle)
	elseif (option == locationEquipToggle_OID)
		DOMEquip.locationEquipToggle = !DOMEquip.locationEquipToggle
		SetToggleOptionValue(locationEquipToggle_OID, DOMEquip.locationEquipToggle)
	endif
EndFunction

Function DoPlayerPage(Int option)
	LogTrace("DoPlayerPage")
	If (option == playerSkillsMessageToggle_OID)
		DOMPlayerAlias.playerSkillsMessageToggle = !DOMPlayerAlias.playerSkillsMessageToggle
		SetToggleOptionValue(playerSkillsMessageToggle_OID, DOMPlayerAlias.playerSkillsMessageToggle)
	elseif (option == friendsPlayerToggle_OID)
		DOMCore.friendsPlayerToggle = !DOMCore.friendsPlayerToggle
		SetToggleOptionValue(friendsPlayerToggle_OID, DOMCore.friendsPlayerToggle)
	elseif (option == kinksPlayerSubToggle_OID)
		DOMCore.kinksPlayerSubToggle = !DOMCore.kinksPlayerSubToggle
		SetToggleOptionValue(kinksPlayerSubToggle_OID, DOMCore.kinksPlayerSubToggle)
	elseif (option == kinksPlayerDomToggle_OID)
		DOMCore.kinksPlayerDomToggle = !DOMCore.kinksPlayerDomToggle
		SetToggleOptionValue(kinksPlayerDomToggle_OID, DOMCore.kinksPlayerDomToggle)
	elseif (option == playerJournalToggle_OID)
		DOMPlayerAlias.playerJournalToggle = !DOMPlayerAlias.playerJournalToggle
		SetToggleOptionValue(playerJournalToggle_OID, DOMPlayerAlias.playerJournalToggle)
	elseif (option == playerLedgerToggle_OID)
		DOMPlayerAlias.playerLedgerToggle = !DOMPlayerAlias.playerLedgerToggle
		SetToggleOptionValue(playerLedgerToggle_OID, DOMPlayerAlias.playerLedgerToggle)
	elseif (option == playerDiaryToggle_OID)
		DOM04.playerDiaryToggle = !DOM04.playerDiaryToggle
		SetToggleOptionValue(playerDiaryToggle_OID, DOM04.playerDiaryToggle)
	elseif (option == addDiarySpell_OID)
		DOMCore.hasDiarySpell = !DOMCore.hasDiarySpell
		SetToggleOptionValue(addDiarySpell_OID, DOMCore.hasDiarySpell)
		DOMCore.RegisterSpells()
	elseif (option == addMenuSpell_OID)
		DOMCore.hasMenuSpell = !DOMCore.hasMenuSpell
		SetToggleOptionValue(addMenuSpell_OID, DOMCore.hasMenuSpell)
		DOMCore.RegisterSpells()
	elseif (option == addInfoSpell_OID)
		DOMCore.hasInfoSpell = !DOMCore.hasInfoSpell
		SetToggleOptionValue(addInfoSpell_OID, DOMCore.hasInfoSpell)
		DOMCore.RegisterSpells()
	elseif (option == addInfoPower_OID)
		DOMCore.hasInfoPower = !DOMCore.hasInfoPower
		SetToggleOptionValue(addInfoPower_OID, DOMCore.hasInfoPower)
		DOMCore.RegisterSpells()
	elseif (option == addMenuPower_OID)
		DOMCore.hasMenuPower = !DOMCore.hasMenuPower
		SetToggleOptionValue(addMenuPower_OID, DOMCore.hasMenuPower)
		DOMCore.RegisterSpells()
	elseif (option == addAbductionSpell_OID)
		DOMCore.hasAbductionSpell = !DOMCore.hasAbductionSpell
		SetToggleOptionValue(addAbductionSpell_OID, DOMCore.hasAbductionSpell)
		DOMCore.RegisterSpells()
	elseif (option == addWakeUpPerk_OID)
		DOMCore.hasWakeUpPerk = !DOMCore.hasWakeUpPerk
		SetToggleOptionValue(addWakeUpPerk_OID, DOMCore.hasWakeUpPerk)
		DOMCore.RegisterPerks()
	elseif (option == addBurlapSackPerk_OID)
		DOMCore.hasBurlapSackPerk = !DOMCore.hasBurlapSackPerk
		SetToggleOptionValue(addBurlapSackPerk_OID, DOMCore.hasBurlapSackPerk)
		DOMCore.RegisterPerks()
	elseif (option == addAbductionPerk_OID)
		DOMCore.hasAbductionPerk = !DOMCore.hasAbductionPerk
		SetToggleOptionValue(addAbductionPerk_OID, DOMCore.hasAbductionPerk)
		DOMCore.RegisterPerks()
	elseif (option == addRecruitPerk_OID)
		DOMCore.hasRecruitPerk = !DOMCore.hasRecruitPerk
		SetToggleOptionValue(addRecruitPerk_OID, DOMCore.hasRecruitPerk)
		DOMCore.RegisterPerks()
	elseif (option == activateCombatAbduction_OID)
		activateCombatAbduction = !activateCombatAbduction
		SetToggleOptionValue(activateCombatAbduction_OID, activateCombatAbduction)
		if activateCombatAbduction
			DOM_ActivateCombatAbduction.SetValue(1)
		else
			DOM_ActivateCombatAbduction.SetValue(0)
		endif
	elseif (option == activateCombatRecruit_OID)
		activateCombatRecruit = !activateCombatRecruit
		SetToggleOptionValue(activateCombatRecruit_OID, activateCombatRecruit)
		if activateCombatRecruit
			DOM_ActivateCombatRecruit.SetValue(1)
		else
			DOM_ActivateCombatRecruit.SetValue(0)
		endif
	elseif (option == addSlapTool_OID)
		DOMCore.hasSlapTool = !DOMCore.hasSlapTool
		SetToggleOptionValue(addSlapTool_OID, DOMCore.hasSlapTool)
		DOMCore.CheckPlayersEquipment()
	elseif (option == doAnimPlayerTieup_OID)
		DOMCore.doAnimPlayerTieup = !DOMCore.doAnimPlayerTieup
		SetToggleOptionValue(doAnimPlayerTieup_OID, DOMCore.doAnimPlayerTieup)
	elseif (option == doPlayerIdle_OID)
		DOMCore.doPlayerIdle = !DOMCore.doPlayerIdle
		SetToggleOptionValue(doPlayerIdle_OID, DOMCore.doPlayerIdle)
	elseif (option == alwaysRandomizeAnimations_OID)
		DOM_Anim.alwaysRandomizeAnimations = !DOM_Anim.alwaysRandomizeAnimations
		SetToggleOptionValue(alwaysRandomizeAnimations_OID, DOM_Anim.alwaysRandomizeAnimations)
	elseif (option == doAnimateAtActorLocation_OID)
		DOM_Anim.doAnimateAtActorLocation = !DOM_Anim.doAnimateAtActorLocation
		SetToggleOptionValue(doAnimateAtActorLocation_OID, DOM_Anim.doAnimateAtActorLocation)
	elseif (option == doPlayerAnim_OID)
		DOM_Anim.doPlayerAnim = !DOM_Anim.doPlayerAnim
		SetToggleOptionValue(doPlayerAnim_OID, DOM_Anim.doPlayerAnim)
	elseif (option == doFreeCamera_OID)
		DOM_Anim.doFreeCamera = !DOM_Anim.doFreeCamera
		SetToggleOptionValue(doFreeCamera_OID, DOM_Anim.doFreeCamera)
	elseif (option == summonPAHToggle_OID)
		DOMCore.summonPAHToggle = !DOMCore.summonPAHToggle
		SetToggleOptionValue(summonPAHToggle_OID, DOMCore.summonPAHToggle)
	elseif (option == summonPosingToggle_OID)
		DOMCore.summonPosingToggle = !DOMCore.summonPosingToggle
		SetToggleOptionValue(summonPosingToggle_OID, DOMCore.summonPosingToggle)
	elseif (option == equipSlaver_OID)
		SetTextOptionValue(equipSlaver_OID, "$Get slaver's equipment", false)
		If ShowMessage("$Equip your character with a whip and slaver's weapons")
			SetTextOptionValue(equipSlaver_OID, "$Close MCM", false)
			CloseMessage()
			GetSlaverEquipment()
		Else
			SetTextOptionValue(equipSlaver_OID, "", false)
		endif
	endif
EndFunction

Function DoNPCsPage(Int option)
	LogTrace("DoNPCsPage")
	if (option == seedUniques_OID)
		DOMCore.seedUniques = !DOMCore.seedUniques
		SetToggleOptionValue(seedUniques_OID, DOMCore.seedUniques)
	elseif (option == tieupWhenUnBagToggle_OID)
		DOMKeys.tieupWhenUnBagToggle = !DOMKeys.tieupWhenUnBagToggle
		SetToggleOptionValue(tieupWhenUnBagToggle_OID, DOMKeys.tieupWhenUnBagToggle)
	elseif (option == alarmToggleAbduction2_OID)
		DOMKeys.alarmToggleAbduction2 = !DOMKeys.alarmToggleAbduction2
		SetToggleOptionValue(alarmToggleAbduction2_OID, DOMKeys.alarmToggleAbduction2)
	elseif (option == alarmToggleAbduction_OID)
		DOMKeys.alarmToggleAbduction = !DOMKeys.alarmToggleAbduction
		SetToggleOptionValue(alarmToggleAbduction_OID, DOMKeys.alarmToggleAbduction)
	elseif (option == alarmToggleWitness2_OID)
		DOMKeys.alarmToggleWitness2 = !DOMKeys.alarmToggleWitness2
		SetToggleOptionValue(alarmToggleWitness2_OID, DOMKeys.alarmToggleWitness2)
	elseif (option == alarmToggleWitness3_OID)
		DOMKeys.alarmToggleWitness3 = !DOMKeys.alarmToggleWitness3
		SetToggleOptionValue(alarmToggleWitness3_OID, DOMKeys.alarmToggleWitness3)
	elseif (option == alarmToggleWitness_OID)
		DOMKeys.alarmToggleWitness = !DOMKeys.alarmToggleWitness
		SetToggleOptionValue(alarmToggleWitness_OID, DOMKeys.alarmToggleWitness)
	elseif (option == alarmToggleRunaway_OID)
		DOMCore.alarmToggleRunaway = !DOMCore.alarmToggleRunaway
		SetToggleOptionValue(alarmToggleRunaway_OID, DOMCore.alarmToggleRunaway)
	elseif (option == hugWhenFreedToggle_OID)
		DOMCore.hugWhenFreedToggle = !DOMCore.hugWhenFreedToggle
		SetToggleOptionValue(hugWhenFreedToggle_OID, DOMCore.hugWhenFreedToggle)
	elseif (option == familyToggle_OID)
		DOMCore.familyToggle = !DOMCore.familyToggle
		SetToggleOptionValue(familyToggle_OID, DOMCore.familyToggle)
	elseif (option == phhshUseSLAL_OID)
		HSHQuest.SLAL.phhshUseSLAL = !HSHQuest.SLAL.phhshUseSLAL
		SetToggleOptionValue(phhshUseSLAL_OID, HSHQuest.SLAL.phhshUseSLAL)
	elseif (option == ReadJSONTraitsWarning_OID)
		DOMGenerator.ReadJSONTraitsWarning = !DOMGenerator.ReadJSONTraitsWarning
		SetToggleOptionValue(ReadJSONTraitsWarning_OID, DOMGenerator.ReadJSONTraitsWarning)
	elseif (option == ReadJSONTraitsToggle_OID)
		DOMGenerator.ReadJSONTraitsToggle = !DOMGenerator.ReadJSONTraitsToggle
		SetToggleOptionValue(ReadJSONTraitsToggle_OID, DOMGenerator.ReadJSONTraitsToggle)
	elseif (option == ReadJSONRelationshipToggle_OID)
		DOMGenerator.ReadJSONRelationshipToggle = !DOMGenerator.ReadJSONRelationshipToggle
		SetToggleOptionValue(ReadJSONRelationshipToggle_OID, DOMGenerator.ReadJSONRelationshipToggle)
	elseif (option == ReadJSONVirginityToggle_OID)
		DOMGenerator.ReadJSONVirginityToggle = !DOMGenerator.ReadJSONVirginityToggle
		SetToggleOptionValue(ReadJSONVirginityToggle_OID, DOMGenerator.ReadJSONVirginityToggle)
	elseif (option == ReadJSONTrainingToggle_OID)
		DOMGenerator.ReadJSONTrainingToggle = !DOMGenerator.ReadJSONTrainingToggle
		SetToggleOptionValue(ReadJSONTrainingToggle_OID, DOMGenerator.ReadJSONTrainingToggle)
	elseif (option == ReadJSONKinksToggle_OID)
		DOMGenerator.ReadJSONKinksToggle = !DOMGenerator.ReadJSONKinksToggle
		SetToggleOptionValue(ReadJSONKinksToggle_OID, DOMGenerator.ReadJSONKinksToggle)
	elseif (option == ReadJSONMemoriesToggle_OID)
		DOMGenerator.ReadJSONMemoriesToggle = !DOMGenerator.ReadJSONMemoriesToggle
		SetToggleOptionValue(ReadJSONMemoriesToggle_OID, DOMGenerator.ReadJSONMemoriesToggle)
	elseif (option == readJSONForUniques_OID)
		DOMGenerator.readJSONForUniques = !DOMGenerator.readJSONForUniques
		SetToggleOptionValue(readJSONForUniques_OID, DOMGenerator.readJSONForUniques)
	elseif (option == readJSONForSpawned_OID)
		DOMGenerator.readJSONForSpawned = !DOMGenerator.readJSONForSpawned
		SetToggleOptionValue(readJSONForSpawned_OID, DOMGenerator.readJSONForSpawned)
	endif
EndFunction

Function DoNotificationsPage(Int option)
	LogTrace("DoNotificationsPage")
	If (option == wMessageToggle_OID)
		DOMCore.wMessageToggle = !DOMCore.wMessageToggle
		SetToggleOptionValue(wMessageToggle_OID, DOMCore.wMessageToggle)
	elseif (option == wMessageLevel0_OID)
		DOMCore.wMessageLevel0 = !DOMCore.wMessageLevel0
		SetToggleOptionValue(wMessageLevel0_OID, DOMCore.wMessageLevel0)
	elseif (option == wMessageLevel1_OID)
		DOMCore.wMessageLevel1 = !DOMCore.wMessageLevel1
		SetToggleOptionValue(wMessageLevel1_OID, DOMCore.wMessageLevel1)
	elseif (option == wMessageLevel2_OID)
		DOMCore.wMessageLevel2 = !DOMCore.wMessageLevel2
		SetToggleOptionValue(wMessageLevel2_OID, DOMCore.wMessageLevel2)
	elseif (option == wMessageLevel3_OID)
		DOMCore.wMessageLevel3 = !DOMCore.wMessageLevel3
		SetToggleOptionValue(wMessageLevel3_OID, DOMCore.wMessageLevel3)
	elseif (option == wMessageLevel4_OID)
		DOMCore.wMessageLevel4 = !DOMCore.wMessageLevel4
		SetToggleOptionValue(wMessageLevel4_OID, DOMCore.wMessageLevel4)
	elseif (option == wMessageLevel5_OID)
		DOMCore.wMessageLevel5 = !DOMCore.wMessageLevel5
		SetToggleOptionValue(wMessageLevel5_OID, DOMCore.wMessageLevel5)
	elseif (option == clearWidgets_OID)
		SetTextOptionValue(clearWidgets_OID, "Clear widgets", false)
		If ShowMessage("Clear actors/widgets associations?")
			SetTextOptionValue(clearWidgets_OID, "$Close MCM", false)
			CloseMessage()
			DOMCore.ClearWidgetSections()
		Else
			SetTextOptionValue(clearWidgets_OID, "", false)
		endif
	endif
EndFunction


event OnOptionColorOpen(int option)
	if option == marks_color_OID
		SetColorDialogStartColor(DOMCore.marks_color)
		SetColorDialogDefaultColor(0x000000) ; black
		return
	endif
	if option == marks_glow_OID
		SetColorDialogStartColor(DOMCore.marks_glow)
		SetColorDialogDefaultColor(0x000000) ; black
		return
	endif
	if option == brand_color_OID
		SetColorDialogStartColor(DOMCore.brand_color)
		SetColorDialogDefaultColor(0x000000) ; black
		return
	endif
	if option == brand_glow_OID
		SetColorDialogStartColor(DOMCore.brand_glow)
		SetColorDialogDefaultColor(0x000000) ; black
		return
	endif
	int i = 0
	int n = widgetColor_OID.length
	while i < n && i < DOMCore.widgetColor.length
		if (option == widgetColor_OID[i])
			SetColorDialogStartColor(DOMCore.widgetColor[i])
			SetColorDialogDefaultColor(0x7FBFFC) ; blue
			return
		endif
	endwhile
endEvent

event OnOptionColorAccept(int option, int color)
	if option == marks_color_OID
		DOMCore.marks_color = color
		SetColorOptionValue(option, color)
		return
	endif
	if option == marks_glow_OID
		DOMCore.marks_glow = color
		SetColorOptionValue(option, color)
		return
	endif
	if option == brand_color_OID
		DOMCore.brand_color = color
		SetColorOptionValue(option, color)
		return
	endif
	if option == brand_glow_OID
		DOMCore.brand_glow = color
		SetColorOptionValue(option, color)
		return
	endif
	int i = 0
	int n = widgetColor_OID.length
	while i < n && i < DOMCore.widgetColor.length
		if (option == widgetColor_OID[i])
			DOMCore.widgetColor[i] = color
			SetColorOptionValue(option, color)
			DOMCore.MessageWidgets[i].UpdateWidgetTextColor(color)
			return
		endif
	endwhile
endEvent

;
Function DoIdlesPage(Int option)
	LogTrace("DoIdlesPage")
	If (option == attentionPoseOn_OID)
		DOMCore.attentionPoseOn = !DOMCore.attentionPoseOn
		SetToggleOptionValue(attentionPoseOn_OID, DOMCore.attentionPoseOn)
	elseif (option == salutePoseOn_OID)
		DOMCore.salutePoseOn = !DOMCore.salutePoseOn
		SetToggleOptionValue(salutePoseOn_OID, DOMCore.salutePoseOn)
	elseif (option == kneelPoseOn_OID)
		DOMCore.kneelPoseOn = !DOMCore.kneelPoseOn
		SetToggleOptionValue(kneelPoseOn_OID, DOMCore.kneelPoseOn)
	elseif (option == travelCuffsToggle_OID)
		DOMCore.travelCuffsToggle = !DOMCore.travelCuffsToggle
		SetToggleOptionValue(travelCuffsToggle_OID, DOMCore.travelCuffsToggle)
	elseif (option == punishPoseToggle_OID)
		DOMCore.punishPoseToggle = !DOMCore.punishPoseToggle
		SetToggleOptionValue(punishPoseToggle_OID, DOMCore.punishPoseToggle)
	elseif (option == punishTieToggle_OID)
		DOMCore.punishTieToggle = !DOMCore.punishTieToggle
		SetToggleOptionValue(punishTieToggle_OID, DOMCore.punishTieToggle)
	elseif (option == punishMasturbateToggle_OID)
		DOMCore.punishMasturbateToggle = !DOMCore.punishMasturbateToggle
		SetToggleOptionValue(punishMasturbateToggle_OID, DOMCore.punishMasturbateToggle)
	elseif (option == punishRestrainToggle_OID)
		DOMCore.punishRestrainToggle = !DOMCore.punishRestrainToggle
		SetToggleOptionValue(punishRestrainToggle_OID, DOMCore.punishRestrainToggle)
	elseif (option == GroupChoiceRandom_OID)
		DOMCore.GroupChoiceRandom = !DOMCore.GroupChoiceRandom
		SetToggleOptionValue(GroupChoiceRandom_OID, DOMCore.GroupChoiceRandom)
	elseif (option == GroupChoicePose_OID)
		DOMCore.GroupChoicePose = !DOMCore.GroupChoicePose
		SetToggleOptionValue(GroupChoicePose_OID, DOMCore.GroupChoicePose)
	elseif (option == checkInteriorPosesToggle_OID)
		DOMCore.checkInteriorPosesToggle = !DOMCore.checkInteriorPosesToggle
		SetToggleOptionValue(checkInteriorPosesToggle_OID, DOMCore.checkInteriorPosesToggle)
	elseif (option == poseMoveToggle_OID)
		DOMCore.ResetPoseMarkers()
		DOMCore.poseMoveToggle = !DOMCore.poseMoveToggle
		SetToggleOptionValue(poseMoveToggle_OID, DOMCore.poseMoveToggle)
	elseif (option == verboseAnim_OID)
		DOMCore.verboseAnim = !DOMCore.verboseAnim
		SetToggleOptionValue(verboseAnim_OID, DOMCore.verboseAnim)
	elseif (option == requireSLTags_OID)
		DOMSexlab.requireSLTags = !DOMSexlab.requireSLTags
		SetToggleOptionValue(requireSLTags_OID, DOMSexlab.requireSLTags)
	elseif (option == requireSLTags4_OID)
		DOMSexlab.requireSLTags4 = !DOMSexlab.requireSLTags4
		SetToggleOptionValue(requireSLTags4_OID, DOMSexlab.requireSLTags4)
	elseif (option == requireSLTags3_OID)
		DOMSexlab.requireSLTags3 = !DOMSexlab.requireSLTags3
		SetToggleOptionValue(requireSLTags3_OID, DOMSexlab.requireSLTags3)
	elseif (option == doRemoveHeels_OID)
		DOM_Anim.doRemoveHeels = !DOM_Anim.doRemoveHeels
		SetToggleOptionValue(doRemoveHeels_OID, DOM_Anim.doRemoveHeels)
	elseif (option == rescaleAnimToggle_OID)
		DOM_Anim.doRescale = !DOM_Anim.doRescale
		SetToggleOptionValue(rescaleAnimToggle_OID, DOM_Anim.doRescale)		
	elseif (option == dualAnimToggle_OID)
		DOMCore.dualAnimToggle = !DOMCore.dualAnimToggle
		SetToggleOptionValue(dualAnimToggle_OID, DOMCore.dualAnimToggle)
	endif
EndFunction

Function SaveSettings()
	String fileName1 = "Diary Of Mine/"+PlayerRef.getDisplayName()+"/Settings.json"
	SaveSettingsToFile(fileName1)
	String fileName2 = "Diary Of Mine/Settings.json"
	if !JsonUtil.JsonExists(fileName2)
		SaveSettingsToFile(fileName2)
	endif
EndFunction

Function SaveSettingsToFile(string fileName)
	LogTrace("SaveSettings fileName="+fileName)
	; Ints
	JsonUtil.SetIntValue(fileName, "modifierkey",   DOMKeys.modifierKey)
	JsonUtil.SetIntValue(fileName, "modifierkeydefault",   DOMKeys.modifierKeyDefault)
	JsonUtil.SetIntValue(fileName, "abductionkey",  DOMKeys.abductionKey)
	JsonUtil.SetIntValue(fileName, "baginkey",      DOMKeys.bagInKey)
	JsonUtil.SetIntValue(fileName, "bagoutkey",     DOMKeys.bagOutKey)
	JsonUtil.SetIntValue(fileName, "personalitykey",DOMKeys.traitsKey)
	JsonUtil.SetIntValue(fileName, "personalitydigitskey",DOMKeys.traitsDigitsKey)
	JsonUtil.SetIntValue(fileName, "feelingskey",   DOMKeys.feelsKey)
	JsonUtil.SetIntValue(fileName, "feelingsdigitskey",   DOMKeys.feelsDigitsKey)
	JsonUtil.SetIntValue(fileName, "menu0key",      DOMKeys.menu0Key)
	JsonUtil.SetIntValue(fileName, "menu1key",      DOMKeys.menu1Key)
	JsonUtil.SetIntValue(fileName, "menu2key",      DOMKeys.menu2Key)
	JsonUtil.SetIntValue(fileName, "menu3key",      DOMKeys.menu3Key)
	JsonUtil.SetIntValue(fileName, "menu4key",      DOMKeys.menu4Key)
	JsonUtil.SetIntValue(fileName, "menu5key",      DOMKeys.menu5Key)
	JsonUtil.SetIntValue(fileName, "menu6key",      DOMKeys.menu6Key)
	JsonUtil.SetIntValue(fileName, "menu7key",      DOMKeys.menu7Key)
	JsonUtil.SetIntValue(fileName, "menu8key",      DOMKeys.menu8Key)
	JsonUtil.SetIntValue(fileName, "menu9key",      DOMKeys.menu9Key)
	JsonUtil.SetIntValue(fileName, "menu10key",     DOMKeys.menu10Key)
	JsonUtil.SetIntValue(fileName, "actionkey",     DOMKeys.actionKey)
	JsonUtil.SetIntValue(fileName, "diarykey",      DOMKeys.diaryKey)
	JsonUtil.SetIntValue(fileName, "statuskey",     DOMKeys.statusKey)
	JsonUtil.SetIntValue(fileName, "moodkey",       DOMKeys.moodKey)
	JsonUtil.SetIntValue(fileName, "movekey",       DOMKeys.moveKey)
	JsonUtil.SetIntValue(fileName, "followkey",     DOMKeys.followKey)
	JsonUtil.SetIntValue(fileName, "followallkey",  DOMKeys.followAllKey)
	JsonUtil.SetIntValue(fileName, "inventorykey",  DOMKeys.inventoryKey)
	JsonUtil.SetIntValue(fileName, "praisekey",     DOMKeys.praiseKey)
	JsonUtil.SetIntValue(fileName, "scoldkey",      DOMKeys.scoldKey)
	JsonUtil.SetIntValue(fileName, "punishkey",     DOMKeys.punishKey)
	JsonUtil.SetIntValue(fileName, "chokekey",      DOMKeys.chokeKey)
	JsonUtil.SetIntValue(fileName, "favorkey",      DOMKeys.favorKey)
	JsonUtil.SetIntValue(fileName, "kneelkey",      DOMKeys.kneelKey)
	JsonUtil.SetIntValue(fileName, "attentionkey",  DOMKeys.attentionKey)
	JsonUtil.SetIntValue(fileName, "ripoffkey",     DOMKeys.ripoffKey)
	JsonUtil.SetIntValue(fileName, "stripkey",      DOMKeys.stripKey)
	JsonUtil.SetIntValue(fileName, "comekey",       DOMKeys.comeKey)
	JsonUtil.SetIntValue(fileName, "testkey",       DOMKeys.testPoseKey)
	JsonUtil.SetIntValue(fileName, "fixmekey",      DOMKeys.fixmeKey)
	JsonUtil.SetIntValue(fileName, "NumberOfWidgets", DOMCore.number_of_widgets)
	JsonUtil.SetIntValue(fileName, "MaxNumberOfParagraph", DOM04.maxNumberOfParagraph)
	JsonUtil.SetIntValue(fileName, "ActorRegenTicks", DOMCore.actorRegenTicks)
	
	; Floats
	JsonUtil.SetFloatValue(fileName, "PostRapeDelay", DOMSexlab.postRapeDelay)
	JsonUtil.SetFloatValue(fileName, "DeleteActorThreshold", DOMCore.deleteActorThreshold)
	JsonUtil.SetFloatValue(fileName, "ActorRegenAmount", DOMCore.actorRegenAmount)
	JsonUtil.SetFloatValue(fileName, "KinkOrgasmSpeed", DOMCore.orgasm_speed_kink)
	JsonUtil.SetFloatValue(fileName, "KinkArousalSpeed", DOMCore.arousal_speed_kink)
	JsonUtil.SetFloatValue(fileName, "PlayerSkillsSpeed", DOMPlayerAlias.skills_difficulty)
	JsonUtil.SetFloatValue(fileName, "KinkTrainingSpeed", DOMCore.train_speed_kink)
	JsonUtil.SetFloatValue(fileName, "LoveTrainingSpeed", DOMCore.train_speed_love)
	JsonUtil.SetFloatValue(fileName, "ArousalTrainingSpeed", DOMCore.train_speed_arousal)
	JsonUtil.SetFloatValue(fileName, "OrgasmTrainingSpeed", DOMCore.train_speed_orgasm)
	JsonUtil.SetFloatValue(fileName, "NPCTrainingSpeed", DOMCore.train_speed_npc)
	JsonUtil.SetFloatValue(fileName, "PlayerTrainingSpeed", DOMCore.train_speed_player)
	JsonUtil.SetFloatValue(fileName, "PainTrainingSpeed", DOMCore.train_speed_pain)
	JsonUtil.SetFloatValue(fileName, "SexTrainingSpeed", DOMCore.train_speed_sex)
	JsonUtil.SetFloatValue(fileName, "RapeTrainingSpeed", DOMCore.train_speed_rape)
	JsonUtil.SetFloatValue(fileName, "ScoldTrainingSpeed", DOMCore.train_speed_tell)
	JsonUtil.SetFloatValue(fileName, "PraiseTrainingSpeed", DOMCore.train_speed_good)
	JsonUtil.SetFloatValue(fileName, "AnimSpeedSec", DOMCore.anim_speed_sec*100.0)
	JsonUtil.SetFloatValue(fileName, "PoseThreshold", DOMCore.pose_threshold*1440.0)
	JsonUtil.SetFloatValue(fileName, "FriendThreshold", DOMCore.friend_threshold*100.0)
	JsonUtil.SetFloatValue(fileName, "RunAwayValue", DOMCore.runAwayValue)
	JsonUtil.SetFloatValue(fileName, "TraitVariation", DOMCore.trait_variation)
	JsonUtil.SetFloatValue(fileName, "TraitRaceBonus", DOMCore.trait_race_bonus)
	JsonUtil.SetFloatValue(fileName, "TraitClassBonus", DOMCore.trait_class_bonus)
	JsonUtil.SetFloatValue(fileName, "TraitJobBonus", DOMCore.trait_job_bonus)
	JsonUtil.SetFloatValue(fileName, "TraitGenderBonus", DOMCore.trait_gender_bonus)
	JsonUtil.SetFloatValue(fileName, "TraitAgeBonus", DOMCore.trait_age_bonus)
	JsonUtil.SetFloatValue(fileName, "TraitPlaceBonus", DOMCore.trait_place_bonus)
	JsonUtil.SetFloatValue(fileName, "DirtinessRegen", DOMCore.dirtRegenAmount)
	JsonUtil.SetFloatValue(fileName, "WealthModifier", DOMCore.wealth_modifier)
	JsonUtil.SetFloatValue(fileName, "ChanceRunAwayMultiplier", DOMCore.chanceRunAwayMultiplier)
	JsonUtil.SetFloatValue(fileName, "ActorUpdateTimer", DOMCore.actorUpdateTimer)
	JsonUtil.SetFloatValue(fileName, "ActorUpdateTimerGlobal", DOMCore.actorUpdateTimerGlobal)

	; bools
	JsonUtil.SetIntValue(fileName, "HasAbductionSpell", DOMCore.hasAbductionSpell as Int)
	JsonUtil.SetIntValue(fileName, "HasDiarySpell", DOMCore.hasDiarySpell as Int)
	JsonUtil.SetIntValue(fileName, "HasMenuSpell", DOMCore.hasMenuSpell as Int)
	JsonUtil.SetIntValue(fileName, "HasMenuPower", DOMCore.hasMenuPower as Int)
	JsonUtil.SetIntValue(fileName, "HasInfoSpell", DOMCore.hasInfoSpell as Int)
	JsonUtil.SetIntValue(fileName, "HasInfoPower", DOMCore.hasInfoPower as Int)
	JsonUtil.SetIntValue(fileName, "HasWakeUpPerk", DOMCore.hasWakeUpPerk as Int)
	JsonUtil.SetIntValue(fileName, "HasBurlapSackPerk", DOMCore.hasBurlapSackPerk as Int)
	JsonUtil.SetIntValue(fileName, "HasAbductionPerk", DOMCore.hasAbductionPerk as Int)
	JsonUtil.SetIntValue(fileName, "HasRecruitPerk", DOMCore.hasRecruitPerk as Int)
	JsonUtil.SetIntValue(fileName, "hasSlapTool", DOMCore.hasSlapTool as Int)
	JsonUtil.SetIntValue(fileName, "SeedUniques", DOMCore.seedUniques as Int)
	JsonUtil.SetIntValue(fileName, "WriteJSONRelease", DOMGenerator.writeJSONRelease as Int)
	JsonUtil.SetIntValue(fileName, "WriteJSONTransfer", DOMGenerator.writeJSONTransfer as Int)
	JsonUtil.SetIntValue(fileName, "TrainSexlabValuesToggle", DOMCore.trainSexlabValuesToggle as Int)
	JsonUtil.SetIntValue(fileName, "ReadSexlabValuesToggle", DOMCore.readSexlabValuesToggle as Int)
	JsonUtil.SetIntValue(fileName, "VampireCattleToggle", DOMCore.VampireCattleToggle as Int)
	JsonUtil.SetIntValue(fileName, "RemoveEssential", DOMCore.RemoveEssentialToggle as Int)
	JsonUtil.SetIntValue(fileName, "SetEssential", DOMCore.SetEssentialToggle as Int)
	JsonUtil.SetIntValue(fileName, "DebugMode", DOMCore.debugMode as Int)
	JsonUtil.SetIntValue(fileName, "DebugKeyMode", DOMKeys.debugKeyMode as Int)
	JsonUtil.SetIntValue(fileName, "PrintActorBonusesToggle", DOMGenerator.printActorBonusesToggle as Int)
	JsonUtil.SetIntValue(fileName, "VerboseMode", DOMCore.verboseMode as Int)
	JsonUtil.SetIntValue(fileName, "VerboseTopics", DOMCore.verboseTopics as Int)
	JsonUtil.SetIntValue(fileName, "WheelsUseVerboseMessage", DOMCore.wheelsUseVerboseMessage as Int)
	JsonUtil.SetIntValue(fileName, "DialoguesUseVerboseMessage", DOMCore.dialoguesUseVerboseMessage as Int)
	JsonUtil.SetIntValue(fileName, "VerboseEquip", DOMEquip.verboseEquip as Int)
	JsonUtil.SetIntValue(fileName, "VerboseAnim", DOMCore.verboseAnim as Int)
	JsonUtil.SetIntValue(fileName, "PlayerSkillsMessageToggle", DOMPlayerAlias.playerSkillsMessageToggle as Int)
	JsonUtil.SetIntValue(fileName, "FriendsPlayerToggle", DOMCore.friendsPlayerToggle as Int)
	JsonUtil.SetIntValue(fileName, "KinksPlayerSubToggle", DOMCore.kinksPlayerSubToggle as Int)
	JsonUtil.SetIntValue(fileName, "KinksPlayerDomToggle", DOMCore.kinksPlayerDomToggle as Int)
	JsonUtil.SetIntValue(fileName, "PlayerJournalToggle", DOMPlayerAlias.playerJournalToggle as Int)
	JsonUtil.SetIntValue(fileName, "PlayerLedgerToggle", DOMPlayerAlias.playerLedgerToggle as Int)
	JsonUtil.SetIntValue(fileName, "PlayerDiaryToggle", DOM04.playerDiaryToggle as Int)
	JsonUtil.SetIntValue(fileName, "SlaveDiaryToggle", DOM04.slaveDiaryToggle as Int)
	JsonUtil.SetIntValue(fileName, "SlaverDiaryToggle", DOM04.slaverDiaryToggle as Int)
	JsonUtil.SetIntValue(fileName, "ShowKinksToggle", DOMCore.showKinksToggle as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONTraitsWarning", DOMGenerator.ReadJSONTraitsWarning as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONTraitsToggle", DOMGenerator.ReadJSONTraitsToggle as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONRelationshipToggle", DOMGenerator.ReadJSONRelationshipToggle as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONVirginityToggle", DOMGenerator.ReadJSONVirginityToggle as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONTrainingToggle", DOMGenerator.ReadJSONTrainingToggle as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONKinksToggle", DOMGenerator.ReadJSONKinksToggle as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONMemoriesToggle", DOMGenerator.ReadJSONMemoriesToggle as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONForUniques", DOMGenerator.readJSONForUniques as Int)
	JsonUtil.SetIntValue(fileName, "ReadJSONForSpawned", DOMGenerator.readJSONForSpawned as Int)
	JsonUtil.SetIntValue(fileName, "GroupChoiceRandom", DOMCore.GroupChoiceRandom as Int)
	JsonUtil.SetIntValue(fileName, "GroupChoicePose", DOMCore.GroupChoicePose as Int)
	JsonUtil.SetIntValue(fileName, "StartupCheckActor", DOMCore.StartupCheckActor as Int)
	JsonUtil.SetIntValue(fileName, "StartupSyncTattoos", DOMCore.StartupSyncTattoos as Int)
	JsonUtil.SetIntValue(fileName, "CaptureSyncTattoos", DOMCore.CaptureSyncTattoos as Int)
	JsonUtil.SetIntValue(fileName, "UpdateCombatStrength", DOMCore.UpdateCombatStrength as Int)
	JsonUtil.SetIntValue(fileName, "sendDOMOrders", DOMCore.sendDOMOrders as Int)
	JsonUtil.SetIntValue(fileName, "sendDOMEquipEvent", DOMEquip.sendDOMEquipEvent as Int)
	JsonUtil.SetIntValue(fileName, "sendDOMCaptureEvent", DOMCore.sendDOMCaptureEvent as Int)
	JsonUtil.SetIntValue(fileName, "sendDOMEvents", DOMCore.sendDOMEvents as Int)
	JsonUtil.SetIntValue(fileName, "ForbidCreatureCapture", DOMKeys.forbidCreatureCapture as Int)
	JsonUtil.SetIntValue(fileName, "ForbidAnimalCapture", DOMKeys.forbidAnimalCapture as Int)
	JsonUtil.SetIntValue(fileName, "ForbidUndeadCapture", DOMKeys.forbidUndeadCapture as Int)
	JsonUtil.SetIntValue(fileName, "DoAnimPlayerTieup", DOMCore.doAnimPlayerTieup as Int)
	JsonUtil.SetIntValue(fileName, "SummonPAHToggle", DOMCore.summonPAHToggle as Int)
	JsonUtil.SetIntValue(fileName, "SummonPosingToggle", DOMCore.summonPosingToggle as Int)
	JsonUtil.SetIntValue(fileName, "SingleTellToggle", DOMCore.singleTellToggle as Int)
	JsonUtil.SetIntValue(fileName, "UseBiS", DOMBath.useBiS as Int)
	JsonUtil.SetIntValue(fileName, "WheelIsDefaultMenu",       DOMKeys.wheelIsDefaultMenu as Int)
	JsonUtil.SetIntValue(fileName, "WheelIsDefaultCall",       DOMKeys.wheelIsDefaultCall as Int)
	JsonUtil.SetIntValue(fileName, "WheelUsesDefaultPunishmentType",       DOMKeys.wheelUsesDefaultPunishmentType as Int)
	JsonUtil.SetIntValue(fileName, "WheelUsesDefaultPraiseType",       DOMKeys.wheelUsesDefaultPraiseType as Int)
	JsonUtil.SetIntValue(fileName, "menuPAH",       DOMKeys.menuPAH as Int)
	JsonUtil.SetIntValue(fileName, "menuExtraSlaves",       DOMKeys.menuExtraSlaves as Int)
	JsonUtil.SetIntValue(fileName, "menuSlavers",       DOMKeys.menuSlavers as Int)
	JsonUtil.SetIntValue(fileName, "DualAnimToggle", DOMCore.dualAnimToggle as Int)
	JsonUtil.SetIntValue(fileName, "RequireSLTags", DOMSexlab.requireSLTags as Int)
	JsonUtil.SetIntValue(fileName, "RequireSLTags4", DOMSexlab.requireSLTags4 as Int)
	JsonUtil.SetIntValue(fileName, "RequireSLTags3", DOMSexlab.requireSLTags3 as Int)
	JsonUtil.SetIntValue(fileName, "UseSexlabBeforeOstimPlayer", DOMSexlab.startSexlabPreferablyPlayer as Int)
	JsonUtil.SetIntValue(fileName, "UseSexlabBeforeOstimNPC", DOMSexlab.startSexlabPreferablyNPC as Int)
	JsonUtil.SetIntValue(fileName, "UseSexlabBeforeOstimDOM", DOMSexlab.startSexlabPreferablyDOM as Int)
	JsonUtil.SetIntValue(fileName, "SeparateOrgasmToggle", DOMSexlab.separateOrgasmToggle as Int)
	JsonUtil.SetIntValue(fileName, "AlwaysAggressiveToggle", DOMSexlab.alwaysAggressiveToggle as Int)
	JsonUtil.SetIntValue(fileName, "AlwaysGentleToggle", DOMSexlab.alwaysGentleToggle as Int)
	JsonUtil.SetIntValue(fileName, "UseAggressiveTag", DOMSexlab.useAggressiveTag as Int)
	JsonUtil.SetIntValue(fileName, "RescaleAnimToggle", DOM_Anim.doRescale as Int)
	JsonUtil.SetIntValue(fileName, "doPlayerIdle", DOMCore.doPlayerIdle as Int)
	JsonUtil.SetIntValue(fileName, "AlwaysRandomizeAnimations", DOM_Anim.alwaysRandomizeAnimations as Int)
	JsonUtil.SetIntValue(fileName, "doAnimateAtActorLocation", DOM_Anim.doAnimateAtActorLocation as Int)
	JsonUtil.SetIntValue(fileName, "doPlayerAnim", DOM_Anim.doPlayerAnim as Int)
	JsonUtil.SetIntValue(fileName, "doFreeCamera", DOM_Anim.doFreeCamera as Int)
	JsonUtil.SetIntValue(fileName, "doRemoveHeels", DOM_Anim.doRemoveHeels as Int)
	JsonUtil.SetIntValue(fileName, "RandomFlat", DOMCore.RandomFlat as Int)
	JsonUtil.SetIntValue(fileName, "StaticTraitsMode", DOMCore.staticTraitsMode as Int)
	JsonUtil.SetIntValue(fileName, "StaticTraitsChat", DOMCore.staticTraitsChat as Int)
	JsonUtil.SetIntValue(fileName, "AttentionPoseToggle", DOMCore.attentionPoseOn as Int)
	JsonUtil.SetIntValue(fileName, "SalutePoseToggle", DOMCore.salutePoseOn as Int)
	JsonUtil.SetIntValue(fileName, "KneelPoseToggle", DOMCore.kneelPoseOn as Int)
	JsonUtil.SetIntValue(fileName, "travelCuffsToggle", DOMCore.travelCuffsToggle as Int)
	JsonUtil.SetIntValue(fileName, "PunishPoseToggle", DOMCore.punishPoseToggle as Int)
	JsonUtil.SetIntValue(fileName, "PunishTieToggle", DOMCore.punishTieToggle as Int)
	JsonUtil.SetIntValue(fileName, "PunishMasturbateToggle", DOMCore.punishMasturbateToggle as Int)
	JsonUtil.SetIntValue(fileName, "PunishRestrainToggle", DOMCore.punishRestrainToggle as Int)
	JsonUtil.SetIntValue(fileName, "CheckInteriorPosesToggle", DOMCore.checkInteriorPosesToggle as Int)
	JsonUtil.SetIntValue(fileName, "PoseMoveToggle", DOMCore.poseMoveToggle as Int)
	JsonUtil.SetIntValue(fileName, "ResilienceToggle", DOMCore.resilienceToggle as Int)
	JsonUtil.SetIntValue(fileName, "LoyalToggle", DOMCore.loyalToggle as Int)
	JsonUtil.SetIntValue(fileName, "InloveToggle", DOMCore.inloveToggle as Int)
	JsonUtil.SetIntValue(fileName, "DepressedToggle", DOMCore.depressedToggle as Int)
	JsonUtil.SetIntValue(fileName, "InsecureToggle", DOMCore.insecureToggle as Int)
	JsonUtil.SetIntValue(fileName, "JealousyToggle", DOMCore.jealousyToggle as Int)
	JsonUtil.SetIntValue(fileName, "GreedToggle", DOMCore.greedToggle as Int)
	JsonUtil.SetIntValue(fileName, "FriendToggle", DOMCore.friendToggle as Int)
	JsonUtil.SetIntValue(fileName, "FriendPlayerToggle", DOMCore.friendPlayerToggle as Int)
	JsonUtil.SetIntValue(fileName, "FriendFollowToggle", DOMCore.friendFollowToggle as Int)
	JsonUtil.SetIntValue(fileName, "FriendDistantToggle", DOMCore.friendDistantToggle as Int)
	JsonUtil.SetIntValue(fileName, "HugWhenFreedToggle", DOMCore.hugWhenFreedToggle as Int)
	JsonUtil.SetIntValue(fileName, "FamilyToggle", DOMCore.familyToggle as Int)
	JsonUtil.SetIntValue(fileName, "AnswerToggle", DOMCore.answerToggle as Int)
	JsonUtil.SetIntValue(fileName, "BrandGlowStatus", DOMCore.brand_glow_status as Int)
	JsonUtil.SetIntValue(fileName, "BrandGloss", DOMCore.brand_gloss as Int)
	JsonUtil.SetIntValue(fileName, "MarksGlowStatus", DOMCore.marks_glow_status as Int)
	JsonUtil.SetIntValue(fileName, "MarksGloss", DOMCore.marks_gloss as Int)
	JsonUtil.SetIntValue(fileName, "TopicsToggle", DOMCore.topicsToggle as Int)
	JsonUtil.SetIntValue(fileName, "ItemEquipToggle", DOMEquip.itemEquipToggle as Int)
	JsonUtil.SetIntValue(fileName, "InstantEquipToggle", DOMEquip.instantEquipToggle as Int)
	JsonUtil.SetIntValue(fileName, "InstantUnEquipToggle", DOMEquip.instantUnEquipToggle as Int)
	JsonUtil.SetIntValue(fileName, "CellEquipToggle", DOMEquip.cellEquipToggle as Int)
	JsonUtil.SetIntValue(fileName, "LocationEquipToggle", DOMEquip.locationEquipToggle as Int)
	JsonUtil.SetIntValue(fileName, "UseStripKeywords", DOMEquip.useStripKeywords as Int)
	JsonUtil.SetIntValue(fileName, "ShameArea52", DOMEquip.shameArea52 as Int)
	JsonUtil.SetIntValue(fileName, "MaskPubicArea", DOMEquip.maskPubicArea as Int)
	JsonUtil.SetIntValue(fileName, "MaskFillHerUp", DOMEquip.maskFillHerUp as Int)
	JsonUtil.SetIntValue(fileName, "neverStripFX", DOMEquip.neverStripFX as Int)
	JsonUtil.SetIntValue(fileName, "StripAndDropToggle", DOMEquip.stripAndDropToggle as Int)
	JsonUtil.SetIntValue(fileName, "StripDeleteToggle", DOMEquip.stripDeleteToggle as Int)
	JsonUtil.SetIntValue(fileName, "StripLootToggle", DOMEquip.stripLootToggle as Int)
	JsonUtil.SetIntValue(fileName, "stripItemsToggle", DOMEquip.stripItemsToggle as Int)
	JsonUtil.SetIntValue(fileName, "StripUnequippedToggle", DOMEquip.stripUnequippedToggle as Int)
	JsonUtil.SetIntValue(fileName, "StripWeaponsToggle", DOMEquip.stripWeaponsToggle as Int)
	JsonUtil.SetIntValue(fileName, "StripShieldsToggle", DOMEquip.stripShieldsToggle as Int)
	JsonUtil.SetIntValue(fileName, "StripHeelsToggle", DOMEquip.stripHeelsToggle as Int)
	JsonUtil.SetIntValue(fileName, "StripUnderwearToggle", DOMEquip.stripUnderwearToggle as Int)
	JsonUtil.SetIntValue(fileName, "StripJewelryToggle", DOMEquip.stripJewelryToggle as Int)
	JsonUtil.SetIntValue(fileName, "RemoveCuffsToggle", DOMCore.removeCuffsToggle as Int)
	JsonUtil.SetIntValue(fileName, "RemoveBlindfoldToggle", DOMCore.removeBlindfoldToggle as Int)
	JsonUtil.SetIntValue(fileName, "RemoveGagToggle", DOMCore.removeGagToggle as Int)
	JsonUtil.SetIntValue(fileName, "UndressBeforeSex", DOMSexlab.undressBeforeSex as Int)
	JsonUtil.SetIntValue(fileName, "RedressAfterSex", DOMSexlab.redressAfterSex as Int)
	JsonUtil.SetIntValue(fileName, "DoAnimBeforeAndAfterSex", DOMCore.doAnimBeforeAndAfterSex as Int)
	JsonUtil.SetIntValue(fileName, "DoRipOffBeforeSex", DOMSexlab.doRipOffBeforeSex as Int)
	JsonUtil.SetIntValue(fileName, "MessageToggle", DOMCore.wMessageToggle as Int)
	JsonUtil.SetIntValue(fileName, "MessageLevel0", DOMCore.wMessageLevel0 as Int)
	JsonUtil.SetIntValue(fileName, "MessageLevel1", DOMCore.wMessageLevel1 as Int)
	JsonUtil.SetIntValue(fileName, "MessageLevel2", DOMCore.wMessageLevel2 as Int)
	JsonUtil.SetIntValue(fileName, "MessageLevel3", DOMCore.wMessageLevel3 as Int)
	JsonUtil.SetIntValue(fileName, "MessageLevel4", DOMCore.wMessageLevel4 as Int)
	JsonUtil.SetIntValue(fileName, "MessageLevel5", DOMCore.wMessageLevel5 as Int)
	JsonUtil.SetIntValue(fileName, "RenameToggle", DOMCore.renameToggle as Int)
	JsonUtil.SetIntValue(fileName, "CloneUniqueMode", DOMCore.CloneUniqueMode as Int)
	JsonUtil.SetIntValue(fileName, "CloneSpawnMode", DOMCore.CloneSpawnMode as Int)
	JsonUtil.SetIntValue(fileName, "CleanCrimeFaction", DOMCore.cleanCrimeFaction as Int)
	JsonUtil.SetIntValue(fileName, "CleanFactionUnique", DOMCore.cleanFactionUnique as Int)
	JsonUtil.SetIntValue(fileName, "CleanFactionSpawn", DOMCore.cleanFactionSpawn as Int)
	JsonUtil.SetIntValue(fileName, "CleanUniqueOutfit", DOMEquip.cleanUniqueOutfit as Int)
	JsonUtil.SetIntValue(fileName, "CleanSpawnOutfit", DOMEquip.cleanSpawnOutfit as Int)
	JsonUtil.SetIntValue(fileName, "CleanSlaverOutfit", DOMEquip.cleanSlaverOutfit as Int)
	JsonUtil.SetIntValue(fileName, "CleanFactionUnique", DOMCore.cleanFactionUnique as Int)
	JsonUtil.SetIntValue(fileName, "RestoreOutfitUnique", DOMEquip.restoreOutfitUnique as Int)
	JsonUtil.SetIntValue(fileName, "RestoreOutfitSpawn", DOMEquip.restoreOutfitSpawn as Int)
	JsonUtil.SetIntValue(fileName, "RestoreOutfitAlways", DOMEquip.restoreOutfitAlways as Int)
	JsonUtil.SetIntValue(fileName, "TieupWhenUnBagToggle", DOMKeys.tieupWhenUnBagToggle as Int)
	JsonUtil.SetIntValue(fileName, "AlarmToggleAbduction2", DOMKeys.alarmToggleAbduction2 as Int)
	JsonUtil.SetIntValue(fileName, "AlarmToggleAbduction", DOMKeys.alarmToggleAbduction as Int)
	JsonUtil.SetIntValue(fileName, "AlarmToggleWitness3", DOMKeys.alarmToggleWitness3 as Int)
	JsonUtil.SetIntValue(fileName, "AlarmToggleWitness2", DOMKeys.alarmToggleWitness2 as Int)
	JsonUtil.SetIntValue(fileName, "AlarmToggleWitness", DOMKeys.alarmToggleWitness as Int)
	JsonUtil.SetIntValue(fileName, "AlarmToggleRunaway", DOMCore.alarmToggleRunaway as Int)
	JsonUtil.SetIntValue(fileName, "EscapeToggle", DOMCore.escapeToggle as Int)
	JsonUtil.SetIntValue(fileName, "fHitToggle", DOMCore.fHitToggle as Int)
	JsonUtil.SetIntValue(fileName, "sHitToggle", DOMCore.sHitToggle as Int)
	JsonUtil.SetIntValue(fileName, "cleanDeleteToggle", DOMCore.cleanDeleteToggle as Int)
	JsonUtil.SetIntValue(fileName, "cleanWeaponsToggle", DOMCore.cleanWeaponsToggle as Int)
	JsonUtil.SetIntValue(fileName, "cleanArmorsToggle", DOMCore.cleanArmorsToggle as Int)
	JsonUtil.SetIntValue(fileName, "cleanAmmoToggle", DOMCore.cleanAmmoToggle as Int)
	JsonUtil.SetIntValue(fileName, "cleanBooksToggle", DOMCore.cleanBooksToggle as Int)
	JsonUtil.SetIntValue(fileName, "cleanScrollsToggle", DOMCore.cleanScrollsToggle as Int)
	JsonUtil.SetIntValue(fileName, "WeaponsOToggle", DOMCore.weaponsOToggle as Int)
	JsonUtil.SetIntValue(fileName, "WeaponsBToggle", DOMCore.weaponsBToggle as Int)
	JsonUtil.SetIntValue(fileName, "WeaponsFToggle", DOMCore.weaponsFToggle as Int)
	JsonUtil.SetIntValue(fileName, "WeaponsMToggle", DOMCore.weaponsMToggle as Int)
	JsonUtil.SetIntValue(fileName, "VirginOToggle", DOMCore.virginOToggle as Int)
	JsonUtil.SetIntValue(fileName, "VirginAToggle", DOMCore.virginAToggle as Int)
	JsonUtil.SetIntValue(fileName, "VirginVToggle", DOMCore.virginVToggle as Int)
	JsonUtil.SetIntValue(fileName, "VirginSToggle", DOMCore.virginSToggle as Int)
	JsonUtil.SetIntValue(fileName, "VirginGToggle", DOMCore.virginGToggle as Int)
	JsonUtil.SetIntValue(fileName, "BlushFToggle", DOMCore.blushFToggle as Int)
	JsonUtil.SetIntValue(fileName, "TearsFToggle", DOMCore.tearsFToggle as Int)
	JsonUtil.SetIntValue(fileName, "MascaraFToggle", DOMCore.masctFToggle as Int)
	JsonUtil.SetIntValue(fileName, "BlushMToggle", DOMCore.blushMToggle as Int)
	JsonUtil.SetIntValue(fileName, "TearsMToggle", DOMCore.tearsMToggle as Int)
	JsonUtil.SetIntValue(fileName, "MascaraMToggle", DOMCore.masctMToggle as Int)
	JsonUtil.SetIntValue(fileName, "CryingPunishmentToggle", DOMCore.cryingPunishmentToggle as Int)
	JsonUtil.SetIntValue(fileName, "CryingPraiseToggle", DOMCore.cryingPraiseToggle as Int)
	JsonUtil.SetIntValue(fileName, "OppositeSexToggle", DOMCore.oppositeSexToggle as Int)
	JsonUtil.SetIntValue(fileName, "SameSexToggle", DOMCore.sameSexToggle as Int)
	JsonUtil.SetIntValue(fileName, "AllowSlavesGear", DOMEquip.allowSlavesGearToggle as Int)
	JsonUtil.SetIntValue(fileName, "AllowSlaversGear", DOMEquip.allowSlaversGearToggle as Int)
	JsonUtil.SetIntValue(fileName, "SetTransferNodeToggle", DOMCore.setTransferNodeToggle as Int)
	JsonUtil.SetIntValue(fileName, "SetOBodyPresetToggleF", DOMCore.setOBodyPresetToggleF as Int)
	JsonUtil.SetIntValue(fileName, "SetOBodyPresetToggleM", DOMCore.setOBodyPresetToggleM as Int)
	JsonUtil.SetIntValue(fileName, "DefaultFollowMode", DOMCore.DefaultFollowMode as Int)
	JsonUtil.SetIntValue(fileName, "DefaultWaitMode", DOMCore.DefaultWaitMode as Int)
	JsonUtil.SetIntValue(fileName, "ActionGroup", DOMCore.actionGroup as Int)
	JsonUtil.SetIntValue(fileName, "ActionFlag", DOMCore.actionFlag as Int)
	JsonUtil.SetIntValue(fileName, "DelayTopic", DOMCore.delayTopic)
	JsonUtil.SetIntValue(fileName, "DelayTopicGlobal", DOMCore.delayTopicGlobal)

	JsonUtil.SetStringValue(fileName, "ActionType", DOMCore.actionType)
	JsonUtil.SetStringValue(fileName, "ActionName", DOMCore.actionName)
	JsonUtil.SetStringValue(fileName, "AttentionPose", DOMCore.attentionPose)
	JsonUtil.SetStringValue(fileName, "SalutePose", DOMCore.salutePose)
	JsonUtil.SetStringValue(fileName, "KneelPose", DOMCore.kneelPose)
	JsonUtil.SetStringValue(fileName, "DefaultPraiseType", DOMCore.DefaultPraiseType)
	JsonUtil.SetStringValue(fileName, "DefaultPunishmentType", DOMCore.DefaultPunishmentType)
	JsonUtil.SetStringValue(fileName, "DefaultWheelPraiseType", DOMCore.DefaultWheelPraiseType)
	JsonUtil.SetStringValue(fileName, "DefaultWheelPunishmentType", DOMCore.DefaultWheelPunishmentType)

	; Global values
	JsonUtil.SetFloatValue(fileName, "TrainingThresholdLow",       DOM_TrainingThresholdLow.GetValue())
	JsonUtil.SetFloatValue(fileName, "TrainingThresholdMedium",    DOM_TrainingThresholdMedium.GetValue())
	JsonUtil.SetFloatValue(fileName, "TrainingThresholdHigh",      DOM_TrainingThresholdHigh.GetValue())
	JsonUtil.SetFloatValue(fileName, "TrainingThresholdMax",       DOM_TrainingThresholdMax.GetValue())
	JsonUtil.SetFloatValue(fileName, "SubmissionMinValue",         DOM_SubmissionMinValue.GetValue())
	JsonUtil.SetFloatValue(fileName, "HealthPercentage",           DOM_HealthPercentage.GetValue())
	JsonUtil.SetFloatValue(fileName, "HealthMinValue",             DOM_HealthMinValue.GetValue())
	JsonUtil.SetFloatValue(fileName, "RelationShipClosenessValue", DOM_RelationShipClosenessValue.GetValue())
	JsonUtil.SetFloatValue(fileName, "RelationShipIntimacyValue",  DOM_RelationShipIntimacyValue.GetValue())
	JsonUtil.SetFloatValue(fileName, "DOMVersion",                 DOM_Version.GetValue())

	if DOM_DeactivateDialogueFollow.GetValue() == 1
		JsonUtil.SetIntValue(fileName, "ActivateDialogueFollow", 0)
	else
		JsonUtil.SetIntValue(fileName, "ActivateDialogueFollow", 1)
	endif
	if DOM_DeactivateDialogueForNPC.GetValue() == 1
		JsonUtil.SetIntValue(fileName, "ActivateDialogueForNPC", 0)
	else
		JsonUtil.SetIntValue(fileName, "ActivateDialogueForNPC", 1)
	endif
	if DOM_DeactivateDialogueForDOM.GetValue() == 1
		JsonUtil.SetIntValue(fileName, "ActivateDialogueForDOM", 0)
	else
		JsonUtil.SetIntValue(fileName, "ActivateDialogueForDOM", 1)
	endif
	if DOM_ActivateCombatAbduction.GetValue() == 1
		JsonUtil.SetIntValue(fileName, "ActivateCombatAbduction", 1)
	else
		JsonUtil.SetIntValue(fileName, "ActivateCombatAbduction", 0)
	endif
	if DOM_ActivateCombatRecruit.GetValue() == 1
		JsonUtil.SetIntValue(fileName, "ActivateCombatRecruit", 1)
	else
		JsonUtil.SetIntValue(fileName, "ActivateCombatRecruit", 0)
	endif

	; Kinks settings
	int n = 127
	int i = 1
	while i < n
		JsonUtil.SetIntValue(fileName, "FilterKinkFemale"+i, DOMCore.FilterKink(i,1,None) as int)
		i+=1
	endwhile
	i = 1
	while i < n
		JsonUtil.SetIntValue(fileName, "FilterKinkMale"+i, DOMCore.FilterKink(i,0,None) as int)
		i+=1
	endwhile

	; PAH & Zaz extra values
	DOMPAH.WriteConfig(fileName)
	DOMZAZ.WriteConfig(fileName)
	 
	JsonUtil.Save(fileName)
EndFunction

Function LoadSettings()
	String fileName1 = "Diary Of Mine/"+PlayerRef.getDisplayName()+"/Settings.json"
	if JsonUtil.JsonExists(fileName1)
		LoadSettingsFromFile(fileName1)
	else
		String fileName2 = "Diary Of Mine/Settings.json"
		LoadSettingsFromFile(fileName2)
	endif
EndFunction

Function LoadSettingsFromFile(string fileName)
	LogTrace("LoadSettings fileName="+fileName)
	; Ints
	DOMKeys.modifierKey  = JsonUtil.GetIntValue(fileName, "modifierkey", 42)
	DOMKeys.modifierKeyDefault  = JsonUtil.GetIntValue(fileName, "modifierkeydefault", -1)
	DOMKeys.abductionKey = JsonUtil.GetIntValue(fileName, "abductionkey", 35)
	DOMKeys.bagInKey     = JsonUtil.GetIntValue(fileName, "baginkey", -1)
	DOMKeys.bagOutKey    = JsonUtil.GetIntValue(fileName, "bagoutkey", -1)
	DOMKeys.traitsKey    = JsonUtil.GetIntValue(fileName, "personalitykey", -1)
	DOMKeys.traitsDigitsKey    = JsonUtil.GetIntValue(fileName, "personalitydigitskey", -1)
	DOMKeys.feelsKey     = JsonUtil.GetIntValue(fileName, "feelingskey", -1)
	DOMKeys.feelsDigitsKey     = JsonUtil.GetIntValue(fileName, "feelingsdigitskey", -1)
	DOMKeys.menu0Key     = JsonUtil.GetIntValue(fileName, "menu0key", -1)
	DOMKeys.menu1Key     = JsonUtil.GetIntValue(fileName, "menu1key", 21)
	DOMKeys.menu2Key     = JsonUtil.GetIntValue(fileName, "menu2key", 22)
	DOMKeys.menu3Key     = JsonUtil.GetIntValue(fileName, "menu3key", -1)
	DOMKeys.menu4Key     = JsonUtil.GetIntValue(fileName, "menu4key", -1)
	DOMKeys.menu5Key     = JsonUtil.GetIntValue(fileName, "menu5key", -1)
	DOMKeys.menu6Key     = JsonUtil.GetIntValue(fileName, "menu6key", -1)
	DOMKeys.menu7Key     = JsonUtil.GetIntValue(fileName, "menu7key", 38)
	DOMKeys.menu8Key     = JsonUtil.GetIntValue(fileName, "menu8key", -1)
	DOMKeys.menu9Key     = JsonUtil.GetIntValue(fileName, "menu9key", -1)
	DOMKeys.menu10Key    = JsonUtil.GetIntValue(fileName, "menu10key", -1)
	DOMKeys.ActionKey    = JsonUtil.GetIntValue(fileName, "ActionKey", 34)
	DOMKeys.DiaryKey     = JsonUtil.GetIntValue(fileName, "DiaryKey", -1)
	DOMKeys.statusKey    = JsonUtil.GetIntValue(fileName, "statuskey", -1)
	DOMKeys.moodKey      = JsonUtil.GetIntValue(fileName, "moodkey", -1)
	DOMKeys.moveKey      = JsonUtil.GetIntValue(fileName, "movekey", -1)
	DOMKeys.followKey    = JsonUtil.GetIntValue(fileName, "followkey", -1)
	DOMKeys.followAllKey = JsonUtil.GetIntValue(fileName, "followAllkey", -1)
	DOMKeys.inventoryKey = JsonUtil.GetIntValue(fileName, "inventorykey", 24)
	DOMKeys.praiseKey    = JsonUtil.GetIntValue(fileName, "praisekey", -1)
	DOMKeys.scoldKey     = JsonUtil.GetIntValue(fileName, "scoldkey", -1)
	DOMKeys.punishKey    = JsonUtil.GetIntValue(fileName, "punishkey", -1)
	DOMKeys.chokeKey     = JsonUtil.GetIntValue(fileName, "chokekey", -1)
	DOMKeys.favorKey     = JsonUtil.GetIntValue(fileName, "favorkey", -1)
	DOMKeys.kneelKey     = JsonUtil.GetIntValue(fileName, "kneelkey", -1)
	DOMKeys.attentionKey = JsonUtil.GetIntValue(fileName, "attentionkey", -1)
	DOMKeys.ripoffKey    = JsonUtil.GetIntValue(fileName, "ripoffkey", -1)
	DOMKeys.stripKey     = JsonUtil.GetIntValue(fileName, "stripkey", -1)
	DOMKeys.comeKey      = JsonUtil.GetIntValue(fileName, "comekey", -1)
	DOMKeys.testPoseKey  = JsonUtil.GetIntValue(fileName, "testkey", -1)
	DOMKeys.fixmeKey     = JsonUtil.GetIntValue(fileName, "fixmekey", 37)
	DOMCore.number_of_widgets = JsonUtil.GetIntValue(fileName, "NumberOfWidgets", 8)
	DOM04.maxNumberOfParagraph = JsonUtil.GetIntValue(fileName, "MaxNumberOfParagraph", 32)
	DOMCore.ActorRegenTicks  = JsonUtil.GetIntValue(fileName, "ActorRegenTicks", 1)	

	; Floats
	DOMSexlab.postRapeDelay  = JsonUtil.GetFloatValue(fileName, "PostRapeDelay", 15.0)	
	DOMCore.deleteActorThreshold  = JsonUtil.GetFloatValue(fileName, "DeleteActorThreshold", 10.0)	
	DOMCore.actorRegenAmount  = JsonUtil.GetFloatValue(fileName, "ActorRegenAmount", 3.0)	
	DOMCore.orgasm_speed_kink  = JsonUtil.GetFloatValue(fileName, "KinkOrgasmSpeed", 100.0)	
	DOMCore.arousal_speed_kink  = JsonUtil.GetFloatValue(fileName, "KinkArousalSpeed", 100.0)	
	DOMPlayerAlias.skills_difficulty  = JsonUtil.GetFloatValue(fileName, "PlayerSkillsSpeed", 1.0)	
	DOMCore.train_speed_kink  = JsonUtil.GetFloatValue(fileName, "KinkTrainingSpeed", 100.0)	/100.0
	DOMCore.train_speed_love  = JsonUtil.GetFloatValue(fileName, "LoveTrainingSpeed", 25.0)	/100.0
	DOMCore.train_speed_arousal  = JsonUtil.GetFloatValue(fileName, "ArousalTrainingSpeed", 50.0)/100.0	
	DOMCore.train_speed_orgasm  = JsonUtil.GetFloatValue(fileName, "OrgasmTrainingSpeed", 25.0)	/100.0
	DOMCore.train_speed_npc  = JsonUtil.GetFloatValue(fileName, "NPCTrainingSpeed", 100.0)	/100.0
	DOMCore.train_speed_player  = JsonUtil.GetFloatValue(fileName, "PlayerTrainingSpeed", 120.0)/100.0	
	DOMCore.train_speed_pain = JsonUtil.GetFloatValue(fileName, "PainTrainingSpeed", 100.0)	
	DOMCore.train_speed_sex  = JsonUtil.GetFloatValue(fileName, "SexTrainingSpeed", 100.0)	
	DOMCore.train_speed_rape = JsonUtil.GetFloatValue(fileName, "RapeTrainingSpeed", 100.0)	
	DOMCore.train_speed_tell = JsonUtil.GetFloatValue(fileName, "ScoldTrainingSpeed", 100.0)	
	DOMCore.train_speed_good = JsonUtil.GetFloatValue(fileName, "PraiseTrainingSpeed", 100.0)	
	DOMCore.anim_speed_sec   = JsonUtil.GetFloatValue(fileName, "AnimSpeedSec", 100.0)	/ 100.0
	DOMCore.pose_threshold   = JsonUtil.GetFloatValue(fileName, "PoseThreshold", 60.0) / 1440.0
	DOMCore.friend_threshold = JsonUtil.GetFloatValue(fileName, "FriendThreshold", 60.0) / 100.0
	DOMCore.runAwayValue  = JsonUtil.GetFloatValue(fileName, "RunAwayValue", 60.0)
	DOMCore.trait_variation  = JsonUtil.GetFloatValue(fileName, "TraitVariation", 25.0)
	DOMCore.trait_race_bonus = JsonUtil.GetFloatValue(fileName, "TraitRaceBonus", 1.0)
	DOMCore.trait_class_bonus = JsonUtil.GetFloatValue(fileName, "TraitClassBonus", 1.0)
	DOMCore.trait_job_bonus = JsonUtil.GetFloatValue(fileName, "TraitJobBonus", 1.0)
	DOMCore.trait_gender_bonus = JsonUtil.GetFloatValue(fileName, "TraitGenderBonus", 1.0)
	DOMCore.trait_age_bonus = JsonUtil.GetFloatValue(fileName, "TraitAgeBonus", 1.0)
	DOMCore.trait_place_bonus = JsonUtil.GetFloatValue(fileName, "TraitPlaceBonus", 1.0)
	DOMCore.dirtRegenAmount  = JsonUtil.GetFloatValue(fileName, "DirtinessRegen", 3.0)
	DOMCore.wealth_modifier  = JsonUtil.GetFloatValue(fileName, "WealthModifier", 10.0)
	DOMCore.chanceRunAwayMultiplier  = JsonUtil.GetFloatValue(fileName, "ChanceRunAwayMultiplier", 1.0)
	DOMCore.actorUpdateTimer  = JsonUtil.GetFloatValue(fileName, "ActorUpdateTimer", 3.0)
	DOMCore.actorUpdateTimerGlobal  = JsonUtil.GetFloatValue(fileName, "ActorUpdateTimerGlobal", 1.0)

	; bools
	DOMCore.hasAbductionSpell = JsonUtil.GetIntValue(fileName, "HasAbductionSpell", 1)
	DOMCore.hasDiarySpell = JsonUtil.GetIntValue(fileName, "HasDiarySpell", 1)
	DOMCore.hasMenuSpell = JsonUtil.GetIntValue(fileName, "HasMenuSpell", 1)
	DOMCore.hasMenuPower = JsonUtil.GetIntValue(fileName, "HasMenuPower", 1)
	DOMCore.hasInfoSpell = JsonUtil.GetIntValue(fileName, "HasInfoSpell", 1)
	DOMCore.hasInfoPower = JsonUtil.GetIntValue(fileName, "HasInfoPower", 1)
	DOMCore.hasWakeUpPerk = JsonUtil.GetIntValue(fileName, "HasWakeUpPerk", 1)
	DOMCore.hasBurlapSackPerk = JsonUtil.GetIntValue(fileName, "HasBurlapSackPerk", 1)
	DOMCore.hasAbductionPerk = JsonUtil.GetIntValue(fileName, "HasAbductionPerk", 1)
	DOMCore.hasRecruitPerk = JsonUtil.GetIntValue(fileName, "HasRecruitPerk", 1)
	DOMCore.hasSlapTool = JsonUtil.GetIntValue(fileName, "hasSlapTool", 1)
	DOMCore.seedUniques = JsonUtil.GetIntValue(fileName, "seedUniques", 0)
	DOMGenerator.writeJSONRelease = JsonUtil.GetIntValue(fileName, "WriteJSONRelease", 1)
	DOMGenerator.writeJSONTransfer = JsonUtil.GetIntValue(fileName, "WriteJSONTransfer", 1)
	DOMCore.trainSexlabValuesToggle = JsonUtil.GetIntValue(fileName, "TrainSexlabValuesToggle", 0)
	DOMCore.readSexlabValuesToggle = JsonUtil.GetIntValue(fileName, "ReadSexlabValuesToggle", 0)
	DOMCore.VampireCattleToggle = JsonUtil.GetIntValue(fileName, "VampireCattleToggle", 1)
	DOMCore.RemoveEssentialToggle = JsonUtil.GetIntValue(fileName, "RemoveEssential", 0)
	DOMCore.SetEssentialToggle = JsonUtil.GetIntValue(fileName, "SetEssential", 0)
	DOMCore.debugMode = JsonUtil.GetIntValue(fileName, "DebugMode", 1)
	DOMKeys.debugKeyMode = JsonUtil.GetIntValue(fileName, "DebugKeyMode", 0)
	DOMGenerator.printActorBonusesToggle = JsonUtil.GetIntValue(fileName, "PrintActorBonusesToggle", 0)
	DOMCore.verboseMode = JsonUtil.GetIntValue(fileName, "VerboseMode", 0)
	DOMCore.verboseTopics = JsonUtil.GetIntValue(fileName, "VerboseTopics", 0)
	DOMCore.wheelsUseVerboseMessage = JsonUtil.GetIntValue(fileName, "WheelsUseVerboseMessage", 1)
	DOMCore.dialoguesUseVerboseMessage = JsonUtil.GetIntValue(fileName, "DialoguesUseVerboseMessage", 0)
	DOMEquip.verboseEquip = JsonUtil.GetIntValue(fileName, "VerboseEquip", 0)
	DOMCore.verboseAnim = JsonUtil.GetIntValue(fileName, "VerboseAnim", 0)
	DOMPlayerAlias.playerSkillsMessageToggle = JsonUtil.GetIntValue(fileName, "PlayerSkillsMessageToggle", 1)
	DOMCore.friendsPlayerToggle = JsonUtil.GetIntValue(fileName, "FriendsPlayerToggle", 0)
	DOMCore.kinksPlayerSubToggle = JsonUtil.GetIntValue(fileName, "KinksPlayerSubToggle", 0)
	DOMCore.kinksPlayerDomToggle = JsonUtil.GetIntValue(fileName, "KinksPlayerDomToggle", 1)
	DOMPlayerAlias.playerJournalToggle = JsonUtil.GetIntValue(fileName, "PlayerJournalToggle", 1)
	DOMPlayerAlias.playerLedgerToggle = JsonUtil.GetIntValue(fileName, "PlayerLedgerToggle", 1)
	DOM04.playerDiaryToggle = JsonUtil.GetIntValue(fileName, "PlayerDiaryToggle", 1)
	DOM04.slaveDiaryToggle = JsonUtil.GetIntValue(fileName, "SlaveDiaryToggle", 1)
	DOM04.slaverDiaryToggle = JsonUtil.GetIntValue(fileName, "SlaverDiaryToggle", 1)
	DOMCore.showKinksToggle = JsonUtil.GetIntValue(fileName, "ShowKinksToggle", 0)
	DOMGenerator.ReadJSONTraitsWarning = JsonUtil.GetIntValue(fileName, "ReadJSONTraitsWarning", 1)
	DOMGenerator.ReadJSONTraitsToggle = JsonUtil.GetIntValue(fileName, "ReadJSONTraitsToggle", 1)
	DOMGenerator.ReadJSONRelationshipToggle = JsonUtil.GetIntValue(fileName, "ReadJSONRelationshipToggle", 1)
	DOMGenerator.ReadJSONVirginityToggle = JsonUtil.GetIntValue(fileName, "ReadJSONVirginityToggle", 1)
	DOMGenerator.ReadJSONTrainingToggle = JsonUtil.GetIntValue(fileName, "ReadJSONTrainingToggle", 1)
	DOMGenerator.ReadJSONKinksToggle = JsonUtil.GetIntValue(fileName, "ReadJSONKinksToggle", 1)
	DOMGenerator.ReadJSONMemoriesToggle = JsonUtil.GetIntValue(fileName, "ReadJSONMemoriesToggle", 1)
	DOMGenerator.readJSONForUniques = JsonUtil.GetIntValue(fileName, "ReadJSONForUniques", 1)
	DOMGenerator.readJSONForSpawned = JsonUtil.GetIntValue(fileName, "readJSONForSpawned", 1)
	DOMCore.GroupChoiceRandom = JsonUtil.GetIntValue(fileName, "GroupChoiceRandom", 1)
	DOMCore.GroupChoicePose = JsonUtil.GetIntValue(fileName, "GroupChoicePose", 1)
	DOMCore.StartupCheckActor = JsonUtil.GetIntValue(fileName, "StartupCheckActor", 0)
	DOMCore.StartupSyncTattoos = JsonUtil.GetIntValue(fileName, "StartupSyncTattoos", 0)
	DOMCore.CaptureSyncTattoos = JsonUtil.GetIntValue(fileName, "CaptureSyncTattoos", 1)
	DOMCore.UpdateCombatStrength = JsonUtil.GetIntValue(fileName, "UpdateCombatStrength", 0)
	DOMCore.sendDOMOrders = JsonUtil.GetIntValue(fileName, "sendDOMOrders", 1)
	DOMEquip.sendDOMEquipEvent = JsonUtil.GetIntValue(fileName, "sendDOMEquipEvent", 1)
	DOMCore.sendDOMCaptureEvent = JsonUtil.GetIntValue(fileName, "sendDOMCaptureEvent", 1)
	DOMCore.sendDOMEvents = JsonUtil.GetIntValue(fileName, "sendDOMEvents", 1)
	DOMKeys.forbidAnimalCapture = JsonUtil.GetIntValue(fileName, "ForbidAnimalCapture", 0)
	DOMKeys.forbidCreatureCapture = JsonUtil.GetIntValue(fileName, "ForbidCreatureCapture", 0)
	DOMKeys.forbidUndeadCapture = JsonUtil.GetIntValue(fileName, "ForbidUndeadCapture", 0)
	DOMCore.doAnimPlayerTieup = JsonUtil.GetIntValue(fileName, "DoAnimPlayerTieup", 1)
	activateCombatAbduction = JsonUtil.GetIntValue(fileName, "ActivateCombatAbduction", 1)
	activateCombatRecruit = JsonUtil.GetIntValue(fileName, "ActivateCombatRecruit", 1)
	DOMCore.summonPAHToggle = JsonUtil.GetIntValue(fileName, "SummonPAHToggle", 0)
	DOMCore.summonPosingToggle = JsonUtil.GetIntValue(fileName, "SummonPosingToggle", 0)
	DOMCore.singleTellToggle = JsonUtil.GetIntValue(fileName, "SingleTellToggle", 1)
	DOMBath.useBiS = JsonUtil.GetIntValue(fileName, "useBiS", 0)
	DOMKeys.wheelIsDefaultMenu      = JsonUtil.GetIntValue(fileName, "WheelIsDefaultMenu",  1)
	DOMKeys.wheelIsDefaultCall      = JsonUtil.GetIntValue(fileName, "WheelIsDefaultCall",  1)
	DOMKeys.wheelUsesDefaultPunishmentType      = JsonUtil.GetIntValue(fileName, "WheelUsesDefaultPunishmentType",  0)
	DOMKeys.wheelUsesDefaultPraiseType      = JsonUtil.GetIntValue(fileName, "WheelUsesDefaultPraiseType",  0)
	DOMKeys.menuPAH      = JsonUtil.GetIntValue(fileName, "menuPAH",  0)
	DOMKeys.menuExtraSlaves      = JsonUtil.GetIntValue(fileName, "menuExtraSlaves",  1)
	DOMKeys.menuSlavers      = JsonUtil.GetIntValue(fileName, "menuSlavers",  1)
	DOMCore.doPlayerIdle = JsonUtil.GetIntValue(fileName, "doPlayerIdle", 1)
	DOM_Anim.alwaysRandomizeAnimations = JsonUtil.GetIntValue(fileName, "AlwaysRandomizeAnimations", 0)
	DOM_Anim.doAnimateAtActorLocation = JsonUtil.GetIntValue(fileName, "doAnimateAtActorLocation", 0)
	DOM_Anim.doPlayerAnim = JsonUtil.GetIntValue(fileName, "doPlayerAnim", 1)
	DOM_Anim.doFreeCamera = JsonUtil.GetIntValue(fileName, "doFreeCamera", 0)
	DOM_Anim.doRemoveHeels = JsonUtil.GetIntValue(fileName, "doRemoveHeels", 0)
	DOMCore.dualAnimToggle = JsonUtil.GetIntValue(fileName, "DualAnimToggle", 1)
	DOMSexlab.requireSLTags = JsonUtil.GetIntValue(fileName, "RequireSLTags", 1)
	DOMSexlab.requireSLTags4 = JsonUtil.GetIntValue(fileName, "RequireSLTags4", 0)
	DOMSexlab.requireSLTags3 = JsonUtil.GetIntValue(fileName, "RequireSLTags3", 0)
	DOMSexlab.startSexlabPreferablyPlayer = JsonUtil.GetIntValue(fileName, "UseSexlabBeforeOstimPlayer", 1)
	DOMSexlab.startSexlabPreferablyNPC = JsonUtil.GetIntValue(fileName, "UseSexlabBeforeOstimNPC", 1)
	DOMSexlab.startSexlabPreferablyDOM = JsonUtil.GetIntValue(fileName, "UseSexlabBeforeOstimDOM", 1)
	if Game.GetModByName("SLSO.esp") != 255
		DOMSexlab.separateOrgasmToggle = JsonUtil.GetIntValue(fileName, "SeparateOrgasmToggle", 0)
	else
		DOMSexlab.separateOrgasmToggle = false
	endif
	DOMSexlab.alwaysAggressiveToggle = JsonUtil.GetIntValue(fileName, "AlwaysAggressiveToggle", 0)
	DOMSexlab.alwaysGentleToggle = JsonUtil.GetIntValue(fileName, "AlwaysGentleToggle", 0)
	DOMSexlab.useAggressiveTag = JsonUtil.GetIntValue(fileName, "UseAggressiveTag", 1)
	DOM_Anim.doRescale = JsonUtil.GetIntValue(fileName, "RescaleAnimToggle", 1)
	DOMCore.RandomFlat = JsonUtil.GetIntValue(fileName, "RandomFlat", 0)
	DOMCore.staticTraitsMode = JsonUtil.GetIntValue(fileName, "StaticTraitsMode", 0)
	DOMCore.staticTraitsChat = JsonUtil.GetIntValue(fileName, "StaticTraitsChat", 0)
	DOMCore.attentionPoseOn = JsonUtil.GetIntValue(fileName, "AttentionPoseToggle", 0)
	DOMCore.salutePoseOn = JsonUtil.GetIntValue(fileName, "SalutePoseToggle", 0)
	DOMCore.kneelPoseOn = JsonUtil.GetIntValue(fileName, "KneelPoseToggle", 0)
	DOMCore.travelCuffsToggle = JsonUtil.GetIntValue(fileName, "travelCuffsToggle", 1)
	DOMCore.punishPoseToggle = JsonUtil.GetIntValue(fileName, "PunishPoseToggle", 1)
	DOMCore.punishTieToggle = JsonUtil.GetIntValue(fileName, "PunishTieToggle", 1)
	DOMCore.punishMasturbateToggle = JsonUtil.GetIntValue(fileName, "PunishMasturbateToggle", 1)
	DOMCore.punishRestrainToggle = JsonUtil.GetIntValue(fileName, "PunishRestrainToggle", 1)
	DOMCore.checkInteriorPosesToggle = JsonUtil.GetIntValue(fileName, "checkInteriorPosesToggle", 1)
	DOMCore.poseMoveToggle = JsonUtil.GetIntValue(fileName, "PoseMoveToggle", 0)
	DOMCore.resilienceToggle = JsonUtil.GetIntValue(fileName, "ResilienceToggle", 0)
	DOMCore.loyalToggle = JsonUtil.GetIntValue(fileName, "LoyalToggle", 1)
	DOMCore.inloveToggle = JsonUtil.GetIntValue(fileName, "InloveToggle", 1)
	DOMCore.depressedToggle = JsonUtil.GetIntValue(fileName, "DepressedToggle", 1)
	DOMCore.insecureToggle = JsonUtil.GetIntValue(fileName, "InsecureToggle", 1)
	DOMCore.jealousyToggle = JsonUtil.GetIntValue(fileName, "JealousyToggle", 1)
	DOMCore.greedToggle = JsonUtil.GetIntValue(fileName, "GreedToggle", 1)
	DOMCore.friendToggle = JsonUtil.GetIntValue(fileName, "FriendToggle", 1)
	DOMCore.friendPlayerToggle = JsonUtil.GetIntValue(fileName, "FriendPlayerToggle", 1)
	DOMCore.friendFollowToggle = JsonUtil.GetIntValue(fileName, "FriendFollowToggle", 1)
	DOMCore.friendDistantToggle = JsonUtil.GetIntValue(fileName, "FriendDistantToggle", 1)
	DOMCore.hugWhenFreedToggle = JsonUtil.GetIntValue(fileName, "HugWhenFreedToggle", 1)
	DOMCore.familyToggle = JsonUtil.GetIntValue(fileName, "FamilyToggle", 1)
	DOMCore.answerToggle = JsonUtil.GetIntValue(fileName, "AnswerToggle", 1)
	DOMCore.Brand_glow_status = JsonUtil.GetIntValue(fileName, "brandGlowStatus", 1)
	DOMCore.Brand_gloss = JsonUtil.GetIntValue(fileName, "brandGloss", 0)
	DOMCore.marks_glow_status = JsonUtil.GetIntValue(fileName, "MarksGlowStatus", 0)
	DOMCore.marks_gloss = JsonUtil.GetIntValue(fileName, "MarksGloss", 0)
	DOMCore.topicsToggle = JsonUtil.GetIntValue(fileName, "TopicsToggle", 1)
	DOMEquip.itemEquipToggle = JsonUtil.GetIntValue(fileName, "ItemEquipToggle", 1)
	DOMEquip.instantEquipToggle = JsonUtil.GetIntValue(fileName, "InstantEquipToggle", 1)
	DOMEquip.instantUnEquipToggle = JsonUtil.GetIntValue(fileName, "InstantUnEquipToggle", 0)
	DOMEquip.cellEquipToggle = JsonUtil.GetIntValue(fileName, "CellEquipToggle", 0)
	DOMEquip.locationEquipToggle = JsonUtil.GetIntValue(fileName, "LocationEquipToggle", 1)
	DOMEquip.useStripKeywords = JsonUtil.GetIntValue(fileName, "UseStripKeywords", 1)
	DOMEquip.shameArea52 = JsonUtil.GetIntValue(fileName, "ShameArea52", 1)
	DOMEquip.maskPubicArea = JsonUtil.GetIntValue(fileName, "MaskPubicArea", 1)
	DOMEquip.maskFillHerUp = JsonUtil.GetIntValue(fileName, "MaskFillHerUp", 1)
	DOMEquip.neverStripFX = JsonUtil.GetIntValue(fileName, "neverStripFX", 0)
	DOMEquip.stripAndDropToggle = JsonUtil.GetIntValue(fileName, "StripAndDropToggle", 0)
	DOMEquip.stripDeleteToggle = JsonUtil.GetIntValue(fileName, "StripDeleteToggle", 0)
	DOMEquip.stripLootToggle = JsonUtil.GetIntValue(fileName, "StripLootToggle", 1)
	DOMEquip.stripItemsToggle = JsonUtil.GetIntValue(fileName, "stripItemsToggle", 0)
	DOMEquip.stripUnequippedToggle = JsonUtil.GetIntValue(fileName, "StripUnequippedToggle", 1)
	DOMEquip.stripWeaponsToggle = JsonUtil.GetIntValue(fileName, "StripWeaponsToggle", 1)
	DOMEquip.stripShieldsToggle = JsonUtil.GetIntValue(fileName, "StripShieldsToggle", 1)
	DOMEquip.stripHeelsToggle = JsonUtil.GetIntValue(fileName, "StripHeelsToggle", 0)
	DOMEquip.stripUnderwearToggle = JsonUtil.GetIntValue(fileName, "StripUnderwearToggle", 0)
	DOMEquip.stripJewelryToggle = JsonUtil.GetIntValue(fileName, "StripJewelryToggle", 0)
	DOMCore.removeCuffsToggle = JsonUtil.GetIntValue(fileName, "RemoveCuffsToggle", 0)
	DOMCore.removeBlindfoldToggle = JsonUtil.GetIntValue(fileName, "RemoveBlindfoldToggle", 0)
	DOMCore.removeGagToggle = JsonUtil.GetIntValue(fileName, "RemoveGagToggle", 0)
	DOMSexlab.undressBeforeSex = JsonUtil.GetIntValue(fileName, "UndressBeforeSex", 1)
	DOMSexlab.redressAfterSex = JsonUtil.GetIntValue(fileName, "RedressAfterSex", 1)
	DOMCore.doAnimBeforeAndAfterSex = JsonUtil.GetIntValue(fileName, "DoAnimBeforeAndAfterSex", 1)
	DOMSexlab.doRipOffBeforeSex = JsonUtil.GetIntValue(fileName, "DoRipOffBeforeSex", 0)
	DOMCore.wMessageToggle = JsonUtil.GetIntValue(fileName, "MessageToggle", 1)
	DOMCore.wMessageLevel0 = JsonUtil.GetIntValue(fileName, "MessageLevel0", 1)
	DOMCore.wMessageLevel1 = JsonUtil.GetIntValue(fileName, "MessageLevel1", 1)
	DOMCore.wMessageLevel2 = JsonUtil.GetIntValue(fileName, "MessageLevel2", 1)
	DOMCore.wMessageLevel3 = JsonUtil.GetIntValue(fileName, "MessageLevel3", 1)
	DOMCore.wMessageLevel4 = JsonUtil.GetIntValue(fileName, "MessageLevel4", 1)
	DOMCore.wMessageLevel5 = JsonUtil.GetIntValue(fileName, "MessageLevel5", 1)
	DOMCore.renameToggle = JsonUtil.GetIntValue(fileName, "RenameToggle", 1)
	DOMCore.cloneUniqueMode = JsonUtil.GetIntValue(fileName, "CloneUniqueMode", 1)
	DOMCore.cloneSpawnMode = true ;JsonUtil.GetIntValue(fileName, "CloneSpawnMode", 1)
	DOMCore.cleanCrimeFaction = JsonUtil.GetIntValue(fileName, "CleanCrimeFaction", 1)
	DOMCore.cleanFactionUnique = JsonUtil.GetIntValue(fileName, "CleanFactionUnique", 1)
	DOMCore.cleanFactionSpawn = JsonUtil.GetIntValue(fileName, "CleanFactionSpawn", 1)
	DOMEquip.cleanUniqueOutfit = JsonUtil.GetIntValue(fileName, "CleanUniqueOutfit", 1)
	DOMEquip.cleanSpawnOutfit = JsonUtil.GetIntValue(fileName, "CleanSpawnOutfit", 1)
	DOMEquip.cleanSlaverOutfit = JsonUtil.GetIntValue(fileName, "CleanSlaverOutfit", 0)
	DOMEquip.restoreOutfitUnique = JsonUtil.GetIntValue(fileName, "RestoreOutfitUnique", 1)
	DOMEquip.restoreOutfitSpawn = JsonUtil.GetIntValue(fileName, "RestoreOutfitSpawn", 1)
	DOMEquip.restoreOutfitAlways = JsonUtil.GetIntValue(fileName, "RestoreOutfitAlways", 0)
	DOMKeys.tieupWhenUnBagToggle = JsonUtil.GetIntValue(fileName, "TieupWhenUnBagToggle", 1)
	DOMKeys.alarmToggleAbduction2 = JsonUtil.GetIntValue(fileName, "AlarmToggleAbduction2", 1)
	DOMKeys.alarmToggleAbduction = JsonUtil.GetIntValue(fileName, "AlarmToggleAbduction", 1)
	DOMKeys.alarmToggleWitness3 = JsonUtil.GetIntValue(fileName, "AlarmToggleWitness3", 1)
	DOMKeys.alarmToggleWitness2 = JsonUtil.GetIntValue(fileName, "AlarmToggleWitness2", 1)
	DOMKeys.alarmToggleWitness = JsonUtil.GetIntValue(fileName, "AlarmToggleWitness", 1)
	DOMCore.alarmToggleRunaway = JsonUtil.GetIntValue(fileName, "AlarmToggleRunaway", 1)
	DOMCore.escapeToggle = JsonUtil.GetIntValue(fileName, "EscapeToggle", 1)
	DOMCore.fHitToggle = JsonUtil.GetIntValue(fileName, "fHitToggle", 1)
	DOMCore.sHitToggle = JsonUtil.GetIntValue(fileName, "sHitToggle", 1)
	DOMCore.cleanDeleteToggle = JsonUtil.GetIntValue(fileName, "cleanDeleteToggle", 1)
	DOMCore.cleanWeaponsToggle = JsonUtil.GetIntValue(fileName, "cleanWeaponsToggle", 1)
	DOMCore.cleanArmorsToggle = JsonUtil.GetIntValue(fileName, "cleanArmorsToggle", 1)
	DOMCore.cleanAmmoToggle = JsonUtil.GetIntValue(fileName, "cleanAmmoToggle", 1)
	DOMCore.cleanBooksToggle = JsonUtil.GetIntValue(fileName, "cleanBooksToggle", 1)
	DOMCore.cleanScrollsToggle = JsonUtil.GetIntValue(fileName, "cleanScrollsToggle", 1)
	DOMCore.rivalryToggle = JsonUtil.GetIntValue(fileName, "RivalryToggle", 1)
	DOMCore.weaponsOToggle = JsonUtil.GetIntValue(fileName, "WeaponsOToggle", 1)
	DOMCore.weaponsBToggle = JsonUtil.GetIntValue(fileName, "WeaponsBToggle", 1)
	DOMCore.weaponsFToggle = JsonUtil.GetIntValue(fileName, "WeaponsFToggle", 1)
	DOMCore.weaponsMToggle = JsonUtil.GetIntValue(fileName, "WeaponsMToggle", 1)
	DOMCore.virginOToggle = JsonUtil.GetIntValue(fileName, "VirginOToggle", 1)
	DOMCore.virginAToggle = JsonUtil.GetIntValue(fileName, "VirginAToggle", 1)
	DOMCore.virginVToggle = JsonUtil.GetIntValue(fileName, "VirginVToggle", 1)
	DOMCore.virginSToggle = JsonUtil.GetIntValue(fileName, "VirginSToggle", 1)
	DOMCore.virginGToggle = JsonUtil.GetIntValue(fileName, "VirginGToggle", 1)
	DOMCore.blushFToggle = JsonUtil.GetIntValue(fileName, "BlushFToggle", 1)
	DOMCore.tearsFToggle = JsonUtil.GetIntValue(fileName, "TearsFToggle", 1)
	DOMCore.masctFToggle = JsonUtil.GetIntValue(fileName, "MascaraFToggle", 1)
	DOMCore.blushMToggle = JsonUtil.GetIntValue(fileName, "BlushMToggle", 1)
	DOMCore.tearsMToggle = JsonUtil.GetIntValue(fileName, "TearsMToggle", 1)
	DOMCore.masctMToggle = JsonUtil.GetIntValue(fileName, "MascaraMToggle", 1)
	DOMCore.cryingPunishmentToggle = JsonUtil.GetIntValue(fileName, "CryingPunishmentToggle", 1)
	DOMCore.cryingPraiseToggle = JsonUtil.GetIntValue(fileName, "CryingPraiseToggle", 1)
	DOMCore.oppositeSexToggle = JsonUtil.GetIntValue(fileName, "OppositeSexToggle", 1)
	DOMCore.sameSexToggle = JsonUtil.GetIntValue(fileName, "SameSexToggle", 0)
	DOMEquip.allowSlavesGearToggle = JsonUtil.GetIntValue(fileName, "AllowSlavesGear", 0)
	DOMEquip.allowSlaversGearToggle = JsonUtil.GetIntValue(fileName, "AllowSlaversGear", 1)
	DOMCore.setTransferNodeToggle = JsonUtil.GetIntValue(fileName, "SetTransferNodeToggle", 1)
	DOMCore.setOBodyPresetToggleF = JsonUtil.GetIntValue(fileName, "SetOBodyPresetToggleF", 1)
	DOMCore.setOBodyPresetToggleM = JsonUtil.GetIntValue(fileName, "SetOBodyPresetToggleM", 0)
	DOMCore.delayTopic  = JsonUtil.GetIntValue(fileName, "DelayTopic", 10)
	DOMCore.delayTopicGlobal  = JsonUtil.GetIntValue(fileName, "delayTopicGlobal", 10)
	DOMCore.attentionPose = JsonUtil.GetStringValue(fileName, "AttentionPose", "ZapKneelDisplay")
	DOMCore.salutePose = JsonUtil.GetStringValue(fileName, "SalutePose", "IdleHandsBehindBack")
	DOMCore.kneelPose = JsonUtil.GetStringValue(fileName, "KneelPose", "ZapLickFeet")
	DOMCore.actionName = JsonUtil.GetStringValue(fileName, "ActionName", "flatter")
	DOMCore.actionType = JsonUtil.GetStringValue(fileName, "ActionType", "sexy")
	DOMCore.actionGroup = JsonUtil.GetIntValue(fileName, "ActionGroup", 0)
	DOMCore.actionFlag = JsonUtil.GetIntValue(fileName, "ActionFlag", 0)
	DOMCore.DefaultPraiseType = JsonUtil.GetStringValue(fileName, "DefaultPraiseType", "tell")
	DOMCore.DefaultPunishmentType = JsonUtil.GetStringValue(fileName, "DefaultPunishmentType", "pain")
	DOMCore.DefaultWheelPraiseType = JsonUtil.GetStringValue(fileName, "DefaultWheelPraiseType", "tell")
	DOMCore.DefaultWheelPunishmentType = JsonUtil.GetStringValue(fileName, "DefaultWheelPunishmentType", "scold")

	activateDialogueFollow = JsonUtil.GetIntValue(fileName, "ActivateDialogueFollow", 1)
	activateDialogueForNPC = JsonUtil.GetIntValue(fileName, "ActivateDialogueForNPC", 1)
	activateDialogueForDOM = JsonUtil.GetIntValue(fileName, "ActivateDialogueForDOM", 1)

	; Kinks settings
	int n = 127
	int i = 1
	while i < n
		bool is_set = JsonUtil.GetIntValue(fileName,  "FilterKinkFemale"+i, 1)
		DOMCore.SetFilterKink(i,1,is_set)
		i+=1
	endwhile
	i = 1
	while i < n
		bool is_set = JsonUtil.GetIntValue(fileName,  "FilterKinkMale"+i, 1)
		DOMCore.SetFilterKink(i,0,is_set)
		i+=1
	endwhile
	
	; PAH & Zaz extra values
	DOMPAH.ReadConfig(fileName)
	DOMZAZ.ReadConfig(fileName)

	DOMCore.RegisterPerks()
	DOMCore.CheckPlayersEquipment()

	; Global values
	DOM_TrainingThresholdLow.SetValue(JsonUtil.GetFloatValue(fileName, "TrainingThresholdLow",30.0))
	DOM_TrainingThresholdMedium.SetValue(JsonUtil.GetFloatValue(fileName, "TrainingThresholdMedium",50.0))
	DOM_TrainingThresholdHigh.SetValue(JsonUtil.GetFloatValue(fileName, "TrainingThresholdHigh",70.0))
	DOM_TrainingThresholdMax.SetValue(JsonUtil.GetFloatValue(fileName, "TrainingThresholdMax",90.0))
	DOM_SubmissionMinValue.SetValue(JsonUtil.GetFloatValue(fileName, "SubmissionMinValue",70.0))
	DOM_HealthPercentage.SetValue(JsonUtil.GetFloatValue(fileName, "HealthPercentage",0.3))
	DOM_HealthMinValue.SetValue(JsonUtil.GetFloatValue(fileName, "HealthMinValue",30.0))
	DOM_RelationShipClosenessValue.SetValue(JsonUtil.GetFloatValue(fileName, "RelationShipClosenessValue",2.0))
	DOM_RelationShipIntimacyValue.SetValue(JsonUtil.GetFloatValue(fileName, "RelationShipIntimacyValue",3.0))
	
	if ActivateCombatAbduction
		DOM_ActivateCombatAbduction.SetValue(1)
	else
		DOM_ActivateCombatAbduction.SetValue(0)
	endif
	if activateCombatRecruit
		DOM_ActivateCombatRecruit.SetValue(1)
	else
		DOM_ActivateCombatRecruit.SetValue(0)
	endif
	if activateDialogueForDOM
		DOM_DeactivateDialogueForDOM.SetValue(0)
	else
		DOM_DeactivateDialogueForDOM.SetValue(1)
	endif
	if activateDialogueForNPC
		DOM_DeactivateDialogueForNPC.SetValue(0)
	else
		DOM_DeactivateDialogueForNPC.SetValue(1)
	endif
	if activateDialogueFollow
		DOM_DeactivateDialogueFollow.SetValue(0)
	else
		DOM_DeactivateDialogueFollow.SetValue(1)
	endif
	if DOMCore.oppositeSexToggle
		DOM_OppositeSexTopics.SetValue(1)
	else
		DOM_OppositeSexTopics.SetValue(0)
	endif
	if DOMCore.sameSexToggle
		DOM_sameSexTopics.SetValue(1)
	else
		DOM_sameSexTopics.SetValue(0)
	endif

	DOMKeys.refreshKeys()
	ForcePageReset()
EndFunction

Function PlayerAddItemOnce(Form the_form)
	if PlayerRef.GetItemCount(the_form) > 0
		return
	endif
	PlayerRef.AddItem(the_form, 1)
EndFunction

Function ResetAllMemories()
	int n = DOM02.actorCounter
	int idx = 0
	while idx < n
		DOM_Actor akActor = DOM02.GetActorByIndex(idx)
		if akActor != None
			akActor.mind.ResetAllMemories()
		endif
		idx += 1
	endWhile
EndFunction


Function ResetAllDiaries()
	int n = DOM02.actorCounter
	int idx = 0
	while idx < n
		DOM_Actor akActor = DOM02.GetActorByIndex(idx)
		if akActor != None
			akActor.mind.MergeMemories()
			akActor.mind.ResetTextMemories()
		endif
		idx += 1
	endWhile
	n = DOM01.actorCounter
	idx = 0
	while idx < n
		DOM_Actor akActor = DOM01.GetActorByIndex(idx)
		if akActor != None
			akActor.mind.MergeMemories()
			akActor.mind.ResetTextMemories()
		endif
		idx += 1
	endWhile
EndFunction

Function GetSlaverEquipment()
	Form bludgeon    = Game.GetFormFromFile(0x00B0A84D, "DiaryOfMine.esm") As Form  ; DOMBludgeon
	Spell ss_spell   = Game.GetFormFromFile(0x0090B0BE, "DiaryOfMine.esm") As Spell ; DOM Summon Slaves Spell
	Spell sf_spell   = Game.GetFormFromFile(0x00E34C3A, "DiaryOfMine.esm") As Spell ; DOM Summon Followers Spell
	Spell si_spell   = Game.GetFormFromFile(0x00BB1B47, "DiaryOfMine.esm") As Spell ; DOM Info Spell
	Spell sp_spell   = Game.GetFormFromFile(0x00AAA4BD, "DiaryOfMine.esm") As Spell ; DOM Mood Spectrum Spell
	Spell sh_spell   = Game.GetFormFromFile(0x000FEC86, "DiaryOfMine.esm") As Spell ; DOM Hose Spell
	Form bow         = Game.GetFormFromFile(0x001724FD, "DiaryOfMine.esm") As Form  ; DOM Bow
	Form sword       = Game.GetFormFromFile(0x001724FE, "DiaryOfMine.esm") As Form  ; DOM Sword
	Form staff       = Game.GetFormFromFile(0x00103D97, "DiaryOfMine.esm") As Form  ; DOM Staff of Hosing
	Form mind_potion = Game.GetFormFromFile(0x000CFD35, "DiaryOfMine.esm") As Form  ; Mind breaking potion
	Form love_potion = Game.GetFormFromFile(0x000CFD35, "DiaryOfMine.esm") As Form  ; Love potion
	Form lust_potion = Game.GetFormFromFile(0x000CFD35, "DiaryOfMine.esm") As Form  ; Lust potion
	Form lash_potion = Game.GetFormFromFile(0x000C0F91, "DiaryOfMine.esm") As Form  ; Lash potion
	Form whip        = Game.GetFormFromFile(0x0031678F, "DiaryOfMine.esm") As Form  ; DOM Whip
	Form cane        = Game.GetFormFromFile(0x00108EC3, "DiaryOfMine.esm") As Form  ; DOM Cane
	Form collar      = Game.GetFormFromFile(0x00C815DA, "DiaryOfMine.esm") As Form  ; DOM simple collar
	Form magiccollar = Game.GetFormFromFile(0x00BC5FC8, "DiaryOfMine.esm") As Form  ; DOM magic collar	
	Form ironcollar  = DOMZaz.GetIronCollar()
	PlayerAddItemOnce(whip)
	PlayerRef.EquipItem(whip)
	PlayerAddItemOnce(cane)
	PlayerAddItemOnce(bludgeon)
	PlayerRef.AddSpell(ss_spell)
	PlayerRef.AddSpell(sf_spell)
	PlayerRef.AddSpell(sp_spell)
	PlayerRef.AddSpell(sh_spell)
	PlayerRef.EquipSpell(si_spell,0)
	PlayerAddItemOnce(sword)
	PlayerAddItemOnce(bow)
	PlayerAddItemOnce(staff)
	PlayerRef.AddItem(mind_potion, 1)
	PlayerRef.AddItem(love_potion, 1)
	PlayerRef.AddItem(lust_potion, 1)
	PlayerRef.AddItem(lash_potion, 1)
	PlayerRef.AddItem(collar, 1)
	PlayerRef.AddItem(magiccollar, 3)
	if ironcollar != None
		PlayerRef.AddItem(ironcollar, 1)
	endif
EndFunction

Function RegisterAnimations()
	SetOptionFlags(registerSexLab_OID, OPTION_FLAG_DISABLED)
	SetTextOptionValue(registerSexLab_OID, "$Registering")

	DOMZAZ.RegisterForSexLab()
	int numRegistered = 0
	if DOMSexlab.Sexlab != None
		slalLoader Loader = Game.GetFormFromFile(0x0300284D, "SLAnimLoader.esp") As slalLoader
		if Loader != None
			slalData.reloadData()
			Loader.PrepareFactory()
			toggleAllAnims(true)
			numRegistered = Loader.registerAnimations()
		endif
	endif
	
	SetTextOptionValue(registerSexLab_OID,"$Click here")
    SetOptionFlags(registerSexLab_OID, OPTION_FLAG_NONE)
    if numRegistered > 0
		ShowMessage("$Registered Zaz and {" + numRegistered + "} SLAL animations", false)
	else
		ShowMessage("$Registered Zaz animations", false)
	endif
EndFunction

Function toggleAllAnims(bool enable)
  int enableState = slalData.getEnableState()
  int anims = slalData.getAnimations()
  string animID = JMap.nextKey(anims)
  while animID
    JMap.setInt(enableState, animID, enable as int)
    animID = JMap.nextKey(anims, animID)
  endWhile
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_MCM: "+msg)
EndFunction

Function LogTrace(string msg)
	;Debug.Trace("Verbose="+DOMCore.verboseMode+" DOM_MCM: "+msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_MCM: "+msg)
	endif
EndFunction
