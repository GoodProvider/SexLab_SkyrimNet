ScriptName DOM_EquipUtil hidden
{Global Utility Functions for DOM}
Import Utility

; ### Utility

Function LogEquipUtil(string msg) Global
	Debug.Trace("DOM_EquipUtil: "+msg)
EndFunction

bool Function IsPotion(Form the_form) global
	if the_form == None
		return false
	endif
	int type = the_form.GetType()
	if type == 46 ; kPotion
		return true
	endif
	return false
EndFunction

bool Function IsPotionOrIngredient(Form the_form) global
	if the_form == None
		return false
	endif
	int type = the_form.GetType()
	if type == 46 ; kPotion
		return true
	endif
	if type == 30 ; kIngredient
		return true
	endif
	return false
EndFunction

float Function GetAlcoholLevel(Form the_form) Global
	if !IsPotionOrIngredient(the_form)
		return 0.0
	endif
	String fname = the_form.GetName()
	; Ale
	if stringUtil.find(fname,"Ale")>=0
		return 1.0
	elseif stringUtil.find(fname,"Mead")>=0
		return 1.2
	elseif stringUtil.find(fname,"Matze")>=0
		return 1.4
	elseif stringUtil.find(fname,"Black-Briar Reserve")>=0
		return 1.5
	; Wine
	elseif stringUtil.find(fname,"Argonian Bloodwine")>=0
		return 2.5
	elseif stringUtil.find(fname,"Bloodwine")>=0
		return 2.4
	elseif stringUtil.find(fname,"Spiced Wine")>=0
		return 2.2
	elseif stringUtil.find(fname,"Wine")>=0
		return 2.0
	elseif stringUtil.find(fname,"Shein")>=0
		return 2.1
	; Strong alcohols
	elseif stringUtil.find(fname,"Brandy")>=0
		return 3.5
	elseif stringUtil.find(fname,"Flin")>=0
		return 4.0
	elseif stringUtil.find(fname,"Sujamma")>=0
		return 4.2
	elseif stringUtil.find(fname,"Rum")>=0
		return 4.5
	; Specials
	elseif stringUtil.find(fname,"Velvet LeChance")>=0
		return 6.0
	elseif stringUtil.find(fname,"White-Gold Tower")>=0
		return 6.0
	elseif stringUtil.find(fname,"Cliff Racer")>=0
		return 6.0
	endif
	return 0.0
EndFunction

