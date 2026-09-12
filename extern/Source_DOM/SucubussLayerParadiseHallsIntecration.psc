Scriptname SucubussLayerParadiseHallsIntecration Extends quest

EssentalSucubuss Property ES Auto
SucubussLayerMainScript Property SLMS Auto

DOM_Core DOM01

Bool Function DOMCoreIntegration()
	int TargetModIndex = Game.GetModByName("DiaryOfMine.esm")
 	if TargetModIndex != 255
		if DOM01 != None
			return True
		endif
		DOM01 = Game.GetFormFromFile(0x0D61, "DiaryOfMine.esm") as DOM_Core
		if DOM01 != None
			Return True
		Endif
	endif
	Return False
EndFunction

Bool Function CheckIfTargetisPAHSlave(actor akTarget)
	if !DOMCoreIntegration()
		Return False
	Endif
	Faction DOMActorFaction = DOM01.DOMActorFaction
	if akTarget.GetInFaction(DOMActorFaction)
		return True
	endif
	Return False
EndFunction

ActorBase Property Clone Auto
Bool Function GetSlavePAH(Actor akTarget)
	if PAHactiv
		debug.Notification("DOM is busy")
		Return false
	Endif
	PAHactiv = True
	if !DOMCoreIntegration()
		PAHactiv = false
		Return False
	Endif

	if SLMS.GenerateID(false) == 999
		PAHactiv = false
		Debug.Notification("No Space in Farms")
		Return False
	Endif

	DOM_Actor SlavePointer = DOM01.GetActor(akTarget)
	if SlavePointer == None
		PAHactiv = false
		Return False
	endif
	DOM_Mind SlaveMind = SlavePointer.mind
	if SlaveMind == None
		PAHactiv = false
		Return False
	endif
	float ABSM = SlaveMind.submission
	float ABCB = SlaveMind.combat_training
	float ABAG = SlaveMind.anger_training
	float ABPS = SlaveMind.pose_training
	float ABRS = SlaveMind.respect_training
	float ABSX = SlaveMind.sex_training
	
	float PHSI_oral_training    = SlaveMind.oral_training
	float PHSI_vaginal_training = SlaveMind.vaginal_training
	float PHSI_anal_training    = SlaveMind.anal_training
	float PHSI_fear_training    = SlaveMind.fear_training

	float ATT_phys = SlaveMind.work_training  ; Workpower
	float ATT_int  = SlaveMind.humiliation    ; Intelligence
	float ATT_cond = SlaveMind.resignation    ; Perseverance
	
	SucubussLayerSlaveMarker Aufruf = none
	int ID = 0
	if akTarget.GetActorBase() == Clone ;is one of my OldClones
		Aufruf = akTarget as SucubussLayerSlaveMarker
		if !Aufruf.SaveID(akTarget) 
			PAHactiv = false
			Return False
		Endif
		ID = Aufruf.ReadID()
		SLMS.GiveAttributestoSlave(ID, Aufruf.GotyouBack(1), Aufruf.GotyouBack(2), Aufruf.GotyouBack(3), 0.0, 0.0, 0.0, 0.0, Aufruf.GotyouBack(9), Aufruf.GotyouBack(10))
		SLMS.SlaveMover(0, ID)
		DOM01.ReleaseActor(akTarget)
		;akTarget.RemoveFromAllFactions()
		SLMS.SETREST(ID)	
	Else
		actor NEWSlavemade = SLMS.Enslave(akTarget, game.getPlayer(), true)
		if NEWSlavemade == none
			PAHactiv = false
			Return False
		Endif
		ID = SLMS.SearchID(NEWSlavemade)
		Aufruf = NEWSlavemade as SucubussLayerSlaveMarker
	Endif
	if ABRS == 0.0
		ABRS = SLMS.AttributeSaveRespectRead(ID)
	Endif
	if ABSX == 0.0
		ABSX = SLMS.AttributeSaveSexRead(ID)
	Endif
	SLMS.GiveAttributestoSlave(ID, ATT_phys, ATT_int, ATT_cond, ABSM, ABCB, ABAG, ABRS, ABPS, ABSX)
	if Aufruf != none
		SLMS.AttributeSaveConditionWrite(ID, Aufruf.GetAttribute(4) /2)
	Endif
	Aufruf.SetAttributesiffromPAH(PHSI_oral_training, PHSI_vaginal_training, PHSI_anal_training, PHSI_fear_training)
	Aufruf.SetEquipItem(true)
	PAHactiv = false
EndFunction

