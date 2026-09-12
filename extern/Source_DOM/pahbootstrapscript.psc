Scriptname PAHBootstrapScript extends Quest

PAHCore Property PAH Auto
Perk Property PAHEnslavePerk Auto
; Perk Property PAHEnslaveFollowerPerk Auto
Perk Property PAHEnslaveCancelPerk Auto

;# PAHCore
Quest Property MQ101 Auto
Quest Property PAHRebootQuest Auto

Quest Property PAHPersonalityGeneric Auto
Quest Property PAHPersonalityEvenToned Auto
Quest Property PAHPersonalityArgonian Auto
Quest Property PAHPersonalityNord Auto
Quest Property PAHPersonalityYoungEager Auto
Quest Property PAHPersonalityCondescending Auto
Quest Property PAHPersonalityFemaleSultry Auto

ReferenceAlias[] Property slave_aliases Auto
ReferenceAlias[] Property target_aliases Auto
ReferenceAlias[] Property reboot_aliases Auto

;need to clean the backpacks from the master file -- later***********
Actor[] Property backpack_mules Auto

PAHClonifierBaseScript Property clonifier Auto

PAHPersonalityDefinition[] Property personality_definitions Auto
PAHPersonalityDefinition Property default_male_personality_definition Auto
PAHPersonalityDefinition Property default_female_personality_definition Auto

Actor Property actor_stub Auto
;*************** remnants of the backpack system improperly named to be fixed later*********
ReferenceAlias Property pah_stub Auto	;--Do Not delete or comment this is core function
;**********

Faction Property PAHCleaned Auto

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

ObjectReference Property CloneMarker Auto

Static Property XMarkerHeading Auto

Outfit Property PAHNothingOutfit Auto

Armor Property CuffsRope Auto
Armor Property zbfCuffsLeatherBinds Auto
Armor Property CuffsIron Auto
Armor Property CuffsIronBrown Auto
Armor Property CuffsSimpleBlack Auto
Armor Property CuffsSimpleBrown Auto
Armor Property WristLeather Auto
Armor Property WristIron Auto
Armor Property AnkleLeather Auto
Armor Property AnkleIron Auto

Spell Property WhistleSpell Auto
Spell Property CaptureSpell Auto

;# Actor Alias

Faction Property PAHAccompanyingPlayer Auto

Faction Property PAHAAUseCOPackage Auto
Faction Property PAHAAUseIdleMarker Auto
Faction Property PAHAAFleeFrom Auto
Faction Property PAHAAFollow Auto
Faction Property PAHAAStandStill Auto
Faction Property PAHAASandboxAtTarget Auto

Weapon Property PAHWhip Auto
Armor Property PAHSlaveCollar Auto
Armor Property PAHIronSlaveCollarLeashing Auto

Idle Property IdleCoweringLoose Auto
Form Property PAHCowerIdleMarker Auto
Idle Property IdleOffsetArmsCrossedStart Auto
Idle Property IdleWarmArms Auto
Idle Property IdleNervous Auto
Idle Property IdleCivilWarCheer Auto
Idle Property IdleWipeBrow Auto

Faction Property PAHNaked Auto
Faction Property PAHLeashed Auto

Cell Property AbandonedPrison01 Auto
Location Property HelgenLocation Auto	;Helgen

Keyword Property ArmorCuirass Auto
Keyword Property ClothingBody Auto
Keyword Property ArmorShield Auto
Keyword Property PAHRestraint Auto
Keyword Property PAHRestraintLeash Auto
Keyword Property PAHCountsAsNaked Auto

Spell Property PAHLeashSpell Auto

Static Property XMarker Auto


;# PAHSlave

Faction Property PlayerFaction Auto
Faction Property PAHPlayerSlaveFaction Auto

Faction Property PAHBEFollowing Auto
Faction Property PAHBEWaiting Auto
Faction Property PAHBEFleeingAndCowering Auto
Faction Property PAHBERunningAway Auto
Faction Property PAHBEWaitingAtLeashPoint Auto

