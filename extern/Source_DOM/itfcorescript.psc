Scriptname itfCoreScript extends Quest Conditional

itfCoreScript Function GetAPI() global
	return Game.GetFormFromFile(0x00003519, "ItortureFramework.esm") as itfCoreScript
EndFunction

Event OnInit()
	debug.notification("Interactive torture framework started")
EndEvent

; Call this Function to check if a piece of furniture can be used. Furniture must not yet be occupied (and will return false if it is)
; This checks for ignore (dummy) keyword. You can still force RequestTortureSession to use furniture with that keyword.
bool Function CheckFurnitureIsEligible(ObjectReference furni)
	if ((furni.HasKeyword(KeywordDummy)) || (furni.GetLinkedRef(KeywordDummy) != None))
		Debug("Has Dummy kwd")
		return false
	endif

	return (!furni.IsFurnitureInUse())
EndFunction


; Call this Function when the victim enters / sits in the torture device. 
; returns true if the torture session can be started, false otherwise. Will return false if the furniture itself has the script, in this case the furniture will start the session
; If the furniture is eligible but not set up for torture, this call will handle setting up the furniture and return true.
; If the Function returns true, you may follow up with a call to RequestTortureSession()

bool Function CheckFurniture(ObjectReference furni, Actor victim)
	; Check if furniture has active effect. If so: ignore, the furniture will handle this event
	if (furni.HasEffectKeyword(KeywordEffect))
		Debug("Has effect")
		return false
	endif

	if ((furni.HasKeyword(KeywordDummy)) || (furni.GetLinkedRef(KeywordDummy) != None))
		Debug("Has Dummy kwd")
		return false
	endif

	; Check if furniture has the right script. If so: ignore, the furniture will handle this event
	itfDeviceScript furniScript =  (furni as itfDeviceScript)
	if (furniScript != None)
		Debug("Has script, let furniture handle this")
		return false
	else
		; Check if furniture is of the right type.
		if ((!furni.GetBaseObject().HasKeyword(KeywordSpecialFurniture)) && (!EligibleFurnitureList.HasForm(furni.GetBaseObject())))
			Debug("Not the right furniture and no script attached")
			return false
		elseif ( ((KeywordZBF != None) && (furni.GetBaseObject().HasKeyword(KeywordZBF))) || \
			((KeywordUFP != None) && (furni.GetBaseObject().HasKeyword(KeywordUFP))) )

			if (AllowAnyFurniture) 
				if (DeviceDetector.IsSlotted(furni))
					Debug("Eligible furniture and slotted, ignore")
					return false
				else
					Debug("Eligible, unslotted.  Proceed")
					return true
				endif
			else
				Debug("Auto detect furniture use is disabled or is not a torture device")
				return false
			endif
		else
			Debug("Not a torture device")
			return false
		endif
	endif

	return true
EndFunction


; Request a torture session. returns the reserved slot (a referencealias) if successful, otherwise None is no session is available or if another error occurred
; You must also pass in a Torturer, or set that parameter to None to let the framework select one for you.  You are responsible for checking if the Torturer is available to participate.
; The framework will check itfTorturerFaction, this faction indicates the Torturer is already engaged in a session 
; Pass in the activator to use.  If None, the Function will find a linked or nearby activator, or create a generic one if allowed
; If no activator is specified, you may pass an activatorkeyword.   The Function will use that keyword to find an activator linked to your furniture, or find a nearby activator with that keyword
; Once a session is returned, you can call StartTortureSession on the session to begin
; Set to automatic if you do not want to intervene in the session (you will still get the events)

