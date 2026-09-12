Scriptname DOM_Animator extends Quest  
Import DOM_Util
Import Utility
Import Debug
Import Game

; Important note: There is only 1 DOM_Animator and it holds the actor positions.
;                 So for the moment there is no way to run more than one dual animation.
;                 To have more than 1 dual animation at once we need to hold the positions in DOM_Actor for example.
;                 One DOM_Actor could hold positions for itself and the other actor (DOM_Actor, Player or NPC).

DOM_Core Property DOM01 Auto
DOM_SEXLAB Property DOMSexlab Auto
Package Property DoNothing Auto
Faction Property DOMAnimatingFaction Auto
Actor Property PlayerRef Auto
Keyword Property ActorTypeCreature Auto
Keyword Property ActorTypeNPC Auto

bool Property doRescale     = true Auto Hidden
bool Property doPlayerAnim  = true Auto Hidden
bool Property doFreeCamera  = false Auto Hidden
bool Property doRemoveHeels = false Auto Hidden
bool Property doAnimateAtActorLocation = false Auto Hidden
bool Property alwaysRandomizeAnimations = false Auto Hidden

bool Function IsAnimating(Actor ActorRef)
	if ActorRef.IsInFaction(DOMAnimatingFaction)
		return true
	endif
	return false
EndFunction

Function ScaleActorToOther(Actor ActorRef, Actor OtherRef)
	if !doRescale
		return
	endif
	Float mScale = ActorRef.GetScale()
	Float pScale = OtherRef.GetScale() 
	ActorRef.SetScale ( pScale / mScale)
	ActorRef.QueueNiNodeUpdate()
EndFunction

Function ScaleActorBack(Actor ActorRef)
	if !doRescale
		return
	endif
	ActorRef.SetScale (1.0)
	ActorRef.QueueNiNodeUpdate()
EndFunction

Function RemoveHeels(Actor ActorRef)
	if !doRemoveHeels ; Local DOM config
		return
	endif
	if !ActorRef.HasKeyword(ActorTypeNPC) || ActorRef.HasKeyword(ActorTypeCreature)
		return
	endif
	if !ActorRef.GetWornForm(0x00000080) ; Feet
		return
	endif
	SetupNiOverride(ActorRef)
	RemoveHeelEffect(ActorRef)
	RemoveHeelNiOverride(ActorRef)
EndFunction

Function AddHeels(Actor ActorRef)
	if !doRemoveHeels ; Local DOM config
		return
	endif
	if !ActorRef.HasKeyword(ActorTypeNPC) || ActorRef.HasKeyword(ActorTypeCreature)
		return
	endif
	if !ActorRef.GetWornForm(0x00000080) ; Feet
		return
	endif
	AddHeelEffect(ActorRef)
	AddHeelNiOverride(ActorRef)
EndFunction

Function RemoveHeelEffect(Actor ActorRef) ; Code ripped from SL
	if !DOMSexlab.HasHDTHeels
		return
	endif
	Spell HDTHeelSpell = DOMSexlab.GetHDTSpell(ActorRef) 
	if HDTHeelSpell == None
		return
	endif
	if !ActorRef.HasSpell(HDTHeelSpell)
		return
	endif
	ActorRef.RemoveSpell(HDTHeelSpell)
EndFunction

Function AddHeelEffect(Actor ActorRef) ; Code ripped from SL
	if !DOMSexlab.HasHDTHeels
		return
	endif
	Spell HDTHeelSpell = DOMSexlab.GetHDTSpell(ActorRef) 
	if HDTHeelSpell == None
		return
	endif
	if ActorRef.HasSpell(HDTHeelSpell)
		return
	endif
	ActorRef.AddSpell(HDTHeelSpell)
EndFunction

Function SetupNiOverride(Actor ActorRef)
	if !DOMSexlab.HasNiOverride
		return
	endif
	ActorBase BaseRef = ActorRef.GetLeveledActorBase()
	bool isRealFemale = (BaseRef.GetSex()) == 1
	string[] MOD_OVERRIDE_KEY = NiOverride.GetNodeTransformKeys(ActorRef, False, isRealFemale, "NPC")
	int idx = 0
	While idx < MOD_OVERRIDE_KEY.Length
		if MOD_OVERRIDE_KEY[idx] == "DiaryOfMine.esp" ; Remove key Node if present by error
			if NiOverride.RemoveNodeTransformScale(ActorRef, False, isRealFemale, "NPC", MOD_OVERRIDE_KEY[idx])
				NiOverride.UpdateNodeTransform(ActorRef, False, isRealFemale, "NPC")
			endif
		endif
		if MOD_OVERRIDE_KEY[idx] == "DiaryOfMine.esm" ; Remove key Node if present by error
			if NiOverride.RemoveNodeTransformScale(ActorRef, False, isRealFemale, "NPC", MOD_OVERRIDE_KEY[idx])
				NiOverride.UpdateNodeTransform(ActorRef, False, isRealFemale, "NPC")
			endif
		endif
		if MOD_OVERRIDE_KEY[idx] == "DiaryOfMine" ; Remove key Node if present by error
			if NiOverride.RemoveNodeTransformScale(ActorRef, False, isRealFemale, "NPC", MOD_OVERRIDE_KEY[idx])
				NiOverride.UpdateNodeTransform(ActorRef, False, isRealFemale, "NPC")
			endif
		endif
		idx += 1
	endWhile
EndFunction

Function RemoveHeelNiOverride(Actor ActorRef) ; Code ripped from SL
	if !DOMSexlab.HasNiOverride
		return
	endif
	ActorBase BaseRef = ActorRef.GetLeveledActorBase()
	bool isRealFemale = (BaseRef.GetSex()) == 1
	bool UpdateNiOPosition = NiOverride.RemoveNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "DiaryOfMine.esm")
	if NiOverride.HasNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "internal")
		float[] pos = NiOverride.GetNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "internal")
		pos[0] = -pos[0]
		pos[1] = -pos[1]
		pos[2] = -pos[2]
		NiOverride.AddNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "DiaryOfMine.esm", pos)
		NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
	elseIf UpdateNiOPosition
		NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
	endif
EndFunction

Function AddHeelNiOverride(Actor ActorRef) ; Code ripped from SL
	if !DOMSexlab.HasNiOverride
		return
	endif
	ActorBase BaseRef = ActorRef.GetLeveledActorBase()
	bool isRealFemale = (BaseRef.GetSex()) == 1
	bool UpdateNiOPosition = NiOverride.RemoveNodeTransformPosition(ActorRef, false, isRealFemale, "NPC", "DiaryOfMine.esm")
	bool UpdateNiOScale = NiOverride.RemoveNodeTransformScale(ActorRef, false, isRealFemale, "NPC", "DiaryOfMine.esm")
	if UpdateNiOPosition || UpdateNiOScale
		NiOverride.UpdateNodeTransform(ActorRef, false, isRealFemale, "NPC")
	endif
EndFunction

Function FaceToFace(Actor ActorRef, ObjectReference OtherRef)
	; Place Actor in front of other for animation
	Float distance = 64.0
	Float az = OtherRef.GetAngleZ() ; +180.0 if from behind or use a negative distance
	ActorRef.MoveTo(OtherRef, distance * Math.Sin(az), distance * Math.Cos(az),1.0,false) ; do not match rotation
	Float pz = ActorRef.GetHeadingAngle(OtherRef)  ; +180.0 ; if heading away from object
	ActorRef.SetAngle(ActorRef.GetAngleX(), ActorRef.GetAngleY(), ActorRef.GetAngleZ() + pz)
EndFunction

Function FaceToBack(Actor ActorRef, ObjectReference OtherRef)
	; Place Actor in front of other for animation
	Float distance = 64.0
	Float az = OtherRef.GetAngleZ() + 180.0 ; if from behind or use a negative distance
	ActorRef.MoveTo(OtherRef, distance * Math.Sin(az), distance * Math.Cos(az),1.0,false) ; do not match rotation
	Float pz = ActorRef.GetHeadingAngle(OtherRef)  ; +180.0 ; if heading away from object
	ActorRef.SetAngle(ActorRef.GetAngleX(), ActorRef.GetAngleY(), ActorRef.GetAngleZ() + pz)
EndFunction

; Wait 1 second for actor to stop combat
Function ClearActor(Actor ActorRef)
	bool anim_actor = (doPlayerAnim || ActorRef != PlayerRef)

	if !anim_actor
		return
	endif

	StandUpActor(ActorRef)
	CalmActorFast(ActorRef)
	ActorRef.ClearKeepOffsetFromActor()
EndFunction

; Allows wait of only 1 second for 2 actors in combat
Function ClearActors(Actor ActorRef, Actor OtherRef)
	bool anim_actor = (doPlayerAnim || ActorRef != PlayerRef)
	bool anim_other = (doPlayerAnim || OtherRef != PlayerRef)	

	if anim_actor && anim_other
		StandUpActor(ActorRef)
		StandUpActor(OtherRef)
		CalmActorFast(ActorRef)
		CalmActorFast(OtherRef)
		ActorRef.ClearKeepOffsetFromActor()
		OtherRef.ClearKeepOffsetFromActor()
		return
	endif
	
	if anim_actor
		StandUpActor(ActorRef)
		CalmActorFast(ActorRef)
		ActorRef.ClearKeepOffsetFromActor()
		return
	endif
	if anim_other
		StandUpActor(OtherRef)
		CalmActorFast(OtherRef)
		OtherRef.ClearKeepOffsetFromActor()
	endif
EndFunction

