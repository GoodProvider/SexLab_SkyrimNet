Scriptname DOM_API extends Quest

Import Utility
Import DOM_Util

DOM_Core Property DOM auto

Faction Property DOMActorFaction auto 
Faction Property DOMPlayerSlaveFaction auto 
Faction Property DOMPlayerSlaverFaction auto

String[] Property validMoods auto
String[] Property TraitNames auto
;Add this framework as a Property to your scripts to use it.

;If you are using Functions in of DOM outside of this script, you are probably doing something fucky, and you should stop and reconsider if you really *need* to do it that way.
;the guts of this mod are largely nicht fur gefingerpoken, and you fingerpoken them at your own risk, and the risk of your users. 

;Now, place your hand over your heart and repeat after me: 

;/ I, [name here], do solemnly swear to only extend or add to DOM in a way that does not overwrite any of the main files of the mod. 
I shall not overwrite. I will not overwrite. I must not overwrite. I cannot overwrite.
I henceforth accept any amount of hellfire and belligerence in my direction if I break this oath. Forever and ever, Amen. /;

;Let me say this one more time just to be extra super clear:
;YOU WILL NOT OVERWRITE DOM'S SCRIPTS DIRECTLY.  

;One final note: this script does not currently use DOMs coding style conventions, because it was not written by TAK. 
;This shouldn't be too much of a problem, just wanted to clarify. 

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;Now with that out of the way, enjoy the API! Use and abuse responsibly. <3
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;DOM EVENTS
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;This is a list of ModEvents you can listen for with RegisterForModEvent
;Make sure you include the same variables as the event in your callback to it!
;Events can be send either as global or per Actor
;  1) For global events - To be defined in your quest script
;     Turn on events with: DOMCore.SetSendExternalEvents(true)
;     or for extended events
;     Turn on events with: DOMCore.SetSendExternalEventsExt(true)
;                       or DOMCore.SetSendExternalEventsExt2(true)
;                       or DOMCore.SetSendExternalEventsExt3(true)
;     Listen to events with: 
;            	string eventName = "DOMOnMoodChange" ; this is an example
;    	        string callbackName = "OnMoodChange" ; this is the name of your local Function as defined in the list below
;               RegisterForModEvent(eventName, callbackName)
;  2) For actor events - To be defined in a reference alias script
;     Turn on events with: DOMActor.SetSendExternalEvents(true) ; where DOMActor is a DOM reference alias of type DOM_Actor
;     or for extended events
;     Turn on events with: DOMActor.SetSendExternalEventsExt(true) ; where DOMActor is a DOM reference alias of type DOM_Actor
;                       or DOMActor.SetSendExternalEventsExt2(true)
;                       or DOMActor.SetSendExternalEventsExt3(true)
;     Listen to events with: 
;               Actor akRef = the_alias.GetActorRef() ; the_alias could be your quest reference alias or a DOM_Actor
;               string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
;            	string eventName = "DOMOnMoodChange"+formid ; this is an example
;    	        string callbackName = "OnMoodChange" ; this is the name of your local Function as defined in the list below
;               RegisterForModEvent(eventName, callbackName)

; EXISTING EVENTS! EXISTING EVENTS! EXISTING EVENTS! EXISTING EVENTS! EXISTING EVENTS! EXISTING EVENTS! EXISTING EVENTS!
;~~MENTAL CHANGES~~ ACTOR EVENTS Turn on those events with: SetSendExternalEvents(true)
;DOMOnBehaviourChange(Form sender, string behaviour) ; behaviour = pose, masturbate, follow_player, BUT NOT running_away (see below) s... see states in DOM_Actor.psc 
;DOMOnMoodChange(Form sender, string mood) ; mood = angry, afraid, broken, inlove, ... see states in DOM_ Mind.psc 
;DOMOnTrainingComplete(Form sender)
;DOMOnInBag(Form sender) 
;DOMOnOutBag(Form sender)
;DOMOnCallForHelp(Form sender, string type) ; type = inbag, leashed (call was magically suppressed), mumbles (noone hears), yells (actually garbles if with gag), fights
;DOMOnOrgasm(Form sender, string type) ; type = sex, rape, grab, masturbate, arousal, kink, magic
;DOMOnKinkDiscovered(Form sender, string kink)
;DOMOnLostVirginity(Form sender, string type)
;DOMOnRunaway(Form sender)  ; for behaviour change to running_away only