ReferenceAlias Function RequestTortureSession(ObjectReference furni, Actor victim, Actor torturer=None, ObjectReference acti=None, Keyword activatorKwd=None, bool automatic=true)
	; Obtain settings to be used
	itfDeviceParameterScript params = (furni as itfDeviceParameterScript)
	if (params == None)
		params = GlobalParameters
		Debug("Using global params")
	endif
	bool playerWantsToTorture = false

	; Verify victim
	if (Game.GetPlayer() == victim)
		if (params.DoNotTorturePlayer)
			Debug("Ignore player")
			return None
		endif
	elseif (GetVictimSlot(victim) != None)
		return None
	else
		if ((params.DoNotTortureNPC) || (!VictimIsEligible(victim)))
			Debug("Ignore NPC")
			return None
		else
			victim.SetFactionRank(VictimFaction, 1)
		endif
	endif

	if (torturer == None)
		if ((victim.IsDoingFavor()) && (furni.GetDistance(Game.GetPlayer()) < 150) && (!Game.GetPlayer().IsInFaction(TorturerFaction)))
			torturer = Game.GetPlayer()
			playerWantsToTorture = true
			Debug("Player initiated torture")
		else
			; Find a torturer
			torturer = GetTorturer()
			if (torturer == None)
				Debug("No torturer found, abort")
				victim.RemoveFromFaction(VictimFaction)
				return None
			endif	
		endif
	endif

	if (acti == None)
		ObjectReference acti2 = None

		; Find an Activator.  Check if the furniture has one linked
		if (activatorKwd != None)
			acti = furni.GetLinkedRef(activatorKwd)
		endif

		; Find nearby activators
		if (ActivatorDetector.IsRunning())
			Utility.Wait(2)					; Try a wait once
		endif

		if (!ActivatorDetector.IsRunning())
			DeviceCandidateAlias.ForceRefTo(furni)
			ActivatorDetector.Start()
			utility.wait(1)
			acti2 = ActivatorDetector.ActivatorAlias.GetRef()
			ActivatorDetector.Stop()
		endif

		; Use the neraby found activator if this furniture usually has a specific one nearby
		int furniId = Math.LogicalAnd(furni.GetBaseObject().GetFormID(), 0x00FFFFFF)	
		if ((acti == None) && ( JSONUtil.GetPathStringValue("../ITortureFramework/furniture.json", "." + furniId + ".Activator", "") != "" ))
			acti = acti2
		endif

		if ((acti == None) && (AutoProvision))
			acti = Positioning.PlaceActivatorAtPreset(furni, WhipActivator)
			if (acti != None)
				Debug("Placing activator at predefined position")
			else
				Debug("No activator found, create one (later)")
			endif
		endif

		if (acti == None)
			; Find a nearby activator.  If the detector is already running, skip
			acti = acti2
		else
			Debug("Using linked activation")
		endif

		if (acti == None)
			if (!AutoProvision)
				Debug("No activator, aborting")
				victim.RemoveFromFaction(VictimFaction)
				return None
			endif
		else
			Debug("Using detected activator")
		endif
	else
		Debug("Using supplied activator")
	endif

	; Get a Victim slot
	itfVictimControlScript VictimRef = GetFreeVictimSlot()
	if (VictimRef == None)
		Debug("No free slots")
		victim.RemoveFromFaction(VictimFaction)
		return None
	endif

	if (playerWantsToTorture)
		victim.Say(ComplainToPlayer)
	endif

	VictimRef.InitSlot(victim, torturer, furni, acti, params, automatic)
	Debug("Start session with: " + torturer.GetDisplayName() + " torturing " + victim.GetDisplayName() + " in " + acti)
	return VictimRef as ReferenceAlias
EndFunction

itfVictimControlScript Function GetFreeVictimSlot()
	if (VictimSlot01.GetRef() == None)
		return VictimSlot01 as itfVictimControlScript 
	elseif (VictimSlot02.GetRef() == None)
		return VictimSlot02 as itfVictimControlScript 
	elseif (VictimSlot03.GetRef() == None)
		return VictimSlot03 as itfVictimControlScript 
	elseif (VictimSlot04.GetRef() == None)
		return VictimSlot04 as itfVictimControlScript 
	elseif (VictimSlot05.GetRef() == None)
		return VictimSlot05 as itfVictimControlScript 
	else
		return None
	endif
EndFunction

itfVictimControlScript Function GetVictimSlot(Actor victim)
	if (VictimSlot01.GetActorRef() == victim)
		return VictimSlot01 as itfVictimControlScript 
	elseif (VictimSlot02.GetActorRef() == victim)
		return VictimSlot02 as itfVictimControlScript 
	elseif (VictimSlot03.GetActorRef() == victim)
		return VictimSlot03 as itfVictimControlScript 
	elseif (VictimSlot04.GetActorRef() == victim)
		return VictimSlot04 as itfVictimControlScript 
	elseif (VictimSlot05.GetActorRef() == victim)
		return VictimSlot05 as itfVictimControlScript 
	else
		return None
	endif
EndFunction


