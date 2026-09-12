scriptname SlaveTatsMCMMenu extends SKI_ConfigBase

SlaveTatsOnload Property st_extra auto

int targets
Actor target
int sections = 0
int tattoos = 0
int applied = 0

int needs_synch = 0

string[] target_menu_items
string[] section_menu_items
string[] tattoo_menu_items
string[] section_menu_current
int[] tattoo_menu_current

Form[] hair_colors
string[] hair_color_names
int num_hair_colors

int page_id = 0
int _pages = 0
string last_area = ""

string Function VERSION() global
    return "1.0.0" ; This is the data structure version, not the release number that's shown to users
EndFunction

int Function GetVersion()
    return 6 ; This is the code version, for MCM. Also not the release number that's shown to users
EndFunction

string Function AREA(string page) global
    if page == "Body Tattoos"
        return "Body"
    elseif page == "Face Tattoos"
        return "Face"
    elseif page == "Hand Tattoos"
        return "Hands"
    elseif page == "Foot Tattoos"
        return "Feet"
    endif

    return ""
EndFunction

bool Function _setup_sections(string area, int slot)
    int cache = SlaveTats.acquire_cache()
    int DOMain = JMap.getObj(cache, "default")

    tattoos = JValue.releaseAndRetain(tattoos, JValue.deepCopy(JMap.getObj(DOMain, area)))
    JMap.setObj(tattoos, "[No Tattoo]", JValue.objectFromPrototype("[{\"name\":\"[No Tattoo]\", \"section\":\"[No Tattoo]\", \"area\":\"" + area + "\"}]"))
    sections = JMap.allKeys(tattoos)
    section_menu_items = JMap.allKeysPArray(tattoos)

    applied = JValue.addToPool(JArray.object(), "SlaveTats-_setup_tattoos")
    if SlaveTats.query_applied_tattoos(target, 0, applied, area, slot)
        JValue.cleanPool("SlaveTats-_setup_tattoos")
        return true
    endif

;; This version was a little more capable, but a lot more slow on SSE

;    int query = JValue.addToPool(JMap.object(), "SlaveTats-_setup_sections")
;    int matches = JValue.addToPool(JArray.object(), "SlaveTats-_setup_sections")
;    int entry

;    int applied = JValue.addToPool(JArray.object(), "SlaveTats-_setup_sections")
;    if SlaveTats.query_applied_tattoos(target, 0, applied, area, slot)
;        JValue.cleanPool("SlaveTats-_setup_sections")
;        return true
;    endif

;    JMap.setStr(query, "area", area)
;    if SlaveTats.query_available_tattoos(query, matches, applied)
;        JValue.cleanPool("SlaveTats-_setup_sections")
;        return true
;    endif

;    tattoos = JValue.releaseAndRetain(tattoos, JMap.object())

;    JMap.setObj(tattoos, "[No Tattoo]", JValue.objectFromPrototype("[{\"name\":\"[No Tattoo]\", \"section\":\"[No Tattoo]\", \"area\":\"" + area + "\"}]"))

;    int i = JArray.count(matches)
;    while i > 0
;        i -= 1

;        entry = JArray.getObj(matches, i)

;        JMap.removeKey(entry, "slot") ; The menu does not respect tattoo pre-specified slots. That's for mods.

;        int section = JMap.getObj(tattoos, JMap.getStr(entry, "section"))
;        if section == 0
;            section = JValue.addToPool(JArray.object(), "SlaveTats-_setup_sections")
;            JMap.setObj(tattoos, JMap.getStr(entry, "section"), section)
;        endif
;        JArray.addObj(section, entry)
;    endwhile

;    sections = JValue.releaseAndRetain(sections, JMap.allKeys(tattoos))

;    int num_sections = JArray.count(sections)
;    if num_sections > 127
;        num_sections = 127
;    endif

;    section_menu_items = Utility.CreateStringArray(num_sections)
;    i = 0
;    while i < num_sections
;        section_menu_items[i] = JArray.getStr(sections, i)
;        i += 1
;    endwhile

;    JValue.cleanPool("SlaveTats-_setup_sections")

;    return false
EndFunction

