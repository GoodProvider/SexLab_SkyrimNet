Scriptname TweakVampire extends ReferenceAlias  

TweakFollowerScript property pTweakFollowerScript auto
TweakDawnGuardScript Property pTweakDawnGuardScript Auto
Faction Property CurrentFollowerFaction auto
Faction Property TweakHasVampGift Auto
Bool Property CombatInProgress auto
Int property previousLevel auto
int property command auto
ReferenceAlias property pAddVampireKeyword auto
TextureSet Property VampireEyes Auto
Bool Property Update auto
Float Property VampireChangeTimer Auto
GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property Gamehour Auto
EffectShader Property DmgVis4  Auto

; Track if this NPC can use Vampire Powers or not
Faction Property TweakVampireSpellsFaction Auto

; Make them more powerful as they level up. 
Spell Property AbVampire01 Auto
Spell Property AbVampire02 Auto
Spell Property AbVampire03 Auto
Spell Property AbVampire04 Auto
Spell Property AbVampire01b Auto
Spell Property AbVampire02b Auto
Spell Property AbVampire03b Auto
Spell Property AbVampire04b Auto
Spell Property VampireDrain01 Auto
Spell Property VampireDrain02 Auto
Spell Property VampireDrain03 Auto
Spell Property VampireDrain04 Auto
Spell Property VampireRaiseThrall01 Auto
Spell Property VampireRaiseThrall02 Auto
Spell Property VampireRaiseThrall03 Auto
Spell Property VampireRaiseThrall04 Auto
Spell Property crVampireUnarmedDamage02 Auto
Spell Property crVampireUnarmedDamage03 Auto
Spell Property crVampireUnarmedDamage04 Auto
Spell Property crVampireUnarmedDamage05 Auto
Spell Property VampireSunDamage01 Auto
Spell Property VampireSunDamage02 Auto
Spell Property VampireSunDamage03 Auto
Spell Property VampireSunDamage04 Auto
Spell Property VampireHuntersSight Auto
Spell Property VampireCharm Auto
Spell Property VampireCloak Auto
Spell Property VampireInvisibilityPC Auto

; Used to detect current (Though we could lookup from Tweak Settings)
Race Property ArgonianRace  Auto  
Race Property BretonRace  Auto  
Race Property DarkElfRace  Auto  
Race Property HighElfRace  Auto  
Race Property ImperialRace  Auto  
Race Property KhajiitRace  Auto  
Race Property NordRace  Auto  
Race Property OrcRace  Auto  
Race Property RedguardRace  Auto  
Race Property WoodElfRace  Auto  

; New Vampire Race
Race Property ArgonianRaceVampire  Auto  
Race Property BretonRaceVampire  Auto  
Race Property DarkElfRaceVampire  Auto  
Race Property HighElfRaceVampire  Auto  
Race Property ImperialRaceVampire  Auto  
Race Property KhajiitRaceVampire  Auto  
Race Property NordRaceVampire  Auto  
Race Property OrcRaceVampire  Auto  
Race Property RedguardRaceVampire  Auto  
Race Property WoodElfRaceVampire  Auto  

; So we know when they are a vampire
Spell Property ABVampireSkills Auto
Spell Property ABVampireSkills02 Auto

; Used for Transform cut scene:
effectShader property VampireChangeFX auto
Idle Property VampireFeedingBedrollRight Auto
Sound  Property MagVampireTransform01  Auto  
VisualEffect Property DisguiseCastVFX01  Auto  
VisualEffect Property DisguiseTargetVFX01  Auto  

Idle Property IdleMagic_01 Auto
Spell Property firstSpell Auto


