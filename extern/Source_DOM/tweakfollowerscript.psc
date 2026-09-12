Scriptname TweakFollowerScript extends Quest Conditional

int property command auto
Faction Property CurrentFollowerFaction Auto
Faction Property PlayerFaction Auto
Faction Property WerewolfFaction Auto
Faction Property PlayerHorseFaction Auto
Faction Property TweakCurrentHorseFaction Auto
Faction Property TweakDisableMagicFaction Auto
Faction Property TweakUseWerewolfFaction Auto
Faction Property TweakUseStaffFaction Auto
Faction Property TweakHelmetCombatOnlyFaction Auto
Faction Property TweakManagedInventoryFaction Auto
Faction Property TweakHasVLGift Auto
Faction Property TweakFarFaction Auto ; 1.6
Faction	Property pTweakImportFaction			Auto ; 1.6
Faction	Property pTweakPotentialFollowerFaction			Auto ; 1.6
Package Property TweakFollowerPackageHorse Auto
Faction Property pTweakInStealth				Auto ; 1.6
Faction	Property TweakWerebearFaction	Auto ; 1.6
Faction Property TweakChattyFaction		Auto ; 1.63
Faction Property TweakDownFaction		Auto ; 1.65

Faction Property TweakHangoutFaction	Auto ; New 1.64
Faction Property TweakPosedFaction		Auto ; New 1.64
Faction Property TweakNoAutoRelax 		Auto ; New 1.64

Armor	Property TweakArmorVampireArmorRoyalRed	Auto ; DG Support

float Property version Auto

ReferenceAlias  Property pAlias1 Auto
ReferenceAlias  Property pAlias2 Auto
ReferenceAlias  Property pAlias3 Auto
ReferenceAlias  Property pAlias4 Auto
ReferenceAlias  Property pAlias5 Auto
ReferenceAlias  Property pAlias6 Auto
ReferenceAlias  Property pAlias7 Auto
ReferenceAlias  Property pAlias8 Auto
ReferenceAlias  Property pAlias9 Auto
ReferenceAlias  Property pAlias10 Auto
ReferenceAlias  Property pAlias11 Auto
ReferenceAlias  Property pAlias12 Auto
ReferenceAlias  Property pAlias13 Auto
ReferenceAlias  Property pAlias14 Auto
ReferenceAlias  Property pAlias15 Auto
ReferenceAlias  Property pAlias16 Auto
ReferenceAlias  Property pAlias17 Auto
ReferenceAlias  Property pAlias18 Auto
ReferenceAlias  Property pAlias19 Auto
ReferenceAlias  Property pAlias20 Auto
ReferenceAlias  Property pAlias21 Auto
ReferenceAlias  Property pAlias22 Auto
ReferenceAlias  Property pAlias23 Auto
ReferenceAlias  Property pAlias24 Auto
ReferenceAlias  Property pAlias25 Auto
ReferenceAlias  Property pAlias26 Auto
ReferenceAlias  Property pAlias27 Auto
ReferenceAlias  Property pAlias28 Auto
ReferenceAlias  Property pAlias29 Auto
ReferenceAlias  Property pAlias30 Auto
ReferenceAlias  Property pAlias31 Auto
ReferenceAlias  Property pAlias32 Auto
ReferenceAlias  Property pAlias33 Auto
ReferenceAlias  Property pAlias34 Auto
ReferenceAlias  Property pAlias35 Auto
ReferenceAlias  Property pAlias36 Auto
ReferenceAlias  Property pAlias37 Auto
ReferenceAlias  Property pAlias38 Auto
ReferenceAlias  Property pAlias39 Auto
ReferenceAlias  Property pAlias40 Auto
ReferenceAlias  Property pAlias41 Auto
ReferenceAlias  Property pAlias42 Auto
ReferenceAlias  Property pAlias43 Auto
ReferenceAlias  Property pAlias44 Auto
ReferenceAlias  Property pAlias45 Auto
ReferenceAlias  Property pAlias46 Auto
ReferenceAlias  Property pAlias47 Auto
ReferenceAlias  Property pAlias48 Auto
ReferenceAlias  Property pAlias49 Auto
ReferenceAlias  Property pAlias50 Auto
ReferenceAlias  Property pAlias51 Auto
ReferenceAlias  Property pAlias52 Auto
ReferenceAlias  Property pAlias53 Auto
ReferenceAlias  Property pAlias54 Auto
ReferenceAlias  Property pAlias55 Auto
ReferenceAlias  Property pAlias56 Auto
ReferenceAlias  Property pAlias57 Auto
ReferenceAlias  Property pAlias58 Auto
ReferenceAlias  Property pAlias59 Auto
ReferenceAlias  Property pAlias60 Auto
ReferenceAlias  Property pAlias61 Auto
ReferenceAlias  Property pAlias62 Auto
ReferenceAlias  Property pAlias63 Auto
ReferenceAlias  Property pAlias64 Auto
ReferenceAlias  Property pAlias65 Auto
ReferenceAlias  Property pAlias66 Auto
ReferenceAlias  Property pAlias67 Auto
ReferenceAlias  Property pAlias68 Auto
ReferenceAlias  Property pAlias69 Auto
ReferenceAlias  Property pAlias70 Auto
ReferenceAlias  Property pAlias71 Auto
ReferenceAlias  Property pAlias72 Auto
ReferenceAlias  Property pAlias73 Auto
ReferenceAlias  Property pAlias74 Auto
ReferenceAlias  Property pAlias75 Auto
ReferenceAlias  Property pAlias76 Auto
ReferenceAlias  Property pAlias77 Auto
ReferenceAlias  Property pAlias78 Auto
ReferenceAlias  Property pAlias79 Auto
ReferenceAlias  Property pAlias80 Auto
ReferenceAlias  Property pAlias81 Auto
ReferenceAlias  Property pAlias82 Auto
ReferenceAlias  Property pAlias83 Auto
ReferenceAlias  Property pAlias84 Auto
ReferenceAlias  Property pAlias85 Auto
ReferenceAlias  Property pAlias86 Auto
ReferenceAlias  Property pAlias87 Auto
ReferenceAlias  Property pAlias88 Auto
ReferenceAlias  Property pAlias89 Auto
ReferenceAlias  Property pAlias90 Auto
Int property tfCount Auto

; DialogueFollowerQuest
ReferenceAlias  Property pDFQRef1 Auto
ReferenceAlias  Property pDFQRef2 Auto
ReferenceAlias  Property pDFQRef3 Auto
ReferenceAlias  Property pDFQRef4 Auto
ReferenceAlias  Property pDFQRef5 Auto
ReferenceAlias  Property pDFQRef6 Auto
ReferenceAlias  Property pDFQRef7 Auto
ReferenceAlias  Property pDFQRef8 Auto
ReferenceAlias  Property pDFQRef9 Auto
ReferenceAlias  Property pDFQRef10 Auto
ReferenceAlias  Property pDFQRef11 Auto
ReferenceAlias  Property pDFQRef12 Auto
ReferenceAlias  Property pDFQRef13 Auto
ReferenceAlias  Property pDFQRef14 Auto
ReferenceAlias  Property pDFQRef15 Auto
ReferenceAlias  Property pDFQRef16 Auto
ReferenceAlias  Property pDFQRef17 Auto
ReferenceAlias  Property pDFQRef18 Auto
ReferenceAlias  Property pDFQRef19 Auto
ReferenceAlias  Property pDFQRef20 Auto
ReferenceAlias  Property pDFQRef21 Auto
ReferenceAlias  Property pDFQRef22 Auto
ReferenceAlias  Property pDFQRef23 Auto
ReferenceAlias  Property pDFQRef24 Auto
ReferenceAlias  Property pDFQRef25 Auto
ReferenceAlias  Property pDFQRef26 Auto
ReferenceAlias  Property pDFQRef27 Auto
ReferenceAlias  Property pDFQRef28 Auto
ReferenceAlias  Property pDFQRef29 Auto
ReferenceAlias  Property pDFQRef30 Auto

; Used by SkyHavenTempleFreeformQuest (Recruit Blades) to fix bug created when we made PlayerFollwoers constant and 0
Int Property numFollowers Auto Conditional
GlobalVariable Property pTweakMoreInteractive Auto
GlobalVariable Property pTweakHorsesOblivious Auto
GlobalVariable Property TweakLimitFollowers auto
GlobalVariable Property pTimeScale Auto
GlobalVariable Property pTweakExtraDamage Auto
GlobalVariable Property pTweakRechargeThreshold Auto
GlobalVariable Property pTweakRootBackPack Auto
GlobalVariable Property pTweakStopAll Auto
GlobalVariable Property pTweakLongRecovery Auto ; 1.65

; Vampire Lord Bug Fix:
GlobalVariable Property pPlayerIsVampire Auto
Quest Property PlayerVampireQuest  Auto
Spell Property pVampireSunDamage01 Auto
Spell Property pVampireSunDamage02 Auto
Spell Property pVampireSunDamage03 Auto
Spell Property pVampireSunDamage04 Auto
Spell Property crVampireSunDamage Auto

; Control AI
GlobalVariable Property pTweakStealthActive Auto

; These globals are only updated by this script, so no cache
; updates are necessary
GlobalVariable Property pTweakAINotWhenTalking Auto
GlobalVariable Property pTweakAINeedCloseIdle Auto
GlobalVariable Property pTweakAIMustSheathe Auto
GlobalVariable Property pTweakAITimeMode Auto
GlobalVariable Property pTweakAISettleProbability Auto
GlobalVariable Property TweakFollowerCount Auto

Message Property TweakAIConfig Auto
Message Property TweakEndPoseMsg Auto

; Speed up Dialogue menus
Int Property menuState Auto Conditional
Int Property fBombs Auto Conditional
Float Property fBombUnlock Auto Conditional

; Used by quest dialogue and script:
Bool Property followerIgnoresFriendlyFire Auto Conditional 
Bool Property followerHoldback Auto Conditional
Bool Property followerNoMorals Auto Conditional
Bool Property followerFearless Auto Conditional
Bool Property followerCatchup Auto Conditional
Bool Property followerPackMuleDisable Auto Conditional
Bool Property followerNoBoostStats Auto Conditional
Bool Property showMessages Auto Conditional
Bool Property ignoreWerewolfFollowers Auto Conditional
Bool Property DisableInstantHeal Auto Conditional
Bool Property FollowerSynergy Auto Conditional 
Bool Property followerRegen Auto Conditional

; Used by quest dialogue and and "stable" quest script and aliases:
Bool Property followerCanRide Auto Conditional
Bool Property followerNoTrap Auto Conditional

; Used by quest dialogue
Int Property pcHasHorse Auto Conditional

Message Property TweakEmbraceConfirm Auto
Message Property TweakWerewolfConfirm Auto
Message Property TweakWerebearConfirm Auto
Message Property TweakVampireConfirm Auto
Message Property TweakResetConfirm Auto
Message Property TweakMaxReached Auto
Message Property TweakSEWarning Auto
Message Property TweakResetNPCConfirm  Auto

Spell Property WerewolfChange Auto
Spell Property TweakCommandSpell Auto
Spell Property TweakMakeFollowerSpell Auto
Spell Property TweakLeadership  Auto

Bool Property PossessHintOnce Auto
Bool Property PoseHintOnce Auto
Bool Property FreezeHintOnce Auto
Bool Property InstallWelcome Auto
Bool Property BehindHintOnce Auto
Bool Property StealthHintOnce Auto
Faction Property PlayerMarriedFaction Auto
Bool property CombatOverFlag auto
Bool property CombatRunningFlag auto

