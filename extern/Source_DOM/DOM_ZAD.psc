Scriptname DOM_ZAD extends Quest  

bool Property hasZad = false Auto Hidden
ZadLibs Property ZadIntegration Auto Hidden

Form Property zad_plugPrimitiveAnal Auto Hidden
Form Property zad_plugPrimitiveVaginal Auto Hidden

Keyword Property zad_Property_Humiliating Auto Hidden
Keyword Property zad_Lockable Auto Hidden
Keyword Property zad_InventoryDevice Auto Hidden
Keyword Property zad_DeviousBelt Auto Hidden
Keyword Property zad_DeviousCollar Auto Hidden
Keyword Property zad_DeviousGag Auto Hidden
Keyword Property zad_DeviousSuit Auto Hidden
Keyword Property zad_DeviousPetSuit Auto Hidden
Keyword Property zad_DeviousPonySuit Auto Hidden
Keyword Property zad_DeviousStraitJacket Auto Hidden
Keyword Property zad_DeviousPlugVaginal Auto Hidden
Keyword Property zad_DeviousPlugAnal Auto Hidden
Keyword Property zad_DeviousArmbinder Auto Hidden
Keyword Property zad_DeviousArmbinderElbow Auto Hidden
Keyword Property zad_DeviousArmCuffs Auto Hidden
Keyword Property zad_DeviousCuffsFront Auto Hidden
Keyword Property zad_DeviousYoke Auto Hidden
Keyword Property zad_DeviousBlindfold Auto Hidden
Keyword Property zad_DeviousLegCuffs Auto Hidden
Keyword Property zad_DeviousAnkleShackles Auto Hidden
Keyword Property zad_DeviousHobbleSkirt Auto Hidden
Keyword Property zad_EffectForcedWalk Auto Hidden
Keyword Property zad_BoundCombatDisableKick Auto Hidden
Keyword Property dse_PlugAnal Auto Hidden

; DOM keywords
Keyword Property DOMWornPlugAnal Auto
Keyword Property DOMWornPlugVaginal Auto
Keyword Property DOMNotDevice Auto

