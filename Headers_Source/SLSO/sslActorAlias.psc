scriptname sslActorAlias extends ReferenceAlias

; Framework access
sslSystemConfig Config
sslActorLibrary ActorLib
sslActorStats Stats
Actor PlayerRef

; Actor Info
Actor property ActorRef auto hidden
ActorBase BaseRef
string ActorName
string RaceEditorID
String ActorRaceKey
int BaseSex
int Gender
bool isRealFemale
bool IsMale
bool IsFemale
bool IsCreature
bool IsFuta
bool IsVictim
bool IsAggressor
bool IsPlayer
bool IsTracked
bool IsSkilled
Faction AnimatingFaction

; Current Thread state
sslThreadController Thread
int Position
bool LeadIn

float StartWait
string StartAnimEvent
string EndAnimEvent
string ActorKey
bool NoOrgasm

; Voice
sslBaseVoice Voice
VoiceType ActorVoice
float BaseDelay
float VoiceDelay
float ExpressionDelay
bool IsForcedSilent
bool UseLipSync

; Expression
sslBaseExpression Expression
sslBaseExpression[] Expressions

; Positioning
ObjectReference MarkerRef
float[] Offsets
float[] Center
float[] Loc

; Storage
int[] Flags
Form[] Equipment
bool[] StripOverride
float[] Skills
float[] OwnSkills

bool UseScale
float StartedAt
float ActorScale
float AnimScale
float NioScale
float LastOrgasm
int BestRelation
int BaseEnjoyment
int QuitEnjoyment
int FullEnjoyment
int Orgasms
int NthTranslation

Form Strapon
Form HadStrapon

Sound OrgasmFX

Spell HDTHeelSpell
Form HadBoots

; Animation Position/Stage flags
bool property ForceOpenMouth auto hidden

; ------------------------------------------------------- ;
; --- Load/Clear Alias For Use						  --- ;
; ------------------------------------------------------- ;

bool function SetActor(Actor ProspectRef)
endFunction

function ClearAlias()
endFunction

; Thread/alias shares
bool DebugMode
bool SeparateOrgasms
int[] BedStatus
float[] RealTime
float[] SkillBonus
string AdjustKey
bool[] IsType

int Stage
int StageCount
string[] AnimEvents
sslBaseAnimation Animation

function LoadShares()
endFunction

; ------------------------------------------------------- ;
; --- Actor Prepartion								  --- ;
; ------------------------------------------------------- ;


state Ready
	event OnUpdate()
	endEvent

	bool function SetActor(Actor ProspectRef)
	endFunction

	function PrepareActor()
	endFunction

	function PathToCenter()
	endFunction

endState

bool Prepared ; TODO: Find better Solution
bool StartedUp ; TODO: Find better Solution
state Prepare
	event OnUpdate()
	endEvent

	function StartAnimating()
	endFunction
	
	event ResetActor()
	endEvent
endState

; ------------------------------------------------------- ;
; --- Animation Loop								  --- ;
; ------------------------------------------------------- ;


function SendAnimation()
endFunction

function GetPositionInfo()
endFunction

string PlayingSA
string CurrentSA
string PlayingAE
string CurrentAE
float LoopDelay
float LoopExpressionDelay
state Animating

	function SendAnimation()
	endFunction

	event OnUpdate()
	endEvent

	function SyncThread()
		; Sync with thread info
		GetPositionInfo()
		VoiceDelay = BaseDelay
		ExpressionDelay = Config.ExpressionDelay * BaseDelay
		if !IsSilent && Stage > 1
			VoiceDelay -= (Stage * 0.8) + Utility.RandomFloat(-0.2, 0.4)
		endIf
		if VoiceDelay < 0.8
			VoiceDelay = Utility.RandomFloat(0.8, 1.4) ; Can't have delay shorter than animation update loop
		endIf
		; Update alias info
	;	GetEnjoyment()
		; Sync status
		if !IsCreature
			ResolveStrapon()
			RefreshExpression()
		endIf
		Debug.SendAnimationEvent(ActorRef, "SOSBend"+Schlong)
		; SyncLocation(false)
	endFunction

	function SyncActor()
		SyncThread()
		SyncLocation(false)
		Thread.SyncEventDone(kSyncActor)
	endFunction

	function SyncAll(bool Force = false)
		SyncThread()
		SyncLocation(Force)
	endFunction

	function RefreshActor()
		UnregisterForUpdate()
		SyncThread()
		StopAnimating(true)
		SyncLocation(false)
		CurrentSA = "SexLabSequenceExit1"
		CurrentAE = PlayingSA
		Debug.SendAnimationEvent(ActorRef, CurrentAE)
		SendDefaultAnimEvent()
		Utility.WaitMenuMode(0.2)
		CurrentSA = Animation.Registry
		CurrentAE = Animation.FetchPositionStage(Position, 1)
		Debug.SendAnimationEvent(ActorRef, CurrentAE)
		PlayingSA = CurrentSA
		PlayingAE = CurrentAE
		SyncLocation(true)
		SendAnimation()
		RegisterForSingleUpdate(1.0)
		Thread.SyncEventDone(kRefreshActor)
	endFunction

	function RefreshLoc()
		Offsets = Animation.PositionOffsets(Offsets, AdjustKey, Position, Stage, BedStatus[1])
		SyncLocation(true)
	endFunction

	function SyncLocation(bool Force = false)
		OffsetCoords(Loc, Center, Offsets)
		MarkerRef.SetPosition(Loc[0], Loc[1], Loc[2])
		MarkerRef.SetAngle(Loc[3], Loc[4], Loc[5])
		; Avoid forcibly setting on player coords if avoidable - causes annoying graphical flickering
		if Force && IsPlayer && IsInPosition(ActorRef, MarkerRef, 40.0)
			AttachMarker()
			ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0)
			return ; OnTranslationComplete() will take over when in place
		elseIf Force
			ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
			ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
		endIf
		AttachMarker()
		Snap()
	endFunction

	function Snap()
		if !(ActorRef && ActorRef.Is3DLoaded())
			return
		endIf
		; Quickly move into place and angle if actor is off by a lot
		float distance = ActorRef.GetDistance(MarkerRef)
		if distance > 125.0 || !IsInPosition(ActorRef, MarkerRef, 75.0)
			ActorRef.SetPosition(Loc[0], Loc[1], Loc[2])
			ActorRef.SetAngle(Loc[3], Loc[4], Loc[5])
			AttachMarker()
		elseIf distance > 2.0
			ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5], 50000, 0.0)
			return ; OnTranslationComplete() will take over when in place
		endIf
		; Begin very slowly rotating a small amount to hold position
		ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5]+0.01, 500.0, 0.0001)
	endFunction

	event OnTranslationComplete()
		; Log("OnTranslationComplete")
		Snap()
	endEvent

	;/ event OnTranslationFailed()
		Log("OnTranslationFailed")
		; SyncLocation(false)
	endEvent /;

	function OrgasmEffect()
		DoOrgasm()
	endFunction

	function DoOrgasm(bool Forced = false)
		if !ActorRef
			return
		endIf
		;Log("OrgasmEffect Triggered")
		int Enjoyment = GetFullEnjoyment()
		if !Forced && (NoOrgasm || Thread.DisableOrgasms)
			; Orgasm Disabled for actor or whole thread
			return 
		elseIf !Forced && Enjoyment < 1
			; Actor have the orgasm few seconds ago or is in pain and can't orgasm
			return
		elseIf Math.Abs(RealTime[0] - LastOrgasm) < 5.0
			Log("Excessive OrgasmEffect Triggered")
			return
		elseIf Forced != true && SeparateOrgasms
			;SLSO conditions to prevent orgasm
			if SLSO_DoOrgasm_Conditions(Forced) < 0
				return
			endIf
		endIf

		
		int i
		;/ SLSO: this probably breaks orgasms in some animations
		; Check if the animation allow Orgasm. By default all the animations with a CumID>0 are type SEX and allow orgasm 
		; But the Lesbian Animations usually don't have CumId assigned and still the orgasm should be allowed at least for Females.
		bool CanOrgasm = Forced || ((IsFemale || IsFuta) && (Animation.HasTag("Lesbian") || Animation.Females == Animation.PositionCount))
		i = Thread.ActorCount
		while !CanOrgasm && i > 0
			i -= 1
			CanOrgasm = Animation.GetCumID(i, Stage) > 0 || Animation.GetCum(i) > 0
		endWhile
		if !CanOrgasm
			Log(ActorName + " Orgasm Disabled for the animation")
			; Orgasm Disabled for the animation
			return
		endIf
		if !Forced && Config.SeparateOrgasms
			;if Enjoyment < 100 && (Stage < StageCount || Orgasms > 0)
			;	; Prevent the orgasm with low enjoyment at least the last stage be reached without orgasms
			;	return
			;endIf
			bool IsCumSource = False
			i = Thread.ActorCount
			while !IsCumSource && i > 0
				i -= 1
				IsCumSource = Animation.GetCumSource(i, Stage) == Position
			endWhile
			if !IsCumSource
				if IsFuta && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Handjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Boobjob") || Animation.HasTag("Footjob") || Animation.HasTag("Penis"))
					return
				elseIf IsMale && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Handjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Boobjob") || Animation.HasTag("Footjob") || Animation.HasTag("Penis"))
					return
				elseIf IsFemale && !(Animation.HasTag("Anal") || Animation.HasTag("Vaginal") || Animation.HasTag("Pussy") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Breast"))
					return
				endIf
			endIf
		endIf
		/;
		
		UnregisterForUpdate()
		LastOrgasm = RealTime[0]
		Orgasms	  += 1
		
		; reset timers
		SLSO_DoOrgasm_Multiorgasm()
		
		; Send an orgasm event hook with actor and orgasm count
		int eid = ModEvent.Create("SexLabOrgasm")
		ModEvent.PushForm(eid, ActorRef)
		ModEvent.PushInt(eid, FullEnjoyment)
		ModEvent.PushInt(eid, Orgasms)
		ModEvent.Send(eid)
		
		; Send an slso separate orgasm event hook with actor and thread id
		SLSO_DoOrgasm_SexLabOrgasmSeparate()

		TrackedEvent("Orgasm")
		Log(ActorName + ": Orgasms["+Orgasms+"] Enjoyment ["+Enjoyment+"] BaseEnjoyment["+BaseEnjoyment+"] FullEnjoyment["+FullEnjoyment+"]")
		if Config.OrgasmEffects
			; Shake camera for player
			if IsPlayer && Config.ShakeStrength > 0 && Game.GetCameraState() >= 8
				Game.ShakeCamera(none, Config.ShakeStrength, Config.ShakeStrength + 1.0)
			endIf
			SLSO_DoOrgasm_Moan()
		endIf
		; Apply cum to female positions from male position orgasm
		i = Thread.ActorCount
		if i > 1 && Config.UseCum && (MalePosition || IsCreature) && (IsMale || IsFuta || IsCreature || (Config.AllowFFCum && IsFemale))
			if i == 2
				Thread.PositionAlias(IntIfElse(Position == 1, 0, 1)).ApplyCum()
			else
				while i > 0
					i -= 1
					if Position != i && Position < Animation.PositionCount && Animation.IsCumSource(Position, i, Stage)
						Thread.PositionAlias(i).ApplyCum()
					endIf
				endWhile
			endIf
		endIf
		Utility.WaitMenuMode(0.2)
		; Reset enjoyment build up, if using multiple orgasms
		QuitEnjoyment = FullEnjoyment
		; VoiceDelay = 0.8
		RegisterForSingleUpdate(0.8)
	endFunction

	event ResetActor()
		ClearEvents()
		GoToState("Resetting")
		Log("Resetting!")
		; Clear TFC
		if IsPlayer
			Thread.ApplyFade()
			MiscUtil.SetFreeCameraState(false)
		endIf
		; Update stats
		if IsSkilled
			Actor VictimRef = Thread.VictimRef
			if IsVictim
				VictimRef = ActorRef
			endIf
			sslActorStats.RecordThread(ActorRef, Gender, BestRelation, StartedAt, RealTime[0], Utility.GetCurrentGameTime(), Thread.HasPlayer, VictimRef, Thread.Genders, Thread.SkillXP)
			Stats.AddPartners(ActorRef, Thread.Positions, Thread.Victims)
			if IsType[6]
				Stats.AdjustSkill(ActorRef, "VaginalCount", 1)
			endIf
			if IsType[7]
				Stats.AdjustSkill(ActorRef, "AnalCount", 1)
			endIf
			if IsType[8]
				Stats.AdjustSkill(ActorRef, "OralCount", 1)
			endIf
		endIf
		; Apply cum
		;/ int CumID = Animation.GetCum(Position)
		if CumID > 0 && !Thread.FastEnd && Config.UseCum && (Thread.Males > 0 || Config.AllowFFCum || Thread.HasCreature)
			ActorLib.ApplyCum(ActorRef, CumID)
		endIf /;
		; Make sure of play the last animation stage to prevet AnimObject issues
		CurrentAE = Animation.FetchPositionStage(Position, StageCount)
		if PlayingAE != CurrentAE
			Debug.SendAnimationEvent(ActorRef, CurrentAE)
		;	Utility.WaitMenuMode(0.2)
			PlayingAE = CurrentAE
		endIf
		StopAnimating(Thread.FastEnd, EndAnimEvent)
		UnlockActor()
		RestoreActorDefaults()
		; Tracked events
		TrackedEvent("End")
		; Unstrip items in storage, if any
		if !IsCreature && !ActorRef.IsDead()
			Unstrip()
			; Add back high heel effects
			if Config.RemoveHeelEffect
				; HDT High Heel
				if HDTHeelSpell && ActorRef.GetWornForm(0x00000080) && !ActorRef.HasSpell(HDTHeelSpell)
					ActorRef.AddSpell(HDTHeelSpell)
				endIf
				; NiOverride High Heels move out to prevent isues and add NiOverride Scale for race menu compatibility
			endIf
			if Config.HasNiOverride
				bool UpdateNiOPosition = NiOverride.RemoveNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "SexLab.esm")
				bool UpdateNiOScale = NiOverride.RemoveNodeTransformScale(ActorRef, false, isRealFemale, "NPC", "SexLab.esm")
				if UpdateNiOPosition || UpdateNiOScale ; I make the variables because not sure if execute both funtion in OR condition.
					NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
				endIf
			endIf
		endIf
		; Free alias slot
		TryToClear()
		GoToState("")
		Thread.SyncEventDone(kResetActor)
	endEvent