ActorBase Property HousecarlWhiterun Auto

; Other Quest Scripts
TweakStables Property pTweakStables Auto
DarkBrotherhood Property pDarkBrotherhood Auto
TweakLydiaFix Property pTweakLydiaFix Auto
TweakMonitorPlayerScript Property pTweakMonitorPlayerScript Auto
Quest Property DialogueFollower Auto

ReferenceAlias[] Property TweakMap Auto
ReferenceAlias[] Property FollowerMap Auto

Message Property UpgradeMsg Auto
Message Property RHorseNote Auto
Message Property RCampNote Auto
Message Property RManagedNote Auto
Message Property RNPCsNote Auto
Message Property MagicDisabledMsg Auto
Message Property MagicEnabledMsg Auto
Message Property EFRNullNote Auto
Message Property AssignFailNote Auto
Message Property CatchupMsg Auto
Message Property PossessMsg Auto
Message Property WerewolfMsg Auto
Message Property IgnoreMsg Auto
Message Property EssentialMsg Auto
Message Property PoseMsg Auto
Message Property HangoutMsg Auto
Message Property UnrecognizedMsg Auto
Message Property IUpgradeNote Auto
Message Property TweakBehindMsg Auto
Message Property TweakStealthMsg Auto
Message Property RCompleteNote Auto

Spell Property TG05KarliahInvisibilitySpell Auto
Spell Property TweakStealth Auto

Book Property pTweakReadMe  Auto
GlobalVariable Property pGameDaysPassed  Auto  
TweakDawnGuardScript Property pTweakDawnGuardScript Auto
TweakDragonBornScript Property pTweakDragonBornScript Auto

; Use by TweakMakeFollowerSpell to identify name of NPC.
ReferenceAlias  Property pDBQRef Auto
Bool			Property Upgrade Auto
Location		Property PlayerHouse Auto Conditional

; ==============================================
; EVENT HANDLERS
; ==============================================

Function OnGameLoaded()
	; Dont do a refresh during upgrades...
	if (1.66 == version && TweakFollowerCount.GetValue() > 0)
		; Weapon Refresh
		ReferenceAlias[] f =GetAllTweakFollowers()
		Int i = 0
		while (i != f.length)
			(f[i] As TweakVampireLord).FixEyes();
			(f[i] As TweakVampire).FixEyes();
			(f[i] As TweakInventoryControl).RefreshWeapon();
			i = i + 1
		endWhile
	endif
	confirmVersion()
	
EndFunction

GlobalVariable Property TweakShowMessages  Auto
GlobalVariable Property TweakIgnoreFriendlyFire  Auto
GlobalVariable Property TweakFollowerHoldBack  Auto
GlobalVariable Property TweakNoMorals  Auto
GlobalVariable Property TweakFearlessFollowers  Auto
GlobalVariable Property TweakFollowerCanRide  Auto
GlobalVariable Property TweakFollowerCatchUp  Auto
GlobalVariable Property TweakFollowerNoTrap  Auto
GlobalVariable Property TweakFollowerRegen  Auto
GlobalVariable Property TweakPackMuleDisable  Auto
GlobalVariable Property TweakIgnoreWerewolfFollowers  Auto
GlobalVariable Property TweakRechargeWeaponsDisable  Auto

GlobalVariable Property TweakFollowersCanDie  Auto
GlobalVariable Property TweakFollowerDeathChance  Auto
int Property TweakCarryWeight  Auto

Event OnInit()
	version=1.66
	pTweakMoreInteractive.SetValueInt(1)
	PossessHintOnce = false
	PoseHintOnce = false
	FreezeHintOnce = false
	Upgrade = false
	command=0
	tfCount=0
	showMessages=TweakShowMessages.GetValueInt()
	followerIgnoresFriendlyFire=TweakIgnoreFriendlyFire.GetValueInt()
	followerHoldback=TweakFollowerHoldBack.GetValueInt()
	followerNoMorals=TweakNoMorals.GetValueInt()
	followerFearless=TweakFearlessFollowers.GetValueInt()
	followerCanRide=TweakFollowerCanRide.GetValueInt()
	followerCatchup=TweakFollowerCatchUp.GetValueInt()
	followerNoTrap=TweakFollowerNoTrap.GetValueInt()
	followerRegen=TweakFollowerRegen.GetValueInt()
	followerPackMuleDisable=TweakPackMuleDisable.GetValueInt()
	rechargeWeaponsDisable=TweakRechargeWeaponsDisable.GetValueInt()
	ignoreWerewolfFollowers=TweakIgnoreWerewolfFollowers.GetValueInt()
	FollowerSynergy=true
	pcHasHorse=0
	PlayerHouse=None
	initializeTweakMap()
	initializeFollowerMap()
	((self As Quest) As TweakFollowerSpells).initializeSpellMaps()
	pTweakHorsesOblivious.SetValueInt(1)
	pTweakMoreInteractive.SetValueInt(1)
	pTweakExtraDamage.SetValue(0.0)
	numFollowers = GetAllTweakFollowers().length
	TweakFollowerCount.SetValueInt(numFollowers)

	if (!InstallWelcome)
		InstallWelcome = true
		command=26
		if (pGameDaysPassed.GetValue() > 1)
			RegisterForSingleUpdate(2.0)
		else
			RegisterForSingleUpdate(30)
		endif
	endif

	; Deprecated 1.6
	followerEssential=true
	
	if Game.GetModByName("SkyUI.esp") != 255
		if !Game.GetFormFromFile(0x000820, "SkyUI.esp")
			Game.GetPlayer().AddSpell(TweakCommandSpell)
		endif
	else
		Game.GetPlayer().AddSpell(TweakCommandSpell)
	endIf
	Game.GetPlayer().AddSpell(TweakLeadership)
	
endEvent

Event OnUpdate()
	if (CombatRunningFlag)
		CombatRunningFlag = false
		CheckCombat()
	endif
	if (combatOverFlag)
		combatOverFlag=false
		RelayCombatEndEvent()
	endif
	if (Upgrade)
		Upgrade = false
		if (version < 1)
			; incase there is an odd timing issue
			; Unfortunately, this also breaks backward compatibility 
			; with version 1.0 as it did not have a version variable.
			Return
		endif
		
		float ov = version
		version=1.66

		if (ov < 1.65)
			if (ov < 1.61)
				if (ov < 1.6)
					if (ov < 1.55)
						if (ov < 1.52)
							if (ov < 1.5)
								if (ov < 1.4)
									if (ov < 1.3)
										if (ov < 1.2)
											initializeTweakMap()
											initializeFollowerMap()
											((self As Quest) As TweakFollowerSpells).initializeSpellMaps()
										endif
										;; Game.GetPlayer().AddItem(pTweakReadMe,1)
										initializeFollowerMap()
									endif
									;	Game.GetPlayer().AddSpell(TweakCommandSpell)
									;	Game.GetPlayer().AddSpell(TweakLeadership)
								endif
								numFollowers = GetAllTweakFollowers().length
								TweakFollowerCount.SetValueInt(numFollowers)
								pTweakMoreInteractive.SetValueInt(1)
								;; Game.GetPlayer().AddSpell(TweakMakeFollowerSpell)
								Game.GetPlayer().AddSpell(TweakLeadership)
							endif
							pTweakHorsesOblivious.SetValueInt(1)			
						endif
						FollowerSynergy = true
					endif
					((self As Quest) As TweakFollowerSpells).v16Update()
					CombatOverFlag=true
					followerRegen=true
				endif
				((self As Quest) As TweakFollowerSpells).v161Update()
				pTweakRootBackPack.SetValue(1.0)
			EndIf
			PlayerHouse=None
			if (pTweakDawnGuardScript.Installed)
				pTweakDawnGuardScript.v165Update()
			endif
		Endif
		
		if (ov < 1.62)

			Debug.Notification("Upgrading AFT. Please Wait...")

			Int i = 0
			Int c = 0
			ReferenceAlias a
			while i < 90
				a = TweakMap[i]
				if (a && a.GetActorRef() && !a.GetActorRef().IsDead())
					c += 1
					if (ov < 1.62)
						if (ov < 1.61)
							if (ov < 1.6)
								if (ov < 1.5)
									if (ov < 1.4)
										if (ov < 1.3)
											(a As TweakInventoryControl).v13Upgrade()
										endif
										(a As TweakWerewolf).v14Upgrade()
									EndIf
									(a As TweakSettings).v15Upgrade()
									(a As TweakInventoryControl).v15Upgrade()
								endif
								(a As TweakInventoryControl).v16Upgrade()
								(a As TweakSettings).v16Upgrade()
								(a As TweakMagic).v16Upgrade()
							endif
							(a As TweakMagic).v161Upgrade()
						endif
						FixArmor(a.GetRef())						
					endif
					Debug.Notification("[" + c + "] of [" + tfCount + "]followers upgraded")
				endif
				i += 1
			endwhile
		endif
		UpgradeMsg.Show(ov, version)
	endif
	if (26 == command)
		;; Game.GetPlayer().AddItem(pTweakReadMe,1, true)
		;; Game.GetPlayer().AddSpell(TweakCommandSpell)
		;; Game.GetPlayer().AddSpell(TweakMakeFollowerSpell)
		Game.GetPlayer().AddSpell(TweakLeadership)
	elseif (24 == command)
		GetFollowersHelper()
	endif
	command = 0
endEvent

Function OnPCLevelUp()
	ReferenceAlias[] f = GetAllTweakFollowers()
	Int i = 0
	Utility.wait(0.1)
	while (i != f.length)
		(f[i] As TweakLevelUp).OnPCLevelUp();
		i += 1
	endWhile
endFunction

; From Quest TweakMonitorPlayer (OnHit event)
Function StealthDetected(ObjectReference akAggressor=None)
	if (1.0 == pTweakStopAll.GetValue())
		return
	endif
	if (1.0 == pTweakStealthActive.GetValue())
		Float fNewValue = pTweakStealthActive.Mod(-1.0)
		if (0.0 == fNewValue)
			Debug.Notification("Stealth Removed")
		else
			pTweakStealthActive.SetValue(0.0)
		endif
		ReferenceAlias[] f = GetAllTweakFollowers()
		if (f)
			int i=0
			while (i != f.length)
				Actor n = f[i].GetActorRef()
				if (!n.IsDead() && n.IsInFaction(pTweakInStealth))
					(f[i] As TweakSettings).stealthFlag = true
					f[i].RegisterForSingleUpdate(0.01)
				endif
				i += 1
			endWhile
		endIf
	endif
EndFunction

; Called from Quest TweakMonitor
Function PCTransform(Bool human)
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		(f[i] As TweakPossession).PCTransform();
		(f[i] As TweakWerewolf).PCTransform(human);
		(f[i] As TweakWerebear).PCTransform(human);
		(f[i] As TweakVampireLord).PCTransform(human);
		i = i + 1
	endWhile
endFunction

; ==============================================
; FUNCTIONS
; ==============================================

Function SetAllCarryWeight()
	TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
	if (pDFScript)
		ReferenceAlias[] f = GetAllTweakFollowers(true)
		int i=0
		while (i != f.length)
			pDFScript.DialogueRef = f[i].GetActorRef()
			pDFScript.SetFollowerWeight()
			f[i].GetActorRef().EvaluatePackage()
			i += 1
		endWhile
	endif
endFunction

; Wait is a robotic hault. Ignore combat, do nothing
Function AllFollowersWait()
	pTweakStopAll.SetValue(1.0)
	TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
	if (pDFScript)
		ReferenceAlias[] f = GetAllTweakFollowers(true)
		int i=0
		while (i != f.length)
			pDFScript.DialogueRef = f[i].GetActorRef()
			pDFScript.FollowerWait()
			f[i].GetActorRef().EvaluatePackage()
			i += 1
		endWhile
	endif