Function AftReset(Bool partial=false)

	Actor npc = self.GetActorRef()
	TweakSettings pTweakSettings = (self as ReferenceAlias)  As TweakSettings
	if (!partial)
		if (pTweakSettings && pTweakSettings.originalRace)
			npc.SetRace(pTweakSettings.originalRace)

		endif

		npc.RemoveSpell(ABVampireSkills)
		npc.RemoveSpell(ABVampireSkills02)
		npc.RemoveSpell(AbVampire01)
		npc.RemoveSpell(AbVampire01b)
		npc.RemoveSpell(VampireDrain01)
		npc.RemoveSpell(VampireRaiseThrall01)
		npc.RemoveSpell(crVampireUnarmedDamage02)
		npc.RemoveSpell(VampireSunDamage01)
		npc.RemoveSpell(AbVampire02)
		npc.RemoveSpell(AbVampire02b)
		npc.RemoveSpell(VampireDrain02)
		npc.RemoveSpell(VampireRaiseThrall02)
		npc.RemoveSpell(crVampireUnarmedDamage03)
		npc.RemoveSpell(VampireSunDamage02)
		npc.RemoveSpell(AbVampire03)
		npc.RemoveSpell(AbVampire03b)
		npc.RemoveSpell(VampireDrain03)
		npc.RemoveSpell(VampireRaiseThrall03)
		npc.RemoveSpell(crVampireUnarmedDamage04)
		npc.RemoveSpell(VampireSunDamage03)
		npc.RemoveSpell(AbVampire04)
		npc.RemoveSpell(AbVampire04b)
		npc.RemoveSpell(VampireDrain04)		
		npc.RemoveSpell(VampireRaiseThrall04)
		npc.RemoveSpell(crVampireUnarmedDamage05)
		npc.RemoveSpell(VampireSunDamage04)
		npc.RemoveSpell(VampireHuntersSight)
		npc.RemoveSpell(VampireCloak)
		npc.RemoveSpell(VampireCharm)
		npc.RemoveSpell(VampireInvisibilityPC)
		npc.RemoveFromFaction(TweakHasVampGift)
		pAddVampireKeyword.Clear()
	EndIf
	
	self.GetActorRef().RemoveFromFaction(TweakVampireSpellsFaction)
	CombatInProgress = false
	firstSpell = None
	command = 0

endFunction

; One time operations
Function initialize()
	CombatInProgress = false
	firstSpell = None
EndFunction

; Every time they join the PC.
Function EventFollowingPlayer()
	; Nothing to do right now
endFunction

; Every time they continue following the PC after waiting
Function EventWaitToFollow()
	; Nothing to do right now.
EndFunction

Function EventNotFollowingPlayer()
	; Nothing to do right now
endFunction

Event OnUpdate()
	;Debug.trace("TweakVampire is Daywalker mod installed="+Game.GetModByName("Daywalker.esp"))

	if Game.GetModByName("Daywalker.esp") != 255
		if Hoodee == None
			Debug.trace("TweakVampire Daywalker FOUND!")
			OutfitCheckcomp = true
			Hoodee = Game.GetFormFromFile(0x0000FB0F, "Daywalker.esp") as Armor
			DayArmor = Game.GetFormFromFile(0x0000FB0D, "Daywalker.esp") as Armor
			DayGloves = Game.GetFormFromFile(0x00005904, "Daywalker.esp") as Armor
			DayBoots = Game.GetFormFromFile(0x00005901, "Daywalker.esp") as Armor
		endif
		if (OutfitCheckcomp)
			RegisterForSingleUpdate(5.0)
			Actor npc = self.GetActorRef()
			if (npc.GetItemCount(Hoodee) >=1 && npc.IsEquipped(DayArmor) && npc.IsEquipped(DayBoots) && npc.IsEquipped(DayGloves))
	          OutfitCheckcomp = false
	          CheckOutfit()
	        endif
		endif
	else
		Hoodee = None
		OutfitCheckcomp = false
	endif
	
	Actor npc = self.GetActorRef()
	if !npc || npc.IsDead()
		return
	endIf
	
	if (Update)
		Update = False
		LoadHelper()
	endif
	
	if (6 == command) ; Embrace NPC as Vampire
		command = 0
		TransformVampire()
	endif
endEvent

Armor Property Hoodee auto
Armor Property DayArmor auto
Armor Property DayBoots auto
Armor Property DayGloves auto
FormList Property SunDamageExceptionList auto
Bool OutfitCheckcomp = true