endState

state Resetting
	function ClearAlias()
	endFunction
	event OnUpdate()
	endEvent
	function Initialize()
	endFunction
endState

function SyncAll(bool Force = false)
endFunction

; ------------------------------------------------------- ;
; --- Actor Manipulation							  --- ;
; ------------------------------------------------------- ;

function StopAnimating(bool Quick = false, string ResetAnim = "IdleForceDefaultState")
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "StopAnimating("+Quick+")")
		return
	endIf
	; Disable free camera, if in it
	; if IsPlayer
	;	MiscUtil.SetFreeCameraState(false)
	; endIf
	; Clear possibly troublesome effects
	ActorRef.StopTranslation()
	bool Resetting = GetState() == "Resetting" || !Quick
	if Resetting
		int StageOffset = Stage
		if StageOffset > StageCount
			StageOffset = StageCount
		endIf
		if AdjustKey && AdjustKey != ""
			Offsets	   = Animation.PositionOffsets(Offsets, AdjustKey, Position, StageOffset, BedStatus[1])
		endIf
		float OffsetZ = 10.0
		if Offsets[2] < 1.0 ; Fix for animation default missaligned 
			Offsets[2] = OffsetZ ; hopefully prevents some users underground/teleport to giant camp problem?
		endIf
		OffsetCoords(Loc, Center, Offsets)
		float PositionX = ActorRef.GetPositionX()
		float PositionY = ActorRef.GetPositionY()
		float AngleZ = ActorRef.GetAngleZ()
		float Rotate = AngleZ
		String Node = "NPC Root [Root]"
		if !IsCreature
			Node = "MagicEffectsNode"
		endIf
		if NetImmerse.HasNode(ActorRef, Node, False)
			PositionX = NetImmerse.GetNodeWorldPositionX(ActorRef, Node, False)
			PositionY = NetImmerse.GetNodeWorldPositionY(ActorRef, Node, False)
			float[] Rotation = new float[3]
			if NetImmerse.GetNodeLocalRotationEuler(ActorRef, Node, Rotation, False)
				Rotate = AngleZ + Rotation[2]
				if Rotate >= 360.0
					Rotate = Rotate - 360.0
				elseIf Rotate < 0.0
					Rotate = Rotate + 360.0
				endIf
				Log(Node +" Rotation:"+Rotation+" AngleZ:"+AngleZ+" Rotate:"+Rotate)
			endIf
		endIf
		ActorRef.SetVehicle(none)
		if AngleZ != Rotate
			ActorRef.SetAngle(Loc[3], Loc[4], Rotate)
		endIf
		ActorRef.SetPosition(PositionX, PositionY, Loc[2])
	;	Utility.WaitMenuMode(0.1)
	else
		ActorRef.SetVehicle(none)
	endIf
	; Stop animevent
	if IsCreature
		; Reset creature idle
		SendDefaultAnimEvent(Resetting)
		Utility.Wait(0.1)
		if ResetAnim != "IdleForceDefaultState" && ResetAnim != "" && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
			ActorRef.PushActorAway(ActorRef, 0.001)
		elseIf !Quick && ResetAnim == "IdleForceDefaultState" && DoRagdoll && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
			if ActorRef.IsDead() || ActorRef.IsUnconscious()
				Debug.SendAnimationEvent(ActorRef, "DeathAnimation")
			elseIf ActorRef.GetActorValuePercentage("Health") < 0.1
				ActorRef.KillSilent()
			elseIf (ActorRaceKey == "Spiders" || ActorRaceKey == "LargeSpiders" || ActorRaceKey == "GiantSpiders")
				ActorRef.PushActorAway(ActorRef, 0.001) ; Temporal Fix TODO:
			endIf
		endIf
	else
		; Reset NPC/PC Idle Quickly
		if ResetAnim != "IdleForceDefaultState" && ResetAnim != ""
			Debug.SendAnimationEvent(ActorRef, ResetAnim)
			Utility.Wait(0.1)
			; Ragdoll NPC/PC if enabled and not in TFC
			if !Quick && DoRagdoll && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
				ActorRef.PushActorAway(ActorRef, 0.001)
			endIf
		elseIf Quick
			Debug.SendAnimationEvent(ActorRef, ResetAnim)
		elseIf !Quick && ResetAnim == "IdleForceDefaultState" && DoRagdoll && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3))
			;TODO: Detect the real actor position based on Node property intead of the Animation Tags
			if ActorRef.IsDead() || ActorRef.IsUnconscious()
				Debug.SendAnimationEvent(ActorRef, ResetAnim)
				Utility.Wait(0.1)
				Debug.SendAnimationEvent(ActorRef, "IdleSoupDeath")
			elseIf ActorRef.GetActorValuePercentage("Health") < 0.1
				ActorRef.KillSilent()
			elseIf Animation && (Animation.HasTag("Furniture") || (Animation.HasTag("Standing") && !IsType[0]))
				Debug.SendAnimationEvent(ActorRef, ResetAnim)
			elseIf IsType[0] && IsVictim && Animation && Animation.HasTag("Rape") && !Animation.HasTag("Standing") && (!IsPlayer || (IsPlayer && Game.GetCameraState() != 3)) \
			&& (Animation.HasTag("DoggyStyle") || Animation.HasTag("Missionary") || Animation.HasTag("Laying"))
				ActorRef.PushActorAway(ActorRef, 0.001)
			else
				Debug.SendAnimationEvent(ActorRef, ResetAnim)
			endIf
		else
			Debug.SendAnimationEvent(ActorRef, ResetAnim)
		endIf
	endIf