;~~MENTAL CHANGES EXTENDED~~ Turn on those events with: SetSendExternalEventsExt(true)
;DOMOnDrunkennessChange(Form sender, int drunkLevel)
;DOMOnTrainingStatusUpdate(Form sender, string type, int value) ; type = freshly captured, degraded, mesmerized, ... value = 1, 2, 3, ...
;DOMOnHEXACOChange(Form sender, string trait, float value)
;DOMOnFACETChange(Form sender, string facet, float value)
;DOMOnTrainingStatChange(Form sender, string stat, float value)

;~~WHEEL MENU/PLAYER ACTIONS (SLAVE PERSPECTIVE)~~ Turn on those events with: SetSendExternalEventsExt2(true)
; Those events are only sent if the player initiated them. Trainers do not fire those events.
;DOMOnSex(Form sender, string sexOrRape, string punishReason, bool hadOrgasm)
;DOMOnPriceInspection(Form sender, float value, bool isObedient)
;DOMOnBodyInspection(Form sender, string inspectionMethod, string inspectionResults, bool isObedient)
;DOMOnKissed(Form sender, string kissType, string kissResults, bool isObedient)
;DOMOnPraised(Form sender, string praiseMethod, string praiseReason, bool isObedient)
;DOMOnPunished(Form sender, string punishMethod, string punishReason, bool isObedient)
;DOMOnFlattered(Form sender, string flatteryType, bool isObedient)
;DOMOnInsulted(Form sender, string insultType, bool isObedient)
;DOMOnComforted(Form sender, string comfortType, bool isObedient)
;DOMOnPromised(Form sender, string promisedOath, bool isAccepted)
;DOMOnThreatened(Form sender, string threatenedFor, bool isAccepted)
;DOMOnUndress(Form sender, string undressType, bool isObedient) ; If isObedient is false stripping didn't occur
;DOMOnWashSelf(Form sender, string washType, bool isObedient) ; If isObedient is false washing didn't occur
;DOMOnBranded(Form sender, string markName, string markArea, bool isObedient)
;DOMOnSalute(Form sender, string saluteType, string salutePose, bool isObedient)
;DOMOnCaptured(Form sender, string mood, bool isPlayerSlave)
;DOMOnRecruited(Form sender, string mood, bool isNewActor) ; If not new actor, slaver was previously in DOM
;DOMOnReleased(Form sender, string mood, bool isObedient)

;~~DIARY ENTRY FULL TEXT (SLAVE PERSPECTIVE)~~ Turn on those events with: SetSendExternalEventsExt3(true)
; This is only sent the first time an entry is registered in the diary
; Most events defined above and more will give an entry. It is recommended to use this or the events above, not both.
;DOMOnDiaryUpdate(Form sender, string entryType, string entryReason, bool isSuccess, string fullText)
;DOMOnNotificationSent(Form sender, string actorStatus, bool isPlayersSlave, string fullText)

; NOT IMPLEMENTED ; After this line, events are not implemented

;~~MOBILITY CHANGES~~
;DOMOnTiedUp(Form sender, string type)
;DOMOnReleasedFromBondage(Form sender, string type)
;DOMOnEscapedBondage(Form sender)
;DOMOnRunAway(Form sender, bool withFriend)
;DOMOnSuccessfulRunAway(Form sender)
;DOMOnCanMove(Form sender)
;DOMOnImmobilize(Form sender, string immobileReason)
;DOMOnTripAndFall(Form sender)
;DOMOnBagged(Form sender)
;DOMOnRemovedFromBag(Form sender)
;DOMOnWait(Form sender)
;DOMOnFollowPlayer(Form Sender)

;~~LOCATION CHANGES~~
;DOMOnEnterCity(Form sender, Form location)
;DOMOnEnterTown(Form sender, Form location)
;DOMOnEnterDungeon(Form sender, Form location)
;DOMOnEnterInteriorCell(Form sender, Form location)

;~~SOCIAL CHANGES~~
;DOMOnMakeFriend(Form sender, form newFriend, int friendshipType)
;DOMOnMakeRival(Form sender, form newRival)
;DOMOnReceiveJewelry(Form sender, Form jewelryGiven)

;~~DIALOGUE~~
;DOMOnCryForHelp(Form sender)
;DOMOnSayChatter

;~~SEX~~
;DOMOnStartSex(Form sender, Form partner, form thirdperson, bool rape)
;DOMOnPostRape(Form sender, form partner, form thirdperson)
;DOMOnPostSex(Form sender, form partner, form thirdperson)