Function CheckOutfit()
    float timeNow = Utility.GetCurrentGameTime() ; GameDaysPassed
	timeNow = 24.0 * (timeNow - (timeNow as int)) ; convert to GameHour
	Actor npc = self.GetActorRef()

	bool shouldWearHood = false
	if (npc.IsInInterior())
		shouldWearHood = false
	else
		WorldSpace currentSpace = self.GetReference().GetWorldSpace()
		if (SunDamageExceptionList.Find(currentSpace)  < 1)
			shouldWearHood = true
		else
			shouldWearHood = false
		endif
	endif

	; put on hood if we're outside
	
	if (shouldWearHood)
		if (timeNow >= 19 || timeNow < 6)
		shouldWearHood = false
		endif
		
    endif
	
	if Hoodee != None
		if (!shouldWearHood)
			if (npc.IsEquipped(Hoodee))
				Debug.Trace("NPC: Inside, taking off hood.")
				npc.UnequipItem(Hoodee, true)
				;npc.RemoveItem(Hoodee)
			endif
		else
			if (shouldWearHood)
				if (!npc.IsEquipped(Hoodee) && timeNow > 5 && timeNow < 19)
					Debug.Trace("NPC: Outside, putting on hood.")
					;npc.AddItem(Hoodee)
					if (npc.GetItemCount(Hoodee) >= 1)
						npc.EquipItem(Hoodee, true)
					endif
				endif
		    endif
	    endif
	endif
	
	OutfitCheckcomp = true
EndFunction


Event OnLoad()
	Actor npc = self.GetActorRef()
	if !npc || npc.IsDead()
		return
	endIf
	
	Utility.wait(0.25)
	Update = true
	RegisterForSingleUpdate(1.5)
	

	; Handles vampiric level up

	if (!npc.IsInFaction(CurrentFollowerFaction))
		return
	endif

	if (!npc.HasSpell(ABVampireSkills))
		return
	endif

	VampireLevelUp()

endEvent

Function LoadHelper()

	Actor npc = self.GetActorRef()
	if !npc
		return
	endIf
	
	FixEyes()
	
EndFunction

Function TransformVampire()

	Actor npc = self.GetActorRef()
	Actor pc = Game.GetPlayer()

	Game.DisablePlayerControls()

	Topic BashTopic = (Game.GetForm(0x00039B94) As Topic)
	Topic Death = (Game.GetForm(0x00013EE4) As Topic)

	npc.AllowPCDialogue(false)

	;npc.SetAngle(npc.GetAngleX(), npc.GetAngleY(), npc.GetAngleZ() - 90)
	;Debug.SendAnimationEvent(npc, "IdleBedRollRightEnterStart")
	;Utility.wait(6.0)
	;float[] pos = (GetOwningQuest() as TweakFollowerScript).TraceCircle(Game.GetPlayer(), 80)
	;float[] moveToLater = (GetOwningQuest() as TweakFollowerScript).TraceCircle(Game.GetPlayer(), -70)


	;npc.SetPosition(pos[0], pos[1], pos[2])
	;npc.SetAngle(Game.GetPlayer().GetAngleX(), Game.GetPlayer().GetAngleY(), Game.GetPlayer().GetAngleZ() +  90)
	;Game.ForceThirdPerson()

	;Utility.wait(1.0)

	;Game.GetPlayer().PlayIdleWithTarget(VampireFeedingBedrollRight, npc)

	;Utility.wait(3.0)

	;npc.Say(BashTopic) ; 1 of 4 random sounds
	;Utility.wait(1.0)
	;npc.Say(BashTopic) ; 1 of 4 random sounds
	;Utility.wait(1.0)
	;npc.Say(Death); 1 of 4
	;Utility.wait(2.0)

	;Debug.SendAnimationEvent(npc, "IdleT02AscendFemale")
	;Game.GetPlayer().SetPosition(moveToLater[0],moveToLater[1], moveToLater[2]) 
	;Utility.wait(4.0)
	;DisguiseCastVFX01.play(npc, 5.0, Game.GetPlayer() )
	;DisguiseTargetVFX01.play(Game.GetPlayer(), 5.0 , npc)
	;utility.wait(5.0)

	;VampireChangeFX.play(npc)
	;MAGVampireTransform01.Play(npc)

	; from Quest DialogueGeneric -> Combat
	;Change npc's race, defaults to Nord Vampire
	;Utility.wait(4.0)
	;VampireChangeFX.stop(npc)

	;Debug.SendAnimationEvent( npc, "IdleWounded_01")
	;utility.wait(3.0)
	if (pc.GetRace() == pTweakDawnGuardScript.VampireLordRace)
			pc.PlayIdleWithTarget(pTweakDawnGuardScript.VampireLordFeed, npc)
		else
			pc.PlayIdleWithTarget(pTweakDawnGuardScript.NormalVampireFeed, npc)
	endif
	Utility.wait(4.0)
	DmgVis4.Play(npc, 3)
	Debug.SendAnimationEvent(npc, "BleedOutStart")
	npc.Say(BashTopic) ; 1 of 4 random sounds
	Utility.wait(2)
	Debug.SendAnimationEvent(npc, "BleedOutStop")
	Utility.Wait(1)
	npc.AllowPCDialogue(true)
	Game.EnablePlayerControls()

	;Game.ForceFirstPerson()
	;Debug.SendAnimationEvent( npc, "IdleForceDefaultState")
	RegisterForUpdateGameTime(0.25)
	VampireChangeTimer = Utility.GetCurrentGameTime()
	
