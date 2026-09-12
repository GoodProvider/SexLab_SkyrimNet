Scriptname zbfBondageShell extends Quest

; @section: zbf
; 
; This is the main interface for ZAP
; 
; This module contains loads of utility functions that are utilized by the rest of the
; systems in ZAP.
; 
; Due to this it's hard to define a good entry point, since most of the functionality is utility functions.
; 
; Some entry points are:
; 
; - ::WornKeywords: Worn keywords, useful for understanding how ZAP works with non-active keywords in defining
;          and setting up items. Most of those keywords are just hints about what the actor is "wearing"
;          (or how the actor is bound).  
;          Since they don't have any actual effects defined by this mod, they can be liberally placed on all items without
;          conflicting in terms of functionality.
; - ::Ai: Ai reference counting. To turn on/off ai for the player.
; - ::EffectKeywords: Keywords used to control the bondage/effects applied on actors in the enchantment mode.
; - ::Slots: Functions to control the slotted behavior of actors. See also zbfSlot::.
; - ::Animation: Animation controls, to set up animations names, and understand how animations are handled by ZAP.
; - ::Sounds: Gag sounds functions.
; 

zbfExternalInterface Property External Auto

Actor Property PlayerRef Auto
zbfPlayerControl Property PlayerControl Auto

Idle Property zbfIdleHandsBound Auto
Idle Property zbfIdleFree Auto
Idle Property zbfIdleForceDefault Auto

; @name: EffectKeywords
; Keywords for effect handling.
; 
; Each of these keywords applies an effect to an item when worn by an actor and when
; either the actor is slotted or the actor is affected by the ZAP item enchantment.
; 
; zbfEffectNoInventory - Denies access to the inventory.
; zbfEffectOpenMouth - Forces the actor to open the mouth. Used on gags, normally.
; zbfEffectWrist - Binds the actor in an animation.
; zbfEffectNoSneak - Disables sneak controls on the player (no effect on npcs).
; zbfEffectNoMove - Disables movement control on the player (no effect on npcs).
; zbfEffectNoActivate - Disables activate control on the player (no effect on npcs).
; zbfEffectNoFighting - Disables draw/sheathe control on the player (no effect on npcs).
; zbfEffectSetExpression - Forces a "sad/angry" expression on the actor.
; zbfEffectSlowMove - Reduces movement speed on that particular actor.
; zbfEffectNoMagic - Prevents magic use for the wearing actor.
; zbfEffectRefresh - Periodically refreshes the offset animation playing on the actor.
; zbfEffectGagSound - Plays a moaning gag sound on the actor when wearing an item.
; zbfEffectBlind - Applies a blindness effect to the actor (only works on player).
; 
Keyword Property zbfEffectNoInventory Auto
Keyword Property zbfEffectOpenMouth Auto
Keyword Property zbfEffectWrist Auto
Keyword Property zbfEffectNoSneak Auto
Keyword Property zbfEffectNoMove Auto
Keyword Property zbfEffectNoActivate Auto
Keyword Property zbfEffectNoFighting Auto
Keyword Property zbfEffectSetExpression Auto
Keyword Property zbfEffectSlowMove Auto
Keyword Property zbfEffectNoMagic Auto
Keyword Property zbfEffectRefresh Auto
Keyword Property zbfEffectGagSound Auto
Keyword Property zbfEffectBlind Auto

Keyword[] Property zbfAnimHands Auto
Idle[] Property HandsBoundIdles Auto
Keyword[] Property zbfAnimMouth Auto
Int[] Property zbfAnimMouthMap Auto
Keyword[] Property zbfAnimFace Auto

; @name: WornKeywords
; Keywords used to identify currently worn item types
; 
; Each item type corresponds to a particular type of binding. Note that none of these keywords are actually used
; by ZAP itself to limit interaction of the player unless requested by an api call or similar. The effects system does not
; scan for these to determine active bindings, and they are not otherwise triggering behavior.
; 
; They should be safe to place on all items that depend on ZAP as they can signal to other mods how they should behave.
; 
; ::zbfWornDevice is special, and is present on all bindings, gags, and so on in ZAP. Any mod that wants to know if an Actor
; is wearing any of the items from ZAP can check for this keyword.
; 
; Example:  
; A mod that prevents speech when gagged, should scan for the ::zbfWornGag keyword.  
; A mod that introduces a chance to trip when running hobbled would scan for ::zbfWornAnkles.
; 
; Example:
; zbfWornBelt - A chastity belt, prevent access to the actors crotch (used in SexLab filtering).
; zbfWornGag - Actor is wearing a gag. This could prevent speech and prevents oral sex when filtering for SexLab.
; 
Keyword Property zbfWornAnkles Auto
Keyword Property zbfWornBelt Auto
Keyword Property zbfWornBlindfold Auto
Keyword Property zbfWornBra Auto
Keyword Property zbfWornCollar Auto
Keyword Property zbfWornGag Auto
Keyword Property zbfWornHood Auto
Keyword Property zbfWornPermitOral Auto
Keyword Property zbfWornWrist Auto
Keyword Property zbfWornYoke Auto
Keyword Property zbfWornDevice Auto

Sound[] Property GagSoundDefault Auto
Sound[] Property GagSoundAlt Auto
Sound[] Property GagSoundFrustrated Auto
Sound[] Property GagSoundTalk Auto
Sound Property GagSoundCustomFemale Auto

Sound Property GagSoundCustomMale Auto
Sound[] Property GagSoundMale01 Auto

Sound Property GagSoundSilent Auto

GlobalVariable Property zbfSettingUpdateInterval Auto
GlobalVariable Property zbfSettingSpeedMult Auto
GlobalVariable Property zbfSettingDisableEffects Auto

Faction Property zbfIsAnimating Auto
Faction Property zbfIsAnimatingExtra Auto Hidden

zbfSlot Property PlayerSlot Auto
zbfSlot[] Property Slots Auto	; First slot is always the player slot

Enchantment Property zbfEnchantmentBondage Auto
Enchantment Property zbfEnchantmentBondageLegacy Auto
MagicEffect Property zbfMagicEffectBondage Auto

ImageSpaceModifier Property zbfImageSpaceBlind Auto
ImageSpaceModifier Property zbfImageSpaceBlindExtra Auto
ImageSpaceModifier Property zbfImageSpaceBlindfold Auto

Int Property iDefaultBoundOffset Auto Hidden		; Set from MCM, default bound animation to play, if not defined by worn items.
Float Property fUpdateIntervalPlayer Auto Hidden	; Set from MCM, update frequency for the PC. Default at 0.5s.
Float Property fUpdateIntervalNpc Auto Hidden		; Set from MCM, update frequency for NPCs. Default at 5.0s.
Bool Property bGagSoundRepeat Auto Hidden			; Repeat playing gagged sounds? Set from MCM.
Float Property fGagSoundFrequency Auto Hidden
Int Property idxGagSoundFemale Auto Hidden
Int Property idxGagSoundMale Auto Hidden
Float Property fGagSoundVolume Auto Hidden
Int Property idxBlindfoldMethod Auto Hidden			; Default blindness method to use. Actual method is set in the slot system.
Float Property fBlindfoldStrength Auto Hidden		; In the interval [0, 1]. Set from MCM.

ObjectReference Property MarkerPin Auto				; Used for pinning actors to the ground.

Armor Property zbfRestraintHider Auto


; @section: Items
; 
; A few short lists of bindings, to use by mods that need just some random item from ZAP.
; 
; Arm bindings slightly overlap with the leg bindings, because items in that category can contain leg cuffs as well.
; 
; code: Selecting a random binding can be done by
; zbfBondageShell zbf = zbfBondageShell.GetApi()
; Armor binding = zbf.ArmBindings[Utility.RandomInt(0, zbf.ArmBindings.Length - 1)]
; 
; code: Alternatively the utility function can be used.
; Armor binding = zbf.GetRandom(Gags)
; 
Armor[] Property ArmBindings Auto
Armor[] Property Gags Auto
Armor[] Property LegBindings Auto
Armor[] Property Blindfolds Auto


; @section: General
; 
; General global utility functions
;

; Retrieves the main instance of zbfBondageShell
; 
zbfBondageShell Function GetApi() Global
	Return zbfUtil.GetGenericForm(0x020137E6) As zbfBondageShell
EndFunction


; @section: Ai
; 
; Use RetainAi to increase reference count and bring the player under ai control. Use ReleaseAi to release ai control. If 
; the ai ref ends up at zero, then ai control is released.
;
; This system allows multiple modules to request ai control of the player, without stepping on each other's toes. Make sure to 
; match each call to retain to a call to release, or control will not be released.
;
Int iAiRef = 0

; Ai reference counter, start ai control
Function RetainAi()
	iAiRef += 1
	Game.SetPlayerAiDriven(true)
EndFunction

; Ai reference counter, release ai control
Function ReleaseAi()
	If iAiRef > 1
		iAiRef -= 1
	Else
		Game.SetPlayerAiDriven(false)
		iAiRef = 0
	EndIf
EndFunction

; Returns the ai reference counter
Int Function GetAiRef()
	Return iAiRef
EndFunction


; @section: Animation
;
; The purpose of this set of functions is to use the promoted idles to set up animation names and allow a mod to 
; play animations based on applied bindings without having to micro manage the details.
; 
; In order to do this, animations events are constructed dynamically based on a set of rules. Since animation names
; are called something similar to "ZapWriOffset01", where the "Wri" part is the one we want to replace, it's quite
; easy to set up animations event names in runtime. See ::GetAnimationName and in particular it's implementation for
; a better description.
; 
; This set of functions set up a framework with enums and so on, for animation names.
; 

; @name: EnumBindType
; 
; These are used in a lot of places to identify the type of bindings applied to an actor. Typically these will control the
; animations played; SexLab animations, offsets, that can be played, and so on.
; 
; Order of these items is due to legacy reasons, and at all times the properties must be used, except for the case of <0, which is sure
; to be defined as "unbound".
; 
Int Property iBindWrists = 1 AutoReadOnly
Int Property iBindArmbinder = 5 AutoReadOnly
Int Property iBindYoke = 7 AutoReadOnly
Int Property iBindUnbound = -1 AutoReadOnly		; No bindings identified.

; Returns the substring used for the binding type.
; 
; This functions is typically not useful to call directly. Instead call ::GetAnimationName
; to get a fully qualified animation name.
; 
; Example:  
; GetBindTypeSubString(iBindWrists) will return "Wri"  
; GetBindTypeSubString(iBindUnbound) will return ""  
; 
String Function GetBindTypeSubString(Int iBindType)
	If iBindType == iBindWrists
		Return "Wri"
	ElseIf iBindType == iBindArmbinder
		Return "Armb"
	ElseIf iBindType == iBindYoke
		Return "Yoke"
	EndIf
	Return "" ; iBindUnbound or unknown index
EndFunction

; Scans the actor for worn keywords and returns the first found type of bindings.
; 
; When zbfEffectWrist is worn, but no zbfAnimHands, then this function will return bound
; wrists. 
; 
; Example:  
; If the player is wearing an item with zbfAnimHandsArmbinder attached, then 
; GetBindTypeFromWornKeywords(Game.GetPlayer()) will return iBindArmbinder
; 
Int Function GetBindTypeFromWornKeywords(Actor akActor)
	If akActor == None
		Return iBindUnbound
	EndIf

	If akActor.WornHasKeyword(zbfAnimHands[1])
		Return iBindWrists
	ElseIf akActor.WornHasKeyword(zbfAnimHands[5])
		Return iBindArmbinder
	ElseIf akActor.WornHasKeyword(zbfAnimHands[2])
		Return iBindWrists
	ElseIf akActor.WornHasKeyword(zbfAnimHands[8])
		Return iBindWrists
	ElseIf akActor.WornHasKeyword(zbfAnimHands[7])
		Return iBindYoke
	EndIf

	; Return some kind of default value if the actor is playing the wrist offset animations.
	If akActor.WornHasKeyword(zbfEffectWrist)
		Return iBindWrists
	EndIf
	Return iBindUnbound ; Feel free to override with whatever feels right...
EndFunction

; Returns the bind type associated with the provided form.
; 
; Returns iBindUnbound if akForm is None or the item does not have zbfAnimHands keywords. Note that zbfEffectWrist is not
; enough to trigger a return value from this function.
; 
; This function should not be called on actors wearing items, but rather be used on items that the actors wear to determine
; which animations they should be playing.
; 
; Example:
; If akForm is set to zbfCuffsRope02 then iBindWrists is returned.
; 
Int Function GetBindTypeFromKeywords(Form akForm)
	If akForm == None
		Return iBindUnbound
	EndIf

	If akForm.HasKeyword(zbfAnimHands[1])
		Return iBindWrists
	ElseIf akForm.HasKeyword(zbfAnimHands[5])
		Return iBindArmbinder
	ElseIf akForm.HasKeyword(zbfAnimHands[7])
		Return iBindYoke
	ElseIf akForm.HasKeyword(zbfAnimHands[2]) || akForm.HasKeyword(zbfAnimHands[8])
		Return iBindWrists
	EndIf
	Return iBindUnbound
EndFunction

; Checks if the actor has the specified bind type equipped.
; 
; *WARNING:*  
; Note that for efficiency reasons, only the promoted animations will be matched. This means, that 
; ::HasBindType(akActor, ::GetBindTypeFromWornKeywords(akActor)) does not automatically return true.
;
Bool Function HasBindType(Actor akActor, Int iBindType)
	If iBindType == iBindWrists
		Return akActor.WornHasKeyword(zbfAnimHands[1])
	ElseIf iBindType == iBindArmbinder
		Return akActor.WornHasKeyword(zbfAnimHands[5])
	ElseIf iBindType == iBindYoke
		Return akActor.WornHasKeyword(zbfAnimHands[7])
	EndIf
	Return False
EndFunction

