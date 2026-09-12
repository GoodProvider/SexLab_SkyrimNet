Scriptname DOM_Equip extends Quest  
Import Utility
Import DOM_Util
Import DOM_EquipUtil

DOM_Core Property DOMCore Auto
DOM_SEXLAB Property DOMSexlab Auto
DOM_ZAZ Property DOMZaz Auto
DOM_PAH Property DOMPAH Auto
DOM_ZAD Property DOMZad Auto

; Toggles
bool Property verboseEquip = false Auto Hidden
bool Property allowSlavesGearToggle = false Auto Hidden
bool Property allowSlaversGearToggle = true Auto Hidden
bool Property itemEquipToggle = true Auto Hidden
bool Property instantEquipToggle = true Auto Hidden
bool Property instantUnEquipToggle = false Auto Hidden
bool Property cellEquipToggle = false Auto Hidden
bool Property locationEquipToggle = true Auto Hidden
bool Property useStripKeywords = true Auto Hidden
bool Property resetStripKeywords = false Auto Hidden
bool Property sendDOMEquipEvent = true Auto Hidden
bool Property cleanUniqueOutfit = true Auto Hidden
bool Property cleanSpawnOutfit = true Auto Hidden
bool Property cleanSlaverOutfit = false Auto Hidden
bool Property restoreOutfitUnique = true Auto Hidden
bool Property restoreOutfitSpawn = true Auto Hidden
bool Property restoreOutfitAlways = false Auto Hidden
bool Property neverStripFX  = false Auto Hidden
bool Property stripAndDropToggle  = false Auto Hidden
bool Property stripDeleteToggle  = false Auto Hidden
bool Property stripLootToggle    = true Auto Hidden
bool Property stripItemsToggle    = false Auto Hidden
bool Property stripUnequippedToggle = true Auto Hidden
bool Property stripWeaponsToggle = true Auto Hidden
bool Property stripShieldsToggle  = true Auto Hidden
bool Property stripHeelsToggle = false Auto Hidden
bool Property stripUnderwearToggle = false Auto Hidden
bool Property stripJewelryToggle = false Auto Hidden
bool Property shameArea52 = false Auto Hidden
bool Property maskPubicArea = true Auto Hidden
bool Property maskFillHerUp = true Auto Hidden
bool Property has_SOS = false Auto Hidden

; Factions
Faction Property DOMNotPlayerSlaveFaction Auto
Faction Property DOMPlayerSlaveFaction Auto
Faction Property DOMShouldNotWearGear Auto
Faction Property DOMNoOutfitFaction Auto
Faction Property DOMWorkMode Auto
Faction Property DOMActionWorking Auto
Faction Property DOMActionPunishing Auto
Faction Property DOMLoveDesire Auto
Faction Property DOMTrainResignation Auto

; Stripping
Keyword Property DOMNoStrip Auto
Keyword Property DOMAlwaysStrip Auto
Keyword Property DOMNotDevice Auto
Keyword Property DOMIsDevice Auto
Keyword Property DOMNotSpecial Auto
Keyword Property DOMIsSpecial Auto
Keyword Property DOMNotIgnore Auto
Keyword Property DOMIsIgnore Auto

; Clothing type
Keyword Property EroticArmor Auto Hidden
Keyword Property ArmorCuirass Auto
Keyword Property ArmorClothing Auto
Keyword Property ArmorJewelry Auto
Keyword Property ArmorShield Auto
Keyword Property ClothingBody Auto
Keyword Property ClothingPoor Auto
Keyword Property ClothingRich Auto
Keyword Property ClothingSexy Auto
Keyword Property ClothingHeels Auto
Keyword Property ClothingNotHeels Auto
Keyword Property ClothingShame Auto
Keyword Property JewelryExpensive Auto
Keyword Property VendorItemJewelry Auto
Keyword Property ClothingUnderwear Auto
Keyword Property ClothingLingerie Auto
Keyword Property ClothingNotLingerie Auto
Keyword Property ClothingJewelry Auto Hidden
Keyword Property ClothingPanties Auto Hidden
Keyword Property ClothingBra Auto Hidden
Keyword Property Panties Auto Hidden
Keyword Property Bra Auto Hidden
Keyword Property Lingerie Auto Hidden
Keyword Property Underwear Auto Hidden
Keyword Property FemalePanties Auto Hidden
Keyword Property ArmorMaterialKSWigs Auto Hidden

; Outfits
Outfit Property DOMNothingOutfit Auto
Outfit Property FineClothesOutfit01 Auto
Outfit Property FineClothesOutfit02VariantWithHat Auto
Outfit Property PrisonerOutfit Auto
Outfit Property FarmClothesRandom Auto
Outfit Property BanditArmorMeleeNoShieldOutfit Auto
Outfit Property HunterClothesRND Auto
Outfit Property JarlClothesOutfit01 Auto
Outfit Property JarlClothesOutfit02 Auto
Outfit Property JarlClothesOutfit03 Auto

; Weapon types
Keyword Property WeapMaterialWood Auto
Keyword Property WeapMaterialLeather Auto
Keyword Property WeapTypeUnarmed Auto
Keyword Property WeapTypeWhip Auto Hidden
Keyword Property WeapTypeWhipAA Auto Hidden

; Restraint materials
Keyword Property ArmorMaterialFiber Auto
Keyword Property ArmorMaterialLeather Auto
Keyword Property ArmorMaterialIron Auto
Keyword Property ArmorMaterialSteel Auto

; Lists
FormList Property mineOreToolsList auto
FormList Property woodChoppingAxes auto

; weapons
Weapon Property weapPickaxe Auto
Weapon Property DOMWhip Auto

; Lights
Light Property Torch01 Auto

; Misc
MiscObject Property broom01 Auto
MiscObject Property Gold001 Auto

Function Initialize()
	LogInfo("===============================================================================")
	LogInfo("==                         DOM: Equipment interface                          ==")
	LogInfo("===============================================================================")

	if resetStripKeywords
		resetStripKeywords = false
	endif
	has_SOS = (Game.GetModbyName("Schlongs of Skyrim.esp") != 255)
	If (Game.GetModByName("Whips.esp") != 255)
		LogTrace("Whips Found!")
		WeapTypeWhip = Game.GetFormFromFile(0x0000AF76, "Whips.esp") as Keyword
	else
		WeapTypeWhip = None
	endif
	If (Game.GetModByName("NewArmoury.esp") != 255)
		LogTrace("NewArmoury Found!")
		WeapTypeWhipAA = Game.GetFormFromFile(0x0020F2A1, "NewArmoury.esp") as Keyword
		if WeapTypeWhipAA == None ; Wrong AA version
			WeapTypeWhipAA = Game.GetFormFromFile(0x0031BD77, "NewArmoury.esp") as Keyword
		endif
	else
		WeapTypeWhipAA = None
	endif
	if WeapMaterialWood == None
		WeapMaterialWood = Game.GetFormFromFile(0x0001E717, "Skyrim.esm") As Keyword
	endif
	ArmorMaterialKSWigs        = Keyword.GetKeyword("ArmorMaterialKSWigs")
	EroticArmor                = Keyword.GetKeyword("EroticArmor")
	ClothingJewelry            = Keyword.GetKeyword("ClothingJewelry")
	ClothingPanties            = Keyword.GetKeyword("ClothingPanties")
	ClothingBra                = Keyword.GetKeyword("ClothingBra")
	Panties                    = Keyword.GetKeyword("Panties")
	Bra                        = Keyword.GetKeyword("Bra")
	Lingerie                   = Keyword.GetKeyword("Lingerie")
	Underwear                  = Keyword.GetKeyword("Underwear")
	FemalePanties              = Keyword.GetKeyword("FemalePanties")
EndFunction

; Equipping

