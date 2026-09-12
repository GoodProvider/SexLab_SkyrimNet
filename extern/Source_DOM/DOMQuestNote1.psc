Scriptname DOMQuestNote1 extends ObjectReference  

Quest Property DOM03Quest Auto

Event OnRead()
	if DOM03Quest .GetStage() < 20
		DOM03Quest .SetStage(20)
	endif
EndEvent