endFunction

Function AllFollowersFollow()
	pTweakStopAll.SetValue(0.0)
	TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
	if (pDFScript)
		ReferenceAlias[] f = GetAllTweakFollowers()
		int i=0
		while (i != f.length)
			pDFScript.DialogueRef = f[i].GetActorRef()
			pDFScript.FollowerFollow()
			f[i].GetActorRef().EvaluatePackage()
			i += 1
		endWhile
	endif
endFunction

; Like Wait, but followers sandbox and hang out. 
Function AllFollowersRelax()
	pTweakStopAll.SetValue(1.0)
	TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
	if (pDFScript)
		ReferenceAlias[] f = GetAllTweakFollowers()
		int i=0
		while (i != f.length)
			pDFScript.FollowerRelax(f[i].GetRef())
			f[i].GetActorRef().EvaluatePackage()
			i += 1
		endWhile
	endif
endFunction

Function ConfigureAI()
	int one = pTweakAITimeMode.GetValueInt()
	one = 3 - one
    one = (one * 3) as int
	int two = 1
	if (1 == pTweakAINotWhenTalking.GetValueInt())
		two = 0
	endif
	int three = 1
	if (1 == pTweakAIMustSheathe.GetValueInt())
		three = 0
	endif
	int four = 1
	if (1 == pTweakAINeedCloseIdle.GetValueInt())
		four = 0
	endif
    int five = pTweakAISettleProbability.GetValueInt()
	int choice = 0
	while (5 != choice)
		choice = TweakAIConfig.Show(one,two,three,four,five)
		if (0 == choice)
			int oldvalue = pTweakAITimeMode.GetValueInt()
			int newvalue = oldvalue + 1
			if (3 == newvalue)
				newvalue = 0
			EndIf
			pTweakAITimeMode.SetValueInt(newvalue)
			one = 3 - newvalue
			one = (one * 3) as int
		elseif (1 == choice)
			if (1 == two)
				pTweakAINotWhenTalking.SetValueInt(1)
				two = 0
			else
				pTweakAINotWhenTalking.SetValueInt(0)
				two = 1
			endif
		elseif (2 == choice)
			if (1 == three)
				pTweakAIMustSheathe.SetValueInt(1)
				three = 0
			else
				pTweakAIMustSheathe.SetValueInt(0)
				three = 1
			endif
		elseif (3 == choice)
			if (1 == four)
				pTweakAINeedCloseIdle.SetValueInt(1)
				four = 0
			else
				pTweakAINeedCloseIdle.SetValueInt(0)
				four = 1
			endif
		elseif (4 == choice)
			five += 25
			if (five > 100)
				five = 25
			endif
			pTweakAISettleProbability.SetValueInt(five)
		endif
	endwhile
EndFunction

Function CombatStateChanged(Bool cstate)
	if (1 == cState)
		combatOverFlag=false
		if (1.0 == pTweakLongRecovery.GetValue())
			CombatRunningFlag=true
			RegisterForSingleUpdate(40)
		else
			UnRegisterForUpdate()
		endif
	elseif (0 == cState)
		CombatRunningFlag=false
		combatOverFlag=true
		RegisterForSingleUpdate(10)
	endif
EndFunction

Function confirmVersion()

	; Since this is fed by Player OnGameLoad event, this can 
	; actually fire BEFORE OnInit. 

	if (InstallWelcome)
		if (pGameDaysPassed.GetValue() > 1)
		;	if (20 < pTimeScale.GetValue())
		;		Debug.MessageBox("AFT Warning : GlobalValue timescale is too large. This may cause instability with AFT.")
		;	endif
		endif
		if (version  != 1.66)
			; flood protection
			UnRegisterForUpdate()
			Upgrade = true
			RegisterForSingleUpdate(0.25)
		endif
	endif

endFunction

Function Dance(ObjectReference follower)
	ReferenceAlias a = FindAlias(follower)
	if (!a)
		Warning()
		return
	endif
	(a as TweakPose).Dance()
endFunction

Function EmbraceFollower(ObjectReference follower)
	ReferenceAlias a = FindAlias(follower)
	if (!a)
		Warning()
		return
	endif
;	int c = TweakEmbraceConfirm.Show()
;	if (0 == c)
		TweakVampire pTweakVampire = a as TweakVampire
		if pTweakVampire
			pTweakVampire.command = 6
			a.RegisterForSingleUpdate(0.0)
			Utility.Wait(0.50)
		endif
;	endif
endFunction

Function EndPose(ObjectReference follower)
	Actor npc = follower As Actor
	if npc
		int choice = TweakEndPoseMsg.show()
		if (1 == choice) ; hang out here
			npc.AddToFaction(TweakHangoutFaction)		
		endif
		npc.RemoveFromFaction(TweakPosedFaction)
		if (2 == choice) ; follow
			TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
			if pDFScript
				pDFScript.SetFollower(follower)
			endif
		endif
	endif
EndFunction

Function EquipBonusOutfit(ObjectReference follower)
	ReferenceAlias a = FindAlias(follower)
	if (!a)
		Warning()
		return
	endif
	Actor n=follower As Actor
	n.UnequipAll()
	(a As TweakInventoryControl).EquipBonusOutfit()
endFunction

Function EventFollowerFollow(ObjectReference follower)
	ReferenceAlias a = FindAlias(follower)
	if (a)
		(a As TweakWerewolf).EventWaitToFollow()
		(a As TweakWerebear).EventWaitToFollow()
		(a As TweakVampireLord).EventWaitToFollow()
		(a As TweakSettings).EventWaitToFollow()
		(a As TweakPose).EventWaitToFollow()
		(a As TweakMagic).EventWaitToFollow()
		(a As TweakLevelup).EventWaitToFollow()
		(a As TweakInventoryControl).EventWaitToFollow()
		(a As TweakPossession).EventWaitToFollow()
		(a As TweakVampire).EventWaitToFollow()
	else
		Warning()
	endif
	Debug.SendAnimationEvent(follower as Actor,"IdleForceDefaultState")
endFunction

Function EventFollowerDismissed(ObjectReference follower)

	Actor n = follower As Actor
	if (n.GetActorBase().GetFormId() == HousecarlWhiterun.GetFormId())
		if (pTweakLydiaFix.IsRunning() && !n.IsInFaction(PlayerMarriedFaction))
			 pTweakLydiaFix.SetLydia(follower)
		endif
	endif

	ReferenceAlias[] f = GetAllTweakFollowers()
	if (1.0 == pTweakStealthActive.GetValue())
		if (f)
			Float fNewValue = pTweakStealthActive.Mod(-1.0)
			if (0.0 == fNewValue)
				Debug.Notification("Stealth Removed")
			Else
				pTweakStealthActive.SetValue(0.0)
			endif
			int i=0
			while (i != f.length)
				(f[i] As TweakSettings).OnStealthDetected()
				i += 1
			endWhile
		endif
	endif
	
	ReferenceAlias a = FindAlias(follower)
	if (a)
		; Avoid rand bounties
		a.GetActorRef().RemoveFromFaction(PlayerFaction)

		(a As TweakWerewolf).EventNotFollowingPlayer()
		(a As TweakWerebear).EventNotFollowingPlayer()
		(a As TweakVampireLord).EventNotFollowingPlayer()
		(a As TweakSettings).EventNotFollowingPlayer()
		(a As TweakPose).EventNotFollowingPlayer()
		(a As TweakMagic).EventNotFollowingPlayer()
		(a As TweakLevelup).EventNotFollowingPlayer()
		(a As TweakInventoryControl).EventNotFollowingPlayer()
		(a As TweakPossession).EventNotFollowingPlayer()
		(a As TweakVampire).EventNotFollowingPlayer()

		numFollowers = TweakFollowerCount.GetValueInt() 		
		numFollowers -= 1
		if (numFollowers < 0)
			numFollowers = 0
		endif
		TweakFollowerCount.SetValueInt(numFollowers)
	endif

endFunction

GlobalVariable Property TweakVoiceFix  Auto

; Event fired from DialogueFollowerQuest
Function EventFollowerRecruited(ObjectReference follower, Bool beforeAIChange)

	Actor n = follower As Actor
	if (!n)
		EFRNullNote.Show()
	endif

	if (n.GetActorBase().GetFormId() == HousecarlWhiterun.GetFormId())
		if (pTweakLydiaFix.IsRunning())
			pTweakLydiaFix.ClearLydia()
		endif
	endif
	int id = n.GetAV("FavorActive") As Int

	ReferenceAlias a = None
	if (0 != id)
		a = FindAliasById(id)
	endif

	if (a && a.GetActorRef())
		if (beforeAIChange)
			return;
		endif
		if (followerCanRide)
			a.GetActorRef().AddToFaction(PlayerFaction)
		endif
		(a As TweakSettings).EventFollowingPlayer()
		(a As TweakMagic).EventFollowingPlayer()
		(a As TweakLevelup).EventFollowingPlayer()
		(a As TweakInventoryControl).EventFollowingPlayer()
		(a As TweakPose).EventFollowingPlayer()
		(a As TweakWerewolf).EventFollowingPlayer()
		(a As TweakWerebear).EventFollowingPlayer()
		(a As TweakVampireLord).EventFollowingPlayer()
		(a As TweakPossession).EventFollowingPlayer()
		(a As TweakVampire).EventFollowingPlayer()

		numFollowers = GetAllTweakFollowers().length
		if (0.0 != TweakLimitFollowers.GetValue())
			if (numFollowers > 3)
				numFollowers = 3
			endif
		else
			if (numFollowers > 30)
				numFollowers = 30
			endif
		endif
		TweakFollowerCount.SetValueInt(numFollowers)		
	else
		Actor f = None
		if (0 != id && id < 91)
			a = FindAliasById(id)
			f = a.GetActorRef()
			if (f && !f.IsDead())
				; Already Assigned, cant use this one
				AssignFailNote.Show()
				a = None
			endif
		endif
		int i = 0
		tfCount = 0
		bool used
		ReferenceAlias r = None
		
		while (i < 90)
			used = false
			r = TweakMap[i]
			f = r.GetActorRef()
			if (f && !f.IsDead())
				used = true
				tfCount += 1
			EndIf
			if (!a && !used)
				a = r
				id = i + 1
			EndIf
			i += 1
		EndWhile
		
		if (a)
			n.SetAV("FavorActive", id)
			a.Clear()
			a.ForceRefTo(follower)			

			if (!a.GetActorRef())
				Debug.MessageBox("AFT Warning: Save Game Compatibility Issue Detected.")
				return
			EndIf
			
			tfCount += 1

			numFollowers = GetAllTweakFollowers().length
			if (0.0 != TweakLimitFollowers.GetValue())
				if (numFollowers > 3)
					numFollowers = 3
				endif
			else
				if (numFollowers > 30)
					numFollowers = 30
				endif
			endif
			TweakFollowerCount.SetValueInt(numFollowers)		

			(a As TweakSettings).initialize()
			(a As TweakMagic).initialize()
			(a As TweakLevelup).initialize()
			(a As TweakPose).initialize()
			(a As TweakWerewolf).initialize()
			(a As TweakWerebear).initialize()
			(a As TweakVampireLord).initialize()
			(a As TweakPossession).initialize()
			(a As TweakVampire).initialize()
			(a As TweakInventoryControl).initialize()
			; To get followers to ride horses, they must be a member of the playerfaction
			if (followerCanRide)
				n.AddToFaction(PlayerFaction)
			endif
			n.AddToFaction(TweakChattyFaction)
		EndIf
		
		Int Remaining = 90 - tfCount
		if (Remaining < 0)
			Remaining = 0
		EndIf

		Debug.Notification("AFT: [" + Remaining + "] Managed NPC Slots remaining")

		if (!a)
			Debug.MessageBox("AFT Warning: Unable to manage NPC.")
			Utility.wait(0.1)
		endif
		
		if (0 == Remaining)
			int confirm = TweakMaxReached.show()
			if (0 == confirm)
				AftReset(false)
			endif
		endif
	endif
	
	if (TweakVoiceFix.GetValueInt())
	
		if(n.isInFaction(PlayerFaction))
			n.RemoveFromFaction(PlayerFaction)
		endif
		
	endif