;	Log(ActorName +"- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "StopAnimating("+Quick+")")
	PlayingSA = "SexLabSequenceExit1"
	PlayingAE = "SexLabSequenceExit1"
endFunction

function SendDefaultAnimEvent(bool Exit = False)
	Debug.SendAnimationEvent(ActorRef, "AnimObjectUnequip")
	if !IsCreature
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
		Utility.Wait(0.1)
	elseIf ActorRaceKey != ""
		if ActorRaceKey == "Dragons"
			Debug.SendAnimationEvent(ActorRef, "FlyStopDefault") ; for Dragons only
			Utility.Wait(0.1)
			Debug.SendAnimationEvent(ActorRef, "Reset") ; for Dragons only
		elseIf ActorRaceKey == "Hagravens"
			Debug.SendAnimationEvent(ActorRef, "ReturnToDefault") ; for Dragons only
			Utility.Wait(0.1)
			if Exit
				Debug.SendAnimationEvent(ActorRef, "Reset") ; for Dragons only
			endIf
		elseIf ActorRaceKey == "Chaurus" || ActorRaceKey == "ChaurusReapers"
			Debug.SendAnimationEvent(ActorRef, "FNISDefault") ; for dwarvenspider and chaurus without time bettwen.
			Utility.Wait(0.1)
			if Exit
		;		Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
			endIf
		elseIf ActorRaceKey == "DwarvenSpiders"
			Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
			Utility.Wait(0.1)
			if Exit
		;		Debug.SendAnimationEvent(ActorRef, "FNISDefault") ; for dwarvenspider and chaurus
			endIf
		elseIf ActorRaceKey == "Draugrs" || ActorRaceKey == "Seekers" || ActorRaceKey == "DwarvenBallistas" || ActorRaceKey == "DwarvenSpheres" || ActorRaceKey == "DwarvenCenturions"
			Debug.SendAnimationEvent(ActorRef, "ForceFurnExit") ; for draugr, trolls daedras and all dwarven exept spiders
		elseIf ActorRaceKey == "Trolls"
			Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
			Utility.Wait(0.1)
			if Exit
				Debug.SendAnimationEvent(ActorRef, "ForceFurnExit") ; the troll need this afther "ReturnToDefault" to allow the attack idles
			endIf
		elseIf ActorRaceKey == "Chickens" || ActorRaceKey == "Rabbits" || ActorRaceKey == "Slaughterfishes"
			Debug.SendAnimationEvent(ActorRef, "ReturnDefaultState") ; for chicken, hare and slaughterfish
			Utility.Wait(0.1)
			if Exit
				Debug.SendAnimationEvent(ActorRef, "ReturnToDefault")
			endIf
		elseIf ActorRaceKey == "Werewolves" || ActorRaceKey == "VampireLords"
			Debug.SendAnimationEvent(ActorRef, "IdleReturnToDefault") ; for Werewolves and VampirwLords
			Utility.Wait(0.1)
		else
			Debug.SendAnimationEvent(ActorRef, "ReturnToDefault") ; the rest creature-animal
			Utility.Wait(0.1)
		endIf
	elseIf Exit
		Debug.SendAnimationEvent(ActorRef, "ReturnDefaultState") ; for chicken, hare and slaughterfish before the "ReturnToDefault"
		Debug.SendAnimationEvent(ActorRef, "ReturnToDefault") ; the rest creature-animal
		Debug.SendAnimationEvent(ActorRef, "FNISDefault") ; for dwarvenspider and chaurus
		Debug.SendAnimationEvent(ActorRef, "IdleReturnToDefault") ; for Werewolves and VampirwLords
		Debug.SendAnimationEvent(ActorRef, "ForceFurnExit") ; for Trolls afther the "ReturnToDefault" and draugr, daedras and all dwarven exept spiders
		Debug.SendAnimationEvent(ActorRef, "Reset") ; for Hagravens afther the "ReturnToDefault" and Dragons
		Utility.Wait(0.1)
	endIf
	Utility.Wait(0.2)
endFunction

function AttachMarker()
	ActorRef.SetVehicle(MarkerRef)
	if UseScale && AnimScale > 0.1 && AnimScale != 1.0
		ActorRef.SetScale(AnimScale)
	endIf
endFunction

function LockActor()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "LockActor()")
		return
	endIf
	; Move if actor out of cell
	ObjectReference CenterRef = Thread.CenterAlias.GetReference()
	if CenterRef && CenterRef != none && CenterRef != ActorRef as ObjectReference && ActorRef.GetDistance(CenterRef) > 3000
		ActorRef.MoveTo(CenterRef)
	endIf
	; Remove any unwanted combat effects
	ClearEffects()
	; Stop whatever they are doing
	; SendDefaultAnimEvent()
	; Start DoNothing package
	ActorUtil.AddPackageOverride(ActorRef, Config.DoNothing, 100, 1)
	ActorRef.SetFactionRank(AnimatingFaction, 1)
	ActorRef.EvaluatePackage()
	; Disable movement
	ActorRef.StopTranslation()
	if IsPlayer
		if Game.GetCameraState() == 0
			Game.ForceThirdPerson()
		endIf
		; abMovement = true, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = false, abMenu = true, abActivate = true, abJournalTabs = false, aiDisablePOVType = 0
		;Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0) 		;SLSO: sexlab disables ui, we dont want that
		Game.SetPlayerAIDriven()
		; Enable hotkeys if needed, and disable autoadvance if not needed
		if IsVictim && Config.DisablePlayer
			Thread.AutoAdvance = true
		else
			Thread.AutoAdvance = Config.AutoAdvance
			Thread.EnableHotkeys()
		endIf
	else
		ActorRef.SetRestrained(true)
		ActorRef.SetDontMove(true)
	endIf
	; Attach positioning marker
	if !MarkerRef
		MarkerRef = ActorRef.PlaceAtMe(Config.BaseMarker)
		int cycle
		while !MarkerRef.Is3DLoaded() && cycle < 50
			Utility.Wait(0.1)
			cycle += 1
		endWhile
		if cycle
			Log("Waited ["+cycle+"] cycles for MarkerRef["+MarkerRef+"]")
		endIf
	endIf
	MarkerRef.Enable()
	ActorRef.StopTranslation()
	MarkerRef.MoveTo(ActorRef)
	AttachMarker()
endFunction

function UnlockActor()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "UnlockActor()")
		return
	endIf
	; Detach positioning marker
	ActorRef.StopTranslation()
	ActorRef.SetVehicle(none)
	; Remove from animation faction
	ActorRef.RemoveFromFaction(AnimatingFaction)
	ActorUtil.RemovePackageOverride(ActorRef, Config.DoNothing)
	ActorRef.SetFactionRank(AnimatingFaction, 0)
	ActorRef.EvaluatePackage()
	; Enable movement
	if IsPlayer
		Thread.RemoveFade()
		Thread.DisableHotkeys()
		MiscUtil.SetFreeCameraState(false)
		Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
		Game.SetPlayerAIDriven(false)
	else
		ActorRef.SetRestrained(false)
		ActorRef.SetDontMove(false)
	endIf
;	Log(ActorName +"- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "UnlockActor()")
endFunction

function RestoreActorDefaults()
	; Make sure	 have actor, can't afford to miss this block
	if !ActorRef
		ActorRef = GetReference() as Actor
		if !ActorRef
			Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "RestoreActorDefaults()")
			return ; No actor, reset prematurely or bad call to alias
		endIf
	endIf	
	; Reset to starting scale
	if UseScale && ActorScale > 0.0 && (ActorScale != 1.0 || AnimScale != 1.0)
		ActorRef.SetScale(ActorScale)
	endIf
	if !IsCreature
		; Reset voicetype
		; if ActorVoice && ActorVoice != BaseRef.GetVoiceType()
		;	BaseRef.SetVoiceType(ActorVoice)
		; endIf
		; Remove strapon
		if Strapon && !HadStrapon; && Strapon != HadStrapon
			ActorRef.RemoveItem(Strapon, 1, true)
		endIf
		; Reset expression
		if ActorRef.Is3DLoaded() && !(ActorRef.IsDisabled() || ActorRef.IsDead() || ActorRef.GetActorValue("Health") < 1.0)
			if Expression
				sslBaseExpression.CloseMouth(ActorRef)
			elseIf sslBaseExpression.IsMouthOpen(ActorRef)
				sslBaseExpression.CloseMouth(ActorRef)			
			endIf
			ActorRef.ClearExpressionOverride()
			ActorRef.ResetExpressionOverrides()
			sslBaseExpression.ClearMFG(ActorRef)
		endIf
	endIf
	; Player specific actions
	if IsPlayer
		; Remove player from frostfall exposure exception
		FormList FrostExceptions = Config.FrostExceptions
		if FrostExceptions
			FrostExceptions.RemoveAddedForm(Config.BaseMarker)
		endIf
		Thread.RemoveFade()
	endIf
	; Remove SOS erection
	Debug.SendAnimationEvent(ActorRef, "SOSFlaccid")
	; Clear from animating faction
	ActorRef.SetFactionRank(AnimatingFaction, -1)
	ActorRef.RemoveFromFaction(AnimatingFaction)
	ActorUtil.RemovePackageOverride(ActorRef, Config.DoNothing)
	ActorRef.EvaluatePackage()
;	Log(ActorName +"- Angle:[X:"+ActorRef.GetAngleX()+"Y:"+ActorRef.GetAngleY()+"Z:"+ActorRef.GetAngleZ()+"] Position:[X:"+ActorRef.GetPositionX()+"Y:"+ActorRef.GetPositionY()+"Z:"+ActorRef.GetPositionZ()+"]", "RestoreActorDefaults()")
endFunction

function RefreshActor()
endFunction

; ------------------------------------------------------- ;
; --- Data Accessors								  --- ;
; ------------------------------------------------------- ;

int function GetGender()
	return Gender
endFunction

function SetVictim(bool Victimize)
	Actor[] Victims = Thread.Victims
	; Make victim
	if Victimize && (!Victims || Victims.Find(ActorRef) == -1)
		Victims = PapyrusUtil.PushActor(Victims, ActorRef)
		Thread.Victims = Victims
		Thread.IsAggressive = true
	; Was victim but now isn't, update thread
	elseIf IsVictim && !Victimize
		Victims = PapyrusUtil.RemoveActor(Victims, ActorRef)
		Thread.Victims = Victims
		if !Victims || Victims.Length < 1
			Thread.IsAggressive = false
		endIf
	endIf
	IsVictim = Victimize
endFunction

