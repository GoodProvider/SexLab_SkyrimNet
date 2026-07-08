Scriptname SkyrimNet_SexLab_Main extends Quest


import JContainers
import UIExtensions
import SkyrimNet_SexLab_Decorators
import SkyrimNet_SexLab_Stages
import SkyrimNet_SexLab_Utilities
import StorageUtil

SkyrimNet_SexLab_Stages Property stages Auto
SkyrimNet_SexLab_Handler_DOM_Interface Property handler_dom Auto 

; ---------------------------
; Optional Mods Found 
; ---------------------------
Bool Property ostimnet_found = False Auto

SexLabFramework Property sexlab Auto 

Faction Property SkyrimNet_SexLab_Faction_Victim Auto

; ---------------------------------------------------
; Globals 
; ---------------------------------------------------

; SexLab Active Sex 
; 0 - no active sexlab animations 
; 1 - one or more active sexlab animations
GlobalVariable Property skyrimnet_sexlab_active_sex Auto
bool Property active_sex
    bool Function Get()
        if skyrimnet_sexlab_active_sex.GetValue() == 1
            return true
        endif
        return false 
    EndFunction 
    Function Set(bool value)
        if value
            skyrimnet_sexlab_active_sex.SetValue(1)
        else
            skyrimnet_sexlab_active_sex.SetValue(0)
        endif
    EndFunction 
EndProperty

; ---------------------------------------------------


Function Trace(String func, String msg, Bool notification=False) global
    msg = "[SkyrimNet_SexLab_Main."+func+"] "+msg
    Debug.Trace(msg) 
    if notification
        Debug.Notification(msg)
    endif 
EndFunction

bool Property rape_allowed = true Auto
bool Property sex_edit_tags_player = true Auto 
bool Property sex_edit_tags_nonplayer = False Auto

String Property storage_actor_lock_key = "skyrimnet_sexlab_actor_lock" AutoReadOnly 
String Property storage_items_key = "skyrimnet_sexlab_storage_items" AutoReadOnly
String Property storage_arousal_key = "skyrimnet_sexlab_arousal_level" AutoReadOnly
String Property storage_thread_ejaculated = "skyrimnet_sexlab_thread_ejaculated" AutoReadOnly


; -----------------------------
; enable virgin blood
; -----------------------------
Bool Property virgin_blood_enabled = True Auto

; -----------------------------
; Time since last dirrect narration
; needed, sine there appears to be a race condition on when things hit the audio queue
; -----------------------------

; Controls when Direction Narration occur 
float Property direct_narration_cool_off Auto 
float Property direct_narration_max_distance Auto 
float Property direct_narration_max_distance_default Auto 
float Property direct_narration_last_time Auto 

; Race to speech 
int Property race_to_description Auto

int Property counter Auto 

Function Setup()
    Trace("Setup","")

    if Game.GetModByName("SexLab.esm") == 255
        Trace("Setup","Data/SexLab.esm does not exist") 
        Trace("Setup", "Can't find Data/SexLab.esm | SkyrimNet_SexLab will not work.", true)
        return 
    endif 
    ; --------------------------------
    ; Decorators
    ; --------------------------------
    SkyrimNet_SexLab_Decorators.RegisterDecorators() 
    ((self as Quest) as SkyrimNet_SexLab_Actions).Setup()
    ((self as Quest) as SkyrimNet_SexLab_MCM).Setup()
    ((self as Quest) as SkyrimNet_SexLab_Menu).Setup()
    ((self as Quest) as SkyrimNet_SexLab_Stages).Setup()
    ((self as Quest) as SkyrimNet_SexLab_Scene_Manager).Setup()

    ; --------------------------------
    ; DOM Handler
    ; --------------------------------
    handler_dom = None 
    bool skyrimnet_dom_found = Game.GetModByName("SkyrimNet_DOM.esp") != 255
    bool skyrimnet_sexlab_handler_dom_found = Game.GetModByName("SkyrimNet_SexLab_Handler_DOM.esp") != 255
    if skyrimnet_dom_found && skyrimnet_sexlab_handler_dom_found
        handler_dom = Game.GetFormFromFile(0x800, "SkyrimNet_SexLab_Handler_DOM.esp") as SkyrimNet_SexLab_Handler_DOM_Interface
        if handler_dom == None
            handler_dom = (self as Quest) as SkyrimNet_SexLab_Handler_DOM_Interface
            Trace("Setup", "ERROR: Failed to get external handler DOM. Using fallback.", true)
        elseif !handler_dom.Setup() 
            handler_dom = None 
            Trace("Setup","SkyrimNet_SexLab_Handler_DOM Setup failed")
        endif      
    endif 
    if handler_dom == None 
        handler_dom = (self as Quest) as SkyrimNet_SexLab_Handler_DOM_Interface
        Trace("Setup","SkyrimNet_SexLab_Handler_DOM found:"+skyrimnet_sexlab_handler_dom_found+", SkyrimNet_DOM found :"+skyrimnet_dom_found)
    endif 

    if handler_dom == None
        Trace("Setup", "CRITICAL: handler_dom is None. Quest will not function.", true)
    endif

    ; --------------------------------
    ; SexLab 
    ; --------------------------------


    ; Direct Narration 
    if direct_narration_cool_off == 0 
        direct_narration_cool_off = 20 
        direct_narration_max_distance = 15
        direct_narration_max_distance_default = 15
    endif 
    direct_narration_last_time = 0 

    if race_to_description <= 0 
        race_to_description = JValue.readFromFile("Data/SKSE/Plugins/SkyrimNet_Sexlab/creatures.json")
        JValue.retain(race_to_description)
    endif 

    ; --------------------------------
    ; Decorators
    ; --------------------------------
    if Game.GetModByName("TT_OStimNet.esp")  != 255
        ostimnet_found = True 
        Trace("Setup","Found TT_OstimNet.esp found")
    endif 

EndFunction


;----------------------------------------------------------------------------------------------------
; Stripped Items Storage
;----------------------------------------------------------------------------------------------------

Function StoreStrippedItems(Actor akActor, Form[] forms)
    if akActor == None || forms.Length == 0
        return 
    endif 
    Trace("AddStrippedItems",akActor.GetDisplayName()+" num_items:"+forms.Length)
    StorageUtil.FormListClear(akActor, storage_items_key)
    int i = 0
    while i < forms.Length
        StorageUtil.FormListAdd(akActor, storage_items_key, forms[i])
        i += 1
    endwhile
EndFunction 

Form[] Function UnStoreStrippedItems(Actor akActor)
    if akActor == None 
        return Utility.CreateFormArray(0)
    endif 
    if !HasStrippedItems(akActor)
        Trace("UnStoreStrippedItems",akActor.GetDisplayName()+" attempting to get stripped items: found none")
        return Utility.CreateFormArray(0)
    endif
    Form[] forms = StorageUtil.FormListToArray(akActor, storage_items_key)
    StorageUtil.FormListClear(akActor, storage_items_key)
    Trace("UnStoreStrippedItems",akActor.GetDisplayName()+" removed stored items: "+forms.Length)
    return forms
EndFunction

Bool Function HasStrippedItems(Actor akActor)
    if akActor == None || StorageUtil.FormListCount(akActor, storage_items_key) == 0
        return False
    endif 
    return true 
EndFunction

;----------------------------------------------------
; Yes No dialogue choice for the player 
;----------------------------------------------------