Faction Property PAHSubmission Auto
Faction Property PAHTrainCombat Auto
Faction Property PAHTrainAnger Auto
Faction Property PAHTrainRespect Auto
Faction Property PAHTrainPose Auto
Faction Property PAHTrainSex Auto
Faction Property PAHTrainAnal Auto
Faction Property PAHTrainOral Auto
Faction Property PAHTrainVaginal Auto
Faction Property PAHTrainFear Auto


Faction Property PAHShouldBeRespectful Auto
Faction Property PAHShouldFightForPlayer Auto
Faction Property PAHShouldPose Auto

Faction Property PAHRespectful Auto
Faction Property PAHBETied Auto
Faction Property PAHBECalm Auto

Faction Property PAHSDMadeNaked Auto
Faction Property PAHSDClothedFromNaked Auto
Faction Property PAHSDArmorAdded Auto
Faction Property PAHSDWeaponAdded Auto
Faction Property PAHSDWeaponRemoved Auto
Faction Property PAHSDRestraintAdded Auto
Faction Property PAHSDRestraintRemoved Auto
Faction Property PAHSDFailedToFight Auto
Faction Property PAHSDFailedToPose Auto

Keyword Property PAHPaingiver Auto


;# PAHSlaveMind

Faction Property PAHPersonalityGenerated Auto

Float spontaneous_anger_submission_cap = 50.0
Float base_chance_attack_player = 0.5
Float base_chance_run_away = 0.5
Float run_away_submission_cap = 40.0

Faction Property PAHMoodAngry Auto
Faction Property PAHMoodAfraid Auto
Faction Property PAHMoodNeutral Auto
Faction Property PAHMoodJustCaptured Auto

Faction Property PAHTraitAngerRating Auto
Faction Property PAHTraitFearRating Auto

String[] nameArray

;# Bootstrap only

Actor Property player Auto

Spell Property PAHInfoSpell Auto
;Spell Property PAHBoostSubmissionSpell Auto
Spell Property PAHDropSubmissionSpell Auto
Spell Property PAHTestSpell Auto
Spell Property PAHLeashToSpell Auto
Spell Property PAHRebootSpell Auto

Event OnInit()
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
	if !player
		player = Game.GetPlayer()
	EndIf
	If (Game.GetModByName("paradise_halls_SLExtension.esp") == 255)
		Debug.Notification("paradise_halls_SLExtension.esp required!")
		Debug.trace("user has pahcore loaded without Pahe")
		while (Game.GetModByName("paradise_halls_SLExtension.esp") == 255)
			Debug.Notification("paradise_halls_SLExtension.esp required!")
			Debug.Notification(", quit without save!!")
			Utility.Wait(0.2)
		EndWhile
	EndIf
	If MQ101.IsObjectiveCompleted(50)
		Utility.Wait(0.2)
		Boot()
	elseIf (PAH.IsStopped() && (player.GetParentCell() == (AbandonedPrison01)))
		Debug.Notification("Paradise Halls: waiting for mods to load")
		Utility.Wait(39.9)
		Boot()
	elseIf (PAH.IsStopped() && (player.GetCurrentLocation() == (HelgenLocation)))
		Debug.Notification("Paradise Halls: waiting for mods to load")
		Utility.Wait(39.9)
		Boot()
	else

		RegisterForSingleUpdate(2.0)
	EndIf
EndEvent

Event OnPlayerLoadGame()
;Event OnLoad()
	if !player
		player = Game.GetPlayer()
	EndIf
	If PAH.IsStopped()
		Debug.Notification("Paradise Halls IsStopped please wait")
		Utility.Wait(49.9)
		Boot()
	else
		RegisterForSingleUpdate(2.0)
	EndIf
EndEvent