string function GetActorKey()
	return ActorKey
endFunction

function SetAdjustKey(string KeyVar)
	if ActorRef
		AdjustKey = KeyVar
		Position  = Thread.Positions.Find(ActorRef)
	endIf
endfunction

function AdjustEnjoyment(int AdjustBy)
	BaseEnjoyment += AdjustBy
endfunction

int function GetEnjoyment()
	return SLSO_GetEnjoyment()
;	Log(ActorName +"- RealTime:["+Utility.GetCurrentRealTime()+"], GameTime:["+SexLabUtil.GetCurrentGameRealTime()+"] IsMenuMode:"+Utility.IsInMenuMode(), "GetEnjoyment()")
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "GetEnjoyment()")
		FullEnjoyment = 0
		return 0
	elseif !IsSkilled
		FullEnjoyment = BaseEnjoyment + (PapyrusUtil.ClampFloat(((RealTime[0] - StartedAt) + 1.0) / 5.0, 0.0, 40.0) + ((Stage as float / StageCount as float) * 60.0)) as int
	else
		if Position == 0
			Thread.RecordSkills()
			Thread.SetBonuses()
		endIf
		FullEnjoyment = BaseEnjoyment + CalcEnjoyment(SkillBonus, Skills, LeadIn, IsFemale, (RealTime[0] - StartedAt), Stage, StageCount)
		; Log("FullEnjoyment["+FullEnjoyment+"] / BaseEnjoyment["+BaseEnjoyment+"] / Enjoyment["+(FullEnjoyment - BaseEnjoyment)+"]")
	endIf

	int Enjoyment = FullEnjoyment - QuitEnjoyment
	if Enjoyment > 0
		return Enjoyment
	endIf
	return 0
endFunction

int function GetPain()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "GetPain()")
		return 0
	endIf
	return PapyrusUtil.ClampInt(Math.Abs(GetFullEnjoyment()) as int, 0, 100)

endFunction

int function CalcReaction()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "CalcReaction()")
		return 0
	endIf
	return PapyrusUtil.ClampInt(Math.Abs(GetFullEnjoyment()) as int, 0, 100)
endFunction

function ApplyCum()
	if ActorRef && ActorRef.Is3DLoaded()
		Cell ParentCell = ActorRef.GetParentCell()
		int CumID = Animation.GetCumID(Position, Stage)
		if CumID > 0 && ParentCell && ParentCell.IsAttached() ; Error treatment for Spells out of Cell
			ActorLib.ApplyCum(ActorRef, CumID)
		endIf
	endIf
endFunction

function DisableOrgasm(bool bNoOrgasm)
	if ActorRef
		NoOrgasm = bNoOrgasm
	endIf
endFunction

bool function IsOrgasmAllowed()
	return !NoOrgasm && !Thread.DisableOrgasms
endFunction

bool function NeedsOrgasm()
	return GetFullEnjoyment() >= 100
endFunction

function SetVoice(sslBaseVoice ToVoice = none, bool ForceSilence = false)
	IsForcedSilent = ForceSilence
	if ToVoice && IsCreature == ToVoice.Creature
		Voice = ToVoice
	endIf
endFunction

sslBaseVoice function GetVoice()
	return Voice
endFunction

function SetExpression(sslBaseExpression ToExpression)
	if ToExpression
		Expression = ToExpression
	endIf
endFunction

sslBaseExpression function GetExpression()
	return Expression
endFunction

function SetStartAnimationEvent(string EventName, float PlayTime)
	StartAnimEvent = EventName
	StartWait = PapyrusUtil.ClampFloat(PlayTime, 0.1, 10.0)
endFunction

function SetEndAnimationEvent(string EventName)
	EndAnimEvent = EventName
endFunction

bool function IsUsingStrapon()
	return Strapon && ActorRef.IsEquipped(Strapon)
endFunction

function ResolveStrapon(bool force = false)
	if Strapon
		if UseStrapon && !ActorRef.IsEquipped(Strapon)
			ActorRef.EquipItem(Strapon, true, true)
		elseIf !UseStrapon && ActorRef.IsEquipped(Strapon)
			ActorRef.UnequipItem(Strapon, true, true)
		endIf
	endIf
endFunction

function EquipStrapon()
	if Strapon && !ActorRef.IsEquipped(Strapon)
		ActorRef.EquipItem(Strapon, true, true)
	endIf
endFunction

function UnequipStrapon()
	if Strapon && ActorRef.IsEquipped(Strapon)
		ActorRef.UnequipItem(Strapon, true, true)
	endIf
endFunction

function SetStrapon(Form ToStrapon)
	if Strapon && !HadStrapon && Strapon != ToStrapon
		ActorRef.RemoveItem(Strapon, 1, true)
	endIf
	Strapon = ToStrapon
	if GetState() == "Animating"
		SyncThread()
	endIf
endFunction

Form function GetStrapon()
	return Strapon
endFunction

bool function PregnancyRisk()
	int cumID = Animation.GetCumID(Position, Stage)
	return cumID > 0 && (cumID == 1 || cumID == 4 || cumID == 5 || cumID == 7) && IsFemale && !MalePosition && Thread.IsVaginal
endFunction

function OverrideStrip(bool[] SetStrip)
	if SetStrip.Length != 33
		Thread.Log("Invalid strip override bool[] - Must be length 33 - was "+SetStrip.Length, "OverrideStrip()")
	else
		StripOverride = SetStrip
	endIf
endFunction

bool function ContinueStrip(Form ItemRef, bool DoStrip = true)
	if !ItemRef
		return False
	endIf
	if StorageUtil.FormListHas(none, "AlwaysStrip", ItemRef) || SexLabUtil.HasKeywordSub(ItemRef, "AlwaysStrip")
		if StorageUtil.GetIntValue(ItemRef, "SometimesStrip", 100) < 100
			if !DoStrip
				return (StorageUtil.GetIntValue(ItemRef, "SometimesStrip", 100) >= Utility.RandomInt(76, 100))
			endIf
			return (StorageUtil.GetIntValue(ItemRef, "SometimesStrip", 100) >= Utility.RandomInt(1, 100))
		endIf
		return True
	endIf
	return (DoStrip && !(StorageUtil.FormListHas(none, "NoStrip", ItemRef) || SexLabUtil.HasKeywordSub(ItemRef, "NoStrip")))
endFunction

function Strip()
	if !ActorRef || IsCreature
		return
	endIf
	; Start stripping animation
	;if DoUndress
	;	Debug.SendAnimationEvent(ActorRef, "Arrok_Undress_G"+BaseSex)
	;	NoUndress = true
	;endIf
	; Select stripping array
	bool[] Strip
	if StripOverride.Length == 33
		Strip = StripOverride
	else
		Strip = Config.GetStrip(IsFemale, Thread.UseLimitedStrip(), IsType[0], IsVictim)
	endIf
	; Log("Strip: "+Strip)
	; Stripped storage
	Form ItemRef
	Form[] Stripped = new Form[34]
	if ActorRef.IsWeaponDrawn() || IsPlayer
		ActorRef.SheatheWeapon()
	endIf
	; Right hand
	ItemRef = ActorRef.GetEquippedObject(1)
	if ContinueStrip(ItemRef, Strip[32])
		Stripped[33] = ItemRef
		ActorRef.UnequipItemEX(ItemRef, 1, false)
		StorageUtil.SetIntValue(ItemRef, "Hand", 1)
	endIf
	; Left hand
	ItemRef = ActorRef.GetEquippedObject(0)
	if ContinueStrip(ItemRef, Strip[32])
		Stripped[32] = ItemRef
		ActorRef.UnequipItemEX(ItemRef, 2, false)
		StorageUtil.SetIntValue(ItemRef, "Hand", 2) 
	endIf
	; Strip armor slots
	Form BodyRef = ActorRef.GetWornForm(Armor.GetMaskForSlot(32))
	int i = 31
	while i >= 0
		; Grab item in slot
		ItemRef = ActorRef.GetWornForm(Armor.GetMaskForSlot(i + 30))
		if ContinueStrip(ItemRef, Strip[i])
			; Start stripping animation
			if DoUndress && ItemRef == BodyRef ;Body
				Debug.SendAnimationEvent(ActorRef, "Arrok_Undress_G"+BaseSex)
				Utility.Wait(1.0)
				NoUndress = true
			endIf
			ActorRef.UnequipItemEX(ItemRef, 0, false)
			Stripped[i] = ItemRef
		endIf
		; Move to next slot
		i -= 1
	endWhile
	; Equip the nudesuit
	if Strip[2] && ((Gender == 0 && Config.UseMaleNudeSuit) || (Gender == 1 && Config.UseFemaleNudeSuit))
		ActorRef.EquipItem(Config.NudeSuit, true, true)
	endIf
	; Store stripped items
	Equipment = PapyrusUtil.MergeFormArray(Equipment, PapyrusUtil.ClearNone(Stripped), true)
	Log("Equipment: "+Equipment)
	; Suppress NiOverride High Heels
	if Config.RemoveHeelEffect && ActorRef.GetWornForm(0x00000080)
		if Config.HasNiOverride
			; Remove NiOverride SexLab High Heels
			bool UpdateNiOPosition = NiOverride.RemoveNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "SexLab.esm")
			; Remove NiOverride High Heels
			if NiOverride.HasNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "internal")
				float[] pos = NiOverride.GetNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "internal")
				Log(pos, "RemoveHeelEffect (NiOverride)")
				pos[0] = -pos[0]
				pos[1] = -pos[1]
				pos[2] = -pos[2]
				NiOverride.AddNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "SexLab.esm", pos)
				NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
			elseIf UpdateNiOPosition
				NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
			endIf
		endIf
	endIf
endFunction

function UnStrip()
	if !ActorRef || IsCreature || Equipment.Length == 0
		return
	endIf
	; Remove nudesuit if present
	int n = ActorRef.GetItemCount(Config.NudeSuit)
	if n > 0
		ActorRef.RemoveItem(Config.NudeSuit, n, true)
	endIf
	; Continue with undress, or am I disabled?
	if !DoRedress
		return ; Fuck clothes, bitch.
	endIf
	; Equip Stripped
	int i = Equipment.Length
	while i
		i -= 1
		if Equipment[i]
			int hand = StorageUtil.GetIntValue(Equipment[i], "Hand", 0)
			if hand != 0
				StorageUtil.UnsetIntValue(Equipment[i], "Hand")
			endIf
			ActorRef.EquipItemEx(Equipment[i], hand, false)
		endIf
	endWhile
