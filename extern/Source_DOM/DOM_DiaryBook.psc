Scriptname DOM_DiaryBook extends ObjectReference  

DOM_Core Property DOM01 Auto
DOM_Diary Property DOM04 Auto
bool Property is_player_diary = false Auto ; If true this is the Dragonborn's diary
DOM_Actor Property actor_alias = None Auto ; If None this is the Dragonborn's diary

bool should_be_updated = true
bool is_being_updated = false

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Debug.Trace("DOM_DiaryBook: OnContainerChanged old="+akOldContainer+" new="+akNewContainer+" self="+self)
EndEVENT

Event OnRead()
	; Register for update diary
	DOM_DiaryReadableBook the_diary
	if is_player_diary
		the_diary = DOM04.DiaryReadPlayer
	else
		bool is_slave
		if actor_alias != None && actor_alias.mind != None
			is_slave = actor_alias.mind.is_slave
		else
			is_slave = true
		endif
		if is_slave
			the_diary = DOM04.DiaryReadSlave
		else
			the_diary = DOM04.DiaryReadSlaver
		endif
	endif
	if should_be_updated
		LogTrace("OnRead needs updating should_be_updated="+should_be_updated+" is_being_updated="+is_being_updated)
		should_be_updated = false
		LogTrace("OnRead REGISTER for event diary="+the_diary.GetDisplayName()+" "+the_diary)
		if the_diary != None ; In inventory book won't receive event !
			the_diary.RegisterForUpdateDiaryEvent()
			the_diary.Diary = self
			Utility.WaitMenuMode(0.1)
			the_diary.SendUpdateDiaryEvent()
		else ; if no readable diary use this object reference
			RegisterForUpdateDiaryEvent()
			Utility.WaitMenuMode(0.1)
			SendUpdateDiaryEvent()
		endif
	else
		LogTrace("OnRead is updating should_be_updated="+should_be_updated+" is_being_updated="+is_being_updated)
		LogTrace("OnRead UNREGISTER for event diary="+the_diary.GetDisplayName()+" "+the_diary)
		if the_diary != None
			the_diary.UnRegisterForUpdateDiaryEvent()
			the_diary.Diary = None
		else ; if no readable diary use this object reference
			UnRegisterForUpdateDiaryEvent()
		endif
		should_be_updated = true
	endif
EndEVENT

Function OpenRead()
	; Register for update diary
	LogTrace("OpenRead "+GetDisplayName())
	DOM_DiaryReadableBook the_diary
	if is_player_diary
		the_diary = DOM04.DiaryReadPlayer
	else
		bool is_slave
		if actor_alias != None && actor_alias.mind != None
			is_slave = actor_alias.mind.is_slave
		else
			is_slave = true
		endif
		if is_slave
			the_diary = DOM04.DiaryReadSlave
		else
			the_diary = DOM04.DiaryReadSlaver
		endif
	endif
	DOM04.OpenDiary(actor_alias,is_player_diary)
EndFunction

Function SetAsMyDiary(DOM_Actor akActor, ObjectReference cont)
	SetActorOwner(None)
	if is_player_diary ; Player's ledger
		actor_alias = None
		LogTrace("SetAsMyDiary name="+GetDisplayName()+" Set as player's diary container="+cont)
	elseif actor_alias != None || akActor != None ; Not a ledger, but a journal
		if actor_alias == None
			LogTrace("SetAsMyDiary WARNING! No actor set actor_alias="+actor_alias+" replacing with"+akActor)
			actor_alias = akActor
		elseif actor_alias != akActor
			LogTrace("SetAsMyDiary WARNING! Different actor set actor_alias="+actor_alias+" replacing with"+akActor)
			actor_alias = akActor
		endif
		string diary_name = "Diary of "+actor_alias.GetName()
		LogTrace("SetAsMyDiary Set diary /"+GetDisplayName()+"/ as: "+diary_name+" in container="+cont)
		SetDisplayName(diary_name,true)
		SetName(diary_name)
		GetBaseObject().SetName(diary_name)
	else
		LogTrace("SetAsMyDiary ERROR: Slave diary has no owner actor="+akActor+" in container="+cont)	
		Moveto(DOM04.DOMJeremyMarker) ; Put book somewhere that is nowhere
		SetDisplayName("A Diary",true)
	endif
	if cont != None
		cont.AddItem(self)
	endif
	return