; @name: EnumAnimationType
; 
; Each animation has a different number of allowed indices when using with ::GetAnimationName.
; 
; Poses: 15  
; Horny: 3  
; Struggle: 15  
; Offset: 1  
; 
Int Property iAnimTypePose = 0 AutoReadOnly
Int Property iAnimTypeHorny = 1 AutoReadOnly
Int Property iAnimTypeStruggle = 2 AutoReadOnly
Int Property iAnimTypeOffset = 3 AutoReadOnly

; Returns the substring used for the animation type
; 
; Animation type is the primary classification of non-SexLab animations. See ::GetAnimationName
; for a full description of how animation names are put together.
; 
String Function GetAnimTypeSubString(Int iAnimType)
	If iAnimType == iAnimTypePose
		Return "Pose"
	ElseIf iAnimType == iAnimTypeHorny
		Return "Horny"
	ElseIf iAnimType == iAnimTypeStruggle
		Return "Struggle"
	ElseIf iAnimType == iAnimTypeOffset
		Return "Offset"
	EndIf
	Return ""
EndFunction

; Puts together a fully qualified animation name
; 
; iBindType - One of the hand binding enums (::EnumBindType)
; iAnimType - One of the animation types (::EnumAnimationType)
; iAnimIndex - Index of the animation to play (See ::EnumAnimationType for a description of the number of animations available.)
; 
; Animation names are put together by four parts mandatory substrings and one optional substring.
; Zap - Three letter identifier always present
; bindings - Type of bindings, eg. Wri, Yoke etc
; animType - Type of animation, general category. Eg. Struggle, Pose
; animIndex - There are several animations of each category. The index in this category.
; SexLab index - SexLab actor and stage index, eg. "_A2_S3" (actor 2, stage 3)
; 
; This function supports putting together the first four categories. A few examples will hopefully
; explain what an animation name looks like.
; 
; Example:  
; GetAnimationName(iBindWrists, iAnimTypeStruggle, 2) will return "ZapWriStruggle02"  
; GetAnimationName(iBindArmbinder, iAnimTypeHorny, 1) will return "ZapArmbHorny01"  
; GetAnimationName(iBindArmbinder, iAnimTypeOffset, 1) will return "ZapArmbOffset01"  
; 
String Function GetAnimationName(Int iBindType, Int iAnimType, Int iAnimIndex)
	Return "Zap" + GetBindTypeSubString(iBindType) + GetAnimTypeSubString(iAnimType) + GetAnimationIndex(iAnimIndex)
EndFunction

; @name: EnumAnimationPose
; 
; Defines a set of poses a character can take. Use these with the slotting system to automatically
; play a set of defined animations based on current bonds or furniture.
; 
; The furniture base (::iPoseFurnitureBase) is used internally for playing animation sets when the actor is locked in furniture.
; Do not specify this pose manually.
; 
Int Property iPoseStanding = 0 AutoReadOnly
Int Property iPoseKneeling = 1 AutoReadOnly
Int Property iPoseHogtie = 2 AutoReadOnly
Int Property iPoseLying = 3 AutoReadOnly
Int Property iPoseFurnitureBase = 2000 AutoReadOnly

; Retrieves a comma separated list of animations to play for the selected pose.
; 
; Some animations will occur more than once so that their relative frequency provides
; a good animation.
; 
; The various indices of the return array are different parts of the animations to play. See
; zbfSlot::SetPose for help on how to use the return values from this function.
; 
String[] Function GetPoseAnimList(Int aiPoseIndex, Int aiBindType)
	String[] anims = New String[2]

	String base = "Zap" + GetBindTypeSubString(aiBindType)
	If (aiBindType < 0)
		base = "ZapWri"		; Default to wrist bindings.
	EndIf

	If aiPoseIndex == iPoseStanding
		anims[0] = ""
		anims[1] = BuildStringList(base + "Struggle", "01,01,02,02,03,03,05")

	ElseIf aiPoseIndex == iPoseKneeling
		anims[0] = BuildStringList(base + "Pose", "07,07,07,06,08")
		anims[1] = BuildStringList(base + "Struggle", "06,07,08,06,07")

	ElseIf aiPoseIndex == iPoseHogtie
		anims[0] = BuildStringList(base + "Pose", "11,13,11")
		anims[1] = BuildStringList(base + "Struggle", "11,13")

	ElseIf aiPoseIndex == iPoseLying
		anims[0] = BuildStringList(base + "Pose", "14,15,14")
		anims[1] = BuildStringList(base + "Struggle", "14,15,15")

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCross
		anims[0] = "ZazXcross01_Loop,ZaZAPFXCII01B,ZaZAPFXCII01B,ZaZAPFXCII01B"
		anims[1] = "ZaZAPFXCII01A,ZaZAPFXCII01A,ZaZAPFXCII01A,ZazXcross01_Loop"

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePony
		base = "ZaZAPFWPA"
		anims[0] = BuildStringList(base, "3,3,3,4")
		anims[1] = BuildStringList(base, "3,4,4,4")

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureHorse
		anims[0] = "ZazWoodenHorse01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheel01
		anims[0] = "ZazWheel01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheel02
		anims[0] = "ZazWheel02_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheel03
		anims[0] = "ZazWheel03_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureMultiRestraint
		anims[0] = "ZazAPCAO301,ZazAPCAO302,ZazAPCAO303,ZazAPCAO304,ZazAPCAO305,ZazAPCAO306"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRack
		anims[0] = "ZazRack01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePillory01
		anims[0] = "ZazPillory01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePillory02
		anims[0] = "ZazAPFPillSingle01,ZazAPFPillSingle02,ZazAPFPillSingle03,ZazAPFPillSingle04,ZazAPFPillSingle05"
		anims[1] = "ZapPilloryStruggle01"

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureVStocks
		anims[0] = "ZaZAPFVS01,ZaZAPFVS02"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureMilkBound
		anims[0] = BuildStringList("ZapMilkMachinePose", "01,01,02")
		anims[1] = BuildStringList("ZapMilkMachineStruggle", "01,01,02,03,04")

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCruxRope
		anims[0] = "ZaZAPFCRL01A,ZaZAPFCRL01B,ZaZAPFCRL01C"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCruxNails
		anims[0] = "ZaZAPFCRH01A,ZaZAPFCRH01B,ZaZAPFCRH01C"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBuddedCruxHeavy
		anims[0] = "ZazBuddedCruxHeavy_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCrossBuddedTorture
		anims[0] = "ZazBuddedCruxHeavy_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCrossANails
		anims[0] = "ZazCrossA_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCrossBNails
		anims[0] = "ZazCrossB_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCrossCRope
		anims[0] = "ZazCrossC_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCrossDRope
		anims[0] = "ZazCrossD_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCrossERope
		anims[0] = "ZazCrossE_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGibbetSmallA
		anims[0] = "ZazMPGibbetSmallA_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGibbetSmallB
		anims[0] = "ZazMPGibbetSmallB_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGibbetLargeA
		anims[0] = "ZazMPGibbetLargeA_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGibbetLargeB
		anims[0] = "ZazMPGibbetLargeB_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGibbetSmallMulti
		anims[0] = "ZazGibbetSmall_Loop1"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGibbetLargeMulti
		anims[0] = "ZazGibbetLarge_Loop1"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGibbetNarrow
		anims[0] = "ZazNarrowGibbet01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGibbetMicro
		anims[0] = "zazGibbetMicroSpeciale_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBondageBag
		anims[0] = "zazBondageBag_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBodyGibbet
		anims[0] = "ZazBodyGibbet01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGlasCoffin
		anims[0] = "xCoffinGlassSleeping"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureVampireCoffinHorizontal
		anims[0] = "ZazVampireCoffinHoriz_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureVampireCoffinVertical
		anims[0] = "ZazVampireCoffinVert_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureDogsHome
		anims[0] = "ZazDogsHome_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCoffinEEP
		anims[0] = "ZazCoffin_Loop"
		anims[1] = anims[0]
		
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTortureBarrel
		anims[0] = "ZazBarrelStruggle_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCrossLightFFStill
		anims[0] = "ZaZXcrossFFSTILL_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCrossLightFFStrug
		anims[0] = "ZaZXcrossFFSTRU_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCrossLightFBStill
		anims[0] = "ZaZXcrossFBSTILL_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCrossLightFBStrug
		anims[0] = "ZaZXcrossFBSTRU_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCrossHeavyFFStrug
		anims[0] = "ZazXXLXcrossFFstruggle_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCrossHeavyFDStill
		anims[0] = "ZazXXLXcrossFDstill_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCrossHeavyFBStrug
		anims[0] = "ZazXXLXcrossFBstruggle_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXCrossHeavyFBStill
		anims[0] = "ZazXXLXcrossFBstill_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePole01
		anims[0] = "ZazAPTorturePole01_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePole02
		anims[0] = "ZazAPTorturePole02_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePole03
		anims[0] = "ZazAPTorturePole03_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePole04
		anims[0] = "ZazAPTorturePole04_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePole05
		anims[0] = "ZazAPTorturePole05_loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustom01
		anims[0] = "ZazAPTorturePoleCustom01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustom02
		anims[0] = "ZazAPTorturePoleCustom02_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustom03
		anims[0] = "ZazAPTorturePoleCustom03_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustom02BF
		anims[0] = "ZazAPTorturePoleCustom02BF_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustomBF
		anims[0] = "ZazAPTorturePoleCustom01BF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustomKneeling
		anims[0] = "ZazAPTorturePoleCustomKneeling_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustomII01
		anims[0] = "zazTorturePole01Custom_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustomII02
		anims[0] = "zazTorturePole02Custom_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustomII03
		anims[0] = "zazTorturePole03Custom_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustomII04
		anims[0] = "zazTorturePole04Custom_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTorturePoleCustomII05
		anims[0] = "zazTorturePole05Custom_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTightPostPoleBondage0
		anims[0] = "ZazTightPostPoleBondage0_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTightPostPoleBondage1
		anims[0] = "ZazTightPostPoleBondage1_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTightPostPoleBondage2
		anims[0] = "ZazTightPostPoleBondage2_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTightPostPoleBondage3
		anims[0] = "ZazTightPostPoleBondage3_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTightPostPoleBondage4
		anims[0] = "ZazTightPostPoleBondage4_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTightPostPoleBondage5
		anims[0] = "ZazTightPostPoleBondage5_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePoleBondageStandingStrug
		anims[0] = "ZazPoleBondageStandingStruggling_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePoleBondageSittingStrug
		anims[0] = "ZazPoleBondageSittingStruggling_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureUprightDown
		anims[0] = "ZazUprightDown_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChainingPole
		anims[0] = "ZazChainingPole01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRestrainedShackles01
		anims[0] = "ZazRSPP01_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRestrainedShackles02
		anims[0] = "ZazRSPP02_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRestrainedShackles03
		anims[0] = "ZazRSPP03_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRestrainedShackles04
		anims[0] = "ZazRSPP04_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRestrainedShackles05
		anims[0] = "ZazRSPP05_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRestrainedShackles06
		anims[0] = "ZazRSPP06_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWallShackleSmall
		anims[0] = "ZazzAPWallShackleSmall_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWallShackleCustom
		anims[0] = "ZazAPWallShackleCustom_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWallShackleCustomStrict
		anims[0] = "ZazAPStrictWallShacklesCustom_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWallShackleCustomHeadDownRigid
		anims[0] = "ZazShackleWallHeadDownRigid_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWallShackleCustomRigid
		anims[0] = "ZazShackleWallRigid_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWallShackleCustomImmersive
		anims[0] = "ZazWallShacklesImmersive_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChained01
		anims[0] = "ZazAPChains01_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChained02
		anims[0] = "ZazAPChains02_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChained03
		anims[0] = "ZazAPChains03_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChained04
		anims[0] = "ZazAPChains04_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChained05
		anims[0] = "ZazAPChains05_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained1
		anims[0] = "ZazChained1_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained2
		anims[0] = "ZazChained2_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained3
		anims[0] = "ZazChained3_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained4
		anims[0] = "ZazChained4_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained5
		anims[0] = "ZazChained5_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained6
		anims[0] = "ZazChained6_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained7
		anims[0] = "ZazChained7_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained8
		anims[0] = "ZazChained8_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained9
		anims[0] = "ZazChained9_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained10
		anims[0] = "ZazChained10_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained11
		anims[0] = "ZazChained11_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained12
		anims[0] = "ZazChained12_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained13
		anims[0] = "ZazChained13_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained14
		anims[0] = "ZazChained14_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureZazChained15
		anims[0] = "ZazChained15_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureShackleChainsPrison
		anims[0] = "ZazShackleChainPrison_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureShackleChainsPrisonBackFace
		anims[0] = "ZazShackleChainPrisonBF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureShackleChainsPrison2
		anims[0] = "ZazShackleChainPrison2_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureShackleChainsPrisonHeadUpsideDown
		anims[0] = "ZazShackleChainPrisonHUD_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureIronHanging
		anims[0] = "ZazIronHanging_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureHogtie01
		anims[0] = "ZazAPCHogtie01_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureHogtie02
		anims[0] = "ZazAPCHogtie02_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureHogtie03
		anims[0] = "ZazAPCHogtie03_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureHogtie04
		anims[0] = "ZazAPCHogtie04_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBitchLessonKneeling
		anims[0] = "ZazBitchLessonsKneeling_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBoundOnKnees
		anims[0] = "Zazboundknees_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBitchOnTheGround
		anims[0] = "ZazGirlStrugglingOnTheGround_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBitchWithDildo
		anims[0] = "ZazGirlStandingWithDildo_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTortureSpreader
		anims[0] = "ZazSpreadShackled_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureFuckMaschine
		anims[0] = "ZazFuckMaschine_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureFuckMaschine02
		anims[0] = "ZazFuckMaschine02_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureFuckJoyChair
		anims[0] = "ZazFuckJoyChair_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureVerticalStocksProbeFucked
		anims[0] = "ZazVerticalStocks_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureVerticalStocksXStockadeProbeFucked
		anims[0] = "ZaZAPFVS04_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTableOfSexMulti
		anims[0] = "ZazTableOfSexSpreadBack"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureVerticalStocks
		anims[0] = "ZazVerticalStocks01_Loop"
		anims[1] = anims[0]

 	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureVerticalStocks2
		anims[0] = "ZazVerticalStocks02_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied01
		anims[0] = "ZazAPTreeTied01_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied02
		anims[0] = "ZazAPTreeTied02_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied03
		anims[0] = "ZazAPTreeTied03_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied04
		anims[0] = "ZazAPTreeTied04_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied05
		anims[0] = "ZazAPTreeTied05_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied06
		anims[0] = "ZazAPTreeTied06_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied07
		anims[0] = "ZazAPTreeTied07_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied08
		anims[0] = "ZazAPTreeTied08_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeTied09
		anims[0] = "ZazAPTreeTied09_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCumCumTree
		anims[0] = "ZazCumCumTree_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCarriageWheel01
		anims[0] = "ZazCarriageWheel01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCarriageWheel02
		anims[0] = "ZazCarriageWheel02_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCarriageWheel03
		anims[0] = "ZazCarriageWheel03_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCarriageWheel04
		anims[0] = "ZazCarriageWheel04_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelSmall01
		anims[0] = "ZazWheel01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelSmall01E
		anims[0] = "ZazSmallWheel01E_Loop2"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelSmall02
		anims[0] = "ZazSmallWheel02_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelSmall02E
		anims[0] = "ZazSmallWheel02E_Loop2"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelSmall03
		anims[0] = "ZazSmallWheel03_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelSmall03E
		anims[0] = "ZazSmallWheel03E_Loop2"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelCustom01
		anims[0] = "ZazCuWheel01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelCustom02
		anims[0] = "ZazCuWheel02_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheelCustom03
		anims[0] = "ZazCuWheel03_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePilloryMulti
		anims[0] = "ZazPillorySingle01"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPonyMulti
		anims[0] = "ZazWoodenPony01"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPony01
		anims[0] = "ZazWoodenPonySingle01"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPony02
		anims[0] = "ZazWoodenPonySingle02"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPony03
		anims[0] = "ZazWoodenPonySingle03"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPony04
		anims[0] = "ZazWoodenPonySingle04"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPony05
		anims[0] = "ZazWoodenPonySingle05"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPony06
		anims[0] = "ZazWoodenPonySingle06"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPony07
		anims[0] = "ZazWoodenPonySingle07"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenPony08
		anims[0] = "ZazWoodenPonySingle08"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePilloryX
		anims[0] = "ZazXPillory_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePilloryH
		anims[0] = "ZazHpillory_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePilloryCustomSingle01
		anims[0] = "ZazPillorySingle01"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePilloryCustomSingle02
		anims[0] = "ZazPillorySingle02"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePilloryCustomSingle03
		anims[0] = "ZazPillorySingle03"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePilloryCustomSingle04
		anims[0] = "ZazPillorySingle04"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRealRack
		anims[0] = "ZazTheRealRack_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTortureRack
		anims[0] = "ZazTortureRack_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRackBackFace
		anims[0] = "ZazRack03_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRackHighFrontFace
		anims[0] = "ZazRackHighFF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRackHighBackFace
		anims[0] = "ZazRackHighFB_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRackLowFrontFace
		anims[0] = "ZazRackFlatFS_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRackLowBackFace
		anims[0] = "ZazRackFlatFB_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRackRound
		anims[0] = "ZazRackRound_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTableOfSex01
		anims[0] = "ZazTableOfSexSpreadBack"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTableOfSex02
		anims[0] = "ZazTableOfSexSpreadBelly"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTableOfSex03
		anims[0] = "ZazTableOfSexTeasing"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTableOfSex04
		anims[0] = "ZazTableOfSexChairService"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChairTied
		anims[0] = "ZazAPChairTied01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChairTied02Multi
		anims[0] = "ZazAPChairTied02_Loop1"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGirlsChair
		anims[0] = "ZazGirlsChairStruggle_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureChairSitTied
		anims[0] = "xChairSitTied"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureDoubleChairBottom
		anims[0] = "xDoubleChairBottomIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureDoubleChairTop
		anims[0] = "xDoubleChairTopIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRopeDance
		anims[0] = "xRopeDance"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureHangingChandilier
		anims[0] = "xHangingChandlierIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureImpWallShackleHanging
		anims[0] = "xImpWallShackleHanging"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBarStool
		anims[0] = "xBarstoolIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTopWheel
		anims[0] = "xTopWheelIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureSaddleRack
		anims[0] = "xSaddleRackIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePetHook
		anims[0] = "xFlashingIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureDreamcatcher
		anims[0] = "xDreamcatcherIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureSaddleFemale
		anims[0] = "xSaddleIdleFemale1"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureSaddleMale
		anims[0] = "xSaddleIdleMale1"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureSacrificalPillars
		anims[0] = "xSacrificalPillarsIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureImpChandlier
		anims[0] = "xImpChandlierIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTrophyWife
		anims[0] = "xTrophyWifeIdle"
		anims[1] = anims[0]	

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureLyingBarrel
		anims[0] = "xLyingBarrelIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCircusWheel
		anims[0] = "xCircusWheelSpin"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRuinsSacrificalTable
		anims[0] = "xRuinsSacrificalTableWaiting"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRuinsSacrificalTable2
		anims[0] = "xRuinsSacrificalTable2Waiting"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWheel
		anims[0] = "xWheelIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWaterbondageWheelIndoor
		anims[0] = "xZazWaterbondageWheelIndoorSpin"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWaterWheelMini
		anims[0] = "xWaterWheelMinSpin"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureHumanTable
		anims[0] = "xTableSmallIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRopeUp
		anims[0] = "xRopeUpIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureRopeDown
		anims[0] = "xRopeDownIdle"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureVampireSupplyHang1
		anims[0] = "xVampireSupplyHang1"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureMachineRaped
		anims[0] = "WNC_MachineRaped_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWoodenhorse
		anims[0] = "WNC_WoodenHorse_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCrucified
		anims[0] = "WNC_Crucified_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureImpaled
		anims[0] = "WNC_Impaled_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureStrappado
		anims[0] = "WNC_Strappado_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureOutdoorTableBondage01
		anims[0] = "ZazOutdoorTableBondage01_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureOutdoorXcross
		anims[0] = "ZazOutsideXcross_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureSlaveStock
		anims[0] = "ZazSlaveStockKneeling_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureStocksSittingAnklesIn
		anims[0] = "ZazAnklesInStockSittingOnTheGroundF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureStocksSittingAnklesAndWristsIn
		anims[0] = "ZazAnklesAndWristsInStockSittingOnTheGroundF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureStocksKneelingAnklesIn
		anims[0] = "ZazKneelingInStocksF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureEdgingStocks
		anims[0] = "ZazEdgingStocks_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBedBound01
		anims[0] = "ZazAPBedBound01_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBedOfSlaves
		anims[0] = "ZazBedOfSlaves_loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXBedStandingFFStrug
		anims[0] = "ZaZXBedFFSTRU_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureXBedStandingFBStrug
		anims[0] = "ZaZXBedFBSTRU_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBedBunkDownstairs
		anims[0] = "ZazBBedBound01_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBedBunkUpstairs
		anims[0] = "ZazBBedBound02_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBedBoundBackFaced
		anims[0] = "ZazBedBoundBF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBedCaressingVictim
		anims[0] = "ZazBedCaressing_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePoleDance
		anims[0] = "ZazPoleDance_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGallow
		anims[0] = "ZazGallow_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBranding
		anims[0] = "ZazAnvilOfBrandingSlaveLoop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureGarotte
		anims[0] = "ZazGarotte_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWayrestGuiloutine
		anims[0] = "ZazWayrestGuiloutine_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTortureChair
		anims[0] = "ZazTortureChair_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePyre
		anims[0] = "ZazPyre_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureFireUpThePyre
		anims[0] = "ZazFireUpTheFire_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureStruggleRope
		anims[0] = "zazStruggleRope_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWhipping
		anims[0] = "ZazWhipping_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureStraightBoundToHook
		anims[0] = "ZazStraightTiedUpGettingClaps_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureStandingSpanking
		anims[0] = "ZazStandingAndClapAss_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWhippingPoleFaceFront
		anims[0] = "ZazWhippingPoleStruggling_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureWhippingPoleFaceBack
		anims[0] = "ZazWhippingPoleQuietBF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureSlavePole
		anims[0] = "ZazSlavePoleStill_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBondagePoleHandsUpBehind
		anims[0] = "zazHandsUpBehindInCuffs_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureKennelBondageMulti
		anims[0] = "zazKennelBondage01_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureKennelBondageStanding
		anims[0] = "zazKennelBondage02_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureHorizontalPoleBondage
		anims[0] = "zazHorizontalPoleBondageOutdoor_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBuried
		anims[0] = "zazBuried_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureJailStockSitting
		anims[0] = "zazJailStockSitting_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBondagePoleHandsUpToFront
		anims[0] = "zazPoleBondageHandsUpToFront_Loop"
		anims[1] = anims[0]


	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePoleBondageHandsOverHeadFrontLegsStill
		anims[0] = "zazPoleBondageHandsOverHeadFrontLegsStill_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePoleBondageHandsOverHeadFrontWithLegsWork
		anims[0] = "zazPoleBondageHandsOverHeadFrontWithLegsWork_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurniturePoleBondageHandsOverHeadBackWithLegsWork
		anims[0] = "zazPoleBondageHandsOverHeadBackWithLegsWork_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureBondagePoleHandsUpHighBehind
		anims[0] = "zazBondagePoleHandsUpBehind_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureCruxMini
		anims[0] = "zazCruxMini_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeBondageYStandingStruggling
		anims[0] = "zazTreeBondageYStandingStruggling_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureTreeBondageYStandingStrugglingBF
		anims[0] = "zazTreeBondageYStandingStrugglingBF_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureFantasyGlassCoffinStanding
		anims[0] = "zazFantasyGlassCoffinMasturbating_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureStrugglingStandingTied
		anims[0] = "zazStrugglingStandingTied_Loop"
		anims[1] = anims[0]
	
	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureEmmaMayKneeling
		anims[0] = "zazEmmaMayPole_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureEmmaMayHanging
		anims[0] = "zazEmmaMayHangingStruggling_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureEmmaMayStanding
		anims[0] = "zazEmmaMayStandingStruggling_Loop"
		anims[1] = anims[0]

	ElseIf aiPoseIndex == iPoseFurnitureBase + iFurnitureDeviousSleep
		anims[0] = "zazDeviousSleep_Loop"
		anims[1] = anims[0]


	EndIf

	Return anims