itfVictimControlScript Function GetVictimSlotForTorturer(Actor torturer)
	if ((VictimSlot01 as itfVictimControlScript ).MyTorturer.GetActorRef() == torturer)
		return VictimSlot01 as itfVictimControlScript
	elseif ((VictimSlot02 as itfVictimControlScript ).MyTorturer.GetActorRef() == torturer)
		return VictimSlot02 as itfVictimControlScript
	elseif ((VictimSlot03 as itfVictimControlScript ).MyTorturer.GetActorRef() == torturer)
		return VictimSlot03 as itfVictimControlScript
	elseif ((VictimSlot04 as itfVictimControlScript ).MyTorturer.GetActorRef() == torturer)
		return VictimSlot04 as itfVictimControlScript
	elseif ((VictimSlot05 as itfVictimControlScript ).MyTorturer.GetActorRef() == torturer)
		return VictimSlot05 as itfVictimControlScript
	else
		return None
	endif
EndFunction

Function DetectFurniture()
	if (AllowAnyFurniture)
;debug.notification("Detect")
		DeviceDetector.Stop()
		utility.wait(5)
		DeviceDetector.Start()
	endif
EndFunction

Function StopSession(Actor victim)
	itfVictimControlScript slot = GetVictimSlot(victim)
	if (slot != None)
		slot.EndSession()
	else
		victim.RemoveFromFaction(VictimFaction)
	endif
EndFunction

Function TakeOverSession(Actor torturer)
	itfVictimControlScript slot = GetVictimSlotForTorturer(torturer)
	if (slot != None)
		slot.PlayerTakesOver()
	else
		torturer.RemoveFromFaction(TorturerFaction)
	endif
EndFunction

Function StopAllSessions()
	(VictimSlot01 as itfVictimControlScript).EndSession()
	(VictimSlot02 as itfVictimControlScript).EndSession()
	(VictimSlot03 as itfVictimControlScript).EndSession()
	(VictimSlot04 as itfVictimControlScript).EndSession()
	(VictimSlot05 as itfVictimControlScript).EndSession()
EndFunction

Function Debug(string text) Global
	if (GetAPI().DebugLog)
		debug.trace("ITF: " + text)
	endif
EndFunction

Function CheckSoftRequirements()
	if (Game.GetModByname("paradise_halls.esm") != 255)
		PAHSlaveFaction = Game.GetFormFromFile(0x000047db, "paradise_halls.esm") as Faction
		PAHTiedFaction = Game.GetFormFromFile(0x0001ebf6, "paradise_halls_slextension.esp") as Faction
	endif
	if (Game.GetModByname("DiaryOfMine.esm") != 255)
		DOMSlaveFaction = Game.GetFormFromFile(0x0056C505, "DiaryOfMine.esm") as Faction
		DOMSlaverFaction = Game.GetFormFromFile(0x001E368B, "DiaryOfMine.esm") as Faction
		DOMTiedFaction = Game.GetFormFromFile(0x0058AB49, "DiaryOfMine.esm") as Faction
	endif

	if (Game.GetModByname("pah_homesweethome.esp") != 255)
		PAHHouseFaction = Game.GetFormFromFile(0x00008972, "pah_homesweethome.esp") as Faction
		PAHSceneFaction = Game.GetFormFromFile(0x00012097, "pah_homesweethome.esp") as Faction
		PAHTrainerFaction = Game.GetFormFromFile(0x000140fb, "pah_homesweethome.esp") as Faction
		PAHTraineeFaction = Game.GetFormFromFile(0x000140ff, "pah_homesweethome.esp") as Faction
		PAHPlayFaction = Game.GetFormFromFile(0x000afb7a, "pah_homesweethome.esp") as Faction
	endif

	if (Game.GetModByname("taraultimatefurniturepack.esm") != 255)
		KeywordUFP = Game.GetFormFromFile(0x00001827, "taraultimatefurniturepack.esm") as Keyword
	endif

	if (Game.GetModByname("pah_andyougetaslave.esp") != 255)
		AygasSlaveTypeFaction = Game.GetFormFromFile(0x000048e2, "pah_andyougetaslave.esp") as Faction
	endif

;	Debug.MessageBox("Using correct ITF script")
	KeywordMilker = Game.GetFormFromFile(0x0002694b, "ZaZAnimationPack.esm") as Keyword
	Positioning.InitArray()
EndFunction