endFunction

bool NoRagdoll
bool property DoRagdoll hidden
	bool function get()
		if NoRagdoll
			return false
		endIf
		return !NoRagdoll && Config.RagdollEnd
	endFunction
	function set(bool value)
		NoRagdoll = !value
	endFunction
endProperty

bool NoUndress
bool property DoUndress hidden
	bool function get()
		if NoUndress || GetState() == "Animating"
			return false
		endIf
		return Config.UndressAnimation
	endFunction
	function set(bool value)
		NoUndress = !value
	endFunction
endProperty

bool NoRedress
bool property DoRedress hidden
	bool function get()
		if NoRedress || (IsVictim && !Config.RedressVictim)
			return false
		endIf
		return !IsVictim || (IsVictim && Config.RedressVictim)
	endFunction
	function set(bool value)
		NoRedress = !value
	endFunction
endProperty

int PathingFlag
function ForcePathToCenter(bool forced)
	PathingFlag = (forced as int)
endFunction
function DisablePathToCenter(bool disabling)
	PathingFlag = IntIfElse(disabling, -1, (PathingFlag == 1) as int)
endFunction
bool property DoPathToCenter
	bool function get()
		return (PathingFlag == 0 && Config.DisableTeleport) || PathingFlag == 1
	endFunction
endProperty

float RefreshExpressionDelay
function RefreshExpression()
	if !ActorRef || IsCreature || !ActorRef.Is3DLoaded() || ActorRef.IsDisabled()
		; Do nothing
	elseIf OpenMouth
		sslBaseExpression.OpenMouth(ActorRef)
		Utility.Wait(1.0)
		if Config.RefreshExpressions && Expression && Expression != none && !ActorRef.IsDead() && !ActorRef.IsUnconscious() && ActorRef.GetActorValue("Health") > 1.0
			int Strength = CalcReaction()
			Expression.Apply(ActorRef, Strength, BaseSex)
			Log("Expression.Applied("+Expression.Name+") Strength:"+Strength+"; OpenMouth:"+OpenMouth)
		endIf
	else
		if Expression && Expression != none && !ActorRef.IsDead() && !ActorRef.IsUnconscious() && ActorRef.GetActorValue("Health") > 1.0
			int Strength = CalcReaction()
			sslBaseExpression.CloseMouth(ActorRef)
			Expression.Apply(ActorRef, Strength, BaseSex)
			Log("Expression.Applied("+Expression.Name+") Strength:"+Strength+"; OpenMouth:"+OpenMouth)
		elseIf sslBaseExpression.IsMouthOpen(ActorRef)
			sslBaseExpression.CloseMouth(ActorRef)			
		endIf
	endIf
	RefreshExpressionDelay = 0.0
endFunction

; ------------------------------------------------------- ;
; --- System Use									  --- ;
; ------------------------------------------------------- ;

function TrackedEvent(string EventName)
	if IsTracked
		Thread.SendTrackedEvent(ActorRef, EventName)
	endif
endFunction

function ClearEffects()
	if IsPlayer && GetState() != "Animating"
		; MiscUtil.SetFreeCameraState(false)
		if Game.GetCameraState() == 0
			Game.ForceThirdPerson()
		endIf
	endIf
	if ActorRef.IsInCombat()
		ActorRef.StopCombat()
	endIf
	if ActorRef.IsWeaponDrawn()
		ActorRef.SheatheWeapon()
	endIf
	if ActorRef.IsSneaking()
		ActorRef.StartSneaking()
	endIf
	ActorRef.ClearKeepOffsetFromActor()
endFunction

int property kPrepareActor = 0 autoreadonly hidden
int property kSyncActor	   = 1 autoreadonly hidden
int property kResetActor   = 2 autoreadonly hidden
int property kRefreshActor = 3 autoreadonly hidden
int property kStartup	   = 4 autoreadonly hidden

function RegisterEvents()
	string e = Thread.Key("")
	; Quick Events
	RegisterForModEvent(e+"Animate", "SendAnimation")
	RegisterForModEvent(e+"Orgasm", "OrgasmEffect")
	RegisterForModEvent(e+"Strip", "Strip")
	; Sync Events
	RegisterForModEvent(e+"Prepare", "PrepareActor")
	RegisterForModEvent(e+"Sync", "SyncActor")
	RegisterForModEvent(e+"Reset", "ResetActor")
	RegisterForModEvent(e+"Refresh", "RefreshActor")
	RegisterForModEvent(e+"Startup", "StartAnimating")
endFunction

function ClearEvents()
	UnregisterForUpdate()
	string e = Thread.Key("")
	; Quick Events
	UnregisterForModEvent(e+"Animate")
	UnregisterForModEvent(e+"Orgasm")
	UnregisterForModEvent(e+"Strip")
	; Sync Events
	UnregisterForModEvent(e+"Prepare")
	UnregisterForModEvent(e+"Sync")
	UnregisterForModEvent(e+"Reset")
	UnregisterForModEvent(e+"Refresh")
	UnregisterForModEvent(e+"Startup")
endFunction

function Initialize()
	; Clear actor
	if ActorRef && ActorRef != none
		; Stop events
		ClearEvents()
		; RestoreActorDefaults()
		; Remove nudesuit if present
		int n = ActorRef.GetItemCount(Config.NudeSuit)
		if n > 0
			ActorRef.RemoveItem(Config.NudeSuit, n, true)
		endIf
	endIf
	; Delete positioning marker
	if MarkerRef
		MarkerRef.Disable()
		MarkerRef.Delete()
	endIf
	; Forms
	ActorRef	   = none
	MarkerRef	   = none
	HadStrapon	   = none
	Strapon		   = none
	HDTHeelSpell   = none
	; Voice
	Voice		   = none
	ActorVoice	   = none
	IsForcedSilent = false
	; Expression
	Expression	   = none
	Expressions	   = sslUtility.ExpressionArray(0)
	; Flags
	NoRagdoll	   = false
	NoUndress	   = false
	NoRedress	   = false
	NoOrgasm	   = false
	ForceOpenMouth = false
	Prepared	   = false
	StartedUp	   = false
	; Integers
	Orgasms		   = 0
	BestRelation   = 0
	BaseEnjoyment  = 0
	QuitEnjoyment  = 0
	FullEnjoyment  = 0
	PathingFlag	   = 0
	; Floats
	LastOrgasm	   = 0.0
	ActorScale	   = 1.0
	AnimScale	   = 1.0
	NioScale	   = 1.0
	StartWait	   = 0.1
	; Strings
	EndAnimEvent   = "IdleForceDefaultState"
	StartAnimEvent = ""
	ActorKey	   = ""
	PlayingSA	   = ""
	CurrentSA	   = ""
	PlayingAE	   = ""
	CurrentAE	   = ""
	; Storage
	StripOverride  = Utility.CreateBoolArray(0)
	Equipment	   = Utility.CreateFormArray(0)
	; Make sure alias is emptied
	
	SLSO_Initialize()

	TryToClear()
endFunction

function Setup()
	; Reset function Libraries - SexLabQuestFramework
	if !Config || !ActorLib || !Stats
		Form SexLabQuestFramework = Game.GetFormFromFile(0xD62, "SexLab.esm")
		if SexLabQuestFramework
			Config	 = SexLabQuestFramework as sslSystemConfig
			ActorLib = SexLabQuestFramework as sslActorLibrary
			Stats	 = SexLabQuestFramework as sslActorStats
		endIf
	endIf
	PlayerRef = Game.GetPlayer()
	Thread	  = GetOwningQuest() as sslThreadController
	OrgasmFX  = Config.OrgasmFX
	DebugMode = Config.DebugMode
	AnimatingFaction = Config.AnimatingFaction
endFunction

function Log(string msg, string src = "")
	msg = "ActorAlias["+ActorName+"] "+src+" - "+msg
	Debug.Trace("SEXLAB - " + msg)
	if DebugMode
		SexLabUtil.PrintConsole(msg)
		Debug.TraceUser("SexLabDebug", msg)
	endIf
endFunction

function PlayLouder(Sound SFX, ObjectReference FromRef, float Volume)
	if SFX && FromRef && FromRef.Is3DLoaded() && Volume > 0.0
		if Volume > 0.5
			Sound.SetInstanceVolume(SFX.Play(FromRef), 1.0)
		else
			Sound.SetInstanceVolume(SFX.Play(FromRef), Volume)
		endIf
	endIf
endFunction

; ------------------------------------------------------- ;
; --- State Restricted								  --- ;
; ------------------------------------------------------- ;

; Ready
function PrepareActor()
endFunction
function PathToCenter()
endFunction
; Animating
function StartAnimating()
endFunction
function SyncActor()
endFunction
function SyncThread()
endFunction
function SyncLocation(bool Force = false)
endFunction
function RefreshLoc()
endFunction
function Snap()
endFunction
event OnTranslationComplete()
endEvent
function OrgasmEffect()
endFunction
function DoOrgasm(bool Forced = false)
endFunction
event ResetActor()
endEvent
;/ function RefreshActor()
endFunction /;
event OnOrgasm()
	OrgasmEffect()
endEvent
event OrgasmStage()
	OrgasmEffect()
endEvent

function OffsetCoords(float[] Output, float[] CenterCoords, float[] OffsetBy) global native
bool function IsInPosition(Actor CheckActor, ObjectReference CheckMarker, float maxdistance = 30.0) global native
int function CalcEnjoyment(float[] XP, float[] SkillsAmounts, bool IsLeadin, bool IsFemaleActor, float Timer, int OnStage, int MaxStage) global native

int function IntIfElse(bool check, int isTrue, int isFalse)
	if check
		return isTrue
	endIf
	return isFalse
endfunction

; function AdjustCoords(float[] Output, float[] CenterCoords, ) global native
; function AdjustOffset(int i, float amount, bool backwards, bool adjustStage)
;	Animation.
; endFunction