EndFunction

; Moves an object (usually marker) to the interaction location for a piece of furniture.
; 
; This function can tell an npc where to stand for interacting with the player, for instance. As an example, the
; pillory usually wants the npc to stand behind the player for interactions. The x-cross would want the npc to stand in
; front of the player.
; 
; Offset is used to further change the distance.
; 
Function MoveToInteraction(Int aiIndex, ObjectReference akObject, ObjectReference akFurniture, Float afOffset = 0.0)
	Float distance = 100.0 + afOffset
	Float angle = 0.0

	If aiIndex == iFurniturePillory01 || aiIndex == iFurniturePillory02
		angle = 180.0
	EndIf

	; Pony, Horse, Vertical Stocks, Crux
	If aiIndex == iFurniturePony || aiIndex == iFurnitureHorse || aiIndex == iFurnitureVStocks || aiIndex == iFurnitureCruxRope || aiIndex == iFurnitureCruxNails
		distance += 50.0
	EndIf

	zbfUtil.PlaceRelative(akObject, akFurniture, distance + 100.0, afAngle = angle)
	zbfUtil.FaceObject(akObject, akFurniture)
EndFunction

Int Property iFurnitureUnknown = 0 AutoReadOnly Hidden
Int Property iFurnitureXCross = 1 AutoReadOnly Hidden
Int Property iFurniturePony = 2 AutoReadOnly Hidden
Int Property iFurnitureHorse = 3 AutoReadOnly Hidden
Int Property iFurnitureWheel01 = 4 AutoReadOnly Hidden
Int Property iFurnitureWheel02 = 5 AutoReadOnly Hidden
Int Property iFurnitureWheel03 = 6 AutoReadOnly Hidden
Int Property iFurnitureMultiRestraint = 7 AutoReadOnly Hidden
Int Property iFurnitureRack = 8 AutoReadOnly Hidden
Int Property iFurniturePillory01 = 9 AutoReadOnly Hidden
Int Property iFurniturePillory02 = 10 AutoReadOnly Hidden
Int Property iFurnitureVStocks = 11 AutoReadOnly Hidden
Int Property iFurnitureMilkBound = 12 AutoReadOnly Hidden
Int Property iFurnitureCruxRope = 13 AutoReadOnly Hidden
Int Property iFurnitureCruxNails = 14 AutoReadOnly Hidden
Int Property iFurnitureBuddedCruxHeavy = 15 AutoReadOnly Hidden
Int Property iFurnitureCrossBuddedTorture = 16 AutoReadOnly Hidden
Int Property iFurnitureCrossANails = 17 AutoReadOnly Hidden
Int Property iFurnitureCrossBNails = 18 AutoReadOnly Hidden
Int Property iFurnitureCrossCRope = 19 AutoReadOnly Hidden
Int Property iFurnitureCrossDRope = 20 AutoReadOnly Hidden
Int Property iFurnitureCrossERope = 21 AutoReadOnly Hidden
Int Property iFurnitureGibbetSmallA = 22 AutoReadOnly Hidden
Int Property iFurnitureGibbetSmallB = 23 AutoReadOnly Hidden
Int Property iFurnitureGibbetLargeA = 24 AutoReadOnly Hidden
Int Property iFurnitureGibbetLargeB = 25 AutoReadOnly Hidden
Int Property iFurnitureGibbetSmallMulti = 26 AutoReadOnly Hidden
Int Property iFurnitureGibbetLargeMulti = 27 AutoReadOnly Hidden
Int Property iFurnitureGibbetNarrow = 28 AutoReadOnly Hidden
Int Property iFurnitureGibbetMicro = 29 AutoReadOnly Hidden
Int Property iFurnitureBondageBag = 30 AutoReadOnly Hidden
Int Property iFurnitureBodyGibbet = 31 AutoReadOnly Hidden
Int Property iFurnitureGlasCoffin = 32 AutoReadOnly Hidden
Int Property iFurnitureVampireCoffinHorizontal = 33 AutoReadOnly Hidden
Int Property iFurnitureVampireCoffinVertical = 34 AutoReadOnly Hidden
Int Property iFurnitureDogsHome = 35 AutoReadOnly Hidden
Int Property iFurnitureCoffinEEP = 36 AutoReadOnly Hidden
Int Property iFurnitureTortureBarrel = 37 AutoReadOnly Hidden
Int Property iFurnitureXCrossLightFFStill = 38 AutoReadOnly Hidden
Int Property iFurnitureXCrossLightFFStrug = 39 AutoReadOnly Hidden
Int Property iFurnitureXCrossLightFBStill = 40 AutoReadOnly Hidden
Int Property iFurnitureXCrossLightFBStrug = 41 AutoReadOnly Hidden
Int Property iFurnitureXCrossHeavyFFStrug = 42 AutoReadOnly Hidden
Int Property iFurnitureXCrossHeavyFDStill = 43 AutoReadOnly Hidden
Int Property iFurnitureXCrossHeavyFBStrug = 44 AutoReadOnly Hidden
Int Property iFurnitureXCrossHeavyFBStill = 45 AutoReadOnly Hidden
Int Property iFurnitureTorturePole01 = 46 AutoReadOnly Hidden
Int Property iFurnitureTorturePole02 = 47 AutoReadOnly Hidden
Int Property iFurnitureTorturePole03 = 48 AutoReadOnly Hidden
Int Property iFurnitureTorturePole04 = 49 AutoReadOnly Hidden
Int Property iFurnitureTorturePole05 = 50 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustom01 = 51 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustom02 = 52 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustom03 = 53 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustom02BF = 54 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustomBF = 55 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustomKneeling = 56 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustomII01 = 57 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustomII02 = 58 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustomII03 = 59 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustomII04 = 60 AutoReadOnly Hidden
Int Property iFurnitureTorturePoleCustomII05 = 61 AutoReadOnly Hidden
Int Property iFurnitureTightPostPoleBondage0 = 62 AutoReadOnly Hidden
Int Property iFurnitureTightPostPoleBondage1 = 63 AutoReadOnly Hidden
Int Property iFurnitureTightPostPoleBondage2 = 64 AutoReadOnly Hidden
Int Property iFurnitureTightPostPoleBondage3 = 65 AutoReadOnly Hidden
Int Property iFurnitureTightPostPoleBondage4 = 66 AutoReadOnly Hidden
Int Property iFurnitureTightPostPoleBondage5 = 67 AutoReadOnly Hidden
Int Property iFurniturePoleBondageStandingStrug = 68 AutoReadOnly Hidden
Int Property iFurniturePoleBondageSittingStrug = 69 AutoReadOnly Hidden
Int Property iFurnitureUprightDown = 70 AutoReadOnly Hidden
Int Property iFurnitureChainingPole = 71 AutoReadOnly Hidden
Int Property iFurnitureRestrainedShackles01 = 72 AutoReadOnly Hidden
Int Property iFurnitureRestrainedShackles02 = 73 AutoReadOnly Hidden
Int Property iFurnitureRestrainedShackles03 = 74 AutoReadOnly Hidden
Int Property iFurnitureRestrainedShackles04 = 75 AutoReadOnly Hidden
Int Property iFurnitureRestrainedShackles05 = 76 AutoReadOnly Hidden
Int Property iFurnitureRestrainedShackles06 = 77 AutoReadOnly Hidden
Int Property iFurnitureWallShackleSmall = 78 AutoReadOnly Hidden
Int Property iFurnitureWallShackleCustom = 79 AutoReadOnly Hidden
Int Property iFurnitureWallShackleCustomStrict = 80 AutoReadOnly Hidden
Int Property iFurnitureWallShackleCustomHeadDownRigid = 81 AutoReadOnly Hidden
Int Property iFurnitureWallShackleCustomRigid = 82 AutoReadOnly Hidden
Int Property iFurnitureWallShackleCustomImmersive = 83 AutoReadOnly Hidden
Int Property iFurnitureChained01 = 84 AutoReadOnly Hidden
Int Property iFurnitureChained02 = 85 AutoReadOnly Hidden
Int Property iFurnitureChained03 = 86 AutoReadOnly Hidden
Int Property iFurnitureChained04 = 87 AutoReadOnly Hidden
Int Property iFurnitureChained05 = 88 AutoReadOnly Hidden
Int Property iFurnitureZazChained1 = 89 AutoReadOnly Hidden
Int Property iFurnitureZazChained2 = 90 AutoReadOnly Hidden
Int Property iFurnitureZazChained3 = 91 AutoReadOnly Hidden
Int Property iFurnitureZazChained4 = 92 AutoReadOnly Hidden
Int Property iFurnitureZazChained5 = 93 AutoReadOnly Hidden
Int Property iFurnitureZazChained6 = 94 AutoReadOnly Hidden
Int Property iFurnitureZazChained7 = 95 AutoReadOnly Hidden
Int Property iFurnitureZazChained8 = 96 AutoReadOnly Hidden
Int Property iFurnitureZazChained9 = 97 AutoReadOnly Hidden
Int Property iFurnitureZazChained10 = 98 AutoReadOnly Hidden
Int Property iFurnitureZazChained11 = 99 AutoReadOnly Hidden
Int Property iFurnitureZazChained12 = 100 AutoReadOnly Hidden
Int Property iFurnitureZazChained13 = 101 AutoReadOnly Hidden
Int Property iFurnitureZazChained14 = 102 AutoReadOnly Hidden
Int Property iFurnitureZazChained15 = 103 AutoReadOnly Hidden
Int Property iFurnitureShackleChainsPrison = 104 AutoReadOnly Hidden
Int Property iFurnitureShackleChainsPrisonBackFace = 105 AutoReadOnly Hidden
Int Property iFurnitureShackleChainsPrison2 = 106 AutoReadOnly Hidden
Int Property iFurnitureShackleChainsPrisonHeadUpsideDown = 107 AutoReadOnly Hidden
Int Property iFurnitureIronHanging = 108 AutoReadOnly Hidden
Int Property iFurnitureHogtie01 = 109 AutoReadOnly Hidden
Int Property iFurnitureHogtie02 = 110 AutoReadOnly Hidden
Int Property iFurnitureHogtie03 = 111 AutoReadOnly Hidden
Int Property iFurnitureHogtie04 = 112 AutoReadOnly Hidden
Int Property iFurnitureBitchLessonKneeling = 113 AutoReadOnly Hidden
Int Property iFurnitureBoundOnKnees = 114 AutoReadOnly Hidden
Int Property iFurnitureBitchOnTheGround = 115 AutoReadOnly Hidden
Int Property iFurnitureBitchWithDildo = 116 AutoReadOnly Hidden
Int Property iFurnitureTortureSpreader = 117 AutoReadOnly Hidden
Int Property iFurnitureFuckMaschine = 118 AutoReadOnly Hidden
Int Property iFurnitureFuckMaschine02 = 119 AutoReadOnly Hidden
Int Property iFurnitureFuckJoyChair = 120 AutoReadOnly Hidden
Int Property iFurnitureVerticalStocksProbeFucked = 121 AutoReadOnly Hidden
Int Property iFurnitureVerticalStocksXStockadeProbeFucked = 122 AutoReadOnly Hidden
Int Property iFurnitureTableOfSexMulti = 123 AutoReadOnly Hidden
Int Property iFurnitureVerticalStocks = 124 AutoReadOnly Hidden
Int Property iFurnitureVerticalStocks2 = 125 AutoReadOnly Hidden
Int Property iFurnitureTreeTied01 = 126 AutoReadOnly Hidden
Int Property iFurnitureTreeTied02 = 127 AutoReadOnly Hidden
Int Property iFurnitureTreeTied03 = 128 AutoReadOnly Hidden
Int Property iFurnitureTreeTied04 = 129 AutoReadOnly Hidden
Int Property iFurnitureTreeTied05 = 130 AutoReadOnly Hidden
Int Property iFurnitureTreeTied06 = 131 AutoReadOnly Hidden
Int Property iFurnitureTreeTied07 = 132 AutoReadOnly Hidden
Int Property iFurnitureTreeTied08 = 133 AutoReadOnly Hidden
Int Property iFurnitureTreeTied09 = 134 AutoReadOnly Hidden
Int Property iFurnitureCumCumTree = 135 AutoReadOnly Hidden
Int Property iFurnitureCarriageWheel01 = 136 AutoReadOnly Hidden
Int Property iFurnitureCarriageWheel02 = 137 AutoReadOnly Hidden
Int Property iFurnitureCarriageWheel03 = 138 AutoReadOnly Hidden
Int Property iFurnitureCarriageWheel04 = 139 AutoReadOnly Hidden
Int Property iFurnitureWheelSmall01 = 140 AutoReadOnly Hidden
Int Property iFurnitureWheelSmall01E = 141 AutoReadOnly Hidden
Int Property iFurnitureWheelSmall02 = 142 AutoReadOnly Hidden
Int Property iFurnitureWheelSmall02E = 143 AutoReadOnly Hidden
Int Property iFurnitureWheelSmall03 = 144 AutoReadOnly Hidden
Int Property iFurnitureWheelSmall03E = 145 AutoReadOnly Hidden
Int Property iFurnitureWheelCustom01 = 146 AutoReadOnly Hidden
Int Property iFurnitureWheelCustom02 = 147 AutoReadOnly Hidden
Int Property iFurnitureWheelCustom03 = 148 AutoReadOnly Hidden
Int Property iFurniturePilloryMulti = 149 AutoReadOnly Hidden
Int Property iFurnitureWoodenPonyMulti = 150 AutoReadOnly Hidden
Int Property iFurnitureWoodenPony01 = 151 AutoReadOnly Hidden
Int Property iFurnitureWoodenPony02 = 152 AutoReadOnly Hidden
Int Property iFurnitureWoodenPony03 = 153 AutoReadOnly Hidden
Int Property iFurnitureWoodenPony04 = 154 AutoReadOnly Hidden
Int Property iFurnitureWoodenPony05 = 155 AutoReadOnly Hidden
Int Property iFurnitureWoodenPony06 = 156 AutoReadOnly Hidden
Int Property iFurnitureWoodenPony07 = 157 AutoReadOnly Hidden
Int Property iFurnitureWoodenPony08 = 158 AutoReadOnly Hidden
Int Property iFurniturePilloryX = 159 AutoReadOnly Hidden
Int Property iFurniturePilloryH = 160 AutoReadOnly Hidden
Int Property iFurniturePilloryCustomSingle01 = 161 AutoReadOnly Hidden
Int Property iFurniturePilloryCustomSingle02 = 162 AutoReadOnly Hidden
Int Property iFurniturePilloryCustomSingle03 = 163 AutoReadOnly Hidden
Int Property iFurniturePilloryCustomSingle04 = 164 AutoReadOnly Hidden
Int Property iFurnitureRealRack = 165 AutoReadOnly Hidden
Int Property iFurnitureTortureRack = 166 AutoReadOnly Hidden
Int Property iFurnitureRackBackFace = 167 AutoReadOnly Hidden
Int Property iFurnitureRackHighFrontFace = 168 AutoReadOnly Hidden
Int Property iFurnitureRackHighBackFace = 169 AutoReadOnly Hidden
Int Property iFurnitureRackLowFrontFace = 170 AutoReadOnly Hidden
Int Property iFurnitureRackLowBackFace = 171 AutoReadOnly Hidden
Int Property iFurnitureRackRound = 172 AutoReadOnly Hidden
Int Property iFurnitureTableOfSex01 = 173 AutoReadOnly Hidden
Int Property iFurnitureTableOfSex02 = 174 AutoReadOnly Hidden
Int Property iFurnitureTableOfSex03 = 175 AutoReadOnly Hidden
Int Property iFurnitureTableOfSex04 = 176 AutoReadOnly Hidden
Int Property iFurnitureChairTied = 177 AutoReadOnly Hidden
Int Property iFurnitureChairTied02Multi = 178 AutoReadOnly Hidden
Int Property iFurnitureGirlsChair = 179 AutoReadOnly Hidden
Int Property iFurnitureChairSitTied = 180 AutoReadOnly Hidden
Int Property iFurnitureDoubleChairBottom = 181 AutoReadOnly Hidden
Int Property iFurnitureDoubleChairTop = 182 AutoReadOnly Hidden
Int Property iFurnitureRopeDance = 183 AutoReadOnly Hidden
Int Property iFurnitureHangingChandilier = 184 AutoReadOnly Hidden
Int Property iFurnitureImpWallShackleHanging = 185 AutoReadOnly Hidden
Int Property iFurnitureBarStool = 186 AutoReadOnly Hidden
Int Property iFurnitureTopWheel = 187 AutoReadOnly Hidden
Int Property iFurnitureSaddleRack = 188 AutoReadOnly Hidden
Int Property iFurniturePetHook = 189 AutoReadOnly Hidden
Int Property iFurnitureDreamcatcher = 190 AutoReadOnly Hidden
Int Property iFurnitureSaddleFemale = 191 AutoReadOnly Hidden
Int Property iFurnitureSaddleMale = 192 AutoReadOnly Hidden
Int Property iFurnitureSacrificalPillars = 193 AutoReadOnly Hidden
Int Property iFurnitureImpChandlier = 194 AutoReadOnly Hidden
Int Property iFurnitureTrophyWife = 195 AutoReadOnly Hidden
Int Property iFurnitureLyingBarrel = 196 AutoReadOnly Hidden
Int Property iFurnitureCircusWheel = 197 AutoReadOnly Hidden
Int Property iFurnitureRuinsSacrificalTable = 198 AutoReadOnly Hidden
Int Property iFurnitureRuinsSacrificalTable2 = 199 AutoReadOnly Hidden
Int Property iFurnitureWheel = 200 AutoReadOnly Hidden
Int Property iFurnitureWaterbondageWheelIndoor = 201 AutoReadOnly Hidden
Int Property iFurnitureWaterWheelMini = 202 AutoReadOnly Hidden
Int Property iFurnitureHumanTable = 203 AutoReadOnly Hidden
Int Property iFurnitureRopeUp = 204 AutoReadOnly Hidden
Int Property iFurnitureRopeDown = 205 AutoReadOnly Hidden
Int Property iFurnitureVampireSupplyHang1 = 206 AutoReadOnly Hidden
Int Property iFurnitureMachineRaped = 207 AutoReadOnly Hidden
Int Property iFurnitureWoodenhorse = 208 AutoReadOnly Hidden
Int Property iFurnitureCrucified = 209 AutoReadOnly Hidden
Int Property iFurnitureImpaled = 210 AutoReadOnly Hidden
Int Property iFurnitureStrappado = 211 AutoReadOnly Hidden
Int Property iFurnitureOutdoorTableBondage01 = 212 AutoReadOnly Hidden
Int Property iFurnitureOutdoorXcross = 213 AutoReadOnly Hidden
Int Property iFurnitureSlaveStock = 214 AutoReadOnly Hidden
Int Property iFurnitureStocksSittingAnklesIn = 215 AutoReadOnly Hidden
Int Property iFurnitureStocksSittingAnklesAndWristsIn = 216 AutoReadOnly Hidden
Int Property iFurnitureStocksKneelingAnklesIn = 217 AutoReadOnly Hidden
Int Property iFurnitureEdgingStocks = 218 AutoReadOnly Hidden
Int Property iFurnitureBedBound01 = 219 AutoReadOnly Hidden
Int Property iFurnitureBedOfSlaves = 220 AutoReadOnly Hidden
Int Property iFurnitureXBedStandingFFStrug = 221 AutoReadOnly Hidden
Int Property iFurnitureXBedStandingFBStrug = 222 AutoReadOnly Hidden
Int Property iFurnitureBedBunkDownstairs = 223 AutoReadOnly Hidden
Int Property iFurnitureBedBunkUpstairs = 224 AutoReadOnly Hidden
Int Property iFurnitureBedBoundBackFaced = 225 AutoReadOnly Hidden
Int Property iFurnitureBedCaressingVictim = 226 AutoReadOnly Hidden
Int Property iFurniturePoleDance = 227 AutoReadOnly Hidden
Int Property iFurnitureGallow = 228 AutoReadOnly Hidden
Int Property iFurnitureBranding = 229 AutoReadOnly Hidden
Int Property iFurnitureGarotte = 230 AutoReadOnly Hidden
Int Property iFurnitureWayrestGuiloutine = 231 AutoReadOnly Hidden
Int Property iFurnitureTortureChair = 232 AutoReadOnly Hidden
Int Property iFurniturePyre = 233 AutoReadOnly Hidden
Int Property iFurnitureFireUpThePyre = 234 AutoReadOnly Hidden
Int Property iFurnitureStruggleRope = 235 AutoReadOnly Hidden
Int Property iFurnitureWhipping = 236 AutoReadOnly Hidden
Int Property iFurnitureStraightBoundToHook = 237 AutoReadOnly Hidden
Int Property iFurnitureStandingSpanking = 238 AutoReadOnly Hidden
Int Property iFurnitureWhippingPoleFaceFront = 239 AutoReadOnly Hidden
Int Property iFurnitureWhippingPoleFaceBack = 240 AutoReadOnly Hidden
Int Property iFurnitureSlavePole = 241 AutoReadOnly Hidden
Int Property iFurnitureBondagePoleHandsUpBehind = 242 AutoReadOnly Hidden
Int Property iFurnitureKennelBondageMulti = 243 AutoReadOnly Hidden
Int Property iFurnitureKennelBondageStanding = 244 AutoReadOnly Hidden
Int Property iFurnitureHorizontalPoleBondage = 245 AutoReadOnly Hidden
Int Property iFurnitureBuried = 246 AutoReadOnly Hidden
Int Property iFurnitureJailStockSitting = 247 AutoReadOnly Hidden
Int Property iFurnitureBondagePoleHandsUpToFront = 248 AutoReadOnly Hidden
Int Property iFurniturePoleBondageHandsOverHeadFrontLegsStill = 249 AutoReadOnly Hidden
Int Property iFurniturePoleBondageHandsOverHeadFrontWithLegsWork = 250 AutoReadOnly Hidden
Int Property iFurniturePoleBondageHandsOverHeadBackWithLegsWork = 251 AutoReadOnly Hidden
Int Property iFurnitureBondagePoleHandsUpHighBehind = 252 AutoReadOnly Hidden
Int Property iFurnitureCruxMini = 253 AutoReadOnly Hidden
Int Property iFurnitureTreeBondageYStandingStruggling = 254 AutoReadOnly Hidden
Int Property iFurnitureTreeBondageYStandingStrugglingBF = 255 AutoReadOnly Hidden
Int Property iFurnitureFantasyGlassCoffinStanding = 256 AutoReadOnly Hidden
Int Property iFurnitureStrugglingStandingTied = 257 AutoReadOnly Hidden
Int Property iFurnitureEmmaMayKneeling = 258 AutoReadOnly Hidden
Int Property iFurnitureEmmaMayHanging = 259 AutoReadOnly Hidden
Int Property iFurnitureEmmaMayStanding = 260 AutoReadOnly Hidden
Int Property iFurnitureDeviousSleep = 261 AutoReadOnly Hidden