Function EquipItemTight(Actor akRef, Form the_form)
	if akRef.IsEquipped(the_form)
		return
	endif
	LogTrace("EquipItemTight actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.EquipItem(the_form, true, true) ; can not unequip, silent
EndFunction

Function UnEquipItemTight(Actor akRef, Form the_form)
	if !akRef.IsEquipped(the_form)
		return
	endif
	LogTrace("UnEquipItemTight actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.UnEquipItem(the_form, true, true) 
EndFunction

Function EquipItemLoose(Actor akRef, Form the_form)
	if akRef.IsEquipped(the_form)
		return
	endif
	LogTrace("EquipItemLoose actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.EquipItem(the_form, false, true) ; can unequip, silent
EndFunction

Function UnEquipItemLoose(Actor akRef, Form the_form)
	if !akRef.IsEquipped(the_form)
		return
	endif
	LogTrace("UnEquipItemLoose actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.UnEquipItem(the_form, false, true)
EndFunction

int Function UnEquipArmor(Actor akRef)
	Armor orig_armor = akRef.GetWornForm(0x00000004) as Armor ; kSlotMask32 = 0x00000004 ; BODY
	Armor orig_helmet = akRef.GetWornForm(0x00000001) as Armor ;  kSlotMask30 = 0x00000001 ; HEAD
	int type_equip = 0
	if orig_armor != None
		if IsToBeStripped(orig_armor)
			UnEquipItemLoose(akRef,orig_armor) 
			type_equip = 4 ; armor
		endif
	endif
	if orig_helmet != None
		if IsToBeStripped(orig_helmet)
			UnEquipItemLoose(akRef,orig_helmet) 
			type_equip = 4 ; armor
		endif
	endif

	return type_equip
EndFunction

int Function EquipArmor(Actor akRef)
	LogTrace("EquipArmor start "+akRef.GetDisplayName())
	Armor orig_armor = akRef.GetWornForm(0x00000004) as Armor ; kSlotMask32 = 0x00000004 ; BODY
	Armor orig_helmet = akRef.GetWornForm(0x00000001) as Armor ;  kSlotMask30 = 0x00000001 ; HEAD
	Armor the_armor = orig_armor
	Armor the_helmet = orig_helmet
	float x_armor = 0.0
	float x_helmet = 0.0
	float x = 0.0
	bool has_armor = false
	bool has_helmet = false
	bool armor_can_be_stripped = true
	bool helmet_can_be_stripped = true
	if the_armor != None
		LogTrace("EquipArmor armor="+the_armor.GetName())
		x_armor = ArmorValue(akRef,the_armor)
		armor_can_be_stripped = IsToBeStripped(the_armor)
		if armor_can_be_stripped && x_armor >= 0
			has_armor = true
		endif
	endif
	if the_helmet != None
		LogTrace("EquipArmor helmet="+the_helmet.GetName())
		x_helmet = ArmorValue(akRef,the_helmet)
		helmet_can_be_stripped = IsToBeStripped(the_helmet)
		if helmet_can_be_stripped && x_helmet >= 0
			has_helmet = true
		endif
	endif
	bool changed_armor = false
	bool changed_helmet = false
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		Form the_form = akRef.GetNthForm(i)
		if the_form != None && isClothesOrArmor(the_form)
			Armor the_current_armor = the_form as Armor
			if the_current_armor != the_armor && the_current_armor != the_helmet
				int slotmask = Math.LogicalAnd(the_current_armor.GetSlotMask(), 0x00002FFF)
				LogTrace("EquipArmor found armor "+akRef.GetDisplayName()+" "+the_current_armor.GetName()+" slot="+slotmask)
				if slotmask == 0x00000004 ; body
					x = ArmorValue(akRef,the_current_armor)
					if x >= 0
						has_armor = true
					endif
					if x > x_armor && armor_can_be_stripped
						the_armor = the_current_armor
						x_armor = x
						changed_armor = true
						armor_can_be_stripped = IsToBeStripped(the_armor)
						LogTrace("EquipArmor found better armor "+akRef.GetDisplayName()+" "+the_armor.GetName())
					endif
				elseif slotmask == 0x00000001  ; helmet
					x = ArmorValue(akRef,the_current_armor)
					if x >= 0
						has_helmet = true
					endif
					if x > x_helmet && helmet_can_be_stripped
						the_helmet = the_current_armor
						x_helmet = x
						changed_helmet = true
						helmet_can_be_stripped = IsToBeStripped(the_helmet)
						LogTrace("EquipArmor found better helmet "+akRef.GetDisplayName()+" "+the_helmet.GetName())
					endif
				endif
			endif
		endif
	endwhile
	if changed_armor
		;if orig_armor != None && akRef.IsEquipped(orig_armor)
		;	UnEquipItemLoose(akRef,orig_armor, false, true)
		;endif
		EquipItemLoose(akRef,the_armor)
	endif
	if changed_helmet
		;if orig_helmet != None && akRef.IsEquipped(orig_helmet)
		;	UnEquipItemLoose(akRef,orig_helmet, false, true)
		;endif
		EquipItemLoose(akRef,the_helmet)
	endif
	
	int type_equip = 0
	if has_armor || has_helmet
		type_equip += 2 ; armor
	endif
	LogTrace("EquipArmor close "+akRef.GetDisplayName()+" changed="+changed_armor+" "+changed_helmet+" has="+has_armor+" "+has_helmet)
	return type_equip
EndFunction

int Function EquipClothes(Actor akRef)
	LogTrace("EquipClothes start "+akRef.GetDisplayName())
	Armor orig_clothes = akRef.GetWornForm(0x00000004) as Armor ; kSlotMask32 = 0x00000004 ; BODY
	Armor orig_hat = akRef.GetWornForm(0x00000001) as Armor ;  kSlotMask30 = 0x00000001 ; HEAD
	Armor the_clothes = orig_clothes
	Armor the_hat = orig_hat
	float x_clothes = 0.0
	float x_hat = 0.0
	float x = 0.0
	bool has_clothes = false
	bool has_hat = false
	bool clothes_can_be_stripped = true
	bool hat_can_be_stripped = true
	if the_clothes != None
		LogTrace("EquipClothes clothes="+the_clothes.GetName())
		x_clothes = ClothesValue(the_clothes)
		if x_clothes > 0.0
			clothes_can_be_stripped = IsToBeStripped(the_clothes)
			if clothes_can_be_stripped && x_clothes >= 0
				has_clothes = true
			endif
		else
			the_clothes = None
		endif
	endif
	if the_hat != None
		LogTrace("EquipClothes hat="+the_hat.GetName())
		x_hat = ClothesValue(the_hat)
		if x_hat > 0.0
			hat_can_be_stripped = IsToBeStripped(the_hat)
			if hat_can_be_stripped && x_hat >= 0
				has_hat = true
			endif
		else
			the_hat = None
		endif
	endif
	bool changed_clothes = false
	bool changed_hat = false
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		Form the_form = akRef.GetNthForm(i)
		if the_form != None && isClothesOrArmor(the_form)
			Armor the_current_clothes = the_form as Armor
			if the_current_clothes != the_clothes && the_current_clothes != the_hat
				int slotmask = Math.LogicalAnd(the_current_clothes.GetSlotMask(), 0x00002FFF)
				LogTrace("EquipClothes found clothes "+akRef.GetDisplayName()+" "+the_current_clothes.GetName()+" slot="+slotmask)
				if slotmask == 0x00000004 ; body
					x = ClothesValue(the_current_clothes)
					if x > 0.0
						has_clothes = true
					endif
					if x > x_clothes && clothes_can_be_stripped
						the_clothes = the_current_clothes
						x_clothes = x
						changed_clothes = true
						clothes_can_be_stripped = IsToBeStripped(the_clothes)
						LogTrace("EquipClothes found better clothes "+akRef.GetDisplayName()+" "+the_clothes.GetName())
					endif
				elseif slotmask == 0x00000001  ; hat
					x = ClothesValue(the_current_clothes)
					if x > 0.0
						has_hat = true
					endif
					if x > x_hat && hat_can_be_stripped
						the_hat = the_current_clothes
						x_hat = x
						changed_hat = true
						hat_can_be_stripped = IsToBeStripped(the_hat)
						LogTrace("EquipClothes found better hat "+akRef.GetDisplayName()+" "+the_hat.GetName())
					endif
				endif
			endif
		endif
	endwhile
	if changed_clothes
		;if orig_clothes != None && akRef.IsEquipped(orig_clothes)
		;	UnEquipItemLoose(akRef,orig_clothes)
		;endif
		EquipItemLoose(akRef,the_clothes)
	endif
	if changed_hat
		;if orig_hat != None && akRef.IsEquipped(orig_hat)
		;	UnEquipItemLoose(akRef,orig_hat, false, true)
		;endif
		EquipItemLoose(akRef,the_hat)
	endif
	
	int type_equip = 0
	if has_clothes || has_hat
		type_equip += 1 ; armor
	endif
	LogTrace("EquipClothes close "+akRef.GetDisplayName()+" changed="+changed_clothes+" "+changed_hat+" has="+has_clothes+" "+has_hat)
	return type_equip
EndFunction

int Function EquipInventory(Actor akRef, bool use_light = false, bool should_be_naked = false, bool should_wear_armor = true, bool should_hold_weapons = true)
	LogTrace("EquipInventory start "+akRef.GetDisplayName()+" light="+use_light+" naked="+should_be_naked+" armor="+should_wear_armor+" weapons="+should_hold_weapons)
	Form the_form
	int type_equip = 0
	int type
	;/
	if should_be_naked
		type_equip += UnEquipArmor(akRef)
	elseif should_wear_armor
		type_equip += EquipArmor(akRef)
	else
		type_equip += EquipClothes(akRef)
	endif
	if should_hold_weapons
		type_equip += EquipWeapon(akRef)
	else
		type_equip += UnEquipWeapon(akRef)
	endif
	if should_wear_armor && should_hold_weapons
		type_equip += EquipShield(akRef)
	else
		type_equip += UnEquipShield(akRef)
	endif
	/;
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			if the_form.GetType() == 53 ; kLeveledItem 
				LogTrace("EquipInventory start "+akRef.GetDisplayName()+" EquipLeveledItem "+the_form.GetName())
				EquipLeveledItem(akRef,the_form)
			else
				LogTrace("EquipInventory start "+akRef.GetDisplayName()+" EquipItemWearable "+the_form.GetName())
				type = EquipItemWearable(akRef,the_form,use_light,should_be_naked,should_wear_armor,should_hold_weapons)
				if (type%2) == 1 &&  (type_equip%2) == 0
					type_equip += 1 ; clothes
				endif
				if ((type/2)%2) == 1 &&  ((type_equip/2)%2) == 0
					type_equip += 2 ; armor except cuirass and shield
				endif
				if ((type/4)%2) == 1 &&  ((type_equip/4)%2) == 0
					type_equip += 4 ; shield
				endif
				if ((type/8)%2) == 1 &&  ((type_equip/8)%2) == 0
					type_equip += 8 ; weapon
				endif
				if ((type/16)%2) == 1 &&  ((type_equip/16)%2) == 0
					type_equip += 16 ; ammo
				endif
				if ((type/32)%2) == 1 &&  ((type_equip/32)%2) == 0
					type_equip += 32 ; cuirass
				endif
			endif
		;else
		;	LogTrace("EquipInventory start "+akRef.GetDisplayName()+" Form=None")
		endif
	endwhile

	LogTrace("EquipInventory close "+akRef.GetDisplayName()+" number of items="+akRef.GetNumItems()+" type_equip="+type_equip)
	return type_equip
EndFunction

Function EquipItemMisc(Actor akRef, Form the_form, int type, bool use_light)
	if use_light && type == 31; Hold light & kLight - use_light = poseID == 99
		if akRef.IsEquipped(the_form)
			;LogTrace("EquipItemMisc item already equipped: "+the_form.GetName())
			return
		endif
		LogTrace("EquipItemMisc "+akRef.GetDisplayName()+" item to be equipped: "+the_form.GetName())
		EquipItemLoose(akRef,the_form)
	endif
	;LogTrace("EquipItemMisc: Do not equip misc item: "+the_form.GetName())
EndFunction

Function EquipItemSpecial(Actor akRef, Form the_form)
	LogTrace("EquipItemSpecial "+akRef.GetDisplayName()+" force equip special item="+the_form.GetName())
	Armor item_as_armor = the_form as Armor
	if akRef.IsEquipped(the_form)
		LogTrace("EquipItemSpecial "+akRef.GetDisplayName()+" already equipped special item="+the_form.GetName())
		return
	endif
	LogTrace("EquipItemSpecial "+akRef.GetDisplayName()+" force equip special item="+the_form.GetName())
	EquipItemTight(akRef,the_form)
EndFunction

Function EquipItemDevice(Actor akRef, Form the_form)
	Armor item_as_armor = the_form as Armor
	if item_as_armor != None
		int imask =  Math.LogicalAnd(item_as_armor.GetSlotMask(), 0x00002FFF) ; other slots should be ignored
		Armor item_already_in_slot = akRef.GetWornForm(imask) as Armor
		if item_already_in_slot != None
			if IsItemSpecial(item_already_in_slot)
				LogTrace("EquipItemDevice "+akRef.GetDisplayName()+" keep SPECIAL item already in slot="+item_already_in_slot.GetName()+" device="+IsItemDevice(item_already_in_slot))
				return
			endif
			if IsItemDevice(item_already_in_slot)
				bool is_yoke = DOMZaz.hasKeywordYoke(the_form)
				if !is_yoke
					LogTrace("EquipItemDevice "+akRef.GetDisplayName()+" keep DEVICE item already in slot="+item_already_in_slot.GetName()+" device="+IsItemDevice(item_already_in_slot))
					return
				endif
				bool is_yoke_already_in_slot = DOMZaz.hasKeywordYoke(item_already_in_slot)
				if is_yoke_already_in_slot
					LogTrace("EquipItemDevice "+akRef.GetDisplayName()+" keep YOKE item already in slot="+item_already_in_slot.GetName()+" device="+IsItemDevice(item_already_in_slot))
					return
				endif
			endif
			LogTrace("EquipItemDevice "+akRef.GetDisplayName()+" remove item already in slot="+item_already_in_slot.GetName()+" device="+IsItemDevice(item_already_in_slot))
			UnEquipItemLoose(akRef,item_already_in_slot)
		endif
	endif
	LogTrace("EquipItemDevice force equip device item="+the_form.GetName())
	EquipItemTight(akRef,the_form)
EndFunction

Function EquipItemArmorNaked(Actor akRef, Armor item_as_armor)
	if !IsToBeStripped(item_as_armor) ; do not unequip FX and no strip items
		EquipItemLoose(akRef,item_as_armor)
		return
	endif
	UnEquipItemLoose(akRef,item_as_armor)
	LogTrace("EquipItemArmorNaked "+akRef.GetDisplayName()+" should be naked -> do not equip item="+item_as_armor.GetName())
EndFunction

Function EquipItemArmorClothes(Actor akRef, Armor item_as_armor, Armor item_already_in_slot)
	; Unstrippable item
	if !IsToBeStripped(item_as_armor) 
		if item_already_in_slot == None ; No item in slot, equip no matter what
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" should be no armor -> equip not to be stripped="+item_as_armor.GetName())
			EquipItemLoose(akRef,item_as_armor)
			return
		endif
		; Has item already in slot
		if item_already_in_slot == item_as_armor ; same item exit
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" already equipped not to be stripped="+item_already_in_slot.GetName())
			return
		endif
		float y = ClothesValue(item_already_in_slot)
		if y == 0.0 ; Old item is armor, unequip and replace
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" replacing previous armor="+item_already_in_slot.GetName()+" with not to be stripped clothes="+item_as_armor.GetName())
			UnEquipItemLoose(akRef,item_already_in_slot) 
			EquipItemLoose(akRef,item_as_armor)
			return
		endif
		; Old item is clothes
		float x = ClothesValue(item_as_armor)
		if x == 0.0 ; New item is armor, keep old & quit
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" keeping previous item="+item_already_in_slot.GetName()+" instead of not to be stripped armor="+item_as_armor.GetName())
			return
		endif
		; Item in slot is not covering, equip that one instead
		if IsItemSpecial(item_already_in_slot) 
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" replacing previous special FX="+item_already_in_slot.GetName()+" with not to be stripped clothes="+item_as_armor.GetName())
			UnEquipItemTight(akRef,item_already_in_slot) 
			EquipItemLoose(akRef,item_as_armor)
			return
		endif
		; Equip best item
		if x > y 
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" replacing previous clothes="+item_already_in_slot.GetName()+" with better not to be stripped clothes="+item_as_armor.GetName())
			UnEquipItemLoose(akRef,item_already_in_slot) 
			EquipItemLoose(akRef,item_as_armor)
			return
		endif
		LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" keeping better clothes="+item_already_in_slot.GetName()+" and not to be stripped clothes="+item_as_armor.GetName())
		return
	endif

	; Item is strippable and no item already in slot
	if item_already_in_slot == None ; equip
		float x = ClothesValue(item_as_armor)
		if x == 0.0 ; New item is armor, keep & quit
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" do not equip armor="+item_as_armor.GetName())
			return
		endif
		LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" equipping clothes "+item_as_armor.GetName())
		EquipItemLoose(akRef,item_as_armor)
		return
	endif
	
	; Item is strippable but found an unstrippable item already in slot
	if !IsToBeStripped(item_already_in_slot)
		float x = ClothesValue(item_as_armor)
		if x == 0.0 ; New item is armor, keep old & quit
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" keeping previous not to be stripped item="+item_already_in_slot.GetName()+" instead of armor="+item_as_armor.GetName())
			return
		endif
		if IsItemSpecial(item_already_in_slot) ; Item in slot is not covering, equip that one instead
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" replacing previous special FX="+item_already_in_slot.GetName()+" with clothes="+item_as_armor.GetName())
			UnEquipItemTight(akRef,item_already_in_slot) 
			EquipItemLoose(akRef,item_as_armor)
			return
		endif
		; Keep not to be stripped item
		LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" keeping not to be stripped clothes="+item_already_in_slot.GetName()+" and not clothes="+item_as_armor.GetName())
		return
	endif
	
	; Item is strippable and found a strippable item already in slot
	if item_already_in_slot == item_as_armor ; same item exit
		float x = ClothesValue(item_as_armor)
		if x == 0.0 ; Item is armor, unequip and quit
			UnEquipItemLoose(akRef,item_as_armor) 
			LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" unequipping strippable item="+item_as_armor.GetName())
			return
		endif
		LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" already equipped strippable item="+item_as_armor.GetName())
		return
	endif

	float x = ClothesValue(item_as_armor)
	if x == 0.0 ; not clothes, quit
		LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" keeping previous item="+item_already_in_slot.GetName()+" instead of armor="+item_as_armor.GetName())
		return
	endif
	
	; Equip best clothes
	float y = ClothesValue(item_already_in_slot)
	if x > y 
		UnEquipItemLoose(akRef,item_already_in_slot) 
		EquipItemLoose(akRef,item_as_armor)
		LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+" replacing previous clothes="+item_already_in_slot.GetName()+" with better "+item_as_armor.GetName())
		return
	endif
	LogTrace("EquipItemArmorClothes "+akRef.GetDisplayName()+"  keeping better previous clothes="+item_already_in_slot.GetName()+" not "+item_as_armor.GetName())
