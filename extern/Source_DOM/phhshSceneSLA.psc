Scriptname phhshSceneSLA extends Quest  Conditional

PHHSHInterface Property PHHSHInter Auto

Function ProcessArousals(float  argNum)
	; Process arousal values from nearby NPCs.  Kicked off by SLA.  Must complete within a few seconds, so the arrays are copied first
	Actor[] followers = new Actor[20]
	int numFollowers = 0

	if(argNum > 0)
;		Debug.Notification("SLA updated")
		utility.wait(1)	; Allow SLA to finish

		int myLockNum = Utility.RandomInt(10, 32000)
		Actor[] actors 
		if (PHHSH.SLAL.GetActors(myLockNum, argNum))
			PHHSH.SLAL.UnlockScan(myLockNum)
			if PHHSH.SLAL.actorsNumber != 0
				;debug.Notification("  SLA: Empty actor array")
			;else
				;debug.Notification("  SLA: Got actor array")
				actors = PHHSH.SLAL.actorList
				int i = 0
				int n = PHHSH.SLAL.actorsNumber
				while (i < argNum) && i < n ; && (actors != None)
					; Find aroused followers
					Actor akActor
					if i < actors.length
						akActor = actors[i]
					else
						akActor = None
					endif
					if akActor != None
						if PHHSHInter.IsFollowerAvailableForScene(akActor)
							int x = PHHSH.SLAL.GetActorArousal(akActor)
;							Debug.Notification("> " + akActor.GetDisplayName() + "  " + x)
							if ((numFollowers < 20) && (x > PHHSH.ArousedFollowerThreshold))
								followers[numFollowers] = akActor
								numFollowers += 1
							endif
						endif
					endif
					i+=1
				endwhile
			endif
		else
			PHHSH.SLAL.UnlockScan(myLockNum)
;			debug.Notification("  SLA: No actors")
		endif

		; Process followers
		while (numFollowers > 0)
			numFollowers -= 1
			Actor f = followers[numFollowers]

			; Check if follower is restricted in any way
			string struggleAnim = ""
			if PHHSH.DOMZaz.wornBelt(f)
				struggleAnim = "ZaZAPCSHFA2"
			elseif PHHSH.DOMZaz.wornYoke(f)
				struggleAnim = "ZapYokeHorny01"
			elseif PHHSH.DOMZaz.wornArmbinder(f)
				struggleAnim = "ZapArmbHorny01"
			elseif PHHSH.DOMZaz.wornEffectWrist(f) ; Check this last for Zbf devices
				struggleAnim = "ZapWriHorny01"
			endif

			if ((f.GetCurrentScene() == None) && (!PHHSHInter.IsActorActive(f)) && (!f.IsChild()) && (!f.IsOnMount()) && (!f.IsBeingRidden()) && (!f.IsInCombat()) && (!f.IsDoingFavor()) && ((PHHSH.DisplayModelFaction == None) || (!f.IsInFaction(PHHSH.DisplayModelFaction )  ))   )    ; && (f.GetDialogueTarget() != Game.GetPlayer()) )
				; Start scene, stop processing followers
;				numFollowers = 0
				if (struggleAnim == "")
					StartFollowerScene(f)
				else
					if (!SceneFollowerStruggle.IsPlaying())
						FollowerStruggleRef.ForceRefTo(f)
						Debug.SendAnimationEvent (f, struggleAnim)
						SceneFollowerStruggle.Start()
;					else
;						Debug.SendAnimationEvent (f, struggleAnim)
;						utility.wait(10)
;						Debug.SendAnimationEvent (f, "IdleForceDefaultState")
					endif
				endif
			else
;				debug.notification("sc:" + (f.GetCurrentScene() != None) + " sl:" + 	PHHSHInter.IsActorActive(f) + " c:" + 	f.IsInCombat() + "  dlg:" + (f.GetDialogueTarget() == Game.GetPlayer()) )	
			endif
		endwhile
	endif
EndFunction