Keyword[] Property FurnitureKeywords Auto

Int Function GetFurnitureType(ObjectReference akFurniture)
	Form base = None
	If akFurniture != None
		base = akFurniture.GetBaseObject()
	EndIf
	Return FindHasKeyword(base, FurnitureKeywords, aiStart = 1, aiDefault = 0)
EndFunction



; @section: Arm animation
;
; This section contains utility functions for retrieving animations on the arms (offset animations).
; These are attached to items through use of the zbfAnimHandsX keywords.
; 

; Returns the offset Idle specified by worn keywords on the Actor.
; 
; In practice this function matches a worn keyword (eg ::zbfAnimHands01 with ZazAPOA001).
; 
Idle Function GetAnimationIdle(Actor akActor)
	Idle kIdleToPlay = zbfIdleFree

	; Retrieve an idle to play
	Int i = zbfAnimHands.Length
	While i > 1 ; Don't check 0th index
		i -= 1
		If akActor.WornHasKeyword(zbfAnimHands[i])
			Return HandsBoundIdles[i]
		EndIf
	EndWhile
	Return kIdleToPlay
EndFunction

; Retrieves the offset animation connected to the specified item
; 
String Function GetArmAnimFromKeywords(Form akItem)
	Int found = FindHasKeyword(akItem, zbfAnimHands, aiStart = 1)
	If found == -1
		Return ""
	EndIf

	If found > 10
		Return "ZazAPOA0" + found
	EndIf
	Return "ZazAPOA00" + found
