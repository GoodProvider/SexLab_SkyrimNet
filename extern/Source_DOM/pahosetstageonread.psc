Scriptname PAHOSetStageOnRead extends ObjectReference  


int Property preReqStage  = -1 Auto
int Property preReqStage2 = -1 Auto
{OPTIONAL: If set, this stage must have been done to set the StageToSet}
int Property StageToSet Auto
{The stage to set the quest to when I've been read}
Quest Property qst Auto

;==============================================
auto STATE ready
	Event OnActivate(ObjectReference akActionRef)
		stageHandling()
	EndEvent

	Event OnEquipped(Actor akActor)
		stageHandling()
	endEvent
	
	Event OnRead()
		stageHandling()
	EndEvent
endSTATE

STATE Done
endSTATE

;==============================================

FUNCTION stageHandling()
	If qst.GetStage() == preReqStage || qst.GetStage() == preReqStage2 || preReqStage == -1
		; utility.wait(0.1)
		qst.SetStage(StageToSet)	
		gotoState("Done")
	Endif	
endFUNCTION