bool Function VictimIsEligible(Actor victim)
	if (victim.IsDoingFavor())
		return true
	endif

	if ((PAHSlaveFaction != None) && (victim.IsInFaction(PAHSlaveFaction)))
		; We have PAH and want victims from them, so check additional conditions
		if ((victim.IsInFaction(PAHTiedFaction)) || (!PAHVictims))
			return false
		endif
	endif

	if ((DOMSlaveFaction != None) && (victim.IsInFaction(DOMSlaveFaction)))
		; We have DOM and want victims from slaves, so check additional conditions
		if ((victim.IsInFaction(DOMTiedFaction)) || (!DOMVictims))
			return false
		endif
	endif

	;if ((DOMSlaverFaction != None) && (victim.IsInFaction(DOMSlaverFaction)))
	;	; We have DOM and want victims from slavers, so check additional conditions
	;	if ((victim.IsInFaction(DOMTiedFaction)) || (!DOMVictims))
	;		return false
	;	endif
	;endif

	if ((PAHHouseFaction != None) && (victim.IsInFaction(PAHHouseFaction)))
		; We have PAH and want victims from them, so check additional conditions
		if ((victim.IsInFaction(PAHTiedFaction)) || (victim.IsInFaction(PAHSceneFaction)) || (victim.IsInFaction(PAHTrainerFaction)) || (!HSHVictims))
			return false
		endif
	endif

	return true
EndFunction

; Check if this torturer is free for some action.  Checks against global settings and HSH factions
bool Function TorturerIsEligible(ReferenceAlias TorturerSlot)
	Actor torturer = TorturerSlot.GetActorRef()
	if (torturer == None)
		return false
	endif

	if ((PAHSlaveFaction != None) && (torturer.IsInFaction(PAHSlaveFaction)))
		; We have PAH and want torturers from them, so check additional conditions
		if (torturer.IsInFaction(PAHTiedFaction) || (!PAHTorturers))
			return false
		endif
	endif

	if ((DOMSlaveFaction != None) && (torturer.IsInFaction(DOMSlaveFaction)))
		; We have DOM and want torturers from slave trainers, so check additional conditions
		if (torturer.IsInFaction(DOMTiedFaction) || (torturer.GetFactionRank(DOMSlaveFaction)==1) || (!DOMTorturers))
			return false
		endif
	endif

	if ((DOMSlaverFaction != None) && (torturer.IsInFaction(DOMSlaverFaction)))
		; We have DOM and want torturers from slavers, so check additional conditions
		if (torturer.IsInFaction(DOMTiedFaction) || (!DOMTorturers))
			return false
		endif
	endif

	if ((AygasSlaveTypeFaction != None) && (torturer.IsInFaction(AygasSlaveTypeFaction)))
		; We have Aygas and want torturers from them, so check additional conditions
		if (!AygasTorturers)
			return false
		endif
	endif


	if ((PAHHouseFaction != None) && (torturer.IsInFaction(PAHHouseFaction)))
		; We have PAH and want torturers from them, so check additional conditions
		if ((torturer.IsInFaction(PAHTiedFaction)) || (torturer.IsInFaction(PAHSceneFaction)) || (torturer.IsInFaction(PAHTraineeFaction)) || (torturer.IsInFaction(PAHTrainerFaction)) || \
			 ((!HSHTorturers) && (!HSHDomTorturers)) )
			return false
		endif

		if ((!HSHTorturers) && (HSHDomTorturers) && (torturer.GetFactionRank(PAHPlayFaction) != 1))
			return false
		endif
	endif

	return true
EndFunction

; Let player execute an action on the victim
; 1=kiss, 2=fondle, 3=slap, 4=pinch, 5=hit, 6=whip
Function PlayerAction(Actor victim, int act)
	itfVictimControlScript victimRef = GetVictimSlot(victim)
	if (victimRef != None)
		victimRef.TortureAction(act)
	endif
EndFunction


; Reserve this NPC in HSH so that mods scripts don't interfere
Function ReserveInHSH(Actor npc, bool reserve)
	if ((PAHHouseFaction != None) && (npc.IsInFaction(PAHHouseFaction)))
		if (reserve)
			npc.SetFactionRank(PAHSceneFaction, 1)
			npc.SetDontMove(false)
			if (npc.GetSitState() == 0)
				debug.SendAnimationEvent(npc, "IdleForceDefaultState")
			endif
		else
			npc.RemoveFromFaction(PAHSceneFaction)
		endif
	endif
EndFunction

Function RemoveAllAutoMarkers()
	ObjectReference marker = Game.FindClosestReferenceOfType(WhipActivator, Game.GetPlayer().x, Game.GetPlayer().Y, Game.GetPlayer().Z, 8000)
	if (marker != None)
		marker.delete()
		marker = Game.FindClosestReferenceOfType(WhipActivator, Game.GetPlayer().x, Game.GetPlayer().Y, Game.GetPlayer().Z, 8000)
		if (marker == None)
			Debug.notification("Last nearby marker deleted")
		endif
	else
		Debug.notification("No markers found")
	endif
EndFunction