endFunction

Event OnUpdateGameTime()

	Actor npc = self.GetActorRef()

	float timeNow = Utility.GetCurrentGameTime() ; GameDaysPassed
	timeNow = 24.0 * (timeNow - (timeNow as int)) ; convert to GameHour
	If Utility.GetCurrentGameTime() >= VampireChangeTimer + 3
	  if !npc.IsSwimming()
	   If timeNow >= 19 || timeNow < 6
		  UnRegisterForUpdateGameTime()
		  ChangeVampire()
	   endif
	  endIf
	EndIf
	
endEvent

Function ChangeVampire()

	Topic BashTopic = (Game.GetForm(0x00039B94) As Topic)
	Topic Death = (Game.GetForm(0x00013EE4) As Topic)
	Actor npc = self.GetActorRef()
	if !npc || npc.IsDead()
		return
	endIf
	
	npc.AllowPCDialogue(false)
	DmgVis4.Play(npc, 3)
	Debug.SendAnimationEvent(npc, "BleedOutStart")
	npc.Say(BashTopic) ; 1 of 4 random sounds
	Utility.wait(2)
	Debug.SendAnimationEvent(npc, "BleedOutStop")
	Utility.Wait(1)
	DmgVis4.Play(npc, 3)
	Debug.SendAnimationEvent(npc, "BleedOutStart")
	npc.Say(BashTopic) ; 1 of 4 random sounds
	Utility.wait(3)
	Debug.SendAnimationEvent(npc, "BleedOutStop")
	Utility.Wait(1)
	DmgVis4.Play(npc, 3)
	npc.Say(Death) ; 1 of 4 random sounds
	Utility.Wait(1)
	npc.PushActorAway(npc, 0.0)
	npc.forceAV("Paralysis", 1)
	Utility.Wait(30)
	npc.forceAV("Paralysis", 0)
	npc.AddToFaction(TweakHasVampGift)
    pAddVampireKeyword.forceRefTo(npc)
	pTweakDawnGuardScript.SetVampireEyes(npc)
	SetUseVampireSpells(true)
	VampireLevelUp(true)
	npc.AllowPCDialogue(true)
	
endFunction

Function SetUseVampireSpells(Bool value)
	if (value)
		self.GetActorRef().AddToFaction(TweakVampireSpellsFaction)
		VampireLevelUp(true)
	else
		self.GetActorRef().RemoveFromFaction(TweakVampireSpellsFaction)
		VampireLevelUp()
	endif