EndFunction

; Retrieves the offset animation worn on the actor
; 
String Function GetArmAnimFromWornKeywords(Actor akActor)
	Int found = FindWornHasKeyword(akActor, zbfAnimHands, aiStart = 1)
	If found == -1
		Return ""
	EndIf

	If found > 10
		Return "ZazAPOA0" + found
	EndIf
	Return "ZazAPOA00" + found
EndFunction


; @section: Leg effects
;
; Small section to help with mouth and expression control.
; 
Float Function GetSpeedFromWornKeywords(Actor akActor)
	If akActor.WornHasKeyword(zbfEffectSlowMove)
		Return zbfSettingSpeedMult.GetValue()
	EndIf
	Return 100.0
EndFunction
Float Function GetSpeedFromKeywords(Form akItem)
	If akItem.HasKeyword(zbfEffectSlowMove)
		Return zbfSettingSpeedMult.GetValue()
	EndIf
	Return 100.0
EndFunction


; @section: Expressions
;
; Small section to help with mouth and expression control.
; 

; @name: EnumMouthAnimType
; 
Int Property iMouthAnimNone = 0 AutoReadOnly Hidden
Int Property iMouthAnimOpen = 1 AutoReadOnly Hidden		; Open using phoneme (default)
Int Property iMouthAnimKhajiitPlug = 2 AutoReadOnly Hidden
Int Property iMouthAnimShout = 3 AutoReadOnly Hidden	; Legacy shout system

; @name: EnumRaceType
; 
Int Property iRaceUndefined = -1 AutoReadOnly Hidden
Int Property iRaceHumanOrElf = 0 AutoReadOnly Hidden
Int Property iRaceKhajiit = 1 AutoReadOnly Hidden
Int Property iRaceArgonian = 2 AutoReadOnly Hidden
Int Property iRaceOrc = 3 AutoReadOnly Hidden

; Function to retrieve a ::EnumRaceType
; 
; Used to figure out how to animate the face (open mouth, usually) since that depends on the racce.
; 
Int Function GetRaceType(Actor akActor)
	Race currentRace = akActor.GetRace()
	If currentRace == Race.GetRace("KhajiitRace")
		Return iRaceKhajiit
	ElseIf currentRace == Race.GetRace("ArgonianRace")
		Return iRaceArgonian
	ElseIf currentRace == Race.GetRace("OrcRace")
		Return iRaceOrc
	EndIf

	Return iRaceHumanOrElf
EndFunction

; Returns the mouth animation defined by keywords on the form sent to this function.
; 
; Gags default to an open mouth. See ::EnumMouthAnimType for a list of animations.
; 
Int Function GetMouthAnimFromKeywords(Form akForm)
	Return MapHasKeywordToInt(akForm, zbfAnimMouth, zbfAnimMouthMap, aiDefault = iMouthAnimNone)
EndFunction

; Returns the mouth animation defined by keywords on the form sent to this function.
; 
; Gags default to an open mouth. See ::EnumMouthAnimType for a list of animations.
; 
Int Function GetMouthAnimFromWornKeywords(Actor akWearer)
	Return MapWornHasKeywordToInt(akWearer, zbfAnimMouth, zbfAnimMouthMap, aiDefault = iMouthAnimNone)
EndFunction

; Applies the specified mouth animation to the actor.
; 
; This function is meant to be called together with other functions to set expressions, and will not clear
; any set expression values it does not override.
; 
; aiAnimation takes an ::EnumMouthAnimType as input.
; 
; aiRace is set to any of the values in ::EnumRaceType. Use ::iRaceUndefined to auto detect.
; 
Function SetMouthAnimation(Actor akActor, Int aiAnimation, Int aiRace = -1)
	Int foundRace = aiRace
	If foundRace <= iRaceUndefined
		foundRace = GetRaceType(akActor)
	EndIf

	If aiAnimation == iMouthAnimNone
		; No action

	ElseIf aiAnimation == iMouthAnimOpen
		If (foundRace == iRaceKhajiit) || (foundRace == iRaceArgonian)
			MfgConsoleFunc.SetPhoneme(akActor, 1, 50)
			MfgConsoleFunc.SetPhoneme(akActor, 11, 70)

		Else	; humans and elves
			MfgConsoleFunc.SetPhoneme(akActor, 1, 100)
			MfgConsoleFunc.SetPhoneme(akActor, 11, 70)

		EndIf

	ElseIf aiAnimation == iMouthAnimShout
		akActor.SetExpressionOverride(aiMood = 16, aiStrength = 100)

	ElseIf aiAnimation == iMouthAnimKhajiitPlug
		MfgConsoleFunc.SetPhoneme(akActor, 1, 10)
		MfgConsoleFunc.SetPhoneme(akActor, 11, 20)

	EndIf
EndFunction

; @name: EnumFaceAnimType
; 
Int Property iFaceAnimNone = 0 AutoReadOnly Hidden
Int Property iFaceAnimFear = 1 AutoReadOnly Hidden
Int Property iFaceAnimHappy = 2 AutoReadOnly Hidden
Int Property iFaceAnimAngry = 3 AutoReadOnly Hidden
Int Property iFaceAnimShy = 4 AutoReadOnly Hidden