Bool PAHactiv
VisualEffect Property TeleportEffect Auto
Bool Function GiveSlavePAH(actor akTarget, bool NotFromLayer = false, bool NotInLayer = false)
	if PAHactiv
		debug.Notification("DOM is busy")
		Return false
	Endif
		PAHactiv = True
	if !DOMCoreIntegration()
		PAHactiv = false
		Return False
	Endif

	SucubussLayerSlaveMarker Aufruf = akTarget as SucubussLayerSlaveMarker
	
	int ID = SLMS.SearchID(akTarget)
	
	
		akTarget.SetCrimeFaction(None)
		;akTarget.RemoveFromAllFactions()
		akTarget.SetAv("Aggression", 0)
		akTarget.SetAv("Confidence", 2)
		akTarget.SetAv("Assistance", 0)
		akTarget.IgnoreFriendlyHits(true)


	akTarget.RemoveFromFaction(DOM01.DOMActorExcludedFaction)
	DOM_Actor SlaveTarget = DOM01.MoveNPCToDOM(akTarget)

	if !NotInLayer
		TeleportEffect.play(akTarget,4)
	Endif
	if !NotFromLayer
		SLMS.GiveMeMyAttributs(ID)
	Endif

	if SlaveTarget != None
		DOM_Mind SlaveMind = SlaveTarget.mind
		If SlaveMind != None
			SlaveMind.submission = Aufruf.GetAttribute(5)
			SlaveMind.combat_training = Aufruf.GetAttribute(6)
			SlaveMind.anger_training = Aufruf.GetAttribute(7)
			SlaveMind.respect_training = Aufruf.GetAttribute(8)
			SlaveMind.pose_training = Aufruf.GetAttribute(9)
			
			SlaveMind.oral_training = Aufruf.GetAttribute(20)
			SlaveMind.vaginal_training = Aufruf.GetAttribute(21)
			SlaveMind.anal_training = Aufruf.GetAttribute(22)
			SlaveMind.fear_training = Aufruf.GetAttribute(23)

			SlaveMind.work_training = Aufruf.GetAttribute(1)
			SlaveMind.humiliation = Aufruf.GetAttribute(2)
			SlaveMind.resignation = Aufruf.GetAttribute(3)
		
			float sex_training = Aufruf.GetAttribute(10)
			sex_training -= SlaveMind.oral_training
			sex_training -= SlaveMind.anal_training
			if sex_training > SlaveMind.vaginal_training
				SlaveMind.vaginal_training = sex_training
			endif
		Endif
	Endif
	
	Aufruf.Register(100, none, false, false)
	if !NotInLayer
		ES.MovetoLocation(akTarget, 0)
	Endif
	akTarget.AllowPCDialogue(true)
	Debug.Notification("Given to DOM")
	PAHactiv = false
	Return True
	
EndFunction

Function GetAttributesfromSlavePAH(actor akTarget)
	if !DOMCoreIntegration()
		Return
	Endif
	SucubussLayerSlaveMarker Aufruf = akTarget as SucubussLayerSlaveMarker
	DOM_Actor SlaveTarget = DOM01.GetActor(akTarget)
	if SlaveTarget == None
		Return
	endif
	DOM_Mind SlaveMind = SlaveTarget.mind
	if SlaveMind == None
		Return
	endif
	Aufruf.EdditAttributeSave(SlaveMind.work_training, \
	SlaveMind.humiliation, \
	SlaveMind.resignation, \
	SlaveMind.work_training, \
	SlaveTarget.submission, \
	SlaveTarget.combat_training, \
	SlaveTarget.anger_training, \
	SlaveTarget.respect_training, \
	SlaveTarget.pose_training, \
	SlaveTarget.sex_training, \
	SlaveTarget.oral_training, \
	SlaveTarget.vaginal_training, \
	SlaveTarget.anal_training, \
	SlaveTarget.fear_training)
EndFunction

bool Function CheckifitsPAH(actor akTarget)
	if !DOMCoreIntegration()
		Return false
	Endif
	if akTarget.IsInFaction(DOM01.DOMActorAlias)
		Return true
	Endif
	Return false
EndFunction

Function GiveAttributestoSlavePAH(actor akTarget)
	if !DOMCoreIntegration()
		Return
	Endif
	SucubussLayerSlaveMarker Aufruf = akTarget as SucubussLayerSlaveMarker
	DOM_Actor SlaveTarget = DOM01.GetActor(akTarget)
	if SlaveTarget == None
		Return
	endif
	DOM_Mind SlaveMind = SlaveTarget.mind
	if SlaveMind == None
		Return
	endif
	SlaveMind.submission = Aufruf.GetAttribute(5)
	SlaveMind.combat_training = Aufruf.GetAttribute(6)
	SlaveMind.anger_training = Aufruf.GetAttribute(7)
	SlaveMind.respect_training = Aufruf.GetAttribute(8)
	SlaveMind.pose_training = Aufruf.GetAttribute(9)
		
	SlaveMind.oral_training = Aufruf.GetAttribute(20)
	SlaveMind.vaginal_training = Aufruf.GetAttribute(21)
	SlaveMind.anal_training = Aufruf.GetAttribute(22)
	SlaveMind.fear_training = Aufruf.GetAttribute(23)
	
	SlaveMind.sex_training = Aufruf.GetAttribute(10)
EndFunction

Bool Function PAHMenuShow(actor akTarget)
	if !DOMCoreIntegration()
		Return False
	Endif

	string msg = DOM01.NPCStatsMessage(akTarget)
    SendMessage(msg);
EndFunction