;~~ANIMATION~~
;DOMOnAnimate(Form sender, string animation)

;~~End of events~~

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; DOM API Functions
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Function Initialize()
	LogInfo("=================================================================================")
	LogInfo("==                             DOM: API for addons                             ==")
	LogInfo("=================================================================================")
EndFunction

;returns a DOM_Actor alias for the given Actor, if one exists. 
DOM_Actor Function GetDOMActor(Actor akActor) 
    DOM_Actor actor_alias = DOM.GetActor(akActor)
   
    if(!actor_alias)
        LogInfo("[GetDOMActor] ERROR: Could not find a DOM_Actor for "+akActor.GetDisplayName()+"!", 2)
        return None
    endif
        
    return actor_alias

EndFunction

;returns true if the actor is in DOMActorFaction (slave or slaver)
bool Function IsDOMActor(Actor akActor)
    return akActor.IsInFaction(DOMActorFaction)
EndFunction

;returns true if the actor is in DOMPlayerSlaveFaction
bool Function IsDOMSlave(Actor akActor)
    return akActor.IsInFaction(DOMPlayerSlaveFaction)
EndFunction

;returns true if the actor is in DOMPlayerSlaverFaction
bool Function IsDOMSlaver(Actor akActor)
    return akActor.IsInFaction(DOMPlayerSlaverFaction)
EndFunction

;Registers an alcoholic drink within DOM so you can force a slave to drink it.
bool Function RegisterDrink(Form the_drink)
    if(the_drink == None)
        LogInfo("[RegisterDrink] ERROR: Form passed to RegisterDrink cannot be None!",2)
        return false
    endif
    DOM.AlcoholicDrinksExtendedList.AddForm(the_drink as Faction)
    return true
EndFunction

;returns the HEXACO values for an DOM Actor in the form of a float array
;The values in the array are in this order:
;Honesty, Emotionality, eXtraversion, Agreeableness, Conscientiousness, Openness
float[] Function GetHEXACO(Actor akActor)

   float[] alltraits = DOM.DOMGenerator.GetNPCTraits(akActor)

    float[] hexaco = new float[6]
    hexaco[0] = alltraits[0]
    hexaco[1] = alltraits[1]
    hexaco[2] = alltraits[2]
    hexaco[3] = alltraits[3]
    hexaco[4] = alltraits[4]
    hexaco[5] = alltraits[5]

    String name = akActor.GetDisplayName()

    LogTrace(name+"'s Honesty is "+             hexaco[0])
    LogTrace(name+"'s Emotionality is "+        hexaco[1])
    LogTrace(name+"'s eXtraversion is "+        hexaco[2])
    LogTrace(name+"'s Agreeableness is "+       hexaco[3])
    LogTrace(name+"'s Conscientiousness is "+   hexaco[4])
    LogTrace(name+"'s Openness is "+            hexaco[5])
    
    return hexaco
EndFunction

;returns the FACET values for an actor in the form of a float array
;The values in the array are in this order:
;Boldness, Wilfulness, Smartness, Sensuality, Toughness, Submissivity
float[] Function GetFACET(Actor akActor)

    float[] alltraits = DOM.DOMGenerator.GetNPCTraits(akActor)

    float[] facet = new float[6]
    facet[0] = alltraits[6]
    facet[1] = alltraits[7]
    facet[2] = alltraits[8]
    facet[3] = alltraits[9]
    facet[4] = alltraits[10]
    facet[5] = alltraits[11]

    String name = akActor.GetDisplayName()

    
    LogTrace(name+"'s Wilfulness is "+          facet[0])
    LogTrace(name+"'s Toughness is "+           facet[1])
    LogTrace(name+"'s Sensuality is "+          facet[2])
    LogTrace(name+"'s Submissivity is "+        facet[3])
    LogTrace(name+"'s Boldness is "+            facet[4])
    LogTrace(name+"'s Smartness is "+           facet[5])


    return facet
EndFunction

;returns HEXACO traits with FACET traits appended to the end
float[] Function GetAllTraits(Actor akActor)
    float[] traits = DOM.DOMGenerator.GetNPCTraits(akActor)

    String name = akActor.GetDisplayName()
    LogTrace(name+"'s Honesty is "+             traits[0])
    LogTrace(name+"'s Emotionality is "+        traits[1])
    LogTrace(name+"'s eXtraversion is "+        traits[2])
    LogTrace(name+"'s Agreeableness is "+       traits[3])
    LogTrace(name+"'s Conscientiousness is "+   traits[4])
    LogTrace(name+"'s Openness is "+            traits[5])

    LogTrace(name+"'s Wilfulness is "+          traits[6])
    LogTrace(name+"'s Toughness is "+           traits[7])
    LogTrace(name+"'s Sensuality is "+          traits[8])
    LogTrace(name+"'s Submissivity is "+        traits[9])
    LogTrace(name+"'s Boldness is "+            traits[10])
    LogTrace(name+"'s Smartness is "+           traits[11])

    return traits
