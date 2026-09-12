Scriptname DOM_Keys extends Quest  
Import Utility
Import DOM_Util
Import DOM_EquipUtil

DOM_PlayerAlias Property DOMPlayerAlias Auto 
DOM_Core Property DOMCore Auto
DOM_PAH Property DOMPAH Auto
DOM_SlaverManager Property DOM01 Auto
DOM_SlaveManager Property DOM02 Auto
DOM_SEXLAB Property DOMSexlab Auto
DOM_OSTIM Property DOMOstim Auto
DOM_Bathing Property DOMBath Auto
DOM_Equip Property DOMEquip Auto
DOM_ZAZ Property DOMZaz Auto
DOM_Diary Property DOM04 Auto
DOM_Generator Property DOMGenerator Auto
DOM_Animator Property DOM_Anim Auto
Actor Property PlayerRef Auto
ReferenceAlias[] Property SlaveSelectTarget Auto

; DOM Factions
Faction Property DOMActorFaction Auto
Faction Property DOMActorExcludedFaction Auto
Faction Property DOMActorExcludedDialogue Auto
Faction Property DOMActorHasTatsMarks Auto
Faction Property DOMActorHasTatsBrand Auto
Faction Property DOMPlayerSlaveFaction Auto
Faction Property DOMPlayerSlaverFaction Auto
Faction Property DOMPotentialSlaverFaction Auto
Faction Property DOMTraineeCount Auto
Faction Property DOMShouldBeNaked Auto
Faction Property DOMShouldBeNoOrgasm Auto
Faction Property DOMShouldBeSilent Auto
Faction Property DOMTobeComfortedFaction Auto
Faction Property DOMActionFleeing Auto
Faction Property DOMActionFollowing Auto
Faction Property DOMActionWaiting Auto
Faction Property DOMActionMasturbating Auto
Faction Property DOMActionTied Auto
Faction Property DOMActionOnDuty Auto
Faction Property DOMFollowMode Auto
Faction Property DOMWaitMode Auto
Faction Property DOMTravelMode Auto
Faction Property DOMWorkMode Auto
Faction Property DOMBeingCaptured Auto
Faction Property DOMIsNaked Auto
Faction Property DOMIsRespectful Auto
Faction Property DOMShouldBeRespectful Auto
Faction Property DOMShouldWalkOnFour Auto

Faction Property DOMVirginSame Auto
Faction Property DOMVirginVaginal Auto
Faction Property DOMFacetSensuality Auto

Faction Property DOMTrainSubmission Auto
Faction Property DOMTrainFear Auto
Faction Property DOMTrainHumiliation Auto
Faction Property DOMTrainAnger Auto
Faction Property DOMTrainResignation Auto
Faction Property DOMTrainRespect Auto

Faction Property DOMTrainVaginal Auto
Faction Property DOMTrainOral Auto
Faction Property DOMTrainAnal Auto

Faction Property DOMModHumility Auto      ; Submission
Faction Property DOMModFearfulness Auto   ; Fear
Faction Property DOMModNaivety Auto       ; Humiliation
Faction Property DOMModForgiveness Auto   ; Anger
Faction Property DOMModPrudent Auto       ; Resignation
Faction Property DOMModDiscipline Auto    ; Respect

Faction Property DOMModPerfectionism Auto ; Conscientious (House keeping)
Faction Property DOMModSentimentality Auto; Emotionality
Faction Property DOMModDaring Auto        ; Extraversion
Faction Property DOMModDiligent Auto      ; Conscientiousness
Faction Property DOMModManipulation Auto  ; Openness

Faction Property DOMModVaginal Auto       ; Honesty
Faction Property DOMModOral Auto		  ; eXtraversion
Faction Property DOMModAnal Auto		  ; Agreeableness
Faction Property DOMModAuthority Auto     ; Openness (Work training)
Faction Property DOMModIngenuity Auto     ; Extraversion

Faction Property DOMModInsensitivity Auto ; Enforcer 
Faction Property DOMModIntimidate Auto    ; Persuader 
Faction Property DOMModSelfEsteem Auto    ; Depraver
Faction Property DOMModResentment Auto    ; Predator 
Faction Property DOMModController Auto    ; Slaver
Faction Property DOMModPretender Auto     ; Deceiver

Faction Property DOMMoodBroken Auto
Faction Property DOMMoodInlove Auto

; More factions
Faction Property PlayerFollowerFaction Auto
Faction Property CurrentFollowerFaction Auto
Faction Property pTweakWaitingFaction Auto Hidden
Faction Property pTweakPosedFaction Auto Hidden
Faction Property pTweakSandboxFaction Auto Hidden

; Forms
Form Property DOMBurlapSack Auto

; Idles
Idle Property pa_DOMOverwhelm Auto
Idle Property pa_DOMNeckBreak Auto
Idle Property pa_DOMSleeper Auto
Idle Property ExitBed Auto
Idle Property ExitChairFront Auto

; Keywords
Keyword Property ActorTypeNPC Auto
Keyword Property ActorTypeCreature Auto
Keyword Property ActorTypeUndead Auto
Keyword Property ActorTypeAnimal Auto
Keyword Property BodyBag Auto

; Package
Package Property DOMBeTiedOrWait Auto

; Toggles
bool Property debugKeyMode = false Auto Hidden
bool Property alarmToggleAbduction = true Auto Hidden
bool Property alarmToggleAbduction2 = true Auto Hidden
bool Property alarmToggleWitness = true Auto Hidden
bool Property alarmToggleWitness2 = true Auto Hidden
bool Property alarmToggleWitness3 = true Auto Hidden
bool Property menuPAH = false Auto Hidden
bool Property menuSlavers = true Auto Hidden
bool Property menuExtraSlaves = true Auto Hidden
bool Property wheelUsesDefaultPunishmentType = false Auto Hidden
bool Property wheelUsesDefaultPraiseType = false Auto Hidden
bool Property wheelIsDefaultMenu = true Auto Hidden
bool Property wheelIsDefaultCall = false Auto Hidden
bool Property forbidAnimalCapture = false Auto Hidden
bool Property forbidCreatureCapture = false Auto Hidden
bool Property forbidUndeadCapture = false Auto Hidden
bool Property tieupWhenUnBagToggle = true Auto Hidden

; Misc
ObjectReference Property DOMTonyMarker Auto
MiscObject Property Gold001 Auto

; Topics
Topic Property DOM02TopicAnswerAttack Auto

; Message boxes
Message Property DOMWheelGroupMessage Auto 
Message Property DOMGroupStatusMessage Auto
Message Property DOMGroupAbuseMessage Auto
Message Property DOMGroupOrderMessage Auto
Message Property DOMGroupTrainingMessage Auto

Message Property DOMGroupTieupMessage Auto
Message Property DOMGroupRestrainMessage Auto
Message Property DOMGroupBlindfoldMessage Auto
Message Property DOMGroupCuffsMessage Auto 
Message Property DOMGroupPlugsMessage Auto

Message Property DOMGroupAttentionMessage Auto
Message Property DOMGroupUpkeepingMessage Auto
Message Property DOMGroupClothesMessage Auto

Message Property DOMWheelSlaveMessage Auto 
Message Property DOMSlaveStatusMessage Auto 
Message Property DOMSlaveAbuseMessage Auto 
Message Property DOMSlaveOrderMessage Auto 
Message Property DOMSlaveTrainingMessage Auto 

Message Property DOMSlaveTieupMessage Auto
Message Property DOMSlaveBlindfoldMessage Auto
Message Property DOMSlaveCuffsMessage Auto 
Message Property DOMSlavePlugsMessage Auto 

Message Property DOMSlaveRecruitMessage Auto 
Message Property DOMSlaveFollowMessage Auto 
Message Property DOMSlaveStandMessage Auto 
Message Property DOMSlaveWaitMessage Auto 
Message Property DOMSlaveTaskMessage Auto 
Message Property DOMSlaveJailMessage Auto 
Message Property DOMSlaveTravelMessage Auto 
Message Property DOMSlaveSexyPoseMessage Auto
Message Property DOMSlavePoseMessage Auto
Message Property DOMSlaveGagAndBlindfoldMessage Auto
Message Property DOMSlaveAttentionMessage Auto
Message Property DOMSlavePraiseMessage Auto
Message Property DOMSlavePunishMessage Auto
Message Property DOMSlaveThreatMessage Auto
Message Property DOMSlaveInspectMessage Auto
Message Property DOMSlaveMasturbateMessage Auto
Message Property DOMSlaveClothesMessage Auto
Message Property DOMSlaveSexMessage Auto
Message Property DOMSlaveKinkyMessage Auto
Message Property DOMSlaveKissMessage Auto
Message Property DOMSlavePromiseMessage Auto
Message Property DOMSlaveComfortMessage Auto
Message Property DOMSlaverComfortMessage Auto
Message Property DOMSlaveFlatterMessage Auto
Message Property DOMSlaveInsultMessage Auto
Message Property DOMSlaveUpkeepingMessage Auto
Message Property DOMSlaveBathingMessage Auto
Message Property DOMSlavePotionMessage Auto
Message Property DOMSlaveRopesMessage Auto
Message Property DOMSlaveChainsMessage Auto
Message Property DOMSlaveRestrainMessage Auto
Message Property DOMSlaveWheelMessage Auto
Message Property DOMSlaveCrossMessage Auto
Message Property DOMSlavePilloryMessage Auto
Message Property DOMSlaveCageMessage Auto
Message Property DOMSlavePostMessage Auto
Message Property DOMSlaveSelectMessage Auto
 
Message Property DOMWheelSlaverMessage Auto 
Message Property DOMSlaverStatusMessage Auto 

Message Property DOMWheelTrainerMessage Auto
Message Property DOMTrainerOrderMessage Auto
Message Property DOMTrainerAbuseMessage Auto

Message Property DOMBurlapSackMessage Auto 

Message Property DOMWheelNPCMessage Auto
Message Property DOMNPCStatusMessage Auto 
Message Property DOMNPCRecruitMessage Auto 
Message Property DOMNPCAbuseMessage Auto 
Message Property DOMNPCSexMessage Auto 

Function Initialize()
	LogInfo("================================================================================")
	LogInfo("==                         DOM: Keys and wheel menus                          ==")
	LogInfo("================================================================================")
	if DOMPlayerAlias == None
		ReferenceAlias player_alias = DOMCore.GetAliasByName("PlayerAlias") as ReferenceAlias
		DOMPlayerAlias = player_alias as DOM_PlayerAlias
		LogInfo("WARNING: DOMPlayerAlias was not set - trying to recover DOMPlayerAlias="+DOMPlayerAlias)
	endif
	UnRegisterForCaptureAnimationEvent()
	RegisterForCaptureAnimationEvent() ; remember to re-register for events each game reload
	UnRegisterForTieupAnimationEvent()
	RegisterForTieupAnimationEvent()
	UnRegisterForUntieAnimationEvent()
	RegisterForUntieAnimationEvent()
	if DOMZaz == None && DOMCore.DOMZaz != None
		LogTrace("Recovering DOMZaz")
		DOMZaz = DOMCore.DOMZaz
	endif
	If (Game.GetModByName("AmazingFollowerTweaks.esp") != 255)
		pTweakWaitingFaction = Game.GetFormFromFile(0x00032CCB, "AmazingFollowerTweaks.esp") as Faction
		pTweakPosedFaction   = Game.GetFormFromFile(0x0002142B, "AmazingFollowerTweaks.esp") as Faction
		pTweakSandboxFaction = Game.GetFormFromFile(0x0003D3F3, "AmazingFollowerTweaks.esp") as Faction
	else
		pTweakWaitingFaction = None
		pTweakPosedFaction   = None
		pTweakSandboxFaction = None
	Endif
	registerKeys()
EndFunction

Function ClearAliases(Actor akRef)
	int n = SlaveSelectTarget.length
	int i = 0
	while i < n 
		if SlaveSelectTarget[i].GetRef() == akRef
			SlaveSelectTarget[i].clear()
		endif
		i += 1
	endwhile
EndFunction

Int Property modifierKeyDefault  = -1 Auto Hidden
Int Property modifierKey  = 42 Auto Hidden
Int Property actionKey    = -1 Auto Hidden ; 34=G
Int Property diaryKey     = -1 Auto Hidden
Int Property menu0Key     = -1 Auto Hidden
Int Property menu1Key     = 21 Auto Hidden ; Y
Int Property menu2Key     = 22 Auto Hidden ; U
Int Property menu3Key     = -1 Auto Hidden
Int Property menu4Key     = -1 Auto Hidden
Int Property menu5Key     = -1 Auto Hidden
Int Property menu6Key     = -1 Auto Hidden
Int Property menu7Key     = 38 Auto Hidden ; L
Int Property menu8Key     = -1 Auto Hidden
Int Property menu9Key     = -1 Auto Hidden
Int Property menu10Key    = -1 Auto Hidden
Int Property abductionKey = 35 Auto Hidden ; H
Int Property bagInKey     = -1 Auto Hidden
Int Property bagOutKey    = -1 Auto Hidden
Int Property traitsKey    = -1 Auto Hidden
Int Property feelsKey     = -1 Auto Hidden
Int Property statusKey    = -1 Auto Hidden
Int Property moodKey      = -1 Auto Hidden
Int Property moveKey      = -1 Auto Hidden ; 48=B
Int Property inventoryKey = 24 Auto Hidden ; O
Int Property praiseKey    = -1 Auto Hidden
Int Property scoldKey     = -1 Auto Hidden
Int Property punishKey    = -1 Auto Hidden
Int Property chokeKey     = -1 Auto Hidden
Int Property attentionKey = -1 Auto Hidden
Int Property kneelKey     = -1 Auto Hidden
Int Property favorKey     = -1 Auto Hidden
Int Property ripoffKey    = -1 Auto Hidden
Int Property stripKey     = -1 Auto Hidden
Int Property comeKey      = -1 Auto Hidden
Int Property fixmeKey     = 37 Auto Hidden ; K
Int Property testPoseKey  = -1 Auto Hidden
Int Property traitsDigitsKey = -1 Auto Hidden
Int Property feelsDigitsKey  = -1 Auto Hidden
Int Property followKey       = -1 Auto Hidden
Int Property followAllKey    = -1 Auto Hidden

Function registerKeys()
	if menu0Key != -1 && menu0Key
		RegisterForKey(menu0Key)
	endif
	if menu1Key != -1 && menu1Key
		RegisterForKey(menu1Key)
	endif
	if menu2Key != -1 && menu2Key
		RegisterForKey(menu2Key)
	endif
	if menu3Key != -1 && menu3Key
		RegisterForKey(menu3Key)
	endif
	if menu4Key != -1 && menu4Key
		RegisterForKey(menu4Key)
	endif
	if menu5Key != -1 && menu5Key
		RegisterForKey(menu5Key)
	endif
	if menu6Key != -1 && menu6Key
		RegisterForKey(menu6Key)
	endif
	if menu7Key != -1 && menu7Key
		RegisterForKey(menu7Key)
	endif
	if menu8Key != -1 && menu8Key
		RegisterForKey(menu8Key)
	endif
	if menu9Key != -1 && menu9Key
		RegisterForKey(menu9Key)
	endif
	if menu10Key != -1 && menu10Key
		RegisterForKey(menu10Key)
	endif
	if abductionKey != -1 && abductionKey
		RegisterForKey(abductionKey)
	endif
	if bagInKey != -1 && bagInKey
		RegisterForKey(bagInKey)
	endif
	if bagOutKey != -1 && bagOutKey
		RegisterForKey(bagOutKey)
	endif
	if traitsKey != -1 && traitsKey
		RegisterForKey(traitsKey)
	endif
	if feelsKey != -1 && feelsKey
		RegisterForKey(feelsKey)
	endif
	if statusKey != -1 && statusKey
		RegisterForKey(statusKey)
	endif
	if moodKey != -1 && moodKey
		RegisterForKey(moodKey)
	endif
	if moveKey != -1 && moveKey
		RegisterForKey(moveKey)
	endif
	if inventoryKey != -1 && inventoryKey
		RegisterForKey(inventoryKey)
	endif
	if praiseKey != -1 && praiseKey
		RegisterForKey(praiseKey)
	endif
	if scoldKey != -1 && scoldKey
		RegisterForKey(scoldKey)
	endif
	if punishKey != -1 && punishKey
		RegisterForKey(punishKey)
	endif
	if chokeKey != -1 && chokeKey
		RegisterForKey(chokeKey)
	endif
	if kneelKey != -1 && kneelKey
		RegisterForKey(kneelKey)
	endif
	if attentionKey != -1 && attentionKey
		RegisterForKey(attentionKey)
	endif
	if favorKey != -1 && favorKey
		RegisterForKey(favorKey)
	endif
	if ripoffKey != -1 && ripoffKey
		RegisterForKey(ripoffKey)
	endif
	if stripKey != -1 && stripKey
		RegisterForKey(stripKey)
	endif
	if actionKey != -1 && actionKey
		RegisterForKey(actionKey)
	endif
	if diaryKey != -1 && diaryKey
		RegisterForKey(diaryKey)
	endif
	if comeKey != -1 && comeKey
		RegisterForKey(comeKey)
	endif
	if fixmeKey != -1 && fixmeKey
		RegisterForKey(fixmeKey)
	endif
	if testPoseKey != -1 && testPoseKey
		RegisterForKey(testPoseKey)
	endif
	if traitsDigitsKey != -1 && traitsDigitsKey
		RegisterForKey(traitsDigitsKey)
	endif
	if feelsDigitsKey != -1 && feelsDigitsKey
		RegisterForKey(feelsDigitsKey)
	endif
	if followKey != -1 && followKey
		RegisterForKey(followKey)
	endif
	if followAllKey != -1 && followAllKey
		RegisterForKey(followAllKey)
	endif
EndFunction

Function refreshKeys()
	UnregisterForAllKeys()
	registerKeys()
EndFunction

Actor Function GetCurrentCrosshairActor()
	Actor akTarget = Game.GetCurrentCrosshairRef() As Actor
	if akTarget != None
		If actionKey && (current_keypressed == actionKey)
			if DOMCore.ActionGroup
				HudNotification("Action key target: Group")
			else
				HudNotification("Action key target: "+akTarget.getDisplayName())
			endif
		else
			HudNotification("Menu target: "+akTarget.getDisplayName())
		endif
	else
		If actionKey && (current_keypressed == actionKey)
			akTarget = previous_target
			if DOMCore.ActionGroup
				HudNotification("Action key target: Group")
			elseif akTarget != None
				HudNotification("Action key target: "+akTarget.getDisplayName())
			endif
		else
			HudNotification("Menu target: Group")
		endif
	endif
	return akTarget
EndFunction

DOM_BurlapSack Function GetCurrentCrosshairBurlapSack()
	DOM_BurlapSack akTarget = Game.GetCurrentCrosshairRef() As DOM_BurlapSack
	if akTarget == None
		HudNotification("Wheel menu target: Group")
	else
		HudNotification("Wheel menu target: "+akTarget.getDisplayName())
	endif
	return akTarget
EndFunction

int current_keypressed = -1
Event OnKeyDown(Int KeyCode)
	If IsInMenuMode()
		return
	endif
	If UI.IsTextInputEnabled() || UI.IsMenuOpen("Crafting Menu")
        return
    endif
	;Logtrace("DOM::OnKeyDown key="+KeyCode)
	if modifierKeyDefault > 0
		if !Input.IsKeyPressed(modifierKeyDefault) && !Input.IsKeyPressed(modifierKey)
			return
		endif
	endif
	current_keypressed = KeyCode
	If traitsKey && (KeyCode == traitsKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoNPCTraits(GetCurrentCrosshairActor())
		else
			DOMDoNPCTraitsVerbose(GetCurrentCrosshairActor())
		endif
	elseIf feelsKey && (KeyCode == feelsKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoNPCFeelings(GetCurrentCrosshairActor())
		else
			DOMDoNPCFeelingsVerbose(GetCurrentCrosshairActor())
		endif
	elseIf statusKey && (KeyCode == statusKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDOMood(GetCurrentCrosshairActor())
		else
			DOMDoStatus(GetCurrentCrosshairActor())
		endif
	elseIf moodKey && (KeyCode == moodKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoStatus(GetCurrentCrosshairActor())
		else
			DOMDOMood(GetCurrentCrosshairActor())
		endif
	elseIf moveKey && (KeyCode == moveKey)
		;if Input.IsKeyPressed(modifierKey)
		;	DOMDOMorph(GetCurrentCrosshairActor())
		;else
		;	DOMDOMoveBone(GetCurrentCrosshairActor())
		;endif
	elseIf followKey && (KeyCode == followKey)
		if Input.IsKeyPressed(modifierKey)
			DOMAllOrderSlavesAndSlavers("Follow")
			if menuPAH
				DOMPAH.AllFollow()
			endif
		else
			DOMAllOrderSlavesAndSlavers("FollowIfPosing")
			if menuPAH
				DOMPAH.AllFollowIfPosing()
			endif
		endif
	elseIf followAllKey && (KeyCode == followAllKey)
		if Input.IsKeyPressed(modifierKey)
			DOMAllOrderSlavesAndSlavers("FollowIfPosing")
			if menuPAH
				DOMPAH.AllFollowIfPosing()
			endif
		else
			DOMAllOrderSlavesAndSlavers("Follow")
			if menuPAH
				DOMPAH.AllFollow()
			endif
		endif
	elseIf inventoryKey && (KeyCode == inventoryKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoAllowOrgasm(GetCurrentCrosshairActor())
		else
			DOMDoOpenInventory(GetCurrentCrosshairActor())
		endif
	elseIf comeKey && (KeyCode == comeKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoOpenInventory(GetCurrentCrosshairActor())
		else
			DOMDoAllowOrgasm(GetCurrentCrosshairActor())
		endif
	elseIf praiseKey && (KeyCode == praiseKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoScold(GetCurrentCrosshairActor())
		else
			DOMDoPraise(GetCurrentCrosshairActor())
		endif
	elseIf scoldKey && (KeyCode == scoldKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoPraise(GetCurrentCrosshairActor())
		else
			DOMDoScold(GetCurrentCrosshairActor())
		endif
	elseIf punishKey && (KeyCode == punishKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoChoke(GetCurrentCrosshairActor())
		else
			DOMSetExample(GetCurrentCrosshairActor())
		endif
	elseIf chokeKey && (KeyCode == chokeKey)
		if Input.IsKeyPressed(modifierKey)
			DOMSetExample(GetCurrentCrosshairActor())
		else
			DOMDoChoke(GetCurrentCrosshairActor())
		endif
	elseIf kneelKey && (KeyCode == kneelKey)
		if Input.IsKeyPressed(modifierKey)
			DOMAllOrderSlaves("Attention")
			if menuPAH
				DOMPAH.AllAttention()
			endif
		else
			DOMAllOrderSlaves("Kneel")
			if menuPAH
				DOMPAH.AllKneel()
			endif
		endif
	elseIf attentionKey && (KeyCode == attentionKey)
		if Input.IsKeyPressed(modifierKey)
			DOMAllOrderSlaves("Kneel")
			if menuPAH
				DOMPAH.AllKneel()
			endif
		else
			DOMAllOrderSlaves("Attention")
			if menuPAH
				DOMPAH.AllAttention()
			endif
		endif
	elseIf menu0Key && (KeyCode == menu0Key)
		if Input.IsKeyPressed(modifierKey)
			DOMDoCallMenu(GetCurrentCrosshairActor())
		else
			DOMDoCallSlaveMenu(GetCurrentCrosshairActor())
		endif
	elseIf menu1Key && (KeyCode == menu1Key)
		if Input.IsKeyPressed(modifierKey)
			DOMDoStatusMenu(GetCurrentCrosshairActor())
		else
			DOMDoOrderMenu(GetCurrentCrosshairActor())
		endif
	elseIf menu2Key && (KeyCode == menu2Key)
		if Input.IsKeyPressed(modifierKey)
			DOMDoTrainingMenu(GetCurrentCrosshairActor())
		else
			DOMDoAbuseMenu(GetCurrentCrosshairActor())
		endif
	elseIf menu3Key && (KeyCode == menu3Key)
		if Input.IsKeyPressed(modifierKey)
			DOMDoOrderMenu(GetCurrentCrosshairActor())
		else
			DOMDoStatusMenu(GetCurrentCrosshairActor())
		endif
	elseIf menu4Key && (KeyCode == menu4Key)
		if Input.IsKeyPressed(modifierKey)
			DOMDoAbuseMenu(GetCurrentCrosshairActor())
		else
			DOMDoTrainingMenu(GetCurrentCrosshairActor())
		endif
	elseIf menu5Key && (KeyCode == menu5Key)
		if Input.IsKeyPressed(modifierKey)
			DOMAllStatusMenu()
		else
			DOMAllOrderMenu()
		endif
	elseIf menu6Key && (KeyCode == menu6Key)
		if Input.IsKeyPressed(modifierKey)
			DOMAllOrderMenu()
		else
			DOMAllStatusMenu()
		endif
	elseIf menu9Key && (KeyCode == menu9Key)
		if Input.IsKeyPressed(modifierKey)
			DOMAllTrainingMenu()
		else
			DOMAllAbuseMenu()
		endif
	elseIf menu10Key && (KeyCode == menu10Key)
		if Input.IsKeyPressed(modifierKey)
			DOMAllAbuseMenu()
		else
			DOMAllTrainingMenu()
		endif
	elseIf menu7Key && (KeyCode == menu7Key)
		if Input.IsKeyPressed(modifierKey)
			DOMDoTrainerAbuseMenu(GetCurrentCrosshairActor())
		else
			DOMDoTrainerManagementMenu(GetCurrentCrosshairActor())
		endif
	elseIf menu8Key && (KeyCode == menu8Key)
		if Input.IsKeyPressed(modifierKey)
			DOMDoTrainerManagementMenu(GetCurrentCrosshairActor())
		else
			DOMDoTrainerAbuseMenu(GetCurrentCrosshairActor())
		endif
	elseIf stripKey && (KeyCode == stripKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoRipOff(GetCurrentCrosshairActor())
		else
			DOMDoStrip(GetCurrentCrosshairActor())
		endif
	elseIf ripoffKey && (KeyCode == ripoffKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoStrip(GetCurrentCrosshairActor())
		else
			DOMDoRipOff(GetCurrentCrosshairActor())
		endif
	elseIf bagInKey && (KeyCode == bagInKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoTakeOutOfBag(PlayerRef,GetCurrentCrosshairBurlapSack(),tieupWhenUnBagToggle)
		else
			DOMDoPutInBag(GetCurrentCrosshairActor())
		endif
	elseIf bagOutKey && (KeyCode == bagOutKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoPutInBag(GetCurrentCrosshairActor())
		else
			DOMDoTakeOutOfBag(PlayerRef,GetCurrentCrosshairBurlapSack(),tieupWhenUnBagToggle)
		endif
	elseIf traitsDigitsKey && (KeyCode == traitsDigitsKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoNPCTraitsVerbose(GetCurrentCrosshairActor())
		else
			DOMDoNPCTraits(GetCurrentCrosshairActor())
		endif
	elseIf feelsDigitsKey && (KeyCode == feelsDigitsKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoNPCFeelingsVerbose(GetCurrentCrosshairActor())
		else
			DOMDoNPCFeelings(GetCurrentCrosshairActor())
		endif
	elseIf testPoseKey && (KeyCode == testPoseKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoFixMe(GetCurrentCrosshairActor())
		else
			DOMDoTestPose(GetCurrentCrosshairActor())
		endif
	elseIf fixmeKey && (KeyCode == fixmeKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoTestPose(GetCurrentCrosshairActor())
		else
			DOMDoFixMe(GetCurrentCrosshairActor())
		endif
	elseIf actionKey && (KeyCode == actionKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoOpenDiary(GetCurrentCrosshairActor())
		else
			DOMDoAction(GetCurrentCrosshairActor())
		endif
	elseIf diaryKey && (KeyCode == diaryKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoAction(GetCurrentCrosshairActor())
		else
			DOMDoOpenDiary(GetCurrentCrosshairActor())
		endif
	endif
	; For oher keys, make sure player and is not in a Sexlab scene
	If DOMSexlab.IsAnimating(PlayerRef)
		return
	endif
	If abductionKey && (KeyCode == abductionKey)
		if Input.IsKeyPressed(modifierKey)
			DOMDoFavor(GetCurrentCrosshairActor())
		else
			DOMActorAbduction(GetCurrentCrosshairActor())
		endif
	elseIf favorKey && (KeyCode == favorKey)
		if Input.IsKeyPressed(modifierKey)
			DOMActorAbduction(GetCurrentCrosshairActor())
		else
			DOMDoFavor(GetCurrentCrosshairActor())
		endif
	endif
EndEvent

; ### DOM

bool Function isADOMSlave(Actor akTarget) ; Is a player's slave
	if akTarget.IsInFaction(DOMPlayerSlaveFaction)
		return true
	endif	
	return false
EndFunction

bool Function isADOMTrainer(Actor akTarget) ; Is a player's slave or slaver
	if akTarget.IsInFaction(DOMPlayerSlaverFaction)
		return true
	endif
	if akTarget.GetFactionRank(DOMPlayerSlaveFaction) == 2
		return true
	endif
	return false
EndFunction

bool Function isADOMActor(Actor akTarget) ; Is a player's slave or slaver
	if akTarget.IsInFaction(DOMPlayerSlaveFaction)
		return true
	endif
	if akTarget.IsInFaction(DOMPlayerSlaverFaction)
		return true
	endif	
	return false
EndFunction

; ### Wheel menu

Function DOMDoCallMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMDoCallGroupMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif

	if akTarget.IsInFaction(DOMPlayerSlaverFaction)
		DOMDoCallSlaverMenu(akTarget)
	elseif DOMPAH.isPAH(akTarget) || isADOMSlave(akTarget)
		if akTarget.GetFactionRank(DOMPlayerSlaveFaction) == 2
			DOMDoCallTrainerMenu(akTarget)
		else
			DOMDoCallSlaveMenu(akTarget)
		endif
	else
		DOMDoCallNPCMenu(akTarget)
	endif
EndFunction

Int Function ShowCallSlaveMenu(Actor akTarget)		
	if !wheelIsDefaultCall
		return DOMWheelSlaveMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Slave menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Order ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Order ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Abuse ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Abuse ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Training ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Training ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Restrain ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Restrain ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Clothes ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Clothes ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoCallSlaveMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if !akTarget.IsInFaction(DOMPlayerSlaveFaction)
		return
	endif
	int idx = ShowCallSlaveMenu(akTarget)
	Debug.Notification("Call slave menu: "+idx)
	if idx == 0
		DOMDoStatusMenu(akTarget)
	elseif idx == 1
		DOMDoOrderMenu(akTarget) 
	elseif idx == 2
		DOMDoAbuseMenu(akTarget)
	elseif idx == 3
		DOMDoTrainingMenu(akTarget) 
	elseif idx == 4
		DOMDoTieUpMenu(akTarget)
	elseif idx == 5
		DOMDoClothesMenu(akTarget)
	endif
EndFunction

Int Function ShowCallTrainerMenu(Actor akTarget)		
	if !wheelIsDefaultCall
		return DOMWheelTrainerMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Trainer menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Order ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Order ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Abuse ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Abuse ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Training ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Training ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Management ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Management ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Trainees ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Trainees ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoCallTrainerMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	int idx = ShowCallTrainerMenu(akTarget)
	Debug.Notification("Call trainer menu: "+idx)
	if idx == 0
		DOMDoStatusMenu(akTarget) 
	elseif idx == 1
		DOMDoOrderMenu(akTarget)
	elseif idx == 2
		DOMDoAbuseMenu(akTarget) 
	elseif idx == 3
		DOMDoTrainingMenu(akTarget) 
	elseif idx == 4
		DOMDoTrainerManagementMenu(akTarget)
	elseif idx == 5
		DOMDoTrainerAbuseMenu(akTarget)
	endif
EndFunction

Int Function ShowCallSlaverMenu(Actor akTarget)		
	if !wheelIsDefaultCall
		return DOMWheelSlaverMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Slaver menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Order ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Order ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Speech ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Speech ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Physical ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Physical ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Management ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Management ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Trainees ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Trainees ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoCallSlaverMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	int idx = ShowCallSlaverMenu(akTarget)
	Debug.Notification("Call slaver menu: "+idx)
	if idx == 0
		DOMDoStatusMenu(akTarget) 
	elseif idx == 1
		DOMDoOrderMenu(akTarget)
	elseif idx == 2
		DOMDoAbuseMenu(akTarget) 
	elseif idx == 3
		DOMDoTrainingMenu(akTarget) 
	elseif idx == 4
		DOMDoTrainerManagementMenu(akTarget)
	elseif idx == 5
		DOMDoTrainerAbuseMenu(akTarget)
	endif
EndFunction

Int Function ShowCallNPCMenu(Actor akTarget)		
	if !wheelIsDefaultCall
		return DOMWheelNPCMessage.Show()
	endif
	if debugKeyMode
		HudNotification("NPC menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Services ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Services ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Abuse ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Abuse ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Training ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Training ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoCallNPCMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	int idx = ShowCallNPCMenu(akTarget)
	Debug.Notification("Call NPC menu: "+idx)
	if idx == 0
		DOMDoNPCMenu(akTarget)
	elseif idx == 1
		DOMDoNPCSlaveMenu(akTarget)
	elseif idx == 2
		DOMDoNPCAbuseMenu(akTarget)
	elseif idx == 3 || idx == 6
		DOMActorAbduction(akTarget)
	endif
EndFunction

Int Function ShowCallGroupMenu()		
	if !wheelIsDefaultCall
		return DOMWheelGroupMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Group menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Status ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Order ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Order ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Abuse ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Abuse ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Training ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Training ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Pose ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Pose ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Restrain ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Restrain ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Attention ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Attention ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Clothes ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Clothes ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoCallGroupMenu()
	int idx = ShowCallGroupMenu()
	Debug.Notification("Call group menu: "+idx)
	if idx == 0
		DOMAllStatusMenu() 
	elseif idx == 1
		DOMAllOrderMenu()
	elseif idx == 2
		DOMAllAbuseMenu()
	elseif idx == 3
		DOMAllTrainingMenu()
	elseif idx == 4
		DOMAllPoseMenu()
	elseif idx == 5
		DOMAllTieUpMenu(true,true)
	elseif idx == 6
		DOMAllAttentionMenu()
	elseif idx == 7
		DOMAllClothesMenu()
	endif
EndFunction

Function DOMDoOrderMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMAllOrderMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif
	if isADOMActor(aktarget)
		int imenu = ShowDOMOrderMenu(akTarget)
		; Orders menu
		bool is_on_duty = akTarget.IsInFaction(DOMActionOnDuty)
		if imenu == 0
			DOMDoOpenInventory(akTarget)
		elseif imenu == 1
			DOMDoFollowMe(akTarget)
		elseif imenu == 2
			DOMDoStandStill(akTarget) ; not sandbox
		elseif is_on_duty
			if imenu == 5
				if isADOMSlave(akTarget)
					DOMDoPutInBag(akTarget)
				endif
			elseif imenu == 4
				DOMDoFavor(akTarget)
			endif
		elseif imenu == 3
			DOMDoWaitSandbox(akTarget) ; sandbox
		elseif imenu == 5
			if akTarget.IsInFaction(DOMActionTied)
				DOMDoUntie(akTarget)
			elseif isADOMSlave(akTarget)
				DOMDoPutInBag(akTarget)
			endif
		elseif imenu == 6
			if isADOMSlave(akTarget)
				DOMDoTieUpMenu(akTarget)
			endif
		elseif imenu == 7
			DOMDoPoseMenu(akTarget)
		elseif imenu == 4
			DOMDoFavor(akTarget)
		endif
	elseif DOMPAH.isPAH(akTarget)
		DOMPAH.DoOrderMenu(akTarget)
	else
		DOMDoNPCMenu(akTarget)
	endif
EndFunction

Int Function ShowDOMOrderMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlaveOrderMessage.Show()
	endif
	DOM_Actor sl_alias = None
	if akTarget != None
		sl_alias = DOMCore.GetActor(akTarget)
	endif
	if debugKeyMode
		HudNotification("Order menu for "+akTarget.getDisplayName())
	endif
	bool is_on_duty = akTarget.IsInFaction(DOMActionOnDuty)
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Inventory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Inventory ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	if sl_alias != None && sl_alias.behaviour != "follow_player"
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Follow me ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Follow me ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	elseif !is_on_duty
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Following ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Follow mode ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	endif
	
	if is_on_duty
		string msg_duty = "On duty "
		if sl_alias != None
			msg_duty = sl_alias.GetBehaviourTitle()+" "
		endif
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = msg_duty)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = msg_duty)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = false)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
		if sl_alias != None && sl_alias.canAnimate
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Put in bag ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Put in bag ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		else
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
		endif
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)
	else
		if sl_alias != None && sl_alias.behaviour != "wait"
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Stand still ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Stand still ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Standing ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Stand mode ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
		endif
	
		if sl_alias != None && sl_alias.behaviour != "wait_sandbox"
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Wait here ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Wait here ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Waiting ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Wait mode ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		endif
	
		if sl_alias != None && sl_alias.mind.is_slave
			if sl_alias.is_restrained
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Untie ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Untie ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
			elseif !sl_alias.canAnimate
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
			else
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Put in bag ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Put in bag ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
			endif

			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Tie up ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Tie up ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		elseif akTarget.IsInFaction(DOMActionTied)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Untie ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Untie ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		endif
	
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Pose for me ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Pose ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif
	
	if !sl_alias.is_restrained
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Order to ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Order to ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	endif
	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoAbuseMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMAllAbuseMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif
	if isADOMActor(aktarget)
		int imenu = ShowDOMAbuseMenu(akTarget)
		LogTrace("DOMDoAbuseMenu "+akTarget.GetName()+" imenu="+imenu)
		; Punish & praise menu
		if imenu == 0
			DOMDoPunishingMenu(akTarget)
		elseif imenu == 1
			DOMDoUpkeeping(akTarget)
		elseif imenu == 2
			DOMDoInsultMenu(akTarget)
		elseif imenu == 3
			DOMDoThreatenMenu(akTarget)
		elseif imenu == 4
			DOMDoPraisingMenu(akTarget)
		elseif imenu == 5
			DOMDoComfortMenu(akTarget)
		elseif imenu == 6
			DOMDoFlatterMenu(akTarget)
		elseif imenu == 7
			DOMDoPromiseMenu(akTarget)
		endif
	elseif DOMPAH.isPAH(akTarget)
		DOMPAH.DoAbuseMenu(akTarget)
	else
		DOMDoNPCAbuseMenu(akTarget)
	endif
EndFunction

Function DOMDoNPCAbuseMenu(Actor akTarget)
	if akTarget == None || akTarget.IsChild()
		return
	endif
	int imenu = ShowDOMNPCAbuseMenu(akTarget)
	if imenu == 0
		DOMDoNPCShower(akTarget)
	elseif imenu == 1
		DOMDoNPCBathMe(akTarget)
	elseif imenu == 2 
		DOMDoInsultMenu(akTarget)
	elseif imenu == 5 
		DOMDoComfortMenu(akTarget)
	elseif imenu == 6 
		DOMDoFlatterMenu(akTarget)
	elseif imenu == 7
		DOMDoWalkOnFour(akTarget)
	endif
EndFunction

Int Function ShowDOMNPCAbuseMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		int imenu = DOMNPCAbuseMessage.Show()
		if imenu > 2
			imenu += 1
		endif
		return imenu
	endif
	if debugKeyMode
		HudNotification("Abuse menu for "+akTarget.getDisplayName())
	endif
			
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Shower ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Shower ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Bath me ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Bath me ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Insult ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Insult ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Feed ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Feed ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Hug ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Hug ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Flatter")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Flatter")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		
	if !akTarget.IsInFaction(DOMShouldWalkOnFour)
		if akTarget.IsInFaction(DOMShouldBeRespectful) && akTarget.HasKeyword(ActorTypeNPC) && !DOMZaz.hasCuffs(akTarget)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Walk on 4 ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Walk on 4 ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
		endif
	elseif akTarget.IsInFaction(DOMShouldWalkOnFour)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Walk Normal ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Walk Normal ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMAbuseMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMSlaveAbuseMessage.Show()
	endif
	int n_scold = 1
	int n_praise = 1
	bool respectful = true
	bool is_busy = false
	DOM_Actor sl_alias = None
	DOM_Mind sl_mind = None
	if akTarget != None
		sl_alias = DOMCore.GetActor(akTarget)
		if sl_alias != None
			if sl_alias.interact_is_busy && DOMCore.singleTellToggle
				is_busy = true
			endif
			sl_mind = sl_alias.mind
			if sl_mind != None
				n_scold = sl_mind.GetNumberOfNextPunishmentReasons()
				if DOMCore.cryingPunishmentToggle && sl_mind.IsCrying()
					n_scold += 1
				endif
				if sl_mind.IsAngry()
					n_scold += 1
				endif
				if (sl_alias.is_behaviour_pose && sl_mind.pose_training < 100.0) || (sl_alias.IsTied() && sl_mind.IsDevoted() && sl_mind.pose_training < 100.0)
					n_scold += 1
				endif
				n_praise = sl_mind.GetNumberOfNextPraiseReasons() ; Can always praise for being a good slave
				if DOMCore.cryingPraiseToggle && sl_mind.IsCrying()
					n_praise += 1
				endif
			endif
		endif
		if akTarget.IsInFaction(DOMShouldBeRespectful) && !akTarget.IsInFaction(DOMIsRespectful)
			respectful = false
		endif
	endif
	if debugKeyMode
		HudNotification("Abuse menu for "+akTarget.getDisplayName())
	endif
			
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	if sl_mind != None && sl_mind.is_slave
		if sl_mind.whipping_active
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Being punished ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
		elseif n_scold > 0
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Punish ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Punish ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Punish ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Punish anyhow ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
			;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "No reason to punish ")
			;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
		endif

		if !is_busy
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Insult ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Insult ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)

			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Threaten ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Threaten ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Insult ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Busy ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Threaten ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Busy ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
		endif
	endif
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Upkeeping ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Upkeeping ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	if !is_busy
		if n_praise > 0
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Praise ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Praise ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Praise ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Praise anyhow ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		endif
		if akTarget.IsInFaction(DOMTobeComfortedFaction)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Comfort ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Comfort ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		else
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
		endif
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Flatter")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Flatter")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Promise ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Promise ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Praise ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Busy ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Comfort ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Busy ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Flatter")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Busy")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Promise ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Busy ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)
	endif
		
	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoStatusMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMAllStatusMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif

	if isADOMActor(aktarget)
		int imenu = ShowDOMStatusMenu(aktarget)
		; Info menu
		if imenu == 0
			DOMCore.DOMWheelTraits(akTarget)
		elseif imenu == 1
			DOMCore.NPCWheelFeelings(akTarget)
		elseif imenu == 2
			DOMDOMood(akTarget)
		elseif imenu == 3
			DOMDoStatus(akTarget)
		elseif imenu == 4
			DOMDoBeRespectful(akTarget)
		elseif imenu == 6
			DOMDoFightForMe(akTarget)
		endif
		if isADOMSlave(akTarget)
			if imenu == 5
				DOMDoBeSilent(akTarget)
			elseif imenu == 7 && !akTarget.IsInFaction(DOMActionOnDuty)
				imenu = ShowDOMTaskMenu(akTarget)
				if imenu == 0
					DOMDoCleanTheMess(akTarget)
				elseif imenu >= 1 && imenu < 7
					DOMDoWork(akTarget,imenu)
				elseif imenu == 7
					DOMDoJail(akTarget)
				endif
			endif
		endif
	elseif DOMPAH.isPAH(akTarget)
		DOMPAH.DoStatusMenu(akTarget)
	else
		DOMDoNPCMenu(akTarget)
	endif
EndFunction

Int Function ShowDOMStatusMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMSlaveStatusMessage.Show()
	endif
	string txt_silent = "Be silent "
	string txt_respectful = "Be respectful "
	string txt_fight_for_me = "Fight for me "
	DOM_Actor  sl_alias = None
	DOM_Mind  sl_mind = None
	if akTarget != None
		sl_alias = DOMCore.GetActor(akTarget)
		if sl_alias != None
			sl_mind = sl_alias.mind
			if sl_mind != None
				if sl_mind.should_be_silent
					txt_silent = "Don't be silent "
				endif
				if sl_mind.should_be_respectful
					txt_respectful = "No need to be respectful "
				endif
				if sl_mind.should_fight_for_player
					txt_fight_for_me = "Don't fight "
				endif
			endif
		endif
	endif
	if debugKeyMode
		HudNotification("Status menu for "+akTarget.getDisplayName())
	endif
	bool is_on_duty = akTarget.IsInFaction(DOMActionOnDuty)

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	if sl_mind != None && sl_mind.is_slave 
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = txt_silent)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = txt_silent)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		if !is_on_duty
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Task ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Task ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
		else
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)
		endif
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)
	endif
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Personality ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Feelings ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Mood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = txt_respectful)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = txt_fight_for_me)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Personality ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Feelings ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Mood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Status ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = txt_respectful)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = txt_fight_for_me)
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMTaskMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMSlaveTaskMessage.Show()
	endif
	string txt_be_a_maid = "Be my maid "
	DOM_Actor  sl_alias = None
	DOM_Mind  sl_mind = None
	if akTarget != None
		sl_alias = DOMCore.GetActor(akTarget)
		if akTarget.GetLeveledActorBase().GetSex() == 0
			txt_be_a_maid = "Be my servant "
		endif
	endif
	if debugKeyMode
		if akTarget != None
			HudNotification("Task menu for "+akTarget.getDisplayName())
		else
			HudNotification("Task group menu")
		endif
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	if sl_alias != None && sl_alias.behaviour != "clean_house"
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = txt_be_a_maid)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Sweeping ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Sweeping ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Distance ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Be a miner ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Mining ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Cut wood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Cut wood ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cook ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Cook ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Forage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Forage ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Smith ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Smith ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Magic ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Magic ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Jail ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Go to jail ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoTrainingMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMAllTrainingMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif
	if isADOMActor(aktarget)
		int imenu = ShowDOMTrainingMenu(akTarget)
		if imenu == 0
			DOMDoClothesMenu(akTarget)
		elseif imenu == 2
			DOMSexlab.DefaultSexlabExtraTags = ""
			DOMDoSexMenu(akTarget)
		elseif imenu == 5
			DOMDoKissMenu(akTarget)
		elseif imenu == 7 && !akTarget.IsInFaction(DOMActionOnDuty)
			DOMDoMasturbateMenu(akTarget)
		endif
		if isADOMSlave(akTarget)
			if imenu == 1
				DOMSexlab.DefaultSexlabExtraTags = ""
				DOMDoRapeMenu(akTarget)
			elseif imenu == 3
				DOMDoSetOrgasmStatus(akTarget)
			elseif imenu == 4
				DOMDoAttentionMenu(akTarget)
			elseif imenu == 6
				DOMDoInspectMenu(akTarget)
			endif
		endif
	elseif DOMPAH.isPAH(akTarget)
		DOMPAH.DoTrainingMenu(akTarget)
	else
		DOMDoNPCSlaveMenu(akTarget)
	endif
EndFunction

Int Function ShowDOMTrainingMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMSlaveTrainingMessage.Show()
	endif
	string txt_allowed = "Control orgasm "
	string txt_masturbate = "Masturbate "
	DOM_Actor sl_alias = None
	DOM_Mind  sl_mind = None
	if akTarget != None
		if akTarget.IsInFaction(DOMShouldBeNoOrgasm)
			txt_allowed = "Free orgasm "
		endif
		if akTarget.IsInFaction(DOMActionMasturbating)
			txt_masturbate = "Masturbate harder "
		endif
		sl_alias = DOMCore.GetActor(akTarget)
		if sl_alias != None
			sl_mind = sl_alias.mind
		endif
	endif
	if debugKeyMode
		HudNotification("Training menu for "+akTarget.getDisplayName())
	endif
	bool is_on_duty = akTarget.IsInFaction(DOMActionOnDuty)

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	if sl_mind != None && sl_mind.is_slave
		if DOMSexlab.DOM_HasSexlab.GetValue() == 1 || DOMOstim.DOM_HasOstim.GetValue() == 1
			if !sl_alias.canAnimate
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = false)
			else
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Rape ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Rape ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
			endif
		endif
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = txt_allowed)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Attention ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Inspect ")

		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = txt_allowed)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Attention ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Inspect ")

		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	endif
	
	if sl_alias != None && sl_alias.equip_inventory_busy
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Clothes ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Busy ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Clothes ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Clothes ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	endif
	
	if DOMSexlab.DOM_HasSexlab.GetValue() == 1 || DOMOstim.DOM_HasOstim.GetValue() == 1
		if sl_alias == None || !sl_alias.canAnimate
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Sex ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Sex ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
		endif
	endif
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Kiss ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	
	if !is_on_duty
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = txt_masturbate)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = txt_masturbate)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Function DOMAllStatusMenu()
	int imenu = ShowDOMMenuGroupStatus()
	; Group orders menu
	if imenu == 0
		DOMAllOrderSlaves("NoOrgasm")
	elseif imenu == 1
		DOMAllOrderSlaves("FreeOrgasm")
	elseif imenu == 2
		DOMAllOrderSlavesAndSlavers("DontFightForMe")
		if menuPAH
			DOMPAH.AllDontFightForMe()
		endif
	elseif imenu == 3
		int jmenu = ShowJailMenu(None)+1
		if jmenu > 0 && jmenu <= 6
			DOMAllOrderSlaves("GoToJail",jmenu)
		endif
	elseif imenu == 4
		DOMAllOrderSlaves("BeRespectful")
	elseif imenu == 5
		DOMAllOrderSlaves("BeSilent")
	elseif imenu == 6
		DOMAllOrderSlavesAndSlavers("FightForMe")
		if menuPAH
			DOMPAH.AllFightForMe()
		endif
	elseif imenu == 7
		int jmenu = ShowDOMTaskMenu(None)
		DOMAllOrderSlaves("Work",jmenu)
	endif
EndFunction

Int Function ShowDOMMenuGroupStatus()		
	if !wheelIsDefaultMenu
		return DOMGroupStatusMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Group status menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "All no orgasm ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "All free orgasm ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "All don't fight ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "All jail ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "All respectful ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "All be silent ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "All fight for me ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "All task ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "No orgasm ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Free orgasm ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Don't fight ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Jail ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Respectful ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Silent ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Fight for me ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Task ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMAllOrderMenu()
	int imenu = ShowDOMMenuGroupOrder()
	; Group orders menu
	; 0 open inventory
	if imenu == 0
		DOMAllOrderBags("OutBag")
	elseif imenu == 1
		DOMAllOrderSlavesAndSlavers("Follow")
		if menuPAH
			DOMPAH.AllFollow()
		endif
	elseif imenu == 2
		DOMAllOrderSlavesAndSlavers("StandStill")
		if menuPAH
			DOMPAH.AllStandstill()
		endif
	elseif imenu == 3
		DOMAllOrderSlavesAndSlavers("WaitHere") ; sandbox
		if menuPAH
			DOMPAH.AllWaitHere()
		endif
	elseif imenu == 4
		DOMAllOrderBags("GatherBag")
	elseif imenu == 5
		DOMAllOrderSlaves("InBag")
	elseif imenu == 6
		DOMAllTieUpMenu(false,false)
	elseif imenu == 7
		DOMAllPoseMenu()
	endif
EndFunction

Int Function ShowDOMMenuGroupOrder()		
	if !wheelIsDefaultMenu
		return DOMGroupOrderMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Group order menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "All out of bag")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "All follow me ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "All stand still ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "All wait here ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Get all bags ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "All put in bag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "All tie up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "All pose ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Open bags ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Follow me ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Stand still ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Wait here ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Get bags ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "In bags ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Tie up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Pose ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMAllAbuseMenu()
	int imenu = ShowDOMMenuGroupAbuse()
	; Group orders menu
	if imenu == 0
		DOMAllOrderSlaves("Scold")
	elseif imenu == 1
		DOMAllUpkeepingMenu()
	elseif imenu == 2
		DOMAllOrderSlaves("Insult")
	elseif imenu == 3
		DOMAllThreatenMenu()
	elseif imenu == 4
		DOMAllOrderSlavesAndSlavers("Praise")
	; 5 comfort
	elseif imenu == 6
		DOMAllOrderSlaves("Flatter")
	elseif imenu == 7
		DOMAllPromiseMenu()
	endif
EndFunction

Int Function ShowDOMMenuGroupAbuse()		
	if !wheelIsDefaultMenu
		return DOMGroupAbuseMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Group abuse menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "All scold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "All upkeeping ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "All insult ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "All threaten ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "All praise ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "All comfort ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "All flatter ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "All promise ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Scold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Upkeeping ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Insult ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Threaten ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Praise ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Comfort ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Flatter ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Promise ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMAllTrainingMenu()
	int imenu = ShowDOMMenuGroupTraining()
	; Group orders menu
	if imenu == 0
		DOMAllClothesMenu()
	; 1 rape
	; 2 sex
	; 3 orgasm
	elseif imenu == 4
		DOMAllAttentionMenu()
	; 5 kiss
	; 6 inspect
	elseif imenu == 7
		DOMAllOrderSlaves("Masturbate")
	endif
EndFunction

Int Function ShowDOMMenuGroupTraining()		
	if !wheelIsDefaultMenu
		return DOMGroupTrainingMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Group training menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "All clothes ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "All attention ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "All promise ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "All threaten ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "All attention ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "All tie up")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "All gag/blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "All masturbate ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Clothes ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Attention ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Promise ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Threaten ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Attention ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Tie up ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Gag/Blind on/off ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Masturbate ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoAttentionMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	int imenu = ShowDOMDoAttentionMenu()
	if imenu == 4 || imenu == 0
		DOMDoDisplay(akTarget)
	elseif imenu == 5 || imenu == 1
		DOMDoSalute(akTarget)
	elseif imenu == 6 || imenu == 2
		DOMDoKneel(akTarget)
	elseif imenu == 7 || imenu == 3
		DOMDoAttention(akTarget)
	endif
EndFunction

Function DOMAllAttentionMenu()
	int imenu = ShowDOMAllAttentionMenu()
	if imenu == 4 || imenu == 0
		DOMAllOrderSlaves("Display")
	elseif imenu == 5 || imenu == 1
		DOMAllOrderSlaves("Salute")
	elseif imenu == 6 || imenu == 2
		DOMAllOrderSlaves("Kneel")
	elseif imenu == 7 || imenu == 3
		DOMAllOrderSlaves("Attention")
	endif
EndFunction

Function DOMAllUpkeepingMenu()
	int imenu = ShowDOMAllUpkeepingMenu()
	if imenu == 0
		DOMAllOrderSlaves("Shower")
	elseif imenu == 1
		DOMAllOrderSlaves("LookAtMe")
	elseif imenu == 2
		DOMAllOrderSlaves("TurnAround")
	elseif imenu == 3
		DOMAllOrderSlaves("ComeHere")
	elseif imenu == 4
		DOMAllOrderSlaves("DrinkThis","potion")
	elseif imenu == 5
		DOMAllOrderSlaves("DrinkThis","alcohol")
	elseif imenu == 6
		DOMAllOrderSlaves("MarkMe")
	elseif imenu == 7
		DOMAllOrderSlaves("BrandMe")
	endif
EndFunction

Int Function ShowDoDOMMenuGagAndBlindfold()
	if !wheelIsDefaultMenu
		return DOMSlaveGagAndBlindfoldMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Group order menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "All wear gag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "All wear blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "All wear both ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "All remove gag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "All remove blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "All remove both ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "All wear gag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "All wear blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "All wear both ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "All remove gag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "All remove blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "All remove both ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMAllAttentionMenu()		
	if !wheelIsDefaultMenu
		return DOMGroupAttentionMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Group order menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "All scold")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "All praise")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "All insult ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "All Gag&Blind ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "All display ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "All hands behind head")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "All kneel")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "All stand ")

	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Scold ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Praise ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Insult ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Gag&Blind ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Display ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Hands behind head ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Kneel ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Stand ")
	
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMAllUpkeepingMenu()
	if !wheelIsDefaultMenu
		return DOMGroupUpkeepingMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Group upkeeping menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Shower ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Shower ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Look at me ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value =  "Look at me ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Turn around ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value =  "Turn around ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Come here ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value =  "Come here ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Drink potion ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value =  "Potion ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Drink alcohol ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value =  "Drink ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Mark slaves ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value =  "Status ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Brand slaves ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value =  "Brand ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMDoAttentionMenu()		
	if !wheelIsDefaultMenu
		return DOMSlaveAttentionMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Attention menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Pose ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Display ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Kneel ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Stand ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Pose ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Display ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Kneel ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Stand ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMPraiseTypeMenu()
	if !wheelIsDefaultMenu
		return DOMSlavePraiseMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Praise type menu")
	endif

	int n = DOMCore.GetJSONNumberOfPraisingTypes()
	if n <= 1
		return 0
	endif
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i < n && i < 7
		string the_key = DOMCore.GetJSONPraisingTypeNameByIndex(i)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_key)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_key)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Kiss ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMPraiseKissMenu()
	if !wheelIsDefaultMenu
		return DOMSlavePraiseMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Praise kiss menu")
	endif

	int n = DOMCore.GetJSONNumberOfPraisingTypes()
	if n <= 1
		return 0
	endif
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i+7 < n && i < 8
		string the_key = DOMCore.GetJSONPraisingTypeNameByIndex(i+7)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_key)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_key)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMPunishmentTypeMenu()
	if !wheelIsDefaultMenu
		return DOMSlavePunishMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Punishment type menu")
	endif

	int n = DOMCore.GetJSONNumberOfPunishmentTypes()
	if n <= 1
		return 0
	endif
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i < n && i < 8
		string the_key = DOMCore.GetJSONPunishmentTypeNameByIndex(i)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_key)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_key)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile
	
	return wheelMenu.OpenMenu()
EndFunction

string[] _selectPunishmentReason
string[] Property selectPunishmentReason
	string[] Function Get()
		if !_selectPunishmentReason
			_selectPunishmentReason = new string[8] ; 8 choices max per wheel menu
		endif
		return _selectPunishmentReason
	EndFunction
EndProperty

Function ClearPunishmentReasons()
	int i = 0
	while i < 8
		selectPunishmentReason[i] = ""
		i += 1
	endwhile
EndFunction

bool Function AlreadyInPunishmentReasons(string reason)
	int i = 0
	while i < 8
		string in_list = selectPunishmentReason[i]
		if in_list == ""
			return false
		endif
		if in_list == reason
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

int Function ShowDOMPunishmentMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return -1
	endif
	if akTarget == None
		return -1
	endif
	if debugKeyMode
		HudNotification("Punishment reason menu for "+akTarget.getDisplayName())
	endif
	
	int n = 0
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	DOM_Mind  sl_mind = None
	if sl_alias != None
		sl_mind = sl_alias.mind
	endif
	if sl_mind != None
		n =  sl_mind.GetNumberOfNextPunishmentReasons()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	if n > 8
		n = 8
	endif
	ClearPunishmentReasons()
	string psh_reason = ""
	while i < n
		psh_reason = sl_mind.GetNextPunishmentReason(i)
		Logtrace("Punish "+sl_alias.GetName()+" reason "+i+" = "+psh_reason)
		selectPunishmentReason[i] = psh_reason
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = psh_reason+" ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = psh_reason+" ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile
	; Find any reason in current behaviour
	if i < 8 && sl_mind != None
		if DOMCore.cryingPunishmentToggle && sl_mind.IsCrying()
			psh_reason = "crying"
			if !AlreadyInPunishmentReasons(psh_reason)
				;Logtrace("Punish "+sl_alias.GetName()+" reason "+i+" = "+psh_reason)
				selectPunishmentReason[i] = psh_reason
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = psh_reason+" ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = psh_reason+" ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
				i += 1
			endif
		endif	
	endif
	if i < 8 && sl_mind != None
		if sl_mind.IsAngry()
			psh_reason = "being angry"
			if !AlreadyInPunishmentReasons(psh_reason)
				;Logtrace("Punish "+sl_alias.GetName()+" reason "+i+" = "+psh_reason)
				selectPunishmentReason[i] = psh_reason
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = psh_reason+" ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = psh_reason+" ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
				i += 1
			endif
		endif	
	endif
	if i < 8 && sl_mind != None
		if (sl_alias.is_behaviour_pose && sl_mind.pose_training < 100.0) || (sl_alias.IsTied() && sl_mind.IsDevoted() && sl_mind.pose_training < 100.0)
			psh_reason = "posture correction"
			; if !AlreadyInPunishmentReasons(psh_reason) ; Should not happen
				;Logtrace("Punish "+sl_alias.GetName()+" reason "+i+" = "+psh_reason)
				selectPunishmentReason[i] = psh_reason
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = psh_reason+" ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = psh_reason+" ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
				i += 1
			; endif
		endif	
	endif
	if i <= 0 ; no reason to punish, find one anyhow
		psh_reason = "being a bad slave"
		;Logtrace("Punish "+sl_alias.GetName()+" reason "+i+" = "+psh_reason)
		selectPunishmentReason[i] = psh_reason
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = psh_reason+" ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = psh_reason+" ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
		;return -1
	endif
	while i < 8
		selectPunishmentReason[i] = ""
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = false)
		i += 1
	endwhile

	return wheelMenu.OpenMenu()
EndFunction

string[] _selectPraiseReason
string[] Property selectPraiseReason
	string[] Function Get()
		if !_selectPraiseReason
			_selectPraiseReason = new string[8] ; 8 choices max per wheel menu
		endif
		return _selectPraiseReason
	EndFunction
EndProperty

Function ClearPraiseReasons()
	int i = 0
	while i < 8
		selectPraiseReason[i] = ""
		i += 1
	endwhile
EndFunction

bool Function AlreadyInPraiseReasons(string reason)
	int i = 0
	;LogTrace("AlreadyInPraiseReasons ? reason="+reason)
	while i < 8
		string in_list = selectPraiseReason[i]
		;LogTrace("AlreadyInPraiseReasons list["+i+"]="+in_list)
		if in_list == ""
			return false
		endif
		if in_list == reason
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

Int Function ShowDOMPraiseMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return -1
	endif
	if akTarget == None
		return -1
	endif
	if debugKeyMode
		HudNotification("Praise reason menu for "+akTarget.getDisplayName())
	endif
	;Logtrace("ShowDOMPraiseMenu "+akTarget.GetDisplayName())
	
	int n = 0
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	DOM_Mind  sl_mind = None
	if sl_alias != None
		sl_mind = sl_alias.mind
	endif
	if sl_mind != None
		n = sl_mind.GetNumberOfNextPraiseReasons()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	if n > 8
		n = 8
	endif
	ClearPraiseReasons()
	string pra_reason = ""
	while i < n
		pra_reason = sl_mind.GetNextPraiseReason(i)
		Logtrace("Praise "+sl_alias.GetName()+" reason "+i+" = "+pra_reason)
		selectPraiseReason[i] = pra_reason
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = pra_reason+" ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = pra_reason+" ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile
	;Logtrace("ShowDOMPraiseMenu "+akTarget.GetDisplayName()+" 1 i="+i)
	; Find any reason in current behaviour
	if i < 8
		if DOMCore.cryingPraiseToggle && sl_mind.IsCrying()
			pra_reason = "crying"
			if !AlreadyInPraiseReasons(pra_reason)
				Logtrace("Praise "+sl_alias.GetName()+" reason "+i+" = "+pra_reason)
				selectPraiseReason[i] = pra_reason
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = pra_reason+" ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = pra_reason+" ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
				i += 1
			endif
		endif	
	endif
	;Logtrace("ShowDOMPraiseMenu "+akTarget.GetDisplayName()+" 2 i="+i)
	if sl_mind != None && sl_mind.is_slave
		if i < 8
			pra_reason = "being a good slave"
			if !AlreadyInPraiseReasons(pra_reason)
				Logtrace("Praise "+sl_alias.GetName()+" reason "+i+" = "+pra_reason)
				selectPraiseReason[i] = pra_reason
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = pra_reason+" ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = pra_reason+" ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
				i += 1
			endif
		endif
	else
		if i < 8
			pra_reason = "being a good slaver" ; 45
			if !AlreadyInPraiseReasons(pra_reason)
				Logtrace("Praise "+sl_alias.GetName()+" reason "+i+" = "+pra_reason)
				selectPraiseReason[i] = pra_reason
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = pra_reason+" ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = pra_reason+" ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
				i += 1
			endif
		endif	
	endif
	;Logtrace("ShowDOMPraiseMenu "+akTarget.GetDisplayName()+" 3 i="+i)
	if i <= 0 ; no reason to praise, find one anyhow
		pra_reason = "being a good slave"
		;Logtrace("Praise "+sl_alias.GetName()+" reason "+i+" = "+pra_reason)
		selectPraiseReason[i] = pra_reason
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = pra_reason+" ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = pra_reason+" ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
		;return -1
	endif
	while i < 8
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = false)
		i += 1
	endwhile

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMDoThreatenMenu()
	if !wheelIsDefaultMenu
		return DOMSlaveThreatMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Threaten against menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Running away ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Being angry ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Not respectful ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Crying ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Not fighting ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Not posing ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Not masturbating ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Covering ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Running away ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Being angry ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Not respectful ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Crying ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Not fighting ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Not posing")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Not masturbating ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Covering self ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoPoseMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMPoseMenu()
	if imenu == 0
		sl_alias.DoChair(PlayerRef)
	elseif imenu == 1
		sl_alias.DoLight(PlayerRef)
	elseif imenu == 2
		sl_alias.DoFlowers(PlayerRef)
	elseif imenu == 3
		sl_alias.DoDrinks(PlayerRef)
	elseif imenu == 4
		sl_alias.DoCute(PlayerRef)
	elseif imenu == 5
		sl_alias.DoDance(PlayerRef)
	elseif imenu == 6
		sl_alias.DoMusic(PlayerRef)
	elseif imenu == 7
		DOMSexyPoseMenu(akTarget)
	endif
EndFunction

Int Function ShowDOMPoseMenu()
	if !wheelIsDefaultMenu
		return DOMSlavePoseMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Pose menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Chair ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Light ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Flowers ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Drinks ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Cute ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Dance ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Music ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Others ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Chair ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Light ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Flowers ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Drinks ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Cute ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Dance ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Music ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Others ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMSexyPoseMenu()
	if !wheelIsDefaultMenu
		return DOMSlaveSexyPoseMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Pose menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Submissive ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Ass ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Breasts ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Pussy ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Cute ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Dance ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Music ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Others ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Submissive ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Ass ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Breasts ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Pussy ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Cute ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Dance ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Music ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Others ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMInspectMenu()
	if !wheelIsDefaultMenu
		return DOMSlaveInspectMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Inspect menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Front ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Back ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Floor ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Display ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Front ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Back ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Floor ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Display ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)


	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMMasturbateMenu()
	if !wheelIsDefaultMenu
		return DOMSlaveMasturbateMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Masturbate menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Standing ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Kneeling ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Laying ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Standing ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Kneeling ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Laying ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)


	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMClothesMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMSlaveClothesMessage.Show()
	endif
	string txt_naked = "Be naked "
	string txt_weapons = "No weapons "
	string txt_armor = "No armor "
	bool is_naked = false
	DOM_Mind  sl_mind = None
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if sl_alias != None
			sl_mind = sl_alias.mind
			if sl_mind != None
				if sl_mind.should_be_naked ; && sl_alias.is_naked
					txt_naked = "Wear clothes "
				endif
				if !akTarget.IsInFaction(DOMCore.DOMShouldHoldWeapons) ; !sl_mind.should_hold_weapons
					txt_weapons = "Hold weapons "
				endif
				if !sl_mind.should_wear_armor
					txt_armor = "Wear armor "
				endif
			endif
			if sl_alias.is_naked
				is_naked = true
			endif
		endif
	endif
	if debugKeyMode
		HudNotification("Clothes menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	if !is_naked
		if sl_mind != None && sl_mind.is_slave
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Rip-off ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Rip-off everything ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Rip-off ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Rip-off everything ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
		endif
		if akTarget.IsInFaction(DOMActionTied)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Restrained... ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Restrained... ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Restrained... ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Restrained... ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Order to strip ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Strip entirely ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Order to strip ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Strip entirely ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		endif
	endif
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = txt_naked)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Re-equip inventory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = txt_weapons)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = txt_armor)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = txt_naked)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Equip inventory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = txt_weapons)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = txt_armor)
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMAllClothesMenu()
	if !wheelIsDefaultMenu
		return DOMGroupClothesMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Clothes menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Always be naked")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Wear clothes")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Order to strip ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Strip entirely ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Re-equip inventory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "No weapons")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "No armor")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Be naked ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Wear clothes ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Order to strip ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Strip entirely ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Equip inventory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "No weapons")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "No armor")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)


	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMSexMenu(Actor akTarget, bool aggro)
	if !wheelIsDefaultMenu
		return DOMSlaveSexMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Sex menu for "+akTarget.getDisplayName())
	endif
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Vaginal ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Vaginal ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Oral ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Oral ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Anal ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Anal ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Kinky ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Kinky ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	
	if akTarget.IsInFaction(DOMActorFaction)
		if aggro 
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Rape slave ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Rape slave ")	
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Sex with ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Sex with ")	
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		endif
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Player 3some ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Player 3some ")	
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Threesome ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Threesome ")	
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Player 4some ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Player 4some ")	
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMNPCMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		if akTarget.IsInFaction(DOMPlayerSlaverFaction)
			return DOMSlaverStatusMessage.Show()
		else
			return DOMNPCStatusMessage.Show()
		endif
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if debugKeyMode
		HudNotification("NPC menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Personality ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Feelings ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Mood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Status ")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Personality ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Feelings ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Mood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Status ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)

	If sl_alias != None
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Open Inventory ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Open Inventory ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		int n_praise = sl_alias.mind.GetNumberOfNextPraiseReasons()
		if n_praise > 0
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Praise ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Praise ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		else
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
		endif
		if akTarget.IsInFaction(DOMTobeComfortedFaction)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Comfort ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Comfort ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Flatter")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Flatter")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		endif
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Dismiss slaver ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Dismiss slaver ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		if akTarget.GetRelationshipRank(PlayerRef) >= 4 || akTarget.IsInFaction(PlayerFollowerFaction) || DOMCore.isAPlayerSlave(akTarget)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Open Inventory ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Open Inventory ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		else
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
		endif
		if DOM02.family_tmp.GetRef() == akTarget
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Ransom slave ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Ransom slave ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		else
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
		endif
		if !akTarget.IsChild()
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Abduction ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Abduction ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
			if akTarget.IsInFaction(DOMPotentialSlaverFaction)
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Recruit slaver ")
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Recruit slaver ")
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
			else
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
			endif
		endif
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMNPCSlaveMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMNPCSexMessage.Show()
	endif
	ReferenceAlias slaver_alias = DOMCore.GetActor(akTarget)

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	if DOMSexlab.DOM_HasSexlab.GetValue() == 1 || DOMOstim.DOM_HasOstim.GetValue() == 1
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Rape slave ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Rape slave ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Sex with ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Sex with ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Player 3some")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Player 3some ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Threesome ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Threesome ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Player 4some")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Player 4some ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Foursome ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Foursome ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	endif
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Re-equip inventory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Equip inventory ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Equip no clothes ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Equip no clothes ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMSackMenu()
	if !wheelIsDefaultMenu
		return DOMBurlapSackMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Sack menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Open sack ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Open and tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Take sack ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Open sack ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Open and tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Take sack ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)


	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMKissMenu(bool do_vampire_kiss)
	if !wheelIsDefaultMenu
		return DOMSlaveKissMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Kiss menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Short Kiss")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Loving kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Long kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Forced kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Dominant kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Side kiss ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Short kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Loving kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Long kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Forced kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Dominant kiss ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Side kiss ")

	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	
	if do_vampire_kiss && DOMCore.IsVampire(PlayerRef)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Vampire ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Feed ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMTieUpMenu()
	if !wheelIsDefaultMenu
		return DOMSlaveTieupMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Tie-up menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Chains ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Post ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Cage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Restrain ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Gag/Plug ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Cuffs ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Chains ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Post ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Restrain ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Gag/Plug ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Cuffs ")

	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMRestrainMenu()
	if !wheelIsDefaultMenu
		return DOMSlaveRestrainMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Tie-up menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Chains ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Post ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Cage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Cross ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Pillory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Wheel ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Go back ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Chains ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Post ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Cross ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Pillory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Wheel ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Go back ")

	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMCuffsMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlaveCuffsMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Cuffs menu for "+akTarget.getDisplayName())
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	if sl_alias != None
		if sl_alias.has_cuffs_back
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "UnCuff ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "UnCuff back ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
		elseif sl_alias.canMove
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Cuffs back ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Cuffs back ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
		endif
		if sl_alias.has_cuffs_front
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "UnCuff ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "UnCuff front ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
		elseif sl_alias.canMove
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Cuffs front ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Cuffs front ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
		endif
		if sl_alias.has_cuffs_crossed
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "UnCuff ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "UnCuff crossed ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
		elseif sl_alias.canMove
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Cuffs crossed ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Cuffs crossed ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
		endif
		if sl_alias.has_cuffs_boxtied
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "UnCuff ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "UnCuff boxtied ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		elseif sl_alias.canMove
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Cuffs boxtied ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cuffs boxtied ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		endif
		if sl_alias.has_yoke
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Remove yoke ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Remove yoke ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		elseif sl_alias.canMove
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Yoke ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Yoke")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		endif
		if sl_alias.has_armbinder
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Remove binder ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Remove binder ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		elseif sl_alias.canMove
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Armbinder ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Armbinder ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		endif
		if sl_alias.IsCuffed()
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Uncuff ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Uncuff ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		endif
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMBlindfoldMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlaveBlindfoldMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Blindfold menu for "+akTarget.getDisplayName())
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Leather ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Blindfold ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "DD")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Blindfold ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Black")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Blindfold ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cloth ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Hood ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Hood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Hood ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "DB ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Hood ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	if sl_alias == None || sl_alias.has_blindfold
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Remove ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Remove ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	endif
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Random ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMPlugsMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlavePlugsMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Cuffs menu for "+akTarget.getDisplayName())
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	if sl_alias != None && sl_alias.has_mouth_gag
		Form the_gag = DOMZaz.GetEquippedGag(akTarget)
		if the_gag == DOMZaz.GetGagCloth()
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Remove gag ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Remove gag ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Gag ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Gag ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
		endif
		if the_gag == DOMZaz.zbfGagBall
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Remove gag ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Remove gag ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Ball gag ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Ball gag")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
		endif
		if the_gag == DOMZaz.zbfGagRing
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Remove gag ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Remove gag ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Ring gag ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Ring gag")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
		endif
		if the_gag == DOMZaz.zbfGagLog
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Remove gag ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Remove gag ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Log bit ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Log bit")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		endif
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Gag ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Gag ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Ball gag ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Ball gag")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Ring gag ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Ring gag")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Log bit ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Log bit")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	endif
	if sl_alias != None && sl_alias.has_plug_vaginal
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Remove plug")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Remove plug")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Vaginal plug")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Vaginal plug")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	endif
	if sl_alias != None && sl_alias.has_plug_anal
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Remove anal")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Remove anal")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Anal plug")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Anal plug")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	endif
	
	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoTieUpMenu(Actor akTarget)	
	int itype = ShowDOMTieUpMenu()
	if itype < 0
		return
	endif
	if itype == 0
		DOMTieUp(akTarget,false,false) ; No gag, no blindfold
	elseif itype == 1
		DOMChains(akTarget,false,false)
	elseif itype == 2
		DOMPost(akTarget,false,false)
	elseif itype == 3
		DOMCage(akTarget,false,false)
	elseif itype == 4
		DOMDoRestrainMenu(akTarget)
	elseif itype == 5
		DOMDoPlugsMenu(akTarget)
	elseif itype == 6
		DOMDoBlindfoldMenu(akTarget)
	elseif itype == 7
		DOMDoCuffsMenu(akTarget)
	endif
EndFunction

Function DOMDoRestrainMenu(Actor akTarget)
	int itype = ShowDOMRestrainMenu()
	if itype < 0
		return
	endif
	if itype == 0
		DOMTieUp(akTarget,false,false)
	elseif itype == 1
		DOMChains(akTarget,false,false)
	elseif itype == 2
		DOMPost(akTarget,false,false)
	elseif itype == 3
		DOMCage(akTarget,false,false)
	elseif itype == 4
		DOMCross(akTarget,false,false)
	elseif itype == 5
		DOMPillory(akTarget,false,false)
	elseif itype == 6
		DOMWheel(akTarget,false,false)
	else ; if itype == 7
		DOMDoTieUpMenu(akTarget)
	endif
EndFunction

Function DOMCrossByIndex(Actor akTarget, int itype, bool do_gag, bool do_blindfold)
	if akTarget == None
		return
	endif
	string the_pose = DOM_Anim.GetCrossAnimationByIndex(itype)
	
	if debugKeyMode
		HudNotification("Binding to cross "+akTarget.getDisplayName()+" "+the_pose)
	endif
	LogTrace("DOMCrossByIndex "+akTarget.GetDisplayName()+" pose="+the_pose)
	
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.EnterRestrained(PlayerRef, None, the_pose)
	else
		DOMTieupActor(akTarget, PlayerRef, the_pose, false, false)
	endif
	if do_gag
		DOMDoEquipGag(akTarget)
	endif
	if do_blindfold
		DOMDoEquipBlindfold(akTarget)
	endif
EndFunction

Function DOMCross(Actor akTarget, bool do_gag, bool do_blindfold)
	int itype = ShowDOMCrossChoiceMenu()
	if itype < 0
		return
	endif
	DOMCrossByIndex(akTarget, itype, do_gag, do_blindfold)
EndFunction

Function DOMPilloryByIndex(Actor akTarget, int itype, bool do_gag, bool do_blindfold)
	if akTarget == None
		return
	endif
	string the_pose = DOM_Anim.GetPilloryAnimationByIndex(itype)
	
	if debugKeyMode
		HudNotification("Displaying in pillory "+akTarget.getDisplayName()+" "+the_pose)
	endif
	LogTrace("DOMPilloryByIndex "+akTarget.GetDisplayName()+" pose="+the_pose)
	
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.EnterRestrained(PlayerRef, None, the_pose)
	else
		DOMTieupActor(akTarget, PlayerRef, the_pose, false, false)
	endif
	if do_gag
		DOMDoEquipGag(akTarget)
	endif
	if do_blindfold
		DOMDoEquipBlindfold(akTarget)
	endif
EndFunction

Function DOMPillory(Actor akTarget, bool do_gag, bool do_blindfold)
	int itype = ShowDOMPilloryChoiceMenu()
	if itype < 0
		return
	endif
	DOMPilloryByIndex(akTarget, itype, do_gag, do_blindfold)
EndFunction

Function DOMWheelByIndex(Actor akTarget, int itype, bool do_gag, bool do_blindfold)
	if akTarget == None
		return
	endif
	string the_pose = DOM_Anim.GetWheelAnimationByIndex(itype)
	
	if debugKeyMode
		HudNotification("Tying to the wheel "+akTarget.getDisplayName()+" "+the_pose)
	endif
	LogTrace("DOMWheelByIndex "+akTarget.GetDisplayName()+" pose="+the_pose)
	
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.EnterRestrained(PlayerRef, None, the_pose)
	else
		DOMTieupActor(akTarget, PlayerRef, the_pose, false, false)
	endif
	if do_gag
		DOMDoEquipGag(akTarget)
	endif
	if do_blindfold
		DOMDoEquipBlindfold(akTarget)
	endif
EndFunction

Function DOMWheel(Actor akTarget, bool do_gag, bool do_blindfold)
	int itype = ShowDOMWheelChoiceMenu()
	if itype < 0
		return
	endif
	DOMWheelByIndex(akTarget, itype, do_gag, do_blindfold)
EndFunction

Function DOMDoPlugsMenu(Actor akTarget)
	int itype = ShowDOMPlugsMenu(akTarget)
	if itype == 0
		DOMDoGag(akTarget,DOMZaz.GetGagCloth())
	elseif itype == 1
		DOMDoGag(akTarget,DOMZaz.GetGagBall())
	elseif itype == 2
		DOMDoGag(akTarget,DOMZaz.GetGagRing())
	elseif itype == 3
		DOMDoGag(akTarget,DOMZaz.GetGagLog())
	elseif itype == 4
		DOMDoPlug(akTarget,true)
	elseif itype == 5
		DOMDoPlug(akTarget,false)
	endif
EndFunction

Function DOMDoBlindfoldMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif

	int itype = ShowDOMBlindfoldMenu(akTarget)
	if itype < 6
		Form the_blindfold = DOMZaz.GetBlindfold(itype+1)
		DOMDoEquipBlindfold(akTarget,the_blindfold)
	elseif itype == 6
		DOMDoRemoveBlindfold(akTarget)
	elseif itype == 7 ; random
		Form the_blindfold = DOMZaz.GetBlindfold(RandomInt(1,6))
		DOMDoEquipBlindfold(akTarget,the_blindfold)
	endif
EndFunction

Function DOMDoCuffsMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int itype = ShowDOMCuffsMenu(akTarget)
	if itype >= 0 && itype <= 5 
		DOMDoWearCuffs(akTarget,itype)
	elseif itype == 6
		DOMDoUncuff(akTarget)
	endif
EndFunction

Function DOMDoPlug(Actor akTarget, bool is_vaginal)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if is_vaginal
		if akTarget.IsInFaction(DOMZaz.DOMHasPlugVaginal)
			DOMDoRemovePlug(akTarget,is_vaginal)
		else
			DOMDoEquipPlug(akTarget,is_vaginal)
		endif
	else
		if akTarget.IsInFaction(DOMZaz.DOMHasPlugAnal)
			DOMDoRemovePlug(akTarget,is_vaginal)
		else
			DOMDoEquipPlug(akTarget,is_vaginal)
		endif
	endif
EndFunction

Function DOMDoGag(Actor akTarget, Form the_gag)
	if DOMCore.IsFleeing(akTarget)
		return
	endif

	LogTrace("DOMDoGag "+akTarget.GetDisplayName()+" hasGag="+akTarget.IsInFaction(DOMZaz.DOMHasMouthGag)+" wornGag="+DOMZaz.wornGag(akTarget))
	if akTarget.IsInFaction(DOMZaz.DOMHasMouthGag) || DOMZaz.wornGag(akTarget)
		DOMDoRemoveGag(akTarget)
		return
	endif
	DOMDoEquipGag(akTarget,the_gag)
EndFunction

Function DOMDoPunishingMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	
	string reason
	int imenu = ShowDOMPunishmentMenu(akTarget)
	if imenu < 0
		reason = ""
	else
		reason = selectPunishmentReason[imenu]
		if reason == ""
			LogInfo("WARNING: Wheel menu returned invalid punishment reason")
		endif
	endif
	
	int itype
	string type
	if !wheelUsesDefaultPunishmentType
		itype = ShowDOMPunishmentTypeMenu()
		if itype < 0
			return
		endif
		type = DOMCore.GetJSONPunishmentTypeNameByIndex(itype)
	else
		type = DOMCore.DefaultWheelPunishmentType
	endif
		
	LogTrace("INFO: Wheel menu returned punishment type="+itype+" reason "+imenu+" "+reason)
	sl_alias.StartPunishing(PlayerRef,reason,type)
EndFunction

Function DOMDoPraisingMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	string reason
	int imenu = ShowDOMPraiseMenu(akTarget)
	Logtrace("DOMDoPraisingMenu "+sl_alias.GetName()+" imenu="+imenu)
	if imenu < 0
		reason = ""
	else
		reason = selectPraiseReason[imenu]
		if reason == ""
			LogInfo("WARNING: Wheel menu returned invalid praise reason")
		endif
	endif
	
	int itype
	string type
	if akTarget.IsInFaction(DOMCore.DOMAnimatingFaction) || DOMSexlab.IsAnimating(akTarget)
		type = "tell"
	elseif !wheelUsesDefaultPraiseType
		itype   = ShowDOMPraiseTypeMenu()
		if itype < 0
			return
		endif
		if itype == 7
			imenu = ShowDOMPraiseKissMenu()
			type = DOMCore.GetJSONPraisingTypeNameByIndex(itype+imenu)
		else
			type = DOMCore.GetJSONPraisingTypeNameByIndex(itype)
		endif
	else
		type = DOMCore.DefaultWheelPraiseType
	endif
	LogTrace("INFO: Wheel menu returned praise reason="+imenu+" "+reason+" type="+itype+" "+type)
	sl_alias.StartPraising(PlayerRef,reason,type)
EndFunction

Function DOMDoPraisingTell(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	string reason
	int imenu = ShowDOMPraiseMenu(akTarget)
	Logtrace("DOMDoPraisingMenu "+sl_alias.GetName()+" imenu="+imenu)
	if imenu < 0
		reason = ""
	else
		reason = selectPraiseReason[imenu]
		if reason == ""
			LogInfo("WARNING: Wheel menu returned invalid praise reason")
		endif
	endif
	
	LogTrace("INFO: Wheel menu returned praise reason="+imenu+" "+reason)
	sl_alias.StartPraising(PlayerRef,reason,"tell")
EndFunction

Function DOMDoNPCMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		return
	elseif !akTarget.GetLeveledActorBase().IsUnique() && !akTarget.IsInFaction(DOMTrainSubmission) && !akTarget.IsInFaction(DOMPlayerSlaveFaction) ; && !akTarget.IsInFaction(DOMTraitHonest) 
		return
	endif

	int imenu = ShowDOMNPCMenu(akTarget)
	if imenu == 0
		DOMCore.NPCWheelTraits(akTarget)
	elseif imenu == 1
		DOMCore.NPCWheelFeelings(akTarget)
	elseif imenu == 2
		DOMDOMood(akTarget)
	elseif imenu == 3
		DOMDoStatus(akTarget)
	elseif imenu == 4
		DOMDoOpenInventory(akTarget)
	endif
	if akTarget.IsChild()
		return
	endif
	if akTarget.IsInFaction(DOMPlayerSlaverFaction)
		if imenu == 5
			DOMDoPraisingTell(akTarget)
		elseif imenu == 6
			if akTarget.IsInFaction(DOMTobeComfortedFaction)
				DOMDoComfortMenu(akTarget)
			else
				DOMDoFlatterMenu(akTarget)
			endif
		elseif imenu == 7
			DOMDoDismiss(akTarget)
		endif
	else
		if imenu == 5
			DOMRansomManage(akTarget)
		elseif imenu == 6
			DOMActorAbduction(akTarget)
		elseif imenu == 7
			DOMDoRecruit(akTarget)
		endif
	endif
EndFunction

Function DOMDoSackMenu(DOM_BurlapSack objSack)
	if objSack==None
		return
	endif
	int imenu = ShowDOMSackMenu()
	if imenu == 0
		DOMDoTakeOutOfBag(PlayerRef,objSack,false)
	elseif imenu == 1
		DOMDoTakeOutOfBag(PlayerRef,objSack,true)
	elseif imenu == 2
		DOMPickUpBag(PlayerRef,objSack)
	endif
EndFunction

Function DOMDoNPCSlaveMenu(Actor akTarget)
	if akTarget == None || akTarget.IsChild()
		return
	endif
	int imenu = ShowDOMNPCSlaveMenu(akTarget)
	if imenu == 0
		imenu = ShowDOMNPCSlaveSelectMenu1(akTarget)
		if imenu >= 0 && selectArray[imenu] != None
			DOM_actor sl_alias = selectArray[imenu]
			int iaccept = DOMGenerator.IsWillingToHaveSexWith(akTarget,sl_alias)
			if iaccept >= 1
				if iaccept >= 2
					DOMDoSexWith(sl_alias,akTarget, "", true)
				else
					DOMDoSexWith(sl_alias,akTarget, "Missionary", true)
				endif
			endif
		endif
	elseif imenu == 1
		imenu = ShowDOMNPCSlaveSelectMenu1(akTarget)
		if imenu >= 0 && selectArray[imenu] != None
			DOM_actor sl_alias = selectArray[imenu]
			int iaccept = DOMGenerator.IsWillingToHaveSexWith(akTarget,sl_alias)
			if iaccept >= 1
				if iaccept >= 2
					DOMDoSexWith(sl_alias,akTarget, "", true)
				else
					DOMDoSexWith(sl_alias,akTarget, "", false)
				endif
			endif
		endif
	elseif imenu == 2
		imenu = ShowDOMNPCSlaveSelectMenu1(akTarget)
		if imenu >= 0 && selectArray[imenu] != None
			DOM_actor sl_alias = selectArray[imenu]
			int iaccept = DOMGenerator.IsWillingToHaveSexWith(akTarget,sl_alias)
			if iaccept >= 1
				if iaccept >= 2
					sl_alias.StartSexWith3ANP(akTarget, "", true)
				else
					sl_alias.StartSexWith3ANP(akTarget, "", false)
				endif
			endif
		endif
	elseif imenu == 3
		int imenu1 = ShowDOMNPCSlaveSelectMenu1(akTarget)
		if imenu1 >= 0 && selectArray[imenu1] != None
			DOM_actor sl_alias1 = selectArray[imenu1]
			int imenu2 = ShowDOMNPCSlaveSelectMenu2(akTarget,sl_alias1)
			if imenu2 >= 0 && selectArray[imenu2] != None
				int iaccept = DOMGenerator.IsWillingToHaveSexWith(akTarget,sl_alias1)
				if iaccept >= 1
					DOM_actor sl_alias2 = selectArray[imenu2]
					if iaccept >= 2
						sl_alias1.StartSexWith3AAN(sl_alias2, akTarget, "", true)
					else
						sl_alias1.StartSexWith3AAN(sl_alias2, akTarget, "", false)
					endif
				endif
			endif
		endif
	elseif imenu == 4
		imenu = ShowDOMNPCSlaveSelectMenu1(akTarget)
		if imenu >= 0 && selectArray[imenu] != None
			DOM_actor sl_alias1 = selectArray[imenu]
			int imenu2 = ShowDOMNPCSlaveSelectMenu2(akTarget,sl_alias1)
			if imenu2 >= 0 && selectArray[imenu2] != None
				DOM_actor sl_alias2 = selectArray[imenu2]
				int iaccept = DOMGenerator.IsWillingToHaveSexWith(akTarget,sl_alias1)
				if iaccept >= 1
					if iaccept >= 2
						sl_alias1.StartSexWith4AANP(sl_alias2,akTarget, "", true)
					else
						sl_alias1.StartSexWith4AANP(sl_alias2,akTarget, "", false)
					endif
				endif
			endif
		endif
	elseif imenu == 5
		int imenu1 = ShowDOMNPCSlaveSelectMenu1(akTarget)
		if imenu1 >= 0 && selectArray[imenu1] != None
			DOM_actor sl_alias1 = selectArray[imenu1]
			int imenu2 = ShowDOMNPCSlaveSelectMenu2(akTarget,sl_alias1)
			if imenu2 >= 0 && selectArray[imenu2] != None
				DOM_actor sl_alias2 = selectArray[imenu2]
				int imenu3 = ShowDOMNPCSlaveSelectMenu3(akTarget,sl_alias1,sl_alias2)
				if imenu3 >= 0 && selectArray[imenu3] != None
					int iaccept = DOMGenerator.IsWillingToHaveSexWith(akTarget,sl_alias1)
					if iaccept >= 1
						DOM_actor sl_alias3 = selectArray[imenu3]
						if iaccept >= 2
							sl_alias1.StartSexWith4AAAN(sl_alias2, sl_alias3, akTarget, "", true)
						else
							sl_alias1.StartSexWith4AAAN(sl_alias2, sl_alias3, akTarget, "", false)
						endif
					endif
				endif
			endif
		endif
	elseif imenu == 6 ; equip all
		DOMDoNPCDressUp(akTarget)
	elseif imenu == 7 ; naked
		DOMDoNPCUnDress(akTarget)
	endif
EndFunction

float Function GetTrainingValue(Actor akTarget, Faction the_faction, Faction the_mod, float base_amount)
	if !akTarget.IsInFaction(the_mod)
		return base_amount
	endif
	float mod = GetModifierFromFaction(akTarget,the_mod)/100.0
	;LogTrace("GetTrainingValue "+akTarget.GetDisplayName()+" mod="+mod)
	float the_training = akTarget.GetFactionRank(the_faction)
	if the_training < 0.0
		the_training = 0.0
	endif
	if the_training >= 100.0
		if base_amount > 0.0
			return 0.0
		endif
		return base_amount
	endif
	;LogTrace("GetTrainingValue "+akTarget.GetDisplayName()+" train="+the_training)
	float multiplier = 0.1 + (0.9*(1.0-(the_training/100.0)))
	;LogTrace("GetTrainingValue "+akTarget.GetDisplayName()+" mult="+multiplier)
	float x = (multiplier*mod*base_amount)
	;LogTrace("GetTrainingValue "+akTarget.GetDisplayName()+" x="+x)
	return x
EndFunction

Function TrainNb(Actor akTarget, Faction the_faction)
	int rank = akTarget.GetFactionRank(the_faction)
	if rank >= 127
		return
	endif
	if rank < 127
		if rank < 0
			rank = 0
		endif
		akTarget.SetFactionRank(the_faction,rank+1)
	endif
EndFunction

Function TrainFactionWithMod(Actor akTarget, Faction the_faction, Faction the_mod, float base_amount)
	;LogTrace("TrainFactionWithMod "+akTarget.GetDisplayName()+" faction="+the_faction)
	;LogTrace("TrainFactionWithMod "+akTarget.GetDisplayName()+" mod="+the_mod)
	;LogTrace("TrainFactionWithMod "+akTarget.GetDisplayName()+" amount="+base_amount)
	int value = (GetTrainingValue(akTarget,the_faction,the_mod,base_amount) as int)
	;LogTrace("TrainFactionWithMod "+akTarget.GetDisplayName()+" value="+value)
	int rank = akTarget.GetFactionRank(the_faction)
	;LogTrace("TrainFactionWithMod "+akTarget.GetDisplayName()+" rank1"+rank)
	if rank >= 100
		return
	endif
	if rank < 0
		rank = 0
	endif
	rank += value
	if rank > 100
		rank = 100
	endif
	;LogTrace("TrainFactionWithMod "+akTarget.GetDisplayName()+" rank2"+rank)
	akTarget.SetFactionRank(the_faction,rank)
EndFunction

Function AnswerThanksToFlatter(Actor akTarget, Faction the_faction, Faction the_mod)
	TrainNb(akTarget,DOMCore.DOMNbFlatter)
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if rel < 4 && RandomFloat()*100.0 < GetModifierFromFaction(akTarget,the_mod) && RandomFloat()*100.0 > akTarget.GetFactionRank(the_faction)
		rel += 1
		akTarget.SetRelationshipRank(PlayerRef,rel)
		if rel >= 4
			HudNotification(akTarget.GetDisplayName()+" has fallen under your charm")
		else
			HudNotification(akTarget.GetDisplayName()+" seems flattered")
		endif
	else
		HudNotification(akTarget.GetDisplayName()+" seems flattered")
	endif
	if rel < 4
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerThanks,PlayerRef)
	else
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerThanksRespectful,PlayerRef)
	endif
EndFunction

Function AnswerBadToFlatter(Actor akTarget, Faction the_faction, Faction the_mod)
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if rel < 4 && rel > 0 && RandomFloat()*100.0 < GetModifierFromFaction(akTarget,the_mod) && RandomFloat()*100.0 < akTarget.GetFactionRank(the_faction)
		akTarget.SetRelationshipRank(PlayerRef,rel - (1))
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerBad,PlayerRef)
		HudNotification(akTarget.GetDisplayName()+" seems offended")
	else
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerWhat,PlayerRef)
		HudNotification(akTarget.GetDisplayName()+" seems uninterested")
	endif
EndFunction

Function AnswerSorryToInsult(Actor akTarget, Faction the_faction, Faction the_mod)
	TrainNb(akTarget,DOMCore.DOMNbInsult)
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if rel < 4
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerSorry,PlayerRef)
	else
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerSorryRespectful,PlayerRef)
	endif
	HudNotification(akTarget.GetDisplayName()+" seems humbled")
EndFunction

Function AnswerBadToInsult(Actor akTarget, Faction the_faction, Faction the_mod)
	TrainNb(akTarget,DOMCore.DOMNbInsult)
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if rel < 4 && rel > 0 && RandomFloat()*100.0 < GetModifierFromFaction(akTarget,the_mod) && RandomFloat()*100.0 < akTarget.GetFactionRank(the_faction)
		akTarget.SetRelationshipRank(PlayerRef,rel - (1))
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerBad,PlayerRef)
		HudNotification(akTarget.GetDisplayName()+" seems infuriated")
	else
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerWhat,PlayerRef)
		HudNotification(akTarget.GetDisplayName()+" seems upset")
	endif
EndFunction

Function DOMDoFlatter(Actor akTarget,string type)
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		sl_alias.StartFlatteringWith(PlayerRef,type)
		return
	endif
	LogTrace("DOMDoFlatter target="+akTarget.GetDisplayName()+" type="+type)
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if type == "sexy" ; submission
		LogTrace("DOMDoFlatter "+akTarget.GetDisplayName()+" "+akTarget.GetFactionRank(DOMTrainSubmission)+" "+GetModifierFromFaction(akTarget,DOMModHumility)+" "+GetModifierFromFaction(akTarget,DOMModSentimentality))
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainSubmission) || (RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModHumility) && RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModSentimentality))
			TrainFactionWithMod(akTarget,DOMTrainSubmission,DOMModHumility,5.0)
			TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModSentimentality,5.0)
			AnswerThanksToFlatter(akTarget,DOMTrainSubmission,DOMModSentimentality)
		else
			TrainFactionWithMod(akTarget,DOMTrainSubmission,DOMModInsensitivity,-5.0)
			TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModInsensitivity,-5.0)
			AnswerBadToFlatter(akTarget,DOMTrainSubmission,DOMModInsensitivity)
		endif
	elseif type == "dirty" ; humiliation
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainHumiliation) || (RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModNaivety) && RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModDaring))
			TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModNaivety,5.0)
			TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModDaring,5.0)
			AnswerThanksToFlatter(akTarget,DOMTrainHumiliation,DOMModDaring)
		else
			TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModSelfEsteem,-5.0)
			TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModSelfEsteem,-5.0)
			AnswerBadToFlatter(akTarget,DOMTrainHumiliation,DOMModSelfEsteem)
		endif
	elseif type == "romance" ; respect
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainRespect) || (RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModDiscipline) && RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModManipulation))
			TrainFactionWithMod(akTarget,DOMTrainRespect,DOMModDiscipline,5.0)
			TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModManipulation,5.0)
			AnswerThanksToFlatter(akTarget,DOMTrainRespect,DOMModManipulation)
		else
			TrainFactionWithMod(akTarget,DOMTrainRespect,DOMModPretender,-5.0)
			TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModPretender,-5.0)
			AnswerBadToFlatter(akTarget,DOMTrainRespect,DOMModPretender)
		endif
	else  ; if type == "praise" ; resignation
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainResignation) || RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModDiligent)
			TrainFactionWithMod(akTarget,DOMTrainResignation,DOMModDiligent,5.0)
			AnswerThanksToFlatter(akTarget,DOMTrainSubmission,DOMModSentimentality)
		else
			TrainFactionWithMod(akTarget,DOMTrainResignation,DOMModController,-5.0)
			AnswerBadToFlatter(akTarget,DOMTrainResignation,DOMModController)
		endif
	endif
EndFunction

Function DOMDoInsult(Actor akTarget,string type)
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		sl_alias.StartInsultingWith(PlayerRef,type)
		return
	endif
	LogTrace("DOMDoInsult target="+akTarget.GetDisplayName())
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if type == "dominating" ; submission
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainSubmission) || RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModHumility)
			TrainFactionWithMod(akTarget,DOMTrainSubmission,DOMModHumility,5.0)
			AnswerSorryToInsult(akTarget,DOMTrainSubmission,DOMModHumility)
		else
			TrainFactionWithMod(akTarget,DOMTrainSubmission,DOMModInsensitivity,-5.0)
			AnswerBadToInsult(akTarget,DOMTrainSubmission,DOMModInsensitivity)
		endif
	elseif type == "useless" ; fear
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainFear) || RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModFearfulness)
			TrainFactionWithMod(akTarget,DOMTrainFear,DOMModFearfulness,5.0)
			AnswerSorryToInsult(akTarget,DOMTrainFear,DOMModFearfulness)
		else
			TrainFactionWithMod(akTarget,DOMTrainFear,DOMModIntimidate,-5.0)
			AnswerBadToInsult(akTarget,DOMTrainFear,DOMModIntimidate)
		endif
	elseif type == "degrading" ; shame
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainHumiliation) || RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModNaivety)
			TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModNaivety,5.0)
			AnswerSorryToInsult(akTarget,DOMTrainHumiliation,DOMModNaivety)
		else
			TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModSelfEsteem,-5.0)
			AnswerBadToInsult(akTarget,DOMTrainHumiliation,DOMModSelfEsteem)
		endif
	elseif type == "demeaning" ; anger
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainAnger) || RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModForgiveness)
			TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModForgiveness,5.0)
			AnswerSorryToInsult(akTarget,DOMTrainAnger,DOMModForgiveness)
		else
			TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModResentment,-5.0)
			AnswerBadToInsult(akTarget,DOMTrainAnger,DOMModResentment)
		endif
	elseif type == "disgrace" ; resignation
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainResignation) || RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModPrudent)
			TrainFactionWithMod(akTarget,DOMTrainResignation,DOMModPrudent,5.0)
			AnswerSorryToInsult(akTarget,DOMTrainResignation,DOMModPrudent)
		else
			TrainFactionWithMod(akTarget,DOMTrainResignation,DOMModController,-5.0)
			AnswerBadToInsult(akTarget,DOMTrainResignation,DOMModController)
		endif
	elseif type == "worthless" ; respect
		if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainRespect) || RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModDiscipline)
			TrainFactionWithMod(akTarget,DOMTrainRespect,DOMModDiscipline,5.0)
			AnswerSorryToInsult(akTarget,DOMTrainRespect,DOMModDiscipline)
		else
			TrainFactionWithMod(akTarget,DOMTrainRespect,DOMModPretender,-5.0)
			AnswerBadToInsult(akTarget,DOMTrainRespect,DOMModPretender)
		endif
	endif 
EndFunction

Function DOMDoNPCShower(Actor akTarget)
	if akTarget == None
		return
	endif
	LogTrace("DOMDoNPCShower target="+akTarget.GetDisplayName())
	bool should_wait = DOMSetFollowerPose(akTarget)
	DOMBath.DoNPCShower(akTarget)
	DOMUnsetFollowerPose(akTarget,should_wait)
EndFunction

Function DOMDoNPCBathMe(Actor akTarget)
	if akTarget == None
		return
	endif
	LogTrace("DOMDoNPCBathMe target="+akTarget.GetDisplayName())
	bool should_wait = DOMSetFollowerPose(akTarget)
	DOMBath.DoNPCBathMe(akTarget)
	DOMUnsetFollowerPose(akTarget,should_wait)
EndFunction

Function DOMDoNPCDressUp(Actor akTarget)
	if akTarget == None
		return
	endif
	LogTrace("DOMDoNPCDressUp EquipOutfit dress up on NPC "+akTarget.GetDisplayName())
	bool was_naked = !(DOMEquip.HasEquippedClothes(akTarget))
	DOMEquip.TransferOutfitIfUnique(akTarget,true) ; equip outfit for uniques
	DOMEquip.EquipOutfit(akTarget,false,false,true,false)  ; do not use light, not naked, allow armor, no weapons
	DOMEquip.EquipInventory(akTarget,false,false,true,false)  ; do not use light,not naked, allow armor, no weapons
	bool is_naked = !(DOMEquip.HasEquippedClothes(akTarget))
	if !is_naked
		if was_naked
			CalmActorFast(akTarget)
			SendAnimation(akTarget, DOM_Anim.GetDressBottomPoseNPC(akTarget)) ; dress bottom
			Wait(2.0*DOMCore.anim_speed_sec)
			Debug.SendAnimationEvent(akTarget, DOM_Anim.GetDressTopPoseNPC(akTarget)) ; dress top
		endif
		akTarget.RemoveFromFaction(DOMIsNaked)
	else
		if !was_naked
			CalmActorFast(akTarget)
			Debug.SendAnimationEvent(akTarget, DOM_Anim.GetStripPoseNPC(akTarget))
		endif
		akTarget.SetFactionRank(DOMIsNaked,1)
	endif
EndFunction

Function DOMDoNPCUnDress(Actor akTarget)
	if akTarget == None
		return
	endif
	LogTrace("DOMDoNPCUnDress EquipOutfit naked on NPC "+akTarget.GetDisplayName())
	bool was_naked = !(DOMEquip.HasEquippedClothes(akTarget))
	DOMEquip.TransferOutfitIfUnique(akTarget,true) ; equip outfit for uniques
	DOMEquip.EquipOutfit(akTarget,false,true,false,false)    ; do not use light, naked, no armor (no shields), no weapons
	DOMEquip.EquipInventory(akTarget,false,true,false,false) ; do not use light, naked, no armor (no shields), no weapons
	bool is_naked = !(DOMEquip.HasEquippedClothes(akTarget))
	if !is_naked
		if was_naked
			CalmActorFast(akTarget)
			SendAnimation(akTarget, DOM_Anim.GetDressBottomPoseNPC(akTarget)) ; dress bottom
			Wait(2.0*DOMCore.anim_speed_sec)
			Debug.SendAnimationEvent(akTarget, DOM_Anim.GetDressTopPoseNPC(akTarget)) ; dress top
		endif
		akTarget.RemoveFromFaction(DOMIsNaked)
	else
		if !was_naked
			CalmActorFast(akTarget)
			Debug.SendAnimationEvent(akTarget, DOM_Anim.GetStripPoseNPC(akTarget))
		endif
		akTarget.SetFactionRank(DOMIsNaked,1)
	endif
EndFunction

Function DOMDoNPCPlayerHug(Actor akTarget)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoNPCPlayerHug "+name)
	HudNotification(name+" gives a hug to player")
	CalmActorFast(akTarget)
	CalmActorFast(PlayerRef)
	akTarget.playIdleWithTarget(DOMCore.pa_HugA,PlayerRef)
	TrainNb(akTarget,DOMCore.DOMNbComfort)
EndFunction

bool Function WillObeyForSex(Actor akTarget)
	string name = akTarget.GetDisplayName()
	LogTrace("WillObeyForSex "+name)
	if akTarget.IsInFaction(DOMMoodInLove) || akTarget.GetRelationshipRank(PlayerRef) > 3
		HudNotification(name+" worshipfully obeys")
		return True
	endif
	if akTarget.IsInFaction(DOMMoodBroken)
		HudNotification(name+" obeys like a good pet")
		return True
	endif
	
	float x = akTarget.GetFactionRank(DOMTrainSubmission)+akTarget.GetFactionRank(DOMTrainHumiliation)
	LogTrace("WillObeyForSex "+name+" sub+hum="+x)
	if RandomFloat()*200.0 < x
		HudNotification(name+" obeys like a good fuck toy")
		return true
	endif
	
	x = (GetModifierFromFaction(akTarget,DOMModAuthority) + GetModifierFromFaction(akTarget,DOMModIngenuity))/100.0
	LogTrace("WillObeyForSex "+name+" authority+ingenuity="+x)
	if RandomFloat()*10.0 < x
		int actorSex = akTarget.GetLeveledActorBase().GetSex()
		if ((actorSex%2) == 1)
			HudNotification(name+" obeys like a good girl")
		else
			HudNotification(name+" obeys like a good boy")
		endif
		return true
	endif

	HudNotification(name+" won't have sex with you")
	return false
EndFunction

bool Function WillObeyForKiss(Actor akTarget)
	string name = akTarget.GetDisplayName()
	LogTrace("WillObeyForKiss "+name)
	if akTarget.IsInFaction(DOMMoodInLove) || akTarget.GetRelationshipRank(PlayerRef) > 3
		HudNotification(name+" worshipfully agrees")
		return True
	endif
	if akTarget.IsInFaction(DOMMoodBroken)
		HudNotification(name+" agrees like a good pet")
		return True
	endif
	
	int actorSex = akTarget.GetLeveledActorBase().GetSex()
	float x = akTarget.GetFactionRank(DOMTrainSubmission)+akTarget.GetFactionRank(DOMTrainRespect)
	LogTrace("WillObeyForKiss "+name+" sub+resp="+x)
	if RandomFloat()*200.0 < x
		if ((actorSex%2) == 1)
			HudNotification(name+" agrees like a well trained girl")
		else
			HudNotification(name+" agrees like a well trained boy")
		endif
		return true
	endif
	
	x = (GetModifierFromFaction(akTarget,DOMModSentimentality) + GetModifierFromFaction(akTarget,DOMModIngenuity))/100.0
	LogTrace("WillObeyForKiss "+name+" sentimentality+ingenuity="+x)
	if RandomFloat()*10.0 < x
		if ((actorSex%2) == 1)
			HudNotification(name+" agrees like a good girl")
		else
			HudNotification(name+" agrees like a good boy")
		endif
		return true
	endif

	if ((actorSex%2) == 1)
		HudNotification(name+" won't let you kiss her")
	else
		HudNotification(name+" won't let you kiss him")
	endif
	return false
EndFunction

bool Function WillObeyForGrab(Actor akTarget)
	string name = akTarget.GetDisplayName()
	LogTrace("WillObeyForGrab "+name)
	if akTarget.IsInFaction(DOMMoodInLove) || akTarget.GetRelationshipRank(PlayerRef) > 3
		HudNotification(name+" worshipfully agrees")
		return True
	endif
	if akTarget.IsInFaction(DOMMoodBroken)
		HudNotification(name+" agrees like a good pet")
		return True
	endif
	
	int actorSex = akTarget.GetLeveledActorBase().GetSex()
	float x = akTarget.GetFactionRank(DOMTrainSubmission)+akTarget.GetFactionRank(DOMTrainRespect)
	LogTrace("WillObeyForGrab "+name+" sub+resp="+x)
	if RandomFloat()*200.0 < x
		if ((actorSex%2) == 1)
			HudNotification(name+" agrees like a well trained girl")
		else
			HudNotification(name+" agrees like a well trained boy")
		endif
		return true
	endif
	
	x = (GetModifierFromFaction(akTarget,DOMModSentimentality) + GetModifierFromFaction(akTarget,DOMModIngenuity))/100.0
	LogTrace("WillObeyForGrab "+name+" sentimentality+ingenuity="+x)
	if RandomFloat()*10.0 < x
		if ((actorSex%2) == 1)
			HudNotification(name+" agrees like a good girl")
		else
			HudNotification(name+" agrees like a good boy")
		endif
		return true
	endif

	if ((actorSex%2) == 1)
		HudNotification(name+" won't let you touch her")
	else
		HudNotification(name+" won't let you touch him")
	endif
	return false
EndFunction

Function AnswerYesToSex(Actor akTarget, Faction the_faction, Faction the_mod)
	LogTrace("AnswerYesToSex "+akTarget.GetDisplayName())
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if rel < 4 && RandomFloat()*100.0 < GetModifierFromFaction(akTarget,the_mod) && RandomFloat()*100.0 > akTarget.GetFactionRank(the_faction)
		rel += 1
		akTarget.SetRelationshipRank(PlayerRef,rel)
		if rel >= 4
			HudNotification(akTarget.GetDisplayName()+" has fallen under your charm")
		else
			HudNotification(akTarget.GetDisplayName()+" seems abashed")
		endif
	else
		HudNotification(akTarget.GetDisplayName()+" seems abashed")
	endif
	if rel < 4
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerThanks,PlayerRef)
	else
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerThanksRespectful,PlayerRef)
	endif
EndFunction

Function AnswerNoToSex(Actor akTarget, Faction the_faction, Faction the_mod)
	LogTrace("AnswerNoToSex "+akTarget.GetDisplayName())
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if rel < 4 && rel > 0 && RandomFloat()*100.0 < GetModifierFromFaction(akTarget,the_mod) && RandomFloat()*100.0 < akTarget.GetFactionRank(the_faction)
		akTarget.SetRelationshipRank(PlayerRef,rel - (1))
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerBad,PlayerRef)
		HudNotification(akTarget.GetDisplayName()+" seems disgusted")
	else
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerWhat,PlayerRef)
		HudNotification(akTarget.GetDisplayName()+" seems apprehensive")
	endif
EndFunction

Function AnswerWhatToSex(Actor akTarget, Faction the_faction, Faction the_mod1, Faction the_mod2)
	LogTrace("AnswerWhatToSex "+akTarget.GetDisplayName())
	int rel = akTarget.GetRelationshipRank(PlayerRef)
	if rel > 4 || (RandomFloat()*100.0 < GetModifierFromFaction(akTarget,the_mod1) && RandomFloat()*100.0 > GetModifierFromFaction(akTarget,the_mod2) && RandomFloat()*100.0 > akTarget.GetFactionRank(the_faction))
		AnswerYesToSex(akTarget,the_faction,the_mod1)
	else
		AnswerNoToSex(akTarget,the_faction,the_mod2)
	endif
EndFunction

Function DOMDoSex(Actor akTarget, string type, bool is_aggressive)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	Actor akAnotherActor = PlayerRef
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	LogTrace("DOMDoSex "+name+" alias="+sl_alias)
	if sl_alias != None
		sl_alias.StartSexWith(akAnotherActor, type, is_aggressive)
		return
	endif
	if is_aggressive
		AnswerWhatToSex(akTarget,DOMTrainSubmission,DOMModSentimentality,DOMModInsensitivity)
		Actor[] akActors        = new Actor[2]
		DOM_Actor[] akDOMActors = new DOM_Actor[2]
		akActors[0]    = akTarget
		akDOMActors[0] = None
		akActors[1]    = akAnotherActor
		akDOMActors[1] = None
		DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, "", type, is_aggressive, "")
		return
	endif
	
	if !WillObeyForSex(akTarget)
		AnswerNoToSex(akTarget,DOMTrainSubmission,DOMModInsensitivity)
		return
	endif
	
	AnswerYesToSex(akTarget,DOMTrainSubmission,DOMModSentimentality)
	if DOMSexlab.undressBeforeSex
		DOMDoNPCUnDress(akTarget)
	endif
	Actor[] akActors        = new Actor[2]
	DOM_Actor[] akDOMActors = new DOM_Actor[2]
	akActors[0]    = akTarget
	akDOMActors[0] = None
	akActors[1]    = akAnotherActor
	akDOMActors[1] = None
	DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, "", type, is_aggressive, "")
EndFunction

Function DOMDoSexOstim(Actor akTarget, string type, bool is_aggressive)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	Actor akAnotherActor = PlayerRef
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	LogTrace("DOMDoSexOstim "+name+" alias="+sl_alias)
	if sl_alias != None
		sl_alias.StartSexWithOstim(akAnotherActor, type, is_aggressive)
		return
	endif
	if is_aggressive
		AnswerWhatToSex(akTarget,DOMTrainSubmission,DOMModSentimentality,DOMModInsensitivity)
		Actor[] akActors        = new Actor[2]
		DOM_Actor[] akDOMActors = new DOM_Actor[2]
		akActors[0]    = akTarget
		akDOMActors[0] = None
		akActors[1]    = akAnotherActor
		akDOMActors[1] = None
		if DOMOSTIM == None
			DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, "", type, is_aggressive, "")
		else
			DOMOSTIM.StartOStimWithArrays(akActors, akDOMActors, type, is_aggressive)
		endif
		return
	endif
	
	if !WillObeyForSex(akTarget)
		AnswerNoToSex(akTarget,DOMTrainSubmission,DOMModInsensitivity)
		return
	endif
	
	AnswerYesToSex(akTarget,DOMTrainSubmission,DOMModSentimentality)
	if DOMSexlab.undressBeforeSex
		DOMDoNPCUnDress(akTarget)
	endif
	Actor[] akActors        = new Actor[2]
	DOM_Actor[] akDOMActors = new DOM_Actor[2]
	akActors[0]    = akTarget
	akDOMActors[0] = None
	akActors[1]    = akAnotherActor
	akDOMActors[1] = None
	if DOMOSTIM == None
		DOMSexlab.StartSexlabWithArrays(akActors, akDOMActors, "", type, is_aggressive, "")
	else
		DOMOSTIM.StartOStimWithArrays(akActors, akDOMActors, type, is_aggressive)
	endif
EndFunction

; Dual animations

ObjectReference Property DualAnimationMarker Auto Hidden

; Save positions of actors before animation
float[] __anim_pos_ref
float[] Property anim_pos_ref
	float[] Function Get()
		if !__anim_pos_ref
			__anim_pos_ref = new float[6]
		endif
		return __anim_pos_ref
	EndFunction
EndProperty

float[] __anim_pos_other
float[] Property anim_pos_other
	float[] Function Get()
		if !__anim_pos_other
			__anim_pos_other = new float[6]
		endif
		return __anim_pos_other
	EndFunction
EndProperty

Function SavePositions(Actor akRef, Actor akTarget)
	anim_pos_ref[0] = akRef.GetPositionX()
	anim_pos_ref[1] = akRef.GetPositionY()
	anim_pos_ref[2] = akRef.GetPositionZ()
	anim_pos_ref[3] = akRef.GetAngleX()
	anim_pos_ref[4] = akRef.GetAngleY()
	anim_pos_ref[5] = akRef.GetAngleZ()

	if akTarget != None
		anim_pos_other[0] = akTarget.GetPositionX()
		anim_pos_other[1] = akTarget.GetPositionY()
		anim_pos_other[2] = akTarget.GetPositionZ()
		anim_pos_other[3] = akTarget.GetAngleX()
		anim_pos_other[4] = akTarget.GetAngleY()
		anim_pos_other[5] = akTarget.GetAngleZ()
	else
		anim_pos_other[0] = 0.0
		anim_pos_other[1] = 0.0
		anim_pos_other[2] = 0.0
		anim_pos_other[3] = 0.0
		anim_pos_other[4] = 0.0
		anim_pos_other[5] = 0.0
	endif
EndFunction

Function RestorePositions(Actor akRef, Actor akTarget)
	akRef.SetPosition(anim_pos_ref[0], anim_pos_ref[1], anim_pos_ref[2])
	akRef.SetAngle(anim_pos_ref[3], anim_pos_ref[4], anim_pos_ref[5])
	if akTarget != None
		if akTarget != PlayerRef || DOM_Anim.doPlayerAnim
			akTarget.SetPosition(anim_pos_other[0], anim_pos_other[1], anim_pos_other[2])
			akTarget.SetAngle(anim_pos_other[3], anim_pos_other[4], anim_pos_other[5])
		endif
	endif
EndFunction


float JSONanim_angle1 = 0.0
float JSONanim_angle2 = 0.0
string JSONanim_idle1 = ""
string JSONanim_idle2 = ""
int JSONanim_nactors = 0
int JSONanim_nscenes = 0
bool JSONanim_is_bounded = false
bool JSONanim_do_actor1 = true
bool JSONanim_do_actor2 = true
bool JSONanim_do_bounded = false
bool JSONanim_do_start = true
String[] JSONanim_idles1
String[] JSONanim_idles2
Float[] JSONanim_angles1
Float[] JSONanim_angles2
Float[] JSONanim_timers
Actor JSONanim_actor1
Actor JSONanim_actor2

Function CheckJSONActors()
	; Check if actors can be animated
	if JSONanim_actor1.IsInFaction(DOMActionTied)
		JSONanim_is_bounded = true
	endif
	if JSONanim_is_bounded && !JSONanim_do_bounded
		LogAnim("CheckJSONActors Actor1 is restrained")
		JSONanim_do_actor1 = false
	elseif DOMSexlab.IsAnimating(JSONanim_actor1)
		LogAnim("CheckJSONActors Actor1 is SxL animating")
		JSONanim_do_actor1 = false
	else
		JSONanim_do_actor1 = true
	endif
	if JSONanim_actor2 != None
		if JSONanim_actor2.IsInFaction(DOMActionTied)
			LogAnim("CheckJSONActors Actor2 is restrained")
			JSONanim_do_actor2 = false
		elseif DOMSexlab.IsAnimating(JSONanim_actor2)
			LogAnim("CheckJSONActors Actor2 is SxL animating")
			JSONanim_do_actor2 = false
		else
			JSONanim_do_actor2 = true
		endif
	else
		JSONanim_do_actor2 = false
	endif
EndFunction

Function StartJSONAnimation(Actor akTarget, Actor akAnotherActor, string the_key, bool do_bounded=false)
	LogAnim("StartJSONAnimation "+the_key+" of "+akTarget+" with "+akAnotherActor)
	; Set variables
	JSONanim_angle1     = 0.0
	JSONanim_angle2     = 0.0
	JSONanim_idle1      = ""
	JSONanim_idle2      = ""
	JSONanim_actor1     = akTarget
	JSONanim_actor2     = akAnotherActor
	JSONanim_nscenes    = 0
	JSONanim_is_bounded = false
	JSONanim_do_bounded = do_bounded
	JSONanim_do_start   = true
	; Check if actors are already busy with DOM animations
	if DOM_Anim.IsAnimating(JSONanim_actor1)
		LogAnim("StartJSONAnimation Actor1 is alread in DoM animation")
		JSONanim_do_actor1 = false
	else
		JSONanim_do_actor1  = true
	endif
	if JSONanim_actor2 != None
		if DOM_Anim.IsAnimating(JSONanim_actor2)
			LogAnim("StartJSONAnimation Actor2 is already in DoM animation")
			JSONanim_do_actor2 = false
		else
			JSONanim_do_actor2  = true
		endif
	else
		LogAnim("StartJSONAnimation Actor2 is not defined")
		JSONanim_do_actor2  = false
	endif
	; If no actors available, abort
	if !JSONanim_do_actor1 && !JSONanim_do_actor2
		JSONanim_nactors = 0
		return
	endif
	JSONanim_nactors    = DOM_Anim.GetNumberOfActors(the_key)
	; If no actors or no animations, abort
	if JSONanim_nactors < 1
		LogAnim("StartJSONAnimation animation "+the_key+" is not defined")
		return
	endif
	; Retrieve animations and parameters
	JSONanim_nscenes = 0
	if JSONanim_do_actor1
		JSONanim_idles1 = DOM_Anim.GetAnimations(the_key,1) ; first actor
		if !JSONanim_idles1
			JSONanim_do_actor1 = false
		elseif JSONanim_idles1.length < 1
			JSONanim_do_actor1 = false
		else
			JSONanim_nscenes = JSONanim_idles1.length
		endif
		; Get parameters if animations are present
		if JSONanim_do_actor1
			CalmActorFast(JSONanim_actor1)
			JSONanim_angles1 = DOM_Anim.GetAngles(the_key,1) ; first actor
		endif
	endif
	if JSONanim_do_actor2
		JSONanim_idles2 = DOM_Anim.GetAnimations(the_key,2) ; second actor
		if !JSONanim_idles2
			JSONanim_do_actor2 = false
		elseif JSONanim_idles2.length < 1
			JSONanim_do_actor2 = false
		elseif JSONanim_idles2.length > JSONanim_nscenes
			JSONanim_nscenes = JSONanim_idles2.length
		endif
		; Get parameters if animations are present
		if JSONanim_do_actor2
			CalmActorFast(JSONanim_actor2)
			JSONanim_angles2 = DOM_Anim.GetAngles(the_key,2) ; second actor
		endif
	endif
	if JSONanim_do_actor1 || JSONanim_do_actor2
		JSONanim_timers  = DOM_Anim.GetTimers(the_key)
	endif
	; Play animation
	LogAnim("StartJSONAnimation found animation "+the_key+" with "+JSONanim_nscenes+" scenes and "+JSONanim_nactors+" actors")
	PlayJSONAnimation(0) ; play first animation
EndFunction

Function PlayJSONAnimation(int index)
	; Check if any animation should be played
	LogAnim("PlayJSONAnimation idx="+index+" start="+JSONanim_do_start+" actor1="+JSONanim_do_actor1+" actor2="+JSONanim_do_actor2)
	if JSONanim_nactors < 1
		return
	endif
	if JSONanim_nscenes <= index
		return
	endif
	; Check actors current animation status
	CheckJSONActors()
	if !JSONanim_do_actor1 && !JSONanim_do_actor2
		return
	endif
	; Fill in animation parameters
	if JSONanim_do_actor1
		if index < JSONanim_idles1.length
			JSONanim_idle1 = JSONanim_idles1[index]
		endif
	else
		JSONanim_idle1 = ""
	endif
	if JSONanim_angles1 && JSONanim_angles1.length > index
		JSONanim_angle1 = JSONanim_angles1[index]
		DOM_Anim.SetAngleActor1(JSONanim_angle1)
	endif
	if JSONanim_do_actor2
		if index < JSONanim_idles2.length
			JSONanim_idle2 = JSONanim_idles2[index]
		endif
	else
		JSONanim_idle2 = ""
	endif
	if JSONanim_angles2 && JSONanim_angles2.length > index
		JSONanim_angle2 = JSONanim_angles2[index]
		DOM_Anim.SetAngleActor2(JSONanim_angle2)
	endif
	
	if JSONanim_do_actor1 && JSONanim_do_actor2
		if JSONanim_do_start
			JSONanim_do_start = false
			PlayDualAnimation(JSONanim_actor1, JSONanim_actor2,JSONanim_idle1,JSONanim_idle2,JSONanim_angle1,JSONanim_angle2)
		else
			PlayAnotherDualAnim(JSONanim_actor1, JSONanim_actor2,JSONanim_idle1,JSONanim_idle2) 
		endif
	elseif JSONanim_do_actor1
		if JSONanim_do_start
			PlayDualAnimationAlone(JSONanim_actor1,JSONanim_actor2,JSONanim_idle1,JSONanim_angle1)
		else
			PlayAnotherDualAnimAlone(JSONanim_actor1,JSONanim_actor2,JSONanim_idle1)
		endif
	else ; if JSONanim_do_actor2
		if JSONanim_do_start
			PlayDualAnimationOnlyAbuser(JSONanim_actor1,JSONanim_actor2,JSONanim_idle2,JSONanim_angle2)
		else
			PlayAnotherDualAnimOnlyAbuser(JSONanim_actor1,JSONanim_actor2,JSONanim_idle2)
		endif
	endif
	if JSONanim_timers && JSONanim_timers.length > index
		Wait(DOMCore.anim_speed_sec*JSONanim_timers[index])
	endif		
EndFunction

Function PlayJSONAnimations(int istart, int iend)
	if iend >= JSONanim_nscenes
		iend = JSONanim_nscenes - (1)
	endif
	LogAnim("PlayJSONAnimations istart="+istart+" iend="+iend)
	if istart > iend 
		return
	endif
	int iscene = istart
	while iscene <= iend
		PlayJSONAnimation(iscene)
		iscene += 1
	EndWhile
EndFunction

Function EndJSONAnimation(string end_anim="")
	LogAnim("EndJSONAnimation actor1="+JSONanim_do_actor1+" actor2="+JSONanim_do_actor2)
	if JSONanim_do_actor1 && JSONanim_do_actor2
		EndDualAnim(JSONanim_actor1,JSONanim_actor2)
	elseif JSONanim_do_actor1
		EndDualAnimAlone(JSONanim_actor1,JSONanim_actor2)
		if end_anim != ""
			LogTrace("EndJSONAnimation Anim_IdleReset")
			Debug.SendAnimationEvent(JSONanim_actor1,end_anim)
		endif
	else ; if JSONanim_do_actor2
		EndDualAnimOnlyAbuser(JSONanim_actor1,JSONanim_actor2)
	endif
	JSONanim_angle1 = 0.0
	JSONanim_angle2 = 0.0
	JSONanim_idle1 = ""
	JSONanim_idle2 = ""
	JSONanim_actor2 = None
	JSONanim_nactors = 0
	JSONanim_nscenes = 0
	JSONanim_is_bounded = false
	JSONanim_do_bounded = false
	JSONanim_do_actor1 = true
	JSONanim_do_actor2 = true
	JSONanim_do_start  = true
EndFunction

Function PlayDualAnimation(Actor akTarget, Actor akAnotherActor, string idle1, string idle2, float angle1=0.0, float angle2=0.0)
	LogAnim("PlayDualAnimation ref="+akTarget+" actor="+akAnotherActor+" "+idle1+" "+idle2+" a1="+angle1+" a2="+angle2)	
	if DualAnimationMarker != NONE
		DualAnimationMarker.Delete()
		DualAnimationMarker = NONE
	endif
	int sitState = akTarget.GetSitState()
	;int sleepState = akTarget.GetSleepState()
	if sitState > 0 ; || sleepState > 0
		if akAnotherActor == PlayerRef && Game.GetCameraState() == 0
			Game.ForceThirdPerson()
		endif
		DualAnimationMarker = akAnotherActor.PlaceAtMe(DOMCore.XMarkerForm)
	else
		DualAnimationMarker = akTarget.PlaceAtMe(DOMCore.XMarkerForm)
	endif
	DualAnimationMarker.Enable()
	SavePositions(akTarget,akAnotherActor)
	DOM_Anim.StartDualAnim(DualAnimationMarker,akTarget,akAnotherActor,angle1,angle2)
	DOM_Anim.PlayDualAnim(DualAnimationMarker,akTarget,akAnotherActor,idle1,idle2)
EndFunction

Function PlayDualAnimationAlone(Actor akTarget, Actor akAnotherActor, string idle1, float angle1=0.0)
	LogAnim("PlayDualAnimationAlone ref="+akTarget+" actor="+akAnotherActor+" "+idle1+" angle1="+angle1)	
	if PoseAnimMarker != NONE
		PoseAnimMarker.Delete()
		PoseAnimMarker = NONE
	endif
	JSONanim_angle1 = angle1
	JSONanim_angle2 = 0.0
	PoseAnimMarker = akTarget.PlaceAtMe(DOMCore.XMarkerForm)
	PoseAnimMarker.Enable()
	;SavePositions(akTarget,akAnotherActor)
	DOM_Anim.StartDualAnimAlone(PoseAnimMarker,akTarget,angle1)
	DOM_Anim.PlayDualAnimAlone(PoseAnimMarker,akTarget,idle1)
EndFunction

Function PlayDualAnimationOnlyAbuser(Actor akTarget, Actor akAnotherActor, string idle2, float angle2=0.0)
	if DualAnimationMarker != NONE
		DualAnimationMarker.Delete()
		DualAnimationMarker = NONE
	endif
	JSONanim_angle1 = 0.0
	JSONanim_angle2 = angle2
	LogAnim("PlayDualAnimationOnlyAbuser ref="+akTarget+" actor="+akAnotherActor+" "+idle2+" a2="+angle2)	
	int sitState = akTarget.GetSitState()
	;int sleepState = akTarget.GetSleepState()
	if sitState > 0 ; || sleepState > 0
		if akAnotherActor == PlayerRef && Game.GetCameraState() == 0
			Game.ForceThirdPerson()
		endif
		DualAnimationMarker = akAnotherActor.PlaceAtMe(DOMCore.XMarkerForm)
	else
		DualAnimationMarker = akTarget.PlaceAtMe(DOMCore.XMarkerForm)
	endif
	DualAnimationMarker.Enable()
	SavePositions(akTarget,akAnotherActor)
	DOM_Anim.StartDualAnimAlone(DualAnimationMarker,akAnotherActor,angle2)
	DOM_Anim.PlayDualAnimAlone(DualAnimationMarker,akAnotherActor,idle2)
EndFunction

Function PlayAnotherDualAnim(Actor akTarget, Actor akAnotherActor, string idle1, string idle2)
	LogAnim("PlayAnotherDualAnim: ref="+akTarget+" actor="+akAnotherActor+" "+idle1+" "+idle2)	
	if DualAnimationMarker == NONE
		if DOM_Anim.doAnimateAtActorLocation
			DualAnimationMarker = akTarget.PlaceAtMe(DOMCore.XMarkerForm)
		else
			DualAnimationMarker = akAnotherActor.PlaceAtMe(DOMCore.XMarkerForm)
		endif
		DualAnimationMarker.Enable()
		SavePositions(akTarget,akAnotherActor)
	endif
	DOM_Anim.PlayDualAnim(DualAnimationMarker,akTarget,akAnotherActor,idle1,idle2)
EndFunction

Function PlayAnotherDualAnimAlone(Actor akTarget, Actor akAnotherActor, string idle1)
	LogAnim("PlayAnotherDualAnimAlone idle1="+idle1)	
	if PoseAnimMarker == NONE
		PoseAnimMarker = akTarget.PlaceAtMe(DOMCore.XMarkerForm)
		PoseAnimMarker.Enable()
		;SavePositions(akTarget,akAnotherActor)
	endif
	DOM_Anim.PlayDualAnimAlone(PoseAnimMarker,akTarget,idle1)
EndFunction

Function PlayAnotherDualAnimOnlyAbuser(Actor akTarget, Actor akAnotherActor, string idle2)
	LogAnim("PlayAnotherDualAnimOnlyAbuser idle2="+idle2)	
	if DualAnimationMarker == NONE
		DualAnimationMarker = akTarget.PlaceAtMe(DOMCore.XMarkerForm)
		DualAnimationMarker.Enable()
		SavePositions(akTarget,akAnotherActor)
	endif
	DOM_Anim.PlayDualAnimAlone(DualAnimationMarker,akAnotherActor,idle2)
EndFunction

Function EndDualAnim(Actor akTarget, Actor akAnotherActor, bool restore_positions=true)
	LogAnim("EndDualAnim ref="+akTarget+" actor="+akAnotherActor)	
	DOM_Anim.EndDualAnim(akTarget,akAnotherActor)
	if restore_positions
		RestorePositions(akTarget,akAnotherActor)
	endif
	if DualAnimationMarker != None
		DualAnimationMarker.Delete()
		DualAnimationMarker = None
	endif
	Debug.SendAnimationEvent(akAnotherActor,"IdleForceDefaultState")
	Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
EndFunction

Function EndDualAnimAlone(Actor akTarget, Actor akAnotherActor, bool restore_positions=true)
	LogAnim("EndDualAnimAlone ref="+akTarget+" actor="+akAnotherActor+" angle2="+JSONanim_angle2)	
	DOM_Anim.EndDualAnimAlone(akTarget)
	if restore_positions
		akTarget.moveTo(PoseAnimMarker)
		;RestorePositions(akTarget,akAnotherActor)
	endif
	if PoseAnimMarker != None
		PoseAnimMarker.Delete()
		PoseAnimMarker = None
	endif
	Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
EndFunction

Function EndDualAnimOnlyAbuser(Actor akTarget, Actor akAnotherActor, bool restore_positions=true)
	LogAnim("EndDualAnimOnlyAbuser ref="+akTarget+" actor="+akAnotherActor+" angle2="+JSONanim_angle2)	
	DOM_Anim.EndDualAnimAlone(akAnotherActor)
	if restore_positions
		RestorePositions(akTarget,akAnotherActor)
	endif
	if DualAnimationMarker != None
		DualAnimationMarker.Delete()
		DualAnimationMarker = None
	endif
	Debug.SendAnimationEvent(akAnotherActor,"IdleForceDefaultState")
EndFunction

Function SendAnimation(Actor akTarget, string the_anim, bool forced=true)
	if !forced 
		int sitState = akTarget.GetSitState()
		if sitState>0
			return
		endif
		int sleepState = akTarget.GetSleepState()
		if sleepState>0
			return
		endif
	endif
	StandUpActor(akTarget)
	CalmActorFast(akTarget)		 
	if the_anim == "IdleHandsBehindBack"
		Debug.SendAnimationEvent(akTarget, "IdleForceDefaultState")
	endif
	Debug.SendAnimationEvent(akTarget,the_anim)
EndFunction

Function IncreaseArousal(Actor akTarget, Actor akAnotherActor, float amount, Faction the_mod)
	float mod  = (akTarget.GetFactionRank(DOMFacetSensuality)/200.0 + 0.5 + GetModifierFromFaction(akTarget,the_mod)/1000.0)
	float trainer_mod
	if akAnotherActor != None
		trainer_mod = DOMCore.GetDepraverModifier(akAnotherActor)
	else
		trainer_mod = 1.0 ; Magic
	endif
	float value = (amount * mod * DOMCore.train_speed_arousal * trainer_mod)/10.0
	float arousal = DOMSexlab.GetArousalValue(akTarget)
	float new_arousal = arousal+value
	LogTrace("IncreaseArousal "+akTarget.GetDisplayName()+" "+arousal+" + "+value+ "= "+new_arousal)
	DOMSexlab.SetArousalValue(akTarget,new_arousal)
EndFunction

bool Function IsAVirgin(Actor akTarget)
	if akTarget.GetLeveledActorBase().GetSex() == ((DOMPlayerAlias.GetPlayerSex())%2)
		if akTarget.GetFactionRank(DOMVirginSame) == 0
			return true
		endif
		return false
	endif

	if akTarget.GetFactionRank(DOMVirginVaginal) == 0
		return true
	endif
	return false
EndFunction

Function DOMDoFollowMe(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoFollowMe "+name)
	if debugKeyMode
		HudNotification("Order "+akTarget.GetDisplayName()+" to follow")
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		if sl_alias.behaviour != "follow_player"
			sl_alias.EnterFollowPlayer()
		else
			DOMDoFollowMenu(akTarget)
		endif
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, PlayerRef, false)
	endif
	if akTarget.IsInFaction(PlayerFollowerFaction) || akTarget.IsInFaction(CurrentFollowerFaction)
		DOMSetFollowerWait(akTarget,false)
	else
		DOMCore.NPCStartFollowMe(akTarget)
	endif
EndFunction

Function DOMDoStandStill(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	string name = akTarget.GetDisplayName()
	Actor akAnotherActor = PlayerRef
	LogTrace("DOMDoStandStill "+name)
	if debugKeyMode
		HudNotification("Order "+akTarget.GetDisplayName()+" to wait here")
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		if sl_alias.behaviour != "wait"
			sl_alias.EnterWait()
		else
			DOMDoStandMenu(akTarget)
		endif
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, PlayerRef, false)
	endif
	if akTarget.IsInFaction(PlayerFollowerFaction) || akTarget.IsInFaction(CurrentFollowerFaction)
		DOMSetFollowerWait(akTarget,true)
	else
		DOMCore.NPCStartWaitHere(akTarget)
	endif
EndFunction

Function DOMDoWaitSandbox(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	string name = akTarget.GetDisplayName()
	Actor akAnotherActor = PlayerRef
	LogTrace("DOMDoWaitSandbox "+name)
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		if sl_alias.behaviour != "wait_sandbox"
			sl_alias.EnterWaitSandbox()
		else
			DOMDoWaitMenu(akTarget)
		endif
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, PlayerRef, false)
	endif
	if akTarget.IsInFaction(PlayerFollowerFaction) || akTarget.IsInFaction(CurrentFollowerFaction)
		DOMSetFollowerSandbox(akTarget,true)
	else
		DOMCore.NPCStartWaitSandbox(akTarget)
	endif
EndFunction

bool Function GetFromOwnerIfNeededAndDrink(Actor akTarget, Actor akAnotherActor, Form the_form)
	int nb = akTarget.getItemCount(the_form)
	if nb <=0 
		if akAnotherActor == None
			return false
		endif
		if akAnotherActor.getItemCount(the_form) <= 0
			return false
		endif
		akAnotherActor.RemoveItem(the_form,1, akOtherContainer = akTarget)
		nb = akTarget.getItemCount(the_form)
		if nb <= 0
			return false
		endif
	endif
	EquipItemLoose(akTarget,the_form)
	return true
EndFunction

Function DOMDoDrink(Actor akTarget, string type)
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoDrink "+name+" type="+type)
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		if type == "alcohol"
			akActor.OrderDrink()
		elseif type == "love"
			akActor.DrinkLovePotion(akAnotherActor)
		elseif type == "lust"
			akActor.DrinkLustPotion(akAnotherActor)
		elseif type == "lash"
			akActor.DrinkLashPotion(akAnotherActor)
		elseif type == "mind"
			akActor.DrinkMindPotion(akAnotherActor)
		elseif type == "narcotic"
			Form the_drug = akActor.GetANarcotic(PlayerRef)
			if the_drug != None
				LogTrace(akActor.GetName()+": Found "+the_drug.GetName())
				akActor.DrinkNarcoticPotion(akAnotherActor,the_drug)
			endif
		endif
		return
	endif
		
	bool should_wait = DOMSetFollowerPose(akTarget)
	int actorSex = akTarget.GetLeveledActorBase().GetSex()
	Form the_drink
	string the_anim
	string the_txt
	bool do_cough = false
	bool do_drunk = false
	float norm = 100.0
	Race akActorRace  = akTarget.GetLeveledActorBase().GetRace()
	string raceString = akActorRace.getName()+" "+MiscUtil.GetRaceEditorID(akActorRace)
	if DOMGenerator.IsYoungAdult(raceString)
		norm = 150.0
	endif

	if type == "alcohol"
		the_drink = DOMCore.FindAlcoholInInventory(akTarget)
		if the_drink == None
			LogTrace("OrderDrinkAlcohol no drink found in actor's inventory")
			the_drink = DOMCore.FindAlcoholInInventory(akAnotherActor)
		endif
		if the_drink == None
			HudNotification("OrderDrinkAlcohol no alcoholic drink found in actor's or player's inventory")
			return
		endif
		float amount = the_drink.GetWeight()
		float level = DOMCore.GetFormAlcoholLevel(the_drink)
		if level >= 2.0
			the_anim = DOM_Anim.GetDrinkWinePoseNPC(akTarget)
		else
			the_anim = DOM_Anim.GetDrinkMeadPoseNPC(akTarget)
		endif
		if level > 2.0 && ((amount > 0.1 && norm > 100.0) || RandomFloat()*norm > akTarget.GetFactionRank(DOMCore.DOMFacetToughness))
			do_cough = True
			the_txt = name+" coughs while trying to swallow the "+the_drink.getName()+", spilling most of it."
		elseif amount > 0.2 && RandomFloat()*norm > akTarget.GetFactionRank(DOMCore.DOMFacetWilfulness)
			do_cough = True
			the_txt = name+" barely manages to swallow some of the "+the_drink.getName()+", spilling most of it."
		elseif  amount > 0.5 && (RandomFloat()*norm > akTarget.GetFactionRank(DOMCore.DOMFacetWilfulness) || RandomFloat()*norm > akTarget.GetFactionRank(DOMCore.DOMFacetToughness))
			do_cough = True
			the_txt = name+" struggles to drink the bottle of "+the_drink.getName()
		else
			the_txt = name+" drinks the full bottle of "+the_drink.getName()
		endif
		int drunk_level = akTarget.GetFactionRank(DOMCore.DOMDrunkLevel)
		if drunk_level < 0
			drunk_level = 0
		endif
		drunk_level += (level as int)
		if drunk_level > 0
			TrainFactionWithMod(akTarget,DOMTrainSubmission,DOMModNaivety,5.0)
			TrainFactionWithMod(akTarget,DOMTrainResignation,DOMModManipulation,5.0)
			akTarget.SetFactionRank(DOMCore.DOMDrunkLevel,drunk_level)
			if drunk_level >= 3
				do_drunk = true
			endif
		else
			akTarget.RemoveFromFaction(DOMCore.DOMDrunkLevel)
			akTarget.PlayIdle(DOMCore.IdleDrunkStop)
		endif
	elseif type == "love"
		the_drink = DOMCore.DOMLovePotion
		the_anim = DOM_Anim.GetDrinkLovePotionPoseNPC(akTarget)
		the_txt = name+" falls under your charm"
		if (RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetWilfulness) || RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetSubmissivity))
			do_cough = True
		endif
	elseif type == "lust"
		the_drink = DOMCore.DOMLustPotion
		the_anim = DOM_Anim.GetDrinkLustPotionPoseNPC(akTarget)
		if actorSex == 0
			the_txt = name+"'s skin becomes red as blood flow increases in his intimate parts"
		else
			the_txt = name+"'s skin becomes red as blood flow increases in her intimate parts"
		endif
		if (RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetWilfulness) || RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetSensuality))
			do_cough = True
		endif
	elseif type == "lash"
		the_drink = DOMCore.DOMPainPotion
		the_anim = DOM_Anim.GetDrinkLashPotionPoseNPC(akTarget)
		if actorSex == 0
			the_txt = name+"'s face becomes white as fear of pain overflows his brain"
		else
			the_txt = name+"'s face becomes white as fear of pain overflows her brain"
		endif
		if (RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetWilfulness) || RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetToughness))
			do_cough = True
		endif
	elseif type == "mind"
		the_drink = DOMCore.DOMBrokenPotion
		the_anim = DOM_Anim.GetDrinkMindPotionPoseNPC(akTarget)
		the_txt = name+" is now under your control"
		if (RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetWilfulness) || RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetBoldness))
			do_cough = True
		endif
	elseif type == "narcotic"
		the_drink = DOMCore.Skooma
		the_anim = DOM_Anim.GetDrinkNarcoticPoseNPC(akTarget)
		the_txt = name+" is now under the influence of "+the_drink.GetName()
		if (RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetWilfulness) || RandomFloat()*100.0 > akTarget.GetFactionRank(DOMCore.DOMFacetBoldness))
			do_cough = True
		endif
		TrainNb(akTarget,DOMCore.DOMNbDrug)
		int rank = akTarget.GetFactionRank(DOMCore.DOMNbDrug)
		if (rank % 15) == 14
			TrainNb(akTarget,DOMCore.DOMTraumaInDays)
		endif
	endif
	if the_drink == None
		return
	endif
	if GetFromOwnerIfNeededAndDrink(akTarget,akAnotherActor,the_drink)
		SendAnimation(akTarget,the_anim)
		if do_cough 
			Wait(10.0*DOMCore.anim_speed_sec)
			SendAnimation(akTarget,DOM_Anim.GetCoughPoseNPC(akTarget))
		endif
		HudNotification(the_txt)
	endif
	Wait(10.0*DOMCore.anim_speed_sec)
	Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
	if do_drunk && !akTarget.IsInFaction(DOMActionTied)
		akTarget.PlayIdle(DOMCore.IdleDrunkStart)
	endif
	DOMUnsetFollowerPose(akTarget,should_wait)
EndFunction

Function DOMDoUntie(Actor akTarget)
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoUntie "+name)
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.ExitTieUpIfTied(PlayerRef)
		return
	endif
	DOMUnTieActor(akTarget, akAnotherActor, false)
EndFunction

Function DOMDoEquipBlindfold(Actor akTarget, Form the_form = None) ; default = clothes
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.EnterBlindfolded(akAnotherActor,the_form)
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoEquipBlindfold "+name+" blindfold="+the_form)
	if the_form == None
		the_form = DOMZaz.GetBlindfold0()
	endif
	Faction the_faction = DOMZaz.DOMHasBlindfold
	if the_form != None && akTarget.GetItemCount(the_form) <= 0
		akTarget.AddItem(the_form, 1, true) ; silent
	endif
	EquipItemTight(akTarget,the_form)
	if the_faction != None
		SetBoolFaction(akTarget,the_faction, true)
	endif
	TrainFactionWithMod(akTarget,DOMTrainSubmission,DOMModHumility,5.0)
	TrainNb(akTarget,DOMCore.DOMNbBondage)
EndFunction

Function DOMDoRemoveBlindfold(Actor akTarget)
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.ExitBlindfolded(akAnotherActor) 
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoRemoveBlindfold "+name)
	Form the_form = DOMZaz.GetEquippedGag(akTarget)
	Faction the_faction = DOMZaz.DOMHasBlindfold
	if the_form != None && akTarget.GetItemCount(the_form) > 0
		akTarget.UnEquipItem(the_form)
		akTarget.RemoveItem(the_form, 1, true) ; silent
	endif
	if the_faction != None
		SetBoolFaction(akTarget,the_faction, false)
	endif
EndFunction

Function DOMDoEquipGag(Actor akTarget, Form the_form = None) ; default = clothes
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		LogTrace("DOMDoEquipGag DOMActor "+akActor.GetName()+" gag="+the_form)
		akActor.EnterGagged(akAnotherActor,the_form) 
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoEquipGag Actor "+name+" gag="+the_form)
	if the_form == None
		the_form = DOMZaz.GetEquippedGag(akTarget)
		if the_form == None
			the_form = DOMZaz.GetGagCloth()
		endif
	endif
	Faction the_faction = DOMZaz.DOMHasMouthGag
	if the_form != None && akTarget.GetItemCount(the_form) <= 0
		akTarget.AddItem(the_form, 1, true) ; silent
	endif
	EquipItemTight(akTarget,the_form)
	if the_faction != None
		SetBoolFaction(akTarget,the_faction, true)
	endif
	TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModNaivety,5.0)
	TrainNb(akTarget,DOMCore.DOMNbBondage)
EndFunction

Function DOMDoRemoveGag(Actor akTarget)
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		LogTrace("DOMDoRemoveGag DOMActor "+akActor.GetName())
		akActor.ExitGagged(akAnotherActor) 
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoRemoveGag Actor "+name)
	Form the_form = DOMZaz.GetEquippedGag(akTarget)
	Faction the_faction = DOMZaz.DOMHasMouthGag
	if the_form != None && akTarget.GetItemCount(the_form) > 0
		akTarget.UnEquipItem(the_form)
		akTarget.RemoveItem(the_form, 1, true) ; silent
	endif
	if the_faction != None
		SetBoolFaction(akTarget,the_faction, false)
	endif
EndFunction

Function DOMDoEquipPlug(Actor akTarget, bool is_vaginal) ; false = anal
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.EnterPlugged(akAnotherActor,is_vaginal) ; false = anal
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoEquipPlug "+name+" is_vaginal="+is_vaginal)
	Form the_form
	Faction the_faction
	if is_vaginal
		the_form = DOMZaz.GetPlugVaginal()
		the_faction = DOMZaz.DOMHasPlugVaginal
		TrainFactionWithMod(akTarget,DOMTrainVaginal,DOMModVaginal,5.0)
		IncreaseArousal(akTarget,akAnotherActor,5.0,DOMModNaivety)
	else
		the_form = DOMZaz.GetPlugAnal()
		the_faction = DOMZaz.DOMHasPlugAnal
		TrainFactionWithMod(akTarget,DOMTrainAnal,DOMModAnal,5.0)
		IncreaseArousal(akTarget,akAnotherActor,5.0,DOMModHumility)
	endif
	if the_form != None && akTarget.GetItemCount(the_form) <= 0
		akTarget.AddItem(the_form, 1, true) ; silent
	endif
	EquipItemTight(akTarget,the_form)
	if the_faction != None
		SetBoolFaction(akTarget,the_faction, true)
	endif
	TrainNb(akTarget,DOMCore.DOMNbShame)
EndFunction

Function DOMDoRemovePlug(Actor akTarget, bool is_vaginal) ; false = anal
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.ExitPlugged(akAnotherActor,is_vaginal) ; false = anal
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoRemovePlug "+name+" is_vaginal="+is_vaginal)
	Form the_form
	Faction the_faction
	if is_vaginal
		the_form = DOMZaz.GetPlugVaginal()
		the_faction = DOMZaz.DOMHasPlugVaginal
	else
		the_form = DOMZaz.GetPlugAnal()
		the_faction = DOMZaz.DOMHasPlugVaginal
	endif
	if the_form != None && akTarget.GetItemCount(the_form) > 0
		akTarget.UnEquipItem(the_form) ; can not unequip, silent
		akTarget.RemoveItem(the_form, 1, true) ; silent
	endif
	if the_faction != None
		SetBoolFaction(akTarget,the_faction, false)
	endif
EndFunction

Function DOMDoEntertain(Actor akTarget, string type)
	if akTarget == None
		return
	endif
	Actor akAnotherActor = PlayerRef
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		sl_alias.DoEntertain(akAnotherActor,type)
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, akAnotherActor, false)
	endif
	DOMSetFollowerWait(akTarget,true)
	UnEquipHandheld(akTarget)
	string name = akTarget.GetDisplayName()
	string the_pose
	if type == "shower"
		DOMDoNPCShower(akTarget)
		return
	elseif type == "display"
		DOMDoDisplay(akTarget)
		return
	elseif type== "favor"
		SendAnimation(akTarget,"IdleForceDefaultState")	
		akTarget.SetDoingFavor()
		return
	elseif type == "kneel"
		if akTarget.IsInFaction(DOMActionTied)
			the_pose = DOM_Anim.GetTieupKneelingNPC(akTarget)
		else
			the_pose = DOMCore.kneelPose
		endif
	elseif type == "salute"
		the_pose = DOMCore.salutePose
	elseif type == "attention"
		the_pose = DOMCore.attentionPose
	elseif type == "light"
		Form the_form = DOMEquip.Torch01
		if the_form != None && akTarget.GetItemCount(the_form) <= 0
			akTarget.AddItem(the_form, 1, true) ; silent
		endif
		EquipItemLoose(akTarget,the_form)
		return
	elseif type == "ass"
		the_pose = DOM_Anim.GetAssPresentationPoseNPC(akTarget)
	elseif type == "breasts"
		the_pose = DOM_Anim.GetBreastPresentationPoseNPC(akTarget)
	elseif type == "chair"
		the_pose = DOM_Anim.GetChairPoseNPC(akTarget)				
	elseif type == "cute"
		the_pose = DOM_Anim.GetCutePoseNPC(akTarget)
	elseif type == "dance"
		the_pose = DOM_Anim.GetDancePoseNPC(akTarget)	
	elseif type == "drinks"
		the_pose = DOM_Anim.GetDrinksPoseNPC(akTarget)	
	elseif type == "exercise"
		the_pose = DOM_Anim.GetExercisePoseNPC(akTarget)
	elseif type== "flowers"
		the_pose = DOM_Anim.GetFlowersPoseNPC(akTarget)
	elseif type == "music"
		the_pose = DOM_Anim.GetMusicPoseNPC(akTarget)	
	elseif type == "pussy"
		the_pose = DOM_Anim.GetPussyPresentationPoseNPC(akTarget)
	elseif type == "submissive"
		the_pose = DOM_Anim.GetSubmissivePoseNPC(akTarget)
	elseif type == "sexy"
		the_pose = DOM_Anim.GetSexyPoseNPC(akTarget)
	elseif type == "cleaning"
		the_pose = DOM_Anim.GetBroomPoseNPC(akTarget)	
	endif
	SendAnimation(akTarget,"IdleForceDefaultState")
	LogTrace("DOMDoEntertain "+name+" type="+type+" pose="+the_pose)
	TrainFactionWithMod(akTarget,DOMCore.DOMTrainPose,DOMCore.DOMModFlexibility,5.0)
	TrainNb(akTarget,DOMCore.DOMNbShame)
	SendAnimation(akTarget,the_pose)
EndFunction

string mast_last_type = ""
Function DOMDoMasturbate(Actor akTarget, string type)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	Actor akAnotherActor = PlayerRef
	LogTrace("DOMDoMasturbate "+name+" "+type)
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		sl_alias.DoMasturbate(akAnotherActor,type)
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, akAnotherActor, false)
	endif
	DOMSetFollowerWait(akTarget,true)
	UnEquipHandheld(akTarget)
	int actorSex = akTarget.GetLeveledActorBase().GetSex()
	string the_pose
	if type == "stand"
		the_pose = DOM_Anim.GetMasturbateStandingPoseNPC(akTarget,0)
		mast_last_type = type
	elseif type == "kneel"
		the_pose = DOM_Anim.GetMasturbateKneelingPoseNPC(akTarget,0)
		mast_last_type = type
	elseif type == "lay"
		the_pose = DOM_Anim.GetMasturbateLayingPoseNPC(akTarget,0)
		mast_last_type = type
	else ; harder
		if mast_last_type == "stand"
			the_pose = DOM_Anim.GetMasturbateStandingPoseNPC(akTarget,2)
		elseif mast_last_type == "kneel"
			the_pose = DOM_Anim.GetMasturbateKneelingPoseNPC(akTarget,2)
		elseif mast_last_type == "lay"
			the_pose = DOM_Anim.GetMasturbateLayingPoseNPC(akTarget,2)
		else
			the_pose = DOM_Anim.GetMasturbateStandingPoseNPC(akTarget,3)
		endif
	endif
	SendAnimation(akTarget,the_pose)
	float mod = DOMCore.GetDepraverModifier(akAnotherActor)
	float amount = DOMCore.train_speed_sex*0.0125*mod
	if type == "stand"
		TrainFactionWithMod(akTarget,DOMTrainAnal,DOMModAnal,amount)
		TrainFactionWithMod(akTarget,DOMTrainVaginal,DOMModVaginal,amount)
		TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModNaivety,DOMCore.train_speed_tell*0.025*mod)
	elseif type == "kneel"
		TrainFactionWithMod(akTarget,DOMTrainOral,DOMModOral,amount)
		TrainFactionWithMod(akTarget,DOMTrainVaginal,DOMModVaginal,amount)
		TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModNaivety,DOMCore.train_speed_tell*0.025*mod)
	elseif type == "lay"
		TrainFactionWithMod(akTarget,DOMTrainOral,DOMModOral,amount)
		TrainFactionWithMod(akTarget,DOMTrainAnal,DOMModAnal,amount)
		TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModNaivety,DOMCore.train_speed_tell*0.025*mod)
	else ; "harder"
		TrainFactionWithMod(akTarget,DOMTrainOral,DOMModOral,amount)
		TrainFactionWithMod(akTarget,DOMTrainAnal,DOMModAnal,amount)
		TrainFactionWithMod(akTarget,DOMTrainVaginal,DOMModVaginal,amount)
	endif
	TrainNb(akTarget,DOMCore.DOMNbShame)
	DOMCore.TrainSkillDepraver(akAnotherActor,0.5)
EndFunction

Function DOMDoWork(Actor akTarget, int type)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	string name = akTarget.GetDisplayName()
	Actor akAnotherActor = PlayerRef
	LogTrace("DOMDoWork "+name+" "+type)
		if debugKeyMode
			HudNotification("Order "+name+" to work")
		endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		sl_alias.EnterWork(type) ; 2 is find wood chopping block and cut wood
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, akAnotherActor, false)
	endif
	if akTarget.IsInFaction(PlayerFollowerFaction) || akTarget.IsInFaction(CurrentFollowerFaction)
		DOMSetFollowerSandbox(akTarget,true)
	else
		DOMCore.NPCStartWaitSandbox(akTarget)
	endif
	TrainFactionWithMod(akTarget,DOMCore.DOMTrainWorking,DOMModAuthority,5.0)
	TrainFactionWithMod(akTarget,DOMCore.DOMTrainResignation,DOMModDiligent,5.0)
EndFunction

Function DOMDoBeRespectful(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		if !sl_alias.mind.should_be_respectful
			sl_alias.SetShouldBeRespectful(PlayerRef)
			if debugKeyMode
				HudNotification("Be respectful "+sl_alias.getName())
			endif
		else
			sl_alias.UnsetShouldBeRespectful(PlayerRef)
			if debugKeyMode
				HudNotification("Don't be respectful "+sl_alias.getName())
			endif
		endif
		return
	endif
	if akTarget.IsInFaction(DOMShouldBeRespectful)
		akTarget.RemoveFromFaction(DOMShouldBeRespectful)
	else
		akTarget.SetFactionRank(DOMShouldBeRespectful,1)
		TrainFactionWithMod(akTarget,DOMTrainRespect,DOMModDiscipline,5.0)
	endif
EndFunction

Function DOMDoWalkOnFour(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		if !sl_alias.mind.should_walk_on_four
			sl_alias.SetShouldWalkOnFour(PlayerRef)
			if debugKeyMode
				HudNotification("Walk on 4 "+sl_alias.getName())
			endif
		else
			sl_alias.UnsetShouldWalkOnFour(PlayerRef)
			if debugKeyMode
				HudNotification("Walk Normal "+sl_alias.getName())
			endif
		endif
		return
	endif
	if akTarget.IsInFaction(DOMShouldWalkOnFour)
		akTarget.RemoveFromFaction(DOMShouldWalkOnFour)
		akTarget.RemoveFromFaction(DOMCore.DOMIsWalkingOnFour)
	else
		akTarget.SetFactionRank(DOMShouldWalkOnFour,1)
		akTarget.SetFactionRank(DOMCore.DOMIsWalkingOnFour,1)
		TrainNb(akTarget,DOMCore.DOMNbShame)
		TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModDiscipline,5.0)
	endif
EndFunction

Function DOMDoDisplay(Actor akTarget)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	Actor akAnotherActor = PlayerRef
	LogTrace("DOMDoDisplay "+name)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		sl_alias.DoDisplay(akAnotherActor)
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, akAnotherActor, false)
	endif
	DOMSetFollowerWait(akTarget,true)
	UnEquipHandheld(akTarget)
	string the_pose = DOM_Anim.GetDisplayPoseNPC(akTarget)
	SendAnimation(akTarget,the_pose)
	int value = DOMCore.DOMGenerator.GetActorPrice(akTarget)
	if value < 100
		HudNotification(name+" would make a poor slave for "+value+" gold")
	elseif value < 1000
		HudNotification(name+" would make an untamed slave for "+value+" gold")
	elseif value < 5000
		HudNotification(name+" would make a fine slave for "+value+" gold")
	else
		HudNotification(name+" would make a great slave for "+value+" gold")
	endif
	float mod = DOMCore.GetSlaverModifier(akAnotherActor)
	TrainFactionWithMod(akTarget,DOMTrainAnger,DOMModForgiveness,DOMCore.train_speed_tell*0.1*mod)
	TrainFactionWithMod(akTarget,DOMTrainHumiliation,DOMModNaivety,DOMCore.train_speed_tell*0.1*mod)
	TrainNb(akTarget,DOMCore.DOMNbShame)
	IncreaseArousal(akTarget,akAnotherActor,5.0,DOMModNaivety)
	DOMCore.TrainSkillSlaver(akAnotherActor,0.5)
EndFunction

Function DOMDoChoke(Actor akTarget)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoChoke "+name)
	Actor akAnotherActor = PlayerRef
	if debugKeyMode
		HudNotification("Choking a disrespectful "+name)
	endif
	DOM_Actor sl_alias = DOM01.GetActor(akTarget)
	if sl_alias != None
		sl_alias.Interact_Punish(akAnotherActor,"","choke")
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, akAnotherActor, false)
	endif
	bool should_wait = DOMSetFollowerPose(akTarget)
	UnEquipHandheld(akTarget)
	
	string anim_key = "DOMPunishChoke"
	StartJSONAnimation(akTarget,akAnotherActor,anim_key)
	
	if !WillObeyForGrab(akTarget)
		AnswerSorryToInsult(akTarget,DOMTrainSubmission,DOMModHumility)
	else
		AnswerBadToInsult(akTarget,DOMTrainAnger,DOMModResentment)
	endif
	
	PlayJSONAnimation(1)
	DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerTouchNeck)
	PlayJSONAnimations(2,JSONanim_nscenes-(1))
	EndJSONAnimation()

	TrainFactionWithMod(akTarget,DOMTrainFear,DOMModFearfulness,5.0)
	TrainFactionWithMod(akTarget,DOMTrainRespect,DOMModDiscipline,5.0)
	TrainFactionWithMod(akTarget,DOMTrainResignation,DOMModFearfulness,5.0)
	TrainNb(akTarget,DOMCore.DOMNbPain)
	DOMUnsetFollowerPose(akTarget,should_wait)
EndFunction

Function DOMDoGrab(Actor akTarget, string type)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoGrab "+name+" "+type)
	Actor akAnotherActor = PlayerRef
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		sl_alias.Interact_Grab(akAnotherActor,type)
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, akAnotherActor, false)
	endif
	bool should_wait = DOMSetFollowerPose(akTarget)
	UnEquipHandheld(akTarget)
	
	string anim_key
	if type == "Front"
		anim_key = "DOMGrabFront"
	elseif type == "Back"
		anim_key = "DOMGrabBack"
	elseif type == "Floor"
		anim_key = "DOMGrabFloor"
	else
		anim_key = "DOMGrab"+type
	endif
	StartJSONAnimation(akTarget,akAnotherActor,anim_key)
	
	if !WillObeyForGrab(akTarget)
		AnswerNoToSex(akTarget,DOMTrainAnger,DOMModForgiveness)
		PlayJSONAnimation(1)
		EndJSONAnimation()
		return
	endif
	
	AnswerYesToSex(akTarget,DOMTrainAnger,DOMModForgiveness)
	TrainFactionWithMod(akTarget,DOMTrainRespect,DOMModDiscipline,5.0)
	TrainFactionWithMod(akTarget,DOMTrainSubmission,DOMModManipulation,5.0)
	TrainNb(akTarget,DOMCore.DOMNbShame)
	
	string actorObjective
	string actorPossessive
	if akTarget.GetLeveledActorBase().GetSex() == 0
		actorObjective = "him"
		actorPossessive = "his"
	else
		actorObjective = "her"
		actorPossessive = "her"
	endif
	float bonus = 0.0
	if RandomFloat()*100.0 < akTarget.GetFactionRank(DOMFacetSensuality)
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerTouchBegin)
		HudNotification(name+" shivers as your hand approaches")
		bonus += 25.0
		IncreaseArousal(akTarget,akAnotherActor,2.5,DOMModNaivety)
	endif
	PlayJSONAnimation(2)
	if  JSONanim_nscenes > 3 && (RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainHumiliation))
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerTouchBreast)
		HudNotification(name+"'s nipples perk up")
		bonus += 25.0
		IncreaseArousal(akTarget,akAnotherActor,2.5,DOMModDaring)
	endif
	PlayJSONAnimation(3)
	if  JSONanim_nscenes > 4 && (RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModAnal))
		TrainFactionWithMod(akTarget,DOMTrainAnal,DOMModAnal,5.0)
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerTouchButt)
		HudNotification(name+" spontaneously arches "+actorPossessive+" back")
		bonus += 25.0
		IncreaseArousal(akTarget,akAnotherActor,2.5,DOMModAnal)
	endif
	PlayJSONAnimation(4)
	if  JSONanim_nscenes > 5 && (RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModOral))
		TrainFactionWithMod(akTarget,DOMTrainOral,DOMModOral,5.0)
		HudNotification(name+" unconsciously parts "+actorPossessive+" lips")
		bonus += 25.0
		IncreaseArousal(akTarget,akAnotherActor,2.5,DOMModOral)
	endif
	PlayJSONAnimation(5)
	if  JSONanim_nscenes > 6 && (RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModVaginal))
		TrainFactionWithMod(akTarget,DOMTrainVaginal,DOMModVaginal,5.0)
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerTouchBase)
		if akTarget.GetLeveledActorBase().GetSex() == 0
			HudNotification(name+"'s crotch feels stiff and warm")
		else
			HudNotification(name+"'s vagina feels nice and warm")
		endif
		bonus += 25.0
		IncreaseArousal(akTarget,akAnotherActor,2.5,DOMModVaginal)
	endif
	if IsAVirgin(akTarget)
		HudNotification(name+" certainly feels like a virgin")
		bonus += 25.0
		PlayJSONAnimation(7)
		IncreaseArousal(akTarget,akAnotherActor,2.5,DOMModDaring)
	endif

	if bonus == 0.0
	    HudNotification("Checking "+name+"'s intimate parts ")
		PlayJSONAnimation(8)
	elseif (DOMSexlab.GetArousalValue(akTarget)+akTarget.GetFactionRank(DOMFacetSensuality)/10.0+bonus) > 100.0
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerAroused)
		HudNotification(name+" cannot hide "+actorPossessive+" arousal")
		PlayJSONAnimation(9)
	endif

	PlayJSONAnimations(11,JSONanim_nscenes-(1))
	EndJSONAnimation()
	
	DOMCore.TrainSkillDepraver(akAnotherActor,0.5)
	DOMUnsetFollowerPose(akTarget,should_wait)
EndFunction

Function DOMDoVampireKiss(Actor akTarget)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	if SKSE.GetPluginVersion("VampireFeedProxy") >= 0 ; VampireFeedProxy is installed
		LogTrace("DOMDoVampireKiss VampireFeedProxy "+name)
		; Use vampire feed proxy for compability
		vampirefeedproxy.VampireFeed(akTarget, false)
	else
		LogTrace("DOMDoVampireKiss VampireFeedVanilla "+name)
		; Everything will be taken care of by the player's OnVampireFeed event
		PlayerRef.StartVampireFeed(akTarget)
	endif
EndFunction

Function DOMDoKiss(Actor akTarget, string type)
	if akTarget == None
		return
	endif
	string name = akTarget.GetDisplayName()
	LogTrace("DOMDoKiss "+name+" "+type)
	Actor akAnotherActor = PlayerRef
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		sl_alias.Interact_Kiss(akAnotherActor,type)
		return
	endif
	if akTarget.IsInFaction(DOMActionTied)
		DOMUnTieActor(akTarget, akAnotherActor, false)
	endif
	bool should_wait = DOMSetFollowerPose(akTarget)
	UnEquipHandheld(akTarget)
	bool had_mouth_gag = false
	Form the_form = None
	if akTarget.IsInFaction(DOMZaz.DOMHasMouthGag)
		had_mouth_gag = true
		the_form = DOMZaz.GetEquippedGag(akTarget)
		DOMDoRemoveGag(akTarget)
	endif

	string anim_key
	if type == "Forced"
		anim_key = "DOMKissForced"
	elseif type == "Dominant"
		anim_key = "DOMKissDominant"
	elseif type == "Short"
		anim_key = "DOMKissShort"
	elseif type == "Side"
		anim_key = "DOMKissSide"
	elseif type == "Long"
		anim_key = "DOMKissLong"
	elseif type == "Love"
		anim_key = "DOMKissLove"
	else 
		anim_key = "DOMKiss"+type
	endif
	StartJSONAnimation(akTarget,akAnotherActor,anim_key)

	if !WillObeyForKiss(akTarget)
		AnswerNoToSex(akTarget,DOMTrainAnger,DOMModForgiveness)
		PlayJSONAnimation(1)
		EndJSONAnimation()
		return
	endif
	
	AnswerYesToSex(akTarget,DOMTrainAnger,DOMModForgiveness)
	TrainFactionWithMod(akTarget,DOMTrainSubmission,DOMModManipulation,5.0)
	
	string actorObjective
	string actorPossessive
	if akTarget.GetLeveledActorBase().GetSex() == 0
		actorObjective = "him"
		actorPossessive = "his"
	else
		actorObjective = "her"
		actorPossessive = "her"
	endif
	float bonus = 0.0
	if RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModOral) ||	RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainOral)
		TrainFactionWithMod(akTarget,DOMTrainOral,DOMModOral,5.0)
		HudNotification(name+" unconsciously parts "+actorPossessive+" lips")
		bonus += 25.0
		IncreaseArousal(akTarget,akAnotherActor,2.5,DOMModOral)
	endif
	PlayJSONAnimation(2)
	if JSONanim_nscenes > 3 && (RandomFloat()*100.0 < GetModifierFromFaction(akTarget,DOMModVaginal) ||	RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainVaginal))
		TrainFactionWithMod(akTarget,DOMTrainVaginal,DOMModVaginal,5.0)
		HudNotification(name+"'s crotch slowly moves closer to yours")
		bonus += 25.0
		IncreaseArousal(akTarget,akAnotherActor,5.0,DOMModVaginal)
	endif
	PlayJSONAnimation(3)
	if JSONanim_nscenes > 4 && (RandomFloat()*100.0 < akTarget.GetFactionRank(DOMFacetSensuality) || RandomFloat()*100.0 < akTarget.GetFactionRank(DOMTrainSubmission))
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerTouchBegin)
		HudNotification(name+" shivers as you hold "+actorObjective)
		bonus += 25.0
		IncreaseArousal(akTarget,akAnotherActor,2.5,DOMModDaring)
	endif
	PlayJSONAnimation(4)

	if bonus == 0.0
	    HudNotification("Kissing an unwilling "+name)
	elseif (DOMSexlab.GetArousalValue(akTarget)+akTarget.GetFactionRank(DOMFacetSensuality)/10.0+bonus) > 100.0
		DOMCore.SayTopic(akTarget,DOMCore.DOM02TopicAnswerAroused)
		HudNotification(name+" cannot hide "+actorPossessive+" arousal")
		PlayJSONAnimation(5)
	endif

	PlayJSONAnimations(6,JSONanim_nscenes-(1))
	EndJSONAnimation()

	DOMCore.TrainSkillDeceiver(akAnotherActor,0.5)
	if had_mouth_gag
		had_mouth_gag = true
		DOMDoEquipGag(akTarget,the_form)
	endif
	DOMUnsetFollowerPose(akTarget,should_wait)
EndFunction

Int Function ShowDOMKinkyMenu(DOM_Actor sl_alias)
	if !wheelIsDefaultMenu
		return DOMSlaveKinkyMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Sex menu for "+sl_alias.getName())
	endif
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Doggy ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Doggy ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	if (sl_alias.actorSex %2 == 1)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Cowgirl ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Cowgirl ")	
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Cowboy ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Cowboy ")	
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Standing ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Standing ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Holding ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Holding ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Rough ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Rough ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Bound ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Bound ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Done ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Done ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "More ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "More ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMKinkyJobsMenu(DOM_Actor sl_alias)
	if !wheelIsDefaultMenu
		return DOMSlaveKinkyMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Sex menu for "+sl_alias.getName())
	endif
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Handjob ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Handjob ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Boobjob ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Boobjob ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Creampie ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Creampie ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Facial ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Facial ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "In Mouth ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "In Mouth ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Footjob ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Footjob ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Fisting ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Fisting ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Back ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Back ")	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

string Function FillKnownKinkTags(DOM_actor akActor)
	if akActor == None
		return ""
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return ""
	endif
	int n = akMind.GetNumberOfKnownKinks()
	if n <= 0
		return ""
	endif
	string tags = ""
	if akMind.HasKnownKink(53) ; "being fucked doggy style"
		tags = AddTag(tags,"Doggy,Doggystyle")
	endif
	if akMind.HasKnownKink(52) ; "being fucked cowgirl style"
		tags = AddTag(tags,"Cowgirl,ReverseCowgirl")
	endif
	if akMind.HasKnownKink(54) ; "being fucked standing"
		tags = AddTag(tags,"Standing")
	endif
	if akMind.HasKnownKink(51) ; "being held while fucked"
		tags = AddTag(tags,"Holding,Hugging")
	endif
	if akMind.HasKnownKink(32) ; "having rough sex"
		tags = AddTag(tags,"Rough,Forced,Aggressive")
	endif
	if akMind.HasKnownKink(33) ; "having tied-up sex"
		tags = AddTag(tags,"Bound,Tied")
	endif
	if akMind.HasKnownKink(40) ; "giving a handjob" 
		tags = AddTag(tags,"Handjob,Hands")
	endif
	if akMind.HasKnownKink(42) ; "giving a boobjob"
		tags = AddTag(tags,"Boobjob")
	endif
	if akMind.HasKnownKink(44) ; "getting creampied"
		tags = AddTag(tags,"Creampie")
	endif
	if akMind.HasKnownKink(45) ; "getting a facial"
		tags = AddTag(tags,"Facial")
	endif
	if akMind.HasKnownKink(46) ; "getting cum in mouth"
		tags = AddTag(tags,"CumInMouth")
	endif
	if akMind.HasKnownKink(41) ; "giving a footjob"
		tags = AddTag(tags,"Footjob,Feet")
	endif
	if akMind.HasKnownKink(49) ; "getting fisted"
		tags = AddTag(tags,"Fisting")
	endif
	return tags
EndFunction

Function DOMDoKinkyMenu(DOM_Actor sl_alias, bool aggro)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMKinkyMenu(sl_alias)
	if imenu == 0
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Doggy,Doggystyle")
	elseif imenu == 1
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Cowgirl,ReverseCowgirl")
	elseif imenu == 2
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Standing")
	elseif imenu == 3
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Holding,Hugging")
	elseif imenu == 4
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Rough,Forced,Aggressive")
	elseif imenu == 5
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Bound,Tied")
	elseif imenu == 6
		if DOMSexlab.DefaultSexlabExtraTags == ""
			DOMSexlab.DefaultSexlabExtraTags = FillKnownKinkTags(sl_alias)
			if DOMSexlab.DefaultSexlabExtraTags == ""
				HudNotification("No known sex kinks")
			else
				HudNotification("Kink tags="+DOMSexlab.DefaultSexlabExtraTags)
			endif
		endif
		if aggro
			DOMDoRapeMenu(sl_alias.akRef)
		else
			DOMDoSexMenu(sl_alias.akRef)
		endif
		return
	elseif imenu == 7
		DOMDoKinkyJobsMenu(sl_alias,aggro)
	endif
	if imenu >= 0 && imenu < 6
		HudNotification("Kink tags="+DOMSexlab.DefaultSexlabExtraTags)
		DOMDoKinkyMenu(sl_alias,aggro)
	endif
EndFunction

Function DOMDoKinkyJobsMenu(DOM_Actor sl_alias, bool aggro)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMKinkyJobsMenu(sl_alias)
	if imenu == 0
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Handjob,Hands")
	elseif imenu == 1
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Boobjob")
	elseif imenu == 2
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Creampie")
	elseif imenu == 3
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Facial")
	elseif imenu == 4
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"CumInMouth")
	elseif imenu == 5
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Footjob,Feet")
	elseif imenu == 6
		DOMSexlab.DefaultSexlabExtraTags = AddTag(DOMSexlab.DefaultSexlabExtraTags,"Fisting")
	elseif imenu == 7
		DOMDoKinkyMenu(sl_alias,aggro)
	endif
	if imenu >= 0 && imenu < 7
		HudNotification("Kink tags="+DOMSexlab.DefaultSexlabExtraTags)
		DOMDoKinkyJobsMenu(sl_alias,aggro)
	endif
EndFunction

Function DOMDoRapeMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMSexMenu(akTarget,true)
	if imenu == 0
		sl_alias.StartPunishingWithTag(PlayerRef, "", "rape", "Vaginal")
	elseif imenu == 1
		sl_alias.StartPunishingWithTag(PlayerRef, "", "rape", "Oral")
	elseif imenu == 2
		sl_alias.StartPunishingWithTag(PlayerRef, "", "rape", "Anal")
	elseif imenu == 3
		DOMDoKinkyMenu(sl_alias,true)
	elseif imenu == 4
		imenu = ShowDOMSlaveSelectMenu(sl_alias)
		if imenu >= 0
			DOM_actor aSlave = selectArray[imenu]
			if aSlave != None
				sl_alias.StartPunishmentOn(aSlave, "", "rape", "")
			endif
		endif
	elseif imenu == 5
		imenu = ShowDOMSlaveSelectMenu(sl_alias)
		if imenu >= 0
			DOM_actor aSlave = selectArray[imenu]
			if aSlave != None
				sl_alias.StartSexOnActor3AAP(aSlave, "", true) ; aggressive
			endif
		endif
	elseif imenu == 6
		int imenu1 = ShowDOMSlaveSelectMenu(sl_alias)
		if imenu1 >= 0
			DOM_actor aSlave1 = selectArray[imenu1]
			if aSlave1 != None
				int imenu2 = ShowDOMSlaveSelectMenu2(sl_alias,aSlave1)
				if imenu2 >= 0
					DOM_actor aSlave2 = selectArray[imenu2]
					if aSlave2 != None
						sl_alias.StartSexOnActor3AAA(aSlave1, aSlave2, "", true) ; aggressive
					endif
				endif
			endif
		endif
	elseif imenu == 7
		int imenu1 = ShowDOMSlaveSelectMenu(sl_alias)
		if imenu1 >= 0
			DOM_actor aSlave1 = selectArray[imenu1]
			if aSlave1 != None
				int imenu2 = ShowDOMSlaveSelectMenu2(sl_alias,aSlave1)
				if imenu2 >= 0
					DOM_actor aSlave2 = selectArray[imenu2]
					if aSlave2 != None
						sl_alias.StartSexOnActor4AAAP(aSlave1, aSlave2, "", true) ; aggressive
					endif
				endif
			endif
		endif
	endif
EndFunction

Function DOMDoSexWith(DOM_Actor sl_alias, Actor akAnotherActor, string type, bool aggro)
	sl_alias.StartSexWith(akAnotherActor,type,aggro)
EndFunction

Function DOMDoSexMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMSexMenu(akTarget,false)
	if imenu == 0
		DOMDoSexWith(sl_alias,PlayerRef,"Vaginal",false)
	elseif imenu == 1
		DOMDoSexWith(sl_alias,PlayerRef,"Oral",false)
	elseif imenu == 2
		DOMDoSexWith(sl_alias,PlayerRef,"Anal",false)
	elseif imenu == 3
		DOMDoKinkyMenu(sl_alias,false)
	elseif imenu == 4
		imenu = ShowDOMSlaveSelectMenu(sl_alias)
		if imenu >= 0
			DOM_actor aSlave = selectArray[imenu]
			if aSlave != None
				sl_alias.StartSexOnActor(aSlave,"",false)
			endif
		endif
	elseif imenu == 5
		imenu = ShowDOMSlaveSelectMenu(sl_alias)
		if imenu >= 0
			DOM_actor aSlave = selectArray[imenu]
			if aSlave != None
				sl_alias.StartSexOnActor3AAP(aSlave, "", false) ; not aggressive
			endif
		endif
	elseif imenu == 6
		int imenu1 = ShowDOMSlaveSelectMenu(sl_alias)
		if imenu1 >= 0
			DOM_actor aSlave1 = selectArray[imenu1]
			if aSlave1 != None
				int imenu2 = ShowDOMSlaveSelectMenu2(sl_alias,aSlave1)
				if imenu2 >= 0
					DOM_actor aSlave2 = selectArray[imenu2]
					if aSlave2 != None
						sl_alias.StartSexOnActor3AAA(aSlave1, aSlave2, "", false) ; not aggressive
					endif
				endif
			endif
		endif
	elseif imenu == 7
		int imenu1 = ShowDOMSlaveSelectMenu(sl_alias)
		if imenu1 >= 0
			DOM_actor aSlave1 = selectArray[imenu1]
			if aSlave1 != None
				int imenu2 = ShowDOMSlaveSelectMenu2(sl_alias,aSlave1)
				if imenu2 >= 0
					DOM_actor aSlave2 = selectArray[imenu2]
					if aSlave2 != None
						sl_alias.StartSexOnActor4AAAP(aSlave1, aSlave2, "", false) ; not aggressive
					endif
				endif
			endif
		endif
	endif
EndFunction

Function DOMSexyPoseMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMSexyPoseMenu()
	if imenu == 0
		sl_alias.DoSubmissive(PlayerRef)
	elseif imenu == 1
		sl_alias.DoAssPresentation(PlayerRef)
	elseif imenu == 2
		sl_alias.DoBreastsPresentation(PlayerRef)
	elseif imenu == 3
		sl_alias.DoPussyPresentation(PlayerRef)
	elseif imenu == 4
		sl_alias.DoCute(PlayerRef)
	elseif imenu == 5
		sl_alias.DoDance(PlayerRef)
	elseif imenu == 6
		sl_alias.DoMusic(PlayerRef)
	elseif imenu == 7
		DOMDoPoseMenu(akTarget)
	endif
EndFunction

Function DOMAllPoseMenu()
	int imenu = ShowDOMPoseMenu()
	if imenu == 0
		DOMAllOrderSlaves("DoChair",distance=10000.0)
	elseif imenu == 1
		DOMAllOrderSlaves("DoLight",distance=10000.0)
	elseif imenu == 2
		DOMAllOrderSlaves("DoFlowers",distance=10000.0)
	elseif imenu == 3
		DOMAllOrderSlaves("DoDrinks",distance=10000.0)
	elseif imenu == 4
		DOMAllOrderSlaves("DoCute",distance=10000.0)
	elseif imenu == 5
		DOMAllOrderSlavesAndSlavers("DoDance",distance=10000.0)
	elseif imenu == 6
		DOMAllOrderSlaves("DoMusic",distance=10000.0)
	elseif imenu == 7
		DOMAllSexyPoseMenu()
	endif
	if imenu >= 0 && menuPAH
		DOMPAH.AllPose(imenu)
	endif
EndFunction

Function DOMAllSexyPoseMenu()
	int imenu = ShowDOMSexyPoseMenu()
	if imenu == 0
		DOMAllOrderSlaves("DoSubmissive")
	elseif imenu == 1
		DOMAllOrderSlaves("DoAssPresentation")
	elseif imenu == 2
		DOMAllOrderSlaves("DoBreastsPresentation")
	elseif imenu == 3
		DOMAllOrderSlaves("DoPussyPresentation")
	elseif imenu == 4
		DOMAllOrderSlaves("DoCute")
	elseif imenu == 5
		DOMAllOrderSlaves("DoDance")
	elseif imenu == 6
		DOMAllOrderSlaves("DoMusic")
	elseif imenu == 7
		DOMAllPoseMenu()
	endif
EndFunction

Function DOMDoThreatenMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMDoThreatenMenu()
	if imenu == 0
		sl_alias.StartThreatening(PlayerRef,"running away")
	elseif imenu == 1
		sl_alias.StartThreatening(PlayerRef,"being angry")
	elseif imenu == 2
		sl_alias.StartThreatening(PlayerRef,"being disrespectful")
	elseif imenu == 3
		sl_alias.StartThreatening(PlayerRef,"crying")
	elseif imenu == 4
		sl_alias.StartThreatening(PlayerRef,"didnt fight")
	elseif imenu == 5
		sl_alias.StartThreatening(PlayerRef,"didnt pose")
	elseif imenu == 6
		sl_alias.StartThreatening(PlayerRef,"didnt masturbate")
	elseif imenu == 7
		sl_alias.StartThreatening(PlayerRef,"covering self")
	endif
EndFunction

Function DOMAllThreatenMenu()
	int imenu = ShowDOMDoThreatenMenu()
	if imenu == 0
		DOMAllOrderSlaves("Threaten","running away")
	elseif imenu == 1
		DOMAllOrderSlaves("Threaten","being angry")
	elseif imenu == 2
		DOMAllOrderSlaves("Threaten","being disrespectful")
	elseif imenu == 3
		DOMAllOrderSlaves("Threaten","crying")
	elseif imenu == 4
		DOMAllOrderSlaves("Threaten","didnt fight")
	elseif imenu == 5
		DOMAllOrderSlaves("Threaten","didnt pose")
	elseif imenu == 6
		DOMAllOrderSlaves("Threaten","didnt masturbate")
	elseif imenu == 7
		DOMAllOrderSlaves("Threaten","covering self")
	endif
EndFunction

Function DOMDoPromiseMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMDoPromiseMenu(akTarget)
	if imenu == 2
		sl_alias.StartPromising(PlayerRef,"rapture") ; humiliation
	elseif imenu == 4
		sl_alias.StartPromising(PlayerRef,"money") ; anger
	endif
	if sl_alias.mind.is_slave
		if imenu == 1
			sl_alias.StartPromising(PlayerRef,"pain") ; submission
		elseif imenu == 3
			sl_alias.StartPromising(PlayerRef,"to be sacrificed") ; fear
		elseif imenu == 5
			sl_alias.StartPromising(PlayerRef,"freedom") ; resignation
		elseif imenu == 6
			sl_alias.StartPromising(PlayerRef,"to be gentle") ; respect
		endif
	endif
EndFunction

Function DOMAllPromiseMenu()
	int imenu = ShowDOMDoPromiseMenu(None)
	if imenu == 1
		DOMAllOrderSlaves("Promise","pain") ; submission
	elseif imenu == 2
		DOMAllOrderSlaves("Promise","rapture") ; humiliation
	elseif imenu == 3
		DOMAllOrderSlaves("Promise","to be sacrificed") ; fear
	elseif imenu == 4
		DOMAllOrderSlaves("Promise","money") ; anger
	elseif imenu == 5
		DOMAllOrderSlaves("Promise","freedom") ; resignation
	elseif imenu == 6
		DOMAllOrderSlaves("Promise","to be gentle") ; respect
	endif
EndFunction

Int Function ShowDOMDoPromiseMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMSlavePromiseMessage.Show()+1
	endif
	if debugKeyMode
		HudNotification("Promise menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	if akTarget == None || isADOMSlave(akTarget)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Pain ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Sacrifice ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Freedom ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Be gentle ")

		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Pain ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Sacrifice ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Freedom ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Be gentle ")

		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	endif
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Rapture ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Money ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Rapture ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Money ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoComfortMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		DOMDoNPCPlayerHug(akTarget)
		return
	endif
	int imenu = ShowDOMDoComfortMenu(akTarget)
	if imenu == 0
		sl_alias.StartComfortingWith(PlayerRef,"care") ; anger/respect
	elseif imenu == 1
		sl_alias.StartComfortingWith(PlayerRef,"guilt") ; anger
	elseif imenu == 2
		sl_alias.StartComfortingWith(PlayerRef,"sex") ; humiliation
	elseif imenu == 3
		sl_alias.StartComfortingWith(PlayerRef,"rape") ; submission
	elseif imenu == 4
		sl_alias.StartComfortingWith(PlayerRef,"pain") ; fear
	elseif imenu == 5
		sl_alias.StartComfortingWith(PlayerRef,"threat") ; resignation
	elseif imenu == 6
		sl_alias.StartComfortingWith(PlayerRef,"insult") ; respect
	endif
EndFunction

Int Function ShowDOMDoComfortMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		if akTarget.IsInFaction(DOMPlayerSlaverFaction)
			return DOMSlaverComfortMessage.Show()
		else
			return DOMSlaveComfortMessage.Show()
		endif
	endif
	if debugKeyMode
		HudNotification("Comfort menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Care ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Care ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Guilt ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Guilt ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	if DOMSexlab.DOM_HasSexlab.GetValue() == 1 || DOMOstim.DOM_HasOstim.GetValue() == 1
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Sex ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Sex ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	endif
	
	if !akTarget.IsInFaction(DOMPlayerSlaverFaction)
		if DOMSexlab.DOM_HasSexlab.GetValue() == 1 || DOMOstim.DOM_HasOstim.GetValue() == 1
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Rape ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Rape ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
		endif
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Punish ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Threaten ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Insult ")

		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Punish ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Threaten ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Insult ")
	
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
	endif
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoMasturbateMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	if sl_alias.is_behaviour_masturbate
		sl_alias.MasturbateHarder(PlayerRef)
		return
	endif
	int imenu = ShowDOMMasturbateMenu()
	if imenu == 0
		sl_alias.EnterMasturbateStanding(PlayerRef)
	elseif imenu == 1
		sl_alias.EnterMasturbateKneeling(PlayerRef)
	elseif imenu == 2
		sl_alias.EnterMasturbateLaying(PlayerRef)
	endif
EndFunction

Function DOMDoInspectMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	int imenu = ShowDOMInspectMenu()
	if imenu == 0
		DOMDoGrab(akTarget,"Front")
	elseif imenu == 1
		DOMDoGrab(akTarget,"Back")
	elseif imenu == 2
		DOMDoGrab(akTarget,"Floor")
	elseif imenu == 5 || imenu == 3
		DOMDoDisplay(akTarget)
	endif
EndFunction

Function DOMDoFlatterMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	int imenu = ShowDOMFlatterMenu()
	if sl_alias == None
		if imenu == 0
			DOMDoFlatter(akTarget,"sexy") ; anger/submission
		elseif imenu == 1
			DOMDoFlatter(akTarget,"dirty") ; anher/humiliation
		elseif imenu == 6 || imenu == 2
			DOMDoFlatter(akTarget,"praise") ; anger/resignation
		elseif imenu == 7 || imenu == 3
			DOMDoFlatter(akTarget,"romance") ; anger/respect
		endif
		return
	endif
	if imenu == 0
		sl_alias.StartFlatteringWith(PlayerRef,"sexy") ; anger/submission
	elseif imenu == 1
		sl_alias.StartFlatteringWith(PlayerRef,"dirty") ; anher/humiliation
	elseif imenu == 6 || imenu == 2
		sl_alias.StartFlatteringWith(PlayerRef,"praise") ; anger/resignation
	elseif imenu == 7 || imenu == 3
		sl_alias.StartFlatteringWith(PlayerRef,"romance") ; anger/respect
	endif
EndFunction

Int Function ShowDOMFlatterMenu()
	if !wheelIsDefaultMenu
		return DOMSlaveFlatterMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Flatter menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Sexy talk ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Dirty talk ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Friendly talk ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Romance ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Sexy talk ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Dirty talk ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Friendly talk ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Romance ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)


	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoInsultMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	int imenu = ShowDOMInsultMenu()
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		if imenu == 1
			DOMDoInsult(akTarget,"dominating") ; submission
		elseif imenu == 2
			DOMDoInsult(akTarget,"useless")    ; fear
		elseif imenu == 3
			DOMDoInsult(akTarget,"degrading")  ; humiliation
		elseif imenu == 4
			DOMDoInsult(akTarget,"demeaning")  ; anger
		elseif imenu == 5
			DOMDoInsult(akTarget,"disgrace")   ; resignation
		elseif imenu == 6
			DOMDoInsult(akTarget,"worthless")  ; respect
		endif
		return
	endif
	if imenu == 1
		sl_alias.StartInsultingWith(PlayerRef,"dominating") ; submission
	elseif imenu == 2
		sl_alias.StartInsultingWith(PlayerRef,"useless")    ; fear
	elseif imenu == 3
		sl_alias.StartInsultingWith(PlayerRef,"degrading")  ; humiliation
	elseif imenu == 4
		sl_alias.StartInsultingWith(PlayerRef,"demeaning")  ; anger
	elseif imenu == 5
		sl_alias.StartInsultingWith(PlayerRef,"disgrace")   ; resignation
	elseif imenu == 6
		sl_alias.StartInsultingWith(PlayerRef,"worthless")  ; respect
	endif
EndFunction

Int Function ShowDOMInsultMenu()
	if !wheelIsDefaultMenu
		return DOMSlaveInsultMessage.Show()+1
	endif
	if debugKeyMode
		HudNotification("Insult menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "dominate ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Useless ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Degrade ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Demean ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Disgrace ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Worthless ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "dominate ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Useless ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Degrade ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Demean ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Disgrace ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Worthless ")
	
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)


	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMBathingMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMSlaveBathingMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Upkeeping menu")
	endif

	string txt_shower = "Bathing "
	bool is_wash_possible = true
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if DOMBath.isInWaterfall(akTarget)|| DOMBath.isInShower(akTarget)
			txt_shower = "Shower "
		elseif PO3_SKSEFunctions.IsActorInWater(akTarget) || PO3_SKSEFunctions.IsActorUnderwater(akTarget)
			txt_shower = "Bath "
		elseif sl_alias != None && sl_alias.wet_level > 0.0
			txt_shower = "Dry self "
		else
			txt_shower = "Can not wash "
			is_wash_possible = false
		endif
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	if isADOMSlave(akTarget)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = txt_shower)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = txt_shower)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = is_wash_possible)
	endif
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Bath me ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value =  "Bath me ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMUpkeepingMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMSlaveUpkeepingMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Upkeeping menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	if isADOMSlave(akTarget)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Bathing ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Bathing ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)

		if akTarget.IsInFaction(DOMActorHasTatsMarks)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Unmark ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value =  "Remove mark ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Mark slave ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value =  "Status ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		endif
		if akTarget.IsInFaction(DOMActorHasTatsBrand)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Unbrand ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value =  "Remove brand ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Brand slave ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value =  "Brand ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
		endif
	endif
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Look at me ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value =  "Look at me ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Turn around ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value =  "Turn around ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Come here ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value =  "Come here ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Follow actor ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value =  "Follow actor ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Drink this ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value =  "Drink this ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoUpkeeping(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int imenu = ShowDOMUpkeepingMenu(akTarget)
	if imenu == 0
		imenu = ShowDOMBathingMenu(akTarget)
		if imenu == 0
			if isADOMSlave(akTarget)
				sl_alias.DoShower(PlayerRef)
			else
				DOMDoNPCShower(akTarget)
			endif
		else
			if isADOMSlave(akTarget)
				sl_alias.DoBathMe(PlayerRef)
			else
				DOMDoNPCBathMe(akTarget)
			endif
		endif
	elseif imenu == 1
		sl_alias.Interact_LookAtMe(PlayerRef)
	elseif imenu == 2
		sl_alias.Interact_TurnAround(PlayerRef)
	elseif imenu == 3
		sl_alias.Interact_ComeHere(PlayerRef)
	elseif imenu == 4
		DOMDoFollowTarget(sl_alias)
	elseif imenu == 5
		DOMDoDrinkThis(akTarget)
	elseif  isADOMSlave(akTarget)
		if imenu == 6
			if sl_alias.HasMark()
				sl_alias.Interact_Unmark()
			else
				sl_alias.Interact_Mark(PlayerRef)
			endif
		elseif imenu == 7
			if sl_alias.HasBrand()
				sl_alias.Interact_Unbrand()
			else
				sl_alias.Interact_Brand(PlayerRef)
			endif
		endif
	endif
EndFunction

Int Function ShowDOMDrinkMenu()
	if !wheelIsDefaultMenu
		return DOMSlavePotionMessage.Show()+3
	endif
	if debugKeyMode
		HudNotification("Drink this menu")
	endif

	Actor akRef = PlayerRef
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Skooma ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value =  "Skooma ")
	int nb = akRef.getItemCount(DOMCore.Skooma) + akRef.getItemCount(DOMCore.WindhelmDoubleDistilledSkooma) + akRef.getItemCount(DOMCore.FreeformAngasMillKordirsSkooma) + akRef.getItemCount(DOMCore.TGTQ02BalmoraBlue) + akRef.getItemCount(DOMCore.DLC1RedwaterDenSkooma) + akRef.getItemCount(DOMCore.dunSleepingTreeCampSap)
	if nb > 0
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Drink alcohol ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value =  "Drink alcohol ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Love Potion ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value =  "Love Potion ")
	nb = akRef.getItemCount(DOMCore.DOMLovePotion)
	if nb > 0
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	endif
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Lust Potion ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value =  "Lust Potion ")
	nb = akRef.getItemCount(DOMCore.DOMLustPotion)
	if nb > 0
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
	endif
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Lash Potion ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value =  "Lash Potion ")
	nb = akRef.getItemCount(DOMCore.DOMPainPotion)
	if nb > 0
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = false)
	endif
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Mind-breaking Potion ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value =  "Mind Potion ")
	nb = akRef.getItemCount(DOMCore.DOMBrokenPotion)
	if nb > 0
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = false)
	endif
	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoDrinkThis(Actor akTarget)
	if akTarget == None
		return
	endif
	int imenu = ShowDOMDrinkMenu()
	if imenu == 2
		DOMDoDrink(akTarget,"narcotic")
	elseif imenu == 3
		DOMDoDrink(akTarget,"alcohol")
	elseif imenu == 4
		DOMDoDrink(akTarget,"love")
	elseif imenu == 5
		DOMDoDrink(akTarget,"lust")
	elseif imenu == 6
		DOMDoDrink(akTarget,"lash")
	elseif imenu == 7
		DOMDoDrink(akTarget,"mind")
	endif
EndFunction

Function DOMDoClothesMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	if sl_alias.equip_inventory_busy
		HudNotification(sl_alias.GetName()+"'s inventory is busy")
		return
	endif
	DOM_Mind sl_mind = sl_alias.mind
	int imenu = ShowDOMClothesMenu(akTarget)
	if imenu == 2
		sl_alias.Interact_Strip(PlayerRef)
	elseif imenu == 3
		sl_alias.Interact_StripAll(PlayerRef)
	elseif imenu == 4
		DOMDoBeNaked(akTarget)
	elseif imenu == 5
		sl_alias.was_inventory_changed = true
		sl_alias.SendOrderEquipInventory(false) ;  no anim
	elseif imenu == 6 && sl_mind != None
		if sl_mind.should_hold_weapons
			sl_alias.HoldNoWeapons()
		else
			sl_alias.HoldWeapons(PlayerRef)
		endif
	elseif imenu == 7 && sl_mind != None
		if sl_mind.should_wear_armor
			sl_alias.WearNoArmor()
		else
			sl_alias.WearArmor(PlayerRef)
		endif
	endif
	if sl_mind.is_slave
		if imenu == 0
			sl_alias.Interact_Undress(PlayerRef)
		elseif imenu == 1
			sl_alias.Interact_UndressAll(PlayerRef)
		endif
	endif
EndFunction

Function DOMAllClothesMenu()
	int imenu = ShowDOMAllClothesMenu()
	LogTrace("DOMAllClothesMenu imenu="+imenu)
	if imenu == 0
		LogTrace("DOMAllClothesMenu BeNaked")
		DOMAllOrderSlaves("BeNaked")
	elseif imenu == 1
		DOMAllOrderSlaves("DontBeNaked")
	elseif imenu == 2
		DOMAllOrderSlaves("Strip")
	elseif imenu == 3
		DOMAllOrderSlaves("StripAll")
	elseif imenu == 5
		DOMAllOrderSlavesAndSlavers("EquipInventoryForced",flag=false) ; do not animate
	elseif imenu == 6
		DOMAllOrderSlaves("StripWeapons")
	elseif imenu == 7
		DOMAllOrderSlaves("StripArmor")
	endif
EndFunction

Function DOMDoKissMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	int imenu = ShowDOMKissMenu(true) ; allow vampire kiss
	if imenu == 0
		DOMDoKiss(akTarget,"Short")
	elseif imenu == 1
		DOMDoKiss(akTarget,"Love")
	elseif imenu == 2
		DOMDoKiss(akTarget,"Long")
	elseif imenu == 3
		DOMDoKiss(akTarget,"Forced")
	elseif imenu == 4
		DOMDoKiss(akTarget,"Dominant")
	elseif imenu == 5
		DOMDoKiss(akTarget,"Side")
	elseif imenu == 6
		DOMDoVampireKiss(akTarget)
	endif
EndFunction

Function DOMRansomManage(Actor akTarget)
	if akTarget == None
		HudNotification("No family members to ransom")
		return
	endif
	if DOM02.family_tmp.GetRef() != akTarget
		HudNotification("No family members to ransom for "+akTarget.GetDisplayName())
		return
	endif
	
	DOMCore.SlaveFamilyRansom(akTarget)
EndFunction

Function DOMDoDismiss(Actor akTarget)
	if akTarget == None
		HudNotification("Noone to dismiss")
		return
	endif

	ReferenceAlias slaver_alias = DOMCore.GetSlaver(akTarget)
	If slaver_alias != None
		DOMCore.ReleaseSlaverAlias(slaver_alias)
	endif
EndFunction

Function DOMDoRecruit(Actor akTarget)
	if akTarget == None
		HudNotification("Noone to recruit")
		return
	endif

	If akTarget.IsInFaction(PlayerFollowerFaction) || akTarget.GetFactionRank(CurrentFollowerFaction) >= 0
		HudNotification("You can not recruit a follower")
		LogTrace(akTarget.getDisplayName()+" you can not recruit a follower")
		return
	endif
	
	ReferenceAlias slave_alias = DOMCore.GetSlave(akTarget)
	If slave_alias != None
		if DOMSlaveRecruitMessage.Show() == 0
			HudNotification("Freeing and recruiting slave "+akTarget.GetDisplayName()+" as slaver")
			DOMCore.ReleaseAlias(slave_alias)
			DOM01.AddActor(akTarget,false)
			Debug.MessageBox(akTarget.getDisplayName()+" was recruited for free")
		endif
	else
		int amount = DOMCore.GetFeeForRecruiting(akTarget)
		if amount == 0 
			Debug.MessageBox(akTarget.getDisplayName()+" will join you for free")
		elseif amount > 0
			Debug.MessageBox(akTarget.getDisplayName()+" will join you for "+amount+" gold")
		else
			return
		endif
		if DOMNPCRecruitMessage.Show(amount as float) == 0
			HudNotification("Recruiting "+akTarget.GetDisplayName()+" as slaver")
			if amount == 0 
				DOM01.Recruit(akTarget)
			elseif amount > 0 
				if (PlayerRef.GetGoldAmount() >= amount)
					PlayerRef.RemoveItem(Gold001, amount)
					DOM01.Recruit(akTarget)
					HudNotification(akTarget.getDisplayName()+" was recruited for "+amount+" gold")
					if amount > 100
						amount = amount / 10
					elseif amount > 10
						amount = 10
					endif
					akTarget.AddItem(Gold001, amount)
				else
					HudNotification("You don't have enough gold to pay "+akTarget.getDisplayName())
				endif
			else
				HudNotification(akTarget.getDisplayName()+" does not feel like it anymore")
			endif
		endif
	endif
EndFunction

Function DOMDoNPCTraitsVerbose(Actor akTarget)
	if akTarget != None
		string msg
		if debugKeyMode
			HudNotification("Get personality traits for "+akTarget.getDisplayName())
		endif
		if isADOMSlave(aktarget)
			msg = DOMCore.DOMTraitsVerboseMessage(akTarget)
		else
			msg = DOMCore.NPCTraitsVerboseMessage(akTarget)
		endif
		SendMessage(msg)
	endif
EndFunction

Function DOMDoNPCTraits(Actor akTarget)
	if akTarget != None
		string msg
		if debugKeyMode
			HudNotification("Get personality values for "+akTarget.getDisplayName())
		endif
		if isADOMSlave(aktarget)
			msg = DOMCore.DOMTraitsMessage(akTarget)
		else
			msg = DOMCore.NPCTraitsMessage(akTarget)
		endif
		SendMessage(msg)
	endif
EndFunction

Function DOMDoNPCFeelingsVerbose(Actor akTarget)
	if akTarget != None
		string msg
		if debugKeyMode
			HudNotification("Get feelings for "+akTarget.getDisplayName())
		endif
		if isADOMSlave(aktarget)
			msg = DOMCore.DOMFeelingsVerboseMessage(akTarget)
		else
			msg = DOMCore.NPCFeelingsVerboseMessage(akTarget)
		endif
		SendMessage(msg)
	endif
EndFunction

Function DOMDoNPCFeelings(Actor akTarget)
	if akTarget != None
		string msg
		if debugKeyMode
			HudNotification("Get feelings values for "+akTarget.getDisplayName())
		endif
		if isADOMSlave(aktarget)
			msg = DOMCore.DOMFeelingsMessage(akTarget)
		else
			msg = DOMCore.NPCFeelingsMessage(akTarget)
		endif
		SendMessage(msg)
	endif
EndFunction

Function DOMDoStatus(Actor akTarget)
	if akTarget != None
		if debugKeyMode
			HudNotification("Get training status for "+akTarget.getDisplayName())
		endif
		SendMessage(DOMCore.NPCStatsMessage(akTarget));
	endif
EndFunction

Function DOMDOMood(Actor akTarget)
	if akTarget != None
		if debugKeyMode
			HudNotification("Get mood status for "+akTarget.getDisplayName())
		endif
		SendMessage(DOMCore.NPCMoodMessage(akTarget));
	endif
EndFunction

Function DOMDOMoveBone(Actor akTarget)
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if sl_alias != None
			if debugKeyMode
				HudNotification("Move bone for "+sl_alias.getname())
			endif
			sl_alias.MoveBone("R Breast03", 0.0)
		endif
	endif
EndFunction

Function DOMDOMorph(Actor akTarget)
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if sl_alias != None
			if debugKeyMode
				HudNotification("Move bone for "+sl_alias.getname())
			endif
			sl_alias.MoveBone("R Breast03", 1.0) ; sl_alias.AddBodyMorph("BreastGravity2", 1.8)
		endif
	endif
EndFunction

Function DOMDoOpenInventory(Actor akTarget)
	if akTarget != None
		if isADOMActor(aktarget)
			if debugKeyMode
				HudNotification("Open inventory for "+akTarget.getDisplayName())
			endif
			DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
			if sl_alias == None
				aktarget.OpenInventory(true)
			else
				sl_alias.OpenInventory()
			endif
		elseif DOMPAH.isPAH(akTarget)
			DOMPAH.DoOpenInventory(akTarget)
		elseif akTarget.IsInFaction(PlayerFollowerFaction)
			akTarget.OpenInventory(true)
		elseif akTarget.GetRelationshipRank(PlayerRef) >= 4
			akTarget.OpenInventory(true)
		elseif akTarget.IsUnconscious()
			akTarget.OpenInventory(true)
		elseif DOMCore.isAPlayerSlave(akTarget)
			akTarget.OpenInventory(true)
		endif
	endif
EndFunction

Function DOMDoAllowOrgasm(Actor akTarget)
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Allow/Forbid orgasm for "+akTarget.GetDisplayName())
		endif
		if sl_alias != None
			DOM_Mind sl_mind = sl_alias.mind
			if sl_mind != None
				sl_mind.SetAllowOrgasm()
			endif
		endif
	endif
EndFunction

Function DOMDoSetOrgasmStatus(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	if !akTarget.IsInFaction(DOMShouldBeNoOrgasm)
		sl_alias.SetShouldBeNoOrgasm(PlayerRef)
		if debugKeyMode
			HudNotification("Yes orgasm for "+sl_alias.getName())
		endif
	else
		sl_alias.UnSetShouldBeNoOrgasm(PlayerRef)
		if debugKeyMode
			HudNotification("No orgasm for "+sl_alias.getName())
		endif
	endif
EndFunction

Function DOMDoPraise(Actor akTarget)
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Praise "+akTarget.GetDisplayName())
		endif
		if sl_alias != None
			sl_alias.StartPraising(PlayerRef)
		endif
	endif
EndFunction

Function DOMDoScold(Actor akTarget)
	if akTarget != None
		if debugKeyMode
			HudNotification("Scold for "+akTarget.GetDisplayName())
		endif
		if isADOMActor(akTarget)
			DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
			if sl_alias != None
				sl_alias.StartScolding(PlayerRef)
			endif
		elseif DOMPAH.isPAH(akTarget)
			DOMPAH.DoScold(akTarget)
		endif
	endif
EndFunction

Function DOMSetExample(Actor akTarget)
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Set example with "+akTarget.GetDisplayName())
		endif
		if sl_alias != None
			sl_alias.Interact_Punish(PlayerRef,"","public humiliation")
		endif
	endif
EndFunction

Function DOMDoFavor(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if DOMSexlab.IsAnimating(akTarget)
		return
	endif
	if akTarget != None
		if debugKeyMode
			HudNotification("Order do favor to "+akTarget.GetDisplayName())
		endif
		if isADOMActor(akTarget)
			DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
			if sl_alias != None
				sl_alias.DoFavor(PlayerRef)
			endif
		elseif DOMPAH.isPAH(akTarget)
			DOMPAH.DoFavor(akTarget)
		endif
	endif
EndFunction

Actor previous_target = None
Function DOMDoAction(Actor akTarget)
	if DOMCore.ActionGroup
		DOMDoActionGroup(DOMCore.ActionName,DOMCore.ActionType,DOMCore.ActionFlag)
		return
	endif
	if akTarget == None
		akTarget = previous_target
		if akTarget == None
			return
		endif
		if !akTarget.Is3DLoaded()
			return
		endif
	else
		previous_target = akTarget
	endif
	DOMDoActionActor(akTarget, DOMCore.ActionName,DOMCore.ActionType,DOMCore.ActionFlag)
EndFunction

Function DOMDoActionActor(Actor akTarget, string the_event, string type, bool the_flag)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	LogTrace("DOMDoActionActor "+the_event+" "+type)
	if akTarget != None
		LogTrace("DOMDoActionActor "+the_event+" "+type+" "+akTarget.GetDisplayName())
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order "+the_event+" "+type+" to "+akTarget.GetDisplayName())
		endif
		if sl_alias != None
			LogTrace("DOMDoActionActor "+the_event+" "+type+" "+sl_alias.GetName())
			sl_alias.DoOrder(PlayerRef,the_event,type,the_flag)
			return
		endif
	endif
	LogTrace("DOMDoActionActor "+the_event+" "+type+" to group")
	DOMAllOrderSlaves(the_event, type, the_flag)
EndFunction

Function DOMDoActionGroup(string the_event, string type, bool the_flag)
	DOMAllOrderSlaves(the_event, type, the_flag)
EndFunction

Function DOMDoOpenDiary(Actor akTarget)
	if akTarget == None
		DOMCore. DOMOpenPlayerDiary()
		return
	endif
	DOMCore.DOMOpenDiary(akTarget)
EndFunction

Function DOMDoTestPose(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Test pose on "+akTarget.GetDisplayName())
		endif
		if sl_alias != None
			sl_alias.DoTest(PlayerRef)
		endif
	endif
EndFunction

Function SpecialReset(Actor akRef)
	akRef.Disable()
	akRef.Enable()
	akRef.SetAlpha(1.0)
	CalmActorFast(akRef)
	QueueNiNodeUpdate(akRef)
	akRef.AllowPCDialogue(true)
	akRef.AllowBleedoutDialogue(true)
	if akRef.IsInFaction(DOMCore.DOMActionFleeing)
		akRef.RemoveFromFaction(DOMCore.DOMActionFleeing)
	endif
	if akRef.IsInFaction(DOMCore.DOMDrunkLevel)
		akRef.RemoveFromFaction(DOMCore.DOMDrunkLevel)
	endif
	akRef.PlayIdle(DOMCore.IdleDrunkStop)
	Debug.SendAnimationEvent(akRef,"IdleForceDefaultState")	
EndFunction

Function DOMDoFixMe(Actor akTarget)
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if sl_alias != None
			sl_alias.SpecialReset()
		else
			SpecialReset(akTarget)	
		endif
	endif
EndFunction

Function DOMDoRipOff(Actor akTarget)
	if akTarget != None
		if debugKeyMode
			HudNotification("Ripping-off clothes of "+akTarget.GetDisplayName())
		endif
		if isADOMActor(akTarget)
			DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
			if sl_alias != None
				sl_alias.Interact_Undress(PlayerRef)
			endif
		elseif DOMPAH.isPAH(akTarget)
			DOMPAH.DoStrip(akTarget)
		else
			DOMDoNPCUnDress(akTarget)
		endif
	endif
EndFunction

Function DOMDoStrip(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		if debugKeyMode
			HudNotification("Order strip to "+akTarget.GetDisplayName())
		endif
		if isADOMActor(akTarget)
			DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
			if sl_alias != None
				sl_alias.Interact_Strip(PlayerRef)
			endif
		elseif DOMPAH.isPAH(akTarget)
			DOMPAH.DoStrip(akTarget)
		endif
	endif
EndFunction

Function DOMDoStripAll(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order strip to "+akTarget.GetDisplayName())
		endif
		if sl_alias != None
			sl_alias.Interact_StripAll(PlayerRef)
		endif
	endif
EndFunction

Function DOMDoBeNaked(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	if !sl_alias.mind.should_be_naked
		sl_alias.SetShouldBeNaked(PlayerRef)
		if debugKeyMode
			HudNotification("Be naked "+sl_alias.getName())
		endif
	else
		sl_alias.UnsetShouldBeNaked(PlayerRef)
		if debugKeyMode
			HudNotification("Don't be naked "+sl_alias.getName())
		endif
	endif
EndFunction

Function DOMDoBeSilent(Actor akTarget)
	if akTarget == None
		return
	endif
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	DOM_Mind sl_mind = sl_alias.mind
	if sl_mind == None
		return
	endif
	if !sl_mind.should_be_silent
		sl_mind.SetShouldBeSilent()
		if debugKeyMode
			HudNotification("Be silent "+sl_alias.getName())
		endif
	else
		sl_mind.UnsetShouldBeSilent()
		if debugKeyMode
			HudNotification("Don't be silent "+sl_alias.getName())
		endif
	endif
EndFunction

Function DOMDoSalute(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to salute")
		endif
		if sl_alias != None
			sl_alias.Interact_StartSalute(PlayerRef,DOMCore.salutePose)
			Wait(4.0)
			sl_alias.Interact_EndSalute(DOMCore.salutePose)
		endif
	endif
EndFunction

Function DOMDoKneel(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to kneel")
		endif
		if sl_alias != None
			sl_alias.Interact_StartSalute(PlayerRef,DOMCore.kneelPose)
			Wait(4.0)
			sl_alias.Interact_EndSalute(DOMCore.kneelPose)
		endif
	endif
EndFunction

Function DOMDoAttention(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to be on attention")
		endif
		if sl_alias != None
			sl_alias.Interact_StartSalute(PlayerRef,DOMCore.attentionPose)
			Wait(4.0)
			sl_alias.Interact_EndSalute(DOMCore.attentionPose)
		endif
	endif
EndFunction

Int Function ShowDOMFollowingMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlaveFollowMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Following menu for "+akTarget.getDisplayName())
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	int rank = akTarget.GetFactionRank(DOMFollowMode)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Tight ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Tight ")
	if rank == 0
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	endif
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Close ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Close ")
	if rank == 1
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Near ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Near ")
	if rank == 2
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Long ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Long ")
	if rank == 3
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	endif

	if sl_alias != None
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Cuffing ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Cuffing ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

		if sl_alias.IsCuffed()
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Uncuff ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Uncuff ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		endif
		
		if sl_alias.mind.should_walk_on_four
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Walk Normal ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Walk Normal ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Walk on 4 ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Walk on 4 ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		endif
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMStandingMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlaveStandMessage.Show()+4
	endif
	if debugKeyMode
		HudNotification("Standing menu for "+akTarget.getDisplayName())
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	if sl_alias != None
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Cuffing ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Cuffing")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

		if sl_alias.IsCuffed()
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Uncuff ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Uncuff ")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
		endif

		if sl_alias.mind.should_walk_on_four
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Walk Normal ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Walk Normal")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Walk on 4 ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Walk on 4")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
		endif
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMWaitingMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlaveWaitMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Waiting distance menu for "+akTarget.getDisplayName())
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	int rank = akTarget.GetFactionRank(DOMWaitMode)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Tight ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Tight ")
	if rank == 0
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	endif
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Close ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Close ")
	if rank == 1
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Near ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Near ")
	if rank == 2
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Long ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Long ")
	if rank == 3
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Far ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Far ")
	if rank == 4
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	endif
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Very far ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Very far ")
	if rank == 5
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = false)
	else
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	endif

	if sl_alias != None
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Cuffing ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Cuffing")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

		if sl_alias.mind.should_walk_on_four
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Walk Normal ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Walk Normal")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
		else
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Walk on 4 ")
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Walk on 4")
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
		endif
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowJailMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlaveJailMessage.Show()
	endif
	if debugKeyMode
		if akTarget != None
			HudNotification("Jail menu for "+akTarget.getDisplayName())
		else
			HudNotification("Jail group menu")
		endif
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Standstill ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Standstill ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Wait around ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Wait around ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Tied-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Tied-up ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Cuffed back")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cuffed back")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Cuffed front")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Cuffed front")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Cuffed crossed")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Cuffed crossed")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Cuffed crossed")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Cuffed crossed")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMTravelMenu(Actor akTarget)		
	if !wheelIsDefaultMenu
		return DOMSlaveTravelMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Travel menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Wait ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Wait ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Punish ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Punish ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Guard ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Guard ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)

	if DOMSexlab.DOM_HasSexlab.GetValue() == 1 || DOMOstim.DOM_HasOstim.GetValue() == 1
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Sex ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Train ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	endif

	if DOMCore.DOMHSH != None
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Escort ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Escort ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	endif
	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoFollowMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMAllOrderMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif
	int imenu
	if isADOMActor(aktarget)
		imenu = ShowDOMFollowingMenu(akTarget)
		; Follow mode menu
		if imenu == 4
			DOMDoCuffsMenu(akTarget)
		elseif imenu == 5
			DOMDoUncuff(akTarget)
		elseif imenu == 6
			DOMDoWalkOnFour(akTarget)
		elseif imenu >= 0 && imenu < 4
			DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
			if sl_alias != None
				sl_alias.SetFollowMode(imenu)
			else
				akTarget.SetFactionRank(DOMFollowMode,imenu)
			endif
		endif
	elseif DOMPAH.isPAH(akTarget)
		DOMDoOrderMenu(akTarget)
	else
		DOMDoNPCMenu(aktarget)
	endif
EndFunction

Function DOMDoStandMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMAllOrderMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif
	int imenu
	if isADOMActor(aktarget)
		imenu = ShowDOMStandingMenu(akTarget)
		; Wait mode menu
		if imenu == 4
			DOMDoCuffsMenu(akTarget)
		elseif imenu == 5
			DOMDoUncuff(akTarget)
		elseif imenu == 6
			DOMDoWalkOnFour(akTarget)
		endif
	elseif DOMPAH.isPAH(akTarget)
		DOMDoOrderMenu(akTarget)
	else
		DOMDoNPCMenu(aktarget)
	endif
EndFunction


Function DOMDoWaitMenu(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMAllOrderMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif
	int imenu
	if isADOMActor(aktarget)
		imenu = ShowDOMWaitingMenu(akTarget)
		; Wait mode menu
		if imenu == 6
			DOMDoCuffsMenu(akTarget)
		elseif imenu == 7
			DOMDoWalkOnFour(akTarget)
		else
			DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
			if sl_alias != None
				sl_alias.SetWaitMode(imenu)
			else
				akTarget.SetFactionRank(DOMWaitMode,imenu)
			endif
		endif
	elseif DOMPAH.isPAH(akTarget)
		DOMDoOrderMenu(akTarget)
	else
		DOMDoNPCMenu(aktarget)
	endif
EndFunction

Function DOMDoWearCuffs(Actor akTarget, int itype)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to wear cuffs")
		endif
		
		if sl_alias != None
			if !sl_alias.HasCuffs(itype)
				sl_alias.EnterCuffed(PlayerRef,itype)
			else
				sl_alias.ExitCuffed(PlayerRef)
			endif
		endif
	endif
EndFunction

Function DOMDoUnCuff(Actor akTarget)
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to uncuff")
		endif
		
		if sl_alias != None
			if sl_alias.IsCuffed()
				sl_alias.ExitCuffed(PlayerRef)
			endif
		endif
	endif
EndFunction

Function DOMDoFollowTarget(DOM_Actor sl_alias) ; follow another slave
	if sl_alias == None
		return
	endif
	if DOMCore.IsFleeing(sl_alias.akRef)
		return
	endif
	if debugKeyMode
		HudNotification("Order "+sl_alias.GetName()+" to follow another slave")
	endif
	int imenu = ShowDOMSlaveSelectMenu(sl_alias)
	if imenu >= 0
		DOM_actor aSlave = selectArray[imenu]
		if aSlave != None
			sl_alias.EnterFollowTarget(aSlave.akRef)
		endif
	endif
EndFunction

string Function GetDOMTieupChoiceMenuNPC(Actor akTarget, int itype)
	if itype == 0 ; Tie-up kneeling
		return DOM_Anim.GetTieupKneelingNPC(akTarget)
	elseif itype == 1
		return DOM_Anim.GetTieupStandingNPC(akTarget)
	elseif itype == 2
		return DOM_Anim.GetTieupLayingNPC(akTarget)
	elseif itype == 3
		return DOM_Anim.GetTieupHogtiedNPC(akTarget)
	elseif itype == 4
		return DOM_Anim.GetTieupHangingNPC(akTarget) 
	elseif itype == 5
		return DOM_Anim.GetTieupHandsBehindBackNPC(akTarget)
	elseif itype == 6
		return DOM_Anim.GetTieupHeadDownNPC(akTarget)
	endif
	int i = RandomInt(1,4)
	if i == 1
		return DOM_Anim.GetTieupKneelingNPC(akTarget)
	elseif i == 2
		return DOM_Anim.GetTieupStandingNPC(akTarget)
	endif
	i = RandomInt(1,4)
	if i == 1
		return DOM_Anim.GetTieupLayingNPC(akTarget)
	elseif i == 2
		return DOM_Anim.GetTieupHogtiedNPC(akTarget)
	endif
	i = RandomInt(1,4)
	if i == 1
		return DOM_Anim.GetTieupHangingNPC(akTarget) 
	elseif i == 2
		return DOM_Anim.GetTieupHandsBehindBackNPC(akTarget)
	elseif i == 3
		return DOM_Anim.GetTieupHeadDownNPC(akTarget)
	endif
	return ""
EndFunction

string Function GetDOMTieupChoiceMenu(DOM_Actor akActor, int itype)
	if itype == 0 ; Tie-up kneeling
		return DOM_Anim.GetTieupKneeling(akActor)
	elseif itype == 1
		return DOM_Anim.GetTieupStanding(akActor)
	elseif itype == 2
		return DOM_Anim.GetTieupLaying(akActor)
	elseif itype == 3
		return DOM_Anim.GetTieupHogtied(akActor)
	elseif itype == 4
		return DOM_Anim.GetTieupHanging(akActor) 
	elseif itype == 5
		return DOM_Anim.GetTieupHandsBehindBack(akActor)
	elseif itype == 6
		return DOM_Anim.GetTieupHeadDown(akActor)
	endif
	int i = RandomInt(1,4)
	if i == 1
		return DOM_Anim.GetTieupKneeling(akActor)
	elseif i == 2
		return DOM_Anim.GetTieupStanding(akActor)
	endif
	i = RandomInt(1,4)
	if i == 1
		return DOM_Anim.GetTieupLaying(akActor)
	elseif i == 2
		return DOM_Anim.GetTieupHogtied(akActor)
	endif
	i = RandomInt(1,4)
	if i == 1
		return DOM_Anim.GetTieupHanging(akActor) 
	elseif i == 2
		return DOM_Anim.GetTieupHandsBehindBack(akActor)
	elseif i == 3
		return DOM_Anim.GetTieupHeadDown(akActor)
	endif
	return ""
EndFunction

Function DOMTieUp(Actor akTarget, bool do_gag, bool do_blindfold)		
	int itype = ShowDOMTieUpChoiceMenu()
	if itype < 0
		return
	endif
	DOMTiedUpByIndex(akTarget,itype,do_gag,do_blindfold)
EndFunction

Function DOMTiedUpByIndex(Actor akTarget, int itype, bool do_gag, bool do_blindfold)
	if akTarget == None
		return
	endif
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	string the_pose
	if akActor == None
		the_pose = GetDOMTieupChoiceMenuNPC(akTarget, itype)
	else
		the_pose = GetDOMTieupChoiceMenu(akActor, itype)
	endif

	LogTrace("DOMTiedUpByIndex "+akTarget.GetDisplayName()+" pose="+the_pose)
	if akActor != None
		if debugKeyMode
			HudNotification("Tying up "+akActor.getName()+" "+the_pose)
		endif
		akActor.EnterTieUp(PlayerRef, None, the_pose)
	else
		if debugKeyMode
			HudNotification("Tying up "+akTarget.getDisplayName()+" "+the_pose)
		endif
		DOMTieupActor(akTarget, PlayerRef, the_pose, false, false)
	endif
	if do_gag
		DOMDoEquipGag(akTarget)
	endif
	if do_blindfold
		DOMDoEquipBlindfold(akTarget)
	endif
EndFunction

Int Function ShowDOMTieUpChoiceMenu(bool do_random= false)
	if !wheelIsDefaultMenu
		return DOMSlaveRopesMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Tie-up menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Tie-up kneeling ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Tie-up standing ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Tie-up laying ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Hogtied ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Struggle rope ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Hands behind back ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Head down ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Tie-up kneeling ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Tie-up standing ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Tie-up laying ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Hogtied ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Struggle rope ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Hands behind back ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Head down ")

	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	
	if do_Random
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Randomize ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMChainsChoiceMenu(bool do_Random = false)
	if !wheelIsDefaultMenu
		return DOMSlaveChainsMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Tie-up with chains menu")
	endif

	string[] desc = DOM_Anim.GetChainDescriptions()
	if !desc
		LogTrace("ShowDOMChainsChoiceMenu no animation descriptions found")
		return -1
	endif
	int n = desc.length
	if n <= 0
		LogTrace("ShowDOMChainsChoiceMenu empty animation description")
		return -1
	endif
	
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i < n && i < 7
		string the_desc = desc[i]
		LogTrace("ShowDOMChainsChoiceMenu animation "+i+" is "+the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile

	if (!do_Random || !DOMCore.GroupChoiceRandom) && n > 7
		string the_desc = desc[7]
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Randomize ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMCageChoiceMenu(bool do_Random = false)
	if !wheelIsDefaultMenu
		return DOMSlaveCageMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Tie-up in cage menu")
	endif

	string[] desc = DOM_Anim.GetCagedDescriptions()
	if !desc
		LogTrace("ShowDOMCageChoiceMenu no animation descriptions found")
		return -1
	endif
	int n = desc.length
	if n <= 0
		LogTrace("ShowDOMCageChoiceMenu empty animation description")
		return -1
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i < n && i < 7
		string the_desc = desc[i]
		LogTrace("ShowDOMCageChoiceMenu animation "+i+" is "+the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile

	if (!do_Random || !DOMCore.GroupChoiceRandom) && n > 7
		string the_desc = desc[7]
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Randomize ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMPostChoiceMenu(bool do_Random = false)
	if !wheelIsDefaultMenu
		return DOMSlavePostMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Tie-up menu")
	endif

	string[] desc = DOM_Anim.GetPostDescriptions()
	if !desc
		LogTrace("ShowDOMPostChoiceMenu no animation descriptions found")
		return -1
	endif
	int n = desc.length
	if n <= 0
		LogTrace("ShowDOMPostChoiceMenu empty animation description")
		return -1
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i < n && i < 7
		string the_desc = desc[i]
		LogTrace("ShowDOMPostChoiceMenu animation "+i+" is "+the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile

	if (!do_Random || !DOMCore.GroupChoiceRandom) && n > 7
		string the_desc = desc[7]
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Randomize ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction


Int Function ShowDOMCrossChoiceMenu(bool do_Random = false)
	if !wheelIsDefaultMenu
		return DOMSlaveCrossMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Cross menu")
	endif

	string[] desc = DOM_Anim.GetCrossDescriptions()
	if !desc
		LogTrace("ShowDOMCrossChoiceMenu no animation descriptions found")
		return -1
	endif
	int n = desc.length
	if n <= 0
		LogTrace("ShowDOMCrossChoiceMenu empty animation description")
		return -1
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i < n && i < 7
		string the_desc = desc[i]
		LogTrace("ShowDOMCrossChoiceMenu animation "+i+" is "+the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile

	if (!do_Random || !DOMCore.GroupChoiceRandom) && n > 7
		string the_desc = desc[7]
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Randomize ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMPilloryChoiceMenu(bool do_Random = false)
	if !wheelIsDefaultMenu
		return DOMSlavePilloryMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Pillory menu")
	endif

	string[] desc = DOM_Anim.GetPilloryDescriptions()
	if !desc
		LogTrace("ShowDOMPilloryChoiceMenu no animation descriptions found")
		return -1
	endif
	int n = desc.length
	if n <= 0
		LogTrace("ShowDOMPilloryChoiceMenu empty animation description")
		return -1
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i < n && i < 7
		string the_desc = desc[i]
		LogTrace("ShowDOMPilloryChoiceMenu animation "+i+" is "+the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile

	if (!do_Random || !DOMCore.GroupChoiceRandom) && n > 7
		string the_desc = desc[7]
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Randomize ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMWheelChoiceMenu(bool do_Random = false)
	if !wheelIsDefaultMenu
		return DOMSlaveWheelMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Wheel menu")
	endif

	string[] desc = DOM_Anim.GetWheelDescriptions()
	if !desc
		LogTrace("ShowDOMWheelChoiceMenu no animation descriptions found")
		return -1
	endif
	int n = desc.length
	if n <= 0
		LogTrace("ShowDOMWheelChoiceMenu empty animation description")
		return -1
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	int i = 0
	while i < n && i < 7
		string the_desc = desc[i]
		LogTrace("ShowDOMWheelChoiceMenu animation "+i+" is "+the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		i += 1
	endwhile

	if (!do_Random || !DOMCore.GroupChoiceRandom) && n > 7
		string the_desc = desc[7]
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = the_desc)
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Randomize ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	return wheelMenu.OpenMenu()
EndFunction

Function DOMChains(Actor akTarget, bool do_gag, bool do_blindfold)
	int itype = ShowDOMChainsChoiceMenu()
	if itype < 0
		return
	endif
	DOMChainsByIndex(akTarget,itype,do_gag,do_blindfold)
EndFunction

Function DOMChainsByIndex(Actor akTarget, int itype, bool do_gag, bool do_blindfold)
	if akTarget == None
		return
	endif
	string the_pose = DOM_Anim.GetChainAnimationByIndex(itype)
	
	if debugKeyMode
		HudNotification("Tying up "+akTarget.getDisplayName()+" "+the_pose)
	endif
	LogTrace("DOMChainsByIndex "+akTarget.GetDisplayName()+" pose="+the_pose)
	
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.EnterChained(PlayerRef, None, the_pose)
	else
		DOMTieupActor(akTarget, PlayerRef, the_pose, false, false)
	endif
	if do_gag
		DOMDoEquipGag(akTarget)
	endif
	if do_blindfold
		DOMDoEquipBlindfold(akTarget)
	endif
EndFunction

bool Function GetDOMCageNeedsCuffs(int itype)
	if itype == 1
		return true ; Cage kneel
	elseif itype >= 3
		return true ; Cage tied
	endif
	return false
EndFunction

Function DOMPost(Actor akTarget, bool do_gag, bool do_blindfold)
	int itype = ShowDOMPostChoiceMenu()
	if itype < 0
		return
	endif
	DOMPostByIndex(akTarget, itype, do_gag, do_blindfold)
EndFunction

Function DOMPostByIndex(Actor akTarget, int itype, bool do_gag, bool do_blindfold)
	if akTarget == None
		return
	endif
	string the_pose = DOM_Anim.GetPostAnimationByIndex(itype)
	
	if debugKeyMode
		HudNotification("Tying to the post "+akTarget.getDisplayName()+" "+the_pose)
	endif
	LogTrace("DOMPostByIndex "+akTarget.GetDisplayName()+" pose="+the_pose)
	
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.EnterRestrained(PlayerRef, None, the_pose)
	else
		DOMTieupActor(akTarget, PlayerRef, the_pose, false, false)
	endif
	if do_gag
		DOMDoEquipGag(akTarget)
	endif
	if do_blindfold
		DOMDoEquipBlindfold(akTarget)
	endif
EndFunction

Function DOMCage(Actor akTarget, bool do_gag, bool do_blindfold)
	int itype = ShowDOMCageChoiceMenu()
	if itype < 0
		return
	endif
	DOMCageByIndex(akTarget, itype, do_gag, do_blindfold)
EndFunction

Function DOMCageByIndex(Actor akTarget, int itype, bool do_gag, bool do_blindfold)
	if akTarget == None
		return
	endif
	string the_pose = DOM_Anim.GetCagedAnimationByIndex(itype)
	
	if debugKeyMode
		HudNotification("Lock in cage "+akTarget.getDisplayName()+" "+the_pose)
	endif
	LogTrace("DOMCageByIndex "+akTarget.GetDisplayName()+" pose="+the_pose)
	
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	if akActor != None
		akActor.EnterRestrained(PlayerRef, None, the_pose)
	else
		DOMTieupActor(akTarget, PlayerRef, the_pose, false, false)
	endif
	if do_gag
		DOMDoEquipGag(akTarget)
	endif
	if do_blindfold
		DOMDoEquipBlindfold(akTarget)
	endif
EndFunction

Function DOMDoCleanTheMess(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to clean the mess")
		endif
		if sl_alias != None
			if sl_alias.behaviour != "clean_house"
				sl_alias.EnterSweep()
			else
				DOMDoWaitMenu(akTarget)
			endif
		else
			Debug.SendAnimationEvent(akTarget, DOM_Anim.GetBroomPoseNPC(akTarget))
			TrainFactionWithMod(akTarget,DOMCore.DOMTrainResignation,DOMModDiligent,5.0)
			TrainFactionWithMod(akTarget,DOMCore.DOMTrainHouse,DOMModDiligent,5.0)
		endif
	endif
EndFunction

Function DOMDoJail(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if debugKeyMode
			HudNotification("Order "+akTarget.GetDisplayName()+" to go to jail")
		endif
		if sl_alias != None
			int imenu = ShowJailMenu(akTarget)+1
			if imenu > 0 && imenu <= 6
				sl_alias.EnterJailTravel(imenu)
			endif
		endif
	endif
EndFunction

Function DOMDoFightForMe(Actor akTarget)
	if DOMCore.IsFleeing(akTarget)
		return
	endif
	if akTarget != None
		DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
		if sl_alias != None
			DOM_Mind sl_mind = sl_alias.mind
			if sl_mind == None
				return
			endif
			if !sl_mind.should_fight_for_player
				sl_mind.SetShouldFightForPlayer()
				if debugKeyMode
					HudNotification("Order "+sl_alias.getName()+" to fight for player")
				endif
			else
				sl_mind.UnsetShouldFightForPlayer()
				if debugKeyMode
					HudNotification("Order "+sl_alias.getName()+" to not fight for player")
				endif
			endif
		endif
	endif
EndFunction

Int Function ShowDOMAllTieUpMenu()
	if !wheelIsDefaultMenu
		return DOMGroupTieupMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Tie-up menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Chains ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Post ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Cage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Restrain ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Gag/Plug ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Cuffs ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Chains ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Post ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Restrain ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Gag/Plug ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Blindfold ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Cuffs ")

	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMAllRestrainMenu()
	if !wheelIsDefaultMenu
		return DOMGroupRestrainMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Restrain menu")
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Chains ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Post ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Cage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Cross ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Pillory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Wheel ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Go back ")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Tie-up ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Chains ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Post ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cage ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Cross ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Pillory ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Wheel ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Go back ")

	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)

	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMAllCuffsMenu()		
	if !wheelIsDefaultMenu
		return DOMGroupCuffsMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Cuffs menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Cuffs back")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Cuffs back")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Cuffs front")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Cuffs front")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Cuffs crossed")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Cuffs crossed")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Cuffs box tied")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cuffs boxtied")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Random ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Random ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Uncuff ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Uncuff ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Yoke ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Yoke")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Armbinder ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Armbinder ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMAllPlugsMenu()		
	if !wheelIsDefaultMenu
		return DOMGroupPlugsMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Cuffs menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Gag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Gag ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Ball gag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Ball gag")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Ring gag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Ring gag")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Log bit ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Log bit")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Vaginal plug")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Vaginal plug")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Anal plug")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Anal plug")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Remove gag ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Remove gag ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Remove plugs ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Remove plugs ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMAllBlindfoldMenu()		
	if !wheelIsDefaultMenu
		return DOMGroupBlindfoldMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Blindfold group menu")
	endif
	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
	
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Leather ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Blindfold ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "DD")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Blindfold ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Black")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Blindfold ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Cloth ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Hood ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Hood ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Hood ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "DB ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Hood ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Remove ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Remove ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Random ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Random ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	
	return wheelMenu.OpenMenu()
EndFunction

Function DOMAllTieUpMenu(bool do_gag, bool do_blindfold)
	string extraevent
	if do_gag && do_blindfold
		extraevent = "GagAndBlindfold"
	elseif do_gag 
		extraevent = "AndGag"
	elseif do_blindfold
		extraevent = "AndBlindfold"
	else
		extraevent = ""
	endif
	int ttype = ShowDOMAllTieUpMenu()
	if ttype < 0
		return
	endif

	if ttype == 0
		string the_event = "TieUp"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMTieUpChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = GetDOMTieupChoiceMenu(None, itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	elseif ttype == 1
		string the_event = "Chain"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMChainsChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetChainAnimationByIndex(itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	elseif ttype == 2
		string the_event = "Post"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMPostChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetPostAnimationByIndex(itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	elseif ttype == 3
		string the_event = "Cage"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMCageChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetCagedAnimationByIndex(itype)
				bool need_cuffs = GetDOMCageNeedsCuffs(itype)
				DOMAllOrderSlaves(the_event,the_pose,flag=need_cuffs)
			endif	
		endif
	elseif ttype == 4
		DOMAllRestrainMenu(do_gag,do_blindfold)
	elseif ttype == 5
		int itype = ShowDOMAllPlugsMenu()
		if itype < 4
			DOMAllOrderSlaves("AddGag",(itype+1))
		elseif itype == 4
			DOMAllOrderSlaves("AddPlugVaginal")
		elseif itype == 5
			DOMAllOrderSlaves("AddPlugAnal")
		elseif itype == 6
			DOMAllOrderSlaves("RemoveGag")
		elseif itype == 7
			DOMAllOrderSlaves("RemovePlug")
		endif
	elseif ttype == 6
		int itype = ShowDOMAllBlindfoldMenu()
		if itype < 6
			DOMAllOrderSlaves("AddBlindfold",(itype+1))
		elseif itype == 6
			DOMAllOrderSlaves("RemoveBlindfold")
		elseif itype == 7 ; random
			DOMAllOrderSlaves("AddBlindfold","random")
		endif
	elseif ttype == 7
		int itype = ShowDOMAllCuffsMenu()
		if itype == 0
			DOMAllOrderSlaves("AddCuffsBack")
		elseif itype == 1
			DOMAllOrderSlaves("AddCuffsFront")
		elseif itype == 2
			DOMAllOrderSlaves("AddCuffsCrossed")
		elseif itype == 3
			DOMAllOrderSlaves("AddCuffsBoxTied")
		elseif itype == 4
			DOMAllOrderSlaves("AddCuffs")
		elseif itype == 5
			DOMAllOrderSlaves("RemoveCuffs")
		elseif itype == 6
			DOMAllOrderSlaves("AddYoke")
		elseif itype == 7
			DOMAllOrderSlaves("AddArmbinder")
		endif
	endif
EndFunction

Function DOMAllRestrainMenu(bool do_gag, bool do_blindfold)
	string extraevent
	if do_gag && do_blindfold
		extraevent = "GagAndBlindfold"
	elseif do_gag 
		extraevent = "AndGag"
	elseif do_blindfold
		extraevent = "AndBlindfold"
	else
		extraevent = ""
	endif
	int ttype = ShowDOMAllRestrainMenu()
	if ttype < 0
		return
	endif

	if ttype == 0
		string the_event = "TieUp"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMTieUpChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = GetDOMTieupChoiceMenu(None, itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	elseif ttype == 1
		string the_event = "Chain"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMChainsChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetChainAnimationByIndex(itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	elseif ttype == 2
		string the_event = "Post"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMPostChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetPostAnimationByIndex(itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	elseif ttype == 3
		string the_event = "Cage"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMCageChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetCagedAnimationByIndex(itype)
				bool need_cuffs = GetDOMCageNeedsCuffs(itype)
				DOMAllOrderSlaves(the_event,the_pose,flag=need_cuffs)
			endif	
		endif
	elseif ttype == 4
		string the_event = "Cross"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMCrossChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetCrossAnimationByIndex(itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	elseif ttype == 5
		string the_event = "Pillory"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMPilloryChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetPilloryAnimationByIndex(itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	elseif ttype == 6
		string the_event = "Wheel"+extraevent
		if !DOMCore.GroupChoicePose
			DOMAllOrderSlaves(the_event)
		else
			int itype = ShowDOMWheelChoiceMenu(DOMCore.GroupChoiceRandom)
			if itype == 7 && DOMCore.GroupChoiceRandom
				DOMAllOrderSlaves(the_event)
			else
				string the_pose = DOM_Anim.GetWheelAnimationByIndex(itype)
				DOMAllOrderSlaves(the_event,the_pose)
			endif	
		endif
	else ; if ttype == 7
		DOMAllTieUpMenu(do_gag,do_blindfold)
	endif
EndFunction

Function DOMAllGagAndBlindfoldMenu()
	int imenu = ShowDoDOMMenuGagAndBlindfold()
	if imenu == 0
		DOMAllOrderSlaves("AddGag")
	elseif imenu == 1
		DOMAllOrderSlaves("AddBlindfold")
	elseif imenu == 2
		DOMAllOrderSlaves("AddGagAndBlindfold")
	elseif imenu == 4
		DOMAllOrderSlaves("RemoveGag")
	elseif imenu == 5
		DOMAllOrderSlaves("RemoveBlindfold")
	elseif imenu == 6
		DOMAllOrderSlaves("RemoveGagAndBlindfold")
	endif
EndFunction

Function DOMAllOrderDefaultSlaves(string the_order, string reason = "", bool flag=false, float distance = 3000.0, bool send_order)
	int n = DOM02.actorCounter
	if debugKeyMode
		if n==1
			HudNotification("Sending order "+the_order+" to one slave")
		else
			HudNotification("Sending order "+the_order+" to "+n+" slaves")
		endif
	endif
	int i = 0
	while i < n
		DOM_Actor sl_alias = DOM02.GetActorByIndex(i)
		if sl_alias != None && !sl_alias.akRef.IsInFaction(DOMActionFleeing)
			Actor akTarget = sl_alias.GetActorRef()
			if !DOMCore.isFleeing(akTarget) && DOMCore.IsWithPlayer(akTarget, distance) ; 3000.0 = 42.6 meters
				sl_alias.is_group_order = true
				DOMRegisterForOrder(sl_alias,PlayerRef,the_order,reason,flag)
			endif
		endif
		i += 1
	endwhile
	if send_order
		DOMCore.SendDOMOrder(PlayerRef,the_order,reason,flag)
	endif
EndFunction

Function DOMAllOrderDefaultBags(string the_order, string reason = "", bool flag=false, float distance = 3000.0, bool send_order)
	int n = DOM02.actorCounter
	if debugKeyMode
		if n==1
			HudNotification("Sending order "+the_order+" to one slave")
		else
			HudNotification("Sending order "+the_order+" to "+n+" slaves")
		endif
	endif
	int i = 0
	while i < n
		DOM_Actor sl_alias = DOM02.GetActorByIndex(i)
		if sl_alias != None && sl_alias.the_bag_iam_in != None
			ObjectReference akTarget = sl_alias.the_bag_iam_in
			if DOMCore.IsObjectWithPlayer(akTarget, distance) ; 3000.0 = 42.6 meters
				sl_alias.is_group_order = true
				DOMRegisterForOrder(sl_alias,PlayerRef,the_order,reason,flag)
			endif
		endif
		i += 1
	endwhile
	if send_order
		DOMCore.SendDOMOrder(PlayerRef,the_order,reason,flag)
	endif
EndFunction

Function DOMAllOrderBags(string the_order, string reason = "", bool flag=false, float distance = 3000.0, bool send_order = true)
	if !menuExtraSlaves
		DOMAllOrderDefaultBags(the_order, reason, flag, distance, true)
		return
	endif
	; Default manager
	DOMAllOrderDefaultBags(the_order, reason, flag, distance, false)

	; Extra managers
	int ndx = DOMCore.nDOMExtraMng
	int idx = 0
	while idx < ndx
		DOM_SlaveManager mng = DOMCore.DOMExtraMng[idx]
		if mng != None
			int n = mng.actorCounter
			int i = 0
			while i < n
				DOM_Actor sl_alias = mng.GetActorByIndex(i)
				if sl_alias != None && sl_alias.the_bag_iam_in != None
					ObjectReference akTarget = sl_alias.the_bag_iam_in
					if DOMCore.IsObjectWithPlayer(akTarget, distance) ; 3000.0 = 42.6 meters
						sl_alias.is_group_order = true
						DOMRegisterForOrder(sl_alias,PlayerRef,the_order,reason,flag)
					endif
				endif
				i += 1
			endwhile
		endif
		idx += 1
	endwhile
	if send_order
		DOMCore.SendDOMOrder(PlayerRef,the_order,reason,flag)
	endif
EndFunction

Function DOMAllOrderSlaves(string the_order, string reason = "", bool flag=false, float distance = 3000.0, bool send_order = true)
	if !menuExtraSlaves
		DOMAllOrderDefaultSlaves(the_order, reason, flag, distance, true)
		return
	endif
	; Default manager
	DOMAllOrderDefaultSlaves(the_order, reason, flag, distance, false)

	; Extra managers
	int ndx = DOMCore.nDOMExtraMng
	int idx = 0
	while idx < ndx
		DOM_SlaveManager mng = DOMCore.DOMExtraMng[idx]
		if mng != None
			int n = mng.actorCounter
			int i = 0
			while i < n
				DOM_Actor sl_alias = mng.GetActorByIndex(i)
				if sl_alias != None && !sl_alias.akRef.IsInFaction(DOMActionFleeing)
					Actor akTarget = sl_alias.GetActorRef()
					if !DOMCore.isFleeing(akTarget) && DOMCore.IsWithPlayer(akTarget, distance) ; 3000.0 = 42.6 meters
						sl_alias.is_group_order = true
						DOMRegisterForOrder(sl_alias,PlayerRef,the_order,reason,flag)
					endif
				endif
				i += 1
			endwhile
		endif
		idx += 1
	endwhile
	if send_order
		DOMCore.SendDOMOrder(PlayerRef,the_order,reason,flag)
	endif
EndFunction

Function DOMAllOrderSlavesAndSlavers(string the_order, string reason = "", bool flag=false, float distance = 10000.0)
	; Slavers
	if menuSlavers
		DOMAllOrderSlavers(the_order,reason,flag,distance,false)
	endif
	
	; Slaves
	DOMAllOrderSlaves(the_order,reason,flag,distance,false)
	
	; Send order
	DOMCore.SendDOMOrder(PlayerRef,the_order,reason,flag)
EndFunction

Function DOMRegisterForOrder(DOM_Actor sl_alias, Form sender, string the_order, string reason, bool flag)
	if the_order == "Scold"
		int np = sl_alias.mind.GetNumberOfNextPunishmentReasons()
		;LogTrace("Number of punishment reasons for "+sl_alias.GetName()+" n="+np)
		if np > 0 
			sl_alias.RegisterForOrder(sender,the_order,reason,flag)
		endif
	elseif the_order == "Praise"
		int np = sl_alias.mind.GetNumberOfNextPraiseReasons()
		;LogTrace("Number of praise reasons for "+sl_alias.GetName()+" n="+np)
		if np > 0 
			sl_alias.RegisterForOrder(sender,the_order,reason,flag)
		endif
	elseif the_order == "BeNaked"
		if !sl_alias.is_naked || !sl_alias.mind.should_be_naked
			sl_alias.RegisterForOrder(sender,the_order,reason,flag)
		endif
	elseif the_order == "DontBeNaked"
		if sl_alias.is_naked || sl_alias.mind.should_be_naked
			sl_alias.RegisterForOrder(sender,the_order,reason,flag)
		endif
	else
		sl_alias.RegisterForOrder(sender,the_order,reason,flag)
	endif
EndFunction

Function DOMAllOrderSlavers(string the_order, string reason = "", bool flag=false, float distance = 10000.0, bool send_order)
	int n = DOM01.actorCounter
	if n < 1
		return
	endif
	if debugKeyMode
		if n==1
			HudNotification("Sending order "+the_order+" to one slaver")
		else
			HudNotification("Sending order "+the_order+" to "+n+" slavers")
		endif
	endif
	int i = 0
	while i < n
		DOM_Actor sl_alias = DOM01.GetActorByIndex(i)
		if sl_alias != None && !sl_alias.akRef.IsInFaction(DOMActionFleeing)
			Actor akTarget = sl_alias.GetActorRef()
			if DOMCore.IsWithPlayer(akTarget, 10000.0) ; 10000.0 = 142 meters
				sl_alias.is_group_order = true
				DOMRegisterForOrder(sl_alias,PlayerRef,the_order,reason,flag)
			endif
		endif
		i += 1
	endwhile
	if send_order
		DOMCore.SendDOMOrder(PlayerRef,the_order,reason,flag)
	endif
EndFunction

; ### DOM Trainers

Function DOMDoTrainerManagementMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	int imenu
	if isADOMTrainer(akTarget)
		imenu = ShowDOMTrainerManagementMenu(akTarget)
		if imenu == 0
			DOMDoListTrainees(akTarget)
		elseif imenu == 1
			DOMDoSetCamp(akTarget)
		elseif imenu == 2
			DOMDoGoToCamp(akTarget)
		elseif imenu == 3
			DOMDoGuard(akTarget)
		elseif imenu == 4
			DOMDoGatherTrainees(akTarget)
		elseif imenu == 5
			DOMDoAddTraineeMenu(akTarget)
		elseif imenu == 6
			DOMDoUnloadTraineeMenu(akTarget)
		elseif imenu == 7
			DOMDoUnloadTrainees(akTarget)
		endif
	endif
EndFunction

Function DOMDoTrainerAbuseMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	if akTarget.GetFactionRank(DOMTraineeCount) <= 0
		return
	endif
	int imenu
	if isADOMTrainer(akTarget)
		imenu = ShowDOMTrainerAbuseMenu(akTarget)
		if imenu == 0
			DOMDoDisplayTrainees(akTarget)
		elseif imenu == 1
			DOMDoTieupTrainees(akTarget)
		elseif imenu == 2
			DOMDoChainTrainees(akTarget)
		elseif imenu == 3
			DOMDoRestrainTrainees(akTarget)
		elseif imenu == 4
			;DOMDoDanceTrainees(akTarget)
			DOMDoMasturbateTrainees(akTarget)
		elseif imenu == 5
			DOMDoPunishTrainees(akTarget)
		elseif imenu == 6
			DOMDoRapeTrainees(akTarget)
		elseif imenu == 7
			DOMDoOrgyTrainees(akTarget)
		endif
	endif
EndFunction

Int Function ShowDOMTrainerManagementMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMTrainerOrderMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Trainer menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	if akTarget.GetFactionRank(DOMTraineeCount) > 0
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "List trainees ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "List ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Gather trainees ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Gather ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Unload trainee ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Unload ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Unload all trainees ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Unload all ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Set base camp ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Base camp ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	if akTarget.IsInFaction(DOMCore.DOMActionTravel)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Go to base camp ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Go to base ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Travelling ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Travel mode ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)
	endif
	
	if akTarget.IsInFaction(DOMCore.DOMActionGuard)
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Guard here ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Guard ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	else
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Guarding ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Guard mode ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)
	endif

	if akTarget.GetFactionRank(DOMTraineeCount) <= 127
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Add trainee ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Add ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMTrainerAbuseMenu(Actor akTarget)
	if !wheelIsDefaultMenu
		return DOMTrainerAbuseMessage.Show()
	endif
	if debugKeyMode
		HudNotification("Trainer menu for "+akTarget.getDisplayName())
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 0, value = "Display trainees ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 0, value = "Display ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 0, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 1, value = "Tie-up trainees ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 1, value = "Tie-up ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 1, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 2, value = "Chain trainees ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 2, value = "Chain ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 2, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 3, value = "Restrain trainees ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 3, value = "Restrain ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 3, value = true)

	;wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Dance trainees ")
	;wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Dance ")
	;wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 4, value = "Masturbate trainees ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 4, value = "Masturbate ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 4, value = true)

	wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 5, value = "Punish trainees ")
	wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 5, value = "Punish ")
	wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 5, value = true)

	if DOMSexlab.DOM_HasSexlab.GetValue() == 1 || DOMOstim.DOM_HasOstim.GetValue() == 1
		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 6, value = "Rape trainees ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 6, value = "Rape ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 6, value = true)

		wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = 7, value = "Orgy ")
		wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = 7, value = "Orgy ")
		wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = 7, value = true)
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMTraineeSelectMenu(DOM_Actor akActor)
	if akActor == None
		return -1
	endif
	int n = akActor.GetTraineeCount()
	if n < 1
		return -1
	endif
	if !wheelIsDefaultMenu
		int i = 0
		while i < n && i < 8
			DOM_Actor aTrainee = akActor.GetTrainee(i)
			if aTrainee != None
				SlaveSelectTarget[i].ForceRefTo(aTrainee.akRef)
			else
				SlaveSelectTarget[i].Clear()
			endif
			i += 1
		endwhile
		while i < 8
			SlaveSelectTarget[i].Clear()
			i += 1
		endwhile
		return DOMSlaveSelectMessage.Show()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	int i = 0
	while i < n && i < 8
		DOM_Actor aTrainee = akActor.GetTrainee(i)
		if aTrainee != None
			string name = aTrainee.GetName()+" "
			wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = name)
			wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = name)
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
		endif
		i += 1
	endwhile
	return wheelMenu.OpenMenu()
EndFunction

DOM_Actor[] _selectArray
DOM_Actor[] Property selectArray
	DOM_Actor[] Function Get()
		if !_selectArray
			_selectArray = new DOM_Actor[8] ; 8 choices max per wheel menu
		endif
		return _selectArray
	EndFunction
EndProperty

bool Function IsAlreadySelected(DOM_Actor akActor)
	int n = selectArray.length
	int i = 0
	while i < n
		if akActor == selectArray[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

Int Function ShowDOMSlaveSelectMenu(DOM_Actor akActor)
	if akActor == None
		return -1
	endif
	int n = DOM02.actorCounter
	if n < 1
		return -1
	endif

	if !wheelIsDefaultMenu
		int i = 0
		int k = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave != akActor
				if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 750.0) ; 750.0 = 10 meters
					SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
		if k < 8
			i = 0
			while i < n && k < 8
				DOM_Actor aSlave = DOM02.GetActorByIndex(i)
				if aSlave != None && aSlave != akActor && !IsAlreadySelected(aSlave)
					if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 2000.0) ; 2000.0 = 28.4 meters
						SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
						selectArray[k] = aSlave
						k += 1
					endif
				endif
				i += 1
			endwhile
		endif
		if k < 1
			return -1
		endif	
		if k < 8
			while k < 8
				SlaveSelectTarget[k].Clear()
				selectArray[k] = None
				k += 1
			endwhile
		endif
		return DOMSlaveSelectMessage.Show()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	int i = 0
	int k = 0
	while i < n && k < 8
		DOM_Actor aSlave = DOM02.GetActorByIndex(i)
		if aSlave != None && aSlave != akActor
			if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 750.0) ; 750.0 = 10 meters
				string name = aSlave.GetName()+" "
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
				selectArray[k] = aSlave
				k += 1
			endif
		endif
		i += 1
	endwhile
	if k < 8
		i = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave != akActor && !IsAlreadySelected(aSlave)
				if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 2000.0) ; 2000.0 = 28.4 meters
					string name = aSlave.GetName()+" "
					wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
					wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
					wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
	endif
	if k < 1
		return -1
	endif
	if k < 8
		while k < 8
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = false)
			selectArray[k] = None
			k += 1
		endwhile
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMSlaveSelectMenu2(DOM_Actor akActor, DOM_Actor akOther)
	if akActor == None
		return -1
	endif
	int n = DOM02.actorCounter
	if n < 2
		return -1
	endif

	if !wheelIsDefaultMenu
		int i = 0
		int k = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave != akActor && aSlave != akOther
				if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 750.0) ; 750.0 = 10 meters
					SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
		if k < 8
			i = 0
			while i < n && k < 8
				DOM_Actor aSlave = DOM02.GetActorByIndex(i)
				if aSlave != None && aSlave != akActor && aSlave != akOther && !IsAlreadySelected(aSlave)
					if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 2000.0) ; 2000.0 = 28.4 meters
						SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
						selectArray[k] = aSlave
						k += 1
					endif
				endif
				i += 1
			endwhile
		endif
		if k < 1
			return -1
		endif
		if k < 8
			while k < 8
				SlaveSelectTarget[k].Clear()
				;selectArray[k] = None
				k += 1
			endwhile
		endif
		return DOMSlaveSelectMessage.Show()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	int i = 0
	int k = 0
	while i < n && k < 8
		DOM_Actor aSlave = DOM02.GetActorByIndex(i)
		if aSlave != None && aSlave != akActor && aSlave != akOther
			if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 750.0) ; 750.0 = 10 meters
				string name = aSlave.GetName()+" "
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
				selectArray[k] = aSlave
				k += 1
			endif
		endif
		i += 1
	endwhile
	if k < 8
		i = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave != akActor && aSlave != akOther && !IsAlreadySelected(aSlave)
				if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 2000.0) ; 2000.0 = 28.4 meters
					string name = aSlave.GetName()+" "
					wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
					wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
					wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
	endif
	if k < 1
		return -1
	endif
	if k < 8
		while k < 8
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = false)
			selectArray[k] = None
			k += 1
		endwhile
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMSlaveSelectMenu3(DOM_Actor akActor, DOM_Actor akOther1, DOM_Actor akOther2)
	if akActor == None
		return -1
	endif
	int n = DOM02.actorCounter
	if n < 3
		return -1
	endif

	if !wheelIsDefaultMenu
		int i = 0
		int k = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave != akActor && aSlave != akOther1 && aSlave != akOther2
				if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 750.0) ; 750.0 = 10 meters
					SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
		if k < 8
			i = 0
			while i < n && k < 8
				DOM_Actor aSlave = DOM02.GetActorByIndex(i)
				if aSlave != None && aSlave != akActor && aSlave != akOther1 && aSlave != akOther2 && !IsAlreadySelected(aSlave)
					if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 2000.0) ; 2000.0 = 28.4 meters
						SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
						selectArray[k] = aSlave
						k += 1
					endif
				endif
				i += 1
			endwhile
		endif
		if k < 1
			return -1
		endif
		if k < 8
			while k < 8
				SlaveSelectTarget[k].Clear()
				;selectArray[k] = None
				k += 1
			endwhile
		endif
		return DOMSlaveSelectMessage.Show()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	int i = 0
	int k = 0
	while i < n && k < 8
		DOM_Actor aSlave = DOM02.GetActorByIndex(i)
		if aSlave != None && aSlave != akActor && aSlave != akOther1 && aSlave != akOther2
			if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 750.0) ; 750.0 = 10 meters
				string name = aSlave.GetName()+" "
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
				selectArray[k] = aSlave
				k += 1
			endif
		endif
		i += 1
	endwhile
	if k < 8
		i = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave != akActor && aSlave != akOther1 && aSlave != akOther2 && !IsAlreadySelected(aSlave)
				if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 2000.0) ; 2000.0 = 28.4 meters
					string name = aSlave.GetName()+" "
					wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
					wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
					wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
	endif
	if k < 1
		return -1
	endif
	if k < 8
		while k < 8
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = false)
			selectArray[k] = None
			k += 1
		endwhile
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMNPCSlaveSelectMenu1(Actor akActor)
	if akActor == None
		return -1
	endif
	int n = DOM02.actorCounter
	if n < 1
		return -1
	endif

	if !wheelIsDefaultMenu
		int i = 0
		int k = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave.akRef != akActor
				LogTrace("ShowDOMNPCSlaveSelectMenu: Check "+aSlave.GetName())
				if IsTogetherWithFast(aSlave.akRef, akActor, 750.0) ; 750.0 = 10 meters
					SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
					selectArray[k] = aSlave
					LogTrace("ShowDOMNPCSlaveSelectMenu: Select1 pos="+k+" "+aSlave.GetName())
					k += 1
				endif
			endif
			i += 1
		endwhile
		if k < 8
			i = 0
			while i < n && k < 8
				DOM_Actor aSlave = DOM02.GetActorByIndex(i)
				if aSlave != None && aSlave.akRef != akActor && !IsAlreadySelected(aSlave)
					if IsTogetherWithFast(aSlave.akRef, akActor, 2000.0) ; 2000.0 = 28.4 meters
						SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
						selectArray[k] = aSlave
						LogTrace("ShowDOMNPCSlaveSelectMenu: Select2 pos="+k+" "+aSlave.GetName())
						k += 1
					endif
				endif
				i += 1
			endwhile
		endif
		if k < 1
			return -1
		endif
		if k < 8
			while k < 8
				SlaveSelectTarget[k].Clear()
				;selectArray[k] = None
				k += 1
			endwhile
		endif
		return DOMSlaveSelectMessage.Show()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	int i = 0
	int k = 0
	while i < n && k < 8
		DOM_Actor aSlave = DOM02.GetActorByIndex(i)
		if aSlave != None && aSlave.akRef != akActor
			if IsTogetherWithFast(aSlave.akRef, akActor, 750.0) ; 750.0 = 10 meters
				string name = aSlave.GetName()+" "
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
				selectArray[k] = aSlave
				k += 1
			endif
		endif
		i += 1
	endwhile
	if k < 8
		i = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave.akRef != akActor && !IsAlreadySelected(aSlave)
				if IsTogetherWithFast(aSlave.akRef, akActor, 2000.0) ; 2000.0 = 28.4 meters
					string name = aSlave.GetName()+" "
					wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
					wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
					wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
	endif
	if k < 1
		return -1
	endif
	if k < 8
		while k < 8
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = false)
			selectArray[k] = None
			k += 1
		endwhile
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMNPCSlaveSelectMenu2(Actor akTarget, DOM_Actor akActor)
	if akTarget == None
		return -1
	endif
	int n = DOM02.actorCounter
	if n < 2
		return -1
	endif

	if !wheelIsDefaultMenu
		int i = 0
		int k = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave.akRef != akTarget && aSlave != akActor
				if IsTogetherWithFast(aSlave.akRef, akTarget, 750.0) ; 750.0 = 10 meters
					SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
		if k < 8
			i = 0
			while i < n && k < 8
				DOM_Actor aSlave = DOM02.GetActorByIndex(i)
				if aSlave != None && aSlave.akRef != akTarget && aSlave != akActor && !IsAlreadySelected(aSlave)
					if IsTogetherWithFast(aSlave.akRef, akTarget, 2000.0) ; 2000.0 = 28.4 meters
						SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
						selectArray[k] = aSlave
						k += 1
					endif
				endif
				i += 1
			endwhile
		endif
		if k < 1
			return -1
		endif
		if k < 8
			while k < 8
				SlaveSelectTarget[k].Clear()
				selectArray[k] = None
				k += 1
			endwhile
		endif
		return DOMSlaveSelectMessage.Show()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	int i = 0
	int k = 0
	while i < n && k < 8
		DOM_Actor aSlave = DOM02.GetActorByIndex(i)
		if aSlave != None && aSlave.akRef != akTarget && aSlave != akActor
			if IsTogetherWithFast(aSlave.akRef, akTarget, 750.0) ; 750.0 = 10 meters
				string name = aSlave.GetName()+" "
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
				selectArray[k] = aSlave
				k += 1
			endif
		endif
		i += 1
	endwhile
	if k < 8
		i = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave.akRef != akTarget && aSlave != akActor && !IsAlreadySelected(aSlave)
				if IsTogetherWithFast(aSlave.akRef, akTarget, 2000.0) ; 2000.0 = 28.4 meters
					string name = aSlave.GetName()+" "
					wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
					wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
					wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
	endif
	if k < 1
		return -1
	endif
	if k < 8
		while k < 8
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = false)
			selectArray[k] = None
			k += 1
		endwhile
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMNPCSlaveSelectMenu3(Actor akTarget, DOM_Actor akActor1, DOM_Actor akActor2)
	if akTarget == None
		return -1
	endif
	int n = DOM02.actorCounter
	if n < 3
		return -1
	endif

	if !wheelIsDefaultMenu
		int i = 0
		int k = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave.akRef != akTarget && aSlave != akActor1  && aSlave != akActor2
				if IsTogetherWithFast(aSlave.akRef, akTarget, 750.0) ; 750.0 = 10 meters
					SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
		if k < 8
			i = 0
			while i < n && k < 8
				DOM_Actor aSlave = DOM02.GetActorByIndex(i)
				if aSlave != None && aSlave.akRef != akTarget && aSlave != akActor1 && aSlave != akActor2 && !IsAlreadySelected(aSlave)
					if IsTogetherWithFast(aSlave.akRef, akTarget, 2000.0) ; 2000.0 = 28.4 meters
						SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
						selectArray[k] = aSlave
						k += 1
					endif
				endif
				i += 1
			endwhile
		endif
		if k < 1
			return -1
		endif
		if k < 8
			while k < 8
				SlaveSelectTarget[k].Clear()
				selectArray[k] = None
				k += 1
			endwhile
		endif
		return DOMSlaveSelectMessage.Show()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	int i = 0
	int k = 0
	while i < n && k < 8
		DOM_Actor aSlave = DOM02.GetActorByIndex(i)
		if aSlave != None && aSlave.akRef != akTarget && aSlave != akActor1 && aSlave != akActor2
			if IsTogetherWithFast(aSlave.akRef, akTarget, 750.0) ; 750.0 = 10 meters
				string name = aSlave.GetName()+" "
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
				selectArray[k] = aSlave
				k += 1
			endif
		endif
		i += 1
	endwhile
	if k < 8
		i = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave.akRef != akTarget && aSlave != akActor1 && aSlave != akActor2 && !IsAlreadySelected(aSlave)
				if IsTogetherWithFast(aSlave.akRef, akTarget, 2000.0) ; 2000.0 = 28.4 meters
					string name = aSlave.GetName()+" "
					wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
					wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
					wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
	endif
	if k < 1
		return -1
	endif
	if k < 8
		while k < 8
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = false)
			selectArray[k] = None
			k += 1
		endwhile
	endif
	return wheelMenu.OpenMenu()
EndFunction

Int Function ShowDOMSlaveNotTraineeSelectMenu(DOM_Actor akActor)
	if akActor == None
		return -1
	endif
	int n = DOM02.actorCounter
	if n < 1
		return -1
	endif

	if !wheelIsDefaultMenu
		int i = 0
		int k = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave != akActor && aSlave.GetTrainer() != akActor
				if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 750.0) ; 750.0 = 10 meters
					SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
		if k < 8
			i = 0
			while i < n && k < 8
				DOM_Actor aSlave = DOM02.GetActorByIndex(i)
				if aSlave != None && aSlave != akActor && aSlave.GetTrainer() != akActor && !IsAlreadySelected(aSlave)
					if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 2000.0) ; 2000.0 = 28.4 meters
						SlaveSelectTarget[k].ForceRefTo(aSlave.akRef)
						selectArray[k] = aSlave
						k += 1
					endif
				endif
				i += 1
			endwhile
		endif
		if k < 1
			return -1
		endif
		if k < 8
			while k < 8
				SlaveSelectTarget[k].Clear()
				selectArray[k] = None
				k += 1
			endwhile
		endif
		return DOMSlaveSelectMessage.Show()
	endif

	UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")

	int i = 0
	int k = 0
	while i < n && k < 8
		DOM_Actor aSlave = DOM02.GetActorByIndex(i)
		if aSlave != None && aSlave != akActor && aSlave.GetTrainer() != akActor
			if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 750.0) ; 750.0 = 10 meters
				string name = aSlave.GetName()+" "
				wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
				wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
				wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
				selectArray[k] = aSlave
				k += 1
			endif
		endif
		i += 1
	endwhile
	if k < 8
		i = 0
		while i < n && k < 8
			DOM_Actor aSlave = DOM02.GetActorByIndex(i)
			if aSlave != None && aSlave != akActor && aSlave.GetTrainer() != akActor && !IsAlreadySelected(aSlave)
				if IsTogetherWithFast(aSlave.akRef, akActor.akRef, 2000.0) ; 2000.0 = 28.4 meters
					string name = aSlave.GetName()+" "
					wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = k, value = name)
					wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = k, value = name)
					wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = true)
					selectArray[k] = aSlave
					k += 1
				endif
			endif
			i += 1
		endwhile
	endif
	if k < 1
		return -1
	endif
	if k < 8
		while k < 8
			wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = k, value = false)
			selectArray[k] = None
			k += 1
		endwhile
	endif
	return wheelMenu.OpenMenu()
EndFunction

Function DOMDoListTrainees(Actor akTarget)
	;LogTrace("DOMDoListTrainees "+akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	;LogTrace("DOMDoListTrainees "+sl_alias)
	if sl_alias == None
		return
	endif
	sl_alias.ListTraineeNames()
EndFunction

Function DOMDoSetCamp(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.SetCamp()
EndFunction

Function DOMDoGoToCamp(Actor akTarget)
	if akTarget == None
		DOM_BurlapSack objSack = GetCurrentCrosshairBurlapSack()
		if objSack==None
			DOMAllOrderMenu()
			return
		endif
		DOMDoSackMenu(objSack)
		return
	endif
	if !isADOMActor(aktarget)
		DOMDoNPCMenu(aktarget)
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		if akTarget.IsInFaction(DOMCore.DOMActionTravel)
			akTarget.RemoveFromFaction(DOMCore.DOMActionTravel)
		else
			akTarget.AddToFaction(DOMCore.DOMActionTravel)
			int imenu = ShowDOMTravelMenu(akTarget)
			if imenu >= 0
				akTarget.SetFactionRank(DOMTravelMode,imenu)
			endif
		endif
		return
	endif
	if sl_alias.behaviour == "travel"
		int imenu = ShowDOMStandingMenu(akTarget)
		; Wait mode menu
		if imenu == 4
			DOMDoCuffsMenu(akTarget)
		elseif imenu == 5
			DOMDoUncuff(akTarget)
		elseif imenu == 6
			DOMDoWalkOnFour(akTarget)
		endif
		return
	endif
	int imenu = ShowDOMTravelMenu(akTarget)
	; Travel mode menu
	if imenu >= 0		
		sl_alias.SetTravelMode(imenu)
		sl_alias.EnterGotoCamp()
	endif
EndFunction

Function DOMDoGuard(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	if sl_alias.behaviour == "guard"
		int imenu = ShowDOMStandingMenu(akTarget)
		; Wait mode menu
		if imenu == 4
			DOMDoCuffsMenu(akTarget)
		elseif imenu == 5
			DOMDoUncuff(akTarget)
		elseif imenu == 6
			DOMDoWalkOnFour(akTarget)
		endif
		return
	endif
	sl_alias.EnterGuard()
EndFunction

Function DOMDoGatherTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.GatherTrainees()
EndFunction

Function DOMDoAddTraineeMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int idx = ShowDOMSlaveNotTraineeSelectMenu(sl_alias)
	if idx < 0 || idx >= selectArray.length
		return
	endif
	DOM_Actor aTrainee = selectArray[idx]
	if aTrainee != None
		aTrainee.SetTrainer(sl_alias)
	endif
EndFunction

Function DOMDoUnloadTraineeMenu(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	int idx = ShowDOMTraineeSelectMenu(sl_alias)
	if idx < 0
		return
	endif
	DOM_Actor aTrainee = sl_alias.GetTrainee(idx)
	if aTrainee != None
		aTrainee.SeparateFromTrainer()
	endif
EndFunction

Function DOMDoUnloadTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.UnloadAllTrainees()
EndFunction

Function DOMDoDanceTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.DanceTrainees()
EndFunction

Function DOMDoMasturbateTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.MasturbateTrainees()
EndFunction

Function DOMDoTieupTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.SecureTrainees()
EndFunction

Function DOMDoDisplayTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.DisplayTrainees()
EndFunction

Function DOMDoChainTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.ChainTrainees()
EndFunction

Function DOMDoRestrainTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.RestrainTraineesInFurniture()
EndFunction

Function DOMDoPunishTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.EnterPunishTrainees()
EndFunction

Function DOMDoRapeTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.EnterTrainSexTrainees()
EndFunction

Function DOMDoOrgyTrainees(Actor akTarget)
	if akTarget == None
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias == None
		return
	endif
	sl_alias.EnterTrainOrgy()
EndFunction

; ### Abduction

bool Function isRescuedByWitness(Actor theVictim, bool do_check)
	if theVictim == None
		return false
	endif
	if theVictim.GetRelationshipRank(PlayerRef) >= 4 ; victim is in love with player
		int sub = theVictim.GetFactionRank(DOMTrainSubmission)
		if sub >= 84 ; victim was submitted before
			return false
		endif
	endif	
	if !do_check
		return false
	endif
	Faction CrimeFaction = theVictim.GetCrimeFaction()
	if CrimeFaction == None
		LogTrace("isRescuedByWitness NO CRIME FACTION SET")
		return false
	endif
    Actor akSomeone
    Cell the_cell = PlayerRef.GetParentCell()

	int knpc = 43 ; kNPC
    int i = the_cell.GetNumRefs(knpc)
    
    LogTrace("isRescuedByWitness found "+i+" NPCs")
    LogTrace("isRescuedByWitness crime faction = "+CrimeFaction.GetName()+" "+CrimeFaction)
    while (i > 0)
        i -= 1
        akSomeone = the_cell.GetNthref(i, knpc) As Actor 
        
        if akSomeone != None && akSomeone != PlayerRef && akSomeone != theVictim
			LogTrace("isRescuedByWitness actor="+akSomeone.GetDisplayName())
			if akSomeone.GetCrimeFaction() == CrimeFaction || akSomeone.HasFamilyRelationship(theVictim)
				bool do_alarm = true
				if akSomeone.IsGhost()
					do_alarm = false
					LogTrace("isRescuedByWitness GHOST actor="+akSomeone.GetDisplayName())
				elseif akSomeone.IsDead()
					do_alarm = false
					LogTrace("isRescuedByWitness DEAD actor="+akSomeone.GetDisplayName())
				elseif akSomeone.IsUnconscious()
					do_alarm = false
					LogTrace("isRescuedByWitness UNCONSCIOUS actor="+akSomeone.GetDisplayName())
				elseif akSomeone.GetSleepState() == 3
					do_alarm = false
					LogTrace("isRescuedByWitness SLEEPING actor="+akSomeone.GetDisplayName())
				elseif akSomeone.IsInFaction(DOMActionTied)
					LogTrace("isRescuedByWitness TIED-UP actor="+akSomeone.GetDisplayName())
					return false
				elseif akSomeone.GetActorValue("Paralysis") != 0.0
					do_alarm = false
					LogTrace("isRescuedByWitness PARALYSIS actor="+akSomeone.GetDisplayName())
				elseif akSomeone.IsInFaction(DOMActorExcludedFaction)
					do_alarm = false
					LogTrace("isRescuedByWitness EXCLUDED actor="+akSomeone.GetDisplayName())
				elseif akSomeone.IsInFaction(DOMCore.DOMActorInTransfer)
					do_alarm = false
					LogTrace("isRescuedByWitness TRANSFER actor="+akSomeone.GetDisplayName())
				elseif DOMCore.isASlave(akSomeone)
					do_alarm = false
					LogTrace("isRescuedByWitness SLAVE actor="+akSomeone.GetDisplayName())
				elseif akSomeone.IsInFaction(DOMActorFaction) 
					do_alarm = false
					LogTrace("isRescuedByWitness DOM actor="+akSomeone.GetDisplayName())
				elseif akSomeone.IsInFaction(PlayerFollowerFaction)
					do_alarm = false
					LogTrace("isRescuedByWitness FOLLOWER actor="+akSomeone.GetDisplayName())
				elseif akSomeone.GetRelationshipRank(PlayerRef) >= 4
					if !akSomeone.HasFamilyRelationship(theVictim)
						do_alarm = false
						LogTrace("isRescuedByWitness LOVER actor="+akSomeone.GetDisplayName())
					else
						LogTrace("isRescuedByWitness LOVER BUT VICTIM IS FAMILY actor="+akSomeone.GetDisplayName())
					endif
				endif
				if do_alarm
					if akSomeone.HasLOS(PlayerRef)
						if TryActorSendAssaultAlarm(akSomeone)
							HudNotification(akSomeone.GetDisplayName()+" saw you assaulting "+theVictim.GetDisplayName()+" and yells for help!")
							LogTrace("isRescuedByWitness WITNESS actor="+akSomeone.GetDisplayName())
							return true
						else
							LogTrace("isRescuedByWitness NO VALID NPC actor="+akSomeone.GetDisplayName())
						endif
					else
						LogTrace("isRescuedByWitness NO LOS actor="+akSomeone.GetDisplayName())
					endif
				endif				
			else
				LogTrace("isRescuedByWitness NOT CRIME FACTION OR FAMILY actor="+akSomeone.GetDisplayName())
			endif
        endif
    endwhile
	return false
EndFunction

bool Function TryActorSendAssaultAlarm(Actor akTarget)
	Cell the_cell = akTarget.GetParentCell()
	int knpc = 43 ; kNPC
	int nnpc = the_cell.GetNumRefs(knpc)
	if nnpc < 1
		return false
	endif
	akTarget.SendAssaultAlarm()
	return true
EndFunction

bool Function TryFactionSendAssaultAlarm(Faction the_faction)
	Cell the_cell = PlayerRef.GetParentCell()
	int knpc = 43 ; kNPC
	int nnpc = the_cell.GetNumRefs(knpc)
	if nnpc < 1
		return false
	endif
	the_faction.SendAssaultAlarm()
	return true
EndFunction

bool Function isOverwhelmed(Actor akTarget)
	if akTarget.GetRelationshipRank(PlayerRef) >= 4
		if akTarget.GetLeveledActorBase().GetSex() == 0
			HudNotification(akTarget.getDisplayName()+" trustfully lets you close your hands around his neck")
		else
			HudNotification(akTarget.getDisplayName()+" trustfully lets you close your hands around her neck")
		endif
		return true
	endif	
	float[] TraitsArray = DOMGenerator.GetNPCTraits(akTarget)
	int x = RandomInt(34,100)
	if akTarget.GetRelationshipRank(PlayerRef) > 1 && x < TraitsArray[0] ; Honesty
		HudNotification(akTarget.getDisplayName()+" should not have trusted your friendship")
		return true
	endif	
	bool is_combat = akTarget.IsInCombat()
	if is_combat ; malus if actor is in combat
		x -= 34
	endif
	; Main atributes against abduction
	if x < TraitsArray[6] ; Wilfulness
		HudNotification(akTarget.getDisplayName()+" is too wilful to let you have it your way")
		return false
	endif
	if x < TraitsArray[7] ; Toughness
		HudNotification(akTarget.getDisplayName()+" is too tough to let you have it your way")
		return false
	endif
	; Secondary atributes against abduction
	x += 34
	if x < TraitsArray[11] ; Smartness
		HudNotification(akTarget.getDisplayName()+" is too smart to let you have it your way")
		return false
	endif
	if x < TraitsArray[9] ; Dominant
		HudNotification(akTarget.getDisplayName()+" is not going to let you have it your way")
		return false
	endif
	HudNotification("You grab an unwary "+akTarget.getDisplayName())
	return true
EndFunction

bool Function isUnaware(Actor akTarget)
	if akTarget.GetRelationshipRank(PlayerRef) >= 4
		if akTarget.GetLeveledActorBase().GetSex() == 0
			HudNotification(akTarget.getDisplayName()+" would let you do anything to him")
		else
			HudNotification(akTarget.getDisplayName()+" would let you do anything to her")
		endif
		return true
	endif	
	if akTarget.IsBleedingOut()
		HudNotification(akTarget.getDisplayName()+" is wounded and unaware of your attack")
		return true
	endif
	if !playerRef.IsDetectedBy(akTarget)
		HudNotification("You succesfully sneak behind "+akTarget.getDisplayName()+"'s back")
		return true
	endif
	if RandomFloat()*100.0 < DOMPlayerAlias.GetSkillPredator()
		HudNotification("You deceitfully approach an unwary "+akTarget.getDisplayName())
		return true
	endif
	return isOverwhelmed(akTarget)
EndFunction

ObjectReference Property PoseAnimMarker Auto Hidden

Function Anim_AggressorByString(Actor aggressor, string the_anim)
	;LogTrace("Anim_AggressorByString "+the_anim+" animPlayer="+DOMCore.doPlayerIdle)
	if aggressor == NONE
		return
	endif
	if aggressor == PlayerRef
		if DOMCore.doPlayerIdle
			StandUpActor(PlayerRef)
			CalmActorFast(PlayerRef)
			if Game.GetCameraState() == 0
				Game.ForceThirdPerson()
			endif
			Debug.SendAnimationEvent(aggressor, the_anim)
		endif
		return
	endif
	StandUpActor(aggressor)
	CalmActorFast(aggressor)
	aggressor.setRestrained()
	aggressor.setDontMove()
	Debug.SendAnimationEvent(aggressor, the_anim)
EndFunction

Function Anim_AggressorReset(Actor aggressor)
	;LogTrace("Anim_AggressorReset aggressor="+aggressor)
	if aggressor == NONE
		return
	endif
	if aggressor == PlayerRef
		return
	endif
	aggressor.setRestrained(false)
	aggressor.setDontMove(false)
EndFunction

Function Anim_AggressorTieUp(Actor aggressor)
	if aggressor == PlayerRef && !DOMCore.doAnimPlayerTieup
		return
	endif
	CalmActorFast(aggressor)
	Anim_AggressorByString(aggressor,"IdleLockpick")
	Wait(2.0)
	Anim_AggressorReset(aggressor)
EndFunction

Function Anim_AggressorUntie(Actor aggressor)
	if aggressor == PlayerRef && !DOMCore.doAnimPlayerTieup
		return
	endif
	CalmActorFast(aggressor)
	Anim_AggressorByString(aggressor,"BoundStandingCutNPC")
	Wait(2.0)
	Anim_AggressorReset(aggressor)
EndFunction

Function Anim_AbductionBack(Actor akTarget)
	if DOMCore.dualAnimToggle
		string anim_key
		int sleepState = akTarget.GetSleepState()
 		if sleepState==0 ; Put NPC down first
			if RandomInt(1,2) == 1
				anim_key = "DOMCaptureStandingBack"
			else
				anim_key = "DOMCaptureKick"
			endif
		else
			anim_key = "DOMCaptureSleeping"
		endif
		StartJSONAnimation(akTarget,PlayerRef,anim_key)
		PlayJSONAnimations(1,JSONanim_nscenes-(1))
		EndJSONAnimation()
	else
		;akTarget.playIdleWithTarget(pa_DOMOverwhelm,playerRef) ;
		akTarget.playIdleWithTarget(pa_DOMSleeper,playerRef) ;
	endif
EndFunction

Function Anim_AbductionFront(Actor akTarget)
	if DOMCore.dualAnimToggle
		string anim_key
		int sleepState = akTarget.GetSleepState()
 		if sleepState==0 ; Put NPC down first
			if RandomInt(1,2) == 1
				anim_key = "DOMCaptureStandingFront"
			else
				anim_key = "DOMCaptureJump"
			endif
		else
			anim_key = "DOMCaptureSleeping"
		endif
		StartJSONAnimation(akTarget,PlayerRef,anim_key)
		PlayJSONAnimations(1,JSONanim_nscenes-(1))
		EndJSONAnimation()
	else
		akTarget.playIdleWithTarget(pa_DOMOverwhelm,playerRef) ;
	endif
EndFunction

Function Anim_AbductionFloor(Actor akTarget)
	if DOMCore.dualAnimToggle
		string anim_key = "DOMCaptureFloor"
		StartJSONAnimation(akTarget,PlayerRef,anim_key)
		PlayJSONAnimations(1,JSONanim_nscenes-(1))
		EndJSONAnimation()
	else
		akTarget.playIdleWithTarget(pa_DOMOverwhelm,playerRef) ;
	endif
EndFunction

Function AnimKnockout(Actor akTarget)
	if akTarget == None
		return
	endif
	;Debug.Notification("SetUnconscious")
	akTarget.SetUnconscious()
	akTarget.StopCombat()
	akTarget.StopCombatAlarm()
	int sleepState = akTarget.GetSleepState()
	int sitState   = akTarget.GetSitState()
	string[] JSONanim_idles = DOM_Anim.GetKnockoutAnims()
	if sleepState > 0 || sitState > 0
		StandUpActor(akTarget)
		CalmActorFast(akTarget)		 
	endif
	;Debug.Notification("KnockOutLoop")
	if JSONanim_idles
		int i = 0
		while i < JSONanim_idles.length
			Debug.SendAnimationEvent(akTarget,JSONanim_idles[i])
			Utility.Wait(4.0)
			i += 1
		endwhile
	else
		Debug.SendAnimationEvent(akTarget,"DOMBaboDefeatKnockOutStart")
		Utility.Wait(4.0)
		Debug.SendAnimationEvent(akTarget,"DOMBaboDefeatKnockOutLoop")
	endif
EndFunction

Function DOMActorCaptureFront(Actor aktarget, string msg)
	if akTarget == None
		return
	endif
	SendCaptureAnimationEvent(aktarget,msg,false,false)
	DOM_Actor akActor = DOM02.Capture(aktarget,"DOMBabo_ChokeRape03_A1_S2")
	if akActor.mind.memory_capture_txt == "" ; Actor did not receive the capture event, maybe because of cloning
		SendCaptureAnimationEvent(akActor.akRef,msg,false,false)
	endif
	akActor.mind.TrainFear(20.0) ; Fear boost for abduction
	DOM04.NotifyCaptureCircumstances2(akActor,true,false,0,0)
EndFunction

DOM_Actor Function DOMActorAbduction(Actor akTarget)
	if akTarget == None
		return None
	endif
	if akTarget.IsDead()
		HudNotification("You need the Dead Soul Necromantic abduction spell to enslave dead actors")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if DOMSexlab.IsAnimating(akTarget) ; In SL scene
		HudNotification("Can not abduct at the moment")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if akTarget.IsInFaction(PlayerFollowerFaction) ; Is a follower
		HudNotification("Can not abduct a follower")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if akTarget.GetFactionRank(CurrentFollowerFaction) >= 0 ; Is a follower
		HudNotification("Can not abduct a follower")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if akTarget.IsInFaction(DOMActorFaction) ; Is already a DOM actor
		HudNotification("Can not abduct a slave or slaver")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if akTarget.IsInFaction(DOMCore.DOMActorInTransfer) ; Is already a DOM actor and is being transfered
		HudNotification("Can not abduct a slave or slaver being transfered")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if akTarget.IsInFaction(DOMActorExcludedFaction) ; Is in excluded faction
		HudNotification("Actor is in excluded faction")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if forbidAnimalCapture && akTarget.HasKeyWord(ActorTypeAnimal) ; Do not capture animals
		HudNotification("Animal capture is turned off")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if forbidCreatureCapture && akTarget.HasKeyWord(ActorTypeCreature) ; Do not capture creatures
		HudNotification("Creature capture is turned off")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if forbidUndeadCapture && akTarget.HasKeyWord(ActorTypeUndead) ; Do not capture undead
		HudNotification("Undead capture is turned off")
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	if akTarget.GetFactionRank(DOMBeingCaptured) == 1 ; already being processed in slave manager
		return None
	endif
	if akTarget.GetFactionRank(DOMBeingCaptured) == 3 ; already being processed in this Function
		return None
	endif
	bool isValid = (akTarget.HasKeyWord(ActorTypeNPC) || akTarget.HasKeyWord(ActorTypeAnimal) || akTarget.HasKeyWord(ActorTypeCreature) || akTarget.HasKeyWord(ActorTypeUndead)) && !akTarget.IsChild()
	bool isSlave = DOMCore.isASlave(akTarget)
	if !isValid || isSlave || akTarget.IsOnMount()
		akTarget.RemoveFromFaction(DOMBeingCaptured)
		return None
	endif
	akTarget.SetFactionRank(DOMBeingCaptured,3)

	Logtrace("DOMAbduction=start Target is "+akTarget.GetDisplaYName()+" is_unconscious="+akTarget.IsUnconscious())
	if debugKeyMode
		HudNotification("Attempting abduction of "+akTarget.getDisplayName())
	endif
	
	bool is_unconscious
	bool is_unaware
	bool is_frombehind 
	int sitState = akTarget.GetSitState()
	int sleepState = akTarget.GetSleepState()
	if akTarget.IsUnconscious()
		is_unconscious = true
		is_unaware = true
		is_frombehind = false
	elseif sleepState>0 ; sleeping
		is_unconscious = false
		is_unaware = true
		is_frombehind = false
		; Wait 2 seconds if laying down or standing up
		if sleepState == 2 ; laying down
			Wait(2.0)
		elseif sleepState == 4 ; standing up
			;LogTrace("Animation: DOMAbduction() ExitBed")
			akTarget.PlayIdle(ExitBed)
			Wait(2.0)
		endif
	else
		is_unconscious = false
		if sitState>0 ; sitting
			; Wait 2 seconds if sitting down or standing up
			if sitState == 2 ; sitting down
				Wait(2.0)
			elseif sitState == 4 ; standing up
				;LogTrace("Animation: DOMAbduction() ExitChairFront")
				akTarget.PlayIdle(ExitChairFront)
				Wait(2.0)
			endif
		endif
			
		if alarmToggleAbduction
			; either actor didn't detect player or actor was not expecting that
			is_unaware = isUnaware(akTarget)
			if !is_unaware
				akTarget.RemoveFromFaction(DOMBeingCaptured)
				Faction the_faction = akTarget.GetCrimeFaction()
				if the_faction
					if TryFactionSendAssaultAlarm(the_faction)
						LogTrace("DOMAbduction SendAssaultAlarm original crime faction="+the_faction.GetName()+" reaction="+the_faction.GetReaction(DOMCore.PlayerFaction))
					else
						LogTrace("DOMAbduction SendAssaultAlarm no NPC nearby")
					endif
				else
					LogTrace("DOMAbduction SendAssaultAlarm no crime faction")
				endif
				if TryActorSendAssaultAlarm(akTarget)
					LogTrace("DOMAbduction SendAssaultAlarm success "+akTarget.GetDisplayName())
				else
					LogTrace("DOMAbduction SendAssaultAlarm no valid NPC nearby "+akTarget.GetDisplayName())
				endif
				akTarget.SetLookAt(playerRef, true)
				akTarget.StartCombat(playerRef)
				return None
			endif
		else
			is_unaware = true		
		endif

		float pangle = akTarget.GetHeadingAngle(playerRef) 
		if pangle < 0.0
			pangle = -pangle
		endif
		;Logtrace(akTarget.getDisplayName()+" player angle is "+pangle)
		if pangle > 110.0 ; beyond far peripheral vision zone
			is_frombehind = true
		else
			is_frombehind = false
		endif
	endif
		
	sleepState = akTarget.GetSleepState()
	string last_anim
	string msg
	if is_unconscious
		last_anim = "DOMBaboFaintF_S"
		msg = "You quietly check your fallen prey "+akTarget.getDisplayName()
	elseif is_frombehind
		last_anim = "DOMBabo_ChokeRape03_A1_S2"
		msg = "You sneak behind "+akTarget.getDisplayName()
	elseif sleepState>0
		last_anim = "DOMBabo_ChokeRape03_A1_S2"
		if akTarget.GetLeveledActorBase().GetSex() == 0
			msg = "You surprise "+akTarget.getDisplayName()+" in his sleep"
		else
			msg = "You surprise "+akTarget.getDisplayName()+" in her sleep"
		endif
		is_frombehind = true
	else
		last_anim = "DOMBabo_ChokeRape03_A1_S2"
		msg = "You manage to overwhelm "+akTarget.getDisplayName()
	endif

	DOM_Actor akActor = None
	if !isRescuedByWitness(akTarget,alarmToggleWitness)
		SendCaptureAnimationEvent(akTarget,msg,is_frombehind,is_unconscious)
		;Logtrace("DOMAbduction=capture Target is "+akTarget)
		akActor = DOM02.Capture(akTarget,last_anim)
		if akActor != None
			if akActor.mind.memory_capture_txt == "" ; Actor did not receive the capture event, maybe because of cloning
				SendCaptureAnimationEvent(akActor.akRef,msg,is_frombehind,is_unconscious)
			endif
			akActor.mind.TrainFear(20.0) ; Fear boost for abduction
			DOM04.NotifyCaptureCircumstances2(akActor,is_unaware,is_frombehind,sitState,sleepState)
		endif
	else
		AnimKnockout(akTarget)
	endif
	if isRescuedByWitness(akTarget,alarmToggleWitness2)
		Logtrace("DOMAbduction=rescue Target is "+akTarget)
	endif
	if akActor == None
		 akTarget.RemoveFromFaction(DOMBeingCaptured)
	endif
	return akActor
	;Logtrace("DOMAbduction=end Target is "+akTarget)
EndFunction

Function DOMTieupActorAbduction(Actor akActor)
	if akActor == None
		return
	endif
	if akActor.IsInFaction(DOMBeingCaptured)
		return
	endif	
	int type = akActor.GetFactionRank(DOMActionTied)
	if type < 1
		type == 1
	endif
	LogTrace("DOMTieupActorAbduction "+akActor.GetDisplayName()+" type="+type)
	akActor.SetFactionRank(DOMBeingCaptured,2)
	akActor.RemoveFromFaction(DOMActorExcludedFaction)
	akActor.RemoveFromFaction(DOMActorExcludedDialogue)
	akActor.RemoveFromFaction(DOMActionWaiting)
	akActor.RemoveFromFaction(DOMActionTied)
	akActor.RemoveFromFaction(DOMActionFollowing)
	int rank = akActor.GetFactionRank(DOMTrainSubmission)
	if rank < 1
		akActor.SetFactionRank(DOMTrainSubmission,1)
	endif
	DOM_Actor dactor
	if type == 1
		dactor = DOM02.Capture(akActor, DOM_Anim.GetTieupKneelingNPC(akActor))
		if dactor != None
			dactor.mind.TrainSubmission(20.0) ; Submission training boost for tieup capture
		endif
	elseif type == 2
		dactor = DOM02.Capture(akActor, DOM_Anim.GetTieupInBedNPC(akActor))
		if dactor != None
			dactor.mind.TrainSubmission(10.0) ; Submission training boost for tieup capture
			dactor.mind.TrainHumiliation(10.0) ; Submission and humiliation training boost for tieup in bed capture
		endif
	else
		dactor = DOM02.Capture(akActor, DOM_Anim.GetTieupLayingNPC(akActor))
		if dactor != None
			dactor.mind.TrainHumiliation(20.0) ; Humiliation training boost for tieup and unconscious
		endif
	endif
	if dactor == None
		 akActor.RemoveFromFaction(DOMBeingCaptured)
	endif
EndFunction

Function DOMActorEnslave(Actor akActor, string the_pose)
	if akActor == None
		return
	endif
	if akActor.IsInFaction(DOMBeingCaptured)
		return
	endif	
	int type = akActor.GetFactionRank(DOMActionTied)
	if type > 0
		 DOMTieupActorAbduction(akActor)
		 return
	endif
	int rel = akActor.GetRelationshipRank(PlayerRef)
	LogTrace("DOMActorEnslave "+akActor.GetDisplayName()+" type="+type+" rel="+rel)
	SendAnimation(akActor,"IdleForceDefaultState")
	akActor.SetFactionRank(DOMBeingCaptured,2)
	akActor.RemoveFromFaction(DOMActorExcludedFaction)
	akActor.RemoveFromFaction(DOMActorExcludedDialogue)
	akActor.RemoveFromFaction(DOMActionWaiting)
	akActor.RemoveFromFaction(DOMActionTied)
	akActor.RemoveFromFaction(DOMActionFollowing)
	int rank = akActor.GetFactionRank(DOMTrainSubmission)
	if rank < 1
		akActor.SetFactionRank(DOMTrainSubmission,1)
	endif
	DOM_Actor dactor = DOM02.Capture(akActor,the_pose)
	if dactor == None
		 akActor.RemoveFromFaction(DOMBeingCaptured)
		 return
	endif
	DOM_Mind akMind = dactor.mind
	if akMind == None
		return
	endif
	akMind.TrainSubmission(10.0) ; Submission, Resignation training boost for free will capture
	akMind.TrainResignation(10.0)
	akMind.TrainRespect(10.0)  
	; Check relation ship to player before capture
	if rel >= 4
		if akMind.resignation < 70.0
			akMind.TrainResignation(70.0-akMind.resignation)
		endif
		if akMind.submission < 50.0
			akMind.TrainSubmission(50.0-akMind.submission)
		endif
		if akMind.respect_training < 30.0
			akMind.TrainRespect(30.0-akMind.respect_training)
		endif
	elseif rel >= 3
		if akMind.resignation < 50.0
			akMind.TrainResignation(50.0-akMind.resignation)
		endif
		if akMind.respect_training < 30.0
			akMind.TrainRespect(30.0-akMind.respect_training)
		endif
	else
		if akMind.resignation < 30.0
			akMind.TrainResignation(30.0-akMind.resignation)
		endif
	endif
EndFunction

Function UnequipFeetAndHands(Actor akTarget)
	Armor the_boots = akTarget.GetWornForm(0x00000080) as Armor ; kSlotMask37 = 0x00000080 AutoReadOnly ; Feet
	if the_boots != None
		LogTrace("UnequipFeetAndHands: found boots="+the_boots)
		akTarget.UnequipItem(the_boots, true, true) ; can not reequip
	endif
	Armor the_shield = akTarget.GetWornForm(0x00000200) as Armor ; kSlotMask39 = 0x00000200 AutoReadOnly ; SHIELD
	if the_shield != None
		LogTrace("UnequipFeetAndHands: found shield="+the_shield)
		akTarget.UnequipItem(the_shield, true, true) ; can not reequip
	endif
	Weapon the_weaponR = akTarget.GetEquippedWeapon(false) ; right hand
	if the_weaponR != None
		LogTrace("UnequipFeetAndHands: found weapon in right hand="+the_weaponR)
		akTarget.UnequipItem(the_weaponR, true, true) ; can not reequip
	endif
	Weapon the_weaponL = akTarget.GetEquippedWeapon(true) ; left hand
	if the_weaponL != None
		LogTrace("UnequipFeetAndHands: found weapon in left hand="+the_weaponL)
		akTarget.UnequipItem(the_weaponL, true, true) ; can not reequip
	endif
	Ammo the_ammo = akTarget.GetEquippedObject(0) as Ammo
	if the_ammo != None
		LogTrace("UnequipFeetAndHands: found ammo="+the_ammo)
		akTarget.UnequipItem(the_ammo, true, true) ; can not reequip
	endif
	Armor the_gloves = akTarget.GetWornForm(0x00000008) as Armor ; kSlotMask33 = 0x00000008 AutoReadOnly ; Hands
	if the_gloves != None
		LogTrace("UnequipFeetAndHands: found gloves="+the_gloves)
		akTarget.UnequipItem(the_gloves, true, true) ; can not reequip
	endif
EndFunction

Function AddAndEquipItem(Actor akTarget, Armor the_item)
	if akTarget == None || the_item == None
		return
	endif
	if akTarget.GetItemCount(the_item) <= 0
		akTarget.AddItem(the_item)
	endif
	if !akTarget.IsEquipped(the_item)
		if DOMEquip.IsItemSpecial(the_item) || DOMEquip.IsItemDevice(the_item)
			EquipItemTight(akTarget,the_item) ; can not unequip, silent
		else
			EquipItemLoose(akTarget,the_item) ; can not unequip, silent
		endif
	endif
EndFunction

Function Anim_VictimTieUp(Actor akTarget, int type, string the_pose = "")
	LogTrace("Anim_VictimTieUp "+akTarget.GetDisplayName()+" type="+type)
	if the_pose == ""
		if type == 1
			the_pose = DOM_Anim.GetTieupKneelingNPC(akTarget) ; kneeling
		elseif type == 2
			the_pose = DOM_Anim.GetTieupInBedNPC(akTarget) ; tied to bed
		else ; if type == 3
			the_pose = DOM_Anim.GetTieupLayingNPC(akTarget) ; laying
		endif
	endif
	LogTrace("Anim_VictimTieUp "+akTarget.GetDisplayName()+" TieUp "+the_pose)
	SendAnimation(akTarget, the_pose) 
	Debug.SendAnimationEvent(akTarget, the_pose)
EndFunction

Function DOMSetFollowerWait(Actor akTarget, bool should_wait=true)
	if akTarget == None
		return
	endif
	If !akTarget.IsInFaction(PlayerFollowerFaction) && akTarget.GetFactionRank(CurrentFollowerFaction) < 0
		return ; not a follower
	endif
	if should_wait
		akTarget.SetAV("WaitingForPlayer", 1)
		if pTweakWaitingFaction != None
			akTarget.SetFactionRank(pTweakWaitingFaction,1)
		endif
	else
		akTarget.SetAV("WaitingForPlayer", 0)
		if pTweakWaitingFaction != None
			akTarget.RemoveFromFaction(pTweakWaitingFaction)
			akTarget.RemoveFromFaction(pTweakSandboxFaction)
			akTarget.RemoveFromFaction(pTweakPosedFaction)
		endif
	endif
EndFunction

Function DOMSetFollowerSandbox(Actor akTarget, bool should_wait=true)
	if akTarget == None
		return
	endif
	If !akTarget.IsInFaction(PlayerFollowerFaction) && akTarget.GetFactionRank(CurrentFollowerFaction) < 0
		return ; not a follower
	endif
	if should_wait
		akTarget.SetAV("WaitingForPlayer", -1) ; -1 = relax
		if pTweakWaitingFaction != None
			akTarget.SetFactionRank(pTweakWaitingFaction,1)
			akTarget.SetFactionRank(pTweakSandboxFaction,1)
		endif
	else
		akTarget.SetAV("WaitingForPlayer", 0)
		if pTweakWaitingFaction != None
			akTarget.RemoveFromFaction(pTweakWaitingFaction)
			akTarget.RemoveFromFaction(pTweakSandboxFaction)
			akTarget.RemoveFromFaction(pTweakPosedFaction)
		endif
	endif
EndFunction

bool Function DOMSetFollowerPose(Actor akTarget)
	if akTarget == None
		return false
	endif
	If !akTarget.IsInFaction(PlayerFollowerFaction) && akTarget.GetFactionRank(CurrentFollowerFaction) < 0
		return false ; not a follower
	endif
	bool was_wait = false
	if akTarget.GetAV("WaitingForPlayer") == 1
		was_wait = True
	elseif pTweakWaitingFaction != None
		if akTarget.IsInFaction(pTweakWaitingFaction)
			was_wait = True
		elseif akTarget.IsInFaction(pTweakSandboxFaction)
			was_wait = True
		endif
	endif
	akTarget.SetAV("WaitingForPlayer", 1)
	if pTweakWaitingFaction != None
		akTarget.SetFactionRank(pTweakWaitingFaction,1)
	endif
	return was_wait
EndFunction

Function DOMUnSetFollowerPose(Actor akTarget, bool should_wait=true)
	if akTarget == None
		return
	endif
	If !akTarget.IsInFaction(PlayerFollowerFaction) && akTarget.GetFactionRank(CurrentFollowerFaction) < 0
		return ; not a follower
	endif
	if should_wait
		akTarget.SetAV("WaitingForPlayer", 1)
		if pTweakWaitingFaction != None
			akTarget.SetFactionRank(pTweakWaitingFaction,1)
		endif
	else
		akTarget.SetAV("WaitingForPlayer", 0)
		if pTweakWaitingFaction != None
			akTarget.RemoveFromFaction(pTweakWaitingFaction)
		endif
	endif
EndFunction

Function DOMTieupActor(Actor akTarget, Actor akAnotherActor, string the_pose = "", bool do_gag = true, bool call_for_help = true)
	LogTrace("DOMTieupActor akTarget="+akTarget.GetDisplayName()+" tied="+akTarget.GetFactionRank(DOMActionTied)+" captured="+akTarget.IsInFaction(DOMBeingCaptured)+" pose="+the_pose+" help="+call_for_help)
	if akTarget.IsInFaction(DOMBeingCaptured)
		return
	endif	
	SendTieupAnimationEvent(akAnotherActor)
	int type ; type 1 means kneeling, 2 laying
	if akTarget.IsUnconscious()
		type = 3
	elseif akTarget.GetSleepState() == 3
		type = 2
	elseif akTarget.IsInFaction(DOMActionTied)
		type = akTarget.GetFactionRank(DOMActionTied)
		if type == 2 ; if tied to bed change to laying
			type = 3
		endif
	else
		type = 1
	endif
	if call_for_help && !akTarget.IsInFaction(DOMActionTied) 
		if isRescuedByWitness(akTarget,alarmToggleWitness3)
			LogTrace("DOMTieupActor FAILED akTarget="+akTarget.GetDisplayName()+" type="+type+" pose="+the_pose)
			HudNotification("You didn't manage to tie-up "+akTarget.GetDisplayName()+" unnoticed")
			return
		endif
	endif
	LogTrace("DOMTieupActor SUCCESS akTarget="+akTarget.GetDisplayName()+" type="+type+" pose="+the_pose)
	UnequipFeetAndHands(akTarget)
	Anim_VictimTieUp(akTarget,type,the_pose) ; type = 1, 2, 3 = kneeling, tied to bed or laying
	akTarget.SetFactionRank(DOMActionTied,type)
	DOMSetFollowerWait(akTarget,true)
	ActorUtil.AddPackageOverride(akTarget, DOMBeTiedOrWait, 100, 1)
	akTarget.EvaluatePackage()
	if do_gag
		AddAndEquipItem(akTarget,DOMZaz.GetGagCloth() as Armor)
	endif
	AddAndEquipItem(akTarget,DOMZaz.GetCuffsRope() as Armor)
	;UnequipFeetAndHands(akTarget)
	akTarget.SetRestrained(true)
	akTarget.SetDontMove(true)
	UnequipFeetAndHands(akTarget)
	Anim_VictimTieUp(akTarget,type,the_pose)
	TrainNb(akTarget,DOMCore.DOMNbBondage)
EndFunction

Function DOMUnTieActor(Actor akTarget, Actor akAnotherActor, bool call_for_help = true)
	LogTrace("DOMUnTieActor akTarget="+akTarget.GetDisplayName()+" tied="+akTarget.IsInFaction(DOMActionTied)+" help="+call_for_help)
	if !akTarget.IsInFaction(DOMActionTied)
		return
	endif
	SendUntieAnimationEvent(akAnotherActor)
	Form the_gag = DOMZaz.GetEquippedGag(akTarget)
	if the_gag != None && akTarget.IsEquipped(the_gag)
		akTarget.UnequipItem(the_gag, true, true) ; do not reequip
	endif
	Form the_cuffs = DOMZaz.GetEquippedCuffs(akTarget)
	if the_cuffs != None && akTarget.IsEquipped(the_cuffs)
		akTarget.UnequipItem(the_cuffs, true, true) ; do not reequip
	endif
	akTarget.RemoveFromFaction(DOMActionTied)
	ActorUtil.RemovePackageOverride(akTarget, DOMBeTiedOrWait)
	akTarget.EvaluatePackage()
	akTarget.SetRestrained(false)
	akTarget.SetDontMove(false)
	akTarget.SetVehicle(None)
	DOMSetFollowerWait(akTarget,false)
	Debug.SendAnimationEvent(akTarget,"IdleForceDefaultState")
	if !call_for_help
		return
	endif
	if akAnotherActor == PlayerRef && alarmToggleAbduction2 && !akTarget.IsUnconscious() ; non slave actors might react by calling for help or attacking the player
		DOMCore.SayTopic(akTarget,DOM02TopicAnswerAttack)
		int rank = akTarget.GetRelationshipRank(PlayerRef)
		if rank <= 2
			Faction the_faction = akTarget.GetCrimeFaction()
			if the_faction
				if TryFactionSendAssaultAlarm(the_faction)
					LogTrace("DOMUnTieActor SendAssaultAlarm SUCCESS original crime faction="+the_faction.GetName()+" reaction="+the_faction.GetReaction(DOMCore.PlayerFaction))
				else
					LogTrace("DOMUnTieActor SendAssaultAlarm FAILURE original crime faction="+the_faction.GetName()+" reaction="+the_faction.GetReaction(DOMCore.PlayerFaction))
				endif
			else
				LogTrace("DOMUnTieActor SendAssaultAlarm no crime faction "+akTarget.GetDisplayName())
			endif
			akTarget.SetLookAt(playerRef, true)
			if rank <= 1
				if TryActorSendAssaultAlarm(akTarget)
					LogTrace("DOMUnTieActor SendAssaultAlarm SUCCESS "+akTarget.GetDisplayName())
				else
					LogTrace("DOMUnTieActor SendAssaultAlarm FAILURE "+akTarget.GetDisplayName())
				endif
				akTarget.StartCombat(playerRef)
			endif
		endif
		if rank < 4 ; not LOVER
			akTarget.SetRelationshipRank(PlayerRef,rank-(1))
		endif
	endif			
EndFunction

Function SendCaptureAnimationEvent(Actor akTarget, string msg, bool is_from_behind, bool is_unconscious)
	if !DOMCore.sendDOMCaptureEvent
		OnCaptureAnimation(akTarget,msg,is_from_behind,is_unconscious)
		return
	endif
	string eventName = "DOM_CaptureAnimation"
    int handle = ModEvent.Create(eventName)
    if (handle)
		LogTrace("SendCaptureAnimationEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akTarget)
		ModEvent.PushString(handle, msg)
		ModEvent.Pushbool(handle, is_from_behind)
		ModEvent.Pushbool(handle, is_unconscious)
        ModEvent.Send(handle)
	else
		LogInfo("ERROR: SendCaptureAnimationEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function RegisterForCaptureAnimationEvent()
	RegisterForModEvent("DOM_CaptureAnimation", "OnCaptureAnimation")
EndFunction

Function UnRegisterForCaptureAnimationEvent()
	UnregisterForModEvent("DOM_CaptureAnimation")
EndFunction

Event OnCaptureAnimation(Form akTarget, string msg, bool is_from_behind, bool is_unconscious)
	Actor akActor = akTarget as Actor
	;Logtrace("OnCaptureAnimation start Target is "+akActor.GetDisplaYName()+" is_unconscious="+akActor.IsUnconscious())
	if akActor == None
		return
	endif
	if akActor.isDead()
		return
	endif
	if msg != ""
		HudNotification(msg)	
	endif
	DOMCore.SayTopic(akActor,DOM02TopicAnswerAttack)
	if is_unconscious
		Logtrace("OnCaptureAnimation unconscious msg="+msg)
		Anim_AbductionFloor(akActor)
	elseif is_from_behind
		Logtrace("OnCaptureAnimation from behind msg="+msg)
		Anim_AbductionBack(akActor)
	else
		Logtrace("OnCaptureAnimation from front msg="+msg)
		Anim_AbductionFront(akActor)
	endif
	if akActor.IsUnconscious()
		akActor.SetUnconscious(false)
	endif
	;Logtrace("OnCaptureAnimation end Target is "+akActor)
EndEvent

Function SendTieupAnimationEvent(Actor akTarget, string msg="")
	if !DOMCore.sendDOMCaptureEvent
		OnTieupAnimation(akTarget,msg)
		return
	endif
	string eventName = "DOM_TieupAnimation"
    int handle = ModEvent.Create(eventName)
    if (handle)
		LogTrace("SendTieupAnimationEvent Registering event SUCCESS "+eventName+" akTarget="+akTarget.GetDisplayName())
		ModEvent.PushForm(handle, akTarget)
		ModEvent.PushString(handle, msg)
        ModEvent.Send(handle)
	else
		LogInfo("ERROR: SendTieupAnimationEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function RegisterForTieupAnimationEvent()
	RegisterForModEvent("DOM_TieupAnimation", "OnTieupAnimation")
EndFunction

Function UnRegisterForTieupAnimationEvent()
	UnregisterForModEvent("DOM_TieupAnimation")
EndFunction

Event OnTieupAnimation(Form akTarget, string msg)
	Actor akActor = akTarget as Actor
	Logtrace("OnTieupAnimation start Target is "+akActor.GetDisplaYName()+" is_unconscious="+akActor.IsUnconscious())
	if akActor == None
		return
	endif
	if akActor.isDead() || akActor.IsUnconscious()
		return
	endif
	if msg != ""
		HudNotification(msg)	
	endif
	Anim_AggressorTieUp(akActor)
	Logtrace("OnTieupAnimation end Target is "+akActor)
EndEvent

Function SendUntieAnimationEvent(Actor akTarget, string msg="")
	if !DOMCore.sendDOMCaptureEvent
		OnUntieAnimation(akTarget,msg)
		return
	endif
	string eventName = "DOM_UntieAnimation"
    int handle = ModEvent.Create(eventName)
    if (handle)
		LogTrace("SendUntieAnimationEvent Registering event SUCCESS "+eventName)
		ModEvent.PushForm(handle, akTarget)
		ModEvent.PushString(handle, msg)
        ModEvent.Send(handle)
	else
		LogInfo("ERROR: SendUntieAnimationEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function RegisterForUntieAnimationEvent()
	RegisterForModEvent("DOM_UntieAnimation", "OnUntieAnimation")
EndFunction

Function UnRegisterForUntieAnimationEvent()
	UnregisterForModEvent("DOM_UntieAnimation")
EndFunction

Event OnUntieAnimation(Form akTarget, string msg)
	Actor akActor = akTarget as Actor
	Logtrace("OnUntieAnimation start Target is "+akActor.GetDisplaYName()+" is_unconscious="+akActor.IsUnconscious())
	if akActor == None
		return
	endif
	if akActor.isDead()
		return
	endif
	if msg != ""
		HudNotification(msg)	
	endif
	Anim_AggressorUntie(akActor)
	Logtrace("OnUntieAnimation end Target is "+akActor)
EndEvent

; ### Put in bag

Function DOMDoPutInBag(Actor akTarget)
	if akTarget == None
		return
	endif
	if debugKeyMode
		HudNotification("Put in bag "+akTarget.getDisplayName())
	endif
	DOMDoPutInBagActor(akTarget,PlayerRef,true)
EndFunction

Function DOMDoPutInBagActor(Actor akTarget, Actor akAnotherActor, bool do_alert)
	bool isValid = (akTarget.HasKeyWord(ActorTypeNPC) || akTarget.HasKeyWord(ActorTypeCreature)) && !akTarget.IsChild()
	if !isValid || akTarget.IsOnMount()
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		if !sl_alias.canAnimate
			return
		endif
		if sl_alias.IsInTraining()
			return
		endif
	elseif do_alert && !DOMCore.isASlave(akTarget)
		if isRescuedByWitness(akTarget,alarmToggleWitness3)
			return
		endif
	endif
	;if akAnotherActor != None
	;	SendTieupAnimationEvent(akAnotherActor)
	;endif
	
	;LogTrace("DOMDoPutInBagActor: Sack form = "+DOMBurlapSack)
	DOM_BurlapSack objSack = akAnotherActor.PlaceAtMe(DOMBurlapSack) as DOM_BurlapSack
	objSack.SetDisplayName("Sack with "+akTarget.GetDisplayName(),true)
	objSack.SetVictim(akTarget)
	objSack.SetActorOwner(None)
	Logtrace("DOMDoPutInBagActor: Sack filled with actor="+akTarget)

	if sl_alias != None ; store behaviour
		if sl_alias.behaviour == "restrained_in_furniture"
			objSack.SetBehaviour("tied")
		else
			objSack.SetBehaviour(sl_alias.behaviour)
		endif
		sl_alias.the_bag_iam_in = objSack
		sl_alias.behaviour = "wait_in_bag"
	elseif DOMPAH.isPAH(akTarget)
		DOMPAH.DoPutInBagActor(objSack,akTarget)
	else
		akTarget.SetFactionRank(DOMCore.DOMActionInContainer,1)
		TrainNb(akTarget,DOMCore.DOMNbBondage)
	endif
	akTarget.Moveto(DOMTonyMarker) ; Put actor some where that is nowhere
	akAnotherActor.AddItem(objSack)
EndFunction

Function DOMDoPutInBagInPlace(Actor akTarget, Actor akAnotherActor)
	LogTrace("DOMDoPutInBagInPlace objSack="+objSack)
	bool isValid = (akTarget.HasKeyWord(ActorTypeNPC) || akTarget.HasKeyWord(ActorTypeCreature)) && !akTarget.IsChild()
	if !isValid || akTarget.IsOnMount()
		return
	endif
	DOM_Actor sl_alias = DOMCore.GetActor(akTarget)
	if sl_alias != None
		if !sl_alias.canAnimate
			return
		endif
		if sl_alias.IsInTraining()
			return
		endif
	elseif !DOMCore.isASlave(akTarget)
		if isRescuedByWitness(akTarget,alarmToggleWitness3)
			return
		endif
	endif
	if akAnotherActor != None
		SendTieupAnimationEvent(akAnotherActor)
	endif
	
	;LogTrace("DOMDoPutInBagInPlace: Sack form = "+DOMBurlapSack)
	DOM_BurlapSack objSack = akTarget.PlaceAtMe(DOMBurlapSack) as DOM_BurlapSack
	objSack.SetDisplayName("Sack with "+akTarget.GetDisplayName(),true)
	objSack.SetVictim(akTarget)
	objSack.SetActorOwner(None)
	Logtrace("DOMDoPutInBagInPlace: Sack fill in with actor="+akTarget)

	if sl_alias != None ; store behaviour
		if sl_alias.behaviour == "restrained_in_furniture"
			objSack.SetBehaviour("tied")
		else
			objSack.SetBehaviour(sl_alias.behaviour)
		endif
		sl_alias.the_bag_iam_in = objSack
		sl_alias.behaviour = "wait_in_bag"
	elseif DOMPAH.isPAH(akTarget)
		DOMPAH.DoPutInBagActor(objSack,akTarget)
	else
		akTarget.SetFactionRank(DOMCore.DOMActionInContainer,1)
		TrainNb(akTarget,DOMCore.DOMNbBondage)
	endif
	akTarget.Moveto(DOMTonyMarker) ; Put actor some where that is nowhere
	if sl_alias != None
		sl_alias.SendExternalEventS("InBag")
	endif
EndFunction

Function DOMPickUpBag(Actor akAnotherActor, DOM_BurlapSack objSack)
	LogTrace("DOMPickUpBag akAnotherActor="+akAnotherActor+" objSack="+objSack)
	akAnotherActor.AddItem(objSack)
EndFunction

Function DOMDoTakeOutOfBag(Actor akAnotherActor, DOM_BurlapSack objSack, bool do_tieup = false, bool do_anim_abuser=true)
	LogTrace("DOMDoTakeOutOfBag akAnotherActor="+akAnotherActor+" objSack="+objSack)
	if objSack==None || !objSack.HasKeyWord(BodyBag)
		Logtrace("DOMDoTakeOutOfBag: Sack in inventory="+akAnotherActor.GetItemCount(DOMBurlapSack))
		if akAnotherActor.GetItemCount(DOMBurlapSack) <= 0
			return
		endif
		;objSack = (akAnotherActor.DropObject(DOMBurlapSack)) as DOM_BurlapSack
		;Wait(1.0)
		;objSack.MoveTo(akAnotherActor, 64.0 * Math.Sin(akAnotherActor.GetAngleZ()), 64.0 * Math.Cos(akAnotherActor.GetAngleZ()), 5.0)
		;Logtrace("Sack dropped="+objSack.getDisplayName())
		return
	endif
	if objSack==None
		return
	endif
	ObjectReference the_ref
	if objSack.GetContainer() != None
		LogTrace("DOMDoTakeOutOfBag: WARNING Object is in container="+objSack.GetContainer())
		the_ref = akAnotherActor
	else
		the_ref = objSack
	endif
	Actor akRef = objSack.GetVictim()
	if akRef == None
		LogTrace("DOMDoTakeOutOfBag: ERROR victim=None")
		return
	endif
	if debugKeyMode
		HudNotification("Take out of bag "+akRef.getDisplayName())
	endif
	if akRef.IsInFaction(DOMActionTied)
		do_tieup = true
	endif
	if do_anim_abuser && (akAnotherActor != PlayerRef || DOMCore.doAnimPlayerTieup)
		LogTrace("DOMDoTakeOutOfBag: DOMTyingUpAnim on akAnotherActor="+akAnotherActor)
		SendAnimation(akAnotherActor, "DOMTyingUpAnim")
	endif
	objSack.SetVictim(None)
	objSack.SetDisplayName("Empty sack",true)
	
	bool is_unconscious = (akRef.GetSleepState() == 3) || (akRef.IsUnconscious())
	Logtrace("DOMDoTakeOutOfBag: Sack contains actor="+akRef.GetDisplayName()+" is_unconscious="+akRef.IsUnconscious()+" sleep="+akRef.GetSleepState()+" => "+is_unconscious)

	akRef.SetAlpha(0.0)
		
	DOM_Actor sl_alias = DOMCore.GetActor(akRef)
	if sl_alias != None
		if do_tieup
			sl_alias.EnterTieup(akAnotherActor)
			DOMDoEquipGag(akRef)
		else
			string beh = objSack.GetBehaviour()
			if beh != ""
				sl_alias.behaviour = beh
			else
				sl_alias.EnterWait()
			endif
		endif
	elseif DOMPAH.isPAH(akRef)
		DOMPAH.DoTakeOutOfBag(objSack,akRef,do_tieup)
	else
		akRef.RemoveFromFaction(DOMCore.DOMActionInContainer)
		if do_tieup
			DOMTieupActor(akRef,akAnotherActor) 
		else
			DOMUntieActor(akRef,akAnotherActor)
		endif
	endif

	Wait(1.0)

	akRef.MoveTo(the_ref, 64.0 * Math.Sin(the_ref.GetAngleZ()), 64.0 * Math.Cos(the_ref.GetAngleZ()), the_ref.GetHeight()/2.0+32.0)
	float zOffset = akRef.GetHeadingAngle(the_ref)
	akRef.SetAngle(akRef.GetAngleX(), akRef.GetAngleY(), akRef.GetAngleZ() + zOffset)

	bool isADOMActor = (sl_alias != None) || DOMPAH.isPAH(akRef)
	if !isADOMActor
		if do_tieup
			LogTrace("DOMDoTakeOutOfBag do_tieup="+do_tieup+" isADOMActor="+isADOMActor)
			akRef.SetLookAt(akAnotherActor)
			Anim_VictimTieUp(akRef,akRef.GetFactionRank(DOMActionTied))
		endif
	
		if akAnotherActor == PlayerRef && !akRef.IsInFaction(DOMActorExcludedFaction) && !akRef.IsInFaction(DOMActionTied) && alarmToggleAbduction2 && !is_unconscious ; non slave actors might react by calling for help or attacking the player
			DOMCore.SayTopic(akRef,DOM02TopicAnswerAttack)
			int rank = akRef.GetRelationshipRank(PlayerRef)
			if rank <= 2
				isRescuedByWitness(akRef,alarmToggleWitness3)
				akRef.SetLookAt(playerRef, true)
				if rank <= 1
					if TryActorSendAssaultAlarm(akRef)
						LogTrace("DOMDoTakeOutOfBag SendAssaultAlarm SUCCESS "+akRef.GetDisplayName())
					else
						LogTrace("DOMDoTakeOutOfBag SendAssaultAlarm FAILURE "+akRef.GetDisplayName())
					endif
					akRef.StartCombat(playerRef)
				endif
			endif
			if rank < 4 ; not LOVER
				akRef.SetRelationshipRank(PlayerRef,rank-(1))
			endif
		endif
	endif

	if !isADOMActor && do_tieup
		Anim_VictimTieUp(akRef,akRef.GetFactionRank(DOMActionTied))
	endif
	Wait(2.0)
	if !isADOMActor && do_tieup
		Anim_VictimTieUp(akRef,akRef.GetFactionRank(DOMActionTied))
	endif
	akRef.SetAlpha(1.0)
	Wait(1.0)
	objSack.Delete()
	if !isADOMActor && do_tieup
		Anim_VictimTieUp(akRef,akRef.GetFactionRank(DOMActionTied))
	endif
EndFunction

int Function DOMDoClearActorSpells(Actor akTarget, bool do_message=true)
	if akTarget == None
		return -1
	endif
	ActorBase abTarget = akTarget.GetLeveledActorBase()
	if abTarget == None
		LogTrace("DOMDoClearActorSpells found actor "+akTarget.GetDisplayName())
	else
		LogTrace("DOMDoClearActorSpells found actor "+akTarget.GetDisplayName()+" base "+abTarget.GetName())
	endif 
	int n = akTarget.GetSpellCount ()
	LogTrace("DOMDoClearActorSpells found "+n+" spells for actor "+akTarget.GetDisplayName())
	if n <= 0
		return 0
	endif
	int i = 0
	int k = 0
	while i < n
		Spell the_spell = akTarget.GetNthSpell(i)
		if the_spell != None
			akTarget.RemoveSpell(the_spell)
			k += 1
			LogTrace("DOMDoClearActorSpells removed spell "+k+"/"+n+" "+the_spell.GetName()+" for actor "+akTarget.GetDisplayName())
		endif
		i += 1
	endwhile
	return k
EndFunction

int Function DOMDoClearActorBaseSpells(Actor akTarget)
	if akTarget == None
		return -1
	endif
	ActorBase abTarget = akTarget.GetLeveledActorBase()
	if abTarget == None
		return 0
	endif 
	LogTrace("DOMDoClearActorBaseSpells found actor "+akTarget.GetDisplayName()+" base "+abTarget.GetName())
	int n = abTarget.GetSpellCount ()
	LogTrace("DOMDoClearActorBaseSpells found "+n+" spells for actor base "+abTarget.GetName())
	if n <= 0
		return 0
	endif
	int i = 0
	int k = 0
	while i < n
		Spell the_spell = abTarget.GetNthSpell(i)
		if the_spell != None
			akTarget.RemoveSpell(the_spell)
				k += 1
			LogTrace("DOMDoClearActorBaseSpells removed spell "+k+"/"+n+" "+the_spell.GetName()+" on actor base "+abTarget.GetName()+" for actor "+akTarget.GetDisplayName())
		endif
		i += 1
	endwhile
	return k
EndFunction

; Utils

Function HudNotification(string msg)
	Debug.Notification(msg)
	;if DOMCore.verboseMode
	;	Debug.Trace("DOM_Keys: "+msg)
	;endif
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Keys: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_Keys: "+msg)
	endif
EndFunction

Function LogAnim(string msg)
	if DOMCore.verboseAnim
		Debug.Trace("DOM_Keys:Animation: "+msg)
	endif
EndFunction

Function LogTopic(Actor akSpeaker, Topic topic_to_say)
	if DOMCore.verboseTopics
		Debug.Trace("DOM_Keys:Topic: "+akSpeaker.GetDisplayName()+": says: "+topic_to_say)
	endif
EndFunction