; Lock actor in position
Function LockActor(Actor ActorRef)
	; Tell Sexlab actor is animating
	ActorRef.SetFactionRank(DOMAnimatingFaction, 1)

	ClearActor(ActorRef)

	; Lock player
	if ActorRef == PlayerRef
		if doPlayerAnim
			if Game.GetCameraState() == 0
				Game.ForceThirdPerson()
			endif
			Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)
			Game.SetPlayerAIDriven()
			if doFreeCamera
				MiscUtil.SetFreeCameraState(TRUE)
			endif
		endif
		return
	endif

	; Lock actor
	ActorUtil.AddPackageOverride(ActorRef, DoNothing, 100, 1)
	ActorRef.EvaluatePackage()
	ActorRef.SetRestrained(true)
	ActorRef.SetDontMove(true)
	ActorRef.StopTranslation()
EndFunction

Function LockActors(Actor ActorRef, Actor OtherRef)
	; Tell Sexlab actors are animating
	OtherRef.SetFactionRank(DOMAnimatingFaction, 1)
	ActorRef.SetFactionRank(DOMAnimatingFaction, 1)

	bool has_player = (ActorRef == PlayerRef) || (OtherRef == PlayerRef)
	ClearActors(ActorRef, OtherRef)

	; Lock player
	if has_player && doPlayerAnim
		if Game.GetCameraState() == 0
			Game.ForceThirdPerson()
		endif
		Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)
		Game.SetPlayerAIDriven()
		if doFreeCamera
			MiscUtil.SetFreeCameraState(TRUE)
		endif
	endif

	; Lock actors
	if ActorRef != PlayerRef
		ActorUtil.AddPackageOverride(ActorRef, DoNothing, 100, 1)
		ActorRef.EvaluatePackage()
		ActorRef.SetRestrained(true)
		ActorRef.SetDontMove(true)
		ActorRef.StopTranslation()
	endif
	if OtherRef != PlayerRef
		ActorUtil.AddPackageOverride(OtherRef, DoNothing, 100, 1)
		OtherRef.EvaluatePackage()
		OtherRef.SetRestrained(true)
		OtherRef.SetDontMove(true)
		OtherRef.StopTranslation()
	endif
EndFunction

Function StartDualAnim(ObjectReference PoseMarker, Actor ActorRef, Actor OtherRef, float angle1i, float angle2i)
	; Player is reference position and Actor will be moved to Player position
	LockActors(ActorRef, OtherRef)

	bool anim_actor = (doPlayerAnim || ActorRef != PlayerRef)
	bool anim_other = (doPlayerAnim || OtherRef != PlayerRef)

	CenterOnObject(PoseMarker)
	if anim_other && anim_actor
		RemoveHeels(ActorRef)	
		RemoveHeels(OtherRef)	
		ScaleActorToOther(ActorRef,OtherRef)
		SetAngleActor1(angle1i)
		SetAngleActor2(angle2i)
		SyncActorLocation(PoseMarker,ActorRef,angle1)
		SyncActorLocation(PoseMarker,OtherRef,angle2)
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
		Debug.SendAnimationEvent(OtherRef, "IdleForceDefaultState")
		;ActorRef.PlaySyncedAnimationSS("IdleForceDefaultState", OtherRef, "IdleForceDefaultState")
	elseif anim_other
		RemoveHeels(OtherRef)	
		SetAngleActor1(angle1i)
		SetAngleActor2(0.0)
		SyncActorLocation(PoseMarker,OtherRef,angle1)
		Debug.SendAnimationEvent(OtherRef, "IdleForceDefaultState")
	elseif anim_actor
		RemoveHeels(ActorRef)	
		SetAngleActor1(0.0)
		SetAngleActor2(angle2i)
		SyncActorLocation(PoseMarker,ActorRef,angle2)
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
	else
		SetAngleActor1(0.0)
		SetAngleActor2(0.0)
	endif
EndFunction

Function StartDualAnimAlone(ObjectReference PoseMarker, Actor ActorRef, float angle1i)
	LockActor(ActorRef)

	bool anim_actor = (doPlayerAnim || ActorRef != PlayerRef) 

	CenterOnObject(PoseMarker)
	if anim_actor
		RemoveHeels(ActorRef)
		SetAngleActor1(angle1i)
		SetAngleActor2(0.0)
		SyncActorLocation(PoseMarker,ActorRef,angle1)
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
	else
		SetAngleActor1(0.0)
		SetAngleActor2(0.0)
	endif
EndFunction

; With this Function, the player stays in place, and the actor comes to him
Function PlayDualAnim(ObjectReference PoseMarker, Actor ActorRef, Actor OtherRef, string idle1, string idle2)
	; Place actor in same position as player right before playing both animations		

	bool anim_actor = (doPlayerAnim || ActorRef != PlayerRef)
	bool anim_other = (doPlayerAnim || OtherRef != PlayerRef)

	if anim_actor && anim_other
		Snap(PoseMarker,ActorRef,angle1)
		Debug.SendAnimationEvent(ActorRef, idle1)
		Snap(PoseMarker,OtherRef,angle2)
		Debug.SendAnimationEvent(OtherRef, idle2)
	elseif anim_actor
		Snap(PoseMarker,ActorRef,angle1)
		Debug.SendAnimationEvent(ActorRef, idle1)
	elseif anim_other
		Snap(PoseMarker,OtherRef,angle2)
		Debug.SendAnimationEvent(OtherRef, idle2)
	endif
EndFunction

Function PlayDualAnimAlone(ObjectReference PoseMarker, Actor ActorRef, string idle1)
	bool anim_actor = (doPlayerAnim || ActorRef != PlayerRef)

	if anim_actor
		Snap(PoseMarker,ActorRef,angle1)
		Debug.SendAnimationEvent(ActorRef,idle1)
	endif
EndFunction

Function DisableFreeCamera()
	MiscUtil.SetFreeCameraState(false)
	if Game.GetCameraState() == 0
		Game.ForceThirdPerson()
	endif
	Utility.WaitMenuMode(0.5)
EndFunction

Function ReleaseActor(Actor ActorRef)
	;LogAnim("DOM_Animator: Releasing actor "+ActorRef+" player="+PlayerRef)
	; Detach positioning marker
	ActorRef.ClearKeepOffsetFromActor()
	ActorRef.SetVehicle(none)
	ActorRef.StopTranslation()

	; Unlock actor
	if ActorRef != PlayerRef
		ActorRef.SetRestrained(False)
		ActorRef.SetDontMove(False)
		ActorUtil.RemovePackageOverride(ActorRef, DoNothing)
		ActorRef.EvaluatePackage()
		; End animation ; Should be done by the calling script
		; Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
	elseif doPlayerAnim ; && Player is in animation
		DisableFreeCamera()
		ActorRef.SetRestrained(False)
		ActorRef.SetDontMove(False)
		Game.EnablePlayerControls() ; Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
		Game.SetPlayerAIDriven(false)
		; End animation
		Debug.SendAnimationEvent(ActorRef, "IdleForceDefaultState")
	endif
	ActorRef.RemoveFromFaction(DOMAnimatingFaction)
EndFunction

Function EndDualAnimAlone(Actor ActorRef)
	bool anim_actor = doPlayerAnim || (ActorRef != PlayerRef)
	
	if anim_actor
		AddHeels(ActorRef)
	endif

	ReleaseActor(ActorRef)
EndFunction

Function EndDualAnim(Actor ActorRef, Actor OtherRef)
	bool anim_actor = doPlayerAnim || ActorRef != PlayerRef
	bool anim_other = doPlayerAnim || OtherRef != PlayerRef	

	if anim_other && anim_actor
		ScaleActorBack(ActorRef)
		AddHeels(ActorRef)
		AddHeels(OtherRef)
	elseif anim_other
		AddHeels(OtherRef)
	elseif anim_actor
		AddHeels(ActorRef)
	endif
	
	ReleaseActor(ActorRef)
	ReleaseActor(OtherRef)
EndFunction

ObjectReference CenterRef = None
float[] _Center
float[] Property Center
	float[] Function Get()
		if !_Center
			_Center = new float[6]
		endif
		return _Center
	EndFunction
EndProperty
float[] _Offsets
float[] Property Offsets
	float[] Function Get()
		if !_Offsets
			_Offsets = new float[4]
		endif
		return _Offsets
	EndFunction
EndProperty
float[] _Loc
float[] Property Loc
	float[] Function Get()
		if !_Loc
			_Loc = new float[6]
		endif
		return _Loc
	EndFunction
EndProperty

float angle1 = 0.0
float angle2 = 0.0

bool LocationIsCorrect = true

Function ChangeAngleActor1(ObjectReference PoseMarker, Actor ActorRef, float angle)
	angle1 = angle
	SyncActorLocation(PoseMarker, ActorRef, angle1)
EndFunction

Function ChangeAngleActor2(ObjectReference PoseMarker, Actor ActorRef, float angle)
	angle2 = angle
	SyncActorLocation(PoseMarker, ActorRef, angle2)
EndFunction

Function SetAngleActor1(float angle)
	angle1 = angle
EndFunction

Function SetAngleActor2(float angle)
	angle2 = angle
EndFunction

Function CenterOnObject(ObjectReference CenterOn)
	if CenterOn == None
		DOM01.HudNotification("DOM_Animator: No positioning marker set, prepare to fly!")
		LocationIsCorrect = false
		return
	endif
	
	CenterRef = CenterOn

	; Get Position after Lock the Actor to avoid unwanted teleport.
	Center[0] = CenterOn.GetPositionX()
	Center[1] = CenterOn.GetPositionY()
	Center[2] = CenterOn.GetPositionZ()
	Center[3] = CenterOn.GetAngleX()
	Center[4] = CenterOn.GetAngleY()
	Center[5] = CenterOn.GetAngleZ()
	SetLocation(CenterOn)