EndFunction

;returns true if the Function succeeds, false otherwise
;takes in an array of 6 floats, matching the HEXACO traits in this order:
;Honesty, Emotionality, eXtraversion, Agreeableness, Conscientiousness, Openness
bool Function SetHEXACO(Actor akActor, float[] values)
    if(values.Length != 6)
        LogInfo("[SetHEXACO] ERROR: The array passed to SetHEXACO must be of length 6!",2)
        return false
    endif

    float[] alltraits = DOM.DOMGenerator.GetNPCTraits(akActor)

    int i = 0
	bool do_set = false
    while i < 6
        if(values[i] == alltraits[i])
            LogTrace("[SetHEXACO] Value for "+TraitNames[i]+" is already set to "+values[i]+".")
        else
			do_set = true
            alltraits[i] = values[i]
            LogTrace("[SetHEXACO] "+TraitNames[i]+" was set to "+alltraits[i]+".")
        endif
        i += 1
    endwhile
	if do_set
		DOM.DOMGenerator.SetNPCTraitsUpdateModifiers(akActor, alltraits)
	endif
    return true
EndFunction   

;returns true if the operation succeeds, false otherwise.
;takes in an array of 6 floats, matching the FACET traits in this order:
;Willfulness, Toughness, Sensuality, Submissivity, Boldness, Smartness
bool Function SetFACET(Actor akActor, float[] values)
    if(values.Length != 6)
        LogInfo("[SetFacet] ERROR: The array passed to SetFACET must be of length 6!", 2)
        return false
    endif

    float[] alltraits = DOM.DOMGenerator.GetNPCTraits(akActor)
    int i = 0
 	bool do_set = false
    while i < 6
        if(values[i] == alltraits[i+6])
            LogTrace("[SetFACET] Value for "+TraitNames[i+6]+" is already set to "+values[i]+".")
        else
			do_set = true
            alltraits[i+6] = values[i]
            LogTrace("[SetFACET] "+TraitNames[i+6]+" was set to "+alltraits[i+6]+".")
        endif
        i += 1
    endwhile
	if do_set
		DOM.DOMGenerator.SetNPCTraitsUpdateModifiers(akActor, alltraits)
	endif
    return true
EndFunction

;returns true if the Function succeeds, false otherwise
;takes in an array of 12 floats, matching the HEXACO and FACET values in this order: 
;Honesty, Emotionality, eXtraversion, Agreeableness, Conscientiousness, Openness, Willfulness, Toughness, Sensuality, Submissivity, Boldness, Smartness
bool Function SetAllTraits(Actor akActor, float[] values)
    if(values.Length < 12)
        LogInfo("[SetAllTraits] ERROR! The array passed to SetAllTraits must be of length 12!",2)
        return false
    endif
	; Wait for DOM to be ready
	if DOM.isOnDOMInit()
		LogInfo("[SetAllTraits] DOM has not finished initializing - Waiting")
		int ntry = 0
		while ntry < 300
			if DOM.isOnDOMInit() 
				ntry += 1
				if (ntry % 10) == 10
					LogInfo("[SetAllTraits] DOM has is still initializing - Waiting "+ntry+"/300 seconds")
				endif
				Wait(1.0)
			else
				LogInfo("[SetAllTraits] DOM has finished initializing - Continue")
				ntry = 1000
			endif
		endWhile
	endif
	
    float[] alltraits = DOM.DOMGenerator.GetNPCTraits(akActor)
    int i = 0
 	bool do_set = false
    while i < 12
        if(values[i] == alltraits[i])
            LogTrace("[SetAllTraits] Value for "+TraitNames[i]+" is already set to "+values[i]+".")
        else
			do_set = true
            alltraits[i] = values[i]
            LogTrace("[SetAllTraits] "+TraitNames[i]+" was set to "+alltraits[i]+".")
        endif
        i += 1
    endwhile
	if do_set
		DOM.DOMGenerator.SetNPCTraitsUpdateModifiers(akActor, alltraits)
	endif
    return true