Function Boot()
	if !player
		player = Game.GetPlayer()
	EndIf
	bool isActive
	PAH.modStatus = "restarting"
	Debug.Notification("Paradise Halls: Testing System")
	TestSKSE()
	If PAH.IsRunning()
		isActive = PAH.isActive()
		Debug.Notification("Paradise Halls: Restarting Quest")
		RestartQuests()
	else
		Debug.Notification("Paradise Halls: Starting Quest")
	EndIf
	EnsureStartedUp()
	Debug.Notification("Paradise Halls: Setting Properties")
	PAH.CheckPlayerGender(player)
	SetProperties()
	Debug.Notification("Paradise Halls: Finalizing Slaves")
	SendBootstrapEvents()
	AddItems()
	PAH.SetActive(isActive)
	PAH.registerKeys()
	Debug.Notification("Paradise Halls: Boot process finished")
	PAH.modStatus = "running"
EndFunction

Function TestSKSE()
	If Game.GetPlayer().GetNthForm(0) != None
	else
		Debug.MessageBox("Paradise Halls: SKSE is not installed or has been corrupted. Please ensure you are running Skyrim with skse_loader.exe. Failing that reinstall SKSE being sure to copy all SKSE scripts over everything in your /skyrim/data/scripts folder.")
	EndIf
EndFunction

Function RestartQuests()
	EnsureQuestStarted(PAHRebootQuest)

	int arrayLength = PAH.slaveArray.length
	int core_index = 0
	int boot_index = 0
	nameArray = PAH.GetStringArrayLength(arrayLength)
	PAHSlave[] slave_array = PAH.slaveArray
	int steps = 1 
	if arrayLength >= 4
		steps = arrayLength / 4
	elseif arrayLength <= 3
		steps = 1 
	EndIf
	steps = PAH.getMin(steps, 6) as Int
	int percent = 100/steps
	int process = 0
	While (core_index < arrayLength)
		If core_index == steps || core_index == steps * 2 || core_index == steps * 3 || core_index == steps * 4 || core_index == steps * 5
			process += percent
			Debug.Notification("Paradise Halls: Saving " + process + "% of slaves.")
		EndIf
		Actor slave = PAH.slaveArray[core_index].GetActorRef()
		If slave != None
			String name = slave.getName()
			If name == "slave" || name == ""
				name = PAH.getSlaveName(boot_index)
			EndIf
			nameArray[boot_index] = name
			reboot_aliases[boot_index].ForceRefTo(slave)
			slave.EvaluatePackage()
			boot_index += 1
		EndIf
		core_index += 1
	EndWhile
	Debug.Notification("Paradise Halls: Saving slaves done.")
	StopQuest(PAH)

	EnsureQuestStarted(PAH)

	int j = 0
	steps = boot_index / 4
	process = 0
	While (j < boot_index)
		If j == steps || j == steps * 2 || j == steps * 3 || j == steps * 4 || j == steps * 5
			process += percent
			Debug.Notification("Paradise Halls: Restoring " + process + "% of slaves.")
		EndIf
		Actor slave = reboot_aliases[j].GetActorRef()
		If slave != None
			PAH.AddSlave(slave)
			slave.ignoreFriendlyHits(true)
			reboot_aliases[j].clear()
			slave.EvaluatePackage()
		EndIf
		j += 1
	EndWhile
	Debug.Notification("Paradise Halls: Restoring slaves done.")

	StopQuest(PAHRebootQuest)
	PAH.UpdateSlaveCount()
EndFunction

Function EnsureStartedUp()
	EnsureQuestStarted(PAH)
	int j = 0
	While (j < personality_definitions.length)
		j += 1
	EndWhile
	int i = 0
	While (i < personality_definitions.length)
		EnsureQuestStarted(personality_definitions[i])
		i += 1
	EndWhile
	EnsureQuestStarted(PAHPersonalityEvenToned)
	EnsureQuestStarted(PAHPersonalityGeneric)