; function OffsetBed(float[] Output, float[] BedOffsets, float CenterRot) global native

; bool function _SetActor(Actor ProspectRef) native
; function _ApplyExpression(Actor ProspectRef, int[] Presets) global native


; function GetVars()
;	IntShare = Thread.IntShare
;	FloatShare = Thread.FloatS1hare
;	StringShare = Thread.StringShare
;	BoolShare
; endFunction

; int[] property IntShare auto hidden ; Stage, ActorCount, BedStatus[1]
; float[] property FloatShare auto hidden ; RealTime, StartedAt
; string[] property StringShare auto hidden ; AdjustKey
; bool[] property BoolShare auto hidden ; 
; sslBaseAnimation[] property _Animation auto hidden ; Animation



; SLSO shit

Faction slaArousal
Faction slaExhibitionist
Bool bslaExhibitionist
Bool SLSOGetEnjoymentCheck1
Bool SLSOGetEnjoymentCheck2
Bool EstrusForcedEnjoymentMods
;Int AllowNonAggressorOrgasm
Int slaExhibitionistNPCCount
int BonusEnjoyment
int ActorFullEnjoyment
float sl_enjoymentrate
float MasturbationMod
float slaActorArousalMod
float ExhibitionistMod
float GenderMod
Keyword zadDeviousBelt

bool function IsVictim()
	return IsVictim
endFunction

bool function IsCreature()
	return IsCreature
endFunction

bool function IsAggressor()
	return IsAggressor
endFunction

bool function IsSilent()
	return IsSilent
endFunction

string function GetActorName()
	return ActorName
endFunction

function SLSO_Initialize()
	;SLSO
	; Flags
	EstrusForcedEnjoymentMods = false
	bslaExhibitionist	 = false
	; Integers
	BonusEnjoyment		= 0
	ActorFullEnjoyment		= 0
	slaExhibitionistNPCCount	  = 0
	; Floats
	MasturbationMod		= 1.0
	slaActorArousalMod	= 1.0
	ExhibitionistMod	= 1.0
	GenderMod	  = 1.0
	; Factions
	slaArousal			 = None
	slaExhibitionist	 = None
	; Keywords
	zadDeviousBelt = None
	thread.Set_minimum_aggressor_orgasm_Count(-1)
endFunction

;SLSO enjoyment calc
int function GetFullEnjoyment()
	return ActorFullEnjoyment
endFunction

float function GetFullEnjoymentMod()
	return	100*MasturbationMod/ExhibitionistMod/GenderMod*slaActorArousalMod
endFunction

int function CalculateFullEnjoyment()
	;this can be very script heavy, don't call it unless you absolutely have to, use GetFullEnjoyment()
	int slaActorArousal = 0
	String File = "/SLSO/Config.json"

	if JsonUtil.GetIntValue(File, "sl_sla_arousal") == 2
		if slaArousal != none
			slaActorArousal = ActorRef.GetFactionRank(slaArousal)
		endIf
		if slaActorArousal < 0
			slaActorArousal = 0
		endIf
	endIf
	if JsonUtil.GetIntValue(File, "sl_sla_arousal") == 3
		if slaArousal != none
			slaActorArousalMod = (ActorRef.GetFactionRank(slaArousal) as float) * 2 / 100
		endIf
		if slaActorArousalMod < 0
			slaActorArousalMod = 1
		endIf
		;set agressor arousal modifier to 100% so we dont get stuck in loop if animation requires aggressor orgasm to finish
	endIf

	; realtime exhibitionism detection, very script heavy
	if !IsCreature
		if JsonUtil.GetIntValue(File, "sl_exhibitionist") == 2
			Cell akTargetCell = ActorRef.GetParentCell()
			int iRef = 0
			slaExhibitionistNPCCount = 0
			while iRef <= akTargetCell.getNumRefs(43) && slaExhibitionistNPCCount < 6 ;GetType() 62-char,44-lvchar,43-npc
				Actor aNPC = akTargetCell.getNthRef(iRef, 43) as Actor
				If aNPC!= none && aNPC.GetDistance(ActorRef) < 1000 && aNPC != ActorRef && aNPC.HasLOS(ActorRef)
					slaExhibitionistNPCCount += 1
				EndIf
				iRef = iRef + 1
			endWhile
			if bslaExhibitionist || OwnSkills[Stats.kLewd] > 5
				slaExhibitionistNPCCount = PapyrusUtil.ClampInt(slaExhibitionistNPCCount, 0, 7)
				;Log("slaExhibitionistNPCCount ["+slaExhibitionistNPCCount+"] FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (3 - 0.4 * slaExhibitionistNPCCount)) as int+"]")
				;ExhibitionistMod = (3 - 0.4 * slaExhibitionistNPCCount)
				ExhibitionistMod =	(1.6 - 0.2 * slaExhibitionistNPCCount)
			elseif slaExhibitionistNPCCount > 1 && !IsAggressor
				;Log("slaExhibitionistNPCCount ["+slaExhibitionistNPCCount+"] FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (1 + 0.2 * slaExhibitionistNPCCount)) as int+"]")
				ExhibitionistMod = (1 + 0.2 * slaExhibitionistNPCCount)
			endif
		endif
	endif
	if IsAggressor && JsonUtil.GetIntValue(File, "condition_aggressor_orgasm") == 1
		if slaActorArousalMod < 1
			slaActorArousalMod = 1
		endIf
		if ExhibitionistMod < 1
			ExhibitionistMod = 1
		endIf
	endIf
	
	int SLSO_FullEnjoyment = GetEnjoyment()
	;Log("SLSO_CalculateFullEnjoyment:")
	;Log("SLSO_FullEnjoyment ["+SLSO_FullEnjoyment+"] SL FullEnjoyment ["+FullEnjoyment+"] BaseEnjoyment["+BaseEnjoyment+"] SLArousal["+slaActorArousal+"]"+"] BonusEnjoyment["+BonusEnjoyment+"]")
	;Log("Modifiers: MasturbationMod["+MasturbationMod+" ExhibitionistMod ["+ExhibitionistMod+"] GenderMod["+GenderMod+"] sl_enjoymentrate["+sl_enjoymentrate+"]"+"] slaActorArousalMod["+slaActorArousalMod+"]")

	SLSO_FullEnjoyment = SLSO_FullEnjoyment + slaActorArousal + BonusEnjoyment

	if	EstrusForcedEnjoymentMods
		ActorFullEnjoyment = (SLSO_FullEnjoyment * JsonUtil.GetFloatValue(File, "sl_estrusforcedenjoyment")) as int
	else
		ActorFullEnjoyment = (SLSO_FullEnjoyment * MasturbationMod / ExhibitionistMod / GenderMod * sl_enjoymentrate * slaActorArousalMod) as int
	endIf
	
	;Log("SLSO_ActorFullEnjoyment with modifiers ["+ActorFullEnjoyment+"] = (SLSO_FullEnjoyment ["+SLSO_FullEnjoyment+"] * Modifiers ["+MasturbationMod / ExhibitionistMod / GenderMod * sl_enjoymentrate * slaActorArousalMod+"])")
	return ActorFullEnjoyment
endFunction

int function SLSO_GetEnjoyment()
	if !ActorRef
		Log(ActorName +"- WARNING: ActorRef if Missing or Invalid", "GetEnjoyment()")
		FullEnjoyment = 0
		return 0
	elseif !IsSkilled
		;run default sexlab enjoyment if: enabled in slso mcm, more than 2 actors, thread has no player or npc_game(), game() disabled
		if SLSOGetEnjoymentCheck1
			if SLSOGetEnjoymentCheck2
				FullEnjoyment = (PapyrusUtil.ClampFloat(((RealTime[0] - StartedAt) + 1.0) / 5.0, 0.0, 40.0) + ((Stage as float / StageCount as float) * 60.0)) as int
			else
				FullEnjoyment = (PapyrusUtil.ClampFloat(((RealTime[0] - StartedAt) + 1.0) / 5.0, 0.0, 40.0)) as int
			endIf
		endIf
	else
		if Position == 0
			Thread.RecordSkills()
			Thread.SetBonuses()
		endIf
		if SLSOGetEnjoymentCheck1
			if SLSOGetEnjoymentCheck2
				FullEnjoyment = BaseEnjoyment + CalcEnjoyment(SkillBonus, Skills, LeadIn, IsFemale, (RealTime[0] - StartedAt), Stage, StageCount)
			else
				FullEnjoyment = BaseEnjoyment + CalcEnjoyment(SkillBonus, Skills, LeadIn, IsFemale, (RealTime[0] - StartedAt), 1, StageCount)
			endIf
			if FullEnjoyment < 0
				FullEnjoyment = 0
			;elseIf FullEnjoyment > 100
			;	FullEnjoyment = 100
			endIf
		endIf
	endIf
	int SLSO_Enjoyment = FullEnjoyment - QuitEnjoyment
	;int SLSO_Enjoyment = FullEnjoyment - BaseEnjoyment
	;Log("SLSO_GetEnjoyment: SLSO_Enjoyment["+SLSO_Enjoyment+"] / FullEnjoyment["+FullEnjoyment+"] / QuitEnjoyment["+QuitEnjoyment+"] / BaseEnjoyment["+BaseEnjoyment+"]")
	if SLSO_Enjoyment > 0
		return SLSO_Enjoyment
	endIf
	return 0
	;return SLSO_Enjoyment - BaseEnjoyment
endFunction

