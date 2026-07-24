Scriptname zadLibs extends Quest


Keyword Property zad_DeviousPlug Auto
Keyword Property zad_DeviousBelt Auto
Keyword Property zad_DeviousBra Auto
Keyword Property zad_DeviousCollar Auto
Keyword Property zad_DeviousArmCuffs Auto
Keyword Property zad_DeviousLegCuffs Auto
Keyword Property zad_DeviousArmbinder Auto
Keyword Property zad_DeviousArmbinderElbow Auto
Keyword Property zad_DeviousHeavyBondage Auto
Keyword Property zad_DeviousHobbleSkirt Auto
Keyword Property zad_DeviousHobbleSkirtRelaxed Auto
Keyword Property zad_DeviousAnkleShackles Auto
Keyword Property zad_DeviousStraitJacket Auto
Keyword Property zad_DeviousCuffsFront Auto
Keyword Property zad_DeviousPetSuit Auto
Keyword Property zad_DeviousYoke Auto
Keyword Property zad_DeviousYokeBB Auto
Keyword Property zad_DeviousCorset Auto
Keyword Property zad_DeviousClamps Auto
Keyword Property zad_DeviousGloves Auto
Keyword Property zad_DeviousHood Auto
Keyword Property zad_DeviousSuit Auto
Keyword Property zad_DeviousElbowTie Auto
Keyword Property zad_DeviousGag Auto
Keyword Property zad_DeviousGagLarge Auto
Keyword Property zad_DeviousGagPanel Auto
Keyword Property zad_DeviousPlugVaginal Auto
Keyword Property zad_DeviousPlugAnal Auto
Keyword Property zad_DeviousHarness Auto
Keyword Property zad_DeviousBlindfold Auto
Keyword Property zad_DeviousBoots Auto
Keyword Property zad_Lockable Auto
Keyword Property zad_DeviousPiercingsNipple Auto
Keyword Property zad_DeviousPiercingsVaginal Auto
Keyword Property zad_DeviousBondageMittens Auto
Keyword Property zad_DeviousPonyGear Auto
Keyword Property zad_PermitOral Auto
Keyword Property zad_PermitAnal Auto
Keyword Property zad_PermitVaginal Auto

Keyword Property zad_InventoryDevice Auto
Keyword Property zad_BlockGeneric Auto ; Block generic removal of this device.
Keyword Property zad_QuestItem Auto ; Quest item tag. This item can not be removed conventionally.

Keyword Property zad_BraNoBlockPiercings Auto
Keyword Property zad_GagNoOpenMouth Auto
Keyword Property zad_GagCustomExpression Auto

Keyword Property zad_BoundCombatDisableKick Auto

Keyword Property zad_NonUniqueKey Auto		; A key tagged with this keyword will be consumed by the global Destroy Key feature, if enabled by the user.

Keyword Property zad_BlockGenericEvents Auto
Keyword Property zad_ExposedBreasts Auto

; All standard devices, at this time. Shorthand for mods, and to avoid the hassle of re-adding these as properties for other scripts.
; If you're using a custom device, you'll need to use EquipDevice, rather than the shorthand ManipulateDevice.
Armor Property beltPaddedRendered Auto         ; Internal Device
Armor Property beltPadded Auto        	       ; Inventory Device
Armor Property beltIronRendered Auto         ; Internal Device
Armor Property beltIron Auto        	     ; Inventory Device
Armor Property plugIronRendered Auto         ; Internal Device
Armor Property plugIron Auto        	     ; Inventory Device
Armor Property plugPrimitiveRendered Auto         ; Internal Device
Armor Property plugPrimitive Auto        	  ; Inventory Device
Armor Property plugInflatableRendered Auto         ; Internal Device
Armor Property plugInflatable Auto        	   ; Inventory Device
Armor Property plugSoulgemRendered Auto         ; Internal Device
Armor Property plugSoulgem Auto        		; Inventory Device
Armor Property braPaddedRendered Auto         ; Internal Device
Armor Property braPadded Auto        	      ; Inventory Device
Armor Property cuffsPaddedArmsRendered Auto         ; Internal Device
Armor Property cuffsPaddedArms Auto        	    ; Inventory Device
Armor Property cuffsPaddedLegsRendered Auto         ; Internal Device
Armor Property cuffsPaddedLegs Auto        	    ; Inventory Device
Armor Property cuffsPaddedCollarRendered Auto         ; Internal Device
Armor Property cuffsPaddedCollar Auto        	      ; Inventory Device
Armor Property cuffsPaddedCompleteRendered Auto         ; Internal Device
Armor Property cuffsPaddedComplete Auto        		; Inventory Device
Armor Property collarPostureRendered Auto         ; Internal Device
Armor Property collarPosture Auto        	  ; Inventory Device
Armor Property armbinderRendered Auto         ; Internal Device
Armor Property armbinder Auto        	  ; Inventory Device
Armor Property zad_armBinderHisec_Rendered Auto
Armor Property zad_armBinderHisec_Inventory Auto
Armor Property gagBall Auto
Armor Property gagBallRendered Auto
Armor Property gagPanel Auto
Armor Property gagPanelRendered Auto
Armor Property gagRing Auto
Armor Property gagRingRendered Auto

