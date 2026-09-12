Scriptname DOMQuestNote2 extends ObjectReference  

Quest Property DOM03Quest Auto

Event OnRead()
	if DOM03Quest .GetStage() < 30
		DOM03Quest .SetStage(30)
	endif
EndEvent
