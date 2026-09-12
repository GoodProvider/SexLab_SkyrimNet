Scriptname DOM_PlayerAlias extends ReferenceAlias  
Import DOM_Util

Actor Property PlayerRef Auto
DOM_Core Property DOMCore Auto
DOM_SlaverManager Property DOMSlaverManager Auto
DOM_SlaveManager Property DOMSlaveManager Auto
DOM_SEXLAB Property DOMSexlab Auto
DOM_Diary Property DOM04 Auto
ReferenceAlias Property PlayerCombatTarget Auto

DOM_DiaryBook Property DiaryLedgerPlayer Auto
DOM_DiaryBook Property DiaryJournalPlayer Auto
ReferenceAlias Property players_target Auto

bool Property playerSkillsMessageToggle = true Auto Hidden
bool Property playerLedgerToggle = true Auto Hidden
bool Property playerJournalToggle = true Auto Hidden
Float Property skills_difficulty = 1.0 Auto Hidden
int Property player_location_type = -1 Auto Hidden
Location Property player_current_location = None Auto Hidden

; Names
string Property playerBadName = "" Auto Hidden
string Property playerNeutralName = "" Auto Hidden

Event OnPlayerLoadGame()
	;LogTrace("OnPlayerLoadGame "+DOMCore)
	;Utility.Wait(2.0)
	if DOMCore == None
		string dom_modname = "DiaryOfMine.esm"
		if (Game.GetModByName(dom_modname) != 255)
			DOMCore     = Game.GetFormFromFile(0x00000D61, dom_modname) As DOM_Core 
		else
			return
		endif
	endif
	
	PreInitializePlayer()

	; DOM init
	DOMCore.OnPlayerLoadGame()
EndEvent

bool player_is_initialized    = false
bool player_is_preinitialized = false
Function Initialize()
	LogInfo("================================================================================")
	LogInfo("==                             DOM: Player Alias                              ==")
	LogInfo("================================================================================")
	InitializePlayer()
EndFunction

DOM_Actor Property actor_alias Auto Hidden
DOM_Mind Property actor_mind Auto Hidden

Function ResetInitializePlayer()
	player_is_preinitialized = false
	player_is_initialized    = false
EndFunction

Function PreInitializePlayer()
	; Player pre initialization
	if player_is_preinitialized
		LogTrace("PreInitializePlayer: Player is already preinitialized")
		return
	endif
	LogInfo("PreInitializePlayer RaceMenu open="+UI.IsMenuOpen(DOMCore.RACESEX_MENU))
	if UI.IsMenuOpen(DOMCore.RACESEX_MENU)
		LogInfo("PreInitializePlayer 1 RaceMenu is open - Waiting...")
		while UI.IsMenuOpen(DOMCore.RACESEX_MENU)
			Utility.wait(1.0)
		endWhile
		LogInfo("PreInitializePlayer 1 RaceMenu has finished - Continuing")
	endif
	ReferenceAlias actor_ref = self
	actor_alias = actor_ref as DOM_Actor
	if actor_alias == None
		LogTrace("PreInitializePlayer: Assign failed to assign DOM actor")
		return
	endif
	if actor_alias.DOM01 != DOMCore && DOMCore != None
		LogTrace("PreInitializePlayer: Assign alias actor DOM pointer was not correctly set!")
		actor_alias.DOM01 = DOMCore
	endif
	actor_mind = actor_ref as DOM_Mind
	if actor_mind == None
		LogTrace("PreInitializePlayer: Assign failed to assign DOM mind")
		return
	endif
	if actor_mind.DOM01 != DOMCore && DOMCore != None
		LogTrace("PreInitializePlayer: Assign alias mind DOM pointer was not correctly set!")
		actor_mind.DOM01 = DOMCore
	endif
	actor_mind.is_player_actor = true
	actor_mind.akRef           = GetActorRef()
	actor_alias.mind           = actor_mind
	actor_alias.akRef          = GetActorRef()
	actor_alias.target         = players_target
	player_is_preinitialized   = true
EndFunction

