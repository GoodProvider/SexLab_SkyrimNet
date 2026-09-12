Scriptname DOM_DiaryReadableBook extends ObjectReference  

DOM_Core Property DOM01 Auto
ObjectReference Property DOMJeremyMarker Auto
DOM_DiaryBook Property Diary = None Auto Hidden

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	LogTrace("OnContainerChanged old="+akOldContainer+" new="+akNewContainer)
	Actor PlayerRef = DOM01.PlayerRef
	if akNewContainer != PlayerRef ; Only care if moved to player's inventory
		return
	endif
	LogTrace("OnContainerChanged moving readable diary back to empty space")
	Moveto(DOMJeremyMarker) ; Put book some where that is nowhere
	if Diary == None  ; Check if any Diary cover book is associated
		return
	endif
	; Move Diary cover book to inventory
	if akOldContainer != None
		if akOldContainer != PlayerRef
			if akOldContainer.getItemCount(Diary) > 0
				LogTrace("OnContainerChanged moving cover diary back to empty space diary="+Diary.GetDisplayName())
				Diary.Moveto(DOMJeremyMarker) 
			endif
		endif
	endif
	int n = PlayerRef.getItemCount(Diary)
	if n == 0
		PlayerRef.AddItem(Diary)
	endif
EndEVENT

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
	RegisterForModEvent(eventName, callbackName)
	LogTrace("RegisterForUpdateDiaryEvent Register event "+eventName+" callback="+callbackName)
	if Diary != None
		LogTrace("RegisterForUpdateDiaryEvent Register diary="+Diary.GetDisplayName())
	endif
EndFunction

Function UnRegisterForUpdateDiaryEvent()
	string formid = DOM_Util.ConvertIDToHex(GetFormID())
	string eventName = "DOMOnUpdateDiary"+formid
	string callbackName = "OnUpdateDiary"
	UnregisterForModEvent(eventName) 
	LogTrace("UnRegisterForUpdateDiaryEvent Register event "+eventName+" callback="+callbackName)
EndFunction

Event OnUpdateDiary()
	if Diary == None
		LogTrace("OnUpdateDiary Diary=NONE")
		return
	endif
	LogTrace("OnUpdateDiary Diary="+Diary.GetDisplayName()+" ref="+Diary)
	UnRegisterForUpdateDiaryEvent()
	Diary.OnUpdateDiary()
EndEVENT

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_DiaryReadableBook : "+GetDisplayName()+" "+msg)
	endif
EndFunction