Function Initialize()
	LogInfo("=================================================================================")
	LogInfo("==                       DOM: Devious Devices interface                        ==")
	LogInfo("=================================================================================")

	If Game.GetModByName("Devious Devices - Assets.esm") != 255
		ZadIntegration = Game.GetFormFromFile(0x0000f624, "Devious Devices - Integration.esm")  as ZadLibs
		zad_plugPrimitiveVaginal       = Game.GetFormFromFile(0x00018713, "Devious Devices - Assets.esm") As Form
		zad_plugPrimitiveAnal          = Game.GetFormFromFile(0x00018714, "Devious Devices - Assets.esm") As Form
		hasZad = true
	else
		ZadIntegration                 = None
		zad_plugPrimitiveVaginal       = None
		zad_plugPrimitiveAnal          = None
		hasZad = false
	endif

	zad_InventoryDevice        = Keyword.GetKeyword("zad_InventoryDevice")
	zad_Lockable               = Keyword.GetKeyword("zad_Lockable")
	zad_DeviousBelt            = Keyword.GetKeyword("zad_DeviousBelt")
	zad_DeviousCollar          = Keyword.GetKeyword("zad_DeviousCollar")
	zad_DeviousSuit            = Keyword.GetKeyword("zad_DeviousSuit")
	zad_DeviousPetSuit         = Keyword.GetKeyword("zad_DeviousPetSuit")
	zad_DeviousPonySuit        = Keyword.GetKeyword("zad_DeviousPonySuit")
	zad_DeviousStraitJacket    = Keyword.GetKeyword("zad_DeviousStraitJacket")
	zad_DeviousArmbinder       = Keyword.GetKeyword("zad_DeviousArmbinder")
	zad_DeviousArmbinderElbow  = Keyword.GetKeyword("zad_DeviousArmbinderElbow")
	zad_DeviousArmCuffs        = Keyword.GetKeyword("zad_DeviousArmCuffs")
	zad_DeviousCuffsFront      = Keyword.GetKeyword("zad_DeviousCuffsFront")
	zad_DeviousYoke            = Keyword.GetKeyword("zad_DeviousYoke")
	zad_BoundCombatDisableKick = Keyword.GetKeyword("zad_BoundCombatDisableKick")
	zad_DeviousPlugVaginal     = Keyword.GetKeyword("zad_DeviousPlugVaginal")
	zad_DeviousPlugAnal        = Keyword.GetKeyword("zad_DeviousPlugAnal")
	zad_DeviousBlindfold       = Keyword.GetKeyword("zad_DeviousBlindfold")
	zad_DeviousAnkleShackles   = Keyword.GetKeyword("zad_DeviousAnkleShackles")
	zad_DeviousLegCuffs        = Keyword.GetKeyword("zad_DeviousLegCuffs")
	zad_DeviousHobbleSkirt     = Keyword.GetKeyword("zad_DeviousHobbleSkirt")
	zad_EffectForcedWalk       = Keyword.GetKeyword("zad_EffectForcedWalk")
	zad_Property_Humiliating   = Keyword.GetKeyword("zad_Property_Humiliating")
	zad_DeviousGag             = Keyword.GetKeyword("zad_DeviousGag")
	zad_Property_Humiliating   = Keyword.GetKeyword("zad_Property_Humiliating")
	zad_DeviousGag             = Keyword.GetKeyword("zad_DeviousGag")

	If (Game.GetModByName("dse-buttplug.esp") != 255)
		dse_PlugAnal = (Game.GetFormFromFile(0x00082F, "dse-buttplug.esp") As Keyword)
	else
		dse_PlugAnal = None
	endif
 	if !hasZad
		LogInfo(" WARNING: Devious Devices NOT FOUND!")
	else
		RemoveKeywordOnForm(zad_plugPrimitiveVaginal,DOMNotDevice)
		RemoveKeywordOnForm(zad_plugPrimitiveAnal,DOMNotDevice)
		AddkeywordToForm(zad_plugPrimitiveVaginal,DOMWornPlugVaginal)
		AddkeywordToForm(zad_plugPrimitiveAnal,DOMWornPlugAnal)
		LogInfo(" Devious Devices found!")
	endif
EndFunction

Function AddkeywordToForm(Form the_form, Keyword the_keyword)
	if the_form == None || the_keyword == None
		LogInfo("WARNING: Devious Devices trying to add keyword "+the_keyword+" to form "+the_form)
		return
	endif
	if the_form.HasKeyword(the_keyword)
		return
	endif
	PO3_SKSEFunctions.AddKeywordToForm(the_form,the_keyword)
EndFunction

Function RemoveKeywordOnForm(Form the_form, Keyword the_keyword)
	if the_form == None || the_keyword == None
		LogInfo("WARNING: Devious Devices trying to remove keyword "+the_keyword+" to form "+the_form)
		return
	endif
	if !the_form.HasKeyword(the_keyword)
		return
	endif
	PO3_SKSEFunctions.RemoveKeywordOnForm(the_form,the_keyword)
EndFunction

Form Function GetPlugAnal()
	return zad_plugPrimitiveAnal
EndFunction

Form Function GetPlugVaginal()
	return zad_plugPrimitiveVaginal
EndFunction

bool Function wornGag(Actor akRef)
	if zad_DeviousGag == None
		return false
	endif
	return akRef.WornHasKeyword(zad_DeviousGag)
EndFunction

bool Function wornHumiliating(Actor akRef)
	if zad_Property_Humiliating == None
		return false
	endif
	return akRef.WornHasKeyword(zad_Property_Humiliating)
EndFunction