EndFunction

Function EquipItemShield(Actor akRef, Armor item_as_armor, Armor item_already_in_slot, bool should_be_naked = false, bool should_wear_armor = true, bool should_hold_weapons = true)
	if item_already_in_slot == item_as_armor && should_wear_armor
		LogTrace("EquipItemShield "+akRef.GetDisplayName()+" already equipped shield="+item_already_in_slot.GetName())
		return
	endif
	if should_hold_weapons && should_wear_armor
		if item_already_in_slot == None
			EquipItemLoose(akRef,item_as_armor) ; Do not force equip shields
			LogTrace("EquipItemShield "+akRef.GetDisplayName()+" equip shield="+item_as_armor.GetName())
			return
		endif
		float x = ShieldValue(item_as_armor)
		float y = ShieldValue(item_already_in_slot)
		if x > y 
			UnEquipItemLoose(akRef,item_already_in_slot)
			EquipItemLoose(akRef,item_as_armor) ; Do not force equip shields
			LogTrace("EquipItemShield "+akRef.GetDisplayName()+" equip better shield="+item_as_armor.GetName()+" than "+item_already_in_slot.GetName())
			return
		endif
		LogTrace("EquipItemShield "+akRef.GetDisplayName()+" do not equip worse shield="+item_as_armor.GetName()+" keep "+item_already_in_slot.GetName())
		return
	else
		LogTrace("EquipItemShield "+akRef.GetDisplayName()+" unequip shield="+item_as_armor.GetName()+" should_hold_weapons="+should_hold_weapons+" should_wear_armor="+should_wear_armor)
		UnEquipItemLoose(akRef,item_as_armor) 
		return
	endif
	LogTrace("EquipItemShield "+akRef.GetDisplayName()+" do not equip shield="+item_as_armor.GetName()+" should_hold_weapons="+should_hold_weapons+" should_wear_armor="+should_wear_armor)
EndFunction

;int Property kSlotMask30 = 0x00000001 AutoReadOnly ; HEAD
;int Property kSlotMask32 = 0x00000004 AutoReadOnly ; BODY 5
;int Property kSlotMask33 = 0x00000008 AutoReadOnly ; Hands D
;int Property kSlotMask35 = 0x00000020 AutoReadOnly ; Amulet 2D
;int Property kSlotMask36 = 0x00000040 AutoReadOnly ; Ring 6D
;int Property kSlotMask37 = 0x00000080 AutoReadOnly ; Feet ED
;int Property kSlotMask39 = 0x00000200 AutoReadOnly ; SHIELD 2ED
;int Property kSlotMask42 = 0x00001000 AutoReadOnly ; Circlet 12ED

Function EquipItemArmor(Actor akRef, Armor item_as_armor, bool should_be_naked = false, bool should_wear_armor = true, bool should_hold_weapons = true)
	LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" found armor="+item_as_armor+" "+item_as_armor.GetName()+" naked="+should_be_naked+" armor="+should_wear_armor+" weapons="+should_hold_weapons)

	; Check if device is already in slot
	int slot_mask = Math.LogicalAnd(item_as_armor.GetSlotMask(), 0x00002FFF)
	LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" found armor="+item_as_armor.GetName()+" mask=0x"+DOM_Util.ConvertIDToHex(slot_mask))
	Armor item_already_in_slot = akRef.GetWornForm(slot_mask) as Armor
	LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" item already in slot="+item_already_in_slot+" mask4 item="+akRef.GetWornForm(4))
	
	if item_already_in_slot != None && IsItemDevice(item_already_in_slot)
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" found device already in slot="+item_already_in_slot.GetName())
		return
	endif
	
	; Device
	if IsItemDevice(item_as_armor)
		EquipItemDevice(akRef,item_as_armor)
		return
	endif

	; shield
	if item_as_armor.IsShield()
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" shield="+item_as_armor.GetName()+" should_be_naked="+should_be_naked)
		EquipItemShield(akRef, item_as_armor, item_already_in_slot, should_be_naked, should_wear_armor, should_hold_weapons)
		return
	endif

	; Naked
	if should_be_naked ; if should be naked, only wear shields
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" naked item="+item_as_armor.GetName()+" should_be_naked="+should_be_naked)
		EquipItemArmorNaked(akRef,item_as_armor)
		return
	endif
	
	; No armors
	if !should_wear_armor
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" should wear clothes item="+item_as_armor.GetName()+" should_wear_armor="+should_wear_armor)
		EquipItemArmorClothes(akRef,item_as_armor,item_already_in_slot)
		return
	endif

	; Should wear armors
	if item_already_in_slot == None
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" equipping armor="+item_as_armor.GetName()+" because NONE item_already_in_slot="+item_already_in_slot)
		EquipItemLoose(akRef,item_as_armor)
		return
	endif
	
	if item_already_in_slot == item_as_armor ; no changes
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" already equipped item="+item_as_armor.GetName())
		return
	endif

	; Unstrippable item & Has item already in slot
	if !IsToBeStripped(item_as_armor) 
		float y = ArmorValue(akRef,item_already_in_slot)
		if y < 1.0 ; Old item is not armor, unequip and replace
			LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" replacing previous armor="+item_already_in_slot.GetName()+" with not to be stripped armor="+item_as_armor.GetName())
			UnEquipItemLoose(akRef,item_already_in_slot)
			EquipItemLoose(akRef,item_as_armor)
			return
		endif
		; Old item is armor
		float x = ArmorValue(akRef,item_as_armor)
		if x < 1.0 ; New item is not armor, keep old & quit
			LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" keeping previous item="+item_already_in_slot.GetName()+" instead of not to be stripped clothes="+item_as_armor.GetName())
			return
		endif
		; Item in slot is not covering, equip that one instead
		if IsItemSpecial(item_already_in_slot) 
			LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" replacing previous special FX="+item_already_in_slot.GetName()+" with not to be stripped armor="+item_as_armor.GetName())
			UnEquipItemTight(akRef,item_already_in_slot)
			EquipItemLoose(akRef,item_as_armor)
			return
		endif
		; Equip best item
		if x > y 
			UnEquipItemLoose(akRef,item_already_in_slot)
			EquipItemLoose(akRef,item_as_armor)
			LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" replacing previous armor="+item_already_in_slot.GetName()+" with better not to be stripped armor="+item_as_armor.GetName())
			return
		endif
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" keeping better armor="+item_already_in_slot.GetName()+" and not to be stripped armor="+item_as_armor.GetName())
		return
	endif
	
	; Item is strippable but found an unstrippable item already in slot
	if !IsToBeStripped(item_already_in_slot)
		if IsItemSpecial(item_already_in_slot) ; Item in slot is not covering, equip that one instead
			LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" replacing previous special FX="+item_already_in_slot.GetName()+" with armor="+item_as_armor.GetName())
			UnEquipItemTight(akRef,item_already_in_slot)
			EquipItemLoose(akRef,item_as_armor)
			return
		endif
		float x = ArmorValue(akRef,item_as_armor)
		if x < 1.0 ; New item is not armor, keep old & quit
			LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" keeping previous item="+item_already_in_slot.GetName()+" instead of armor="+item_as_armor.GetName())
			return
		endif
		; Keep not to be stripped item
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" keeping not to be stripped armor="+item_already_in_slot.GetName()+" and not armor="+item_as_armor.GetName())
		return
	endif
	
	; Item is strippable and found a strippable item already in slot
	float x = ArmorValue(akRef,item_as_armor)
	if x < 1.0 ; not armor, quit
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" keeping previous item="+item_already_in_slot.GetName()+" instead of armor="+item_as_armor.GetName())
		return
	endif
	
	; Equip best armor
	float y = ArmorValue(akRef,item_already_in_slot)
	if x > y 
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" 1 item already in slot="+item_already_in_slot.GetName()+" mask4 item="+akRef.GetWornForm(4))
		UnEquipItemLoose(akRef,item_already_in_slot) 
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" 2 item already in slot="+item_already_in_slot.GetName()+" mask4 item="+akRef.GetWornForm(4))
		EquipItemLoose(akRef,item_as_armor)
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" 3 item already in slot="+item_already_in_slot.GetName()+" mask4 item="+akRef.GetWornForm(4))
		EquipItemLoose(akRef,item_as_armor)
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" 4 item already in slot="+item_already_in_slot.GetName()+" mask4 item="+akRef.GetWornForm(4))
		LogTrace("EquipItemArmor "+akRef.GetDisplayName()+" replacing previous armor="+item_already_in_slot.GetName()+" with better "+item_as_armor.GetName())
		return
	endif
	LogTrace("EquipItemArmor "+akRef.GetDisplayName()+"  keeping better previous armor="+item_already_in_slot.GetName()+" not "+item_as_armor.GetName())