EndFunction

Function SetLocation(ObjectReference PositionMarker)
	Offsets[0] = 0.0
	Offsets[1] = 0.0
	Offsets[2] = 0.0 ; This should be 5.0 if on bed
	Offsets[3] = 0.0
	Loc[0] = 0.0
	Loc[1] = 0.0
	Loc[2] = 0.0
	Loc[3] = 0.0
	Loc[4] = 0.0
	Loc[5] = 0.0
	OffsetCoords(Loc, Center, Offsets)
	if _Loc[0] == 0.0 &&  _Loc[1] == 0.0 && _Loc[2] == 0.0
		;LogAnim("DOM_Animator: Could not get coordinates, will not snap actors into place")
		LocationIsCorrect = false
	else
		LocationIsCorrect = true
	endif
	SyncMarkerLocation(PositionMarker)
EndFunction

float[] function OffsetCoords(float[] Loc, float[] CenterLoc, float[] Offsets)
	Loc[0] = CenterLoc[0] + ( Math.sin(CenterLoc[5]) * Offsets[0] ) + ( Math.cos(CenterLoc[5]) * Offsets[1] )
	Loc[1] = CenterLoc[1] + ( Math.cos(CenterLoc[5]) * Offsets[0] ) + ( Math.sin(CenterLoc[5]) * Offsets[1] )
	Loc[2] = CenterLoc[2] + Offsets[2]
	Loc[3] = CenterLoc[3]
	Loc[4] = CenterLoc[4]
	Loc[5] = CenterLoc[5] + Offsets[3]
	if Loc[5] >= 360.0
		Loc[5] = Loc[5] - 360.0
	elseIf Loc[5] < 0.0
		Loc[5] = Loc[5] + 360.0
	endIf
	return Loc
endFunction

Function SyncMarkerLocation(ObjectReference PositionMarker)
	if !LocationIsCorrect
		return
	endif
	PositionMarker.SetPosition(_Loc[0], _Loc[1], _Loc[2])
	PositionMarker.SetAngle(_Loc[3], _Loc[4], _Loc[5])
EndFunction

Function SyncActorLocation(ObjectReference PositionMarker, Actor ActorRef, float angle)
	if !LocationIsCorrect
		return
	endif
	if !ActorRef.Is3DLoaded()
		return
	endif
	; Avoid forcibly setting on player coords if avoidable - causes annoying graphical flickering
	;if ActorRef == PlayerRef && IsInPosition(ActorRef, PositionMarker, 40.0)
	;	ActorRef.SetVehicle(PositionMarker)
	;	ActorRef.TranslateTo(Loc[0], Loc[1], Loc[2], Loc[3], Loc[4], Loc[5]+angle, 50000, 0)
	;	return ; Should snap
	;else
	bool anim_actor = doPlayerAnim || (ActorRef != PlayerRef)
	if !anim_actor || ActorRef == None
		return
	endif
	;LogAnim("SyncActorLocation: "+ActorRef.GetDisplayName()+" Angle = "+angle)
	ActorRef.SetPosition(_Loc[0], _Loc[1], _Loc[2])
	ActorRef.SetAngle(_Loc[3], _Loc[4], _Loc[5]+angle)
	ActorRef.SetVehicle(PositionMarker)
	Snap(PositionMarker,ActorRef,angle)
EndFunction

Function Snap(ObjectReference PositionMarker, Actor ActorRef, float angle)
	if !LocationIsCorrect
		return
	endif
	;LogAnim("Snap: "+ActorRef.GetDisplayName()+" Angle = "+angle)
	; Quickly move into place and angle if actor is off by a lot
	float distance = ActorRef.GetDistance(PositionMarker)
	if distance > 125.0 || !sslActorAlias.IsInPosition(ActorRef, PositionMarker, 75.0)
		ActorRef.SetPosition(_Loc[0], _Loc[1], _Loc[2])
		ActorRef.SetAngle(_Loc[3], _Loc[4], _Loc[5]+angle)
		ActorRef.SetVehicle(PositionMarker)
	elseIf distance > 2.0
		ActorRef.TranslateTo(_Loc[0], _Loc[1], _Loc[2], _Loc[3], _Loc[4], _Loc[5]+angle, 50000, 0.0)
		return
	endif
	; Begin very slowly rotating a small amount to hold position
	ActorRef.TranslateTo(_Loc[0], _Loc[1], _Loc[2], _Loc[3], _Loc[4], _Loc[5]+0.01+angle, 500.0, 0.0001)
EndFunction

; Events and location should be in actor if we want more than 1 animation running at a time
; event OnUpdate -> Snap, OnTranslationComplete -> Snap

; ********* JSON animation file init

string    g_fileName = "Diary Of Mine/Animations.json"
string    g_basePath = "animationsList"
String[]  g_animation_keys

; ********* JSON animation file handling