Function EquipItemTight(Actor akRef, Form the_form) global
	if akRef.IsEquipped(the_form)
		return
	endif
	LogEquipUtil("EquipItemTight actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.EquipItem(the_form, true, true) ; can not unequip, silent
EndFunction

Function UnEquipItemTight(Actor akRef, Form the_form) global
	if !akRef.IsEquipped(the_form)
		return
	endif
	LogEquipUtil("UnEquipItemTight actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.UnEquipItem(the_form, true, true) 
EndFunction

Function EquipItemLoose(Actor akRef, Form the_form) global
	if akRef.IsEquipped(the_form)
		return
	endif
	LogEquipUtil("EquipItemLoose actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.EquipItem(the_form, false, true) ; can unequip, silent
EndFunction

Function UnEquipItemLoose(Actor akRef, Form the_form) global
	if !akRef.IsEquipped(the_form)
		return
	endif
	LogEquipUtil("UnEquipItemLoose actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.UnEquipItem(the_form, false, true)
EndFunction

Function UnequipHandheld(Actor akTarget) global
	Armor the_shield = akTarget.GetWornForm(0x00000200) as Armor ; kSlotMask39 = 0x00000200 AutoReadOnly ; SHIELD
	if the_shield != None
		LogEquipUtil("UnequipHandheld: found shield="+the_shield)
		UnEquipItemLoose(akTarget,the_shield)
	endif
	Weapon the_weaponR = akTarget.GetEquippedWeapon(false) ; right hand
	if the_weaponR != None
		LogEquipUtil("UnequipHandheld: found weapon in right hand="+the_weaponR)
		UnEquipItemLoose(akTarget,the_weaponR)
	endif
	Weapon the_weaponL = akTarget.GetEquippedWeapon(true) ; left hand
	if the_weaponL != None
		LogEquipUtil("UnequipHandheld: found weapon in left hand="+the_weaponL)
		UnEquipItemLoose(akTarget,the_weaponL)
	endif
	Ammo the_ammo = akTarget.GetEquippedObject(0) as Ammo
	if the_ammo != None
		LogEquipUtil("UnequipHandheld: found ammo="+the_ammo)
		UnEquipItemLoose(akTarget,the_ammo)
	endif
EndFunction

int Function UnEquipWeapon(Actor akRef) global
	Weapon orig_weapon = GetEquippedWeapon(akRef)
	Ammo orig_ammo = akRef.GetEquippedObject(0) as Ammo ; left hand
	int type_equip = 0
	if orig_weapon != None
		UnEquipItemLoose(akRef,orig_weapon) 
		type_equip += 8 ; weapon
	endif
	if orig_ammo != None
		UnEquipItemLoose(akRef,orig_ammo) 
		type_equip += 16 ; ammo
	endif
	return type_equip
EndFunction

int Function UnEquipShield(Actor akRef) global
	Armor orig_shield = akRef.GetEquippedShield()
	if orig_shield != None
		UnEquipItemLoose(akRef,orig_shield) 
		return 4
	endif
	return 0
EndFunction

int Function EquipShield(Actor akRef) global
	;LogEquipUtil("EquipShield start "+akRef.GetDisplayName())
	Armor orig_shield = akRef.GetEquippedShield()
	Armor the_shield = orig_shield
	float x_shield = 0.0
	float x = 0.0
	bool has_shield = false
	if the_shield != None
		;LogEquipUtil("EquipShield shield="+the_shield.GetName())
		x_shield = ArmorValue(akRef,the_shield)
		has_shield = true
	endif
	bool changed_shield = false
	Int i = akRef.GetNumItems()
	while i > 0
		i -= 1
		Form the_form = akRef.GetNthForm(i)
		if the_form != None && isClothesOrArmor(the_form)
			Armor the_armor = the_form as Armor
			if the_armor != the_shield && the_armor.IsShield()
				;LogEquipUtil("EquipShield found shield "+akRef.GetDisplayName()+" "+the_armor.GetName())
				x = ShieldValue(the_armor)
				if x > x_shield
					the_shield = the_armor
					x_shield = x
					changed_shield = true
					;LogEquipUtil("EquipShield found better shield "+akRef.GetDisplayName()+" "+the_shield.GetName())
				endif
			endif
		endif
	endwhile
	if changed_shield
		;if orig_shield != None && akRef.IsEquipped(orig_shield)
		;	UnEquipItemLoose(akRef,orig_shield)
		;endif
		EquipItemLoose(akRef,the_shield)
		has_shield = true
	endif
	
	int type_equip = 0
	if has_shield
		type_equip += 4 ; shield
	endif
	;LogEquipUtil("EquipShield close "+akRef.GetDisplayName()+" changed="+changed_shield+" has="+has_shield)
	return type_equip
EndFunction

bool Function IsItemSpecialNeverStrip(Form the_form) Global
	; Only consider armors
	int type = the_form.GetType()
	if type != 26 ; kArmor 
		return false
	endif
	
	Armor the_armor = the_form as Armor

	; Never strip special armor slots
	int slotmask = the_armor.GetSlotMask()
	if Math.LogicalAnd(slotmask,0xC0400802) != 0x0
		return true
	endif
	return false
EndFunction

bool Function isWeaponOrShield(Form the_form) Global
	int type = the_form.GetType()
	
	if type == 41 ; kWeapon 
		;LogEquipUtil(" isWeaponOrShield "+the_form.GetName()+" YES type="+type)
		return true
	endif
	if type == 42 ; kAmmo 
		;LogEquipUtil(" isWeaponOrShield "+the_form.GetName()+" YES type="+type)
		return true
	endif
	Armor the_armor = the_form as Armor
	if the_armor != None && the_armor.IsShield()
		;LogEquipUtil(" isWeaponOrShield "+the_form.GetName()+" YES type="+type)
		return true
	endif
	;LogEquipUtil(" isWeaponOrShield "+the_form.GetName()+" NO type="+type)
	return false
EndFunction

bool Function isClothesOrArmor(Form the_form) Global
	if the_form.GetType() == 26 ; kArmor 
		;LogEquipUtil(" isWearable "+the_form.GetName()+" YES type="+type)
		return true
	endif
	return false
EndFunction

bool Function isWeaponOrAmmo(Form the_form) Global
	int type = the_form.GetType()

	if type == 41 ; kWeapon 
		;LogEquipUtil(" isWearable "+the_form.GetName()+" YES type="+type)
		return true
	endif
	if type == 42 ; kAmmo 
		;LogEquipUtil(" isWearable "+the_form.GetName()+" YES type="+type)
		return true
	endif
	return false
EndFunction

bool Function isWeapon(Form the_form) Global
	int type = the_form.GetType()

	if type == 41 ; kWeapon 
		;LogEquipUtil(" isWearable "+the_form.GetName()+" YES type="+type)
		return true
	endif
	return false
EndFunction

bool Function isWearable(Form the_form) Global
	int type = the_form.GetType()
	
	if type == 26 ; kArmor 
		;LogEquipUtil(" isWearable "+the_form.GetName()+" YES type="+type)
		return true
	endif
	if type == 31 ; kLight 
		;LogEquipUtil(" isWearable "+the_form.GetName()+" YES type="+type)
		return true
	endif
	; 32 kMisc
	if type == 41 ; kWeapon 
		;LogEquipUtil(" isWearable "+the_form.GetName()+" YES type="+type)
		return true
	endif
	if type == 42 ; kAmmo 
		;LogEquipUtil(" isWearable "+the_form.GetName()+" YES type="+type)
		return true
	endif
	;LogEquipUtil(" isWearable "+the_form.GetName()+" NO type="+type)
	return false
EndFunction

; Actor and object values

float Function GetMagicActorValue(Actor akRef) Global
	if akRef == None
		return 0.0
	endif
	float x = akRef.GetActorValue("Alteration")
	float y = akRef.GetActorValue("Conjuration")
	if y > x
		x = y
	endif
	y = akRef.GetActorValue("Destruction")
	if y > x
		x = y
	endif
	y = akRef.GetActorValue("Illusion")
	if y > x
		x = y
	endif
	y = akRef.GetActorValue("Restoration")
	if y > x
		return y
	endif
	return x
EndFunction

float Function WeaponValue(Actor akRef, Weapon weap) Global
	if weap == None
		return 0.0
	endif
	float skill = 1.0
	int itype = 10
	if akRef != None ; Adapt value to actor's equipment and skills
		itype =  weap.GetWeaponType() 
		if itype == 7 ; Bows
			Ammo am = akRef.GetEquippedObject(0) as Ammo
			if am == None
				return 0.5
			endif
			if am.IsBolt() 
				return 0.5
			endif
			skill = akRef.GetActorValue("Marksman")/100.0
		elseif itype == 9 ; Crossbows
			Ammo am = akRef.GetEquippedObject(0) as Ammo
			if am == None
				return 0.5
			endif
			if !am.IsBolt() 
				return 0.5
			endif
			skill = akRef.GetActorValue("Marksman")/100.0
		elseif itype <= 4 ; OneHanded
			skill = akRef.GetActorValue("OneHanded")/100.0
		elseif itype <= 6 ; TwoHanded
			skill = akRef.GetActorValue("TwoHanded")/100.0
		endif
		if skill < 0.01
			skill = 0.01
		endif
	endif
	float x = ((weap.GetBaseDamage()-(2.0))*weap.GetSpeed()*5.0+weap.GetGoldValue()/50.0)/2.0*skill
	;LogEquipUtil(" WeaponValue "+weap.GetName()+" type="+itype+" skill="+skill+" x="+x)
	if x <= 1.0
		return 1.0
	endif
	return x
EndFunction

float Function AmmoValue(Actor akRef, Ammo am) Global
	if am == None
		return 0.0
	endif
	if akRef != None ; Adapt value to actor's equipment and skills
		Weapon weap = akRef.GetEquippedWeapon()
		if weap != None
			int itype =  weap.GetWeaponType() 
			if itype == 7
				if am.IsBolt()
					return 0.5
				endif
			elseif itype == 9
				if !am.IsBolt()
					return 0.5
				endif
			endif
		endif
	endif
	float x = am.GetDamage()+am.GetGoldValue()/50.0
	if x <= 1.0
		return 1.0
	endif
	return x
EndFunction

float Function ArmorValue(Actor akRef, Armor the_armor) Global
	if the_armor == None
		return 0.0
	endif
	float skill = 1.0
	int itype = 10
	if akRef != None ; Adapt value to actor's equipment and skills
		if the_armor.IsShield()
			itype = 3
			skill = akRef.GetActorValue("Block")/100.0
		else
			itype =  the_armor.GetWeightClass() 
			if itype == 0 ; LightArmor
				skill = akRef.GetActorValue("LightArmor")/100.0
			elseif itype == 1 ; HeavyArmor
				skill = akRef.GetActorValue("HeavyArmor")/100.0
			else ; Clothes
				skill = GetMagicActorValue(akRef)
			endif
		endif
		if skill < 0.01
			skill = 0.01
		endif
	endif
	float y = the_armor.GetArmorRating()
	float x = (y+the_armor.GetGoldValue()/50.0)*skill
	;LogEquipUtil(" ArmorValue "+the_armor.GetName()+" type="+itype+" skill="+skill+" x="+x)
	if y <= 0.0 && x >= 1.0 ; No real armor protection
		return 1.0
	endif
	return x
EndFunction

float Function ClothesValue(Armor the_armor) Global
	if the_armor == None
		return 0.0
	endif
	float y = the_armor.GetArmorRating()
	if y > 1.0
		return 0.0
	endif
	float x = the_armor.GetGoldValue()/50.0
	return x
EndFunction

float Function ShieldValue(Armor the_armor) Global
	if the_armor == None
		return 0.0
	endif
	float y = the_armor.GetArmorRating()
	float x = (y+the_armor.GetGoldValue()/50.0)/10.0
	return x
EndFunction


; Get equipment

Weapon Function GetEquippedWeapon(Actor akRef) global
	Weapon weap = akRef.GetEquippedWeapon(false) ; right hand
	if weap != None
		return weap
	endif
	return akRef.GetEquippedWeapon(true) ; left hand
EndFunction

Form Function GetEquippedNecklace(Actor akTarget) global
	Int iArmsSlotMask =	0x00000020 ; kSlotMask35 ; Amulet
	Form the_form = akTarget.GetWornForm(iArmsSlotMask)
	if the_form != None
		return the_form
	endif
	return None
EndFunction

Form Function GetEquippedWrist(Actor akTarget) global
	Int iArmsSlotMask =	0x00000008 ; kSlotMask33 ; Hands
	Form the_form = akTarget.GetWornForm(iArmsSlotMask)
	if the_form != None
		return the_form
	endif
	return None
EndFunction

; has Equipment

float Function HasEquippedWeapon(Actor akRef) global
	Weapon weap
	
	; Right hand
	weap = akRef.GetEquippedWeapon(false)
	if weap
		float x = WeaponValue(akRef,weap)
		;LogEquipUtil("HasEquippedWeapon: "+akRef.GetDisplayName()+" has weapon "+weap.getName()+" damage="+weap.GetBaseDamage()+" speed="+weap.GetSpeed()+" value="+weap.GetGoldValue()+" x="+x)
		return x
	endif
	; Left hand
	weap = akRef.GetEquippedWeapon(true)
	if weap
		float x = WeaponValue(akRef,weap)
		;LogEquipUtil("HasEquippedWeapon: "+akRef.GetDisplayName()+" has weapon in left hand "+weap.getName()+" damage="+weap.GetBaseDamage()+" speed="+weap.GetSpeed()+" value="+weap.GetGoldValue()+" x="+x)
		return x
	endif
	;LogEquipUtil("HasEquippedWeapon: "+akRef.GetDisplayName()+" has no weapon in hand")
    return 0.0
EndFunction

float Function HasEquippedHeadArmor(Actor akRef) global
	Armor ws = akRef.GetWornForm(0x00000001) as Armor
	if ws != None
		float x = ArmorValue(akRef,ws)
		;LogEquipUtil("HasEquippedHeadArmor: "+akRef.GetDisplayName()+" has armor "+ws.getName()+" rating="+ws.GetArmorRating()+" value="+ws.GetGoldValue()+" x="+x)
		return x
	endif
	return 0.0
EndFunction

float Function HasEquippedBodyArmor(Actor akRef) global
	Armor ws = akRef.GetWornForm(0x00000004) as Armor
	if ws != None
		float x = ArmorValue(akRef,ws)
		;LogEquipUtil("HasEquippedBodyArmor: "+akRef.GetDisplayName()+" has armor "+ws.getName()+" rating="+ws.GetArmorRating()+" value="+ws.GetGoldValue()+" x="+x)
		return x
	endif
	return 0.0
EndFunction

float Function HasEquippedHandsArmor(Actor akRef) global
	Armor ws = akRef.GetWornForm(0x00000008) as Armor
	if ws != None
		float x = ArmorValue(akRef,ws)
		;LogEquipUtil("HasEquippedHandsArmor: "+akRef.GetDisplayName()+" has armor "+ws.getName()+" rating="+ws.GetArmorRating()+" value="+ws.GetGoldValue()+" x="+x)
		return x
	endif
	return 0.0
EndFunction

float Function HasEquippedFeetArmor(Actor akRef) global
	Armor ws = akRef.GetWornForm(0x00000080) as Armor
	if ws != None
		float x = ArmorValue(akRef,ws)
		;LogEquipUtil("HasEquippedFeetArmor: "+akRef.GetDisplayName()+" has armor "+ws.getName()+" rating="+ws.GetArmorRating()+" value="+ws.GetGoldValue()+" x="+x)
		return x
	endif
	return 0.0
EndFunction

float Function HasEquippedShield(Actor akRef) global
	Armor ws = akRef.GetEquippedShield()
	if ws != None
		float x =  ShieldValue(ws)
		;LogEquipUtil("HasEquippedShield: "+akRef.GetDisplayName()+" has shield "+ws.getName()+" rating="+ws.GetArmorRating()+" value="+ws.GetGoldValue()+" x="+x)
		return x
	endif
	return 0.0
EndFunction

; Adding

Function AddItemNoChange(Actor akRef, Form the_form) global
	if akRef.GetItemCount(the_form) > 0
		return
	endif
	LogEquipUtil("AddItemNoChange actor="+akRef.GetDisplayName()+" item="+the_form.GetName())
	akRef.AddItem(the_form, 1, true) ; silent
EndFunction

; Print

Function PrintCurrentEquipment(Actor akTarget) global
	int i
	int n
	Form the_form
	Armor the_armor
	Outfit outf = akTarget.GetLeveledActorBase().GetOutfit()
	if outf != None
		i = 0
		n = outf.GetNumParts()
		LogEquipUtil("PrintCurrentEquipment "+akTarget.GetDisplayName()+" outfit="+outf.GetName()+" # items="+n)
		while i < n
			the_form = outf.GetNthPart(i)
			if the_form != None
				the_armor = the_form as Armor
				if the_armor != None
					int imask =  Math.LogicalAnd(the_armor.GetSlotMask(), 0x00002FFF) ; other slots should be ignored
					LogEquipUtil("PrintCurrentEquipment "+akTarget.GetDisplayName()+" outfit armor #"+i+" "+the_armor.GetName()+" equipped="+akTarget.IsEquipped(the_armor)+" mask="+imask)
				else
					LogEquipUtil("PrintCurrentEquipment "+akTarget.GetDisplayName()+" outfit part #"+i+" "+the_form.GetName()+" equipped="+akTarget.IsEquipped(the_form))
				endif
			endif
			i += 1
		endWhile
	endif
	i = 0
	n = akTarget.GetNumItems()
	LogEquipUtil("PrintCurrentEquipment "+akTarget.GetDisplayName()+" inventory # items="+n)
	while i < n
		the_form = akTarget.GetNthForm(i)
		if the_form != None
			the_armor = the_form as Armor
			if the_armor != None
				int imask =  Math.LogicalAnd(the_armor.GetSlotMask(), 0x00002FFF) ; other slots should be ignored
				LogEquipUtil("PrintCurrentEquipment "+akTarget.GetDisplayName()+" inventory armor #"+i+" "+the_armor.GetName()+" equipped="+akTarget.IsEquipped(the_armor)+" mask="+imask)
			endif
			LogEquipUtil("PrintCurrentEquipment "+akTarget.GetDisplayName()+" inventory part #"+i+" "+the_form.GetName()+" equipped="+akTarget.IsEquipped(the_form))
		endif
		i += 1
	endWhile
EndFunction