bool Function wornBlindfold(Actor akRef)
	if zad_DeviousBlindfold == None
		return false
	endif
	return akRef.WornHasKeyword(zad_DeviousBlindfold)
EndFunction

bool Function wornWrist(Actor akRef)
	if zad_DeviousCuffsFront != None && akRef.WornHasKeyword(zad_DeviousCuffsFront)
		return true
	endif
	if zad_DeviousArmCuffs != None && akRef.WornHasKeyword(zad_DeviousArmCuffs)
		return true
	endif
	return false
EndFunction

bool Function wornLeash(Actor akRef)
	if zad_DeviousPetSuit != None && akRef.WornHasKeyword(zad_DeviousPetSuit)
		return true
	endif
	if zad_DeviousHobbleSkirt != None && akRef.WornHasKeyword(zad_DeviousHobbleSkirt)
		return true
	endif
	if zad_EffectForcedWalk != None && akRef.WornHasKeyword(zad_EffectForcedWalk)
		return true
	endif
	if zad_DeviousAnkleShackles != None && akRef.WornHasKeyword(zad_DeviousAnkleShackles)
		return true
	endif
	if zad_DeviousLegCuffs != None && akRef.WornHasKeyword(zad_DeviousLegCuffs)
		return true
	endif
	if zad_DeviousCollar != None && akRef.WornHasKeyword(zad_DeviousCollar)
		return true
	endif
	if zad_DeviousBlindfold != None && akRef.WornHasKeyword(zad_DeviousBlindfold)
		return true
	endif
	return false
EndFunction

bool Function isYoked(Form the_form)
	if zad_Lockable == None
		return false
	endif
	if !the_form.HasKeyword(zad_Lockable)
		return false
	endif
	if the_form.HasKeyword(zad_DeviousYoke)
		return true
	endif
	if the_form.HasKeyword(zad_DeviousArmbinder)
		return true
	endif
	if the_form.HasKeyword(zad_DeviousPonySuit)
		return true
	endif
	if the_form.HasKeyword(zad_DeviousPetSuit)
		return true
	endif
	if the_form.HasKeyword(zad_DeviousArmbinderElbow)
		return true
	endif
	if the_form.HasKeyword(zad_DeviousStraitJacket)
		return true
	endif
	return false
EndFunction

bool Function wornPlugAnal(Actor akRef)
	if zad_DeviousPlugAnal != None && akRef.WornHasKeyword(zad_DeviousPlugAnal)
		return true
	endif
	if dse_PlugAnal != None && akRef.WornHasKeyword(dse_PlugAnal)
		return true
	endif
	return false
EndFunction

bool Function wornPlugVaginal(Actor akRef)
	if zad_DeviousPlugVaginal == None
		return false
	endif
	;LogInfo("wornplugVaginal "+akRef.getDisplayName()+" "+akRef.WornHasKeyword(zad_DeviousPlugVaginal))
	return akRef.WornHasKeyword(zad_DeviousPlugVaginal)
EndFunction

bool Function wornDisableKick(Actor akRef)
	if zad_BoundCombatDisableKick == None
		return false
	endif
	return akRef.WornHasKeyword(zad_BoundCombatDisableKick)
EndFunction

bool Function wornArmbinder(Actor akRef)
	if zad_DeviousArmbinderElbow != None && akRef.WornHasKeyword(zad_DeviousArmbinderElbow)
		return true
	endif
	if zad_DeviousArmbinder != None && akRef.WornHasKeyword(zad_DeviousArmbinder)
		return true
	endif
	return false
EndFunction

bool Function wornBelt(Actor akRef)
	if zad_DeviousBelt != None && akRef.WornHasKeyword(zad_DeviousBelt)
		return true
	endif
	return false
EndFunction

bool Function wornYoke(Actor akRef)
	if zad_DeviousYoke != None && akRef.WornHasKeyword(zad_DeviousYoke)
		return true
	endif
	return false
EndFunction

