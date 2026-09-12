ScriptName DOM_MessageWidget Extends SKI_WidgetBase

String _messageText = ""
String _next1MessageText = ""
String _next2MessageText = ""
String _next3MessageText = ""
String _next4MessageText = ""
String _font = "$EverywhereMediumFont"
String _align = "left"
Int _textSize = 16
bool _visible = False
Int _textColor = 0xFFFFFF
Int _widgetWidth = 300

Function DisplayMessage(String mess)
    MessageText = mess
EndFunction

Function ClearMessage()
   _messageText = ""
   _next1MessageText = ""
   _next2MessageText = ""
   _next3MessageText = ""
   _next4MessageText = ""
   _isReadyForUpdate = True
EndFunction

bool Property IsLargeWidget = False AutoReadOnly

String Property DebugText
    String Function get()
        return "Widget " + WidgetIndex + ", IsEnabled : " + IsEnabled + ", Section: " + WidgetSection+ ", Section2: " + WidgetSection2 + ", SecondsToDisplay: " + SecondsToDisplay
    EndFunction
EndProperty

Function DisplayPlayerMessage(String mess)
    MessageText = mess
EndFunction

Function Test(String text = "")
    Debug.Trace("Running Test " + text)
    DisplayMessage(WidgetName + text)
EndFunction

Float Property SecondsToDisplay = 7.0 Auto

bool Property IsEnabled         = False Auto

bool _isReadyForUpdate = True
bool Property IsReadyForUpdate
    bool Function get()
        return _isReadyForUpdate
    EndFunction
EndProperty

Float Property FadeOutDuration = 1.0 Auto
Float Property FadeInDuration = 0.1 Auto
Int Property WidgetIndex = -1 Auto
String Property WidgetSection Auto
String Property WidgetSection2 Auto Hidden

bool message_stacked = false
bool message_stays   = false

Event OnUpdate()	
	Update()
EndEvent

Function Update()
    If _next1MessageText != ""
		string tmp
		if _next2MessageText == ""
			; only one message saved
			if message_stacked
				; stop stacking
				tmp = _next1MessageText
				_next1MessageText = ""
				message_stacked = false
				message_stays   = true ; true so that it stays one more tick
			else ; 1 more stack
				if MessageText != _next1MessageText
					tmp = MessageText +"\n"+_next1MessageText
				endif
				message_stacked = true
			endif
		elseif _next3MessageText == ""
			; two messages saved
			tmp = _next1MessageText +"\n"+_next2MessageText
			_next1MessageText = _next2MessageText
			_next2MessageText = ""
			message_stacked = true
		else ; fast forward, messages are piling up
			if _next2MessageText != _next1MessageText
				tmp = _next1MessageText +"\n"+_next2MessageText
			endif
			_next1MessageText = _next3MessageText
			_next2MessageText = _next4MessageText
			_next3MessageText = ""
			_next4MessageText = ""
			message_stacked = true
		endif
		;_messageText = ""
		_isReadyForUpdate = True
        MessageText = tmp
    Elseif message_stays
		_isReadyForUpdate = True
		; wait one more tick
		message_stays = false
		message_stacked = false
		UnregisterForUpdate()
        RegisterForSingleUpdate(SecondsToDisplay)
	else
		_isReadyForUpdate = True
        UpdateWidgetText("")
        Visible = False
    endif
EndFunction

String Property MessageText
    String Function get()
        return _messageText
    EndFunction

    Function set(String a_val)
        If !_isReadyForUpdate
			if _next1MessageText == ""
				_next1MessageText = a_val
			elseif _next2MessageText == ""
				_next2MessageText = a_val
			elseif _next3MessageText == ""
				_next3MessageText = a_val
			elseif _next3MessageText == ""
				_next4MessageText = a_val
			else
				_next4MessageText = _next4MessageText+"\n"+a_val
			endif
			Update()
            return
        endif

        _isReadyForUpdate = False
        _messageText = a_val
		;Debug.Trace("Widget section = "+WidgetSection+" / "+WidgetSection2+" message ="+_messageText)

        Visible = True
        UpdateWidgetText(_messageText)

        UnregisterForUpdate()
        RegisterForSingleUpdate(SecondsToDisplay)
    EndFunction
EndProperty

Int Property TextColor
    Int Function Get()
        return _textColor
    EndFunction

    Function Set(Int newValue)
        _textColor = newValue
        UpdateWidgetTextColor(_textColor)
    EndFunction
EndProperty

bool Property Visible
    bool Function get()
        return _visible
    EndFunction

    Function set(bool a_val)
        _visible = a_val
        UpdateWidgetVisible(_visible)
    EndFunction
EndProperty

String Property Font
    String Function get()
        return _font
    EndFunction

    Function set(String a_val)
        _font = a_val
        UpdateWidgetFont(_font)
    EndFunction
EndProperty