EndFunction

Function EquipItemWeapon(Actor akRef, Weapon item_as_weapon, bool should_hold_weapons = true)
	LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" found weapon="+item_as_weapon.GetName())
	if !ShouldEquipWeapon(akRef,item_as_weapon)
		return
	endif
	if !should_hold_weapons
		UnEquipItemLoose(akRef,item_as_weapon) 
		LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" should not hold weapons -> do not equip weapon="+item_as_weapon.GetName())
		return
	endif

	Weapon item_already_equipped = akRef.GetEquippedWeapon()
	LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" found weapon="+item_as_weapon.GetName())
	if item_already_equipped == None
		LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" equip weapon="+item_as_weapon.GetName())
		EquipItemLoose(akRef,item_as_weapon) 
		return
	endif
	
	if item_already_equipped == item_as_weapon
		LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" already equipped weapon="+item_as_weapon.GetName())
		return
	endif
	
	if akRef.IsInFaction(DOMActionWorking) && akRef.GetFactionRank(DOMWorkMode) == 1
		if IsWeaponMineTool(item_already_equipped) ; pickaxe is already equipped
			LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" keep mining tools="+item_already_equipped.GetName()+" instead of "+item_as_weapon.GetName())
			return
		elseif IsWeaponMineTool(item_as_weapon) ; double checking should be useless if pickaxe is already equipped
			UnEquipItemLoose(akRef,item_already_equipped)
			EquipItemLoose(akRef,item_as_weapon) 
			LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" replacing previous weapon="+item_already_equipped.GetName()+" with mining tools "+item_as_weapon.GetName())
		endif
	endif
	
	LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" other weapon="+item_as_weapon.GetName())
	LogTrace("EquipItemWeapon WeaponValues")
	float x = WeaponValue(akRef,item_as_weapon)
	LogTrace("EquipItemWeapon WeaponValue "+item_as_weapon.GetName()+" x ="+x)
	float y = WeaponValue(akRef,item_already_equipped)
	LogTrace("EquipItemWeapon WeaponValue "+item_already_equipped.GetName()+" y ="+y)
	if x > y 
		UnEquipItemLoose(akRef,item_already_equipped)
		EquipItemLoose(akRef,item_as_weapon) 
		LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" replacing previous weapon="+item_already_equipped.GetName()+" y="+y+" with "+item_as_weapon.GetName()+" x="+x)
		return
	endif
	LogTrace("EquipItemWeapon "+akRef.GetDisplayName()+" do not replace previous weapon="+item_already_equipped.GetName()+" y="+y+" with "+item_as_weapon.GetName()+" x="+x)
EndFunction

Function EquipItemAmmo(Actor akRef, Ammo item_as_ammo, bool should_hold_weapons = true)
	LogTrace("EquipItemAmmo found ammo="+item_as_ammo.GetName())
	if !should_hold_weapons
		LogTrace("EquipItemAmmo "+akRef.GetDisplayName()+" should not hold weapons -> strip item="+item_as_ammo.GetName())
		UnEquipItemLoose(akRef,item_as_ammo) 
		return
	endif

	Ammo ammo_already_equipped = akRef.GetEquippedObject(0) as Ammo
	LogTrace("EquipItemAmmo found ammo="+item_as_ammo.GetName())
	if ammo_already_equipped == None
		LogTrace("EquipItemAmmo "+akRef.GetDisplayName()+" equip ammo="+item_as_ammo.GetName())
		EquipItemLoose(akRef,item_as_ammo)
		return
	endif
	
	if ammo_already_equipped == item_as_ammo
		LogTrace("EquipItemAmmo "+akRef.GetDisplayName()+" already equipped weapon="+item_as_ammo.GetName())
		return
	endif

	LogTrace("EquipItemAmmo other ammo="+item_as_ammo.GetName())
	if ammo_already_equipped != item_as_ammo
		float x = AmmoValue(akRef,item_as_ammo)
		float y = AmmoValue(akRef,ammo_already_equipped)
		if x > y 
			UnEquipItemLoose(akRef,ammo_already_equipped)
			EquipItemLoose(akRef,item_as_ammo) ; Ammos are not forced to equip
			LogTrace("EquipItemAmmo "+akRef.GetDisplayName()+" replacing previous Ammo="+ammo_already_equipped.GetName()+" y="+y+" with "+item_as_ammo.GetName()+" x="+x)
			return
		endif
		LogTrace("EquipItemAmmo "+akRef.GetDisplayName()+" do not replace previous Ammo="+ammo_already_equipped.GetName()+" y="+y+" with "+item_as_ammo.GetName()+" x="+x)
		return
	endif
	LogTrace("EquipItemAmmo "+akRef.GetDisplayName()+" do not replace previous Ammo="+ammo_already_equipped.GetName()+" with "+item_as_ammo.GetName())
EndFunction

int Function EquipItemForm(Actor akRef, Form the_form, bool use_light = false, bool should_be_naked, bool should_wear_armor, bool should_hold_weapons)
	int type = the_form.GetType()
	LogTrace("EquipItemForm "+akRef.GetDisplayName()+" "+the_form.GetName()+" type="+type+" naked="+should_be_naked+" armor="+should_wear_armor+" weapons="+should_hold_weapons)	
	if type == 26 ; kArmor 
		Armor item_as_armor = the_form as Armor
		if item_as_armor != None
			EquipItemArmor(akRef,item_as_armor,should_be_naked,should_wear_armor,should_hold_weapons)
			if item_as_armor.IsShield()
				return 4 ; shield
			endif
			if item_as_armor.IsCuirass()
				if item_as_armor.GetArmorRating() > 0.0
					return 33 ; Cuirass + clothes
				endif
				return 32
			endif
			if ProcessItemJewelry(the_form)
				return 64 ; jewelry
			endif
			if item_as_armor.GetArmorRating() > 0.0
				return 3 ; Armor + clothes
			endif
			return 1 ; clothes
		endif
	elseif type == 41 ; kWeapon 
		Weapon item_as_weapon = the_form as Weapon
		if item_as_weapon != None 
			EquipItemWeapon(akRef,item_as_weapon,should_hold_weapons)
			return 8 ; weapon
		endif
	elseif type == 42 ; kAmmo 
		Ammo item_as_ammo = the_form as Ammo
		if item_as_ammo != None 
			EquipItemAmmo(akRef,item_as_ammo,should_hold_weapons)
			return 16 ; ammo
		endif
	else
		EquipItemMisc(akRef,the_form,type,use_light)
	endif
	return 0
EndFunction

int Function EquipItemWearable(Actor akRef, Form the_form, bool use_light = false, bool should_be_naked = false, bool should_wear_armor = true, bool should_hold_weapons = true)
	LogTrace("EquipItemWearable "+akRef.GetDisplayName()+" item="+the_form.GetName()+" should_be_naked="+should_be_naked+" should_wear_armor="+should_wear_armor+" should_hold_weapons="+should_hold_weapons)
	if !isWearable(the_form)
		LogTrace("EquipItemWearable "+akRef.GetDisplayName()+" item is not wearable="+the_form.GetName())
		return 0
	elseif IsItemIgnore(the_form)
		LogTrace("EquipItemWearable ignore item="+the_form.GetName()+" isequipped="+akRef.IsEquipped(the_form))
		return 0
	elseif IsItemSpecial(the_form)
		LogTrace("EquipItemWearable "+akRef.GetDisplayName()+" found special="+the_form.GetName())
		EquipItemSpecial(akRef,the_form)
		return 0
	elseif IsItemDevice(the_form)
		LogTrace("EquipItemWearable "+akRef.GetDisplayName()+" found device="+the_form.GetName())
		EquipItemDevice(akRef,the_form)
		return 0
	endif
	LogTrace("EquipItemWearable "+akRef.GetDisplayName()+" found item="+the_form.GetName())
	return EquipItemForm(akRef,the_form,use_light,should_be_naked,should_wear_armor,should_hold_weapons)
EndFunction

Function EquipLeveledItem(Actor akRef, Form the_leveleditem) ; , bool use_light = false, bool should_be_naked = false, bool should_wear_armor = true, bool should_hold_weapons = true)
	LeveledItem the_list = the_leveleditem as LeveledItem
	if the_list == None
		return
	endif
	akRef.AddItem(the_leveleditem, abSilent = true)
	LogTrace("EquipLeveledItem "+akRef.GetDisplayName()+" adding item "+the_leveleditem.GetName())
EndFunction

Function EquipOutfit(Actor akRef, bool use_light = false, bool should_be_naked = false, bool should_wear_armor = true, bool should_hold_weapons = true)
	ActorBase abRef = akRef.GetLeveledActorBase()
	Outfit outf = abRef.GetOutfit()
	if outf == None
		LogTrace("EquipOutfit no outfit for "+akRef.GetDisplayName())
		return
	endif
	if outf == DOMNothingOutfit
		LogTrace("EquipOutfit DOM nothing outfit for "+akRef.GetDisplayName())
		return
	endif
	LogTrace("EquipOutfit outfit="+outf.GetName()+" start for "+akRef.GetDisplayName())
	Form the_form
	Int i = outf.GetNumParts()
	while i > 0
		i -= 1
		the_form = outf.GetNthPart(i)
		if the_form != None
			if the_form.GetType() == 53 ; kLeveledItem 
				LogTrace("EquipOutfit EquipLeveledItem "+akRef.GetDisplayName()+" "+the_form.GetName())
				EquipLeveledItem(akRef,the_form) ; ,use_light,should_be_naked,should_wear_armor,should_hold_weapons)
			else
				LogTrace("EquipOutfit EquipItemWearable "+akRef.GetDisplayName()+" "+the_form.GetName())
				EquipItemWearable(akRef,the_form,use_light,should_be_naked,should_wear_armor,should_hold_weapons)
			endif
		endif
	endWhile
	LogTrace("EquipOutfit outfit end "+akRef.GetDisplayName()+" number of items in outfit="+outf.GetNumParts())
EndFunction

; Equipment process