endFunction

Function FenceGear(ObjectReference f)
	ReferenceAlias a = FindAlias(f)
	if (!a)
		Warning()
		return
	endif
	(a as TweakInventoryControl).SellGear()
endFunction

ReferenceAlias Function FindAlias(ObjectReference f)
	Actor n = f As Actor
	if (!n)
		return None
	endif
	int id = n.GetAV("FavorActive") As Int
	if (0 != id)
		ReferenceAlias r = FindAliasById(id)
		if r.GetActorRef()
			return r
		endif
	endif
	return None
endFunction

ReferenceAlias Function FindAliasById(int Idp)
	if (Idp > 90) 
		return None
	endif
	Int id = (Idp - 1)
	return TweakMap[id]
endFunction

Function FixArmor(ObjectReference n)
	if (pTweakDawnGuardScript.Installed)
		Actor npc = n As Actor
		if (npc == pTweakDawnGuardScript.Serena && npc.IsInFaction(TweakManagedInventoryFaction))
			int armors = npc.GetItemCount(pTweakDawnGuardScript.ArmorVampireArmorRoyal)
			if 0 != armors
				n.RemoveItem(pTweakDawnGuardScript.ArmorVampireArmorRoyal,armors,true)
				Utility.wait(0.25)
				n.AddItem(TweakArmorVampireArmorRoyalRed,armors,false)
			endif
			int hood = npc.GetItemCount(pTweakDawnGuardScript.SeranaHood)
			if 0 != hood
				n.RemoveItem(pTweakDawnGuardScript.SeranaHood,hood,true)
			endif
		endif
	endif
EndFunction

Function FollowerBomb()
	if (1 == TweakSEWarning.show())
		return
	endif
	if fBombs < 3
		fBombs += 1
		if (3 == fBombs)
			fBombUnlock = Utility.GetCurrentGameTime() + 7
		endif
	else
		int diff = (fBombUnlock - Utility.GetCurrentGameTime()) as Int
		if diff > 0
			Debug.MessageBox("Locked. Will unlock in [" + diff + "] days")	
			return
		else
			fBombs = 1
		endif
	endif
	int[] offset = new int[5]
	offset[0] = 0
	offset[1] = 45
	offset[2] = 90
	offset[3] = 135
	offset[4] = 180
	offset[5] = -135
	offset[6] = -90
	offset[7] = -45
	float[] facing = new float[3]
	facing[0] = pc.GetAngleX()
	facing[1] = pc.GetAngleY()
	facing[2] = pc.GetAngleZ()
	int distance = 200	
	Actor pc = Game.GetPlayer()
	Actor moveTarget = pc;
	Int i = 0
	Int c = 0
	ReferenceAlias a
	while i < 90
		a = TweakMap[i]
		if (a)
			Actor n = a.GetActorRef()
			if (n && !n.IsDead())
				float[] pos = TraceCircle(pc, distance, offset[c])
				if (!n.GetCurrentLocation().IsSameLocation(pc.GetCurrentLocation()))
					n.MoveTo(moveTarget)
				endif
				n.SetPosition(pos[0],pos[1],pos[2])
				n.SetAngle(facing[0], facing[1],facing[2])
				moveTarget = n
				n.RemoveSpell(TG05KarliahInvisibilitySpell)
				n.RemoveSpell(TweakStealth)
				c += 1
				if (8 == c)
					c = 0
					distance += 200
				endif
			endif
		endif
		i += 1
	endwhile
endFunction

Function LevelUp(ObjectReference f)
	ReferenceAlias a = FindAlias(f)
	if (!a)
		Warning()
		return
	endif
	TweakLevelUp pTweakLevelUp = a as TweakLevelUp
	if pTweakLevelUp
		pTweakLevelUp.command = 3
		a.RegisterForSingleUpdate(0.1)
	endif
endFunction

Function Freeze(ObjectReference f)
	ReferenceAlias a = FindAlias(f)
	if (!a)
		Warning()
		return
	endif
	if (showMessages && !FreezeHintOnce)
		FreezeHintOnce = true
		HangoutMsg.Show()
		Utility.Wait(0.1)
	endif
	TweakPose pTweakPose = a as TweakPose
	if (pTweakPose)
		pTweakPose.command = 5
		a.RegisterForSingleUpdate(0.1)
		Utility.Wait(0.50)
	endif
endFunction

ReferenceAlias[] Function GetAllTweakFollowers(Bool onlyNotWaiting = FALSE, Bool onlyNotWerewolf = FALSE, Bool onlyNotVampireLord=FALSE)

	ReferenceAlias[] ret = new ReferenceAlias[30]
	int c = 0

	int i = 0
	while (i != 30)
		if (FollowerMap[i])
			Actor n = FollowerMap[i].GetActorRef()
			if (n)
				int id = (n.GetAV("favorActive") As Int) - 1
				if (-1 != id && TweakMap[id] && TweakMap[id].GetActorRef())
					if (!onlyNotWaiting || (0 == (TweakMap[id].GetActorRef().GetAV("WaitingforPlayer") As Int)))
						if (!onlyNotWerewolf || !TweakMap[id].GetActorRef().IsInFaction(WerewolfFaction) && !TweakMap[id].GetActorRef().IsInFaction(TweakWerebearFaction))
							if (!onlyNotVampireLord || (pTweakDawnGuardScript.Installed && !TweakMap[id].GetActorRef().IsInFaction(pTweakDawnGuardScript.VampireLordFaction)))
								ret[c] = TweakMap[id]
								c += 1
							endif
						endif
					endif
				endif
			endif
		endif
		i += 1
	endWhile

	ReferenceAlias[] trim;
	if (c == 30)
		trim = new ReferenceAlias[30]
	elseif (c == 29)
		trim = new ReferenceAlias[29]
	elseif (c == 28)
		trim = new ReferenceAlias[28]
	elseif (c == 27)
		trim = new ReferenceAlias[27]
	elseif (c == 26)
		trim = new ReferenceAlias[26]
	elseif (c == 25)
		trim = new ReferenceAlias[25]
	elseif (c == 24)
		trim = new ReferenceAlias[24]
	elseif (c == 23)
		trim = new ReferenceAlias[23]
	elseif (c == 22)
		trim = new ReferenceAlias[22]
	elseif (c == 21)
		trim = new ReferenceAlias[21]
	elseif (c == 20)
		trim = new ReferenceAlias[20]
	elseif (c == 19)
		trim = new ReferenceAlias[19]
	elseif (c == 18)
		trim = new ReferenceAlias[18]
	elseif (c == 17)
		trim = new ReferenceAlias[17]
	elseif (c == 16)
		trim = new ReferenceAlias[16]
	elseif (c == 15)
		trim = new ReferenceAlias[15]
	elseif (c == 14)
		trim = new ReferenceAlias[14]
	elseif (c == 13)
		trim = new ReferenceAlias[13]
	elseif (c == 12)
		trim = new ReferenceAlias[12]
	elseif (c == 11)
		trim = new ReferenceAlias[11]
	elseif (c == 10)
		trim = new ReferenceAlias[10]
	elseif (c == 9)
		trim = new ReferenceAlias[9]
	elseif (c == 8)
		trim = new ReferenceAlias[8]
	elseif (c == 7)
		trim = new ReferenceAlias[7]
	elseif (c == 6)
		trim = new ReferenceAlias[6]
	elseif (c == 5)
		trim = new ReferenceAlias[5]
	elseif (c == 4)
		trim = new ReferenceAlias[4]
	elseif (c == 3)
		trim = new ReferenceAlias[3]
	elseif (c == 2)
		trim = new ReferenceAlias[2]
	elseif (c == 1)
		trim = new ReferenceAlias[1]		
	endif

	i = 0
	while (i < c)
		trim[i] = ret[i]
		i += 1
	endwhile

	return trim

endFunction

Function GetBehindMe(ObjectReference f)

	if (showMessages && !BehindHintOnce)
		BehindHintOnce = true
		TweakBehindMsg.Show()
	endif

	Actor pc=Game.GetPlayer()
	Actor n=f As Actor
	float[] behindMe=TraceCircle(pc, 125, -180)
	n.SetPosition(behindMe[0],behindMe[1],behindMe[2]) 
	n.SetAngle(0.0,0.0, pc.GetAngleZ()) 
endFunction

Function GetFollowers(ObjectReference f = None)

	; Lots of followers may call this at same
	if (f)
		; In dialogue. cant flood
		GetFollowersHelper(f)
	else
		; Update and UpdateGameTime function on different threads
		UnRegisterForUpdate()
		command = 24
		; moveto breaks if during sheathe/draw. Change areas to fix.
		RegisterForSingleUpdate(0.5)
	endif

endFunction

; 2 scenarios: Ask follower to summon All or
; draw weapon and teleport behind player.
Function GetFollowersHelper(ObjectReference f = None)

	Actor pc = Game.GetPlayer()
	Actor moveTarget=pc
	bool moveFlag=false
	int talkingToID=0
	int[] offset=new int[5]
	float[] facing=new float[3]
	offset[0]=180
	offset[1]=158
	offset[2]=-158
	offset[3]=136
	offset[4]=-136
	facing[0]=pc.GetAngleX()
	facing[1]=pc.GetAngleY()
	facing[2]=pc.GetAngleZ()

	bool excludeWait = true
	TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
		
	if (f)
		talkingToID = (f as Actor).GetFormID()
		offset[0]=22
		offset[1]=-22
		offset[2]=44
		offset[3]=-44
		facing[2]=pc.GetAngleZ() - 180
		excludeWait=false
		moveFlag=true
		pTweakStopAll.SetValue(0.0)
		if combatRunningFlag
			if !Game.GetPlayer().IsInCombat()
				UnregisterForUpdate()
				combatRunningFlag = false
				combatOverFlag = false
				RelayCombatEndEvent()
			endif
		endif
	endif

	ReferenceAlias[] all =GetAllTweakFollowers(false,false)
	int i = 0
	int c = 0
	bool pass
	while (i != all.length)
		ObjectReference FO = all[i].GetReference()
		Actor FA = FO As Actor
		Package p = FA.GetCurrentPackage() 
		if (FA.GetFormID() != talkingToID)
			if (!FA.GetPlayerControls() && p != TweakFollowerPackageHorse)
				if (0 == (FA.GetAv("WaitingforPlayer") as Int) || !excludeWait)
					pass = true
					if (!f)
						if (pc.HasLOS(FO))
							pass = False
						else
							Actor ct = FA.GetCombatTarget()
							if ct
								if !ct.IsPlayerTeammate()
									pass = False
								EndIf
							endif
						endif
					endif
					if (pass)
						if (moveFlag)
							FA.MoveTo(moveTarget)
						else
							Location fLoc = FA.GetCurrentLocation()
							Location pLoc = pc.GetCurrentLocation()	
							if (fLoc && pLoc && fLoc.IsSameLocation(pLoc))
								FA.MoveTo(moveTarget)
							endif
						endif
						float[] pos = TraceCircle(pc, 200, offset[c])
						FA.SetPosition(pos[0],pos[1],pos[2])
						FA.SetAngle(facing[0], facing[1],facing[2])
						moveTarget = FA
						If (0 != (FA.GetAv("WaitingforPlayer") as Int) && pDFScript)
							pDFScript.DialogueRef = all[i].GetActorRef()
							pDFScript.FollowerFollow()
						endif
						if (!ignoreWerewolfFollowers)
							if (all[i] As TweakWerewolf).IsWerewolfform
								(all[i] As TweakWerewolf).WerewolfPeek()
							endif
							if (pTweakDawnGuardScript.Installed && (all[i] As TweakVampireLord).IsVampireform)
								(all[i] As TweakVampireLord).VampirePeek()
							endif
							if (pTweakDragonBornScript.Installed && (all[i] As TweakWerebear).IsWerebearform)
								(all[i] As TweakWerebear).WerebearPeek()
							endif
						endif
						c += 1
					endif
				endif
			endif
		elseIf (0 != (FA.GetAv("WaitingforPlayer") as Int) && pDFScript)
			pDFScript.DialogueRef = all[i].GetActorRef()
			pDFScript.FollowerFollow()
		endif
		i = i + 1
	endWhile