bool Function _setup_tattoos(string section)
    int tats = JMap.getObj(tattoos, section)

    if tats == 0
        JValue.cleanPool("SlaveTats-_setup_tattoos")
        return true
    endif

    int buffer = JValue.addToPool(JArray.object(), "SlaveTats-_setup_tattoos")

    int i = 0
    int num_tats = JArray.count(tats)
    while i < num_tats
        int entry = JArray.getObj(tats, i)
        if (SlaveTats.find_excluding_tattoo(applied, entry) < 0) && (SlaveTats.find_required_tattoo(applied, entry) >= 0)
            JMap.removeKey(entry, "slot") ; The menu does not respect tattoo pre-specified slots. That's for mods.
            JArray.addStr(buffer, JMap.getStr(entry, "name"))
            i += 1
        else
            JArray.eraseIndex(tats, i)
        endif
    endwhile

    if JContainers.APIVersion() >= 4 && JContainers.featureVersion() >= 1
        tattoo_menu_items = JArray.asStringArray(buffer)
    else
        tattoo_menu_items = botticelli_asStringArray(buffer)
    endif

    JValue.cleanPool("SlaveTats-_setup_tattoos")
    return false
EndFunction

; Contributed by botticelli on LoversLab: https://www.loverslab.com/topic/25398-slavetats/page/171/#comment-3718263
string[] Function botticelli_asStringArray(int buffer)
    int count = JArray.count(buffer)
    string[] result
    if count > 0
        result = Utility.CreateStringArray(count)
        int i = 0
        while i < count
            result[i] = Jarray.getStr(buffer, i)
            i += 1
        endwhile
    endif
    return result
EndFunction

Function cleanup()
    int i = JArray.count(targets)
    while i > 0
        i -= 1
        Actor who = JArray.getForm(targets, i) as Actor
        SlaveTats.remove_tattoos(who, 0, True)
        SlaveTats.synchronize_tattoos(who)
    endwhile

    JDB.setObj("SlaveTats", 0)
    JDB.setObj("SlaveTatsMenu", 0)

    JValue.cleanPool("SlaveTats-_setup_sections")
    JValue.cleanPool("SlaveTats-OnConfigOpen")
    JValue.cleanPool("SlaveTats-OnConfigClose")
EndFunction

event OnVersionUpdate(int version)

endevent