Armor Property gagStrapBall Auto                   ; Inventory Device
Armor Property gagStrapBallRendered Auto           ; Internal Device
Armor Property gagStrapRing Auto                   ; Inventory Device
Armor Property gagStrapRingRendered Auto           ; Internal Device
Armor Property blindfold Auto                        ; Inventory Device
Armor Property blindfoldRendered Auto                ; Internal Device
Armor Property cuffsLeatherArms Auto                 ; Inventory Device
Armor Property cuffsLeatherArmsRendered Auto         ; Internal Device
Armor Property cuffsLeatherLegs Auto                 ; Inventory Device
Armor Property cuffsLeatherLegsRendered Auto         ; Internal Device
Armor Property cuffsLeatherCollar Auto               ; Inventory Device
Armor Property cuffsLeatherCollarRendered Auto       ; Internal Device
Armor Property harnessBody Auto                          ; Inventory Device
Armor Property harnessBodyRendered Auto                  ; Internal Device
Armor Property harnessCollar Auto                  ; Inventory Device
Armor Property harnessCollarRendered Auto          ; Internal Device
Armor Property collarPostureLeather Auto
Armor Property collarPostureLeatherRendered Auto

Armor Property plugIronVag Auto                  ; Internal Device
Armor Property plugIronVagRendered Auto          ; Internal Device
Armor Property plugIronAn Auto                  ; Internal Device
Armor Property plugIronAnRendered Auto          ; Internal Device
Armor Property plugPrimitiveVag Auto                  ; Internal Device
Armor Property plugPrimitiveVagRendered Auto          ; Internal Device
Armor Property plugPrimitiveAn Auto                  ; Internal Device
Armor Property plugPrimitiveAnRendered Auto          ; Internal Device
Armor Property plugSoulgemVag Auto                  ; Internal Device
Armor Property plugSoulgemVagRendered Auto          ; Internal Device
Armor Property plugSoulgemAn Auto                  ; Internal Device
Armor Property plugSoulgemAnRendered Auto          ; Internal Device
Armor Property plugInflatableVag Auto                  ; Internal Device
Armor Property plugInflatableVagRendered Auto          ; Internal Device
Armor Property plugInflatableAn Auto                  ; Internal Device
Armor Property plugInflatableAnRendered Auto          ; Internal Device
Armor Property beltPaddedOpen Auto        	       ; Inventory Device
Armor Property beltPaddedOpenRendered Auto         ; Internal Device
Armor Property plugChargeableVag Auto
Armor Property plugChargeableRenderedVag Auto
Armor Property plugTrainingVag Auto
Armor Property plugTrainingRenderedVag Auto

Armor Property collarRestrictive Auto
Armor Property collarRestrictiveRendered Auto
Armor Property corset Auto
Armor Property corsetRendered Auto
Armor Property glovesRestrictive Auto
Armor Property glovesRestrictiveRendered Auto
Armor Property yoke Auto
Armor Property yokeRendered Auto

Armor Property piercingVSoul Auto
Armor Property piercingVSoulRendered Auto
Armor Property piercingNSoul Auto
Armor Property piercingNSoulRendered Auto

; Keys
Key Property chastityKey Auto
Key Property restraintsKey Auto
Key Property piercingKey Auto ; Piercing removal tool

; Use this function to lock a device on an actor. It's way, waaaaay, WAY faster than the old EquipDevice() and doesn't even 
; need the rendered device or keyword, because the OnEquipped() event will process all the needed operations, which has direct access to these properties.
; The force parameter will make the function try to equip the given item, even if another (generic) item is already worn.
Bool Function LockDevice(actor akActor, armor deviceInventory, bool force = false)
EndFunction
; Remove device from actor. For NPCs, fires the events etc, just like UnEquipped() would.
; Passing the rendered device and/or keyword is 100% unneeded for the player, but it will make the routine perform a LOT faster if at least the keyword is given for NPCs.
; If at least the keyword is given, this is STILL lightning-fast, otherwise the device will get determined the slow way. Meh!
; On the plus side, ALL pre-5.0 mods had to provide the keyword and the rendered device anyway, so existing stuff will still enjoy a nice speed-boost.
; The parameter genericonly is set to false by default to mirror the behavior of the old RemoveDevice() function (which will for the time being still be in API and route calls to this function).
; If this function is used in place of the old ManipulateGenericDevice() function, make sure to pass genericonly = true
; Mind you that this function assumes the block_generic and quest_item flags to be present on the inventory device, not (just) the rendered device. Most mods seemed to do that already,
; but unexpected behavior might occur if the keywords are on the rendered device only.
Bool Function UnlockDevice(actor akActor, armor deviceInventory, armor deviceRendered = none, keyword zad_DeviousDevice = none, bool destroyDevice = false, bool genericonly = false)
EndFunction 

; Removes a device in a given slot by providing a keyword.
Bool Function UnlockDeviceByKeyword(actor akActor, keyword zad_DeviousDevice, bool destroyDevice = false)
EndFunction



; Use this function to safely replace a worn item with the given one. If genericonly is set to false, the function will also replace devices marked with zad_BlockGeneric.
; It is not necessary to pass the device keyword, but the function will perform much faster if you do.
; This function will behave like LockDevice() if no conflicting device is equipped, but it WILL be slower, if no keyword is provided.
Bool Function SwapDevices(actor akActor, armor deviceInventory, keyword zad_DeviousDevice = none, bool destroyDevice = false, bool genericonly = true)
EndFunction

; Retrieves a random inventory device with the given keyword, returns none if no devices are available
Armor Function GetGenericDeviceByKeyword(Keyword kw)
EndFunction