;**********fix these quests before starting
;	EnsureQuestStarted(PAHPersonalityArgonian)
    	If (PAHPersonalityNord == None)
        	PAHPersonalityNord = (Game.GetFormFromFile(0x0261BB, "paradise_halls_SLExtension.esp") as Quest)
		Debug.Notification("[PAHBoot] warning Nord quest detected as none")
    	EndIf
	If PAHPersonalityNord != None
		EnsureQuestStarted(PAHPersonalityNord)
	EndIf
	If (PAHPersonalityYoungEager == None)
		PAHPersonalityYoungEager = (Game.GetFormFromFile(0x00EB14, "paradise_halls_SLExtension.esp") as Quest)
		Debug.Notification("[PAHBoot] warning young eager quest detected as none")
	EndIf
	If PAHPersonalityYoungEager != None
		EnsureQuestStarted(PAHPersonalityYoungEager)
	EndIf
    	If (PAHPersonalityCondescending == None)
        	PAHPersonalityCondescending = (Game.GetFormFromFile(0x00F0A1, "paradise_halls_SLExtension.esp") as Quest)
		Debug.Notification("[PAHBoot] warning Condescending quest detected as none")
    	EndIf
	If PAHPersonalityCondescending != None
		EnsureQuestStarted(PAHPersonalityCondescending)
	EndIf
    	If (PAHPersonalityFemaleSultry == None)
        	PAHPersonalityFemaleSultry = (Game.GetFormFromFile(0x02C44F, "paradise_halls_SLExtension.esp") as Quest)
		Debug.Notification("[PAHBoot] warning Sultry quest detected as none")
    	EndIf
	If PAHPersonalityNord != None
		EnsureQuestStarted(PAHPersonalityFemaleSultry)
	EndIf


EndFunction

Function StopQuest(Quest the_quest)
	the_quest.SetActive(false)
	the_quest.Stop()
	While !the_quest.IsStopped()
		Utility.Wait(0.2)
	EndWhile
EndFunction

Function EnsureQuestStarted(Quest the_quest)
	the_quest.SetActive(true)
	the_quest.Start()
	While (!the_quest.IsRunning() || the_quest.IsStarting())
		Utility.Wait(0.2)
	EndWhile
EndFunction

Function SetProperties()
	PAH.slave_aliases = slave_aliases
	PAH.clonifier = clonifier
	PAH.personality_definitions = personality_definitions
	PAH.default_male_personality_definition = default_male_personality_definition
	PAH.default_female_personality_definition = default_female_personality_definition
	PAH.PAHWhip = PAHWhip
	PAH.PAHCleaned = PAHCleaned
	PAH.PAH0to9Zone = PAH0to9Zone
	PAH.PAH10to19Zone = PAH10to19Zone
	PAH.PAH20to29Zone = PAH20to29Zone
	PAH.PAH30to39Zone = PAH30to39Zone
	PAH.PAH40to49Zone = PAH40to49Zone
	PAH.PAH50to59Zone = PAH50to59Zone
	PAH.PAH60to69Zone = PAH60to69Zone
	PAH.PAH70to79Zone = PAH70to79Zone
	PAH.PAH80to89Zone = PAH80to89Zone
	PAH.PAH90to99Zone = PAH90to99Zone
	PAH.PAH100to109Zone = PAH100to109Zone
	PAH.PAH110to119Zone = PAH110to119Zone
	PAH.PAH120to129Zone = PAH120to129Zone
	PAH.PAH130to139Zone = PAH130to139Zone
	PAH.PAH140to149Zone = PAH140to149Zone
	PAH.PAH150to159Zone = PAH150to159Zone
	PAH.PAH160to169Zone = PAH160to169Zone
	PAH.PAH170to179Zone = PAH170to179Zone
	PAH.PAH180to189Zone = PAH180to189Zone
	PAH.PAH190to199Zone = PAH190to199Zone
	PAH.PAH200PlusZone = PAH200PlusZone
	PAH.CloneMarker = CloneMarker
	PAH.XMarkerHeading = XMarkerHeading
	PAH.PAHNothingOutfit = PAHNothingOutfit
	PAH.WhistleSpell = WhistleSpell   
	PAH.CaptureSpell = CaptureSpell
	
	PAH.CuffsRope = CuffsRope
	PAH.CuffsLeather = zbfCuffsLeatherBinds
	PAH.CuffsIron = CuffsIron
	PAH.CuffsIronBrown = CuffsIronBrown
	PAH.CuffsSimpleBlack = CuffsSimpleBlack
	PAH.CuffsSimpleBrown = CuffsSimpleBrown
	PAH.WristLeather = WristLeather
	PAH.WristIron = WristIron
	PAH.AnkleLeather = AnkleLeather
	PAH.AnkleIron = AnkleIron
	
	Debug.Notification("Paradise Halls: Core properties restored.")

	PAHActorAlias actor_alias
	PAHSlave slave
	PAHSlaveMind slave_mind
	int i = 0
	int slaveCount = PAH.GetSlaveCount()
	int steps = slaveCount / 4
	int process = 0
	While (i < slaveCount)
		If i == steps || i == steps * 2 || i == slaveCount - steps || i == slaveCount - 1
			process += 25
			Debug.Notification("Paradise Halls: Processing " + process + "% of slave properties.")
		EndIf