Function StartFollowerScene(Actor follower)
;	Debug.Notification("Start scene on " + follower.GetDisplayName())
	Location loc = follower.GetCurrentLocation()
	if ((loc != None) && (!loc.HasKeyword(DungeonKeyword)))
		DetectActors()
		Actor slave = PHHSH.ActorDetector.RandomSexSlave()
		if ((slave != None) && (!SceneFollowerSex.IsPlaying()))
;			Debug.Notification("   using slave:" + slave.GetDisplayName())
			PHHSHInter.WaitHere(slave)
			FollowerRef.ForceRefTo(follower)
			FollowerSlaveRef.ForceRefTo(slave)
			SetNearbyBed()
			SceneFollowerSex.Start()
			PHHSHInter.IncreaseSexTraining(slave, utility.RandomInt(4,8))
		endif
	endif
EndFunction

Function DetectActors()
	PHHSH.ActorDetector.Clear()
	PHHSH.ActorDetector.Stop()
	utility.wait(5)
	PHHSH.ActorDetector.Start()
EndFunction

Function StartTMReleaseScene(Actor taskm, Actor slave)
	if (!ReleaseFromDevice.IsPlaying())
		Taskmaster.ForceRefTo(taskm)
		TaskMasterReleaseTarget.ForceRefTo(slave)
		ReleaseFromDevice.Start()
	endif
EndFunction


Function SetNearbyBed()
	Actor follower = FollowerRef.GetActorRef()
	if (follower != None) && PHHSH.DOMSexlab.Beds != None
		ObjectReference bed = Game.FindClosestReferenceOfAnyTypeInListFromRef(PHHSH.DOMSexlab.Beds, follower, 2048)
		if (bed != None)
			FollowerBedRef.ForceRefTo(bed)
;			debug.notification("Picked bed")
		else
			FollowerBedRef.Clear()
		endif
	endif
EndFunction

Function EndSitScene()
	SceneChairRub.Stop()
	ChairMasterRef.Clear()
	ChairSlaveRef.Clear()
	ReleaseChairMarkers()
EndFunction

Function ReleaseChairMarkers()
	if (ChairMarkerFRef.GetRef() != None)
		ChairMarkerFRef.GetRef().Delete()
	endif
	if (ChairMarkerBRef.GetRef() != None)
		ChairMarkerBRef.GetRef().Delete()
	endif
	ChairMarkerFRef.Clear()
	ChairMarkerBRef.Clear()
EndFunction

Function ClearSitAnims()
	actor a = StorageUtil.FormListShift(None, "PHHSHChairScene") as Actor
	while (a != None)
		a.SetDontMove(false)
		a.SetHeadTracking(true)
		a.SetRestrained(false)
		a.RemoveFromFaction(PHHSH.InSceneFaction)
		debug.sendanimationevent(a, "IdleForceDefaultState")
		a = StorageUtil.FormListShift(None, "PHHSHChairScene") as Actor
	endwhile
	StorageUtil.FormListClear(None, "PHHSHChairScene")
EndFunction


Function MasterGetsUp(Actor master)
	if (master == ChairMasterRef.GetActorRef())
		EndSitScene()
	endif
	Actor s = StorageUtil.GetFormValue(master, "PHHSHChairScene") as Actor
	if (s != None)
		StorageUtil.UnsetFormValue(master, "PHHSHChairScene")
		Debug.SendAnimationEvent(s, "IdleForceDefaultState")
		s.SetDontMove(false)
		s.SetHeadTracking(true)
		s.SetRestrained(false)
		s.RemoveFromFaction(PHHSH.InSceneFaction)

	endif
EndFunction

Function MasterSits(Actor master, ObjectReference furnRef)
	Furniture furn = furnRef.GetBaseObject() as Furniture
	if (furn != None)