EndFunction

Function UpdateText()
	LogTrace("UpdateText name="+GetDisplayName()+" should_be_updated="+should_be_updated+" updating="+is_being_updated)
	LogTrace("UpdateText id="+self)
	LogTrace("UpdateText actor="+actor_alias)
	if is_being_updated
		return
	endif
	is_being_updated = true
	if is_player_diary
		DOM04.UpdatePlayerText()
	else
		if actor_alias == None
			LogTrace("UpdateText ERROR None actor found for "+GetDisplayName())
			return
		endif
		DOM04.UpdateSlaveText(actor_alias)
	endif
	is_being_updated = false
EndFunction

Function SendUpdateDiaryEvent()
	string formid = DOM_Util.ConvertIDToHex(GetFormID())
	string eventName = "DOMOnUpdateDiary"+formid
	int handle = ModEvent.Create(eventName)
    if (handle)
		LogTrace("SendUpdateDiaryEvent Registering event SUCCESS "+eventName)
        ModEvent.Send(handle)
	else
		LogTrace("SendUpdateDiaryEvent Registering event FAILED "+eventName)
    endif
EndFunction

Function RegisterForUpdateDiaryEvent()
	string formid = DOM_Util.ConvertIDToHex(GetFormID())
	string eventName = "DOMOnUpdateDiary"+formid
	string callbackName = "OnUpdateDiary"
	LogTrace("RegisterForUpdateDiaryEvent Register event "+eventName+" callback="+callbackName)
	RegisterForModEvent(eventName, callbackName)
EndFunction

Function UnRegisterForUpdateDiaryEvent()
	string formid = DOM_Util.ConvertIDToHex(GetFormID())
	string eventName = "DOMOnUpdateDiary"+formid
	string callbackName = "OnUpdateDiary"
	UnregisterForModEvent(eventName) 
	LogTrace("UnRegisterForUpdateDiaryEvent Register event "+eventName+" callback="+callbackName)
EndFunction

Event OnUpdateDiary()
	LogTrace("OnUpdateDiary should_be_updated="+should_be_updated+" is_being_updated="+is_being_updated)
	HudNotification("PRESS ESC! Then wait a few seconds for "+GetDisplayName()+" to be updated")
	UpdateText()
	HudNotification("Diary's update done")
	LogTrace("OnUpdateDiary Closing should_be_updated="+should_be_updated)
	Input.TapKey(1) ; Type ESC
	LogTrace("OnUpdateDiary Waiting diary="+self)
	Utility.WaitMenuMode(1.0) ; Wait counting menu time
	DOM_DiaryReadableBook the_diary
	if is_player_diary
		the_diary = DOM04.DiaryReadPlayer
	else
		bool is_slave
		if actor_alias != None && actor_alias.mind != None
			is_slave = actor_alias.mind.is_slave
		else
			is_slave = true
		endif
		if is_slave
			the_diary = DOM04.DiaryReadSlave
		else
			the_diary = DOM04.DiaryReadSlaver
		endif
		string diary_name = "Diary of "+actor_alias.GetName()
		if GetDisplayName() != diary_name ; Check name in case player bookshelves ruined it or actor changed name
			SetDisplayName(diary_name) 
		endif
	endif
	LogTrace("OnUpdateDiary Activating readable diary="+the_diary)
	bool status 
	if the_diary != None
		LogTrace("OnUpdateDiary Activate readable diary="+the_diary.GetDisplayName()+" "+the_diary)
		status = the_diary.Activate(Game.GetPlayer())
		should_be_updated = true
	else
		LogTrace("OnUpdateDiary Activate diary")
		status = self.Activate(Game.GetPlayer())
	endif
	LogTrace("OnUpdateDiary Activation status="+status+" should_be_updated="+should_be_updated+" is_being_updated="+is_being_updated)
EndEVENT

Function LogTrace(string msg)
	if DOM01.verboseMode && self != None ; Yes this has happenned...
		if is_player_diary
			Debug.Trace("DOM_DiaryBook: "+GetName()+" "+msg)
		else
			Debug.Trace("DOM_DiaryBook: "+GetDisplayName()+" "+msg)
		endif
	endif
EndFunction

Function HudNotification(string msg)
	Debug.Notification(msg)
	LogTrace(msg)
EndFunction