function BonusEnjoyment(actor Ref = none, int fixedvalue = 0)
	if self.GetState() == "Animating"
		if Ref == none || Ref == ActorRef
			if Ref == none 
				;Log("Ref is none, setting to self")
				Ref = ActorRef
			endif
			
			if fixedvalue != 0
				;reduce enjoyment by fixed value
				if fixedvalue < 0
					BonusEnjoyment += fixedvalue
					
				;increase enjoyment by fixed value
				else
					BonusEnjoyment += fixedvalue
				endif
				
				;Log("change [" +Ref.GetDisplayName()+ "] BonusEnjoyment[" +BonusEnjoyment+ "] by fixed value[" +fixedvalue+ "]")
				
			;increase enjoyment based on arousal
			else
				;Log("change [" +Ref.GetDisplayName()+ "]")
				int slaActorArousal = 0
				String File = "/SLSO/Config.json"
				if JsonUtil.GetIntValue(File, "sl_sla_arousal") == 1
					if slaArousal != none
						slaActorArousal = ActorRef.GetFactionRank(slaArousal)
					endIf
					if slaActorArousal < 0
						slaActorArousal = 0
					endIf
				endIf
				
				slaActorArousal = PapyrusUtil.ClampInt(slaActorArousal/20, 1, 5)
				;Log("change [" +Ref.GetDisplayName()+ "] enjoyment by [" +slaActorArousal+ "] arousal mod")
				if BaseSex == 0
					BonusEnjoyment +=slaActorArousal
				elseif JsonUtil.GetIntValue(File, "condition_female_orgasm_bonus") != 1
					BonusEnjoyment +=slaActorArousal
				else
				Log("female [" +Ref.GetDisplayName()+ "] bonus enjoyment [" +GetOrgasmCount()+ "]")
					BonusEnjoyment +=slaActorArousal + GetOrgasmCount()
				endif
			endIf
		
		;increase target enjoyment
		elseif Thread.ActorAlias(Ref) != none
			;Log("change target [" +Ref.GetDisplayName()+ "] enjoyment by [" +fixedvalue+ "]")
			Thread.ActorAlias(Ref).BonusEnjoyment(Ref, fixedvalue)
		endIf
	endIf
endFunction

;orgasm stuff
function Orgasm(float experience = 0.0)
	if experience == -2
		LastOrgasm = Math.Abs(RealTime[0] - 11)
		DoOrgasm(true)
	elseif ActorFullEnjoyment >= 90
		if experience == -1
			LastOrgasm = Math.Abs(RealTime[0] - 11)
		endIf
		if Math.Abs(RealTime[0] - LastOrgasm) > 10.0
			OrgasmEffect()
		endIf
	endIf
endFunction

function HoldOut(float experience = 0.0)
	if Position == 0
		if	IsFemale 
			if (Animation.HasTag("Vaginal" || Animation.HasTag("Fisting") || Animation.HasTag("69")))
				LastOrgasm = Math.Abs(RealTime[0] - 8 + OwnSkills[Stats.kVaginal] + experience)
				BonusEnjoyment(ActorRef, (- 1 - OwnSkills[Stats.kVaginal]) as int)
			elseif(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))
				LastOrgasm = Math.Abs(RealTime[0] - 8 + OwnSkills[Stats.kAnal] + experience)
				BonusEnjoyment(ActorRef, (-1 - OwnSkills[Stats.kAnal]) as int)
			else
				LastOrgasm = Math.Abs(RealTime[0] - 8 + experience)
				BonusEnjoyment(ActorRef, -1)
			endIf
		elseif IsMale || IsFuta
			if (Animation.HasTag("Anal") || Animation.HasTag("Fisting"))
				LastOrgasm = Math.Abs(RealTime[0] - 8 + OwnSkills[Stats.kAnal] + experience)
				BonusEnjoyment(ActorRef, (-1 - OwnSkills[Stats.kAnal]) as int)
			else
				LastOrgasm = Math.Abs(RealTime[0] - 8 + experience)
				BonusEnjoyment(ActorRef, -1)
			endIf
		endIf
	elseif Position == 1
		LastOrgasm = Math.Abs(RealTime[0] - 8 + experience)
		BonusEnjoyment(ActorRef, -1)
	endIf
endFunction

int function GetOrgasmCount()
	if !ActorRef
		Orgasms = 0
	endIf
	return Orgasms
endFunction

function SetOrgasmCount(int SetOrgasms = 0)
	if SetOrgasms >=0
		Orgasms = SetOrgasms
	endIf
endFunction

;Sexlab "patching", for interaluse only
int function SLSO_DoOrgasm_Conditions(bool Forced)
	String File = "/SLSO/Config.json"
	if LeadIn && JsonUtil.GetIntValue(File, "condition_leadin_orgasm") == 0
		Log(ActorName + " Orgasm blocked, orgasms disabled at LeadIn/Foreplay Stage")
		return -1
	endIf
	if IsPlayer && (JsonUtil.GetIntValue(File, "condition_player_orgasm") == 0)
		Log("Orgasm blocked, player is forbidden to orgasm")
		return -2
	endIf
	if JsonUtil.GetIntValue(File, "condition_ddbelt_orgasm") == 0
		if zadDeviousBelt != none
			if ActorRef.WornHasKeyword(zadDeviousBelt)
				Log("Orgasm blocked, " + ActorName + " has DD belt prevent orgasming")
				return -3
			EndIf
		endIf
	endIf
	if !Animation.HasTag("Estrus")
		if IsVictim
			if JsonUtil.GetIntValue(File, "condition_victim_orgasm") == 0
				Log("Orgasm blocked, " + ActorName + " is victim, victim forbidden to orgasm")
				return -4
			elseif JsonUtil.GetIntValue(File, "condition_victim_orgasm") == 2
				if (OwnSkills[Stats.kLewd]*10) as int < Utility.RandomInt(0, 100)
					Log("Orgasm blocked, " + ActorName + " is victim, victim didn't pass lewd check to orgasm")
					return -5
				endIf
			endIf
		endIf
		if !IsAggressor
			if !(Animation.HasTag("69") || Animation.HasTag("Masturbation")) || Thread.Positions.Length == 2
				if	!IsCreature && BaseRef.GetSex() != Gender || IsFuta
					if	JsonUtil.GetIntValue(File, "condition_futa_orgasm") == 1
						if Position == 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Lesbian"))
							Log(ActorName + " Orgasm blocked, futa female pos 0, conditions not met, no HasTag(Vaginal,Anal,Cunnilingus,Fisting)")
							return -11
						elseif Position != 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Boobjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Handjob") || Animation.HasTag("Footjob"))
							Log(ActorName + " Orgasm blocked, futa male pos > 0, conditions not met, no HasTag(Vaginal,Anal,Boobjob,Blowjob,Handjob,Footjob)")
							return -12
						endIf
					endIf
				elseif IsFemale
					if JsonUtil.GetIntValue(File, "condition_female_orgasm") == 1
						if Position == 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Lesbian"))
							Log(ActorName + " Orgasm blocked, female pos 0, conditions not met, no HasTag(Vaginal,Anal,Cunnilingus,Fisting)")
							return -6
						endIf
					endIf
				elseif IsMale
					if JsonUtil.GetIntValue(File, "condition_male_orgasm") == 1
						if Position == 0 && !(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))
							Log(ActorName + " Orgasm blocked, male pos 0, conditions not met, no HasTag(Anal,Fisting)")
							return -7
						elseif Position != 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Boobjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Handjob") || Animation.HasTag("Footjob"))
							Log(ActorName + " Orgasm blocked, male pos > 0, conditions not met, no HasTag(Vaginal,Anal,Boobjob,Blowjob,Handjob,Footjob)")
							return -8
						endIf
					endIf
				endIf
			endIf
		endIf
		if StorageUtil.GetIntValue(ActorRef, "slso_forbid_orgasm") == 1
			Log("Orgasm blocked, " + ActorName + " is forbidden to orgasm (by other mod)")
			return -9
		endIf
	endIf
	if StorageUtil.GetIntValue(ActorRef, "slso_forbid_orgasm") == 1
		int Seid = ModEvent.Create("SexLabOrgasmSeparateDenied")
		if Seid
			ModEvent.PushForm(Seid, ActorRef)
			ModEvent.PushInt(Seid, Thread.tid)
			ModEvent.Send(Seid)
		endif
		Log("Orgasm blocked, " + ActorName + " is forbidden to orgasm")
		return -10
	endIf
	return 0
endFunction

function SLSO_DoOrgasm_Multiorgasm()
	String File = "/SLSO/Config.json"

	if BaseSex == 0
		if JsonUtil.GetIntValue(File, "condition_male_orgasm_penalty") == 1
			;male wont be able to orgasm 2nd time if slso game() and sla disabled
			;Log("male FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (1 + GetOrgasmCount()*2)) as int+"]")
			if (Position == 0 && !(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))) || Position != 0
				if (!IsAggressor || IsPlayer)
					GenderMod = (1 + GetOrgasmCount()*2)
				endif
			endif
		endif
	endif
	;if (Utility.RandomInt(0, 100) > (JsonUtil.GetIntValue(File, "sl_multiorgasmchance") + ((OwnSkills[Stats.kLewd]*10) as int) - 10 * Orgasms)) || BaseSex != 1
	if (Utility.RandomInt(0, 100) > (JsonUtil.GetIntValue(File, "sl_multiorgasmchance") + ((OwnSkills[Stats.kLewd] * JsonUtil.GetIntValue(File, "sl_multiorgasmchance_curve")) as int) - 10 * Orgasms)) || BaseSex != 1
		;orgasm
		LastOrgasm = Math.Abs(SexLabUtil.GetCurrentGameRealTime())
		; Reset enjoyment build up, if using separate orgasms option
		if IsSkilled
			if IsVictim
				BaseEnjoyment += ((BestRelation - 3) + PapyrusUtil.ClampInt((OwnSkills[Stats.kLewd]-OwnSkills[Stats.kPure]) as int,-6,6)) * Utility.RandomInt(5, 10)
			else
				if IsAggressor
					BaseEnjoyment += (-1*((BestRelation - 4) + PapyrusUtil.ClampInt(((Skills[Stats.kLewd]-Skills[Stats.kPure])-(OwnSkills[Stats.kLewd]-OwnSkills[Stats.kPure])) as int,-6,6))) * Utility.RandomInt(5, 10)
				else
					BaseEnjoyment += (BestRelation + PapyrusUtil.ClampInt((((Skills[Stats.kLewd]+OwnSkills[Stats.kLewd])*0.5)-((Skills[Stats.kPure]+OwnSkills[Stats.kPure])*0.5)) as int,0,6)) * Utility.RandomInt(5, 10)
				endIf
			endIf
		else
			if IsVictim
				BaseEnjoyment += (BestRelation - 3) * Utility.RandomInt(5, 10)
			else
				if IsAggressor
					BaseEnjoyment += (-1*(BestRelation - 4)) * Utility.RandomInt(5, 10)
				else
					BaseEnjoyment += (BestRelation + 3) * Utility.RandomInt(5, 10)
				endIf
			endIf
		endIf
		;reset slso enjoyment build up
		BonusEnjoyment = 0
	else
		;slso multiorgasm for females (rnd + lewdness), reset timer
		LastOrgasm = Math.Abs(SexLabUtil.GetCurrentGameRealTime() - 9)
	endIf