bool Function ProcessToBeStripped(Form the_form)
	; Only strip armors
	if !isClothesOrArmor(the_form)
		return false
	endif
	if IsItemIgnore(the_form)
		LogTrace("DO NOT STRIP nude bodies "+the_form.GetName()) 
		return false
	endif
	if IsItemSpecial(the_form)
		LogTrace("DO NOT STRIP special FX "+the_form.GetName()) 
		return false
	endif
	
	; Do not strip restrains
	if IsItemDevice(the_form)
		LogTrace("DO NOT STRIP device "+the_form.GetName()) 
		return false
	elseif DOMSexlab.HasNoStripKeyword(the_form)
		LogTrace("DO NOT STRIP keyword SexLabNoStrip "+the_form.GetName()) 
		return false
	elseif DOMSexlab.HasAlwaysStripKeyword(the_form)
		LogTrace("ALWAYS STRIP keyword SexLabAlwaysStrip "+the_form.GetName()) 
		return true
	endif
	
	; Check for non armor items
	Armor the_armor = the_form as Armor
	if the_armor == None
		return false ; do not strip items if not armor at this point
	endif

	; Do not strip special armor slots
	if neverStripFX
		if IsItemSpecialNeverStrip(the_form)
			return false
		endif
	elseif IsItemSpecial(the_form)
		return false
	endif
	
	; Always not stripped items
	
	; Check for jewelry
	if !stripJewelryToggle
		 if ProcessItemJewelry(the_form)
			LogTrace("DO NOT STRIP jewelry "+the_form.GetName()) 
			return false
		endif
	endif

	; Check for underwear unregister if needed
	if resetStripKeywords
		if the_form.HasKeyword(ClothingLingerie)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,ClothingLingerie)
		elseif  the_form.HasKeyword(ClothingNotLingerie)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,ClothingNotLingerie)
		endif
	endif
	; Check for underwear with main keyword
	if the_form.HasKeyword(ClothingLingerie)
		if !stripUnderwearToggle
			LogTrace("DO NOT STRIP lingerie "+the_form.GetName()) 
			return false
		else
			LogTrace("ALWAYS STRIP lingerie "+the_form.GetName()) 
			return true
		endif
	; Check for underwear reset keyword
	elseif !the_form.HasKeyword(ClothingNotLingerie)
		LogTrace("ProcessToBeStripped() checking item for being lingerie "+the_form.GetName())
		bool is_underwear = ProcessItemLingerie(the_form)
		if useStripKeywords
			if is_underwear
				LogTrace("ProcessToBeStripped() registering form to lingerie "+the_form.GetName())
				if the_form.HasKeyword(ClothingNotLingerie)
					PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,ClothingNotLingerie)
				endif
				PO3_SKSEFunctions.AddKeywordToForm(the_form,ClothingLingerie)
			else
				LogTrace("ProcessToBeStripped() registering form to not lingerie "+the_form.GetName())
				if the_form.HasKeyword(ClothingLingerie)
					PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,ClothingLingerie)
				endif
				PO3_SKSEFunctions.AddKeywordToForm(the_form,ClothingNotLingerie)
			endif
		endif
		if is_underwear
			if !stripUnderwearToggle
				LogTrace("DO NOT STRIP lingerie "+the_form.GetName()) 
				return false
			else
				LogTrace("ALWAYS STRIP lingerie "+the_form.GetName()) 
				return true
			endif
		endif
	endif

	; Check for heels unregister if needed
	if resetStripKeywords
		if the_form.HasKeyword(ClothingHeels)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,ClothingHeels)
		elseif  the_form.HasKeyword(ClothingNotHeels)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,ClothingNotHeels)
		endif
	endif
	; Check for heels with main keyword
	if the_form.HasKeyword(ClothingHeels)
		if !stripHeelsToggle
			LogTrace("DO NOT STRIP heels "+the_form.GetName()) 
			return false
		else
			LogTrace("ALWAYS STRIP heels "+the_form.GetName()) 
			return true
		endif
	; Check for heels reset keyword
	elseif !the_form.HasKeyword(ClothingNotHeels)
		bool is_heels = ProcessItemHeels(the_form)
		if useStripKeywords
			if is_heels
				LogTrace("ProcessToBeStripped() registering form to heels "+the_form.GetName())
				if the_form.HasKeyword(ClothingNotHeels)
					PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,ClothingNotHeels)
				endif
				PO3_SKSEFunctions.AddKeywordToForm(the_form,ClothingHeels)
			else
				LogTrace("ProcessToBeStripped() registering form to not heels "+the_form.GetName())
				if the_form.HasKeyword(ClothingHeels)
					PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,ClothingHeels)
				endif
				PO3_SKSEFunctions.AddKeywordToForm(the_form,ClothingNotHeels)
			endif
		endif
		if is_heels
			if !stripHeelsToggle
				LogTrace("DO NOT STRIP heels "+the_form.GetName()) 
				return false
			else
				LogTrace("ALWAYS STRIP heels "+the_form.GetName()) 
				return true
			endif
		endif
	endif

	; Strip
	LogTrace("ALWAYS STRIP "+the_form.GetName()) 
	return true
EndFunction

; Process items

bool Function ProcessItemHeels(Form the_form)
	if the_form.HasKeyword(ClothingHeels)
		return true
	elseif the_form.HasKeyword(ClothingNotHeels)
		return false
	endif
	
	string fname = the_form.getName()
	if StringUtil.Find(fname, "heels")>=0 
		LogTrace("DO NOT STRIP heels "+the_form.GetName()) 
		return true
	endif
	return false
EndFunction

bool Function ProcessItemLingerie(Form the_form)
	LogTrace("ProcessItemLingerie "+the_form.GetName())
	if the_form.HasKeyword(ClothingLingerie)
		return true
	elseif the_form.HasKeyword(ClothingNotLingerie)
		return false
	elseif the_form.HasKeyword(ClothingUnderwear)
		return true
	elseif ClothingPanties != None && the_form.HasKeyword(ClothingPanties)
		return true
	elseif ClothingBra != None && the_form.HasKeyword(ClothingBra)
		return true
	elseif Panties != None && the_form.HasKeyword(Panties)
		return true
	elseif Bra != None && the_form.HasKeyword(Bra)
		return true
	elseif Lingerie != None && the_form.HasKeyword(Lingerie)
		return true
	elseif Underwear != None && the_form.HasKeyword(Underwear)
		return true
	elseif FemalePanties != None && the_form.HasKeyword(FemalePanties)
		return true
	endif
		
	string fname = the_form.getName()
	if StringUtil.Find(fname, "lingerie")>=0 
		LogTrace("ProcessItemLingerie lingerie "+the_form.GetName())
		return true
	elseif StringUtil.Find(fname, "panties")>=0 
		LogTrace("ProcessItemLingerie panties "+the_form.GetName())
		return true
	elseif StringUtil.Find(fname, "panty")>=0 ; including pantyhose
		LogTrace("ProcessItemLingerie panty "+the_form.GetName())
		return true
	elseif StringUtil.Find(fname, "underwear")>=0 
		LogTrace("ProcessItemLingerie underwear "+the_form.GetName())
		return true
	elseif StringUtil.Find(fname, "stocking")>=0 
		LogTrace("ProcessItemLingerie stocking "+the_form.GetName())
		return true
	elseif StringUtil.Find(fname, "nightie")>=0 
		LogTrace("ProcessItemLingerie nightie "+the_form.GetName())
		return true
	elseif StringUtil.Find(fname, "garter")>=0 
		LogTrace("ProcessItemLingerie garter "+the_form.GetName())
		return true
	elseif StringUtil.Find(fname, "bikini")>=0 
		LogTrace("ProcessItemLingerie bikini "+the_form.GetName())
		return true
	elseif StringUtil.Find(fname, " bra ")>=0 ; might be triggered on quite a few other words though
		LogTrace("ProcessItemLingerie BRA "+the_form.GetName())
		return true
	endif
	LogTrace("ProcessItemLingerie false "+the_form.GetName())
	return false
EndFunction

bool Function ProcessItemJewelry(Form the_form)
	if !isClothesOrArmor(the_form)
		return false
	endif
	if the_form.HasKeyword(JewelryExpensive)
		return true
	endif
	if the_form.HasKeyword(VendorItemJewelry)
		return true
	endif
	if the_form.HasKeyword(ArmorJewelry)
		return true
	endif
	if ClothingJewelry != None && the_form.HasKeyword(ClothingJewelry)
		return true
	endif	
	return false
EndFunction

bool Function ProcessItemDevice(Form the_form)
	; Only consider armors
	if !isClothesOrArmor(the_form)
		return false
	endif

	return DOMZaz.IsItemDevice(the_form)
EndFunction

bool Function ProcessItemIgnore(Form the_form)
	; Only consider armors
	if !isClothesOrArmor(the_form)
		return false
	endif
	string nameString = the_form.GetName()
	if(stringUtil.find(nameString,"OBody Nude")>=0)
		LogTrace("ProcessItemIgnore "+nameString+" YES "+the_form)
		return true
	endif
	if nameString == ""
		LogTrace("ProcessItemIgnore unnamed form YES "+the_form)
		return true
	endif
	return false
EndFunction

bool Function ProcessItemSpecial(Form the_form)
	; Only consider armors
	if !isClothesOrArmor(the_form)
		return false
	endif

	; Do not strip wigs or special armor slots
	Armor the_armor = the_form as Armor
	; Wigs
	if isWig(the_armor)
		LogTrace("ProcessItemSpecial SPECIAL WIG ITEM found"+the_form.GetName()) 
		return true
	endif
		
	int slotmask = Math.LogicalAnd(the_armor.GetSlotMask(), 0x00002FFF) ; other slots should be ignored
	LogTrace("ProcessItemSpecial "+the_form.GetName()+" slots="+ConvertIDToHex(slotmask))
	; Do not strip special armor slots
	if slotmask == 0x40000000 ; kSlotMask60 - slots 60 ; Unnamed
		LogTrace("ProcessItemSpecial SPECIAL FX ITEM found in slot 60"+the_form.GetName()) 
		return true
	endif
	if slotmask == 0x80000000 ; kSlotMask61 - 61 ; FX01
		LogTrace("ProcessItemSpecial SPECIAL FX ITEM found in slot 61 "+the_form.GetName()) 
		return true
	endif
	if slotmask == 0x00000002 ; Math.LogicalAnd(slotmask, 0x00000002) == 0x00000002 ; kSlotMask31 - slot 31 ; Hair
		LogTrace("ProcessItemSpecial SPECIAL HAIR ITEM found in slot 31 "+the_form.GetName()) 
		return true
	endif
	if  slotmask == 0x00000800 ;  ; Math.LogicalAnd(slotmask, 0x00000800) == 0x00000800 ; kSlotMask41  - slot 41 ; LongHair
		LogTrace("ProcessItemSpecial SPECIAL LONG HAIR ITEM found in slot 41 "+the_form.GetName()) 
		return true
	endif
	if  slotmask == 0x00000802 ;  Hair & LongHair
		LogTrace("ProcessItemSpecial SPECIAL LONG HAIR ITEM found in slot 41 "+the_form.GetName()) 
		return true
	endif
	if slotmask == 0x00100000 ; kSlotMask50 - 50 = DecapitateHead
		LogTrace("ProcessItemSpecial SPECIAL DecapitateHead ITEM found in slot 50 "+the_form.GetName()) 
		return true
	endif
	if slotmask == 0x00200000 ; kSlotMask51 - 51 = Decapitate
		LogTrace("ProcessItemSpecial SPECIAL Decapitate ITEM found in slot 51 "+the_form.GetName()) 
		return true
	endif
	if maskPubicArea
		if slotmask == 0x00400000 ; kSlotMask52 - 52 = used by SOS and pubic hair
			LogTrace("ProcessItemSpecial SPECIAL SOS ITEM found in slot 52 "+the_form.GetName()) 
			return true
		endif
	endif
	if maskFillHerUp
		if slotmask == 0x00040000 ; kSlotMask48 - 48 = Fill Her Up Anal & Oral leak
			LogTrace("ProcessItemSpecial SPECIAL Fill Her Up Anal & Oral leak ITEM found in slot 48 "+the_form.GetName()) 
			return true
		endif
		if slotmask == 0x00800000 ; kSlotMask53 - 53 = Fill Her Up Inflater
			LogTrace("ProcessItemSpecial SPECIAL Fill Her Up Inflater ITEM found in slot 53 "+the_form.GetName()) 
			return true
		endif
		if slotmask == 0x01000000 ; kSlotMask54 - 54 = Fill Her Up Vaginal leak
			LogTrace("ProcessItemSpecial SPECIAL Fill Her Up Vaginal leak ITEM found in slot 54 "+the_form.GetName()) 
			return true
		endif
		if slotmask == 0x02000000 ; kSlotMask55 - 55 = Fill Her Up Tongue
			LogTrace("ProcessItemSpecial SPECIAL Fill Her Up Tongue ITEM found in slot 55 "+the_form.GetName()) 
			return true
		endif
	endif
	LogTrace("ProcessItemSpecial ITEM IS NOT HAIR/FX slotmask="+slotmask+" for "+the_form.GetName()) 
	return false
EndFunction

; Item types

int Function GetMaterial(Form cuffs)
	if cuffs.haskeyword(ArmorMaterialFiber)
		return 1 ; ropes
	endif
	if cuffs.haskeyword(ArmorMaterialSteel)
		return 4 ; steel
	endif
	if cuffs.haskeyword(ArmorMaterialIron)
		return 3 ; iron
	endif
	if cuffs.haskeyword(ArmorMaterialLeather)
		return 2 ; leather
	endif
	return 1 ; ropes
EndFunction