Function Initialize()
	LogInfo("============================================================================")
	LogInfo("==                             DOM: Animator                              ==")
	LogInfo("============================================================================")

	PopulateAnimationList()
	
	; Descriptions
	JSONdesc_TiedUpCaged          = GetDescriptions("DOMTiedUpCaged")
	JSONdesc_TiedUpChained        = GetDescriptions("DOMTiedUpChained")
	JSONdesc_TiedUpCross          = GetDescriptions("DOMTiedUpCross")
	JSONdesc_TiedUpPillory        = GetDescriptions("DOMTiedUpPillory")
	JSONdesc_TiedUpPost           = GetDescriptions("DOMTiedUpPost")
	JSONdesc_TiedUpWheel          = GetDescriptions("DOMTiedUpWheel")

	; Tied-up poses
	JSONanim_TiedUpKneeling       = GetAnimations("DOMTiedUpKneeling",1)
	JSONanim_TiedUpStanding       = GetAnimations("DOMTiedUpStanding",1)
	JSONanim_TiedUpLaying         = GetAnimations("DOMTiedUpLaying",1)
	JSONanim_TiedUpInBed          = GetAnimations("DOMTiedUpInBed",1)
	JSONanim_TiedUpHandsBehindBack= GetAnimations("DOMTiedUpHandsBehindBack",1)
	JSONanim_TiedUpHanging        = GetAnimations("DOMTiedUpHanging",1)
	JSONanim_TiedUpHeadDown       = GetAnimations("DOMTiedUpHeadDown",1)
	JSONanim_TiedUpHogtied        = GetAnimations("DOMTiedUpHogtied",1)
	JSONanim_TiedUpCaged          = GetAnimations("DOMTiedUpCaged",1)
	JSONanim_TiedUpChained        = GetAnimations("DOMTiedUpChained",1)
	JSONanim_TiedUpCross          = GetAnimations("DOMTiedUpCross",1)
	JSONanim_TiedUpPillory        = GetAnimations("DOMTiedUpPillory",1)
	JSONanim_TiedUpPost           = GetAnimations("DOMTiedUpPost",1)
	JSONanim_TiedUpSalute         = GetAnimations("DOMTiedUpSalute",1)
	JSONanim_TiedUpWheel          = GetAnimations("DOMTiedUpWheel",1)
	
	; Idle poses
	JSONanim_IdleMaleAroused      = GetAnimations("DOMIdleMaleAroused",1)
	JSONanim_IdleFemaleAroused    = GetAnimations("DOMIdleFemaleAroused",1)
	JSONanim_IdleYokeAroused      = GetAnimations("DOMIdleYokeAroused",1)
	JSONanim_IdleArmbinderAroused = GetAnimations("DOMIdleArmbinderAroused",1)
	JSONanim_IdleTiedUpAroused    = GetAnimations("DOMIdleTiedUpAroused",1)
	JSONanim_IdleCuffedAroused    = GetAnimations("DOMIdleCuffedAroused",1)
	JSONanim_IdleMaleCovering     = GetAnimations("DOMIdleMaleCovering",1)
	JSONanim_IdleFemaleCovering   = GetAnimations("DOMIdleFemaleCovering",1)
	JSONanim_IdleMaleShamed       = GetAnimations("DOMIdleMaleShamed",1)
	JSONanim_IdleFemaleShamed     = GetAnimations("DOMIdleFemaleShamed",1)
	JSONanim_IdleMaleShocked      = GetAnimations("DOMIdleMaleShocked",1)
	JSONanim_IdleFemaleShocked    = GetAnimations("DOMIdleFemaleShocked",1)
	JSONanim_IdleMaleStrip        = GetAnimations("DOMIdleMaleStrip",1)
	JSONanim_IdleFemaleStrip      = GetAnimations("DOMIdleFemaleStrip",1)
	JSONanim_IdleDressBottom      = GetAnimations("DOMIdleDressBottom",1)
	JSONanim_IdleDressTop         = GetAnimations("DOMIdleDressTop",1)
	JSONanim_IdleTieUp            = GetAnimations("DOMIdleTieUp",1)
	JSONanim_IdleDrinkLashPotion  = GetAnimations("DOMIdleDrinkLashPotion",1)
	JSONanim_IdleDrinkLovePotion  = GetAnimations("DOMIdleDrinkLovePotion",1)
	JSONanim_IdleDrinkLustPotion  = GetAnimations("DOMIdleDrinkLustPotion",1)
	JSONanim_IdleDrinkMindPotion  = GetAnimations("DOMIdleDrinkMindPotion",1)
	JSONanim_IdleDrinkNarcotic    = GetAnimations("DOMIdleDrinkNarcotic",1)
	JSONanim_IdleDrinkMead        = GetAnimations("DOMIdleDrinkMead",1)
	JSONanim_IdleDrinkWine        = GetAnimations("DOMIdleDrinkWine",1)
	JSONanim_IdleCough            = GetAnimations("DOMIdleCough",1)
	
	; Sexlab post scene idles
	JSONanim_PostRapeIn  = GetAnimations("DOMIdlePostRapeIn",1)
	JSONanim_PostRapeOut = GetAnimations("DOMIdlePostRapeOut",1)
	
	; Knockout animating
	JSONanim_Knockout    = GetAnimations("DOMKnockout",1)

	; Masturbate poses
	JSONanim_MasturbateMaleStanding         = GetAnimations("DOMMasturbateMaleStanding",1)
	JSONanim_MasturbateMaleStandingClimax   = GetAnimations("DOMMasturbateMaleStandingClimax",1)
	JSONanim_MasturbateFemaleStanding       = GetAnimations("DOMMasturbateFemaleStanding",1)
	JSONanim_MasturbateFemaleStandingClimax = GetAnimations("DOMMasturbateFemaleStandingClimax",1)
	JSONanim_MasturbateMaleKneeling         = GetAnimations("DOMMasturbateMaleKneeling",1)
	JSONanim_MasturbateMaleKneelingClimax   = GetAnimations("DOMMasturbateMaleKneelingClimax",1)
	JSONanim_MasturbateFemaleKneeling       = GetAnimations("DOMMasturbateFemaleKneeling",1)
	JSONanim_MasturbateFemaleKneelingClimax = GetAnimations("DOMMasturbateFemaleKneelingClimax",1)
	JSONanim_MasturbateMaleLaying           = GetAnimations("DOMMasturbateMaleLaying",1)
	JSONanim_MasturbateMaleLayingClimax     = GetAnimations("DOMMasturbateMaleLayingClimax",1)
	JSONanim_MasturbateFemaleLaying         = GetAnimations("DOMMasturbateFemaleLaying",1)
	JSONanim_MasturbateFemaleLayingClimax   = GetAnimations("DOMMasturbateFemaleLayingClimax",1)
	
	; Special poses
	JSONanim_PoseMusic            = GetAnimations("DOMPoseMusic",1)
	JSONanim_PoseDance            = GetAnimations("DOMPoseDance",1)
	JSONanim_PoseDrinks           = GetAnimations("DOMPoseDrinks",1)
	JSONanim_PoseMaleDisplay      = GetAnimations("DOMPoseMaleDisplay",1)
	JSONanim_PoseFemaleDisplay    = GetAnimations("DOMPoseFemaleDisplay",1)
	JSONanim_PoseMaleCute         = GetAnimations("DOMPoseMaleCute",1)
	JSONanim_PoseFemaleCute       = GetAnimations("DOMPoseFemaleCute",1)
	JSONanim_PoseMaleAss          = GetAnimations("DOMPoseMaleAss",1)
	JSONanim_PoseFemaleAss        = GetAnimations("DOMPoseFemaleAss",1)
	JSONanim_PoseMaleBreast       = GetAnimations("DOMPoseMaleBreast",1)
	JSONanim_PoseFemaleBreast     = GetAnimations("DOMPoseFemaleBreast",1)
	JSONanim_PoseMaleFront        = GetAnimations("DOMPoseMaleFront",1)
	JSONanim_PoseFemaleFront      = GetAnimations("DOMPoseFemaleFront",1)
	JSONanim_PoseChair            = GetAnimations("DOMPoseChair",1)
	JSONanim_PoseMaleSexy         = GetAnimations("DOMPoseMaleSexy",1)
	JSONanim_PoseFemaleSexy       = GetAnimations("DOMPoseFemaleSexy",1)
	JSONanim_PoseMaleSubmissive   = GetAnimations("DOMPoseMaleSubmissive",1)
	JSONanim_PoseFemaleSubmissive = GetAnimations("DOMPoseFemaleSubmissive",1)
	JSONanim_PoseMaleBroom        = GetAnimations("DOMPoseMaleBroom",1)
	JSONanim_PoseFemaleBroom      = GetAnimations("DOMPoseFemaleBroom",1)
	JSONanim_PoseMaleCleaning     = GetAnimations("DOMPoseMaleCleaning",1)
	JSONanim_PoseFemaleCleaning   = GetAnimations("DOMPoseFemaleCleaning",1)
	JSONanim_PoseMalePickup       = GetAnimations("DOMPoseMalePickup",1)
	JSONanim_PoseFemalePickup     = GetAnimations("DOMPoseFemalePickup",1)
	JSONanim_PoseMaleExercise     = GetAnimations("DOMPoseMaleExercise",1)
	JSONanim_PoseFemaleExercise   = GetAnimations("DOMPoseFemaleExercise",1)
	JSONanim_PoseFlowers          = GetAnimations("DOMPoseFlowers",1)
EndFunction

; Get poses

string Function GetPoseFromArray(DOM_Actor the_actor, String[] the_array, String default_str)
	if !the_array
		LogInfo("WARNING: String array not found. Default value="+default_str)
		return default_str
	endif
	int nmax = the_array.length
	if nmax <= 0
		LogInfo("WARNING: String array empty. Default value="+default_str)
		return default_str
	endif
	if nmax == 1
		return the_array[0]
	endif
	int index
	if alwaysRandomizeAnimations
		index = RandomInt(0,nmax - (1))
	elseif the_actor == None
		index = RandomInt(0,nmax - (1))
	else
		DOM_Mind the_mind = the_actor.mind
		if the_mind == None
			index = RandomInt(0,nmax - (1))
		else
			index = the_mind.GetPersonalityIndex()
			float x   = (nmax as float)/20.0*(index as float)
			index     = (x as int)
			if index < 0
				index = 0
			endif
			if index >= nmax
				index = nmax - (1)
			endif
		endif
	endif
	string the_pose = the_array[index]
	if the_pose == "GS" ; randomize GS pose
		int ipose = RandomInt(1,489)
		return "GS"+ipose
	endif
	return the_pose
EndFunction

string Function GetPoseFromArrayNPC(Actor the_actor, String[] the_array, String default_str)
	if !the_array
		LogInfo("WARNING: String array not found. Default value="+default_str)
		return default_str
	endif
	int nmax = the_array.length
	if nmax <= 0
		LogInfo("WARNING: String array empty. Default value="+default_str)
		return default_str
	endif
	if nmax == 1
		return the_array[0]
	endif
	int index
	if the_actor == None
		index = RandomInt(0,nmax - (1))
	else
		index = DOM01.GetPersonalityIndexNPC(the_actor)
		float x   = (nmax as float)/20.0*(index as float)
		index     = (x as int)
		if index < 0
			index = 0
		endif
		if index >= nmax
			index = nmax - (1)
		endif
	endif
	string the_pose = the_array[index]
	if the_pose == "GS" ; randomize GS pose
		int ipose = RandomInt(1,489)
		return "GS"+ipose
	endif
	return the_pose
EndFunction

; Sexlab post scene idles

string[] JSONanim_PostRapeIn
string Function GetPostRapeAnimIn(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_PostRapeIn,"IdleWounded_02")
EndFunction
string Function GetPostRapeAnimInNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_PostRapeIn,"IdleWounded_02")
EndFunction

string[] JSONanim_PostRapeOut
string Function GetPostRapeAnimOut(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_PostRapeOut,"DOMWounded02Exit")
EndFunction
string Function GetPostRapeAnimOutNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_PostRapeOut,"DOMWounded02Exit")
EndFunction

; Knockout anims

string[] JSONanim_Knockout
string[] Function GetKnockoutAnims()
	return JSONanim_Knockout
EndFunction

; TiedUp poses

string[] JSONanim_TiedUpChained
string[] JSONdesc_TiedUpChained
string Function GetChainPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpChained,"IdleHandsBehindBack")
EndFunction
string Function GetChainAnimationByIndex(int index)
	if !JSONanim_TiedUpChained
		return "IdleHandsBehindBack"
	endif
	if index < 0 || index >= JSONanim_TiedUpChained.Length
		index = 0
	endif
	return JSONanim_TiedUpChained[index]
EndFunction
string[] Function GetChainDescriptions()
	return JSONdesc_TiedUpChained
EndFunction

string[] JSONanim_TiedUpCaged
string[] JSONdesc_TiedUpCaged
string Function GetCagePose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpCaged,"IdleHandsBehindBack")
EndFunction
string Function GetCagedAnimationByIndex(int index)
	if !JSONanim_TiedUpCaged
		return "IdleHandsBehindBack"
	endif
	if index < 0 || index >= JSONanim_TiedUpCaged.Length
		index = 0
	endif
	return JSONanim_TiedUpCaged[index]
EndFunction
string[] Function GetCagedDescriptions()
	return JSONdesc_TiedUpCaged
EndFunction

string[] JSONanim_TiedUpCross
string[] JSONdesc_TiedUpCross
string Function GetCrossPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpCross,"IdleHandsBehindBack")
EndFunction
string Function GetCrossAnimationByIndex(int index)
	if !JSONanim_TiedUpCross
		return "IdleHandsBehindBack"
	endif
	if index < 0 || index >= JSONanim_TiedUpCross.Length
		index = 0
	endif
	return JSONanim_TiedUpCross[index]
EndFunction
string[] Function GetCrossDescriptions()
	return JSONdesc_TiedUpCross
