Scriptname aygasScenesScript extends Quest

Function OnInit()
	UnregisterForUpdate()
	OnUpdate()

EndFunction

Event OnUpdate()
	Aygas.WorkDetector.Detect()
	Aygas.IsPlayerHouse()

	; Check for any job events
	; Prostitution
	if ((Utility.RandomInt(1, 2) == 1) && (!Aygas.EventFunctions.ActivateAuctionPackages))	; Skip events when event in progress
		Actor slave = Aygas.WorkDetector.RandomProstitute()

		; Is the location eligible (City with open slavery, wilderness is NOT eligible for random encounters, tavern, or indoors in a city with slavery > 3
		if ((slave != none) && (Aygas.LocationEligibleForProstitution(slave, false)))
			; Regular prostitution scene
			Actor client = Aygas.FindEligibleJohn(slave, Game.GetPlayer(), 1500)
			Aygas.DebugLog("Evaluate pro trick for " + slave.GetDisplayName() + " with:" + client.GetDisplayName())

			if (client != None) 	
				ObjectReference bed = Game.FindRandomReferenceOfAnyTypeInListFromRef(Aygas.Beds, slave, 2048)
				; Is client eligible and not busy?
				if (Aygas.JobSlaveAvailable(slave, false))
					if (ProTrickCustomer.GetRef() != None)
						Aygas.DebugLog("Pro Trick Scene is occupied")
					else
						ProTrickProstituteCandidate.ForceRefTo(slave)
						ProTrickProstitute.ForceRefTo(slave)
						ProTrickCustomer.ForceRefTo(client)	
						if (UseBed(bed))
							ProTrickTargetBed.ForceRefTo(bed)	
						else
							ProTrickTargetBed.Clear()	
						endif				
						if (Aygas.ProPimp)
							Aygas.DebugLog("Pro autonomous start")
							ProTrickContinueAuto(client)
						else
							Aygas.DebugLog("Pro Scene start")
						endif
					endif
				endif
			else
				Aygas.DebugLog("No client found")
				ProTrickProstituteCandidate.Clear()
			endif
		else
			Aygas.DebugLog("Location not eligible or no slave found")
			ProTrickProstituteCandidate.Clear()
		endif
	endif

	Aygas.CheckSlavesNearPlayer()		; Not strictly part of this script, but needs to be done every now & then

	RegisterForSingleUpdate(30)
EndEvent

bool Function NPCInScene(Actor npc)
	return ((npc == InnTrickCustomer.GetActorRef()) || (npc == WhipMaster.GetActorRef()) || (npc == PunishMaster.GetActorRef()) || (npc == ProTrickCustomer.GetActorRef())|| (npc == ProTrickCustomerRes.GetActorRef()))
EndFunction

Function ProTrickContinueAuto(Actor client)
	ProTrickProstituteCandidate.Clear()
	Aygas.WorkFunctions.JobPay(ProTrickProstitute.GetActorRef(), Aygas.WorkFunctions.ProstituteValue(ProTrickProstitute.GetActorRef()))

	; Add increase in sex xp
	Aygas.DoJobExperience(ProTrickProstitute.GetActorRef())
	Aygas.proProstituteTricks += 1
	Aygas.EvaluatePerks()

	ProTrickAutoScene.Start()
	ApplyClientCooldown(client)
EndFunction

Function ProTrickContinue(Actor client)
	ProTrickCustomer.ForceRefTo(client)
	ProTrickProstituteCandidate.Clear()
	Game.GetPlayer().AddItem(Aygas.Gold, Aygas.WorkFunctions.ProstituteValue(ProTrickProstitute.GetActorRef()))

	; Add increase in sex xp
	Aygas.DoJobExperience(ProTrickProstitute.GetActorRef())
	Aygas.proProstituteTricks += 1
	Aygas.EvaluatePerks()

	ProTrickScene.Start()
	ApplyClientCooldown(client)
EndFunction

Function InnTrickStop()
	InnTrickScene.Stop()
	InnTrickProstitute.Clear()
	InnTrickCustomer.Clear()
EndFunction

Function ProTrickStop()
	ProTrickScene.Stop()
	ProTrickProstitute.Clear()
	ProTrickCustomer.Clear()
	ProTrickProstituteCandidate.Clear()
EndFunction

Function ProTrickResStop()
	ProTrickResScene.Stop()
	ProTrickProstituteRes.Clear()
	ProTrickCustomerRes.Clear()
EndFunction

Function BrothelStop()
	ServeDrinkScene.Stop()
	ServeDrinksCourtesanRef.Clear()
	ServeDrinksPatronRef.Clear()
	utility.wait(3)
	int n = BrothelPatrons.length
	int i = 0
	while i < n
		BrothelPatrons[i].Clear()
		i += 1
	endwhile
EndFunction

Function ClearScenes()
;	Aygas.DebugMessage("Clearing scenes")
	ProTrickStop()
	ProTrickResStop()
	InnTrickStop()
	BrothelStop()
	ReleaseReservedProstitute()
	ProTrickProstituteCandidate.Clear()
EndFunction

Function ServeDrinks(Actor courtesan, Actor patron, ObjectReference seat)
	if ((!ServeDrinkScene.IsPlaying()) && (Aygas.JobSlaveAvailable(courtesan, false)) && (Aygas.JobSlaveAvailable(patron, false)))
		Aygas.DebugMessage(courtesan.GetDisplayName() + " serving drinks to " + patron.GetDisplayName())
		ServeDrinksCourtesanRef.ForceRefTo(courtesan)
		ServeDrinksPatronRef.ForceRefTo(patron)
		ServeDrinksSeatRef.ForceRefTo(seat)
		ServeDrinkScene.Start()
	else
		Aygas.DebugMessage("Serving: scene or actors occupied")
	endif
EndFunction

; Fill in client in order to also evaluate sex preferences, or set to None
Function ReserveRandomProstitute(Actor client)
	Actor[] candidates = new Actor[3]
	ReservedProstitute.Clear()
	int i = 0
	int j = 0
	int rejected = 0
	int n = aygas.WorkDetector.Prostitutes.length
	int m = candidates.length
	while j < n && i < m
		if (Aygas.JobSlaveAvailable(aygas.WorkDetector.Prostitutes[j], true))
			candidates[i] = aygas.WorkDetector.Prostitutes[j]
			i += 1
		endif
		j += 1
	endwhile

	if (i > 0)
		i -= 1
		int c = Utility.RandomInt(0, i)
		ReservedProstitute.ForceRefTo(candidates[c])
;		ReservedProstitute.GetActorRef().SetFactionRank(Aygas.JobOverrideAction, 2)
		Scene s = ReservedProstitute.GetActorRef().GetCurrentScene()
		if (s != None)
			s.Stop()		; End whatever scene was going on with the prostitute
		endif

		if (Aygas.GenderCheck(ReservedProstitute.GetActorRef(), client))
			rejected += 1
		endif

		ProstitutePrice.SetvalueInt(Aygas.WorkFunctions.ProstituteValue(candidates[c]))
		UpdateCurrentInstanceGlobal(ProstitutePrice)
;		ProstitutesRejected.SetvalueInt(rejected)
;		UpdateCurrentInstanceGlobal(ProstitutesRejected)		

		Aygas.DebugLog("Reserved " + ReservedProstitute.GetActorRef().GetDisplayName()+ ", rejected:" + rejected)
	else
		Aygas.DebugLog("Failed to reserve, candidate is " + ProTrickProstituteCandidate.GetActorRef().GetDisplayName() + ", rejected:" + rejected)
;		ProstitutesRejected.SetvalueInt(0)
;		UpdateCurrentInstanceGlobal(ProstitutesRejected)		
	endif
EndFunction

Function ReleaseReservedProstitute()
	if (ReservedProstitute.GetActorRef() != None)
		ReservedProstitute.GetActorRef().RemoveFromFaction(Aygas.JobOverrideAction)
	endif
	ReservedProstitute.Clear()
EndFunction

Function ProceedWithReservedProstitute(Actor client)
	Actor slave = ReservedProstitute.GetActorRef()
	if (slave != None)
		ApplyClientCooldown(client)
		Game.GetPlayer().AddItem(Aygas.Gold, ProstitutePrice.GetValueInt())

		ProTrickCustomerRes.ForceRefTo(client)
		ProTrickProstituteRes.ForceRefTo(ReservedProstitute.GetActorRef())
		ObjectReference bed = Game.FindRandomReferenceOfAnyTypeInListFromRef(Aygas.Beds, slave, 2048)
		if (UseBed(bed))
			ProTrickTargetBedRes.ForceRefTo(bed)
		else
			ProTrickTargetBedRes.Clear()
		endif

		; Add increase in sex xp
		Aygas.DoJobExperience(ProTrickProstituteRes.GetActorRef())
		Aygas.proProstituteTricks += 1
		Aygas.EvaluatePerks()

		ProTrickResScene.Start()
	endif
	ReleaseReservedProstitute()
EndFunction

Function ApplyClientCooldown(Actor client)
	Aygas.TrickCooldownSpell.Cast(client, client)
EndFunction

Function ProstitutionSceneCancel(Actor slave)
	if (slave == ProTrickProstitute.GetActorRef())
		ProTrickStop()
	elseif (slave == ProTrickProstituteRes.GetActorRef())
		ProTrickResStop()
	endif
EndFunction

Function ReleaseFromObject(Actor slave)
	slave.SetFactionRank(Aygas.JobOverrideAction, 0)
	ObjectReference f = StorageUtil.GetFormValue(slave, "BoundFurniture") as ObjectReference
	if (f != None)
		f.Delete()
		StorageUtil.UnsetFormValue(slave, "BoundFurniture")
	endif
	Aygas.ITF.IgnoreNPC(slave, false)
EndFunction

ObjectReference Function BindInObject(Actor slave, Actor owner, Furniture furn, bool doTorture, int zOffset = 0)
	Objectreference f
	Aygas.DebugLog(slave.GetDisplayName() + " to be bound in " + furn.GetName())
	slave.EnableAI(false)
	f = slave.PlaceAtme(furn, 1) 
	f.MoveTo(slave, 0, 0, zOffset, true)
	f.SetAngle(0, 0, f.GetAngleZ())

	slave.EnableAI(true)
	StorageUtil.SetFormValue(slave, "BoundFurniture", f)
	BindInObjectRef(slave, owner, f, doTorture)
	return f
EndFunction 

Function BindInObjectRef(Actor slave, Actor owner, ObjectReference furn, bool doTorture)
	if ((Aygas.HasTortureFramework) && (doTorture))
		Aygas.ITF.BindInFurniture(furn, slave, owner)
	else
		; TODO: just sit in furniture
	endif
EndFunction

bool Function UseBed(ObjectReference bed)
	return ((bed != None) &&  ((Game.GetPlayer().IsInInterior()) || (Aygas.IsEligibleForProstitutionCity)) )
EndFunction

ReferenceAlias Property InnTrickProstitute Auto
ReferenceAlias Property InnTrickCustomer Auto
ReferenceAlias Property InnTrickTargetBed Auto

ReferenceAlias Property WhipSlave Auto
ReferenceAlias Property WhipMaster Auto

ReferenceAlias Property PunishSlave Auto
ReferenceAlias Property PunishMaster Auto

ReferenceAlias Property ProTrickProstitute Auto
ReferenceAlias Property ProTrickProstituteCandidate Auto
ReferenceAlias Property ProTrickCustomer Auto
ReferenceAlias Property ProTrickTargetBed Auto
ReferenceAlias Property ReservedProstitute Auto 
ReferenceAlias Property ProTrickProstituteRes Auto
ReferenceAlias Property ProTrickCustomerRes Auto
ReferenceAlias Property ProTrickTargetBedRes Auto
ReferenceAlias Property ServeDrinksCourtesanRef Auto
ReferenceAlias Property ServeDrinksPatronRef Auto
ReferenceAlias Property ServeDrinksSeatRef Auto
				  
ReferenceAlias[] Property BrothelPatrons Auto

Actor[] __BrothelPatronCandidatesM
Actor[] Property BrothelPatronCandidatesM
	Actor[] Function Get()	
		If !__BrothelPatronCandidatesM
			__BrothelPatronCandidatesM = new Actor[16]
		endif
		return __BrothelPatronCandidatesM
	EndFunction
EndProperty
Actor[] __BrothelPatronCandidatesF
Actor[] Property BrothelPatronCandidatesF
	Actor[] Function Get()	
		If !__BrothelPatronCandidatesF
			__BrothelPatronCandidatesF = new Actor[16]
		endif
		return __BrothelPatronCandidatesF
	EndFunction
EndProperty

Scene Property InnTrickScene Auto
Scene Property ShortWhipScene Auto
Scene Property PunishScene Auto
Scene Property ProTrickScene Auto
Scene Property ProTrickResScene Auto
Scene Property ProTrickAutoScene Auto
Scene Property ServeDrinkScene Auto

GlobalVariable Property ProstitutePrice Auto
; GlobalVariable Property ProstitutesRejected Auto

Keyword Property KeywordInn Auto

aygasCoreScript Property Aygas Auto

Weapon Property Cane Auto