;		Debug.Notification(master.GetDisplayName() + " sits in " + furn.GetName())

		bool hasFront = false
		bool hasBack = false
		bool eligible = false
		isStool = false

		; Check eligible furniture
		if (StringUtil.Find(furn.GetName(), "Chair", 0) >= 0)
			eligible = true
			hasFront = true
			hasBack = true
		elseif (StringUtil.Find(furn.GetName(), "Bench", 0) >= 0)
			eligible = true
			hasFront = true
			hasBack = true
		elseif (StringUtil.Find(furn.GetName(), "Throne", 0) >= 0)
			eligible = true
			hasFront = true
			hasBack = false
		elseif (StringUtil.Find(furn.GetName(), "Table", 0) >= 0)
			eligible = true
			hasFront = false
			hasBack = true
		elseif (StringUtil.Find(furn.GetName(), "Stool", 0) >= 0)
			eligible = true
			hasFront = false
			hasBack = true
			isStool = true
		endif

		if (eligible)
			; Check master not busy
			if ((master.GetCurrentScene() == None) && (!PHHSHInter.IsActorActive(master)) && (!master.IsChild()) && (!master.IsInCombat()) && (!master.IsDoingFavor()) ) 
				; find applicable slave
				PHHSH.ActorDetector.Clear()
				PHHSH.ActorDetector.Stop()
				utility.wait(2)
				PHHSH.ActorDetector.Start()
				Actor slave = PHHSH.ActorDetector.RandomSexSlave()
				Actor follower = PHHSH.ActorDetector.RandomPlayerFollower()
				Actor selected = None

				if (master == Game.GetPlayer())
					; Check follower arousal
					if ((PHHSH.SLAL.GetActorArousal(follower) >  PHHSH.ArousedFollowerThreshold * 0.9) && (PHHSH.ArousedFollowerThreshold < 100))
						selected = follower
					endif
				endif
				if (selected == None)
					; Check slave arousal
					selected = slave
				endif

				if ((selected != None) && (selected.GetCurrentScene() == None) && (!PHHSHInter.IsActorActive(selected)) && (!selected.IsChild()) && (!selected.IsInCombat()) && (!selected.IsDoingFavor()) )
;					debug.notification(hasFront + " / " + hasBack + ": " + selected.GetDisplayName())
					; Reserve for scene
					ChairMasterRef.ForceRefTo(master)
					ChairSlaveRef.ForceRefTo(selected)
					SceneChairRub.Start()

					; drop scene markers
					utility.wait(1)
					float zr = master.GetAngleZ()
					float df = 70
					float dr = 50

					ObjectReference fm = None
					ObjectReference bm = None

					if (hasFront)
						; Place marker
						fm = master.PlaceAtMe(FrontMarker, 1)
						utility.wait(0.1)
						fm.SetMotionType(4)
						fm.MoveTo(master, df*math.sin(zr), df*math.cos(zr), 0, true)
						fm.SetAngle(master.GetAngleX(), master.GetAngleY(), master.GetAngleZ() + 180)

						; Perform LOS checks
						Actor a = fm.PlaceActorAtMe(LOSCheckActor)
						a.SetMotionType(4)
						a.SetAlpha(0)
						a.moveto(a, 0, 0, 15)
						utility.wait(0.1)
						a.EnableAI(false)
						a.SetMotionType(4)
						utility.wait(0.3)
						bool fLos = master.HasLOS(a)
						a.delete()
				
						if (!fLos)
							fm.Delete()
							fm = None
						endif
					endif

					if (hasBack)
						bm = master.PlaceAtMe(BackMarker, 1)
						utility.wait(0.1)
						bm.SetMotionType(4)
						bm.MoveTo(master, -dr*math.sin(zr), -dr*math.cos(zr), 0, true)
	
						; Perform LOS checks
						Actor a = bm.PlaceActorAtMe(LOSCheckActor)
						a.SetMotionType(4)
						a.SetAlpha(0)
						a.moveto(a, 0, 0, 15)
						utility.wait(0.1)
						a.EnableAI(false)
						a.SetMotionType(4)
						utility.wait(0.3)
						bool bLos = master.HasLOS(a)
						a.delete()
				
						if (!bLos)
							bm.Delete()
							bm = None
						endif
					endif

					; Remember animated slave
					StorageUtil.FormListAdd(None, "PHHSHChairScene", selected, false)