EndFunction

string[] JSONanim_TiedUpPillory
string[] JSONdesc_TiedUpPillory
string Function GetPilloryPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpPillory,"IdleHandsBehindBack")
EndFunction
string Function GetPilloryAnimationByIndex(int index)
	if !JSONanim_TiedUpPillory
		return "IdleHandsBehindBack"
	endif
	if index < 0 || index >= JSONanim_TiedUpPillory.Length
		index = 0
	endif
	return JSONanim_TiedUpPillory[index]
EndFunction
string[] Function GetPilloryDescriptions()
	return JSONdesc_TiedUpPillory
EndFunction

string[] JSONanim_TiedUpPost
string[] JSONdesc_TiedUpPost
string Function GetPostPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpPost,"IdleHandsBehindBack")
EndFunction
string Function GetPostAnimationByIndex(int index)
	if !JSONanim_TiedUpPost
		return "IdleHandsBehindBack"
	endif
	if index < 0 || index >= JSONanim_TiedUpPost.Length
		index = 0
	endif
	return JSONanim_TiedUpPost[index]
EndFunction
string[] Function GetPostDescriptions()
	return JSONdesc_TiedUpPost
EndFunction

string[] JSONanim_TiedUpWheel
string[] JSONdesc_TiedUpWheel
string Function GetWheelPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpWheel,"IdleHandsBehindBack")
EndFunction
string Function GetWheelAnimationByIndex(int index)
	if !JSONanim_TiedUpWheel
		return "IdleHandsBehindBack"
	endif
	if index < 0 || index >= JSONanim_TiedUpWheel.Length
		index = 0
	endif
	return JSONanim_TiedUpWheel[index]
EndFunction
string[] Function GetWheelDescriptions()
	return JSONdesc_TiedUpWheel
EndFunction

string Function GetFurniturePose(DOM_Actor the_actor)
	int i = RandomInt(1,5)
	if i == 1
		return GetCagePose(the_actor)
	elseif i == 2
		return GetCrossPose(the_actor)
	elseif i == 3
		return GetPilloryPose(the_actor)
	elseif i == 4
		return GetPostPose(the_actor)
	endif
	return GetWheelPose(the_actor)
EndFunction

string[] JSONanim_TiedUpSalute
string Function GetTieupSalute(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpSalute,"ZapWriPose08")
EndFunction
string Function GetTieupSaluteNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpSalute,"ZapWriPose08")
EndFunction

string[] JSONanim_TiedUpKneeling
string Function GetTieupKneeling(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpKneeling,"IdleHandsBehindBack")
EndFunction
string Function GetTieupKneelingNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpKneeling,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_TiedUpStanding
string Function GetTieupStanding(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpStanding,"IdleHandsBehindBack")
EndFunction
string Function GetTieupStandingNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpStanding,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_TiedUpInBed
string Function GetTieupInBed(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpInBed,"IdleHandsBehindBack")
EndFunction
string Function GetTieupInBedNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpInBed,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_TiedUpLaying
string Function GetTieupLaying(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpLaying,"IdleHandsBehindBack")
EndFunction
string Function GetTieupLayingNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpLaying,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_TiedUpHogtied
string Function GetTieupHogtied(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpHogtied,"IdleHandsBehindBack")
EndFunction
string Function GetTieupHogtiedNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpHogtied,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_TiedUpHanging
string Function GetTieupHanging(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpHanging,"IdleHandsBehindBack")
EndFunction
string Function GetTieupHangingNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpHanging,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_TiedUpHeadDown
string Function GetTieupHeadDown(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpHeadDown,"DOMIdleSeat1")
EndFunction
string Function GetTieupHeadDownNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpHeadDown,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_TiedUpHandsBehindBack
string Function GetTieupHandsBehindBack(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_TiedUpHandsBehindBack,"IdleHandsBehindBack")
EndFunction
string Function GetTieupHandsBehindBackNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_TiedUpHandsBehindBack,"IdleHandsBehindBack")
EndFunction

; Idle poses

string[] JSONanim_IdleMaleCovering
string[] JSONanim_IdleFemaleCovering
string Function GetCoveringPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_IdleMaleCovering,"DOMZaZCoverSelfM")
	endif
	return GetPoseFromArray(the_actor,JSONanim_IdleFemaleCovering,"DOMZaZCoverSelfF")
EndFunction

string[] JSONanim_IdleMaleShamed
string[] JSONanim_IdleFemaleShamed
string Function GetShamedPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_IdleMaleShamed,"DOMZaZCoverSelfM")
	endif
	return GetPoseFromArray(the_actor,JSONanim_IdleFemaleShamed,"DOMZaZCoverSelfF")
EndFunction

string[] JSONanim_IdleMaleShocked
string[] JSONanim_IdleFemaleShocked
string Function GetShockedPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_IdleMaleShocked,"DOMEstrusExhaustedBack")
	endif
	return GetPoseFromArray(the_actor,JSONanim_IdleFemaleShocked,"DOMEstrusExhaustedFront")
EndFunction

string[] JSONanim_IdleMaleStrip
string[] JSONanim_IdleFemaleStrip
string Function GetStripPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_IdleMaleStrip,"DOMArrok_Undress_G0")
	endif
	return GetPoseFromArray(the_actor,JSONanim_IdleFemaleStrip,"DOMArrok_Undress_G1")
EndFunction
string Function GetStripPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_IdleMaleStrip,"DOMArrok_Undress_G0")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleFemaleStrip,"DOMArrok_Undress_G1")
EndFunction

string[] JSONanim_IdleCough
string Function GetCoughPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleCough,"IdleUncontrollableCough")
EndFunction
string Function GetCoughPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleCough,"IdleUncontrollableCough")
EndFunction

string[] JSONanim_IdleDressBottom
string Function GetDressBottomPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDressBottom,"DOMZapRedress01")
EndFunction
string Function GetDressBottomPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDressBottom,"DOMZapRedress01")
EndFunction

string[] JSONanim_IdleDressTop
string Function GetDressTopPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDressTop,"DOMZapRedress02")
EndFunction
string Function GetDressTopPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDressTop,"DOMZapRedress02")
EndFunction

string[] JSONanim_IdleTieUp
string Function GetTieUpPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleTieUp,"IdleLockpick")
EndFunction

string[] JSONanim_IdleDrinkLashPotion
string Function GetDrinkLashPotionPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDrinkLashPotion,"DOMIdleDrinkLashPotion")
EndFunction
string Function GetDrinkLashPotionPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDrinkLashPotion,"DOMIdleDrinkLashPotion")
EndFunction

string[] JSONanim_IdleDrinkLovePotion
string Function GetDrinkLovePotionPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDrinkLovePotion,"DOMIdleDrinkLovePotion")
EndFunction
string Function GetDrinkLovePotionPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDrinkLovePotion,"DOMIdleDrinkLovePotion")
EndFunction

string[] JSONanim_IdleDrinkLustPotion
string Function GetDrinkLustPotionPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDrinkLustPotion,"DOMIdleDrinkLustPotion")
EndFunction
string Function GetDrinkLustPotionPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDrinkLustPotion,"DOMIdleDrinkLustPotion")
EndFunction

string[] JSONanim_IdleDrinkMindPotion
string Function GetDrinkMindPotionPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDrinkMindPotion,"DOMIdleDrinkMindPotion")
EndFunction
string Function GetDrinkMindPotionPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDrinkMindPotion,"DOMIdleDrinkMindPotion")
EndFunction

string[] JSONanim_IdleDrinkNarcotic
string Function GetDrinkNarcoticPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDrinkNarcotic,"DOMIdleDrinkNarcotic")
EndFunction
string Function GetDrinkNarcoticPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDrinkNarcotic,"DOMIdleDrinkNarcotic")
EndFunction

string[] JSONanim_IdleDrinkMead
string Function GetDrinkMeadPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDrinkMead,"DOMIdleDrinkMead")
EndFunction
string Function GetDrinkMeadPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDrinkMead,"DOMIdleDrinkMead")
EndFunction

string[] JSONanim_IdleDrinkWine
string Function GetDrinkWinePose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleDrinkWine,"DOMIdleDrinkWine")
EndFunction
string Function GetDrinkWinePoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_IdleDrinkWine,"DOMIdleDrinkWine")
EndFunction

string[] JSONanim_IdleMaleAroused
string[] JSONanim_IdleFemaleAroused
string Function GetArousedPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_IdleMaleAroused,"DOMArrok_MaleMasturbation_A1_S3")
	endif
	return GetPoseFromArray(the_actor,JSONanim_IdleFemaleAroused,"DOMBilly_b_fmast3_A1_S5")
EndFunction

string[] JSONanim_IdleYokeAroused
string Function GetYokeArousedPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleYokeAroused,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_IdleArmbinderAroused
string Function GetArmbinderArousedPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleYokeAroused,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_IdleTiedUpAroused
string Function GetTieupArousedPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleTiedUpAroused,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_IdleCuffedAroused
string Function GetCuffedArousedPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_IdleCuffedAroused,"IdleHandsBehindBack")
EndFunction

; Masturbating Poses