; Applies face animation to the actor
; 
; This function will not reset expressions, so they will have to be cleared outside this function
; before calling. This is to make sure that it will interact correctly with ::SetMouthAnim
; 
Function SetFaceAnimation(Actor akActor, Int aiAnimation, Int aiStrength, Int aiRace = -1)
	; aiRace is not used atm

	If aiAnimation == iFaceAnimNone
		; No action

	ElseIf aiAnimation == iFaceAnimFear
		akActor.SetExpressionOverride(9, ExprScaler(80, aiStrength))

		MfgConsoleFunc.SetModifier(akActor, 2, ExprScaler(50, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 3, ExprScaler(50, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 4, ExprScaler(50, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 5, ExprScaler(50, aiStrength))
		;MfgConsoleFunc.SetModifier(akActor, 11, ExprScaler(90, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 12, ExprScaler(40, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 13, ExprScaler(40, aiStrength))

		MfgConsoleFunc.SetPhoneme(akActor, 0, ExprScaler(30, aiStrength))
		MfgConsoleFunc.SetPhoneme(akActor, 2, ExprScaler(30, aiStrength))

	ElseIf aiAnimation == iFaceAnimHappy
		akActor.SetExpressionOverride(2, ExprScaler(80, aiStrength))

		MfgConsoleFunc.SetModifier(akActor, 12, ExprScaler(80, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 13, ExprScaler(80, aiStrength))

		MfgConsoleFunc.SetPhoneme(akActor, 5, ExprScaler(50, aiStrength))
		MfgConsoleFunc.SetPhoneme(akActor, 11, ExprScaler(60, aiStrength))

	ElseIf aiAnimation == iFaceAnimAngry
		akActor.SetExpressionOverride(0, ExprScaler(100, aiStrength))

		MfgConsoleFunc.SetModifier(akActor, 12, ExprScaler(65, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 13, ExprScaler(65, aiStrength))

		MfgConsoleFunc.SetPhoneme(akActor, 3, ExprScaler(40, aiStrength))
		MfgConsoleFunc.SetPhoneme(akActor, 4, ExprScaler(50, aiStrength))

	ElseIf aiAnimation == iFaceAnimShy
		akActor.SetExpressionOverride(3, ExprScaler(50, aiStrength))

		MfgConsoleFunc.SetModifier(akActor, 8, ExprScaler(50, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 9, ExprScaler(40, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 12, ExprScaler(30, aiStrength))
		MfgConsoleFunc.SetModifier(akActor, 13, ExprScaler(30, aiStrength))

		MfgConsoleFunc.SetPhoneme(akActor, 5,  ExprScaler(10, aiStrength))
		MfgConsoleFunc.SetPhoneme(akActor, 6,  ExprScaler(10, aiStrength))

	EndIf
EndFunction
Int Function ExprScaler(Int aiMax, Int aiLevel)
	Return (aiMax * aiLevel) / 100
EndFunction


; @section: SexLab
;
; These functions are all helper functions for SexLab to do its stuff.
; 

; Returns the SexLab animation tag connected to the bind type
; 
; *DEPRECATED!* Function is deprecated. Use the similar function in zbfSexLab.psc. Function will eventually get removed.
; 
String Function GetSexLabBoundTag(Int iBindType)
	Log("GetSexLabBoundTag", "GetSexLabBoundTag is deprecated.", iError)

	If iBindType == iBindWrists
		Return "Wrists"
	ElseIf iBindType == iBindArmbinder
		Return "Armbinder"
	ElseIf iBindType == iBindYoke
		Return "Yoke"
	EndIf
	Return ""
EndFunction

; Returns a list of required SexLab tags based on worn keywords.
; 
; *DEPRECATED!* Function is deprecated. Use the similar function in zbfSexLab.psc. Function will eventually get removed.
; 
String[] Function GetRequiredSexLabTags(Actor akActor)
	Log("GetRequiredSexLabTags", "GetRequiredSexLabTags is deprecated.", iError)
	Return zbfUtil.GetSexLab().GetRequiredTags(akActor)
EndFunction

; Returns a list of blocked SexLab tags based on worn keywords.
; 
; *DEPRECATED!* Function is deprecated. Use the similar function in zbfSexLab.psc. Function will eventually get removed.
; 
String[] Function GetBlockedSexLabTags(Actor akActor)
	Log("GetBlockedSexLabTags", "GetBlockedSexLabTags is deprecated.", iError)
	Return zbfUtil.GetSexLab().GetBlockedTags(akActor)
EndFunction

; Modifies a list of SexLab strip slots to remove the specified slots
; 
; Can be combined with vanilla SexLab strip slots to further limit stripping in custom animations.
; 
; Usually, it's best to use the functions from zbfSexLab instead. See zbfSexLab::GetDefaultStripSlots.
; 
Function ModifySexLabStripSlots(Bool[] abSlots, Bool abKeepWrists = True, Bool abKeepAnkles = True, Bool abKeepGag = True, Bool abKeepCollar = True, Bool abKeepBelt = True, Bool abKeepBlindfold = True)
	Log("ModifySexLabStripSlotsFromKeywords", "Wrists = " + abKeepWrists + ", Gag = " + abKeepGag + ", Collar = " + abKeepCollar + ", Blindfold = " + abKeepBlindfold)

	If abKeepWrists
		abSlots[59 - 30] = False
	EndIf
	If abKeepAnkles
		abSlots[53 - 30] = False
	EndIf
	If abKeepGag
		abSlots[44 - 30] = False
	EndIf
	If abKeepCollar
		abSlots[45 - 30] = False
	EndIf
	If abKeepBelt
		abSlots[49 - 30] = False
	EndIf
	If abKeepBlindfold
		abSlots[55 - 30] = False
	EndIf
EndFunction

; Automatically modifies a strip list based on worn keywords.
; 
; Usually, it's best to use the functions from zbfSexLab instead. See zbfSexLab::GetDefaultStripSlots
; and similar functions.
; 
Function ModifySexLabStripSlotsFromKeywords(Bool[] abSlots, Actor akActor)
	Log("ModifySexLabStripSlotsFromKeywords", "On actor " + akActor)

	ModifySexLabStripSlots( \
		abSlots, \
		akActor.WornHasKeyword(zbfWornWrist), \
		akActor.WornHasKeyword(zbfWornAnkles), \
		akActor.WornHasKeyword(zbfWornGag), \
		akActor.WornHasKeyword(zbfWornCollar) || akActor.WornHasKeyword(zbfWornYoke), \
		akActor.WornHasKeyword(zbfWornBelt), \
		akActor.WornHasKeyword(zbfWornBlindfold))
EndFunction

; Automatically fetches a list of SexLab strip slots.
; 
; Does not consider SexLab configuration, and will completely strip the actor of all gear.
; 
; Usually, it's best to use the functions from zbfSexLab instead. See zbfSexLab::GetDefaultStripSlots
; and similar functions.
; 
Bool[] Function GetSexLabStripSlots(Actor akActor)
	Log("GetSexLabStripSlots", "On actor " + akActor)

	Bool[] list = New Bool[33]
	Int i = list.Length
	While i > 0
		i -= 1
		list[i] = True
	EndWhile
	ModifySexLabStripSlotsFromKeywords(list, akActor)
	Return list
EndFunction

; Returns a SexLab animation name given a SexLab base entry and a bind type
; 
; Does not verify that the requested animation exists. This is also just a convenience
; wrapper so that a caller does not have to check if vanilla or ZAP animation names should
; be used.
; 
; This function will return weird (unusable) results if called with aiStage set, but aiActorIndex ignored.
; SexLab always needs _Ax_Sy defined at the end.
; 
; Base names used by ZAP should never include the _Ax_Sy prefix. Those parameter are included as a 
; convenience when it's desirable to set up specific stages manually.
; 
String Function GetSexLabAnimationName(zbfSexLabBaseEntry akEntry, Int aiBindType, Int aiActorIndex = 0, Int aiStage = 0)
	String sStageSubString = ""
	String sActorSubString = ""
	String sBase = ""

	If aiActorIndex > 0
		sActorSubString = "_" + aiActorIndex As String
	EndIf

	If aiStage > 0
		sStageSubString = "_" + aiStage As String
	EndIf

	If aiBindType >= 0
		sBase = "Zap" + GetBindTypeSubString(aiBindType) + akEntry.BaseName
	Else
		sBase = akEntry.VanillaBaseName
	EndIf

	Return sBase + sActorSubString + sStageSubString
EndFunction


; @section: Actor Control
;
; These functions are primarily used to control the player actor in various ways. Some of these
; functions are useful on other actors as well.
; 

; Marks the player as blind
; 
; Items and actors will not appear with their regular names, since the player can't
; properly see.
; 
; Perk can only bet set on the player.
; 
Perk Property zbfPerkBlind Auto
Function SetBlindPerk(Actor akActor, Bool abSet)
	SetPlayerActorPerk(akActor, zbfPerkBlind, abSet)
EndFunction

; Applies the bound perk to the actor
; 
; When used the activate control is intercepted, and instead of activating the target in the reticle, 
; an event is sent.
; Mods can listen to this event and manually trigger activation. See zbfSlot::OnZapActivateIntercept 
; for more info on this event.
; 
; Actors can still be activated but only with the "talk" option (no pick-pocket, and no looting
; dead actors).
; 
; Perk can only bet set on the player.
; 
Perk Property zbfPerkBound Auto
Function SetBoundPerk(Actor akActor, Bool abSet)
	SetPlayerActorPerk(akActor, zbfPerkBound, abSet)
EndFunction
Function SendOnActivateInterceptEvent(Actor akSource, ObjectReference akTarget) Global
	Int iHandle = ModEvent.Create("ZapActivateIntercept")
	ModEvent.PushForm(iHandle, akSource)
	ModEvent.PushForm(iHandle, akTarget)
	Bool bSent = ModEvent.Send(iHandle)
EndFunction

; Intercepts regular Talk activation on actors
; 
; Instead of starting dialogue, when the player activates the actor, an event is sent (ZapTalkIntercept).
; This event can be listened to and talking can start by calling the Activate method on the passed in 
; actor. See zbfSlot::OnZapTalkIntercept for example code.
; 
; This allows mods to handle talking when the player is gagged, by for instance, pushing the talking
; to actor in a specific faction, or set a variable to allow or disable gag talking.
; 
; In any case, zbfFactionGagAllowTalk will prevent this mechanism from running and allow regular dialogue.
; 
; Can only be called on the player.
; 
Perk Property zbfPerkGagged Auto
Function SetGaggedPerk(Actor akActor, Bool abSet)
	SetPlayerActorPerk(akActor, zbfPerkGagged, abSet)
EndFunction
Function SendOnTalkInterceptEvent(Actor akSource, ObjectReference akTarget) Global
	Int iHandle = ModEvent.Create("ZapTalkIntercept")
	ModEvent.PushForm(iHandle, akSource)
	ModEvent.PushForm(iHandle, akTarget)
	Bool bSent = ModEvent.Send(iHandle)
EndFunction

; Limit activation to actors
; 
; Limits activation to only actors. This is automatically applied to actors restrained in furniture
; by the zbfSlot::SetFurniture function. When this is applied, the only allowed action is to talk to
; other actors, and no other activation options will show up.
; 
; Can only be called on the player.
; 
Perk Property zbfPerkLimitActivation Auto
Function SetLimitedActivation(Actor akActor, Bool abSet)
	SetPlayerActorPerk(akActor, zbfPerkLimitActivation, abSet)
EndFunction

; Forces the actor to stay put.
; 
; NPC actors can't move around anymore, and so can't complete AI packages and so on (even packages, that require the target
; to stand still). This function does not disable movement controls or enable ai on the player, so that also needs to be 
; done to prevent the player from moving around.
; 
; zbfSlot::PinActor will handle corner cases (furniture etc) better for slotted actors.
; 
Function PinActor(Actor akActor)
	akActor.SetVehicle(MarkerPin)
	If akActor != PlayerRef
		akActor.SetDontMove(True)
	EndIf
EndFunction

; Releases the actor
; 
; Actor can again move around. See ::PinActor for a more thorough discussion.
; 
Function UnPinActor(Actor akActor)
	akActor.SetVehicle(None)
	If akActor != PlayerRef
		akActor.SetDontMove(False)
	EndIf
EndFunction

; Returns True if the actor is busy animating.
; 
; Anyone continuously updating idles should pause their updating as long as this function returns True.
; 
Bool Function IsBusyAnimating(Actor akActor)
	Return akActor.IsInFaction(zbfIsAnimating) || akActor.IsInFaction(zbfIsAnimatingExtra)
EndFunction

; Sets the actor as busy animating something.
; 
Function SetBusyAnimating(Actor akActor)
	akActor.AddToFaction(zbfIsAnimating)
	akActor.ModFactionRank(zbfIsAnimating, 1)
EndFunction

; Makes the actor start running regular updates again.
; 
; If several mods have requested animations to pause, then this command will just unpause a single one of those instances.
; 
Function StopBusyAnimating(Actor akActor, Int aiAmount = 1)
	If akActor.GetFactionRank(zbfIsAnimating) < 1
		akActor.RemoveFromFaction(zbfIsAnimating)
		Return
	EndIf

	akActor.ModFactionRank(zbfIsAnimating, -aiAmount) ; Otherwise just reduce rank by one
EndFunction



; @section: Effects
;
; These functions are primarily used internally to alter actor behavior or state, that is:
; play idles, change expression, etc.
; 
; Always use the api to access the effect mask. There is no guarantee that it will not change in
; the future.
; 

; Updates control settings if akActor is the player. No effect on npcs.
; 
Function ApplyPlayerControls(Actor akActor)
	If akActor != PlayerRef
		Return
	EndIf

	PlayerControl.SetDisabledControls( \
		abMovement = akActor.WornHasKeyword(zbfEffectNoMove), \
		abFighting = akActor.WornHasKeyword(zbfEffectNoFighting), \
		abSneaking = akActor.WornHasKeyword(zbfEffectNoSneak), \
		abMenu = akActor.WornHasKeyword(zbfEffectNoInventory), \
		abActivate = akActor.WornHasKeyword(zbfEffectNoActivate))
EndFunction

Function ApplyFaceModifier(Actor akActor)
	; Special handling for the shout gag effect
	If akActor.WornHasKeyword(zbfEffectOpenMouth) && akActor.WornHasKeyword(zbfAnimMouth[3])
		MfgConsoleFunc.ResetPhonemeModifier(akActor)
		Return
	EndIf
	If !akActor.WornHasKeyword(zbfEffectSetExpression)
		akActor.SetExpressionOverride(16, 1)
		akActor.ClearExpressionOverride()
		MfgConsoleFunc.ResetPhonemeModifier(akActor)
		Return
	EndIf

	Int amount = 70
	Int type = FindWornHasKeyword(akActor, zbfAnimFace, aiDefault = iFaceAnimFear)
	SetFaceAnimation(akActor, type, amount)
EndFunction

Function ApplyMouthModifier(Actor akActor)
	Int type = GetMouthAnimFromWornKeywords(akActor)

	; Clear mouth gag settings, and drop out
	If type == iMouthAnimNone
		MfgConsoleFunc.SetPhoneme(akActor, 1, 0)
		MfgConsoleFunc.SetPhoneme(akActor, 11, 0)
		Return
	EndIf

	SetMouthAnimation(akActor, type)
EndFunction

; Updates properties on the actor which relates to movement
; 
Function ApplyMovementModifiers(Actor akActor)
	;Debug.Trace("ApplyMovementModifiers "+akActor.getDisplayName()+" zbfEffectSlowMove="+akActor.WornHasKeyword(zbfEffectSlowMove))
	If akActor.WornHasKeyword(zbfEffectSlowMove)
		akActor.SetAv("SpeedMult", zbfSettingSpeedMult.GetValue())
	Else
		akActor.SetAv("SpeedMult", 100.0)
	EndIf
	akActor.ModAv("CarryWeight", -0.02)
	akActor.ModAv("CarryWeight", 0.02)
EndFunction

; Updates offset animation based on worn keywords.
; 
; Offset animations are specified with the zbfAnimHands* keywords. If multiple such keywords are worn,
; one is automatically selected.
; 
; Internally uses ::GetAnimationIdle to retrieve the idle to play.
; Will break other animations playing on the actor. This function does not check if the actor is busy animating
; something else. That condition needs to be checked elsewhere.
; 
Function ApplyOffsetIdle(Actor akActor)
	int sitState = akActor.GetSitState()
	Debug.Trace("ApplyOffsetIdle "+akActor.getDisplayName()+" zbfEffectWrist="+akActor.WornHasKeyword(zbfEffectWrist)+" sitState="+sitState)
	if  sitState == 0 || sitState == 4
		Idle kIdleToPlay = zbfIdleFree
		If akActor.WornHasKeyword(zbfEffectWrist)
			kIdleToPlay = GetAnimationIdle(akActor)
			If (kIdleToPlay == zbfIdleFree) || (kIdleToPlay == HandsBoundIdles[iBindWrists])
				kIdleToPlay = HandsBoundIdles[iDefaultBoundOffset]
			EndIf
		EndIf
		akActor.PlayIdle(kIdleToPlay)
		Debug.Trace("ApplyOffsetIdle "+akActor.getDisplayName()+" kIdleToPlay="+kIdleToPlay)
	endif
EndFunction

; Prevents magic use and shouts by forcing unequip of magic and shouts.
; 
Function ApplySilenceEffect(Actor akActor)
	If akActor.WornHasKeyword(zbfEffectNoMagic)
		Spell kSpell = akActor.GetEquippedSpell(0)
		if kSpell != None
			akActor.UnequipSpell(kSpell, 0)
		EndIf
		kSpell = akActor.GetEquippedSpell(1)
		if kSpell != None
			akActor.UnequipSpell(kSpell, 1)
		EndIf

		Shout kShout = akActor.GetEquippedShout()
		If kShout != None
			akActor.UnequipShout(kShout)
		EndIf
	EndIf
EndFunction

; Returns true if the actor is wearing items that is flagged as playing a gag moan when worn.
; 
Bool Function WornHasGagSound(Actor akActor)
	Return akActor.WornHasKeyword(zbfEffectGagSound)
EndFunction

Int Property iEffectArms = 0x01 AutoReadOnly	; Offset idles, arm animations
Int Property iEffectMouth = 0x02 AutoReadOnly		; Facial animations for gag only
Int Property iEffectPlayerControl = 0x04 AutoReadOnly	; Player control disabling
Int Property iEffectLegs = 0x08 AutoReadOnly		; Leg animations and movement speed control
Int Property iEffectSilence = 0x10 AutoReadOnly	; Force unequip magic and shout
Int Property iEffectRepeat = 0x20 AutoReadOnly	; Force repeating the animation effects
Int Property iEffectFace = 0x40 AutoReadOnly		; Facial animations for only expression (not mouth)

Int Property iEffectFullMask = 0xff AutoReadOnly	; All combined

; Returns the complete mask of keywords on the provided form.
; 
Int Function FormEffectMask(Form akForm)
	Int iPC = 0
	iPC += 0x01 * akForm.HasKeyword(zbfEffectNoMove) As Int
	iPC += 0x02 * akForm.HasKeyword(zbfEffectNoFighting) As Int
	iPC += 0x04 * akForm.HasKeyword(zbfEffectNoSneak) As Int
	iPC += 0x08 * akForm.HasKeyword(zbfEffectNoInventory) As Int
	iPC += 0x10 * akForm.HasKeyword(zbfEffectNoActivate) As Int
	Bool bHasPlayerControl = (iPC != 0)

	Int iMask = iEffectArms * (akForm.HasKeyword(zbfEffectWrist) As Int)
	iMask += iEffectMouth * (akForm.HasKeyword(zbfEffectOpenMouth) As Int)
	iMask += iEffectLegs * (akForm.HasKeyword(zbfEffectSlowMove) As Int)
	iMask += iEffectPlayerControl * (bHasPlayerControl As Int)
	iMask += iEffectSilence * (akForm.HasKeyword(zbfEffectNoMagic) As Int)
	iMask += iEffectRepeat * (akForm.HasKeyword(zbfEffectRefresh) As Int)
	iMask += iEffectFace * (akForm.HasKeyword(zbfEffectSetExpression) As Int)

	Return iMask
EndFunction

; Returns a mask of all the currently applied effects on akActor.
; 
Int Function WornEffectMask(Actor akActor)
	Bool bHasPlayerControl = (akActor == PlayerRef)

	Int iMask = 0
	iMask += iEffectArms * (akActor.WornHasKeyword(zbfEffectWrist) As Int)
	iMask += iEffectMouth * (akActor.WornHasKeyword(zbfEffectOpenMouth) As Int)
	iMask += iEffectPlayerControl * (bHasPlayerControl As Int)
	iMask += iEffectLegs * (akActor.WornHasKeyword(zbfEffectSlowMove) As Int)
	iMask += iEffectSilence * (akActor.WornHasKeyword(zbfEffectNoMagic) As Int)
	iMask += iEffectRepeat * (akActor.WornHasKeyword(zbfEffectRefresh) As Int)
	iMask += iEffectFace * (akActor.WornHasKeyword(zbfEffectSetExpression) As Int)

	Return iMask
EndFunction

; Returns a mask for the currently worn player control flags.
; 
Int Function WornPlayerControlMask(Actor akActor)
	Int iPC = 0
	iPC += 0x01 * akActor.WornHasKeyword(zbfEffectNoMove) As Int
	iPC += 0x02 * akActor.WornHasKeyword(zbfEffectNoFighting) As Int
	iPC += 0x04 * akActor.WornHasKeyword(zbfEffectNoSneak) As Int
	iPC += 0x08 * akActor.WornHasKeyword(zbfEffectNoInventory) As Int
	iPC += 0x10 * akActor.WornHasKeyword(zbfEffectNoActivate) As Int
	Return iPC
EndFunction

; Plays equipped effects on an actor.
; 
; akActor is the actor to run effects on
; aiMask specifies the set of effects to consider. See WornEffectMask.
; 
; This function DOES checks if the actor is busy animating. In that case it does not override animations with something else.
; 
Function ApplyModifiersMask(Actor akActor, Int aiMask)
	If (zbfSettingDisableEffects.GetValueInt() == 0) && !IsBusyAnimating(akActor)
		If Math.LogicalAnd(aiMask, iEffectPlayerControl)
			ApplyPlayerControls(akActor)
		EndIf

		If Math.LogicalAnd(aiMask, iEffectLegs)
			ApplyMovementModifiers(akActor)
		EndIf

		If Math.LogicalAnd(aiMask, iEffectSilence)
			ApplySilenceEffect(akActor)
		EndIf

		If Math.LogicalAnd(aiMask, iEffectFace)
			ApplyFaceModifier(akActor)
		EndIf

		If Math.LogicalAnd(aiMask, iEffectMouth)
			ApplyMouthModifier(akActor)
		EndIf

		If Math.LogicalAnd(aiMask, iEffectArms)
			ApplyOffsetIdle(akActor)
		EndIf
	EndIf
EndFunction


; @section: Sounds
;

; Returns the next time to play a gag sound based on settings and a random factor.
; 
Float Function NextGagSound()
	If bGagSoundRepeat == False
		Return Utility.GetCurrentRealTime() + 10000000.0
	EndIf

	Float fGagSoundFreqVariance = 1.5
	Return Utility.GetCurrentRealTime() + Utility.RandomFloat(1.0 / fGagSoundFreqVariance, 1.0 * fGagSoundFreqVariance) * fGagSoundFrequency
EndFunction

; Plays a random gag sound.
; 
; Uses the config menu setting to pick a sound set to play from.
; 
; This should be the go to function for playing gag moans and sounds. It honors the 
; user configuration in MCM which is what a user would expect.
; 
; akActor - Actor to play the sound from
; afVolumeMult - Extra multiplier for the volume. 1.0 is default volume, 0.5 is half volume, and so on.
; 
Function PlayGagSound(Actor akActor, Float afVolumeMult = 1.0)
	Int gender = akActor.GetLeveledActorBase().GetSex()

	If (idxGagSoundFemale > 0) && (gender == 1)
		Int iSoundHandle = PickRandomGagSoundFemale(idxGagSoundFemale).Play(akActor)
		Sound.SetInstanceVolume(iSoundHandle, afVolumeMult * fGagSoundVolume / 100.0)
	ElseIf (idxGagSoundMale > 0) && (gender == 0)
		Int iSoundHandle = PickRandomGagSoundMale(idxGagSoundMale).Play(akActor)
		Sound.SetInstanceVolume(iSoundHandle, afVolumeMult * fGagSoundVolume / 100.0)
	EndIf
EndFunction

; Returns number of available gag sound types
; 
Int Function GetGagSoundCount(Actor akActor)
	Int gender = akActor.GetLeveledActorBase().GetSex()
	If gender == 1
		Return 4
	EndIf
	Return 2
EndFunction

; Returns a "best effort" random sound to play provided a set input variable.
; 
; Specify 0 to play using the user configured set.
; 
; aiGender - Gender to get sound for (0 = male, otherwise female)
; aiSet - The sound set to retrieve.
; 
; Female sets
; 0 - Use the user config set
; 1 - Custom gag sounds (loose files, user modifiable)
; 2 - Alternative 1
; 3 - Alternative 2
; 4 - Frustrated/angry gag sounds
; 
; Male sets
; 0 - Use the user config set
; 1 - Custom gag sounds (loose files, user modifiable)
; 2 - Normal gag sounds
; 
; Note:
; The custom gag sounds should almost never be explicitly selected. This set is normally left empty, and the
; user of the mod may fill with his/her own content (or leave empty). If anything, the most common option
; should be to use the MCM selected value.
; 
; Example:
; Sound s = zbf.PickRandomGagSound(akActor.GetLeveledActorBase().GetSex(), 4) ; Retrieves a best effort frustrated/angry gag sound
; 
Sound Function PickRandomGagSound(Int aiGender, Int aiSet = 0)
	If aiGender == 0
		Return PickRandomGagSoundMale(aiSet)
	EndIf
	Return PickRandomGagSoundFemale(aiSet)
EndFunction

; Returns a random female gag sound to play provided a set input variable.
; 
; Sets:
; 0 - Use the MCM config set
; 1 - Custom gag sounds
; 2 - Alternative 1
; 3 - Alternative 2
; 4 - Frustrated/angry gag sounds
; 
Sound Function PickRandomGagSoundFemale(Int aiSet = 0)
	If aiSet == 0
		aiSet = idxGagSoundFemale ; Ooh, very naughty. Changing input parameters...!
	EndIf

	If aiSet == 2
		Return GagSoundDefault[Utility.RandomInt(0, GagSoundDefault.Length - 1)]
	ElseIf aiSet == 3
		Return GagSoundAlt[Utility.RandomInt(0, GagSoundAlt.Length - 1)]
	ElseIf aiSet == 4
		Return GagSoundFrustrated[Utility.RandomInt(0, GagSoundFrustrated.Length - 1)]
	ElseIf aiSet == 1
		Return GagSoundCustomFemale
	EndIf
	Return GagSoundSilent ; Invalid selection
EndFunction

; Returns a random sound from the specified set (for a male).
; 
; Sets:
; 0 - Use the MCM config set
; 1 - Custom gag sounds
; 2 - Basic male gag sounds
; 
Sound Function PickRandomGagSoundMale(Int aiSet = 0)
	If aiSet == 0
		aiSet = idxGagSoundMale ; Ooh, very naughty. Changing input parameters...!
	EndIf

	If aiSet == 1
		Return GagSoundCustomMale
	ElseIf aiSet == 2
		Return GagSoundMale01[Utility.RandomInt(0, GagSoundMale01.Length - 1)]
	EndIf
	Return GagSoundSilent
EndFunction

; @section: Overlays
; 
; This section contains code and constants for texture overlays on actors.
; Texture overlays are things like drool, tears, scars and dirt.
; 
; If possible, this system will use SlaveTats to do it's internal processing. If SlaveTats is not
; available, it will attempt to use the Racemenu plugins directly.
; 
; If neither module is available, overlays are not enabled.
; 

; @name: Overlay categories
; 
; These categories define the types of overlays that can be applied on actors.
; 
; Each actor can have a single overlay in each category, since they potentially share overlay slots.
; 
Int Property iOverlayCategoryTears = 0 AutoReadOnly
Int Property iOverlayCategoryDrool = 1 AutoReadOnly
Int Property iOverlayCategoryDirt = 2 AutoReadOnly
Int Property iOverlayCategoryScars = 3 AutoReadOnly

; Applies the specified overlay on the actor.
; 
; Do not call this function directly. Instead use the various utility functions: ::SetOverlayTears, for instance.
; 
Function SetOverlayGeneric(Actor akActor, String asName, String asSection, String asPrevious)
	If asPrevious != asName
		Log("SetOverlayGeneric", "Applying texture overlay, switching from (" + asPrevious + ") to (" + asName + ") on section (" + asSection + ").")
		External.RemoveOverlay(akActor, asPrevious, asSection)
		External.SetOverlay(akActor, asName, asSection)
	EndIf
EndFunction

; Retrieves overlay data
; 
; This data format is packed in a way that may change during development.
; 
; Do not rely on this function providing consistent results across versions. Instead
; use the provided utility functions to access information: ::GetOverlaySection, ::GetOverlayName.
; 
String[] Property sOverlayDataTears Auto
String[] Property sOverlayDataDrool Auto
String[] Property sOverlayDataDirt Auto
String[] Property sOverlayDataScars Auto
String[] Function GetOverlayData(Int aiCategory)
	String[] base = New String[1]
	If aiCategory == iOverlayCategoryTears
		base = sOverlayDataTears
	ElseIf aiCategory == iOverlayCategoryDrool
		base = sOverlayDataDrool
	ElseIf aiCategory == iOverlayCategoryDirt
		base = sOverlayDataDirt
	ElseIf aiCategory == iOverlayCategoryScars
		base = sOverlayDataScars
	EndIf
	Return base
EndFunction

String Function GetOverlaySection(Int aiCategory)
	String[] base = GetOverlayData(aiCategory)
	return base[0]
EndFunction

String Function GetOverlayName(Int aiCategory, Int aiIndex)
	String[] names = GetOverlayData(aiCategory)

	; Index 0 is the "section", then comes the names packed.
	If aiIndex <= 0 || aiIndex >= names.Length
		Return ""
	EndIf
	Return names[aiIndex]
EndFunction

Int Function GetOverlayCount(Int aiCategory)
	String[] base = GetOverlayData(aiCategory)
	Return base.Length - 1
EndFunction



; @section: Misc
;

; Returns the update interval for the character
; 
; In the future, the update interval can be different for player and npc characters.
; Use this function instead of the deprecated older function.
Float Function GetUpdateIntervalForActor(Actor akActor)
	If akActor == PlayerRef
		Return fUpdateIntervalPlayer
	EndIf
	Return fUpdateIntervalNpc
EndFunction


; @section: Slots
; 
; Functions related to placing the actor in a slot for constant bondage effects and better api control.
; 

; Returns the player slot. The player is always slotted, so this function always returns a result.
; 
zbfSlot Function FindPlayer()
	Return PlayerSlot
EndFunction

; Finds the slot for the specified actor, or None if the Actor is not slotted.
; 
zbfSlot Function FindSlot(Actor akActor)
	If akActor == PlayerRef
		Return PlayerSlot
	EndIf
	Return FindSlotHelper(Slots, akActor)
EndFunction

; Slots the Actor and returns the Actor slot. If the Actor is already slotted, this function just
; returns the current actor slot.
; 
zbfSlot Function SlotActor(Actor akActor)
	If akActor == PlayerRef
		Return PlayerSlot
	EndIf
	Return SlotActorHelper(Slots, akActor)
EndFunction

; Unslots the actor. Does nothing on the Player, since the player is always slotted.
; 
Function UnSlotActor(Actor akActor)
	If akActor == PlayerRef
		Return
	EndIf
	UnslotActorHelper(Slots, akActor)
EndFunction

; Returns the slot for the specified index. Slot is not guaranteed to be active.
; 
zbfSlot Function GetSlot(Int aiIndex)
	Return Slots[aiIndex]
EndFunction

zbfSlot Function FindSlotHelper(zbfSlot[] akSlots, Actor akActor)
	Int i = akSlots.Length
	While i > 0
		i -= 1
		If akSlots[i].GetActorReference() == akActor
			Return akSlots[i]
		EndIf
	EndWhile
	Return None
EndFunction

zbfSlot Function SlotActorHelper(zbfSlot[] akSlots, Actor akActor)
	GrabMutex()
	Log("SlotActorHelper", zbfUtil.GetActorName(akActor))
	zbfSlot found = FindSlotHelper(akSlots, akActor)
	Int i = akSlots.Length
	While (found == None) && (i > 0)
		i -= 1
		If akSlots[i].GetActorReference() == None
			akSlots[i].Register(akActor)
			found = akSlots[i]

			zbfEffectBondage.SendSlottedEvent(akActor)
		EndIf
	EndWhile
	ReleaseMutex()

	Return found
EndFunction

Function UnslotActorHelper(zbfSlot[] akSlots, Actor akActor)
	GrabMutex()
	Log("UnslotActorHelper", zbfUtil.GetActorName(akActor))
	zbfSlot found = FindSlotHelper(akSlots, akActor)
	If found != None
		found.Unregister()
		zbfEffectBondage.SendUnSlottedEvent(akActor)
	EndIf
	ReleaseMutex()
EndFunction

Armor Function GetRandom(Armor[] akArmors)
	Return akArmors[Utility.RandomInt(0, akArmors.Length - 1)]
EndFunction


; @section: PlayerControls
; 
; These functions are all used by zbfPlayerControl, and should not be called directly.
;

zbfPlayerControl[] Property PlayerControlRegs Auto Hidden ; Array containing all registered player controls

; Registers a player control object in the repository. This is normally done automatically by zbfPlayerControl::
; 
Function Register(zbfPlayerControl akItem)
	GrabMutex()

	If PlayerControlRegs.Length < 10
		PlayerControlRegs = New zbfPlayerControl[10]
		PlayerControlRegs[0] = PlayerControl ; Shameless self register
	EndIf

	Int i = PlayerControlRegs.Find(akItem)
	If i < 0
		i = PlayerControlRegs.Find(None) ; First empty element
		PlayerControlRegs[i] = akItem
	EndIf

	ReleaseMutex()
	Log("Register", "Registered mod " + akItem.ModName + " in slot " + i + ".")
EndFunction

; Checks all disabled player controls, and reapplies settings to the Game global object.
; 
; 0x1 - Movement
; 0x2 - Fighting
; 0x4 - Sneaking
; 0x8 - Menu
; 0x10 - Activation
; 0x20 - Saving
; 0x40 - Waiting
; 0x80 - Show message about disabled controls
; 
Int Property PlayerControlsFromSlot Auto Hidden
Function ReapplyPlayerControls()
	Int iControlMask = PlayerControlsFromSlot
	Int i = 0
	While i < PlayerControlRegs.Length
		If PlayerControlRegs[i] != None
			iControlMask = Math.LogicalOr(PlayerControlRegs[i].iControlMask, iControlMask)
		EndIf
		i += 1
	EndWhile

	Game.EnablePlayerControls( \
		abMovement = Math.LogicalAnd(iControlMask, 0x1) == 0, \
		abFighting = Math.LogicalAnd(iControlMask, 0x2) == 0, \
		abSneaking = Math.LogicalAnd(iControlMask, 0x4) == 0, \
		abMenu = Math.LogicalAnd(iControlMask, 0x8) == 0, \
		abActivate = Math.LogicalAnd(iControlMask, 0x10) == 0, \
		abCamSwitch = False, \
		abLooking = False, \
		abJournalTabs = False)

	Game.DisablePlayerControls( \
		abMovement = Math.LogicalAnd(iControlMask, 0x1) != 0, \
		abFighting = Math.LogicalAnd(iControlMask, 0x2) != 0, \
		abSneaking = Math.LogicalAnd(iControlMask, 0x4) != 0, \
		abMenu = Math.LogicalAnd(iControlMask, 0x8) != 0, \
		abActivate = Math.LogicalAnd(iControlMask, 0x10) != 0)

	Game.SetInChargen( \
		abDisableSaving = (Math.LogicalAnd(iControlMask, 0x20) != 0), \
		abDisableWaiting = (Math.LogicalAnd(iControlMask, 0x40) != 0), \
		abShowControlsDisabledMessage = (Math.LogicalAnd(iControlMask, 0x80) != 0))

	Game.EnableFastTravel( \
		abEnable = (Math.LogicalAnd(iControlMask, 0x100) == 0))
EndFunction


; @section: Private
; 
; Private functions go here. Do not call these unless you're doing so from this file.
; 

Int Function MapHasKeywordToInt(Form akItem, Keyword[] akKeys, Int[] aiList, Int aiDefault = -1)
	Int found = FindHasKeyword(akItem, akKeys)
	If found == -1
		Return aiDefault
	EndIf

	Return aiList[found]
EndFunction

Int Function MapWornHasKeywordToInt(Actor akWearer, Keyword[] akKeys, Int[] aiList, Int aiDefault = -1)
	Int found = FindWornHasKeyword(akWearer, akKeys)
	If found == -1
		Return aiDefault
	EndIf

	Return aiList[found]
EndFunction

Int Function FindHasKeyword(Form akItem, Keyword[] akKeys, Int aiStart = 0, Int aiStop = -1, Int aiDefault = -1)
	If akItem == None
		Return aiDefault
	EndIf
	If aiStop < 0
		aiStop = akKeys.Length
	EndIf

	Int i = aiStart
	While i < aiStop
		If akItem.HasKeyword(akKeys[i])
			Return i
		EndIf
		i += 1
	EndWhile
	Return aiDefault
EndFunction

Int Function FindWornHasKeyword(Actor akWearer, Keyword[] akKeys, Int aiStart = 0, Int aiStop = -1, Int aiDefault = -1)
	If akWearer == None
		Return aiDefault
	EndIf
	If aiStop < 0
		aiStop = akKeys.Length
	EndIf

	Int i = aiStart
	While i < aiStop
		If akWearer.WornHasKeyword(akKeys[i])
			Return i
		EndIf
		i += 1
	EndWhile
	Return aiDefault
EndFunction

Function SetPlayerActorPerk(Actor akActor, Perk akPerk, Bool abSet)
	If akActor == PlayerRef
		If abSet
			akActor.AddPerk(akPerk)
		Else
			akActor.RemovePerk(akPerk)
		EndIf
	EndIf
EndFunction

String Function BuildStringList(String asPre, String asArgs, String asPost = "")
	String out = ""

	Int maxLen = StringUtil.GetLength(asArgs)
	Int begin = 0
	While begin < maxLen
		Int end = StringUtil.Find(asArgs, ",", begin)
		If end < 0
			end = maxLen
		EndIf

		Int actualStringLen = (end - begin + 1) - 1
		If actualStringLen > 0
			out += ", " + asPre + StringUtil.Substring(asArgs, begin, actualStringLen) + asPost
		EndIf
		begin = end + 1
	EndWhile
	Return out
EndFunction



; Removes all ai references and releases player from ai control
; 
; Used by MCM to restore player controls. Use with care if called outside of ZAP.
; 
Function ReleaseAllAiRefs()
	iAiRef = 0
	Game.SetPlayerAiDriven(false)
EndFunction

Function SetDebugLevel(Int aiLevel)
	iDebugLevel = aiLevel
	PlayerSlot.SetDebugLevel(aiLevel)
	Int i = Slots.Length
	While i > 0
		i -= 1
		Slots[i].SetDebugLevel(aiLevel)
	EndWhile
EndFunction

Int iDebugLevel
Int iError = 0
Int iWarning = 1
Int iInfo = 2
String sFilePrefix = "zbf"
Function Log(String asMethod, String asMessage, Int aiLevel = 2, Bool abCondition = True)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace(sFilePrefix + " (" + asMethod + "): " + asMessage)
	EndIf
EndFunction

Int iLocked
Function GrabMutex()
	Int iSafety = 0
	While iLocked > 0 && iSafety < 50
		Utility.Wait(0.5)
		iSafety += 1
	EndWhile
	Log("GrabMutex", "Lock function did not release right away!", iError, iSafety >= 50)
	iLocked = 1
EndFunction

Function ReleaseMutex()
	iLocked = 0
EndFunction

; Helper function to turn an int into a zero padded string
; 
; This function supports only numbers up to 99
; 
; Example:  
; GetAnimationIndex(1) --> "01"  
; GetAnimationIndex(11) --> "11"  
; 
String Function GetAnimationIndex(Int iIndex)
	If iIndex < 10
		Return "0" + (iIndex As String)
	EndIf
	Return iIndex As String
EndFunction

Function InitializeModule()
	zbfIsAnimatingExtra = zbfIsAnimating

	Log("InitializeModule", "Initialize")

	; Force registration
	Log("InitializeModule", "Register player")
	PlayerSlot.Register(PlayerRef)
EndFunction

; @section: Deprecated
;
; Old deprecated functions. Avoid using these.
; 

Bool Function HasOffsetIdle(Actor akActor)
	Return akActor.WornHasKeyword(zbfEffectWrist)
EndFunction

Bool Function HasExpressionModifier(Actor akActor)
	Return akActor.WornHasKeyword(zbfEffectOpenMouth) || akActor.WornHasKeyword(zbfEffectSetExpression)
EndFunction

Bool Function HasPlayerControls(Actor akActor)
	Bool hasPc = akActor.WornHasKeyword(zbfEffectNoInventory) || akActor.WornHasKeyword(zbfEffectNoActivate) || akActor.WornHasKeyword(zbfEffectNoFighting) || akActor.WornHasKeyword(zbfEffectNoSneak) || akActor.WornHasKeyword(zbfEffectNoMove)

	Return hasPc
EndFunction

Bool Function HasMovementModifier(Actor akActor)
	Return akActor.WornHasKeyword(zbfEffectSlowMove)
EndFunction

Bool Function HasSilenceEffect(Actor akActor)
	Return akActor.WornHasKeyword(zbfEffectNoMagic)
EndFunction

Bool Function HasRefreshModifier(Actor akActor)
	Return akActor.WornHasKeyword(zbfEffectRefresh)
EndFunction

Bool Function HasGagSound(Actor akActor)
	Return akActor.WornHasKeyword(zbfEffectGagSound)
EndFunction

Function ApplyAllModifiers(Actor akActor, Bool abApplyMouth = True, Bool abApplyMovement = True, Bool abApplySilence = True, Bool abApplyPlayerControls = True, Bool abApplyOffsetIdle = True)
	Int iMask = iEffectArms * (abApplyOffsetIdle As Int)
	iMask += iEffectMouth * (abApplyMouth As Int)
	iMask += iEffectFace * (abApplyMouth As Int)
	iMask += iEffectPlayerControl * (abApplyPlayerControls As Int)
	iMask += iEffectLegs * (abApplyMovement As Int)
	iMask += iEffectSilence * (abApplySilence As Int)

	ApplyModifiersMask(akActor, iMask)
EndFunction

Float Function GetUpdateInterval()
	Return 0.5
EndFunction