event OnConfigOpen()
	Debug.Trace("SlaveTatsMCMMenu::OnConfigOpen")
    if !JContainers.isInstalled()
        ShowMessage("Warning: This version of SlaveTats uses version 3 or greater of the JContainers API. You do not have JContainers installed.", false)
        return
    endif

    if JContainers.APIVersion() < 3
        ShowMessage("Warning: This version of SlaveTats uses version 3 or greater of the JContainers API. You have a different version installed.", false)
        return
    endif

    Pages = new string[5]
    ;Pages = new string[6]

    Pages[0] = "Setup"
    Pages[1] = "Body Tattoos"
    Pages[2] = "Face Tattoos"
    Pages[3] = "Hand Tattoos"
    Pages[4] = "Foot Tattoos"
    ;Pages[5] = "Extra"

    needs_synch = JValue.addToPool(JFormMap.object(), "SlaveTats-OnConfigClose")

    target = Game.GetPlayer()

    string old_version = JDB.solveStr(".SlaveTatsMenu.version")
    if old_version != VERSION()
        Debug.Trace("SlaveTats Menu: Initializing the menu data structures, version " + VERSION())
        int config = JValue.addToPool(JMap.object(), "SlaveTats-OnConfigOpen")
        JMap.setStr(config, "version", VERSION())
        JMap.setObj(config, "known_targets", JArray.object())
        JMap.setForm(config, "last_target", target)
        JDB.setObj("SlaveTatsMenu", config)
        JArray.addForm(JDB.solveObj(".SlaveTatsMenu.known_targets"), target)

        Debug.Trace("SlaveTats Menu: Setting up player character")
        SlaveTats.upgrade_tattoos(target)
        JFormMap.setInt(needs_synch, target, 1)
    endif

    int known = JDB.solveObj(".SlaveTatsMenu.known_targets")
    if known == 0
        Debug.Trace("SlaveTats Menu: The list of known targets is null! Re-initializing it.")

        known = JValue.addToPool(JArray.object(), "SlaveTats-OnConfigOpen")
        JDB.solveObjSetter(".SlaveTatsMenu.known_targets", known)

        JArray.addForm(known, target)
    endif

    bool player_in_known = false

    int i = JArray.count(known)
    while i > 0
        i -= 1

        Actor previously_known = JArray.getForm(known, i) as Actor
        if previously_known == None
            JArray.eraseIndex(known, i)
        elseif previously_known == target
            player_in_known = True
        endif
    endwhile

    Debug.Trace("SlaveTats Menu: There are currently " + JArray.count(known) + " known targets.")

    if !player_in_known
        Debug.Trace("SlaveTats Menu: The player was not in the known list. Adding.")
        JArray.addForm(known, target)
    endif

    targets = JValue.addToPool(JArray.object(), "SlaveTats-OnConfigClose")
    JArray.addFromArray(targets, JDB.solveObj(".SlaveTatsMenu.known_targets"))

    target = JDB.solveForm(".SlaveTatsMenu.last_target") as Actor

    if target == None
        Debug.Trace("SlaveTats Menu: .SlaveTatsMenu.last_target is null. Falling back targets[0]")
        target = JArray.getForm(targets, 0) as Actor
        if target == None
            Debug.Trace("SlaveTats Menu: targets[0] is null. Falling back on Game.GetPlayer()")
            target = Game.GetPlayer()
            JArray.addForm(targets, target)
        endif
    endif

    Debug.Trace("SlaveTats Menu: The default target is " + target.GetDisplayName())

    Actor player = Game.GetPlayer()
    Actor temp_target
    int loop_count = 12
    while loop_count > 0
        loop_count -= 1
        temp_target = Game.FindRandomActorFromRef(player, 300.0)
        if JArray.findForm(targets, temp_target) < 0
            JArray.addForm(targets, temp_target)
            Debug.Trace("SlaveTats Menu: Found nearby actor " + temp_target.GetDisplayName())
        endif
    endwhile

    loop_count = JArray.count(targets)

    if loop_count > 127
        loop_count = 127
    endif

    Debug.Trace("SlaveTats Menu: Setting up target selection choices.")
    target_menu_items = Utility.CreateStringArray(loop_count)

    while loop_count > 0
        loop_count -= 1
        target_menu_items[loop_count] = (JArray.getForm(targets, loop_count) as Actor).GetDisplayName()
    endwhile

    FormList HairColorList = Game.GetFormFromFile(0xE7BED, "Skyrim.esm") as FormList
    FormList SlaveTatsHairColors = Game.GetFormFromFile(0x6774, "SlaveTats.esp") as FormList
	int nhaircolors = 0
	if HairColorList != None
		nhaircolors = HairColorList.GetSize()
	endif
	int nslhaircolors = 0
	if SlaveTatsHairColors != None
		nslhaircolors = SlaveTatsHairColors.GetSize()
	endif
    int offset = 1
    num_hair_colors = offset + nhaircolors + nslhaircolors
    hair_colors = Utility.CreateFormArray(num_hair_colors)
    hair_color_names = Utility.CreateStringArray(num_hair_colors)

    hair_color_names[0] = "[No change]"

    loop_count = nslhaircolors
    while loop_count > 0
        loop_count -= 1
        hair_colors[offset + loop_count] = SlaveTatsHairColors.GetAt(loop_count)
        hair_color_names[offset + loop_count] = hair_colors[offset + loop_count].GetName()
    endwhile

    offset = 1 + nslhaircolors

    loop_count = nhaircolors
    while loop_count > 0
        loop_count -= 1
        hair_colors[offset + loop_count] = HairColorList.GetAt(loop_count)
        hair_color_names[offset + loop_count] = hair_colors[offset + loop_count].GetName()
    endwhile

    SlaveTats.acquire_cache()

    JValue.cleanPool("SlaveTats-OnConfigOpen")
    last_area = "" ; resets area from the last time we opened MCM
endevent

Function apply_to_target()
    if target != None
        st_extra.apply_customizations()

        Debug.Trace("SlaveTats Menu: Leaving target " + target.GetDisplayName() + ". Queueing synchronization.")
        JDB.solveFormSetter(".SlaveTatsMenu.last_target", target)

        int known = JDB.solveObj(".SlaveTatsMenu.known_targets")
        if JArray.findForm(known, target) < 0
            JArray.addForm(known, target)
        endif

        JFormMap.setInt(needs_synch, target, 1)
    endif
EndFunction

event OnConfigClose()
    apply_to_target()

    int keys = JValue.addToPool(JFormMap.allKeys(needs_synch), "SlaveTats-OnConfigClose")
    int i = JArray.count(keys)
    while i > 0
        i -= 1
        SlaveTats.synchronize_tattoos(JArray.getForm(keys, i) as Actor)
    endwhile

    JValue.cleanPool("SlaveTats-OnConfigClose")
    JValue.release(sections)
    JValue.release(tattoos)
    SlaveTats.release_cache()