endFunction

function SLSO_DoOrgasm_SexLabOrgasmSeparate()
	if SeparateOrgasms
		String File = "/SLSO/Config.json"
		if !IsPlayer && (IsAggressor || (!IsAggressor && JsonUtil.GetIntValue(File, "condition_consensual_orgasm") == 1))
			if JsonUtil.GetIntValue(File, "game_enabled") == 1
				if GetOrgasmCount() == Thread.Get_minimum_aggressor_orgasm_Count()
					if Utility.RandomInt(0, 100) < JsonUtil.GetIntValue(File, "condition_chance_minimum_aggressor_orgasm_increase")
						Thread.Set_minimum_aggressor_orgasm_Count(Thread.Get_minimum_aggressor_orgasm_Count() + 1)
						Log("Aggressor - " + ActorName + " increased required orgasms to: " + Thread.Get_minimum_aggressor_orgasm_Count())
					endif
				endif
			endif
		endif
		int Seid = ModEvent.Create("SexLabOrgasmSeparate")
		if Seid
			ModEvent.PushForm(Seid, ActorRef)
			ModEvent.PushInt(Seid, Thread.tid)
			ModEvent.Send(Seid)
		endif
	endif
endFunction

function SLSO_StartAnimating()
	String File = "/SLSO/Config.json"
	BonusEnjoyment = 0
	if Game.GetModByName("SexLabAroused.esm") != 255
		slaArousal = Game.GetFormFromFile(0x3FC36, "SexLabAroused.esm") As Faction
	endIf
	if Game.GetModByName("Devious Devices - Assets.esm") != 255
		zadDeviousBelt = Game.GetFormFromFile(0x3330, "Devious Devices - Assets.esm") As Keyword
	endif
	
	bool SLSO_GAME_enabled = (JsonUtil.GetIntValue(File, "game_enabled") == 1 && Thread.HasPlayer) || (JsonUtil.GetIntValue(File, "game_npc_enabled", 0) == 1 && !Thread.HasPlayer)

;GetEnjoyment() condi checks
;to enable default sexlab enjoyment gains if true
	if JsonUtil.GetIntValue(File, "sl_passive_enjoyment") == 1 || !SLSO_GAME_enabled
		SLSOGetEnjoymentCheck1 = true
	else
		SLSOGetEnjoymentCheck1 = false
	endIf
	
	if JsonUtil.GetIntValue(File, "sl_stage_enjoyment") == 1 || !SLSO_GAME_enabled
		SLSOGetEnjoymentCheck2 = true
	else
		SLSOGetEnjoymentCheck2 = false
	endIf

;CalculateFullEnjoyment() checks
	ExhibitionistMod = 1
	bslaExhibitionist = false
	slaExhibitionistNPCCount = 0
	if !IsCreature
	;Check if actor sla exhibitionist
		if Game.GetModByName("SexLabAroused.esm") != 255
			slaExhibitionist = Game.GetFormFromFile(0x713DA, "SexLabAroused.esm") As Faction
			if slaExhibitionist != none
				if ActorRef.GetFactionRank(slaExhibitionist) >= 0
					bslaExhibitionist = true
				endif
			endif
		endIf
	;check npcs nearby for exhibitionist modifier
		if JsonUtil.GetIntValue(File, "sl_exhibitionist") == 1
			Cell akTargetCell = ActorRef.GetParentCell()
			int iRef = 0
			while iRef <= akTargetCell.getNumRefs(43) && slaExhibitionistNPCCount < 6 ;GetType() 62-char,44-lvchar,43-npc
				Actor aNPC = akTargetCell.getNthRef(iRef, 43) as Actor
				If aNPC!= none && aNPC.GetDistance(ActorRef) < 1000 && aNPC != ActorRef && aNPC.HasLOS(ActorRef)
					slaExhibitionistNPCCount += 1
				EndIf
				iRef = iRef + 1
			endWhile
		endif
	;apply modifier 
		if JsonUtil.GetIntValue(File, "sl_exhibitionist") > 0
			if bslaExhibitionist || OwnSkills[Stats.kLewd] > 5
				slaExhibitionistNPCCount = PapyrusUtil.ClampInt(slaExhibitionistNPCCount, 0, 7)
				;Log("slaExhibitionistNPCCount ["+slaExhibitionistNPCCount+"] FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (3 - 0.4 * slaExhibitionistNPCCount)) as int+"]")
				;ExhibitionistMod = (3 - 0.4 * slaExhibitionistNPCCount)
				ExhibitionistMod =	(1.6 - 0.2 * slaExhibitionistNPCCount)
			elseif slaExhibitionistNPCCount > 1 && !IsAggressor
				;Log("slaExhibitionistNPCCount ["+slaExhibitionistNPCCount+"] FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (1 + 0.2 * slaExhibitionistNPCCount)) as int+"]")
				ExhibitionistMod = (1 + 0.2 * slaExhibitionistNPCCount)
			endif
		endif
	endif
	
;Estrus, force enjoyment modifiers to 1+
	bool EstrusAnim = false
	if (Animation.HasTag("Estrus") || Animation.HasTag("Machine") || Animation.HasTag("Slime") || Animation.HasTag("Ooze"))
		EstrusAnim = true
	endif
	
	if EstrusAnim && JsonUtil.GetFloatValue(File, "sl_estrusforcedenjoyment") > 0
		EstrusForcedEnjoymentMods = true
	endif
	
;apply masturbation modifier 
	MasturbationMod = 1
	if Thread.ActorCount == 1 && JsonUtil.GetIntValue(File, "sl_masturbation") == 1

		;Log("masturbation_penalty FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment * (1 - 1 * (OwnSkills[Stats.kLewd]) / 10)) as int+"]")
		;Estrus, increase enjoyment with lewdness
		if EstrusAnim == true
			MasturbationMod = 1 + 1 * (OwnSkills[Stats.kLewd]) / 10
		;normal, reduce enjoyment with lewdness
		else
			MasturbationMod = 1 - 1 * (OwnSkills[Stats.kLewd]) / 10
		endif
		MasturbationMod = PapyrusUtil.ClampFloat(MasturbationMod, 0.1, 2.0)
	endif

;apply arousal modifier, 1=100%
	slaActorArousalMod = 1

;apply gender modifier 
	GenderMod = 1
	if BaseSex == 0
		sl_enjoymentrate = JsonUtil.GetFloatValue(File, "sl_enjoymentrate_male", missing = 1)
		if JsonUtil.GetIntValue(File, "condition_male_orgasm_penalty") == 1
			;male wont be able to orgasm 2nd time if slso game() and sla disabled
			;Log("male FullEnjoyment MOD["+(FullEnjoyment-FullEnjoyment / (1 + GetOrgasmCount()*2)) as int+"]")
			
			;can probably be broken(not refreshed) by manually changing position/animation
			; probably no one will notice so w/e
			if (Position == 0 && !(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))) || Position != 0
				GenderMod = (1 + GetOrgasmCount()*2)
			endif
		endif
	else
		sl_enjoymentrate = JsonUtil.GetFloatValue(File, "sl_enjoymentrate_female", missing = 1)
	endif
		
	;OrgasmEffect() Orgasm condi checks
	;check if non aggressor actor meets orgasm conditions
	;can probably be broken by manually changing position/animation
	;perfomance decrease probably not worth it 
;		AllowNonAggressorOrgasm = 0
;		if !IsAggressor
;			if !(Animation.HasTag("69") || Animation.HasTag("Masturbation")) || Thread.Positions.Length == 2
;				if	IsFemale && JsonUtil.GetIntValue(File, "condition_female_orgasm") == 1
;					if Position == 0 && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Cunnilingus") || Animation.HasTag("Fisting") || Animation.HasTag("Lesbian"))
;						AllowNonAggressorOrgasm = 1
;					endIf
;				elseif IsMale && JsonUtil.GetIntValue(File, "condition_male_orgasm") == 1
;					if Position == 0 && !(Animation.HasTag("Anal") || Animation.HasTag("Fisting"))
;						AllowNonAggressorOrgasm = 2
;					elseif Position != 0 && && !(Animation.HasTag("Vaginal") || Animation.HasTag("Anal") || Animation.HasTag("Boobjob") || Animation.HasTag("Blowjob") || Animation.HasTag("Handjob") || Animation.HasTag("Footjob"))
;						AllowNonAggressorOrgasm = 3
;					endIf
;				endIf
;			endIf
;		endIf
endFunction

Function SLSO_Animating_Moan()
	String File = "/SLSO/Config.json"
	if !IsSilent
		if !IsFemale
			Voice.PlayMoan(ActorRef, ActorFullEnjoyment, IsVictim, UseLipSync)
			;Log("	!IsFemale " + ActorName)
		elseif ((JsonUtil.GetIntValue(File, "sl_voice_player") == 0 && IsPlayer) || (JsonUtil.GetIntValue(File, "sl_voice_npc") == 0 && !IsPlayer))
			Voice.PlayMoan(ActorRef, ActorFullEnjoyment, IsVictim, UseLipSync)
			;Log("	IsFemale " + ActorName)
		endIf
	endIf
endFunction

Function SLSO_DoOrgasm_Moan()
	String File = "/SLSO/Config.json"
	if !IsSilent
		if !IsFemale
			PlayLouder(Voice.GetSound(100, false), ActorRef, Config.VoiceVolume)
		;replace SL actor voice with SLSO, if voice options enabled in SLSO
		elseif ((JsonUtil.GetIntValue(File, "sl_voice_player") == 0 && IsPlayer) || (JsonUtil.GetIntValue(File, "sl_voice_npc") == 0 && !IsPlayer))
			PlayLouder(Voice.GetSound(100, false), ActorRef, Config.VoiceVolume)
		endIf
	endIf
	PlayLouder(OrgasmFX, MarkerRef, Config.SFXVolume)
endFunction