;************************************Actor**************************************
		actor_alias = PAH.slave_aliases[i] as PAHActorAlias

		actor_alias.PAH = PAH
;*************** remnants of the backpack system improperly named to be fixed later*********
		actor_alias.actor_stub = actor_stub
		actor_alias.slave_stub = pah_stub as PAHSlave
;************
		actor_alias.mind_stub = pah_stub as PAHSlaveMind
		actor_alias.PAHAccompanyingPlayer = PAHAccompanyingPlayer
		actor_alias.PAHAAUseCOPackage = PAHAAUseCOPackage
		actor_alias.PAHAAUseIdleMarker = PAHAAUseIdleMarker
		actor_alias.PAHAAFleeFrom = PAHAAFleeFrom
		actor_alias.PAHAAFollow = PAHAAFollow
		actor_alias.PAHAAStandStill = PAHAAStandStill
		actor_alias.PAHAASandboxAtTarget = PAHAASandboxAtTarget
		actor_alias.PAHCowerIdleMarker = PAHCowerIdleMarker
		actor_alias.IdleCoweringLoose = IdleCoweringLoose
		actor_alias.IdleOffsetArmsCrossedStart = IdleOffsetArmsCrossedStart
		actor_alias.IdleWarmArms = IdleWarmArms
		actor_alias.IdleNervous = IdleNervous
		actor_alias.IdleCivilWarCheer = IdleCivilWarCheer
		actor_alias.IdleWipeBrow = IdleWipeBrow
		actor_alias.PAHNaked = PAHNaked
		actor_alias.PAHLeashed = PAHLeashed
		actor_alias.ArmorCuirass = ArmorCuirass
		actor_alias.ClothingBody = ClothingBody
		actor_alias.ArmorShield = ArmorShield
		actor_alias.PAHRestraint = PAHRestraint
		actor_alias.PAHRestraintLeash = PAHRestraintLeash
		actor_alias.PAHCountsAsNaked = PAHCountsAsNaked
		actor_alias.PAHLeashSpell = PAHLeashSpell
		actor_alias.XMarker = XMarker

		actor_alias.target_alias = target_aliases[i]
		actor_alias.RegisterForModEvent("PAHBootstrap", "OnBootstrap")