endevent

event OnPageReset(string page)
    string area = AREA(page)

    if page == ""

    elseif page == "Setup"
        AddMenuOptionST("TARGET", "Target", target.GetDisplayName())
        AddTextOptionST("RECOMPILE", "Add/remove tattoos", "")
    elseif page == "Extra"
        if target == Game.GetPlayer()
            AddHeaderOption("This tab is for NPC targets")
            AddHeaderOption("Use showracemenu on the console")
        else
            AddInputOptionST("NAME", "Name", target.GetDisplayName(), 0)
            AddMenuOptionST("HAIRCOLOR", "Hair Color", "[No change]")
            AddSliderOptionST("WEIGHT", "Weight", target.GetActorBase().GetWeight())
        endif
    else
        SetCursorFillMode(LEFT_TO_RIGHT)

        ; resets the page when we change area
        if area != last_area
            page_id = 0
            last_area = area
        endif

        AddHeaderOption(area + " Patterns")
        AddHeaderOption(area + " Colors")

        int external = JValue.addToPool(JArray.object(), "SlaveTats-OnPageReset")
        SlaveTats.external_slots(target, area, external)

        int slots = SlaveTats.SLOTS(area)

        section_menu_current = Utility.CreateStringArray(slots)
        tattoo_menu_current = Utility.CreateIntArray(slots)

        ; -----------------------------------------------------------------------------------------------------------------------------------
        ; --------------------------------------------------- Crude paging Functionality ----------------------------------------------------
        ; -----------------------------------------------------------------------------------------------------------------------------------
        float slots_per_page = 12.0
        _pages = Math.Ceiling(slots / slots_per_page)

        if _pages > 1
            AddSliderOptionST("PageSelectorST", "Select page:", page_id + 1, "{0}")
            AddEmptyOption()
        endif

        ; -----------------------------------------------------------------------------------------------------------------------------------
        ; ---------------------------- State Names changed to allow for easier switching using StringUtil.Split -----------------------------
        ; ---------------------------- Some visual changes, personal preference but i like it better this way   -----------------------------
        ; ---------------------------- Also - a bit easier to find which page and which slot youre at           -----------------------------
        ; -----------------------------------------------------------------------------------------------------------------------------------
        int slot = (page_id * slots_per_page) as int
        while (slot < (page_id + 1) * slots_per_page && slot < slots)
            if JArray.findInt(external, slot) >= 0
                section_menu_current[slot] = "External"
                tattoo_menu_current[slot] = 0

                AddHeaderOption("Slot " + (slot + 1))
                AddEmptyOption()
                AddMenuOptionST("SECTIONSLOT_" + slot, "Section " + (slot + 1), "External", OPTION_FLAG_DISABLED)
                AddColorOptionST("COLORSLOT_" + slot, "Ink " + (slot + 1), 0, OPTION_FLAG_DISABLED)
                AddMenuOptionST("TATTOOSLOT_" + slot, "Pattern " + (slot + 1), "External", OPTION_FLAG_DISABLED)
                AddColorOptionST("GLOWSLOT_" + slot, "Glow " + (slot + 1), 0, OPTION_FLAG_DISABLED)
                AddEmptyOption()
                AddToggleOptionST("GLOSSSLOT_" + slot, "Glossy " + (slot + 1), false, OPTION_FLAG_DISABLED)
            else
                int entry = SlaveTats.get_applied_tattoo_in_slot(target, area, slot)
                if entry == 0
                    section_menu_current[slot] = "[No Tattoo]"
                    tattoo_menu_current[slot] = 0

                    AddHeaderOption("Slot " + (slot + 1))
                    AddEmptyOption()
                    AddMenuOptionST("SECTIONSLOT_" + slot, "Section " + (slot + 1), "[No Tattoo]")
                    AddColorOptionST("COLORSLOT_" + slot, "Ink " + (slot + 1), 0)
                    AddMenuOptionST("TATTOOSLOT_" + slot, "Pattern " + (slot + 1), "[No Tattoo]")
                    AddColorOptionST("GLOWSLOT_" + slot, "Glow " + (slot + 1), 0)
                    AddEmptyOption()
                    AddToggleOptionST("GLOSSSLOT_" + slot, "Glossy " + (slot + 1), false)
                else
                    int flag = 0
                    if JMap.getInt(entry, "locked") > 0
                        flag = OPTION_FLAG_DISABLED
                    endif

                    section_menu_current[slot] = JMap.getStr(entry, "section")
                    tattoo_menu_current[slot] = entry

                    AddHeaderOption("Slot " + (slot + 1))
                    AddEmptyOption()
                    AddMenuOptionST("SECTIONSLOT_" + slot, "Section " + (slot + 1), JMap.getStr(entry, "section"), flag)
                    AddColorOptionST("COLORSLOT_" + slot, "Ink " + (slot + 1), JMap.getInt(entry, "color"), flag)
                    AddMenuOptionST("TATTOOSLOT_" + slot, "Pattern " + (slot + 1), JMap.getStr(entry, "name"), flag)
                    AddColorOptionST("GLOWSLOT_" + slot, "Glow " + (slot + 1), JMap.getInt(entry, "glow"), flag)
                    AddEmptyOption()
                    AddToggleOptionST("GLOSSSLOT_" + slot, "Glossy " + (slot + 1), JMap.getInt(entry, "gloss") as bool, flag)
                endif
            endif
            slot += 1
        endwhile
    endif

    JValue.cleanPool("SlaveTats-OnPageReset")