string[] JSONanim_MasturbateMaleStanding
string[] JSONanim_MasturbateFemaleStanding
int Function NumberOfMasturbateStandingPoses(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		if !JSONanim_MasturbateMaleStanding
			return 1
		endif
		if JSONanim_MasturbateMaleStanding.length < 1
			return 1
		endif
		return JSONanim_MasturbateMaleStanding.length
	endif
	if !JSONanim_MasturbateFemaleStanding
		return 1
	endif
	if JSONanim_MasturbateFemaleStanding.length < 1
		return 1
	endif
	return JSONanim_MasturbateFemaleStanding.length
EndFunction
string Function GetMasturbateStandingPose(DOM_Actor the_actor, int index)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		if !JSONanim_MasturbateMaleStanding
			return "DOMArrok_MaleMasturbation_A1_S1"
		endif
		if index < 0 || index >= JSONanim_MasturbateMaleStanding.length
			return "DOMArrok_MaleMasturbation_A1_S1"
		endif
		return JSONanim_MasturbateMaleStanding[index]
	endif
	if !JSONanim_MasturbateFemaleStanding
		return "DOMTease_Idle2"
	endif
	if index < 0 || index >= JSONanim_MasturbateFemaleStanding.length
		return "DOMTease_Idle2"
	endif
	return JSONanim_MasturbateFemaleStanding[index]
EndFunction
string Function GetMasturbateStandingPoseNPC(Actor the_actor, int index)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		if !JSONanim_MasturbateMaleStanding
			return "DOMArrok_MaleMasturbation_A1_S1"
		endif
		if index < 0 || index >= JSONanim_MasturbateMaleStanding.length
			return "DOMArrok_MaleMasturbation_A1_S1"
		endif
		return JSONanim_MasturbateMaleStanding[index]
	endif
	if !JSONanim_MasturbateFemaleStanding
		return "DOMTease_Idle2"
	endif
	if index < 0 || index >= JSONanim_MasturbateFemaleStanding.length
		return "DOMTease_Idle2"
	endif
	return JSONanim_MasturbateFemaleStanding[index]
EndFunction
string[] JSONanim_MasturbateMaleStandingClimax
string[] JSONanim_MasturbateFemaleStandingClimax
string Function GetMasturbateStandingPoseClimax(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_MasturbateMaleStandingClimax,"DOMArrok_MaleMasturbation_A1_S4")
	endif
	return GetPoseFromArray(the_actor,JSONanim_MasturbateFemaleStandingClimax,"DOMBilly_b_fmast3_A1_S5")
EndFunction
string Function GetMasturbateStandingPoseClimaxNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_MasturbateMaleStandingClimax,"DOMArrok_MaleMasturbation_A1_S4")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_MasturbateFemaleStandingClimax,"DOMBilly_b_fmast3_A1_S5")
EndFunction

string[] JSONanim_MasturbateMaleKneeling
string[] JSONanim_MasturbateFemaleKneeling
int Function NumberOfMasturbateKneelingPoses(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		if !JSONanim_MasturbateMaleKneeling
			return 1
		endif
		if JSONanim_MasturbateMaleKneeling.length < 1
			return 1
		endif
		return JSONanim_MasturbateMaleKneeling.length
	endif
	if !JSONanim_MasturbateFemaleKneeling
		return 1
	endif
	if JSONanim_MasturbateFemaleKneeling.length < 1
		return 1
	endif
	return JSONanim_MasturbateFemaleKneeling.length
EndFunction
string Function GetMasturbateKneelingPose(DOM_Actor the_actor, int index)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		if !JSONanim_MasturbateMaleKneeling
			return "DOMMitos_Teasing_A2_S1"
		endif
		if index < 0 || index >= JSONanim_MasturbateMaleKneeling.length
			return "DOMMitos_Teasing_A2_S1"
		endif
		return JSONanim_MasturbateMaleKneeling[index]
	endif
	if !JSONanim_MasturbateFemaleKneeling
		return "DoMLeito_FemaleSolo_A1_S1"
	endif
	if index < 0 || index >= JSONanim_MasturbateFemaleKneeling.length
		return "DoMLeito_FemaleSolo_A1_S1"
	endif
	return JSONanim_MasturbateFemaleKneeling[index]
EndFunction
string Function GetMasturbateKneelingPoseNPC(Actor the_actor, int index)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		if !JSONanim_MasturbateMaleKneeling
			return "DOMMitos_Teasing_A2_S1"
		endif
		if index < 0 || index >= JSONanim_MasturbateMaleKneeling.length
			return "DOMMitos_Teasing_A2_S1"
		endif
		return JSONanim_MasturbateMaleKneeling[index]
	endif
	if !JSONanim_MasturbateFemaleKneeling
		return "DoMLeito_FemaleSolo_A1_S1"
	endif
	if index < 0 || index >= JSONanim_MasturbateFemaleKneeling.length
		return "DoMLeito_FemaleSolo_A1_S1"
	endif
	return JSONanim_MasturbateFemaleKneeling[index]
EndFunction
string[] JSONanim_MasturbateMaleKneelingClimax
string[] JSONanim_MasturbateFemaleKneelingClimax
string Function GetMasturbateKneelingPoseClimax(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_MasturbateMaleKneelingClimax,"DOMMitos_Teasing_A2_S4")
	endif
	return GetPoseFromArray(the_actor,JSONanim_MasturbateFemaleKneelingClimax,"DOMLeito_FemaleSolo_A1_S5")
EndFunction
string Function GetMasturbateKneelingPoseClimaxNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_MasturbateMaleKneelingClimax,"DOMMitos_Teasing_A2_S4")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_MasturbateFemaleKneelingClimax,"DOMLeito_FemaleSolo_A1_S5")
EndFunction

string[] JSONanim_MasturbateMaleLaying
string[] JSONanim_MasturbateFemaleLaying
int Function NumberOfMasturbateLayingPoses(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		if !JSONanim_MasturbateMaleLaying
			return 1
		endif
		if JSONanim_MasturbateMaleLaying.length < 1
			return 1
		endif
		return JSONanim_MasturbateMaleLaying.length
	endif
	if !JSONanim_MasturbateFemaleLaying
		return 1
	endif
	if JSONanim_MasturbateFemaleLaying.length < 1
		return 1
	endif
	return JSONanim_MasturbateFemaleLaying.length
EndFunction
string Function GetMasturbateLayingPose(DOM_Actor the_actor, int index)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		if !JSONanim_MasturbateMaleLaying
			return "DOM4D_MaleSolo_A1_S1"
		endif
		if index < 0 || index >= JSONanim_MasturbateMaleLaying.length
			return "DOM4D_MaleSolo_A1_S1"
		endif
		return JSONanim_MasturbateMaleLaying[index]
	endif
	if !JSONanim_MasturbateFemaleLaying
		return "DOMBleagh_FemaleSolo_A1_S1"
	endif
	if index < 0 || index >= JSONanim_MasturbateFemaleLaying.length
		return "DOMBleagh_FemaleSolo_A1_S1"
	endif
	return JSONanim_MasturbateFemaleLaying[index]
EndFunction
string Function GetMasturbateLayingPoseNPC(Actor the_actor, int index)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		if !JSONanim_MasturbateMaleLaying
			return "DOM4D_MaleSolo_A1_S1"
		endif
		if index < 0 || index >= JSONanim_MasturbateMaleLaying.length
			return "DOM4D_MaleSolo_A1_S1"
		endif
		return JSONanim_MasturbateMaleLaying[index]
	endif
	if !JSONanim_MasturbateFemaleLaying
		return "DOMBleagh_FemaleSolo_A1_S1"
	endif
	if index < 0 || index >= JSONanim_MasturbateFemaleLaying.length
		return "DOMBleagh_FemaleSolo_A1_S1"
	endif
	return JSONanim_MasturbateFemaleLaying[index]
EndFunction
string[] JSONanim_MasturbateMaleLayingClimax
string[] JSONanim_MasturbateFemaleLayingClimax
string Function GetMasturbateLayingPoseClimax(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_MasturbateMaleLayingClimax,"DOM4D_MaleSolo_A1_S4")
	endif
	return GetPoseFromArray(the_actor,JSONanim_MasturbateFemaleLayingClimax,"DOMBleagh_FemaleSolo_A1_S5")
EndFunction
string Function GetMasturbateLayingPoseClimaxNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_MasturbateMaleLayingClimax,"DOM4D_MaleSolo_A1_S4")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_MasturbateFemaleLayingClimax,"DOMBleagh_FemaleSolo_A1_S5")
EndFunction

; Entertaining Poses

string[] JSONanim_PoseMusic
string Function GetMusicPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_PoseMusic,"IdleLuteStart")
EndFunction
string Function GetMusicPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMusic,"IdleLuteStart")
EndFunction

string[] JSONanim_PoseDance
string Function GetDancePose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_PoseDance,"IdleCiceroDance1")
EndFunction
string Function GetDancePoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseDance,"IdleCiceroDance1")
EndFunction


string[] JSONanim_PoseDrinks
string Function GetDrinksPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_PoseDrinks,"OffsetCarryMQ201DrinkR")
EndFunction
string Function GetDrinksPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseDrinks,"OffsetCarryMQ201DrinkR")
EndFunction

string[] JSONanim_PoseMaleDisplay
string[] JSONanim_PoseFemaleDisplay
string Function GetDisplayPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleDisplay,"IdleHandsBehindBack")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleDisplay,"DOMBaboStripMotionS03Idle_A01")
EndFunction
string Function GetDisplayPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleDisplay,"IdleHandsBehindBack")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleDisplay,"DOMBaboStripMotionS03Idle_A01")
EndFunction

string[] JSONanim_PoseMaleCute
string[] JSONanim_PoseFemaleCute
string Function GetCutePose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleCute,"IdleHandsBehindBack")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleCute,"DOMWhatDoYouWishOfMe")
EndFunction
string Function GetCutePoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleCute,"IdleHandsBehindBack")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleCute,"DOMWhatDoYouWishOfMe")
EndFunction