EndFunction

;This just tries the normal orgasm Function in the slave's mind. That Function has a number of conditions for success, so this is not a consistent method of triggering orgasm. returns true if an orgasm happens.
bool Function TryOrgasm(Actor akActor, float base_chance)
    DOM_Actor slave = GetDOMActor(akActor)
    if(!slave)
        LogInfo("[TryOrgasm] ERROR: a non-DOM actor cannot orgasm using TryOrgasm! Sorry!",2)
        return false
    endif

    return slave.mind.IsOrgasmingAfterArousal(base_chance)
EndFunction

;This simulates what happens inside the IsOrgasmingAfterArousal Function if the orgasm succeeds.
;It completely bypasses the allowed_to_orgasm checks & etc. so the notification message will always be the same, aside from the gendered pronoun. 
bool Function ForceOrgasm(Actor akActor)
    DOM_Actor slave = GetDOMActor(akActor)
    DOM_Mind mind = slave.mind
    if(!mind)
        LogInfo("[ForceOrgasm] Could not find a mind to orgasm with!", 2)
        return false
    endif

    if(mind.promiseOath == "rapture")
        ;uncomment once promise_kept becomes an accessible Property
        ;mind.promise_kept = 1
    endif

    float amount = mind.MOD_Daring*10.0 
    slave.SexlabPlayOrgasm(true)

    string pronoun = "she"
    if(DOM.GetActorGender(akActor)%2==0)
        amount *= 0.20
        pronoun = "he"
    endif
    
    String name = akActor.GetDisplayName()
    SendNotification(name+"'s mind melts as "+pronoun+" is overwhelmed by orgasm",name)

    mind.number_of_orgasm += 1
    amount *= 5.0/(mind.number_of_orgasm+5.0)

    float[] FACET = GetFACET(akActor)
    FACET[5] = FACET[5] + amount * DOM_Util.RandG1() ;submissivity
    FACET[3] = FACET[3] + amount * DOM_Util.RandG1() ;sensuality

    float[] HEXACO = GetHEXACO(akActor)
    HEXACO[5] = HEXACO[5] + amount * DOM_Util.RandG1() ;openness

    if (!DOM.staticTraitsMode)
        SetFACET(akActor, FACET)
        SetHEXACO(akActor,HEXACO)
        mind.ResetModifiers()
    endif

    ;uncomment once had_orgasm becomes an accessible Property
    ;mind.had_orgasm = true

    return true

EndFunction

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;WHEEL MENU FunctionS
;These allow you to easily create and fill wheel menus like the ones DOM natively uses.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;creates an empty wheel menu with the given number of entries. A singular wheel menu can only
;contain a maximum of 8 entries. You will have to create your own custom handling to move between pages if you want to link multiple pages of wheels. 
;Note that you must create your own handling of the menu selection regardless
UIMenuBase Function CreateWheel(int numEntries = 8)
    if(numEntries > 8)
        LogInfo("[CreateWheel] WARNING: numEntries must be 8 or less! Only 8 entries will be placed on this wheel.", 1)
        numEntries = 8
    endif
    UIMenuBase wheelMenu = UIExtensions.GetMenu("UIWheelMenu")
    int i = 0
    while i < numEntries
        wheelMenu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = true)
        wheelMenu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = "none")
        wheelMenu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = "none")
        i += 1
    endWhile
    return wheelMenu
EndFunction

;configure an entry for a wheel including its label, text, and whether it is disabled or enabled.
;It then returns the modified wheel menu. 
UIMenuBase Function SetWheelEntry(UIMenuBase menu, int menuIndex, string label, string text, bool enabled = true)
    if(menuIndex > 7)
        LogInfo("[SetWheelEntry] ERROR: menuIndex must be 7 or less!", 2)
        return menu
    endif
    menu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = menuIndex, value = enabled)
    menu.SetPropertyIndexString(PropertyName = "optionText", index = menuIndex, value = text)
    menu.SetPropertyIndexString(PropertyName = "optionLabelText", index = menuIndex, value = label)
    return menu
EndFunction