EndFunction

Function Hangout(ObjectReference f)
	ReferenceAlias a = FindAlias(f)
	if (a)
		TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
		if (pDFScript)
			pDFScript.DialogueRef = f
			pDFScript.DismissFollower(-1, 0)
			(a as TweakSettings).Hangout()
		endif
	endif
endFunction

Function IgnoreWerewolfFollowers(Bool v)
	ignoreWerewolfFollowers = v
	if (!v)
		if (showMessages)
			IgnoreMsg.Show()
			Utility.wait(0.1) ; wait till they close the messagebox
		endif
		; Lets attack people...
		ReferenceAlias[] f =GetAllTweakFollowers()
		Int i = 0
		while (i != f.length)
			if (f[i].GetActorRef().IsInFaction(WerewolfFaction))
				(f[i] As TweakWerewolf).MakeFactionsHateWerewolf();
				(f[i] As TweakWerewolf).WerewolfPeek();
				return
			endif
			i = i + 1
		endWhile
		if (pTweakDawnGuardScript.Installed)
			i = 0
			while (i != f.length)
				if (f[i].GetActorRef().IsInFaction(pTweakDawnGuardScript.VampireLordFaction))
					(f[i] As TweakVampireLord).MakeFactionsHateVampire();
					(f[i] As TweakVampireLord).VampirePeek();
					return
				endif
				i = i + 1
			endWhile
		endif
		if (pTweakDragonBornScript.Installed)
			i = 0
			while (i != f.length)
				if (f[i].GetActorRef().IsInFaction(TweakWerebearFaction))
					(f[i] As TweakWerebear).MakeFactionsHateWerebear();
					(f[i] As TweakWerebear).WerebearPeek();
					return
				endif
				i = i + 1
			endWhile
		endif
	else
		; Change factions so current werewolves are not hostile
		ReferenceAlias[] f =GetAllTweakFollowers()
		Int i = 0
		while (i != f.length)
			if (f[i].GetActorRef().IsInFaction(WerewolfFaction))
				(f[i] As TweakWerewolf).MakeFactionsNeutralToWerewolf();
				return
			endif
			i = i + 1
		endWhile
		if (pTweakDawnGuardScript.Installed)
			i = 0
			while (i != f.length)
				if (f[i].GetActorRef().IsInFaction(pTweakDawnGuardScript.VampireLordFaction))
					(f[i] As TweakVampireLord).MakeFactionsNeutralToVampire();
					return
				endif
				i = i + 1
			endWhile
		endif		
		if (pTweakDragonBornScript.Installed)
			i = 0
			while (i != f.length)
				if (f[i].GetActorRef().IsInFaction(TweakWerebearFaction))
					(f[i] As TweakWerebear).MakeFactionsNeutralToWerebear();
					return
				endif
				i = i + 1
			endWhile
		endif		
	endif
endFunction

Function initializeTweakMap()
	TweakMap=new ReferenceAlias[90]
	TweakMap[0]=pAlias1
	TweakMap[1]=pAlias2
	TweakMap[2]=pAlias3
	TweakMap[3]=pAlias4
	TweakMap[4]=pAlias5
	TweakMap[5]=pAlias6
	TweakMap[6]=pAlias7
	TweakMap[7]=pAlias8
	TweakMap[8]=pAlias9
	TweakMap[9]=pAlias10
	TweakMap[10]=pAlias11
	TweakMap[11]=pAlias12
	TweakMap[12]=pAlias13
	TweakMap[13]=pAlias14
	TweakMap[14]=pAlias15
	TweakMap[15]=pAlias16
	TweakMap[16]=pAlias17
	TweakMap[17]=pAlias18
	TweakMap[18]=pAlias19
	TweakMap[19]=pAlias20
	TweakMap[20]=pAlias21
	TweakMap[21]=pAlias22
	TweakMap[22]=pAlias23
	TweakMap[23]=pAlias24
	TweakMap[24]=pAlias25
	TweakMap[25]=pAlias26
	TweakMap[26]=pAlias27
	TweakMap[27]=pAlias28
	TweakMap[28]=pAlias29
	TweakMap[29]=pAlias30
	TweakMap[30]=pAlias31
	TweakMap[31]=pAlias32
	TweakMap[32]=pAlias33
	TweakMap[33]=pAlias34
	TweakMap[34]=pAlias35
	TweakMap[35]=pAlias36
	TweakMap[36]=pAlias37
	TweakMap[37]=pAlias38
	TweakMap[38]=pAlias39
	TweakMap[39]=pAlias40
	TweakMap[40]=pAlias41
	TweakMap[41]=pAlias42
	TweakMap[42]=pAlias43
	TweakMap[43]=pAlias44
	TweakMap[44]=pAlias45
	TweakMap[45]=pAlias46
	TweakMap[46]=pAlias47
	TweakMap[47]=pAlias48
	TweakMap[48]=pAlias49
	TweakMap[49]=pAlias50
	TweakMap[50]=pAlias51
	TweakMap[51]=pAlias52
	TweakMap[52]=pAlias53
	TweakMap[53]=pAlias54
	TweakMap[54]=pAlias55
	TweakMap[55]=pAlias56
	TweakMap[56]=pAlias57
	TweakMap[57]=pAlias58
	TweakMap[58]=pAlias59
	TweakMap[59]=pAlias60
	TweakMap[60]=pAlias61
	TweakMap[61]=pAlias62
	TweakMap[62]=pAlias63
	TweakMap[63]=pAlias64
	TweakMap[64]=pAlias65
	TweakMap[65]=pAlias66
	TweakMap[66]=pAlias67
	TweakMap[67]=pAlias68
	TweakMap[68]=pAlias69
	TweakMap[69]=pAlias70
	TweakMap[70]=pAlias71
	TweakMap[71]=pAlias72
	TweakMap[72]=pAlias73
	TweakMap[73]=pAlias74
	TweakMap[74]=pAlias75
	TweakMap[75]=pAlias76
	TweakMap[76]=pAlias77
	TweakMap[77]=pAlias78
	TweakMap[78]=pAlias79
	TweakMap[79]=pAlias80
	TweakMap[80]=pAlias81
	TweakMap[81]=pAlias82
	TweakMap[82]=pAlias83
	TweakMap[83]=pAlias84
	TweakMap[84]=pAlias85
	TweakMap[85]=pAlias86
	TweakMap[86]=pAlias87
	TweakMap[87]=pAlias88
	TweakMap[88]=pAlias89
	TweakMap[89]=pAlias90
endFunction

Function initializeFollowerMap()
	FollowerMap = new ReferenceAlias[30]
	FollowerMap[0] = pDFQRef1
	FollowerMap[1] = pDFQRef2
	FollowerMap[2] = pDFQRef3
	FollowerMap[3] = pDFQRef4
	FollowerMap[4] = pDFQRef5
	FollowerMap[5] = pDFQRef6
	FollowerMap[6] = pDFQRef7
	FollowerMap[7] = pDFQRef8
	FollowerMap[8] = pDFQRef9
	FollowerMap[9] = pDFQRef10
	FollowerMap[10] = pDFQRef11
	FollowerMap[11] = pDFQRef12
	FollowerMap[12] = pDFQRef13
	FollowerMap[13] = pDFQRef14
	FollowerMap[14] = pDFQRef15
	FollowerMap[15] = pDFQRef16
	FollowerMap[16] = pDFQRef17
	FollowerMap[17] = pDFQRef18
	FollowerMap[18] = pDFQRef19
	FollowerMap[19] = pDFQRef20
	FollowerMap[20] = pDFQRef21
	FollowerMap[21] = pDFQRef22
	FollowerMap[22] = pDFQRef23
	FollowerMap[23] = pDFQRef24
	FollowerMap[24] = pDFQRef25
	FollowerMap[25] = pDFQRef26
	FollowerMap[26] = pDFQRef27
	FollowerMap[27] = pDFQRef28
	FollowerMap[28] = pDFQRef29
	FollowerMap[29] = pDFQRef30
	ReferenceAlias[] all = GetAllTweakFollowers()
	if (0 != all.length)
		numFollowers = all.length
		TweakFollowerCount.SetValueInt(numFollowers)
	endif
endFunction

Function InventorySnapshot(ObjectReference f, int type = 0)
	ReferenceAlias a = FindAlias(f)
	if (!a)
		Warning()
		return
	endif
	(a As TweakInventoryControl).InventorySnapshot((2 + type),true)
EndFunction



Function Pose(ObjectReference f, Int p)
	ReferenceAlias a = FindAlias(f)
	if (!a)
		Warning()
		return
	endif

	if (showMessages && !PoseHintOnce)
		PoseHintOnce = true
		PoseMsg.Show()
	endif
	(a as TweakPose).PoseFollower(p+10)
endFunction

Function possessFollower(ObjectReference f)
	ReferenceAlias a = findAlias(f)
	if (!a)
		Warning()
		return
	endif
	Actor pc = Game.GetPlayer()
	Spell other = pc.GetEquippedSpell(2)
	if (other)
		pc.UnequipSpell(other, 2)
	endif

	if (showMessages && !PossessHintOnce)
		PossessHintOnce = true
		PossessMsg.Show()
	endif
	TweakPossession pTweakPossession = a as TweakPossession
	if (pTweakPossession)
		pTweakPossession.command = 8
		a.RegisterForSingleUpdate(0.0)
		Utility.Wait(0.50)
	endif
endFunction

Function preparePose(ObjectReference follower)
	ReferenceAlias a = FindAlias(follower)
	if (!a)
		Warning()
		return
	endif
	(a as TweakPose).PreparePose()
endFunction