Function UnslotFurniture(ObjectReference f)
	ReferenceAlias ref = DeviceDetector.FurnitureSlot(f)
	if (ref != None)
		ref.Clear()
	endif
EndFunction


Actor Function GetTorturer()
	TorturerDetector.Start()
	Actor torturer = None
	utility.wait(1)
	if (TorturerIsEligible(TorturerDetector.Torturer1))
		torturer = TorturerDetector.Torturer1.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer2))
		torturer = TorturerDetector.Torturer2.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer3))
		torturer = TorturerDetector.Torturer3.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer4))
		torturer = TorturerDetector.Torturer4.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer5))
		torturer = TorturerDetector.Torturer5.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer6))
		torturer = TorturerDetector.Torturer6.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer7))
		torturer = TorturerDetector.Torturer7.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer8))
		torturer = TorturerDetector.Torturer8.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer9))
		torturer = TorturerDetector.Torturer9.GetActorRef()
	elseif (TorturerIsEligible(TorturerDetector.Torturer10))
		torturer = TorturerDetector.Torturer10.GetActorRef()
	endif
	TorturerDetector.Stop()
	return torturer
EndFunction

bool Function IsFurnitureSlotted(ObjectReference furni)
	return ( ((VictimSlot01 as itfVictimControlScript ).Device == furni) || \
			((VictimSlot02 as itfVictimControlScript ).Device == furni) || \
			((VictimSlot03 as itfVictimControlScript ).Device == furni) || \
 			((VictimSlot04 as itfVictimControlScript ).Device == furni) || \
			((VictimSlot05 as itfVictimControlScript ).Device == furni) )
EndFunction



Keyword Property KeywordDevice Auto
Keyword Property KeywordActivator Auto
Keyword Property KeywordEffect Auto
Keyword Property KeywordSpecialFurniture Auto
Keyword Property KeywordUFP Auto
Keyword Property KeywordZBF Auto
Keyword Property KeywordDummy Auto
Keyword Property KeywordMilker Auto Hidden
FormList Property EligibleFurnitureList Auto	; Add furniture to be used to this list

ReferenceAlias Property DeviceCandidateAlias Auto
Faction Property TorturerFaction Auto
Faction Property VictimFaction Auto
Faction Property IgnoreFaction Auto
ObjectReference Property TeleportMark Auto
Activator Property WhipActivator Auto
Topic Property ComplainToPlayer Auto

itfFurnitureDetectorScript Property DeviceDetector Auto
itfActivatorDetectorScript Property ActivatorDetector Auto
itfTorturerDetectorScript Property TorturerDetector Auto

ReferenceAlias Property VictimSlot01 Auto
ReferenceAlias Property VictimSlot02 Auto
ReferenceAlias Property VictimSlot03 Auto
ReferenceAlias Property VictimSlot04 Auto
ReferenceAlias Property VictimSlot05 Auto
zbfPlayerControl Property PlayerControl Auto

Faction Property PAHSlaveFaction Auto
Faction Property PAHTiedFaction Auto
Faction Property PAHHouseFaction Auto
Faction Property PAHSceneFaction Auto
Faction Property PAHTrainerFaction Auto
Faction Property PAHTraineeFaction Auto
Faction Property PAHPlayFaction Auto
Faction Property AygasSlaveTypeFaction Auto
Faction Property DOMSlaveFaction Auto Hidden
Faction Property DOMSlaverFaction Auto Hidden
Faction Property DOMTiedFaction Auto Hidden

; MCM Configurable options.  Rest of the options live in GlobalParameters
bool Property AutoProvision Auto			; Automatically set up torture furniture for use by this mod. If the mod attempts to use a furniture without activator, it will add a generic one.
bool Property AllowAnyFurniture Auto		; Look for eligible furniture in the room and allow it to be used for torture.
bool Property AllowAnyTorturer Auto	Conditional		; Enable to let any NPC to be a torturer.  If disabled, use the itfTorturerCandidate magic effect or faction to designate torturers
bool Property IgnoreMilkers Auto				; Ignore milking machines
bool Property DebugLog Auto
bool Property AygasTorturers Auto
bool Property PAHTorturers Auto
bool Property PAHVictims Auto
bool Property DOMTorturers = true Auto Hidden
bool Property DOMVictims =true Auto Hidden
bool Property HSHTorturers Auto
bool Property HSHDomTorturers Auto
bool Property HSHVictims Auto
int Property TestAnim Auto

itfDeviceParameterScript Property GlobalParameters Auto
itfPositioning Property Positioning Auto