String Property Align
    String Function get()
        return _align
    EndFunction

    Function set(String a_val)
        _align = a_val
        UpdateWidgetTextAlignment(_align)
    EndFunction
EndProperty

Int Property TextSize
    Int Function get()
        return _textSize
    EndFunction
    
    Function set(Int a_val)
        _textSize = a_val
        UpdateWidgetTextSize(_textSize)
    EndFunction
EndProperty

Int Property WidgetWidth
    Int Function get()
        return _widgetWidth
    EndFunction
    Function set(Int a_val)
        _widgetWidth = a_val
        UpdateWidgetWidth(_widgetWidth)
    EndFunction
EndProperty

Event OnWidgetReset()
    ;Log("OnWidgetReset")
    Parent.OnWidgetReset()
    UpdateWidgetFont(_font)
    UpdateWidgetTextSize(_textSize)
    UpdateWidgetTextColor(_textColor)
    UpdateWidgetTextAlignment(_align)
    UpdateWidgetText(_messageText)
EndEvent

Event OnWidgetInit()
    string[] hudModes = new string[14]
    hudModes[0] = "All"
    hudModes[1] = "StealthMode"
    hudModes[2] = "Favor"
    hudModes[3] = "Swimming"
    hudModes[4] = "HorseMode"
    hudModes[5] = "WarHorseMode"
    hudModes[6] = "MovementDisabled"
    hudModes[7] = "InventoryMode"
    hudModes[8] = "BookMode"
    hudModes[9] = "DialogueMode"
    hudModes[10] = "BarterMode"
    hudModes[11] = "TweenMode"
    hudModes[12] = "WorldMapMode"
    hudModes[13] = "CartMode"
    ;hudModes[14] = "SleepWaitMode"
    ;hudModes[15] = "JournalMode"
    ;hudModes[16] = "VATSPlayback"

    Modes = hudModes
EndEvent

Event OnWidgetLoad()
    ;Log("OnWidgetLoad")
    ; Don't call the parent event since it will display the widget regardless of the Visible Property.
    ;Parent.OnWidgetLoad()

    OnWidgetReset()

    UpdateWidgetModes()

    ; Determine if the widget should be displayed
    UpdateWidgetVisible(_visible)
EndEvent

; @overrides SKI_WidgetBase
Float[] Function GetDimensions()
    {return the dimensions of the widget (width,height).}
    Float[] dim = New Float[2]
    dim[0] = UI.GetFloat(HUD_MENU, WidgetRoot + "._width")
    dim[1] = UI.GetFloat(HUD_MENU, WidgetRoot + "._height")
    return dim
EndFunction

; @overrides SKI_WidgetBase
String Function GetWidgetSource()
    return "DOM/MessageWidget.swf"
EndFunction

; @overrides SKI_WidgetBase
String Function GetWidgetType()
    ; Must be the same as scriptname
    return "DOM_MessageWidget"
EndFunction

Function MoveTo(Int newX, Int newY)
    UpdateWidgetVisible(False)
    If (newX As Float != X)
        X = newX As Float
    endif
    If (newY As Float != Y)
        Y = newY As Float
    endif
    UpdateWidgetVisible(_visible)
EndFunction

Function UpdateWidgetText(String a_val)
    If !Ready
        Log("Not ready")
        return
    endif    
    UI.InvokeString(HUD_MENU, WidgetRoot + ".setMessageText", a_val)
EndFunction

Function UpdateWidgetFont(String a_val)
    If !Ready
        Log("Not ready")
        return
    endif    
    UI.InvokeString(HUD_MENU, WidgetRoot + ".setFont", a_val)
EndFunction

Function UpdateWidgetTextSize(Int a_val)
    If !Ready
        Log("Not ready")
        return
    endif    
    UI.InvokeNumber(HUD_MENU, WidgetRoot + ".setTextSize", a_val)
EndFunction

Function UpdateWidgetTextColor(Int a_val)
    If !Ready
        Log("Not ready")
        return
    endif    
    UI.InvokeNumber(HUD_MENU, WidgetRoot + ".setTextColor", a_val)
EndFunction

Function UpdateWidgetTextAlignment(String a_val)
    If !Ready
        Log("Not ready")
        return
    endif
    UI.InvokeString(HUD_MENU, WidgetRoot + ".setAlign", a_val)
EndFunction

Function UpdateWidgetVisible(bool a_val)
    If !Ready
        Log("Not ready")
        return
    endif    
    UI.Invokebool(HUD_MENU, WidgetRoot + ".setVisible", a_val)
EndFunction

Function UpdateWidgetWidth(Int a_val)
    If !Ready
        Log("Not ready")
        return
    endif    
    UI.InvokeNumber(HUD_MENU, WidgetRoot + ".setWidgetWidth", a_val)    
EndFunction

Function Log(String mess)
    Debug.Trace("DOM_MessageWidget "+WidgetName +": " + mess)
EndFunction