;					debug.notification((fm != None) + " - " + (bm != None))
			
					; Set markers and advance scene
					if (fm != None)
						ChairMarkerFRef.ForceRefTo(fm)
					endif

					if (bm != None)
						ChairMarkerBRef.ForceRefTo(bm)
					endif

				endif
			endif
		endif
	endif
EndFunction

Function ChairMarkerHit(ObjectReference marker, Actor a)
	float d = a.GetDistance(marker)
	if (d < 30)
		a.SetDontMove(true)
		a.SetRestrained(true)
		a.SetFactionRank(PHHSH.InSceneFaction, 1)
		utility.wait(0.7)
		a.MoveTo(marker, 0, 0, 0, true)

		bool atFront = (marker == ChairMarkerFRef.GetRef())
		if (atFront)
			debug.sendanimationevent(a, "HSHFootRub_Enter")
		else
			debug.sendanimationevent(a, "HSHShoulderRub_Enter")
		endif
		StorageUtil.SetFormValue(ChairMasterRef.GetRef(), "PHHSHChairScene", a)
	
		utility.wait(3)
		a.MoveTo(marker, 0, 0, 0, true)

	endif
	EndSitScene()
EndFunction


Function Say(Actor a, int topicIndex)
	speechIndex = topicIndex
	SpeechActor.ForceRefTo(a)
	a.EvaluatePackage()
	utility.wait(3)
	SpeechActor.Clear()
EndFunction

Function SaySlave(Actor a, int topicIndex)
	speechIndexSlave = topicIndex
	SpeechSlave.ForceRefTo(a)
	a.EvaluatePackage()
	utility.wait(3)
	SpeechSlave.Clear()
EndFunction

Function SayTM(Actor a, int topicIndex)
	speechIndexTM = topicIndex
	SpeechTM.ForceRefTo(a)
	a.EvaluatePackage()
	utility.wait(3)
	SpeechTM.Clear()
EndFunction

Function Exclaim(Actor a)
	if !a.Is3DLoaded()
		return
	endif
	SpeechExclaim.ForceRefTo(a)
	a.EvaluatePackage()
	utility.wait(3.0)
	SpeechExclaim.Clear()
EndFunction

Function HandleZoning()
	Actor slave = FollowerSlaveRef.GetActorRef()
	SceneFollowerSex.Stop()
	FollowerRef.Clear()
	FollowerSlaveRef.Clear()
	EndSitScene()
	ClearSitAnims()
	PHHSHInter.FollowPlayer(slave)
EndFunction

phhshStorageFunctions Property PHHSH Auto
ReferenceAlias Property FollowerRef Auto
ReferenceAlias Property FollowerStruggleRef Auto
ReferenceAlias Property FollowerSlaveRef Auto
ReferenceAlias Property FollowerBedRef Auto
ReferenceAlias Property ChairMasterRef Auto
ReferenceAlias Property ChairSlaveRef Auto
ReferenceAlias Property ChairMarkerFRef Auto
ReferenceAlias Property ChairMarkerBRef Auto

ReferenceAlias Property SpeechActor Auto
ReferenceAlias Property SpeechSlave Auto
ReferenceAlias Property SpeechTM Auto
ReferenceAlias Property SpeechExclaim Auto

ReferenceAlias Property Taskmaster Auto
ReferenceAlias Property TaskmasterReleaseTarget Auto

Scene Property SceneFollowerSex Auto
Scene Property SceneChairRub Auto
Scene Property ReleaseFromDevice Auto
Scene Property SceneFollowerStruggle Auto

Keyword Property DungeonKeyword Auto
Activator Property FrontMarker Auto
Activator Property BackMarker Auto
ActorBase Property LOSCheckActor Auto

bool Property isStool Auto Hidden
int Property speechIndex Auto Hidden Conditional
int Property speechIndexSlave Auto Hidden Conditional
int Property speechIndexTM Auto Hidden Conditional

Faction Property FollowerWIComments Auto