Function InitializePlayer()
	if actor_alias == None || actor_mind == None
		player_is_initialized = false
	endif
	if player_is_initialized
		LogTrace("InitializePlayer: Player is already initialized")
		return
	endif
	player_is_initialized = true
	LogInfo("InitializePlayer RaceMenu open="+UI.IsMenuOpen(DOMCore.RACESEX_MENU))
	if UI.IsMenuOpen(DOMCore.RACESEX_MENU)
		LogInfo("InitializePlayer 1 RaceMenu is open - Waiting...")
		while UI.IsMenuOpen(DOMCore.RACESEX_MENU)
			Utility.wait(1.0)
		endWhile
		LogInfo("InitializePlayer 1 RaceMenu has finished - Continuing")
	endif
	PreInitializePlayer()
	actor_alias.AfterAssign(false,false,false) ; slave=no, new=no, player's=no
	actor_mind.AfterAssign(false,false,false) ; slave=no, new=no, player's=no
	SetPlayerStrings()
	RetrieveSkills()
	RetrieveDiaries()
	actor_alias.OnUpdate()
	actor_alias.OnUpdateGameTime()
	LogTrace("InitializePlayer: Assign alias ref DOM - Player setup successful actor_ref="+self)
	LogTrace("InitializePlayer: Assign alias actor DOM - Player setup successful actor_alias="+actor_alias)
	LogTrace("InitializePlayer: Assign alias mind DOM - Player setup successful actor_mind="+actor_mind)
	if UI.IsMenuOpen(DOMCore.RACESEX_MENU)
		LogInfo("InitializePlayer 2 RaceMenu is open - Waiting...")
		while UI.IsMenuOpen(DOMCore.RACESEX_MENU)
			Utility.wait(1.0)
		endWhile
		LogInfo("InitializePlayer 2 RaceMenu has finished - Continuing")
	endif	
 	Debug.MessageBox("DOM Player "+actor_alias.GetName()+" creation successful. If this is your first time loading DOM with this game, wait for the DOM initialization message box to appear.")
EndFunction

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	;LogTrace("OnLocationChange "+akNewLoc)
	;LogTrace("OnLocationChange Before player_location_type="+player_location_type+" ("+GetLocationTypeName(player_location_type)+")")
	SetPlayerLocationType()
	;LogTrace("OnLocationChange After player_location_type="+player_location_type+" ("+GetLocationTypeName(player_location_type)+")")
	DOMCore.DoLocationChange(akOldLoc, akNewLoc)
endEvent

; Player names and pronouns

string Function GetPlayerTitleIfRespectful(bool is_respectful)
	if is_respectful
		return actor_alias.getTitle()
	endif
	return "this "+playerBadName
EndFunction

Function SetPlayerGenderByString(string str_gender)
	actor_alias.SetGenderByString(str_gender)
	SetPlayerStrings()
EndFunction

Function SetPlayerTitleByString(string the_title)
	actor_alias.setTitle(the_title)
EndFunction

int Function GetPlayerLocationType()
	if player_location_type == -1
		SetPlayerLocationType()
	endif
	return player_location_type
EndFunction

string Function GetPlayerTitle()
	return actor_alias.getTitle()
EndFunction

string Function GetPlayerPossessive()
	return actor_alias.actorPossessive
EndFunction

string Function GetPlayerObjective()
	return actor_alias.actorObjective
EndFunction

string Function GetPlayerPronoun()
	return actor_alias.actorPronoun
EndFunction

string Function GetPlayerBeVerb()
	return actor_alias.actorBeVerb
EndFunction

string Function GetPlayerHaveVerb()
	return actor_alias.actorHaveVerb
EndFunction

int Function GetPlayerSex()
	if actor_alias == None
		return PlayerRef.GetActorBase().GetSex()
	endif
	return actor_alias.actorSex
EndFunction

Function SetPlayerStrings()
	int playerSex = GetPlayerSex()
	if playerSex == 0 || playerSex == 2
		playerBadName = "bastard"
		playerNeutralName = "guy"
	elseif playerSex == 1 || playerSex == 3
		playerBadName = "bitch"
		playerNeutralName = "girl"
	else
		playerBadName = "bitchard"
		playerNeutralName = "person"
	endif
EndFunction