endevent

; -----------------------------------------------------------------------------------------------------------------------------------
; ------------------------------------------------------- Page selector, duh --------------------------------------------------------
; -----------------------------------------------------------------------------------------------------------------------------------
state PageSelectorST
    event onSliderOpenST()
                SetSliderDialogStartValue(page_id + 1)
                SetSliderDialogDefaultValue(page_id + 1)
                SetSliderDialogRange(1, _pages)
                SetSliderDialogInterval(1)
        endEvent

        event onSliderAcceptST(float value)
                page_id = (value as int) - 1
                SetSliderOptionValueST(page_id, "{0}")
        ForcePageReset()
        endEvent
endstate

state TARGET
    event OnMenuOpenST()
        SetMenuDialogStartIndex(JArray.findForm(targets, target))
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(target_menu_items)
    endevent

    event OnMenuAcceptST(int index)
        apply_to_target()
        target = JArray.getForm(targets, index) as Actor
        SetMenuOptionValueST(target_menu_items[index])
        SlaveTats.upgrade_tattoos(target)
    endevent

    event OnDefaultST()
        target = JArray.getForm(targets, 0) as Actor
        SetMenuOptionValueST(target_menu_items[0])
    endevent

    event OnHighlightST()
        SetInfoText("Select the person to modify. This list will always contain the player character. Any character you have tattooed will appear here as well. Finally, nearby characters will be added to the list.")
    endevent
endstate

state RECOMPILE
    event OnSelectST()
        SetTextOptionValueST("Working...")
        SlaveTats.compile_cache()
        SetTextOptionValueST("")
    endEvent

    event OnDefaultST()
        SetTextOptionValueST("")
    endEvent

    event OnHighlightST()
        SetInfoText("After you install a new tattoo pack (or multiple new tattoo packs), click this button to make them available in SlaveTats. Similarly, if you uninstall tattoo packs, click this button to remove them.")
    endEvent
endState

state NAME
    event OnInputAcceptST(string value)
        SetInputOptionValueST(value, False, "NAME")
        JMap.setStr(st_extra._actor_extra(target), "name", value)
        st_extra._requires_update_on_load(target)
    endevent

    event OnHighlightST()
        SetInfoText("Mods that change how followers work can interfere with this. If the name doesn't change, or the change doesn't stick, that's probably why.")
    endevent
endstate

state HAIRCOLOR
    event OnMenuOpenST()
        SetMenuDialogStartIndex(0)
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(hair_color_names)
    endevent

    event OnMenuAcceptST(int index)
        if index > 0
            SetMenuOptionValueST(hair_color_names[index])
            ColorForm selected = hair_colors[index] as ColorForm
            JMap.setForm(st_extra._actor_extra(target), "hair_color", selected)
            st_extra._requires_update_on_load(target)
        endif
    endevent
endstate