float Function GetMaterialModifier(Form cuffs)
	if DOMZaz.hasKeywordFurniture(cuffs)
		return 5.0
	endif
	if cuffs.haskeyword(ArmorMaterialSteel)
		return 4.0
	endif
	if cuffs.haskeyword(ArmorMaterialIron)
		return 3.0
	endif
	if cuffs.haskeyword(ArmorMaterialLeather)
		return 2.5
	endif
	if cuffs.haskeyword(ArmorMaterialFiber)
		return 2.0
	endif
	return 1.0
EndFunction


bool Function isWig(Armor wig)
	if wig == none
		return false
	endif
	LogTrace("Looking up for wig "+wig.GetName())
	if wig.HaskeywordString("ArmorMaterialKSWigs")
		LogTrace("Found KS1 wig "+wig.GetName())
		return true
	endif
	string wigName = wig.getName()
	if (StringUtil.substring(wigName,0,5) == "KSSMP")
		LogTrace("Found KS2 wig "+wigName)
		return true
	elseif (StringUtil.substring(wigName,0,4) == "[KS]")
		LogTrace("Found KS3 wig "+wigName)
		return true
	elseif (StringUtil.substring(wigName,0,4) == "[HG]")
		LogTrace("Found HG wig "+wigName)
		return true
	elseif (StringUtil.substring(wigName,0,4) == "[HH]")
		LogTrace("Found HH wig "+wigName)
		return true
	elseif (StringUtil.substring(wigName,0,4) == "[SG]")
		LogTrace("Found SG wig "+wigName)
		return true
	elseif (StringUtil.substring(wigName,0,6) == "[FUSE]")
		LogTrace("Found FUSE wig "+wigName)
		return true
	elseif (StringUtil.substring(wigName,0,3) == "YD ")
		LogTrace("Found YD wig "+wigName)
		return true
	elseif (StringUtil.substring(wigName,0,11) == "[BDOR Hair]")
		LogTrace("Found BDOR wig "+wigName)
		return true
	else
		return false
	endif
endFunction

Form Function FindLight(Actor akRef)
	Int n = akRef.GetNumItems()
	Int i = n
	while i > 0
		i -= 1
		Light the_light = akRef.GetNthForm(i) as Light
		if the_light != None 
			LogTrace("FindLight in loop form="+the_light)
			return the_light
		endif
	endwhile
	return Torch01
EndFunction

Function CheckLight(Actor akRef)
	Light the_light 
	the_light = akRef.GetEquippedObject(0) as Light
	if the_light != None
		return
	endif
	the_light = akRef.GetEquippedObject(1) as Light
	if the_light != None
		return
	endif
	EquipLight(akRef)
EndFunction

Function EquipLight(Actor akRef)
	Form the_light = FindLight(akRef)
	AddItemNoChange(akRef,the_light)
	EquipItemLoose(akRef,the_light)
EndFunction

Function UnequipLight(Actor akRef)
	Form the_light = FindLight(akRef)
	if akRef.IsEquipped(the_light)
		UnEquipItemLoose(akRef,the_light)
	endif
EndFunction

bool Function IsLight(Form akBaseObject)
	Light the_light = akBaseObject as Light
	if the_light == None
		return false
	endif
	return true
EndFunction

Function EquipPick(Actor akRef)
	int n = mineOreToolsList.GetSize()
	Form the_form
	if akRef.GetItemCount(mineOreToolsList) == 0
		int i = RandomInt(0,n)
		if i >= n
			i = 0
		endif
		the_form = mineOreToolsList.GetAt(i)
		;*ogTrace("EquipMiningTools get and equip "+the_form.GetName()+" "+the_form)
		AddItemNoChange(akRef,the_form)
	else
		int i = 0
		while i < n
			the_form = mineOreToolsList.GetAt(i)
			if akRef.getItemCount(the_form) > 0
				;*ogTrace("EquipMiningTools equip "+the_form.GetName()+" "+the_form)
				i = n
			endif
			i += 1
		EndWhile
	endif
	if the_form == None ; Check that a pick was found from the list or just use a pick
		the_form = weapPickaxe
		if akRef.getItemCount(the_form) == 0
			AddItemNoChange(akRef,the_form)
		endif
	endif
	EquipItemLoose(akRef,the_form)
EndFunction

Function UnequipPick(Actor akRef)
	if akRef.GetItemCount(mineOreToolsList) == 0
		return
	endif
	int n = mineOreToolsList.GetSize()
	int i = 0
	while i < n
		Form the_form = mineOreToolsList.GetAt(i)
		if akRef.getItemCount(the_form) > 0
			UnEquipItemLoose(akRef,the_form)
		endif
		i += 1
	EndWhile
EndFunction

bool Function IsWeaponMineTool(Form akSource)
	if mineOreToolsList.hasForm(akSource)
		return true; do not equip weapons if using tools (working)
	endif
	return false
EndFunction

Function EquipBroom(Actor akRef)
	;*ogTrace("Equip broom")	
	AddItemNoChange(akRef,broom01)
	EquipItemLoose(akRef,broom01) 
EndFunction

Function UnequipBroom(Actor akRef)
	int nb = akRef.getItemCount(broom01)
	if nb > 0 
		;*ogTrace("Unequip broom")	
		UnEquipItemLoose(akRef,broom01)
	endif
EndFunction

bool Function IsCleaningTool(Form akBaseObject)
	if akBaseObject == broom01
		return true
	endif
	return false
EndFunction

Function EquipWhip(Actor akRef)
	LogTrace("EquipWhip")
	AddItemNoChange(akRef,DOMWhip)
	EquipItemLoose(akRef,DOMWhip)
EndFunction

Function UnequipWhip(Actor akRef)
	int nb = akRef.getItemCount(DOMWhip)
	if nb > 0 
		UnEquipItemLoose(akRef,DOMWhip)
	endif
	if nb > 1
		akRef.RemoveItem(DOMWhip)
	endif
	LogTrace("Unequip whip")	
EndFunction

bool Function IsWeaponWhip(Form akSource)
	if akSource.HasKeyword(WeapMaterialLeather)
		LogTrace("IsWeaponWhip WeapMaterialLeather "+akSource.GetName()) 
		return true
	endif
	if WeapTypeWhip != None && akSource.HasKeyword(WeapTypeWhip)
		LogTrace("IsWeaponWhip WeapTypeWhip "+akSource.GetName()) 
		return true
	endif
	if WeapTypeWhipAA != None && akSource.HasKeyword(WeapTypeWhipAA)
		LogTrace("IsWeaponWhip WeapTypeWhipAA "+akSource.GetName()) 
		return true
	endif
	LogTrace("IsWeaponWhip NO "+akSource.GetName()) 
	return false
EndFunction

bool Function IsWeaponCane(Form akSource)
	LogTrace("IsWeaponCane wood="+WeapMaterialWood+" "+akSource.GetName()+" wood="+akSource.HasKeyword(WeapMaterialWood)) 
	if akSource.HasKeyword(WeapMaterialWood)
		LogTrace("IsWeaponCane WeapMaterialWood "+akSource.GetName()) 
		return true
	endif
	LogTrace("IsWeaponCane NO "+akSource.GetName()) 
	return false
EndFunction

bool Function IsWeaponSlap(Form akSource)
	if akSource.HasKeyword(WeapTypeUnarmed)
		LogTrace("IsWeaponSlap WeapTypeUnarmed "+akSource.GetName()) 
		return true
	endif
	LogTrace("IsWeaponSlap NO "+akSource.GetName()) 
	return false
EndFunction

bool Function IsItemDevice(Form the_form)
	LogTrace("IsItemDevice() "+the_form.GetName())
	; Only consider armors
	if !isClothesOrArmor(the_form)
		return false
	endif

	if resetStripKeywords
		if the_form.HasKeyword(DOMNotDevice)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMNotDevice)
		endif
		if the_form.HasKeyword(DOMIsDevice)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMIsDevice)
		endif
	endif

	if useStripKeywords
		; Do not strip already processed items
		if the_form.HasKeyword(DOMIsDevice)
			LogTrace("IsItemDevice() form already known as device "+the_form.GetName())
			return true
		elseif the_form.HasKeyword(DOMNotDevice)
			LogTrace("IsItemDevice() form already known not a device "+the_form.GetName())
			return false
		endif
	endif
	
	bool is_device = ProcessItemDevice(the_form)
	if useStripKeywords
		if is_device 
			LogTrace("IsItemDevice() registering form as device "+the_form.GetName())
			if the_form.HasKeyword(DOMNotDevice)
				PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMNotDevice)
			endif
			PO3_SKSEFunctions.AddKeywordToForm(the_form,DOMIsDevice)
		else
			LogTrace("IsItemDevice() registering form not a device "+the_form.GetName())
			if the_form.HasKeyword(DOMIsDevice)
				PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMIsDevice)
			endif
			PO3_SKSEFunctions.AddKeywordToForm(the_form,DOMNotDevice)
		endif
	endif
	LogTrace("IsItemDevice() "+the_form.GetName()+" "+is_device)
	return is_device
EndFunction

bool Function IsItemIgnore(Form the_form)
	; Only consider armors
	if !isClothesOrArmor(the_form)
		return false
	endif

	if resetStripKeywords
		if the_form.HasKeyword(DOMIsIgnore)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMNotSpecial)
		endif
	endif

	if useStripKeywords
		; Do not strip already processed items
		if the_form.HasKeyword(DOMIsIgnore)
			LogTrace("IsItemIgnore() form already known as ignore "+the_form.GetName())
			return true
		elseif the_form.HasKeyword(DOMNotIgnore)
			LogTrace("IsItemIgnore() form already known not ignore "+the_form.GetName())
			return false
		endif
	endif
	
	bool is_ignore = ProcessItemIgnore(the_form)
	if useStripKeywords
		if is_ignore
			LogTrace("IsItemIgnore() registering form to ignore "+the_form.GetName())
			if the_form.HasKeyword(DOMNotIgnore)
				PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMNotIgnore)
			endif
			PO3_SKSEFunctions.AddKeywordToForm(the_form,DOMIsIgnore)
		else
			LogTrace("IsItemIgnore() registering form not to ignore "+the_form.GetName())
			if the_form.HasKeyword(DOMIsIgnore)
				PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMIsIgnore)
			endif
			PO3_SKSEFunctions.AddKeywordToForm(the_form,DOMNotIgnore)
		endif
	endif
	return is_ignore
EndFunction

bool Function IsItemSpecial(Form the_form)
	; Only consider armors
	if !isClothesOrArmor(the_form)
		return false
	endif

	if resetStripKeywords
		if the_form.HasKeyword(DOMNotSpecial)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMNotSpecial)
		endif
		if the_form.HasKeyword(DOMIsSpecial)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMIsSpecial)
		endif
	endif

	if useStripKeywords
		; Do not strip already processed items
		if the_form.HasKeyword(DOMIsSpecial)
			LogTrace("IsItemSpecial() form already known as special "+the_form.GetName())
			return true
		elseif the_form.HasKeyword(DOMNotSpecial)
			LogTrace("IsItemSpecial() form already known not special "+the_form.GetName())
			return false
		endif
	endif
	
	bool is_special = ProcessItemSpecial(the_form)
	if useStripKeywords
		if is_special
			LogTrace("IsItemSpecial() registering form as special "+the_form.GetName())
			if the_form.HasKeyword(DOMNotSpecial)
				PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMNotSpecial)
			endif
			PO3_SKSEFunctions.AddKeywordToForm(the_form,DOMIsSpecial)
		else
			LogTrace("IsItemSpecial() registering form not special "+the_form.GetName())
			if the_form.HasKeyword(DOMIsSpecial)
				PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMIsSpecial)
			endif
			PO3_SKSEFunctions.AddKeywordToForm(the_form,DOMNotSpecial)
		endif
	endif
	return is_special
EndFunction