Function SetPlayerLocationType()
	if PlayerRef == None
		LogInfo("ERROR! SetPlayerLocationType PlayerRef=None")
		player_location_type = 0
		return
	endif
	Location loc = PlayerRef.GetCurrentLocation()
	if loc == None
		LogInfo("ERROR! SetPlayerLocationType player_location=None")
		player_location_type = 0
		return
	endif
	LogTrace("SetPlayerLocationType player_location="+loc.GetName()+" "+loc)
	if DOMCore.isInDungeon(loc)
		player_location_type = 1
	elseif DOMCore.isInCity(loc)
		player_location_type = 2
	else
		player_location_type = 3 ; Wilderness
	endif
	player_current_location = loc
EndFunction

; Player's Skills
; The six player skills are:
; enforcer:    Training slaves physically (pain)                        / submission
; predator:    Capturing slaves unnoticed and bonus training at capture / fear
; depraver:    Training slaves sexually                                 / humiliation
; persuader:   Brain washing slaves (shock/broken/loyal/inlove)         / anger
; slaver:      Selling slaves at a good price                           / resignation
; deceiver:    Training slaves psychologically                          / respect

bool playerLedgerRetrieved = false
bool playerJournalRetrieved = false
Function RetrieveDiaries()
	if playerLedgerRetrieved && playerJournalRetrieved
		LogTrace("Player's diaries already retrieved")
		return
	endif
	if !playerLedgerRetrieved
		playerLedgerRetrieved  = true
		if DiaryLedgerPlayer != None && actor_alias != None
			DiaryLedgerPlayer.SetAsMyDiary(actor_alias,actor_alias.akRef)
			if !playerLedgerToggle
				DiaryLedgerPlayer.Moveto(DOM04.DOMJeremyMarker) ; Put book somewhere that is nowhere
			endif
			LogTrace("Player's ledger retrieved")
		endif
	endif
	if !playerJournalRetrieved
		playerJournalRetrieved = true
		if DiaryJournalPlayer != None && actor_alias != None
			DiaryJournalPlayer.SetAsMyDiary(actor_alias,actor_alias.akRef)
			if !playerJournalToggle
				DiaryJournalPlayer.Moveto(DOM04.DOMJeremyMarker) ; Put book somewhere that is nowhere
			endif
			LogTrace("Player's journal retrieved")
		endif
	endif
EndFunction

Function MoveJournal()
	if DiaryJournalPlayer != None
		return
	endif
	if !playerJournalToggle
		DiaryJournalPlayer.Moveto(DOM04.DOMJeremyMarker) ; Put book somewhere that is nowhere
		return
	endif
	PlayerRef.AddItem(DiaryJournalPlayer)
EndFunction

Function MoveLedger()
	if DiaryLedgerPlayer != None
		return
	endif
	if !playerLedgerToggle
		DiaryLedgerPlayer.Moveto(DOM04.DOMJeremyMarker) ; Put book somewhere that is nowhere
		return
	endif
	PlayerRef.AddItem(DiaryLedgerPlayer)
EndFunction

bool skills_retrieved = false
Function RetrieveSkills()
	if skills_retrieved
		LogTrace("Player's skills already retrieved")
		return
	endif
	skills_retrieved  = true
	actor_mind.skill_enforcer  = DOMCore.RetrieveSkillEnforcer()
	actor_mind.skill_persuader = DOMCore.RetrieveSkillPersuader()
	actor_mind.skill_depraver  = DOMCore.RetrieveSkillDepraver()
	actor_mind.skill_predator  = DOMCore.RetrieveSkillPredator()
	actor_mind.skill_slaver    = DOMCore.RetrieveSkillSlaver()
	actor_mind.skill_deceiver  = DOMCore.RetrieveSkillDeceiver()
	LogTrace("Retrieved skill_enforcer ="+actor_mind.skill_enforcer)
	LogTrace("Retrieved skill_persuader="+actor_mind.skill_persuader)
	LogTrace("Retrieved skill_depraver ="+actor_mind.skill_depraver)
	LogTrace("Retrieved skill_predator ="+actor_mind.skill_predator)
	LogTrace("Retrieved skill_slaver   ="+actor_mind.skill_slaver)
	LogTrace("Retrieved skill_deceiver ="+actor_mind.skill_deceiver)
	
	if DOMCore.playerTitle != ""
		SetPlayerTitleByString(DOMCore.playerTitle)
	endif
EndFunction

Float Function GetEnforcerModifier()
	return actor_mind.GetEnforcerModifier()
EndFunction
Float Function GetPersuaderModifier()
	return actor_mind.GetPersuaderModifier()