state WEIGHT
    event OnSliderOpenST()
        SetSliderDialogRange(0, 100)
        SetSliderDialogStartValue(target.GetActorBase().GetWeight())
        SetSliderDialogDefaultValue(50)
        SetSliderDialogInterval(1)
    endevent

    event OnSliderAcceptST(float value)
        SetSliderOptionValueST(value)
        JMap.setFlt(st_extra._actor_extra(target), "weight", value)
        st_extra._requires_update_on_load(target)
    endevent
endstate

; -----------------------------------------------------------------------------------------------
; ---------------------------- use non encapsulated state           -----------------------------
; ---------------------------- switch based on GetState             -----------------------------
; ---------------------------- allows to have one switching handler -----------------------------
; -----------------------------------------------------------------------------------------------
event OnMenuOpenST()
    string _state = GetState()
    string[] ids = StringUtil.Split(_state, "_")
    int slot = ids[1] as int

    if ids[0] == "SECTIONSLOT"
		Debug.Trace("SlaveTatsMCMMenu::OnMenuOpenST 0 "+slot+" "+CurrentPage)
		Debug.Trace("SlaveTatsMCMMenu::OnMenuOpenST 0 "+AREA(CurrentPage))
		Debug.Trace("SlaveTatsMCMMenu::OnMenuOpenST 0 "+section_menu_current[slot])
        _setup_sections(AREA(CurrentPage), slot)
        SetMenuDialogStartIndex(section_menu_items.Find(section_menu_current[slot]))
        SetMenuDialogDefaultIndex(section_menu_items.Find("[No Tattoo]"))
        SetMenuDialogOptions(section_menu_items)
    elseif ids[0] == "TATTOOSLOT"
		Debug.Trace("SlaveTatsMCMMenu::OnMenuOpenST 1 "+slot+" "+CurrentPage)
		Debug.Trace("SlaveTatsMCMMenu::OnMenuOpenST 1 "+AREA(CurrentPage))
		Debug.Trace("SlaveTatsMCMMenu::OnMenuOpenST 1 "+section_menu_current[slot])
        _setup_sections(AREA(CurrentPage), slot)
        _setup_tattoos(section_menu_current[slot])
        if tattoo_menu_current[slot] == 0
            SetMenuDialogStartIndex(0)
        else
            SetMenuDialogStartIndex(tattoo_menu_items.Find(JMap.getStr(tattoo_menu_current[slot], "name")))
        endif
        SetMenuDialogDefaultIndex(0)
        SetMenuDialogOptions(tattoo_menu_items)
    endif
endEvent

event OnMenuAcceptST(int index)
    string _state = GetState()
    string[] ids = StringUtil.Split(_state, "_")
    int slot = ids[1] as int

    if ids[0] == "SECTIONSLOT"
        if index < 0
            section_menu_current[slot] = "[No Tattoo]"
            SetMenuOptionValueST("[No Tattoo]")
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]", false, "TATTOOSLOT_" + slot)
                SetColorOptionValueST(0, false, "COLORSLOT_" + slot)
                SetColorOptionValueST(0, false, "GLOWSLOT_" + slot)
                SetToggleOptionValueST(false, false, "GLOSSSLOT_" + slot)
            endif
        elseif section_menu_current[slot] != section_menu_items[index]
            section_menu_current[slot] = section_menu_items[index]
            SetMenuOptionValueST(section_menu_current[slot])
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), 0)
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"), false, "TATTOOSLOT_" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLORSLOT_" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOWSLOT_" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSSSLOT_" + slot)
                endif
            endif
        endif
    elseif ids[0] == "TATTOOSLOT"
        if index == -1 || tattoo_menu_items[index] == "[No Tattoo]"
            Debug.Trace("SlaveTats Menu: Emptying slot " + slot)
            if tattoo_menu_current[slot] != 0 && !SlaveTats.remove_tattoo_from_slot(target, AREA(CurrentPage), slot)
                tattoo_menu_current[slot] = 0
                SetMenuOptionValueST("[No Tattoo]")
                SetColorOptionValueST(0, false, "COLORSLOT_" + slot)
                SetColorOptionValueST(0, false, "GLOWSLOT_" + slot)
                SetToggleOptionValueST(false, false, "GLOSSSLOT_" + slot)
            endif
        else
            int entry = JArray.getObj(JMap.getObj(tattoos, section_menu_current[slot]), index)
            Debug.Trace("SlaveTats Menu: Setting slot " + slot + " to " + JMap.getStr(entry, "name"))
            if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
                entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
                if entry != 0
                    Debug.Trace("SlaveTats Menu: Succeeded")
                    tattoo_menu_current[slot] = entry
                    SetMenuOptionValueST(JMap.getStr(entry, "name"))
                    SetColorOptionValueST(JMap.getInt(entry, "color"), false, "COLORSLOT_" + slot)
                    SetColorOptionValueST(JMap.getInt(entry, "glow"), false, "GLOWSLOT_" + slot)
                    SetToggleOptionValueST(JMap.getInt(entry, "gloss") > 0, false, "GLOSSSLOT_" + slot)
                endif
            endif
        endif
    endif