;************************************Slave**************************************
		slave = PAH.slave_aliases[i] as PAHSlave

		slave.PAH = PAH
		slave.pah_stub = pah_stub
		slave.PlayerFaction = PlayerFaction
		slave.PAHPlayerSlaveFaction = PAHPlayerSlaveFaction
		slave.PAHBEFollowing = PAHBEFollowing
		slave.PAHBEWaiting = PAHBEWaiting
		slave.PAHBEFleeingAndCowering = PAHBEFleeingAndCowering
		slave.PAHBERunningAway = PAHBERunningAway
		slave.PAHBEWaitingAtLeashPoint = PAHBEWaitingAtLeashPoint
		slave.PAHBETied = PAHBETied
		slave.PAHBECalm = PAHBECalm
		slave.PAHSubmission = PAHSubmission
		slave.PAH.PAHTrainFear = PAHTrainFear

		slave.PAHTrainCombat = PAHTrainCombat
		slave.PAHTrainAnger = PAHTrainAnger
		slave.PAHTrainRespect = PAHTrainRespect
		slave.PAHTrainPose = PAHTrainPose
		slave.PAH.PAHTrainSex = PAHTrainSex
		slave.PAH.PAHTrainOral = PAHTrainOral
		slave.PAH.PAHTrainVaginal = PAHTrainVaginal
		slave.PAH.PAHTrainAnal = PAHTrainAnal
		slave.PAHShouldBeRespectful = PAHShouldBeRespectful
		slave.PAHShouldFightForPlayer = PAHShouldFightForPlayer
		slave.PAHShouldPose = PAHShouldPose
		slave.PAHRespectful = PAHRespectful
		slave.PAHSDMadeNaked = PAHSDMadeNaked
		slave.PAHSDClothedFromNaked = PAHSDClothedFromNaked
		slave.PAHSDArmorAdded = PAHSDArmorAdded
		slave.PAHSDWeaponAdded = PAHSDWeaponAdded
		slave.PAHSDWeaponRemoved = PAHSDWeaponRemoved
		slave.PAHSDRestraintAdded = PAHSDRestraintAdded
		slave.PAHSDRestraintRemoved = PAHSDRestraintRemoved
		slave.PAHSDFailedToFight = PAHSDFailedToFight
		slave.PAHSDFailedToPose = PAHSDFailedToPose

		slave.PAHRestraint = PAHRestraint
		slave.PAHPaingiver = PAHPaingiver

		slave.RegisterForModEvent("PAHBootstrap", "OnBootstrap")

		slave.PAHLeashToSpell = PAHLeashToSpell
		slave.setDisplayName(nameArray[i])
;*************************************Mind**************************************
		slave_mind = PAH.slave_aliases[i] as PAHSlaveMind

		slave_mind.PAH = PAH
		slave_mind.PAHPersonalityGenerated = PAHPersonalityGenerated
		slave_mind.PAHMoodAngry = PAHMoodAngry
		slave_mind.PAHMoodAfraid = PAHMoodAfraid
		slave_mind.PAHMoodNeutral = PAHMoodNeutral
		slave_mind.PAHMoodJustCaptured = PAHMoodJustCaptured
		slave_mind.PAHTraitAngerRating = PAHTraitAngerRating
		slave_mind.PAHTraitFearRating = PAHTraitFearRating

		slave_mind.RegisterForModEvent("PAHBootstrap", "OnBootstrap")

		PAH.slave_aliases[i].GetActorRef().EvaluatePackage()
		i += 1
	EndWhile
EndFunction

Function SendBootstrapEvents()
	PAH.OnBootstrap()
	int i = 0
	SendModEvent("PAHBootstrap")
EndFunction

Function AddItems()
	int i = 0
	while i < PAH.EnslavePerks.Length
		Game.GetPlayer().AddPerk(PAH.EnslavePerks[i])
		i += 1
	EndWhile
	Game.GetPlayer().AddPerk(PAHEnslaveCancelPerk)
;	If !PAH.Config.EnslaveFollowerToggle
;		Game.GetPlayer().RemovePerk(PAHEnslaveFollowerPerk)
;	else
;		Game.GetPlayer().AddPerk(PAHEnslaveFollowerPerk)
;	endIf
	
	If (PAH.Config.statSpellToggle)
		Game.GetPlayer().AddSpell(PAHInfoSpell, true)
	EndIf
EndFunction

Function FreeAllSlaves()
	int i = 0
	While (i < PAH.slave_aliases.length)
		PAH.RemoveSlave(PAH.slave_aliases[i])
		i += 1
	EndWhile
EndFunction