endFunction

Function VampireLevelUp(bool force=false)

	Actor npc = self.GetActorRef()

	if (!npc.IsInFaction(TweakVampireSpellsFaction))
		npc.RemoveSpell(VampireDrain01)
		npc.RemoveSpell(VampireDrain02)
		npc.RemoveSpell(VampireDrain03)
		npc.RemoveSpell(VampireDrain04)
		npc.RemoveSpell(VampireCharm)
		npc.RemoveSpell(VampireInvisibilityPC)	
		npc.RemoveSpell(VampireHuntersSight)
		npc.RemoveSpell(VampireCloak)
		npc.RemoveSpell(VampireRaiseThrall01)
		npc.RemoveSpell(VampireRaiseThrall02)
		npc.RemoveSpell(VampireRaiseThrall03)
		npc.RemoveSpell(VampireRaiseThrall04)
		return
	endif

	int npcLevel = npc.GetLevel() as int
	int pcLevel = Game.GetPlayer().GetLevel() as int
	if (npcLevel < pcLevel)
		npcLevel = pcLevel
	endif

	if ((npcLevel != previousLevel) || force)

		if (!force)
			previousLevel = npcLevel
		endif
		
		npc.AddSpell(ABVampireSkills, abVerbose = False)
		npc.AddSpell(ABVampireSkills02, abVerbose = False)

		if (npcLevel <= 15)

			npc.AddSpell(AbVampire01, abVerbose = False)
			npc.AddSpell(AbVampire01b, abVerbose = False)
			npc.AddSpell(VampireDrain01, abVerbose = False)
			npc.AddSpell(VampireRaiseThrall01, abVerbose = False)
			npc.AddSpell(crVampireUnarmedDamage02, abVerbose = False)
			npc.AddSpell(VampireSunDamage01, abVerbose = False)

			firstSpell = None

		elseif (npcLevel <= 30)

			npc.RemoveSpell(AbVampire01)
			npc.RemoveSpell(AbVampire01b)
			npc.RemoveSpell(VampireDrain01)
			npc.RemoveSpell(VampireRaiseThrall01)
			npc.RemoveSpell(crVampireUnarmedDamage02)
			npc.RemoveSpell(VampireSunDamage01)

			npc.AddSpell(AbVampire02, abVerbose = False)
			npc.AddSpell(AbVampire02b, abVerbose = False)
			npc.AddSpell(VampireDrain02, abVerbose = False)
			npc.AddSpell(VampireRaiseThrall02, abVerbose = False)
			npc.AddSpell(crVampireUnarmedDamage03, abVerbose = False)
			npc.AddSpell(VampireSunDamage02, abVerbose = False)		
			npc.AddSpell(VampireCharm)

			firstSpell = VampireCharm

		elseif (npcLevel <= 45)

			npc.RemoveSpell(AbVampire01)
			npc.RemoveSpell(AbVampire01b)
			npc.RemoveSpell(VampireDrain01)
			npc.RemoveSpell(VampireRaiseThrall01)
			npc.RemoveSpell(crVampireUnarmedDamage02)
			npc.RemoveSpell(VampireSunDamage01)

			npc.RemoveSpell(AbVampire02)
			npc.RemoveSpell(AbVampire02b)
			npc.RemoveSpell(VampireDrain02)
			npc.RemoveSpell(VampireRaiseThrall02)
			npc.RemoveSpell(crVampireUnarmedDamage03)
			npc.RemoveSpell(VampireSunDamage02)


			npc.AddSpell(AbVampire03, abVerbose = False)
			npc.AddSpell(AbVampire03b, abVerbose = False)
			npc.AddSpell(VampireDrain03, abVerbose = False)
			npc.AddSpell(VampireRaiseThrall03, abVerbose = False)
			npc.AddSpell(crVampireUnarmedDamage04, abVerbose = False)
			npc.AddSpell(VampireSunDamage03, abVerbose = False)
		
			npc.AddSpell(VampireHuntersSight)
			npc.AddSpell(VampireCloak)
			npc.AddSpell(VampireCharm)

			firstSpell = VampireCharm

		else

			npc.RemoveSpell(AbVampire01)
			npc.RemoveSpell(AbVampire01b)
			npc.RemoveSpell(VampireDrain01)
			npc.RemoveSpell(VampireRaiseThrall01)
			npc.RemoveSpell(crVampireUnarmedDamage02)
			npc.RemoveSpell(VampireSunDamage01)

			npc.RemoveSpell(AbVampire02)
			npc.RemoveSpell(AbVampire02b)
			npc.RemoveSpell(VampireDrain02)
			npc.RemoveSpell(VampireRaiseThrall02)
			npc.RemoveSpell(crVampireUnarmedDamage03)
			npc.RemoveSpell(VampireSunDamage02)

			npc.RemoveSpell(AbVampire03)
			npc.RemoveSpell(AbVampire03b)
			npc.RemoveSpell(VampireDrain03)
			npc.RemoveSpell(VampireRaiseThrall03)
			npc.RemoveSpell(crVampireUnarmedDamage04)
			npc.RemoveSpell(VampireSunDamage03)

			npc.AddSpell(AbVampire04, abVerbose = False)
			npc.AddSpell(AbVampire04b, abVerbose = False)
			npc.AddSpell(VampireDrain04, abVerbose = False)		
			npc.AddSpell(VampireRaiseThrall04, abVerbose = False)
			npc.AddSpell(crVampireUnarmedDamage05, abVerbose = False)
			npc.AddSpell(VampireSunDamage04, abVerbose = False)
		
			npc.AddSpell(VampireHuntersSight)
			npc.AddSpell(VampireCloak)
			npc.AddSpell(VampireCharm)
			npc.AddSpell(VampireInvisibilityPC)	

			firstSpell = VampireCharm

		endif
	endif

