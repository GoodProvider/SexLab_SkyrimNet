;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PAHOKidnappingPardoTrust Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PardosTrust()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function PardosTrust()
	QF_PAHOKidnapping_060228C3 qst = GetOwningQuest() as QF_PAHOKidnapping_060228C3
	if qst.CheckPlayerKeepsMelina()
		qst.SetStage(125)
	else
		qst.SetStage(130)
	endif
EndFunction