bool Function wornStraitJacket(Actor akRef)
	if zad_DeviousStraitJacket == None
		return false
	endif
	return akRef.WornHasKeyword(zad_DeviousStraitJacket)
EndFunction

bool Function wornPetSuit(Actor akRef)
	if zad_DeviousPetSuit == None
		return false
	endif
	return akRef.WornHasKeyword(zad_DeviousPetSuit)
EndFunction

bool Function wornDeviousSuit(Actor akRef)
	if zad_DeviousSuit == None
		return false
	endif
	return akRef.WornHasKeyword(zad_DeviousSuit)
EndFunction

bool Function wornCollar(Actor akRef)
	if zad_DeviousCollar == None
		return false
	endif
	return akRef.WornHasKeyword(zad_DeviousCollar)
EndFunction

Form Function GetRenderedDevice(Form the_form)
	if ZadIntegration == None
		return None
	endif
	return ZadIntegration.GetRenderedDevice(the_form as Armor)
EndFunction

Function ManipulateGenericDevice(Actor slave, Armor item, bool equip)
	if ZadIntegration == None
		return None
	endif
	ZadIntegration.ManipulateGenericDevice(slave, item, equip, !equip, false)
EndFunction

bool Function wornDevice(Actor akRef)
	if zad_Lockable != None && akRef.WornHasKeyword(zad_Lockable)
		return true
	endif
	if zad_InventoryDevice != None && akRef.WornHasKeyword(zad_InventoryDevice)
		return true
	endif
	return false
EndFunction

bool Function hasKeywordGag(Form the_form)
	if zad_DeviousGag == None
		return false
	endif
	return the_form.hasKeyword(zad_DeviousGag)
EndFunction

bool Function hasKeywordWrist(Form the_form)
	if zad_DeviousCuffsFront != None && the_form.hasKeyword(zad_DeviousCuffsFront)
		return true
	endif
	if zad_DeviousArmCuffs != None && the_form.hasKeyword(zad_DeviousArmCuffs)
		return true
	endif
	return false
EndFunction

bool Function hasKeywordPlugAnal(Form the_form)
	if zad_DeviousPlugAnal != None && the_form.hasKeyword(zad_DeviousPlugAnal)
		return true
	endif
	if dse_PlugAnal != None && the_form.hasKeyword(dse_PlugAnal)
		return true
	endif
	return false
EndFunction

bool Function hasKeywordPlugVaginal(Form the_form)
	if zad_DeviousPlugVaginal == None
		return false
	endif
	return the_form.hasKeyword(zad_DeviousPlugVaginal)
EndFunction

bool Function hasKeywordArmbinder(Form the_form)
	if zad_DeviousArmbinderElbow != None && the_form.HasKeyword(zad_DeviousArmbinderElbow)
		return true
	endif
	if zad_DeviousArmbinder != None && the_form.HasKeyword(zad_DeviousArmbinder)
		return true
	endif
	return false
EndFunction

bool Function hasKeywordYoke(Form the_form)
	if zad_DeviousYoke != None && the_form.HasKeyword(zad_DeviousYoke)
		return true
	endif
	return false
EndFunction

bool Function hasKeywordDevice(Form the_form)
	if zad_Lockable != None && the_form.HasKeyword(zad_Lockable)
		return true
	endif
	if zad_InventoryDevice != None && the_form.HasKeyword(zad_InventoryDevice)
		return true
	endif
	;if zad_DeviousCollar != None && the_form.HasKeyword(zad_DeviousCollar)
	;	return true
	;endif
	;if !hasZad
	;	return false
	;endif
	;string the_name = the_form.GetName()
	;LogInfo("hasKeywordDevice "+the_name+" form="+the_form)
	;if(stringUtil.find(the_name,"zad")>=0)
	;	LogInfo("hasKeywordDevice "+the_name+" true")
	;	return true
	;endif
	return false
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_ZAD: "+msg)
EndFunction