endFunction

Function OnCombatBegin(Actor akTarget=None)

	CombatInProgress = true

	if (!akTarget)
		Return
	EndIf

	Actor npc = self.GetActorRef()

	; If possessing the follower, we dont care
	if (npc.GetPlayerControls())
		return
	endif

	; Can't do anything if we are not a vampire
	if (!self.GetActorRef().HasSpell(ABVampireSkills))
		return
	endif

	; If our abilities are disabled, we dont care:
	if (!self.GetActorRef().IsInFaction(TweakVampireSpellsFaction))
		return
	endif

	; If too far away and waiting, nothing we can do:
	if (0 != (npc.GetAv("WaitingforPlayer") as Int))
		if (Game.GetPlayer().GetDistance(self.GetRef()) > 2000)
			return
		endif
	endif

	if (firstSpell)
		FollowerCast(firstSpell, akTarget)
	endif

EndFunction

; Called by TweakFollowerScript: RelayCombatEnd
Function OnCombatEnd()
	CombatInProgress = false
EndFunction

Event OnCombatStateChanged(Actor akTarget, int cState)

	Actor npc = self.GetActorRef()
	if !npc || npc.IsDead()
		return
	endIf
	if (1 != cState)
		Return
	endIf
	if (akTarget && akTarget.IsPlayerTeammate())
		return
	endif

	if (!npc.IsInFaction(CurrentFollowerFaction))
		return
	endif

	if (!CombatInProgress)
		OnCombatBegin(akTarget)
	endif
		
endEvent

Function FollowerCast(Spell theSpell, Actor combatTarget)
	if (self.GetActorRef().HasSpell(theSpell))
		self.GetActorRef().PlayIdle(IdleMagic_01)
		Utility.wait(1.0)
		theSpell.cast(self.GetActorRef(), combatTarget)
	endif
endFunction

Function FixEyes()
	Actor npc = self.GetActorRef()
	if !npc || npc.IsDead()
		return
	endIf
	
	if (npc.IsInFaction(TweakHasVampGift))
	    pTweakDawnGuardScript.SetVampireEyes(npc)
	endif
	
EndFunction