bool Function IsToBeStripped(Form the_form)
	; Only consider armors
	if !isClothesOrArmor(the_form)
		return true
	endif

	; Reset keywords
	if resetStripKeywords
		if the_form.HasKeyword(DOMNoStrip)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMNoStrip)
		endif
		if the_form.HasKeyword(DOMAlwaysStrip)
			PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMAlwaysStrip)
		endif
	endif

	; Check for shields
	Armor the_armor = the_form as Armor
	if the_armor!= None && the_armor.IsShield()
		if !stripShieldsToggle
			LogTrace("IsToBeStripped() DO NOT STRIP shield "+the_form.GetName()) 
			return false
		else
			LogTrace("IsToBeStripped() ALWAYS STRIP shield "+the_form.GetName()) 
			return true
		endif
	endif
	
	if useStripKeywords
		; Do not strip already processed items
		if the_form.HasKeyword(DOMNoStrip)
			LogTrace("IsToBeStripped() form already known to never strip "+the_form.GetName())
			return false
		elseif the_form.HasKeyword(DOMAlwaysStrip)
			LogTrace("IsToBeStripped() form already known to always strip "+the_form.GetName())
			return true
		endif
	endif
	
	bool is_stripped = ProcessToBeStripped(the_form)
	if useStripKeywords
		if is_stripped
			LogTrace("IsToBeStripped() registering form to always strip "+the_form.GetName())
			if the_form.HasKeyword(DOMNoStrip)
				PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMNoStrip)
			endif
			PO3_SKSEFunctions.AddKeywordToForm(the_form,DOMAlwaysStrip)
		else
			LogTrace("IsToBeStripped() registering form to never strip "+the_form.GetName())
			if the_form.HasKeyword(DOMAlwaysStrip)
				PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,DOMAlwaysStrip)
			endif
			PO3_SKSEFunctions.AddKeywordToForm(the_form,DOMNoStrip)
		endif
	endif
	LogTrace("IsToBeStripped() CHECK STRIP result="+is_stripped+" for"+the_form.GetName()) 
	return is_stripped
EndFunction

int Function EquipWeapon(Actor akRef)
	LogTrace("EquipWeapon start "+akRef.GetDisplayName())
	Weapon orig_weapon = GetEquippedWeapon(akRef)
	Ammo orig_ammo = akRef.GetEquippedObject(0) as Ammo ; left hand
	Weapon the_weapon = orig_weapon
	Ammo the_ammo = orig_ammo
	float x_weapon = 0.0
	float x_ammo = 0.0
	float x = 0.0
	bool has_weapon = false
	bool has_ammo = false
	if the_weapon != None
		LogTrace("EquipWeapon weapon="+the_weapon.GetName())
		if ShouldEquipWeapon(akRef,the_weapon)
			x_weapon = WeaponValue(akRef,the_weapon)
			has_weapon = true
		else
			x_weapon = 0.0
		endif
	endif
	if the_ammo != None
		LogTrace("EquipWeapon ammo="+the_ammo.GetName())
		x_ammo = AmmoValue(akRef,the_ammo)
		has_ammo = true
	endif
	bool changed_weapon = false
	bool changed_ammo = false
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		Form the_form = akRef.GetNthForm(i)
		if the_form != None && isWeaponOrAmmo(the_form)
			Weapon weap = the_form as Weapon
			if weap != None
				LogTrace("EquipWeapon found weapon "+akRef.GetDisplayName()+" "+weap.GetName())
				if weap != the_weapon
					if ShouldEquipWeapon(akRef,weap)
						x = WeaponValue(akRef,weap)
					else
						x = 0.0
					endif
					if x > x_weapon
						the_weapon = weap
						x_weapon = x
						changed_weapon = true
						LogTrace("EquipWeapon found better weapon "+akRef.GetDisplayName()+" "+the_weapon.GetName())
					endif
				endif
			else
				Ammo amm = the_form as Ammo
				if amm != None
					LogTrace("EquipWeapon found ammo "+akRef.GetDisplayName()+" "+amm.GetName())
					if amm != the_ammo
						x = AmmoValue(akRef,amm)
						if x > x_ammo
							the_ammo = amm
							x_ammo = x
							changed_ammo = true
							LogTrace("EquipWeapon found better ammo "+akRef.GetDisplayName()+" "+the_ammo.GetName())
						endif
					endif
				endif
			endif
		endif
	endwhile
	if changed_weapon
		;if orig_weapon != None && akRef.IsEquipped(orig_weapon)
		;	UnEquipItemLoose(akRef,orig_weapon)
		;endif
		EquipItemLoose(akRef,the_weapon)
		has_weapon = true
	endif
	if changed_ammo
		;if orig_ammo != None && akRef.IsEquipped(orig_ammo)
		;	UnEquipItemLoose(akRef,orig_ammo, false, true)
		;endif
		EquipItemLoose(akRef,the_ammo)
		has_ammo = true
	endif
		
	int type_equip = 0
	if has_weapon
		type_equip += 8 ; weapon
	endif
	if has_ammo
		type_equip += 16 ; ammo
	endif
	LogTrace("EquipWeapon close "+akRef.GetDisplayName()+" changed="+changed_weapon+" "+changed_ammo+" has="+has_weapon+" "+has_ammo)
	return type_equip
EndFunction

bool Function ShouldEquipWeapon(Actor akRef, Weapon item_as_weapon)
	if akRef.isInFaction(DOMActionWorking) && akRef.GetFactionRank(DOMWorkMode) == 1
		if !IsWeaponMineTool(item_as_weapon)
			return false; do not equip weapons if using tools (working)
		endif
	elseif akRef.isInFaction(DOMActionPunishing)
		if !DOMZaz.IsWeaponPunishment(item_as_weapon)
			return false
		endif
	endif
	return true
EndFunction

; has Equipment

bool Function HasShameClothes(Actor akRef)
	string name = akRef.GetDisplayName()
	if akRef.WornHasKeyword(ClothingPoor)
		LogTrace("HasShameClothes: "+name+" has poor clothes")
		return true
	endif
	if akRef.WornHasKeyword(ClothingSexy)
		LogTrace("HasShameClothes: "+name+" has sexy clothes")
		return true
	endif
	if akRef.WornHasKeyword(ClothingShame)
		LogTrace("HasShameClothes: "+name+" has shame clothes")
		return true
	endif
	if EroticArmor != None && akRef.WornHasKeyword(EroticArmor)
		LogTrace("HasShameClothes: "+name+" has erotic armor")
		return true
	endif
	if DOMZad.wornHumiliating(akRef)
		LogTrace("HasShameClothes: "+name+" Zad worn humiliating")
		return true
	endif
	Armor equippedArmor = akRef.GetWornForm(0x00000004) as Armor
	if equippedArmor != None
		if shameArea52 && Math.LogicalAnd(equippedArmor.GetSlotMask(), 0x00400000) ; armor has slot kSlotMask52 - 52 = used by SOS and pubic hair
			LogTrace("HasShameClothes: "+name+" showing SOS or pubic hair")
			return true
		endif
		if has_SOS
			if SOS_SKSE.IsRevealing(equippedArmor)
				LogTrace("HasShameClothes: "+name+" wearing revealing armor")
				return true
			endif
		endif
	else
		if HasEquippedClothes(akRef)
			LogTrace("HasShameClothes: "+name+" is not wearing a body armor")
			return true ; Not wearing armor or clothes covering body parts
		endif
	endif
	
	LogTrace("HasShameClothes: "+name+" is not wearing any humiliating clothes")
	return false
EndFunction

bool Function HasEquippedClothes(Actor akRef)
	if DOMPAH.HasCountAsNaked(akRef)
		return false
	endif
	Armor  ws
	ws = akRef.GetWornForm(0x00000004) as Armor ; Cuirass
	if ws != None && isToBeStripped(ws)
		return true
	endif
	ws = akRef.GetWornForm(0x00000001) as Armor ; Head
	if ws != None && isToBeStripped(ws)
		return true
	endif
	ws = akRef.GetWornForm(0x00000008) as Armor ; Hands
	if ws != None && isToBeStripped(ws)
		return true
	endif
	ws = akRef.GetWornForm(0x00000080) as Armor
	if ws != None && isToBeStripped(ws)
		return true
	endif
	return false
EndFunction

bool Function HasClothes(Actor akRef) ; check for any covering clothes in inventory
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		Form the_form = akRef.GetNthForm(i)
		if the_form != None && isClothesOrArmor(the_form)
			if isToBeStripped(the_form)
				LogTrace("HasClothes "+akRef.GetDisplayName()+" found covering clothes: "+the_form.GetName()) 
				return true
			endif
		endif
	endwhile
	return false
EndFunction

int Function HasJewelry(Actor akRef)
	; Check
	int n_jewelry = 0
	Form the_form
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		the_form = akRef.GetNthForm(i)
		if the_form != None
			bool is_device = IsItemDevice(the_form)
			if !is_device ; Do not count devices as jewelry
				bool is_jewelry = ProcessItemJewelry(the_form)
				if is_jewelry
					n_jewelry += the_form.GetGoldValue()
					LogTrace("HasJewelry: "+akRef.GetDisplayName()+" has jewelry "+the_form.getName()+" value="+the_form.GetGoldValue())
				else
					bool is_rich = the_form.HasKeyword(ClothingRich)
					if is_rich
						LogTrace("HasJewelry: "+akRef.GetDisplayName()+" has rich clothes "+the_form.getName()+" value="+the_form.GetGoldValue())
						n_jewelry += the_form.GetGoldValue()
					endif
				endif
			endif
		endif
	endWhile

	return n_jewelry
EndFunction

int Function HasGold(Actor akRef)
	; Check gold amount
	return akRef.GetItemCount(Gold001)
EndFunction

; Gear factions 

Function SetAllowGearFaction(Actor akRef, bool gear_allowed, bool is_slave)
	if !gear_allowed
		if !akRef.IsInFaction(DOMShouldNotWearGear)
			akRef.AddToFaction(DOMShouldNotWearGear)
		endif
		return
	endif
	if is_slave
		if allowSlavesGearToggle
			if akRef.IsInFaction(DOMShouldNotWearGear)
				akRef.RemoveFromFaction(DOMShouldNotWearGear)
			endif
		elseif !akRef.IsInFaction(DOMShouldNotWearGear)
			akRef.AddToFaction(DOMShouldNotWearGear)
		endif
		return
	endif
	if allowSlaversGearToggle
		if akRef.IsInFaction(DOMShouldNotWearGear)
			akRef.RemoveFromFaction(DOMShouldNotWearGear)
		endif
		return
	endif
	if !akRef.IsInFaction(DOMShouldNotWearGear)
		akRef.AddToFaction(DOMShouldNotWearGear)
	endif
EndFunction

; Capture/Recruit and outfit

Function CheckCloneEquipment(ActorBase original_base, Actor original, Actor clone)
	ActorBase clone_base = clone.GetLeveledActorBase()
	clone.RemoveAllItems()
	Outfit outf = original_base.GetOutfit()
	LogTrace("CheckCloneEquipment "+clone.GetDisplayName()+" original outfit="+outf)
	LogTrace("CheckCloneEquipment "+clone.GetDisplayName()+" clone outfit="+clone_base.GetOutfit().GetName())
	if outf != None && outf != clone_base.GetOutfit()
		clone.SetOutfit(outf)
	endif
	LogTrace("CheckCloneEquipment "+clone.GetDisplayName()+" outfit="+outf.GetName())
	Int i = original.GetNumItems()
	bool check_defeat = DOMZaz.HasDefeat()
	Form the_form
	While i > 0
		i -= 1
		the_form = original.GetNthForm(i)
		If !(check_defeat && DOMZaz.HasDefeatWornDevice(the_form))
			int nb = clone.getItemCount(the_form)			
			if nb <= 0 ; only add items not in inventory 
				Armor the_armor = the_form as Armor
				if the_armor == None
					Weapon the_weapon = the_form as Weapon
					if the_weapon == None
						LogTrace(clone.GetDisplayName()+" CheckCloneEquipment found ITEM="+i+" name="+the_form.getName()+" "+the_form)
						clone.AddItem(the_form,1,true) ; silently add
					elseif clone.GetEquippedWeapon() == None
						LogTrace(clone.GetDisplayName()+" CheckCloneEquipment found WEAPON="+i+" name="+the_weapon.getName()+" "+the_weapon)
						clone.AddItem(the_weapon,1,true) ; silently add
					endif
				else
					int slotmask = Math.LogicalAnd(the_armor.GetSlotMask(), 0x00002FFF)
					if clone.GetWornForm(slotmask) == None
						LogTrace(clone.GetDisplayName()+" CheckCloneEquipment found ARMOR="+i+" name="+the_armor.getName()+" "+the_armor)
						clone.AddItem(the_armor,1,true) ; silently add
						EquipItemLoose(clone,the_armor)
					endif
				endif
			endif
		endif
	EndWhile
