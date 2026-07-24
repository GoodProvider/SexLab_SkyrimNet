Scriptname DOM_Actor extends ReferenceAlias 

DOM_Mind Property mind Auto
String Property behaviour Auto

int blush_map0 = 0
int drool_map0 = 0

Function Anim_SexlabWithNPC(Actor akOther, string tag, bool punishment, string reason_name = "")
EndFunction

Function SetSendExternalEvents(bool status)
EndFunction

bool Property sendExternalEventToggleExt = false Auto Hidden
Function SetSendExternalEventsExt(bool status)
EndFunction

bool Property sendExternalEventToggleExt2 = false Auto Hidden
Function SetSendExternalEventsExt2(bool status)
EndFunction

bool Property sendExternalEventToggleExt3 = false Auto Hidden
Function SetSendExternalEventsExt3(bool status)
EndFunction

Function StripMore()
EndFunction

Function UnsetShouldBeNaked(Actor akAbuser)
EndFunction

Function Anim_DressUp(bool do_bottom)
EndFunction

Function StartPraising(Actor akAbuser, string reason="", string type="")
EndFunction

Function StartInsultingWith(Actor akAbuser, string type)
EndFunction

bool Function hasTears()
EndFunction

Function StartSexWithNPC(Actor akAbuser, string type, bool aggro)
EndFunction

; Undress 
Function Interact_Undress(Actor akAbuser)
EndFunction 

Function Interact_UndressNoChoice(Actor akAbuser, bool do_anim)
EndFunction

Function Interact_UndressNoAnim(Actor akAbuser)
EndFunction

;#############################################################
bool Property wait_for_equipment = false Auto Hidden
int cuffs_material = 0

bool __is_in_dungeon = false
bool Property is_in_dungeon Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __is_in_city = false
bool Property is_in_city Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __is_naked = false
bool Property is_naked Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __is_shamed = false
bool Property is_shamed Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty


bool Property has_shield_in_inventory = false Auto Hidden
bool Property has_body_armor_in_inventory = false Auto Hidden
bool Property has_armor_in_inventory = false Auto Hidden
bool Property has_clothes_in_inventory = false Auto Hidden


bool __has_cuffs_crossed = false
bool Property has_cuffs_crossed Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_cuffs_front = false
bool Property has_cuffs_front Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_cuffs_boxtied = false
bool Property has_cuffs_boxtied Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_cuffs_back = false
bool Property has_cuffs_back Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool Property has_mouth_gag Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_arms_device = false
bool Property has_arms_device Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_dwarven_device = false
bool Property has_dwarven_device Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_dd_suit = false
bool Property has_dd_suit Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_petsuit = false
bool Property has_petsuit Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_straitjacket = false
bool Property has_straitjacket Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_cuffs = false
bool Property has_cuffs Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_armbinder = false
bool Property has_armbinder Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_yoke = false
bool Property has_yoke Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_disablekick = false
bool Property has_disablekick Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_device = false
bool Property has_device Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_collar = false
bool Property has_collar Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_blindfold = false
bool Property has_blindfold Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_leash = false
bool Property has_leash Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_plug_anal = false
bool Property has_plug_anal Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_plug_vaginal = false
bool Property has_plug_vaginal Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_weapon_in_inventory = false
bool Property has_weapon_in_inventory Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

Float __has_weapon = 0.0
Float Property has_weapon Hidden
    Float Function get()
    EndFunction
    Function set(Float value)
    EndFunction
EndProperty

Float __dirty_level = 0.0
Float Property dirty_level Hidden
    Float Function get()
    EndFunction
    Function set(Float value)
    EndFunction
EndProperty

Float __wet_level = 0.0
Float Property wet_level Hidden
    Float Function get()
    EndFunction
    Function set(Float value)
    EndFunction
EndProperty

Float __has_body_armor = 0.0
Float Property has_body_armor Hidden
    Float Function get()
    EndFunction
    Function set(Float value)
    EndFunction
EndProperty

Float __has_armor = 0.0
Float Property has_armor Hidden
    Float Function get()
    EndFunction
    Function set(Float value)
    EndFunction
EndProperty

Float __has_shield = 0.0
Float Property has_shield Hidden
    Float Function get()
    EndFunction
    Function set(Float value)
    EndFunction
EndProperty

bool __has_shame_clothes = false
bool Property has_shame_clothes Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_lingerie = false
bool Property has_lingerie Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __has_heels = false
bool Property has_heels Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __is_restrained = false
bool Property is_restrained Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool __is_bounded = false
bool Property is_bounded Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

bool Property is_jailed = false Auto Hidden

bool __is_leashed = false
bool Property is_leashed Hidden
    bool Function get()
    EndFunction
    Function set(bool value)
    EndFunction
EndProperty

Float __has_jewelry = -1.0
Float Property has_jewelry Hidden
    Float Function get()
    EndFunction
    Function set(Float value)
    EndFunction
EndProperty

int __has_gold = -1
int Property has_gold Hidden
    int Function get()
    EndFunction
    Function set(int value)
    EndFunction
EndProperty