;Does what it says on the tin. It's exactly the same as SetWheelEntry but for multiple entries at once. 
UIMenuBase Function BatchSetupWheelEntries(UIMenuBase menu, string[] labels, string[] texts, bool[] enabled)
    int labelLen = labels.Length
    int textsLen = texts.Length
    int enableLen = enabled.Length
    
    if (labelLen == textsLen)
        if(textsLen == enableLen)
            if(labelLen > 8)
                LogInfo("[BatchSetupWheelEntries] ERROR: all arrays passed to BatchSetupWheelEntries must be length 8 or shorter!", 2)
                return menu
            endif

            int i = 0
            while i < labelLen
                menu.SetPropertyIndexbool(PropertyName = "optionEnabled", index = i, value = enabled[i])
                menu.SetPropertyIndexString(PropertyName = "optionText", index = i, value = texts[i])
                menu.SetPropertyIndexString(PropertyName = "optionLabelText", index = i, value = labels[i])
                i += 1
            endwhile
        else
        LogInfo("[BatchSetupWheelEntries] ERROR: all arrays passed to BatchSetupWheelEntries must be same length!", 2)
        endif
    else
        LogInfo("[BatchSetupWheelEntries] ERROR: all arrays passed to BatchSetupWheelEntries must be same length!", 2)
    endif
    return menu
EndFunction

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;DOM MIND FunctionS
;These allow you to manipulate the state of a DOM actor's mind. You can change their mood, change their arousal, and change their current behaviour. 
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;Get the DOM_Mind for a given Actor, if one exists. Otherwise returns an error.
DOM_Mind Function GetDOM_MindFromActor(Actor akActor) 
    DOM_Actor DOMAkActor = GetDOMActor(akActor)
    if (DOMAkActor)
        return DOMAkActor.mind
    else
        LogInfo("[GetDOM_MindFromActor] ERROR: Could not get a DOM_Mind for " + akActor.GetDisplayName() + " because they are not a slave or slaver!", 2)
    endif
EndFunction

;NOT FunctionAL ATM
bool Function InjectArousal(Actor akActor, float value)
    ;TODO: Need to talk to TAK to understand how arousal works (as in, which value do I adjust? what Functions to trigger?)
EndFunction


;Directly set an actor's mood. You must set this to a valid mood already defined within DOM; the mood controls a state machine inside the slave's mind and the input MUST match the name of a state. 
;Acceptable mood values for the Function are listed below: 
;empty_minded
;charmed
;happy
;fine
;neutral
;angry
;defiant
;afraid
;terrified
;scared
;ashamed
;proud
;sad
;crushed
;just_captured
;shock
;broken
;loyal
;inlove
;depressed
;insecure
;jealous
Function SetDOMMood(Actor akActor, String mood = "empty_minded")
    int i = 0
    while i < validMoods.Length
        if mood == validMoods[i]
            DOM_Mind mind = GetDOM_MindFromActor(akActor)
            if (mind)
                mind.mood = mood
                return
            else
                LogInfo("[SetDOMMood] ERROR: Failed to set mood on " + akActor.GetDisplayName() + " because they are not a slave or slaver!", 2)    
            endif
        endif
        i += 1
    endWhile

    LogInfo("[SetDOMMood] ERROR: Failed to set mood on " + akActor.GetDisplayName() + "! You must pass in a valid mood value!", 2)
    return

EndFunction        


;returns an actor's DOM mood as a string, if they have a DOM_Mind. 
String Function GetDOMMood(Actor akActor)
    DOM_Mind mind = GetDOM_MindFromActor(akActor)
    if (mind)
        return mind.mood
    else
        LogInfo("[GetDOMMood] ERROR: Failed to get mood on " + akActor.GetDisplayName() + " because they are not a slave or slaver!", 2)    
        return None
    endif
EndFunction

;Send an on-screen message.
;section: typically, the name of the actor the message is related to. 
;msg: The text you want to appear
;type: the type of message as filtered in the DOM MCM.
;0 = Friends, 1 = Mood, 2 = Emotion, 3 = Secondary Abuse, 4 = Order Response, 5 = Important Abuse
;if you do not enter a section or type, it is sent as an ownerless generic message. 
Function SendNotification(String msg, String section = "", int type = 5, bool start_at_end=false)
    if(type == 0)
        DOM.SendNotificationFriends(section, msg, start_at_end)
    elseif type == 1
        DOM.SendNotificationAction(section, msg, start_at_end)
    elseif type == 2
        DOM.SendNotificationEmotion(section, msg, start_at_end)
    elseif type == 3
        DOM.SendNotificationAbuse(section, msg, start_at_end)
    elseif type == 4 
        DOM.SendNotificationOrder(section, msg, start_at_end)
    else ; if type >= 5 || type < 0
        DOM.SendNotification(section, msg, start_at_end)
    endif