Function AftReset(bool stop=true)
	int confirm = TweakResetConfirm.show()
	if (1 == confirm)
		return
	endif
	confirmVersion()

	ResetHints()
	command=0
	PlayerHouse=None
	followerIgnoresFriendlyFire=TweakIgnoreFriendlyFire.GetValueInt()
	followerHoldback=TweakFollowerHoldBack.GetValueInt()
	followerNoMorals=TweakNoMorals.GetValueInt()
	followerFearless=TweakFearlessFollowers.GetValueInt()
	followerCanRide=TweakFollowerCanRide.GetValueInt()
	followerCatchup=TweakFollowerCatchUp.GetValueInt()
	followerNoTrap=TweakFollowerNoTrap.GetValueInt()
	followerRegen=TweakFollowerRegen.GetValueInt()
	followerPackMuleDisable=TweakPackMuleDisable.GetValueInt()
	rechargeWeaponsDisable=TweakRechargeWeaponsDisable.GetValueInt()
	ignoreWerewolfFollowers=TweakIgnoreWerewolfFollowers.GetValueInt()
	pcHasHorse=0
	TweakDFScript pTDF = DialogueFollower As TweakDFScript
	FollowerSynergy=True
	; Prevent lots of message popups:
	showMessages=false

	; Stables and Horses
	pTweakStables.AftReset()
	RHorseNote.Show()

	; Camp
	((self As Quest) As TweakCampScript).TearDownCamp()
	RCampNote.Show()

	; Reset TweakFollower Aliases

	int i = 0 
	int c = 0
	ReferenceAlias a
	while i < TweakMap.length
		a = TweakMap[i]
		if (a && a.GetActorRef())
			c += 1
			RManagedNote.Show(c, tfCount)
			Actor n = a.GetActorRef()

			n.RemoveFromFaction(PlayerFaction)
			n.RemoveFromFaction(TweakChattyFaction)
			n.RemoveFromFaction(TweakUseStaffFaction)
			n.RemoveFromFaction(pTweakImportFaction)
			n.RemoveFromFaction(pTweakPotentialFollowerFaction)

			(a As TweakVampire).AftReset()
			(a As TweakPossession).AftReset()
			(a As TweakWerewolf).AftReset()
			(a As TweakWerebear).AftReset()
			(a As TweakVampireLord).AftReset()
			(a As TweakPose).AftReset()
			(a As TweakInventoryControl).AftReset()
			(a As TweakLevelup).AftReset()
			(a As TweakMagic).AftReset()
			(a As TweakSettings).AftReset()

			n.SetAv("Infamy",0) ; - Used by Sleep AI
			n.SetAv("Fame",0) ; - Used For bonus outfits
			n.SetAv("FavorActive",0) ; - Used for ID hash lookup of followers
			n.SetAv("FavorsPerDay",0); - Used for No Trap conditionals in trap base scripts
			n.SetAv("FavorsPerDayTimer",0); - Controls Combat Style

			a.Clear()
		endif
		i += 1
	endWhile
	tfCount=0

	RNPCsNote.Show()
	if (pDFQRef1 && pDFQRef1.GetActorRef())
		pTDF.DialogueRef = pDFQRef1.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef2 && pDFQRef2.GetActorRef())
		pTDF.DialogueRef = pDFQRef2.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef3 && pDFQRef3.GetActorRef())
		pTDF.DialogueRef = pDFQRef3.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef4 && pDFQRef4.GetActorRef())
		pTDF.DialogueRef = pDFQRef4.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef5 && pDFQRef5.GetActorRef())
		pTDF.DialogueRef = pDFQRef5.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef6 && pDFQRef6.GetActorRef())
		pTDF.DialogueRef = pDFQRef6.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef7 && pDFQRef7.GetActorRef())
		pTDF.DialogueRef = pDFQRef7.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef8 && pDFQRef8.GetActorRef())
		pTDF.DialogueRef = pDFQRef8.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef9 && pDFQRef9.GetActorRef())
		pTDF.DialogueRef = pDFQRef9.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef10 && pDFQRef10.GetActorRef())
		pTDF.DialogueRef = pDFQRef10.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef11 && pDFQRef11.GetActorRef())
		pTDF.DialogueRef = pDFQRef11.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef12 && pDFQRef12.GetActorRef())
		pTDF.DialogueRef = pDFQRef12.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef13 && pDFQRef13.GetActorRef())
		pTDF.DialogueRef = pDFQRef13.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef14 && pDFQRef14.GetActorRef())
		pTDF.DialogueRef = pDFQRef14.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef15 && pDFQRef15.GetActorRef())
		pTDF.DialogueRef = pDFQRef15.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef16 && pDFQRef16.GetActorRef())
		pTDF.DialogueRef = pDFQRef16.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef17 && pDFQRef17.GetActorRef())
		pTDF.DialogueRef = pDFQRef17.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef18 && pDFQRef18.GetActorRef())
		pTDF.DialogueRef = pDFQRef18.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef19 && pDFQRef19.GetActorRef())
		pTDF.DialogueRef = pDFQRef19.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef20 && pDFQRef20.GetActorRef())
		pTDF.DialogueRef = pDFQRef20.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef21 && pDFQRef21.GetActorRef())
		pTDF.DialogueRef = pDFQRef21.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef22 && pDFQRef22.GetActorRef())
		pTDF.DialogueRef = pDFQRef22.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef23 && pDFQRef23.GetActorRef())
		pTDF.DialogueRef = pDFQRef23.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef24 && pDFQRef24.GetActorRef())
		pTDF.DialogueRef = pDFQRef24.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef25 && pDFQRef25.GetActorRef())
		pTDF.DialogueRef = pDFQRef25.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef26 && pDFQRef26.GetActorRef())
		pTDF.DialogueRef = pDFQRef26.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef27 && pDFQRef27.GetActorRef())
		pTDF.DialogueRef = pDFQRef27.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef28 && pDFQRef28.GetActorRef())
		pTDF.DialogueRef = pDFQRef28.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef29 && pDFQRef29.GetActorRef())
		pTDF.DialogueRef = pDFQRef29.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	if (pDFQRef30 && pDFQRef30.GetActorRef())
		pTDF.DialogueRef = pDFQRef30.GetRef()
		pTDF.DismissFollower(-1,1)
		Utility.wait(0.5)
	endif
	numFollowers=0
	TweakFollowerCount.SetValueInt(0)
	pTweakMoreInteractive.SetValueInt(1)
	pTweakExtraDamage.SetValue(0)
	pTweakAITimeMode.SetValue(0)
	pTweakRechargeThreshold.SetValue(125)
	pTweakRootBackPack.SetValue(1.0)

	showMessages=TweakShowMessages.GetValueInt()

	if (stop)
		pTweakMonitorPlayerScript.AftReset()
	else
		RCompleteNote.show()
	endif
	
	; Deprecated 1.6
	followerEssential=true	
endFunction

Function CheckCombat()
	if Game.GetPlayer().IsInCombat()
		CombatRunningFlag = true
		RegisterForSingleUpdate(20)
	else
		CombatOverFlag = true	
		RegisterForSingleUpdate(10)
	endif
EndFunction

Function RelayCombatEndEvent()
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	Int num = f.length
	if (num > 0)
		while (i != num)
			(f[i] As TweakSettings).OnCombatEnd();
			(f[i] As TweakWerewolf).OnCombatEnd();
			(f[i] As TweakWerebear).OnCombatEnd();
			(f[i] As TweakVampire).OnCombatEnd();
			(f[i] As TweakVampireLord).OnCombatEnd();
			(f[i] As TweakMagic).OnCombatEnd();
			(f[i] As TweakInventoryControl).OnCombatEnd();
			i = i + 1
		endWhile
	endif
	
	; This is a very elaborate fix for a simple bug. If the user gives Vampire followers
	; potions of blood, when the followers drink them, the player will partially become
	; a vampire again. That is, they get sun damage and vampire powers, even if their 
	; race doesn't change. It is really a dawnguard bug, but I have a fix here as I imagine
	; it could be common.
	
	if (0.0 == pPlayerIsVampire.GetValue() && pTweakDawnGuardScript.installed)
		Actor pc = Game.GetPlayer()
		Bool hasSunDamage = false
		if pc.HasSpell(pVampireSunDamage01)
			;Debug.Notification("VampireSunDamage01")
			hasSunDamage = true
		endif
		if pc.HasSpell(pVampireSunDamage02)
			;Debug.Notification("VampireSunDamage02")
			hasSunDamage = true
		endif
		if pc.HasSpell(pVampireSunDamage03)
			;Debug.Notification("VampireSunDamage03")
			hasSunDamage = true
		endif
		if pc.HasSpell(pVampireSunDamage04)
			;Debug.Notification("VampireSunDamage04")
			hasSunDamage = true
		endif
		if pc.HasSpell(crVampireSunDamage)
			;Debug.Notification("crVampireSunDamage")
			hasSunDamage = true
		endif
		if pc.HasSpell(pTweakDawnGuardScript.VampireLordSunDamage)
			;Debug.Notification("VampireLordSunDamage")
			hasSunDamage = true
		endif
		if (hasSunDamage)
			;Debug.Notification("Fixing")
			(PlayerVampireQuest as PlayerVampireQuestScript).VampireCure(Game.Getplayer())
		endif
	endif
	
EndFunction