string[] JSONanim_PoseMaleAss
string[] JSONanim_PoseFemaleAss
string Function GetAssPresentationPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleAss,"DOMShowYourButt")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleAss,"DOMShowYourButt")
EndFunction
string Function GetAssPresentationPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleAss,"DOMShowYourButt")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleAss,"DOMShowYourButt")
EndFunction

string[] JSONanim_PoseMaleBreast
string[] JSONanim_PoseFemaleBreast
string Function GetBreastPresentationPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleBreast,"DOMHandsBehindPose")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleBreast,"DOMLikeMyBody")
EndFunction
string Function GetBreastPresentationPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleBreast,"DOMHandsBehindPose")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleBreast,"DOMLikeMyBody")
EndFunction

string[] JSONanim_PoseMaleFront
string[] JSONanim_PoseFemaleFront
string Function GetPussyPresentationPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleFront,"DOMArrok_MaleMasturbation_A1_S1")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleFront,"DOMAroused_Idle0")
EndFunction
string Function GetPussyPresentationPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleFront,"DOMArrok_MaleMasturbation_A1_S1")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleFront,"DOMAroused_Idle0")
EndFunction

string[] JSONanim_PoseChair
string Function GetChairPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_PoseChair,"DOMIdleSeat1")
EndFunction
string Function GetChairPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseChair,"DOMIdleSeat1")
EndFunction

string[] JSONanim_PoseMaleSexy
string[] JSONanim_PoseFemaleSexy
string Function GetSexyPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleSexy,"DOMWhatDoYouWishOfMe")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleSexy,"DOMAintICute")
EndFunction
string Function GetSexyPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleSexy,"DOMWhatDoYouWishOfMe")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleSexy,"DOMAintICute")
EndFunction

string[] JSONanim_PoseMaleSubmissive
string[] JSONanim_PoseFemaleSubmissive
string Function GetSubmissivePose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleSubmissive,"IdleHandsBehindBack")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleSubmissive,"IdleHandsBehindBack")
EndFunction
string Function GetSubmissivePoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleSubmissive,"IdleHandsBehindBack")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleSubmissive,"IdleHandsBehindBack")
EndFunction

string[] JSONanim_PoseMaleBroom
string[] JSONanim_PoseFemaleBroom
string Function GetBroomPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleBroom,"IdleLooseSweepingStart")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleBroom,"IdleLooseSweepingStart")
EndFunction
string Function GetBroomPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleBroom,"IdleLooseSweepingStart")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleBroom,"IdleLooseSweepingStart")
EndFunction

string[] JSONanim_PoseMaleCleaning
string[] JSONanim_PoseFemaleCleaning
string Function GetCleaningPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleCleaning,"IdleLooseSweepingStart")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleCleaning,"IdleLooseSweepingStart")
EndFunction
string Function GetCleaningPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleCleaning,"idlepickup_ground")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleCleaning,"idlepickup_ground")
EndFunction

string[] JSONanim_PoseMalePickup
string[] JSONanim_PoseFemalePickup
string Function GetPickupPose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMalePickup,"idlepickup_ground")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemalePickup,"idlepickup_ground")
EndFunction
string Function GetPickupPoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMalePickup,"idlepickup_ground")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemalePickup,"idlepickup_ground")
EndFunction

string[] JSONanim_PoseMaleExercise
string[] JSONanim_PoseFemaleExercise
string Function GetExercisePose(DOM_Actor the_actor)
	If the_actor != None && ((the_actor.actorSex%2) == 0) ; Male
		return GetPoseFromArray(the_actor,JSONanim_PoseMaleExercise,"IdleCiceroDance1")
	endif
	return GetPoseFromArray(the_actor,JSONanim_PoseFemaleExercise,"IdleCiceroDance1")
EndFunction
string Function GetExercisePoseNPC(Actor the_actor)
	If the_actor != None && ((the_actor.GetLeveledActorBase().GetSex()%2) == 0) ; Male
		return GetPoseFromArrayNPC(the_actor,JSONanim_PoseMaleExercise,"IdleCiceroDance1")
	endif
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFemaleExercise,"IdleCiceroDance1")
EndFunction

string[] JSONanim_PoseFlowers
string Function GetFlowersPose(DOM_Actor the_actor)
	return GetPoseFromArray(the_actor,JSONanim_PoseFlowers,"OffsetFlowerBasketStart")
EndFunction
string Function GetFlowersPoseNPC(Actor the_actor)
	return GetPoseFromArrayNPC(the_actor,JSONanim_PoseFlowers,"OffsetFlowerBasketStart")
EndFunction

; Pose management

string Function GetTieupExteriorPose(string the_pose)
	if the_pose == ""
		return ""
	endif
	if the_pose == "zazStruggleRope_Loop"
		return "ZazGirlStrugglingOnTheGround_Loop"
	endif
	if !(StringUtil.Find(the_pose, "ZazAPCAO")>=0) ; not a chain Pose
		return the_pose
	endif
	if the_pose == "ZazAPCAO301"
		return "ZazAPCAO312"
	endif
	if the_pose == "ZazAPCAO302"
		return "ZazAPCAO312"
	endif
	if the_pose == "ZazAPCAO303"
		return "ZazAPCAO312"
	endif
	if the_pose == "ZazAPCAO304"
		return "ZazAPCAO313"
	endif
	if the_pose == "ZazAPCAO305"
		return "ZazAPCAO313"
	endif
	if the_pose == "ZazAPCAO306"
		return "ZazAPCAO313"
	endif
	if the_pose == "ZazAPCAO307"
		return "ZazAPCAO314"
	endif
	if the_pose == "ZazAPCAO308"
		return "ZazAPCAO314"
	endif
	if the_pose == "ZazAPCAO309"
		return "ZazAPCAO314"
	endif
	if the_pose == "ZazAPCAO315"
		return "ZazAPCAO314"
	endif
	return the_pose
EndFunction

string Function GetTieupStrugglePose(string the_pose)
	if StringUtil.Find(the_pose, "ZapWriPose")>=0
		string pose_number = StringUtil.Substring(the_pose,10,StringUtil.GetLength(the_pose))
		string the_struggle_pose = "ZapWriStruggle"+pose_number
		;debug.trace("GetTieupStrugglePose "+the_struggle_pose)
		return the_struggle_pose
	endif
	if the_pose == "ZazAPCAO025" || the_pose == "ZapXCrossPose01" || the_pose == "ZapXCrossPose01b" ; facing forward
		return "ZapXCrossStruggle01"
	endif
	if the_pose == "ZapXCrossPose02" ; facing backward
		return "ZapXCrossStruggle02"
	endif
	if the_pose == "ZazAPCAO051"
		return "ZazAPCAO053"
	endif
	if the_pose == "ZazAPCAO052"
		return "ZazAPCAO053"
	endif
	if the_pose == "ZazAPCAO055"
		return "ZazAPCAO054"
	endif
	if the_pose == "ZazAPCAO310" ; Zaz Chains on the floor face up arms in the back legs spread
		return "ZazAPCAO311"
	endif
	return the_pose
EndFunction

string Function GetTieupEnterPose(string the_pose)
	if StringUtil.Find(the_pose, "ZapWriPose")>=0
		if the_pose == "ZapWriPose03" 
			return "IdleHandsBehindBack"
		elseif the_pose == "ZapWriPose04" 
			return "IdleHandsBehindBack"
		elseif the_pose == "ZapWriPose05" 
			return "IdleHandsBehindBack"
		endif
		return "DOMTieUpEnter"
	endif
	if the_pose == "zazStruggleRope_Loop"
		return "zazStruggleRope_Enter" ; Struggle rope
	elseif the_pose == "Zazboundknees_Loop"
		return "Zazboundknees_Enter" ; Kneeling head-down
	elseif the_pose == "ZazGirlStrugglingOnTheGround_Loop"
		return "ZazGirlStrugglingOnTheGround_Enter" ; Tie-up floor
	elseif the_pose == "IdleHandsBehindBack"
		return "IdleHandsBehindBack" ; Tie-up standing
	elseif the_pose == "ZapWriTurn01"
		return "ZapWriTurn01" ; Tie-up standing
	elseif the_pose == "ZapWriBleedoutIdle"
		return "ZapArmbBleedoutIdle" ; On one knee
	elseif the_pose == DOM01.kneelPose
		return "DOMTieUpEnter"
	endif
	return the_pose
EndFunction

string Function GetTieupExitPose(string the_pose)
	if StringUtil.Find(the_pose, "ZapWriPose")>=0
		if the_pose == "ZapWriPose03" 
			return "IdleHandsBehindBack"
		elseif the_pose == "ZapWriPose04" 
			return "IdleHandsBehindBack"
		elseif the_pose == "ZapWriPose05" 
			return "IdleHandsBehindBack"
		endif
		return "DOMTieUpExit"
	endif
	if the_pose == "zazStruggleRope_Loop"
		return "zazStruggleRope_Exit" ; Struggle rope
	elseif the_pose == "Zazboundknees_Loop"
		return "Zazboundknees_Exit" ; Kneeling head-down
	elseif the_pose == "ZazGirlStrugglingOnTheGround_Loop"
		return "ZazGirlStrugglingOnTheGround_Exit" ; Tie-up floor
	elseif the_pose == "IdleHandsBehindBack"
		return "IdleHandsBehindBack" ; Tie-up standing
	elseif the_pose == "ZapWriTurn01"
		return "ZapWriTurn01" ; Tie-up standing
	elseif the_pose == "ZapWriBleedoutIdle"
		return "ZapArmbBleedoutIdle" ; On one knee
	elseif the_pose == DOM01.kneelPose
		return "DOMTieUpExit"
	endif
	return the_pose