EndFunction
Float Function GetDepraverModifier()
	return actor_mind.GetDepraverModifier()
EndFunction
Float Function GetPredatorModifier()
	return actor_mind.GetPredatorModifier()
EndFunction
Float Function GetSlaverModifier()
	return actor_mind.GetSlaverModifier()
EndFunction
Float Function GetDeceiverModifier()
	return actor_mind.GetDeceiverModifier()
EndFunction

Float Function GetSkillEnforcer()
	return actor_mind.skill_enforcer
EndFunction
Float Function GetSkillPersuader()
	return actor_mind.skill_persuader
EndFunction
Float Function GetSkillDepraver()
	return actor_mind.skill_depraver
EndFunction
Float Function GetSkillPredator()
	return actor_mind.skill_predator
EndFunction
Float Function GetSkillSlaver()
	return actor_mind.skill_slaver
EndFunction
Float Function GetSkillDeceiver()
	return actor_mind.skill_deceiver
EndFunction

Function TrainSkillEnforcer(Float base_amount)
	float prev_value = actor_mind.skill_enforcer
	actor_mind.TrainSkillEnforcer(base_amount*skills_difficulty)
	DisplaySkillMessage("Enforcer",prev_value,actor_mind.skill_enforcer)
EndFunction
Function TrainSkillPersuader(Float base_amount)
	float prev_value = actor_mind.skill_persuader
	actor_mind.TrainSkillPersuader(base_amount*skills_difficulty)
	DisplaySkillMessage("Persuader",prev_value,actor_mind.skill_persuader)
EndFunction
Function TrainSkillDepraver(Float base_amount)
	float prev_value = actor_mind.skill_depraver
	actor_mind.TrainSkillDepraver(base_amount*skills_difficulty)
	DisplaySkillMessage("Depraver",prev_value,actor_mind.skill_depraver)
EndFunction
Function TrainSkillPredator(Float base_amount)
	float prev_value = actor_mind.skill_predator
	actor_mind.TrainSkillPredator(base_amount*skills_difficulty)
	DisplaySkillMessage("Preadtor",prev_value,actor_mind.skill_predator)
EndFunction
Function TrainSkillSlaver(Float base_amount)
	float prev_value = actor_mind.skill_slaver
	actor_mind.TrainSkillSlaver(base_amount*skills_difficulty)
	DisplaySkillMessage("Slaver",prev_value,actor_mind.skill_slaver)
EndFunction
Function TrainSkillDeceiver(Float base_amount)
	float prev_value = actor_mind.skill_deceiver
	actor_mind.TrainSkillDeceiver(base_amount*skills_difficulty)
	DisplaySkillMessage("Deceiver",prev_value,actor_mind.skill_deceiver)
EndFunction

Function HasBroken(DOM_Actor akActor) 
	if akActor == None
		return
	endif
	LogTrace("Player has broken "+akActor.GetName())
	TrainSkillEnforcer(0.5)
	actor_mind.number_of_brokenslaves += 1
	TrainSlavers(akActor,"broken",0.1) ; Enforcer
	TrainSlaves(akActor,"broken",0.1)  ; Submission
EndFunction

Function HasRecruited(DOM_Actor akActor)
	if akActor == None
		return
	endif
	LogTrace("Player has recruited "+akActor.GetName())
	TrainSkillPersuader(0.5)
	actor_mind.number_of_recruitedslavers += 1
	TrainSlavers(akActor,"recruited",0.1) ; Persuader
	TrainSlaves(akActor,"recruited",0.1)  ; Fear
EndFunction

Function HasWhored(DOM_Actor akActor)
	if akActor == None
		return
	endif
	LogTrace("Player has whored "+akActor.GetName())
	TrainSkillDepraver(0.5)
	actor_mind.number_of_recruitedslavers += 1
	TrainSlavers(akActor,"whored",0.1) ; Depraver
	TrainSlaves(akActor,"whored",0.1)  ; Humiliation
EndFunction

Function HasCaptured(DOM_Actor akActor)
	if akActor == None
		return
	endif
	LogTrace("Player has captured "+akActor.GetName())
	TrainSkillPredator(0.5)
	actor_mind.number_of_capturedslaves += 1
	TrainSlavers(akActor,"captured",0.1) ; Predator
	TrainSlaves(akActor,"captured",0.1)  ; Anger
EndFunction