Function ResetFollower(ObjectReference follower)

	int confirm = TweakResetNPCConfirm.show()
	if (1 == confirm)
		return
	endif

	Actor n = follower As Actor
	if !n
		Return
	EndIf
	
	; Prevent lots of message popups:
	bool oldShow = showMessages
	showMessages=false
	
	
	n.RemoveFromFaction(PlayerFaction)
	n.RemoveFromFaction(TweakChattyFaction)
	n.RemoveFromFaction(TweakUseStaffFaction)
	n.RemoveFromFaction(pTweakImportFaction)
	n.RemoveFromFaction(pTweakPotentialFollowerFaction)
	
	n.SetAv("Infamy",0) ; - Used by Sleep AI
	n.SetAv("Fame",0) ; - Used For bonus outfits
	n.SetAv("FavorsPerDay",0); - Used for No Trap conditionals in trap base scripts
	n.SetAv("FavorsPerDayTimer",0); - Controls Combat Style	
	int TweakMapIndex = (n.GetAV("FavorActive") As Int) - 1
	n.SetAv("FavorActive",0) ; - Used for ID hash lookup of followers
	
	if TweakMapIndex > -1
		ReferenceAlias a = TweakMap[TweakMapIndex]
		if a.GetActorRef()
			(a As TweakVampire).AftReset(true)
			(a As TweakPossession).AftReset()
			(a As TweakWerewolf).AftReset(true)
			(a As TweakWerebear).AftReset(true)
			(a As TweakVampireLord).AftReset(true)
			(a As TweakPose).AftReset()
			(a As TweakInventoryControl).AftReset()
			(a As TweakLevelup).AftReset()
			(a As TweakMagic).AftReset()
			(a As TweakSettings).AftReset()
			a.Clear()
		Else
			Debug.Notification("Reset Partial Failure. Follower already Reset by AFT")
		endif
	else
		Debug.Notification("Reset Partial Failure. Follower Unrecognized by AFT")
	endif
	
	if (pTweakDawnGuardScript.Installed && n == pTweakDawnGuardScript.Serena)
		n.AddToFaction(pTweakPotentialFollowerFaction)
		n.AddToFaction(TweakHasVLGift)
	endif
	
	TweakDFScript pTDF = DialogueFollower As TweakDFScript
	if (pTDF)
	
	if (pDFQRef1 && pDFQRef1.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef1.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef2 && pDFQRef2.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef2.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef3 && pDFQRef3.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef3.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef4 && pDFQRef4.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef4.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef5 && pDFQRef5.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef5.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef6 && pDFQRef6.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef6.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef7 && pDFQRef7.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef7.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef8 && pDFQRef8.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef8.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef9 && pDFQRef9.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef9.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef10 && pDFQRef10.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef10.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef11 && pDFQRef11.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef11.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef12 && pDFQRef12.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef12.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef13 && pDFQRef13.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef13.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef14 && pDFQRef14.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef14.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef15 && pDFQRef15.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef15.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef16 && pDFQRef16.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef16.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef17 && pDFQRef17.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef17.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef18 && pDFQRef18.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef18.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef19 && pDFQRef19.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef19.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef20 && pDFQRef20.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef20.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef21 && pDFQRef21.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef21.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef22 && pDFQRef22.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef22.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef23 && pDFQRef23.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef23.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef24 && pDFQRef24.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef24.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef25 && pDFQRef25.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef25.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef26 && pDFQRef26.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef26.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef27 && pDFQRef27.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef27.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef28 && pDFQRef28.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef28.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef29 && pDFQRef29.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef29.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		elseif (pDFQRef30 && pDFQRef30.GetActorRef() == n)
			pTDF.DialogueRef = pDFQRef30.GetRef()
			pTDF.DismissFollower(-1,1)
			Utility.wait(0.5)
		endif
		
	endif
	if oldShow
		showMessages=TweakShowMessages.GetValueInt()
	EndIf
EndFunction

Function ResetHints()
	PossessHintOnce = false
	PoseHintOnce = false
	FreezeHintOnce = false
	TweakFollowerSpells tspells= ((Self As Quest) As TweakFollowerSpells)
	BehindHintOnce = false
	StealthHintOnce = false
	tspells.DisableMagicHintOnce=false
	tspells.ViewTeachHintOnce=false
	tspells.ViewTeachCombatHintOnce=false
	tspells.AddSetHintOnce=false
	tspells.ClearHintOnce=false
endFunction

Function RoundUpHorses()
	pTweakStables.RoundUpHorses()
	pcHasHorse=1
endFunction

Function SetCanRide(Bool v)
	followerCanRide=v
	TweakFollowerCanRide.SetValueInt(followerCanRide as int)
endFunction

Function SetCatchup(Bool v)
	if (showMessages)
		if (v && !followerEssential)
			CatchupMsg.Show()
		endif
	endif
	followerCatchup = v
	TweakFollowerCatchUp.SetValueInt(followerCatchup as int)
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		(f[i] As TweakSettings).enforceSettings();
		i = i + 1
	endWhile
endFunction

Function SetCombatStyle(ObjectReference f, int v)
	ReferenceAlias a=FindAlias(f)
	if (!a)
		Warning()
		return
	endif
	Actor n = f As Actor
	n.SetAV("FavorsPerDayTimer",v)
	if (v != (n.GetAV("FavorsPerDayTimer") As Int))
		n.ForceAV("FavorsPerDayTimer",v)
	endif
	(a As TweakLevelUp).ResetAndLevelUp()
	if (0 != v)
		if (v > 732 && v < 738)
			if (showMessages && !n.IsInFaction(TweakDisableMagicFaction))
				MagicDisabledMsg.Show()
			endif
			(a As TweakMagic).SetDisableMagic(true)
		else
			if (showMessages && n.IsInFaction(TweakDisableMagicFaction))
				MagicEnabledMsg.Show()
			endif
			(a As TweakMagic).SetDisableMagic(false)
		endif
	endif
	n.EvaluatePackage()
endFunction

; StealthAttack
Function AllAttack(int t=2)
	pTweakStopAll.SetValue(0.0)
	if (1.0 == pTweakStealthActive.GetValue())
		StealthDetected()
	endif
	TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
	if (pDFScript)
		ReferenceAlias[] f = GetAllTweakFollowers()
		int i = 0
		while (i != f.length)
			pDFScript.DialogueRef = f[i].GetActorRef()
			pDFScript.FollowerFollow()
			f[i].GetActorRef().EvaluatePackage()
			TweakSettings pTweakSettings = f[i] As TweakSettings
			if (pTweakSettings)
				pTweakSettings.command = t
				f[i].RegisterForSingleUpdate(0.0)
			endif
			i += 1
		endwhile
	endif
endFunction

Function SetFearless(Bool v)
	followerFearless = v
	TweakFearlessFollowers.SetValueInt(followerFearless as int)
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		(f[i] As TweakSettings).enforceSettings()
		i += 1
	endWhile
endFunction

Function SetFollowerRegen(Bool pRegen)
	followerRegen = pRegen
	TweakFollowerRegen.SetValueInt(followerRegen as int)
EndFunction

Function SetHoldback(Bool v)
	followerHoldback = v
	TweakFollowerHoldback.SetValueInt(followerHoldback as int)
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		(f[i] As TweakSettings).enforceSettings()
		i += 1
	endWhile
endFunction

Function SetIgnoresFriendlyFire(Bool v)
	followerIgnoresFriendlyFire = v
	TweakIgnoreFriendlyFire.SetValueInt(followerIgnoresFriendlyFire as int)
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		f[i].GetActorRef().IgnoreFriendlyHits(v)
		f[i].GetActorRef().GetActorBase().SetInvulnerable(v)
		i += 1
	endWhile
endFunction

Function SetManualLU(ObjectReference f, Bool b)
	ReferenceAlias a = FindAlias(f)
	if (!a)
		Warning()
		return
	endif
	(a as TweakLevelUp).SetManual(b)
endFunction

Function SetNoMorals(Bool v)
	followerNoMorals = v
	TweakNoMorals.SetValueInt(followerNoMorals as int)
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		(f[i] As TweakSettings).enforceSettings()
		i += 1
	endWhile
endFunction

Function SetNoTrap(Bool v)
	followerNoTrap=v
	TweakFollowerNoTrap.SetValueInt(followerNoTrap as int)
	ReferenceAlias[] f = GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		(f[i] As TweakSettings).enforceSettings();
		i += 1
	endWhile
endFunction

Function SetPackMule(Bool v)
	followerPackMuleDisable = !v
	TweakPackMuleDisable.SetValueInt(followerPackMuleDisable as int)
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		(f[i] As TweakSettings).enforceSettings()
		i += 1
	endWhile
endFunction

Function SetPlayerHouse(bool makehome=true)
	PlayerHouse = None
	if !makehome
		return
	endif
	Location currentLocation = Game.GetPlayer().GetCurrentLocation()
	if currentLocation
		PlayerHouse = currentLocation
		ReferenceAlias[] f =GetAllTweakFollowers()
		Int i = 0
		while (i != f.length)
			(f[i] As TweakInventoryControl).OnLoadHelper()
			i += 1
		endWhile
	Else
		Debug.MessageBox("Current Location can not be used as Player House")
	endif
EndFunction

; Relayed from Stables Script. Note that if riding is False
; (player has dismounted), TweakMonitorPlayer informs DialogueFollower 
; directly for faster reaction. (No need to call evaluatePackage)
Function SetRiding(bool r=true)
	if (followerCanRide)
		ReferenceAlias[] f
		int i = 0
		; Transform to human to allow mount
		if (r)
			f = GetAllTweakFollowers(true)
			while (i != f.length)
				TweakWerewolf pTweakWerewolf = (f[i] As TweakWerewolf)
				if (pTweakWerewolf)
					if (pTweakWerewolf.IsWerewolfForm && !pTweakWerewolf.RemainWerewolf)
						pTweakWerewolf.command = 7
						f[i].RegisterForSingleUpdate(0.0)
					endif
				endif
				i += 1
			EndWhile
			if pTweakDawnGuardScript.Installed
				i = 0
				while (i != f.length)
					TweakVampireLord pTweakVampireLord = (f[i] As TweakVampireLord)
					if (pTweakVampireLord)
						if (pTweakVampireLord.IsVampireForm && !pTweakVampireLord.RemainVampire)
							pTweakVampireLord.command = 7
							f[i].RegisterForSingleUpdate(0.0)
						endif
					endif
					i += 1
				EndWhile
			endif
			if pTweakDragonBornScript.Installed
				i = 0
				while (i != f.length)
					TweakWerebear pTweakWerebear = (f[i] As TweakWerebear)
					if (pTweakWerebear)
						if (pTweakWerebear.IsWerebearForm && !pTweakWerebear.RemainWerebear)
							pTweakWerebear.command = 7
							f[i].RegisterForSingleUpdate(0.0)
						endif
					endif
					i += 1
				EndWhile
			endif
			Utility.Wait(0.50)
			i = 0
			while (i != f.length)
				Actor n = f[i].GetActorRef()
				n.EvaluatePackage()
				i += 1
			endWhile
		endif
	endif
endFunction

Function SetShowHint(Bool v)
	showMessages = v
endFunction

Function SetUseVampireSpells(ObjectReference n, Bool v)
	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	(a as TweakVampire).SetUseVampireSpells(v)
endFunction

Function SetWerewolf(ObjectReference n, Bool v)
	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	if (v)
		TweakWerewolf pTweakWerewolf = a as TweakWerewolf
		if (!(n as Actor).HasSpell(WerewolfChange))
		;	int c=TweakWerewolfConfirm.show()
		;	if (0 == c)
				pTweakMonitorPlayerScript.Unsettle()
				if (pTweakWerewolf)
					pTweakWerewolf.command=6
					a.RegisterForSingleUpdate(0.0)
					Utility.Wait(0.50)
				endif
		;	endif
		else
			pTweakMonitorPlayerScript.Unsettle()
			if (pTweakWerewolf)
				pTweakWerewolf.SetUseWerewolf(true)
				pTweakWerewolf.command=6
				a.RegisterForSingleUpdate(0.0)
				Utility.Wait(0.50)
			endif
		endif
	else
		TweakWerewolf pTweakWerewolf = a as TweakWerewolf
		if (pTweakWerewolf)
			pTweakWerewolf.command = 7
			a.RegisterForSingleUpdate(0.0)
			Utility.Wait(0.50)
		endif
	endif
endFunction

Function SetVampire(ObjectReference n, Bool v)
	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	if (v)
		TweakVampireLord pTweakVampireLord = a as TweakVampireLord
		if (!(n as Actor).IsInFaction(TweakHasVLGift))
			int c=TweakVampireConfirm.show()
			if (0 == c)
				pTweakMonitorPlayerScript.Unsettle()
				if (pTweakVampireLord)
					pTweakVampireLord.command=6
					a.RegisterForSingleUpdate(0.0)
					Utility.Wait(0.50)
				endif
			endif
		else
			pTweakMonitorPlayerScript.Unsettle()
			if (pTweakVampireLord)
				pTweakVampireLord.SetUseVampire(true)
				pTweakVampireLord.command=6
				a.RegisterForSingleUpdate(0.0)
				Utility.Wait(0.50)
			endif
		endif
	else
		TweakVampireLord pTweakVampireLord = a as TweakVampireLord
		if (pTweakVampireLord)
			pTweakVampireLord.command = 7
			a.RegisterForSingleUpdate(0.0)
			Utility.Wait(0.50)
		endif
	endif
endFunction

Function SetWerebear(ObjectReference n, Bool v)
	if !pTweakDragonBornScript.Installed
		Return
	endif
	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	if (v)
		TweakWerebear pTweakWerebear = a as TweakWerebear
		if (!(n as Actor).HasSpell(pTweakDragonBornScript.WerebearChange))
			int c=TweakWerebearConfirm.show()
			if (0 == c)
				pTweakMonitorPlayerScript.Unsettle()
				if (pTweakWerebear)
					pTweakWerebear.command=6
					a.RegisterForSingleUpdate(0.0)
					Utility.Wait(0.50)
				endif
			endif
		else
			pTweakMonitorPlayerScript.Unsettle()
			if (pTweakWerebear)
				pTweakWerebear.SetUseWerebear(true)
				pTweakWerebear.command=6
				a.RegisterForSingleUpdate(0.0)
				Utility.Wait(0.50)
			endif
		endif
	else
		TweakWerebear pTweakWerebear = a as TweakWerebear
		if (pTweakWerebear)
			pTweakWerebear.command = 7
			a.RegisterForSingleUpdate(0.0)
			Utility.Wait(0.50)
		endif
	endif
endFunction

Function AllTransformWerebear(Bool bToW=true)
	ReferenceAlias[] f = GetAllTweakFollowers()
	pTweakMonitorPlayerScript.Unsettle()
	Int i=0
	while (i != f.length)
		(f[i] As TweakWerebear).ToggleTransform(bToW)
		i += 1
	endWhile
endFunction

Function AllTransformWereWolf(Bool bToW=true)
	ReferenceAlias[] f = GetAllTweakFollowers()
	pTweakMonitorPlayerScript.Unsettle()
	Int i=0
	while (i != f.length)
		(f[i] As TweakWerewolf).ToggleTransform(bToW)
		i += 1
	endWhile
endFunction

Function AllTransformVampire(Bool bToV=true)
	ReferenceAlias[] f = GetAllTweakFollowers()
	pTweakMonitorPlayerScript.Unsettle()
	Int i=0
	while (i != f.length)
		(f[i] As TweakVampireLord).ToggleTransform(bToV)
		i += 1
	endWhile
endFunction

Function StableHorses()
	pTweakStables.StableHorses()
	pcHasHorse=2
endFunction

Function stealth()

	if (showMessages && !StealthHintOnce)
		StealthHintOnce = true
		TweakStealthMsg.Show()
	endif
	
	ReferenceAlias[] f = GetAllTweakFollowers()
	
	if (f)
		if (0.0 == pTweakStealthActive.GetValue())
			Float fNewValue = pTweakStealthActive.Mod(1.0)
			if (1.0 == fNewValue)
			Else
				pTweakStealthActive.SetValue(1.0)
			endif
			int i=0
			while (i != f.length)
				(f[i] As TweakSettings).stealth();
				i += 1
			endWhile
		else
			Float fNewValue = pTweakStealthActive.Mod(-1.0)
			if (0.0 == fNewValue)
				Debug.Notification("Stealth Removed")
			Else
				pTweakStealthActive.SetValue(0.0)
			endif
			int i=0
			while (i != f.length)
				(f[i] As TweakSettings).OnStealthDetected()
				i += 1
			endWhile
		endif
	endIf

EndFunction



Function StopManagingInventory(ObjectReference n, int type=0)
	ReferenceAlias a=FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	if (0 == type)
		(a As TweakInventoryControl).DisableOutfitControl()
	elseif (1 == type)
		(a As TweakInventoryControl).DisableCityOutfit()
	elseif (2 == type)
		(a As TweakInventoryControl).DisableHomeOutfit()
	endif
endFunction

Function StartManagingInventory(ObjectReference n, int type=0)
	ReferenceAlias a=FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	if (0 == type)
		(a As TweakInventoryControl).EnableOutfitControl()
		if (pTweakDawnGuardScript.Installed)
			Actor npc = n As Actor
			if (npc == pTweakDawnGuardScript.Serena && npc.IsInFaction(TweakManagedInventoryFaction))
				int armors = n.GetItemCount(pTweakDawnGuardScript.ArmorVampireArmorRoyal)
				if 0 != armors
					; This is a nasty hack, but it works...
					Utility.wait(2.0)
					n.RemoveItem(pTweakDawnGuardScript.ArmorVampireArmorRoyal,armors,true)
					Utility.wait(0.25)
					n.AddItem(TweakArmorVampireArmorRoyalRed,armors,false)
				endif
				int hood = npc.GetItemCount(pTweakDawnGuardScript.SeranaHood)
				if 0 != hood
					n.RemoveItem(pTweakDawnGuardScript.SeranaHood,hood,true)
				endif
			endif
		endif
	elseif (1 == type)
		(a As TweakInventoryControl).EnableCityOutfit()
	elseif (2 == type)
		(a As TweakInventoryControl).EnableHomeOutfit()
	endif
endFunction

Function TakeAllGear(ObjectReference n, bool opt)
	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	(a as TweakInventoryControl).TakeAllGear(opt)
endFunction

Function ToggleChatty(ObjectReference n)
	Actor npc = n As Actor
	if npc.IsInFaction(TweakChattyFaction)
		npc.RemoveFromFaction(TweakChattyFaction)
	Else
		npc.AddToFaction(TweakChattyFaction)
	endif
EndFunction
Function ToggleEssential(ObjectReference n, Bool pEssential)

	if (showMessages)
		if (!pEssential && followerCatchup)
			EssentialMsg.Show()
		endif
	endif

	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	(a as TweakSettings).ToggleEssential(pEssential)
EndFunction

Function ToggleExtraDamage(Bool pExtraDamage)
	if pExtraDamage
		pTweakExtraDamage.SetValue(1.0)
	Else
		pTweakExtraDamage.SetValue(0.0)
	endif
EndFunction

Function ToggleRegen(ObjectReference n, Bool pRegen)
	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	(a as TweakMagic).ToggleRegen(pRegen)
EndFunction

Function ToggleAutoHeal(ObjectReference n, Bool pAutoHeal)
	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	(a as TweakMagic).ToggleAutoHeal(pAutoHeal)
EndFunction

Function ToggleFar(ObjectReference ref, Bool pfar)
	Actor npc = ref As Actor
	if (npc)
		if pfar
			npc.AddToFaction(TweakFarFaction)
		Else
			npc.RemoveFromFaction(TweakFarFaction)
		EndIf
	EndIf
endFunction
				
Function ToggleHelmet(ObjectReference f, Bool on)
	ReferenceAlias a = FindAlias(f)
	if (a)
		Actor n=f As Actor
		if (on)
			n.RemoveFromFaction(TweakHelmetCombatOnlyFaction)
			(a as TweakInventoryControl).EquipHelmet()
		else
			n.AddToFaction(TweakHelmetCombatOnlyFaction)
			(a as TweakInventoryControl).RemoveHelmet()
		endif
		Armor JewelryRingGold = Game.GetFormFromFile(0x01CF2B, "Skyrim.esm") as Armor
		n.EquipItem(JewelryRingGold)
		n.RemoveItem(JewelryRingGold)
	else
		Warning()
	endif
endFunction

Function ToggleNoAuto(ObjectReference ref, Bool pNoAuto)
	Actor npc = ref As Actor
	if (npc)
		if pNoAuto
			npc.AddToFaction(TweakNoAutoRelax)
		Else
			npc.RemoveFromFaction(TweakNoAutoRelax)
		EndIf
	EndIf
EndFunction

Function ToggleRecharge(ObjectReference n, Bool pRecharge)
	ReferenceAlias a = FindAlias(n)
	if (!a)
		Warning()
		return
	endif
	(a as TweakSettings).ToggleRecharge(pRecharge)
EndFunction

Function ToggleStatBoost()
	followerNoBoostStats = !followerNoBoostStats
	ReferenceAlias[] f =GetAllTweakFollowers()
	Int i = 0
	while (i != f.length)
		(f[i] As TweakLevelUp).ResetAndLevelUp()
		i += 1
	endWhile
endFunction

Float[] Function TraceCircle(ObjectReference n, Float radius = 500.0, Float angleOffset = 0.0)
    float a = n.GetAngleZ();
    a = 450 - a
    if (a >= 360)
        a = a - 360
    endif 
    a  = a + angleOffset;
    if (a < 0) 
        a = a + 360
    endif
    if (a > 360)
        a = a - 360
    endif 

    Float xoffset = radius * Math.cos(a)
    Float yoffset = radius * Math.sin(a)

    Float[] r = new Float[3]
    r[0] =  (n.GetPositionX() + xoffset)
    r[1] =  (n.GetPositionY() + yoffset)
    r[2] = n.GetPositionZ()
    return r

endFunction

Function TransferDuplicateGear(ObjectReference follower, Int filter)
	ReferenceAlias a = FindAlias(follower)
	if (!a)
		Warning()
		return
	endif
	(a as TweakInventoryControl).TransferDuplicateGear(filter)
endFunction

Function UnEquipGear(ObjectReference follower)
	ReferenceAlias a = FindAlias(follower)
	if (a)
		(a as TweakInventoryControl).UnequipGear()
	endif
endFunction

Int Function UsedSlots()
	tfCount = 0

	ReferenceAlias r = None
	int i = 0
	Actor f

	while (i < 90)
		r = TweakMap[i]
		f = r.GetActorRef()
		if (f && !f.IsDead())
			tfCount += 1
		EndIf
		i += 1
	EndWhile
	return tfCount
EndFunction

Function UseWerewolf(ObjectReference follower, Bool value)
	; no need to check if in combat as you can't talk to people in combat
	if (showMessages)
		if (value && !ignoreWerewolfFollowers)
		;	WerewolfMsg.Show()
			Utility.wait(0.01)
		endif
	endif
	ReferenceAlias a = findAlias(follower)
	if (!a)
		Warning()
		return
	endif
	pTweakMonitorPlayerScript.Unsettle()
	(a as TweakWerewolf).SetUseWerewolf(value)		
endFunction

Function UseWerebear(ObjectReference follower, Bool value)
	; no need to check if in combat as you can't talk to people in combat
	if (showMessages)
		if (value && !ignoreWerewolfFollowers)
		;	WerewolfMsg.Show()
			Utility.wait(0.01)
		endif
	endif
	ReferenceAlias a = findAlias(follower)
	if (!a)
		Warning()
		return
	endif
	pTweakMonitorPlayerScript.Unsettle()
	(a as TweakWerebear).SetUseWerebear(value)		
endFunction

Function UseVampire(ObjectReference follower, Bool value)
	if (showMessages)
		if (value && !ignoreWerewolfFollowers)
		;	WerewolfMsg.Show()
			Utility.wait(0.01)
		endif
	endif
	ReferenceAlias a = findAlias(follower)
	if (!a)
		Warning()
		return
	endif
	pTweakMonitorPlayerScript.Unsettle()
	(a as TweakVampireLord).SetUseVampire(value)		
endFunction

Function ViewInventory(ObjectReference follower, Int type=0)

	ReferenceAlias a = findAlias(follower)
	if (!a)
		Warning()
		return
	endif
	if (0 == type)
		(a as TweakInventoryControl).ViewInventory()
	elseif (4 == type)
		(a as TweakInventoryControl).OpenBackPack()
	elseif (1 == type)
		(a as TweakInventoryControl).ViewStandard()
	elseif (2 == type)
		(a as TweakInventoryControl).ViewCity()
	elseif (3 == type)
		(a as TweakInventoryControl).ViewHome()
	endif

endFunction

Function Warning()
	UnrecognizedMsg.Show(version)
endFunction

; Deprecated 1.6
Function SetEssential(Bool v)
endFunction

Bool Property rechargeWeaponsDisable Auto Conditional
Bool Property followerEssential Auto Conditional

; Deprecated 1.5
Bool Property pcRiding Auto Conditional
Bool Property InventoryHintOnce Auto

Function RemovePlayerFaction()
	TweakFollowerCanRide.SetValueInt(0)
	pTweakStopAll.SetValue(0.0)
	TweakDFScript pDFScript = (DialogueFollower As TweakDFScript)
	if (pDFScript)
		ReferenceAlias[] f = GetAllTweakFollowers()
		int i=0
		while (i != f.length)
			f[i].GetActorRef().RemoveFromFaction(PlayerFaction)
			f[i].GetActorRef().EvaluatePackage()
			i += 1
		endWhile
	endif
endFunction