EndFunction

bool Function IsTiedUpPoseCanKneel(string the_pose)
	if StringUtil.Find(the_pose, "ZapWriPose")>=0
		return true
	endif
	if StringUtil.Find(the_pose, "ZapWriStruggle")>=0
		return true
	endif
	if StringUtil.Find(the_pose, "ZazGirlStrugglingOnTheGround")>=0
		return true
	endif
	if StringUtil.Find(the_pose, "HSHStruggle")>=0
		return true
	endif
	return false
EndFunction

; ********* JSON animation file reading with mini cache

Function PopulateAnimationList()
	if !JsonUtil.JsonExists(g_fileName)
		LogTrace("PopulateAnimationList: ERROR Could not find file "+g_fileName)
		return
	endif
	
	last_read_key = ""

	int nkeys = JsonUtil.PathCount(g_fileName, g_basePath) 
	g_animation_keys =  JsonUtil.PathMembers(g_fileName, g_basePath)
	
	int n = g_animation_keys.length
	LogInfo("PopulateAnimationList: Found "+nkeys+" entries in array of size "+n)
	if !DOM01.verboseAnim
		return
	endif
	int i = 0
	while i < n
		string the_key = g_animation_keys[i]
		int nb_actors  = GetNumberOfActors(the_key)
		String[] anims = GetAnimations(the_key,1)
		Float[] angles = GetAngles(the_key,1)
		String[] desc  = GetDescriptions(the_key, false) ; do not check if exists
		bool has_angles
		bool has_desc
		if angles
			has_angles = true
		else
			has_angles = false
		endif
		if desc
			has_desc = true
		else
			has_desc = false
		endif
		int nscenes
		if anims
			nscenes = anims.length
		else
			nscenes = 0
		endif
		LogAnim("PopulateAnimationList: "+i+" "+the_key+" actors = "+nb_actors+" scenes = "+nscenes+" angles "+has_angles+" desc "+has_desc)
		i += 1
	endwhile
EndFunction

String   last_read_key       = ""
String   last_read_desc_key  = ""
Int      last_read_actors    = 0
Float[]  last_read_timers
String[] last_read_anim1
String[] last_read_anim2
String[] last_read_desc
Float[]  last_read_angles1
Float[]  last_read_angles2

Int Function GetNumberOfActors(string the_key)
	if the_key != last_read_key
		last_read_key     = the_key
		last_read_actors  = JsonUtil.GetPathIntValue(g_fileName, g_basePath + "."+ the_key + ".actors")
		last_read_timers  = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".timers")
		last_read_anim1   = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations1")
		last_read_anim2   = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations2")
		last_read_angles1 = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles1")
		last_read_angles2 = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles2")
		if last_read_actors <= 0
			LogInfo("ERROR: Could not read animation with key="+the_key)
		endif
	endif
	return last_read_actors
EndFunction

Float[] Function GetTimers(string the_key)
	if the_key != last_read_key
		last_read_key     = the_key
		last_read_actors  = JsonUtil.GetPathIntValue(g_fileName, g_basePath + "."+ the_key + ".actors")
		last_read_timers  = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".timers")
		last_read_anim1   = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations1")
		last_read_anim2   = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations2")
		last_read_angles1 = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles1")
		last_read_angles2 = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles2")
		if last_read_actors <= 0
			LogInfo("ERROR: Could not read animation with key="+the_key)
		endif
	endif
	return last_read_timers
EndFunction

String[] Function GetDescriptions(string the_key, bool do_check=true)
	if the_key != last_read_desc_key
		last_read_desc_key = the_key
		last_read_desc     = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".descriptions")
	endif
	if do_check && !last_read_desc
		LogInfo("ERROR: Could not read animation descriptions with key="+the_key)
	endif
	return last_read_desc
EndFunction

String[] Function GetAnimations(string the_key, int actorIndex)
	if the_key != last_read_key
		last_read_key     = the_key
		last_read_actors  = JsonUtil.GetPathIntValue(g_fileName, g_basePath + "."+ the_key + ".actors")
		last_read_timers  = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".timers")
		last_read_anim1   = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations1")
		last_read_anim2   = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations2")
		last_read_angles1 = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles1")
		last_read_angles2 = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles2")
		if last_read_actors <= 0
			LogInfo("ERROR: Could not read animation with key="+the_key)
		endif
	endif
	if actorIndex == 1
		return last_read_anim1
	endif
	if actorIndex == 2
		return last_read_anim2
	endif
	return JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations"+actorIndex)
EndFunction

Float[] Function GetAngles(string the_key, int actorIndex)
	if the_key != last_read_key
		last_read_key     = the_key
		last_read_actors  = JsonUtil.GetPathIntValue(g_fileName, g_basePath + "."+ the_key + ".actors")
		last_read_timers  = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".timers")
		last_read_anim1   = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations1")
		last_read_anim2   = JsonUtil.PathStringElements(g_fileName, g_basePath + "."+ the_key + ".animations2")
		last_read_angles1 = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles1")
		last_read_angles2 = JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles2")
		if last_read_actors <= 0
			LogInfo("ERROR: Could not read animation with key="+the_key)
		endif
	endif
	if actorIndex == 1
		return last_read_angles1
	endif
	if actorIndex == 2
		return last_read_angles2
	endif
	return JsonUtil.PathFloatElements(g_fileName, g_basePath + "."+ the_key + ".angles"+actorIndex)
EndFunction

bool Function IsPoseHogTied(string the_pose)
	if !JSONanim_TiedUpHogtied
		return false
	endif
	int n = JSONanim_TiedUpHogtied.length
	int i = 0
	while i < 0
		if the_pose == JSONanim_TiedUpHogtied[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsPoseHanging(string the_pose)
	if JSONanim_TiedUpHanging
		int n = JSONanim_TiedUpHanging.length
		int i = 0
		while i < 0
			if the_pose == JSONanim_TiedUpHanging[i]
				return true
			endif
			i += 1
		endwhile
	endif
	if JSONanim_TiedUpHeadDown
		int n = JSONanim_TiedUpHeadDown.length
		int i = 0
		while i < 0
			if the_pose == JSONanim_TiedUpHeadDown[i]
				return true
			endif
			i += 1
		endwhile
	endif
	return false
EndFunction

bool Function IsPoseTiedUp(string the_pose)
	if JSONanim_TiedUpKneeling
		int n = JSONanim_TiedUpKneeling.length
		int i = 0
		while i < 0
			if the_pose == JSONanim_TiedUpKneeling[i]
				return true
			endif
			i += 1
		endwhile
	endif
	if JSONanim_TiedUpStanding
		int n = JSONanim_TiedUpStanding.length
		int i = 0
		while i < 0
			if the_pose == JSONanim_TiedUpStanding[i]
				return true
			endif
			i += 1
		endwhile
	endif
	if JSONanim_TiedUpLaying
		int n = JSONanim_TiedUpLaying.length
		int i = 0
		while i < 0
			if the_pose == JSONanim_TiedUpLaying[i]
				return true
			endif
			i += 1
		endwhile
	endif
	if JSONanim_TiedUpHandsBehindBack
		int n = JSONanim_TiedUpHandsBehindBack.length
		int i = 0
		while i < 0
			if the_pose == JSONanim_TiedUpHandsBehindBack[i]
				return true
			endif
			i += 1
		endwhile
	endif
	return false
EndFunction

bool Function IsPoseTiedInBed(string the_pose)
	if !JSONanim_TiedUpInBed
		return false
	endif
	int n = JSONanim_TiedUpInBed.length
	int i = 0
	while i < 0
		if the_pose == JSONanim_TiedUpInBed[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsPoseChain(string the_pose)
	if !JSONanim_TiedUpChained
		return false
	endif
	int n = JSONanim_TiedUpChained.length
	int i = 0
	while i < 0
		if the_pose == JSONanim_TiedUpChained[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsPosePost(string the_pose)
	if !JSONanim_TiedUpPost
		return false
	endif
	int n = JSONanim_TiedUpPost.length
	int i = 0
	while i < 0
		if the_pose == JSONanim_TiedUpPost[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsPoseWheel(string the_pose)
	if !JSONanim_TiedUpWheel
		return false
	endif
	int n = JSONanim_TiedUpWheel.length
	int i = 0
	while i < 0
		if the_pose == JSONanim_TiedUpWheel[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsPoseCross(string the_pose)
	if !JSONanim_TiedUpCross
		return false
	endif
	int n = JSONanim_TiedUpCross.length
	int i = 0
	while i < 0
		if the_pose == JSONanim_TiedUpCross[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsPoseCage(string the_pose)
	if !JSONanim_TiedUpCaged
		return false
	endif
	int n = JSONanim_TiedUpCaged.length
	int i = 0
	while i < 0
		if the_pose == JSONanim_TiedUpCaged[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function IsPosePillory(string the_pose)
	if !JSONanim_TiedUpPillory
		return false
	endif
	int n = JSONanim_TiedUpPillory.length
	int i = 0
	while i < 0
		if the_pose == JSONanim_TiedUpPillory[i]
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Animator: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_Animator: "+msg)
	endif
EndFunction

Function LogAnim(string msg)
	if DOM01.verboseAnim
		Debug.Trace("DOM_Animator: "+msg)
	endif
EndFunction