Function HasSold(DOM_Actor akActor)
	if akActor == None
		return
	endif
	LogTrace("Player has sold "+akActor.GetName())
	TrainSkillSlaver(0.5)
	actor_mind.number_of_soldslaves += 1
	TrainSlavers(akActor,"sold",0.1) ; Slaver
	TrainSlaves(akActor,"sold",0.1)  ; Resignation
EndFunction

Function HasRansomed(DOM_Actor akActor)
	if akActor == None
		return
	endif
	LogTrace("Player has ransomed "+akActor.GetName())
	TrainSkillDeceiver(0.5)
	actor_mind.number_of_ransomedslaves += 1
	TrainSlavers(akActor,"ransomed",0.1) ; Deceiver
	TrainSlaves(akActor,"ransomed",0.1)  ; Respect
EndFunction

Function HasFlingWith(DOM_Actor akActor)
	string the_event = "IncrementFling"
	Actor akRef = akActor.akRef
	bool doSendEvent = false
	int i = 0
	while i < DOMSlaveManager.actorCounter
		DOM_Actor akOther = DOMSlaveManager.actorArray[i]
		if akOther != None && akOther != akActor
			if akOther.mind.IsInLove() && IsTogetherWithFast(akOther.akRef, akRef, 3000.0) ; 3000 = 42 meters
				if DOMCore.sendDOMEvents
					akOther.RegisterForDOMEvent(akRef,the_event)
					doSendEvent = true
				else
					akOther.IncrementFling(akActor)
				endif
			endif
		endif
		i += 1
	EndWhile
	if doSendEvent
		DOMCore.sendDOMEvent(akRef,the_event)
	endif
EndFunction

Function HasChatWith(DOM_Actor akActor)
	string the_event = "IncrementChat"
	Actor akRef = akActor.akRef
	bool doSendEvent = false
	int i = 0
	while i < DOMSlaveManager.actorCounter
		DOM_Actor akOther = DOMSlaveManager.actorArray[i]
		if akOther != None && akOther != akActor
			if akOther.mind.IsInLove() && IsTogetherWithFast(akOther.akRef, akRef, 1500.0) ; 1500 = 21 meters
				if DOMCore.sendDOMEvents
					akOther.RegisterForDOMEvent(akRef,the_event)
					doSendEvent = true
				else
					akOther.IncrementChat(akActor)
				endif
			endif
		endif
		i += 1
	EndWhile
	if doSendEvent
		DOMCore.sendDOMEvent(akRef,the_event)
	endif
EndFunction

Function DisplaySkillMessage(string the_skill, float skill_before, float skill_after)
	if !playerSkillsMessageToggle || skill_before >= skill_after || skill_after < 1.0
		return
	endif
	if skill_before < 100.0 && skill_after >= 100.0
		HudNotification("You're now a master "+the_skill+"!")
	elseif  skill_before < 90.0 && skill_after >= 90.0
		HudNotification("You've reached 60% in "+the_skill+" skill. You are the absolute "+GetPlayerTitle()+"!")
	elseif  skill_before < 80.0 && skill_after >= 80.0
		HudNotification("You've reached 80% in "+the_skill+" skill. You’re doing a fantastic job.")
	elseif  skill_before < 70.0 && skill_after >= 70.0
		HudNotification("You've reached 70% in "+the_skill+" skill. You’re nailing it.")
	elseif  skill_before < 60.0 && skill_after >= 60.0
		HudNotification("You've reached 60% in "+the_skill+" skill. You've earn your title, "+GetPlayerTitle()+"!")
	elseif  skill_before < 50.0 && skill_after >= 50.0
		HudNotification("You've reached 50% in "+the_skill+" skill. Your hard work is paying off.")
	elseif  skill_before < 40.0 && skill_after >= 40.0
		HudNotification("You've reached 40% in "+the_skill+" skill. Keep doing what you’re doing.")
	elseif  skill_before < 30.0 && skill_after >= 30.0
		HudNotification("You've reached 30% in "+the_skill+" skill. "+"Show them who is the "+GetPlayerTitle()+"!")
	elseif  skill_before < 20.0 && skill_after >= 20.0
		HudNotification("You've reached 20% in "+the_skill+" skill. Keep at it, you’re almost there.")
	elseif  skill_before < 10.0 && skill_after >= 10.0
		HudNotification("You've reached 10% in "+the_skill+" skill. You’re on the right track.")
	elseif  skill_before < 5.0 && skill_after >= 5.0
		HudNotification("You've reached 5% in "+the_skill+" skill. You start to get it now.")
	elseif  skill_before < 1.0 && skill_after >= 1.0
		HudNotification("You've reached 1% in "+the_skill+" skill. It's a start.")
	endif