EndFunction

FormList Property DOMSavedEquipment Auto

Function SaveCurrentEquipment(Actor akTarget)
	int n = DOMSavedEquipment.GetSize()
	if n > 0
		LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" WARNING Waiting for DOMSavedEquipment to empty # items="+n)
		int k = 0
		while n > 0 && k < 20
			Wait(1.0) ; wait 1 second
			k += 1
		endwhile
		if k < 20
			LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" Waited "+k+" seconds for DOMSavedEquipment to emptied # items="+n)
		else
			LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" ERROR WARNING ERROR Waited "+k+" seconds for DOMSavedEquipment to emptied # items="+n+" NOT EMPTY!!!")
		endif
	endif
	DOMSavedEquipment.Revert()
	DOMSavedEquipment.AddForm(Gold001) ; used to block the form list
	int i
	Form the_form
	Armor the_armor
	i = 0
	n = akTarget.GetNumItems()
	LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" inventory # items="+n)
	while i < n
		the_form = akTarget.GetNthForm(i)
		if the_form != None
			the_armor = the_form as Armor
			if the_armor != None
				int imask =  Math.LogicalAnd(the_armor.GetSlotMask(), 0x00002FFF) ; other slots should be ignored
				LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" inventory armor #"+i+" "+the_armor.GetName()+" added to form list mask="+imask)
			else
				LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" inventory part #"+i+" "+the_form.GetName()+" added to form list")
			endif
			DOMSavedEquipment.AddForm(the_form)
		endif
		i += 1
	endWhile
	Outfit outf = akTarget.GetLeveledActorBase().GetOutfit()
	if outf != None
		bool check_defeat = DOMZaz.HasDefeat()
		i = 0
		n = outf.GetNumParts()
		LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" outfit="+outf.GetName()+" # items="+n)
		while i < n
			the_form = outf.GetNthPart(i)
			if the_form != None
				if check_defeat && DOMZaz.HasDefeatWornDevice(the_form)
					LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" skipping defeat worn device item="+i+" name="+the_form.getName()+" "+the_form)
				else
					the_armor = the_form as Armor
					if the_armor != None
						int imask =  Math.LogicalAnd(the_armor.GetSlotMask(), 0x00002FFF) ; other slots should be ignored
						if akTarget.GetWornForm(imask) == None
							LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" outfit armor #"+i+" "+the_armor.GetName()+" equipped="+akTarget.IsEquipped(the_armor)+" mask="+imask)
							DOMSavedEquipment.AddForm(the_form)
						else
							LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" SKIPPED outfit armor #"+i+" "+the_armor.GetName()+" equipped="+akTarget.IsEquipped(the_armor)+" mask="+imask)
						endif
					else
						LogTrace("SaveCurrentEquipment "+akTarget.GetDisplayName()+" outfit part #"+i+" "+the_form.GetName()+" equipped="+akTarget.IsEquipped(the_form))
						DOMSavedEquipment.AddForm(the_form)
					endif
				endif
			endif
			i += 1
		endWhile
	endif
	DOMSavedEquipment.RemoveAddedForm(Gold001)
EndFunction

Function RestoreCurrentEquipment(Actor akTarget)
	int n = DOMSavedEquipment.GetSize()
	if n <= 0
		return
	endif
	int i = 0
	LogTrace("RestoreCurrentEquipment "+akTarget.GetDisplayName()+" saved inventory # items="+n)
	while i < n
		Form the_form = DOMSavedEquipment.GetAt(i)
		if the_form != None
			if akTarget.GetItemCount(the_form) <= 0 ; not in inventory
				akTarget.AddItem(the_form,1,true) ; silent
				Armor the_armor = the_form as Armor
				if the_armor != None
					int imask =  Math.LogicalAnd(the_armor.GetSlotMask(), 0x00002FFF) ; other slots should be ignored
					Armor the_armor_in_slot = akTarget.GetWornForm(imask) as Armor
					if the_armor_in_slot == None
						LogTrace("RestoreCurrentEquipment "+akTarget.GetDisplayName()+" add and equip armor #"+i+" "+the_armor.GetName()+" mask="+imask)
						EquipItemLoose(akTarget,the_armor)
					else
						LogTrace("RestoreCurrentEquipment "+akTarget.GetDisplayName()+" add and SKIPPED equip armor #"+i+" "+the_armor.GetName()+" mask="+imask+" in slot="+the_armor_in_slot.GetName())
					endif
				else
					LogTrace("RestoreCurrentEquipment "+akTarget.GetDisplayName()+" add form to inventory #"+i+" "+the_form.GetName())
				endif
			else
				LogTrace("RestoreCurrentEquipment "+akTarget.GetDisplayName()+" found form already in inventory #"+i+" "+the_form.GetName())
			endif
		endif
		i += 1
	endWhile
	; Equipment was restored, clear FormList for next actor
	DOMSavedEquipment.Revert()
EndFunction

Outfit Function CheckAndTransferOutfit(Actor akTarget, bool re_equip)
	if akTarget.IsInFaction(DOMNoOutfitFaction)
		return None ; already processed, cleared or no outfit
	endif
	ActorBase abTarget = akTarget.GetLeveledActorBase()
	Outfit outf = abTarget.GetOutfit() 
	LogTrace("CheckAndTransferOutfit "+akTarget.GetDisplayName()+" outfit="+outf.GetName())
	if outf == DOMNothingOutfit
		akTarget.SetFactionRank(DOMNoOutfitFaction,2) ; Outfit is already DOMNothingOutfit
		return None
	endif
	if outf == None
		akTarget.SetFactionRank(DOMNoOutfitFaction,3) ; Outfit is already None
		return None
	endif
	; save equipment
	LogTrace("CheckAndTransferOutfit "+akTarget.GetDisplayName()+" before setting outfit")
	SaveCurrentEquipment(akTarget)
	;PrintCurrentEquipment(akTarget)
	; clear outfit
	akTarget.SetOutfit(DOMNothingOutfit)
	akTarget.SetFactionRank(DOMNoOutfitFaction,1) ; Outfit was removed
	; restore equipment
	LogTrace("CheckAndTransferOutfit "+akTarget.GetDisplayName()+" after setting outfit")
	RestoreCurrentEquipment(akTarget)
	;PrintCurrentEquipment(akTarget)
	return outf
EndFunction

Outfit Function TransferOutfitIfSettings(Actor akRef, bool reequip)
	if akRef.IsInFaction(DOMNoOutfitFaction)
		return None ; already processed, cleared or no outfit
	endif
	if OutfitIsToBeCleared(akRef)
		return CheckAndTransferOutfit(akRef,reequip)
	endif
	ActorBase abTarget = akRef.GetLeveledActorBase()
	Outfit outf = abTarget.GetOutfit() 
	LogTrace("TransferOutfitIfSettings "+akRef.GetDisplayName()+" outfit="+outf.GetName())
	if outf == DOMNothingOutfit
		akRef.SetFactionRank(DOMNoOutfitFaction,2) ; Outfit is default
	elseif outf == None
		akRef.SetFactionRank(DOMNoOutfitFaction,3) ; Outfit doesn't exist
	else
		akRef.SetFactionRank(DOMNoOutfitFaction,0) ; Outfit is set (not cleared)
	endif
	return outf
EndFunction

bool Function OutfitIsToBeCleared(Actor akRef)
	if cleanUniqueOutfit 
		if akRef.GetLeveledActorBase().IsUnique()
			return true
		elseif cleanSpawnOutfit
			return true
		endif
	elseif cleanSpawnOutfit
		if !akRef.GetLeveledActorBase().IsUnique()
			return true
		endif
	endif
	return false
EndFunction

Outfit Function TransferOutfitIfUnique(Actor akRef, bool reequip)
	ActorBase abTarget = akRef.GetLeveledActorBase()
	Outfit outf
	if !abTarget.IsUnique()
		outf = abTarget.GetOutfit() 
		LogTrace("TransferOutfitIfUnique non unique "+akRef.GetDisplayName()+" outfit="+outf.GetName())
		return outf
	endif
	outf = CheckAndTransferOutfit(akRef,reequip)
	LogTrace("TransferOutfitIfUnique unique "+akRef.GetDisplayName()+" outfit="+outf.GetName())
	return outf
EndFunction

Function RestoreOutfit(Actor akRef, int actorType, Outfit old_outfit, bool restore_outfit_on_release)
	LogTrace("RestoreOutfit "+akRef.GetDisplayName()+" "+restore_outfit_on_release+" "+restoreOutfitAlways+" old_outfit="+old_outfit)
	if !restore_outfit_on_release && !restoreOutfitAlways
		return
	endif
	if actorType != 0 ; Animal or creature
		return
	endif
	if old_outfit == None || old_outfit == DOMNothingOutfit
		ActorBase abRef = akRef.GetLeveledActorBase()
		old_outfit = abRef.GetOutfit()
	endif
	if old_outfit == None ; Do not try to give outfit to naked actors like most creatures and animals
		if actorType > 0 ; Animal or Creature
			return
		endif
	endif
	if akRef.GetLeveledActorBase().IsUnique()
		if !restoreOutfitUnique
			return
		endif
	else
		if !restoreOutfitSpawn
			return
		endif
	endif

	; Only restore if no other actor with same actor base in pools
	if DOMCore.CheckSameActorBase(akRef)
		return
	endif

	; Try to find another outfit if it was deleted
	if old_outfit == DOMNothingOutfit || old_outfit == None
		LogTrace("RestoreOutfit "+akRef.GetDisplayName()+" use another outfit")
		; Restore outfit depending on mood and training
		int love_desire = akRef.GetFactionRank(DOMLoveDesire)
		if love_desire > 0
			if love_desire < 30
				old_outfit = FineClothesOutfit01
			elseif love_desire < 60
				old_outfit = FineClothesOutfit02VariantWithHat
			else
				int i = RandomInt(1, 3)
				if i == 1
					old_outfit = JarlClothesOutfit01
				elseif i == 2
					old_outfit = JarlClothesOutfit02
				else
					old_outfit = JarlClothesOutfit03
				endif
			endif
		else
			int resignation = akRef.GetFactionRank(DOMTrainResignation)
			if resignation < 30
				old_outfit = PrisonerOutfit
			elseif resignation < 60.0
				old_outfit = FarmClothesRandom
			elseif resignation < 90.0
				old_outfit = BanditArmorMeleeNoShieldOutfit
			else
				old_outfit = HunterClothesRND
			endif
		endif
	endif
	if old_outfit == None
		if akRef.IsInFaction(DOMPlayerSlaveFaction) || akRef.IsInFaction(DOMNotPlayerSlaveFaction)
			return
		endif
		old_outfit = HunterClothesRND
	endif
	LogTrace("Restore outfit="+old_outfit)
	akRef.SetOutfit(old_outfit)
	akRef.RemoveFromFaction(DOMNoOutfitFaction)
EndFunction

; Utilities

Function LogInfo(string msg)
	Debug.Trace("DOM_Equip: "+msg)
EndFunction

Function LogTrace(string msg)
	if verboseEquip
		Debug.Trace("DOM_Equip: "+msg)
	endif
EndFunction
