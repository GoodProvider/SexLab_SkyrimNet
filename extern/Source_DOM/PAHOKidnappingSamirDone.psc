;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PAHOKidnappingSamirDone Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SealTheDeal()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function SealTheDeal()
	QF_PAHOKidnapping_060228C3 qst = GetOwningQuest() as QF_PAHOKidnapping_060228C3
	Game.Getplayer().AddItem(qst.LetterPardo, 1)
	qst.SetStage(110)
	qst.TransferMelina()
EndFunction