EndFunction

Function TrainSlavers(DOM_Actor akActor, string type, float amount)
	LogTrace("TrainSlavers: "+akActor.getName()+" number of actors="+DOMSlaverManager.actorCounter+" type="+type+" amount="+amount)
	Actor akRef = akActor.akRef
	string the_event = "TrainForSlaver"
	bool doSendEvent = false
	int i = 0
	while i < DOMSlaverManager.actorCounter
		DOM_Actor akOther = DOMSlaverManager.actorArray[i]
		if akOther != None && akOther != akActor
			if akOther.IsAttentive() || type == "public_humiliation" || type == "to be sacrificed"
				if IsTogetherWithFast(akRef, akOther.akRef, 2000.0) ; 2000 = 30 meters	
					if DOMCore.sendDOMEvents
						akOther.RegisterForDOMEvent(akRef,the_event)
						doSendEvent = true
					else
						akOther.TrainForSlaver(akActor,amount,0,type)
					endif
				endif
			endif
		endif
		i += 1
	EndWhile
	if doSendEvent
		DOMCore.sendDOMEvent(akRef,the_event,amount,0,type)
	endif
EndFunction

Function TrainSlaves(DOM_Actor akActor, string type, float amount)
	LogTrace("TrainSlaves: "+akActor.getName()+" number of actors="+DOMSlaveManager.actorCounter+" type="+type+" amount="+amount)
	Actor akRef = akActor.akRef
	string the_event = "TrainForSlaver"
	bool doSendEvent = false
	int i = 0
	while i < DOMSlaveManager.actorCounter
		DOM_Actor akOther = DOMSlaveManager.actorArray[i]
		if akOther != None && akOther != akActor
			if akOther.IsAttentive() || type == "public_humiliation" || type == "to be sacrificed"
				if IsTogetherWithFast(akRef, akOther.akRef, 2000.0) ; 2000 = 30 meters	
					if DOMCore.sendDOMEvents
						akOther.RegisterForDOMEvent(akRef,the_event)
						doSendEvent = true
					else
						akOther.TrainForSlaver(akActor,amount,0,type)
					endif
				endif
			endif
		endif
		i += 1
	EndWhile
	if doSendEvent
		DOMCore.sendDOMEvent(akRef,the_event,amount,0,type)
	endif
EndFunction

Event OnVampireFeed(Actor akTarget)
	;LogTrace("OnVampireFeed Actor="+akTarget)	
	if akTarget == NONE
		return
	endif
	DOM_Actor akActor = DOMCore.GetActor(akTarget)
	;LogTrace("OnVampireFeed DOM_Actor="+akActor)	
	Actor akPlayer = GetActorRef()
	;LogTrace("OnVampireFeed Player="+akPlayer)	
	TrainSkillPredator(2.0)
	string victim_name 
	int hexaco_trait
	if akActor == NONE
		victim_name = akTarget.GetDisplayName()
		hexaco_trait = DOMCore.DOMNPCTrainingRandom(akTarget,5.0)
	else
		victim_name = akActor.GetName()
		hexaco_trait = akActor.mind.TrainForVampireFed(akPlayer)
	endif
	if hexaco_trait == 0
		HudNotification("You feed on a docile "+victim_name)
	elseif hexaco_trait == 1
		HudNotification("You feed on a shaking "+victim_name)
	elseif hexaco_trait == 2
		HudNotification("You feed on an innocent "+victim_name)
	elseif hexaco_trait == 3
		HudNotification("You feed on a tamed "+victim_name)
	elseif hexaco_trait == 3
		HudNotification("You feed on a flaccid "+victim_name)
	else
		HudNotification("You feed on a compliant "+victim_name)
	endif
EndEvent

Function HudNotification(string msg)
	Debug.Notification(msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_PlayerAlias: "+msg)
	endif
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_PlayerAlias: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_PlayerAlias: "+msg)
	endif
EndFunction