endEvent

event OnDefaultST()
    string _state = GetState()
    string[] ids = StringUtil.Split(_state, "_")
    int slot = ids[1] as int

    if ids[0] == "SECTIONSLOT"
        section_menu_current[slot] = "[No Tattoo]"
        SetMenuOptionValueST("[No Tattoo]")
    elseif ids[0] == "TATTOOSLOT"
        int entry = JArray.getObj(tattoos, 0)
        if !SlaveTats.tattoo_matches(entry, tattoo_menu_current[slot])
            entry = SlaveTats.add_and_get_tattoo(target, entry, slot)
            if entry != 0
                tattoo_menu_current[slot] = entry
                SetMenuOptionValueST(JMap.getStr(entry, "name"))
            endif
        endif
    elseif ids[0] == "COLORSLOT"
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != 0
            JMap.setInt(entry, "color", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    elseif ids[0] == "GLOWSLOT"
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != 0
            JMap.setInt(entry, "glow", 0)
            SetColorOptionValueST(0)
            SlaveTats.mark_actor(target)
        endif
    elseif ids[0] == "GLOSSSLOT"
        int entry = tattoo_menu_current[slot]
        JMap.setInt(entry, "gloss", 0)
        SetToggleOptionValueST(false)
        SlaveTats.mark_actor(target)
    endif
endEvent

event OnHighlightST()
    string _state = GetState()
    string[] ids = StringUtil.Split(_state, "_")

    if ids[0] == "SECTIONSLOT"
        SetInfoText("Pick a tattoo collection to select your tattoo from. To remove a tattoo, select [No Tattoo] from the section menu.")
    elseif ids[0] == "TATTOOSLOT"
        int slot = ids[1] as int
        int entry = tattoo_menu_current[slot]
        string credit = JMap.getStr(entry, "credit")
        if credit
            SetInfoText("Tattoo by: " + credit)
        endif
    elseif ids[0] == "COLORSLOT"
        SetInfoText("Pick the ink color for this tattoo.")
    elseif ids[0] == "GLOWSLOT"
        SetInfoText("Pick a color for the tattoo to glow (black is no glow).")
    elseif ids[0] == "GLOSSSLOT"
        SetInfoText("Checking this makes the tattoo slightly glossy, like skin.")
    endif
endEvent

event OnColorOpenST()
    string _state = GetState()
    string[] ids = StringUtil.Split(_state, "_")
    int slot = ids[1] as int

    if ids[0] == "COLORSLOT"
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "color"))
        SetColorDialogDefaultColor(0)
    elseif ids[0] == "GLOWSLOT"
        int entry = tattoo_menu_current[slot]
        SetColorDialogStartColor(JMap.getInt(entry, "glow"))
        SetColorDialogDefaultColor(0)
    endif
endEvent

event OnColorAcceptST(int color)
    string _state = GetState()
    string[] ids = StringUtil.Split(_state, "_")
    int slot = ids[1] as int

    if ids[0] == "COLORSLOT"
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "color") != color
            JMap.setInt(entry, "color", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    elseif ids[0] == "GLOWSLOT"
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "glow") != color
            JMap.setInt(entry, "glow", color)
            SetColorOptionValueST(color)
            SlaveTats.mark_actor(target)
        endif
    endif
endEvent

event OnSelectST()
    string _state = GetState()
    string[] ids = StringUtil.Split(_state, "_")
    int slot = ids[1] as int

    if ids[0] == "GLOSSSLOT"
        int entry = tattoo_menu_current[slot]
        if JMap.getInt(entry, "gloss") > 0
            JMap.setInt(entry, "gloss", 0)
            SetToggleOptionValueST(false)
        else
            JMap.setInt(entry, "gloss", 1)
            SetToggleOptionValueST(true)
        endif
        SlaveTats.mark_actor(target)
    endif
endEvent