EndFunction

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;TRAINING FunctionS
;These allow you to train a slave just like DOM does. Calculations will be performed on the baseAmount you input to get the final increase to their training stats. 
;this is the recommended way of training a slave if you want to do that as part of your add-on.
;There is no bulk "train all" Function for a reason: Understand what the stats you're touching do before you mess with them, and be deliberate!
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


;/ PSYCHOLOGICAL TRAINING FunctionS /;

;Train the actor's submission by the baseAmount, modified by the training Function
Function TrainSubmission(DOM_Actor akActor, float baseAmount)
   akActor.mind.TrainSubmission(baseAmount)
EndFunction

;Train the actor's fear by the baseAmount, modified by the training Function
Function TrainFear(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainFear(baseAmount)
EndFunction

;Train the actor's humiliation by the baseAmount, modified by the training Function
Function TrainHumiliation(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainHumiliation(baseAmount)
EndFunction

;Train the actor's anger by the baseAmount, modified by the training Function
Function TrainAnger(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainAnger(baseAmount)
EndFunction

;Train the actor's resignation by the baseAmount, modified by the training Function
Function TrainResignation(DOM_Actor akActor, float baseAmount)
   akActor.mind.TrainResignation(baseAmount)
EndFunction

;Train the actor's respect by the baseAmount, modified by the training Function
Function TrainRespect(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainRespect(baseAmount)
EndFunction

;/ SKILL TRAINING FunctionS /;

;Train the actor's posing abilities by the baseAmount, modified by the training Function
Function TrainPose(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainPose(baseAmount) 
EndFunction

;Train the actor's house training by the baseAmount, modified by the training Function
Function TrainHouse(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainHouse(baseAmount) 
EndFunction

;Train the actor's combat abilities by the baseAmount, modified by the training Function
Function TrainCombat(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainCombat(baseAmount) 
EndFunction

;Train the actor's vaginal sex skill by the baseAmount, modified by the training Function
Function TrainVaginal(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainVaginal(baseAmount) 
EndFunction

;Train the actor's oral sex skill by the baseAmount, modified by the training Function
Function TrainOral(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainOral(baseAmount) 
EndFunction

;Train the actor's anal sex skill by the baseAmount, modified by the training Function
Function TrainAnal(DOM_Actor akActor, float baseAmount)
    akActor.mind.TrainAnal(baseAmount) 
EndFunction

;/ TRAINER SKILL TRAINING FunctionS /;

; OBSOLETE
Function TrainMasterTraining(DOM_Actor akActor, float amount)
    akActor.mind.TrainSkillEnforcer(amount)
EndFunction

Function TrainTrainer(DOM_Actor akActor)
    akActor.mind.TrainTrainer()
EndFunction

Function TrainCrime(DOM_Actor akActor)
   akActor.mind.TrainHouseMistress()
EndFunction

; NEW FunctionS TO USE
Function TrainSlaveTrainer(DOM_Actor akActor)
    akActor.mind.TrainTrainer()
EndFunction

Function TrainSexTrainer(DOM_Actor akActor)
    akActor.mind.TrainSexTrainer()
EndFunction

Function TrainHouseMistress(DOM_Actor akActor)
   akActor.mind.TrainHouseMistress()
EndFunction


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;FORCE VALUE CHANGE FunctionS
;These allow you to directly change a DOM mind's training values without going through the training modifiers or calculations. 
;You probably shouldn't do this, but the option is here in case you need it. Please make sure you know what a stat does before you change it! 
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Function ForceSubmissionValue(DOM_Actor akActor, float value)
    akActor.mind.submission = value
    LogTrace("[ForceSubmissionValue] Set "+akActor.getName()+"'s submission to "+value,0)
EndFunction

Function ForceFearValue(DOM_Actor akActor, float value)
    akActor.mind.fear_training = value
    LogTrace("[ForceSubmissionValue] Set "+akActor.getName()+"'s fear training to "+value)
EndFunction

Function ForceHumiliationValue(DOM_Actor akActor, float value)
    akActor.mind.humiliation = value
    LogTrace("[ForceHumiliationValue] Set "+akActor.getName()+"'s humiliation to "+value)
EndFunction

Function ForceAngerValue(DOM_Actor akActor, float value)
    akActor.mind.anger_training = value
    LogTrace("[ForceAngerValue] Set "+akActor.getName()+"'s anger training to "+value)
EndFunction

Function ForceResignationValue(DOM_Actor akActor, float value)
    akActor.mind.resignation = value
    LogTrace("[ForceResignationValue] Set "+akActor.getName()+"'s resignation to "+value)
EndFunction

Function ForceRespectValue(DOM_Actor akActor, float value)
    akActor.mind.respect_training = value
    LogTrace("[ForceRespectValue] Set "+akActor.getName()+"'s respect training to "+value)
EndFunction

Function ForcePoseTrainingValue(DOM_Actor akActor, float value)
    akActor.mind.pose_training = value
    LogTrace("[ForcePoseTrainingValue] Set "+akActor.getName()+"'s pose training to "+value)
EndFunction

Function ForceHouseTrainingValue(DOM_Actor akActor, float value)
    akActor.mind.house_training = value
    LogTrace("[ForceHouseTrainingValue] Set "+akActor.getName()+"'s house training to "+value,0)
EndFunction

Function ForceCombatTrainingValue(DOM_Actor akActor, float value)
    akActor.mind.combat_training = value
    LogTrace("[ForceCombatTrainingValue] Set "+akActor.getName()+"'s combat training to "+value,0)
EndFunction

Function ForceVaginalTrainingValue(DOM_Actor akActor, float value)
    akActor.mind.vaginal_training = value
    LogTrace("[ForceVaginalTrainingValue] Set "+akActor.getName()+"'s vaginal training to "+value,0)
EndFunction

Function ForceOraltrainingValue(DOM_Actor akActor, float value)
    akActor.mind.oral_training = value
    LogTrace("[ForceOralTrainingValue] Set "+akActor.getName()+"'s oral training to "+value,0)
EndFunction

Function ForceAnalTrainingValue(DOM_Actor akActor, float value)
    akActor.mind.anal_training = value
    LogTrace("[ForceAnalTrainingValue] Set "+akActor.getName()+"'s anal training to "+value,0)
EndFunction

Function ForceMasterTrainingValue(DOM_Actor akActor, float value)
    akActor.mind.skill_enforcer = value
    LogTrace("[ForceMasterTrainingValue] Set "+akActor.getName()+"'s master training (enforcer skill) to "+value,0)
EndFunction

Function ForceCrimeTrainingValue(DOM_Actor akActor, float value)
    akActor.mind.skill_deceiver = value
    LogTrace("[ForceCrimeTrainingValue] Set "+akActor.getName()+"'s crime training (deceiver skill) to "+value,0)
EndFunction

Function ForceEnforcerSkillValue(DOM_Actor akActor, float value)
    akActor.mind.skill_enforcer = value
    LogTrace("[ForceEnforcerSkillValue] Set "+akActor.getName()+"'s enforcer skill to "+value,0)
EndFunction

Function ForcePredatorSkillValue(DOM_Actor akActor, float value)
    akActor.mind.skill_predator = value
    LogTrace("[ForcePredatorSkillValue] Set "+akActor.getName()+"'s predator skill to "+value,0)
EndFunction

Function ForceDepraverSkillValue(DOM_Actor akActor, float value)
    akActor.mind.skill_depraver = value
    LogTrace("[ForceDepraverSkillValue] Set "+akActor.getName()+"'s depraver skill to "+value,0)
EndFunction

Function ForcePersuaderSkillValue(DOM_Actor akActor, float value)
    akActor.mind.skill_persuader = value
    LogTrace("[ForcePersuaderSkillValue] Set "+akActor.getName()+"'s persuader skill to "+value,0)
EndFunction

Function ForceSlaverSkillValue(DOM_Actor akActor, float value)
    akActor.mind.skill_slaver = value
    LogTrace("[ForceSlaverSkillValue] Set "+akActor.getName()+"'s slaver skill to "+value,0)
EndFunction

Function ForceDeceiverSkillValue(DOM_Actor akActor, float value)
    akActor.mind.skill_deceiver = value
    LogTrace("[ForceDeceiverSkillValue] Set "+akActor.getName()+"'s deceiver skill to "+value,0)
EndFunction

;Local logging Function for DOM_API.
;Outputs the string to the log
;Severity is one of the following:
;0 - Info
;1 - Warning
;2 - Error 
Function LogTrace(string msg, int severity = 0)
	if DOM.verboseMode
		Debug.Trace("DOM_API: "+msg, severity)
	endif
EndFunction

Function LogInfo(string msg, int severity = 0)
	Debug.Trace("DOM_API: "+msg, severity)
EndFunction




