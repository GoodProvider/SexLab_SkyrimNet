Scriptname PAHOKidnapInventoryCheck Extends ReferenceAlias

Event OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if qst.IsObjectiveDisplayed(71)
		if (qst.CheckRequirements())
			qst.SetObjectiveCompleted(71)
		endif
	endif
EndEvent


QF_PAHOKidnapping_060228C3 Property qst Auto